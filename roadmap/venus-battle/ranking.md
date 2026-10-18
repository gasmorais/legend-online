# Venus battle: groups, ranking and rewards

Module `venus_battle::ranking`. Prefixes as in [README.md](README.md).

## 1. Overview

Each couple team has a persistent score (`totalScore`). Thresholds put it in group 1 "Grupo de Diamantes", 2 "Ouro", 3 "Prata" or 4 "Ferro". The rank frame lists the teams of a group from the last 4799, with own group, rank and score. After each weekly fight scores decay and rewards ("Cristais de Vênus") are sent by group; at least 200 points are needed.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `matelords.MatelordsRankFrame` | Ranking | 4 group tabs (initial tab = own group), columns "Rank", "Equipe", "Poder de Equipe", "Pontos"; own group icon, rank, team score, group hint text; "new player" text when `order <= 0` | main frame rank link -> openType 1 (`M9/matelords/MatelordsFrame.as:336-340`) | `model.rankList` from 4799 filtered by `teamType == tab+1`, sorted by `curOrder` (`M9/matelords/MatelordsRankFrame.as:76-266`; rows `M9/matelords/MatelordsGeneralListCell.as:265-330`) |
| Room right panel | | same list for the room (from 4798) | [room.md](room.md) | |

## 3. Routes (client to server)

No dedicated request: the rank frame reads the cached 4799 and refreshes on `INFO_UPDATE`. To refresh, the server answers 8979 ([signup.md](signup.md)).

## 4. Server messages (server to client)

4799 and 4798 `info` rows (`MateLordsInfoMsg`), see [signup.md](signup.md). Fields used: `curreOrder` (rank in group; 1..3 show a medal), `nickName` (team name "Equipe {0}"), `serverName`, `grades`, `fightPower`, `totalScore`, `teamType`.

## 5. Rules and formulas

| # | Rule | Source |
|---|---|---|
| G1 | `Mate_TeamType` = 2600,1500,800,200 "(钻石,黄金,白银,黑铁)": Diamond >= 2600, Gold >= 1500, Silver >= 800, Iron below 800 (the iron text says "abaixo de 200 pontos", A: iron = everything under silver) | `TPL/ConfigInfos.xml`; LANG `MatelordsRankFrame.teamTypeText.text0..3` |
| G2 | Rewards `Mate_TeamReward` = 4000,2000,1000,300 per group (Diamond..Iron), currency 12 "Cristais de Vênus" (A from shops catalog), only if score >= 200 | config; help item 6 |
| G3 | Decay `Mate_Desc` = 10,70\|7,60\|6,50\|5,40 "百分比\|固定分" per group (Diamond..Iron): A: after each weekly fight score -= max(score * pct / 100, fixed) or pct plus fixed; confirm | config; LANG "Após o término da batalha será reduzido alguns pontos e enviado prêmios." |
| G4 | Rank inside group by score desc (A) | |

## 6. Templates

| File | Record | Fields |
|---|---|---|
| `TPL/ConfigInfos.xml` | `Mate_TeamType`, `Mate_TeamReward`, `Mate_Desc` | |

## 7. Persistent state

```sql
CREATE TABLE venus_battle.team_score (
  team_uid        uuid PRIMARY KEY REFERENCES venus_battle.couple_team(team_uid),
  total_score     integer NOT NULL DEFAULT 0 CHECK (total_score >= 0),
  group_type      smallint NOT NULL DEFAULT 4 CHECK (group_type BETWEEN 1 AND 4),
  updated_at      timestamptz NOT NULL DEFAULT now()
);
CREATE INDEX ON venus_battle.team_score (group_type, total_score DESC);

CREATE TABLE venus_battle.reward_grant (
  season_id       integer NOT NULL,
  week_no         smallint NOT NULL,
  player_id       BIGINT NOT NULL REFERENCES player.players(player_id),
  team_uid        uuid NOT NULL,
  group_type      smallint NOT NULL,
  amount          integer NOT NULL,
  granted_at      timestamptz NOT NULL DEFAULT now(),
  PRIMARY KEY (season_id, week_no, player_id)
);
```

## 8. Backend implementation notes

- Rank rows are built for 4799/4798: per group ordered by score, with `curreOrder`.
- Week close job (after `Mate_Time` end on `MateLords_Day`): reward both partners of every team with score >= 200 (mail, currency 12, idempotent), then apply G3 decay and recompute groups.

## 9. Open questions and assumptions

- (A) Exact G3 formula, iron lower bound, reward split between partners (each partner receives the full amount, A).

## 10. Implementation checklist

- [ ] `team_score`, `reward_grant`
- [ ] Group computation and ranking rows in 4799/4798
- [ ] Weekly reward and decay job
- [ ] Tests: group boundaries, 199 vs 200 reward cut
