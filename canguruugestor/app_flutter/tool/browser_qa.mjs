import assert from 'node:assert/strict';
import { mkdir, mkdtemp, readFile, writeFile } from 'node:fs/promises';
import { resolve } from 'node:path';

const { chromium } = await import(process.env.CANGURUU_PLAYWRIGHT || 'playwright');
const base = process.env.CANGURUU_BASE_URL || 'http://127.0.0.1:5187';
const output = resolve('build/qa');
await mkdir(output, {recursive:true});
const profile = await mkdtemp(resolve(output, 'profile-'));
const downloads = resolve(profile, 'downloads');
await mkdir(downloads, {recursive:true});
const captureBackups = process.env.CANGURUU_CAPTURE_BACKUPS === '1';
const issues = [];
const externalRequests = new Set();
const passed = [];
let context;
let page;
let stage = 'início';

async function launch() {
  context = await chromium.launchPersistentContext(profile, {
    channel:process.env.CANGURUU_BROWSER || 'chrome', headless:true, viewport:{width:1440,height:1000},
    locale:'pt-BR', acceptDownloads:true, downloadsPath:downloads
  });
  if (captureBackups) await context.addInitScript(() => {
    window.__qaBackup = null;
    document.addEventListener('click', event => {
      const anchor = event.target.closest?.('a[download]');
      if (!anchor || !anchor.href.startsWith('blob:')) return;
      event.preventDefault();
      fetch(anchor.href).then(r=>r.text()).then(text=>{ window.__qaBackup = text; });
    }, true);
  });
  context.on('request', request => {
    const url = request.url();
    if (/^https?:/.test(url) && !url.startsWith(base)) {
      externalRequests.add(url); console.log('Recurso externo observado: ' + url);
    }
  });
  page = context.pages()[0] || await context.newPage();
  page.on('pageerror', error => issues.push(error.message));
}
async function ready(text) {
  await page.locator('flutter-view').waitFor({state:'attached',timeout:30000});
  const placeholder = page.locator('flt-semantics-placeholder');
  if (await placeholder.count()) await placeholder.evaluate(element => element.click());
  await page.getByText(text,{exact:true}).first().waitFor({timeout:30000});
}
async function navigate(path, heading) {
  await page.goto(base + '/#' + path, {waitUntil:'domcontentloaded',timeout:60000});
  await ready(heading);
}
async function enter(field, value) {
  for (let attempt = 0; attempt < 3; attempt++) {
    await field.click();
    await page.waitForTimeout(120);
    await field.press('ControlOrMeta+A');
    await page.waitForTimeout(100);
    await field.press('Backspace');
    await page.waitForTimeout(100);
    await field.pressSequentially(value, {delay:40});
    await page.waitForTimeout(100);
    if (await field.inputValue() === value) {
      await field.press('Tab');
      return;
    }
  }
  assert.equal(await field.inputValue(),value,'Valor digitado no formulário');
}
async function exportBackup(path) {
  if (captureBackups) {
    await page.evaluate(() => { window.__qaBackup = null; });
    await page.getByRole('button',{name:'Exportar cópia',exact:true}).click();
    await page.waitForFunction(() => typeof window.__qaBackup === 'string');
    await writeFile(path, await page.evaluate(() => window.__qaBackup));
  } else {
    const download = page.waitForEvent('download');
    await page.getByRole('button',{name:'Exportar cópia',exact:true}).click();
    await (await download).saveAs(path);
  }
}
async function createAccount(name, value, wallet = false) {
  await page.getByRole('button',{name:'Adicionar conta',exact:true}).click();
  await enter(page.getByRole('textbox',{name:/Nome da conta/}), name);
  await enter(page.getByRole('textbox',{name:'Saldo inicial',exact:true}), value);
  if (wallet) await page.getByRole('radio',{name:'Carteira',exact:true}).click();
  await page.getByRole('button',{name:'Salvar',exact:true}).click();
  await page.getByRole('dialog').waitFor({state:'hidden'});
}
async function movement(kind, value, description, category) {
  await page.getByRole('button',{name:'Nova movimentação',exact:true}).click();
  await page.getByRole('radio',{name:kind,exact:true}).click();
  await enter(page.getByRole('textbox',{name:/^Valor/}), value);
  await enter(page.getByRole('textbox',{name:/^Descrição/}), description);
  if (kind === 'Transferir') {
    await page.getByRole('button',{name:/Conta de destino/}).click();
    await page.getByRole('menuitem',{name:'Carteira de teste',exact:true}).click();
  } else {
    await page.getByRole('button',{name:/Categoria/}).click();
    await page.getByRole('menuitem',{name:category,exact:true}).click();
  }
  await page.getByRole('button',{name:'Registrar movimentação',exact:true}).click();
  await page.getByRole('dialog').waitFor({state:'hidden'});
}
async function payments(expected) {
  const buttons = page.getByRole('button',{name:'Confirmar pagamento',exact:true});
  await buttons.nth(expected - 1).waitFor();
  assert.equal(await buttons.count(),expected);
}
async function balance(expected) {
  await page.getByText(expected,{exact:false}).or(page.getByRole('group',{name:expected,exact:false})).or(page.getByRole('button',{name:expected,exact:false})).first().waitFor({timeout:15000});
}
try {
  await launch();
  stage = 'painel vazio'; console.log('Validando: painel vazio');
  await navigate('/', 'Seu dinheiro');
  await page.screenshot({path:resolve(output,'dashboard-empty.png')});
  await page.getByText('Contas',{exact:true}).waitFor();
  passed.push('Navegação disponível na árvore de acessibilidade');
  stage = 'contas'; console.log('Validando: contas');
  await navigate('/accounts', 'Suas contas');
  await createAccount('Banco de teste', '1.000,00');
  await createAccount('Carteira de teste', '100,00', true);
  stage = 'receita'; console.log('Validando: receita');
  await navigate('/', 'Seu dinheiro');
  await movement('Receita', '3.000,00', 'Salário de teste', 'Salário');
  stage = 'despesa'; console.log('Validando: despesa');
  await movement('Despesa', '225,50', 'Mercado de teste', 'Alimentação');
  stage = 'transferência'; console.log('Validando: transferência');
  await movement('Transferir', '150,00', 'Transferência de teste');
  await balance('R$ 3.874,50');
  passed.push('Duas contas, receita, despesa e transferência com saldo de R$ 3.874,50');
  await page.screenshot({path:resolve(output,'dashboard-recorded.png')});
  stage = 'exportação'; console.log('Validando: exportação');
  await navigate('/settings', 'Seu espaço, suas escolhas');
  const backupPath = resolve(output, 'roundtrip-backup.json');
  await exportBackup(backupPath);
  const backup = JSON.parse(await readFile(backupPath,'utf8'));
  assert.equal(backup.tables.accounts.length,2);
  assert.equal(backup.tables.financial_events.length,5);
  passed.push('Exportação JSON pelo navegador');
  stage = 'restauração'; console.log('Validando: restauração');
  await navigate('/', 'Seu dinheiro');
  await movement('Receita','9,00','Receita temporária de teste','Salário');
  await balance('R$ 3.883,50');
  await navigate('/settings','Seu espaço, suas escolhas');
  const chooserPromise = page.waitForEvent('filechooser');
  await page.getByRole('button',{name:'Restaurar cópia',exact:true}).click();
  await (await chooserPromise).setFiles(backupPath);
  await page.getByRole('button',{name:'Substituir e restaurar',exact:true}).click();
  await page.getByRole('group',{name:/Cópia restaurada. Saldos e histórico foram atualizados/}).waitFor();
  await navigate('/', 'Seu dinheiro');
  await balance('R$ 3.874,50');
  passed.push('Restauração substitui os dados e preserva o saldo');
  stage = 'reinício do navegador'; console.log('Validando: reinício do navegador');
  await context.close();
  await launch();
  await navigate('/', 'Seu dinheiro');
  await balance('R$ 3.874,50');
  passed.push('Saldo preservado após fechar e reabrir o navegador');
  stage = 'offline'; console.log('Validando: offline');
  await page.waitForFunction(() => navigator.serviceWorker.controller !== null);
  await context.setOffline(true);
  await page.reload({waitUntil:'domcontentloaded'});
  await ready('Seu dinheiro');
  await balance('R$ 3.874,50');
  await movement('Despesa','5,00','Despesa offline de teste','Alimentação');
  await balance('R$ 3.869,50');
  await page.reload({waitUntil:'domcontentloaded'});
  await ready('Seu dinheiro');
  await balance('R$ 3.869,50');
  passed.push('Reabertura, gravação e persistência de uma despesa sem conexão');
  stage = 'cartão e compra parcelada offline'; console.log('Validando: cartão e compra parcelada offline');
  await navigate('/cards', 'Seus cartões');
  await page.getByRole('button',{name:'Adicionar cartão',exact:true}).click();
  await enter(page.getByRole('textbox',{name:/Nome do cartão/}), 'Cartão de teste');
  await enter(page.getByRole('textbox',{name:'Limite total',exact:true}), '2.000,00');
  await enter(page.getByRole('textbox',{name:'Dia de fechamento',exact:true}), '31');
  await enter(page.getByRole('textbox',{name:'Dia de vencimento',exact:true}), '10');
  await page.getByRole('button',{name:'Salvar',exact:true}).click();
  await page.getByRole('dialog').waitFor({state:'hidden'});
  await balance('R$ 2.000,00');
  async function purchase(value, count, description) {
    await page.getByRole('button',{name:'Nova compra',exact:true}).click();
    await enter(page.getByRole('textbox',{name:'Valor total da compra',exact:true}), value);
    await enter(page.getByRole('textbox',{name:/Descrição da compra/}), description);
    await enter(page.getByRole('textbox',{name:'Número de parcelas',exact:true}), count);
    await page.getByRole('button',{name:/Categoria da compra/}).click();
    await page.getByRole('menuitem',{name:'Alimentação',exact:true}).click();
    await page.getByRole('button',{name:'Registrar compra',exact:true}).click();
    await page.getByRole('dialog').waitFor({state:'hidden'});
  }
  await purchase('100,00','3','Compra parcelada de teste');
  await balance('R$ 1.900,00');
  await balance('R$ 33,34');
  await balance('R$ 33,33');
  passed.push('Cartão e compra em 3 parcelas criados offline com centavos exatos');
  stage = 'pagamento de fatura'; console.log('Validando: pagamento de fatura');
  await page.getByRole('button',{name:'Registrar pagamento',exact:true}).first().click();
  await enter(page.getByRole('textbox',{name:'Valor pago',exact:true}), '10,00');
  await page.getByRole('button',{name:'Confirmar pagamento',exact:true}).click();
  await page.getByRole('dialog').waitFor({state:'hidden'});
  await balance('R$ 1.910,00');
  await page.getByRole('group',{name:/Pagamento parcial/}).first().waitFor();
  await page.screenshot({path:resolve(output,'cards-desktop.png')});
  await navigate('/', 'Seu dinheiro');
  await balance('R$ 3.859,50');
  await balance('R$ 330,50');
  await balance('R$ 3.769,50');
  passed.push('Pagamento parcial reduz conta e dívida sem duplicar despesa; patrimônio reconciliado');
  stage = 'backup de cartões'; console.log('Validando: backup de cartões');
  await context.setOffline(false);
  await navigate('/settings','Seu espaço, suas escolhas');
  const cardBackupPath = resolve(output,'cards-backup.json');
  await exportBackup(cardBackupPath);
  const cardBackup = JSON.parse(await readFile(cardBackupPath,'utf8'));
  assert.equal(cardBackup.schema_version,3);
  assert.equal(cardBackup.tables.credit_cards.length,1);
  assert.equal(cardBackup.tables.card_operations.length,1);
  assert.equal(cardBackup.tables.invoice_items.length,3);
  assert.equal(cardBackup.tables.invoice_payment_allocations.length,1);
  await navigate('/cards','Seus cartões');
  await purchase('5,00','1','Compra temporária de teste');
  await navigate('/settings','Seu espaço, suas escolhas');
  const cardChooser = page.waitForEvent('filechooser');
  await page.getByRole('button',{name:'Restaurar cópia',exact:true}).click();
  await (await cardChooser).setFiles(cardBackupPath);
  await page.getByRole('button',{name:'Substituir e restaurar',exact:true}).click();
  await page.getByRole('group',{name:/Cópia restaurada. Saldos e histórico foram atualizados/}).waitFor();
  await navigate('/cards','Seus cartões');
  await balance('R$ 1.910,00');
  passed.push('Backup v3 exportado e restaurado com cartões, parcelas e pagamento');
  stage = 'reinício com cartões e nova compra offline'; console.log('Validando: reinício com cartões e nova compra offline');
  await context.close();
  await launch();
  await navigate('/cards','Seus cartões');
  await balance('R$ 1.910,00');
  await context.setOffline(true);
  await page.reload({waitUntil:'domcontentloaded'});
  await ready('Seus cartões');
  await purchase('1,00','1','Compra offline após reinício');
  await balance('R$ 1.909,00');
  await page.reload({waitUntil:'domcontentloaded'});
  await ready('Seus cartões');
  await balance('R$ 1.909,00');
  passed.push('Cartões preservados ao reiniciar o navegador; nova compra persiste offline');

  stage = 'recorrência offline'; console.log('Validando: recorrência offline');
  await navigate('/schedule','Sua agenda financeira');
  await page.getByRole('button',{name:'Nova recorrência',exact:true}).click();
  await enter(page.getByRole('textbox',{name:/Descrição da previsão/}), 'Assinatura de teste');
  await enter(page.getByRole('textbox',{name:'Valor previsto',exact:true}), '50,00');
  await page.getByRole('button',{name:/Categoria da previsão/}).click();
  await page.getByRole('menuitem',{name:'Alimentação',exact:true}).click();
  await enter(page.getByRole('textbox',{name:/Quantidade de ocorrências/}), '3');
  await page.getByRole('button',{name:'Salvar previsão',exact:true}).click();
  await page.getByRole('dialog').waitFor({state:'hidden'});
  await page.getByRole('button',{name:'Confirmar pagamento',exact:true}).first().waitFor();
  await payments(3);
  await navigate('/','Seu dinheiro');
  await balance('R$ 3.859,50');
  await balance('R$ 331,50');
  passed.push('Recorrência mensal offline gera 3 previsões sem alterar saldo nem despesa');
  stage = 'confirmar previsão'; console.log('Validando: confirmar previsão');
  await navigate('/schedule','Sua agenda financeira');
  await page.getByRole('button',{name:'Confirmar pagamento',exact:true}).first().click();
  await page.getByRole('button',{name:'Confirmar lançamento',exact:true}).click();
  await page.getByRole('dialog').waitFor({state:'hidden'});
  await payments(2);
  await navigate('/','Seu dinheiro');
  await balance('R$ 3.809,50');
  await balance('R$ 381,50');
  passed.push('Confirmar uma previsão reduz saldo uma única vez e preserva as 2 futuras');
  stage = 'pausar recorrência e backup'; console.log('Validando: pausar recorrência e backup');
  await navigate('/schedule','Sua agenda financeira');
  await page.getByText('Recorrências',{exact:true}).click();
  await page.getByRole('button',{name:'Pausar',exact:true}).click();
  await page.getByRole('alertdialog').getByRole('button',{name:'Pausar',exact:true}).click();
  await page.getByText('Pausada',{exact:true}).waitFor();
  await context.setOffline(false);
  await navigate('/settings','Seu espaço, suas escolhas');
  const agendaBackupPath = resolve(output,'schedule-backup.json');
  await exportBackup(agendaBackupPath);
  const agendaBackup = JSON.parse(await readFile(agendaBackupPath,'utf8'));
  assert.equal(agendaBackup.schema_version,3);
  assert.equal(agendaBackup.tables.recurrence_series.length,1);
  assert.ok(agendaBackup.tables.recurrence_series[0].paused_on);
  assert.equal(agendaBackup.tables.scheduled_occurrences.filter(o=>o.status==='settled').length,1);
  assert.equal(agendaBackup.tables.scheduled_occurrences.filter(o=>o.status==='cancelled').length,2);
  await context.close();
  await launch();
  await navigate('/schedule','Sua agenda financeira');
  await page.getByText('Recorrências',{exact:true}).click();
  await page.getByText('Pausada',{exact:true}).waitFor();
  await page.getByRole('button',{name:'Retomar',exact:true}).click();
  await page.getByRole('alertdialog').getByRole('button',{name:'Retomar',exact:true}).click();
  await page.getByText('Ativa',{exact:true}).waitFor();
  await page.getByText('Pendentes',{exact:true}).click();
  await payments(2);
  passed.push('Pausa persiste após reiniciar; retomada preserva realização e gera somente as futuras');
  stage = 'restaurar agenda'; console.log('Validando: restaurar agenda');
  await navigate('/settings','Seu espaço, suas escolhas');
  const agendaChooser = page.waitForEvent('filechooser');
  await page.getByRole('button',{name:'Restaurar cópia',exact:true}).click();
  await (await agendaChooser).setFiles(agendaBackupPath);
  await page.getByRole('button',{name:'Substituir e restaurar',exact:true}).click();
  await page.getByRole('group',{name:/Cópia restaurada. Saldos e histórico foram atualizados/}).waitFor();
  await navigate('/schedule','Sua agenda financeira');
  await page.getByText('Recorrências',{exact:true}).click();
  await page.getByText('Pausada',{exact:true}).waitFor();
  await page.getByRole('button',{name:'Retomar',exact:true}).click();
  await page.getByRole('alertdialog').getByRole('button',{name:'Retomar',exact:true}).click();
  await page.getByText('Ativa',{exact:true}).waitFor();
  await page.getByText('Pendentes',{exact:true}).click();
  await payments(2);
  await page.screenshot({path:resolve(output,'schedule-desktop.png')});
  await context.setOffline(true);
  await page.reload({waitUntil:'domcontentloaded'});
  await ready('Sua agenda financeira');
  await payments(2);
  passed.push('Backup v3 restaura agenda e lançamentos; reabertura offline não duplica previsões');
  stage = 'mobile'; console.log('Validando: mobile');
  await navigate('/cards','Seus cartões');
  await context.setOffline(false);
  await page.setViewportSize({width:390,height:844});
  await page.getByRole('tab',{name:'Visão geral',exact:true}).waitFor();
  await page.screenshot({path:resolve(output,'cards-mobile.png')});
  await page.getByRole('tab',{name:'Visão geral',exact:true}).click();
  await page.getByText('Seu dinheiro',{exact:true}).waitFor();
  await page.screenshot({path:resolve(output,'dashboard-mobile.png')});
  await page.getByRole('tab',{name:'Contas',exact:true}).click();
  await page.getByText('Suas contas',{exact:true}).waitFor();
  await page.screenshot({path:resolve(output,'accounts-mobile.png')});

  await page.getByRole('tab',{name:'Agenda',exact:true}).click();
  await page.getByText('Sua agenda financeira',{exact:true}).waitFor();
  await page.screenshot({path:resolve(output,'schedule-mobile.png')});
  await page.getByRole('button',{name:'Nova previsão',exact:true}).click();
  await enter(page.getByRole('textbox',{name:/Descrição da previsão/}), 'Previsão mobile de teste');
  await enter(page.getByRole('textbox',{name:'Valor previsto',exact:true}), '12,00');
  await page.getByRole('button',{name:/Categoria da previsão/}).click();
  await page.getByRole('menuitem',{name:'Alimentação',exact:true}).click();
  await page.getByRole('button',{name:'Salvar previsão',exact:true}).click();
  await page.getByRole('dialog').waitFor({state:'hidden'});
  await page.getByText('Previsão mobile de teste',{exact:true}).waitFor();
  passed.push('Navegação e cadastro de previsão mobile em 390 × 844');
  assert.deepEqual(issues,[]);
  assert.equal(externalRequests.size,0);
  passed.push('Nenhum erro JavaScript ou recurso externo requisitado');
  await writeFile(resolve(output,'browser-report.json'),JSON.stringify({passed,issues,externalRequests:[...externalRequests],profile,browser:process.env.CANGURUU_BROWSER || 'chrome',backupMode:captureBackups?'generated_blob_capture':'native_download'},null,2));
  console.log(JSON.stringify({passed,issues,externalRequests:[...externalRequests]},null,2));
} catch (error) {
  if (page && !page.isClosed()) {
    await page.screenshot({path:resolve(output,'failure.png')});
    await writeFile(resolve(output,'failure.html'),await page.content());
    console.error(JSON.stringify({stage,passed,issues,externalRequests:[...externalRequests],text:await page.locator('body').innerText()},null,2));
    console.error((await page.locator('body').ariaSnapshot()).slice(0,18000));
  }
  throw error;
} finally {
  await context?.close();
}


