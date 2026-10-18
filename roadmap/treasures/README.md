# Caças ao tesouro e tesouros (`treasures`)

Domain: events. Client packages `treasurehunt` (m3), `skytreasure` (m11), `godtreasure` (m11) and `map/internals/view/treasuremap` (m3), plus shared code in `core_module`: `managers/TreasureHuntManager.as`, `managers/TreasureMapManager.as`, `managers/TreasureMapSocketOutManager.as`, `managers/GodTreasureManager.as`, `yishi/manager/SkyTreasureManager.as`, `mvc/module/{treasurehunt,treasuremap,skytreasure,godTreasure}/*`, controllers `TreasureHuntControler`, `TreasureMapFrameController`, `SkyTreasureControler` (old), `SkyTreasureController` (new), `GodTreasureControler`. Protobuf packages `treasuremap`, `seek`, `active` (`TreasureHunt*`, `GodTreasure*`, `PlayerCrashInfoMsg`, `TreasureRankMsg`) and `cccactive` (`SkyTreasure*`).

## Overview

Five independent systems share the "tesouro" theme:

| System | pt-BR | What the player does | Status in this client |
|---|---|---|---|
| Lost treasure maps | "Tesouro Perdido" | NPC option gives a daily treasure map of 4 qualities (refresh to upgrade), the player walks to the hidden spot or pays to dig at once, fights the guardian with his team and gets rewards | live (get frame); dig frame unreachable |
| Sky treasure flight | "Tesouro do Céu" | time limited event: charge energy stones, fly up hitting boxes, height ranking, height rewards | reachable only through controller `skytreasure`, no opener in this client |
| Celestial treasure | "Tesouro celeste" | cross-server lottery ("Sorteio"), exchange shop ("Trocar") and score rankings driven by server sent activity templates | live (top toolbar `skytreasure1`) |
| Treasure hunt | "Caça ao Tesouro" | 10 regenerating seek attempts on a world map, events at nodes, magic fragment exchange | frame opens but every request is a no-op (`TreasureHuntControler.sendHuntRequest` is empty) |
| God treasure | "Tesouro dos Deuses" | invest diamonds stage by stage in a floating box, get diamond profit | dormant: no opener, template cate never created |

## Entry points

| Entry | Condition | Opens | Source |
|---|---|---|---|
| Space NPC node option type 13 (`SpaceArmyViewHelper.getNodeFrameName` 13 -> `treasuremap`) | none client side; option title shows "{0} (Quantidade de ganho {1} / {2})" | `TreasureMapGetFrame` | `decompiled/m3/scripts/map/space/helper/hero/SpaceArmyViewHelper.as:208-209`, `decompiled/m3/scripts/map/campaign/view/frame/NewbieVillageDialogFrame.as:277-281` |
| Top toolbar `skytreasure1` | visible when at least one open non rank activity template exists | `SkyTreasureFrame1` "Tesouro celeste" | `decompiled/core_module/scripts/ui/toptoolbar/TopBtnCheckShowHelper.as:429-430`, `TopToolsBar.as:1075-1076` |
| Controller `skytreasure` | none | `SkyTreasureFrame` "Tesouro do Céu" | `decompiled/core_module/scripts/yishi/manager/FrameControllerManager.as:1650-1651` |
| Chat seek link (cell type 26, XML tag `t="100"`), task condition 91 (`SwitchPageHelp.gotoTreasureHunt`) | not in battle, no Athena team; level >= 32 | `TreasureHuntFrame` | `decompiled/core_module/scripts/chat/view/ChatOutputViewII.as:379-391`, `decompiled/core_module/scripts/yishi/SwitchPageHelp.as:1819-1832`, `decompiled/core_module/scripts/mvc/controler/TreasureHuntControler.as:30-40` |
| Controller `godtreasure` | activity type 145 window (`FunnyManager.godTreasureStart/End`) | `GodTreasureFrame` | `decompiled/core_module/scripts/managers/FunnyManager.as:552-556` |

## Modules

| Module | File | Scope |
|---|---|---|
| Lost treasure maps | [treasure-map.md](treasure-map.md) | 8744 ops 1..6, 4633, 4634, quality refresh, dig, guardian battle, daily counters |
| Celestial treasure | [celestial-treasure.md](celestial-treasure.md) | activity templates 778, lottery 9025/774, records 9026/775, exchange 9027/776/777, rankings 9030/9031/9032/772/773 |
| Sky treasure flight | [sky-treasure-flight.md](sky-treasure-flight.md) | 8966 ops 1..8, 4769, 4770, 4956 |
| Treasure hunt | [treasure-hunt.md](treasure-hunt.md) | 9502 (no sender), 4914, 4915, `PlayerMsg.seekSurplusTime` |
| God treasure | [god-treasure.md](god-treasure.md) | 9546 ops 1..3, 4968 |

## Protocol summary

| Dir | Opcode | Hex | Name | Module |
|---|---|---|---|---|
| C>S | 8744 | 0x2228 | `C_TREASUREMAP_OP` (`PlayerTreasureMsg`) | treasure-map |
| C>S | 8745 | 0x2229 | `C_TREASUREMAP_BATTLE_REINFORCE` (no sender) | treasure-map |
| S>C | 4633 | 0x1219 | `U_C_TREASUREMAP_INFO` | treasure-map |
| S>C | 4634 | 0x121a | `U_C_TREASUREMAP_REWARD` | treasure-map |
| C>S | 9025 | 0x2341 | `C_SKY_TREASURE_LOTTERY_INFO_REQ` | celestial-treasure |
| C>S | 9026 | 0x2342 | `C_SKY_TREASURE_LOTTERY_RECORD_REQ` | celestial-treasure |
| C>S | 9027 | 0x2343 | `C_SKY_TREASURE_EXCHANGE_REQ` | celestial-treasure |
| C>S | 9030 | 0x2346 | `C_SKY_TREASURE_REQ_RANK_INFO` | celestial-treasure |
| C>S | 9031 | 0x2347 | `C_SKY_TREASURE_RANK_HISTORY_REQ` | celestial-treasure |
| C>S | 9032 | 0x2348 | `C_SKY_TREASURE_EXCHANGEUPDATE_REQ` | celestial-treasure |
| S>C | 772..778 | 0x0304..0x030a | `U_C_SKY_TREASURE_*` | celestial-treasure |
| C>S | 8966 | 0x2306 | `C_TREASURE_HUNT_OPTION` (`TreasureHuntOpMsg`) | sky-treasure-flight |
| S>C | 4769 | 0x12a1 | `U_C_TREASURE_HUNT_ACTIVE_INFO` | sky-treasure-flight |
| S>C | 4770 | 0x12a2 | `U_C_TREASURE_HUNT_RANK_INFO` | sky-treasure-flight |
| S>C | 4956 | 0x135c | `U_C_TREASURE_HUNT_CRASH_SCORE` | sky-treasure-flight |
| C>S | 9502 | 0x251e | `C_SEEK_REQ` (no sender) | treasure-hunt |
| S>C | 4914 | 0x1332 | `U_C_SEEK_LOADNODEINFO` | treasure-hunt |
| S>C | 4915 | 0x1333 | `U_C_SEEK_MESSAGE` | treasure-hunt |
| C>S | 9546 | 0x254a | `C_GODTREASURE_REQ` | god-treasure |
| S>C | 4968 | 0x1368 | `U_C_GODTREASURE_RSP` | god-treasure |

Note: protocol/opcodes.csv names 8746 `C_TREASUREMAP_REQUEST`, but this client uses 8746 as "refuse team invite" (`SocketSendManager.sendRefuseTeamInvite`, `decompiled/core_module/scripts/yishi/service/managers/SocketSendManager.as:432-436`). It belongs to [team](../team/README.md).

## Dependencies

- [inventory](../inventory/README.md): treasure map items (2190001..2190004), bag pushes, Baiding wine 208050, energy stones 208049, magic fragments 2131019, time roulette 2131022.
- [currency](../currency/README.md): diamonds (`point`) and bound diamonds (`giftToken`) for refresh, dig, lottery, god treasure investment.
- [team](../team/README.md): treasure map rewards scale with the free team; reinforcement chat link.
- [marriage](../marriage/README.md): SonType 320 marriage task maps reuse `TreasureMapManager.checkTreasureMap` and send `C_MARRIAGE_OP` 8774 op 2004.
- [world-map](../world-map/README.md) and [campaign](../campaign/README.md): space scene NPC node 13, pet land and mineral scenes for digging, walking to coordinates.
- [rankings](../rankings/README.md): cross-server ranking feed for the celestial treasure.
- [recharge](../recharge/README.md): `RechargeAlertMannager` when diamonds are short; activity type 145 window for god treasure comes from the activity list (`SumActiveinfoMsg`).
- [magic-cards](../magic-cards/README.md): the hunt glow on the magic card button; [fantasy-bar](../fantasy-bar/README.md) is opened by the magic card "treasure" button.

## Suggested implementation order

1. Treasure map: tables, 8744 op 6 and 4633, op 1 (get), op 2 (refresh), daily reset. Then the dig flow (op 3, op 5, 4634, op 4) with battle type 291.
2. Celestial treasure: activity template loader and 778 at login, 774 and 9025 lottery, 9026/775, exchange 9027/776/777, rankings 9030/9032/772 and history 9031/773, scheduled rank rewards.
3. Sky treasure flight: only if the controller is wired to an entry (activity list); 8966 ops and pushes.
4. Treasure hunt and god treasure: implement the server state and pushes only if a client patch or later client enables the senders; keep the documented contracts.
