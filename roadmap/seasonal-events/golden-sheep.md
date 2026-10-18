# Lucky golden sheep ("Ovelha Dourada da Sorte", 幸运金羊)

Feature `seasonal-events`, module `golden-sheep`. Client package `goldensheep` (`M11/goldensheep/*`), shared `CM/yishi/manager/GoldenSheepManager.as` (`GSM`), `CM/mvc/module/goldensheep/GoldenSheepModel.as`, `GoldenSheepRecordInfo.as`, resource bar button `CM/ui/resourcebar/view/GoldenSheepView.as`, controller `CM/mvc/controler/GoldenSheepController.as`. Proto `cccactive.GoldenSheepMsg`, `cccactive.GoldenSheepPlayerMsg`. cccactive sub-activity `extend1 = 31` ([active-framework.md](active-framework.md)).

Conventions: see [README.md](README.md).

---

## 1. Overview

A timed server-wide box. At the opening time a golden sheep button glows in the resource bar; each player may open the box once and receives a random amount (`myCount`) of one reward item (`rewardId`). The box has a global stock (`totalCount`, `curCount`); a record list shows who got how much and marks the best luck. The top tool bar shows an info icon with "Horário de Abertura: {0}".

`VersionSwitch.GOLDEN_SHEEP = true` (`CM/yishi/datas/VersionSwitch.as:114`).

---

## 2. Screens

Controller `goldensheep`: openType 2 `goldensheep.GoldenSheepBoxFrame`, otherwise `goldensheep.GoldenSheepFrame`.

| Class | pt-BR text | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| Tool bar icon `goldensheep` (TopToolBtnInfo 2053) | tip "Horário de Abertura: {0}" (`TopBtnItemView.as:587-593`) | Info only (in `TopBtnType.REMOVE_EFFECT_DATA`) | visible when `GOLDEN_SHEEP && topBtnShow` (`TopBtnCheckShowHelper.as:375-376`): open, or today before the open time, or inside `[openTime, endTime)` (`GoldenSheepModel.topBtnShow`) | open time |
| `ui.resourcebar.view.GoldenSheepView` | button | Entry | Shown when `GOLDEN_SHEEP && needShow` (`isOpen == 1`); glows when `state == 1` (`GoldenSheepView.as:88-105`) | |
| `goldensheep.GoldenSheepBoxFrame` (680x290) | box | Open the box | 4881 `op 1` when not yet rewarded | Box animation; after 4881 `op 2` shows the result and opens the record frame (`GoldenSheepBoxFrame.as:60-125`) |
| `goldensheep.GoldenSheepFrame` | records | Result and records | 4881 `op 1` when already rewarded, or after the box animation | Own reward `rewardId x myCount` ("×{0}"), record list (nickname, money, best mark) |

---

## 3. Routes (client to server)

Route: **9645 (0x25ad) `C_CCCACTIVE_CLIENTOP`**, header `extend1 = 31`, body `cccactive.GoldenSheepMsg` with only `op (#1, INT32)` set.

| op | UI control | Sender (file:line) | Client checks | Expected response |
|---|---|---|---|---|
| 1 CHECK | Resource bar button | `GoldenSheepView` click → `GSM.checkState()` (`GoldenSheepView.as:66-70`, `GSM:113-119`) | none (stops the glow) | 4881 `op 1` |
| 2 OPEN | Box click | `GoldenSheepBoxFrame` → `GSM.openBox()` (`GoldenSheepBoxFrame.as:114-125`, `GSM:121-127`) | `needShow` (`isOpen == 1`) | 4881 `op 2` with the result |

---

## 4. Server messages (server to client)

| Opcode | Name | Message | Receiver | When | Reaction (`GSM:58-111`) |
|---|---|---|---|---|---|
| 4881 (0x1311) | U_C_GOLDEN_SHEEP | `cccactive.GoldenSheepMsg` | `GSM.__goldenSheepHandler` | op 1 → `op 1`; op 2 → `op 2`; state pushes (open, glow, stock change) with `op` other than 1..3; close → `op 3` | `op 3`: closes the frame and stops. Otherwise copies fields and records; `op 1` opens the record frame if `isReward == 1` else the box frame; `op 2` fires `ANIMATION_UPDATE`; other ops fire `STATE_UPDATE` (tool bar and resource bar refresh); always `INFO_UPDATE` |

`GoldenSheepMsg`: `op` (#1, INT32); `index` (#2, INT32) box round *(assumption)*; `myCount` (#3, INT32) amount won; `isReward` (#4, INT32) 1 already opened; `rewardId` (#5, INT32) item template; `totalCount` (#6, INT32) stock; `curCount` (#7, INT32) opened so far; `sheepData` (#8, GoldenSheepPlayerMsg, repeated) records; `isOpen` (#9, INT32) 1 open now; `state` (#10, INT32) 1 glow; `openTime` (#11, STRING), `stopTime` (#12, STRING) "YYYY-MM-DD hh:mm:ss".

`GoldenSheepPlayerMsg`: `nick_name` (#1, STRING); `money` (#2, INT32) amount; `is_best` (#3, BOOL).

---

## 5. Rules and formulas

- One open per player per round; amounts are random server side *(assumption: weighted table, best luck = max amount so far)*.
- When `curCount >= totalCount` the box closes for everyone (`isOpen = 0`, push).
- Push `op 3` to close open frames when the window ends.

---

## 6. Templates

None (server configuration: window, reward item, amount table, stock).

---

## 7. Persistent state (PostgreSQL, schema `seasonal_events`)

```sql
CREATE TABLE seasonal_events.golden_sheep_rounds (
  round_id     serial PRIMARY KEY,
  open_time    timestamptz NOT NULL,
  stop_time    timestamptz NOT NULL,
  reward_id    integer NOT NULL,
  total_count  integer NOT NULL,
  cur_count    integer NOT NULL DEFAULT 0
);

CREATE TABLE seasonal_events.golden_sheep_opens (
  round_id   integer NOT NULL REFERENCES seasonal_events.golden_sheep_rounds(round_id) ON DELETE CASCADE,
  player_id  bigint  NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  amount     integer NOT NULL,
  opened_at  timestamptz NOT NULL DEFAULT now(),
  PRIMARY KEY (round_id, player_id)
);
CREATE INDEX golden_sheep_opens_amount ON seasonal_events.golden_sheep_opens (round_id, amount DESC);
```

---

## 8. Backend implementation notes

| Handler | Route | Notes |
|---|---|---|
| `seasonal_events::golden_sheep::handle_check` | 9645/31 op 1 | 4881 op 1 with own state and last records |
| `seasonal_events::golden_sheep::handle_open` | 9645/31 op 2 | round open → not opened → stock left (atomic increment of `cur_count`) → roll amount → grant; 4881 op 2; broadcast a state push with new `curCount` |

- Scheduler: push state at the open time (glow), at stock exhaustion and `op 3` at the end.

---

## 9. Open questions and assumptions

- *(assumption)* Amount distribution and the meaning of `index`.

---

## 10. Implementation checklist

- [ ] Resource bar button and tool bar info icon
- [ ] Box frame and record frame
- [ ] 9645/31 ops 1, 2
- [ ] 4881 ops 1, 2, 3 and state pushes
- [ ] Tables `golden_sheep_rounds`, `golden_sheep_opens`
- [ ] Tests: open twice, open after stock exhausted, close push
