# Estelas (steles)

Feature slug `steles`, domain `character`. Client packages `stelesys` (module `m14`) and `stele` (`core_module/scripts/mvc/module/stele`). Protobuf package `stela` (`StelaMsg`, `StelaDataMsg`, `StelaRefreshMsg`), plus the shared `player.PlayerOpMsg` and `item.ItemUseMsg`.

## Overview

An "Estela" (stele, internal name `stela`) is a collectible equipment-like object stored outside the normal bag. The player equips up to 10 steles: slot 1 is the core slot ("Estela Central") whose step grants a passive battle skill, slots 2..10 are auxiliary slots unlocked by the consecrated profession level (`vocationGrades`). Every equipped stele adds flat attributes (Ataque Físico, Defesa Física, Ataque Mágico, Defesa Mágica, Vida, Crítico, Bloqueio, Penetração, Anti_Res., Res. de Penetração) to the hero.

Progression of a single stele:

| pt-BR (help text `stela.helpFrame.content`) | Internal | What it does |
|---|---|---|
| Fortalecimento | intensify, op 2 | Consume other steles or "Estela de fortalecimento" material to gain strength EXP and levels, capped by the current step's `StrengthLimit`. |
| Ascensão | step/advance, op 3 | Consume N copies of the same stele at a given step to raise the step (grade color branco, verde, azul, roxo, laranja, vermelho), raising the level cap, the refine slot count and the passive skill. |
| Purificação | refine/baptize, ops 4, 5, 6 | Spend "Pedra de Purificação da Estela" (and optionally "Pedra de Bloqueio da Estela" per locked line) to reroll up to 5 random attribute lines, then accept or ignore the result. |
| Recuo | rollback, op 7 | Spend 1 "Pedra de Recuo" (or 100 diamonds) to reset a strengthened stele to level 0 and get back green strengthening material equal to its spent EXP. |

Steles are obtained by opening bag items of SonType 710 ("Baú de Estela ...", "Item de troca da Estela ...") through opcode 8665.

pt-BR names: frame title "Estela" (`stela.mainFrame.title`), selection frame "Seleção de Estela" (`stela.switchFrame.title`), preview "Visualização da Estela" (`stela.preview.title`).

## Entry points

| Entry | Condition | Citation |
|---|---|---|
| Main toolbar "Ferreiro / Atalho T" (`_storeBtn`) child button opens controller `stelesys` | Parent button open when `thane.grades >= 7` (`decompiled/core_module/scripts/ui/maintoolbar/constant/MainToolCheckBtnOpen.as:38-39`); child enabled only when `thane.isChangeJob` (profession changed, `vocationIndex > 0`, `decompiled/core_module/scripts/yishi/datas/playerinfo/SimplePlayerInfo.as:1259-1262`); but `_storeBtn.isChildOpen = false` so the child never slides out in this build | `decompiled/core_module/scripts/ui/maintoolbar/MainToolBar.as:1072-1073`, `:2187-2190` |
| `FrameControllerManager.openControllerByInfo("stelesys", openType, frameData)` | `openType == "switch.page"` opens `SteleSwitchFrame`, anything else `SteleSysFrame`; `frameData` selects the tab (0 main, 1 Fortalecimento, 2 Ascensão, 3 Purificação, 4 Recuo) | `decompiled/core_module/scripts/mvc/controler/SteleSysController.as:16-29`, `decompiled/m14/scripts/stelesys/SteleSysFrame.as:135-142`, `decompiled/core_module/scripts/yishi/manager/FrameControllerManager.as:1976-1978` |
| Bag item use (click, context menu, batch use) on SonType 710 | none client side besides the item | `decompiled/core_module/scripts/cell/mediator/playerbag/PlayerBagCellClickMediator.as:324-327`, `decompiled/core_module/scripts/cell/view/GoodsItemMenu.as:329-332`, `decompiled/core_module/scripts/bag/view/MulItemUseFrame.as:132-136` |

The manager `SteleSysManager.Ins.setup()` is called at boot (`decompiled/core_module/scripts/yishi/lunch/Yishi.as:534`), so the client accepts stele pushes even when the frame is closed. Note: in this BR build the toolbar entry is effectively hidden (see above); the backend must still implement everything because bag items and data pushes are live. Assumption: the server gates the feature on `vocationIndex > 0` (same as the toolbar).

## Modules

| Module | File | Routes | Server messages |
|---|---|---|---|
| Equip, collection, sync and selection | [equip.md](equip.md) | 8664 op 1 (equip, unequip) | 4279, 4280 |
| Fortalecimento (strengthen) | [intensify.md](intensify.md) | 8664 op 2 | 4280 |
| Ascensão (step up) | [advance.md](advance.md) | 8664 op 3 | 4280 |
| Purificação (refine) | [refine.md](refine.md) | 8664 ops 4, 5, 6 | 4281, 4280 |
| Recuo (rollback) | [rollback.md](rollback.md) | 8664 op 7 | 4280 |
| Stele boxes and exchange items | [boxes.md](boxes.md) | 8665 | 4280 |

### Op code table of `C_STELA_CLIETN_OP` 8664 (0x21d8), message `PlayerOpMsg`

Constants in `decompiled/core_module/scripts/managers/SteleSysManager.as:21-33`.

| op | Constant | Meaning | Fields used | Sender |
|---|---|---|---|---|
| 1 | `OP_EDIT` | Equip stele `id` into slot `pos` (`id = 0` unequips slot `pos`) | `op`, `id`, `pos` | `SteleSysManager.sendEquip` `:133-141` |
| 2 | `OP_STRENGTH` | Strengthen stele `id` consuming materials `param1` and steles `ids` | `op`, `id`, `param1`, `ids` | `sendIntensify` `:143-152` |
| 3 | `OP_STEP` | Step up stele `id` consuming steles `ids` | `op`, `id`, `ids` | `sendStep` `:154-162` |
| 4 | `OP_REFRESH` | Roll a new refine result for stele `id`, `param1` = lock flags | `op`, `id`, `param1` | `sendRefine` `:164-172` |
| 5 | `OP_VIEW_REFRESH` | Ask for the pending (not accepted) refine result of stele `id` | `op`, `id` | `sendGetRefine` `:174-181` |
| 6 | `OP_REPLACE` | Accept the pending refine result of stele `id` | `op`, `id` | `sendReplaceRefine` `:183-190` |
| 7 | `OP_ROLLBACK` | Roll back steles `ids` to level 0 | `op`, `ids` | `sendRecycle` `:192-199` |

## Dependencies

| Feature | Why |
|---|---|
| [hero](../hero/README.md) | Equipped stele attributes are added to hero attributes; aux slot unlock uses `vocationGrades`; access uses `isChangeJob`. |
| [inventory](../inventory/README.md) | SonType 710 items (opened by 8665), refine stones 7110001/7110002 and rollback stone 7110003 (SonType 711) live in the bag; bag updates via 115 `U_C_BAG_MOVE_UPDATE`. |
| [currency](../currency/README.md) | Rollback without stone costs `stela_roll_back_point` = 100 diamonds. |
| [skills](../skills/README.md) | Passive skills (`PassiveSkills`), refine attribute skills (`SkillTempInfos` MasterType 13100..13600) and resist skills (MasterType 141xx..146xx) with `SkillPropertyTempInfos`. |
| [battle](../battle/README.md) | The core stele passive skill and its buffers must be injected into the hero's battle unit. |
| [smith](../smith/README.md) | Shares the "Ferreiro" toolbar button (parent opens the smith, child opens steles). |
| [shops](../shops/README.md) | Assumption: stones and stele boxes are sold or rewarded elsewhere (no source in client data). |

## Suggested implementation order

1. Templates loader (StelaTemplates, StelaStepTemplates, StelaPropertyTemplates, StelaResistTemplates, refine skill pools) and tables (`equip.md` section 7).
2. Login sync 4279 and generic 4280 builder (`equip.md`).
3. Boxes 8665 (to obtain steles in tests) (`boxes.md`).
4. Equip/unequip and hero attribute aggregation (`equip.md`).
5. Fortalecimento (`intensify.md`).
6. Ascensão (`advance.md`).
7. Purificação (`refine.md`).
8. Recuo (`rollback.md`).
9. Battle passive skill injection (`equip.md` section 8).
