"use client";

const socialLinks = [
  { href: "https://linkedin.com", label: "LinkedIn" },
  { href: "https://github.com", label: "GitHub" },
  { href: "https://behance.net", label: "Behance" },
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
        <p className="text-text-secondary text-sm">
          © {currentYear} Canguruu
        </p>
      </div>
      <p className="font-mono text-center text-text-secondary text-xs mt-4">
        Made with [Flutter/React] & Coffeine.
      </p>
    </footer>
  );
}
