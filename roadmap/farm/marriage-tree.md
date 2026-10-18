# Marriage tree on the pasture

Module `marriage-tree` of feature `farm`. The couple tree ("Árvore do casal", marriage god tree) drawn on the pasture tab. Its state and routes belong to [marriage](../marriage/README.md); the farm only displays it and carries `MarriageTreeMsg` inside `FarmInfoRspMsg`.

Path aliases:

| Alias | File |
|---|---|
| MTV | `decompiled/m3/scripts/farm/view/marrytree/MarryTreeView.as` |
| PV | `decompiled/m3/scripts/farm/newview/PastureView.as` |
| FM | `decompiled/core_module/scripts/farm/FarmManager.as` |
| MM | `decompiled/core_module/scripts/managers/MarryManager.as` |
| MS | `decompiled/core_module/scripts/mvc/module/marry/MarrySender.as` |

## 1. Overview

`PastureView` adds a `MarryTreeView` (style `PastureView.marryTree`, `PV:56-72,93-106`); the legacy garden layer also creates one (`decompiled/m3/scripts/farm/view/FarmWalkLayer.as:36-55`). The view reads `MarryManager.model.marriageData.godTreeInfo` (`MTV:373-376`): `treeState` for the own farm, `mateTreeState` on the spouse's farm; it is hidden for unmarried players ("Após casar será desbloqueado"). States (`MTV:213-280`): 0 idle (owner click opens the foster frame), 1 weeds, 2 worms, 3 ripe (pick marker, feed button), 4 limit reached.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `MarryTreeView` (`MTV`) | | tree with state markers and countdown "Contagem do amadurecimento: {0}" (12 h from `treeEarningDate`, `MTV:350-360`) | `PV` | `godTreeInfo` |
| `MarryTreeFosterFrame` | | foster (train) the tree | owner click in state 0 or feed button (`MTV:177-187,397-404`) -> `MM.creatTreeFosterFrame` | owned by [marriage](../marriage/README.md) |

## 3. Routes (client to server)

C>S 8773 (0x2245) `C_MARRIAGE_TREE_REQUEST`, `marriage.MarriageOpMsg` via `MS.opMarryTree(op, payType, property1)` (`MS:42-50`): `op_type (#2, INT32)`, `pay_type (#3, INT32)` = -1, `property1 (#4, INT32)`.

| UI | op_type | property1 | Source |
|---|---|---|---|
| click in state 1 or 2 (weed / worm, own or spouse farm) | 1003 | farm owner id | `MTV:188-191` |
| click in state 3 (harvest) | 1004 | unset | `MTV:192-194` |
| click in state 4 | none: "Você já ultrapassou o limite  de energizações diárias." | | `MTV:195-197` |

Server logic, responses (4678 and marriage data pushes) and limits (`mar_tree_train_count` = 10, `mar_feed_count` read by `MTV:87-95` but absent from `ConfigInfos.xml`) are owned by [marriage](../marriage/README.md).

## 4. Server messages (server to client)

### S1. `FarmInfoRspMsg.marriage_tree` (#15) and 4678 (0x1246) `U_C_MARRIAGE_TREE`
Both carry `farm.MarriageTreeMsg`; `FM.readFarmInfoMsg` (`FM:244-267`) and `MM.__marryTreeUpdate` (`MM:333-356`) copy it into `MarryTreeInfo` and notify `MarryEventType.TREE_UPDATE`.

| Field | Tag | Type | Meaning |
|---|---|---|---|
| `userId_a`, `nickName_a`, `job_a` | #1, #2, #3 | INT32, STRING, INT32 | spouse A |
| `userId_b`, `nickName_b`, `job_b` | #4, #5, #6 | INT32, STRING, INT32 | spouse B |
| `stateValue` | #7 | INT32 | growth value |
| `feedCount` | #8 | INT32 | feeds done |
| `start_time`, `end_time` | #10, #11 | STRING | cycle times |
| `trainACount`, `trainBCount` | #12, #13 | INT32 | trainings by each spouse |
| `trainAType`, `trainBType` | #14, #15 | INT32 | training type |
| `isGetA`, `isGetB` | #16, #17 | BOOL | reward taken by each spouse |
| `tree_state` | #18 | STRING | state string |
| `feed_user` | #19 | INT32 | last feeder |

The farm server includes `marriage_tree` in 4386 for married owners by asking the marriage service.

## 5. Rules and formulas

Owned by [marriage](../marriage/README.md). Farm side: visible only to the couple (`MTV:283-305`).

## 6. Templates

`ConfigInfos.xml` `mar_tree_train_count`; `mar_feed_count` missing (gap).

## 7. Persistent state

None in the farm schema (marriage owns the tree).

## 8. Backend implementation notes

| Opcode | Handler |
|---|---|
| 8773 ops 1003, 1004 | `marriage::tree::handle_*` (owner) |
| 4386 assembly | `farm::farm_core::handle_query` calls `marriage::tree::snapshot(owner)` |

## 9. Open questions and assumptions

- Gap: `mar_feed_count` configuration missing from the template dump.

## 10. Implementation checklist

- [ ] `marriage_tree` field in 4386 for married owners.
- [ ] Coordination with marriage for 8773 ops 1003 and 1004 and 4678.
