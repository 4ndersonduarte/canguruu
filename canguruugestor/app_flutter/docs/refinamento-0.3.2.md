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
