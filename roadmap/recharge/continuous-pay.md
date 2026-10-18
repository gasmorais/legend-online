# Continuous recharge ("Evento de recarga contínua")

Path aliases:

| Alias | File |
|---|---|
| FUM | `decompiled/core_module/scripts/managers/FunnyManager.as` |
| FM | `decompiled/core_module/scripts/mvc/module/funny/FunnyModel.as` |
| CPF | `decompiled/m11/scripts/continuePayRebate/ContinuePayRebateFrame.as` |
| CPV | `decompiled/m11/scripts/continuePayRebate/view/` (ChestView, ChestItem, ChestIcon, ChestPayItem, RewardView, RewardItem) |
| TBH | `decompiled/core_module/scripts/ui/toptoolbar/TopBtnCheckShowHelper.as` |

## 1. Overview

A recharge activity built on the generic activity engine ("funny", owned by [../seasonal-events/README.md](../seasonal-events/README.md)). Two activity types are used:
- 2501 "chest rows": each activity is one daily threshold (recharge at least N diamonds in a day). Counting the days on which the threshold was met unlocks three chests at day counts D1, D2, D3.
- 2500 "cumulative rewards": one activity whose packages are rewards unlocked by a cumulative condition.

Rewards are claimed one by one with the generic claim 8586.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `continuePayRebate.ContinuePayRebateFrame` (CPF) | "Evento de recarga contínua" (CPF:244) | Header "Hoje já recarregou acumuladamente: {0} diamantes" (CPF:126-131), countdown "Contagem do Evento: {0}" or "Evento expirado" (CPF:156-176), chest view, reward view, pay and help buttons | top toolbar "continuepayrrbate" (`TopToolsBar.as:1335-1336`) visible when hero level > 6, the 2500 activity is in its show window with packages and the first 2501 activity is in its show window (TBH:299-300) | requests user data on open (`FunnyManager.sendGetBag(1)`, CPF:57); refreshes on `REFRESH_ITEM` |
| `ContinuePayRebateChestView` | top numbers = day counts of the three chests (`bagList[i].conditionList[0].bak` of the first row) | Rows of 2501 activities in their show window (`ChestView.as:53-112`) | CPF | |
| `ContinuePayRebateChestItem` | daily threshold and "Completou {0} dia(s)" | One 2501 activity: threshold `bagList[0].conditionList[0].value`, days done `bagList[0].finshCount` (`ChestItem.as:67-78`) | ChestView | three `ContinuePayRebateChestIcon` |
| `ContinuePayRebateChestIcon` | chest | Claim a chest; status 2 shows the taken mark | ChestItem | status 2 "Você já coletou este prêmio", 3 "Você ainda não pode coletar o prêmio" (`ChestIcon.as:51-69`) |
| `ContinuePayRebateRewardItem` | reward card with the number `conditionList[0].value` | Claim a 2500 package; items (`temType` 1) or cosmos stars (`temType` 2) | RewardView | button enabled only for status 1, taken mark for 2 (`RewardItem.as:98-165`) |

Help: "Intruções de ajuda da recarga contínua" (`continuePayRebate.helperFrame.HelpTitle.text`; the body key is a placeholder "1").

## 3. Routes (client to server)

All routes: send 8586 (0x218a) `C_SUMACTIVE_GATE`; message `SumActiveGetPackageMsg` (active): `activeId` (#1, STRING); `packageId` (#2, STRING); `type` (#3, INT32) operation; `count` (#4, INT32) default 1. Sender `FunnyManager.sendGetBag(type, activeId = "", packageId = "", count = 1)` (FUM:969-978).

### K1. Query user data
- UI: CPF constructor (CPF:57).
- Route: 8586 with `type` 1, no ids.
- Expected response: 4476 `U_C_SUMACTIVE_DATA` with every activity's progress.

### K2. Claim a chest (2501 package)
- UI: `ContinuePayRebateChestIcon.__onMouseClick` (`ChestIcon.as:51-69`) when status is neither 2 nor 3.
- Route: 8586 with `type` 2, `activeId` = 2501 activity id, `packageId` = chest package id.
- Expected responses: bag updates, 4476 with the package status 2.

### K3. Claim a cumulative reward (2500 package)
- UI: `ContinuePayRebateRewardItem.__onBtnClick` (`RewardItem.as:88-96`) when status 1.
- Route: 8586 with `type` 2, `activeId` = 2500 activity id, `packageId`.
- Expected responses: bag updates, 4476.

## 4. Server messages (server to client)

### S1. 4475 (0x117b) `U_C_SUM_ACTIVE_TEMP` (activity definitions, paged)
- Message `SumActivesMsg` (active): `actives` (#1, `SumActiveinfoMsg`, repeated); `dataStamp` (#2, INT32) version (a higher value clears the client cache); `curPage` (#3, INT32); `maxPage` (#4, INT32) (the client finalizes after `maxPage` messages and then sends 8586 type 1, FUM:596-640).
- `SumActiveinfoMsg`: `active_id` (#1, STRING); `begin_date` (#2, STRING) and `end_date` (#3, STRING) progress window; `title` (#4, STRING); `detail` (#5, STRING); `condition_detail` (#6, STRING); `getway` (#7, INT32); `packages` (#8, `SumActivePackageMsg`, repeated); `active_type` (#9, INT32) 2500 or 2501 here; `start_time` (#10, STRING) and `stop_time` (#11, STRING) show window; `order` (#12, INT32); `appendParam` (#13, STRING); `isInitiate` (#14, INT32).
- `SumActivePackageMsg`: `packageId` (#1, STRING); `order` (#2, INT32); `items` (#3, `SumActiveItemInfoMsg`, repeated: `template_id` (#1, INT32), `template_type` (#2, INT32) 1 item, 2 cosmos star, `count` (#3, INT32), `isbind` (#4, BOOL), `length` (#5, INT32) strengthen grade, `job` (#6, INT32)); `conditions` (#4, `PackageConditionMsg`, repeated: `condition_id` (#1, INT32), `condition_value` (#2, INT32), `condition_bak` (#3, INT32), `condition_bak2` (#4, INT32), `condition_bak3` (#5, INT32), `condition_bak4` (#6, INT32)).
- Receiver: `FunnyManager.__funnyTemHandler` (FUM:152, 409-641): activities whose `stop_time` passed are dropped; type 2500 kept only while in the show window (FUM:530-538); type 2501 kept only with exactly 3 packages and in the show window (FUM:539-551); 2501 rows sorted by `order` (FUM:637).
- When: login and whenever activities change (owner: seasonal events).

### S2. 4476 (0x117c) `U_C_SUMACTIVE_DATA` (user progress)
- Message `SumActiveDataMsg` (active): `datas` (#1, `ActiveData`, repeated). `ActiveData`: `packdata` (#1, `PackageData`, repeated); `value` (#2, INT32) activity progress; `activeId` (#3, STRING); `is_show` (#4, BOOL); `type` (#5, INT32); `activeCharge` (#6, INT32); `consumeMsg` (#7, repeated, unused here). `PackageData`: `packId` (#1, STRING); `status` (#2, INT32) 1 claimable, 2 claimed, 3 not reached; `countDown` (#3, INT32); `is_show` (#4, BOOL); `param1` (#5, STRING); `finish_value` (#6, INT32) progress of this package; `get_count` (#7, INT32).
- Receiver: `FunnyManager.__funnyUserHandler` (FUM:153-154, 643-788) (also on 4714 `U_C_CONSUME_RES`).
- Values used here: 2501 `ActiveData.value` = diamonds recharged today (header, CPF:126-130); 2501 `PackageData.finish_value` of package 0 = days on which the threshold was met (`finshCount`); package status per chest; 2500 package status.
- When: reply to K1, K2, K3; push after each credited recharge and at 00:00.

## 5. Rules and formulas

- 2501 row: threshold T = `packages[0].conditions[0].condition_value` diamonds per day; required days of chest i = `packages[i].conditions[0].condition_bak`. A day counts when the diamonds recharged on that server day reach T. Chest i becomes claimable (status 1) when days >= its required days; claimed chests are status 2; others 3.
- Day counting happens between `begin_date` and `end_date`; claims allowed until `stop_time` (assumption).
- 2500 packages: unlocked by `conditions[0].condition_value` (displayed number; assumption: total threshold days met across rows, or total diamonds recharged during the event; activity configuration decides by `condition_id`).
- Rewards filtered by `job` (0 = all). Bag full: mail (assumption).

## 6. Templates

None: activities are server data (4475). The generic activity tables belong to [../seasonal-events/README.md](../seasonal-events/README.md).

## 7. Persistent state

Activity definitions and per player package states are stored by the activity engine (proposed `events.activities`, `events.activity_packages`, `events.player_packages` in [../seasonal-events/README.md](../seasonal-events/README.md)). This module adds the daily counter it needs:

```sql
CREATE TABLE recharge.continuous_days (
  player_id    BIGINT  NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  activity_id  TEXT    NOT NULL,
  day          DATE    NOT NULL,
  PRIMARY KEY (player_id, activity_id, day)
);
```

Daily recharge amounts come from `recharge.daily_totals` ([payment.md](payment.md)).

## 8. Backend implementation notes

- `recharge::continuous::on_recharge(tx, player_id, today_total)`: for each active 2501 activity, when `today_total >= threshold` and no row for today, insert `continuous_days`; recompute chest statuses (`count(days) >= required`); recompute 2500 package statuses; after commit push 4476.
- Claims go through the activity engine handler `events::funny::handle_gate` (8586): `type` 1 query, `type` 2 claim; for these activity types it calls `recharge::continuous::claim(tx, player_id, activity_id, package_id)`: require status 1, grant items (stars through [../cosmos/README.md](../cosmos/README.md)), set status 2; reply 4476.
- Midnight: push 4476 so the header resets to 0 for the new day.

## 9. Open questions and assumptions

- Assumption: the meaning of the 2500 condition value (days met vs diamonds).
- Assumption: claims allowed until `stop_time`.
- Open: `activeCharge` is not read for these types.

## 10. Implementation checklist

- [ ] Screen: header today recharge, countdown, chest rows, reward cards
- [ ] Route K1 8586 type 1
- [ ] Route K2 8586 type 2 chest
- [ ] Route K3 8586 type 2 reward
- [ ] Server message S1 4475 with types 2500 and 2501 (2501 with exactly 3 packages)
- [ ] Server message S2 4476 progress and statuses
- [ ] Table `recharge.continuous_days`
- [ ] Rule: a day counts once when the daily threshold is met
- [ ] Rule: chest unlock by day counts `condition_bak`
- [ ] Test: two recharges in one day count one day
- [ ] Test: claim of status 3 refused
