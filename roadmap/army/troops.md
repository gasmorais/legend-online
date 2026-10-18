# Troops and army sync (Tropa)

Path aliases:

| Alias | File |
|---|---|
| AM | `decompiled/core_module/scripts/yishi/manager/ArmyManager.as` |
| SGR | `decompiled/core_module/scripts/map/internals/utils/SocketGameReader.as` |
| TIH | `decompiled/core_module/scripts/com/road/pb/helper/army/ThaneInfoHelper.as` |
| AP | `decompiled/core_module/scripts/mvc/module/armyII/ArmyPawn.as` |
| PP | `decompiled/core_module/scripts/mvc/module/armyII/PawnProperty.as` |
| BA | `decompiled/core_module/scripts/mvc/module/armyII/BaseArmy.as` |
| AMOD | `decompiled/core_module/scripts/mvc/module/armyII/ArmyModel.as` |

## 1. Overview

The client keeps three soldier collections in `ArmyManager` (AM:68-94):
- `army: UserArmy` (`BaseArmy`): the player's army. `armyPawns[0]` (site 0) is the troop led by the hero; `baseHero` is the hero (`ThaneInfo`), `viceHero` the vice hero.
- `castlePawnList`: castle reserve, one `ArmyPawn` per soldier `SonType` with `ownPawns` = soldiers stored in the castle.
- `casernPawnList`: barracks catalogue, initialized with the 11 level 1 soldiers `10<i>01` / `1<i>01` for i = 1..11 (AM:130-150), marked `canRecruit` when the server lists them.

The server sends the whole army at login with 150 and incremental updates with 92/100 (reserve) and 93 (hero troop). This module defines the data model; actions are in [recruitment.md](recruitment.md), [pawn-upgrade.md](pawn-upgrade.md) and [formation.md](formation.md).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `armyII.AllocateFrame` | "Tropa" (`armyII.AllocateFrame.title`) | Hero troop panel | `PAWN_PANEL` | `AllocateView` |
| `armyII.viewII.allocate.AllocateView` | buttons "Recrutar soldado", front/back row tips | Troop cells (`PawnDragCell` per reserve type with soldiers, `SoldierDragCell` for site 0), total count, auto allocate | AllocateFrame | `castlePawnList` filtered by `ownPawns > 0` (`decompiled/m5/scripts/armyII/viewII/allocate/AllocateView.as:269-346`), `countAllArmyPawnNmber()` |
| `yishi.view.tips.PawnTip` | | Soldier tooltip | cells | template stats, totals from `PawnProperty` |

## 3. Routes (client to server)

None specific: the army is pushed. Actions that change it are routes of other modules (5155, 5156, 5157, 5158, 8276, 8455, 8456, 8580).

## 4. Server messages (server to client)

### S1. 150 (0x0096) `U_C_SERIAL_ARMY`
- Message `ArmyMsg` (army): `army_id` (#1, INT32), `player_id` (#2, INT32), `nick_name` (#3, STRING), `map_id` (#4, INT32), `cur_pos_x` (#5, INT32), `cur_pos_y` (#6, INT32), `state` (#7, INT32), `type` (#8, INT32), `armyPawn` (#9, `ArmyPawnInfoMsg`, repeated), `simple_hero_info` (#10, `SimpleHeroInfoMsg`), `consortia_id` (#11, INT32), `consortia_name` (#12, STRING), `fightingCapacity` (#13, INT32), `gpOrder` (#14, INT32), `grades` (#15, INT32), `arm` (#16, STRING), `cloth` (#17, STRING), `job` (#18, INT32), `change_sharp` (#19, INT32), `hero_tempId` (#20, INT32), `userIds` (#21, INT32, repeated), `geste` (#22, INT32), `is_vip` (#23, BOOL), `vip_type` (#24, INT32), `mount_tempId` (#25, INT32), `mount_grade` (#26, INT32), `wing` (#27, STRING), `server_name` (#28, STRING), `hat` (#29, STRING), `fashion_arm` (#30, STRING), `fashion_cloth` (#31, STRING), `hide` (#32, BOOL), `appellid` (#33, INT32), `fate_skills` (#34, STRING), `pet_tempId` (#35, INT32), `pet_quqlity` (#36, INT32), `pet_name` (#37, STRING), `child_job` (#38, INT32), `child_name` (#39, STRING), `child_sex` (#40, INT32), `growth_grade` (#41, INT32), `monster_id` (#42, INT32), `avenger_grade` (#43, INT32), `growth_grade2` (#44, INT32).
- Receiver: `AM.__getArmyListHandler` → `__recieveArmyHandler` (AM:211-255): `SGR.readArmyInfo` (id, player, name, type, map, position, state, mount; SGR:44-62); for each `armyPawn`, `SGR.readArmyPawnInfo` into `army.getPawnByIndex(sites)`; if `simple_hero_info` present: guild id/name, `fightingCapacity` (also copied to `playerInfo.fightingCapacity`), then `TIH.readHeroInfo(hero, simple_hero_info, ArmyMsg)` which also reads avatar fields `cloth`, `arm`, `wing`, `hide`, `fashion_cloth`, `fashion_arm`, `hat`, `appellid`, `change_sharp`, `avenger_grade` (TIH:161-200). Then `initEvent()` registers every other army listener and dispatches `RECIEVED_ARMY`.
- When: once at login, before any other army, skill or fashion push. Required.

### S2. 92 (0x005c) `U_C_ARMY_RECRUITED` and S3. 100 (0x0064) `U_C_ARMY_UPDATE_ARMYPAWN`
- Message `ArmyPawnUpdatedMsg` (army): `armyPawn` (#1, `ArmyPawnInfoMsg`, repeated), one entry per changed reserve soldier type.
- Receiver: `AM.__recievePawnListHandler` for both (AM:257-294): finds the barracks entry by `son_type` (else the castle reserve entry by `tempate_id`/`son_type`), sets `templateId`, then `SGR.readPawnInfo` (SGR:64-88). Dispatches `ARMY_PAWN_CHANGE` when any `own_pawns <= 0`.
- When: 92 after recruitment (5155); 100 after dismiss (5157), after soldiers die in battle, after level-up of reserve soldiers and whenever reserve counts change *(assumption: 100 is the generic reserve update)*.

### S4. 93 (0x005d) `U_C_ARMY_EDIT`
- Message `ArmyEditRspMsg` (army): `armyPawn` (#1, `ArmyPawnInfoMsg`, repeated), the hero troop sites.
- Receiver: `AM.__armypawnUpdateHander` (AM:296-318): empty list → site 0 emptied; else `SGR.readArmyPawnInfo` for each entry; `army.commit()`.
- When: after 5156 (troop edit), after battles that kill soldiers of the troop, after 8276 (fight position) *(assumption)*.

### `ArmyPawnInfoMsg` (army), used by S1..S4 and 116
| Field | Tag/type | Meaning |
|---|---|---|
| `id` | #1, INT32 | row id |
| `army_id` | #2, INT32 | army id (troop entries) |
| `sites` | #3, INT32 | troop slot; 0 = hero troop |
| `son_type` | #4, INT32 | soldier family (101..111) |
| `tempate_id` | #5, INT32 | `PawnTempInfos.TemplateId` (current level) |
| `own_pawns` | #6, INT32 | soldier count |
| `pawnLive` | #7, `PropertyMsg`, repeated | exactly 6 entries, index 0 attack, 1 defence, 2 magic attack, 3 magic defence, 4 HP, 5 critical (AP:19-29); the client indexes `[0..5]` without bounds checks (SGR:69-81), so 6 entries are mandatory |
| `fight_pos` | #8, INT32 | troop position (1 front, 3 back), read only for troop entries |
| `special_tempIds` | #9, STRING | active characteristic (`SpecialTempInfos.TemplateId`) |
| `comprehedn_tempIds` | #10, STRING | pending comprehended characteristic |
| `bless_num` | #11, INT32 | characteristic bless progress (reserve entries and 116 only) |

`PropertyMsg` (army): `temp_data` (#1), `effect_Per` (#2), `effect_Data` (#3), `bag_Per` (#4), `bag_Data` (#5), `star_Per` (#6), `star_Data` (#7), `powcard_Per` (#8), `powcard_Data` (#9), `skill_Per` (#10), `skill_Data` (#11), `base_Join` (#12), all INT32. The client reads `bag/star/skill/effect` Data and Per only.

## 5. Rules and formulas

- Soldier stat (PP:27-34): `total = (base + bagData + starData + effectData) * (100 + effectPer) / 100 * (100 + bagPer + skillPer + starPer) / 100 + skillData`, where `base` is the template field (`Attack`, `Defence`, `MagicAttack`, `MagicDefence`, `Live`, `ForceHit`) and the total is 0 when `base` is 0 (AP:72-100).
- Troop size cap: `hero.totalConatArmy / template.NeedPopulation` soldiers (AMOD:149-165).
- Auto allocate (AMOD:114-147), used when the barracks frame closes (`decompiled/m4/scripts/buildings/casern/view/CasernFrame.as:81`): if site 0 has soldiers below the cap, top up from the reserve of the same template; if empty, take the reserve type with the highest `(attack + defence + magicAttack + magicDefence + live) * 50000 + NeedBuilding`. Then 5156 is sent ([recruitment.md](recruitment.md)).
- `checkCanUpgraeSeriaPawn`: the troop soldier level must stay below `hero level - 3` to show upgrade hints (AM:783-811).
- Soldier template ids: `<SonType><level 2 digits>` (e.g. 10101..10180); max level 80 (`ThaneInfoHelper.getPawnMaxTempIDBySontype` = `SonType + "80"`, TIH:558-561).

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `PawnTempInfos.xml` | soldier level (6464 rows; MasterType 1..11 = families 101..111, 80 levels each; 12 = special variants; 101 = NPC soldiers) | `TemplateId`, `MasterType`, `SonType`, `Camp`, `Level`, `NextLevelTemplateId`, `PawnName`, `Description`, `GoldConsume`, `CrystalsConsume`, `NeedBuilding` (barracks building template id), `NeedTime`, `NeedPopulation`, `Live`, `Attack`, `Defence`, `MagicAttack`, `MagicDefence`, `ForceHit`, `Parry`, `Swf`, `AttackType`, `DefaultSkill`, `HighSkill`, `HeroSkill`, `Icon`, `AI`, resistances (`FireResi`..`LightResi`, `ReduceResi`, `ReduceResiAgainst`, `ResiPenetrate`, `Penetrate`, `StunAttr`) |

## 7. Persistent state

```sql
CREATE SCHEMA IF NOT EXISTS army;

CREATE TABLE army.castle_reserve (
    player_id      BIGINT  NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
    son_type       INTEGER NOT NULL,
    template_id    INTEGER NOT NULL,
    soldier_count  INTEGER NOT NULL DEFAULT 0 CHECK (soldier_count >= 0),
    special_template_id     INTEGER,
    pending_special_template_id INTEGER,
    bless_value    INTEGER NOT NULL DEFAULT 0,
    PRIMARY KEY (player_id, son_type)
);

CREATE TABLE army.troops (
    player_id      BIGINT   NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
    site           SMALLINT NOT NULL DEFAULT 0 CHECK (site >= 0),
    son_type       INTEGER,
    template_id    INTEGER,
    soldier_count  INTEGER  NOT NULL DEFAULT 0 CHECK (soldier_count >= 0),
    fight_pos      SMALLINT NOT NULL DEFAULT 3 CHECK (fight_pos IN (1, 3)),
    PRIMARY KEY (player_id, site)
);
```

The soldier level is shared per `son_type` between reserve and troop (`synchronizationAllArmyPawns`, AM:826-835), so `template_id` in `army.troops` must equal the reserve row of the same `son_type`. Characteristics live on the reserve row (one per soldier family).

## 8. Backend implementation notes

- `army::troops::send_serial_army` (login, no request): build `ArmyMsg` with the hero troop (site 0), reserve is not part of 150 *(assumption: reserve rows arrive with 100 right after 150)*, `simple_hero_info` (full, see [../hero/attributes.md](../hero/attributes.md)), avatar fields. Send before 113/64/other pushes.
- `army::troops::push_reserve_update(player, son_types)`: 100 `ArmyPawnUpdatedMsg` with 6 `PropertyMsg` per entry.
- `army::troops::push_troop_update(player)`: 93 `ArmyEditRspMsg`.
- Stat bonuses in `PropertyMsg` come from equipment, stars, skills and effects computed by the hero stat service; compute server-side.
- Battle: the hero troop (template, count, fight_pos) is the soldier unit of the player's side (`docs/battle/server-engine.md` §9.3, `docs/battle/formation.md` §4.1). Losses update `soldier_count` and the reserve (souls `strategy` gain, see [pawn-upgrade.md](pawn-upgrade.md)).

## 9. Open questions and assumptions

- Assumption: 100 is the generic reserve update and is sent at login after 150.
- Assumption: 93 is sent after 8276 to update `fight_pos` of site 0.
- Open: meaning of `ArmyMsg.type` and `state` for the own army (used for outer city states 2/4/5, see [../world-map/README.md](../world-map/README.md)).

## 10. Implementation checklist

- [ ] Screen: AllocateView renders reserve and troop
- [ ] Server message 150 at login with full hero
- [ ] Server message 92 after recruitment
- [ ] Server message 100 reserve updates
- [ ] Server message 93 troop updates
- [ ] `ArmyPawnInfoMsg` always carries 6 `PropertyMsg`
- [ ] Table `army.castle_reserve`
- [ ] Table `army.troops`
- [ ] Rule: stat formula, troop cap by command
- [ ] Rule: shared level per `son_type`
- [ ] Test: login sequence 150 → 100 → 113 renders the troop panel
