# Roletas e sorteios (lotteries)

Client packages `lottery`, `luckylottery`, `chargelottery`, `superlottery`, `pumpingjoy` (UI) with `pumpingegg` (model), `foisonhorn`, `faterotary`, `wishpool`; protobuf packages `lottery` (`LotteryMsg`) and `fate` (`FateListMsg`, `FateInfoMsg`, `FateEditMsg`). Most events also use package `cccactive` or `active` messages, multiplexed on 9645 `C_CCCACTIVE_CLIENTOP` with header `extend1` (24 charge, 27 gashapon, 30 horn, 34 joy, 36 wish pool).

| System | pt-BR | What the player does |
|---|---|---|
| Lucky roulette | "Roleta da Sorte" | Spend diamonds during the event to earn chances; spin a 16 slot wheel |
| Joy grand prize | "Grande prêmio da Alegria" | Spend an event item to draw from a personal finite prize pool; refill it after the grand prize is out |
| Charge roulette | "Roleta de Recarga" | Recharge to earn draws on a 22 slot wheel with a rare inner ring |
| Lotto | "Loteria" / "Lotto" | Daily Tarot plus zodiac bet (dormant in this client) |
| Gashapon | "Gashapon" | Buy capsules with diamonds or coupons, earn shop points, share luck when someone wins big |
| Cornucopia | "Grande Pacote da Cornucópia" | Collect five items, activate, share a cross server prize at the end |
| Fate wheel | "Roleta do Destino" / "Proteção do Destino" | Daily free spin and paid spins for stones that level three fate guardian skills (level 55) |
| Wish pool | "Poço dos Desejos" | Pick up to 3 wishes, pay per wish, 20 to 30 percent success, points shop |
| Fashion and mount box | "Caixa de Moda" / "Caixa de Montaria" | Already mapped in [../exchange/exchange-box.md](../exchange/exchange-box.md) (9613 `C_FASHION_MOUNT_LOTTERY`) |

PostgreSQL schema: `lotteries`. Rust handlers: `lotteries::<module>::handle_<action>`.

## Entry points

| Entry | Condition | Opens | Citation |
|---|---|---|---|
| Top toolbar `lottery` (TopToolBtnInfos 2026 "幸运轮盘") | level 10, 4637 `isOpen` | `lottery.LotteryFrame` | `decompiled/core_module/scripts/ui/toptoolbar/TopBtnCheckShowHelper.as:265-266`, `TopToolsBar.as:1170-1173` |
| Top toolbar `luckylottery` (2056 "欢乐中大奖") | `VersionSwitch.LUCKY_LOTTERY`, 462 open, not past `endDate` | `luckylottery.LuckyLotteryFrame` | `TopBtnCheckShowHelper.as:383-384`, `TopToolsBar.as:1456-1463` |
| Top toolbar `chargelottery` (2017 "充值抽奖轮盘") | level 11, 433 open | `chargelottery.ChargeLotteryFrame` | `TopBtnCheckShowHelper.as:333-334`, `TopToolsBar.as:1326-1328` |
| Top toolbar `pumpingjoy` (2048 "幸运扭蛋"); bag item SonType 219 | level 16, 4847 id 27 open | `pumpingjoy.PumpingJoyFrame` | `TopBtnCheckShowHelper.as:363-364`, `SwitchPageHelp.as:2459-2473` |
| Top toolbar `foisonhorn` (2052 "丰收号角") | `VersionSwitch.FOISON_HORN`, 4877 open | `foisonhorn.FoisonHornFrame` | `TopBtnCheckShowHelper.as:373-374`, `TopToolsBar.as:1441-1443` |
| Hero equip view fate button; day guide 50 | level 55, fate skills loaded | `faterotary.FateRotaryFrame` | `decompiled/m5/scripts/armyII/viewII/equip/EquipView.as:1025-1034`, `DayGuideManager.as:738-746` |
| Top toolbar `wishpool` (2058 "许愿池") | 4590 id 2058 open | `wishpool.WishPoolFrame` | `TopBtnCheckShowHelper.as:391-392`, `TopToolsBar.as:1473-1475` |
| none | `VersionSwitch.SUPER_LOTTERY = false` | (missing `SuperLotteryFrame`) | `decompiled/core_module/scripts/yishi/datas/VersionSwitch.as:58` |

## Modules

| Module | Content | Opcodes |
|---|---|---|
| [lucky-roulette.md](lucky-roulette.md) | Roleta da Sorte: diamond spend chances, 16 slot wheel, winners panel | 8750, 8748 -> 4636, 4637, 4639, 4641, 4642 |
| [joy-grand-prize.md](joy-grand-prize.md) | Grande prêmio da Alegria: 4 tier finite pool, item cost, refills | 9645/34 -> 462, 4892, 4893 |
| [charge-roulette.md](charge-roulette.md) | Roleta de Recarga: recharge draws, 22 + 8 rings, rare chain, draw all | 9645/24 -> 432, 433 |
| [gashapon.md](gashapon.md) | Gashapon: x1/x10 capsules, coupons, points, floor reward, shared luck | 9645/27 -> 4847, 4848, 4850 |
| [foison-horn.md](foison-horn.md) | Cornucópia: five item activation, shared end prize | 9645/30 -> 4877 |
| [fate-wheel.md](fate-wheel.md) | Roleta do Destino and fate guardian skills: free and paid spins, lock, training | 8626, 8627, 8628 -> 4544, 4545 |
| [wish-pool.md](wish-pool.md) | Poço dos Desejos: wishes, refresh, coin, points shop | 9645/36 -> 4590, 196, 197 |
| [super-lotto.md](super-lotto.md) | Lotto: dormant protocol and configs | 9529 -> 4947 |

Out of scope (owned elsewhere): fashion and mount box 9613 ([../exchange/exchange-box.md](../exchange/exchange-box.md)); new year lottery 8818, 4706, 4708 and Christmas or carnival draws ([../seasonal-events/README.md](../seasonal-events/README.md)); sky treasure lottery 9025, 9026, 774, 775 ([../treasures/README.md](../treasures/README.md)); rune lottery 9724, 539 (`ArmySocketOutManager.as:176`, [../army/README.md](../army/README.md)); platinum pot 9645/40 ([../laboratory/platinum-pot.md](../laboratory/platinum-pot.md)); Easter lottery 4587 ([../casino/game-hall.md](../casino/game-hall.md)); dragon soul list 4555 reusing `FateListMsg` ([../dragon/README.md](../dragon/README.md)).

## Dependencies

| Feature | Why |
|---|---|
| [../currency/README.md](../currency/README.md) | Diamonds and bound diamonds, push 3; diamond spend hook for the lucky roulette |
| [../recharge/README.md](../recharge/README.md) | Recharge hook for the charge roulette |
| [../inventory/README.md](../inventory/README.md) | Cost items, rewards, push 115 |
| [../shops/README.md](../shops/README.md) | Gashapon points shop 1012, wish pool shop 1019 |
| [../hero/README.md](../hero/README.md) | Hero level gates (10, 11, 16, 55); fate skill buffs in attributes |
| [../mail/README.md](../mail/README.md) | Cornucopia and lotto prizes by mail |
| [../chat/README.md](../chat/README.md) | Winner lines rendered as chat markup (channels 3, 21, 103, 111) |
| [../cross-server/README.md](../cross-server/README.md) | Cornucopia activation total "em todos os servidores" |
| [../laboratory/platinum-pot.md](../laboratory/platinum-pot.md) | Shares the 9645 dispatcher by `extend1` |

## Suggested implementation order

1. 9645 dispatcher by header `extend1` (shared with vip, laboratory, recharge).
2. [fate-wheel.md](fate-wheel.md): permanent system with full client config.
3. [wish-pool.md](wish-pool.md) and [gashapon.md](gashapon.md): richest event UIs.
4. [lucky-roulette.md](lucky-roulette.md) and [charge-roulette.md](charge-roulette.md): need currency and recharge hooks.
5. [joy-grand-prize.md](joy-grand-prize.md), [foison-horn.md](foison-horn.md).
6. [super-lotto.md](super-lotto.md): reject only.
