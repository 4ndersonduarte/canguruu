"use client";

const socialLinks = [
  { 
    href: "https://instagram.com/ocanguruu", 
    label: "Instagram Canguruu",
    username: "@ocanguruu",
    icon: (
      <svg width="24" height="24" viewBox="0 0 24 24" fill="currentColor">
        <path d="M12 2.163c3.204 0 3.584.012 4.85.07 3.252.148 4.771 1.691 4.919 4.919.058 1.265.069 1.645.069 4.849 0 3.205-.012 3.584-.069 4.849-.149 3.225-1.664 4.771-4.919 4.919-1.266.058-1.644.07-4.85.07-3.204 0-3.584-.012-4.849-.07-3.26-.149-4.771-1.699-4.919-4.92-.058-1.265-.07-1.644-.07-4.849 0-3.204.013-3.583.07-4.849.149-3.227 1.664-4.771 4.919-4.919 1.266-.057 1.645-.069 4.849-.069zm0-2.163c-3.259 0-3.667.014-4.947.072-4.358.2-6.78 2.618-6.98 6.98-.059 1.281-.073 1.689-.073 4.948 0 3.259.014 3.668.072 4.948.2 4.358 2.618 6.78 6.98 6.98 1.281.058 1.689.072 4.948.072 3.259 0 3.668-.014 4.948-.072 4.354-.2 6.782-2.618 6.979-6.98.059-1.28.073-1.689.073-4.948 0-3.259-.014-3.667-.072-4.947-.196-4.354-2.617-6.78-6.979-6.98-1.281-.059-1.69-.073-4.949-.073zM5.838 12a6.162 6.162 0 1 1 12.324 0 6.162 6.162 0 0 1-12.324 0zM12 16a4 4 0 1 1 0-8 4 4 0 0 1 0 8zm4.965-10.405a1.44 1.44 0 1 1 2.881.001 1.44 1.44 0 0 1-2.881-.001z"/>
      </svg>
    )
  },
  { 
    href: "https://instagram.com/andduarte_", 
    label: "Instagram André Duarte",
    username: "@andduarte_",
    icon: (
      <svg width="24" height="24" viewBox="0 0 24 24" fill="currentColor">
        <path d="M12 2.163c3.204 0 3.584.012 4.85.07 3.252.148 4.771 1.691 4.919 4.919.058 1.265.069 1.645.069 4.849 0 3.205-.012 3.584-.069 4.849-.149 3.225-1.664 4.771-4.919 4.919-1.266.058-1.644.07-4.85.07-3.204 0-3.584-.012-4.849-.07-3.26-.149-4.771-1.699-4.919-4.92-.058-1.265-.07-1.644-.07-4.849 0-3.204.013-3.583.07-4.849.149-3.227 1.664-4.771 4.919-4.919 1.266-.057 1.645-.069 4.849-.069zm0-2.163c-3.259 0-3.667.014-4.947.072-4.358.2-6.78 2.618-6.98 6.98-.059 1.281-.073 1.689-.073 4.948 0 3.259.014 3.668.072 4.948.2 4.358 2.618 6.78 6.98 6.98 1.281.058 1.689.072 4.948.072 3.259 0 3.668-.014 4.948-.072 4.354-.2 6.782-2.618 6.979-6.98.059-1.28.073-1.689.073-4.948 0-3.259-.014-3.667-.072-4.947-.196-4.354-2.617-6.78-6.979-6.98-1.281-.059-1.69-.073-4.949-.073zM5.838 12a6.162 6.162 0 1 1 12.324 0 6.162 6.162 0 0 1-12.324 0zM12 16a4 4 0 1 1 0-8 4 4 0 0 1 0 8zm4.965-10.405a1.44 1.44 0 1 1 2.881.001 1.44 1.44 0 0 1-2.881-.001z"/>
      </svg>
    )
  },
];

const toolLogos = [
  { src: "/ferramentas/flutter.webp", alt: "Flutter", className: "h-16 w-16" },
  { src: "/ferramentas/supabase.webp", alt: "Supabase", className: "h-16 w-16" },
  { src: "/ferramentas/photoshop.webp", alt: "Adobe Photoshop", className: "h-7 w-7" },
  { src: "/ferramentas/after.webp", alt: "Adobe After Effects", className: "h-7 w-7" },
  { src: "/ferramentas/android.webp", alt: "Android", className: "h-12 w-12" },
];

export default function Footer() {
  const currentYear = new Date().getFullYear();

  return (
    <footer className="border-t border-border py-8 px-4 sm:px-6 lg:px-8">
      <div className="max-w-6xl mx-auto flex flex-col gap-6 sm:gap-4">
        {/* Social Media Section */}
        <div className="flex flex-col items-center gap-6 sm:gap-4">
          <div className="flex gap-6">
            {socialLinks.map((link) => (
              <a
                key={link.label}
                href={link.href}
                target="_blank"
                rel="noopener noreferrer"
                className="flex flex-col items-center gap-1 text-text-secondary hover:text-secondary transition-colors p-2 hover:scale-110 transition-transform"
                aria-label={link.label}
              >
                {link.icon}
                <span className="text-xs font-mono">{link.username}</span>
              </a>
            ))}
          </div>
        </div>

        {/* Tools and Text Section */}
        <div className="flex flex-col items-center gap-4">
          <div className="flex items-center gap-3 sm:gap-4">
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
          <span className="font-mono text-text-secondary text-xs text-center">
            Made with [Flutter/React] & Coffee.
          </span>
        </div>

        {/* Copyright */}
        <p className="text-text-secondary text-sm text-center">
          © {currentYear} Canguruu
        </p>
      </div>
    </footer>
  );
}
