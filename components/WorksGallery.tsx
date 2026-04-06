"use client";

import { useMemo } from "react";
import { motion } from "framer-motion";

type Work = {
  id: string;
  title: string;
  src: string;
  description: string;
};

export default function WorksGallery() {
  const works: Work[] = useMemo(
    () => [
      {
        id: "acelerabanner",
        title: "Acelera Coração",
        src: "/trabalhos/aceleracoracao.webp",
        description: "Banner promocional (campanha).",
      },
      {
        id: "canguruu",
        title: "Canguruu",
        src: "/trabalhos/canguruu.webp",
        description: "Arte e identidade visual para marca Canguruu.",
      },
      {
        id: "canguruulogo",
        title: "Canguruu Logo",
        src: "/trabalhos/canguruulogo.webp",
        description: "Logo Canguruu (versão final).",
      },
      {
        id: "dilab",
        title: "Dilab",
        src: "/trabalhos/dilab.webp",
        description: "Design de materiais promocionais e institucionais.",
      },
      {
        id: "dilab3",
        title: "Dilab",
        src: "/trabalhos/dilab3.webp",
        description: "Design de materiais promocionais e institucionais.",
      },
      {
        id: "dilabagenda",
        title: "Dilab",
        src: "/trabalhos/dilabagenda.webp",
        description: "Design de materiais promocionais e institucionais.",
      },
      {
        id: "forno",
        title: "Forno de Ouro",
        src: "/trabalhos/forno.webp",
        description: "Materiais institucionais e branding.",
      },
      {
        id: "forno1",
        title: "Forno de Ouro",
        src: "/trabalhos/forno1.webp",
        description: "Materiais institucionais e branding.",
      },
      {
        id: "forno2",
        title: "Forno de Ouro",
        src: "/trabalhos/forno2.webp",
        description: "Materiais institucionais e branding.",
      },
      {
        id: "forno3",
        title: "Forno de Ouro",
        src: "/trabalhos/forno3.webp",
        description: "Materiais institucionais e branding.",
      },
      {
        id: "cupons",
        title: "Cupom Acelera Coração",
        src: "/trabalhos/cupons.webp",
        description: "Cupom criado para campanha Acelera Coração.",
      },
      {
        id: "lojaonline",
        title: "Loja Online",
        src: "/trabalhos/lojaonline.webp",
        description: "Layout/arte para vitrine e loja online.",
      },
    ],
    []
  );

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

      <div className="columns-2 sm:columns-2 lg:columns-3 gap-3 sm:gap-4 [column-fill:_balance]">
        {works.map((w) => (
          <motion.article
            key={w.id}
            initial={false}
            whileInView={{ opacity: 1, y: 0 }}
            viewport={{ once: true, margin: "-40px" }}
            transition={{ duration: 0.25 }}
            className="w-full mb-3 sm:mb-4 break-inside-avoid rounded-card border border-border bg-bg/80 overflow-hidden card-glow transition-all duration-300 hover:-translate-y-1 text-left"
          >
            <div className="w-full">
              <img src={w.src} alt={w.title} className="w-full h-auto block" loading="lazy" />
            </div>
            <div className="p-2 sm:p-3">
              <p className="font-display font-semibold text-xs sm:text-sm truncate">{w.title}</p>
              <p className="font-mono text-[9px] sm:text-[10px] text-text-secondary mt-1 leading-relaxed">
                {w.description}
              </p>
            </div>
          </motion.article>
        ))}
      </div>
    </section>
  );
}
