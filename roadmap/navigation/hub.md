# Navigation hub, state sync and strength

Feature [navigation](README.md), module `hub`. Aliases in [README.md](README.md).

## 1. Overview

- `NavigationFrame` "Mistério de Navegação" is the harbor view: one ship building and three ports, the strength bar ("pontos de movimento"), the shop button and the fishing panel.
- The whole client state comes from one push, 342 `U_C_NAVIGATION_DATA_MSG` (`NavigationMsg`), stored in `NavigationModel` by `NavigationManager` (`NM:91-199`). There is no "open" request: the server must push 342 at login and after every change.
- Every request uses 9600 (0x2580) `C_NAVIGATION` with an op enum; the server answers with 341 `U_C_NAVIGATION_MSG` (`NavigationResMsg {op, result}`) and then 342 with the new state.
- Strength: 100 per day (`navigation_strength_default`), 20 per expedition, 20 per friend assist; buy 100 more for 100 diamonds, twice per day.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `NAV/NavigationFrame.as` (795 x 570) | "Mistério de Navegação" (`:320-324`) | Harbor; four `NavigationBuildView` hotspots (`:134-147`); shop button (`:200-204`); strength bar and buy button (`:206-227`); fishing panel (`:178-188`, `:249-289`) | controller `navigation` openType 1 | `strength` (bar `strength * 100 / 100`, `:229-235`), port list for the 3 port views (`:236-245`), fishing state |
| `NAV/NavigationBuildView.as` | "Navio", "Porto do Céu", "Porto do Amanhecer", "Porto Azul"; "Contagem de regresso:", "Já recusou troca:" | Hotspot; index 0 opens the ship frame (openType 2), 1..3 open the port frame with the port index (openType 3) (`:131-143`); shows the port refusal cooldown or the expedition return countdown (`:155-192`) | `NavigationFrame` | `portCd`, ship `boatCd` |

## 3. Routes (client to server)

Common: send 9600 (0x2580) `C_NAVIGATION`, protobuf `NavigationOpMsg` (package `pet`): `op` (#1, ENUM `NavigationOpState`); `param1` (#2, STRING); `param2` (#3, STRING); `param3` (#4, INT32); `param4` (#5, INT32); `param5` (#6, INT32, repeated); `param6` (#7, INT32, repeated). Sender `NavigationManager.sendNavigationOperate(op, param1, param2, param3 = 0, param4 = 0, param5 = null, param6 = null)` (`NM:201-219`).

Op enum `NavigationOpState` (`decompiled/core_module/scripts/com/road/yishi/proto/pet/NavigationOpState.as`, mirrored in `decompiled/core_module/scripts/mvc/module/navigation/NavigationOpClass.as:6-46`):

| op | Name | Sent by client | Module |
|---|---|---|---|
| 0 | BOAT_ACTIVATE | yes | [boats.md](boats.md) |
| 1 | BOAT_IDLE | no (server state) | [boats.md](boats.md) |
| 2 | BOAT_STOPPING | no | [boats.md](boats.md) |
| 3 | BOAT_UPGRADE | yes | [boats.md](boats.md) |
| 4 | BOAT_UPGRADE_INVITE_SPEEDUP | yes | [boats.md](boats.md) |
| 5 | BOAT_UPGRADE_ASSIST_SPEEDUP | yes | [boats.md](boats.md) |
| 6 | BOAT_UPGRADE_SPEEDUP | no | [boats.md](boats.md) |
| 7 | BOAT_UPGRADE_FINISHED | no | [boats.md](boats.md) |
| 8 | STREANTH_BUY | yes | this file |
| 9 | PORT_REFRESH_TASK | yes | [ports.md](ports.md) |
| 10 | PORT_ABORT_TASK | yes | [ports.md](ports.md) |
| 11 | PORT_ACCEPT_TASK | yes | [ports.md](ports.md) |
| 12 | PORT_NEW_TASK | no | [ports.md](ports.md) |
| 13 | SHOP_MAIN | no | [shop.md](shop.md) |
| 14 | SHOP_BUY_DATA | yes | [shop.md](shop.md) |
| 15 | SHOP_REFRESH | yes | [shop.md](shop.md) |
| 16 | FISHING_START | yes | [fishing.md](fishing.md) |
| 17 | FISHING_STOP | no | [fishing.md](fishing.md) |
| 18 | FISHING_REWARD | no | [fishing.md](fishing.md) |
| 19 | PORT_UPGRADE | yes | [ports.md](ports.md) |
| 20 | PAY_BUSINESS | yes | [ports.md](ports.md) |

Payment flag convention used by ops 0, 8, 9 and 15: the client passes `0` when the player ticked "use bound diamonds" (bound "giftToken" first, then real) and `1` for real diamonds only (`NAV/NavigationFrame.as:219-227`, `decompiled/core_module/scripts/utils/LogicUtils.as:80-90`).

### R1. Buy strength (op 8)

- UI: strength "+" button (`NAV/NavigationFrame.as:206-217`).
- Client checks: `dayBuyStrengthNum < navigation_strength_buy_num (2)` else "Limite de compras diárias atingiu o limite"; confirmation (with "do not ask again" via `NotAlertManager`) "Deseja consumir {0} diamantes para comprar {1} pontos de movimento? (Hoje pode comprar {2} vez(es))" with cost `navigation_strength_buy_point (100)`, amount `navigation_strength_default (100)`; diamonds check `judgePointEnoughToShowPay(100, useBound)` else recharge.
- Request: `op = 8`, `param1 = ""`, `param2 = ""`, `param3 = useBound ? 0 : 1`.
- Expected: 341 `{op: 8, result}`, 342 with `strength` and `dayBuyStrengthNum`, player info 3 (diamonds).

## 4. Server messages (server to client)

### 342 (0x0156) `U_C_NAVIGATION_DATA_MSG`

`NavigationMsg` (package `pet`). Receivers: `NavigationManager.__updateNavigationData` (`NM:91-199`, listener `NM:60`) and `QueueBarManager.__updateNavigationData` (`decompiled/core_module/scripts/yishi/manager/QueueBarManager.as:425-469`, counts ports with no ship and elapsed `cd`, `n/3`). Scalar fields are applied only when present (`has*`). Repeated fields decode to an array that is never null, so `buyData`, `port` and `boat` replace the client lists on every 342 (`NM:138-197`): always send all ports, all ships and all 6 shop rows in every 342. `fishingTipsList` is appended only when non empty (`NM:131-137`).

| Field | Tag, type | Meaning | Client use |
|---|---|---|---|
| `strength` | #1, INT32 | current strength | bar, checks |
| `currency` | #2, INT32 | "Moedas de Navegação" balance | ship/port upgrades, shop |
| `dayBuyShopNum` | #3, INT32 | shop purchases today | [shop.md](shop.md) |
| `dayBuyStrengthNum` | #4, INT32 | strength purchases today | R1 |
| `shopRefreshCD` | #5, INT64 | epoch ms of the next free shop refresh | `/1000`, [shop.md](shop.md) |
| `inviteNum` | #6, INT32 | invitations sent today | [boats.md](boats.md) |
| `assistNum` | #7, INT32 | assists given today | [boats.md](boats.md) |
| `buyData` | #8, `NavigationBuyDataMsg`, repeated | shop rows: `shopId` (#1, INT32) shop template id, `index` (#2, INT32) slot 0..5, `buy` (#3, BOOL) already bought | [shop.md](shop.md) |
| `port` | #9, `NavigationPortMsg`, repeated | 3 ports, sorted by `id` | [ports.md](ports.md) |
| `boat` | #10, `NavigationBoatMsg`, repeated | owned ships, sorted by `id` | [boats.md](boats.md) |
| `fishingTime` | #11, INT32 | fishing seconds accumulated today | [fishing.md](fishing.md) |
| `fishingTipsList` | #12, STRING, repeated | reward lines appended to the fishing log | [fishing.md](fishing.md) |

After applying, the client notifies `NAVIGATION_DATA_CHANGE`; every open navigation frame refreshes.

When: login (full state), after every 9600 op, on timers (expedition return, ship rest end, upgrade end, fishing tick), at the daily reset.

### 341 (0x0155) `U_C_NAVIGATION_MSG`

- `NavigationResMsg`: `op` (#1, ENUM `NavigationOpState`) the op handled or the state event; `result` (#2, BOOL) success (not read by the client).
- Receiver `NavigationManager.__updateNavigationOpState` (`NM:64-77`, listener `NM:59`): stores `model.op`; `op == 11` or `op == 16` closes the ship selection frames (`NAVIGATION_PATROL_CLOSE`, also closes the port frame, `NAV/NavigationPortFrame.as:311-314`).
- `NavigationPortFrame` ignores the next 342 when `model.op` is 17 or 18 (`NAV/NavigationPortFrame.as:316-323`), so fishing ticks must send 341 op 17/18 before their 342.
- When: after every request (same op), and for server events (1, 2, 7, 12, 17, 18) before the matching 342.

## 5. Rules and formulas

Config (`raw/xml/tempinfos/ConfigInfos.xml`, getters `CFG:252-339`, `:972-998`, `:1956-1977`):

| Key | Value | Meaning |
|---|---|---|
| `navigation_strength_default` | 100 | daily strength, also strength per purchase |
| `navigation_strength_shipping` | 20 | strength per expedition |
| `navigation_strength_buy_point` | 100 | diamonds per strength purchase |
| `navigation_strength_buy_num` | 2 | strength purchases per day |
| `navigation_strength_assist_speedup` | 20 | strength per friend assist |

- Daily reset (assumption 00:00 server time): `strength = 100` (assumption: reset, not added), `dayBuyStrengthNum = 0`, `dayBuyShopNum = 0`, `inviteNum = 0`, `assistNum = 0`, `fishingTime = 0`, port `payBusinessNum = 0`.
- Hero level >= 80 for every op (entry check, enforce server side).

## 6. Templates

Config keys above. Other templates are listed in each module.

## 7. Persistent state

Schema `navigation`.

```sql
CREATE TABLE navigation.player_state (
  player_id             BIGINT     PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
  strength              INTEGER     NOT NULL DEFAULT 100 CHECK (strength >= 0),
  currency              INTEGER     NOT NULL DEFAULT 0 CHECK (currency >= 0),
  day                   DATE        NOT NULL,
  strength_buys_today   SMALLINT    NOT NULL DEFAULT 0,
  shop_buys_today       SMALLINT    NOT NULL DEFAULT 0,
  invites_today         SMALLINT    NOT NULL DEFAULT 0,
  assists_today         SMALLINT    NOT NULL DEFAULT 0,
  fishing_seconds_today INTEGER     NOT NULL DEFAULT 0,
  shop_refresh_at       TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at            TIMESTAMPTZ NOT NULL DEFAULT now()
);
```

`currency` may instead live in the shared currency ledger (`mvc.module.currency.CurrencyType.type101` "Moedas de Navegação"); keep one source of truth (open question).

## 8. Backend implementation notes

- `navigation::hub::handle_op` is the 9600 entry: decode `NavigationOpMsg`, lazily roll the daily row, dispatch by op to the module handlers, then always send 341 `{op, result}` followed by 342 built by `navigation::hub::build_state(player)` (all fields, all lists).
- `navigation::hub::handle_buy_strength` (op 8): `strength_buys_today < 2` -> charge 100 diamonds honoring `param3` (0 bound first, 1 real only) -> `strength += 100`, `strength_buys_today += 1`; push player info 3.
- `navigation::hub::login_push`: 342 full state, then 178 fishing window state ([fishing.md](fishing.md)).
- Scheduler: one per-player timer queue for ship returns, rest ends, upgrade ends ([boats.md](boats.md), [ports.md](ports.md)) plus the global fishing windows. On each event persist, send 341 with the event op, then 342.
- Daily reset job at 00:00 for all rows, push 342 to online players.

## 9. Open questions and assumptions

- Whether daily strength resets to 100 or is added (assumed reset), and whether it can exceed 100 after purchases (the bar is capped visually at 100%).
- `result = false` has no client message; error tips are client side only, so the server should reject silently and resend 342.
- Navigation coins storage (own column vs currency ledger).

## 10. Implementation checklist

- [ ] Screen: `NavigationFrame` harbor, strength bar, build views with countdowns
- [ ] Route R1 op 8 buy strength
- [ ] Server message 342 full state builder
- [ ] Server message 341 result and event ops
- [ ] Table `navigation.player_state`
- [ ] Config loader for `navigation_*` keys
- [ ] Daily reset job
- [ ] Per player timer queue (ship and port events)
- [ ] Test: 342 lists always complete (client replaces lists)
- [ ] Test: strength purchase cap and bound diamond flag
