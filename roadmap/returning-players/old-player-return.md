# Old player return screens ("Regresso dos Jogadores Antigos")

Module `old-player-return` of feature `returning-players`. Client package `oldplayerreturn` (m11, 21 classes) with `decompiled/core_module/scripts/yishi/manager/OldPlayerReturnManager.as` and `decompiled/core_module/scripts/mvc/module/oldplayerreturn/OldPlayerReturnModel.as`.

The protocol (C>S 9717 `C_ALLIANCE_REGRESSION_OP`, S>C 534, 535, 536, 538, protobuf package `allianceregression`), rules, templates, tables and handlers are mapped in [league](../league/README.md): [alliance-event.md](../league/alliance-event.md), [alliance-contracts.md](../league/alliance-contracts.md), [alliance-tasks.md](../league/alliance-tasks.md), [alliance-shop.md](../league/alliance-shop.md). This file only lists the screens of the client package and where each is specified. Do not implement a second copy.

## Screens

| Class | pt-BR title | Purpose | Specified in |
|---|---|---|---|
| `OldPlayerReturnFrame` | "Regresso dos Jogadores Antigos" | frame with tabs "Missão de Regresso", "Contrato da Aliança", "Marco", "Loja do Evento" (`decompiled/m11/scripts/oldplayerreturn/OldPlayerReturnFrame.as:132-135`) | [alliance-event.md](../league/alliance-event.md) |
| `OldPlayerReturnBuffItem` | | privilege buff row | [alliance-contracts.md](../league/alliance-contracts.md) |
| `task/OldPlayerReturnTaskView`, `OldPlayerReturnTaskItem`, `OldPlayerReturnTaskBoxItem` | "Missão de Regresso" | return tasks and daily / weekly boxes | [alliance-tasks.md](../league/alliance-tasks.md) |
| `alliance/OldPlayerReturnAllianceView` | "Minha Aliança" | my alliance | [alliance-contracts.md](../league/alliance-contracts.md) |
| `alliance/OldPlayerReturnLeftView`, `OldPlayerReturnHeadItem`, `OldPlayerReturnHeadMenu` ("Rescindir o contrato") | | members, terminate contract | [alliance-contracts.md](../league/alliance-contracts.md) |
| `alliance/OldPlayerReturnContractView`, `OldPlayerReturnContractFrame` | "Contrato da Aliança" | contract levels and rewards | [alliance-contracts.md](../league/alliance-contracts.md) |
| `OldPlayerReturnFindFrame`, `OldPlayerReturnFindItem` | | ally search and apply | [alliance-contracts.md](../league/alliance-contracts.md) |
| `alliance/OldPlayerReturnAlliTaskView`, `OldPlayerReturnOracleTaskView`, `OldPlayerReturnOracleTaskItem` | | alliance and oracle tasks | [alliance-tasks.md](../league/alliance-tasks.md) |
| `milestone/OldPlayerReturnMilestoneView`, `OldPlayerReturnMilestoneItem` | "Marco" | milestones | [alliance-tasks.md](../league/alliance-tasks.md) |
| `shop/OldPlayerReturnShopView`, `OldPlayerReturnShopItem`, `OldPlayerReturnShopBuyFrame` | "Loja do Evento" | event shop | [alliance-shop.md](../league/alliance-shop.md) |

## Entry points

Top toolbar keys `oldplayerreturn` and `oldplayerreturn2` (`decompiled/core_module/scripts/ui/toptoolbar/TopBtnCheckShowHelper.as:421-424`), see [alliance-event.md](../league/alliance-event.md).

## Implementation checklist

- [ ] Implement through [league](../league/README.md); verify every screen above against the league module it points to
