# Steel ranking ("Ranking da Liga")

Aliases: see [README.md](README.md). Extra alias: SRI2 = `decompiled/m11/scripts/steel/view/ranklists/SteelRankItem.as`.

## 1. Overview

Two ranking views exist:

1. The cross-server team ranking "Ranking da Liga", ordered by `crossOrder`, showing server, wins and fight power, plus the caller's own rank and win count. Requested with 8962 op 15, answered by 4775.
2. An in battle score detail (4771 `U_C_STEEL_VEHICLE_DETAILE`): red and blue team scores and a per player point ranking. The client stores it in `SteelModel` but no view listens to it in this build.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `steel.view.ranklists.SteelRankListFrame` (SRL), `openType` 5 | "Ranking da Liga" | Paged team ranking, 10 rows per page (`SRL:75-76`) | lobby rank button ([steel-lobby.md](steel-lobby.md)) | columns "Ranking", "Aliança", "Servidor", "Número de vitórias", "Poder de combate"; own rank "{0}" or "Iniciante" when `selfOrder < 1` (`SRL:199-210`); own win count |
| `SteelRankItem` (SRI2) | | One row | SRL | rank image for `crossOrder <= 3` else number; "Aliança de {teamName}"; `serverName`; `succCount`; `fightPower` (`SRI2:84-100`) |

## 3. Routes (client to server)

### R1. Order list (op 15)

- UI: SRL constructor (`SRL:79`).
- Sender: `SteelController.sendSteelOrderListReq` (`SC:617-623`).
- Client checks: none. Paging is client side over the full list (`SRL:227-244`).
- Route: C>S 8962 (0x2302) `C_STEEL_PLAYER_OP`, request `steel.SteelTeamInfoMsg` with `param1 (#19, INT32)` = 15.
- Response: S1 4775.

## 4. Server messages (server to client)

### S1. 4775 (0x12a7) `U_C_STEEL_ORDERLIST`

Message `steel.SteelTeamListMsg`. Receiver `SteelController.__orderListHandler` (`SC:220-237`): `selfOrder = param1`, `selfWinCount = param2`, `finalOrderList = teamInfo` sorted by `crossOrder` asc, which refreshes SRL (`SRL:177-180`).

| Field | Tag, type | Meaning |
|---|---|---|
| `param1` | #1 INT32 | caller's team rank (0 = unranked, shows "Iniciante") |
| `param2` | #2 INT32 | caller's team wins |
| `teamInfo` | #10 SteelTeamInfoMsg repeated | ranked teams; fields read by the row: `crossOrder (#14)`, `teamName (#2)`, `serverName (#3)`, `succCount (#7)`, `fightPower (#25)` |

When: response to op 15.

### S2. 4771 (0x12a3) `U_C_STEEL_VEHICLE_DETAILE`

Message `steel.SteelRankDetailMsg`. Receiver `SteelController.__vehicleDetaileHandler` (`SC:239-263`): sets `steelCampaignInfo.blueTeamScore`, `redTeamScore`, `selfPoint`, and `rankDetailList` sorted by `rank` asc. No view subscribes to `STEEL_RANK_DETAIL_LIST_CHANGE`.

| Field | Tag, type | Meaning |
|---|---|---|
| `steelRankMsg` | #1 SteelRankMsg repeated | player rows |
| `redTeamScore` | #2 INT32 | red side score |
| `blueTeamScore` | #3 INT32 | blue side score |
| `score` | #4 INT32 | caller's personal points |

`SteelRankMsg`: `userId (#1, INT32)`, `serverName (#2, STRING)`, `nickName (#3, STRING)`, `job (#4, INT32)`, `point (#5, INT32)`, `rank (#6, INT32)`.

When: push during a steel battle on score change (assumption, throttled to once per second).

## 5. Rules and formulas

- Ranking key: `crossOrder` computed by the server. Proposed order: wins desc, then (wins minus losses) desc, then team fight power desc (assumption).
- Rewards: help text says rewards are only given when the final point gap is 30 or more (see [steel-battle.md](steel-battle.md)); ranking rewards are not described by the client (open).

## 6. Templates

None.

## 7. Persistent state

Wins, losses and `cross_order` live in `league.steel_teams` ([steel-teams.md](steel-teams.md)). Match history:

```sql
CREATE TABLE league.steel_matches (
    match_id      bigserial   PRIMARY KEY,
    season_id     bigint      NOT NULL REFERENCES league.steel_seasons(season_id),
    round_no      integer     NOT NULL,
    red_team_uid  uuid        NOT NULL REFERENCES league.steel_teams(team_uid),
    blue_team_uid uuid        NOT NULL REFERENCES league.steel_teams(team_uid),
    red_score     integer     NOT NULL DEFAULT 0,
    blue_score    integer     NOT NULL DEFAULT 0,
    winner_team_uid uuid      REFERENCES league.steel_teams(team_uid),
    started_at    timestamptz,
    finished_at   timestamptz,
    CHECK (red_team_uid <> blue_team_uid)
);
CREATE INDEX steel_matches_season_round_idx ON league.steel_matches (season_id, round_no);

CREATE TABLE league.steel_match_players (
    match_id   bigint  NOT NULL REFERENCES league.steel_matches(match_id) ON DELETE CASCADE,
    player_id  bigint  NOT NULL REFERENCES player.players(player_id),
    side       smallint NOT NULL CHECK (side IN (1, 2)),
    points     integer NOT NULL DEFAULT 0,
    PRIMARY KEY (match_id, player_id)
);
```

## 8. Backend implementation notes

- `league::steel_ranking::handle_order_list` (op 15): load teams of the current season ordered by `cross_order`; `param1`/`param2` from the caller's team (0 / 0 when none). Read only, no transaction.
- After each match: update wins/losses in one transaction with the match row, recompute `cross_order` for the season.
- During a match: the battle service pushes 4771 to every participant ([steel-battle.md](steel-battle.md)).

## 9. Open questions and assumptions

- Assumption: ranking order criteria.
- Open: ranking rewards and their delivery (mail).
- 4771 has no UI consumer in this build; sending it is optional.

## 10. Implementation checklist

- [ ] Screen SRL with paging and own rank.
- [ ] Route 8962 op 15.
- [ ] Server messages 4775 and 4771.
- [ ] Tables `league.steel_matches`, `league.steel_match_players`.
- [ ] Test: team without rank shows "Iniciante"; 25 teams give 3 pages.
