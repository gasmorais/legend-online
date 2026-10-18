# Hermitage expedition ("Expedição do Eremitério")

Feature [exploration](README.md), module `secret-adventure` (code names `secretadventure`, `secret`, protobuf package `secretexplore`). Aliases in [README.md](README.md).

## 1. Overview

- Weekly roguelike on hexagon maps. 4 regions ("Domínio do Fogo", "Terra da Madeira", "Domínio da Água", "Domínio do Vento"), 12 levels (3 per region); each level chains 1 to 3 sub maps (`SecretSonLevelTemplates.MapNum`) picked from 11 hexagon layouts (`SecretMapDataTemplates`).
- The player walks cell to cell (A* on hexagons, client side) and triggers cell events: guards and the boss ("Lorde Elemental") start battles (battleType 3904), shops sell discounted items, chests give rewards, a lost knight may reward or trick, mechanisms remove obstacles, stone pillars toggle, information boxes give the sub map mission (kill the boss, rescue Eliza, kill all guardians), the castle is the mission turn in point, the transmitter leads to the next sub map or level, the end ring exits.
- HP persists through the run ("A quantidade de vida perdida do jogador e dos monstros durante a expedição são mantidas"). At 0 HP the player waits `secretexplore_revive_time = 24` h or pays 30 diamonds per remaining hour to revive.
- Power is snapshotted when entering the system the first time and refreshed on death or reset (help text). Only own attributes plus Theseus armor bonuses count.
- Weekly cycle: closes Sunday 23:30 for settlement, reopens Monday 00:00 (`Secret_time` default `0,23:30:00|23:59:59`, config `secretexplore_close_time`). Paid resets (`secretexplore_reset_times_cost_diamonds`, empty in this build, client default 100) restart all areas.
- Region unlock by "Caminho da Realeza" level: `RoyaltyTemplate.OpenSecret` >= region `MapId` (region descriptions: "Caminho da Realeza nv. 6", 8, 11, 15) and having passed the previous region (`passMapId`).

## 2. Screens

Controller `secretadventure` (`decompiled/core_module/scripts/mvc/controler/SecretAdventureController.as:22-46`): default `SecretAdventureFrame`, 1 `SecretAdEventFrame` (data `[eventInfo, isNear, mapDataId]`), 2 `SecretShopFrame` (data eventInfo), 3 `SecretDialogFrame` (data eventInfo). Scene `SECRET_ADVENTURE_SCENE` (id 28) = `secretadventure.SecretAdventureScene` (`docs/world/README.md`).

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `SA/SecretAdventureFrame.as` (985 x 620) | "Expedição do Eremitério"; help "Sobre a Expedição do Eremitério" | Region selector, level progress, explore/reset buttons; sends op 5 on open (`:31-37`) | `SwitchPageHelp.openSecretFrame` (body lost, see section 9); after a 3904 battle that ends in the space scene (`decompiled/m3/scripts/map/space/SpaceSceneController.as:411-414`, `decompiled/m4/scripts/castle/CastleSceneView.as:297-300`) | 524 frame info |
| `SA/view/SecretAdLeftView.as` | "Tempo de ressurreição restante:" | Power, HP bar, revive button and countdown, region drop list (`:58-205`) | frame | `fight`, `hp/initHp`, `remainTime`, `SecretMapLevelTemplate.Drop` |
| `SA/view/SecretAdRightView.as` | "(Restam: {0})", "A cada {0}{1} reseta o Eremitério", "Usar {0} diamantes para resetar todas as áreas?" | Region cards with lock state, level progress items, explore and reset (`:66-321`) | frame | `mapId`, `levelId`, `remainingTimes`, royalty level |
| `SA/item/SecretAdventureItem.as`, `SA/item/SecretAdProgressItem.as`, `SA/item/SecretAdTitle.as` | lock tip "Condições para liberação: {0}" | Region card and level step | right view | templates |
| `SA/SecretAdventureScene.as`, `SA/map/SecretAdMapView.as`, `SA/map/SecretSonMapView.as`, `SA/map/SecretAdWarkLayer.as`, `SA/map/SecretAdArmyView.as`, `SA/map/SecretAdMapRightView.as` | | Hexagon maps of the current level, army walk, side panel | push 525 switches the scene (`SAM:115-136`) | 525 scene info, 526 events |
| `SA/item/SecretHexagon.as`, `SA/item/SecretNode.as`, `SA/item/SecretRiverNode.as`, `SA/item/SecretNewArrowItem.as`, `SA/util/SecretHexagonTool.as` | "Por favor, limpe os obstáculos do caminho primeiro!", "Ressuscite primeiro!", "Parece haver pistas no mapa escondido no báu, clique para ver" | Cell view, click logic, pathfinding, revive marker | scene | event per cell |
| `SA/SecretAdEventFrame.as` (400 x 280) | event `Name`/`Description`; mission `TaskTitle`/`Introduction` with rewards | Description and confirm for FunType 10 (information box), 14 (transmitter), 15 (healing mechanism) (`:72-191`) | cell click | event template, params |
| `SA/SecretShopFrame.as`, `SA/item/SecretShopItem.as` (585 x 365) | "Deseja consumir {0} diamantes para comprar?" | Cell shop (FunType 3) (`SecretShopItem.as:96-130`) | cell click | `params` |
| `SA/SecretDialogFrame.as` (400 x 130) | "Olá, eu me perdi da equipe do treinamento militar, você poderia me ajudar?"; "Obrigado pela sua ajuda..."; "Haha, caiu nessa!"; castle "Valeu pela ajuda guerreiro..." | Knight (FunType 2) and castle (FunType 11) dialogs (`:81-201`) | cell click | `params` "1" good outcome |

## 3. Routes (client to server)

All requests: send 9706 (0x25ea) `C_SECRET_EXPLORE_OP`, protobuf `simple.PropertyMsg` (package `simple`; `protocol/proto.json` maps the name `PropertyMsg` to an unrelated `army` message): `param1` (#1, INT32) op, `param2` (#2, INT32), `param3` (#3, INT32), `param10` (#10, INT32); other fields unused (`param4..6` #4..#6 STRING, `param7..9` #7..#9 BOOL, `param11` #11 INT32, `param12` #12 STRING). Sender `decompiled/core_module/scripts/yishi/manager/SecretAdventerManager.as` (`SAM:169-217`). Ops 6, 7, 8 clear the local scene model first (`SAM:203-206`).

| # | op | UI and sender | Client checks | Fields | Expected reply |
|---|---|---|---|---|---|
| S1 | 1 WALK | end of each walk segment (`SA/map/SecretAdWarkLayer.as:70-87`, `SAM:169-177`) | path computed client side over passable cells (`SA/item/SecretHexagon.as:426-497`) | `param2 = mapDataId`, `param3 = nodeId` reached | none required; server stores the stand node (assumption: validates adjacency) |
| S2 | 2 BUY | shop item buy (`SA/item/SecretShopItem.as:96-114`, `SAM:179-188`) | `allPoint >= price` (bound first) else recharge; confirm "Deseja consumir {0} diamantes para comprar?"; item not bought | `param2 = mapDataId`, `param3 = nodeId`, `param10 = item index` | 526 with the shop cell `params` updated (bought flag), bag 115, player info 3 |
| S3 | 3 EVENT | cell action (`SA/item/SecretHexagon.as:523-626`), event frame confirm (`SA/SecretAdEventFrame.as:72-94`), dialog (`SA/SecretDialogFrame.as:114-139`) | player alive; adjacent to the cell; FunType specific confirmations: 5 "Você deseja ativar a chave Elemental?", 17 "Há guardas bloqueando o caminho, desafiá-los?", 13 "Sair da Fase atual?", 14 requires `state == 0` else "Complete a missão ou derrote o boss!" | `param2 = mapDataId`, `param3 = nodeId`, `param10` = knight choice (0 confirm, 1 "help" path) | 526 with changed cells; battle start for FunType 17/18 (3904); 524 when HP or level changes; 525 when the sub map or level changes; exit (FunType 13) returns to space |
| S4 | 4 REVIVE | revive button or countdown end (`SA/view/SecretAdLeftView.as:141-172`), dead player clicking its own cell (`SA/item/SecretHexagon.as:370-424`), revive marker countdown (`SA/item/SecretRiverNode.as:52-58`) | confirm "Usar {0} diamantes para ressuscitar imediatamente?" with `30 x ceil(remaining hours)`; `point >= cost` | `param2 = 0` | 524 with `hp = initHp` |
| S5 | 5 FRAME | frame open (`SA/SecretAdventureFrame.as:36`) | none | `param2 = 0` | 524 |
| S6 | 6 START | "Explorar" (`SA/view/SecretAdRightView.as:309-321`) | not in Dragon Talker form else "Mude para o status de Jogador"; button enabled only for the current region, unlocked by royalty, and `levelId <= last level` (`:178-182`) | `param2 = levelId` | 525 scene info (client switches to the scene), 524 |
| S7 | 7 EXIT | HUD exit button in the scene (`decompiled/core_module/scripts/ui/maintoolbar/MainToolBar.as:1893-1902`) | confirm | `param2 = 0` | none; client returns to space with `isSecretAdventure` |
| S8 | 8 RESET | "Resetar" (`SA/view/SecretAdRightView.as:269-307`) | `remainingTimes > 0`; confirm with price `costs[len - remainingTimes]` (default 100); `point >= price` | `param2 = 0` | 524 with `levelId = 1` of the region, `remainingTimes - 1`, refreshed power and HP; player info 3 |

## 4. Server messages (server to client)

Receivers `SAM:68-167` (listeners `SAM:70-73`).

### 524 (0x020c) `U_C_SECRET_EXPLORE_PANEL_DATA`

`SecretExploreInfoRspMsg`: `mapId` (#1, INT32) current region 1..4; `levelId` (#2, INT32) current level 1..12; `remainingTimes` (#3, INT32) resets left; `fight` (#4, INT32) snapshotted power; `remainTime` (#5, STRING `YYYY-MM-DD hh:mm:ss`) automatic revive time; `hp` (#6, INT64) current HP; `initHp` (#7, INT64) max HP; `isFirst` (#8, BOOL) first visit (shows the hint arrow on information boxes); `passMapId` (#9, INT32) highest region passed. Handler `SAM:88-105`: updates `SecretFrameInfo`, `isDie = hp <= 0`, refreshes the frame and the task state. When: op 5, op 4, op 6, op 8, HP change after battles and healing, level change.

### 525 (0x020d) `U_C_SECRET_EXPLORE_MAP_DATA`

`SecretExploreSecenRspMsg`: `levelId` (#1, INT32); `mapDataIds` (#2, STRING) comma list of sub map layouts of this level; `currentMapDataId` (#3, INT32) sub map where the player stands; `nodeId` (#4, INT32) stand cell; `maps` (#5, `SecretExploreMapRspMsg`, repeated) events per sub map. Handler `SAM:115-136`: stores the scene, reads events, switches to `SECRET_ADVENTURE_SCENE` if needed. `SecretSecenInfo.putMapInfo` keeps only one sub map in memory (`decompiled/core_module/scripts/mvc/module/secret/SecretSecenInfo.as:39-43`), so send the current sub map. When: op 6, transmitter use, scene re-entry after battle.

### 526 (0x020e) `U_C_SECRET_EXPLORE_EVENT_DATA`

`SecretExploreMapRspMsg`: `mapDataId` (#1, INT32); `events` (#2, `SecretExploreEventRspMsg`, repeated): `nodeId` (#1, INT32) cell id = `row x maxColumns + column` of `MapDatas` (`SA/map/SecretSonMapView.as:88-150`); `eventId` (#2, INT32) `SecretEventTemplate.Id`; `state` (#3, INT32) 0 active, 1 done/opened, -1 hidden (`SA/item/SecretNode.as:166-230`); `params` (#4, STRING) FunType specific. Handler `SAM:107-113`, `:138-167` (upsert by node). When: after op 2, op 3 and battles.

`params` formats: FunType 3 shop `itemId#count#price#discount#bought@...` (`SA/SecretShopFrame.as:95-99`, `SA/item/SecretShopItem.as:115-130`); FunType 10 mission rewards `itemId#count@...`; FunType 8/9 pillar or switch state as an integer; FunType 2 knight outcome "1" or other.

### 527 (0x020f) `U_C_SECRET_EXPLORE_CLOSE`

Empty body. Handler `SAM:76-86`: resets the model, returns to space if inside the scene, closes the frame. When: weekly close at Sunday 23:30 to every player inside the system.

## 5. Rules and formulas

- Cell passability (`SA/item/SecretNode.as:323-346`): FunType 0 never; 1, 12, 13, 14 always; 8 never; 9 when `state == 0`; others when `state == 1` (cleared). Dead players cannot move.
- FunType catalog (`SecretEventTemplates.xml`, 149 rows): 0 hidden cell; 1 empty walkable cell; 2 "Cavaleiro Perdido" (Para1 battle unit, dialog); 3 "Loja Misteriosa" (Para1 `id,count,price,discount|...`); 4 "Baú da Surpresa"; 5 "Mecanismo Elemental" (Para1 obstacle type it clears); 6 "Obstáculo elementar"; 7 decoration; 8 "Operar dispositivo" (Para2 pillar types it toggles, repeatable); 9 "Pilar de pedra"; 10 "Caixa de Informação" (Para2 mission target type, e.g. 2501 boss); 11 "Castelo" turn in; 12 "Porta do Nascimento" spawn; 13 "Diafragma final" exit; 14 "Transmissor"; 15 "Bênção do mecanismo" (Para1 = 10 % HP heal); 16 "Montanha"; 17 guards ("Guarda sentinela", "Guarda de elite", "Guardião do Eremitério"; Para1 `unitTemplate,level`); 18 "Lorde Elemental" boss. `LevelId` selects the variant for levels 1..12; `Type` matches the codes in `MapDatas`.
- Map layout `MapDatas`: rows separated by `|`, cells by `,`; 0 no cell, -1 empty walkable cell (event Id 2), any other value = event `Type` to instantiate at that cell. `AdoptCondition` = information box type that defines the sub map mission (801 kill boss, 802 rescue, 803 kill all guardians).
- Transmitter opens once the sub map mission is done or the boss is beaten (`state == 0` check and "Complete a missão ou derrote o boss!").
- Revive: automatic after 24 h (`secretexplore_revive_time`), or 30 diamonds per started hour (`secretexplore_revive_cost_diamonds`).
- Weekly reset Monday 00:00; closed Sunday 23:30..23:59:59 (527 push).
- Battles: battleType 3904; after the battle the client returns to the scene unless `gotoSpace` (`decompiled/core_module/scripts/battle/handler/BattleResultHandler.as:296-304`).
- Rewards of regions: `SecretMapLevelTemplate.Drop` lists Theseus related items (2127021..2127026, 2131526, 2131527, 2131530) ("pode-se desbloquear slots do equipamento do tesouro de Teseu").

## 6. Templates

| File | Fields |
|---|---|
| `SecretMapLevelTemplates.xml` (`secretMapCate`) | `MapId` 1..4, `MapName`, `Description` unlock text, `Drop` comma item list, `Type` |
| `SecretSonLevelTemplates.xml` | `LevelId` 1..12, `MapNum` sub maps per level, `MapId` region |
| `SecretMapDataTemplates.xml` (`secretSonDataCate`) | `Id` 1..11, `MapDatas` hexagon layout, `AdoptCondition`, `TaskTitle`, `Introduction` |
| `SecretEventTemplates.xml` (`secretEventCate`) | `Id`, `Name`, `Type`, `Description`, `Icon`, `Resource`, `Para1`, `Para2`, `NoteName` (Chinese designer note), `LevelId`, `FunType` |
| `RoyaltyTemplates.xml` | `OpenSecret` highest region unlocked per royalty level ([theseus](../theseus/README.md)) |
| `ConfigInfos.xml` | `secretexplore_reset_times_cost_diamonds` (empty), `secretexplore_revive_time` 24, `secretexplore_revive_cost_diamonds` 30, `secretexplore_close_time` `0,23:30:00\|23:59:59`, client key `Secret_time` |

## 7. Persistent state

```sql
CREATE TABLE exploration.secret_run (
  player_id          INTEGER     PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
  week_start         DATE        NOT NULL,
  region_id          SMALLINT    NOT NULL DEFAULT 1 CHECK (region_id BETWEEN 1 AND 4),
  level_id           SMALLINT    NOT NULL DEFAULT 1 CHECK (level_id BETWEEN 1 AND 12),
  passed_region_id   SMALLINT    NOT NULL DEFAULT 0,
  resets_left        SMALLINT    NOT NULL DEFAULT 0,
  power_snapshot     INTEGER     NOT NULL DEFAULT 0,
  hp                 BIGINT      NOT NULL DEFAULT 0,
  max_hp             BIGINT      NOT NULL DEFAULT 0,
  revive_at          TIMESTAMPTZ,
  first_visit        BOOLEAN     NOT NULL DEFAULT true,
  map_data_ids       TEXT        NOT NULL DEFAULT '',
  current_map_data_id SMALLINT,
  stand_node_id      INTEGER,
  in_scene           BOOLEAN     NOT NULL DEFAULT false
);

CREATE TABLE exploration.secret_cell (
  player_id     INTEGER  NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  map_data_id   SMALLINT NOT NULL,
  node_id       INTEGER  NOT NULL,
  event_id      INTEGER  NOT NULL,
  state         SMALLINT NOT NULL DEFAULT 0 CHECK (state BETWEEN -1 AND 1),
  params        TEXT     NOT NULL DEFAULT '',
  monster_hp    BIGINT,
  PRIMARY KEY (player_id, map_data_id, node_id)
);
```

## 8. Backend implementation notes

- `exploration::secret_adventure::handle_op` (9706) dispatching on `param1`: `handle_walk`, `handle_buy`, `handle_event`, `handle_revive`, `handle_frame`, `handle_start`, `handle_exit`, `handle_reset`.
- Start: region unlocked (royalty `OpenSecret`, `passed_region_id`), level is the current one, not closed -> snapshot power and HP if first run or after death/reset, build the level: pick `MapNum` layouts, instantiate cells from `MapDatas` (event Id per Type and LevelId), set stand node at the spawn (FunType 12). Reply 525 and 524.
- Walk: target adjacent or reachable through cleared cells (verify the path server side, BFS on the hexagon grid).
- Event: dispatch on FunType; battles (17, 18, knight bad outcome) use battleType 3904 with the persisted monster HP and player HP; win marks the cell `state = 1`, updates HP; boss kill completes mission 801; castle completes 802; transmitter moves to the next sub map (new 525) or the next level (`level_id + 1`, region change after level 3, 6, 9, 12 sets `passed_region_id`); exit (13) closes the run for the week.
- Revive: `now >= revive_at` free, else charge `30 x ceil((revive_at - now) / 1 h)` diamonds.
- Weekly job: Sunday 23:30 push 527 to players inside, settle, Monday 00:00 reset runs (`resets_left` from config).

## 9. Open questions and assumptions

- `SwitchPageHelp.openSecretFrame` lost its body in decompilation (`decompiled/core_module/scripts/yishi/SwitchPageHelp.as:3264-3275`, same empty body in the transpiled TypeScript); the only entry (dialog option 159, `decompiled/m3/scripts/map/space/view/frame/DialogOptionItem.as:877-879`) currently does nothing and no NPC in `MapNodeInfos.xml` offers option 159. Needs a `PATCHES` entry in `tools/as3/gen.py` reconstructed from the original bytecode.
- Reward tables of chests, knight and missions are not in client data.
- Monster HP persistence per cell and power snapshot details.
- Exact cost list of resets (config empty).

## 10. Implementation checklist

- [ ] Screens: frame (left/right views), scene with hex maps, event, shop, dialog frames
- [ ] Route S1 op 1 walk
- [ ] Route S2 op 2 shop buy
- [ ] Route S3 op 3 cell event per FunType
- [ ] Route S4 op 4 revive
- [ ] Route S5 op 5 frame info
- [ ] Route S6 op 6 start level
- [ ] Route S7 op 7 exit
- [ ] Route S8 op 8 reset
- [ ] Server messages 524, 525, 526, 527
- [ ] Tables `exploration.secret_run`, `exploration.secret_cell`
- [ ] Template loaders (4 files) and config keys
- [ ] Battle 3904 with persisted HP
- [ ] Weekly close and reset jobs
- [ ] Fix the decompiled `openSecretFrame` entry (transpiler patch)
