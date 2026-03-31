"use client";

import { useState } from "react";
import { motion } from "framer-motion";
import VideoModal from "./VideoModal";

const container = {
  hidden: { opacity: 0 },
  show: {
    opacity: 1,
    transition: { staggerChildren: 0.08, delayChildren: 0.1 },
  },
};

const item = {
  hidden: { y: 20, opacity: 0 },
  show: { y: 0, opacity: 1 },
};

function ProjectImagePlaceholder({ label }: { label: string }) {
  return (
    <div className="w-full aspect-square bg-bg border-b border-border flex items-center justify-center relative overflow-hidden">
      <div className="absolute inset-0 opacity-30">
        <div className="absolute -top-16 -left-16 w-56 h-56 rounded-full bg-primary/20 blur-3xl" />
        <div className="absolute -bottom-16 -right-16 w-56 h-56 rounded-full bg-primary/15 blur-3xl" />
      </div>
      <div className="relative text-center px-6">
        <p className="font-mono text-xs text-text-secondary">Imagem 1080×1080</p>
        <p className="font-display font-semibold text-secondary mt-1">{label}</p>
        <p className="font-mono text-[10px] text-text-secondary mt-2">(substituir depois)</p>
      </div>
    </div>
  );
}

const projects = [
  {
    id: "duca",
    title: "Duca - Gestão Financeira",
    type: "App",
    tags: ["Flutter", "Supabase"],
    description: "App de gestão financeira pessoal com dashboard intuitivo e sincronização em nuvem.",
    visual: "app", // mockup style
  },
  {
    id: "oxente",
    title: "Oxente Cupons",
    type: "Design / Comunidade",
    tags: ["Branding", "Telegram"],
    description: "Logo e mascote para comunidade de cupons. Identidade visual que conecta.",
    visual: "logo",
  },
  {
    id: "showreel",
    title: "Showreel 2024",
    type: "Vídeo",
    tags: ["Motion", "Edição"],
    description: "Reel com os melhores trabalhos de edição e motion do ano.",
    visual: "video",
    videoUrl: "https://www.youtube.com/embed/dQw4w9WgXcQ?autoplay=1",
  },
];

export default function Projects() {
  const [videoOpen, setVideoOpen] = useState(false);
  const [videoUrl, setVideoUrl] = useState<string | undefined>();

  const openVideo = (url?: string) => {
    setVideoUrl(url);
    setVideoOpen(true);
  };

  return (
    <section id="trabalhos" className="py-16 px-4 sm:px-6 lg:px-8 max-w-6xl mx-auto">
      <motion.h2
        initial={{ opacity: 0, y: 16 }}
        whileInView={{ opacity: 1, y: 0 }}
        viewport={{ once: true }}
        className="font-display text-2xl md:text-3xl font-bold mb-8"
      >
        <span className="scribble-underline">Projetos em Destaque</span>
      </motion.h2>
      <motion.div
        variants={container}
        initial="hidden"
        whileInView="show"
        viewport={{ once: true, margin: "-40px" }}
        className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4"
      >
        {projects.map((p) => (
          <motion.article
            key={p.id}
            variants={item}
            className="rounded-card border border-border bg-bg/80 overflow-hidden card-glow transition-all duration-300 hover:-translate-y-1 flex flex-col"
          >
            <ProjectImagePlaceholder label={p.title} />
            <div className="p-4 flex flex-col flex-1">
              <p className="font-mono text-xs text-text-secondary mb-2">[{p.type}]</p>
              <div className="flex flex-wrap gap-2 mb-2">
                {p.tags.map((tag) => (
                  <span
                    key={tag}
                    className="font-mono text-xs px-2 py-0.5 rounded bg-border text-text-secondary"
                  >
                    [{tag}]
                  </span>
                ))}
              </div>
              <h3 className="font-display font-semibold text-lg mb-1">{p.title}</h3>
              <p className="text-text-secondary text-sm flex-1">{p.description}</p>
              {p.visual === "video" && (
                <button
                  onClick={() => openVideo(p.videoUrl)}
                  className="font-mono text-sm mt-4 px-4 py-3 sm:py-2 rounded-btn bg-secondary text-bg font-medium w-full sm:w-fit hover:shadow-glow hover:-translate-y-0.5 transition-all"
                  aria-label="Assistir vídeo"
                >
                  Assistir
                </button>
              )}
              <a
                href="#contato"
                className="font-mono text-sm mt-3 px-4 py-3 sm:py-2 rounded-btn bg-primary text-secondary font-medium border border-border w-full sm:w-fit hover:shadow-glow hover:-translate-y-0.5 transition-all"
              >
                Quero um projeto assim
              </a>
            </div>
          </motion.article>
        ))}
      </motion.div>
      <VideoModal isOpen={videoOpen} onClose={() => setVideoOpen(false)} videoUrl={videoUrl} />
    </section>
  );
}
