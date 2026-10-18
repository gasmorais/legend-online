# Pet arena (Arena de Einherjar)

Path aliases:

| Alias | File |
|---|---|
| PCM | `decompiled/core_module/scripts/managers/PetChallengeManager.as` |
| PCMOD | `decompiled/core_module/scripts/mvc/module/petchallenge/PetChallengeModel.as` |
| PCC | `decompiled/core_module/scripts/mvc/controler/PetChallengeController.as` |
| V | `decompiled/m14/scripts/petchallenge/` |

## 1. Overview

Asynchronous cross server PvP for pets. The player sets a team of up to 3 pets ("Ajustar Formação") and, for each, the order of 3 awakening skills. Each day he has `Pet_Challenge_Count` = 10 challenges against opponents of similar score; the server simulates a pet battle (battleType 35). Wins add score; score defines the league group ("Reino", "Diamantes", "Ouro branco", "Ouro", "Prata", "Bronze"). Weekly, Monday 0h, the server pays rewards per group and rank and resets. Each week has element bonus points: pets of some elements give extra score. Help (`PetChallengeFrame.helpContent`): "Clique para começar, o sistema irá combinar jogadores com pontuação semelhante para efetuar batalha ... Quando o jogador atingir vip3 ou mais, pode-se selecionar para terminar imediatamente o combate ... O Cálculo dos pontos será feita todas as segundas às 0h, não será possível desafiar."

Unlock: lord level >= 50 (`Pet_Challenge_Grade`, `PCC:68-85`) and at least one pet ("No momento não tem Einherjar, não poderá entrar na batalha.").

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `V/PetChallengeFrame.as` | "Arena de Einherjar" (`:123`) | Tabs ranking (`sortBtn`), challenge (`challengeBtn`), report (`reportBtn`); left info; requests data on open (`:54`) | `PCC` openType 2: queue bar item type 4 (`decompiled/core_module/scripts/ui/queuebar/QueueBar.as:266-276`), reopen after a battle of type 35 (`decompiled/core_module/scripts/battle/handler/BattleResultHandler.as:362-365` -> castle `decompiled/m4/scripts/castle/CastleSceneView.as:131-134` or space `decompiled/m3/scripts/map/space/SpaceSceneController.as:256-259`) | |
| `V/views/PetChallengeInfoView.as` | "Pontos atuais:", "{0}º lugar", "Ver prêmios" | Self score, group, rank, next group gap "PetChallengeInfoView.nextScoreText.text", weekly reward preview | frame | `PCMOD.selfInfo`, `PetChallengeRewards.xml` |
| `V/views/PetChallengeListView.as`, `V/views/PetChallengeItemView.as` | "Número de desafios restantes: {0}/{1}", "Desafiando jogadores com mais pontos, ao vencê-los obterá mais pontos." | Ranking list (from `crosspet.xml`), opponents list, report list; cooldown button; "Próxima atualização: {0}" | frame | `sortList`, `challengeList`, `reportList` (`PCMOD:396-411`) |
| `V/views/PetChallengeTeamView.as`, `V/views/PetChallengeTeamItemView.as`, `V/views/PetChallengeSkillView.as`, `V/views/PetChallengeSkillSelectView.as` | "Clique no ícone para ajustar formação ou a ordem das habilidades." | Team pets and 3 skill slots each | frame | `cha_pos`, `cha_skill_indexs` |
| `V/views/PetChallengeResiPointView.as` | element names "Fogo|Vento|Luz|Choque|Água|Escuridão" | Weekly element bonus points | frame | `weekResiPointArr` |
| `V/PetFormationFrame.as`, `V/views/PetFormationItemView.as`, `V/views/PetFormationPetHeadView.as` | "Ajustar Formação" | Drag up to 3 pets; closing with < 3 asks "Pode configurar no máximo 3 Einherjars na Arena, Fechar?"; with 0 "Configure pelo menos um Einherjar." | team view | |
| `V/views/PetChallengeWeekRewardTipView.as` | "Campeão Semanal", "2º lugar da semana:" .. | Weekly reward table tip | info view | rewards template |
| `yishi.view.frame.PetChallengeReportFrame` (core) | | Weekly result popup after claiming | `PCC` openType 1 from top bar (`decompiled/core_module/scripts/ui/toptoolbar/TopToolsBar.as:1815-1838`) | rank, score |

## 3. Routes (client to server)

### R1. Load arena data
- UI: frame construction (`V/PetChallengeFrame.as:54`).
- Sender: `PCM.requestChallengeData(type = 1)` (`PCM:201-207`).
- Route: send 8256 (0x2040) `C_CHALLENGEINFO_REQUEST`, `ChallengeRequestMsg` (package pet): `type` (#1, INT32) = 1 (pet arena).
- Response: 4611 (S1) and 4176 (S2, `type` 1).
- Ranking tab: HTTP GET `{TEMPLATE_PATH}crosspet.xml` (`PCMOD:302-306`, `routes/routes.md`), root attribute `createDate` (next refresh = createDate + 1800 s), rows `CrossPetScoreRank` with `uuid`, `userid`, `nickName`, `serverName`, `score`, `rank`, `fightCapacity`, `Pet1..Pet3` = "templateId,name,grade,quality,fightPower" (`PCMOD:323-395`).

### R2. Challenge an opponent
- UI: challenge button on an opponent (`V/views/PetChallengeItemView.as:112-135`).
- Client checks: cooldown running -> `colosseum.view.ColosseumListView.command02`; no team -> "Favor configurar a Equipe de Arena dos Einherjars."; no remaining count -> `godarrive.GodArriveFrame.NoLeftCount`.
- Sender: `PCM.sendChallengeCommand(uuid)` (`PCM:209-215`).
- Route: send 8724 (0x2214) `C_CHALLENGE_PET`, `ChallengeMsg` (package player): `uuid` (#5, STRING) opponent; `tar_userId` (#1), `tar_armyId` (#2), `pay_type` (#3), `type` (#4) unused.
- Response: battle creation for battleType 35 (pets only, `docs/battle/formation.md` "pet battle (35)"), then the battle result, then 4611 and 4176 refreshed.

### R3. Save formation
- UI: closing `V/PetFormationFrame.as` when the string changed (`:427-436`).
- Sender: `PCM.sendPetFormation(formation)` (`PCM:217-223`).
- Route: send 8725 (0x2215) `C_PET_CHALLENGE_FORMATION`, `PlayerPetMsg`: `cha_pos` (#5, STRING) = comma separated pet ids by position (3 entries, 0 or empty for free).
- Response: 4540 with `cha_pos` ([pets.md](pets.md)).

### R4. Set skill order of a team pet
- UI: skill select (`V/views/PetChallengeTeamItemView.as:205-249`): string of 3 indexes into the pet `changeSkills` list (-1 for empty).
- Sender: `PCM.sendPetSkills(petId, indexes)` (`PCM:225-232`).
- Route: send 8726 (0x2216) `C_PET_CHALLENGE_SKILL`, `PetInfoMsg`: `pet_id` (#1), `cha_skill_indexs` (#38, STRING).
- Response: 4540 with `cha_skill_indexs`.

### R5. Clear cooldown
- UI: cooldown button (`V/views/PetChallengeListView.as:169-226`) or queue bar (`QueueBar.as:553,572`, `QueueItem.as:254`); VIP with cool privilege sends directly; otherwise confirm with cost `ceil(remain / (60 * b)) * a` from `Challenge_Cool` = "1,1".
- Sender: `PCM.coolDownChallengeCD(useBind)` (`PCM:244-262`).
- Route: send 8265 (0x2049) `C_QUICKCOOL_CHALLENGE_TIME`, `PayTypeMsg`: `type` (#4) = 1 (pet arena), `pay_type` (#1) = 0 VIP free, 2 bound diamonds allowed, 1 diamonds only.
- Response: 4176 with `left_time` 0.

### R6. Finish battle now
- UI: battle "finish now" (`decompiled/m10/scripts/battle/view/ui/BattleUIView.as:531-550`) needs VIP >= 3 (`Pet_BattleOver_Grade` = 3).
- Route: send 8727 (0x2217) `C_PET_CHALLENGE_END_BATTLE`, `BattleReqMsg.battle_id` (#2, STRING) (`decompiled/m10/scripts/battle/net/BattleSocketOuterManager.as:43-49`).
- Response: battle result immediately.

### R7. Claim weekly reward
- UI: top bar "petweedreward" button (`TopToolsBar.as:1145-1152`), visible when `canAcceptPetChallWeekReward`.
- Sender: `PCM.sendPetRankOperate(2)` (`PCM:234-242`).
- Route: send 8728 (0x2218) `C_PET_RANK_REWARD`, `PetRankRewardMsg`: `type` (#1) = 2 (weekly), `opType` (#4) = 1 (claim), `reward_type` (#5) = 0.
- Response: 4613 with `status` 1, rank and score -> report frame; 115 items.

## 4. Server messages (server to client)

### S1. 4611 (0x1203) `U_C_PET_CHALLENGE_LIST`
- `CrossPetRankMsg` (package pet): `myRank` (#1, PetRankMsg) self; `otherRank` (#2, PetRankMsg, repeated) opponents; `log` (#3, PetLogMsg, repeated) reports; `auto_id` (#4), `max_count` (#5), `cur_count` (#6), `time` (#7, STRING), `type` (#8), `server_id` (#9), `server_name` (#10), `address` (#11), `port` (#12), `param1` (#13), `param3` (#15, BOOL), `is_fresh` (#16, BOOL) unused by the client; `param2` (#14, STRING) weekly element points "a,b,c,d,e,f" in order Fogo, Vento, Luz, Choque, Água, Escuridão.
- `PetRankMsg`: `uuid` (#1, STRING), `user_id` (#2), `server_name` (#3), `nick_name` (#4), `rank` (#5), `score` (#6), `fightCapacity` (#7), `pets` (#8, CrossPetInfoMsg, repeated).
- `CrossPetInfoMsg`: `uuid` (#1), `petId` (#2), `userId` (#3), `serverName` (#4), `name` (#5), `quality` (#6), `templateId` (#7), `hp` (#8), `grade` (#9), resistances (#10..#15), `phyAttack` (#16), `PhyDefence` (#17), `magAttack` (#18), `magDefence` (#19), `defaultSkill` (#20, STRING), `challengeSkill` (#21, STRING), `fightPos` (#22), `fightCapacity` (#23). The client reads template, quality, name, grade, fightCapacity (`PCM:167-184`).
- `PetLogMsg`: `userId` (#1), `tarUserId` (#2), `tarServerName` (#3), `tarNickName` (#4), `result` (#5), `isAttack` (#6, BOOL), `logDate` (#7, STRING), `score` (#8), `pets` (#9, CrossPetInfoMsg, repeated).
- Receiver: `PCM.__loadPetChallengeListHandler` (`PCM:89-165`): opponents sorted by score desc, reports by date desc.

### S2. 4176 (0x1050) `U_C_CHALLENGE_TIME`
- `ChallengeCoolTimeMsg` (package player): `left_time` (#1) cooldown seconds; `challenge_count` (#2) remaining challenges (client sets total = this and current = 0); `total_count` (#3); `type` (#4) 1 = pet arena (other types belong to the colosseum); `total_buyCount` (#5).
- Receiver: `PCM.__petchallengeTimeHandler` (`PCM:186-199`). Also used at login by `decompiled/core_module/scripts/yishi/lunch/LoginInitDataAccept.as` for the colosseum.

### S3. 4613 (0x1205) `U_C_PET_RANK_REWARD`
- `PetRankRewardMsg`: `type` (#1) 2 weekly; `status` (#2) 0 reward available, 1 claimed; `rank` (#3); `opType` (#4); `reward_type` (#5); `score` (#6).
- Receivers: login (`LoginInitDataAccept.as:113,131-150`), `decompiled/core_module/scripts/yishi/manager/BaseManager.as:1304-1316` (status 0 -> show button), `TopToolsBar.as:1815-1838` (status 1 -> open report frame with rank and score).

### S4. 4540 `U_C_PLAYER_PETINFO`
`cha_pos` and `cha_skill_indexs` after R3/R4 ([pets.md](pets.md)).

## 5. Rules and formulas

- Daily challenges `Pet_Challenge_Count` = 10 (`decompiled/core_module/scripts/yishi/datas/ConfigInfoManager.as:577-584`); cooldown cleared with `Challenge_Cool` "1,1" (1 diamond per minute).
- Team: up to 3 pets; at least 1 required; arena team pets cannot be sacrificed, absorbed or refined ([pets.md](pets.md), [growth.md](growth.md)).
- Skills per pet in arena: 3 indexes into `changeSkills` (`decompiled/core_module/scripts/mvc/module/pet/PetData.as:1467-1500`).
- Groups (`PCMOD:181-253`): score lines `Pet_Challenge_Default_Score_Line` = 1600, 2400, 3500, 4000. Group id: rank 1 -> 1 "Reino"; score >= 4000 -> 2 "Diamantes"; >= 3500 -> 3 "Ouro branco"; >= 2400 -> 4 "Ouro"; >= 1600 -> 5 "Prata"; else 6 "Bronze". Score <= 0 -> 6.
- Element weekly bonus: `Pet_Challenge_Resist_Score_Pool` "2,2,4,4,6,6" shuffled weekly (assumption) into `param2`; dual element pets count two elements (117: Luz + Escuridão, 118: Vento + Água, 119: Fogo + Choque, `PCMOD:413-436`, mapping `resiIndexArr` 101,104,106,103,102,105).
- Win/lose score shown per opponent "Vitória: pts ﹢{0} Fracassado: pts ﹢{1}" (formula server side).
- Weekly reset Monday 0h; challenges disabled during calculation.
- Weekly rewards `PetChallengeRewards.xml` (`Type` 2, `Ranking` "group|rank" or "group|from,to"): items 208065 "Fragmentos da Alma da Fusão", 2060488, 3040001, 3040002; for example group 2 rank 1: 208065 x350, group 5 ranks 11+: 208065 x240, 3040001 x380, 3040002 x240. Extra for "Reino": `PetChallengeRewardTemplate.allAddValue` ",50,40,30" all attributes and titles ",47,48,49".
- Finish now: VIP >= 3.

## 6. Templates

| File | Use |
|---|---|
| `raw/xml/tempinfos/PetChallengeRewards.xml` | `Type`, `Ranking`, `RewardType`, `TemplateId`, `Count` |
| `raw/xml/tempinfos/ConfigInfos.xml` | `Pet_Challenge_Grade`, `Pet_Challenge_Count`, `Pet_BattleOver_Grade`, `Pet_Challenge_Default_Score_Line`, `Pet_Challenge_Resist_Score_Pool`, `Challenge_Cool` |
| `{TPL}crosspet.xml` | ranking snapshot generated by the server every 30 minutes |

## 7. Persistent state

```sql
CREATE TABLE einherjar.arena_players (
  player_id         BIGINT      PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
  uuid              TEXT        NOT NULL UNIQUE,
  score             INTEGER     NOT NULL DEFAULT 0,
  rank              INTEGER,
  challenges_left   SMALLINT    NOT NULL DEFAULT 10,
  cooldown_until    TIMESTAMPTZ,
  last_daily_reset  DATE,
  week_reward_rank  INTEGER,
  week_reward_score INTEGER,
  week_reward_state SMALLINT    NOT NULL DEFAULT 2 CHECK (week_reward_state IN (0, 1, 2))
);
CREATE INDEX arena_players_score_idx ON einherjar.arena_players (score DESC);

CREATE TABLE einherjar.arena_logs (
  log_id          BIGSERIAL   PRIMARY KEY,
  player_id       BIGINT      NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  target_uuid     TEXT        NOT NULL,
  target_name     TEXT        NOT NULL,
  target_server   TEXT        NOT NULL,
  is_attack       BOOLEAN     NOT NULL,
  result          SMALLINT    NOT NULL,
  score_delta     INTEGER     NOT NULL,
  target_pets     JSONB       NOT NULL,
  created_at      TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX arena_logs_player_idx ON einherjar.arena_logs (player_id, created_at DESC);

CREATE TABLE einherjar.arena_week (
  week_start      DATE        PRIMARY KEY,
  element_points  SMALLINT[]  NOT NULL CHECK (array_length(element_points, 1) = 6)
);
```

Formation and per pet skill indexes: `einherjar.player_state.challenge_formation` and `einherjar.pet_mode_skills` (mode `challenge`) in [pets.md](pets.md). `week_reward_state`: 0 available, 1 claimed, 2 none.

## 8. Backend implementation notes

- `einherjar::challenge_arena::handle_request` (8256 type 1): daily reset if needed; pick opponents with similar score (cross server pool, assumption: same server first); push 4611 and 4176.
- `einherjar::challenge_arena::handle_challenge` (8724): unlock, team not empty, no cooldown, `challenges_left > 0`, opponent uuid in the offered list -> create battle battleType 35 with both teams (pets only, skills from `cha_skill_indexs`, AI driven) -> on end: score delta (+ element bonus), log for both sides, decrement count, set cooldown -> push result, 4611, 4176.
- `einherjar::challenge_arena::handle_formation` (8725): ids owned, max 3, unique -> save -> 4540.
- `einherjar::challenge_arena::handle_skills` (8726): pet in team, 3 indexes valid -> save -> 4540.
- `einherjar::challenge_arena::handle_cooldown` (8265 type 1): debit diamonds by minutes unless VIP privilege -> 4176.
- `einherjar::challenge_arena::handle_end_battle` (8727): VIP >= 3, battle of this player -> resolve instantly.
- `einherjar::challenge_arena::handle_rank_reward` (8728 type 2 opType 1): state 0 -> grant rewards by group and rank -> state 1 -> 4613 status 1, 115.
- Schedules: daily reset of `challenges_left`; weekly job Monday 0h: compute ranks, groups, store `week_reward_*` state 0, push 4613 status 0 to online players, reset scores (assumption: partial reset), roll element points; every 30 minutes regenerate `crosspet.xml`.

## 9. Open questions and assumptions

- Score formula per win/loss and the reset policy at week start.
- Opponent matching pool (cross server in the original: uuid and server names).
- Whether `challenge_count` is remaining or used (client treats it as remaining).
- Exact battle simulation for battleType 35 (battle engine).

## 10. Implementation checklist

- [ ] Screen: arena frame tabs, info, team, element points, formation frame
- [ ] Route 8256 -> 4611 + 4176
- [ ] Route 8724 challenge -> battle 35
- [ ] Route 8725 formation, 8726 skills -> 4540
- [ ] Route 8265 cooldown
- [ ] Route 8727 finish now
- [ ] Route 8728 weekly claim -> 4613
- [ ] HTTP `crosspet.xml` generator
- [ ] Server messages 4611, 4176 (type 1), 4613
- [ ] Tables `einherjar.arena_players`, `einherjar.arena_logs`, `einherjar.arena_week`
- [ ] Schedules daily reset, weekly rewards, 30 min ranking file
- [ ] Tests: group thresholds, count and cooldown, reward claim once
