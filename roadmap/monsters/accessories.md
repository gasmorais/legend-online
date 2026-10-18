# Accessories: equip, strengthen, breakthrough, temperament and characteristics

Path aliases:

| Alias | File |
|---|---|
| MM | `decompiled/core_module/scripts/yishi/manager/MonsterManager.as` |
| MMOD | `decompiled/core_module/scripts/mvc/module/monster/MonsterModel.as` |
| GM | `decompiled/core_module/scripts/yishi/manager/GoodsManager.as` |
| SSM | `decompiled/core_module/scripts/yishi/service/managers/SocketSendManager.as` |
| ACC | `decompiled/m14/scripts/monster/view/MonsterAccessoriesView.as` |
| AUTO | `decompiled/m14/scripts/monster/MonsterAutoHammerFrame.as` |
| V | `decompiled/m14/scripts/monster/` |

## 1. Overview

Each beast wears one accessory: "Sino de monstro" (bell), "Luva de monstro" (glove) or "Sachê de monstro" (sachet), chosen by beast type. Accessories add a resistance attribute, are strengthened with "Gema do dragão" up to their tier cap (10, 20, 30, 40, 50), then broken through into the next tier with polishing materials. Every 10 strengthen levels unlock a characteristic slot (5 slots) that holds a random special skill ("Característica", levels 1..5). "Temperamento" re-rolls one slot using materials, manually or automatically (VIP 4). Only the strongest characteristic type of an accessory works; contracts ([contracts.md](contracts.md)) pass it to the lord. Help items 5 and 6: "Cada monstro pode usar um acessório. Pode-se gastar itens de fortalecimento para aumentar os atributos dos acessórios. Ao atingir o nível máximo, o acessório pode proceder para a superação." and "Ao atingir certos níveis através do fortalecimento de acessórios, recebe-se uma habilidade especial aleatória. As habilidades especiais de acessórios podem mudar através de refinamento. Entre as habilidades especiais, aquelas forem do mesmo tipo terão seus parâmetros e efeitos sobrepostos. Apenas a habilidade com o maior nível após a sobreposição terá efeito sobre o acessório de monstro individual."

Accessories are real items (inventory feature). Bag types used:

| bagType | Meaning | Citation |
|---:|---|---|
| 36 | Monster bag: unequipped accessories (`SonType` 232) and accessory materials (233, 234) | `GM:1407-1418`, `GM:505-516` (`getBagCountByTempId(36, ...)`) |
| 37 | Equipped accessory, `objectId` = monster id | `GM:1393-1405` |
| 0 | Hidden work bag shared with the smith: pos 0 = accessory being worked, pos 1..5 = temperament materials | `GM:1155-1158`, `ACC:261-275` |
| 1 | Player bag (end bag sent when returning items from the work bag) | `V/cell/MonsterAccessoriesEquipCell.as:102,114` |

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `V/view/MonsterPropView.as` + `V/view/MonsterPropBagView.as` | (tab 0) | Equip/unequip: accessory bag (bag 36 accessories) and the beast cell (bag 37) | MonsterFrame tab 0 | `GM.getMonsterBagList`, `GM.getMonsterBagGoodsInfo(monsterId)` |
| `ACC` | (tab 3) | Two panels: strengthen (level "Nv. {0}", attribute with "+x" preview, bless bar, Gema count "Estrelas atuais: {0}", amount input, strengthen or breakthrough with material list) and temperament (5 characteristic rows with unlock text "(Ativado ao se fortalecer ao nível {0})", slot selector, "Ao temperar recebe uma característica nv. 1-N aleatória", success percent, 5 material cells, temper and auto temper buttons, help "Detalhes das características") | MonsterFrame tab 3 | hidden bag 0 contents, `randomSkill1..5`, `strengthenGrade`, `strBlessValue` |
| `V/view/MonsterAccessoriesBagView.as` | | Bag with two filters: accessories (bags 36 and 37, `GM.getMonsterAccessoriesBagList`) and materials (`GM.getMonsterPropBagList`); sell button (`:77-80,236-246`) | tab 3 | |
| `AUTO` | "Temperamento automático" | Count input (1..9999) and target combo "Característica nv. N ou acima" (N = 1..5), start/stop; text "Quando o alvo do temperamento for alcançado ou as oportunidades e materiais forem insuficientes o temperamento é interrompido" | auto button (`ACC:342-371`) | |
| `V/MonsterAccessoriesHelpFrame.as` | "Detalhes das características" | Static help `MonsterAccessoriesView.helpContent.text` | help button (`ACC:336-340`) | |

## 3. Routes (client to server)

### R1. Equip an accessory on the selected beast
- UI: double click or drag from the accessory bag onto the beast cell (`V/cell/MonsterPropBagCell.as:107-160`).
- Client checks: beast `type` in accessory `Job` list else "Só pode vestir {0}" with the kind name (`MonsterAccessoriesTips.job1..3`); beast `star >= NeedGrades` else "Este monstro tem menos de {0} estrelas, não podendo vestir este acessório".
- Sender: `PlayerManager.moveBagToBag(bagType, objectId, pos, 37, 0, 0, 1, monsterId)` -> `SSM.sendMoveBagToBag` (`SSM:139-155`).
- Route: send 5005 (0x138d) `U_C_BAG_MOVE`, `ItemReqMsg`: `begin_bag_type` (#1, INT32) 36, `begin_obj_id` (#2, INT32) 0, `begin_pos` (#3, INT32) source pos, `end_bag_type` (#4, INT32) 37, `end_obj_id` (#5, INT32) 0, `end_pos` (#6, INT32) 0, `count` (#7, INT32) 1, `object_id` (#8, INT32) monster id.
- Server: if the beast already wears an accessory, swap it back to bag 36.
- Response: inventory pushes 115 (0x0073) `U_C_BAG_MOVE_UPDATE` (and 54 `U_C_BAG_MOVE` per inventory rules) with the moved item(s); the views listen to `GoodsManager` `UPDATE_BAG` / `DELETE_BAG` (`V/view/MonsterPropView.as:307-336`). See [../inventory/README.md](../inventory/README.md).

### R2. Unequip
- UI: double click or drag the beast cell onto the bag (`V/cell/MonsterBagCell.as:107-128`).
- Route: 5005 with `begin_bag_type` 37, `begin_pos` = item pos, `end_bag_type` 36, `end_pos` 0, `count` 1, `object_id` = monster id (the item `objectId`).
- Response: 115.

### R3. Put items into the work bag (bag 0)
- Accessory to pos 0: drag/double click an accessory (`SonType` 232, from bag 36 or 37) (`V/mediator/MonsterAccessoriesBagCellDropMediator.as:104-114`, `V/mediator/MonsterAccessoriesBagCellClickMediator.as:76-86`); other types -> "Tipo de acessório incorrespondente".
- Material to pos 1..5: only in the temperament panel (`ClickMediator:76-78`); "Gema do dragão" (233) is refused for temperament ("Tipo de acessório incorrespondente"); accessories from bag 37 refused ("Acessórios equipados não podem ser usados para temperar", `DropMediator:118-131`); first empty pos from `MMOD.getEmptyPos` (`MMOD:675-692`) else "Espaço cheio".
- Route: 5005 with `end_bag_type` 0, `end_pos` 0..5, `count` 1 (drag may send the dragged count).
- Return to bag: `moveBagToBag(bagType, objectId, pos, 1, 0, 0, 1)` sends `end_bag_type` 1 (`V/cell/MonsterAccessoriesEquipCell.as:95-115`, `V/cell/MonsterAccessoriesItemCell.as:95-116`, `ACC:933-952`); switching panels returns the materials (`ACC:454-462`). Server must route monster items back to bag 36 (or 37 when the accessory came from a beast, assumption).

### R4. Strengthen
- UI: strengthen button `_intensifyBtn`, amount `_numTxt` (`ACC:530-541`); enabled when Gema count >= 1 and level < `StrengthenMax` (`ACC:678-730`).
- Client checks: an accessory in work pos 0; Gema "Gema do dragão" 2330001 count in bag 36 > 0 (`ACC:923-926`).
- Sender: `MM.sendMonsterIntensify(count)` (`MM:304-311`).
- Route: send 5150 (0x141e) `U_C_ITEM_STRENGTHEN`, `StoreReqMsg` (package store): `opType` (#13, INT32) = 2 (monster accessory), `count` (#11, INT32) = Gems to use. Other fields unused.
- Response: 86 (0x0056) `U_C_ITEM_STRENGTHEN` `StoreRspMsg` (S1); 115 for consumed Gems and the updated accessory.

### R5. Breakthrough
- UI: breakthrough button `_breakthroughBtn`, visible when `strengthenGrade >= StrengthenMax`, enabled when every required material count in bag 36 is met (`ACC:543-550,795-847`).
- Sender: `MM.sendMonsterBreakthrough()` (`MM:313-317`).
- Route: send 5441 (0x1541) `C_MONSTER_ACCESSORY_BREACH`, empty body.
- Response: 115 with the accessory replaced by template `Property2` (next tier) and consumed materials (assumption: no dedicated reply).

### R6. Temper (manual)
- UI: temper `_hammerButton` (`ACC:381-389`), enabled when success percent > 0 (`ACC:775-793`).
- Client checks (`ACC:408-428`): accessory in pos 0; a slot selected (only slots that hold a characteristic can be selected, `ACC:732-773`); percent > 0 else "Chance de sucesso 0, não é possível temperar"; at least one material.
- Sender: `MM.sendMonsterHammer(slot, tempIds)` with defaults `hammerCount` 1, `aimSkillGrade` 1, `isAuto` false (`MM:319-329`).
- Route: send 5440 (0x1540) `C_MONSTER_ACCESSORY_HAMMER`, `MonsterAccessoryHammerMsg` (package campaign): `skillIndex` (#1, INT32) slot 1..5; `hammerCount` (#2, INT32) 1; `aimSkillGrade` (#3, INT32) 1; `isAuto` (#5, BOOL) false; `materialTempIdList` (#7, INT32, repeated) template ids in work pos 1..5 (`ACC:430-446`).
- Response: 186 (S2) and 115 (materials, accessory `randomSkillN`).

### R7. Temper (auto, VIP 4)
- UI: auto button (`ACC:342-371`) -> `AUTO`; start (`AUTO:191-227`).
- Client checks: active VIP with `VipGrade >= 4` else confirm "VIP4 pode desfrutar de temperamento automático, deseja habilitar vip?" (opens VIP); no accessory (`SonType` 232) among the materials else "Ao temperar gastando acessórios não é possível fazê-lo automaticamente" (`ACC:391-406`); materials present.
- Loop: `AUTO.hammer` sends 5440 with `hammerCount` = remaining count (first call = input, then minus 1 per call), `aimSkillGrade` = target 1..5, `isAuto` true (`AUTO:236-252`). On each 186 with `isAuto` true it shows "Temperamento bem-sucedido" / "Falha no temperamento" and, when `autoStopResult` = 0, sends the next request after 1 s; otherwise shows `MonsterAutoHammerFrame.stopText{autoStopResult}` and stops (`AUTO:139-174`).

### R8. Sell an accessory or material
- UI: sell cursor in the accessory bag (`V/MonsterAccessoriesSellHelp.as:66-138`): `SellGold * count == 0` -> "Item não pode ser vendido"; `objectId != 0` (equipped) -> "O item atual foi bloqueado, favor desbloquear"; otherwise opens the shared `army.ItemSellView` (`V/view/MonsterAccessoriesBagView.as:147-158`). The sell route belongs to [../inventory/README.md](../inventory/README.md).

## 4. Server messages (server to client)

### S1. 86 (0x0056) `U_C_ITEM_STRENGTHEN`
- `StoreRspMsg` (package store): `compose_result` (#1, BOOL) unused; `compose_templateId` (#2, INT32) unused; `streng_result` (#3, BOOL) true when processed; `strengthenGrade` (#4, INT32) new level; `pos` (#5, INT32) work bag pos (0); `objectId` (#6, INT32); `bagType` (#7, INT32) 0; `strBlessValue` (#8, INT32) bless toward the next level; `gp` (#9, INT32) unused.
- Receiver: `ACC.__intensifyResult` (`ACC:472-494`): updates the item in work pos `pos`, refreshes, plays the strengthen animation. Nothing happens when `streng_result` is false.

### S2. 186 (0x00ba) `U_C_MONSTER_ACCESSORY_HAMMER`
- `MonsterAccessoryHammerMsg`: `skillIndex` (#1) echo; `hammerCount` (#2) echo; `aimSkillGrade` (#3) echo; `success` (#4, BOOL) roll result; `isAuto` (#5, BOOL) echo; `autoStopResult` (#6, INT32) 0 continue, 1 "N° de temperamentos atingido", 2 "Atingir o alvo do temperamento", 3 "Materiais insuficientes", 4 "VIP expirou"; `materialTempIdList` (#7) echo.
- Receivers: `ACC.__hammerResult` for manual (success/fail animation, ignores `isAuto`, `ACC:496-521`); `AUTO.__hammerResult` for auto (`AUTO:139-160`).

### S3. 115 (0x0073) `U_C_BAG_MOVE_UPDATE` and 54 (0x0036) `U_C_BAG_MOVE`
Inventory messages carrying the item rows (`SimpleItemInfoMsg` with `strengthen_grade` #17 and `random_skill_1..5` #22..#26). Owned by [../inventory/README.md](../inventory/README.md).

## 5. Rules and formulas

### Accessory templates (`ItemTempInfos.xml`, `SonType` 232)

| Kind (`Property6`) | Beast types (`Job`) | Tier 1..5 (`TemplateId`, `TemplateName`, `StrengthenMax`, `NeedGrades` star) |
|---|---|---|
| 1 bell "Sino de monstro" | 2,3,4,16,17,19 | 2321001 "Laço de couro" (10, 1), 2321002 "Sino de coleira de ferro" (20, 1), 2321003 "Sino de coleira de cobre" (30, 2), 2321004 "Sino de coleira de ouro" (40, 2), 2321005 "Sino de coleira de platina" (50, 3) |
| 2 glove "Luva de monstro" | 1,5,6,7,8,12,18 | 2322001 "Luva de corrente", 2322002 "Luva de prata", 2322003 "Luva de ouro", 2322004 "Luva de cristal", 2322005 "Luva de diamante" (same caps and stars) |
| 3 sachet "Sachê de monstro" | 9,10,11,13,14,15 | 2323001 "Folha de menta", 2323002 "Girlanda de menta", 2323003 "Sachê de tecido", 2323004 "Sachê de seda", 2323005 "Sachê de ouro" |

- Attribute: `ReduceResi` ("Anti-Res {0}") 5000, 7500, 10500, 14100, 20300 by tier; value at level L = `base + 0.05 * (L - 1) * base`, next level preview `+0.05 * base` (`ACC:849-888`). Beast types 96..99 appear in no `Job` list (assumption: cannot wear accessories).
- `Property1` (10..50) = temperament power when the accessory itself is used as material; `Property2` = next tier template; `Property3..5` = the three characteristic skill `SonType`s of the kind (bell 850 Atordoamento, 851 Confusão, 852 Sangramento; glove 853 Reflexão, 854 aumento de dano, 855 Crítico; sachet 856 redução de dano, 857 recuperação de Vida, 858 redução de cura).
- `SellGold` 1000.

### Strengthen
- Material: "Gema do dragão" 2330001 (`SonType` 233, `Property1` 10, `NeedGrades` 70) from bag 36. Assumption: each Gem adds `Property1` = 10 bless.
- Table `UpGradeTempInfos` `Types=151` (`MMOD:139`): the bar uses row index `strengthenGrade` (row `Grades` = L + 1), `Data` = bless needed to reach L + 1 (600 for Lv2 .. 547500 for Lv50) (`ACC:686-716`). Level cannot pass `StrengthenMax` of the current tier.

### Breakthrough
- Allowed when `strengthenGrade == StrengthenMax` and `Property2 > 0` (tiers 1..4). Materials from config `moster_skill_lv{L}break` (L = 10, 20, 30, 40), entry `Property6 - 1` (bell, glove, sachet), format `templateId,count;...` (`decompiled/core_module/scripts/yishi/datas/ConfigInfoManager.as:1098-1106`, `ACC:795-817`):
  - Lv10: bell 2330004 x5, 2330003 x5, 2330002 x10; glove 2330004 x5, 2330002 x5, 2330003 x10; sachet 2330003 x5, 2330002 x5, 2330004 x10.
  - Lv20: bell 2330007 x8, 2330006 x8, 2330005 x14, 2330002 x30; glove 2330007 x8, 2330005 x8, 2330006 x14, 2330003 x30; sachet 2330006 x8, 2330005 x8, 2330007 x14, 2330004 x30.
  - Lv30: bell 2340012 x8, 2340011 x8, 2340010 x14, 2330005 x40; glove 2340012 x8, 2340010 x8, 2340011 x14, 2330006 x40; sachet 2340011 x8, 2340010 x8, 2340012 x14, 2330007 x40.
  - Lv40: bell 2340012 x40, 2340011 x40, 2340010 x70; glove 2340012 x40, 2340010 x40, 2340011 x70; sachet 2340011 x40, 2340010 x40, 2340012 x70.
- Result: template becomes `Property2`, strengthen level and characteristics kept (assumption), cap raised by 10.
- Note: `UpGradeTempInfos` rows 15100010/20/30/40 also list materials in `TemplateName` with different values; the client uses ConfigInfos, so the server must use ConfigInfos too.

### Characteristics
- Slot k (1..5) unlocks at the strengthen level whose type 151 row has `ActiveObject` = k: 10, 20, 30, 40, 50 (`V/item/MonsterAccessoriesEffectItem.as:94-107`). On unlock the server grants a random characteristic level 1 of one of the kind's three `SonType`s (help text; assumption: level 1).
- Stored as skill template ids in `randomSkill1..5` (`SkillTempInfos.xml` `SonType` 850..858, `Grades` 0..5).
- Active effect: sum the `Grades` per `SonType` over the 5 slots, take the highest sum (ties: highest slot index) (`MMOD:809-873`); description built from the grade 0 skill buffer plus talent effects of each slot grade (`MMOD:694-807`).

### Temperament
- Success percent = `min(100, sum over work pos 1..5 of int(Property1 * p[slot - 1] / 100))` with `p` = `moster_skill_probability` = 103, 25, 8, 3, 1 (`ACC:775-793,912-921`). One item per position counts once. Materials: `SonType` 234 ("Escova de polimento" 20, "Ferramenta de escultura" 20, "Folha fresca" 20, "Graxa de sapatos" 40, "Pá" 40, "Buquê cheio" 40, "Sino/Luva/Folha de temperamento" 40, "Graxa de couro" 100, "Martelo" 100, "Rosa preciosa" 100) or other accessories (`Property1` 10..50).
- On success the slot gets a random `SonType` of the kind and a random level from `moster_skill_level_property` row `slot`: slot 1: Lv1 100; slot 2: 66, 33; slot 3: 75, 15, 10; slot 4: 70, 15, 10, 5; slot 5: 50, 20, 15, 10, 5 (matches "Ao temperar recebe uma característica nv. 1-N aleatória"). Materials are consumed on every attempt (assumption: one unit per occupied position).
- Auto: stop result 1 when `hammerCount` reaches 0 after this attempt, 2 when the slot level >= `aimSkillGrade`, 3 when a material runs out, 4 when VIP < 4 or expired.

## 6. Templates

| File | Use |
|---|---|
| `raw/xml/tempinfos/ItemTempInfos.xml` | `SonType` 232 accessories, 233 Gem, 234 temperament and breakthrough materials |
| `raw/xml/tempinfos/UpGradeTempInfos.xml` | `Types` 151: bless per level and slot unlock (`ActiveObject`) |
| `raw/xml/tempinfos/SkillTempInfos.xml` | characteristic skills `SonType` 850..858 |
| `raw/xml/tempinfos/SkillBufferTempInfos.xml` + talent templates | characteristic effect values (`BufferIds`, `TalentEffIds`) |
| `raw/xml/tempinfos/ConfigInfos.xml` | `moster_skill_probability`, `moster_skill_level_property`, `moster_skill_lv10break` .. `lv40break` |

## 7. Persistent state

Items live in the inventory tables ([../inventory/README.md](../inventory/README.md)) with `bag_type` 36/37/0 and these per item columns (proposed on the shared item table): `strengthen_grade`, `strengthen_bless`, `random_skill_1..5`, `owner_object_id` (monster id for bag 37). Monster specific view:

```sql
CREATE TABLE monsters.accessory_state (
  item_id          BIGINT   PRIMARY KEY REFERENCES inventory.items(item_id) ON DELETE CASCADE,
  monster_id       BIGINT   UNIQUE REFERENCES monsters.monsters(monster_id) ON DELETE SET NULL,
  strengthen_grade SMALLINT NOT NULL DEFAULT 1 CHECK (strengthen_grade BETWEEN 1 AND 50),
  strengthen_bless INTEGER  NOT NULL DEFAULT 0 CHECK (strengthen_bless >= 0),
  random_skill_1   INTEGER  NOT NULL DEFAULT 0,
  random_skill_2   INTEGER  NOT NULL DEFAULT 0,
  random_skill_3   INTEGER  NOT NULL DEFAULT 0,
  random_skill_4   INTEGER  NOT NULL DEFAULT 0,
  random_skill_5   INTEGER  NOT NULL DEFAULT 0
);
```

Use this table only if the shared item table does not already carry these columns (the smith and einherjar equipment use the same fields).

## 8. Backend implementation notes

- Bag moves 5005 are handled by `inventory::bag::handle_move`; it calls `monsters::accessories::validate_equip` when `end_bag_type` is 37 (ownership of `object_id`, `Job` contains type, star >= `NeedGrades`, swap previous) and routes returns from bag 0 to 36/37.
- `monsters::accessories::handle_strengthen` (5150 with `opType` 2; dispatched from the smith strengthen handler): item in bag 0 pos 0 with `SonType` 232 -> level < `StrengthenMax` -> `count` >= 1 and Gems available -> transaction: consume Gems, add bless, level up through table 151 up to cap, unlock characteristic slots crossed (10, 20, ...) with a random level 1 characteristic -> reply 86, push 115.
- `monsters::accessories::handle_breakthrough` (5441): item in bag 0 pos 0 -> level == cap and `Property2` > 0 -> materials from config available in bag 36 -> transaction: consume, change template -> push 115.
- `monsters::accessories::handle_hammer` (5440): item in bag 0 pos 0 -> `skillIndex` slot holds a characteristic -> materials match work pos 1..5 -> for auto: VIP >= 4 active and no accessory material -> compute percent -> transaction: consume materials, roll, update `random_skill_N` -> reply 186 with `success`, echo fields and `autoStopResult` -> push 115. Auto mode is driven by the client (one request per attempt); the server computes the stop reason.
- Fight power of the wearer and of contracted lords must be recomputed when the accessory changes.

## 9. Open questions and assumptions

- Bless per Gem (assumed `Property1` = 10) and whether strengthen can fail.
- Whether moving an equipped accessory (bag 37) to the work bag keeps it equipped (client allows it for strengthening).
- Return destination when the client sends `end_bag_type` 1 for monster items (assumed bag 36 or the original bag 37).
- Material consumption per temperament attempt (assumed one unit per occupied position).
- Characteristic granted on slot unlock (assumed random level 1).
- Whether breakthrough keeps characteristics.

## 10. Implementation checklist

- [ ] Screen: equip cell and accessory bag in tab 0
- [ ] Screen: accessories tab strengthen and temperament panels
- [ ] Screen: auto temperament frame with stop texts
- [ ] Route 5005 equip/unequip/work bag moves for bags 36, 37, 0
- [ ] Route 5150 `StoreReqMsg.opType` 2 -> 86 + 115
- [ ] Route 5441 breakthrough -> 115
- [ ] Route 5440 manual and auto -> 186 + 115
- [ ] Sell via inventory
- [ ] Server message 86 encoder for accessory fields
- [ ] Server message 186 encoder with `autoStopResult`
- [ ] Item columns or `monsters.accessory_state`
- [ ] Rule: tier caps, resistance growth 5 percent per level
- [ ] Rule: slot unlock at 10/20/30/40/50
- [ ] Rule: success percent and level distribution from config
- [ ] Rule: breakthrough materials from `moster_skill_lv{L}break`
- [ ] Tests: wrong beast type rejected, star requirement, auto stop reasons
