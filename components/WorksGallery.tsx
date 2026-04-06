"use client";

import { useMemo, useState } from "react";
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

export default function WorksGallery() {
  const [selectedTab, setSelectedTab] = useState<"Trabalhos" | "Identidade visual">("Trabalhos");
  const [selectedClient, setSelectedClient] = useState<string>("Todos");
  const [open, setOpen] = useState(false);
  const [selectedWork, setSelectedWork] = useState<Work | null>(null);

  const clientBadges = useMemo(() => {
    return {
      "Vila Degust": {
        src: "/clientes/logotipos/viladegust.webp",
        alt: "Vila Degust",
      },
    } as Record<string, { src: string; alt: string }>;
  }, []);

  const works: Work[] = useMemo(
    () => [
      {
        id: "acelerabanner",
        title: "Acelera Coração",
        src: "/trabalhos/aceleracoracao.webp",
        description: "Banner promocional (campanha).",
        client: "Acelera Coração",
      },
      {
        id: "canguruu",
        title: "Canguruu",
        src: "/trabalhos/canguruu.webp",
        description: "Arte e identidade visual para marca Canguruu.",
        client: "Canguruu",
      },
      {
        id: "canguruulogo",
        title: "Canguruu Logo",
        src: "/trabalhos/canguruulogo.webp",
        description: "Logo Canguruu (versão final).",
        client: "Canguruu",
      },
      {
        id: "dilab",
        title: "Dilab",
        src: "/trabalhos/dilab.webp",
        description: "Design de materiais promocionais e institucionais.",
        client: "Dilab",
      },
      {
        id: "dilab3",
        title: "Dilab",
        src: "/trabalhos/dilab3.webp",
        description: "Design de materiais promocionais e institucionais.",
        client: "Dilab",
      },
      {
        id: "dilabagenda",
        title: "Dilab",
        src: "/trabalhos/dilabagenda.webp",
        description: "Design de materiais promocionais e institucionais.",
        client: "Dilab",
      },
      {
        id: "forno",
        title: "Forno de Ouro",
        src: "/trabalhos/forno.webp",
        description: "Materiais institucionais e branding.",
        client: "Forno de Ouro",
      },
      {
        id: "forno1",
        title: "Forno de Ouro",
        src: "/trabalhos/forno1.webp",
        description: "Materiais institucionais e branding.",
        client: "Forno de Ouro",
      },
      {
        id: "forno2",
        title: "Forno de Ouro",
        src: "/trabalhos/forno2.webp",
        description: "Materiais institucionais e branding.",
        client: "Forno de Ouro",
      },
      {
        id: "forno3",
        title: "Forno de Ouro",
        src: "/trabalhos/forno3.webp",
        description: "Materiais institucionais e branding.",
        client: "Forno de Ouro",
      },
      {
        id: "cupons",
        title: "Cupom Acelera Coração",
        src: "/trabalhos/cupons.webp",
        description: "Cupom criado para campanha Acelera Coração.",
        client: "Acelera Coração",
      },
      {
        id: "lojaonline",
        title: "Loja Online",
        src: "/trabalhos/lojaonline.webp",
        description: "Layout/arte para vitrine e loja online.",
        client: "Loja Online",
      },
    ],
    []
  );

  const identityWorks: Work[] = useMemo(
    () => [
      {
        id: "vila1",
        title: "Identidade visual",
        src: "/trabalhos/identidade%20visual/vila1.webp",
        description: "",
        client: "Vila Degust",
        badgeSrc: clientBadges["Vila Degust"]?.src,
        badgeAlt: clientBadges["Vila Degust"]?.alt,
      },
      {
        id: "vila2",
        title: "Identidade visual",
        src: "/trabalhos/identidade%20visual/vila2.webp",
        description: "",
        client: "Vila Degust",
        badgeSrc: clientBadges["Vila Degust"]?.src,
        badgeAlt: clientBadges["Vila Degust"]?.alt,
      },
      {
        id: "vila3",
        title: "Identidade visual",
        src: "/trabalhos/identidade%20visual/vila3.webp",
        description: "",
        client: "Vila Degust",
        badgeSrc: clientBadges["Vila Degust"]?.src,
        badgeAlt: clientBadges["Vila Degust"]?.alt,
      },
      {
        id: "vila4",
        title: "Identidade visual",
        src: "/trabalhos/identidade%20visual/vila4.webp",
        description: "",
        client: "Vila Degust",
        badgeSrc: clientBadges["Vila Degust"]?.src,
        badgeAlt: clientBadges["Vila Degust"]?.alt,
      },
      {
        id: "vila5",
        title: "Identidade visual",
        src: "/trabalhos/identidade%20visual/vila5.webp",
        description: "",
        client: "Vila Degust",
        badgeSrc: clientBadges["Vila Degust"]?.src,
        badgeAlt: clientBadges["Vila Degust"]?.alt,
      },
      {
        id: "vila6",
        title: "Identidade visual",
        src: "/trabalhos/identidade%20visual/vila6.webp",
        description: "",
        client: "Vila Degust",
        badgeSrc: clientBadges["Vila Degust"]?.src,
        badgeAlt: clientBadges["Vila Degust"]?.alt,
      },
      {
        id: "vila7",
        title: "Identidade visual",
        src: "/trabalhos/identidade%20visual/vila7.webp",
        description: "",
        client: "Vila Degust",
        badgeSrc: clientBadges["Vila Degust"]?.src,
        badgeAlt: clientBadges["Vila Degust"]?.alt,
      },
    ],
    [clientBadges]
  );

  const clients = useMemo(() => {
    const unique = Array.from(new Set(works.map((w) => w.client)));
    return ["Todos", ...unique];
  }, [works]);

  const filteredWorks = useMemo(() => {
    if (selectedTab === "Identidade visual") return identityWorks;
    if (selectedClient === "Todos") return works;
    return works.filter((w) => w.client === selectedClient);
  }, [identityWorks, selectedClient, selectedTab, works]);

  const openWork = (w: Work) => {
    setSelectedWork(w);
    setOpen(true);
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

      <div className="columns-2 sm:columns-2 lg:columns-3 gap-3 sm:gap-4 [column-fill:_balance]">
        {filteredWorks.map((w) => (
          <motion.article
            key={w.id}
            initial={{ opacity: 0, y: 14 }}
            whileInView={{ opacity: 1, y: 0 }}
            viewport={{ once: true, margin: "-40px" }}
            transition={{ duration: 0.38, ease: [0.22, 1, 0.36, 1] }}
            className="relative w-full mb-3 sm:mb-4 break-inside-avoid rounded-card border border-border bg-bg/80 overflow-hidden card-glow transition-all duration-300 hover:-translate-y-1 text-left"
          >
            {selectedTab === "Identidade visual" && w.badgeSrc && (
              <div className="pointer-events-none absolute top-2 left-2 z-10">
                <div className="w-9 h-9 sm:w-10 sm:h-10 rounded-full bg-bg/90 border border-border overflow-hidden">
                  <img src={w.badgeSrc} alt={w.badgeAlt || w.client} className="w-full h-full object-cover" loading="lazy" />
                </div>
              </div>
            )}
            <div className="w-full">
              <button
                type="button"
                onClick={() => openWork(w)}
                className="block w-full"
                aria-label={`Pré-visualizar ${w.title}`}
              >
                <img src={w.src} alt={w.title} className="w-full h-auto block" loading="lazy" />
              </button>
            </div>
            {selectedTab !== "Identidade visual" && (
              <div className="p-2 sm:p-3">
                <p className="font-display font-semibold text-xs sm:text-sm truncate">{w.title}</p>
                {w.description && (
                  <p className="font-mono text-[9px] sm:text-[10px] text-text-secondary mt-1 leading-relaxed">
                    {w.description}
                  </p>
                )}
              </div>
            )}
          </motion.article>
        ))}
      </div>

      <ImageModal
        isOpen={open}
        onClose={() => setOpen(false)}
        title={selectedWork?.title}
        src={selectedWork?.src}
      />
    </section>
  );
}
