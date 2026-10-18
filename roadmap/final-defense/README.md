# Final defense ("Defesa final") and mini PvE games

Domain: pve. `roadmap/features.json` groups three unrelated client packages and four protobuf packages under this slug:

| Package | pt-BR name | What it is |
|---|---|---|
| `finaldefense` (M11 scene `finaldefense.FinalDefenseScene`, core `mvc.module.finaldefense`, `managers.FinalDefenseManager`) | "Última Trincheira" (game box game 4, scene `FINAL_DEFENSE_SCENE`) | Single player lane defense ("plants vs zombies" style, resources `images/pvz/*.swf`): own units on 5 rows attack incoming monsters, energy upgrades units, 3 buyable skills, 5 rounds, score boxes. Protocol messages are `gamebox.LastDitch*` (opcodes 9560, 9562, 9563 / 258, 262, 264, 267, 270) |
| `landmine` (M11 `landmine.*`, core `mvc.module.landmine`, `yishi.manager.LandMineManager`) | "Campo de Minas" | 4 player team game: 5 stages of 4 stones with hidden mines, reach the end castle; daily reward by mail. Opcodes 5192 / 4882, message `module.LandMineMsg` |
| `unrealshooting` (M9 lobby/room/ranking, M3 campaign map mediators and HUD, core `mvc.controler.UnrealShootingController`) | "Caça Fantástica" | Cross server 4v4 real time arena on campaign map 5703 with vehicle-like heroes, towers, crystals and buffs, twice a day; weekly ranking. Opcodes 9662, 25202, 25203 / 4828..4836 |
| proto `guardscuffle` | "守卫竞技" (guardian scuffle) | No client user in this build; opcodes 4992/4993 are reused by the glory game. See [guard-scuffle.md](guard-scuffle.md) |
| protos `guardpve`, `guardendless` | "Guardiões Procurados", "Abismo sem fim" | Already mapped by their client owners: [guardians](../guardians/README.md) (`guardians/pve.md`, opcode 9548 / 4979) and [abyss](../abyss/README.md) (opcode 9644 / 423, 427, 428). The abyss sweep ops of 9644 are also catalogued in [mopup](../mopup/README.md). Not duplicated here. |

PostgreSQL schema: `final_defense`. Rust handlers: `final_defense::<module>::handle_<action>`.

## Entry points

| Entry | Condition | Opens |
|---|---|---|
| Game box ("Caixa de jogos") start game 4: 9559 `GameBoxInfoMsg` op 2 `starGameId = 4` -> 257 op 2 -> `GameBoxManager.enterGame4` (`decompiled/core_module/scripts/managers/GameBoxManager.as:76-83`, `:116-131`, `:180-183`) | game box owner feature [time-story](../time-story/README.md) | `FINAL_DEFENSE_SCENE` ([last-ditch.md](last-ditch.md)) |
| Top toolbar button `landmine` (`decompiled/core_module/scripts/ui/toptoolbar/TopToolsBar.as:1444-1446`) | `VersionSwitch.LANDMINE && thane.vocationGrades > 0 && checkIsRightScene()` (`decompiled/core_module/scripts/ui/toptoolbar/TopBtnCheckShowHelper.as:377-378`) | `LandMineTeamFrame` ([land-mine.md](land-mine.md)) |
| Top toolbar button `unrealshooting` (`TopToolsBar.as:1423-1424`) | `thane.grades >= 1 && VersionSwitch.UNREALSHOOTING && checkIsRightScene()` (`TopBtnCheckShowHelper.as:361-362`); shown while 4836 says the activity is visible | `UnrealShootingFrame` ([unreal-shooting.md](unreal-shooting.md)) |

## Modules

| Module | Content |
|---|---|
| [last-ditch.md](last-ditch.md) | Final defense lane game: ops 5, 6, 7, 2, 3, 1 on 9560, attack/skill on 9563, move 9562; pushes 258, 262, 264, 267, 270 |
| [land-mine.md](land-mine.md) | Campo de Minas: 5192 ops 0..4, push 4882 ops 0..6 |
| [unreal-shooting.md](unreal-shooting.md) | Caça Fantástica: 9662 ops 1..6, 25202 attack, 25203 pick, pushes 4828, 4829, 4830, 4833, 4834, 4835, 4836 |
| [guard-scuffle.md](guard-scuffle.md) | Unused `guardscuffle` protocol reference |

## Dependencies

- Game box start (9559/256/257) and its medal shop: [time-story](../time-story/README.md) (owner of the `gamebox` package).
- Team system (`FreedomTeamManager`, team invites) and game hall scene for Campo de Minas: [team](../team/README.md), [casino](../casino/README.md) ("Salão de jogo", `GameHallManager`).
- Campaign map scene, vehicle movement and buffs for Caça Fantástica: [campaign](../campaign/README.md), [artillery](../artillery/README.md) (`vehicle` protos `VehicleAttackReqMsg`, `VehiclePickPropMsg`, `VehicleSkillListMsg`, `VehicleBuffListMsg`).
- Mail for rewards: [mail](../mail/README.md).

## Suggested implementation order

1. [land-mine.md](land-mine.md) (small, self contained, needs teams).
2. [last-ditch.md](last-ditch.md) (needs the missing `DitchTemplateInfos` data, see its open questions).
3. [unreal-shooting.md](unreal-shooting.md) (cross server matchmaking, real time map: last).
