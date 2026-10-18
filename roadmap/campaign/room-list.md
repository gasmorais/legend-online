# PvE room list ("Salão de Campanhas")

Module `room-list` of [campaign](README.md). The hall where players browse, search, create and join team instance rooms (`room_type 0`). The room itself is in [rooms.md](rooms.md).

## 1. Overview

- Controller `PVERoomListControler` (`CM/mvc/controler/PVERoomListControler.as`), module key `pveroomlist`, model `PVERoomListModel` (`CM/mvc/module/pveroomlist/PVERoomListModel.as`). The same controller also opens the room invite frame (`openType 1`, `room.RoomInviteFrame`) and the quick invite frame (`openType 2`, `invite.QuickInviteFrame`) (:186-197).
- On the first start it requests the list (**5026**) with the filter `searchId` (0 = all) (:151-165, 128-131). It listens to **13** (full list), **4270** (one room changed) and **4370** (search result) while open (:30-41).
- The left panel lists players waiting in the hall (opcode **11** pushes kept in `PlayerManager.watingList`, level >= 20 only).
- Creating a room sends **5023** `{capacity 1, room_type 0, password ""}`; joining sends **8465** (room lookup) then **5024**. The server answers a successful create or join with **12** and the client switches to `PVE_ROOM_SCENE` ([rooms.md](rooms.md)).
- `TheseusRoomListControler` and `PVPRoomListControler` use the same opcodes with `room_type 16` and `1` (theseus-arena and arena features).

## 2. Screens

| Class (file) | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `PVERoomListFrame` (`M9/pveroomlist/PVERoomListFrame.as`) | "Salão de Campanhas" (`pveroomlist.PVERoomListFrame.title`, :51) | Hall | NPC "Tina, Portal dos Heróis" option type 2 (`M3/map/space/helper/hero/SpaceArmyViewHelper.as:181-190`), `returnToSpace({isOpenPveRoomList:true})` (`M3/map/space/SpaceSceneController.as:244-247`), castle (`M4/castle/CastleSceneView.as:121`), top bar (`CM/ui/toptoolbar/TopToolsBar.as:1391`), activity box (`CM/ui/toptoolbar/view/TimeActiveBoxView.as:129`) | two panels below |
| `PVERoomListView` (`M9/pveroomlist/view/PVERoomListView.as`) | combobox "Todos os mapas" | Room grid | frame | 6 `PVERoomItem` slots (:93-101); combobox of multiplayer campaigns "Name(Nv.min-max)", activity campaigns with the suffix "public.Activity", weekly campaigns (:103-200; `CampaignTemplateManager.getMutiCampaignList/getActiveCampaignList/getWeekCampaignList`, `CM/yishi/manager/CampaignTemplateManager.as:184-233, 337-354`); prev, next and refresh buttons all re-request the list (:202-206) |
| `PVERoomItem` (`M9/pveroomlist/view/PVERoomItem.as`) | "No. {id}" | One room | grid | lock icon (`is_set_password`), "{count} / {capacity}", campaign name and difficulty, requirement line ("Nv.{0}-{1}", "Nv.{0}", "Avanço da Profissão", "Profissão Cavaleiro", "Classe Divindade", "Classe Consagrada"), state text (:175-260) |
| `PVEPlayerListView` + `PVEPlayerListItem` (`M9/pveroomlist/view/PVEPlayerListView.as`) | waiting players | Players in the hall, self first, sorted by VIP, transfer grade, level (:119-137); buttons "Criar" and "Procurar" | frame | name, level, VIP; click opens `PlayerMenu` (friend, chat, info) |
| `PVERoomSearchFrame` (`M9/pveroomlist/view/PVERoomSearchFrame.as`) | "Procurar Sala" | Find a room by id | "Procurar" | "ID da Sala", optional "Senha" checkbox (the password is typed but **not sent**, :152-187) |
| `RoomPasswordFrame` (`M9/yishi/view/RoomPasswordFrame.as`) | "Senha" | Ask the password | 4370 with a locked room | password input |

## 3. Routes (client to server)

| # | Action | Sender (file:line) | Client checks | Route | Request fields | Server response |
|---|---|---|---|---|---|---|
| L1 | Open the hall, refresh, prev, next, change filter | `PVERoomListControler.requestRoomInfo` (`CM/mvc/controler/PVERoomListControler.as:128-131`) -> `RoomListSocketOutManager.requestRoomList(roomType, nameKey)` (`CM/yishi/manager/RoomListSocketOutManager.as:22-29`); filter change `PVERoomListView.__selectedCampaignChange` (:229-234) shows "Procura Concluída" | none | C>S **5026 (0x13a2) U_C_CAMPAIGN_ROOM_LIST** | `room.RoomReqMsg`: `room_type (#9, INT32)` = 0; `name_key (#10, STRING)` = campaign id filter as text ("0" = all) | **13** `RoomListRspMsg` |
| L2 | Create a room | `PVEPlayerListView.__createRoomHandler` (`M9/pveroomlist/view/PVEPlayerListView.as:180-196`) -> `PVERoomListControler.sendCreateRoom` (:133-136) -> `RoomListSocketOutManager.sendCreateRoom(1, 0, "")` (:58-72) | 3 s button debounce; `WorldBossHelper.getCampaignTips()` empty (not in planes war, cross guild war, outyard apply, sandbox, crisis, shooting room, secret adventure..., `CM/yishi/utils/WorldBossHelper.as:334-380`); 5 s anti flood shared with join ("Clique excessivo, tente novamente") | C>S **5023 (0x139f) U_C_CAMPAIGN_ROOM_CREATE** | `RoomReqMsg`: `capacity (#13, INT32)` = 1, `room_type (#9)` = 0, `password (#11, STRING)` = "" | **12** `RoomMsg` (new room, owner = player), **120** members, **17** slots; failure: **126** tip |
| L3 | Click a room | `PVERoomItem.__clickHandler` (`M9/pveroomlist/view/PVERoomItem.as:136-170`) -> `PVERoomListControler.sendSearchRoomInfo(0, id)` -> `RoomListSocketOutManager.sendSearchRoomInfo` (:49-56) | 3 s debounce; `room_state == 1` else the state tip ("Sala não utilizada...", "Sala está combinando...", "Sala em jogo..."); level >= campaign `MinLevel` ("Seu nível é insuficiente") | C>S **8465 (0x2111) U_C_ROOM_FIND** | `RoomReqMsg`: `room_id (#1, INT32)`, `room_type (#9)` = 0 | **4370** `RoomMsg` |
| L4 | Search by id | `PVERoomSearchFrame.sendSearch` (`M9/pveroomlist/view/PVERoomSearchFrame.as:171-187`) | id > 0, else "Sala inexistente" (0) or "Insira ID da Sala" | C>S **8465** | same as L3 | **4370** |
| L5 | Join after 4370 | `PVERoomListControler.__searchRoomHandler` (:44-72) -> `sendEnterRoom(0, id, pwd, false)` (:138-144) -> `RoomListSocketOutManager.addRoomById` (:31-47); locked rooms first ask the password (`RoomPasswordFrame` callback `inviteBackCall`) | 5 s anti flood | C>S **5024 (0x13a0) U_C_CAMPAIGN_ROOM_ENTER** | `RoomReqMsg`: `room_id (#1)`, `password (#11, STRING)`, `room_type (#9)` = 0, `is_invite (#12, BOOL)` = false, `is_get (#14, BOOL)` = false | **12** to the joiner, **120** to every member, **4270** to hall viewers; failure **126** |
| L6 | Join from a chat room link | `ChatOutputViewII` link click (`CM/chat/view/ChatOutputViewII.as:884`) -> `RoomListSocketOutManager.sendSearchRoomState(roomId)` (:86-92) | none | C>S **8780 (0x224c) C_MULITY_CAMPAIGN_REQUEST** | `simple.PropertyMsg{param1 (#1, INT32) = room id}` | **4913**; then the confirm sends 5024 with `is_invite = true`, `is_get = !income` (`CM/yishi/manager/BaseManager.as:1124-1153`) |
| L7 | Quick start (vehicle hall only) | `RoomListSocketOutManager.quickStart` / `cancelQuickStart` (:74-84) | n/a | 8608 / 8609 | none | artillery feature |

## 4. Server messages (server to client)

| Opcode | Message and fields | Receiver | When | Client effect |
|---|---|---|---|---|
| **13 (0x000d) U_C_CAMPAIGN_ROOM_LIST** | `RoomListRspMsg{room (#1, RoomMsg, repeated)}` | `PVERoomListControler.__roomListHandler` (:74-103) | reply to 5026 | replaces the list; fills the 6 slots in order (extra rooms are not shown) |
| **4270 (0x10ae) U_C_ROOM_SEND** | `RoomMsg` | `__updateRoomHandler` (:105-126) | a listed room changes (count, state, map, lock) | updates the slot; when `capacity == 0` or state 2/3 it re-requests the list |
| **4370 (0x1112) U_C_ROOM_FIND_RESULT** | `RoomMsg` | `__searchRoomHandler` (:44-72) | reply to 8465 | updates the cached room; `is_set_password` -> password frame, else 5024 |
| **11 (0x000b) U_C_CAMPAIGN_WAITING_PLAYER_LIST** | `RoomPlayerListMsg{state (#1, INT32) 1 add / else remove, roomPlayer (#2, RoomPlayerMsg, repeated)}`; reads `player_id`, `template_id`, `grades`, `nick_name`, `sex`, `consortia_id`, `change_shapeId`, `is_vip`, `vip_type`, `transfer_grade`, `change_branch`, `is_back_player`, `consortia_name`, `fighting_capacity` | `PlayerManager.__playerListHandler` (`CM/yishi/manager/PlayerManager.as:158, 1262-1302`) | players enter or leave the hall | `watingList` add/remove; the view shows level >= 20 only |
| **4913 (0x1331) U_C_MULITY_CAMPAIGN_REQUEST** | `simple.PropertyMsg`: `param1 (#1)` room id, `param2 (#2)` campaign id (optional), `param6 (#6, STRING)` remaining bosses ("-1" = not started), `param7 (#7, BOOL)` room already in the campaign | `BaseManager.__mulityCampaignRequestHandler` (`CM/yishi/manager/BaseManager.as:327, 1156-1218`) | reply to 8780 | "Entrar no Mapa Multiplayer [{0}] da sala [{1}]?" + "Número de Chefão restantes: {0}" or "A campanha ainda não começou"; a second confirm "A Campanha já está aberta, deseja entrar?" when `param7` |
| 126 | `CampaignNotifyMsg{id 2, body}` | `BaseManager.__msgHandler` | refusals (room full, wrong password, unknown room, level) | floating tip |

`RoomMsg`, every field: `room_id (#1, INT32)`; `campaignId (#2, INT32)` selected campaign (0 = none); `master_id (#3, INT32)`; `name (#4, STRING)` map name text; `count (#5, INT32)` members; `capacity (#6, INT32)` open slots; `room_state (#7, INT32)` 0 unused, 1 waiting, 2 matching, 3 in game (`CM/yishi/datas/consant/RoomState.as`); `room_type (#8, INT32)` (0 PvE, 1 PvP, 2 vehicle, 3 Molong/rapid through, 4 wedding, 5 multi lords, 6 PvP campaign, 7 Grupo FB, 8 mate lords, 9 ares lords, 13 sandbox, 14 apex, 15 glory, 16 theseus, 100 farm bonfire; `RoomType.as`); `is_set_password (#9, BOOL)`; `masterServerName (#10, STRING)`; `masterName (#11, STRING)`; `masterScore (#12, INT32)`.

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Hall unlock | NPC option level (20); quest shortcut needs level 20 ("Mapa Multiplayer não está aberto!") | `SwitchPageHelp.as:1101-1110`; `OpenGradesII.PVE = 20` |
| Waiting list filter | level >= 20 | `PVEPlayerListView.as:129, 142` |
| Slots per page | 6, no paging field in 5026: prev/next/refresh only resend 5026. The server should rotate or randomize the 6 rooms *(assumption)* | `PVERoomListView.as:93-101, 202-206` |
| Joinable room | state 1 (waiting) | `PVERoomItem.as:150-153` |
| Anti flood | create/join 5 s (`RoomListSocketOutManager._intervalTime`), button debounce 3 s | `RoomListSocketOutManager.as:33-38, 60-64` |
| Default capacity on create | 1 in the request; real capacity comes back in 12/32 (4 for PvE) | `PVERoomListControler.as:133-136`; `docs/world/README.md` §4.3 |

## 6. Templates

| File | Use |
|---|---|
| `Campaigns.xml` | filter combobox: `LandId 0` chapters except 0, 3, 4 (multiplayer), chapter 3 (activities, area 304 lists every difficulty), chapter 4 (weekly); `AreaId 402` hidden unless `VersionSwitchInfo.WEEK_CAMPAIGN`; sorted by `MinLevel`. Room item: `CampaignName`, `MinLevel`, `MaxLevel`, `DifficultyGrade`, transfer flags |

## 7. Persistent state (schema `campaign`)

The hall state is volatile (in memory): rooms, hall viewers, waiting players. Rooms are persisted for crash recovery only, see `campaign.room` in [rooms.md](rooms.md).

```sql
CREATE TABLE campaign.hall_presence (
  player_id  integer PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
  room_type  smallint NOT NULL DEFAULT 0,
  filter_campaign_id integer NOT NULL DEFAULT 0,
  entered_at timestamptz NOT NULL DEFAULT now()
);
```

## 8. Backend implementation notes

| Handler | Opcode | Validation order | Effects |
|---|---|---|---|
| `campaign::room_list::handle_list` | 5026 | none | register the player as a hall viewer of `room_type` with filter `int(name_key)`; reply 13 with up to 6 rooms (state 1 first *(assumption)*); first call also pushes 11 (state 1) with the current waiting players and broadcasts 11 add of this player to other viewers *(assumption)* |
| `campaign::room_list::handle_create` | 5023 | (1) not in a room, instance or battle; (2) level >= 20 for type 0; (3) `room_type` known | allocate `room_id`, owner = player, capacity 4 for type 0; send 12, 120, 17; push 4270 to hall viewers; remove the player from the waiting list (11 remove) |
| `campaign::room_list::handle_find` | 8465 | room exists and `room_type` matches | reply 4370 with the room; unknown -> 126 "Sala inexistente" |
| `campaign::room_list::handle_join` | 5024 | (1) not in a room; (2) room exists, state 1, free slot (`placesState` 0); (3) password matches unless `is_invite` from a valid invitation; (4) level >= campaign `MinLevel` when a campaign is selected | add member at the first open slot, store `is_get` as gains flag; send 12 to the joiner, 120 to all, 17 if slots changed, 4270 to viewers |
| `campaign::room_list::handle_room_state_query` | 8780 | room exists | reply 4913 `{param1 room_id, param2 campaign_id, param6 remaining bosses or "-1", param7 instance running}` |

- On hall close there is no request; drop the viewer registration when the player changes scene (8688/8747) or joins a room *(assumption)*.
- Concurrency: room membership changes go through the room actor ([rooms.md](rooms.md)).

## 9. Open questions and assumptions

1. How the original server picked the 6 rooms shown (no page index in 5026).
2. When the waiting list 11 is pushed and who is in it (players with the hall open, level >= 20 assumed).
3. The search frame password is not sent; a locked room always goes through 4370 then the password frame.

## 10. Implementation checklist

- [ ] Screen check: `PVERoomListFrame`, `PVERoomListView`, `PVERoomItem`, `PVEPlayerListView`, `PVERoomSearchFrame`, `RoomPasswordFrame`
- [ ] 5026 -> 13 (filter, 6 rooms)
- [ ] 4270 push to hall viewers on any room change
- [ ] 11 waiting list pushes
- [ ] 5023 create -> 12/120/17
- [ ] 8465 -> 4370; 5024 join with password and level checks
- [ ] 8780 -> 4913
- [ ] 126 tips for every refusal
- [ ] Table `campaign.hall_presence` (or in memory)
- [ ] Test: two clients, A creates, B sees the room in 13/4270, B joins, A receives 120 with two members
