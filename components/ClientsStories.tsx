"use client";

import { useMemo, useState } from "react";
import { motion } from "framer-motion";
import ImageModal from "./ImageModal";

type Client = {
  id: string;
  name: string;
  logoSrc: string;
  stories: string[];
};

export default function ClientsStories() {
  const clients: Client[] = useMemo(
    () => [
      {
        id: "bmpes",
        name: "BMPES",
        logoSrc: "/clientes/bmpes.webp",
        stories: ["/clientes/stories/bmpes/bmstory.webp"],
      },
      {
        id: "hiper",
        name: "Hipermercado Coração",
        logoSrc: "/clientes/hiper.webp",
        stories: ["/clientes/stories/hiper/hiper.webp"],
      },
      {
        id: "viladegust",
        name: "Vila Degust",
        logoSrc: "/clientes/rai.webp",
        stories: ["/clientes/stories/viladegust/viladegust.webp"],
      },
      {
        id: "taine",
        name: "TD Boutique Closet",
        logoSrc: "/clientes/taine.webp",
        stories: [],
      },
    ],
    []
  );

  const [open, setOpen] = useState(false);
  const [selected, setSelected] = useState<Client | null>(null);

  const openClient = (c: Client) => {
    setSelected(c);
    setOpen(true);
    window.dispatchEvent(new CustomEvent("wa-fab-visible", { detail: { visible: false } }));
  };

  const closeModal = () => {
    setOpen(false);
    window.dispatchEvent(new CustomEvent("wa-fab-visible", { detail: { visible: true } }));
  };

  return (
    <section className="py-12 sm:py-16 px-4 sm:px-6 lg:px-8 max-w-6xl mx-auto">
      <motion.h2
        initial={false}
        whileInView={{ opacity: 1, y: 0 }}
        viewport={{ once: true }}
        className="font-display text-2xl md:text-3xl font-bold mb-6"
      >
        <span className="scribble-underline">Clientes</span>
      </motion.h2>

      <div className="-mx-2 px-2 sm:mx-0 sm:px-0">
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
                  <img src={c.logoSrc} alt={c.name} className="w-full h-full object-cover" />
                </div>
              </div>
              <p className="font-mono text-[9px] sm:text-xs text-text-secondary mt-1.5 text-center max-w-16 sm:max-w-20 truncate">
                {c.name}
              </p>
            </button>
          ))}
        </div>
      </div>

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
            <div className="flex-1 overflow-y-auto snap-y snap-mandatory">
              {selected.stories.map((src, idx) => (
                <div key={`${selected.id}-${idx}`} className="w-full h-full snap-start">
                  <img
                    src={src}
                    alt={`${selected.name} ${idx + 1}`}
                    className="w-full h-full object-contain bg-secondary"
                    loading="eager"
                  />
                </div>
              ))}
            </div>
          ) : (
            <div className="flex-1 flex items-center justify-center px-6 text-center">
              <div>
                <p className="font-display text-bg text-lg font-semibold">Stories 9:16</p>
                <p className="font-mono text-xs text-bg/80 mt-2">
                  Em breve: imagens por cliente (ex: /stories/{selected?.id}/001.jpg)
                </p>
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
