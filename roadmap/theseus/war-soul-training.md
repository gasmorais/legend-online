# Theseus: Fort. do Espírito (war soul upgrades)

Module `war-soul-training`. The upgrade frame "Fort. do Espírito" for war souls: strengthen (op 12), star promotion (op 11), reform (op 13), refine (ops 15, 16, 17, hidden), trigger skill learning (ops 14, 20, hidden) and decomposition (op 18). War soul data, equip and hatching are in [war-soul.md](war-soul.md).

Path aliases:

| Alias | File |
|---|---|
| MGR | `decompiled/core_module/scripts/managers/TheseussoulManager.as` |
| WSM | `decompiled/core_module/scripts/mvc/module/theseus/WarSoulModel.as` |
| W | `decompiled/m5/scripts/theseus/war` |
| T | `decompiled/m5/scripts/theseus` |
| CM | `decompiled/core_module/scripts` |

---

## 1. Overview

- The frame lists every war soul of a type (equipped ones included, `WSM:114-133` with `param2 = true`) and the materials of the active tab. The player places one soul in the tab's source slot (double click or drag; equipped souls are allowed except for decomposition).
- Tabs (`T/TheseuswarIntensifyFrame.as:98-139`): "qh" strengthen, "sx" star promotion, "gz" reform, "xl" refine (only if `VersionSwitch.WARSOUL_XL`, false), "jn" skill (only if `VersionSwitch.WARSOUL_JN`, false), "fj" decomposition. In this build players see 4 tabs.
- Growth limits are driven by the star row: `MaxGrade` (strengthen cap), `MaxReform` (reform cap), `MaxClear` (refine lines).
- All routes: 8680 (0x21e8) `C_THESEUS_CLIENT_OP`, `player.PlayerOpMsg` via `TheseussoulManager.doWarsoulParam(op, index=-1, id=0, type=-1, ids=null)` (`MGR:995-1008`): `op` (#1, INT32), `index` (#6, INT32), `id` (#5, INT32), `type` (#2, INT32, -1), `ids` (#20, INT32, repeated, unpacked).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `T/TheseuswarIntensifyFrame.as` | "Fort. do Espírito" (`theseus.war.intensifyTitle`, `:81`) | Frame 760x536, tabs, shared bag, "Dividir" button ([war-soul.md](war-soul.md) R4) | War tab upgrade button, controller openType 5 with `backTheseFrame` (`W/view/TheseusWarEquipPageView.as:103-107`) | |
| `W/TheseusWarInSBag.as` | 3 type tabs; material title per tab | Souls (`TheseusWarsoulBagView(6,11,1)`, `:102-108`) and materials (`:431-471`): qh SonType 762 `Property7 1` ("Material de Fortalecimento"); gz 762 `Property7` 3 or 4 ("Material de Reforma"); xl 762 `Property7 2` ("Material de Polimento"); jn SonType 763 "Livro" (filtered by the selected soul `Rank`, `:236-264`); sx template 7620150 ("Material de Promoção"); fj 762 `Property7 1` + 7620150 + eggs 760 ("Material de Decomposição Obtido") | frame | |
| `W/view/TheseusWarIntenPageView.as` | tab qh | source, material, preview "Prévia", button; max banner "Limite de fortalecimento atingido" + "(Aumentar Estrelas do Espírito de Guerra aumenta o limite)" | tab | name "+strengthen" (`:128-180`) |
| `W/view/TheseusWarStarPageView.as` | tab sx | source, current and target stars, prev/next buttons to choose the target star, up to 5 material cells "Material da Promoção Consumido:", button; max "O nível de estrelas da qualidade atual atingiu o máximo" | tab | `:188-351` |
| `W/view/TheseusWarGZpageView.as` | tab gz | source, current and next reform name (`theseus.war.gzN`), "Termos da Intenção de Guerra {0}", "Nível Máx. dos Termos {0}", material, stone chooser, rates "Sucesso:{0}% Inalterado: {1}% Falha: {2}%", button; max "A Reforma atingiu o limite" | tab | `:242-336` |
| `W/TheseuswarGZMFrame.as` | "Adições" (`theseus.war.gzAddT`) | Choose how many reform stones to add (+/- and input) | stone chooser click, controller openType 6 with `[soul, lastCount]` (`W/view/TheseusWarGZpageView.as:176-182`) | stone name, live rates (`:106-234`) |
| `W/view/TheseusWarRefPageView.as` | tab xl (hidden) | 5 refine lines "Atributo original" / "Novo atributo", lock toggles, diamond cost, buttons refine and replace | tab | `:63-337` |
| `W/view/TheseusWarSKPageView.as` | tab jn (hidden) | source, book slot (hidden bag 0 pos 0), "Habilidade original" / "Habilidade nova", learn and "Substituir por habilidade nova" | tab | `:52-330` |
| `W/view/TheseusWarFenJiePageView.as` | tab fj | 12 decomposition slots, returned materials preview, button | tab | `:131-240` |
| `W/TheseusWarStarChooseFrame.as` | "Seleção de Materiais" | Pick souls as star materials | controller openType 7: **never opened** in this build | |

## 3. Routes (client to server)

Putting a soul in a slot is client only (`objectId = 1` marks it, `W/mediator/TheseusInsfBagCellClickMediator.as:80-108`, `W/mediator/TheseusInsfBagCellDropMediator.as:111-146`).

### R1. Strengthen (+1)

- UI: button `_info1QhBtn` (`W/view/TheseusWarIntenPageView.as:111-117`).
- Client checks (`:128-180`): disabled when `star.MaxGrade <= strengthen`; enabled when the material cell is satisfied (row(strengthen).`NeedItem`).
- Request: `op` 12, `index` -1, `id` = uid, `type` -1.
- Response: 4307 op 12 (soul with `strengthen + 1`; a stack is split first *(assumption)*), inventory update for 7620100, 4300 if equipped.

### R2. Star promotion

- UI: choose the target star with prev/next (`W/view/TheseusWarStarPageView.as:144-152, 232-255`), button `_star2Btn` (`:377-383`).
- Client checks: target in `star+1 .. MaxStar`; materials = sum of `NeedWarSoul` of rows `star .. target-1`, all owned (`:281-351`).
- Request: `op` 11, `index` = target star, `id` = uid, `type` -1.
- Response: 4307 op 11 (soul with the new star), inventory update for 7620150, 4300 if equipped.

### R3. Reform

- UI: optional stone count in `TheseuswarGZMFrame` (confirm sends the local event `Event.GzCountPrecent`, `W/TheseuswarGZMFrame.as:230-234`), then button `_gz4Btn` (`W/view/TheseusWarGZpageView.as:204-231`).
- Client checks:
  - material row(reform).`NeedItem` owned (`:297-302`);
  - at the cap (`star.MaxReform <= reform`): confirm "O nível de Reforma atual atingiu o limite. Continuar a Reforma?" (`theseus.war.gzToadyTip2`), the request is still sent;
  - fail rate > 0 after stones: confirm "A taxa de falha da Reforma atual é de {0}%. Continuar? (A adição de Pedras de Reforma reduz a taxa de falha)" (`theseus.war.gzToadyTip`);
  - both confirmations can be muted by `SharedManagerHelper`.
- Request: `op` 13, `index` = number of reform stones (0..ceil(Fail/5), capped by owned), `id` = uid, `type` -1.
- Response: 4307 op 13 (new `reform`, new `reformBuff`), inventory update (NeedItem and stones), 4300 if equipped.

### R4. Refine (hidden tab)

- R4a, view current preview: placing a soul sends `op` 16, `id` = uid (`W/view/TheseusWarRefPageView.as:212-220`). Response 4310 with the pending preview (zeros when none).
- R4b, refine: button `_ref3Btn` (`:305-329`), enabled when `star.MaxClear > 0` (`:270`); request `op` 15, `id` = uid, `ids` = 5 lock flags (1 locked, 0 free) in line order. Cost: `WarSoulTmpl.ClearItem` ("7620200,n" "Pedra de Purificação da Guerra") + locked lines x `warsoul_lock_point` (50) diamonds (`:156-173`). Response 4310 with 5 new skill ids (locked lines keep their skill) and inventory/currency updates.
- R4c, replace: button `_replaceBtn` (`:331-337`), enabled when the preview has any skill; request `op` 17, `id` = uid. Response 4307 op 17 with the new `ramdomSkills` (`:175-199`).

### R5. Learn a trigger skill (hidden tab)

- UI: double click or drag a skill book (SonType 763) to the book slot: 5005 move to hidden bag 0 pos 0 (`W/mediator/TheseusMetrialBagCellClickMediator.as:30-55`, `W/mediator/TheseusMetrialBagCellDropMediator.as:63`); checks "Selecione o Espírito da Guerra para aprender habilidade" (no soul) and "Selecione o Espírito da Guerra da mesma posição" (book `Property2 != Rank`).
- R5a, learn: button `_sk5Btn` (`W/view/TheseusWarSKPageView.as:277-283`): `op` 14, `id` = uid. Response 4307 op 14: `learnSkill` set when empty, otherwise `newLearnSkill` holds the candidate; book consumed from bag 0.
- R5b, replace: `_newBtn` (`:120-123`): `op` 20, `id` = uid; response 4307 op 20 with `learnSkill = newLearnSkill`, `newLearnSkill = 0`.
- Closing the tab moves bag 0 items back to bag 1 (`:296-303`).

### R6. Decompose

- UI: add up to 12 souls (`W/view/TheseusWarFenJiePageView.as:242-270`); button `_fjBtn` (`:272-275`).
- Client checks: not equipped "Não pode Decompor Espíritos da guerra equipados!", not locked "Não é possível decompor espírito da guerra bloqueado", slots < 12 "Sem slot de decomposição vazio" (`W/mediator/TheseusInsfBagCellClickMediator.as:83-99`, drop `:127-146`).
- Request: `op` 18, `index` -1, `id` 0, `type` -1, `ids` = uids (each whole stack is decomposed, preview multiplies by `num`, `:131-217`).
- Response: 4307 op 18 with the souls `isExist` false, inventory updates for returned materials.

## 4. Server messages (server to client)

### S1. 4307 (0x10d3) `U_C_WARSOUL_UPDATE` (and 4306)

- `theseus.WarSoulListMsg` with `op` = request op, `warSouls`, `fightIdx` (always): full field list in [war-soul.md](war-soul.md) S1. Receiver `MGR.__warsoulInfosHandler` (`MGR:746-784`). Page reactions: strengthen refreshes on op 12 (`W/view/TheseusWarIntenPageView.as:102-109`), star on 11 (`W/view/TheseusWarStarPageView.as:154-161`), reform on 13 (`W/view/TheseusWarGZpageView.as:167-174`), refine on 17 (`W/view/TheseusWarRefPageView.as:175-199`), skill on 14 and 20 (`W/view/TheseusWarSKPageView.as:132-139`), decompose on any op (clears slots, `W/view/TheseusWarFenJiePageView.as:111-119`).

### S2. 4310 (0x10d6) `U_C_WARSOUL_REFRESH`

- Message `theseus.WarSoulRefreshMsg`:
  - `opType` (#1, INT32): 15 or 16 *(assumption: echo)*, unused by the client.
  - `id` (#2, INT32): war soul uid.
  - `skills` (#3, INT32, repeated): 5 preview skill ids (0 = empty).
- Receiver: `MGR.__refineInfosHandler` (`MGR:734-744`) stores `WSM.refineInfo`, dispatches `EVENT_WAR_REFINE`; `TheseusWarRefPageView.updatePreViewHandler` shows them when `id` matches and enables replace if any > 0 (`:273-303`).
- When: response to R4a and R4b.

### S3. Errors

- None in the protocol; failures send nothing *(assumption)*. Reform "fail" and "unchanged" are normal results carried by 4307.

## 5. Rules and formulas

- Rows: star `WarSoulStarTmpls(warSoulId, Grades = star)`, strengthen `WarSoulStrengthenTmpls(warSoulId, Grades = strengthen)`, reform `WarSoulReformTmpls(warSoulId, Grades = reform)` (`CM/mvc/module/theseus/TheseusWarsoulItemInfo.as:97-165`).
- Strengthen: cost L to L+1 = strengthen row(L).`NeedItem` ("7620100,n", "Pedra de Fort. da Guerra", e.g. 1, 3, ..., 883 at level 200); cap `star.MaxGrade` (10 at star 0 up to 300 at star 20); `OpenActiveSkill` / `OpenPassiveSkill` of the row change at some levels (e.g. 76001101 then 76001102 at 100, 76001105 at 199); `DecompositionReturn` = cumulative stones refunded.
- Star: target `T <= WarSoulTmpl.MaxStar`; cost = sum over g in [star, T-1] of star row(g).`NeedWarSoul` ("7620150,n", "Antique de Espírito da Guerra"); each star raises `MaxGrade`, `MaxReform`, `MaxClear` and the attribute percentage (`Attack` 100 at star 0, 110, 121, ...). Star rows also carry `Decompose` (returned eggs on decompose).
- Reform (help text item 4): outcomes Success +1, Unchanged 0, Failure -1.
  - Base rates from row(reform): `SuccessProbability`, `UnchangedProbability`, `FailProbability` (sum 100; e.g. grade 2: 4 / 66 / 30).
  - With `n` stones of row(reform).`NeedStone` (7620301..7620303, `Property2` = 5 points each): unchanged = min(100, Unchanged + 5n), fail = max(0, Fail - 5n), success unchanged (`W/view/TheseusWarGZpageView.as:264-296`, `W/TheseuswarGZMFrame.as:170-210`). Client max `n = ceil(Fail / 5)`.
  - Cost: row(reform).`NeedItem` ("7620401,10" ... "7620405,120", "Alma da Reforma ..."), plus the `n` stones.
  - Cap: `reform < star.MaxReform` and row(reform+1) exists; at the cap the client still sends (assumption: the server re-rolls the bonuses without changing the grade, or rejects; see §9).
  - Bonuses: grade G gives `MaxWarpath` war intent entries ("Termos", 2 per grade) with levels in [`MinRageGrades`, `MaxRageGrades`] at random positions 1..12, stored as `reformBuff` "pos,level|..." *(assumption: re-rolled on every reform)*; grade attributes are the row's flat `Attack`..`Live`.
- Refine: lines available = `star.MaxClear` (0..5; config `warsoul_clearopen_tips` "6,11,12,14,17" is the tip of the star needed per line); skills drawn from the family `WarSoulTmpl.ClearSkill` *(assumption)*; lock cost 50 diamonds per locked line (`warsoul_lock_point`).
- Skill learning: one trigger skill; new books produce a candidate that must be confirmed (op 20) (help `theseus.war.skUpTip`). Book data (`Property1`, `Property2`, `Property7`) is inconsistent in `ItemTempInfos.xml` (some books have no `Property2`), irrelevant while the tab is hidden.
- Decompose return per unit (`W/view/TheseusWarFenJiePageView.as:151-217`): `WarSoulTmpl.Decompose` ("7620100,1") + strengthen item x `DecompositionReturn` + star row `Decompose` (eggs, e.g. "7601600,5|7601500,2"), all multiplied by the stack count. Maximum 12 entries per request.
- Locked or equipped souls cannot be decomposed; locked souls may still be upgraded.

## 6. Templates

| File | Record | Fields |
|---|---|---|
| `raw/xml/tempinfos/WarSoulStarTmpls.xml` (729) | star grade | `Id`, `WarSoulId`, `Grades` 0..20, `MaxClear`, `MaxGrade`, `MaxReform`, `NeedWarSoul`, `Attack`..`Live` (percent), `Decompose` |
| `raw/xml/tempinfos/WarSoulStrengthenTmpls.xml` (10179) | strengthen level | `Id`, `WarSoulId`, `Grades` 0..300, `OpenActiveSkill`, `OpenPassiveSkill`, `NeedItem`, `SkillStrengthening`, `DecompositionReturn`, `Attack`..`Live` |
| `raw/xml/tempinfos/WarSoulReformTmpls.xml` (378) | reform grade | `Id`, `WarSoulId`, `Grades` 0..6, `MaxWarpath`, `NeedItem`, `NeedStone`, `MaxRageGrades`, `MinRageGrades`, `FailProbability`, `UnchangedProbability`, `SuccessProbability`, `Attack`..`Live` |
| `raw/xml/tempinfos/WarSoulTmpls.xml` | soul | `ClearSkill`, `ClearItem`, `Decompose`, `MaxStar`, `Rank` |
| `raw/xml/tempinfos/TheseusRageTemplates.xml` `MasterType 2` | war intent bonus attributes | see [war-intent.md](war-intent.md) |
| `raw/xml/tempinfos/ItemTempInfos.xml` | materials SonType 762 (7620100, 7620150, 7620200, 7620301..303, 7620401..405), books 763 | `Property2` stone points, `Property7` tab filter |
| `raw/xml/tempinfos/ConfigInfos.xml` | `warsoul_lock_point` 50, `warsoul_clearopen_tips` | |

## 7. Persistent state

Uses `theseus.war_souls` (star, strengthen, reform, skills, refine skills) and `theseus.war_soul_reform_buffs` ([war-soul.md](war-soul.md) §7), plus:

```sql
CREATE TABLE theseus.war_soul_refine_previews (
    war_soul_uid  integer PRIMARY KEY REFERENCES theseus.war_souls(war_soul_uid) ON DELETE CASCADE,
    skill_ids     integer[] NOT NULL CHECK (cardinality(skill_ids) = 5),
    created_at    timestamptz NOT NULL DEFAULT now()
);
```

## 8. Backend implementation notes

Common validation for every op: soul exists, owned, `isExist`; when the soul is a stack (`quantity > 1`) split one unit into a new row before modifying it *(assumption)*; one transaction per request; push 4307 with the request op and current `fightIdx`, inventory/currency updates, and 4300 when the soul is equipped.

- `theseus::war_soul_training::handle_strengthen` (op 12): `strengthen < star.MaxGrade`; consume row(L).`NeedItem` from bag 1/34; `strengthen + 1`.
- `theseus::war_soul_training::handle_star_up` (op 11): `star < index <= MaxStar`; consume the summed `NeedWarSoul`; `star = index`.
- `theseus::war_soul_training::handle_reform` (op 13): `index` in 0..owned stones and `<= ceil(Fail/5)`; consume `NeedItem` and stones; roll with adjusted rates; apply +1 / 0 / -1 (never below 0, never above `MaxReform`); regenerate `war_soul_reform_buffs` for the resulting grade (`MaxWarpath` rows, levels in [Min, Max]) *(assumption)*.
- `theseus::war_soul_training::handle_refine_view` (op 16): read `war_soul_refine_previews`; push 4310 (zeros if none).
- `theseus::war_soul_training::handle_refine` (op 15): `star.MaxClear > 0`; `ids` has 5 flags; consume `ClearItem` and 50 diamonds per locked line; generate skills for the `MaxClear` open lines (locked lines copy the current skill); upsert preview; push 4310.
- `theseus::war_soul_training::handle_refine_replace` (op 17): preview exists; copy into `refine_skill_ids`; delete preview; push 4307 op 17.
- `theseus::war_soul_training::handle_learn_skill` (op 14): book in bag 0 pos 0 (SonType 763, rank rule); consume it; roll a skill; set learned or pending; push 4307 op 14.
- `theseus::war_soul_training::handle_replace_skill` (op 20): pending skill exists; promote; push 4307 op 20.
- `theseus::war_soul_training::handle_decompose` (op 18): `ids` 1..12 distinct, unequipped, unlocked; delete rows; grant returns; push 4307 op 18 (`isExist` false).
- The hidden tabs (ops 14..17, 20) must still be validated because the opcodes are reachable by a crafted client.
- No timers, no battles.

## 9. Open questions and assumptions

1. Reform at the cap: the client sends op 13 after a warning; the server behavior (re-roll bonuses or reject) is unknown. Recommended: allow and re-roll bonuses, keeping the grade.
2. Generation rules of `reformBuff` (distinct positions or not, re-roll on unchanged/fail) are not in the client.
3. Refine skill pools (`ClearSkill` families) and probabilities are not in the client; tab hidden.
4. Skill book semantics (`Property1` chance, `Property7` skill id, rank match) are inconsistent in data; tab hidden.
5. Whether upgrading one unit of a stack splits it is inferred from the stack model.
6. `TheseusWarStarChooseFrame` (souls as star material) is dead code: star promotion consumes only item 7620150.

## 10. Implementation checklist

- [ ] Screen `TheseuswarIntensifyFrame` with qh, sx, gz, fj tabs (xl, jn behind switches).
- [ ] Screen `TheseuswarGZMFrame` stone chooser.
- [ ] Route op 12 strengthen with star cap.
- [ ] Route op 11 star promotion with summed costs.
- [ ] Route op 13 reform with stone-adjusted rates and bonus regeneration.
- [ ] Routes op 16, 15, 17 refine (validated even if hidden).
- [ ] Routes op 14, 20 skill learning (validated even if hidden).
- [ ] Route op 18 decompose with returns.
- [ ] Server messages 4307 per op and 4310 refine preview.
- [ ] Table `theseus.war_soul_refine_previews`.
- [ ] Test: strengthen at `MaxGrade` is rejected; star up raises the cap.
- [ ] Test: reform with enough stones has 0% failure.
- [ ] Test: decomposing an equipped or locked soul is rejected; 13 ids are rejected.
