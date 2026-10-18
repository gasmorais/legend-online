# Beasts roster (data sync, list, deploy, follow, lock, handbook)

Path aliases:

| Alias | File |
|---|---|
| MM | `decompiled/core_module/scripts/yishi/manager/MonsterManager.as` |
| MMOD | `decompiled/core_module/scripts/mvc/module/monster/MonsterModel.as` |
| MI | `decompiled/core_module/scripts/mvc/module/monster/MonsterInfo.as` |
| MCC | `decompiled/core_module/scripts/mvc/module/monster/MonsterConstClass.as` |
| CIM | `decompiled/core_module/scripts/yishi/datas/ConfigInfoManager.as` |
| V | `decompiled/m14/scripts/monster/` |

## 1. Overview

Owns the beast entity and the two server messages every other module reuses: 4574 `U_C_MONSTER_DATA_LIST` (beast rows) and 4575 `U_C_MONSTER_USER_DATA` (circles, ovens, material items, recipes, exploration ids, contracts). Player actions here: open the frame (full sync), deploy or rest the fighting beast ("Entrar em batalha" / "Descansar"), mark a beast as first in the list, follow on the map, lock with the vice password, look at another player's beast, browse the handbook.

A player owns at most `monster_max_count` = 40 beasts (`raw/xml/tempinfos/ConfigInfos.xml`, client reads the misspelled key `"monster_max_count "` and falls back to 40, `CIM:1117-1123`). Exactly one beast can be in battle (`MMOD.enterWarMonster`, `MMOD:663-673`) and at most one can follow (`MMOD.getFollowMonster`, `MMOD:935-945`).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `V/MonsterFrame.as` | "Monstro" (`:245`) | Container with six image tabs: prop, train, skill, accessories, contract, handbook (`:98-114`; labels are bitmaps, no language keys); list on the left for tabs 0..2 (`:199-203`) | Toolbar, hotkey K, `SwitchPageHelp.openMonsterFrame` | Tabs 0..4 disabled while the roster is empty, then handbook selected (`:222-235`) |
| `V/view/MonsterListView.as` | | Paged roster, auto selects the fighting beast or the first one (`:123-137`) | MonsterFrame | `showMonsterList` sorted by `first` descending (`MM:129`) |
| `V/item/MonsterListItem.as` | | Row: icon, stars, "Nv. {0}", fighting badge, exploration badge, lock icon (`:101-122`) | list | `enterWar`, `exploreMonsterIds` contains id, `isLock` |
| `V/view/MonsterPropView.as` | | Attributes tab: avatar, name, stars, level, stage ("Fase"), fight power, EXP bar, 8 attribute bars, 3 active skills, accessory cell, buttons first / enter battle / rest / follow / cancel follow / lock (`:110-170`) | tab 0 | see Rules |
| `V/view/MonsterPropBagView.as`, `V/cell/MonsterPropBagCell.as`, `V/cell/MonsterBagCell.as` | | Accessory bag and the equipped accessory cell (see [accessories.md](accessories.md)) | tab 0 | bag 36 accessories, bag 37 equipped |
| `V/view/MonsterHandBookView.as`, `V/item/MonsterHandBookItem.as` | | Handbook: every beast type at max star, 8 per page, with avatar and active skills (`HandBookView:24,45-63`, `HandBookItem:65-101`); also hosts the magic circle frame (`HandBookView:34,80-89`) | tab 5 | `MMOD.monsterTempAry` (templates whose `Star` is the max star of the type, `MMOD:104-124`) |
| `V/view/MonsterPropSeeView.as`, `V/view/MonsterPropSeeViewFrame.as` | "Verificar Monstro" | Read only attributes of another player's beast (`MonsterPropView(false)`, `MonsterPropView.as:97-107,167-178`) | `MonsterControler` openType `LOOK_UP_MONSTER` -> `playerInfo.monsterPropSeeView` (`decompiled/core_module/scripts/mvc/controler/MonsterControler.as:24-31`) | `MonsterInfo` built from rankings XML (`decompiled/core_module/scripts/mvc/controler/SortController.as:460-479`) |

## 3. Routes (client to server)

### R1. Full sync on frame open (op 1)
- UI: constructing `MonsterFrame` (`V/MonsterFrame.as:60-68`).
- Sender: `MM.sendMonsterInfoRequest` (`MM:234-240`).
- Checks: none.
- Route: send 8652 (0x21cc) `C_MONSTER_CLIENT_OP`, `MonsterClientOpMsg`: `opType` (#1, INT32) = 1. Other fields unset.
- Response order: 4574 `MonsterListMsg` with every beast (`opType` 1), then 4575 `MonsterUserMsg` with `opType` 0 (full user data: calls, cooks, items, recipes, exploreFights, contracts). `opType` 0 makes the client clear the item caches before refilling (`MM:173-176`) and fire `MONSTER_USER_INFO_CHANGE` (`MM:204-207`).

### R2. Deploy / rest (op 17, toggle)
- UI: enter battle `_enterWarBtn` and rest `_restBtn` (bitmap buttons), only one visible depending on `enterWar` (`V/view/MonsterPropView.as:353-361,384-385`).
- Sender: `MM.sendMonsterOperate(17, monsterId)` (`MM:242-249`).
- Checks: none client side.
- Route: 8652, `opType` = 17, `monsterId` (#2, INT32) = beast id.
- Server: if the beast is fighting, set it to rest; otherwise set it fighting and set any previous fighting beast to rest (single fighter, `MMOD:663-673`).
- Response: 4574 `opType` 17 with the changed rows (old and new fighter).

### R3. Mark as first (op 18)
- UI: "first" button `_firstBtn`, disabled when the beast is already at index 0 (`MonsterPropView.as:348-351,383`).
- Route: 8652, `opType` = 18, `monsterId`.
- Server: set `first` of this beast to `max(first) + 1` over the roster (assumption: the client only sorts by `first` descending, `MM:129`).
- Response: 4574 `opType` 18 with at least the changed row.

### R4. Follow / cancel follow (ops 19, 20)
- UI: `_followBtn` / `_cancelFollowBtn`, shown only when `VersionSwitch.MONSTER_FOLLOW` (`MonsterPropView.as:157-161,291-305,407-416`).
- Route: 8652, `opType` = 19 or 20, `monsterId`.
- Server: op 19 sets `is_follow` on this beast and clears it on the others; op 20 clears it.
- Response: 4574 `opType` 19/20 with changed rows. The client copies the follow beast template into `ThaneInfo.monsterTempteId` (`MM:119-127`). Also push 150 `ArmyMsg` with `monster_id` (#42, INT32) = follow template id (0 when none) to the owner and to players on the same map (`decompiled/core_module/scripts/com/road/pb/helper/army/ThaneInfoHelper.as:115-118`, `decompiled/core_module/scripts/map/space/SpaceManager.as:331-335`, `decompiled/core_module/scripts/map/campaign/CampaignManager.as:707-711`).

### R5. Lock with vice password
- UI: lock button `_btnVpLock` (tip "mainBar.SmallMapBar.vicepasswordBtnTipData") (`MonsterPropView.as:260-289`).
- Checks: during password reset -> "Durante o periodo de reset à senha, não pode realizar nenhuma operação"; no vice password -> open `vicepassword` frame type 1; `GlobalConfig.isConfirmPassword` false -> open `vicepassword` frame type 3 (password entry).
- Sender: `VicePasswordUtil.vpLockOp(6, 0, monsterId)` (`decompiled/core_module/scripts/mainBar/vicePassword/VicePasswordUtil.as:40-49`).
- Route: send 8809 `LockAndUnlockMsg`: `op_type` (#1, INT32) = 6 (beast lock toggle), `item_pos` (#2, INT32) = 0, `pet_id` (#3, INT32) = monster id. Owned by the vice password module of [../account/README.md](../account/README.md).
- Response: 4574 with `isLock` toggled (assumption, the client has no dedicated handler). Locked beasts cannot be used as evolution or skill material ("O monstro atual foi bloqueado, primeiro desbloqueie", `V/item/MonsterIconCell.as:246-250`).

### R6. Look at another player's beast
No socket route in this module: the data comes from the rankings player XML (`SortController.as:460-479`) and opens `MonsterPropSeeView`. See [../rankings/README.md](../rankings/README.md).

## 4. Server messages (server to client)

### S1. 4574 (0x11de) `U_C_MONSTER_DATA_LIST`
- Message `MonsterListMsg` (package monster): `opType` (#1, INT32) echo of the request op that caused it (the evolution frame closes when it is 16, `V/MonsterEvolveFrame.as:209-216`), `monsters` (#2, MonsterMsg, repeated) changed rows.
- `MonsterMsg`: `monsterId` (#1, INT32) beast id; `name` (#2, STRING) display name; `type` (#3, INT32) template `Type`; `star` (#4, INT32) current star; `level` (#5, INT32) level; `exp` (#6, INT32) current level EXP; `stageLevel` (#7, INT32) stage ("Fase"); `stateExp` (#8, INT32) stage EXP; `fightPower` (#9, INT32); `skills` (#10, STRING) `"skillTemplateId,exp|skillTemplateId,exp"` (`MI:84-103`); `first` (#11, INT32) list order key; `isFight` (#12, BOOL) deployed; `isLock` (#13, BOOL) vice password lock; `isExist` (#14, BOOL) false deletes the row client side; `isFollow` (#15, BOOL).
- Receiver: `MM.__monsterListHandler` (`MM:64-131`): upserts or deletes rows, recomputes the follow template, re-sorts by `first`, notifies `MONSTER_INFO_CHANGE` with `opType`.
- When: response to ops 1, 5 (new beast), 14, 15, 16 (material beasts sent with `isExist` false), 17..20, lock; push when exploration changes EXP or level.

### S2. 4575 (0x11df) `U_C_MONSTER_USER_DATA`
- Message `MonsterUserMsg`: `opType` (#1, INT32) section selector; `calls` (#2, CallInfoMsg, repeated); `cooks` (#3, CookInfoMsg, repeated); `items` (#4, ItemCountMsg, repeated); `recipes` (#5, INT32, repeated); `exploreFights` (#6, INT32, repeated) beast ids in the exploration team; `contracts` (#7, INT32, repeated) 3 beast ids, 0 = empty.
- `CallInfoMsg` / `CookInfoMsg`: `index` (#1, INT32) slot 1..4; `level` (#2, INT32) 1 initial, 2 medium, 3 advanced; `state` (#3, INT32) 0 idle, 1 working; `stopTime` (#4, STRING `YYYY-MM-DD hh:mm:ss`) end of the timer.
- `ItemCountMsg`: `templateId` (#1, INT32), `count` (#2, INT32). Items with `SonType` 231 go to the summon bag, `SonType` 230 to the food bag (`MM:177-191`).
- Receiver: `MM.__monsterUserInfoHandler` (`MM:138-232`). Reaction per `opType`: 0 full (clear item caches, set exploration ids, `MONSTER_USER_INFO_CHANGE`); 2 `MONSTER_CALL_CHANGE`; 3 `MONSTER_COOK_CHANGE`; 4 clear and refill items, `MONSTER_ITEMMSG_CHANGE`; 5 `MONSTER_RECIPE_CHANGE`; 6 exploration ids, `MONSTER_EXPLORE_IDLIST`; 8 `CONTRACT_INFO_CHANGE`. `recipes` and `contracts` replace the cached arrays only when non empty (`MM:192-199`), so to clear all contracts send `[0,0,0]`.
- When: opType 0 after op 1 (and login, assumption); see the other modules for 2, 3, 4, 8; opType 6 is sent by [../exploration/README.md](../exploration/README.md).

### S3. 150 (0x0096) `ArmyMsg` field `monster_id` (#42, INT32)
Follow beast template id for map avatars (see R4). Owned by [../hero/README.md](../hero/README.md).

## 5. Rules and formulas

- Templates per beast: `MonsterTemplates.xml` row for (`Type`, `Star`) (`MI:105-108`). 23 types: 1..19 with stars 1..3 (`MaxLevel` 40/80/120), 96..99 with stars 1..4 (`MaxLevel` 40/80/120/160). Example: type 1 "Lobo Demoníaco" ids 101/102/103.
- Level EXP: `UpGradeTempInfos` `Types=147`, row `grade - 1`, `Data` = EXP to next level (335 at Lv1 .. 10750995 at Lv200) (`MMOD:136,500-504`). Level cap is the template `MaxLevel` for the current star (`MonsterPropView.as:387-391`). EXP is earned in Monster Exploration (4580, [../exploration/README.md](../exploration/README.md)).
- Attributes (8): `Attack`, `Defence`, `MagicAttack`, `MagicDefence`, `ForceHit`, `Penetrate`, `Parry`, `Live` (`MMOD:32`). Base from `SkillPropertyTempInfos.xml` row `PropertyId` of the template. Formula (`MMOD:506-513`):
  `v = int(base / 10 / star) * (level - 1) + base`; `value = int(v * (stage_bonus + 100) / 100)` where `stage_bonus` = `ActiveObject` of `UpGradeTempInfos Types=148` row index `stageLevel` (0, 20, 50, 100, 150 percent for stages 0..4).
  The bar maximum uses the same formula with `level = MaxLevel` and `stage = star` (`MMOD:515-524`).
- Active skills shown: skills of the beast whose `SonType` is listed in the current template `SkillSonTypes` (`MI:128-151`); passive skills are `PassiveSkillSonTypes` (830001, 830002 for every type).
- `fightPower` is computed by the server (formula not in the client; assumption: derived from the 8 attributes and skill levels, see Open questions).
- Single fighter: at most one `isFight` true. Single follower: at most one `isFollow` true.
- List order: `first` descending (`MM:129`).
- Beasts in the exploration team are flagged (`MonsterListItem.as:109`); beasts that are fighting, following, in a contract, in the exploration team or locked must not be consumed as material (assumption, server side; the client only blocks locked beasts).

## 6. Templates

| File | Use |
|---|---|
| `raw/xml/tempinfos/MonsterTemplates.xml` | `TemplateId`, `Name`, `Type`, `Star`, `MaxLevel`, `PropertyId`, `SkillSonTypes`, `PassiveSkillSonTypes`, `Icon`, `ResPath`, `ResType`, `DefaultSkill`, `Scale`, `Offset`, `DefaultAttack` |
| `raw/xml/tempinfos/SkillPropertyTempInfos.xml` | Base attributes by `PropertyId` |
| `raw/xml/tempinfos/UpGradeTempInfos.xml` | `Types` 147 (level EXP), 148 (stage EXP and bonus) |
| `raw/xml/tempinfos/SkillTempInfos.xml` | Beast skills by `SonType` 830101.. and `Grades` |
| `raw/xml/tempinfos/ConfigInfos.xml` | `monster_max_count` 40 |

## 7. Persistent state

```sql
CREATE SCHEMA IF NOT EXISTS monsters;

CREATE TABLE monsters.monsters (
  monster_id     BIGSERIAL   PRIMARY KEY,
  player_id      BIGINT      NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  name           TEXT        NOT NULL,
  monster_type   SMALLINT    NOT NULL,
  star           SMALLINT    NOT NULL CHECK (star BETWEEN 1 AND 4),
  level          SMALLINT    NOT NULL DEFAULT 1 CHECK (level >= 1),
  exp            INTEGER     NOT NULL DEFAULT 0 CHECK (exp >= 0),
  stage_level    SMALLINT    NOT NULL DEFAULT 0 CHECK (stage_level >= 0),
  stage_exp      INTEGER     NOT NULL DEFAULT 0 CHECK (stage_exp >= 0),
  fight_power    INTEGER     NOT NULL DEFAULT 0,
  sort_first     INTEGER     NOT NULL DEFAULT 0,
  is_fighting    BOOLEAN     NOT NULL DEFAULT false,
  is_following   BOOLEAN     NOT NULL DEFAULT false,
  is_locked      BOOLEAN     NOT NULL DEFAULT false,
  created_at     TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX monsters_player_idx ON monsters.monsters (player_id);
CREATE UNIQUE INDEX monsters_one_fighter ON monsters.monsters (player_id) WHERE is_fighting;
CREATE UNIQUE INDEX monsters_one_follower ON monsters.monsters (player_id) WHERE is_following;

CREATE TABLE monsters.monster_skills (
  monster_id        BIGINT   NOT NULL REFERENCES monsters.monsters(monster_id) ON DELETE CASCADE,
  skill_son_type    INTEGER  NOT NULL,
  skill_template_id INTEGER  NOT NULL,
  skill_exp         INTEGER  NOT NULL DEFAULT 0,
  PRIMARY KEY (monster_id, skill_son_type)
);
```

`monster_skills` serializes to `MonsterMsg.skills` as `template_id,exp` joined by `|`. Material item counts and per player state are in [summon.md](summon.md) and [contracts.md](contracts.md).

## 8. Backend implementation notes

- `monsters::beasts::handle_client_op` decodes 8652 and dispatches by `opType` to the handlers of every module.
- `monsters::beasts::handle_request_data` (op 1): read roster, skills, circles, ovens, item counts, recipes, exploration ids, contracts; send 4574 (opType 1) then 4575 (opType 0).
- `monsters::beasts::handle_fight` (op 17): validate ownership and `is_exist`; transaction: clear `is_fighting` on the player, set it on the target unless it was already fighting; send 4574 with both rows; recompute lord fighting capacity (hero feature).
- `monsters::beasts::handle_first` (op 18), `handle_follow` (op 19), `handle_cancel_follow` (op 20): same pattern; follow changes also broadcast 150 `ArmyMsg` to viewers of the owner's army.
- Lock (8809 op 6) is routed by the account security module and calls `monsters::beasts::set_locked`.
- Validation order: beast exists and belongs to the player -> state allows the action -> write -> push.
- Battle configuration: when the lord enters a battle, the fighting beast is added to `monsters[]` of the lord side with its attributes, skills and `DefaultSkill`; manual skill casts arrive as 10520 `B_MONSTER_ORDER` (`UseSkillMsg`: `battle_id` #1 STRING, `hero_id` #2 INT32, `skill_id` #3 INT32, `decompiled/core_module/scripts/yishi/service/managers/SocketSendManager.as:248-256`). See `docs/battle/server-engine.md` and `docs/battle/formation.md` (monster role row).

## 9. Open questions and assumptions

- Assumption: login pushes 4574 + 4575 (opType 0) so the toolbar and battle know the roster; the client only requests op 1 when the frame opens.
- Fight power formula is server side only.
- Assumption: R3 "first" increments a counter; any monotonic value works.
- Assumption: lock toggles through 8809 and is reported by 4574 `isLock`.
- Name of a new beast: assumption = template `Name`.
- `MonsterModel.OWN_MAX_COUNT` = 12 is unused; the real cap is config 40.

## 10. Implementation checklist

- [ ] Screen: MonsterFrame tabs enable logic with empty roster
- [ ] Screen: list, attributes view, handbook, look up view
- [ ] Route 8652 op 1 -> 4574 (opType 1) + 4575 (opType 0)
- [ ] Route 8652 op 17 deploy/rest toggle
- [ ] Route 8652 op 18 first
- [ ] Route 8652 ops 19/20 follow, plus 150 `ArmyMsg.monster_id` broadcast
- [ ] Route 8809 op 6 lock integration
- [ ] Server message 4574 encoder (`MonsterListMsg`, `MonsterMsg` 15 fields)
- [ ] Server message 4575 encoder (`MonsterUserMsg` sections)
- [ ] Table `monsters.monsters` with single fighter and follower indexes
- [ ] Table `monsters.monster_skills`
- [ ] Rule: attribute formula with stage bonus (type 148)
- [ ] Rule: level cap by star `MaxLevel`, EXP table type 147
- [ ] Rule: max 40 beasts
- [ ] Battle hook: fighting beast as monster unit, 10520 skill order
- [ ] Tests: deploy toggles previous fighter, follow uniqueness, removed beast sends `isExist` false
