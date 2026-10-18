# Divine weapon roulette ("Roleta da Arma Divina", artifact gift activity)

Feature `divine-weapon`, module `gift-roulette`. A time-limited monetization event: diamonds spent on the event's packages give "pontos de arma divina"; every completed point step grants one spin of a 10-box roulette; each box can be won only once; after all 10 boxes the player claims one final prize; a reset (one per day) restarts the progress and the roulette. Client package `artifact` (`m11/scripts/artifact`), proto package `artifactgiftactivity`.

Conventions:
- Paths are relative to `decompiled/` unless they start with `raw/`, `protocol/`, `index/` or `docs/`. `CM` = `core_module/scripts`, `M11` = `m11/scripts`.
- Opcode names come from `protocol/opcodes.csv`. Proto fields come from `protocol/proto.json`; tags checked against the AS3 `writeTo` in `CM/com/road/yishi/proto/artifactgiftactivity/*.as` and `CM/com/road/yishi/proto/step/*.as`.
- *(assumption)* marks anything the client does not prove.
- No HTTP servlet or AMF call is used. The roulette data has no XML template; everything comes from server pushes.

---

## 1. Overview

- **Entry.** Top tool bar button `artifact` (tip "Roleta da Arma Divina", `ui.toptoolbar.TopToolsBar.tipData_artifact`), visible when hero level >= 11 and `ArtifactManager.openArtifact` (`CM/ui/toptoolbar/TopBtnCheckShowHelper.as:285-286`). Click → `openControllerByInfo("artifact")` (`CM/ui/toptoolbar/TopToolsBar.as:1277-1278`) → `ArtifactControler` (`CM/mvc/controler/ArtifactControler.as:20-50`, preloads `15.png`, also loads the `shop` UI module, `CM/yishi/manager/FrameControllerManager.as:1127-1128`).
- **Open flag.** `openArtifact = template.open && now < template.end_time` set on every 323 (`CM/yishi/manager/ArtifactManager.as:148-157`), followed by `REFRESH_TOPTOOLS`.
- **Points.** "Comprando pacote da área correspondente poderá obter pontos de arma divina\n Cada 1 diamante consumido obterá 1 ponto." (`artifact.ArtifactProgressView.descriptTxt`). The packages are shop goods of type 7 shown in the frame.
- **Steps.** "Sempre que completar um nível tem a chance de sortear uma vez" (`artifact.ArtifactBoxView.progressStrip`).
- **Roulette.** 10 boxes; "Não obterá prêmios de roleta repetidos" (`lotteryBtnStrip`).
- **Final prize.** "Após coletar os prêmios da rolelata, poderá obter 1 dos prêmios abaixo:" (`receiveStrip`).
- **Reset.** "Redefinição de pontos da barra de progresso, prêmios de roleta e imagens." (`resetBtnStrip`); "Diariamente às 0h adicionará 1 chance de redifinição" (`resetTxtStrip`).

---

## 2. Screens

| Class (file) | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `artifact.ArtifactFrame` (`M11/artifact/ArtifactFrame.as`), 875x620 | "Roleta da Arma Divina" (`view.ArtifactFrame.titleText`, :49) | Event frame with three parts | Top bar button | Rebuilt on every 323 (`ARTIFACT_TEMP_REFRESH`, :63, 82-93). Cannot be closed while a spin is running (`artifactOpen`, :105-115) |
| `artifact.ArtifactShopView` (`M11/artifact/ArtifactShopView.as`) | image `asset.artifact.shopNote` | Event packages | Inside the frame | `ShopManager.model.artifactList` (shop goods of type 7, `CM/mvc/module/shop/ShopModel.as:555-559`) with `remainTime > 0`, 4 per page (:110-158); item widget `view.GoodsItem9` (`m15/scripts/view/GoodsItem9.as`) |
| `yishi.view.frame.ArtifactBuyFrame` (`CM/yishi/view/frame/ArtifactBuyFrame.as`), style `artifact.buyFrame` | buy frame (shop texts "shop.view.GoodsItem.limited05/07") | Buy a package for self or as a gift | `GoodsItem9` buy button via `ShopManager.quickUIcallback` (`CM/managers/ShopManager.as:274-299`) | Price in diamonds (`PayMoney = playerInfo.point`, :97-100), limit counts (:79-95) |
| `artifact.ArtifactProgressView` (`M11/artifact/ArtifactProgressView.as`) | images `asset.artifact.resetNote1..3` | Progress and reset | Inside the frame | Reset count (`resetNum`), spins left (`lotteryNum`), bar `score / next step value` or "max" (:159-188); tip "Sempre que completar um nível tem a chance de sortear uma vez\nNível atual/Nível total: {0}/{1}\nPontos totais necessários: {2}/{3}" (:185-186); remaining time "Contagem do Evento: {0}" or "Evento expirado" (:190-206) |
| `artifact.ArtifactBoxView` + `ArtifactBoxItem` (`M11/artifact/ArtifactBoxView.as`, `ArtifactBoxItem.as`) | none | Roulette | Inside the frame | 10 boxes at fixed positions (`_posArr`, :61) from 323 `lotteryItem` (item icon, count, `pos`) (:125-151); drawn boxes grey (:239-270); spins left; open-chest movie frame `c{drawnCount}` (:164-165); spin button; receive button for the final prize (:189-194); tip listing the final prizes (:166-187) |

Tips and alerts: "Obteve {0} x{1}" after a spin (`artifact.ArtifactBoxView.alertRewardTxt`, :197-206); reset alerts "Ainda tem {0} chance(s) de sortear, não é possível redefinir.", "Ainda tem um pacote de armas divinas para coletar, não é possível redefinir.", "Deseja redefinir?" (`resetAlertContent1..3`).

---

## 3. Routes (client to server)

The three roulette actions use **9580 (0x256c) C_ARTIFACT_GIFT_ACTIVITY** with `artifactgiftactivity.ArtifactGiftActivityOpMsg { op (#1, ENUM ArtifactGiftActivityOpState) }`, sent by `ArtifactManager.OperateArtifact(op)` (`CM/yishi/manager/ArtifactManager.as:250-256`). Enum values (`CM/com/road/yishi/proto/artifactgiftactivity/ArtifactGiftActivityOpState.as:6-10`): 0 RESET, 1 LOTTERY, 2 REWARD. There is **no** load request; all state arrives by push.

| # | UI control | Client sender (file:line) | Client checks, in order | Request | Expected response |
|---|---|---|---|---|---|
| G1 | Spin button | `ArtifactBoxView.__lotteryBtnHandler` (`M11/artifact/ArtifactBoxView.as:278-283`) | Button enabled only when `lotteryNum > 0` (:191, 202). On click the button is disabled and the frame and keyboard are locked (`closeEnable = false`, :298-312) | `{op=1}` | **322** with `lotteryNum - 1` and the drawn `pos` appended to `lotteryItems`, then **326** `{op=1, result=true, item=[{itemId, itemCount, pos}], lottery_pos=pos}`; bag push with the prize (inventory area). The client spins to the box whose `pos == lottery_pos` (:221-234) and, when the movie ends (`ArtifactBoxItem.onFrameEnd`, `M11/artifact/ArtifactBoxItem.as:71-76`), shows "Obteve {0} x{1}" and unlocks using the last 322 (:197-206) |
| G2 | Receive button (final prize) | `ArtifactBoxView.__receiveBtnHandler` (:272-276) | Visible only when `lotteryItems.length == 10` (box count) and `!rewarded` (:192, 203) | `{op=2}` | **322** with `rewarded = true` (hides the button, :189-194), **326** `{op=2, result=true, item=[prize]}` (ignored by the client), bag push |
| G3 | Reset button | `ArtifactProgressView.__resetBtnHandler` → `responseOperate` (`M11/artifact/ArtifactProgressView.as:115-157`) | 1. button enabled when `resetNum > 0` (:171); 2. `lotteryNum > 0`: alert 1, stop; 3. all 10 drawn and not rewarded: alert 2, stop; 4. confirm "Deseja redefinir?"; 5. not while spinning (`artifactOpen`, :151-154) | `{op=0}` | **322** with `score=0, scoreStep=0, lotteryItems=[], rewarded=false, resetNum-1`, then **326** `{op=0, result=true}` (the client re-greys the boxes from the cached 322 after 200 ms, :208-220) |
| G4 | Buy a package in the event shop | `GoodsItem9.__clickHandler` (`m15/scripts/view/GoodsItem9.as:98-109`) → `ShopManager.getGoodsBuyNum(id, 7)` (`CM/managers/ShopManager.as:930-940`) → `ArtifactBuyFrame.__confirmHandler` (`CM/yishi/view/frame/ArtifactBuyFrame.as:102-150`) → `ShopManager.buyOne` (`ShopManager.as:1205-1219`) | Not while spinning (`GoodsItem9.as:100-103`); price <= diamonds else recharge alert (`ArtifactBuyFrame.as:112-117`); self or gift | **8693 (0x21f5) C_BUY_DISCOUNT** `shop.ShopMsg{buyInfo{goodId, type=7, isDiscount=true}}`, then **8970 (0x230a) C_SHOPCAR_BUY** `shop.ShopCarListMsg` | **4599 (0x11f7) U_C_BUY_DISCOUNT** (bought count, type 7), **90 (0x005a) U_C_SHOP_BUY**; then this module's **322** with the new `score`/`scoreStep`/`lotteryNum`. Routes owned by [../shops/README.md](../shops/README.md); the shops handler must call `divine_weapon::gift_roulette::add_points(player, diamonds_spent)` |

---

## 4. Server messages (server to client)

| Opcode | Name | Message | Client receiver (file:line) | When to send | Client effect |
|---|---|---|---|---|---|
| 321 (0x0141) | U_C_STEP_MSG | `step.StepListMsg{type (#1, INT32), step (#2, StepMsg, repeated)}`; `StepMsg{Id (#1, INT32), Name (#2, STRING), Type (#3, INT32), Step (#4, INT32) step number 1..N, Value (#5, INT32) points needed for that step}` | `ArtifactManager.__stepTempHandler` (`CM/yishi/manager/ArtifactManager.as:62, 68-113`) | Login, and when the activity configuration changes | `type == 0`: keep only steps with `StepMsg.Type == 1`; `type == 1`: keep all. Stored by `Step` number. *(recommendation: send `type = 1` with the roulette steps only)* |
| 323 (0x0143) | U_C_ARTIFACT_GIFT_ACTIVITY_TEMPLATE_MSG | `ArtifactGiftActivityTemplateMsg{lotteryItem (#1, LotteryItemInfoMsg, repeated) the 10 boxes, rewardItem (#2, LotteryItemInfoMsg, repeated) final prize choices, open (#3, BOOL), end_time (#4, INT64) epoch milliseconds}`; `LotteryItemInfoMsg{itemId (#1, INT32), itemCount (#2, INT32), pos (#3, INT32) box id}` | `ArtifactManager.__boxTempHandler` (:63, 115-158) | Login, at activity start and end, and on configuration change | Replaces boxes and prizes, sets `openArtifact`, rebuilds an open frame, refreshes the top bar. `lotteryItem` must have exactly 10 entries, or 0 (`ArtifactBoxView.as:125-151` reads indices 0..9) |
| 322 (0x0142) | U_C_ARTIFACT_GIFT_ACTIVITY_MSG | `ArtifactGiftActivityMsg{UserId (#1, INT32), Score (#2, INT32) points inside the current step, ScoreStep (#3, INT32) completed steps, LotteryNum (#4, INT32) spins left, lotteryItems (#5, INT32, repeated) drawn box `pos` values, ResetNum (#6, INT32) resets left, rewarded (#7, BOOL) final prize claimed}` | `ArtifactManager.__activityMsgHandler` (:64, 160-167) | Login (while the activity exists), after G1/G2/G3, after every point gain, after the daily reset grant | Stores the state and fires `ARTIFACT_MSG_RECORD` (progress view, box view) |
| 326 (0x0146) | U_C_ARTIFACT_GIFT_ACTIVITY | `ArtifactGiftActivityResMsg{op (#1, ENUM), result (#2, BOOL), item (#3, LotteryItemInfoMsg, repeated), lottery_pos (#4, INT32)}` | `ArtifactManager.__activityOperateHandler` (:65, 169-175) → `ArtifactBoxView.__activityResultHandler` (`M11/artifact/ArtifactBoxView.as:208-237`) | Response to every 9580 | `op 0 && result`: re-grey boxes; `op 1 && result`: spin to `lottery_pos`, prize = `item[0]`; anything else: ignored |

**Result handling risk.** If a spin (op 1) is answered with `result = false`, the client never unlocks the frame or the keyboard (`closeEnable` stays false) until it is reopened. The server must validate exactly the client preconditions and only reject forged requests.

**Order.** Send 322 before 326. For op 0 the box view re-greys from its cached 322 200 ms after 326 (:211-220); for op 1 the button state after the spin is read from the cached 322 (:202-204).

---

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Visibility | hero level >= 11, `open == true`, `now < end_time` | `TopBtnCheckShowHelper.as:285-286`; `ArtifactManager.as:148-157` |
| Points | 1 point per diamond spent on type-7 shop packages | `artifact.ArtifactProgressView.descriptTxt` |
| Package list | shop discount goods with `type == 7`, `oneDayCount = maxCount`, shown while `remainTime > 0` | `ShopModel.as:555-559`; `ArtifactShopView.as:116-126` |
| Steps | ordered by `Step` 1..N; step k needs `Value_k` points; max step = highest `Step`; total = Σ Value | `ArtifactManager.as:197-248` |
| Score bookkeeping | `score` = points inside the current step; on reaching `Value(scoreStep+1)`: `scoreStep += 1`, `lotteryNum += 1`, `score -= Value` (repeat); after the last step the bar shows "max" *(assumption: extra points are discarded at max)* | `ArtifactProgressView.as:172-186`; `getCurrentTotalScore` `ArtifactManager.as:237-248` |
| Spin | picks one box whose `pos` is not in `lotteryItems`; `lotteryNum -= 1`; prize = that box's item and count. Probabilities are server-side and unknown *(assumption: weighted per box, default uniform)* | `lotteryBtnStrip`; `ArtifactBoxView.as:239-270` |
| Final prize | allowed once when all 10 boxes are drawn; gives **one** of `rewardItem` *(assumption: random, weighted)*; sets `rewarded` | `receiveStrip`; `ArtifactBoxView.as:192` |
| Reset | requires `resetNum > 0`, `lotteryNum == 0`, and not (`lotteryItems.length == 10 && !rewarded`); clears `score`, `scoreStep`, `lotteryItems`, `rewarded`; `resetNum -= 1` | `ArtifactProgressView.as:115-157`; `resetBtnStrip` |
| Daily reset grant | +1 `resetNum` at 00:00 server time *(assumption: no cap given; cap at 1 unused grant is not stated)* | `resetTxtStrip` |
| Frame lock | while spinning, closing the frame, buying packages and resetting are blocked; keyboard disabled | `ArtifactBoxView.as:298-312`; `ArtifactFrame.as:105-115`; `GoodsItem9.as:100-103`; `ArtifactProgressView.as:151-154` |
| Remaining time | `end_time/1000 - sysCurTimeBySecond`; "Evento expirado" when <= 0 | `ArtifactProgressView.as:190-206` |

---

## 6. Templates

No XML template exists for this module (no `ArtifactGift*` file in `raw/xml/tempinfos`). The configuration (boxes, final prizes, steps, dates, package list) is server data, pushed by 321 and 323; the packages come from the shop discount list. Item names and icons come from `raw/xml/tempinfos/ItemTempInfos.xml`.

---

## 7. Persistent state (PostgreSQL, schema `divine_weapon`)

```sql
-- Activity instances (configured by operators).
CREATE TABLE divine_weapon.gift_activities (
    activity_id  INTEGER     GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    starts_at    TIMESTAMPTZ NOT NULL,
    ends_at      TIMESTAMPTZ NOT NULL,
    is_open      BOOLEAN     NOT NULL DEFAULT TRUE,
    CHECK (ends_at > starts_at)
);
CREATE INDEX gift_activities_window ON divine_weapon.gift_activities (starts_at, ends_at);

-- The 10 roulette boxes.
CREATE TABLE divine_weapon.gift_activity_boxes (
    activity_id  INTEGER  NOT NULL REFERENCES divine_weapon.gift_activities(activity_id) ON DELETE CASCADE,
    pos          INTEGER  NOT NULL,
    item_id      INTEGER  NOT NULL,
    item_count   INTEGER  NOT NULL CHECK (item_count > 0),
    weight       INTEGER  NOT NULL DEFAULT 1 CHECK (weight > 0),
    PRIMARY KEY (activity_id, pos)
);

-- Final prize choices.
CREATE TABLE divine_weapon.gift_activity_final_rewards (
    activity_id  INTEGER  NOT NULL REFERENCES divine_weapon.gift_activities(activity_id) ON DELETE CASCADE,
    idx          SMALLINT NOT NULL,
    item_id      INTEGER  NOT NULL,
    item_count   INTEGER  NOT NULL CHECK (item_count > 0),
    weight       INTEGER  NOT NULL DEFAULT 1 CHECK (weight > 0),
    PRIMARY KEY (activity_id, idx)
);

-- Point steps.
CREATE TABLE divine_weapon.gift_activity_steps (
    activity_id  INTEGER  NOT NULL REFERENCES divine_weapon.gift_activities(activity_id) ON DELETE CASCADE,
    step         SMALLINT NOT NULL CHECK (step >= 1),
    name         TEXT     NOT NULL DEFAULT '',
    points       INTEGER  NOT NULL CHECK (points > 0),
    PRIMARY KEY (activity_id, step)
);

-- Per player progress.
CREATE TABLE divine_weapon.gift_activity_players (
    activity_id          INTEGER  NOT NULL REFERENCES divine_weapon.gift_activities(activity_id) ON DELETE CASCADE,
    player_id            BIGINT   NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
    score                INTEGER  NOT NULL DEFAULT 0 CHECK (score >= 0),
    score_step           SMALLINT NOT NULL DEFAULT 0 CHECK (score_step >= 0),
    lottery_num          INTEGER  NOT NULL DEFAULT 0 CHECK (lottery_num >= 0),
    reset_num            INTEGER  NOT NULL DEFAULT 0 CHECK (reset_num >= 0),
    rewarded             BOOLEAN  NOT NULL DEFAULT FALSE,
    last_reset_grant_on  DATE,
    updated_at           TIMESTAMPTZ NOT NULL DEFAULT now(),
    PRIMARY KEY (activity_id, player_id)
);

-- Boxes drawn in the current cycle (cleared by a reset).
CREATE TABLE divine_weapon.gift_activity_draws (
    activity_id  INTEGER     NOT NULL,
    player_id    BIGINT      NOT NULL,
    pos          INTEGER     NOT NULL,
    drawn_at     TIMESTAMPTZ NOT NULL DEFAULT now(),
    PRIMARY KEY (activity_id, player_id, pos),
    FOREIGN KEY (activity_id, player_id)
        REFERENCES divine_weapon.gift_activity_players (activity_id, player_id) ON DELETE CASCADE,
    FOREIGN KEY (activity_id, pos)
        REFERENCES divine_weapon.gift_activity_boxes (activity_id, pos)
);
```

---

## 8. Backend implementation notes

| Handler | Op | Validation order | Transaction | Pushes |
|---|---|---|---|---|
| `divine_weapon::gift_roulette::handle_reset` | 0 | active activity (`is_open`, now in window); level >= 11; `reset_num > 0`; `lottery_num == 0`; not (10 drawn and not rewarded) | one transaction: zero score, step, rewarded; delete draws; `reset_num -= 1` | 322, then 326 `{op 0, result true}` |
| `divine_weapon::gift_roulette::handle_lottery` | 1 | active activity; `lottery_num > 0`; fewer than 10 drawn | one transaction (row lock on the player row): weighted pick among undrawn boxes, insert draw, `lottery_num -= 1`, grant the item (inventory service) | 322, 326 `{op 1, result true, item [box], lottery_pos}`, bag update |
| `divine_weapon::gift_roulette::handle_reward` | 2 | active activity; 10 drawn; not rewarded | one transaction: weighted pick of one final prize, grant, `rewarded = true` | 322, 326 `{op 2, result true, item [prize]}`, bag update |
| `divine_weapon::gift_roulette::add_points` (service, called by shops on a type-7 purchase) | none | active activity; level >= 11 *(assumption)* | inside the shop purchase transaction: `score += diamonds`, step loop (`lottery_num += 1` per completed step) | 322 |

- **Login.** If an activity exists (open or recently closed), push 321, 323, 322 in that order. If none, push 323 with `open = false` so the top bar hides *(assumption: the original may simply not send anything)*.
- **Schedules.** At `starts_at` and `ends_at` push 323 to all online players. At 00:00 grant `reset_num += 1` (lazily on login or first access using `last_reset_grant_on`, and eagerly for online players followed by 322).
- **Rejections.** Never answer a valid-looking op 1 with `result = false` (client lock-up); reject only forged requests and log them.
- No battle.

---

## 9. Open questions and assumptions

1. Box and final-prize probabilities are unknown *(assumption: weights in the tables, default uniform)*.
2. Whether the final prize is random or player-chosen; the text "poderá obter 1 dos prêmios abaixo" and the single button suggest random *(assumption)*.
3. Whether `reset_num` accumulates without cap.
4. Whether points earned past the last step are kept or discarded.
5. `StepListMsg.type` semantics: type 0 filters `StepMsg.Type == 1`; other step lists may share 321 in the original server.
6. Which purchases count: only type-7 packages of this frame *(assumption)*, or every diamond spend during the event.
7. Gift purchases (bought for a friend through `GiftDonatioFrame`): who receives the points is unknown *(assumption: the buyer)*.
8. Initial `reset_num` for a new participant is unknown *(assumption: 1 on the first day)*.

---

## 10. Implementation checklist

- [ ] Tables `gift_activities`, `gift_activity_boxes`, `gift_activity_final_rewards`, `gift_activity_steps`, `gift_activity_players`, `gift_activity_draws`.
- [ ] Operator tooling or seed for an activity (10 boxes, prizes, steps, window).
- [ ] Encoders: 321 `StepListMsg` (type 1), 323 `ArtifactGiftActivityTemplateMsg` (INT64 ms end time), 322 `ArtifactGiftActivityMsg`, 326 `ArtifactGiftActivityResMsg`.
- [ ] Decoder for 9580 `ArtifactGiftActivityOpMsg` (enum op 0/1/2).
- [ ] Route G1 spin, G2 final prize, G3 reset, with 322 before 326.
- [ ] `add_points` hook in the shops purchase handler for type-7 goods (G4).
- [ ] Login push sequence and start/end broadcasts of 323.
- [ ] Daily reset grant job.
- [ ] Tests: spin without spins rejected; no duplicate box; 10 draws then final prize once; reset blocked with spins left or unclaimed prize; step loop grants multiple spins for a large purchase; top bar hides after `end_time`.
