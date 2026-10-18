export type UnitKind = 'hero' | 'npcHero' | 'boss' | 'pawn' | 'pet' | 'child' | 'monster';

export interface FixtureUnit {
  livingId: number;
  kind: UnitKind;
  face: 1 | 2;
  pos: number;
  name: string;
  hp: number;
  maxHp: number;
  type?: number;
  owner?: number;
  flying?: boolean;
  self?: boolean;
  res?: string;
}

export interface Fixture {
  id: string;
  title: string;
  battleType: number;
  ground: number;
  units: FixtureUnit[];
}

let nextId = 1000;
const u = (p: Omit<FixtureUnit, 'livingId'>): FixtureUnit => ({ livingId: nextId++, ...p });

function lordPve(): FixtureUnit[] {
  const lord = u({ kind: 'hero', face: 1, pos: 4, name: 'Lorde', hp: 8200, maxHp: 10000, type: 1, self: true });
  return [
    lord,
    u({ kind: 'pet', face: 1, pos: 4, name: 'Pet', hp: 1, maxHp: 1, owner: lord.livingId, flying: true }),
    u({ kind: 'pawn', face: 1, pos: 3, name: 'Arqueiro Nv. 40', hp: 5200, maxHp: 6000, res: '002' }),
    u({ kind: 'pawn', face: 1, pos: 12, name: 'Lanceiro Nv. 40', hp: 6000, maxHp: 6000, res: '001' }),
    u({ kind: 'child', face: 1, pos: 6, name: 'Filho', hp: 3000, maxHp: 4000, type: 1 }),
  ];
}

export const FIXTURES: Fixture[] = [
  {
    id: 'pve', title: 'Campanha (PvE): lorde contra herói NPC com tropas 1,2,7,8', battleType: 6, ground: 1,
    units: [
      ...lordPve(),
      u({ kind: 'npcHero', face: 2, pos: 5, name: 'Capitão Bandido', hp: 9000, maxHp: 9000, type: 1 }),
      u({ kind: 'pawn', face: 2, pos: 1, name: 'Lobo da Floresta Nv. 22', hp: 4000, maxHp: 4000, res: 'monster002b' }),
      u({ kind: 'pawn', face: 2, pos: 2, name: 'Lobo da Floresta Nv. 22', hp: 2600, maxHp: 4000, res: 'monster002b' }),
      u({ kind: 'pawn', face: 2, pos: 7, name: 'Arqueiro Demônio Nv. 20', hp: 4000, maxHp: 4000, res: 'monster012a' }),
      u({ kind: 'pawn', face: 2, pos: 8, name: 'Arqueiro Demônio Nv. 20', hp: 900, maxHp: 4000, res: 'monster012a' }),
    ],
  },
  {
    id: 'boss', title: 'Chefe (HeroMsg.type 3): BossBottomStrip sobre a unidade', battleType: 12, ground: 5,
    units: [
      ...lordPve(),
      u({ kind: 'boss', face: 2, pos: 5, name: 'Elfo Peyton', hp: 640000, maxHp: 1000000, type: 3, res: 'boss101' }),
    ],
  },
  {
    id: 'grid', title: 'Grade completa: 12 posições por lado', battleType: 6, ground: 9,
    units: [1, 2].flatMap((face) => Array.from({ length: 12 }, (_, i) => u({
      kind: i % 3 === 0 ? 'hero' : 'pawn', face: face as 1 | 2, pos: i + 1, name: `pos ${i + 1}`,
      res: i % 3 === 0 ? undefined : ['001', '002', '003', '005', '006', '007', '008', '009', '010', '011'][(i + face) % 10],
      hp: 1000 - i * 60, maxHp: 1000, type: 1, self: face === 1 && i === 3,
    }))),
  },
];

export function fixtureById(id: string): Fixture {
  return FIXTURES.find((f) => f.id === id) ?? FIXTURES[0];
}
