# Guild war: season, signup and defense policy ("Defesa de Guilda")

Module: `guild::war`. Protobuf package `com.road.yishi.proto.consortiawar`. Client manager `yishi.manager.CrossGuildManager`.

Citation prefixes: `CM/` = `decompiled/core_module/scripts/`, `M6/` = `decompiled/m6/scripts/`. `TPL/` = `raw/xml/tempinfos/`. `LANG` = `index/language.json`. "(A)" marks an assumption that the client code does not prove.

## Overview

The guild war of this client is the "new cross-server guild war" (`【新版跨服公会战】` in `TPL/ConfigInfos.xml`), shown to players as **Defesa de Guilda** (`ui.toptoolbar.TopToolsBar.tipData_crossgvg`). It has no separate "local" guild war: the `consortiawar` protobuf package, opcode 8650 and the `CrossGuild*` UI classes are one feature. This roadmap splits it in two modules:

- **This file (`war.md`)**: the season layer. Season state machine, signup, preparation day (guild strategy, 12 defenders and their personal bonuses), season guild ranking, attack contribution ranking, and all reward templates.
- **[cross-server-war.md](cross-server-war.md)**: the fight day. Cross-server pairing, the battlefield scene `CROSS_GUILD_SCENE`, the 12 towers per guild, attacks (battleType 296), interference, action points, momentum, live updates.

Both modules share the request opcode **8650** (`ConsortiaWarClientOpMsg.opType` selects the action) and the push opcodes 4566 to 4573.

Player rules (help text `CrossGuild.helperFrame.helpTxt.text`, LANG, verbatim excerpts):

- "Cada temporada da Defesa da Guilda dura 2 semanas e tem 7 batalhas de 1 dia cada uma."
- "Antes de cada disputa começar há 1 dia de preparo, quando o líder pode selecionar a estratégia de defesa, os 12 membros que entraram com o maior Poder de Combate podem selecionar o bônus de defesa; após selecionadas a estratégia e bônus estes não podem ser mudados."
- "Participando de ataques e interferência, pode-se ganhar pontos de contribuição. Os prêmios no fim da temporada são distribuídos de acordo com a contribuição individual. Os membros que entraram na guilda nos últimos 4 dias da temporada não podem ganhar os prêmios."
- "Ao fim de uma disputa, a quantidade de vida que a guilda adversária perde é a quantidade de pontos que sua guilda ganha. A premiação das guildas é enviada ao fim da temporada de acordo com o ranking de pontos."

Entry points:

| Entry | Condition | Code |
|---|---|---|
| Guild activity list, item id 5 (`ConsortiaViewHelper.CROSS_GUILD`) | `VersionSwitch.CROSS_GUILD = true` (`CM/yishi/datas/VersionSwitch.as:132`) | `CM/mvc/module/consortia/ConsortiaViewHelper.as:79-82,169-204` |
| Top bar button `crossgvg` | `VersionSwitch.CROSS_GUILD && thane.grades >= 13 && checkIsRightScene() && state != 1` | `CM/ui/toptoolbar/TopBtnCheckShowHelper.as:271-272`; click `CM/ui/toptoolbar/TopToolsBar.as:1182-1184` |
| Both call `ConsortiaViewHelper.openCrossGuildHandler` | routing table in Rules R2 | `CM/mvc/module/consortia/ConsortiaViewHelper.as:206-243` |

Client bootstrap: `CrossGuildManager.setup()` is called at login (`CM/yishi/lunch/Yishi.as:460`) and registers listeners for 4566 to 4573 (`CM/yishi/manager/CrossGuildManager.as:71-81`). The manager clears its model when the player leaves the guild (`CONSORTIA_CHANGE` with `consortiaID <= 0`, `CrossGuildManager.as:84-90`, `CM/mvc/module/crossguild/CrossGuildModel.as:247-263`).

## Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `consortia.view.crossguild.CrossGuildSignFrame` (520x420) | Defesa de Guilda | Signup: season number, signup end date, cost, sign button, policy and reward buttons | controller `crossguild` openType 1 (`CM/mvc/controler/CrossGuildControler.as:19-30`) | `season`, `signEndTime` ("Começa em {0}, dura 2 semanas"), cost "Condições de Inscrição: Gasto de {0} de Fortuna da Guilda" (`consortia_war_sign_offer`), "Início das inscrições: {0}" when state 1, signed flag (`M6/consortia/view/crossguild/CrossGuildSignFrame.as:198-224`) |
| `consortia.view.crossguild.view.CrossGuildSignItem` (inside Sign) | | Describes the only sign type | Sign frame (`CrossGuildSignFrame.as:116-127`) | "Antes do combate você pode escolher {0} membros para o Ponto de Defesa, durante o combate todos os membros podem participar do ataque" with `defendNum` 12 |
| `consortia.view.crossguild.CrossGuildPolicyFrame` (820x625) | Defesa de Guilda | Preparation hub: season panel, guild strategy, defender list, personal bonus grid | controller `crossguild` openType 2 | 4566 + 4573 data (`M6/consortia/view/crossguild/CrossGuildPolicyFrame.as:59-237`) |
| `consortia.view.crossguild.view.CrossGuildSeasonView` (panel) | | Season number, state text and countdown, own score vs rival score, buttons Contribution and Ranking | Policy frame | `state`, `endTime`, `fightIndex`, `selfGuild.score`, `vsGuild` (`M6/consortia/view/crossguild/view/CrossGuildSeasonView.as:114-247`) |
| `consortia.view.crossguild.view.CrossGuildDefendListView` (panel) | | 12 defenders: rank, head, name, fight power, bonus | Policy frame | `defenderList` (`M6/consortia/view/crossguild/view/CrossGuildDefendListView.as:60-125`) |
| `consortia.view.crossguild.view.CrossGuildBufferView` (panel) | | Grid of personal defense bonuses (skill MasterType 309), paged | Policy frame | `userBuffers` or all MasterType 309 (`CrossGuildModel.as:227-245`) |
| `consortia.view.crossguild.view.CrossGuildBufferSelectFrame` (490x465) | Seleção de estratégia de defesa | Chairman picks the guild strategy (skill MasterType 308) | Policy frame modify button | MasterType 308 skills (`M6/consortia/view/crossguild/view/CrossGuildBufferSelectFrame.as:55-71`) |
| `consortia.view.crossguild.view.CrossGuildRankFrame` (483x406) | Ranking e prêmios | Tabs: Ranking, season rewards, single fight rewards, contribution rewards | Sign frame reward button; Season panel rank button | 4567 + templates (`M6/consortia/view/crossguild/view/CrossGuildRankFrame.as:42-121`) |
| `consortia.view.crossguild.view.CrossGuildAttackContributionFrame` (483x433) | Contribuição do ataque | Member contribution ranking | Season panel contribution button | 4568 (`M6/consortia/view/crossguild/view/CrossGuildAttackContributionFrame.as:42-120`) |
| Space map statue (`map.space.view.SpaceSceneMapView`, `SpaceNpcView`) | | Shows last season champion guild name "＜{0}＞" and server | always, when `first` is set | 4573 `first` (`decompiled/m3/scripts/map/space/view/SpaceSceneMapView.as:385-401`; `.../physics/SpaceNpcView.as:58-80`) |

Help frame: style `CrossGuild.helperFrame`, help button tip "Ajuda da defesa de Guilda".

## Actions

All requests go to **C to S 8650 (0x21CA) `C_CONSORTIA_WAR_CLIENT_OP`** with body `ConsortiaWarClientOpMsg`:

| Field | Tag | Type | Meaning |
|---|---|---|---|
| `opType` | 1 | INT32 | action (constants `CM/mvc/module/crossguild/CrossGuildConstClass.as:18-42`): 1 REQUEST_DATA, 2 SIGN, 3 SET_GUILD_BUFFER, 4 VIEW_SEASON_RANK, 5 VIEW_CONTRIBUTE_RANK, 6 ENTER_WAR, 7 BUY_SPIRIT, 8 ATTACK_TOWER, 9 VIEW_TOWER, 10 VIEW_FIGHT_RANK, 11 LEAVE_WAR, 12 SET_USER_BUFF, 13 LEAVE_SET_POLICY |
| `signType` | 2 | INT32 | opType 2 only: 1 = 12 defenders (12v12), the only value the client sends |
| `bufferId` | 3 | INT32 | opType 3 and 12: skill TemplateId; 0 on opType 12 = give up |
| `towerId` | 4 | INT32 | opType 8, 9 (see cross-server-war.md) |
| `teamId` | 5 | INT32 | opType 8, 9 |
| `attackType` | 6 | INT32 | opType 8 |
| `payType` | 7 | INT32 | never set by the client |

Senders in `CM/yishi/manager/CrossGuildManager.as`: `sendCrossGuildSign` :512-519, `sendFrameRequest` :521-527, `sendBufferSelect` :529-536, `sendCrossGuildWar` :546-552. This module owns opTypes 1, 2, 3, 4, 5, 12, 13. opTypes 6 to 11 are in [cross-server-war.md](cross-server-war.md).

There is no result code in any response. On failure the client shows nothing specific (no error handler for 8650). The server should reject silently or send the project-wide notice (A: 126 `U_C_MSG` `CampaignNotifyMsg`, handled by `CM/yishi/manager/BaseManager.as:2070-2085`; verify its rendering in the core module) and then resend the authoritative 4573/4566 so the UI reverts.

| # | Action | UI control | Client sender | Client checks | Request | Responses (in order) |
|---|---|---|---|---|---|---|
| A1 | Open the war entry | activity item id 5 join, or top bar `crossgvg` | `ConsortiaViewHelper.openCrossGuildHandler` (`ConsortiaViewHelper.as:206-243`) | `consortiaID != 0`, else tip "Você ainda não juntou-se à uma Guilda!" (`room.view.invite.RoomInviteFrame.command01`). Routing R2 | none, or opType 6 on fight day (cross-server-war.md) | none (frames use cached 4573/4566) |
| A2 | Sign up the guild | Sign frame `_signBtn` | `CrossGuildSignFrame._signBtnClickHandler` (`CrossGuildSignFrame.as:193-197`) -> `sendCrossGuildSign(1)` | Button enabled only if `consortiaInfo.chairmanID == userId` or `consortiaController.getRightsByNum(20)` (`CrossGuildSignFrame.as:214`). Hidden when `signType != 0` (:215-224). No state or wealth check | `{opType:2, signType:1}` | 4573 to every online guild member with `signType=1` (frame swaps to "already signed") (A: plus the guild wealth update of the core module) |
| A3 | Open the policy frame | `openControllerByInfo("crossguild",2)` | `CrossGuildPolicyFrame` constructor (`CrossGuildPolicyFrame.as:59-65`) -> `sendFrameRequest(1)` | none | `{opType:1}` | 4566 `ConsortiaWarDataMsg` with `opType=1` |
| A4 | Close the policy frame | frame close | `CrossGuildPolicyFrame.dispose` (`:232-237`) -> `sendCrossGuildWar(13)` | none | `{opType:13}` | none. Server removes the user from the "policy viewers" push set |
| A5 | Pick the guild strategy | `CrossGuildBufferSelectItem` select | `CrossGuildBufferSelectItem.__selectSkillHandler` (`M6/consortia/view/crossguild/view/CrossGuildBufferSelectItem.as:74-81`) -> `sendBufferSelect(3, TemplateId)` | Modify button visible only to the chairman (`CrossGuildPolicyFrame.as:169`). Select enabled only if `TemplateId != selfGuildBufferId && state == 4 && signType != 0` (`CrossGuildBufferSelectItem.as:99`) | `{opType:3, bufferId}` (MasterType 308 skill) | 4566 with `opType=3`, `defendBuffer=bufferId` to all policy viewers of the guild |
| A6 | Pick a personal defense bonus | `CrossGuildBufferItem` select | `CrossGuildBufferItem.__selectSkillHandler` (`M6/consortia/view/crossguild/view/CrossGuildBufferItem.as:88-95`) -> `sendBufferSelect(12, TemplateId)` | Enabled only if `state == 4` and the player is in `defenderList` (`:142`). A bonus held by another defender shows that defender's name and no button (`:120-136`) | `{opType:12, bufferId}` (MasterType 309 skill) | 4566 with `opType=12` (client keeps the bonus page, `CrossGuildPolicyFrame.as:145-158`) to all policy viewers |
| A7 | Give up own bonus | "Desistir" link (`CrossGuildBufferItem.giveUpText.text`) | `CrossGuildBufferItem._giveUpClickHandler` (`:97-103`) -> `sendBufferSelect(12, 0)` | only the holder, only if `state != 5 && state != 6` (`:127`) | `{opType:12, bufferId:0}` | 4566 `opType=12` |
| A8 | View season ranking | Sign frame reward button; Season panel rank button | `CrossGuildRankFrame` constructor (`CrossGuildRankFrame.as:42-48`) -> `sendFrameRequest(4)` | none | `{opType:4}` | one or more 4567 with the same `uuid` |
| A9 | View contribution ranking | Season panel contribution button | `CrossGuildAttackContributionFrame` constructor (`CrossGuildAttackContributionFrame.as:42-46`) -> `sendFrameRequest(5)` | none | `{opType:5}` | 4568 |
| A10 | Switch reward tabs | Rank frame tabs | `CrossGuildRankFrame.__tabChangeHandler` (`:98-121`) | none | none (templates only) | none |
| A11 | Open help | help button | `CrossGuildSignFrame.__helpClickHandler` (`:165-170`) | none | none | none |

## Server messages

All S to C. Receivers in `CM/yishi/manager/CrossGuildManager.as`. Strings in dates use `"YYYY-MM-DD hh:mm:ss"` (parsed with `DateFormatter.parse`).

### 4573 (0x11DD) `U_C_CONSORTIA_WAR_SEASON_DATA`, `ConsortiaWarSeasonMsg`

Receiver `__crossGuildSeasonHandler` (:92-160). Every field is optional (`has*` checked) except `first`, which is reset to null when absent.

| Field | Tag | Type | Meaning / client effect |
|---|---|---|---|
| `opType` | 1 | INT32 | unused by the client |
| `seasonId` | 2 | INT32 | season number shown as digits (`model.season`) |
| `seasonStartTime` | 3 | STRING | unused by the client |
| `seasonStopTime` | 4 | STRING | unused by the client |
| `signStartTime` | 5 | STRING | "Início das inscrições: {0}" and activity text "As inscrições começam dia {1}/{0} às 00:10" |
| `signStopTime` | 6 | STRING | "Começa em {0}, dura 2 semanas" |
| `state` | 7 | INT32 | 1 SEASON_EVE, 2 SIGN, 3 PRE_EVE, 4 PRE, 5 FIGHT_EVE, 6 FIGHT (`CrossGuildConstClass.as:6-16`) |
| `startTime` | 8 | STRING | `model.openTime`, start of the current phase |
| `stopTime` | 9 | STRING | `model.endTime`, end of the current phase; countdown in states 2, 4, 6 (`CrossGuildSeasonView.as:225-240`) |
| `fightIndex` | 10 | INT32 | fight number 1..7 ("({1}ª disputa da temporada)") |
| `signType` | 11 | INT32 | 0 not signed, 1 signed 12v12 (own guild) |
| `first` | 12 | `ConsortiaWarScoreInfoMsg` | last season champion: `order`, `consortiaUid`, `consortiaName`, `serverName`, `score`; drives the space map statue |
| `buffEndTime` | 13 | STRING | end of the champion buff (`crossGuildBufferEndDate`) |
| `isBye` | 14 | BOOL | own guild has no opponent this fight |
| `isValid` | 15 | BOOL | own guild qualified for this fight (enough defenders) |

When: push at login, on every phase change (to every online player, since the top bar uses `state`), and to every online member of a guild whose `signType`, `isBye` or `isValid` changes. Side effect: if `state != 6` while the client is in the battlefield, the client leaves `CROSS_GUILD_SCENE` (buffered until the scene is active, :151-158). Notifies `CROSS_GUILD_MAIN_CHANGE` (activity list, top bar, Sign/Policy frames).

### 4566 (0x11D6) `U_C_CONSORTIA_WAR_DATA`, `ConsortiaWarDataMsg`

Receiver `__crossGuildMainHandler` (:167-215).

| Field | Tag | Type | Meaning / client effect |
|---|---|---|---|
| `opType` | 1 | INT32 | echo of the request opType; 12 keeps the bonus grid page (`CrossGuildPolicyFrame.as:145-158`) |
| `defendBuffer` | 2 | INT32 | guild strategy skill id (MasterType 308); 0 = none (client then shows the first 308 skill, `CrossGuildModel.as:181-192`) |
| `userBuffers` | 3 | INT32 repeated | personal bonus skill ids offered (MasterType 309). Empty = client shows all 309 skills (`CrossGuildModel.as:227-245`) |
| `score` | 4 | INT32 | own season score |
| `isBye` | 5 | BOOL | as in 4573 |
| `isValid` | 6 | BOOL | as in 4573 |
| `rivalConsortiaName` | 7 | STRING | current opponent; empty = none (client shows "Não existe uma rodada atualmente" if bye, else "-") |
| `rivalServerName` | 8 | STRING | opponent server |
| `rivalScore` | 9 | INT32 | opponent season score |
| `defenderList` | 10 | `ConsortiaWarDefenderMsg` repeated | `userId` (#1 INT32), `nickName` (#2 STRING), `headId` (#3 INT32), `fightPower` (#4 INT32), `bufferId` (#5 INT32, chosen bonus or 0). Client sorts by `fightPower` desc |

When: response to opTypes 1, 3, 12; push to every guild member currently viewing the policy frame (between opType 1 and 13) when strategy, bonuses or defenders change, and at the start of state 4 when defenders are selected.

### 4567 (0x11D7) `U_C_CONSORTIA_WAR_SEASON_RANK`, `ConsortiaWarScoreRankMsg`

Receiver `__seasonRankHandler` (:217-240). `uuid` (#1 STRING): snapshot id; a different uuid clears the list, the same uuid appends (paging). `rankList` (#2 repeated `ConsortiaWarScoreInfoMsg`: `order` #1 INT32, `consortiaUid` #2 STRING, `consortiaName` #3 STRING, `serverName` #4 STRING, `score` #5 INT32). Client sorts by `order`. Response to opType 4.

### 4568 (0x11D8) `U_C_CONSORTIA_WAR_CONTRIBUTE_RANK`, `ConsortiaWarContributeRankMsg`

Receiver `__contributionRankHandler` (:242-261). `rankList` (#1 repeated `ConsortiaWarContributeInfoMsg`: `userId` #1 INT32, `nickName` #2 STRING, `headId` #3 INT32, `fightPower` #4 INT32, `contribute` #5 INT32). Client sorts by `contribute` desc; empty shows "Sem recorde de ataque". Response to opType 5. Scope: own guild members, current season.

### Opcodes of the same package handled in cross-server-war.md

4569 `U_C_CONSORTIA_WAR_FIGHT_DATA`, 4570 `U_C_CONSORTIA_WAR_FIGHT_RANK`, 4571 `U_C_CONSORTIA_WAR_TOWER_DATA`, 4572 `U_C_CONSORTIA_WAR_UPDATE`.

## Rules and formulas

| # | Rule | Source |
|---|---|---|
| R1 | Season states: 1 SEASON_EVE (before signup), 2 SIGN (signup open), 3 PRE_EVE ("O dia de preparação começa em 10 minutos"), 4 PRE (preparation day), 5 FIGHT_EVE ("O dia de combate começa em 10 minutos"), 6 FIGHT (fight day). Season = 2 weeks = 7 fights; each fight = 1 preparation day (state 4) + 1 fight day (state 6). (A) The EVE states are the 10 minutes from 00:00 to 00:10 before each day; signup opens at 00:10 ("às 00:10") | `CrossGuildConstClass.as:6-16`; LANG `CrossGuildSeasonView.stateText.text3/5`, `ConsortiaActivityListView.crossGuildAcitveItem.text1`, help text |
| R2 | Entry routing: not signed (`signType == 0`) -> Sign frame. Signed: state 1 -> Sign frame; states 2, 3, 4, 5 -> Policy frame; state 6 and (`isBye` or `!isValid`) -> Policy frame; state 6 otherwise -> opType 6 ENTER_WAR | `ConsortiaViewHelper.as:213-242` |
| R3 | Activity list prompt: state 1 -> "As inscrições começam dia {1}/{0} às 00:10" (month, day of `signStartTime`); state 2 -> "Data de inscrição"; signed and state 3/4 -> "Dia de preparação"; signed and state 5/6 -> "Dia de combate"; else "Não-inscrito nesta temporada" | `ConsortiaViewHelper.as:169-204` |
| R4 | Top bar button visible if `grades >= 13` and `state != 1`. Badge: state 2 signed -> `braveleg.Tip.sign`; state 4/6 signed -> "Dia de preparação"/"Dia de combate"; not signed -> `toptoolbar.topBtn.matelords.stateText2` | `TopBtnCheckShowHelper.as:271-272`; `CM/ui/toptoolbar/TopBtnItemView.as:366-390` |
| R5 | Signup permission: chairman, or a member with extended guild right 20 "Inscrições para Defesa de Guilda". `getRightsByNum(20)` = own rights bit 19 (1-based) set AND the vice-chairman duty (`consortiaDutyList[2]`) `rightsStr` contains 20. Right 20 is delegable by the chairman to the vice-chairman only (rights 20, 41, 43, 45, 46) | `CrossGuildSignFrame.as:214`; `CM/mvc/controler/ConsortiaControler.as:568-593`; `M6/consortia/view/myConsortia/ConsortiaSettingItem.as:99-120`; LANG `ConsortiaSettingItem.txt.text13` |
| R6 | Signup cost: `consortia_war_sign_offer` = 150000 guild Fortuna (client default 10000 if the key is missing). Server must check and debit guild wealth atomically. Signup only in state 2 (A) | `CM/yishi/datas/ConfigInfoManager.as:1008-1015`; `TPL/ConfigInfos.xml` |
| R7 | Sign types: only 1 (12 defenders). `defendNum = 12` when `signType == 1`, else 0 | `CrossGuildModel.as:172-179`; `CrossGuildSignFrame.as:116-127` |
| R8 | Defenders: at the start of each preparation day the server selects the 12 guild members with the highest fight power (help text). They defend towers 1..12 (A: tower 1 = highest fight power, matching the highest tower HP). If fewer than 12 qualify the guild is invalid for that fight: state 4 text "Defensores insuficientes, é necessário busca mais membros da guilda, senão não será possível entrar na temporada"; invalid text "Membros da defesa do combate anterior insuficientes, não pode entrar nesta temporada" | help text; `CrossGuildDefendListView.as:60-96` |
| R9 | Guild strategy (opType 3): chairman only, state 4 only, any MasterType 308 skill different from the current one; fixed after the preparation day. 4 strategies: 618101 "Pronto para a ação", 618201 "Armadilha", 618301 "Ataque como defesa", 618401 "Sobrevivência extrema" | `CrossGuildBufferSelectItem.as:99`; `CrossGuildPolicyFrame.as:169`; `TPL/SkillTempInfos.xml` |
| R10 | Personal bonus (opType 12): only defenders, state 4 only; each bonus skill can be held by one defender of the guild at a time; a defender holds at most one; giving up (bufferId 0) allowed while state is not 5/6. 27 MasterType 309 skills (619101..619903, 9 families x grades 2..4). `userBuffers` lets the server restrict the offered set | `CrossGuildBufferItem.as:88-145`; `CrossGuildModel.as:118-121,227-245` |
| R11 | Season score: after each fight the guild gains the HP its opponent lost in that fight (help text). (A) A bye grants `cross_guild_bye_score` = 10000 (config of the old cross guild war; confirm) | help text; `TPL/ConfigInfos.xml` |
| R12 | Contribution: earned by attacks and interference. (A) Per action: `consortia_war_contribution` = "15,30,15" (attack, fortified attack, interference); not read by the client | `TPL/ConfigInfos.xml` |
| R13 | Season rank rewards: `TPL/ConsortiaWarSeasonDrop.xml` by rank range (`para2`), mailed at season end. Rank 1 also gets four honors (client pseudo ids 1..4): "Dominante do Céu", "Coração do Povo", "Aura do Rei", "Dom do Demónio" (7 days); rank 2 gets "Dom do Demónio" (5 days); rank 3 "Dom do Demónio" (3 days) (`RANK_TEMP4_DAYS = [7,5,3]`). Honor durations in LANG say 3 days for items 1..3 | `M6/consortia/view/crossguild/view/CrossGuildCommonRewardItem.as:72-100`; `RankIconRewardItem.as:60-80`; `CrossGuildModel.as:25` |
| R14 | Champion effects: 4573 `first` shows the champion name on the space map; `buffEndTime` ends the champion buff. "Dom do Demónio" is a player buffer with `bufferType == 40004` ("Prêmio de ativação da Terra dos Sonhos pela Guilda +100%") | `SpaceSceneMapView.as:385-401`; `CM/yishi/datas/playerinfo/PlayerBufferInfo.as:176-178,229-231` |
| R15 | Single fight rewards: `TPL/ConsortiaWarFightDrop.xml`, `site` 0 = win, 1 = bye, 2 = loss (titles `CrossGuild.CrossGuildRankRewardItem.titleText.text20/21/22` "Vitória"/"Vazio"/"Fracasso"; the reward tab hides site 1). Granted to (A) every member who took part in the fight, at fight end | `CM/yishi/datas/templates/cate/CrossGuildSingleRewardTempCate.as`; `CrossGuildCommonRewardItem.as:42-60` |
| R16 | Contribution rewards: `TPL/ConsortiaWarUserDrop.xml`, `para2` = contribution range "min,max", mailed at season end; members who joined the guild in the last 4 days of the season get nothing | help text; `CrossGuildContributionRewardTempCate.as` |
| R17 | Leaving the guild closes all war frames and clears client war state | `CrossGuildSignFrame.as:157-163`; `CrossGuildPolicyFrame.as:120-126`; `CrossGuildManager.as:84-90` |
| R18 | Reward currency: item -2900 "Pedra da Coragem" = currency 31 `NEW_CROSS_GUILD_COIN` (shop "Loja da defesa de guilda", economy module). -3600 "Ouro de Yalamen" (`RANK_REWARD_TEMPID`) | `CrossGuildModel.as:13-15`; `CM/mvc/module/currency/CurrencyType.as`; `TPL/ItemTempInfos.xml` |

Config keys read by the client (`CM/yishi/datas/ConfigInfoManager.as`), values from `TPL/ConfigInfos.xml`:

| Key | Value | Use |
|---|---|---|
| `consortia_war_sign_offer` | 150000 | signup guild Fortuna (:1008-1015) |
| `consortia_war_fight_time` | `5:00,23:00` | daily fight window on fight day (:1297-1304) |
| `consortia_war_sprite_config` | `4,3,150,3,2` | action points (cross-server-war.md) |
| `consortia_war_attack_config` | `1,2,1,3` | attack costs (cross-server-war.md) |
| `consortia_war_defence` | `1,1,7120,89\|2,3,6640,83\|4,5,5600,70\|6,7,5120,64\|8,8,4640,58\|9,9,4160,52\|10,12,3600,45\|` | tower HP and HP lost per defeat |
| `consortia_war_defence_skin` | `1,2,2\|3,5,4\|6,8,1\|9,12,3` | tower look |
| `consortia_war_attack_buff` | `5,112` | momentum (x5, 112 uses) |
| `consortia_war_contribution` | `15,30,15` | server only (R12) |

The `cross_guild_*` keys (action points, moves, skills, weekday 6, time 20:00-21:00) belong to the old node-based cross guild war; only `cross_guild_bye_score` may still apply (A).

## Templates

| File | Loaded by | Record meaning | Fields used |
|---|---|---|---|
| `TPL/ConsortiaWarSeasonDrop.xml` (7 rows) | `CrossGuildRewardTempCate` (`CM/yishi/manager/TempleteManager.as:1286`) | season guild rank reward per rank range | `id`, `dropId` (16701..16707), `site` 0, `para2` rank range ("1", "2", "3", "4,10", "11,25", "26,50", "51,1000"), `itemId` -2900, `count` 2500/2000/1750/1500/1250/1000/650, `isBind`, `appearType`, `validDate`, `isShow` |
| `TPL/ConsortiaWarFightDrop.xml` (12 rows) | `CrossGuildSingleRewardTempCate` (`TempleteManager.as:1287`) | per fight reward by result | `dropId` 16800 bye / 16801 win / 16802 loss; `site` 1 bye / 0 win / 2 loss; items -2900 (225/300/150), 208001 "Medalhas" (900/1200/600), 208017 "Pedra Bestial" (70/90/45), 2032201 "Medalha de Fama" (3/4/3) |
| `TPL/ConsortiaWarUserDrop.xml` (9 rows) | `CrossGuildContributionRewardTempCate` (`TempleteManager.as:1288`) | contribution reward per range | `para2` "min,max" (491,2000 / 430,490 / 350,429 / 260,349 / 170,259 / 140,169 / 120,139 / 90,119 / 45,89), `itemId` 208104 "Emblema da Guilda", `count` 75/65/60/55/50/45/40/30/20 |
| `TPL/ConsortiaWarQuestTemplates.xml` | `CrossGuildWarQuestTempCate` (`TempleteManager.as:1289`) | interference quests (cross-server-war.md) | `TemplateId`, `Type`, `Description`, `Para1`, `Para2` |
| `TPL/SkillTempInfos.xml` MasterType 308 / 309 | `TempleteManager.getSkillsByMasterType` (`CrossGuildModel.as:118-121`) | guild strategies / personal bonuses | `TemplateId`, `TemplateName`, `Description`, `Icons`, `Grades` (frame shown when > 1) |
| `TPL/ConfigInfos.xml` | `ConfigInfoManager` | config table above | `ConfigName`, `ConfigValue` |

Sample row: `<ConsortiaWarSeasonDropInfo id="1670401" dropId="16704" site="0" para2="4,10" itemId="-2900" count="1500" isBind="1" appearType="1" validDate="0" isShow="0"/>`.

## Persistent state

Schema `guild`. `guild.guild(id)` (integer, [profile.md](profile.md)), `guild.member` ([membership.md](membership.md)) and `public.player(id)` (integer) are defined elsewhere; ids here use `integer` to match them.

```sql
CREATE TABLE guild.war_season (
  id               serial PRIMARY KEY,
  season_no        integer NOT NULL UNIQUE,              -- seasonId sent to the client
  signup_start_at  timestamptz NOT NULL,
  signup_end_at    timestamptz NOT NULL,                 -- = first preparation day start
  season_end_at    timestamptz NOT NULL,
  state            smallint NOT NULL CHECK (state BETWEEN 1 AND 6),
  fight_index      smallint NOT NULL DEFAULT 0 CHECK (fight_index BETWEEN 0 AND 7),
  phase_start_at   timestamptz NOT NULL,                 -- startTime
  phase_end_at     timestamptz NOT NULL,                 -- stopTime
  champion_guild_uid text,                               -- first.consortiaUid of the previous season
  champion_guild_name text,
  champion_server_name text,
  champion_score   integer,
  champion_buff_end_at timestamptz,
  settled_at       timestamptz                           -- season rewards mailed
);
CREATE INDEX war_season_state_idx ON guild.war_season (state);

CREATE TABLE guild.war_registration (
  season_id      integer NOT NULL REFERENCES guild.war_season(id),
  guild_id       integer  NOT NULL REFERENCES guild.guild(id),
  guild_uid      text    NOT NULL,                       -- consortiaUid, unique across servers (A: "<server_id>_<guild_id>")
  server_name    text    NOT NULL,
  sign_type      smallint NOT NULL CHECK (sign_type = 1),
  signed_by      integer  NOT NULL,
  signed_at      timestamptz NOT NULL DEFAULT now(),
  wealth_paid    integer NOT NULL CHECK (wealth_paid >= 0),
  defend_buff_id integer NOT NULL DEFAULT 0,             -- MasterType 308 skill
  season_score   integer NOT NULL DEFAULT 0,
  final_rank     integer,
  PRIMARY KEY (season_id, guild_id),
  UNIQUE (season_id, guild_uid)
);
CREATE INDEX war_registration_rank_idx ON guild.war_registration (season_id, season_score DESC);

CREATE TABLE guild.war_round_entry (                    -- per guild per fight
  season_id   integer NOT NULL,
  fight_index smallint NOT NULL CHECK (fight_index BETWEEN 1 AND 7),
  guild_id    integer  NOT NULL,
  is_valid    boolean NOT NULL DEFAULT false,
  is_bye      boolean NOT NULL DEFAULT false,
  match_id    bigint,                                    -- guild.war_match(id), cross-server-war.md
  result      smallint CHECK (result IN (0, 1, 2)),      -- 0 win, 1 bye, 2 loss (FightDrop site)
  score_gain  integer NOT NULL DEFAULT 0,
  PRIMARY KEY (season_id, fight_index, guild_id),
  FOREIGN KEY (season_id, guild_id) REFERENCES guild.war_registration(season_id, guild_id)
);

CREATE TABLE guild.war_defender (
  season_id    integer NOT NULL,
  fight_index  smallint NOT NULL,
  guild_id     integer  NOT NULL,
  tower_id     smallint NOT NULL CHECK (tower_id BETWEEN 1 AND 12),
  user_id      integer  NOT NULL,
  nick_name    text    NOT NULL,
  head_id      integer NOT NULL,
  fight_power  integer NOT NULL,
  user_buff_id integer NOT NULL DEFAULT 0,               -- MasterType 309 skill, 0 = none
  formation    jsonb   NOT NULL,                         -- snapshot of heroes/soldiers/followers for battle 296
  PRIMARY KEY (season_id, fight_index, guild_id, tower_id),
  UNIQUE (season_id, fight_index, guild_id, user_id),
  FOREIGN KEY (season_id, fight_index, guild_id) REFERENCES guild.war_round_entry(season_id, fight_index, guild_id)
);
CREATE UNIQUE INDEX war_defender_buff_uq ON guild.war_defender (season_id, fight_index, guild_id, user_buff_id) WHERE user_buff_id <> 0;

CREATE TABLE guild.war_contribution (
  season_id   integer NOT NULL REFERENCES guild.war_season(id),
  user_id     integer  NOT NULL,
  guild_id    integer  NOT NULL,                          -- guild at the time of the last contribution
  contribute  integer NOT NULL DEFAULT 0 CHECK (contribute >= 0),
  updated_at  timestamptz NOT NULL DEFAULT now(),
  PRIMARY KEY (season_id, user_id)
);
CREATE INDEX war_contribution_guild_idx ON guild.war_contribution (season_id, guild_id, contribute DESC);

CREATE TABLE guild.war_reward_grant (
  id          bigserial PRIMARY KEY,
  season_id   integer NOT NULL,
  kind        smallint NOT NULL CHECK (kind IN (1, 2, 3)), -- 1 fight, 2 season rank, 3 contribution
  fight_index smallint NOT NULL DEFAULT 0,
  guild_id    integer  NOT NULL,
  user_id     integer  NOT NULL,
  drop_id     integer NOT NULL,
  mail_id     bigint,
  granted_at  timestamptz NOT NULL DEFAULT now(),
  UNIQUE (season_id, kind, fight_index, user_id)
);
```

In memory (not persisted): `policy_viewers: HashMap<guild_id, HashSet<user_id>>` (opType 1 adds, 13 or disconnect removes).

## Backend implementation notes

Rust handlers (dispatch on `ConsortiaWarClientOpMsg.opType` of opcode 8650; the dispatcher is shared with cross-server-war.md):

| opType | Handler |
|---|---|
| 1 | `guild::war::handle_request_data` |
| 2 | `guild::war::handle_sign` |
| 3 | `guild::war::handle_set_guild_buff` |
| 4 | `guild::war::handle_view_season_rank` |
| 5 | `guild::war::handle_view_contribution_rank` |
| 12 | `guild::war::handle_set_user_buff` |
| 13 | `guild::war::handle_leave_policy` |
| 6..11 | `guild::cross_server_war::*` |
| unknown | ignore and log |

Validation order for every request: session authenticated -> player is in a guild (else drop) -> current season exists -> state check -> permission check -> payload check -> write in one transaction -> pushes after commit.

- `handle_sign`: state == 2; not already registered; permission R5 (chairman, or right 20 delegated and held); guild wealth >= `consortia_war_sign_offer`. One transaction: debit guild wealth (core API), insert `war_registration`. After commit: 4573 (`signType=1`) to all online guild members, plus the core guild-wealth push.
- `handle_request_data`: add to `policy_viewers`; reply 4566 built from `war_registration` + current `war_round_entry` + `war_defender` + rival (from `war_match`).
- `handle_set_guild_buff`: state == 4; registered; requester is chairman; `bufferId` is a MasterType 308 skill. Update `war_registration.defend_buff_id`; push 4566 `opType=3` to `policy_viewers[guild]`.
- `handle_set_user_buff`: state == 4 (bufferId != 0) or state not in (5, 6) (bufferId == 0); requester is a defender of the current fight; bufferId is MasterType 309 and in the offered set; not held by another defender (unique index). Update `war_defender.user_buff_id`; push 4566 `opType=12` to viewers.
- `handle_view_season_rank`: 4567 with a fresh uuid per request; page in chunks (A: 50 rows) with the same uuid.
- `handle_view_contribution_rank`: 4568 for the requester's guild.

Schedules (one season scheduler task, server time, times as configured; (A) exact clock times):

| Time | Transition | Work |
|---|---|---|
| season start | -> state 1 | create `war_season` with computed signup window; push 4573 to all online |
| signup start (00:10) | 1 -> 2 | push 4573 |
| day before each fight 00:00 | -> 3 | push 4573 |
| 00:10 | 3 -> 4, `fight_index += 1` | select top 12 defenders per registered guild (snapshot formation and fight power), set `is_valid`, run pairing (cross-server-war.md), push 4573 to all online and 4566 to viewers |
| fight day 00:00 | 4 -> 5 | freeze strategy and bonuses; push 4573 |
| 00:10 | 5 -> 6 | create matches and towers (cross-server-war.md); push 4573 |
| fight window `consortia_war_fight_time` 05:00 to 23:00 | | attacks allowed only inside the window |
| fight day end | 6 -> 3 (or season end after fight 7) | settle matches: `score_gain`, `season_score`, FightDrop rewards by mail; push 4573 (kicks players out of the battlefield) |
| season end | | rank guilds by `season_score`, mail SeasonDrop and honors (ranks 1..3), set champion fields, mail UserDrop by contribution excluding members who joined in the last 4 days; schedule the next season |

Pushes: 4573 phase changes go to every online player (top bar needs `state` even for players without a guild, `TopBtnCheckShowHelper.as:272`). Guild-specific 4573 fields (`signType`, `isBye`, `isValid`) are per guild, so build the message per recipient.

Battles: none in this module (battleType 296 is started in cross-server-war.md).

Cross-area dependencies: core (guild, members, duties and rights 20, guild wealth, `CONSORTIA_CHANGE`), economy (currency 31 "Pedra da Coragem", shop "Loja da defesa de guilda"), mail (rewards), player buffers (bufferType 40004), player fight power and formation snapshot (army module), space map (champion statue).

## Open questions

1. Exact clock times of each phase and signup window length (only "às 00:10" and "dura 2 semanas" are in the client).
2. Defender eligibility beyond fight power (minimum guild tenure? the old string `CrossGuildMemberFrame.TipsTxt.text` says 3 days).
3. Whether `isValid` is decided per fight or once at signup; the state 5/6 text says "do combate anterior".
4. Bye score: is `cross_guild_bye_score` (10000) still used, or does a bye give 0?
5. Who receives single fight rewards (all members, only participants, defenders included?).
6. Honors 1..3 (rank 1): concrete server effects and durations (LANG says 3 days, `RANK_TEMP4_DAYS` applies only to honor 4).
7. Error feedback: the client has no handler for failed 8650 requests; confirm the project's generic notice opcode.
8. `seasonStartTime`/`seasonStopTime` are unused by the client; send them anyway for completeness.

## Implementation checklist

Client (already present, verify against the server):
- [ ] Activity list item id 5 text per R3 and routing per R2
- [ ] Top bar `crossgvg` visibility and badge per R4
- [ ] CrossGuildSignFrame: dates, cost, permission, signed state
- [ ] CrossGuildPolicyFrame: season panel, strategy, defenders, bonus grid, opType 1 on open and 13 on close
- [ ] CrossGuildBufferSelectFrame (opType 3)
- [ ] CrossGuildBufferItem select and give up (opType 12)
- [ ] CrossGuildRankFrame four tabs (opType 4 + templates)
- [ ] CrossGuildAttackContributionFrame (opType 5)
- [ ] Space map champion statue from 4573 `first`

Backend:
- [ ] Opcode 8650 decoder and opType dispatcher (shared with cross-server-war)
- [ ] `guild::war::handle_request_data` -> 4566
- [ ] `guild::war::handle_sign` -> 4573 broadcast, guild wealth debit
- [ ] `guild::war::handle_set_guild_buff` -> 4566 broadcast
- [ ] `guild::war::handle_set_user_buff` -> 4566 broadcast
- [ ] `guild::war::handle_view_season_rank` -> 4567 (paged by uuid)
- [ ] `guild::war::handle_view_contribution_rank` -> 4568
- [ ] `guild::war::handle_leave_policy`
- [ ] 4573 builder per recipient; push on login, phase change, guild change
- [ ] Season scheduler (states 1..6, 7 fights, fight window)
- [ ] Defender selection job (top 12 fight power, formation snapshot, `is_valid`)
- [ ] Fight settlement (score gain, FightDrop mail)
- [ ] Season settlement (SeasonDrop, honors, champion, UserDrop with 4 day rule)
- [ ] Tables: `war_season`, `war_registration`, `war_round_entry`, `war_defender`, `war_contribution`, `war_reward_grant`
- [ ] Template loaders: ConsortiaWarSeasonDrop, ConsortiaWarFightDrop, ConsortiaWarUserDrop, SkillTempInfos 308/309, ConfigInfos keys
- [ ] Policy viewer registry (opType 1/13, disconnect cleanup)
