# Generic activity framework (event windows, sum-active engine, cccactive gateway, proto ownership)

Feature `seasonal-events`, module `active-framework`. Shared infrastructure used by this feature's modules and by many other features: the event window pushes (4590 top tool buttons, per event open-state pushes, server switches), the **sum-active engine** ("精彩活动", 8586 / 4475 / 4476 / 4714, proto package `active`), the **cccactive gateway** (9645 with header `extend1`), and the ownership index of the proto packages assigned to this feature (`active`, `active.anniversary`, `cccactive`, `universalActive`, `sumpassion`, `giftparty`).

Conventions: see [README.md](README.md). `FM` = `CM/managers/FunnyManager.as`, `FMo` = `CM/mvc/module/funny/FunnyModel.as`.

---

## 1. Overview

| Piece | What it does | Users |
|---|---|---|
| Event windows | Tell the client which time limited events are open and when | every module of this feature and many others |
| Sum-active engine | Server configured activities with packages (reward tiers), conditions and per player progress; one query, one claim route | [funny.md](funny.md), [../medals/hall-of-fame.md](../medals/hall-of-fame.md), [../cross-server/consumption-ranking.md](../cross-server/consumption-ranking.md), [../cross-server/recharge-ranking.md](../cross-server/recharge-ranking.md), [../daily-activity/login-activity.md](../daily-activity/login-activity.md), [../recharge/continuous-pay.md](../recharge/continuous-pay.md), [../auction/system-auction.md](../auction/system-auction.md), [public-egg.md](public-egg.md) (type 201), [new-year.md](new-year.md) (type 49) |
| cccactive gateway | One request opcode (9645) for many small cross-server events, selected by the packet header field `extend1` | [golden-dionysia.md](golden-dionysia.md), [golden-sheep.md](golden-sheep.md) and 12 events of other features (section 3.2) |
| Proto ownership | Which feature implements each message of the six packages | section 9 |

---

## 2. Screens

No screen of its own. The tool bar visibility helper `CM/ui/toptoolbar/TopBtnCheckShowHelper.as` and the tool bar `CM/ui/toptoolbar/TopToolsBar.as` consume the window state; each module lists its button.

---

## 3. Routes (client to server)

### 3.1 Sum-active gate: 8586 (0x218a) `C_SUMACTIVE_GATE`

Body `active.SumActiveGetPackageMsg`:

| Field | Tag | Type | Meaning |
|---|---|---|---|
| `activeId` | #1 | STRING | `SumActiveinfoMsg.active_id`; "" for queries |
| `packageId` | #2 | STRING | `SumActivePackageMsg.packageId`; "" for queries |
| `type` | #3 | INT32 | 1 query all user data; 2 claim a package; 3 query the "Loucura do Povo" ranking (type 51); 4 claim a "Loucura do Povo" tier |
| `count` | #4 | INT32 | Claim count (multi-claim activities, `getWay == 2`), else 1 |

Senders: `FM.sendGetBag(type, activeId = "", packageId = "", count = 1)` (`FM:969-978`), `FM.sedGetTiroBag(type, packageId, count = 1)` (`FM:980-989`, `activeId` = selected open server activity), `ExchargeRankManager.sendGetBag` and `sendInitBagData(type)` (`CM/managers/ExchargeRankManager.as:349-367`, cross-server ranks). Call sites are listed in [funny.md](funny.md) section 3.1.

| type | Validation (server) | Response |
|---|---|---|
| 1 | none | 4476 with one `ActiveData` per activity visible to the player |
| 2 | activity exists and `begin_date <= now < end_date`; package belongs to it; package state claimable; `count` within the allowed maximum; bag space | 4476 with that activity (package `status = 2` or `get_count` decremented); item and currency pushes |
| 3 | an activity of type 51 exists | 4476 for type 51 with `consumeMsg` |
| 4 | as type 2 for type 51 tiers | 4476 |

### 3.2 cccactive gateway: 9645 (0x25ad) `C_CCCACTIVE_CLIENTOP`

`new PackageOut(9645, 0, sub)`: the third constructor argument is the packet header field `extend1` (`CM/yishi/comm/PackageOut.as:16-32`; the server reads it as `Packet.extend1`, `server/src/packet.rs:49`). The body type depends on `extend1`. Dispatch table (all senders found in the client):

| extend1 | Event | Sender | Body | Responses | Spec |
|---|---|---|---|---|---|
| 23 | Pandora | `PandoraManager` | `cccactive.PandoraLotteryMsg` | 429, 430 | [../inventory/pandora.md](../inventory/pandora.md) |
| 24 | Charge roulette | `ChargeLotteryManager` | `cccactive.ChargePointLotteryMsg` | 432, 433 | [../lotteries/charge-roulette.md](../lotteries/charge-roulette.md) |
| 25 | Golden Dionysia | `GoldenDionysiaManager` | `cccactive.GoldCrazyMsg` | 440, 441, 443 | [golden-dionysia.md](golden-dionysia.md) |
| 27 | Pumping joy (gashapon) | `PumpingJoyManager` | `cccactive.PumpingMsg` | 4848, 4850 | [../lotteries/gashapon.md](../lotteries/gashapon.md) |
| 28 | Whole rebate | `WholeRebateManager` | `cccactive.MoneyReturnMsg` | 4865, 4866 | [../recharge/whole-rebate.md](../recharge/whole-rebate.md) |
| 29 | Month card | `MonthCardManager` | `cccactive.MonthCardMsg` | 175 | [../vip/month-card.md](../vip/month-card.md) |
| 30 | Foison horn | `FoisonHornManager` | `cccactive.FoisonHornMsg` | 4877 | [../lotteries/foison-horn.md](../lotteries/foison-horn.md) |
| 31 | Golden sheep | `GoldenSheepManager` | `cccactive.GoldenSheepMsg` | 4881 | [golden-sheep.md](golden-sheep.md) |
| 34 | Lucky lottery (joy grand prize) | `LuckyLotteryManager` | `cccactive.LuckyLotteryOpMsg` | 462, 4892, 4893 | [../lotteries/joy-grand-prize.md](../lotteries/joy-grand-prize.md) |
| 35 | Hephaestus ore | `StokesOreManager` | `active.OreActiveClientOpMsg` | 187, 188, 189, 190 | [../cross-server/hephaestus-ore.md](../cross-server/hephaestus-ore.md) |
| 36 | Wish pool | `WishPoolManager` | `active.WishPoolReqMsg` | 196, 197 (+ 4590 id 2058) | [../lotteries/wish-pool.md](../lotteries/wish-pool.md) |
| 38 | Super sign-in card | `SuperSigninCardManager` | `active.SuperSigninCardReqMsg` | 513, 514 (+ 4590 id 2059) | [../daily-activity/super-sign-in-card.md](../daily-activity/super-sign-in-card.md) |
| 40 | Platinum pot | `PlatinumManager` | `cccactive.PlatinaCanOpMsg` | 213, 214, 215 | [../laboratory/platinum-pot.md](../laboratory/platinum-pot.md) |
| 41 | Customized VIP | `CustomizedVipManager` | `cccactive.CustomizedVipMsg` | 4277 (+ 4590 id 2064) | [../vip/customized-vip.md](../vip/customized-vip.md) |

Unknown `extend1` values must be answered with nothing (log and drop).

### 3.3 Activity status query: 5049 (0x13b9) `C_ACTIVE_QUERY`

`active.QueryActiveMsg` with the listed GM activities; response 166. Specified in [funny.md](funny.md) section 3.2.

---

## 4. Server messages (server to client)

### 4.1 Sum-active engine

| Opcode | Name | Message | Receiver | When | Client reaction |
|---|---|---|---|---|---|
| 4475 (0x117b) | U_C_SUM_ACTIVE_TEMP | `active.SumActivesMsg` | `FM.__funnyTemHandler` (`FM:152, 409-641`), also `ExchargeRankManager.__exchargeRankTempHandler` (`ExchargeRankManager.as:85`) | Login (all pages), and again whenever an activity is added, changed or removed | `dataStamp > version` clears the model and resets the page counter (`FM:427-432`); each page increments the counter; activities whose `stop_time` is past are dropped (`:445`); special routing by type (see below); after `count >= maxPage` sorts lists, fires `REFRESH_TEMP`, sends 8586 type 3 if a type 51 activity exists and always 8586 type 1 (`FM:596-640`) |
| 4476 (0x117c) | U_C_SUMACTIVE_DATA | `active.SumActiveDataMsg` | `FM.__funnyUserHandler` (`FM:153, 643-788`), `ExchargeRankManager.__exchargeRankUserHandler` (`:86`) | Response to 8586 (all types); push when progress makes a package claimable | Matches `ActiveData` by `(type, activeId)` (`FMo.findFunnyDataByTypeAndId`); updates progress and package states; glow and refresh events (`FM:686-787`); `InfoTipsManager.dealData(23)` |
| 4714 (0x126a) | U_C_CONSUME_RES | `active.SumActiveDataMsg` | same handler (`FM:154`) | Push after a diamond spend that changes consumption activities *(assumption)* | same as 4476 |

`SumActivesMsg`: `actives` (#1, SumActiveinfoMsg, repeated); `dataStamp` (#2, INT32) configuration version; `curPage` (#3, INT32) not read; `maxPage` (#4, INT32) total pages.

`SumActiveinfoMsg`:

| Field | Tag | Type | Meaning |
|---|---|---|---|
| `active_id` | #1 | STRING | Activity id (unique) |
| `begin_date` | #2 | STRING "YYYY-MM-DD hh:mm:ss" | Claim window start (`startTime`) |
| `end_date` | #3 | STRING | Claim window end (`endTime`); claims refused after it ("Evento expirado") |
| `title` | #4 | STRING | Left list title |
| `detail` | #5 | STRING | Description |
| `condition_detail` | #6 | STRING | Condition description |
| `getway` | #7 | INT32 | 2 = multi-claim with a count (`FunnyHelper.isMutConditionType`); other values single claim |
| `packages` | #8 | SumActivePackageMsg, repeated | Reward tiers |
| `active_type` | #9 | INT32 | Activity type (catalogue in [funny.md](funny.md) section 5) |
| `start_time` | #10 | STRING | Show window start (`showStart`) |
| `stop_time` | #11 | STRING | Show window end (`showEnd`); past activities are dropped on receipt |
| `order` | #12 | INT32 | Sort order (ascending) |
| `appendParam` | #13 | STRING | Extra configuration, copied only for types 49 (rebate table "min@max@discount@maxDiamond$..."), 51 (minimum spend), 186 (external link), 197 (`FM:463-466`) |
| `isInitiate` | #14 | INT32 | > 0 marks open server ("tiro") activities for the tiro types |

`SumActivePackageMsg`: `packageId` (#1, STRING); `order` (#2, INT32); `items` (#3, SumActiveItemInfoMsg, repeated); `conditions` (#4, PackageConditionMsg, repeated).

`SumActiveItemInfoMsg`: `template_id` (#1, INT32) item or virtual currency id; `template_type` (#2, INT32) 1 = item shown in the bag list; `count` (#3, INT32); `isbind` (#4, BOOL); `length` (#5, INT32) strengthen grade; `job` (#6, INT32) job filter (0 all).

`PackageConditionMsg`: `condition_id` (#1, INT32) condition type ([funny.md](funny.md) condition catalogue); `condition_value` (#2, INT32) target `{0}`; `condition_bak` (#3, INT32) parameter `{1}` (level, item id, rank...); `condition_bak2` (#4), `condition_bak3` (#5), `condition_bak4` (#6) INT32 extra parameters (type 146 uses them as featured item ids, type 197 as rank slots).

`SumActiveDataMsg`: `datas` (#1, ActiveData, repeated).

`ActiveData`: `packdata` (#1, PackageData, repeated); `value` (#2, INT32) progress (`finishNum`); `activeId` (#3, STRING); `is_show` (#4, BOOL) not read; `type` (#5, INT32) activity type (match key); `activeCharge` (#6, INT32) secondary counter (`canGet`, shown by consumption types); `consumeMsg` (#7, ConsumeInfoMsg, repeated) type 51 ranking.

`PackageData`: `packId` (#1, STRING); `status` (#2, INT32) 1 claimable, 2 claimed, 3 not reached; `countDown` (#3, INT32) seconds before the package unlocks (online chests); `is_show` (#4, BOOL) visibility (regression); `param1` (#5, STRING) free parameter; `finish_value` (#6, INT32) times completed (`finshCount`); `get_count` (#7, INT32) times claimable now (`getCount`, multi-claim maximum).

`ConsumeInfoMsg`: `user_id` (#1, INT32); `order` (#2, INT32); `point` (#3, INT32) diamonds spent today; `nick_name` (#4, STRING); `is_vip` (#5, BOOL).

Client routing of activities on receipt (`FM:443-595`): types in `FMo.isOtherType` (14, 15, 51, 70, 73, 145, 146, 197) go to `otherList[type]`; tiro types with `isInitiate > 0` go to `tiroFunnyList`; 2500 and 2501 (inside their show window, 2501 only with exactly 3 packages) go to the continuous rebate lists; everything else goes to `data` (type 4 also sets `regression`). Type 62 triggers 8843; type 15 with a future `start_time` sets the "need" countdown; type 145 sets the gods treasure window (`begin_date + 120 s` .. `end_date`).

### 4.2 Event window pushes

| Mechanism | Opcode / message | Payload | Users |
|---|---|---|---|
| Top tool button window | 4590 (0x11ee) `U_C_TOP_TOOL_BTN`, `simple.PropertyMsg` | `param1` (#1, INT32) button id; `param4` (#4, STRING) open time; `param5` (#5, STRING) stop time; `param7` (#7, BOOL) open. Other params unused | 2058 wish pool, 2059 super sign-in card, 2061 anniversary 2023 ([year-2023.md](year-2023.md)), 2064 customized VIP, 2065 dark maze, 4020 Easter game hall, 4022 new first recharge, 4023 questionnaire, 4024 memory cards, 4025 Carnival ([carnival.md](carnival.md)), 4029 secret war, 4030 Christmas ([christmas.md](christmas.md)). Every listener receives every 4590 and filters by `param1`; layout also in [../daily-activity/super-sign-in-card.md](../daily-activity/super-sign-in-card.md) |
| Dedicated open-state push | `simple.PropertyMsg`, `param7` = open (some also use `param1`) | 401 rave party (`party.PartyOpMsg.state` instead), 414 crowdfunding, 416 public egg (`param1` 0 standalone, 1 combined), 418 summer gifts (same), 426 summer campaign, 435 culture, 443 Golden Dionysia | modules of this feature |
| Server switches | 4422 `U_C_SWITCH`, `switches.SwitchInfoListMsg` | switch 2005 New Year login (`isOpen`, `beginDate`, `endDate`), 2007 birthday | [../account/switches.md](../account/switches.md), [new-year.md](new-year.md), [birthday.md](birthday.md) |
| Config window only | `ConfigInfos.xml` keys (`christmas_time`, `CarnivalStartDate/StopDate`, `year_time`, `seven_year_*`) | display only; the server must still push the window | |

---

## 5. Rules and formulas

Sum-active engine:
- Paging: send all activities in pages of a fixed size *(assumption: 20 per page)* with the same `dataStamp`; the client only resets on a strictly higher `dataStamp`, and counts pages, so a full resend must use a new `dataStamp` and exactly `maxPage` pages. After the last page the client asks 8586 type 1 itself.
- Windows: show `start_time..stop_time` (listed, button visible), claim `begin_date..end_date`.
- Progress: each activity type has one counter per player (`value`), optionally a second (`activeCharge`); package status is derived: 2 if claimed (or `get_count == 0` for repeatable packages after the last claim), 1 if the conditions hold, else 3. For repeatable packages (`getway == 2`), `finish_value` = times completed and `get_count` = completions not yet claimed.
- Counters are fed by gameplay hooks keyed by condition id (catalogue in [funny.md](funny.md)): for example 9 diamonds consumed, 18 mount training count, 21 alchemy count ([../alchemy/README.md](../alchemy/README.md)), 36 power rank. Daily types (2, 13, 14, 100, 101, 118, 119...) reset at 00:00 *(assumption: per type flag in the configuration)*.
- Ranking types (34..38, 66, 196, 197) evaluate the rank at `begin_date`/`end_date` boundaries *(assumption)*.
- Claims are atomic: check state, grant items, mark claimed, then push 4476.

cccactive gateway: route by `extend1`, never by body content; each sub-event validates its own window.

---

## 6. Templates

None for the engine (all configuration is server data). `TopToolBtnInfos.xml` maps tool bar keys to template ids used by 4590 (`param1`).

---

## 7. Persistent state (PostgreSQL, schema `seasonal_events`)

```sql
CREATE TABLE seasonal_events.event_windows (
  window_id     serial PRIMARY KEY,
  event_key     text        NOT NULL,          -- 'christmas', 'carnival', 'year2023', ...
  top_tool_id   integer,                       -- 4590 param1 (4030, 4025, 2061...) or NULL
  open_state_opcode integer,                   -- dedicated push (401, 414, 416, 418, 426, 435, 443) or NULL
  starts_at     timestamptz NOT NULL,
  ends_at       timestamptz NOT NULL,
  config        jsonb       NOT NULL DEFAULT '{}'::jsonb,
  CHECK (ends_at > starts_at)
);
CREATE INDEX event_windows_key ON seasonal_events.event_windows (event_key, starts_at);

CREATE TABLE seasonal_events.sum_activities (
  active_id        text PRIMARY KEY,
  active_type      integer     NOT NULL,
  title            text        NOT NULL,
  detail           text        NOT NULL DEFAULT '',
  condition_detail text        NOT NULL DEFAULT '',
  getway           integer     NOT NULL DEFAULT 1,
  begin_date       timestamptz NOT NULL,
  end_date         timestamptz NOT NULL,
  start_time       timestamptz NOT NULL,
  stop_time        timestamptz NOT NULL,
  sort_order       integer     NOT NULL DEFAULT 0,
  append_param     text        NOT NULL DEFAULT '',
  is_initiate      integer     NOT NULL DEFAULT 0,
  daily_reset      boolean     NOT NULL DEFAULT false,
  data_stamp       integer     NOT NULL
);

CREATE TABLE seasonal_events.sum_activity_packages (
  active_id   text    NOT NULL REFERENCES seasonal_events.sum_activities(active_id) ON DELETE CASCADE,
  package_id  text    NOT NULL,
  sort_order  integer NOT NULL DEFAULT 0,
  items       jsonb   NOT NULL,   -- [{template_id, template_type, count, isbind, length, job}]
  conditions  jsonb   NOT NULL,   -- [{condition_id, value, bak, bak2, bak3, bak4}]
  PRIMARY KEY (active_id, package_id)
);

CREATE TABLE seasonal_events.sum_activity_progress (
  active_id    text    NOT NULL REFERENCES seasonal_events.sum_activities(active_id) ON DELETE CASCADE,
  player_id    bigint  NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  value        bigint  NOT NULL DEFAULT 0,
  second_value bigint  NOT NULL DEFAULT 0,
  day_date     date,
  PRIMARY KEY (active_id, player_id)
);

CREATE TABLE seasonal_events.sum_activity_claims (
  active_id    text    NOT NULL REFERENCES seasonal_events.sum_activities(active_id) ON DELETE CASCADE,
  package_id   text    NOT NULL,
  player_id    bigint  NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  claimed      integer NOT NULL DEFAULT 0,   -- number of claims (repeatable packages)
  completed    integer NOT NULL DEFAULT 0,   -- finish_value
  day_date     date,
  last_claim_at timestamptz,
  PRIMARY KEY (active_id, package_id, player_id)
);
CREATE INDEX sum_activity_claims_player ON seasonal_events.sum_activity_claims (player_id);
```

Activity specific state (hall of fame best power, cross-server ranks, karneval daily spend) lives with the owning module and is read by the engine when building `ActiveData`.

---

## 8. Backend implementation notes

| Handler | Route | Notes |
|---|---|---|
| `seasonal_events::funny::handle_gate` | 8586 | Dispatch by `type`: 1 build 4476 for all visible activities (per type builders registered by owning modules: `medals::hall_of_fame::build_active_data`, cross-server ranks, ...); 2 claim with the validation of 3.1 in one transaction; 3 and 4 for type 51 |
| `seasonal_events::funny::push_templates` | login, configuration change | page 4475 with a new `dataStamp` |
| `seasonal_events::funny::record_progress(player, condition_id, amount, bak)` | internal API | update `sum_activity_progress` of every open activity whose packages use that condition; push 4476 (or 4714 for consumption) when a package becomes claimable |
| `seasonal_events::cccactive::dispatch` | 9645 | `match packet.extend1 { 25 => golden_dionysia, 31 => golden_sheep, 23 => inventory::pandora, ... }` |
| `seasonal_events::windows::scheduler` | timer | at each window start and end push 4590 (`param1`), the dedicated open-state opcode, or the 4422 switch; at 00:00 run daily resets |

- Type specific claim hooks: types owned by other features register a claim validator and a 4476 builder with the engine (for example type 146 power threshold).
- Never trust the client for `count`: clamp to `get_count`.

---

## 9. Open questions and assumptions

- *(assumption)* Page size of 4475 and when 4714 is used instead of 4476.
- *(assumption)* Daily reset flag per activity; the protocol has no field for it.
- The `extend1` values 26, 32, 33, 37, 39 are unused by this client.

Proto package ownership (all messages of the six packages; "this feature" means seasonal-events):

**Package `active`**

| Owner feature | Messages |
|---|---|
| [cross-server](../cross-server/README.md) (345 `U_C_CONSUM_RANK`, handler in `FunnyManager`) | `ChargeRewardMsg` |
| seasonal-events (this feature: sum-active engine), also read by [cross-server](../cross-server/README.md) | `ActiveData`, `PackageConditionMsg`, `PackageData`, `SumActiveDataMsg`, `SumActiveGetPackageMsg`, `SumActiveItemInfoMsg`, `SumActivePackageMsg`, `SumActiveinfoMsg`, `SumActivesMsg` |
| seasonal-events (this feature) | `ActiveInfoMsg`, `ActiveMsgLeaveInfo`, `ActiveMsgLeaveOp`, `ActiveOptionMsg`, `ActiveRspMsg`, `ChairsListMsg`, `ChargeLotteryMsg`, `ConsumeInfoMsg`, `ItemMsg`, `LoginActiveMsg`, `LoginRewardInfoMsg`, `NewMountFeedMsg`, `PayInfoMsg`, `QueryActiveMsg`, `RebateAllInfosMsg`, `RewardItemMsg`, `ActiveRspInfo` and `ActiveItemRspInfo` (nested in `ActiveRspMsg`), `ChairsChargeMsg` and `ChairsRewardMsg` (nested in `ChairsListMsg`, never read) |
| [returning-players](../returning-players/README.md) (handlers live in `FunnyManager`) | `ReturnChargeRewardMsg`, `ReturnCommonRewardMsg`, `ReturnOptionMsg`, `ReturnedItemMsg`, `RewardMsg` |
| unused by any client class | `LotoInfoMsg`, `LotoReqMsg`, `LotoRspMsg`, `OreCastle2CrossActiveInfoMsg`, `OreCross2CastleActiveInfoMsg` (cross-server internal), `OreMineReqMsg` |
| nested types (owner = owner of the parent) | `DayActiveRspInfo` (daily-activity), `FMOp`, `FMType` (enums of the fashion and mount lottery), `LuckExchangeInfoMsg`, `LuckExchangeItemTempMsg` (exchange) |
| [mines](../mines/README.md) | `ActiveParamMsg`, `DepositActiveMsg`, `GItemInfoMsg`, `GetItemInfosMsg`, `GetLogMsg`, `GradeRewardInfoMsg`, `LevelInfoMsg`, `LodeListMsg`, `RewardItemInfoMsg` |
| [exchange](../exchange/README.md) | `AllExchangeItemInfoMsg`, `AllExchangeMsg`, `LuckExchangeInfoListMsg`, `LuckExchangeOpMsg`, `LuckExchangeTempListMsg`, `LuckExchangeTempMsg` |
| [daily-activity](../daily-activity/README.md) | `DayActiveRspMsg`, `SuperSigninCardReqMsg`, `SuperSigninCardRespMsg`, `SuperSigninDetailMsg`, `SuperSigninRewardMsg`, `SuperSigninTempMsg` |
| [shops](../shops/README.md) | `DiscountMallItemInfo`, `DiscountMallMsg`, `DiscountMallRequestMsg`, `DiscountMallScoreInfo`, `MvpShopItemInfoMsg`, `MvpShopMsg`, `ShopDiscountActiveMsg`, `ShopItemInfoMsg`, `UserBuyInfoMsg` |
| no registered feature: client package `exchangebox` (fashion and mount lottery, 9613 `C_FASHION_MOUNT_LOTTERY`, 367..369) | `FMBaseItem`, `FMDropMsg`, `FMReqMsg`, `FMResMsg`, `HotItemMsg` |
| [time-story](../time-story/README.md) | `GameStoryMsg` |
| [treasures](../treasures/README.md) | `GodTreasureReqMsg`, `GodTreasureRspMsg`, `ItemInfoMsg`, `PlayerCrashInfoMsg`, `PlayerJoinInfoMsg`, `PlayerRankMsg`, `RewardInfoMsg`, `TreasureHuntActiveMsg`, `TreasureHuntOpMsg`, `TreasureRankMsg` |
| [vip](../vip/README.md) | `ItemBoxChainIndexListMsg`, `ItemBoxChainMsg`, `ItemBoxChainReqMsg`, `ItemBoxChainTemplateMsg` |
| [cross-server](../cross-server/README.md) | `OreActiveBaseInfoMsg`, `OreActiveClientOpMsg`, `OreItemInfoMsg`, `OreMineRespMsg`, `OreRewardTempMsg`, `OreWindowMsg` |
| [inventory](../inventory/README.md) | `RentalBagOpReqMsg`, `RentalBagOpResMsg` |
| [sacrifice](../sacrifice/README.md) | `SacrificeReqMsg`, `SacrificeRspMsg` |
| [casino](../casino/README.md) | `SlotActiveMsg`, `SlotActiveRequest` |
| [cosmos](../cosmos/README.md) | `StarAreaMessage` |
| [lotteries](../lotteries/README.md) | `WishPoolItemInfo`, `WishPoolReqMsg`, `WishPoolRespMsg`, `WishPoolShopGoodInfo`, `WishPoolWindowMsg` |

**Package `active.anniversary`**

| Owner feature | Messages |
|---|---|
| unused (see [seven-year.md](seven-year.md)) | `ActiveInfoMsg`, `ActiveRewardMsg`, `ActiveSimpleMsg`, `DreamCTPassMsg`, `GetTreasuryMsg`, `GoldenEggPassMsg`, `ItemInfo`, `MysticalTreasuryMsg`, `NoteInfo`, `NoteInfoMsg`, `PassItem`, `PrayerInfoMsg`, `TruewordInfoListMsg`, `TruewordInfoMsg` |
| [hermitage-war](../hermitage-war/seven-year-event.md) (client package `sevenyear`) | `SevenYearAchievementMsg`, `SevenYearActiveMsg`, `SevenYearOrderListMsg`, `SevenYearOrderMsg`, `SevenYearQuestionMsg`, `SevenYearUserMsg` |

**Package `cccactive`**

| Owner feature | Messages |
|---|---|
| [treasures](../treasures/README.md) | `ActiveAwardTemplatePB`, `ActiveInfoPB`, `ActiveRankPB`, `ExchangeItemPB`, `LotteryRecordPB`, `SkyTreasureActiveTempInfoRes`, `SkyTreasureAwardHistoryPB`, `SkyTreasureAwardHistoryRes`, `SkyTreasureExchangeActivePB`, `SkyTreasureExchangeInfoRes`, `SkyTreasureExchangeReq`, `SkyTreasureExchangeRes`, `SkyTreasureLotteryPB`, `SkyTreasureLotteryRecordReq`, `SkyTreasureLotteryRecordRes`, `SkyTreasureLotteryReq`, `SkyTreasurePlayerInfoRes`, `SkyTreasureRankInfoPB`, `SkyTreasureRankInfoRes` |
| [lotteries](../lotteries/README.md) | `ChargePointLotteryMsg`, `EggTempMsg`, `FoisonHornMsg`, `ItemInfoMsg`, `LuckyLotteryOpMsg`, `LuckyLotteryRecordMsg`, `LuckyLotteryRespMsg`, `LuckyRewardMsg`, `PumpingMsg`, `RecordMsg` |
| seasonal-events (this feature) | `CrazyOrderInfoMsg`, `GoldCrazyMsg`, `GoldCrazyRewardMsg`, `GoldenSheepMsg`, `GoldenSheepPlayerMsg` |
| unused or nested | `CrazyOrderListMsg` (unused), `GoldCrazyInfoMsg`, `GoldLotteryMsg` (nested in `GoldCrazyMsg`, never read), `LotteryItemMsg` (nested in `ChargePointLotteryMsg`, lotteries) |
| [vip](../vip/README.md) | `CustomizedVipBoxMsg`, `CustomizedVipItemMsg`, `CustomizedVipMsg`, `GiftItemInfoMsg`, `MonthCardGiftMsg`, `MonthCardMsg` |
| [inventory](../inventory/README.md) | `LotteryRewardMsg`, `PandoraLotteryMsg` |
| [recharge](../recharge/README.md) | `MoneyReturnMsg` |
| [laboratory](../laboratory/README.md) | `PlatinaCanOpMsg`, `PlatinaItemGainTipMsg`, `PlatinaItemInfoMsg` |

**Package `universalActive`**

| Owner feature | Messages |
|---|---|
| unused by any client class | `ExchangeActive`, `ExchangeItemInfo`, `ExchangeMsg`, `ExchangeReq` |

**Package `sumpassion`**

| Owner feature | Messages |
|---|---|
| seasonal-events (this feature) | `EggItemMsg`, `EggListMsg`, `EggMsg`, `LevelMsg`, `SumCampaignTaskListMsg`, `SumGiftList`, `TaskMsg` |
| [recharge](../recharge/README.md) | `EncoDayMsg`, `EncoGoldListMsg` |
| nested (this feature) | `GiftItemMsg` (in `LevelMsg`), `ItemMsg` (in `TaskMsg`) |

**Package `giftparty`**

| Owner feature | Messages |
|---|---|
| [fantasy-bar](../fantasy-bar/README.md) | `GiftPartyMsg`, `GiftPartyTeamInfoMsg`, `TeamMemberInfoMsg` |

---

## 10. Implementation checklist

- [ ] Table `event_windows` and the window scheduler (4590, dedicated open-state pushes, 4422 switches)
- [ ] Sum-active tables and configuration loader
- [ ] 4475 paging with `dataStamp`
- [ ] 8586 types 1..4 with per type builders and validators
- [ ] 4476 and 4714 pushes from `record_progress`
- [ ] 9645 dispatcher by `extend1` with the 14 known sub-events
- [ ] Generated protobuf code for `active`, `active.anniversary`, `cccactive`, `universalActive`, `sumpassion`, `giftparty`
- [ ] Tests: stale `dataStamp` page ignored, claim after `end_date`, multi-claim above `get_count`, unknown `extend1`
