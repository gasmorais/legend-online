# Married life

Feature `marriage`, module `married-life`. Everything a married couple grows: satisfaction ("Pontos de Perfeição" / "Pontos de Felicidade"), partner help, ring tempering and marriage skills, the marriage tree, the daily heart quiz ("Apaixonados") and the daily marriage tasks.

Conventions and the shared `MarriageOpMsg` layout as in [proposal-and-engagement.md](proposal-and-engagement.md). Request opcodes: C>S 8759 `C_marriage_REQUEST` (ops 11, 12, 18, 19), C>S 8773 0x2245 `C_MARRIAGE_TREE_REQUEST` (ops 1002 to 1006), C>S 8774 0x2246 `C_MARRIAGE_TASK_REQUEST` (ops 2001 to 2005), C>S 8802 0x2262 `C_MARRIAGE_HEART` (ops 3001 to 3005).

## 1. Overview

`MarriageDataMsg` (357) carries the couple's growth data: own and mate satisfaction (exp, level, help count), ring (exp, level, unlocked skills) and the marriage tree. Satisfaction grows by consuming "Coração de Rosas" (208034, levels below 9) or "Selo de Juramento" (208057, level 9 and above) or by the partner's paid help. The ring grows by tempering (diamonds or "Coração Eterno" 208036, advanced levels with crystals) and unlocks marriage skills, of which the player equips one. The marriage tree (shown on the farm) is watered with gold or diamonds, fostered (state points), refreshed and harvested; partners and friends can water it. The heart quiz is a daily 2 player quiz started from the NPC with the partner in a team. Marriage tasks are daily ring tasks given by the NPC (max 10 per day).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `marry.income.MarryTrainFrame` `decompiled/m9/scripts/marry/income/MarryTrainFrame.as` | "Casamento" | Container (satisfaction, ring, skills tabs) | `MARRY_TRAIN` / `RING_UPGRADE` from the ring view (`decompiled/core_module/scripts/marry/view/MarryRingView.as:184`) | `MarryModel.marriageData` |
| `MarrySatisfactoryRateView` `decompiled/m9/scripts/marry/income/MarrySatisfactoryRateView.as` | "Casamento {1} Nível: {0}", "{0} EXP:", "Nº de adestrações:", "Coração de Rosas" / "Selo do Juramento", "{1} possui: {0}", "Consumindo {0} obterá EXP de pontos de perfeição", note "Os pontos de perfeição (felicidade) serão definidos de acordo com o nível mais baixo..." | Train satisfaction with N items (`:209` region, quick buy for missing items), mate panel, mate search when single (`:311`) | train frame | own and mate happy info, level table type 35 (`getnowInfo` `:420`) |
| `MateRightView` `decompiled/m9/scripts/marry/income/MateRightView.as` | "Nº de auxílios restantes hoje: {0}", "Consumo de auxílio: {0}", "Deseja consumir {0} diamantes para elevar o grau de perfeição do seu parceiro ou parceira?" | Help the partner (`:136`) | satisfaction view | mate happy level, help count |
| `MarryRingUpgradeView` `decompiled/m9/scripts/marry/income/MarryRingUpgradeView.as` | "Consumir {0} diamantes ou {1} Coração Eterno para temperar {2} vezes...", "Deseja consumir {0} diamantes para temperar {1} vezes?\n (Coração Eterno prioritário)", advanced "Deseja consumir {0} cristais da vênus para efetuar {1} vez(es) temperamento avançado?" | Temper x1 or x50 (`upRingForNormal` `:500`, `upRingForSenior` `:440`, advanced `:421`, `:495`) | train frame | ring level table type 36 (`nowInfo` `:544`) |
| `MarrySkillItem` / `MarrySkillInfoItem` `decompiled/m9/scripts/marry/income/MarrySkillItem.as` | "Ainda não está liberado", "Clicando poderá alterar esta habilidade por uma habilidade de casamento", "Poderá ativar esta habilidade caso o anel de casamento atingir um certo nível." | Choose the active marriage skill (`:85`) | train frame | `ring_skill`, skill templates |
| `marry.income.MarryTreeFosterFrame` `decompiled/m9/scripts/marry/income/MarryTreeFosterFrame.as` | "Adestramento da árvore de casamento."; "Nível: {0}", "Ganhos:", "Ganhos do próximo nível:", "Ao obter pontos de estado máximo pode obter ganhos:", "Selecionar itens para recuperar pontos de estado:", "Consumo ouro: {0}", "Diamantes: {0}", "Nº restantes: {0}", "tempo de cultivo:", "Pontos de estado atingiu o limite superior", "Árvore de Casamento atingiu o nível máximo", "Deseja consumir {0} ouro para atualizar item duplo?", "Deseja consumir {0} diamantes para efetuar irrigação?" | Water (gold/diamond), foster, refresh items | `TREE_FOSTER` from the farm tree (`decompiled/m3/scripts/farm/view/marrytree/MarryTreeView.as:186`) | tree info, level table type 121 |
| `MarryTreeView` (farm) `decompiled/m3/scripts/farm/view/marrytree/MarryTreeView.as` | "openAfterMarry", "harvestLimit" tips | Tree on a farm: open foster (own), water (1003), harvest (1004) (`__clickHandler` `:176`) | farm scene | 4678 data |
| `marry.income.MarryHeartFrame` `decompiled/m9/scripts/marry/income/MarryHeartFrame.as` | "Apaixonados"; "Resultado:"; "Você", "Ele (a)"; "Perguntas encerrada"; help "Guia de ajuda Apaixonados"; close warning `marry.income.MarryHeartFrame.CloseTip` | Quiz with timer; answer (`:326`), timeout (`:253`), quit (`:363`) | `HEART` on 4691 | `HeartTempInfos.xml` question, options, sync rate |
| `marry.income.MarryTaskMapFrame` `decompiled/m9/scripts/marry/income/MarryTaskMapFrame.as` | treasure map texts | Use a marriage task map item (`:202`) | `TASK_MAP` from `TreasureMapManager` (`decompiled/core_module/scripts/managers/TreasureMapManager.as:129`) | item `randomSkill1` = map id |

## 3. Routes (client to server)

| # | UI control | Client sender | Client checks | Route | Request | Response |
|---|---|---|---|---|---|---|
| L1 | Train satisfaction | `MarrySatisfactoryRateView` `:218` then `MarrySender.riseSatisfactory` `decompiled/core_module/scripts/mvc/module/marry/MarrySender.as:224` | owns N items (else quick buy for the missing count) | C>S 8759 | `op_type` = 11, `property1` = item template (208034 below level 9, 208057 at 9 and above), `property2` = count | 357 |
| L2 | Help partner | `MateRightView` `:136` then `MarrySender.helpMateTrain` `:301` | help count left (`marriage_happy_help_count` 5 minus `happy_help`), diamonds `marriage_happy_help_point` 100 (recharge alert) | C>S 8759 | `op_type` = 18, `pay_type` = 0 when bound diamonds may be used, 1 otherwise | 357 to both |
| L3 | Temper ring | `MarryRingUpgradeView.upRingForNormal` `:500`, `upRingForSenior` `:440` then `MarrySender.upgradeRing` `:234` | x1: one 208036 or `mar_ring_points` (6) diamonds; x50: `50 * 6` diamonds counting 208036 as 6 each; daily confirmation alerts (local) | C>S 8759 | `op_type` = 12, `pay_type` = 0 (items and bound diamonds allowed) or 1 (unbound only), `property1` = 1 (x1) or 2 (x50) | 357 |
| L4 | Advanced temper (high ring levels) | `upRingForHeightNormal` `:493` sends (0, 1), `upRingForHeightSenior` `:421` sends (1, 2) | crystals ("cristais da vênus", item 208058 Assumption) | C>S 8759 | `op_type` = 12 with the same pairs | 357 |
| L5 | Choose marriage skill | `MarrySkillItem` `:85` then `MarrySender.skillUse` `:244` | skill unlocked by ring level | C>S 8759 | `op_type` = 19, `property3` = skill template name/id string | 357 (`ring_skill`) |
| T1 | Foster tree | `MarryTreeFosterFrame.__fosterBtnHandler` `:684` | state value < 800 ("Pontos de estado atingiu o limite superior") | C>S 8773 0x2245 `C_MARRIAGE_TREE_REQUEST` | `op_type` = 1002 | 4678, 357 |
| T2 | Water other/partner tree (farm) | `MarryTreeView.__clickHandler` states 1 and 2 `:187` | | C>S 8773 | `op_type` = 1003, `pay_type` = -1, `property1` = farm owner id | 4678 |
| T3 | Harvest | `MarryTreeView` state 3 `:190` | state 4: "harvestLimit" tip | C>S 8773 | `op_type` = 1004 | 4678, rewards |
| T4 | Refresh foster items | `MarryTreeFosterFrame.refreshCall` `:635` | gold >= `fresh_martree_item` 100000 | C>S 8773 | `op_type` = 1005 | 4678 |
| T5 | Water with gold / diamonds | `MarryTreeFosterFrame` `:548`, `:591` | gold: uses left (`marriage_tree_gold_max` 5 minus `tree_gold_water`), gold >= `marriage_tree_gold`; diamonds: uses left (`marriage_tree_point_max` 5 minus `tree_diamond_water`), diamonds >= `marriage_tree_water_point` 10 | C>S 8773 | `op_type` = 1006, `pay_type` = 0 gold, else diamond pay mode (1 or 2, bound choice) | 357 (`god_tree`) |
| H1 | Start heart quiz (NPC option 25) | `DialogOptionItem.heartCallback` `decompiled/m3/scripts/map/space/view/frame/DialogOptionItem.as:961` | free team ("Por favor venha responder às perguntas antes de formar equipa"), captain ("Somente o Líder pode fazer o convite das Perguntas"), confirmation | C>S 8802 0x2262 `C_MARRIAGE_HEART` | `op_type` = 3001 | 4690 to the partner |
| H2 | Partner accepts | `MarryManager.heartCallback` `decompiled/core_module/scripts/managers/MarryManager.as:134` after the 4690 popup | | C>S 8802 | `op_type` = 3002 | 4691 to both |
| H3 | Answer | `MarryHeartFrame` `:326` then `MarrySender.opMarryHeartAnswer` `MarrySender.as:24` | | C>S 8802 | `op_type` = 3003, `property1` = question order, `property2` = option index (0 based) | 4691 |
| H4 | Timer expired | `MarryHeartFrame` `:253` then `opMarryHeartTimerComplete` `:15` | | C>S 8802 | `op_type` = 3004, `property1` = question order | 4691 |
| H5 | Quit | `MarryHeartFrame` `:363` then `opMarryHeartOp(3005)` | confirmation `CloseTip` | C>S 8802 | `op_type` = 3005 | 4691 with no current question (Assumption) |
| K1 | Accept marriage task (NPC option 21) | `DialogOptionItem.as:538` then `MarrySender.opMarryTask(2001)` `MarrySender.as:52` | married; `canAccessTask`: tasks today < `marriage_task_count` 10 and no task in progress | C>S 8774 0x2246 `C_MARRIAGE_TASK_REQUEST` | `op_type` = 2001 | 4675, 4657 (`quest_count`) |
| K2 | Submit task | `TaskFrameII` `decompiled/m15/scripts/task/TaskFrameII.as:726`, `TaskTraceItem`, `CompleteTaskTip` | task completed | C>S 8774 | `op_type` = 2002 | 4675 (removed), rewards |
| K3 | Abandon task | `TaskFrameII` `:991` | confirmation | C>S 8774 | `op_type` = 2003 | 4675 |
| K4 | Use task map item | `MarryTaskMapFrame` `:202`, `TreasureMapManager` then `MarrySender.useTaskGoods` `:60` | on the right map | C>S 8774 | `op_type` = 2004, `property1` = bag position | 4675 |
| K5 | Talk task (NPC option 96) | `DialogOptionItem` case 96 | | C>S 8774 | `op_type` = 2005 | 4675 |

## 4. Server messages (server to client)

| Route | Message | Client receiver | When |
|---|---|---|---|
| S>C 357 0x0165 `U_C_MARRIAGE_DATA` | `marriage.MarriageDataMsg`: `user_id (#1, INT32)`, `type (#2, INT32)`, `marriage_state (#3, INT32)` (4 = divorced, drops mate data), `happy (#4, MarriageHappyMsg)`, `mate_happy (#5, MarriageHappyMsg)`, `ring (#6, MarriageRingMsg)`, `god_tree (#7, MarriageGodTreeMsg)`. `MarriageHappyMsg`: `happy_gp (#1, INT32)` exp, `happy_grade (#2, INT32)` level, `happy_help (#3, INT32)` helps used today. `MarriageRingMsg`: `ring_gp (#1, INT32)`, `ring_grade (#2, INT32)`, `ring_skill (#3, STRING)` skills (active and unlocked). `MarriageGodTreeMsg`: `tree_gp (#1, INT32)`, `tree_grade (#2, INT32)`, `tree_gold_water (#3, INT32)` gold waterings today, `tree_diamond_water (#4, INT32)`, `tree_state (#5, INT32)`, `tree_state_value (#6, INT32)` state points (max 800), `tree_earning_date (#7, STRING)`, `tree_mate_state (#8, INT32)` | `MarryManager.__marryPersonalDataHandler` `MarryManager.as:189` (`MarryEventType.MARRIAGE_DATA`) | login and after every growth change, to both partners |
| S>C 4678 0x1246 `U_C_MARRIAGE_TREE` | `farm.MarriageTreeMsg`: `userId_a (#1)`, `nickName_a (#2)`, `job_a (#3)`, `userId_b (#4)`, `nickName_b (#5)`, `job_b (#6)`, `stateValue (#7, INT32)`, `feedCount (#8, INT32)`, `start_time (#10, STRING)`, `end_time (#11, STRING)` foster window, `trainACount (#12)`, `trainBCount (#13)`, `trainAType (#14)`, `trainBType (#15)`, `isGetA (#16, BOOL)`, `isGetB (#17, BOOL)` harvested, `tree_state (#18, STRING)`, `feed_user (#19, INT32)` | `MarryManager.__marryTreeUpdate` `:333` (`TREE_UPDATE`) | farm visit and tree ops |
| S>C 4690 0x1252 `U_C_MARRIAGE_HEART_START` | no body read | `MarryManager.__marryHeartStartHandler` `:119` | to the partner after H1 | popup "Apaixonados" with `heartTipContent`; accept sends H2 |
| S>C 4691 0x1253 `U_C_MARRIAGE_HEART_QUESTION` | `marriage.MarriageHeartMsg`: `cur_question (#1, HeartMsg)`, `lastQuestions (#2, HeartMsg, repeated)`, `sync_rate (#3, INT32)`, `max_order (#4, INT32)`. `HeartMsg`: `order (#1, INT32)` 1 based, `templateId (#2, INT32)` question (`HeartTempInfos.xml`), `options (#3, INT32, repeated)` option order, `result (#4, INT32)`, `option_a (#5, INT32)` answer of A, `option_b (#6, INT32)` answer of B, `remain_time (#7, INT32)` seconds, `random (#8, INT32)` | `MarryManager.__marryHeartQuestionHandler` `:284` (opens `HEART`) | after H2, H3 (both answered), H4, H5 |
| S>C 4675 0x1243 `U_C_MARRIAGE_TASK_UPDATE` | `reward.RewardUpdatedRspMsg`: `reward (#1, RewardInfo, repeated)` (template id, accept and complete flags, progress), `states_length (#2)`, `states (#3, BYTES)` | `MarryManager.__marryTaskUpdate` `:360` (`MarryModel.hasAccessList`, templates from `RingTaskManager`) | login and task changes |

## 5. Rules and formulas

- Satisfaction levels: `UpGradeTempInfos.xml` `Types="35"` (30 levels; `Grades` level, `Data` exp threshold, `TemplateName` bonus id); the display level of the couple is the lower of both (`happyDesc`). Item switches at level 9 (`MarrySatisfactoryRateView.as:209`). Help: `marriage_happy_help_count` 5 per day, `marriage_happy_help_point` 100 unbound diamonds, `marriage_happy_help_addgp` 200 exp to the partner.
- Ring levels: `Types="36"` (46 levels, `TemplateName` skill id unlocked, `Data` exp); `marriage_ring_addgp` 10 exp per temper; `mar_ring_points` 6 diamonds per temper; tooltip mentions a chance of a special event ("Deusa do Amor", text truncated in the key).
- Tree levels: `Types="121"` (10 levels, `TemplateName` harvest rewards `208034,100|208036,1`, `Data` exp); gold water `marriage_tree_gold` 10000000 gold, `marriage_tree_gold_addgp` 5 exp, max `marriage_tree_gold_max` 5 per day; diamond water `marriage_tree_water_point` 10 diamonds (bound allowed), `marriage_tree_point_addgp` 50 exp, max `marriage_tree_point_max` 5; foster `marriage_tree_train_gold` 1000000 gold, cooldown `marriage_tree_train_cd` 12 h, `mar_tree_train_count` 10; refresh `fresh_martree_item` 100000 gold; state points max 800; farm watering by others `mar_feed_count` (client default 2, key missing in `ConfigInfos.xml`).
- Heart quiz: `mar_heart_count` per day (client default 1, key missing in config); questions from `HeartTempInfos.xml` (`Question`, `Option1..4`); matching answers raise `sync_rate`; rewards "Coração de Rosas" per correct answer (`synchronizationtext`).
- Tasks: `marriage_task_count` 10 per day; task templates are ring task rewards (`RingTaskManager.getRewardTempByTempId`); condition type 16 = talk to NPC (`MarryModel.getTalkTaskNPCNode` `decompiled/core_module/scripts/mvc/module/marry/MarryModel.as:512`).

## 6. Templates

| File | Record | Fields |
|---|---|---|
| `raw/xml/tempinfos/UpGradeTempInfos.xml` | `UpGradeTempInfo` Types 35, 36, 121 | `Grades`, `Data`, `TemplateName` |
| `raw/xml/tempinfos/HeartTempInfos.xml` | `HeartTempInfo` | `TemplateId`, `Question`, `Option1`..`Option4` |
| `raw/xml/tempinfos/ConfigInfos.xml` | marriage keys above | |
| skill templates (skills feature) | marriage skills | names and effects |
| reward/ring task templates (tasks feature) | marriage tasks | |

## 7. Persistent state

```sql
CREATE TABLE marriage.growth (
    player_id          integer     PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
    happy_exp          integer     NOT NULL DEFAULT 0 CHECK (happy_exp >= 0),
    happy_level        smallint    NOT NULL DEFAULT 0,
    happy_help_used    smallint    NOT NULL DEFAULT 0,      -- per day
    ring_exp           integer     NOT NULL DEFAULT 0 CHECK (ring_exp >= 0),
    ring_level         smallint    NOT NULL DEFAULT 0,
    active_skill       text        NOT NULL DEFAULT '',     -- ring_skill selection
    daily_reset_on     date        NOT NULL DEFAULT CURRENT_DATE
);

CREATE TABLE marriage.tree (
    marriage_id        integer     PRIMARY KEY REFERENCES marriage.marriage(marriage_id) ON DELETE CASCADE,
    tree_exp           integer     NOT NULL DEFAULT 0,
    tree_level         smallint    NOT NULL DEFAULT 0,
    state_value        smallint    NOT NULL DEFAULT 0 CHECK (state_value BETWEEN 0 AND 800),
    tree_state         smallint    NOT NULL DEFAULT 0,      -- 0 growing, 1/2 waterable, 3 harvestable, 4 harvest limit
    gold_water_count   smallint    NOT NULL DEFAULT 0,
    diamond_water_count smallint   NOT NULL DEFAULT 0,
    feed_count         smallint    NOT NULL DEFAULT 0,
    last_feed_by       integer     REFERENCES player.players(player_id),
    foster_started_at  timestamptz,
    foster_ends_at     timestamptz,
    train_a_count      smallint    NOT NULL DEFAULT 0,
    train_b_count      smallint    NOT NULL DEFAULT 0,
    train_a_type       smallint    NOT NULL DEFAULT 0,
    train_b_type       smallint    NOT NULL DEFAULT 0,
    harvested_a        boolean     NOT NULL DEFAULT false,
    harvested_b        boolean     NOT NULL DEFAULT false,
    earning_date       date,
    daily_reset_on     date        NOT NULL DEFAULT CURRENT_DATE
);

CREATE TABLE marriage.heart_quiz (
    marriage_id        integer     NOT NULL REFERENCES marriage.marriage(marriage_id) ON DELETE CASCADE,
    quiz_date          date        NOT NULL,
    question_order     smallint    NOT NULL,
    template_id        integer     NOT NULL,
    answer_a           smallint,
    answer_b           smallint,
    asked_at           timestamptz NOT NULL DEFAULT now(),
    PRIMARY KEY (marriage_id, quiz_date, question_order)
);
```

Marriage tasks are stored in the task feature tables (ring task progress) with a marriage flag; daily counts in `marriage.player_state` ([proposal-and-engagement.md](proposal-and-engagement.md)).

## 8. Backend implementation notes

| Opcode / op | Handler |
|---|---|
| 8759 op 11 | `marriage::married_life::handle_train_satisfaction` |
| 8759 op 18 | `marriage::married_life::handle_help_partner` |
| 8759 op 12 | `marriage::married_life::handle_temper_ring` |
| 8759 op 19 | `marriage::married_life::handle_select_skill` |
| 8773 ops 1002 to 1006 | `marriage::married_life::handle_tree_op` |
| 8802 ops 3001 to 3005 | `marriage::married_life::handle_heart_op` |
| 8774 ops 2001 to 2005 | `marriage::married_life::handle_task_op` |

- All growth ops: player is married (state 3); consume items/currency and add exp in one transaction; level up through the upgrade tables; push 357 to both partners (mate fields swapped).
- Ring temper x50: loop 50 tempers server side, consuming 208036 first when `pay_type = 0`; random special event chance (Open question).
- Tree: lazy daily reset; foster starts a 12 h timer (`foster_ends_at`); harvest grants the level rewards (mail if bag full).
- Heart quiz: H1 requires both partners online in a 2 member team; per question timer (`remain_time`, Assumption 20 s); when both answered or timed out, score and send the next question; rewards at the end; one quiz per day per couple.
- Marriage skills in battle are handled by the battle feature (C>S 10509 `B_USE_MARRSKILL`).

## 9. Open questions and assumptions

1. Exact semantics of the advanced temper (pay_type/property1 pairs at high ring levels) and the crystal item.
2. Tree state values and the farm interaction limits (`mar_feed_count` missing from config).
3. Heart quiz timer, number of questions per day (`max_order`) and rewards.
4. `MarriageDataMsg.type` meaning.

## 10. Implementation checklist

- [ ] Tables `marriage.growth`, `marriage.tree`, `marriage.heart_quiz`
- [ ] 357 at login and after changes, to both partners
- [ ] Satisfaction training (op 11) and partner help (op 18)
- [ ] Ring temper x1/x50 (op 12) and skill selection (op 19)
- [ ] Tree ops 1002 to 1006 and 4678
- [ ] Heart quiz 3001 to 3005, 4690, 4691
- [ ] Marriage tasks 2001 to 2005, 4675
- [ ] Daily resets
