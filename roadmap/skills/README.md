# Skills and talents (Habilidades e talentos)

Feature slug: `skills`. Domain: character. PostgreSQL schema: `skills`. Rust module: `skills`.

## Overview

The hero (lord, `ThaneInfo`) has four progression trees that all live in the frame `armyII.SkillFrame` ("Habilidade"):

| Tree | pt-BR | What the player does | Module |
|---|---|---|---|
| Class skills | "Habilidade" | Spends skill points to learn and raise class skills (`SkillTempInfos` MasterType 1/2/3, 421-423 after job transfer), resets them, buys a second skill set ("Conjunto de habilidades {0}") and switches between sets | [hero-skills.md](hero-skills.md) |
| Skill bar | fast keys 1..5 | Drags learned active skills to the 5 battle slots; the string is sent to the server and replayed at battle start | [skill-bar.md](skill-bar.md) |
| Talents | "Dom Natural" | Raises the talent level with gold and hero EXP (or "Pedra do Dom Natural Básico"), spends talent points on the 9 basic talents and the 5 advanced talents, resets them; after job transfer the talent tree is replaced by a 7-talent tree paid with diamonds or "Pedra do Dom Natural" | [talents.md](talents.md) |
| Runes | "Runa" | Learns runes with rune stones (items SonType 302), feeds runes with items to gain rune EXP, promotes runes to the next tier, carries up to 2 runes on the Z/X battle slots | [runes.md](runes.md) |
| Rune sockets and rune gems | "Runas" (stone tab), "Escultura de slot de runa", "Mochila de Runas" | Draws rune gems with rune energy or diamonds, sockets them into rune holes, engraves new hole sets, strengthens and decomposes gems. Disabled in the BR build (`VersionSwitch.RUNE_STONE = false`) | [rune-stones.md](rune-stones.md) |

The halo animation `armyII.viewII.skill.HaloView` is a job transfer visual, documented in [../hero/README.md](../hero/README.md) (job change). Guild skills are a separate system: [../guild/skills.md](../guild/skills.md).

## Entry points

| Entry | Condition | Opens | Citation |
|---|---|---|---|
| Main toolbar skill button | always (button type 4) | `ArmyControler.startFrameByType(SKILL_PANEL)` → `army.SkillFrame` tab 0 | `decompiled/core_module/scripts/ui/maintoolbar/MainToolBar.as:2212-2223`, `decompiled/core_module/scripts/mvc/controler/ArmyControler.as:105-110` |
| Keyboard `S` | not in battle or vehicle, no text input focused, `newbieProcess > 19000` | same | `decompiled/core_module/scripts/yishi/keyboard/KeyBoardRegister.as:130-131`, `:321-348` |
| Tips bar / task links | | `SKILL_PANEL`, optionally with tab index 1 (runes) or 2 (talents) | `decompiled/core_module/scripts/mainBar/TipsBar.as:113`, `decompiled/core_module/scripts/yishi/SwitchPageHelp.as:1521`, `:1848`, `:1864` |
| Frame tabs | Skill: always. Rune: hero level >= 35 (`OpenRuneGrade`). Talent: hero level >= 50. Equipe (line-up, army feature): level >= 11. Rune gems: `thane.runeStoneOpen && VersionSwitch.RUNE_STONE` | | `decompiled/m5/scripts/armyII/SkillFrame.as:145-205`, `:592-695` |

Tab buttons show a red counter: skill points, talent points (or advanced talent points), and `InfoTipsManager` key 16 for runes (`decompiled/m5/scripts/armyII/SkillFrame.as:216-242`).

## Modules

| Module | File | Routes | Server messages | Tables |
|---|---|---:|---:|---:|
| Hero skills | [hero-skills.md](hero-skills.md) | 4 | 3 | 3 |
| Skill bar | [skill-bar.md](skill-bar.md) | 1 | 1 | 0 (column in `skills.skill_sets`) |
| Talents | [talents.md](talents.md) | 3 | 5 | 2 |
| Runes | [runes.md](runes.md) | 4 | 3 | 2 |
| Rune sockets and gems | [rune-stones.md](rune-stones.md) | 8 | 4 | 2 |

## Shared protocol facts

- All handlers are registered by `ArmyManager.initEvent` only after the first 150 `U_C_SERIAL_ARMY` arrives (`decompiled/core_module/scripts/yishi/manager/ArmyManager.as:152-179`, `:211-216`). The server must send 150 at login before any skill push.
- The hero record is pushed with 113 `U_C_HERO_INFO` (`SimpleHeroInfoMsg`, read by `ThaneInfoHelper.readHeroInfo`, `decompiled/core_module/scripts/com/road/pb/helper/army/ThaneInfoHelper.as:161-460`). Skill points, skill script, fast key, skill set index, double skill flag, talent points/levels/scripts and runes all travel in it. The message is documented in [../hero/attributes.md](../hero/attributes.md).
- Warning: `readHeroInfo` writes `fight_pos` and all resistance fields without `has*` guards (`ThaneInfoHelper.as:443-452`). Every 113 must carry them, otherwise they reset to 0 on the client.
- Opcodes 5184, 5185, 5167, 64, 8605 and 4495 are missing from `protocol/opcodes.csv`; their names come from `decompiled/core_module/scripts/yishi/datas/consant/ProtocolType.as:312-320` and `AcceptProtocolType.as:318-320`.

## Dependencies

- [../hero/README.md](../hero/README.md): hero level (`grades`), hero EXP (`gp`), class (`Job`), job transfer (`isChangeJob`, `vocationIndex`, `vocationGrades`) and 113 `U_C_HERO_INFO`.
- [../army/README.md](../army/README.md): `ArmyManager`/`ArmyControler` shell, the "Equipe" tab of `SkillFrame` (line-up).
- [../inventory/README.md](../inventory/README.md): items consumed (rune stones SonType 302, 3020010, 3021001, 212012, 208053, 10000000, 10010000), bag moves 5005, bag pushes, rune gem bags 40/41.
- [../currency/README.md](../currency/README.md): gold, diamonds (`point`) and bound diamonds (`giftToken`).
- [../battle/README.md](../battle/README.md): skill use in battle (10008/75), fast keys, rune slots, trigger skills.
- [../returning-players/README.md](../returning-players/README.md): King Contract buff 9 makes skill and talent resets free.

## Suggested implementation order

1. Templates loader for `SkillTempInfos`, `RuneTempInfos`, `UpGradeTempInfos` (types 21, 38, 112), `ConfigInfos`.
2. [hero-skills.md](hero-skills.md): skill state in 113, learn/upgrade (5185 → 60), reset (5184 → 61).
3. [skill-bar.md](skill-bar.md): 5167 → 64, and the 64 push before every battle.
4. [talents.md](talents.md): 5187 → 4430/4431, talent points via 5185/5184.
5. Double skill set (8479, 8480) from [hero-skills.md](hero-skills.md).
6. [runes.md](runes.md): 8605 op types 1..4 → 4495, 4527.
7. [rune-stones.md](rune-stones.md) only if `RUNE_STONE` is enabled in the client build.
