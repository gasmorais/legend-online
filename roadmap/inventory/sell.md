# Sell to the system ("Vender")

Module of [README.md](README.md). Selling bag items to the system for gold: single sell by sell cursor or by dropping an item out of the frame, and batch sell through the "Itens à Venda" list. Player to player trade is in [market-stall.md](market-stall.md) and [../auction/README.md](../auction/README.md).

Path aliases:

| Alias | File |
|---|---|
| AF | `decompiled/m5/scripts/armyII/ArmyFrameII.as` |
| BH | `decompiled/core_module/scripts/bag/helper/BagHelper.as` |
| ISV | `decompiled/core_module/scripts/bag/view/ItemSellView.as` |
| SI | `decompiled/core_module/scripts/bag/view/SellItem.as` |
| PBD | `decompiled/core_module/scripts/cell/mediator/playerbag/PlayerBagCellDropMediator.as` |
| GM | `decompiled/core_module/scripts/yishi/manager/GoodsManager.as` |
| GC | `decompiled/core_module/scripts/bag/helper/GoodsCheck.as` |
| SSM | `decompiled/core_module/scripts/yishi/service/managers/SocketSendManager.as` |
| RM | `decompiled/core_module/scripts/yishi/manager/ResourceManager.as` |

## 1. Overview

- Price per unit = template `SellGold`; `SellGold == 0` means unsellable ([item-catalog.md](item-catalog.md) 5.11).
- Two client flows:
  - "Vender" button (hero level >= 10) switches the cursor to sell mode; each clicked bag cell is added to the "Itens à Venda" list (cells in the list are marked and ignored by other clicks); the list's sell button sends one batch request 8624.
  - Dragging an item outside every frame (after the tutorial, `newbieProcess > 19000`) asks "Certeza ao vender [name]? Preço {2} ouro" and sends a single sell 5007.
- Gold is credited by the server and pushed with 109 `U_C_CASTLE_UPDATE`; the sold slots are pushed with 115.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data |
|---|---|---|---|---|
| `bag.view.ItemSellView` (style `army.ItemSellView`) | "Itens à Venda" (`armyII.viewII.ItemSellView.titleText`) | List of selected items with columns "Nome", "Quantidade", "Cancelar", total gold, buttons sell / cancel (`ISV:73-101`) | first item clicked in sell mode (`AF:747-768`); disables "Dividir" and "Organizar" while open | items, editable count per row (`SI:95-109`, clamped 1..count), total |
| `bag.helper.BagHelper` sell cursor | cursor `SELL_CIRSOR` | sell mode (`BH:241-259`) | "Vender" (`AF:1416-1422`) | |
| Simple alert | "Certeza ao vender <font color='{0}'>[{1}]</font>? \nPreço {2} ouro" (`bag.helper.BagHelper.content01`) | single sell confirm (`PBD:193-237`) | drop outside frame | name in quality color, `SellGold * count` |
| Simple alert | "Vender{0} tipos de itens pode receber {1} ouro\nConfirmar venda?" (`armyII.viewII.ItemSellView.simpleGoodsHtml`) | batch confirm (`ISV:212-243`) | sell button | rows, total |

## 3. Routes (client to server)

### S-R1. Single sell (drop outside the frame)

- UI: drag a bag cell and release it outside any frame (`PBD:179-183`).
- Client checks (`PBD:193-237`), in order: item locked -> "O item atual foi bloqueado, favor desbloquear" (`vicepassword.description2`); `SellGold * count == 0` -> "Item não pode ser vendido" (`bag.helper.BagHelper.command01`); item has a gem (`join1..4 > 0`) -> "Equipamento contêm gema inserida, não pode ser vendida" (`command02`) or for Einherjar equipment (SonType 113..116) "Equipamentos que contém alma divina, não podem ser vendidos." (`command03`); `gold + price >= 2147483647` -> "Itens para vender ultrapassaram o limite de ouro, não é possível vendê-los." (`army.itemSellView.sell.overMaxAlert`); then confirmation.
- Client path: `SSM.sendSellItem(pos, bagType)` (`PBD:239-245`, `SSM:345-352`). The sell cursor path `BH.__alertResponse -> BH.sendSellItem(pos)` (`BH:491-504`, `BH:810-814`) also exists but is not reached in this build (the cursor now feeds the list).
- Route: C>S 5007 (0x138f) `U_C_BAG_SELL`; request `item.ItemReqMsg` with only `begin_pos` (#3, INT32) slot and `begin_bag_type` (#1, INT32) bag (1 or 34, default 1). The whole stack is sold.
- Response: 115 (slot emptied), 109 `U_C_CASTLE_UPDATE` (new gold).

### S-R2. Add to the sell list (sell cursor)

- UI: "Vender" then click a bag cell (`BH:397-489`). Same checks as S-R1 except the gold cap (zero price, gem inserted, locked). Valid items fire `SELL_GOODS` -> `ItemSellView.addSellGoods` (`ISV:305-334`): adds the row once, marks the item with `GM.setSellPos` (`GM:1833-1855`), updates the total. Clicking another frame button leaves sell mode. No request.

### S-R3. Batch sell ("Itens à Venda")

- UI: sell button of `ItemSellView`.
- Client checks (`ISV:212-229`): at least one row; `total + gold` within int32 ("Itens para vender ultrapassaram o limite de ouro...", "Capacidade máxima de ouro atingida!" `mainBar.view.GoldOvertopView.goldOvertop`); confirmation.
- Route: C>S 8624 (0x21b0) `C_BAG_BATCH_SELL`; request `item.ItemSellReqMsg`: `selledItemInfos` (#1, MESSAGE `SelledItemInfo`, repeated) with `pos` (#1, INT32) slot, `count` (#2, INT32) quantity to sell (1..stack), `bagType` (#3, INT32) bag of the slot (`ISV:245-271`).
- Response: 115 with every changed slot (emptied or reduced), 109 with the new gold. The view closes on send and clears the marks (`ISV:345-373`).
- Variant: `ItemSellView(1)` (Dragon Tamer talismans) sends `DragonTalkerManager.sendSellItems` instead (`ISV:273-298`), owned by [../dragon/README.md](../dragon/README.md).

## 4. Server messages (server to client)

| Opcode | Message | Receiver | When |
|---|---|---|---|
| 115 (0x0073) `U_C_BAG_MOVE_UPDATE` | `item.ItemMovedListMsg` | `GM.__bagUpdateHandler` ([item-instance.md](item-instance.md) S1); `ItemSellView` follows `DELETE_BAG` / `UPDATE_BAG` to drop or update rows (`ISV:125-163`) | after S-R1, S-R3 |
| 109 (0x006d) `U_C_CASTLE_UPDATE` | `castle.CastleYieldMsg`: `goldYield` (#1), `goldTotalCount` (#6, new gold), `goldMax` (#7), `curPopulation` (#8), `maxPopulation` (#9), `crystalsCount` (#11) | `ResourceManager.__resourceUpgrade` (`RM:61-77`) | after a sell; owner [../castle/README.md](../castle/README.md) |
| 56 (0x0038) `U_C_BAG_SELL` | | no client listener | not needed |
| 126 `U_C_MSG` | text | | optional failure notice |

## 5. Rules and formulas

- Payment per row: `SellGold * count` (`GC:369-372`). The list shows `SellGold` without the count for MasterType 1 and 5 (`ISV:134-140`, `GC:379-392`), which is the same because those stacks hold 1.
- Assumption: enhanced equipment pays `SellGold * (1 + strengthenGrade * 2)` as the tooltip says (`decompiled/core_module/scripts/yishi/view/tips/goods/PropTips.as:179`); the client total ignores enhancement.
- Not sellable: `SellGold == 0`; locked; any socket holding a gem; equipment equipped (only bag rows can be selected); items in the market stall.
- Gold cap: total gold must stay below 2 147 483 647.
- Allowed bags: 1 and 34 (the guild warehouse frame reuses the same list for bag 6 items, [../guild/warehouse.md](../guild/warehouse.md)).
- Precious goods (`GST.isPreciousGoods`) have a "[YES]" confirmation text (`armyII.viewII.ItemSellView.hasPrecciousGoodsHtml`) not used by this build (assumption: optional).
- Anti addiction: "Você está em estado anti-vício, não pode vender itens" (`armyII.viewII.ItemSellView.inAAS`) exists; assumption: the server refuses sells while the player is in anti addiction state.

## 6. Templates

`ItemTempInfos.xml`: `SellGold`, `MaxCount`, `MasterType`, `SonType`.

## 7. Persistent state

Rows are deleted or reduced in `inventory.items`; gold is a player counter ([../currency/README.md](../currency/README.md)). Audit:

```sql
CREATE TABLE inventory.sell_log (
  sell_id      BIGSERIAL   PRIMARY KEY,
  player_id    INTEGER     NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  item_id      BIGINT      NOT NULL,
  template_id  INTEGER     NOT NULL,
  count        INTEGER     NOT NULL CHECK (count > 0),
  gold         BIGINT      NOT NULL CHECK (gold >= 0),
  opcode       INTEGER     NOT NULL CHECK (opcode IN (5007, 8624)),
  sold_at      TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX sell_log_player_idx ON inventory.sell_log (player_id, sold_at DESC);
```

## 8. Backend implementation notes

- `inventory::sell::handle_sell` (5007) and `inventory::sell::handle_batch_sell` (8624): one transaction for all rows; validation per row: bag in {1, 34}, slot exists, `1 <= count <= row.count` (5007 sells the whole stack), template `SellGold > 0`, not locked, all sockets empty (`socket_N <= 0`), not in a market stall; total gold within int32 after credit. Any failure rejects the whole batch (assumption) and sends 126.
- Apply: reduce or delete rows, credit gold (`currency::credit_gold`), log, commit, push 115 then 109.
- Guild warehouse sells (bag 6) call the same handler with the guild hook.

## 9. Open questions and assumptions

- Enhanced equipment sell price (tooltip formula vs `SellGold`).
- Partial failure policy for 8624 (all or nothing assumed).
- Whether the original server accepted bag 34 in 5007 (the client sends the cell bag type).

## 10. Implementation checklist

- [ ] Screen: ItemSellView list, counts, total, sell mode cursor
- [ ] Route 5007 single sell
- [ ] Route 8624 batch sell
- [ ] Push 115 and 109 after sell
- [ ] Validation: zero price, gems, lock, gold cap, bags
- [ ] Table `inventory.sell_log`
- [ ] Tests: batch with partial counts, stack reduction, gold overflow refusal
