# Refinamento visual 0.3.3

Rodada solicitada em 16/09/2026: aplicar a fonte do saldo das contas aos valores de Cartões e Agenda e dar profundidade ao fundo.

## Valores

CanguruuType.amount é o estilo compartilhado dos destaques monetários: Trocchi local, peso regular, altura 1,3. Aplicado ao saldo principal, saldos individuais de contas, limite disponível, saldo das faturas, totais de previsões e valor de cada previsão na agenda. Tamanhos variam de 18 a 34 conforme a hierarquia. Os títulos continuam em negrito.

FittedBox com scaleDown protege os espaços destinados a valores. O controle de ocultação continua usando o formatador comum. As descrições e os detalhes das listas mantêm Inter para leitura compacta.

## Fundo

Novo componente compartilhado CanguruuBackground: base off-white, luz amarela suave no canto superior direito e uma variação quente discreta no canto inferior esquerdo. Os gradientes são estáticos e renderizados pelo Flutter, sem imagens, downloads, desfoque ou animação. Aplicado à área principal das sete telas, incluindo o cabeçalho; cards brancos e navegação permanecem legíveis.

## Escopo e verificação

Somente apresentação, versão e documentação. Sem alteração das regras financeiras ou do esquema local (versão 3). Verificação em 390 e 1440 px, incluindo valores ocultos em Cartões e Agenda, formulários e carregamento offline. Resultados registrados em validacao-visual-0.3.3.json e capturas em screenshots/visual-0.3.3/.
