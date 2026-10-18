# Sky realm ("Reino do Céu")

Client package `map.space` (`CM/map/space`, `M3/map/space`), scene `SPACE_SCENE`, map 10000 (9000 × 6000 px). The Reino do Céu is the shared social hub of the server: every player of level 16 or more lands here after login and after most activities, walks among the other players, rides mounts, duels, and talks to 36 NPCs that open almost every activity of the game.

All traffic is socket based (no HTTP route except the optional robot XML). PostgreSQL schema: `sky_realm`. Rust handlers: `sky_realm::<module>::handle_<action>`.

`CM` = `decompiled/core_module/scripts`, `M3` = `decompiled/m3/scripts`.

## Entry points

| Entry | Condition | Result |
|---|---|---|
| Login | level > 16 and `newbieProcess ≥ 36000`; the login burst includes 4595 | Client opens the hub directly (`CM/yishi/manager/BaseManager.as:1940-1960, 1345-1372`) |
| Minimap "Ir ao Reino dos Ceús" (castle, outer city) | level ≥ 16, not in bot mode, not in a campaign | 8688 → 4606 (`CM/mainBar/SmallMapBar.as:553, 854-857`) |
| Castle building shortcuts `goSpaceAndFind(1/2/6/8)` and quest jumps | as above | Enter, then walk to the NPC (`CM/yishi/SwitchPageHelp.as:1981-1999`) |
| Return from battles, rooms, campaigns and activity frames | `returnScene` = hub when level ≥ 16 and `spaceMapId != 0` | Client switches back on 4606 or by `returnToSpace` (`SwitchPageHelp.as:1955-1979`) |
| Key M | level ≥ 16, in the hub | Map frame `SpaceMapFrame` (`CM/yishi/keyboard/KeyBoardRegister.as:470-517`) |
| Exits | Castle button, key Q (outer city), NPC options, portal node 5, room or campaign creation | see [scene.md](scene.md) |

## Modules

| Module | Content |
|---|---|
| [scene.md](scene.md) | Enter/leave (8688, 8747, 8689), scene creation 4595/4606, player list 4597, spawn, map files, map frame, minimap, robots (dead code), level gates |
| [movement.md](movement.md) | Client pathfinding (`FindPath8`), flying mounts, speed, 8690 batches, 4594 relay, 4126 correction, 8700 obstacle check, server validation |
| [players.md](players.md) | Player record `RoomPlayerMsg` field by field, 4592 join/refresh, 4593/4607 leave, 149 equipment, 140 army state, chat bubbles, render caps, hide others |
| [mount-state.md](mount-state.md) | Mounted/unmounted display for self (150) and others (4592), flying, landing restriction, hooks for the mounts feature |
| [npc-interaction.md](npc-interaction.md) | Node model, 8692 → 4601 / 143 / 125, dialog option parsing, full option type enum with target features, ring task gathering (8733), gift piles (8994, 4811), holiday exchange (9586) |
| [npc-catalog.md](npc-catalog.md) | Every node of `MapNodeInfos.xml` with its options, levels, actions and owning feature folder |
| [duel.md](duel.md) | "Duelo" invitations (9547 ops 1/2/3, 4421) and the duel battle |

## Opcode summary

| Dir | Opcode | Name | Module |
|---|---:|---|---|
| C>S | 8688 | `C_PLAYER_SPACE_ENTER` | scene |
| C>S | 8689 | `C_PLAYER_SPACE_LEAVE` (no caller) | scene |
| C>S | 8747 | `C_ENTER_CASTLE` | scene |
| C>S | 8690 | `C_PLAYER_SPACE_MOVE` | movement |
| C>S | 8700 | `C_CHECK_MOVEABLE` | movement |
| C>S | 8701 | `C_GET_SPACE_PLAYER_ARMY_INFO` (no caller) | players |
| C>S | 8692 | `C_PLAYER_SPACE_NODE_TRIGGER` | npc-interaction |
| C>S | 8733 | `C_SPACE_COLLECTION_FINISHED` | npc-interaction |
| C>S | 8994 | `C_NEW_YEAR_BOX_ACTIVE` (ops 1, 2, 3) | npc-interaction |
| C>S | 9586 | `C_NPC_ITEM_EXCHANGE` | npc-interaction |
| C>S | 9547 | `C_SPACEMAP_ATTACK` (ops 1, 2, 3) | duel |
| S>C | 4595 | `U_C_PLAYER_SPACE_CREATE` | scene |
| S>C | 4606 | `U_C_PLAYER_RETURN_TO_SPACE` | scene |
| S>C | 4597 | `U_C_PLAYER_SPACE_SEND_EXSIT` | scene, players |
| S>C | 4592 | `U_C_PLAYER_SPACE_ENTER` | players, mount-state |
| S>C | 4593 | `U_C_PLAYER_SPACE_LEAVE` | players |
| S>C | 4607 | `U_C_PLAYER_REMOVE_IN_SPACE` | players |
| S>C | 4594 | `U_C_PLAYER_SPACE_SYNC_POS` | movement |
| S>C | 4126 | `U_C_SEND_STANDPOS` | movement |
| S>C | 149 | `U_C_HERO_BROAD_EQUIPMENT` | players |
| S>C | 140 | `U_C_MAPDATA_SYNC` (type 3) | players |
| S>C | 4601 | `U_C_PLAYER_SPACE_EVENT` | npc-interaction |
| S>C | 143 | `U_C_PLAY_MOVIE` (`COLLECTION`) | npc-interaction |
| S>C | 4811 | `U_C_SELECT_NEW_YEAR_BOX_NODE` | npc-interaction |
| S>C | 4421 | `U_C_HANGUP_PVP` | duel |

## Cross-cutting rules

- Coordinates on the wire are 20 px cells (`PosMsg`, `RoomPlayerMsg.cur_pos_*`, `StandPosMsg`, `MapNodeInfos.PosX/PosY`); 450 × 300 cells.
- The hub is a single shared room per server; cross-server players do not appear.
- The client never receives its own records outside 4595/4606 (no echo of 4592, 4593, 4594, 4607).
- Packets 4592, 4593, 4594, 149 and 4601 may arrive before the scene module is loaded; the client buffers them (`CM/proxy/scene/SpaceSocketDataProxy.as:16-20`).
- The server must answer 8688 with 4606 outside the login burst ([scene.md](scene.md) R3).

## Dependencies

| Feature | Why |
|---|---|
| [../account/README.md](../account/README.md) | login burst sends 4595 |
| [../hero/README.md](../hero/README.md), [../army/README.md](../army/README.md) | hero level, avatar fields, army id and state; class advancement options (15, 104, 154) |
| [../mounts/README.md](../mounts/README.md) | riding state, flying flag, 8529 ride/dismount, 150 |
| [../fashion/README.md](../fashion/README.md), [../smith/README.md](../smith/README.md) | avatar strings, 149 broadcast |
| [../einherjar/README.md](../einherjar/README.md), [../guardians/README.md](../guardians/README.md), [../monsters/README.md](../monsters/README.md) | following pet, guardian, monster on the avatar; NPC options; Ilha dos Einherjars portal |
| [../guild/README.md](../guild/README.md), [../vip/README.md](../vip/README.md) | guild name, VIP icon in the player record |
| [../chat/README.md](../chat/README.md) | bubbles for channels 6 and 8 |
| [../team/README.md](../team/README.md) | free team members always visible, follow, team positions on the map frame |
| [../battle/README.md](../battle/README.md) | duel battle, army state 2/3, return to the hub |
| [../quests/README.md](../quests/README.md) | story tasks, ring task, offer reward, gathering node 18 |
| [../seasonal-events/README.md](../seasonal-events/README.md) | gift piles, Papai Noel options, new year window |
| [../world-map/README.md](../world-map/README.md) | exit to the outer city (key Q), shared 140 handler |
| [../outyard/README.md](../outyard/README.md) | Terralém gates (nodes 35, 36), options 118, 119 |
| Every feature in the [npc-catalog.md](npc-catalog.md) feature map | frames opened by NPC options |

## Suggested implementation order

1. [scene.md](scene.md): 8688 → 4606, login 4595, 4597, presence registry, leave detection, `player_positions`.
2. [players.md](players.md): `build_room_player`, 4592/4593 fan-out.
3. [movement.md](movement.md): 8690 validation and 4594 relay, 4126 helper.
4. [mount-state.md](mount-state.md): refresh hook from the mounts handler.
5. [npc-interaction.md](npc-interaction.md): 8692 → 4601 for all dialog NPCs, portal 125, then gathering and gift piles.
6. [npc-catalog.md](npc-catalog.md): verify every NPC opens its dialog; owners implement the frames.
7. [duel.md](duel.md): invitations and duel battle.

## Current Rust server coverage

`server/flows.json` and `server/flows/navigation.json` implement: 8688 → 4595 (fixed spawn (175,98), `mount_tempId` from `$var.mount`), 8690 accepted with no relay, 8692 → 4601 echo, 8689 → 4593 to self. Missing: 4606, 4597, 4592/4594 fan-out to other players, validation, persistence, 8733, 8994, 9586, 9547, 8700, 8701.
