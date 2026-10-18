# Revenge Road ("Caminho da Vingança")

Area: roads, module `revenge-road`. Client package `revenge` (`decompiled/m11/scripts/revenge`), manager `yishi.manager.RevengeRoadManager`, model `mvc.module.revenge.RevengeModel` / `RevengeNodeInfo`, controller key `revengeroad` (`decompiled/core_module/scripts/mvc/controler/RevengeRoadController.as`), messages `module.RevengeRoadMsg` and `gameplot.PlotMsg`. Sweeps use [mopup](../mopup/README.md) `sweep_type = 5`. Requires the deified hero ([avenger](../avenger/README.md)).

Path aliases:

| Alias | File |
|---|---|
| RVM | `decompiled/core_module/scripts/yishi/manager/RevengeRoadManager.as` |
| RVMOD | `decompiled/core_module/scripts/mvc/module/revenge/RevengeModel.as` |
| RV | `decompiled/m11/scripts/revenge/` |

## 1. Overview

"Sua força foi tomada, use de toda a sua fúria para trilhar o caminho da Vingança!" A linear PvE campaign of 5 areas ("Pasto Livre", "Floresta Nebulosa", "Pântano Sem Fim", "Deserto da Morte", "Terra do Julgamento") x 10 nodes (50 nodes). Each fight costs 20 "Corações de Vingança" (revenge hearts: max 200, +10 per hour, 3 refills per day at 500 diamonds). Boss nodes (5 of them) have 3 attacks per day, with up to 3 extra attacks at 80 diamonds. First clears give first drops, every clear gives attack drops. Each area has a completion chest. Cleared nodes can be swept. Battle type 3887 `REVENGE_ROAD_BATTLE`. Structure and messages mirror [../trials/demon-land.md](../trials/demon-land.md).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `revenge.RevengeRoadFrame` (`RV/RevengeRoadFrame.as`), 1032 x 650 | "Coração de Vingança" counter, "Recupera {0} Corações de Vingança por hora" | Area map (5 areas, locks), area chests ("Condições de coleta: passar de {0}"), heart refill | controller `revengeroad` default via `SwitchPageHelp.openRevengeRoad` (`decompiled/core_module/scripts/yishi/SwitchPageHelp.as:2536-2550`, deified required "Primeiro complete a prova de Divindade"); after 4896; after a 3887 battle (`RVM.battleOverHandlerView`, `RVM:221-224`) | 4895 |
| `revenge.RevengeNodeFrame` (`RV/RevengeNodeFrame.as`), 897 x 543 | area nodes | 10 nodes of an area | openType `node` with the area id (`RV/RevengeRoadFrame.as:221-231`), locked areas "Primeiro complete a fase anterior" | node states |
| `revenge.RevengeFightFrame` (`RV/RevengeFightFrame.as`), 400 x 460 | "Desafios restantes: {0}" | Node detail: rewards, fight, boss attack purchase, sweep | openType `fight` (`RV/RevengeNodeFrame.as:185-198`) | template, node msg |
| `mopup.view.RevengeRoadMopupPrepareFrame` / `RevengeRoadMopupIngFrame` | "Bot do Caminho da Vingança" | Sweep | controller `mopup` openType 15 / 16 with `{nodeId, bossFightCount}` (`RV/RevengeFightFrame.as:120-126`) | 4425 |

## 3. Routes (client to server)

Route: send 9688 (0x25d8) `C_REVENGE_ROAD_OP` with `player.PlayerOpMsg` (`op` (#1), `index` (#6), `nodeId` (#10); other fields unused). Ops (`RVM:29-37`): 0 GET_DATA, 1 ATTACK, 2 GET_BOX, 3 BUY_REVENGE_HEART, 4 BUY_ATTACK_COUNT.

| # | UI control | Client sender | Client checks | Fields | Response |
|---|---|---|---|---|---|
| V1 | Main frame open | `RVM.sendGetData` (`RVM:177-183`) from `RV/RevengeRoadFrame.as:39` | open checks | `op 0` | 4895 |
| V2 | Fight | `RVM.sendAttackNode(nodeId)` (`RVM:185-193`) from `RV/RevengeFightFrame.as:154-178` | boss node attacks left > 0 ("Número de ataques insuficientes"); hearts < `Cost` with refills left -> refill dialog "Deseja gastar {0} diamantes para repor {1} Corações de Vingança? (Pode repor mais {2}vezes)" (`RVMOD.checkIsNeedBuyAlert`) | `op 1`, `nodeId` | battle 3887; after it 4895; frame reopens |
| V3 | Area chest | `RVM.sendGetAreaBox(idx)` (`RVM:212-219`) from `RV/RevengeRoadFrame.as:145-149` | enabled when `nodeId >= idx x 10` (`RV/RevengeRoadFrame.as:83-95`) | `op 2`, `index` = area 1..5 | 4895 (`boxState`) |
| V4 | Refill hearts | `RVM.sendBuyHeart` (`RVM:195-201`) | confirm (price 500, refills left `3 - buyCount`) | `op 3` | 4895 (`revengeHeart`, `buyCount`) |
| V5 | Buy boss attack | `RVM.sendBuyBoss(nodeId)` (`RVM:203-210`) from `RV/RevengeFightFrame.as:130-151` | confirm "Deseja gastar {0} diamantes para comprar uma oportunidade de participação? (Pode comprar mais {1}vezes)" (80 diamonds, 3 per node) | `op 4`, `nodeId` | 4895 (node `buyCount`) |
| V6 | Sweep | `MopupManager.sendMopupInfo(5, op, nodeId, count, nodeId)` (`decompiled/m5/scripts/mopup/view/RevengeRoadMopupPrepareFrame.as:296`, `RevengeRoadMopupIngFrame.as:410`, `:444`, `:465`, `:610`) | node cleared; hearts; gold `revengeroad_sweep_gold` | send 8528 (0x2150) `C_CAMPAIGN_SWEEP`, `CampaignSweepReq`: `sweep_type` (#1) 5, `op_type` (#2) 1..4, `campaign_id` (#3) node, `count` (#4), `e_index` (#5) node | 4425 (mopup), 4895 |

## 4. Server messages (server to client)

| Opcode | Message and fields | Client receiver | When |
|---|---|---|---|
| 4895 (0x131f) `U_C_REVENGEROAD_INFO` | `module.RevengeRoadMsg`: `type` (#1, INT32) operation echo; `nodeId` (#2) highest cleared node 0..50; `revengeHeart` (#3); `buyCount` (#4) heart refills today; `updateTime` (#5, STRING) last regeneration time; `boxState` (#6, STRING) CSV of 5 values, "1" = collected; `nodeList` (#7, repeated `RevengeRoadNodeMsg`: `nodeId` (#1), `attackCount` (#2) attacks used today, `buyCount` (#3) attacks bought today). Fields apply only when present | `RVM.__revengeInfoHandler` (`RVM:132-175`) -> `REVENGE_ROAD_DATA` | V1..V6, battles |
| 4896 (0x1320) `U_C_REVENGEROAD_DIALOG` | `gameplot.PlotMsg` (see [../trials/demon-land.md](../trials/demon-land.md)): `loop` true plays the dialog then opens the main frame, false opens it at once | `RVM.onReceiveDialogData` (`RVM:65-85`) | Story dialogs (e.g. first entry, area unlock; assumption) |

## 5. Rules and formulas

- `revenge_road_config = 200,10,3,500,3,80` (`RVMOD` constructor): max hearts 200, +10 per hour, 3 heart refills per day at 500 diamonds (refill to max, "repor {1}" with `MAX_VALUE`), boss attack purchases 3 per node per day at 80 diamonds.
- Nodes: `RevengeRoadTemplates.xml` 50 rows, `Cost` 20, `AttackCount` 3 on 5 boss nodes (0 = unlimited), `FirstDropId`, `AttackDropId` (`RevengeRoadDrop.xml`), `Bosses`, `Npcs`, `DialogId` (all 0 in this data).
- Area N unlocks when `nodeId >= (N - 1) x 10` (`RV/RevengeRoadFrame.as:209-213`, `:221-229`).
- Area chests: `RevengeRoadBoxDrop.xml` `site = area`, collectable when `nodeId >= area x 10`, once.
- Sweep: `revengeroad_sweep_time = 60` s, `revengeroad_sweep_gold = 50000` per run.
- Entry: daily guide type 81 (`decompiled/core_module/scripts/managers/DayGuideManager.as:924-925`), space NPC dialog option 145, task links `gotoRevengeRoad` (walk to NPC 51, `SwitchPageHelp.as:2799-2819`).

## 6. Templates

| File | Record | Fields |
|---|---|---|
| `raw/xml/tempinfos/RevengeRoadTemplates.xml` | node | `NodeId`, `Name`, `Bosses`, `Npcs`, `Cost`, `AttackCount`, `DialogId`, `FirstDropId`, `AttackDropId` |
| `raw/xml/tempinfos/RevengeRoadDrop.xml` | drop | `dropId`, `itemId`, `count`, `isBind`, `appearType` |
| `raw/xml/tempinfos/RevengeRoadBoxDrop.xml` | area chest | `site`, `para2`, `itemId`, `count` |
| `raw/xml/tempinfos/ConfigInfos.xml` | `revenge_road_config`, `revengeroad_sweep_time`, `revengeroad_sweep_gold` | |

## 7. Persistent state

```sql
CREATE TABLE roads.revenge_road_state (
    player_id          BIGINT     PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
    max_node_id        smallint    NOT NULL DEFAULT 0 CHECK (max_node_id BETWEEN 0 AND 50),
    hearts             smallint    NOT NULL DEFAULT 200 CHECK (hearts >= 0),
    hearts_updated_at  timestamptz NOT NULL DEFAULT now(),
    heart_refills      smallint    NOT NULL DEFAULT 0,
    box_state          smallint[]  NOT NULL DEFAULT '{0,0,0,0,0}',
    daily_date         date        NOT NULL DEFAULT current_date
);

CREATE TABLE roads.revenge_road_node (
    player_id       BIGINT  NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
    node_id         smallint NOT NULL CHECK (node_id BETWEEN 1 AND 50),
    attacks_used    smallint NOT NULL DEFAULT 0,
    attacks_bought  smallint NOT NULL DEFAULT 0,
    PRIMARY KEY (player_id, node_id)
);
```

## 8. Backend implementation notes

- `roads::revenge_road::handle_op` (9688): op 0 `handle_get_data`, 1 `handle_attack`, 2 `handle_get_box`, 3 `handle_buy_heart`, 4 `handle_buy_attack`.
- Lazy heart regeneration (+10 per full hour, cap 200) and daily reset (refills, boss attacks) before each op.
- Attack: deified hero; node <= `max_node_id + 1`; hearts >= 20; boss attacks left; deduct, battle 3887 (`Bosses` + `Npcs`). Win: first clear advances `max_node_id` and grants `FirstDropId`; always `AttackDropId`; boss attack counter. Push 4895.
- Box: `max_node_id >= area x 10`, not collected; grant chest rows.
- Sweep via `mopup::handle_campaign_sweep` type 5.

## 9. Open questions and assumptions

- 4896 trigger conditions (all `DialogId` are 0 in this data).
- Heart refill amount (assumed to max, from the dialog showing `MAX_VALUE`).

## 10. Implementation checklist

- [ ] Template and config loaders
- [ ] Tables `roads.revenge_road_state`, `roads.revenge_road_node`
- [ ] V1 data, V2 fight 3887, V3 chest, V4 refill, V5 boss attack purchase
- [ ] V6 sweep type 5
- [ ] Heart regeneration and daily reset
- [ ] Tests: area unlock, costs, boss limits, chest once
