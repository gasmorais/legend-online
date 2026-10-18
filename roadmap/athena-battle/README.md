# Athena battle ("Batalha de Athena")

Feature slug `athena-battle`. Client package `braveleg` (`decompiled/m11/scripts/braveleg`, models `decompiled/core_module/scripts/mvc/module/braveleg`). Protobuf package `com.road.yishi.proto.braveleg`. Client manager `yishi.manager.BraveLegManager`. Chinese names 勇者征程 / 雅典娜之战.

Citation prefixes: `CM/` = `decompiled/core_module/scripts/`, `M11/` = `decompiled/m11/scripts/`, `TPL/` = `raw/xml/tempinfos/`, `LANG` = `index/language.json`, `PTT` = `CM/yishi/datas/consant/ProtocolTypeTable.as`. "(A)" marks an assumption.

## Critical finding: the receive side is disconnected in this client

`BraveLegManager.setup()` creates the model but never calls `addEvent()`, and `addEvent()` is empty (`CM/yishi/manager/BraveLegManager.as:73-76,224-226`). The seven handlers (`__viewInfoHandler`, `__teamInfoHandler`, `__teamListInfoHandler`, `__inviteInfoHandler`, `__rankInfoHandler`, `__playerListInfoHandler`, `__teamInspireInfoHandler`, `:228-409`) are never registered. Worse, the Athena push opcodes of PTT (376..383) are reused by other managers in this build: `AirGardenManager` listens to 376, 377, 379, 380, 381 (`CM/managers/AirGardenManager.as:58-62`), the campaign proxy to 378 (`CM/proxy/scene/CampaignSocketDataProxy.as:92`). `TopToolsBar.braveLegState` has no writer, so the badge stays at 0.

Consequences:

- The client can send 9619 (top bar button `braveleg`, level 40), but no answer can open a frame. Sending 379 would be parsed by Air Garden.
- Implementing the server alone does not make the feature playable. Enabling it needs a runtime decision (CLAUDE.md forbids hand edits of generated code; a fix would have to be a documented `PATCHES` entry restoring listeners on free opcodes, which is a change of original behavior). Until decided, the server should answer nothing to 9619 except, optionally, a "not open" notice.

This roadmap still maps the whole feature from the UI code, with the presumed opcode of each handler taken from the PTT names, so it can be implemented if the listeners are restored.

## What it is for the player (from UI and strings)

Weekly cross server team tournament (`Brave_Day` = 4, `Brave_Time` 20:00 to 21:00). Signup is individual ("Inscrição: Modo individual") for `Brave_NeedGold` = 1000000 gold. When the event opens, signed players create or join teams of 2 to 4 ("Modo de combate: 2~4 jogadores"), split into 3 groups; a fight is won by the team that wins 2 of the 3 group battles ("3 grupos, se houver 2 grupos vencedores ganhará"). The server runs turns; before each turn the team can buy group inspirations (skills MasterType 9010/9020/9030, 10 levels). Personal score places the player in one of six categories ("Novato" .. "Grande Mestre"). Rewards: "lágrimas de Athena" (currency 20, "Loja de Athena") per battle and monthly by category (`braveleg.SignUp.RewardTip`).

## Entry points

| Entry | Condition | Code |
|---|---|---|
| Top bar `braveleg` | `thane.grades >= 40 && checkIsRightScene()` | `CM/ui/toptoolbar/TopBtnCheckShowHelper.as:353-354`; click `CM/ui/toptoolbar/TopToolsBar.as:1344-1346` -> `BraveLegManager.requestViewInfo` |
| Controller `braveleg` | navigation id `braveleg` sends 9619 | `CM/yishi/manager/FrameControllerManager.as:1779`; `CM/mvc/controler/BraveLegController.as:31-49` |
| After battle 3861 | reopen the team frame | `CM/battle/handler/BattleResultHandler.as:410-413`; `decompiled/m3/scripts/map/space/SpaceSceneController.as:293-298`; `decompiled/m4/scripts/castle/CastleSceneView.as:172` |
| While in a team | guild and archaeology buttons blocked | `docs/ui/navigation.md` (`BraveLegManager.hasTeam()`) |

## Modules

| Module | File | Content |
|---|---|---|
| Signup and team list | [signup.md](signup.md) | 9619 ops 1, 2, 6, 3 (create/join), invitations 7/9, presumed pushes 379, 377, 380, 382 |
| Team, inspiration and matches | [team.md](team.md) | team frame, ops 4, 5, 10, 11, 12, formation, presumed pushes 378, 383, battle 3861 |
| Categories, ranking and rewards | [ranking.md](ranking.md) | op 8, presumed push 381, groups and rewards |

## Dependencies

| Feature | Why |
|---|---|
| [shops](../shops/catalog.md) | "Loja de Athena" `shop` openType 16, currency 20 |
| [army](../army/README.md) | formation frame uses `ArmySocketOutManager.sendEditArmyPos` |
| [friends](../friends/README.md) | invite list of online players (A) |
| [ares-battle](../ares-battle/README.md), [venus-battle](../venus-battle/README.md) | sibling tournaments |

## Suggested implementation order

0. Decide whether to restore the client listeners (see the critical finding). Without it, stop here.
1. Tables and schedule; op 1 (379), op 2.
2. Team lifecycle ops 3, 4, 5, 6, 7, 9, 11 with pushes 378, 377, 380, 382.
3. Turn loop, inspiration ops 10, 12 (383), battle 3861 with 3 group sub battles.
4. Ranking op 8 (381), rewards.
