# Job transfer and vocation (Elevação da profissão)

Path aliases:

| Alias | File |
|---|---|
| CJC | `decompiled/core_module/scripts/mvc/controler/ChangeJobControler.as` |
| CJF | `decompiled/m5/scripts/changeJob/ChangeJobFrame.as` |
| PM | `decompiled/core_module/scripts/yishi/manager/PlayerManager.as` |
| SPI | `decompiled/core_module/scripts/yishi/datas/playerinfo/SimplePlayerInfo.as` |
| SV | `decompiled/m5/scripts/armyII/viewII/skill/SkillView.as` |
| PEV | `decompiled/core_module/scripts/ui/maintoolbar/view/PlayerExperenceView.as` |

## 1. Overview

After hero level 80, EXP feeds a vocation (profession) track. The hero record carries:
- `vocationIndex` (SPI): 0 = not transferred, 1..2 = transferred (`isChangeJob`), 3 = Avenger (`isAvenger`, SPI:1264-1267), >= 4 = Holy (`isHoly`, SPI:1269-1272);
- `vocationGrades` (profession level) and `vocationGp` (EXP in the level);
- derived `vocationStep` ("Nível 1".."Nível 10") and `vocationLevel` (+8 for index 1-2, +16 Avenger, +19 Holy, SPI:1316-1331) used for names: `PM.getVocationName(job, step, level)` (PM:2128-2160) picks the per-class name from `UpGradeTempInfos` `TemplateName` (split by `|`).

Job transfer ("Atributos de tatuagem necessário") is performed at an NPC in the Sky realm when the tattoo attribute totals reach the class requirement; it switches the skill tree to the job transfer tree (MasterType 420 + job) and the talent tree to the 7-cell tree (see [../skills/README.md](../skills/README.md)). Branch 2 is deprecated ("【废弃】"), so every transfer uses branch 1; the "branch switch" between skill sets after transfer uses the same message.

The Avenger stage (index 3) is owned by [../avenger/README.md](../avenger/README.md); this module documents only the shared vocation fields.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `changeJob.ChangeJobFrame` (CJF) | prompt "Atributos de tatuagem necessário" | Shows the class icon and the tattoo requirement list ("Força+6000", ...), confirm/cancel | NPC dialog option 104 (`decompiled/m3/scripts/map/space/view/frame/DialogOptionItem.as:678-679`) → `openControllerByInfo("changejob")` | `Job{job}_Branch1` config, tattoo totals (`tattooModel.calculateAddProperty()`) |
| `armyII.viewII.skill.HaloView` | | Halo animation of the transferred skill tree (brighten, darken, rotate) | SkillView | none (`decompiled/m5/scripts/armyII/viewII/skill/HaloView.as:35-57`) |
| `PlayerExperenceView` | | Vocation EXP bar after level 80 | toolbar | `vocationGp` vs next `Data` (PEV:154-176) |
| `InformationView` help | "Explicação do Nível da Profissão" | Vocation help | hero information tab | |

## 3. Routes (client to server)

### R1. Transfer job
- UI: confirm button (CJF:188-196).
- Client check: `checkBranchCondition(job, 1)` (CJF:198-226): for each of the 5 values in `Job{job}_Branch1` (Força, Proteção, Inteligência, Físico, Liderança) that is > 0, the tattoo total of that attribute must be >= it; else "Atributos da tatuagem não atingiu os requesitos necessários, falha ao mudar" (`changeJob.changeBranchFail`).
- Client path: `CJC.sendChooseBranch(1)` (CJC:33-39).
- Route: send 9576 (0x2568) `C_CHANGEJOB`, `ChangePlayerInfoMsg` (changejob): `branch` (#3, INT32) = 1; `grades` (#1, INT32) and `gp` (#2, INT32) unset.
- Response: 4557 (S1) with `index` > 0 (the frame closes on `VOCATION_INDEX`, CJF:168-174), 4556 (S2) broadcast, then 113 with the new skill/talent scripts, and 150/113 `tempate_id` if the hero template changes *(assumption)*.

### R2. Switch branch (skill set) after transfer
- UI: `_switchSkillBtn2` in `SkillView` (SV:630-642) → confirm "Dese alterar para {0}?" with "Conjunto de habilidades {0}" and "Não alertar mais" (SV:540-568).
- Client path: `CJC.sendChangeBranch(n)` (CJC:41-47), n = 1 or 2; the view shows a mask until `VOCATION_INDEX` or `SKILL_INDEX` arrives (SV:505-510, SV:740-750).
- Route: send 9577 (0x2569) `C_EXCHANGEJOB_BRANCH`, `ChangePlayerInfoMsg`: `branch` (#3, INT32) target branch.
- Response: 113 with `skill_index` (#44) = branch - 1 and the branch's `skill_script`, `fast_key`, `skill_point` ([../skills/hero-skills.md](../skills/hero-skills.md)).

## 4. Server messages (server to client)

### S1. 4557 (0x11cd) `U_C_TRANS_GRADE`
- `FateInfoMsg` (fate): `template_id` (#1, INT32) read but unused, `fate_types` (#2), `total_gp` (#3, INT64) vocation EXP, `grades` (#4, INT32) vocation level, `property1` (#5), `property2` (#6), `turn_count` (#7), `index` (#8, INT32) vocation index.
- Receiver: `PM.__dragonSoulTransferInfoHandler` (PM:2049-2073): updates `playerInfo` and `thane` (`vocationIndex`, `vocationGrades`, `vocationGp`); when the index changes it rebuilds the skill and talent trees and dispatches `VOCATION_INDEX`.
- When: login, every vocation EXP change, level up, transfer, Avenger/Holy promotion.

### S2. 4556 (0x11cc) `U_C_TRANSFER`
- `simple.PropertyMsg` (fields in `decompiled/core_module/scripts/com/road/yishi/proto/simple/PropertyMsg.as`; `protocol/proto.json` keys `PropertyMsg` to the army message): `param1` (#1, INT32) user id, `param2` (#2, INT32) class (`Job`), `param3` (#3, INT32) new vocation level, `param4` (#4, STRING) nickname, `param5` (#5, STRING) guild id; others unused.
- Receiver: `PM.__dragonSoulTransferHandler` (PM:1991-2043): for the own player calls `playerInfo.transfer()` and plays fireworks; posts to chat channel 3 "Parabéns {0} sucesso na elevação da profissão, tornando-se {1}!" (`yishi.manager.PlayerManager.TransferTip01`); updates the army avatar on the Sky realm map.
- When: broadcast to all online players (or the map) on each vocation step promotion.

### S3. 113 `U_C_HERO_INFO`
Trees and branch (`skill_index`), see [attributes.md](attributes.md).

## 5. Rules and formulas

- Requirements (`ConfigInfos.xml`, order Força, Proteção, Inteligência, Físico, Liderança): `Job1_Branch1` = 6000,1500,0,1500,0; `Job2_Branch1` = 7000,1000,0,1000,0; `Job3_Branch1` = 0,1500,6000,1500,0; `Job*_Branch2` rows are marked deprecated.
- Vocation EXP tables (`UpGradeTempInfos`, PEV:160-176): `Types 105` (no transfer, levels 1..80, level 1 = 99000), `110` (transferred, 1..80, level 1 = 2800000, names "Espadachim ...|Artilheiro ...|Deus Mago ..."), `152` (Avenger, 1..30, level 1 = 1205000000, "Deus espadachim vingador|Deus arqueiro vingador|Deus mago vingador"), `158` (Holy, 1..40). `TemplateName` columns may contain mis-encoded characters in the XML.
- Name lookup uses `(vocationLevel - 19) * 10` for Holy (type 158) and `(vocationLevel - 16) * 10` for Avenger (type 152) (PM:2140-2155).
- Ranking level `totalGrade` (see [attributes.md](attributes.md)).
- On transfer: skill tree reset to MasterType 420 + job with the two base skills at level 1; talent script becomes `"<Job>00199,"`; skill points recomputed (server).

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `ConfigInfos.xml` | `Job{1..3}_Branch{1,2}` | tattoo attribute requirements |
| `UpGradeTempInfos.xml` | `Types 105`, `110`, `152`, `158` | `Grades`, `Data`, `TemplateName` |
| `SkillTempInfos.xml` | MasterType 421..423, 70 | transferred skill and talent trees |

## 7. Persistent state

```sql
CREATE TABLE hero.vocation (
    player_id        BIGINT PRIMARY KEY REFERENCES hero.heroes(player_id) ON DELETE CASCADE,
    vocation_index   SMALLINT NOT NULL DEFAULT 0 CHECK (vocation_index BETWEEN 0 AND 4),
    vocation_grade   SMALLINT NOT NULL DEFAULT 0 CHECK (vocation_grade >= 0),
    vocation_exp     BIGINT   NOT NULL DEFAULT 0 CHECK (vocation_exp >= 0),
    branch           SMALLINT NOT NULL DEFAULT 0 CHECK (branch IN (0, 1, 2)),
    transferred_at   TIMESTAMPTZ
);
```

## 8. Backend implementation notes

- `hero::job_change::handle_change_job` (9576): require `vocation_index = 0`, hero level 80 *(assumption)*, `branch = 1`, tattoo totals >= config; transaction: set index 1, branch 1, reset skill/talent trees per the rules; push 4557, broadcast 4556, push 113 (and 150 if needed).
- `hero::job_change::handle_change_branch` (9577): require `vocation_index > 0`; set the active branch (maps to skill set index); push 113.
- `hero::job_change::grant_vocation_exp` (called by `hero::attributes::grant_exp` after level 80): level up the vocation track by its table; push 4557; broadcast 4556 on step changes.
- Avenger/Holy promotions are triggered by the Avenger feature and reuse 4557/4556.

## 9. Open questions and assumptions

- Assumption: transfer needs hero level 80 in addition to the tattoo requirement (only the tattoo check exists in the client).
- Assumption: index 1 vs 2 reflects the branch; the client treats both as transferred.
- Open: exact vocation index assignment on Avenger (3) and Holy (4) promotions; see [../avenger/README.md](../avenger/README.md).

## 10. Implementation checklist

- [ ] Screen: ChangeJobFrame requirement list
- [ ] Route 9576 job transfer
- [ ] Route 9577 branch switch
- [ ] Server message 4557 at login and on changes
- [ ] Server message 4556 broadcast
- [ ] Server message 113 after transfer/branch switch
- [ ] Table `hero.vocation`
- [ ] Rule: tattoo requirements per class
- [ ] Rule: vocation EXP tables 105/110/152/158
- [ ] Test: transfer resets trees and shows the transferred skill view
