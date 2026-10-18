# Theseus god plates ("Placa divina")

Area: character progression, feature `theseus`, module `godhead` (code names "slate", "shiban", "godhead").

The player owns **plates** (slates). Each plate is a polyomino of 1 to 4 cells, with stats, an optional passive or triggered skill, a level (1..60) and a star grade (0..5). Plates are placed on a **5x5 board** whose cells start sealed and are unsealed with "Chave de Teseus". Equipped plates add their stats to the hero. Plates can be:
- leveled ("Elevação") with "Poeira de placa" and gold;
- promoted ("Promoção") by fusing a duplicate plate plus dust;
- rotated, locked, decomposed back into dust.

A small task list ("Missão") pays keys.

Conventions:
- Paths are relative to `decompiled/` unless they start with `raw/`, `protocol/`, `index/`, `build/` or `docs/`. `CM` = `core_module/scripts`, `M5` = `m5/scripts`.
- Opcode names come from `protocol/opcodes.csv`. Proto tags were checked against the generated `writeToBuffer` in `build/as3/gen/com/road/yishi/proto/slate/*.ts`.
- *(assumption)* marks anything the client does not prove.
- Everything goes over the binary socket. There is one request opcode with an `op` switch and one response or push opcode.
- **Registry note.** `roadmap/features.json` lists the proto package `slate` under feature `inventory`. The only user of `slate.*` is this module (`CM/managers/TheseussoulManager.as:239-449`), so it is mapped here.
- **Opcode note.** The request opcode **9762 (0x2622) `C_THESEUS_SLATE_CLIENT_OP`** is missing from `protocol/opcodes.csv`. It is defined in `CM/yishi/datas/consant/ProtocolType.as:1486`.

---

## 1. Overview

- **Unlock.** The "Divino" button (`TheseusGodheadFrame.title1`) lives on the Theseus main frame (`theseus.view.ThereussoulEquipView`, owned by part A of the feature, `M5/theseus/view/ThereussoulEquipView.as:118-120, 183-194`).
  - It is visible only when `RoyaltyTemplates[royaltyLevel].OpenSlate == 1`.
  - `royaltyLevel` comes from `RoyaltyBossManager.model.royaltyLevel` (feature `royalty-boss`).
  - In `raw/xml/tempinfos/RoyaltyTemplates.xml` that is **RoyaltyLevel 30 and above** (levels 1..29 have OpenSlate 0, levels 30..40 have 1).
- **Open.** The click calls `__openGodtion` (`:293-297`). It sets `theseussoulController.backTheseFrame = "theseussoul"` and calls `openControllerByInfo("theseussoul",10)`, which opens `theseusgodhead.TheseusgodAllFrame` (`CM/mvc/controler/TheseussoulController.as:68-70`).
  - The frame constructor immediately sends 9762 `op=1` (`M5/theseusgodhead/TheseusgodAllFrame.as:99-104`).
  - The client has no login push for plates. Data exists only after the frame has been opened once.
- **Tabs.** The frame has four tab buttons (`initActionButtons`, `:253`; switch `__actionButtonChange`, `:467`):
  1. "Placa divina": the board;
  2. "Elevação": level up;
  3. "Promoção": star up;
  4. "Missão": tasks.

  The plate bag is always visible on the right: 6 pages of 12 cells.
- **Board rules** (client side only displays them; the server must enforce):
  - 25 cells, index `row*5 + col`;
  - a cell is sealed when its bit in `posMark` is 1 (`CM/mvc/module/theseus/TheseusGodheadModel.as:74-81`);
  - an equipped plate is anchored at `equipPos`, the top-left cell of its rotated bounding box (the stone bitmap is drawn at `grid[equipPos]`, `M5/theseusgodhead/view/TheseusGodheadView.as:78-120`);
  - plates must not overlap and must not cover sealed cells *(assumption: no client check exists; see §5.3)*.
- **Stats.** The server sends the summed stats of all equipped plates (`SlatePropertyMsg`). The "Bônus total" frame (`openControllerByInfo("theseussoul",11)`) lists them together with the skill descriptions of the equipped plates.

---

## 2. Screens

| Class (file) | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `theseusgodhead.TheseusgodAllFrame` (`M5/theseusgodhead/TheseusgodAllFrame.as`), 900x600 (`:112-114`), layer 3 (`:618-620`) | "Placa divina" (`theseusgodhead.txt1`) | Container: board, bag, 4 tabs, 6 bag pages, "Decompor", "Virar", item-lock buttons | `ThereussoulEquipView.__openGodtion` (`M5/theseus/view/ThereussoulEquipView.as:293-297`); controller key `theseussoul` openType 10 | Tabs "Placa divina" / "Elevação" / "Promoção" / "Missão" (`theseusgodhead.txt1..4`). Item-lock button "Bloqueio de Itens" (`mainBar.SmallMapBar.vicepasswordBtnTipData`), enabled at hero grade 10 or more (`:149`). Sub-buttons "Bloquear" (`armyII.ArmyFrameII.lockBtn.text`) and "Senha" (`room.view.pve.RoomRightView.lockBtn.tipData`). Closing returns to the Theseus main frame (`TheseussoulController.exitFrame`; `backTheseFrame`) |
| `theseusgodhead.view.TheseusGodheadView` (`M5/theseusgodhead/view/TheseusGodheadView.as`) | tab "Placa divina" | 5x5 board with sealed cells and equipped plates; drag targets | Tab 0 | Label "Placa equipada:" (`theseusgodhead.txt5`, `:230`). Per-type counts such as "Placa de atributos x2" (`updateEquippedText`, `:138`, type names `theseusgodhead.txt17..20`). Info button opens the "Bônus total" frame (`:304-306`). Sealed cells are clickable (`:256-279`) |
| `theseusgodhead.view.TheseusGodheadBagView` (`M5/theseusgodhead/view/TheseusGodheadBagView.as`) | none | Plate bag, 6 pages x 12 (`_pageCount=6`, `_pageSize=12`, `:37-39`), sorted by templateId then stoneId (`setGoods`, `:164-167`) | Always visible in the frame | `TheseusGodheadBagItem` cells: icon by shape and rotation, stars, level, lock mark. Rotate mode with a cursor; decompose mode with selection marks |
| `theseusgodhead.view.TheseusGodheadUpgradeView` (`M5/theseusgodhead/view/TheseusGodheadUpgradeView.as`) | tab "Elevação" | Level a plate by 1 | Tab 1; select a plate in the bag (`EventGodheadInsPutIn`, `TheseusgodAllFrame.as:345-383`) | "Nv.{0}" current and next (`theseusgodhead.upgrade.currentLevel`). Up to 3 stats as "+current", "+next" and "+delta" (`updateUI`, `:228-343`). Cost: dust count (`Item`) with the bag total (`_allNum`, `GoodsManager.getGoodsNumByTempId`, `:262`), and gold (`Consume`, gold icon, `:275-278`). At max level: "Nível máximo" (`army.stone.fullLV`) and the red hint "Elevação disponível após a promoção" (`theseusgodhead.txt13`). Confirm button "Elevação" |
| `theseusgodhead.view.TheseusGodheadStarUpView` (`M5/theseusgodhead/view/TheseusGodheadStarUpView.as`) | tab "Promoção" | Promote a max-level plate to the next star | Tab 2; select a plate | Current and next stars, the result plate preview (`NewMaterial`), the duplicate-plate requirement "{have}/{need}" (red if short, `:220-225`), material items with bag counts. "Estrela máxima" (`theseusgodhead.txt14`) at star 5. Button "Confirmar promoção" |
| `theseusgodhead.view.TheseusGodheadTaskView` + `item.TheseusGodheadTaskItem` (`M5/theseusgodhead/view/TheseusGodheadTaskView.as`, `M5/theseusgodhead/item/TheseusGodheadTaskItem.as`) | tab "Missão" | 16 tasks with key rewards | Tab 3 | `TaskDescription` from the template, reward icon (`TaskReward`), button "Coletar" (`theseusgodhead.txt12`), "claimed" stamp. Sort: claimable first, claimed last, then by TemplateId (`sortNumbers`, `:48`). State per `TheseusSlateTaskInfo.state` (§5.6) |
| `theseusgodhead.view.GodItemSellView` (`M5/theseusgodhead/view/GodItemSellView.as`) | "Desmonte de placa divina" (`theseusgodhead.decompose.title`) | Decompose list | Button "Decompor" (`theseusgodhead.decompose`, `TheseusgodAllFrame.__decomposeBtnClick`, `:189`) | Rows `GodheadSellItem` (name, level, delete), total dust preview `_total` (`calculateSlateReward`, `:245-280`), buttons "Decompor" / "Cancelar" |
| `theseusgodhead.TheseusGodheadFrame` (`M5/theseusgodhead/TheseusGodheadFrame.as`) | "Bônus total" (`theseus.yi.frameTitle`, `:74`) | Read-only summary | Info button on the board (`openControllerByInfo("theseussoul",11)`) | Two `TheseusHeadInfoItem` blocks (`M5/theseusgodhead/TheseusHeadInfoItem.as:25`): (1) "Atributo de Bônus total" (`theseus.yi.allAdd`) with the non-zero stats of `SlatePropertyMsg`, in the order ATQ, DEF, MAG, Resistência, Crítico, Vida, Bloqueio, Penetração (`TheseusGodheadModel.get attNames`, `:363`); (2) "Bônus de habilidade" (`theseusgodhead.txt21`) with the `Description` of every `SkillTempInfos` id in `SlateSkillTemplate` of each equipped plate |
| `yishi.view.tips.TheseusGodheadEquipTip` (`m16`) | none | Plate tooltip | Hover on a board plate, bag item or star-up cell | Icon, stats, skills. Uses `goddess.equip.tipMax` "(Pode fortalecer até {0})" |
| Confirm popups (`SimpleAlertHelper`) | "Aviso" (`public.prompt`) | Unseal a cell; confirm decompose | Click on a sealed cell; "Decompor" | "Deseja consumir chave de Teseus x1 para desbloquear a placa?" (`theseusgodhead.equipped_none.txt1`); "Deseja decompor {0} placa(s) divina(s)? Pode receber {1} poeira de placa após decomposição." (`theseusgodhead.decompose.confirm`) |

The vice-password screens (`openControllerByInfo("vicepassword",1|2|3)`) belong to the account area.

---

## 3. Routes (client to server)

All requests use **9762 (0x2622) `C_THESEUS_SLATE_CLIENT_OP`** with `com.road.yishi.proto.player.PlayerOpMsg`, sent through `SocketManager.instance.socket.sendProtobuffer` (`CM/managers/TheseussoulManager.as:1034-1135`).

Only these fields are ever set:
- `op (#1, INT32, single)`: the action;
- `id (#5, INT32, single)`: plate id (stone id) or task template id;
- `pos (#19, INT32, single)`: board cell, or the material plate id for op 4;
- `ids (#20, INT32, repeated)`: list of plate ids.

No other PlayerOpMsg field is used.

| # | UI control | Client sender (file:line) | Client checks, in order | Request body | Expected response |
|---|---|---|---|---|---|
| R1 | Open "Placa divina" frame | `TheseusgodAllFrame()` constructor (`M5/theseusgodhead/TheseusgodAllFrame.as:99-104`) → `TheseussoulManager.requestSlateData` (`CM/managers/TheseussoulManager.as:1034-1040`) | Button visible only when OpenSlate == 1 (`M5/theseus/view/ThereussoulEquipView.as:185-194`) | `{op=1}` | **1024** `opType=1` with `posMark`, all `slates`, `tasks`, `property` (full snapshot) |
| R2 | Click a sealed board cell, then "Confirmar" | `TheseusGodheadView.__gridMouseDown` (`M5/theseusgodhead/view/TheseusGodheadView.as:256-279`) → `buyCallBack` (`:281-288`) → `unlockPos(pos)` (`TheseussoulManager.as:1042-1049`) | 1. cell not unlocked (`!grid.unlocked`); 2. confirm dialog `theseusgodhead.equipped_none.txt1`. No client check of the key count | `{op=2, pos(#19)=cell 0..24}` | **1024** `opType=2` with the new `posMark` (slates may be empty). The key item decrement comes through the inventory push *(assumption, inventory area)* |
| R3 | "Elevação" button | `TheseusGodheadUpgradeView.__confirmHandler` (`M5/theseusgodhead/view/TheseusGodheadUpgradeView.as:223-226`) → `upgradeSlate(id)` (`TheseussoulManager.as:1051-1058`) | Only: a plate is selected and `level < maxLevel` (otherwise the button is hidden, `updateUI` `:228-343`). The client does **not** check dust or gold | `{op=3, id(#5)=stoneId}` | **1024** `opType=3` with the changed plate (`grade+1`) and the new `property` when the plate is equipped *(assumption: always send property)*. Gold and dust decrements come through the core and inventory pushes |
| R4 | "Confirmar promoção" | `TheseusGodheadStarUpView.clickHandler` (`M5/theseusgodhead/view/TheseusGodheadStarUpView.as:385-407`) → `starUpSlate(id, materialId)` (`TheseussoulManager.as:1060-1068`) | `isCanUpstar(true)` (`:312-383`): 1. `level >= maxLevel`, else "Promoção disponível após Nv.{0}" (`theseusgodhead.txt15`); 2. every non-plate material (index 1 and up of the compose row, i.e. dust) has bag count >= need, else "Material insuficiente para a promoção" (`theseusgodhead.txt16`); 3. the bag holds at least `Count2` other existing plates with the same templateId (`getBagStoneCountByTemplateId`, `CM/mvc/module/theseus/TheseusGodheadModel.as:593`), else txt16. The client picks the **first** matching bag plate as the material | `{op=4, id(#5)=target stoneId, pos(#19)=material stoneId}` | **1024** `opType=4` with: (a) the target plate with its new `templateId` (star = templateId % 10) and unchanged `grade`, and (b) the material plate with `pos=-1`, `is_exist=false` and **no** `equipPos`, so the client removes it from the bag (`TheseussoulManager.as:355-376`). Plus `property` if the target is equipped |
| R5 | "Decompor" in the decompose list, then "Confirmar" | `GodItemSellView.__sellHandler` (`M5/theseusgodhead/view/GodItemSellView.as:157-171`) → `__decomposeResponse` (`:173-187`) → `resolveSlate(ids)` (`TheseussoulManager.as:1070-1077`) | 1. list not empty; 2. locked plates are refused when added: "Placas bloqueadas não podem ser decompostas" (`theseusgodhead.equipped_none.lock`, `TheseusgodAllFrame.as:345-360`); 3. only bag plates can be added (the decompose mode works on bag cells only); 4. confirm dialog with the count and the dust preview | `{op=5, ids(#20, repeated)=stoneIds}` | **1024** `opType=5` whose `slates` list the removed ids (only `id` is read, `decomposeShiban`, `TheseussoulManager.as:278-290`). Dust (30000000) credit comes through the inventory push |
| R6 | "Virar" (rotate mode), then click a bag plate | Rotate mode toggled by `TheseusgodAllFrame.__rotateBtnClick` (`:239`) → `TheseusGodheadBagView.toggleRotateMode`. The click on a bag item reaches `TheseusBagCellDropMediator.starItemDrag` (`M5/theseusgodhead/mediator/TheseusBagCellDropMediator.as:22-31`) → `rotateSlate(id)` (`TheseussoulManager.as:1079-1086`) | `modelGodhead.isRotateMode`; the plate is in the bag (the mediator is registered on bag items only). Equipped plates cannot be rotated from the client | `{op=6, id(#5)=stoneId}` | **1024** `opType=6` with the plate (`rotate` = (rotate+1) mod 4 *(assumption: one 90 degree clockwise step, matching `TheseusSlateShapeInfo.rotateGrid` and the bitmap rotation)*) |
| R7 | "Bloqueio de Itens", then "Bloquear", then click a bag plate | `TheseusgodAllFrame.__vpLockHandler` (`:385-402`) and `__goodsLockHandler` (`:432-465`) → `TheseusGodheadBagHelper.vpLockBtnClickHandler` → `__vpLockClickHandler` (`M5/theseusgodhead/TheseusGodheadBagHelper.as:51-90`) → `lockSlate(id)` (`TheseussoulManager.as:1088-1095`) | 1. hero grade >= 10, else "Função habilitada no Nv. {0}" ({0}=10); 2. not `isDuringResetTime`, else "Durante o periodo de reset à senha, não pode realizar nenhuma operação"; 3. `hasVicePassword == 1`, else opens `vicepassword` 1; 4. `GlobalConfig.isConfirmPassword`, else opens `vicepassword` 3 | `{op=7, id(#5)=stoneId}` | **1024** `opType=7` with the plate and the toggled `is_lock` |
| R8 | "Coletar" on a task | `TheseusGodheadTaskItem.__receiveHandler` (`M5/theseusgodhead/item/TheseusGodheadTaskItem.as:111-121`) → `getMissionReward(taskId)` (`TheseussoulManager.as:1097-1104`) | `state == 1` (computed, §5.6) | `{op=8, id(#5)=SlateTaskTmpl.TemplateId}` | **1024** `opType=8` with `tasks` (at least the claimed task with `state=1`). Reward item through the inventory push |
| R9 | (no caller) | `moveSlatePos(id,pos)` (`TheseussoulManager.as:1106-1114`) | none | `{op=9, id, pos}` | Handled by the client as a merge (`opType=9`). **Dead route**: nothing calls it. Implement as an alias of op 11 or reject *(assumption)* |
| R10 | Drag a bag plate onto a board cell, or drag an equipped plate to another board cell | Bag to board: `TheseusBagCellDropMediator.beDropHitCallBack` (`M5/theseusgodhead/mediator/TheseusBagCellDropMediator.as:52-80`). Board to board: `TheseussoulEquipCellDropMediator.beDropHitCallBack` (`M5/theseusgodhead/mediator/TheseussoulEquipCellDropMediator.as:41-76`). Both → `movegirdSlatePos(id, anchor)` (`TheseussoulManager.as:1116-1124`) | 1. not in decompose mode (`StoneDropMediator.as:52`) and not in rotate mode; 2. `isCanEquip` always returns true (`TheseusBagCellDropMediator.as:83-87`). No overlap, sealed-cell or bounds check. The drop cell is converted to the anchor by `getPosByShapeandRotate` (`TheseusGodheadModel.as:284-327`, §5.3) | `{op=10, id(#5)=stoneId, pos(#19)=anchor cell}` (the anchor can be negative or out of the board when the drop is near an edge) | **1024** `opType=10` with the moved plate (`equip_pos` set 0..24) and `property` |
| R11 | Drag an equipped plate onto another plate, the bag, or outside the board | `TheseussoulEquipCellDropMediator.beDropHitCallBack` (`:41-55` drop on a `TheseusGodheadStoneUI`; `:68-76` any other target) → `movebagSlatePos(id, equipPos)` (`TheseussoulManager.as:1126-1134`) | none | `{op=11, id(#5)=stoneId, pos(#19)=its current equipPos}` | **1024** `opType=11` with the plate back in the bag: `pos >= 0` and **no** `equip_pos` (or -1), plus `property` |

The client never resends op 1 after an action. Every response must carry everything the client needs to redraw (§4).

---

## 4. Server messages (server to client)

### 1024 (0x0400) `U_C_SLATE_USER_DATA`

Message `com.road.yishi.proto.slate.UserSlateMsg`. Receiver: `TheseussoulManager.__slateInfosHandler` (`CM/managers/TheseussoulManager.as:236, 239-276`). Response to every 9762 op, echoing the op in `opType`. It may also be pushed after an external grant of plates *(assumption: use opType 1 or 3 for pushes, since both merge)*.

| Field | Tag | Type | Meaning |
|---|---|---|---|
| op_type | 1 | INT32 | Echo of the request op (1..11). Selects the client branch below |
| pos_mark | 2 | INT32 | Sealed-cell bitmask, bit `i` = cell `i` (0..24); 1 = sealed, 0 = unlocked (`TheseusGodheadModel.isGridUnlocked`, `CM/mvc/module/theseus/TheseusGodheadModel.as:74-81`). Read only when present (`hasPosMark`, `:245-248`); send it in every response |
| tasks | 3 | SlateTaskMsg, repeated | `template_id (#1, INT32)` task id; `count (#2, INT32)` progress, **not read by the client**; `state (#3, INT32)`: the client stores it in `compeltedTasks[templateId]` and only tests `== 1` (= reward claimed) (`updateTaskInfo`, `:438-448`; `CM/yishi/datas/templates/TheseusSlateTaskInfo.as:29-45`) |
| property | 4 | SlatePropertyMsg | Totals of all equipped plates: `attack #1`, `defence #2`, `magic_attack #3`, `magic_defence #4`, `force_hit #5`, `parry #6`, `live #7`, `penetrate #8`, all INT32. Read only when present (`hasProperty`, `:421-434`) and only in the branches that call `onQueryShibanInfo` (opType 1, 3, 4, 9, 10, 11) |
| slates | 5 | SlateMsg, repeated | Plates, see below |

`SlateMsg` (`slate.SlateMsg`):

| Field | Tag | Type | Meaning |
|---|---|---|---|
| id | 1 | INT32 | Plate instance id (stoneId), unique per player |
| template_id | 2 | INT32 | `SlateTmpls.TemplateId`. The client derives `star = templateId % 10` in the merge branch (`:347, 386`) |
| pos | 3 | INT32 | Bag slot index, 0 or more when in the bag; -1 when the plate is gone (consumed). The bag view ignores it for ordering (it sorts by templateId, stoneId) |
| grade | 4 | INT32 | Level |
| star | 5 | INT32 | Star grade. Read only in the opType 2/6/7 branch (`onUplevShiban`, `:292-309`) |
| rotate | 6 | INT32 | 0..3, quarter turns clockwise |
| equip_pos | 7 | INT32 | Board anchor 0..24 when equipped. **Omit** (or send -1) for bag plates, because the client tests `hasEquipPos && 0 <= equipPos < 25` first (`:355, 409`) |
| is_lock | 8 | BOOL | Locked against decomposition |
| is_exist | 9 | BOOL | False when the plate was consumed |
| count | 10 | INT32 | Not read by the client |

Client branches on `opType` (`:250-274`):

| opType | Client function | Effect and server obligations |
|---|---|---|
| 1 | `clearPag()`, then `onQueryShibanInfo`, then `updateTaskInfo` | The bag is cleared and rebuilt. Equipped plates already known stay in the equipped list and are updated in place (`_equipedStoneInfo` is never cleared). Send **all** plates, all task states, `property`, `pos_mark` |
| 2, 6, 7 | `onUplevShiban` (`:292-309`) | For each slate: `getStoneById(id)` then overwrite `pos, level=grade, star, rotate, equipPos, isLock, isExist`. **Crash risk:** the client dereferences without a null check, so only send plates the client already knows. `star` must be sent (#5). `template_id` is ignored here |
| 3, 4, 9, 10, 11 | `onQueryShibanInfo` (`:311-436`) | Merge. Known plate: update fields (`star` from `templateId % 10`), then: (a) if `equip_pos` is valid and the old equipPos was -1, move it from bag to board; (b) else if `pos >= 0` and it was on the board, move it to the bag; (c) else if `pos == -1`, remove it from the bag. Unknown plate: create it from the template (name, quality=SlateProfile, icon, type=SlateType, shape=SlateShape, base and level stats) and put it on the board or in the bag. **Note:** for a known plate whose `template_id` changes (op 4), the client updates `templateId` and `star` but keeps the old name and base stats until the next opType 1 |
| 5 | `decomposeShiban` (`:278-290`) | `removeFromBag(id)` for each listed id. **Bug:** `removeFromBag` splices index 0 when the id is not found (`TheseusGodheadModel.as:129-152`), so list only ids that are in the bag |
| 8 | `updateTaskInfo` (`:438-448`) | Only the task states are refreshed |

After any branch the manager dispatches `EVENT_SLATE_UPDATE` with `opType`. Listeners:
- the frame refreshes the bag and the board (`TheseusgodAllFrame.as:643`);
- the upgrade view refreshes on any opType;
- the star-up view refreshes only on opType 4 (`TheseusGodheadStarUpView.as:432`);
- the task view re-sorts.

There is no result or error code. A rejected request should be answered with nothing, or with a generic tip from the core area *(open question)*. Never send a partial state that breaks the rules above.

### Related pushes owned by other areas

- Inventory item count changes: dust 30000000, key 30000001, task reward items. Read by `GoodsManager.getGoodsNumByTempId` in the upgrade and star-up views. Owner: `inventory`.
- Gold change after an upgrade. Owner: core player resources.
- Hero stat refresh when equipped plates change *(assumption: the hero or army property push of the core area)*.

---

## 5. Rules and formulas

### 5.1 Unlock and limits

| Rule | Value | Source |
|---|---|---|
| Feature unlock | Royalty level with `OpenSlate=1`: RoyaltyLevel 30 or more | `M5/theseus/view/ThereussoulEquipView.as:185-194`; `raw/xml/tempinfos/RoyaltyTemplates.xml` |
| Parent frame | Theseus main frame ("Alma de Teseu"), main toolbar button, hero grade 15 or more (`docs/ui/navigation.md` row `_archaeologyBtn`) | part A |
| Board | 25 cells (5x5), `gridCount = 25` | `TheseusGodheadModel.as:59-62` |
| Initial sealed cells | Unknown. The server owns `pos_mark` *(open question; suggestion: unlock the centre 3x3, cells 6,7,8,11,12,13,16,17,18)* | none |
| Unseal cost | 1 "Chave de Teseus" (item 30000001) per cell | `theseusgodhead.equipped_none.txt1`; `ItemTempInfos.xml` 30000001 "Usado para desbloquear placas seladas." |
| Bag capacity | The UI shows 72 cells (6 pages x 12). Plates beyond 72 exist but are not visible *(assumption: cap the bag at 72 and refuse grants beyond it, or mail them)* | `TheseusGodheadBagView.as:37-39` |
| Item lock (op 7) | Hero grade 10 or more and a vice password | `TheseusgodAllFrame.as:385-465` |

### 5.2 Plate templates and stats

- **SlateType** = number of cells, and the category name:
  - 1 "Placa de atributos" (shape 7, 1 cell);
  - 2 "Placa de habilidade passiva" (shape 6, 2 cells);
  - 3 "Placa de habilidade múltiplas" (shapes 4 and 5, 3 cells);
  - 4 "Placa de habilidade gatilho" (shapes 1, 2 and 3, 4 cells).

  Names come from `TheseusGodheadModel.getNamebySlateType` (`theseusgodhead.txt17..20`). Task texts say "placa de N slots" with `Part3 = SlateType`.
- **SlateProfile** = quality: 3 blue, 4 purple, 5 orange (client colours in `TheseusGodheadStoneInfo.getQualityColor`).
- **Star** = `SlateStarLevel` = `TemplateId % 10`, 0..5. Each family has 6 consecutive ids (e.g. 1000..1005 "Placa de corte").
- **Level cap** = `star*10 + 10`, so 10 at star 0 and 60 at star 5 (`CM/mvc/module/theseus/TheseusGodheadStoneInfo.as:192-195`).
- **Stat codes** in `SlateAttr` and `SlateLvAttr` (`parseSlateAttributes`, `TheseusGodheadModel.as:485-532`):

  | Code | Stat |
  |---|---|
  | 1 | Attack |
  | 2 | Defence |
  | 3 | MagicAttack |
  | 4 | MagicDefence |
  | 5 | ForceHit |
  | 6 | Penetrate |
  | 7 | Parry |
  | 8 | Live |
- **Plate stat at level L** = `SlateAttr[k] + L * SlateLvAttr[k]`. This is the client preview (`TheseusGodheadStoneInfo.getTotalAttributes`; upgrade preview `TheseusGodheadUpgradeView.as:228-343`).
- **SlatePropertyMsg** = sum over equipped plates *(assumption: the server uses the same formula; the client only displays the server totals)*.
- **Skills**: `SlateSkillTemplate` lists 0, 1 or 2 `SkillTempInfos` ids (e.g. 5500101 "Finalização"). They apply to the hero in battle while the plate is equipped *(assumption)*. Type 1 plates have skill 0.

### 5.3 Board placement

- **Shape grids at rotation 0** (`CM/mvc/module/theseus/TheseusSlateShapeInfo.as:39-66`; rows top to bottom):

  | Shape | Grid | Cells |
  |---|---|---|
  | 1 | `[[1,1,1],[0,1,0]]` | 4 (T) |
  | 2 | `[[1,0],[1,1],[0,1]]` | 4 (S) |
  | 3 | `[[0,1],[0,1],[1,1]]` | 4 (J) |
  | 4 | `[[1,0],[1,1]]` | 3 |
  | 5 | `[[1,1,1]]` | 3 |
  | 6 | `[[1,1]]` | 2 |
  | 7 | `[[1]]` | 1 |
- **Rotation**: `rotate` quarter turns clockwise (`rotateGrid`, `:102`).
- **Hit areas**: the board stone hit areas (`M5/theseusgodhead/UI/TheseusGodheadStoneUI.as:70, 320-430`) agree with these grids for shapes 1, 2 and 3. For shape 4 they **disagree**: the hit areas are `[[1,1],[0,1]]` at rotation 0, `[[0,1],[1,1]]` at 1, `[[1,0],[1,1]]` at 2, `[[1,1],[1,0]]` at 3. Shapes 5 to 7 have no hit area table. Choose one canonical table on the server *(open question; recommendation: the hit-area table for shape 4, because it is what the player sees)*.
- **Occupied cells** for anchor `a`: `{ (row(a)+r)*5 + col(a)+c : grid[r][c]==1 }`. The anchor is the top-left of the rotated bounding box.
- **Validity**: every occupied cell is on the board (`col(a)+width <= 5`, `row(a)+height <= 5`) and unsealed, and no cell is used by another equipped plate (excluding the plate itself when moving). The unused helper `TheseusSlateShapeHelper.canPlaceStone` (`CM/mvc/module/theseus/TheseusSlateShapeHelper.as:39`) implements bounds plus an "available" bitmask test with the same indexing.
- **Drop cell to anchor** (`getPosByShapeandRotate`, `TheseusGodheadModel.as:284-327`), where `p` is the cell under the cursor:

  | Shape | Rotation 0 or 2 | Rotation 1 or 3 |
  |---|---|---|
  | 1 | p-1 | p-5 |
  | 2 | p-5 | p-1 |
  | 3 | p-5 | p-1 |
  | 5 | p-5 | p-1 |
  | 4, 6, 7 | p | p |

  The server must accept any anchor value and validate it.

### 5.4 Level up ("Elevação")

- Template: `SlateUpgradeTmpls` row with key `EquipProfile = SlateProfile`, `EquipLv = level+1`, `Type = SlateType` (`CM/yishi/datas/templates/cate/TheseusSlateUpgradeCate.as`, key built from `@EquipProfile_@EquipLv_@Type`; lookup `TheseusGodheadStoneInfo.getUpgradeTemplateInfo`, `:364`).
- Cost: `Item` = `30000000,N` dust, plus `Consume` gold. The data always has Consume = 1000 x N.
- Allowed while `level < star*10 + 10`.
- Examples:
  - profile 5 type 4: level 1 costs 360 dust + 360 000 gold; level 60 costs 3 900 dust;
  - profile 3 type 1: level 1 costs 50 dust; level 60 costs 640 dust.
- Success is guaranteed *(assumption: no failure rate exists in the data)*.

### 5.5 Star up ("Promoção")

- Template: the `ComposeTempInfos.xml` row with `Types = 370` and `Material1 = templateId` (120 rows) (`TheseusGodheadStoneInfo.getStarUpMaterials`, `:197-230`).
- Consumes:
  - `Material2` x `Count2`: another plate with the **same template** (Count2 = 1), taken from the bag;
  - `Material3` x `Count3` dust (e.g. 4 500 for 1000→1001; 16 500 for 1004→1005);
  - `NeedGold = 0`.
- Requires `level >= NeedMinLevel`. NeedMinLevel = 10, 20, 30, 40, 50 = the current level cap.
- Result: the target plate becomes `NewMaterial` (templateId+1). It keeps its id, level, rotation, lock and board position *(assumption: the board footprint does not change because the shape is the same within a family)*.
- Server checks:
  - the material plate is in the bag (not equipped);
  - the material is not the target;
  - same templateId;
  - `is_exist`;
  - *(assumption)* not locked. The client does not exclude locked plates.

### 5.6 Tasks ("Missão")

- 16 rows in `SlateTaskTmpls`, all `TaskType=1`. Reward `30000001,1` (one key each). So 16 keys from tasks.
- **Completion** is computed by the client: count the plates (bag and board, `isExist`) with `level >= Part1` and `SlateType >= Part3`; the task is complete when the count `>= Part2` (`TheseusGodheadModel.getStoneCountWithLevel`, `:561-591`).
- **States**: 0 "not done" (button disabled), 1 "claimable" (button enabled), 2 "claimed" (stamp). State 2 = server `state == 1` (`TheseusSlateTaskInfo.get state`, `CM/yishi/datas/templates/TheseusSlateTaskInfo.as:29-45`).
- The server must recompute the same condition before paying, then store the claim.

### 5.7 Decompose

- Dust returned = `SlateDecomposition` count (e.g. `30000000,2250` for 1000) + Σ over L = 1..level of `int(Item_count(L) * 0.9)`, with the upgrade rows of the plate's profile and type. Gold is not refunded (`GodItemSellView.calculateSlateReward`, `M5/theseusgodhead/view/GodItemSellView.as:245-280`).
- **Note:** the client sums L from 1 to the current level, i.e. it includes the row "EquipLv = level", which is the cost paid to reach `level` from `level-1`. A level-0 plate returns only the base.
- Only bag plates that are not locked. All of them in one request.

### 5.8 Rotation and lock

- Rotation steps (rotate+1) mod 4 on bag plates only *(assumption: also reject equipped plates on the server)*.
- Lock toggles `is_lock`. Locked plates cannot be decomposed (client check `TheseusgodAllFrame.as:355-358`; enforce on the server).

---

## 6. Templates

| File (`raw/xml/tempinfos/`) | Loader | Record meaning | Fields used |
|---|---|---|---|
| `SlateTmpls.xml` (144 rows) | `TempleteManager._theseusSlateCate = TheseusSlateCate(getXmlListByName("SlateTmpls"))` (`CM/yishi/manager/TempleteManager.as:1374`) | One plate template per family and star | `TemplateId` (e.g. 1000..1005, 1010.., 2000.., 3000.., 4000..4075); `SlateName` ("Placa de corte"); `SlateProfile` quality 3..5; `SlateStarLevel` 0..5; `SlateType` 1..4 (= cell count, category); `SlateIcon`; `SlateAttr` base stats "code,value\|..." ("2,31\|4,31\|8,1170"); `SlateLvAttr` per-level stats ("2,31\|4,31\|8,1171"); `SlateSkillTemplate` CSV of skill ids ("5500101" or "5500201,5500301" or "0"); `SlateShape` 1..7; `SlateDecomposition` "30000000,count" (2250..36000 for profile 5 type 4) |
| `SlateUpgradeTmpls.xml` (360 rows = 6 profile/type pairs x 60 levels) | `TheseusSlateUpgradeCate` (`TempleteManager.as:1376`) | Cost to reach level `EquipLv` | `EquipProfile`, `Type`, `EquipLv` 1..60, `Consume` gold, `Item` "30000000,N". Pairs: (5,4) 360..3900, (4,4) 300..3250, (5,3) 220..2580, (4,3) 180..2540, (4,2) 120..1890, (3,1) 50..640 |
| `SlateTaskTmpls.xml` (16 rows) | `TheseusSlateTaskCate` (`TempleteManager.as:1375`) | Tasks | `TemplateId` 1..16; `TaskDescription` (e.g. "Fortalecer 1 placa de 4 slots até o Nv.10"); `TaskType` 1; `Part1` min level; `Part2` count; `Part3` min SlateType; `TaskReward` "30000001,1" |
| `ComposeTempInfos.xml` rows `Types=370` (120 rows, Id 3701000..3704039) | `TempleteManager.getComposeTempleteList()` | Star-up recipes | `Material1` source template, `Material2`/`Count2` duplicate plate x1, `Material3`/`Count3` dust, `NeedMinLevel`, `NewMaterial`, `NeedGold` 0 |
| `ItemTempInfos.xml` | goods templates | Currencies and items | 30000000 "Poeira de placa" (MasterType 2, SonType 1100, MaxCount 9999); 30000001 "Chave de Teseus"; boxes 30000002 "Baú de poeira de placa" (dust x200), 30000003 "Baú aleatório de placa roxa de 4 estrelas", 30000004..30000006 "Baú divino básico/intermediário/avançado", 30000008 "Baú “?”", 30000009 "Baú bloqueado", 30000010 "Baú divino", 30000011 "Saco grande de poeira de placa", 30000012 "Baú divino roxo aleatório"; display items 3001xxxx..3004xxxx (MasterType 15, SonType 800, `Property1` = slate template id, e.g. 30010000 → 1000) |
| `SkillTempInfos.xml` | `TempleteManager.getSkillById` | Plate skills | `TemplateName`, `Description` (shown in "Bônus de habilidade") |
| `RoyaltyTemplates.xml` | `RoyaltyTempCate.getTempInfoByLevel` (`CM/yishi/datas/templates/cate/RoyaltyTempCate.as:129`) | Unlock | `OpenSlate` |

---

## 7. Persistent state

Schema `theseus`.

```sql
CREATE TABLE theseus.slate_board (
  player_id     integer PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
  sealed_mask   integer NOT NULL CHECK (sealed_mask >= 0 AND sealed_mask < 33554432), -- 25 bits, 1 = sealed
  next_slate_id integer NOT NULL DEFAULT 1,
  created_at    timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE theseus.slates (
  player_id    integer  NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  slate_id     integer  NOT NULL,                     -- SlateMsg.id, per player
  template_id  integer  NOT NULL,                     -- SlateTmpls.TemplateId
  level        smallint NOT NULL DEFAULT 0 CHECK (level BETWEEN 0 AND 60),
  rotation     smallint NOT NULL DEFAULT 0 CHECK (rotation BETWEEN 0 AND 3),
  bag_slot     smallint CHECK (bag_slot >= 0),        -- NULL when equipped
  board_anchor smallint CHECK (board_anchor BETWEEN 0 AND 24), -- NULL when in the bag
  is_locked    boolean  NOT NULL DEFAULT false,
  obtained_at  timestamptz NOT NULL DEFAULT now(),
  PRIMARY KEY (player_id, slate_id),
  CHECK ((bag_slot IS NULL) <> (board_anchor IS NULL))
);
CREATE INDEX slates_equipped ON theseus.slates (player_id) WHERE board_anchor IS NOT NULL;
CREATE INDEX slates_template ON theseus.slates (player_id, template_id) WHERE board_anchor IS NULL;

CREATE TABLE theseus.slate_task_claims (
  player_id   integer  NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  task_id     smallint NOT NULL,                      -- SlateTaskTmpls.TemplateId
  claimed_at  timestamptz NOT NULL DEFAULT now(),
  PRIMARY KEY (player_id, task_id)
);
```

- Consumed plates are deleted, not flagged. The `is_exist=false` in the response is built from the deleted row.
- The cell occupancy is derived from `slates` (anchor + shape + rotation). Optionally cache it as a 25-bit `occupied_mask` in `slate_board`.
- The dust, key and gold balances live in the inventory and player resource tables.

---

## 8. Backend implementation notes

### Handlers (one per op of 9762)

All handlers:
- load `slate_board` (create it on first access with the initial `sealed_mask`) and refuse when the royalty level has `OpenSlate=0`;
- after commit, send 1024 with `op_type = op`, `pos_mark` and, where noted, `property`.

| Handler | Op | Validation order | Transaction and response |
|---|---|---|---|
| `theseus::godhead::handle_query` | 1 | unlock | read only; 1024 with all slates (board ones with `equip_pos`, bag ones with `pos` and no `equip_pos`), all 16 task states (`state=1` if claimed, else 0), `property` |
| `theseus::godhead::handle_unlock_cell` | 2 | pos in 0..24 → cell sealed → key 30000001 count >= 1 | tx: consume 1 key (inventory), clear the bit. Response: `pos_mark`, empty `slates` |
| `theseus::godhead::handle_level_up` | 3 | plate exists → level < star*10+10 → upgrade row exists → dust >= N → gold >= Consume | tx: debit dust and gold, level+1. Response: the plate, `property` (recompute if equipped). Push the gold and item changes |
| `theseus::godhead::handle_star_up` | 4 | target exists → star < 5 (a Types 370 row exists) → level >= NeedMinLevel → material id != target, material in bag, same template_id, not locked *(assumption)* → dust >= Count3 | tx: delete the material, debit dust, set target template_id = NewMaterial. Response: target (new template_id, unchanged grade) + material (`pos=-1`, `is_exist=false`, no `equip_pos`), `property` |
| `theseus::godhead::handle_decompose` | 5 | ids non-empty, distinct → each in bag (not equipped) → not locked | tx: delete the rows, credit dust = Σ formula §5.7. Response: `slates` with only the ids |
| `theseus::godhead::handle_rotate` | 6 | plate exists and is in the bag *(assumption)* | tx: rotation = (rotation+1) mod 4. Response: the plate with all fields incl. `star` |
| `theseus::godhead::handle_toggle_lock` | 7 | plate exists → *(assumption)* the vice password session check of the account area | tx: flip is_locked. Response: the plate incl. `star` |
| `theseus::godhead::handle_claim_task` | 8 | task exists → not claimed → condition §5.6 true on the server state | tx: insert the claim, grant `TaskReward` (inventory). Response: `tasks` (all 16, or at least the claimed one with `state=1`) |
| `theseus::godhead::handle_move_legacy` | 9 | treat as op 11 *(assumption)* | as op 11 |
| `theseus::godhead::handle_place` | 10 | plate exists → compute the occupied cells for (shape, rotation, anchor) → all in bounds → none sealed → no overlap with other equipped plates | tx: set board_anchor, clear bag_slot. Response: the plate with `equip_pos`, `property` |
| `theseus::godhead::handle_unequip` | 11 | plate exists and is equipped → a free bag slot exists (capacity 72, assumption) | tx: board_anchor NULL, bag_slot = lowest free. Response: the plate with `pos` and no `equip_pos`, `property` |

### Other notes

- **Transactions.** Each handler is a single DB transaction, including the inventory and gold debits. Rejections send nothing.
- **Hero stats and battles.** On any change of the equipped set or of an equipped plate's level or template:
  - recompute the slate totals and add them to the hero's combat properties;
  - push the hero property refresh of the core area *(assumption)*;
  - battle setup (`docs/battle/server-engine.md`) adds the skills of `SlateSkillTemplate` of equipped plates to the player hero *(assumption)*.
- **No timers, resets or schedules.**
- **No pushes to other players.**
- **Grants from other features** (dungeon chests, shops, boxes): insert slate rows. If the player is online and has opened the frame this session, push 1024 with `op_type=3` and the new plates (merge branch) *(assumption)*.

---

## 9. Open questions and assumptions

1. Initial `pos_mark` (which cells are open at unlock) and whether unsealing has an order constraint. Not in client data.
2. Shape 4 footprint: the shape helper and the hit-area table disagree (§5.3). Shapes 5 and 6 bitmap orientation vs. the drop-anchor table (`getPosByShapeandRotate` uses p-5 for shape 5 at rotation 0, which fits a vertical bar, while the shape grid is horizontal).
3. Whether the server sends `star` in all responses (the merge branch ignores it, the opType 2/6/7 branch needs it). The recommendation is always.
4. Bag capacity (72 visible) and what happens to grants beyond it.
5. Whether locked or equipped plates may be used as star-up material, rotated or decomposed (the client allows a locked material).
6. Decompose formula off-by-one (§5.7): the client preview includes the cost row of the current level.
7. How plate stats and skills enter battles and combat power.
8. Server-side error channel (no result code in 1024).
9. **Registry overlap:** the `slate` proto is listed under `inventory` in `roadmap/features.json` but used only here.
10. Opcode 9762 is missing from `protocol/opcodes.csv`. The name comes from `ProtocolType.as:1486`.
11. Client display bug after a star-up: name and base stats stay stale until the next full query. The server needs nothing; a client fix is optional.

---

## 10. Implementation checklist

**Screens (client already exists; verify against the backend):**

- [ ] "Divino" button visibility by OpenSlate (royalty level 30)
- [ ] `TheseusgodAllFrame` opens and sends op 1; tabs; bag pages 1..6
- [ ] Board: sealed cells, unseal confirm (op 2), equipped plates, per-type summary text
- [ ] Bag: sort, drag to board (op 10), rotate mode (op 6), decompose mode
- [ ] `TheseusGodheadUpgradeView` (op 3) with cost display
- [ ] `TheseusGodheadStarUpView` (op 4) with material checks
- [ ] `TheseusGodheadTaskView` (op 8) states and sorting
- [ ] `GodItemSellView` (op 5) preview total matches server credit
- [ ] Item lock flow with vice password (op 7)
- [ ] `TheseusGodheadFrame` "Bônus total" (stats + skills)

**Routes:**

- [ ] 9762 op 1 `handle_query`
- [ ] 9762 op 2 `handle_unlock_cell`
- [ ] 9762 op 3 `handle_level_up`
- [ ] 9762 op 4 `handle_star_up`
- [ ] 9762 op 5 `handle_decompose`
- [ ] 9762 op 6 `handle_rotate`
- [ ] 9762 op 7 `handle_toggle_lock`
- [ ] 9762 op 8 `handle_claim_task`
- [ ] 9762 op 9 `handle_move_legacy` (alias)
- [ ] 9762 op 10 `handle_place`
- [ ] 9762 op 11 `handle_unequip`

**Server messages:**

- [ ] 1024 `UserSlateMsg` builder: op_type echo, pos_mark always, property where required, slates with correct `equip_pos` omission, star always
- [ ] Inventory pushes for dust, key and reward items; gold push; hero stat refresh

**Tables:**

- [ ] `theseus.slate_board`
- [ ] `theseus.slates`
- [ ] `theseus.slate_task_claims`

**Rules and templates:**

- [ ] Loaders: SlateTmpls, SlateUpgradeTmpls, SlateTaskTmpls, ComposeTempInfos Types 370, RoyaltyTemplates.OpenSlate
- [ ] Shape table and rotation (§5.3), placement validation
- [ ] Level cap star*10+10; upgrade cost lookup (profile, level+1, type)
- [ ] Star-up recipe; decompose formula; task condition

**Tests:**

- [ ] Place every shape at every rotation on all anchors; reject overlap, sealed cells and out-of-bounds
- [ ] Level up to the cap, then refuse; star up at the cap with a duplicate; refuse without a duplicate or dust
- [ ] Decompose returns the exact preview total; locked plates refused
- [ ] Task claim only when the condition holds; double claim refused
- [ ] op 2 without a key refused; op 2 on an open cell refused
- [ ] Response shapes never trigger the client null dereference (opType 2/6/7 with unknown ids) or the index-0 splice (opType 5 with ids not in the bag)
