# Potential (Potencialidades)

Path aliases:

| Alias | File |
|---|---|
| PRM | `decompiled/core_module/scripts/yishi/manager/ProficiencyManager.as` |
| PMOD | `decompiled/core_module/scripts/mvc/module/proficiency/ProficiencyModel.as` |
| PF | `decompiled/m5/scripts/proficiency/ProficiencyFrame.as` |
| PEF | `decompiled/m5/scripts/proficiency/ProficiencyExchangeFrame.as` |
| SPH | `decompiled/core_module/scripts/yishi/SwitchPageHelp.as` |

## 1. Overview

A hero stat track for Avenger-stage heroes: the player converts "Potencial" items into potential points, then "practices" to raise the potential grade (700 grades in layers of 7), each grade adding flat Attack, physical defence, magic defence and HP.

Disabled in the BR build: `VersionSwitch.PROFICIENCY = false` (`decompiled/core_module/scripts/yishi/datas/VersionSwitch.as:150`). The only entries check the switch and `thane.isAvenger` (SPH:2879-2887: "resourcebar.view.ChildrenFigureView.noOpen" otherwise); the keyboard handler `showProficiencyFrame` (`decompiled/core_module/scripts/yishi/keyboard/KeyBoardRegister.as:1120-1152`) has no caller. The "Potencialidades" of the DragonTalker (`dragontalker.DragonTalkerProficiencyFrame`) is a different system owned by [../dragon/README.md](../dragon/README.md).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `proficiency.ProficiencyFrame` (PF) | "Potencialidades" (`DragonTalkerProficiencyFrame.title.text`) | Current and next grade stats, layer, value "value/Exp", practice and exchange buttons; "Atingiu o nível mais alto do grau atual" at max | `SPH.openPotential` | `PMOD.proficiencyGrade`, `proficiencyValue`, templates |
| `proficiency.ProficiencyExchangeFrame` (PEF) | "Obtenção de Potencial" | Converts all owned potential items: "Gaste todo o Potencial abaixo, podendo fornecer {0} pontos de Potencial" | PF exchange button (PF:125-128) | items SonType 627 not locked |
| `proficiency.ProficiencyGradeMcView`, `item/ProficiencyPropItem` | | Ball animation and stat lines | PF | |

## 3. Routes (client to server)

All routes: send 8660 (0x21d4) `C_PROFICIENCY_CLIENT_OP`, `PlayerOpMsg` (player) with only `op` (#1, INT32) set (PRM:58-64). Other `PlayerOpMsg` fields (`type` #2, `payType` #3, `count` #4, `id` #5, `index` #6, `userId` #7, `templateId` #8, `campaignId` #9, `nodeId` #10, `chapterId` #11, `uuid` #12, `value1` #13, `value2` #14, `param1` #15, `param2` #16, `flag1` #17, `flag2` #18, `pos` #19, `ids` #20 repeated) are unused.

### R1. Query (`op 0`)
- When: PF opens (PF:61). Response: 210 (S1).

### R2. Exchange items (`op 1`)
- UI: PEF exchange button, enabled when at least one item SonType 627 is owned (PEF:80-117).
- Server: consumes all unlocked potential items; adds `count * Property1` points (6270001 "Potencial Básico" 100, 6270002 "Potencial Intermediário" 500, 6270003 "Potencial Avançado" 1000).
- Response: 210 and bag updates.

### R3. Practice (`op 2`)
- UI: PF practice button (PF:130-138). Check: `proficiencyValue >= next.Exp` else "Valor de Potencial insuficiente. Não é possível praticar." (`proficiency.practice.noValueAlert`).
- Response: 210 with grade + 1 and value - `Exp` *(assumption: the cost is subtracted)*; 113 with new stats.

## 4. Server messages (server to client)

### S1. 210 (0x00d2) `U_C_PROFICIENCY_DATA`
- `simple.PropertyMsg`: `param1` (#1, INT32) potential grade, `param2` (#2, INT32) potential points; `param3`..`param12` unused (field list in `decompiled/core_module/scripts/com/road/yishi/proto/simple/PropertyMsg.as`).
- Receiver: `PRM.__proficiencyUpdateHandler` (PRM:48-56) → `PROFICIENCY_INFO_UPDATE`.

## 5. Rules and formulas

- `ProficiencyTemplates.xml` (700 rows): grade `Grade` with `Exp` cost (grade 1 = 44, 2 = 53, 3 = 62, ...), `Layer`, cumulative `Attack`, `PhyDefence`, `MagDefence`, `Live` (grade 1 = 100/100/100/600).
- Layer boundary every 7 grades (`(grade + 1) % 7 == 0` changes the practice icon, PF:173-182).
- Only Avenger heroes (`vocationIndex >= 3`).

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `ProficiencyTemplates.xml` | potential grade | `Id`, `Grade`, `Layer`, `Exp`, `Attack`, `PhyDefence`, `MagDefence`, `Live` |
| `ItemTempInfos.xml` | SonType 627 | `Property1` points per item |

## 7. Persistent state

```sql
CREATE TABLE hero.potential (
    player_id        BIGINT PRIMARY KEY REFERENCES hero.heroes(player_id) ON DELETE CASCADE,
    potential_grade  SMALLINT NOT NULL DEFAULT 0 CHECK (potential_grade BETWEEN 0 AND 700),
    potential_points INTEGER  NOT NULL DEFAULT 0 CHECK (potential_points >= 0)
);
```

## 8. Backend implementation notes

- `hero::proficiency::handle_op` (8660): reject unless the switch is enabled server-side and the hero is Avenger; op 0 reply 210; op 1 consume items (exclude locked items) and add points; op 2 check points >= next `Exp`, increment grade, subtract; reply 210, push 113 for stats.

## 9. Open questions and assumptions

- Feature disabled in BR; implement last, behind a server switch.
- Assumption: practice subtracts `Exp` from the points.

## 10. Implementation checklist

- [ ] Screens: ProficiencyFrame, ProficiencyExchangeFrame
- [ ] Route 8660 op 0
- [ ] Route 8660 op 1
- [ ] Route 8660 op 2
- [ ] Server message 210
- [ ] Table `hero.potential`
- [ ] Rule: Avenger-only, layer every 7 grades, stats from template
- [ ] Test: exchange then practice to grade 7
