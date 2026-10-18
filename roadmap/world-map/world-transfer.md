# World map: world map frame and castle relocation

Area: world-map, module `world-transfer`. Covers the "Mapa do Mundo" frame (choose one of the five worlds), relocating the castle to another world or to an empty site of the same world ("Transferir"), the 105 reply that reloads the scene, and the world-map side of the relocation (site allocation, fan-out). The Transmissor energy, its recharge and the handler of 5176 itself are owned by [../castle/transmitter.md](../castle/transmitter.md); this module defines the UI, the rules visible on the map and the `world_map` API the handler calls.

Conventions: see [scene.md](scene.md).

## 1. Overview

A castle always stands on a castle site of one world. The player can move it:

- to another world from the world map frame (costs 200 Transmissor energy, the server picks the site: the client sends cell (0,0));
- to a chosen empty site ("Transferir" on a site with no owner, level ≥ 10) on the same world (costs 100 energy).

Without enough energy the client offers to pay a full Transmissor recharge price instead (`transport_charge_cost` = 10 diamonds). The server answers 105 with the new castle position; the client plays a transfer animation, preloads the new world and reloads the outer city scene there.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `worldmap.WorldMapFrame` (`M11/worldmap/WorldMapFrame.as`), controller `worldmap` (`CM/mvc/controler/WorldMapControler.as:35-38`) | "Mapa do Mundo (Atalho: M)" (minimap tooltip `mainBar.SmallMapBar.worldBtnTipData`) | Background `asset.worldmap.Bg` and five clickable areas `map1..map5` (`_mapNum = 5`, `:28`) | Minimap world button (`CM/mainBar/SmallMapBar.as:864-868`, level ≥ 15); guide type 9 `gotoWorldMapFrame` (`CM/yishi/SwitchPageHelp.as:163-164, 1715`) | world areas only (no live data) |
| Confirm "Aviso": "Essa ação cosumirá 200 pontos de energia do transmissor, continuar?" (`worldmap.view.WorldMapFrame.content`) | | Confirmation before the change | area click (`WorldMapFrame.as:112-122`) | |
| Paid confirm "Transferir": "Energia insuficiente, para energizar transmissor consumirá {0} diamantes!" with the bound diamond checkbox (`UseBindPointAlert`) | | Pay instead of energy | `WorldMapControler.sendMap` (`WorldMapControler.as:45-68`), `MapPhysicsCastle.__transferHandler` (`M3/map/outercity/view/mapphysics/MapPhysicsCastle.as:105-145`) | {0} = `transport_charge_cost` |
| Castle site menu `BTN_PORTAL` "Transferir" (`PhysicsMenu`, `M3/map/internals/view/displaye/PhysicsMenu.as:289-306`) and confirm "Essa ação consumirá 100 pontos de energia, continuar?" | | Move the castle to this empty site | Click on a site with `occupy_player_id == 0`, level ≥ 10 | site cell |
| `TransferOuterCityAction` (`CM/yishi/actions/map/TransferOuterCityAction.as`) | none | Transfer animation (`asset.core.CollectionAsset` frame 2, dark overlay, `TransferOuterCityEffectAsset`), preload of the new world, scene reload | 105 handler when level ≥ 13 | |

## 3. Routes (client to server)

| # | UI control | Client sender | Client checks | Route | Request | Expected response |
|---|---|---|---|---|---|---|
| T1 | World map area `mapN` → confirm | `WorldMapFrame.__mouseClickHandler` / `__exitSocketHandler` (`WorldMapFrame.as:112-147`) → `WorldMapControler.sendMap` (`WorldMapControler.as:45-68`) → `PlayerManager.sendMoveCastle` (`CM/yishi/manager/PlayerManager.as:1703-1706`) → `SocketSendManager.sendMoveCastle` (`CM/yishi/service/managers/SocketSendManager.as:128-137`) | Not in `CAMPAIGN_MAP_SCENE` ("Jogador está em campanha, não é possível entrar no atlas"; special texts for Crepúsculo, Templo das Chamas, Fogo e Gelo and the guild secret land); not in `PVE_ROOM_SCENE`, `PVP_ROOM_SCENE`, `WARLORDS_ROOM` ("Jogador está em uma sala, não é possível entrar no atlas"); in the outer city the own army must be standing ("Soldados em marcha, não é possível transferir"); target world ≠ current castle world ("Você já está nessa zona, não é possível transferir"); energy ≥ 200 → send with `pay_type 1`, else paid confirm (`checkScene` again: "Saia primeiro do cenário atual para entrar no atlas") | C>S 5176 0x1438 `U_C_BUILDING_TRANSCASTLE` | `CastleReqMsg` (castle): `mag_id (#1, INT32)` target world 1..5, `pos_x (#2, INT32)` = 0, `pos_y (#3, INT32)` = 0 (server picks a site), `pay_type (#6, INT32)` = 1 (energy or real diamonds) or 2 (bound diamonds allowed, paid path with checkbox); `left_time (#4)`, `left_energy (#5)` unset | 105; 3 `U_C_PLAYER_INFO` when diamonds were spent |
| T2 | Empty site `BTN_PORTAL` "Transferir" → confirm | `MapPhysicsCastle.portal` / `__transferHandler` / `transferBack` (`MapPhysicsCastle.as:95-157`) → `PlayerManager.sendMoveCastle` | Level ≥ 8 to click a castle that is not yours (`:62-67`, "Nível inferior à 8, não é possível atacar outro jogador"); `BTN_PORTAL` only on empty sites at level ≥ 10 (`PhysicsMenu.as:297-303`); energy ≥ 100 → `pay_type 1`, else paid confirm | C>S 5176 | `CastleReqMsg`: `mag_id` = site world, `pos_x`, `pos_y` = site cell, `pay_type` as T1 | 105 |

Dead code: `WorldMapControler.lookMap` (view another world without moving, `:82-98`), `WorldMapHelper.chcekMapId` per world levels and `WorldMapFrame._unopenList = [5]` / `isOpenByIndex` have no callers; all five worlds are selectable.

## 4. Server messages (server to client)

| Opcode | Message | Receiver | When | Client reaction |
|---|---|---|---|---|
| S>C 105 0x0069 `U_C_BUILDING_TRANSCASTLE` | `CastleReqMsg` (castle): `mag_id (#1)` new world, `pos_x (#2)`, `pos_y (#3)` new site cell, `left_time (#4)` relocation cooldown seconds, `left_energy (#5)` energy after the move, `pay_type (#6)` unused | `PlayerManager.__transferCastleHandler` (`PlayerManager.as:1850-1872`) | Reply to T1/T2 on success | Updates `mapNodeInfo` (world, cell), building -11 energy and cooldown; level ≥ 13 queues `TransferOuterCityAction` (preloads the castle world, plays the movie, then `setScene("OUTER_CITY_SCENE", {isShowLoading:false, showMapName:false}, true)`, `TransferOuterCityAction.as:44-200`); below 13 reloads the scene directly; dispatches `TRANSEFER_CASTLE_SUCCESS` (quest trackers) |
| S>C 140 type 2 | `MapUpdatedMsg.base_castle` | [scene.md](scene.md) | To viewers of the old site (now empty, `occupy_player_id 0`, `type 100`) and of the new site | Updates the site |
| S>C 4168 / 140 type 3 | army removal from the old world, army record on the new world | [scene.md](scene.md) | To viewers | |

Failure: no failure message is handled by the client for 5176; the server sends nothing (the frame stays open) or a generic tip (assumption, owned by castle).

## 5. Rules and formulas

| # | Rule | Source |
|---|---|---|
| WT1 | Cost: 200 energy to change world, 100 energy to move within a world; otherwise the player pays `transport_charge_cost` (10 diamonds, bound diamonds allowed with `pay_type 2`). `pay_type 1` is sent both for energy and for real diamonds: the server decides by the current energy. | `WorldMapControler.as:52-79`, `MapPhysicsCastle.as:119-157`, `raw/xml/tempinfos/ConfigInfos.xml` |
| WT2 | Effective maximum energy = `Property2` of template 151101 (500) × (1 + race bonus / 100) + flat bonus (`PlayerEffectInfo.getTransferPowerLimitAddition`). | `CM/yishi/datas/playerinfo/PlayerEffectInfo.as:124-127` |
| WT3 | World change target site: chosen by the server (client sends (0,0)). | `WorldMapControler.as:58, 78` |
| WT4 | Site move: only to empty sites (`occupy_player_id == 0`, `castle_type 100`), level ≥ 10. | `PhysicsMenu.as:297-303` |
| WT5 | No relocation while the army is walking (frame check) or while in a campaign or room. Server must also refuse while the castle is under attack (`state 4`) or the army is in battle (assumption). | `WorldMapFrame.as:124-201` |
| WT6 | After relocation the hero army is placed at the new castle (assumption: the 105 handler does not move the army; the next 169/4241 must show it at the castle). | client behavior |

## 6. Templates

| File | Fields |
|---|---|
| `raw/xml/tempinfos/MapInfos.xml` | worlds 1 to 5 |
| `raw/xml/tempinfos/BuildingTempInfos.xml` | 151101 Transmissor `Property2` 500 |
| `raw/xml/tempinfos/ConfigInfos.xml` | `transport_charge_cost` |

## 7. Persistent state

Uses `world_map.castle_sites` ([scene.md](scene.md)) and `world_map.armies` ([army-movement.md](army-movement.md)). Relocation history:

```sql
CREATE TABLE world_map.castle_relocations (
    relocation_id    BIGSERIAL PRIMARY KEY,
    player_id        BIGINT NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
    from_site_id     INTEGER REFERENCES world_map.castle_sites(site_id),
    to_site_id       INTEGER NOT NULL REFERENCES world_map.castle_sites(site_id),
    paid_with        TEXT NOT NULL CHECK (paid_with IN ('energy','diamonds','bound_diamonds')),
    energy_spent     INTEGER NOT NULL DEFAULT 0,
    diamonds_spent   INTEGER NOT NULL DEFAULT 0,
    created_at       TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX castle_relocations_player_idx ON world_map.castle_relocations (player_id, created_at DESC);
```

## 8. Backend implementation notes

- Handler `castle::transmitter::handle_move_castle` (5176) is owned by castle. It calls:
  - `world_map::castles::pick_free_site(map_id) -> site_id` when `pos_x = pos_y = 0` (random empty site on a non obstacle area; fail when the world is full);
  - `world_map::castles::validate_target(player_id, map_id, cell)` (world exists and is open, site empty, not the current site, castle not in state 4, army not in battle);
  - `world_map::castles::relocate(player_id, site_id)` inside the same transaction as the energy or diamond spend: clear the old site (`owner_player_id NULL`, `castle_type 100`, `castle_name ''`), set the new site (type 201, or 202 for VIP skins), move the army to the castle cell, insert `castle_relocations`.
- After commit: castle sends 105 (and 3 when paid); world-map pushes 140 type 2 for both sites to their chunk viewers, 4168 to viewers of the old army chunk, 140 type 3 to viewers of the new one.
- The relocating client reloads the scene and re-requests its chunks (5004, 5181, 8201).

## 9. Open questions and assumptions

- Site choice for world changes and world capacity rules are unknown (WT3, SC10 in scene.md).
- Whether relocation clears castle protection is unknown (assumption: keeps it).
- Relocation cooldown (`left_time`) duration is owned by castle and unknown.

## 10. Implementation checklist

- [ ] Screen: world map frame with five areas and the 200 energy confirm
- [ ] Screen: `BTN_PORTAL` on empty sites with the 100 energy confirm and paid confirm
- [ ] Route T1 5176 world change (castle handler + `world_map::castles` API)
- [ ] Route T2 5176 site move
- [ ] Server message 105 (castle) and 140/4168 fan-out (world-map)
- [ ] `pick_free_site`, `validate_target`, `relocate`
- [ ] Table `world_map.castle_relocations`
- [ ] Test: change world with energy, with diamonds, with bound diamonds
- [ ] Test: other players watching the old site see it become empty
