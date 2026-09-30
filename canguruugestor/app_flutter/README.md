# Canguruu · Finanças pessoais

Aplicativo Flutter independente do site Next.js existente em `duarte`. Esta é a **etapa 6: metas e reservas locais**, versão 0.4.0, com revisão visual baseada nas referências da marca e construída sobre a fundação local da etapa 3. O site e os materiais de referência foram preservados.

## Refinamento visual 0.3.3

Valores de contas, limites, faturas e previsões usam a mesma fonte Trocchi do saldo principal. O fundo compartilhado ganhou variações suaves de off-white e amarelo. Critérios em docs/refinamento-0.3.3.md, resultados em docs/validacao-visual-0.3.3.json e capturas em docs/screenshots/visual-0.3.3/.

## Refinamento visual 0.3.2

Títulos Trocchi em negrito, superfícies mais claras e ícones com contornos suaves. A página inicial usa textos curtos e atalhos com ícone acima do nome; as explicações das métricas ficam em “Sobre os valores”. O logo, as fontes locais e as regras financeiras foram preservados. A direção responde às novas referências do site e do will bank enviadas pelo usuário.

Critérios em docs/refinamento-0.3.2.md e no guia compartilhado ../docs/03-identidade-visual.md. O relatório desta rodada está em docs/validacao-visual-0.3.2.json; capturas em docs/screenshots/visual-0.3.2/. A revisão anterior está preservada abaixo.

## Revisão visual 0.3.1

A direção visual está registrada em ../docs/03-identidade-visual.md. Foram incluídas Trocchi e JetBrains Mono como fontes locais, preservando Inter. A revisão padroniza ícones SVG de traço fino, títulos com marcação amarela, cards com contorno, controles e navegação mobile. A prévia aguarda o retorno visual do usuário antes da próxima etapa funcional.

Validação específica: análise sem problemas, sete testes de interface aprovados e revisão das sete telas em 390/1440 px, incluindo formulários e carregamento offline. O relatório está em docs/validacao-visual-0.3.1.json. Os 82 testes e a validação de backup descritos abaixo pertencem à entrega funcional 0.3.0; esta revisão não altera o esquema nem as regras financeiras.

O teste tool/visual_qa.mjs utiliza a cópia fictícia build/qa/schedule-backup.json produzida pela validação da etapa 5. Uma outra cópia de teste pode ser fornecida por CANGURUU_VISUAL_FIXTURE. As capturas estão em docs/screenshots/visual-0.3.1/.

## O que já funciona

- Contas bancárias e dinheiro/carteira, com data e saldo inicial.
- Receitas, despesas e transferências entre contas.
- Categorias e subcategorias em dois níveis; classificação de custo fixo/variável e essencial.
- Saldo consolidado, receitas, despesas e resultado mensal; evolução diária do saldo registrado.
- Cartões com limite total, utilizado e disponível; excesso de limite e dívida inicial.
- Compra à vista ou parcelada no cartão, com prévia de valores e vencimentos, categoria e processamento.
- Faturas por ciclo, cobranças, parcelas pendentes, pagamentos parciais/integral e gráfico dos vencimentos em aberto.
- Dívida dos cartões e patrimônio registrado no painel, sem duplicar despesas ao pagar faturas.
- Agenda de receitas, despesas, transferências e compras no cartão previstas, avulsas ou recorrentes.
- Recorrências diárias, semanais, mensais e anuais; pausa, retomada, edição individual ou das próximas.
- Confirmação integral de cada ocorrência, alerta de vencidas e resumo dos próximos 30 dias no painel.
- Histórico com busca, filtros e estorno que preserva a movimentação original.
- Arquivamento de contas com saldo zero.
- Exportação de cópia JSON e restauração com confirmação, validação em banco temporário e substituição atômica.
- Layout responsivo para desktop e celular; logo original, amarelo, preto, off-white e fonte Inter incluída localmente.
- Persistência Drift + SQLite. Sem Supabase, autenticação, telemetria ou serviço financeiro externo.

O aplicativo começa sem contas ou movimentações fictícias. As oito categorias iniciais são sugestões de organização.

Metas e reservas locais agora estão persistidas em Drift/SQLite, com cobertura proporcional explicável, revisão e navegação própria. Planejamento, projeções avançadas e recomendações entram nas próximas etapas. Seus contratos financeiros estão no documento `../docs/02-especificacao-financeira.md`.

## Executar

Ambiente usado: Flutter 3.35.7, Dart 3.9.2. As dependências resolvidas estão em `pubspec.lock`. Não é necessário atualizar o Flutter global para esta entrega.

Na pasta `app_flutter`:

```powershell
flutter pub get
flutter run -d windows
```

Para desenvolver a versão Web:

```powershell
flutter run -d chrome
```

Para uma prévia com cache offline, usar o build de produção:

```powershell
.\tool\build_web.ps1
node tool/serve.mjs 5187
```

Abrir `http://127.0.0.1:5187`. O servidor de prévia atende somente o computador local. Usa os cabeçalhos COOP/COEP e o tipo MIME de WASM adequados para SQLite no navegador. O primeiro carregamento precisa do servidor; o funcionamento offline depende dos recursos já armazenados pelo navegador.

Para Android, com aparelho ou emulador configurado:

```powershell
flutter run -d <identificador-do-dispositivo>
flutter build apk --debug
```

## Organização do código

```text
lib/
  app/                         tema, rotas e composição das dependências
  core/                        centavos exatos, data civil, relógio e erros
  features/
    finance/
      domain/
        models.dart
        repositories/          contratos por intenção financeira
        services/              invariantes do livro financeiro
        use_cases/             ações consumidas pelas telas
      data/
        local_finance_repository.dart
        services/              backup e validação do conjunto relacional
      presentation/            painel, contas, histórico, categorias e formulários
    cards/
      domain/                  ciclos, centavos das parcelas, faturas e contrato do repositório
      data/                    compras, pagamentos e validação relacional de cartões
      presentation/            cartões, prévia de parcelas e detalhe das faturas
    schedule/
      domain/                  calendário, ocorrências, regras e contrato do repositório
      data/                    geração, realização e validação relacional da agenda
      presentation/            agenda, recorrências, formulários e resumo no painel
    backup/
      domain/                  contrato de seleção/exportação de arquivos
      data/                    adaptador de arquivos por plataforma
      presentation/            preferências e restauração
  persistence/                 esquema Drift, migração e gravação transacional compartilhada
  shared/presentation/         componentes e formatação reutilizáveis
test/                          regras, transações, backup, esquema e telas
drift_schemas/                 fotografias imutáveis dos esquemas v1, v2 e v3
tool/                          geração de ícones, prévia e validação Web
assets/                        marca original e fonte com licença
android/ · web/ · windows/     projetos de plataforma
```

Nesta fundação, contas e movimentações compartilham o módulo `finance` porque participam das mesmas transações. O módulo `cards` usa a mesma conexão e a mesma unidade de gravação `LedgerWriter`, que garante a transação de evento, lançamentos, parcelas/alocações e recibo. O módulo `schedule` compartilha a mesma transação ao confirmar uma ocorrência: a movimentação e seu vínculo com a previsão são gravados juntos. O módulo de metas e planejamento será adicionado em sua etapa.

A apresentação depende dos contratos e modelos do domínio. Somente a composição em `app/providers.dart` escolhe a implementação local. Os modelos do domínio não importam Flutter, Drift ou plugins. Uma futura implementação de API pode substituir o repositório sem reescrever as telas.

Sincronização não é apenas trocar a conexão: autenticação, conflitos, filas de envio, exclusões sincronizadas e identidade remota serão implementados na etapa de integração. Não há sincronização pronta ou chamada remota oculta.

## Regras de integridade já aplicadas

1. Dinheiro é armazenado em centavos inteiros, com limite interoperável de ±9.007.199.254.740.991 centavos. Leitura de texto e somas usam operações exatas; intermediários usam `BigInt`. Somente a geometria do gráfico usa ponto flutuante.
2. Datas financeiras são civis, no formato `AAAA-MM-DD`, separadas do instante UTC de registro. O relógio é injetável; a data atual usa o calendário de São Paulo.
3. Cada evento possui dois lançamentos cuja soma é zero. Receita, despesa, transferência e saldo inicial têm composições distintas.
4. Saldo inicial e transferência não entram nas receitas ou despesas. Saldos negativos reais são permitidos e sinalizados.
5. Evento, lançamentos e recibo de idempotência são gravados na mesma transação. Uma falha no segundo lançamento desfaz todos os registros daquela operação.
6. Repetir uma chave com os mesmos dados retorna o resultado anterior. Reusar a chave com outros dados produz um conflito.
7. Estornos criam lançamentos opostos e preservam o original. A data do estorno define o mês de sua compensação.
8. Contas arquivadas mantêm suas referências e histórico. Categorias não admitem ciclos, terceiro nível ou subcategorias de outro tipo.
9. Os totais são derivados do livro financeiro. Não existe saldo separado que a interface precise atualizar.
10. A restauração valida versão, moeda, tipos, vínculos, datas, soma dos lançamentos, composição dos eventos, estornos e recibos. Depois verifica as restrições SQLite em outra conexão, em memória. O banco atual só muda após essa validação, numa transação única.

## Banco e evolução

O esquema v1 contém `profiles`, `ledger_accounts`, `accounts`, `categories`, `financial_events`, `postings` e `operation_receipts`. A v2 acrescenta `credit_cards`, `card_operations`, `invoices`, `invoice_items`, `invoice_payments` e `invoice_payment_allocations`. A v3 acrescenta `recurrence_series`, `recurrence_rule_versions` e `scheduled_occurrences`, com índices únicos para regra atual, ordinal e data ativa da série.

IDs dos registros criados são UUIDs, preservados nos backups. Perfil único e contas internas usam identificadores locais reservados. A associação a uma identidade remota será responsabilidade da futura camada de dados.

SQLite habilita chaves estrangeiras. Há índices para datas, contas e categorias. Não existe recriação destrutiva do banco quando a versão muda. A versão atual é a v3. Migrações explícitas v1 → v3 e v2 → v3 adicionam as tabelas necessárias numa transação, mantendo IDs, valores, eventos e recibos. As três fotografias do esquema foram preservadas. Os testes comparam os registros anteriores, incluindo transferências, estornos, cartões, parcelas e pagamentos. Uma versão desconhecida é recusada.

Para alterar o esquema numa próxima etapa:

```powershell
dart run build_runner build
dart run drift_dev schema dump lib/persistence/database.dart drift_schemas
dart run drift_dev schema generate drift_schemas test/generated_migrations
flutter test
```

Ao evoluir: aumentar `schemaVersion`, escrever uma migração explícita, preservar todas as fotografias históricas e testar a passagem da versão anterior com dados financeiros reais de teste. Não sobrescrever uma fotografia histórica para fazer o teste passar.

## Persistência e backup por plataforma

- **Windows:** arquivo SQLite na pasta de suporte do aplicativo; backup com escolha de arquivo pelo usuário.
- **Android:** SQLite no armazenamento do aplicativo; exportação pelo seletor de documentos do sistema, sem permissão ampla de armazenamento. Backup automático de nuvem desabilitado no manifesto.
- **Web:** SQLite/WASM com armazenamento persistente escolhido pelo Drift conforme os recursos do navegador. Modos em memória ou IndexedDB sem proteção adequada são recusados. Recursos do app, fonte, worker e WASM são servidos localmente.

Dados do navegador pertencem à origem, incluindo a porta. Abrir outra porta não mostra automaticamente os mesmos dados. Limpar os dados do site ou desinstalar o aplicativo pode remover a base; exportar uma cópia é a forma de transportá-la.

O backup usa envelope JSON de formato 1, esquema 3, sem criptografia e com limite de 10 MB. Backups dos esquemas 1 e 2 continuam importáveis: a adaptação adiciona as coleções ausentes vazias e passa pela mesma validação. O resumo da restauração informa também a quantidade de cartões e previsões. Restaurar substitui a base; não mescla conjuntos. Repetir a mesma restauração não duplica registros. Não há envio automático para nuvem.

## Verificação

```powershell
flutter analyze
flutter test
```

**Resultado confirmado no código desta etapa:** análise sem problemas e 82 testes aprovados. Além da base financeira e dos cartões, cobrem calendário de recorrências (dia 31 e ano bissexto), geração sem duplicação, pausa e retomada, edição individual e de versões futuras, confirmação concorrente, classificação histórica, reversão de transação após falha injetada, limites de valores, backup v3 e migrações a partir das versões 1 e 2. Os formulários de agenda foram testados em 390 e 1440 px.

Passaram 16 cenários Web, sem erros JavaScript ou requisições HTTP externas do app. As capturas de desktop e celular estão em `docs/screenshots/agenda-*.png`. Web e Windows foram compilados em release.

**Limite da verificação Web:** downloads nativos encerraram intermitentemente as sessões de teste do Chrome e do Edge após reinícios sucessivos; a causa ainda não foi determinada. A execução completa usou `CANGURUU_CAPTURE_BACKUPS=1`: a automação captura o JSON real gerado pelo app antes de salvar pelo navegador e o restaura pela interface. Isso não muda o aplicativo. Um teste separado, em nova sessão do Chrome, baixou normalmente uma cópia v3 completa da agenda e comparou todos os registros com o original.

`tool/browser_qa.mjs` mantém o modo de download nativo por padrão; aceita `CANGURUU_BROWSER=msedge` e o modo de captura descrito acima. `tool/native_backup_qa.mjs` verifica o download nativo em sessão nova usando a cópia fictícia `build/qa/schedule-backup.json` produzida pelo primeiro teste. Não confundir a execução completa com uma confirmação de estabilidade do download nativo após reinícios.

A validação da etapa está em `docs/validacao-etapa-5.json`; os relatórios das etapas 3 e 4 foram preservados. O teste reproduzível `tool/browser_qa.mjs` cobre também criação de recorrência offline, realização de uma ocorrência, pausa, reinício, retomada, restauração de agenda e cadastro no celular.

O pacote atualizado está em `dist/Canguruu-Windows-0.3.3.zip`. Extraia a pasta completa e abra `canguruu_finance.exe`; mantenha as DLLs e a pasta `data` junto do executável. Depois de atualizar a base para v3, use a versão 0.3 ou posterior para abri-la.

A compilação Android foi tentada, mas o Java 21.0.6 do ambiente falhou antes da compilação do aplicativo com `Unable to establish loopback connection`, causada por `UnixDomainSockets.connect0: Invalid argument`. A tentativa com IPv4 não resolveu. Portanto, **não há APK validado nesta entrega**. A estrutura Android e a exportação nativa precisam ser verificadas em um ambiente de build funcional e em aparelho/emulador. Nenhuma configuração de segurança do Windows foi alterada.

O teste reproduzível de navegador é `tool/browser_qa.mjs`. Usa Chrome e Playwright, cria um perfil exclusivo dentro de `build/qa` e nunca acessa o perfil pessoal do navegador. Para executá-lo, o módulo `playwright` deve estar disponível ao Node; opcionalmente informar sua URL de módulo em `CANGURUU_PLAYWRIGHT`. O servidor local precisa estar ativo. Capturas e relatório ficam em `build/qa`.

## Regras de cartões implementadas

- R$ 100,00 em 3 vezes resulta em R$ 33,34 + R$ 33,33 + R$ 33,33. Quantidade entre 1 e 360, sem parcela de zero centavo. A divisão usa inteiros exatos inclusive na Web.
- A compra reconhece todo o consumo e a dívida na data efetiva. Processamento define o ciclo; parcelas organizam a cobrança e não geram lançamentos financeiros adicionais.
- Política padrão: compra no dia do fechamento vai ao ciclo seguinte. A alternativa “ciclo atual” é escolhida no cadastro. O vencimento é a primeira ocorrência estritamente posterior ao fechamento.
- Dias inexistentes são limitados ao fim do mês sem esquecer o dia configurado para os meses seguintes. Não há adiamento automático por feriados.
- Registro em ciclo já encerrado exige conferência explícita, preservada na operação. A dívida inicial é uma cobrança única no primeiro ciclo calculado e usa contrapartida patrimonial, sem nova despesa.
- Pagamento realizado reduz a conta e a dívida na mesma transação. Pode ser parcial ou quitar antecipadamente uma fatura futura; excesso é recusado. Um pagamento retroativo não pode produzir saldo negativo em qualquer data posterior da fatura já registrada.
- Ciclo aberto/encerrado, situação do pagamento e atraso são apresentados separadamente. Uma fatura aberta com saldo zero permanece aberta para novas compras.
- Limite inclui parcelas futuras. Dívida real acima do limite é aceita e sinalizada, com disponível igual a zero.
- Distribuição interna dos pagamentos por item: processamento mais antigo, sequência e ID. Essa política reduz parcelas pendentes e não pretende reproduzir a distribuição do emissor.

## Regras de agenda implementadas

- Previsões são compromissos pendentes. Não afetam saldo, despesa realizada, dívida nem limite até a confirmação.
- Diárias e semanais usam intervalos de dias civis. Mensais e anuais preservam o dia original, limitando ao último dia do mês quando necessário; há opção explícita de último dia.
- A geração inicial cobre até 90 dias a partir de hoje. A tela permite ampliar para 12 meses. O repositório aceita até dois anos adiante e limita cada geração a 5.000 novas ocorrências; cada regra também limita a janela calculada a 5.000 datas. Recorrências muito antigas devem começar em uma data mais recente.
- Quantidade máxima e data final são opcionais. A contagem considera as posições do calendário da regra, inclusive as que ficam no período de pausa.
- Gerar novamente preserva IDs, exceções, ignoradas e realizações. Pausar cancela somente as pendentes de hoje em diante; vencidas anteriores e realizadas permanecem.
- Retomar cria nova versão com a mesma âncora. O intervalo suspenso não é recriado. Uma ocorrência já realizada na mesma data não é duplicada.
- “Editar esta previsão” altera apenas a ocorrência pendente. “Editar próximas” cria uma versão a partir da data escolhida e substitui somente as pendentes futuras. Se a série estiver pausada, a edição mantém a pausa.
- Confirmar é uma ação manual e integral, com data realizada até hoje. Mudanças de valor devem ser feitas antes da confirmação. Não há débito automático, juros presumidos ou liquidação parcial da previsão.
- A realização cria o evento financeiro e vincula a ocorrência na mesma transação. Repetir a mesma solicitação não duplica dinheiro nem dívida.
- Compra prevista de cartão gera uma compra de parcela única quando confirmada. Pagamento de fatura continua no módulo de cartões.
- Categoria e classificação de despesa são preservadas como estavam na previsão. Referências arquivadas precisam ser substituídas por opções ativas antes de confirmar.
- Estornar uma movimentação realizada pela agenda preserva o vínculo histórico e sinaliza o estorno; não reabre automaticamente a previsão.
- O resumo de 30 dias mostra os valores cadastrados pendentes. Ainda não é uma projeção completa de fluxo de caixa e não incorpora automaticamente faturas ou transferências.

## Limites desta etapa e próximos passos

- O painel trabalha com uma fotografia completa do histórico local. Antes de escalar para bases grandes e relatórios, introduzir consultas agregadas e paginação no repositório. A interface já recebe um modelo independente do banco. O módulo de cartões também carrega o conjunto local; otimização por consultas agregadas e paginação continua planejada.
- O perfil inicial é único, em BRL. Não há múltiplas moedas, autenticação, Open Finance ou conexão com bancos.
- Arquivamento e estorno estão disponíveis; edição ampla, conciliação de saldo inicial e reativação de contas não foram incluídas nesta primeira interface.
- Distribuição assinada, instalador, testes em aparelhos Android e validação de outros sistemas desktop são etapas próprias.
- Configuração do cartão permanece fixa após o cadastro nesta etapa. Alteração de limite/datas com histórico, conciliação manual de datas, encargos, reembolsos, estornos de cartão, reversão de pagamento, transferência de créditos e reorganização de parcelas serão fluxos próprios. O estorno genérico recusa eventos de cartão para não deixar cobranças ou alocações inconsistentes.
- O fluxo de pagamento registra uma fatura por vez e não inicia pagamentos no banco. O gráfico mostra valores conhecidos cadastrados, sem estimar consumo futuro.
- Próxima entrega funcional: metas e objetivos financeiros; depois compras planejadas, projeções e motor de recomendações explicáveis.

## Origem dos recursos

- Marca: cópias de `duarte/public/ocanguruu.svg` e `duarte/public/logolight.svg`. A geometria foi preservada; as regras CSS de preenchimento foram convertidas em atributos SVG para compatibilidade com Flutter. Os ícones são rasterizações desses vetores.
- Inter: [repositório oficial Google Fonts](https://github.com/google/fonts/tree/main/ofl/inter), com licença SIL OFL incluída em `assets/fonts/OFL.txt`. SHA-256 do arquivo: `29160a80ff49ddcab2c97711247e08b1fab27a484a329ce8b813d820dc559031`.
- Roboto de reserva do renderizador Web: cópia local do recurso v32 utilizado pelo Flutter, com licença Apache 2.0 em `web/fonts/LICENSE-Roboto.txt`. O endereço de fontes de reserva do motor aponta para arquivos locais, sem consulta automática ao Google.
- SQLite/WASM 2.9.4: [release oficial sqlite3.dart](https://github.com/simolus3/sqlite3.dart/releases/tag/sqlite3-2.9.4). SHA-256: `922a76b182b6af69b030c8e2fdd3283ecc8e827248b20e4b1f3f3db170b52117`.
- Migrações: [procedimento transacional e alteração de restrições no Drift](https://drift.simonbinder.eu/migrations/api/).
- Referências: [Drift](https://drift.simonbinder.eu/), [Flutter](https://docs.flutter.dev/), [Riverpod](https://riverpod.dev/), [go_router](https://pub.dev/packages/go_router).

Riverpod 2.6.1, Drift 2.30.0 e drift_flutter 0.2.8 foram escolhidos para compatibilidade com o SDK instalado. Atualizações devem ser coordenadas e verificadas com os testes, sem sobrepor os limites de versão de ferramentas do Flutter.

