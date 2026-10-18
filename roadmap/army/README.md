# Army, soldiers and formation (Tropa, soldados e formação)

Feature slug: `army`. Domain: character. PostgreSQL schema: `army`. Rust module: `army`.

## Overview

The hero ("Líder") leads one troop: a stack of one soldier type (`PawnTempInfos`, "Lanceiro", "Arqueiro", "Espadachim", "Griffin", "Sacerdote", "Cavaleiro", "Anjo", "Demônio", "Presbítera", "Cavaleiro Mágico", "Anjo Mágico") whose size is limited by the hero's command (`totalConatArmy`). Soldiers are recruited with gold and population in the barracks ("Quartel", castle building SonType 402), kept in a castle reserve, assigned to the hero ("Tropa"), raised in level with soul points ("Espírito", `playerInfo.strategy`), and gain characteristics ("Características do Soldado"). The player chooses the hero position in the battle line ("Equipe") and, in rooms, the order of the team ("Formação dos Soldados").

The hero frame `armyII.ArmyFrameII` ("Equipamentos") also hosts two army-owned side systems: the battle guard (grids of gems, level 50) and the Dragon Soul / Holy Dragon Soul (level 40).

## Entry points

| Entry | Condition | Opens | Citation |
|---|---|---|---|
| Castle building "Quartel" (barracks) | building SonType 402 built | `buildings.casern.view.CasernFrame` with `PawnTileList` (recruit, "Elevar") | `decompiled/m4/scripts/buildings/casern/view/CasernFrame.as:29-40` |
| Troop panel | none in the controller | `armyII.AllocateFrame` "Tropa" (`PAWN_PANEL` → `army.PawnFrame`) | `decompiled/core_module/scripts/mvc/controler/ArmyControler.as:101-104` |
| Recruit from troop panel | barracks built, else "Você não tem Quartel" (`armyII.ArmyControler.command01`, `ArmyControler.as:190-205`) | `RECRUIT_PAWN` → `armyII.viewII.allocate.RecruitPawnFrame` "Abastecer tropa" | `decompiled/m5/scripts/armyII/viewII/allocate/AllocateView.as:211-215` |
| "Formação" | barracks built and soldiers > 0, else "Por favor prepare os soldados antes de iniciar o ajuste de formação" (`armyII.ArmyControler.command02`) | `SORT_PAWN` → `SortPawnFrame` | `ArmyControler.as:206-214` |
| Skill frame tab "Equipe" | hero level >= 11 | `armyII.viewII.lineUp.LineUpView` | `decompiled/m5/scripts/armyII/SkillFrame.as:189`, `:638-653` |
| Hero frame (key B, toolbar) tabs | battle guard: level >= 50 and Einherjar system open; Dragon Soul: level >= 40; Holy Dragon Soul replaces it when `dragonSoulType == 153` | `armyII.ArmyFrameII` | `decompiled/m5/scripts/armyII/ArmyFrameII.as:194-262`, `:857-992` |
| Rooms | room owner / leader / captain | `teammanager.TeamSortFrame`, `MatelordsSortFrame`, `GroupSortFrame` | `docs/battle/formation.md` §7.14-7.16 |

## Modules

| Module | File | Routes | Server messages | Tables |
|---|---|---:|---:|---:|
| Troops and army sync | [troops.md](troops.md) | 0 | 4 | 2 |
| Recruitment, barracks and troop assignment | [recruitment.md](recruitment.md) | 3 | 3 | 0 (uses troops tables) |
| Soldier upgrade, characteristics and conversion | [pawn-upgrade.md](pawn-upgrade.md) | 4 | 2 | 1 |
| Hero line-up and soldier formation | [formation.md](formation.md) | 1 | 2 | 0 (column in `army.troops`) |
| Room team order | [team-sort.md](team-sort.md) | 3 | 2 | 1 |
| Battle guard | [battle-guard.md](battle-guard.md) | 3 | 1 | 1 |
| Dragon Soul and Holy Dragon Soul | [dragon-soul.md](dragon-soul.md) | 3 | 1 | 1 |

## Opcode map (ArmyManager)

`ArmyManager` registers 150 at `setup()` and all other listeners after the first 150 (`decompiled/core_module/scripts/yishi/manager/ArmyManager.as:152-179`).

| Opcode | Name | Owner |
|---|---|---|
| 150 | `U_C_SERIAL_ARMY` | [troops.md](troops.md) |
| 92, 100 | `U_C_ARMY_RECRUITED`, `U_C_ARMY_UPDATE_ARMYPAWN` | [troops.md](troops.md), [recruitment.md](recruitment.md) |
| 93 | `U_C_ARMY_EDIT` | [troops.md](troops.md) |
| 116 | `U_C_PAWN_INFO` | [pawn-upgrade.md](pawn-upgrade.md) |
| 113 | `U_C_HERO_INFO` | [../hero/attributes.md](../hero/attributes.md) |
| 60, 61, 64, 4430, 4431, 4495, 4527, 539, 541 | skills, talents, runes | [../skills/README.md](../skills/README.md) |
| 274, 346, 301 | tattoos, fashion | [../fashion/README.md](../fashion/README.md) |
| 4544 | `U_C_FATE_REQUEST` (fate wheel skills, `FateListMsg`, fate types 2000/2100/2200) | [../lotteries/README.md](../lotteries/README.md) ("Roleta do Destino", `faterotary`) |

## Dependencies

- [../hero/README.md](../hero/README.md): hero level, command (`totalConatArmy`), fight position (`fight_pos` in 113), vocation.
- [../castle/README.md](../castle/README.md): barracks building (SonType 402, `BuildingTempInfos.Property4` recruit discount), population and gold resources.
- [../currency/README.md](../currency/README.md): gold, diamonds, soul points (`strategy`).
- [../inventory/README.md](../inventory/README.md): battle guard gems, dragon soul items, bag pushes.
- [../battle/README.md](../battle/README.md): soldiers and positions in battle (`docs/battle/formation.md`, `docs/battle/server-engine.md`).
- [../campaign/README.md](../campaign/README.md), [../venus-battle/README.md](../venus-battle/README.md), [../team/README.md](../team/README.md): rooms that use team sort.
- [../skills/README.md](../skills/README.md): `SkillFrame` hosts the "Equipe" tab.

## Suggested implementation order

1. [troops.md](troops.md): data model and 150 at login (blocks every other army and skill listener).
2. [recruitment.md](recruitment.md): recruit 5155, dismiss 5157, assign 5156.
3. [formation.md](formation.md): 8276 hero front/back.
4. [pawn-upgrade.md](pawn-upgrade.md): 5158 level up, then 8455/8456 characteristics and 8580 conversion.
5. [team-sort.md](team-sort.md) together with the room features.
6. [dragon-soul.md](dragon-soul.md) and [battle-guard.md](battle-guard.md).
