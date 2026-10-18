# Endless Abyss ("Abismo sem fim")

Feature slug `abyss`, domain `pve`. Registry: client package `abysm` (`decompiled/m11/scripts/abysm`), no proto package (`roadmap/features.json`). Following the code adds `CM/yishi/manager/OutyardManager.as` (abyss part), `CM/mvc/module/outyard/AbysmModel.as`, `AbysmBossInfo.as`, `AbysmChildInfo.as`, the guardian formation frame `M14/childabysm/*` (package registered to [../guardians/README.md](../guardians/README.md)), the sweep frames `M5/mopup/view/AbysmMopup*.as` and `HellAbysmMopup*.as` (package registered to [../mopup/README.md](../mopup/README.md)) and the drop templates `GuardEndlessDrop.xml`, `GuardEndlessHorribleDrop.xml`. The messages are in proto package `guardendless`, which the registry assigns to [../final-defense/README.md](../final-defense/README.md); this feature is their only client user.

An endless tower fought with guardians ("Espírito de Proteção", children) only. The player climbs floors ("piso"); each floor has 7 waves; each wave shows up to six bosses of which `bossNum` appear at the same time. Before the first wave of a floor the player can rearrange up to four guardians (fighting order and grid position); some slots can be sealed by the floor. A record ("Recorde máximo") allows sweeping ("Bot") the cleared floors later, 30 seconds per floor, accelerable with diamonds. A harder variant, "Abismo Sem Fim (Inferno)", shares the same protocol with a flag.

| Module | pt-BR | What it covers | Transport |
|---|---|---|---|
| [abyss-tower.md](abyss-tower.md) | "Abismo sem fim", "Abismo Sem Fim (Inferno)" | Main frames (normal and hell), info, challenge, waves, bosses, drop preview, battles 3867 and 3889 | 9644 ops 1 and 3, 423, 427 |
| [formation.md](formation.md) | "Ajustar Formação" | Guardian order and grid positions, seal rule, first-wave-only rule | 9644 op 2 |
| [sweep.md](sweep.md) | "Modo Bot Abismo sem fim", "Bot do Abismo Sem Fim (Inferno)" | Sweep to a floor, progress polling, accelerate, stop, per floor rewards | 9644 ops 4, 5, 6, 7, 423, 428 |

Conventions used in every module file:
- Paths are relative to `decompiled/` unless they start with `raw/`, `protocol/`, `index/`, `docs/` or `build/`.
- `CM` = `core_module/scripts`, `M3` = `m3/scripts`, `M5` = `m5/scripts`, `M11` = `m11/scripts`, `M14` = `m14/scripts`.
- Opcode names come from `protocol/opcodes.csv`. Proto tags were read from the AS3 `writeToBuffer` of `CM/com/road/yishi/proto/guardendless/*.as`.
- *(assumption)* marks anything the client does not prove.

## Entry points

| Entry | Where | Unlock condition | Opens |
|---|---|---|---|
| NPC dialog option 130 "Abismo Sem Fim" | NPC 42 "Podor, Abismo Sem Fim", space map 10000 (`raw/xml/tempinfos/MapNodeInfos.xml` node 42), dispatch `M3/map/space/view/frame/DialogOptionItem.as:782-784` | `SwitchPageHelp.openAbysmFrame` (`CM/yishi/SwitchPageHelp.as:2376-2393`): knight job change ("Necessário atingir profissão cavaleiro para entrar"); at least one guardian ("Você ainda não contém nenhum guardião"); `checkScene()` | `abysm.AbysmFrame` (controller key `abysm`, openType 7, `CM/mvc/controler/OutyardControler.as:75-78`) |
| Daily guide item type 74 | `CM/managers/DayGuideManager.as:896-898` | same | same |
| NPC dialog option 148 | `DialogOptionItem.as:843-845` → `SwitchPageHelp.openHellAbysmFrame` (`CM/yishi/SwitchPageHelp.as:2395-2412`), same checks | No NPC in the local `MapNodeInfos.xml` offers option 148 *(the hell variant has no reachable entry in the local data)* | `abysm.HellAbysmFrame` (openType 11) |
| Return from battle 3867 or 3889 | `isAbysmBattle`, `isHellAbysmBattle` (`CM/battle/handler/BattleResultHandler.as:418-421, 465-468`) | | Reopens the frame (`M3/map/space/SpaceSceneController.as:310-313, 393-396`) |

No VIP condition, no hero level condition besides the job change.

## Dependencies

| Feature | Why |
|---|---|
| [../guardians/README.md](../guardians/README.md) | Fighting units are the player's guardians (`ChildManager.model.childList`); the formation frame `childabysm.ChildAbysmFormationFrame` is in that package; drops are guardian items |
| [../mopup/README.md](../mopup/README.md) | Sweep frames (controller `mopup` openTypes 7, 8, 17, 18), bot mode flags on the tool bars |
| [../battle/README.md](../battle/README.md) | battleType 3867 `ABYSM_BATTLE`, 3889 `HELL_ABYSM_BATTLE` (P-CHILD, P-NOHERO, P-75, P-BUFFICON; `docs/battle/rules.md`) |
| [../final-defense/README.md](../final-defense/README.md) | Owner of the `guardendless` proto package in the registry |
| [../fantasy-bar/README.md](../fantasy-bar/README.md) | Magic spring buffer 18 shown on the normal frame |
| [../returning-players/README.md](../returning-players/README.md) | King contract buff 4: free accelerate in the sweep |
| [../inventory/README.md](../inventory/README.md) | Rewards |

## Suggested implementation order

1. Templates `GuardEndlessDrop.xml` (224 waves) and `GuardEndlessHorribleDrop.xml` (210 waves); boss wave definitions (server data, not in the client).
2. Table `abyss.progress` and op 1 → 423 ([abyss-tower.md](abyss-tower.md)).
3. [formation.md](formation.md): op 2.
4. Op 3 challenge: battle 3867/3889 with guardians, wave advance, rewards, 427.
5. [sweep.md](sweep.md): ops 4..7, 428, timers.
