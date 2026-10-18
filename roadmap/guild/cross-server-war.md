# Cross-server guild war: fight day and battlefield ("Defesa de Guilda")

Module: `guild::cross_server_war`. Protobuf package `com.road.yishi.proto.consortiawar`. Client manager `yishi.manager.CrossGuildManager`; views `consortia.view.crossguild.war.*`.

Citation prefixes: `CM/` = `decompiled/core_module/scripts/`, `M6/` = `decompiled/m6/scripts/`, `TPL/` = `raw/xml/tempinfos/`, `LANG` = `index/language.json`. "(A)" marks an assumption.

## Overview

This is the fight-day half of the guild war described in [war.md](war.md) (same opcode 8650, same model `CrossGuildModel`). On each fight day (state 6) every valid, non-bye guild is paired with a guild that may live on another server (`rivalServerName`, `serverName` fields). Each guild has 12 towers ("pontos de defesa"), one per defender selected on the preparation day. Any member can enter the battlefield scene `CROSS_GUILD_SCENE`, spend action points ("Pontos de movimento") to attack enemy towers (a real battle, battleType 296, against the defender's stored formation), make fortified attacks, or interfere (no battle, seals the defender's followers). Tower HP lost is the guild HP lost; the guild with more remaining HP wins; the HP the rival lost is added to the guild's season score.

Help text excerpts (`CrossGuild.helperFrame.helpTxt.text`, LANG, verbatim):

- "Todos os membros da Guilda podem participar do ataque. Ataque os pontos de defesa do oponente para reduzir sua durabilidade e obter a vitória. A durabilidade perdida dos pontos de defesa é equivalente à quantidade de vida perdida pela guilda."
- "Ao fim da competição, vence a guilda que tiver mais vida restante."
- "No dia do combate, todos os membros da guilda possuirão um Estado de Guerrilha que pode reduzir efetivamente a vida da guilda adversária: durante esse estado, atacar ou fortelecer o ataque enquanto estiver ganhando, reduzirá os pontos de defesa cinco vezes mais rápido. O Estado de Guerrilha tem uma quantidade limitada, que é reduzida em 1 para cada ataque ou ataque fortalecido feito pelos membros."
- "Ao encontrar um ponto de defesa poderoso, pode-se optar por fortalecer o ataque e obter habilidade de fortalecimento extras. Outra alternativa é realizar uma interferência contínua, distraindo a atenção do Defensor e selando os Einherjars e Guardiões que ele traz para reduzir sua eficácia de combate. Interferência não requer poder de combate e não confere vitórias ou derrotas."

Entry: `ConsortiaViewHelper.openCrossGuildHandler` sends opType 6 when `state == 6`, `signType != 0`, `!isBye`, `isValid` (`CM/mvc/module/consortia/ConsortiaViewHelper.as:227-236`). Same handler from the guild activity item id 5 and the top bar button `crossgvg` (`CM/ui/toptoolbar/TopToolsBar.as:1182-1184`).

Legacy: the client also declares opcodes of an older node-based cross guild war that are never sent or listened to: 8778 `C_CROSSGUILD_TEAM_EDIT`, 8779 `C_CROSSGUILD_SIGNUP`, 8782 `C_CROSSGUILD_GROUP`, 8783 `C_ENTER_CROSSGUILD`, 25109 `CR_CROSS_GUILD_WAR_REQUEST`, 4439 `U_CR_CROSS_GUILD_WAR_FIELD`, 4440 `U_CR_CROSS_GUILD_WAR_NODE_DETAIL`, 4441 `U_CR_CROSS_GUILD_WAR_SELF`, 4832 `U_C_GUILDWAR_JOIN_PLAYER_COUNT` (only in `CM/yishi/datas/consant/ProtocolType.as` / `AcceptProtocolType.as`; `events/GvgEvent.GUILDWAR_PLAYER_COUNT` is never dispatched). The `CrossGuildWarNodeFrame.*`, `CrossGuildWarLeftView.selfInspire.*` strings and the `cross_guild_*` config keys belong to it. Do not implement them.

## Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `consortia.view.crossguild.CrossGuildWarSceneView` (scene `CROSS_GUILD_SCENE`) | (none) | Battlefield: map, 12 green towers (left, team 1) and 12 red towers (right, team 0), HUD | 4569 (`CM/yishi/manager/CrossGuildManager.as:263-294`); return from battleType 296 (`CM/battle/handler/BattleResultHandler.as:261-269`) | 4569/4572 (`M6/consortia/view/crossguild/CrossGuildWarSceneView.as:17-120`) |
| `consortia.view.crossguild.war.CrossGuildWarTowerView` / `CrossGuildWarTowerNodeView` | | Tower sprites with HP bar, skin by tower id, state art, "being attacked" effect, attack cursor on enemy towers | scene | `greenTeamInfo`/`redTeamInfo.towerDic[1..12]` (`M6/consortia/view/crossguild/war/CrossGuildWarTowerView.as:43-90`; `CrossGuildWarTowerNodeView.as:129-260`) |
| `consortia.view.crossguild.war.CrossGuildWarTopView` | | Guild names, "Vida: {0}/{1}" per guild, war countdown or "Horário de combate" + window, momentum uses left | scene HUD | `myTeam/vsTeam.blood/maxBlood`, `bufferCount`, `consortia_war_attack_buff`, `consortia_war_fight_time` (`CrossGuildWarTopView.as:113-243`) |
| `consortia.view.crossguild.war.CrossGuildWarLeftView` | | "Pontos de movimento {0}/{1}" bar, buy button, defense policy button, attack record button | scene HUD | `curSpirit`, `maxSpirit`, `buySpiritCount` (`CrossGuildWarLeftView.as:71-121`) |
| `consortia.view.crossguild.war.CrossGuildTowerAttackFrame` (375x425) | Castelo atual | Attack menu: three `CrossGuildAttackItem` rows (attack, fortified, interference) | click on a tower (`CrossGuildWarTowerNodeView.as:192-197`) | defender nick, "Durabilidade {0}/{1}", costs, interference quest (`CrossGuildTowerAttackFrame.as:84-113`; `CrossGuildAttackItem.as:56-206`) |
| `consortia.view.crossguild.war.CrossGuildTowerDetailFrame` (375x425) | Castelo atual | Defender fight power, HP, guild strategy + personal bonus icons, 6 seal slots, defense record | tower look button (`CrossGuildWarTowerNodeView.as:165-169`) | 4571 (`CrossGuildTowerDetailFrame.as:51-236`) |
| `consortia.view.crossguild.war.CrossGuildWarAttackRecordFrame` (485x405) | Recorde de ataque | Per member stats, tabs own guild / rival guild | left view attack button (`CrossGuildWarLeftView.as:76-80`) | 4570 (`CrossGuildWarAttackRecordFrame.as:56-161`) |
| `consortia.view.crossguild.CrossGuildPolicyFrame` | Defesa de Guilda | Read-only on fight day | left view policy button (`CrossGuildWarLeftView.as:71-74`) | see war.md |

Exit: the main toolbar exit button in `CROSS_GUILD_SCENE` asks "Deseja sair da Defesa de Guilda?" (`ui.maintoolbar.MainToolBar.CrossGuild.exitGame`, `CM/ui/maintoolbar/MainToolBar.as:1673-1677`).

## Actions

All requests: **C to S 8650 (0x21CA) `C_CONSORTIA_WAR_CLIENT_OP`**, body `ConsortiaWarClientOpMsg` with fields `opType` (#1, INT32), `signType` (#2, INT32), `bufferId` (#3, INT32), `towerId` (#4, INT32, 1..12), `teamId` (#5, INT32, 0 or 1, the team that owns the tower), `attackType` (#6, INT32, 1 attack, 2 fortified attack, 3 interference), `payType` (#7, INT32, never set). Senders in `CM/yishi/manager/CrossGuildManager.as`. No result code exists; on rejection resend the authoritative state (4572 or 4569) so the UI reverts (A: plus the project generic notice, see war.md).

| # | Action | UI control | Client sender | Client checks | Request | Responses (in order) |
|---|---|---|---|---|---|---|
| B1 | Enter the battlefield | activity item 5 / top bar `crossgvg` | `ConsortiaViewHelper.openCrossGuildHandler` (`ConsortiaViewHelper.as:227-236`) -> `CrossGuildManager.sendCrossGuildWar(6)` (:546-552) | in a guild; `signType != 0`; `state == 6`; `!isBye`; `isValid` | `{opType:6}` | 4569 (client switches to `CROSS_GUILD_SCENE`) |
| B2 | Buy action points | left view "+" | `CrossGuildWarLeftView._addSpiritBtnClickHandler` (:82-101) -> `confirmBuyHandler` (:103-114) -> `sendBuySpirit` (:538-544) | `curSpirit < maxSpirit` else "Você atingiu o limite máximo de pontos de moviemtno, não é possível comprar mais"; `buySpiritCount < maxBuySpiritCount` else "Compra atingiu o limite"; confirm "Deseja gastar {0} diamantes para preencher o Movimento?\n(pode comprar mais {1} vezes hoje)"; `LogicUtils.judgePointEnoughToShowPay(150)` (opens recharge if short) | `{opType:7}` | 4572 `{spirit, buyCount}` to the buyer; core diamond update |
| B3 | Attack a tower | attack row button (index 0) | `CrossGuildAttackItem._attackBtnClickHandler` (`M6/consortia/view/crossguild/war/CrossGuildAttackItem.as:98-105`) -> `checkIsAlertFighting(1)` (:151-166) -> `sendCrossGuildTowerAttack(teamId, towerId, 1)` (:554-563) | buttons disabled on own towers (`model.myTeamId != teamId`, :205); `curSpirit >= 1` else "Pontos de movimento insuficientes, compre mais" (:134-138); `blood > 0` else "A durabilidade do castelo é zero" (:139-143); if `attackCount > 0` confirm "Este ponto de defesa está sendo atacado por outro membro, caso você ataque agora talvez não afete sua durabilidade e não ganhe pontos." | `{opType:8, teamId, towerId, attackType:1}` | 4572 to all battlefield viewers of both guilds (`attackCount+1`, attacker `spirit`); battle start 157 -> 156 -> 153... -> 154 -> 4103 (battleType 296); then 4572 with new `blood`, `bufferCount`, `attackCount-1` to all viewers |
| B4 | Fortified attack | row index 1 | `_fortifiedAttackBtnClickHandler` (:107-114) | same as B3 with cost 2 | `{opType:8, teamId, towerId, attackType:2}` | same as B3 |
| B5 | Interference | row index 2 | `_troubleBtnClickHandler` (:116-130) | `curSpirit >= 1`; `blood > 0`; `troubleCount < 6 * 3` else "Limite de Interferência atingido"; no "being attacked" confirm | `{opType:8, teamId, towerId, attackType:3}` | 4572 to all viewers (`troubleCount`, `sealList`, `questId`, attacker `spirit`); no battle |
| B6 | View tower detail | tower look button | `CrossGuildTowerDetailFrame` constructor (`CrossGuildTowerDetailFrame.as:51-58`) -> `sendCrossGuildTowerDetail(teamId, towerId)` (:565-573) | none (own or enemy) | `{opType:9, teamId, towerId}` | 4571 |
| B7 | View attack record | left view attack button | `CrossGuildWarAttackRecordFrame` constructor (:56-61) -> `sendCrossGuildWar(10)` | none | `{opType:10}` | 4570 |
| B8 | Leave the battlefield | main toolbar exit | `MainToolBar.exitCrossGuildWar` (`CM/ui/maintoolbar/MainToolBar.as:1848-1855`) | confirm dialog | `{opType:11}` | none; client sets `isInCrossGuildWar=false` and returns to `SwitchPageHelp.returnScene` |
| B9 | Open policy (read-only) | left view policy button | `openControllerByInfo("crossguild",2)` | none | opType 1 and 13 (war.md) | 4566 |

## Server messages

Receivers in `CM/yishi/manager/CrossGuildManager.as` (listeners :71-81).

### 4569 (0x11D9) `U_C_CONSORTIA_WAR_FIGHT_DATA`, `ConsortiaWarBattleFieldMsg`

Receiver `__fightWarMainHandler` (:263-294); team builder `createTeamInfo` (:296-349). Response to opType 6.

| Field | Tag | Type | Meaning |
|---|---|---|---|
| `teamId` | 1 | INT32 | requester's team: 0 = red (right side), 1 = green (left side) (`CrossGuildModel.as:194-202`) |
| `spirit` | 2 | INT32 | current action points |
| `buyCount` | 3 | INT32 | action point buys today |
| `myTeam` | 4 | `ConsortiaWarTeamMsg` | own guild |
| `rivalTeam` | 5 | `ConsortiaWarTeamMsg` | rival guild |
| `bufferCount` | 6 | INT32 | momentum uses consumed by the requester's guild (A: per guild) |

`ConsortiaWarTeamMsg`: `consortiaName` (#1, STRING), `serverName` (#2, STRING), `blood` (#3, INT32, current guild HP = sum of tower HP), `maxBlood` (#4, INT32), `defendBufferId` (#5, INT32, guild strategy skill), `towerList` (#6, repeated `ConsortiaWarTowerMsg`).

`ConsortiaWarTowerMsg`: `teamId` (#1, INT32), `towerId` (#2, INT32, 1..12), `name` (#3, STRING, defender nick), `blood` (#4, INT32), `questId` (#5, INT32, `ConsortiaWarQuestTemplates.TemplateId` of the current interference quest), `sealList` (#6, INT32 repeated, sealed follower slots 1..6), `attackCount` (#7, INT32, attackers fighting it now), `troubleCount` (#8, INT32, interferences received). Client side, setting `blood` derives `totalBlood` from `consortia_war_defence`, `towerType` (skin) from `consortia_war_defence_skin` and `state` 1 (>75%), 2 (>20%), 3 (else) (`CM/mvc/module/crossguild/CrossGuildTowerInfo.as:51-96`).

Effect: `isInCrossGuildWar = true`, `setScene("CROSS_GUILD_SCENE")`.

### 4572 (0x11DC) `U_C_CONSORTIA_WAR_UPDATE`, `ConsortiaWarUpdateMsg`

Receiver `__warInfoChangeHandler` (:430-510). Ignored unless both teams are loaded.

| Field | Tag | Type | Meaning |
|---|---|---|---|
| `opType` | 1 | INT32 | unused by the client |
| `towerData` | 2 | `ConsortiaWarTowerMsg` | changed tower; only fields with `has*` are applied, but `sealList` is always replaced (send it every time) |
| `teamId` | 3 | INT32 | team of `towerData` and `blood`; required for tower/blood updates |
| `blood` | 4 | INT32 | new guild HP of `teamId` |
| `spirit` | 5 | INT32 | receiver's action points (send only to the acting player) |
| `buyCount` | 6 | INT32 | receiver's buys today |
| `bufferCount` | 7 | INT32 | momentum uses consumed |

Effect: notifies `WAR_OHTER_INFO_CHANGE` (tower node, top view, left view redraw).

### 4571 (0x11DB) `U_C_CONSORTIA_WAR_TOWER_DATA`, `ConsortiaWarTowerDetailMsg`

Receiver `__towerDataHandler` (:391-428). Response to opType 9. Fields: `teamId` (#1, INT32), `towerId` (#2, INT32), `name` (#3, STRING), `fightPower` (#4, INT32, defender fight power), `blood` (#5, INT32), `troubleCount` (#6, INT32), `sealList` (#7, INT32 repeated), `userBufferId` (#8, INT32, defender's personal bonus), `recordList` (#9, repeated `ConsortiaWarDefendRecordMsg`: `num` #1 INT32 order, `attackName` #2 STRING, `attackType` #3 INT32 1..3, `isWin` #4 BOOL attacker won, `score` #5 INT32 HP lost). The client shows "Defesa bem-sucedida" (attacker lost), "Falha na defesa" + "-score" (attacker won), "Interferência" (attackType 3) (`CrossGuildTowerDetailFrame.as:189-226`). Ignored if the tower is not in the loaded teams.

### 4570 (0x11DA) `U_C_CONSORTIA_WAR_FIGHT_RANK`, `ConsortiaWarFightRankMsg`

Receiver `__fightRankHandler` (:351-389). Response to opType 10. `myTeam` (#1) and `rivalTeam` (#2), repeated `ConsortiaWarFightInfoMsg`: `nickName` (#1, STRING), `headId` (#2, INT32), `fightPower` (#3, INT32), `count1` (#4) / `score1` (#5) attacks, `count2` (#6) / `score2` (#7) fortified attacks, `count3` (#8) / `score3` (#9) interferences, `totalSocre` (#10, sic). All INT32. Client sorts by total desc; rows read "Ataque:{0}vezes +{1}", "Fortalec. ataque: {0}vezes +{1}", "Interferência: {0}vezes +{1}" (`CrossGuildWarAttackRecordItem.as:110-121`).

### 4573 (0x11DD) `U_C_CONSORTIA_WAR_SEASON_DATA`

See war.md. In this module: when the fight day ends (state leaves 6) the server pushes 4573 to everyone in the battlefield; the client leaves `CROSS_GUILD_SCENE` (`CrossGuildManager.as:151-158`).

### Battle opcodes

Attacks use the generic battle pipeline (`docs/battle/README.md` section 1, `docs/battle/server-engine.md` section 1): 157 `U_B_PREPARE` (`battle_type` 296), client 10007 `U_B_USER_LOADOVER`, 156 `U_B_START` (`mainType` 296), 153 `U_B_ATTACKING`..., 154 `PrepareOverMsg`, 4103 `BattleReportMsg`. Exit goes back to `CROSS_GUILD_SCENE` if `isInCrossGuildWar` and still in a guild, else `returnScene` (`BattleResultHandler.as:261-269`). battleType 296 HUD: trial props strip, `[servidor]` names (`docs/battle/rules.md:1351`; `docs/battle/hud.md:4191`).

## Rules and formulas

| # | Rule | Source |
|---|---|---|
| F1 | Fight window on fight day: `consortia_war_fight_time` = "5:00,23:00". Inside it the top view counts down to 23:00; outside it shows "Horário de combate" and "5:00--23:00". Attacks only inside the window (A: server enforced) | `CM/yishi/datas/ConfigInfoManager.as:1297-1304`; `CrossGuildModel.as:126-131`; `CrossGuildWarTopView.as:198-224` |
| F2 | Max action points (`consortia_war_sprite_config` "4,3,150,3,2"): second job transfer (`isChangeJob`) 4; first transfer (`vocationGrades > 0`) 3; none 2. Buys per day 3, each costs 150 diamonds and refills to max ("preencher") | `CrossGuildModel.as:122-146`; `ConfigInfoManager.as:1017-1024` |
| F3 | Action costs (`consortia_war_attack_config` "1,2,1,3"): attack 1, fortified attack 2, interference 1; 3 interferences seal one follower slot | `CrossGuildAttackItem.as:71-74`; `ConfigInfoManager.as:1044-1051` |
| F4 | Interference cap: `troubleCount < 6 * 3 = 18` per tower (6 seal slots, `TROUBLE_TYPE_NUM = 6`). Progress text "A cada {0}interferências que a defesa recebe, 1 dos sistemas abaixo é selado ({1}/{2})" with `{2} = min(floor(tc/3)+1, 6)*3` when `tc % 3 == 0`, else `ceil(tc/3)*3` | `CrossGuildAttackItem.as:124,179-203`; `CrossGuildTowerDetailFrame.as:160-183`; `CrossGuildModel.as:23` |
| F5 | Tower HP (`consortia_war_defence`, 12v12): towers 1: 7120 HP, loses 89 per defeat; 2-3: 6640/83; 4-5: 5600/70; 6-7: 5120/64; 8: 4640/58; 9: 4160/52; 10-12: 3600/45. Guild max HP = sum = 61440 | `TPL/ConfigInfos.xml`; `CrossGuildTowerInfo.as:59-73` |
| F6 | HP loss on a lost defense (attacker wins): `loss = per_defeat_loss(tower) * (fortified ? 1.5 : 1) * (momentum ? 5 : 1)`, clamped to remaining HP. (A) Guild strategy and personal bonus skills modify it (for example 618101 "O dano recebido pelos pontos de defesa diminui em 15%", 618401 "após uma derrota a vida perdida diminui em 10%"). No HP change when the defender wins | `CrossGuildAttackItem.descText.text1` ("A vitória no ataque causa uma perda de Durabilidade x1.5"); `consortia_war_attack_buff` "5,112"; help text; `TPL/SkillTempInfos.xml` |
| F7 | Momentum ("Estado de Guerrilha"/"Torcida"): per guild per fight, 112 uses; each attack or fortified attack by a member consumes 1 while uses remain and multiplies the HP loss by 5. Remaining shown = 112 - `bufferCount`, colored by thirds. (A) consumed on every attack, win or lose | `CrossGuildWarTopView.as:113-196`; `consortia.view.crossguild.war.bufferDescImageTxt` |
| F8 | Tower skins (`consortia_war_defence_skin` "1,2,2\|3,5,4\|6,8,1\|9,12,3"): look index by tower id range | `CrossGuildTowerInfo.as:74-83` |
| F9 | Tower art state: 1 if HP > 75%, 2 if > 20%, else 3; HP 0 = destroyed art; `attackCount > 0` = "being attacked" effect | `CrossGuildTowerInfo.as:84-95`; `CrossGuildWarTowerNodeView.as:230-260` |
| F10 | Attack record per member: count and score per attack type; score = HP removed (A) | `ConsortiaWarFightInfoMsg` |
| F11 | Contribution per action (A): `consortia_war_contribution` "15,30,15" (attack, fortified, interference), added to `guild.war_contribution` (war.md) | `TPL/ConfigInfos.xml` |
| F12 | Fight result: guild with more remaining HP wins (help). Each guild adds the HP its rival lost to its season score (war.md R11). (A) Equal HP = both lose or compare damage dealt | help text |
| F13 | Pairing (A): at the start of each preparation day, pair valid registered guilds across servers, by closest season score; odd guild out gets `isBye`. Team ids 0/1 assigned per match | `isBye`, `rivalServerName` fields |
| F14 | Interference quests: each tower shows a quest from `ConsortiaWarQuestTemplates` ("Conteúdo da missão: {0}"). (A) The interferer's formation must contain the required unit; after each interference a new quest is rolled | `CrossGuildAttackItem.as:196-203` |
| F15 | Seals: `sealList` values 1..6 = defender follower slots (Einherjars and Guardians, style `CrossGuildTowerDetailFrame.followImage1..6`). Sealed followers do not join the defender's battle formation | `CrossGuildTowerDetailFrame.as:174-183`; help text |
| F16 | Fortified attack grants the attacker extra skills for this attack only (A: skills unknown; candidate pool MasterType 309) | `CrossGuildAttackItem.descText.text1` |

## Templates

| File | Loaded by | Record meaning | Fields |
|---|---|---|---|
| `TPL/ConsortiaWarQuestTemplates.xml` (10 rows) | `CrossGuildWarQuestTempCate` (`CM/yishi/manager/TempleteManager.as:1289`; `getTemplateById`) | interference quest | `TemplateId`, `Type` (1 Einherjar element, 2 hero class (A), 3 goddess (A)), `Description` (pt-BR shown in "Conteúdo da missão: {0}"), `Para1` (Type 1: 101..106 fire, water, shock, wind, darkness, light; Type 2: 1..3; Type 3: 1), `Para2` 0 |
| `TPL/ConsortiaWarFightDrop.xml` | war.md | per fight reward | see war.md |
| `TPL/ConfigInfos.xml` | `ConfigInfoManager` | `consortia_war_*` keys | see war.md |

Sample: `<ConsortiaWarQuestTemplate TemplateId="10101" Type="1" Description="Levar Einherjar de fogo para o combate" Para1="101" Para2="0"/>`.

## Persistent state

Schema `guild`. Season tables are in war.md.

```sql
CREATE TABLE guild.war_match (
  id             bigserial PRIMARY KEY,
  season_id      integer  NOT NULL REFERENCES guild.war_season(id),
  fight_index    smallint NOT NULL CHECK (fight_index BETWEEN 1 AND 7),
  guild_team0_id integer   NOT NULL,                     -- red side
  guild_team1_id integer   NOT NULL,                     -- green side
  team0_name     text     NOT NULL,
  team0_server   text     NOT NULL,
  team1_name     text     NOT NULL,
  team1_server   text     NOT NULL,
  team0_blood    integer  NOT NULL,
  team1_blood    integer  NOT NULL,
  team0_max_blood integer NOT NULL,
  team1_max_blood integer NOT NULL,
  team0_momentum_used smallint NOT NULL DEFAULT 0,
  team1_momentum_used smallint NOT NULL DEFAULT 0,
  winner_team    smallint CHECK (winner_team IN (0, 1)),
  settled_at     timestamptz,
  UNIQUE (season_id, fight_index, guild_team0_id),
  UNIQUE (season_id, fight_index, guild_team1_id),
  CHECK (guild_team0_id <> guild_team1_id)
);

CREATE TABLE guild.war_tower (
  match_id        bigint   NOT NULL REFERENCES guild.war_match(id) ON DELETE CASCADE,
  team_id         smallint NOT NULL CHECK (team_id IN (0, 1)),
  tower_id        smallint NOT NULL CHECK (tower_id BETWEEN 1 AND 12),
  defender_user_id integer  NOT NULL,                    -- guild.war_defender.user_id
  defender_name   text     NOT NULL,
  fight_power     integer  NOT NULL,
  blood           integer  NOT NULL CHECK (blood >= 0),
  max_blood       integer  NOT NULL,
  loss_per_defeat integer  NOT NULL,
  quest_id        integer  NOT NULL,
  trouble_count   smallint NOT NULL DEFAULT 0 CHECK (trouble_count BETWEEN 0 AND 18),
  seals           smallint[] NOT NULL DEFAULT '{}',     -- values 1..6
  PRIMARY KEY (match_id, team_id, tower_id)
);

CREATE TABLE guild.war_tower_record (
  id           bigserial PRIMARY KEY,
  match_id     bigint   NOT NULL,
  team_id      smallint NOT NULL,
  tower_id     smallint NOT NULL,
  attacker_user_id integer NOT NULL,
  attacker_name text    NOT NULL,
  attack_type  smallint NOT NULL CHECK (attack_type IN (1, 2, 3)),
  attacker_won boolean  NOT NULL,
  blood_lost   integer  NOT NULL DEFAULT 0,
  battle_id    text,
  created_at   timestamptz NOT NULL DEFAULT now(),
  FOREIGN KEY (match_id, team_id, tower_id) REFERENCES guild.war_tower(match_id, team_id, tower_id)
);
CREATE INDEX war_tower_record_idx ON guild.war_tower_record (match_id, team_id, tower_id, id);

CREATE TABLE guild.war_player_day (
  season_id   integer  NOT NULL,
  fight_index smallint NOT NULL,
  user_id     integer   NOT NULL,
  guild_id    integer   NOT NULL,
  match_id    bigint   NOT NULL REFERENCES guild.war_match(id),
  spirit      smallint NOT NULL CHECK (spirit >= 0),
  buy_count   smallint NOT NULL DEFAULT 0 CHECK (buy_count BETWEEN 0 AND 3),
  count1 integer NOT NULL DEFAULT 0, score1 integer NOT NULL DEFAULT 0,
  count2 integer NOT NULL DEFAULT 0, score2 integer NOT NULL DEFAULT 0,
  count3 integer NOT NULL DEFAULT 0, score3 integer NOT NULL DEFAULT 0,
  PRIMARY KEY (season_id, fight_index, user_id)
);
CREATE INDEX war_player_day_match_idx ON guild.war_player_day (match_id, guild_id);
```

In memory: `battlefield_viewers: HashMap<match_id, HashSet<user_id>>` (opType 6 adds; opType 11, disconnect, battle start keep or remove as described below); `tower_attackers: HashMap<(match_id, team, tower), HashSet<user_id>>` for `attackCount`; per-match mutex for HP updates.

## Backend implementation notes

| opType | Handler |
|---|---|
| 6 | `guild::cross_server_war::handle_enter_war` |
| 7 | `guild::cross_server_war::handle_buy_spirit` |
| 8 | `guild::cross_server_war::handle_attack_tower` (branches on `attackType`) |
| 9 | `guild::cross_server_war::handle_view_tower` |
| 10 | `guild::cross_server_war::handle_view_fight_rank` |
| 11 | `guild::cross_server_war::handle_leave_war` |
| battle end callback | `guild::cross_server_war::on_attack_battle_end` |
| scheduler | `guild::cross_server_war::create_matches`, `guild::cross_server_war::settle_matches` |

Validation order (opType 6..10): in a guild -> season state 6 -> guild registered, `is_valid`, not bye, has a match -> (attacks) inside the fight window -> tower belongs to the rival team -> tower HP > 0 -> spirit >= cost -> (interference) trouble_count < 18 and quest requirement (A) -> act.

- `handle_enter_war`: create `war_player_day` on first entry with `spirit = max_spirit(player)` (F2); add to viewers; reply 4569.
- `handle_buy_spirit`: `spirit < max`, `buy_count < 3`, diamonds >= 150. Transaction: debit diamonds, `spirit = max`, `buy_count += 1`. Reply 4572 `{spirit, buyCount}`.
- `handle_attack_tower` (attackType 1/2): transaction: `spirit -= cost`; add to `tower_attackers`. Push 4572 (tower `attackCount`) to viewers of both guilds and 4572 `{spirit}` to the attacker. Start battle 296 (config below). Do not hold a DB transaction during the battle.
- `on_attack_battle_end`: transaction under the match mutex: if attacker won and tower HP > 0, apply F6 (momentum if `momentum_used < 112`, then increment), update `war_tower.blood`, team blood, `war_tower_record`, `war_player_day` counts/scores, `war_contribution` (F11). Remove from `tower_attackers`. After commit push 4572 `{teamId, blood, towerData, bufferCount}` to all viewers of both guilds. A defeat records `attacker_won=false`, `blood_lost=0`.
- Interference (attackType 3): transaction: `spirit -= 1`, `trouble_count += 1`, every 3rd adds a random unsealed slot to `seals`, roll a new `quest_id`, record row (attackType 3), stats count3/score3 (A: score3 = contribution). Push 4572.
- `handle_view_tower`: reply 4571 with the last N records (A: 20).
- `handle_view_fight_rank`: reply 4570 from `war_player_day` of both guilds in the match.
- `handle_leave_war`: remove from viewers; no reply.
- Disconnect: remove from viewers and `tower_attackers` (abort the battle as the engine does).

Push routing: 4572 tower/blood changes go to every online member of both guilds currently in `battlefield_viewers[match]` (players in the 296 battle stay registered, since they return to the scene; A: queue or drop while in battle, the client ignores 4572 outside the scene only when teams are not loaded). Spirit/buy fields only to the acting player. 4573 at the end of state 6 goes to all viewers.

Schedules: `create_matches` at state 5 -> 6 transition (00:10 of fight day): build `war_match` and 24 `war_tower` rows from `war_defender` (tower HP and loss from F5, quest roll). `settle_matches` at fight day end: winner by remaining HP, `war_round_entry.result`/`score_gain` for both guilds (score = HP the rival lost), FightDrop mail (war.md R15), push 4573.

Battle rule config for battleType 296 (engine config shape: `docs/battle/server-engine.md` section 9.2):

| Key | Value |
|---|---|
| `battle_type` | 296 |
| `map` | (A) any PvP map id; the client has no map table for 296. Use the arena map used by rule 8253 (3) until confirmed |
| `side` | 1 (attacker) |
| `count_down` | 180 (A) |
| `auto` | false (A) |
| heroes, soldiers (attacker) | the attacker's current formation, plus fortified skills when `attackType == 2` (A) |
| heroes, soldiers (defender) | `war_defender.formation` snapshot of the tower's defender, minus followers in `war_tower.seals`; apply the guild strategy skill (`defend_buff_id`, MasterType 308) and personal bonus (`user_buff_id`, MasterType 309) as battle buffs |
| `report` | `BattleReportMsg` win/lose; no item rewards (rewards are per fight and per season) |
| exit | client returns to `CROSS_GUILD_SCENE` by itself (`BattleResultHandler.as:261-269`) |

Cross-area dependencies: war.md (season, registration, defenders), core guild membership (`CONSORTIA_CHANGE` kicks the player out of the scene, `CrossGuildWarSceneView.as:69-76`), battle engine (296), army/formation (snapshot and attacker formation), diamonds (economy), player job transfer fields `isChangeJob`/`vocationGrades` (F2).

## Open questions

1. Exact HP loss modifiers of each strategy/bonus skill and whether they apply in the battle or in F6.
2. Is momentum consumed on a lost attack? Is `bufferCount` per guild or per player (the client shows it as a guild counter)?
3. Fortified attack: which extra skills does the attacker get?
4. Interference quest semantics: is the quest a precondition (formation must contain the unit) or a bonus? How is a seal slot chosen?
5. Does `attackCount > 0` block the HP change of a second concurrent attacker ("talvez não afete sua durabilidade e não ganhe pontos")? Proposed: only the first finished victory per tower state applies.
6. Pairing algorithm across servers and handling of an odd number of guilds.
7. Tie-break when both guilds keep equal HP.
8. Map id and `count_down` for battleType 296.
9. Daily reset of `spirit` and `buy_count`: per fight day (proposed) or daily at midnight.

## Implementation checklist

Client (present, verify):
- [ ] Enter flow from activity item 5 and top bar (opType 6 -> 4569 -> scene)
- [ ] CrossGuildWarSceneView with 24 tower nodes, skins and states
- [ ] CrossGuildWarTopView HP bars, timer window, momentum counter
- [ ] CrossGuildWarLeftView spirit bar and buy flow (opType 7)
- [ ] CrossGuildTowerAttackFrame three actions (opType 8, attackType 1/2/3)
- [ ] CrossGuildTowerDetailFrame (opType 9)
- [ ] CrossGuildWarAttackRecordFrame (opType 10)
- [ ] Exit dialog (opType 11) and battle return to the scene

Backend:
- [ ] `guild::cross_server_war::handle_enter_war` -> 4569
- [ ] `guild::cross_server_war::handle_buy_spirit` -> 4572
- [ ] `guild::cross_server_war::handle_attack_tower` (attack, fortified) -> 4572 + battle 296
- [ ] `guild::cross_server_war::handle_attack_tower` (interference) -> 4572
- [ ] `guild::cross_server_war::on_attack_battle_end` -> HP, records, stats, contribution, 4572 broadcast
- [ ] `guild::cross_server_war::handle_view_tower` -> 4571
- [ ] `guild::cross_server_war::handle_view_fight_rank` -> 4570
- [ ] `guild::cross_server_war::handle_leave_war`
- [ ] `create_matches` (pairing, byes, towers) and `settle_matches` (winner, score, FightDrop)
- [ ] Battle rule for battleType 296 in the engine (formation snapshot, seals, buffs)
- [ ] Tables `war_match`, `war_tower`, `war_tower_record`, `war_player_day`
- [ ] Viewer registry and per-match lock
- [ ] Template loader ConsortiaWarQuestTemplates; config keys `consortia_war_sprite_config`, `consortia_war_attack_config`, `consortia_war_defence`, `consortia_war_defence_skin`, `consortia_war_attack_buff`, `consortia_war_fight_time`, `consortia_war_contribution`
- [ ] Do not implement legacy opcodes 8778, 8779, 8782, 8783, 25109, 4439, 4440, 4441, 4832
