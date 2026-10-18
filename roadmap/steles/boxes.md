# Steles: boxes and exchange items (C_STELA_BOX)

Path aliases:

| Alias | File |
|---|---|
| SSM | `decompiled/core_module/scripts/yishi/service/managers/SocketSendManager.as` |
| MGR | `decompiled/core_module/scripts/managers/SteleSysManager.as` |

## 1. Overview

Steles are not bag items: they are created by using bag items of `SonType` 710 (`GoodsSonType.STELA_SONTYPE`, `decompiled/core_module/scripts/bag/datas/GoodsSonType.as:310`). Using such an item sends 8665 instead of the normal item use 5006. The server consumes the item(s) and creates the steles in the stele collection, then pushes 4280.

## 2. Screens

No stele screen. Bag interactions (inventory feature):

| Class | Purpose | Citation |
|---|---|---|
| `PlayerBagCellClickMediator` | Double click / use on a SonType 710 cell -> `sendUseStelaItem(pos)` | `decompiled/core_module/scripts/cell/mediator/playerbag/PlayerBagCellClickMediator.as:324-327` |
| `GoodsItemMenu` | Context menu "use" on SonType 710 -> `sendUseStelaItem(pos)` | `decompiled/core_module/scripts/cell/view/GoodsItemMenu.as:329-332` |
| `MulItemUseFrame` | Batch use (items have `IsCanBatch = true`), opened from the context menu (`GoodsItemMenu.as:243`) -> `sendUseStelaItem(pos, count)` | `decompiled/core_module/scripts/bag/view/MulItemUseFrame.as:132-136` |

## 3. Routes (client to server)

### R1. Use a stele box or exchange item
- UI: use / batch use of a bag item with `SonType == 710`.
- Client checks: batch frame requires `count > 0` (`MulItemUseFrame.as:122-126`); no other check.
- Sender: `SocketSendManager.sendUseStelaItem(pos, count = 1, bagType = 1, battleId = "", friendId = 0)` (`SSM:169-179`).
- Route: client to server, 8665 (0x21d9) `C_STELA_BOX`, `item.ItemUseMsg`:
  - `pos` (#1, INT32): bag slot of the item.
  - `count` (#2, INT32): quantity to use (1, or the batch number).
  - `bag_type` (#3, INT32): always 1 (player bag).
  - `battle_id` (#4, STRING): always "".
  - `friend_id` (#5, INT32): always 0.
- Expected response: 115 (0x0073) `U_C_BAG_MOVE_UPDATE` with the decreased/removed stack, then 4280 (0x10b8) `U_C_STELA_UPDATE` with the new steles (`isExist = true`, `step = 0`, `level = 0`, `pos = 0`) and/or material rows. Assumption: a notice of what was obtained may be sent through 126 `U_C_MSG`.

## 4. Server messages (server to client)

| Opcode | Name | Message | Receiver | When |
|---|---|---|---|---|
| 4280 (0x10b8) | `U_C_STELA_UPDATE` | `stela.StelaMsg` / `StelaDataMsg` (fields in `equip.md` S1) | `SteleSysManager.__dataInfosHandler` (`MGR:60`, `MGR:76-131`) | after R1 |
| 115 (0x0073) | `U_C_BAG_MOVE_UPDATE` | inventory message | `GoodsManager.__bagUpdateHandler` (`decompiled/core_module/scripts/yishi/manager/GoodsManager.as:98-101`) | item consumed |

No client handler exists for a response on 8665 itself. Error codes: none client side.

## 5. Rules and formulas

Items with `SonType = 710` in `raw/xml/tempinfos/ItemTempInfos.xml` (all `MasterType` 2, `NeedGrades` 1, `MaxCount` 100000000, `Property2` 100):

| TemplateId | TemplateName (pt-BR) | `Property1` |
|---|---|---|
| 7101401 .. 7101406 | "Item de troca da Estela da Faca curva imperial", "... da Armadura da Glória", "... do Escudo Demoníaco", "... da Bota de Armadura Ouro", "... do Anel de Cristal", "... do Elmo de Runa Demoníaco" | 1941401 .. 1941406 |
| 7101501 .. 7101506 | "Item de troca da Estela da Velha Faca Encantada", "... da Armadura de ouro real", "... do Escudo de Fogo Glorioso", "... da Bota de Asas", "... do Anel do Poder", "... do Elmo de Asas Gloriosas" | 1941501 .. 1941506 |
| 7101601 .. 7101603 | "Item de troca da Estela do Anel Glorioso", "... do Colar da Runa Misteriosa", "... do Elmo do Poder Sagrado" | 1941601 .. 1941603 |
| 7106001 | "Baú de Estela 1 estrela" | 1946001 |
| 7106002 | "Baú de Estela 2 estrelas" | 1946002 |
| 7106003 | "Baú de Estela 3 estrelas" | 1946003 |
| 7106004 | "Baú de Estela 1~2 estrelas" | 1946004 |
| 7106005 | "Baú de Estela 1~3 estrelas" | 1946005 |
| 7106006 | "Baú de Estela 4 estrelas" | 1946006 |

- Exchange item `71014RR..71016RR` maps to stele template `RRRR` = last 4 digits (7101401 -> 1401 "Faca curva imperial"). Assumption: it creates exactly one stele of that template per unit.
- Boxes 7106001..7106006 create one random stele per unit among templates of the rarities in the name (1★ = 1101..1103, 2★ = 1201..1203, 3★ = 1301..1306, 4★ = 1401..1406). Assumption: uniform among templates; `Property1` (1946xxx) is a server drop table id not present in client data.
- The pt-BR `Description` strings of these items are shifted by one row in the data (e.g. 7101402 says "Após usar obtém uma Estela da Faca curva imperial", 7101401 mentions "100 Faíscas"); keep verbatim but do not rely on them.
- `Property2` = 100: meaning unknown (assumption: drop weight base or rate percent).
- New steles: `step = 0`, `level = 0`, `total_exp = 0`, no refine lines, `slot_pos = 0`.

## 6. Templates

| File | Fields used |
|---|---|
| `raw/xml/tempinfos/ItemTempInfos.xml` | `TemplateId`, `SonType` 710, `Property1`, `Property2`, `IsCanBatch`, `MaxCount` |
| `raw/xml/tempinfos/StelaTemplates.xml` | `Rarity` for random boxes, `TemplateId` for exchange items |

## 7. Persistent state

Uses `steles.player_steles` (`equip.md`) and inventory items (`inventory.items(item_id, player_id, template_id, bag_type, position, count, ...)`, assumption from the shared inventory model). Server side drop tables:

```sql
CREATE TABLE steles.box_drops (
    box_drop_id   INTEGER NOT NULL,           -- ItemTempInfos.Property1 (1941401.., 1946001..)
    stele_template_id INTEGER NOT NULL,       -- StelaTemplates.TemplateId
    weight        INTEGER NOT NULL DEFAULT 1 CHECK (weight > 0),
    quantity      INTEGER NOT NULL DEFAULT 1 CHECK (quantity > 0),
    PRIMARY KEY (box_drop_id, stele_template_id)
);
```

Seeded from the assumptions in section 5 (static data, not per player).

## 8. Backend implementation notes

- Handler `steles::boxes::handle_use_box` (8665).
- Validation: `bag_type == 1`; item at `pos` owned with `SonType == 710`; `1 <= count <= stack count`; player level `>= NeedGrades`.
- Transaction: decrement or delete the stack; for each unit draw from `steles.box_drops` by `Property1`; insert steles; log (`op = 8`).
- Pushes: 115 bag update, 4280 with all created steles (`opType = 8`, assumption).
- Assumption: no stele capacity limit; if one is introduced, check it before consuming items.

## 9. Open questions and assumptions

- Assumption: exchange item -> fixed template; box -> uniform random template of the listed rarities.
- Open: real drop table contents for `Property1` ids and the meaning of `Property2`.
- Open: whether strengthening material (2101) can also come from boxes (no SonType 710 item names it).
- Open: source of the boxes and stones (shops, events, exploration); not visible in client data.

## 10. Implementation checklist

- [ ] Table `steles.box_drops` and seed.
- [ ] `steles::boxes::handle_use_box` with batch count.
- [ ] Item consumption and 115 push (inventory API).
- [ ] 4280 push with created steles.
- [ ] Tests: single use; batch use of 10; wrong SonType rejected; count above stack rejected; random box creates only allowed rarities; exchange item creates the mapped template.
