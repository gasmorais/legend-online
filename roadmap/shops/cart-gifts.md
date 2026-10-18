# Shopping cart and gifts (Carrinho, Presentear)

Path aliases:

| Alias | File |
|---|---|
| SM | `decompiled/core_module/scripts/managers/ShopManager.as` |
| SMOD | `decompiled/core_module/scripts/mvc/module/shop/ShopModel.as` |
| BF | `decompiled/core_module/scripts/yishi/view/frame/BuyFrameI.as` |
| CART | `decompiled/m15/scripts/view/subshop/ShopCartFrame.as` |
| GDF | `decompiled/core_module/scripts/yishi/view/frame/giftdonatio/GiftDonatioFrame.as` |
| FAB | `decompiled/m15/scripts/view/inside/FashionAllBuyFrame.as` |

## 1. Overview

- The cart is client side state (`ShopModel.shopCartList`, a vector of `ShopCartGoodsInfo {goodsInfo, number, isBind, isDiscount}`); the server only sees the final multi line purchase on 8970 (see [purchase.md](purchase.md) R2).
- Lines come from the "Adicionar ao carrinho" button of `BuyFrameI` (mall rows of ShopType 1 except item 30000013, and `MainShopInfo` offers, `BF:545-567`).
- Gifts: the receiver is resolved by nickname (8223 -> 4148), then the purchase is sent on 8970 with `receiveUserId` = receiver. In this build the per item gift tab of `BuyFrameI` and `ShopMainBuyFrame` is hidden (`_friendSelectBtn.visible = false`, `BF:1121-1122`), so gifting is only reachable from the cart ("Presentear") and from feature specific callers (seven year event callback in `GDF:165-175`).
- `FashionAllBuyFrame` ("Compra Rápida", openType 8) buys a whole fashion set in one 8970 message; its screen belongs to [../fashion/README.md](../fashion/README.md).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `view.subshop.ShopCartFrame` (`shop.CartShopFrame`, openType 200, `decompiled/core_module/scripts/mvc/controler/ShopControler.as:135-138`) | "Carrinho" (`view.subshop.ShopCartFrame.Title`) | List of lines with quantity edit, per line "Usar diamantes vinculados" toggle, delete, "Comprar tudo", "Limpar", "Presentear", "Recarregar" | cart buttons in `ShopTimeBuyView` (`decompiled/m15/scripts/view/timebuy/ShopTimeBuyView.as:193-196`), `MainGoodsListView` (`decompiled/m15/scripts/view/inside/MainGoodsListView.as:120`), `ShopBoxView` (`decompiled/m15/scripts/view/inside/ShopBoxView.as:319`) | columns "Nome do item", "Preço", "Quantidade"; totals in diamonds and bound diamonds (`SMOD.allCostPoint`, `SMOD.allCostBindPoint`, `SMOD:999-1029`) |
| `yishi.view.frame.giftdonatio.GiftDonatioFrame` (`shop.GiftDonatioFrame`) | "Presentear" | Receiver nickname input with friend and guild member combo lists | cart "Presentear" (`CART:454-473`), BuyFrameI gift tab (hidden) | nickname, friend list, guild member list |
| `view.inside.FashionAllBuyFrame` (openType 8) | "Compra Rápida" | Buy every piece of a fashion set | fashion screens | pieces, total, bind toggle, coupon |

## 3. Routes (client to server)

### R1. Add line to cart (client only)

- UI: "Adicionar ao carrinho" in `BuyFrameI` -> `BuyFrameI.__addToShopCartHandler` (`BF:253-339`).
- Checks: cart length >= 20 -> "Carrinho está cheio" (`BF:261-268`); same `goodsInfo` already in cart -> "O item já foi adicionado ao carrinho" (`BF:269-277`); owned permanent mount card -> `shop.view.frame.BuyFrameI.mopupexitst2` (`BF:278-319`); offer type 2 clamps quantity to `limitCount - count` (`BF:320-329`).
- Effect: push `{goodsInfo, number, isBind = bind checkbox, isDiscount = goodsInfo is MainShopInfo}`, toast "Adicionado com sucesso". No network traffic.

### R2. Buy whole cart (8970)

- UI: "Comprar tudo" -> `ShopCartFrame.__allBuyBtnHandler` (`CART:326-378`) -> confirm -> `ShopCartFrame.__confirmBuy` (`CART:389-425`) -> `ShopManager.allBuy(lines, selfId)` (`SM:1154-1176`).
- Client checks: empty cart -> "O carrinho atual não tem nenhum item"; bound part = `min(giftToken, allCostBindPoint)`; diamonds needed = `allCostPoint + allCostBindPoint - boundPart`; diamonds < needed -> "A sua quantidade de diamantes é insuficiente, por favor recarregue." with recharge button; confirm text "Consumo total de diamantes:{0}" or, when bound diamonds are used, "Consumo total de diamantes:{0}\n Você consumiu diamantes vinculados:{1}\nEsta compra contém diamantes vinculados, por isso os itens são vinculados".
- Route: send 8970 (0x230a) `C_SHOPCAR_BUY`, `ShopCarListMsg`: `receiveUserId` (#2) = own id; `discountTempId` (#3) unset (no coupon in cart); `carItemInfo` (#4, repeated): `shopId` (#1) row Id or offer id, `counts` (#2) quantity, `payType` (#3) 2 when the line `isBind` else 1, `isDiscountShop` (#4) = line is an offer, `type` (#5) = 0.
- Response: 4783 (S1).

### R3. Resolve gift receiver (8223)

- UI: `GiftDonatioFrame.__confirmHandler` (`GDF:158-207`): empty nickname -> "Preencha o apelido de quem deseja presentear!!". Single gift path stores `ItemBuyInfo {nickname, goodId, count, isDiscount}` in `ShopModel.giftInfo` and calls `ShopManager.sendPresent()` (`SM:505-509`); cart path shows the same diamond confirm as R2 (`GDF:209-245`) then `ShopManager.sendShopCartPresent()` (`SM:511-515`).
- Cart gift extra check: any line with `isBind` -> "Não pode usar diamantes vinculados para presentear amigos." (`CART:462-469`).
- Sender: `ShopManager.getUserId(nickname)` (`SM:922-928`).
- Route: send 8223 (0x201f) `U_C_CHECK_NICK`, `com.road.yishi.proto.player.CheckNickMsg`: `nick_name` (#2, STRING); `player_id` (#1, INT32) unset.
- Response: 4148 (S2), shared with other features (owner of the route: [../friends/README.md](../friends/README.md)).

### R4. Send gift purchase (8970)

- Trigger: 4148 handlers `__checkNicknameBack` (`SM:575-602`) and `__checkShopCartNicknameBack` (`SM:517-573`).
- Client checks: nickname in the reply equals the requested one (case insensitive), else ignore; `player_id == -1` -> "Usuário não encontrado!"; `player_id == self` -> "Não pode presentear a si mesmo!!".
- Route: single gift `buyOne(goodId, count, receiverId, 1, isDiscount)` (payType 1, diamonds only); cart gift `allBuy(lines, receiverId)` with `payType` 2 for rows marked bind (already rejected client side) else 1. Message as in R2 with `receiveUserId` (#2) = receiver.
- Response: 4783, plus mail or bag delivery to the receiver.

### R5. Fashion set quick buy (8970)

- UI: `FashionAllBuyFrame` confirm (`FAB:313`) -> `ShopManager.allFashion(rows, selfId, useBind, couponId)` (`SM:1178-1203`).
- Route: 8970 `ShopCarListMsg`: `carItemInfo[]` with `shopId` = row Id, `counts` = row count, `payType` = 2 if bind checkbox else 1, `isDiscountShop` = false; `discountTempId` (#3) = coupon template id when `!= -1`.
- Response: 4783 handled by `FashionAllBuyFrame.__succeedHandler` (`FAB:225,414`).

## 4. Server messages (server to client)

### S1. 4783 (0x12af) `U_C_SHOPCAR_RESULT`

- `ShopCarListMsg`: `result` (#1, INT32), `receiveUserId` (#2, INT32), `discountTempId` (#3, INT32), `carItemInfo` (#4, CarItemInfoMsg, repeated), `isMail` (#5, BOOL).
- Receiver: `ShopCartFrame.__shopCartHandler` (`CART:304-319`): on `result` 1 or 12 clears the cart and totals. Other result codes keep the cart. Result codes: [purchase.md](purchase.md) section 5.
- When: reply to R2, R4, R5.

### S2. 4148 (0x1034) `U_C_CHECK_NICK`

- `CheckNickMsg`: `player_id` (#1, INT32) id or -1 when not found, `nick_name` (#2, STRING) echo of the requested nickname.
- Receivers: `SM.__checkNicknameBack`, `SM.__checkShopCartNicknameBack` (each registered right before sending R3).
- Client bug to tolerate: `__checkShopCartNicknameBack` removes `__checkNicknameBack` instead of itself (`SM:525`), so a later 4148 for another feature may re-trigger a cart gift if the nickname matches the stored `giftInfo`. The server must answer each 8223 exactly once.

## 5. Rules and formulas

- Cart: at most 20 lines, no duplicate `goodsInfo`, quantity 1..9999 per line.
- Totals: `allCostPoint = sum(price x number)` of lines without bind, `allCostBindPoint = sum(price x number)` of lines with bind (`SMOD:999-1029`).
- Bound diamonds can pay only lines whose row PayType is 2 and only for self purchases. Server must reject `payType = 2` on gift lines and on offers (`view.shopFrame.buyFrameI.shopCartItem.change` "Não pode usar diamantes vinculados nos itens da promoção limitada.", `view.shopFrame.buyFrameI.shopCartItem.fault`).
- Gift purchases always spend diamonds; the receiver gets unbound items. Gift limits are checked against the receiver's counters (result 6 shows "Compras máximas atingidas pelo amigo" when `isHandsel == 1`, `SM:1006-1009`).
- Coupons cannot be used on gifts (result 23).
- Whole cart is atomic on the server (assumption): either every line succeeds or none; the client clears the cart only on success.

## 6. Templates

Same as [purchase.md](purchase.md): `ShopTempInfos.xml` rows and `MainDiscountInfo` offers.

## 7. Persistent state

No cart table (client side state). Gift deliveries reuse `shops.purchase_log` (`buyer_id <> receiver_id`) from [purchase.md](purchase.md). Mail delivery uses [../mail/README.md](../mail/README.md).

## 8. Backend implementation notes

- `shops::cart::handle_cart_buy` is the same handler as `shops::purchase::handle_cart_buy` (8970); gift specific validation order when `receiveUserId != sender`: receiver exists (2) -> receiver is not self (5) -> no coupon (23) -> every line `payType != 2` (5) -> receiver limits (6) -> receiver mount ownership (18) -> diamonds.
- Delivery to an offline or bag full receiver goes through mail with sender name; push a mail notice to the receiver if online.
- `shops::cart::handle_check_nick` (8223) lives with the player directory; reply 4148 with `player_id = -1` when unknown, nickname echoed verbatim.

## 9. Open questions and assumptions

- Assumption: the whole cart is one transaction.
- Open: whether the original server let gifts use offers (`isDiscount` true); the client allows it in `GiftDonatioFrame` (`isDiscount` copied).
- Open: gift message or mail text format for the receiver.

## 10. Implementation checklist

- [ ] Screen ShopCartFrame (client side, no server state)
- [ ] Screen GiftDonatioFrame
- [ ] Route 8970 multi line, atomic
- [ ] Route 8223 and encoder 4148
- [ ] Gift validation (no bind, no coupon, receiver limits)
- [ ] Receiver delivery (bag or mail)
- [ ] Tests: cart with bind and non bind lines, cart over limit on one line, gift to unknown nickname, gift to self, gift with bind line rejected
