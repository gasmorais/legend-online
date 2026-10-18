# Trial lobby ("Julgamento TM")

Module `artillery::trial_lobby`. Citation prefixes: see [README.md](README.md).

## 1. Overview

"Julgamento TM" is the daily vehicle PvP event. During its window the player opens the lobby and either:

- joins the solo quick match queue ("Participação rápida individual"), or
- creates or joins a team room of up to 4 players (`roomType = 2`, `capacity = 4`), readies up, and the captain starts.

When a match is formed the server creates the campaign 3001 and sends 125 `U_C_CAMPAIGN_CREATE`; the client switches to the `VEHICLE` scene ([battle-scene.md](battle-scene.md)).

Help text (`vehicle.helpText02`, `vehicle.helpTxt01`): "1-4 jogadores", "Nível ≥35", "Todos os dias 15:00-15:30" (text) while the template config says `MatchOfVehicleTime = 16:00,16:25` and `Vehicle_Day = 1,2,3,4,5,6,7`. The server must use the config (A).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `vehicle.DaimonTrialFrame` (623x510; `vehicleroomlist` openType 0) | Julgamento TM (`vehicle.molishilian`) | Lobby | toolbar, daily guide, world helper | left: current vehicle and "Ver Informações" link, "Trocar" opens garage; bottom: rules text, buttons Criar / Procurar / Iniciar / Cancelar, queue timer mm:ss |
| `vehicle.daimontrial.DaimonRoomSearchFrame` (355x250) | Procurar Sala / Procurar (`vehicle.findTeam`) | Find a room by number | "Procurar" button | input "Insira ID da equipe" |
| `vehicle.VehicleRoomFrame` (`vehicleroomlist` openType 2) | Julgamento TM | Team room: 4 `VehiclePlayerFigure` slots, room number, captain, password lock, invite, change vehicle, start / ready / cancel | push 12 with `roomType = 2` (`CM/yishi/manager/BaseManager.as:2660-2665`) | generic room members (120) incl. `vehicleTemplateId` (#38) |
| `core.RoomPasswordFrame` | | Password prompt | 4370 with `isSetPassword` | |

Lobby buttons are enabled only while `playerInfo.isVehicleStart` is true (`M9/vehicle/daimontrial/view/DaimonTrialBottomView.as:235-250`).

## 3. Routes (client to server)

| # | Action | UI control / sender | Client checks | Route and request | Expected response |
|---|---|---|---|---|---|
| L1 | Quick match | "Iniciar" -> `DaimonTrialBottomView.__startClickHandler` (`M9/vehicle/daimontrial/view/DaimonTrialBottomView.as:175-188`) -> `VehicleDaimonTrialController.quickStart` (`CM/mvc/controler/VehicleDaimonTrialController.as:73-76`) -> `RoomListSocketOutManager.quickStart` (`CM/yishi/manager/RoomListSocketOutManager.as:74-78`) | 5 s click throttle ("activity.view.ActivityItem.command01"); button enabled only when `isVehicleStart` | C to S 8608 (0x21a0) `C_VEHICLE_QUICK_PLAY`, empty body | 4525 `PropertyMsg{param1=1}` (queued, start timer); later 125 when matched |
| L2 | Cancel quick match | "Cancelar" (`DaimonTrialBottomView.as:190-206`); also on lobby dispose while queued (`:259-262`) | none | C to S 8609 (0x21a1) `C_VEHICLE_QUICK_PLAY_CANCEL`, empty body | none (client resets UI locally) |
| L3 | Create team room | "Criar" (`DaimonTrialBottomView.as:157-161`) -> `createRoom()` = `RoomListSocketOutManager.sendCreateRoom(4, 2, "")` (`VehicleDaimonTrialController.as:68-71`, `RoomListSocketOutManager.as:58-72`) | 5 s throttle shared with join | C to S 5023 (0x139f) `U_C_CAMPAIGN_ROOM_CREATE`, `room.RoomReqMsg` {`capacity` (#13, INT32) = 4, `room_type` (#9, INT32) = 2, `password` (#11, STRING) = ""} | 12 `RoomMsg` (opens `VehicleRoomFrame`), 120 members |
| L4 | Search room | `DaimonRoomSearchFrame` confirm (`M9/vehicle/daimontrial/DaimonRoomSearchFrame.as:115-130`) -> `searchRoom(id)` (`VehicleDaimonTrialController.as:78-81`) -> `sendSearchRoomInfo(2, id)` (`RoomListSocketOutManager.as:49-56`) | non empty numeric id ("pveroomlist.view.PVERoomSearchFrame.command01") | C to S 8465 (0x2111) `U_C_ROOM_FIND`, `RoomReqMsg` {`room_id` (#1, INT32), `room_type` (#9, INT32) = 2} | 4370 `RoomMsg` |
| L5 | Join room | after 4370: `enterRoom(2, roomId, pwd, false)` (`VehicleDaimonTrialController.as:37-66`) -> `addRoomById` (`RoomListSocketOutManager.as:31-47`) | 5 s throttle; password frame if `isSetPassword` | C to S 5024 (0x13a0) `U_C_CAMPAIGN_ROOM_ENTER`, `RoomReqMsg` {`room_id` #1, `password` #11, `room_type` #9 = 2, `is_invite` (#12, BOOL) = false, `is_get` (#14, BOOL) = false} | 12, 120 to joiner; 120 to members |
| L6 | Ready / unready | room "Pronto" (`M9/vehicle/room/VehicleRoomFrame.as:389-399`), "Cancelar" (`:418-435`) | `checkCanEnter`: more than 5 min before the window end, else "Contagem regressiva da entrada do Julgamento TM encerrada, não é possível entrar" (`:401-411`) | C to S 5036 (0x13ac) `U_C_PLAYER_READY_STATE`, `RoomReqMsg` {`state` (#6, INT32) 1 ready / 0 not ready, `is_get` #14 false} (`decompiled/m9/scripts/room/net/RoomSocketOuterManager.as:100-107`) | 24 to room |
| L7 | Captain start | room "Iniciar" (`VehicleRoomFrame.as:365-380`) | `roomInfo.allPlayerReader`; `checkCanEnter`; 3 s throttle (`RoomSocketOuterManager.as:76-98`) | C to S 5039 (0x13af) `U_C_CAMPAIGN_ENTER`, `campaign.CampaignReqMsg` {`para_int2` (#2) = 0, `para_bool1` (#7) = false, `isCross` (#9) = false} | 25 room state 2; then, when matched against another team or filled, 125 to every member |
| L8 | Captain cancel start | room "Cancelar" when captain (`VehicleRoomFrame.as:426-428`) | room state not 2 unless captain | C to S 5037 (0x13ad) `U_C_ROOM_STATE`, `RoomReqMsg` {`state` #6 = 1} (`RoomSocketOuterManager.as:109-115`) | 25 |
| L9 | Lock with password | lock button (`VehicleRoomFrame.as:325-333`) | captain | C to S 8344 (0x2098) `C_ROOM_PWDCHANGE`, `RoomEditMsg` {`room_id` #1, `room_pwd` #2} (`RoomSocketOuterManager.as:28-35`) | 32 `EditRoomRspMsg` |
| L10 | Open / close slot | click empty slot (`M9/vehicle/room/view/VehiclePlayerFigure.as:496-503`) | captain, slot empty | C to S 5029 (0x13a5) `U_C_CAMPAGIN_ROOM_PLACESTATE` via `RoomSocketOutManager.sendClose(index, open)` (`CM/managers/RoomSocketOutManager.as:69-76`) | 17 `PlaceStateRspMsg` |
| L11 | Kick | double click member (`VehiclePlayerFigure.as:507-513`) | captain, target not captain, room state not 2/3; confirm alert | C to S 5031 (0x13a7) `U_C_CAMPAIGN_ROOM_KILLPLAYER` (`RoomSocketOutManager.as:28-53`) | 28 `KillPlayerRspMsg` |
| L12 | Invite | "Convidar" (`VehicleRoomFrame.as:341-353`) | room has an empty slot ("room.view.pve.RoomRightView.command01") | generic `RoomInviteFrame` -> 5028 `U_C_CAMPAIGN_ROOM_INVITE` `RoomReqMsg{user_id #5}` | invitation push to target (generic room feature) |
| L13 | Change vehicle | "Trocar" (`VehicleRoomFrame.as:355-363`) | none | opens garage without group; see [garage.md](garage.md) R1 (8611) | 4515; 120 refresh (A) |
| L14 | Leave room | close frame (`VehicleRoomFrame.as:720-750`) | none | generic room exit (A: 5025 or the room exit opcode used by PvE rooms) | 15 `RoomExitRspMsg`; client reopens `vehicleroomlist` |

## 4. Server messages (server to client)

| Opcode | Message | Receiver | When | Client effect |
|---|---|---|---|---|
| 4512 (0x11a0) `U_C_VEHICLE_STATE` | `room.MatchStateMsg` {`match_state` (#1, BOOL), `param1` (#2, STRING), `param2` (#3, STRING)} | `BaseManager.__vehicleStartHandler` (`CM/yishi/manager/BaseManager.as:322,2832-2840`) | login and at window open/close, broadcast | `playerInfo.isVehicleStart`; enables lobby buttons and the timed toolbar button |
| 4525 (0x11ad) `U_C_VEHICLE_ROOM_START_COUNT` | `simple.PropertyMsg` {`param1` (#1, INT32) 1 = entered queue} | `DaimonTrialBottomView.__startCountHandler` (`DaimonTrialBottomView.as:142,216-233`) | reply to 8608 | shows Cancelar, starts timer, `existRoomInvate = true` |
| 4370 (0x1112) `U_C_ROOM_FIND_RESULT` | `room.RoomMsg` {`room_id` #1, `campaignId` #2, `master_id` #3, `name` #4, `count` #5, `capacity` #6, `room_state` #7, `room_type` #8, `is_set_password` (#9, BOOL), `masterServerName` #10, `masterName` #11, `masterScore` #12} | `VehicleDaimonTrialController.__searchRoomHandler` (`VehicleDaimonTrialController.as:29,37-53`) | reply to 8465 | password frame or direct join |
| 12 (0x000c) `U_C_CAMPAIGN_ROOM_CREATE` | `room.RoomMsg` | `BaseManager.__createRoomHandler` (`BaseManager.as:295,2636-2668`) | after 5023 / 5024 success | `RoomManager.setup`; `roomType == 2` opens `VehicleRoomFrame` |
| 120 `U_C_CAMPAIGN_ROOM_MEMBER` | `RoomPlayerListMsg` {`state` #1, `roomPlayer` #2 repeated `RoomPlayerMsg`} (60 fields; vehicle uses `vehicleTemplateId` #38) | `RoomManager.__roomMemberHandler` (`CM/managers/RoomManager.as:106,184-196`) | on join, leave, member change | slots redraw |
| 24 `U_C_PLAYER_READY_STATE` | `PlayerReadyRspMsg` (no fields in `protocol/proto.json`; gap) | `RoomManager.__updateReaderStateHandler` (`RoomManager.as:111,442`) | after 5036 | ready marks |
| 25 `U_C_ROOM_STATE` | `RoomStateRspMsg` {`room_state` (#1, INT32)} | `RoomManager.as:114,526` | after 5037 / 5039 | buttons |
| 17 `U_C_CAMPAGIN_ROOM_PLACESTATE` | `PlaceStateRspMsg` {`placeState` (#1, INT32, repeated)} | `RoomManager.as:115,536` | after 5029 | slot open/closed |
| 121 `U_C_CAMPAIGN_ROOM_MASTER` | `ChangeMasterRspMsg` {`room_id` #1, `master_id` #2, `serverName` #3, `isCross` #4} | `RoomManager.as:113,496` | captain left | captain label |
| 28 `U_C_CAMPAIGN_ROOM_KILLPLAYER` | `KillPlayerRspMsg` {`room_id` #1, `killed_player_id` #2} | `RoomManager.as:109,398` | after 5031 | kicked player returns to lobby |
| 15 `U_C_CAMPAIGN_ROOM_EXIT` | `RoomExitRspMsg` {`player_id` #1, `exit_type` #2, `param1` #3} | `RoomManager.as:112,467` | leave | |
| 32 `U_C_CAMPAIGN_ROOM_EDIT` | `EditRoomRspMsg` {`room_id` #1, `start_campaign_id` #2, `master_id` #3, `count` #4, `capacity` #5, `pass_word` #6, `room_name` #7} | `RoomManager.as:108,375` | after 8344 | lock icon |
| 125 (0x007d) `U_C_CAMPAIGN_CREATE` | `room.RoomCreatedMsg` {`created_type` (#1, INT32), `room` (#2, RoomMsg) with `campaignId = 3001`, `is_cross` (#3, BOOL), `campignId` (#4, INT32)} | `BaseManager.__createCampaignHandler` (`BaseManager.as:297,2530-2548`) -> `createVehicle` (`:2621-2634`) | match formed | `setScene("VEHICLE", ..., createdType)`; `created_type == 3` hides loading; the 125 packet is replayed into `VehicleSocketManager.createMapModel` (`M17/com/map/vehicle/net/VehicleSocketManager.as:154-158,774-787`) |

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Window | `MatchOfVehicleTime` = `16:00,16:25` (`|` separates several windows), days `Vehicle_Day` = 1..7 | `TPL/ConfigInfos.xml`; parsed in `VehicleRoomFrame.initStartEndDate` (`M9/vehicle/room/VehicleRoomFrame.as:123-155`) and `VehicleModel.initStartEndDate` (`M17/com/map/vehicle/VehicleModel.as:371-406`) |
| Entry cut-off | no ready/start in the last 5 minutes of the window | `VehicleRoomFrame.as:401-411` |
| Level | 35 (toolbar gate and help text) | `TopBtnType.as:214`, `vehicle.helpText02` |
| Team size | room capacity 4 | `VehicleDaimonTrialController.as:70` |
| Teams | two teams (`PlayerVehicleMsg.team`; red and blue scores) | [battle-scene.md](battle-scene.md) |
| One reward per round | "Para cada rodada, jogador poderá apenas obter 1 prêmio de resultado do evento" | `vehicle.helpTxt01` |
| Throttles | quick match 5 s, create/join 5 s, start 3 s | cited above |

Matchmaking (server-side, not in client, A): fill two teams of up to 4 from quick-match players and ready team rooms; a team room counts as a block that stays on one side.

## 6. Templates

| File | Record | Fields |
|---|---|---|
| `TPL/ConfigInfos.xml` | `MatchOfVehicleTime`, `Vehicle_Day`, `revivalTime` | window, days, revive cycle |
| `TPL/VehicleObjectTempInfos.xml` | vehicles shown in room slots | `Avatar`, `TemplateName` |

## 7. Persistent state

Rooms and queues are in memory. Persist only the daily participation:

```sql
CREATE TABLE artillery.trial_participation (
  player_id     BIGINT NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  event_date    DATE NOT NULL,
  match_count   INTEGER NOT NULL DEFAULT 0,
  rewarded      BOOLEAN NOT NULL DEFAULT false,
  PRIMARY KEY (player_id, event_date)
);
```

## 8. Backend implementation notes

- Scheduler: at window open broadcast 4512 `match_state = true`; at close broadcast `false`, cancel queues, keep running matches until their own end.
- `artillery::trial_lobby::handle_quick_play` (8608): check window, hero level >= 35, owned default vehicle, not in a room/scene; add to queue; reply 4525 `param1 = 1`.
- `artillery::trial_lobby::handle_quick_play_cancel` (8609): remove from queue.
- Room routes reuse the generic room service with `room_type = 2`, `capacity = 4`; validate the window on 5023/5024/5036/5039.
- `artillery::trial_lobby::handle_start` (5039 for room type 2): require all members ready; put the room in the matchmaker; when a match is formed create a `VehicleMatch` (campaign 3001) and send 125 to all participants, then the scene bootstrap ([battle-scene.md](battle-scene.md)).
- Push 4512 at login with the current window state.

## 9. Open questions and assumptions

- (A) Help text says 15:00-15:30, config says 16:00-16:25. Use config.
- (A) Exact matchmaking and team balancing rules.
- (A) Leave-room opcode for type 2 follows the generic room implementation.
- `PlayerReadyRspMsg` has no fields in `protocol/proto.json` (gap in schema extraction).

## 10. Implementation checklist

- [ ] Event window scheduler and 4512 broadcast (login and transitions).
- [ ] 8608 quick match with 4525 reply; 8609 cancel.
- [ ] Generic room service supports `room_type = 2`, capacity 4, password, slots, kick, invite.
- [ ] 8465 search -> 4370; 5024 join.
- [ ] 5036 ready, 5037 state, 5039 start with 5-minute cut-off.
- [ ] Matchmaker: two teams up to 4, rooms kept together.
- [ ] 125 `RoomCreatedMsg` with `campaignId = 3001`.
- [ ] Table `trial_participation`.
- [ ] Tests: start outside window, start with unready member, cancel while matched, disconnect in queue.
