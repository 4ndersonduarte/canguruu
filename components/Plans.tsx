import { whatsappLink } from "@/lib/contact";

const plans = [
  {
    name: "Essencial",
    price: "400",
    description: "Para empresas que querem manter uma comunicação profissional durante todo o mês.",
    features: ["Campanhas promocionais", "Artes para redes sociais", "Datas comemorativas", "Padronização visual", "Suporte pelo WhatsApp"],
    cta: "Quero começar",
    message: "Olá! Quero começar com o plano Essencial de R$ 400/mês.",
    featured: false,
  },
  {
    name: "Canguruu+",
    price: "800",
    description: "Para empresas que querem uma presença digital completa e aplicações para facilitar a gestão do negócio.",
    features: ["Tudo do Essencial", "Site profissional", "Criação de aplicações e sistemas de gestão", "Hospedagem", "Integração com WhatsApp", "Atualizações do site", "Suporte"],
    cta: "Quero minha empresa no digital",
    message: "Olá! Quero minha empresa no digital com o plano Canguruu+ de R$ 800/mês.",
    featured: true,
  },
];

const comparison = [
  { label: "Artes mensais", essential: true },
  { label: "Campanhas", essential: true },
  { label: "Datas comemorativas", essential: true },
  { label: "Padronização visual", essential: true },
  { label: "Suporte pelo WhatsApp", essential: true },
  { label: "Site profissional", essential: false },
  { label: "Criação de aplicações e sistemas de gestão", essential: false },
  { label: "Hospedagem", essential: false },
  { label: "Manutenção e atualizações do site", essential: false },
  { label: "Integração com WhatsApp no site", essential: false },
];

function Included({ value }: { value: boolean }) {
  return <span><span aria-hidden="true">{value ? "✓" : "—"}</span><span className="sr-only">{value ? "Incluso" : "Não incluso"}</span></span>;
}

export default function Plans() {
  return (
    <section aria-labelledby="plans-title" className="py-16 px-4 sm:px-6 lg:px-8 max-w-6xl mx-auto">
      <div className="max-w-2xl mb-8">
        <p className="font-mono text-xs uppercase tracking-widest text-text-secondary mb-3">Um parceiro para todo o mês</p>
        <h2 id="plans-title" className="font-display text-2xl md:text-3xl font-bold leading-tight mb-4">Escolha o próximo passo da sua empresa.</h2>
        <p className="text-text-secondary leading-relaxed">Comunicação profissional nas redes ou uma presença digital completa, com site e aplicações para a gestão do seu negócio. Escolha o plano e vamos conversar.</p>
      </div>
      <div id="planos" role="group" aria-label="Planos Essencial e Canguruu+" className="grid md:grid-cols-2 gap-6 items-stretch scroll-mt-24 sm:scroll-mt-28">
        {plans.map((plan) => (
          <article key={plan.name} className={`relative rounded-card border p-6 sm:p-8 flex flex-col ${plan.featured ? "border-primary border-2 bg-bg shadow-glow" : "border-border bg-bg"}`}>
            <p className={`font-mono text-xs uppercase tracking-wider mb-5 ${plan.featured ? "bg-primary text-secondary rounded-full px-3 py-1 w-fit" : "text-text-secondary py-1"}`}>
              {plan.featured ? "Comunicação + site + gestão" : "Sua marca presente"}
            </p>
            <h3 className="font-display text-2xl font-semibold mb-4">{plan.name}</h3>
            <p className="mb-4 flex items-baseline gap-1"><span className="text-lg">R$</span><span className="font-display text-5xl sm:text-6xl font-bold tracking-tight">{plan.price}</span><span className="text-text-secondary">/mês</span></p>
            <p className="text-text-secondary leading-relaxed mb-6">{plan.description}</p>
            <ul className="space-y-3 mb-8">
              {plan.features.map((feature) => <li key={feature} className="flex gap-3"><span aria-hidden="true" className="font-mono font-medium">✓</span><span>{feature}</span></li>)}
            </ul>
            <a href={whatsappLink(plan.message)} target="_blank" rel="noopener noreferrer" className={`mt-auto font-mono inline-flex items-center justify-center gap-2 px-5 py-3 sm:py-2.5 rounded-btn text-center font-medium border border-border hover:shadow-glow hover:-translate-y-0.5 transition-all w-full sm:w-fit ${plan.featured ? "bg-primary text-secondary" : "bg-secondary text-bg"}`}>{plan.cta}</a>
          </article>
        ))}
      </div>
      <div className="my-8 rounded-card bg-primary text-secondary p-6 sm:p-8">
        <p className="font-display text-xl sm:text-2xl font-semibold mb-2">Por mais R$ 400/mês, sua empresa também ganha um site.</p>
        <p className="text-sm sm:text-base">Do Essencial ao Canguruu+: site profissional, criação de aplicações e sistemas de gestão, hospedagem, integração com WhatsApp e atualizações, além de toda a comunicação do mês.</p>
      </div>
      <div className="rounded-card border border-border overflow-hidden">
        <table className="w-full table-fixed text-sm">
          <caption className="text-left font-display text-xl font-semibold p-5 sm:p-6">Compare o que está incluso</caption>
          <thead>
            <tr className="border-y border-border">
              <th scope="col" className="w-[44%] p-3 sm:p-5 text-left font-mono font-medium">O que sua empresa recebe</th>
              <th scope="col" className="p-2 sm:p-5 font-mono font-medium">Essencial<span className="block mt-1 text-xs sm:text-sm text-text-secondary">R$ 400/mês</span></th>
              <th scope="col" className="p-2 sm:p-5 bg-primary text-secondary font-mono font-medium">Canguruu+<span className="block mt-1 text-xs sm:text-sm">R$ 800/mês</span></th>
            </tr>
          </thead>
          <tbody>
            {comparison.map((row) => (
              <tr key={row.label} className="border-t border-border">
                <th scope="row" className="p-3 sm:px-5 sm:py-4 text-left font-normal">{row.label}</th>
                <td className="p-3 text-center text-lg"><Included value={row.essential} /></td>
                <td className="p-3 text-center text-lg bg-[rgba(255,212,0,0.10)]"><Included value /></td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </section>
  );
}
