# Divine slates ("Placa divina", proto package `slate`)

Module of [README.md](README.md). Protocol of the `slate` package: Theseus divine slates ("Placa de corte" items, MasterType 15 SonType 800) placed on a 25 cell grid, levelled, promoted (stars), rotated, locked, decomposed into "Poeira de placa", plus slate missions. The screens live in the Theseus client package (`theseusgodhead`, owned by [../theseus/README.md](../theseus/README.md)); this module defines routes, messages, rules and state.

Path aliases:

| Alias | File |
|---|---|
| TSM | `decompiled/core_module/scripts/managers/TheseussoulManager.as` |
| TGM | `decompiled/core_module/scripts/mvc/module/theseus/TheseusGodheadModel.as` |
| TGSI | `decompiled/core_module/scripts/mvc/module/theseus/TheseusGodheadStoneInfo.as` |
| TAF | `decompiled/m5/scripts/theseusgodhead/TheseusgodAllFrame.as` |
| TGV | `decompiled/m5/scripts/theseusgodhead/view/TheseusGodheadView.as` |
| TUV | `decompiled/m5/scripts/theseusgodhead/view/TheseusGodheadUpgradeView.as` |
| TSV | `decompiled/m5/scripts/theseusgodhead/view/TheseusGodheadStarUpView.as` |
| GISV | `decompiled/m5/scripts/theseusgodhead/view/GodItemSellView.as` |
| TTI | `decompiled/m5/scripts/theseusgodhead/item/TheseusGodheadTaskItem.as` |

## 1. Overview

- Slate templates: `SlateTmpls.xml` (144 rows, ids 1000.., 6 star levels per slate, `SlateType` 1 attributes, 2 passive skill, 3 multiple skills, 4 trigger skill; `SlateShape` 1..7 occupies grid cells; `SlateProfile` quality 3..5). Item templates 30010000.. (144 rows, MasterType 15, SonType 800, `MaxCount 1`) are the bag form (assumption: one item template per slate template).
- A player owns slates (id, template, level, star = template id % 10, rotation, grid position or bag position, lock flag). The grid has 25 cells (5 x 5, `TGM:59-62`); cells are unlocked with "Chave de Teseus" (item 30000001); `posMark` is a bitmask where bit `n` = 1 means cell `n` is still locked (`TGM:74-81`).
- Operations use one request opcode 9762 with `player.PlayerOpMsg.op` 1..11 and one push 1024 `U_C_SLATE_USER_DATA` (`slate.UserSlateMsg`).
- Equipped slates give attributes (`SlatePropertyMsg`) and skills.

## 2. Screens (owned by Theseus)

| Class | pt-BR title | Purpose |
|---|---|---|
| `theseusgodhead.TheseusgodAllFrame` (controller `TheseussoulController` open type 10) | "Placa divina" (`theseusgodhead.txt1`), tabs "Placa divina", "Elevação", "Promoção", "Missão" (`TAF:259`) | grid, slate bag (pages), decompose and rotate buttons ("Decompor", "Virar"), lock buttons (`TAF:119-190`); requests the data on open (`decompiled/m5/scripts/theseusgodhead/TheseusgodAllFrame.as:104`) |
| `TheseusGodheadView` | grid of 25 cells | drag slates, unlock cells (`TGV:256-288`) |
| `TheseusGodheadUpgradeView` | "Elevação" | level up one slate (`TUV:221-226`) |
| `TheseusGodheadStarUpView` | "Promoção", "Nível de estrelas atual:", "Próximo nível de estrelas:", "Consumo: {0}" | star up using a copy (`TSV:360-406`) |
| `TheseusGodheadTaskView` / `TheseusGodheadTaskItem` | "Missão de placa divina" | tasks with "Resgatar" (`TTI:100-125`) |
| `GodItemSellView` | "Desmonte de placa divina" | decompose list ("Nome", "Nível", "Deletar"), total dust (`GISV:79-190`, `GISV:245-280`) |
| `theseusgodhead.TheseusGodheadFrame` (open type 11) | `theseus.yi.frameTitle` | summary view |

## 3. Routes (client to server)

All routes: C>S 9762 (0x2622, not listed in `protocol/opcodes.csv`; name assumed `C_SLATE_OP`), message `player.PlayerOpMsg`: `op` (#1, INT32), `type` (#2), `payType` (#3), `count` (#4), `id` (#5, INT32), `index` (#6), `userId` (#7), `templateId` (#8), `campaignId` (#9), `nodeId` (#10), `chapterId` (#11), `uuid` (#12, STRING), `value1` (#13), `value2` (#14), `param1` (#15, STRING), `param2` (#16, STRING), `flag1` (#17, BOOL), `flag2` (#18, BOOL), `pos` (#19, INT32), `ids` (#20, INT32, repeated). Only the fields listed per op are set. Response: 1024 with `opType` = op.

| Op | Action | Sender | Fields | Client checks |
|---:|---|---|---|---|
| 1 | load all data | `TSM.requestSlateData` (`TSM:1034-1040`), on frame open | | |
| 2 | unlock grid cell | `TSM.unlockPos` (`TSM:1042-1049`) from `TGV.__gridMouseDown` (`TGV:256-288`) | `pos` cell 0..24 | cell locked; confirm "Deseja consumir chave de Teseus x1 para desbloquear a placa?" |
| 3 | level up | `TSM.upgradeSlate` (`TSM:1051-1058`) from `TUV:224-226` | `id` slate | level < `star * 10 + 10` (`TGSI.updateMaxLevel`); material shown from `SlateUpgradeTmpls` |
| 4 | star up (promotion) | `TSM.starUpSlate` (`TSM:1060-1068`) from `TSV:383-406` | `id` slate, `pos` = id of the copy slate consumed | materials from `ComposeTempInfos` Types 370 (`TGSI.getStarUpMaterials`, `TGSI:197-237`); enough copies in the bag else "Material insuficiente para a promoção"; level requirement "Promoção disponível após Nv.{0}" |
| 5 | decompose | `TSM.resolveSlate` (`TSM:1070-1077`) from `GISV:174-190` | `ids` slate ids | not locked ("Placas bloqueadas não podem ser decompostas", `TAF:352-358`); confirm "Deseja decompor {0} placa(s) divina(s)? Pode receber {1} poeira de placa após decomposição." |
| 6 | rotate | `TSM.rotateSlate` (`TSM:1079-1086`) from `TheseusBagCellDropMediator:30` | `id` | rotate mode |
| 7 | lock / unlock | `TSM.lockSlate` (`TSM:1088-1095`) from `TheseusGodheadBagHelper:82` | `id` | second password flow ([../account/item-lock.md](../account/item-lock.md)) |
| 8 | claim mission reward | `TSM.getMissionReward` (`TSM:1097-1104`) from `TTI:113-123` | `id` = task template id | task state 1 (completed) |
| 9 | move slate (bag position) | `TSM.moveSlatePos` (`TSM:1106-1114`), no caller in this build | `id`, `pos` | |
| 10 | place on grid / move on grid | `TSM.movegirdSlatePos` (`TSM:1116-1124`) from `TheseusBagCellDropMediator:69`, `TheseussoulEquipCellDropMediator:64` | `id`, `pos` grid cell (anchor adjusted by shape and rotation, `TGM.getPosByShapeandRotate`, `TGM:284-326`) | cells free and unlocked |
| 11 | remove from grid to bag | `TSM.movebagSlatePos` (`TSM:1126-1134`) from `TheseussoulEquipCellDropMediator:51`, `:73` | `id`, `pos` = current equip position | |

## 4. Server messages (server to client)

### S1. 1024 (0x0400) `U_C_SLATE_USER_DATA`

- Message `slate.UserSlateMsg`: `opType` (#1, INT32) echo of the op; `posMark` (#2, INT32) locked cell bitmask; `tasks` (#3, MESSAGE `SlateTaskMsg`, repeated); `property` (#4, MESSAGE `SlatePropertyMsg`) total bonus; `slates` (#5, MESSAGE `SlateMsg`, repeated) changed or all slates.
- `slate.SlateMsg`: `id` (#1, INT32); `templateId` (#2, INT32) slate template (star = `templateId % 10`); `pos` (#3, INT32) bag position, -1 = removed; `grade` (#4, INT32) level; `star` (#5, INT32); `rotate` (#6, INT32) 0..3; `equipPos` (#7, INT32) grid anchor 0..24, -1 = not on grid; `isLock` (#8, BOOL); `isExist` (#9, BOOL); `count` (#10, INT32).
- `slate.SlateTaskMsg`: `templateId` (#1, INT32) `SlateTaskTmpls.TemplateId`; `count` (#2, INT32) progress; `state` (#3, INT32) 1 completed and claimable, 2 claimed, other values in progress (assumption 0).
- `slate.SlatePropertyMsg`: `attack` (#1), `defence` (#2), `magicAttack` (#3), `magicDefence` (#4), `forceHit` (#5), `parry` (#6), `live` (#7), `penetrate` (#8), all INT32.
- Receiver `TSM.__slateInfosHandler` (`TSM:239-276`, listener `TSM:236`): `posMark` applied when present; op 1 clears the bag and reads slates and tasks; ops 2, 6, 7 update slates in place (`TSM:292-309`); ops 3, 4, 9, 10, 11 re-read the listed slates (placement, removal, `pos == -1` deletion) and the property block (`TSM:311-436`); op 5 removes the listed ids (`TSM:278-290`); op 8 updates tasks (`TSM:438-448`). Then `EVENT_SLATE_UPDATE`.
- When: answer to each op; push when tasks progress (assumption).

### S2. 115 and 3

Dust (30000000), keys (30000001) and slate items are ordinary items: consumption and gains are pushed with 115 ([item-instance.md](item-instance.md)); gold costs with 109.

## 5. Rules and formulas

- Grid: 25 cells; `isGridUnlocked(n) = ((posMark >> n) & 1) != 1` (`TGM:74-81`). Unlock cost: 1 "Chave de Teseus" (30000001) per cell.
- Shapes and rotation: `SlateShape` 1..7; rotation 0..3; anchor adjustment: shape 1 subtract 1 when rotation 0 or 2 else 5; shape 2 subtract 1 when rotation 1 or 3 else 5; shapes 3 and 5 subtract 1 when rotation 1 or 3 else 5; shapes 4, 6, 7 no adjustment (`TGM:284-326`). The server must validate that every covered cell is unlocked and free.
- Attributes: `SlateAttr` and `SlateLvAttr` = `type,value|...` with type 1 Attack, 2 Defence, 3 MagicAttack, 4 MagicDefence, 5 ForceHit, 6 Penetrate, 7 Parry, 8 Live (`TGM:485-531`); total = base + level x per level (assumption); server sends the total in `SlatePropertyMsg`.
- Level cap: `star * 10 + 10` (`TGSI:192-195`); level up cost from `SlateUpgradeTmpls` row (`EquipProfile` = slate quality, `Type` = slate type, `EquipLv` = target level): `Consume` (gold, assumption) and `Item = 30000000,N` dust; 360 rows, levels 1..60.
- Star up: `ComposeTempInfos` Types 370: `Material1` = slate template, `Material2` / `Count2` = copies needed, `Material3` / `Count3` = dust, `NewMaterial` = next star template, `NeedMinLevel` = slate level required (for example 3701000: 1000 + one copy of 1000 + 4 500 dust at level 10 -> 1001).
- Decompose reward: `SlateDecomposition = 30000000,N` dust plus, for each level 1..L, `int(upgradeItemCount(quality, level, type) * 0.9)` (`GISV:245-280`). Locked slates cannot be decomposed.
- Missions: `SlateTaskTmpls` (16 rows, `TaskType` 1 "Fortalecer N placas de 4 slots até o Nv.X": `Part1` level, `Part2` count, `Part3` slot count), reward `TaskReward = 30000001,1` (one key).

## 6. Templates

| File | Record | Fields |
|---|---|---|
| `raw/xml/tempinfos/SlateTmpls.xml` | `SlateTmpl` (144) | `TemplateId`, `SlateName`, `SlateProfile`, `SlateStarLevel` 0..5, `SlateType` 1..4, `SlateIcon`, `SlateAttr`, `SlateLvAttr`, `SlateSkillTemplate`, `SlateShape` 1..7, `SlateDecomposition` |
| `raw/xml/tempinfos/SlateUpgradeTmpls.xml` | `SlateUpgradeTmpl` (360) | `TemplateId`, `EquipProfile`, `Type`, `EquipLv`, `Consume`, `Item` |
| `raw/xml/tempinfos/SlateTaskTmpls.xml` | `SlateTaskTmpl` (16) | `TemplateId`, `TaskDescription`, `TaskType`, `Part1..3`, `TaskReward` |
| `raw/xml/tempinfos/ComposeTempInfos.xml` | Types 370 | star up recipes |
| `raw/xml/tempinfos/ItemTempInfos.xml` | 30000000 "Poeira de placa", 30000001 "Chave de Teseus" (SonType 1100), 30010000.. slates (MasterType 15) | |

Loaded by `TM:1374-1376` (`decompiled/core_module/scripts/yishi/manager/TempleteManager.as`).

## 7. Persistent state

Schema `inventory` (the slate package belongs to inventory; Theseus may reuse it).

```sql
CREATE TABLE inventory.slates (
  slate_id      BIGSERIAL   PRIMARY KEY,
  player_id     BIGINT     NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  template_id   INTEGER     NOT NULL,
  level         SMALLINT    NOT NULL DEFAULT 0 CHECK (level BETWEEN 0 AND 60),
  rotation      SMALLINT    NOT NULL DEFAULT 0 CHECK (rotation BETWEEN 0 AND 3),
  bag_position  INTEGER,
  grid_anchor   SMALLINT    CHECK (grid_anchor BETWEEN 0 AND 24),
  is_locked     BOOLEAN     NOT NULL DEFAULT false,
  created_at    TIMESTAMPTZ NOT NULL DEFAULT now(),
  CHECK ((bag_position IS NULL) <> (grid_anchor IS NULL))
);
CREATE INDEX slates_player_idx ON inventory.slates (player_id);

CREATE TABLE inventory.slate_grid (
  player_id       BIGINT PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
  locked_mask     INTEGER NOT NULL DEFAULT 33554431 CHECK (locked_mask BETWEEN 0 AND 33554431)
);

CREATE TABLE inventory.slate_tasks (
  player_id     BIGINT  NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  task_id       INTEGER  NOT NULL,
  progress      INTEGER  NOT NULL DEFAULT 0,
  state         SMALLINT NOT NULL DEFAULT 0 CHECK (state IN (0,1,2)),
  PRIMARY KEY (player_id, task_id)
);
```

Assumption: initial `locked_mask` (all 25 bits set) and the number of free cells at start are not visible in the client.

## 8. Backend implementation notes

- `inventory::slate::handle_op` (9762) dispatch by `op`: 1 `load`, 2 `unlock_cell` (key -> clear bit), 3 `level_up`, 4 `star_up` (consume copy and dust, replace template with `NewMaterial`), 5 `decompose` (delete, credit dust), 6 `rotate` (only off grid, assumption), 7 `toggle_lock`, 8 `claim_task`, 9 `move_in_bag`, 10 `place_on_grid` (validate shape cells), 11 `remove_from_grid`.
- Each op runs in one transaction, then pushes 1024 (with `posMark`, changed slates, recomputed `SlatePropertyMsg`) and 115 / 109 for consumed or gained items.
- Recompute hero attributes after grid changes (hero feature).
- Task progress hooks after level up.

## 9. Open questions and assumptions

- Opcode 9762 name is missing from `protocol/opcodes.csv`.
- Mapping between slate template ids (1000..) and item templates (30010000..); whether slates also exist as `inventory.items` rows while in the bag.
- `Consume` unit in `SlateUpgradeTmpls` (gold assumed).
- Initial unlocked cells and the source of new slates (drops of the Theseus challenge, [thess-box.md](thess-box.md), assumption).

## 10. Implementation checklist

- [ ] Route 9762 ops 1..11
- [ ] Push 1024 with slates, tasks, property, posMark
- [ ] Shape and rotation placement validation
- [ ] Level, star up and decompose formulas
- [ ] Tables `inventory.slates`, `inventory.slate_grid`, `inventory.slate_tasks`
- [ ] Tests: unlock with and without key, overlapping placement refused, decompose locked refused
