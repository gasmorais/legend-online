# Main shop (Loja)

Path aliases:

| Alias | File |
|---|---|
| SF | `decompiled/m15/scripts/view/ShopFrame.as` |
| TAB | `decompiled/m15/scripts/view/inside/ShopTypeTabView.as` |
| SIV | `decompiled/m15/scripts/view/inside/ShopInsideView.as` |
| MGL | `decompiled/m15/scripts/view/inside/MainGoodsListView.as` |
| GI | `decompiled/m15/scripts/view/GoodsItem.as` |
| GI1 | `decompiled/m15/scripts/view/GoodsItem1.as` |
| SC | `decompiled/core_module/scripts/mvc/controler/ShopControler.as` |
| SMOD | `decompiled/core_module/scripts/mvc/module/shop/ShopModel.as` |
| SGI | `decompiled/core_module/scripts/mvc/module/shop/ShopGoodsInfo.as` |

## 1. Overview

The "Loja" is the diamond mall. Its catalog is static: the client reads ShopType 1 rows of `raw/xml/tempinfos/ShopTempInfos.xml` and splits them by `Area` into tabs (`SMOD.init`, `SMOD:229-277`). The server never sends the mall list; it only sends offers ([timebuy.md](timebuy.md), [promotions.md](promotions.md)), purchase counters and results ([purchase.md](purchase.md)). The same `ShopControler` (`shop` key) also opens every currency shop frame by `openType` (catalog in [catalog.md](catalog.md)).

Entry points:
- Main tool bar "Loja / Atalho O" (`mainToolBtn.ShopBtn`, `decompiled/core_module/scripts/ui/maintoolbar/MainToolBar.as:1543-1547`), unlocked at level 10 (`docs/ui/navigation.md:97`).
- Keyboard shortcut O, level >= 10 (`decompiled/core_module/scripts/yishi/keyboard/KeyBoardRegister.as:436-442`).
- Daily guide link, level >= 10, message "dayGuide.DayGuideManager.command02" otherwise (`decompiled/core_module/scripts/yishi/SwitchPageHelp.as:1180-1188`).
- Fashion store and community promotion items open the mall with `shopFrameDefaultPanel = "fashion"` (`decompiled/m14/scripts/fashion/FashionStoreFrame.as:724-727`, `decompiled/core_module/scripts/yishi/view/community/PromotionItem.as:280-281`).
- Time buy tip "Direção da Loja" sets `shopFrameDefaultPanel` to `SHOPFRAME_TIMEBUY` or `SHOPFRAME_VIPBUY` (`decompiled/m16/scripts/tasktracetip/view/ShopTimeBuyTipView.as:61`).
- Mystery shop frame button (`decompiled/m7/scripts/auction/view/mysteryshop/MysteryShopFrame.as:783`).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `view.ShopFrame` (openType 1 or default, `SC:57-62,223`) 952x612 | "Loja" (`task.view.shopFrame.title`, `SF:56`) | Container: search box ("Insira nome da mercadoria"), tab bar | entry points above | |
| `view.inside.ShopTypeTabView` | image tabs (labels are bitmaps `asset.shop.TimeBuy`, `PropBtSelectedImg`, `hero`, `pet`, `childBuy`, `elseSelectedImg`, `fashionBox`, `mountBox`; the pt-BR names below are inferred from the asset names) | Tab order (`TAB:62-94`): "Compra Limitada" home (`shop.TimeBuyBtn`, only when `getTimeBuyList(0)` or promotional offers exist, `TAB:96-104`), Itens (`shop.PropBtn`, Area 2), Herói (`shop.heroBtn`, Area 16), Einherjar (`shop.petBtn`, Area 18), Espírito (`shop.childBtn`, Area 12), Outros (`shop.ElsepageBtn`, Area 4), Baú de Moda (`shop.fashionBoxBtn`), Baú de Montaria (`shop.mountBoxBtn`) | `ShopFrame.initView` | default tab index 0 |
| `view.timebuy.ShopTimeBuyView` | "Compra Limitada" home | 6 offers per page plus the right column (`MainRightView`) | home tab | see [timebuy.md](timebuy.md), [promotions.md](promotions.md) |
| `view.inside.ShopInsideView` + `MainGoodsListView` | | 3x3 grid (9 per page, `SC.setCurrentGoodsList`, `SC:293-303`) of `GoodsItem1` cells, page buttons, "Recarregar" button (`SIV:155-159`), balances | Itens, Herói, Einherjar, Espírito, Outros tabs and search | `ShopGoodsInfo` rows of the tab |
| `view.GoodsItem1` (extends `GoodsItem`) | | One row: icon, name, price + currency icon (`_lineImg.setFrame(PayType)`), label ("Novo", "Recomendado", "Popular" frames for `Labels` 1..3, hidden when `Discount != 0`, `GI1:68-87`), daily limit text, "Esgotado" when `OneCurrentCount >= OneDayCount` (`GI1:88-100`), buy button, "Provar" try on button for fashion (`GI:159-191`) | grid | |
| `view.inside.ShopBoxView` | "Baú de Moda" / "Baú de Montaria" | Lottery boxes | box tabs | see [boxes.md](boxes.md) |
| `view.ShopFrame` search | | Free text search over all ShopType 1 rows except Area 10 and Area 52 (`SC.searchGoods`, `SC:264-286`); empty text -> "Insira nome da mercadoria que procura!!" (`SF:118-131`) | search button | results in the inside grid |

Dead views present in the module but never instantiated in this build: `view.main.ShopMainView` (`HomepageTopView`, `HomepageRightView` showing `mainNewList` and `mainUrlList` banners), `view.inside.ShopFashionView`, `view.limiteTimeDiscountBuy.LimiteTimeDiscountView` (verified by global search for `new ...`).

## 3. Routes (client to server)

The mall itself has no listing route. User actions:

| Action | UI | Route |
|---|---|---|
| Buy a row | `GoodsItem.__onBuyBtnHandler` (`GI:198-420`): ShopType 1 rows open `BuyFrameI` directly (`GI:418`, `quickbuy.buyFrame`) | 8970 `C_SHOPCAR_BUY`, [purchase.md](purchase.md) R2 |
| Add to cart, open cart, gift | `BuyFrameI` buttons, cart buttons | client state then 8970, [cart-gifts.md](cart-gifts.md) |
| Open home tab | `TAB.updateTimeBuyView` (`TAB:220-245`) -> `ShopTimeBuyView.initTimeGoods` | 8632 `C_FLASH_SALE_FRESH`, [timebuy.md](timebuy.md) |
| Open box tab | `ShopBoxView` constructor | 9613 `C_FASHION_MOUNT_LOTTERY` type 4 and 5, [boxes.md](boxes.md) |
| "Loja Misteriosa" button in the home tab right column | `MainRightView.__onMysteryHandler` (`decompiled/m15/scripts/view/inside/MainRightView.as:109-120`), level >= 26 | opens [outer-city-shop.md](outer-city-shop.md) |
| Recharge | `ShopInsideView.__onRechargeHandler` | external recharge page (HTTP, [../recharge/README.md](../recharge/README.md)) |

## 4. Server messages (server to client)

Pushed at login or on change, consumed by the mall (details in the referenced modules):

| Opcode | Name | Module |
|---|---|---|
| 4145 (0x1031) | `U_C_SHOP_HASBUY` | [purchase.md](purchase.md) S5, sets `OneCurrentCount` of mall rows |
| 4238 (0x108e) | `U_C_SHOP_MAIN` | [timebuy.md](timebuy.md), offers for the home tab |
| 4375 (0x1117) | `U_C_SHOP_DISCOUNT` | [timebuy.md](timebuy.md) |
| 4547 (0x11c3) | `U_C_FLASHSALE_FRESH` | [timebuy.md](timebuy.md) |
| 4599 (0x11f7) | `U_C_BUY_DISCOUNT` | [purchase.md](purchase.md) S1 |
| 4783 (0x12af) | `U_C_SHOPCAR_RESULT` | [purchase.md](purchase.md) S2 |
| 344 (0x0158) | `U_C_SHOP_TEMPLATE_MSG` | [purchase.md](purchase.md) S7 |
| 4890 (0x131a) | `U_C_SHOP_DISCOUNT_INFO` | [promotions.md](promotions.md) |

## 5. Rules and formulas

- Tabs by `Area` (`SMOD:240-263`): 2 Itens (63 rows), 16 Herói (34), 18 Einherjar (21), 12 Espírito (26), 4 Outros (16), 52 hidden (180 rows, only reachable through quick buy frames of other features, excluded from search). Areas 6 (9 rows), 8 (9 rows, returning player items paid with item 2125048, PayType 8) and 10 (9 rows) have no tab; Area 6 and 8 rows are still found by search, Area 10 is excluded from search. Rows whose item template is missing are skipped. Each list is sorted by `Sort` ascending.
- Page size 9 (`SC:293-303`, `SMOD.resetData`).
- Price and currency: [purchase.md](purchase.md) section 5. In the mall 346 rows are priced in `GiftToken` (PayType 2: bound diamonds allowed with "Diamante vinculado prioritário"), 12 in `Point` (PayType 1: diamonds only), 9 in item 2125048.
- No level, VIP or limit requirement is set on any ShopType 1 row (`VIP0Count = -1`, `NeedMinVip = 0`, `NeedGrades = 0` for all 367 rows); the opening level is 10.
- Labels: `Labels` 1 = new, 2 = recommended, 3 = hot (`SGI` constants `NEW_GOODS`, `RECOMMENDED_GOODS`, `HOT_GOODS_FLAG`); every mall row has `Labels = 1`. `IsHot` (124 rows true) is not read by the mall grid.
- Default panel: when the time buy list is empty and the mall is opened from the time buy tip, the tip shows a message instead of opening (`decompiled/m16/scripts/tasktracetip/view/ShopTimeBuyTipView.as:62`).

## 6. Templates

| File | Record | Fields |
|---|---|---|
| `raw/xml/tempinfos/ShopTempInfos.xml` | ShopType 1 rows (367), `Id` 1..61700037 | `Id`, `Area`, `ItemId`, `Point`, `GiftToken`, `Score`, `NeedItem`, `Sort`, `Labels`, `Discount`, `IsHot`, `VIP0Count` |
| item templates ([../inventory/README.md](../inventory/README.md)) | `GoodsTemplateInfo` | `TemplateName` (search), `SonType` (fashion try on, mount card checks) |

## 7. Persistent state

None specific to the mall. Counters and logs: [purchase.md](purchase.md) (`shops.purchase_counter`, `shops.purchase_log`).

## 8. Backend implementation notes

- Load ShopType 1 rows into an in memory index by `Id`; `shops::mall` exposes `find_row(id)` and `is_buyable(row, player)` used by `shops::purchase::handle_cart_buy`.
- Reject purchases of rows whose item template is missing (result 8) and rows of Area 52 only if the owning feature forbids direct purchase (assumption: Area 52 rows are bought by quick buy frames of other features through 8970 and must stay buyable).
- At login send, in this order (assumption on order, all are pushes the client stores): 344 dynamic templates, 4238 offers, 4890 limited discount state, then answer 8218 with 4145 when the client asks.

## 9. Open questions and assumptions

- Assumption: Area 6 and Area 10 rows are gem and fashion pages of an older mall layout; nothing in this build shows them.
- Open: whether the original server pushed 4238 in several chunks (the `flag` field supports it, see [timebuy.md](timebuy.md)).

## 10. Implementation checklist

- [ ] Screen ShopFrame with tabs, search and 9 item pages (client, data from XML)
- [ ] Index of ShopType 1 rows on the server
- [ ] Buy path via 8970 for ShopType 1 rows (PayType 1, 2, 8)
- [ ] Login pushes 344, 4238, 4890 and reply to 8218
- [ ] Tests: buy a GiftToken row with bound diamonds, buy a Point row with bound diamonds rejected, buy an Area 8 row with item 2125048
