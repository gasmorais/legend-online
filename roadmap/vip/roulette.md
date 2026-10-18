# VIP roulette ("Roleta VIP")

Path aliases:

| Alias | File |
|---|---|
| VM | `decompiled/core_module/scripts/managers/VIPManager.as` |
| VC | `decompiled/core_module/scripts/mvc/controler/VIPControler.as` |
| VBF | `decompiled/m15/scripts/vip/VipBoxFrame.as` |
| VBI | `decompiled/m15/scripts/vip/VipBoxItem.as` |
| VTC | `decompiled/m15/scripts/vip/VipTurnControl.as` |
| SSM | `decompiled/core_module/scripts/yishi/service/managers/SocketSendManager.as` |
| PBC | `decompiled/core_module/scripts/cell/mediator/playerbag/PlayerBagCellClickMediator.as` |
| GIM | `decompiled/core_module/scripts/cell/view/GoodsItemMenu.as` |

## 1. Overview

The item "Moeda VIP" (208015, SonType 292, "Moeda misteriosa apenas utilizada por VIP") opens an 18 slot board. Each spin costs VIP coins and gives one of the remaining slots; at most 8 slots are won per board. The board can be refreshed (new 18 slots). VIP only (privilege 10).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `vip.VipBoxFrame` (VBF) | "Roleta VIP" | 18 `VipBoxItem` slots on a ring, 8 won slots, buttons start, X start, refresh | `VIPControler.__openBoxHandler` on `vip_open_box` when no VIP frame is open (VC:40-46), openType 3 (`frameClassName` `vip.VipBoxFrame`, VC:71-78) | left count `LeftCount` (VBF:167), coins needed `NeedVipItem` (VBF:170), coins owned = bag count of SonType 292 (VBF:180); red when needed > owned (VBF:217-231); slot contents `BoxTempIdList[i].tempId / count` (VBF:503-514) |

## 3. Routes (client to server)

### V1. Open the roulette (use a VIP coin)
- UI: use item SonType 292 from the bag (PBC:432-442, GIM:438-450, `bag/view/MulItemUseFrame.as:146`); refuse during mop up "mopup.MopupManager.mopupTipData01"; shows a wait mask.
- Sender: `SocketSendManager.sendUseVipMoney` (SSM:202-206).
- Route: send 8521 (0x2149) `C_VIP_COIN_OPEN`, empty body.
- Expected response: 4414 `U_C_OPENVIPROULETTE` with the board (S1).

### V2. Refresh the board
- UI: VBF refresh button (VBF:316-321). Client checks: VIP (VBF:311-315). If fewer than 8 slots were won and the daily "do not ask again" flag is not set, confirm "Ao atualizar redefinirá todos os itens da Roleta, continuar?" (VBF:360-389, stored in `SharedManager.vipBoxRefreshTip`).
- Sender and route: same as V1, 8521 (0x2149), empty body.
- Expected response: 4414 with a new board; the frame posts the summary of the previous board to chat (VBF:424-433, 549-572).

### V3. Spin once
- UI: VBF start button (VBF:323-333). Client checks: VIP else "Você não é VIP, ative primeiro o VIP"; `NeedVipItem <= coins owned` else "Moeda VIP insuficiente"; disables buttons and close.
- Sender: `VIPManager.senVIPRolette(0)` (VM:125-131).
- Route: send 8519 (0x2147) `C_VIPROULETTE`; message `VipRouletteMsg` (vip) with only `op_type` (#7, INT32) = 0.
- Expected response: 4415 `U_C_VIPROULETTE_RESULT` with `is_start = true` and `openIndex[0]` = won slot (S2); bag update.

### V4. Spin all ("X-Roleta")
- UI: VBF quick button: confirm "Habilitar X-Roleta VIP?" (VBF:334-342), then the same coin check (VBF:345-357).
- Sender: `VIPManager.senVIPRolette(1)`.
- Route: send 8519 (0x2147); `op_type` (#7) = 1.
- Expected response: 4415 with `op_type = 1`, every won slot in `openIndex` and `takeItem` (S2); bag update.

## 4. Server messages (server to client)

### S1. 4414 (0x113e) `U_C_OPENVIPROULETTE`
- Message `VipRouletteMsg` (vip): `left_count` (#1, INT32) remaining spins on this board (assumption: 8 minus won); `need_vipItem` (#2, INT32) coins for the next spin; `openIndex` (#3, INT32, repeated) indexes 0..17 already won; `leftItem` (#4, `VipItemInfoMsg`, repeated) the 18 board slots in index order (`temp_id` (#1, INT32) item template, `count` (#2, INT32)); `takeItem` (#5, `VipItemInfoMsg`, repeated) won items in order; `is_start` (#6, BOOL) false; `op_type` (#7, INT32) 0.
- Receiver: `VIPManager._openVipRouletteHandler` (VM:53, 84-105): hides the mask; ignores the message when `leftItem` has fewer than 18 entries; clears dynamic layers; stores `rouletteInfo`; dispatches `vip_open_box` (opens the frame, or `VBF.__refreshHandler` resets an open one, VBF:424-433).
- When: reply to 8521.

### S2. 4415 (0x113f) `U_C_VIPROULETTE_RESULT`
- Message `VipRouletteMsg` as above, after the spin.
- Receivers: `VIPManager._openVipRouletteResultHandler` (VM:54, 68-82) stores it; `VBF._openVipRouletteHandler` (VBF:204, 207-292): `op_type = 1`: shows every `takeItem` in the won slots and greys `openIndex` slots, start buttons disabled at 8 won; `is_start = true`: animates the ring to `openIndex[0]` (`VipTurnControl.turnPlate`) and on completion shows the last `takeItem` (VBF:391-422); otherwise just re-enables the buttons (failure path).
- When: reply to 8519. A refused spin replies `is_start = false` with the unchanged board (assumption, matches the client re-enable path).

Closing the frame asks "Certeza ao sair da Roleta VIP?" (VBF:522-546); on dispose the client posts "Na Roleta VIP, você obteu: ..." to chat channel 3 and warns "Mochila cheia, cheque seu email" when the bag has fewer free slots than won items (VBF:549-578). After closing it returns to the army equip panel (VC:85-94).

## 5. Rules and formulas

- VIP only. Board size 18, at most 8 wins per board (8 won slots, VBF:181-190, 234-238, 394-402).
- Each spin consumes `need_vipItem` items 208015 from the bag (assumption: cost may grow with the spin number; the client always shows the server value).
- X spin consumes coins for all remaining spins at once and wins them all; requires `need_vipItem` (total) coins (assumption: server sends the total in `need_vipItem` before an X spin is possible, client compares only that value).
- Opening or refreshing does not consume a coin (assumption; the item use only opens the board).
- Won items go to the bag; if full, by mail ("Mochila cheia, cheque seu email").
- Board content: drawn by the server from a VIP roulette pool. No template in `raw/xml/tempinfos` describes it (gap); proposed pool table below, seeded from the weekly gift items and VIP shop goods.

## 6. Templates

| File | Record | Fields |
|---|---|---|
| `raw/xml/tempinfos/ItemTempInfos.xml` | item 208015 "Moeda VIP", SonType 292 | the coin |
| none | roulette pool | missing in the client data; server owned |

## 7. Persistent state

```sql
CREATE TABLE vip.roulette_pool (
  id            SERIAL   PRIMARY KEY,
  min_vip_level SMALLINT NOT NULL DEFAULT 1 CHECK (min_vip_level BETWEEN 1 AND 9),
  item_id       INTEGER  NOT NULL,
  count         INTEGER  NOT NULL CHECK (count > 0),
  weight        INTEGER  NOT NULL CHECK (weight > 0)
);

CREATE TABLE vip.roulette_boards (
  player_id     BIGINT      PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
  slots         JSONB       NOT NULL,          -- 18 entries [{item_id, count}]
  won_indexes   SMALLINT[]  NOT NULL DEFAULT '{}',
  spins         SMALLINT    NOT NULL DEFAULT 0 CHECK (spins BETWEEN 0 AND 8),
  created_at    TIMESTAMPTZ NOT NULL DEFAULT now(),
  CHECK (jsonb_array_length(slots) = 18)
);

CREATE TABLE vip.roulette_wins (
  id          BIGSERIAL   PRIMARY KEY,
  player_id   BIGINT      NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  slot_index  SMALLINT    NOT NULL CHECK (slot_index BETWEEN 0 AND 17),
  item_id     INTEGER     NOT NULL,
  count       INTEGER     NOT NULL,
  coins_spent INTEGER     NOT NULL,
  created_at  TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX roulette_wins_player_idx ON vip.roulette_wins (player_id, created_at DESC);
```

## 8. Backend implementation notes

- `vip::roulette::handle_open` (8521): require VIP (else 126); require at least one item 208015 in the bag (assumption); if no board or `spins = 8` or the request comes from the refresh button, draw 18 weighted slots from `vip.roulette_pool` filtered by level and replace the board; reply 4414.
- `vip::roulette::handle_spin` (8519): lock board; require VIP and board; `op_type 0`: require `spins < 8`, consume `need` coins through the inventory service, pick a uniform (or weighted) slot among the not won ones, grant it, update board, insert win; `op_type 1`: repeat for all remaining spins in one transaction with the total cost. Reply 4415 after commit, with bag pushes.
- `need_vipItem` function: constant 1 per spin (assumption), total for X spin = remaining spins.

## 9. Open questions and assumptions

- Gap: roulette item pool, spin cost curve and whether refresh costs anything are not in the client.
- Assumption: `left_count` = remaining spins on the board.
- Assumption: open and refresh are free; a coin is needed only to spin.

## 10. Implementation checklist

- [ ] Screen: board of 18, won slots, coins needed and owned
- [ ] Route V1 8521 from the bag item
- [ ] Route V2 8521 refresh
- [ ] Route V3 8519 op 0
- [ ] Route V4 8519 op 1
- [ ] Server message S1 4414 with exactly 18 slots
- [ ] Server message S2 4415 spin and X spin variants
- [ ] Table `vip.roulette_pool` (seeded)
- [ ] Table `vip.roulette_boards`
- [ ] Table `vip.roulette_wins`
- [ ] Rule: VIP only, 8 wins per board
- [ ] Rule: coin consumption per spin
- [ ] Test: 4414 with 17 slots is ignored by the client (guard server side)
- [ ] Test: X spin after 5 wins grants exactly 3 items
