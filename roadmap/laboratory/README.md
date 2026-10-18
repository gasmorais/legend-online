# Laboratório de Platina e pote mágico (`laboratory`)

Domain: economy. Two unrelated systems grouped by the registry:

1. **Laboratório de Platina** (client package `perkinlab`, m11; title in the client "Laboratório de Plantina"). Shared code in `core_module`: `managers/PerkinLabManager.as`, `mvc/module/perkinlab/*`, `mvc/controler/PerkinLabControler.as`, tips in m16 (`PerkinLabKengTip`, `PerkinLabVictoryTip`, `PerkinLabExpTips`, `tasktracetip/view/PerkinlabCanPickTipView.as`). Protobuf package `perkinlab`.
2. **Pote Mágico de platina** (client package `platinum`, m11). Shared code: `managers/PlatinumManager.as`, `mvc/module/platinum/PlatinumModel.as`, `mvc/controler/PlatinumControler.as`. Protobuf messages `cccactive.PlatinaCanOpMsg`, `PlatinaItemInfoMsg`, `PlatinaItemGainTipMsg` and `simple.PropertyMsg`.

## Overview

### Laboratório de Platina
A castle building (template 170101, client side building id -29) available after the first job transfer (`vocationGrades > 0`). The player owns 3 laboratories that research tattoo materials ("Material de tatuagem" 208101, "Material de tatuagem avançada" 208102) in 3 hour cycles; finished research is collected ("Coletar"). Players raid ("Saquear") the laboratories of 3 rival players (possibly from other servers) in a PvP battle (battleType 3851), 5 raids per day with a 30 minute cooldown; a win steals part of the rival's normal materials, gives laboratory experience and a winning streak bonus. Laboratory experience raises the laboratory level (10 levels, UpGrade Types 134) which raises the production per hour. A diary ("Diário do Laboratório") lists raids and defenses. The Fonte Mágica buffer 20 "Tatuagem" doubles lab rewards.

### Pote Mágico de platina
A timed event (top bar button "platinum", level 11+). The player breaks the "Pote Mágico de Ouro" with "Martelo Mágico de Ouro" (208530) 1 or 10 times to draw random items; a single draw may, and a 10 draw always, grant the chance to break the "Pote Mágico de platina" with "Martelo Mágico de Platina" (208531). The chance does not accumulate: any further draw consumes it. Lucky draws of all players and the player's own gains are listed.

## Entry points

| Entry | Condition | Opens | Source |
|---|---|---|---|
| Castle building 1701 "Laboratório de Platina" (client created building -29, template 170101) | `vocationGrades > 0`, else "Laboratório de Platina não ativado!" | `PerkinLabFrame` (controller `perkinlab`), research view | `decompiled/m4/scripts/castle/view/layer/CastleWalkLayer.as:262-272`, `decompiled/m4/scripts/castle/view/CastleBuildingView.as:389-397`, `decompiled/core_module/scripts/mvc/controler/BuildingControler.as:43-44` |
| Castle bubbles "lab gains" and "lab rob" | gains: `vocationGrades > 0` and a lab is ripe (`checkHasPick`); rob: raids left | same | `CastleWalkLayer.as:524-525,562-576` |
| Day guide item 69 | `vocationGrades > 0` else "Nível insuficiente, não é possível participar desse evento" | `PerkinLabFrame` | `decompiled/core_module/scripts/managers/DayGuideManager.as:871-872`, `decompiled/core_module/scripts/yishi/SwitchPageHelp.as:2474-2486` |
| Quest links (condition types 207 "Entrar no Laboratório de Platina", 208 "Saquear uma vez ...") | `vocationGrades > 0`; type 208 makes the raid button glow | `PerkinLabFrame` | `SwitchPageHelp.as:377-379,2195-2204`, `decompiled/m11/scripts/perkinlab/PerkinLabFrame.as:244-251` |
| Pequena Secretária task 6 (City) | `vocationGrades > 0`, a lab ripe, raids left | | `decompiled/core_module/scripts/mvc/module/secretary/SecretaryItemData.as:112-114` |
| Task trace tip type 1001 "Pesquisa do Laboratório concluída" button "Coletar" | server pushed tip (assumption) | `PerkinLabFrame` | `decompiled/core_module/scripts/managers/TaskTraceTipManager.as:851-852`, `decompiled/m16/scripts/tasktracetip/view/PerkinlabCanPickTipView.as:40-45` |
| Return from a lab battle (battleType 3851) | `isOpenPerkinLab` | `PerkinLabFrame` openType 1 (raid view) | `decompiled/core_module/scripts/battle/handler/BattleResultHandler.as:378-381`, `decompiled/m4/scripts/castle/CastleSceneView.as:155-158`, `decompiled/m3/scripts/map/space/SpaceSceneController.as:276-279` |
| Top bar button `platinum` (TopToolBtn 2063) | `thane.grades >= 11` and `PlatinumManager.openBottle` (push 213) | `PlatinumFrame` (controller `platinum`) | `decompiled/core_module/scripts/ui/toptoolbar/TopBtnCheckShowHelper.as:401-404`, `decompiled/core_module/scripts/ui/toptoolbar/TopToolsBar.as:1485-1486` |

## Modules

| Module | File | Scope |
|---|---|---|
| Research | [research.md](research.md) | 3 own laboratories, research cycle, harvest, laboratory level and experience, magic spring buffer, push 272 |
| Raid | [raid.md](raid.md) | rival list, refresh (gold and timer), raid battle 3851, cooldown purchase, daily count, winning streak, push 273 |
| Diary | [log.md](log.md) | raid and defense log (op 8, push 275) |
| Platinum pot | [platinum-pot.md](platinum-pot.md) | Pote Mágico event state (213), pools and chance (214), draws (9645 extend1 40), gain tips (215) |

## Protocol summary

| Dir | Opcode | Hex | Name | Module |
|---|---|---|---|---|
| C>S | 9566 | 0x255e | `C_PERKIN_LAB_CLIENT` (`PerkinLabClientMsg.op` 0..10) | research (0, 2, 3, 4), raid (1, 5, 6, 7, 9, 10), log (8) |
| S>C | 272 | 0x0110 | `U_C_PERKIN_LAB_SELF` | research |
| S>C | 273 | 0x0111 | `U_C_PERKIN_LAB_ROB` | raid |
| S>C | 275 | 0x0113 | `U_C_PERKIN_LAB_LOG` | log |
| S>C | 260 | 0x0104 | `U_C_PLAYER_EXTRA_FIELD_MSG` (field 12 winning streak, field 20 lab experience) | owned by hero, fields owned here |
| C>S | 9645 | 0x25ad | `C_CCCACTIVE_CLIENTOP` with header `extend1 = 40` | platinum-pot |
| S>C | 213 | 0x00d5 | `U_C_PLATINA_CAN_OPEN_STATE` | platinum-pot |
| S>C | 214 | 0x00d6 | `U_C_PLATINA_ACTIVE_INFO` | platinum-pot |
| S>C | 215 | 0x00d7 | `U_C_PLATINA_ACTIVE_ITEM_TIP` | platinum-pot |

Battle messages for raids (64, 157, 156, 153, 154, 4103) are owned by [battle](../battle/README.md).

## Dependencies

| Feature | Why |
|---|---|
| [hero](../hero/README.md) | `vocationGrades` gate; `DetailRspMsg` (rival details, same as "Ver Informações"); extra fields 260 |
| [castle](../castle/README.md) | building 1701 entry and castle bubbles |
| [battle](../battle/README.md) | raid PvP battle, battleType 3851 |
| [army](../army/README.md) | defender battle army snapshot (`ArmyMsg rival_battle_army`) |
| [fashion](../fashion/README.md) | tattoo system consumes 208101/208102 |
| [fantasy-bar](../fantasy-bar/README.md) | Fonte Mágica buffer 20 "Tatuagem" (+100% lab rewards, 8 h) |
| [currency](../currency/README.md) | gold for rival refresh, diamonds/bound diamonds for cooldown, `point` checks |
| [vip](../vip/README.md) | VIP cooldown privilege (free raid cooldown) |
| [inventory](../inventory/README.md) | rewards and hammer counts (bag type 1) |
| [shops](../shops/README.md) | quick buy of hammers 208530/208531 (ShopTempInfo 11001/11002) |
| [chat](../chat/README.md) | gain tips use chat content formatting (channel 21) |
| [quests](../quests/README.md) | condition types 207 and 208 |
| [secretary](../secretary/README.md) | task 6 shows raids left |
| [daily-activity](../daily-activity/README.md) | day guide item 69 |

## Suggested implementation order

1. [research.md](research.md): tables, op 0, harvest, level table, login push 272.
2. [raid.md](raid.md): rival selection, op 1 list, refresh, raid battle and result, cooldown, extra fields 12/20.
3. [log.md](log.md): log writes from the raid result, op 8.
4. [platinum-pot.md](platinum-pot.md): event config, 213/214 at login, draw handler, tips.
