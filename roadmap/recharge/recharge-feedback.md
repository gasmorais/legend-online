# Recharge feedback packs ("Feedback de Pacote de Recarga", rebate proto)

Path aliases:

| Alias | File |
|---|---|
| FBM | `decompiled/core_module/scripts/managers/FeedBackManager.as` |
| FBF | `decompiled/core_module/scripts/feedback/FeedBackFrame.as` |
| FBI | `decompiled/core_module/scripts/feedback/FeedBackItem.as` |
| SSM | `decompiled/core_module/scripts/yishi/service/managers/SocketSendManager.as` |
| TBH | `decompiled/core_module/scripts/ui/toptoolbar/TopBtnCheckShowHelper.as` |

## 1. Overview

A timed activity (top toolbar template 2016 "充值回馈礼包") with up to N packs, each unlocked by the diamonds recharged during the activity ("Recarregue {0} diamantes", or "Recarregue qualquer valor" for a zero threshold). Each pack is claimed once. It uses the `rebate` proto package; the UI package is `feedback`.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `feedback.FeedBackFrame` (FBF) | "Feedback de Pacote de Recarga" (FBF:397) | Pack list, progress bar, description "Ainda falta recarregar {0} diamantes para poder coletar pacote de valor equivalente à {1} diamantes" or "Parabéns ao obter qualificação para coletar todos os pacotes" (FBF:184-209), pack content "Conteúdo do Pacote de {0} Diamantes" (FBF:317), recharge button | top toolbar "feedback" (`TopToolsBar.as:1069`); visible when hero level >= 6, the activity is active and now is inside `[startTime, endTime]` (TBH:234-236); toolbar glow `needShine` (`TopToolsBar.as:374-376`) | `userPoint`, packs ordered by `order` (FBM:210-214) |
| `FeedBackItem` (FBI) | "Recarregue {0} diamantes" / "Recarregue qualquer valor" | One pack; button enabled when `userPoint >= point`, grey with taken mark when claimed (FBI:151-182) | FBF | |

## 3. Routes (client to server)

All routes: send 8574 (0x217e) `C_REBATE_DATA`; message `RebateOpMsg` (rebate): `id` (#1, STRING) activity id; `packageid` (#2, STRING) pack id or empty; `op` (#3, INT32) 1 query, 2 claim. Sender `SocketSendManager.sendGetFeedBack(id, packageId, op)` (SSM:489-497).

### R1. Query player state
- UI: automatically after 4461 with a valid activity (FBM:89-91).
- Route: 8574, `id` = activity id, `packageid` null, `op` 1.
- Expected response: 4463 `U_C_REBATE_DATA`.

### R2. Claim a pack
- UI: FBI get button (FBI:99-112). Client checks: now inside the activity dates else "Evento expirado"; button enabled only when `userPoint >= point`.
- Route: 8574, `id`, `packageid` = pack id, `op` 2.
- Expected responses: bag updates, 4463 with the pack `isget = true`.

## 4. Server messages (server to client)

### S1. 4461 (0x116d) `U_C_REBATE_ACTIVE`
- Message `RebateInfoMsg` (rebate): `id` (#1, STRING) activity id, empty = no activity; `begin_date` (#2, STRING); `end_date` (#3, STRING); `type` (#4, INT32) activity type, echoed by 4463; `packages` (#5, `PackageInfoMsg`, repeated).
- `PackageInfoMsg`: `packageId` (#1, STRING); `order` (#2, INT32); `point` (#3, INT32) diamonds to recharge; `price` (#4, INT32) displayed value of the pack in diamonds; item pairs `itemid1` (#5) / `count1` (#6), `itemid2` (#7) / `count2` (#8), `itemid3` (#9) / `count3` (#10), `itemid4` (#11) / `count4` (#12), `itemid5` (#13) / `count5` (#14), `itemid6` (#15) / `count6` (#16), `itemid7` (#17) / `count7` (#18), `itemid8` (#29, INT32, tag 29 as in `decompiled/core_module/scripts/com/road/yishi/proto/rebate/PackageInfoMsg.as:593`) / `count8` (#20), all INT32, 0 = empty slot.
- Receiver: `FeedBackManager.__rebateActiveHandler` (FBM:59, 63-92): empty `id` disables the button and fires `FEEDBACK_DELETE_ACTIVE`; otherwise stores dates, type and packs (items sorted by quality, FBM:94-133), enables the button and sends R1.
- When: login, activity start (with data), activity end (empty `id`).

### S2. 4463 (0x116f) `U_C_REBATE_DATA`
- Message `UserRebateMsg` (rebate): `id` (#1, STRING) activity id; `userid` (#2, INT32) player id; `point` (#3, INT32) diamonds recharged during the activity; `type` (#4, INT32) activity type; `packagestates` (#5, `PackageStateMsg`, repeated: `id` (#1, STRING) pack id, `isget` (#2, BOOL) claimed).
- Receiver: `FeedBackManager.__rebateDataHandler` (FBM:60, 173-203): ignored unless `id`, `userid` and `type` match; sets `userPoint` and states; `needShine` when an unclaimed pack is reachable; `FEEDBACK_RECEIVE_USERINFO`; info tip 21.
- When: reply to R1 and R2; push after each credited recharge during the activity.

## 5. Rules and formulas

- `point` accumulates the diamonds credited between `begin_date` and `end_date`.
- Pack claimable when `point >= pack.point` and not yet claimed; once per activity.
- A pack with `point = 0` is claimable after any recharge ("Recarregue qualquer valor"; assumption: requires at least one credited order).
- Content: up to 8 (item, count) pairs; virtual ids allowed ([../currency/spending.md](../currency/spending.md)).

## 6. Templates

None: packs come with 4461.

## 7. Persistent state

```sql
CREATE TABLE recharge.feedback_events (
  id            TEXT        PRIMARY KEY,
  event_type    INTEGER     NOT NULL DEFAULT 1,
  starts_at     TIMESTAMPTZ NOT NULL,
  ends_at       TIMESTAMPTZ NOT NULL,
  CHECK (ends_at > starts_at)
);

CREATE TABLE recharge.feedback_packs (
  event_id      TEXT     NOT NULL REFERENCES recharge.feedback_events(id) ON DELETE CASCADE,
  pack_id       TEXT     NOT NULL,
  sort_order    INTEGER  NOT NULL,
  required      INTEGER  NOT NULL CHECK (required >= 0),
  shown_value   INTEGER  NOT NULL DEFAULT 0,
  items         JSONB    NOT NULL,           -- up to 8 [{item_id, count}]
  PRIMARY KEY (event_id, pack_id)
);

CREATE TABLE recharge.feedback_players (
  player_id     BIGINT  NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  event_id      TEXT    NOT NULL REFERENCES recharge.feedback_events(id) ON DELETE CASCADE,
  recharged     INTEGER NOT NULL DEFAULT 0 CHECK (recharged >= 0),
  claimed       TEXT[]  NOT NULL DEFAULT '{}',
  PRIMARY KEY (player_id, event_id)
);
```

## 8. Backend implementation notes

- `recharge::feedback::handle_op` (8574): `op` 1 -> reply 4463; `op` 2 -> lock player row, require active event and dates, `recharged >= required`, pack not in `claimed`; grant items (mail overflow); append; reply 4463.
- `recharge::feedback::on_recharge(tx, player_id, diamonds)`: when an event is active add to `recharged`; after commit push 4463.
- Scheduler: push 4461 at start (with packs) and at end (empty `id`); login sends 4461 when an event is active.

## 9. Open questions and assumptions

- Assumption: zero threshold packs need at least one recharge.
- Open: meaning of `type` beyond echo.

## 10. Implementation checklist

- [ ] Screen: pack list, progress and description texts
- [ ] Route R1 8574 op 1
- [ ] Route R2 8574 op 2
- [ ] Server message S1 4461 with tag 29 for `itemid8`
- [ ] Server message S2 4463
- [ ] Table `recharge.feedback_events`
- [ ] Table `recharge.feedback_packs`
- [ ] Table `recharge.feedback_players`
- [ ] Rule: cumulative recharge during the activity
- [ ] Rule: claim once per pack
- [ ] Test: claim below threshold refused
- [ ] Test: activity end sends empty id and hides the button
