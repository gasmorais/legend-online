const def = (proto: object, name: string, desc: PropertyDescriptor, force = false): void => {
  if (force || !Object.prototype.hasOwnProperty.call(proto, name)) Object.defineProperty(proto, name, { configurable: true, enumerable: false, ...desc });
};

const D = Date.prototype as any;
def(D, 'time', { get(this: any) { return this.getTime(); }, set(this: any, v: number) { this.setTime(v); } });
for (const [prop, getter, setter] of [
  ['fullYear', 'getFullYear', 'setFullYear'], ['month', 'getMonth', 'setMonth'], ['date', 'getDate', 'setDate'],
  ['hours', 'getHours', 'setHours'], ['minutes', 'getMinutes', 'setMinutes'], ['seconds', 'getSeconds', 'setSeconds'],
  ['milliseconds', 'getMilliseconds', 'setMilliseconds'],
  ['fullYearUTC', 'getUTCFullYear', 'setUTCFullYear'], ['monthUTC', 'getUTCMonth', 'setUTCMonth'], ['dateUTC', 'getUTCDate', 'setUTCDate'],
  ['hoursUTC', 'getUTCHours', 'setUTCHours'], ['minutesUTC', 'getUTCMinutes', 'setUTCMinutes'],
  ['secondsUTC', 'getUTCSeconds', 'setUTCSeconds'], ['millisecondsUTC', 'getUTCMilliseconds', 'setUTCMilliseconds'],
] as const) {
  def(D, prop, { get(this: any) { return this[getter](); }, set(this: any, v: number) { this[setter](v); } });
}
def(D, 'day', { get(this: any) { return this.getDay(); } });
def(D, 'dayUTC', { get(this: any) { return this.getUTCDay(); } });
def(D, 'timezoneOffset', { get(this: any) { return this.getTimezoneOffset(); } });

const A = Array as any;
Object.assign(A, { CASEINSENSITIVE: 1, DESCENDING: 2, UNIQUESORT: 4, RETURNINDEXEDARRAY: 8, NUMERIC: 16 });

function cmpBy(opts: number): (a: any, b: any) => number {
  const numeric = (opts & 16) !== 0, ci = (opts & 1) !== 0, desc = (opts & 2) !== 0;
  return (a, b) => {
    let r: number;
    if (numeric) r = Number(a) - Number(b);
    else {
      let x = a === undefined ? '' : String(a), y = b === undefined ? '' : String(b);
      if (ci) { x = x.toLowerCase(); y = y.toLowerCase(); }
      r = x < y ? -1 : x > y ? 1 : 0;
    }
    return desc ? -r : r;
  };
}

function finishSort(arr: any[], cmp: (a: any, b: any) => number, opts: number): any {
  const idx = arr.map((_, i) => i).sort((i, j) => cmp(arr[i], arr[j]) || i - j);
  if (opts & 4) for (let k = 1; k < idx.length; k++) if (cmp(arr[idx[k - 1]], arr[idx[k]]) === 0) return 0;
  if (opts & 8) return idx;
  const sorted = idx.map((i) => arr[i]);
  for (let k = 0; k < sorted.length; k++) arr[k] = sorted[k];
  return arr;
}

const nativeSort = Array.prototype.sort;
def(Array.prototype, 'sort', {
  writable: true,
  value: function (this: any[], ...args: any[]) {
    if (!args.length || args[0] === undefined) return nativeSort.call(this);
    const [a0, a1] = args;
    if (typeof a0 === 'function') {
      const opts = typeof a1 === 'number' ? a1 : 0;
      const cmp = opts & 2 ? (x: any, y: any) => -a0(x, y) : a0;
      return opts & 12 ? finishSort(this, cmp, opts) : nativeSort.call(this, cmp);
    }
    const opts = Number(a0) || 0;
    return opts & 12 ? finishSort(this, cmpBy(opts), opts) : nativeSort.call(this, cmpBy(opts));
  },
}, true);

def(Array.prototype, 'sortOn', {
  writable: true,
  value: function (this: any[], names: string | string[], options: number | number[] = 0) {
    const fields = Array.isArray(names) ? names : [names];
    const opts = fields.map((_, i) => (Array.isArray(options) ? options[i] ?? 0 : options) as number);
    const cmp = (a: any, b: any): number => {
      for (let i = 0; i < fields.length; i++) {
        const r = cmpBy(opts[i])(a?.[fields[i]], b?.[fields[i]]);
        if (r) return r;
      }
      return 0;
    };
    const first = opts[0] ?? 0;
    return finishSort(this, cmp, first);
  },
});
def(Array.prototype, 'insertAt', { writable: true, value: function (this: any[], i: number, v: any) { this.splice(i, 0, v); } });
def(Array.prototype, 'removeAt', { writable: true, value: function (this: any[], i: number) { return this.splice(i, 1)[0]; } });

def(Object.prototype, 'setPropertyIsEnumerable', {
  writable: true,
  value: function (this: any, name: string, enumerable = true) {
    const d = Object.getOwnPropertyDescriptor(this, name);
    if (d) Object.defineProperty(this, name, { ...d, enumerable });
  },
});

export {};
