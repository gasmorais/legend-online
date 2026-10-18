# Recharge, first recharge and rebates ("Recarga, primeira recarga e reembolsos")

Everything that turns real money into diamonds and the activities that reward recharging: the recharge page and the server side crediting, first recharge packs ("Pacote de Primeira Recarga"), period recharge pack ("Pacote de prendas de recarga"), continuous recharge ("Evento de recarga contínua"), general compensation ("Compensação Geral", 全民返利), encouragement gold ("Ouro da Incentivação", 鼓励金) and the recharge feedback pack ("Feedback de Pacote de Recarga", rebate proto).

The client never talks to a payment system: every "Recarregar" button opens the external `PAY` URL from `config.xml` in a new browser window. Diamonds arrive later through socket pushes after the server receives a payment notification over HTTP. PostgreSQL schema: `recharge`. Rust handlers: `recharge::<module>::handle_<action>`.

Registry notes:
- Proto package `reward` (`RewardInfo`, `RewardFreshReqMsg`, ...) is the bounty quest system ("悬赏", used by `OfferRewardManager`, `RingTaskManager`, `MarryManager`), not recharge. It is documented by [../quests/README.md](../quests/README.md).
- The `feedback` client package (registry: customer-service) is the UI of the `rebate` proto package; it is documented here in [recharge-feedback.md](recharge-feedback.md).

## Entry points

| Entry | Condition | Opens |
|---|---|---|
| Main toolbar pay button (`decompiled/core_module/scripts/ui/maintoolbar/MainToolBar.as:536, 1391-1395`) | always | external recharge page ([payment.md](payment.md)) |
| Right click context menu "recharge" (`decompiled/core_module/scripts/yishi/utils/RightMenuUtils.as:48-52`) | always | external recharge page |
| "Diamante insuficiente, recarregar?" alert | any diamond check fails | external recharge page |
| Top toolbar "newfirstpay" (template 4022) | 4590 `param1` 4022 open and hero level >= 6 | [first-pay.md](first-pay.md) new first recharge |
| Top toolbar "recharge" (template 2010 "时段首充") | hero level >= 11 and an activity of type 15 with a not yet reached tier | [first-pay.md](first-pay.md) period recharge pack |
| Top toolbar "continuepayrrbate" (template 2013) | hero level > 6 and continuous recharge activities (types 2500 and 2501) in their show window | [continuous-pay.md](continuous-pay.md) |
| Top toolbar "wholerebate" (template 2049) | 4866 `param7` open | [whole-rebate.md](whole-rebate.md) |
| Top toolbar "encoGold" (template 2020) | hero level >= 6 and 421 open | [enco-gold.md](enco-gold.md) |
| Top toolbar "feedback" (template 2016 "充值回馈礼包") | hero level >= 6, 4461 active and inside its dates | [recharge-feedback.md](recharge-feedback.md) |

## Modules

| Module | Content |
|---|---|
| [payment.md](payment.md) | Recharge page URL, proposed HTTP routes (`/pay`, `/pay/notify`), order crediting, `first_charge` flag, fan out of recharge events to every activity, recharge alert |
| [first-pay.md](first-pay.md) | New first recharge 3 tiers x 3 days (4290, 8672, `FirstPayTemplates`), period recharge pack (activity type 15), legacy first pay frame (dead code, `FirstChargeItems`) |
| [continuous-pay.md](continuous-pay.md) | Continuous recharge: daily threshold chests (activity type 2501) and cumulative rewards (type 2500), claims through 8586 |
| [whole-rebate.md](whole-rebate.md) | General compensation: daily draw of a rebate percent (9645 extend1 28), 4866 state, extra diamonds on recharge up to a cap |
| [enco-gold.md](enco-gold.md) | Encouragement gold: gain days and discount days on the first consumption, 9643, 421, 422 |
| [recharge-feedback.md](recharge-feedback.md) | Recharge feedback packs: tiers by recharged diamonds (4461, 4463, 8574) |

## Dependencies

- [../currency/README.md](../currency/README.md): diamonds credit (`currency::spending::grant`), consumption hook for encouragement gold, ledger.
- [../seasonal-events/README.md](../seasonal-events/README.md): the generic activity engine "funny" (4475 `U_C_SUM_ACTIVE_TEMP`, 4476 `U_C_SUMACTIVE_DATA`, 8586 `C_SUMACTIVE_GATE`) that carries the period recharge pack and continuous recharge.
- [../vip/README.md](../vip/README.md): VIP purchases are the main diamond sink; VIP shop EXP from recharge (disabled).
- [../cross-server/README.md](../cross-server/README.md): recharge ranking (`exchargerank`, 4745, 8866) listens to the same recharge events.
- [../lotteries/README.md](../lotteries/README.md): recharge roulette (`chargelottery`, 432, 433).
- [../returning-players/README.md](../returning-players/README.md): returner recharge rewards (4739).
- [../mail/README.md](../mail/README.md): rewards that do not fit the bag.

## Suggested implementation order

1. `recharge.orders` and the HTTP notify route with idempotent crediting; push 3 with `point` and `first_charge` ([payment.md](payment.md)).
2. Recharge event bus `recharge::payment::on_credited` with per activity listeners.
3. New first recharge (4290, 8672).
4. Recharge feedback (rebate) and general compensation.
5. Funny based recharge activities (type 15, 2500, 2501) once the activity engine exists.
6. Encouragement gold (needs the consumption hook of the currency feature).
