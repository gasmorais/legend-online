# Goddess ("Deusa")

Feature slug `goddess`, domain companions. Five goddesses ("Deusa da Magia Hécate", "Deusa da Criação Illia", "Deusa da Esperança Aster", "Deusa do Destino Cassandra", "Deusa da Guerra Lenneth") are invoked with fragments and raised on three tracks (level, advance, offering). One goddess fights beside the hero as a support unit casting a guard skill and a dance skill driven by belief. Each goddess has four accessories ("Acessório da Deusa") with strengthen, advance and a four piece set bonus; the five position "Formação da Deusa" gives anti resistance, lets the hero inherit goddess stats and unlocks formation skills.

## Entry points

| Entry | Condition | Source |
|---|---|---|
| Toolbar skill button child `GoddessBtn` (hotkey J) -> `GodDessFrame` | `GodDessManager.isOpen` = `VersionSwitch.GODDESS_OPEN` and `vocationGrades > 0` | `decompiled/core_module/scripts/ui/maintoolbar/MainToolBar.as:2212-2228`, `:1074`; `decompiled/core_module/scripts/managers/GodDessManager.as:54-59` |
| `SwitchPageHelp.openStrengthenGodess` / `openAdvanceGodess` -> accessories tab | same | `decompiled/core_module/scripts/yishi/SwitchPageHelp.as:2856-2878` |
| Player info: "Ver Deusa", goddess accessories look up | other player's fighting goddess | `decompiled/m5/scripts/playerinfo/PlayerInfoFrameII.as:1454`, `:1614` |
| Activities: "Forja Dupla da Deusa" (4954), goddess level ranking | event windows | `equipment.md`, [seasonal-events](../seasonal-events/README.md) |

## Modules

| Module | Scope | Opcodes |
|---|---|---|
| [goddess](goddess.md) | invoke, level, advance, offering, battle goddess, battle integration; owns 177 | 5191 ops 1..5; 177; 4102 (battle) |
| [equipment](equipment.md) | accessories strengthen/advance/set, double forge event | 5191 ops 8, 10; 177 `equipInfos`; 4954 |
| [formation](formation.md) | "Formação da Deusa" positions, anti resistance, stat inheritance, formation skills | 5191 ops 6, 7; 177 `formations` |

## Dependencies

- [hero](../hero/README.md): goddess stats flow into hero power; formation inheritance; look up 4125 `DetailRspMsg.goddessInfo` (#22).
- [inventory](../inventory/README.md): fragments, Larimar, Amuleto de Oração, Marca da Terra, accessory materials, bag pushes.
- [battle](../battle/README.md): goddess units in battle creation, 4102 `U_B_GODDESS_STAGE`, belief.
- [smith](../smith/README.md): composing "Coração da Deusa" materials.
- [currency](../currency/README.md): gold for strengthening.
- [seasonal-events](../seasonal-events/README.md): double forge and goddess level activities.
- [dragon](../dragon/README.md): formation texts reference Titan skills.

## Suggested implementation order

1. `goddess` (table, 177, ops 1..5, stat formula, battle integration).
2. `equipment` (accessory rows created on activation, ops 8 and 10, 4954 scheduler).
3. `formation` (ops 6 and 7, hero inheritance, formation skills).
