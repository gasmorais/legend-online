# Guardians and Espírito de Proteção ("Guardiões e Espírito de Proteção")

Feature slug `guardians`, domain companions. Client code name "child". The player owns guardians ("Guardião", jobs 1..10) that inherit a percentage of the hero's stats, have equipment, skills and a war emblem, and fight beside the hero as main or assist guardian. Two guardians can be composed into an "Espírito de Proteção" (jobs 101..105) with deeper progression (emblem/resistance tracks, talent, awakening, life wheel, artifact, second advancement). Guardians also play their own modes: patrol, wanted PvE, guardian arena, the Espírito de Proteção arena, the seal mini game, and two expedition modes.

## Entry points

| Entry | Condition | Source |
|---|---|---|
| Army toolbar button (hotkey A) -> guardian frame | hero level >= 70 and at least one guardian ("Você ainda não contém nenhum guardião") | `decompiled/core_module/scripts/ui/maintoolbar/MainToolBar.as:2193-2209`, `decompiled/core_module/scripts/managers/ChildManager.as:725-739`, `decompiled/core_module/scripts/yishi/keyboard/KeyBoardRegister.as:370-381` |
| Army toolbar child button `nursingSpiritBtn` (hotkey U) -> Espírito de Proteção frame | `isChangeJob` ("Ativado ao obter Profissão de Cavaleiro") | `decompiled/core_module/scripts/ui/maintoolbar/constant/MainToolCheckBtnOpen.as:48-49`, `ChildManager.as:840-855` |
| Bag items: 2131140 (summon, SonType 277), SonType 226 (skill books), SonType 624 (spirit books), 208044 (legacy) | | `decompiled/core_module/scripts/cell/view/GoodsItemMenu.as:536-564` |
| Space NPC options 27 (summon), 29 (abandon), 118 is the Titan temple (dragon feature) | | `decompiled/m3/scripts/map/space/view/frame/DialogOptionItem.as:620-633` |
| Patrol: queue bar item, NPC, day guide, task tip | | `patrol.md` |
| Guardian arena: `SwitchPageHelp`, top bar time box | level 70 | `arena.md` |
| Seal: top bar button | `isChangeJob` | `seal.md` |
| Espírito de Proteção arena: `SwitchPageHelp.openChildNsWar` | `isChangeJob` | `nswar.md` |
| Expeditions | version switches off; `isAvenger` | `spirit-expedition.md`, `ylex-expedition.md` |

## Modules

| Module | Scope | Main opcodes |
|---|---|---|
| [roster](roster.md) | guardian entity, summon, list, rest, sell, abandon, divorce split, look up; owns 4746, 4747, 4749, 4758 | 8868 ops 1, 2, 5, 7, 12, 13, 24; 8875 |
| [attributes](attributes.md) | growth leveling, legacy fostering, "Conversão de Guardiões" (attribute conversion) | 8868 ops 3, 4, 10, 11, 14, 15, 27 |
| [skills](skills.md) | learn, upgrade, battle bar | 8868 ops 8, 9, 16 |
| [equipment](equipment.md) | equipment bags 28/29/30, strengthen, upgrade, sockets, refresh, sell | 8869 ops 1..8 |
| [emblem](emblem.md) | war emblem and resistances | 8868 ops 17..21, 23 |
| [handbook](handbook.md) | collection, summon by job, soul awakening, spirit compose, assist awakening | 8868 ops 25, 26, 28, 50 |
| [formation](formation.md) | main/assist fielding, grid formations, battle commands | 8868 op 6; 10516 |
| [nursing-spirit](nursing-spirit.md) | Espírito de Proteção core progression; owns 424 | 8868 ops 29..34, 36..39, 44..49 |
| [nursing-spirit-artifact](nursing-spirit-artifact.md) | life wheel and artifact | 8868 ops 35, 40..43 |
| [patrol](patrol.md) | "Patrulha do Guardião" | 9578, 9579; 302, 303, 304 |
| [pve](pve.md) | "Guardiões Procurados" (battle 3845) | 9548; 4979 |
| [arena](arena.md) | "Guardião Leida" bracket arena (battle 3847) | 9657; 453 |
| [nswar](nswar.md) | "Arena do Espírito de Proteção" (battle 3911) | 9732, 25240; 568..574 |
| [seal](seal.md) | "Selo do Guardião" | 9641; 420 |
| [spirit-expedition](spirit-expedition.md) | spirit expedition (battle 3895, disabled) | 8661; 4274, 4275 |
| [ylex-expedition](ylex-expedition.md) | spirit camps (disabled) | 9018; 4215 |

Proto ownership notes: packages `children`, `childpatrol`, `childseal`, `expedition` are registered to this feature. Packages `guardpve` (registered to final-defense), `guardpvp` and `pvp` (registered to arena) are used by `pve.md`, `arena.md` and `nswar.md`; `guardendless` (abyss guardian formation) belongs to [abyss](../abyss/README.md). Opcode 4979 `U_C_GUARDPVE_OPRSP` is missing from `protocol/opcodes.csv`.

## Dependencies

- [hero](../hero/README.md): guardian stats are percentages of hero totals; fielded guardian shown on the hero; look up (4125/8875).
- [inventory](../inventory/README.md): items, bag types 28/29/30, bag pushes 115.
- [marriage](../marriage/README.md): couple sharing, abandon confirmation, divorce split.
- [army](../army/README.md): barracks soldier requirements for soul awakening.
- [battle](../battle/README.md): guardian units, battle types 3845, 3847, 3867, 3868, 3889, 3895, 3898, 3911; 4752 awaken updates; 10516 and 25240 commands.
- [friends](../friends/README.md): patrol visits and riot help.
- [currency](../currency/README.md), [vip](../vip/README.md) (arena auto sign up), [shops](../shops/README.md) (quick buy, arena shop), [mail](../mail/README.md) (sell refunds).
- [avenger](../avenger/README.md): expeditions require `isAvenger`.
- [abyss](../abyss/README.md), [mazes](../mazes/README.md): guardian formations used by those modes.
- [einherjar](../einherjar/README.md): fielded pet stats inherited by guardians (`fight_pet`).

## Suggested implementation order

1. `roster` (entity, 4747 serialization, 8868 dispatcher) and the shared stat service from `attributes`.
2. `formation` (op 6 and battle units) so guardians appear in normal battles.
3. `attributes`, `skills`, `equipment`, `emblem`.
4. `handbook` (collection, call, soul awakening, compose) then `nursing-spirit` and `nursing-spirit-artifact`.
5. Modes: `patrol` and `pve` (shared towers), `seal`, `arena`, `nswar`.
6. `spirit-expedition` and `ylex-expedition` only if their version switches are enabled.
