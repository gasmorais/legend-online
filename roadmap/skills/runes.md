# Runes (Runa)

Path aliases:

| Alias | File |
|---|---|
| ASOM | `decompiled/core_module/scripts/managers/ArmySocketOutManager.as` |
| AC | `decompiled/core_module/scripts/mvc/controler/ArmyControler.as` |
| AM | `decompiled/core_module/scripts/yishi/manager/ArmyManager.as` |
| TIH | `decompiled/core_module/scripts/com/road/pb/helper/army/ThaneInfoHelper.as` |
| RC | `decompiled/core_module/scripts/yishi/datas/playerinfo/RuneCategory.as` |
| RI | `decompiled/core_module/scripts/mvc/module/armyII/RuneInfo.as` |
| SF | `decompiled/m5/scripts/armyII/SkillFrame.as` |
| SV | `decompiled/m5/scripts/armyII/viewII/skill/SkillView.as` |
| RV | `decompiled/m5/scripts/armyII/viewII/rune/RuneView.as` |
| RIV | `decompiled/m5/scripts/armyII/viewII/rune/RuneItemView.as` |
| RUV | `decompiled/m5/scripts/armyII/viewII/rune/RuneUpgradeView.as` |
| RB | `decompiled/m5/scripts/armyII/viewII/rune/RuneBag.as` |
| FRI | `decompiled/m5/scripts/armyII/viewII/rune/FastRuneItem.as` |

## 1. Overview

Runes are battle items: each rune type (10 types, `RuneTempInfos.RuneType` 1..10) maps to a skill (`SkillTemplateId`) usable `UseCount` times per battle on the Z and X keys, with a shared cooldown `RuneCommonCD` = 20000 ms. The player:
1. learns a rune by consuming one rune stone item ("Pedra Rúnica", SonType 302 with `Property1 = RuneType`);
2. raises it (grades 1..10 for tier `Level 0`, 1..8 for tier `Level 1`) by feeding items into an 8-slot hidden bag and converting them into rune EXP ("Elevar Runa");
3. promotes a maxed tier 0 rune to its advanced tier 1 version ("Runa ... Avançada") by consuming 10 x item 3021001, after a vocation upgrade;
4. carries 1 rune (hero level 35) or 2 runes (level 40, `CarryTwoRune`) on the skill bar.

Rune holes and rune gems (op types 5..7) are in [rune-stones.md](rune-stones.md).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `armyII.viewII.rune.RuneView` (RV) | "Runa" (`armyII.SkillFrame.runeTitle`, SF:605) | 2x5 grid of runes sorted by `RuneIndex`, 2 carried rune slots, help | `SkillFrame` tab 1 when hero level >= `OpenRuneGrade` 35, else "Nv.{0} activado" (SF:592-608) | `runeCate.allRuneList` |
| `armyII.viewII.rune.RuneItemView` (RIV) | buttons "Aprender" (`armyII.viewII.rune.RuneItemView.StudyBtnTxt`), "+", promote, "Ativar slot de runa" / "Slot de runa" | One rune: icon, level, study/upgrade/promote/socket buttons | RuneView | `RuneInfo` (grade, `runeCurGp`, `swallowCount`, holes) |
| `armyII.viewII.rune.RuneUpgradeView` (RUV) | "Elevar Runa" (`armyII.viewII.rune.RuneUpgradeView.TitleTxt`) | Feed items, show "Experiência obtida:", "Automático" fill, quick buy | "+" on a learned rune (RIV:451-458) | EXP bar `runeCurGp / next.NeedGp`, "Máx." icon |
| `armyII.viewII.rune.RuneBag` (RB) | | Filtered bag (items SonType 302) | RuneUpgradeView | bag 1 items |
| `armyII.viewII.rune.FastRuneItem` (FRI) | keys "Z", "X"; lock tip "Fechado" | Carried rune slots in RuneView and SkillView | RV:168-203, SV:224-282 | `runeCate.runeScript` |
| `core.RuneHelpFrame` | | Static help | help buttons | none |

## 3. Routes (client to server)

All rune operations share one request: send 8605 (0x219d) `U_C_HERO_RUNE_OP` (name from `ProtocolType.as:320`, absent in opcodes.csv) with `HeroRuneOpMsg` (army):

| Field | Tag/type | Meaning |
|---|---|---|
| `user_id` | #1, INT32 | `ArmyManager.army.userId` (always set) |
| `runeId` | #2, INT32 | rune template id of the target rune (current level row) |
| `runeKey` | #3, STRING | CSV of carried rune template ids (op 3) |
| `learn_runePos` | #4, INT32 | bag position of the rune stone item (op 1) |
| `learn_runeCount` | #5, INT32 | stones to consume (op 1, always 1) |
| `opType` | #6, INT32 | 1 learn, 2 upgrade, 3 set carried runes, 4 promote, 5 activate holes, 6 engrave, 7 replace holes |
| `opResult` | #7, BOOL | response only |
| `runeInfo` | #8, `HeroRuneMsg` | response only |
| `count` | #9, INT32 | response only (`playerInfo.diamondIndex`) |
| `runeType` | #10, INT32 | not set by the client |

### R1. Learn a rune (op 1)
- UI: "Aprender" (RIV:381-400) on a grade 0 rune.
- Client checks: owns a rune stone (item SonType 302, `Property1 == RuneType`, bound preferred, RIV:760-794); confirm "Consumir <font color='#1fd6e6'> uma Pedra Rúnica da {0}</font> para aprender {0}" (`armyII.viewII.rune.RuneStudyConfirmTxt`). Without a stone the quick buy frame opens for the stone of that type (RIV:402-421) and the study is sent after purchase.
- Client path: `AC.sendStudyRune(runeId, pos)` (AC:396-399) → `ASOM.sendStudyRune` (ASOM:120-130): `opType 1`, `runeId`, `learn_runePos = item.pos`, `learn_runeCount = 1`.
- Expected response: 4495 (S1) with `opResult true`, `opType 1` → "Apredizado sucedido" (`armyII.viewII.rune.RuneStudyTipTxt`), plus bag update for the consumed stone ([../inventory/README.md](../inventory/README.md)).

### R2. Upgrade a rune (op 2)
- UI: `RuneUpgradeView` upgrade button (RUV:472-492). Before sending, the player moves up to 8 items into the hidden bag (bag type 0, positions 0..7) by drag or "Automático" (RUV:333-410); each move is 5005 `U_C_BAG_MOVE` (`ItemReqMsg`, `PlayerManager.moveBagToBag`, see inventory). Closing the view moves them back to bag 1 (RUV:623-631).
- Client checks: `grade < 10` and a next level exists, else "Runa atingiu nível máximo" (`UpgradeTipTxt3`); if hero level < `next.NeedGrade` and the EXP bar is already full, "Nível do personagem insuficiente, eleve antes de absorver" (`UpgradeTipTxt2`); button enabled only when computed EXP > 0 (RUV:566-576).
- Client path: `AC.sendUpgradeRune(runeId)` (AC:401-404) → `ASOM.sendUpgradeRune` (ASOM:190-198), `opType 2`.
- Expected response: 4495 with the new `runeinfo` (grade, `rune_gp`, `swallowCount`), bag removals for consumed items.

### R3. Set carried runes (op 3)
- UI: drag a learned rune onto a Z/X slot (RIV:479-505) or drag it off; auto placement after learning when fewer than 2 are carried (RIV:315-358); also after a skill set switch (SV:740-750).
- Client checks: rune type not already carried (`RC.hasCarryed`), slot not locked (slot i locked while hero level < 35 + 5 * i, RV:184, SV:241).
- Serialization: `RuneView.fastKey` / `SkillView.runefastKey` (SV:836-859): for 2 slots, `runeId + ","` or `"-1,"`.
- Client path: `AC.sendTakeRune(key)` (AC:406-409) → `ASOM.sendTakeRune` (ASOM:220-228): `opType 3`, `runeKey`.
- Expected response: 4495 `opType 3` with `runeInfo.runeKey`; the client sets `runeCate.runeScript` and notifies `DOUBLE_KEY_CHANGE` (AM:566-570).

### R4. Promote a rune (op 4)
- UI: promote button on a max level tier 0 rune when a tier 1 exists (`needShowPromotBtn`, RIV:746-758).
- Client checks: `vocationGrades > 0` else "Após elevar a profissão poderá liberar" (`runeitemView.tip02`); 10 x item 3021001 in bag else quick buy of 10 (RIV:235-273); confirm "Deseja consumir {0} {1}  para ativar {2}?" (`armyController.promotRuneTip`).
- Client path: `ASOM.sendPromotRune(runeId)` (ASOM:230-238), `opType 4`.
- Expected response: 4495 `opType 4` with the new tier 1 rune in `runeinfo` and optionally `runeKey` (carried slot follows the promoted id, AM:578-584).

### R5. Quick buy
Rune stones (SonType 302), 3020010 (tier 0 EXP item) and 3021001 (tier 1 item) are bought through the quick buy frame, which uses the shop feature ([../shops/README.md](../shops/README.md)).

## 4. Server messages (server to client)

### S1. 4495 (0x118f) `U_C_RUNE_OP` (name from `AcceptProtocolType.as:320`)
- Message `HeroRuneOpMsg` (fields above). Response fields: `opType` (#6) echo, `opResult` (#7, BOOL) success, `runeInfo` (#8) = `HeroRuneMsg { user_id (#1, INT32), runeinfo (#2, HeroRuneInfoMsg, repeated), runeKey (#3, STRING) }`, `count` (#9, INT32) stored as `playerInfo.diamondIndex` when non-zero (no reader in the UI).
- `HeroRuneInfoMsg`: `rune_id` (#1, INT32) rune template id (level row), `rune_gp` (#2, INT32) current EXP, `swallowCount` (#3, INT32) items absorbed today, `rune_hole` (#4, STRING) and `temp_hole` (#5, STRING) see [rune-stones.md](rune-stones.md), `newSkillTempId` (#6, INT32) replacement skill granted by hole effects, `baseProperties` (#7, `BasePropertiesMsg`) stats from socketed gems.
- Receiver: `AM.__runeOperateHandler` (AM:546-624). `opResult false` is ignored. Op 3 only updates `runeScript`. Other ops update each listed rune by `RuneIndex`, set `runeStoneOpen` when a hole string exists, notify `RUNE_UPGRADE` (or `RUNE_NO_CHANGE` when nothing changed).

### S2. 4527 (0x11af) `U_C_RUNE_RESET`
- No body read. Receiver `AM.__runeResetHandler` (AM:626-645) sets `swallowCount = 0` on every rune and notifies `RUNE_UPGRADE`.
- When: daily reset push to online players (absorption counter, `RuneSwallowMax` = 999999 per day).

### S3. 113 `U_C_HERO_INFO` field `rune` (#60, `HeroRuneMsg`)
Read by `TIH.readHeroRuneInfo` (TIH:462-491): `runeKey` → `runeScript`, every `runeinfo` stored in `studiedRuneList` by `RuneType`. Sent at login inside 150 and on full hero refresh.

## 5. Rules and formulas

- Unlock: `OpenRuneGrade` = 35; second carried slot at 40 (`CarryTwoRune`; client uses 35 + 5 * slot).
- Learn: 1 rune stone of the same `RuneType`; result grade 1 = template with `RuneGrade 1` of that type.
- EXP from fed items (RUV:520-564), per item stack with template `Property1` (rune type) and `Property2` (EXP):
  - same type, or `Property1` 0, or 100: `Property2 * count`; `Property1 == 100` (universal) gives 50 per item for tier 0 runes and 10 for tier 1 runes;
  - other type: `Property2 / 10 * count`.
- Bag filter: only SonType 302; for tier 1 runes only `Property1 == 100` items are accepted (RB:258-286).
- Level up: when `rune_gp >= next.NeedGp` and hero level >= `next.NeedGrade` (tier 0) or `vocationGrades >= next.NeedGrade` (tier 1) (SF:286-336). Grade caps: tier 0 grade 10, tier 1 grade 8 (SF:318, SF:325).
- Promote: tier 0 at max grade → first row of the same `RuneType` with `Level = 1` (`getMaxRuneTemplateInfoByRuneType`, RIV:629-646); cost 10 x 3021001; needs vocation upgrade.
- Daily absorb limit `RuneSwallowMax` = 999999 (effectively unlimited), reset by 4527.
- `Rune_Points` = `2,4,6,...,20` ("炼符所需钻石", diamonds per refine) has no client user; probably a diamond EXP purchase counted by `count`/`diamondIndex` *(assumption)*.
- Battle: rune skills are in the battle item slots `skills[9 + bagPos]`; `UseCount` uses per battle; common CD `RuneCommonCD` (`docs/battle/rules.md`).

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `RuneTempInfos.xml` | one row per rune level (132 rows) | `TemplateId`, `TemplateName`, `RuneType` (1..10), `SonType` (91), `Job`, `RuneGrade` (level), `SkillTemplateId` (battle skill), `RuneIndex` (grid order), `Icon`, `NextRuneId`, `NeedGp` (EXP to reach this level), `UseCount` (uses per battle), `NeedGrade` (hero level, or vocation level for tier 1), `Description`, `Level` (tier 0 normal, 1 advanced) |
| `ItemTempInfos.xml` | rune stones (SonType 302), 3020010, 3021001 | `Property1` rune type (0/100 universal), `Property2` EXP |
| `ConfigInfos.xml` | | `OpenRuneGrade` 35, `CarryTwoRune` 40, `RuneSwallowMax` 999999, `RuneCommonCD` 20000, `Rune_Points` |
| `SkillTempInfos.xml` | rune skills (MasterType 0, ids 9101..) | battle behavior |

## 7. Persistent state

```sql
CREATE TABLE skills.runes (
    player_id          BIGINT  NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
    rune_type          SMALLINT NOT NULL CHECK (rune_type BETWEEN 1 AND 10),
    template_id        INTEGER NOT NULL,
    rune_exp           INTEGER NOT NULL DEFAULT 0 CHECK (rune_exp >= 0),
    swallow_count      INTEGER NOT NULL DEFAULT 0,
    hole_layout        TEXT,
    pending_hole_layout TEXT,
    new_skill_template_id INTEGER NOT NULL DEFAULT 0,
    learned_at         TIMESTAMPTZ NOT NULL DEFAULT now(),
    PRIMARY KEY (player_id, rune_type)
);

CREATE TABLE skills.rune_loadout (
    player_id        BIGINT PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
    slot1_template_id INTEGER,
    slot2_template_id INTEGER,
    CHECK (slot1_template_id IS NULL OR slot2_template_id IS NULL OR slot1_template_id <> slot2_template_id)
);
```

Items consumed live in `inventory.items` *(assumption: inventory feature schema)*.

## 8. Backend implementation notes

- `skills::runes::handle_rune_op` (8605) dispatches by `opType`:
  - `handle_learn` (1): rune type of `runeId` not learned; item at bag 1 `learn_runePos` has SonType 302 and `Property1 = RuneType`; hero level >= 35; consume 1; insert grade 1 row; reply 4495 `{opType 1, opResult true, runeInfo{runeinfo:[row]}}`; bag push.
  - `handle_upgrade` (2): sum EXP from hidden bag 0 items with the formula above; respect grade caps and `NeedGrade`; apply multiple level-ups while EXP suffices; consume items; increment `swallow_count`; reply 4495 with the row; bag push.
  - `handle_set_loadout` (3): parse `runeKey`, max 2 entries, slot 2 only at level 40, each learned and distinct; reply 4495 `{opType 3, opResult true, runeInfo{runeKey}}`.
  - `handle_promote` (4): grade at max, tier 1 exists, `vocationGrades > 0`, 10 x 3021001; replace the row with the tier 1 grade 1 template; keep the loadout pointing to the new id; reply 4495 with `runeinfo` and `runeKey`.
  - ops 5..7: see [rune-stones.md](rune-stones.md).
- Daily job: reset `swallow_count`, push 4527 to online players.
- Battle configuration: carried runes become battle items with `UseCount` uses.

## 9. Open questions and assumptions

- Assumption: the hidden bag 0 (8 slots) holds feed items between 5005 moves and op 2; the server consumes all of them.
- Assumption: `count` in 4495 and `Rune_Points` relate to a diamond refine feature without UI in BR.
- Open: failure codes; the client ignores `opResult false` silently, so send a generic message push for errors.

## 10. Implementation checklist

- [ ] Screen: RuneView grid and Z/X slots from 113 `rune`
- [ ] Screen: RuneUpgradeView EXP preview
- [ ] Route 8605 op 1 learn
- [ ] Route 8605 op 2 upgrade (with 5005 hidden bag moves)
- [ ] Route 8605 op 3 loadout
- [ ] Route 8605 op 4 promote
- [ ] Server message 4495 per op
- [ ] Server message 4527 daily reset
- [ ] Server message 113 `rune` field
- [ ] Table `skills.runes`
- [ ] Table `skills.rune_loadout`
- [ ] Rule: EXP formula and grade caps
- [ ] Rule: slot unlock 35/40
- [ ] Test: learn, feed, multi-level up, promote, loadout swap
