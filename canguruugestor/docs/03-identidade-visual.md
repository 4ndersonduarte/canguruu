# Canguruu — direção visual e revisão 0.3.1

Esta revisão responde ao retorno do usuário sobre fontes, ícones e formas do aplicativo. A prévia precisa receber seu retorno visual antes de avançarmos para metas e objetivos.

## Referências

As cinco imagens enviadas estão preservadas em referencias-visuais/:
- site-inicio-01.png e site-inicio-02.png
- site-trabalhos.png
- site-servicos.png
- app-conceitual.png

As capturas do site orientam a tipografia, os controles e os contornos. A imagem conceitual mobile orienta o fundo quente, os destaques amarelos, a marca e a navegação. Essa combinação é a interpretação aplicada à primeira revisão, não uma afirmação de reprodução exata da imagem.

## Identidade confirmada no site original

Em duarte/app/layout.tsx: Trocchi para títulos, Inter para leitura e JetBrains Mono para detalhes. Em tailwind.config.ts: cards de raio 16 e botões de raio 8. Em app/globals.css: amarelo #FFD400, preto #111111 e marcações amarelas sob os títulos. Em components/Services.tsx: SVGs lineares com traço 1,5 e terminações arredondadas.

A tipografia exata da imagem conceitual mobile não foi identificada. A escolha das famílias vem do código original da marca.

## Aplicado ao Flutter

- Trocchi local para títulos de páginas e seções e para valores destacados no painel.
- Inter preservada para textos, campos, listas e valores de leitura rápida.
- JetBrains Mono local para botões, filtros e detalhes curtos.
- Preto #111111, amarelo #FFD400, fundo quente #F8F5EB, papel #FFFDF7 e destaque suave #FFF2CC. Os três tons de superfície são escolhas desta revisão inspiradas na imagem; não são apresentados como cores oficiais extraídas dela.
- Cards comuns de raio 16 e contorno fino. Campos e botões de raio 8; painéis especiais de raio 20.
- Ícones próprios em SVG sobre uma grade de 24 unidades, traço 1,5, pontas e junções arredondadas. Os desenhos ficam centralizados sem crescer para ocupar toda a área de toque.
- Logo original isolado no cabeçalho, sem o texto adicional em Inter que competia com a marca.
- Navegação mobile preta com formato de cápsula e ícone ativo amarelo.
- Marcação amarela sob os títulos e destaques claros no painel e resumo da agenda.

## Componentes responsáveis

- app_flutter/lib/app/theme.dart: paleta, tipografia e estilos de controles.
- app_flutter/lib/shared/presentation/brand_icon.dart: desenhos e escala dos ícones do app.
- app_flutter/lib/shared/presentation/brand_heading.dart: títulos com marcação amarela.
- app_flutter/lib/shared/presentation/components.dart: cabeçalhos, cards vazios e seções.
- app_flutter/lib/app/app.dart: marca e navegação.
- app_flutter/pubspec.yaml: fontes locais e licenças.

Os controles internos do Flutter, como o calendário do sistema de interface e os indicadores de menu, continuam usando sua implementação padrão. Novos ícones próprios devem entrar no catálogo compartilhado, mantendo a mesma espessura.

## Limites e sequência

A revisão adapta as funcionalidades existentes. Não adiciona análises fictícias, compras de exemplo ou metas apenas para imitar a imagem. A pose coroada do canguru e as ilustrações de produtos da imagem conceitual não foram incorporadas como assets; o logo existente foi preservado.

A base financeira, os repositórios e o esquema local permanecem os mesmos da etapa 5. O banco continua na versão 3. Após o retorno do usuário sobre esta prévia, ajustar os detalhes necessários e seguir para metas e objetivos.

Verificar cada mudança visual em 390 e 1440 px, formulários, valores ocultos e estados vazios. Capturas de validação usam somente dados fictícios em perfil isolado.

## Fontes e licenças

Arquivos incluídos localmente a partir do repositório oficial Google Fonts:
- [Trocchi](https://github.com/google/fonts/tree/main/ofl/trocchi), com licença em app_flutter/assets/fonts/Trocchi-OFL.txt.
- [JetBrains Mono](https://github.com/google/fonts/tree/main/ofl/jetbrainsmono), com licença em app_flutter/assets/fonts/JetBrainsMono-OFL.txt.
- Inter e sua licença já estavam no projeto.

Nenhuma fonte precisa ser buscada na internet durante o uso do aplicativo.


## Refinamento 0.3.2 — títulos e menos texto

Retorno de 15/09/2026: o usuário acrescentou o will bank como referência de simplicidade, pediu títulos mais escuros e encorpados e uma interface mais intuitiva, com menos explicações permanentes. As novas imagens estão em referencias-visuais/site-tipografia-02.png e will-bank-referencia.png.

Esta rodada é incremental:
- Trocchi com peso solicitado 700 nos títulos, correspondendo ao font-bold do Hero.tsx original. O arquivo local continua sendo Trocchi Regular; o peso adicional depende da síntese do renderizador, como no site que carrega apenas o peso 400. Valores monetários mantêm peso regular.
- Fundo off-white mais claro #FAF9F5, cards brancos #FFFFFF e contornos #DEDDD6. Preto e amarelo da marca preservados.
- Traço dos ícones ajustado para 1,65; cartões e calendários ganham cantos curvos. Todos mantêm a grade de 24 unidades e a área de toque original.
- Início com título “Seu dinheiro”, ações em “Movimentar” e sem o parágrafo motivacional nem a repetição do logo nesse card.
- Métricas com nome e valor; definições disponíveis por tooltip e na seção recolhida “Sobre os valores”. Alertas de saldo negativo e previsões vencidas permanecem visíveis.
- Resumo da agenda mais curto, com a indicação de que são previsões para 30 dias sem faturas.

O objetivo é aproximar a hierarquia e a leveza das referências, preservando a marca Canguruu. A referência will bank não define uma nova fonte nem substitui o logo. A próxima rodada pode refinar outras telas a partir do retorno sobre esta prévia.


## Refinamento 0.3.3 — valores e profundidade

Os destaques monetários de Contas, Cartões e Agenda passam a usar CanguruuType.amount (Trocchi regular), como o saldo principal. O componente CanguruuBackground aplica duas variações radiais discretas de amarelo e off-white na área principal das sete telas. Direção e critérios em app_flutter/docs/refinamento-0.3.3.md.


## Navegação sem animação

Preferência do usuário em 16/09/2026: troca direta entre funções. As sete rotas usam NoTransitionPage e a barra de navegação tem duração de seleção zero. Manter esse comportamento nas próximas telas.


## Refinamento 0.3.4 — UI flutuante

A referência enviada em 25/09/2026 orienta a próxima camada: superfícies brancas mais arredondadas e flutuantes, controles em formato de cápsula, fundo com luzes suaves e hierarquia compacta. As cores Canguruu, o logo, as funções e os dados locais permanecem. A troca de telas continua sem animação.
