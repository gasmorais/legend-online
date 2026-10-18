# Castle resources: gold, light crystals, population

Aliases: see [README.md](README.md). Extra aliases:

| Alias | File |
|---|---|
| RD | `decompiled/core_module/scripts/yishi/datas/resource/ResourceData.as` |
| RV | `decompiled/core_module/scripts/ui/resourcebar/view/ResourceView.as` |
| RB | `decompiled/core_module/scripts/ui/resourcebar/ResourcesBar.as` |
| OCC | `decompiled/m3/scripts/map/outercity/OuterCityController.as` |
| FI | `decompiled/m4/scripts/buildings/politics/view/FieldItem.as` |

## 1. Overview

The castle owns three resources that the client keeps in `ResourceManager`, separate from `PlayerInfo`:

| Resource | pt-BR | Client field | Pseudo item id | Cap | Main uses |
|---|---|---|---|---|---|
| Gold | "Ouro" | `RM.gold` (`baseYield`, `count`, `limit`) | -100 | `gold_max` from the server (initial `Player_ResourceMax = 10000`) | building upgrades, soldier recruitment, many fees |
| Light crystal | "Cristal de Luz" (also "Cristais de Luz") | `RM.waterCrystal` | -600 | 100 000 000 (hard coded, `RM:75`) | technologies, blessing wheel |
| Population | "População" | `RM.population` (`count` used, `limit` max) | none | `max_population` | soldier recruitment (`PawnTempInfos.NeedPopulation`) |

The only message that updates them is 109 `U_C_CASTLE_UPDATE` with `castle.CastleYieldMsg` (`RM:64-77`). The client asks for it every 30 s (`RM:39-41`, `RM:54-57`) and when the resource bar is built (`RB:101`). The server also pushes 109 after any change, including changes made by other features (smith, army, shops, rewards).

Gold is produced every hour by the Prefeitura, gold technologies and occupied wild lands. Production is computed server side; the client only displays the per hour value in a tooltip.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `ui.resourcebar.view.ResourceView` (RV) | gold item | Gold counter (red frame and "Limite atingido" overlay `GoldOvertopView` when `count >= limit`, `RV:510-545`), floating "+N" effect on increase, coin sound every multiple of 500 (`RV:499-509`) | HUD, always | `gold.count`, tooltip "Produção interna: {baseYield - fieldYield}/hr" plus Midas bonus "+{n} (bônus de magia)" (`RV:290-312`) |
| `buildings.seminary.view.SeminaryFrameBottomView` | "Cristais de Luz" | crystal counter | Santuário | `waterCrystal.count` |
| `buildings.politics.view.PoliticsFieldView`, `FieldItem` (FI) | "Nome do recurso", "Coordenadas do recurso", "Produção do recurso", "Tempo restante", "Ação" | Legacy wild land list in the Prefeitura | never instantiated (`PoliticsFrame` declares `_fieldList` but never creates it) | `BMOD.fieldDic` |

## 3. Routes (client to server)

### R1. Resource sync

- UI: timer every 30 000 ms (`RM:39-41`), resource bar init (`RB:101`).
- Sender: `RM.sendSyncResources` (`RM:106-110`).
- Client checks: none.
- Route: C>S 5015 (0x1397) `U_C_CASTLE_UPDATE`, empty body.
- Response: 109 (S1).

### R2. Abandon a wild land

- UI: world map context menu "give up" on an owned resource node (`OCC.sendGiveUp`, `OCC:1334-1342`, owned by [../world-map/README.md](../world-map/README.md)); legacy Prefeitura field list "Abandonar território selvagem" with confirm "Abandonar mina natural?" (`FI:100-122`, unreachable).
- Client checks: node owner is the player (`OCC:1336`).
- Sender: `BSOM.unoccupy(position)` (`BSOM:84-90`).
- Route: C>S 5179 (0x143b) `U_C_UNOCCPWILDLAND`.
- Request `building.BuildingReqMsg`: `position (#2, STRING)` = `"x,y"` of the node; `order_id (#1)`, `index (#3)`, `user_id (#4)` unset.
- Response: 108 (S3), then 152 (S2) with the remaining lands, then 109 with the new `gold_yield`. World map node refresh is owned by world-map.

## 4. Server messages (server to client)

### S1. 109 (0x006d) `U_C_CASTLE_UPDATE`

Message `castle.CastleYieldMsg`. Receiver `RM.__resourceUpgrade` (`RM:64-77`): `gold.synchronizationResource(gold_yield, gold_total_count, gold_max)`, `waterCrystal.synchronizationResource(0, crystals_count, 100000000)`, `population.synchronizationResource(0, cur_population, max_population)`. Each sync dispatches `RESOURCE_UPDATE` with the delta (`RD:31-38`).

| Field | Tag, type | Meaning | Read |
|---|---|---|---|
| `gold_yield` | #1 INT32 | total gold per hour (all sources, before the Midas bonus, assumption) | yes, `baseYield` |
| `gold_wild_land_yield` | #2 INT32 | part of the yield from wild lands | no |
| `gold_technology` | #3 INT32 | part from gold technologies | no |
| `gold_wonder` | #4 INT32 | part from wonders (legacy, 0) | no |
| `gold_dower` | #5 INT32 | part from dowry / other (legacy, 0) | no |
| `gold_total_count` | #6 INT32 | current gold | yes, `count` |
| `gold_max` | #7 INT32 | gold cap | yes, `limit` |
| `cur_population` | #8 INT32 | population used | yes |
| `max_population` | #9 INT32 | population cap | yes |
| `wildYield` | #10 MESSAGE `WildYieldMsg`, repeated | ignored on 109 | no |
| `crystals_count` | #11 INT32 | current light crystals | yes |

When: response to 5015; push after every change of gold, crystals, population or yield (upgrades, taxes, rewards, purchases, recruitment, wild land changes).

### S2. 152 (0x0098) `U_C_SECURITY_INFO_UPDATE`

Same message `CastleYieldMsg`; only `wildYield` is read. Receiver `BM.__politicsDataHandler` (`BM:80-110`): clears `fieldDic` and refills it keyed by `wild_pox_name`, dispatches `U_SECURITY_INFO_UPDATE`. Used by the gold tooltip (`fieldYield` = sum of `wild_yield`, `RV:154-166`).

`castle.CastleYieldMsg.WildYieldMsg`:

| Field | Tag, type | Meaning |
|---|---|---|
| `wild_pox_name` | #1 STRING | key of the land (client uses it as site) |
| `wild_pox` | #2 STRING | `"x,y"` position (sent back in 5179) |
| `wild_grade` | #3 INT32 | land level |
| `wild_name` | #4 STRING | land name |
| `wild_yield` | #5 INT32 | gold per hour from this land |
| `wild_refresh_time` | #6 INT32 | seconds left / refresh period (`MapPhysicsTempInfos.RefreshTime = 7200`, assumption) |
| `map_id` | #7 INT32 | world map id |
| `create_time` | #8 STRING | `YYYY-MM-DD hh:mm:ss`, occupation time |

When: at login (assumption) and whenever the set of occupied lands changes (world-map occupation, expiry, abandon).

### S3. 108 (0x006c) `U_C_UNOCCPWILDLAND`

Message `building.GiveupWildLandMsg`: `wild_land_pos (#1, STRING)`. Receiver `BM.__unoccupyHandler` (`BM:255-268`): non empty position shows "Abandono de território selvagem sucedido" and dispatches `U_UNOCCPWILDLAND` (world map refresh, `OCC:831`). Empty string means failure (no tip).

## 5. Rules and formulas

- Gold per hour (assumption, consistent with the tooltip `RV:298` and the template values):
  `gold_yield = Prefeitura.Property1 + sum(EffectTempInfos[tech.Property1].Property1 * tech.level for tech in {1304, 2304}) + sum(wild_yield)`.
  `gold_technology` and `gold_wild_land_yield` report the two parts.
- Midas bonus ("Toque de Midas", Fonte Mágica buffer 1, [../fantasy-bar/README.md](../fantasy-bar/README.md)): the client shows `floor(AddValue * internal / 100)` extra per hour where `internal = gold_yield - fieldYield` (`RV:298-305`). Assumption: real production adds that bonus on the internal part only.
- Accrual: `gold += floor(gold_yield_effective * elapsed_seconds / 3600)`, applied lazily (on 5015, on any gold read or write, at login). Production stops at `gold_max`; gold from other sources may exceed the cap (the client handles `count > limit`, `RV:533-545`). Assumption.
- Gold cap: initial 10 000 (`Player_ResourceMax`). Open: how `gold_max` grows (no template carries it). Proposal: server config per Prefeitura level, default 10 000 until confirmed.
- Light crystals: no production; granted by rewards (campaigns, Yggdrasil tree, plunder per the help text) and spent by technologies. Hard cap 100 000 000.
- Population: `cur_population` = population used by soldiers; `max_population` = cap. Open: the cap source (residences, MasterType 12, have no rows in this build). Proposal: config value, see [../army/README.md](../army/README.md) recruitment.
- Initial values at castle creation: gold `Player_Gold = 0`, crystals `Player_WaterCrystal = 1000`.
- `ResourceManager.canSubtractResources(gold, crystals, population)` (`RM:79-104`) is the client pre check used by every castle cost; the server must re-check.

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `raw/xml/tempinfos/BuildingTempInfos.xml` | 901 rows | `Property1` gold per hour |
| `raw/xml/tempinfos/EffectTempInfos.xml` | 1104, 1204 | `Property1` = 240 gold per hour per level |
| `raw/xml/tempinfos/ConfigInfos.xml` | | `Player_ResourceMax = 10000`, `Player_Gold = 0`, `Player_WaterCrystal = 1000` |
| `raw/xml/tempinfos/MagicSpringTempInfos.xml` | buffer 1 | `AddValue` (Midas percent), owned by fantasy-bar |
| `raw/xml/tempinfos/MapPhysicsTempInfos.xml` | wild lands (MasterType 21) | `RefreshTime`, yields, owned by world-map |

## 7. Persistent state

```sql
CREATE TABLE castle.resources (
    player_id         bigint      PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
    gold              bigint      NOT NULL DEFAULT 0     CHECK (gold >= 0),
    gold_max          integer     NOT NULL DEFAULT 10000 CHECK (gold_max >= 0),
    crystals          bigint      NOT NULL DEFAULT 1000  CHECK (crystals BETWEEN 0 AND 100000000),
    population_used   integer     NOT NULL DEFAULT 0     CHECK (population_used >= 0),
    population_max    integer     NOT NULL DEFAULT 0     CHECK (population_max >= 0),
    accrued_at        timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE castle.resource_ledger (
    entry_id     bigint      GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    player_id    bigint      NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
    resource     text        NOT NULL CHECK (resource IN ('gold', 'crystals', 'population')),
    delta        bigint      NOT NULL,
    balance      bigint      NOT NULL,
    reason       text        NOT NULL,
    reference_id text,
    created_at   timestamptz NOT NULL DEFAULT now()
);
CREATE INDEX resource_ledger_player_created_idx ON castle.resource_ledger (player_id, created_at DESC);
```

Wild land ownership is stored by world-map; this module only reads it to compute `gold_yield` and to build 152. The protocol carries INT32: clamp `gold` to 2 147 483 647 when serializing (assumption).

## 8. Backend implementation notes

- `castle::resources::handle_sync` (5015): lock nothing; compute accrual in a short transaction (`UPDATE ... SET gold = LEAST(gold + produced, GREATEST(gold, gold_max)), accrued_at = now()`), then send 109.
- Shared API for every feature (single transaction with the caller): `castle::resources::accrue(tx, player)`, `spend_gold(tx, player, amount, reason, reference)`, `add_gold(...)`, `spend_crystals(...)`, `add_crystals(...)`, `use_population(...)`, `free_population(...)`. Each call accrues first, checks the balance, writes the ledger, and marks the session "resources dirty"; the dispatcher sends one 109 after commit.
- `castle::resources::gold_yield(player)`: Prefeitura + gold technologies + wild lands; used by 109 and by accrual. Recompute after Prefeitura or gold technology upgrades and wild land changes (accrue with the old rate before the change).
- `castle::resources::handle_abandon_wild_land` (5179): validate the land belongs to the player (world-map API), release it, accrue, send 108, 152, 109. On failure send 108 with an empty `wild_land_pos`.
- Login: after 4153 / 4154 the client sends 5015 itself; also push 152 when the player owns wild lands (assumption).
- No timers: accrual is lazy.

## 9. Open questions and assumptions

- Open: `gold_max` growth rule and `max_population` source.
- Assumption: production stops at the cap; other income may exceed it.
- Assumption: Midas bonus applies to the internal (non wild land) yield only and is not included in `gold_yield`.
- Assumption: 152 is pushed at login when lands exist.
- Coordination: [../currency/README.md](../currency/README.md) should treat gold (-100) and light crystals (-600) as castle resources and call this API.

## 10. Implementation checklist

- [ ] Tables `castle.resources`, `castle.resource_ledger`.
- [ ] `handle_sync` (5015) with lazy accrual, 109 response.
- [ ] Shared spend / add API with ledger and a single 109 per request.
- [ ] `gold_yield` formula and part fields `gold_technology`, `gold_wild_land_yield`.
- [ ] 152 assembler and `handle_abandon_wild_land` (5179) with 108.
- [ ] Test: 1 hour offline at Prefeitura 10 gives 5 115 gold (cap permitting); cap 10 000 stops production.
- [ ] Test: technology upgrade lowers crystals and 109 reflects it.
