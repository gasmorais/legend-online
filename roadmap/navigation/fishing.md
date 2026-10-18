# Navigation ship fishing

Feature [navigation](README.md), module `fishing`. Aliases in [README.md](README.md). Common request/response format in [hub.md](hub.md). Not to be confused with the "Pesca" feature ([fishing](../fishing/README.md)).

## 1. Overview

- Twice a day (`navigation_fishing_time = 12:00,12:30|17:30,18:00`) the harbor opens a fishing window. The server announces it with push 178.
- During the window the player sends one or more idle ships fishing ("Clique para selecionar a embarcação a enviar. Você pode gastar diamantes para enviar várias embarcações e ganhar mais prêmios."). The first ship is free, more ships cost diamonds (`navigation_ship_consumption = 0,20,40,60,80` for 1..5 ships).
- Every `navigation_fishing_reward_interval = 20` seconds each fishing ship yields a reward; a player can receive at most `navigation_fishing_reward_max = 30` rewards per day (`fishingTime / 20 >= 30` blocks the button, `NMOD:164-168`). Fishing continues with the window closed ("Você pode seguir pescando com a janela fechada").
- Reward lines are appended to the log area of `NavigationFrame`.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `NAV/NavigationFrame.as` fishing panel | "Horário de pesca:" + configured windows (`:129-131`); "Você pode seguir pescando com a janela fechada" | Fishing button, animation, reward log (`:178-188`, `:249-289`) | harbor | `fishOpen`, `isBoatFishing` (any ship `state == 4`), `fishRewardList` |
| `NAV/NavigationBoatPatrolFrameII.as` (595 x 380) | "Navios de Expedição"; "Nº de embarcações selecionadas: {0}" | Multi select idle ships, price by count, confirm (`:52-218`) | fishing button, openType 7 with `{type: 16}` (`NAV/NavigationFrame.as:178-188`) | ships (`NAV/NavigationBoatItemII.as:73-98`, only `state == 0` selectable), price |
| `NAV/NavigationBoatPatrolFrame.as` type 16 | "Navios de Expedição" | Single ship variant, sends op 16 with one id (`:144-147`) | openType 6 with `{type: 16}` (no caller in this build) | |

## 3. Routes (client to server)

### R1. Start fishing (op 16)

- UI: confirm in `NavigationBoatPatrolFrameII` (`:163-176`).
- Client checks: fishing count not exhausted ("Já atingiu o número máximo de pescas.", `NAV/NavigationFrame.as:178-184`); fishing panel visible only while `fishOpen`; fishing button disabled while a ship already fishes; at least one ship selected; `allPoint >= navigation_ship_consumption[count - 1]` else recharge (`:183-197`).
- Request: `op = 16`, `param1 = ""`, `param2 = "boatId1,boatId2,..."` (comma joined ship ids).
- Expected: 341 `{op: 16}` (closes the selection frame), 342 with the ships in `state = 4`, player info 3 if diamonds were spent.

## 4. Server messages (server to client)

### 178 (0x00b2) `U_C_NAVIGATION_FISHING_STATE`

- `NavigationFishingStateMsg` (package `pet`): `open` (#1, BOOL) window open; `startTime` (#2, INT64) and `endTime` (#3, INT64) window bounds in epoch ms (not read by the client).
- Receiver `NavigationManager.__updateNavigationFishState` (`NM:79-89`, listener `NM:61`): sets `fishOpen`, notifies `FISHING_STATE_CHANGE` (fishing panel shown or hidden).
- When: login (current state), at each window start (`open = true`) and end (`open = false`), to all online players with navigation unlocked.

### 341 events

- `{op: 18}` FISHING_REWARD each tick, followed by 342 with `fishingTime` (#11) increased and `fishingTipsList` (#12) carrying the new reward lines (HTML strings shown as is).
- `{op: 17}` FISHING_STOP at the window end or when the reward cap is reached, followed by 342 with ships back to `state = 0`.
- The port frame skips refreshes while `model.op` is 17 or 18 (`NAV/NavigationPortFrame.as:316-323`).

## 5. Rules and formulas

| Key | Value | Meaning (getter) |
|---|---|---|
| `navigation_fishing_time` | `12:00,12:30\|17:30,18:00` | windows (`CFG:990-998`, default `11:30,12:00`, `18:00,18:30`) |
| `navigation_fishing_reward_interval` | 20 | seconds per reward tick (`CFG:972-980`, default 120) |
| `navigation_fishing_reward_max` | 30 | max rewards per day (`CFG:981-989`, default 10) |
| `navigation_ship_consumption` | `0,20,40,60,80` | diamonds by number of ships (`CFG:1965-1977`) |

- `fishingTime` counts fishing seconds today; the client computes rewards received as `fishingTime / interval` (`NMOD:164-168`). Assumption: one tick adds `interval` seconds once per tick regardless of ship count, and each fishing ship produces one reward line per tick.
- Reward table is not in client data (open question).

## 6. Templates

Config keys above. No reward template in the client.

## 7. Persistent state

`navigation.ship.state = 4` marks fishing ships ([boats.md](boats.md)); `navigation.player_state.fishing_seconds_today` ([hub.md](hub.md)).

```sql
CREATE TABLE navigation.fishing_reward_log (
  id          BIGSERIAL   PRIMARY KEY,
  player_id   INTEGER     NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  ship_id     UUID        REFERENCES navigation.ship(ship_id) ON DELETE SET NULL,
  item_id     INTEGER     NOT NULL,
  count       INTEGER     NOT NULL CHECK (count > 0),
  granted_at  TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX fishing_reward_log_player_idx ON navigation.fishing_reward_log (player_id, granted_at DESC);
```

## 8. Backend implementation notes

- `navigation::fishing::handle_start` (op 16): window open -> rewards today < max -> every id in `param2` owned and `state = 0` -> charge `consumption[n - 1]` diamonds (bound first) -> ships `state = 4`.
- Global scheduler `navigation::fishing::window_job`: at start push 178 `open = true`; at end push 178 `open = false`, stop all fishing ships (event op 17 + 342 per player).
- Tick job every 20 s during the window: for each player with fishing ships and `fishing_seconds_today / 20 < 30`, grant one reward per ship, add 20 s, push 341 `{op: 18}` and 342 with `fishingTipsList`; when the cap is reached stop (event 17).
- Offline players keep fishing (rewards granted by the tick job).

## 9. Open questions and assumptions

- Reward pool and the text format of `fishingTipsList` lines.
- Whether the cap counts ticks or reward lines (multi ship).
- Whether the window state 178 is also sent at login (assumed).

## 10. Implementation checklist

- [ ] Screen: fishing panel in `NavigationFrame`
- [ ] Screen: `NavigationBoatPatrolFrameII` multi ship selection
- [ ] Route R1 op 16 start fishing
- [ ] Server message 178 window state
- [ ] Events 341 op 17 and op 18 with 342
- [ ] Table `navigation.fishing_reward_log`
- [ ] Scheduler: windows and 20 s ticks
- [ ] Test: diamond price by ship count
- [ ] Test: daily cap 30
