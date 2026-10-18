# Hero, attributes and information (Herói, atributos e informações)

Feature slug: `hero`. Domain: character. PostgreSQL schema: `hero`. Rust module: `hero`.

## Overview

The hero ("Líder", `ThaneInfo`) is the player's avatar in battle. This feature covers what the hero *is* and how the player inspects it:
- level, EXP, class, attributes and derived combat stats, pushed by the server (113 `U_C_HERO_INFO`, 3 `U_C_PLAYER_INFO`); the client computes nothing authoritative;
- information screens: own hero frame ("Equipamentos" / "Informações": portrait, rename, SNS profile, honor), attribute detail ("Atributos"), and "Ver Informações" for any other player;
- titles ("Título", `AppellInfos`);
- job transfer ("elevação da profissão", vocation levels, Avenger and Holy stages, branch switch);
- potential ("Potencialidades", disabled in BR: `VersionSwitch.PROFICIENCY = false`);
- the vice hero protocol (`viceplayer`, no client sender) and the secondary password / item lock ("Bloqueio de Itens", `VicePasswordMsg`).

## Entry points

| Entry | Condition | Opens | Citation |
|---|---|---|---|
| Key `B`, toolbar hero button | | `armyII.ArmyFrameII` tab "Equipamentos" (`EQUIP_PANEL`) | `decompiled/core_module/scripts/yishi/keyboard/KeyBoardRegister.as:109-110`, `:291-318` |
| Hero frame tab "Informações" | hero level >= 10 ("Função habilitada no Nv. {0}") | `INFORMATION_PANEL` → `armyII.viewII.information.InformationView` | `decompiled/m5/scripts/armyII/ArmyFrameII.as:319`, `:352-355`, `:958-965` |
| Attribute "Detalhes" link | | `playerinfo.view.ThaneAttributeFrame` "Atributos" | `decompiled/m5/scripts/playerinfo/view/PlayerAttributeView.as:70`, `decompiled/m5/scripts/armyII/ArmyFrameII.as:675-713` |
| Player menu "Ver Informações" (chat, rankings, map) | any player | `playerinfo.PlayerInfoFrameII` | `decompiled/m5/scripts/playerinfo/PlayerInfoFrameII.as:183-186` |
| Title combo / "Modificar de Título" | | `appell.AppellFrame` "Título" | `decompiled/m5/scripts/playerinfo/view/PlayerAttributeView.as:180-207` |
| NPC dialog option 104 (Sky realm) | | `changeJob.ChangeJobFrame` | `decompiled/m3/scripts/map/space/view/frame/DialogOptionItem.as:678-679` |
| Potential (Avenger only, switch off) | `VersionSwitch.PROFICIENCY && thane.isAvenger` | `proficiency.ProficiencyFrame` | `decompiled/core_module/scripts/yishi/SwitchPageHelp.as:2879-2887` |
| Item lock / password buttons in the hero frame | hero level >= 10 | `vicepassword` controller | `decompiled/m5/scripts/armyII/ArmyFrameII.as:568-651` |

## Modules

| Module | File | Routes | Server messages | Tables |
|---|---|---:|---:|---:|
| Attributes, level and stats | [attributes.md](attributes.md) | 2 (legacy) | 4 | 2 |
| Information screens and player lookup | [info-screens.md](info-screens.md) | 6 | 5 | 1 |
| Titles | [titles.md](titles.md) | 2 | 3 | 1 |
| Job transfer and vocation | [job-change.md](job-change.md) | 2 | 3 | 1 |
| Potential | [proficiency.md](proficiency.md) | 3 | 1 | 1 |
| Vice hero, secondary password and item lock | [vice-player.md](vice-player.md) | 3 | 2 | 2 |

## Protocol package ownership

- `army.SimpleHeroInfoMsg` (113) is the hero record: [attributes.md](attributes.md). Skill/talent/rune fields are described in [../skills/README.md](../skills/README.md).
- `player` package: hero-relevant messages are `PlayerMsg` (3, hero fields only), `AppellExchangeMsg`, `AppellsMsg`, `AppellInfoMsg`, `AppellReachMsg` (no reader), `PlayerRenameReqMsg`, `PlayerRenameRspMsg`, `VicePasswordMsg`, `LockAndUnlockMsg`, `PlayerOpMsg` (proficiency op), `CommonMsg` (as used by the dragon soul awaken, see army). The other `player` messages are owned by the features that use them: `KingContract*` ([../returning-players/README.md](../returning-players/README.md)), `MagicSpring*` ([../fantasy-bar/README.md](../fantasy-bar/README.md)), `Challenge*` ([../arena/README.md](../arena/README.md)), `Login*`, `Version*`, `TimeZone*`, `SystemProperty*`, `PlayerDataMsg` ([../account/README.md](../account/README.md)), `PlayerTokenInfoMsg`, `TokenInfoMsg` ([../currency/README.md](../currency/README.md)), `Artifact*`, `Armory*`, `ResonatePosMsg` ([../divine-weapon/README.md](../divine-weapon/README.md)), `DaySignInfoMsg`, `TakeLoginReward` ([../daily-activity/README.md](../daily-activity/README.md)), `MailCheckMsg` ([../customer-service/README.md](../customer-service/README.md)), `PlayerAAS*` (anti-addiction, account), `AdditionMsg`, `RateUpdate*`, `EffectRemoveReqMsg` (buffs, [../battle/README.md](../battle/README.md)), `PayTypeMsg` (generic payment selector used by many features).
- `changejob.ChangePlayerInfoMsg`: [job-change.md](job-change.md).
- `viceplayer.ViceHeroOpMsg`: [vice-player.md](vice-player.md).
- `watch` (`HeroWatchMsg`, `HeroWatchOpMsg`, `WatchInfoMsg`): the battle guard, documented in [../army/battle-guard.md](../army/battle-guard.md) because its screen lives in `armyII`.

## Dependencies

- [../army/README.md](../army/README.md): `ArmyManager` owns the hero object (`army.baseHero`), 150 `U_C_SERIAL_ARMY` carries the first hero record.
- [../skills/README.md](../skills/README.md): skill, talent and rune fields of 113; job transfer resets the trees.
- [../fashion/README.md](../fashion/README.md): avatar fields of 113/150, tattoos (job transfer requirements use tattoo attributes).
- [../inventory/README.md](../inventory/README.md): equipment shown on the hero, rename card 208018, item lock.
- [../friends/README.md](../friends/README.md): SNS profile messages (15033, 15036, 4239).
- [../avenger/README.md](../avenger/README.md): vocation index 3 (Avenger) and potential.

## Suggested implementation order

1. [attributes.md](attributes.md): 113 and the hero fields of 3, stat computation service.
2. [info-screens.md](info-screens.md): rename, portrait, lookup of other players (8199 → 4125).
3. [titles.md](titles.md).
4. [job-change.md](job-change.md) (needs tattoos and the vocation EXP tracks).
5. [vice-player.md](vice-player.md) secondary password and item lock.
6. [proficiency.md](proficiency.md) only if the switch is enabled.
