# Game birthday ("3º Aniversário do Legend Online")

Feature `seasonal-events`, module `birthday`. Client package `birthday` (`M11/birthday/BirthdayBoardFrame.as`, `BirthdayInputFrame.as`), shared `CM/yishi/manager/BirthdayManager.as` (`BDM`), `CM/mvc/module/birthday/BirthdayModel.as`. Proto `active.ActiveMsgLeaveOp`, `active.ActiveMsgLeaveInfo`.

Conventions: see [README.md](README.md).

---

## 1. Overview

An anniversary NPC event: a wishing board where every player may post up to 3 congratulation messages (max 50 characters, word filtered), see the latest 12 messages of all players, collect a daily anniversary reward and a buff. The NPC dialog also links to the "Destaques" frame (sum-active, [funny.md](funny.md)). The window is the server switch 2007 ([../account/switches.md](../account/switches.md)).

---

## 2. Screens

| Class | pt-BR text | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| NPC dialog options 36, 37, 38 (`M3/map/space/view/frame/DialogOptionItem.as:642-645, 939-959`) | dialog options | Entry | Anniversary NPC in the space scene | 36 opens the board, 37 opens `funny`, 38 sends op 102. All guarded by `BirthdayManager.checkActiveHandler()` (`BDM`): tip `activity.ActivityManager.command03` before start or when switched off, `command02` after the end |
| `birthday.BirthdayBoardFrame` (controller `birthday`, `MESSAGE_BOARD_FRAME`) | default slot text "3º Aniversário do Legend Online" | Message board | Option 36 | 12 slots with `msgStr` and `nickName` (`BirthdayBoardFrame.as:140-165`), buttons wish, get buff, refresh |
| `birthday.BirthdayInputFrame` (`MESSAGE_INPUT_FRAME`) | "Mensagens restantes: {0}/{1} inserir números: {2}/{3}" (`3 - wishCount`, 3, chars, 50) | Write a message | Board "wish" button | Text input, confirm "Deseja enviar mensagem de bênção?" |

---

## 3. Routes (client to server)

Route: **8984 (0x2318) `C_ACTIVE_MSG_OP`**, body `active.ActiveMsgLeaveOp`, sender `BirthdayManager.sendOperationToServer(opType, msgType, msgStr = null)` (`BDM`, `PackageOut(8984)` at line 117): sets `op_type (#1)`, `msg_type (#2)`, and `msg_str (#3)` when given. `msg_type` is always 1 (`BIRTHDAY_3_TYPE`).

| op_type | UI control | Call site | Client checks | Expected response |
|---|---|---|---|---|
| 100 GET_MESSAGE | Board opens; refresh button | `BirthdayBoardFrame.show` (`:168-172`), `onRefreshClickHandler` (`:115-127`) | refresh throttled to 500 ms ("activity.view.ActivityItem.command01") | 4972 with `msgList` (latest 12) and `count` (own messages today or total) |
| 101 SUBMIT_MESSAGE | Input confirm | `BirthdayInputFrame` (`:120-150`) | text filtered by `FilterWordManager`; empty → "activity.customerService.textInput"; length <= 50; confirm | 4972 with the updated list and `count` |
| 102 GET_REWARD | NPC option 38 | `DialogOptionItem.birthdayItemsHandler` (`:953`) | event active | 4972 with `result` *(assumption)*; bag pushes |
| 103 GET_BUFF | Board "buff" button | `BirthdayBoardFrame.onGetBuffClickHandler` (`:110-113`) | none | 4972 *(assumption)*; buff push |

---

## 4. Server messages (server to client)

| Opcode | Name | Message | Receiver | When | Reaction |
|---|---|---|---|---|---|
| 4972 (0x136c) | U_C_ACTIVE_MSG_RES | `active.ActiveMsgLeaveOp` | `BDM.onReceiveDataHandler` (registered with `SocketManager.listener(4972, ...)` in `setup`, line 103) | After every 8984 | `model.updateModel(msgList, count)`; board and input frames refresh |
| 4422 | U_C_SWITCH | `switches.SwitchInfoListMsg` | `BaseManager.__switchesUpdateHandler` (`CM/yishi/manager/BaseManager.as:1505, 1569-1570`) | Login and switch changes; switch id 2007 | `setBirthdaySwitch(isOpen, beginDate, endDate)` |

`ActiveMsgLeaveOp`: `op_type` (#1, INT32); `msg_type` (#2, INT32); `msg_str` (#3, STRING); `count` (#4, INT32) messages already posted by the player (the input shows `3 - count`); `result` (#5, BOOL); `param1` (#6, STRING), `param2` (#7, STRING), `param3` (#8, INT32) unused; `msgList` (#9, ActiveMsgLeaveInfo, repeated).

`ActiveMsgLeaveInfo`: `userId` (#1, INT32); `msg_str` (#2, STRING); `op_date` (#3, STRING); `nick_name` (#4, STRING); `param1` (#5), `param2` (#6) STRING, `param3` (#7, INT32) unused.

---

## 5. Rules and formulas

- Max 3 messages per player (input frame constant `3`, `BirthdayInputFrame.as:222`) *(assumption: for the whole event)*; 50 characters (`:175`).
- The board shows the latest 12 messages of the server.
- Reward (op 102) and buff (op 103) once per day *(assumption)*.
- Window from switch 2007.

---

## 6. Templates

None.

---

## 7. Persistent state (PostgreSQL, schema `seasonal_events`)

```sql
CREATE TABLE seasonal_events.birthday_messages (
  message_id  bigserial PRIMARY KEY,
  window_id   integer NOT NULL REFERENCES seasonal_events.event_windows(window_id),
  player_id   bigint  NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  text        varchar(50) NOT NULL,
  created_at  timestamptz NOT NULL DEFAULT now()
);
CREATE INDEX birthday_messages_latest ON seasonal_events.birthday_messages (window_id, created_at DESC);

CREATE TABLE seasonal_events.birthday_claims (
  window_id  integer  NOT NULL,
  player_id  bigint   NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  kind       smallint NOT NULL CHECK (kind IN (102, 103)),
  day_date   date     NOT NULL,
  PRIMARY KEY (window_id, player_id, kind, day_date)
);
```

---

## 8. Backend implementation notes

| Handler | op_type | Notes |
|---|---|---|
| `seasonal_events::birthday::handle_get_messages` | 100 | 4972 with 12 latest and own count |
| `seasonal_events::birthday::handle_submit` | 101 | window → count < 3 → length <= 50 → word filter → insert; 4972 |
| `seasonal_events::birthday::handle_reward` | 102 | window → not claimed today → grant; 4972 `result` |
| `seasonal_events::birthday::handle_buff` | 103 | window → not claimed today → apply buff; 4972 |

---

## 9. Open questions and assumptions

- *(assumption)* Reward and buff contents and periodicity (not visible in the client).
- `msg_type` other than 1 never used.

---

## 10. Implementation checklist

- [ ] Switch 2007 pushed in 4422
- [ ] NPC options 36..38, board frame, input frame
- [ ] 8984 op 100..103
- [ ] 4972 response
- [ ] Tables `birthday_messages`, `birthday_claims`
- [ ] Tests: 4th message refused, 51 characters refused, filtered words
