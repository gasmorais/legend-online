# Rave party ("Festa do Carnaval", 狂欢派对)

Feature `seasonal-events`, module `rave-party`. Client package `raveparty` (`M11/raveparty/*`, `M11/raveparty/sort/*`), shared `CM/managers/RavePartyManager.as` (`RPM`), `CM/mvc/module/raveparty/*` (`RavePartyModel`, `RavePartyRewardInfo`, `RavePartyRewardType`, `RavePartyClientOpType`, `RavePartySortInfo`). Proto package `party` (registered under [../marriage/README.md](../marriage/README.md), which explicitly delegates it here).

Conventions: see [README.md](README.md).

---

## 1. Overview

A cross-server points event. The player earns "Pontos da Festa do Carnaval" from recharge, diamond spending and daily activity points ("pontos de atividade", reset at 0h), plus from other highlighted events ("Para obtenção de mais pontos pode verificar os eventos nos destaques"). Points feed eight reward ladders:

| Type (`RavePartyRewardType`) | Ladder | Value compared |
|---|---|---|
| 1 CHARGE | Recharge ladder | `myChargePoint` (diamonds recharged) |
| 2 CONSUM | Spending ladder | `myConsumPoint` (diamonds spent) |
| 3 LEED | Daily activity ladder | `myLeedScore` (daily, reset 0h) |
| 4 SELF_SCORE | Personal points | `myTotalScore` |
| 5 GUILD_SCORE | Guild points | `myConsortiaScore` (sum of guild members) |
| 6 SERVER_SCORE | Server points | `myServerScore` (sum of the server) |
| 7 GUILD_SORT | Cross-server guild rank | rank of the guild, rewards mailed after the event |
| 8 SERVER_SORT | Cross-server server rank | rank of the server, mailed after the event |

Help (`RavePartyScoreView.scoreAlertText.text4`): until the player has collected the first personal points reward, they cannot collect the guild and server cross rank rewards.

---

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `raveparty.RavePartyFrame` (`M11/raveparty/RavePartyFrame.as`) | title `ui.toptoolbar.TopToolsBar.tipData_raveparty`; time "godarrive.GodArriveFrame.activeTime" (`openTime`, `stopTime`) | 6 tab buttons | Tool bar `raveparty` (TopToolBtnInfo 2011 "狂欢派对--积分活动", `CM/ui/toptoolbar/TopToolsBar.as:1353-1354`); visible when `grades >= 11` and `openState == 1` (`TopBtnCheckShowHelper.as:355-356`) | Tabs: rave, "Pontos pessoais", "Pontos da guilda", "Pontos do servidor", "Pontos inter-serv da Guilda", "Pontos inter-servidor do servidor" (`:98-110, 141-175`) |
| `raveparty.RavePartyView` + `RavePartyItemView` + `RavePartyBoxImage` | rave tab | Ladders 1, 2, 3 | Tab 0 | Per ladder "A cada {0} dimas de recarga, oferece {1} pontos..." from `chargeScoreSet`/`consumScoreSet` "diamonds\|points" (`RavePartyItemView.as:88-100`), "Pontos obtidos"/"Pontos atuais", boxes with state; total `myTotalScore`; link "Clique para entrar nos destaques" opens `funny` |
| `raveparty.RavePartyScoreView` + `RavePartyScoreItemView` | personal, guild, server | Ladders 4, 5, 6 (`setShowType(selectIndex + 3)`) | Tabs 1..3 | Current grade and next `needValue` (`RavePartyModel.getCurGradeAndMaxData`), reward items, claim button |
| `raveparty.sort.RavePartyScoreSortView` / `RavePartyScoreSortFrame` + `RavePartySortItem` | inter-server ranks | Rank lists 7 and 8 | Tabs 4, 5 | order, server name, guild name, score, my order, update time |
| `raveparty.sort.RavePartySortRewardFrame` | rank rewards | Rank reward preview | Sort view | "{0}º lugar e inferior:" or "{0}-{1}º lugar:", "Após o evento terminar, será enviado os prêmios baseando-se no rank." |

---

## 3. Routes (client to server)

Single route: **9630 (0x259e) `C_PARTY_CLIENT_OP`**, body `party.PartyOpMsg`, sender `RavePartyManager.sendRavePartyRequest(op, takeRewardType = 0, takeRewardLevel = 0)` (`RPM:299-308`); type and level are only set when non zero.

`PartyOpMsg`: `op` (#1, INT32); `state` (#2, INT32) not sent; `takeRewardType` (#3, INT32); `takeRewardLevel` (#4, INT32).

| op (`RavePartyClientOpType`) | UI control | Sender (file:line) | Client checks | Expected response |
|---|---|---|---|---|
| 1 REQUEST | Frame opens | `RavePartyFrame()` (`M11/raveparty/RavePartyFrame.as:56-63`) | none | 393 (templates, if not cached) and 400 (user state) |
| 2 TAKEREWARD | box or claim button | `RavePartyBoxImage.__getRewardHandler` (`RavePartyBoxImage.as:69-76`), `RavePartyScoreItemView.__onGetRewardHandler` (`RavePartyScoreItemView.as:84-91`) | `rewardState == 1` | 400 with that reward's `rewardState = 2`; bag pushes |
| 3 CONSORTIARANK | guild cross rank tab | `RavePartyScoreSortView(showType 7)` (`sort/RavePartyScoreSortView.as:75-83`), `RavePartyScoreSortFrame(7)` (`sort/RavePartyScoreSortFrame.as:78-86`) | none | 402 |
| 4 SERVERRANK | server cross rank tab | same with showType 8 (`showType - 4`) | none | 403 |

---

## 4. Server messages (server to client)

| Opcode | Name | Message | Receiver | When | Reaction |
|---|---|---|---|---|---|
| 393 (0x0189) | U_C_PARTY_TEMP | `party.PartyMsg` (template part) | `RPM.__updatePartyTempHandler` (`RPM:55, 62-125`) | Login while open, event start, op 1 | Sets times and score rules; each reward list present replaces the model list (sorted by `rewardLevel`); `hasTempData = true` |
| 400 (0x0190) | U_C_PARTY_MSG | `party.PartyMsg` (user part) | `__updatePartyUserInfoHandler` (`RPM:56, 153-215`) | op 1, op 2, push when points change | Sets my scores; for each `PartyRewardMsg` matches `(rewardType, rewardLevel)` and copies `rewardState` |
| 401 (0x0191) | U_C_PARTY_OPEN_STATE | `party.PartyOpMsg` | `__updatePartyOpenStateHandler` (`RPM:57, 230-241`) | Login, start, end | `openState = state`; 0 clears all data; tool bar refresh (`TopToolsBar.as:465, 592-595`) |
| 402 (0x0192) | U_C_PARTY_CONSORTIA_RANK | `party.PartyOrdersMsg` | `__updatePartyGuildSortHandler` (`RPM:58, 243-269`) | op 3 | Guild rank list sorted by `order`, `myOrder`, `updateTime` |
| 403 (0x0193) | U_C_PARTY_SERVER_RANK | `party.PartyOrdersMsg` | `__updatePartyServerSortHandler` (`RPM:59, 271-297`) | op 4 | Server rank list |

Fields:

| Message | Fields |
|---|---|
| `PartyMsg` | `uUid` (#1, STRING) event id; `serverUid` (#2, STRING); `openTime` (#3, STRING), `stopTime` (#4, STRING); `chargeScoreSet` (#5, STRING) "diamonds\|points"; `consumScoreSet` (#6, STRING) same; `myTotalScore` (#7), `myChargePoint` (#8), `myConsumPoint` (#9), `myLeedScore` (#10), `myConsortiaScore` (#11), `myServerScore` (#12) INT32; reward lists `chargeReward` (#13), `comsumReward` (#14), `leedsReward` (#15), `playerScoreReward` (#16), `consortiaScoreReward` (#17), `serverScoreReward` (#18), `consortiaCrossOrderReward` (#19), `serverCrossOrderReward` (#20), all `PartyRewardMsg, repeated` |
| `PartyRewardMsg` | `uUid` (#1, STRING); `rewardType` (#2, INT32) 1..8; `rewardLevel` (#3, INT32) tier; `needValue1` (#4, INT32) threshold; `needOrder1` (#5), `needOrder2` (#6) INT32 rank range; `rewardScore` (#7, INT32) points shown on the tier; `templateIds1..6` (#8..#13, STRING) "templateId\|count"; `rewardState` (#14, INT32) 0 locked, 1 claimable, 2 claimed |
| `PartyOpMsg` (401) | `state` (#2, INT32) 1 open, 0 closed |
| `PartyOrdersMsg` | `info` (#1, OrderInfoMsg, repeated); `myOrder` (#2, INT32); `updateTime` (#3, STRING) |
| `OrderInfoMsg` | `order` (#1, INT32); `serverName` (#2, STRING); `consortiaName` (#3, STRING); `partyScore` (#4, INT32) |

`PartyConsortiaMsg` and `PartyConsortiaMsgList` (`serverUid`, `serverName`, `consortiaId`, `consortiaName`, `consortiaGrade`, `score`, `order`, `uuid`; list with `eventId`, `op`) are never read by the client: they are the cross-server aggregation format *(assumption: server to cross-server sync)*.

---

## 5. Rules and formulas

- Points: `myChargePoint` and `myConsumPoint` grow per `chargeScoreSet`/`consumScoreSet` blocks ("A cada {0} dimas ... oferece {1} pontos"); total `myTotalScore = recharge points + spend points + activity points + item points` *(assumption: activity and highlighted events also add)*. Guild score = sum of members' totals; server score = sum of the server.
- A tier of types 1..6 becomes claimable (`rewardState 1`) when the compared value >= `needValue1`. Types 3 and its daily state reset at 0h ("Os pontos de atividade são redefinidos todas os dias às 0h").
- Types 7 and 8: rank tiers `needOrder1..needOrder2`; mailed at the end; require the first personal tier claimed.
- Tool bar visible only for `grades >= 11`.

---

## 6. Templates

No XML: all tiers come from the server in 393. Proposed admin configuration: one event row and its reward rows (type, level, need value, rank range, items).

---

## 7. Persistent state (PostgreSQL, schema `seasonal_events`)

```sql
CREATE TABLE seasonal_events.rave_party_events (
  event_uid        text PRIMARY KEY,
  open_time        timestamptz NOT NULL,
  stop_time        timestamptz NOT NULL,
  charge_score_set text NOT NULL,
  consume_score_set text NOT NULL
);

CREATE TABLE seasonal_events.rave_party_rewards (
  event_uid     text     NOT NULL REFERENCES seasonal_events.rave_party_events(event_uid) ON DELETE CASCADE,
  reward_type   smallint NOT NULL CHECK (reward_type BETWEEN 1 AND 8),
  reward_level  smallint NOT NULL,
  need_value    integer  NOT NULL DEFAULT 0,
  need_order_from integer NOT NULL DEFAULT 0,
  need_order_to   integer NOT NULL DEFAULT 0,
  reward_score  integer  NOT NULL DEFAULT 0,
  items         jsonb    NOT NULL,
  PRIMARY KEY (event_uid, reward_type, reward_level)
);

CREATE TABLE seasonal_events.rave_party_players (
  event_uid     text    NOT NULL REFERENCES seasonal_events.rave_party_events(event_uid) ON DELETE CASCADE,
  player_id     bigint  NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  consortia_id  integer,
  charge_points integer NOT NULL DEFAULT 0,
  consume_points integer NOT NULL DEFAULT 0,
  leed_points   integer NOT NULL DEFAULT 0,
  leed_day      date,
  total_points  integer NOT NULL DEFAULT 0,
  PRIMARY KEY (event_uid, player_id)
);
CREATE INDEX rave_party_players_guild ON seasonal_events.rave_party_players (event_uid, consortia_id);

CREATE TABLE seasonal_events.rave_party_claims (
  event_uid    text     NOT NULL,
  player_id    bigint   NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  reward_type  smallint NOT NULL,
  reward_level smallint NOT NULL,
  claim_day    date     NOT NULL DEFAULT '1970-01-01',
  claimed_at   timestamptz NOT NULL DEFAULT now(),
  PRIMARY KEY (event_uid, player_id, reward_type, reward_level, claim_day)
);
```

---

## 8. Backend implementation notes

| Handler | op | Notes |
|---|---|---|
| `seasonal_events::rave_party::handle_request` | 1 | 393 then 400 |
| `seasonal_events::rave_party::handle_take_reward` | 2 | type in 1..6 → tier exists → value >= need → not claimed (type 3 per day) → bag space; tx; 400 |
| `seasonal_events::rave_party::handle_guild_rank` | 3 | read cross-server guild ranking (cached, `updateTime`); 402 |
| `seasonal_events::rave_party::handle_server_rank` | 4 | 403 |

- Hooks: recharge, diamond spend, daily activity points, and point items.
- Schedules: 401 broadcast at start and end; ranking refresh (periodic); at the end, mail types 7 and 8 to eligible players.
- Cross-server: guild and server aggregation lives in the cross-server service ([../cross-server/README.md](../cross-server/README.md)).

---

## 9. Open questions and assumptions

- *(assumption)* Exact point sources besides recharge and spend ("item points", other events).
- *(assumption)* Guild rank uses the guild at the time of scoring.
- `PartyConsortiaMsg*` unused by the client.

---

## 10. Implementation checklist

- [ ] Tool bar button 2011 visibility (`grades >= 11`, open state)
- [ ] Frame with 6 tabs, item, score and sort views
- [ ] Route 9630 ops 1..4
- [ ] Server messages 393, 400, 401, 402, 403
- [ ] Tables `rave_party_events`, `rave_party_rewards`, `rave_party_players`, `rave_party_claims`
- [ ] Point hooks (recharge, spend, activity)
- [ ] End of event mail for ranks
- [ ] Tests: claim twice, claim before threshold, daily reset of type 3, rank reward gate on first personal tier
