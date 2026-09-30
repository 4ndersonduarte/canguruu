"use client";

import { useState } from "react";
import { whatsappLink } from "@/lib/contact";

const planOptions = ["Essencial · R$ 400/mês", "Canguruu+ · R$ 800/mês", "Preciso de orientação"];
const steps = [
  { title: "Conte sobre sua empresa", description: "Queremos conhecer seu negócio e o que você precisa comunicar." },
  { title: "Encontre o plano ideal", description: "Alinhamos os serviços e os próximos passos com você." },
  { title: "Vamos começar", description: "Combinamos os materiais e os prazos para colocar tudo em prática." },
];
const fieldClass = "w-full px-4 py-3 rounded-btn bg-bg border border-border text-text-primary placeholder-text-secondary focus:outline-none focus:ring-2 focus:ring-primary";
const buttonClass = "font-mono inline-flex items-center justify-center gap-2 px-5 py-3 sm:py-2.5 rounded-btn font-medium border border-border hover:shadow-glow hover:-translate-y-0.5 transition-all";

export default function Contact() {
  const [formData, setFormData] = useState({ name: "", company: "", email: "", message: "", plan: "Preciso de orientação" });

  const handleSubmit = (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    const message = [
      "Olá! Quero conversar sobre a presença digital da minha empresa.",
      "",
      `Nome: ${formData.name.trim()}`,
      formData.company.trim() && `Empresa: ${formData.company.trim()}`,
      formData.email.trim() && `E-mail: ${formData.email.trim()}`,
      `Interesse: ${formData.plan}`,
      formData.message.trim() && `\n${formData.message.trim()}`,
    ].filter(Boolean).join("\n");
    window.open(whatsappLink(message), "_blank", "noopener,noreferrer");
  };

  const handleChange = (e: React.ChangeEvent<HTMLInputElement | HTMLTextAreaElement>) => {
    setFormData((prev) => ({ ...prev, [e.target.name]: e.target.value }));
  };

  return (
    <section id="contato" aria-labelledby="contact-title" className="py-16 px-4 sm:px-6 lg:px-8 max-w-6xl mx-auto">
      <div className="rounded-card border border-border bg-bg overflow-hidden">
        <div className="h-1.5 bg-primary" aria-hidden="true" />
        <div className="grid grid-cols-1 lg:grid-cols-2">
          <div className="p-6 sm:p-8 lg:p-10 flex flex-col">
            <p className="font-mono text-xs uppercase tracking-widest text-text-secondary mb-4">Vamos conversar</p>
            <h2 id="contact-title" className="font-display text-2xl md:text-3xl font-bold leading-tight mb-4">
              Vamos dar o próximo passo com sua empresa?
            </h2>
            <p className="text-text-secondary text-sm leading-relaxed mb-8">
              Uma comunicação mais profissional começa com uma conversa. Conte o que sua empresa precisa e vamos encontrar o melhor caminho.
            </p>
            <ol className="space-y-6 mb-8">
              {steps.map((step, index) => (
                <li key={step.title} className="flex items-start gap-4">
                  <span className="font-mono text-xs bg-primary text-secondary rounded-btn w-9 h-9 shrink-0 flex items-center justify-center" aria-hidden="true">0{index + 1}</span>
                  <div>
                    <h3 className="font-display text-base font-semibold mb-1">{step.title}</h3>
                    <p className="text-text-secondary text-sm leading-relaxed">{step.description}</p>
                  </div>
                </li>
              ))}
            </ol>
            <div className="mt-auto pt-6 border-t border-border">
              <a href="mailto:contato@canguruu.studio" className="block font-mono text-xs text-text-secondary break-all hover:text-text-primary transition-colors">contato@canguruu.studio</a>
            </div>
          </div>
          <div className="p-6 sm:p-8 lg:p-10 border-t lg:border-t-0 lg:border-l border-border">
            <h3 className="font-display text-xl font-semibold mb-2">Conte um pouco sobre seu negócio</h3>
            <p id="contact-help" className="text-sm text-text-secondary leading-relaxed mb-6">Preencha abaixo e continue a conversa no WhatsApp.</p>
            <form onSubmit={handleSubmit} aria-describedby="contact-help" className="space-y-5">
              <div className="grid sm:grid-cols-2 gap-4">
                <div>
                  <label htmlFor="name" className="font-mono text-xs text-text-secondary block mb-2">Seu nome <span aria-hidden="true">*</span></label>
                  <input id="name" name="name" type="text" required pattern=".*\S.*" autoComplete="name" value={formData.name} onChange={handleChange} className={fieldClass} placeholder="Como podemos te chamar?" />
                </div>
                <div>
                  <label htmlFor="company" className="font-mono text-xs text-text-secondary block mb-2">Empresa (opcional)</label>
                  <input id="company" name="company" type="text" autoComplete="organization" value={formData.company} onChange={handleChange} className={fieldClass} placeholder="Nome do seu negócio" />
                </div>
              </div>
              <fieldset>
                <legend className="font-mono text-xs text-text-secondary mb-2">Qual plano faz sentido para você?</legend>
                <div className="space-y-2">
                  {planOptions.map((plan) => (
                    <label key={plan} className={`flex items-center gap-3 p-3 rounded-btn border cursor-pointer transition-colors ${formData.plan === plan ? "border-primary bg-[rgba(255,212,0,0.08)]" : "border-border"}`}>
                      <input type="radio" name="plan" value={plan} checked={formData.plan === plan} onChange={handleChange} className="h-4 w-4 accent-[#ffd400] shrink-0 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2" />
                      <span className="font-mono text-xs sm:text-sm">{plan}</span>
                    </label>
                  ))}
                </div>
              </fieldset>
              <div>
                <label htmlFor="email" className="font-mono text-xs text-text-secondary block mb-2">E-mail (opcional)</label>
                <input id="email" name="email" type="email" autoComplete="email" value={formData.email} onChange={handleChange} className={fieldClass} placeholder="seu@email.com" />
              </div>
              <div>
                <label htmlFor="message" className="font-mono text-xs text-text-secondary block mb-2">O que sua empresa precisa? (opcional)</label>
                <textarea id="message" name="message" rows={3} value={formData.message} onChange={handleChange} className={`${fieldClass} resize-y min-h-24`} placeholder="Artes para divulgar ofertas, um site, uma comunicação mais organizada..." />
              </div>
              <button type="submit" className={`${buttonClass} w-full bg-primary text-secondary`}>Continuar no WhatsApp <span aria-hidden="true">↗</span></button>
              <p className="text-xs text-text-secondary leading-relaxed">Você poderá revisar a mensagem no WhatsApp antes de enviar. * Nome obrigatório.</p>
            </form>
          </div>
        </div>
      </div>
    </section>
  );
}
