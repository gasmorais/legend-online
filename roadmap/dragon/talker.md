# Dragon Talker core: unlock, form switch, skill sets, potentials

Module `talker`. "Encantador de Dragões" is an alternate hero form unlocked after the job advance and the "Cavernas do Tempo" (Time Vortex) chain. The player toggles between the normal hero and the Dragon Talker form; in the Dragon Talker form the hero uses talismans instead of equipment (`talisman.md`), inherits a share of the hero's equipment through symbiosis (`symbiote.md`), rides a combat beast (`battle-beast.md`) and fights with a dedicated skill tree organized in up to three skill sets ("Método"). Four "Potencialidades" (potentials) give passive bonuses.

Path aliases:

| Alias | File |
|---|---|
| DTM | `decompiled/core_module/scripts/managers/DragonTalkerManager.as` |
| DMOD | `decompiled/core_module/scripts/mvc/module/dragontalker/DragonTalkerModel.as` |
| DPI | `decompiled/core_module/scripts/mvc/module/dragontalker/DragonTalkerProficiencyInfo.as` |
| DTC | `decompiled/core_module/scripts/mvc/controler/DragonTalkerController.as` |
| OP | `decompiled/core_module/scripts/com/road/yishi/proto/dragontalker/DragonTalkerOp.as` |
| V | `decompiled/m5/scripts/dragontalker/` |
| SPH | `decompiled/core_module/scripts/yishi/SwitchPageHelp.as` |

## 1. Overview

- One opcode for every action: send 9667 (0x25c3) `C_DRAGONTALKER_OP`, `DragonTalkerOpMsg.op` is the enum `DragonTalkerOp` (`OP`): 0 OPEN, 1 GET_TALISMAN, 2 SWITCH, 3 EQUIP_TALISMAN, 4 SET_NOT_NEW, 5 STRENGTHEN_TALISMAN, 6 REFRESH_TALISMAN, 7 STRENGTHEN_SYMBIONT, 8 STRENGTHEN_FIGHTMOUNT, 9 SELECT_FIGHT_MOUNT, 10 SKILL_ACTIVE, 11 SKILL_UPGRADE, 12 SKILL_CLEAR, 13 SKILL_SET_FASTKEY, 14 RANDOMSKILL_REPLACE, 15 RANDOMSKILL_DISCARD, 16 UPGRADE_QUALITY, 17 BATCH_STRENGTHEN, 18 CHANGE_POTENTIAL, 19 BUY_SKILL_COUNT, 20 SELL_TALISMAN.
- Ops owned by this file: 2, 10, 11, 12, 13, 18, 19. Ops 0 and 1 have no client caller (server side only: unlock and talisman grant).
- State pushes: 4845 (0x12ed) `U_C_DRAGONTALKER_INFO` (this file), 4844 (0x12ec) `U_C_DRAGONTALKER_TALISMAN` (`talisman.md`), 4846 (0x12ee) `U_C_DRAGONTALKER_OP` (result of ops 6, 14, 15, `talisman.md`).
- Not part of this feature: 4842 (0x12ea) `U_C_DRAGONTALKER_NODE` (`DragonTalkerNodeMsg`) is read by `TimeVortexManager` (`decompiled/core_module/scripts/managers/TimeVortexManager.as:98-112`) and tells which of the 5 Time Vortex dragon nodes are cleared (`TimeVortexModel.openDragon` = all five non zero, `decompiled/core_module/scripts/mvc/module/timevortex/TimeVortexModel.as:237-251`); owner [trials](../trials/README.md). Opcodes 8641..8643 `C_DRAGON_FEED/REQUEST/TRANSFER` (sent by `PlayerManager`) and 8761, 8768, 8769 `C_DRAGON_CREATED/PICK_BOX/ROLL` (sent by `decompiled/m3/scripts/map/campaign/view/ui/molong/MolongSocketOut.as`) belong to the "Covil do Dragão" campaign ([campaign](../campaign/README.md)); 9689 `C_HOLY_DRAGON_OP` (`PlayerManager`) is a separate holy dragon system, not the Dragon Talker.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `V/DragonTalkerFrame.as` | "Encantador de Dragões" (`DragonTalkerFrame.title.text`), help "Explicação do Encantador de Dragões" | 761x563 frame with tabs: main, symbiosis, talismans, skills, combat beast, potentials (`VersionSwitch.DRAGON_PROFICIENCY`) (`:101-136`, `:267-401`) | main toolbar `DragonTalkerBtn` (hotkey D), keyboard, `SPH.openDragonTalkerFrame` | hero attribute panel slides out on `ATTRIBUTE_CLICK` (`:188-260`) |
| `V/view/DragonTalkerMainView.as` (`DragonTalkerEquipView` + `DragonTalkerBagView`) | | equipped talismans, talisman bag, form switch button, VIP link | tab 0 | see `talisman.md` |
| `V/view/DragonTalkerSkillActiveView.as` | `DragonTalker.skillDesc1.text`, `DragonTalker.skillDesc2.text` | choose skill school 1 or 2 when `skillTabIndex == 0` | skills tab | active index |
| `V/view/DragonTalkerSkillMainViewII.as`, `V/item/DragonTalkerSkillItemViewII.as`, `V/item/DragonTalkerFastSkillItem.as`, `V/item/DragonTalkerTab.as`, `V/item/DragonTalkerLine.as` | "Método 1..3" | skill tree of the current set, add points, save, cancel, reset ("wash"), quick bar keys, set selector combo (buy sets 2 and 3) | skills tab | `skillPoint`, learned `skillScript`, `fastKey`, `skillCount` |
| `V/view/DragonTalkerProficiencyView.as`, `V/item/DragonTalkerProficiencyItem.as` | tip `DragonTalkerProficiencyView.tipText.text` | four potential slots | tab potentials | slot active by job level (`DPI:20-31`), current skill and stars |
| `V/DragonTalkerProficiencyFrame.as` | "Potencialidades" | pick one of 3 potentials of the slot and roll stars | slot click, `DTC` openType `PROFICIENCY_CHANGE_FRAME` | 3 descriptions (stars 1..3), material list (`:150-175`, `:230-292`) |
| `decompiled/core_module/scripts/ui/resourcebar/view/ResourceView.as:640-700` | | form switch button in the resource bar (frame 4 when Dragon Talker) | always | |

## 3. Routes (client to server)

`DragonTalkerOpMsg` fields (from `protocol/proto.json`, package `dragontalker`):

| Field | Tag | Type | Rep | Meaning |
|---|---|---|---|---|
| `op` | #1 | ENUM `DragonTalkerOp` | | action |
| `talismanId` | #2 | INT32 | | talisman instance id |
| `count` | #3 | INT32 | | quantity |
| `skillIndex` | #4 | INT32 | | skill set index (1..3) |
| `payType` | #5 | INT32 | | 1 diamonds, 2 bound diamonds |
| `skillTempIds` | #6 | INT32 | yes | skill template ids |
| `materialId` | #7 | INT32 | | material talisman id |
| `fastKey` | #8 | STRING | | quick bar layout |
| `symbiontIndex` | #9 | INT32 | | symbiosis slot 0..5 |
| `mountTempId` | #10 | INT32 | | combat beast template |
| `result` | #11 | INT32 | | response only |
| `newSkillIndex` | #12 | INT32 | | response only |
| `materialList` | #13 | MaterialListMsg | yes | batch strengthen materials |
| `potentialIndex` | #14 | INT32 | | potential choice 1..12 |
| `sellTaliInfos` | #15 | SellTalismanInfo | yes | talismans to sell |

### A1. Switch form (op 2 SWITCH)
- UI: job change button in the resource bar (`ResourceView.as:640-648`), in the Dragon Talker equip view (`V/view/DragonTalkerEquipView.as:588-591`) and in the hero equip view (`decompiled/m5/scripts/armyII/viewII/equip/EquipView.as:826`).
- Client checks (`DTM:249-271`): 3 s throttle ("armyII.ArmyControler.command03"); `model.isOpen` and `vocationGrades > 0` else "Ativado depois de Avançar Profissão e completar as Cavernas do Tempo."; not in battle ("armyII.ArmyControler.command05"); resource bar also blocks in scenes `THESE_PVP_SCENE` / `THESE_Double_PVP_SCENE` ("scene.switch.dragonTip").
- Request: `op`=2.
- Response: 4845 with `isNowDragonTalker` (#2) toggled; the server must also resend the hero attribute and fight power pushes (hero feature) because all derived stats change *(assumption)*.

### A2. Activate skill set (op 10 SKILL_ACTIVE)
- UI: `_activeBtn1/_activeBtn2` (`V/view/DragonTalkerSkillActiveView.as:70-89`), set combo (`V/view/DragonTalkerSkillMainViewII.as:540-559`, toast "A habilidade foi trocada para {0}").
- Client checks: already active -> "Este conjunto de habilidades já foi ativado."; combo index > `skillCount` opens the buy flow (A6).
- Request: `op`=10, `skillIndex` = set 1..3.
- Response: 4845 with `currentSkillIndex` (#1).

### A3. Save learned skills (op 11 SKILL_UPGRADE)
- UI: add point "+" on a skill (`V/item/DragonTalkerSkillItemViewII.as:188-207`) learns locally (`DMOD.clientLearn`, `DMOD:712-780`), "Salvar" sends (`V/view/DragonTalkerSkillMainViewII.as:503-514`), "Cancelar" restores (`DMOD.clearSkillPool`).
- Client checks: set points >= skill `Grades` else "Pontos de habilidade insuficientes" (each learned level costs its `Grades` value in points). Only one skill per line (`SonType / 100`) is kept: learning a higher grade replaces the lower one in `skillScript`.
- Request: `op`=11, `skillIndex` = set, `skillTempIds` = one template id per changed line (`opPoolDic` values).
- Response: 4845 with the updated `skillInfoList` entry (`skillPoint`, `skillScript`).

### A4. Reset skill points (op 12 SKILL_CLEAR)
- UI: "wash" button (`V/view/DragonTalkerSkillMainViewII.as:430-488`).
- Cost: config `ResetSkill_NeedPay` = 100 diamonds ("Consumir {0} diamantes para redefinir pontos de habilidade"); free when the King Contract buff 9 is active (`KingContractManager.checkHasBuffById(9)`, text "Essa ação voltará os pontos de habilidade ao estado inicial").
- Request: `op`=12, `skillIndex`, `payType` 1 (diamonds) or 2 (bound diamonds), omitted when free. Client checks the selected balance >= cost, else recharge alert.
- Response: 4845 with the set reset (`skillScript` = default, `skillPoint` = total), plus currency push.

### A5. Save quick bar (op 13 SKILL_SET_FASTKEY)
- UI: dragging skills into quick slots raises `SET_FAST_KEY` (`V/view/DragonTalkerSkillMainViewII.as:645-648`).
- Request: `op`=13, `skillIndex`, `fastKey` = comma list built by the getter (`:650+`).
- Response: 4845 (`fastKey` echoed).

### A6. Buy a skill set (op 19 BUY_SKILL_COUNT)
- UI: choose "Método 2/3" while not owned (`V/view/DragonTalkerSkillMainViewII.as:561-605`), confirm "Gaste {0} diamantes para ativar permanentemente o método {1} da habilidade de Encantador de Dragões".
- Cost: config `dragon_buy_skill_point` = "1000,1500" (set 2 = 1000, set 3 = 1500).
- Request: `op`=19, `skillIndex` = new set number, `payType`.
- Response: 4845 with `skillCount` (#13) incremented and a new `skillInfoList` entry.

### A7. Roll a potential (op 18 CHANGE_POTENTIAL)
- UI: "Substituir" in `V/DragonTalkerProficiencyFrame.as:199-214` with confirm "Depois de trocar poderá obter uma potencialidade de número de estrelas aleatório."
- Client checks: slot active (`DPI.isActive`); all materials of the slot owned (`:273-290`).
- Request: `op`=18, `potentialIndex` = choice index `3 * slot - 2 + column` (1..12) (`:241-254`).
- Response: 4845 with `potentialIdN` (#8..#11) = chosen skill template (SonType 436, `Grades` = stars 1..3); bag update 115.

## 4. Server messages (server to client)

### S1. 4845 (0x12ed) `U_C_DRAGONTALKER_INFO`, `DragonTalkerInfoMsg`
Receiver `DTM.__dragonTalkerInfoMsgHandler` (`DTM:73-169`); all fields are optional (`has*` checks), send only what changed after an op, everything at login. Ends with `DRAGON_TALKER_INFO_UPDATE`.

| Field | Tag | Type | Rep | Meaning | Client use |
|---|---|---|---|---|---|
| `currentSkillIndex` | #1 | INT32 | | active skill set | `skillActiveIndex`, `skillTabIndex` |
| `isNowDragonTalker` | #2 | BOOL | | current form | `isDragonTalker`, switch button frame |
| `skillInfoList` | #3 | SkillInfoMsg | yes | per set: `skillIndex` (#1), `skillPoint` (#2 free points), `skillScript` (#3 comma list of learned skill template ids), `fastKey` (#4) | replaces all sets when non empty (`:134-153`) |
| `currentFightMount` | #4 | INT32 | | selected beast `MountTempId` | `battle-beast.md` |
| `symbiontGpList` | #5 | SymbiontGp | yes | `index` (#1) 0..5, `totalGp` (#2) | `symbiote.md` |
| `fightMountGp` | #6 | INT32 | | beast total exp | `battle-beast.md` |
| `isOpen` | #7 | BOOL | | feature unlocked | gate of frame and switch |
| `potentialId1..4` | #8..#11 | INT32 | | potential skill per slot (0 = none) | `proficiencyList` (`:154-163`) |
| `fashions` | #12 | DragonFashionMsg | | `dragonWingAvata` #1, `dragonHatAvata` #2, `dragonArmAvata` #3, `dragonClothAvata` #4 | not read here (fashion feature) |
| `skillCount` | #13 | INT32 | | owned skill sets (1..3) | combo |

Also embedded in look up 4125 `DetailRspMsg.dragonTalkerInfo` (#20) for other players (`decompiled/core_module/scripts/yishi/datas/playerinfo/DragonTalkerPlayerInfo.as`).

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Unlock | `vocationGrades > 0` (job advance) and `isOpen`; `isOpen` becomes true once the five Time Vortex dragon nodes are cleared *(assumption: server sets `isOpen` from the same condition as `openDragon`)* | `SPH:2255-2268`, `TimeVortexModel.as:237-251` |
| Toolbar | `_dragonTalkerBtn.enable = vocationGrades > 0`; child button is the Titan (`titan.md`) | `decompiled/core_module/scripts/ui/maintoolbar/MainToolBar.as:1065-1067` |
| Form effect | in Dragon Talker form all systems except hero equipment and its upgrades give bonuses; talismans replace equipment (help text) | `DragonTalkerFrame.helperFrame.helpTxt.text` |
| Skill tree | skills with `MasterType` 4, line = `SonType / 100` in 131..145 (`DMOD:229-247`); prerequisites via `PreTemplateId`; Index 11 skills are always available (`DMOD:249-277`) | `SkillTempInfos.xml` |
| Skill cost | learning a skill costs its `Grades` points | `V/item/DragonTalkerSkillItemViewII.as:191-206` |
| Skill points | per set `skillPoint` from the server *(assumption: derived from job level like the hero skill tree)* | |
| Skill sets | default 1, buy 2nd for 1000 and 3rd for 1500 diamonds | config `dragon_buy_skill_point` |
| Reset | 100 diamonds (`ResetSkill_NeedPay`), free with King Contract buff 9 | |
| Potentials | 4 slots; slot `i` active when `isChangeJob` or `ceil((vocationGrades - 10) / 20) >= i` (`DPI:20-31`); slot `i` offers skill `Index` 3i-2..3i (SonType 436, 36 templates `Index` 1..12 x `Grades` 1..3, e.g. "Vitalidade Original" +2/4/6% attack); stars rolled randomly *(assumption: uniform 1..3)* | `DMOD:145-180` |
| Potential cost | `UpGradeTempInfos` Types 143 row `Grades` = slot: `TemplateName` = materials "212026,10|212020,3" (slot 1), "212026,10|212021,3" (2), "212026,10|212022,3|212023,3" (3), "212026,10|212024,3|212025,3" (4); `ActiveObject` 50 unused by the client | `V/DragonTalkerProficiencyFrame.as:150-175` |

## 6. Templates

| File | Use |
|---|---|
| `SkillTempInfos.xml` | MasterType 4 dragon skills (lines SonType 13100..14599), SonType 435 talisman special skills, SonType 436 potentials |
| `UpGradeTempInfos.xml` Types 140 / 141 / 142 / 143 | beast exp curve, talisman exp curve, symbiosis exp curve, potential materials |
| `ConfigInfos.xml` | `ResetSkill_NeedPay` 100, `dragon_buy_skill_point` "1000,1500", `DragonTalker_Gp_Item_Config` "208066,10,208067,10" |

## 7. Persistent state

```sql
CREATE SCHEMA IF NOT EXISTS dragon;

CREATE TABLE dragon.talkers (
  player_id            BIGINT   PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
  is_open              BOOLEAN  NOT NULL DEFAULT FALSE,
  is_dragon_form       BOOLEAN  NOT NULL DEFAULT FALSE,
  active_skill_set     SMALLINT NOT NULL DEFAULT 1 CHECK (active_skill_set BETWEEN 1 AND 3),
  skill_set_count      SMALLINT NOT NULL DEFAULT 1 CHECK (skill_set_count BETWEEN 1 AND 3),
  fight_mount_id       INTEGER  NOT NULL DEFAULT 1,
  fight_mount_gp       INTEGER  NOT NULL DEFAULT 0 CHECK (fight_mount_gp >= 0),
  potential_skill_1    INTEGER  NOT NULL DEFAULT 0,
  potential_skill_2    INTEGER  NOT NULL DEFAULT 0,
  potential_skill_3    INTEGER  NOT NULL DEFAULT 0,
  potential_skill_4    INTEGER  NOT NULL DEFAULT 0,
  last_switch_at       TIMESTAMPTZ
);

CREATE TABLE dragon.skill_sets (
  player_id     BIGINT   NOT NULL REFERENCES dragon.talkers(player_id) ON DELETE CASCADE,
  set_index     SMALLINT NOT NULL CHECK (set_index BETWEEN 1 AND 3),
  free_points   INTEGER  NOT NULL DEFAULT 0 CHECK (free_points >= 0),
  learned_skill_ids INTEGER[] NOT NULL DEFAULT '{}',
  fast_key      TEXT     NOT NULL DEFAULT '',
  PRIMARY KEY (player_id, set_index)
);
```

## 8. Backend implementation notes

| op | Handler |
|---|---|
| 2 | `dragon::talker::handle_switch_form` |
| 10 | `dragon::talker::handle_activate_skill_set` |
| 11 | `dragon::talker::handle_learn_skills` |
| 12 | `dragon::talker::handle_reset_skills` |
| 13 | `dragon::talker::handle_set_fast_key` |
| 18 | `dragon::talker::handle_change_potential` |
| 19 | `dragon::talker::handle_buy_skill_set` |
| 0, 1 | internal: `dragon::talker::unlock` (called when the 5th Time Vortex node is cleared), talisman grant in `talisman.md` |

- Validation order: `is_open` and job advanced -> not in battle (op 2) -> op checks -> cost -> transaction -> push 4845 (+ currency, bag, hero attributes when stats change).
- Op 11: verify each skill id is MasterType 4, its line prerequisites are learned, the total point cost fits `free_points`; replace the same line entry; store the array.
- Op 12: refund all points of the set (total = points granted by level), clear learned except Index 11 defaults.
- Op 18: consume materials of Types 143 row, roll stars (1..3), set `potential_skill_N` = template with `Index` = choice and `Grades` = stars.
- Battle: when `is_dragon_form`, the hero's battle skills are the learned skills of the active set and the fast key layout; potentials and talisman sets are passive effects (`docs/battle/server-engine.md`).

## 9. Open questions and assumptions

- *(assumption)* Skill point totals per set (server formula unknown; probably job level based).
- *(assumption)* Star roll distribution for potentials.
- *(assumption)* `isOpen` is set by the server when Time Vortex dragon nodes are complete.
- `fashions` (#12) is consumed by the fashion feature (`FashionModel.lookDragonTalkerFashion`), see [fashion](../fashion/README.md).

## 10. Implementation checklist

- [ ] 4845 full push at login, partial after each op.
- [ ] Op 2 switch with throttle and battle check.
- [ ] Ops 10, 11, 12, 13, 19 skill sets.
- [ ] Op 18 potentials with Types 143 costs.
- [ ] Tables `dragon.talkers`, `dragon.skill_sets`.
- [ ] Unlock hook from Time Vortex.
- [ ] `DetailRspMsg.dragonTalkerInfo` in look up.
- [ ] Tests: switch blocked in battle; learning beyond points rejected; buying set 3 before set 2 rejected; reset refunds points and charges 100 diamonds; potential slot 3 rejected while `vocationGrades <= 50` and not `isChangeJob` (`ceil((50 - 10) / 20) = 2`).
