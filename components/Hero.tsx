"use client";

import { motion } from "framer-motion";

const container = {
  hidden: { opacity: 0 },
  show: {
    opacity: 1,
    transition: { staggerChildren: 0.12, delayChildren: 0.1 },
  },
};

const item = {
  hidden: { y: 20, opacity: 0 },
  show: { y: 0, opacity: 1 },
};

export default function Hero() {
  return (
    <section className="pt-32 pb-14 sm:pb-16 px-4 sm:px-6 lg:px-8 max-w-6xl mx-auto">
      <motion.div
        variants={container}
        initial={false}
        animate="show"
        className="grid grid-cols-1 gap-4 md:gap-6"
      >
        {/* Card esquerdo - Título e CTA */}
        <motion.div
          variants={item}
          className="rounded-card border border-border bg-bg/80 p-6 md:p-8 flex flex-col justify-center card-glow transition-all duration-300 hover:-translate-y-1"
        >
          <h1 className="font-display text-[2rem] sm:text-4xl md:text-5xl font-bold leading-tight mb-4">
            Da identidade visual ao seu sistema completo.
          </h1>
          <p className="text-text-secondary text-sm sm:text-base leading-relaxed mb-4 max-w-[62ch]">
            Artes e campanhas pra comércio, identidade visual, sites e apps. Um visual limpo e moderno que chama atenção e vende.
          </p>
          <p className="font-mono text-sm text-text-secondary mb-6">
            UI/UX • Web Dev • Identidade Visual • Conteúdo
          </p>
          <div className="flex flex-col sm:flex-row gap-3">
            <a
              href="#contato"
              className="font-mono inline-flex items-center justify-center gap-2 px-5 py-3 sm:py-2.5 rounded-btn bg-primary text-secondary font-medium border border-border hover:shadow-glow hover:-translate-y-0.5 transition-all w-full sm:w-fit"
            >
              Solicitar Orçamento
            </a>
            <a
              href="#trabalhos"
              className="font-mono inline-flex items-center justify-center gap-2 px-5 py-3 sm:py-2.5 rounded-btn bg-secondary text-bg font-medium border border-border hover:shadow-glow hover:-translate-y-0.5 transition-all w-full sm:w-fit"
            >
              Ver Trabalhos
            </a>
          </div>
        </motion.div>
      </motion.div>
    </section>
  );
}
