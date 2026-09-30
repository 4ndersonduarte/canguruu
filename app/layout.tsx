import type { Metadata } from "next";
import { Trocchi, Inter, JetBrains_Mono } from "next/font/google";
import "./globals.css";
import { ThemeProvider } from "@/components/ThemeProvider";

const trocchi = Trocchi({
  subsets: ["latin"],
  variable: "--font-trocchi",
  weight: ["400"],
});

const inter = Inter({
  subsets: ["latin"],
  variable: "--font-inter",
  weight: ["400", "500", "600"],
});

const jetbrains = JetBrains_Mono({
  subsets: ["latin"],
  variable: "--font-jetbrains",
  weight: ["400", "500"],
});

export const metadata: Metadata = {
  title: "Canguruu | Comunicação e sites para sua empresa",
  description:
    "Comunicação profissional a partir de R$ 400/mês. Conheça o Canguruu+ por R$ 800/mês, com artes, campanhas, site profissional, hospedagem e suporte.",
  icons: {
    icon: "/icon.svg",
    shortcut: "/icon.svg",
    apple: "/icon.svg",
  },
  manifest: "/manifest.json",
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html
      lang="pt-BR"
      className={`${trocchi.variable} ${inter.variable} ${jetbrains.variable}`}
    >
      <body className="font-body antialiased bg-bg text-text-primary">
        <ThemeProvider>
          {children}
        </ThemeProvider>
      </body>
    </html>
  );
}
