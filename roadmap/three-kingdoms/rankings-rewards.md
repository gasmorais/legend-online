# Rankings and rewards

Aliases: see [README.md](README.md). Extra aliases:

| Alias | File |
|---|---|
| GRF | `decompiled/m9/scripts/godsevening/GERankFrame.as` |
| GRP | `decompiled/m9/scripts/godsevening/GERankPersonalView.as` |
| GRS | `decompiled/m9/scripts/godsevening/GERankServerView.as` |
| GCP | `decompiled/m9/scripts/godsevening/GECheckRewardPersonalView.as` |
| GCS | `decompiled/m9/scripts/godsevening/GECheckRewardServerView.as` |

## 1. Overview

Three ranking surfaces:

1. **Ranking frame** "Ranking da Hegemonia dos Três Reinos" (lobby): event totals (`readyScore + finalScore`) for servers and players.
2. **Live ranks** on the battlefield (left HUD, current round), fed by 247 ([battlefield.md](battlefield.md)).
3. **Round end frame** "Ranking de Pontos da Hegemonia dos Três Reinos" (push 252): final ranks of the round, top 3 servers with their mark reward and the caller's mark reward.

Rewards: "Marca dos Deuses" (currency 46, shown as virtual template -11000), a title ("Título", icon `lordappell.png`) for the top players, and server buffs "Força dos Três Reinos" (campaign gold gains multiplied) and "Dádiva dos Três Reinos" (chest in the sky realm). Marks are spent in shop 35.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `godsevening.GERankFrame` (GRF), `openType` 1 | "Ranking da Hegemonia dos Três Reinos" | Tabs server and personal | lobby rank button | |
| `GERankServerView` (GRS) | "Rank", "Servidor", "Poder de Combate", "Pontos" | 8 per page; own server rank `serverOrder` and score `serverScore` | GRF; requests op 3 `param1 = 1` (`GRS:65`) | `mainFrameServerRankDic` |
| `GERankPersonalView` (GRP) | "Rank", "Nome", "Servidor", "Poder de Combate", "Pontos" | 8 per page; own rank `totalRank` ("No Ranking" when 0) and `readyScore + finalScore` (`GRP:216-228`) | GRF; requests op 3 `param1 = 2` (`GRP:67`) | `mainFramePersonRankDic` |
| `godsevening.GECheckRewardFrame`, `openType` 2 | "Ver prêmios" | Static reward tables (server and personal tabs) | lobby check reward button | constants below |
| `godsevening.GEGameOverFrame` (GGO), `openType` 3 | "Ranking de Pontos da Hegemonia dos Três Reinos" | Round result: top 3 servers with "+{0}" marks, 8 players per page, own rank, own score, own mark reward | push 252 (`BM:618-701`) | 252 data |

## 3. Routes (client to server)

### R1. Ranking lists (op 3)

- UI: opening a GRF tab.
- Sender: `GodsEveningManager.sendRequstMainFrameRankInfo(tab)` (`GEM:404-411`).
- Route: C>S 5101 (0x13ed) `C_GODS_CLIENT_OP`, `gods.CrossGodsMsg`: `op_type (#1)` = 3, `param1 (#5, INT64)` = 1 server ranking, 2 personal ranking.
- Response: S1 248.

## 4. Server messages (server to client)

### S1. 248 (0x00f8) `U_C_GODS_ORDER`

`CrossGodsMsg`. Receiver `GEM.__mainFrameRankInfoHandler` (`GEM:71-129`):

| Field | Use |
|---|---|
| `my_info (#12)` | `teamId`, `readyScore`, `readyOrder`, `finalScore`, `finalOrder`, `totalRank = rank (#17)` |
| `param2 (#6, INT64)` | own server rank (`serverOrder`) |
| `param3 (#7, INT32)` | own server score (`serverScore`) |
| `playerInfo (#3)` | players; the client sorts by `readyScore + finalScore` desc then `fight_power` desc and numbers them 1..n; fields `nick_name`, `server_name`, `fight_power`, scores |
| `info (#2)` | servers; same sort; fields `server_name`, `fight_power`, scores |

When: response to op 3. Send both lists regardless of `param1` (the client fills both dictionaries) or only the requested one (both work).

### S2. 252 (0x00fc) `U_C_GODS_OVER`

`CrossGodsMsg`. Receiver `BaseManager.__godsEveningReportHandler` (`BM:618-623`) buffers the package until the return scene is ready, then `godsEveningReportCall` (`BM:625-701`):

| Field | Use |
|---|---|
| `gameType (#4)` | 1 preliminary: read `readyOrder` / `readyScore`; 2 final: read `finalOrder` / `finalScore` |
| `param1 (#5, INT64)` | own server rank (`myServerRank`) |
| `my_info (#12)` | own rank and score of that round |
| `playerInfo (#3)` | players with rank and score of that round, `nick_name`, `server_name`, `fight_power` |
| `info (#2)` | servers with rank, score, `fight_power`, `team_id` |

Opens GGO with `{myRank, myScore, personRankDic, serverRankDic, myServerRank}`. When: push to every participant when a round ends (online; offline players get the reward by mail only).

## 5. Rules and formulas

Round end frame (GGO), marks of a round:

| Server rank | Server reward (`getServerRewardCountByRank`, `GGO:284-300`) |
|---|---|
| 1 | 3500 |
| 2 | 2500 |
| 3 | 1500 |

| Personal rank | Personal part (`getPersonRewardCountByRank`, `GGO:302-330`) |
|---|---|
| 1 | 3500 |
| 2 | 3000 |
| 3 | 2500 |
| 4 to 20 | 2000 |
| 21 to 50 | 1500 |
| 51 to 100 | 1000 |
| other | 0 |

Player marks = personal part + server reward of the player's server rank.

Reward catalog frame ("Ver prêmios", static and inconsistent with the round end frame; probably event total rewards, assumption):

| Personal rank (`GCP`) | Marks | Extra |
|---|---|---|
| 1 | 9500 | title |
| 2 | 8000 | title |
| 3 | 7000 | title |
| 4 to 10 | 5500 | |
| 11 to 20 | 4500 | |
| 21 to 50 | 3000 | |
| 51 to 100 | 2000 | |

| Server rank (`GCS`) | Reward |
|---|---|
| 1 | "Força dos Três Reinos" 14 days: "Todos os jogadores deste servidor receberam o privilégio de ganhos de ouro na campanha multiplicados, durante {0} dias." |
| 2 | same, 10 days |
| 3 | same, 7 days |
| 4 to 6 | same, 5 days |
| 7 to 10 | same, 3 days |

"Dádiva dos Três Reinos" ("privilégio de coletar o Baú dos Três Reinos no Reino dos Céus durante {0} dias") has strings but no row in the frame (unused). The catalog lists ranks up to 10 servers while a match has 3 (open).

- Help item 2: every participant of an edition gets the final reward, even after an idle kick (texts of 4483 and the re-entry confirm).
- Currency: "Marca dos Deuses" currency id 46 (virtual template -11000), see [../currency/tokens.md](../currency/tokens.md).

## 6. Templates

None in `raw/xml/tempinfos` for these tables; the numbers are client constants (GGO, GCP, GCS). Title id for "lordappell" is unknown (open).

## 7. Persistent state

Scores and orders: `three_kingdoms.participants`, `three_kingdoms.match_teams` ([lobby.md](lobby.md)).

```sql
CREATE TABLE three_kingdoms.rewards (
    event_id    bigint      NOT NULL REFERENCES three_kingdoms.events(event_id) ON DELETE CASCADE,
    game_state  smallint    NOT NULL CHECK (game_state IN (1, 2)),
    player_id   bigint      NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
    personal_rank integer,
    server_rank smallint,
    marks       integer     NOT NULL CHECK (marks >= 0),
    title_id    integer,
    granted_at  timestamptz NOT NULL DEFAULT now(),
    PRIMARY KEY (event_id, game_state, player_id)
);

CREATE TABLE three_kingdoms.server_buffs (
    server_id   integer     NOT NULL,
    buff_kind   smallint    NOT NULL CHECK (buff_kind IN (1, 2)),
    starts_at   timestamptz NOT NULL,
    ends_at     timestamptz NOT NULL,
    event_id    bigint      REFERENCES three_kingdoms.events(event_id),
    PRIMARY KEY (server_id, buff_kind, starts_at)
);
```

`buff_kind`: 1 "Força dos Três Reinos", 2 "Dádiva dos Três Reinos".

## 8. Backend implementation notes

- `three_kingdoms::rankings::handle_rank_list` (5101 op 3): read participants and teams of the caller's group with totals; reply 248.
- Round end job: freeze ranks (ready or final), compute marks with the GGO tables, grant currency 46 (wallet API, reason `three_kingdoms_round`) in one transaction per player with the `rewards` row, push 252 to online participants; offline: mail notice (assumption). After the final round: titles for personal ranks 1 to 3 and server buffs by server rank.
- Campaign gold multiplier: expose `three_kingdoms::server_buff_active(server_id, kind)` to the campaign feature (multiplier value open).

## 9. Open questions and assumptions

- Open: which table applies (round end constants versus "Ver prêmios" constants); proposal: round end constants per round, catalog constants unused.
- Open: title template id and buff multiplier value.
- Assumption: offline participants receive marks by mail.

## 10. Implementation checklist

- [ ] Screens GRF (GRS, GRP), check reward frame, GGO.
- [ ] Route 5101 op 3.
- [ ] Server messages 248, 252.
- [ ] Tables `three_kingdoms.rewards`, `three_kingdoms.server_buffs`.
- [ ] Round end job with mark grants.
- [ ] Tests: personal rank 15 on server rank 2 gets 2000 + 2500 = 4500 marks; rank 101 on server rank 3 gets 1500.
