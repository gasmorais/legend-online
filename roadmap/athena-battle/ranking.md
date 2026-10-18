# Athena battle: categories, ranking and rewards

Module `athena_battle::ranking`. Prefixes as in [README.md](README.md). The push below is not received by this client build (see the README).

## 1. Overview

Personal Athena score places the player in one of six categories. The rank frame (tab 2) mirrors the Ares rank frame: one tab per category, 10 rows per page, own rank or "Sem rank", last update time. Rewards are "lágrimas de Athena" (currency 20) per battle and monthly by category.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `braveleg.BraveLegRankFrame` (535x585) | Ranking | 6 category tabs ("Categoria de Novato" .. "Categoria de Grande Mestre"), columns "Rank", "Jogador" "{0}[{1}]", "Poder", "Pontos", tab tips "{0}: {1}-{2} pontos" / "{0}: {1} +pontos", "Última atualização: {0}" | SignUp frame rank button: op 8 then tab 2 (`M11/braveleg/BraveLegSignUpFrame.as:320-325`) | `rankInfo` (`M11/braveleg/BraveLegRankFrame.as:95-340`) |

## 3. Routes (client to server)

| # | Action | Client sender | Request | Presumed response |
|---|---|---|---|---|
| K1 | Open ranking | `BraveLegManager.requestRankInfo` / `requestRankList` (`CM/yishi/manager/BraveLegManager.as:104-110,182-188`) | 9619 `{op:8}` | 381 |

## 4. Server messages (server to client), presumed mapping

381 (0x017D) `U_C_BRAVE_RANKLIST` "勇者征程排行榜信息" (PTT:819), `BraveLegListMsg` -> `__rankInfoHandler` / `resovleRankInfo` (`BraveLegManager.as:374-381,541-561`): `order` (own rank in own category, 0 = unranked), `teamType` (own category 0..5), `totalScore`, `openTime` (last update text), `info` rows (`nickName`, `serverName`, `fightPower`, `totalScore`, `teamType`, `rankOrder`). Not registered in this client; in this build Air Garden listens to 381 (`CM/managers/AirGardenManager.as:62`).

## 5. Rules and formulas

| # | Rule | Source |
|---|---|---|
| K-R1 | Categories by score `Brave_TeamType` = 1000,2000,3500,5000,7000: 0 "Novato" < 1000, 1 "Corajoso" 1000..1999, 2 "Herói" 2000..3499, 3 "Especialista" 3500..4999, 4 "Mestre" 5000..6999, 5 "Grande Mestre" >= 7000 | config; LANG `braveleg.GroupName.*` |
| K-R2 | Monthly reward by category and score increase (`braveleg.SignUp.RewardTip`); per battle chance of currency 20. (A) No reward table in the client templates | LANG |

## 6. Templates

`TPL/ConfigInfos.xml` `Brave_TeamType`.

## 7. Persistent state

```sql
CREATE TABLE athena_battle.player_score (
  player_id       BIGINT PRIMARY KEY REFERENCES player.players(player_id),
  server_id       integer NOT NULL,
  total_score     integer NOT NULL DEFAULT 0 CHECK (total_score >= 0),
  category        smallint NOT NULL DEFAULT 0 CHECK (category BETWEEN 0 AND 5),
  month_start_score integer NOT NULL DEFAULT 0,
  updated_at      timestamptz NOT NULL DEFAULT now()
);
CREATE INDEX ON athena_battle.player_score (category, total_score DESC);

CREATE TABLE athena_battle.reward_grant (
  period          text NOT NULL,                       -- 'YYYY-MM' or battle id
  player_id       BIGINT NOT NULL REFERENCES player.players(player_id),
  amount          integer NOT NULL,
  reason          text NOT NULL CHECK (reason IN ('battle', 'monthly')),
  granted_at      timestamptz NOT NULL DEFAULT now(),
  PRIMARY KEY (period, player_id, reason)
);
```

## 8. Backend implementation notes

- `athena_battle::ranking::handle_rank` (op 8) -> 381 from a periodic snapshot.
- Monthly job: grant by category and `total_score - month_start_score`, reset `month_start_score`.

## 9. Open questions and assumptions

- (A) Reward amounts and monthly formula.

## 10. Implementation checklist

- [ ] `player_score`, `reward_grant`
- [ ] Op 8 -> 381 (only when listeners restored)
- [ ] Monthly reward job
- [ ] Tests: category boundaries
