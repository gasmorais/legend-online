# World map: wild lands (fields, monsters, treasures)

Area: world-map, module `wild-lands`. Covers the non castle entities of the outer city: fields / natural mines (type 20), roaming monsters (type 21) and treasures (type 22): their record (`WildLandMsg`), how they are attacked (5160), occupation and abandonment of fields (5179 → 108), refresh and removal, and the battles they start. Daily kill counters, bosses, fog and boss chests are in [map-boss.md](map-boss.md); the gold yield of occupied fields is in [../castle/resources.md](../castle/resources.md).

Conventions: see [scene.md](scene.md).

## 1. Overview

Wild lands are server spawned entities on worlds 1 to 5. Each has a template (`MapPhysicsTempInfos`), a level, a guarding system army (hero plus up to 2 troop stacks) and a lifetime. The player walks the hero army to it and attacks (5160 with the entity cell). Winning against a field makes the player its occupant (gold per hour while occupied, max 2 fields); winning against a monster or a treasure gives rewards and removes or refreshes it. The BR template set only contains monsters (44 templates, MasterType 21), so fields and treasures are effectively unused in this build (see §9).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `OuterCityNpcView` (`M3/map/outercity/view/mapphysics/OuterCityNpcView.as`) | monster name | Monster avatar on the map; click walks to it | NPC layer (`M3/map/outercity/view/layer/OuterCityNpcLayer.as`) | template name, level |
| `MapPhysicsField` (`M3/map/outercity/view/mapphysics/MapPhysicsField.as:24-65`) | field sprite | Field; click walks to it (others) or shows "Desistir" (own) | building layer | |
| `MapPhysicsTreasure` (`M3/map/outercity/view/mapphysics/MapPhysicsTreasure.as:16-20`) | treasure sprite | Treasure; click walks to it | building layer | |
| Attack confirm "Aviso": "Confirmar ataque {0}?" (`map.outercity.view.bossinfo.attackMsg`) | | Shown on arrival at a monster or treasure | `OuterFrameManager.open` (`M3/map/outercity/manager/OuterFrameManager.as:49-77`) | `MapPhysicsTempName` |
| `FieldInfoFrame` / `FieldInfoView` (`M3/map/outercity/view/frame/FieldInfoFrame.as`, `M3/map/internals/view/frame/FieldInfoView.as`) | "{name}({x},{y}) {MapName}", "Tempo Restante", "Ocupante" ("Desocupado" / name / "Nenhum"), "Produção" "+{Property4}/H", button "Atacar" or "Desistir" | Field details and actions | Arrival at a field (`M3/map/outercity/OuterCityController.as:612-622`) | template name, cell, map, remaining time = `RefreshTime - (now - create_date)`, occupant, yield |
| Give up confirm "Desistir?": "Desistindo da mina não receberá mais ganhos extras dessa mina, continuar?" | | Abandon an owned field | `FieldInfoFrame.__attackHandler` (`FieldInfoFrame.as:19-47`) | |
| `TreasureInfoFrame` / `TreasureFrameView` (`M3/map/outercity/view/frame/TreasureInfoFrame.as`, `M3/map/internals/view/frame/TreasureFrameView.as`) | "Ataque" / "Cancelar", defense forces image | Treasure details with its guards | `OuterFrameManager.open(4)` when the confirm path is not taken | guard troops |

## 3. Routes (client to server)

| # | UI control | Client sender | Client checks | Route | Request | Expected response |
|---|---|---|---|---|---|---|
| L1 | Monster or treasure: click → walk → "Confirmar ataque {0}?" OK | `OuterCityNpcView.mouseClickHandler` (`OuterCityNpcView.as:56-65`) / `MapPhysicsTreasure.mouseClickHandler` → walk → `OuterFrameManager.open` → `onOuterCityAttack` (`OuterFrameManager.as:49-86`) → `OuterCityController.sendAttack` (`OuterCityController.as:657-666`) → `OuterCitySocketOutManager.sendAttack` (`M3/map/outercity/manager/OuterCitySocketOutManager.as:81-89`) | click on the avatar pixels (> 50 opaque); arrival within 100 px; army usable (AM8 in [army-movement.md](army-movement.md)) | C>S 5160 0x1428 `U_C_ARMY_ATTACK` | `MapPhysicAttackMsg` (worldmap): `map_id (#1, INT32)`, `pos_x (#2, INT32)`, `pos_y (#3, INT32)` entity cell | Battle start (157); 140 type 1 with `state 4` to viewers; after the battle 4382 gains and 140 type 1 (`state 0` removes it or a refreshed record) |
| L2 | Field (not owned): click → walk → field info "Atacar" | `MapPhysicsField.mouseClickHandler` (`MapPhysicsField.as:24-60`) → walk → `FieldInfoFrame.__attackHandler` (`FieldInfoFrame.as:19-47`) → `sendAttack` | level ≥ 6; field guild ≠ own guild name ("Não é possível atacar membros da mesma Guilda"); fewer than 2 owned fields (`BuildingManager.model.fieldDic`, filled by 152, "Número máximo de minas naturais ocupadas atingido, não é possível ocupar") | C>S 5160 | as L1 | Battle; on victory the field becomes owned (140 type 1 with `occupy_player_id`) and 152 updates the yields (castle) |
| L3 | Own field: menu "Desistir" or field info "Desistir" → confirm | `MapPhysicsField.giveUpCall` (`:62-65`), `FieldInfoFrame.__giveUpCall` → `OuterCityController.sendGiveUp` (`OuterCityController.as:1334-1342`) → `BuildingSocketOutManager.unoccupy` (`CM/managers/BuildingSocketOutManager.as:84-90`) | own field (`occupy_player_id == self`) | C>S 5179 0x143b `U_C_UNOCCPWILDLAND` | `BuildingReqMsg` (building): `position (#2, STRING)` = `"cellX,cellY"`; `order_id (#1)`, `index (#3)`, `user_id (#4)` unset | 108; then 152 and 109 (castle resources) and 140 type 1 to viewers |

Handler ownership: 5179 is implemented by `castle::resources::handle_abandon_wild_land` ([../castle/resources.md](../castle/resources.md)); it calls `world_map::wild_lands::release(player, map, cell)`.

## 4. Server messages (server to client)

| Opcode | Message | Receiver | When | Client reaction |
|---|---|---|---|---|
| S>C 4129 | `PhysicListUpdateMsg.wildLand` | [scene.md](scene.md) | chunk list | `readWildLand` (`OuterCityController.as:958-1028`) |
| S>C 140 type 1 | `MapUpdatedMsg.wild_land` | `OuterCityController.__updateWildLandHandler` (`:1120-1125`) → `OuterCityModel.updateWildLand` (`CM/map/outercity/OuterCityModel.as:255-311`) | spawn, battle start/end, occupation, abandonment, expiry | adds, updates, or removes (`state 0`, or a different `type` at the same cell) |
| S>C 108 0x006c `U_C_UNOCCPWILDLAND` | `GiveupWildLandMsg` (building): `wild_land_pos (#1, STRING)` `"cellX,cellY"` | `BuildingManager.__unoccupyHandler` (`CM/yishi/manager/BuildingManager.as:255-268`) → controller `__unoccupyHandler` (`OuterCityController.as:1344-1352`) | Reply to L3 | Non empty: tip "Abandono de território selvagem sucedido" and the field's occupant is cleared on the map; empty string = failure (no tip) |
| S>C 4382 | `FightOverMoiveMsg` | [castle-pvp.md](castle-pvp.md) | after a won wild land battle | floating gains |

### `WildLandMsg` (army)

| Field | Tag, type | Meaning |
|---|---|---|
| `id` | #1, INT32 | entity id |
| `map_id` | #2, INT32 | world |
| `pos_x`, `pos_y` | #3, #4, INT32 | cell (entities are keyed by px position on the client) |
| `template_id` | #5, INT32 | `MapPhysicsTempInfos.TemplateId` (name, kind, refresh, yield) |
| `type` | #6, INT32 | 20 field, 21 monster, 22 treasure |
| `occupy_player_id`, `occupy_player_name`, `occupy_league_name` | #7 to #9 | field occupant |
| `level` | #10, INT32 | level shown |
| `refresh_time` | #11, INT32 | seconds (stored, not displayed) |
| `state` | #12, INT32 | 0 = gone (remove), 4 = in battle ("(Em batalha)"), other = active |
| `create_date` | #13, STRING | `"YYYY-MM-DD hh:mm:ss"`, start of the lifetime used for "Tempo Restante" |
| `simple_hero_info` | #14, SimpleHeroInfoMsg | guard hero (read when present) |
| `armyPawn` | #15, ArmyPawnInfoMsg, repeated | up to 2 guard troop stacks: `id (#1)`, `army_id (#2)`, `tempate_id (#5)`, `own_pawns (#6)` |
| `curArmyId` | #16, INT32, repeated | armies currently fighting it |
| `fight_capaity` | #17, INT32 | guard power |
| `BossType` | #18, INT32 | map boss kind ([map-boss.md](map-boss.md)) |
| `size` | #19, INT32 | sprite size |
| `lifeMasterType`, `lifeSonType` | #20, #21 | unused |

## 5. Rules and formulas

| # | Rule | Source |
|---|---|---|
| WL1 | Kinds by `MapPhysicsTempInfos.Property1`: 1 normal, 2 elite ("[Elite]"), 3 boss, 4 snow event (300201), 5 hermitage monsters (400101..400108), 6 event bosses (500001..500005, `RefreshTime 0`). `Property2` (10 or 12) is a display size (assumption). Levels 10 to 80 by template (event 80 to 240). | `raw/xml/tempinfos/MapPhysicsTempInfos.xml` |
| WL2 | Refresh: `RefreshTime` 7200 s; help text: from 08:00 to 00:00 creatures are refreshed every 2 hours at random places of each map. | template, `map.outercity.view.helpFrame.helpContent` |
| WL3 | Rewards: monsters 15 or more levels below the player give no reward and do not consume a daily kill. Daily kill caps per kind in [map-boss.md](map-boss.md). | `map.outercity.view.helpFrame.helpContent` |
| WL4 | Field gates: level ≥ 6 to click, max 2 owned fields, not the same guild; yield `Property4` gold per hour while occupied (castle resources), lifetime `RefreshTime` from `create_date`. | `MapPhysicsField.as:24-60`, `FieldInfoView.as:186-225` |
| WL5 | Battle exit returns to the outer city at the army position for battleType 1 to 5 and 3841. Assumption: 1 = field, 2 = monster, 3 = treasure, 3841 = map boss (constants `RES_WILDLAND_BATTLE`, `NPC_WILDLAND_BATTLE`, `TRE_WILDLAND_BATTLE`, `WORLD_MAP_NPC`). | `CM/yishi/datas/battle/BattleType.as`, `CM/battle/handler/BattleResultHandler.as:172-177, 211-213` |
| WL6 | Walk target for an entity is its px position + (0, 40); the arrival radius is 100 px. | `OuterCityController.as:603-633, 712-720` |
| WL7 | While a wild land is in battle (`state 4`) other players may still click it; the server refuses (assumption: one fight at a time). | client |

## 6. Templates

| File | Records | Fields used |
|---|---|---|
| `raw/xml/tempinfos/MapPhysicsTempInfos.xml` | 44 rows, all MasterType 21 | `TemplateId`, `MapPhysicsTempName`, `MasterType`, `SonType` (sprite), `Grades`, `RefreshTime`, `Property1` (kind), `Property2`, `Property4` (field yield), `HeroGP` |

## 7. Persistent state

```sql
CREATE TABLE world_map.wild_lands (
    wild_land_id      BIGSERIAL PRIMARY KEY,
    map_id            INTEGER NOT NULL REFERENCES world_map.worlds(map_id),
    cell_x            INTEGER NOT NULL,
    cell_y            INTEGER NOT NULL,
    chunk_id          TEXT GENERATED ALWAYS AS ((cell_x * 20 / 1000)::TEXT || '_' || (cell_y * 20 / 1000)::TEXT) STORED,
    land_type         SMALLINT NOT NULL CHECK (land_type IN (20, 21, 22)),
    template_id       INTEGER NOT NULL,
    level             INTEGER NOT NULL,
    state             SMALLINT NOT NULL DEFAULT 1,
    boss_type         INTEGER NOT NULL DEFAULT 0,
    size              INTEGER NOT NULL DEFAULT 0,
    guard_json        JSONB NOT NULL DEFAULT '{}'::jsonb,
    occupant_player_id BIGINT REFERENCES player.players(player_id) ON DELETE SET NULL,
    occupied_at       TIMESTAMPTZ,
    created_at        TIMESTAMPTZ NOT NULL DEFAULT now(),
    expires_at        TIMESTAMPTZ,
    UNIQUE (map_id, cell_x, cell_y)
);
CREATE INDEX wild_lands_chunk_idx ON world_map.wild_lands (map_id, chunk_id);
CREATE INDEX wild_lands_occupant_idx ON world_map.wild_lands (occupant_player_id) WHERE occupant_player_id IS NOT NULL;
```

`guard_json` stores the guard hero and the up to 2 troop stacks used to build `simple_hero_info` and `armyPawn` and the battle.

## 8. Backend implementation notes

- `world_map::castle_pvp::handle_attack` (5160) dispatches wild lands to `world_map::wild_lands::attack(player, wild_land)`: army within 100 px (assumption), state not 4, field gates (WL4), daily kill cap and level rule (WL3, map-boss); set `state 4`, push 140 type 1; start the battle (WL5) with the guard army; on end: monsters and treasures → grant rewards (server drop tables, not in the client), increment daily kills, remove (`state 0` push) or schedule refresh; fields → set occupant on victory (push 140 type 1, notify castle resources to rebuild 152/109).
- Spawner job: every 2 hours between 08:00 and 00:00 fill each world with monsters of its level band at random free non obstacle cells (WL2); push 140 type 1 to chunk viewers.
- Expiry job: fields past `RefreshTime` are released and respawned (assumption).
- `world_map::wild_lands::release(player, map, cell)` for 5179 (called by castle resources).

## 9. Open questions and assumptions

- No MasterType 20 or 22 templates exist in `MapPhysicsTempInfos.xml`; `FieldInfoView` would fail on a null template. Fields and treasures are likely disabled on BR servers. Implement monsters first; keep fields behind a switch.
- `OuterFrameManager.open` uses `data.hasOwnProperty("tempInfo")`: for monsters and treasures this shows the confirm instead of `TreasureInfoFrame` (assumption: AS3 reports declared getters as own properties).
- Reward tables and spawn bands per world are not in the client.
- Battle type values per kind are assumptions (WL5).

## 10. Implementation checklist

- [ ] Monster spawner per world and refresh schedule
- [ ] Route L1 5160 monster and treasure attack
- [ ] Route L2 5160 field attack and occupation (behind a switch)
- [ ] Route L3 5179 release (castle handler + `release` API)
- [ ] Server messages 140 type 1, 4129 entries, 108 (castle)
- [ ] Table `world_map.wild_lands`
- [ ] Test: monster attack → battle → removal pushed to viewers
- [ ] Test: monster 15+ levels below gives no reward
