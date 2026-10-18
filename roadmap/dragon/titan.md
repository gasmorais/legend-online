# Titan ("Titã"): collection, star training, skill order, spirit injection, energization

Module `titan`. After the "Profissão Cavaleiro" job change the player owns Titans (12 templates in `TitanTempInfos.xml`). One shared Titan state holds a star level trained with "Pedra da Alma de Titã", three skill order pages of up to 10 rounds where each round fires the skill of one owned Titan, a spirit injection track that activates new Titans and later runs repeatable cycles, and seven resistance energization tracks. In battle the Titan panel (`DragonTitanTeamView`) fires the skill of the current round.

Path aliases:

| Alias | File |
|---|---|
| DTM | `decompiled/core_module/scripts/managers/DragonTitanManager.as` |
| DMOD | `decompiled/core_module/scripts/mvc/module/dragonTitan/DragonTitanModel.as` |
| DII | `decompiled/core_module/scripts/mvc/module/dragonTitan/DragonTitanInjectInfo.as` |
| DCI | `decompiled/core_module/scripts/mvc/module/dragonTitan/DragonTitanChargeInfo.as` |
| DCC | `decompiled/core_module/scripts/mvc/module/dragonTitan/DragonTitanChargeCellInfo.as` |
| V | `decompiled/m14/scripts/dragontitan/` |
| OPS | `decompiled/core_module/scripts/com/road/yishi/proto/titan/TitanOpState.as` |

## 1. Overview

- One opcode: send 9581 (0x256d) `C_TITAN`, `TitanOpMsg` with `op` = `TitanOpState`: 0 UPDATE_AVATAR, 1 UPDATE_SKILLS, 2 UPGRADE, 3 DEVOUR, 4 INJECT, 5 REINJECT, 6 CHARGE, 7 USE_SKILL, 8 OPEN_SKILL_PAGE, 9 OPEN_SKILL_SLOT (`OPS`).
- One push: 324 (0x0144) `U_C_TITAN_DATA_MSG`, `TitanDataMsg`, always the full state.
- `TitanResMsg` (`op` ENUM #1, `result` BOOL #2) exists in the package but no client class reads it.
- Owned Titans = `devourTitan` list; `templateId` = displayed Titan (avatar/icon). The frame opens only when `isChangeJob` and `templateId > 0` (`decompiled/core_module/scripts/ui/maintoolbar/MainToolBar.as:2302-2312`, `decompiled/core_module/scripts/yishi/SwitchPageHelp.as:1674-1683`, "Titã não ativado").

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `V/DragonTitanFrame.as` | "Titã" | frame with pages develop, arrange, spirit (inject), energy (charge) (`:433-466`), displayed Titan icon and "Nv{0} {1}☆" | toolbar child of `DragonTalkerBtn` (hotkey I), `SwitchPageHelp.gotoTitanInject`, mail and sale shortcuts | `templateId`, `starLevel` |
| `V/DragonTitanSelectFrame.as`, `V/DragonTitanIconItemView.as` | | pick the displayed Titan among owned ones | icon click | "No momento já usou titã, não poderá fazer alteração" when re-picking the current one |
| `V/DragonTitanDevelopView.as`, `V/ProgressView.as` | "Atual：", "Próx. Nível：", "Pedra da Alma de Titã atual:", "Pedra da Alma de Titã a consumir:" | star training | develop page | exp bar `starExp / next.Data` (Types 116), next level "Anti-res +{0} ... anti-escuridão +{0}" with `starLevel * 100` (`:203-233`) |
| `V/DragonTitanArrangeView.as`, `V/DragonTitanSkillSlot.as`, `V/DragonTitanSkillItemView.as` | "Ordem da Hab. 1..3", desc `DragonTitanArrangeView.desc` | skill order pages: combo, 10 round slots, owned Titan skills to drag | arrange page | `skillId0..2`, `useSkillIndex`, owned 212013 count |
| `V/inject/DragonTitanInjectView.as`, `DragonTitanInjectAttPanel`, `DragonTitanInjectDesc`, `DragonTitanInjectLevelTip` | "Energização do Poder de Espírito", "Taxa de sucesso atual:", "Nº de ciclos do poder de espírito:" | activate Titans (inject) and run cycles (reinject) | spirit page | per Titan inject grade, rate, cost, added stats; explain1/explain2 |
| `V/charge/DragonTitanChargeView.as`, `V/charge/DragonTitanChargeCell.as` | "Nº de energizações:", "Nível de energização de anti insuficiente,não pode ultrapassar o Nv.20" | energize one of 7 resistances | energy page | per resistance grade, exp, value, limit "Limite Nível de energização:" |
| `V/DragonTitanInfoFrame.as`, `V/DragonTitanInfoView.as` | "Meu Titã" | read only look up of another player | player info, controller openType `TITAN_DATA_CHECK` | `DetailRspMsg.titanInfo` (#16) |
| `decompiled/m16/scripts/yishi/view/tips/DragonTitanTips.as`, `DragonTitanFightingTips.as`, `DragonTitanSkillTipsItem.as` | "Limite do Nível do Dragão", "Habilidades de Titã:", "1ª Rodada:" ... "10º Turno:" | tips | | |
| `decompiled/m10/scripts/battle/view/ui/DragonTitanTeamView.as` | | battle panel with the round order | battle | `docs/battle/rules.md` (P-SINGLE row) |

## 3. Routes (client to server)

`TitanOpMsg`: `op` (#1, ENUM `TitanOpState`), `param1` (#2, INT32), `param2` (#3, INT32), `param3` (#4, STRING).

### A1. Set displayed Titan (op 0 UPDATE_AVATAR)
- UI: `V/DragonTitanSelectFrame.as:102-116`. Check: not the current one.
- Request: `op`=0, `param1` = Titan template id. Response: 324 with `templateId`.

### A2. Star training (op 2 UPGRADE)
- UI: develop button (`V/DragonTitanDevelopView.as:249-290`), count input 1..9999 defaulting to owned stones.
- Client checks: next Types 116 row exists else "Elevou até o nível máx."; confirm "Deseja usar {0} Pedra da Alma de Titã ou {1} diamantes para adestrar?\n(Prioridade de uso de Pedra da Alma de Titã)" where diamonds = count x `titan_upgrade_point` (10).
- Request: `op`=2, `param1` = 2 when the alert's bound diamond option is chosen, else 1 (`sendDevelop(param1 ? 2 : 1, count)`), `param2` = count.
- Response: 324 with `starExp`, `starLevel`, resistances; bag and currency pushes.

### A3. Save a skill order (op 1 UPDATE_SKILLS)
- UI: dropping a Titan skill on a round slot (`V/DragonTitanArrangeView.as:248-283`): a Titan already placed elsewhere swaps; locked slots (-1) are ignored.
- Request: `op`=1, `param1` = page 0..2, `param3` = 10 comma separated values (Titan template id, 0 empty, -1 locked).
- Response: 324 with `skillId0..2`.

### A4. Use a skill order page (op 7 USE_SKILL)
- UI: state button when the page is opened but not in use (`V/DragonTitanArrangeView.as:158-176`); in use -> "A habilidade deste grupo já está em uso".
- Request: `op`=7, `param1` = page. Response: 324 with `useSkillIndex`.

### A5. Open a skill order page (op 8 OPEN_SKILL_PAGE)
- UI: state button when the page has no opened slot (`getIsSkillGroupActive` false, `DMOD:321-334`), confirm "Deseja consumir {0} diamantes para ativar a ordem de habilidades deste grupo" with `titan_open_page_need_point` = 200; client checks diamonds (`point`) >= cost.
- Request: `op`=8, `param1` = page. Response: 324 with the page array changed from all -1 to the default open slots *(assumption: 5 slots open, matching goddess formation text about Titan skills 6..9 unlocking later)*.

### A6. Open a round slot (op 9 OPEN_SKILL_SLOT)
- UI: locked slot click (`V/DragonTitanSkillSlot.as:85-121`): page must be opened ("Favor abrir primeiro a ordem de habilidades deste grupo"); confirm "Deseja consumir {0} para {1} ativar um slot de habilidades" with `titan_open_slot_need_item` = 212013 "Fragmento de Slot de Titã" x100; owned (bag + storehouse) < 100 -> "Materiais insuficientes, não é possível de abrir o slot de habilidades".
- Request: `op`=9, `param1` = page. Response: 324 with the first -1 of that page set to 0.

### A7. Inject (activate) a Titan (op 4 INJECT)
- UI: spirit button for a not yet owned Titan (`V/inject/DragonTitanInjectView.as:201-225`).
- Client check: bag has the displayed cost of 208059 "Pedra do Poder do Espírito" (Types 122 `Data` of the next grade) else "Itens insuficientes".
- Request: `op`=4, `param1` = Titan template id.
- Response: 324 with `injectData` (#28) entry for that Titan (`titan_id`, `grade`); at grade 10 the Titan joins `devourTitan` (owned) *(assumption based on `MAX_LEVEL` 10 and `updateTitanActiveState`)*. Success rate = Types 122 `ActiveObject` (100% at grade 1 down to 50% at grade 10); failure consumes the stones *(assumption)*.

### A8. Spirit cycle (op 5 REINJECT)
- UI: same button for an owned Titan when all Titans are owned ("Todas as habilidades de titã foram ativadas, abertura do ciclo do poder de espírito"); blocked when `injectCount > injectCircleCount` -> "Ciclos de poder de espírito básico cheios, não é possível efetuar operação" (`DII:173-176`).
- Request: `op`=5, `param1` = Titan template id.
- Response: 324 with `injectGrade` (#29), `injectCount` (#30), `chargeGrade` (#31). Types 123: 50 stones per attempt, 80% rate, grades 1..10; finishing a cycle grants `titan_reinject_reward` 208054 x30 and raises the energization limit *(assumption on limit increment)*.

### A9. Energize a resistance (op 6 CHARGE)
- UI: `V/charge/DragonTitanChargeView.as:134-147`.
- Client check: bag has the input count of 208060 "Fragmento de Energização".
- Request: `op`=6, `param1` = resistance type 16 reduceResi, 17 fire, 18 water, 19 elect, 20 wind, 21 dark, 22 light (`DCI:11-23`), `param2` = count.
- Response: 324 with the `*ResiGp` fields (#32..#38).

### A10. Devour (op 3 DEVOUR)
No client caller (`DTM.sendDevour`, `DTM:177-184`). Config `titan_devour_item` = "208054,10" (devouring a duplicate Titan gives 10 Pedra da Alma de Titã). Keep server side for Titan items obtained twice *(assumption)*.

## 4. Server messages (server to client)

### S1. 324 (0x0144) `U_C_TITAN_DATA_MSG`, `TitanDataMsg`
Receiver `DTM.__titanDataHandler` (`DTM:79-126`); then `updateTitanActiveState`, `updateViewInfo` and `DragonTitanEvent.TITAN_DATA`. Send at login (after job change) and after every op.

| Field | Tag | Type | Rep | Meaning |
|---|---|---|---|---|
| `userId` | #1 | INT32 | | owner |
| `templateId` | #2 | INT32 | | displayed Titan (0 = no Titan, frame locked) |
| `starExp` | #3 | INT32 | | exp inside the current star level |
| `starLevel` | #4 | INT32 | | steps*10 + stars (`getSteps = starLevel/10`, `getStars = starLevel%10`) |
| `devourTitan` | #5 | INT32 | yes | owned Titan template ids |
| `attack` .. `stunAttr` | #6..#23 | INT32 | | final Titan stats: attack #6, defence #7, magicAttack #8, magicDefence #9, live #10, forceHit #11, parry #12, strength #13, tenacity #14, reduceResi #15, fireResi #16, waterResi #17, electResi #18, windResi #19, darkResi #20, lightResi #21, penetrate #22, stunAttr #23 |
| `useSkillIndex` | #24 | INT32 | | page in use 0..2 |
| `skillId0`, `skillId1`, `skillId2` | #25, #26, #27 | INT32 | yes | 10 entries each: Titan id, 0 empty, -1 locked |
| `injectData` | #28 | TitanInjectMsg | yes | `titan_id` #1, `grade` #2 per Titan |
| `injectGrade` | #29 | INT32 | | cycle grade (owned Titans use it) |
| `injectCount` | #30 | INT32 | | cycles done |
| `chargeGrade` | #31 | INT32 | | extra energization limit (client adds `titan_charge_grade_base_Grade` 200, `DMOD:127-135`) |
| `reduceResiGp` .. `lightResiGp` | #32..#38 | INT32 | | energization exp per resistance |

Look up: 4125 `DetailRspMsg.titanInfo` (#16, `TitanDataMsg`) parsed in `decompiled/m5/scripts/playerinfo/PlayerInfoFrameII.as` (stats subset).

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Unlock | `isChangeJob`; frame needs `templateId > 0` | toolbar |
| Star curve | `UpGradeTempInfos` Types 116, grades 0..200 (`Data` 50 per level up to 10, then larger, 50000 at 200) | `DMOD:13`, `V/DragonTitanDevelopView.as:205` |
| Star cap | `starLevel + 1 < sum(QualiLimit of owned Titans)` (20 for Titan 1, 10 or 15 for others) | `DMOD:151-164`, `V/DragonTitanDevelopView.as:206` |
| Training | per unit: 1 stone 208054 or 10 diamonds (`titan_upgrade_point`), +10 exp (`titan_upgrade_base_exp`), crit `titan_upgrade_forcehit` "5,2|2,10" = x5 exp at 2%, x2 at 10% *(assumption on format)*; stones used first | config, alert text |
| Star bonus | +100 to all 7 resistances per star level (`titan_resi_enhance` 100) | `V/DragonTitanDevelopView.as:211` |
| Inject | Types 122 grade g: cost `Data` stones 208059 (30..100), rate `ActiveObject` % (100..50), `TemplateName` = % of the Titan template Attack, MagicAttack, Defence, MagicDefence, Live added (`DII:118-150`) | |
| Cycles | Types 123: 50 stones, 80%, 10 grades; max cycles = owned Titans x `titan_reinject_base_count` (5) (`DII:77`) | |
| Energize | Types 124 exp curve grades 0..3000; each grade adds `titan_charge_grade_base_property` (10) to the resistance (`DCC:36-74`); grade limit `chargeGrade + 200`; a resistance cannot exceed the lowest one by more than `titan_charge_grade_differ` (20) | `DCI:77-121` |
| Skill pages | 3 pages x 10 rounds; open page 200 diamonds; open slot 100 x 212013; each Titan skill once per page | config, `DragonTitanArrangeView.desc` |
| Battle | each round fires the Titan skill of the slot; skill 41101001 resets used flags (titanland blessing) | `docs/battle/rules.md` rows 153 and P-SINGLE |

## 6. Templates

| File | Use |
|---|---|
| `TitanTempInfos.xml` (12) | `TemplateId`, `TemplateName`, `AvatarPath`, base stats, resistances, `SkillIds` (40901001..40912001), `QualiLimit` |
| `UpGradeTempInfos.xml` Types 116, 122, 123, 124 | curves above |
| `ConfigInfos.xml` | `titan_upgrade_point`, `titan_upgrade_base_exp`, `titan_upgrade_forcehit`, `titan_upgrade_item`, `titan_resi_enhance`, `titan_devour_item`, `titan_reinject_reward`, `titan_charge_grade_differ`, `titan_reinject_base_count`, `titan_charge_grade_base_property`, `titan_charge_grade_base_Grade`, `titan_open_page_need_point`, `titan_open_slot_need_item` |
| `ItemTempInfos.xml` | 208054 Pedra da Alma de Titã, 208059 Pedra do Poder do Espírito, 208060 Fragmento de Energização, 212013 Fragmento de Slot de Titã |

## 7. Persistent state

```sql
CREATE TABLE dragon.titan_states (
  player_id        BIGINT   PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
  display_titan_id SMALLINT NOT NULL DEFAULT 0,
  star_level       SMALLINT NOT NULL DEFAULT 0 CHECK (star_level BETWEEN 0 AND 200),
  star_exp         INTEGER  NOT NULL DEFAULT 0 CHECK (star_exp >= 0),
  use_skill_page   SMALLINT NOT NULL DEFAULT 0 CHECK (use_skill_page BETWEEN 0 AND 2),
  skill_page_0     INTEGER[] NOT NULL DEFAULT '{-1,-1,-1,-1,-1,-1,-1,-1,-1,-1}',
  skill_page_1     INTEGER[] NOT NULL DEFAULT '{-1,-1,-1,-1,-1,-1,-1,-1,-1,-1}',
  skill_page_2     INTEGER[] NOT NULL DEFAULT '{-1,-1,-1,-1,-1,-1,-1,-1,-1,-1}',
  inject_grade     SMALLINT NOT NULL DEFAULT 0,
  inject_count     INTEGER  NOT NULL DEFAULT 0,
  charge_grade     INTEGER  NOT NULL DEFAULT 0
);

CREATE TABLE dragon.titans (
  player_id     BIGINT   NOT NULL REFERENCES dragon.titan_states(player_id) ON DELETE CASCADE,
  titan_id      SMALLINT NOT NULL CHECK (titan_id BETWEEN 1 AND 12),
  inject_grade  SMALLINT NOT NULL DEFAULT 0 CHECK (inject_grade BETWEEN 0 AND 10),
  is_owned      BOOLEAN  NOT NULL DEFAULT FALSE,
  owned_at      TIMESTAMPTZ,
  PRIMARY KEY (player_id, titan_id)
);

CREATE TABLE dragon.titan_resistances (
  player_id   BIGINT   NOT NULL REFERENCES dragon.titan_states(player_id) ON DELETE CASCADE,
  resi_type   SMALLINT NOT NULL CHECK (resi_type BETWEEN 16 AND 22),
  charge_gp   INTEGER  NOT NULL DEFAULT 0 CHECK (charge_gp >= 0),
  PRIMARY KEY (player_id, resi_type)
);
```

## 8. Backend implementation notes

| op | Handler |
|---|---|
| 0 | `dragon::titan::handle_set_display` |
| 1 | `dragon::titan::handle_save_skill_order` |
| 2 | `dragon::titan::handle_train` |
| 3 | `dragon::titan::handle_devour` |
| 4 | `dragon::titan::handle_inject` |
| 5 | `dragon::titan::handle_reinject` |
| 6 | `dragon::titan::handle_charge` |
| 7 | `dragon::titan::handle_use_skill_page` |
| 8 | `dragon::titan::handle_open_skill_page` |
| 9 | `dragon::titan::handle_open_skill_slot` |

- Validation: `isChangeJob` -> op specific -> costs -> transaction -> recompute final Titan stats (template base of owned Titans + inject % + star resist + charge) -> push 324 (full) -> currency/bag pushes -> hero fight power.
- Op 1: every non -1 value must be 0 or an owned Titan, no duplicates, locked positions unchanged.
- Op 2: consume stones first then diamonds (`param1` 2 = bound diamonds); roll crit per unit; stop at the star cap.
- Op 6: reject when the resulting grade exceeds `chargeGrade + 200` or the lowest resistance grade + 20.
- Initial grant: on job change give the first Titan *(assumption: template 1 "Proteção de Titã", QualiLimit 20)* and set `display_titan_id`, otherwise the frame never opens.
- Battle: include `titanInfo` round order of `use_skill_page` in battle creation for the hero (see `docs/battle/server-engine.md`).

## 9. Open questions and assumptions

- *(assumption)* How the first Titan is granted.
- *(assumption)* Inject failure consumes stones; grade 10 makes the Titan owned.
- *(assumption)* Default opened slots when a page is opened, and the link with goddess formation texts (Titan skills 6..9).
- *(assumption)* `titan_upgrade_forcehit` format.
- `TitanResMsg` unused: the server may skip it.

## 10. Implementation checklist

- [ ] Push 324 full state.
- [ ] Ops 0..9.
- [ ] Tables `dragon.titan_states`, `dragon.titans`, `dragon.titan_resistances`.
- [ ] Final stat computation and hero power hook.
- [ ] `DetailRspMsg.titanInfo` in look up.
- [ ] Battle round order.
- [ ] Tests: train blocked at star cap; open slot consumes 100 x 212013; charge blocked at +20 over lowest; inject grade 10 adds to `devourTitan`; cycles limited to owned x 5.
