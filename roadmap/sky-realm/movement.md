# Sky realm: movement and walk routes

Area: sky-realm, module `movement`. Covers how the own hero walks in the hub (pathfinding, flying mounts, speed), how the walk is reported to the server (8690), how other clients receive it (4594), position corrections (4126) and the obstacle check (8700).

Conventions: see [scene.md](scene.md). Points in `PosMsg` are **20 px cells**.

## 1. Overview

Walking is computed entirely by the client: it runs an 8-direction A* (`FindPath8`) over the walkable cells of `maps/10000/10000.titles`, animates the hero locally and streams the cells it actually stepped on to the server in batches of up to 7. The server stores the last cell and relays the batch to the other players in the hub, who append it to the avatar path. The server never computes paths; it only validates, stores and relays.

## 2. Screens

No dedicated screen. Inputs:

| Input | Handler | Effect |
|---|---|---|
| Click on the ground | `SpaceWalkLayer.onClickHandler` (`M3/map/space/view/layer/SpaceWalkLayer.as:322-337`) | Clears the selected node and the reinforce target, then `SpaceSceneController.moveArmyByPos(mouseX, mouseY, true)` |
| Click on a node, NPC button or map frame entry | `SpaceArmyViewHelper.visitNode` (`M3/map/space/helper/hero/SpaceArmyViewHelper.as:58-97`) | Walks to the node; for patrol NPCs (MasterType 1) to an attack point beside it |
| Map frame click | `SpaceMapFrame.__mapClickHandler` (`M3/map/space/view/frame/SpaceMapFrame.as:304-329`) | `moveArmyByPos` with frame coordinates × 16.6 |
| Team follow | `FreedomTeamFollowMediator` (`M3/map/internals/mediator/team/FreedomTeamFollowMediator.as`) | Calls the same walk path (team feature, [../team/README.md](../team/README.md)) |

## 3. Routes (client to server)

| # | UI control | Client sender | Client checks | Route | Request | Expected response |
|---|---|---|---|---|---|---|
| M1 | Hero steps while walking (automatic) | `SpacePlayerWalkMediator.__walkNextHandler` / `__walkOverHandler` → `sendPath` (`M3/map/space/mediator/hero/SpacePlayerWalkMediator.as:85-94, 132-148, 217-228`) → `SpaceSocketOutManager.move` (`CM/map/space/manager/SpaceSocketOutManager.as:64-80`) | Sent when 7 cells are buffered (`_sendPosRate = 7`, `:54`) or when the walk ends; nothing is sent while the path buffer is empty. Before walking `moveArmyByPos` refuses in bot mode ("Modo Bot em andamento"), outside the map rectangle, or with no reachable start (`M3/map/space/SpaceSceneController.as:707-808`) | C>S 8690 0x21f2 `C_PLAYER_SPACE_MOVE` | `SpacePlayerMoveMsg` (campaign): `players (#1, SpacePlayerMsg, repeated)` with exactly one entry: `playerId (#1, INT32)` = own userId (`ArmyManager.army.userId`), `state (#2, INT32)` not set, `path (#3, PosMsg, repeated)` = stepped cells in order, each `x (#1, INT32)`, `y (#2, INT32)` | No reply to the sender. Relay 4594 to the other players in the hub |
| M2 | Dismount or change mount while standing on an obstacle (only when `isInCampaign`) | `MountsFrame.__onDismountBtnClick` (`decompiled/m14/scripts/mounts/MountsFrame.as:842-861`), `WildSoulFrame.__onChangeBtnClick` (`decompiled/m14/scripts/mounts/WildSoulFrame.as:415-440`) → `SpaceSocketOutManager.resetSpacePosition` (`SpaceSocketOutManager.as:42-46`) | Only sent when `SwitchPageHelp.isInCampaign` and `isOnObstacle`; in the hub the client blocks the dismount instead (rule MV6) | C>S 8700 0x21fc `C_CHECK_MOVEABLE` | no body | Assumption: 4126 `StandPosMsg` with the nearest walkable cell, then the mount op reply. Owned here because the opcode is in the space sender; used by campaign maps |

## 4. Server messages (server to client)

| Opcode | Message | Receiver | When | Client reaction |
|---|---|---|---|---|
| S>C 4594 0x11f2 `U_C_PLAYER_SPACE_SYNC_POS` | `SpacePlayerMoveMsg`: `players (#1, SpacePlayerMsg, repeated)`; per entry `playerId (#1, INT32)` mover, `state (#2, INT32)` ignored by the client, `path (#3, PosMsg, repeated)` cells | `SpaceSocketManager.__spaceMoveHandler` → scene buffer → `__spaceSyncPosHandler` (`CM/map/space/manager/SpaceSocketManager.as:169-184`) → `SpaceModel.moveArmyTo` → `SpaceWalkLayer.__armyPosBroadHandler` (`M3/map/space/view/layer/SpaceWalkLayer.as:244-302`) | Push to every other hub player for each accepted 8690 (one entry per mover, may batch several movers) | Ignored outside `SPACE_SCENE`. For each mover with a rendered view: if the first cell is more than 250 px from the avatar, the avatar jumps there; else the not yet walked part of its current path is kept and the new cells are appended; the current tile is prepended; `PathPointUtils.optimizePath` |
| S>C 4126 0x101e `U_C_SEND_STANDPOS` | `StandPosMsg` (campaign): `id (#1, INT32)` player userId, `pos_x (#2, INT32)` cell, `pos_y (#3, INT32)` cell, `server_name (#4, STRING)` unused | `SpaceSocketManager.__standPosHandler` (`SpaceSocketManager.as:241-278`) | Correction of any player position (anti-cheat snap, after 8700, after a teleport); to self and to viewers | Ignored outside `SPACE_SCENE`; sets `curPosX/Y`; if it is the own army also updates `ArmyManager.army`; moves the view to cell × 20 and clears its path |

The sender must **not** receive its own 4594: the walk layer would re-path the own avatar with the relayed cells.

## 5. Rules and formulas

| # | Rule | Source |
|---|---|---|
| MV1 | Grid: 20 px cells, `W/20 × H/20` = 450 × 300 for map 10000. Walkable = key `"x_y"` present and truthy in `.titles`. | `M3/map/space/SpaceSceneController.as:193-198`, `CM/map/space/SpaceModel.as:224-227, 313-321` |
| MV2 | Ground path: `FindPath8.find(startCell, endCell)` then `AcorrsLineGrid.getPsnode` (removes intermediate points on straight visible lines). With `param3 = true` (clicks) the target is first snapped by `WalkRectScanUtils.walkRectScan` to a walkable cell. | `SpaceSceneController.as:770-800` |
| MV3 | Start cell: current view position if walkable, else the nearest walkable cell in rings 1..9 (`getNeighborII`); if none, the hero is placed on node 14 (MasterType 40) and the walk is cancelled. | `SpaceSceneController.as:754-765, 838-851`, `SpaceModel.as:229-271` |
| MV4 | Target near a node: if the clicked cell is within the `HandlerRange` of a node (not MasterType 191 or 1, `Param1 != 2`), the target becomes a random cell of that node's diamond of walkable cells at distance exactly `HandlerRange` (`SpaceNode.initHandlerRangePoints`). Portal nodes (`Param1 == 2`) are walked onto directly. | `SpaceSceneController.as:719-735`, `CM/map/internals/data/SpaceNode.as:81-115` |
| MV5 | Flying: an army is flying when its mount template has `IsFly == 1` or `isBuyFly`. Flying paths are the straight segment `[start, target]` (no A*), start clamped to the map rectangle, obstacles ignored. | `CM/map/space/SpaceModel.as:162-174`, `SpaceSceneController.as:743-753, 777-782, 817-836` |
| MV6 | Landing: `canLand(templateId)` is false in the hub when the own view cell is an obstacle with no walkable cell within ring 2 and the mount (or the target mount) does not fly. MountsFrame dismount and WildSoulFrame change then show "Não é possível remover estado de montaria voadora" and send nothing. | `SpaceModel.as:176-202, 273-311`, `MountsFrame.as:851-855`, `WildSoulFrame.as:428-431` |
| MV7 | Speed: 7 (AI units per frame) on foot; with any mount `7 × (100 + maxSpeed) / 100` where `maxSpeed` is the highest `Speed` among the player's owned mount avatars (`WildSoulCollection.getSpeedMaxMount`). For other players the client uses the **viewer's** own avatar list (client bug, cosmetic). | `CM/map/internals/utils/ArmySpeedUtils.as:14-29`, `M3/map/space/view/layer/SpaceWalkLayer.as:404-416`, `SpaceArmyView.as:938-952` |
| MV8 | Path batching: on each reached cell the cell is pushed; if the new cell and the two last buffered cells are pairwise neighbors (Chebyshev ≤ 1), the last buffered cell is dropped. A batch is flushed at 7 cells and at walk end. Consecutive cells in one batch are therefore usually 1 cell apart, at most 2 after a drop. | `SpacePlayerWalkMediator.as:96-148` |
| MV9 | Arrival: at walk end the client checks the selected node (`getNodeInRange`: distance < `HandlerRange + 5` cells) or any portal node in range (`Param1 == 2`) and triggers it ([npc-interaction.md](npc-interaction.md)). | `SpaceArmyViewHelper.as:99-116, 281-301` |
| MV10 | Leaving range: every 12 frames, if the hero is farther than `2 × HandlerRange` cells from the last checked node, its dialog and frames are closed. | `SpacePlayerWalkMediator.as:150-193` |
| MV11 | Other players: path jump threshold 250 px; render queue adds one avatar every 500 ms. | `SpaceWalkLayer.as:49, 275-279, 374-402` |

Server validation (assumptions, the client gives no feedback on rejection):

- `playerId` must equal the session player; drop entries for other ids.
- Every cell inside `[0,449] × [0,299]`; walkable unless the army is flying (MV5).
- First cell within 3 cells of the last stored cell; consecutive cells within 2 cells (ground) or any distance (flying).
- Speed: cells advanced per second ≤ `speed × 25 fps / 20 × 1.5` tolerance; on violation send 4126 with the last valid cell to the mover and its viewers.
- Store the last cell as the hub position.

## 6. Templates

| File | Fields |
|---|---|
| `raw/maps/10000/10000.titles` | walkable cells (also used server side for validation) |
| `raw/xml/tempinfos/MountTempInfos.xml` | `IsFly` per mount template (flying rule MV5); owned by [../mounts/README.md](../mounts/README.md) |
| `raw/xml/tempinfos/MapNodeInfos.xml` | `PosX`, `PosY`, `HandlerRange`, `Param1` for MV4 and MV9 |

## 7. Persistent state

Uses `sky_realm.player_positions` ([scene.md](scene.md) §7). The in-memory presence entry holds: last cell, last move timestamp, flying flag (from the mounts module), current batch sequence.

## 8. Backend implementation notes

- `sky_realm::movement::handle_move` (8690): decode `SpacePlayerMoveMsg`; take the first `players` entry with `playerId == session`; reject when the player is not present in the hub. Validate per §5. Update the in-memory cell (and persist asynchronously every 10 s or on leave). Build `SpacePlayerMoveMsg{players: [{playerId, path}]}` and send 4594 to every other present player (AOI optional: the client renders at most 30 players, so a full broadcast is acceptable at hub sizes below a few hundred).
- `sky_realm::movement::handle_check_moveable` (8700): if the stored cell is not walkable, find the nearest walkable cell (BFS over `.titles`) and send 4126 to self and viewers; else send 4126 with the current cell (assumption).
- `sky_realm::movement::push_stand_pos(player_id, cell)`: helper used by teleports and anti-cheat to send 4126.
- Load the `.titles` grid of map 10000 once at startup (zlib + AMF3, see [../../docs/world/maps.md](../../docs/world/maps.md) §5) into a bitset.

## 9. Open questions and assumptions

- Assumption: the server echoes the path cells unchanged; `SpacePlayerMsg.state` is left unset (the client ignores it).
- Assumption: 8700 is answered by 4126; no client listener confirms it (4126 is handled in campaign and space).
- Speed tolerance values are proposals.
- Viewer-side speed of others uses the viewer's mount list (MV7); the server cannot fix that.

## 10. Implementation checklist

- [ ] Route M1 8690 `sky_realm::movement::handle_move`
- [ ] Route M2 8700 `sky_realm::movement::handle_check_moveable`
- [ ] Server message 4594 relay (never to the sender)
- [ ] Server message 4126 correction helper
- [ ] Rule MV1 grid loaded from `10000.titles`
- [ ] Validation rules (bounds, walkable, adjacency, speed) with flying exception
- [ ] Persist last cell to `sky_realm.player_positions`
- [ ] Test: two clients, A walks, B sees A follow the same cells
- [ ] Test: teleport-like jump (> 250 px) is snapped by the viewer
- [ ] Test: flying mount crosses obstacles and is accepted
