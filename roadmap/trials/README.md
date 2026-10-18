# Trials ("Torres e provações")

Domain: PvE. Towers, trials and challenge maps that the player repeats daily or weekly for rewards. Client packages `warsoultower`, `lordtrial`, `crisis`, `timevortex`, `shadowland`, `demonland`, `skyboxroad`, `singlepass`, `rapidThrough`, `rapidthrouh`; proto packages `warsoultower`, `lordtrial`, `crisis`, `timevortex`, `skytrial` (and `demonroad`, which is used by the "Rua Mítica" in [roads](../roads/increasing-road.md)).

All traffic is socket based, except the Lord Trial ranking XML (`{TPL}lordtrial_unzip.xml`). PostgreSQL schema: `trials`. Rust handlers: `trials::<module>::handle_<action>`.

## Entry points

| Entry | Condition | Opens |
|---|---|---|
| Space ("Reino do Céu") NPC dialog options (`decompiled/m3/scripts/map/space/view/frame/DialogOptionItem.as:349-900`) | option 14 sky trial; 109/110 rapid through (level 36); 117 lord trial; 131 time vortex; 132 plane crisis; 134 demon land; 152 shadow land; 160 war soul tower | the module frames |
| Daily guide (`decompiled/core_module/scripts/managers/DayGuideManager.as:881-975`) | types 85 demon land, 86 time vortex, 87 lord trial, 94 shadow land | same openers |
| Queue bar (`decompiled/core_module/scripts/ui/queuebar/QueueBar.as:235-441`) | daily activity items: lord trial, time vortex, demon land, shadow land | controllers |
| `SwitchPageHelp` openers (`decompiled/core_module/scripts/yishi/SwitchPageHelp.as`) | changed job (lord trial, time vortex, demon land, war soul tower), holy class (shadow land), royalty level 10 and quest 1390 (war soul tower), `checkScene()` (not in a room scene), `VersionSwitch` flags | |
| Battle return (`decompiled/core_module/scripts/battle/handler/BattleResultHandler.as:330-526`, `decompiled/m3/scripts/map/space/SpaceSceneController.as:300-470`) | after battle types 3869, 3872..3875, 3880, 3897, 3905, 293 | reopen the module frame or scene |

## Modules

| Module | pt-BR | Content | Battle type |
|---|---|---|---|
| [war-soul-tower.md](war-soul-tower.md) | Torre da Guerra | 500 floor daily climb in one wave battle, first/repeat/stage rewards; 9709 / 530, 531 | 3905 |
| [lord-trial.md](lord-trial.md) | Julgamento Principal | weekly 3 difficulty x 30 floor trial with keys, HP carry, prayer cards, ranking XML, sweep; 9650 / 445 | 3869 |
| [plane-crisis.md](plane-crisis.md) | Plano de Crise | team node map exploration with action points, crystals and final boss; 9675 / 4867..4876 | 3877 |
| [time-vortex.md](time-vortex.md) | Vórtice do Tempo | dragon talker nodes, 45 conquerable positions with lairds and revenge, hourly cracks with team fights, sweep; 9664 / 4837..4842 | 3872..3875 |
| [shadow-land.md](shadow-land.md) | Terra Sombria | 5 continents x 2 difficulties x 6 checkpoints, energy, star chests, sweep; 9702 / 517 | 3897 |
| [demon-land.md](demon-land.md) | Continente dos Demônios | 30 chapters x 10 nodes with goddess tears, boss attack limits, star chests, plot dialogs, sweep; 9676 / 4879, 4878 | 3880 |
| [sky-trial.md](sky-trial.md) | Caminho do Céu | layered portal exploration with action and search points, skills, helper, boss; hidden stay points and ranking; 8636 / 4552, 4551, 4996, 459, 460 | 293 |
| [single-pass.md](single-pass.md) | Caminho do Paraíso (legacy) | dormant predecessor of the sky trial (listeners never registered) | 293 |
| [rapid-through.md](rapid-through.md) | Completar fase rapidamente | timed team campaign 4801 with 9 cooperative stages and ranking; 9633 / 405, 406 | campaign map |

## Shared mechanics and dependencies

- Sweeps ("Modo Bot") for lord trial (own ops), time vortex (`sweep_type 3`), demon land (4), shadow land (6) use the [mopup](../mopup/README.md) feature: 8528 `C_CAMPAIGN_SWEEP` / 4425 `U_C_CAMPAIGN_SWEEP` and frames `decompiled/m5/scripts/mopup/view/*Mopup*Frame.as` (openTypes 9..20, `decompiled/core_module/scripts/mvc/controler/MopupController.as:60-148`).
- Battles follow [docs/battle/server-engine.md](../../docs/battle/server-engine.md); waves and reinforcements (war soul tower), mirrors (time vortex lairds) and team battles (plane crisis, time vortex cracks) need the battle engine extensions.
- Team membership and invites: [team](../team/README.md) (`FreedomTeamManager`), used by plane crisis, time vortex cracks and rapid through.
- Player info opcode 3 `PlayerMsg` carries counters: `quickPassCount` (#140), `time_vortex_count` (#143), `time_vortex_node` (#144) ([hero](../hero/README.md)).
- Plot dialogs 4878 (demon land) share the format of [tutorial/plot-dialog.md](../tutorial/plot-dialog.md).
- Dragon Talker unlock (time vortex dragon nodes, 4842) feeds [dragon](../dragon/README.md).
- Royalty level gates (war soul tower) come from the royalty boss system; quests 1390 from the quest system.
- Related but not part of this feature: campaign trial buff shop 8582 `C_BUY_TRIAL` / 4467, 4468 and battle trial prop use 10507 `B_USE_TRIAL` (campaign and battle modules).

## Suggested implementation order

1. [shadow-land.md](shadow-land.md) and [demon-land.md](demon-land.md): simple single player progress, energy, chests; validate the battle start and reward pipeline.
2. [war-soul-tower.md](war-soul-tower.md): adds multi wave battles and battle quit (10497).
3. [lord-trial.md](lord-trial.md): weekly calendar, HP carry, prayers, sweep scheduler, ranking XML.
4. [sky-trial.md](sky-trial.md): scene based exploration with events.
5. [time-vortex.md](time-vortex.md): requires mirror battles, shared world state (lairds), schedulers and team flows.
6. [plane-crisis.md](plane-crisis.md) and [rapid-through.md](rapid-through.md): real time team sessions.
7. [single-pass.md](single-pass.md): nothing to implement (keep dormant).
