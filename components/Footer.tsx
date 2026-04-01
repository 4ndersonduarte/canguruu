"use client";

const socialLinks = [
  { href: "https://linkedin.com", label: "LinkedIn" },
  { href: "https://github.com", label: "GitHub" },
  { href: "https://behance.net", label: "Behance" },
];

const toolLogos = [
  { src: "/ferramentas/flutter.png", alt: "Flutter", className: "h-16 w-16" },
  { src: "/ferramentas/supabase.png", alt: "Supabase", className: "h-16 w-16" },
  { src: "/ferramentas/photoshop.png", alt: "Adobe Photoshop", className: "h-7 w-7" },
  { src: "/ferramentas/after.png", alt: "Adobe After Effects", className: "h-7 w-7" },
  { src: "/ferramentas/android.webp", alt: "Android", className: "h-12 w-12" },
];

export default function Footer() {
  const currentYear = new Date().getFullYear();

  return (
    <footer className="border-t border-border py-8 px-4 sm:px-6 lg:px-8">
      <div className="max-w-6xl mx-auto flex flex-col sm:flex-row items-center justify-between gap-4">
        <div className="flex gap-6">
          {socialLinks.map((link) => (
            <a
              key={link.label}
              href={link.href}
              target="_blank"
              rel="noopener noreferrer"
              className="text-text-secondary hover:text-secondary transition-colors text-sm"
            >
              {link.label}
            </a>
          ))}
        </div>

        <div className="flex flex-col sm:flex-row items-center gap-2 sm:gap-3 opacity-95">
          <div className="flex items-center gap-2 sm:gap-4">
            {toolLogos.map((t) => (
              <img
                key={t.alt}
                src={t.src}
                alt={t.alt}
                className={`${t.className} object-contain grayscale`}
                loading="lazy"
              />
            ))}
          </div>
          <span className="font-mono text-text-secondary text-xs whitespace-nowrap">
            Made with [Flutter/React] & Coffee.
          </span>
        </div>

        <p className="text-text-secondary text-sm">
          © {currentYear} Canguruu
        </p>
      </div>
    </footer>
  );
}
