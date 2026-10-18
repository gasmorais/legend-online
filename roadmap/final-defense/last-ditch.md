# Final defense lane game ("Última Trincheira")

Feature [final-defense](README.md), module `last-ditch`.

Path aliases:

| Alias | Path |
|---|---|
| `FDM` | `decompiled/core_module/scripts/managers/FinalDefenseManager.as` |
| `FDMOD` | `decompiled/core_module/scripts/mvc/module/finaldefense/FinalDefenseModel.as` |
| `FDI` | `decompiled/core_module/scripts/mvc/module/finaldefense/info/FinalDefenseInfo.as` |
| `FD` | `decompiled/m11/scripts/finaldefense/` |

## 1. Overview

- Game 4 of the game box. The scene `FINAL_DEFENSE_SCENE` (1140x440 field) has 5 rows (`rowIndex` 0..4). The player owns up to 4 defensive units (`ditchTempId1..4`, `selfNPCList`) placed per row; monsters (`npcList`) enter from the right and walk left 1 px per frame until a row limit (`MIN_X = [0, 205, 170, 135, 100]`) or until a unit of the row is alive (`FD/view/FinalDefenseMonsterView.as:18`, `:70-96`).
- Combat is client timed, server resolved: every own unit fires every 2000 ms when its row has a monster (`FD/view/FinalDefenseRoleView.as:156-179`) and every monster that stopped attacks the unit of its row; each hit is a 9563 request `op = 1` (`attakDitchId`, `defenceDitchId`) answered by 267 with hp and beaten flags.
- Energy ("Energia", bar max 900, `FD/view/FinalDefensePowerPrgView.as:68-73`) comes from killed monsters (`dieTakeEnergy`) and upgrades units: one button when `NextTemplateIds` has one id, or a 3 way choice life 101 / ice 201 / fire 301 (`FD/view/FinalDefenseRoleView.as:207-321`).
- 3 skills (bottom bar): buy (op 3) and use (9563 op 2). Effects shown client side: skill 1 and 3 animation in the center, skill 2 stops every monster 10 s, skill 3 pushes every monster back to its spawn point (`FD/view/FinalDefenseShowUseSkill.as:35-83`).
- 5 rounds ("Iniciar" button, op 6); round index image `min(rounds, 5)`; button disabled when `rounds > 5` (`FD/view/FinalDefenseGameStarView.as:36-69`). Each round has a countdown `leftSecond` (`FD/view/FinalDefenseTopView.as:58-72`).
- Score boxes on the right: thresholds 100, 500, 1500, 3000, 5000 points (`SORCE_ARR`, `FD/view/FinalDefenseRightView.as:42`); box ids 1, 2, 4, 8, 16 are bits of `boxTakeMark`; click shows the drop list (270) and "claim" sends op 1 (`FD/view/FinalDefenseBoxRewardView.as:50-96`).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `FD/FinalDefenseScene.as` | scene `FINAL_DEFENSE_SCENE` | Scene; on enter sends op 5, on leave op 7 (`:47-54`, `:159-170`) | game box game 4 (`GameBoxManager.as:180-183`); exit via HUD -> space (`decompiled/core_module/scripts/ui/maintoolbar/MainToolBar.as:1655-1657`) | all views |
| `FD/view/FinalDefenseView.as`, `FinalDefenseRoleView.as`, `FinalDefenseMonsterView.as` | - | Field, own units, monsters (`images/pvz/{ResPath}.swf`, `decompiled/core_module/scripts/yishi/manager/PathManager.as` `getFinalDefenseRes`) | scene | `selfNPCList`, `npcList`, positions `x = 50 + 1140 * bornPoint / 100 + (4 - row) * 35`, `y = 50 + 440 * row * 0.18` (`FinalDefenseRoleView.as:145-149`) |
| `FD/view/FinalDefenseRightView.as`, `FinalDefenseBoxRewardView.as` | "{0}pts" | Score, round, 5 boxes | scene | `score`, `rounds`, `boxTakeMark`, `dropDict` |
| `FD/view/FinalDefenseBottomView.as`, `FinalDefenseSkillItem.as` | - | 3 skills with counts and buy buttons | scene | `skillCount1..3` |
| `FD/view/FinalDefenseTopView.as`, `FinalDefensePowerPrgView.as`, `FinalDefenseGameStarView.as` | - | Countdown, energy, start round | scene | `leftSecond`, `energy`, `rounds` |

## 3. Routes (client to server)

### R1. Load state (9560 op 5)

- UI: scene enter (`FD/FinalDefenseScene.as:53`). Sender `FDM.getInfo` (`FDM:175-181`).
- Request: 9560 (0x2558) `C_LASTDITCH_OP`, `LastDitchMsg` (package `gamebox`) with `op` (#12) = 5.
- Response: 258 with the full state and own units; 270 drop list (assumption: sent with the state so the boxes can show contents).

### R2. Start round (9560 op 6)

- UI: start button (`FinalDefenseGameStarView.as:62-69`), disabled when `rounds > 5`.
- Request: `op = 6` (`FDM:191-197`).
- Response: 262 (monsters of the round, `leftSecond`) and 264 (round start, `rounds`, `leftSecond`) -> `isGameStar = true`, units start attacking.

### R3. Upgrade a unit (9560 op 2)

- UI: level up buttons (`FinalDefenseRoleView.as:236-247`, `:308-321`). Client check: `upgradeNeedEnergy <= energy` (button state, `:207-229`).
- Request: `op = 2`, `id` (#17) unit id, `npcIndex` (#15) row index, `nextTempIndex` (#16) target template id (`NextTemplateIds` single id, or 101 / 201 / 301) (`FDM:252-261`).
- Response: 258 (`op = 2`, energy, replaced unit in `ditchNpcInfo`). With `op == 2` the client does not touch `rounds` (`FDM:103-109`).

### R4. Buy a skill (9560 op 3)

- UI: buy button of skill i (`FinalDefenseSkillItem.as:116-119`).
- Request: `op = 3`, `skillIndex` (#14) 1..3 (`FDM:263-270`).
- Response: 258 with `skillCount1..3` (cost unknown: energy, gold or diamonds; assumption: game box medals or diamonds).

### R5. Claim a score box (9560 op 1)

- UI: box popup button (`FinalDefenseBoxRewardView.as:50-53`); boxes are clickable when `score >= threshold` (`FinalDefenseRightView.as:129-138`).
- Request: `op = 1`, `boxId` (#13) 1, 2, 4, 8 or 16 (`FDM:306-313`).
- Response: 258 with `boxTakeMark` bit set; bag update.

### R6. Leave (9560 op 7)

- Trigger: scene leaving (`FD/FinalDefenseScene.as:159-170`), `FDM.exitGame` (`FDM:183-189`).
- Request: `op = 7`. No reply needed.

### R7. Hit (9563 op 1)

- Trigger: own unit every 2 s if a monster is in its row (`FinalDefenseRoleView.as:162-179`); monster every 2 s after it stops, against the unit of its row (`FinalDefenseMonsterView.as:98-109`, `:138-146`).
- Request: 9563 (0x255b) `C_LASTDITCH_BATTLE`, `LastDitchBattleMsg`: `attakDitchId` (#2) attacker id, `defenceDitchId` (#4) target id, `op` (#5) = 1 (`FDM:208-216`).
- Response: 267 `op = 1` with the target in `ditchNpcInfo` (`hp`, `isBeaten`).

### R8. Use a skill (9563 op 2)

- UI: skill icon when `skillCount > 0` (`FinalDefenseSkillItem.as:107-114`).
- Request: 9563 `op = 2`, `useSkillId` (#3) 1..3 (`FDM:272-279`).
- Response: 267 `op = 2`, `useSkillId` -> client decrements `skillCount{id}` and plays the effect (`FDM:243-249`); server applies damage/freeze/knock back.

### R9. Monster move (9562)

- Sender `FDM.monsterMove(id, bornPoint)` sends 9562 (0x255a) `C_LASTDITCH_MOVE`, `DitchNpcInfoMsg` `id` (#1), `bornPoint` (#4) (`FDM:199-206`), but `FinalDefenseMonsterView.sendMove` is empty (`:134-136`): never sent in this build.

## 4. Server messages (server to client)

### 258 (0x0102) `U_C_LASTDITCH_UPDATE`

- Message `LastDitchMsg` (package `gamebox`): `ditchTempId1..4` (#1..#4, INT32) own unit template per slot; `skillCount1..3` (#5..#7, INT32); `energy` (#8, INT32); `score` (#9, INT32); `boxTakeMark` (#10, INT32) claimed box bits; `rounds` (#11, INT32) current round (ignored when `op == 2`); `op` (#12, INT32) echo; `boxId` (#13), `skillIndex` (#14), `npcIndex` (#15), `nextTempIndex` (#16) request echoes; `id` (#17, INT32) game id; `ditchNpcInfo` (#18, MESSAGE `DitchNpcInfoMsg`, repeated) own units.
- `DitchNpcInfoMsg`: `id` (#1, INT32) unit instance; `templateId` (#2, INT32) `DitchTemplateInfos` id; `types` (#3, INT32); `bornPoint` (#4, INT32) x percent; `rowIndex` (#5, INT32) 0..4; `hp` (#6, INT32); `isBeaten` (#7, BOOL) hit this tick.
- Receiver: `FDM.onInfo` (`FDM:55-128`): only present fields overwrite; units are merged into `selfNPCList`; a change of `rounds` between two non zero values ends the round client side (`FDI:59-67`). Notifies `FINAL_DEFENSE_INFO`.

### 262 (0x0106) `U_C_LASTDTICH_ADDNPC`

- Message `DitchNpcInfoListMsg`: `ditchNpcInfo` (#1, repeated) monsters to spawn; `rounds` (#2, INT32); `leftSecond` (#3, INT32).
- Receiver: `FDM.onAddNPC` (`FDM:130-156`) -> `FINAL_DEFENSE_ADD_NPC` (monster views created, `FD/view/FinalDefenseView.as:39-56`).

### 264 (0x0108) `U_C_LASTDTICH_START`

- Same message; `rounds`, `leftSecond`. Receiver `FDM.onGameStar` (`FDM:158-173`) sets `isGameStar` and starts the countdown.

### 267 (0x010b) `U_C_LASTDTICH_BATTLERESULT`

- Message `LastDitchBattleMsg`: `ditchNpcInfo` (#1, repeated) affected units (id, templateId, hp, isBeaten); `attakDitchId` (#2); `useSkillId` (#3); `defenceDitchId` (#4); `op` (#5) 1 hit, 2 skill.
- Receiver: `FDM.onBattleResult` (`FDM:218-250`): op 1 -> each role view flashes when `isBeaten` and dies when `hp <= 0` (`FinalDefenseRoleView.as:323-357`); op 2 -> skill count -1 and effect.

### 270 (0x010e) `U_C_LASTDITCH_DROP`

- Message `GemMazeInfoMsg` (package `minigame`, shared with the gem maze): only `dropItemList` (#13, MESSAGE `DropItemInfoMsg`, repeated) is read: `score` (#1, INT32) box id (1, 2, 4, 8, 16), `itemTempId` (#2, INT32), `count` (#3, INT32).
- Receiver: `FDM.onBoxReward` (`FDM:281-304`) builds `dropDict[boxId]`.

## 5. Rules and formulas

- Rows 0..4, field 1140x440; attack interval 2000 ms (client).
- Score boxes: 100 / 500 / 1500 / 3000 / 5000 points -> bits 1 / 2 / 4 / 8 / 16 of `boxTakeMark`.
- Max rounds 5; after round 5 the start button stays disabled.
- Energy display max 900 (bar scale only).
- Unit template fields (`decompiled/core_module/scripts/yishi/datas/templates/DitchTemplateInfo.as`): `TemplateId`, `Types`, `HP`, `Attack`, `Speed`, `AttackType` 1..4 (attack effect `finaldefenceskill0{n}0/1`), `BornPoints`, `ResPath`, `NextTemplateIds`, `upgradeNeedEnergy`, `dieTakeEnergy`, `dieTakeTempIds`, `roundRandom1..5` (monster spawn weights per round, assumption).
- Daily play count, cost and score to reward mapping are not in client data (game box owns entry limits).

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `DitchTemplateInfos` (loaded by `decompiled/core_module/scripts/yishi/manager/TempleteManager.as:1217`) | units and monsters | see section 5. **Not present in `raw/xml/tempinfos/`** (292 files, no ditch file): must be recovered or authored |

## 7. Persistent state

Schema `final_defense`.

```sql
CREATE TABLE final_defense.last_ditch_game (
  game_id              BIGSERIAL   PRIMARY KEY,
  player_id            BIGINT     NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  round                SMALLINT    NOT NULL DEFAULT 0 CHECK (round BETWEEN 0 AND 6),
  energy               INTEGER     NOT NULL DEFAULT 0 CHECK (energy >= 0),
  score                INTEGER     NOT NULL DEFAULT 0 CHECK (score >= 0),
  box_take_mark        SMALLINT    NOT NULL DEFAULT 0 CHECK (box_take_mark BETWEEN 0 AND 31),
  skill_counts         SMALLINT[]  NOT NULL DEFAULT '{0,0,0}',
  started_at           TIMESTAMPTZ NOT NULL DEFAULT now(),
  finished_at          TIMESTAMPTZ
);
CREATE UNIQUE INDEX last_ditch_active_idx ON final_defense.last_ditch_game (player_id) WHERE finished_at IS NULL;
```

Units and monsters of a running game are kept in memory (session state); only the game row is persisted.

## 8. Backend implementation notes

- `final_defense::last_ditch::handle_op` (9560) dispatches by `op`: 5 load (create a game if none active), 6 start round (spawn monsters from `roundRandom*`), 2 upgrade, 3 buy skill, 1 claim box, 7 leave (finish game).
- `final_defense::last_ditch::handle_battle` (9563): op 1 validates attacker and target exist, same row, attacker alive, rate limit about 1 hit per 2 s per unit; applies `Attack`; on monster death add `dieTakeEnergy` and score; op 2 consumes a skill and applies its effect to all monsters.
- Round end: when all monsters of the round are dead or `leftSecond` reaches 0, push 258 with the next `rounds`. Game over when a monster reaches the left edge of an empty row (assumption).
- No battle engine; no pushes to other players.

## 9. Open questions and assumptions

- `DitchTemplateInfos.xml` is missing; unit stats, monster waves and rewards cannot be derived from the client.
- Skill prices and score per kill.
- Whether the server validates timing or trusts the client hit stream.
- Box drop table source (270 is the only data; assumed static per box).

## 10. Implementation checklist

- [ ] Screen: `FinalDefenseScene` and its views
- [ ] Route R1 op 5 load
- [ ] Route R2 op 6 start round -> 262, 264
- [ ] Route R3 op 2 upgrade
- [ ] Route R4 op 3 buy skill
- [ ] Route R5 op 1 claim box
- [ ] Route R6 op 7 leave
- [ ] Route R7 9563 op 1 hit -> 267
- [ ] Route R8 9563 op 2 skill -> 267
- [ ] Server messages 258, 262, 264, 267, 270
- [ ] Table `final_defense.last_ditch_game`
- [ ] Data: author `DitchTemplateInfos`
- [ ] Test: box claimable only above its threshold and once
