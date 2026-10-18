# Hermitage war lobby

Module `hermitage_war::lobby`. Citation prefixes: see [README.md](README.md).

## 1. Overview

Shows the daily windows, the time left in the current window and the remaining result rewards today, and lets the player enter the battlefield or open the Merit shop. Entering puts the player into a war instance (30 players, two camps) and the server answers with the full map snapshot 544, which switches the client to `SECRET_WAR_SCENE` ([battlefield.md](battlefield.md)).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `war2023.SecretwarEnterFrame` (772x565, `M3/war2023/SecretwarEnterFrame.as:79`) containing `war2023.view.SecretWarEnterView` | Batalha do Eremitério (`secretwar.warEnter.title`) | Lobby | toolbar `secretwar` | two upcoming windows "HH:MM-HH:MM" from `secret_war_open_time` + `secret_war_keep_time[1]` (`M3/war2023/view/SecretWarEnterView.as:46-160`); countdown to `stopTime` while open (`:191-216`); "Prêmios de resultados restantes da Batalha: {0}/{1}" (`:218-226`); buttons Entrar (enabled only when `isOpen`), Loja; help `secretwar.helpContent` |

## 3. Routes (client to server)

All routes: C to S 9725 (0x25fd) `C_SECRET_WAR_CLIENT_OP`, `player.PlayerOpMsg`; sender `SecretWarManager.gameOp(op, nodeId = -1, type = -1)` (`SWM:354-362`) always writes `op` (#1, INT32), `nodeId` (#10, INT32) and `type` (#2, INT32). Op constants `CM/mvc/module/war2023/SecretwarConst.as:32-44`.

| # | Action | UI / sender | Client checks | Request | Response |
|---|---|---|---|---|---|
| L1 | Open lobby | `SecretWarEnterView` constructor (`M3/war2023/view/SecretWarEnterView.as:38-44`) | none | `op = 0` OP_OPEN, `nodeId = -1`, `type = -1` | 550 (reward counter); 4590 if the state changed (A) |
| L2 | Enter | "Entrar" -> `enterHandler` (`SecretWarEnterView.as:236-254`) | button enabled only while `SecretWarManager.isOpen`; forbidden in the last 5 min of the window: "Faltam menos de 5 minutos para o fim do evento. Entrada não permitida." (`secretwar.forbidenTip`); when `rewardCount >= secret_war_max_reward` confirm "Você não poderá ganhar os prêmios de resultados desta Batalha do Eremitério. Deseja combater mesmo assim?" (`:244-250,256-262`) | `op = 1` OP_ENTER | 544 `SecretWarCreateMsg` (scene switch); on refusal a system tip (A) |
| L3 | Open shop | "Loja" (`SecretWarEnterView.as:263-266`) | none | opens `secretwar` openType 5; see [../shops/exploits-shop.md](../shops/exploits-shop.md) | 540 |

Server-side checks for L2 (A, from help text and toolbar): divine class (`vocationIndex >= 3`), window open and more than 5 min left, not exiled (left a war less than 5 min ago, `secretwar.leaveTip`), not in another scene/battle.

## 4. Server messages (server to client)

| Opcode | Message | Receiver | When | Client effect |
|---|---|---|---|---|
| 4590 (0x11ee) `U_C_TOP_TOOL_BTN` | `simple.PropertyMsg` {`param1` (#1, INT32) = 4029 (toolbar template), `param7` (#7, BOOL) open, `param4` (#4, STRING) open time "YYYY-MM-DD hh:mm:ss", `param5` (#5, STRING) stop time} | `SWM.__topBtnHandler` (`SWM:84,114-126`) | login and each window open/close (generic toolbar push shared with other buttons, only `param1 == 4029` is read here) | `isOpen`, `openTime`, `stopTime`; `REFRESH_TOPTOOLS` enables Entrar and the countdown |
| 550 (0x0226) `U_C_SECRET_WAR_USER_DATA` | `secretwar.SecretWarUserDataMsg` {`rewardCount` (#1, INT32) result rewards already received today, `rewardShow` (#2, STRING) last reward "itemId,count"} | `SWM._rewardHandler` (`SWM:85,104-112`) | reply to op 0; after a war result | lobby counter; result frame reward ([results.md](results.md)) |
| 544 `U_C_SECRET_WAR_CREATE` | see [battlefield.md](battlefield.md) | `SWM.__creatMapHandler` (`SWM:78,128-150`) | reply to op 1, and on reconnect | scene `SECRET_WAR_SCENE` |
| 6 `U_C_PLAYER_LOGINSTATEE` | `LoginStateMsg` {`playerId`, `state`}; `state = 8` = inside a secret war | `BaseManager.__loginStateHandler` (`CM/yishi/manager/BaseManager.as:1904-1939`) | login | `loginToSecretWarFlag = true`; space scene is skipped (`CM/yishi/SwitchPageHelp.as:684-687`) and the server must follow with 544 |

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Windows | `secret_war_open_time` = `14:00|16:00` | `TPL/ConfigInfos.xml` |
| Durations | `secret_war_keep_time` = `5,20`: 5 min preparation, 20 min round | ConfigInfos; help "14h00 às 14h20 e 16h00 às 16h20" |
| Entry cut-off | 5 min before the round end | `SecretWarEnterView.as:36,240-243` |
| Max players per war | 30 (both camps) | `secret_war_max_player` |
| Camp assignment | random | help item 3 |
| Level bands | 30-49, 50-80, and the three job-advance phases (help text); the client only allows divine class to open the lobby | `secretwar.helpContent` item 1; `TopToolsBar.as:1521-1530` |
| Daily result rewards | `secret_war_max_reward` = 1 (help text says 2 per day, reset at midnight) | ConfigInfos; `SecretWarEnterView.as:59-63` |
| Item cap | `secret_war_limit` = `-5500,1000`: item -5500 (Mérito) capped at 1000 (A: per day) | ConfigInfos |
| Exile | leaving mid-war blocks re-entry for 5 min | `secretwar.leaveTip` |

## 6. Templates

| File | Keys |
|---|---|
| `TPL/ConfigInfos.xml` | `secret_war_open_time`, `secret_war_keep_time`, `secret_war_cd_time`, `secret_war_max_score`, `secret_war_max_player`, `secret_war_node_score`, `secret_war_max_reward`, `secret_war_limit`, `secret_war_win_score` |
| `TPL/TopToolBtnInfos.xml` | row 4029 `BtnKey="secretwar"` |

## 7. Persistent state

```sql
CREATE TABLE hermitage_war.player_daily (
  player_id       BIGINT NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  day             DATE NOT NULL,
  reward_count    SMALLINT NOT NULL DEFAULT 0,
  merit_gained    INTEGER NOT NULL DEFAULT 0,
  last_reward     TEXT NOT NULL DEFAULT '',
  exiled_until    TIMESTAMPTZ,
  PRIMARY KEY (player_id, day)
);
```

## 8. Backend implementation notes

- Scheduler per window: at `open - 0` (A: entry opens at the window start, the first 5 min are preparation) broadcast 4590 `param7 = true` with `param4`/`param5`; at `open + 5 + 20 min` close.
- `hermitage_war::lobby::handle_open` (op 0): reply 550 from `player_daily`.
- `hermitage_war::lobby::handle_enter` (op 1): validate class, window, cut-off, exile; pick or create a war instance for the player's band with free capacity (<= 30), assign the camp with fewer players (A: help says random), place the player on the camp birth node (7 blue, 11 red), send 544 to the player and 545 (player list delta) to the others.
- Reconnect: if a player logs in while registered in a running instance, send login state 8, then 544.
- All instance state is in memory; only daily counters and results are persisted ([results.md](results.md)).

## 9. Open questions and assumptions

- (A) Help text says 2 rewards per day; config says 1. Use config.
- (A) Server answer to op 0 is 550 only; 4590 already arrives at login.
- (A) Band matchmaking rules and cross-server pooling.
- (A) Whether the preparation phase allows entering only, or also moving (client blocks moves until `preTime`, see [battlefield.md](battlefield.md)).

## 10. Implementation checklist

- [ ] Config loader for `secret_war_*`.
- [ ] Window scheduler, 4590 broadcast and login push.
- [ ] Op 0 -> 550.
- [ ] Op 1 enter with all checks, instance allocation, camp assignment, 544.
- [ ] Exile on leave (5 min) and refusal on re-entry.
- [ ] Login state 8 and reconnect snapshot.
- [ ] Table `player_daily`.
- [ ] Tests: enter at T-4 min, enter with reward cap reached, enter non divine class, instance full.
