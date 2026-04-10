"use client";

import { useEffect, useMemo, useState } from "react";
import { useParams, useRouter } from "next/navigation";
import { createClient } from "@supabase/supabase-js";
import AdminGuard from "@/components/admin/AdminGuard";
import AdminShell from "@/components/admin/AdminShell";
import ImageModal from "@/components/ImageModal";
import { supabase } from "@/lib/supabaseClient";

type ClientRow = {
  id: string;
  name: string;
  slug: string;
  logo_url: string | null;
  story_icon_url: string | null;
  created_at: string;
};

type ClientWithSigned = ClientRow & {
  logo_preview: string | null;
  story_icon_preview: string | null;
};

type StoryRow = {
  id: string;
  client_id: string;
  url: string;
  alt: string | null;
  sort_order: number;
  created_at: string;
};

type StoryView = StoryRow & {
  previewUrl: string | null;
};

function isHttpUrl(url: string) {
  return /^https?:\/\//i.test(url);
}

function isPublicPath(url: string) {
  return url.startsWith("/");
}

function safeFilename(name: string) {
  return name.replace(/[^a-zA-Z0-9._-]+/g, "-");
}

function normalizeStoragePath(path: string) {
  return path.startsWith("/") ? path.slice(1) : path;
}

async function signIfNeeded(
  supabaseClient: any,
  bucket: string,
  maybeUrl: string | null,
  expiresInSeconds: number
) {
  if (!maybeUrl) return null;
  if (isHttpUrl(maybeUrl) || isPublicPath(maybeUrl)) return maybeUrl;

  const path = normalizeStoragePath(maybeUrl);
  const { data, error } = await supabaseClient.storage.from(bucket).createSignedUrl(path, expiresInSeconds);
  if (error) return null;
  return data?.signedUrl ?? null;
}

export default function AdminClientDetailPage() {
  const params = useParams<{ id: string }>();
  const router = useRouter();
  const id = params?.id;

  const [client, setClient] = useState<ClientWithSigned | null>(null);
  const [stories, setStories] = useState<StoryView[]>([]);
  const [loading, setLoading] = useState(true);
  const [busy, setBusy] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const [previewOpen, setPreviewOpen] = useState(false);
  const [previewSrc, setPreviewSrc] = useState<string | undefined>(undefined);
  const [previewTitle, setPreviewTitle] = useState<string | undefined>(undefined);

  const [name, setName] = useState("");
  const [slug, setSlug] = useState("");
  const [logoUrl, setLogoUrl] = useState("");
  const [storyIconUrl, setStoryIconUrl] = useState("");

  const [storyUrlToAdd, setStoryUrlToAdd] = useState("");

  const basePath = useMemo(() => {
    if (!client?.slug) return null;
    return `${client.slug}`;
  }, [client?.slug]);

  const load = async () => {
    if (!id || typeof id !== "string") return;

    setError(null);
    setLoading(true);

    const { data: cData, error: cErr } = await supabase
      .from("clients")
      .select("id,name,slug,logo_url,story_icon_url,created_at")
      .eq("id", id)
      .single();

    if (cErr) {
      setError(cErr.message);
      setLoading(false);
      return;
    }

    const clientRaw = cData as ClientRow;
    const [logoPreview, storyIconPreview] = await Promise.all([
      signIfNeeded(supabase, "clients", clientRaw.logo_url, 60 * 60),
      signIfNeeded(supabase, "clients", clientRaw.story_icon_url, 60 * 60),
    ]);
    const clientWithSigned: ClientWithSigned = {
      ...clientRaw,
      logo_preview: logoPreview,
      story_icon_preview: storyIconPreview,
    };
    setClient(clientWithSigned);
    setName(clientRaw.name ?? "");
    setSlug(clientRaw.slug ?? "");
    setLogoUrl(clientRaw.logo_url ?? "");
    setStoryIconUrl(clientRaw.story_icon_url ?? "");

    const { data: sData, error: sErr } = await supabase
      .from("client_stories")
      .select("id,client_id,url,alt,sort_order,created_at")
      .eq("client_id", id)
      .order("sort_order", { ascending: true })
      .order("created_at", { ascending: true });

    if (sErr) {
      setError(sErr.message);
      setLoading(false);
      return;
    }

    const views: StoryView[] = await Promise.all(
      ((sData ?? []) as StoryRow[]).map(async (s) => {
        if (isHttpUrl(s.url)) return { ...s, previewUrl: s.url };

        const path = normalizeStoragePath(s.url);
        const { data } = await supabase.storage
          .from("clients")
          .createSignedUrl(path, 60 * 60);

        return { ...s, previewUrl: data?.signedUrl ?? null };
      })
    );

    setStories(views);
    setLoading(false);
  };

  useEffect(() => {
    load();
  }, [id]);

  const onBack = () => {
    router.push("/admin/clients");
  };

  const onSaveClient = async () => {
    if (!client) return;

    setBusy(true);
    setError(null);

    try {
      const { error: e } = await supabase
        .from("clients")
        .update({
          name: name.trim(),
          slug: slug.trim(),
          logo_url: logoUrl.trim() ? logoUrl.trim() : null,
          story_icon_url: storyIconUrl.trim() ? storyIconUrl.trim() : null,
        })
        .eq("id", client.id);

      if (e) {
        setError(e.message);
        return;
      }

      await load();
    } finally {
      setBusy(false);
    }
  };

  const uploadToClientsBucket = async (file: File, kind: "logo" | "story_icon" | "story") => {
    if (!client || !basePath) {
      setError("Cliente sem slug.");
      return null;
    }

    const filename = `${Date.now()}-${safeFilename(file.name)}`;

    if (kind === "logo") return `${basePath}/logo/${filename}`;
    if (kind === "story_icon") return `${basePath}/story-icon/${filename}`;
    return `${basePath}/stories/${filename}`;
  };

  const onUploadLogo = async (file: File) => {
    if (!client) return;

    setBusy(true);
    setError(null);

    try {
      const path = await uploadToClientsBucket(file, "logo");
      if (!path) return;

      const { error: upErr } = await supabase.storage
        .from("clients")
        .upload(path, file, { upsert: true });

      if (upErr) {
        setError(upErr.message);
        return;
      }

      await supabase.from("clients").update({ logo_url: path }).eq("id", client.id);
      await load();
    } finally {
      setBusy(false);
    }
  };

  const onUploadStoryIcon = async (file: File) => {
    if (!client) return;

    setBusy(true);
    setError(null);

    try {
      const path = await uploadToClientsBucket(file, "story_icon");
      if (!path) return;

      const { error: upErr } = await supabase.storage
        .from("clients")
        .upload(path, file, { upsert: true });

      if (upErr) {
        setError(upErr.message);
        return;
      }

      await supabase
        .from("clients")
        .update({ story_icon_url: path })
        .eq("id", client.id);

      await load();
    } finally {
      setBusy(false);
    }
  };

  const onUploadStory = async (file: File) => {
    if (!client) return;

    setBusy(true);
    setError(null);

    try {
      const path = await uploadToClientsBucket(file, "story");
      if (!path) return;

      const { error: upErr } = await supabase.storage
        .from("clients")
        .upload(path, file, { upsert: false });

      if (upErr) {
        setError(upErr.message);
        return;
      }

      const maxOrder = stories.reduce((acc, s) => Math.max(acc, s.sort_order), 0);

      const { error: insErr } = await supabase.from("client_stories").insert({
        client_id: client.id,
        url: path,
        alt: null,
        sort_order: stories.length === 0 ? 0 : maxOrder + 1,
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

  const onAddStoryByUrl = async () => {
    if (!client) return;
    const u = storyUrlToAdd.trim();
    if (!u) return;

    setBusy(true);
    setError(null);

    try {
      const maxOrder = stories.reduce((acc, s) => Math.max(acc, s.sort_order), 0);

      const { error: insErr } = await supabase.from("client_stories").insert({
        client_id: client.id,
        url: u,
        alt: null,
        sort_order: stories.length === 0 ? 0 : maxOrder + 1,
      });

      if (insErr) {
        setError(insErr.message);
        return;
      }

      setStoryUrlToAdd("");
      await load();
    } finally {
      setBusy(false);
    }
  };

  const onSaveStoryAlt = async (storyId: string, alt: string) => {
    setBusy(true);
    setError(null);

    try {
      const { error: e } = await supabase
        .from("client_stories")
        .update({ alt: alt.trim() ? alt.trim() : null })
        .eq("id", storyId);

      if (e) {
        setError(e.message);
        return;
      }

      await load();
    } finally {
      setBusy(false);
    }
  };

  const swapOrder = async (a: StoryView, b: StoryView) => {
    setBusy(true);
    setError(null);

    try {
      const { error: e1 } = await supabase
        .from("client_stories")
        .update({ sort_order: b.sort_order })
        .eq("id", a.id);

      if (e1) {
        setError(e1.message);
        return;
      }

      const { error: e2 } = await supabase
        .from("client_stories")
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
    await swapOrder(stories[index], stories[index - 1]);
  };

  const onMoveDown = async (index: number) => {
    if (index >= stories.length - 1) return;
    await swapOrder(stories[index], stories[index + 1]);
  };

  const onSetStoryOrder = async (storyId: string, order: number) => {
    if (!Number.isFinite(order)) return;

    setBusy(true);
    setError(null);

    try {
      const { error: e } = await supabase
        .from("client_stories")
        .update({ sort_order: order })
        .eq("id", storyId);

      if (e) {
        setError(e.message);
        return;
      }

      await load();
    } finally {
      setBusy(false);
    }
  };

  const onDeleteStory = async (storyId: string, storyUrl: string, alsoDeleteFromStorage: boolean) => {
    if (!client) return;
    const ok = confirm(
      alsoDeleteFromStorage
        ? "Remover story e apagar do Storage?"
        : "Remover story? (não apaga do Storage)"
    );
    if (!ok) return;

    setBusy(true);
    setError(null);

    try {
      if (alsoDeleteFromStorage && !isHttpUrl(storyUrl)) {
        const path = normalizeStoragePath(storyUrl);
        const { error: se } = await supabase.storage.from("clients").remove([path]);
        if (se) {
          setError(se.message);
          return;
        }
      }

      const { error: e } = await supabase
        .from("client_stories")
        .delete()
        .eq("id", storyId);

      if (e) {
        setError(e.message);
        return;
      }

      await load();
    } finally {
      setBusy(false);
    }
  };

  return (
    <AdminGuard>
      <AdminShell title="Cliente">
        <div className="mb-6 flex flex-wrap gap-2">
          <button
            onClick={onBack}
            className="px-4 py-2 rounded-btn border border-border/60 text-sm font-mono font-medium hover:bg-secondary hover:text-bg transition-colors w-full sm:w-auto"
          >
            Voltar
          </button>
        </div>

        {error ? <div className="text-sm text-red-500 mb-4">{error}</div> : null}

        {loading || !client ? (
          <div className="text-text-secondary text-sm">Carregando...</div>
        ) : (
          <div className="space-y-6">
            <div className="rounded-card border border-border bg-bg/80 overflow-hidden p-6">
              <h2 className="font-display text-lg mb-4">Dados</h2>

              <div className="grid grid-cols-1 sm:grid-cols-2 gap-3">
                <input
                  value={name}
                  onChange={(e) => setName(e.target.value)}
                  placeholder="Nome"
                  className="px-4 py-2 rounded-lg border border-border bg-bg"
                  disabled={busy}
                />
                <input
                  value={slug}
                  onChange={(e) => setSlug(e.target.value)}
                  placeholder="Slug"
                  className="px-4 py-2 rounded-lg border border-border bg-bg"
                  disabled={busy}
                />

                <input
                  value={logoUrl}
                  onChange={(e) => setLogoUrl(e.target.value)}
                  placeholder="Logo"
                  className="px-4 py-2 rounded-lg border border-border bg-bg"
                  disabled={busy}
                />

                <input
                  value={storyIconUrl}
                  onChange={(e) => setStoryIconUrl(e.target.value)}
                  placeholder="Ícone"
                  className="px-4 py-2 rounded-lg border border-border bg-bg"
                  disabled={busy}
                />
              </div>

              <div className="mt-4 flex flex-wrap gap-2">
                <button
                  onClick={onSaveClient}
                  disabled={busy}
                  className="px-4 py-2 rounded-btn bg-secondary text-bg font-mono font-medium border border-border disabled:opacity-60 w-full sm:w-auto"
                >
                  Salvar
                </button>
              </div>

              <div className="mt-4 grid grid-cols-1 sm:grid-cols-2 gap-3">
                <div className="rounded-card border border-border bg-bg/60 overflow-hidden p-4">
                  <div className="font-medium text-sm mb-2">Upload logo</div>
                  <input
                    id="client-logo-upload"
                    type="file"
                    accept="image/*"
                    onChange={(e) => {
                      const f = e.target.files?.[0];
                      if (f) void onUploadLogo(f);
                      e.currentTarget.value = "";
                    }}
                    className="sr-only"
                    disabled={busy}
                  />
                  <label
                    htmlFor="client-logo-upload"
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

                <div className="rounded-card border border-border bg-bg/60 overflow-hidden p-4">
                  <div className="font-medium text-sm mb-2">Upload ícone (stories)</div>
                  <input
                    id="client-icon-upload"
                    type="file"
                    accept="image/*"
                    onChange={(e) => {
                      const f = e.target.files?.[0];
                      if (f) void onUploadStoryIcon(f);
                      e.currentTarget.value = "";
                    }}
                    className="sr-only"
                    disabled={busy}
                  />
                  <label
                    htmlFor="client-icon-upload"
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
              </div>

              <div className="mt-3 grid grid-cols-1 sm:grid-cols-2 gap-3">
                <div className="rounded-card border border-border bg-bg/60 overflow-hidden p-4">
                  <div className="font-medium text-sm mb-2">Logo</div>
                  {client.logo_preview ? (
                    <button
                      type="button"
                      onClick={() => {
                        setPreviewSrc(client.logo_preview ?? undefined);
                        setPreviewTitle("Logo");
                        setPreviewOpen(true);
                      }}
                      className="block w-full"
                      aria-label="Abrir logo"
                    >
                      <div className="flex items-center justify-center">
                        <div className="relative w-28 h-28 rounded-full">
                          <div className="absolute inset-0 rounded-full bg-gradient-to-tr from-primary via-amber-400 to-pink-500" />
                          <div className="absolute inset-[3px] rounded-full bg-bg/90 border border-border overflow-hidden">
                            <img
                              src={client.logo_preview}
                              alt="Logo"
                              className="w-full h-full object-cover"
                              loading="lazy"
                              decoding="async"
                            />
                          </div>
                        </div>
                      </div>
                    </button>
                  ) : (
                    <div className="w-full h-32 rounded-lg border border-border flex items-center justify-center text-xs text-text-secondary bg-bg">
                      Sem logo
                    </div>
                  )}
                </div>

                <div className="rounded-card border border-border bg-bg/60 overflow-hidden p-4">
                  <div className="font-medium text-sm mb-2">Ícone (stories)</div>
                  {client.story_icon_preview ? (
                    <button
                      type="button"
                      onClick={() => {
                        setPreviewSrc(client.story_icon_preview ?? undefined);
                        setPreviewTitle("Ícone (stories)");
                        setPreviewOpen(true);
                      }}
                      className="block w-full"
                      aria-label="Abrir ícone"
                    >
                      <div className="flex items-center justify-center">
                        <div className="relative w-28 h-28 rounded-full">
                          <div className="absolute inset-0 rounded-full bg-gradient-to-tr from-primary via-amber-400 to-pink-500" />
                          <div className="absolute inset-[3px] rounded-full bg-bg/90 border border-border overflow-hidden">
                            <img
                              src={client.story_icon_preview}
                              alt="Ícone stories"
                              className="w-full h-full object-cover"
                              loading="lazy"
                              decoding="async"
                            />
                          </div>
                        </div>
                      </div>
                    </button>
                  ) : (
                    <div className="w-full h-32 rounded-lg border border-border flex items-center justify-center text-xs text-text-secondary bg-bg">
                      Sem ícone
                    </div>
                  )}
                </div>
              </div>

            </div>

            <div className="rounded-card border border-border bg-bg/80 overflow-hidden p-6">
              <h2 className="font-display text-lg mb-4">Stories</h2>

              <div className="grid grid-cols-1 sm:grid-cols-2 gap-3">
                <div>
                  <input
                    id="client-story-upload"
                    type="file"
                    accept="image/*"
                    onChange={(e) => {
                      const f = e.target.files?.[0];
                      if (f) void onUploadStory(f);
                      e.currentTarget.value = "";
                    }}
                    className="sr-only"
                    disabled={busy}
                  />
                  <label
                    htmlFor="client-story-upload"
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
                    value={storyUrlToAdd}
                    onChange={(e) => setStoryUrlToAdd(e.target.value)}
                    placeholder="URL"
                    className="flex-1 px-3 py-2 rounded-lg border border-border bg-bg"
                    disabled={busy}
                  />
                  <button
                    onClick={onAddStoryByUrl}
                    disabled={busy || !storyUrlToAdd.trim()}
                    className="px-4 py-2 rounded-btn border border-border/60 text-sm font-mono font-medium hover:bg-secondary hover:text-bg transition-colors disabled:opacity-60"
                  >
                    Add
                  </button>
                </div>
              </div>

              <div className="mt-4">
                {stories.length === 0 ? (
                  <div className="text-text-secondary text-sm">Sem stories ainda.</div>
                ) : (
                  <div className="space-y-4">
                    {stories.map((s, idx) => (
                      <div key={s.id} className="rounded-xl border border-border p-4">
                        <div className="grid grid-cols-1 sm:grid-cols-3 gap-4">
                          <div>
                            {s.previewUrl ? (
                              <button
                                type="button"
                                onClick={() => {
                                  setPreviewSrc(s.previewUrl ?? undefined);
                                  setPreviewTitle(`Story #${idx + 1}`);
                                  setPreviewOpen(true);
                                }}
                                className="block w-full text-left"
                                aria-label="Abrir story"
                              >
                                <div className="flex items-center justify-center sm:justify-start">
                                  <div className="relative w-24 h-24 rounded-full">
                                    <div className="absolute inset-0 rounded-full bg-gradient-to-tr from-primary via-amber-400 to-pink-500" />
                                    <div className="absolute inset-[3px] rounded-full bg-bg/90 border border-border overflow-hidden">
                                      <img
                                        src={s.previewUrl}
                                        alt={s.alt ?? ""}
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
                              <div className="text-sm font-medium truncate">Story #{idx + 1}</div>
                              <div className="flex items-center gap-2 text-xs text-text-secondary">
                                <span>ordem:</span>
                                <input
                                  type="number"
                                  min={0}
                                  defaultValue={s.sort_order}
                                  onKeyDown={(e) => {
                                    if (e.key === "Enter") {
                                      (e.currentTarget as HTMLInputElement).blur();
                                    }
                                  }}
                                  onBlur={(e) => {
                                    const next = Number(e.currentTarget.value);
                                    if (Number.isFinite(next) && next !== s.sort_order) {
                                      void onSetStoryOrder(s.id, next);
                                    }
                                  }}
                                  className="w-20 px-2 py-1 rounded-lg border border-border bg-bg text-xs"
                                  disabled={busy}
                                />
                              </div>
                            </div>

                            <div className="text-xs text-text-secondary mt-1 break-all">{s.url}</div>

                            <div className="mt-3">
                              <label className="text-xs text-text-secondary">alt</label>
                              <input
                                defaultValue={s.alt ?? ""}
                                onBlur={(e) => {
                                  const v = e.target.value;
                                  if ((s.alt ?? "") !== v) {
                                    void onSaveStoryAlt(s.id, v);
                                  }
                                }}
                                className="mt-1 w-full px-3 py-2 rounded-lg border border-border bg-bg text-sm"
                                disabled={busy}
                              />
                            </div>

                            <div className="flex flex-wrap gap-2 mt-3">
                              <button
                                onClick={() => onMoveUp(idx)}
                                disabled={busy || idx === 0}
                                className="px-3 py-2 rounded-lg border border-border text-sm hover:bg-secondary hover:text-bg transition-colors disabled:opacity-60"
                              >
                                Subir
                              </button>

                              <button
                                onClick={() => onMoveDown(idx)}
                                disabled={busy || idx === stories.length - 1}
                                className="px-3 py-2 rounded-lg border border-border text-sm hover:bg-secondary hover:text-bg transition-colors disabled:opacity-60"
                              >
                                Descer
                              </button>

                              <button
                                onClick={() => onDeleteStory(s.id, s.url, false)}
                                disabled={busy}
                                className="px-3 py-2 rounded-lg border border-border text-sm hover:bg-secondary hover:text-bg transition-colors disabled:opacity-60"
                              >
                                Remover
                              </button>

                              <button
                                onClick={() => onDeleteStory(s.id, s.url, true)}
                                disabled={busy || isHttpUrl(s.url)}
                                className="px-3 py-2 rounded-lg border border-border text-sm hover:bg-secondary hover:text-bg transition-colors disabled:opacity-60"
                              >
                                Remover do Storage
                              </button>
                            </div>
                          </div>
                        </div>
                      </div>
                    ))}
                  </div>
                )}
              </div>
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
              onClick={onSaveClient}
              disabled={busy || loading || !client}
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
