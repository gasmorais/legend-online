# Currencies and resources ("Moedas e recursos")

Every balance a player owns outside the bag: castle resources (gold "Ouro", light crystal "Cristal de luz"), premium currencies (diamonds "Diamante", bound diamonds "Diamante vinculado"), hero counters carried by `PlayerMsg` (Espírito, Honra, Pontos do Cosmo, Ametistas, Cristal da Glória, Emblema do Campeonato, ...) and the generic token wallet pushed by 4725 `U_C_PLAYER_TOKENINFO` (arena medals, maze coins, Einherjar crystals, Pó da Ilusão, every activity shop coin). The client package `mvc.module.currency` only holds the token model; the balances themselves are spread over `PlayerInfo`, `ThaneInfo`, `ResourceManager` and `PlayerCurrencyManager`.

The feature has no request opcodes of its own except the resource sync 5015. It is the shared ledger every other feature calls to spend or grant value. PostgreSQL schema: `currency`. Rust module: `currency::<module>`.

## Entry points

| Entry | Condition | Shows |
|---|---|---|
| HUD resource bar `ui.resourcebar.view.ResourceView` | always | gold (with production tip and cap), diamonds, bound diamonds, VIP button ([wallet.md](wallet.md)) |
| Main toolbar pay button `MainToolBar.__payBtnClickHandler` (`decompiled/core_module/scripts/ui/maintoolbar/MainToolBar.as:1391`) | always | external recharge page ([../recharge/payment.md](../recharge/payment.md)) |
| Hero frame, tab "Item" list `armyII.viewII.information.ItemExchangeView` (columns "Item", "Quantidade", "Validade", "Loja") | hero frame open; each row has its own level gate | token wallet and pseudo currencies with a shortcut to the shop that spends them ([tokens.md](tokens.md)) |
| Any priced action (shops, upgrades, refreshes) | per feature | diamond and bound diamond checks, "Diamante insuficiente, recarregar?" ([spending.md](spending.md)) |

## Modules

| Module | Content |
|---|---|
| [wallet.md](wallet.md) | Core balances: gold, light crystal, diamonds, bound diamonds, Espírito, Honra (daily caps 4471), Pontos do Cosmo, Ametistas, Cristal da Glória, cross counters, Texas chips (260), HUD; pushes 3 and 109; sync 5015 |
| [tokens.md](tokens.md) | Token wallet 4725 `PlayerTokenInfoMsg`: every `masterType`, names, sort, expiry, level gates, the currency list screen and the shop each token opens |
| [spending.md](spending.md) | Shared spend and grant API: diamond checks, bound first rule (`payType`), recharge alert, virtual item ids (-100 gold, -400 diamonds, ...), currency costed items (SonType 311), ledger, hooks for VIP growth and consumption activities |

## Dependencies

- [../hero/README.md](../hero/README.md): owns `player.players` and the full `PlayerMsg` push 3; this feature owns the currency columns written into it.
- [../castle/README.md](../castle/README.md): gold production, gold cap and light crystal come from `CastleYieldMsg` (109).
- [../shops/README.md](../shops/README.md): almost every token is spent in a shop (`ShopType` per token in [tokens.md](tokens.md)).
- [../vip/README.md](../vip/README.md): VIP growth points from diamond consumption (`Vip_ConsumeGp`), VIP coin (token 41, Moeda VIP item 208015).
- [../recharge/README.md](../recharge/README.md): the only source of diamonds; recharge and consumption activities read the ledger.
- [../guild/funds.md](../guild/funds.md): guild contribution `consortia_offer` and guild wealth (not repeated here).
- [../inventory/README.md](../inventory/README.md): virtual reward ids (-100, -400, ...) are resolved into wallet deltas when a drop is granted.
- [../seasonal-events/README.md](../seasonal-events/README.md), [../casino/README.md](../casino/README.md), [../cat-house/README.md](../cat-house/README.md), [../fantasy-bar/README.md](../fantasy-bar/README.md): activity tokens (anniversary, Texas, cat toys, magic pub).

## Suggested implementation order

1. `currency.wallets` and `currency.ledger` with the shared API `currency::spending::{spend, grant}` ([spending.md](spending.md)).
2. Login pushes: 3 (point, gift_token, strategy, geste, starpoint, mine_score, lords_score, cross_league_medal), 109 (gold, crystals), 4725 (tokens), 260 (extra fields), 4471 (daily honor).
3. Resource sync 5015 to 109 and lazy gold production ([wallet.md](wallet.md)).
4. Token wallet with expiry and the 4725 full snapshot after each change ([tokens.md](tokens.md)).
5. Diamond spend with `payType` bound first, recharge alert behavior and consumption hooks.

## Cross-cutting rules

- Every balance change is one transaction: lock the wallet row, check, update, insert a ledger row, commit, then push the affected message (3, 109 or 4725). Never push before commit.
- Diamonds (`point`) only come from recharge, GM grants and specific refunds; bound diamonds (`gift_token`) come from quests and activities and are never accepted where the client says so ("Não pode usar diamantes vinculados ...").
- The client never asks for 4725 or 3: the server must push a fresh snapshot after every change.
