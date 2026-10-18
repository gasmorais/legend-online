# Hermitage war ranking and results

Module `hermitage_war::results`. Citation prefixes: see [README.md](README.md).

## 1. Overview

During the war a player can open the live score ranking. When a camp reaches the score cap or the round times out the server sends the final result with every player's statistics, grants rewards by personal score (limited to `secret_war_max_reward` results per day) and returns all players to space, where the win banner and the result table are shown.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `war2023.SecretwarRankFrame` (710x445; openType 3) | Ranking de Pontos (`map.campaign.pvp.title01`) | Live ranking, tabs Todos / Azul / Vermelho (`M3/war2023/view/SecretwarRankView.as:126-145`) | right bottom rank button | 547: Ranking, Nome, Servidor, Ataque (kills), Ocupação, Pontos pessoais |
| `war2023.SecretwarWinFrame` (1380x390; openType 2) | | Banner "Azul"/"Vermelho" wins; "Toque em qualquer lugar para fechar"; any click opens the result frame (`M3/war2023/SecretwarWinFrame.as:30-66`) | space/castle scene after 548 with `isSecretwarResult` (`M3/map/space/SpaceSceneController.as:469-471`, `decompiled/m4/scripts/castle/CastleSceneView.as:275`) | `resultInfo.winCamp` |
| `war2023.SecretwarResultFrame` (1040x456; openType 4) | | Win or lose art for own camp, blue and red scores, full table with "Mérito" column, own reward "× N" (`M3/war2023/SecretwarResultFrame.as:50-90`, `view/SecretwarResultView.as:37-46`) | win frame | 548, 550 `rewardShow` |

Sorting: by `score` desc then `fightPower` desc (`CM/mvc/module/war2023/info/SecretwarResultInfo.as:32-37`).

## 3. Routes (client to server)

| # | Action | Sender | Checks | Request | Response |
|---|---|---|---|---|---|
| R1 | Live ranking | `SecretwarRankFrame` constructor (`M3/war2023/SecretwarRankFrame.as:24`) | none | 9725 `PlayerOpMsg` {`op` = 6 OP_REPORT, `nodeId` = -1, `type` = -1} (`SWM:354-362`) | 547 |

## 4. Server messages (server to client)

| Opcode | Message | Receiver | When | Effect |
|---|---|---|---|---|
| 547 (0x0223) `U_C_SECRET_WAR_RANK` | `SecretWarRankListMsg` {`ranks` (#1, SecretWarRankMsg, repeated)} | `SWM.__rankListHandler` (`SWM:254-267`) | reply to op 6 | ranking lists (all, blue camp 1, red camp 2) |
| 548 (0x0224) `U_C_SECRET_WAR_RESULT` | `SecretWarResultMsg` {`winCamp` (#1, INT32: 1 blue, 2 red), `blueScore` (#2), `redScore` (#3), `ranks` (#4, SecretWarRankMsg, repeated)} | `SWM.__resultHandler` (`SWM:295-319`) | war end, to every participant still in the instance | `isOver = true`; return to space now (or after 2 s if in a battle scene) with `isSecretwarResult` |
| 550 (0x0226) `U_C_SECRET_WAR_USER_DATA` | `SecretWarUserDataMsg` {`rewardCount` (#1), `rewardShow` (#2, "itemId,count")} | `SWM._rewardHandler` (`SWM:104-112`) | right after 548 when a reward was granted | result frame "× count"; lobby counter |

`SecretWarRankMsg`: `rank` (#1, INT32), `userId` (#2, INT32), `serverName` (#3, STRING), `nickName` (#4, STRING), `job` (#5, INT32), `camp` (#6, INT32), `kill` (#7, INT32), `occupy` (#8, INT32), `score` (#9, INT32), `uuid` (#10, STRING, not read), `fightPower` (#11, INT32), `isReward` (#12, BOOL, player received a result reward), `exploits` (#13, INT32, Mérito gained).

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| End | camp score >= `secret_war_max_score` (7500) or round end; winner = higher camp score | `secretwar.helpContent` item 5; ConfigInfos |
| Rewards | by personal score ("Quanto maior a Pontuação Individual, melhores os prêmios"), sent after the end | help item 6 |
| Daily limit | `secret_war_max_reward` = 1 result reward per day (help says 2), reset at midnight | ConfigInfos; help item 7 |
| Mérito cap | `secret_war_limit` = item -5500 max 1000 (A: per day) | ConfigInfos |
| Players who left | not in the result (A) and no reward | `secretwar.leaveTip` |

Reward table (A): no template in the client. Proposal: Mérito = `floor(score / 10)` clamped to the daily cap, bonus 20% for the winning camp; replace when real data is recovered.

## 6. Templates

None in `raw/xml/tempinfos/` for secret war rewards. Mérito shop items: `ExploitsShopTemplates.xml`, `MapShopItemTemplateInfos.xml` (see [../shops/exploits-shop.md](../shops/exploits-shop.md)).

## 7. Persistent state

Uses `hermitage_war.wars`, `hermitage_war.war_players` ([battlefield.md](battlefield.md)) and `hermitage_war.player_daily` ([lobby.md](lobby.md)). Final ranks:

```sql
ALTER TABLE hermitage_war.war_players
  ADD COLUMN final_rank SMALLINT,
  ADD COLUMN rewarded BOOLEAN NOT NULL DEFAULT false,
  ADD COLUMN fight_power INTEGER NOT NULL DEFAULT 0;
```

## 8. Backend implementation notes

- `hermitage_war::results::handle_report` (op 6): build ranks from the instance (sorted by score, fightPower), reply 547.
- `finish_war(instance)`: stop timers and battles; compute `winCamp`; in one transaction per player: if `player_daily.reward_count < secret_war_max_reward` and not `left_early`, grant Mérito (currency service, clamp by `secret_war_limit`), set `rewarded`, increment `reward_count`, set `last_reward`; persist `wars` and `war_players`. Then send 548 to every participant and 550 to rewarded players.
- Remove the instance after all players were returned.

## 9. Open questions and assumptions

- (A) Reward formula and items (only "Mérito" is visible in the result view).
- (A) `isReward` semantics: true when this result counted against the daily limit.
- (A) Config 1 vs help text 2 daily rewards.

## 10. Implementation checklist

- [ ] Op 6 -> 547.
- [ ] End detection and `finish_war`.
- [ ] 548 to all participants; 550 to rewarded.
- [ ] Daily limit and Mérito cap.
- [ ] Columns `final_rank`, `rewarded`, `fight_power`.
- [ ] Screens: win banner on return to space or castle, result table, rank tabs.
- [ ] Tests: tie at time out (winCamp 0, A), reward limit reached, player in battle when 548 arrives (2 s delay path).
