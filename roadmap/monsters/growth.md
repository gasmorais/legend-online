# Growth: feeding (stage), evolution (stars) and skill training

Path aliases:

| Alias | File |
|---|---|
| MM | `decompiled/core_module/scripts/yishi/manager/MonsterManager.as` |
| MMOD | `decompiled/core_module/scripts/mvc/module/monster/MonsterModel.as` |
| TM | `decompiled/core_module/scripts/yishi/manager/TempleteManager.as` |
| TRAIN | `decompiled/m14/scripts/monster/view/MonsterTrainView.as` |
| EVO | `decompiled/m14/scripts/monster/MonsterEvolveFrame.as` |
| PRAC | `decompiled/m14/scripts/monster/MonsterSkillPracticeFrame.as` |
| V | `decompiled/m14/scripts/monster/` |

## 1. Overview

Three progressions besides level (level EXP comes from exploration, see [beasts.md](beasts.md)):

1. Stage ("Fase", 0..star): feeding food raises stage EXP; each stage gives "Todos os atributos +{0}%" (20, 50, 100, 150). Help item 3: "Os jogadores podem gastar comidas monstruosas para alimentar monstros, melhorando a alimentação de monstros. Quando alimentação resulta no grande sucesso, o valor de alimentação é dobrado."
2. Star ("Evolução"): at max level and full stage the beast consumes `star` other beasts of the same star to gain one star (new template row, higher `MaxLevel`, a new active skill).
3. Skills ("Treino"): each active or passive skill (10 grades) gains EXP by sacrificing beasts. Help item 4: "As habilidades dos monstros são divididas entre ativas e passivas. Habilidades ativas são liberadas através de aumento de estrelas. Habilidades passivas são liberadas normalmente. Os jogadores podem aumentar as habilidades dos monstros através de treinos de monstros."

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `TRAIN` | (tab 1) | Feeding: current and next stage, stage EXP bar with preview, "Grande chance de vitória" rate bar, gold cost, food bag (`SonType` 230 counts from 4575, up to 70 cells) and 6 feed slots; buttons feed and evolve; hosts the kitchen ([kitchen.md](kitchen.md)) | MonsterFrame tab 1 | `stageLevel`, `stateExp`, `MMOD.trainBagDic`, `MMOD.rateBagList` (`TRAIN:288-360`) |
| `EVO` | "Evolução" (`MonsterEvolveFrame.title.text`) | Choose `star` material beasts of the same star; shows next star avatar, new skill icon (or "Não"), gold cost (`EVO:228-270`) | evolve button (`TRAIN:275-285`) | `MMOD.getMonsterBagShowList`, `monsterMaterialList` |
| `V/view/MonsterSkillView.as` | (tab 2) | Two sub tabs: active (`UseWay` 1) and passive (`UseWay` 2) skills at their max grade template (`:92-128`, `MMOD:258-280`) | MonsterFrame tab 2 | learned grade and EXP per skill |
| `V/item/MonsterSkillLeranItem.as` | "Avanço do treino" | Row: icon, name, EXP bar or "O monstro é liberado com {0} estrelas" when not learned (`:92-140`) | skill view | `skills` string |
| `PRAC` | "Treino" (`MonsterSkillPracticeFrame.title.text`) | Choose material beasts, preview grade and description, gold cost (`PRAC:221-305`) | train button of a learned skill (`V/item/MonsterSkillLeranItem.as:79-85`) | |

## 3. Routes (client to server)

All: send 8652 (0x21cc) `C_MONSTER_CLIENT_OP`, `MonsterClientOpMsg`.

### R1. Feed (op 15, FEED)
- UI: feed button `_trainBtn` (`TRAIN:250-273`).
- Client checks, in order: `stageGrade >= star` -> "Fase máxima para as estrelas atuais atingida"; no food selected -> "Materiais necessários insuficentes, não é possível efetuar operação."; gold < sum of `Property3` of the selected foods -> "Ouro Insuficiente". Adding food when the stage is full is also blocked (`V/item/MonsterMaterialItemCell.as:181-189`). Max 6 food units (`MMOD:298-317`).
- Sender: `MM.sendMonsterTrain(monsterId, items)` (`MM:273-281`).
- Request: `opType` (#1) = 15, `monsterId` (#2, INT32), `items` (#6, INT32, repeated) food template ids, one per unit.
- Response: 4574 `opType` 15 with the beast (`stageLevel`, `stateExp`, `fightPower`); 4575 `opType` 4 with the full food list; gold push (currency).

### R2. Evolve (op 16, EVOLVE)
- UI: evolve button on the train tab opens `EVO` only if `MMOD.checkCanEvolve` passes (`TRAIN:275-285`); then `_evolveBtn` of `EVO` (`EVO:175-207`).
- Client checks (`MMOD:890-908`, `EVO:175-207`): `star >= max star of type` -> "Limite de estrelas atingido"; `stageLevel < star` -> "Fases insuficientes, não por evoluir"; `level < template MaxLevel` -> "Nível necessário não atingido"; no material -> "Não inseriu material de treino de Evolução de monstro"; materials < `star` or a material with another star -> "É necessário {0}monstros de {0} estrelas para Evolução"; locked material -> "O monstro atual foi bloqueado, primeiro desbloqueie" (`V/item/MonsterIconCell.as:180-264`); gold < sum of material `fightPower` -> "Ouro Insuficiente".
- Sender: `MM.sendMonsterEvolve(monsterId, items)` (`MM:294-302`).
- Request: `opType` = 16, `monsterId` = target, `items` = material beast ids (exactly `star` entries).
- Response: 4574 `opType` 16 containing the evolved beast (star + 1) and each material with `isExist` false; the frame closes on opType 16 (`EVO:209-216`). Gold push. If a material was in a contract also 4575 `opType` 8.

### R3. Train a skill (op 14, SKILL_UPGRADE)
- UI: `_practiceBtn` in `PRAC` (`PRAC:191-205`); the row button is enabled only for learned skills below max grade (`V/item/MonsterSkillLeranItem.as:106-108`).
- Client checks: no material -> "Não inseriu material de treino de habilidade de monstro"; gold < sum of material `fightPower` -> "Ouro Insuficiente"; locked materials cannot be selected. Max 6 materials (`MMOD:526-539`).
- Sender: `MM.sendMonsterSkillPractice(monsterId, skillId, items)` (`MM:283-292`).
- Request: `opType` = 14, `monsterId`, `skillId` (#3, INT32) = current skill template id of that `SonType` (for example 83010103), `items` = material beast ids.
- Response: 4574 `opType` 14 with the target (`skills` updated, `fightPower`) and materials `isExist` false; gold push.

## 4. Server messages (server to client)

| Opcode | Message | Fields | Receiver | When |
|---|---|---|---|---|
| 4574 (0x11de) `U_C_MONSTER_DATA_LIST` | `MonsterListMsg` | `opType` (#1) = 14, 15 or 16; `monsters` (#2, repeated `MonsterMsg`: see [beasts.md](beasts.md) S1) | `MM.__monsterListHandler` (`MM:64-131`); views refresh on `MONSTER_INFO_CHANGE` | After R1, R2, R3 |
| 4575 (0x11df) `U_C_MONSTER_USER_DATA` | `MonsterUserMsg` `opType` 4 | `items` (#4, ItemCountMsg, repeated) full material counts | `MM:173-191,216-219` | After R1 |

## 5. Rules and formulas

### Stage (feeding)
- Stage table `UpGradeTempInfos` `Types=148` (`MMOD:137`): row `Grades` g has `Data` = EXP to go from stage g to g+1 and `ActiveObject` = attribute bonus percent at stage g: g0 500 / 0, g1 2000 / 20, g2 8000 / 50, g3 18000 / 100, g4 0 / 150.
- Stage cap = current `star` (`TRAIN:250-256`, `MMOD:475-483`). Stage EXP carries over levels like `TM.getUpgradeTotalInfo` (`TM:2404-2433`): subtract `Data` while EXP >= `Data`.
- Food value per unit = `Property1` (230001: 20, 230002: 10, 230003: 5); gold per unit = `Property3` (1000000 for each food); big success chance shown = sum of `Property2` of the batch, capped at 100 percent (`MMOD:432-460,485-498`, `TRAIN:300-303`). Big success doubles the food value (help text). Assumption: one roll for the batch with chance `min(100, sum Property2)` (matches the UI); alternative is one roll per unit with its own `Property2`.
- EXP beyond the cap (stage = star) is discarded (assumption).

### Evolution
- Preconditions as in R2. Materials: exactly `star` beasts with the same `star`, not the target, not locked (server must also reject fighting, following, contracted or exploration beasts, assumption).
- Gold = sum of material `fightPower` (`MMOD:640-648`, used in `EVO:265`).
- Result: `star` + 1, template = (`type`, star + 1) (`EVO:221-227`); the new active skill `SkillSonTypes[newStar - 1]` is learned at grade 1 (`EVO:233-245`). Assumption: level, EXP, stage and stage EXP stay (the next stage cap becomes the new star). `MaxLevel` rises (40 -> 80 -> 120 -> 160).
- Max star: last row of the type (3 for types 1..19, 4 for 96..99) (`MMOD:947-960`).

### Skill training
- Skill table `UpGradeTempInfos` `Types=149` (`MMOD:138`): row `Grades` g, `Data` EXP to go to g+1: 500, 1650, 3500, ..., 32000 (g9), 40000 (g10). Max grade = highest `Grades` of the `SonType` in `SkillTempInfos.xml` (10) (`MMOD:189-198`, `V/item/MonsterSkillLeranItem.as:101-108`).
- EXP gained = sum over materials of `star^2 * 100` (`MMOD:630-638`); gold = sum of material `fightPower`.
- Skill template id = `SonType * 100 + grade` (for example 830101 grade 3 -> 83010103), `skillTemplateId` and EXP stored in `MonsterMsg.skills` (`MI:84-103`).
- Active skills unlock by star: skill `SkillSonTypes[k]` belongs to star k+1 (`MMOD:222-244`); passive skills 830001 "Transmissão de Resistência" and 830002 "Transmissão de Anti-resistência" exist from star 1.

## 6. Templates

| File | Use |
|---|---|
| `raw/xml/tempinfos/UpGradeTempInfos.xml` | `Types` 148 (stage), 149 (skill) |
| `raw/xml/tempinfos/ItemTempInfos.xml` | foods `SonType` 230: `Property1` food, `Property2` big success percent, `Property3` gold |
| `raw/xml/tempinfos/MonsterTemplates.xml` | `MaxLevel`, `SkillSonTypes`, `PassiveSkillSonTypes`, max star per type |
| `raw/xml/tempinfos/SkillTempInfos.xml` | beast skills `SonType` 8300xx..8399xx, `Grades` 1..10, `UseWay` 1 active / 2 passive, `Description` |

## 7. Persistent state

No new table: updates `monsters.monsters` (`star`, `stage_level`, `stage_exp`, `fight_power`), `monsters.monster_skills` (see [beasts.md](beasts.md)) and `monsters.material_items` (see [summon.md](summon.md)). Deleted material beasts are hard deleted from `monsters.monsters` (cascade on skills, equipped accessory must be returned to bag 36 first, see [accessories.md](accessories.md)).

Optional audit table:

```sql
CREATE TABLE monsters.growth_log (
  log_id       BIGSERIAL   PRIMARY KEY,
  player_id    BIGINT      NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  monster_id   BIGINT      NOT NULL,
  action       SMALLINT    NOT NULL CHECK (action IN (14, 15, 16)),
  consumed     INTEGER[]   NOT NULL,
  gold_spent   BIGINT      NOT NULL DEFAULT 0,
  created_at   TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX growth_log_player_idx ON monsters.growth_log (player_id, created_at);
```

## 8. Backend implementation notes

- `monsters::growth::handle_feed` (op 15): own beast -> stage < star -> 1..6 items, all `SonType` 230, counts available -> gold >= sum `Property3` -> transaction: debit gold, decrement foods, roll big success, add stage EXP, level up stages up to `star`, recompute fight power -> push 4574 (15), 4575 (4), gold.
- `monsters::growth::handle_evolve` (op 16): own beast -> star < max -> stage >= star -> level >= `MaxLevel` -> `items` has exactly `star` distinct own beasts with the same star, none locked/fighting/following/contracted/in exploration -> gold >= sum fight power -> transaction: unequip material accessories to bag 36, delete materials, star + 1, add new active skill grade 1, recompute fight power -> push 4574 (16) with deletions, gold, and 4575 (8) if contracts changed.
- `monsters::growth::handle_skill_train` (op 14): own beast -> `skillId` belongs to the beast and is below max grade -> 1..6 material beasts as above -> gold -> transaction: delete materials, add EXP, raise grade through table 149 (template id changes), recompute fight power -> push 4574 (14).
- Recompute lord fighting capacity when the fighting beast changes (hero feature).

## 9. Open questions and assumptions

- Big success roll granularity (batch vs per unit) and multiplier (help says doubled).
- Whether overflow stage EXP is kept.
- Whether evolution keeps level and stage (assumed yes).
- Server side exclusion of fighting, following, contracted and exploration beasts as materials (client only blocks locked ones).
- Food gold cost of 1000000 per unit is taken from `Property3`; verify that the client gold check matches the server economy.

## 10. Implementation checklist

- [ ] Screen: train tab with feed preview (stage table 148)
- [ ] Screen: evolve frame with material rules
- [ ] Screen: skill view active/passive and practice frame
- [ ] Route op 15 feed -> 4574 (15) + 4575 (4)
- [ ] Route op 16 evolve -> 4574 (16) with material deletions
- [ ] Route op 14 skill training -> 4574 (14)
- [ ] Rule: stage cap = star, bonuses 0/20/50/100/150 percent
- [ ] Rule: evolution preconditions and gold = sum fight power
- [ ] Rule: skill EXP = sum star^2 * 100, table 149, max grade 10
- [ ] Table `monsters.growth_log` (optional)
- [ ] Tests: evolve rejects wrong star materials, feed blocked at full stage, skill grade carry over
