# Armadura Mítica (devil armor, holes and pearls)

Module `devil-armor` of the feature [Vingador](README.md). Path conventions are in the README.

## 1. Overview

Tab index 3 of `AvengerFrame` (shown only when `VersionSwitch.DEVIL_ARMOR`, `CM/yishi/datas/VersionSwitch.as:200`). Four mechanics:

1. **Polish the armor** ("polir") with "Pedra de polir" 6910001: armor grade 1..10 (`UpGradeTempInfos` Types 155). Grades 1-5 open 2..6 "Buraco Mítico" holes; grades 6-10 add +2% .. +10% to all hole attributes.
2. **Carve a hole** ("esculpir", frame "Buraco Mítico esculpido") with "Pedra de esculpir" 6920001: hole grade 1..20 (`AvengerHoleTemplates.xml`), each grade gives flat attack/defense/magic defense/HP.
3. **Inlay pearls** ("Esfera Mítica", items SonType 670, 1680 templates) into open holes. A pearl's level must not exceed the hole grade; at most 2 pearls bound to the same avenger skill and at most 1 pearl per effect.
4. **Decompose pearls** in the smith ("Decompor") back into "Pedra de esculpir" (and fusion stones), op 8.

The materials and pearls do not live in the main bag: they live in the **avenger virtual bag** (bagType 3), pushed by 211/212 and stored client side in `AvengerModel.armorBagDic` (`CM/yishi/manager/BaseManager.as:350-365, 407-417`).

## 2. Screens

| Class (file) | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `avenger.view.AvengerDevilArmorView` (`M5/avenger/view/AvengerDevilArmorView.as`) | tab of "Vingador" (icon); hole list title "Esfera Mítica" (`AvengerDevilArmorView.itemTitleText.text`, :101) | Polish, show holes, open carve frame | Tab 3 | Armor grade number (:179); polish stone count and tooltip (6910001 from `armorBagDic`, :180-186); exp bar `exp / UpGrade(155, grade+1).Data` and next-grade text `TemplateName` (e.g. "Abrir 3 buracos mítico"), or "Nível máximo da Armadura Mítica" at max (:187-204); look image tooltip listing every Types 155 row green (reached) or grey (:214-235); 6 `AvengerDevilArmorEquipItem` holes pos 0..5 (:104-119, 205-211); embedded bag view |
| `avenger.view.AvengerDevilArmorBagView` (`M5/avenger/view/AvengerDevilArmorBagView.as`) | none | Virtual bag grid | Inside the armor tab | `armorBagDic` sorted by templateId in at least 42 cells (6 columns, grows by rows) (:54-60, 65-105) |
| `avenger.item.AvengerDevilArmorEquipItem` (`M5/avenger/item/AvengerDevilArmorEquipItem.as`) | none | One hole | Armor tab, `DevilArmorLookInfoFrame` (read-only) | Hole grade "Nv.{0}"; lock image when grade 0; inlaid pearl cell; "+" button (opens the carve frame) visible only when open and editable (:90-115) |
| `avenger.item.AvengerDevilArmorItemCell` (`M5/avenger/item/AvengerDevilArmorItemCell.as`) | none | Draggable pearl cell (showType 1 = bag, 2 = hole) | Bag view, hole items | Pearl icon, count; drag/drop and double click (only SonType 670 items are interactive, :208-229) |
| `avenger.AvengerDevilArmorCarveFrame` (`M5/avenger/AvengerDevilArmorCarveFrame.as`), key `DEVILARMOR_CARVE_FRAME` (`CM/mvc/controler/AvengerControler.as:34-37`) | "Buraco Mítico esculpido" (`AvengerDevilArmorCarveFrame.title.text`, :225) | Carve one hole | "+" button of a hole (`AvengerDevilArmorEquipItem.as:79-83`) | Hole grade; current and next grade stats (`AvengerDevilArmorCarveItem`: "Ataque:{0}", "Defesa:{0}", "Resistência:{0}", "Vida:{0}"); exp bar `exp / tempInfo.NeedItemNum`; owned carve stones "Quantidade atual: {0}" (6920001 from `armorBagDic`); amount input (default 1, clamped 1..owned, :165-176); note "Nota: O nível da Esfera Mítica colocada não pode ser maior que o nível do Buraco Mítico" (:111); max state "Nível máximo atingido" (:178-210) |
| `store.AvengerRosolveView` (`M14/store/AvengerRosolveView.as`) in `NewResolveView` (smith, tab enabled when `isAvenger`, `M14/store/NewResolveView.as:56-79, 117-120`) | smith decompose tab | Decompose pearls | Smith | 4 manual slots + "decompose all" filter; preview of materials from `ItemResolveTemplates` Type 1 (:307-410). UI owned by [../smith/README.md](../smith/README.md) |
| `store.resolve.AllResolvePopFrame` (`M14/store/resolve/AllResolvePopFrame.as`) | none | Filter by quality and level for "decompose all" | Decompose all button | Qualities from `ItemResolveSortTemplates` Sontype 670 ("Verde", "Azul", "Roxo", "Laranja", "Vermelho") plus "Tudo" (:205-260) |

## 3. Routes (client to server)

All routes use **8657 (0x21d1) C_AVENGER_CLIENT_OP** with `player.PlayerOpMsg` (full field list in [core.md](core.md) §3).

### D1. Polish the armor (op 5, DEVIL_ARMOR)

| Item | Value |
|---|---|
| UI control | polish button of the armor tab |
| Client sender | `AvengerDevilArmorView.__polishClickHandler` (`M5/avenger/view/AvengerDevilArmorView.as:138-146`) -> `AvengerManager.sendDevilArmorRequest` (`CM/yishi/manager/AvengerManager.as:221-227`) |
| Client checks | owned 6910001 in `armorBagDic` > 0, else "Materiais necessários insuficentes, não é possível efetuar operação."; button disabled at max grade (:187-200) |
| Request | `op (#1, INT32) = 5`. No other field (no count) |
| Expected response | **212** U_C_VIRTUAL_BAG_UPDATE `{bagType 3, items [6910001 new count]}`; **4588** `AvengerMsg{opType=5, armorGrade, armorExp, holeDatas=[holes that were opened]}` |

### D2. Carve a hole (op 6, DEVIL_ARMOR_HOLE)

| Item | Value |
|---|---|
| UI control | carve button of `AvengerDevilArmorCarveFrame` |
| Client sender | `AvengerDevilArmorCarveFrame.__carveClickHandler` (`M5/avenger/AvengerDevilArmorCarveFrame.as:154-163`) -> `AvengerManager.sendDevilArmorCarveRequest(pos, count)` (`AvengerManager.as:229-237`) |
| Client checks | `count > 0` and owned 6920001 in `armorBagDic` >= count, else "Materiais necessários insuficentes, ..."; button hidden at max hole grade (:188-208); the frame can only be opened on an open hole (`AvengerDevilArmorEquipItem.as:103`) |
| Request | `op (#1, INT32) = 6`; `index (#6, INT32)` = hole pos 0..5; `count (#4, INT32)` = carve stones to consume |
| Expected response | **212** `{bagType 3, items [6920001 new count]}`; **4588** `AvengerMsg{opType=6, holeDatas=[the hole]}` |

### D3. Inlay, swap or remove a pearl (op 7, DEVIL_ARMOR_EQUIP)

| Item | Value |
|---|---|
| UI control | double click or drag of a pearl between the bag grid and a hole |
| Client sender | `AvengerDevilArmorItemCell.__doubleClickHandler` (:165-186), `beDropHitCallBack` (:107-151), `dealBagHandler` (:153-163) -> `AvengerManager.sendDevilArmorEquip(pos, templateId = 0)` (`AvengerManager.as:239-247`) |
| Client checks | see the table below; on failure one of the alerts "Sem local disponível no momento" (-1), "O nível atual da Esfera Mítica é maior que o nível do Buraco Mítico" (-2), "Só pode equipar 2 Esferas Míticas elevadas com a mesma habilidade" (-3), "Só pode equipar 1 Esfera Mítica com o mesmo efeito" (-4) (:188-206) |
| Request | `op (#1, INT32) = 7`; `index (#6, INT32)` = target hole pos 0..5; `templateId (#8, INT32)` = pearl template id from the virtual bag, or 0 (not sent) to remove the pearl of that hole |
| Expected response | **212** `{bagType 3, items [pearl(s) with new counts]}`; **4588** `AvengerMsg{opType=7, holeDatas=[the hole]}` (refreshes the armor views through the always-true branch, `AvengerManager.as:147`) |

Client decision table for op 7 (`AvengerDevilArmorItemCell.as` and `CM/mvc/module/avenger/AvengerModel.as:95-181`):

| Gesture | Client check | Sent |
|---|---|---|
| Double click a bag pearl | `checkCanEquipPos`: first open hole (sorted by pos) with `inlayItem == 0` and `pearl.Property1 <= hole.grade` (:95-106, 120-130), then `checkEquipResult` | `{index = that pos, templateId = pearl}` |
| Double click a hole pearl | none | `{index = pos}` (remove) |
| Drag bag pearl onto an empty hole | `checkEquipByPos`: `hole.grade >= Property1` (-2), then `checkEquipResult` over all holes (:108-118) | `{index = hole pos, templateId}` |
| Drag bag pearl onto an occupied hole, or hole pearl onto a bag pearl | `checkCanExchangePos`: grade check (-2), then `checkEquipResult` over the other holes (excluding the target, :132-147) | `{index = hole pos, templateId = bag pearl}` (swap) |
| Drag hole pearl onto an empty bag cell | none | `{index = hole pos}` (remove) |
| Drag between two cells of the same kind | rejected silently (:117-121) | nothing |

`checkEquipResult` (:149-181): over the open holes considered, count pearls with the same `Property2` (bound avenger skill) and with the same `Property3` (effect id). If the same-skill count is already >= 2, return -3; if the same-effect count is >= 1, return -4.

### D4. Decompose pearls (op 8, PROP_RESOLVE)

| Item | Value |
|---|---|
| UI control | decompose button of `AvengerRosolveView` (smith) |
| Client sender | `AvengerRosolveView.__onResolveHandler` (`M14/store/AvengerRosolveView.as:237-256`) -> `resolveConfirmHandler` (:269-272) -> `AvengerManager.sendAvengerResolve(param1)` (`AvengerManager.as:249-256`) |
| Client checks, in order | 1. selection not empty (button enabled when any manual or "all" item is selected, :409); 2. locked items cannot be selected: "Não é possível Decompor equipamento bloqueado" (`AvengerModel.as:193-221`); 3. manual slots max 4 (`M14/store/resolve/AvengerStoreItemCell.as:180-183`); 4. confirmation: for "decompose all" an alert "Deseja decompor o equipamento ... de ... na mochila?(Equipamentos bloqueados não serão decompostos)" (:242-249), otherwise a "do not show again" alert "Decompor a Esfera Mítica, traz gastos à Pedra esculpida, quer ir adiante?" (:250-255) |
| Request | `op (#1, INT32) = 8`; `param1 (#15, STRING)` = `"tid,count\|tid,count\|"` (trailing `\|`), manual slots with count 1 each, then "decompose all" items with their full count (:320-367) |
| Expected response | **212** `{bagType 3, items [each decomposed pearl with its new count (0 removes), 6920001 and the other output materials]}`. No 4588 is needed. The view resets on `DEVIL_ARMOR_BAG_UPDATE` (:215-220) |

## 4. Server messages (server to client)

| Opcode | Message, fields (tag, type) | Client receiver | When | Client effect |
|---|---|---|---|---|
| 4588 (0x11ec) U_C_AVENGER_DATA | `avenger.AvengerMsg` (spec in [core.md](core.md) §4): `opType (#1)` 5/6/7; `armorGrade (#5, INT32)`; `armorExp (#6, INT32)`; `holeDatas (#7, AvengerHoleMsg, repeated)` with `pos (#1, INT32)` 0..5, `grade (#2, INT32)` 0 locked or 1..20, `exp (#3, INT32)` carve exp inside the grade, `inlayItem (#4, INT32)` pearl template id or 0 (tags verified at `CM/com/road/yishi/proto/avenger/AvengerHoleMsg.as:122-137`) | `AvengerManager.__avengerMsgUpdateHandler` (`CM/yishi/manager/AvengerManager.as:85-105, 147-150`) | Response to ops 5, 6, 7; full sync opType 0 | Upsert holes by pos; `DEVIL_ARMOR_INFO_UPDATE` refreshes the armor tab and the carve frame; tasks 258/259 |
| 211 (0x00d3) U_C_VIRTUAL_BAG_DATA | `item.VirtualBagMsg{bagType (#1, INT32) = 3, items (#2, VirtualItemMsg, repeated)}`; `VirtualItemMsg{templateId (#1, INT32), count (#2, INT32), pos (#3, INT32), isLock (#4, BOOL)}` | `BaseManager.__virtualBagDataHandler` (`CM/yishi/manager/BaseManager.as:350, 356-366`) -> `resovleVistualBag` (:385-405): clears and rebuilds `armorBagDic` keyed by templateId | Login and deification *(assumption)* | `DEVIL_ARMOR_BAG_UPDATE` |
| 212 (0x00d4) U_C_VIRTUAL_BAG_UPDATE | same `VirtualBagMsg` (delta) | `BaseManager.__virtualBagUpdateHandler` (:351, 407-417) -> `handleVistualBagUpdate` (:436-459): upsert by templateId, delete when `count == 0` | After every change of the avenger virtual bag (ops 5, 6, 7, 8; pearl synthesis in the smith; drops) | `DEVIL_ARMOR_BAG_UPDATE`: armor tab counts, bag grid, carve frame count, decompose view reset |

The virtual bag is keyed by **templateId** on the client (one stack per template). `pos` and `isLock` are stored but positions are not used for layout (the grid sorts by templateId).

No error code. On rejection send nothing.

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Armor grades | 1..10 (`UpGradeTempInfos` Types 155, Id 155001-155010) | template |
| Armor exp to reach grade g | `Data` of row g: 0, 20, 20, 60, 80, 120, 180, 220, 380, 520 (bar `exp / UpGrade(155, grade+1).Data`) | `AvengerDevilArmorView.as:187-191` |
| Polish material | 6910001 "Pedra de polir" ("Item necessário para polir a Armadura Mítica, é produzido na Corrida contra o tempo."), item `Property1 = 10` *(assumption: one stone per click giving `Property1` = 10 exp)* | `ItemTempInfos.xml`; `AvengerModel.POLISH_STONE_TEMPID` (`CM/mvc/module/avenger/AvengerModel.as:20`) |
| Holes opened | `ActiveObject` of the armor grade row: 2, 3, 4, 5, 6 at grades 1..5, 6 afterwards. A newly opened hole gets grade 1 *(assumption: grade 0 means locked, `AvengerDevilArmorHoleInfo.isOpen`, `CM/mvc/module/avenger/AvengerDevilArmorHoleInfo.as:24-27`)* | template |
| Hole bonus | `TemplateId` of the armor grade row = +% to all hole attributes: 2, 4, 6, 8, 10 at grades 6..10 (text "Aumento de N% em todos os atributos do buraco mítico") | template |
| Hole grades | 1..20 (`AvengerHoleTemplates.xml` Type 1) | template |
| Carve exp for hole grade g -> g+1 | `NeedItemNum` of row g: 50, 150, 250, 350, 550, 750, 950, 1150, 1350, 1650, 1950, 2250, 2550, 2850, 3250, 3650, 4050, 4450, 4850; row 20 = 0 (max) | `AvengerDevilArmorCarveFrame.as:188-197` |
| Carve material | 6920001 "Pedra de esculpir", 1 stone = 1 exp *(assumption)*; overflow carries across grades *(assumption)* | `AvengerModel.CARVE_STONE_TEMPID` (:22) |
| Hole stats of grade g | `PhyAttack = PhyDefence = MagAttack = MagDefence = 1800 g`, `Health = 10800 g` (g = 20: 36 000 / 216 000), times (1 + armor bonus %) *(assumption on how the bonus applies)* | `AvengerHoleTemplates.xml` |
| Pearl level cap | pearl `Property1` (level 1..20) <= hole grade | `AvengerModel.as:100, 112, 138` |
| Same skill cap | at most 2 inlaid pearls with the same `Property2` (bound skill index 1..6, matching the 6 avenger skill names) | `AvengerModel.as:161-175` |
| Same effect cap | at most 1 inlaid pearl with the same `Property3` (effect id, e.g. 6711) | `AvengerModel.as:165-179` |
| Pearl stats | item `Attack`, `Defence`, `MagicAttack`, `MagicDefence`, `Live` (e.g. 6711101 Nv.1: 320/320/320/320/1920; 6711120 Nv.20: 6400 x4 / 38400; holy 6756320: 100000 x4 / 600000); pearl skill effect = SkillTempInfos `Property4` (e.g. 1511101), shown as its Description (`m16/scripts/yishi/view/tips/AvengerJewelryTips.as:113-129`) | `ItemTempInfos.xml` |
| Pearl families | 1680 templates with id `67PSEGG`: P = tier 1..5 (`Profile` 2..6 = "Verde", "Azul", "Roxo", "Laranja", "Vermelho"; tier 4 names start with "Lendário", tier 5 with "Sagrado"), S = bound skill index 1..6 (= `Property2`), E = effect 1..3 (`Property3` = `67SE`, e.g. 6711, 6763), GG = level 01..20 (= `Property1`) *(pattern read from template ids, names and properties)* | `ItemTempInfos.xml` SonType 670 |
| Decompose output | `ItemResolveTemplates` Type 1, row `ResolvedItem = pearl`: `Item1..4` x `Count1..4` per unit, e.g. 6711101 -> 1 x 6920001; 6711102 -> 12; 6756320 -> 78000 x 6920001 + 100 x 6940001 | `M14/store/AvengerRosolveView.as:322-345`; template |
| Decompose all filter | pearls with `Property1 <= level` and, unless "Tudo", `Profile == quality`; locked pearls are skipped | `M14/store/resolve/AvengerStoreItemCell.as:195-247` |
| Task 258 / 259 | armor grade >= Para2 / count of holes with grade >= Para2 must be 6 | `CM/mvc/module/task/TaskTemplate.as:1531-1555` |

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `raw/xml/tempinfos/UpGradeTempInfos.xml` Types 155 (10 rows), via `TempleteManager.getTemplateByLevelAndType(grade, 155)` (`CM/mvc/module/avenger/AvengerDevilArmorInfo.as:22-30`) | armor grade | `Grades`, `Data` (exp to reach the grade), `ActiveObject` (open holes), `TemplateId` (% bonus), `TemplateName` (description) |
| `raw/xml/tempinfos/AvengerHoleTemplates.xml` (20 rows, Type 1; `AvengerCommonTempCate.getTemplateByTypeAndGrade(1, grade)`, `CM/yishi/datas/templates/cate/AvengerCommonTempCate.as:19-40`; loaded at `CM/yishi/manager/TempleteManager.as:1320`) | hole grade | `Id`, `Type` (1), `Grade`, `NeedItem` (6920001), `NeedItemNum` (exp to next), `PhyAttack`, `PhyDefence`, `MagAttack`, `MagDefence`, `Health` (`CM/yishi/datas/templates/AvengerCommonTempInfo.as:6-34`) |
| `raw/xml/tempinfos/ItemTempInfos.xml` SonType 670 | pearls | `Property1` level, `Property2` skill index, `Property3` effect id, `Property4` skill template, `Profile` quality, stats |
| `raw/xml/tempinfos/ItemTempInfos.xml` 6910001, 6920001, 6930001, 6940001 | materials | "Pedra de polir", "Pedra de esculpir", "Pedra fundida de ouro" (legendary pearl synthesis), "Pedra fundida de sangue" (holy pearl synthesis) |
| `raw/xml/tempinfos/ItemResolveTemplates.xml` Type 1 (1680 rows) | pearl decomposition | `ResolvedItem`, `Item1..4`, `Count1..4` |
| `raw/xml/tempinfos/ItemResolveSortTemplates.xml` Sontype 670 | decompose-all filter | `Propety1` (quality), `PropetyName1`, `Propety2` (max level 20), `Color` |

## 7. Persistent state

```sql
-- Devil armor of an avenger (one row per player).
CREATE TABLE avenger.devil_armors (
  player_id   bigint   PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
  grade       smallint NOT NULL DEFAULT 1 CHECK (grade BETWEEN 1 AND 10),
  exp         integer  NOT NULL DEFAULT 0 CHECK (exp >= 0),
  updated_at  timestamptz NOT NULL DEFAULT now()
);

-- Six holes per player, pos 0..5.
CREATE TABLE avenger.armor_holes (
  player_id               bigint   NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  pos                     smallint NOT NULL CHECK (pos BETWEEN 0 AND 5),
  grade                   smallint NOT NULL DEFAULT 0 CHECK (grade BETWEEN 0 AND 20),  -- 0 = locked
  exp                     integer  NOT NULL DEFAULT 0 CHECK (exp >= 0),
  inlay_item_template_id  integer,                                                     -- NULL = empty (sent as 0)
  PRIMARY KEY (player_id, pos),
  CHECK (inlay_item_template_id IS NULL OR grade > 0)
);

-- Avenger virtual bag (bagType 3): pearls and armor materials, one stack per template.
CREATE TABLE avenger.armor_bag_items (
  player_id         bigint   NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  item_template_id  integer  NOT NULL,
  count             integer  NOT NULL CHECK (count > 0),
  pos               integer  NOT NULL DEFAULT 0,
  is_locked         boolean  NOT NULL DEFAULT false,
  PRIMARY KEY (player_id, item_template_id)
);
```

If the inventory feature implements a generic virtual bag table (bag types 3, 5, 6), `avenger.armor_bag_items` should be that table filtered by `bag_type = 3`.

## 8. Backend implementation notes

| Handler | Route | Validation order | Transaction and pushes |
|---|---|---|---|
| `avenger::devil_armor::handle_polish` | 8657 op 5 | avenger -> devil armor enabled -> armor grade < 10 -> owns 6910001 in the virtual bag | One tx: consume 1 stone *(assumption)*, `exp += 10` *(assumption: item Property1)*, level up while `exp >= Data(grade+1)` (subtract, grade+1), open holes up to `ActiveObject` (set grade 1 on newly opened holes). Push 212 (stone count) and 4588 opType 5 with armor grade/exp and the opened holes |
| `avenger::devil_armor::handle_carve` | 8657 op 6 | avenger -> `index` 0..5 -> hole open (grade > 0) -> hole grade < 20 -> `count >= 1` -> owns `count` of 6920001 | One tx: consume up to the stones needed to reach the max *(assumption)*, add exp, level up using `NeedItemNum` of the current grade. Push 212 and 4588 opType 6 with the hole. Recompute hero stats |
| `avenger::devil_armor::handle_equip` | 8657 op 7 | avenger -> `index` 0..5 -> hole open. If `templateId != 0`: owns the pearl in the virtual bag -> item SonType 670 -> `Property1 <= hole.grade` -> same `Property2` count among the other holes < 2 -> same `Property3` count among the other holes < 1. If `templateId == 0`: the hole has a pearl | One tx: remove 1 pearl from the bag, put the previous pearl of the hole (if any) back into the bag, set `inlay_item_template_id` (or NULL on removal). Push 212 with both changed stacks and 4588 opType 7 with the hole. Recompute hero stats |
| `avenger::devil_armor::handle_decompose` | 8657 op 8 | avenger -> parse `param1` as `tid,count` pairs (ignore empty trailing entry) -> each tid is SonType 670 with a Type 1 resolve row -> owned count >= requested -> not locked | One tx: remove the pearls, add `count x CountN` of every `ItemN` to the virtual bag. Push one 212 with all changed stacks |

- Virtual bag helper `avenger::devil_armor::bag` must emit 212 deltas (count 0 removes the stack) and 211 snapshots (login).
- Inlaid pearls are not in the virtual bag; they are only in `armor_holes`.
- Hero attributes = holes (template x armor bonus) + inlaid pearl stats; pearl skills (`Property4`) are passive skills to apply in battle *(assumption: added to the hero passive skill list for the battle engine)*.

## 9. Open questions and assumptions

1. *(assumption)* Op 5 consumes one "Pedra de polir" per click for `Property1 = 10` exp; the client sends no count.
2. *(assumption)* Holes opened by the armor grade start at grade 1; the order of opening is pos 0, 1, 2, ...
3. *(assumption)* The armor % bonus (grades 6-10) multiplies hole stats only, not pearl stats ("todos os atributos do buraco mítico").
4. *(assumption)* 1 carve stone = 1 hole exp, with overflow across grades.
5. How pearls enter the virtual bag (synthesis in the smith with compose types 111..156, shops, drops) is owned by other features; the bag push 212 must be sent by them.
6. Pearl skills (`Property4`, e.g. 1511101) and their battle effect are not described client side beyond the Description text.
7. Whether locking virtual bag items (`isLock`) has a route; none was found in this feature.

## 10. Implementation checklist

- [ ] Screen `AvengerDevilArmorView` (grade, exp, tips, polish button, 6 holes)
- [ ] Screen `AvengerDevilArmorBagView` + `AvengerDevilArmorItemCell` (drag, double click, client checks)
- [ ] Screen `AvengerDevilArmorCarveFrame` + `AvengerDevilArmorCarveItem`
- [ ] Smith screens `AvengerRosolveView`, `AllResolvePopFrame` (smith feature) wired to op 8
- [ ] Route 8657 op 5 -> `avenger::devil_armor::handle_polish`
- [ ] Route 8657 op 6 -> `avenger::devil_armor::handle_carve`
- [ ] Route 8657 op 7 -> `avenger::devil_armor::handle_equip` (inlay, swap, remove)
- [ ] Route 8657 op 8 -> `avenger::devil_armor::handle_decompose`
- [ ] Server messages 4588 opType 5/6/7, 211 and 212 with bagType 3
- [ ] Tables `avenger.devil_armors`, `avenger.armor_holes`, `avenger.armor_bag_items`
- [ ] Rules: armor grades and hole opening (Types 155), hole grades (AvengerHoleTemplates), pearl caps (level, same skill, same effect)
- [ ] Template loaders: Types 155, `AvengerHoleTemplates.xml`, pearls SonType 670, `ItemResolveTemplates` Type 1
- [ ] Test: equip rejected for level > hole grade, third pearl of the same skill, second pearl of the same effect
- [ ] Test: swap returns the old pearl to the bag; remove with templateId 0
- [ ] Test: decompose with trailing `|`, locked pearls rejected, output materials added
