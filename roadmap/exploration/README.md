# Explorations and ruins ("Explorações e ruínas")

Domain: world. Registry entry `exploration`: client packages `monsterexplore`, `remainsexplore`, `dungenexploration`, `secretadventure`, `secret`; protobuf packages `secretexplore`, `seek`, `shuttle`. Several independent PvE explore systems share this folder; each module is self contained.

PostgreSQL schema: `exploration`. Rust handlers: `exploration::<module>::handle_<action>`.

Path aliases used in the modules:

| Alias | Path |
|---|---|
| `ME` | `decompiled/m14/scripts/monsterexplore/` |
| `RE` | `decompiled/m11/scripts/remainsexplore/` |
| `SA` | `decompiled/m3/scripts/secretadventure/` |
| `SY` | `decompiled/m11/scripts/outyard/shuttle/` |

## Modules

| Module | pt-BR | Opcodes | Status in this build |
|---|---|---|---|
| [monster-explore.md](monster-explore.md) | "Exploração de monstros" (idle beast exploration, boss battleType 3884) | 8653 -> 4576..4580 | `VersionSwitch.MONSTER_EXPLORE = false` |
| [remains-explore.md](remains-explore.md) | "Exploração das Ruínas" (tinder steps, events, bosses, activity chests; battleTypes 3899/3900) | 9703 -> 519, 520, 521 | `VersionSwitch.REMAINS_EXPLORE = false`; no NPC offers option 155 |
| [secret-adventure.md](secret-adventure.md) | "Expedição do Eremitério" (weekly hexagon roguelike, battleType 3904) | 9706 -> 524..527 | enabled, but `SwitchPageHelp.openSecretFrame` lost its body in decompilation |
| [seek.md](seek.md) | "Caça ao Tesouro" protocol (UI in [treasures](../treasures/README.md)) | 9502 -> 4914, 4915 | client sender empty, no request is ever sent |
| [shuttle.md](shuttle.md) | "Portal do Tempo" and "Chefão da Área Restrita" (Einherjar ladder, shared boss; battleTypes 3864/3865) | 8475, 8476, 15058 -> 4460, 4451, 4462 | enabled; UI under the `outyard` package |
| [../theseus/dungeon.md](../theseus/dungeon.md) | "Masmorra de Teseus" (package `dungenexploration`) | 9763 -> 779, 780 | documented in the theseus feature; not duplicated here |

## Entry points

| Entry | Condition | Opens |
|---|---|---|
| NPC dialog option 136, daily guide item 83 (`decompiled/m3/scripts/map/space/view/frame/DialogOptionItem.as:803-805`, `decompiled/core_module/scripts/managers/DayGuideManager.as:930-932`) | `MONSTER_EXPLORE` switch, level 70, task 1936 | monster explore |
| NPC dialog option 155 (`DialogOptionItem.as:865-867`) | `REMAINS_EXPLORE` switch, no team, "Classe Consagrada" | ruins exploration |
| NPC dialog option 159 (`DialogOptionItem.as:877-879`) | unknown (body lost) | hermitage expedition frame |
| Chat link "Ir à Caça", daily guide | level 32 | treasure hunt frame ([treasures](../treasures/README.md)) |
| NPC node 41 "Walpoth, Portal do Tempo" option 119, daily guide 73, queue bar order 15 | class changed (`isChangeJob`) | Time Portal (`outyard` openType 10) |
| NPC node 49 "Eliza, chefe da Zona Proibida" option 167 | see theseus | Theseus dungeon |

## Dependencies

- Battles: `docs/battle/server-engine.md` (battleTypes 3864, 3865, 3884, 3899, 3900, 3904).
- Beasts: [monsters](../monsters/README.md). Einherjars and their divine weapons: [einherjar](../einherjar/README.md). Royalty level ("Caminho da Realeza") gating the hermitage regions: [theseus](../theseus/README.md).
- Rewards and payments: [inventory](../inventory/README.md), [currency](../currency/README.md).
- Treasure hunt UI: [treasures](../treasures/README.md). Shuttle UI host: [outyard](../outyard/README.md).

## Not mapped (orphans)

- "秘境探索" island exploration: request 9646 (0x25ae) `C_ISLAND_EXPLORE_OP`, pushes 431 (0x01af) `U_C_ISLAND_EXPLORE` and 444 (0x01bc) `U_C_ISLAND_EXPLORE_SKILL` exist in `decompiled/core_module/scripts/yishi/datas/consant/ProtocolTypeTable.as:866`, `:881`, `:1527`, with config keys `explore_base_holy` and `explore_prop` and the icon path `PathManager.getIslandExploreSkillPath`, but no client class sends or reads them and `protocol/proto.json` has no message for them. Nothing to implement until a client exists.

## Suggested implementation order

1. [shuttle.md](shuttle.md) (enabled, reachable from an NPC, self contained).
2. [secret-adventure.md](secret-adventure.md) after repairing the `openSecretFrame` entry.
3. [seek.md](seek.md) after recovering the request sender.
4. [monster-explore.md](monster-explore.md) and [remains-explore.md](remains-explore.md) only if their version switches are turned on.
