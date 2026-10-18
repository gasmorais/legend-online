# Increasing Road ("Rua Mítica")

Area: roads, module `increasing-road`. Client packages `increasingly` (model `mvc.module.increasingly.IncreasinglyModel`, `IncreasinglyBossInfo`, `IncreasinglyRewardsInfo`) and `increasinglyroad` (scene `decompiled/m11/scripts/increasinglyroad/IncreasinglyRoadFrame.as`, scene type `INCREASINGLY_ROAD_SCENE`), manager `managers.IncreasinglyRoadManager`, controller key `increasinglyroad`; shop "Loja da Rua Mítica" (`decompiled/m15/scripts/view/subshop/DemonRoadShop*.as`, controller `demonroadshop`, shop id 1022). Internal Chinese name 神魔之路; proto package `demonroad` (opcode 5195 `C_DEMON_ROAD_OP`, not to be confused with [../trials/demon-land.md](../trials/demon-land.md)).

Path aliases:

| Alias | File |
|---|---|
| IRM | `decompiled/core_module/scripts/managers/IncreasinglyRoadManager.as` |
| IRF | `decompiled/m11/scripts/increasinglyroad/IncreasinglyRoadFrame.as` |
| IRL | `decompiled/m11/scripts/increasinglyroad/view/IncreasinglyroadLayerItemView.as` |
| DRS | `decompiled/m15/scripts/view/subshop/` |

## 1. Overview

An endless climb of floors ("piso"), each with several bosses in order. Each fight costs 10 action points ("Movimento", max 100); action points can be bought with diamonds (escalating price list). Each boss shows its reward (fragments); the rewards of the current floor can be re-rolled for 50 diamonds, and they refresh daily at 0:00 ("Nota: Todo dia às 0h se atualiza a Prêmiação de monstros dos pisos."). Beaten bosses (lower floors, or earlier bosses on the top floor) can be swept for the same action point cost. Battle type 3893 `INCREASINGLY_ROAD_BATTLE`. Gold cast stones (item 6930001, "pedras fundidas de ouro") are decomposed into "Pó Mítico" (demon dust) to buy items in the Rua Mítica shop.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `increasinglyroad.IncreasinglyRoadFrame` (`IRF`), scene `INCREASINGLY_ROAD_SCENE` | note "Nota: Todo dia às 0h se atualiza a Prêmiação de monstros dos pisos." | Floor view with boss items (`IRL`), floor up/down, action points bar, buy action points, refresh rewards, shop button (controller `shop` 1022) | `SwitchPageHelp.openIncreasinglyRoad` (`decompiled/core_module/scripts/yishi/SwitchPageHelp.as:2750-2772`): `VersionSwitch.INCREASINGLY_ROAD`, not in a team ("Você está no modo de equipe, não pode entrar na Rua Mítica."), deified (`isAvenger`), `checkScene()`; daily guide type 91, space NPC dialog option 149; after a 3893 battle (`decompiled/core_module/scripts/battle/handler/BattleResultHandler.as:132-136`) | 205 |
| `IRL` (boss item) | sweep confirm "Quer consumir {0} de Movimento e usar 1 Bot?" | Fight or sweep a boss | floor view | `IncreasinglyBossInfo` (resource icon, rewards) |
| `view.subshop.DemonRoadShopFrame` (`DRS/DemonRoadShopFrame.as`) | "Loja da Rua Mítica"; currency "Pó"; help "Guia da Loja da Rua Mítica" ("1. Os jogadores podem obter o Pó Mítico decompondo a pedra fundida de ouro") | Shop list and decompose entry | shop controller 1022 ([shops](../shops/README.md)) | shop templates |
| `view.subshop.DemonRoadSolveFrame` / `DemonRoadShopExchangeView` | "Decompor" / "Trocar"; confirm "Você quer decompor {0} pedras fundidas de ouro?" | Decompose stones into dust | shop frame, controller `demonroadshop` (`decompiled/core_module/scripts/mvc/controler/DemonRoadShopController.as:40`) | bag count of 6930001 |

## 3. Routes (client to server)

All routes: send 5195 (0x144b) `C_DEMON_ROAD_OP` with `demonroad.DemonRoadMsg`: `op` (#1, INT32), `energy` (#2), `level` (#3, INT32), `index` (#4, INT32), `buyCount` (#5), `bossInfos` (#6), `items` (#7, repeated `DemonRoadRewardMsg`: `ItemTempId` (#1, INT32), `Count` (#2, INT32)). Ops (`IRM:24-32`): 1 OPEN_FRAME (page), 2 BUY_ENERGY, 3 REFRESH_REWARD, 4 ENTER_BATTLE, 5 resolve (decompose), 6 MOPUP.

| # | UI control | Client sender | Client checks | Fields | Response |
|---|---|---|---|---|---|
| I1 | Scene enter, floor up/down | `IRM.pageChange` (`IRM:183-190`) from `IRF:105-113`, `:271-281` | up enabled when `currentLayer > 1`; down when `currentLayer < maxLayer` | `op 1`, `level` = floor to show | 205 |
| I2 | Buy action points | `IRM.buyEnergy` (`IRM:156-162`) from `IRF:283-313` | purchases left = price list length + returning bonus - bought ("Compras diárias atingiu o limite"); confirm "Deseja consumir {0} diamantes para aumentar {1}pts de movimento? (Hoje você ainda pode comprar {2} vez(es))"; diamonds | `op 2` | 205 (`energy`, `buyCount`) |
| I3 | Refresh floor rewards | `IRM.refreshCurrentLayerReward` (`IRM:146-154`) from `IRF:315-353` | diamonds >= 50; daily confirm "Consumir {0} diamantes para atualizar a Prêmiação deste piso?"; extra warning when a high quality fragment is offered ("Existem atualmente fragmentos de alta qualidade...") | `op 3`, `level` = current floor | 205 (`bossInfos`) |
| I4 | Boss click | `IRM.enterBattle(index)` (`IRM:164-172`) from `IRL:174-189` | boss open (`IRF.isOpen`: any boss on lower floors, on the top floor `index + 1 <= currentIndex`); action points >= 10 ("Movimento insuficiente, não é possível desafiar") | `op 4`, `level`, `index` | battle 3893; after it the client re-enters the scene and sends I1 |
| I5 | Boss sweep | `IRM.mopupBattle(index)` (`IRM:192-200`) from `IRL:126-139` | beaten boss (button shown for lower floors or `index < currentIndex`); action points >= 10; confirm | `op 6`, `level`, `index` | 205 and item rewards |
| I6 | Decompose stones | `IRM.resolveGoods(items)` (`IRM:174-181`) from `DRS/DemonRoadSolveFrame.as:176-190`, `DRS/DemonRoadShopExchangeView.as:436-445` | confirm; quantity <= owned | `op 5`, `items` = [{`ItemTempId` 6930001, `Count` n}] | bag update (115) and dust currency update (assumption: player currency push) |

## 4. Server messages (server to client)

| Opcode | Message and fields | Client receiver | When |
|---|---|---|---|
| 205 (0x00cd) `U_C_DEMON_ROAD_RESP` | `demonroad.DemonRoadMsg`: `energy` (#2) action points; `level` (#3) floor being shown (raises `maxLayer` when higher, `IRM:83-95`); `index` (#4) next boss index on the top floor; `buyCount` (#5) purchases today; `bossInfos` (#6, repeated `DemonRoadBossMsg`: `level` (#1), `index` (#2), `resource` (#3, STRING) boss icon or swf, `rewards` (#4, repeated `DemonRoadRewardMsg`: `ItemTempId` (#1), `Count` (#2))). Only fields present are applied | `IRM.onInfo` (`IRM:68-117`) -> `INCREASINGLY_ROAD_INFO` | Reply to I1..I5 |
| `DemonRoadShopMsg` | `demonDustNum` (#1, INT32), `items` (#2, repeated) | no reader in this client | declared only |

## 5. Rules and formulas

- `demonroad_energy_refresh = 10,100,50`: 10 action points per fight or sweep, max 100, 50 diamonds per reward refresh (`IRF:232-246`).
- `demonroad_energy_buy = 100,100|100,100|150,100|150,100|200,100|200,100|300,100|400,100`: Nth purchase price and amount (8 purchases plus returning player bonus `OldPlayerReturnManager.model.increasinglyRoadCount`).
- Action point regeneration: not visible in the client (assumption: daily reset to max).
- Floor progression: beating the last boss of the top floor opens the next floor (`maxLayer` grows).
- Rewards per boss come from the server (`bossInfos`), refreshed daily and on I3.
- Obsolete sweep configs `demon_road_sweep_time`, `demon_road_sweep_gold` are marked "【废弃】" (deprecated).

## 6. Templates

| File | Record | Fields |
|---|---|---|
| `raw/xml/tempinfos/ConfigInfos.xml` | `demonroad_energy_refresh`, `demonroad_energy_buy` | rules |
| Shop 1022 items | shop templates ([shops](../shops/README.md)) | dust prices |
| Boss pools per floor | not in the client | server configuration |

## 7. Persistent state

```sql
CREATE TABLE roads.increasing_road_state (
    player_id       integer     PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
    max_layer       integer     NOT NULL DEFAULT 1,
    next_index      smallint    NOT NULL DEFAULT 1,
    energy          smallint    NOT NULL DEFAULT 100 CHECK (energy >= 0),
    energy_bought   smallint    NOT NULL DEFAULT 0,
    daily_date      date        NOT NULL DEFAULT current_date
);

CREATE TABLE roads.increasing_road_floor_reward (
    player_id    integer   NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
    layer        integer   NOT NULL,
    boss_index   smallint  NOT NULL,
    resource     text      NOT NULL,
    rewards      jsonb     NOT NULL,
    rolled_on    date      NOT NULL DEFAULT current_date,
    PRIMARY KEY (player_id, layer, boss_index)
);
```

Demon dust is a player currency ([currency](../currency/README.md)).

## 8. Backend implementation notes

- `roads::increasing_road::handle_op` (5195): op 1 `handle_page`, 2 `handle_buy_energy`, 3 `handle_refresh_reward`, 4 `handle_fight`, 5 `handle_resolve`, 6 `handle_mopup`.
- Page: `level <= max_layer`; roll rewards for the floor if missing or stale (daily); reply 205 with `bossInfos` of that floor.
- Fight: boss open rule, energy >= 10, deduct, battle 3893 with the boss army (server pool). Win on the top floor: grant rewards, `next_index += 1`, open the next floor after the last boss.
- Mopup: beaten boss, energy >= 10; grant the boss rewards at once.
- Resolve: consume stones 6930001, add dust (rate unknown).
- Daily reset 0:00: energy to max, purchases 0, rewards re-rolled.

## 9. Open questions and assumptions

- Boss count per floor and boss pools.
- Energy regeneration rule and dust conversion rate.
- Whether rewards refresh resets also on floor change.

## 10. Implementation checklist

- [ ] Config keys loader
- [ ] Tables `roads.increasing_road_state`, `roads.increasing_road_floor_reward`
- [ ] I1 page (205), I2 buy energy, I3 refresh
- [ ] I4 fight 3893, I5 sweep
- [ ] I6 decompose and shop 1022 dust currency
- [ ] Daily reset
- [ ] Tests: open rule, energy costs, purchase price ladder
