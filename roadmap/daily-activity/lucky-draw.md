# Lucky draw ("Sorteio da Sorte")

Area: daily-activity, module `lucky-draw`. Covers route 9523 `C_LEAD_EXTRACT` with `leed.LeadRewardMsg`, its answer 4936 `U_C_LEAD_EXTRACT`, the wheel frames `dayguide.GroupLuckFrame` and `dayguide.LuckDrawView`, the turn animation `dayguide.manager.DayGuideTurnControl`, `dayguide.LuckDrawGoodsItem`, and the missing template `LeadReward`.

Conventions: see [README.md](README.md).

## 1. Overview

A 9 slot wheel: the player spends one draw, the wheel spins to the won slot and the item flies to the bag. Two flavors share the same route:

- Group buy wheel (live): every successful group buy settlement grants one draw ("Comprando com sucesso poderá obter uma chance de sorteio, pode acumular chances de sorteio."). Opened from the group buy view of the "funny" event screen; the 9 slots and the remaining draws come from the group buy server (338). Owner of the group buy itself: [../shops/group-buy.md](../shops/group-buy.md).
- Daily lucky draw (dormant): `LuckDrawView` gave draws from daily activity points and VIP ("1. Jogadores VIP podem obter 2 sorteios por dia. 2. Ao atingir 15, 45, 85, 115 pode obter uma chance sorteio. 3. O número de sorteios é redefinido diariamente"). No reachable screen creates `LuckDrawView` in this build.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `dayguide.GroupLuckFrame` (`decompiled/m11/scripts/dayguide/GroupLuckFrame.as:74`) | "Sorteio da Sorte" (`dayguide.GroupLuckFrame.titleText`), warning `dayGuide.view.GroupLuckFrameWarn` | 9 `LuckDrawGoodsItem` slots (scale 0.6), draw button, remaining draws | `FrameControllerManager` key `funny` with open type `FunnyControler.LUCKVIEW` (3) (`decompiled/core_module/scripts/mvc/controler/FunnyControler.as:64`), from `GroupBuyView.zhuanpanResultHandler` `decompiled/core_module/scripts/funny/groupbuy/GroupBuyView.as:475` | `VipItemInfoMsg` list (`show(items)` `:304`), `funnyControler.luckDrawCount` |
| `dayguide.LuckDrawView` (`decompiled/m11/scripts/dayguide/LuckDrawView.as:81`) | draw button, "Sorteios restantes" | daily wheel with `LeadReward` slots | unreachable | `DayGuideCatecory.rewardTemplateId`, `leadExtractTimes`, activity points |

## 3. Routes (client to server)

### D1. Open the group buy wheel

- UI: group buy lucky draw button; the view loads `11.png` and the `dayguide` UI pack, then sends (`GroupBuyView.__onComplete` `decompiled/core_module/scripts/funny/groupbuy/GroupBuyView.as:466-:472`).
- Sender: `FunnyControler.sendLuckDraw(3)` `decompiled/core_module/scripts/mvc/controler/FunnyControler.as:119`.
- Route: C>S 9523 (0x2533) `C_LEAD_EXTRACT`, `leed.LeadRewardMsg`: `op (#1, INT32)` = 3 open; other fields unset.
- Expected response: S>C 338 (0x0152) `U_C_GROUPON_DROPITEM` `vip.VipRouletteMsg` with `left_count` and `leftItem` (9 slots). Message layout in [../shops/group-buy.md](../shops/group-buy.md).

### D2. Spin

- UI: draw button (`GroupLuckFrame._darawBtnHandler` `decompiled/m11/scripts/dayguide/GroupLuckFrame.as:161`; daily: `LuckDrawView._darawHandler` `decompiled/m11/scripts/dayguide/LuckDrawView.as:169`).
- Client checks: a free bag slot ("Mochila cheia, favor organizar"); remaining draws > 0 ("Sorteios restantes insuficientes").
- Route: C>S 9523 `LeadRewardMsg.op = 1`.
- Expected response: S>C 4936 with the won slot.

### D3. Confirm after the animation

- UI: automatic when the spin animation ends (`GroupLuckFrame.__onBlessComplete` `:201`; `LuckDrawView.__onBlessComplete` `:258`, and `LuckDrawView.dispose` `:419` if closed mid spin).
- Route: C>S 9523 `LeadRewardMsg.op = 2`.
- Expected response: none required; assumption: the server delivers the item on op 1 and treats op 2 as an acknowledgement (or delivers on op 2; see section 9).

## 4. Server messages (server to client)

### S1. 4936 (0x1348) `U_C_LEAD_EXTRACT`

- Message `leed.LeadRewardMsg`: `op (#1, INT32)` echo; `templateId (#2, INT32)` won item template; `leadExtractTimes (#3, INT32)`; `count (#4, INT32)` won item count.
- Receivers:
  - `GroupLuckFrame.__luckDrawHandler` `decompiled/m11/scripts/dayguide/GroupLuckFrame.as:179`: finds the slot whose `temp_id == templateId` and `count == count`, spins to it, sets `funnyControler.luckDrawCount = leadExtractTimes` (so here the field means draws remaining).
  - `DayGuideManager.__luckDrawHandler` `decompiled/core_module/scripts/managers/DayGuideManager.as:407` (always): `cate.rewardTemplateId = templateId`, `cate.leadExtractTimes` and `PlayerInfo.leadExtractTimes = leadExtractTimes` (daily meaning: draws used today). `rewardTemplateId == 0` re-enables the daily wheel button without spinning (`LuckDrawView.__onPosChangeHandler` `:233`).
- When: reply to D2.

## 5. Rules and formulas

- Group buy: one draw per successful settlement, accumulative (warning text); the slot list and weights are server side.
- Slot match: the server must answer with a `templateId` and `count` equal to one of the 9 slots sent in 338, otherwise the wheel stops on slot 0.
- Daily wheel (dormant): draws = (VIP active ? 2 : 0) + (points >= 115 ? 4 : points >= 85 ? 3 : points >= 45 ? 2 : points >= 15 ? 1 : 0) - `leadExtractTimes` (`LuckDrawView.refreshDrawTimes` `:284`); slots from `LeadReward` in dictionary order (`:133`); info tip 27 shows the remaining count.

## 6. Templates

| File | Status | Record |
|---|---|---|
| `LeadReward` (`dayGuideDropTemplateCate`, `decompiled/core_module/scripts/yishi/manager/TempleteManager.as:1171`) | missing in `raw/xml/tempinfos/` | `LeadRewardTempInfo`: `templateId` (`decompiled/core_module/scripts/mvc/module/dayGuide/LeadRewardTempInfo.as:6`) |

## 7. Persistent state

```sql
CREATE TABLE daily_activity.lucky_draw_balance (
    player_id     BIGINT     NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
    source        smallint    NOT NULL CHECK (source IN (1, 2)),
    draws_left    integer     NOT NULL DEFAULT 0 CHECK (draws_left >= 0),
    draws_used    integer     NOT NULL DEFAULT 0,
    period_date   date,
    PRIMARY KEY (player_id, source)
);

CREATE TABLE daily_activity.lucky_draw_pending (
    player_id     BIGINT     PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
    item_template integer     NOT NULL,
    item_count    integer     NOT NULL CHECK (item_count > 0),
    rolled_at     timestamptz NOT NULL DEFAULT now()
);
```

`source` 1 = group buy wheel, 2 = daily wheel (dormant). The group buy feature increments `draws_left` on each settlement.

## 8. Backend implementation notes

- `daily_activity::lucky_draw::handle_extract` (9523), dispatch on `op`:
  - 3: build and send 338 with the 9 configured slots and `left_count = draws_left` (slot table owned by [../shops/group-buy.md](../shops/group-buy.md)).
  - 1: validate `draws_left > 0` and a free bag slot; roll a slot by weight; in one transaction decrement `draws_left` and store `lucky_draw_pending`; reply 4936 `{op: 1, templateId, count, leadExtractTimes: draws_left}`.
  - 2: if a pending row exists, grant the item, delete the row, push the bag update.
- On logout or reconnect with a pending row, grant it (the client also sends op 2 when the frame closes).

## 9. Open questions and assumptions

- Whether the original server granted the item on op 1 or op 2 is unknown; the pending row design is safe for both.
- `leadExtractTimes` has two meanings (remaining in the group wheel, used in the daily wheel). The daily wheel is unreachable, so the group meaning wins.
- Slot weights are unknown.

## 10. Implementation checklist

- [ ] Route 9523 op 3 replies 338
- [ ] Route 9523 op 1 roll, decrement, reply 4936
- [ ] Route 9523 op 2 grant pending item
- [ ] Table `daily_activity.lucky_draw_balance`, `lucky_draw_pending`
- [ ] Group buy settlement increments draws
- [ ] Test: no draws refused, bag full refused, reconnect grants pending
