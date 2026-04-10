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

type ClientRowRaw = {
  id: string;
  name: string;
  slug: string;
  logo_url: string | null;
  story_icon_url: string | null;
  created_at: string;
};

type StoryRow = {
  id: string;
  client_id: string;
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

async function signIfNeeded(
  supabase: ReturnType<typeof createClient>,
  bucket: string,
  maybeUrl: string | null,
  expiresInSeconds: number
) {
  if (!maybeUrl) return null;
  if (isHttpUrl(maybeUrl) || isPublicPath(maybeUrl)) return maybeUrl;

  const path = normalizeStoragePath(maybeUrl);
  const { data, error } = await supabase.storage.from(bucket).createSignedUrl(path, expiresInSeconds);
  if (error) return null;
  return data?.signedUrl ?? null;
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
    return NextResponse.json({ error: "Missing SUPABASE_SERVICE_ROLE_KEY" }, { status: 500 });
  }

  const supabase = createClient(supabaseUrl, supabaseServiceRoleKey, {
    auth: { persistSession: false, autoRefreshToken: false },
  });

  const { data: clients, error: cErr } = await supabase
    .from("clients")
    .select("id,name,slug,logo_url,story_icon_url,created_at")
    .order("name");

  if (cErr) {
    return NextResponse.json({ error: cErr.message }, { status: 400 });
  }

  const { data: stories, error: sErr } = await supabase
    .from("client_stories")
    .select("id,client_id,url,alt,sort_order,created_at")
    .order("client_id")
    .order("sort_order")
    .order("created_at");

  if (sErr) {
    return NextResponse.json({ error: sErr.message }, { status: 400 });
  }

  const storiesByClient = new Map<string, StoryRow[]>();
  for (const s of (stories ?? []) as StoryRow[]) {
    const list = storiesByClient.get(s.client_id) ?? [];
    list.push(s);
    storiesByClient.set(s.client_id, list);
  }

  const storagePaths = new Set<string>();

  for (const c of (clients ?? []) as ClientRowRaw[]) {
    if (c.logo_url && !isHttpUrl(c.logo_url) && !isPublicPath(c.logo_url)) {
      storagePaths.add(normalizeStoragePath(c.logo_url));
    }
    if (c.story_icon_url && !isHttpUrl(c.story_icon_url) && !isPublicPath(c.story_icon_url)) {
      storagePaths.add(normalizeStoragePath(c.story_icon_url));
    }
  }

  for (const s of (stories ?? []) as StoryRow[]) {
    if (!isHttpUrl(s.url) && !isPublicPath(s.url)) {
      storagePaths.add(normalizeStoragePath(s.url));
    }
  }

  const signedUrlMap = new Map<string, string>();
  await Promise.all(
    Array.from(storagePaths).map(async (p) => {
      const { data } = await supabase.storage.from("clients").createSignedUrl(p, 60 * 60);
      if (data?.signedUrl) signedUrlMap.set(p, data.signedUrl);
    })
  );

  const result = await Promise.all(
    ((clients ?? []) as ClientRowRaw[]).map(async (c) => {
      const logo =
        c.logo_url && !isHttpUrl(c.logo_url) && !isPublicPath(c.logo_url)
          ? signedUrlMap.get(normalizeStoragePath(c.logo_url)) ?? null
          : c.logo_url;

      const storyIcon =
        c.story_icon_url && !isHttpUrl(c.story_icon_url) && !isPublicPath(c.story_icon_url)
          ? signedUrlMap.get(normalizeStoragePath(c.story_icon_url)) ?? null
          : c.story_icon_url;

      const list = storiesByClient.get(c.id) ?? [];
      const storiesView = list.map((s) => {
        if (isHttpUrl(s.url) || isPublicPath(s.url)) {
          return { ...s, preview_url: s.url };
        }
        const key = normalizeStoragePath(s.url);
        return { ...s, preview_url: signedUrlMap.get(key) ?? null };
      });

      return {
        ...c,
        logo_url: logo ?? null,
        story_icon_url: storyIcon ?? null,
        stories: storiesView,
      };
    })
  );

  return NextResponse.json(
    {
      clients: result,
      ...(debug
        ? {
            meta: {
              supabase_url: supabaseUrl,
              service_key_role: jwtRole(supabaseServiceRoleKey),
              now: new Date().toISOString(),
              clients_count: result.length,
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
