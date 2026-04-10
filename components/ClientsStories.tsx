"use client";

import { useEffect, useMemo, useState } from "react";
import { motion } from "framer-motion";
import ImageModal from "./ImageModal";

type Client = {
  id: string;
  name: string;
  logoSrc: string;
  stories: string[];
};

type ApiStory = {
  id: string;
  client_id: string;
  url: string;
  alt: string | null;
  sort_order: number;
  created_at: string;
  preview_url: string | null;
};

type ApiClient = {
  id: string;
  name: string;
  slug: string;
  logo_url: string | null;
  story_icon_url: string | null;
  created_at: string;
  stories: ApiStory[];
};

export default function ClientsStories() {
  const [clients, setClients] = useState<Client[]>([]);
  const [apiError, setApiError] = useState<string | null>(null);

  const storyDurationMs = 5000;

  useEffect(() => {
    let mounted = true;

    const run = async () => {
      try {
        const res = await fetch("/api/public/clients", { cache: "no-store" });
        const text = await res.text();
        let json: { clients?: ApiClient[]; error?: string } | null = null;

        try {
          json = JSON.parse(text) as { clients?: ApiClient[]; error?: string };
        } catch {
          json = null;
        }

        if (!mounted) return;

        if (!res.ok) {
          setApiError(
            json?.error ?? `Falha ao carregar clientes (HTTP ${res.status}).`
          );
          setClients([]);
          return;
        }

        const mapped: Client[] = (json?.clients ?? []).map((c) => {
          const icon = c.story_icon_url || c.logo_url || "";
          const logoSrc = icon || "";
          const stories = (c.stories ?? [])
            .map((s) => s.preview_url)
            .filter((u): u is string => Boolean(u));

          return {
            id: c.slug || c.id,
            name: c.name,
            logoSrc,
            stories,
          };
        });

        setClients(mapped);
        setApiError(null);
      } catch {
        if (!mounted) return;
        setApiError("Falha ao carregar clientes.");
        setClients([]);
      }
    };

    run();

    return () => {
      mounted = false;
    };
  }, []);

  const [open, setOpen] = useState(false);
  const [selected, setSelected] = useState<Client | null>(null);
  const [activeIdx, setActiveIdx] = useState(0);
  const [progress, setProgress] = useState(0);
  const [pressing, setPressing] = useState(false);

  const storyCount = selected?.stories.length ?? 0;
  const activeSrc = selected?.stories[activeIdx] ?? null;

  const progressWidth = useMemo(() => {
    const p = Number.isFinite(progress) ? Math.min(1, Math.max(0, progress)) : 0;
    return `${p * 100}%`;
  }, [progress]);

  const openClient = (c: Client) => {
    setSelected(c);
    setActiveIdx(0);
    setProgress(0);
    setOpen(true);
  };

  const closeModal = () => {
    setOpen(false);
    setPressing(false);
    setProgress(0);
    setActiveIdx(0);
  };

  const goPrev = () => {
    if (!selected) return;
    setProgress(0);
    setActiveIdx((i) => Math.max(0, i - 1));
  };

  const goNext = () => {
    if (!selected) return;
    setProgress(0);
    setActiveIdx((i) => {
      const next = i + 1;
      if (next >= (selected.stories?.length ?? 0)) {
        closeModal();
        return i;
      }
      return next;
    });
  };

  useEffect(() => {
    if (!open || !selected || storyCount === 0) return;
    if (pressing) return;

    let raf = 0;
    let start = performance.now();

    const tick = (now: number) => {
      const elapsed = now - start;
      const next = elapsed / storyDurationMs;
      if (next >= 1) {
        setProgress(1);
        goNext();
        return;
      }
      setProgress(next);
      raf = requestAnimationFrame(tick);
    };

    raf = requestAnimationFrame(tick);
    return () => {
      cancelAnimationFrame(raf);
      start = 0;
    };
  }, [open, selected, activeIdx, pressing, storyCount]);

  useEffect(() => {
    if (!open) return;

    const onKeyDown = (e: KeyboardEvent) => {
      if (e.key === "ArrowLeft") goPrev();
      if (e.key === "ArrowRight") goNext();
    };

    window.addEventListener("keydown", onKeyDown);
    return () => window.removeEventListener("keydown", onKeyDown);
  }, [open, selected]);

  return (
    <section className="py-12 sm:py-16 px-4 sm:px-6 lg:px-8 max-w-6xl mx-auto">
      <motion.h2
        initial={{ opacity: 0, y: 14 }}
        whileInView={{ opacity: 1, y: 0 }}
        viewport={{ once: true }}
        transition={{ duration: 0.45, ease: [0.22, 1, 0.36, 1] }}
        className="font-display text-2xl md:text-3xl font-bold mb-6"
      >
        <span className="scribble-underline">Clientes</span>
      </motion.h2>

      <motion.div
        initial={{ opacity: 0, y: 10 }}
        whileInView={{ opacity: 1, y: 0 }}
        viewport={{ once: true, margin: "-40px" }}
        transition={{ duration: 0.38, ease: [0.22, 1, 0.36, 1] }}
        className="-mx-2 px-2 sm:mx-0 sm:px-0"
      >
        {apiError ? (
          <div className="text-sm text-red-500 mb-4">{apiError}</div>
        ) : null}
        <div className="flex gap-3 overflow-x-auto pb-2 snap-x snap-mandatory">
          {clients.map((c) => (
            <button
              key={c.id}
              onClick={() => openClient(c)}
              className="snap-start shrink-0 group"
              aria-label={`Abrir trabalhos de ${c.name}`}
            >
              <div className="relative w-14 h-14 sm:w-20 sm:h-20 rounded-full group-hover:shadow-glow transition-shadow">
                <div className="absolute inset-0 rounded-full bg-gradient-to-tr from-primary via-amber-400 to-pink-500 animate-[spin_10s_linear_infinite] motion-reduce:animate-none pointer-events-none" />
                <div className="absolute inset-[3px] sm:inset-[4px] rounded-full bg-bg/90 border border-border overflow-hidden">
                  {c.logoSrc ? (
                    <img src={c.logoSrc} alt={c.name} className="w-full h-full object-cover" />
                  ) : (
                    <div className="w-full h-full" />
                  )}
                </div>
              </div>
              <p className="font-mono text-[9px] sm:text-xs text-text-secondary mt-1.5 text-center max-w-16 sm:max-w-20 truncate">
                {c.name}
              </p>
            </button>
          ))}
        </div>
      </motion.div>

      <ImageModal
        isOpen={open}
        onClose={closeModal}
        title={selected ? `${selected.name} • Stories` : "Stories"}
        aspectClassName="max-w-sm aspect-[9/16]"
        showCloseButton={false}
        showTitle={false}
      >
        <div className="w-full h-full flex flex-col bg-bg">
          {selected && selected.stories.length > 0 ? (
            <div className="relative flex-1 min-h-0 bg-bg">
              <div className="absolute top-0 left-0 right-0 z-10 px-3 pt-3">
                <div className="flex gap-1">
                  {selected.stories.map((_, idx) => {
                    const isDone = idx < activeIdx;
                    const isActive = idx === activeIdx;
                    return (
                      <div key={`${selected.id}-bar-${idx}`} className="flex-1 h-1 rounded-full bg-white/25 overflow-hidden">
                        <div
                          className="h-full bg-white"
                          style={{
                            width: isDone ? "100%" : isActive ? progressWidth : "0%",
                            transition: isActive ? "none" : "width 120ms linear",
                          }}
                        />
                      </div>
                    );
                  })}
                </div>
              </div>

              <div
                className="absolute inset-0"
                onMouseDown={() => setPressing(true)}
                onMouseUp={() => setPressing(false)}
                onMouseLeave={() => setPressing(false)}
                onTouchStart={() => setPressing(true)}
                onTouchEnd={() => setPressing(false)}
              >
                <div className="absolute inset-0 grid grid-cols-2">
                  <button
                    type="button"
                    onClick={goPrev}
                    className="w-full h-full"
                    aria-label="Story anterior"
                  />
                  <button
                    type="button"
                    onClick={goNext}
                    className="w-full h-full"
                    aria-label="Próximo story"
                  />
                </div>

                {activeSrc ? (
                  <img
                    src={activeSrc}
                    alt={`${selected.name} ${activeIdx + 1}`}
                    className="w-full h-full object-cover"
                    loading="eager"
                    draggable={false}
                  />
                ) : null}
              </div>
            </div>
          ) : (
            <div className="flex-1 flex items-center justify-center px-6 text-center">
              <div>
                <p className="font-display text-bg text-lg font-semibold">Stories 9:16</p>
              </div>
            </div>
          )}

          {selected && (
            <div className="border-t border-border/30 bg-bg/95 px-4 py-3">
              <div className="flex items-center justify-between">
                <div className="flex items-center gap-3 min-w-0 flex-1">
                  <div className="relative w-10 h-10 rounded-full">
                    <div className="absolute inset-0 rounded-full bg-gradient-to-tr from-primary via-amber-400 to-pink-500 animate-[spin_10s_linear_infinite] motion-reduce:animate-none pointer-events-none" />
                    <div className="absolute inset-[3px] rounded-full bg-bg border border-border overflow-hidden">
                      <img src={selected.logoSrc} alt={selected.name} className="w-full h-full object-cover" />
                    </div>
                  </div>
                  <div className="min-w-0">
                    <p className="font-display font-semibold text-sm text-secondary truncate">{selected.name}</p>
                    <p className="font-mono text-[10px] text-text-secondary truncate">
                      {selected.stories.length > 0 ? `${selected.stories.length} itens` : "Conteúdo em breve"}
                    </p>
                  </div>
                </div>
                <button
                  onClick={closeModal}
                  className="font-mono text-xs px-3 py-1.5 rounded-btn bg-primary text-secondary font-medium border border-border hover:shadow-glow hover:-translate-y-0.5 transition-all"
                  aria-label="Fechar"
                >
                  Fechar
                </button>
              </div>
            </div>
          )}
        </div>
      </ImageModal>
    </section>
  );
}
