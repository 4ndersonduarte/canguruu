"use client";

import { motion } from "framer-motion";

const container = {
  hidden: { opacity: 0 },
  show: {
    opacity: 1,
    transition: { staggerChildren: 0.1, delayChildren: 0.2 },
  },
};

const item = {
  hidden: { y: 24, opacity: 0 },
  show: { y: 0, opacity: 1 },
};

const services = [
  {
    label: "Artes, Flyers & Campanhas",
    mono: "[Supermercado • Farmácia • Lanchonete]",
    description:
      "Criativos que chamam atenção: promoções, encartes, combos, banners e campanhas para redes sociais e impressão. Layouts pensados pra vender e pra destacar ofertas.",
    examples: "Ex: promo do dia, encarte, combo, cardápio, banner e status",
    icon: (
      <svg className="w-8 h-8" fill="none" stroke="currentColor" viewBox="0 0 24 24">
        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={1.5} d="M7 7h10M7 11h6M7 15h10" />
        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={1.5} d="M6 3h12a2 2 0 012 2v14l-4-2-4 2-4-2-4 2V5a2 2 0 012-2z" />
      </svg>
    ),
  },
  {
    label: "Identidade Visual",
    mono: "[Mockups • Cardápios • Elementos]",
    description:
      "Criação de identidade visual e elementos que dão padrão: mockups de produtos, cardápios, destaques, peças e templates para você manter consistência em tudo.",
    examples: "Ex: mockup de produto, cardápio, templates e destaques",
    icon: (
      <svg className="w-8 h-8" fill="none" stroke="currentColor" viewBox="0 0 24 24">
        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={1.5} d="M7 21a4 4 0 01-4-4V5a2 2 0 012-2h4a2 2 0 012 2v12a4 4 0 01-4 4zm0 0h12a2 2 0 002-2v-4a2 2 0 00-2-2h-2.343M11 7.343l1.657-1.657a2 2 0 012.828 0l2.829 2.829a2 2 0 010 2.828l-8.486 8.485M7 17h.01" />
      </svg>
    ),
  },
  {
    label: "UI/UX & App Dev",
    mono: "[Sites • React • Flutter]",
    description:
      "Desenvolvimento de sites e apps (web/React e Flutter Android). Soluções para comércios, gestão de negócio, páginas de oferta, cardápios online e muito mais.",
    examples: "Ex: site pra comércio, catálogo, cardápio online, gestão",
    icon: (
      <svg className="w-8 h-8" fill="none" stroke="currentColor" viewBox="0 0 24 24">
        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={1.5} d="M9.75 17L9 20l-1 1h8l-1-1-.75-3M3 13h18M5 17h14a2 2 0 002-2V5a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z" />
        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={1.5} d="M14 7h-4M14 11h-4" />
      </svg>
    ),
  },
  {
    label: "Edição de Vídeo & Motion",
    mono: "[Cortes • Anúncios]",
    description:
      "Cortes dinâmicos, efeitos visuais e criativos para anúncios focados em conversão.",
    examples: "Ex: reels, anúncios, motion para promoções e produtos",
    icon: (
      <svg className="w-8 h-8" fill="none" stroke="currentColor" viewBox="0 0 24 24">
        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={1.5} d="M14.752 11.168l-3.197-2.132A1 1 0 0010 9.87v4.263a1 1 0 001.555.832l3.197-2.132a1 1 0 000-1.664z" />
        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={1.5} d="M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
      </svg>
    ),
  },
];

export default function Services() {
  return (
    <section id="o-que-faco" className="py-16 px-4 sm:px-6 lg:px-8 max-w-6xl mx-auto">
      <motion.h2
        initial={false}
        whileInView={{ opacity: 1, y: 0 }}
        viewport={{ once: true }}
        className="font-display text-2xl md:text-3xl font-bold mb-8"
      >
        <span className="scribble-underline">O Que Fazemos</span>
      </motion.h2>
      <motion.div
        variants={container}
        initial={false}
        whileInView="show"
        viewport={{ once: true, margin: "-60px" }}
        className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4"
      >
        {services.map((s) => (
          <motion.div
            key={s.label}
            variants={item}
            className="rounded-card border border-border bg-bg/80 p-5 sm:p-6 card-glow transition-all duration-300 hover:-translate-y-1 flex flex-col"
          >
            <div className="text-primary mb-3">{s.icon}</div>
            <p className="font-mono text-xs text-text-secondary mb-1">{s.mono}</p>
            <h3 className="font-display font-semibold text-base sm:text-lg mb-2">{s.label}</h3>
            <p className="text-text-secondary text-sm leading-relaxed">{s.description}</p>
            <p className="font-mono text-xs text-text-secondary mt-3 leading-relaxed">{s.examples}</p>
          </motion.div>
        ))}
      </motion.div>
    </section>
  );
}
