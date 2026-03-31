import type { Metadata } from "next";
import { Trocchi, Inter, JetBrains_Mono } from "next/font/google";
import "./globals.css";

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
  title: "Canguruu | Design, Estratégia & Dev",
  description:
    "Design, Estratégia & Dev: artes e campanhas, identidade visual, sites e apps, vídeo e motion. Do rabisco ao produto.",
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
        {children}
      </body>
    </html>
  );
}
