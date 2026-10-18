# Ares battle: groups, ranking and rewards

Module `ares_battle::ranking`. Prefixes as in [README.md](README.md).

## 1. Overview

The persistent Ares score (`totalScore`) puts every participant in one of six groups (`teamType` 0..5). The rank frame shows one group per tab, own rank and score, and the last update time. The reward frame lists the "Coração de Ares" amount paid per group. Scores decay by group (`Ares_Desc`) and players under `Ares_ScoreLess` = 200 points earn nothing.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `areslords.AresLordsRankFrame` (535x585) | Ranking | 6 group tabs, 10 rows per page: "Rank", "Jogador" ("{0}[{1}]" name and server), "Poder de Combate", "Pontos"; own group medal and rank or "Sem rank"; "Última atualização: {0}"; note "Obs.: pontos abaixo de {0} não poderá ganhar prêmios, pontuação não são reduzidos." | rank button of SignUp/Start frames: op 4 then controller `areslords` openType 2 (`M9/areslords/AresLordsSignUpFrame.as:174-179`; `M9/areslords/AresLordsStartFrame.as:224-229`) | 373 (`M9/areslords/AresLordsRankFrame.as:107-396`; rows `M9/areslords/rank/AresLordsRankItemView.as`) |
| `areslords.AresLordsRewardFrame` | | reward per group: medal, group name, coin icon, amount | Start frame reward button, openType 3 (`AresLordsStartFrame.as:231-235`) | config `Ares_TeamReward` (`M9/areslords/AresLordsRewardFrame.as:68-88`; `M9/areslords/reward/AresLordsRewardItemView.as:69-90`) |

Group tab tips: "{0}：{1}-{2}pts" or for the last group "{0}：{1}+pts" built from `Ares_TeamType` (`AresLordsRankFrame.as:177-199`).

## 3. Routes (client to server)

| # | Action | UI control | Client sender | Client checks | Request | Responses |
|---|---|---|---|---|---|---|
| K1 | Open ranking | rank button | `AresLordsManager.requestRankInfo` (`CM/yishi/manager/AresLordsManager.as:87-93`) | none | 9615 `{op:4}` | 373 |
| K2 | Switch group tab / page | tabs, prev/next | `AresLordsRankFrame.__onTabBtnHandler`, page handlers (`:278-303`) | client side filter | none | none |
| K3 | Open rewards | reward button | openType 3 | none | none | none |

## 4. Server messages (server to client)

### 373 (0x0175) `U_C_ARES_RANK_INFO`, `AresLordsListMsg`

Receiver `AresLordsManager.__aresLordsRankInfoHandler` (`:208-215`) -> `resovleRankInfo` (`:461-481`), event `RANK_INFO`; the frame clears the cached list on close (`clearRankInfo`, `:127-130`).

| Field | Meaning |
|---|---|
| `order` (#16) | own rank inside own group; 0 = not ranked ("Sem rank", tab 0 selected) |
| `teamType` (#15) | own group, selects the initial tab and medal frame |
| `totalScore` (#14) | own score |
| `openTime` (#6) | reused as "last update" time text ("Última atualização: {0}"); empty shows nothing |
| `info` (#17) | rows of all groups (`AresLordsInfoMsg`: `nickName`, `serverName`, `fightPower`, `totalScore`, `teamType`, `rankOrder`); the client filters by `teamType` and sorts by `rankOrder` |

When: response to op 4. (A) Ranking is a snapshot refreshed periodically, hence the update time.

## 5. Rules and formulas

| # | Rule | Source |
|---|---|---|
| G1 | Groups by score, `Ares_TeamType` = 1200,3200,5200,7200,10000: group 0 "Básico" 0..1199, 1 "Profissão" 1200..3199, 2 "Especialista" 3200..5199, 3 "Mestre" 5200..7199, 4 "Lendário" 7200..9999, 5 "Titã" 10000+ | `TPL/ConfigInfos.xml`; tab tips `AresLordsRankFrame.as:177-199`; LANG `areslords.GroupName.*` |
| G2 | Next group tip: "{0} faltam {1} pts" = threshold[teamType] - totalScore; top group shows "Você já atingiu {0}" | `AresLordsStartFrame.as:293-304` |
| G3 | Decay `Ares_Desc` = 10,20\|10,40\|10,60\|10,80\|10,100\|10,120 per group 0..5: "各组的衰减比例与衰减值" (ratio and value). (A) At each round end every score loses max(10% of score, fixed value)? or 10% plus value; choose and confirm. The rank note says scores under `Ares_ScoreLess` are not reduced | config; LANG `areslords.RankFrame.mark` |
| G4 | Reward per group `Ares_TeamReward` = 200,400,800,1200,1800,2400 "Coração de Ares" (currency 18, shop "Loja de Ares" weekly). Paid at round end (A: by mail) only to players with score >= `Ares_ScoreLess` = 200 who took part in the round | config; `AresLordsRewardFrame.as:68-88`; [../shops/catalog.md](../shops/catalog.md) |
| G5 | Rank inside group: by score desc, then (A) fight power desc, then earliest reach | client sorts by server `rankOrder` |

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `TPL/ConfigInfos.xml` | `Ares_TeamType`, `Ares_Desc`, `Ares_ScoreLess`, `Ares_TeamReward` | values above |

## 7. Persistent state

```sql
CREATE TABLE ares_battle.player_score (
  player_id       BIGINT PRIMARY KEY REFERENCES player.players(player_id),
  server_id       integer NOT NULL,
  total_score     integer NOT NULL DEFAULT 0 CHECK (total_score >= 0),
  group_type      smallint NOT NULL DEFAULT 0 CHECK (group_type BETWEEN 0 AND 5),
  last_round_played integer,
  updated_at      timestamptz NOT NULL DEFAULT now()
);
CREATE INDEX ON ares_battle.player_score (group_type, total_score DESC);

CREATE TABLE ares_battle.rank_snapshot (
  edition_id      integer NOT NULL,
  round_no        smallint NOT NULL,
  player_id       BIGINT NOT NULL REFERENCES player.players(player_id),
  group_type      smallint NOT NULL,
  rank_order      integer NOT NULL,
  total_score     integer NOT NULL,
  fight_power     integer NOT NULL,
  taken_at        timestamptz NOT NULL,
  PRIMARY KEY (edition_id, round_no, player_id)
);

CREATE TABLE ares_battle.reward_grant (
  edition_id      integer NOT NULL,
  round_no        smallint NOT NULL,
  player_id       BIGINT NOT NULL REFERENCES player.players(player_id),
  group_type      smallint NOT NULL,
  amount          integer NOT NULL,
  mail_id         bigint,
  granted_at      timestamptz NOT NULL DEFAULT now(),
  PRIMARY KEY (edition_id, round_no, player_id)
);
```

## 8. Backend implementation notes

- `ares_battle::ranking::handle_rank` (9615 op 4): read the latest `rank_snapshot` (or compute live), send 373 with own `order` within own group, `openTime` = snapshot time "YYYY-MM-DD hh:mm".
- After each battle: update `player_score.total_score`, recompute `group_type` from G1.
- Round close job: write `rank_snapshot`, pay G4 into `reward_grant` and mail currency 18 (idempotent per primary key), then apply G3 decay.

## 9. Open questions and assumptions

- (A) Exact decay formula of G3 and whether decay applies weekly to non participants.
- (A) Reward mail text and whether rewards depend on rank within group (the client shows a flat amount per group).
- (A) Snapshot refresh interval.

## 10. Implementation checklist

- [ ] `player_score`, `rank_snapshot`, `reward_grant`
- [ ] 9615 op 4 -> 373
- [ ] Group computation G1, decay G3, reward G4 with `Ares_ScoreLess`
- [ ] Tests: group boundaries 1199/1200, 9999/10000; unranked player gets `order = 0`; reward idempotency
