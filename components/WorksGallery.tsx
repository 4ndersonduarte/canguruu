"use client";

import { useMemo, useState } from "react";
import { motion } from "framer-motion";
import ImageModal from "@/components/ImageModal";

type Work = {
  id: string;
  title: string;
  src: string;
  description: string;
  category: "Identidade" | "Social" | "Web" | "Motion";
};

const WHATSAPP_NUMBER = "5574998094104";

export default function WorksGallery() {
  const works: Work[] = useMemo(
    () => [
      {
        id: "acelerabanner",
        title: "Acelera Coração",
        src: "/trabalhos/aceleracoracao.webp",
        description: "Banner promocional (campanha).",
        category: "Social",
      },
      {
        id: "canguruu",
        title: "Canguruu",
        src: "/trabalhos/canguruu.webp",
        description: "Arte e identidade visual para marca Canguruu.",
        category: "Identidade",
      },
      {
        id: "canguruulogo",
        title: "Canguruu Logo",
        src: "/trabalhos/canguruulogo.webp",
        description: "Logo Canguruu (versão final).",
        category: "Identidade",
      },
      {
        id: "dilab",
        title: "Dilab",
        src: "/trabalhos/dilab.webp",
        description: "Design de materiais promocionais e institucionais.",
        category: "Social",
      },
      {
        id: "dilab3",
        title: "Dilab",
        src: "/trabalhos/dilab3.webp",
        description: "Design de materiais promocionais e institucionais.",
        category: "Social",
      },
      {
        id: "dilabagenda",
        title: "Dilab",
        src: "/trabalhos/dilabagenda.webp",
        description: "Design de materiais promocionais e institucionais.",
        category: "Social",
      },
      {
        id: "forno",
        title: "Forno de Ouro",
        src: "/trabalhos/forno.webp",
        description: "Materiais institucionais e branding.",
        category: "Identidade",
      },
      {
        id: "forno1",
        title: "Forno de Ouro",
        src: "/trabalhos/forno1.webp",
        description: "Materiais institucionais e branding.",
        category: "Identidade",
      },
      {
        id: "forno2",
        title: "Forno de Ouro",
        src: "/trabalhos/forno2.webp",
        description: "Materiais institucionais e branding.",
        category: "Identidade",
      },
      {
        id: "forno3",
        title: "Forno de Ouro",
        src: "/trabalhos/forno3.webp",
        description: "Materiais institucionais e branding.",
        category: "Identidade",
      },
      {
        id: "cupons",
        title: "Cupom Acelera Coração",
        src: "/trabalhos/cupons.webp",
        description: "Cupom criado para campanha Acelera Coração.",
        category: "Social",
      },
      {
        id: "lojaonline",
        title: "Loja Online",
        src: "/trabalhos/lojaonline.webp",
        description: "Layout/arte para vitrine e loja online.",
        category: "Web",
      },
    ],
    []
  );

  const categories = useMemo(() => {
    const set = new Set<Work["category"]>();
    works.forEach((w) => set.add(w.category));
    return ["Todos" as const, ...Array.from(set)];
  }, [works]);

  const [activeCategory, setActiveCategory] = useState<(typeof categories)[number]>("Todos");
  const [open, setOpen] = useState(false);
  const [selected, setSelected] = useState<Work | null>(null);

  const filteredWorks = useMemo(() => {
    if (activeCategory === "Todos") return works;
    return works.filter((w) => w.category === activeCategory);
  }, [activeCategory, works]);

  const openWork = (w: Work) => {
    setSelected(w);
    setOpen(true);
  };

  const whatsappHref = selected
    ? `https://wa.me/${WHATSAPP_NUMBER}?text=${encodeURIComponent(
        `Olá! Gostaria de um orçamento baseado no trabalho: ${selected.title}.\n\nDetalhes: ${selected.description}`
      )}`
    : `https://wa.me/${WHATSAPP_NUMBER}`;

  return (
    <section id="trabalhos" className="py-12 sm:py-16 px-4 sm:px-6 lg:px-8 max-w-6xl mx-auto">
      <motion.h2
        initial={false}
        whileInView={{ opacity: 1, y: 0 }}
        viewport={{ once: true }}
        className="font-display text-2xl md:text-3xl font-bold mb-6"
      >
        <span className="scribble-underline">Trabalhos</span>
      </motion.h2>

      <div className="flex flex-wrap gap-2 mb-6">
        {categories.map((c) => (
          <button
            key={c}
            type="button"
            onClick={() => setActiveCategory(c)}
            className={`font-mono text-xs px-3 py-2 rounded-btn border border-border transition-colors ${
              activeCategory === c ? "bg-primary text-secondary" : "bg-bg/50 text-text-secondary hover:text-text-primary"
            }`}
            aria-label={`Filtrar por ${c}`}
          >
            {c}
          </button>
        ))}
      </div>

      <div className="columns-2 sm:columns-2 lg:columns-3 gap-3 sm:gap-4 [column-fill:_balance]">
        {filteredWorks.map((w) => (
          <motion.article
            key={w.id}
            initial={false}
            whileInView={{ opacity: 1, y: 0 }}
            viewport={{ once: true, margin: "-40px" }}
            transition={{ duration: 0.25 }}
            onClick={() => openWork(w)}
            role="button"
            tabIndex={0}
            onKeyDown={(e) => {
              if (e.key === "Enter" || e.key === " ") {
                e.preventDefault();
                openWork(w);
              }
            }}
            className="cursor-pointer w-full mb-3 sm:mb-4 break-inside-avoid rounded-card border border-border bg-bg/80 overflow-hidden card-glow transition-all duration-300 hover:-translate-y-1 text-left"
          >
            <div className="w-full">
              <img src={w.src} alt={w.title} className="w-full h-auto block" loading="lazy" />
            </div>
            <div className="p-2 sm:p-3">
              <p className="font-display font-semibold text-xs sm:text-sm truncate">{w.title}</p>
              <p className="font-mono text-[9px] sm:text-[10px] text-text-secondary mt-1">[{w.category}]</p>
              <p className="font-mono text-[9px] sm:text-[10px] text-text-secondary mt-1 leading-relaxed">
                {w.description}
              </p>
            </div>
          </motion.article>
        ))}
      </div>

      <ImageModal
        isOpen={open}
        onClose={() => setOpen(false)}
        title={selected?.title}
        showTitle
        showCloseButton
      >
        <div className="w-full h-full flex flex-col min-h-0">
          {selected?.src ? (
            <div className="flex-1 min-h-0 bg-secondary">
              <img src={selected.src} alt={selected.title} className="w-full h-full object-contain" />
            </div>
          ) : null}
          <div className="shrink-0 p-4 border-t border-border bg-bg">
            <p className="font-mono text-xs text-text-secondary mb-3">{selected?.description}</p>
            <a
              href={whatsappHref}
              target="_blank"
              rel="noopener noreferrer"
              className="font-mono inline-flex items-center justify-center gap-2 w-full px-4 py-3 rounded-btn bg-primary text-secondary font-medium border border-border hover:shadow-glow hover:-translate-y-0.5 transition-all"
            >
              Quero algo assim (WhatsApp)
            </a>
          </div>
        </div>
      </ImageModal>
    </section>
  );
}
