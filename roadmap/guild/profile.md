# Guild profile, notice and level

Area: guild core, module `profile`. Covers the guild information record (`ConsortiaInfoMsg`) and the info tab, the notice (placard), the description, the guild level upgrade with its cooldown and speed up, weekly maintenance, guild ranking data, and `ConsortiaLevelInfos.xml`. Owns the `guild.guild` table used by every other module.

Conventions: see [membership.md](membership.md). No HTTP servlet is involved.

## Overview

`ConsortiaFrame` (title "{nome}Guilda", `decompiled/m6/scripts/consortia/view/myConsortia/ConsortiaFrame.as:278`) requests 8212 on creation (`:76`) and opens on the info tab `ConsortiaInfoView`. The info tab shows level (digits), name, "Presidente:{0}", "Ranking da guilda:{0}", "N° de membros da guilda:{0}", "Fortuna da guilda:{0}", "Pontos de combate:{0}", "Produção da guilda:{0}", "Gasto para manutenção:{0}" (`levels*500` per week, "Sem"), "Contribuição individual:{0}", "Mérito individual:{0}", the notice editor (members with right 3), the donate button ([contribution.md](contribution.md)) and the impeach button ([election.md](election.md)).

There is no guild experience: the guild level (1 to 10) is bought by the chairman (right 3, develop tab visible only to duty 1) by spending guild fortune (`offer`) equal to the next level `NeedOffer` from `ConsortiaLevelInfos.xml`, which starts a shared construction cooldown (`CodeTime` seconds) that can be skipped with diamonds. Level raises the member cap (`levels*20+10`) and the weekly maintenance (`levels*500` fortune). Buildings (types 2 to 5, 26) use the same develop tab and cooldown and belong to the economy area.

## Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `ConsortiaFrame` (`decompiled/m6/scripts/consortia/view/myConsortia/ConsortiaFrame.as:91`) | "{consortiaName}Guilda" | Tabs info, develop (chairman only, `:116`), members, buildings, activities | `consortia` controller openType 1 when in a guild (`decompiled/core_module/scripts/mvc/controler/ConsortiaControler.as:273`); tab index from openType data | name, badge counts |
| `ConsortiaInfoView` (`decompiled/m6/scripts/consortia/view/myConsortia/newui/ConsortiaInfoView.as:81`) | strings `ConsortiaInfoView.*.text`; notice hint "Clique para modificar anúncio da Guilda" or "Clique para modificar descrição da Guilda" when empty | Guild summary and notice editor | Info tab | `refreshView` `:219`: `levels`, `consortiaName`, `chairmanName`, `orderInfo.gradeOrder`, `currentCount`, `offer`, `emeDreamInfo.spirit`, `consortiaAsset`, `levels*500`, own `consortiaOffer`, `reputation` (from 180), `placard` |
| `ConsortiaDevelopView` (`decompiled/m6/scripts/consortia/view/myConsortia/newui/ConsortiaDevelopView.as:105`) | "Elevar"; speed tip "Acelerar resfriamento" | Upgrade guild (type 1) and buildings (2, 3, 4, 5, 26); cooldown timer; speed up | Develop tab | current and next template description, `NeedOffer`, `offer`, `consortiaAsset`, cooldown |
| `ConsortiaFrameRightContent` (`decompiled/m6/scripts/consortia/view/myConsortia/ConsortiaFrameRightContent.as:68`) | "Confirmar" | Legacy description and placard editor (rights 30 and 4); not instantiated anywhere: unreachable | none | description, placard |

## Actions

| # | UI control | Client sender | Client checks | Route | Request message and fields | Resp |
|---|---|---|---|---|---|---|
| P1 | Open guild frame / login setup | `ConsortiaFrame` constructor `ConsortiaFrame.as:76` -> `ConsortiaControler.getConsortiaInfos` `ConsortiaControler.as:546`; `ConsortiaManager.getConsirtiaInfo` `decompiled/core_module/scripts/yishi/manager/ConsortiaManager.as:780` -> `ConsortiaSocketOutManager.getConsortiaInfos` `decompiled/core_module/scripts/managers/ConsortiaSocketOutManager.as:222` | in a guild | C>S 8212 0x2014 `U_C_CONSORTIA_INFO` | `ConsortiaMsg`: `consortia_id (#1, INT32)` own guild id | 4138 |
| P2 | Notice publish button | `ConsortiaInfoView.__publishBtnClickHandler` `ConsortiaInfoView.as:188` -> `ConsortiaControler.modifyConsortiaPlacard` `ConsortiaControler.as:648` -> `ConsortiaSocketOutManager.modifyConsortiaPlacard` `ConsortiaSocketOutManager.as:79` | notice editable only with right 3 (`ConsortiaInfoView.as:253`); max 200 chars and text height <= 85 px (`:122`, `:209`); forbidden words in `name` or `chat` lists ("Caractéres inválidos, insira novamente", `ConsortiaControler.as:656`) | C>S 5139 0x1413 `U_C_CONSORTIA_MODIFYBBS` | `ConsortiaMsg`: `placard (#11, STRING)` | 164 to all online members (38 `U_C_CONSORTIA_MODIFYBBS` has no listener) |
| P3 | Description edit (legacy) | `ConsortiaFrameRightContent` `:301` -> `ConsortiaControler.modifyConsortiaDiscription` `ConsortiaControler.as:640` -> `ConsortiaSocketOutManager.modifyConsortiaDiscription` `ConsortiaSocketOutManager.as:71` | right 30; forbidden words | C>S 5140 0x1414 `U_C_CONSORTIA_MODIFYDESC` | `ConsortiaMsg`: `description (#12, STRING)` | 164. Unreachable in this client build; implement for completeness (description is shown in search and info preview) |
| P4 | Upgrade guild ("Elevar", type 1 selected) | `ConsortiaDevelopView._upgradeBtnClickHandler` `ConsortiaDevelopView.as:281` -> `ConsortiaControler.consortiaUpgrade` `ConsortiaControler.as:744` -> `ConsortiaSocketOutManager.consortiaUpgrade` `ConsortiaSocketOutManager.as:95` | button visible with right 3 (`:216`); enabled when level < 10, no cooldown and prerequisite reached (`:218`, `checkPrevReached` `:250`); `offer >= NeedOffer` else popup "Fortuna da Guilda insuficiente, acrescentar fortuna?" which opens the donate frame (`:303`). Type 26 uses `consortiaAsset` instead ("Produção da guilda insuficiente") | C>S 5133 0x140d `U_C_CONSORTIA_LEVEL` | `ConsortiaMsg`: `upgrade_type (#5, INT32)` = 1 guild (2 shop, 3 altar, 4 school, 5 store, 26 master school belong to economy) | 164 to all online members with new `levels`, `offer`, `code_begin_date`, `code_need_date`, `current_date`; 43 has no listener |
| P5 | Speed up cooldown | `ConsortiaDevelopView._speedBtnClickHandler` `ConsortiaDevelopView.as:228`, `SpeedAlertBack` `:241` -> `ConsortiaControler.sendQuickTime` `ConsortiaControler.as:769` -> `ConsortiaSocketOutManager.sendQuickTime` `ConsortiaSocketOutManager.as:111` | right 3 (`:344`); confirm "Para acelerar o resfriamento é necessário consumir {0} diamantes, deseja acelerar?" with cost `ceil(timeLeft / (60 * 10)) * 1` from `Consortia_Fast` "1,10" and a bound diamond checkbox | C>S 8545 0x2161 `C_CONSORTIA_QUICK` | `PayTypeMsg` (player): `pay_type (#1, INT32)` 0 = bound diamonds first allowed, 1 = real diamonds only | 164 with cooldown cleared (`code_need_date = 0`); diamond change via 3 |

## Server messages

| Route | Message and fields read | When | Client handler and effect |
|---|---|---|---|
| S>C 4138 0x102a `U_C_CONSORTIA_INFO` and S>C 164 0x00a4 `U_CH_CONSORTIA_FRESHINFO` | `ConsortiaInfoMsg` (fields below) | 4138: response to 8212. 164: push to all online members after any guild level data change | Both run `ConsortiaManager.__refreshConsortiaInfo` `ConsortiaManager.as:457`: copies fields, dispatches `CONSORTIA_UPGRADE` when `levels` changed (`:498`), refreshes members when `current_count` changed (`:504`), handles chairman change (`:483`), adds a fake robot chairman when `is_robot` (`:566`), stores ranking when `orderInfo` present (`:570`), dispatches `UPDA_CONSORTIA_INFO` |

`ConsortiaInfoMsg` fields (all from `protocol/proto.json`; "read" = copied by `__refreshConsortiaInfo` or the search reader):

| Field | Meaning | Owner |
|---|---|---|
| `consortia_id (#1, INT32)` | guild id | profile |
| `creator_id (#2, INT32)`, `creator_name (#30, STRING)` | founder | profile |
| `chairman_id (#3, INT32)`, `chairman_name (#31, STRING)` | current chairman | ranks |
| `levels (#4, INT32)` | guild level 1..10 | profile |
| `add_count (#5, INT32)` | read, unused in UI (Assumption: extra member slots) | profile |
| `current_count (#6, INT32)` | member count | membership |
| `kick_count (#7, INT32)`, `kick_date (#37, STRING)` | kick counters | membership |
| `shop_level (#8)`, `store_level (#9)`, `altar_level (#10)`, `school_level (#11)`, `attack_level (#12)`, `defence_level (#13)`, `agility_level (#14)`, `ability_level (#15)`, `captain_level (#16)`, `gold_level (#17)`, `physique_level (#45)`, `new_power_lv (#57)`, `new_agility_lv (#58)`, `new_intellect_lv (#59)`, `new_physique_lv (#60)`, `fam_gp_lv (#61)`, `medal_lv (#62)`, `honor_lv (#63)`, `score_lv (#64)`, `master_power_lv (#72)`, `master_agility_lv (#73)`, `master_intellect_lv (#74)`, `master_physique_lv (#75)`, `master_skill_research_cd_end (#76, INT64 ms)`, `master_school_lv (#78)`, `quest_lobby_lv (#79)`, `new_shop_lv (#80)` | building and research levels (all INT32 unless noted) | economy |
| `fight_power (#18, INT64)` | guild power | profile |
| `own_wildlands (#19, INT32)` | owned wild lands | world, read only |
| `offer (#20, INT32)` | guild fortune "Fortuna" | contribution / profile |
| `honor (#21, INT32)` | prestige "Prestígio" | profile |
| `bless_temp_id (#22)`, `bless_count (#23)`, `site (#47, repeated)`, `altar_date (#54)`, `altar_state (#55)` | altar | economy, not read here |
| `code_type (#24, INT32)` | which upgrade type is cooling down (Assumption) | profile |
| `total_offer (#25)`, `op (#26)`, `renames (#32)`, `quit_result (#33)`, `is_exist (#35)`, `quit_date (#40)`, `activeData (#52)` | not read by `__refreshConsortiaInfo` | n/a |
| `placard (#27, STRING)` | notice | profile |
| `description (#28, STRING)` | description | profile |
| `consortia_name (#29, STRING)` | name | profile |
| `open_app (#34, BOOL)` | accepting applications | membership |
| `create_date (#36, STRING)` | creation date "YYYY-MM-DD hh:mm:ss" | profile |
| `deduct_date (#38, STRING)` | next maintenance deduction | profile |
| `warn_date (#39, STRING)` | date of the last failed maintenance; empty when fine | profile |
| `code_begin_date (#41, STRING)`, `code_need_date (#43, INT32 seconds)`, `current_date (#42, STRING server now)` | cooldown: remaining = `code_need_date - (current_date - code_begin_date)` (`ConsortiaDevelopView.as:317`) | profile |
| `orderInfo (#44, ConsortiaOrderInfoMsg)` | ranking: `consortia_id (#1)`, `grade_order (#2)` shown as rank, `fight_power_order (#3)`, `last_day_offer (#4)`, `last_day_order (#5)`, `last_week_offer (#6)`, `last_week_order (#7)`, `offer (#8)` unused, `last_day_date (#9)`, `last_week_date (#10)` | profile |
| `is_robot (#46, BOOL)` | robot guild | membership |
| `speak_times (#48, INT32)` | recruitment broadcasts left today | election |
| `votingDate (#49)`, `votingStatic (#50)`, `votingId (#51)` | election | election |
| `group_placard (#53, STRING)` | group chat notice | logs |
| `max_mave (#56, INT32)` | read into `model.maxMave`, meaning unknown | unknown |
| `boss_info (#65, ConsortiaBossMsg)`, `storage_expire_time1 (#66)`, `storage_expire_time2 (#67)`, `is_storage_expire1 (#68)`, `is_storage_expire2 (#69)` | guild boss and storage | PvE / economy |
| `consortia_active_point (#70)`, `consortia_weekly_active_point (#77)` | activity points | economy |
| `consortia_asset (#71, INT32)` | "Produção da guilda", currency for type 26 upgrades | economy / profile |

## Rules and formulas

- Guild level range 1..10 (`ConsortiaUpgradeType.MAX_LEVEL = 10`, `decompiled/core_module/scripts/mvc/module/consortia/ConsortiaUpgradeType.as:54`; `ConsortiaDevelopView.as:218`). New guilds start at level 1 (template 101 `NeedOffer = 0`).
- Upgrade cost: next level `NeedOffer` from `ConsortiaLevelInfos.xml` Types=1, paid from guild `offer`. Levels 2..10 cost 400, 6000, 12000, 20000, 30000, 42000, 56000, 72000, 90000 fortune with cooldowns 1800, 3600, 7200, 14400, 28800, 43200, 86400, 129600, 172800 seconds.
- Prerequisite: `PreTemplateId` of the next template must be reached (0 for the guild itself, `ConsortiaDevelopView.as:250`).
- Cooldown: one per guild, shared by every develop tab type (`model.timeLeft`, `ConsortiaDevelopView.as:317`). Upgrade blocked while `timeLeft > 0`.
- Speed up: cost `ceil(remaining_seconds / 600) * 1` diamonds (`Consortia_Fast = "1,10"`: 1 diamond per 10 minutes, `ConsortiaDevelopView.as:231`). Event type 10 "SPEED" ([logs.md](logs.md)).
- Member cap: `levels * 20 + 10` (`decompiled/m6/scripts/consortia/view/club/ConsortiaItem.as:174`, template text, `Consortia_Member = 20`).
- Maintenance: `levels * 500` fortune per week (`ConsortiaInfoView.as:231`; template `Property2` = 500 per level). Deducted at `deduct_date` (tip "Será deduzido da fortuna da Guilda, próximo dedução:"). If fortune is insufficient the server sets `warn_date`; the client warns on frame open when `now - warn_date >= 8 days` with "Taxa de manutenção da Guilda insuficiente, mais uma vez e a Guilda será dissolvida, contribua em tempo" (`ConsortiaControler.as:132`, `:174`). A second failure disbands the guild (text; Assumption on exact timing). Event type 8 "DEDUCT".
- Notice: max 200 chars, forbidden words, right 3. Description: right 30, forbidden words, no length limit visible (Assumption: 200).
- Ranking: `grade_order` displayed; when `orderInfo` is absent the client shows the string `yishi.view.PlayerMenu.consortiaName`. Daily and weekly offer ranks are computed by the server (Assumption: by level then power, and by fortune gained).

## Templates

`raw/xml/tempinfos/ConsortiaLevelInfos.xml`, element `ConsortiaLevelInfo`, loaded by `ConsortiaTempInfoResolve` (`decompiled/core_module/scripts/yishi/resolve/ConsortiaTempInfoResolve.as:17`) into `TempleteManager` keyed by `TemplateId` and `"Types_Levels"` (`decompiled/core_module/scripts/yishi/manager/TempleteManager.as:2467`, `:2472`). Class `ConsortiaTemplete` (`decompiled/core_module/scripts/mvc/module/consortia/ConsortiaTemplete.as`). 247 records; Types: 1 guild, 2 shop, 3 altar, 4 school, 5 store, 6 to 25 skills (`ConsortiaUpgradeType.as:6` to `:52`), 26 master school, 27 quest school, 28 commerce chamber.

| Field | Meaning (Types=1) |
|---|---|
| `TemplateId` | 101..110 |
| `Types` | 1 guild |
| `Levels` | level reached |
| `LevelName` | "Guilda" |
| `PreTemplateId` | prerequisite template (0) |
| `NextTemplateId` | skills unlocked (used for type 4 only) |
| `NeedOffer` | fortune cost to reach this level |
| `CodeTime` | cooldown seconds started by the upgrade |
| `Property1`, `Property3` | 0 |
| `Property2` | 500 x level: weekly maintenance |
| `Description` | pt-BR text with the member cap |
| `BuildingType` | 1 |

`raw/xml/tempinfos/ConfigInfos.xml`: `Consortia_Fast = 1,10`, `Consortia_Member = 20`.

## Persistent state

```sql
CREATE SCHEMA IF NOT EXISTS guild;

CREATE TABLE guild.guild (
    id                       serial      PRIMARY KEY,
    name                     text        NOT NULL,
    name_needs_change        boolean     NOT NULL DEFAULT false,
    creator_id               integer     REFERENCES public.player(id) ON DELETE SET NULL,
    creator_name             text        NOT NULL,
    chairman_id              integer     REFERENCES public.player(id) ON DELETE SET NULL,
    level                    smallint    NOT NULL DEFAULT 1 CHECK (level BETWEEN 1 AND 10),
    fortune                  integer     NOT NULL DEFAULT 0 CHECK (fortune >= 0),   -- offer
    asset                    integer     NOT NULL DEFAULT 0 CHECK (asset >= 0),     -- consortia_asset
    honor                    integer     NOT NULL DEFAULT 0,
    fight_power              bigint      NOT NULL DEFAULT 0,
    notice                   text        NOT NULL DEFAULT '' CHECK (char_length(notice) <= 200),
    description              text        NOT NULL DEFAULT '',
    group_notice             text        NOT NULL DEFAULT '',
    accepts_applications     boolean     NOT NULL DEFAULT true,                       -- open_app
    is_robot                 boolean     NOT NULL DEFAULT false,
    cooldown_type            smallint    NOT NULL DEFAULT 0,                          -- code_type
    cooldown_started_at      timestamptz,                                             -- code_begin_date
    cooldown_seconds         integer     NOT NULL DEFAULT 0 CHECK (cooldown_seconds >= 0), -- code_need_date
    next_maintenance_at      timestamptz NOT NULL,                                    -- deduct_date
    maintenance_warned_at    timestamptz,                                             -- warn_date
    kick_count               smallint    NOT NULL DEFAULT 0,
    kick_count_date          date,
    recruit_broadcasts_left  smallint    NOT NULL DEFAULT 0,                          -- speak_times
    recruit_broadcasts_reset_on date,
    created_at               timestamptz NOT NULL DEFAULT now()
);
CREATE UNIQUE INDEX guild_name_unique ON guild.guild (lower(name));
CREATE INDEX guild_level_idx ON guild.guild (level DESC, fight_power DESC);

CREATE TABLE guild.ranking (
    guild_id            integer PRIMARY KEY REFERENCES guild.guild(id) ON DELETE CASCADE,
    grade_order         integer NOT NULL,
    fight_power_order   integer NOT NULL,
    last_day_offer      integer NOT NULL DEFAULT 0,
    last_day_order      integer NOT NULL DEFAULT 0,
    last_week_offer     integer NOT NULL DEFAULT 0,
    last_week_order     integer NOT NULL DEFAULT 0,
    last_day_date       timestamptz,
    last_week_date      timestamptz
);
```

Building, skill, storage, boss and activity columns are owned by the economy and PvE modules (separate tables keyed by `guild_id`). `current_count` is `count(*)` from `guild.member`. `ConsortiaLevelInfos.xml` stays a file loaded at startup (no table).

## Backend implementation notes

| Opcode | Handler |
|---|---|
| 8212 | `guild::profile::handle_get_info` |
| 5139 | `guild::profile::handle_set_notice` |
| 5140 | `guild::profile::handle_set_description` |
| 5133 (upgrade_type 1) | `guild::profile::handle_upgrade_level` (other types forwarded to `guild::buildings`) |
| 8545 | `guild::profile::handle_speed_up_cooldown` |

Encoder `guild::profile::encode_info(guild, viewer) -> ConsortiaInfoMsg` assembles the full message from `guild.guild`, member count, ranking, election state and economy/PvE tables; `current_date` is server now formatted "YYYY-MM-DD hh:mm:ss".

5133 type 1 validation: member with right 3; level < 10; cooldown elapsed; `fortune >= NeedOffer(level+1)`. One transaction: debit fortune, level + 1, start cooldown (`cooldown_type = 1`, `cooldown_started_at = now`, `cooldown_seconds = CodeTime`), insert event type 4 "CONSORTIA_UPGRADE". Push 164 to all online members.

8545 validation: right 3; cooldown active; diamonds `ceil(remaining/600)` (bound first when `pay_type = 0`). One transaction: debit, clear cooldown, event type 10. Push 164 to all online members and 3 to the payer.

5139/5140: right 3 (or 4) / right 30; filter words; update; push 164 to all online members.

Scheduled job `guild::profile::maintenance_tick` (hourly): for guilds with `next_maintenance_at <= now`, debit `level*500` fortune; on success clear `maintenance_warned_at`, on failure set it (or disband if already set, Assumption), insert event type 8, advance `next_maintenance_at` by 7 days, push 164.

## Open questions

1. Exact disband rule after maintenance warnings (8 day client threshold vs second failure).
2. `add_count`, `max_mave`, `code_type` semantics.
3. Whether guild level also requires anything other than fortune (no XP field exists).
4. Description length limit.

## Implementation checklist

Client flows:

- [ ] Info tab shows every field with real data (rank, members, fortune, power, asset, maintenance, own contribution, merit)
- [ ] Notice publish (right 3) and refresh for other online members
- [ ] Develop tab: guild upgrade with fortune, cooldown countdown, insufficient fortune popup opening donate
- [ ] Speed up cooldown with diamond confirmation
- [ ] Maintenance warning tip on frame open

Backend:

- [ ] Table `guild.guild` (with unique lower(name)) and `guild.ranking`
- [ ] `ConsortiaLevelInfos.xml` loader (Types, Levels, NeedOffer, CodeTime, Property2, PreTemplateId)
- [ ] `ConsortiaInfoMsg` encoder used by 4138 and 164
- [ ] Handlers 8212, 5139, 5140, 5133 (type 1), 8545
- [ ] Maintenance scheduler and ranking recomputation job
- [ ] Events 4, 8, 10
