# Level up support packs ("Apoio de Elevação")

Path aliases:

| Alias | File |
|---|---|
| UPM | `decompiled/core_module/scripts/yishi/manager/UpgradePresentManager.as` |
| UPMOD | `decompiled/core_module/scripts/mvc/module/upgradepresent/UpgradePresentModel.as` |
| UPI | `decompiled/core_module/scripts/mvc/module/upgradepresent/UpgradePresentInfo.as` |
| UPF | `decompiled/m11/scripts/upgradepresent/UpgradePresentFrame.as` |
| UPG | `decompiled/m11/scripts/upgradepresent/UpgradePresentGoodsItem.as` |
| QB | `decompiled/core_module/scripts/ui/queuebar/QueueBar.as` |
| SM | `decompiled/core_module/scripts/managers/ShopManager.as` |

## 1. Overview

When the hero reaches certain levels ("areas" 35, 50, 70, 80) a time limited page of diamond packs opens. Each pack is a shop item of ShopType 1013 that can be bought up to `SellMaxCount` times before the page expires. The packs are boxes whose content is in `UpgradePresentBoxDrop.xml`.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `upgradepresent.UpgradePresentFrame` (UPF) | "Apoio de Elevação" | One page per open area, previous / next page, countdown (UPF:116-138) | queue bar button (QB:665-675, 745-749) visible when `VersionSwitch.UPGRADE_PRESENT` and at least one pack is buyable, badge = number of buyable areas | opens on the last open page (`showMaxPage`, UPF:50); refreshed every second (UPF:88, 106) |
| `UpgradePresentGoodsItem` (UPG) | pack card: cost "Custo: {0}", remaining "n/limit" | Buy one pack | UPF | box content (`UpgradePresentBoxDropTempCate.getTemplateListByBoxId(ItemId)`, UPI:100-118) |

## 3. Routes (client to server)

### U1. Buy a pack
- UI: UPG buy button (UPG:98-113). Client checks: page not expired else "Este pacote excedeu o prazo de validade."; confirm "Você vai gastar {0} diamantes para comprar o {1}Ainda pode comprar: {2}/{3} vezes."; `judgePointEnoughToShowPay(price, false)` diamonds only (UPG:115-126); button disabled when `bought >= limit` (UPG:141-145).
- Sender: `UpgradePresentManager.sendUpgradePresentBuy(shopId)` (UPM:71-77) -> `ShopManager.buyOne(shopId, 1, selfUserId, 1, false)` (SM:1205-1220).
- Route: send 8970 (0x230a) `C_SHOPCAR_BUY`; message `ShopCarListMsg` (shop): `result` (#1, INT32) unused; `receiveUserId` (#2, INT32) own player id; `discountTempId` (#3, INT32) 0; `carItemInfo` (#4, `CarItemInfoMsg`, repeated, one entry): `shopId` (#1, INT32) ShopTempInfo `Id` (61700011..61700016), `counts` (#2, INT32) 1, `payType` (#3, INT32) 1 diamonds only, `isDiscountShop` (#4, BOOL) false, `type` (#5, INT32) unset; `isMail` (#5, BOOL) unset.
- Expected responses in order: 3 (`point`), bag update with the pack box item, 4783 (0x12af) `U_C_SHOPCAR_RESULT` (owned by [../shops/README.md](../shops/README.md)), 176 with the new bought counts.

## 4. Server messages (server to client)

### S1. 176 (0x00b0) `U_C_UPGRADE_PRESENT`
- Message `UpgradePresentListMsg` (shop): `list` (#1, `UpgradePresentMsg`, repeated). `UpgradePresentMsg`: `area` (#1, INT32) hero level that opens the page; `end_time` (#2, INT64) page expiry in milliseconds since epoch (client divides by 1000, UPM:60); `boughtCount` (#3, INT32, repeated) bought count per shop id, same order as `shopId`; `shopId` (#4, INT32, repeated) ShopTempInfo ids of the page.
- Receiver: `UpgradePresentManager.__upgradePresentMsgBack` (UPM:46, 49-69): rebuilds the list sorted by area, `setPresentInfo` reads limits from the shop templates (UPI:79-98), `setModelData` counts buyable and open pages (UPMOD:67-91), notifies `UPGRADE_PRESNET_INFO_CHANGE`.
- Client rules: page open when `thane.grades >= area` (UPI:36-39); expired when `end_time <= now` (UPI:84); buyable when open, not expired and some `bought < SellMaxCount` (UPI:51-77). Re-evaluated every minute by `PlayerModel` (`decompiled/core_module/scripts/yishi/datas/playerinfo/PlayerModel.as:382-385`).
- When: login, after each purchase, and when the hero reaches a new area level (a new page with its `end_time`).

## 5. Rules and formulas

- Packs (`raw/xml/tempinfos/ShopTempInfos.xml`, `ShopType="1013"`):

| Shop Id | Area (level) | Box item | Price (diamonds) | Limit |
|---:|---:|---:|---:|---:|
| 61700011 | 35 | 6170001 "Pacote de Apoio de Elevação 1" | 150 | 3 |
| 61700012 | 50 | 6170002 "Pacote de Apoio de Elevação 2" | 300 | 3 |
| 61700013 | 70 | 6170003 (Guardiões) | 500 | 3 |
| 61700014 | 70 | 6170004 (Einherjars) | 500 | 3 |
| 61700015 | 80 | 6170005 (Personagem) | 800 | 3 |
| 61700016 | 80 | 6170006 (Einherjars e Guardiões) | 800 | 3 |

- Box contents (`UpgradePresentBoxDrop.xml`, `BoxTempId` -> `ItemTempId` x `Count`): 6170001: 2127003 x350, 3020010 x100, 208014 x300, 3300101 x100, 211001 x100, 208024 x100; 6170002: 3040001 x300, 208023 x500, 3230101 x800, 3290503 x3, 2060488 x100; 6170003: 2250001 x800, 2271001 x135, 2240603 x5, 2269000 x300, 2129822 x60; 6170004: 3040001 x600, 208023 x800, 2125059 x50, 2125057 x500, 3230101 x800; 6170005: 2013004 x5, 208102 x4000, 212012 x20, 2030102 x20, 3173004 x400; 6170006: 208046 x400, 208047 x400, 208048 x400, 3270101 x200, 3240101 x300. The purchase gives the box item; opening it grants the contents ([../inventory/README.md](../inventory/README.md)).
- `end_time` = moment the hero reached `area` + a fixed window (assumption: 72 hours; not in client data).
- The shop purchase validates `SellMaxCount` per page instance, not per lifetime of the shop item (assumption: one page per area per character).

## 6. Templates

| File | Record | Fields |
|---|---|---|
| `raw/xml/tempinfos/ShopTempInfos.xml` | `ShopTempInfo` ShopType 1013 | `Id`, `Area` level, `ItemId` box, `Point` price, `SellMaxCount` limit |
| `raw/xml/tempinfos/UpgradePresentBoxDrop.xml` | `UpgradePresentBoxDropInfo` (31 rows) | `BoxTempId`, `ItemTempId`, `Count`, `AppearType`, `ValidDate` |
| `raw/xml/tempinfos/ItemTempInfos.xml` | boxes 6170001..6170006 (MasterType 2, SonType 206) | names |

## 7. Persistent state

```sql
CREATE TABLE vip.upgrade_present_pages (
  player_id    BIGINT      NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  area         SMALLINT    NOT NULL,
  opened_at    TIMESTAMPTZ NOT NULL DEFAULT now(),
  ends_at      TIMESTAMPTZ NOT NULL,
  PRIMARY KEY (player_id, area)
);

CREATE TABLE vip.upgrade_present_purchases (
  player_id    BIGINT   NOT NULL,
  area         SMALLINT NOT NULL,
  shop_id      INTEGER  NOT NULL,
  bought       SMALLINT NOT NULL DEFAULT 0 CHECK (bought >= 0),
  PRIMARY KEY (player_id, area, shop_id),
  FOREIGN KEY (player_id, area) REFERENCES vip.upgrade_present_pages(player_id, area) ON DELETE CASCADE
);
```

## 8. Backend implementation notes

- Hook `hero::on_level_up(player_id, new_level)`: for every area in {35, 50, 70, 80} newly reached, insert the page with `ends_at = now + window`; push 176.
- The shop handler for 8970 (`shops::cart::handle_buy`) routes ShopType 1013 to `vip::upgrade_present::validate_and_record(tx, player_id, shop_id, count)`: page exists, not expired, hero level >= area, `bought + count <= SellMaxCount`; then the normal shop flow spends diamonds (payType 1) and grants the box item; after commit push 176.
- Login: send 176 with all pages (expired pages may be omitted after a grace period).

## 9. Open questions and assumptions

- Gap: the page window length (`end_time - reach time`) is server data; assumption 72 hours.
- Assumption: characters already above an area level at feature launch get no page for it.

## 10. Implementation checklist

- [ ] Screen: queue bar button and badge count
- [ ] Screen: pages per area with countdown and limits
- [ ] Route U1 8970 for ShopType 1013
- [ ] Server message S1 176
- [ ] Table `vip.upgrade_present_pages`
- [ ] Table `vip.upgrade_present_purchases`
- [ ] Rule: page opens at levels 35, 50, 70, 80
- [ ] Rule: limit 3 per pack, diamonds only, expiry
- [ ] Test: buying after `end_time` is refused
- [ ] Test: fourth purchase of the same pack is refused
