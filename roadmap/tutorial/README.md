# Tutorial e novato

Domain: account. Slug `tutorial`. PostgreSQL schema `tutorial`. Rust handlers `tutorial::<module>::handle_<action>`.

Conventions: paths are relative to the repository root; AS3 citations use `decompiled/<module>/scripts/<path>.as:<line>`; "C>S" is a `send` opcode, "S>C" an `accept` opcode from `protocol/opcodes.csv`; protobuf fields are `name (#tag, TYPE)` from `protocol/proto.json`; "Assumption" marks behavior that the client code does not show.

## What it does for the player

A new hero goes through a scripted introduction before the normal game opens up:

1. Character creation and name selection (owned by [account](../account/README.md)) store novice process 10000.
2. The first login sends the hero into the training campaign "Monte do Dragão Divino" (campaign 10002, `raw/xml/tempinfos/Campaigns.xml`), a forced sequence of masks, arrows, NPC walks, dialogs ("Clique para continuar({0})") and two guided battles that teach the first skills ("Clique na Habilidade para usá-la").
3. A movie flies the hero to the castle, a guided collection battle runs, the castle buildings and queues are initialized, and further forced clicks teach the castle, the barracks ("Clique no Quartel para abrir a janela do Quartel", "Clique em Recrutar para recrutar soldados") and the campaign selection ("Clique na Campanha para entrar no mapa de Campanha").
4. After that (novice process >= 25000) the tutorial becomes level and quest driven: at hero levels 12, 13, 15, 16, 18, 50 and 70, and when quest 1912 is done, a short guide highlights a newly opened function ("Aberuta da nova função [Guilda]", "[Montaria]", "[Astrologia]", "[Einherjar]", "Abertura da nova função [Arma Divina]", "[Espírito de Proteção]").
5. Server pushed story dialogs ("game plot") appear in campaigns, the castle and battles, with portraits, typewriter text and auto advance.

Side systems grouped in this feature:

- "Objetivo dos 7 dias" (seven day objectives, `guidetask`): a 7 tab frame of daily goals with rewards. The UI exists but no opcode feeds it in this client build.
- "Como obter Ouro?" style game guide (`gameguide`): a static "where to get X" list with "Ir Agora" shortcuts. The view is never instantiated in this build.
- Step templates (`U_C_STEP_MSG` 321, "阶段模板数据"): server sent stage thresholds consumed by the Arma Divina gift activity progress bar.

## Entry points

| Entry | Condition | Source |
|---|---|---|
| Login state push 6 with a normal state and `noviceProcess < 19000` | client sends 5127 to enter the training campaign | `decompiled/core_module/scripts/yishi/manager/BaseManager.as:1941` |
| `NewbieManager.start()` after every login state push | runs the next scripted node | `decompiled/core_module/scripts/yishi/manager/BaseManager.as:1961`, `decompiled/core_module/scripts/dialog/utils/NewbieManager.as:48` |
| Hero level up (`LEVEL_COMMIT`) at 12, 13, 15, 16, 18, 50, 70 | `noviceProcess >= 25000` | `decompiled/core_module/scripts/dialog/utils/NewbieModel.as:65`, `decompiled/core_module/scripts/ui/resourcebar/view/ResourceView.as:614` |
| Quest commit (`TASK_COMMIT`) of quest 1912 | `noviceProcess >= 25000` | `decompiled/core_module/scripts/dialog/utils/NewbieModel.as:96`, `decompiled/core_module/scripts/yishi/manager/TaskManage.as:257` |
| Mini map "skip tutorial" button (`smallMap.NoviceCloseBtn`), "Pular tutorial?" | visible only on maps 10001 and 10002 | `decompiled/core_module/scripts/mainBar/SmallMapBar.as:562`, `:898` |
| Mini map "Objetivo dos 7 dias" button | visible when the seven day status is 1 | `decompiled/core_module/scripts/mainBar/SmallMapBar.as:241`, `:523` |
| Server push 138 `U_C_GAME_PLOT` or 171 `U_C_BATTLE_TALK` | any time, scene filtered | `decompiled/core_module/scripts/yishi/manager/BaseManager.as:298`, `decompiled/core_module/scripts/yishi/service/managers/SocketManager.as:148` |
| First QTE skill shown in the skill frame | `PlayerMsg.qte_guide == 0` | `decompiled/core_module/scripts/yishi/view/guild/QteSkillGuide.as:28` |

## Modules

| Module | File | Summary |
|---|---|---|
| Novice process | [novice-process.md](novice-process.md) | The `novice_process` value: lifecycle, save (5017), login routing (5127, forced 36000), jump to level 40 (8871), skip tutorial servlet, every client gate on the value |
| Guided steps | [guided-steps.md](guided-steps.md) | `NewbieManager` script engine (m8 nodes), masks, arrows and forced clicks, the server calls the script makes (node arrive, room exit, collection battle 8699, building init 8281, battle pause and continue, quest reward), QTE guide (8302) |
| Plot and dialog | [plot-dialog.md](plot-dialog.md) | `U_C_GAME_PLOT` 138 and `U_C_BATTLE_TALK` 171 with `PlotMsg`, dialog UI, plot events (`SESSION_OVER` to 5032), battle plot ack (10022), client side scripted dialogs |
| Step templates | [step-templates.md](step-templates.md) | `U_C_STEP_MSG` 321 with `StepListMsg`, consumed by the Arma Divina gift activity |
| Guide tasks | [guide-tasks.md](guide-tasks.md) | "Objetivo dos 7 dias" frame, its data model (`leed.ServenDayLeadMsg`), templates, and the "something to do" level view |
| Game guide | [game-guide.md](game-guide.md) | Static "Como obter ...?" guide with "Ir Agora" shortcuts, client only |

## Dependencies

- [account](../account/README.md): HTTP servlet `updateplayernovice` (read on login, write 10000 after naming), registration and character creation ([register.md](../account/register.md), [login-session.md](../account/login-session.md)). This feature consumes the value they produce.
- [hero](../hero/README.md): `PlayerMsg` (accept 3) carries `novice_process (#23)`, `qte_guide (#56)` and `jump_novice (#110)`; vice password push 4696 sets `needViceGuild` and `needShowReward` used by the item lock guide.
- [campaign](../campaign/README.md): training campaign 10002, node arrive 5125, room exit 5025, campaign create 125, session callback 5032, node states.
- [battle](../battle/README.md): guided battles, pause 10010, continue 10022, battle plot 171, skill order 10008. See `docs/battle/hud.md` and `docs/battle/rules.md`.
- [castle](../castle/README.md): building and queue initialization requested by 8281; buildings 901, 402, 1509, 1511 highlighted by the script.
- [quests](../quests/README.md): quests 1832, 1834, 1912, 1823, 1826, 1827 drive and gate the script; quest reward 5014; quest condition type 23 compares `novice_process`.
- [skills](../skills/README.md): QTE skills (`QTETime > 0`) trigger the QTE guide.
- [daily-activity](../daily-activity/README.md): owns the `leed` proto package and the day guide frame; `DayGuideManager` gates entries on `novice_process`.
- [divine-weapon](../divine-weapon/README.md): consumer of the step templates (321) through `ArtifactManager`.
- [trials](../trials/README.md) and [roads](../roads/README.md): reuse `PlotMsg` for their own dialogs (4878 `U_C_DIALOG`, 4896 `U_C_REVENGEROAD_DIALOG`).
- [world-map](../world-map/README.md), [guild](../guild/README.md), [mounts](../mounts/README.md), [cosmos](../cosmos/README.md), [einherjar](../einherjar/README.md), [guardians](../guardians/README.md), [farm](../farm/README.md): targets of "new function" guides and of "Ir Agora" shortcuts.

## Suggested implementation order

1. Novice process storage and 5017 save, plus the `novice_process` field in `PlayerMsg` and the login routing (5127, castle). Setting 99900 at creation is a valid stub that disables the whole script.
2. Plot pushes (138) with server side plot data, and the `SESSION_OVER` callback (5032); battle plot (171) with the 10022 ack.
3. Guided steps server side effects in script order: training campaign and node battles (with campaign and battle), room exit, collection battle 8699, building init 8281, quest 1834 reward.
4. QTE guide flag (8302).
5. Step templates (321) when the Arma Divina gift activity is implemented.
6. Seven day objectives only if a server opcode is decided (see [guide-tasks.md](guide-tasks.md) open questions); the game guide needs no server work.
