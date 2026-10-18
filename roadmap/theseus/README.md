# Theseus ("Alma de Teseu")

Late game progression unlocked after deification (`vocationIndex > 0`) and gated by royalty level (see [../royalty-boss/README.md](../royalty-boss/README.md)). The player equips Theseus armor suits and levels war intent, treasure slots and war souls. The player also places god plates and runs three Theseus PvE modes: the tower, the dungeon and the challenge. Controller key `theseussoul`.

PostgreSQL schema: `theseus`. Rust handlers: `theseus::<module>::handle_<action>`.

## Entry points

| Entry | Condition | Opens |
|---|---|---|
| Main toolbar, child button of the archaeology button (`MainToolBar.as:2336-2357`) | `royaltyLevel > 0`, `VersionSwitch.THESESOUL`, `vocationIndex > 0`; parent button needs hero level 15. Locked tip: "Liberado após a deificação" | Main frame "Alma de Teseu" ([soul.md](soul.md)) |
| Hotkey E (`KeyBoardRegister.as:1154-1191`) | same as the toolbar | Main frame |
| Player info "Ver Teseu" (openType 3) | viewed player has `vocationIndex > 0` | Read-only inspection ([soul.md](soul.md)) |
| "Divino" button on the main frame (openType 10; "Bônus total" openType 11) | `RoyaltyTemplates.OpenSlate == 1` (royalty level 30 or more) | [godhead.md](godhead.md) |
| "Coleção" button on the main frame (openType 9) | `VersionSwitch.TREASURECANGPING` (false in this build) | [collection.md](collection.md) |
| Reino do Céu map 10000, NPC 49 "Eliza, chefe da Zona Proibida", option 165 | Knight job change, royalty level 6 or more | [tower.md](tower.md) |
| Same NPC, option 167 | royalty level 30 or more | [dungeon.md](dungeon.md) |
| Dialog option 166 | Knight job change; no NPC in `MapNodeInfos.xml` carries option 166, so it is unreachable as shipped | [box.md](box.md) |
| Smith resolve tab "Teseu" | royalty level > 0 | Decompose ([war-frame.md](war-frame.md)) |
| Quest 1389 "Abertura do Espírito da Guerra" (level 80) | `VersionSwitch.WARSOUL` | War soul tab ([war-soul.md](war-soul.md)) |

### Controller `theseussoul` openTypes

| openType | Frame |
|---|---|
| none | Main frame |
| 1 | Suit attributes |
| 2 | Bônus total (war intent) |
| 3 | Inspection |
| 4 | Hatch |
| 5 | War soul upgrade |
| 6 | Reform stones |
| 7 | Star choose (dead code) |
| 8 | Armor upgrade |
| 9 | Coleção |
| 10, 11 | God plates, plate bonus |

### Royalty unlocks (`RoyaltyTemplates`)

| Unlock | Royalty level |
|---|---|
| Suits (`OpenTheseus`, suit `n` usable when `OpenTheseus >= n`) | suit 1 at royalty 1, 2 at 4, 3 at 9, 4 at 14, 5 at 19, 6 at 24, 7 at 28, 8 at 32, 9 at 37 |
| Outer treasure slots | 3 at 6, 5 at 8, 7 at 11, 9 at 15 |
| Inner treasure slots | 1 at 6, 2 at 9, 3 at 13 |
| Core level cap | 20 at 6, up to 150 at 20 |
| War soul slots | 3 at 10, 6 at 15, 9 at 20 |
| Tower / god plates and dungeon | 6 / 30 |

## Modules

### Armor and souls (shared opcodes 8680 and 8684)

| Module | Content |
|---|---|
| [soul.md](soul.md) | Main frame, full op tables of 8680 and 8684, snapshot 4298, stat totals 4300, vice password locks 8809, inspection via 4125 |
| [equipment-suits.md](equipment-suits.md) | 9 suits x 12 positions, 336 slot Theseus bag, tidy, move, equip, unequip, suit bonuses (4323) |
| [war-frame.md](war-frame.md) | Armor strengthen, quality up, decompose |
| [war-intent.md](war-intent.md) | 12 war intent positions, levels 0 to 100, total level bonus (4299) |
| [treasure.md](treasure.md) | "Selo Regenerador": outer, inner and core slots (bags 38, 39), core strengthen (4302) |
| [war-soul.md](war-soul.md) | War souls: 54 templates, 9 elements, equip, primary group, split, hatching (4306 to 4309) |
| [war-soul-training.md](war-soul-training.md) | War soul strengthen, star, reform, decompose, hidden refine and skill tabs (4310) |

### Theseus PvE and extras

| Module | Content |
|---|---|
| [godhead.md](godhead.md) | "Placa divina": 5 x 5 board, plate placement, level, star, decompose, 16 tasks (9762, 1024) |
| [dungeon.md](dungeon.md) | "Masmorra de Teseus": 28 floors, pickaxes, events, battleType 3915 (9763, 779, 780) |
| [tower.md](tower.md) | "Torre de Teseus": stages, sweep, weekly attempts, battleType 3913 (9760, 768) |
| [box.md](box.md) | "Desafio de Teseus": 20 chapters, skill picks, battleType 3914 (9761, 769 to 771) |
| [collection.md](collection.md) | "Coleção": album, suits, chips, chests, shop 1035 (9740, 584, 585, 594); hidden in this build |

## Cross-cutting rules

- No Theseus message carries a result or error code. Rejected requests get no state push; the error channel is an open question in every module.
- The server must push currency type 70 (4725) at login even with the collection switch off, or the client crashes.
- Opcodes 9762 and 4725 are missing from `protocol/opcodes.csv`; they are defined in `ProtocolType.as` and `AcceptProtocolType.as`.

## Dependencies

- [../royalty-boss/README.md](../royalty-boss/README.md): royalty level gates every unlock.
- [../hero/README.md](../hero/README.md): deification gate, stat totals, detail 4125.
- [../account/README.md](../account/README.md): vice password 8809 for item locks.
- [../inventory/README.md](../inventory/README.md): 5005 and 115; bags 0, 1, 34, 38, 39; `slate` and `storehouse` protos.
- [../smith/README.md](../smith/README.md): armor compose, treasure strengthen 5150, resolve 8683, refine.
- [../currency/README.md](../currency/README.md): Gema Poseidon (-19000), crystals (type 71), collection points (type 70), push 4725.
- [../shops/README.md](../shops/README.md): shops 1034 and 1035, 8970.
- [../battle/README.md](../battle/README.md): battleTypes 3913, 3914, 3915; war soul skills 10522, fury 4311.
- [../campaign/README.md](../campaign/README.md): challenge floors use 5125, 5120, 10008.
- [../quests/README.md](../quests/README.md): quest 1389.
- [../sky-realm/README.md](../sky-realm/README.md): NPC 49 dialog options.
- [../exploration/README.md](../exploration/README.md): secret adventure `passMapId` for inner slots and core.
- [../vip/README.md](../vip/README.md): hatch privileges 23 and 24 (missing from templates).
- [../theseus-arena/README.md](../theseus-arena/README.md): Theseus PvP.

## Implementation order

1. `soul`: shell, snapshot and the shared 4300 builder.
2. `equipment-suits`, `war-frame`: armor.
3. `war-intent`, `treasure`: stat progression.
4. `war-soul`, `war-soul-training`.
5. `godhead`: self-contained, and its plates are rewards elsewhere.
6. `dungeon`, `tower`: need the battle engine.
7. `box`: needs campaign routes and a decision on its entry point.
8. `collection`: hidden by the version switch, lowest priority.
