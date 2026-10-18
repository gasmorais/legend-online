# Histórias e eventos de tempo (`time-story`)

Domain: events. Client packages `gamebox` (m11: `gamebox/GameBoxEnterFrame.as`, `view/*`, `vo/GameBoxGameVO.as`), `timestory` (m11: `timestory/TimeStoryFrame.as`, `UpdateBroadcastView.as`) and `findback` (`decompiled/core_module/scripts/mvc/module/findback/*`). Shared code: `decompiled/core_module/scripts/managers/GameBoxManager.as`, `mvc/module/gamebox/*`, `mvc/controler/TimeStoryControler.as`, `mvc/module/timestory/*`, `PlayerManager.__findBackHandler`. Protobuf package `gamebox` (`GameBoxInfoMsg`; the other messages of the package, `LastDitch*` and `DitchNpc*`, are read by [final-defense](../final-defense/README.md)), plus `active.GameStoryMsg` and `retrieve` (owned by [returning-players](../returning-players/README.md), mapped here because only `findback` reads it).

## Overview

| System | pt-BR | What the player does | Status |
|---|---|---|---|
| Game box | "Caixa do jogo" | hub of mini games opened from an NPC: fishing ("Pescar", game 1), gem maze (game 2), cloud adventure (game 3), final defense (game 4), each open on certain weekdays; exchange shop paying "Moeda do Jogo" for 4 daily rotating items | live |
| Legend journal | "Jornal Legend", "Edição {0}" | an illustrated newspaper (`gametimes.xml`) with update notes, events and comics; reading pages may drop eggs ("Ao ler o Jornal Legend poderá receber Ovos") | controller exists, no opener in this client |
| Find back | "Sistema de Resgate" | recover missed daily rewards for gold or diamonds | model only; the 4561 handler is never registered |

## Entry points

| Entry | Condition | Opens | Source |
|---|---|---|---|
| Space NPC dialog option 111 | level >= 28 ("DialogOptionItem.gloryroad.grade.text") | `GameBoxEnterFrame` "Caixa do jogo" | `decompiled/m3/scripts/map/space/view/frame/DialogOptionItem.as:752-760` |
| Controller `timestory` | `gametimes.xml` with at least 3 pages | `TimeStoryFrame` | `decompiled/core_module/scripts/yishi/manager/FrameControllerManager.as:1521-1522` (no caller) |

## Modules

| Module | File | Scope |
|---|---|---|
| Game box | [game-box.md](game-box.md) | 9559 ops 1..3, 256, 257, game launch, exchange shop |
| Legend journal | [legend-journal.md](legend-journal.md) | `{TPL}gametimes.xml`, 4492, 8629, 8630, 4546 |
| Find back | [findback.md](findback.md) | 4561 `RetrieveInfosMsg` |

## Protocol summary

| Dir | Opcode | Hex | Name | Module |
|---|---|---|---|---|
| C>S | 9559 | 0x2557 | `C_GAMEBOX_OP` (`GameBoxInfoMsg`; not in `protocol/opcodes.csv`, name from `ProtocolTypeTable.as:1455`) | game-box |
| S>C | 256 | 0x0100 | `U_C_GAMEBOX_INFO` | game-box |
| S>C | 257 | 0x0101 | `U_C_GAMEBOX_GAMESTART` | game-box |
| HTTP | | | `{TPL}gametimes.xml` | legend-journal |
| S>C | 4492 | 0x118c | `U_C_GAMETIMES_INFO` | legend-journal |
| C>S | 8629 | 0x21b5 | `C_GAME_STORY_REQUEST` (`active.GameStoryMsg`) | legend-journal |
| C>S | 8630 | 0x21b6 | `C_GAME_STORY_REWARD` | legend-journal |
| S>C | 4546 | 0x11c2 | `U_C_GAME_STORY_DROP` | legend-journal |
| S>C | 4561 | 0x11d1 | `U_C_FIND_BACK` (`retrieve.RetrieveInfosMsg`) | findback |

## Dependencies

- [fishing](../fishing/README.md) (game 1), [mazes](../mazes/README.md) (game 2, `gemMazeController`), [final-defense](../final-defense/README.md) (game 4, `FINAL_DEFENSE_SCENE`).
- [currency](../currency/README.md): "Moeda do Jogo" (template -4000) is the game box medal; find back gold and diamonds.
- [shops](../shops/README.md): journal links to shop, quick buy and fashion; [seasonal-events](../seasonal-events/README.md): journal "convert" link opens `funny`, and `FunnyControler` also reads `gametimes.xml`.
- [returning-players](../returning-players/README.md): owner of the `retrieve` package.

## Suggested implementation order

1. Game box: 9559 op 1 -> 256 (daily shop rotation), op 3 exchange, op 2 -> 257 with game id (fishing first).
2. Serve `gametimes.xml` from the CDN templates; 4492 when it changes; egg drop 8629 / 4546 / 8630.
3. Find back only if a client fix registers 4561.
