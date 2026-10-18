# Glory supremacy forecast ("Predição")

Module `glory_supremacy::forecast`. Citation prefixes: see [README.md](README.md).

## 1. Overview

After the qualifier any player can predict the knockout bracket: for each of 8 slots (4 quarter-finals, 2 semi-finals, the final and the champion slot) choose the two teams expected to play, picked from the groups that feed that slot. Locking ("bloquear") saves the whole prediction with a timestamp; re-locking replaces it and resets the timestamp. Correct predictions are rewarded at the end of each round, with +50% per full day the lock was made in advance.

## 2. Screens

| Class | pt-BR | Purpose | Data |
|---|---|---|---|
| `gloryGame.SevenYearGloryGameForecastView` | rule `SevenYearGloryGame.forecast.rule`; "Prazo da predição {0}" per stage; "Tempo de bloqueio da predição {0}"; base reward `glory_bet_best_count` (350) | 8 combo items, lock button (disabled while stage 1 is not finished) (`M11/sevenyear/view/gloryGame/SevenYearGloryGameForecastView.as:53-61,100-236`) | 4992 |
| `gloryGame.SevenYearGloryGameForecastComboItem` | two combo boxes with team names | build one `PlayerBetMsg` (`M11/sevenyear/view/gloryGame/SevenYearGloryGameForecastComboItem.as:200-230`); editing a locked prediction shows "Primeiro desbloqueie antes de fazer alterações" (`:283`) | schedules |

Slots (`posArr`, `groupArr`): ids 1..4 stage 3 with team pools (group 1 vs 2), (2 vs 3), (3 vs 4), (4 vs 1); ids 5..6 stage 4 with (1,2 vs 2,3), (3,4 vs 4,1); id 7 stage 5 (1,2,3 vs 1,3,4); id 8 stage 6 (all vs all).

## 3. Routes (client to server)

| Action | Sender | Client checks | Request | Response |
|---|---|---|---|---|
| Open forecast data | `GGM.sendOpenBet` (`GGM:382-388`) from `SevenYearGameView` (`M11/sevenyear/view/battleflag/SevenYearGameView.as:110`) and the forecast tab | none | 9694 (0x25de) `C_GLORYGAME_OP` `PropertyMsg` {`param1` = 4 OPEN_BET} | 4992 |
| Lock prediction | lock button -> confirm "Deseja confirmar o bloqueio da predição?" or, when a prediction exists, "Bloquear novamente atualizará a informação da equipe de predição e o tempo de predição (talvez afetando o prêmio de bônus). Deseja realmente bloquear novamente?" -> `lockConfirm` -> `GGM.sendBet` (`SevenYearGloryGameForecastView.as:203-236`, `GGM:407-413`) | lock enabled only after stage 1 results (`currentRound > 1` or `currentState >= 5`) | C to S 9699 (0x25e3) `C_GLORYGAME_BET`, `Glory.GloryBetMsg` {`playerBet` (#1, repeated `PlayerBetMsg`): one per slot with `id` (#1, INT32) slot 1..8, `round` (#2, INT32) stage, `teamUid1` (#3, STRING), `teamUid2` (#5, STRING); `teamScore1` (#4), `teamScore2` (#6), `betTiem` (#7, INT64) unset} | 4992 with `playerBet` (saved, `betTiem` = lock time ms) |

## 4. Server messages (server to client)

| Opcode | Message | Receiver | When | Effect |
|---|---|---|---|---|
| 4992 (0x1380) `U_C_GLORY_OPEN_BET_VIEW` | `GloryBetMsg` {`playerBet` (#1, PlayerBetMsg, repeated), `allSchedule` (#2, GloryScheduleMsg, repeated), `round` (#3, INT32)} | `GGM.receiveBetInfo` (`GGM:152-182`) | reply to op 4 and to 9699 | `myBetInfos` keyed by `id`; `scheduleInfos` and `teamNameMap`; "BET_INFO_UPDATE" rebuilds the slots |

`PlayerBetMsg`: `id` (#1, INT32), `round` (#2, INT32), `teamUid1` (#3, STRING), `teamScore1` (#4, INT32), `teamUid2` (#5, STRING), `teamScore2` (#6, INT32), `betTiem` (#7, INT64, ms since epoch, shown via `GloryGameBetInfo.betTimeStr`, `CM/mvc/module/gloryGame/GloryGameBetInfo.as:24-53`).

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Base reward per correct prediction | `glory_bet_best_count` = 350 (client default 100) | ConfigInfos; `CM/yishi/datas/ConfigInfoManager.as:1518-1525` |
| Advance bonus | +50% per full day between the lock and the stage deadline; less than 1 day gives no bonus | `forecast.rule` item 2 |
| Re-lock | replaces the record and the lock time | `forecast.rule` item 3 |
| Deadlines | stage start times `getBattleTimeByRoundAndGroup(2..5)` ("Prazo da predição") | `SevenYearGloryGameForecastView.as:142-145` |
| Correctness | (A) a slot is correct when both predicted teams are the ones that actually play that slot (or the winner for slot 8) |
| Reward item | (A) "Pontos de Guerreiro" (item -15000); achievement type 9 "Predizer equipe" progresses per correct prediction ([../hermitage-war/seven-year-event.md](../hermitage-war/seven-year-event.md)) |

## 6. Templates

`TPL/ConfigInfos.xml` `glory_bet_best_count`.

## 7. Persistent state

```sql
CREATE TABLE glory_supremacy.predictions (
  season_id     INTEGER NOT NULL REFERENCES glory_supremacy.seasons(season_id) ON DELETE CASCADE,
  player_id     BIGINT NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  slot_id       SMALLINT NOT NULL CHECK (slot_id BETWEEN 1 AND 8),
  stage         SMALLINT NOT NULL,
  team_uid_1    UUID,
  team_uid_2    UUID,
  locked_at     TIMESTAMPTZ NOT NULL,
  rewarded      BOOLEAN NOT NULL DEFAULT false,
  reward_amount INTEGER NOT NULL DEFAULT 0,
  PRIMARY KEY (season_id, player_id, slot_id)
);
```

## 8. Backend implementation notes

- `glory_supremacy::forecast::handle_open` (op 4): reply 4992 with all schedules of the season and the player's predictions (`teamScore*` filled with actual results once known, A).
- `glory_supremacy::forecast::handle_bet` (9699): stage 1 finished; for each slot whose deadline has not passed, validate the team pools by group, upsert with `locked_at = now()`; slots past their deadline keep the old record; reply 4992.
- After each knockout stage: evaluate slots of that stage, reward `350 * (1 + 0.5 * floor((deadline - locked_at) / 1 day))` per correct slot (A), mark `rewarded`, update achievement type 9.

## 9. Open questions and assumptions

- (A) Correctness rule and reward formula details; reward item.
- (A) Whether partial re-locks (only some slots) are allowed; the client always sends all 8 slots.

## 10. Implementation checklist

- [ ] Op 4 -> 4992 with schedules and bets.
- [ ] 9699 lock with deadlines per slot and team pool validation.
- [ ] Stage evaluation and rewards with advance bonus.
- [ ] Table `predictions`.
- [ ] Tests: lock before stage 1 ends (refused), re-lock resets time, deadline passed.
