import { NextResponse } from "next/server";
import { createClient } from "@supabase/supabase-js";

const supabaseUrlEnv = process.env.NEXT_PUBLIC_SUPABASE_URL;
const supabaseAnonKeyEnv = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY;

if (!supabaseUrlEnv) {
  throw new Error("Missing NEXT_PUBLIC_SUPABASE_URL");
}

if (!supabaseAnonKeyEnv) {
  throw new Error("Missing NEXT_PUBLIC_SUPABASE_ANON_KEY");
}

const supabaseUrl = supabaseUrlEnv;
const supabaseAnonKey = supabaseAnonKeyEnv;

export async function GET(req: Request) {
  const auth = req.headers.get("authorization") ?? req.headers.get("Authorization");
  const token = auth?.startsWith("Bearer ") ? auth.slice("Bearer ".length) : null;

  if (!token) {
    return NextResponse.json({ error: "Missing bearer token" }, { status: 401 });
  }

  const supabase = createClient(supabaseUrl, supabaseAnonKey, {
    global: {
      headers: {
        Authorization: `Bearer ${token}`,
      },
    },
  });

  const { data: userData, error: userErr } = await supabase.auth.getUser();

  if (userErr || !userData.user) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }

  if (userData.user.app_metadata?.role !== "admin") {
    return NextResponse.json({ error: "Forbidden" }, { status: 403 });
  }

  const [{ data: clients, error: cErr }, { data: categories, error: catErr }] =
    await Promise.all([
      supabase.from("clients").select("id,name,slug,logo_url,created_at").order("name"),
      supabase.from("categories").select("id,name,slug,created_at").order("name"),
    ]);

  if (cErr) {
    return NextResponse.json({ error: cErr.message }, { status: 400 });
  }

  if (catErr) {
    return NextResponse.json({ error: catErr.message }, { status: 400 });
  }

  const { data: works, error: wErr } = await supabase
    .from("works")
    .select(
      "id,title,description,client_id,category_id,cover_asset_id,created_at,clients(name,slug,logo_url),categories(name,slug)"
    )
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

  return NextResponse.json({ clients, categories, works, assets });
}
