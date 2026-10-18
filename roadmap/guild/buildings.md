# Guild buildings (economy module)

Scope: guild hall level, the five classic buildings (Loja da Guilda, Altar, Instituto de Habilidades / Torre de Habilidades, Depósito) plus the Torre de Habilidade de Mestre, the single construction queue, paid speed up, and the Altar prayer (the only building with its own interactive loop in this module). Skills researched in the Instituto live in `skills.md`, the Depósito item flow in `warehouse.md`, the Loja da Guilda and Câmara de Comércio in `shop.md`, guild wealth accounting in `funds.md`.

Path aliases used for citations (all relative to the repo root):

| Alias | File |
|---|---|
| CSOM | `decompiled/core_module/scripts/managers/ConsortiaSocketOutManager.as` |
| CM | `decompiled/core_module/scripts/yishi/manager/ConsortiaManager.as` |
| CC | `decompiled/core_module/scripts/mvc/controler/ConsortiaControler.as` |
| CMOD | `decompiled/core_module/scripts/mvc/module/consortia/ConsortiaModel.as` |
| CINFO | `decompiled/core_module/scripts/mvc/module/consortia/ConsortiaInfo.as` |
| V | `decompiled/m6/scripts/consortia/view/myConsortia/` |
| QBM | `decompiled/core_module/scripts/yishi/manager/QueueBarManager.as` |
| SECM | `decompiled/core_module/scripts/managers/SecretaryManager.as` |

## Overview

A guild has one level per building type (`ConsortiaUpgradeType`, `decompiled/core_module/scripts/mvc/module/consortia/ConsortiaUpgradeType.as:6-54`). The president (only `dutyId == 1` sees the "Desenvolvimento" tab, `V/ConsortiaFrame.as:117-123`) upgrades buildings in `ConsortiaDevelopView`, paying guild wealth ("Fortuna da guilda", `ConsortiaInfo.offer`) or, for the Torre de Habilidade de Mestre, guild production ("Produção da guilda", `ConsortiaInfo.consortiaAsset`). Upgrades with `CodeTime > 0` occupy one guild wide construction queue that can be shortened with diamonds. Members use the buildings from the "Construções" tab (`V/newui/ConsortiaBuildingView.as`).

Entry points:
- Main toolbar Guild button -> `openControllerByInfo("consortia")` -> `ConsortiaFrame` (openType 1, `CC:223-274`), see `docs/ui/navigation.md:89`.
- `ConsortiaControler.showBuildingView` (`CC:356`) opens tab 3; `showFacilitiesView` tab 4; `showActivityView` tab 5 (`CC:361-369`).
- Altar: `openControllerByInfo("consortia",4)` -> `consortia.ConsortiaNewAltarFrame` (`CC:229-232`), blocked when `altarLevel <= 0` with "Altar da Guilda ainda não aberta" (`CC:207-214`).
- Secretary (Pequena Secretária) also asks altar counters with 8215 (`decompiled/m11/scripts/secretary/LittleSecretaryFrame.as:70`).

## Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `V/ConsortiaFrame.as` | "{nome}Guilda" (`public.consortia` = "Guilda", `:244`,`:278`) | Tabbed guild window: Info(0), Desenvolvimento(1, president only), Membros(2), Construções(3), Atividades(5). `_facilitiesBtn` is created but never added to the HBox (`:115-126`) | Guild button, `CC.showBuildingView` | title from `consortiaName`; red counters from `recruitNum`, `treasureCount`, `taskCanRewardCount` (`:231-240`) |
| `V/newui/ConsortiaInfoView.as` | (tab) | Guild summary | Tab 0 | level, "Fortuna da guilda:{0}" (`offer`), "Produção da guilda:{0}" (`consortiaAsset`), "Gasto para manutenção:{0}" = `levels*500 + "/Sem"`, "Contribuição individual:{0}", "Mérito individual:{0}" (`:219-261`) |
| `V/newui/ConsortiaDevelopView.as` | (tab) | Building upgrade panel, 6 buttons for types `[1,2,3,4,5,26]` (`CINFO:149`, `:146-159`) | Tab 1 | current level, wealth, production, current and next `Description`, next `NeedOffer`, cooldown, prerequisite text (`:201-226`) |
| `V/newui/ConsortiaBuildingView.as` | (tab) | Building map: Altar, Loja, Depósito, Torre de Habilidades, plus master church (Torre de habilidade de mestre), assassin camp (Câmara de comércio), hunter camp (Escola de missões) | Tab 3 | each building button visible only if its level > 0 (`:126-196`) |
| `V/newui/ConsortiaFacilitiesView.as` | (unused tab) | Same three facility buttons, mine and logging camp show "public.unopen" (`:143-174`) | never added to tab bar | master school level |
| `V/building/ConsortiaNewAltarFrame.as` | "Altar Nv. {0}" (`:95`) | Pray to one of three gods for a random item | Building map Altar (`ConsortiaBuildingView.as:280-283`) | personal merit, personal contribution, cost per prayer, remaining prayers "Vezes restantes: {0}/{1}" (`:344-349`) |
| `V/building/ConsortiaAltarFrame.as`, `V/building/ConsortiaAltarView.as`, `V/building/ConsortiaBuildingView.as` | "Altar Nv. {0}" | Legacy altar and building UI, not reachable from the current frames (only referenced as field types) | none | legacy |

## Actions

### A1. Load guild info (economy fields)
- UI: `ConsortiaFrame` constructor `control.getConsortiaInfos()` (`V/ConsortiaFrame.as:76`), also `CM.setup` on login when `consortiaID != 0` (`CM:127-135`).
- Client path: `CC.getConsortiaInfos` (`CC:546`) -> `CSOM.getConsortiaInfos` (`CSOM:222-228`).
- Route: send 8212 (0x2014) `U_C_CONSORTIA_INFO`.
- Message `ConsortiaMsg`: `consortia_id` (#1, INT32) = `playerInfo.consortiaID`. Other fields unset.
- Response: 4138 (0x102a) `U_C_CONSORTIA_INFO` with `ConsortiaInfoMsg` (see the server messages table). Handler `guild::profile::handle_get_info` is owned by `profile.md`; this module supplies the building, wealth and cooldown fields.

### A2. Upgrade a building or the hall
- UI: "Elevar" button `_upgradeBtn` in `ConsortiaDevelopView`, handler `_upgradeBtnClickHandler` (`V/newui/ConsortiaDevelopView.as:281-315`).
- Client checks:
  1. Button visible only with right 3 `UPDATEBUILDING` (`:216`, `CC.getRightsByIndex` `CC:551-554` reads bit `index-1` of the duty rights byte array, LSB first, `decompiled/core_module/scripts/yishi/utils/BitArray.as`).
  2. Button disabled when level >= 10, when the queue is busy (`model.timeLeft > 0`) or prerequisite unmet (`:217-225`).
  3. Prerequisite `checkPrevReached` (`:250-279`): template `PreTemplateId` must belong to one of the six buttons and that building level must be >= prerequisite `Levels`; text "É necessário que {0} atinja o nível {1}".
  4. Cost: type 26 compares `consortiaAsset >= NeedOffer` else "Produção da guilda insuficiente" (`:292-299`); other types compare `offer >= NeedOffer` else confirm "Fortuna da Guilda insuficiente, acrescentar fortuna?" which opens the donation frame (`:301-313`).
- Client path: `CC.consortiaUpgrade(tempType)` (`CC:744-754`) -> `CSOM.consortiaUpgrade` (`CSOM:95-101`).
- Route: send 5133 (0x140d) `U_C_CONSORTIA_LEVEL`.
- Message `ConsortiaMsg`: `upgrade_type` (#5, INT32) = building type (1 hall, 2 shop, 3 altar, 4 skill institute, 5 depot, 26 master tower). The same opcode is used for skill research (types 6..25), see `skills.md`.
- Response: the client registers no handler for 43 `U_C_CONSORTIA_LEVEL` (grep of `"SLGSocketEvent" + 43` returns nothing). The server must push 164 (0x00a4) `U_CH_CONSORTIA_FRESHINFO` (or 4138) to all online members with the raised building level, the new `offer`/`consortia_asset`, `code_type`, `code_begin_date`, `code_need_date`, `current_date` (S1). Assumption: on failure the server sends nothing (no error string is mapped client side); optionally a system tip via the generic message opcode.

### A3. Speed up construction
- UI: `_speedBtn` "Acelerar resfriamento" (`V/newui/ConsortiaDevelopView.as:228-239`), visible only while `timeLeft > 0` and right 3 (`:344`).
- Client cost shown: `ceil(timeLeft / (60 * 10)) * 1` diamonds from config `Consortia_Fast = 1,10` (`:231-232`); confirm "Para acelerar o resfriamento é necessário consumir {0} diamantes, deseja acelerar?" with the bound diamond checkbox (`USEBINDPOINT_ALERT`).
- Client path: `SpeedAlertBack` (`:241-248`) -> `CC.sendQuickTime(useBind)` (`CC:769`) -> `CSOM.sendQuickTime` (`CSOM:111-121`).
- Route: send 8545 (0x2161) `C_CONSORTIA_QUICK`.
- Message `PayTypeMsg`: `pay_type` (#1, INT32) 0 = bound diamonds may be used first, 1 = only real diamonds. Other fields unused.
- Response: push 164/4138 with the cooldown cleared (`code_need_date = 0`) to all online members; push 3 (0x0003) `U_C_PLAYER_INFO` with new `point`/`gift_token` to the payer. Server handler is `guild::profile::handle_speed_up_cooldown` (`profile.md`).

### A4. Open the altar and read today's counter
- UI: Altar button (`V/newui/ConsortiaBuildingView.as:280-283`) -> `CC.showAltarFrame` (`CC:371`) -> `ConsortiaNewAltarFrame.initData` (`V/building/ConsortiaNewAltarFrame.as:182-193`) -> `CC.initAltarFrameInfo` (`CC:859-863`) -> `CSOM.getAltarInfo` (`CSOM:239-243`).
- Route: send 8215 (0x2017) `U_C_CONSORTIA_ALTERINFO`, empty body.
- Response: 4141 (0x102d) `U_C_CONSORTIA_ALTERINFO` (S3). If the player has an uncollected prayer reward the server should also send 4142 (S4) so the client shows it (assumption, inferred from `lastaltarGoods` usage `CC:900-907`).

### A5. Pray (single or "one click")
- UI: `_blessBtn` (`V/building/ConsortiaNewAltarFrame.as:272-281`) and `_oneKeyBlessBtn` "Clique uma vez para completar todas as bênçãos" (`:283-293`).
- God selection: 3 tabs, god N unlocked at altar level `LEVEL_ARR = [1,4,7]` (`:42`, `:156-176`), selection stored in `model.altarWorshipIndex` (1..3, `:371-378`).
- Client checks `ConsortiaAltarHelper.canBless` (`decompiled/m6/scripts/consortia/helper/ConsortiaAltarHelper.as:28-53`):
  1. used prayers `alTarBlessLeftTime >= Property2` -> "Oração insuficiente".
  2. merit cost `Altar_Reputation_Cost[worshipIndex-1]` (config `0,20,30`, `decompiled/core_module/scripts/yishi/datas/ConfigInfoManager.as:999-1006`) > `model.reputation` -> "Mérito Individual insuficiente, você pode homenagear outros deuses ou obter mais na Escola de missões".
  3. contribution cost `Property1` of altar template (20) > `playerInfo.consortiaOffer` -> confirm "Contribuição da Guilda insuficiente, acrescentar contribuição?".
  4. if a previous reward is still displayed it is dismissed first.
- Count: single = 1; one click = `min(Property2 - used, floor(consortiaOffer / Property1))` (`:290`). `QUICK_BLESS_VIP_GRADE = 4` is declared but not checked in this frame (`:40`).
- Client path: `CC.consortiaAltarBless(count)` (`CC:878-882`, sets `isBlessing`) -> `CSOM.consortiaAltarBless` (`CSOM:132-139`).
- Route: send 5145 (0x1419) `U_C_CONSORTIA_FRESHALTAR`.
- Message `com.road.yishi.proto.simple.PropertyMsg` (field numbers from `decompiled/core_module/scripts/com/road/yishi/proto/simple/PropertyMsg.as:300-362`, the name collides in `proto.json`): `param1` (#1, INT32) = prayer count; `param2` (#2, INT32) = god index 1..3.
- Responses in order: 45 (0x002d) `U_C_CONSORTIA_FRESHALTAR` (S2) then 3 `U_C_PLAYER_INFO` with the new `consortia_offer`, then 180 `U_C_CONSORTIA_USER_JOIN_INFO` with the new `reputation` (merit lives there, see `funds.md`).

### A6. Collect the prayer reward
- Trigger: automatic. After 45 the frame plays an effect, then `altarCallback` copies `altarGoods` to `lastaltarGoods` (`V/building/ConsortiaNewAltarFrame.as:220-225`), the setter dispatches `UPDE_ALTAR_GOODS` (`CMOD:830-834`) and `__updateAltarGoods` sends the collect request (`:351-358`).
- Client path: `CC.getConsortiaAddFreshItem` (`CC:909-912`) -> `CSOM.getConsortiaAddFreshItem` (`CSOM:251-255`).
- Route: send 8216 (0x2018) `U_C_CONSORTIA_ADDFRESH`, empty body.
- Response: 4143 (0x102f) `U_C_CONSORTIA_ADDFRESH` (S5) plus 115 (0x0073) `U_C_BAG_MOVE_UPDATE` with the new bag items.

### A7. Open other buildings (navigation only)
- Loja da Guilda: `openControllerByInfo("shop",2)` (`V/newui/ConsortiaBuildingView.as:285-288`), see `shop.md`.
- Depósito: `consortia.ConsortiaCaseFrame` (`:266-271`), see `warehouse.md`.
- Torre de Habilidades research: `consortia.ConsortiaResearchSkillFrame` (`:290-295`), see `skills.md`.
- Master church: `CC.showMasterSkillFrame(4)` (`:248-252`); assassin camp: `CC.showBusinessFrame(5)` (`:254-258`); hunter camp: `CC.showTaskSchoolFrame(6)` (`:260-264`).

## Server messages

| Opcode | Name | Message | Client handler | Fields read and meaning | When to send |
|---|---|---|---|---|---|
| 4138 (0x102a) | `U_C_CONSORTIA_INFO` | `ConsortiaInfoMsg` | `CM.__refreshConsortiaInfo` (`CM:457-577`, listener `CM:158`) | economy fields: `levels` (#4) hall level, `shop_level` (#8), `store_level` (#9), `altar_level` (#10), `school_level` (#11), `offer` (#20) guild wealth, `code_type` (#24) building being built, `code_begin_date` (#41, STRING `YYYY-MM-DD hh:mm:ss`), `current_date` (#42, STRING, server now), `code_need_date` (#43, INT32 seconds of the whole build), `deduct_date` (#38), `warn_date` (#39), `consortia_asset` (#71) production, `master_school_lv` (#78), `quest_lobby_lv` (#79), `new_shop_lv` (#80), `orderInfo` (#44) rankings, `storage_expire_time1/2` (#66/#67), `is_storage_expire1/2` (#68/#69). Skill level fields listed in `skills.md`. Level change dispatches `CONSORTIA_UPGRADE` (`CM:497-502`). | Response to 8212; also after any change if the requester is the only one concerned |
| 164 (0x00a4) | `U_CH_CONSORTIA_FRESHINFO` | `ConsortiaInfoMsg` | same handler (`CM:157`) | same | Push to every online member after an upgrade starts or completes, a speed up, wealth/production change, rental, research |
| 45 (0x002d) | `U_C_CONSORTIA_FRESHALTAR` | `ConsortiaMsg` | `CC.__getAltarBlessInfo` (`CC:884-898`, only while a guild frame is open, `CC:92-110`); `QBM.__consortiaRefreshAltar` (`QBM:194-215`, always) | `bless_left_time` (#15) = prayers already used today; `bless_site` (#8) slot (legacy); `bless_temp_id` (#9) item template won; `bless_count` (#10) item count. Client stores them in `blessInfo` and `altarGoods` and dispatches `UPDA_ALTAR_BLESS_INFO` | Response to 5145. For a multi prayer the client only renders one item (assumption: server returns the last or the aggregated item; all items are granted) |
| 4141 (0x102d) | `U_C_CONSORTIA_ALTERINFO` | `ConsortiaMsg` | `CC.__refreshAltarInfo` (`CC:870-876`), `SECM.__refreshAltarInfo` (`SECM:65-72`) | `bless_left_time` (#15) used prayers today; clamps < 0 to 0 (`CMOD:808-813`) | Response to 8215 |
| 4142 (0x102e) | `U_C_CONSORTIA_ALTERITEM` | `com.road.yishi.proto.item.ItemInfoMsg` | `CC.__refreshAltarGoods` (`CC:900-907`) | item (template_id #2, count #11 ...) parsed by `ItemHelper.readGoodsInfo`; sets `lastaltarGoods` which triggers A6 | Optional push after 8215 when an uncollected reward exists (assumption) |
| 4143 (0x102f) | `U_C_CONSORTIA_ADDFRESH` | `ConsortiaMsg` | `CC.__addFreshItem` (`CC:914-924`) | `result` (#14, BOOL): true clears `altarGoods`/`lastaltarGoods`; dispatches `GET_ALTAR_GOODS` | Response to 8216 |
| 4144 (0x1030) | `U_C_CONSORTIA_SITE` | `ConsortiaInfoMsg` | `CC.__setGoods` (`CC:1091-1097`) | `site` (#47, INT32 repeated) legacy altar slots | Never requested: sender `CSOM.getConsortiaSite` (`CSOM:245`) has no caller. Implement as no-op |
| 3 (0x0003) | `U_C_PLAYER_INFO` | `PlayerMsg` | `PlayerManager.__uPlayerInfoHandler` (`decompiled/core_module/scripts/yishi/manager/PlayerManager.as:496`) | `consortia_offer` (#19) personal contribution (`:859`), `point` (#6), `gift_token` (#7) | After every cost deduction |

## Rules and formulas

- Template key: `Types` + `Levels`, `TemplateId` (`decompiled/core_module/scripts/yishi/resolve/ConsortiaTempInfoResolve.as:16-21`). Max level 10 (`ConsortiaUpgradeType.MAX_LEVEL`, `:54`).
- Building data (`raw/xml/tempinfos/ConsortiaLevelInfos.xml`):

| Type | Name | Lv1..Lv10 `NeedOffer` | `CodeTime` (s) Lv1..Lv10 | Prerequisite (`PreTemplateId`) | Effect fields |
|---|---|---|---|---|---|
| 1 | Guilda | 0, 400, 6000, 12000, 20000, 30000, 42000, 56000, 72000, 90000 | 0, 1800, 3600, 7200, 14400, 28800, 43200, 86400, 129600, 172800 | none | `Property2` = weekly upkeep 500..5000 |
| 2 | Loja da Guilda | 100, 12000, 27000, 48000, 75000, 108000, 147000, 192000, 243000, 300000 | 900, 1800, 3600, 7200, 14400, 21600, 43200, 64800, 86400, 108000 | hall level = target level (201->101 ... 210->110) | unlocks shop rows `NeedConsortiaLevels <= shopLevel+1` (`decompiled/core_module/scripts/mvc/controler/ShopControler.as:470-481`) |
| 3 | Altar | 100, 2400, 5400, 9600, 15000, 21600, 29400, 38400, 48600, 60000 | same as type 2 | Lv1 and Lv2 need hall 2, then hall = level | `Property1` = 20 contribution per prayer, `Property2` = prayers per day 3,6,...,30 |
| 4 | Instituto de Habilidades | 100, 8000, 18000, 32000, 50000, 72000, 98000, 128000, 162000, 200000 | same as type 2 | Lv1..3 need hall 3, then hall = level | `NextTemplateId` lists skills unlocked: Lv1 -> 601,801,901,1001,1101,1201; Lv6 -> 1301..2001 |
| 5 | Depósito | 100, 800, 1800, 3200, 5000, 7200, 9800, 12800, 16200, 20000 | same as type 2 | Lv1..4 need hall 4, then hall = level | slots `storeLevel*5`, 56 at Lv10 (`CMOD:836-852`) |
| 26 | Torre de Habilidade de Mestre | 2000, 5000, 10000, 20000, 30000, 40000, 50000, 60000, 80000, 100000 (paid with production) | same as type 2 | Instituto level = target level (3001->401 ...) | `Property1` 2340..720 at Lv1..Lv10 (2520 at Lv0): master research cooldown (unit unknown, see open questions) |
| 27 | Escola de missões | Lv1 only, 2000 | 0 | none | not in the upgrade buttons |
| 28 | Câmara de Comércio | Lv1 only, 2000 | 0 | none | not in the upgrade buttons |

- Level 0 rows exist for types 2,3,4,5,26 (`TemplateId` x00) so the "current" description works before the first upgrade.
- Cost currency: type 26 uses `consortiaAsset` (`V/newui/ConsortiaDevelopView.as:214`,`:292-299`); all others use guild wealth `offer` (`:303`). Server must re-check and deduct the same currency.
- Construction cooldown ("resfriamento"): one per guild. Client remaining time = `code_need_date - (current_date - code_begin_date)` seconds (`:317-321`). While > 0 every upgrade button is disabled (`:218-221`). The level is raised immediately and `CodeTime` only blocks the next upgrade (same rule as `profile.md`; the UI calls it "Acelerar resfriamento", speed up cooldown). Assumption: research of skills (types 6..25, `CodeTime = 0`) does not start a cooldown.
- Speed up cost: `ceil(remaining_seconds / 600) * 1` diamonds (`Consortia_Fast = 1,10`, `raw/xml/tempinfos/ConfigInfos.xml`).
- Weekly upkeep: `levels * 500` wealth per week (`V/newui/ConsortiaInfoView.as:231`, equals hall `Property2`), deducted at `deduct_date` (see `funds.md`).
- Upkeep warning: if `now - warn_date >= 8 days` opening the guild shows "Taxa de manutenção da Guilda insuficiente, mais uma vez e a Guilda será dissolvida, contribua em tempo" (`CC:132-142`, `CC:184-188`).
- Altar: prayers per day = altar `Property2`; contribution per prayer = `Property1` (20); merit per prayer by god = `Altar_Reputation_Cost` = 0, 20, 30; god 2 needs altar 4, god 3 needs altar 7. Reward pools per god are described only in text: "Poção nv. 5, gemas, sementes de pastagem, etc.", "Ágata nv. 4, itens do sistema de Guardião, etc.", "Almas divinas, Pedras Rúnicas, itens do sistema de Espírito de Proteção, etc." (`ConsortiaNewAltarFrame.goodsTxt.text1..3`). The drop table is server side and not present in the client.
- Altar daily counter also feeds the activity queue order 1 "Bênção da Guilda" (`QBM:194-215`).
- Visibility in the building map: each building button appears only when its level > 0 (`V/newui/ConsortiaBuildingView.as:126-196`).
- Unused level field: `getLevelByUpgradeType` has no case 20 and returns 0 for 26..28 (`CINFO:265-319`); the develop view reads master school level from `masterSchoolLevel` through `buildBtnLevelAry` (`CINFO:353-356`).

## Templates

| File | Record | Fields used |
|---|---|---|
| `raw/xml/tempinfos/ConsortiaLevelInfos.xml` (247 rows) | `ConsortiaLevelInfo` -> `ConsortiaTemplete` (`decompiled/core_module/scripts/mvc/module/consortia/ConsortiaTemplete.as`) | `TemplateId`, `Types`, `Levels`, `LevelName` (pt-BR), `PreTemplateId` (prerequisite row), `NextTemplateId` (comma list of unlocked rows), `NeedOffer` (cost), `CodeTime` (build seconds), `Property1`, `Property2`, `Property3` (always 0), `Icon`, `Description`, `BuildingType` (1 hall, 2 building, 3 skill, 4 new building, 5 master skill) |
| `raw/xml/tempinfos/ConfigInfos.xml` | `ConfigInfo` | `Consortia_Fast` = `1,10`; `Altar_Reputation_Cost` = `0,20,30` |

## Persistent state

Aligned with the core module: `guild.guild` (`id serial`, `level` = hall level, `fortune` = wealth `offer`, `asset` = production `consortia_asset`, `cooldown_type` / `cooldown_started_at` / `cooldown_seconds` = `code_type` / `code_begin_date` / `code_need_date`, `next_maintenance_at`, `maintenance_warned_at`) is defined in `profile.md`; players are `public.player(id integer)`; members are `guild.member` (`membership.md`). This module adds:

```sql
CREATE TABLE guild.guild_building (
  guild_id      INTEGER  NOT NULL REFERENCES guild.guild(id) ON DELETE CASCADE,
  building_type SMALLINT NOT NULL CHECK (building_type IN (2,3,4,5,26,27,28)),
  level         SMALLINT NOT NULL DEFAULT 0 CHECK (level BETWEEN 0 AND 10),
  updated_at    TIMESTAMPTZ NOT NULL DEFAULT now(),
  PRIMARY KEY (guild_id, building_type)
);

CREATE TABLE guild.member_altar_day (
  player_id           BIGINT  NOT NULL REFERENCES public.player(id) ON DELETE CASCADE,
  day                 DATE     NOT NULL,
  guild_id            INTEGER  NOT NULL REFERENCES guild.guild(id) ON DELETE CASCADE,
  prayers_used        SMALLINT NOT NULL DEFAULT 0 CHECK (prayers_used >= 0),
  pending_template_id INTEGER,
  pending_count       INTEGER  CHECK (pending_count IS NULL OR pending_count > 0),
  PRIMARY KEY (player_id, day)
);

CREATE TABLE guild.altar_reward (
  id          SERIAL   PRIMARY KEY,
  god_index   SMALLINT NOT NULL CHECK (god_index BETWEEN 1 AND 3),
  template_id INTEGER  NOT NULL,
  count       INTEGER  NOT NULL CHECK (count > 0),
  weight      INTEGER  NOT NULL CHECK (weight > 0)
);
CREATE INDEX altar_reward_god_idx ON guild.altar_reward (god_index);
```

Rows of `guild_building` are created at level 0 when the guild is created (or read as 0 when missing). The construction cooldown is the shared `guild.guild.cooldown_*` triple; `cooldown_type` stores the building type that started it.

## Backend implementation notes

Ownership: 8212 (`guild::profile::handle_get_info`), 5133 with `upgrade_type = 1` (`guild::profile::handle_upgrade_level`) and 8545 (`guild::profile::handle_speed_up_cooldown`) are specified in `profile.md`; `guild::profile::handle_upgrade_level` forwards other types here. `guild::profile::encode_info` must read `guild_building`, `guild_tech` (`skills.md`) and storage columns (`warehouse.md`).

Handlers of this module:
- `guild::buildings::handle_upgrade` (5133 forwarded, `upgrade_type` in 2..5 or 26; types 6..25 go to `guild::skills::handle_research`).
- `guild::buildings::handle_altar_info` (8215).
- `guild::buildings::handle_altar_pray` (5145).
- `guild::buildings::handle_altar_collect` (8216).
- `guild::buildings::handle_altar_site` (8217, legacy, reply an empty 4144 or ignore).

Validation order for 5133 (building): member with right 3 -> cooldown elapsed (`cooldown_started_at + cooldown_seconds <= now`) -> current level < 10 -> template (type, level+1) exists -> prerequisite reached (`PreTemplateId` row: hall level from `guild.guild.level`, other buildings from `guild_building`, level >= its `Levels`) -> balance: `asset >= NeedOffer` for type 26, else `fortune >= NeedOffer`. One transaction: `SELECT ... FOR UPDATE` on `guild.guild`, debit, level + 1 in `guild_building`, start the cooldown (`cooldown_type = type`, `cooldown_started_at = now`, `cooldown_seconds = CodeTime`), insert a guild event (`logs.md`), commit; push 164 to all online members.

Validation order for 5145: member -> `altar_level >= 1` -> god index unlocked (`altar_level >= [1,4,7][i-1]`) -> `count >= 1` and `prayers_used + count <= Property2` -> `guild.member.contribution >= count*Property1` -> merit `>= count*cost[i]` -> roll rewards from `altar_reward`. One transaction updates `member_altar_day`, debits contribution and merit, stores the pending reward; reply 45, then 3, then 180. 8216 moves the pending reward into the bag (reply 4143 `result=true`, plus 115) or replies `result=false` when nothing is pending.

Pushes: 164 to all online guild members for level, cooldown and fortune/asset changes; 45, 4141, 4142, 4143 only to the acting player.

## Open questions

- 5133 failure: is there an error reply? None is handled; the server can stay silent.
- Unit of type 26 `Property1` (2520..720): seconds or minutes of master research cooldown (see `skills.md`).
- Types 27 and 28 have only Lv1 (`NeedOffer` 2000) and are not in `buildBtnTypeAry`; how they become level 1 (auto at some hall level or always 1) is not visible client side. `quest_lobby_lv` and `new_shop_lv` are only displayed.
- Exact altar drop tables per god and whether multi prayers return one 45 per prayer.
- Does a speed up of 0 remaining seconds cost 0 or is it rejected.

## Implementation checklist

- [ ] Client screen: ConsortiaFrame tabs render with live 4138 data
- [ ] Client screen: ConsortiaDevelopView (6 buildings, cost currency, cooldown, prerequisite text)
- [ ] Client screen: ConsortiaBuildingView buttons appear for levels > 0
- [ ] Client screen: ConsortiaNewAltarFrame with god tabs and counters
- [ ] Table `guild.guild_building` (cooldown uses `guild.guild.cooldown_*` from `profile.md`)
- [ ] Table `guild.member_altar_day`
- [ ] Table `guild.altar_reward` (seed per god)
- [ ] Template loader for `ConsortiaLevelInfos.xml` keyed by (Types, Levels) and TemplateId
- [ ] Handler `guild::buildings::handle_upgrade` (5133 types 2..5, 26, forwarded by `guild::profile::handle_upgrade_level` -> push 164)
- [ ] `guild::profile::encode_info` includes building levels (owned by `profile.md`; 8212 and 8545 handlers there)
- [ ] Handler `guild::buildings::handle_altar_info` (8215 -> 4141, optional 4142)
- [ ] Handler `guild::buildings::handle_altar_pray` (5145 -> 45, 3, 180)
- [ ] Handler `guild::buildings::handle_altar_collect` (8216 -> 4143, 115)
- [ ] Handler `guild::buildings::handle_altar_site` (8217, legacy no-op)
- [ ] Daily reset of `prayers_used` (new row per day)
- [ ] Encoder for `ConsortiaInfoMsg` economy fields and date strings `YYYY-MM-DD hh:mm:ss`
- [ ] Push fan-out of 164 to online guild members
