# Summer carnival: public egg and summer gifts ("Carnaval do Verão", 仲夏狂欢季)

Feature `seasonal-events`, module `public-egg`. Client package `publicegg` (`M11/publicegg/*`, `M11/publicegg/frame/*`), shared `CM/yishi/manager/PublicEggManager.as` (`PEM`), controller `CM/mvc/controler/PublicEggControler.as`. Proto package `sumpassion` (`EggListMsg`, `EggMsg`, `EggItemMsg`, `SumGiftList`, `LevelMsg`, `GiftItemMsg`).

Conventions: see [README.md](README.md).

---

## 1. Overview

A summer event made of two independent sub-activities, each with its own open switch, plus a third tab that shows a sum-active activity:

| Sub-activity | pt-BR | Tool bar buttons |
|---|---|---|
| Public egg ("Convidar para o Verão", 激情夏日) | Several "eggs" (tiers by `profile`). Each egg is started for free and opens after a countdown, or is bought instantly with diamonds; opening reveals random items; lighting all items of an egg gives an extra box. A global score box rewards progress | `publicegg_egg` (2028) standalone, or inside `publicegg_total` (2027) |
| Summer gifts ("Presente do Verão", 夏日好礼) | Buy-once packs collected daily for N days (`giftType 1`), and recharge packs unlocked by total recharge and collected daily (`giftType 2`) | `publicegg_sumgift` (2029) standalone, or inside `publicegg_total` |
| Summon tab | The sum-active activity of type 201 (`FunnyModel.eggSummonData`, `CM/mvc/module/funny/FunnyModel.as:573-586`) rendered with `FunnyBagItem` | inside `publicegg_total` |

The open-state pushes say whether each sub-activity runs alone (`param1 = 0`) or inside the combined frame (`param1 = 1`).

---

## 2. Screens

Controller `publicegg` (`PublicEggControler`): openType 1 `publicegg.frame.PublicEggFrame`, 2 `publicegg.frame.PublicGiftFrame`, 3 `publicegg.PublicEggConfirmFrame`, other `publicegg.PublicEggGiftExchargeFrame`.

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `PublicEggGiftExchargeFrame` (`M11/publicegg/PublicEggGiftExchargeFrame.as`) | "Carnaval do Verão" | Combined frame with 3 tabs (egg, gift, summon) | Tool bar `publicegg_total` (`TopToolsBar.as:1314-1315`), visible when `grades >= 6` and (`openEgg1` or `openGift1`) (`TopBtnCheckShowHelper.as:323-324`) | Tabs enabled by `openEgg1`, `openGift1` (`:123-135`) |
| `frame.PublicEggFrame` + `PublicEggView` + `PublicEggItem` | "Convidar para o Verão" | Eggs | Tool bar `publicegg_egg` (`TopToolsBar.as:1317-1318`, visible when `grades >= 6` and `openEgg`) or tab 1 | Per egg: state button, countdown "Contagem:{0}" or "Pode ser coletado", start time "Abertura: {0}min", price digits; score bar `scoreBoxShow` "cur\|need"; score box button enabled by `canTake`, tip "Prêmio do Baú: {0}"; event countdown to `stopTime` |
| `PublicEggConfirmFrame` (openType 3) | "Prêmios" | Items of one egg | Egg item preview (`PublicEggItem.as:142`) | `randomOpenTemps` (lit when `isOpen`, hidden when `isHiden`), note "Após abrir cerveja obterá os seguintes itens, acendendo todos os itens poderá obter prêmios adicionais.", extra box (`boxRewardState`, `boxRewardsTemps`) |
| `frame.PublicGiftFrame` + `PublicGiftView` + `PublicGiftItem` | "Presente do Verão" | Gifts | Tool bar `publicegg_sumgift` (`TopToolsBar.as:1320-1321`, `grades >= 6` and `openGift`) or tab 2 | "Diamantes Já Recarregados: {0}" (`charge`), buy levels and charge levels: name "Oferta de Presentes, compra única\n{0} dia(s) a coletar", "Ainda pode coletar: {0} dia(s)", "Recarga atingiu {0} diamantes", items |
| `PublicSummonView` | `funny.view.FunnyBagView.title` | Sum-active type 201 | Tab 3 | Bags of the type 201 activity; claims go through the sum-active engine ([active-framework.md](active-framework.md)) |

---

## 3. Routes (client to server)

### 3.1 Eggs: 9640 (0x25a8) `C_EGG_OP`, body `sumpassion.EggListMsg`

Sender `PublicEggManager.OperateEggReq(op, profile = 0)` (`PEM:150-157`): sets `op (#5, INT32)` and `profile (#6, INT32)` only.

| op | UI control | Sender call site | Client checks | Expected response |
|---|---|---|---|---|
| 1 | View opens | `PublicEggView()` (`M11/publicegg/PublicEggView.as:57-63`) | none | 417 |
| 2 | Egg button: free start (state 0) | `PublicEggItem.__freeHandler` (`PublicEggItem.as:103-107`) | none | 417 with that egg in state 1 and `leftTime` |
| 2 | Egg button: buy now (state 2) | `PublicEggItem.alertHandler` (`:120-131`) | confirm "Deseja consumir {0} diamantes para comprar imediatamente?"; `point >= needPoint` else recharge alert | 417 with the egg opened (state 3 or next); wallet push |
| 2 | Egg button: collect (state 3) | `PublicEggItem.__receiveHandler` (`:133-137`) | none | 417; bag pushes |
| 3 | Score box | `PublicEggView.__allRewardHandler` (`:117-121`) | button enabled when `canTake` | 417 with `allTaked` or new `scoreBoxState`; bag pushes |

### 3.2 Gifts: 9642 (0x25aa) `C_SUMGIFT_OP`, body `sumpassion.SumGiftList`

Sender `PublicEggManager.OperateGiftReq(op, giftType = 0, level = 0)` (`PEM:159-167`): sets `op (#1)`, `giftType (#7)`, `level (#6)`.

| op | UI control | Sender call site | Client checks | Expected response |
|---|---|---|---|---|
| 1 | View opens | `PublicGiftView()` (`PublicGiftView.as:41-47`) | none | 419 with `op = 1` (full list) |
| 2 | Buy (giftType 1) | `PublicGiftItem.alertHandler` (`PublicGiftItem.as:117-127`) | confirm "Deseja consumir {0} diamantes para comprar imediatamente? Após comprar poderá continuar a coletar {1}dia(s)"; `point >= needPoint` | 419 partial (`op != 1`) with the level `isFinish = true`, `canTake` |
| 3 | Collect today (giftType 1 or 2) | `PublicGiftItem.__receiveHandler` (`:136-140`) | button enabled when `canTake` | 419 partial with `takeDays + 1`, `canTake = false`; bag pushes |

---

## 4. Server messages (server to client)

| Opcode | Name | Message | Receiver | When | Reaction |
|---|---|---|---|---|---|
| 416 (0x01a0) | U_C_EGGINFO_OPENSTATE | `simple.PropertyMsg` | `PEM.__openEggStateHandler` (`PEM:52, 66-74`) | Login, start, end | `openEgg1 = param7 && param1 == 1` (combined), `openEgg = param7 && param1 == 0` (standalone); refresh tool bar |
| 417 (0x01a1) | U_C_EGGINFO | `sumpassion.EggListMsg` | `PEM.__egglistHandler` (`PEM:51, 57-64`) | Response to every 9640; push when an egg countdown ends *(optional)* | Replaces the cached list, fires `PUBLIC_EGG_UPDATE` |
| 418 (0x01a2) | U_C_SUMGIFT_OPENSTATE | `simple.PropertyMsg` | `PEM.__openGiftStateHandler` (`PEM:54, 125-133`) | Login, start, end | Same as 416 for gifts |
| 419 (0x01a3) | U_C_SUMGIFT | `sumpassion.SumGiftList` | `PEM.__giftlistHandler` (`PEM:53, 76-123`) | Response to every 9642; push on recharge and at 0h | `op == 1` replaces the list; any other `op` merges `isFinish`, `takeDays`, `canTake` by `levelId` into the cached lists (the view ignores the update until a full list was received, `PublicGiftView.as:83`) |

Fields:

| Message | Fields |
|---|---|
| `EggListMsg` | `egg` (#1, EggMsg, repeated); `scoreBoxState` (#2, STRING) not read; `openTime` (#3, STRING); `stopTime` (#4, STRING) event end for the countdown; `op` (#5, INT32); `profile` (#6, INT32); `scoreBoxShow` (#7, STRING) "current\|needed"; `boxRewardsTemps` (#8, EggItemMsg, repeated) score box rewards; `canTake` (#9, BOOL) score box claimable; `allTaked` (#10, BOOL) |
| `EggMsg` | `profile` (#1, INT32) egg id; `isFree` (#2, BOOL); `buttonState` (#3, INT32) 0 can start, 1 opening, 2 buy now, 3 collect; `leftTime` (#4, INT32) seconds left while opening; `needPoint` (#5, INT32) diamonds to buy; `boxRewardState` (#6, INT32) 1 extra box claimable; `randomOpenTemps` (#7, EggItemMsg, repeated) item pool; `boxRewardsTemps` (#8, EggItemMsg, repeated) extra box; `needTime` (#9, INT32) minutes to open |
| `EggItemMsg` | `id` (#1, INT32); `templateId` (#2, INT32); `counts` (#3, INT32); `isOpen` (#4, BOOL) already obtained; `isHiden` (#5, BOOL) hidden in the preview |
| `SumGiftList` | `op` (#1, INT32); `openTime` (#2, STRING); `stopTime` (#3, STRING); `buyLevel` (#4, LevelMsg, repeated) giftType 1; `chargeLevel` (#5, LevelMsg, repeated) giftType 2; `level` (#6, INT32); `giftType` (#7, INT32); `charge` (#8, INT32) recharge during the event |
| `LevelMsg` | `levelId` (#1, INT32); `needPoint` (#2, INT32) price (type 1) or recharge needed (type 2); `isFinish` (#3, BOOL) bought or reached; `takeDays` (#4, INT32) days collected; `maxTakeDays` (#5, INT32); `canTake` (#6, BOOL) collectable today; `item` (#7, GiftItemMsg, repeated); `name` (#8, STRING), `desc` (#9, STRING) not read |
| `GiftItemMsg` | `templateId` (#2, INT32); `counts` (#3, INT32) (no tag 1) |

---

## 5. Rules and formulas

- Egg cycle: state 0 → op 2 starts the countdown of `needTime` minutes (state 1) → when `leftTime` reaches 0 the egg is collectable (state 3) → op 2 collects one random not yet obtained item from `randomOpenTemps` *(assumption)* and returns to state 0 or 2. State 2 means the free start is used up and the egg can be bought instantly for `needPoint` diamonds *(assumption from the button set)*. When every item of an egg is `isOpen`, `boxRewardState = 1` and the extra box can be claimed *(assumption: claimed by op 2 on that egg)*.
- Score box: progress "cur\|need" in `scoreBoxShow`; op 3 claims when `canTake` *(assumption: progress = eggs opened)*.
- Gifts type 1: pay `needPoint` once, then collect once per day for `maxTakeDays` days. Type 2: when `charge >= needPoint` the level is reached; collect once per day for `maxTakeDays` days. Daily flag resets at 0h.
- Tool bar visibility requires `grades >= 6`.

---

## 6. Templates

None in XML. The egg and gift definitions are server configuration (all item lists travel in the messages).

---

## 7. Persistent state (PostgreSQL, schema `seasonal_events`)

```sql
CREATE TABLE seasonal_events.summer_eggs (
  window_id    integer  NOT NULL REFERENCES seasonal_events.event_windows(window_id),
  player_id    bigint   NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  profile      smallint NOT NULL,
  state        smallint NOT NULL DEFAULT 0 CHECK (state BETWEEN 0 AND 3),
  opens_at     timestamptz,
  obtained_ids integer[] NOT NULL DEFAULT '{}',
  box_claimed  boolean  NOT NULL DEFAULT false,
  PRIMARY KEY (window_id, player_id, profile)
);

CREATE TABLE seasonal_events.summer_egg_scores (
  window_id   integer NOT NULL,
  player_id   bigint  NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  progress    integer NOT NULL DEFAULT 0,
  claimed     boolean NOT NULL DEFAULT false,
  PRIMARY KEY (window_id, player_id)
);

CREATE TABLE seasonal_events.summer_gifts (
  window_id   integer  NOT NULL,
  player_id   bigint   NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  gift_type   smallint NOT NULL CHECK (gift_type IN (1,2)),
  level_id    integer  NOT NULL,
  unlocked    boolean  NOT NULL DEFAULT false,
  take_days   smallint NOT NULL DEFAULT 0,
  last_take   date,
  PRIMARY KEY (window_id, player_id, gift_type, level_id)
);

CREATE TABLE seasonal_events.summer_gift_charges (
  window_id   integer NOT NULL,
  player_id   bigint  NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  charge      integer NOT NULL DEFAULT 0,
  PRIMARY KEY (window_id, player_id)
);
```

---

## 8. Backend implementation notes

| Handler | Route | Validation and effects |
|---|---|---|
| `seasonal_events::public_egg::handle_egg_list` | 9640 op 1 | 417 |
| `seasonal_events::public_egg::handle_egg_action` | 9640 op 2 | by egg state: 0 start (set `opens_at`), 2 spend `needPoint` and open, 3 grant one item, extra box when all obtained; 417 |
| `seasonal_events::public_egg::handle_score_box` | 9640 op 3 | progress >= need → not claimed; 417 |
| `seasonal_events::public_egg::handle_gift_list` | 9642 op 1 | 419 `op 1` |
| `seasonal_events::public_egg::handle_gift_buy` | 9642 op 2 | giftType 1 → not bought → diamonds; 419 partial |
| `seasonal_events::public_egg::handle_gift_take` | 9642 op 3 | unlocked → `take_days < maxTakeDays` → not taken today → bag; 419 partial |

- Hooks: recharge updates `summer_gift_charges` and pushes 419 partial for levels that became reachable.
- Schedules: 416 and 418 broadcast at start and end (with `param1` = 0 standalone or 1 combined); daily reset of `canTake`.

---

## 9. Open questions and assumptions

- *(assumption)* Exact egg state machine (which state follows a collect, what "isFree" changes).
- *(assumption)* Score box progress source.
- `EggListMsg.scoreBoxState`, `LevelMsg.name/desc` are never read.
- The rest of package `sumpassion` belongs to other features: `EncoGoldListMsg`/`EncoDayMsg` (`EncoGoldManager`, tool bar `encoGold`) and `SumCampaignTaskListMsg`/`TaskMsg`/`ItemMsg` (`SumCampaignManager`, tool bar `sumcampaign`); see the ownership table in [active-framework.md](active-framework.md).

---

## 10. Implementation checklist

- [ ] Tool bar buttons 2027, 2028, 2029 with `param1` mode
- [ ] Combined frame, egg frame, gift frame, confirm frame, summon tab (type 201)
- [ ] 9640 ops 1, 2, 3
- [ ] 9642 ops 1, 2, 3
- [ ] 416, 417, 418, 419 (full and partial)
- [ ] Tables `summer_eggs`, `summer_egg_scores`, `summer_gifts`, `summer_gift_charges`
- [ ] Egg countdown and daily reset
- [ ] Tests: buy without diamonds, collect before countdown, take twice per day, take after `maxTakeDays`
