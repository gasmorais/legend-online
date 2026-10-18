# Sky realm: NPC and node interaction

Area: sky-realm, module `npc-interaction`. Covers the node model of `MapNodeInfos.xml`, how a click on a node becomes a server trigger (8692) and a dialog (4601), how the dialog frame builds its options, the full option type enum and what each type opens, the collection nodes (ring task plant and gift piles), the holiday item exchange and the portal to the Ilha dos Einherjars. The per NPC list with every option is in [npc-catalog.md](npc-catalog.md).

Conventions: see [scene.md](scene.md).

## 1. Overview

The hub has 58 template nodes (all `MapId = 10000`). The client builds them locally from `MapNodeInfos.xml`; the server never sends the node list for the hub. Interaction is a short handshake:

1. The player clicks a node (avatar, name button, map frame entry). The hero walks to a cell at `HandlerRange` distance.
2. On arrival the client sends **8692** with the node id.
3. The server checks distance and conditions and answers **4601** with the same node id (dialog NPCs, gift piles, Terralém gates), or **143** `COLLECTION` (ring task plant), or **125** (portal), or nothing.
4. On 4601 the client opens the dialog (when the node has `Dialogue`) or directly the frame of the first option. Dialog options run client side actions; most open another feature's frame, a few send their own packets.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `map.space.SpaceDialogFrame` (`M3/map/space/view/frame/SpaceDialogFrame.as:81-158`), controller `space` openType 2 (`CM/mvc/controler/SpaceController.as:43-44`) | NPC name "{name}:" (`public.colon`) | NPC portrait (`IconFactory.getNPCIcon(nodeId)`, hidden for node 21), dialogue text, options, "Sair" | `SpaceArmyViewHelper.openNodeDialog` (`M3/map/space/helper/hero/SpaceArmyViewHelper.as:269-273`) on 4601 | `Dialogue`, options from `Param3/4/5/ItemExchange`; for node 17 with level ≥ 35 the ring task reward items for 50 and 200 rings |
| `DialogOptionItem` (`M3/map/space/view/frame/DialogOptionItem.as:264-277`) | option title (from `Param3`) | One clickable option row (394 × 24) | dialog frame | title; for type 13 a remaining reward counter |
| `SpacePhysicsView`, `SpaceNpcView` | node name | Building nodes (`Resource != 1`, `mapmaterial/build/<SonType>.swf`) and NPC avatars (`Resource == 1`) | Building and NPC layers (`M3/map/space/view/layer/SpaceBuildingLayer.as:72-110`, `SpaceNpcLayer.as:195-236`) | name, glow on hover; gift piles only when active |
| Name buttons `map.space.NPCBtn<nodeId>` | NPC title art | Clickable label above each NPC | `SpaceUIMediator.addAllBtn` (`M3/map/space/mediator/mapview/SpaceUIMediator.as:87-165`) | none |
| `CollectionAction` progress bar (`CM/yishi/actions/map/collection/CollectionAction.as`) | none | Gathering animation (`asset.core.CollectionAsset`, duration = frames × 33 ms) | 143 `COLLECTION` | progress |

## 3. Routes (client to server)

| # | UI control | Client sender | Client checks | Route | Request | Expected response |
|---|---|---|---|---|---|---|
| N1 | Arrive at a node after clicking it (or step on a portal node) | `SpaceArmyViewHelper.visitNode` / `selfArmyToEnd` → `nodeTrigger` (`SpaceArmyViewHelper.as:58-179`) → `SpaceSocketOutManager.nodeTrigger` (`CM/map/space/manager/SpaceSocketOutManager.as:82-88`) | In range: distance < `HandlerRange + 5` cells from the selected node, or any node with `Param1 == 2` within `HandlerRange` at walk end (`:99-116, 281-301`). MasterType 1 nodes (patrol NPCs) are handled locally without packet (none in this template). If the first `Param3` field is `"12"` (ring task plant, node 18) the current ring task must exist, have condition type 4 with `Para1 == Param4` and not be completed, else nothing is sent (`:156-176`) | C>S 8692 0x21f4 `C_PLAYER_SPACE_NODE_TRIGGER` | `PropertyMsg`: `param1 (#1, INT32)` = node id | Per node kind (rules NI3): 4601, or 143 `COLLECTION`, or 125, or nothing |
| N2 | Gathering finished (ring task plant) | `CollectionAction.sendCollection` (`CollectionAction.as:484-500`) → `SocketSendManager.sendSpaceCollectOver` (`CM/yishi/service/managers/SocketSendManager.as:521-527`) | progress completed without moving or clicking away (cancel on mouse down outside the node, `CollectionAction.as:340-428`) | C>S 8733 0x221d `C_SPACE_COLLECTION_FINISHED` | `PropertyMsg`: `param1` = node id | Item granted by the quests feature (ring task progress, bag push). Assumption |
| N3 | Hub entry: query active gift piles | `SpaceUIMediator.register` (`SpaceUIMediator.as:37-44`) → `StoreSocketOutManager.searchYearBox` (`CM/managers/StoreSocketOutManager.as:340-346`) | none | C>S 8994 0x2322 `C_NEW_YEAR_BOX_ACTIVE` | `PropertyMsg`: `param1` = 3 (query) | 4811 list of active piles |
| N4 | 4601 for a gift pile (MasterType 300..315 or 410) | `SpaceSceneController.__selectNodeHandler` (`M3/map/space/SpaceSceneController.as:676-679`) → `StoreSocketOutManager.sendYearBoxCollect` (`StoreSocketOutManager.as:317-329`) | level ≥ 35, else "Nível insuficiente, a função só é ativada no nível 35." | C>S 8994 | `PropertyMsg`: `param1` = 1 (start), `param2 (#2, INT32)` = node id | 143 `COLLECTION` for that node |
| N5 | Gathering finished (gift pile) | `CollectionAction.sendCollection` (`CollectionAction.as:496-499`) → `StoreSocketOutManager.sendYearBoxCollectConfirm` (`StoreSocketOutManager.as:331-338`) | as N2 | C>S 8994 | `PropertyMsg`: `param1` = 2 (confirm), `param2` = node id | Reward pushes (seasonal-events) and 4811 refresh |
| N6 | Holiday exchange option (type 107) | `DialogOptionItem.__optionBtnClickHandler` case 107 (`DialogOptionItem.as:710-722`) → `SpaceSocketOutManager.sendHolidayExchange` (`SpaceSocketOutManager.as:110-117`) | new year window open (`ConfigManager.info.NEW_YEAR_MODULE`, begin ≤ now < end) else "Evento ainda não foi aberto, não é possível entrar"; the player holds the `give` items of that option (`checkGoodsCount`) else "Itens suficientes, não pode ser trocado" | C>S 9586 0x2572 `C_NPC_ITEM_EXCHANGE` | `CampaignReqMsg` (campaign): `para_int1 (#1, INT32)` = node id, `para_int2 (#2, INT32)` = option index inside `ItemExchange` | Bag pushes (remove give items, add get items). Owned by [../seasonal-events/README.md](../seasonal-events/README.md) |
| N7 | Dialog option click | `DialogOptionItem.__optionBtnClickHandler` (`DialogOptionItem.as:329-904`) | `optionLevel > hero level` → "Função habilitada no Nv. {0}" | per type (§5 table) | | |
| N8 | Node without dialogue, direct frame | `__selectNodeHandler` (`SpaceSceneController.as:688-703`) → `SpaceArmyViewHelper.openNodeFrame(type)` (`SpaceArmyViewHelper.as:240-257`) | level = third field of `Param3` | none (opens a frame) | | |

## 4. Server messages (server to client)

| Opcode | Message | Receiver | When | Client reaction |
|---|---|---|---|---|
| S>C 4601 0x11f9 `U_C_PLAYER_SPACE_EVENT` | `PropertyMsg`: `param1 (#1, INT32)` node id | `SpaceSocketManager.__spaceEventHandler` (`CM/map/space/manager/SpaceSocketManager.as:210-216`) → `SpaceSceneController.__selectNodeHandler` (`SpaceSceneController.as:623-705`); buffered before scene load | Reply to an accepted 8692 for dialog NPCs, gift piles, Terralém gates. May also be pushed to open an NPC programmatically (`SpaceManager.visitSpaceNPC` callers rely on it) | Sets `checkNodeId` and `selectNode`, runs the pending `visitSpaceNPC` callback; stops if `isPopFrame` is false. Then: node 21 marriage car checks; gift pile → N4; nodes 35/36 → `TopToolsBar.enterOutyardScene` (`CM/ui/toptoolbar/TopToolsBar.as:1603`, [../outyard/README.md](../outyard/README.md)); `Dialogue` not empty → dialog; else N8 |
| S>C 143 0x008f `U_C_PLAY_MOVIE` | `PlayerMovieMsg` (player): `movie_target_type (#1, INT32)` = 0 (node), `target_id (#2, INT32)` node id, `movie_type (#3, STRING)` = `"COLLECTION"`, `delay (#4, INT32)`, `map_id (#5, INT32)` | `SocketManager` re-dispatches 143 as `U_PLAY_MOVIE` (`CM/yishi/service/managers/SocketManager.as:119-126`) → `SpaceSocketManager.__playMovieHandler` (`SpaceSocketManager.as:218-239`) → `SpaceActionsFactory.createAction` (`CM/map/space/SpaceActionsFactory.as:15-27`) | Reply to 8692 for node 18 and to 8994 op 1 | Starts `CollectionAction` on the node view if no other collection is running (`onCollectionId == 0`). Other movie types are ignored in the hub |
| S>C 4811 0x12cb `U_C_SELECT_NEW_YEAR_BOX_NODE` | `QueryCollectCampaignNodeRspMsg` (player): `collectCampaignNode (#1, CollectCampaignNodeMsg, repeated)`; each `mast_type (#1, INT32)`, `item (#2, INT32)`, `campaignDataId (#3, INT32)` node id, `son_type (#4, INT32)` sprite, `name (#5, STRING)` display name | `PlayerManager.__receiveYearNodeDataHandler` (`CM/yishi/manager/PlayerManager.as:182, 195-230`) | Reply to N3; push after a pile is collected or when piles respawn | Piles listed become active (`stateId 1`, sprite `son_type`, name shown, clickable); piles not listed become inactive (no sprite, not clickable) (`M3/map/space/view/physics/SpacePhysicsView.as:149-163, 190-197`) |
| S>C 125 0x007d `U_C_CAMPAIGN_CREATE` | `RoomCreatedMsg` | `BaseManager.__createCampaignHandler` | Reply to 8692 on the portal node 5 | Leaves the hub for the Ilha dos Einherjars (map 20001); owned by [../einherjar/README.md](../einherjar/README.md) |

## 5. Rules and formulas

### NI1 Node fields (`SpaceManager.readSpaceNodeInfo`, `CM/map/space/SpaceManager.as:344-398`)

| Template attribute | Node field | Meaning |
|---|---|---|
| `Id` | `nodeId`, `info.id` | node id sent in 8692/4601 |
| `NodeName` | `info.names` = part before the first comma; `funcType` = part after | display name; the function label is unused |
| `MasterType` | `info.types` | 61 dialog NPC, 171 portal, 40 spawn, 300 gift pile (`SpaceNodeType`, `CM/map/space/data/SpaceNodeType.as`) |
| `SonType` | `sonType` | sprite id (`mapmaterial/build/<SonType>.swf` or NPC avatar) |
| `NPCId` | `npcId` | unused here |
| `PosX`, `PosY` | `info.posX/Y`, `curPosX/Y` | cell |
| `FixX`, `FixY` | draw position in px for buildings |
| `BackPosX`, `BackPosY` | `resetPosX/Y` | unused in the hub |
| `MoveToMapId`, `MoveToNodeId` | portal destination (node 5: 20001 / 2000101) |
| `PatrolPos` | patrol path for MasterType 1 (none) |
| `NameColor`, `SizeType`, `Toward` | rendering |
| `Resource` | 1 = NPC avatar layer, otherwise building layer |
| `HandlerRange` | interaction radius in cells (0, 4 or 8) |
| `Dialogue` | dialog text; empty means "open the first option directly" |
| `Param1` | 2 = step-on portal (no snapping, auto trigger) |
| `Param3` | options, `"type,title,level|type,title,level|..."` |
| `Param4` | per option parameter, `|` separated, aligned with `Param3` (task id for type 7, unused for most) |
| `Param5` | story dialogues per option, `$` separated per option, `|` per step, `#` separates text and button label |
| `ItemExchange` | per option `"giveId,count#getId,count"`, `|` separated (type 107) |
| `Sort` | order in the map frame (0 → id) |

### NI2 Dialog option list (`SpaceDialogFrame.initOptions`, `SpaceDialogFrame.as:170-455`)

- Options come from `Param3` split by `|`, each parsed by `stringToObject` (`:462-489`) into `{optionType, optionTitle, optionLevel}`; `optionParam` = matching `Param4` entry.
- Injected options: ring task talk target with ring task type 16 adds `"11,Missão de Ciclo,35"` (`:215-222`); a marriage talk task targeting this node adds type 97 (`:223-227`).
- Hidden options: type 7 when the task does not exist, is completed, or is neither accepted nor available (an accepted task gets "(Em andamento)" appended); type 11 on node 17 while a ring task is active; type 90 when `marriangeState == 3`; type 23 when `canRideCar` is false; type 15 when `matchTransferCondition()` is false; type 104 when `matchChangeJobCondition()` is false; type 146 when `isShowAvengerItem()` is false; type 154 when `isShowFourTransferItem()` is false; type 152 when `VersionSwitch.SHADOW_LAND` is false; type 160 when task `WARSOUL_TOWER` is not finished; type 161 when task `FINAL_ROAD` is not finished; type 4 when `VersionSwitch.SAND_BOX` is false (`:239-386`).
- Node 22 (Andrew) options 17, 19, 20/91/92/93, 25, 21 are shown only when the marriage model allows them (`:396-438`).
- A final "Sair" (type 99) is always appended (`:491-497`).
- Type 13 titles get the treasure map counter "{0} (Quantidade de ganho {1} / {2})" (`:307-312`).
- Story options (type 7) step through `Param5` dialogues; after the last step a not accepted task is accepted (`TaskManage.requestAcceptTask`); a completed story with condition type 85 is marked `finishStory`, otherwise the client jumps to the task target (`:504-571`).

### NI3 Server answer to 8692 by node kind

| Node kind | Ids | Server reply | Validation |
|---|---|---|---|
| Dialog NPC (MasterType 61, `Dialogue` not empty) | 2, 3, 4, 6, 8, 10, 16, 17, 20, 21, 22, 23, 25, 28, 31, 32, 37, 39, 40, 41, 42, 43, 44, 45, 46, 48, 49, 50, 51, 52, 53, 54 | 4601 `{param1: id}` | player in the hub, within `HandlerRange + 5` cells of (`PosX`,`PosY`); node 32 only inside the new year window |
| NPC without dialogue, direct frame (MasterType 61) | 1 | 4601 | as above; the client checks `Param3` level (17) |
| Ring task plant | 18 | 143 `{movie_target_type 0, target_id 18, movie_type "COLLECTION"}` | ring task condition type 4 with `Para1 == 2100027` active and not complete (the client also checks) |
| Terralém gates | 35, 36 | 4601 | visible gate only (Terralém state, rule R12 in scene.md) |
| Gift piles (MasterType 300) | 30001..30020 | 4601 | pile active (listed in 4811) |
| Portal (MasterType 171, `Param1 = 2`) | 5 | 125 entering map 20001 at node 2000101 | level ≥ 50 (`Param3 = "50"`, assumption: the level is enforced server side because the client does not check it) |
| Spawn (MasterType 40) | 14 | none (never triggered) | |

### NI4 Option type enum (`DialogOptionItem`, `M3/map/space/view/frame/DialogOptionItem.as:58-234, 329-904`)

"Frame" = `FrameControllerManager.openControllerByInfo(key, openType)`. "Feature" = roadmap folder that owns the target.

| Type | Constant | Client action (line) | Extra client checks | Direct packet | Feature |
|---:|---|---|---|---|---|
| 1 | | frame `offerreward` (:351-360) | | | [../quests/README.md](../quests/README.md) |
| 2 | | frame `pveroomlist` (:351-360) | | | [../campaign/README.md](../campaign/README.md) |
| 3 | | frame `pvp` (Coliseu) (:351-360) | | | [../arena/README.md](../arena/README.md) |
| 4 | `VEHICLE` | `SandboxManager.requestState` (:361-370) | level ≥ 13 | 9670 `C_SAND_BOX_OP` | none (sandbox "Matança de Madrugada", unassigned) |
| 5 | | frame `auction` (:351-360) | | | [../auction/README.md](../auction/README.md) |
| 6 | | `SocketSendManager.enterPetLand(optionParam)` (:380-382) | | 8694 | [../einherjar/README.md](../einherjar/README.md) |
| 7 | `STORY_TASK` | story steps (NI2) | task availability | task accept | [../quests/README.md](../quests/README.md) |
| 8 | | frame `shop` openType 888 (:351-360) | | | [../shops/README.md](../shops/README.md) |
| 9 | `PET_PVP` | frame `petchallenge` openType 2 (:351-360) | | | [../einherjar/README.md](../einherjar/README.md) |
| 10 | | frame `shop` openType 11 (:351-360) | | | [../shops/README.md](../shops/README.md) |
| 11 | `RING_TASK` | `RingTaskManager.accessRingTask` on node 17, else dialog text change (:389-406) | level ≥ 35 ("Habilidade aberta no Nv. 35") | 8732 / 8729 / 8730 | [../quests/README.md](../quests/README.md) |
| 12 | `START_OFF` | jump to the ring task target (:407-413) | | | [../quests/README.md](../quests/README.md) |
| 13 | `TREASURE_MAP` | frame `treasuremap` openType 1 (:351-360) | | | [../treasures/README.md](../treasures/README.md) |
| 14 | `SINGLE_PASS` | `SkyboxRoadManager.getData` (:374-376) | | 8636 op 1 | [../trials/README.md](../trials/README.md) |
| 15 | `TRANSFER` | `PlayerManager.sendDragonSoulTransfer` (:421-427) | shown only if `matchTransferCondition` | 8643 `C_DRAGON_TRANSFER` | [../hero/README.md](../hero/README.md) |
| 16 | `MOLONG` | `MolongSocketOut.clickMolongMap` (:428-430) | | Molong entry | [../world-boss/README.md](../world-boss/README.md) (assumption) |
| 17 | `MARRY_QUALITY` | wedding ceremony quality frame (:431-437) | marriage model | | [../marriage/README.md](../marriage/README.md) |
| 19 | `ENTER_WEDDING` | wedding room list (:466-472) | marriage model | | [../marriage/README.md](../marriage/README.md) |
| 20 | `MARRY_DIVORCE` | shows 92/93/91 sub options (:473-478) | | | [../marriage/README.md](../marriage/README.md) |
| 21 | `ACCEPT_MARRY_TASK` | `MarrySender.opMarryTask(2001)` (:538-544) | married | 8774 op 2001 | [../marriage/README.md](../marriage/README.md) |
| 22 | `HOOK` | frame `hook` (:371-373) | | | [../castle/README.md](../castle/README.md) |
| 23 | `RIDE_MARRY_CAR` | `MarrySender.rideHorse` (:581-587) | `canRideCar` | 8759 op 7 | [../marriage/README.md](../marriage/README.md) |
| 25 | `HEART_QUESTION` | "Apaixonados" quiz confirm (:558-580) | team with the partner, captain only | marriage quiz | [../marriage/README.md](../marriage/README.md) |
| 26 | `MONOPOLY` | `MonopolySocketOutManager.sendEnterCampaign` (:609-611) | | 8823 | [../casino/README.md](../casino/README.md) |
| 27 | `CHILD` | `ChildManager.checkForExchangeChild` (:620-622) | | guardian summon | [../guardians/README.md](../guardians/README.md) |
| 29 | `CHILD_HAND_IN` | guardian hand-in frame (:623-632) | has a guardian | | [../guardians/README.md](../guardians/README.md) |
| 33 | `LIFESKILL` | frame `store` tab `SKILL` (:612-619) | level ≥ 35 | | [../smith/README.md](../smith/README.md) |
| 36, 37, 38 | `BIRTHDAY_*` | birthday wish, activity, reward (:642-646) | event | | [../seasonal-events/README.md](../seasonal-events/README.md) |
| 90 | `MARRY_PROPOSE` | propose frame (:438-465) | free team of 2, captain | | [../marriage/README.md](../marriage/README.md) |
| 91, 92, 93 | `MARRY_DIVORCE3/1/2` | divorce alerts (:479-537) | married; 93 requires team captain | divorce | [../marriage/README.md](../marriage/README.md) |
| 94 | `OPEN_BAG` | army equip panel (:588-598) | | | [../inventory/README.md](../inventory/README.md) |
| 95 | `GO_NOW` | jump to the marriage task target (:599-608) | | | [../marriage/README.md](../marriage/README.md) |
| 96 | `MARRY_TASK_COMPONENT` | `MarrySender.opMarryTask(2005)` (:551-557) | | 8774 op 2005 | [../marriage/README.md](../marriage/README.md) |
| 97 | `MARRY_TASK` | marriage talk task step (:545-550) | | | [../marriage/README.md](../marriage/README.md) |
| 98 | `COMPONENT_TASK` | ring task talk complete event (:414-420) | | quests | [../quests/README.md](../quests/README.md) |
| 99 | `LEAVE` | close the dialog | | | here |
| 100 | `OUTERCITYSHOP` | frame `outercityshop` (:633-641) | level ≥ 26 ("Função ativada no Nv. 26") | | [../shops/README.md](../shops/README.md) |
| 101 | `REMOTEPET` | `remotePetController` type 1 first time, else 2 (:647-666) | level ≥ 50 (message says 60); server hour in [1, 23) | | [../einherjar/README.md](../einherjar/README.md) |
| 102 | `CHILDPVE` | frame `childpve` (:667-674) | level ≥ 70 | | [../guardians/README.md](../guardians/README.md) |
| 103 | `CHILDARENA` | `SwitchPageHelp.gotoChildArenaFrame` (:675-677) | level ≥ 70, has guardian | | [../guardians/README.md](../guardians/README.md) |
| 104 | `CHANGE_JOB` | frame `changejob` (:678-680) | shown only if `matchChangeJobCondition` | | [../hero/README.md](../hero/README.md) |
| 105 | `CHILD_PATROL` | frame `childpatrol` openType 1 (:681-697) | level ≥ 70, has guardian, `checkScene` | | [../guardians/README.md](../guardians/README.md) |
| 106 | `HOLIDAY_CAMPAIGN_ENTER` | `CampaignSocketOutManager.sendEnterActiveVehicle` (:698-709) | new year window, `checkScene` | 9587 | [../seasonal-events/README.md](../seasonal-events/README.md) |
| 107 | `HOLIDAY_GOODS_EXCHANGE` | route N6 (:710-722) | new year window, items | 9586 | [../seasonal-events/README.md](../seasonal-events/README.md) |
| 108 | `GLORY_ROAD` | frame `gloryroad` (:723-730) | level ≥ 15 | | [../roads/README.md](../roads/README.md) |
| 109 | `RAPID_THROUGH` | `RapidThroughPassManager.requestEnterRapidPass` (:731-742) | level ≥ 36, `checkScene` | rapid pass entry | [../trials/README.md](../trials/README.md) |
| 110 | `RAPID_RANK` | frame `rapidthrough` openType 1 (:743-751) | level ≥ 36 | | [../trials/README.md](../trials/README.md) |
| 111 | `GAME_BOX` | frame `gamebox` (:752-760) | level ≥ 28 | | [../time-story/README.md](../time-story/README.md) |
| 112 | `ALCHEMICAL` | `openAlchemicalFrame` → frame `alchemical` (:761-763) | needs class advancement | | [../alchemy/README.md](../alchemy/README.md) |
| 113 | `CHILD_ESAL` | `openChildEsalFrame` → frame `childesal` (:764-766) | needs class advancement | | [../guardians/README.md](../guardians/README.md) |
| 114 | `FASHION_BOX` | `openFashionBoxFrame` (:767-769) | level ≥ 10 | | [../fashion/README.md](../fashion/README.md) |
| 115 | `MOUNT_BOX` | `openMountBoxFrame` (:770-772) | level ≥ 16 | | [../mounts/README.md](../mounts/README.md) |
| 117 | `LORD_TRIAL` | frame `lordtrial` 0 (:773-775) | class advancement, not in outer city, activity open | | [../trials/README.md](../trials/README.md) |
| 118 | `TITAN_TEMPLE` | frame `outyard` 9 (:776-778) | class advancement, time window | | [../outyard/README.md](../outyard/README.md) |
| 119 | `SHUTTLE` | frame `outyard` 10 (:779-781) | class advancement | | [../outyard/README.md](../outyard/README.md) |
| 130 | `ABYSM` | frame `abysm` 7 (:782-784) | class advancement, has guardian | | [../abyss/README.md](../abyss/README.md) |
| 131 | `TIMEVORTEX` | frame `timevortex` 1 or 0 (:788-790) | class advancement | | [../trials/README.md](../trials/README.md) |
| 132 | `PLANE_CRISIS` | crisis enter frame (:791-793) | `VersionSwitch.PLANE_CRISIS_OPEN` | | [../trials/README.md](../trials/README.md) |
| 133 | `ECLIPTIC_PALACE` | frame `eclipticpalace` `MAIN_FRAME` (:794-796) | class advancement | | [../ecliptic-palace/README.md](../ecliptic-palace/README.md) |
| 134 | `DEMON_LAND` | frame `demonland` 1 (:797-799) | class advancement | | [../trials/README.md](../trials/README.md) |
| 135 | `GAME_HALL` | frame `gamehall` (:800-802) | | | [../casino/README.md](../casino/README.md) |
| 136 | `MONSTER_EXPLORE` | frame `monsterexplore` (:803-805) | level ≥ 70, task | | [../exploration/README.md](../exploration/README.md) |
| 137..144 | `PERSONAL_PARTY` .. `GAME_POKER` | air garden party actions (:806-829) | | | [../seasonal-events/README.md](../seasonal-events/README.md) |
| 145 | `REVENGE_ROAD` | frame `revengeroad` (:830-832) | | | [../roads/README.md](../roads/README.md) |
| 146 | `AVENGER_TASK` | `PlayerManager.sendAvengerTransfer` (:833-839) | shown only if `isShowAvengerItem` | 8658 `C_THIRD_TRANSFER` | [../avenger/README.md](../avenger/README.md) |
| 147 | `REDEMPTION_ROAD` | frame `redemptionroad` (:840-842) | | | [../roads/README.md](../roads/README.md) |
| 148 | `HELL_ABYSM` | hell abyss frame (:843-845) | class advancement, guardian | | [../abyss/README.md](../abyss/README.md) |
| 149 | `INCREASINGLY_ROAD` | `SwitchPageHelp.openIncreasinglyRoad` → `IncreasinglyRoadManager.getData` (:377-379) | not in a team | | [../roads/README.md](../roads/README.md) |
| 150 | `SPIRIT_EXPEDITION` | spirit expedition frame (:846-848) | | | [../guardians/README.md](../guardians/README.md) |
| 151 | `YL_EXPEDITION` | YL expedition frame (:849-851) | | | [../guardians/README.md](../guardians/README.md) |
| 152 | `SHADOW_LAND` | shadow land frame (:852-854) | `VersionSwitch.SHADOW_LAND` | | [../trials/README.md](../trials/README.md) |
| 153 | `DARK_MAZE_SHOP` | frame `shop` 1023 (:855-857) | class advancement | | [../mazes/README.md](../mazes/README.md) |
| 154 | `HOLY_TASK` | `PlayerManager.sendFourTransfer` (:858-864) | shown only if `isShowFourTransferItem` | 8663 `C_FOURTH_TRANSFER` | [../hero/README.md](../hero/README.md) |
| 155 | `REMAINS_EXPLORE` | remains explore frame (:865-867) | | | [../exploration/README.md](../exploration/README.md) |
| 156 | `ROYALTY_BOSS` | frame `royaltyboss` (:868-870) | class advancement, task `ROYALTY_BOSS_TASK` | | [../royalty-boss/README.md](../royalty-boss/README.md) |
| 157 | `POSEIDON_SHOP` | frame `poseidonshop` (:871-873) | level from config | | [../shops/README.md](../shops/README.md) |
| 158 | `FORBIDDEN_BOSS` | frame `forbiddenboss` (:874-876) | class advancement, time window | | [../forbidden-boss/README.md](../forbidden-boss/README.md) |
| 159 | `SECRET_EXPLOR` | secret exploration (:877-879) | not in outer city | | [../exploration/README.md](../exploration/README.md) |
| 160 | `WARSOULTOWER` | frame `warsoultower` (:880-882) | class advancement, task `WARSOUL_TOWER` | | [../trials/README.md](../trials/README.md) |
| 161 | `FINALROAD` | frame `finalroad` (:883-885) | class advancement, task `FINAL_ROAD` | | [../roads/README.md](../roads/README.md) |
| 162 | `GOD_PVP` | frame `godpvpenter` (:886-888) | | | [../arena/README.md](../arena/README.md) |
| 163 | `CHILD_NS_WAR` | guardian war (:889-891) | class advancement | | [../guardians/README.md](../guardians/README.md) |
| 165 | `THESS_TOWER` | frame `thesstower` `ThessTowerFrame` (:892-894) | class advancement | | [../theseus/README.md](../theseus/README.md) |
| 166 | `THESS_BOX` | frame `thessbox` `ThessBoxMainFrame` (:895-897) | class advancement | | [../theseus/README.md](../theseus/README.md) |
| 167 | `DUNGEONEXPLO` | frame `dungenexplo` 1 (:785-787) | | | [../exploration/README.md](../exploration/README.md) |
| other | | runs `nextStep` (closes) (:898-903) | | | |

### NI5 Direct frames for nodes without dialogue (`SpaceArmyViewHelper.getNodeFrameName`, `:181-238`)

| Type | Frame | openType |
|---:|---|---|
| 1 | `offerreward` | none |
| 2 | `pveroomlist` | none |
| 3 | `pvp` | none |
| 4 | `vehicleroomlist` | none |
| 5 | `auction` | none |
| 8, 10 | `shop` | 888, 11 |
| 9 | `petchallenge` | 2 |
| 13 | `treasuremap` | 1 |
| 14 | `skyboxroad` | none |
| 135 | `antaeus` | none |

### NI6 Other rules

| # | Rule | Source |
|---|---|---|
| NI6a | Leaving range closes dialogs and node frames (distance > 2 × `HandlerRange`). | `M3/map/space/mediator/hero/SpacePlayerWalkMediator.as:150-193` |
| NI6b | Clicking a new node closes the dialog and frames of the previous one. | `SpaceArmyViewHelper.as:69-84` |
| NI6c | Collection: one at a time (`onCollectionId`); cancelled when the hero stops standing, on a click outside the node, or when a PvP fight lock arrives. | `CollectionAction.as:150-166, 290-296, 340-428` |
| NI6d | Gift piles: only piles listed by 4811 are drawn and clickable; their sprite and name come from 4811. | `PlayerManager.as:195-230`, `SpacePhysicsView.as:149-163, 190-197` |
| NI6e | Cross map route: `SwitchPageHelp.walkToCrossMapTarget` walks 10000 → node 5 → 20001 → ... automatically; special case 10000 → 9995 (Sala de Sacrifício) via node 99, which is not in the template. | `CM/yishi/SwitchPageHelp.as:960-1060`, `CM/yishi/actions/map/crossmapsearch/CrossMapSearchActionQueue.as:26-116` |

## 6. Templates

| File | Record | Fields |
|---|---|---|
| `raw/xml/tempinfos/MapNodeInfos.xml` | `MapNodeInfo` (58 rows) | all of NI1 |
| `raw/xml/tempinfos/QuestTemps.xml`, `QuestCondictionInfos.xml` (quests) | tasks 757, 1100, 1389, 1390, 1391, 1912, 1925, 1926, 1936, 1944, 1965 referenced by `Param4` | owned by [../quests/README.md](../quests/README.md) |
| `raw/xml/tempinfos/ConfigInfos.xml` | `NEW_YEAR_*` comes from `config.xml` (client config), not templates | |

## 7. Persistent state

```sql
CREATE TABLE sky_realm.gift_pile_state (
    node_id        INTEGER PRIMARY KEY CHECK (node_id BETWEEN 30001 AND 30020),
    active         BOOLEAN NOT NULL DEFAULT FALSE,
    son_type       INTEGER NOT NULL DEFAULT 10031,
    display_name   TEXT NOT NULL DEFAULT 'Pilha de Presentes',
    item_id        INTEGER,
    respawn_at     TIMESTAMPTZ
);

CREATE TABLE sky_realm.gift_pile_claims (
    player_id      BIGINT NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
    node_id        INTEGER NOT NULL REFERENCES sky_realm.gift_pile_state(node_id),
    claimed_on     DATE NOT NULL,
    claimed_at     TIMESTAMPTZ NOT NULL DEFAULT now(),
    PRIMARY KEY (player_id, node_id, claimed_on)
);

CREATE TABLE sky_realm.collection_sessions (
    player_id      BIGINT PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
    node_id        INTEGER NOT NULL,
    kind           TEXT NOT NULL CHECK (kind IN ('ring_task_plant','gift_pile')),
    started_at     TIMESTAMPTZ NOT NULL DEFAULT now()
);
```

Gift pile rewards, respawn timers and daily limits are owned by [../seasonal-events/README.md](../seasonal-events/README.md); the tables above hold only the hub side state. Exchange limits of type 107 (if any) belong to seasonal events.

## 8. Backend implementation notes

- `sky_realm::npc_interaction::handle_node_trigger` (8692): load the node from the template cache (`MapNodeInfos` where `MapId = 10000`); reject unknown ids. Check presence and distance (`HandlerRange + 5` cells, using the last stored cell). Dispatch by NI3. For node 18 also call `quests::ring_task::can_collect(player, item 2100027)` and open a `collection_sessions` row; reply 143. For the portal call `einherjar::pet_land::enter(player, map 20001, node 2000101)` after the level 50 check.
- `sky_realm::npc_interaction::handle_collection_finished` (8733): require an open `collection_sessions` row for that node with `now - started_at ≥ 2 s` (assumption: minimum gather time); delete the row; call `quests::ring_task::on_collect`.
- `sky_realm::npc_interaction::handle_year_box` (8994): `param1 = 3` reply 4811 with active piles; `param1 = 1` check level ≥ 35, pile active, not yet claimed today, open a session, reply 143 `COLLECTION` with `target_id = param2`; `param1 = 2` close the session, grant the reward (seasonal events), mark the claim, deactivate the pile if it is single use (assumption) and push 4811 to every hub player.
- `sky_realm::npc_interaction::handle_item_exchange` (9586): delegate to `seasonal_events::holiday::exchange(player, node_id, option_index)` which parses `ItemExchange` of that node and option.
- Programmatic open: `sky_realm::npc_interaction::push_open_node(player, node_id)` sends 4601 (used by quests to show an NPC after a walk).

## 9. Open questions and assumptions

- The exact server answer for each node kind (NI3) is inferred from the client handlers; the original server is not available.
- Assumption: the level 50 of the portal and the level 17 of node 1 are also enforced server side.
- Collection minimum time and pile respawn rules are unknown.
- `Param4` of node 8 (Lara, "|1926") and node 48 (Tau Estranho, "|1936") are misaligned with `Param3` (node 8 has no option at all; node 48's only option gets an empty parameter), so their story tasks never appear in the dialog. Reproduce as is.

## 10. Implementation checklist

- [ ] Template cache of `MapNodeInfos` (map 10000) on the server
- [ ] Route N1 8692 `handle_node_trigger` with NI3 dispatch
- [ ] Route N2 8733 `handle_collection_finished`
- [ ] Routes N3, N4, N5 8994 `handle_year_box` (ops 3, 1, 2)
- [ ] Route N6 9586 `handle_item_exchange` (delegated)
- [ ] Server message 4601
- [ ] Server message 143 `COLLECTION`
- [ ] Server message 4811
- [ ] Portal 125 through einherjar
- [ ] Tables `gift_pile_state`, `gift_pile_claims`, `collection_sessions`
- [ ] Test: every dialog NPC opens its dialog (NI3 list)
- [ ] Test: node 1 opens "Recompensa" directly at level ≥ 17
- [ ] Test: gift pile collect flow 8994(3) → 4811 → 8692 → 4601 → 8994(1) → 143 → 8994(2)
