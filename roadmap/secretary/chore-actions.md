# Chore actions

Module `chore-actions` of feature `secretary`. The 9 chore actions run by the assistant queue: the routes each one sends, the expected server behavior and responses. Routes owned by other features are summarized and linked; the secretary owns 9741 (one key gem compose) and 9566 op 11 (one key lab collection).

Path aliases:

| Alias | File |
|---|---|
| LAF | `decompiled/core_module/scripts/mvc/module/secretary/acts/LittleActionFactory.as` |
| OA | `decompiled/core_module/scripts/mvc/module/secretary/acts/OfferAction.as` |
| DA | `decompiled/core_module/scripts/mvc/module/secretary/acts/DixAction.as` |
| SYA | `decompiled/core_module/scripts/mvc/module/secretary/acts/SyAction.as` |
| LYA | `decompiled/core_module/scripts/mvc/module/secretary/acts/LyAction.as` |
| GA | `decompiled/core_module/scripts/mvc/module/secretary/acts/GemAction.as` |
| LVA | `decompiled/core_module/scripts/mvc/module/secretary/acts/LevyAction.as` |
| LBA | `decompiled/core_module/scripts/mvc/module/secretary/acts/LabAction.as` |
| FA | `decompiled/core_module/scripts/mvc/module/secretary/acts/FarmAction.as` |
| AA | `decompiled/core_module/scripts/mvc/module/secretary/acts/AltarAction.as` |
| SM | `decompiled/core_module/scripts/managers/SecretaryManager.as` |
| ORM | `decompiled/core_module/scripts/managers/OfferRewardManager.as` |
| SHM | `decompiled/core_module/scripts/managers/ShopManager.as` |
| MM | `decompiled/core_module/scripts/managers/MopupManager.as` |
| PM | `decompiled/core_module/scripts/yishi/manager/PlayerManager.as` |
| FM | `decompiled/core_module/scripts/farm/FarmManager.as` |
| CSO | `decompiled/core_module/scripts/managers/ConsortiaSocketOutManager.as` |

## 1. Overview

`LAF.creatAction` (`LAF:13-46`) maps chore type to an action class. Each action exposes `exc()` (called every frame until `isFinish`) and `dispose()`. Single shot actions send one or two requests and finish immediately; maze actions are state machines that wait for the shop result and poll the sweep.

## 2. Screens

None of their own; results appear in `SecretaryAwardFrame` ([assistant-panel.md](assistant-panel.md)).

## 3. Routes (client to server)

### C1. Bounty one key (type 1, `OfferAction`)
- Client check: available = `point` (+ `giftToken` when `moneyState`) >= `Reward_OneKey` (68), else recharge alert and finish (`OA:24-39`).
- Sender `ORM.sendAllFinishRequest(moneyState)` (`ORM:259-269`): C>S 9583 (0x256f) `C_REWARD_ONEKEY`, `player.PayTypeMsg`: `pay_type (#1, INT32)` 0 = bound diamonds first, 1 = diamonds only; `property1 (#2)`, `property2 (#3)`, `type (#4)` unset.
- Server ([quests](../quests/README.md), offer reward): complete every remaining bounty of the day, grant their rewards, debit 68 -> push quest list update, 3 (diamonds), 115 items, 592 `type` 1 with the total items.

### C2..C4. Maze sweeps (types 2, 3, 4: `DixAction`, `SyAction`, `LyAction`)

| Type | Maze | Campaign | Key item | Keys bought | Tower reset index | Source |
|---|---|---|---|---|---|---|
| 2 | "Labirinto Subterrâneo" | 8001 | 208008 "Chave do Labirinto" | 1 | 0 | `DA:81-90,111-141` |
| 3 | "Labirinto do Abismo" | 8101 | 208008 | 3 | 1 | `SYA` (same code, diff only in ids) |
| 4 | "Labirinto do Purgatório" | 8401 | 208037 "Chave do Purgatório" | 3 | 2 | `LYA` |

Sequence (`DA:57-177`):
1. If the chore cost shows missing keys (`moneyNum > 0`):
   - C>S 8299 (0x206b) `C_TOWER_RESET`, `TowerInfoReqMsg`: `index (#1, INT32)` = type - 2 (`DA:49-55`).
   - C>S 8970 (0x230a) `C_SHOPCAR_BUY`, `ShopCarListMsg` (`SHM:1205-1220`): `discountTempId (#3)` 0, `receiveUserId (#2)` self, `carItemInfo (#4, repeated)` one `CarItemInfoMsg { shopId (#1) = shop row of the key, counts (#2) = 1 or 3, payType (#3) = 2 when bound diamonds first else 1, isDiscountShop (#4) = false }`.
   - Wait for S>C 4783 (0x12af) `U_C_SHOPCAR_RESULT` (`ShopCarListMsg.result (#1)` 1 = success, `isMail (#5)` true when the items were mailed). Failure or mailed -> finish.
2. Start the sweep: C>S 8528 (0x2150) `C_CAMPAIGN_SWEEP`, `CampaignSweepReq`: `sweep_type (#1)` 2 (maze), `op_type (#2)` 1 (start), `campaign_id (#3)` 8001 / 8101 / 8401, `count (#4)` 0, `e_index (#5)` = `maxIndex` (sweep up to the best floor), `enter_type (#6)` 2 (assumption: key run with double gains), `open_silver_box (#7)` false, `open_secret_box (#8)` false, `pay_type (#9)` 2.
3. Every `Tower_Sweep_Time` (6) seconds send 8528 `sweep_type 2, op_type 3` (progress poll) until the mopup model reports `mopupEnd` for this campaign, then finish (`DA:153-177`).
4. S>C 4425 (0x1149) `U_C_CAMPAIGN_SWEEP`, `CampaignSweepRsp`: `status (#2)` other than 1 finishes the action (`DA:92-109`); status 1 with `sweep_type 2` triggers the result block (`MM:127-138`). Result items arrive in `result (#1, SweepResult, repeated)`.
5. On dispose with the action started: 8528 `sweep_type 2, op_type 4` (stop) (`DA:184-197`).
- Server side owned by [mopup](../mopup/README.md) and [mazes](../mazes/README.md). Gold cost: `Tower_Sweep_Gold` (1000) per floor.
- Note: when keys are already owned the client skips the 8299 reset (`DA:131-140`).

### C5. One key gem compose (type 5, `GemAction`), owned here
- Sender `GA.exc` (`GA:15-22`): C>S 9741 (0x260d) `C_GEM_ONE_KEY_COMPOSE`, `player.PlayerOpMsg`: `op (#1, INT32)` = 1; every other field (`type #2`, `payType #3`, `count #4`, `id #5`, `index #6`, `userId #7`, `templateId #8`, `campaignId #9`, `nodeId #10`, `chapterId #11`, `uuid #12`, `value1 #13`, `value2 #14`, `param1 #15`, `param2 #16`, `flag1 #17`, `flag2 #18`, `pos #19`, `ids #20`) unset.
- Server: repeatedly apply the gem synthesis recipes of [smith gems](../smith/gems.md) to every gem in bag 1 below level 6 while materials and gold allow (description: "Sintetizar todos os Gemas da Mochila para Nv. 6"), debit the gold returned by the op 0 query -> push 115 (bag changes), gold resource update, 593 with the new remaining gold (0 when nothing left), 592 `type` 5 with the produced gems.
- Op 0 (query) is in [assistant-panel.md](assistant-panel.md) P3.

### C6. Tax collection (type 6, `LevyAction`)
- Sender `PM.sendLevy(2)` (`PM:1708-1714`, `LVA:13-17`): C>S 8327 (0x2087) `C_GOLD_IMPOSE`, `PlayerOpMsg.op (#1)` = 2.
- Server: [castle levy](../castle/levy.md) R2 (collect every remaining levy) -> 4242, 109, then 592 `type` 6 with the gold (-100 or the gold item id used by the client icon, assumption: -100).

### C7. One key lab collection (type 7, `LabAction`), owned here
- Sender `LBA.exc` (`LBA:15-22`, same as `SM.gotoLab` `SM:96-102`): C>S 9566 (0x255e) `C_PERKIN_LAB_CLIENT`, body `player.PlayerOpMsg` with `op (#1, INT32)` = 11 (wire compatible with `PerkinLabClientMsg.op`).
- Visible only for job advanced players with a ready lab and raids left.
- Server ([laboratory](../laboratory/README.md)): collect every finished research of the player's own lab (assumption: op 11 = collect all; the laboratory module documents ops 0..10 only) -> the lab state pushes of the laboratory feature, 115/currency updates, 592 `type` 7.

### C8. Farm and pasture auto harvest (type 8, `FarmAction`)
- Sender `FM.sendReqAutoPick(25, userId)` and `FM.sendReqAutoPick(26, userId)` (`FA:21-26`, `FM:626-633`): two C>S 15044 (0x3ac4) `CH_FARM_OPER_CHECK`, `FarmOperReqMsg`: `op_type (#3, INT32)` 25 then 26, `friend_id (#2, INT32)` = own user id.
- Server: [farm](../farm/README.md) auto harvest of every ripe field (25) and every ripe animal (26) -> 4387 per changed land, 115, 592 `type` 8.

### C9. Altar blessing (type 9, `AltarAction`)
- Client checks (`AA:25-49,70-80`): blessings used `>= Property2` -> "Oração insuficiente"; merit `Altar_Reputation_Cost[god - 1]` > guild reputation -> "Mérito Individual insuficiente, você pode homenagear outros deuses ou obter mais na Escola de missões"; contribution per blessing `Property1` > player `consortiaOffer` -> confirm "Contribuição da Guilda insuficiente, acrescentar contribuição?" (opens the contribute frame); otherwise count = `min(Property2 - used, floor(consortiaOffer / Property1))`.
- Sender `CSO.consortiaAltarBless(count)` (`CSO:132-139`): C>S 5145 (0x1419) `U_C_CONSORTIA_FRESHALTAR`, `simple.PropertyMsg`: `param1 (#1, INT32)` = count, `param2 (#2, INT32)` = selected god 1..3 (`AI:73-77`).
- Server: [guild buildings](../guild/buildings.md) altar blessing, repeated `count` times -> its pushes (4141 and the prayer reward), 592 `type` 9.

## 4. Server messages (server to client)

| Opcode | Hex | Name | Message | Used by | Owner |
|---|---|---|---|---|---|
| 592 | 0x0250 | `U_C_ASSISTANT_ITEMS` | `player.AssistantMsg` | all chores | secretary ([assistant-panel.md](assistant-panel.md) S4) |
| 593 | 0x0251 | `U_C_GEM_ONE_KEY_COMPOSE_NEED_GOLD` | `NeedGoldMsg { gold (#1, INT32) }` | C5 | secretary |
| 4783 | 0x12af | `U_C_SHOPCAR_RESULT` | `ShopCarListMsg { result (#1, INT32), receiveUserId (#2), discountTempId (#3), carItemInfo (#4, repeated), isMail (#5, BOOL) }` | C2..C4 (`DA:57-79`) | [shops](../shops/README.md) |
| 4425 | 0x1149 | `U_C_CAMPAIGN_SWEEP` | `CampaignSweepRsp { result (#1, SweepResult, repeated), status (#2, INT32), sweep_type (#3, INT32), total_gp (#4, INT32), dropItems (#5, ItemTemplate, repeated), campaign_id (#6, INT32) }` | C2..C4 (`DA:92-109`) | [mopup](../mopup/README.md) |

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Bounty one key price | `Reward_OneKey` = 68 diamonds | `ConfigInfos.xml`, `SD:112-116` |
| Maze keys | type 2: 1 key 208008; type 3: 3 keys 208008; type 4: 3 keys 208037 | `DA:85`, `SYA:85`, `LYA:85` |
| Maze sweep | gold 1000 per floor, 6 s per floor | `Tower_Sweep_Gold`, `Tower_Sweep_Time` |
| Gem compose | up to gem level 6, gold from 593 | `secretary.LittleSecretaryFrame5` |
| Levy | all remaining levies of the day | [castle levy](../castle/levy.md) |
| Farm | ops 25 (fields) and 26 (animals) for the own farm | `FA:23-24` |
| Altar | count = `min(Property2 - used, floor(offer / Property1))`; `Property1` = 20, `Property2` = 3 * altar level | `AA:77`, `ConsortiaLevelInfos.xml` Types 3 |

## 6. Templates

| File | Fields used |
|---|---|
| `ConfigInfos.xml` | `Reward_OneKey`, `Tower_Sweep_Gold`, `Tower_Sweep_Time`, `Altar_Reputation_Cost` |
| `ShopTempInfos.xml` | key shop rows for 208008 and 208037 (`Id`, `price`) |
| `ConsortiaLevelInfos.xml` Types 3 | altar `Property1`, `Property2` |
| gem recipes | see [smith gems](../smith/gems.md) |

## 7. Persistent state

None of its own (optional audit `secretary.chore_runs` in [assistant-panel.md](assistant-panel.md)). Owned routes write to the owner tables: gem compose to the items table, lab collection to the laboratory tables.

## 8. Backend implementation notes

| Opcode | Handler |
|---|---|
| 9741 op 1 | `secretary::chore_actions::handle_gem_one_key_compose` |
| 9566 op 11 | `secretary::chore_actions::handle_lab_collect_all` (calls the laboratory service) |
| 9583 | `quests::offer_reward::handle_one_key` (owner) + `secretary::emit_summary` |
| 8327 op 2 | `castle::levy::handle_collect` (owner) + `secretary::emit_summary` |
| 15044 op 25, 26 | `farm::farmland::handle_auto_harvest`, `farm::pasture::handle_auto_harvest` (owner) + `secretary::emit_summary` |
| 5145 | `guild::buildings::handle_altar_bless` (owner) + `secretary::emit_summary` |
| 8299, 8970, 8528 | owners (mazes, shops, mopup) |

- Gem compose validation order: hero level >= 15 -> compute the plan (same as op 0) -> gold >= plan cost -> one transaction: consume lower gems, create higher gems, debit gold -> push 115, gold update, 593, 592.
- Lab collect validation: `vocationGrades > 0` -> at least one finished research -> transaction via laboratory service -> pushes, 592.
- Each owner handler stays authoritative; the secretary adds no extra validation beyond its own routes.

## 9. Open questions and assumptions

- Assumption: 9566 op 11 = collect every finished lab research (not documented in [laboratory](../laboratory/README.md)).
- Assumption: 8528 `enter_type = 2` means a key run (double gains) and `op_type` 3 / 4 are progress poll and stop.
- Assumption: levy and farm 592 items use negative currency ids (-100 gold).
- Observation: the maze actions buy a fixed number of keys (1 or 3) even when the cost line asked for fewer (`DA:85,126-130`).

## 10. Implementation checklist

- [ ] Route 9741 op 1 gem one key compose (owned).
- [ ] Route 9566 op 11 lab collect all (owned).
- [ ] 592 emission in owners: 9583, 8327 op 2, 15044 op 25/26, 5145, 9741, 9566 op 11.
- [ ] Coordination with owners: 9583 (quests), 8299 / 8528 (mazes, mopup), 8970 / 4783 (shops), 8327 (castle), 15044 (farm), 5145 (guild).
- [ ] Tests: gem compose with insufficient gold refused and 593 resent; lab collect for a non advanced job refused; full "execute all" run on a level 20 player sends 9583, 8327, 15044 x2 in order and receives one 592 per chore.
