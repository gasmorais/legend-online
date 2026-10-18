# Star equipment: cosmos bag, horoscope slots, devour, bag synthesis, lock, bag cells

Module `star-equip` of feature `cosmos`. Covers the "Horóscopo" panel: the cosmos bag (bag type 1, 12 + 6 cells), the 10 equip slots (bag type 2), moving stars between them, devouring one star into another, synthesizing the whole bag, the synthesis lock, buying the 6 extra bag cells, star power and the attribute contribution to the hero. All star cell changes are pushed with 4178, defined here and reused by every other star module.

Path aliases:

| Alias | File |
|---|---|
| SM | `decompiled/core_module/scripts/yishi/manager/StarManager.as` |
| SMOD | `decompiled/core_module/scripts/mvc/module/star/StarModel.as` |
| SH | `decompiled/core_module/scripts/yishi/utils/StarHelper.as` |
| SBC | `decompiled/core_module/scripts/cell/view/starbag/StarBagCell.as` |
| BH | `decompiled/core_module/scripts/bag/helper/BagHelper.as` |
| V | `decompiled/m5/scripts/star/` |
| TIP | `decompiled/core_module/scripts/yishi/view/tips/goods/StarTip.as` |
| PTIP | `decompiled/m16/scripts/yishi/view/tips/goods/StarPowTip.as` |

## 1. Overview

| Area | Bag type | Cells | Unlock |
|---|---|---|---|
| Cosmos bag ("mochila de cosmos") | 1 | 0..17; usable `12 + starBagCount` | 12 free, 6 bought together (`Star_BagAdd` = 6) for 100 diamonds (`Star_BagPrice`) |
| Equip slots 0..7 (normal) | 2 | 8 | slot i open when `i < floor(heroLevel / 10)` (slot 0 at 10, slot 7 at 80) |
| Equip slot 8 (advanced 1) | 2 | 1 | task 1802 ("Mestre de Cosmos") finished and hero level >= 60 |
| Equip slot 9 (advanced 2) | 2 | 1 | task 1802 finished and `vocationLevel > 0` (job advanced: "Espadachim do Dragão", "Guerreiro do Dragão", "Sacrifício do Dragão") |

Equipped stars give attributes and "Poder dos Cosmos" (star power). Two equipped stars can never share a `MasterType`. Advanced stars (`MasterType` 17, 18, 19: Gêmeos, Peixes, Câncer) only fit slots 8 and 9. Energy stars (Profile 6) cannot be equipped; they only feed experience.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `V/HoroscopeFrame.as` | (horoscope panel, power label "Poder dos Cosmos") | hero figure, 10 slots, bag, star power, quick synthesis "Sintetizar todos os cosmos destravados", lock tool "Travar Cosmo", sublimation button | embedded in `StarFrame` (toggle button), or alone via controller openType 1 (`decompiled/core_module/scripts/yishi/SwitchPageHelp.as:1705-1713`) | `SMOD.getStarPow()`, `StarPowTip` with star list and trough grades (`:88-121`) |
| `V/view/PlayerStarListView.as` | locked cell tip "Clique para abrir espaço na mochila de cosmos" | 18 `StarBagCell` of bag 1 | HoroscopeFrame | cells >= `12 + starBagCount` locked (`:49-62`) |
| `V/view/EquipStarListView.as` | locked tips "Habilitado no nível {0}", "Para desbloquear o jogador tem de atingir o nv.60 e concluir a missão do Mestre de Cosmos.", "Slot de cosmo avançado, após transferir profissão poderá ser liberado." | 10 slots of bag 2 with trough info | HoroscopeFrame | unlock state (`:75-143`), refinement "+" button per slot (see [star-addition.md](star-addition.md)) |
| `SBC` | "Nv. {0}" | one draggable cell (bag 1, 2, 3) | lists above | icon, name colored by profile, level, lock icon (`asset.common.vp.icon`), equipped marker (`:731-844`) |
| `TIP` | "{name} Nv.{grade}", "Experiência {0}" / "Nível máximo", "Preço {0}" | star tooltip | any star icon | attributes with trough bonus (`TIP:96-124,160-203`) |
| `PTIP` | "Poder dos Cosmos" | star power tooltip | power label | total power and each equipped star (`PTIP:54-100`) |

## 3. Routes (client to server)

### E1. Move a star (equip, unequip, rearrange)
- UI:
  - drag a `SBC` onto an empty unlocked `SBC` (`SBC:402-559`);
  - drag an equipped star onto the bag area (`IDragTarget` type `PLAYER_STARLISTVIEW`) or a bag star outside (`SBC:563-584`), which falls back to the double click logic;
  - double click: bag 1 star -> `SM.moveToEquip`, equipped star -> `SM.moveToBag` (`SBC:683-724`).
- Client checks:
  - target cell locked or not accepting drop -> cancel (`SBC:420-424`);
  - bag 1 -> bag 2: Profile 6 -> "Esse cosmo não pode ser equipado"; target slot < 8 and `MasterType` in 17..19 -> "Cosmos avançados não podem ser colocados dentro do slot de cosmos inferiores"; same `MasterType` already equipped -> "Não é possível equipar cosmos de mesmo atributo" (`SBC:522-549`);
  - any move into slot < 8 with `MasterType` 17..19 -> same advanced slot message (`SBC:550-556`);
  - `SM.moveToEquip` (`SM:719-833`): Profile 6 -> "Esse cosmo não pode ser equipado"; equipped count >= `min(floor(level/10), 8) + (task1802 && level >= 60 ? 1 + (vocationLevel > 0 ? 1 : 0) : 0)` -> "Número máximo de cosmos já equipados, não é possível equipar mais"; same `MasterType` -> "Não é possível equipar cosmos de mesmo atributo"; advanced star with no free advanced slot -> "Slot do cosmo avançado cheio" (job advanced) or "Necessário ativar slots de cosmos avançados"; chosen slot 8 not unlocked -> "Cosmos avançados apenas poderão ser colocados nos slots de cosmos do mesmo nível, slot de cosmos avançado bloqueada." (advanced) or "Slot do cosmo baixo cheio, o primeiro slot do cosmo avançado, apenas é liberado após a troca de profissão."; chosen slot 9 not unlocked -> "Cosmos avançados apenas poderão ser colocados nos slots de cosmos do mesmo nível, segundo slot bloqueado." or "Slot do cosmo baixo cheio, o segundo slot do cosmo avançado, apenas é liberado após elevar até o nv.{0}." (`{0}` = third job name). Target = first empty slot (advanced stars: first empty unlocked advanced slot).
  - `SM.moveToBag` (`SM:663-690`): bag count == capacity -> "Mochila de cosmos cheia, não é possível mover"; target = first empty position 0..17.
- Sender: `SM.starMove(beginPos, beginType, endPos, endType, eat = false, count = 1)` (`SM:378-389`).
- Route: C>S 8267 (0x204b) `C_STAR_MOVE`, `StarMoveReqMsg`: `begin_star_type (#1, INT32)` source bag type; `begin_pos (#2, INT32)` source cell; `end_star_type (#3, INT32)` target bag type; `end_pos (#4, INT32)` target cell; `count (#5, INT32)` always 1; `eat (#6, BOOL)` false.
- Response: 4178 with two entries: source cell without `star_Info` (delete) and target cell with the moved star. Hero attribute pushes follow when bag 2 changes (owner hero).

### E2. Devour (feed one star into another)
- UI: drag star A onto occupied cell B (bags 1 and 2) (`SBC:425-463`).
- Client checks: A or B is Profile 8 -> "Não se pode efetuar absorção entre 2 cosmos avançados"; the eaten star is B when B is an energy star (Profile 6), else A; eaten star locked -> "O Cosmo atual já foi bloqueado, favor desbloquear"; confirm "{eater} acrescentará {1} pontos de experiência" + ", \nelevado ao Nv. {0}" when the level rises (`SH.checkCanUpGrade`); after confirm, eater at max grade -> "Cosmo atingiu nível máximo, não é possível consumir"; eaten Profile >= 5 and != 6 -> typed confirmation "Certeza ao converter {0} em experiência?" (`SBC:636-672`).
- Sender: `SM.starMove(eaten.pos, eaten.bagType, eater.bagPos, eater.bagType, true)` (`SBC:674-681`).
- Route: 8267 with `eat = true`; begin = eaten star, end = eater star.
- Server: add `SH.getStarTotalExp(eaten)` to the eater `gp`, level up with the eater's profile table, cap at max grade, delete the eaten star. Response: 4178 (delete eaten cell, update eater cell).

### E3. Synthesize the whole bag
- UI: horoscope quick compose (`V/HoroscopeFrame.as:182-287`).
- Client checks: bag count <= 1 -> "Não há cosmos disponíveis para síntese"; candidates = bag 1 stars not locked, `grade < 10`, Profile < 8; target = a non energy candidate below its max grade (the client effectively takes the last one iterated); remaining exp <= 0 -> same message; confirm with "não perguntar novamente" (`StarManager.isNotAlert`): "{target} irá consumir todos os cosmos destravados da mochila, acréscimo {0} de experiência" + ", nível aumentou até {0}"; second typed confirmation when another candidate has Profile >= 5 and != 6, Profile < 8, grade < 10.
- Sender: `SM.sendQuickCompose(target.pos)` with default `bag_type = 1` (`SM:419-426`, `V/HoroscopeFrame.as:280-287`).
- Route: C>S 8331 (0x208b) `C_STAR_COMPOSE`, `StarComposeReqMsg`: `pos (#1, INT32)` target bag cell; `bag_type (#2, INT32)` 1.
- Server: consume every other candidate of bag 1 (same filter as the client), add their exp to the target. Response: 4178 only (one delete per consumed cell and the target update). Never 4479 (it would clear the temporary area).

### E4. Toggle the synthesis lock
- UI: lock button "Travar Cosmo" (`V/HoroscopeFrame.as:295-322`): during a password reset -> "Durante o periodo de reset à senha, não pode realizar nenhuma operação"; no item password -> opens `vicepassword` openType 1 (create); password not confirmed this session -> `vicepassword` openType 3; else enters lock cursor mode (`BH.vpLockBtnClickHandler`, `BH:261-279`). Clicking a `SBC` with a star in lock mode sends the toggle (`BH:370-386`). A drag variant exists (`V/HoroscopeFrame.as:324-362`, `onLockDrop`).
- Sender: `SM.sendStarComposeLock(bagType, pos)` (`SM:428-435`).
- Route: C>S 8330 (0x208a) `C_STAR_LOCK`, `StarLockReqMsg`: `star_type (#1, INT32)` bag type (1 or 2); `pos (#2, INT32)` cell.
- Server: flip `is_locked`. Response: 4178 with the updated cell (`is_lock`).

### E5. Buy the extra bag cells
- UI: click a locked bag cell (`V/view/PlayerStarListView.as:68-80,127-131`).
- Client: confirm "Para abrir espaço na mochila de cosmos consume {0} diamantes" with `Star_BagPrice` (100) and a "use bound diamonds" checkbox (`SimpleAlertHelper` type `USEBINDPOINT_ALERT`) (`SM:391-400`).
- Sender: `SM.payCallBack` (`SM:402-417`).
- Route: C>S 8270 (0x204e) `C_STAR_BUY`, `PayTypeMsg`: `pay_type (#1, INT32)` 0 = bound diamonds allowed (checkbox on), 1 = real diamonds only; `property1 (#2, INT32)`, `property2 (#3, INT32)`, `type (#4, INT32)` unused.
- Server: `extra_bag_cells < 6` and diamonds >= 100 -> `extra_bag_cells += 6`. Response: 3 with `star_count (#43)` = new extra count (client unlocks cells 12..17 and shows "Espaço na mochila habilitado com sucesso", `V/view/PlayerStarListView.as:101-125`), diamond balance push (currency).

### E6. Star link in chat (local)
- Shift click on a `SBC` sends `SEND_STAR` to the chat input (`SBC:364-369`). No star route.

## 4. Server messages (server to client)

### S1. 4178 (0x1052) `U_C_START_MOVE_UPDATE`, `StarMoveRspMsg`
Receiver `SM.__starMoveUpdateHandler` (`SM:92-167`, listener `SM:85`).

| Field | Tag | Type | Rep | Meaning |
|---|---|---|---|---|
| `move` | #1 | `StarMoveMsg` | yes | changed cells |

`StarMoveMsg`: `change_type (#1, INT32)` bag type of the cell; `change_pos (#2, INT32)` cell; `star_Info (#3, StarInfoMsg)` optional, present = cell now holds this star, absent = cell emptied. `StarInfoMsg` fields are listed in [star-divination.md](star-divination.md) S1; its `bag_type`/`pos` must equal `change_type`/`change_pos` because the client keys stars by `change_type + "_" + change_pos`.

Client reaction: create or update the star and dispatch `UPDATE_STAR` (and `UPDATE_STAR_POWER` for bag 2); for a delete dispatch `DELETE_STAR` (crashes if the cell was unknown, so never send deletes for empty cells). Then `InfoTipsManager.dealData(13)` recounts empty unlocked slots for the toolbar badge (`decompiled/core_module/scripts/yishi/manager/InfoTipsManager.as:128-158`).

When: login (all stars of bags 1, 2, 3), after E1..E4, after a pick ([star-divination.md](star-divination.md)), shop buy ([star-shop.md](star-shop.md)), sublimation ([star-sublime.md](star-sublime.md)).

### S2. 3 (0x0003) `U_C_PLAYER_INFO`
`star_count (#43)` after E5 (see [star-divination.md](star-divination.md) S4).

No result codes; invalid requests are ignored (assumption: optionally a system tip).

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Bag capacity | `12 + extra_bag_cells`, positions 0..17 | `SM:497-512`, `V/view/PlayerStarListView.as:24-26` |
| Extra cells | one purchase of 6 for 100 diamonds | `ConfigInfos.xml` `Star_BagPrice`, `Star_BagAdd` |
| Normal slot i (0..7) | open when `i < floor(level / 10)` | `V/view/EquipStarListView.as:85-104` |
| Slot 8 | task 1802 finished and level >= 60 | `V/view/EquipStarListView.as:105-127`, `SM:767` |
| Slot 9 | task 1802 finished and `vocationLevel > 0` | `V/view/EquipStarListView.as:128-140`, `SM:771` |
| Unique family | at most one equipped star per `MasterType` | `SM:755-761`, `SBC:538-547` |
| Advanced family | `MasterType` 17, 18, 19 only in slots 8, 9 (template `NeedGrades` 60 for Profile 7, 81 for Profile 8) | `SBC:531,550`, `starTempInfos.xml` |
| Not equippable | Profile 6 | `SM:725-730` |
| Devour | eater gains `getStarTotalExp(eaten)`; energy star is always the eaten one; no devour involving Profile 8; eaten not locked; eater below max grade | `SBC:425-463,636-681`, `SH:114-135` |
| Bag synthesis filter | not locked, `grade < 10`, Profile < 8 | `V/HoroscopeFrame.as:197-219` |
| Attribute of a star | for each stat X: `X * grade + int(X * grade * troughGrade * 0.01)`; troughGrade only for equipped stars in slots with a trough | `TIP:96-124,197-201`, `PTIP:85-93` |
| Star power ("Poder dos Cosmos") | `int(sum(getStarTotalExp(equipped)) / 10 * (1 + avgTroughLv / 100))`, `avgTroughLv = sum(trough grade of slots 0..7) / 8` | `SMOD:83-108` (`PTIP:64-78` sums all 10 troughs / 8; use `SMOD`) |
| "Star not full" tip | level 18..24 power < 150 gold >= 50000; 25..34 < 250 and >= 100000; 35..40 < 500 and >= 150000 | `SM:532-547` |
| Toolbar badge 13 | count of empty unlocked slots | `InfoTipsManager.as:128-158` |
| Hero stats | equipped star attributes are part of the hero `PropertyMsg` (`star_Per` #6, `star_Data` #7, package `army`) | owner [hero](../hero/README.md) |

## 6. Templates

| File | Fields used |
|---|---|
| `starTempInfos.xml` | `MasterType` (family uniqueness, advanced 17..19), `Profile`, stats, `NeedGrades`, `SellGp` |
| `UpGradeTempInfos.xml` | types 9, 10, 11, 12, 13, 22 for exp and max grade (see [star-divination.md](star-divination.md)) |
| `ConfigInfos.xml` | `Star_BagPrice` 100, `Star_BagAdd` 6 |
| quest templates | task 1802 (owner [quests](../quests/README.md)) |

## 7. Persistent state

Uses `cosmos.stars` and `cosmos.star_state.extra_bag_cells` from [star-divination.md](star-divination.md). Additional constraint for this module:

```sql
-- Unique equipped family is enforced in code (MasterType comes from templates);
-- slot range checks per bag:
ALTER TABLE cosmos.stars ADD CONSTRAINT stars_pos_by_bag CHECK (
  (bag_type = 2 AND pos BETWEEN 0 AND 9) OR
  (bag_type = 3 AND pos = 0) OR
  (bag_type IN (0, 1) AND pos BETWEEN 0 AND 17)
);
```

## 8. Backend implementation notes

| Opcode | Handler |
|---|---|
| 8267 (`eat = false`) | `cosmos::star_equip::handle_move` |
| 8267 (`eat = true`) | `cosmos::star_equip::handle_devour` |
| 8331 (`bag_type = 1`) | `cosmos::star_equip::handle_bag_compose` |
| 8330 | `cosmos::star_equip::handle_lock` |
| 8270 | `cosmos::star_equip::handle_buy_bag_cells` |

- Validation order for 8267: source star exists and belongs to the player -> bag types in {1, 2} (bag 3 handled in [star-sublime.md](star-sublime.md)) -> target position in range and unlocked (bag 1 `< 12 + extra`, bag 2 slot rules) -> equip rules (Profile 6, family, advanced slots) -> if target occupied and `eat = false`: swap both stars when both directions are legal (assumption, the UI never sends it) else reject -> one transaction -> push 4178 -> recompute hero stats and combat power when bag 2 changed (push owned by hero).
- Devour/synthesis: exp loop per section 5; never consume locked stars; delete consumed rows.
- 8270: deduct diamonds through the currency service honoring `pay_type`, update `extra_bag_cells`, push 3 and the diamond balance.
- Battle: equipped star attributes enter the hero stats used by every battle (`decompiled/core_module/scripts/battle/logsys/DebugBattleCreater.as:420` reads bag 2 for debug battles).
- No timers.

## 9. Open questions and assumptions

- Assumption: a non eat move onto an occupied cell swaps (the client never sends it).
- `vocationLevel` (job advance level) vs `vocationGrades`: slot 9 uses `vocationLevel > 0`; the sublimation button uses `thane.vocationGrades > 0`. Both come from the hero feature.
- Star power tooltip and model disagree on troughs 8, 9; the server value is not sent, so only the hero combat power matters.
- Assumption: equipped Profile 8 stars can be devoured by nothing and cannot devour (client rule); server enforces the same.

## 10. Implementation checklist

- [ ] Screens (client ready): `HoroscopeFrame`, `PlayerStarListView`, `EquipStarListView`, `StarBagCell`, `StarTip`, `StarPowTip`.
- [ ] Push 4178 at login with bags 1, 2, 3.
- [ ] Route 8267 move with slot unlock, family and advanced slot rules.
- [ ] Route 8267 eat (devour) with energy star role swap and max grade.
- [ ] Route 8331 bag 1 synthesis (4178 only).
- [ ] Route 8330 lock toggle.
- [ ] Route 8270 bag cell purchase with `pay_type`.
- [ ] Hero stat integration (attribute formula with trough %), combat power refresh.
- [ ] Tests: equip at level 9 rejected, level 10 slot 0 accepted; duplicate MasterType rejected; advanced star rejected in slot 0..7; slot 8 needs task 1802 and level 60; devour moves exp and levels up; locked star cannot be devoured; synthesis skips locked and Profile 8 stars; buying cells twice rejected; 4178 delete never targets an empty cell.
