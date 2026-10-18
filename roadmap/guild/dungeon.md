# Guild PvE dungeon ("Campanha da Guilda", guild FB)

Area: guild PvE, module `dungeon`. Client code name `guildfb`; protobuf package `com.road.yishi.proto.consortiapve`; battleType **3881** `GUILD_FB_BATTLE`.

The guild advances through a linear chain of 120 stages:
- 2 difficulties: Normal "Comum" and Nightmare "Pesadelo";
- 5 areas per difficulty;
- 12 stages per area.

Each stage has one boss with a shared HP pool. Up to 8 members fight it at the same time, and each member has 1 attempt per day. Every member present when a stage or an area is cleared claims a reward once. A cross-server season ranks guilds by progress and mails rank rewards.

Conventions:
- Paths are relative to `decompiled/` unless they start with `raw/`, `protocol/`, `index/` or `docs/`.
- `CM` = `core_module/scripts`. `FB` = `m6/scripts/consortia/view/fb`.
- Opcode names come from `protocol/opcodes.csv`. Proto tags were verified against the AS3 `readFrom`/`writeTo` and `protocol/proto.json`.
- *(assumption)* marks anything the client does not prove.

Related: `docs/battle/README.md`, `docs/battle/server-engine.md` §9, `docs/battle/rules.md` (row 3881, world boss family P-WB), `roadmap/guild/boss.md`, `roadmap/guild/minos.md`.

---

## 1. Overview

- **Client wiring.**
  - Controller: `GuildFbController` (`CM/mvc/controler/GuildFbController.as`), created at client setup (`CM/yishi/manager/FrameControllerManager.as:661`). Module key "guildfb" (`CM/yishi/datas/UIModuleTypes.as:524`).
  - Model: `GuildFBModel` (`CM/mvc/module/guildfb/GuildFBModel.as`).
  - Op enum: `GuildFBOper` (`CM/mvc/module/guildfb/GuildFBOper.as:6-16`).
- **Entry points.** All go through `SwitchPageHelp.openGuildFbFrame()` (`CM/yishi/SwitchPageHelp.as:1901-1907`), which requires `consortiaID > 0` and `checkScene()` (`:1883-1899`; inside a room it shows "Você está dentro de uma sala, não é possível realizar essa ação"). Callers:
  - guild activity list entry id 2 (`CM/mvc/module/consortia/ConsortiaViewHelper.as:385-415`), with text "Número de desafios restantes: {0}/{1}" (`PetChallengeSortView.leftCountText.text`) and a red dot count = `getReaNum()`;
  - daily guide `switchScene(89)` (`CM/managers/DayGuideManager.as:948-949`);
  - automatically after a 3881 battle (`CM/yishi/actions/consortia/GuildFBBattleAction.as:15-22`).
- **Load at login.** When the controller is built and the player is in a guild, it sends op 0 once (`GuildFbController.as:63-73`). It never sends it again, so the server must push the data when the player joins a guild or a season rolls over.
- **Season ranking.** Not on the socket. It is an HTTP GET of `TEMPLATE_PATH + "consortiapve_unzip.xml"` (`GuildFbController.as:253-308`; `CM/.../PathManager.as:488-491`).
- **Guild shop.** The shop button opens the guild shop tab 3 (`openControllerByInfo("shop",2,{type:3})`, `FB/GuildFBMainUIView.as:263-276`). Economy area.

---

## 2. Screens

| Class (file) | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `GuildFbFrame` (`FB/GuildFbFrame.as`) + `GuildFBMainUIView` (`FB/GuildFBMainUIView.as`) | graphic only (`raw/ui/zh_cn/xml/decoded/guildfb.xml:367-374`); help title "Explicação" | Map of one area | `openGuildFbFrame` | 12 `GuildFBNodeItem` labelled "area-index" (`FB/item/GuildFBNodeItem.as:65-68`), filled with the received nodes of the area and difficulty **sorted by NodeId** (MainUIView:93-112). Area arrows 1..5 (:245-261). Normal/Nightmare buttons (:229-243). "Claim all" button, flashing when any node has state 1 (:113-123). Shop button. Help frame `ui.guildfb.helpFrame1` when no running season, else `ui.guildfb.helpFrame` (`GuildFbFrame.as:63-76`), with texts `guildfb.helpTxt1` / `guildfb.helpTxt`. On open it jumps to the current node's area and difficulty (:167-177). Closes itself when the player leaves the guild (:83-89) |
| `GuildFBTopUIView` (`FB/GuildFBTopUIView.as`) | none | Season header | inside the main frame | "S{seasonId}", dates "YYYY.MM.DD-YYYY.MM.DD", badge "racing" (state 1) or "end" (state 2). Rank and season-reward buttons, hidden when there is no season or state 0 (:49-77, 125-133). Buff preview tip for 43000001 and 43000002 (:98; `GuildFBModel.as:32`) |
| `GuildFBBotoomUIView` (`FB/GuildFBBotoomUIView.as`) | none | Area boxes and progress bar | inside the main frame | 5 `GuildFBAreaBoxItem` for the selected difficulty. Box tip "Para a fase {0} são obtidos os seguintes prêmios" (`guildfb.areaRewardBoxTip.Title`, `m16/scripts/yishi/view/tips/GuildFBAreaBoxTip.as:50-93`). Progress bar (§5) |
| `GuildFBFightFrame` (`FB/GuildFBFightFrame.as`, openType 1) + `GuildFBFightUIView` | template `Name`, e.g. "[1-1] Pasto Livre" (:46) | Stage detail and fight | Click on a node with state ≠ 1 (`GuildFBNodeItem.as:91-107`) | Buff icons from `buffers` (UIView:96-118); NodeDropId rewards (:120-148); boss bar "(max-hp)/max %", 100% when passed (:150-166); fight button only when state 3 (:173); passed flag (:174); "Desafios acumulados da guilda {0}" (`guildfb.fightNode.attackNum`, :175). For a state-3 node it opens `GuildFBFightInfoFrame` and polls op 1 every 10 s (FightFrame:48-53, 105-126). Closes on 4884 (:87-90) |
| `GuildFBFightInfoFrame` (`FB/GuildFBFightInfoFrame.as`) | none | Current challengers panel | Auto-opened with the fight frame | Up to `consortia_pve_fight_count` (8) heads (:61-73); "Há atualmente {0} membros da guilda realizado desafio" (`guildfb.fightNode.attackPlayerNum`, :76-100). The tooltip key `guildfb.playinfo.tip` is missing (language.json has `Guildfb.playinfo.tip`), so the tooltip is blank. Client bug, no server action |
| `GuildFBAreaRewardFrame` (`FB/GuildFBAreaRewardFrame.as`, openType 2) + `GuildFbAreaUIView` | "Prêmio de área da fase" (`guildfb.areaRewardFrame.Title`, :36) | Area completion reward and MVP leader | Click on a non-empty area box (`FB/item/GuildFBAreaBoxItem.as:87-99`) | Leader head, nickName, attackCount, totalDamage (AreaUIView:69-72); "Liderança central: O jogador da guida que mais contribuiu para passar desta área!" (`guildfb.areaLeader`); "As fase {0} foi completada devido ao esforço conjunto dos membros da guilda. Parabéns por ter obtido:" (`guildfb.areaRewardFrame.Des`); AreaDropId items (:75-92) |
| `GuildFBRankFrame` (`FB/GuildFBRankFrame.as`, openType 3) + `item/GuildFBRankItem.as` | "Ranking da temporada" (`consortia.view.fb.guildFBRankFrame.titleTxt`, :377) | Season ranking of guilds | Top bar rank button | HTTP XML (§4). 7 rows per page. Columns "Ranking", "Nome da guilda", "Fase atual", then "Avanço da fase" (state 1) or "Prêmio da temporada" (state 2). Own guild line and own rank, or "Iniciante" when absent (:240-326). "Horário da última atualização: {0}" (:309). Needs `raceNode` and `currFightNode` non-null (:242-254) |
| `GuildFBRewardFrame` (`FB/GuildFBRewardFrame.as`, openType 4) + `item/GuildFBRewardItem.as` | "Prêmio da temporada" (:122) | Season rank rewards preview | Top bar reward button | "Ao encerrar a temporada o cálculo é realizado de acordo com o ranking e o prêmio é enviado por correio"; rows per rank range: "Primeiro lugar:", "Segundo lugar:", "Terceiro lugar:", "{0}° - {1}° lugares:" (`GuildFBModel.getRewardArray`, :117-163) |

---

## 3. Actions

All requests use **8554 (0x216a) C_CONSORTIA_PVE_CLIENT_OP** with `com.road.yishi.proto.player.PlayerOpMsg`.

- Sender: `GuildFbController.requestOp(op, value1=0, value2=0)` (`CM/mvc/controler/GuildFbController.as:199-207`).
- Fields always written: `op (#1, INT32)`, `value1 (#13, INT32)`, `value2 (#14, INT32)`. Explicit zeros are sent.
- Ops: `GuildFBOper.as:6-16`.

| op | Name | UI control and sender (file:line) | Fields | Client checks | Expected server reply, in order |
|---|---|---|---|---|---|
| 0 | REQUEST_DATA | none; controller init (`GuildFbController.as:69-72`) | none | `consortiaID > 0` | **4884** (full data), **4887** (season), **260** field 21 (attempts used) |
| 1 | NODE_DATA | `GuildFBFightUIView.setData` (`FB/GuildFBFightUIView.as:59-70`) and the 10 s poll in `GuildFBFightFrame.enterFrame` (`FB/GuildFBFightFrame.as:105-116`) | value1 = nodeId | only for state-3 nodes | **4886** for that node |
| 2 | FIGHT | Fight button `GuildFBFightFrame._fightClickHandler` (:128-146) | value1 = nodeId | `consortia_pve_count` (1) - `currFightNum` > 0, else "Os desafios de hoje já foram usados" (`guildfb.nofightNum`). Button only for state 3. No confirmation; the frame closes after sending. **No check of the 8-fighter cap, the season or the time** | **260** field 21 (used+1), battle **157** with battle_type **3881**, then 156/153.../154/4103, **4889** HP sync during the battle; after the battle **4885** |
| 3 | NODE_AWARD | Click on a node with state 1, `GuildFBNodeItem.clickHandler` (`FB/item/GuildFBNodeItem.as:91-99`) | value1 = nodeId | state 1 | item grant (generic bag push), then **4885** with that node `awardState=2` |
| 4 | NODE_AWARD_ALL | "Claim all" `GuildFBMainUIView.allRewardClickHandler` (:219-222) | none | at least one node with state 1, any area or difficulty (`GuildFBModel.getFightRewards`, :297-309) | item grants, then one **4885** with all claimed nodes at 2 |
| 5 | BOX_AWARD | Area box `GuildFBAreaBoxItem.clickHandler` (`FB/item/GuildFBAreaBoxItem.as:87-99`) | value1 = areaId, value2 = difficulty | box present (else "Primeiro passe desta área", `guildfb.getAreaRewardTip`); sends only when state 1. The area frame then opens in every non-null case | item grant, then **4885** with the box `awardState=2` |

**Client-only actions:**
- Normal: difficulty 0, area 1 (MainUIView:229-233).
- Nightmare: requires `isPassNormal`, i.e. node 60 is present with state ≠ 3 (`GuildFBModel.as:279-295`). Otherwise it shows "Ao passar de todas as áreas pode-se liberar o modo pesadelo,siga lutando com seus companheiros." (`guildfb.advance.tip`).
- Area arrows.
- Locked node click: "Esta fase ainda não foi liberada, primeiro passe da fase anterior" (`guildfb.fight.openTip`).
- Rank and season-reward frames.
- Shop. It checks `consortiaID > 0`, else "De momento não há Guilds", and `shopLevel > 0`, else "Nv.do mercado da Guild insuficiente".

---

## 4. Server messages

| Opcode | Name | Message and fields (tag, type) | Receiver (file:line) | When | Client effect |
|---|---|---|---|---|---|
| 4884 (0x1314) | U_C_CONSORTIA_PVE_DATA | `ConsortiaPveDataMsg`: `curNodeId (#1, INT32)`; `boxs (#2, ConsortiaPveAreaBoxMsg, repeated)`; `nodes (#3, ConsortiaPveNodeMsg, repeated)`; `serverName (#4, STRING)` (used to find the own row in the rank XML) | `GuildFbController.__allNodeInfosHandler` (:65, 75-80) | Response to op 0; push on guild join and season rollover | `resetNodes()` (`GuildFBModel.as:204-209`), merges the data, recomputes the guild red dots (`CM/yishi/manager/ConsortiaManager.as:1538-1551`), fires `GuildFBModel.raceReset` (main view goes to area 1, fight frame closes) |
| 4885 (0x1315) | U_C_CONSORTIA_PVE_NODE_UPDATE | same `ConsortiaPveDataMsg`, partial | `__updateNodeInfosHandler` (:66, 82-115) | Response to ops 3/4/5; push to online members after a stage kill or area completion | Upserts the nodes and boxes present. **`curNodeId` must always be a valid NodeId**: the setter dereferences the template (`GuildFBModel.as:185-202`), so 0 or a missing value crashes the client. A state other than 3 clears the node's players and buffs (`CM/mvc/module/guildfb/GuildFBNode.as:39-51`) |
| 4886 (0x1316) | U_C_CONSORTIA_PVE_CUR_NODE | `ConsortiaPveCurNodeMsg`: `curNodeId (#1, INT32)`; `bossHp (#2, INT64)` remaining; `bossMaxHp (#3, INT64)`; `attackCount (#4, INT32)` guild attempts on the node; `buffers (#5, INT32, repeated)` skill ids; `players (#6, ConsortiaPvePlayerMsg, repeated)` current fighters | `__currNodeInfoHandler` (:67, 152-183) | Response to op 1 | Updates the boss bar, the challenger list and the buffs. Ignored if the node is not in the model |
| 4887 (0x1317) | U_C_CONSORTIA_PVE_SEASON_DATA | `ConsortiaPveSeasonMsg`: `seasonId (#1, INT32)`; `state (#2, INT32)` 0 closed, 1 running, 2 ended/settlement; `beginTime (#3, STRING)`; `endTime (#4, STRING)` ("YYYY-MM-DD..." *(assumption: "YYYY-MM-DD hh:mm:ss")*) | `__raceInfoHandler` (:68, 185-197) | Login (with op 0) and on state change, to all online players | Top bar and help variant |
| 260 (0x0104) | U_C_PLAYER_EXTRA_FIELD_MSG | `player.PlayerExtraFieldMsg{extraField (#1, ExtraFieldInfoMsg, repeated)}`; entry `fieldId (#1, INT32)` = **21**, `field_Type (#2)`, `userId (#3)`, `value (#4, STRING)` = attempts used today | `BaseManager.__updateInfoHandler` (`CM/yishi/manager/BaseManager.as:335, 957-960`) | Login, after each fight, at the daily reset; to the player only | `GuildFBModel.currFightNum` |
| 4889 (0x1319) | U_C_CONSORTIA_PVE_BOSS_HP | `simple.WorldBossInfoMsg`: reads `curHp (#1, INT64)`, `totalHp (#5, INT64)`, `currentMillis (#8, INT64)` server ms, `bossState (#12, INT32)` (send 1). Other fields are unused here | `RoleShowViewII.__syncBossHpHandler` (`m10/scripts/battle/view/ui/RoleShowViewII.as:225, 264-286`) | During battle 3881, to every player fighting the same guild node, whenever the shared HP changes | `BattleModel.updateWorldBossBlood` lowers the local boss HP to `curHp` (`CM/yishi/datas/BattleModel.as:837-858`). It works because `getWorldBoss()` accepts 3881 (:861-866). The enemy must be a type-3 boss hero. A 0→1 `bossState` transition re-initialises the total HP |
| 157, 156, 153, 154, 4103 | battle | `docs/battle/README.md` | battle module | Battle 3881 | On exit, `BattleResultHandler` queues `GuildFBBattleAction` (`CM/battle/handler/BattleResultHandler.as:271-272`). It waits for the CASTLE or SPACE scene and reopens the main frame |

Nested messages:

| Message | Field | Tag | Type | Meaning |
|---|---|---|---|---|
| ConsortiaPveNodeMsg | nodeId | 1 | INT32 | template NodeId |
| | attackCount | 2 | INT32 | guild cumulative attempts on the node |
| | awardState | 3 | INT32 | **per player**: 3 in progress (current boss), 1 passed and claimable, 2 claimed, 0 passed but not claimable *(assumption: the player joined after the pass)* (`GuildFBNode.as:9-13`) |
| ConsortiaPveAreaBoxMsg | areaId | 1 | INT32 | area 1..5 |
| | difficulty | 2 | INT32 | 0 or 1 |
| | awardState | 3 | INT32 | 1 claimable, 2 claimed, 0 not claimable; an absent box means the area is not complete (`GuildFBAreaBoxItem.as:41-59`) |
| | leader | 4 | ConsortiaPvePlayerMsg | area MVP |
| ConsortiaPvePlayerMsg | userId | 1 | INT32 | |
| | headId | 2 | INT32 | |
| | nickName | 3 | STRING | |
| | fightPower | 4 | INT32 | |
| | attackCount | 5 | INT32 | |
| | totalDamage | 6 | INT64 | |

**HTTP route.**
- `GET <TEMPLATE_PATH>/consortiapve_unzip.xml`. The loader lowercases the URL and may map it through MD5 paths (`Loading/scripts/com/pickgliss/loader/LoaderManagerII.as:83-125`).
- Body: a root with `<info createDate="YYYY-MM-DD hh:mm:ss.fff"/>` (the text before "." is shown) and N `<ConsortiaPveOrder Rank ConsortiaId ConsortiaName ServerName PassNodeId Progress/>`, sorted by Rank (`GuildFbController.as:253-308`).
- `Progress` is an integer percent, shown as "{n}%". `PassNodeId` gives the "Fase atual" name *(assumption: the guild's current node)*.

**Result and error codes.** None. The client never waits for a reply. Server-side rejections go through the generic **126 (0x007e) U_C_MSG** `CampaignNotifyMsg` handled by `BaseManager.__msgHandler` (`CM/yishi/manager/BaseManager.as:299, 2070-2085`; core area) *(assumption)*, or are silently ignored.

---

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Daily attempts | `consortia_pve_count` = 1 (client default 1); no buy option | `GuildFBModel.as:84-100`; ConfigInfos |
| Max concurrent fighters per stage | `consortia_pve_fight_count` = 8 (client display only; the server enforces it) | `FB/GuildFBFightInfoFrame.as:61-65`; help "até 8 pessoas ao mesmo tempo" |
| Settlement days | `consortia_pve_day_count` = 5, not read by the client *(assumption: length of season state 2)* | ConfigInfos |
| Stage chain | NextNodeId: 1→2→…→60→1001→…→1060→0. Normal = 1..60, Nightmare = 1001..1060. Area k covers stages 12(k-1)+1..12k | `ConsortiaPveTemplates.xml` |
| Nightmare view | allowed after node 60 is passed (`isPassNormal`) | `GuildFBModel.as:279-295` |
| Stage boss | GameHeroTemp `TemplateId == NodeDropId` (all 120 exist, e.g. 3860101 "[Monarquia da Lava] Barlock", HeroType 3, Live 88 750 000, ResPath boss022; nightmare Live up to 1.8e9, so use INT64). AI = HeroAis with the same id; CrazySkill 3860000 "Grande jogada do chefe da guilda" (seckill, CoolDown 180000) *(assumption: id convention, used as the attempt timer)* | `raw/xml/tempinfos/GameHeroTemp.xml`, `HeroAis.xml` |
| Shared HP | the boss HP persists across fights and fighters; the node is passed at HP 0, and the next node starts at its boss `Live` | 4886/4889 semantics |
| Rewards | stage: ConsortiaPveDrop[NodeDropId]; area: ConsortiaPveDrop[AreaDropId]; once per player; no reward for stages cleared before joining the guild (help rules 5-7) | `guildfb.helpTxt` |
| Area MVP | player with the highest total damage over the 12 stages of the area *(assumption)* | `GuildFbAreaUIView.as:69-72` |
| Bottom progress | n = boxes received for the difficulty; fill = (n>1 ? (n-1)·12 : 0) + (if n+1 ≤ 5: count of nodes in area n+1 with state ≠ 0); width = fill/48 × bar width | `FB/GuildFBBotoomUIView.as:114-134` |
| Red dots | count of nodes with state 1 + count of boxes with state 1, both difficulties | `GuildFBModel.as:311-323`; `ConsortiaViewHelper.as:391-405`; `m6/.../ConsortiaFrame.as:238` |
| Node list | send every reached node of each area from its first node, because slots fill by sort order (MainUIView:93-112). Unsent nodes show as locked | |
| Buffs | 43000001 "Grande Moral": +100% damage when guild online ratio > 40% the day before (Parameter1 40, BufferIds 41502001). 43000002 "Última Carga": enemies lose 1% HP per turn when participation ≥ 30% and the same stage has not been cleared for 3 days in a row (P1 30, P2 3, BufferIds 23030304). The server decides which are active and sends them in `buffers` | `SkillTempInfos.xml`; `GuildFBModel.as:32` |
| Season | state 0/1/2; 2 months, cross-server, ranking by stage progress, computed daily at 00:00 and published at 01:00, rewards by mail at the end (help text) | `guildfb.helpTxt` |
| Season rewards | `ConsortiaPveRankDrop` grouped by `para2` rank range: 1, 2, 3, 4-10, 11-20, 21-50, 51-100, 101-99999. Rank 1 gets -4700 ×10000 + 208104 ×300; rank 101+ gets 2000 / 120 | `CM/yishi/datas/templates/cate/GuildFBPveRankDropTempCate.as:34-54` |
| Permissions | any guild member; no rank or guild level check on the client | |

---

## 6. Templates

| File | Record | Fields and use |
|---|---|---|
| `raw/xml/tempinfos/ConsortiaPveTemplates.xml` (120 rows; `GuildFBTempInfo`, `GuildFBTemplateCate`, loaded at `CM/yishi/manager/TempleteManager.as:1277-1279`) | stage | `NodeId` key. `AreaId` 1..5 and `Difficulty` 0/1 used for filtering. `NextNodeId` for server progression. `Name` such as "[1-1] Pasto Livre" or "Pesadelo [1-1] Pasto Livre". `AreaDropId` (386000k normal, 387000k nightmare). `NodeDropId` (3860k01..3860k12, 3870k..) = stage reward and boss id. `BossId` is declared in the class but absent from the XML. `conciseName` strips `[1-9-[]]` (`GuildFBTempInfo.as:27-35`) |
| `raw/xml/tempinfos/ConsortiaPveDrop.xml` (406 rows, 130 DropIds; `GuildFBDropTempCate.getTempInfos` :35-51) | reward item | `DropId`, `ItemId`, `Count`, `IsBind`=1, `ValidDate`=0. Stage: -4700 "Prata de Moréia" 20-75, -500 "Diamante Vinculado" 20, 2030102 "Bolsa de Ouro" 40. Area: -4700 250-900, -500 150/250, 2030102 ×500, "Oferta" 2131121-2131124 |
| `raw/xml/tempinfos/ConsortiaPveRankDrop.xml` (16 rows) | season rank reward | `id` (sort), `para2` rank range, `itemId`, `count`; also `dropId`, `site`, `isBind`, `appearType`, `validDate`, `isShow` |
| `raw/xml/tempinfos/ConfigInfos.xml` | config | `consortia_pve_count`, `consortia_pve_fight_count` (client); `consortia_pve_day_count` (server) |
| `GameHeroTemp.xml`, `HeroAis.xml`, `SkillTempInfos.xml` | boss and buffs | see §5 |

---

## 7. Persistent state (PostgreSQL, schema `guild`)

```sql
CREATE TABLE guild.dungeon_season (
  season_id  integer PRIMARY KEY,
  state      smallint NOT NULL CHECK (state IN (0,1,2)),
  begin_at   timestamptz NOT NULL,
  end_at     timestamptz NOT NULL,
  settled_at timestamptz,
  CHECK (end_at > begin_at)
);
CREATE UNIQUE INDEX dungeon_season_running ON guild.dungeon_season ((true)) WHERE state = 1;

CREATE TABLE guild.dungeon_progress (
  guild_id        integer NOT NULL REFERENCES guild.guilds(id) ON DELETE CASCADE,
  season_id       integer NOT NULL REFERENCES guild.dungeon_season(season_id),
  cur_node_id     integer NOT NULL CHECK (cur_node_id > 0),
  boss_hp         bigint  NOT NULL CHECK (boss_hp >= 0),
  boss_max_hp     bigint  NOT NULL CHECK (boss_max_hp > 0),
  node_started_at timestamptz NOT NULL,
  finished        boolean NOT NULL DEFAULT false,
  updated_at      timestamptz NOT NULL DEFAULT now(),
  PRIMARY KEY (guild_id, season_id)
);
CREATE INDEX dungeon_progress_rank ON guild.dungeon_progress (season_id, cur_node_id DESC);

CREATE TABLE guild.dungeon_node (
  guild_id     integer NOT NULL,
  season_id    integer NOT NULL,
  node_id      integer NOT NULL,
  attack_count integer NOT NULL DEFAULT 0 CHECK (attack_count >= 0),
  passed_at    timestamptz,
  PRIMARY KEY (guild_id, season_id, node_id),
  FOREIGN KEY (guild_id, season_id) REFERENCES guild.dungeon_progress ON DELETE CASCADE
);

CREATE TABLE guild.dungeon_node_player_stat (
  guild_id     integer NOT NULL,
  season_id    integer NOT NULL,
  node_id      integer NOT NULL,
  player_id    integer NOT NULL REFERENCES game.players(id),
  attack_count integer NOT NULL DEFAULT 0,
  total_damage bigint  NOT NULL DEFAULT 0 CHECK (total_damage >= 0),
  PRIMARY KEY (guild_id, season_id, node_id, player_id),
  FOREIGN KEY (guild_id, season_id, node_id) REFERENCES guild.dungeon_node ON DELETE CASCADE
);
CREATE INDEX dungeon_node_player_stat_player ON guild.dungeon_node_player_stat (guild_id, season_id, player_id);

CREATE TABLE guild.dungeon_area (
  guild_id            integer  NOT NULL,
  season_id           integer  NOT NULL,
  area_id             smallint NOT NULL CHECK (area_id BETWEEN 1 AND 5),
  difficulty          smallint NOT NULL CHECK (difficulty IN (0,1)),
  completed_at        timestamptz NOT NULL,
  leader_player_id    integer NOT NULL REFERENCES game.players(id),
  leader_attack_count integer NOT NULL,
  leader_total_damage bigint  NOT NULL,
  PRIMARY KEY (guild_id, season_id, area_id, difficulty),
  FOREIGN KEY (guild_id, season_id) REFERENCES guild.dungeon_progress ON DELETE CASCADE
);

CREATE TABLE guild.dungeon_node_claim (
  player_id  integer NOT NULL REFERENCES game.players(id),
  guild_id   integer NOT NULL,
  season_id  integer NOT NULL,
  node_id    integer NOT NULL,
  claimed_at timestamptz NOT NULL DEFAULT now(),
  PRIMARY KEY (player_id, season_id, guild_id, node_id)
);

CREATE TABLE guild.dungeon_area_claim (
  player_id  integer  NOT NULL REFERENCES game.players(id),
  guild_id   integer  NOT NULL,
  season_id  integer  NOT NULL,
  area_id    smallint NOT NULL CHECK (area_id BETWEEN 1 AND 5),
  difficulty smallint NOT NULL CHECK (difficulty IN (0,1)),
  claimed_at timestamptz NOT NULL DEFAULT now(),
  PRIMARY KEY (player_id, season_id, guild_id, area_id, difficulty)
);

CREATE TABLE guild.dungeon_player_daily (
  player_id   integer PRIMARY KEY REFERENCES game.players(id),
  day         date     NOT NULL,
  fight_count smallint NOT NULL DEFAULT 0 CHECK (fight_count >= 0)
);

CREATE TABLE guild.dungeon_buff_state (
  guild_id integer NOT NULL REFERENCES guild.guilds(id) ON DELETE CASCADE,
  day      date    NOT NULL,
  buff_id  integer NOT NULL CHECK (buff_id IN (43000001, 43000002)),
  node_id  integer,
  PRIMARY KEY (guild_id, day, buff_id)
);

CREATE TABLE guild.dungeon_rank_snapshot (
  season_id      integer NOT NULL REFERENCES guild.dungeon_season(season_id),
  server_name    text    NOT NULL,
  guild_id       integer NOT NULL,
  rank           integer NOT NULL CHECK (rank > 0),
  guild_name     text    NOT NULL,
  pass_node_id   integer NOT NULL,
  progress       smallint NOT NULL CHECK (progress BETWEEN 0 AND 100),
  computed_at    timestamptz NOT NULL,
  PRIMARY KEY (season_id, server_name, guild_id)
);
CREATE INDEX dungeon_rank_snapshot_rank ON guild.dungeon_rank_snapshot (season_id, rank);

CREATE TABLE guild.dungeon_season_reward_log (
  season_id integer NOT NULL,
  guild_id  integer NOT NULL,
  player_id integer NOT NULL,
  rank      integer NOT NULL,
  mailed_at timestamptz NOT NULL DEFAULT now(),
  PRIMARY KEY (season_id, player_id)
);
```

**Derived values.**
- `awardState` per recipient: 3 if the node is current and not passed; 2 if a claim exists; 1 if passed and the player joined before `passed_at` (membership `joined_at`, core area); else 0.
- Box states use the same rule with `completed_at`.

**In memory.** Live fighters per (guild, node), at most 8, used for 4886 `players` and 4889 recipients.

---

## 8. Backend implementation notes

| Handler | op | Validation order | Transaction and pushes |
|---|---|---|---|
| `guild::dungeon::handle_request_data` | 0 | in guild | read-only. Send 4884 (built per player), 4887, 260/21 |
| `guild::dungeon::handle_node_data` | 1 | in guild → node == cur_node and not passed | read-only. Send 4886 with live fighters, active buffs, boss_hp/max, attack_count |
| `guild::dungeon::handle_fight` | 2 | in guild → season state 1 *(assumption)* → nodeId == cur_node and not passed → fight_count < consortia_pve_count → live fighters < 8 → player not in battle | tx: fight_count+1, node attack_count+1, player stat attack_count+1; register the fighter. After commit: 260/21 to the player, then start battle 3881 |
| `guild::dungeon::on_battle_end` | (report 3881) | fighter registered | tx: lock the progress row; boss_hp = max(0, boss_hp - damage); total_damage += damage. On HP 0: passed_at, advance `cur_node_id` to NextNodeId with the new boss Live (stay on 1060 with `finished = true` when NextNodeId = 0); if the area's last stage was passed, insert `dungeon_area` with the MVP. After commit: 4885 to every online guild member (per-player awardState) |
| `guild::dungeon::handle_claim_node` | 3 | in guild → node passed → eligible (joined before passed_at) → not claimed | tx: insert claim + grant NodeDropId items. Then 4885 to the player |
| `guild::dungeon::handle_claim_all_nodes` | 4 | in guild | tx: every passed, eligible, unclaimed node of the season; grant all. Then one 4885 |
| `guild::dungeon::handle_claim_area_box` | 5 | in guild → area completed → eligible → not claimed | tx: insert claim + grant AreaDropId items. Then 4885 to the player |

**During a battle.** On each boss damage tick *(assumption: per action round)*, push 4889 `{curHp, totalHp, currentMillis, bossState=1}` to every fighter of the same (guild, node), and write the shared HP back.

**Jobs.**
- `daily_reset`: reset `fight_count` and push 260/21.
- `daily_buff_eval`.
- `rank_snapshot` at 00:00, writing `consortiapve_unzip.xml` for publication at 01:00.
- `season_settle`: state 2, mail RankDrop rewards.
- `season_rollover`: new season; reset progress to node 1 with boss 3860101 `Live`; push 4887 + 4884 to all online players.
- On guild join, push 4884 (per player).

**Battle rule config** (`docs/battle/server-engine.md` §9.2):

```json
{"battle_type":3881,"map":"<MapInfos id of the area (assumption, matched by name): 1 Pasto Livre, 2 Floresta Nublada, 5 Terra do Julgamento, 3 Pântano Sem Fim, 4 Deserto da Morte>",
 "count_down":180,
 "heroes":[ <player hero with active buffs 41502001 / 23030304>,
            {"temp_id":"<NodeDropId>","type":3,"pos":5,"max_hp":"<boss_max_hp>","hp":"<boss_hp>"} ],
 "soldiers":[ <player soldiers> ],
 "report":{"battle_result":1},"report_defeat":{"battle_result":2}}
```

- The boss must be a type-3 hero so `getWorldBoss` finds it.
- Damage dealt = HP lost by the boss during the battle.
- Several fighters may attack the same boss at once. The engine must read and write the shared HP.

---

## 9. Cross-area dependencies

- **Core:** membership with `joined_at` (eligibility), the guild join and leave events, online member list, generic tip 126.
- **Economy:** item grants, the guild shop tab 3, currency -4700.
- **Battle:** the 3881 engine with shared HP and the 4889 broadcast.
- **Mail:** season rewards.
- **HTTP static files:** `consortiapve_unzip.xml` under the template path.
- **Player extra fields:** 260 (field 21).

---

## 10. Open questions

1. Exact meaning of awardState 0 for nodes and boxes (inferred: passed but not eligible).
2. Pass criterion per attempt: is damage applied incrementally (4889) or at the report? Does CrazySkill 3860000 (seckill after 180 s) end each attempt?
3. Boss = GameHeroTemp[NodeDropId] and the area to MapInfos mapping are id or name conventions only.
4. Ranking definitions (`PassNodeId`, `Progress`, tie-break) and who receives season mail.
5. Meaning of `consortia_pve_day_count` = 5.
6. Whether fights are allowed outside season state 1.
7. Daily reset hour (probably midnight).

---

## 11. Implementation checklist

**Client screens and actions (verify against the backend):**

- [ ] Activity entry id 2 (counter, red dots)
- [ ] `GuildFbFrame` / `GuildFBMainUIView` (area map, difficulty switch, claim-all op 4, shop)
- [ ] `GuildFBTopUIView` (season), `GuildFBBotoomUIView` (boxes op 5, progress)
- [ ] `GuildFBFightFrame` (op 1 poll every 10 s, fight op 2) + `GuildFBFightInfoFrame`
- [ ] Node click claim (op 3)
- [ ] `GuildFBAreaRewardFrame`
- [ ] `GuildFBRankFrame` (HTTP XML) and `GuildFBRewardFrame`
- [ ] Reopen after battle (`GuildFBBattleAction`)

**Backend:**

- [ ] 8554 dispatcher with the handlers `guild::dungeon::handle_request_data`, `handle_node_data`, `handle_fight`, `handle_claim_node`, `handle_claim_all_nodes`, `handle_claim_area_box`
- [ ] `guild::dungeon::on_battle_end` (shared HP, progression, area completion, MVP)
- [ ] Encoders: 4884/4885 (valid curNodeId, per-player awardState), 4886, 4887, 260 field 21, 4889
- [ ] Battle 3881 builder with a persisted shared boss HP and concurrent fighters (max 8)
- [ ] Jobs: daily reset, buff evaluation, rank snapshot + XML, settlement mail, season rollover
- [ ] Template loaders: ConsortiaPveTemplates, ConsortiaPveDrop, ConsortiaPveRankDrop, GameHeroTemp/HeroAis bosses, ConfigInfos keys

**Tables:**

- [ ] `guild.dungeon_season`
- [ ] `guild.dungeon_progress`
- [ ] `guild.dungeon_node`
- [ ] `guild.dungeon_node_player_stat`
- [ ] `guild.dungeon_area`
- [ ] `guild.dungeon_node_claim`
- [ ] `guild.dungeon_area_claim`
- [ ] `guild.dungeon_player_daily`
- [ ] `guild.dungeon_buff_state`
- [ ] `guild.dungeon_rank_snapshot`
- [ ] `guild.dungeon_season_reward_log`
