# Steel lobby ("Batalha de Ferro")

Aliases: see [README.md](README.md). Extra aliases:

| Alias | File |
|---|---|
| BM | `decompiled/core_module/scripts/yishi/manager/BaseManager.as` |
| FCM | `decompiled/core_module/scripts/yishi/manager/FrameControllerManager.as` |
| MTB | `decompiled/core_module/scripts/ui/maintoolbar/MainToolBar.as` |

## 1. Overview

The lobby is a full screen frame that shows the next opening date of the cross-server team war and gives access to the team screens ("A minha Aliança" or "Entrar na Aliança"), the vehicle selection, the ranking and the help. All steel traffic from the client uses one request opcode, 8962 `C_STEEL_PLAYER_OP`, with `steel.SteelTeamInfoMsg.param1` as the operation code (`SM:20-48`):

| op | Constant | Module |
|---|---|---|
| 1 | `PLAYER_OP_CREATETEAM` | [steel-teams.md](steel-teams.md) |
| 2 | `PLAYER_OP_KILLPLAYER` | [steel-teams.md](steel-teams.md) |
| 3 | `PLAYER_OP_INVTPLAYER` | [steel-teams.md](steel-teams.md) |
| 4 | `PLAYER_OP_APPLYENTER` | [steel-teams.md](steel-teams.md) |
| 5 | `PLAYER_OP_CHANGEMAST` | [steel-teams.md](steel-teams.md) |
| 6 | `PLAYER_OP_ENTER` | [steel-battle.md](steel-battle.md) |
| 7 | `PLAYER_OP_LISTUSERS` | [steel-teams.md](steel-teams.md) |
| 8 | `PLAYER_OP_LISTTEAMS` | [steel-teams.md](steel-teams.md) |
| 9 | `PLAYER_OP_MYTEAM` | this module |
| 10 | `PLAYER_OP_CANCLEAPPLY` | [steel-teams.md](steel-teams.md) |
| 11 | `PLAYER_OP_APPLYLIST` | [steel-teams.md](steel-teams.md) |
| 12 | `PLAYER_OP_AGREEAPPLY` | [steel-teams.md](steel-teams.md) |
| 13 | `PLAYER_OP_INVITE_STATE` | [steel-teams.md](steel-teams.md) |
| 14 | `PLAYER_OP_EXITTEAM` | [steel-teams.md](steel-teams.md) |
| 15 | `PLAYER_OP_ORDERLIST` | [steel-ranking.md](steel-ranking.md) |

**Reachability:** no client code opens `steel.SteelFrame` (the default `openType` of controller key `steelmap`, `SC:63-80`). The controller is created at boot (`FCM:580`) and its socket listeners are always registered (`SC:93-104`), so pushes are processed, but the player has no way to open the lobby in this build. Implement the protocol so the frames work if an entry is added (for example a top bar key); this is flagged in section 9.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `steel.view.SteelFrame` (SF) | none (full screen, background `asset.steelmap.steelFrameBg`) | Hides the HUD (`SF:132-147`), sets `isInSteelFrame = true` (`SF:171`), closes on `CLOSE_STEEL_FRAME` (main bar "Voltar", `MTB:1557,1581`) or `SWITCH_SCENE` | `openControllerByInfo("steelmap")` (no caller) | hosts `SteelView` |
| `steel.view.SteelView` (SV) | buttons "Entrar" (join battle), link "A minha Aliança" / "Entrar na Aliança", change vehicle, ranking, help "Instruções" | Lobby content | SteelFrame | opening date as digits year, month, day, hour, minute from `SteelModel.openDate` (`SV:209-217`) |
| `SimpleHelpFrame` style `steel.HelperFrame` | "Instruções" | Rules text `steel.view.SteelFrame.helpContent` | help button (`SV:187-192`) | static |

Button actions (`SV:162-185`):

| Control | Action |
|---|---|
| `_joinBtn` | 8962 op 6 ([steel-battle.md](steel-battle.md)) |
| `_myTeamBtn` "A minha Aliança" (visible when `selfTeamUid` not empty, `SV:194-206`) | opens `SteelMemberFrame` (`steelmap`, 1) |
| `_joinTeamBtn` "Entrar na Aliança" (visible when `selfTeamUid` empty) | opens `SteelSearchFrame` (`steelmap`, 2) |
| `_changeBtn` | opens controller `vehicledaimon` ([../artillery/README.md](../artillery/README.md)) |
| `_rankBtn` | opens `SteelRankListFrame` (`steelmap`, 5) |

## 3. Routes (client to server)

### R1. Lobby info request

- UI: constructing `SteelView` (`SV:66`).
- Sender: `SteelController.sendSteelInfoReq` (`SC:564-570`).
- Client checks: none.
- Route: C>S 8962 (0x2302) `C_STEEL_PLAYER_OP`.
- Request `steel.SteelTeamInfoMsg`: `param1 (#19, INT32)` = 9. Every other field unset.
- Response: S1 (4772).

## 4. Server messages (server to client)

### S1. 4772 (0x12a4) `U_C_MYTEANINFO`

Message `steel.SteelTeamInfoMsg`. Receiver `SteelController.__myTeamInfoHandler` (`SC:119-130`): `model.selfTeamUid = teamUid`; when `param4` is present, `model.openDate = parse(param4, "YYYY-MM-DD hh:mm:ss")`; then `commit()` dispatches `STEEL_INFO_CHANGE`, which refreshes `SteelView` (`SF:119-122`) and closes `SteelSearchFrame` once the player has a team (`steel/view/search/SteelSearchFrame.as:64-71`).

| Field | Tag, type | Meaning |
|---|---|---|
| `teamUid` | #1 STRING | uid of the caller's team, empty string when the caller has no team |
| `param4` | #22 STRING | next battle start, `YYYY-MM-DD hh:mm:ss` server time |

All other `SteelTeamInfoMsg` fields (listed in [steel-teams.md](steel-teams.md)) are ignored here. When: response to op 9; also push after any change of the caller's team membership (assumption, so the lobby link stays correct).

### S2. 4765 (0x129d) `U_C_STEEL_ICONSTATE`

Message `steel.SteelTeamListMsg`. Receiver `SteelController.__steelIconStateHandler` (`SC:265-274`): `showSteelBtn = (param1 == 1)`, `shineSteelBtn = (param2 == 1)`. Nothing reads these flags in this build.

| Field | Tag, type | Meaning |
|---|---|---|
| `param1` | #1 INT32 | 1 = event visible |
| `param2` | #2 INT32 | 1 = icon shines (battle phase running) |

When: push at login and at each phase change (assumption).

### S3. 4776 (0x12a8) `U_C_PVP_TIMER`

Message `timer.TimerInfoListMsg` `timerInfo (#1, MESSAGE TimerInfoMsg, repeated)`. Receiver `BaseManager.__pvpTimerHandler` (`BM:334`, `BM:974-990`): entries with `type == 1` go to `SteelModel.initTimerInfo`, which is an empty method (`SM:95-97`); `type == 3` goes to the SVS feature. `TimerInfoMsg` fields: `type (#1, INT32)`, `index (#2, INT32)`, `name (#3, STRING)`, `readyOpen (#4, STRING)`, `readyStop (#5, STRING)`, `finalOpen (#6, STRING)`, `finalStop (#7, STRING)`, `param1 (#8, STRING)`, `param2 (#9, STRING)`, `param3 (#10, STRING)`, `signupTime (#11, STRING)`. The server may send the steel schedule (type 1) for consistency; the client ignores it.

## 5. Rules and formulas

- Schedule: one battle window per cycle; `openDate` is the only time shown. The original cycle is unknown (assumption: weekly, configured in server config `league.steel_schedule`).
- `isInSteelFrame` blocks other top bar actions while the lobby is open (`TopToolsBar.as:2205`).
- Help rules (verbatim key `steel.view.SteelFrame.helpContent`): rounds are matched by opponent ranking; players fight as artillery with merged hero and vehicle attributes; the iron city is neutral at start, players can destroy the city gate and take the formation energy and traps; a destroyed formation totem blocks respawn until it refreshes; the winner is decided by possession and the match ends early on a large score gap; kills, totems and monsters give battle points, holding the city gives many points; monsters drop combat buffs, the boss grants strong skills; rewards only when the point gap is 30 or more. See [steel-battle.md](steel-battle.md).

## 6. Templates

None. Lobby strings: `index/language.json` keys `steel.view.SteelFrame.*`.

## 7. Persistent state

```sql
CREATE SCHEMA IF NOT EXISTS league;

CREATE TABLE league.steel_seasons (
    season_id     bigserial   PRIMARY KEY,
    opens_at      timestamptz NOT NULL,
    closes_at     timestamptz NOT NULL,
    phase         smallint    NOT NULL DEFAULT 0 CHECK (phase BETWEEN 0 AND 3),
    created_at    timestamptz NOT NULL DEFAULT now(),
    CHECK (closes_at > opens_at)
);
CREATE INDEX steel_seasons_opens_idx ON league.steel_seasons (opens_at);
```

`phase`: 0 registration, 1 battle running, 2 finished, 3 rewards sent (assumption). Team tables are in [steel-teams.md](steel-teams.md).

## 8. Backend implementation notes

- Dispatcher `league::steel::handle_player_op` (8962) switches on `param1` and calls `league::steel_lobby::handle_info` (op 9), the team handlers, `league::steel_battle::handle_enter` (op 6) and `league::steel_ranking::handle_order_list` (op 15). Unknown op: ignore and log.
- `handle_info`: read the caller's membership and the next `steel_seasons` row, reply 4772 with `teamUid` (empty when none) and `param4 = opens_at` formatted `YYYY-MM-DD HH:MM:SS`.
- Login: push 4765 (`param1` = 1 while a season is open, `param2` = 1 during phase 1) and optionally 4776 with a type 1 entry.
- Scheduler: on each phase change push 4765 to online players.

## 9. Open questions and assumptions

- Open: no entry point opens the lobby. Decide whether to add one (for example a top bar key) or leave the feature dormant.
- Assumption: 4772 is also pushed after membership changes.
- Assumption: season cycle and phases (the client only knows `openDate`).
- Map 5701 has no row in `raw/xml/tempinfos/MapInfos.xml` and no `steelmap` assets were checked; see [steel-battle.md](steel-battle.md).

## 10. Implementation checklist

- [ ] Screen `SteelFrame` / `SteelView` renders date digits from 4772.
- [ ] Route 8962 op 9 and dispatcher for all ops.
- [ ] Server message 4772 (with and without team).
- [ ] Server message 4765 at login and on phase change.
- [ ] Optional 4776 type 1 entry.
- [ ] Table `league.steel_seasons`.
- [ ] Test: player without team sees "Entrar na Aliança"; after joining, 4772 with uid shows "A minha Aliança".
