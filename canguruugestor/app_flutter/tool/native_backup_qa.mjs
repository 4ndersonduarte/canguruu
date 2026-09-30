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
  assert.equal(captureBackups,false);
  await launch();
  await navigate('/settings','Seu espaço, suas escolhas');
  const fixture=resolve(output,'schedule-backup.json');
  const chooser=page.waitForEvent('filechooser');
  await page.getByRole('button',{name:'Restaurar cópia',exact:true}).click();
  await (await chooser).setFiles(fixture);
  await page.getByRole('button',{name:'Substituir e restaurar',exact:true}).click();
  await page.getByRole('group',{name:/Cópia restaurada. Saldos e histórico foram atualizados/}).waitFor();
  const saved=resolve(output,'schedule-native-download.json');
  await exportBackup(saved);
  const original=JSON.parse(await readFile(fixture,'utf8'));
  const actual=JSON.parse(await readFile(saved,'utf8'));
  assert.equal(actual.schema_version,3);
  assert.deepEqual(actual.tables,original.tables);
  const result={nativeDownload:'passed',tablesPreserved:true,profile,issues,externalRequests:[...externalRequests]};
  await writeFile(resolve(output,'native-backup-report.json'),JSON.stringify(result,null,2));
  console.log(JSON.stringify(result,null,2));
} finally { await context?.close(); }
