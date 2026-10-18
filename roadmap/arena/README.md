# Arena and colosseum ("Arena e coliseu")

Feature slug `arena`. Client packages: `pvp` (`decompiled/m9/scripts/pvp`, hub "Salão da Arena"), `pvproomlist` (`decompiled/m9/scripts/pvproomlist`, team arena rooms), `colosseum` (`decompiled/m13/scripts/colosseum`, "Coliseu"), `godpvpenter` (`decompiled/m11/scripts/godpvpenter`, "Domínio da Arena"), `dreamarena` (`decompiled/m13/scripts/dreamarena`, "Arena Ilusória"). Protobuf packages assigned here: `pvp` and `guardpvp`.

Citation prefixes: `CM/` = `decompiled/core_module/scripts/`, `M3/`, `M4/`, `M9/`, `M11/`, `M13/` = `decompiled/m<n>/scripts/`, `TPL/` = `raw/xml/tempinfos/`, `LANG` = `index/language.json`, `PTT` = `CM/yishi/datas/consant/ProtocolTypeTable.as`. "(A)" marks an assumption.

## What it is for the player

| Mode | pt-BR | Summary |
|---|---|---|
| Team arena | "Arena" / "Arena multijogador" (frame title `mainBar.TopToolsBar.pvpBtnIipData`) | Daily time window (`MatchTime` 12:00 to 14:00 and 18:00 to 20:00). Players (level 22+) join 4 seat rooms (room type 1), the owner starts, the server matches rooms and moves both teams into a PvP war field map where they fight for score and "geste"; rewards and the arena shop ("Loja da Arena", currency 8 "Medalha") |
| Colosseum | "Coliseu" / "Desafio individual" | Asynchronous ranked challenge ladder: pick one of 4 nearby ranked players, battle 16 `BATTLE_CHALLENGE` (auto), swap ranks on win; daily free and paid challenges, cooldown queue, periodic rank reward of gold and spirits |
| Dream arena | "Arena Ilusória" | Event: build a fantasy line-up from templates (hero, dragon talker, pets, goddess, artifact, titan, guardians, runes, talismans), open a run with a ticket, fight battle 3885 until 12 wins or 3 losses, reward by wins |
| Arena domain | "Domínio da Arena" | Hub frame with the entries to the Theseus arenas ([../theseus-arena/README.md](../theseus-arena/README.md)) |
| Chaos battle | "Batalha do Caos" (svs, `pvp` proto) | Server vs server top 40 team war; legacy, no reachable entry in this client |

## Entry points

| Entry | Condition | Code |
|---|---|---|
| Top bar `pvp` (time active box) | level >= 22 (`TopBtnType.TIME_ACTIVE_GRADES[0]`), server flag `isPVPStart` from 4201 | `CM/ui/toptoolbar/TopBtnCheckShowHelper.as:219-220`; `CM/ui/toptoolbar/TopToolsBar.as:1359-1365,1581-1601`; `CM/ui/toptoolbar/view/TimeActiveBoxView.as:93-99` -> controller `pvproomlist` |
| Frame `pvp` ("Salão da Arena") with tabs single (colosseum scene) and multi (room list) | reopened after colosseum battles (`ChallengeManager.showPVPFrame`) | `M9/pvp/PvPFrame.as`; `M9/pvp/view/PvPSingleView.as:90-96`; `M9/pvp/view/PvPMultiView.as:65-89` |
| Castle colosseum building | | `M4/castle/CastleSceneView.as:117` -> controller `colosseum` |
| Top bar `dreamarena` | `VersionSwitch.DREAM_ARENA && model.isShow && checkIsRightScene()` | `CM/ui/toptoolbar/TopBtnCheckShowHelper.as:385-386`; `CM/ui/toptoolbar/TopToolsBar.as:1464-1466` |
| NPC option 162 | | `CM/yishi/SwitchPageHelp.as:3150-3153` -> `godpvpenter` |

## Modules

| Module | File | Content |
|---|---|---|
| Team arena rooms and war field | [team-arena.md](team-arena.md) | 4201 open flag, room type 1 list/create/find/enter/ready/start, PvP map war field (4252, 4254, 4255, 8334), shop 3 |
| Colosseum | [colosseum.md](colosseum.md) | 8256 -> 4169, 8253 challenge, 8265 cooldown, 4176 cooldown queue, 4243/4244 rank reward, hero ranking file `challengeorder.xml`, battle 16 |
| Dream arena | [dream-arena.md](dream-arena.md) | 8654 ops 0..13, 4581..4584, battle 3885, `DreamArenaTemplates`, `DreamArenaDrop` |
| Arena domain hub | [arena-domain.md](arena-domain.md) | `godpvpenter.GodPvpEnterFrame` |
| Chaos battle (svs), legacy | [chaos-battle.md](chaos-battle.md) | `pvp` proto: 8863/8864/8867/8870/8872/8874/8991/25142, 4743/4744/4750/4754/4755/4756/4776/4778 |

Protobuf coverage notes:

- `pvp` package: `PvpMsg`, `PvpInfoMsg`, `PvpUserMsg`, `PvpUserInfoMsg`, `PvpCampaignMsg` -> [chaos-battle.md](chaos-battle.md); `TheseusPvp*` / `TheseusMultiPvp*` -> [../theseus-arena/README.md](../theseus-arena/README.md); `ChildPvp*` (guardian arena "Arena do Espírito de Proteção", opcodes 568..574, 9732) -> [../guardians/README.md](../guardians/README.md).
- `guardpvp` package (9657 / 453, "Guardião Leida") -> [../guardians/arena.md](../guardians/arena.md). Not duplicated here.

## Dependencies

| Feature | Why |
|---|---|
| [campaign](../campaign/README.md) | room protocol (type 1), campaign enter 5039, PvP map scene, war field messages |
| [battle](../battle/README.md) | battle types 16, 3885 and the map PvP fights |
| [shops](../shops/catalog.md) | arena shop 3 and 1020, chaos shop 19 |
| [castle](../castle/README.md) | colosseum building and its cooldown queue (`BuildingManager.colosseumOrderList`) |
| [vip](../vip/README.md) | free cooldown speed up (`vipCoolPrivilege`) |
| [guardians](../guardians/README.md), [goddess](../goddess/README.md), [einherjar](../einherjar/README.md), [dragon](../dragon/README.md), [divine-weapon](../divine-weapon/README.md) | dream arena line-up components (template driven) |
| [theseus-arena](../theseus-arena/README.md) | hub entries |

## Suggested implementation order

1. Colosseum (self contained, already partly mocked in `server/flows/battle.json`: 8253 and 8256).
2. Team arena: 4201 window flag, room type 1, matching, war field map.
3. Arena domain hub (no protocol) once Theseus arena exists.
4. Dream arena (event, needs many companion templates).
5. Chaos battle only if an entry point is found.
