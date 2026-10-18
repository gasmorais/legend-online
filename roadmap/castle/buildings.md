# Buildings (core module)

Aliases: see [README.md](README.md). Extra aliases:

| Alias | File |
|---|---|
| BI | `decompiled/core_module/scripts/mvc/module/buildings/BuildInfo.as` |
| BC | `decompiled/core_module/scripts/mvc/controler/BuildingControler.as` |
| CF | `decompiled/m4/scripts/buildings/casern/view/CasernFrame.as` |
| PF | `decompiled/m4/scripts/buildings/politics/view/PoliticsFrame.as` |
| NSOM | `decompiled/core_module/scripts/dialog/utils/NewbieSocketOutManager.as` |
| CMV | `decompiled/m4/scripts/castle/view/CastleMapViewII.as` |
| XML | `raw/xml/tempinfos/BuildingTempInfos.xml` |

## 1. Overview

Every castle building is one row per player with a `building_id`, a `son_type` (building kind) and a `template_id` that points to the `BuildingTempInfos` row of its current level (`TemplateId = SonType * 100 + level`). Upgrading replaces the template with `NextGradeTemplateId` and pays the next row costs. This module owns the building list, its login load, creation, upgrade and the generic building frame. Technologies are buildings too (MasterType 13 and 14) and share the same routes; their rules are in [technologies.md](technologies.md).

Buildings that exist in this build:

| SonType | MasterType | pt-BR name | Levels | Source |
|---|---|---|---|---|
| 901 | 9 | "Prefeitura" | 1..80 | created with the castle (`Castle_Building = 901,402`) |
| 402 | 4 | "Quartel" | 1..80 | created with the castle |
| 501 | 5 | "Santuário" (tooltip "Seminário") | 1..80 | created at Leader level 18 |
| 1304, 1420..1424, 1441..1446 | 13 / 14 | basic technologies | 0..80 | unlocked by Santuário levels 1..12 |
| 2304, 2420..2424, 2441..2446 | 13 / 14 | advanced technologies | 0..80 | unlocked by Santuário level 55 |
| 1507, 1509, 1511, 1601, 1701 | 15, 15, 8, 16, 17 | portals | 1 | client pseudo buildings, never stored ([scene.md](scene.md)) |

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `buildings.BaseBuildFrame` (BBF) | "{BuildingName} Nv. {grade}" (`BBF:196`) | Base of every building frame: icon, "Nível atual" with `Activity`, "Próximo" with next `Activity`, "Condições de elevamento" text "Personagem atingiu Nv.{Leader+1}", "Nível máximo atingido", upgrade button | `BuildingControler` (`BC:52-67`) with the `BuildInfo` | current and next template `Activity`; for 901 the Midas bonus "+{n} (bônus de magia)" (`BBF:226-241`) |
| `buildings.politics.view.PoliticsFrame` (PF) | Prefeitura | Base frame plus the tax panel ([levy.md](levy.md)) | Prefeitura click | level, production, taxes |
| `buildings.casern.view.CasernFrame` (CF) | Quartel | Base frame plus `PawnTileList` (soldier families, recruit and level up, owned by [../army/README.md](../army/README.md)); on close calls `armyController.autoAllocate()` (`CF:83-93`) | Quartel click | level, soldier list |
| `buildings.seminary.view.SeminaryFrame` | Santuário | see [technologies.md](technologies.md) | Santuário click | technologies |
| `buildings.crystal.view.CrystalFrame`, `buildings.depot.view.DepotFrame`, `buildings.market.view.MarkertBuildFrame`, `buildings.residence.view.ResidenceFrame`, `buildings.titan.view.TitanFrame` | none | Legacy frames for MasterTypes 1, 11, 12, 10 (and depot); empty shells over `BaseBuildFrame` | unreachable: no template rows | none |

## 3. Routes (client to server)

### R1. Load buildings at login

- UI: login data request (`LIDA.request`, `LIDA:154-184`): `PlayerDataMsg.castle = true` (`LIDA:158`), `PlayerDataMsg.build = true` (`LIDA:159`).
- Route: C>S 8224 (0x2020) `C_LONIG_LOAD_REQ`, owned by [../account/README.md](../account/README.md). Fields relevant here: `castle (#2, BOOL)`, `build (#5, BOOL)`.
- Responses for this module, in this order: 4153 `U_C_LOAD_CASTLE` (S1, see [transmitter.md](transmitter.md) for the energy field), then 4154 `U_C_LOAD_BUILD` (S2). Both count toward the login step counter (`LIDA:839`, `LIDA:872`).

### R2. Initialize the castle (tutorial)

- UI: tutorial node 170 step 1, when the player is in scene 1 (`decompiled/m8/scripts/nodes/NoviceTutorial_170.as:15-50`), action `NewbieBaseActionMediator.sendInitBuildAndQueue`.
- Sender: `NewbieSocketOutManager.sendInitBuildAndQueue` (`NSOM:57-61`).
- Route: C>S 8281 (0x2059) `C_BUILDING_INIT`, empty body (`sendProtobuffer(pkg, null)`).
- Server: create the default buildings if missing (config `Castle_Building = 901,402`, templates 90101 and 40201) and the activity queue rows. Response: 4130 (S3) with `result = true` and the created buildings (client draws them with the camera animation when `newbieProcess >= 21000`, `CMV:270-285`), then 366 ([activity-queue.md](activity-queue.md)). Assumption: idempotent; if the buildings exist, answer 4130 with the existing rows.

### R3. Upgrade a building or technology

- UI: `BaseBuildFrame._upgradeBtn` (`BBF:145`, handler `BBF:169-175`) for 901, 402; technology "Elevar" button in the Santuário ([technologies.md](technologies.md)).
- Client checks `BuildingManager.isUpgradeAvaliable` (`BM:367-386`), each failure shows a tip and stops:
  1. Not max level: `NextGradeTemplateId != 0` (`BMOD:399-411`).
  2. Resources: next template `GoldConsume <= gold` and `CrystalsConsume <= crystals` (`BM:393-404`, `RM:79-104`); tip "Necessário Ouro{missing},Cristal de luz{missing}".
  3. Prerequisites: every id of the next template `PreTemplateId` (comma list) must be met by the existing building of the same `SonType` with `BuildingGrade >=` the prerequisite grade (`BMOD:282-357`); tip "Necessita {name Nv.N}" (`BM:406-417`).
  4. Leader level: next `PlayerGrades <= thane.grades` (`BM:419-431`); tip "Necessita Líder Nv. {0}".
  5. The construction queue is not checked (`checkBuildList` has no caller, see [build-queue.md](build-queue.md)).
- Sender: `BM.upgradeBuildingByBuildingInfo` (`BM:270-277`) > `BSOM.sendUpgradeBuild` (`BSOM:26-32`).
- Route: C>S 8203 (0x200b) `C_BUILDING_UPGRADE`.
- Request `building.BuildingOptionReqMsg`: `building_id (#1, INT32)` = the building to upgrade; `son_type (#2, INT32)` unset.
- Response: 4130 (S3) with `result = true` and the upgraded `BuildingInfoMsg` (plus any building created by the upgrade, see rules), then 109 with the new gold and crystal balances ([resources.md](resources.md)). For MasterType 13 / 14 also the hero attribute push owned by [../hero/README.md](../hero/README.md). On failure: 4130 with `result = false` (client ignores it, `BM:134-135`) and a generic alert (assumed 111).

### R4. Create a building

- UI: technology button when the `BuildInfo` has `building_id == 0` (`decompiled/m4/scripts/buildings/seminary/view/SeminaryFrameBottomView.as:111-114`). In practice every row the server sends has an id, so this path is dormant.
- Client checks `BM.creatBuilding` (`BM:287-310`): lowest grade template of the SonType (`getMinGradeBuildingTemplete`) costs affordable ("Falha na ativação de {0}"), prerequisites met ("Condição necessária de estrutura {0} insuficiente").
- Sender: `BSOM.sendCreateBuild` (`BSOM:18-24`).
- Route: C>S 8202 (0x200a) `C_BUILDING_CREATE`.
- Request `building.BuildingOptionReqMsg`: `son_type (#2, INT32)` = SonType to build; `building_id (#1)` unset.
- Response: 4130 with the new row (client dispatches `CREATE_NEW_BUILDING`), then 109.

## 4. Server messages (server to client)

### S1. 4153 (0x1039) `U_C_LOAD_CASTLE`

Message `army.BaseCastleMsg` (owned by world-map / army proto package; castle reads it). Receiver `LIDA.__loadCastleHandler` (`LIDA:817-847`).

| Field | Tag, type | Meaning |
|---|---|---|
| `id` | #1 INT32 | castle node id on the world map |
| `map_id` | #2 INT32 | world map id |
| `pos_x`, `pos_y` | #3, #4 INT32 | castle coordinates |
| `template_id` | #5 INT32 | not read |
| `type` | #6 INT32 | node type |
| `occupy_player_id`, `occupy_player_name`, `occupy_league_name` | #7 INT32, #8 STRING, #9 STRING | owner (the player) and guild name |
| `state` | #10 INT32 | node state |
| `defence_lefttime` | #11 INT32 | seconds of castle protection left ([../world-map/README.md](../world-map/README.md)) |
| `castle_name` | #12 STRING | castle name |
| `left_energy` | #13 INT32 | Transmissor energy, copied into pseudo building -11 `property1` ([transmitter.md](transmitter.md)) |
| `grade` | #14 INT32 | castle grade shown on the world map (assumption: Prefeitura level) |
| `is_defenceBuffer` | #15 BOOL | not read |
| `vip_castleView` | #16 INT32 | VIP castle skin ([../vip/README.md](../vip/README.md)) |
| `vip_type` | #17 INT32 | VIP type |

When: once in the login load. Must precede the first castle render.

### S2. 4154 (0x103a) `U_C_LOAD_BUILD`

Message `building.BuildingInfoListMsg`. Receiver `LIDA.__loadBuildHandler` (`LIDA:849-873`): adds every row to the model (no events).

| Field | Tag, type | Meaning |
|---|---|---|
| `result` | #1 BOOL | read but unused at login |
| `building` | #2 MESSAGE `BuildingInfoMsg`, repeated | every building and technology row of the player |

`BuildingInfoMsg`:

| Field | Tag, type | Meaning |
|---|---|---|
| `user_id` | #1 INT32 | owner, not read |
| `building_id` | #2 INT32 | positive id, unique per player |
| `castle_id` | #3 INT32 | not read |
| `created_date` | #4 STRING | not read |
| `is_exist` | #5 BOOL | not read |
| `template_id` | #6 INT32 | current `BuildingTempInfos.TemplateId` |
| `son_type` | #7 INT32 | SonType (the client recomputes it from the template, `BI:31-39`) |
| `propterty1` | #8 INT32 | per building: 901 = taxes used today ([levy.md](levy.md)); others 0 |
| `propterty2` | #9 INT32 | per building: 901 = taxes allowed per day; others 0 |

### S3. 4130 (0x1022) `U_C_BUILDINGINFO_LIST`

Same message as S2. Receiver `BM.__updateBuildInfoHandler` (`BM:126-167`):

- `result = false`: the whole message is ignored.
- For each row: unknown `building_id` creates the `BuildInfo` and dispatches `CREATE_NEW_BUILDING`; known id updates template and properties and dispatches `BUILDING_UPGRADE_RECEIVE`. MasterType 13 / 14 rows also send `UPDATE_EXTRABUFFER` (top bar technology buff icon).
- Consumers: castle map ([scene.md](scene.md)), open building frame refresh (`BBF:159-167`), Santuário list ([technologies.md](technologies.md)).

When: response to 8202, 8203, 8281; push when the server creates a building on its own (Santuário at Leader 18, technologies unlocked by a Santuário level); push of 901 after the daily tax reset (alternative to 4242, see [levy.md](levy.md)).

### Errors

No error code. Send 4130 with `result = false` and a generic alert (assumed 111 `U_C_CHANNEL_ALERT`) with one of the client strings: "Necessita Líder Nv. {0}", "Necessita {0}", "Necessário ...", "Já está no nível máximo".

## 5. Rules and formulas

### Template keys

- `TemplateId = SonType * 100 + BuildingGrade` (technologies start at grade 0, buildings at 1).
- `NextGradeTemplateId = 0` means max level. `BUILD_MAX_GRADE = 80` in `ConfigInfos`.
- Costs and requirements are always read from the next level row: `GoldConsume`, `CrystalsConsume`, `PlayerGrades`, `PreTemplateId`.
- `PreTemplateId` is a comma list of template ids; a prerequisite is met when the player has a building with the prerequisite `SonType` and a `BuildingGrade >=` the prerequisite grade (`BMOD:306-357`).
- `Reputation` is 0 in every row; `PopuliationConsume` is absent (0).

### Prefeitura (901), `XML` rows 90101..90180

| Level L | Gold to reach L (`GoldConsume`) | `PlayerGrades` | Gold per hour (`Property1`) |
|---|---|---|---|
| 1 | 0 | 1 | 390 |
| 2..10 | 100 * L | L | 390 + 525 * (L - 1) |
| 11..20 | 1600 + 320 * (L - 11) | L | same |
| 21..30 | 6400 + 1840 * (L - 21) | L | same |
| 31..50 | 26550 + 3590 * (L - 31) | L | same |
| 51..60 | 99880 + 5120 * (L - 51) | L | same (31365 at 60) |
| 61..70 | 153040 + 7080 * (L - 61) | L | 31365 + 285 * (L - 60) |
| 71..80 | 227560 + 10800 * (L - 71) | L | same (37065 at 80) |

Total gold 1 to 80: 7 235 500. The Prefeitura level can never exceed the Leader level.

### Quartel (402), rows 40201..40280

- `PreTemplateId = 90100 + L`: Quartel level L needs Prefeitura level L. `PlayerGrades = 1`.
- Gold to reach L: 0 (L1); 130 + 120 * (L - 2) for 2..10; 1520 + 310 * (L - 11) for 11..21; 6260 + 1640 * (L - 22) for 22..30; 22020 + 2640 * (L - 31) for 31..50; 77300 + 5120 * (L - 51) for 51..60; 130460 + 7080 * (L - 61) for 61..70; 204980 + 10800 * (L - 71) for 71..80. Total 6 259 040.
- Effect: "Afeta o nível máximo dos soldados". `PawnTempInfos.NeedBuilding` lists the Quartel template required per soldier level; recruit discount `Property4` is 0 in every row ([../army/README.md](../army/README.md)).

### Santuário (501), rows 50101..50180

- `PreTemplateId = 90100 + L` except level 71 whose prerequisite is 90161 (data quirk, keep it). `PlayerGrades = 1`.
- Gold to reach L: 0, 10, 30, 50, 80, 120, 150, 200, 250, 310 for L = 1..10; 560 + 180 * (L - 11) for 11..20; 3300 + 1240 * (L - 21) for 21..30; 17660 + 3200 * (L - 31) for 31..50; 83580 + 5120 * (L - 51) for 51..60; 136740 + 7080 * (L - 61) for 61..70; 211260 + 10800 * (L - 71) for 71..80. Total 6 415 700.
- `NextTemplateId` lists the technologies unlocked at that level ([technologies.md](technologies.md)).
- Created by the server when the Leader reaches level 18 (`UpGradeTempInfos` Types 3, Grades 18, `ActiveObject 50101`); the castle shows a gray placeholder with "Função habilitada no Nv. 18" before that (`CWL:194-226`).

### Upgrade time

`UpgradeTime` (seconds) is identical for every 80 level row (buildings and technologies): 0 at level 1 (or 0); 5 for 2..20; 10, 20, 30, 60 for 21..24; 120 + 60 * (L - 25) for 25..37; 900 for 38..80. No reachable client UI shows a timer (see [build-queue.md](build-queue.md)). Assumption: upgrades complete immediately and `UpgradeTime` is ignored.

### Castle creation

When a player castle is created (character creation or first 8281): insert Prefeitura 90101 and Quartel 40201. Assumption: also create the Transmissor energy state ([transmitter.md](transmitter.md)) and the resources row ([resources.md](resources.md)) with `Player_Gold = 0`, `Player_WaterCrystal = 1000`, `Player_ResourceMax = 10000`.

### Upgrade side effects

| Upgraded SonType | Side effect |
|---|---|
| 901 | gold per hour changes: accrue production up to now with the old rate first, then push 109 ([resources.md](resources.md)) |
| 402 | soldier family caps change ([../army/README.md](../army/README.md)); assumption: no push beyond 4130 |
| 501 | create the technology rows listed in the new level `NextTemplateId` at grade 0, include them in the same 4130 |
| 13xx, 23xx (MasterType 13) | gold per hour changes (accrue first), push 109 |
| 14xx, 24xx (MasterType 14) | hero and soldier attributes change, push hero attributes ([../hero/README.md](../hero/README.md)) |

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `raw/xml/tempinfos/BuildingTempInfos.xml` (2189 rows) | `BuildingTempInfo` (`decompiled/core_module/scripts/yishi/datas/templates/BuildingTempInfo.as`) | `TemplateId`, `Camp` (always 1), `BuildingName`, `MasterType`, `SonType`, `BuildingGrade`, `PreTemplateId` (comma list), `NextGradeTemplateId`, `NextTemplateId` (comma list of unlocked rows), `PlayerGrades`, `CrystalsConsume`, `GoldConsume`, `Reputation`, `UpgradeTime`, `Property1` (901 gold per hour; technologies `EffectTempInfos` id), `Property2` (1511 max energy 500), `Property3..6`, `Description`, `Activity` (pt-BR effect text), `Icon`, `PosX`, `PosY`, `TitleX`, `TitleY`, `PicPath` |
| `raw/xml/tempinfos/ConfigInfos.xml` | `ConfigInfo` | `Castle_Building = 901,402`, `BUILD_MAX_GRADE = 80`, `Player_ResourceMax = 10000`, `Player_Gold = 0`, `Player_WaterCrystal = 1000` |
| `raw/xml/tempinfos/UpGradeTempInfos.xml` | `Types = 3` | `Grades = 18`, `ActiveObject = 50101` |
| `raw/xml/tempinfos/BuildingResInfos.xml` | legacy per level sprites | no client reference, ignore |

## 7. Persistent state

```sql
CREATE SCHEMA IF NOT EXISTS castle;

CREATE TABLE castle.buildings (
    building_id   integer     GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    player_id     bigint      NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
    son_type      integer     NOT NULL,
    template_id   integer     NOT NULL,
    level         smallint    NOT NULL CHECK (level BETWEEN 0 AND 80),
    property1     integer     NOT NULL DEFAULT 0,
    property2     integer     NOT NULL DEFAULT 0,
    created_at    timestamptz NOT NULL DEFAULT now(),
    updated_at    timestamptz NOT NULL DEFAULT now(),
    CONSTRAINT buildings_player_son_type_key UNIQUE (player_id, son_type),
    CONSTRAINT buildings_template_matches CHECK (template_id = son_type * 100 + level)
);
CREATE INDEX buildings_player_idx ON castle.buildings (player_id);
```

Notes: `level` is redundant with `template_id` but keeps queries simple. `property1` / `property2` mirror `BuildingInfoMsg.propterty1/2`; for the Prefeitura they are derived from [levy.md](levy.md) state at send time (assumption: do not store them twice). `building_id` fits INT32 as the protocol requires.

## 8. Backend implementation notes

- `castle::buildings::handle_login_load`: called by the account login handler for 8224 when `castle` / `build` flags are set; sends 4153 (data from world-map castle node, transmitter energy) and 4154 with every row of `castle.buildings`.
- `castle::buildings::handle_init` (8281): in one transaction ensure the resources row and the default buildings; send 4130 with the rows and 366.
- `castle::buildings::handle_upgrade` (8203), validation order mirrors the client: building belongs to the player; not max; next template exists; prerequisites; Leader level; gold and crystals. Transaction: lock `castle.resources` and the building row (`SELECT ... FOR UPDATE`), accrue production up to now ([resources.md](resources.md)), deduct costs with ledger entries, update the row, insert unlocked technologies when SonType is 501. After commit send 4130 (upgraded row first, new rows after), 109, and the hero attribute push for MasterType 14.
- `castle::buildings::handle_create` (8202): resolve the minimum grade template of the SonType; reject if a row of that SonType exists; same checks and transaction as upgrade.
- `castle::buildings::on_leader_level_up(player, level)`: called by the hero feature; when `UpGradeTempInfos(Types 3, Grades level).ActiveObject` is a building template (50101 at 18) and the building is missing, insert it and push 4130 (plus technology 130400 unlocked by Santuário level 1).
- No other player is notified. No timers (upgrades are immediate).

## 9. Open questions and assumptions

- Assumption: upgrades are instant; `UpgradeTime` is unused because the construction queue UI is unreachable ([build-queue.md](build-queue.md)).
- Assumption: 8281 is idempotent and also creates the activity queue rows.
- Assumption: `BaseCastleMsg.grade` is the Prefeitura level.
- Open: whether the original server rejected Quartel / Santuário upgrades beyond the Leader level. Data only binds them to the Prefeitura level; keep the template rules.
- Open: the Santuário level 71 prerequisite 90161 looks like a data typo; keep it for fidelity.

## 10. Implementation checklist

- [ ] Table `castle.buildings` with constraints.
- [ ] Castle creation inserts 90101 and 40201.
- [ ] 4153 and 4154 in the login load, in this order.
- [ ] `handle_init` (8281) returns 4130 and 366.
- [ ] `handle_upgrade` (8203) with every check and the ledger.
- [ ] `handle_create` (8202).
- [ ] 4130 push for Santuário creation at Leader 18 and technology unlocks.
- [ ] 109 after every gold / crystal change.
- [ ] Prefeitura, Quartel, Santuário formulas verified against all 240 rows.
- [ ] Test: upgrade Prefeitura 1 to 2 with 200 gold; Quartel 2 blocked until Prefeitura 2; Prefeitura 3 blocked at Leader 2; max level 80 rejected.
- [ ] Test: Leader 18 creates Santuário 50101 and technology 130400.
