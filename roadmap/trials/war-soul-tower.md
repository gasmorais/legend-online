# War Soul Tower ("Torre da Guerra")

Area: trials, module `war-soul-tower`. Client package `warsoultower` (`decompiled/m11/scripts/warsoultower`), manager `yishi.manager.WarSoulTowerManager`, model `mvc.module.warsoultower.WarSoulTowerModel`, controller key `warsoultower`, proto package `warsoultower`.

Path aliases:

| Alias | File |
|---|---|
| WSTM | `decompiled/core_module/scripts/yishi/manager/WarSoulTowerManager.as` |
| WSTMOD | `decompiled/core_module/scripts/mvc/module/warsoultower/WarSoulTowerModel.as` |
| WSTF | `decompiled/m11/scripts/warsoultower/WarSoulTowerFrame.as` |
| WSTR | `decompiled/m11/scripts/warsoultower/WarSoulTowerResultFrame.as` |
| SPH | `decompiled/core_module/scripts/yishi/SwitchPageHelp.as` |
| BUI | `decompiled/m10/scripts/battle/view/ui/BattleUIView.as` |

## 1. Overview

A 500 floor endless tower. Once per day the player starts a single battle (battleType 3905 `WARSOULTOWER_BATTLE`) that chains floors as reinforcement waves: the fight starts a few floors below the record and continues until the player loses, times out or quits with "Encerrar". Every floor cleared gives a reward: "Prêmio de 1ª passagem" (first clear of a floor above the old record), "Prêmio de Repetição" (floor already cleared before) and "Prêmio de Estágio" (every 10th floor, first time). After the battle the result frame lists the rewards of the run.

Help text (`warSoulTowerFrame.helperFrame.helpTxt.text`): one challenge per day reset at 0:00; first clear gives the first clear reward, repeating gives the repeat reward, stage rewards at milestones; after the daily reset the challenge restarts 5 floors below the highest record.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `warsoultower.WarSoulTowerFrame` (`WSTF:88`), 1043 x 717 | "Torre da Guerra" (`warSoulTowerFrame.titleText`) | Tower map of 15 floors around the record, current floor, record, challenges left, boss armour and skills, reward panels, "Desafiar" button, help | controller `warsoultower` openType 0 (`decompiled/core_module/scripts/mvc/controler/WarSoulTowerController.as:43-50`) | `currentLevel`, `highestLevel`, `challengeTimes` from 530; templates |
| Left panel "Prêmio Final" (`rewardsTxt.text1`, `WSTF:203-210`) | "Prêmio Final" | Next 5 floors above the record with their first clear rewards (`WarSoulTowerItem(1)`), and the last 5 cleared floors with their repeat rewards (`WarSoulTowerItem(2)`) (`WSTF:287-312`); empty texts "Desafiou com sucesso todos os níveis. Nenhum prêmio de Primeira conclusão disponível!" / "O nível ainda não foi desafiado com sucesso. O Prêmio de Repetição ainda não foi ativado!" | left arrow | `highestLevel` |
| Left panel "Prêmio Fase" (`rewardsTxt.text2`, `WSTF:212-219`) | "Prêmio Fase", rows "Prêmio do Ponto do {0}° andar" with "Retirado" / "Não Retirado" | All stage reward rows (`WarSoulTowerStageItem`, claimed when `LevelId <= highestLevel`, `decompiled/m11/scripts/warsoultower/WarSoulTowerStageItem.as:60-71`) | right arrow | stage templates |
| Floor icons `WarSoulTowerLevelItem` x 15 (`WSTF:242-271`) | "{0}° piso" | Floor id, state frame, required armour | frame | `getState(level)` (`WSTMOD:73-88`): 1 below current, 2 cleared, 3 next, 4 locked; window `beginLevel..beginLevel+14` (`WSTMOD:90-121`) |
| `warsoultower.WarSoulTowerResultFrame` (`WSTR:59`), 789 x 314 | "O desafio foi superado com sucesso" | Start floor, end floor, highest unlocked floor, "new record" stamp, 3 tabs: repeat, first clear, stage rewards with item lists ("Prêmio de Repetição do {0}° andar", "Prêmio de 1ª passagem do {0}° andar", "Prêmio de Estágio do {0}° andar") | controller `warsoultower` openType 1 after the battle when `overLevel > 0` (`decompiled/m3/scripts/map/space/SpaceSceneController.as:446-452`, `decompiled/m4/scripts/castle/CastleSceneView.as:331-337`) | 531 |
| Battle button `_warsoulEndBtn` (`BUI:216-219`, `BUI:1268-1271`) | confirm "Deseja encerrar o desafio atual? Caso encerre, você não poderá entrar novamente na Torre da Guerra hoje." | Quit the run and keep rewards | battleType 3905 HUD | none |

## 3. Routes (client to server)

### R1. Open the tower
- UI: frame construction (`WSTF:94`).
- Sender: `WarSoulTowerManager.sendOpen` (`WSTM:81-87`).
- Client checks before opening (`SPH:3120-3148`): hero changed job ("Ativado ao obter Profissão de Cavaleiro"); quest 1390 "Desafio até o Topo" finished (`TaskManage.WARSOUL_TOWER = 1390`, `decompiled/core_module/scripts/yishi/manager/TaskManage.as:65`), else "Primeiro complete a missão: {0}"; `checkScene()` (not in a PvE/PvP room, `SPH:1883-1899`); royalty level >= `RoyaltyTemplates.OpenWarSoulTower` first level (10) else "Abre com Realeza Nv. {0}".
- Route: send 9709 (0x25ed) `C_WAR_SOUL_TOWER_CLIENT_OP`.
- Message `simple.PropertyMsg`: `param1` (#1, INT32) = 0 (`OP_OPEN`, `WSTM:20`). Other fields unset.
- Response: 530 `U_C_WAR_SOUL_TOWER` (S1).

### R2. Challenge ("Desafiar")
- UI: `_challengeBtn` (`WSTF:198-201`).
- Sender: `WarSoulTowerManager.sendBattle` (`WSTM:89-95`).
- Client checks: none (the button is always enabled; the count is only displayed). Server must reject when `challengeTimes == 0`.
- Route: send 9709 (0x25ed) `C_WAR_SOUL_TOWER_CLIENT_OP`, `PropertyMsg.param1` (#1, INT32) = 1 (`OP_BATTLE`, `WSTM:22`).
- Response: battle creation (157 `BattlePrepareMsg` etc., see [docs/battle/server-engine.md](../../docs/battle/server-engine.md)) with battleType 3905; then 530 with `challengeTimes` decremented (assumption, the frame closes when the scene switches).
- After the battle: 531 `U_C_WAR_SOUL_TOWER_RESULT` before the battle report, so `overLevel` is set when the scene returns (S2).

### R3. Quit the run ("Encerrar")
- UI: battle HUD button (`BUI:567-586`), confirm dialog.
- Sender: `SocketSendManager.sendRemoveBattle` (`decompiled/core_module/scripts/yishi/service/managers/SocketSendManager.as:499-505`).
- Route: send 10497 (0x2901) `B_REMOVE_BATTLE`; message `battle.BattleReqMsg`: `battleId` (#2, STRING) current battle id; `userId` (#1), `armyId` (#3), `otherObj` (#4) unset.
- Response: end the battle as a normal finish (154 `PrepareOverMsg`, 4103 report) with 531 sent first. The run counts as used.

## 4. Server messages (server to client)

| Opcode | Message and fields | Client receiver | When |
|---|---|---|---|
| 530 (0x0212) `U_C_WAR_SOUL_TOWER` | `warsoultower.WarSoulTowerRspMsg`: `currentLevel` (#1, INT32) floor where today's run starts; `highestLevel` (#2, INT32) record floor; `challengeTimes` (#3, INT32) runs left today | `WarSoulTowerManager.__warSoulTowerHandler` (`WSTM:58-67`): sets model, notifies `WARSOULTOWER_UPDATE` -> `WSTF.refreshView` (`WSTF:193-196`, `:273-334`) | Reply to R1; after every run; at login (assumption, `TaskTemplate.checkWarSoulTowerLevel` reads `highestLevel`, `decompiled/core_module/scripts/mvc/module/task/TaskTemplate.as:938-946`); at daily reset if online |
| 531 (0x0213) `U_C_WAR_SOUL_TOWER_RESULT` | `warsoultower.ResultRspMsg`: `isNewRecord` (#1, BOOL); `highestUnLockLevel` (#2, INT32) record after the run; `startLevel` (#3, INT32); `endLevel` (#4, INT32) last floor cleared (0 when nothing cleared); `rewards` (#5, repeated `RewardRspMsg`: `level` (#1, INT32) floor, `state` (#2, INT32) 0 first clear plus stage reward, 1 repeat, 2 first clear only) | `WarSoulTowerManager.__warSoulTowerResultHandler` (`WSTM:69-79`); `WarSoulTowerModel.rewards` setter splits the list (`WSTMOD:45-71`): state 0 -> pass and stage lists, 1 -> repeat list, other -> pass list | Once at the end of each run, before the battle report |
| `WarSoulTowerLevelInfoRspMsg` | `level` (#1, INT32), `state` (#2, INT32) | none | Declared in the proto package, no client reader |

The result frame opens only when `overLevel > 0` (`decompiled/m3/scripts/map/space/SpaceSceneController.as:448`).

## 5. Rules and formulas

- Floors: `WarSoulTowerLevelTemplates.xml`, `LevelId` 1..500; `max` = number of rows (`decompiled/core_module/scripts/yishi/datas/templates/cate/WarSoulTowerLevelTempCate.as:37-46`).
- Daily runs: 1 (help text; `challengeTimes` default 1, `WSTMOD:21`). Reset at 0:00.
- Start floor after reset: 5 floors below the record (help text point 3). Proposed: `currentLevel = max(1, highestLevel - 4)` (assumption on the exact offset: "a partir das 5 primeiras fases" below the record).
- Battle: battleType 3905, one battle for the whole run. Each floor is a wave: heroes `Heroes` (`templateId,pos`), pawns `Pawns` (`templateId,pos|...`). Wave counter is shown with `TrailCountView` from `BattleModel.trialLayer`, set from `currentWave` on create and `reinforceWave` on each reinforcement (`decompiled/core_module/scripts/battle/transaction/CreateGameTransaction.as:121`, `decompiled/core_module/scripts/battle/handler/ReinforceHandler.as:152-158`). Seal skills are disabled in 3905 (`decompiled/core_module/scripts/battle/view/ui/SkillItemListView.as:197`).
- Rewards per floor cleared in the run:
  - floor > old record: `FirstRewardItemId1..3 x FirstRewardItemNum1..3`; if a stage row exists with that `LevelId`, also `StageRewardItemId1..3` (state 0), else state 2.
  - floor <= old record: `RepeatRewardItemId1..3 x RepeatRewardItemNum1..3` (state 1).
- Stage rows: every 10 floors (`WarSoulTowerStageRewardTemplates.xml`, `LevelId` 10..500); shown as claimed when `LevelId <= highestLevel`.
- `NeedArmourValue` is shown as the recommended armour value of the current floor and on every floor icon; the client does not check it.
- Boss skill descriptions: `BossSkill` CSV of skill template ids (`WSTF:318-333`).
- Unlock: quest 1390 "Desafio até o Topo" (prereq 1389, level 80..100, "Fale com Eliza no Reino do Céu para saber sobre a Torre da Guerra"); royalty level 10 (`raw/xml/tempinfos/RoyaltyTemplates.xml` first row with `OpenWarSoulTower="1"`); quest condition type 268 `WARSOUL_TOWER_LEVEL` uses `highestLevel >= Para2` (`decompiled/core_module/scripts/yishi/datas/consant/TaskConditionType.as:136`).
- Entry: space (Reino do Céu) NPC dialog option type 160 (`decompiled/m3/scripts/map/space/view/frame/DialogOptionItem.as:880-881`).

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `raw/xml/tempinfos/WarSoulTowerLevelTemplates.xml` (category `WarSoulTowerLevelTemplates`, `decompiled/core_module/scripts/yishi/manager/TempleteManager.as:1387`) | one floor | `LevelId`; `Heroes` boss hero `templateId,pos`; `Pawns` soldiers `templateId,pos|...`; `NeedArmourValue`; `BossSkill` CSV; `FirstRewardItemId1..3`, `FirstRewardItemNum1..3`; `RepeatRewardItemId1..3`, `RepeatRewardItemNum1..3` |
| `raw/xml/tempinfos/WarSoulTowerStageRewardTemplates.xml` (`TempleteManager.as:1388`) | milestone reward | `Id`, `LevelId` (10, 20, ..., 500), `StageRewardItemId1..3`, `StageRewardItemNum1..3` |
| `raw/xml/tempinfos/RoyaltyTemplates.xml` | royalty level | `RoyaltyLevel`, `OpenWarSoulTower` |
| `raw/xml/tempinfos/QuestTemps.xml`, `QuestCondictionInfos.xml` | quest 1390 | unlock quest |

## 7. Persistent state

```sql
CREATE SCHEMA IF NOT EXISTS trials;

CREATE TABLE trials.war_soul_tower_state (
    player_id        integer     PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
    highest_level    integer     NOT NULL DEFAULT 0 CHECK (highest_level BETWEEN 0 AND 500),
    current_level    integer     NOT NULL DEFAULT 1 CHECK (current_level >= 1),
    challenges_left  smallint    NOT NULL DEFAULT 1 CHECK (challenges_left >= 0),
    reset_date       date        NOT NULL DEFAULT current_date,
    updated_at       timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE trials.war_soul_tower_run (
    run_id           bigserial   PRIMARY KEY,
    player_id        integer     NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
    battle_id        text        NOT NULL,
    start_level      integer     NOT NULL,
    end_level        integer     NOT NULL DEFAULT 0,
    old_highest      integer     NOT NULL,
    new_record       boolean     NOT NULL DEFAULT false,
    started_at       timestamptz NOT NULL DEFAULT now(),
    finished_at      timestamptz
);
CREATE INDEX war_soul_tower_run_player_idx ON trials.war_soul_tower_run (player_id, started_at DESC);
```

Stage rewards are derived from `highest_level` (a stage row is granted once, the first time the record passes it), so no separate claim table is needed.

## 8. Backend implementation notes

- `trials::war_soul_tower::handle_open` (9709 param1 0): lazy daily reset (if `reset_date < today`: `challenges_left = 1`, `current_level = max(1, highest_level - 4)`), reply 530.
- `trials::war_soul_tower::handle_battle` (9709 param1 1): validate unlock (quest 1390, royalty level 10, job change), `challenges_left > 0`, player not in another battle. In one transaction decrement `challenges_left`, insert a run row. Start battle: battleType 3905, wave 1 = floor `current_level`, reinforcement waves for the next floors (`reinforceCount`, `currentWave` in the create message), map from configuration (assumption: one fixed tower map, unknown id). Push 530.
- On each wave cleared: record `end_level`. On defeat, timeout or 10497 for this battle: compute rewards per floor `start_level..end_level`, grant items, update `highest_level`, send 531 then end the battle (154, 4103), push 530. Rewards and state update in one transaction.
- `trials::war_soul_tower::handle_remove_battle` (10497) is shared with the battle module; it must only finish battles of type 3905 owned by the sender.
- Daily reset at 0:00 server time: push 530 to online players with the tower frame open is optional (the client asks on open).

## 9. Open questions and assumptions

- Assumption: start floor after reset is `max(1, highest_level - 4)`; the help says "a partir das 5 primeiras fases com o recorde de desafio mais alto".
- Assumption: battle map id and wave timer for 3905 are not in the client templates.
- Assumption: rewards are added to the bag directly (no mail); bag full behavior unknown.
- Whether `NeedArmourValue` gates the next wave on the server (armour = war soul armour attribute) is unknown.
- Whether 530 is pushed at login is unknown; sending it at login is harmless and needed by quest condition 268.

## 10. Implementation checklist

- [ ] Table `trials.war_soul_tower_state`, `trials.war_soul_tower_run`
- [ ] Template loaders for `WarSoulTowerLevelTemplates.xml`, `WarSoulTowerStageRewardTemplates.xml`
- [ ] R1 9709 param1 0 -> 530
- [ ] R2 9709 param1 1 -> battle 3905 with floor waves
- [ ] R3 10497 ends a 3905 battle
- [ ] S1 530 at login and after runs
- [ ] S2 531 before the battle report
- [ ] Daily reset rule
- [ ] Reward rules (first, repeat, stage)
- [ ] Tests: first run from floor 1, repeat run after reset, quit mid run, stage reward once, 0 runs left rejected
