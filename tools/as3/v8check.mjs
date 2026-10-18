import { createRequire } from 'node:module';
import { readdirSync, readFileSync, writeFileSync, mkdirSync } from 'node:fs';
import { execFileSync } from 'node:child_process';
const require = createRequire(new URL('../../web/package.json', import.meta.url));
const { transformSync } = require('esbuild');
const dir = new URL('../../web/src/gen-bundles/', import.meta.url).pathname, tmp = process.argv[2] ?? '/tmp/lg-v8check';
mkdirSync(tmp, { recursive: true });
for (const f of readdirSync(dir).filter((f) => f.endsWith('.ts'))) {
  let js; try { js = transformSync(readFileSync(`${dir}/${f}`, 'utf8'), { loader: 'ts', format: 'esm' }).code; } catch (e) { console.log('ERRO', f, e.errors?.[0]?.text, e.errors?.[0]?.location?.lineText?.trim()); continue; }
  const out = `${tmp}/${f.replace('.ts', '.mjs')}`;
  writeFileSync(out, js);
  try { execFileSync(process.execPath, ['--check', out], { stdio: 'pipe' }); console.log('ok  ', f); }
  catch (e) { console.log('ERRO', f, String(e.stderr).split('\n').slice(0, 5).join(' | ')); }
}
