# Castle scene

Aliases: see [README.md](README.md). Extra aliases:

| Alias | File |
|---|---|
| CSV | `decompiled/m4/scripts/castle/CastleSceneView.as` |
| CMV | `decompiled/m4/scripts/castle/view/CastleMapViewII.as` |
| NPC | `decompiled/m4/scripts/castle/view/CastleNPCView.as` |
| DLG | `decompiled/m4/scripts/castle/view/CastleDialogView.as` |
| BB | `decompiled/m4/scripts/castle/view/BuildingBase.as` |
| SSM | `decompiled/core_module/scripts/yishi/service/managers/SocketSendManager.as` |
| SCM | `decompiled/core_module/scripts/yishi/scene/SceneManager.as` |

## 1. Overview

The castle scene renders the player castle: a background map, every building the server sent (except technologies and the Transmissor row), five client side pseudo buildings, one walking guard NPC with dialog lines, and animated "has operation" bubbles over buildings. Clicking a building opens its frame or sends the player to another feature. Entering the scene shows the full HUD ([hud.md](hud.md)) and, when the player comes back from a battle of another feature, reopens that feature screen.

The scene itself has a single server route (8747). Everything else on the map is driven by the building list ([buildings.md](buildings.md)) and by state owned by other features.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `castle.CastleSceneView` (CSV) | none (scene `CASTLE_SCENE`) | Host scene; shows HUD bars on `enterOver` (`CSV:88-110`), hides them on `leaving` (`CSV:394-420`); plays music "castle"; reopens feature screens from `_preSceneData` (`CSV:111-366`) | `SceneManager.setScene("CASTLE_SCENE")` | HUD, castle map |
| `castle.view.CastleMapViewII` (CMV) | none | Draggable map (drag after 300 ms hold, click under 300 ms, `CMV:210-238`), arrow key panning 50 px (`CMV:144-170`), layers background, walk, air, fog border (`CMV:60-69`) | scene enter | buildings, NPC |
| `castle.view.layer.CastleWalkLayer` (CWL) | none | Places buildings at `PosX/PosY`, adds pseudo buildings, NPC, bubbles, depth sorting by y every frame (`CWL:464-494`) | map | building views |
| `castle.view.CastleBuildingView` (CBV) | building name and "Nv. N" label (`BB:153-185`, position `TitleX/TitleY`) | One building; tooltip, gray filter when locked, click dispatch | map | `BuildingTempInfos` row of the instance |
| `castle.view.CastleNPCView` (NPC) | dialog title per NPC type (DLG) | Walking NPC, cycles 4 dialog lines per click (`NPC:151-187`) | walk layer | pt-BR lines |
| `castle.view.CastleDialogView` (DLG) | NPC name | Speech bubble | NPC click | one line |

### Buildings on the map

Server buildings are drawn by `CWL.initBuild` for every `BuildInfo` whose `MasterType` is not 13 or 14 (`CWL:125-137`); `updateBuildingView` skips `SonType 1511` (`CWL:143-146`). The art comes from `PicPath = "swf|viewClass|effectClass"` loaded from `RESOURCE_PATH` (`decompiled/m4/scripts/castle/loader/CastleBuildingLoader.as:19-48`).

| Building | SonType | Id | Source | Template | Position (PosX, PosY) | SWF |
|---|---|---|---|---|---|---|
| Prefeitura | 901 | server | 4154 / 4130 | 90101..90180 | 285, 17 | `images/neizhengting.swf` |
| Quartel | 402 | server | 4154 / 4130 | 40201..40280 | 821, 237 | `images/binyin.swf` |
| Santuário | 501 | server | 4154 / 4130 (from Leader 18) | 50101..50180 | 700, 64 | `images/shenxueyuan.swf` |
| Transmissor | 1511 | -11 | client, created on 4153 (`LIDA:840-844`), drawn by `createTransferBuild` (`CWL:228-243`) | 151101 | 590, 327 | `images/chuansong.swf` |
| Labirinto | 1507 | -7 | client (`CWL:296-311`) | 150701 | 249, 429 | `images/wuxianta.swf` |
| Residência | 1509 | -9 | client (`CWL:279-294`) | 150901 | 1000, 170 | `images/home.swf` |
| Bar da Fantasia | 1601 | -28 | client (`CWL:245-260`) | 160101 | 495, 442 | `images/mofalvguan.swf` |
| Laboratório de Platina | 1701 | -29 | client (`CWL:262-277`) | 170101 | 77, 239 | `images/bojinshiyanshi.swf` |

When the Santuário does not exist yet the layer draws a gray placeholder "Seminário" with tooltip "Função habilitada no Nv. 18" (`CWL:194-226`). Pseudo buildings are rebuilt on every Leader level up (`CWL:431-435`).

SonTypes 1501..1506, 1508, 1510, 101, 301, 1201, 1801 have click and tooltip code but no `BuildingTempInfos` row in this build, so they never appear. 1501, 1502, 1503, 1506, 1508, 1510 are treated as decoration (`CBV:65-79`).

## 3. Routes (client to server)

### R1. Enter the castle scene

- UI: any call to `SceneManager.setScene("CASTLE_SCENE")` (HUD castle buttons, return button, login), also `"FARM"` (true) and `"SPACE_SCENE"` (false) (`SCM:169-181`).
- Sender: `SocketSendManager.enterCastle(inCastle)` (`SSM:529-535`).
- Client checks: none.
- Route: C>S 8747 (0x222b) `C_ENTER_CASTLE`.
- Request `simple.PropertyMsg` (field numbers from `decompiled/core_module/scripts/com/road/yishi/proto/simple/PropertyMsg.as:333-337`, the name collides with `army.PropertyMsg` in `proto.json`): `param7 (#7, BOOL)` = true when entering the castle or the farm, false when entering the sky realm. Other fields unset.
- Response: none expected by the client. Server records the player location (castle or sky realm) for presence. Assumption: used by the sky realm to hide or show the avatar and by "other players" visibility.

### R2. Building click

Local dispatch, no request by itself. `CMV.castleMapClick` (`CMV:231-238`) calls `CBV.mouseClickHandler` (`CBV:276-402`):

1. Decoration SonTypes return (`CBV:278-281`).
2. Bot mode active: tip "Modo Bot em andamento" and stop (`CBV:284-289`, see [../mopup/README.md](../mopup/README.md)).
3. Switch on `SonType`:

| SonType | Building | Gate (client) | Locked tip | Action | Owner |
|---|---|---|---|---|---|
| 901 | Prefeitura | none | | `openControllerByInfo("politics", null, info)` > `PoliticsFrame` | [levy.md](levy.md), [buildings.md](buildings.md) |
| 402 | Quartel | none | | `"casern"` > `CasernFrame` | [buildings.md](buildings.md), [../army/README.md](../army/README.md) |
| 501 | Santuário | none | | `"seminary"` > `SeminaryFrame` | [technologies.md](technologies.md) |
| 1511 | Transmissor | Leader >= 15 | "Transmissor não ativado!" | `"transferbuilding"` > `TransferBuildFrame` (`CBV:362-370`) | [transmitter.md](transmitter.md) |
| 1507 | Labirinto | Leader >= 12 | "Labirinto não está aberto!" | `"maze"` > `MazeFrame` (`CBV:325-333`) | [../mazes/README.md](../mazes/README.md) |
| 1509 | Residência | Leader >= 12 | "Fazenda não ativado!" | `"farm"`, `"CastleBuildingView.FarmEnterNewFrame"` (`CBV:343-350`) | [../farm/README.md](../farm/README.md) |
| 1601 | Bar da Fantasia | Leader >= 32 | "Hotel de Magia não ativado!" | `"magiccard"` (`CBV:380-388`) | [../magic-cards/README.md](../magic-cards/README.md) |
| 1701 | Laboratório de Platina | `vocationGrades > 0` | "Laboratório de Platina não ativado!" | `"perkinlab"` (`CBV:389-397`) | [../laboratory/README.md](../laboratory/README.md) |
| 1801 | Mina de Ametistas | Leader >= 25 | "Mina de Ametista não ativado!" | `"minefield"` (no row, never shown) | `mineField` package, assumption [../mines/README.md](../mines/README.md) |
| 1501 | Ferreiro | Leader >= 7 | "Ferreiro não está aberto!" | `storeController.startFrameByType("STORE_PANEL_INTENSIFY")` (no row) | [../smith/README.md](../smith/README.md) |
| 1503 | Coliseu | Leader >= 16 | "Arena não está aberta!" | `SwitchPageHelp.goSpaceAndFind(6)` (no row) | [../arena/README.md](../arena/README.md) |
| 1502 | Portal dos Heróis | Leader >= 20 | "Mapa Multiplayer não está aberto!" | `goSpaceAndFind(2)` (no row) | [../campaign/README.md](../campaign/README.md) |
| 1510 | Centro de Recompensas | none | | `goSpaceAndFind(1)` (no row) | [../quests/README.md](../quests/README.md) |
| 1506 | Mercado | none | | `goSpaceAndFind(8)` (no row) | [../auction/README.md](../auction/README.md) |
| 1504 | Santuário (hang up) | none | | `"hook"` (no row) | [hook.md](hook.md) |
| 1505 | Artilharia TM | Leader >= 35 | "Artilharia TM não aberta!" | `"vehicledaimon"` (no row) | [../artillery/README.md](../artillery/README.md) |
| 1508 | (reserved) | | "Função será aberta em breve!" | none | none |
| 101, 301, 1201 | legacy furnace, warehouse, houses | | | none | none |
| other | by `MasterType` | | | `BuildingControler.getModelNameByInfo` (`decompiled/core_module/scripts/mvc/controler/BuildingControler.as:18-50`): 1 crystal, 4 casern, 5 and 13 seminary, 8 transferbuilding, 9 politics, 10 titan, 11 market, 12 residence, 15 offerreward, 16 and 18 magiccard, 17 perkinlab | |

`goSpaceAndFind(n)` moves the player to the sky realm and walks to NPC n ([../sky-realm/README.md](../sky-realm/README.md)).

Locked state (`CBV.isNotOpen`, `CBV:469-472`): 1511 below 15, 1507 and 1509 below 12, 1801 below 25, 1601 below 32, 1701 without class advancement. Locked buildings are gray, not clickable, and the tooltip reads "Função habilitada no Nv. {N}" or "Avanço de Profissão não ativado!" (`CBV:205-237`).

### R3. NPC click

Local only. Each click shows the next of 4 lines in a speech bubble; a second click on an open bubble closes it (`NPC:151-187`).

## 4. Server messages (server to client)

The scene listens to no opcode directly. It reacts to `BuildingManager` events raised by 4130 ([buildings.md](buildings.md)):

| Event | Source | Scene reaction |
|---|---|---|
| `CREATE_NEW_BUILDING` | 4130 with an unknown `building_id` (`BM:152-156`) | Draws the building; if `newbieProcess >= 21000` pans the camera to it and plays the build effect (`CMV:270-291`). Ignored for MasterType 13 and 14 |
| `BUILDING_UPGRADE_RECEIVE` | 4130 with a known `building_id` (`BM:157-160`) | Sound "010", redraws with the level up effect (`CMV:260-268`, `CBV:556-581`). Ignored for MasterType 13 and 14 |
| `THANE_LEVEL_UPDATE` | hero level push ([../hero/README.md](../hero/README.md)) | Rebuild pseudo buildings and bubbles (`CWL:431-435`) |

## 5. Rules and formulas

### Operation bubbles

Animated icons over buildings, refreshed on depth sort and on level up (`CWL:496-531`):

| Bubble | Map position | Visible when | Owner |
|---|---|---|---|
| `castle.gold` (taxes) | 453, 135 | Prefeitura exists, `property2 - property1 > 0` and Leader >= 14 (`CWL:552-560`) | [levy.md](levy.md) |
| `castle.seminary` | 790, 145 | Santuário level > 0 and the job attack technology (1441/2441 for jobs 1, 2, 4, 5; 1442/2442 for jobs 3, 6) has a next level whose `CrystalsConsume` <= crystals (`CWL:54-61`, `CWL:609-646`) | [technologies.md](technologies.md) |
| `castle.dye` | 222, 283 | `vocationGrades > 0` and laboratory has something to pick (`CWL:562-565`) | [../laboratory/README.md](../laboratory/README.md) |
| `castle.rob` | 122, 283 | `vocationGrades > 0` and `perkin_lab_rob_count - robCount > 0` (`CWL:567-576`) | [../laboratory/README.md](../laboratory/README.md) |
| `castle.maze` | 390, 440 | free tower entries left (`CWL:583-607`) | [../mazes/README.md](../mazes/README.md) |
| `castle.magicHotel` | 614, 442 | Leader >= 32 and `MagicPubManager.canChatCount() > 0` (`CWL:662-669`) | [../fantasy-bar/README.md](../fantasy-bar/README.md) |
| `castle.pick` | 1130, 190 | farm has crops to pick (`CWL:671-674`) | [../farm/README.md](../farm/README.md) |
| `castle.catHouse` | 1130, 190 | cat toys to harvest (`CWL:676-679`) | [../cat-house/README.md](../cat-house/README.md) |

### NPCs

Only NPC type 4 is spawned (`CWL:319-326`); `createCampaignNpc` and `createBuildNpc` (`CWL:328-366`) are never called. Lines are pt-BR keys `castle.view.CastleNPCView.dialogDic*` (`NPC:78-121`). Names from `castle.view.CastleDialogView.*` (`DLG:121-136`, switch on `type - 1`).

| Type | Name | Lines (keys) | Spawned |
|---|---|---|---|
| 1 | "Florista" | `dialogDicFlowerWomen1..4` | no |
| 2 | "Tina" | `dialogDicFlaman1..4` | no |
| 3 | "Glorya" | `dialogDicWarriorWomen1..4` | no |
| 4 | "Guarda" | `dialogDicSoldier1..4`, for example "Grande Líder, poder lutar ao seu lado é minha honra, lutarei por você até a morte!" | yes, path from `AiPlayerConfig.getPathByType(4)`, speed 0.7 |
| 5 | "Mercante" | `dialogDicBussinessman1..4` | no |
| 6 | "Plebeia" | `dialogDicDinluo1..4` | no |
| 7 | "Chefe dos Guardas Randy" | `dialogDicSoldierLeader1..4` | no |
| 8 | "Mineiro" | `dialogDicDrudgrey1..4` | no |

NPC art: `swf/castle/npc/castleNpc.swf`, symbols `asset.castle.Npc_<direction>_<type>` (`CWL:313-317`, `CWL:392-402`).

### Post battle reopen

`enterOver` reopens the screen of the feature the player came from, based on flags the battle result sets in the scene data (`CSV:111-366`). Server impact: none; each owning feature sets its flag client side. Flags and targets: `isOpenColosseum` colosseum ([../arena/README.md](../arena/README.md)), `isOpenPveRoomList` pveroomlist ([../campaign/README.md](../campaign/README.md)), `isOpenPvpRoomList` pvproomlist, `isOpenVehicle` vehicledaimon ([../artillery/README.md](../artillery/README.md)), `isOpenPetChallenge` petchallenge 2 and `isOpenRemotePet` ([../einherjar/README.md](../einherjar/README.md)), `isOpenPetMaze2` maze 2 ([../mazes/README.md](../mazes/README.md)), `isOpenChildPve`, `isOpenChildArena`, `isExpeditionBattle`, `isYLExpidtionBattle` ([../guardians/README.md](../guardians/README.md)), `isGloryRoadBattle`, `isOpenRevengeRoad`, `isOpenRedemptionRoad`, `isFinalRoadBattle` ([../roads/README.md](../roads/README.md)), `isOpenPerkinLab` ([../laboratory/README.md](../laboratory/README.md)), `isOutyardBattle`, `isOutyardExploreBattle`, `isTitanTempleBattle`, `isShuttleBattle` ([../outyard/README.md](../outyard/README.md)), `isCrossBraveBattle` ([../athena-battle/README.md](../athena-battle/README.md)), `isAbysmBattle` ([../abyss/README.md](../abyss/README.md)), `isLordTrial`, `isDragonTalker`, `isOpenTimeVortex`, `isOpenDemonLand`, `isShadowLandBattle`, `isWarSoulTowerBattle` ([../trials/README.md](../trials/README.md)), `isOpenEclipticPalace` ([../ecliptic-palace/README.md](../ecliptic-palace/README.md)), `isOpenGameHall` ([../casino/README.md](../casino/README.md)), `isMonsterExplore`, `isRemainsExploreBattle`, `isSecretAdventure`, `dungeonexplo` ([../exploration/README.md](../exploration/README.md)), `isOpenDreamArena` ([../arena/README.md](../arena/README.md)), `isMinosMap`, `chesspvp`, `isConsortiaNewBossBattle` ([../guild/README.md](../guild/README.md)), `isSecretwarResult`, `isOpenStararea` ([../hermitage-war/README.md](../hermitage-war/README.md)), `isRoyaltyBossBattle` ([../royalty-boss/README.md](../royalty-boss/README.md)), `thesetower`, `thessbox` ([../theseus/README.md](../theseus/README.md)).

Other side effects on enter: farm harvest tip, guardian patrol tip, better equipment tip, "Destino" notice at Leader >= 55 when `showVersion`, template cache save when Leader > 6, hero road popup (`CSV:367-386`).

## 6. Templates

| File | Record | Fields used here |
|---|---|---|
| `raw/xml/tempinfos/BuildingTempInfos.xml` | one level of one building | `SonType`, `MasterType`, `BuildingName`, `BuildingGrade`, `PosX`, `PosY`, `TitleX`, `TitleY`, `PicPath`, `Icon` (see [buildings.md](buildings.md)) |
| `raw/xml/tempinfos/UpGradeTempInfos.xml` | Leader level curve, `Types = 3` | `Grades = 18`, `ActiveObject = 50101`: Santuário unlock |

## 7. Persistent state

No table of its own. Reads `castle.buildings` ([buildings.md](buildings.md)). Presence flag from R1:

```sql
CREATE TABLE castle.presence (
    player_id   bigint      PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
    in_castle   boolean     NOT NULL DEFAULT true,
    updated_at  timestamptz NOT NULL DEFAULT now()
);
```

Assumption: this can live in memory (session state) instead of a table; it is listed for completeness.

## 8. Backend implementation notes

- `castle::scene::handle_enter` (8747): decode `simple.PropertyMsg`, store `param7` in the session (and optionally `castle.presence`). No response.
- The scene needs, at login, 4153 (Transmissor energy, castle name and position) and 4154 (buildings) before the client finishes loading ([buildings.md](buildings.md), [transmitter.md](transmitter.md)); and the first 109 after the client sends 5015 ([resources.md](resources.md)).
- Never send a `BuildingInfoMsg` with `son_type 1511` or a negative `building_id`.

## 9. Open questions and assumptions

- Assumption: 8747 has no response and only tracks presence.
- Assumption: buildings without template rows (1501..1506, 1508, 1510, 1801, 101, 301, 1201) are never created by the server in this build.
- Open: the walking NPC path comes from `AiPlayerConfig` (client data); no server impact.

## 10. Implementation checklist

- [ ] `castle::scene::handle_enter` (8747) accepts `param7` and updates presence.
- [ ] Castle renders Prefeitura, Quartel, Santuário (after Leader 18) and the five pseudo buildings.
- [ ] Locked gates verified: Transmissor 15, Labirinto and Residência 12, Bar da Fantasia 32, Laboratório after class advancement.
- [ ] Click dispatch verified for 901, 402, 501, 1511, 1507, 1509, 1601, 1701.
- [ ] New building animation after 8281 / Leader 18 (`newbieProcess >= 21000`).
- [ ] Taxes bubble and Santuário bubble react to 4242 / 109.
- [ ] Test: login, enter castle, send 8747 true; go to sky realm, 8747 false.
