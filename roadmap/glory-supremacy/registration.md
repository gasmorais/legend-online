# Glory supremacy registration and main view

Module `glory_supremacy::registration`. Citation prefixes: see [README.md](README.md).

## 1. Overview

The sign tab shows the tournament phase, the player's own team (avatars from `GloryPlayerViewMsg`), the next match time, the reward list and the "Inscrever" button. Only the captain of a free team can register; the server then asks every member to confirm within 10 seconds. After registration the team composition is frozen ("Depois do registro a equipe não pode ser alterada").

## 2. Screens

| Class | pt-BR | Purpose | Data |
|---|---|---|---|
| `sevenyear.view.SevenYearGloryGameView` | tabs Inscrição / Calendário / Predição | container (`M11/sevenyear/view/SevenYearGloryGameView.as:37-48`) | |
| `gloryGame.SevenYearGloryGameSignView` | rules `SevenYearGloryGame.sign.rule`, condition "O poder de combate da equipe atingiu 10.000.000" (`SevenYearGloryGame.sign.condition`), award tip `SevenYearGloryGame.award.str` | Register, enter room, phase banner ("Inscrevendo-se...", "Entrando na Eleição Marinha", ... "Supremacia da Glória terminou", `sign.str1..8`), "turn/15" during the qualifier, next match time (`M11/sevenyear/view/gloryGame/SevenYearGloryGameSignView.as:80-290`) | 4991 |
| `gloryGame.SevenYearGloryGameHallPlayerList` / `HallPlayer` | | Own team avatars (`arm`, `cloth`, `wing`, `hat`, fashion, `job`, `nickName`, `fightCapacity`, `vipType`) | 4991 `player` |
| Confirmation alert | "{0} lhe convida a participar desta Supremacia da Glória. Você aceita?" with a 10 s countdown (`GGM:65-91`) | members confirm | 4990 |

## 3. Routes (client to server)

C to S 9694 (0x25de) `C_GLORYGAME_OP`, `simple.PropertyMsg` with `param1` (#1, INT32) = op (`CM/mvc/module/gloryGame/GloryGameConst.as` CLIENT_OP_*). Layout of `simple.PropertyMsg`: see [../auto-chess/matchmaking.md](../auto-chess/matchmaking.md).

| op | Action | Sender | Client checks | Fields | Response |
|---|---|---|---|---|---|
| 1 OPEN_MAIN | Open hub glory data | `GGM.sendOpenView` (`GGM:358-364`) from `SevenYearGameView` (`M11/sevenyear/view/battleflag/SevenYearGameView.as:109`), sign view open and team change (`SevenYearGloryGameSignView.as:87,166-169`) | none | `param1 = 1` | 4991 |
| 2 SIGN_IN | Register team | "Inscrever" -> `onClickSign` -> confirm "Depois do registro a equipe não pode ser alterada. Deseja confirmar o registro?" -> `GGM.sendSign` (`SevenYearGloryGameSignView.as:252-275`, `GGM:366-372`) | has a free team ("É necessário ter uma equipe para inscrever-se na Supremacia da Glória."), is captain ("Apenas o líder pode realizar a inscrição"); button disabled when `isSelfSigned` | `param1 = 2` | 4990 to every other member; after all confirm, 4991 to all members |
| 5 SIGN_IN_CONFIRM | Member answer | alert buttons (`GGM:105-109`) or 10 s timeout = refuse (`GGM:92-97`) | none | `param1 = 5`, `param7` (#7, BOOL) accept | 4991 to the team when complete; a refusal cancels the registration (A) |

Server-side checks for op 2 (A): registration state (`state = 1` of round 1), team power >= 10,000,000 (sum of members' `fightCapacity`), team size (A: 3), no member already registered in another team.

## 4. Server messages (server to client)

| Opcode | Message | Receiver | When | Effect |
|---|---|---|---|---|
| 4991 (0x137f) `U_C_GLORY_OPEN_MAIN_VIEW` | `Glory.GloryMainViewMsg` {`selfSignUp` (#1, BOOL), `player` (#2, GloryPlayerViewMsg, repeated), `state` (#3, STRING "round,state,turn")} | `GGM.receiveOpenView` (`GGM:60,111-133`) | reply to op 1, after registration | `isSelfSigned`, `currentRound`, `currentState`, `currentTurn`, `isOpen = state != "0,0,0"`, `teamPlayers` |
| 4990 (0x137e) `U_C_GLORY_SIGN_IN_CONFIRM` | `simple.PropertyMsg` {`param4` (#4, STRING) captain name} | `GGM.receiveSignConfirm` (`GGM:59,65-91`) | captain registered, to each member | confirm alert with 10 s countdown |

`GloryPlayerViewMsg`: `arm` (#1, STRING), `cloth` (#2), `wing` (#3), `hat` (#4), `hideFashion` (#5, BOOL), `fashionArm` (#6), `fashionCloth` (#7), `isDragonTalker` (#8, BOOL), `job` (#9, INT32), `nickName` (#10), `serverName` (#11), `playerUid` (#12, INT32), `fightCapacity` (#13, INT32), `vipType` (#14, INT32), `heroTempId` (#15, INT32), `teamUid` (#16, STRING).

`state` values: round = stage (`STAGE_CLOSE 0`, `TRYOUT 1` "Eleição Marinha", `GROUP 2`, `OUT 3` quarter-finals, `OUT2 4` semi-finals, `FINAL 5`, `END 6`); state = phase (`STATE_CLOSE 0`, `SIGN_IN 1`, `GUESS 2` prediction, `READY 3`, `FIGHT 4`, `REWARD 5`, `END 6`); turn = current turn of the stage (`CM/mvc/module/gloryGame/GloryGameConst.as`).

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Team power | >= 10,000,000 | `SevenYearGloryGame.sign.condition` |
| Confirmation timeout | 10 s, timeout = refuse | `GGM:83-97` |
| Team frozen after registration | yes | `SevenYearGloryGame.sign.hint` |
| Qualifier | everyone registered, 15 turns, top 16 by points continue | `sign.rule` items 1-2; `GloryGameConst.TRYOUT_TOTAL_TURN = 15` |

## 6. Templates

`TPL/GloryRewardDrop.xml` (tip of rewards, see [matches.md](matches.md)).

## 7. Persistent state

```sql
CREATE TABLE glory_supremacy.seasons (
  season_id     SERIAL PRIMARY KEY,
  starts_on     DATE NOT NULL,
  stage         SMALLINT NOT NULL DEFAULT 0 CHECK (stage BETWEEN 0 AND 6),
  phase         SMALLINT NOT NULL DEFAULT 0 CHECK (phase BETWEEN 0 AND 6),
  turn          SMALLINT NOT NULL DEFAULT 0
);

CREATE TABLE glory_supremacy.teams (
  team_uid      UUID PRIMARY KEY,
  season_id     INTEGER NOT NULL REFERENCES glory_supremacy.seasons(season_id) ON DELETE CASCADE,
  name          TEXT NOT NULL,
  server_name   TEXT NOT NULL,
  captain_id    BIGINT NOT NULL REFERENCES player.players(player_id),
  status        SMALLINT NOT NULL DEFAULT 0 CHECK (status IN (0, 1, 2)),
  registered_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE glory_supremacy.team_members (
  team_uid      UUID NOT NULL REFERENCES glory_supremacy.teams(team_uid) ON DELETE CASCADE,
  player_id     BIGINT NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  confirmed     BOOLEAN NOT NULL DEFAULT false,
  fight_capacity INTEGER NOT NULL,
  PRIMARY KEY (team_uid, player_id)
);
CREATE UNIQUE INDEX glory_team_members_player_season ON glory_supremacy.team_members (player_id);
```

`teams.status`: 0 pending confirmation, 1 registered, 2 cancelled. The unique index on `player_id` assumes the table is emptied per season (A); otherwise add `season_id`.

## 8. Backend implementation notes

- `glory_supremacy::registration::handle_open` (op 1): reply 4991 with the current `"stage,phase,turn"`, own team members and `selfSignUp`.
- `handle_sign` (op 2): validate phase, captain, team power, members not registered; insert pending team, send 4990 to the other online members (offline members: A, refuse).
- `handle_sign_confirm` (op 5): record answer; all accepted -> status 1, push 4991 to members; any refusal or 10 s timeout -> status 2 and notify the captain (A: tip).
- Push 4991 to all registered players on phase changes (A) so the banner updates.

## 9. Open questions and assumptions

- (A) Team size and how offline members confirm.
- (A) Whether teams can register after the qualifier starts.
- (A) Cross-server registration (teams carry `serverName`).

## 10. Implementation checklist

- [ ] Op 1 and 4991 encoder.
- [ ] Op 2 with validations; 4990 to members.
- [ ] Op 5 confirmation with 10 s timeout.
- [ ] Tables `seasons`, `teams`, `team_members`.
- [ ] Tests: non captain, no team, low power, refusal, timeout.
