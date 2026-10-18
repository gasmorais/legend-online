# Rooms: create, join, ready, kick, start

Module `rooms` of [campaign](README.md). The PvE room scene (`PVE_ROOM_SCENE`, `room_type 0`) where up to 4 players gather, the owner picks a multiplayer instance, members get ready and the owner starts. Most messages are shared by every room type (PvP 1, vehicle 2, theseus 16, apex 14, glory 15, lords 5/8/9); those modes are owned by their features but must use the same handlers. Cross-server matchmaking is in [cross-match.md](cross-match.md); the hall in [room-list.md](room-list.md).

## 1. Overview

- **Entry.** The server sends **12** `RoomMsg`. `BaseManager.__createRoomHandler` (`CM/yishi/manager/BaseManager.as:295, 2636-2690`) builds a `RoomInfo`, calls `RoomManager.setup` and selects the scene by `room_type`: 0 `PVE_ROOM_SCENE`, 1 `PVP_ROOM_SCENE`, 2 vehicle room list frame, 5 `MULTILORDS_ROOM`, 8 `MATELORDS_ROOM`, 9 `ARESLORDS_ROOM`, 14 `APEX_ROOM`, 15 `GLORY_GAME_SCENE`, 16 `THESE_Double_PVP_SCENE`.
- **Room manager.** `RoomManager.setup` (`CM/managers/RoomManager.as:70-119`) listens to 120 members, 4186 formation, 32 room edit, 28 kick, 4984 cross kick vote, 24 ready, 15 leave, 121 owner, 25 room state, 17 slots, 149 equipment, 4994 cross match.
- **Flow.**

```
S>C 12  RoomMsg                        (enter the scene)
S>C 120 RoomPlayerListMsg              (members, slot = current_room_index)
S>C 17  PlaceStateRspMsg               (4 slots: -1 closed, 0 open, >0 taken)
owner:  C>S 5034 select instance  -> S>C 32 EditRoomRspMsg (to all)
owner:  C>S 8344 password         -> S>C 32
owner:  C>S 5029 open/close slot  -> S>C 17
owner:  C>S 5031 kick             -> S>C 28 (to all)
owner:  C>S 5030 give leadership  -> S>C 121 (to all)
member: C>S 5036 ready/cancel     -> S>C 24 (to all)
owner:  C>S 5037 cancel matching  -> S>C 25 (to all)
any:    C>S 5028 invite           -> S>C 16 (to the invitee)
owner:  C>S 5039 start            -> S>C 125 + 21 + 127 ... (everyone enters the instance)
any:    C>S 5025 leave            -> S>C 15 (to all)
instance end: S>C 134 -> client returns to PVE_ROOM_SCENE (same room)
```

## 2. Screens

| Class (file) | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `RoomControl` + `RoomView` (`CM/mvc/controler/RoomControl.as`, `M9/room/view/pve/RoomView.as`) | none | Room scene | 12 with `room_type 0`; 134 after an instance | back to the hall when `RoomManager.exit` (`RoomControl.as`, `gotoSpaceScene`) |
| `AnteroomView` (`M9/room/view/anteroom/AnteroomView.as`) | none | 4 slots | room view | `RoomPlayerFigure` per slot, counter `count/capacity` |
| `RoomPlayerFigure` (`M9/room/view/anteroom/RoomPlayerFigure.as`) | member name | One slot | anteroom | avatar, level, ready badge, owner badge, closed slot art; owner click on an empty slot toggles open/closed (:619-653); owner double click on a member asks "Expulsar jogador?" (:655-661) |
| `RoomRightView` (`M9/room/view/pve/RoomRightView.as`) | "Sala {id}", "{n}" people | Controls and instance info | room view | selected instance art (`images/InstanceImg/{AreaId}`), difficulty ("Fácil", "Normal", "Difícil", "Pesadelo", "Dificuldade Inferno"), recommended level, best grade ("Avaliação" + D..SSS, `checkOptimizeProfile` :1458-1475), daily entries "{left} / {max}", cross power "Poder necessário inter-servidor: {0}", drop showcase; buttons: select instance, lock (password), invite, formation, ready, cancel, start ("Iniciar"), cross start, quit, gains checkbox "Utilizar a quantidade de ganhos diária" (tip "Se não utilizar a quantidade de ganhos poderá ainda completar a missão mas não será capaz de receber prêmios de campanha"); matching timer when state 2 (:760-775) |
| `InstanceSelectFrame` + `InstanceLeftView` + `InstanceRightView` + `InstanceItem` (`M9/room/view/pve/instance/`) | "Escolha de Mapa" | Owner picks the instance and difficulty | select button or start without a map (`RoomRightView.__selectInstance`, :1410-1418) | areas of `LandId 0`, grades, requirements, weekly/daily notes ("Apenas pode obter ganhos uma vez por semana na roleta da masmorra.") |
| `RoomPasswordFrame` (`M9/yishi/view/RoomPasswordFrame.as`) | "Senha" | Set or clear the password | lock button (`RoomRightView.__lockHandler`, :871-879) | input |
| `RoomInviteFrame` (`M9/room/view/invite/RoomInviteFrame.as`) | "Convidar" | Invite friends or guild members | invite button (`RoomRightView._inviteClick`, :1248-1260), `ArmyManageFrame` | tabs "Guilda" and "Amigo", "Atualizar", "Rápido" (quick invite) |
| `QuickInviteFrame` (`M9/room/view/invite/QuickInviteFrame.as`) | "Convite Rápido" | Broadcast an invitation in chat | "Rápido" | editable text; costs a small bugle 208003 (cross: item SonType 280 / 208025) or a free count |
| `InviteFrame` (`CM/yishi/view/frame/InviteFrame.as`) | "Convite de campanha" | Invitation popup on the invitee | 16 | "{nick} te convida à entrar na sala [{map}]" + remaining bosses; 10 s countdown; gains checkbox |
| `ArmyManageFrame` (`CM/map/campaign/view/frame/ArmyManageFrame.as`) | team | Same room actions inside the instance: invite, change leader, kick, formation | campaign HUD | members |
| `RoomReadyTopView`, `FallGoodsOldView` (`M9/room/view/`) | none | ready banner, drop list | room view | |
| `PVPRoomView`, `PVPRoomRightView`, `PVPAnteroomView`, `PVPRoomPlayerFigure` (`M9/room/view/pvp/`, `.../anteroom/`) | PvP room | Same flow with `room_type 1`, no instance choice (5039 with campaign 0) | 12 with type 1 | [../arena/README.md](../arena/README.md) |

## 3. Routes (client to server)

| # | Action | Sender (file:line) | Client checks | Route | Request fields | Server response |
|---|---|---|---|---|---|---|
| R1 | Select instance (owner) | `InstanceSelectFrame.__confireInstance` (`M9/room/view/pve/instance/InstanceSelectFrame.as:70-75`) -> `RoomSocketOuterManager.updateRoomInfo(roomId, dungeonId, campaignId)` (`M9/room/net/RoomSocketOuterManager.as:66-74`) | owner; `InstanceRightView.__okClick` (:262-312): a map ("Escolha Mapa"), a difficulty ("Dificuldade do Mapa"), owner level >= `MinLevel` ("Nível Insuficiente") | C>S **5034 (0x13aa) U_C_CAMPAIGN_ROOM_EDIT** | `room.RoomReqMsg`: `room_id (#1, INT32)`, `dungeon_id (#2, INT32)` = template `DungeonId`, `campaign_id (#3, INT32)` = `CampaignId` | **32** `EditRoomRspMsg` to all members; **4270** to hall viewers |
| R2 | Set or clear the password (owner) | `RoomRightView.passwordInputBack` (:881-883) -> `RoomSocketOuterManager.sendLockCampaignRoom` (:28-35) | owner, not matching | C>S **8344 (0x2098) C_ROOM_PWDCHANGE** | `room.RoomEditMsg`: `room_id (#1, INT32)`, `room_pwd (#2, STRING)` ("" clears), `room_name (#3, STRING)` unused | **32** with `pass_word`; **4270** (`is_set_password`) |
| R3 | Open or close an empty slot (owner) | `RoomPlayerFigure.__clickHandler` (`M9/room/view/anteroom/RoomPlayerFigure.as:619-653`) -> `RoomSocketOutManager.sendClose(index, open)` (`CM/managers/RoomSocketOutManager.as:69-76`) | owner, slot empty | C>S **5029 (0x13a5) U_C_CAMPAGIN_ROOM_PLACESTATE** | `RoomReqMsg`: `index (#7, INT32)` slot 0..3, `open (#8, BOOL)` = true when the slot was closed (state -1) | **17** `PlaceStateRspMsg` to all; **4270** (`capacity`) |
| R4 | Kick a member (owner) | `RoomPlayerFigure.__doubleClickHandler` (:655-661), `ArmyManageFrame.__kickClickHandler` -> `RoomSocketOutManager.sendKickPlayerAlert` (:28-36) -> confirm "Expulsar jogador?" -> `sendKickingInfo` (:46-53) | owner; target is not the owner | C>S **5031 (0x13a7) U_C_CAMPAIGN_ROOM_KILLPLAYER** | `RoomReqMsg`: `user_id (#5, INT32)`, `name_key (#10, STRING)` = target server name (cross rooms) | **28** `KillPlayerRspMsg` to all including the kicked player |
| R5 | Give leadership | `ArmyManageFrame.__changeClickHandler` (`CM/map/campaign/view/frame/ArmyManageFrame.as:291-307`) -> `RoomSocketOutManager.sendChangeRoomOwner(userId, serverName)` (:19-26) | owner; target is another member; cross: only from the owner server | C>S **5030 (0x13a6) U_C_CAMPAIGN_ROOM_MASTER_CHANGE** | `campaign.CampaignReqMsg`: `para_int1 (#1, INT32)` = new owner id, `para_string1 (#6, STRING)` = server name | **121** `ChangeMasterRspMsg` to all |
| R6 | Ready / cancel ready (member) | `RoomRightView.sendPlayerReady` (:1378-1390) and `_cancelClick` (:1392-1408) -> `RoomSocketOuterManager.sendPlayerState(state, isGet)` (:100-107) | ready checks in `__readyClick` (:1273-1376): map selected ("Mapa não selecionado"); level ("Seu nível é insuficiente"); job transfers ("Você não mudou de profissão, não é possível entrar nesta campanha." etc.); child in battle for child war maps; difficulty 2 needs a grade on difficulty 1 ("Pode entrar depois de completar o modo normal"), difficulty 3 needs difficulty 2 ("Ao completar a dificuldade pesadelo poderá entrar"); Bloody: level inside Min..Max; daily count warning | C>S **5036 (0x13ac) U_C_PLAYER_READY_STATE** | `RoomReqMsg`: `state (#6, INT32)` 1 ready / 0 cancel, `is_get (#14, BOOL)` = gains wanted (`getIsNoGet`, :1130-1235; false when the daily count of the mode is used up) | **24** `PlayerReadyRspMsg` to all |
| R7 | Cancel matching (owner) | `RoomRightView._cancelClick` (:1392-1408) -> `RoomSocketOuterManager.sendRoomState(1)` (:109-115) | owner; room state 2 | C>S **5037 (0x13ad) U_C_ROOM_STATE** | `RoomReqMsg`: `state (#6, INT32)` = 1 | **25** `RoomStateRspMsg{room_state 1}` to all |
| R8 | Invite a player | `InviteItem` / `InviteItemButton` (`M9/room/view/invite/InviteItem.as:150-163`, `InviteItemButton.as:189`) -> `RoomSocketOuterManager.sendRoomInvite(userId)` (:117-123) | target level >= selected campaign `MinLevel` ("Nível insuficiente do jogador"); an empty slot ("Não há espaço livre", `RoomRightView.as:1248-1256`) | C>S **5028 (0x13a4) U_C_CAMPAIGN_ROOM_INVITE** | `RoomReqMsg`: `user_id (#5, INT32)` | **16** `RoomInviteMsg` to the invitee (if online, not refusing, level >= 20, not busy); tip 126 to the inviter otherwise |
| R9 | Accept an invitation | `InviteFrame.__confirmHandler` (`CM/yishi/view/frame/InviteFrame.as:173-250`) -> `RoomListSocketOutManager.addRoomById(roomType, roomId, pwd, isInvite=true, isGet)`; cross: `RoomSocketOutManager.sendInviteOther(roomId, isGet)` (`CM/managers/RoomSocketOutManager.as:88-95`) | 5 s anti flood; daily count warning for type 0 | C>S **5024** (see [room-list.md](room-list.md) L5) or **9557 (0x2555) C_CROSS_INVITE_CHOOSE** | 5024: `room_id`, `password` = `sign_str` from 16, `room_type`, `is_invite` = true, `is_get`; 9557: `RoomReqMsg{room_id (#1), is_get (#14)}` | **12** + **120** |
| R10 | Refuse all invitations toggle | `SocketSendManager.sendRefuseInvite` (`CM/yishi/service/managers/SocketSendManager.as:426-430`), callers `TopToolsBar.as:1220,1248`, `ChatOutputViewII.as:1220,1269`, `GameBoxManager.as:162` | none | C>S **8286 (0x205e) C_ROOM_REFUSE** | no body | **4194 (0x1062) U_C_REFUSEINVITE_REFRESH** `player.RefuseFriendRspMsg{result (#1, BOOL)}` -> `PlayerManager.__uRefuseInvite` (`CM/yishi/manager/PlayerManager.as:152, 469-475`) |
| R11 | Quick invite (chat broadcast) | `QuickInviteFrame.sendQuickInvite` (`M9/room/view/invite/QuickInviteFrame.as:338-360`) -> `SocketSendManager.sendQuickInvite(content, type)` (`CM/yishi/service/managers/SocketSendManager.as:474-481`) | text not empty; chat flood check (`ChatHelper.checkCanSend`, 10 s); bugle item or free count | C>S **8353 (0x20a1) C_CAPTAIN_SPEAK** | `campaign.CaptainSpeakMsg`: `inviteContent (#4, STRING, repeated)` (one parsed message), `type (#5, INT32)` (3 = cross); `cmapaign_name (#1)`, `room_id (#2)`, `is_lock (#3)` not set | chat message with a room link (chat feature; the link triggers 8780, [room-list.md](room-list.md) L6) |
| R12 | Request the formation of the room | `TeamSortFrame` / `MatelordsSortFrame` (`M5/teammanager/TeamSortFrame.as:48-52`) -> `RoomSocketOutManager.sendRequestTeamPos` / `sendRequestCrossTeamPos(serverName)` (:55-67) | formation frame open | C>S **8278 (0x2056) C_CAMPIAGN_ARMYPOS_REQ** (no body) or **25159 (0x6247) CR_FIGHTPOS_REQ** `RoomReqMsg{serverName (#15)}` | | **4186 (0x105a) U_C_CAMPAIGN_ARMYPOS_SEND** `army.ArmyFightPosEditListMsg{armyFightPos (#1, repeated), serverName (#2)}` -> `RoomManager.__requestTeamPosHandler` (:107, 198-204); edits belong to [../army/README.md](../army/README.md) |
| R13 | Start (owner) | `RoomRightView._startClick` (:885-961), `__alertResponse` (:963-973), `startAlertBack` (:1095-1110) -> `RoomSocketOuterManager.sendStartCampaignScene(campaignId, 0, null, isNoGet, isCross)` (:76-98) | owner; no map -> opens the instance frame; `isChildWarCampaign` needs a child in battle; **solo start**: if alone and `EnterNumb > 1` -> "Em {0} requer {1} ou mais pessoas para entrar!" (blocked), else confirm "{0} é bem difícil, sendo mais adequado para desafios em equipe. Quer começar sozinho?"; all members ready (`allPlayerReader`); daily count warning; 3 s anti flood; cross start 2 s anti flood | C>S **5039 (0x13af) U_C_CAMPAIGN_ENTER** | `CampaignReqMsg`: `para_int2 (#2, INT32)` = room `campaignId`; `para_bool1 (#7, BOOL)` = owner gains flag (`getIsNoGet`); `isCross (#9, BOOL)` = cross start ([cross-match.md](cross-match.md)); `para_int1` not set (0) | **125** to every member (`created_type 1`), then 21/127...; cross: **25** state 2 and matching |
| R14 | Leave the room | `RoomRightView._quitClick` (:866-869), `RoomControl.quitRoom`, idle timer `RoomTimeMediator.killSelf` (`CM/mediator/RoomTimeMediator.as`) -> `CampaignSocketOutManager.sendReturnCampaignRoom` (`CM/map/campaign/CampaignSocketOutManager.as:68-82`) | none | C>S **5025 (0x13a1) U_C_CAMPAIGN_ROOM_EXIT** | `RoomExitMsg{msg (#1, STRING)}` "" or "kill self" (idle) | **15** `RoomExitRspMsg` to all; new owner **121** if the owner left; **4270** |
| R15 | Invitable players list (theseus only in this client) | `SocketSendManager.sendRefreshInviteHall` (`CM/yishi/service/managers/SocketSendManager.as:394-398`), caller `M3/theseusdoublepvproom/invite/TheseusTeamInviteFrame.as:253,270` | none | C>S **5027 (0x13a3) U_C_CAMPAIGN_INVITE_PLAYER_LIST** | no body | **4161 (0x1041) U_C_INVITE_PLAYER_LIST** `RoomPlayerListMsg` (also read by `RoomInviteFrame.__getHallListHandler`, `M9/room/view/invite/RoomInviteFrame.as:126, 141-218`) |

## 4. Server messages (server to client)

| Opcode | Message and fields | Receiver | When | Client effect |
|---|---|---|---|---|
| **12 (0x000c) U_C_CAMPAIGN_ROOM_CREATE** | `RoomMsg` (fields in [room-list.md](room-list.md) §4) | `BaseManager.__createRoomHandler` (`CM/yishi/manager/BaseManager.as:2636-2690`) | create (5023) or join (5024/9557) | new `RoomInfo` (`id`, `houseOwnerId`, `mapName`, `campaignId`, `capacity`, `roomType`, `roomState`), scene by type |
| **120 (0x0078) U_C_CAMPAIGN_ROOM_MEMBER** | `RoomPlayerListMsg{state (#1, INT32), roomPlayer (#2, RoomPlayerMsg, repeated)}` | `RoomManager.__roomMemberHandler` (`CM/managers/RoomManager.as:106, 184-196`), `readMember` (:211-373) | after 12 and on any member change | upserts members: slot `current_room_index`, `player_state`, avatar and pet/child/mount fields |
| **17 (0x0011) U_C_CAMPAGIN_ROOM_PLACESTATE** | `PlaceStateRspMsg{placeState (#1, INT32, repeated)}` 4 values: -1 closed, 0 open, other taken | `__roomPlaceStateChangeHandler` (:115, 536-551) | after 12 and on 5029, join, leave | `placesState`; `capacity` = count of values >= 0 (`CM/mvc/module/room/SimpleRoomInfo.as:43-61`) |
| **32 (0x0020) U_C_CAMPAIGN_ROOM_EDIT** | `EditRoomRspMsg{room_id (#1), start_campaign_id (#2), master_id (#3), count (#4), capacity (#5), pass_word (#6, STRING), room_name (#7, STRING)}` | `__updateRoomInfoHandler` (:108, 375-396) | 5034, 8344, capacity changes | updates campaign, owner, count, capacity, password; `ROOM_SELECT_CHANGE`. **Must be `EditRoomRspMsg`, not `RoomMsg`** (tags differ) |
| **24 (0x0018) U_C_PLAYER_READY_STATE** | `PlayerReadyRspMsg{readyState (#1, PlayerReady, repeated)}`; `PlayerReady{player_id (#1, INT32), ready_state (#2, INT32)}`. `protocol/proto.json` lists no field for `PlayerReadyRspMsg`; the tag comes from `CM/com/road/yishi/proto/room/PlayerReadyRspMsg.as:19-45` | `__updateReaderStateHandler` (:111, 442-465) | 5036 | member ready badges; owner start enable |
| **25 (0x0019) U_C_ROOM_STATE** | `RoomStateRspMsg{room_state (#1, INT32)}` | `__updateRoomStateHandler` (:114, 526-534) | matching starts (2), stops (1), game (3) | buttons and matching timer |
| **28 (0x001c) U_C_CAMPAIGN_ROOM_KILLPLAYER** | `KillPlayerRspMsg{room_id (#1), killed_player_id (#2)}` | `__campaingkillOutHandler` (:109, 398-440) | 5031 | kicked self: `returnToSpace({isOpenPveRoomList})` (vehicle room: notification); others: member removed, `roomKillOut` (map army removed) |
| **121 (0x0079) U_C_CAMPAIGN_ROOM_MASTER** | `ChangeMasterRspMsg{room_id (#1), master_id (#2), serverName (#3, STRING), isCross (#4, BOOL)}` | `__updateHouseOwnerHandler` (:113, 496-524) | 5030 or owner left | new owner; cross rooms keep `serverName` |
| **15 (0x000f) U_C_CAMPAIGN_ROOM_EXIT** | `RoomExitRspMsg{player_id (#1), exit_type (#2), param1 (#3)}` | `__returnRoomHandler` (:112, 467-490) | 5025 in a room | member removed; self: `returnToSpace({isOpenPveRoomList:true})` |
| **16 (0x0010) U_C_CAMPAIGN_ROOM_INVITE** | `RoomInviteMsg{room_id (#1), player_id (#2) inviter, nick_name (#3), name (#4) map name, sign_str (#5) password, room_type (#6), temp_id (#7) campaign id, position (#8) 1 = instance already running, userKey (#9), boss_count (#10) -1 not started, isCross (#11, BOOL)}` | `BaseManager.__roomInviteHandler` (`CM/yishi/manager/BaseManager.as:296, 2248-2492`) | 5028 | ignored when busy (battle, vehicle, cross guild, star area, poker, child arena, ecliptic palace, land mine, dream arena matching, chess, secret scenes, theseus pvp, `loginState < 0`, already in a room or campaign except house, campaign over, inviter blacklisted, loading, level < 20 for type 0, another invite open, quiz, sweep, wedding lock, Grupo FB, outyard apply); else `InviteFrame` (10 s) |
| **149 (0x0095) U_C_HERO_BROAD_EQUIPMENT** | `army.HeroEquUpdatedMsg{player_id (#1), arm_str (#2), cloth_str (#3), wing (#4), hat (#5), fashion_arm (#6), fashion_cloth (#7), hide (#8, BOOL), appellId (#9), trans_grade (#10), changeBranch (#11)}` | `RoomManager.__otherHeroInfoChange` (:116, 160-182) | a member changes equipment | avatar refresh |
| 4194 | `RefuseFriendRspMsg{result (#1, BOOL)}` | `PlayerManager.__uRefuseInvite` | 8286 | `playerInfo.refuseInvite` |
| 4161 | `RoomPlayerListMsg` | invite frames | 5027 | invitable list |
| 4186 | `ArmyFightPosEditListMsg` | `RoomManager.__requestTeamPosHandler` | 8278/25159 | `roomInfo.armyFightPos` |
| 125, 21, 127 | see [map-session.md](map-session.md) | | 5039 | members enter the instance together |
| 126 | `CampaignNotifyMsg{id 2, body}` | | any refusal | tip |

`RoomPlayerMsg` (120, 21, 11, 4161), every field: `room_id (#1)`, `count (#2)`, `current_room_index (#3)` slot, `player_state (#4)` 0 waiting / 1 ready / 2 owner (`RoomPlayerState`), `hero_id (#5)`, `player_id (#6)`, `grades (#7)`, `nick_name (#8)`, `sex (#9)`, `template_id (#10)`, `arm (#11)`, `cloth (#12)`, `army_id (#13)`, `fighting_capacity (#14)`, `cur_pos_x (#15)`, `cur_pos_y (#16)` (cells, instance only), `campaign_id (#17)` (map id), `online_state (#18, BOOL)`, `consortia_id (#19)`, `consortia_name (#20)`, `change_shapeId (#21)`, `army_state (#22)`, `team_id (#23)`, `buffer_tempId (#24)`, `geste (#25)`, `head_id (#26)`, `is_vip (#27, BOOL)`, `vip_type (#28)`, `mount_tempId (#29)`, `mount_grade (#30)`, `wing (#31)`, `server_name (#32)`, `hat (#33)`, `fashion_arm (#34)`, `fashion_cloth (#35)`, `hide (#36, BOOL)`, `appellid (#37)`, `vehicleTemplateId (#38)`, `fate_skills (#39)`, `petTemplateId (#40)`, `pet_quqlity (#41)`, `pet_name (#42)`, `isNoGet (#43, BOOL)`, `dragon_grade (#44, STRING "type,grade,gp\|...")`, `transfer_grade (#45)`, `rank (#46)`, `group_type (#47)`, `is_back_player (#48, BOOL)`, `child_job (#49)`, `child_name (#50)`, `child_sex (#51)`, `child_fightcap (#52)`, `growth_grade (#53)`, `change_branch (#54)`, `player_uuid (#55)`, `monster_id (#56)`, `avenger_grade (#57)`, `growth_grade2 (#58)`, `theseusMultiPvpRankName (#59)`, `theseusMultiPvpIntegral (#60)`.

`RoomReqMsg`, every field: `room_id (#1)`, `dungeon_id (#2)`, `campaign_id (#3)`, `army_id (#4)`, `user_id (#5)`, `state (#6)`, `index (#7)`, `open (#8, BOOL)`, `room_type (#9)`, `name_key (#10, STRING)`, `password (#11, STRING)`, `is_invite (#12, BOOL)`, `capacity (#13)`, `is_get (#14, BOOL)`, `serverName (#15, STRING)`.

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Slots | 4 (`placesState = [0,0,0,0]`) | `CM/mvc/module/room/SimpleRoomInfo.as:35` |
| Room state | 0 unused, 1 waiting, 2 matching, 3 in game | `RoomState.as` |
| Member state | 0 waiting, 1 ready, 2 owner; start allowed when every non owner member is not 0 | `RoomInfo.allPlayerReader` (`CM/mvc/module/room/RoomInfo.as:201-211`) |
| Minimum players | `Campaigns.EnterNumb` (e.g. 1 for 4202); alone with `EnterNumb <= 1` needs a confirmation | `RoomRightView.as:926-946` |
| Difficulty chain | difficulty 2 needs a grade on difficulty 1 of the same area; 3 needs 2 (members only; the owner is not checked client side) | `RoomRightView.as:1350-1370` |
| Job requirements | `NeedTransfer` (job transfer), `NeedChangeJob`, `NeedThirdTransfer` (avenger), `NeedFourTransfer`/`NeedTransferType 4` (holy) | `RoomRightView.as:1294-1318` |
| Gains flag | checkbox "Utilizar a quantidade de ganhos diária"; forced false when the mode's daily count is 0: `multiCopyCount` (default, ConfigInfos `MultiCampaign_MaxCount` 1), trial tower, Bloody (`Random_Boss_Count` 1), Molong, NaLan, Taila, Waste, Fantasy Matrix, child war, sacristy, spacetime, dungeon turn (weekly), deep prison, dark king, race against time, forest, sky step. Cannot be toggled while ready or matching | `RoomRightView.as:521-543, 1130-1235` |
| Energy | `MultiCampaign_Weary` = 20 per run *(assumption: charged only when gains are on)* | ConfigInfos |
| Idle kick (client side) | alone 5 min; owner with all ready 1 min; owner waiting 20 min; members never; any mouse click resets; on expiry the client sends 5025 "kill self" | `CM/mediator/RoomTimeMediator.as` |
| Invite eligibility | invitee level >= 20 for type 0, and the many busy checks listed in 16 | `BaseManager.as:2248-2400` |
| Invitation timeout | 10 s popup | `BaseManager.as:2480-2490` |
| Owner leave | the next member becomes owner (121) *(assumption: lowest slot)* | |
| Anti flood | 5024/5023 5 s; 5039 3 s | `RoomListSocketOutManager.as`, `RoomSocketOuterManager.as:76-87` |

## 6. Templates

| File | Use |
|---|---|
| `Campaigns.xml` (`LandId 0`, `Capacity 4`) | instance list: `CampaignId`, `DungeonId` (1 normal multiplayer, 3 activities, 4 weekly, 999 special), `AreaId`, `DifficultyGrade` 1..3, `MinLevel`, `MaxLevel`, `EnterNumb`, `NeedFightPower` (cross), job flags, `SonTypes` (activity kind: 301 trial tower, 305 fantasy matrix, 306 spacetime, 307 dungeon turn, 308 dark king, 309 race against time, 310 forest, 400 special areas), `Item` |
| `ConfigInfos.xml` | `MultiCampaign_Weary` 20, `MultiCampaign_MaxCount` 1, `Random_Boss_Count` 1, `Multi_Match` "00:00,23:59" |

## 7. Persistent state (schema `campaign`)

Rooms are live objects; persist them only to survive a restart and for audit.

```sql
CREATE TABLE campaign.room (
  room_id      integer  PRIMARY KEY,
  room_type    smallint NOT NULL CHECK (room_type >= 0),
  owner_player_id BIGINT NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  campaign_id  integer  NOT NULL DEFAULT 0,
  dungeon_id   integer  NOT NULL DEFAULT 0,
  password     text     NOT NULL DEFAULT '',
  room_state   smallint NOT NULL DEFAULT 1 CHECK (room_state BETWEEN 0 AND 3),
  is_cross     boolean  NOT NULL DEFAULT false,
  created_at   timestamptz NOT NULL DEFAULT now()
);
CREATE INDEX room_listing ON campaign.room (room_type, room_state, campaign_id);

CREATE TABLE campaign.room_slot (
  room_id     integer  NOT NULL REFERENCES campaign.room(room_id) ON DELETE CASCADE,
  slot_index  smallint NOT NULL CHECK (slot_index BETWEEN 0 AND 3),
  is_closed   boolean  NOT NULL DEFAULT false,
  player_id   BIGINT  REFERENCES player.players(player_id) ON DELETE SET NULL,
  ready_state smallint NOT NULL DEFAULT 0 CHECK (ready_state IN (0, 1, 2)),
  wants_gains boolean  NOT NULL DEFAULT true,
  joined_at   timestamptz,
  PRIMARY KEY (room_id, slot_index),
  CHECK (NOT (is_closed AND player_id IS NOT NULL))
);
CREATE UNIQUE INDEX room_slot_player ON campaign.room_slot (player_id) WHERE player_id IS NOT NULL;

CREATE TABLE campaign.room_invitation (
  room_id        integer NOT NULL REFERENCES campaign.room(room_id) ON DELETE CASCADE,
  invitee_id     integer NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  inviter_id     integer NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  expires_at     timestamptz NOT NULL,
  PRIMARY KEY (room_id, invitee_id)
);

CREATE TABLE campaign.player_invite_setting (
  player_id      BIGINT PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
  refuse_invites boolean NOT NULL DEFAULT false
);

CREATE TABLE campaign.daily_entry (
  player_id   BIGINT  NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  mode        text     NOT NULL,
  period_start date    NOT NULL,
  used_count  smallint NOT NULL DEFAULT 0 CHECK (used_count >= 0),
  PRIMARY KEY (player_id, mode, period_start)
);
```

`campaign.daily_entry.mode` values: `multi_copy`, `trial_tower`, `bloody`, `molong`, `nalan`, `taila`, `waste`, `fantasy_matrix`, `child_war`, `sacristy`, `spacetime`, `dungeon_turn` (weekly period), `deep_prison`, `dark_king`, `race_against_time`, `forest`, `sky_step`. The counts are sent to the client in player info (hero feature).

## 8. Backend implementation notes

One actor per room serializes every room opcode. All members receive every push.

| Handler | Opcode | Validation order | Effects |
|---|---|---|---|
| `campaign::rooms::handle_select_instance` | 5034 | owner; state 1; template `LandId 0`, `Capacity > 1`; `campaign_id` belongs to `dungeon_id`; owner level >= `MinLevel` | set campaign; reset non owner ready states to 0 *(assumption)*; 32 to all, 24, 4270 |
| `campaign::rooms::handle_password` | 8344 | owner; state 1 | set password; 32 to all; 4270 |
| `campaign::rooms::handle_slot` | 5029 | owner; slot empty | toggle `is_closed`; 17 to all; 4270 |
| `campaign::rooms::handle_kick` | 5031 | owner; target member, not self | remove; 28 to all (including the kicked player); 17; 4270 |
| `campaign::rooms::handle_change_owner` | 5030 | owner; target member | swap owner (`player_state` 2 to the new owner, 0 to the old); 121 to all; 120 |
| `campaign::rooms::handle_ready` | 5036 | member, not owner; state 1; for ready: campaign selected, level, job flags, difficulty chain (grade table) | set ready and `wants_gains = is_get`; 24 to all |
| `campaign::rooms::handle_room_state` | 5037 | owner; state 2 | cancel matching ([cross-match.md](cross-match.md)); 25 `{1}` to all |
| `campaign::rooms::handle_invite` | 5028 | inviter in the room; free slot; invitee online, level >= 20, `refuse_invites` false, not busy | store invitation (10 s *(assumption: 30 s server side)*); 16 to the invitee |
| `campaign::rooms::handle_cross_invite_choose` | 9557 | pending cross invitation | join the cross room ([cross-match.md](cross-match.md)) |
| `campaign::rooms::handle_refuse_toggle` | 8286 | none | flip `refuse_invites`; 4194 |
| `campaign::rooms::handle_start` | 5039 with room | owner; campaign selected; `isCross` false: every member ready, member count >= `EnterNumb`; Energy and daily counts per member decide `has_gains` (never block) | room state 3; `campaign::map_session::create_instance` with all members; 125 to all, 21, 127 |
| `campaign::rooms::handle_leave` | 5025 in a room | member | remove; 15 to all; owner left: next owner, 121; empty: delete room; 4270 |
| `campaign::rooms::on_instance_end` | after 134 | | room state 1, ready states 0, 120 and 25 to all *(assumption)* |

- Daily counts: increment `campaign.daily_entry` at start for members with gains; push the hero player info update.
- Quick invite 8353 is a chat message (chat feature) with a room link; the server stamps `room_id`, `campaign name` and lock state.
- Existing mock flows in `server/flows.json` answer 5034 with code 32 carrying a `RoomMsg`; the client decodes 32 as `EditRoomRspMsg`, so the real handler must encode `EditRoomRspMsg`.

## 9. Open questions and assumptions

1. Owner succession order when the owner leaves.
2. Whether a server side idle kick existed (the client kicks itself).
3. Whether 5034 resets ready states.
4. Exact invitation expiry on the server.
5. Energy charging rules for team runs with gains off.

## 10. Implementation checklist

- [ ] Screens check: `RoomView`, `AnteroomView`, `RoomPlayerFigure`, `RoomRightView`, `InstanceSelectFrame`, `RoomPasswordFrame`, `RoomInviteFrame`, `QuickInviteFrame`, `InviteFrame`, `ArmyManageFrame`
- [ ] Room actor and registry
- [ ] Encoders: 12, 120 (`RoomPlayerMsg` full), 17, 32 (`EditRoomRspMsg`), 24 (`readyState` tag 1), 25, 28, 121, 15, 16, 149, 4194, 4161, 4186
- [ ] Routes: 5034, 8344, 5029, 5031, 5030, 5036, 5037, 5028, 9557, 8286, 8353 (chat), 8278/25159, 5039, 5025, 5027
- [ ] Rules: ready validation (level, job, difficulty chain), `EnterNumb`, gains flag, daily counts
- [ ] Tables `room`, `room_slot`, `room_invitation`, `player_invite_setting`, `daily_entry`
- [ ] Return to the room after 134
- [ ] Test: owner selects 2351, member readies (24), owner starts (125 to both), finish (134) brings both back to the room
- [ ] Test: kick (28) sends the kicked player to the hall
