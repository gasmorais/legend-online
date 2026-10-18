# Legacy day guide (leed activity, daily list)

Area: daily-activity, module `legacy-day-guide`. Covers the older activity system built on the `leed` proto package: `managers.DayGuideManager` (leed part, daily counters, day actions), `managers.DayGuideSocketOutManager`, `mvc.module.dayGuide.*` (`DayGuideCatecory`, `LeedInfo`, `DailyList`, `DailyItemInfo`, `DayActionInfo`), the frames `dayguide.newleed.ActiveLeedFrame`, `dayguide.DayGuideFrame`, `dayguide.LimitedSellView`, `dayguide.DailyTabView` family and `dailyactivity.DailyActivityFrame` (m11), and the templates `LeedTemp`, `LeedDrop`, `ActiveTempInfos`.

Conventions: see [README.md](README.md).

## 1. Overview

Before [activity-points.md](activity-points.md), the "Pontos de Atividade" frame was fed by per player leed records (`LeedData`), 5 daily and 3 weekly chests (`leed_daily_config`, `leed_weekly_config`) and a "daily list" of recurring events (`ActiveTempInfos`) with counters from `ClickDatasRspMsg`. In this client build:

- `ActiveLeedFrame` is only returned by `DayGuideController.frameClassName` when the open type is not 1 (`decompiled/core_module/scripts/mvc/controler/DayGuideController.as:57`), and every caller passes open type 1 or opens `newactiveleed` instead. The frame is unreachable.
- `DayGuideFrame` (only hosts `LimitedSellView`) and `DailyActivityFrame` (hosts `DailyTabView`) are never returned by any controller. Unreachable.
- The templates `LeedTemp` and `ActiveTempInfos` are absent from `raw/xml/tempinfos/`, so `DayGuideCatecory.allList` items have no template and `DayGuideManager.dailyList` is empty.

Still live: the login sends 8322 with template 1, the sign in frame sends 8518, and the manager listens to 4152, 4150, 4393, 4412 and 4936 for the whole session. `leadExtractTimes` (lucky draw count, [lucky-draw.md](lucky-draw.md)) travels in 4152. Server parity only needs harmless answers to 8322 and 8518; the rest is documented for completeness and possible revival.

## 2. Screens

| Class | pt-BR title | Purpose | Reachable | Data shown |
|---|---|---|---|---|
| `dayguide.newleed.ActiveLeedFrame` (`decompiled/m11/scripts/dayguide/newleed/ActiveLeedFrame.as:104`), 780 x 538 | "Pontos de Atividade" | 9 category tabs (daily, single, multi, multi PvP, guild, pet and guardian, investiture, third turn, fourth turn with `VersionSwitch.FOUR_TURN`), list of `LeedInfo` with `int(Sort / 100) == tab`, progress bar with 5 daily chests, 3 weekly chests, double buff button "Obter ganhos dobrados" | no | `DayGuideCatecory` |
| `dayguide.newleed.ActiveLeedItem` (`decompiled/m11/scripts/dayguide/newleed/ActiveLeedItem.as:37`) | `Title`, `Desc`, "+`Num` pontos", progress or "Completado"; VIP row "Login VIP" (`templateId -1`) | one leed record, go button (`switchScene(templateId)`) | no | `LeedInfo`, `LeedTempInfo` |
| `dayguide.ActiveProgressView`, `dayguide.ActiveBoxItem` (`decompiled/m11/scripts/dayguide/ActiveBoxItem.as:48`) | "{0} atividades" | daily chest (type 1) or weekly chest (type 2) | no | `leed_daily_config`, `leedProcess` bits |
| `dayguide.DayGuideFrame` (`decompiled/m11/scripts/dayguide/DayGuideFrame.as:36`), `dayguide.LimitedSellView` | "Pontos de Atividade" | progress and chest view, sends 8518 on open | no | |
| `dailyactivity.DailyActivityFrame` (`decompiled/m11/scripts/dailyactivity/DailyActivityFrame.as:35`), `dayguide.DailyTabView`, `DailyItem`, `DailyRightView`, `DailyProjectView`, `ProjectItem`, `UnfinishedProjectView`, `LimitedItemsView` | `dayGuide.view.DailyActivityFrame.title` | daily event list with stars, times and counters | no | `DayGuideManager.dailyList` |

## 3. Routes (client to server)

| # | UI control | Client sender | Route | Body | Reachable |
|---|---|---|---|---|---|
| L1 | Login end | `LoginInitDataAccept.request` `decompiled/core_module/scripts/yishi/lunch/LoginInitDataAccept.as:184` -> `DayGuideSocketOutManager.sendLeedClientUpdate(1)` `decompiled/core_module/scripts/managers/DayGuideSocketOutManager.as:43` | C>S 8322 (0x2082) `C_LEED_CLIENT` | `leed.FinishedReqMsg`: `template_id (#1, INT32)` leed template finished on the client side (1 = daily login) | yes, every login |
| L2 | Sign in frame open | `SignDayFrame` `decompiled/m11/scripts/dayguide/SignDayFrame.as:38`, `DayGuideFrame` `:39` -> `sendDailyCount` `DayGuideSocketOutManager.as:37` | C>S 8518 (0x2146) `C_CLICKDATALIST` | none | yes |
| L3 | Chest click | `ActiveBoxItem.__clickHandler` `decompiled/m11/scripts/dayguide/ActiveBoxItem.as:75` -> `sendGetGoods(site, isWeek)` `DayGuideSocketOutManager.as:22` | C>S 8235 (0x202b) `C_LEED_FINISH` | `leed.LeedFinishedReqMsg`: `site (#1, INT32)` chest 1..5 (daily) or 1..3 (weekly, `index - 2`); `isWeek (#2, BOOL)` | no |
| L4 | Double buff | `ActiveLeedFrame._buyDoubleActiveHandler` `decompiled/m11/scripts/dayguide/newleed/ActiveLeedFrame.as:297`, `ActiveBoxItem.as:112` -> `sendbuyDoubleBuff` `DayGuideSocketOutManager.as:51` | C>S 8236 (0x202c) `C_LEED_BUY_BUFF` | empty `LeedFinishedReqMsg` | no |
| L5 | none | `sendLeedAdd` `DayGuideSocketOutManager.as:31` (no caller) | C>S 8234 (0x202a) `C_LEED_ADD` | none | no |

Client checks on L3 and L4 match [activity-points.md](activity-points.md) A1 and A2 (weekly chest offers the buff when `buffStopDate` is past; buff needs `point >= leed_buy_buff_point`).

## 4. Server messages (server to client)

### S1. 4152 (0x1038) `U_C_LEED_UPDATE`

- `leed.LeedUpdatedRspMsg`: `leed (#1, LeedData, repeated)`; `leedProcess (#2, INT32)` daily chest bits (bit `site` set = claimed, `DayGuideCatecory.hasPick` `decompiled/core_module/scripts/mvc/module/dayGuide/DayGuideCatecory.as:482`); `totalNum (#3, INT32)` daily points; `leadExtractTimes (#4, INT32)` lucky draws used today; `weekLeedProcess (#5, INT32)` weekly chest bits; `weekTotalNum (#6, INT32)` weekly points; `buff_stop_date (#7, STRING)`.
- `leed.LeedData`: `template_id (#1, INT32)` `LeedTemp` id; `user_id (#2, INT32)`; `current_count (#3, INT32)` clamped to `PassCount` by the client; `begin_date (#4, STRING)` "YYYY-MM-DD hh:mm:ss"; `is_complete (#5, BOOL)`.
- Receiver: `DayGuideManager.__onLeedUpdateHandler` `decompiled/core_module/scripts/managers/DayGuideManager.as:368`; also copies `leadExtractTimes` into `PlayerInfo`.
- When: original server, login (`PlayerDataMsg.leed = true`) and on progress. Parity: send once at login with `leadExtractTimes` (the only field a reachable screen reads).

### S2. 4150 (0x1036) `U_C_LEED_RECEIVE`

- `leed.LeedFinishedRspMsg`: `result (#1, BOOL)`; `site (#2, INT32)`; `leedProcess (#3, INT32)` new bits; `isWeek (#4, BOOL)` selects daily or weekly bits.
- Receiver: `DayGuideManager.__onLeedReceiveHandler` `:390`. When: reply to L3.

### S3. 4393 (0x1129) `U_C_DAYACTION`

- `active.DayActiveRspMsg`: `dayActiveRspInfo (#1, DayActiveRspInfo, repeated)`; `DayActiveRspInfo`: `activeId (#1, STRING)`, `title (#2, STRING)`, `description (#3, STRING)`, `contents (#4, STRING)`, `awardContent (#5, STRING)`, `startDate (#6, STRING)`, `endDate (#7, STRING)` both "YYYY-MM-DD hh:mm:ss", `actionTimeContent (#8, STRING)`, `sort (#9, INT32)`.
- Receiver: `DayGuideManager.__dayActivityHandler` `:302` stores `dayActiveList` sorted by `sort`; no screen reads it. Proto package `active` belongs to [seasonal-events](../seasonal-events/README.md). Optional.

### S4. 4412 (0x113c) `U_C_CLICKDATA`

- `leed.ClickDatasRspMsg`: `info (#1, ClickDataRspMsg, repeated)`; `ClickDataRspMsg`: `keys (#1, STRING)`, `keyData (#2, INT32)` count done today, `changeTime (#3, STRING)`.
- Receiver: `DayGuideManager.__dailyCount` `:99`: maps keys to daily list ids: "5001" -> 1, "match" -> 2 (and 10), "5002" -> 3, "4001" and "4002" summed -> 4, "5003" -> 5, "reward" -> 9, "vehicle" -> 12, "minefield" -> 13, "pet" -> 14, "petboss_1" -> 20, "petboss_2" -> 21, "7701" -> 27; sets `currentFinsh` clamped to `MaxCount`; event `DAILY_ITEM_REFRESH`.
- When: reply to L2. Parity: an empty `info` list is enough because `dailyList` is empty without `ActiveTempInfos`.

### S5. 4936 (0x1348) `U_C_LEAD_EXTRACT`

- Also read here (`DayGuideManager.__luckDrawHandler` `:407`); see [lucky-draw.md](lucky-draw.md).

## 5. Rules and formulas

- Daily chest thresholds: `leed_daily_config` "1,100|2,150|3,200|4,250|5,300" (`site,points`; client default identical, `decompiled/core_module/scripts/yishi/datas/ConfigInfoManager.as:810`). Weekly: `leed_weekly_config` "1,800|2,1600|3,2100" (default "1,100|2,150", `:819`).
- Chest state: claimed when bit `site` of the process is set; claimable when points >= threshold (`DayGuideCatecory.canPick` `:442`, `canWeekPick` `:491`).
- VIP level >= 3 adds a virtual completed row "Login VIP" (`templateId -1`) showing "+`vipActivePrivilege`" (`DayGuideCatecory.getShowAllList` `:315`, `ActiveLeedItem.as:118`).
- Daily list counters computed on the client from other features (`DayGuideManager.dailyList` `:212`): id 6 `multiCopyMaxCount - multiCopyCount`, 7 `seminaryCount`, 8 tax order count, 9 bounty quests done (`maxRewardCount - remainRewardCount`), 11 trial tower runs, 15 ring quests done, 16 treasure map count, 17 single pass count, 19 `1 - molongRestNum`, 25 monopoly count, 1600 random boss count. `remainRewardCount` (id 9) is used by `GuideTaskManager` and exit prompts.
- Bounty limit sync: `OfferRewardManager` writes `maxRewardCount` into the daily list (`decompiled/core_module/scripts/managers/OfferRewardManager.as:89`) and increments id 9 on `REWARD_TASK_FINISH` (`DayGuideManager.as:189`).

## 6. Templates

| File | Status | Record and fields |
|---|---|---|
| `LeedTemp` (`TempleteManager.as:1165`) | missing | `LeedTempInfo`: `TemplateId`, `PassCount`, `Num`, `Title`, `Sort` (tab = `Sort / 100`), `Type`, `Desc`, `RewardDesc` |
| `raw/xml/tempinfos/LeedDrop.xml` (33 rows, `TempleteManager.as:1164`) | present, tooltips only | `site` 1..5 daily or 1..3 weekly, `isWeek` 0/1, `itemId`, `count`, `ValidDate` |
| `ActiveTempInfos` (`TempleteManager.as:1159`) | missing | `DailyItemInfo`: `TemplateId`, `Type`, `Levels`, `ActiveTime`, `ActiveName`, `MaxCount`, `Sort`, `Detail`, `DropList`, `ActiveType` (1 world boss, 2 multi PvP, 3 battlefield, 4 vehicle, 5 cross multi; `DailyActiveType`) |
| `ConfigInfos` | present | `leed_daily_config`, `leed_weekly_config`, `leed_buy_buff_point` |

## 7. Persistent state

No table is required for parity. If revived, reuse the counters of [activity-points.md](activity-points.md) section 7; a dedicated store would be:

```sql
CREATE TABLE daily_activity.leed_record (
    player_id      BIGINT     NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
    template_id    integer     NOT NULL,
    current_count  integer     NOT NULL DEFAULT 0,
    is_complete    boolean     NOT NULL DEFAULT false,
    begin_at       timestamptz NOT NULL DEFAULT now(),
    PRIMARY KEY (player_id, template_id)
);
```

## 8. Backend implementation notes

- `daily_activity::legacy_day_guide::handle_client_finish` (8322): accept any `template_id`; for template 1 record the daily login in [activity-points.md](activity-points.md) (`record(player, 1, 1)`). No reply required (the current prototype uses this opcode as the trigger to push bag, fashion, quests and friends, `docs/ui/navigation.md`; keep that behavior until those pushes move to 8224).
- `daily_activity::legacy_day_guide::handle_click_data` (8518): reply 4412 with an empty list (or real counters if `ActiveTempInfos` is ever restored).
- `daily_activity::legacy_day_guide::push_leed` at login: 4152 with an empty `leed` list, zero processes and the current `leadExtractTimes`.
- 8234, 8235, 8236: unreachable; log and ignore.

## 9. Open questions and assumptions

- The original meaning of `ClickDataRspMsg.changeTime` is unknown.
- Whether the original server still sent 4152 data alongside 529 is unknown; only `leadExtractTimes` matters.
- `LeedTemp` and `ActiveTempInfos` contents are lost.

## 10. Implementation checklist

- [ ] 8322 accepted at login (and daily login recorded)
- [ ] 8518 answered with 4412
- [ ] 4152 at login with `leadExtractTimes`
- [ ] Unreachable routes 8234, 8235, 8236 ignored without error
- [ ] Test: login flow does not throw when `dailyList` is empty
