# League and alliance ("Liga e aliança")

Feature slug `league`, domain pvp. The registry groups two unrelated systems that both use the pt-BR word "Aliança":

1. **"Batalha de Ferro" / "Liga"** (client package `steel`, protobuf package `steel`). Cross-server team war: a player founds an "Aliança" (team of up to 20 players) for 1 000 000 gold, recruits members, and the team fights other servers' teams in artillery mode ("modo de Artilharia") on the iron city map 5701. Teams are ranked by wins ("Ranking da Liga").
2. **"Contrato da Aliança"** inside the "Regresso dos Jogadores Antigos" event (protobuf package `allianceregression`, client package `oldplayerreturn`). A returning player ("Ressurgido") binds an alliance contract with up to 3 active players ("Eternalistas"); both sides complete tasks, raise a contract level, unlock privileges and spend event tokens in a shop.

Path aliases used in every module of this folder:

| Alias | File |
|---|---|
| SC | `decompiled/core_module/scripts/mvc/controler/SteelController.as` |
| SM | `decompiled/core_module/scripts/map/campaign/data/SteelModel.as` |
| SV | `decompiled/m11/scripts/steel/view/SteelView.as` |
| SF | `decompiled/m11/scripts/steel/view/SteelFrame.as` |
| SLV | `decompiled/m11/scripts/steel/view/search/SteelSeachLeftView.as` |
| SMF | `decompiled/m11/scripts/steel/view/member/SteelMemberFrame.as` |
| SMI | `decompiled/m11/scripts/steel/view/member/SteelMemberItem.as` |
| SAL | `decompiled/m11/scripts/steel/view/auditing/SteelApplyPlayerList.as` |
| SIF | `decompiled/m11/scripts/steel/view/invite/SteelInviteFrame.as` |
| SRL | `decompiled/m11/scripts/steel/view/ranklists/SteelRankListFrame.as` |
| CSM | `decompiled/m3/scripts/map/campaign/CampaignSocketManger.as` |
| CMC | `decompiled/m3/scripts/map/campaign/CampaignMapController.as` |
| OPRM | `decompiled/core_module/scripts/yishi/manager/OldPlayerReturnManager.as` |
| OPRMOD | `decompiled/core_module/scripts/mvc/module/oldplayerreturn/OldPlayerReturnModel.as` |
| OPR | `decompiled/m11/scripts/oldplayerreturn/` (directory) |

## Entry points

| Entry | Condition | Opens | Module |
|---|---|---|---|
| None for the steel lobby. No HUD button, top bar key or NPC calls `openControllerByInfo("steelmap")` without an `openType`; `SteelModel.showSteelBtn` (4765) is written but never read; `OpenGradesII.STEEL_WAR = 50` is never referenced | unreachable in this build | `steel.SteelFrame` | [steel-lobby.md](steel-lobby.md) |
| Player menu "Nomear Presidente" on a member row (`PlayerMenu` built with `showChangeMastBtn1 = isHostPlayer`, `SMI:206`) | viewer is the team host | sends 8962 op 5 | [steel-teams.md](steel-teams.md) |
| Invitation popup 4763 (queued through `PopFrameCheck`) | any time the server pushes it | confirm dialog | [steel-teams.md](steel-teams.md) |
| Map 5701 (`WorldBossHelper.checkSteel`) | server places the player in the steel campaign | artillery battle map | [steel-battle.md](steel-battle.md) |
| Top bar "Regresso" keys `oldplayerreturn` (TopToolBtnInfos 4027 "回归者") and `oldplayerreturn2` (4028 "永恒者") | `status == 1`, `isOpen or isShopOpen`, and `PlayerType == 1` for key 1, `!= 1` for key 2 (`TopBtnCheckShowHelper.as:421-424`) | `oldplayerreturn.OldPlayerReturnFrame` | [alliance-event.md](alliance-event.md) |

## Modules

| Module | Content |
|---|---|
| [steel-lobby.md](steel-lobby.md) | `SteelFrame` full screen lobby, info request 8962 op 9, 4772 my team and open date, 4765 icon state, 4776 PvP timer, global state |
| [steel-teams.md](steel-teams.md) | Team life cycle on 8962 ops 1, 2, 3, 4, 5, 7, 8, 10, 11, 12, 13, 14 and pushes 4773, 4768, 4767, 4774, 4763: create, list, apply, cancel apply, audit, invite, reply, kick, change host, quit |
| [steel-ranking.md](steel-ranking.md) | "Ranking da Liga": 8962 op 15, 4775 order list; 4771 in battle score detail |
| [steel-battle.md](steel-battle.md) | Enter (8962 op 6), iron city map 5701, node types 191 to 197, door and tower path rules, vehicle protocol reuse, dead routes 25131 and 25133, scoring rules |
| [alliance-event.md](alliance-event.md) | "Regresso dos Jogadores Antigos" event shell: 534 activity info, 535 user data, player types, frame tabs, timing, shared request 9717 and 538 |
| [alliance-contracts.md](alliance-contracts.md) | Ally search, apply, revoke, approve, terminate (9717 ops 2 to 5 and 8; 536, 538), contract levels and rewards (op 6), privileges (`AlliancePrivileges`, `PrivilegeChangeMsg`) |
| [alliance-tasks.md](alliance-tasks.md) | Return tasks, oracle tasks, alliance tasks (op 0), daily and weekly boxes, milestones (op 1), `AllianceActivityTasks`, `AllianceRewardInfos` |
| [alliance-shop.md](alliance-shop.md) | "Loja do Evento": op 7, tokens 208701 / 208702, `AllianceShopInfos`, per contract level limits |

## Dependencies

- [../artillery/README.md](../artillery/README.md): the steel battle runs on the vehicle protocol (`vehicle` package: 4513, 4514, 4517, 4518, 4519, 4520, 4521, 4522, 4474, `VehicleAttackReqMsg`, `VehiclePickPropMsg`) and the "vehicledaimon" vehicle selection frame opened by the lobby "change" button.
- [../campaign/README.md](../campaign/README.md): the steel battle map and the event campaigns use the campaign map engine (125, 21, 127, 128, 5025, 22, 4175); invite hall list 5027 / 4161.
- [../castle/README.md](../castle/README.md): team creation spends 1 000 000 gold.
- [../guild/README.md](../guild/README.md) and [../friends/README.md](../friends/README.md): invite frame tabs read guild members and friends.
- [../chat/README.md](../chat/README.md): quick invite through the small bugle (item 208003, free count) and `pveroomlist` quick invite frame.
- [../returning-players/README.md](../returning-players/README.md): owns the `oldplayerreturn` client package (frames, top bar keys). This folder owns the `allianceregression` protocol it uses; the two must share one implementation.
- [../hero/README.md](../hero/README.md): player info 3 for level, vocation, job transfer stage (`alliance_playerjob`), fight power; privilege effects (stat buffer templates 159101xx, daily activity, campaign EXP).
- [../inventory/README.md](../inventory/README.md) and [../mail/README.md](../mail/README.md): rewards and tokens 208701 / 208702.
- Privilege consumers: Time Vortex (`TimeVortexModel.as:87`), Demon Land (`DemonLandModel.as:71`), Forbidden Boss (`ForbiddenBossFrame.as:387`), Increasingly Road (`IncreasinglyRoadFrame.as:247`).

## Implementation order

1. [alliance-event.md](alliance-event.md): activity window, player classification, 534 / 535 at login. It is reachable in this build, steel is not.
2. [alliance-contracts.md](alliance-contracts.md): search and binding, contract EXP and levels, privileges.
3. [alliance-tasks.md](alliance-tasks.md): task progress hooks in the other features, claims, boxes, milestones.
4. [alliance-shop.md](alliance-shop.md).
5. [steel-teams.md](steel-teams.md) and [steel-lobby.md](steel-lobby.md): team tables and 8962 dispatcher (only needed if an entry point is added).
6. [steel-ranking.md](steel-ranking.md).
7. [steel-battle.md](steel-battle.md): after the artillery engine exists.
