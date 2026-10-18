# Guardian roster: obtaining, list, rest, sale, abandonment, look up

Module `roster`. The "Guardião" (code name child) is a companion with a job type (1..10 normal guardians, 101..105 "Espírito de Proteção"), a growth level 1..12, equipment, skills and emblems. This module owns the guardian entity, how guardians are obtained (summon with "Fragmentos da Marca do Deus Escolhido", legacy marriage pregnancy flow), the main frame, the battle state toggles for rest, selling, abandoning (with spouse confirmation), the divorce split, and the shared pushes 4746, 4747, 4749 plus the look up 8875/4758.

Path aliases:

| Alias | File |
|---|---|
| CM | `decompiled/core_module/scripts/managers/ChildManager.as` |
| CS | `decompiled/core_module/scripts/mvc/module/children/ChildSender.as` |
| CMOD | `decompiled/core_module/scripts/mvc/module/children/ChildModel.as` |
| CD | `decompiled/core_module/scripts/mvc/module/children/ChildData.as` |
| CC | `decompiled/core_module/scripts/mvc/controler/ChildControler.as` |
| PM | `decompiled/core_module/scripts/yishi/manager/PlayerManager.as` |
| V | `decompiled/m14/scripts/child/` |

## 1. Overview

- Two client opcodes carry almost every guardian action: send 8868 (0x22a4) `C_CHILDREN_OP` with `ChildrenOpMsg` (`op_type` table below) and send 8869 (0x22a5) `C_CHILDREN_EQUI_OP` with `CommonItemMsg` (equipment, `equipment.md`).
- `ChildrenOpMsg` (package `children`): `op_type` (#1, INT32), `pay_type` (#2, INT32), `property1` (#3, INT32), `property2` (#4, INT32), `property3` (#5, STRING), `property4` (#6, STRING), `property5` (#7, BOOL), `property6` (#8, INT32), `furniture` (#9, FurnitureDecMsg repeated, unused here), `property7` (#10, INT32), `poses` (#11, PosMsg repeated), `inviteFriendids` (#12, INT32 repeated).
- `op_type` constants (`CS:20-118`) and owning file:

| op | Constant | File |
|---|---|---|
| 1 | OP_APPLY | roster |
| 2 | OP_DESTORY | roster |
| 3 | OP_FEED | attributes |
| 4 | OP_RESET_POINT | attributes |
| 5 | OP_JOB | roster (no caller) |
| 6 | OP_ENTER_WAR | formation |
| 7 | OP_REST | roster |
| 8 | OP_LEARN_SKILL | skills |
| 9 | OP_UPGRADE_SKILL | skills |
| 10 | OP_UP_GROWGH_VALUE | attributes |
| 11 | OP_MOOD | attributes |
| 12 | OP_SEX | roster |
| 13 | CONFIRM_DESTORY | roster |
| 14 | APT_RESET_ITEM | attributes |
| 15 | REFRESH_FEED_ITEM | attributes (no caller) |
| 16 | CARRY_SKILL | skills |
| 17..21, 23 | emblem ops | emblem |
| 22 | SET_FIRST_POS | no caller |
| 24 | SELL_CHILD | roster |
| 25 | OP_SOUL_FEED (awaken) | handbook |
| 26 | OP_CALL | handbook |
| 27 | OP_SWITCH | attributes (conversion) |
| 28 | SPIRIT_COMPOSE | handbook |
| 29..34, 36..39, 44..49 | spirit ops | nursing-spirit |
| 35, 40..43 | life wheel, artifact | nursing-spirit-artifact |
| 50 | CHILD_ASSIST_AWAKE | handbook |

- Guardians are household objects: `fight_userId` / `fightSlaveUserId` name the player who fields the guardian, and a spouse can field it ("O seu companheiro configurou o guardião, não pode fazer esta operação.", `V/equip/ChildBagCellClickMediator.as:106-117`); abandoning requires the spouse's answer (4749 below); divorce splits guardians ("Depois de divorciar, apenas pode levar dois Guardiões.").

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `V/ChildFrame.as` | "Guardião" (`child.ChildFrame.title`), help "Instruções do Guardião" | main frame: left list, tabs attributes, equipment, skills, emblem, handbook (`:55-63`, `:195-340`) | `CM.openChildFram` (`CM:725-739`): army toolbar button, keyboard, bag items SonType 226, `SortPawnFrame`, `KingbackOtherPage`; `CC` openType `main` | `CMOD.childList` sorted by growth level, first `firstChildId` |
| `V/ChildListView.as`, `V/ChildListItemView.as`, `V/ChildListItemCell.as` | | guardian list | frame | name, job, level, battle flags |
| `V/attribute/ChildFosterViewII.as` | "Valor do estado", "Pontos de crescimento: {0}" | attribute tab: battle state menu (main, assist, rest), sell, growth upgrade, rename | tab 1 | see `attributes.md` |
| `V/attribute/ChildRenameView.as` | "Não contém cartão de renomeação na mochila" | rename with a rename card | attribute tab | *(rename route not found in `ChildSender`; assumption: generic item use route of the inventory feature)* |
| `decompiled/core_module/scripts/yishi/view/frame/ChildSexFrame.as` | | legacy: choose sex when using item 208044 | bag item 208044 while `applyInfo.state == 0` | |
| `V/attribute/ChildSelectJobFrame.as`, `V/attribute/ChildSelectJobItem.as` | "Favor selecionar profissão" | legacy: choose job of a new guardian, sends op 1 with the job | `CC` openType `select_job` | |
| `V/handin/ChildHandInFrame.as`, `V/handin/ChildHandInItem.as` | "Desistir do Guardião" | abandon guardians | space NPC option 29 (`decompiled/m3/scripts/map/space/view/frame/DialogOptionItem.as:625-633`), `CC` `handin` | list with equipment check |
| `V/handin/ChildLookUpFrame.as`, `V/handin/ChildLookUpView.as` | "Nome do Guardião:", "Dono:", "Nível", "Pontos de crescimento:{0}" | details of a guardian in the hand in list | hand in item | |
| `V/handin/ChildDivideFrame.as` | "Distribuição de Guardiões do Divórcio" | choose guardians to keep on divorce | `CC` `divide` (marriage flow) | alert texts `child.handin.ChildDivideFrame.*` |
| `V/ChildNursingSpiritFrame.as` | | Espírito de Proteção frame (entry only, see `nursing-spirit.md`) | `CM.openChildNsFram` | |

## 3. Routes (client to server)

### A1. Summon a guardian with fragments (op 1, property1 = 0)
- UI: bag item SonType 277 or NPC option 27 -> `CM.checkForExchangeChild` (`CM:759-774`) -> `CS.pickChild` (`CS:227-253`).
- Client checks: hero level >= 70 ("dayGuide.DayGuideManager.command02"); bag count of `child_apply_item` id (2131140 "Fragmentos da Marca do Deus Escolhido") >= count (5) ("Material insuficiente, não pode convocar"); confirm "Deseja consumir {0} {1} para convocar 1 guardião?".
- Request: 8868, `op_type`=1, `property1`=0.
- Response: 4747 with the new guardian (`firstLoad` false -> army button shines, `CM:557-566`, `:703-706`); bag push 115. Job is random from `Random_Childs` = "1,2,3,4,5,6" for non first applications *(assumption: first application also random)*.

### A2. Apply with a chosen job (op 1, property1 = job), legacy
- UI: `V/attribute/ChildSelectJobFrame.as:98-102`. Request: `op_type`=1, `property1` = job type. Response: 4746 and/or 4747.

### A3. Choose sex (op 12), legacy pregnancy flow
- UI: `ChildSexFrame.__confirmHandler` (`decompiled/core_module/scripts/yishi/view/frame/ChildSexFrame.as:138-150`) after using item 208044; requires `applyInfo.state == 0` else "cell.mediator.playerbag.PlayerBagCellClickMediator.command10".
- Request: `op_type`=12, `property1` = sex index (0/1). `CS.choiceSex(sex, pos)` ignores the item position (`CS:341-348`).
- Response: 4746 `ChildrenApplyMsg` with the new state; later 4747 when the child is born (`create_child_time` 86400000 ms, `adult_child_time` 604800000 ms) *(assumption: legacy timers)*.

### A4. Rest (op 7 OP_REST)
- UI: rest entry of the battle menu (`V/attribute/ChildFosterViewII.as:507-511`).
- Request: `op_type`=7, `property1` = child id. Response: 4747 with `fight_userId` / `fightSlaveUserId` cleared.

### A5. Sell a guardian (op 24 SELL_CHILD)
- UI: sell button (`V/attribute/ChildFosterViewII.as:514-547`).
- Client checks: guardian not fielded (`fightUserId > 0 || fightSlaveUserId > 0` -> "Este guardião está em estado de combate, não pode ser vendido"); not the last guardian of its job ("O último guardião do mesmo tipo não pode ser vendido"); confirm "Deseja vender o guardião: {0}, 50% dos itens consumidos de adestração serão reembolsados via email.".
- Request: `op_type`=24, `property1` = child id.
- Response: 4747 with the guardian `state` = -1 (removed, `CM:551-554`); refund mail (mail feature).

### A6. Abandon guardians (op 2 OP_DESTORY, op 13 CONFIRM_DESTORY)
- UI: `V/handin/ChildHandInFrame.as:200-290`. Checks: guardian exists ("Este guardião não existe"), not fielded ("Não pode desistir do Guardião em batalha."), no equipment in bag 30 positions 0..7 ("O guardião escolhido está equipado, não pode abandonar."); confirm "Quer desistir do Guardião [{0}], depois de desistir não pode voltar".
- Request 1 (initiator): `op_type`=2, `property3` = comma separated child ids. Client shows "Aguardar resposta do adversário".
- Server -> partner: 4749 `ConfirmMsg` `op_type` 1, `property2` = ids; the partner gets an alert with the guardian names (`CM:207-246`).
- Request 2 (partner): `op_type`=13, `property5` = true (accept) or false (refuse) (`CM:316-324`, `CS:273-280`).
- Response: 4747 with `state` -1 for removed guardians to both players; `ChildEvent.HAND_IN` refresh. *(assumption: a single owner without spouse is answered immediately without the 4749 round trip)*

### A7. Divorce split
- The divorce flow (marriage feature, [marriage](../marriage/README.md)) opens `ChildDivideFrame`; `CM.divideCall` (`CM:276-314`) refuses when any guardian equipment in the general bag has gems ("Dentro a mochila do Guarda possui equipamentos com Ágata inserida...") and answers `MarrySender.confirmDivorce(true/false)`. Rule: each side keeps at most two guardians.

### A8. Look up another player's guardians (8875)
- UI: player info frame (`decompiled/m5/scripts/playerinfo/PlayerInfoFrameII.as:1567`) -> `PM.sendRequistChildData(userId)` (`PM:1755-1761`).
- Request: send 8875 (0x22ab) `C_QUERY_CHILDREN`, `ChildrenOpMsg.property1` (#3) = target user id.
- Response: 4758 (S4).

### A9. Change job (op 5 OP_JOB), set first (op 22)
`CS.selectJob` (`CS:350-358`, `property1` child id, `property2` job) and op 22 have no caller; keep handlers returning no-op *(assumption)*.

## 4. Server messages (server to client)

### S1. 4747 (0x128b) `U_C_CHILDREN`, `PlayerChildMsg`
Receiver `CM.__childrenInfoHandler` (`CM:531-709`). Sent at login (all guardians) and after any change (only changed guardians; `state` -1 removes).

| Field | Tag | Type | Rep | Meaning |
|---|---|---|---|---|
| `child` | #1 | ChildrenMsg | yes | guardians |
| `firstChildId` | #2 | INT32 | | guardian shown first in lists |
| `info` | #3 | ChildCollectInfoMsg | yes | per job type collection: `childType` #1, `soulWakes` #2 (awaken level), `growth` #3 (best level) (`handbook.md`) |
| `totalGrowth` | #4 | INT32 | | sum of best levels of all types (`ChildHandBookView.growthImage.tipdata`) |

`ChildrenMsg`:

| Field | Tag | Type | Meaning |
|---|---|---|---|
| `child_id` | #1 | INT32 | guardian id |
| `name` | #2 | STRING | name |
| `job` | #3 | INT32 | job type (`ChildTempInfos.JobType`) |
| `sex` | #4 | INT32 | sex |
| `userId_a` | #5 | INT32 | owner user id |
| `growth_grade` | #6 | INT32 | level 1..12 |
| `skill` | #7 | STRING | learned skills (`skills.md`) |
| `fight_userId` | #8 | INT32 | player fielding it as main guardian (0 = none) |
| `fight_skill` | #9 | STRING | carried battle skills |
| `state` | #10 | INT32 | -1 removed, else status |
| `birth_time` | #11 | STRING | creation time |
| `growth_gp` | #12 | INT32 | growth exp inside the level |
| `growth_count` | #13 | INT32 | growth items absorbed today *(assumption from "A absorção atingiu o limite por hoje")* |
| `fight_capacity` | #14 | INT32 | fight power |
| `skill_books` | #15 | STRING | skill book state |
| `emblemPos` | #16 | EmblemMsg | repeated, emblem slots (`emblem.md`) |
| `emblem` | #17 | INT32 | emblem level |
| `emblemGp` | #18 | INT32 | emblem exp |
| `fight_pet` | #19 | FightPetMsg | stats inherited from the fielded pet: `pet_phy_attack` #1, `pet_phy_defence` #2, `pet_mag_attack` #3, `pet_mag_defence` #4, `pet_hp` #5 INT64, `pet_fireResi..pet_lightResi` #6..#11 |
| `fightSlaveUserId` | #20 | INT32 | player fielding it as assist guardian |
| `join_info` | #21 | JoinInfoMsg | final stats: attack #1, defence #2, magicAttack #3, magicDefence #4, hp #5 INT64, forceHit #6, parry #7, reduceResi #8, fireResi..lightResi #9..#14, penetrate #15, stunAttr #16, reduceResiAgainst #17, resiPenetrate #18 |
| `childAssistAwakeLevel` | #22 | INT32 | assist awaken level (`handbook.md`) |

Side effects: hero fields `childrenName/Job/Sex/Grade` and `growthGrade2` from the main fielded guardian (`CM:680-702`).

### S2. 4746 (0x128a) `U_C_CHILDREN_APPLY`, `ChildrenApplyMsg`
Receiver `CM.__childrenApplyHandler` (`CM:326-340`): `userId_a` #1, `userId_b` #2 (couple), `state` #3 (0 = none; 1 = ready, army button shines), `is_apply` #4, `apply_time` #5 STRING. Send at login and on state change.

### S3. 4749 (0x128d) `U_C_CHILDREN_REMOVE`, `ConfirmMsg`
Receiver `CM.__childrenRemoveHandler` (`CM:207-268`): `op_type` #1, `property1` #2 INT32, `property2` #3 STRING.

| op_type | Meaning | Client reaction |
|---|---|---|
| 1 | partner asks to abandon guardians `property2` | names alert, answer op 13 |
| 3 | team invite to a PvP war / world boss campaign `property1` (campaign id) from `property2` (nick) | invite frame, room type 6 (owned by [team](../team/README.md)) |

### S4. 4758 (0x1296) `U_C_QUERY_CHILD`, `PlayerChildInfoMsg`
Receiver `PM.__receiveChildDataHandler` (`PM:1801-1840`): `child` (#1, repeated `ChildrenInfoMsg`): `child_id` #1, `name` #2, `job` #3, `sex` #4, `userId_a` #5, `userId_b` #6, `growth_grade` #7, `mood` #8, `growth_gp` #9, `growth_count` #10, `fight_capacity` #11, `state` #12, `equipmets` #13 (repeated `ChildEquipmentMsg`, see `equipment.md`), `emblem` #14. Dispatches `QUERY_CHILDDATA_RESULT` with the last guardian. Send the target's fielded guardian(s).

### S5. 4752 (0x1290) `U_C_UPDATE_CHILD_POWER`
Not a roster push: it is a battle transaction (`decompiled/core_module/scripts/battle/transaction/BattleChildChangeTransaction.as:19-64`, `AwakeMsg`) updating a guardian unit's awaken value in battle; see `formation.md` and `docs/battle/rules.md`.

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Unlock | hero level >= 70 for the frame and summon | `CM:725-774` |
| Summon cost | `child_apply_item` = "2131140,5" | `ConfigInfos.xml`, `CS:143-159` |
| Random jobs | `Random_Childs` = "1,2,3,4,5,6" | `ConfigInfos.xml` |
| Job types | 1 Cavaleiro Sagrado, 2 Caçador do Santuário, 3 Sacerdote do Combate, 4 Feiticeiro da Conden, 5 Guerreiro do Vento, 6 Combate Sangrento, 7 Leopardo das Neves, 8 Coelho Voador, 9 Anão de Gelo, 10 Diabo Charmoso; 101..105 Espírito de Proteção (Mensageiro da Alma, Anjo da Luz, Sacerdote do Oceano, Guarda do Mal, Gladiador da Águia, `MasterType` 1) | `ChildTempInfos.xml` |
| Sell | blocked when fielded or last of its job; 50% of training items refunded by mail | `V/attribute/ChildFosterViewII.as:514-547` |
| Abandon | needs spouse confirmation; no equipment, not fielded | hand in frame |
| Divorce | keep at most two guardians each | `child.handin.ChildDivideFrame.countLimit` |
| Sort | first `firstChildId`, then growth level desc | `CMOD:347-381` |

## 6. Templates

| File | Use |
|---|---|
| `ChildTempInfos.xml` (180 rows: 15 job types x 12 levels) | `JobType`, `Grades`, `JobName`, `MasterType`, stat percentages, resistances, `Icon`, `ResPath`, `SkillMasterType`, `CallNeedItems`, `CallTotalGrowth`, `ArtifactName/Path` |
| `ConfigInfos.xml` | `child_apply_item`, `Random_Childs`, `create_child_time`, `adult_child_time`, `child_feed_count` |
| `ItemTempInfos.xml` | 2131140 summon fragments, 208044 legacy item |

## 7. Persistent state

Deviation from the coordinator's tentative composite key: guardians are shared by a couple and fielded by either spouse, so the id is global.

```sql
CREATE SCHEMA IF NOT EXISTS guardians;

CREATE TABLE guardians.children (
  child_id            SERIAL   PRIMARY KEY,
  owner_player_id     BIGINT   NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  partner_player_id   BIGINT   REFERENCES player.players(player_id) ON DELETE SET NULL,
  name                TEXT     NOT NULL,
  job_type            SMALLINT NOT NULL,
  sex                 SMALLINT NOT NULL DEFAULT 0,
  growth_grade        SMALLINT NOT NULL DEFAULT 1 CHECK (growth_grade BETWEEN 1 AND 12),
  growth_gp           INTEGER  NOT NULL DEFAULT 0 CHECK (growth_gp >= 0),
  growth_count_today  INTEGER  NOT NULL DEFAULT 0,
  state               SMALLINT NOT NULL DEFAULT 0,
  fight_player_id     BIGINT   REFERENCES player.players(player_id) ON DELETE SET NULL,
  fight_slave_player_id BIGINT REFERENCES player.players(player_id) ON DELETE SET NULL,
  assist_awake_level  SMALLINT NOT NULL DEFAULT 0,
  fight_capacity      INTEGER  NOT NULL DEFAULT 0,
  born_at             TIMESTAMPTZ NOT NULL DEFAULT now(),
  removed_at          TIMESTAMPTZ
);
CREATE INDEX children_owner ON guardians.children (owner_player_id) WHERE removed_at IS NULL;
CREATE UNIQUE INDEX children_one_main ON guardians.children (fight_player_id) WHERE fight_player_id IS NOT NULL AND removed_at IS NULL;
CREATE UNIQUE INDEX children_one_assist ON guardians.children (fight_slave_player_id) WHERE fight_slave_player_id IS NOT NULL AND removed_at IS NULL;

CREATE TABLE guardians.player_state (
  player_id       BIGINT  PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
  first_child_id  INTEGER REFERENCES guardians.children(child_id) ON DELETE SET NULL,
  apply_state     SMALLINT NOT NULL DEFAULT 0,
  apply_partner_id BIGINT,
  apply_at        TIMESTAMPTZ
);

CREATE TABLE guardians.pending_abandons (
  request_id      BIGSERIAL PRIMARY KEY,
  requester_id    BIGINT   NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  responder_id    BIGINT   NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  child_ids       INTEGER[] NOT NULL,
  created_at      TIMESTAMPTZ NOT NULL DEFAULT now()
);
```

Other guardian tables reference `guardians.children(child_id)`. Collection rows are in `handbook.md`.

## 8. Backend implementation notes

| Opcode / op | Handler |
|---|---|
| 8868 op 1 | `guardians::roster::handle_apply` |
| 8868 op 2 | `guardians::roster::handle_abandon_request` |
| 8868 op 13 | `guardians::roster::handle_abandon_confirm` |
| 8868 op 5 | `guardians::roster::handle_change_job` (no-op) |
| 8868 op 7 | `guardians::roster::handle_rest` |
| 8868 op 12 | `guardians::roster::handle_choose_sex` |
| 8868 op 24 | `guardians::roster::handle_sell` |
| 8875 | `guardians::roster::handle_query_children` |

- Dispatcher: one Rust entry for 8868 that switches on `op_type` to the module handler named in the table of section 1.
- Op 1: level >= 70 -> consume 5 x 2131140 -> roll job -> insert guardian (level 1) -> update collection (`handbook.md`) -> push 115, 4747 (new guardian + `info` + `totalGrowth`).
- Op 24: checks as the client; transaction: set `removed_at`, move its equipment back to the bag or destroy *(assumption: client forbids selling only when fielded; equipment handling unspecified)*, mail 50% of recorded training costs *(assumption: keep a ledger of consumed items per guardian)*; push 4747 with `state` -1.
- Op 2/13: store a pending request, push 4749 op 1 to the partner if online (else auto refuse after timeout *(assumption)*); on accept remove and push 4747 to both.
- Hero integration: after any change of the fielded guardian, recompute hero power and push hero data (hero feature).

## 9. Open questions and assumptions

- *(assumption)* Rename route (rename card) is the generic item use path.
- *(assumption)* Legacy pregnancy flow (ops 1 with job, 12, 4746 states, `create_child_time`) may be unused in this version; keep minimal support.
- *(assumption)* `growth_count` semantic (daily absorption counter).
- Spouse sharing details depend on the marriage feature.

## 10. Implementation checklist

- [ ] 8868 dispatcher and ops 1, 2, 7, 12, 13, 24 (5 and 22 no-op).
- [ ] 8875 query and 4758 response.
- [ ] Pushes 4746, 4747 (login and deltas), 4749.
- [ ] Tables `guardians.children`, `guardians.player_state`, `guardians.pending_abandons`.
- [ ] Hero integration of the fielded guardian.
- [ ] Tests: summon at level 69 rejected; summon consumes 5 fragments; selling the last guardian of a job rejected; selling a fielded guardian rejected; abandon with spouse accept/refuse; 4747 `state` -1 removes the guardian client side.
