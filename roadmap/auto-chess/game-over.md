# Auto chess game over and rewards

Module `auto_chess::game_over`. Citation prefixes: see [README.md](README.md).

## 1. Overview

When a player is eliminated, or the match ends, the server sends the placement and the "Pontos de Guerreiro" earned. Points go to the anniversary war-points counter shared with the snow battle, capped at 600 per day, and advance the war flag ([../hermitage-war/seven-year-event.md](../hermitage-war/seven-year-event.md)).

## 2. Screens

| Class | pt-BR title | Purpose | Data |
|---|---|---|---|
| `chess.SelfChessGameOverFrame` (430x400) | Término do jogo (`selfchess.gameover.title`) | "Ranking da rodada:" "{N}º lugar", "Prêmio obtido:" points, Confirmar; closing by any means sends op 8 and returns to space (`CH/SelfChessGameOverFrame.as:78-126`) | 4217 |

The frame is queued with `AlertTipAction(..., "SELF_CHESS_SCENE")` and opens only while the player is in the scene (`SCM:176-191`), then `model.clear()`.

## 3. Routes (client to server)

| Action | Sender | Request | Response |
|---|---|---|---|
| Confirm / close result | `SelfChessGameOverFrame` -> `SCM.exitGame` (`SCM:223-227`) | 25031 `PropertyMsg` {`param1` = 8 OUT_ROOM, `param2` userId, `param4` serverName, `param5` roomUuid} | none |

## 4. Server messages (server to client)

| Opcode | Message | Receiver | When | Effect |
|---|---|---|---|---|
| 4217 (0x1079) `U_C_SELF_PROPELLED_CHESS_OVER` | `simple.PropertyMsg` {`param1` (#1, INT32) placement 1..6, `param2` (#2, INT32) points granted} | `SCM.receivegameOverInfos` (`SCM:78,176-185`) | when the player is eliminated, and to the winner at the end | game over frame |
| 4987 `U_C_SEVEN_YEAR_USER_INFO` | `SevenYearUserMsg` (`snowScore`, `flagGrade`, `flagScore`) | `SevenYearManager` | after crediting points | "x/600" and flag progress |

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Points by placement | 1st 600, 2nd 400, 3rd 300, 4th 200, 5th 100, 6th 50 | `chess_game_over_award` in `TPL/ConfigInfos.xml` |
| Daily cap | 600 points (`snow_vehicle_daily_reward_max`), shared with the snow battle | ConfigInfos; `SevenYearSelfChessView.as:107,191` |
| Granted | `min(award, 600 - today)`; `param2` = granted value (A) | |
| Flag | +points to `flag_points`, 1000 points = 1 level | `seven_year_grade_score` |
| Leaving early | eliminated at the current last place (A) | |

## 6. Templates

`TPL/ConfigInfos.xml` `chess_game_over_award`, `snow_vehicle_daily_reward_max`, `seven_year_grade_score`.

## 7. Persistent state

```sql
CREATE TABLE auto_chess.matches (
  room_uuid    UUID PRIMARY KEY,
  started_at   TIMESTAMPTZ NOT NULL,
  ended_at     TIMESTAMPTZ,
  rounds       SMALLINT NOT NULL DEFAULT 0
);

CREATE TABLE auto_chess.match_players (
  room_uuid       UUID NOT NULL REFERENCES auto_chess.matches(room_uuid) ON DELETE CASCADE,
  player_id       BIGINT NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  server_name     TEXT NOT NULL,
  placement       SMALLINT NOT NULL CHECK (placement BETWEEN 1 AND 6),
  points_awarded  INTEGER NOT NULL DEFAULT 0,
  points_granted  INTEGER NOT NULL DEFAULT 0,
  left_early      BOOLEAN NOT NULL DEFAULT false,
  final_board     INTEGER[] NOT NULL DEFAULT '{}',
  PRIMARY KEY (room_uuid, player_id)
);
CREATE INDEX auto_chess_match_players_player_idx ON auto_chess.match_players (player_id);
```

The daily counter is `hermitage_war.anniversary_daily.war_points` ([../hermitage-war/seven-year-event.md](../hermitage-war/seven-year-event.md)).

## 8. Backend implementation notes

- On elimination: placement = alive count + 1; one transaction: insert `match_players`, call `add_war_points(player, award)` (clamps to the cap, rolls flag levels), commit; send 4217 and 4987.
- When one player remains: placement 1, same flow; close the room, insert `matches.ended_at`.
- Op 8 after game over only removes the seat; op 8 before elimination is a forfeit ([preparation.md](preparation.md)).

## 9. Open questions and assumptions

- (A) `param2` is the granted amount after the cap, not the nominal award.
- (A) Forfeit placement.

## 10. Implementation checklist

- [ ] Placement computation and 4217.
- [ ] Shared war-points counter with cap and 4987.
- [ ] Tables `matches`, `match_players`.
- [ ] Game over frame shown only in scene (client) - server sends once.
- [ ] Tests: cap reached (granted 0), forfeit, simultaneous eliminations in one round (tie order by HP before the round, A).
