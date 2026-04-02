"use client";

import { motion } from "framer-motion";
import { useTheme } from "@/hooks/useTheme";

const navLinks = [
  { href: "#trabalhos", label: "Trabalhos" },
  { href: "#o-que-faco", label: "O Que Fazemos" },
  { href: "#contato", label: "Contato" },
];

export default function Header() {
  const { isDark } = useTheme();
  
  return (
    <motion.header
      initial={false}
      animate={{ y: 0, opacity: 1 }}
      transition={{ duration: 0.5 }}
      className="fixed top-0 left-0 right-0 z-50 glass border-b border-border/50"
    >
      <nav className="max-w-6xl mx-auto px-4 sm:px-6 lg:px-8 h-20 sm:h-24 flex items-center justify-between">
        <a href="#" className="flex items-center gap-3 hover:opacity-90 transition-opacity">
          <img 
            src={isDark ? "/logolight.svg" : "/ocanguruu.svg"} 
            alt="Canguruu" 
            className="h-20 sm:h-28 w-auto -my-2 sm:-my-3" 
          />
        </a>
        <div className="flex items-center gap-3 sm:gap-6">
          {navLinks.map((link) => (
            <a
              key={link.href}
              href={link.href}
              className="text-sm text-text-secondary hover:text-text-primary transition-colors hidden sm:inline"
            >
              {link.label}
            </a>
          ))}
          
          <a
            href="#contato"
            className="font-mono text-sm px-3 sm:px-4 py-2.5 rounded-btn bg-primary text-secondary font-medium border border-border hover:shadow-glow hover:-translate-y-0.5 transition-all"
          >
            Solicitar Orçamento
          </a>
        </div>
      </nav>
    </motion.header>
  );
}
