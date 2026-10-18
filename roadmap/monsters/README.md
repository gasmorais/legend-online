# Monsters (Feras de combate e invocação)

The "Monstro" system gives the lord a collection of combat beasts. One beast at a time fights next to the lord, one can follow the lord on the map, and up to three are bound by "Contrato" so the lord inherits the special characteristic of their accessory. Beasts are summoned in magic circles ("Invocar círculo") from materials gathered in Monster Exploration, fed with food cooked in the "Cozinha" to raise their stage ("Fase"), evolved to more stars ("Evolução"), have their skills trained by sacrificing other beasts ("Treino"), and wear one accessory (bell, glove or sachet) that is strengthened, broken through and tempered ("Temperamento") to roll characteristics ("Característica").

pt-BR frame title: "Monstro" (`MonsterFrame.title.text`). Help title: "Instruções de ajuda de monstro".

## Entry points and unlock

| Entry | Condition | Citation |
|---|---|---|
| Main toolbar, child button of the mount button (`_mountBtn.buttonChildBtn`) | `thane.grades >= 70 && VersionSwitch.MONSTER`; locked tip "store.view.StoreFrame.command01" with 70 | `decompiled/core_module/scripts/ui/maintoolbar/MainToolBar.as:1432-1437`, `decompiled/core_module/scripts/ui/maintoolbar/constant/MainToolCheckBtnOpen.as:66-67,173-174` |
| Hotkey K | same, plus not in battle/vehicle and keyboard enabled | `MainToolCheckBtnOpen.as:126-127`, `decompiled/core_module/scripts/yishi/keyboard/KeyBoardRegister.as:1052-1083` |
| `SwitchPageHelp.openMonsterFrame()` (links from other UIs) | `VersionSwitch.MONSTER` else "Esta função ainda não foi ativada"; level >= 70 else "Nível baixo, função habilitada no Nv. {0}" | `decompiled/core_module/scripts/yishi/SwitchPageHelp.as:2567-2579` |
| Player info "Verificar Monstro" (look at another player's beast) | opens `MonsterControler` with openType `LOOK_UP_MONSTER` | `decompiled/m5/scripts/playerinfo/PlayerInfoFrameII.as:1424`, `decompiled/core_module/scripts/mvc/controler/MonsterControler.as:24-31` |

FrameControllerManager key: `"monster"` (`decompiled/core_module/scripts/yishi/manager/FrameControllerManager.as:1893-1894`), frame class `monster.MonsterFrame` in module m14.

## Modules

| Module | File | Scope |
|---|---|---|
| Beasts (roster) | [beasts.md](beasts.md) | Data sync (4574/4575), list, attributes, deploy to battle, first, follow, lock, look up, handbook ("Manual") |
| Summon | [summon.md](summon.md) | Magic circles: unlock, summon with materials, instant finish, cancel, collect, upgrade (ops 2..7) |
| Kitchen | [kitchen.md](kitchen.md) | Ovens: unlock, cook, instant finish, cancel, collect, upgrade (ops 8..13) |
| Growth | [growth.md](growth.md) | Feeding / stage training (op 15), evolution (op 16), skill training (op 14) |
| Accessories | [accessories.md](accessories.md) | Equip/unequip (5005 bag moves), strengthen (5150), breakthrough (5441), temperament (5440, manual and VIP4 auto), characteristics, sell |
| Contracts | [contracts.md](contracts.md) | Three contract slots (op 21) that pass accessory characteristics to the lord |

Every request of the module uses opcode 8652 (0x21cc) `C_MONSTER_CLIENT_OP` with `MonsterClientOpMsg.opType` except the accessory routes (5005, 5150, 5440, 5441) and the vice password lock (8809). Op codes are named in `decompiled/core_module/scripts/mvc/module/monster/MonsterConstClass.as:6-46`:

| op | Constant | Module |
|---:|---|---|
| 1 | REQUEST_USER_DATA | beasts |
| 2..7 | CALL, CALL_FINISH, CALL_CANCEL, CALL_GET, CALL_UPGRADE, CALL_UNLOCK | summon |
| 8..13 | COOK, COOK_FINISH, COOK_CANCEL, COOK_GET, COOK_UPGRADE, COOK_UNLOCK | kitchen |
| 14 | SKILL_UPGRADE | growth |
| 15 | FEED | growth |
| 16 | EVOLVE | growth |
| 17 | FIGHT (toggle deploy) | beasts |
| 18 | FIRST | beasts |
| 19, 20 | FOLLOW, CANCEL_FOLLOW | beasts |
| 21 | CONTRACT | contracts |

## Dependencies

| Feature | Why |
|---|---|
| [../exploration/README.md](../exploration/README.md) | Monster Exploration ("Expedição Monstruosa", `monsterexplore`, opcodes 8653, 4576..4580) is the source of summon materials (231xxx), "Gema do dragão" 2330001, beast EXP (4580) and the `exploreFights` id list in 4575. The first beast (template 101, config `monster_explore_present`) is granted there |
| [../inventory/README.md](../inventory/README.md) | Accessories and accessory materials are real items in bag types 36 (monster bag), 37 (equipped on a beast, `object_id` = monster id) and 0 (hidden work bag); bag move 5005, pushes 54/115; sell via `army.ItemSellView` |
| [../smith/README.md](../smith/README.md) | Accessory strengthen reuses `U_C_ITEM_STRENGTHEN` 5150 / 86 (`StoreReqMsg.opType = 2`) and the hidden bag 0 workflow |
| [../battle/README.md](../battle/README.md) | Deployed beast fights as `monsters[]` role; manual skill order 10520 `B_MONSTER_ORDER`; reinforce/swap push 4793 (`docs/battle/formation.md`) |
| [../hero/README.md](../hero/README.md) | `ArmyMsg.monster_id` (#42) carries the following beast template for map avatars; fighting capacity |
| [../vip/README.md](../vip/README.md) | Auto temperament requires VIP 4 and an active VIP |
| [../account/README.md](../account/README.md) | Vice password lock 8809 `LockAndUnlockMsg` (op 6) locks a beast |
| [../rankings/README.md](../rankings/README.md) | Look up of other players reads `MonsterInfo` XML attributes (`decompiled/core_module/scripts/mvc/controler/SortController.as:460-479`) |

## Suggested implementation order

1. Tables `monsters.monsters`, `monsters.player_state`, `monsters.material_items`; templates loader (MonsterTemplates, UpGradeTempInfos types 147/148/149/151, SkillPropertyTempInfos, ConfigInfos keys).
2. [beasts.md](beasts.md): op 1 full sync (4574 + 4575 opType 0), ops 17..20, `ArmyMsg.monster_id`.
3. [growth.md](growth.md): feed (15), evolve (16), skill training (14).
4. [summon.md](summon.md) and [kitchen.md](kitchen.md): timers, diamond costs, drops.
5. [accessories.md](accessories.md): equip moves, strengthen, breakthrough, temperament.
6. [contracts.md](contracts.md) and battle hooks (beast unit, contract characteristic on the lord).

## Current server behavior

`server/flows.json` and `server/flows/*.json` have no rule for 8652, 5440, 5441, 4574 or 4575: the frame opens with an empty roster (all tabs disabled except the handbook, `decompiled/m14/scripts/monster/MonsterFrame.as:222-235`).
