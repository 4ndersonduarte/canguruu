import http from 'node:http';
import { createReadStream } from 'node:fs';
import { stat } from 'node:fs/promises';
import { resolve, sep, extname } from 'node:path';
import { fileURLToPath } from 'node:url';

const root = resolve(fileURLToPath(new URL('../build/web', import.meta.url)));
const port = Number(process.argv[2] || 5187);
const types = { '.html':'text/html; charset=utf-8', '.js':'application/javascript',
  '.wasm':'application/wasm', '.json':'application/json', '.svg':'image/svg+xml',
  '.png':'image/png', '.ttf':'font/ttf', '.woff2':'font/woff2', '.css':'text/css' };
const server = http.createServer(async (request, response) => {
  try {
    const pathname = decodeURIComponent(new URL(request.url, 'http://localhost').pathname);
    const candidate = resolve(root, '.' + (pathname === '/' ? '/index.html' : pathname));
    if (candidate !== root && !candidate.startsWith(root + sep)) {
      response.writeHead(403).end(); return;
    }
    if (!(await stat(candidate)).isFile()) { response.writeHead(404).end(); return; }
    response.writeHead(200, {
      'Content-Type': types[extname(candidate)] || 'application/octet-stream',
      'Cross-Origin-Opener-Policy': 'same-origin',
      'Cross-Origin-Embedder-Policy': 'require-corp',
      'Cache-Control': 'no-cache'
    });
    createReadStream(candidate).pipe(response);
  } catch { response.writeHead(404).end(); }
});
server.listen(port, '127.0.0.1', () => process.stdout.write('Canguruu local: http://127.0.0.1:' + port + '\n'));
