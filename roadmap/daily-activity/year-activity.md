# Anniversary activity data ("Exploração de Aniversário")

Area: daily-activity, module `year-activity`. Covers the proto package `activity` (`activity.YearActivityMsg`), its manager `managers.YearActiveManager`, the push 551 `U_C_YEAR_ACTIVITY_DATA`, the route 9728 `C_YEAR_ACTIVITY_CLIENT_OP`, and the top toolbar template 2061. The screens (`year2023.*` in m3, controller `mvc.controler.YearActiveController`) belong to [seasonal-events](../seasonal-events/README.md); this file defines the protocol both sides must agree on.

Conventions: see [README.md](README.md).

## 1. Overview

An anniversary hub with six cards (`yearactivity.type1..6`): "Presente de Check-in" (daily check in with a free and a paid "Prêmio Avançado" track), "Mini game aleatório", "Caça-Tesouro", "Exploração de Aniversário" (box floors opened with "Chave do Baú de Aniversário"), "Coleção Comemorativa", "Gashapon da Sorte" (draws paid with "Moeda de Aniversário"). One message (551) carries the whole player state; one route (9728) carries every action.

## 2. Screens

| Class | Purpose | Opened from |
|---|---|---|
| `year2023.frame.YearActiveEnterFrame` | hub with the six cards | top toolbar key `sevenyear` (template 2061 "周年庆") -> `openControllerByInfo("yearactive", "Enter")` (`decompiled/core_module/scripts/ui/toptoolbar/TopToolsBar.as:1482`); visible when `YearActiveManager.ins.isOpen` (`decompiled/core_module/scripts/ui/toptoolbar/TopBtnCheckShowHelper.as:397`) |
| `year2023.frame.YearActiveDayFrame` (`YearActiveDayView`) | check in track, per gear "Grátis" and "Prêmio Avançado", make up check in | card 1 (`decompiled/m3/scripts/year2023/ui/item/YearActive1UI.as:51`) |
| `year2023.frame.YearActiveLookFrame` (`YearActiveLookView`) | box floors ("Quanto maior o andar, melhor o prêmio") | card 3 |
| `year2023.frame.YearActiveEggFrame`, `YearactiveEggDropFrame` | gashapon x1 / x10 and its drop list | card 6 |
| `year2023.frame.YeraActiveShopFrame` | anniversary shop | cards 5, Look and Egg views |

Controller frame names: `decompiled/core_module/scripts/mvc/controler/YearActiveController.as:40-:62`.

## 3. Routes (client to server)

All actions: C>S 9728 (0x2600) `C_YEAR_ACTIVITY_CLIENT_OP`, body `player.PlayerOpMsg` with `op (#1, INT32)` and `id (#5, INT32)` (default -1). Sender `YearActiveManager.doSomething(op, id)` `decompiled/core_module/scripts/managers/YearActiveManager.as:97`.

| op | Action | UI sender | Client checks | id |
|---:|---|---|---|---|
| 2 | claim the check in reward of a gear (day) | `YearActivePrivateItem.getClickHandler` `decompiled/m3/scripts/year2023/item/YearActivePrivateItem.as:110` | button state from `checkinInfo` | gear |
| 3 | claim all available check in rewards | `YearActiveDayView.oneKeyHandler` `decompiled/m3/scripts/year2023/view/YearActiveDayView.as:234` | | -1 |
| 4 | make up a missed check in | `YearActivePrivateItem.bqCallHandler` `:105` | `point >= buqPoint`, confirm "Deseja gastar {0} Diamante(s) para compensar o Check-in?" | gear |
| 5 | unlock the advanced track | `YearActivePrivateCItem.__alertResponse` `decompiled/m3/scripts/year2023/item/YearActivePrivateCItem.as:101` | confirm "Deseja gastar {0} diamantes para liberar o prêmio avançado?" | -1 |
| 6 | claim the mini game reward | `YearActive2UI.getHandler` `decompiled/m3/scripts/year2023/ui/item/YearActive2UI.as:144` | `miniGameState` | -1 |
| 7 | open a box slot | `YearActiveBoxItemUI.boxClickHandler` `decompiled/m3/scripts/year2023/ui/item/YearActiveBoxItemUI.as:90` | | slot position |
| 8 | open the floor box with a key | `YearActiveLookView` `decompiled/m3/scripts/year2023/view/YearActiveLookView.as:264` | owns a key, else "Chaves insuficientes. Deseja comprar?" | -1 |
| 9 | go to the next floor | `YearActiveLookView.nextHandler` `:243` | | -1 |
| 10 | gashapon draws | `YearActiveEggView` `decompiled/m3/scripts/year2023/view/YearActiveEggView.as:227` (x10), `:265` (x1) | confirm cost "Deseja gastar {0} Moeda(s) de Aniversário para sortear no Gashapon {1} vez(es)?" | 1 or 10 |

No sender uses op 1 in this build (assumption: op 1 = request data, answered by 551).

Expected response for every op: item and currency pushes, then 551 with `opType` = the op handled.

## 4. Server messages (server to client)

### S1. 551 (0x0227) `U_C_YEAR_ACTIVITY_DATA`

- `activity.YearActivityMsg`: `opType (#1, INT32)` op that caused the push (forwarded as notification `EVENT_YEARACTIVITY_OP`); `checkinInfo (#2, STRING)` "gear,state|gear,state" per check in gear (`YearActiveDayView.as:208-:229`); `buyCheckin (#3, BOOL)` advanced track unlocked; `miniGameState (#4, INT32)` 0 not played (resets `isGamePassed`), > 0 played or claimed; `boxInfo (#5, STRING)` box slots joined by "|" (9 entries = floor full, `YearActiveLookView.as:142`); `boxLevel (#6, INT32)` current floor; `boxNext (#7, BOOL)` next floor available; `eggCount (#8, INT32)` gashapon draws done; `showInfo (#9, STRING)` opened slot ids joined by ","; `curDay (#10, INT32)` current event day.
- Receiver: `YearActiveManager.__dataInfosHandler` `decompiled/core_module/scripts/managers/YearActiveManager.as:59`.
- When: login while open, after every 9728.

### S2. 4590 (0x11ee) `U_C_TOP_TOOL_BTN` with `param1 = 2061`

- `simple.PropertyMsg`: `param7 (#7, BOOL)` open, `param4 (#4, STRING)` open time, `param5 (#5, STRING)` stop time. Receiver `YearActiveManager.__topBtnHandler` `:81`. Layout in [super-sign-in-card.md](super-sign-in-card.md) S3.

## 5. Rules and formulas

- Check in gear states and costs (`buqPoint`, advance price) are defined by the screens of [seasonal-events](../seasonal-events/README.md); the server is authoritative and must reject ops whose state does not allow them.
- Box floors: 9 slots per floor; `op 8` needs a key item, `op 9` requires `boxNext`.
- Gashapon: `op 10` with id 1 or 10, cost in anniversary coins.

## 6. Templates

`YearEggDrop.xml` (gashapon drops) is present in `raw/xml/tempinfos/`; the other tables are server side. Owner: [seasonal-events](../seasonal-events/README.md).

## 7. Persistent state

```sql
CREATE TABLE daily_activity.year_activity_state (
    player_id        BIGINT  PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
    event_id         integer  NOT NULL,
    checkin_states   jsonb    NOT NULL DEFAULT '{}'::jsonb,
    advanced_bought  boolean  NOT NULL DEFAULT false,
    mini_game_state  smallint NOT NULL DEFAULT 0,
    box_level        smallint NOT NULL DEFAULT 1,
    box_slots        text     NOT NULL DEFAULT '',
    opened_slots     text     NOT NULL DEFAULT '',
    egg_count        integer  NOT NULL DEFAULT 0
);
```

## 8. Backend implementation notes

- `daily_activity::year_activity::handle_client_op` (9728): dispatch on `op` per section 3; each op in one transaction; always end with 551 carrying the full state and `opType`.
- Event window pushes 4590 with `param1 = 2061`.

## 9. Open questions and assumptions

- op 1 meaning; gear states encoding (`state` values) is defined by `YearActivePrivateItem.updateBtnState` (seasonal-events must document it).
- Ownership split: protocol here, screens and rewards in seasonal-events.

## 10. Implementation checklist

- [ ] 4590 template 2061 open and close
- [ ] 551 at login while open
- [ ] Route 9728 ops 2 to 10
- [ ] Table `daily_activity.year_activity_state`
