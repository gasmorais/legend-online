import { createRequire } from 'node:module';
import { createHash } from 'node:crypto';
import { readdirSync, readFileSync, writeFileSync, mkdirSync, rmSync } from 'node:fs';

const require = createRequire(new URL('../../web/package.json', import.meta.url));
const { transformSync } = require('esbuild');

const src = new URL('../../web/src/gen-bundles/', import.meta.url).pathname;
const out = new URL('../../web/public/as3/bundles/', import.meta.url).pathname;
rmSync(out, { recursive: true, force: true });
mkdirSync(out, { recursive: true });

const manifest = {};
let total = 0;
for (const f of readdirSync(src).filter((n) => n.endsWith('.ts'))) {
  const mod = f.slice(0, -3);
  const { code } = transformSync(readFileSync(src + f, 'utf8'), {
    loader: 'ts',
    format: 'esm',
    target: 'es2022',
    minify: true,
    keepNames: true,
    legalComments: 'none',
  });
  const hash = createHash('md5').update(code).digest('hex').slice(0, 8);
  writeFileSync(`${out}${mod}.${hash}.js`, code);
  manifest[mod] = `${mod}.${hash}.js`;
  total += code.length;
}
writeFileSync(`${out}manifest.json`, JSON.stringify(manifest));
console.log(`bundles: ${Object.keys(manifest).length}, ${(total / 1048576).toFixed(1)} MB`);
