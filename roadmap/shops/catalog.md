# Shop catalog (every shop screen of the client)

Reference module: maps each `ShopTempInfos.xml` ShopType and every other shop screen to its frame, currency, limit period and owning feature. Purchases of ShopTempInfos rows all go through [purchase.md](purchase.md) (8693 + 8970); owning features add their own requirement checks through hooks.

Path aliases:

| Alias | File |
|---|---|
| SC | `decompiled/core_module/scripts/mvc/controler/ShopControler.as` |
| SGR | `decompiled/core_module/scripts/yishi/resolve/ShopGoodsInfoResolve.as` |
| SGI | `decompiled/core_module/scripts/mvc/module/shop/ShopGoodsInfo.as` |
| BF | `decompiled/core_module/scripts/yishi/view/frame/BuyFrameI.as` |
| CT | `decompiled/core_module/scripts/mvc/module/currency/CurrencyType.as` |
| PCM | `decompiled/core_module/scripts/managers/PlayerCurrencyManager.as` |

## 1. Overview

- `ShopControler.frameClassName` maps `openControllerByInfo("shop", openType, frameData)` to a frame (`SC:57-224`).
- `ShopGoodsInfoResolve.resolveImp` splits `ShopTempInfos.xml` into 50 dictionaries by ShopType (`SGR:165-366`); `TempleteManager.ShopGoodsInfoBack` names them (`decompiled/core_module/scripts/yishi/manager/TempleteManager.as:2608-2660`).
- PayType and price column per ShopType: `SGI.setPrice` (`SGI:469-738`); balance per PayType: `BF.PayMoney` (`BF:1311-1495`); currency ids (`TokenInfoMsg.masterType` on 4725) and pt-BR names: `CT:8-130` and its name switch, `PCM:135-...`.
- Limit period: weekly for ShopTypes 3, 10, 1008, 1015, 1016, 1020, 1021, 1030; season for 1027, 1031; monthly for 1034; daily otherwise (`BF:1585-1653`). Limit = `VIP0Count` (-1 unlimited).

## 2. ShopTempInfos shops

| ShopType | Rows | Frame (openType) | pt-BR title | Price column -> PayType -> currency | Limit | Owner |
|---|---:|---|---|---|---|---|
| 1 | 367 | `view.ShopFrame` (1) | Loja | `GiftToken` (2) bound allowed / `Point` (1) diamonds / `Score`+item 2125048 (8) | daily, all unlimited | [mall.md](mall.md) |
| 2 | 27 | `consortia.ConsortiaShopFrame` (2) | Loja da Guilda | `ConsortiaOffer` (4) contribution | daily | [../guild/shop.md](../guild/shop.md) |
| 3 | 36 | `pvp.PvPShopFrame` (3) | Loja da Arena | `Honor` (5) -> currency 8 "Medalha" | weekly | [../arena/README.md](../arena/README.md) |
| 4 | 15 | `maze.MazeShopFrame` (4) | Loja do Labirinto | `MazeCoin` (6) -> currency 11 "Moedas do labirinto" + item 208009; floor gates `MazeLayers` | daily | [../mazes/README.md](../mazes/README.md) |
| 5, 7 | 0 | `auction.MysteryShopFrame` | Loja Misteriosa | `Point`/`GiftToken`; exchange `Score` points | daily | [../auction/mystery-shop.md](../auction/mystery-shop.md) |
| 6 | 23 | `farm.FarmShopFrame` (6) | Loja da Fazenda | `Gold` (3); farm level `NeedGrades` | daily | [../farm/README.md](../farm/README.md) |
| 8 | 15 | `shop.PetExchangeShopFrame` (888) | Troca Einherjar | `Score` of currency chosen by `NeedItem` (PayType 1001..1011: currencies 1..5, 26, 99, 100) | daily | [../einherjar/README.md](../einherjar/README.md) |
| 10 | 27 | `shop.AresLordsShopFrame` (10) | Loja de Ares | `LordsScore` (7) -> currency 18 "Coração de Ares" | weekly | [../ares-battle/README.md](../ares-battle/README.md) |
| 11 | 5 | `mineral.MineralShopFrame` (11) | Loja de Ametista | `MineScore` -> -3 "Ametistas" | daily | [../mines/README.md](../mines/README.md) |
| 13 | 23 | `shop.CrossPvPShopFrame` (13) | Loja do Império | `CrossGuildScore` (10) -> currency 19 "Ouro de Yalamen" | daily | [../guild/cross-server-war.md](../guild/cross-server-war.md) |
| 14 | 14 | `pvp.PvPShopFrame` score tab | (league) | `CrossLeagueMedal` (11) -> -5 "Emblema do Campeonato" | daily | [../league/README.md](../league/README.md) |
| 15 | 4 | pet boss shop | | `Score` (1007) | daily | [../einherjar/README.md](../einherjar/README.md) |
| 16 | 30 | `shop.BraveLegShopFrame` (16) | Loja de Athena | `Score` (13) -> currency 20 "Lágrimas de Athena" | daily | [../athena-battle/README.md](../athena-battle/README.md) |
| 17 | 14 | guild advanced tab | | `Score` (12) -> currency 6 "Dente de Terror" | daily | [../guild/shop.md](../guild/shop.md) |
| 19 | 10 | `shop.SvSShopFrame` (19) | Loja de Caos | `Score` (15) -> currency 10 "Pedra do Caos" | daily | [../cross-server/README.md](../cross-server/README.md) |
| 20 | 5 | `shop.MatelordsShopFrame` (20) | Loja de Vênus | `Score` (16) -> currency 12 "Cristais de Vênus" | daily | [../venus-battle/README.md](../venus-battle/README.md) |
| 35 | 4 | `shop.GodsEveningShopFrame` (35) | Casa do Tesouro dos Três Reinos | `Score` (25) -> currency 46 "Marca dos Deuses" | daily | [../three-kingdoms/README.md](../three-kingdoms/README.md) |
| 36 | 8 | `sevenyear.view.SevenYearShopView` | | `Point` (1) | daily | [../hermitage-war/README.md](../hermitage-war/README.md) |
| 37, 38 | 4, 2 | `year2023.view.YearActiveShopView` | | `Score` (42, 43) -> currency 64 "Moeda de Aniversário", 62 "Chave do Baú de Aniversário" | daily | [../seasonal-events/README.md](../seasonal-events/README.md) |
| 99 | 0 | none (hidden main shop list) | | | | none |
| 100 | 0 | `QuickBuyFrame` | | blood potions, route 5633 | | [purchase.md](purchase.md) R4 |
| 1002 | 0 | `shop.MountShopFrame` (1002) | Loja de montaria | own route 8529 `C_MOUNT_OP` (`MountsManager.mountOperateSend`), config `mount_shop_item_count` 30, `mount_shop_refresh_cost` 999 | | [../mounts/README.md](../mounts/README.md) |
| 1003 | 0 (344) | `shop.PokerShopFrame` (1003) | Loja de Texas Poker | `PokerScore` (17) -> 102 "Pontos de Texas" | daily | [../casino/README.md](../casino/README.md) |
| 1004 | 5 | `shop.OutyardShopFrame` (1004) | Loja da Terrálem | `Score` (18) -> currency 17 "Cristais da Terrálem" | daily | [../outyard/README.md](../outyard/README.md) |
| 1005 | 0 (344) | `shop.BingoShopFrame` (1005) | Loja da Maçã | `Score` (19) -> currency 21 "Cristais Vermelhos" | daily | [../casino/README.md](../casino/README.md) |
| 1008 | 33 | `view.subshop.GloryShopFrame` (1008) | Loja da Glória | `Score` (20) -> currency 22 "Pontos da Glória" | weekly | [../roads/README.md](../roads/README.md) |
| 1009 | 6 | guild treasure tab | | `Score` (21) -> currency 23 "Cristais amarelos" | daily | [../guild/shop.md](../guild/shop.md) |
| 1010 | 7 | `view.subshop.IsExploreShopFrame` (1010) | Loja do Eremitério | `Score` (22) -> currency 24 "Medalha do Eremitério" | daily | [../exploration/README.md](../exploration/README.md) |
| 1011 | 6 | `view.subshop.AssaultwarShopFrame` (1011) | Loja Militar | `Score` (28) -> currency 28 "Medalha da Força" | daily | not assigned in `features.json` |
| 1012 | 25 | `shop.PumpingJoyShopFrame` (1012) | Loja do Gashapon | `Score` (2001) -> Gashapon total score | daily | [../lotteries/README.md](../lotteries/README.md) |
| 1013 | 6 | upgrade present (`UpgradePresentManager`, 176 `U_C_UPGRADE_PRESENT`) | | `Point` (1) | daily | [../vip/README.md](../vip/README.md) |
| 1014 | 12 | guild copy tab | | `Score` (29) -> currency 29 "Prata de Moréia" | daily | [../guild/shop.md](../guild/shop.md) |
| 1015 | 27 | `shop.ApexShopFrame` (1015) | | `Score` (30) -> currency 30 "Corações de Gelo" | weekly | [../casino/README.md](../casino/README.md) |
| 1016 | 27 | `shop.CrossGuildShopFrame` (1016) | Loja da defesa de guilda | `Score` (31) -> currency 31 "Pedra da Coragem" | weekly | [../guild/cross-server-war.md](../guild/cross-server-war.md) |
| 1017 | 22 | `shop.AntaeusShopFrame` (1017) | Loja de Anteus | `Score` (32) -> currency 32 "Cristal de localização" | daily | [../assistant/README.md](../assistant/README.md) |
| 1018 | 8 | `shop.AirGardenShopFrame` (1018) | Loja do jardim | `Score` (33) -> currency 33 "Cristal da diversão" (bed tab currency 34 "Cristal da loucura") | daily | [../seasonal-events/README.md](../seasonal-events/README.md) |
| 1019 | 0 | `shop.WishPoolShopFrame` (1019) | Loja do Poço dos Desejos | own route (`WishPoolManager.wishPoolShopBuy`) | | [../lotteries/README.md](../lotteries/README.md) |
| 1020 | 34 | `pvp.PvPShopFrame` (1020) | Loja da Arena | `Score` (37) -> currency 37 "Medalha da Chama" | weekly | [../arena/README.md](../arena/README.md) |
| 1021 | 36 | `pvp.PvPShopFrame` (1021) | Loja da Arena | `Score` (38) -> currency 38 "Medalha do Crepúsculo" | weekly | [../campaign/README.md](../campaign/README.md) (dusk area) |
| 1022 | 19 | `shop.DemonRoadShopFrame` (1022) | Loja da Rua Mítica | `Score` (1022) -> currency 56 "Pó" | daily | [../trials/README.md](../trials/README.md) |
| 1023 | 17 | `shop.DarkMazeShopFrame` (1023) | Loja do Labirinto Negro | `Score` (39) -> currency 39 "Alma do labirinto" | daily | [../mazes/README.md](../mazes/README.md) |
| 1024 | 12 | `shop.ConsortiaNewBossShopFrame` (1024) | | `Score` (40) -> currency 57 | daily | [../guild/boss.md](../guild/boss.md) |
| 99999 | | `shop.ConsortiaNewBossBufferShopFrame` | | guild wealth, config `consortia_newboss_buff_shop` | | [../guild/boss.md](../guild/boss.md) |
| 1027 | 81 | `shop.TheseuspvpShopFrame` (1027) | Loja da Arena | `Score` (41) -> currency 59 (60, 69 honors) | season | [../theseus-arena/README.md](../theseus-arena/README.md) |
| 1029 | 35 | guild Minos tab | | `Score` (44) -> currency 65 | daily | [../guild/minos.md](../guild/minos.md) |
| 1030 | 12 | guild chess tab | | `Score` (45) -> currency 66 | weekly | [../guild/chess.md](../guild/chess.md), [../auto-chess/README.md](../auto-chess/README.md) |
| 1031 | 84 | `shop.childnswarShopFrame` (1031) | Loja da Arena do Espírito de Proteção | `Score` (46) -> currency 67 | season | [../guardians/README.md](../guardians/README.md) |
| 1033 | 27 | `vip.VIPShopView` | Loja VIP | `Score` (1033) -> currency 41 (VIP coin), VIP discount type 208 | daily | [../vip/README.md](../vip/README.md) |
| 1034 | 4 | `shop.DungenexShopFrame` (1034) | Loja de exploração de masmorra | `Score` (1034) -> currency 71 | monthly | [../exploration/README.md](../exploration/README.md) |
| 1035 | 5 | `theseusCollention.shop.TheseusCollentionShopView` | | `Score` (1035) | weekly sync on 528 | [../theseus/README.md](../theseus/README.md) |

Rows of every type use `Id` ranges that do not overlap, so the server can resolve the ShopType from `CarItemInfoMsg.shopId` alone.

## 3. Other shop screens with their own routes

| Screen | pt-BR title | Route | Owner |
|---|---|---|---|
| `consortia.ConsortiaBusinessFrame` | Câmara de comércio | 5438 | [../guild/shop.md](../guild/shop.md) |
| `outercityshop.OuterCityShopFrame` | Loja Misteriosa | 9528 | [outer-city-shop.md](outer-city-shop.md) |
| `discountshop.DiscountShopFrame` | Desconto da Alegria | 9628 | [discount-shop.md](discount-shop.md) |
| `mvpshop.MvpShopFrame` | MVP geral | 9678 | [mvp-shop.md](mvp-shop.md) |
| `poseidon.PoseidonFrame` | Loja Poseidon | 9704, 9705 | [poseidon-shop.md](poseidon-shop.md) |
| `war2023.SecretwarShopFrame` | Loja de Mérito | 9727 | [exploits-shop.md](exploits-shop.md) |
| `timebuy.TimeBuyFrame` | Compra Limitada | 8632, 8693, 8970 | [timebuy.md](timebuy.md) |
| `funny.groupbuy.GroupBuyView` | Compra em grupo | 8645 | [group-buy.md](group-buy.md) |
| `view.inside.ShopBoxView` | Baú de Moda / Baú de Montaria | 9613 | [boxes.md](boxes.md) |
| `view.subshop.StarShopFrame` (101) | Resgatar Pontos | 8341 `C_STARSHOP_BUY` / 4261 `StarShopMsg` (`decompiled/core_module/scripts/yishi/manager/StarManager.as:443-449`) | [../cosmos/README.md](../cosmos/README.md) |
| `view.subshop.NavigationShopFrame` (9001) | Loja de Navegação | `NavigationManager.sendNavigationOperate`, config `navigation_shop_buy_num` 6, `navigation_shop_refresh_point` 10 | [../navigation/README.md](../navigation/README.md) |
| `view.subshop.FarmShopFrame` furniture tab, `FurnitureShopBuyFrame` | Comprar | 9519 `C_FURNITURE_SHOP_BUY` (`FurnitureShopBuyMsg {shopId, count}`, `decompiled/core_module/scripts/managers/ShopManager.as:1248-1255`) | [../farm/README.md](../farm/README.md) |
| `matelords.room.MatelordsDemonShopFrame` | | `MatelordsManager.sendRequestDemoOp` | [../venus-battle/README.md](../venus-battle/README.md) |
| `map.campaign.view.frame.TrailShopFrame` | Loja do Julgamento | 8582 `C_BUY_TRIAL` / 4467 `U_BUY_TRIAL_RESULT` | [../campaign/README.md](../campaign/README.md) |
| `map.campaign.view.ui.CampaignBuffShopEnterView` | | campaign buffs | [../campaign/README.md](../campaign/README.md) |
| `secretadventure.SecretShopFrame` | | secret adventure | [../exploration/README.md](../exploration/README.md) |
| `oldplayerreturn.shop.OldPlayerReturnShopView` | | `OldPlayerReturnManager.send`, `AllianceShopInfos.xml` | [../returning-players/README.md](../returning-players/README.md) |
| `artifact.ArtifactShopView` | | MainDiscountInfo type 7 via 8693/8970 | [../divine-weapon/README.md](../divine-weapon/README.md), [promotions.md](promotions.md) |
| `gamehall.GameHallEastShopFrame` | Sorteio de ovos | `GameHallManager.opEastFrame` | [../casino/README.md](../casino/README.md) |
| `skytreasure.SkyShopBuyFrame` | Comprar | `SkyTreasureManager.sendSkyTreasureExchangeReq` | [../treasures/README.md](../treasures/README.md) |
| `view.subshop.DemonRoadShopExchangeFrame`, `DemonRoadSolveFrame` | Trocar, Decompor | `IncreasinglyRoadManager.resolveGoods` | [../trials/README.md](../trials/README.md) |
| `view.subshop.ShopCartFrame` (200) | Carrinho | 8970 | [cart-gifts.md](cart-gifts.md) |
| `view.inside.FashionAllBuyFrame` (8), `shop.LookFrame` (9) | Compra Rápida | 8970 | [../fashion/README.md](../fashion/README.md) |
| `vip.VipBoxFrame` | Roleta VIP | 4415 | [../vip/README.md](../vip/README.md) |

## 4. Server messages

Shared by all ShopTempInfos shops: 4599, 4783, 4145, 528, 344 ([purchase.md](purchase.md)).

## 5. Rules and formulas

See section 2 and [purchase.md](purchase.md) section 5. Owner hooks enforce: guild shop level (`NeedConsortiaLevels`), maze floors (`MazeLayers`, `MazeLayers2`), farm level (`NeedGrades`), PvP rank (`NeedGeste`), player level range (`NeedMinGrade`, `NeedMaxGrade`), job filter (shops filter rows by `isJobFix`, `SC:1486-1502`), new guild boss stage (`NeedMinGrade` 0, 81, 161, 241 with `MazeLayers`, `decompiled/m15/scripts/view/GoodsItem.as:615-636`).

## 6. Templates

`raw/xml/tempinfos/ShopTempInfos.xml` (1183 rows). Row counts per ShopType are in section 2.

## 7. Persistent state

None beyond [purchase.md](purchase.md).

## 8. Backend implementation notes

- `shops::catalog::shop_type_of(row_id)` and `shops::catalog::currency_of(row)` implement the `setPrice` order.
- Hook registry `shops::catalog::register_requirement(shop_type, fn)` so owning features validate their gates and open state (result 17 "Função de troca abrirá em breve" when closed).

## 9. Open questions and assumptions

- ShopTypes 1011, 19 and 1020 have no clear owner in `roadmap/features.json`; assignments above are assumptions based on frame names and currencies.

## 10. Implementation checklist

- [ ] ShopType to currency table
- [ ] Owner hooks for every ShopType in section 2
- [ ] Limit period table
