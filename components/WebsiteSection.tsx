export default function WebsiteSection() {
  return (
    <section id="seu-site" aria-labelledby="website-title" className="py-16 px-4 sm:px-6 lg:px-8 max-w-6xl mx-auto">
      <div className="grid lg:grid-cols-2 gap-8 lg:gap-12 items-center rounded-card border border-border bg-bg p-5 sm:p-8">
        <div>
          <p className="font-mono text-xs uppercase tracking-widest text-text-secondary mb-4">Seu negócio ainda não tem site?</p>
          <h2 id="website-title" className="font-display text-2xl md:text-3xl font-bold leading-tight mb-5">Seu negócio ainda depende apenas do Instagram?</h2>
          <p className="text-text-secondary leading-relaxed mb-6">Tenha um espaço profissional para apresentar sua empresa, seus serviços, localização e facilitar o contato dos seus clientes.</p>
          <p className="font-mono text-sm font-medium mb-6">Site profissional incluso no plano Canguruu<span className="text-primary">+</span></p>
          <a href="#planos" className="font-mono inline-flex items-center justify-center gap-2 px-5 py-3 sm:py-2.5 rounded-btn bg-primary text-secondary font-medium border border-border hover:shadow-glow hover:-translate-y-0.5 transition-all w-full sm:w-fit">Quero conhecer</a>
        </div>
        {/* Substituir por uma imagem real de notebook + celular, 1600 × 1200 px (4:3). */}
        <figure className="min-w-0">
          <img src="/site-preview.svg" alt="Ilustração de um notebook e um celular com espaço para apresentar o site da sua empresa." width={1600} height={1200} loading="lazy" className="w-full aspect-[4/3] object-contain rounded-card" />
        </figure>
      </div>
    </section>
  );
}
