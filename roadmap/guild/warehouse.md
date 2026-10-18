# Guild warehouse ("Depósito" / "Armazém da Guilda") (economy module)

Scope: the Depósito building used as extra storage (bag type 6), its two rentable "Armazém temporário" pages paid with guild wealth, item return by mail when leaving the guild, and the legacy guild prize chest distribution (bag type 8, "Lista de Distribuição"). Building levels are in `buildings.md`.

Path aliases:

| Alias | File |
|---|---|
| CSOM | `decompiled/core_module/scripts/managers/ConsortiaSocketOutManager.as` |
| SSM | `decompiled/core_module/scripts/yishi/service/managers/SocketSendManager.as` |
| PM | `decompiled/core_module/scripts/yishi/manager/PlayerManager.as` |
| GM | `decompiled/core_module/scripts/yishi/manager/GoodsManager.as` |
| CM | `decompiled/core_module/scripts/yishi/manager/ConsortiaManager.as` |
| CMOD | `decompiled/core_module/scripts/mvc/module/consortia/ConsortiaModel.as` |
| MED | `decompiled/core_module/scripts/cell/mediator/consortiabag/` |
| B | `decompiled/m6/scripts/consortia/view/myConsortia/building/` |

## Overview

The warehouse is per member storage (assumption, see open questions): items live in the player's own item list with `bagType = 6`, `objectId = 0` (`GM.consoritaBagList` `GM:592-603`, cells keyed `pos_0_6`). Page 1 holds `storeLevel * 5` slots (56 at level 10, `CMOD:836-852`). Pages 2 and 3 hold 49 slots each and are unlocked by the president renting them for 30/90/180 days with guild wealth. Moves use the generic bag move opcode 5005. When the member leaves, the items are mailed back.

Entry point: building map "Depósito" -> `consortia.ConsortiaCaseFrame` (`decompiled/m6/scripts/consortia/view/myConsortia/newui/ConsortiaBuildingView.as:266-271`), visible only when `storeLevel > 0` (`:162-178`).

## Screens

| Class | pt-BR title | Purpose | Data |
|---|---|---|---|
| `B/ConsortiaCaseFrame.as` | "Armazém da Guilda Nv.{0}" (`:49-50`) | Left: player bag (`ConsortiaBagView`, buttons "Organizar", "Dividir", "Vender"); right: warehouse (`ConsortiaCaseView`); sell panel on `SELL_GOODS` (`:104-120`) | store level |
| `B/ConsortiaCaseView.as` | page buttons 1..3, "Organizar" | 3 pages (`:51-60`), tidy (`:114-117`); prize bag hidden because `showCaseBagTip()` is always called with `true` (`:72`, `:129-136`) | |
| `B/ConsortiaCaseBag.as` | | 7x8 grid of `ConsortiaCaseCell`, `bagType = 6` (`:26-30`); locks cells beyond capacity (`:52-77`, `:102-148`); page offsets: page 1 pos 0..55, page 2 pos 56..104, page 3 pos 105..153 (`:172-241`) | `GM.consoritaBagList` (`:344-347`) |
| `B/ConsortiaRentalBagStateView.as` | buttons open / continue, expiry date "YYYY-MM-DD" | Overlay on pages 2 and 3 (`:168-201`) | `storage_expire_time1/2`, `is_storage_expire1/2` |
| `B/ConsortiaRentalBagAlertFrame.as` | "Armazém temporário"; "Ao ativar o armazém temporário {0} poderá desfrutar dos seguintes privilégios:" / "Ao continuar pagando pelo armazém temporário {0} poderá desfrutar dos seguintes privilégios:"; options "{0} dia(s) (Fortuna da Guilda {1})" | Choose 30/90/180 days | config `consortia_storage_offer` |
| `B/ConsortiaPrizeBag.as`, `B/ConsortiaPrizeAllotFrame.as` "Lista de Distribuição", `B/ConsortiaPrizeAllotItem.as` | legacy prize chest bag and distribution list (columns "Nome", "Nível", "Poder", "Distribuído") | Unreachable from the current UI (prize bag never visible) but the protocol handlers are live | `prizeList`, `prizeMemberList` |

## Actions

### W1. Deposit by double click (player bag -> warehouse)
- Mediator `ConsortiaBagDoubleClickMediator.__mouseDoubleClick` (`MED/ConsortiaBagDoubleClickMediator.as:40-94`).
- Checks: `caseBagCanUse` else "Não é possível depositar itens pessoais no Depósito de Baú da Guilda" (`:44-49`); item `SonType != 298` (`:55-58`); item not in the sell list (`:59-62`). Target: an existing stack of the same template with room and same bind flag (`check`, `:122-147`), else the first free slot `< capacity` (`:67-81`), else a free slot on a non expired rented page (`findConsortiaEmputyPos`, `:96-120`, scans 0..153 but only accepts positions > 56). None -> "Depósito cheio".
- Client path: `PM.moveBagToBag(srcBag, srcObj, srcPos, 6, 0, dstPos, 1)` (`PM:1602-1606`; `PM.checkConsortiaBagGoods` shows "Armazém temporário expirado" for expired page positions but still sends, `PM:1613-1628`) -> `SSM.sendMoveBagToBag` (`SSM:139-155`).
- Route: send 5005 (0x138d) `U_C_BAG_MOVE`.
- Message `ItemReqMsg`: `begin_bag_type` (#1, INT32) source bag (1 main bag, 34 store bag); `begin_obj_id` (#2, INT32) 0; `begin_pos` (#3, INT32); `end_bag_type` (#4, INT32) 6; `end_obj_id` (#5, INT32) 0; `end_pos` (#6, INT32); `count` (#7, INT32) = 1 for double click; `object_id` (#8, INT32) unset.
- Response: 115 (0x0073) `U_C_BAG_MOVE_UPDATE` with both changed slots (S1).

### W2. Deposit or swap by drag
- `ConsortiaBagDropMediator.beDropHitCallBack` (`MED/ConsortiaBagDropMediator.as:56-164`): dropping a player bag cell on a warehouse cell calls `swapItem` -> 5005 with `count = drag count or 1` (`:84-99`, `:166-169`); locked target cells are ignored (`:73-76`); market cell drop forwards to the auction (`:67-72`).
- Same route and reply as W1.

### W3. Withdraw by double click (warehouse -> bag)
- `ConsortiaCaseCellClickMediator.__mouseDoubleClick` (`MED/ConsortiaCaseCellClickMediator.as:32-55`): target bag = `currentBagType` (1 main bag or 34 store bag); first empty slot (`GM.findEmputyPos` / `findStroeEmputyPos`); none -> "Mochila cheia".
- 5005 with `begin_bag_type = 6`, `end_bag_type = 1|34`, `count = 1`. Reply 115.

### W4. Withdraw or reorder by drag
- `ConsortiaCaseCellDropMediator.beDropHitCallBack` (`MED/ConsortiaCaseCellDropMediator.as:52-153`): drop on any item cell -> `swapItem` 5005 (`:64-87`, `:160-163`); drop on a bag page button -> first empty slot of that page (`:88-142`), full -> "cell.mediator.playerbag.PlayerBagCellDropMediator.command01".

### W5. Tidy ("Organizar")
- `ConsortiaCaseView.__tidyHandler` (`B/ConsortiaCaseView.as:114-117`) -> `BagHelper.onTidyHandler` (`decompiled/core_module/scripts/bag/helper/BagHelper.as:556`) -> `ConsortiaCaseBag.sort` (`B/ConsortiaCaseBag.as:243-310`) computes new positions (skipping expired rented pages) -> `GM.fixBagItem` (`GM:292-310`).
- Route: send 8220 (0x201c) `C_BAG_ARRANGE`; message `ArrangeReq`: `isStackItem` (#1, BOOL) merge stacks, `bagType` (#2, INT32) 6, `arrangeInfo` (#3, MESSAGE `ArrangeInfo`, repeated: `oldplace` (#1, INT32), `newplace` (#2, INT32)).
- Response: 115 with all moved slots.

### W6. Remove expired items
- `ConsortiaCaseBag.refreshView` (`B/ConsortiaCaseBag.as:172-214`) sends a delete for every item with `validDate > 0` whose `beginDate + validDate minutes` passed (`:206-209`) via `BaseBagListView.sendDeleteGoods` (`decompiled/core_module/scripts/bag/view/BaseBagListView.as:202-205`) -> `SSM.sendDeleteGoods` (`SSM:354-361`).
- Route: send 8346 (0x209a) `C_BAG_REMOVE`; `ItemRemoveMsg`: `bag_type` (#1, INT32) 6, `pos` (#2, INT32). Reply 115 with the slot emptied.

### W7. Rent or renew a temporary page
- UI: open / continue buttons on pages 2 and 3 (`B/ConsortiaRentalBagStateView.as:116-140`).
- Checks (`checkClick`, `:142-156`): only the president ("Apenas o presidente da guilda pode continuar a pagar para desfrutar do armazém temporário."); `storeLevel >= 10` ("O armazém da guilda ainda não atingiu o nível 10, não é possível ativar."). In the alert frame (`B/ConsortiaRentalBagAlertFrame.as:118-139`): guild wealth `offer >= price` else "Fortuna da Guilda insuficiente".
- Client path: `SSM.sendConsortiaRentalBagOp(currentPage - 2, days)` (`SSM:603-610`).
- Route: send 8995 (0x2323) `C_CONSORTIA_STORAGE`; message `com.road.yishi.proto.simple.PropertyMsg` (field numbers from `decompiled/core_module/scripts/com/road/yishi/proto/simple/PropertyMsg.as:300-362`): `param1` (#1, INT32) page index 0 (page 2) or 1 (page 3); `param2` (#2, INT32) days 30, 90 or 180.
- Response: push 164 (0x00a4) `U_CH_CONSORTIA_FRESHINFO` to all online members with the new `offer`, `storage_expire_time1/2`, `is_storage_expire1/2` (`CM:548-551`); the state view listens to `UPDA_CONSORTIA_INFO` (`:100`, `:158-161`).

### W8. Sell from the warehouse frame
Generic item sell panel (`B/ConsortiaCaseFrame.as:104-134`); cross dependency with the inventory module.

### W9. Legacy prize chest distribution (president)
- Double click a chest in the prize bag (`MED/ConsortiaPrizeCellClickMediator.as:34-41`, only president and non empty `prizeList`, `:43-50`) -> `CSOM.consortiaPrizeAllot(templateId)` (`CSOM:293-299`).
  - Route: send 8579 (0x2183) `C_CONSORTIA_BOX_SEND_INFO`; `ConsortiaTreasureBoxMsg.template_id` (#3, INT32).
  - Reply: 4465 (0x1171) `U_C_CONSORTIA_TREASURE_BOX` (S4), which opens openType 7 `ConsortiaPrizeAllotFrame` (`B/ConsortiaCaseView.as:124-127`).
- Allocation edit: per member input capped at `min(remaining + current, 10)` (`B/ConsortiaPrizeAllotItem.as:163-177`); members with `is_received` are read only with tip "Esse jogador já coletou baú nessa semana" (`:203-227`); president row first (`B/ConsortiaPrizeAllotFrame.as:322-329`).
- Confirm "Certeza ao distribuir de acordo com essa lista?" (`:237-245`) -> `CSOM.consortiaPrizeAllotConfirm` (`CSOM:301-320`).
  - Route: send 8578 (0x2182) `C_CONSORTIA_BOX_SEND_CONFIRM`; `ConsortiaTreasureBoxMsg`: `consortia_id` (#1, INT32), `chairman_id` (#2, INT32), `template_id` (#3, INT32), `playerInfo` (#6, repeated `ConsortiaMembersInfoMsg` with `user_id` (#5) and `count` (#6) only for counts > 0).
  - Reply: 4466 with the new stock (S3) and mail or bag delivery to members (assumption).

## Server messages

| Opcode | Name | Message | Handler | Fields | When |
|---|---|---|---|---|---|
| 115 (0x0073) | `U_C_BAG_MOVE_UPDATE` | `ItemMovedListMsg`: `moved` (#1, repeated `ItemMoveUpdateMsg`: `change_type` (#1, INT32) bag type, `change_obj_id` (#2, INT32), `change_pos` (#3, INT32), `item` (#4, `com.road.yishi.proto.item.ItemInfoMsg`, absent when the slot became empty)) | `GM.__bagUpdateHandler` (`GM:101`, listener `GM:98`) | items with `bag_type = 6` feed `consoritaBagList` | After 5005, 8220, 8346 and on login with all bag 6 items |
| 164 / 4138 | `U_CH_CONSORTIA_FRESHINFO` / `U_C_CONSORTIA_INFO` | `ConsortiaInfoMsg` | `CM.__refreshConsortiaInfo` (`CM:457`) | `store_level` (#9) capacity; `storage_expire_time1` (#66, STRING `YYYY-MM-DD hh:mm:ss`), `storage_expire_time2` (#67), `is_storage_expire1` (#68, BOOL true when page 2 is not rented or expired), `is_storage_expire2` (#69); `offer` (#20) | Push after W7, after store upgrades, on expiry |
| 4466 (0x1172) | `U_C_CONSORTIA_BOX_INFO` | `ConsortiaStorageInfoMsg`: `storageInfo` (#1, repeated `ConsortiaBoxInfoMsg`: `template_id` (#1), `consortia_id` (#2), `count` (#3), `add_time` (#4, BYTES), `remove_time` (#5, BYTES)) | `CM.__prizeCheckHandler` (`CM:257-297`) | expands counts into bag 8 cells stacking up to `MaxCount` | Push to the president when guild chests change (legacy) |
| 4465 (0x1171) | `U_C_CONSORTIA_TREASURE_BOX` | `ConsortiaTreasureBoxMsg`: `template_id` (#3), `count` (#4) chests left to give, `playerInfo` (#6, repeated `ConsortiaMembersInfoMsg`: `job` (#1), `nick_name` (#2), `level` (#3), `fight_capacity` (#4), `user_id` (#5), `count` (#6) planned, `is_received` (#7) already got one this week, `trans_grade` (#8)) | `CM.__prizeAllotHandler` (`CM:299-334`) | fills `prizeMemberList`, `currentPrizeTemplateId`, `currentPrizeListCount` | Reply to 8579 |
| 117 (0x0075) | `U_C_CONSORTIA_STATIC` | `ConsortiaMsg` | `CM.__consortiaStageChange` (`CM:721-752`) | when `consortia_id` (#1) becomes 0 and `return_item` (#16, BOOL) is true the client shows "Items do depósito da Guilda foram retornados, verifique seu email, email será guardado por 30 dias" (`decompiled/core_module/scripts/yishi/actions/consortia/CaseGoodsSendBackByMailAction.as:46-53`) | On leave or kick (core module), after mailing bag 6 items |

## Rules and formulas

- Capacity page 1: `0` at level 0, `storeLevel * 5` at 1..9, 56 at level 10 (`CMOD:836-852`; `B/ConsortiaCaseBag.as:63-64`). `CASE_CELL_MAX_NUM = 56`, `BAG_PAGE_CELL_NUM = 56` (`CMOD:42`,`:54`).
- Rented pages: page 2 positions 56..104, page 3 positions 105..153 (49 each, `PM:1619-1626`, `B/ConsortiaCaseBag.as:182-192`).
- Rental requires president and `storeLevel = 10`; price `consortia_storage_offer = 30,3000000|90,9000000|180,18000000` (days, guild wealth) (`decompiled/core_module/scripts/yishi/datas/ConfigInfoManager.as:676-679`). Renewal extends from the current expiry (assumption) else from now.
- Expired page: deposits are refused (client only warns), withdrawals stay allowed (cells unlock when the page still has items, `B/ConsortiaCaseBag.as:122-147`).
- Items with `SonType 298` cannot be stored.
- Leaving or being kicked: all bag 6 items are mailed back (mail kept 30 days) and 117 is sent with `return_item = true`.
- Legacy prize distribution: at most 10 chests per member per allocation, one per member per week.

## Templates

- `raw/xml/tempinfos/ConsortiaLevelInfos.xml` type 5 (Depósito) for capacity and cost.
- `raw/xml/tempinfos/ConfigInfos.xml` key `consortia_storage_offer`.
- `raw/xml/tempinfos/ItemTempInfos.xml` (`MaxCount`, `SonType`, `ValidDate`).

## Persistent state

Bag 6 items are rows of the generic item table of the inventory module with `bag_type = 6` (owner = player). This module adds rental state and legacy chest stock:

```sql
ALTER TABLE guild.guild
  ADD COLUMN storage_page2_expires_at TIMESTAMPTZ,
  ADD COLUMN storage_page3_expires_at TIMESTAMPTZ;

CREATE TABLE guild.storage_rental_log (
  id          BIGSERIAL PRIMARY KEY,
  guild_id    INTEGER   NOT NULL REFERENCES guild.guild(id) ON DELETE CASCADE,
  page_index  SMALLINT NOT NULL CHECK (page_index IN (0,1)),
  days        SMALLINT NOT NULL CHECK (days IN (30,90,180)),
  wealth_cost BIGINT   NOT NULL CHECK (wealth_cost > 0),
  paid_by     INTEGER   NOT NULL REFERENCES public.player(id),
  paid_at     TIMESTAMPTZ NOT NULL DEFAULT now(),
  new_expiry  TIMESTAMPTZ NOT NULL
);
CREATE INDEX storage_rental_log_guild_idx ON guild.storage_rental_log (guild_id, paid_at DESC);

CREATE TABLE guild.prize_stock (
  guild_id    INTEGER  NOT NULL REFERENCES guild.guild(id) ON DELETE CASCADE,
  template_id INTEGER NOT NULL,
  count       INTEGER NOT NULL CHECK (count >= 0),
  added_at    TIMESTAMPTZ NOT NULL DEFAULT now(),
  PRIMARY KEY (guild_id, template_id)
);

CREATE TABLE guild.prize_grant (
  guild_id    INTEGER   NOT NULL REFERENCES guild.guild(id) ON DELETE CASCADE,
  week_start  DATE     NOT NULL,
  player_id   BIGINT   NOT NULL REFERENCES public.player(id) ON DELETE CASCADE,
  template_id INTEGER  NOT NULL,
  count       SMALLINT NOT NULL CHECK (count BETWEEN 1 AND 10),
  granted_at  TIMESTAMPTZ NOT NULL DEFAULT now(),
  PRIMARY KEY (guild_id, week_start, player_id)
);
```

## Backend implementation notes

- 5005 is owned by the inventory module; it must call `guild::warehouse::validate_move(player, src, dst)` whenever `begin_bag_type = 6` or `end_bag_type = 6`: player in a guild; `store_level >= 1`; destination position allowed (`< capacity` on page 1, or page 2/3 rented and not expired for deposits); item not `SonType 298`; stacking rules unchanged.
- 8220 with `bagType = 6`: inventory module arrange, with the same position validation for every `newplace`.
- 8346 with `bag_type = 6`: only expired items may be removed (assumption).
- `guild::warehouse::handle_rent` (8995): president -> `store_level = 10` -> `days` in config -> page index 0/1 -> wealth >= price. Transaction: `guild::funds::spend_fortune` (locks `guild.guild`, debits `fortune`), set expiry `greatest(now, current_expiry) + days`, insert log; push 164 to all online members.
- `guild::warehouse::on_member_leave` (called by core module): move all bag 6 items of the player into a system mail, then send 117 with `return_item = true`.
- Legacy: `guild::warehouse::handle_prize_info` (8579) reply 4465; `guild::warehouse::handle_prize_confirm` (8578) validates president, totals <= stock, per member count <= 10 and not granted this week; deliver by mail; reply 4466 to the president.

## Open questions

- Is bag 6 really personal storage or a shared guild pool? Client evidence points to personal (`GM:592-603`); the template text says "Pode armazenar itens temporários dos membros da guilda para poupar espaço na mochila".
- Double click sends `count = 1`; does the original server move the whole stack in that case?
- Source of legacy guild chests (4466) in this version (probably wars/bosses, PvE and PvP modules).

## Implementation checklist

- [ ] Client screen: ConsortiaCaseFrame with player bag and 3 warehouse pages
- [ ] Client screen: rental overlay and ConsortiaRentalBagAlertFrame
- [ ] Inventory hook `guild::warehouse::validate_move` for 5005, 8220, 8346
- [ ] Login sync of bag 6 items in 115
- [ ] Columns `guild.guild.storage_page2_expires_at`, `storage_page3_expires_at`
- [ ] Table `guild.storage_rental_log`
- [ ] Handler `guild::warehouse::handle_rent` (8995 -> push 164)
- [ ] Expiry flags `is_storage_expire1/2` in `ConsortiaInfoMsg`
- [ ] `guild::warehouse::on_member_leave` mail return + 117 `return_item`
- [ ] Tables `guild.prize_stock`, `guild.prize_grant` (legacy)
- [ ] Handlers `guild::warehouse::handle_prize_info` (8579 -> 4465) and `handle_prize_confirm` (8578 -> 4466)
