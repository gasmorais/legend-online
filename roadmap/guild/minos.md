# Minos ("Reino de Minos", guild labyrinth)

Area: guild PvE, module `minos`. This is a weekly guild labyrinth.

- Each guild has up to 4 levels ("Fase"). Each level is a 16x10 grid of nodes.
- Members spend daily challenges to fight nodes at one of 4 difficulties, in battleType **3909** `MINOS_BATTLE`. Each win adds progress to the node.
- A completed node opens its neighbours. Killing the lord (type 5) unlocks the next level.
- Players earn "Virtude" (feat), which ranks them inside the guild. Feat gives threshold rewards and weekly ranking rewards by mail.
- The map is a static grid frame. There is no walking avatar and no campaign scene.

Conventions:
- Paths are relative to `decompiled/` unless they start with `raw/`, `protocol/`, `index/` or `docs/`.
- `CM` = `core_module/scripts`. `M6` = `m6/scripts/consortia/view/minos`.
- Opcode names come from `protocol/opcodes.csv`. Proto tags come from `protocol/proto.json` and were checked against the AS3 `writeTo`.
- *(assumption)* marks anything the client does not prove.
- No HTTP route is used.

Related: `docs/battle/server-engine.md` §9 (battle rule), `docs/battle/rules.md` (battleType 3909 row), `roadmap/guild/boss.md`, `roadmap/guild/dungeon.md`.

---

## 1. Overview

- **Feature switch.** `VersionSwitch.MINOS = true` (`CM/yishi/datas/VersionSwitch.as:244`).
- **Network setup.** `MinosManager.ins.setup()` runs at boot (`CM/yishi/lunch/Yishi.as:554`) and registers 552-557 (`CM/managers/MinosManager.as:53-63`). When the player leaves the guild (`CONSORTIA_CHANGE`), the model is reset (`MinosManager.as:62-71`).
- **Entry point.**
  - The guild activity list entry has id -1 (`CM/mvc/module/consortia/ConsortiaViewHelper.as:91-94, 352-383`). Its card text is "Número de desafios restantes: {0}/{1}" (`PetChallengeSortView.leftCountText.text`). {1} = `Minos_ChallengeCount + buyMax` = 15, and {0} = {1} - challengeCount, clamped to 0. This uses buyMax, not buyCount, so it differs from the map counter.
  - The join button calls `SwitchPageHelp.openMinosFrame()` (`CM/yishi/SwitchPageHelp.as:1909-1915`). It requires `consortiaID > 0` and `checkScene()` (`:1883-1898`), and does no guild level check.
- **Frames.** `MinosController` (`CM/mvc/controler/MinosController.as:33-48`, module key "minos") picks the frame by openType:
  - default: `MinosEnterFrame`
  - "Map": `MinousmapFrame`
  - "GJ": `MinosGJRewardFrame`
  - "SEASON": `MinosSeaonRewardFrame`
  - When the map frame closes, the controller reopens the previous frame (the entry) (`:50-62`).
- **Name.** "GJ" is the pinyin of 功绩 (merit), shown in pt-BR as "Virtude".

---

## 2. Screens

| Class (file) | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `consortia.view.minos.MinosEnterFrame` (`M6/MinosEnterFrame.as`) + `ui/MinosEnterViewUI.as` + `ui/MinosCardUI.as` + `ui/MinosTopLeftUI.as` | image `asset.minos.title`; header "Informações de estratégia" (`minos.enter.topInfo`, EnterViewUI:100) | Lobby: level cards, guild feat ranking, season dates | Activity id -1 → `openMinosFrame`; preFrame when the map closes | **Cards.** One per `MinosLevelTmpl`, sorted by Id (EnterViewUI:106-121). Unlocked iff the level is in `mapLvInfoDic`, i.e. the server sent it. Unlocked cards show progress "Nível de exploração da fase: {0}%" (`minos.cardPro`) with {0} = int(progress/progressMax·100), capped at 100, plus "(Ainda não chegou a 100%. Pode seguir explorando)" (`minos.goOn.tip`) while below 100. Locked cards show "Derrote o senhor do andar anterior" (`minos.cardTip`) and "Guilda chegar ao nível {0}" (`minos.open.needLv`, GuildLevel) (CardUI:120-232). A red tip "Há prêmios ainda não retirados" (`minos.hasRewardTip`) appears when `killInfo` count > claimed count (CardUI:151-179). **Top progress.** For the highest unlocked level: "Nível de exploração da guilda: {0}ª fase" (`ui.minos.topProTitle`), "Guardiões do Labirinto: {0}/{1}" (`ui.minos.topProNpc`), "Senhores do Labirinto: {0}/{1}" (`ui.minos.topProBoss`), or "Todos os Guardiões do Labirinto foram derrotados" (`ui.minos.topProMax`) (EnterViewUI:131-164). **Ranking.** `MinosRankItem` rows with medals for ranks 1-3 (`M6/item/MinosRankItem.as:46-72`). My rank and feat come from the row with my userId; without it the client shows "Fora do ranking" (`apex.rank.str7`) and 0 (EnterViewUI:171-220). **Season.** Dates "{0}-{1}" from begin/end substr(0,10) (TopLeftUI:50-61) |
| `consortia.view.minos.MinousmapFrame` (`M6/MinousmapFrame.as`) + `ui/MinosMapViewUI.as`, `ui/MinosSamllMapView.as`, `item/MinosNodeItem.as`, `ui/MinosCardChoseViewUI.as`, `item/MinosDiffChoseItem.as`, `ui/MinosRwardNodeUI.as` | level `LevelName`, e.g. "1ª Fase" (MapViewUI:199) | Labyrinth grid of one level | Card explore button: `openControllerByInfo("minos","Map",Id)` + `setPreFrame("minos")` (CardUI:145-149); return from a 3909 battle (`m3/scripts/map/space/SpaceSceneController.as:473-480`, `m4/scripts/castle/CastleSceneView.as:243-250`) | **Grid.** 16 cols × 10 rows of 91 px cells, draggable (MapViewUI:156-181, 229-272), plus a minimap. Open nodes of types 2-5 show a progress bar "N%" (NodeItem:79-108). **Counter.** "Desafios restantes hoje: {0}" (`warSoulTowerFrame.challengeNumTxt.text`) with {0} = max(0, 10 + buyCount - challengeCount) (MapViewUI:371-377); a buy "+" button. **Level.** Progress bar. **Reward slots.** Five slots: 1-4 guardians, 5 lord (MapViewUI:182-191, 297-348). **Node panel.** NodeName; 4 difficulty rows "Normal +{0}", "Difícil +{0}", "Pesadelo +{0}", "Inferno +{0}" (`minos.diff1..4`, {0} = GardenValue) (DiffChoseItem:85-93); reward preview RewardItem1..3 of the selected grade (ChoseViewUI:169-189); progress "progress +GardenValue/NodeValueMax" colored #0099CC/#9900CC/#FF9900/#FF0000 (:228-247); Fight button |
| `consortia.view.minos.MinosGJRewardFrame` (`M6/MinosGJRewardFrame.as`) + `ui/MinosGJRewardItemUI.as` | "Prêmios de Virtude" (`minos.gj.frame`, :151) | Claim feat threshold rewards | TopLeftUI GJ button (:87-90) | `minos.gj.des`; rows = `MinosRewardTmpls` RewardType 2 sorted by Id (:63); "Virtude pessoal atinge {0} ({1}/{2})" (`minos.gj.condition`); claim button or claimed flag (ItemUI:83-109) |
| `consortia.view.minos.MinosSeaonRewardFrame` (`M6/MinosSeaonRewardFrame.as`) + `ui/MinosSeasonRewardItemUI.as` | "Prêmios da Temporada" (`minos.season.frame`) | Read-only weekly rank rewards | TopLeftUI season button (:92-95) | `minos.season.des`; rows = RewardType 1; "{0}° lugar em Virtude da Guilda" (`minos.season.condition`), with "a" or "a-b" (ItemUI:48-66) |
| Help `ui.minos.HelpFrame` (SimpleHelpFrame; `raw/ui/zh_cn/xml/decoded/minos.xml:758-772`) | "Instruções" (`public.help`) | Rules text | Help button (`MinosEnterFrame.as:83-88`) | `minos.helpFrame.helpContent` (weekly reset, 10 base + 5 buys, neighbour unlock, closed Sunday 23:30 to 06:00) |
| Minos shop tab (`m15/scripts/view/subshop/ConsortiaShopFrame.as:219-223, 586-603`) | shop | Spend "Pontos Minos" (-21000) | TopLeftUI shop button: `openControllerByInfo("shop",2,{minos:true})` (:82-85) | ShopType 1029, PayType 44, currency type 65. Economy area, not specified here |

All three main frames close themselves when `consortiaID` becomes 0 (`MinosEnterFrame.as:70-76`).

---

## 3. Actions

All requests use **9729 (0x2601) C_MINOS_CLIENT_OP** with `com.road.yishi.proto.player.PlayerOpMsg`.

- Sender: `MinosManager.doSomething(op, index=1, id=-1, pos=-1, type=-1)` (`CM/managers/MinosManager.as:216-226`).
- Fields always written: `op (#1, INT32)`, `type (#2, INT32)`, `id (#5, INT32)`, `index (#6, INT32)`, `pos (#19, INT32)`. Every setter sets the has-bit, so -1 values arrive as 10-byte negative varints.
- Op constants: `CM/mvc/module/minos/MinosConst.as:6-20`.

| op | Name | UI trigger and sender (file:line) | Fields | Client checks | Expected server reply, in order |
|---|---|---|---|---|---|
| 1 | OPEN | `MinosEnterFrame` constructor (`M6/MinosEnterFrame.as:34`) | index=1, rest -1 | in guild, `checkScene` | **552** MinosDataMsg, then **556** MinosPlayerMsg, then **557** MinosRankListMsg. 552 must come first: a new seasonId resets the model, including player info (`CM/mvc/module/minos/MinosModel.as:90-101, 261-269`). Subscribe the session to lobby pushes |
| 2 | CLOSE | `MinosEnterFrame.dispose` (:123) | index=1 | none | none; unsubscribe |
| 3 | ENTER | `MinousmapFrame.show(lv)`: sets `model.currBattleLv`, then `doSomething(3, lv)` (`M6/MinousmapFrame.as:109-117`) | index=levelId | card enabled only if the level is unlocked | **554** MinosMapMsg (full map), then **556**; optionally **553** for the level. Subscribe the session to (guild, level) map pushes |
| 4 | LEAVE | `MinousmapFrame.dispose` (:105) | index=levelId | none | none; unsubscribe. The entry frame then reopens and sends op 1 |
| 5 | FIGHT | `MinosCardChoseViewUI.fightClickHandler`: `doSomething(5, ForLevel, x, y, currDiff)` (`M6/ui/MinosCardChoseViewUI.as:254-258`) | index=levelId, id=x (0..15), pos=y (0..9), type=difficulty 1..4 | Button enabled only if `node.progress < NodeValueMax` (:246). The node must be open and NodeType ≠ 1 to be selectable (`M6/item/MinosNodeItem.as:87-145`). **No count or season check** | Battle **157** with battle_type **3909** (then 156/153/154/4103). After the report: **555** (changed nodes) to map subscribers, **553** to lobby and map subscribers, **556** to the fighter |
| 6 | NODE_REWARD | Reward slot button `MinosRwardNodeUI.clickhandler`: `doSomething(6, lv, idx)` (`M6/ui/MinosRwardNodeUI.as:160-163`) | index=levelId, id=rewardIdx 1..5 | Visible only when that slot's node has progress ≥ NodeValueMax and is not yet claimed (:102-137) | item grant (generic bag push), then **556** with the updated `levelRewardInfo` |
| 7 | FEAT_REWARD | `MinosGJRewardItemUI.clickHandler`: `doSomething(7, temp.Id)` (`M6/ui/MinosGJRewardItemUI.as:74-81`) | **index** = reward template Id 201..206 (not `id`) | enabled when `feat >= int(RewardCondition)` and the Id is not claimed (:83-109) | item grant, then **556** with `featRewardInfo` including the Id |
| 8 | BUY_COUNT | Map "+" button `MinosMapViewUI.addClickHandler` → `buyConfirm` (`M6/ui/MinosMapViewUI.as:448-469`) | index=1 | 1. `buyCount >= 5`: "Número de compras de hoje esgotadas" (`minos.nobuy`); 2. confirm "Deseja gastar {0} Diamante(s) para comprar 1 chance de participação?" (`minos.buy.time`, {0}=100) with the "Não alertar mais" option (`SharedManagerHelper.needAlert("view.minos.buyTime")`); 3. `playerInfo.point < 100` → recharge alert | diamond deduction (generic currency push), then **556** with buyCount+1 |
| none | select node, select difficulty, drag map, help, open GJ/season/shop frames | `MinosNodeItem.clickHandler` (:177-187), `MinosDiffChoseItem` (:50-78) | | client only | none |

---

## 4. Server messages

All are pushes, with no request correlation. The receivers are registered at `CM/managers/MinosManager.as:56-61`.

| Opcode | Name | Message and fields (tag, type) | Receiver (file:line) | When | Client effect |
|---|---|---|---|---|---|
| 552 (0x0228) | U_C_MINOS_DATA | `consortiaplay.MinosDataMsg`: `seasonId (#1, INT32)`, `state (#2, INT32)` stored but never read, `beginTime (#3, STRING)`, `endTime (#4, STRING)` ("YYYY-MM-DD hh:mm:ss" *(assumption)*; only substr(0,10) is shown), `levels (#5, MinosLevelMsg, repeated)` = **only unlocked levels** | `__seasonDataHandler` (:200-214) | Response to op 1; push on season change or level unlock | A new seasonId calls `model.reset()`. Levels are merged into `mapLvInfoDic`. Fires `minos_EVENT_LV_UPDATE` |
| 553 (0x0229) | U_C_MINOS_LEVEL_UPDATE | `MinosLevelMsg`: `id (#1)` level; `progress (#2)`; `progressMax (#3)`; `killNpc (#4)` guardians killed; `npcMax (#5)` (=4); `killBoss (#6)`; `bossMax (#7)` (=1); `killInfo (#8, STRING)` CSV of killed reward slot indices *(assumption)*. All INT32 except killInfo | `__lvDataHandler` / `readLvInfo` (:173-198) | Push to lobby and map subscribers of the guild after node progress; also unlocks a new level card | Upserts the level and refreshes cards. **Always send killInfo as a string ("" when empty)**: a null after a non-null value throws (`CM/mvc/module/minos/MinosLevelInfo.as:54-62`) |
| 554 (0x022a) | U_C_MINOS_MAP_DATA | `MinosMapMsg`: `id (#1, INT32)` level; `nodes (#2, MinosNodeMsg, repeated)`. MinosNodeMsg: `x (#1)`, `y (#2)`, `id (#3)` MinosNodeTmpl Id (send the grade-1 Id, e.g. 14101), `isOpen (#4, BOOL)`, `progress (#5, INT32)` | `__mapNodeHandler` (:137-144) → `readNodeInfo` (:146-171) → `MinosMapViewUI.updateView("init")` (:274-361) | Response to op 3 | Full map, keyed "x_y". 2x2 nodes (types 3/4/5) are anchored at top-left and need x ≤ 14, y ≤ 8; the client deletes the tiles (x+1,y), (x,y+1), (x+1,y+1) (:315-335), so never send nodes there. Reward slots: type-4 nodes sorted by y then x get idx 1..4, and the type-5 node gets idx 5 (:297-348) |
| 555 (0x022b) | U_C_MINOS_NODE_UPDATE | **Decoded as `MinosMapMsg`** (`{id, nodes}`), not `MinosNodeUpdateMsg` (`MinosManager.as:128-135`) | `__mapNodeUpdateHandler` | Push to sessions viewing that (guild, level) after any node change | Upserts the changed nodes, refreshes slots and the node panel (MapViewUI:351-360, 435-446). Ignored unless id == the open level |
| 556 (0x022c) | U_C_MINOS_PLAYER_DATA | `MinosPlayerMsg`: `challengeCount (#1, INT32)` used today; `buyCount (#2, INT32)` bought today; `levelRewardInfo (#3, STRING)` "lv,idx,idx\|lv,idx" (`CM/mvc/module/minos/MinosPlayerInfo.as:42-69`); `featRewardInfo (#4, STRING)` CSV of claimed RewardType-2 Ids (:27-35); `feat (#5, INT32)` season Virtude | `__playInfoHandler` (:114-126) | To the acting player only: after ops 1, 3, 6, 7, 8 and after a battle; at login *(assumption, the activity card needs it)* | Fires `minos_EVENT_PALYER_UPDATE`. Always send both strings. Send every level in levelRewardInfo, because entries are only overwritten, never cleared |
| 557 (0x022d) | U_C_MINOS_RANK_DATA | `MinosRankListMsg{ranks (#1, MinosRankMsg, repeated)}`. MinosRankMsg: `userId (#1, INT32)`, `nickName (#2, STRING)`, `fightPower (#3, INT32)` unused, `vipGrade (#4, INT32)` unused, `feat (#5, INT32)` | `__rankDataHandler` (:78-112) | Response to op 1; guild members of this season | The client sorts by feat descending and sets rank = index+1. Include the requester |
| 157, 156, 153, 154, 4103 | battle | `docs/battle/README.md` | battle module | Battle 3909 | Exit sets `isMinosMap` (`CM/battle/handler/BattleResultHandler.as:506-508`). Space or castle reopens the map frame at `currBattleLv`, which sends op 3 again (selection, scroll and difficulty are kept, `MinosModel.as:228-239`) |

**Result and error codes.** No Minos-specific error opcode exists. The client-side messages are `minos.nobuy`, the recharge alert, and the shop's "Pontos Minos insuficientes" (`quickbuy.QuickBuyFrame.noMinosCoinAlert`). Server-side rejections should use the generic **126 (0x007e) U_C_MSG** `CampaignNotifyMsg` (`CM/yishi/manager/BaseManager.as:299, 2070-2085`; core area) *(assumption)*.

---

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Daily base challenges | `Minos_ChallengeCount` = 10 | ConfigInfos; `MinosModel.as:60`; `MinosMapViewUI.as:110` |
| Buys | `Minos_ChallengePrice` = "5,100": max 5 per day, 100 diamonds (`playerInfo.point`) each, flat price, +1 challenge per buy | `MinosModel.as:61-67`; MapViewUI:103-110, 448-469 |
| Remaining | max(0, 10 + buyCount - challengeCount); no carry-over to the next day | MapViewUI:372; help item 2 |
| Season | `Minos_Opendays` = 7 (weekly). `Minos_CloseTime` = 390: challenges close 390 min before the end. The help text says no challenges from Sunday 23:30 to 06:00 the next day, so the season ends Monday 06:00 *(inference)* | ConfigInfos (server only); help item 4 |
| Feat | resets each season ("toda a Virtude é atualizada"); gained per win *(assumption: = GardenValue of the grade)* | `minos.gj.des` |
| Level unlock | guild level ≥ `GuildLevel` (1/3/5/7) and (level 1, or the previous level's lord killed) | `minos.open.needLv`, `minos.cardTip`, help item 3 |
| Node types | 1 start "Início do Labirinto" (1x1, NodeValueMax 0, not clickable); 2 "Soldado do Labirinto" 1x1; 3 soldier 2x2; 4 "Guardião do Labirinto" 2x2, counted in killNpc, slots 1-4; 5 "Senhor do Labirinto" 2x2, counted in killBoss, slot 5, unlocks the next level | `CM/mvc/module/minos/MinosNodeTempInfo.as:43-54`; NodeItem:147-163 |
| Node progress | win at grade g adds GardenValue(g); complete at NodeValueMax (same for all grades), capped *(assumption)* | ChoseViewUI:228-247 |
| Neighbour unlock | when a node completes, all surrounding nodes open: 8-neighbours for 1x1, 12-cell ring for 2x2 (`CM/mvc/module/minos/MinosPos.as:57-93, 198-236`). The start node counts as complete *(assumption)* | help item 3 |
| Level progress | progressMax = Σ NodeValueMax, progress = Σ node progress *(assumption)*; level 1 = 50·86 + 5·86 + 4·500 + 2000 = 8730 | |
| Node reward (op 6) | once per player per season per slot, after the slot node is complete; item contents unknown *(open question)* | |
| Feat rewards (op 7) | RewardType 2, thresholds 500/1000/3000/5000/10000/15000 (Ids 201-206), once per season | `MinosRewardTmpls.xml` |
| Season rewards | RewardType 1, guild feat rank ranges 1, 2, 3, 4-10, 11-20, 21-300; by mail at season end; feat 0 gets nothing | `minos.season.des` |
| Ranking | guild members by feat descending | `MinosManager.as:78-112` |

---

## 6. Templates

| File | Record | Fields and use |
|---|---|---|
| `raw/xml/tempinfos/MinosLevelTmpls.xml` (4 rows; `CM/mvc/module/minos/MinosLevelTempInfo.as`, `MinosLevelCate`) | level | `Id` 1..4. `LevelName` "1ª Fase".."4ª Fase". `GuildLevel` 1/3/5/7. `LevelImage` boss006/017/001/021 (card icon). `NodeNum` "type,count\|..." = node counts for server map generation (L1 "2,50\|3,5\|4,4\|5,1", L4 "2,68\|3,8\|4,4\|5,1"); not read by the client |
| `raw/xml/tempinfos/MinosNodeTmpls.xml` (212 rows; `MinosNodeTempInfo`, `MinosNodeCate.getDiffTempBy(ForLevel, NodeId, NodeType, grade)` :35-45) | node × grade | `Id` = `{ForLevel}{NodeType}{NodeId}{Grade:02}` (start = `L1101`). `NodeId` per level: type 2 → 1..5, type 3 → 1..3, type 4 → 1..4, type 5 → 1. `NodeGrade` 1..4 (0 for start). `NodeName`. `NodeValueMax` per level for types 2/3, 4 and 5: 86/500/2000, 150/1000/4000, 234/1750/7000, 360/3000/12000. `GardenValue` per grade, e.g. L1 soldier 9/11/15/22, guardian 34/42/50/63, lord 80/100/134/200. `Heroes` "GameHeroTemp id,pos" (types 4/5 at pos 6, e.g. 9014101). `Pawns` "PawnTempInfos id,pos\|..." (types 2/3/4 at pos 2 and 8; type 5 at 3, 5, 9). `RewardItem1..3`/`RewardNum1..3` = per-win rewards. The client never reads Heroes or Pawns |
| `raw/xml/tempinfos/MinosRewardTmpls.xml` (12 rows; `MinosRewardCate.getTempListBy` :40-52) | reward | `RewardType` 1 rank / 2 feat. `RewardCondition` "min,max" or a threshold. `RewardItem1..5`/`RewardNum1..5`, including -21000 "Pontos Minos" |
| `raw/xml/tempinfos/ConfigInfos.xml` | config | `Minos_ChallengeCount`, `Minos_ChallengePrice` (client); `Minos_CloseTime`, `Minos_Opendays` (server) |
| `GameHeroTemp.xml`, `HeroAis.xml`, `PawnTempInfos.xml` | battle units | e.g. 9014101 "Alma de Baelen" (boss011), pawn 901210101 "Cavaleiro do Julgamento" Level 50 |

---

## 7. Persistent state (PostgreSQL, schema `guild`)

```sql
CREATE TABLE guild.minos_season (
  season_id          integer PRIMARY KEY,
  begin_at           timestamptz NOT NULL,
  end_at             timestamptz NOT NULL,
  challenge_close_at timestamptz NOT NULL,
  state              smallint NOT NULL DEFAULT 1 CHECK (state BETWEEN 0 AND 3),
  settled_at         timestamptz,
  CHECK (end_at > begin_at)
);
CREATE UNIQUE INDEX minos_season_begin ON guild.minos_season (begin_at);

CREATE TABLE guild.minos_guild_level (
  season_id     integer  NOT NULL REFERENCES guild.minos_season(season_id),
  guild_id      integer  NOT NULL REFERENCES guild.guilds(id) ON DELETE CASCADE,
  level_id      smallint NOT NULL CHECK (level_id BETWEEN 1 AND 4),
  progress      integer  NOT NULL DEFAULT 0 CHECK (progress >= 0),
  progress_max  integer  NOT NULL CHECK (progress_max > 0),
  kill_npc      smallint NOT NULL DEFAULT 0,
  npc_max       smallint NOT NULL DEFAULT 4,
  kill_boss     smallint NOT NULL DEFAULT 0,
  boss_max      smallint NOT NULL DEFAULT 1,
  killed_reward_idx smallint[] NOT NULL DEFAULT '{}',
  unlocked_at   timestamptz NOT NULL DEFAULT now(),
  PRIMARY KEY (season_id, guild_id, level_id)
);

CREATE TABLE guild.minos_guild_node (
  season_id        integer  NOT NULL,
  guild_id         integer  NOT NULL,
  level_id         smallint NOT NULL,
  x                smallint NOT NULL CHECK (x BETWEEN 0 AND 15),
  y                smallint NOT NULL CHECK (y BETWEEN 0 AND 9),
  node_template_id integer  NOT NULL,
  node_type        smallint NOT NULL CHECK (node_type BETWEEN 1 AND 5),
  node_no          smallint NOT NULL,
  reward_idx       smallint CHECK (reward_idx BETWEEN 1 AND 5),
  is_open          boolean  NOT NULL DEFAULT false,
  progress         integer  NOT NULL DEFAULT 0 CHECK (progress >= 0),
  PRIMARY KEY (season_id, guild_id, level_id, x, y),
  FOREIGN KEY (season_id, guild_id, level_id) REFERENCES guild.minos_guild_level ON DELETE CASCADE,
  CHECK (node_type < 3 OR (x <= 14 AND y <= 8)),
  CHECK ((node_type IN (4,5)) = (reward_idx IS NOT NULL))
);
CREATE UNIQUE INDEX minos_guild_node_slot ON guild.minos_guild_node (season_id, guild_id, level_id, reward_idx) WHERE reward_idx IS NOT NULL;

CREATE TABLE guild.minos_player (
  season_id       integer  NOT NULL REFERENCES guild.minos_season(season_id),
  player_id       integer  NOT NULL REFERENCES game.players(id),
  guild_id        integer  NOT NULL REFERENCES guild.guilds(id),
  feat            integer  NOT NULL DEFAULT 0 CHECK (feat >= 0),
  challenge_count smallint NOT NULL DEFAULT 0 CHECK (challenge_count >= 0),
  buy_count       smallint NOT NULL DEFAULT 0 CHECK (buy_count BETWEEN 0 AND 5),
  counts_day      date     NOT NULL,
  updated_at      timestamptz NOT NULL DEFAULT now(),
  PRIMARY KEY (season_id, player_id)
);
CREATE INDEX minos_player_rank ON guild.minos_player (season_id, guild_id, feat DESC);

CREATE TABLE guild.minos_player_node_reward (
  season_id  integer  NOT NULL,
  player_id  integer  NOT NULL,
  level_id   smallint NOT NULL CHECK (level_id BETWEEN 1 AND 4),
  reward_idx smallint NOT NULL CHECK (reward_idx BETWEEN 1 AND 5),
  claimed_at timestamptz NOT NULL DEFAULT now(),
  PRIMARY KEY (season_id, player_id, level_id, reward_idx),
  FOREIGN KEY (season_id, player_id) REFERENCES guild.minos_player
);

CREATE TABLE guild.minos_player_feat_reward (
  season_id          integer NOT NULL,
  player_id          integer NOT NULL,
  reward_template_id integer NOT NULL CHECK (reward_template_id BETWEEN 201 AND 299),
  claimed_at         timestamptz NOT NULL DEFAULT now(),
  PRIMARY KEY (season_id, player_id, reward_template_id),
  FOREIGN KEY (season_id, player_id) REFERENCES guild.minos_player
);

CREATE TABLE guild.minos_season_reward_log (
  season_id          integer NOT NULL,
  player_id          integer NOT NULL,
  guild_id           integer NOT NULL,
  rank               integer NOT NULL CHECK (rank > 0),
  feat               integer NOT NULL,
  reward_template_id integer NOT NULL,
  mailed_at          timestamptz NOT NULL DEFAULT now(),
  PRIMARY KEY (season_id, player_id)
);
```

Scopes:
- Season: global.
- Levels and nodes: per guild per season.
- Feat, counts and claims: per player per season. Counts also reset daily (lazy reset via `counts_day`).
- Subscriptions (lobby open, viewed level) are in-memory session state.

---

## 8. Backend implementation notes

**Dispatch.** 9729 is routed on `op`. Common prelude:
1. The player is in a guild.
2. Load the current season.
3. Run the lazy daily reset of `minos_player`.

| Handler | op | Validation order | Transaction and pushes |
|---|---|---|---|
| `guild::minos::handle_open` | 1 | in guild | Lazily create level 1 and its map for the guild (tx). Send 552, 556, 557. Subscribe to the lobby |
| `guild::minos::handle_close` | 2 | none | Unsubscribe |
| `guild::minos::handle_enter` | 3 | level unlocked for the guild | Send 554 (full map), then 556. Subscribe to (guild, level) |
| `guild::minos::handle_leave` | 4 | none | Unsubscribe from (guild, level) |
| `guild::minos::handle_fight` | 5 | 1. now < challenge_close_at; 2. level unlocked; 3. node at (x,y) is an anchor cell, is_open, type ≠ 1, progress < NodeValueMax; 4. grade 1..4 and its template exists; 5. 10 + buy_count - challenge_count > 0; 6. not already in battle | tx A: lock `minos_player`, challenge_count+1 *(assumption: consumed at start)*. Start battle 3909 outside the tx |
| `guild::minos::on_battle_result` | (battle report) | win only *(assumption)* | tx B: lock node FOR UPDATE, then the level; progress += GardenValue (capped); on completion open neighbours, update kill counters and killed_reward_idx; feat += GardenValue *(assumption)*; grant RewardItem1..3; on a lord kill unlock level+1 if guild level allows and generate its map. After commit: 555 to (guild, level) viewers, 553 to lobby and map subscribers of the guild (plus 553 for a new level), 556 to the fighter |
| `guild::minos::handle_claim_node_reward` | 6 | level unlocked; idx 1..5; slot node complete; not claimed | tx: insert claim + grant items; send 556 |
| `guild::minos::handle_claim_feat_reward` | 7 | template from `index`; RewardType 2; feat ≥ condition; not claimed | tx: insert claim + grant items; send 556 |
| `guild::minos::handle_buy_count` | 8 | season open *(assumption)*; buy_count < 5; diamonds ≥ 100 | tx: debit 100 diamonds + buy_count+1; currency push, then 556 |

**Scheduled jobs.**
- `guild::minos::season_rollover`: create the next season (Monday 06:00 *(assumption)*). Clients see it on the next 552.
- `guild::minos::season_settle` at end_at: rank each guild's members by feat (feat > 0) and mail the RewardType-1 reward for the rank range. Write `minos_season_reward_log` for idempotency.

**Map generation.**
- Per (guild, season, level): one type-1 start node, plus the `NodeNum` counts per type, on the 16x10 grid.
- 2x2 nodes must not overlap and must keep x ≤ 14, y ≤ 8.
- The map must be connected through neighbour adjacency.
- Assign `reward_idx` to type-4 nodes by (y, x) order as 1..4, and 5 to the lord.
- `MinosModel.radomMapEvents` (`CM/mvc/module/minos/MinosModel.as:108-189`) is an unused client prototype of such a generator. Use it as a reference only, because it has overlap bugs.

**Battle rule config** (`docs/battle/server-engine.md` §9.2):

```json
{"battle_type":3909,"map":"<MapInfos id with a BattleGround, unknown (assumption: a default PvE map)>","count_down":180,
 "heroes":[ <player hero>, {"temp_id":"<Heroes id, e.g. 9014101>","type":3,"pos":6} ],
 "soldiers":[ <player soldiers>, {"temp_id":"<Pawns id>","pos":"<pos from Pawns>","side":2}, ... ],
 "report":{"battle_result":1,"items":"<RewardItem1..3 × RewardNum1..3 of the grade>"},"report_defeat":{"battle_result":2}}
```

Node types 2 and 3 have no enemy hero, only pawns. Check that the engine accepts an enemy side with soldiers only.

---

## 9. Cross-area dependencies

- **Core:** guild membership, guild level, online sessions, generic error tip.
- **Economy:** diamonds (buy), Minos shop and currency -21000, item grants, mail for season rewards.
- **Battle:** engine support for 3909.
- **Ranking scope:** guild members.

---

## 10. Open questions

1. Item contents of a node reward (op 6).
2. Feat per win, whether a loss consumes a challenge or adds progress, and whether progress is capped.
3. The `progressMax` formula and the meaning of `state` in 552.
4. The daily reset hour, and whether 556 is pushed at login.
5. The battle map id for 3909.
6. NodeId assignment for type 2/3/4 variants on generated maps.
7. Whether feat follows a player who changes guild mid-season.
8. The rank tie-break and the number of rows in 557.
9. Whether 126 U_C_MSG is the right channel for server-side rejections.

---

## 11. Implementation checklist

**Client screens and actions (verify against the backend):**

- [ ] Activity entry id -1 (counter text, join → `openMinosFrame`)
- [ ] `MinosEnterFrame`: open (op 1) / close (op 2), cards, top progress, ranking, season dates, help
- [ ] `MinousmapFrame`: enter (op 3) / leave (op 4), grid, minimap, counter, reward slots
- [ ] Node panel: difficulty select, fight (op 5)
- [ ] Reward slot claim (op 6)
- [ ] `MinosGJRewardFrame` claim (op 7)
- [ ] Buy challenge with confirm (op 8)
- [ ] `MinosSeaonRewardFrame` (display)
- [ ] Return from battle 3909 reopens the map

**Backend:**

- [ ] `guild::minos::handle_open`, `handle_close`, `handle_enter`, `handle_leave`
- [ ] `guild::minos::handle_fight` + battle 3909 builder (Heroes/Pawns → GameHeroTemp, HeroAis, PawnTempInfos)
- [ ] `guild::minos::on_battle_result` (progress, neighbour unlock, kills, feat, rewards, next level)
- [ ] `guild::minos::handle_claim_node_reward`, `handle_claim_feat_reward`, `handle_buy_count`
- [ ] Pushes 552, 553, 554, 555 (as MinosMapMsg), 556, 557 with ordering and subscriptions
- [ ] Map generator
- [ ] Season rollover, settlement and mail
- [ ] Lazy daily reset
- [ ] Template loaders: MinosLevelTmpls, MinosNodeTmpls, MinosRewardTmpls, ConfigInfos keys

**Tables:**

- [ ] `guild.minos_season`
- [ ] `guild.minos_guild_level`
- [ ] `guild.minos_guild_node`
- [ ] `guild.minos_player`
- [ ] `guild.minos_player_node_reward`
- [ ] `guild.minos_player_feat_reward`
- [ ] `guild.minos_season_reward_log`
