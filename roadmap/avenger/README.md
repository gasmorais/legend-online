# Vingador (Avenger)

Feature slug `avenger`, domain `character`. Client packages `avenger` (`decompiled/m5/scripts/avenger/*`) and `mvc.module.avenger` (`decompiled/core_module/scripts/mvc/module/avenger/*`); protobuf package `avenger` (`protocol/proto.json`, AS classes in `decompiled/core_module/scripts/com/road/yishi/proto/avenger/*`).

Conventions used in every file of this folder:
- Paths are relative to `decompiled/` unless they start with `raw/`, `protocol/`, `index/`, `docs/` or `build/`.
- `CM/` = `core_module/scripts/`, `M5/` = `m5/scripts/`, `M14/` = `m14/scripts/`, `M10/` = `m10/scripts/`, `M3/` = `m3/scripts/`.
- Opcode names come from `protocol/opcodes.csv`. Proto field tags were checked against the AS `writeTo` methods (cited per message).
- *(assumption)* marks anything the client code does not prove.
- pt-BR strings are quoted verbatim from `index/language.json`.

## 1. What the feature is for the player

"Vingador" is the third job advancement of the hero ("Deificação", `vocationIndex >= 3`, `CM/yishi/datas/playerinfo/SimplePlayerInfo.as:1264-1267`). Once a hero is deified, a dedicated frame titled "Vingador" (`AvengerFrame.title.text`) gives five progression tabs on top of the hero:

| Tab (index) | pt-BR concept | What the player does | Module |
|---|---|---|---|
| 0 | Habilidades de Julgamento (skill tab) | Picks which 2 of the 6 avenger skills are in the battle formation ("Formação"), feeds "Pedra de Julgamento" stones into each skill for stats and evolves skills from Nv.1 to Nv.10 | [skills.md](skills.md) |
| 1 | Espírito da Vingança / Corpo do Julgamento (body tab) | Feeds "Cristal da Vingança" to raise the body grade 0..220 (21 degrees of 11 stars) for flat attack, defense, magic defense and HP | [body.md](body.md) |
| 2 | Olhos da Verdade (eye tab) | Read-only: the job-title level (vocation grade) sets the battle skill swap cooldown | [core.md](core.md) |
| 3 | Armadura Mítica (devil armor tab) | Polishes the armor (grades 1..10, opens up to 6 "Buraco Mítico"), carves holes (grades 1..20) and inlays "Esfera Mítica" pearls; pearls are decomposed in the smith | [devil-armor.md](devil-armor.md) |
| 4 | Lâmina do Espírito de Proteção (child sword tab) | Levels a sword per guardian child, spends points on life/defense/attack, ascends stages, learns sword skills. **Hidden in this build** (`VersionSwitch.CHILD_NS = false`) | [child-sword.md](child-sword.md) |

In battle, an avenger hero gets an extra skill bar: 2 active avenger skills (keys B and N) paid with a separate "avenger SP" gauge (max 70), plus a standby panel (key M) to swap skills under a cooldown ([battle.md](battle.md)).

## 2. Entry points and unlock conditions

| Entry point | Condition | Source |
|---|---|---|
| NPC dialog option type 146 (deification) sends **8658 C_THIRD_TRANSFER** | Option shown only when task 1943 is finished and the hero is not yet an avenger | `M3/map/space/view/frame/SpaceDialogFrame.as:327-333`; `CM/yishi/manager/PlayerManager.as:2102-2106, 2216-2224`; `M3/map/space/view/frame/DialogOptionItem.as:833-839` |
| Main toolbar, child button of the star (astrology) button | `VersionSwitch.AVENGER && thane.isAvenger`; locked tip "Liberado após a deificação" | `CM/ui/maintoolbar/MainToolBar.as:1055, 1076, 1523-1541`; `CM/ui/maintoolbar/constant/MainToolCheckBtnOpen.as:68-69, 175-176` |
| Hotkey **X** | not in battle or vehicle, keys enabled, no text input focused, `AVENGER` switch, `isAvenger` | `CM/yishi/keyboard/KeyBoardRegister.as:178-179, 1086-1118` |
| Task "go to" links (task condition types 246, 247, 248-251, 255-259) | `AVENGER` switch and `isAvenger`, else "Esta função ainda não foi ativada" | `CM/yishi/SwitchPageHelp.as:458-488, 2889-2909` |
| Player info of another player, buttons 9 ("Verificar Vingador") and 10 ("Armadura Mítica") | target `isAvenger` and has avenger data | `M5/playerinfo/PlayerInfoFrameII.as:1398-1402, 1427-1445` |
| Smith, decompose tab "Vingador" (pearl decomposition) | `VersionSwitch.AVENGER`; tab enabled only when `isAvenger` | `M14/store/NewResolveView.as:65-79` |

Feature switches (`CM/yishi/datas/VersionSwitch.as`): `AVENGER = true` (:144), `DEVIL_ARMOR = true` (:200), `CHILD_NS = false` (:202), `AVENGER_CAST_SUN = true` (:182, smith mould cap, not this feature).

## 3. Modules

| Module | File | Routes | Server messages (dedicated) | Tables |
|---|---|---:|---:|---:|
| Core: deification, frame, data sync, Olhos da Verdade, inspection, shared avenger fields | [core.md](core.md) | 2 | 1 (4588) | 1 |
| Espírito da Vingança / Corpo do Julgamento | [body.md](body.md) | 1 | 0 (4588 opType 4) | 0 (uses `avenger.profiles`) |
| Habilidades de Julgamento | [skills.md](skills.md) | 3 | 0 (4588 opType 1..3) | 2 |
| Armadura Mítica | [devil-armor.md](devil-armor.md) | 4 | 0 (4588 opType 5..7, virtual bag 211/212) | 3 |
| Battle skill bar | [battle.md](battle.md) | 1 | 2 (4589, 4591) | 0 |
| Lâmina do Espírito de Proteção (disabled) | [child-sword.md](child-sword.md) | 5 | 1 (4276) | 2 |
| **Total** | | **16** | **4** | **8** |

All feature requests share one opcode, **8657 (0x21d1) C_AVENGER_CLIENT_OP**, with `com.road.yishi.proto.player.PlayerOpMsg`; the operation is `op (#1)`. Op constants: `CM/mvc/module/avenger/AvengerConstClass.as:6-32` (0 GET_AVENGER_DATA, 1 SKILL_SET_FIGHT, 2 PROMOTE_SKILL, 3 EVOLVE_SKILL, 4 UPGRADE_BODY, 5 DEVIL_ARMOR, 6 DEVIL_ARMOR_HOLE, 7 DEVIL_ARMOR_EQUIP, 8 PROP_RESOLVE, 9 OP_SPIRIT_UPGRADE, 10 OP_SPIRIT_UPGRADE_STAGE, 11 OP_SPIRIT_UPGRADE_ATTR, 12 OP_SPIRIT_LEARN_SKILL, 13 OP_SPIRIT_UPGRADE_SKILL). The other two requests are 8658 (deification, empty body) and 10521 (battle skill swap).

The protobuf package `avenger` also contains `DarkMazeMsg` and `DarkMazeChildMsg`. They are used only by `CM/managers/DarkMazeManager.as` (opcodes 4278, 4590, 8662) and belong to [../mazes/README.md](../mazes/README.md), not to this feature.

## 4. Dependencies on other features

| Feature | Why |
|---|---|
| [../hero/README.md](../hero/README.md) | Job advancement: `vocationIndex` (3 = avenger, 4 = holy), `vocationGrades` and vocation GP drive the deification, the Eye tab and the swap cooldown; the self `ArmyMsg.avenger_grade (#43)` is delivered in 150 U_C_SERIAL_ARMY; 4125 U_C_BAG_EQUIPLOOK (`DetailRspMsg.avengerInfo #24`) for player inspection |
| [../battle/README.md](../battle/README.md) | Avenger fields in `HeroMsg` (#106-#111) inside 157 U_B_PREPARE, skill use 10008, SP pushes 4589, skill bar 4591 |
| [../inventory/README.md](../inventory/README.md) | Main bag counts for "Cristal da Vingança" 5010001 and "Pedra de Julgamento" 5001xxx/5002xxx/5003xxx; generic virtual bag pushes 211/212 (bagType 3 is the avenger armor bag; 5 and 6 belong to theseus) |
| [../smith/README.md](../smith/README.md) | Pearl synthesis (compose types 16, 104, 111..156) and the decompose UI (`AvengerRosolveView`) that sends 8657 op 8 |
| [../guardians/README.md](../guardians/README.md) | Child list, child jobs and the nursing spirit model used by the (disabled) child sword tab; the guardians feature has its own parallel sword UI (`M14/child/nursingspirit/ChildNSFrame.as`) |
| [../quests/README.md](../quests/README.md) | Task condition types 236-238, 246-251, 255-259 read avenger state (`CM/mvc/module/task/TaskTemplate.as:296-330, 842-884, 1321-1564`) |
| [../rankings/README.md](../rankings/README.md) | Ranking XML embeds `<AvengerInfo>` per hero (`CM/mvc/controler/SortController.as:480-529`) |
| [../theseus/README.md](../theseus/README.md) | Shares the virtual bag mechanism (bagTypes 5 and 6) and the resolve UI |
| [../roads/README.md](../roads/README.md) | "Caminho da Vingança" (revenge road) produces "Cristal da Vingança" 5010001 (item description); task condition 239 reads the revenge road node |
| [../shops/README.md](../shops/README.md) | `DemonRoadSolveFrame` reads "Pedra fundida de ouro" 6930001 from the avenger armor bag (`m15/scripts/view/subshop/DemonRoadSolveFrame.as:96-98`) |
| [../mazes/README.md](../mazes/README.md) | Owns `DarkMazeMsg`/`DarkMazeChildMsg` of the `avenger` proto package |

## 5. Suggested implementation order

1. **core.md**: tables `avenger.profiles`, deification 8658 (creates the profile, the 6 skills, the armor and the 6 holes), 8657 op 0 and the 4588 full sync, `avenger_grade` in `ArmyMsg`/`RoomPlayerMsg`/`TeamPlayerInfoMsg`, login push.
2. **body.md**: op 4 (simple feed and level loop); push 150 with the new `avenger_grade`.
3. **skills.md**: ops 1, 2, 3; skill stats aggregation into the hero.
4. **devil-armor.md**: virtual bag type 3 (211/212), ops 5, 6, 7, then op 8 (decompose) together with the smith UI.
5. **battle.md**: `HeroMsg` avenger fields, avenger SP economy, 4589/4591 and 10521 swap with cooldown from the Eye.
6. **core.md** inspection: `DetailRspMsg.avengerInfo` in 4125.
7. **child-sword.md**: only if `CHILD_NS` is turned on (or if the guardians feature reuses opcode 4276 data).
