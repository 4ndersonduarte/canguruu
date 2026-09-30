# Canguruu

Portfólio SPA em Next.js (App Router) + Tailwind CSS + Framer Motion.

## Stack

- **Framework:** Next.js 14 (App Router)
- **Estilização:** Tailwind CSS
- **Animações:** Framer Motion
- **Fontes:** Plus Jakarta Sans, Inter, JetBrains Mono

## Design System

- **Fundo:** `#FFFFFF`
- **Acento:** Amarelo `#FFD400` e Preto `#111111`
- **Texto:** `#111111` / `#4B5563`
- **Bordas:** `#111111`
- Layout em Bento Grid, glassmorphism no header, sombras limpas.

## Desenvolvimento

```bash
npm install
npm run dev
```

Acesse [http://localhost:3000](http://localhost:3000).

## Build

```bash
npm run build
npm start
```

## Personalização

- **WhatsApp:** Altere `WHATSAPP_NUMBER` em `components/Contact.tsx` (formato: 5511999999999).
- **E-mail:** O texto `contato@duarte.dev` está em `components/Contact.tsx`.
- **Vídeo Showreel:** Em `components/Projects.tsx`, troque `videoUrl` do projeto "Showreel 2024" pela URL do embed do YouTube/Vimeo.
- **Redes sociais:** Links no `components/Footer.tsx`.

## Opcional: Supabase para formulário

Para enviar o formulário de contato para o Supabase em vez de abrir o WhatsApp, crie uma tabela (ex.: `contacts`) e use o client do Supabase no `handleSubmit` de `Contact.tsx`.

## Planos e imagem do site

- Planos e comparativo: `components/Plans.tsx`.
- WhatsApp compartilhado pelos planos e contato: `lib/contact.ts`.
- Seção do site: `components/WebsiteSection.tsx`.
- A ilustração provisória está em `public/site-preview.svg`.
- Para a imagem definitiva de notebook + celular, exporte **1600 × 1200 px (4:3)** em WebP ou PNG. Mantenha os dispositivos dentro da imagem, com uma margem de aproximadamente 80 px.
- Salve a imagem em `public/site-preview.webp` e altere o `src` e o texto alternativo em `WebsiteSection.tsx`. O espaço já é responsivo e usa `object-contain` para preservar a composição inteira.
