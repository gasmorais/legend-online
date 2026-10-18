# Espírito da Vingança / Corpo do Julgamento (avenger body)

Module `body` of the feature [Vingador](README.md). Path conventions are in the README.

## 1. Overview

The body tab (tab index 1 of `AvengerFrame`) raises the avenger body grade from 0 to 220 by feeding "Cristal da Vingança" (item 5010001). Each grade gives flat physical attack, physical defense, magic defense and HP from `AvengerBodyTemplates.xml`. Grades are grouped in 21 "degrees" (`BodyType` 0..20) of 11 grades; the degree is shown as stars (grade mod 11), sets the avatar aura (`avengerDegree`) and gates skill evolution ([skills.md](skills.md)).

pt-BR naming in the client is inconsistent: the view tip says "O nível do Espírito de Vingança afeta o aumento da habilidade do Corpo do Julgamento" (`AvengerBodyView.alertText.text`), the evolve frame says "Corpo do Julgamento" for the degree and "Espírito da Vingança" in the error. The task constant for this tab is `REVENGE_SOUL_TASK` (246).

## 2. Screens

| Class (file) | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `avenger.view.AvengerBodyView` (`M5/avenger/view/AvengerBodyView.as`) | tab of "Vingador" (icon) | Feed crystals | Tab 1 of `AvengerFrame`; task 246 (`CM/yishi/SwitchPageHelp.as:2889-2899`) | Degree number = `tempInfo.BodyType` (:199); current totals attack/defense/magic defense/HP = current row `PhyAttack, PhyDefence, MagDefence, Health` (`CM/mvc/module/avenger/AvengerModel.as:86-93`, view :200-204); crystal tooltip and "(Quantidade atual: {0})" with the bag count of 5010001 in bag + stone bag (:205-208); current and next row props "Ataque:{0}", "Defesa:{0}", "Resistência:{0}", "Vida:{0}" (`AvengerBodyPropItem`, :209-210); exp bar `exp / tempInfo.NeedItemNum` or max (:211-222); stars = `grade % 11` of 10 (:113-116, 223-224); button icon "evolve" when `(grade+1) % 11 == 0`, else "upgrade" (:225-234); aura `core.avengerEffectzs<min(10, ceil(degree/2))>` (:235-251); hero avatar |

The amount input (`_inputText`, default "1") is clamped to 1..min(owned, 9999) on change (:161-173).

## 3. Routes (client to server)

### B1. Feed crystals (op 4, UPGRADE_BODY)

| Item | Value |
|---|---|
| UI control | Upgrade/evolve button of the body tab |
| Client sender | `AvengerBodyView._upgradeBtnClickHandler` (`M5/avenger/view/AvengerBodyView.as:175-189`) -> `AvengerManager.sendAvengerBodyRequest(count)` (`CM/yishi/manager/AvengerManager.as:212-219`) |
| Client checks, in order | 1. owned crystals (`GoodsManager.getBagCountInPlayerAndStoneByTempId(NeedItem)`) `>= count` and `count > 0`, else "Materiais necessários insuficentes, não é possível efetuar operação." (`PetHallowsRightSkillView.train.noGoodsAlert`); 2. a next grade row exists, else "Nível máximo atingido" (`map.campaign.view.ui.secretland.ConsortiaTreeExpView.maxLevel`) |
| Route | client to server, **8657 (0x21d1) C_AVENGER_CLIENT_OP** |
| Request | `PlayerOpMsg`: `op (#1, INT32) = 4`; `count (#4, INT32)` = crystals to consume, 1..9999 |
| Expected response | 1. bag update of item 5010001 (inventory feature); 2. **4588** `AvengerMsg{opType=4, grade, exp}`; 3. when the grade changed: **150** U_C_SERIAL_ARMY with `ArmyMsg.avenger_grade (#43)` and the hero stats refresh *(assumption, see [core.md](core.md) §4 S2)* |

## 4. Server messages (server to client)

| Opcode | Message | Fields used here | Client receiver | When | Client effect |
|---|---|---|---|---|---|
| 4588 (0x11ec) U_C_AVENGER_DATA | `avenger.AvengerMsg` (full spec in [core.md](core.md) §4) | `opType (#1) = 4`, `grade (#2, INT32)` body grade, `exp (#3, INT32)` exp inside the grade | `AvengerManager.__avengerMsgUpdateHandler` (`CM/yishi/manager/AvengerManager.as:77-84, 139-142`) | Response to op 4 | `BODY_INFO_UPDATE` -> `AvengerBodyView.refreshView`; task 246 and 255-259 progress (`CM/mvc/module/task/TaskTemplate.as:318-330`) |
| 150 (0x0096) U_C_SERIAL_ARMY | `army.ArmyMsg.avenger_grade (#43)` | body grade | `ThaneInfoHelper.readHeroInfo` (`CM/com/road/pb/helper/army/ThaneInfoHelper.as:196-199`) | After a grade change *(assumption)* | `thane.avengerGrade` -> `avengerDegree`, `AVENGER_DEGREE_CHANGE` |
| bag update (inventory feature) | item 5010001 count | | `GoodsManager` | After consumption | Owned count text |

No result code: on rejection send nothing.

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Grade range | 0..220 (221 rows, Id 50000..50220) | `raw/xml/tempinfos/AvengerBodyTemplates.xml` |
| Degree | `BodyType` of the current grade: grades 0-10 -> 0, 11-21 -> 1, ..., 209-219 -> 19, 220 -> 20 | template; `CM/mvc/module/avenger/AvengerBodyInfo.as:28-35` |
| Exp needed for grade g -> g+1 | `NeedItemNum` of row g: 5 at grade 0, +5 per grade up to 250 (grade 49), then 250 per grade | template; exp bar `exp / tempInfo.NeedItemNum` (`AvengerBodyView.as:213-214`) |
| Material | `NeedItem` = 5010001 "Cristal da Vingança" for every row; 1 crystal = 1 exp *(assumption, consistent with the counts)* | template |
| Overflow | exp beyond the requirement carries into the next grades in the same request *(assumption)*; the request `count` may exceed what is needed for the max grade, and the server should consume only what is needed *(assumption)* | |
| Max | no row for grade+1 -> "max" (grade 220) | `AvengerBodyView.as:183-187, 217-222` |
| Stats of grade g | row g: `PhyAttack = PhyDefence = MagAttack = MagDefence = 800 g`, `Health = 4800 g` (e.g. g=220: 176 000 / 1 056 000). The client displays PhyAttack, PhyDefence, MagDefence, Health; `MagAttack` is not shown but exists *(assumption: also applied to the hero)* | template; `AvengerModel.avengerBodyPropAry` (:86-93) |
| Stars | `grade % 11` lit of 10 | `AvengerBodyView.as:223-224` |
| Evolve icon | when `(grade + 1) % 11 == 0` (the next grade starts a new degree) | :225-229 |
| Skill evolution gate | `AvengerSkillTemplates.NeedBodyGrade` compares with the raw body grade (33, 55, ..., 209) | `M5/avenger/AvengerSkillEvolveFrame.as:147-151` |
| Task 257 | `bodyInfo.degree >= Para2` | `TaskTemplate.as:1522-1529` |
| Task 246 | `thane.avengerDegree >= 1` | `TaskTemplate.as:1341-1348` |

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `raw/xml/tempinfos/AvengerBodyTemplates.xml` (`AvengerBodyTempCate.getTemplateByGrade`, `CM/yishi/datas/templates/cate/AvengerBodyTempCate.as:19-35`; loaded at `CM/yishi/manager/TempleteManager.as:1301`) | one body grade | `Id`, `BodyType` (degree), `BodyGrade` (key), `NeedItem` (5010001), `NeedItemNum` (exp to next grade), `PhyAttack`, `PhyDefence`, `MagAttack`, `MagDefence`, `Health` (`CM/yishi/datas/templates/AvengerBodyTempInfo.as:6-34`) |
| `raw/xml/tempinfos/ItemTempInfos.xml` | 5010001 "Cristal da Vingança" | "Cristal usado para fortalecer o corpo do Vingador, é produzido no Caminho da Vingança." MaxCount 9999 |

## 7. Persistent state

Uses `avenger.profiles.body_grade` and `avenger.profiles.body_exp` defined in [core.md](core.md) §7. No extra table.

## 8. Backend implementation notes

Handler `avenger::body::handle_feed` (8657 op 4):

1. Player is avenger (row in `avenger.profiles`), else drop.
2. `count` in 1..9999, else drop.
3. Current row exists and `grade + 1` row exists, else drop (max).
4. Player owns `count` of 5010001 in bag + stone bag (inventory API), else drop.
5. Transaction:
   - lock the profile row;
   - loop: `need = row(grade).NeedItemNum - exp`; consume up to `need` crystals; on reaching it, `grade += 1`, `exp = 0`; stop at max grade or when crystals run out;
   - consume only the crystals used;
   - update `body_grade`, `body_exp`.
6. After commit: bag update; 4588 `{opType 4, grade, exp}`; if the grade changed, recompute hero stats and push 150 (avenger_grade) and the hero attribute refresh; if the degree changed, the map/space avatar of the player should refresh for others *(assumption, via the space/room member update)*.

No timers. No battle.

## 9. Open questions and assumptions

1. *(assumption)* 1 crystal = 1 exp, and overflow carries across grades within one request.
2. *(assumption)* `MagAttack` of the template is also applied (not displayed).
3. *(assumption)* The server pushes 150 after a grade change; the client has no other path for `thane.avengerGrade`.
4. Whether the server rejects or truncates a `count` larger than needed for grade 220.

## 10. Implementation checklist

- [ ] Screen `AvengerBodyView` (degree, stars, stats, exp bar, amount input)
- [ ] Route 8657 op 4 -> `avenger::body::handle_feed`
- [ ] Server message 4588 opType 4 (grade, exp)
- [ ] Push 150 `ArmyMsg.avenger_grade` after grade change
- [ ] Rule: exp table from `AvengerBodyTemplates.NeedItemNum`, max grade 220
- [ ] Rule: body stats added to the hero attributes
- [ ] Template loader `AvengerBodyTemplates.xml`
- [ ] Columns `avenger.profiles.body_grade`, `body_exp`
- [ ] Test: feeding exactly the requirement raises one grade and resets exp
- [ ] Test: feeding across several grades in one request
- [ ] Test: feeding at grade 220 is rejected; feeding without crystals is rejected
