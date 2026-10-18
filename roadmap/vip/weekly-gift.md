# VIP weekly gift ("Pacote Semanal VIP")

Path aliases:

| Alias | File |
|---|---|
| VM | `decompiled/core_module/scripts/managers/VIPManager.as` |
| VGF | `decompiled/m15/scripts/vip/VipGiftFrame.as` |
| VGI | `decompiled/m15/scripts/vip/VipGiftItem.as` |
| VC | `decompiled/core_module/scripts/mvc/controler/VIPControler.as` |

## 1. Overview

While VIP, the player can collect once per week a pack that depends on his VIP level (privilege 13). The availability is a flag in 4410 (`is_takeGift`) plus the next date (`take_giftDate`).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `vip.VipGiftFrame` (VGF) | "Pacote Semanal VIP" (VGF:48), subtitle "Colete o pacote de acordo com nível VIP" (VGF:68) | Two rows: current level pack and next level pack | `OpenSelfView` gift button, task tip 22, `VIPControler.showGiftFrame` (VC:96-100), openType 1 | level 0: packs of levels 1 and 2; level 9: levels 8 and 9; otherwise level and level + 1 (VGF:80-114) |
| `vip.VipGiftItem` (VGI) | row with button "VIP{n}Coletar" | Items of `VipDrop` for that level; button only on the row of the player's level | VGF | when `!is_takeGift && is_vip`: no button, text "Próxima data de coleta: <take_giftDate>" (VGI:94-101); when `is_takeGift && is_vip`: button visible (VGI:102-113) |

## 3. Routes (client to server)

### G1. Collect the weekly pack
- UI: VGI button `__receiveHandler` (VGI:136-152).
- Client checks: `is_vip` else "Você não é VIP, só pode ser coletado após ativação do VIP"; `is_takeGift` else "Você já coletou esse pacote essa semana, colete novamente na próxima".
- Sender: `VIPManager.senReceiveGift` (VM:171-175); then the frame closes and info tip 26 is cleared.
- Route: send 8505 (0x2139) `C_VIP_BOX_DROP`, empty body.
- Expected responses in order: bag updates for the granted items ([../inventory/README.md](../inventory/README.md)), 4410 `U_C_VIP_INFO` with `is_takeGift = false` and `take_giftDate` = next availability ([membership.md](membership.md) S1).

## 4. Server messages (server to client)

4410 `U_C_VIP_INFO` fields `is_takeGift` (#5, BOOL) and `take_giftDate` (#8, STRING) drive this screen; the model raises tip 22 "Coletar pacote VIP" when `is_takeGift && is_vip` (`decompiled/core_module/scripts/mvc/module/vip/VIPModel.as:109-117`).

`VipBoxDropMsg` (vip): `week_gift_date` (#1, BYTES) exists in the proto but no decompiled class reads it; do not send it.

Errors (not VIP, already taken) use 126 `U_C_MSG` (assumption); the client already blocks both.

## 5. Rules and formulas

- Content: `raw/xml/tempinfos/VipDrop.xml`, `site` = VIP level, all rows of the site are granted (`itemId` x `count`, `ValidDate` days or 0):

| Level | Items (`itemId` x `count`) |
|---:|---|
| 1 | 2030102 x2, 208017 x20, 208015 x10, 2061015 x10 |
| 2 | 208103 x10, 208017 x40, 208015 x20, 2061015 x15, 2030102 x4 |
| 3 | 208015 x30, 2061015 x20, 2030102 x8, 208103 x15, 208017 x60 |
| 4 | 208550 x5, 208103 x20, 208017 x80, 208015 x40, 2061015 x25, 2030102 x12 |
| 5 | 208015 x50, 2061015 x30, 2030102 x14, 208550 x8, 208103 x25, 208017 x100 |
| 6 | 208550 x10, 208103 x30, 208017 x120, 208015 x60, 2061015 x35, 2030102 x16 |
| 7 | 2030102 x18, 208550 x12, 208103 x35, 208017 x140, 208015 x70, 2061015 x40 |
| 8 | 208550 x15, 208103 x40, 208017 x160, 208015 x80, 2061015 x45, 2030102 x20 |
| 9 | 208550 x20, 208103 x45, 208017 x180, 208015 x100, 2061015 x50, 2030102 x22 |

  208015 is "Moeda VIP" (roulette coin, [roulette.md](roulette.md)).
- Once per week: availability resets every Monday 00:00 server time (assumption; the client only shows the date the server gives).
- Only while VIP; the level used is the level at collect time.
- Bag full: items go by mail (assumption, same rule as the roulette "Mochila cheia, cheque seu email").

## 6. Templates

| File | Record | Fields |
|---|---|---|
| `raw/xml/tempinfos/VipDrop.xml` | `VipDropInfo` (50 rows) | `site` VIP level, `itemId`, `count`, `ValidDate` |

## 7. Persistent state

Columns `weekly_gift_available` and `next_weekly_gift_at` of `vip.memberships` ([membership.md](membership.md)), plus a claim log:

```sql
CREATE TABLE vip.weekly_gift_claims (
  player_id    BIGINT      NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  week_start   DATE        NOT NULL,
  vip_level    SMALLINT    NOT NULL CHECK (vip_level BETWEEN 1 AND 9),
  claimed_at   TIMESTAMPTZ NOT NULL DEFAULT now(),
  PRIMARY KEY (player_id, week_start)
);
```

## 8. Backend implementation notes

- `vip::weekly_gift::handle_take` (8505): lock membership; require VIP and no row for the current `week_start`; insert the claim (the primary key makes it idempotent); grant `VipDrop` rows of the level through the inventory service (mail overflow); set `weekly_gift_available = false`, `next_weekly_gift_at` = next Monday 00:00; commit; push bag updates and 4410.
- `is_takeGift` in 4410 is computed: VIP and no claim row for the current week.
- Weekly job Monday 00:00: push 4410 to online VIPs so tip 22 appears.

## 9. Open questions and assumptions

- Assumption: weekly reset on Monday 00:00.
- Assumption: overflow goes to mail.

## 10. Implementation checklist

- [ ] Screen: two rows with the right levels (0, 9 and middle cases)
- [ ] Screen: next collect date when already taken
- [ ] Route G1 8505
- [ ] Server message 4410 `is_takeGift` / `take_giftDate`
- [ ] Table `vip.weekly_gift_claims`
- [ ] Rule: once per week per player, VIP only
- [ ] Rule: content by level from `VipDrop`
- [ ] Test: second 8505 in the same week grants nothing
- [ ] Test: Monday push raises tip 22
