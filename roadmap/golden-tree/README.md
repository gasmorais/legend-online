# Árvore de Ouro (`golden-tree`)

Domain: home. Client package `bottle` (m11: `bottle/*.as`) plus shared code in `core_module`: `managers/BottleManager.as`, `mvc/module/bottle/BottleModel.as`, `mvc/module/bottle/BottleUserInfo.as`, `events/BottleEvent.as`, `cell/view/bottlebag/BottleBagCell.as`, `cell/mediator/bottlebag/BottleBagCellClickMediator.as`, the top toolbar hooks (`ui/toptoolbar/TopToolsBar.as`, `TopBtnCheckShowHelper.as`) and the bag handler in `yishi/manager/GoodsManager.as` (bag type 22). Protobuf packages `bottle` (`BottleMsg`, `BottleScoreMsg`, `PlayerBottleMsg`) and `item` (`BottleOpMsg`, `BottlePassMsg`, `BottleDropListMsg`, `BottleItemInfoMsg`, `BottlePackage`). Internally the feature is called "魔罐" (magic jar), toolbar template 2039 "魔罐(新版黄金神树)".

## Overview

A timed event with a top toolbar button. The player spends diamonds (20, 200 or 1000 for 1, 10 or 50 opens) or "Bastão de Ouro" sticks (item 208022, one stick = one open) to shake the golden tree. Each open drops items from a server side drop table into a dedicated storage ("Armazém da árvore de ouro", bag type 22), from which items are moved to the bag one by one, all at once ("Coletar Tudo") or sold ("Vender Tudo"). Opens accumulate a personal counter ("Consumos") that unlocks 5 count chests. In parallel the whole server shares a 5 floor ("piso") tree: when the global open total crosses a floor threshold, the player whose open crossed it "derruba" the floor and can claim a rare floor chest. A scrolling feed shows the player's own drops and a global rare drop feed.

## Entry points

| Entry | Condition | Opens | Source |
|---|---|---|---|
| Top toolbar button `bottle` (template 2039) | hero level >= 11 and `BottleManager.openBottle` (event open and not ended, from 295) | sends 8604 op 4 | `decompiled/core_module/scripts/ui/toptoolbar/TopBtnCheckShowHelper.as:253-254`, `decompiled/core_module/scripts/ui/toptoolbar/TopToolsBar.as:1140-1142` |
| S>C 4526 with `open_view = true` | | controller `bottle` -> `BottleFrame` | `decompiled/core_module/scripts/managers/BottleManager.as:93-106`, `decompiled/core_module/scripts/mvc/module/bottle/BottleModel.as:212-220` |
| S>C 295 while the frame flag `hasOpenFrame` is set | | reopens controller `bottle` | `BottleManager.as:127-130` |

## Modules

| Module | File | Scope |
|---|---|---|
| Tree opening | [tree-open.md](tree-open.md) | event state, open with diamonds or sticks, drop list, drop feeds, storage (bag 22) pickup, sell, single move |
| Reward chests | [reward-chests.md](reward-chests.md) | personal count chests (5), global floor event (5 floors) and floor chests |

## Protocol summary

| Dir | Opcode | Hex | Name | Module |
|---|---|---|---|---|
| C>S | 8604 | 0x219c | `C_BOTTLE_OP` (`BottleOpMsg`, op_type 0..6) | both |
| C>S | 5005 | 0x138d | `U_C_BAG_MOVE` (`ItemReqMsg`, storage cell to bag) | tree-open |
| S>C | 295 | 0x0127 | `U_C_BOTTLE_DROP_DATA` (`BottleDropListMsg`) | both |
| S>C | 4526 | 0x11ae | `U_C_BOTTLE_RESULT` (`BottleScoreMsg`) | both |
| S>C | 4497 | 0x1191 | `U_C_BOTTLE_PASS` (`BottlePassMsg`, feeds) | tree-open |
| S>C | 4825 | 0x12d9 | `U_C_BOTTLE_ACTIVE` (`BottleMsg`, floor event) | reward-chests |
| S>C | 115 | 0x0073 | `U_C_BAG_MOVE_UPDATE` (bag 22 and bag 1) | both |
| S>C | 3 | 0x0003 | `U_C_PLAYER_INFO` (diamonds) | tree-open |

`BottleOpMsg.op_type` values used by the client:

| op_type | Sender | Meaning | Module |
|---|---|---|---|
| 0 | `BottleFrame.openCall` | open the tree, `alter_type` 1/2/3 = 1/10/50 opens, `stick_first` 0 = sticks first | tree-open |
| 1 | `BottleStorageFrame.giveupResponse` | sell all storage | tree-open |
| 2 | `BottleStorageFrame.__pickupHandler` | collect all storage | tree-open |
| 3 | frame close, after results and chest animations | refresh state | both |
| 4 | toolbar button | open view (request all data) | tree-open |
| 5 | `BottleBottomIntergalBoxView.onBoxClick` | claim count chest, `alter_type` = threshold | reward-chests |
| 6 | `BottleIntergalBoxView.onBoxClick` | claim floor chest, `alter_type` = floor threshold | reward-chests |

## Dependencies

- [currency](../currency/README.md): diamonds.
- [inventory](../inventory/README.md): bag type 22, `U_C_BAG_MOVE` 5005, push 115, sell price.
- [chat](../chat/README.md): feed strings use the chat content format (channel 21).
- [shops](../shops/README.md): item 208022 "Bastão de Ouro" source.
- [laboratory](../laboratory/README.md): "Pote mágico" / platinum jar (`PlatinumManager`) is a sibling event sharing the same design; not part of this feature.

## Suggested implementation order

1. Event configuration (start, end, drop table, chests, floors) and tables.
2. 8604 op 4 -> 295, 4526 (`open_view = true`), 4825, 4497 history.
3. op 0 open: costs, drops into bag 22, counters, feeds, 4526 `alter_bottle = true`.
4. Storage: op 2, op 1, 5005 single move.
5. Count chests op 5; floor event and op 6.
6. Daily reset of the floor event and end of event cleanup.
