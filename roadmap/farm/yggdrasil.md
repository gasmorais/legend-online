# Yggdrasil (water tree)

Module `yggdrasil` of feature `farm`. The farm tree ("Yggdrasil", `castle.view.CastleBuildingView.command07`): energizing ("energizar", watering) by the owner and friends, fruit collection, tree info and logs.

Path aliases:

| Alias | File |
|---|---|
| WM | `decompiled/core_module/scripts/yishi/manager/WaterManager.as` |
| TI | `decompiled/core_module/scripts/yishi/datas/playerinfo/TreeInfo.as` |
| WTM | `decompiled/core_module/scripts/water/data/WaterTreeModel.as` |
| BSO | `decompiled/core_module/scripts/managers/BuildingSocketOutManager.as` |
| WVC | `decompiled/m3/scripts/water/view/WaterViewContainer.as` |
| WEI | `decompiled/m3/scripts/water/view/WaterExpItem.as` |
| HF | `decompiled/m3/scripts/farm/newview/HomeFrame.as` |
| FM | `decompiled/core_module/scripts/farm/FarmManager.as` |
| LIDA | `decompiled/core_module/scripts/yishi/lunch/LoginInitDataAccept.as` |

## 1. Overview

Every farm has one tree shown in the farm tab (`WaterView` style `farm.FarmWaterLayer`, `decompiled/m3/scripts/farm/newview/FarmView.as:56`). The tree accumulates energy (`waterCount`) from energize actions until it reaches the energy needed for the farm level (UpGrade Types 7, 10 to 30); then it bears fruit (`fruitCount`). The owner collects fruits ("Cristais de Luz" and "Espíritos", better with farm level) with a cooldown. A friend can energize the tree once per day; the owner energizes with a cooldown. Help text: "Recarregue a Yaggdrasil 3 vezes diariamente, também é possivel recarregar a Yaggdrasil do seu amigo 1 vez".

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `WaterViewContainer` (`WVC`) | "Yggdrasil" | tree art, energize and pick cursors, cooldown timers, result animations | farm tab of `HomeFrame` | `waterCount`, `fruitCount`, `left_time`, `left_pickTime` |
| `WaterExpItem` (`WEI`) | | energy bar | farm tab | "Restam {0} pontos de energia para dar próximo fruto", "Energização máxima de hoje atingida", tip "Energia cheia pode obter Cristais de Luz e Espíritos" |
| `WaterLogFrame` | "Diário de Crescimento" | log list ("Diário da Yggdrasil", "Diário da Fazenda") | never opened in this client | `WM.logList` |

## 3. Routes (client to server)

### Y1. Energize (water)
- UI: click the tree with the water cursor (`WVC:322-351`), quick harvest on the farm tab (`HF:176-179`).
- Client checks (`TI:207-222`, `WVC:329-347`): allowed only if the viewer may still energize this tree today (`FriendFarmStateInfo.canGivePower`, from 4190/4157); own tree with `left_time > 1` (cooldown) -> "Tempo de energização não atingido"; tree already has fruit -> blocked; energy full for the farm level -> "Energia máxima atingida"; already energized today -> "Você já energizou hoje".
- Sender `BSO.water(userId)` (`BSO:100-106`): C>S 15017 (0x3aa9) `CH_TREE_WATER`, `building.BuildingReqMsg`: `user_id (#4, INT32)` = tree owner; `order_id (#1)`, `position (#2, STRING)`, `index (#3)` unset.
- Response order: 146 `U_C_HARVEST_MSG` to the actor (result texts), 147 `U_C_TREEINFO_UPDATE` (new tree state) to the actor and the owner, 4158 `U_C_SEND_WATER_RESULT` to the actor (clears `canGivePower` for that friend), 145 `U_C_WATERLOG_SEND` to the owner (log line).

### Y2. Collect fruits (pick)
- UI: click the own tree with the pick cursor (`WVC:299-321`), quick harvest (`HF:170-175`).
- Client checks: own tree only (`TI:190-205`); no fruit -> "Energia insuficiente, não é possível coletar"; `left_pickTime > 0` -> "Em resfriamento, não é possível coletar".
- Sender `BSO.pickFruits(0)` (`BSO:92-98`): C>S 5178 (0x143a) `U_C_TREE_PICK`, `BuildingReqMsg`: `index (#3, INT32)` = 0.
- Response order: 106 `U_C_TREE_PICK` with `pickMsg` (reward lines, animated in two steps `WVC:598-660`), 4189 `U_C_PICK_HARVEST_MSG` with `harvestMsg` (`WVC:569-596`), 147 tree update, resource pushes (light crystal -600, spirit -300).

### Y3. Request trees
- Sender `WM.sendGetTreeInfoById(userId)` (`WM:231-237`), sent once when the hero reaches level 11 (`WM:96-102`).
- Route C>S 8219 (0x201b) `C_TREE_FRIEND`, `FriendTreeReq`: `friendId (#1, INT32, repeated)`.
- Response: 4146 `U_C_TREE_FRIEND`.
- Tree info for visited farms otherwise travels inside `FarmInfoRspMsg.tree_info` (4386, `FM:231-243`).

## 4. Server messages (server to client)

`TreeInfoMsg` (inside 4146, 147, 146, 106, 4189 and `FarmInfoRspMsg.tree_info`):

| Field | Tag | Type | Meaning |
|---|---|---|---|
| `userId` | #1 | INT32 | tree owner |
| `nickName` | #2 | STRING | owner name |
| `waterCount` | #3 | INT32 | energy accumulated |
| `fruitCount` | #4 | INT32 | fruits ready |
| `isFirstFruit` | #5 | BOOL | first fruit flag (stored) |
| `nextPickTime` | #6 | STRING | next pick time "YYYY-MM-DD hh:mm:ss" |
| `property1` | #7 | INT32 | stored, unused (assumption: light crystal per fruit) |
| `property2` | #8 | INT32 | stored, unused (assumption: spirit per fruit) |
| `lastWaterTime` | #9 | STRING | last energize time |
| `left_time` | #10 | INT32 | owner only: seconds until the owner may energize again |
| `left_pickTime` | #11 | INT32 | owner only: seconds until the next pick |

### S1. 4146 (0x1032) `U_C_TREE_FRIEND`, `FriendTreeRsp`
Receiver `WM.__getTreeInfoHandler` (`WM:104-152`): `treeInfo (#1, TreeInfoMsg, repeated)`; for the own tree dispatches `CREATE_TREE`.

### S2. 147 (0x0093) `U_C_TREEINFO_UPDATE`, `TreeUpdateRsp`
Receiver `WM.__treeInfoUpdateHandler` (`WM:169-204`): `tree (#1, TreeInfoMsg, repeated)`. `TreeUpdateRsp` also has `harvestMsg (#2, STRING, repeated)`, `pickMsg (#3, STRING, repeated)`, `isUpGrade (#4, BOOL)`.

### S3. 146 (0x0092) `U_C_HARVEST_MSG`, `TreeUpdateRsp`
Receiver `WVC.__message` (`WVC:493-536`): plays the water animation and shows each `harvestMsg` line; unless `isUpGrade`, adds `expByOper(23)` farm gp locally.

### S4. 106 (0x006a) `U_C_TREE_PICK`, `TreeUpdateRsp`
Receiver `WVC.__pickResultHandler` (`WVC:598-660`): `pickMsg` lines (two reward lines animated).

### S5. 4189 (0x105d) `U_C_PICK_HARVEST_MSG`, `TreeUpdateRsp`
Receiver `WVC.__pickHavestHandler` (`WVC:569-596`): `harvestMsg` lines, adds `expByOper(24)` gp locally.

### S6. 4158 (0x103e) `U_C_SEND_WATER_RESULT`, `FarmLogRsp`
Receiver `WM.__waterStateHandler` (`WM:206-222`): when `player_id` is the viewer, clears `canGivePower` for `oper_user_id` (the tree owner was energized) and dispatches `UPDATA_WATER_STATE`.

### S7. 145 (0x0091) `U_C_WATERLOG_SEND`, `FarmLogRsp`
Receiver `WM.__logUpdateHandler` (`WM:154-167`), appended to `WM.logList`. Also sent in bulk at login inside 4157 `farmLog` (`LIDA:554`).

| Field | Tag | Type | Meaning |
|---|---|---|---|
| `player_id` | #1 | INT32 | log owner |
| `oper_user_id` | #2 | INT32 | actor |
| `oper_nick_name` | #3 | STRING | actor name |
| `desc` | #4 | STRING | text |
| `oper_date` | #5 | STRING | "YYYY-MM-DD hh:mm:ss" |
| `oper_count` | #6 | INT32 | amount |
| `isAddFavGp` | #7 | BOOL | friendship points granted |
| `type` | #8 | INT32 | 1 tree log, 2 farm log (assumption from `water.view.WaterLogItem.treelog/farmlog`) |

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Unlock | hero level 11 (tree request), farm at 12 | `WM:96-102` |
| Energy to fruit | UpGrade Types 7 by farm level: grade 1 = 10, +1 per grade, 30 from grade 21 | `WVC:331,412`, `UpGradeTempInfos.xml` |
| Owner cooldown | 10 minutes between owner energizes (`lastWaterTime + 600000 ms`) and server `left_time` | `TI:170-177,207-222` |
| Daily energize | owner 3 per day, each friend once per day per tree (help text); `canGivePower` flag per friend | `farm.view.FarmResourcesView.helpContent`, `WM:206-222` |
| Fruit | a full tree gives fruits; collect when `left_pickTime == 0`; rewards "Cristais de Luz" and "Espíritos", higher with farm level (assumption: base by Types 7 grade) | help text, `buildings.water.view.WaterExpItem.tipData` |
| No water with fruit | energizing is blocked while `fruitCount > 0` | `TI:217-220` |
| Tree art | grade bands 1..9, 10..19, 20+ (`treeResource`) | `TI:224-238` |

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `UpGradeTempInfos.xml` Types 7 | energy per farm level | `Grades`, `Data` |

## 7. Persistent state

```sql
CREATE TABLE farm.trees (
  player_id        BIGINT PRIMARY KEY REFERENCES farm.farms(player_id) ON DELETE CASCADE,
  water_count      INTEGER NOT NULL DEFAULT 0 CHECK (water_count >= 0),
  fruit_count      INTEGER NOT NULL DEFAULT 0 CHECK (fruit_count >= 0),
  is_first_fruit   BOOLEAN NOT NULL DEFAULT true,
  last_water_at    TIMESTAMPTZ,
  next_pick_at     TIMESTAMPTZ,
  owner_waters_today SMALLINT NOT NULL DEFAULT 0,
  counters_day     DATE NOT NULL DEFAULT current_date
);

CREATE TABLE farm.tree_waterings (
  tree_owner_id  BIGINT NOT NULL REFERENCES farm.trees(player_id) ON DELETE CASCADE,
  actor_id       BIGINT NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  day            DATE   NOT NULL,
  watered_at     TIMESTAMPTZ NOT NULL DEFAULT now(),
  PRIMARY KEY (tree_owner_id, actor_id, day)
);
```

Logs in `farm.logs` ([farm-core.md](farm-core.md)).

## 8. Backend implementation notes

| Opcode | Handler |
|---|---|
| 15017 | `farm::yggdrasil::handle_water` |
| 5178 | `farm::yggdrasil::handle_pick` |
| 8219 | `farm::yggdrasil::handle_tree_info` |

- Water validation order: tree owner farm exists -> caller is owner or friend -> no fruit -> energy below the Types 7 cap -> owner: `owner_waters_today < 3` and cooldown passed; friend: no row in `tree_waterings` today -> transaction: `water_count += 1` (if it reaches the cap, convert into fruits and reset energy), insert watering, farm gp to the actor, log -> 146 and 4158 to the actor, 147 to actor and owner, 145 to the owner.
- Pick validation: own tree -> `fruit_count > 0` -> `next_pick_at <= now` -> transaction: grant rewards, `fruit_count = 0` (or decrement, assumption), set `next_pick_at` -> 106, 4189, 147, resource pushes.
- Include `tree_info` in every 4386.

## 9. Open questions and assumptions

- Assumption: pick cooldown and reward amounts (server configuration).
- Assumption: owner limit 3 per day.
- Gap: `WaterLogFrame` is unreachable; logs are still pushed for completeness.

## 10. Implementation checklist

- [ ] Screens (client ready): `WaterView`, `WaterViewContainer`, `WaterExpItem`.
- [ ] Route 15017 energize with all pushes.
- [ ] Route 5178 pick.
- [ ] Route 8219 -> 4146.
- [ ] Messages 146, 147, 106, 4189, 4158, 145.
- [ ] Tables `farm.trees`, `farm.tree_waterings`.
- [ ] Tests: friend energizes twice in a day -> refused; energize with fruit present refused; pick on cooldown refused; full energy produces fruit.
