"use client";

import { useMemo } from "react";
import { motion } from "framer-motion";

type Logo = {
  id: string;
  name: string;
  src: string;
};

export default function LogosSection() {
  const logos: Logo[] = useMemo(
    () => [
      { id: "canguruulogo", name: "Canguruu", src: "/clientes/logotipos/canguruulogo.png" },
      { id: "comercialrodagem", name: "Comercial Rodagem", src: "/clientes/logotipos/comercialrodagem.png" },
      { id: "fornodeouro", name: "Forno de Ouro", src: "/clientes/logotipos/fornodeouro.png" },
      { id: "jovempipas", name: "Jovem Pipas", src: "/clientes/logotipos/jovempipas.png" },
      { id: "reidascarnes", name: "Rei das Carnes", src: "/clientes/logotipos/reidascarnes.png" },
      { id: "tdboutique", name: "TD Boutique", src: "/clientes/logotipos/tdboutique.png" },
      { id: "viladegust", name: "Vila Degust", src: "/clientes/logotipos/viladegust.png" },
    ],
    []
  );

  return (
    <section className="relative py-12 sm:py-16 px-4 sm:px-6 max-w-none mx-auto">
      {/* Background image - sem limites */}
      <div 
        className="absolute inset-0 bg-center bg-no-repeat opacity-40"
        style={{ backgroundImage: 'url(/imagemfundo.png)', backgroundSize: 'auto', backgroundPosition: 'center center' }}
      />
      
      {/* Content */}
      <div className="relative z-10 max-w-6xl mx-auto">
        <motion.h2
          initial={{ opacity: 0, y: 16 }}
          whileInView={{ opacity: 1, y: 0 }}
          viewport={{ once: true }}
          className="font-display text-2xl md:text-3xl font-bold mb-6"
        >
          <span className="scribble-underline">Logotipos</span>
        </motion.h2>

        <div className="grid grid-cols-3 sm:grid-cols-4 lg:grid-cols-5 xl:grid-cols-7 gap-3">
          {logos.map((logo) => (
            <motion.div
              key={logo.id}
              initial={{ opacity: 0, y: 20 }}
              whileInView={{ opacity: 1, y: 0 }}
              viewport={{ once: true, margin: "-40px" }}
              transition={{ duration: 0.25 }}
              className="rounded-card border border-border bg-bg/80 overflow-hidden card-glow transition-all duration-300 hover:-translate-y-1 aspect-square"
            >
              <div className="w-full h-full p-3 flex items-center justify-center">
                <img src={logo.src} alt={logo.name} className="w-full h-full object-contain" />
              </div>
            </motion.div>
          ))}
        </div>
      </div>
    </section>
  );
}
