# Recruitment, barracks and troop assignment (Quartel, Recrutar, Organizar tropa)

Path aliases:

| Alias | File |
|---|---|
| ASOM | `decompiled/core_module/scripts/managers/ArmySocketOutManager.as` |
| AC | `decompiled/core_module/scripts/mvc/controler/ArmyControler.as` |
| AM | `decompiled/core_module/scripts/yishi/manager/ArmyManager.as` |
| AMOD | `decompiled/core_module/scripts/mvc/module/armyII/ArmyModel.as` |
| RPC | `decompiled/core_module/scripts/yishi/view/community/RecruitPawnCell.as` |
| CRF | `decompiled/core_module/scripts/yishi/view/frame/CasernRecruitFrame.as` |
| AL | `decompiled/m5/scripts/armyII/viewII/allocate/` |
| LU | `decompiled/m5/scripts/armyII/viewII/lineUp/` |

## 1. Overview

- Recruit: in the barracks ("Quartel", building SonType 402) or the "Abastecer tropa" frame, the player buys soldiers of an unlocked family with gold and population. Soldiers go to the castle reserve.
- Assign: the hero troop (site 0) holds one soldier family; the player drags reserve soldiers into it ("Organizar tropa"), toggles a family with "Batalhar"/"Descansar" in the "Equipe" tab, or lets auto allocate fill it when the barracks frame closes. Every change is sent as the full new state of site 0.
- Dismiss: "Dispersar tropa" removes soldiers from the reserve.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `buildings.casern.view.CasernFrame` (`decompiled/m4/scripts/buildings/casern/view/CasernFrame.as`) | barracks building frame | List of soldier families with "Recrutar" and "Elevar" | castle building SonType 402 ([../castle/README.md](../castle/README.md)) | `PawnTileList` of `casernPawnList`, sorted by `NeedBuilding` |
| `yishi.view.community.RecruitPawnCell` (RPC) | "Recrutar", "Elevar", "Nv. {0}", "Necessita de {0}" | One family: level, lock if the required building level is missing | CasernFrame, RecruitPawnFrame | template, `canRecruit`, barracks level |
| `yishi.view.frame.CasernRecruitFrame` (CRF) | "Recrutar"; labels "Necessário", "Quantidade" | Quantity slider and gold cost | "Recrutar" (`AC.openCasernRecruitFrame`, AC:316-325) | max by population and gold (CRF:266-316) |
| `armyII.viewII.allocate.RecruitPawnFrame` | "Abastecer tropa" | Barracks list inside the army UI | troop panel / Equipe "Recrutar soldado" (`RECRUIT_PAWN`) | `RecruitPawnTileList` |
| `armyII.viewII.allocate.AdjustPawnFrame` | "Organizar tropa" | Split/merge quantity when dragging soldiers between reserve and troop | drag in AllocateView / LineUp | slider up to the source count |
| `armyII.viewII.allocate.DissmissPawnFrame` | "Dispersar tropa" | Dismiss quantity | delete button on a reserve item (`LU/LineUpLeftItem.as:202-208`) | input capped by `ownPawns` |
| `armyII.viewII.lineUp.LineupLeftView` | "Batalhar" / "Descansar" | Up to 3 reserve families with soldiers; toggle which one the hero leads | SkillFrame "Equipe" | reserve entries with `ownPawns > 0` |

## 3. Routes (client to server)

### R1. Recruit soldiers
- UI: "Recrutar" on `RecruitPawnCell` (RPC:212-237) → `CasernRecruitFrame` OK (CRF:194-200).
- Client checks (RPC:212-237, CRF:266-316): free population `(limit - count) / NeedPopulation > 0` else "População insuficiente" (`buildings.casern.view.RecruitPawnCell.command03`); unit gold cost <= gold else "Ouro Insuficiente" (`public.gold`); the cell is enabled only if the barracks level >= the level of the `NeedBuilding` template (RPC:154-190); quantity max = `min(free population / NeedPopulation, gold / unit cost)`.
- Client path: `AC.sendRecruitPawn(templateId, count)` (AC:371-374) → `ASOM.sendRecruitPawn` (ASOM:57-64).
- Route: send 5155 (0x1423) `U_C_ARMY_RECRUITED`. Request `ArmyPawnInfoMsg`: `tempate_id` (#5, INT32) soldier template (current level of the family); `own_pawns` (#6, INT32) quantity; other fields unset.
- Expected response: 92 `U_C_ARMY_RECRUITED` (`ArmyPawnUpdatedMsg` with the reserve row of that family), gold and population pushes (3 `U_C_PLAYER_INFO` / resource messages, see [../currency/README.md](../currency/README.md)).

### R2. Edit the hero troop (site 0)
- UI triggers:
  - drag between reserve (`AL/PawnDragCell.as`) and troop (`AL/SoldierDragCell.as`) with `AdjustPawnFrame` (`AL/AdjustPawnFrame.as:134-187`: swap, join, add);
  - "Batalhar"/"Descansar" (`LU/LineUpLeftItem.as:128-182`): selecting a family moves the current troop back to the reserve and fills site 0 with `min(reserve, totalConatArmy / NeedPopulation)`; deselecting empties site 0. Checks: command > 0 else "Soldados atuais insuficientes" (`LineUpLeftItem.totalConatArmy.noCount`); 1 s click throttle "Clique excessivo, tente novamente";
  - auto allocate (`AC.autoAllocate`, AC:359-364; AMOD:114-147) when the barracks frame closes;
  - `LU/LineUpFormationItem.as:106`.
- Client path: the client mutates its local model first, then `AC.sendMovePawnInfo()` (AC:347-357) sends only if site 0 template or count changed: `AC.sendEditArmyPawn(0, templateId, count)` → `ASOM.sendEditArmyPawn` (ASOM:75-83).
- Route: send 5156 (0x1424) `U_C_ARMY_EDIT`. Request `ArmyPawnInfoMsg`: `sites` (#3, INT32) = 0; `tempate_id` (#5, INT32) template now in the troop (0 if empty); `own_pawns` (#6, INT32) new troop count.
- Expected response: 93 `U_C_ARMY_EDIT` (`ArmyEditRspMsg`, the troop) and 100 `U_C_ARMY_UPDATE_ARMYPAWN` (reserve rows changed). The server must compute the delta against its stored state (move soldiers between reserve and troop).

### R3. Dismiss soldiers
- UI: `DissmissPawnFrame` confirm (`AL/DissmissPawnFrame.as:103-118`); empty input → "Quantidade de soldados à dispersar, mínimo 1".
- Client path: `AC.sendDismissPawn(templateId, count)` (AC:426-429) → `ASOM.sendDismissPawn` (ASOM:66-73).
- Route: send 5157 (0x1425) `U_C_ARMY_DEMOBPAWN`. Request `ArmyPawnInfoMsg`: `tempate_id` (#5) reserve template; `own_pawns` (#6) count to remove.
- Expected response: 100 with the new reserve count; population push (freed population). The frame also has a legacy AMF handler `dissmissHandler` (`:120-131`) that is not wired.

## 4. Server messages (server to client)

- 92 `U_C_ARMY_RECRUITED`, 100 `U_C_ARMY_UPDATE_ARMYPAWN`, 93 `U_C_ARMY_EDIT`: see [troops.md](troops.md) S2..S4.
- Error reporting: none of the routes has a failure opcode; use the generic system message push *(assumption)*.

## 5. Rules and formulas

- Unit gold cost (CRF:285-316, RPC:219-221): `ceil(n * effect(GoldConsume * (1 - Property4 / 100)))`, where `Property4` is the largest `Property4` among the building templates returned by `BuildingManager.getMaxEffectBuildingTemplate(template)` (barracks discount, %) and `effect()` is `PlayerEffect.getRecruitPawnResourceAddition` (buffs). Population: `n * NeedPopulation`.
- Recruit unlock: family available when the barracks reached the level of `NeedBuilding` (`BuildingTempInfos` id, e.g. 40201 Lanceiro, 40204 Arqueiro, 40220 Espadachim/Sacerdote, 40230 Griffin, 40240 Cavaleiro/Anjo, 40250 Demônio/Presbítera, 40270 Cavaleiro Mágico/Anjo Mágico).
- The "Elevar" button on a cell appears at hero level >= 8 (RPC:99, RPC:173).
- Troop cap: `totalConatArmy / NeedPopulation` (`LU/LineUpLeftItem.as:157-160`, AMOD:149-165). The server must clamp.
- One family per troop: putting another family into site 0 returns the previous soldiers to the reserve (`LU/LineUpLeftItem.as:161-167`).
- Recruitment is instant: `NeedTime` and `CrystalsConsume` are 0 in every family row (MasterType 1..11); `GoldConsume` is 2..4 per soldier.

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `PawnTempInfos.xml` | soldier level | `GoldConsume`, `NeedPopulation`, `NeedBuilding`, `NeedTime`, `PawnName`, `Level` |
| `BuildingTempInfos.xml` | barracks levels | `BuildingName`, `BuildingGrade`, `Property4` (recruit gold discount %) ([../castle/README.md](../castle/README.md)) |

## 7. Persistent state

Uses `army.castle_reserve` and `army.troops` from [troops.md](troops.md). Population and gold belong to the castle/currency features.

## 8. Backend implementation notes

- `army::recruitment::handle_recruit` (5155): template must be the current level of an unlocked family; barracks level check; `n > 0`; population free >= `n * NeedPopulation`; gold >= cost (same formula, server-side buffs); transaction: deduct gold, consume population, add to `army.castle_reserve`; push 92 and resources.
- `army::recruitment::handle_edit_troop` (5156): validate `sites = 0`, template equals the reserve template of its family, `own_pawns <= totalConatArmy / NeedPopulation`; compute moves: return the old troop to its reserve row, take `own_pawns` from the new reserve row (must be available); transaction; push 93 and 100.
- `army::recruitment::handle_dismiss` (5157): count <= reserve; decrement, free population; push 100 and population.
- Notify other players: none.

## 9. Open questions and assumptions

- Assumption: population is consumed by recruited soldiers and freed by dismissal and death.
- Open: whether dismissing can target the hero troop; the client only offers it on reserve entries.

## 10. Implementation checklist

- [ ] Screen: CasernFrame list and CasernRecruitFrame slider
- [ ] Screen: RecruitPawnFrame, AdjustPawnFrame, DissmissPawnFrame, LineupLeftView toggles
- [ ] Route 5155 recruit
- [ ] Route 5156 edit troop (delta computation)
- [ ] Route 5157 dismiss
- [ ] Server messages 92, 93, 100 after each route
- [ ] Rule: gold cost with barracks discount
- [ ] Rule: troop cap by command
- [ ] Test: recruit → assign → swap family → dismiss round trip
