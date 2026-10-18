# Chaos battle ("Batalha do Caos", svs): legacy

Module `arena::chaos_battle`. Prefixes as in [README.md](README.md). Controller `CM/mvc/controler/SvsController.as` (SVC), views `CM/svs/view/*`, map UI `M3/map/campaign/view/ui/svsmap/*`, `M3/map/campaign/mediator/svs/SvsUIMediator.as`. Chinese name 服战（混沌之战）.

## 1. Overview

Server vs server war: the top 40 players (level 50+) of each server form the server team ("O jogador mais forte será o líder"; the leader edits the roster within 1 hour before the fight, removing offline players). Servers are grouped; in each round two servers fight in map 5401 (`WorldBossHelper.checkSvs`, `CM/yishi/utils/WorldBossHelper.as:245-248`); dead players do not revive; the team that kills all enemies or has more survivors wins. Preliminary ranking sends ranks 1..16 to "Templo Sagrado" and 17+ to "Templo dos Corajosos". Players earn "pedras do caos" for the chaos shop (`shop` openType 19, "Loja de Caos"), reset 3 days after the event (help `svs.view.SvsFrame.helpContent`). Schedule from `TimerInfoMsg` type 3 and config `PvpTimer` = 20,00,10\|20,15,25\|20,30,40\|20,45,55 (4 fights of the prelim and final).

Reachability in this client: `SvsController` is created and listens to its pushes (SVC:87-96), but no code opens controller `svsmap` except the svs views themselves, and the "show button" push 4755 only sets `model.showSvsBtn` that no toolbar reads. The feature is unreachable from the UI (A: the entry was removed in this build). Protobuf package `pvp` (assigned to this feature) is used only here and by Theseus/Guardian modules.

## 2. Screens

| Class | pt-BR title | Purpose | Data |
|---|---|---|---|
| `svs.view.SvsFrame` / `SvsView` (1000x600) | | group, opponent server, round tabs 1..4 with times, join, shop, roster, ranking, help; state texts "Ainda não agrupou", "Não existe uma rodada atualmente", "Encerrado" | 4756, timer (`CM/svs/view/SvsFrame.as:45-50`; `CM/svs/view/SvsView.as:106-312`) |
| `svs.view.warteam.SvsEnterWarFrame` | Lista de Participantes | roster: "Personagem", "Nível", "Estado de batalha", "Equipe", "Poder de combate" | 4743, 4778 |
| `svs.view.warteam.SvsEnterWarAddFrame` | Lista de Participantes | leader adds online players / removes | 4750 |
| `svs.view.ranklists.SvsRankListFrame` | Templo Sagrado Batalha do Caos | server ranking | 4754 |
| `map.campaign.view.ui.svsmap.SvsCampaignInfoView`, `SvsManageView` | | in-map live counts, "fight now" | 4744 |

## 3. Routes (client to server)

| Opcode | Hex | Name (PTT) | Body | Sender |
|---|---|---|---|---|
| 8864 | 0x22A0 | `C_PVP_USERINFO_REQ` roster request | empty | SVC `sendSvsUserInfoReq` (`:288-292`), from `SvsFrame`, `SvsEnterWarFrame` |
| 25142 | 0x6236 | `C_PVP_USERINFO_STATE_REQ` roster team state | `simple.PropertyMsg{param4: own server name}` | SVC `sendSvsUserInfoStateReq` (`:299-305`), after 4743 |
| 8870 | 0x22A6 | `C_PVP_USERONLIE_REQ` online players | empty | SVC (`:307-311`), `SvsEnterWarAddFrame` |
| 8863 | 0x229F | `C_PVP_USERINFO_EDIT` roster edit | `PvpUserMsg{param1: userId, param3: add (true) / remove (false)}` | SVC `sendSvsUserInfoEdit` (`:313-320`), `SvsEnterWarLeftItem:162`, `SvsEnterWarRightItem:178` |
| 8867 | 0x22A3 | `C_PVP_ENTER` enter the war field | empty | SVC `sendSvsEnter` (`:322-326`), `SvsView` join |
| 8874 | 0x22AA | `C_PVP_LOCALGROUP_REQ` own group | empty | SVC (`:328-332`), `SvsFrame` |
| 8872 | 0x22A8 | `C_PVP_FINALINFO_REQ` ranking | empty | SVC (`:334-338`), `SvsRankListFrame` |
| 8991 | 0x231F | `C_REQ_PVP_FAST_BATTLE` fight now | empty | SVC `sendImmediateWar` (`:340-344`), `SvsManageView:115` |

## 4. Server messages (server to client)

| Opcode | Hex | Name | Body | Receiver |
|---|---|---|---|---|
| 4743 | 0x1287 | `U_C_PVP_USERINFO` | `PvpUserMsg` (`param1` #1, `param2` #2, `param3` #3 BOOL, `pvpInfo` #4 repeated `PvpUserInfoMsg`: `userId` #1, `teamUid` #2, `isExist` #3 BOOL, `hostPlayer` #4 (1 = leader), `job` #5, `fightPower` #6, `isEnterPvp` #7 BOOL, `nickName` #8, `isOnline` #9 BOOL, `grades` #10, `serverName` #11) | SVC `__svsUserInfoHandler` (`:114-147`) |
| 4778 | 0x12AA | `U_C_PVP_USERINFO_STATE` | `team.TeamInfoStateMsg` (`team` #1 repeated `TeamStateMsg`: `userId` #1, `serverName` #2, `isReject` #3) | `:149-175` |
| 4750 | 0x128E | `U_C_PVP_ONLINEPLAYERS` | `PvpUserMsg` | `:177-202` |
| 4744 | 0x1288 | `U_C_PVP_CAMPAIGN_MSG` | `PvpCampaignMsg` (`site1` #1, `teamId1` #2, `liveCount1` #3, `totalCount1` #4, `site2` #5, `teamId2` #6, `liveCount2` #7, `totalCount2` #8); the client swaps sides so own team is side 1 when `teamId1 == 2` | `:204-232` |
| 4755 | 0x1293 | `U_C_PVP_ICON` | none read | `:234-238` (`showSvsBtn = true`) |
| 4756 | 0x1294 | `U_C_PVP_MYGROUP` | `PvpInfoMsg` (`groupId` #17, `teamName` #2 own server, `property1` #21 opponent server, `property2` #22 open date "YYYY-MM-DD hh:mm:ss", `property3` #23 current turn; other fields `teamUid` #1, `site` #3, `ready1..4` #4/#6/#7/#8, `final1..4` #9..#12, `readyScore` #13, `finalScore` #14, `readyOrder` #15, `finalOrder` #16, `serverId` #18, `fightPower` #19, `finalTeam` #20) | `:240-251` |
| 4754 | 0x1292 | `U_C_PVP_FINALINFO` | `PvpMsg` (`eventType` #1, `param1` #2 own order, `param2` #3 own fight power, `param3` #4 BOOL, `pvpInfo` #5 repeated `PvpInfoMsg`: `teamUid`, `teamName`, `finalOrder`, `fightPower`) | `:253-274` |
| 4776 | 0x12A8 | `U_C_PVP_TIMER` | `timer.TimerInfoListMsg` (`timerInfo` #1 repeated `TimerInfoMsg`: `type` #1 (1 league, 3 chaos), `index` #2, `name` #3, `readyOpen` #4, `readyStop` #5, `finalOpen` #6, `finalStop` #7, `param1..3` #8..#10, `signupTime` #11) | `BaseManager.__pvpTimerHandler` (`CM/yishi/manager/BaseManager.as:334,974-990`); type 1 belongs to [league](../league/README.md) |

Note: PTT names these "服战（混沌之战）"; 4776 is shared with the league feature.

## 5. Rules and formulas

From help text: top 40, level 50 (help says 50, the add frame help says 40), leader = strongest, roster lock 1 hour before, no revive, ranks 1..16 vs 17+, chaos stones reset 3 days after. Timer: prelim and final dates from `TimerInfoMsg` type 3; final stop + 4 days (345600000 ms) is the last date (`CM/mvc/module/multilords/MultilordsModel.as:189-204` uses the same shape).

## 6. Templates

`TPL/ConfigInfos.xml` `PvpTimer`; chaos shop 19 ([../shops/catalog.md](../shops/catalog.md)).

## 7. Persistent state

Not proposed: unreachable feature.

## 8. Backend implementation notes

- Send 4776 with only the entries the client needs (type 1 for the league).
- Do not send 4743..4756 unless an entry point is restored.

## 9. Open questions and assumptions

- (A) Unreachable in this build; the button may have been driven by a top bar template that no longer exists.

## 10. Implementation checklist

- [ ] Confirm no entry point (top bar templates, NPC options) opens `svsmap`
- [ ] 4776 shared with league
