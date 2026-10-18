# Super sign in card ("Super cartão de check-in")

Area: daily-activity, module `super-sign-in-card`. Covers `managers.SuperSigninCardManager`, `mvc.module.supersignincard.SuperSigninCardModel`, `supersignincard.SuperSigninCardFrame`, `SuperSigninCardItem` (m11), `mvc.controler.SuperSigninCardController`, the "CCC" activity route 9645 with header `extend1 = 38` (`CCCActiveType.SUPER_SIGNIN_CARD`), and the top toolbar push 4590 for button template 2059.

Conventions: see [README.md](README.md).

## 1. Overview

A timed paid event (top toolbar "Super cartão de check-in", template 2059 "超级签到卡"). The player activates the card once for diamonds; the card then lasts 8 days ("O Cartão de Check-in dura 8 dias, desaparecendo após isso"). Each card day has a reward pack (up to 8 items) that can be collected when the day has arrived ("Só pode retirar os prêmios dos dias acumulados, conecte-se para retirar"); a missed day can be signed retroactively for diamonds ("Deseja gastar {0} diamantes para realizar check-in retroativo?").

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `supersignincard.SuperSigninCardFrame` (`decompiled/m11/scripts/supersignincard/SuperSigninCardFrame.as:51`) | "Super cartão de check-in" (`SuperSigninCardFrame.titleText`) | price, activate button (enabled while no day state exists, `refreshView` `:185`), remaining time "Restante: {0}" until `stopTime` (`refreshTime` `:195`), help, one item per template day | top toolbar key `supersignincard` (`decompiled/core_module/scripts/ui/toptoolbar/TopToolsBar.as:1476`), controller `decompiled/core_module/scripts/mvc/controler/SuperSigninCardController.as:14` | `cardPrice`, `tempDic`, `stateDic`, `stopTime` |
| `supersignincard.SuperSigninCardItem` (`decompiled/m11/scripts/supersignincard/SuperSigninCardItem.as:39`) | day number, "receive", "received", "sign in" buttons | state 0: receive disabled; 1: receive enabled; 3: retro sign button; other (2): received (`refreshView` `:108`) | frame | `tempDic[day]` "templateId,count|..." (`GoodsHelp.getCommonRewardAry` `decompiled/core_module/scripts/yishi/utils/GoodsHelp.as`), `stateDic[day]` |

Top button visibility: `SuperSigninCardModel.isOpen` (`decompiled/core_module/scripts/ui/toptoolbar/TopBtnCheckShowHelper.as:393`). The frame closes itself when the event closes (`__superSigninCardUpdateHandler` `:173`).

## 3. Routes (client to server)

All routes: C>S 9645 (0x25ad) `C_CCCACTIVE_CLIENTOP`, header `extend1 = 38` (`new PackageOut(9645, 0, 38)`), body `active.SuperSigninCardReqMsg`: `opType (#1, INT32)`, `date (#2, INT32)` card day 1..8. Sender `SuperSigninCardManager.sendRequest(op, date = 0)` `decompiled/core_module/scripts/managers/SuperSigninCardManager.as:105`.

| # | UI control | opType | Client checks | Expected response |
|---|---|---|---|---|
| SC1 | none in this build (constant `OPEN_FRAME = 1`, `:21`) | 1 | | 514 then 513 (assumption) |
| SC2 | "Ativar" (`SuperSigninCardFrame.__activateBtnClickHandler` `:134`, confirm "Deseja gastar {0} diamantes para ativar o Cartão de Check-in?") | 2, `date = 0` | `playerInfo.point >= cardPrice` else recharge popup (`callBack` `:151`) | 3 (diamonds), 513 with all 8 days |
| SC3 | day "receive" (`SuperSigninCardItem.__receiveBtnClickHandler` `:134`) | 3, `date = day` | state 1 | item grants, 513 with that day state 2 |
| SC4 | day "sign in" (`__signinBtnClickHandler` `:139`, confirm with `reSigninPrice`) | 4, `date = day` | `point >= reSigninPrice` else recharge (`callBack` `:149`) | 3, 513 with that day state 1 (assumption: becomes collectable) |

## 4. Server messages (server to client)

### S1. 513 (0x0201) `U_C_SUPER_SIGNIN_CARD`

- `active.SuperSigninCardRespMsg`: `details (#1, SuperSigninDetailMsg, repeated)`; `SuperSigninDetailMsg`: `date (#1, INT32)` card day, `state (#2, INT32)` 0 future, 1 collectable, 2 collected, 3 missed (retro sign available).
- Receiver: `SuperSigninCardManager.__updateSuperSigninCardMsg` `:85` merges into `stateDic` (`SuperSigninCardModel.refreshState` `decompiled/core_module/scripts/mvc/module/supersignincard/SuperSigninCardModel.as:39`). Empty list = not activated.
- When: login while the event is open, after SC2, SC3, SC4, at 00:00.

### S2. 514 (0x0202) `U_C_SUPER_SIGNIN_CARD_TEMP`

- `active.SuperSigninRewardMsg`: `CardPrice (#1, INT32)` diamonds to activate; `ReSigninPrice (#2, INT32)` diamonds per retro sign; `temp (#3, SuperSigninTempMsg, repeated)`; `SuperSigninTempMsg`: `date (#1, INT32)` day 1..8, `itemMsg (#2, STRING)` "templateId,count|templateId,count" (max 8 entries).
- Receiver: `__updateSuperSigninCardTempMsg` `:94`. The frame builds one item per key of `tempDic` (`initItem` `:86`), so 514 must arrive before the frame opens.
- When: login while the event is open.

### S3. 4590 (0x11ee) `U_C_TOP_TOOL_BTN` (shared)

- `simple.PropertyMsg` (fields read from `decompiled/core_module/scripts/com/road/yishi/proto/simple/PropertyMsg.as`): `param1 (#1, INT32)` top toolbar template id; `param4 (#4, STRING)` open time; `param5 (#5, STRING)` stop time "YYYY-MM-DD hh:mm:ss"; `param7 (#7, BOOL)` open.
- Receivers for this feature: `SuperSigninCardManager.__superSigninCardBtnHandler` `:66` (only `param1 == 2059`; closing clears `stateDic`), `YearActiveManager.__topBtnHandler` (`param1 == 2061`, [year-activity.md](year-activity.md)). Other features listen to other ids (for example 4023 in [../customer-service/research-survey.md](../customer-service/research-survey.md)).
- When: login and whenever an event opens or closes.

## 5. Rules and formulas

- Activation once per event; card days 1..8 counted from the activation day (assumption: day 1 = activation day).
- Day state at 00:00: today's day becomes 1 (collectable); a previous day still 0 or 1 that was not collected becomes 3 when the player did not log in that day (assumption from the text "conecte-se para retirar").
- Retro sign (state 3) costs `ReSigninPrice` diamonds and makes the day collectable.
- The countdown uses `stopTime` of 4590 (`refreshTime` `:197`).

## 6. Templates

None in `raw/xml/tempinfos/`; prices and packs come from 514 (server configuration).

## 7. Persistent state

```sql
CREATE TABLE daily_activity.super_sign_card_event (
    event_id        integer     PRIMARY KEY,
    opens_at        timestamptz NOT NULL,
    closes_at       timestamptz NOT NULL,
    card_price      integer     NOT NULL CHECK (card_price >= 0),
    resign_price    integer     NOT NULL CHECK (resign_price >= 0)
);

CREATE TABLE daily_activity.super_sign_card_reward (
    event_id   integer  NOT NULL REFERENCES daily_activity.super_sign_card_event(event_id) ON DELETE CASCADE,
    card_day   smallint NOT NULL CHECK (card_day BETWEEN 1 AND 8),
    items      text     NOT NULL,
    PRIMARY KEY (event_id, card_day)
);

CREATE TABLE daily_activity.super_sign_card (
    player_id     BIGINT     NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
    event_id      integer     NOT NULL REFERENCES daily_activity.super_sign_card_event(event_id),
    activated_at  timestamptz NOT NULL DEFAULT now(),
    PRIMARY KEY (player_id, event_id)
);

CREATE TABLE daily_activity.super_sign_card_day (
    player_id   BIGINT  NOT NULL,
    event_id    integer  NOT NULL,
    card_day    smallint NOT NULL CHECK (card_day BETWEEN 1 AND 8),
    state       smallint NOT NULL CHECK (state BETWEEN 0 AND 3),
    PRIMARY KEY (player_id, event_id, card_day),
    FOREIGN KEY (player_id, event_id) REFERENCES daily_activity.super_sign_card(player_id, event_id) ON DELETE CASCADE
);
```

## 8. Backend implementation notes

- `daily_activity::super_sign_in_card::handle_client_op` (9645, `extend1 == 38`), dispatch on `opType`:
  - 2 activate: event open, not yet activated, debit `card_price` diamonds; create 8 day rows (day 1 state 1, others 0); push 3 and 513.
  - 3 receive: day state 1; set 2 and grant the pack in one transaction; push bag and 513.
  - 4 retro sign: day state 3; debit `resign_price`; set 1; push 3 and 513.
  - 1: reply 514 and 513.
- The 9645 dispatcher is shared with other CCC activities (month card `extend1 = 29`, platinum pot 40, ...); route by `extend1`.
- 00:00 job: advance states for activated cards and push 513 to online players. Event open and close: push 4590 with `param1 = 2059`.

## 9. Open questions and assumptions

- Exact day state machine (when 0 becomes 3) is inferred from texts.
- Whether opType 1 was sent by older clients is unknown.

## 10. Implementation checklist

- [ ] 4590 push for template 2059 on open and close
- [ ] 514 and 513 at login while open
- [ ] Route 9645/38 ops 1 to 4
- [ ] Tables `super_sign_card_event`, `super_sign_card_reward`, `super_sign_card`, `super_sign_card_day`
- [ ] Daily state job
- [ ] Test: activate twice refused, receive future day refused, retro sign cost
