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
        bg: "#FFFFFF",
        primary: "#FFD400",
        secondary: "#111111",
        "text-primary": "#111111",
        "text-secondary": "#4B5563",
        border: "#111111",
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
        "glow-violet": "0 14px 34px rgba(255, 212, 0, 0.22)",
      },
      backdropBlur: {
        nav: "12px",
      },
    },
  },
  plugins: [],
};

export default config;
