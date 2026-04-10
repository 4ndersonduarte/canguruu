import { NextResponse } from "next/server";
import { createClient } from "@supabase/supabase-js";

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
const supabaseServiceRoleKey = process.env.SUPABASE_SERVICE_ROLE_KEY;

function base64UrlToString(input: string) {
  const pad = (s: string) => s + "===".slice((s.length + 3) % 4);
  const b64 = pad(input.replace(/-/g, "+").replace(/_/g, "/"));
  return Buffer.from(b64, "base64").toString("utf8");
}

function jwtRole(key: string | undefined) {
  if (!key) return null;
  const parts = key.split(".");
  if (parts.length < 2) return null;
  try {
    const payload = JSON.parse(base64UrlToString(parts[1]));
    return typeof payload?.role === "string" ? payload.role : null;
  } catch {
    return null;
  }
}

type WorkRowRaw = {
  id: string;
  title: string;
  description: string | null;
  client_id: string;
  category_id: string;
  cover_asset_id: string | null;
  sort_order: number;
  created_at: string;
  clients:
    | { name: string; slug: string; logo_url: string | null }
    | { name: string; slug: string; logo_url: string | null }[]
    | null;
  categories:
    | { name: string; slug: string }
    | { name: string; slug: string }[]
    | null;
};

type WorkRow = {
  id: string;
  title: string;
  description: string | null;
  client_id: string;
  category_id: string;
  cover_asset_id: string | null;
  sort_order: number;
  created_at: string;
  clients: { name: string; slug: string; logo_url: string | null } | null;
  categories: { name: string; slug: string } | null;
};

type AssetRow = {
  id: string;
  work_id: string;
  url: string;
  alt: string | null;
  sort_order: number;
  created_at: string;
};

function isHttpUrl(url: string) {
  return /^https?:\/\//i.test(url);
}

function isPublicPath(url: string) {
  return url.startsWith("/");
}

function normalizeStoragePath(path: string) {
  return path.startsWith("/") ? path.slice(1) : path;
}

function firstOrNull<T>(v: T | T[] | null): T | null {
  if (!v) return null;
  return Array.isArray(v) ? v[0] ?? null : v;
}

export async function GET(req: Request) {
  const debug = (() => {
    try {
      return new URL(req.url).searchParams.get("debug") === "1";
    } catch {
      return false;
    }
  })();

  if (!supabaseUrl) {
    return NextResponse.json(
      { error: "Missing NEXT_PUBLIC_SUPABASE_URL" },
      { status: 500 }
    );
  }

  if (!supabaseServiceRoleKey) {
    return NextResponse.json(
      { error: "Missing SUPABASE_SERVICE_ROLE_KEY" },
      { status: 500 }
    );
  }

  const supabase = createClient(supabaseUrl, supabaseServiceRoleKey, {
    auth: { persistSession: false, autoRefreshToken: false },
  });

  const { data: works, error: wErr } = await supabase
    .from("works")
    .select(
      "id,title,description,client_id,category_id,cover_asset_id,sort_order,created_at,clients(name,slug,logo_url),categories(name,slug)"
    )
    .order("sort_order", { ascending: true })
    .order("created_at", { ascending: false });

  if (wErr) {
    return NextResponse.json({ error: wErr.message }, { status: 400 });
  }

  const { data: assets, error: aErr } = await supabase
    .from("assets")
    .select("id,work_id,url,alt,sort_order,created_at")
    .order("work_id")
    .order("sort_order")
    .order("created_at");

  if (aErr) {
    return NextResponse.json({ error: aErr.message }, { status: 400 });
  }

  const assetsByWork = new Map<string, AssetRow[]>();
  for (const a of (assets ?? []) as AssetRow[]) {
    const list = assetsByWork.get(a.work_id) ?? [];
    list.push(a);
    assetsByWork.set(a.work_id, list);
  }

  const storagePaths = new Set<string>();
  for (const a of (assets ?? []) as AssetRow[]) {
    if (!isHttpUrl(a.url)) {
      storagePaths.add(normalizeStoragePath(a.url));
    }
  }

  const clientLogoPaths = new Set<string>();
  for (const w of (works ?? []) as unknown as WorkRowRaw[]) {
    const c = firstOrNull(w.clients);
    const logo = c?.logo_url;
    if (logo && !isHttpUrl(logo) && !isPublicPath(logo)) {
      clientLogoPaths.add(normalizeStoragePath(logo));
    }
  }

  const signedUrlMap = new Map<string, string>();
  await Promise.all(
    Array.from(storagePaths).map(async (p) => {
      const { data } = await supabase.storage
        .from("works")
        .createSignedUrl(p, 60 * 60);
      if (data?.signedUrl) signedUrlMap.set(p, data.signedUrl);
    })
  );

  const clientLogoSignedUrlMap = new Map<string, string>();
  await Promise.all(
    Array.from(clientLogoPaths).map(async (p) => {
      const { data } = await supabase.storage.from("clients").createSignedUrl(p, 60 * 60);
      if (data?.signedUrl) clientLogoSignedUrlMap.set(p, data.signedUrl);
    })
  );

  const normalizedWorks: WorkRow[] = ((works ?? []) as unknown as WorkRowRaw[]).map(
    (w) => {
      const client = firstOrNull(w.clients);
      const category = firstOrNull(w.categories);

      const logo = client?.logo_url;
      const logoSigned =
        logo && !isHttpUrl(logo) && !isPublicPath(logo)
          ? clientLogoSignedUrlMap.get(normalizeStoragePath(logo)) ?? null
          : logo ?? null;

      return {
        ...w,
        clients: client ? { ...client, logo_url: logoSigned } : null,
        categories: category,
      };
    }
  );

  const result = normalizedWorks.map((w) => {
    const list = assetsByWork.get(w.id) ?? [];
    const assetsView = list.map((a) => {
      if (isHttpUrl(a.url)) {
        return { ...a, preview_url: a.url };
      }
      const key = normalizeStoragePath(a.url);
      return { ...a, preview_url: signedUrlMap.get(key) ?? null };
    });

    return {
      ...w,
      assets: assetsView,
    };
  });

  return NextResponse.json(
    {
      works: result,
      ...(debug
        ? {
            meta: {
              supabase_url: supabaseUrl,
              service_key_role: jwtRole(supabaseServiceRoleKey),
              now: new Date().toISOString(),
              works_count: result.length,
            },
          }
        : {}),
    },
    {
      headers: {
        "Cache-Control": "no-store, max-age=0",
      },
    }
  );
}
