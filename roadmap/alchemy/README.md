# Fábrica de Alquimia (`alchemy`)

Domain: economy. Client package `alchemical` (m14: `AlchemicalFrame`, `AlchemicalExploitView`, `AlchemicalMineItem`, `AlchemicalMakeView` and `makeview/*`) plus shared code in `core_module`: `yishi/manager/AlchemicalManager.as`, `mvc/module/alchemical/*`, `mvc/controler/AlchemicalController.as`, templates `yishi/datas/templates/AlchemicalMineTempInfo.as`, `AlchemicalFormulaTempInfo.as` and their cates, chat link code in `chat/utils/ChatFormat.as` and `chat/view/ChatOutputViewII.as`. Protobuf package `alchemyworkshop`.

## Overview

The "Fábrica de Alquimia" (Alchemy Workshop) is a job advanced (post "transferência de profissão") economy system with two tabs:

1. **Exploração** (mines). Six mines ("Minas de Einherjar", "Minas de Romã", "Benitoíta", "Corindon", "Mina de Metal", "Mina de Ouro") produce one ore every `Speed` seconds up to `MaxCount`. The player harvests ("colher") the stored ores into a private alchemy storage, or pays diamonds to fill a mine at once ("adição de velocidade", 5 per day). Mines unlock and upgrade (4 grades) with Alchemy Points ("Pontos de Alquimia").
2. **Fabricar** (formulas). Fifty formulas in six reward categories ("Equipamento", "Brasão Sagrado", "Arma Divina", "Titã", "Arma Sagrada", "Proteção da Alma") turn ores into real items and Alchemy Points. Formulas are either "Combinação Singular" (solo, Type 2) or "Combinação em grupo" (group, Type 1: 3 or 4 steps, each done by a different player within 12 hours). A "Catalisador Misterioso" (701000) can be added to a step to get a chance to double the output.

Alchemy Points (item id 700000, cap 285000) unlock formulas (`NeedScore`), mine grades (`NeedScore`) and level rewards (UpGrade Types 139: catalysts and two titles). After the cap, a daily "cycle score" grants 3 catalysts every 20000 points.

## Entry points

| Entry | Condition | Opens | Source |
|---|---|---|---|
| Sky realm (city) NPC node 8, dialog option 112 | `VersionSwitch.ALCHEMY_WORKSHOP` (true); `thane.vocationGrades > 0` else "Após elevar a profissão poderá liberar" | `AlchemicalFrame` (controller `alchemical`) | `decompiled/m3/scripts/map/space/mediator/mapview/SpaceUIMediator.as:98`, `decompiled/m3/scripts/map/space/view/frame/DialogOptionItem.as:148,761-763`, `decompiled/core_module/scripts/yishi/SwitchPageHelp.as:2245-2254` |
| Day guide item 75 | same check | `AlchemicalFrame` | `decompiled/core_module/scripts/managers/DayGuideManager.as:899-900` |
| Chat invite link (cell type 117) | scene is `CASTLE_SCENE` or `SPACE_SCENE` | `AlchemicalFrame`, tab Fabricar, cooperation list with the shared formula selected | `decompiled/core_module/scripts/chat/view/ChatOutputViewII.as:258-265`, `decompiled/core_module/scripts/yishi/manager/AlchemicalManager.as:153-159,236-243` |
| Daily quest 184 "Missão Diária de Alquimia" (condition type 64 "Completar Alquimia" x3, level 50+) | quest feature | link to the frame | `raw/xml/tempinfos/QuestTemps.xml`, `QuestCondictionInfos.xml` |

The frame sends the open request in its constructor (`decompiled/m14/scripts/alchemical/AlchemicalFrame.as:33-39`).

## Modules

| Module | File | Scope |
|---|---|---|
| Workshop core | [core.md](core.md) | open (op 0), the single response/push 461, alchemy storage, Alchemy Points, score levels (Types 139), cycle score, daily reset |
| Mines | [mines.md](mines.md) | six mines, production formula, harvest (op 1), speed-up (op 5), mine unlock and upgrade (push op 6) |
| Formulas | [formulas.md](formulas.md) | notebook, solo formulas and starting a group formula (op 2), catalysts and doubling, rewards |
| Cooperation | [cooperation.md](cooperation.md) | shared group formulas: list, join a step (op 3), chat invite (op 4), open by invite (op 8), expiry and completion |

## Protocol summary

All traffic uses one request and one response opcode with the same message `AlchemyWorkshopMsg`, discriminated by `op` (`AlchemyWorkshopOp`).

| Dir | Opcode | Hex | Name | `op` values |
|---|---|---|---|---|
| C>S | 9661 | 0x25bd | `C_ALCHEMY_WORKSHOP_OP` | 0 OPEN, 1 REAP, 2 PRODUCE, 3 SHARE_PRODUCE, 4 INVITE, 5 SPEED_UP, 8 OPEN_BY_INVITE |
| S>C | 461 | 0x01cd | `U_C_ALCHEMY_WORKSHOP_OP` | echo of the request op, plus server pushes 6 UPDATE_MINE and 7 UPDATE_ITEM |

Other messages: chat element `t="117"` inside a system chat message (owned by [chat](../chat/README.md)); bag and currency pushes for real item rewards and diamond costs.

## Dependencies

| Feature | Why |
|---|---|
| [hero](../hero/README.md) | `vocationGrades > 0` gate; score levels 17 and 32 have `TemplateId` 2 with `ActiveObject` 308 and 309 (level 32 text promises the title "Mestre da Alquimia"); no `AppellInfos.xml` record has these ids (open question in core.md) |
| [sky-realm](../sky-realm/README.md) | city NPC node 8 entry |
| [chat](../chat/README.md) | invite broadcast (cell type 117) and click handler sending op 8 |
| [friends](../friends/README.md), [guild](../guild/README.md) | likely audiences of the invite broadcast (assumption, see cooperation.md) |
| [inventory](../inventory/README.md) | formula rewards are normal bag items (2129838, 212018, 208054, ...) |
| [currency](../currency/README.md) | diamonds ("point") for the speed-up |
| [quests](../quests/README.md) | condition type 64 (alchemy completions) |
| [seasonal-events](../seasonal-events/README.md) | `FunnyConditionType.ALCHEMY` = 21 counts alchemy for "Destaques" events |
| [daily-activity](../daily-activity/README.md) | day guide item 75 |

## Suggested implementation order

1. Templates loader: `AlchemyMineTemplates.xml`, `AlchemyFormulaTemplates.xml`, UpGrade Types 139, `ConfigInfos` keys `alchemyworkshop_*`, items SonType 701/702.
2. [core.md](core.md): tables, op 0 full snapshot, storage, score and level rewards, daily reset.
3. [mines.md](mines.md): harvest and speed-up, mine unlock and upgrade on score change.
4. [formulas.md](formulas.md): solo formulas, rewards, catalyst doubling.
5. [cooperation.md](cooperation.md): group formulas, join, invites, expiry job.
