# Exchanges ("Trocas")

Client packages `luckyexchange` (m11, "Troca da Sorte"), `allmanexchange` (m11, "Troca geral"), `exchange` (core_module `mvc/module/exchange/ExchangeBoxModel.as`, used by the m11 `exchangebox` frame "Caixa de Moda" / "Caixa de Montaria") and the protobuf package `lucky` (legacy, unused by the client). The exchange protobuf messages actually used live in package `active` (`LuckExchange*`, `AllExchange*`, `FM*`).

| System | What the player does |
|---|---|
| Troca da Sorte (lucky exchange) | During a server event, trade a consumable item for rewards; every trade fills a luck bar, and the trade after a full bar gives the rare prizes |
| Troca geral (all-man exchange) | During a cross server event, trade an event item into one of 3 boxes for 1 to 5 random points each; full boxes give box rewards; the server wide point total unlocks 5 shared rewards |
| Caixa de Moda / Caixa de Montaria (exchange box) | Daily diamond lottery: normal draw (fashion material or mount stones plus a random item, guaranteed fashion or mount every 10) and "baú de coleção" draw (6 random items with the daily hot item), keys spent before diamonds |

All traffic is socket based. No HTTP or AMF routes. PostgreSQL schema: `exchange`. Rust handlers: `exchange::<module>::handle_<action>`.

## Entry points

| Entry | Condition | Opens | Citation |
|---|---|---|---|
| Top toolbar `luckyexchange` (TopToolBtnInfos 2025 "幸运兑换", tip "Troca da Sorte") | level 6 and at least one lucky event active now | `luckyexchange.LuckyExchangeFrame` | `decompiled/core_module/scripts/ui/toptoolbar/TopBtnCheckShowHelper.as:309-310`, `decompiled/core_module/scripts/ui/toptoolbar/TopToolsBar.as:1296-1298` |
| Top toolbar `allmanexchange` (TopToolBtnInfos 2062 "全民兑换") | `AllExchangeMsg.isopen` | `allmanexchange.AllManExchangeFrame` | `TopBtnCheckShowHelper.as:399-400`, `TopToolsBar.as:1453-1455` |
| Space NPC dialog options 114 / 115 (NPC "Ifan", node 37: "Tantas modas lindíssimas e montarias misteriosas, você não quer?") | level 10 (fashion) / 16 (mount), `VersionSwitch.FASHION_BOX` / `MOUNT_BOX` (both true) | `exchangebox.ExchangeBoxFrame` openType 1 / 2 | `decompiled/m3/scripts/map/space/view/frame/DialogOptionItem.as:767-771`, `decompiled/core_module/scripts/yishi/SwitchPageHelp.as:2281-2309` |
| Shop tab "box" (`view.inside.ShopBoxView`) | shops feature | same opcodes as the exchange box | `decompiled/m15/scripts/view/inside/ShopBoxView.as:136-143`, `:600-700` |

## Modules

| Module | Content | Opcodes |
|---|---|---|
| [lucky-exchange.md](lucky-exchange.md) | Troca da Sorte: event templates, luck bar, drop groups, exchange count rules | 9610, 363, 364 |
| [all-man-exchange.md](all-man-exchange.md) | Troca geral: 3 point boxes, daily trade cap, box claims, 5 server wide rewards | 9007 -> 4955 |
| [exchange-box.md](exchange-box.md) | Caixa de Moda and Caixa de Montaria: normal, x10 and hot draws, keys, daily limits, hot and drop lists, extra fields 16..19 | 9613 -> 367, 368, 369, 260 |
| [legacy-lucky.md](legacy-lucky.md) | Protobuf package `lucky` and opcodes 8320, 8321, 4224 ("招财") and 8466, 8467, 4372 ("炼魂"): defined but unused by this client | none used |

Out of scope (owned by other features, listed to avoid duplicate work): NPC item exchange 9586 `C_NPC_ITEM_EXCHANGE` (space NPC `ItemExchange`, [../sky-realm/README.md](../sky-realm/README.md)), title exchange 8597 `C_APPELL_EXCHANGE` ([../hero/README.md](../hero/README.md)), fashion exchange 9582 `C_FASHION_EXCHANGE` ([../fashion/README.md](../fashion/README.md)), activity exchange 8539 `C_ACTIVE_EXCHANGE`, sky treasure exchange 9027/9032 ([../treasures/README.md](../treasures/README.md)), Einherjar exchange shop ([../shops/README.md](../shops/README.md)), mystery shop points exchange ([../auction/mystery-shop.md](../auction/mystery-shop.md)).

## Dependencies

| Feature | Why |
|---|---|
| [../inventory/README.md](../inventory/README.md) | Consumed items (bag count by template), granted items, bag push 115 `U_C_BAG_MOVE_UPDATE`, new item animation (`NEW_GOODS`) |
| [../currency/README.md](../currency/README.md) | Diamonds and bound diamonds (`allPoint = point + giftToken`), push 3 `U_C_PLAYER_INFO` |
| [../fashion/README.md](../fashion/README.md) | Fashion collection progress shown in the fashion box (`FashionManager.fashionModel.bookList`) |
| [../mounts/README.md](../mounts/README.md) | Mount collection progress (`MountsManager.avatarList`) |
| [../hero/README.md](../hero/README.md) | Player extra fields push 260 `U_C_PLAYER_EXTRA_FIELD_MSG` (fields 16..19) |
| [../cross-server/README.md](../cross-server/README.md) | Server wide total of the Troca geral ("Pontuação inter-servidor") |
| [../mail/README.md](../mail/README.md) | Overflow delivery when the bag is full (assumption) |

## Suggested implementation order

1. [exchange-box.md](exchange-box.md) (config exists in `ConfigInfos.xml`, reachable from an NPC and the shop).
2. [lucky-exchange.md](lucky-exchange.md) (server templates and event calendar needed).
3. [all-man-exchange.md](all-man-exchange.md) (needs a cross server aggregate or a local approximation).
4. [legacy-lucky.md](legacy-lucky.md): nothing to implement; reject the opcodes.
