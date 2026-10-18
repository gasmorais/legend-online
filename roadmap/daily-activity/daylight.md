# Dawn slaughter ("Matança de Madrugada", 黎明杀机)

Area: daily-activity, module `daylight`. Covers the guild versus guild sandbox event: `sandbox.SandboxManager`, `sandbox.daylight.DayLightModel` and data classes (core), `mvc.controler.DayLightController`, `sandbox.SandboxSceneController`, `sandbox.net.DayLightOuterManager` and the `sandbox.daylight.*` views (m3), the proto package `daylight`, routes 9670 and pushes 4851 to 4860.

Conventions: see [README.md](README.md).

## 1. Overview

A daily 30 minute event (15:00 to 15:30, every weekday) for guilds. A guild president signs the guild up by paying guild fortune; members then enter a dedicated sandbox scene ("SANDBOX_SCENE", music of map 4101) split into a blue team (1) and a red team (2), each a guild ("consortiaName"). Each side has a base tower with HP, defense units, blessings and monster lairs ("Monstros Restantes") that spawn waves. Players choose a lane to attack (4 attack buttons), defend their tower, or use skills bought with "exchanges" earned by repelling monsters. The team with the higher score (or the surviving tower) wins; individual scores rank players and the top 50 receive "Baú da Madrugada" chests.

Daily activity link: `DayGuideManager.switchScene(55)` (constant `VEHICLE`, `decompiled/core_module/scripts/managers/DayGuideManager.as:791`) opens this event, but no current activity template uses TaskType 55; quest condition types 79 and 80 ("join timed event", "win timed event") navigate here (`SwitchPageHelp.gotoDayLight` from the quest switch, see [../quests/quest-conditions.md](../quests/quest-conditions.md)).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `sandbox.SandboxSceneController` (`decompiled/m3/scripts/sandbox/SandboxSceneController.as:34`) | | Scene shell; leaves to space when `SandboxManager.exit` (`:44`) | `SceneManager.setScene("SANDBOX_SCENE")` from `SandboxManager.init` (`decompiled/core_module/scripts/sandbox/SandboxManager.as:181`) | |
| `sandbox.daylight.DayLightSceneView` (`decompiled/m3/scripts/sandbox/daylight/DayLightSceneView.as:27`) | | Builds the event view; on creation sends op 8 and op 4 (`:33-:34`) | scene | |
| `sandbox.daylight.DayLightView` (`decompiled/m3/scripts/sandbox/daylight/DayLightView.as`) | "Unidade de defesa: {0}", "Bênçãos Restantes: {0}", "Monstros Restantes: {0}", "Ataque Voador X{0}" per team, defend buttons, tower HP | Battlefield | scene | 4853, 4854 |
| `sandbox.daylight.DayLightBattleView` (`decompiled/m3/scripts/sandbox/daylight/DayLightBattleView.as`) | 4 attack buttons | Moving monster units (`DayLightAvatarView`) and lane attack (`__attackBtnClickHandler` `:138`) | scene | 4854 |
| `sandbox.daylight.DayLightTopBar` (`decompiled/m3/scripts/sandbox/daylight/DayLightTopBar.as`) | team scores, tower HP tips | start and end countdowns (`fightBeginCd`, `fightEndCd`, `:198-:209`) | scene | 4853 |
| `sandbox.daylight.DayLightRightView` (`decompiled/m3/scripts/sandbox/daylight/DayLightRightView.as`) | "Ranking de Pontos" link, "Minha Formação:", "Meu status:" (Inativo, Atacar, Esperando a ressurreição, Defender), "Nº de monstros que eu repeli:", "Nº de trocas restantes:", "Meus pontos:" | Self info and 5 skill rows (`refreshView` `:297`) | scene | 4851 |
| `sandbox.daylight.DayLightBufferItemView` (`decompiled/m3/scripts/sandbox/daylight/DayLightBufferItemView.as:30`) | skill name "X{count}", use and exchange buttons | skill 410201..410205; 410205 is passive (no buttons, `:123`) | right view | `CampaignBufferTemps` |
| `daylight.DayLightScoreRankFrame` (`decompiled/m3/scripts/sandbox/daylight/DayLightScoreRankFrame.as:56`) | "Ranking de Pontos" | live ranking; sends op 7 on open (`:61`) | `openControllerByInfo("daylight", 1)` (`decompiled/m3/scripts/sandbox/daylight/DayLightRightView.as:289`) | 4852 |
| `daylight.DayLightGameOverFrame` (`decompiled/m3/scripts/sandbox/daylight/DayLightGameOverFrame.as`) | "Lista de Heróis", "Pontos", "Ver todos os prêmios" | final ranking with victory or defeat flags (`:449-:450`) and reward counts (`:444-:446`) | `openControllerByInfo("daylight", 2)` after 4855 (`decompiled/core_module/scripts/mvc/controler/DayLightController.as:176`) | 4855 |
| `daylight.DayLightPersonRewardFrame` (`decompiled/m3/scripts/sandbox/daylight/DayLightPersonRewardFrame.as`) | "Prêmios de pontos pessoal" | reward table by rank | game over frame | `DayLightModel.PERSONAL_REWARDS` |

Entry points:

| Entry | Condition | Source |
|---|---|---|
| Top toolbar time active button `daylight` | `TopToolsBar.dayLightState == 1` (set by 4860) (`decompiled/core_module/scripts/yishi/datas/templates/TopToolBtnTempInfo.as:131`), hero level >= 13 and `VersionSwitch.ICON_DAYLIAHGT` (`decompiled/core_module/scripts/ui/toptoolbar/TopBtnCheckShowHelper.as:313`) | `decompiled/core_module/scripts/ui/toptoolbar/TopToolsBar.as:1350` -> `SwitchPageHelp.gotoDayLight` `decompiled/core_module/scripts/yishi/SwitchPageHelp.as:1798` |
| Quest "Ir" for condition types 79, 80 | same | `decompiled/core_module/scripts/yishi/SwitchPageHelp.as:348-:350` |

`gotoDayLight` requires level >= 13 ("Função não habilitada, não é possível pular") and `checkScene`, then `SandboxManager.requestState` (`decompiled/core_module/scripts/sandbox/SandboxManager.as:219`) requires a guild ("Você não faz de parte de uma guilda!").

## 3. Routes (client to server)

All routes: C>S 9670 (0x25c6) `C_SAND_BOX_OP`, body `simple.PropertyMsg` with `param10 (#10, INT32)` = sandbox type (1 = daylight) and `param11 (#11, INT32)` = op; `param1 (#1, INT32)` carries the argument when needed. Senders in `SandboxManager` (`decompiled/core_module/scripts/sandbox/SandboxManager.as:219-:257`) and `DayLightOuterManager` (`decompiled/m3/scripts/sandbox/net/DayLightOuterManager.as:30-:92`, which forces `param10 = 1`).

| # | UI control | op (`param11`) | `param1` | Client checks | Expected response |
|---|---|---|---|---|---|
| DL1 | top button | 10 `OP_TOP_CLICK` (request state) | | has guild | 4859 |
| DL2 | automatic after 4859 when signed and open | 0 `OP_ENTER` | | | 4856 `param2 = 1` then the scene pushes |
| DL3 | sign up confirm "Confirma que deseja gastar {0} pontos de fortuna da guilda?" | 11 `OP_JION` | | 4859 `param1 == 1`, guild fortune (`consortiaInfo.offer`) >= `daylight_signin_offer` else "Fortuna da Guilda inferior a {0}!" | 4859 again (signed) |
| DL4 | main toolbar exit with "Você já utilizou uma oportunidade de obtenção de ganhos. Se você sair do evento agora não receberá o prêmio não poderá voltar a entrar." (`decompiled/core_module/scripts/ui/maintoolbar/MainToolBar.as:1658`, `:1823`) | 1 `OP_LEAVE` | (`param10` = current type) | confirm | 4856 `param2 = 0` |
| DL5 | attack button 1..4 | 2 `OP_WALK` | lane 0..3 | | 4851, 4854 |
| DL6 | defend button (own tower) (`DayLightView.__defendBtnClickHandler` `decompiled/m3/scripts/sandbox/daylight/DayLightView.as:600`) | 3 `OP_DEFEND` | | not dead ("Você está morto. Não pode realizar esta ação!") | 4851, 4853 |
| DL7 | scene creation | 4 `OP_CLEAR_CD` | | | 4851 (assumption: resync of the revive cooldown) |
| DL8 | skill use (`DayLightBufferItemView.__buffUseBtnClickHandler` `:91`) | 5 `OP_USE_SKILL` | skill template 410201..410204 | count > 0 shown | 4857, 4851, 4853 or 4854 |
| DL9 | skill exchange (`__buffExchangeBtnClickHandler` `:99`) | 6 `OP_BUY_SKILL` | skill template | | 4851 |
| DL10 | ranking frame open | 7 `OP_VIEW_RANK` | | | 4852 |
| DL11 | scene creation | 8 `OP_REQUEST_DATA` | | | 4851, 4853, 4854 |

Constant `OP_TEAM_CONF = 9` exists without sender.

## 4. Server messages (server to client)

| Opcode | Message and fields | Receiver | When |
|---|---|---|---|
| 4859 (0x12fb) `U_C_SAND_BOX_STATE` | `simple.PropertyMsg`: `param1 (#1)` 1 = this player may sign the guild up (president), `param4 (#4, STRING)` opening time text for "Espere {0} para abrir!", `param7 (#7, BOOL)` guild signed up, `param8 (#8, BOOL)` event running | `SandboxManager.__sandboxStateHandler` `decompiled/core_module/scripts/sandbox/SandboxManager.as:83`: signed and running -> DL2; signed and not running -> wait message; not signed and `param1 == 1` -> sign up popup; otherwise "O presidente não se inscreveu!" | reply to DL1, DL3 |
| 4856 (0x12f8) `U_C_SAND_BOX_INFO` | `simple.PropertyMsg`: `param1 (#1)` sandbox type, `param2 (#2)` 1 enter, 0 leave | `__sandboxInfoHandler` `:157` (enter: `init(type)` switches scene); leave packets are buffered until the sandbox scene and handled by `SandboxOverTransaction` (`decompiled/core_module/scripts/sandbox/transaction/SandboxOverTransaction.as:17`) which calls `uninit` and returns to space | reply to DL2, DL4, event end |
| 4860 (0x12fc) `U_C_SAND_BOX_OPEN` | `simple.PropertyMsg`: `param1 (#1)` 1 show the top button, 0 hide | `_activeStateHandler` `:75` -> `TopToolsBar.dayLightState` | login, 15:00 open, 15:30 close (sign up window, assumption) |
| 4851 (0x12f3) `U_C_DAY_LIGHT_USER_INFO` | `daylight.DayLightUserInfoMsg`: `uuid (#1, STRING)`, `userId (#2, INT32)`, `serverName (#3, STRING)`, `nickName (#4, STRING)`, `isViceHero (#5, BOOL)`, `isVip (#6, BOOL)`, `fightPower (#7, INT32)`, `team (#8, INT32)` 1 blue 2 red, `state (#9, INT32)` 0 idle 1 attacking 2 dead 3 defending, `score (#10, INT32)`, `honor (#11, INT32)`, `reviveCd (#12, INT32)` seconds, `repelCount (#13, INT32)` monsters repelled, `remainCount (#14, INT32)` skill exchanges left, `skills (#15, STRING)` "templateId,count|...", `order (#16, INT32)` rank, `isReward (#17, BOOL)` earns a rank reward | `DayLightController.__userInfoHandler` `decompiled/core_module/scripts/mvc/controler/DayLightController.as:80` | self state changes |
| 4852 (0x12f4) `U_C_DAY_LIGHT_USER_RANK` | `daylight.DayLightUserRankMsg`: `rankList (#1, DayLightUserInfoMsg, repeated)`, `winTeam (#2, INT32)` | `__userRankHandler` `:89` | reply to DL10 |
| 4853 (0x12f5) `U_C_DAY_LIGHT_SAND_BOX_INFO` | `daylight.DayLightSandBoxInfoMsg`: `redTeam (#1, DayLightTeamInfoMsg)`, `blueTeam (#2, DayLightTeamInfoMsg)`, `fightBeginCd (#3, INT32)` seconds to start, `fightEndCd (#4, INT32)` seconds to end. `DayLightTeamInfoMsg`: `teamCount (#1)` players, `teamScore (#2)`, `defendCount (#3)` defense units, `blessCount (#4)` blessings left, `towerHp (#5)`, `towerMaxHp (#6)`, `leftNpcCount (#7)` lair monsters left, `createNpcCd (#8)` seconds to next wave, `assaultCount (#9)` flying attacks, `consortiaName (#10, STRING)` | `__sandboxInfoHandler` `:106` | every state change, at least every wave |
| 4854 (0x12f6) `U_C_DAY_LIGHT_MODEL_INFO` | `daylight.DayLightModelListMsg`: `blueModelList (#1, DayLightModelInfoMsg, repeated)`, `redModelList (#2, ...)`. `DayLightModelInfoMsg`: `id (#1)`, `x (#2)`, `y (#3)`, `type (#4)`, `count (#5)` stack size, `speed (#6)`, `state (#7)`, `isFight (#8, BOOL)` | `__modelInfoHandler` `:118` | wave spawn and unit movement |
| 4857 (0x12f9) `U_C_DAY_LIGHT_USE_SKILL` | `simple.PropertyMsg`: `param1 (#1)` team that used it, `param2 (#2)` skill template | `__useSkillHandler` `:142` (skill effect animation) | after DL8, broadcast to both teams |
| 4855 (0x12f7) `U_C_DAY_LIGHT_RESULT` | `daylight.DayLightUserRankMsg` (final `rankList`, `winTeam`) | buffered to the return scene, then `resultCallBack` `:159` opens the game over frame in space | event end, to every participant |

## 5. Rules and formulas

Config (`raw/xml/tempinfos/ConfigInfos.xml`):

| Key | Value | Meaning |
|---|---|---|
| `daylight_open_week_day` | 1,2,3,4,5,6,7 | open every day |
| `daylight_open_time` | 15:00,15:30 | event window |
| `daylight_signin_offer` | 2500000 | guild fortune paid to sign up |
| `daylight_nest_npc_count` | 300 | initial monsters in each lair |
| `daylight_create_npc_cd` | 40 | seconds between waves |
| `daylight_init_npc_count` | 16 | monsters spawned at fight start |
| `daylight_create_npc_count` | 20 | monsters per wave |
| `daylight_buy_skill_count` | 8 | repels needed for one skill exchange (assumption on unit) |
| `daylight_win_add_score` | 200 | extra score for the winning team |
| `daylight_add_honor` | 0 | honor for winning |

Skills (`raw/xml/tempinfos/CampaignBufferTemps.xml`, `Types` 40): 410201 "Intimidação" (enemy lairs lose 5), 410202 "Raiva" (5 monsters spawn on the enemy side), 410203 "Bênção" (+2% attack unit attributes), 410204 "Ataque Voador" (strike the enemy tower defense units, or the tower when undefended), 410205 "Excitação" (passive, +100% after each defeat, reset on victory).

Personal rewards (`DayLightModel.PERSONAL_REWARDS` `decompiled/core_module/scripts/sandbox/daylight/DayLightModel.as:38`): item 2060801 "Baú da Madrugada": rank 1 x20, 2 x15, 3 x12, 4 to 6 x10, 7 to 15 x5, 16 to 50 x3; `MIN_SCORE = 5` (assumption: minimum personal score to be eligible, reflected by `isReward`).

Other rules:

- Leaving after earning rewards forfeits them and blocks re entry (exit popup text).
- Dead players wait `reviveCd` and cannot defend.
- Each team is one guild; matching of two signed guilds is server side (open question).

## 6. Templates

| File | Record | Fields |
|---|---|---|
| `raw/xml/tempinfos/CampaignBufferTemps.xml` | `CampaignBufferTemp` 410201..410205 | `TemplateId`, `TemplateName`, `Icon`, `Description`, attribute bonuses |
| `raw/xml/tempinfos/ConfigInfos.xml` | config | keys above |
| `raw/xml/tempinfos/ItemTempInfos.xml` | item 2060801 | reward chest |

## 7. Persistent state

```sql
CREATE TABLE daily_activity.daylight_signup (
    event_date     date      NOT NULL,
    consortia_id   integer   NOT NULL,
    signed_by      integer   NOT NULL REFERENCES player.players(player_id),
    signed_at      timestamptz NOT NULL DEFAULT now(),
    team           smallint  CHECK (team IN (1, 2)),
    match_id       integer,
    PRIMARY KEY (event_date, consortia_id)
);

CREATE TABLE daily_activity.daylight_match (
    match_id       serial    PRIMARY KEY,
    event_date     date      NOT NULL,
    blue_consortia integer   NOT NULL,
    red_consortia  integer   NOT NULL,
    win_team       smallint  CHECK (win_team IN (0, 1, 2)),
    blue_score     integer   NOT NULL DEFAULT 0,
    red_score      integer   NOT NULL DEFAULT 0,
    finished_at    timestamptz
);

CREATE TABLE daily_activity.daylight_participant (
    match_id     integer   NOT NULL REFERENCES daily_activity.daylight_match(match_id) ON DELETE CASCADE,
    player_id    BIGINT   NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
    team         smallint  NOT NULL CHECK (team IN (1, 2)),
    score        integer   NOT NULL DEFAULT 0,
    repel_count  integer   NOT NULL DEFAULT 0,
    final_rank   integer,
    rewarded     boolean   NOT NULL DEFAULT false,
    left_early   boolean   NOT NULL DEFAULT false,
    PRIMARY KEY (match_id, player_id)
);
```

Live state (units, towers, cooldowns, skills) stays in memory inside the match actor; only results are stored. `consortia_id` references the guild table of [guild](../guild/README.md).

## 8. Backend implementation notes

- `daily_activity::daylight::handle_sandbox_op` (9670): dispatch on `param10` (1 only) and `param11`:
  - 10 state: reply 4859 from guild membership, president permission, sign up row and the clock.
  - 11 join: president only, guild fortune >= 2,500,000, inside the sign up window; debit guild fortune ([guild](../guild/README.md) funds) and insert `daylight_signup` in one transaction; reply 4859.
  - 0 enter: event running and guild matched; add the player to the match actor; reply 4856 (`param1 = 1`, `param2 = 1`), then 4853, 4854, 4851.
  - 1 leave: mark `left_early` if the player already scored; reply 4856 (`param2 = 0`).
  - 2 attack lane, 3 defend, 5 use skill, 6 exchange skill, 4 clear cooldown, 7 ranking, 8 full data: forwarded to the match actor.
- Match actor (one per pair of guilds, tick 1 s): spawns 16 monsters at start and 20 every 40 s per lair while `leftNpcCount > 0`; moves units (4854); resolves lane fights server side (no battle scene is opened by this client; assumption: simplified combat using fight power); updates towers and scores (4853); grants exchanges every 8 repels; ends at 15:30 or when a tower falls; adds 200 to the winning team; ranks players; grants rewards by rank with `isReward`; sends 4855 to everyone; closes with 4856 `param2 = 0`.
- Scheduler: 4860 `param1 = 1` before the window to every online guild member (assumption: from sign up opening), `param1 = 0` after the event.
- Record quest counters 79 (join) and 80 (win) for participants ([../quests/quest-conditions.md](../quests/quest-conditions.md)).

## 9. Open questions and assumptions

- Combat resolution of lane attacks and defense is not visible in the client (no battle opcodes are used); a server simulation must be designed.
- Score formula per action is unknown.
- Guild matching rule (random, by power) and odd counts are unknown.
- Meaning of op 4 sent on scene creation ("clear CD") is unclear; treat it as a resync.

## 10. Implementation checklist

- [ ] 4860 top button schedule
- [ ] Route 9670 ops 10, 11, 0, 1 (state, sign up, enter, leave)
- [ ] Guild fortune debit on sign up
- [ ] Match actor with waves, lanes, towers, skills, exchanges
- [ ] Pushes 4851, 4852, 4853, 4854, 4857
- [ ] Result 4855 and rank rewards (2060801)
- [ ] Tables `daylight_signup`, `daylight_match`, `daylight_participant`
- [ ] Quest counters 79, 80 and activity record
- [ ] Test: no guild, not signed, wait message, leave and re entry refused
