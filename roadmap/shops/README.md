# Shops (Lojas)

Every place where the player spends a currency for an item: the diamond mall "Loja", time limited and promotional offers, fashion and mount boxes, the outer city "Loja Misteriosa", event shops (Desconto da Alegria, MVP geral, Compra em grupo), the Poseidon and Mérito shops, and the generic purchase pipeline used by about 45 currency shops of other features.

Client packages: `shop`, `discountshop`, `outercityshop`, `poseidon`, `mvpshop`, `timebuy` plus the m15 `view.*` shop module. Protobuf packages: `shop`, `mall`, `mapshop`, `poseidonshop`, `exploitsshop`.

## Entry points

| Entry | Condition | Opens |
|---|---|---|
| Main tool bar "Loja / Atalho O", key O | level >= 10 (`docs/ui/navigation.md:97`, `decompiled/core_module/scripts/yishi/keyboard/KeyBoardRegister.as:436-442`) | [mall.md](mall.md) |
| Top bar `limitbuy` "Compra Limitada" | level >= 10 and type 2 offers exist | [timebuy.md](timebuy.md) |
| Top bar `discountshop` | event active | [discount-shop.md](discount-shop.md) |
| Top bar `mvpshop` | event open | [mvp-shop.md](mvp-shop.md) |
| Mall home "Loja Misteriosa", NPC "Rona, Loja Misteriosa", resource link -4 | level >= 26 | [outer-city-shop.md](outer-city-shop.md) |
| Royalty fight frame, NPC, resource link | royalty floor 1 unlocked | [poseidon-shop.md](poseidon-shop.md) |
| Secret war entry "Loja" | war feature | [exploits-shop.md](exploits-shop.md) |
| Funny frame group buy button | type 3 offer active | [group-buy.md](group-buy.md) |
| Feature buttons (`openControllerByInfo("shop", openType)`) | per feature | [catalog.md](catalog.md) |

## Modules

| Module | Content | Routes | Server messages |
|---|---|---|---|
| [purchase.md](purchase.md) | Generic purchase, price derivation, limits, bound diamonds, coupons, result codes | 8693, 8970, 5154 (dead), 8592 (dead), 5633, 8218 | 4599, 4783, 90, 170, 4145, 528, 344 |
| [cart-gifts.md](cart-gifts.md) | Cart (20 lines), gifts by nickname, fashion set quick buy | 8970, 8223 | 4783, 4148 |
| [mall.md](mall.md) | Loja tabs, search, data from XML | (uses purchase) | (consumes 4145, 4238, 4599, 4783) |
| [timebuy.md](timebuy.md) | MainDiscountInfo offers, Compra Limitada types 1 and 2 | 8632 | 4238, 4375, 4547 |
| [promotions.md](promotions.md) | Featured offer, daily free and consume gifts, artifact offers, limited time discount | 9545 | 4890, 3 (`is_cost`) |
| [boxes.md](boxes.md) | Baú de Moda / Baú de Montaria lotteries | 9613 | 367, 368, 369, 260 |
| [mystery-shop.md](mystery-shop.md) | Link note: market Loja Misteriosa lives in [../auction/mystery-shop.md](../auction/mystery-shop.md) | (8483, 8482) | (4384, 4383, 4470) |
| [outer-city-shop.md](outer-city-shop.md) | Outer city Loja Misteriosa (map shop) | 9528 | 4946, 294 |
| [discount-shop.md](discount-shop.md) | Desconto da Alegria | 9628 | 389 |
| [mvp-shop.md](mvp-shop.md) | MVP geral | 9678 | 4888 |
| [poseidon-shop.md](poseidon-shop.md) | Loja Poseidon | 9704, 9705 | 522, 523 |
| [exploits-shop.md](exploits-shop.md) | Loja de Mérito | 9727 | 540 |
| [group-buy.md](group-buy.md) | Compra em grupo | 8645 | 4559, 4560, 338 |
| [catalog.md](catalog.md) | Every ShopType and shop screen with currency, limit and owner | | |

The guild shops (Câmara de comércio 5438 and the Loja da Guilda tabs) are in [../guild/shop.md](../guild/shop.md); their ShopTempInfos purchases use [purchase.md](purchase.md).

## Dependencies

- [../currency/README.md](../currency/README.md): diamonds (`point`), bound diamonds (`giftToken`), gold, all shop currencies (masterType ids in [catalog.md](catalog.md)).
- [../inventory/README.md](../inventory/README.md): item grant, bag full mail fallback, coupons in bag.
- [../mail/README.md](../mail/README.md): mailed purchases and gifts.
- [../vip/README.md](../vip/README.md): VIP gates, VIP shop discount, mystery shop limits.
- [../friends/README.md](../friends/README.md): nickname lookup 8223/4148.
- [../hero/README.md](../hero/README.md): 3 `PlayerMsg.is_cost`, 260 extra fields.
- [../auction/mystery-shop.md](../auction/mystery-shop.md), [../guild/shop.md](../guild/shop.md), [../royalty-boss/README.md](../royalty-boss/README.md), [../hermitage-war/README.md](../hermitage-war/README.md), [../seasonal-events/README.md](../seasonal-events/README.md), [../divine-weapon/README.md](../divine-weapon/README.md).
- Every feature listed as owner in [catalog.md](catalog.md) for requirement hooks.

## Suggested implementation order

1. [purchase.md](purchase.md): template loader, 8970/8693/8218, counters (unblocks every ShopTempInfos shop).
2. [mall.md](mall.md) and [cart-gifts.md](cart-gifts.md).
3. [timebuy.md](timebuy.md) offers table and 4238, then [promotions.md](promotions.md).
4. [boxes.md](boxes.md).
5. Standalone shops: [outer-city-shop.md](outer-city-shop.md), [poseidon-shop.md](poseidon-shop.md), [exploits-shop.md](exploits-shop.md).
6. Event shops: [discount-shop.md](discount-shop.md), [mvp-shop.md](mvp-shop.md), [group-buy.md](group-buy.md).
7. Owner hooks from [catalog.md](catalog.md) as each feature lands.

## Notable findings

- 5154 `U_C_SHOP_BUY` and 8592 `C_FASHION_SHOP_BUY` have no caller in this client; real purchases use 8970 `C_SHOPCAR_BUY`.
- ShopType 5/7 (market mystery shop), ShopType 100 (blood quick buy) rows and the `MapShopCost` template are absent from `raw/xml/tempinfos`.
- Opcodes 4559 and 4560 (group buy) are missing from `protocol/opcodes.csv`; `protocol/proto.json` merges three different `PropertyMsg` messages (9678 and 9727 use `simple.PropertyMsg`).
- `ShopGoodsInfo.OneDayCount` is always `VIP0Count`; VIP1..9 counts are ignored by the client.
