# Air garden ("Jardim", 空中花园) and its mini games

Feature `seasonal-events`, module `air-garden`. Client code: `M9/airgarden/*` (party frames), `M3/map/campaign/view/ui/airgarden/*` (garden scene UI and the three mini games), `M3/map/campaign/mediator/airgarden/*`, `CM/mvc/module/airgarden/*` (models), `CM/mvc/controler/AirGardenControl.as`, managers `CM/managers/AirGardenManager.as` (`AGM`), `AirGardenGameLlkManager.as` (`AGL`), `AirGardenMemoryCardManager.as` (`AGMC`), `AirGardenFivecardManager.as` (`AGF`); bed shop `M15/view/subshop/AirGarden*`. Proto packages `airgarden`, plus `minigame` (`FiveCardPokerMsg`, `MemoryCardMsg`), `linkgame` (`LinkGameMsg`) and `player.CommonMsg`.

Conventions: see [README.md](README.md). `M3` = `decompiled/m3/scripts`, `M9` = `decompiled/m9/scripts`, `M15` = `decompiled/m15/scripts`.

**Status in this client:** `VersionSwitch.AIR_GARDEN = false` (`CM/yishi/datas/VersionSwitch.as:164`). Every garden entry (`SwitchPageHelp.enterAirGardenCampaign`, `airGardenCreateParty`, `airGardenJoinParty`, `CM/yishi/SwitchPageHelp.as:2610-2660`) shows "not open" and the garden bed currency is hidden (`CM/managers/PlayerCurrencyManager.as:718`). The **three mini games are live** because the Carnival "Joguinho" tab opens them ([carnival.md](carnival.md)) and the star area opens them too ([../cosmos/stararea.md](../cosmos/stararea.md)). Implement the mini games first; the garden itself is optional.

Ownership of the games: the five card (5443) and memory card (5444) handlers and their session table belong to [../casino/minigames.md](../casino/minigames.md) (owner of proto package `minigame`); the air garden link game (8859/4736 through `AirGardenGameLlkManager`) belongs here ([../mazes/link-game.md](../mazes/link-game.md) documents only the dormant standalone variant). This module owns the garden (5442, 376..380), the game launcher 381 and the context callbacks (Carnival rewards).

---

## 1. Overview

- **Garden** (disabled): each player owns a garden campaign map with bed nodes (`AirGardenNodeTemplates` NodeType 901..904) where they display their hero, a guardian, a mount or an Einherjar. On configured weekdays a player can pay diamonds to host a party; other players visit, "like" ("curtir") the garden to raise its heat ("Calor") and play mini games in it. Game scores convert to "Cristal da diversão" (-5000) and the host's total score to "Cristal da loucura" (-5100) *(assumption from config descriptions)*.
- **Mini games**:
  - "Jogo de Ligação" (match pairs, link game, 8x14 grid, bombs and shuffles).
  - "Jogo da memória" (flip pairs, auto flip and reveal chances).
  - "Jogo de 5 Cartas" (five-card draw poker, 5 rounds, hold cards, hand ranks).
  Each game ends with a score; the server converts it into a reward and sends an alert "Você obteve {0}pontos no jogo que foram trocados por {1} Cristais da diversão" (`AirGardenGame.hint3`).

---

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `airgarden.AirGardenCreatePartyFrame` (`M9/airgarden/AirGardenCreatePartyFrame.as`) | "Apresentação da festa" | Host a party | NPC dialog option 138 (`M3/map/space/view/frame/DialogOptionItem.as:810`) | Intro text (max 30 chars, default "Sintam-se à vontade para visitar meu jardim!"), cost "Custo da festa {0}" |
| `airgarden.AirGardenJoinPartyFrame` | "Lista de festas" | Party list | NPC option 139 | `AirGardenCampaignMsg` rows: host, heat, likes, score |
| Garden scene views (`M3/.../airgarden/AirGardenCampaignTopView.as`, `RightView`, `RightItem`, `SmallMapFrame`) | "Calor do jardim:{0}", "Curtidas restantes no jardim:{0}/{1}", "Contagem para curtidas:{0}" | Garden HUD | Entering a garden (option 137 own garden, or a list row) | Heat, likes, remaining games per type, like cooldown |
| `AirGardenCampaignShowFrame` (`BED_CAMPAIGN_SHOW`) | "Guardiões" / "Montarias" / "Einherjars" | Choose what a bed displays | Clicking an own bed node of type 902/903/904 (`CM/mvc/controler/AirGardenControl.as:90-118`) | Owned guardians, mounts or Einherjars |
| Bed shop (`M15/view/subshop/AirGardenShopFrame.as`, `AirGardenShopBedView`, `AirGardenShopBedItem`) | "Loja do jardim" | Buy beds | NPC option 140 (`shop` 1018) | Bed templates, cost in bed coins, limit |
| `AirGardenGameLlkFrame` (`M3/.../airgarden/game/llk/AirGardenGameLlkFrame.as`) | "AirGardenGame.llk.title" | Link game | 381 with `param1 = 1` | 8x14 board, time, score, bombs, shuffles, target "samll.game.score" |
| `AirGardenGameMemoryCardFrame` (`.../game/memorycard/`) | "Jogo da memória" | Memory game | 381 `param1 = 2` | Cards, turn, score, "Auto-virar cartas" and "Revelações de cartas" chances, duration |
| `AirGardenGameFivecardFrame` (`.../game/fivecard/`) | "Jogo de 5 Cartas" | Poker | 381 `param1 = 3` | 5 cards, round (max 5, `AGF:31`), score table (9 hand ranks "Straight Flush".."Outro") |

---

## 3. Routes (client to server)

### 3.1 Garden: 5442 (0x1542) `C_AIR_GARDEN_OP`, body `player.CommonMsg`

`CommonMsg`: `param1` (#1, INT32) op; `param2` (#2, INT32); `param3` (#3, INT32); `param4` (#4, STRING); `param5` (#5, STRING); `param6` (#6, INT64); `param7` (#7, INT64).

| param1 | UI control | Sender (file:line) | Client checks | Other params | Expected response |
|---|---|---|---|---|---|
| 1 | Enter a garden | `AGM.reqAirGardenCampaign(1, userId)` (`AGM:271-278`) via `SwitchPageHelp.enterAirGardenCampaign` (`SwitchPageHelp.as:2610-2623`) | switch on, `vocationGrades > 0` | param2 = garden owner userId | Campaign map enter (campaign scene protocol) *(assumption)*, 378, 379, 380 |
| 2 | Party list | `AGM.requestAirGarden(2)` (`AGM:263-269`) from `AirGardenJoinPartyFrame()` (`M9/airgarden/AirGardenJoinPartyFrame.as:34`) and `AirGardenCampaignRightView()` (`M3/.../AirGardenCampaignRightView.as:88`) | switch on | | 377 pages |
| 3 | Put on a bed | `AGM.reqAirGardenBed(tempId, nodeId)` (`AGM:280-288`) from `AirGardenCampaignShowItem.__showBtnClickHandler` (`:83-90`) and `AirGardenControl.showSureFrameBack` (`:130-137`, tempId 0 = own hero appearance after "Deseja exibir a aparência atual?") | own garden | param2 = displayed template id (0 hero), param3 = campaign node id | 379 detail |
| 4 | Create party | `AGM.airGardenCreateParty(intro)` (`AGM:290-297`) from `AirGardenCreatePartyFrame.sureBackHandler` (`:151`) | `canCreateParty` else "Não é possível criar festa neste horário"; not `selfCreatedParty` else "Você já começou uma festa, aguarde seu fim"; confirm "Deseja gastar {0} diamantes para começar uma festa?" | param4 = intro | 376, 377 |
| 5 | Like | `SwitchPageHelp.airGardenCampaignUp` (`:2664-2694`) | not party time ("Agora é horário de festa, não é possível curtir"), host has a party entry, not own garden, `selfUpCount < air_garden_up_single_max_count`, garden `upCount < air_garden_up_max_count` | param2 = host userId | 376 (`selfUpCount`, `upCdEndTime`), 378 |
| 6 | Join a game | `AGM.airGardenJoinGame(host, type)` (`AGM:299-307`) via `SwitchPageHelp.joinAirGardenPartyGame(type)` (`:2696-2729`) | party time; host has a party; not own; `extraGameCount > 0` or (`gameRemain > 0` and host `gameRemainList[type-1] > 0`) with tips "Número de jogos insuficiente", "Número de Jogos de Ligação/da Memória/de 5 Cartas insuficiente" | param2 = host, param3 = game type 1..3 | 381 then the game protocol |
| 8 | Refresh garden info | `AGM.reqAirGardenCampaign(8, userId)` from `AirGardenCampaignTopView()` (`:75`) and `AirGardenShopBedView` (`M15/view/subshop/AirGardenShopBedView.as:25`) | | param2 = owner | 378, 379 |
| 9 | Buy a bed | `AGM.sendBedShopBuy(templateId)` (`AGM:309-315`) from `AirGardenShopBedItem` (`M15/.../AirGardenShopBedItem.as:95-106`) | bought < `limitCount` ("Limite de bases deste tipo que pode ser posto atingido"); bed coins >= cost | param2 = bed template id | currency push, 379 |

### 3.2 Link game: 8859 (0x229b) `C_LINKGAME_OP`, body `linkgame.LinkGameMsg`

Senders `AGL.llkOp(op)` (`AGL:51-57`), `AGL.llkBuy(op, useBind)` (`AGL:59-66`, unused by the air garden frames), `AGL.llkDelete(a, b)` (`AGL:68-78`).

| op_type | Control | Sender call site | Client checks | Fields set | Response |
|---|---|---|---|---|---|
| 1 START | Frame opens / start | `AirGardenGameLlkFrame.requestInfo` (`:246-251`), skipped in star area mode | none | `op_type` | 4736 with the board |
| 2 DELETE | Two matching tiles linked | `AirGardenGameLlkFrame` (`:458`) | client path check | `a_x`, `a_y`, `b_x`, `b_y` (row, column of both tiles) | 4736 with `a_*`, `b_*`, `comb_count`, `add_score`, `point_value`, new `score` |
| 3 USE_BOMB | Bomb item | `AirGardenGameLlkGoodsItem` (`:140-150`) | `bombCount > 0` ("Número de bombas insuficientes"), board started | | 4736 |
| 4 RESET | Shuffle item | `AirGardenGameLlkGoodsItem` (`:152-165`) | `resetCount > 0` ("Número de embaralhamentos insuficientes") | | 4736 with new `points` |
| 5 CLOSE | Frame closes | `AirGardenGameLlkFrame.dispose` (`:495-501`) | | | 4736 with `reward` "count,templateId" (alert) |

### 3.3 Memory game: 5444 (0x1544) `C_MEMORY_CARD_OP`, body `minigame.MemoryCardMsg`

| op | Sender (`AGMC`) | Call site | Client checks | Fields | Response |
|---|---|---|---|---|---|
| 1 START | `sendStart` (`:166-172`) | `AirGardenGameMemoryCardFrame` (`:360`) | | | 194 with `cards`, `duration`, chances |
| 2 FLIP | `sendFlip(i1, i2)` (`:174-182`) | `AirGardenGameMemoryCardItem` (`:140`) after two cards are open | | `cIndex1`, `cIndex2` | 194 `op 2` with `result`, `addScore`, `score` |
| 3 AUTO | `sendAuto` (`:184-190`) | frame (`:232-245`) | not while one card is open ("Primeiro vire um par de cartas para prosseguir") | | 194 `op 3` with the auto pair |
| 4 SHOW | `sendShow` (`:192-198`) | frame (`:246-249`) | same | | 194 `op 4` with all `cards` revealed briefly |
| 5 CLOSE | `sendClose` (`:200-206`) | frame (`:407`) | | | 195 reward |

### 3.4 Five cards: 5443 (0x1543) `C_FIVE_CARD_POKER_OP`, body `minigame.FiveCardPokerMsg`

| op | Sender (`AGF`) | Call site | Fields | Response |
|---|---|---|---|---|
| 1 START | `sendStart` (`:110-116`) | `AirGardenGameFivecardFrame` (`:281`) | | 192 with 5 `pokers`, `curTurn` |
| 2 NEXT | `sendNext` (`:118-124`) | "continue" (`:174-186`) | | 192 next round cards |
| 3 SHOW | `sendShow(hold)` (`:126-133`) | "OK" (`:188-212`) | `holdList` = indexes kept (1..5) | 192 `op 3` with replaced cards, `addScore`, `score` |
| 4 CLOSE | `sendClose` (`:135-141`) | frame (`:325`) | | 193 reward |

---

## 4. Server messages (server to client)

| Opcode | Name | Message | Receiver | When | Reaction |
|---|---|---|---|---|---|
| 376 (0x0178) | U_C_AIR_GARDEN_STATE | `airgarden.AirGardenStateMsg` | `AGM.__airGardenStateHandler` (`AGM:58, 65-107`) | Login, party windows, after create or like | Only fields with `has*` are applied; notifies `AIRGARDEN_STATE_CHANGE` |
| 377 (0x0179) | U_C_AIR_GARDEN_LIST (shares the code with U_C_BRAVE_ALLTEAMS) | `airgarden.AirGardenCampaignMsgList` | `AGM.__partyListUpdateHandler` (`:59, 109-142`) | After op 2, paged | `page == 0 && totalPage == 0` clears the list; rows merged by `masterUserId` |
| 378 (0x017a) | U_C_AIR_GARDEN_CAMPAIGN_INFO | `airgarden.AirGardenCampaignMsg` | `CampaignSocketManger.__airGardenCampaignHandler` (`M3/map/campaign/CampaignSocketManger.as:413, 3155-3187`) | Entering or refreshing a garden, after a like | Updates current garden info, notifies `CAMPAIGN_INFO_UPDATE` |
| 379 (0x017b) | U_C_AIR_GARDEN_CAMPAIGN_DETAIL | `airgarden.AirGardenCampaignDetailMsg` | `AGM.__airGardenCampaignDetailHandler` (`:61, 168-237`) | Entering, bed changes | Bed list for the visited and/or own garden |
| 380 (0x017c) | U_C_AIR_GARDEN_SELF | `airgarden.AirGardenSelfMsg` | `AGM.__selfGardenUpdateHandler` (`:60, 144-166`) | After entering and after each game | Own counters |
| 381 (0x017d) | U_C_AIR_GARDEN_GAME_OPEN | `player.CommonMsg` | `AGM.__gameStartBackHandler` (`:62, 239-261`) | After 5442 op 6 or Carnival 9019 op 9 | `param1` 1/2/3 opens LLK/memory/five card frame |
| 4736 (0x1280) | U_C_LINK_GAME_INFO | `linkgame.LinkGameMsg` | `AGL.__llkInfoHandler` (`AGL:87, 90-153`) | Every 8859 | Board (`points` must have 112 values, else only logged), deletes queue, reward alert if `reward` set |
| 194 (0x00c2) | U_C_MEMORY_CARD_INFO | `minigame.MemoryCardMsg` | `AGMC.infoHandler` (`AGMC:58, 62-148`) | Every 5444 except close | By `op`: 2 flip, 3 auto, 4 show; otherwise new deck (2 s delay if a deck exists) |
| 195 (0x00c3) | U_C_MEMORY_CARD_REWARD | `minigame.MemoryCardRewardMsg` | `AGMC.scoreAwardHandler` (`:155-164`) | On close | Alert hint3 with `score`, `count` |
| 192 (0x00c0) | U_C_FIVE_CARD_POKER_INFO | `minigame.FiveCardPokerMsg` | `AGF.infoHandler` (`AGF:54, 58-92`) | Every 5443 except close | `op 3` → `SHOW_FIVE_CARD`, else `INIT_FIVE_CARD` |
| 193 (0x00c1) | U_C_FIVE_CARD_SCORE_REWARD | `minigame.FiveCardPokerRewardMsg` | `AGF.scoreAwardHandler` (`:99-108`) | On close | Alert hint3 |

Fields:

| Message | Fields |
|---|---|
| `AirGardenStateMsg` | `canCreateParty` (#1, BOOL); `createBeginTime` (#2, INT64 ms), `createEndTime` (#3, INT64); `isParty` (#4, BOOL) party time now; `partyBeginTime` (#5, INT64), `partyEndTime` (#6, INT64); `selfCreatedParty` (#7, BOOL); `selfUpCount` (#8, INT32) likes given; `upCdEndTime` (#9, INT64) like cooldown end |
| `AirGardenCampaignMsgList` | `page` (#1, INT32), `totalPage` (#2, INT32), `list` (#3, AirGardenCampaignMsg, repeated) |
| `AirGardenCampaignMsg` | `masterUserId` (#1, INT32); `isParty` (#2, BOOL); `upCount` (#3, INT32) likes this week; `gameRemainList` (#4, INT32, repeated) remaining plays per game type; `totalScore` (#5, INT32); `nickName` (#6, STRING); `intro` (#7, STRING); `headId` (#8, INT32); `fightCapacity` (#9, INT32); `hotCount` (#10, INT32) heat |
| `AirGardenCampaignDetailMsg` | `nodeList` (#1, AirGardenCampaignNodeMsg, repeated); `masterUserId` (#2, INT32) |
| `AirGardenCampaignNodeMsg` | `campaignNodeId` (#1), `nodeTempId` (#2) bed template, `objId` (#3), `tempId` (#4) displayed template, `grade` (#5), `hero` (#6, AirGardenHeroMsg) |
| `AirGardenHeroMsg` | `player_id` (#1), `grades` (#2), `nick_name` (#3, STRING), `sex` (#4), `template_id` (#5), `arm` (#6), `cloth` (#7) STRING, `consortia_id` (#8), `consortia_name` (#9), `change_shapeId` (#10), `head_id` (#11), `is_vip` (#12, BOOL), `vip_type` (#13), `wing` (#16), `server_name` (#17), `hat` (#18), `fashion_arm` (#19), `fashion_cloth` (#20) STRING, `hide` (#21, BOOL), `appellid` (#22), `dragon_grade` (#23, STRING), `transfer_grade` (#24), `change_branch` (#25). The client reads id, grades, nick, sex, template, head and avatar strings |
| `AirGardenSelfMsg` | `gameRemain` (#2, INT32) own fixed plays left; `extraGameCount` (#3, INT32); `selfScore` (#4, INT32); `thisUpCount` (#5, INT32) likes given in this garden |
| `LinkGameMsg` | `op_type` (#1), `a_x` (#2), `a_y` (#3), `b_x` (#4), `b_y` (#5), `score` (#6), `time` (#7) seconds, `strength` (#8), `points` (#9, STRING) 112 comma separated tile values, `bomb_count` (#10), `reset_count` (#11), `param1` (#12) buy with bound diamonds flag, `tollgate` (#13) level, `reward` (#14, STRING) "count,templateId", `comb_count` (#15), `add_score` (#16), `point_value` (#17), `scoreValue` (#18, INT32, repeated). All INT32 unless noted |
| `MemoryCardMsg` | `op` (#1), `curTurn` (#2), `score` (#3), `addScore` (#4), `addScore2` (#5), `cIndex1` (#6), `cIndex2` (#7), `result` (#8, BOOL) pair matched, `leftAutoChance` (#9), `leftCheckChance` (#10), `duration` (#11) seconds, `cards` (#12, MemoryCard, repeated) |
| `MemoryCard` | `index` (#1), `type` (#2) |
| `MemoryCardRewardMsg`, `FiveCardPokerRewardMsg` | `templateId` (#1), `count` (#2), `score` (#3) |
| `FiveCardPokerMsg` | `op` (#1), `curTurn` (#2), `score` (#3), `addScore` (#4), `pokers` (#5, FiveCardPoker, repeated), `holdList` (#6, INT32, repeated) |
| `FiveCardPoker` | `index` (#1) 1..5, `color` (#2) suit, `number` (#3) rank |

---

## 5. Rules and formulas

Config (`ConfigInfos.xml`, getters `CM/yishi/datas/ConfigInfoManager.as:1198-1250`):

| Key | Value | Meaning |
|---|---|---|
| `air_garden_party_create_time` | `1#9:00,4#0:00` | Weekly window to create a party (weekday#time from, to) |
| `air_garden_party_time` | `4#14:00,5#9:00` | Weekly party window |
| `air_garden_party_cost` | 2000 | Diamonds to host |
| `air_garden_up_cd` | 480 | Like cooldown (minutes) |
| `air_garden_up_single_max_count` | 5 | Max likes per player |
| `air_garden_up_max_count` | 50 | Max likes per garden per week |
| `air_garden_game_count` | `100,100,100` | Party game plays per type (link, memory, poker) offered by a host |
| `air_garden_user_game_count` | 10 | Fixed personal plays per party |
| `air_garden_game_score_to_crystal` | `10,1` | 10 game points → 1 "Cristal da diversão" |
| `air_garden_total_score_to_crystal` | `10,1` | 10 total points → 1 "Cristal da loucura" (host) |

- Bed nodes: `AirGardenNodeTemplates` NodeType 901 hero, 902 guardian, 903 mount, 904 Einherjar; `Cost` list = bed coin price per purchased copy *(assumption)*.
- Link game: 8 rows x 14 columns (`CM/mvc/module/llk/LlkModel.as:10-12`); combos raise `add_score`; time limit `time`.
- Memory game: score per pair `addScore`, combo `addScore2`; `leftAutoChance` and `leftCheckChance` limit helpers.
- Five cards: 5 rounds (`MAX_PLAY_TIME`), hand ranks: Straight Flush, Quadra, Full House, Flush, Straight, Trinca, 2 pares, Par maior de 7, Outro (`AirGardenGame.fivecard.result1..9`). Score per rank *(assumption: server table, not in the client)*.
- End of game (close op): reward = `floor(score / 10)` "Cristal da diversão" in the garden; in Carnival mode the reward is the `CarnivalPlayGroundTemplates` items when `score >= Target` ([carnival.md](carnival.md)).

---

## 6. Templates

| File | Use |
|---|---|
| `AirGardenNodeTemplates.xml` (4) | `TemplateId`, `ItemTempId`, `NodeType`, `Cost` |
| `CarnivalPlayGroundTemplates.xml` | Target score shown in each game frame ("samll.game.score") |
| `ConfigInfos.xml` | keys above |

---

## 7. Persistent state (PostgreSQL, schema `seasonal_events`)

```sql
CREATE TABLE seasonal_events.link_game_sessions (
  player_id    bigint   PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
  context      text     NOT NULL CHECK (context IN ('carnival','air_garden','star_area','christmas_snowy')),
  context_ref  integer,
  board        smallint[] NOT NULL,
  score        integer  NOT NULL DEFAULT 0,
  bomb_count   smallint NOT NULL DEFAULT 0,
  reset_count  smallint NOT NULL DEFAULT 0,
  started_at   timestamptz NOT NULL DEFAULT now(),
  expires_at   timestamptz
);

-- five card and memory card sessions: casino.minigame_session (../casino/minigames.md); add a context column there
-- (or a side table keyed by player_id) so the settle step knows whether to pay crystals or call the Carnival callback

CREATE TABLE seasonal_events.air_gardens (
  owner_id        bigint  PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
  intro           text,
  heat            integer NOT NULL DEFAULT 0,
  week_likes      integer NOT NULL DEFAULT 0,
  total_score     integer NOT NULL DEFAULT 0,
  party_week      date,
  game_remaining  integer[] NOT NULL DEFAULT '{0,0,0}'
);

CREATE TABLE seasonal_events.air_garden_beds (
  owner_id     bigint   NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  node_id      integer  NOT NULL,
  bed_template integer  NOT NULL,
  shown_template integer NOT NULL DEFAULT 0,
  PRIMARY KEY (owner_id, node_id)
);

CREATE TABLE seasonal_events.air_garden_visitors (
  owner_id    bigint  NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  player_id   bigint  NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  party_week  date    NOT NULL,
  likes       smallint NOT NULL DEFAULT 0,
  games_played smallint NOT NULL DEFAULT 0,
  score       integer NOT NULL DEFAULT 0,
  PRIMARY KEY (owner_id, player_id, party_week)
);
```

---

## 8. Backend implementation notes

| Handler | Route | Notes |
|---|---|---|
| `seasonal_events::air_garden::handle_op` | 5442 | Dispatch by `param1`; reject everything with a "not open" tip while the garden is disabled |
| `seasonal_events::air_garden::open_game` | internal (from 5442 param1 6 and Carnival 9019 op 9) | create the session with its `context`, send 381 `param1 = type` |
| `seasonal_events::air_garden::handle_link_game` | 8859 | Generate a solvable 8x14 board on START; validate DELETE with the two-turn path rule; BOMB and RESET decrement counters; CLOSE settles |
| `casino::minigames::handle_five_card`, `casino::minigames::handle_memory_card` | 5443, 5444 | owned by [../casino/minigames.md](../casino/minigames.md) |
| `seasonal_events::air_garden::on_game_settled` | callback from the three games | by `context`: air garden pays crystals (`air_garden_game_score_to_crystal`); Carnival calls `seasonal_events::carnival::on_game_finished` (items when score >= Target, pushes 4304) |

- One open session per player. Sessions started by Carnival op 9 carry `context = 'carnival'`.
- The link game protocol (`linkgame`) is shared with the maze feature's link game ([../mazes/README.md](../mazes/README.md)); the air garden manager and the maze manager both listen to 4736, so a session must exist in only one context at a time.
- No battle.

---

## 9. Open questions and assumptions

- *(assumption)* Garden campaign entry uses the campaign scene protocol; no explicit "enter" response is visible in `AirGardenManager`.
- *(assumption)* Five card scoring table and memory card score values are server data not present in the client.
- *(assumption)* 5442 param1 7 is not used by this client.
- The garden is disabled (`AIR_GARDEN = false`); only implement it if the switch is turned on.

---

## 10. Implementation checklist

**Screens:**
- [ ] Link game, memory game, five card frames (from 381)
- [ ] Garden frames (party create, party list, HUD, show frame, bed shop) only if enabled

**Routes:**
- [ ] 8859 ops 1..5 (air garden link game)
- [ ] 5443 / 5444 via casino, with the context callback
- [ ] 5442 params 1, 2, 3, 4, 5, 6, 8, 9 (garden)

**Server messages:**
- [ ] 381 game open
- [ ] 4736, 194, 195, 192, 193
- [ ] 376, 377, 378, 379, 380 (garden)

**Tables:**
- [ ] `link_game_sessions` (+ context for `casino.minigame_session`)
- [ ] `air_gardens`, `air_garden_beds`, `air_garden_visitors` (garden)

**Rules:**
- [ ] Board generation and path validation
- [ ] Poker hand ranking
- [ ] Context callbacks (carnival, star area, snowy mist)

**Tests:**
- [ ] DELETE with non matching or blocked tiles refused
- [ ] Memory AUTO with 0 chances refused
- [ ] Second START while a session is open closes or rejects the old one
