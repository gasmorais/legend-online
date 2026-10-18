# Minas do Tesouro (`mines`)

Domain: economy. Client packages `fund` (m11: `FundFrame`, `FundNewBuyView`, `FundNewBuyItem`, `FundNewRewardView`, `FundNewRewardItem`, `FundNewDoubleGiftItem`, plus legacy `FundBuyView`, `FundBuyItem`, `FundRewardView`, `FundRewardItem`, `FundNewbieFrame`) and `fundVein` (m11: `FundVeinFrame`, `FundVeinItem`, `FundVeinItemCell`, `FundVeinDiamondCell`). Shared code in `core_module`: `managers/FundManager.as`, `managers/FundVeinManager.as`, `mvc/module/fund/*`, `mvc/module/fundVein/*`, `mvc/controler/FundController.as`, `mvc/controler/FundVeinController.as`, `fund/FundItem.as`. Protobuf package `active` (`DepositActiveMsg`, `ActiveParamMsg`, `GetItemInfosMsg`, `GItemInfoMsg`, `GetLogMsg`, `LodeListMsg`, `LevelInfoMsg`, `GradeRewardInfoMsg`, `RewardItemInfoMsg`); the registry lists no proto package because these messages live in `active`.

## Overview

Two "investment" systems with mine artwork:

1. **Minas do Tesouro** (`fund`, top bar template 2014). A timed recharge event. During the participation window ("Tempo de abertura do evento") the player's accumulated recharge ("Recarga atual acumulada") reaches one of 5 tiers (mines). During the collection window each tier pays daily rewards ("Tempo de Coleta"): every day the player chooses package A or B ("Pacote A", "Pacote B"), and the first choice fixes the package for all later days ("Pode coletar um tipo de pacote fixo"). Uncollected rewards are mailed after the event (help text).
2. **Minas de Iniciante** (`fundVein`, controller `fundnewbie`, top bar template 2004). A one time newbie offer: 3 mine sets bought with diamonds (config `FreshManDepositCost` 200, 2000, 10000), each paying diamonds and bound diamonds when the hero reaches given levels ("Condições para coletar: Nível da Personagem {0}").

## Entry points

| Entry | Condition | Opens | Source |
|---|---|---|---|
| Top bar `fund` "Minas do Tesouro" | `FundManager.getShowBtn()`: hero level >= 11 and (`activeType == 1` or (`activeType == 2` and `depositLevel > 0`)); data comes from a 4612 push | click sends 8703 op 0 and sets `isUseOpen`; the 4612 answer opens `FundFrame` (controller `fund`, openType 2) | `decompiled/core_module/scripts/ui/toptoolbar/TopBtnCheckShowHelper.as:257-258`, `decompiled/core_module/scripts/ui/toptoolbar/TopToolsBar.as:1153-1157`, `decompiled/core_module/scripts/managers/FundManager.as:89-172,218-233` |
| Top bar `fundnewbie` "Minas de Iniciante" | `FundVeinManager.isShowBtn` = `!isOver` (default `isOver = true`, so a 4640 push is required) | `FundVeinFrame` (controller `fundnewbie`); badge = claimable rewards (InfoTips key 22) | `TopBtnCheckShowHelper.as:259-260`, `TopToolsBar.as:1158-1160,2739,2801-2803`, `decompiled/core_module/scripts/managers/FundVeinManager.as:81-89`, `decompiled/core_module/scripts/yishi/manager/InfoTipsManager.as:243-247` |

## Modules

| Module | File | Scope |
|---|---|---|
| Treasure mines | [treasure-mines.md](treasure-mines.md) | "Minas do Tesouro": 8703/4612, event windows, tiers by accumulated recharge, daily A/B packages, logs, mail of unclaimed rewards |
| Newbie mines | [newbie-mines.md](newbie-mines.md) | "Minas de Iniciante": 8751/4640, 3 diamond purchases, level based diamond rewards |

## Protocol summary

| Dir | Opcode | Hex | Name | Module |
|---|---|---|---|---|
| C>S | 8703 | 0x21ff | `C_U_ACTIVE_DEPOSIT` (`DepositActiveMsg.opType` 0 query, 1 join tier, 2 claim) | treasure-mines |
| S>C | 4612 | 0x1204 | `U_C_ACTIVE_DEPOSIT` (`DepositActiveMsg`) | treasure-mines |
| C>S | 8751 | 0x222f | `C_FRESHMAN_DEPOSIT` (`DepositActiveMsg.opType` 0 query, 1 buy, 2 claim) | newbie-mines |
| S>C | 4640 | 0x1220 | `U_C_FRESHMAN_DEPOSIT` (`LodeListMsg`) | newbie-mines |

## Dependencies

| Feature | Why |
|---|---|
| [recharge](../recharge/README.md) | accumulated recharge during the treasure mines window (`chargePoint`); "Recarregar" button opens the recharge page |
| [currency](../currency/README.md) | diamonds ("point") spent on newbie mines; diamonds and bound diamonds ("giftToken", ids -400 and -500) paid as rewards |
| [inventory](../inventory/README.md) | item rewards of treasure mines |
| [mail](../mail/README.md) | uncollected treasure mine rewards are mailed after the event |
| [hero](../hero/README.md) | hero level for button visibility and newbie reward conditions |

## Suggested implementation order

1. [newbie-mines.md](newbie-mines.md): small, self contained, only currency.
2. [treasure-mines.md](treasure-mines.md): event config, recharge hook, daily claims, end of event mail job.
