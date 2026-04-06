"use client";

import { useState } from "react";
import { motion } from "framer-motion";

const WHATSAPP_NUMBER = "5574998094104"; // substitua pelo número real
const WHATSAPP_MSG = "Olá! Gostaria de solicitar um orçamento para um projeto.";

export default function Contact() {
  const [formData, setFormData] = useState({ name: "", email: "", message: "" });

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    // Opcional: enviar para Supabase ou API
    const url = `https://wa.me/${WHATSAPP_NUMBER}?text=${encodeURIComponent(
      `Nome: ${formData.name}\nE-mail: ${formData.email}\n\n${formData.message}`
    )}`;
    window.open(url, "_blank");
  };

  const handleChange = (e: React.ChangeEvent<HTMLInputElement | HTMLTextAreaElement>) => {
    setFormData((prev) => ({ ...prev, [e.target.name]: e.target.value }));
  };

  return (
    <section id="contato" className="py-16 px-4 sm:px-6 lg:px-8 max-w-6xl mx-auto">
      <motion.div
        initial={{ opacity: 0, y: 14 }}
        whileInView={{ opacity: 1, y: 0 }}
        viewport={{ once: true }}
        transition={{ duration: 0.45, ease: [0.22, 1, 0.36, 1] }}
        className="rounded-card border border-border bg-bg/80 p-5 sm:p-6 md:p-8 card-glow overflow-hidden"
      >
        <div className="grid grid-cols-1 md:grid-cols-2 gap-8">
          {/* Esquerda */}
          <div>
            <h2 className="font-display text-2xl md:text-3xl font-bold mb-4">
              Vamos tirar sua ideia do papel?
            </h2>
            <p className="text-text-secondary text-sm leading-relaxed mb-4">
              Me chama e eu te ajudo a transformar a ideia em algo pronto pra vender: arte, identidade, site/app ou vídeo.
            </p>
            <div className="font-mono text-xs text-text-secondary mb-4 space-y-1">
              <p>— Orçamento rápido</p>
              <p>— Prazos claros</p>
              <p>— Peças prontas para postar e imprimir</p>
            </div>
            <p className="font-mono text-sm text-text-secondary mb-4">
              contato@canguruu.studio
            </p>
            <a
              href={`https://wa.me/${WHATSAPP_NUMBER}?text=${encodeURIComponent(WHATSAPP_MSG)}`}
              target="_blank"
              rel="noopener noreferrer"
              className="font-mono inline-flex items-center justify-center gap-2 px-6 py-3 rounded-btn bg-green-600 hover:bg-green-500 text-white font-medium transition-all hover:shadow-lg w-full sm:w-fit"
            >
              <svg className="w-5 h-5" fill="currentColor" viewBox="0 0 24 24">
                <path d="M17.472 14.382c-.297-.149-1.758-.867-2.03-.967-.273-.099-.471-.148-.67.15-.197.297-.767.966-.94 1.164-.173.199-.347.223-.644.075-.297-.15-1.255-.463-2.39-1.475-.883-.788-1.48-1.761-1.653-2.059-.173-.297-.018-.458.13-.606.134-.133.298-.347.446-.52.149-.174.198-.298.298-.497.099-.198.05-.371-.025-.52-.075-.149-.669-1.612-.916-2.207-.242-.579-.487-.5-.669-.51-.173-.008-.371-.01-.57-.01-.198 0-.52.074-.792.372-.272.297-1.04 1.016-1.04 2.479 0 1.462 1.065 2.875 1.213 3.074.149.198 2.096 3.2 5.077 4.487.709.306 1.262.489 1.694.625.712.227 1.36.195 1.871.118.571-.085 1.758-.719 2.006-1.413.248-.694.248-1.289.173-1.413-.074-.124-.272-.198-.57-.347m-5.421 7.403h-.004a9.87 9.87 0 01-5.031-1.378l-.361-.214-3.741.982.998-3.648-.235-.374a9.86 9.86 0 01-1.51-5.26c.001-5.45 4.436-9.884 9.888-9.884 2.64 0 5.122 1.03 6.988 2.898a9.825 9.825 0 012.893 6.994c-.003 5.45-4.437 9.884-9.885 9.884m8.413-18.297A11.815 11.815 0 0012.05 0C5.495 0 .16 5.335.157 11.892c0 2.096.547 4.142 1.588 5.945L.057 24l6.305-1.654a11.882 11.882 0 005.683 1.448h.005c6.554 0 11.89-5.335 11.893-11.893a11.821 11.821 0 00-3.48-8.413z" />
              </svg>
              Abrir WhatsApp
            </a>
            <p className="text-text-secondary text-xs mt-3">
              Resposta normalmente no mesmo dia.
            </p>
          </div>
          {/* Direita - Formulário */}
          <form onSubmit={handleSubmit} className="space-y-4">
            <div>
              <label htmlFor="name" className="font-mono text-xs text-text-secondary block mb-1">
                Nome
              </label>
              <input
                id="name"
                name="name"
                type="text"
                required
                value={formData.name}
                onChange={handleChange}
                className="w-full px-4 py-2.5 rounded-btn bg-bg/50 border border-border text-text-primary placeholder-text-secondary focus:outline-none focus:ring-2 focus:ring-primary/50"
                placeholder="Seu nome"
              />
            </div>
            <div>
              <label htmlFor="email" className="font-mono text-xs text-text-secondary block mb-1">
                E-mail
              </label>
              <input
                id="email"
                name="email"
                type="email"
                required
                value={formData.email}
                onChange={handleChange}
                className="w-full px-4 py-2.5 rounded-btn bg-bg/50 border border-border text-text-primary placeholder-text-secondary focus:outline-none focus:ring-2 focus:ring-primary/50"
                placeholder="seu@email.com"
              />
            </div>
            <div>
              <label htmlFor="message" className="font-mono text-xs text-text-secondary block mb-1">
                Mensagem
              </label>
              <textarea
                id="message"
                name="message"
                required
                rows={3}
                value={formData.message}
                onChange={handleChange}
                className="w-full px-4 py-2.5 rounded-btn bg-bg/50 border border-border text-text-primary placeholder-text-secondary focus:outline-none focus:ring-2 focus:ring-primary/50 resize-none"
                placeholder="Conte sobre seu projeto..."
              />
            </div>
            <button
              type="submit"
              className="font-mono w-full sm:w-auto px-6 py-2.5 rounded-btn bg-primary text-secondary font-medium border border-border hover:shadow-glow transition-all"
            >
              Enviar (via WhatsApp)
            </button>
          </form>
        </div>
      </motion.div>
    </section>
  );
}
