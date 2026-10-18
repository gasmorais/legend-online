# Ranking generation

Feature `rankings`, module `ranking-generation`. Server side job that computes every ranking, stores snapshots, renders the XML files the client downloads, and updates the per player order fields of `PlayerMsg`.

Conventions as in [ranking-board.md](ranking-board.md). Everything in sections 7 and 8 is a proposal; the client only constrains the file names, the XML schema and the order fields.

## 1. Overview

The client never asks the game server for rankings over the socket. It downloads `{TPL}<file>.xml` and `{TPL}cross/<file>.xml` (zlib compressed) and parses rows with `SortController` (`decompiled/core_module/scripts/mvc/controler/SortController.as`). The server must therefore:

1. Periodically compute each list from live data (hero level/GP, power, total power, guild power, honour, charm, beast points, pet power, child power, Theseus armour, returned players).
2. Store a snapshot (rank, player, value) and the rendered compressed XML per file.
3. Update each ranked player's own positions (`gp_order`, `PlayerOrderMsg`) and push them to online players.
4. For cross server files, merge the snapshots of all servers of the cross group (Assumption: single server deployment can publish the local snapshot also as the cross file, with `serverId` = own server name).

## 2. Screens

None (server job). Consumers: [ranking-board.md](ranking-board.md), [number-one.md](number-one.md), colosseum self view (`fight.xml`).

## 3. Routes (client to server)

| Route | Description |
|---|---|
| HTTP GET `{TPL}<file>` and `{TPL}cross/<file>` | Static file download, loader type 5 (`COMPRESS_TEXT_LOADER`, `decompiled/Loading/scripts/com/pickgliss/loader/data/LoaderInfo.as:21`): the body is zlib compressed and decoded with `ByteArray.uncompress()` then read as UTF-8 (`decompiled/Loading/scripts/com/pickgliss/loader/LoaderManagerII.as:397`). File names: `fight.xml`, `totalfightcapacity.xml`, `constainfight.xml`, `geste.xml`, `soulscore.xml`, `day.xml`, `week.xml`, `total.xml`, `daycharm.xml`, `weekcharm.xml`, `totalcharm.xml`, `petfightcapacityrank.xml`, `childfightcapacityrank.xml`, `returnedplayers.xml`, `theseus.xml` (`SortController.getSortFileName` `SortController.as:779`). |

## 4. Server messages (server to client)

| Route | Fields | When |
|---|---|---|
| S>C 3 0x0003 `U_C_PLAYER_INFO` | `PlayerMsg.gp_order (#29, INT32)`; `PlayerMsg.order (#47, PlayerOrderMsg)`: `player_id (#1, INT32)`, `fight_capacity_order (#2, INT32)`, `geste_Order (#3, INT32)`, `charm_Order (#4, INT32)`, `soul_score_Order (#5, INT32)`. The client reads the `order` block only when `gp_order` is present (`decompiled/core_module/scripts/yishi/manager/PlayerManager.as:961`). Use 0 for "not ranked". | Login (`decompiled/core_module/scripts/yishi/lunch/LoginInitDataAccept.as:419`) and after each job run to online players (Assumption) |

## 5. Rules and formulas

XML document shape (all lists). The root element name is free; the client reads `root.info@createDate` and all descendant row elements by name:

```xml
<Result>
  <info createDate="2026-10-17 05:00:00"/>
  <PlayerFight orderId="1" userid="1001" nikcName="Nome" serverId="S1" ... >
    <PlayerSNSInfo userId="1001" HeadId="3" Sex="1" .../>
    <Item .../> ...
  </PlayerFight>
</Result>
```

Row element per file (resolvers in `SortController.resolveXML` `SortController.as:919`):

| File | Row element | Sort key (value column) | Resolver |
|---|---|---|---|
| `day.xml` / `week.xml` / `total.xml` | `DayAdd` / `WeekAdd` / `TotalAdd` | GP gained in the day, week, all time (`gp`, shown with `grades`) | `:940`, `:954`, `:968` |
| `fight.xml` | `PlayerFight` | hero power `fightCapaity` | `:982` |
| `totalfightcapacity.xml` | `PlayerTotalFight` | total power `FightCapacity`; `gpOrde` is also copied to the own `multipleApOrder` | `:1029` |
| `constainfight.xml` | `fightItems` | guild power `FightPower` (row also `ConsortiaName`, `Levels`, `Offer`, `ConsortiaId`) | `:1047` |
| `geste.xml` | `PlayerGeste` | honour `CurrentGeste` | `:1061` |
| `daycharm.xml` / `weekcharm.xml` / `totalcharm.xml` | `CharmDayAdd` / `CharmWeekAdd` / `CharmTotalAdd` | charm gained `charm`; total also `totalCharm` | `:1076`, `:1090`, `:1104` |
| `soulscore.xml` | `SoulScoreTotalAdd` | beast points `CurrentSoulScore` | `:1119` |
| `theseus.xml` | `Theseus` | armour value `TheseusInfo@Armour` | `:996` |
| `petfightcapacityrank.xml` | `PetCapabilityRankInfo` | pet `FightCapacity` | `:1249` |
| `childfightcapacityrank.xml` | `ChildCapabilityRankInfo` | child `FightCapacity` | `:1292` |
| `returnedplayers.xml` | `ReturnedPalyer` | rank by `orderId`; value `ReturnedTime` (display string) | `:1335` |

Player row attributes (`SortController.read` `SortController.as:72`, attribute names are case sensitive and some are misspelled in the client; keep them):

| Attribute | Meaning |
|---|---|
| `orderId` | rank, 1 based |
| `uuid`, `userid`, `serverId` | player uuid, user id, server display name |
| `nikcName` | nickname (misspelled) |
| `grades`, `gp`, `CurrentGp` | hero level, GP for the list, current GP |
| `fightCapaity` (misspelled), `FightCapacity` | hero power, total power |
| `Job`, `baseJob`, `job` | hero template id, base template, fallback |
| `IsVip` (`"true"`), `VipType` | VIP flags |
| `ConsortiaName`, `constainName`, `ConsortiaId`, `Levels`, `Offer`, `FightPower` | guild name (both spellings are read), id, level, wealth, power |
| `CurrentGeste`, `geste` | honour value |
| `charm`, `totalCharm`, `charmOrder` | charm for the period, total charm, charm order |
| `CurrentSoulScore` | beast points |
| `weekScore` | PvP weekly score |
| `gpOrde`, `CurrentOrder` | level order, honour/GP order copied into the snapshot `playerOrdeInfo` |
| `ReturnedTime` | returned player text |
| `MagicCards` | `templateId,grade|templateId,grade...` active magic cards |
| `HideFashion` (`"true"`), `FashionGP`, `FashionGrades`, `FashionHat`, `FashionCloth`, `FashionArm`, `FashionWing` | fashion state and template ids |
| `StoreGrade`, `EquipmentRefiningGrade`, `SeniorStoreGrade`, `fateTotalGp`, `fateGrades`, `appellId`, `NickNameB`, `RingGrade` | jewel grade, refining grade, senior jewel grade, fate, title, mate nickname, marriage ring grade |
| `power`, `agility`, `intellect`, `captain`, `physique`, `totalBattleWill`, `totalFireResi`, `totalWaterResi`, `totalWindResi`, `totalElecResi`, `totalLightResi`, `totalDarkResi`, `totalResiPenetrate`, `totalReduceResiAgainst`, `fashionPower`, `fashionArmor`, `fashionIntellect`, `fashionPhysique` | base properties |
| `totalPhyAttack`, `totalPhyDefence`, `totalMagicAttack`, `totalMagicDefence`, `totalForceHit`, `totalConatArmy`, `live`, `parry`, `Tenacity`, `Strength`, `Penetrate`, `StunAttr` | combat properties |

Optional child elements of a player row (full hero snapshot for the info frame; each block has its own owning feature): `PlayerSNSInfo` (`userId`, `HeadId`, `Sex`, `BirthdayType`, `BirthYear`, `BirthMonth`, `BirthDay`, `StarId`, `BloodType`, `Country`, `Province`, `City`, `Desc`, `SortController.as:240`), `Item` (equipment: `id`, `pos`, `objectId`, `bagType`, `templateId`, `isBinds`, `strengthenGrade`, `join1..4`, `randomSkill1..5`, `mouldGrade`, `appraisalSkill`, `:258`), `StarInfo`, `StarAdditionInfo`, `PowCardFightInfo`, `PetInfo`, `ChildInfo`, `MountInfo`, `WatchInfo`, `DragonInfo`, `DragonTalkerInfo`/`TalismanInfo`, `TattooInfo`, `TattooEnhanceInfo`, `PetHallowsInfo`, `TransferInfo`, `TitanDataInfo`, `ArtifactInfo`, `GoddessInfo`/`GoddessEquip`, `MonsterInfo`, `AvengerInfo`/`AvengerSkillInfo`/`AvengerHoleInfo`, `EquipData`, `TheseusInfo`, `WarSoulInfo` (`SortController.as:203` to `:580`). Minimum viable snapshot: row attributes plus `PlayerSNSInfo` and `Item`; the other blocks may be omitted (the info frame then shows empty panels).

Pet row (`PetCapabilityRankInfo`): `Rank`, `NickName` (owner), `serverId`, `UserId`, `IsVip`, `VipType`, `HeadId`, plus pet attributes read by `PetData.createWithXML` (`decompiled/core_module/scripts/mvc/module/pet/PetData.as:689`): `PetId`, `TemplateId`, `PetName`, `Quality`, `InitQuality`, `CurGrade`, `CurGp`, `TotalGp`, `CurQualityGp`, `FightCapacity`, `Power`, `PowerApt`, `Armor`, `ArmorApt`, `Intel`, `IntelApt`, `Physi`, `PhysiApt`, `FireResi`, `WaterResi`, `WindResi`, `ElectResi`, `LightResi`, `DarkResi`, `ChangeSkills`, `FollowSkills`, `RandomSkill`, `Join`, `MouldGrade`, `Pos`, `IsBinding`, `IsBinds`.

Child row (`ChildCapabilityRankInfo`): `Rank`, `NickName`, `serverId`, `UserId`, `IsVip`, `VipType`, `HeadId`, plus `ChildData.createChildWithXML` attributes (`decompiled/core_module/scripts/mvc/module/children/ChildData.as:95`): `ChildId`, `TemplateId`, `ChildName`, `job`, `sex`, `state`, `GrowthGrade`, `GrowthGp`, `GrowthCount`, `FightCapacity`, `StrengthenGrade`, `RandomSkill`, `Join`, `MouldGrade`, `Pos`, `IsBinds`.

Computation rules (Assumptions, the client does not show them):

- Ties broken by earlier reach time then lower `player_id`.
- Level list "day" and "week": GP gained since 00:00 of the current day and since the start of the week (Monday 00:00 server time); "total": level then total GP.
- Charm "day", "week", "total": charm received from rose gifts (see [../friends/instant-messages.md](../friends/instant-messages.md), rose items 2170001 and 2170005) in the period; total charm is the hero `charm` (`PlayerMsg.charm #69`).
- Honour list by `geste` (`PlayerMsg.geste #60`).
- Guild list by guild power; also feeds `ConsortiaInfoMsg.orderInfo.fightPowerOrder` (guild feature).
- Exclude robots, GMs and banned accounts.
- Orders >= 15000 are displayed as "Iniciante" by the client, so storing up to 15000 positions per list is enough for own order fields.

## 6. Templates

| File | Use |
|---|---|
| `raw/xml/tempinfos/UpGradeTempInfos.xml` `Types="14"` | Honour titles, client side only |

## 7. Persistent state

```sql
CREATE SCHEMA IF NOT EXISTS rankings;

CREATE TABLE rankings.snapshot (
    snapshot_id   bigserial   PRIMARY KEY,
    file_key      text        NOT NULL,              -- 'fight', 'total', 'daycharm', ... (file name without .xml)
    area          text        NOT NULL CHECK (area IN ('local', 'cross')),
    created_at    timestamptz NOT NULL DEFAULT now(), -- info@createDate
    row_count     integer     NOT NULL CHECK (row_count >= 0),
    xml_zlib      bytea       NOT NULL,              -- body served to the client
    is_current    boolean     NOT NULL DEFAULT true
);
CREATE UNIQUE INDEX snapshot_current_idx ON rankings.snapshot (file_key, area) WHERE is_current;

CREATE TABLE rankings.entry (
    snapshot_id   bigint      NOT NULL REFERENCES rankings.snapshot(snapshot_id) ON DELETE CASCADE,
    rank          integer     NOT NULL CHECK (rank >= 1),
    player_id     integer     REFERENCES player.players(player_id) ON DELETE SET NULL, -- null for guild or foreign rows
    guild_id      integer,                           -- constainfight rows
    server_name   text        NOT NULL,
    subject_id    integer,                           -- pet_id or child_id for pet/child lists
    value         bigint      NOT NULL,
    PRIMARY KEY (snapshot_id, rank)
);
CREATE INDEX entry_player_idx ON rankings.entry (player_id, snapshot_id);

CREATE TABLE rankings.player_order (
    player_id             integer     PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
    gp_order              integer     NOT NULL DEFAULT 0,  -- PlayerMsg.gp_order
    fight_capacity_order  integer     NOT NULL DEFAULT 0,  -- PlayerOrderMsg.fight_capacity_order
    geste_order           integer     NOT NULL DEFAULT 0,
    charm_order           integer     NOT NULL DEFAULT 0,
    soul_score_order      integer     NOT NULL DEFAULT 0,
    updated_at            timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE rankings.period_counter (
    player_id     integer     NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
    metric        text        NOT NULL CHECK (metric IN ('gp', 'charm')),
    period        text        NOT NULL CHECK (period IN ('day', 'week')),
    period_start  date        NOT NULL,
    amount        bigint      NOT NULL DEFAULT 0 CHECK (amount >= 0),
    PRIMARY KEY (player_id, metric, period, period_start)
);
```

`rankings.period_counter` is incremented by the hero GP and charm code paths (hero and friends features) inside their own transactions.

## 8. Backend implementation notes

- Job `rankings::generation::run_all` scheduled daily (Assumption: 05:00 server time) plus on server start when no current snapshot exists. For each file key: query, assign ranks, insert `rankings.entry`, render XML with `quick-xml`, compress with zlib (`flate2::write::ZlibEncoder`), insert `rankings.snapshot`, flip `is_current` in one transaction.
- After all lists: upsert `rankings.player_order` from the new entries and push `PlayerMsg` (only `gp_order` and `order`) to online ranked and unranked players whose order changed.
- Cross area: `rankings::generation::merge_cross` reads the current local snapshots of every server in the cross group (shared database or HTTP pull from peers), re-ranks and writes `area = 'cross'`. Single server: copy local rows.
- File handler `rankings::board::handle_get_file` reads `xml_zlib` of the current snapshot; serve an empty document when none.
- Snapshot rendering of the hero block should reuse the encoder of the player info view (hero feature) to avoid divergence.

## 9. Open questions and assumptions

1. Schedule and list length are not visible in the client (Assumption: daily, 100 rows).
2. `returnedplayers.xml` content: which players count as returned and what `ReturnedTime` shows (Assumption: players flagged `is_back_player`, text "YYYY-MM-DD").
3. `weekScore` and `gpOrde` semantics per list are inferred from attribute names.
4. Cross group composition (which servers are merged) is an operations decision.

## 10. Implementation checklist

- [ ] Tables `rankings.snapshot`, `rankings.entry`, `rankings.player_order`, `rankings.period_counter`
- [ ] Job computing all 15 file keys for local area
- [ ] Cross merge (or copy) for all file keys except `returnedplayers`
- [ ] XML renderer with exact attribute names (including `nikcName`, `fightCapaity`, `ReturnedPalyer`)
- [ ] zlib compression and HTTP serving under `/xml/` and `/xml/cross/`
- [ ] `PlayerMsg.gp_order` and `PlayerMsg.order` at login and after each run
- [ ] Period counters for GP and charm with day and week rollover
- [ ] Test: parse generated files with the client (open every tab, cross and local)
- [ ] Test: own position strip matches `rankings.player_order`
