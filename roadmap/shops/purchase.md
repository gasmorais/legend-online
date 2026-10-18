# Generic purchase pipeline (compra, limites, cupons)

Every shop whose rows live in `ShopTempInfos.xml` (the mall ShopType 1 and all currency shops listed in [catalog.md](catalog.md)) and every discount offer pushed in `MainDiscountInfo` (see [timebuy.md](timebuy.md), [promotions.md](promotions.md)) is bought through the same client pipeline: an optional limit query (8693), the generic buy frame `BuyFrameI`, and the cart purchase opcode 8970. This module documents that pipeline, the price and limit rules, coupons, bound diamonds and result codes. Cart and gift flows are in [cart-gifts.md](cart-gifts.md).

Path aliases:

| Alias | File |
|---|---|
| SM | `decompiled/core_module/scripts/managers/ShopManager.as` |
| SMOD | `decompiled/core_module/scripts/mvc/module/shop/ShopModel.as` |
| SGI | `decompiled/core_module/scripts/mvc/module/shop/ShopGoodsInfo.as` |
| MSI | `decompiled/core_module/scripts/mvc/module/shop/MainShopInfo.as` |
| BF | `decompiled/core_module/scripts/yishi/view/frame/BuyFrameI.as` |
| SMBF | `decompiled/core_module/scripts/yishi/view/frame/ShopMainBuyFrame.as` |
| GI | `decompiled/m15/scripts/view/GoodsItem.as` |
| DU | `decompiled/core_module/scripts/yishi/view/frame/discount/DiscountUtil.as` |
| DC | `decompiled/core_module/scripts/yishi/view/frame/discount/DiscountCons.as` |
| QBF | `decompiled/core_module/scripts/ui/resourcebar/view/quickbuy/QuickBuyFrame.as` |

## 1. Overview

- A shop row (`ShopGoodsInfo`) has one price column; `SGI.setPrice` (`SGI:469-738`) derives `PayType` and `price` from the first non zero column in a fixed order (table in section 5). The client never sends the price: the server recomputes it from the template.
- A discount offer (`MainShopInfo`, built from `MainDiscountInfo`) always costs diamonds (`price`, `MSI:319-322`) and is bought with `is_discount = true`.
- Purchase routes actually used by this client build: 8693 (limit query, optional), 8970 (purchase), 5633 (quick buy and use, blood shop). Routes 5154 and 8592 exist in `SM.sendShoping` (`SM:604-643`) but `sendShoping` has no caller anywhere in the decompiled client (verified with a global search), so 5154 `U_C_SHOP_BUY` and 8592 `C_FASHION_SHOP_BUY` are dead in this build. They are documented here because the server must still accept them if another client build sends them.
- Purchase counters reach the client three ways: 4145 at login (all counters), 4599 per item (answer to 8693), 528 (weekly limit sync for a few PvP shops).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `yishi.view.frame.BuyFrameI` (style `quickbuy.buyFrame`) | "Comprar" (`campaign.TrailShop.BuyBtnTxt`, `BF:197`) or "Presentear" when the gift tab is selected (`BF:1071`) | Quantity picker (1..9999), price, currency icon, "Diamante vinculado prioritário" checkbox, "(Não participa no evento de consumo)" note, coupon selector, "Adicionar ao carrinho" | `GoodsItem.__onBuyBtnHandler` (`GI:198-420`) of every ShopTempInfos grid; `ShopManager.quickUIcallback` (`SM:274-300`) after 4599 when `currBuyGoods2` is set | item icon and name, unit price x quantity, balance of the paying currency (`BF.PayMoney`, `BF:1311-1495`), daily or weekly limit (`BF.refreshLimitView`, `BF:1527-1641`) |
| `yishi.view.frame.ShopMainBuyFrame` (style `shop.ShopMainBuyFrame`) | "Comprar" | Same frame for `MainShopInfo` offers, diamonds only (`SMBF:78-81`) | `SM.quickUIcallback` when `currBuyGoods` is set | offer content, price, limits |
| `yishi.view.frame.ArtifactBuyFrame` (style `artifact.buyFrame`) | "Comprar" | Same as above for MainDiscountInfo type 7 (artifact offers, owned by [../divine-weapon/README.md](../divine-weapon/README.md)) | `SM.quickUIcallback` when `currBuyGoods3` is set | |
| `yishi.view.frame.ShopLimiteTimeDiscountBuyFrame` | "Comprar" | Buy frame for `LimiteTimeDiscountInfo` (4890 offers); its only opener `LimiteTimeDiscountView` is never instantiated, see [promotions.md](promotions.md) | none in this build | |
| `yishi.view.frame.NumBuyFrame` (style `numbuy.numbuyFrame`) | "Comprar" | Quantity picker used by point exchanges (mystery exchange, see [../auction/mystery-shop.md](../auction/mystery-shop.md)) | `ExchangeGoodsItem.showBuyFrameCall` | |
| `ui.resourcebar.view.quickbuy.QuickBuyFrame` | `mainBar.view.quickbuy.QuickBuyFrame.title` | Quick buy and use of blood potions (ShopType 100) | resource bar blood button | rows of `getBloodShopTempInfoList()` (`QBF:81`) |

## 3. Routes (client to server)

### R1. Query bought count of one item (8693)

- UI: buy button of a grid item whose ShopType is 2, 17, 1004, 1005, 20, 1034, 1008, 1009, 1010, 1011, 1012, 1014, 1027, 1029, 1030, 1031 (`GI:231-416`), VIP shop items (`decompiled/m15/scripts/vip/VipShopItem.as:195`), time buy items (`decompiled/m11/scripts/timebuy/TimeBuyItem.as:156-167`, `decompiled/m15/scripts/view/GoodsItem5.as:148`), promotional items and gift boxes (`decompiled/m15/scripts/view/inside/ShopTimeItem.as:170`, `decompiled/m15/scripts/view/inside/ShopGiftBoxView.as:111,169`), artifact offers (`decompiled/m15/scripts/view/GoodsItem9.as:108`), funny hot buy (`decompiled/core_module/scripts/funny/view/FunnyHotBuyItem.as:150`).
- Sender: `ShopManager.getGoodsBuyNum(goodId, type, isDiscount = true)` (`SM:930-940`). Before sending, the caller stores the item in `ShopManager.currBuyGoods` (MainShopInfo), `currBuyGoods2` (ShopGoodsInfo) or `currBuyGoods3` (artifact) and may set `ShopManager.type` (only used by the dead 5154 path).
- Client checks: none before sending. Some shops check the currency balance first (`GI:337-385`: Ares heart, Athena tear, garden prop coin, flame temple coin, dusk area coin, dark maze coin).
- Route: send 8693 (0x21f5) `C_BUY_DISCOUNT`, message `com.road.yishi.proto.shop.ShopMsg`:
  - `buyInfo` (#1, BuyInfo): `good_id` (#2, INT32) shop row Id or discount offer id; `type` (#6, INT32) query kind: 0 = plain row or MainDiscountInfo type 1, 2 = loop offer (type 2), 4 = promotional offer, 5 = daily free gift, 6 = daily consume gift, 7 = artifact offer, 1027/1029/1030/1031/1033/1034 = shop type of the row; `is_discount` (#1, BOOL) true for MainDiscountInfo offers, false for ShopTempInfos rows; `count` (#3), `receive_id` (#4), `result` (#5) unset.
  - `hasDataInfo` (#2), `refresh_date` (#3), `pay_type` (#4), `item_templateId` (#5), `refresh_interval` (#6) unset.
- Expected response: 4599 (S1) echoing `good_id` and `type` with `count` = units already bought in the current limit period.

### R2. Buy one line or a cart (8970)

- UI and senders (all build `ShopCarListMsg`):
  - `BuyFrameI.buy` (`BF:920-955`) -> `ShopManager.buyOne(id, num, selfId, payType, isDiscount, couponId)` (`SM:1205-1220`). `payType` = 2 when "Diamante vinculado prioritário" is checked, else 1 (`BF:937-944`).
  - `ShopMainBuyFrame.__confirmHandler` (`SMBF:83-135`) and `ArtifactBuyFrame.__confirmHandler`: `buyOne(offerId, num, selfId, 1, true, couponId)`.
  - `ShopLimiteTimeDiscountBuyFrame.__confirmHandler` -> `buyOneNew(id, num, selfId, payType, true, 1, couponId)` (`SM:1222-1238`): the only sender that sets `CarItemInfoMsg.type = 1`.
  - `NumBuyFrame` (`decompiled/core_module/scripts/yishi/view/frame/NumBuyFrame.as:192,196`), `ExchangeGoodsItem` (`decompiled/m7/scripts/auction/view/mysteryshop/ExchangeGoodsItem.as:161`), `MineralShopItem` (`decompiled/m15/scripts/view/subshop/MineralShopItem.as:164`), `TheseusCollentionShopView` (`decompiled/m5/scripts/theseusCollention/shop/TheseusCollentionShopView.as:330,345`), `UpgradePresentManager` (`decompiled/core_module/scripts/yishi/manager/UpgradePresentManager.as:76`), `FashionSwitchItem` (`decompiled/m14/scripts/fashion/FashionSwitchItem.as:505`), secretary auto buy actions (`decompiled/core_module/scripts/mvc/module/secretary/acts/DixAction.as:129`), seasonal treasure boxes (`decompiled/m3/scripts/year2023/frame/YearActiveTreasureBoxFrame.as:629`, `decompiled/m11/scripts/sevenyear/SevenYearTreasureBoxFrame.as:640`): `buyOne(id, num, selfId, item.PayType or 1, false)`.
  - Cart and gift senders `allBuy` / `allFashion` / gift `buyOne`: see [cart-gifts.md](cart-gifts.md).
- Client checks in `BuyFrameI.__confirmHandler` (`BF:656-901`), in order:
  1. Mount card already owned (SonType 218 with `Property2 < 0`, or SonType 212 material whose compose result is an owned permanent mount): "shop.view.frame.BuyFrameI.mopupexitst" (`BF:676-711`).
  2. `price x num (minus coupon)` > balance of the paying currency (`BF.PayMoney`): PayType 1 or offers -> recharge alert; PayType 2 -> recharge alert; other PayTypes -> currency specific message such as "Moeda necessária insuficiente" (`shop.view.frame.BuyFrameI.MoneyLack`), "Contribuição insuficiente" style keys (`BF:714-860`).
  3. Maze shop equipment already in a bag: confirm `BuyFrameI.tip01/tip02` (`BF:865-873`).
  4. `checkExist` mount card check again (`BF:874-880`).
  5. Item 30000013 (dungeon exploration ticket) is not bought here: `DungeonExploManager.sendDungeonOperate(5,0,0,num)` (`BF:881-886`).
  6. Quantity clamp: `1 <= num <= min(9999, canBuyNum, floor(balance / price))` (`BF:1130-1256`, `BF.currentCanCount` `BF:1287-1299`).
- Route: send 8970 (0x230a) `C_SHOPCAR_BUY`, message `com.road.yishi.proto.shop.ShopCarListMsg`:
  - `result` (#1, INT32) unset on request.
  - `receiveUserId` (#2, INT32) receiver player id; the buyer's own id for normal purchases.
  - `discountTempId` (#3, INT32) coupon item template id (3170001, 3170002, 3170003, 3171001, 3172001, 3173001) or 0 (`BF:927-931`).
  - `carItemInfo` (#4, CarItemInfoMsg, repeated), one entry per line: `shopId` (#1, INT32) ShopTempInfos Id or MainDiscountInfo id; `counts` (#2, INT32) quantity; `payType` (#3, INT32) 1 = diamonds or the row's own currency, 2 = bound diamonds first (only meaningful for PayType 2 rows), other callers pass the row's PayType (for example 4, 12); `isDiscountShop` (#4, BOOL) true when `shopId` is a MainDiscountInfo id; `type` (#5, INT32) 1 only for LimiteTimeDiscount offers, otherwise 0.
  - `isMail` (#5, BOOL) unset on request.
- Expected response: 4783 (S2), then resource pushes (diamonds, bound diamonds, gold, currency 4725, bag item adds) owned by [../currency/README.md](../currency/README.md) and [../inventory/README.md](../inventory/README.md).

### R3. Legacy single buy (5154), dead in this build

- Sender: `ShopManager.sendShoping(goodId, count, receiveId, isDiscount, opcode = 5154, allowBind = true, itemTemplateId = 0)` (`SM:604-643`); no caller.
- Route: send 5154 (0x1422) `U_C_SHOP_BUY`, `ShopMsg`: `buyInfo` (#1): `good_id` (#2), `count` (#3), `receive_id` (#4, 0 replaced by own id), `is_discount` (#1), `type` (#6) = `ShopManager.type`; `pay_type` (#4, INT32) 0 = bound diamonds allowed, 1 = not; `item_templateId` (#5, INT32).
- When `opcode == 8592` the same data goes to send 8592 (0x2190) `C_FASHION_SHOP_BUY` as `FashionShopMsg`: `buyInfos` (#1, BuyInfo, repeated), `pay_type` (#3), `item_templateId` (#4), `result` (#2, BOOL) unset.
- Expected response: 90 (S3). For 8592 the reply opcode would be 4486 `U_C_FASHION_SHOP_BUY`, which has no client listener.

### R4. Quick buy and use (5633)

- UI: `QuickBuyFrame` confirm (`QBF:197`).
- Sender: `ShopManager.sendShopingBloo(goodId, count = 1, allowBind = true)` (`SM:884-900`).
- Route: send 5633 (0x1601) `C_FAST_USE_BLOOD`, `ShopMsg`: `buyInfo` (`good_id` (#2), `count` (#3), `receive_id` (#4) = own id), `pay_type` (#4) 0 or 1.
- Expected response: 170 (S4).

### R5. Login counters request (8218)

- Sender: `ShopManager.getBuyDataInfos()` (`SM:916-920`), called once after entering the game (`decompiled/core_module/scripts/yishi/lunch/Yishi.as:622`).
- Route: send 8218 (0x201a) `U_C_SHOP_HASBUY`, empty body.
- Expected response: 4145 (S5).

## 4. Server messages (server to client)

### S1. 4599 (0x11f7) `U_C_BUY_DISCOUNT`

- Message `ShopMsg`: `buyInfo` (#1): `good_id` (#2) echo, `type` (#6) echo, `count` (#3) bought in the current period, `is_discount` (#1) echo.
- Receiver: `ShopManager.__shopBuyDiscount` (`SM:210-247`): stores `ShopManager.count`; type 5 -> `dayGiftCount`, type 6 -> `costGiftCount` and dispatch `SHOP_TIME_GIFT_REFRESH` without opening a frame; type 7 -> artifact counts; types 1027/1031 also dispatch `SHOP_TIME_GIFT_REFRESH`; then opens the buy frame for the pending `currBuyGoods*` (`SM:274-300`).
- When: reply to R1. Must be sent even when nothing was bought (count 0), otherwise the buy frame never opens.
- The buy frame shows `remaining = limit - ShopManager.count` (`BF:1585-1609`).

### S2. 4783 (0x12af) `U_C_SHOPCAR_RESULT`

- Message `ShopCarListMsg`: `result` (#1, INT32) result code (section 5), `receiveUserId` (#2), `discountTempId` (#3), `carItemInfo` (#4, repeated) lines actually bought, `isMail` (#5, BOOL) true when items went to mail because the bag was full.
- Receivers: `BuyFrameI.__shopResult` only when a callback was set (`BF:1507-1525`, success when `result == 1`); `ShopCartFrame.__shopCartHandler` clears the cart on `result == 1 or 12` ([cart-gifts.md](cart-gifts.md)); `FashionAllBuyFrame.__succeedHandler`; secretary actions.
- No generic toast is attached to 4783. Assumption: the server sends the result text through the system message channel (the client strings `shop.utils.ShopingHelper.command01..23` are only bound to 90).
- Counters: the client does not increment `OneCurrentCount` on 4783. The server must push the updated counter (4145 delta or 4599) after a limited purchase. Assumption based on `SM:422-492` and `SM:645-691`.

### S3. 90 (0x005a) `U_C_SHOP_BUY`

- Message `ShopMsg.buyInfo`: `good_id`, `count`, `receive_id`, `result` (#5), `is_discount`.
- Receiver: `ShopManager.__shoppingHandler` (`SM:645-691`), registered only by `sendShoping`; also `ShopMainBuyFrame.__shopResult` and `ArtifactBuyFrame.__shopResult` when a callback is set (`SMBF:117`).
- Reaction: `shopingResult(result)` toast (`SM:966-1060`); on 1 or 12 increments `oneCurrentCount`/`count` of the offer or `OneCurrentCount` of the row (unless `OneDayCount == -1`).

### S4. 170 (0x00aa) `U_C_FAST_USE_BLOOD`

- Message `com.road.yishi.proto.item.FastUseBloodMsg`: `result` (#1, INT32), `template_id` (#2, INT32).
- Receiver: `ShopManager.__shoppingBlooHandler` (`SM:902-914`): toast by result code.

### S5. 4145 (0x1031) `U_C_SHOP_HASBUY`

- Message `ShopMsg.hasDataInfo` (#2, repeated `HasDataInfo`): `user_id` (#1, INT32), `item_id` (#2, INT32) shop row Id or offer id, `counts` (#3, INT32) bought in current period, `buy_date` (#4, STRING `YYYY-MM-DD hh:mm:ss`), `is_discount` (#5, BOOL).
- Receiver: `ShopManager.__getBuyDataInfosSuccess` (`SM:422-492`): `is_discount` rows update `oneCurrentCount`/`count` of time buy and artifact offers; other rows set `OneCurrentCount` of the mall row (`SMOD.getShopTempInfoById`, ShopType 1 only); dispatch `SHOP_TIME_BUY_REFRESH`.
- When: reply to R5 and, assumption, after each limited purchase and at each period reset.

### S6. 528 (0x0210) `U_C_FROST_HEART_SHOP`

- Message `com.road.yishi.proto.player.CommonMsgList.list` (#1, repeated `CommonMsg`): `param1` (#1, INT32) shop row Id, `param2` (#2, INT32) bought count.
- Receiver: `ShopManager.shopBuyHandler` (`SM:146-161`): looks the Id up in ShopTypes 3, 1020, 1021, 1030, 1035 (`SM:163-208`) and sets `OneCurrentCount`; dispatch `BTHESSOXSHOPBUYEFF`. Also listened by `GloryroadManager`, `AresLordsManager`, `ApexManager`, `ConsortiaManager` for their own shops (`decompiled/core_module/scripts/managers/GloryroadManager.as:54`, `decompiled/core_module/scripts/yishi/manager/AresLordsManager.as:138`, `decompiled/core_module/scripts/yishi/manager/ApexManager.as:90`, `decompiled/core_module/scripts/yishi/manager/ConsortiaManager.as:187`).
- When: push after a purchase in a weekly or season limited shop, and on open of those shops (assumption).

### S7. 344 (0x0158) `U_C_SHOP_TEMPLATE_MSG`

- Message `ShopTempInfoListMsg`: `shop_type` (#1, INT32), `shopTempInfo` (#2, repeated `ShopTempInfoMsg`: `id` (#1), `shopType` (#2), `area` (#3), `itemId` (#4), `point` (#5), `giftToken` (#6), `gold` (#7), `crystal` (#8), `consortiaOffer` (#9), `honor` (#10), `mazeCoin` (#11), `mazeLayers` (#12), `mazeLayers2` (#13), `needGrades` (#14), `needConsortiaLevels` (#15), `needMinVip` (#16), `vIP0Count`..`vIP9Count` (#17..#26), `firstPrice` (#27), `discount` (#28), `price` (#29), `sort` (#30), `isHot` (#31, BOOL), `labels` (#32), `needGeste` (#33), `validDate` (#34), `rands` (#35), `needScore` (#36), `needMinGrade` (#37), `needMaxGrade` (#38), `isNeedPoint` (#39, BOOL), `lordsScore` (#40), `needItem` (#41), `mineScore` (#42), `crossGuildScore` (#43), `leagueMedal` (#44), `pokerScore` (#45)), all INT32 unless noted.
- Receiver: `ShopManager.__shopTempDataHandler` (`SM:773-835`): builds `ShopGoodsInfo` rows sorted by `Sort` into `ShopModel.shopTempDic[shop_type]`; for 1003 it opens the poker shop list. `crystal`, `firstPrice`, `price`, `isNeedPoint`, `leagueMedal` are ignored by the client.
- When: server pushed dynamic shop definitions for ShopTypes that have no XML rows (1003 Texas Poker shop, 1005 Bingo "Loja da Maçã", read by `SC.initPokeShopData` and `SC.initBingoData`, `decompiled/core_module/scripts/mvc/controler/ShopControler.as:772-820`). Owners: [../casino/README.md](../casino/README.md).

## 5. Rules and formulas

Price derivation (`SGI.setPrice`, `SGI:469-738`), first match wins:

| Condition | PayType | Price column | Paying balance (`BF.PayMoney`) |
|---|---|---|---|
| ShopType 8 | 1001..1011 by `NeedItem` template `Property1 - 101` | `Score` | bag count of `NeedItem` (`BF:1366`) |
| ShopType 15 | 1007 | `Score` | |
| ShopType 1033 | 1033 | `Score` | currency 41 `gemDust` |
| ShopType 1035 | 1035 | `Score` | |
| `Point > 0` | 1 diamonds only | `Point` | `point` (+ coupon) |
| `GiftToken > 0` | 2 bound diamonds allowed | `GiftToken` | `point` or `point + giftToken` when bind checkbox set |
| `Gold > 0` | 3 | `Gold` | gold resource |
| `Honor > 0` | 5 | `Honor` | currency 8 `arenaMedal` |
| ShopType 17 | 12 | `Score` | currency 6 `guildSkill` |
| `ConsortiaOffer > 0` | 4 | `ConsortiaOffer` | `consortiaOffer` |
| `MazeCoin > 0` | 6 | `MazeCoin` | item 208009 + currency 11 |
| `LordsScore > 0` | 7 | `LordsScore` | currency 18 `aresHeart` |
| ShopType 16 | 13 | `Score` | currency 20 `athenaTear` |
| `CrossGuildScore > 0` | 10 | `CrossGuildScore` | currency 19 `yarramanCoin` |
| `NeedItem == 2125048` | 8 | `Score` | bag count of 2125048 |
| ShopType 14 | 11 | `CrossLeagueMedal` | `crossLeagueMedal` |
| ShopType 19, 20, 1003, 1004, 1005, 10, 1015, 1008, 1009, 1010, 1011, 35, 1012, 1014, 1016, 1017, 1018, 1020, 1021, 1022, 1023, 1024, 1027, 37, 38, 1029, 1030, 1031, 1034 | 15, 16, 17, 18, 19, 7, 30, 20, 21, 22, 28, 25, 2001, 29, 31, 32, 33, 37, 38, 1022, 39, 40, 41, 42, 43, 44, 45, 46, 1034 | `Score` (`PokerScore` for 1003) | see [catalog.md](catalog.md) |
| otherwise | 1 | 1 | |

Limits:
- `ShopGoodsInfo.OneDayCount` is always `VIP0Count` regardless of the VIP level (`SGI:813-816`); `-1` means unlimited. `VIP1Count..VIP9Count` are loaded but never used by the client. `canOneCount = OneDayCount - OneCurrentCount` (`SGI:784-791`); `canTotalCount` is always -1 for rows (`SGI:793-796`).
- Limit period by ShopType (`BF.isWeeklyLimit`, `BF:1643-1653` and label keys `BF:1585-1603`): weekly ("Limite de Compra Semanal:") for 1015, 10, 1008, 1016, 3, 1020, 1021, 1030; season ("Compra Limitada da Temporada") for 1027, 1031; monthly ("Limite de compra mensal:", `TheseusDungeonEventInfo.message15`) for 1034; daily ("Limite Diário") for every other ShopType.
- Assumption: daily limits reset at 00:00 server time (mall help text for the mystery shop says 5:00; no mall specific text exists), weekly limits on Monday 00:00, season limits when the owning feature's season rolls.
- Discount offers (`MainShopInfo`, `MSI:135-206`): `canTotalCount = maxCount - currentCount` server wide (for types other than 2 only when `maxCurrentDate` is today, else `maxCount`); `canOneCount` per player: type 1 `oneDayCount - oneCurrentCount`, types 2/4/7 `oneDayCount - count`, type 5 `oneDayCount - dayGiftCount`, type 6 `oneDayCount - costGiftCount`; `-1` = unlimited.
- Quantity per purchase: 1..9999 (`BF:1150-1160`).
- Minimum level: `NeedMinGrade`/`NeedMaxGrade`, `NeedGrades` (farm level for ShopType 6), `NeedConsortiaLevels` (guild shop level), `MazeLayers`/`MazeLayers2` (maze floor), `NeedGeste` (PvP rank) are shown as disabled reasons by `GoodsItem.setFilter` (`GI:565-650`); server must enforce them (result 7, 9, 10).
- Bound diamonds: only rows with PayType 2 (price in `GiftToken`) may consume bound diamonds; with `payType = 2` the server spends bound diamonds first and then diamonds. Items bought with any bound diamond are bound ("Esta compra contém diamantes vinculados, por isso os itens são vinculados", `view.subshop.ShopCartFrame.buyText1`). Bound diamond spending does not count toward consume events ("(Não participa no evento de consumo)", `BF:196`). PayType 1 rows, MainDiscountInfo offers and gifts are diamonds only (`view.shopFrame.buyFrameI.shopCartItem.fault`, `view.shopFrame.giving.bind`).
- Mall data (`raw/xml/tempinfos/ShopTempInfos.xml`, ShopType 1, 367 rows): 346 rows priced in `GiftToken`, 12 in `Point`, 9 returning player rows (Area 8, `NeedItem` 2125048, `Score`); all `VIP0Count = -1` (unlimited), `Discount`, `Price`, `FirstPrice`, `ValidDate` all 0.

Coupons (`DU`, `DC`, `raw/xml/tempinfos/ConfigInfos.xml`):

| Coupon template | Config key | Value | Usable on (`BF.getSonType`, `BF:486-509`, `DU.isInitDiscountUI`) |
|---|---|---|---|
| 3170001 | `50_coupons` | spend >= 500 -> minus 50 | any PayType 1/2 row or offer type 1/2 |
| 3170002 | `200_coupons` | spend >= 1000 -> minus 200 | same |
| 3170003 | `2000_coupons` | spend >= 5000 -> minus 2000 | same |
| 3171001 | `prop_coupons` | 1000->100, 2000->400, 3000->900 | mall rows with Area 2 ("prop") |
| 3172001 | `gem_coupons` | 1000->100, 2000->600, 3000->1500 | category 2 (gems); no client code maps a row to category 2 |
| 3173001 | `fashion_coupons` | 1000->100, 2000->400, 3000->900 | fashion items (SonType 109..112) |

- Discount amount: highest tier whose threshold `<= price x num` (`DU.getDiscountNumByIdAndPrice`, `DU:12-41`). The coupon is found in bag, mail or bottle (`DU:46-74`). A coupon purchase cannot be a gift (result 23).
- VIP shop discount (ShopType 1033): price = `floor(Score x para1 / 100)` with `para1` from `VipPrerogativeTempInfos` type 208 for the VIP grade (95, 95, 95, 90, 90, 90, 90, 90, 85 for VIP 1..9) (`BF:384-399`, `decompiled/m15/scripts/vip/VipShopItem.as:127,147-181`). Owner: [../vip/README.md](../vip/README.md).

Result codes (`SM.shopingResult`, `SM:966-1060`, strings `shop.utils.ShopingHelper.commandNN`):

| Code | pt-BR | Meaning |
|---|---|---|
| 1 | "Compra sucedida" / "Presenteado com sucesso" (gift) | success |
| 2 | "Usuário a presentear inexistente" | receiver not found |
| 3 | "Mercadoria inexistente" | unknown shop id |
| 4 | (silent) | currency insufficient (`command04` "Moeda do usuário insuficiente" exists but code 4 returns silently) |
| 5 | "Erro de parâmetros" | bad parameters |
| 6 | "Limite de quantidade ultrapassada", "Esgotado" when the server stock is 0, "Compras máximas atingidas pelo amigo" (gift) | limit reached |
| 7 | "Restrição de nível mínimo VIP" | `NeedMinVip` |
| 8 | "Módulo de mercadoria inexistente" | item template missing |
| 9 | "Restrição de nível da Guilda" | guild shop level |
| 10 | "Restrição de nível do Líder" | player level |
| 11 | "Falha na dedução" | debit failed |
| 12 | "Compra sucedida, mochila cheia, item foi enviado no email" | success, items mailed |
| 15 | "Você já possui essa Montaria, não é possível comprar" | permanent mount already owned |
| 17 | "Função de troca abrirá em breve" | shop closed |
| 18 | "Jogador já possui essa montaria, não é possível presentear" | gift mount owned |
| 19 | "Habilitando VIP poderá comprar" | VIP required |
| 20, 22 | "Cupons de desconto ou cupons insuficientes" | coupon missing |
| 21 | "Valor de consumo insuficiente, não é capaz de usar este item" | coupon threshold not met |
| 23 | "Usando os cupons ou cupons de desconto para comprar, não pode presentear a outros." | coupon on gift |

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `raw/xml/tempinfos/ShopTempInfos.xml` | `ShopTempInfo`, 1183 rows, unique `Id` across all ShopTypes; dispatched by ShopType into 50 dictionaries (`decompiled/core_module/scripts/yishi/resolve/ShopGoodsInfoResolve.as:165-366`, `decompiled/core_module/scripts/yishi/manager/TempleteManager.as:2608-2660`) | `Id`, `ShopType`, `Area` (mall tab), `ItemId`, price columns (`Point`, `GiftToken`, `Gold`, `ConsortiaOffer`, `Honor`, `MazeCoin`, `Score`, `LordsScore`, `CrossGuildScore`, `CrossLeagueMedal`, `PokerScore`, `MineScore`, `NeedItem`), requirements (`NeedGrades`, `NeedMinGrade`, `NeedMaxGrade`, `NeedConsortiaLevels`, `NeedMinVip`, `NeedGeste`, `MazeLayers`, `MazeLayers2`), `VIP0Count` limit, `Sort`, `IsHot`, `Labels`, `ValidDate` (item validity), `Rands` (rarity, mystery shop), `SellMaxCount` (unused by client), `Discount`, `Price`, `FirstPrice` (unused) |
| `raw/xml/tempinfos/ConfigInfos.xml` | coupon keys above | `ConfigValue` |
| `raw/xml/tempinfos/VipPrerogativeTempInfos.xml` | type 208 | `grade`, `para1` VIP shop discount percent |

## 7. Persistent state

```sql
CREATE SCHEMA IF NOT EXISTS shops;

CREATE TABLE shops.purchase_counter (
  player_id     INTEGER     NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  source        SMALLINT    NOT NULL CHECK (source IN (0, 1)),
  offer_id      INTEGER     NOT NULL,
  period_kind   SMALLINT    NOT NULL CHECK (period_kind BETWEEN 0 AND 5),
  period_start  TIMESTAMPTZ NOT NULL,
  bought_count  INTEGER     NOT NULL DEFAULT 0 CHECK (bought_count >= 0),
  last_buy_at   TIMESTAMPTZ NOT NULL DEFAULT now(),
  PRIMARY KEY (player_id, source, offer_id, period_start)
);
CREATE INDEX purchase_counter_player_idx ON shops.purchase_counter (player_id, period_start);

CREATE TABLE shops.purchase_log (
  purchase_id        BIGSERIAL   PRIMARY KEY,
  buyer_id           INTEGER     NOT NULL REFERENCES player.players(player_id),
  receiver_id        INTEGER     NOT NULL REFERENCES player.players(player_id),
  source             SMALLINT    NOT NULL CHECK (source IN (0, 1)),
  offer_id           INTEGER     NOT NULL,
  item_template_id   INTEGER     NOT NULL,
  quantity           INTEGER     NOT NULL CHECK (quantity BETWEEN 1 AND 9999),
  pay_type           SMALLINT    NOT NULL,
  diamonds_spent     BIGINT      NOT NULL DEFAULT 0,
  bound_spent        BIGINT      NOT NULL DEFAULT 0,
  currency_id        INTEGER,
  currency_spent     BIGINT      NOT NULL DEFAULT 0,
  coupon_template_id INTEGER,
  coupon_discount    INTEGER     NOT NULL DEFAULT 0,
  result_code        SMALLINT    NOT NULL,
  mailed             BOOLEAN     NOT NULL DEFAULT false,
  created_at         TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX purchase_log_buyer_idx ON shops.purchase_log (buyer_id, created_at DESC);
```

- `source`: 0 = ShopTempInfos row, 1 = MainDiscountInfo offer. `period_kind`: 0 none, 1 daily, 2 weekly, 3 monthly, 4 season, 5 event (offer lifetime). `period_start` is the start of the period the counter belongs to, so old rows expire naturally.
- Server wide stock of offers is in `shops.discount_offer_stock` ([timebuy.md](timebuy.md)).

## 8. Backend implementation notes

- `shops::purchase::handle_buy_count` (8693): load row or offer by (`is_discount`, `good_id`); resolve period from `type`/ShopType; reply 4599 with the counter (0 when missing). Never fail: unknown ids reply count 0.
- `shops::purchase::handle_cart_buy` (8970), single transaction for the whole message:
  1. Validate `receiveUserId` exists (result 2); gifts route through [cart-gifts.md](cart-gifts.md) checks.
  2. For each line: load template (result 3), item template (result 8); shop open check by ShopType (owning feature hook, result 17); requirements: level (10), VIP (7, 19), guild level (9) via `guild::shop::validate_guild_shop_buy`, feature specific hooks (maze floor, PvP rank, farm level, royalty level); permanent mount already owned (15/18).
  3. Limits: per player counter vs `VIP0Count` (or offer `oneDayCount`, `limitCount`), server stock vs `maxCount` (result 6). Clamp `counts` to 1..9999 (result 5 otherwise).
  4. Price: recompute with the `setPrice` order; apply VIP discount for 1033; apply coupon `discountTempId` on the total diamond price of eligible lines (coupon exists in bag or mail: 20/22; threshold: 21; gift: 23); consume one coupon.
  5. Debit: PayType 1 and offers -> diamonds; PayType 2 with `payType = 2` -> bound diamonds first then diamonds, mark the delivered items bound when any bound diamond was used; other PayTypes -> owning currency (`currency::spend`). Insufficient -> result 4; failure -> 11.
  6. Grant `ItemId` x (`counts` x row count multiplier; offers grant `templateId..templateId8` with `counts..count8`) through `inventory::grant`; bag full -> mail and result 12 with `isMail = true`.
  7. Increment counters and stock, insert `purchase_log`, emit consume event (diamonds only) for [../seasonal-events/README.md](../seasonal-events/README.md) and VIP experience hooks.
  8. Reply 4783 echoing lines and `result`; push currency and bag updates; push 4599 or a 4145 delta for limited lines; push 528 for ShopTypes 3, 1020, 1021, 1030, 1035 and the guild/Ares/Apex/Glory shops.
- `shops::purchase::handle_legacy_buy` (5154) and `shops::purchase::handle_fashion_buy` (8592): same validation as one line of 8970 with `pay_type` 0 = bind allowed; reply 90 (or 4486).
- `shops::purchase::handle_quick_use` (5633): buy one ShopType 100 row and use it immediately (blood potion); reply 170.
- `shops::purchase::handle_bought_counters` (8218): reply 4145 with every counter of the current periods (rows and offers).
- Period rollover job `shops::purchase::rollover_counters` (daily 00:00, weekly Monday 00:00): nothing to delete thanks to `period_start`; push 4145 to online players.

## 9. Open questions and assumptions

- Assumption: daily reset at 00:00 server time; the only explicit reset times in strings are mystery shop 5:00 and box points 0:00.
- Assumption: result text for 8970 comes from a generic system message; no 4783 toast exists in the client.
- Open: whether `VIP1Count..VIP9Count` should raise limits on the server (client ignores them; all mall rows are -1 anyway).
- Open: category 2 (gem coupon) mapping; no row maps to it in `BF.getSonType`.
- Open: `SellMaxCount` meaning (all 0 in mall rows).
- Gap: `protocol/proto.json` merges three different `PropertyMsg` messages under one name (army, simple, stargazing); the shop routes 9678 and 9727 use `simple.PropertyMsg` (`param1..param12`).
- Gap: ShopType 100 (blood quick buy) has no rows in `ShopTempInfos.xml` or the packed `raw/xml/tempinfos.xml`, so `QuickBuyFrame` is empty.

## 10. Implementation checklist

- [ ] Template loader for `ShopTempInfos.xml` with the `setPrice` PayType derivation
- [ ] Route 8693 `shops::purchase::handle_buy_count` and encoder 4599
- [ ] Route 8970 `shops::purchase::handle_cart_buy` and encoder 4783
- [ ] Route 5154 `shops::purchase::handle_legacy_buy` and encoder 90
- [ ] Route 8592 `shops::purchase::handle_fashion_buy` and encoder 4486
- [ ] Route 5633 `shops::purchase::handle_quick_use` and encoder 170
- [ ] Route 8218 `shops::purchase::handle_bought_counters` and encoder 4145
- [ ] Encoder 528 weekly limit sync
- [ ] Encoder 344 dynamic shop templates (ShopTypes 1003, 1005)
- [ ] Bound diamond rule (PayType 2 only, items bound, no consume event)
- [ ] Coupon rule (six coupons, tiers, no gift)
- [ ] VIP shop discount (type 208)
- [ ] Limit periods (daily, weekly, monthly, season)
- [ ] Tables `shops.purchase_counter`, `shops.purchase_log`
- [ ] Job `shops::purchase::rollover_counters`
- [ ] Tests: unlimited row, daily limit hit (6), bound diamond split, coupon tiers, bag full mail (12), unknown id (3), level gate (10)
