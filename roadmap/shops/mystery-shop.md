# Mystery shop of the market (Loja Misteriosa, Mercado)

The client has two screens titled "Loja Misteriosa" (search of `index/language.json` for "Misteriosa": `auction.view.mysteryshop.MysteryShopFrame.titleText` and `outercityshop.OuterCityShopFrame.titleText`).

| Screen | Opcodes | Documented in |
|---|---|---|
| `auction.MysteryShopFrame` in the "Mercado" hub (ShopTypes 5 and 7, 6 random offers, 4 h refresh, points exchange, lucky feed) | 8483/4384, 8482/4383, 4470, exchange via 8970 | [../auction/mystery-shop.md](../auction/mystery-shop.md) |
| `outercityshop.OuterCityShopFrame` (map shop, NPC "Rona, Loja Misteriosa", mall home button) | 9528/4946, 294 | [outer-city-shop.md](outer-city-shop.md) |

Shop specific notes not repeated in the auction module:
- Exchange rows (ShopType 7) are bought on the generic purchase route 8970; the shops handler must call the auction hook that spends mystery points and increments the daily purchase count ([purchase.md](purchase.md) R2, `auction::mystery::spend_points_and_count`).
- The mall home tab button labelled "Loja Misteriosa" (`decompiled/m15/scripts/view/inside/MainRightView.as:109-120`) opens the outer city shop, not the market shop.
- Points currency id -4 "Pontos da Loja Misteriosa" (`mvc.module.currency.CurrencyType.type05`, `SHOPSCORE` in `decompiled/core_module/scripts/mvc/module/currency/CurrencyType.as:36`); the hero resource link for -4 also opens the outer city shop (`decompiled/m5/scripts/armyII/viewII/information/GoodsExchangeItem.as:338-345`).

## Implementation checklist

- [ ] 8970 hook for ShopType 7 rows (points debit and daily count) agreed with the auction module
