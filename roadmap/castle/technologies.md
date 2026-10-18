# Santuário technologies

Aliases: see [README.md](README.md). Extra aliases:

| Alias | File |
|---|---|
| SF | `decompiled/m4/scripts/buildings/seminary/view/SeminaryFrame.as` |
| SFB | `decompiled/m4/scripts/buildings/seminary/view/SeminaryFrameBottomView.as` |
| TI | `decompiled/m4/scripts/buildings/seminary/view/TechnologyItem.as` |
| MTL | `decompiled/m4/scripts/buildings/seminary/view/MilitaryTechnologyList.as` |
| EBI | `decompiled/core_module/scripts/ui/toptoolbar/view/ExtraBufferItem.as` |
| TTB | `decompiled/core_module/scripts/ui/toptoolbar/TopToolsBar.as` |
| SBF | `decompiled/m11/scripts/seminaryBless/SeminaryBlessFrame.as` |

## 1. Overview

The Santuário (SonType 501, "Santuário", map placeholder "Seminário") hosts 24 technologies ("Tecnologia"). Each technology is a building row with MasterType 13 (gold production) or 14 (hero and soldier attributes), levels 0..80, paid only with light crystals ("Cristal de Luz"). Santuário levels unlock technologies and cap their level. Effects are permanent passive bonuses: gold per hour, soldier HP / attack / defense / magic / resistance, hero attack / magic / defense / resistance / HP, and "Infantaria".

A legacy blessing wheel ("Roleta da Benção", m11) raised a daily technology effect percentage; its entry points are disabled in this build (section 3, R3).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `buildings.seminary.view.SeminaryFrame` (SF) | "Santuário Nv. {N}" (base frame title) | Santuário upgrade (base frame) and a 12 slot page of technologies with page buttons (`SF:88-139`, `SF:164-201`); records fighting capacity before and after (`SF:65`, `SF:329-333`) | Santuário click ([scene.md](scene.md)), top bar technology buff icon (`EBI:84-91`, type 2) | every `BuildInfo` with MasterType 13 / 14 sorted by `sonType` (`SF:170-180`); page "n/m" |
| `buildings.seminary.view.TechnologyItem` (TI) | technology name, level | Icon, level, "Elevar" button, "new" icon at grade 0 (`TI:176-223`), advanced background when `TemplateId > 200000` (`TI:190-197`), tooltip `BuildTip` | SF | template of the row (grade 0 uses the min grade template) |
| `buildings.seminary.view.SeminaryFrameBottomView` (SFB) | "Cristais de Luz" counter | Crystal balance, turns red when hovering an unaffordable technology (`SFB:63-79`), tip "Cristais de Luz são recursos obrigatórios na pesquisa de tecnologias, obtidos principalmente na Yggdrasil, saqueamento e campanhas" | SF | `ResourceManager.waterCrystal.count` |
| `seminaryBless.SeminaryBlessFrame` (SBF) | "Roleta da Benção" | Spin to raise the technology effect percentage | unreachable (R3) | `playerInfo.seminaryEffect`, crystals |
| Help frame | "Explicação" | `buildings.seminary.view.SeminaryFrame.helpContent` | SF help button | static text |

## 3. Routes (client to server)

### R1. Upgrade a technology

- UI: "Elevar" on a `TechnologyItem` (`TI:130-137`) dispatches `TEC_UPGRADE_CLICK`, handled by `SFB.__tecUpgradeHandler` (`SFB:89-116`).
- Client checks: row with `building_id != 0`: max level gives "Já está no nível máximo" (`SFB:97-105`); then `BuildingManager.isUpgradeAvaliable` ([buildings.md](buildings.md) R3: crystals, prerequisite Santuário level, Leader level).
- Route: C>S 8203 (0x200b) `C_BUILDING_UPGRADE`, `building.BuildingOptionReqMsg.building_id (#1, INT32)`.
- Response: 4130 with the upgraded row (`TechnologyItem` refreshes through `TechnologyItemEvent.UPDATA`, `SF:304-312`; top bar buff refresh through `UPDATE_EXTRABUFFER`, `BM:161-164`), 109 with the new crystal balance, and for MasterType 14 the hero attribute push. MasterType 13 changes gold per hour: also 109 with the new `gold_yield`.

### R2. Create a technology

- UI: same button when the row has `building_id == 0` (`SFB:111-114`). Dormant: the server always sends unlocked technologies as rows with ids.
- Route: C>S 8202 (0x200a) `C_BUILDING_CREATE`, `BuildingOptionReqMsg.son_type (#2, INT32)`. See [buildings.md](buildings.md) R4.

### R3. Spin the blessing wheel (legacy)

- UI: `SeminaryFrame._blessBtn` is created but only added when a hard coded flag is true, and it is false (`SF:114-134`); `openControllerByInfo("seminarybless")` is otherwise reached only from the top bar buff type 3 (`EBI:92-97`), and `TopToolsBar` never creates a type 3 item (`TTB:1975-2054`). Unreachable in this build.
- Client checks (`SBF:291-319`): crystals >= 2000 ("Cristais de Luz insuficiente, não é capaz de abrir a roleta"); a daily "Necessário consumir 2000 Cristais de Luz por vez" confirmation; when the server hour is between 3 and 5 a warning "Tempo restante da Benção é inferior à 2 horas, continuar ativação da roleta?"; button disabled at 200 percent.
- Sender: `SBF.sendBless` (`SBF:370-379`).
- Route: C>S 8489 (0x2129) `C_BLESSING_ALTER`, empty body.
- Response: 4391 (S2), then 109 (crystals), then hero attribute push.

## 4. Server messages (server to client)

### S1. 4130 (0x1022) `U_C_BUILDINGINFO_LIST`

See [buildings.md](buildings.md) S3. Technology rows: `template_id` = technology template at the current grade, `son_type` = 13xx / 14xx / 23xx / 24xx, `propterty1/2 = 0`.

### S2. 4391 (0x1127) `U_C_BLESS_REFRESH` (legacy)

Message `player.BlessingMsg`. Receiver `SBF.__refreshBlessHandler` (`SBF:197-226`, only while the frame is open).

| Field | Tag, type | Meaning |
|---|---|---|
| `increase` | #1 INT32 | percentage points added by this spin; client shows `old + increase`, capped at 200 |
| `used_count` | #2 INT32 | spins used today (not read by the frame) |
| `max_count` | #3 INT32 | spins allowed today (not read by the frame) |

Related fields owned by [../hero/README.md](../hero/README.md): `PlayerMsg.blessingCount (#65)`, `blessingBuff (#66)`, `blessingMaxCount (#67)` (`decompiled/core_module/scripts/yishi/manager/PlayerManager.as:996-1000`, `:689`), and the daily reset `DataResetMsg.blessing_count (#9)`, `blessing_buff (#10)` on 4202 (`decompiled/core_module/scripts/yishi/manager/BaseManager.as:1874-1885`).

## 5. Rules and formulas

### Unlock order

The Santuário row `NextTemplateId` lists technology templates at grade 0 that the server must create when the Santuário reaches that level:

| Santuário level | Unlocked template | SonType | pt-BR name | Effect (`EffectTempInfos`) | Per level |
|---|---|---|---|---|---|
| 1 | 130400 | 1304 | "Produção de Ouro" | 1104, PropertyType 104, gold per hour | +240 |
| 2 | 144500 | 1445 | "Vida Adicional" | 1145, PropertyType 145, hero HP | +80 |
| 3 | 142000 | 1420 | "Vida do Soldado" | 1120, PropertyType 120, soldier HP | +20 |
| 4 | 144100 | 1441 | "Ataque Adicional" | 1141, PropertyType 141, hero attack | +48 |
| 5 | 142100 | 1421 | "Ataque do Soldado" | 1121, PropertyType 121, soldier attack | +24 |
| 6 | 144200 | 1442 | "Magia Adicional" | 1142, PropertyType 142, hero magic | +48 |
| 7 | 142300 | 1423 | "Magia do Soldado" | 1123, PropertyType 123, soldier magic | +24 |
| 8 | 144300 | 1443 | "Defesa Adicional" | 1143, PropertyType 143, hero defense | +32 |
| 9 | 142200 | 1422 | "Defesa do Soldado" | 1122, PropertyType 122, soldier defense | +16 |
| 10 | 144400 | 1444 | "Resistência Adicional" | 1144, PropertyType 144, hero resistance | +32 |
| 11 | 142400 | 1424 | "Resistência do Soldado" | 1124, PropertyType 124, soldier resistance | +16 |
| 12 | 144600 | 1446 | "Infantaria Adicional" | 1146, PropertyType 146, "Adição de Infantaria" | +16 |
| 55 | 230400, 244500, 242000, 244100, 242100, 244200, 242300, 244300, 242200, 244400, 242400, 244600 | 2304, 2445, 2420, 2441, 2421, 2442, 2423, 2443, 2422, 2444, 2424, 2446 | same names with "Avançado" / "Avançada" | 1204, 1245, 1220, 1241, 1221, 1242, 1223, 1243, 1222, 1244, 1224, 1246 (PropertyType 2xx) | same values |

When a Santuário is upgraded several levels at once (never, upgrades are one level), or on data repair, create every missing technology unlocked at or below the current Santuário level.

### Costs and caps

- Basic technology level L (1..80): `CrystalsConsume = 50 + 5 * L * (L - 1)` for L <= 71; `24900 + 720 * (L - 71) + 10 * (L - 72) * (L - 71)` for 72..80 (50 at L1, 500 at L10, 32 100 at L80; total 858 850). Gold 0.
- Advanced technology: exactly 5 times the basic cost (250 at L1, 160 500 at L80; total 4 294 250).
- Prerequisite: basic level L needs Santuário level L (`PreTemplateId = 50100 + L`); advanced level L needs Santuário level max(50, L) (`50150` for L <= 50, `50100 + L` above); advanced rows only exist after Santuário 55.
- `PlayerGrades = 1` for every technology row. `UpgradeTime` as buildings (ignored, see [buildings.md](buildings.md)).
- Level 0 rows (`xx00`) cost nothing and have empty `PreTemplateId`; `Activity` shows "+0".

### Effects

- Bonus of one technology = `EffectTempInfos[Property1].Property1 * BuildingGrade`; basic and advanced stack (gold +19 200 per hour each at level 80).
- The top bar buff tooltip parses `Activity` ("Produção de Ouro +240/h", "Vida do Soldado +20") and sums values by name (`EBI:232-262`, `TTB:1988-1994`).
- Gold technologies (1304, 2304) are part of `gold_yield` and of `CastleYieldMsg.gold_technology` ([resources.md](resources.md)).
- Attribute technologies feed hero and soldier stats computed by [../hero/README.md](../hero/README.md) and [../army/README.md](../army/README.md); PropertyType ids are those of `EffectTempInfos` (see `docs/mechanics/skills_buffs.md`).
- Castle bubble "castle.seminary" shows when the job attack technology (1441 / 2441 for jobs 1, 2, 4, 5; 1442 / 2442 for jobs 3, 6) can be afforded (`CWL:54-61`, `CWL:609-646`).

### Blessing wheel (legacy)

Config (`raw/xml/tempinfos/ConfigInfos.xml`): `Blessing_Grade = 41` (Leader level), `Blessing_Buffer = 10` (default percent), `Blessing_Cast = 2000` (crystals per spin), `Blessing_ItemId = 208026` (consumable alternative, assumption), `Blessing_Max = 200` (percent cap). Help text: spins and the percentage reset daily ("redefinido para 10%"; tooltip says 05:00, help says 0h). Assumption: the percentage multiplies the attribute technology bonuses; since the UI is unreachable and the default is 10, keep `blessing_buff = 10` and do not apply it to stats unless the original formula is confirmed.

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `raw/xml/tempinfos/BuildingTempInfos.xml` | technology level rows (24 SonTypes x 81 rows) | `TemplateId`, `SonType`, `MasterType`, `BuildingGrade`, `PreTemplateId`, `NextGradeTemplateId`, `CrystalsConsume`, `Property1` (effect id), `Activity`, `Icon` (`/science_*.png`), `BuildingName` |
| Santuário rows 50101..50180 | | `NextTemplateId` (unlock list) |
| `raw/xml/tempinfos/EffectTempInfos.xml` | effect | `TemplateId`, `PropertyType1`, `Property1` (value per level), `Description` |
| `raw/xml/tempinfos/ConfigInfos.xml` | | `Blessing_*` |

## 7. Persistent state

Technology rows live in `castle.buildings` ([buildings.md](buildings.md)). Blessing state:

```sql
CREATE TABLE castle.blessings (
    player_id     bigint   PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
    effect_percent smallint NOT NULL DEFAULT 10 CHECK (effect_percent BETWEEN 0 AND 200),
    used_count    smallint NOT NULL DEFAULT 0 CHECK (used_count >= 0),
    reset_on      date     NOT NULL DEFAULT current_date
);
```

Effect totals are derived (no table): `SELECT son_type, level FROM castle.buildings WHERE player_id = $1 AND son_type BETWEEN 1300 AND 2499`.

## 8. Backend implementation notes

- Upgrades go through `castle::buildings::handle_upgrade` (8203); after the update call `castle::technologies::on_upgraded(player, row)` which, for MasterType 14, asks the hero feature to recompute attributes and push them, and for MasterType 13 accrues gold first and pushes 109.
- `castle::technologies::unlock_for_sanctuary_level(player, level)`: insert missing rows from `NextTemplateId` of every Santuário row up to `level` (grade 0, `template_id = son_type * 100`). Called from the Santuário upgrade and from Santuário creation at Leader 18.
- `castle::technologies::effect_totals(player) -> map<PropertyType, i32>`: exported API used by hero and army stat computation and by the gold yield.
- `castle::technologies::handle_bless` (8489, legacy): check Leader >= 41, crystals >= 2000, `effect_percent < 200`, daily count (max unknown); deduct crystals; roll `increase` (distribution unknown); cap 200; send 4391, 109. Daily reset sets `effect_percent = 10`, `used_count = 0` and is reported through 4202 by the hero / daily reset owner.

## 9. Open questions and assumptions

- Assumption: unlocked technologies are created by the server as grade 0 rows (the client shows the "new" icon for grade 0 rows and only renders rows it received).
- Open: PropertyType 146 / 246 "Infantaria" meaning (troop command or infantry bonus); owned by army stats.
- Open: blessing `increase` distribution, daily spin count and whether the percentage affects stats.

## 10. Implementation checklist

- [ ] `unlock_for_sanctuary_level` creates the 12 basic rows at Santuário 1..12 and 12 advanced rows at 55.
- [ ] Crystal cost and prerequisite checks for basic and advanced rows.
- [ ] 4130 + 109 (+ hero push) after an upgrade.
- [ ] `effect_totals` exported to hero, army and gold yield.
- [ ] Optional legacy: `castle.blessings`, 8489 / 4391.
- [ ] Test: Santuário 4 shows 1304, 1445, 1420, 1441; upgrade 1304 to 5 with 450 crystals total; 1304 level 5 blocked at Santuário 4.
- [ ] Test: Santuário 55 shows 24 technologies; advanced level 51 needs Santuário 51.
