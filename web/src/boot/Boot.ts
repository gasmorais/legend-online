import type { Application } from 'pixi.js';
import { $ } from '@/as3/runtime';
import { Domain } from '@/flash/library';
import { FlashMode } from '@/flash/mode';
import { getStage } from '@/as3/flash';
import '@/as3/xml';
import '@/as3/builtins';
import { Loader } from '@/as3/flash/display';
import { Socket, URLLoader } from '@/as3/flash/net';

export const SERVER = location.origin;

export const FLASHVARS: Record<string, string> = {
  user: 'player',
  key: 'local',
  site: 'broas_1264',
  config: `${SERVER}/config.xml`,
  logintype: '1',
};

const CODE_MODULES: Record<string, string> = { '2': 'core_module' };
for (let i = 3; i <= 18; i++) CODE_MODULES[String(i)] = `m${i}`;

export async function resolveSwf(url: string): Promise<{ kind: 'code' | 'library' | 'none'; name?: string }> {
  const clean = url.split('?')[0];
  const file = clean.split('/').pop() ?? '';
  const base = file.replace(/_[0-9a-f]{8}(?=\.)/, '').replace(/\.(png|swf|bswf)$/, '');
  if (/^\d+$/.test(base) && CODE_MODULES[base]) {
    await $.loadBundle(CODE_MODULES[base]);
    return { kind: 'code', name: CODE_MODULES[base] };
  }
  if (/\.swf$/i.test(clean) || /mainloading/.test(clean)) {
    const name = base;
    if (Domain.libraryOf(name) !== undefined || (await libraryExists(name))) {
      await Domain.loadLibrary(name);
      return { kind: 'library', name };
    }
  }
  return { kind: 'none' };
}

export function cdnUrl(url: string): string | null {
  const m = /^https?:\/\/res\d*oas\.creaction-network\.com(?::\d+)?\/(.*)$/i.exec(url);
  return m ? `/cdn/${m[1]}` : null;
}

function installTrace(): void {
  const spec = new URLSearchParams(location.search).get('trace');
  if (!spec) return;
  const log: string[] = ((window as any).__trace = []);
  for (const item of spec.split(',')) {
    const i = item.lastIndexOf('.');
    const fqn = item.slice(0, i), method = item.slice(i + 1);
    void $.load(fqn).then(() => {
      const proto = $.C(fqn).prototype;
      const orig = proto[method];
      if (typeof orig !== 'function') return;
      proto[method] = function (this: unknown, ...args: unknown[]) {
        const where = (new Error().stack ?? '').split('\n').slice(2, 6).map((l) => l.trim().replace(/\(?https?:\/\/[^)]*\/([^/)]+)\)?/, '$1')).join(' < ');
        log.push(`${fqn.split('.').pop()}.${method} @ ${where}`);
        return orig.apply(this, args);
      };
    });
  }
}

const SWF_MARK = 'CWS-LGH5:';
const swfLog: string[] = [];
(window as any).__swfLog = swfLog;

function isSwfUrl(url: string): boolean {
  const clean = url.split('?')[0].toLowerCase();
  return /\.swf$/.test(clean) || /^https?:\/\/[^/]+\/\d{1,2}(_[0-9a-f]{8})?\.png$/.test(clean);
}

async function loadImageResult(url: string): Promise<{ content: any; width: number; height: number } | null> {
  const img = new Image();
  img.crossOrigin = 'anonymous';
  try {
    await new Promise<void>((res, rej) => { img.onload = () => res(); img.onerror = () => rej(new Error(url)); img.src = url; });
  } catch {
    throw new Error(`imagem ausente: ${url}`);
  }
  const BD = $.C('flash.display.BitmapData');
  const B = $.C('flash.display.Bitmap');
  const bd = new BD(img.naturalWidth || 1, img.naturalHeight || 1, true, 0);
  bd.canvas().getContext('2d').drawImage(img, 0, 0);
  bd.changed();
  return { content: new B(bd), width: img.naturalWidth, height: img.naturalHeight };
}

const known = new Map<string, boolean>();
async function libraryExists(name: string): Promise<boolean> {
  if (!known.has(name)) {
    const r = await fetch(`/lib/${name}/library.json`, { method: 'HEAD' });
    known.set(name, r.ok);
  }
  return known.get(name)!;
}

export async function bootGame(app: Application): Promise<void> {
  const errors: string[] = ((window as any).__errors = []);
  const origError = console.error.bind(console);
  console.error = (...a: unknown[]) => {
    errors.push(a.map((x) => (x instanceof Error ? `${x.message}\n${x.stack?.split('\n').slice(1, 4).join('\n')}` : String(x))).join(' '));
    origError(...a);
  };
  URLLoader.interceptor = (req) => {
    if (!isSwfUrl(req.url)) {
      const local = cdnUrl(req.url);
      return local ? fetch(local, { method: req.method === 'POST' ? 'POST' : 'GET' }) : null;
    }
    swfLog.push(req.url);
    const mark = new TextEncoder().encode(SWF_MARK + req.url + '\0');
    let size = 0;
    try {
      const CS = $.C('com.pickgliss.ui.ComponentSetting');
      const plain = req.url.split('?')[0].replace(/_[0-9a-f]{8}(?=\.\w+$)/, '');
      size = Number((CS.getFileVo(plain) ?? CS.getFileVo(req.url))?.size) || 0;
    } catch { }
    if (size <= mark.length) return mark;
    const out = new Uint8Array(size);
    out.set(mark);
    return out;
  };
  Loader.resolver = async ({ url, bytes }) => {
    let target = url;
    if (!target && bytes && bytes.length > SWF_MARK.length) {
      const n = Math.min(bytes.length, 2048);
      const head = new TextDecoder().decode(Uint8Array.from({ length: n }, (_, i) => (bytes as any)[i]));
      if (head.startsWith(SWF_MARK)) target = head.slice(SWF_MARK.length).split('\0')[0];
    }
    if (!target) return null;
    if (!isSwfUrl(target)) {
      const local = cdnUrl(target);
      if (local && /\.(png|jpe?g|gif)(\?|$)/i.test(target)) return loadImageResult(local);
      return null;
    }
    const r = await resolveSwf(target);
    if (r.kind === 'none') {
      if (isSwfUrl(target)) console.info('[boot] SWF sem conversão:', target);
      return null;
    }
    return {};
  };
  Socket.wsUrl = () => `${location.protocol === 'https:' ? 'wss' : 'ws'}://${location.host}/socket`;
  await Domain.ensure(['Loading']);
  await $.load('Loading');
  await $.load('com.pickgliss.loader.ModuleLoader');
  const ML = $.C('com.pickgliss.loader.ModuleLoader');
  const analyMd5 = ML.prototype.analyMd5;
  ML.prototype.analyMd5 = function (this: any, bytes: any) {
    if (bytes && bytes.length > SWF_MARK.length && bytes[0] === 67 && bytes[3] === 45) return this.handleModule(bytes);
    return analyMd5.call(this, bytes);
  };
  Domain.codeResolver = (name) => (name.includes('.') && $.hasCode(name) ? $.C(name) : undefined);
  Domain.missingPlaceholder = () => new ($.C('flash.display.MovieClip'))();
  FlashMode.interactive = true;
  installTrace();
  const flashStage = getStage(app, FLASHVARS);
  const Loading = $.C('Loading');
  const doc = new Loading();
  flashStage.addChild(doc);
  Object.assign(window as any, { __doc: doc, __$: $ });
}
