# Celestial treasure ("Tesouro celeste")

Module `celestial-treasure` of feature `treasures`. Cross-server lottery, exchange shop and score rankings configured entirely by activity templates the server pushes (`cccactive` protobuf package).

Path aliases:

| Alias | File |
|---|---|
| STM | `decompiled/core_module/scripts/yishi/manager/SkyTreasureManager.as` |
| SMN | `decompiled/core_module/scripts/mvc/module/skytreasure/SkyTreasureModelNew.as` |
| SAT | `decompiled/core_module/scripts/mvc/module/skytreasure/SkyTreasureActTemplateInfo.as` |
| SLD | `decompiled/core_module/scripts/mvc/module/skytreasure/SkyTreasureLotteryDataInfo.as` |
| SEI | `decompiled/core_module/scripts/mvc/module/skytreasure/SkyTreasureExchangeItemInfo.as` |
| SRD | `decompiled/core_module/scripts/mvc/module/skytreasure/SkyTreasureRankDataInfo.as` |
| STC | `decompiled/core_module/scripts/mvc/controler/SkyTreasureController.as` |
| SF1 | `decompiled/m11/scripts/skytreasure/SkyTreasureFrame1.as` |
| SLV | `decompiled/m11/scripts/skytreasure/SkyTreasureLotteryView.as` |
| SEV | `decompiled/m11/scripts/skytreasure/SkyTreasureExchangeView.as` |
| SGI | `decompiled/m11/scripts/skytreasure/SkyGoodItem.as` |
| SBF | `decompiled/m11/scripts/skytreasure/SkyShopBuyFrame.as` |
| TBH | `decompiled/core_module/scripts/ui/toptoolbar/TopBtnCheckShowHelper.as` |

## 1. Overview

The server defines a set of activities (`ActiveInfoPB`), each with a `uuid`, a `type` and a time window:

| type | Constant | Meaning | Tab |
|---|---|---|---|
| 100..109 | `SKY_TREASURE_LOTTERY*` | lottery pool ("Sorteio") | lottery view |
| 110..114 | `SKY_TREASURE_EXCHANGE*` | exchange shop ("Trocar") | exchange view |
| 120 | `SKY_TREASURE_TOTAL_RANK` | total score ranking ("Pontuação total") | inside lottery view |
| 121 | `SKY_TREASURE_ROUND_RANK_1` | round score ranking ("Pontos desta rodada") | inside lottery view |

(`decompiled/core_module/scripts/mvc/module/skytreasure/SkyTreasureActType.as`, SMN:57-135.)

Lottery: draws cost the key item `param1` ("Pedras do céu"); missing keys are paid with `param2` diamonds each. One free draw becomes available at `fresh_time`. 50 draws cost 45 keys. Draws give items and score; every `times` draws a big prize is guaranteed ("nextBigGiftTimes"). Exchange: spend the exchange currency item `param1` to buy items with total, daily or no limit. Rankings: score per round and in total, cross-server (`site` = server), with rank rewards described in the rank activity's award templates.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `SkyTreasureFrame1` (SF1, style `skytreasure.SkyTreasureFrame`) | "Tesouro celeste" | tab per open non rank activity, red dots | top toolbar `skytreasure1` (`TopToolsBar.as:1075-1076`), controller `skytreasure1` default `openType` (STC) | tabs from `SMN.getAllSkyTreasureFrameOpenActTempData` sorted by type (SMN:193-205) |
| `SkyTreasureLotteryView` (SLV) | "Sorteio" | draw 1/10/50, show pool, my rank and score, timers | tab of type 100..109 | `param5` name (SLV:476), key count, free draw countdown "Grátis após {0}" (SLV:671-687), `times` (SLV:656), round/total rank and score (SLV:279-318), round countdown "Contagem regressiva desta rodada: {0}", activity countdown |
| `SkyTreasureExchangeView` (SEV) + `SkyGoodItem` (SGI) | "Trocar" | shop grid | tab of type 110..114 | item, cost `exchangeCostNum`, limit "Compra limitada diária:" / "Compra limitada total" / "Sem limite" with remaining (SGI:146-194) |
| `SkyShopBuyFrame` (SBF) | "Comprar" | quantity selector | `SGI` buy button (SGI:137) | price `cost * n`, n clamped to remaining limit and 1..999 (SBF:320-340) |
| `SkyTraesureProFrame` | "Probabilidade" | pool items with `rate` strings | controller `skytreasure1` `openType = 2` (SLV:440-451) | `LotteryRateInfo` list |
| `SkyTreasureCoinRankFrame` | "Prêmio do ranking de pontos" | tabs "Prêmio de pontos desta rodada", "Prêmio de pontos totais", "Registro no ranking" | `openType = 3` | rank rewards (`remain1` rank, `remain3` required score, `remain2` text), history (773) |
| `SkyTreasureRankFrame` | "Registro de prêmios" | "Registro individual" / "Registro inter-servidor" | `openType = 4` with the activity | 775 records |

Top toolbar button visible when `getAllSkyTreasureFrameOpenActTempData().length > 0` (TBH:429-430); red dot and counter when `SMN.getAllred()` (SMN:245-315): a lottery has keys or a free draw ready, or an exchange item is affordable and under its limit.

## 3. Routes (client to server)

### R1. Open frame: rank info (9030) and exchange info (9032)
- Sender `STM.sendSkyTreasureRankInfoReq` (STM:694-700) in the SF1 constructor (SF1:52-57). Both packets have no body (`sendProtobuffer(pkg, null)`).
- C>S 9030 (0x2346) `C_SKY_TREASURE_REQ_RANK_INFO` -> 772. C>S 9032 (0x2348) `C_SKY_TREASURE_EXCHANGEUPDATE_REQ` -> 776.
- Also sends 9026 for the first tab (SF1:134).

### R2. Draw (9025 `C_SKY_TREASURE_LOTTERY_INFO_REQ`, 0x2341)
- UI: "Sortear 1 vez", "Sortear 10 vezes", "Sortear 50 vezes" (SLV:383-428).
- Client checks: keys = `getBagCountInPlayerAndStoneByTempId(param1)`; diamond shortfall = `param2` (1 draw), `param2 * (10 - keys)`, `param2 * (45 - keys)`; if keys are short (for 1 draw: also no free draw ready) confirm "Pedras do céu insuficientes, deseja gastar {0} diamantes?" (SLV:405-421); no activity -> "Sem eventos no momento".
- Request `SkyTreasureLotteryReq`: `active_id (#1, STRING)` activity uuid, `count (#2, INT32)` 1, 10 or 50. Sender `STM.sendSkyTreasureLotteryReq` (STM:667-674).
- Response: 774 with the updated lottery state (client then requests 9026 itself, SLV:453-457), bag updates, reward display (assumption: through the generic reward push).

### R3. Lottery records (9026 `C_SKY_TREASURE_LOTTERY_RECORD_REQ`, 0x2342)
- `SkyTreasureLotteryRecordReq { active_id (#1, STRING) }`, sender STM:676-682, on tab change (SF1:164) and after a draw (SLV:457).
- Response 775.

### R4. Exchange (9027 `C_SKY_TREASURE_EXCHANGE_REQ`, 0x2343)
- UI: `SkyShopBuyFrame` confirm (SBF:270-286). The client picks the last open exchange activity and sends it.
- Client checks: quantity 1..min(999, remaining limit) (SBF:320-340); buy button disabled at limit (SGI:146-163). No currency check client side.
- `SkyTreasureExchangeReq`: `active_id (#1, STRING)`, `template_id (#2, INT32)` item to buy, `count (#3, INT32)`.
- Response 777 with the updated counter, bag updates.

### R5. Rank history (9031 `C_SKY_TREASURE_RANK_HISTORY_REQ`, 0x2347)
- No body. Sender STM:702-706 from `SkyTreasureCoinRankView` and `SkyTreasureHistoryView` (`decompiled/m11/scripts/skytreasure/reward/SkyTreasureCoinRankView.as:23`, `rank/SkyTreasureHistoryView.as:33`).
- Response 773.

## 4. Server messages (server to client)

All handlers in STM:500-626 call `MsgMan.notifyObserver("SKYTREASURE1")` (top toolbar refresh) and restart the free draw timer.

### S1. 778 (0x030a) `U_C_SKY_TREASURE_ACTIVE_CONFIG`, `SkyTreasureActiveTempInfoRes`
Receiver `STM.__updateSkyTreasureActiveTempInfoRes` (STM:614-626) -> `SMN.addSkyTreasureActTempInfo` (replace by uuid).

`info (#1, ActiveInfoPB, repeated)`:

| Field | Tag | Type | Meaning |
|---|---|---|---|
| `uuid` | #1 | STRING | activity id (`actId`) |
| `type` | #2 | INT32 | 100..109, 110..114, 120, 121 |
| `start_time` | #3 | STRING | "YYYY-MM-DD hh:mm:ss" |
| `end_time` | #4 | STRING | end; `actLeftTime` countdown |
| `show_time` | #5 | STRING | visible until (open = start <= now <= show_time or end_time) (SAT:117-120) |
| `param1` | #6 | INT32 | lottery: key item template; exchange: currency item template |
| `param2` | #7 | INT32 | lottery: diamonds per missing key |
| `param3` | #8 | INT32 | unused by the client |
| `param4` | #9 | INT32 | lottery: shown in `_time` before data arrives (assumption: big prize period) |
| `param5` | #10 | STRING | display name |
| `param6` | #11 | STRING | unused (assumption: art key) |
| `desc` | #12 | STRING | description, also used to match history rows |
| `awardTemp` | #13 | `ActiveAwardTemplatePB`, repeated | per type, see below |

`ActiveAwardTemplatePB`: `uuid (#1, STRING)`, `template_id (#2, INT32)`, `template_type (#3, INT32)`, `template_count (#4, INT32)`, `template_show (#5, INT32)`, `is_bind (#6, INT32)`, `is_notice (#7, INT32)`, `remain_1..remain_4 (#8..#11, STRING)`. Interpretation (SAT:60-90): lottery -> pool item `template_id`, `template_type`, `template_count`, shown when `template_show != 0`, `remain_3` = rate text; exchange -> item `template_id` x `template_count`, `remain_1` limit type (0 none, 1 per activity, 2 per day), `remain_2` limit count, `remain_3` cost; rank -> `remain_1` rank label, `remain_3` required score, `remain_2` reward text.

When: at login and whenever the activity set changes (assumption).

### S2. 774 (0x0306) `U_C_SKY_TREASURE_LOTTERY_INFO`, `SkyTreasurePlayerInfoRes`
Receiver STM:551-563. `info (#1, SkyTreasureLotteryPB, repeated)`: `active_id (#1, STRING)`, `fresh_time (#2, STRING)` next free draw time, `times (#3, INT32)` draws left until the big prize. Send at login and after each draw.

### S3. 775 (0x0307) `U_C_SKY_TREASURE_LOTTERY_RECORD`, `SkyTreasureLotteryRecordRes`
Receiver STM:565-583. `selfRecord (#1, LotteryRecordPB, repeated)`, `serverRecord (#2, LotteryRecordPB, repeated)`; `LotteryRecordPB`: `time (#1, STRING)`, `active_name (#2, STRING)`, `item_id (#3, INT32)`, `item_count (#4, INT32)`, `server_id (#5, STRING)`, `nick_name (#6, STRING)`. Client sorts by time descending.

### S4. 776 (0x0308) `U_C_SKY_TREASURE_EXCHANGE_INFO`, `SkyTreasureExchangeInfoRes`
Receiver STM:585-598 (replaces all). `exchangeInfo (#1, SkyTreasureExchangeActivePB, repeated)`: `active_id (#1, STRING)`, `items (#2, ExchangeItemPB, repeated)`; `ExchangeItemPB`: `active_id (#1, STRING)`, `template_id (#2, INT32)`, `exchange_times (#3, INT32)` already bought in the limit period.

### S5. 777 (0x0309) `U_C_SKY_TREASURE_EXCHANGE_RES`, `SkyTreasureExchangeRes`
Receiver STM:600-612. Field `info (#1, SkyTreasureExchangeActivePB)` (missing from `protocol/proto.json`, verified in `decompiled/core_module/scripts/com/road/yishi/proto/cccactive/SkyTreasureExchangeRes.as:34-49`). The client updates only `items[0]`, so send one item: the one just bought with its new `exchange_times`. Without `info` the client only refreshes the toolbar (use this for failures).

### S6. 772 (0x0304) `U_C_SKY_TREASURE_RANK_INFO`, `SkyTreasureRankInfoRes`
Receiver STM:500-521. `info (#1, SkyTreasureRankInfoPB, repeated)`; `SkyTreasureRankInfoPB`: `active_id (#1, STRING)` id of a type 120 or 121 activity, `ranks (#2, ActiveRankPB, repeated)`, `self (#3, ActiveRankPB)` (tag 3 missing from proto.json, verified in `SkyTreasureRankInfoPB.as:58-86`). `ActiveRankPB`: `user_name (#1, STRING)`, `score (#2, INT32)`, `rank (#3, INT32)`, `active_id (#4, STRING)`, `site (#5, STRING)` server, `nick_name (#6, STRING)`. Rank 0 in `self` shows "Fora do ranking".

### S7. 773 (0x0305) `U_C_SKY_TREASURE_RANK_HISTORY`, `SkyTreasureAwardHistoryRes`
Receiver STM:523-549. `info (#1, SkyTreasureAwardHistoryPB, repeated)`; `SkyTreasureAwardHistoryPB`: `desc (#1, STRING)` round label, `ranks (#2, ActiveRankPB, repeated)`, `self (#3, ActiveRankPB)`, `active_id (#4, STRING)` (tag 3 verified in `SkyTreasureAwardHistoryPB.as:60-115`).

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Draw counts | 1, 10, 50 | SLV:390-399 |
| 50 draw discount | costs 45 keys | SLV:399, help "Faça 50 sorteios de uma vez para receber desconto" |
| Missing key price | `param2` diamonds per key | SLV:389-399 |
| Free draw | available when `fresh_time <= now`; only for 1 draw | SLD:28-31, SLV:412-419 |
| Big prize | guaranteed after `times` more draws | SLD:33-36, help item 4 |
| Exchange limit types | 0 none, 1 per activity, 2 per day | `SkyTreasureExchangeLimitType.as`, SEI:56-71 |
| Exchange quantity | 1..999 and <= remaining limit | SBF:327-337 |
| Rank activities | 120 total, 121 round; not shown as tabs | SMN:127-135, SMN:193-205 |
| Visibility | `start <= now <= (show_time or end_time)` | SAT:117-120 |

## 6. Templates

No XML; everything comes from 778. Server side configuration should be a table (section 7). `ItemTempInfos.xml` provides names for keys, currencies and pool items.

## 7. Persistent state

```sql
CREATE TABLE treasures.celestial_activities (
  activity_uuid   TEXT PRIMARY KEY,
  activity_type   SMALLINT NOT NULL CHECK (activity_type BETWEEN 100 AND 121),
  starts_at       TIMESTAMPTZ NOT NULL,
  ends_at         TIMESTAMPTZ NOT NULL,
  shown_until     TIMESTAMPTZ,
  param1          INTEGER NOT NULL DEFAULT 0,
  param2          INTEGER NOT NULL DEFAULT 0,
  param3          INTEGER NOT NULL DEFAULT 0,
  param4          INTEGER NOT NULL DEFAULT 0,
  param5          TEXT NOT NULL DEFAULT '',
  param6          TEXT NOT NULL DEFAULT '',
  description     TEXT NOT NULL DEFAULT ''
);

CREATE TABLE treasures.celestial_awards (
  award_uuid      TEXT PRIMARY KEY,
  activity_uuid   TEXT NOT NULL REFERENCES treasures.celestial_activities(activity_uuid) ON DELETE CASCADE,
  template_id     INTEGER NOT NULL,
  template_type   INTEGER NOT NULL DEFAULT 0,
  template_count  INTEGER NOT NULL DEFAULT 1,
  template_show   SMALLINT NOT NULL DEFAULT 0,
  is_bind         BOOLEAN NOT NULL DEFAULT true,
  is_notice       BOOLEAN NOT NULL DEFAULT false,
  weight          INTEGER NOT NULL DEFAULT 0,
  remain_1        TEXT, remain_2 TEXT, remain_3 TEXT, remain_4 TEXT
);
CREATE INDEX celestial_awards_activity ON treasures.celestial_awards (activity_uuid);

CREATE TABLE treasures.celestial_lottery_state (
  player_id       BIGINT NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  activity_uuid   TEXT NOT NULL REFERENCES treasures.celestial_activities(activity_uuid) ON DELETE CASCADE,
  next_free_at    TIMESTAMPTZ NOT NULL,
  draws_to_big    INTEGER NOT NULL,
  PRIMARY KEY (player_id, activity_uuid)
);

CREATE TABLE treasures.celestial_lottery_records (
  record_id       BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  player_id       BIGINT NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  activity_uuid   TEXT NOT NULL,
  server_id       TEXT NOT NULL,
  nickname        TEXT NOT NULL,
  item_id         INTEGER NOT NULL,
  item_count      INTEGER NOT NULL,
  is_notice       BOOLEAN NOT NULL DEFAULT false,
  created_at      TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX celestial_records_player ON treasures.celestial_lottery_records (player_id, created_at DESC);
CREATE INDEX celestial_records_notice ON treasures.celestial_lottery_records (activity_uuid, created_at DESC) WHERE is_notice;

CREATE TABLE treasures.celestial_exchanges (
  player_id       BIGINT NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  activity_uuid   TEXT NOT NULL REFERENCES treasures.celestial_activities(activity_uuid) ON DELETE CASCADE,
  template_id     INTEGER NOT NULL,
  period_day      DATE NOT NULL DEFAULT DATE '1970-01-01',
  exchange_times  INTEGER NOT NULL DEFAULT 0 CHECK (exchange_times >= 0),
  PRIMARY KEY (player_id, activity_uuid, template_id, period_day)
);

CREATE TABLE treasures.celestial_scores (
  player_id       BIGINT NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  activity_uuid   TEXT NOT NULL REFERENCES treasures.celestial_activities(activity_uuid) ON DELETE CASCADE,
  score           INTEGER NOT NULL DEFAULT 0,
  updated_at      TIMESTAMPTZ NOT NULL DEFAULT now(),
  PRIMARY KEY (player_id, activity_uuid)
);
CREATE INDEX celestial_scores_rank ON treasures.celestial_scores (activity_uuid, score DESC, updated_at);

CREATE TABLE treasures.celestial_rank_history (
  history_id      BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  activity_uuid   TEXT NOT NULL,
  round_label     TEXT NOT NULL,
  rank            INTEGER NOT NULL,
  player_id       BIGINT REFERENCES player.players(player_id) ON DELETE SET NULL,
  server_id       TEXT NOT NULL,
  nickname        TEXT NOT NULL,
  score           INTEGER NOT NULL,
  closed_at       TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX celestial_rank_history_activity ON treasures.celestial_rank_history (activity_uuid, closed_at DESC, rank);
```

`period_day` is the day for limit type 2 and the epoch sentinel for types 0 and 1.

## 8. Backend implementation notes

| Opcode | Handler |
|---|---|
| 9030 | `treasures::celestial_treasure::handle_rank_info` -> 772 |
| 9032 | `treasures::celestial_treasure::handle_exchange_info` -> 776 |
| 9025 | `treasures::celestial_treasure::handle_draw` -> 774 |
| 9026 | `treasures::celestial_treasure::handle_records` -> 775 |
| 9027 | `treasures::celestial_treasure::handle_exchange` -> 777 |
| 9031 | `treasures::celestial_treasure::handle_rank_history` -> 773 |

- Login push: 778 (open activities), 774 (state per lottery), 776 (exchange counters).
- Draw: validate activity open and type 100..109, count in {1,10,50}; free draw only when count 1 and `next_free_at <= now` (then `next_free_at = now + interval`, interval assumption from `param3` or `param4`); keys needed = count (45 for 50); missing keys charged `param2` each; weighted roll on `celestial_awards` (weight from `remain_3` or a server only column); decrement `draws_to_big`, on 0 grant the big prize and reset; add score to the open rank activities (120, 121); record rows; one transaction; push 774 and bag updates.
- Exchange: validate open exchange activity, item exists, limit, currency `param1` >= cost * count; debit and grant.
- Ranking: cross-server scope (`site`); round rank closes at each round end (schedule), writes history, mails rank rewards per `remain_1`/`remain_3`.

## 9. Open questions and assumptions

- Assumption: free draw interval and big prize period come from `param3`/`param4`; `param6` unused.
- Assumption: draw score per draw and round length are server configuration.
- `protocol/proto.json` lacks `SkyTreasureExchangeRes.info (#1)`, `SkyTreasureRankInfoPB.self (#3)` and `SkyTreasureAwardHistoryPB.self (#3)`; fixed here from the AS classes.
- The reward popup after a draw is not wired in this module (assumption: generic reward display push).

## 10. Implementation checklist

- [ ] Screen `SkyTreasureFrame1` tabs and red dots
- [ ] Screen lottery view, exchange view, buy frame, probability, rank reward and record frames
- [ ] Route 9030 and 9032 on open
- [ ] Route 9025 draw (1, 10, 50, free)
- [ ] Route 9026 records
- [ ] Route 9027 exchange with limits
- [ ] Route 9031 history
- [ ] Server messages 778, 774, 775, 776, 777, 772, 773
- [ ] Tables `treasures.celestial_*`
- [ ] Round close job, rank rewards by mail, daily limit reset
- [ ] Tests: diamond shortfall math, free draw timer, limit types, rank ordering
