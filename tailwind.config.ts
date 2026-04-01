import type { Config } from "tailwindcss";

const config: Config = {
  content: [
    "./pages/**/*.{js,ts,jsx,tsx,mdx}",
    "./components/**/*.{js,ts,jsx,tsx,mdx}",
    "./app/**/*.{js,ts,jsx,tsx,mdx}",
  ],
  theme: {
    extend: {
      colors: {
        bg: "var(--bg)",
        primary: "var(--primary)",
        secondary: "var(--secondary)",
        "text-primary": "var(--text-primary)",
        "text-secondary": "var(--text-secondary)",
        border: "var(--border)",
      },
      fontFamily: {
        display: ["var(--font-trocchi)", "Trocchi", "serif"],
        body: ["var(--font-inter)", "sans-serif"],
        mono: ["var(--font-jetbrains)", "monospace"],
      },
      borderRadius: {
        card: "16px",
        btn: "8px",
      },
      boxShadow: {
        glow: "0 14px 34px rgba(17, 17, 17, 0.12)",
        "glow-violet": "0 14px 34px rgba(160, 160, 152, 0.22)",
      },
      backdropBlur: {
        nav: "12px",
      },
    },
  },
  plugins: [],
};

export default config;
