# Titan battle ("Batalha de Titãns", multilords): legacy

Module `venus_battle::multilords`. Prefixes as in [README.md](README.md).

## 1. Overview

`multilords` (Chinese 多人众神之战, players call it "Batalha de Titãns", battle type 308 `MULTILORDS`, `docs/battle/rules.md`) is the predecessor of the Venus battle: a cross server team tournament with signup, preliminary rounds, a final, betting ("Aposta da Alegria"), worship of the winners and a shop. In this client only fragments remain:

- Model `CM/mvc/module/multilords/MultilordsModel.as` (processes, bet limits, inspiration costs, timer parsing), `MultilordsPlayerInfo`, `MultilordsReportInfo`.
- Controller `CM/mvc/controler/MultilordsController.as` (frames `multilords.MultilordsFrame`, `MultilordsBetFrame`, `MultilordsBetSelectFrame`, `MultilordsWinPrizesFrame`, `MultilordsCheckRewardFrame`, `MultilordsRankFrame`, `MultilordsPrelimReportFrame`, `MultilordsFinalReportFrame`, `MultilordsWorshipFrame`, `MultilordsBattleViewFrame`), **not registered** in `FrameControllerManager`.
- Scene `MULTILORDS_ROOM` (`CM/mvc/controler/MultilordsRoomController.as`, `CM/yishi/scene/SceneCreate.as:60`), entered when 12 carries `roomType 5` (`CM/yishi/manager/BaseManager.as`; `CM/managers/RoomManager.as` preScene) and left with 5025 (`CM/ui/maintoolbar/MainToolBar.as:1621-1625,1868-1874`, "Deseja sair..." `ui.maintoolbar.MainToolBar.exitMultilordsRoom`).
- Assets `web/public/lib/multilords`, `web/public/lib/multilordsroom` exist; the frame scripts (`multilords.*`) are **absent** from `decompiled/`, and no manager sends any multilords opcode.

Conclusion: not reachable from the UI. Implement only the room exit path (shared with campaign rooms) and keep the protocol below for completeness.

## 2. Screens

None reachable (frame classes missing). Room scene `MULTILORDS_ROOM` exists but its view `multilordsroom.MultilordsRoomView` has no script.

## 3. Routes (client to server)

No client sender exists. Opcodes from PTT:1359-1369 (bodies unknown, no protobuf classes in `com.road.yishi.proto` for them):

| Opcode | Hex | Name | Meaning (PTT) |
|---|---|---|---|
| 8841 | 0x2289 | `C_MUTIL_LORDS_FINALORDER_REQUEST` | final list request |
| 8842 | 0x228A | `C_MUTIL_LORDS_BET` | bet |
| 8844 | 0x228C | `C_MUTIL_LORDS_SIGNUP` | signup |
| 8849 | 0x2291 | `C_MUTIL_LORDS_ROOMCREATE` | create and enter room |
| 8851 | 0x2293 | `C_MULTILORDS_SIGN_RECIVE` | accept or cancel signup |
| 8852 | 0x2294 | `C_MULTILORDS_INSPIRE` | inspiration |
| 8853 | 0x2295 | `C_MULTILORDS_MAININFO` | main panel |
| 8854 | 0x2296 | `C_MULTILORDS_LOCAL_FINAL` | local final list |
| 8855 | 0x2297 | `C_MULTILORDS_BETWIN_REQ` | bet winners |
| 8856 | 0x2298 | `C_MULTILORDS_WORSHIP` | worship |

## 4. Server messages (server to client)

No client receiver. PTT:558-564, 675: 4716 `U_C_MULTILORDS_INFO`, 4719 `U_C_MULTILORDS_OPENSTATE`, 4724 `U_C_MULTILORDS_FINALORDER`, 4730 `U_C_MULTILORDS_SIGN_NOTIC`, 4731 `U_C_MULTILORDS_MAININFO`, 4733 `U_C_MULTILORDS_LOCAL_FINAL`, 4734 `U_C_MULTILORDS_BET_LIST`, 4806 `U_C_MULTI_LORDS_FIANL_ORDER`. The server must never send them to this client.

## 5. Rules and formulas (from the model, for reference)

| Rule | Value | Source |
|---|---|---|
| Open level / bet level | 50 / 35 | `MultilordsModel.as:17-19` |
| Processes | 0 READY, 1 PRELIM, 2 FINAL, 3 BET, 4 OVER, 5 APPLY | `:21-31` |
| Bet range | 600..5000 (25000 second cap), win rate 1.5x..20x, fail rate 1x | `:49-59`; LANG `matelords.MatelordsBetFrame.helpContent` |
| Inspiration cost by level 0..9 | 200, 400, 600, 800, 1200, 1800, 2600, 3600, 4800, 6200 | `:206-243` |
| Final dividing rank | 16 | `:61` |
| Schedule config | `PvpTimer` = 20,00,10\|20,15,25\|20,30,40\|20,45,55 "【混沌之战】初赛/决赛4场战斗时间"; `Multi_Lords_BetOrder` = 6 | `TPL/ConfigInfos.xml` |

## 6. Templates

Multilords shop templates are loaded into `TempleteManager._multilordsShopTemplateDic` (`CM/yishi/manager/TempleteManager.as:1659-1667,2626`); owned by [shops](../shops/README.md).

## 7. Persistent state

None.

## 8. Backend implementation notes

- Treat `roomType 5` as unused. If a 8841..8856 packet ever arrives, ignore it.

## 9. Open questions and assumptions

- (A) The frame scripts may exist in another client build; if recovered, map them before implementing.

## 10. Implementation checklist

- [ ] Confirm no server rule emits 4716..4734 or 4806
- [ ] Room type 5 not created
