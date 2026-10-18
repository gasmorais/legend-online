# World map: map bosses, daily kills, fog and boss chests

Area: world-map, module `map-boss`. Covers the outer city creature event shown in the top panel of the scene: daily kill counters per monster kind, the list of bosses of the current world with their state, the refresh countdown, the boss radar (walk to a boss), the fog removal timer and the boss chests dropped on the map.

Conventions: see [scene.md](scene.md).

## 1. Overview

Each world has normal monsters, elites and bosses ([wild-lands.md](wild-lands.md)). A player may kill per day 5 normal, 3 elite and 1 boss for rewards (`WorldMapKill = "5,3,1"`). When the outer city opens the client asks the server for the panel data of that world (9525 → 4938): kills done today, up to 5 bosses with name, level and state, seconds until the next refresh and seconds of fog removal left. After a boss dies, chests can appear on the map (4940); clicking a chest picks it (9526). The radar button next to each boss walks the army to it, but only for players with the "contrato dos elfos" buff.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `OuterCityBossInfoView` (`M3/map/outercity/view/bossinfo/OuterCityBossInfoView.as`) | "Montro Normal:  {0}/{1}", "Monstro Elite:  {0}/{1}", "Chefão:  {0}/{1}"; boss lines "{0}: Nv.{1}{2}" with "(Em batalha)" (type 4) or "(Já matou)" (type 0); countdown | Event panel | Scene enter (`M3/map/outercity/OuterCityController.as:456-463`) | `MapBossMsg` (kills capped by `WorldMapKill`), boss list, `leftBossTime` as a countdown |
| Boss radar buttons `_bossRadar0..4` | none | Walk to a living boss | panel | hidden for killed bosses |
| King contract prompt "Aviso": "Necessário ativar contrato dos elfos, deseja habilitar?" | | Radar without buff 10 | radar click (`OuterCityBossInfoView.as:214-250`) | opens frame `kingcontract` ([../returning-players/README.md](../returning-players/README.md)) |
| `OuterCityBossBoxView` (`M3/map/outercity/view/bossinfo/OuterCityBossBoxView.as`) | chest movie | Boss chest on the map at cell × 20; click picks it and fades out | 4940 (`M3/map/outercity/view/OuterCityMap.as:276-296`) | none |
| Help "map.outercity.view.helpFrame.helpContent" | rules text (kill rules, 2 h refresh) | | panel help | |

## 3. Routes (client to server)

| # | UI control | Client sender | Client checks | Route | Request | Expected response |
|---|---|---|---|---|---|---|
| B1 | Scene enter; countdown reaching 0 | `OuterCityController.enter` (`OuterCityController.as:463`), `OuterCityManager.coolDownBossUpdate` (`CM/map/outercity/manager/OuterCityManager.as:125-137`) → `OuterCityManager.getBossInfo` (`:229-235`) | none; while `leftBossTime == 0` the client re-requests every second | C>S 9525 0x2535 `C_MAPBOSS_DATAS` | `MapBossQuestMsg` (army): `mapId (#1, INT32)` shown world | 4938 |
| B2 | Click a boss chest | `OuterCityBossBoxView.onClick` (`OuterCityBossBoxView.as:35-50`) → `OuterCityManager.getBossBox` (`OuterCityManager.as:237-242`) | none (any listed chest is clickable) | C>S 9526 0x2536 `C_MAPBOX_PICK` | `BoxMsg` (army), echo of the chest: `boxId (#1, STRING)`, `userId (#2, INT32)`, `grade (#3, INT32)`, `mapId (#4, INT32)`, `x (#5, INT32)`, `y (#6, INT32)`, `type (#7, INT32)` | Reward pushes (bag 115 / player info 3, assumption) and 4940 without that chest to the world viewers |
| B3 | Radar button of a living boss (with king contract buff 10) | `OuterCityBossInfoView.__bossRadarHandler` (`:214-250`) | `KingContractManager.checkHasBuffById(10)` | walk only (8254 segments, [army-movement.md](army-movement.md)) | | |

## 4. Server messages (server to client)

| Opcode | Message | Receiver | When | Client reaction |
|---|---|---|---|---|
| S>C 4938 0x134a `U_C_MAPBOSS_DATAS` | `MapBossMsg` (army): `count1 (#1, INT32)` normal kills today, `count2 (#2)` elite kills, `count3 (#3)` boss kills, `bosslist (#4, BossMsg, repeated)` each `bossName (#1, STRING)`, `grade (#2, INT32)`, `type (#3, INT32)` 0 killed, 4 in battle, other alive, `x (#4)`, `y (#5)` cells; `leftBossTime (#5, INT32)` seconds to the next refresh (0 triggers an immediate re-request, negative stops the countdown), `leftFogTime (#6, INT32)` seconds of fog removal, `archaeologyKillCount (#7)`, `atchaeologyMonsterCount (#8)` ([../archaeology/README.md](../archaeology/README.md)) | `OuterCityManager.onGetBossInfo` (`OuterCityManager.as:85-117`) | Reply to B1; push to world viewers when bosses spawn, die or change state (assumption) | Updates the panel; `leftFogTime > 0` removes the fog and makes every entity visible ([scene.md](scene.md) SC6) |
| S>C 4939 0x134b `U_C_MAPBOSS_FOG` | `MapBossMsg`: only `leftFogTime (#6)` read | `OuterCityManager.onMapBossFog` (`:152-159`) | When a fog removal starts for the player (item or event, source not in the client) | Removes the fog; when the countdown reaches 0 the fog returns (`:139-150`) |
| S>C 4940 0x134c `U_C_MAPBOSS_BOX` | `MapBoxMsg` (army): `boxlist (#1, BoxMsg, repeated)` | `OuterCityManager.onMapBossBox` (`:161-186`) → `OuterCityMap.onUpdateBox` | After a boss dies (chests dropped), after a pick | Adds chest views for new `boxId`s (existing ones are kept; removal is local after a click) |

## 5. Rules and formulas

| # | Rule | Source |
|---|---|---|
| MB1 | Daily kill caps `WorldMapKill = "5,3,1"` (normal, elite, boss); the panel shows `min(count, cap)/cap`. Reset at 0h (help text). | `CM/map/outercity/MapBossMsgInfo.as:33-48`, `OuterCityBossInfoView.as:155-170`, `raw/xml/tempinfos/ConfigInfos.xml` |
| MB2 | Kind of a monster = `MapPhysicsTempInfos.Property1` (1 normal, 2 elite, 3 boss). Kills 15+ levels below the player give no reward and do not count. | `raw/xml/tempinfos/MapPhysicsTempInfos.xml`, help text |
| MB3 | Refresh: every 2 hours from 08:00 to 00:00 (help text); `leftBossTime` = seconds to the next refresh. Never send 0 as a steady value (client polls every second); send −1 outside the refresh window. | `OuterCityManager.as:125-137` |
| MB4 | Radar needs king contract buff id 10. | `OuterCityBossInfoView.as:226` |
| MB5 | Chests: drawn at (`x × 20`, `y × 20`); any player can click; the server must check ownership (`userId`) or allow free for all (assumption: owner only during 5 minutes, then free). | `OuterCityBossBoxView.as:20-50` |
| MB6 | Fog removal shows all players' entities on the world map regardless of distance. | `OuterCityController.as:191-404` |

## 6. Templates

| File | Fields |
|---|---|
| `raw/xml/tempinfos/ConfigInfos.xml` | `WorldMapKill` |
| `raw/xml/tempinfos/MapPhysicsTempInfos.xml` | boss templates (`Property1 = 3`), event bosses (`Property1 = 6`) |

## 7. Persistent state

```sql
CREATE TABLE world_map.daily_kills (
    player_id        BIGINT NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
    day              DATE NOT NULL,
    normal_kills     SMALLINT NOT NULL DEFAULT 0,
    elite_kills      SMALLINT NOT NULL DEFAULT 0,
    boss_kills       SMALLINT NOT NULL DEFAULT 0,
    PRIMARY KEY (player_id, day)
);

CREATE TABLE world_map.boss_chests (
    box_id           TEXT PRIMARY KEY,
    map_id           INTEGER NOT NULL REFERENCES world_map.worlds(map_id),
    cell_x           INTEGER NOT NULL,
    cell_y           INTEGER NOT NULL,
    owner_player_id  BIGINT REFERENCES player.players(player_id) ON DELETE SET NULL,
    grade            INTEGER NOT NULL,
    box_type         INTEGER NOT NULL,
    dropped_at       TIMESTAMPTZ NOT NULL DEFAULT now(),
    expires_at       TIMESTAMPTZ NOT NULL,
    picked_by        BIGINT REFERENCES player.players(player_id),
    picked_at        TIMESTAMPTZ
);
CREATE INDEX boss_chests_map_idx ON world_map.boss_chests (map_id) WHERE picked_at IS NULL;

CREATE TABLE world_map.fog_reveals (
    player_id        BIGINT PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
    reveal_until     TIMESTAMPTZ NOT NULL
);
```

Bosses themselves are rows of `world_map.wild_lands` with `boss_type > 0` ([wild-lands.md](wild-lands.md)).

## 8. Backend implementation notes

- `world_map::map_boss::handle_boss_data` (9525): build 4938 for the requested world: today's kills of the player, bosses of the world (`wild_lands` with kind 3 or `boss_type > 0`, max 5), `leftBossTime` per MB3, `leftFogTime` from `fog_reveals`, archaeology counters from the archaeology feature.
- `world_map::map_boss::handle_pick_box` (9526): chest exists, not picked, not expired, ownership rule (MB5), player army within 100 px (assumption); mark picked; grant the reward (drop table by `grade`/`type`, server data); push 4940 with the remaining chests to world viewers.
- Kill hook from wild lands: increment `daily_kills` when within caps and level rule; boss death drops chests (insert rows, push 4940).
- Fog: `world_map::map_boss::grant_fog_reveal(player, seconds)` used by items or events; push 4939.

## 9. Open questions and assumptions

- What grants fog removal (4939) is not visible in the client.
- Chest ownership, lifetime and rewards are unknown.
- The current Rust rule for 9525 (`server/flows/navigation.json`) answers `leftBossTime 0`, which makes the client poll every second; it must send a positive countdown or −1.

## 10. Implementation checklist

- [ ] Route B1 9525 → 4938 with correct `leftBossTime`
- [ ] Route B2 9526 chest pick → rewards → 4940
- [ ] Server message 4939 fog reveal
- [ ] Kill counting hook and daily reset
- [ ] Tables `world_map.daily_kills`, `world_map.boss_chests`, `world_map.fog_reveals`
- [ ] Test: panel counters update after kills; caps 5/3/1 enforced
- [ ] Test: no 9525 polling loop when no refresh is pending
