"use client";

import { useEffect, useMemo, useState } from "react";
import Link from "next/link";
import { useParams, useRouter } from "next/navigation";
import AdminGuard from "@/components/admin/AdminGuard";
import AdminShell from "@/components/admin/AdminShell";
import ImageModal from "@/components/ImageModal";
import { supabase } from "@/lib/supabaseClient";

type ClientRow = {
  id: string;
  name: string;
  slug: string;
};

type CategoryRow = {
  id: string;
  name: string;
  slug: string;
};

type WorkJoined = {
  id: string;
  title: string;
  description: string | null;
  client_id: string;
  category_id: string;
  cover_asset_id: string | null;
  clients: { name: string; slug: string } | null;
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

type AssetView = AssetRow & {
  previewUrl: string | null;
};

function safeFilename(name: string) {
  return name.replace(/[^a-zA-Z0-9._-]+/g, "-");
}

export default function AdminWorkDetailPage() {
  const params = useParams<{ id: string }>();
  const router = useRouter();
  const id = params?.id;

  const [clients, setClients] = useState<ClientRow[]>([]);
  const [categories, setCategories] = useState<CategoryRow[]>([]);
  const [work, setWork] = useState<WorkJoined | null>(null);
  const [assets, setAssets] = useState<AssetView[]>([]);
  const [loading, setLoading] = useState(true);
  const [busy, setBusy] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const [previewOpen, setPreviewOpen] = useState(false);
  const [previewSrc, setPreviewSrc] = useState<string | undefined>(undefined);
  const [previewTitle, setPreviewTitle] = useState<string | undefined>(undefined);

  const [title, setTitle] = useState("");
  const [description, setDescription] = useState("");

  const [clientId, setClientId] = useState("");
  const [categoryId, setCategoryId] = useState("");

  const [urlToAdd, setUrlToAdd] = useState("");

  const storagePathBase = useMemo(() => {
    const clientSlug = work?.clients?.slug;
    const categorySlug = work?.categories?.slug;
    if (!clientSlug || !categorySlug || !work?.id) return null;
    return `${clientSlug}/${categorySlug}/${work.id}`;
  }, [work]);

  const load = async () => {
    if (!id || typeof id !== "string") return;

    setError(null);
    setLoading(true);

    const [{ data: cData, error: cErr }, { data: catData, error: catErr }] =
      await Promise.all([
        supabase.from("clients").select("id,name,slug").order("name"),
        supabase.from("categories").select("id,name,slug").order("name"),
      ]);

    if (cErr) {
      setError(cErr.message);
      setLoading(false);
      return;
    }

    if (catErr) {
      setError(catErr.message);
      setLoading(false);
      return;
    }

    setClients((cData ?? []) as ClientRow[]);
    setCategories((catData ?? []) as CategoryRow[]);

    const { data: wData, error: wErr } = await supabase
      .from("works")
      .select(
        "id,title,description,client_id,category_id,cover_asset_id,clients(name,slug),categories(name,slug)"
      )
      .eq("id", id)
      .single();

    if (wErr) {
      setError(wErr.message);
      setLoading(false);
      return;
    }

    setWork(wData as unknown as WorkJoined);
    setTitle((wData as any).title ?? "");
    setDescription((wData as any).description ?? "");
    setClientId((wData as any).client_id ?? "");
    setCategoryId((wData as any).category_id ?? "");

    const { data: aData, error: aErr } = await supabase
      .from("assets")
      .select("id,work_id,url,alt,sort_order,created_at")
      .eq("work_id", id)
      .order("sort_order", { ascending: true })
      .order("created_at", { ascending: true });

    if (aErr) {
      setError(aErr.message);
      setLoading(false);
      return;
    }

    const views: AssetView[] = await Promise.all(
      ((aData ?? []) as AssetRow[]).map(async (a) => {
        const isStoragePath = !/^https?:\/\//i.test(a.url);
        if (!isStoragePath) {
          return { ...a, previewUrl: a.url };
        }

        const path = a.url.startsWith("/") ? a.url.slice(1) : a.url;

        const { data } = await supabase.storage
          .from("works")
          .createSignedUrl(path, 60 * 60);

        return { ...a, previewUrl: data?.signedUrl ?? null };
      })
    );

    setAssets(views);
    setLoading(false);
  };

  useEffect(() => {
    load();
  }, [id]);

  const onSaveWork = async () => {
    if (!work) return;
    setBusy(true);
    setError(null);

    try {
      const { error: e } = await supabase
        .from("works")
        .update({
          title: title.trim(),
          description: description.trim() ? description.trim() : null,
          client_id: clientId,
          category_id: categoryId,
        })
        .eq("id", work.id);

      if (e) {
        setError(e.message);
        return;
      }

      await load();
    } finally {
      setBusy(false);
    }
  };

  const onSaveAlt = async (assetId: string, alt: string) => {
    setBusy(true);
    setError(null);

    try {
      const { error: e } = await supabase
        .from("assets")
        .update({ alt: alt.trim() ? alt.trim() : null })
        .eq("id", assetId);

      if (e) {
        setError(e.message);
        return;
      }

      await load();
    } finally {
      setBusy(false);
    }
  };

  const onUpload = async (file: File) => {
    if (!work || !storagePathBase) {
      setError("Sem base de path (client/category). Verifique se o trabalho tem cliente e categoria.");
      return;
    }

    setBusy(true);
    setError(null);

    try {
      const filename = `${Date.now()}-${safeFilename(file.name)}`;
      const path = `${storagePathBase}/${filename}`;

      const { error: upErr } = await supabase.storage
        .from("works")
        .upload(path, file, { upsert: false });

      if (upErr) {
        setError(upErr.message);
        return;
      }

      const maxOrder = assets.reduce((acc, a) => Math.max(acc, a.sort_order), 0);

      const { error: insErr } = await supabase.from("assets").insert({
        work_id: work.id,
        url: path,
        alt: null,
        sort_order: assets.length === 0 ? 0 : maxOrder + 1,
      });

      if (insErr) {
        setError(insErr.message);
        return;
      }

      await load();
    } finally {
      setBusy(false);
    }
  };

  const onAddByUrl = async () => {
    if (!work) return;

    const u = urlToAdd.trim();
    if (!u) return;

    setBusy(true);
    setError(null);

    try {
      const maxOrder = assets.reduce((acc, a) => Math.max(acc, a.sort_order), 0);

      const { error: insErr } = await supabase.from("assets").insert({
        work_id: work.id,
        url: u,
        alt: null,
        sort_order: assets.length === 0 ? 0 : maxOrder + 1,
      });

      if (insErr) {
        setError(insErr.message);
        return;
      }

      setUrlToAdd("");
      await load();
    } finally {
      setBusy(false);
    }
  };

  const onDeleteAsset = async (
    assetId: string,
    assetUrl: string,
    alsoDeleteFromStorage: boolean
  ) => {
    const ok = confirm(
      alsoDeleteFromStorage
        ? "Remover esta imagem do trabalho e apagar do Storage?"
        : "Remover esta imagem do trabalho? (não apaga do Storage)"
    );
    if (!ok) return;

    setBusy(true);
    setError(null);

    try {
      if (work?.cover_asset_id === assetId) {
        const { error: ce } = await supabase
          .from("works")
          .update({ cover_asset_id: null })
          .eq("id", work.id);

        if (ce) {
          setError(ce.message);
          return;
        }
      }

      const isStoragePath = !/^https?:\/\//i.test(assetUrl);
      if (alsoDeleteFromStorage && isStoragePath) {
        const path = assetUrl.startsWith("/") ? assetUrl.slice(1) : assetUrl;
        const { error: se } = await supabase.storage.from("works").remove([path]);
        if (se) {
          setError(se.message);
          return;
        }
      }

      const { error: e } = await supabase.from("assets").delete().eq("id", assetId);
      if (e) {
        setError(e.message);
        return;
      }

      await load();
    } finally {
      setBusy(false);
    }
  };

  const onSetCover = async (assetId: string) => {
    if (!work) return;

    setBusy(true);
    setError(null);

    try {
      const { error: e } = await supabase
        .from("works")
        .update({ cover_asset_id: assetId })
        .eq("id", work.id);

      if (e) {
        setError(e.message);
        return;
      }

      await load();
    } finally {
      setBusy(false);
    }
  };

  const swapOrder = async (a: AssetView, b: AssetView) => {
    setBusy(true);
    setError(null);

    try {
      const { error: e1 } = await supabase
        .from("assets")
        .update({ sort_order: b.sort_order })
        .eq("id", a.id);

      if (e1) {
        setError(e1.message);
        return;
      }

      const { error: e2 } = await supabase
        .from("assets")
        .update({ sort_order: a.sort_order })
        .eq("id", b.id);

      if (e2) {
        setError(e2.message);
        return;
      }

      await load();
    } finally {
      setBusy(false);
    }
  };

  const onMoveUp = async (index: number) => {
    if (index <= 0) return;
    await swapOrder(assets[index], assets[index - 1]);
  };

  const onMoveDown = async (index: number) => {
    if (index >= assets.length - 1) return;
    await swapOrder(assets[index], assets[index + 1]);
  };

  const onSetAssetOrder = async (assetId: string, order: number) => {
    if (!Number.isFinite(order)) return;

    setBusy(true);
    setError(null);

    try {
      const { error: e } = await supabase
        .from("assets")
        .update({ sort_order: order })
        .eq("id", assetId);

      if (e) {
        setError(e.message);
        return;
      }

      await load();
    } finally {
      setBusy(false);
    }
  };

  const onBack = () => {
    router.push("/admin/works");
  };

  return (
    <AdminGuard>
      <AdminShell title="Editar trabalho">
        <div className="mb-6 flex flex-wrap gap-2">
          <button
            onClick={onBack}
            className="px-4 py-2 rounded-btn border border-border/60 text-sm font-mono font-medium hover:bg-secondary hover:text-bg transition-colors w-full sm:w-auto"
          >
            Voltar
          </button>
          {work ? (
            <Link
              href={`/admin/works/${work.id}`}
              className="px-4 py-2 rounded-btn border border-border/60 text-sm font-mono font-medium hover:bg-secondary hover:text-bg transition-colors w-full sm:w-auto"
            >
              Recarregar
            </Link>
          ) : null}
        </div>

        {error ? <div className="text-sm text-red-500 mb-4">{error}</div> : null}

        {loading || !work ? (
          <div className="text-text-secondary text-sm">Carregando...</div>
        ) : (
          <div className="space-y-6">
            <div className="rounded-card border border-border bg-bg/80 overflow-hidden p-6">
              <h2 className="font-display text-lg mb-4">Dados</h2>
              <div className="grid grid-cols-1 sm:grid-cols-2 gap-3">
                <input
                  value={title}
                  onChange={(e) => setTitle(e.target.value)}
                  className="px-4 py-2 rounded-lg border border-border bg-bg"
                />
                <input
                  value={description}
                  onChange={(e) => setDescription(e.target.value)}
                  placeholder="Descrição"
                  className="px-4 py-2 rounded-lg border border-border bg-bg"
                />
                <select
                  value={clientId}
                  onChange={(e) => setClientId(e.target.value)}
                  className="px-4 py-2 rounded-lg border border-border bg-bg"
                >
                  {clients.map((c) => (
                    <option key={c.id} value={c.id}>
                      {c.name}
                    </option>
                  ))}
                </select>
                <select
                  value={categoryId}
                  onChange={(e) => setCategoryId(e.target.value)}
                  className="px-4 py-2 rounded-lg border border-border bg-bg"
                >
                  {categories.map((c) => (
                    <option key={c.id} value={c.id}>
                      {c.name}
                    </option>
                  ))}
                </select>
              </div>
              <div className="mt-4 flex flex-wrap gap-2">
                <button
                  onClick={onSaveWork}
                  disabled={busy}
                  className="px-4 py-2 rounded-btn bg-secondary text-bg font-mono font-medium border border-border disabled:opacity-60 w-full sm:w-auto"
                >
                  Salvar
                </button>
              </div>

              <div className="mt-4 text-xs text-text-secondary">
                {work.clients?.name ?? "-"} / {work.categories?.name ?? "-"}
              </div>
            </div>

            <div className="rounded-card border border-border bg-bg/80 overflow-hidden p-6">
              <h2 className="font-display text-lg mb-4">Adicionar imagens</h2>

              <div className="grid grid-cols-1 sm:grid-cols-2 gap-3">
                <div>
                  <input
                    id="work-upload"
                    type="file"
                    accept="image/*"
                    onChange={(e) => {
                      const f = e.target.files?.[0];
                      if (f) void onUpload(f);
                      e.currentTarget.value = "";
                    }}
                    className="sr-only"
                    disabled={busy}
                  />
                  <label
                    htmlFor="work-upload"
                    className={
                      "w-full h-11 px-4 rounded-btn border border-border/60 bg-bg flex items-center justify-center text-sm font-mono font-medium transition-colors " +
                      (busy
                        ? "opacity-60 cursor-not-allowed"
                        : "cursor-pointer hover:bg-secondary hover:text-bg")
                    }
                  >
                    Selecionar imagem
                  </label>
                </div>

                <div className="flex gap-2">
                  <input
                    value={urlToAdd}
                    onChange={(e) => setUrlToAdd(e.target.value)}
                    placeholder="URL"
                    className="flex-1 px-4 py-2 rounded-lg border border-border bg-bg"
                    disabled={busy}
                  />
                  <button
                    onClick={onAddByUrl}
                    disabled={busy || !urlToAdd.trim()}
                    className="px-4 py-2 rounded-btn border border-border/60 text-sm hover:bg-secondary hover:text-bg transition-colors disabled:opacity-60"
                  >
                    Add
                  </button>
                </div>
              </div>

              <div className="mt-3 text-xs text-text-secondary">
                Upload vai para o bucket <span className="font-mono">works</span> em:
                {storagePathBase ? (
                  <span className="font-mono"> {storagePathBase}/...</span>
                ) : (
                  <span className="text-red-500"> (path base indisponível)</span>
                )}
              </div>
            </div>

            <div className="rounded-card border border-border bg-bg/80 overflow-hidden p-6">
              <div className="flex items-center justify-between gap-3 mb-4">
                <h2 className="font-display text-lg">Imagens</h2>
                <button
                  onClick={load}
                  className="px-4 py-2 rounded-btn border border-border/60 hover:bg-secondary hover:text-bg transition-colors text-sm font-mono font-medium w-full sm:w-auto"
                  disabled={busy}
                >
                  Atualizar
                </button>
              </div>

              {assets.length === 0 ? (
                <div className="text-text-secondary text-sm">Sem imagens ainda.</div>
              ) : (
                <div className="space-y-4">
                  {assets.map((a, idx) => {
                    const isCover = work.cover_asset_id === a.id;

                    return (
                      <div key={a.id} className="rounded-xl border border-border p-4">
                        <div className="grid grid-cols-1 sm:grid-cols-3 gap-4">
                          <div className="sm:col-span-1">
                            {a.previewUrl ? (
                              <button
                                type="button"
                                onClick={() => {
                                  setPreviewSrc(a.previewUrl ?? undefined);
                                  setPreviewTitle(`${isCover ? "Capa" : "Imagem"} #${idx + 1}`);
                                  setPreviewOpen(true);
                                }}
                                className="block w-full text-left"
                                aria-label="Abrir pré-visualização"
                              >
                                <div className="flex items-center justify-center sm:justify-start">
                                  <div className="relative w-24 h-24 rounded-full">
                                    <div className="absolute inset-0 rounded-full bg-gradient-to-tr from-primary via-amber-400 to-pink-500" />
                                    <div className="absolute inset-[3px] rounded-full bg-bg/90 border border-border overflow-hidden">
                                      <img
                                        src={a.previewUrl}
                                        alt={a.alt ?? ""}
                                        className="w-full h-full object-cover"
                                        loading="lazy"
                                        decoding="async"
                                      />
                                    </div>
                                  </div>
                                </div>
                              </button>
                            ) : (
                              <div className="w-full h-40 rounded-lg border border-border flex items-center justify-center text-xs text-text-secondary">
                                Sem preview
                              </div>
                            )}
                          </div>

                          <div className="sm:col-span-2 min-w-0">
                            <div className="flex items-center justify-between gap-3">
                              <div className="text-sm font-medium truncate">
                                {isCover ? "Capa" : "Imagem"} #{idx + 1}
                              </div>
                              <div className="flex items-center gap-2 text-xs text-text-secondary">
                                <span>ordem:</span>
                                <input
                                  type="number"
                                  min={0}
                                  defaultValue={a.sort_order}
                                  onKeyDown={(e) => {
                                    if (e.key === "Enter") {
                                      (e.currentTarget as HTMLInputElement).blur();
                                    }
                                  }}
                                  onBlur={(e) => {
                                    const next = Number(e.currentTarget.value);
                                    if (Number.isFinite(next) && next !== a.sort_order) {
                                      void onSetAssetOrder(a.id, next);
                                    }
                                  }}
                                  className="w-20 px-2 py-1 rounded-lg border border-border bg-bg text-xs"
                                  disabled={busy}
                                />
                              </div>
                            </div>

                            <div className="text-xs text-text-secondary mt-1 break-all">{a.url}</div>

                            <div className="mt-3">
                              <label className="text-xs text-text-secondary">alt</label>
                              <input
                                defaultValue={a.alt ?? ""}
                                onBlur={(e) => {
                                  const v = e.target.value;
                                  if ((a.alt ?? "") !== v) {
                                    void onSaveAlt(a.id, v);
                                  }
                                }}
                                className="mt-1 w-full px-3 py-2 rounded-lg border border-border bg-bg text-sm"
                                disabled={busy}
                              />
                            </div>

                            <div className="flex flex-wrap gap-2 mt-3">
                              <button
                                onClick={() => onSetCover(a.id)}
                                disabled={busy || isCover}
                                className="px-3 py-2 rounded-lg border border-border text-sm hover:bg-secondary hover:text-bg transition-colors disabled:opacity-60"
                              >
                                {isCover ? "Capa" : "Definir capa"}
                              </button>

                              <button
                                onClick={() => onMoveUp(idx)}
                                disabled={busy || idx === 0}
                                className="px-3 py-2 rounded-lg border border-border text-sm hover:bg-secondary hover:text-bg transition-colors disabled:opacity-60"
                              >
                                Subir
                              </button>

                              <button
                                onClick={() => onMoveDown(idx)}
                                disabled={busy || idx === assets.length - 1}
                                className="px-3 py-2 rounded-lg border border-border text-sm hover:bg-secondary hover:text-bg transition-colors disabled:opacity-60"
                              >
                                Descer
                              </button>

                              <button
                                onClick={() => onDeleteAsset(a.id, a.url, false)}
                                disabled={busy}
                                className="px-3 py-2 rounded-lg border border-border text-sm hover:bg-secondary hover:text-bg transition-colors disabled:opacity-60"
                              >
                                Remover
                              </button>

                              <button
                                onClick={() => onDeleteAsset(a.id, a.url, true)}
                                disabled={busy || /^https?:\/\//i.test(a.url)}
                                className="px-3 py-2 rounded-lg border border-border text-sm hover:bg-secondary hover:text-bg transition-colors disabled:opacity-60"
                              >
                                Remover do Storage
                              </button>
                            </div>
                          </div>
                        </div>
                      </div>
                    );
                  })}
                </div>
              )}
            </div>
          </div>
        )}

        <ImageModal
          isOpen={previewOpen}
          onClose={() => setPreviewOpen(false)}
          title={previewTitle}
          src={previewSrc}
        />

        <div className="sticky bottom-0 z-10 -mx-4 sm:mx-0 px-4 sm:px-0 py-3 bg-bg/90 backdrop-blur border-t border-border/30">
          <div className="flex flex-col sm:flex-row gap-2">
            <button
              onClick={onSaveWork}
              disabled={busy || loading || !work}
              className="px-4 py-2 rounded-btn bg-secondary text-bg font-mono font-medium border border-border disabled:opacity-60 w-full sm:w-auto"
            >
              Salvar
            </button>
            <button
              onClick={load}
              disabled={busy || loading}
              className="px-4 py-2 rounded-btn border border-border/60 text-sm font-mono font-medium hover:bg-secondary hover:text-bg transition-colors disabled:opacity-60 w-full sm:w-auto"
            >
              Atualizar
            </button>
            <button
              onClick={onBack}
              className="px-4 py-2 rounded-btn border border-border/60 text-sm font-mono font-medium hover:bg-secondary hover:text-bg transition-colors w-full sm:w-auto"
            >
              Voltar
            </button>
          </div>
        </div>
      </AdminShell>
    </AdminGuard>
  );
}
