"use client";

import { useMemo } from "react";
import { motion } from "framer-motion";

type ToolLogo = {
  id: string;
  name: string;
  src: string;
};

export default function TechStack() {
  const tools: ToolLogo[] = useMemo(
    () => [
      { id: "flutter", name: "Flutter", src: "/ferramentas/flutter.png" },
      { id: "supabase", name: "Supabase", src: "/ferramentas/supabase.png" },
      { id: "photoshop", name: "Adobe Photoshop", src: "/ferramentas/photoshop.png" },
      { id: "after", name: "Adobe After Effects", src: "/ferramentas/after.png" },
      { id: "android", name: "Android", src: "/ferramentas/android.webp" },
    ],
    []
  );

  return (
    <section className="py-12 sm:py-16 px-4 sm:px-6 lg:px-8 max-w-6xl mx-auto">
      <motion.h2
        initial={false}
        whileInView={{ opacity: 1, y: 0 }}
        viewport={{ once: true }}
        className="font-display text-2xl md:text-3xl font-bold mb-6"
      >
        <span className="scribble-underline">Nossa Pilha</span>
      </motion.h2>

      <div className="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-6 gap-4">
        {tools.map((tool) => (
          <motion.div
            key={tool.id}
            initial={false}
            whileInView={{ opacity: 1, y: 0 }}
            viewport={{ once: true, margin: "-40px" }}
            transition={{ duration: 0.25 }}
            className="rounded-card border border-border bg-bg/70 overflow-hidden card-glow aspect-square flex items-center justify-center"
          >
            <img
              src={tool.src}
              alt={tool.name}
              className="w-12 h-12 sm:w-16 sm:h-16 object-contain grayscale opacity-80"
              loading="lazy"
            />
          </motion.div>
        ))}
      </div>
    </section>
  );
}
