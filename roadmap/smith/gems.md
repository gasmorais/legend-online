# Smith: Gemas (inlay, sockets, removal, Selo da Alma, gem synthesis rules)

Path aliases:

| Alias | File |
|---|---|
| MV | `decompiled/m14/scripts/store/mount/MountView.as` |
| JC | `decompiled/core_module/scripts/cell/view/storebag/StoreJewelCell.as` |
| SC | `decompiled/core_module/scripts/mvc/controler/StoreControler.as` |
| SSOM | `decompiled/core_module/scripts/managers/StoreSocketOutManager.as` |
| SSM | `decompiled/core_module/scripts/yishi/service/managers/SocketSendManager.as` |
| BH | `decompiled/core_module/scripts/bag/helper/BagHelper.as` |
| CLK | `decompiled/core_module/scripts/cell/mediator/storebag/StoreBagCellClickMediator.as` |
| DRP | `decompiled/core_module/scripts/cell/mediator/storebag/StoreBagCellDropMediator.as` |
| JF | `decompiled/m5/scripts/armyII/viewII/equip/JewelFrame.as` |
| GH | `decompiled/core_module/scripts/yishi/utils/GoodsHelp.as` |
| PM | `decompiled/core_module/scripts/yishi/manager/PlayerManager.as` |
| CMV | `decompiled/m14/scripts/store/compose/ComposeMatetialView.as` |
| SM | `decompiled/core_module/scripts/mvc/module/store/StoreModel.as` |

## 1. Overview

Gem handling on equipment:
- Inlay ("Inserção"): every equipment has 4 sockets (`StoreModel.EQUIP_HOLE_NUMBER = 4`, `SM:17`). Socket state is carried by the item fields `join1..join4`: `-1` closed, `0` open and empty, `> 0` template id of the inserted gem. Sockets are opened ("Perfurar") with the item "Perfurador" (208004), gems are inserted for free, removed or replaced for gold (gem template `Property3`). Socket 4 needs an epic (Profile >= 5) equipment. Help (`store.StoreControler.helpContent02`): "Probabilidade de sucesso de inserção é 100%", "Gemas já inseridas podem ser retiradas ou diretamente substituídas consumindo ouro", "Inserir/Perfurar mudará estado de itens livre para vinculado".
- Selo da Alma ("Selo da Alma", `JewelFrame`): a hero level track that multiplies gem effects ("Efeito de gema +{0}%"), raised by consuming "Cristal de Almas" (208014), then a senior track with the item "Selo da Alma" (208031) after the first track reaches 80 and the hero advanced job. Route 8484 `C_BAG_USESTORE`.
- Gem synthesis: done through the generic compose route (recipe Types 3, 6, 8, 12), documented in [compose.md](./compose.md); gem specific rules are in section 5 here. The one key gem compose of the secretary (9741) is owned by [../secretary/README.md](../secretary/README.md).

Gems used by the smith inlay: SonType 205 (single attribute "Gema de Ataque Nv. 1" etc.) and SonType 228 (double attribute "Gema de Ataque e Crítico Nv.7" etc.). Other gem families (SonType 312 resistance "Proteção do Fogo", 329/343/344 "Alma Divina", 224 "Ágata") are synthesized in the smith but inserted by other features (pets, guardians, battle guard).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `MV` `store.MountView` | sub tab inlay; strip tip "Função habilitada no Nv. 15" below level 15 | Equipment cell `store.MountEquiItem` (workspace slot 0), 4 socket cells `store.mount.JewelItem1..4`, remove gem button `store.MountRemoveJewelBtn` (`MV:78-122`) | `StoreView1` tab 1 (`STORE_PANEL_MOUNT`) | Job recommendation: job 1 "Recomenda-se inserção de gemas: ataque, defesa, resistência, vida", job 2 "... ataque, crítico, liderança, vida", job 3 "... magia, defesa, resistência, vida" (`MV:134-147`); socket 4 tip "Habilitado em item épico" (or "Ainda não abriu" for dragon equipment) (`MV:154-191`); closed socket tooltip "Clique para perfurar" (`MV:193-200`) |
| `JC` `StoreJewelCell` | button "Perfurar" (`cell.view.storebag.jewelcombox`) | One socket. Background frame 1 closed, 2 open, 3 locked epic slot; shows the inserted gem icon (`JC:96-200`) | `MV` | `join<index>` of the slot 0 equipment |
| Remove cursor mode (`BH.removeJewel`) | cursor `REMOVE_CURSOR_UP`; confirm "Retirar gema consumirá {0} ouro, continuar?" (`bag.helper.BagHelper.content03`) | Click a filled socket to remove its gem (`BH:612-695`) | `MV` remove button (`MV:216-220`) | |
| Confirm replace | "Substituir gema consumirá {0} ouro, substituir?" (`store.StoreControler.content`) | Insert onto a filled socket (`SC:289-312`) | drop on socket | old gem `Property3` |
| Confirm punch | "Consumir 1 perfurador?" (`store.StoreControler.content02`) | Open a socket (`SC:425-458`) | "Perfurar" | |
| Quick buy `quickbuy.buyFrame` (`BuyFrameI`) | | Buy a Perfurador when none is owned (after tip "Não há perfurador, não é possível perfurar") (`SC:454-467`) | punch without tool | shop row of 208004, see [../shops/README.md](../shops/README.md) |
| `JF` `army.JewelFrame` | "Selo da Alma" (`armyII.viewII.equip.JewelFrame.JewelTitleTxt` / `JewelTitleTxt02`) | Raise the gem effect track | Army equipment view "jewel" button (`decompiled/m5/scripts/armyII/viewII/equip/EquipView.as:1019-1023`) -> `ArmyControler.openJewelFrame` (`decompiled/core_module/scripts/mvc/controler/ArmyControler.as:288-297`) | Level, exp bar `gp / Data`, "Nível atual:" "Efeito de gema +X%", "Próximo:" next effect or "Nível máximo atingido", "Quantidade de consumo:" input (digits only, clamped to owned count), "Atualmente Cristal de Almas: N", alert "Consumir“{0}”Pode aumentar {1} Nv.para aumentar as propriedades de Jóias em equipamento." (`JF:96-160,262-328`) |

## 3. Routes (client to server)

Placing the equipment into workspace slot 0: [store-frame.md](./store-frame.md) R1/R2 (MOUNT filter: SonType 205, 228, 299, or MasterType 1 with SonType != 109; a dropped equipment must be MasterType 1, `DRP:188-202`).

### R1. Insert a gem by drag and drop on a socket
- UI: drag a gem from `StoreBagII` onto a `StoreJewelCell` (`DRP:155-187`).
- Client checks, in order:
  1. Workspace empty -> "Selecione primeiro o equipamento" (`DRP:157-163`).
  2. Socket locked (`lock`) -> ignored; socket closed (`notOpen`) -> "Perfure primeiro" (`DRP:164-175`).
  3. Dragged item is equipment or the Perfurador (SonType 299) -> "Tipo de acessório incorrespondente" (`DRP:176-182`).
  4. `SC.mountJewel` -> `SC.checkType` (`SC:330-398`): if another socket already holds a gem of the same SonType and same attribute (205: same `Property1`; 228: same `Property1` and `Property2`) and that socket is not the target -> "Não é possível inserir gemas de mesmo tipo".
  5. Target socket filled -> confirm "Substituir gema consumirá {0} ouro, substituir?" with the old gem `Property3`; on confirm, gold `< Property3` -> "Ouro Insuficiente" (`SC:299-328`).
- Sender: `SC.sendItemMount(socket, gemPos, gemBag)` -> `SC.inlayConfirm` -> `SSOM.sendItemMount` (`SC:499-510`, `SSOM:50-58`).
- Route: client to server, 5151 (0x141f) `U_C_ITEM_INLAY`, `store.StoreReqMsg`:
  - `mount_pos` (#5, INT32) = socket index 1..4.
  - `bag_type` (#3, INT32) = gem bag (1 or 34).
  - `bag_pos` (#4, INT32) = gem slot.
  - Unused: `hole_pos` (#1), `operate` (#2), `compose_id` (#6), `compose_num` (#7), `auto_buy` (#8), `src_itemid` (#9), `des_itemid` (#10), `count` (#11), `pay_type` (#12), `opType` (#13).
- Expected response, in order: 115 `U_C_BAG_MOVE_UPDATE` (equipment in bag 0 slot 0 with new `join_N` and `bind`; gem stack decremented; old gem returned to a bag on replace), 87 `U_C_ITEM_INLAY` (S1), 109 gold update on replace.

### R2. Insert a gem by double click
- UI: double click a gem (SonType 205 / 228) in `StoreBagII` while on MOUNT (`CLK:106-109,325-453`).
- Client checks: equipment present in slot 0 (otherwise the double click is swallowed); same type rule as R1 (messages "Não é possível inserir gemas de mesmo tipo"); a free open socket must exist (`join == 0`), else "Não há buraco disponível". The client also refuses dragon equipment with "As Pérolas do Dragão apenas podem ser inseridas nos Equipamentos do Dragão." (`CLK:341-347`), but that branch reads the never assigned `GoodsInfo.isViceEquip` and never runs.
- Route: 5151 as in R1 with `mount_pos` = first socket whose `join == 0` (`CLK:434-447`). No replace confirmation in this path.

### R3. Open a socket (punch)
- UI: "Perfurar" button on a closed socket (`JC:56-62`) -> `SC.openHole(pos)` (`SC:425-458`).
- Client checks: a Perfurador 208004 in bag 1 or bag 6 (guild bag) must exist; otherwise tip "Não há perfurador, não é possível perfurar" and open quick buy for 208004; after a successful purchase callback the punch is sent directly (`SC:460-467,482-488`). With the tool: confirm "Consumir 1 perfurador?".
- Sender: `SocketSendManager.sendPunch(pos, true, flag)` -> `PunchConfirm` (`SSM:318-343`).
- Route: client to server, 5152 (0x1420) `U_C_ITEM_INLAYJOIN`, `store.StoreReqMsg`:
  - `hole_pos` (#1, INT32) = socket index 1..4.
  - `operate` (#2, BOOL) = true (open socket).
  - `pay_type` (#12, INT32) = 0 when `flag` is true, 1 otherwise. The quick buy path uses the default `flag = true` (0); the confirm path passes the alert's second callback value (`SC:474-480`), false for a plain alert (1).
- Expected response: 115 (equipment `join_N` from -1 to 0, item bound; one Perfurador consumed), 88 `U_C_ITEM_INLAYJOIN` (S2).

### R4. Remove a gem
- UI: double click a filled socket (`JC:64-94`) or the remove button then click a socket (`BH:612-695`). Confirm "Retirar gema consumirá {0} ouro, continuar?" with the gem `Property3`; gold check "Ouro Insuficiente".
- Sender: `SocketSendManager.sendPunch(pos, false)` (`JC:92`, `BH:693`).
- Route: 5152 (0x1420) `U_C_ITEM_INLAYJOIN`, `StoreReqMsg`: `hole_pos` (#1) = socket 1..4, `operate` (#2) = false, `pay_type` (#12) = 0.
- Expected response: 115 (equipment `join_N` -> 0; gem added to the stone bag 34 or bag 1), 88 (S2), 109 gold.

### R5. Raise the Selo da Alma
- UI: `JF` confirm button (`JF:189-202`).
- Client checks: amount input clamped to the owned count of SonType 293 (or 318 for the senior track) in bag 1 (`JF:204-231,262-265`); button disabled at max level or when the amount is 0; senior track also requires `seniorStoreGrade < vocationLevel * 10` (`JF:306`).
- Route: client to server, 8484 (0x2124) `C_BAG_USESTORE`, `item.ItemUseStoreReqMsg`:
  - `count` (#1, INT32) = number of items to consume.
  - `templateId` (#2, INT32) = 208014 ("Cristal de Almas") or 208031 ("Selo da Alma") when `isHighLevel` (`jewelGrades >= 80` and `vocationGrades > 0`, `JF:139-151`).
- Expected response: 115 (items consumed), 3 `U_C_PLAYER_INFO` with the new grade / gp (S3). `item.ItemUseStoreRspMsg` (`result` #1 BOOL) exists but no accept opcode uses it.

### R6. Gem synthesis
- Generic compose 5153 `U_C_ITEM_COMPOSE` with `auto_buy` (#8) true when the player presses "Sintetizar Agora" (`_promptlyBtn`, `CMV:292-308`). Full route and response 89 in [compose.md](./compose.md). Gem specific rules in section 5.

### R7. One key gem compose (secretary)
- 9741 (0x260d) `C_GEM_ONE_KEY_COMPOSE`, `player.PlayerOpMsg` with `op` (#1, INT32) = 0 to query the gold cost (`SecretaryManager.gotoGetGemNum`, `decompiled/core_module/scripts/managers/SecretaryManager.as:82-88`, sent by `decompiled/m11/scripts/secretary/LittleSecretaryFrame.as:72`) or 1 to execute (`decompiled/core_module/scripts/mvc/module/secretary/acts/GemAction.as:15-22`). Response 593 `U_C_GEM_ONE_KEY_COMPOSE_NEED_GOLD` (`player.NeedGoldMsg`, `gold` #1 INT32), receiver `SecretaryManager.gemGoldHandler` (`SecretaryManager.as:61,74-80`). Shown when level >= 15 and gold > 0 (`decompiled/core_module/scripts/mvc/module/secretary/SecretaryItemData.as:107-108`). Owned by [../secretary/README.md](../secretary/README.md); the server logic should reuse the gem recipes of section 5.

## 4. Server messages (server to client)

### S1. 87 (0x0057) `U_C_ITEM_INLAY`
- No client listener in this build. Assumption: `store.StoreRspMsg` with `streng_result` (#3, BOOL) = success, `pos` (#5) = 0, `objectId` (#6) = 0, `bagType` (#7) = 0; the other fields (`compose_result` #1, `compose_templateId` #2, `strengthenGrade` #4, `strBlessValue` #8, `gp` #9) unset. The UI refreshes from 115 only (`MV:222-231`).
- When: response to R1/R2. Errors: 126 `U_C_MSG`.

### S2. 88 (0x0058) `U_C_ITEM_INLAYJOIN`
- No client listener. Same assumption as S1. When: response to R3/R4.

### S3. 3 (0x0003) `U_C_PLAYER_INFO` (Selo da Alma fields)
- Message `player.PlayerMsg` (full definition in [../hero/README.md](../hero/README.md)); smith fields: `storeGrade` (#61, INT32) Selo da Alma level, `storeGp` (#62, INT32) progress, `seniorStoreGrade` (#88, INT32), `seniorStoreGp` (#89, INT32).
- Receiver: `PM.__uPlayerInfoHandler` (`PM:150,496`, fields at `PM:789-820`). Client quirk: `storeGrade` is applied only when `grades` (#16) is present and `storeGp` only when `grade_process` (#31) is present (`PM:789-804`), so the server must include `grades` and `grade_process` in the same message. Setters dispatch `JEWELGRADES_UPDATE`, `JEWELGP_UPDATE`, `SENIORSTOREGRADE_UPDATE`, `SENIORSTOREGP_UPDATE`, which refresh `JF` (`JF:163-174,233-244`).
- When: after R5, and at login.

### S4. 115, 109, 593
- 115 `U_C_BAG_MOVE_UPDATE` and 109 `U_C_CASTLE_UPDATE`: see [store-frame.md](./store-frame.md) S2/S4. `MV` refreshes sockets from `UPDATE_BAG` / `DELETE_BAG` on slot 0 (`MV:202-242`).
- 593: see R7.

## 5. Rules and formulas

Socket state (`JC:96-200`):

| `joinN` | Meaning | UI |
|---|---|---|
| -1 | closed | "Perfurar" button; socket 4 on a non epic item shows locked frame 3 without button |
| 0 | open, empty | drop target |
| > 0 | gem template id | gem icon, double click removes |

- Socket 4 is usable only when `Profile >= 5` (epic, normal equipment) or `Profile >= 4` (dragon equipment, template `Job = "99"`); otherwise the client shows "Habilitado em item épico" / "Ainda não abriu" and never offers the punch (`JC:118-178`, `MV:160-177`). Compose upgrade to epic "permite a inserção 4 gemas" ([compose.md](./compose.md)).
- Server validation for punch: socket index 1..4, state -1, socket 4 rule above, consume 1 x 208004 (bag 1 first, guild bag 6 accepted by the client check). `pay_type` semantics are not determinable; Assumption: 0 = consume a bound Perfurador first, 1 = unbound first. The string "Deseja consumir {0} diamantes para abrir novo slot?" (`store.StoreControler.content04`) exists but is unused.
- Inlay: gem must be SonType 205 or 228 (MasterType 2), socket open (0) or filled (replace). No gold for an empty socket (constant `MOUNT_JEWEL_CUNSUME = 1000` is unused). Replace costs the old gem `Property3` gold and returns the old gem to the bags.
- Same type rule: no two 205 gems with the same `Property1` (attribute) and no two 228 gems with the same attribute pair on one item (`SC:330-398`, `CLK:368-386`). Assumption: also forbid a 205 gem whose attribute is already covered by a 228 gem only if the original server did; the client does not check it (the counting dictionary `mountTypeDic` is built but its result `command09` "O equipamento tem {0} gemas de atributos, não pode inserir." is never reached).
- Removal costs the gem `Property3` gold (200 for level 1, 500 level 2, 1000 level 3, 2000 level 4, ..., 10000 level 12; double gems 5000..8000; `StoreModel.REMOVE_JEWEL_CUNSUME = 50` unused).
- Binding: inlay and punch bind the equipment (help text; string "Item não vinculado, se inserir tornará vinculado, inserir?" exists but is unused).
- Gem effect: each gem adds its attribute value to the equipment; the Selo da Alma percentage multiplies gem attributes. Attribute values per gem level are not in the client templates (only `Property1` attribute type and `Property6` level). Open question.
- Attribute codes (`Property1` of SonType 205, `SC:400-423`): 1 "Ataque", 2 "Defesa", 3 "Magia", 4 "Resistência", 5 "Crítico", 6 "Vida", 7 "Líder", 8 "Bloqueio". Template ids `205TTLL` (TT attribute 01..08, LL level 01..12). Double gems `228xxLL` have a combined code in `Property1` and their component gems in `Property5` / `Property6` (used by decompose, [decompose.md](./decompose.md)).

Selo da Alma (`JF`, `GH:85-117`):
- Normal track: level `storeGrade` 0..80; each consumed 208014 adds GP (Assumption: `Property1` = 1 GP per item); level up when GP reaches `UpGradeTempInfos` row `Types = 15`, `Grades = level + 1`, `Data` (10 at level 1 ... 5500 at level 80); no row -> max ("Nível máximo atingido").
- Effect percent: `g <= 50: 2g`; `g <= 70: (g-50)*3 + 100`; `g <= 80: (g-70)*4 + 160` (max 200%).
- Senior track (unlocked when `storeGrade >= 80` and `vocationGrades > 0`): item 208031 (SonType 318), `UpGradeTempInfos` `Types = 104` (10 ... 720 at level 80), cap `seniorStoreGrade < vocationLevel * 10`; effect `g <= 50: 2g + 200`; `g <= 70: (g-50)*3 + 300`; `g <= 80: (g-70)*4 + 360`.
- Assumption: GP is per level progress (reset on level up, overflow carried).

Gem synthesis rules (recipes in `ComposeTempInfos.xml`, route in [compose.md](./compose.md)):

| Recipe Types | Result SonType | Example | Notes |
|---|---|---|---|
| 3 | 205 (88 recipes), 228 (36) | 4 x "Gema de Ataque Nv. 1" + 50 gold -> "Gema de Ataque Nv. 2" (recipe 33, level 5); 1 x Ataque Nv.7 + 1 x Crítico Nv.7 + 1000 gold -> "Gema de Ataque e Crítico Nv.7" (recipe 600, level 30) | listed in the gem tab (`SC:175-178`) |
| 6 | 312 resistance gems (84) | 100 x 208028 + 1000 gold -> "Proteção do Fogo Nv.1" (level 55) | `COMPOSE_TYPE_RESIS_GEM` |
| 8 | 329, 343, 344 "Alma Divina" (85) | 4 x "Alma Divina ataque nv.3" + 10000 gold -> nv.4 | `COMPOSE_TYPE_PET_GEM` |
| 12 | 224 "Ágata" (88) | 4 x 2240101 + 50 gold -> "Ágata do Ataque Físico" (level 70) | `COMPOSE_TYPE_CHILD_GEM` |

- Gem recipes always allow at least quantity 1 even with no materials (`SM:393-411`), because "Sintetizar Agora" can buy the missing gems.
- "Sintetizar Agora" (`auto_buy` true) is available for Types 3 and 6 when the result gem level (last two digits of `NewMaterial`) is not the lowest buyable one (`_cannotGrade` = 2 for Types 3, 1 for Types 6, `CMV:820-880`). The client computes the diamond price by walking the recipe chain down (up to 11 levels) until a level is sold in the shop, price = shop price x missing count, with the time limited discount (`CMV:398-560`); it confirms "quantidade de itens insuficientes, quer gastar {0} diamantes para comprar {1} itens necessários para sintetização?" (+ "Loja - Liquidação de Gemas, economize {0} diamantes" when discounted). Without auto buy and missing materials: "Materiais desbloqueados insuficientes". The server must recompute the price (never trust the client).
- Locked items are not counted as materials (`getGoodsNumByTempIdAndNotLock`).
- Recipe scroll items "Fórmula de Gema - <attr> Nv. N" (SonType 208, `Property1` = recipe id, e.g. 2110001 -> recipe 1001 "Ataque Nv.4 -> Nv.5", 64 items) exist in `ItemTempInfos.xml`; the client "already learned" check looks at SonType 211 instead (see [compose.md](./compose.md)).

Quest: task condition type 18 progresses on inlay ([../quests/README.md](../quests/README.md)).

## 6. Templates

| File | Record | Fields |
|---|---|---|
| `raw/xml/tempinfos/ItemTempInfos.xml` | SonType 205 (96 rows), 228 (36) | `Property1` attribute (or pair code), `Property3` removal / replace gold, `Property5` / `Property6` component gems (228), `Property6` level (205), `Profile` |
| same | 208004 "Perfurador" (SonType 299) | punch tool |
| same | 208014 "Cristal de Almas" (SonType 293), 208031 "Selo da Alma" (SonType 318) | `Property1` = 1 (GP per item, Assumption) |
| same | equipment | `Profile` (socket 4 rule), `Job` ("99" dragon), `SonType` (109 excluded from inlay) |
| `raw/xml/tempinfos/UpGradeTempInfos.xml` | `UpGradeTempInfo` `Types` 15 (81 rows, grades 0..80) and 104 (81 rows) | `Grades`, `Data` = GP to reach the grade |
| `raw/xml/tempinfos/ComposeTempInfos.xml` | Types 3, 6, 8, 12 | `Material1..4`, `Count1..4`, `NewMaterial`, `NeedGold`, `NeedMinLevel` |
| `raw/xml/tempinfos/ShopTempInfos.xml` | shop rows of gems / Perfurador | price for auto buy and quick buy ([../shops/README.md](../shops/README.md)) |

## 7. Persistent state

Assumption: `inventory.items` may already own `join_1..join_4`; otherwise:

```sql
CREATE TABLE smith.item_sockets (
    item_id          BIGINT   NOT NULL REFERENCES inventory.items(item_id) ON DELETE CASCADE,
    socket_index     SMALLINT NOT NULL CHECK (socket_index BETWEEN 1 AND 4),
    state            SMALLINT NOT NULL DEFAULT -1 CHECK (state IN (-1, 0, 1)), -- -1 closed, 0 open empty, 1 filled
    gem_template_id  INTEGER,                                               -- pushed as join_N when filled
    updated_at       TIMESTAMPTZ NOT NULL DEFAULT now(),
    PRIMARY KEY (item_id, socket_index),
    CHECK ((state = 1) = (gem_template_id IS NOT NULL))
);
CREATE INDEX item_sockets_gem_idx ON smith.item_sockets (gem_template_id) WHERE gem_template_id IS NOT NULL;

CREATE TABLE smith.player_soul_seal (
    player_id           BIGINT   PRIMARY KEY REFERENCES player.players(player_id),
    grade               SMALLINT NOT NULL DEFAULT 0 CHECK (grade BETWEEN 0 AND 80),        -- PlayerMsg.storeGrade
    gp                  INTEGER  NOT NULL DEFAULT 0 CHECK (gp >= 0),                       -- PlayerMsg.storeGp
    senior_grade        SMALLINT NOT NULL DEFAULT 0 CHECK (senior_grade BETWEEN 0 AND 80), -- PlayerMsg.seniorStoreGrade
    senior_gp           INTEGER  NOT NULL DEFAULT 0 CHECK (senior_gp >= 0),                -- PlayerMsg.seniorStoreGp
    updated_at          TIMESTAMPTZ NOT NULL DEFAULT now()
);
```

Missing rows mean all sockets closed (`join = -1`). Operations are logged in `smith.operation_log` (`inlay`, `socket_open`, `gem_remove`, `soul_seal`), see [store-frame.md](./store-frame.md).

## 8. Backend implementation notes

- `smith::gems::handle_inlay` (5151): lock player; slot 0 equipment (MasterType 1, SonType != 109); `mount_pos` 1..4 open or filled; gem at (`bag_type`, `bag_pos`) SonType 205/228 owned and not locked; same type rule; if filled: gold = old gem `Property3`, return old gem to bag 34 (or 1); set socket; consume 1 gem; bind equipment; log; push 115, 87, 109; hero attributes if equipped; quest 18.
- `smith::gems::handle_socket_op` (5152): `operate = true` -> open: state -1, socket 4 rule, consume 1 x 208004 (respect `pay_type` binding preference), set 0, bind; `operate = false` -> remove: state filled, gold = gem `Property3`, return gem to bags (fail with 126 if no space), set 0. Push 115, 88, 109.
- `smith::gems::handle_soul_seal` (8484): `templateId` 208014 or 208031 (208031 only when grade >= 80 and the hero advanced job); `count` <= owned; add GP and level up through `UpGradeTempInfos` (types 15 / 104), senior cap `vocationLevel * 10`; consume items; push 115 and 3 (include `grades` #16 and `grade_process` #31 so the client applies the values). The gem effect percent must feed hero attribute computation ([../hero/README.md](../hero/README.md)).
- Gem synthesis and auto buy pricing: implement inside `smith::compose::handle_compose` ([compose.md](./compose.md)) with the chain pricing above; diamonds via [../currency/README.md](../currency/README.md).
- Socket data must be included in every item info push (`join_1..join_4`) and in other players' equipment views.

## 9. Open questions and assumptions

- Open: payload of 87 / 88 (no client listener).
- Open: `pay_type` meaning for 5152 (binding preference vs diamonds).
- Open: gem attribute values per level (server side table needed; not in client data).
- Assumption: Selo da Alma GP per item = template `Property1` (= 1) and GP resets per level.
- Assumption: removed or replaced gems go to the stone bag 34 when it exists (client return rule `GoodsManager.isStoreBagGoods`).
- Dragon equipment (Job "99") gem restrictions ("As Pérolas do Dragão apenas podem ser inseridas nos Equipamentos do Dragão.", "Dragão recomenda a inserção da pérola do dragão: magia, defesa, resistência, vida") hint at dragon pearls; no pearl SonType is filtered by the client. Open.

## 10. Implementation checklist

- [ ] Screen `MountView` with socket states, job tips, epic lock.
- [ ] Screen `JewelFrame` (Selo da Alma) normal and senior tracks.
- [ ] Route R1/R2 5151 inlay (empty and replace).
- [ ] Route R3 5152 open socket with Perfurador and quick buy fallback.
- [ ] Route R4 5152 remove gem with gold.
- [ ] Route R5 8484 soul seal.
- [ ] Route R6 gem synthesis rules inside compose (auto buy chain pricing).
- [ ] Route R7 9741 coordination with secretary.
- [ ] Server messages S1 87, S2 88, S3 3 (with `grades` / `grade_process` present), 115, 109.
- [ ] Rules: socket 4 epic rule, same type rule, removal cost `Property3`, binding.
- [ ] Rules: soul seal formulas and caps.
- [ ] Tables `smith.item_sockets`, `smith.player_soul_seal`, log entries.
- [ ] Quest condition 18.
- [ ] Tests: punch without tool, socket 4 on non epic, duplicate attribute, replace with insufficient gold, remove with full bags, soul seal over cap, senior unlock.
