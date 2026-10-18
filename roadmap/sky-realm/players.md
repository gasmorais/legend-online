# Sky realm: other players visibility and sync

Area: sky-realm, module `players`. Covers how the hub shows the other players: the player record (`RoomPlayerMsg`), join and leave pushes, appearance and equipment updates, army state (combat flag), chat bubbles, the render limits and the "hide others" toggle, and target selection.

Conventions: see [scene.md](scene.md).

## 1. Overview

Every player in the hub is a `SpaceArmy` keyed by `userId` in `SpaceModel._allArmysDict`. The server announces players with full `RoomPlayerMsg` records (4595/4606 for self, 4597 initial list, 4592 joins and refreshes) and removes them with 4593 or 4607. Appearance changes arrive through 149 (equipment and fashion) or by re-sending 4592 (mount, pet, guardian, title). The client renders at most 30 other players (team members always), adding one avatar every 500 ms.

## 2. Screens

| Class | pt-BR | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `map.space.view.physics.SpaceArmyView` (`M3/map/space/view/physics/SpaceArmyView.as`) | none | Avatar of a player: body, weapon, wings, fashion, mount, pet, guardian, monster, name, level, guild, VIP icon, title, vocation icon, returning-player icon, avenger effect, chat bubble, "in combat" icon | Walk layer render queue (`M3/map/space/view/layer/SpaceWalkLayer.as:358-416`) | `RoomPlayerMsg` fields (§4) |
| `SpaceWalkLayer` (`SpaceWalkLayer.as:42`) | none | Holds the avatars, applies the render caps and the hide-others flag | `SpaceSceneMapView` | none |
| Target selection (`PlayerManager.currentPlayerModel.selectTarget`) | none | Clicking another avatar selects it (top bar target view, player menu) | `SpaceArmyView.mouseClickHandler` (`SpaceArmyView.as:1577-1617`) | target name, level |
| `ChatItemMenu` PK entry | "Duelo" (see [duel.md](duel.md)) | Duel invite from a chat name menu | chat | none |

## 3. Routes (client to server)

| # | UI control | Client sender | Client checks | Route | Request | Expected response |
|---|---|---|---|---|---|---|
| P1 | none | `SpaceSocketOutManager.requestPlayerInfos` (`CM/map/space/manager/SpaceSocketOutManager.as:90-96`) | **no caller** | C>S 8701 0x21fd `C_GET_SPACE_PLAYER_ARMY_INFO` | `SpacePlayerArmyInfoReqMsg` (campaign): `userList (#1, INT32, repeated)` user ids | Assumption: 4592 with the requested `RoomPlayerMsg` records. Implement for completeness |
| P2 | "Mostrar Jogadores" / "Ocultar Jogadores" | `SmallMapBar.__othersShowHander` / `__othersHideHander` (`CM/mainBar/SmallMapBar.as:782-795`) | none | none (local `SharedManager.hideOthers`, event `HIDE_OTHERS`) | | none |
| P3 | Click another avatar | `SpaceArmyView.mouseClickHandler` (`SpaceArmyView.as:1577-1617`) | the click must hit more than 50 opaque pixels; self is ignored | none (local selection) | | none |

## 4. Server messages (server to client)

| Opcode | Message | Receiver | When | Client reaction |
|---|---|---|---|---|
| S>C 4592 0x11f0 `U_C_PLAYER_SPACE_ENTER` | `RoomEnterMsg` (room): `result (#1, INT32)` unused, `player (#2, RoomPlayerMsg, repeated)` | `SpaceSocketManager.__spaceEnterHandler` (`CM/map/space/manager/SpaceSocketManager.as:140-150`); buffered by `SpaceSocketDataProxy` before the scene loads | Push to all present players when someone enters; re-push of one record to all when that player's appearance, mount, pet, guardian, title, guild or army state changes while in the hub | `SpaceManager.readMember` for each record (`CM/map/space/SpaceManager.as:184-342`): creates or updates the `SpaceArmy`; a new army is queued for rendering (`addGarrison`); an existing one is updated in place (avatar refresh through `ThaneInfo.commit`). Position fields of an existing army update the model only, not the view |
| S>C 4597 0x11f5 `U_C_PLAYER_SPACE_SEND_EXSIT` | `RoomEnterMsg` | `SpaceManager.__initPlayerListHandler` (`SpaceManager.as:128-138`) | Once after 4595/4606 to the entering player: everyone already present | same as 4592 |
| S>C 4593 0x11f1 `U_C_PLAYER_SPACE_LEAVE` | `CampaignExitMsg` (campaign): `result (#1, INT32)` unused, `player_id (#2, INT32)` leaver userId, `army_id (#3, INT32)` unused, `server_name (#4, STRING)` unused | `SpaceSocketManager.__spaceLeaveHandler` (`SpaceSocketManager.as:152-162`); buffered | Push to the remaining players when one leaves the hub | Removes the army and its view, unless `player_id` is self |
| S>C 4607 0x11ff `U_C_PLAYER_REMOVE_IN_SPACE` | `SpacePlayerMoveMsg` (campaign): `players (#1, SpacePlayerMsg, repeated)`, only `playerId (#1)` is read | `SpaceManager.__removePlayerListHandler` (`SpaceManager.as:140-152`) | Batched removal (several leavers, server shutdown of a hub, disconnect sweep) | Removes each non-self army |
| S>C 149 0x0095 `U_C_HERO_BROAD_EQUIPMENT` | `HeroEquUpdatedMsg` (army): `player_id (#1, INT32)`, `arm_str (#2, STRING)` weapon avatar, `cloth_str (#3, STRING)` armor avatar, `wing (#4, STRING)`, `hat (#5, STRING)` hair fashion, `fashion_arm (#6, STRING)`, `fashion_cloth (#7, STRING)`, `hide (#8, BOOL)` hide fashion, `appellId (#9, INT32)` title, `trans_grade (#10, INT32)` vocation grade, `changeBranch (#11, INT32)` vocation branch | `SpaceSocketManager.__otherHeroInfoChange` (`SpaceSocketManager.as:186-208`); buffered | Push to hub players when a present player changes equipment, fashion, wings, title or class | Updates the `ThaneInfo` and redraws the avatar. The equipment owners ([../smith/README.md](../smith/README.md), [../fashion/README.md](../fashion/README.md), [../hero/README.md](../hero/README.md)) call the hub broadcast helper |
| S>C 140 0x008c `U_C_MAPDATA_SYNC` | `MapUpdatedMsg` (army): `updated_type (#1, INT32)` = 3, `army (#2, ArmyMsg)` with `player_id (#2)`, `state (#7)` | `SocketManager.mapDataSync` (`CM/yishi/service/managers/SocketManager.as:181-196`) → `ArmyManager.__updateArmyHandler` (`CM/yishi/manager/ArmyManager.as:335-370`) | Army state change of a player visible in the hub (start or end of a battle) | Sets `SpaceArmy.state` of that user if present → `UPDATE_STATE` → `SpaceArmyView` shows or hides the fire ("em combate") icon (`SpaceArmyView.as:1526-1535`) |
| Chat (owned by [../chat/README.md](../chat/README.md)) | `ChatData` channel 6 or 8 | `SpaceSocketManager.__playerChatHandler` (`SpaceSocketManager.as:118-138`) | Any chat line of a present player on channel 6 or 8 | Shows the bubble above the speaker's avatar |

### `RoomPlayerMsg` fields read by `readMember`

Message `RoomPlayerMsg` (room package). Optional fields are applied only when present (`has*`), so the server must always send the ones listed as "always".

| Field | Tag, type | Used as | Presence |
|---|---|---|---|
| `room_id` | #1, INT32 | unused here (send 10000) | always |
| `hero_id` | #5, INT32 | `ThaneInfo.id` | always |
| `player_id` | #6, INT32 | key; `userId` (0 falls back to `army_id`) | always |
| `grades` | #7, INT32 | level | always |
| `nick_name` | #8, STRING | name | always |
| `template_id` | #10, INT32 | hero template (sex, job); avatar is skipped when unknown (`SpaceWalkLayer.as:204-207`) | always |
| `arm`, `cloth` | #11, #12, STRING | weapon and armor avatars ("" = job default) | always |
| `army_id` | #13, INT32 | `SpaceArmy.id` | always |
| `cur_pos_x`, `cur_pos_y` | #15, #16, INT32 | spawn cell for new avatars | always |
| `campaign_id` | #17, INT32 | `SpaceArmy.mapId` (send 10000) | always |
| `online_state` | #18, BOOL | `ThaneInfo.state` 7 when true, else 0 | always |
| `consortia_id`, `consortia_name` | #19, #20 | guild line | always |
| `change_shapeId` | #21, INT32 | transformation avatar (> 0 replaces body) | always |
| `army_state` | #22, INT32 | `ArmyState` (0 idle, 1 moving, 2 fight, 3 battle pending, 4 recalling, 6 campaign); 2 or 3 show the combat icon and block duel invites | always |
| `geste` | #25, INT32 | honor (title area) | always |
| `head_id` | #26, INT32 | portrait | always |
| `is_vip`, `vip_type` | #27, #28 | VIP icon | always |
| `mount_tempId`, `mount_grade` | #29, #30, INT32 | see [mount-state.md](mount-state.md) | **always**, 0 when not riding |
| `wing` | #31, STRING | wings (applied only when present) | optional |
| `server_name` | #32, STRING | unused in the hub | optional |
| `hat`, `fashion_arm`, `fashion_cloth` | #33, #34, #35, STRING | fashion avatars | always |
| `hide` | #36, BOOL | hide fashion | always |
| `appellid` | #37, INT32 | title id | always |
| `vehicleTemplateId` | #38, INT32 | vehicle avatar (artillery) | optional |
| `fate_skills` | #39, STRING | fate skill effect | always |
| `petTemplateId`, `pet_quqlity`, `pet_name` | #40, #41, #42 | following pet; displayed quality = `(q-1)/5+1` when q < 26, else `(q-1)/5` | optional |
| `dragon_grade` | #44, STRING | `"type,grade,gp|..."`, the entry with the highest type is shown | optional |
| `transfer_grade`, `change_branch` | #45, #54, INT32 | vocation icon | optional |
| `is_back_player` | #48, BOOL | returning-player icon | optional |
| `child_job`, `child_name`, `child_sex`, `growth_grade`, `growth_grade2` | #49, #50, #51, #53, #58 | following guardian | optional |
| `monster_id` | #56, INT32 | following monster | optional |
| `avenger_grade` | #57, INT32 | avenger effect | always |

Fields not read in the hub: `count`, `current_room_index`, `player_state`, `sex`, `fighting_capacity`, `team_id`, `buffer_tempId`, `isNoGet`, `rank`, `group_type`, `child_fightcap`, `player_uuid`, `theseusMultiPvp*`.

## 5. Rules and formulas

| # | Rule | Source |
|---|---|---|
| PL1 | Render cap: at most 30 non-team armies (`RENDER_MAX`), robots counted against 10 (`ROBOT_MAX`); team members of the free team (`FreedomTeamManager.inMyTeam`) bypass the cap. Extra armies stay in the model and are never drawn until one leaves. | `SpaceWalkLayer.as:45-47, 179-216` |
| PL2 | Render pacing: one avatar added per 500 ms (`RENDER_TICK`); existing players are queued 5 s after the scene is shown. | `SpaceWalkLayer.as:49, 304-320, 374-402` |
| PL3 | Hide others: when `SharedManager.hideOthers` is true, non-team, non-self avatars stop animating (`isPlaying = false`) but remain clickable. | `SpaceWalkLayer.as:133-139, 166-177` |
| PL4 | Self record: `readMember` for self binds the global `ArmyManager.thane`; the server must not send 4592/4593/4607 about the receiver itself except inside 4595/4606. | `SpaceManager.as:200-208`, `SpaceSocketManager.as:158`, `SpaceManager.as:147` |
| PL5 | Combat icon: `ArmyState.checkCampaignAttack(state)` is false for states 2 and 3; the view clears its path and shows the fire icon. | `CM/map/internals/constant/ArmyState.as`, `SpaceArmyView.as:1526-1535` |
| PL6 | Position of an already known army is not moved by 4592; use 4594 or 4126. | `SpaceManager.as:268-269`, `SpaceWalkLayer.as:212-213` |
| PL7 | Chat bubbles only for channels 6 and 8 and only in `SPACE_SCENE`. | `SpaceSocketManager.as:118-138` |

## 6. Templates

None specific. Avatar paths come from equipment, fashion, mount and pet templates owned by other features.

## 7. Persistent state

No table. The hub record of a player is assembled on demand from the owning features (hero, army, fashion, mounts, einherjar, guardians, monsters, guild, VIP, titles). Presence is in memory (see [scene.md](scene.md)).

## 8. Backend implementation notes

- `sky_realm::players::build_room_player(player_id) -> RoomPlayerMsg`: single builder used by 4595, 4606, 4597, 4592 and by rooms; fill every "always" field (§4), including `mount_tempId` = 0 when not riding.
- `sky_realm::players::handle_request_infos` (8701): for each id present in the hub, reply 4592 with its record (assumption).
- `sky_realm::players::broadcast_refresh(player_id)`: when a present player's appearance changes, push 4592 with the new record to the other hub players. Call it from mounts (ride/dismount, appearance change), einherjar (follow pet change), guardians, monsters, titles, guild join/leave, VIP change.
- `sky_realm::players::broadcast_equipment(player_id)`: push 149 to the other hub players on equipment, fashion, wing, title, class changes.
- `sky_realm::players::broadcast_state(player_id, state)`: push 140 `{updated_type: 3, army: {army_id, player_id, state}}` when a hub player enters or leaves a battle (battle engine hook, [../battle/README.md](../battle/README.md)).
- Leave fan-out: 4593 for single leaves, 4607 for batches (for example a timed sweep of disconnected sessions).

## 9. Open questions and assumptions

- Assumption: 4592 is also the refresh vehicle for appearance changes (the handler updates existing armies in place).
- Assumption: 8701 replies with 4592.
- Whether the original server limited visibility (area of interest) is unknown; the client copes with full broadcasts (PL1).
- `HeroEquUpdatedMsg` is also consumed elsewhere (campaign maps); the hub only needs the fan-out to present players.

## 10. Implementation checklist

- [ ] Builder `build_room_player` with all "always" fields
- [ ] Route P1 8701 `sky_realm::players::handle_request_infos`
- [ ] Server message 4592 join and refresh
- [ ] Server message 4597 initial list
- [ ] Server message 4593 single leave, 4607 batch removal
- [ ] Server message 149 equipment broadcast hook
- [ ] Server message 140 type 3 state broadcast hook
- [ ] Rule PL4 never send own records outside 4595/4606
- [ ] Test: 35 players present, viewer renders 30 plus team members
- [ ] Test: equipment change of A is visible to B without re-entering
