# Hermitage war ("Batalha do Eremitério")

Client packages `war2023` (`decompiled/m3/scripts/war2023/**`, views) and `mvc.module.war2023` (`decompiled/core_module/scripts/mvc/module/war2023/**`, model), manager `yishi.manager.SecretWarManager` (`decompiled/core_module/scripts/yishi/manager/SecretWarManager.as`). Protobuf package `com.road.yishi.proto.secretwar` ("秘境战场", secret war). The registry also assigns the client package `sevenyear` (7th anniversary hub) to this feature; it is documented in [seven-year-event.md](seven-year-event.md).

The war is a cross-server node-capture battleground for divine-class heroes. Twice a day a 20-minute round opens; up to 30 players are split into the Blue ("Formação Azul") and Red ("Formação Vermelha") camps on a 17-node map. Players move between adjacent forts ("Fortes"), occupy neutral or enemy forts, defend their own, and fight enemy players on the same node (battle 3908). Occupied forts produce camp and personal points; the first camp to 7500 points wins, else the higher score at time out. Personal score decides the reward ("Mérito", spent in the "Loja de Mérito").

All traffic is socket based; no HTTP routes. PostgreSQL schema: `hermitage_war`. Rust handlers: `hermitage_war::<module>::handle_<action>`.

Citation prefixes: `CM/` = `decompiled/core_module/scripts/`, `M3/` = `decompiled/m3/scripts/`, `M11/` = `decompiled/m11/scripts/`, `TPL/` = `raw/xml/tempinfos/`, `LANG` = `index/language.json`, `SWM` = `CM/yishi/manager/SecretWarManager.as`.

## Entry points

| Entry | Condition | Opens |
|---|---|---|
| Top toolbar button key `secretwar` (template 4029 "秘境战场" in `TPL/TopToolBtnInfos.xml`) | visible when `VersionSwitch.SECRET_WAR` (true, `CM/yishi/datas/VersionSwitch.as:254`; `CM/ui/toptoolbar/TopBtnCheckShowHelper.as:425-426`); click requires `thane.isAvenger` (`vocationIndex >= 3`, `CM/yishi/datas/playerinfo/SimplePlayerInfo.as:1264-1267`) else "Desbloqueado após se tornar uma Classe Divindade." (`CM/ui/toptoolbar/TopToolsBar.as:1521-1530`) | `war2023.SecretwarEnterFrame` "Batalha do Eremitério" ([lobby.md](lobby.md)) |
| Login while inside a running war | `LoginStateMsg.state = 8` sets `SecretWarManager.loginToSecretWarFlag` (`CM/yishi/manager/BaseManager.as:1920-1939`) | server resends 544, scene `SECRET_WAR_SCENE` |
| Battle 3908 end | `BattleResultHandler` returns to `SECRET_WAR_SCENE` while the war is not over (`CM/battle/handler/BattleResultHandler.as:312-321,501-504`) | battlefield with the node frame reopened |
| War end | 548, return to space with `isSecretwarResult` (`SWM:295-325`, `M3/map/space/SpaceSceneController.as:469-471`) | `SecretwarWinFrame`, then `SecretwarResultFrame` ([results.md](results.md)) |

UI module key `secretwar` (`CM/mvc/controler/SecretWarController.as:27-50`): openType 0 enter frame, 1 node frame, 2 win frame, 3 rank frame, 4 result frame, 5 shop frame.

## Modules

| Module | Content |
|---|---|
| [lobby.md](lobby.md) | Schedule and toolbar state (4590), enter frame, reward counter (550), enter (9725 op 0/1), exile on leave, reconnect |
| [battlefield.md](battlefield.md) | `SECRET_WAR_SCENE`: map graph, camps, player states, move/occupy/defend (9725 op 3/4/5), leave (op 2), snapshots 544/545/546/549, node production, fights (battle 3908) |
| [results.md](results.md) | Live ranking (op 6 -> 547), end result 548, win and result frames, daily reward limit, Mérito grant |
| [seven-year-event.md](seven-year-event.md) | 7th anniversary hub `sevenyear` (battle flag pass, purchases, quiz, daily game, achievements, rankings, treasure box, star area and glory tabs) |
| Merit shop | Documented in [../shops/exploits-shop.md](../shops/exploits-shop.md) (9727, 540; `SWM:94-102,364-371`) |

## Dependencies

- [avenger](../avenger/README.md): entry requires the divine class (`isAvenger`).
- Battle engine (`docs/battle/server-engine.md`): battle type 3908 `SECRET_WAR_BATTLE` (`CM/yishi/datas/battle/BattleType.as:248`).
- [shops](../shops/exploits-shop.md): "Loja de Mérito"; currency "Mérito" ([currency](../currency/README.md), item -5500 per `secret_war_limit`).
- [account](../account/README.md): login state 8 reconnect.
- [seasonal-events](../seasonal-events/README.md): proto package `active.anniversary` used by [seven-year-event.md](seven-year-event.md); the toolbar key `sevenyear` opens `yearactive` there.
- [auto-chess](../auto-chess/README.md), [glory-supremacy](../glory-supremacy/README.md), [artillery/snow-battle.md](../artillery/snow-battle.md), [cosmos/stararea.md](../cosmos/stararea.md): tabs and cards of the anniversary hub.

## Suggested implementation order

1. Config and schedule (`secret_war_*` keys), 4590 toolbar push, 550 reward counter.
2. [lobby.md](lobby.md): op 0/1, matchmaking into rooms of 30 by level band, 544 bootstrap.
3. [battlefield.md](battlefield.md): node graph, movement timer, occupy timer, defend, production tick, 545/546 pushes, fights via battle 3908.
4. [results.md](results.md): op 6, end detection, 548, rewards and daily limit.
5. [seven-year-event.md](seven-year-event.md) only if the anniversary event is enabled.
