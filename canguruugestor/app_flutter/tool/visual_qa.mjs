import assert from 'node:assert/strict';
import {mkdir,mkdtemp,readFile,writeFile} from 'node:fs/promises';
import {resolve} from 'node:path';
const {chromium}=await import(process.env.CANGURUU_PLAYWRIGHT || 'playwright');
const base=process.env.CANGURUU_BASE_URL || 'http://127.0.0.1:5187';
const output=resolve('build/visual-qa');
await mkdir(output,{recursive:true});
const profile=await mkdtemp(resolve(output,'profile-'));
const context=await chromium.launchPersistentContext(profile,{
 channel:'chrome',headless:true,viewport:{width:1440,height:1000},locale:'pt-BR'});
const page=context.pages()[0];
const errors=[], external=new Set(), checked=[];
page.on('pageerror',e=>errors.push(e.message));
context.on('request',r=>{if(/^https?:/.test(r.url())&&!r.url().startsWith(base)) external.add(r.url());});
async function ready(heading){
 await page.locator('flutter-view').waitFor({state:'attached'});
 const placeholder=page.locator('flt-semantics-placeholder');
 if(await placeholder.count())await placeholder.evaluate(el=>el.click());
 await page.getByText(heading,{exact:true}).first().waitFor();
 await page.mouse.move(0,0);
 await page.waitForTimeout(300);
}
async function visit(route,heading){
 await page.goto(base+'/#'+route,{waitUntil:'domcontentloaded'});
 await ready(heading);
}
try{
 await visit('/','Seu dinheiro');
 await page.screenshot({path:resolve(output,'desktop-empty.png')});
 await visit('/settings','Seu espaço, suas escolhas');
 const chooser=page.waitForEvent('filechooser');
 await page.getByRole('button',{name:'Restaurar cópia',exact:true}).click();
 await (await chooser).setFiles(process.env.CANGURUU_VISUAL_FIXTURE || resolve('build/qa/schedule-backup.json'));
 await page.getByRole('button',{name:'Substituir e restaurar',exact:true}).click();
 await page.getByRole('group',{name:/Cópia restaurada. Saldos e histórico foram atualizados/}).waitFor();
 // A pending amount exercises the forecast typography beyond an empty agenda.
 await visit('/schedule','Sua agenda financeira');
 await page.getByRole('button',{name:'Nova previsão',exact:true}).click();
 for(const [field,value] of [
   [page.getByRole('textbox',{name:/Descrição da previsão/}),'Previsão de teste visual'],
   [page.getByRole('textbox',{name:'Valor previsto',exact:true}),'12.450,75'],
 ]) {
   await field.click(); await page.waitForTimeout(120);
   await field.press('Control+A'); await field.press('Backspace');
   await page.waitForTimeout(120); await field.pressSequentially(value,{delay:40});
   await page.waitForTimeout(120);
   assert.equal(await field.inputValue(),value);
   await field.press('Tab');
 }
 await page.getByRole('button',{name:/Categoria da previsão/}).click();
 await page.getByRole('menuitem',{name:'Alimentação',exact:true}).click();
 await page.getByRole('button',{name:'Salvar previsão',exact:true}).click();
 await page.getByRole('dialog').waitFor({state:'hidden'});
 await page.getByRole('button',{name:'Confirmar pagamento',exact:true}).first().waitFor();
 checked.push('agenda com previsão fictícia de R$ 12.450,75');
 const routes=[
 ['dashboard','/','Seu dinheiro'],['accounts','/accounts','Suas contas'],
 ['cards','/cards','Seus cartões'],['schedule','/schedule','Sua agenda financeira'],
 ['movements','/movements','Seu histórico'],['categories','/categories','Categorias'],
 ['settings','/settings','Seu espaço, suas escolhas']];
 for(const width of [1440,390]){
  await page.setViewportSize({width,height:width===390?844:1000});
  for(const [name,route,heading] of routes){
   await visit(route,heading);
   await page.screenshot({path:resolve(output,name+'-'+width+'.png')});
   checked.push(name+' '+width);
  }
  await visit('/','Seu dinheiro');
  await page.getByRole('button',{name:'Ocultar valores',exact:true}).click();
  await page.getByRole('button',{name:'Mostrar valores',exact:true}).waitFor();
  await page.screenshot({path:resolve(output,'hidden-'+width+'.png')});
  for (const [name,route,heading] of routes.filter(([name])=>['cards','schedule'].includes(name))) {
    await visit(route,heading);
    assert.doesNotMatch(await page.locator('body').ariaSnapshot(), /R\$\s*[−\d]/);
    await page.screenshot({path:resolve(output,name+'-hidden-'+width+'.png')});
  }
  checked.push('valores ocultos em cartões e agenda '+width);
  await visit('/','Seu dinheiro');
  await page.getByRole('button',{name:'Mostrar valores',exact:true}).click();
  await page.getByText('Sobre os valores',{exact:true}).click();
  await page.getByText(/^Os totais consideram os dados cadastrados/).waitFor();
  await page.mouse.move(width/2,400);
  await page.mouse.wheel(0,6000);
  await page.waitForTimeout(500);
  await page.mouse.move(0,0);
  await page.screenshot({path:resolve(output,'help-'+width+'.png')});
  checked.push('ajuda e valores ocultos '+width);
  await visit('/movements','Seu histórico');
  await page.getByRole('button',{name:'Nova movimentação',exact:true}).click();
  await page.getByRole('textbox',{name:/^Descrição/}).waitFor();
  await page.waitForTimeout(300);
  await page.screenshot({path:resolve(output,'form-'+width+'.png')});
  await page.getByRole('button',{name:'Fechar',exact:true}).click();
 }
 await page.waitForFunction(()=>navigator.serviceWorker.controller!==null);
 await context.setOffline(true);
 await visit('/','Seu dinheiro');
 checked.push('tipografia e ícones disponíveis offline');
 assert.deepEqual(errors,[]);assert.equal(external.size,0);
 const report={checked,errors,externalRequests:[...external],profile,version:'0.3.3',fixture:'dados fictícios da etapa 5 e previsão criada pela interface em perfil isolado'};
 await writeFile(resolve(output,'report.json'),JSON.stringify(report,null,2));
 console.log(JSON.stringify(report,null,2));
} catch(e){
 await page.screenshot({path:resolve(output,'failure.png')});
 console.error(await page.locator('body').ariaSnapshot());throw e;
} finally{await context.close();}
