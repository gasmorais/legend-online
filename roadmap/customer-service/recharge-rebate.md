# Recharge rebate gift packs (client package `feedback`)

Area: customer-service, module `recharge-rebate`. The client package `core_module/scripts/feedback` is named "feedback" but implements a recharge rebate event ("回馈活动", feedback = reward back): during a time window, recharge points unlock gift packs that the player claims one by one. Protocol: `4461 U_C_REBATE_ACTIVE`, `4463 U_C_REBATE_DATA`, `8574 C_REBATE_DATA`. The proto package `rebate` and the economic rules are owned by [../recharge/README.md](../recharge/README.md); this file documents the screen and protocol because the registry assigns the `feedback` package to customer-service.

Conventions: see [support-tickets.md](support-tickets.md). Paths are relative to the repository root.

## 1. Overview

- The server pushes the active rebate event (`4461`) at login (flag `rebate_charge` of `8224`, [../account/login-session.md](../account/login-session.md)) or when one starts. The client immediately asks for the player's progress (`8574 op 1`), the server answers `4463` (points and claimed packs).
- Top toolbar button "feedback" (level >= 6, inside the window) opens the frame; it glows when a pack is claimable. Each pack has a point threshold (`point`), a price label (`price`) and up to 8 items. The player claims with `8574 op 2`.
- No pt-BR strings exist for `feedback.*` keys in `index/language.json`, so the frame shows raw keys in BR (the event was probably unused in BR).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `feedback.FeedBackFrame` (`decompiled/core_module/scripts/feedback/FeedBackFrame.as:77`) | key `feedback.FeedBackFrame.title` (missing in BR) | Pack list, progress bar, recharge button | Top button `feedback` (`decompiled/core_module/scripts/ui/toptoolbar/TopToolsBar.as:1069-1074`), visible when level >= 6, `switchBtn1` and inside `[startTime, endTime)` (`decompiled/core_module/scripts/ui/toptoolbar/TopBtnCheckShowHelper.as:234-240`) | Packs sorted by `order`; progress `userPoint / next threshold`; text `describeText03` (points missing, price) or `describeText02` (all reached) (`FeedBackFrame.as:184-209`); recharge button opens the payment page (`:321-324`) |
| `feedback.FeedBackItem` (`decompiled/core_module/scripts/feedback/FeedBackItem.as:47`) | `feedback.FeedBackItem.title01` (point 0) or `title02` with the threshold | One pack | Frame | Items, claim button enabled when `userPoint >= point`, grey with "claimed" mark when `state` (`FeedBackItem.as:151-168`) |

## 3. Routes (client to server)

`8574 C_REBATE_DATA` (C>S, 0x217e), `RebateOpMsg` (package rebate): `id (#1, STRING)` event id, `packageid (#2, STRING)` pack id, `op (#3, INT32)`. Sender `SocketSendManager.sendGetFeedBack(id, packageId, op)` (`decompiled/core_module/scripts/yishi/service/managers/SocketSendManager.as:489-497`).

| Action | Trigger | op | packageid | Client checks | Response |
|---|---|---:|---|---|---|
| Load progress | automatic after `4461` (`decompiled/core_module/scripts/managers/FeedBackManager.as:91`) | 1 | null | none | `4463` |
| Claim pack | claim button (`FeedBackItem.as:99-112`) | 2 | pack id | now inside `[startTime, endTime]`, else `feedback.FeedBackItem.outDate`; button only enabled when `userPoint >= point` | `4463` with the pack marked, plus the bag update ([../inventory/README.md](../inventory/README.md)) |

## 4. Server messages (server to client)

### `4461 U_C_REBATE_ACTIVE` (0x116d), `RebateInfoMsg` (package rebate)

Fields: `id (#1, STRING)` event id (empty = no event), `begin_date (#2, STRING)`, `end_date (#3, STRING)` "YYYY-MM-DD hh:mm:ss", `type (#4, INT32)` rebate type, `packages (#5, MESSAGE PackageInfoMsg, repeated)`.

`PackageInfoMsg`: `packageId (#1, STRING)`, `order (#2, INT32)`, `point (#3, INT32)` threshold, `price (#4, INT32)` displayed value, `itemid1 (#5, INT32)`, `count1 (#6, INT32)`, `itemid2 (#7)`, `count2 (#8)`, `itemid3 (#9)`, `count3 (#10)`, `itemid4 (#11)`, `count4 (#12)`, `itemid5 (#13)`, `count5 (#14)`, `itemid6 (#15)`, `count6 (#16)`, `itemid7 (#17)`, `count7 (#18)`, `itemid8 (#29, INT32)` (tag 29 confirmed in `decompiled/core_module/scripts/com/road/yishi/proto/rebate/PackageInfoMsg.as:593`), `count8 (#20, INT32)`.

- Receiver: `FeedBackManager.__rebateActiveHandler` (`FeedBackManager.as:63-92`), registered at `:59`. Empty `id` removes the button and closes the frame. Items with id 0 are dropped and the rest sorted by template `Profile` desc then `MasterType` (`:94-171`).

### `4463 U_C_REBATE_DATA` (0x116f), `UserRebateMsg` (package rebate)

Fields: `id (#1, STRING)`, `userid (#2, INT32)`, `point (#3, INT32)` player points, `type (#4, INT32)`, `packagestates (#5, MESSAGE PackageStateMsg, repeated)`; `PackageStateMsg`: `id (#1, STRING)` pack id, `isget (#2, BOOL)` claimed.

- Receiver: `FeedBackManager.__rebateDataHandler` (`FeedBackManager.as:173-203`): ignored unless `id`, `userid` and `type` match the active event and player. Sets `userPoint`, pack states, glow when a pack is claimable, `allReceived = true` (enables opening), info tip 21.

## 5. Rules and formulas

- Points: recharge amount during the window (assumption: diamonds recharged; `type` selects recharge vs consumption, see `PlayerDataMsg.rebate_consum (#27)` which the client never requests).
- A pack is claimable once when `point >= threshold` and the event is running.
- Level gate 6.

## 6. Templates

None; events and packs are server configuration owned by [../recharge/README.md](../recharge/README.md).

## 7. Persistent state

Owned by recharge; minimal proposal if implemented here:

```sql
CREATE TABLE customer_service.rebate_claims (
  event_id         TEXT        NOT NULL,
  package_id       TEXT        NOT NULL,
  player_id        BIGINT      NOT NULL REFERENCES player.players(player_id),
  claimed_at       TIMESTAMPTZ NOT NULL DEFAULT now(),
  PRIMARY KEY (event_id, package_id, player_id)
);
```

Player points per event come from the recharge ledger (`recharge` schema).

## 8. Backend implementation notes

- `customer_service::recharge_rebate::push_active` (login flag `rebate_charge`, event start/end): `4461`.
- `customer_service::recharge_rebate::handle_rebate_op` (8574): op 1 -> `4463`; op 2 -> validate event running, pack exists, points >= threshold, not claimed; transaction: insert claim, add items; reply `4463`.
- Recommended: delegate to the recharge feature service and keep this module as the protocol adapter.

## 9. Open questions and assumptions

- Assumption: points are recharged diamonds in the window.
- Open: whether BR ever ran this event (no pt-BR strings).

## 10. Implementation checklist

- [ ] `4461` at login and on event change
- [ ] `8574` op 1 and op 2
- [ ] `4463` progress push
- [ ] Claim table and item grant
- [ ] Add pt-BR strings if the event is enabled (client language file, outside backend)
- [ ] Test: claim below threshold rejected
- [ ] Test: double claim rejected
