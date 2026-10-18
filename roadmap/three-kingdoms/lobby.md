# Lobby and entry

Aliases: see [README.md](README.md). Extra aliases: TBC = `decompiled/core_module/scripts/ui/toptoolbar/TopBtnCheckShowHelper.as`, TTB = `decompiled/core_module/scripts/ui/toptoolbar/TopToolsBar.as`.

## 1. Overview

The lobby is a full screen frame showing the three servers of the match (Muspel, Nifl, Jötun) and the next opening date, with buttons to enter the battlefield, open the shop, the ranking, the reward list and the help. The server drives a global state (`gameState`): 0 closed, 1 preliminary round running, 2 final round running (inferred from the score and rank getters, `GMOD:103-158`). All lobby requests use C>S 5101 `C_GODS_CLIENT_OP` with `gods.CrossGodsMsg.op_type`:

| op_type | Sender | Module |
|---|---|---|
| 1 | `sendEnterCampaign` (`GEM:413-419`) | this module |
| 2 | `sendRequestMainFrameInfo` (`GEM:396-402`) | this module |
| 3 | `sendRequstMainFrameRankInfo(tab)` (`GEM:404-411`) | [rankings-rewards.md](rankings-rewards.md) |
| 4 | `sendInspire(0)` (`GEM:442-449`) | [battlefield.md](battlefield.md) |

`CrossGodsMsg` fields: `op_type (#1, INT32)`, `info (#2, CrossGodsInfoMsg, repeated)`, `playerInfo (#3, GodsPlayerInfoMsg, repeated)`, `gameType (#4, INT32)`, `param1 (#5, INT64)`, `param2 (#6, INT64)`, `param3 (#7, INT32)`, `param4 (#8, INT32)`, `taskInfo (#9, GodsTaskInfoMsg, repeated)`, `server_name (#10, STRING)`, `user_id (#11, INT32)`, `my_info (#12, GodsPlayerInfoMsg)`, `openTime (#13, STRING)`, `stopTime (#14, STRING)`.

`CrossGodsInfoMsg` (one per server/team): `game_key (#1, STRING)`, `server_name (#2, STRING)`, `fight_power (#3, INT32)`, `score (#4, INT32)`, `server_id (#5, INT32)`, `readyScore (#6, INT32)`, `readyOrder (#7, INT32)`, `finalScore (#8, INT32)`, `finalOrder (#9, INT32)`, `lordsInfo (#10, STRING)`, `goddessInfo (#11, STRING)`, `group_id (#12, INT32)`, `team_id (#13, INT32)`, `rank (#14, INT32)`, `buffer_lv (#15, INT32)`.

`GodsPlayerInfoMsg` (one per player): `game_key (#1, STRING)`, `server_name (#2, STRING)`, `nick_name (#3, STRING)`, `template_id (#4, INT32)`, `slotAvata (#5, STRING)`, `clothAvate (#6, STRING)`, `hatAvata (#7, STRING)`, `wingAvata (#8, STRING)`, `fashionArmAvata (#9, STRING)`, `fashionClothAvata (#10, STRING)`, `team_id (#11, INT32)`, `id (#12, INT32)`, `readyScore (#13, INT32)`, `readyOrder (#14, INT32)`, `finalScore (#15, INT32)`, `finalOrder (#16, INT32)`, `rank (#17, INT32)`, `uuid (#18, STRING)`, `fight_power (#19, INT32)`, `user_id (#20, INT32)`, `head_id (#21, INT32)`.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `godsevening.GEMainFrame` (GMF), default `openType` (`GEC:37-50`) | none (full screen) | Hides the HUD (`GMF:146-160`), sets `isInGodsEveningFrame` (`GMF:52-59`) | top bar `godsevening` (`TTB:1429-1431`) | hosts `GEMainView` |
| `godsevening.GEMainView` (GMV) | team names `_team1.._team3` = server names by team id; opening date digits; closed image after `endTime` (`GMV:256-288`) | Lobby | GMF | 242 data |
| Help frame | "Explicação da Hegemonia dos Três Reinos" | Rules text `godsEvening.GERankFrame.helpContent` | help button (`GMV:249-254`) | static |

Buttons (`GMV:193-247`): enter; shop opens `openControllerByInfo("shop", 35)`; rank opens `godsevening` openType 1; check reward opens openType 2.

## 3. Routes (client to server)

### R1. Lobby info (op 2)

- UI: `GEMainView` constructor (`GMV:74`).
- Sender: `GodsEveningManager.sendRequestMainFrameInfo` (`GEM:396-402`).
- Route: C>S 5101 (0x13ed) `C_GODS_CLIENT_OP`, `CrossGodsMsg` with `op_type (#1)` = 2.
- Response: S2 242.

### R2. Enter the battlefield (op 1)

- UI: enter button (`GMV:193-216`).
- Client checks: `vocationGrades > 0` else "Os jogadores apenas podem entrar depois de realizar a Profissão Avançada." (`GMV:200-204`). When `isForceQuit` is set and `gameState != 0`: confirm "Você já participou desta edição da Hegemonia dos Três Reinos, vai receber o prêmio final mesmo que não volte a entrar! Confirma que deseja voltar a entrar?" (`GMV:205-214`, `GMV:223-229`).
- Sender: `sendEnterCampaign` (`GEM:413-419`). Fields: `op_type` = 1.
- Response: campaign instance creation for map 8501 (125, 21, 127, see [../campaign/README.md](../campaign/README.md)), then 245, 247, 4175 ([battlefield.md](battlefield.md)). On refusal (closed, no profession, not in a grouped server) a generic alert.

## 4. Server messages (server to client)

### S1. 246 (0x00f6) `U_C_GODS_STATE`

`simple.PropertyMsg` (fields: `param1 #1 INT32`, `param2 #2 INT32`, `param3 #3 INT32`, `param4 #4 STRING`, `param5 #5 STRING`, `param6 #6 STRING`, `param7 #7 BOOL`, `param8 #8 BOOL`, `param9 #9 BOOL`, `param10 #10 INT32`, `param11 #11 INT32`, `param12 #12 STRING`). Receiver `GEM.__stateHandler` (`GEM:177-186`): `gameState = param1`, `isShowIcon = param7`, refreshes the top bar; `godsEveningLightState = gameState` (shine when 1).

When: at login and on every state change (push to all online players of the participating servers).

### S2. 242 (0x00f2) `U_C_GODS_INFO`

`CrossGodsMsg`. Receiver `GEM.__mainInfoHandler` (`GEM:188-201`): `gameState = gameType (#4)`, `openTime = openTime (#13)`, `endTime = stopTime (#14)` (format `YYYY-MM-DD hh:mm:ss`), `teamDataDic[team_id] = server_name` for each `info` row; refreshes GMV. When: response to op 2. Note: `endTime` must always be present, GMV dereferences it (`GMV:283`).

### S3. 4483 (0x1183) `U_WARFIELD_FORCE_QUIT`

`simple.PropertyMsg`. Receiver `BaseManager.__forceQuitBattleCampaign` (`BM:319`, `BM:1445-1470`): alert queued; `param1 == 3` sets `GodsEveningModel.isForceQuit = true` and shows "O sistema expulsa automaticamente jogadores inativos que não realizem qualquer ação durante cinco minutos.\nVocê já participou desta edição da Hegemonia dos Três Reinos, vai receber o prêmio final mesmo que não volte a entrar!"; `param1 == 2` is the generic battlefield text; other values the vocation battle text. When: the server removes a player idle for 5 minutes from map 8501, followed by the campaign exit 22.

## 5. Rules and formulas

- Eligibility: advanced profession (`vocationGrades > 0`, client and top bar).
- Top bar (`TBC:365-366`): `isShowIcon && vocationGrades > 0 && VersionSwitch.GODS_EVENING && scene in {CASTLE_SCENE, SPACE_SCENE}` (`TBC:506-513`).
- Idle kick: 5 minutes without action (text of 4483).
- Teams: three servers per match, team ids 1..3; names Muspel, Nifl, Jötun (`godsEvening.chatData.team1..3`).
- Schedule (assumption): preliminary round (`gameState` 1) and final round (`gameState` 2) on configured days; `openTime` / `stopTime` cover the current event.
- Re-entry after a kick is allowed with confirmation.

## 6. Templates

| File | Use |
|---|---|
| `raw/xml/tempinfos/TopToolBtnInfos.xml` | 4017 `godsevening` |
| `raw/xml/tempinfos/MapInfos.xml` | map 8501 "Hegemonia dos Três Reinos", 8000 x 6000, `BattleGround` 15 |

## 7. Persistent state

```sql
CREATE SCHEMA IF NOT EXISTS three_kingdoms;

CREATE TABLE three_kingdoms.events (
    event_id    bigserial   PRIMARY KEY,
    opens_at    timestamptz NOT NULL,
    closes_at   timestamptz NOT NULL,
    game_state  smallint    NOT NULL DEFAULT 0 CHECK (game_state IN (0, 1, 2)),
    show_icon   boolean     NOT NULL DEFAULT false
);

CREATE TABLE three_kingdoms.match_teams (
    event_id     bigint   NOT NULL REFERENCES three_kingdoms.events(event_id) ON DELETE CASCADE,
    group_id     integer  NOT NULL,
    team_id      smallint NOT NULL CHECK (team_id IN (1, 2, 3)),
    server_id    integer  NOT NULL,
    server_name  text     NOT NULL,
    fight_power  bigint   NOT NULL DEFAULT 0,
    ready_score  integer  NOT NULL DEFAULT 0,
    ready_order  smallint,
    final_score  integer  NOT NULL DEFAULT 0,
    final_order  smallint,
    inspire_level smallint NOT NULL DEFAULT 0 CHECK (inspire_level BETWEEN 0 AND 10),
    PRIMARY KEY (event_id, group_id, team_id),
    UNIQUE (event_id, server_id)
);

CREATE TABLE three_kingdoms.participants (
    event_id     bigint   NOT NULL REFERENCES three_kingdoms.events(event_id) ON DELETE CASCADE,
    player_id    bigint   NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
    server_id    integer  NOT NULL,
    team_id      smallint NOT NULL,
    ready_score  integer  NOT NULL DEFAULT 0,
    ready_order  integer,
    final_score  integer  NOT NULL DEFAULT 0,
    final_order  integer,
    force_quit   boolean  NOT NULL DEFAULT false,
    first_entered_at timestamptz NOT NULL DEFAULT now(),
    PRIMARY KEY (event_id, player_id)
);
CREATE INDEX participants_ready_idx ON three_kingdoms.participants (event_id, ready_score DESC);
CREATE INDEX participants_final_idx ON three_kingdoms.participants (event_id, final_score DESC);
```

## 8. Backend implementation notes

- `three_kingdoms::lobby::handle_client_op` (5101) dispatches on `op_type`.
- `handle_info` (op 2): reply 242 with `gameType = game_state`, `openTime`, `stopTime`, `info` rows (`team_id`, `server_name`) of the caller's group.
- `handle_enter` (op 1): validation: event state 1 or 2, caller's server grouped, `vocation_grade > 0`. Insert participant (first entry), clear `force_quit`, create or join the map 8501 instance of the group, place the player at the team spawn, send the campaign sequence and 245 / 247.
- Scheduler: state changes push 246 to all online players (`param1` state, `param7` show icon).
- Idle detector: 5 minutes without movement or action on map 8501: set `force_quit`, send 4483 (`param1` 3), remove the player (22).

## 9. Open questions and assumptions

- Open: `VersionSwitch.GODS_EVENING` is false; decide whether to enable the feature.
- Assumption: meaning of `gameState` values and the round schedule.
- Assumption: cross-server grouping of 3 servers per `group_id`.

## 10. Implementation checklist

- [ ] Screen GMF / GMV with date and team names.
- [ ] Routes 5101 op 1 and op 2.
- [ ] Server messages 246, 242, 4483.
- [ ] Tables `three_kingdoms.events`, `three_kingdoms.match_teams`, `three_kingdoms.participants`.
- [ ] Idle kick job.
- [ ] Tests: player without advanced profession is refused; 242 without `stopTime` must never be sent.
