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
        title: "Acelera Banner",
        src: "/trabalhos/acelerabanner.png",
        description: "Banner promocional (campanha).",
      },
      {
        id: "campanha",
        title: "Campanha",
        src: "/trabalhos/campanha.png",
        description: "Peças de campanha para redes sociais.",
      },
      {
        id: "canguruu",
        title: "Canguruu",
        src: "/trabalhos/canguruu.png",
        description: "Arte e identidade visual para marca Canguruu.",
      },
      {
        id: "canguruulogo",
        title: "Canguruu Logo",
        src: "/trabalhos/canguruulogo.png",
        description: "Logo Canguruu (versão final).",
      },
      {
        id: "cardapio",
        title: "Cardápio",
        src: "/trabalhos/cardapio.png",
        description: "Cardápio com layout pronto pra imprimir e postar.",
      },
      {
        id: "cupons",
        title: "Cupons",
        src: "/trabalhos/cupons.png",
        description: "Artes de cupons/ofertas com foco em conversão.",
      },
      {
        id: "lojaonline",
        title: "Loja Online",
        src: "/trabalhos/lojaonline.png",
        description: "Layout/arte para vitrine e loja online.",
      },
      {
        id: "processo",
        title: "Processo",
        src: "/trabalhos/processo.png",
        description: "Peça de processo/etapas (conteúdo explicativo).",
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

      <div className="columns-1 sm:columns-2 lg:columns-3 gap-4 [column-fill:_balance]">
        {works.map((w) => (
          <motion.article
            key={w.id}
            initial={false}
            whileInView={{ opacity: 1, y: 0 }}
            viewport={{ once: true, margin: "-40px" }}
            transition={{ duration: 0.25 }}
            className="w-full mb-4 break-inside-avoid rounded-card border border-border bg-bg/80 overflow-hidden card-glow transition-all duration-300 hover:-translate-y-1 text-left"
          >
            <div className="w-full">
              <img src={w.src} alt={w.title} className="w-full h-auto block" loading="lazy" />
            </div>
            <div className="p-3">
              <p className="font-display font-semibold text-sm text-secondary truncate">{w.title}</p>
              <p className="font-mono text-[10px] text-text-secondary mt-1 leading-relaxed">
                {w.description}
              </p>
            </div>
          </motion.article>
        ))}
      </div>
    </section>
  );
}
