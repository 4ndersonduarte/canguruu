"use client";

import { useEffect, useMemo, useState } from "react";
import { motion } from "framer-motion";
import ImageModal from "@/components/ImageModal";

type Work = {
  id: string;
  title: string;
  src: string;
  description: string;
  client: string;
  badgeSrc?: string;
  badgeAlt?: string;
};

type ApiWorkAsset = {
  id: string;
  work_id: string;
  url: string;
  alt: string | null;
  sort_order: number;
  created_at: string;
  preview_url: string | null;
};

type ApiWork = {
  id: string;
  title: string;
  description: string | null;
  client_id: string;
  category_id: string;
  cover_asset_id: string | null;
  created_at: string;
  clients: { name: string; slug: string; logo_url: string | null } | null;
  categories: { name: string; slug: string } | null;
  assets: ApiWorkAsset[];
};

export default function WorksGallery() {
  const [selectedTab, setSelectedTab] = useState<"Trabalhos" | "Identidade visual">("Trabalhos");
  const [selectedClient, setSelectedClient] = useState<string>("Todos");
  const [open, setOpen] = useState(false);
  const [selectedWork, setSelectedWork] = useState<Work | null>(null);

  const [loadedImages, setLoadedImages] = useState<Record<string, boolean>>({});

  const [apiWorks, setApiWorks] = useState<ApiWork[]>([]);
  const [apiError, setApiError] = useState<string | null>(null);

  useEffect(() => {
    let mounted = true;

    const run = async () => {
      try {
        const res = await fetch("/api/public/works", { cache: "no-store" });
        const text = await res.text();
        let json: { works?: ApiWork[]; error?: string } | null = null;

        try {
          json = JSON.parse(text) as { works?: ApiWork[]; error?: string };
        } catch {
          json = null;
        }

        if (!mounted) return;

        if (!res.ok) {
          const msg =
            json?.error ??
            `Falha ao carregar trabalhos (HTTP ${res.status}). ${text.slice(0, 180)}`;
          setApiError(msg);
          return;
        }

        setApiWorks(json?.works ?? []);
        setApiError(null);
      } catch {
        if (!mounted) return;
        setApiError("Falha ao carregar trabalhos.");
      }
    };

    run();

    return () => {
      mounted = false;
    };
  }, []);

  const clientBadgesDynamic = useMemo(() => {
    const map: Record<string, { src: string; alt: string }> = {};

    for (const w of apiWorks) {
      const name = w.clients?.name;
      const logo = w.clients?.logo_url;
      if (!name) continue;

      if (!map[name] && logo) {
        map[name] = { src: logo, alt: name };
      }
    }

    return map;
  }, [apiWorks]);

  const works: Work[] = useMemo(() => {
    const list: Work[] = [];

    for (const w of apiWorks) {
      const categorySlug = w.categories?.slug ?? "";
      if (categorySlug === "identidade-visual" || categorySlug === "identidade%20visual") {
        continue;
      }

      const clientName = w.clients?.name ?? "-";
      const assets = (w.assets ?? [])
        .filter((a) => Boolean(a.preview_url))
        .slice()
        .sort((a, b) => {
          if (a.sort_order !== b.sort_order) return a.sort_order - b.sort_order;
          return String(a.created_at).localeCompare(String(b.created_at));
        });
      for (const a of assets) {
        const src = a.preview_url as string;
        list.push({
          id: a.id,
          title: w.title,
          src,
          description: w.description ?? "",
          client: clientName,
        });
      }
    }

    return list;
  }, [apiWorks]);

  const identityWorks: Work[] = useMemo(() => {
    const list: Work[] = [];

    for (const w of apiWorks) {
      const categorySlug = w.categories?.slug ?? "";
      if (categorySlug !== "identidade-visual" && categorySlug !== "identidade%20visual") {
        continue;
      }

      const assets = (w.assets ?? [])
        .filter((a) => Boolean(a.preview_url))
        .slice()
        .sort((a, b) => {
          if (a.sort_order !== b.sort_order) return a.sort_order - b.sort_order;
          return String(a.created_at).localeCompare(String(b.created_at));
        });

      for (const a of assets) {
        if (!a.preview_url) continue;
        const clientName = w.clients?.name ?? "-";

        list.push({
          id: a.id,
          title: "Identidade visual",
          src: a.preview_url,
          description: "",
          client: clientName,
          badgeSrc: clientBadgesDynamic[clientName]?.src,
          badgeAlt: clientBadgesDynamic[clientName]?.alt,
        });
      }
    }

    return list;
  }, [apiWorks, clientBadgesDynamic]);

  const clients = useMemo(() => {
    const unique = Array.from(new Set(works.map((w) => w.client)));
    return ["Todos", ...unique];
  }, [works]);

  const identityGroups = useMemo(() => {
    const map = new Map<string, Work[]>();
    for (const w of identityWorks) {
      const current = map.get(w.client) || [];
      current.push(w);
      map.set(w.client, current);
    }
    return Array.from(map.entries());
  }, [identityWorks]);

  const filteredWorks = useMemo(() => {
    if (selectedClient === "Todos") return works;
    return works.filter((w) => w.client === selectedClient);
  }, [selectedClient, works]);

  const openWork = (w: Work) => {
    setSelectedWork(w);
    setOpen(true);
  };

  const markLoaded = (key: string) => {
    setLoadedImages((prev) => {
      if (prev[key]) return prev;
      return { ...prev, [key]: true };
    });
  };

  return (
    <section id="trabalhos" className="py-12 sm:py-16 px-4 sm:px-6 lg:px-8 max-w-6xl mx-auto">
      <motion.h2
        initial={{ opacity: 0, y: 14 }}
        whileInView={{ opacity: 1, y: 0 }}
        viewport={{ once: true }}
        transition={{ duration: 0.45, ease: [0.22, 1, 0.36, 1] }}
        className="font-display text-2xl md:text-3xl font-bold mb-6"
      >
        <span className="scribble-underline">Trabalhos</span>
      </motion.h2>

      <div className="flex flex-wrap gap-2 mb-4">
        {(["Trabalhos", "Identidade visual"] as const).map((t) => {
          const active = t === selectedTab;
          return (
            <button
              key={t}
              type="button"
              onClick={() => setSelectedTab(t)}
              className={
                active
                  ? "px-3 py-1.5 rounded-btn bg-primary text-secondary border border-border text-sm font-mono"
                  : "px-3 py-1.5 rounded-btn bg-bg/50 text-text-secondary border border-border/60 text-sm font-mono hover:bg-bg/80 hover:text-text-primary transition-colors"
              }
            >
              {t}
            </button>
          );
        })}
      </div>

      {apiError ? (
        <div className="text-sm text-red-500 mb-6">{apiError}</div>
      ) : null}

      {selectedTab === "Trabalhos" && (
        <div className="flex flex-wrap gap-2 mb-6">
          {clients.map((c) => {
            const active = c === selectedClient;
            return (
              <button
                key={c}
                type="button"
                onClick={() => setSelectedClient(c)}
                className={
                  active
                    ? "px-3 py-1.5 rounded-btn bg-primary text-secondary border border-border text-sm font-mono"
                    : "px-3 py-1.5 rounded-btn bg-bg/50 text-text-secondary border border-border/60 text-sm font-mono hover:bg-bg/80 hover:text-text-primary transition-colors"
                }
              >
                {c}
              </button>
            );
          })}
        </div>
      )}

      {selectedTab === "Identidade visual" ? (
        <div className="space-y-8">
          {identityGroups.map(([clientName, clientWorks]) => (
            <div key={clientName}>
              <div className="flex items-center gap-3 mb-4">
                {clientBadgesDynamic[clientName]?.src && (
                  <div className="w-10 h-10 rounded-full bg-bg/90 border border-border overflow-hidden">
                    <img
                      src={clientBadgesDynamic[clientName]!.src}
                      alt={clientBadgesDynamic[clientName]!.alt}
                      className="w-full h-full object-cover"
                      loading="lazy"
                    />
                  </div>
                )}
                <p className="font-display font-semibold text-base sm:text-lg">{clientName}</p>
              </div>

              <div className="columns-2 sm:columns-2 lg:columns-3 gap-3 sm:gap-4 [column-fill:_balance]">
                {clientWorks.map((w) => (
                  <motion.article
                    key={w.id}
                    initial={{ opacity: 0, y: 14 }}
                    whileInView={{ opacity: 1, y: 0 }}
                    viewport={{ once: true, margin: "-40px" }}
                    transition={{ duration: 0.38, ease: [0.22, 1, 0.36, 1] }}
                    className="w-full mb-3 sm:mb-4 break-inside-avoid rounded-card border border-border bg-bg/80 overflow-hidden card-glow transition-all duration-300 hover:-translate-y-1 text-left"
                  >
                    <div className="w-full">
                      <button
                        type="button"
                        onClick={() => openWork(w)}
                        className="block w-full"
                        aria-label="Pré-visualizar imagem"
                      >
                        <div className="relative w-full">
                          {!loadedImages[w.id] ? (
                            <div className="absolute inset-0 bg-bg/60 animate-pulse" />
                          ) : null}
                          <img
                            src={w.src}
                            alt={w.title}
                            className={
                              "w-full h-auto block transition-opacity duration-300 " +
                              (loadedImages[w.id] ? "opacity-100" : "opacity-0")
                            }
                            loading="lazy"
                            decoding="async"
                            onLoad={() => markLoaded(w.id)}
                          />
                        </div>
                      </button>
                    </div>
                  </motion.article>
                ))}
              </div>
            </div>
          ))}
        </div>
      ) : (
        <div className="columns-2 sm:columns-2 lg:columns-3 gap-3 sm:gap-4 [column-fill:_balance]">
          {filteredWorks.map((w) => (
            <motion.article
              key={w.id}
              initial={{ opacity: 0, y: 14 }}
              whileInView={{ opacity: 1, y: 0 }}
              viewport={{ once: true, margin: "-40px" }}
              transition={{ duration: 0.38, ease: [0.22, 1, 0.36, 1] }}
              className="w-full mb-3 sm:mb-4 break-inside-avoid rounded-card border border-border bg-bg/80 overflow-hidden card-glow transition-all duration-300 hover:-translate-y-1 text-left"
            >
              <div className="w-full">
                <button
                  type="button"
                  onClick={() => openWork(w)}
                  className="block w-full"
                  aria-label={`Pré-visualizar ${w.title}`}
                >
                  <div className="relative w-full">
                    {!loadedImages[w.id] ? (
                      <div className="absolute inset-0 bg-bg/60 animate-pulse" />
                    ) : null}
                    <img
                      src={w.src}
                      alt={w.title}
                      className={
                        "w-full h-auto block transition-opacity duration-300 " +
                        (loadedImages[w.id] ? "opacity-100" : "opacity-0")
                      }
                      loading="lazy"
                      decoding="async"
                      onLoad={() => markLoaded(w.id)}
                    />
                  </div>
                </button>
              </div>
              <div className="p-2 sm:p-3">
                <p className="font-display font-semibold text-xs sm:text-sm truncate">{w.title}</p>
                {w.description && (
                  <p className="font-mono text-[9px] sm:text-[10px] text-text-secondary mt-1 leading-relaxed">
                    {w.description}
                  </p>
                )}
              </div>
            </motion.article>
          ))}
        </div>
      )}

      <ImageModal
        isOpen={open}
        onClose={() => setOpen(false)}
        title={selectedWork?.title}
        src={selectedWork?.src}
      />
    </section>
  );
}
