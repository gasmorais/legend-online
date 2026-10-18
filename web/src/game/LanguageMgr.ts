class LanguageMgrClass {
  private dict = new Map<string, string>();

  async load(url = '/ui/language.txt'): Promise<void> {
    const text = (await (await fetch(url)).text()).replace(/^﻿/, '');
    for (const line of text.split(/\r?\n/)) {
      const i = line.indexOf(':');
      if (i <= 0 || line.startsWith('#')) continue;
      const key = line.slice(0, i).trim();
      if (!this.dict.has(key)) this.dict.set(key, line.slice(i + 1).trim());
    }
  }

  has(key: string): boolean { return this.dict.has(key); }

  GetTranslation(key: string, ...args: unknown[]): string {
    const s = this.dict.get(key);
    if (s === undefined) return key;
    return s.replace(/\{(\d+)\}/g, (m, i: string) => (args[Number(i)] !== undefined ? String(args[Number(i)]) : m))
      .replace(/\\n/g, '\n');
  }

  get size(): number { return this.dict.size; }
}

export const LanguageMgr = new LanguageMgrClass();
