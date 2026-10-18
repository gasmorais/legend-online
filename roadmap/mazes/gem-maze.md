# Gem maze ("Saqueador Soldado")

Feature `mazes`, module `gem-maze`. Client: `M11/gemmaze/GemMazeFrame.as`, `M11/gemmaze/view/*` (14 classes), `CM/yishi/manager/GemMazeManager.as`, `CM/mvc/module/gemmaze/*`, `CM/mvc/controler/GemMazeControler.as`, `CM/cell/view/gemmazebag/GemMazeBagCell.as`, `CM/events/GemMazeEvent.as`. Proto package `minigame` (registered to the casino feature). Conventions: see [README.md](README.md).

---

## 1. Overview

- A match-3 minigame launched from the game box (game id 2). The board has 9 columns (`mark` index 0-based, row = `mark / 9`); each gem has a colour. The player swaps two adjacent gems; the server resolves the matches, returns removed and added gems, the score of each combo, the experience and the gem level, and drops reward items into a private "maze bag" (bag type 24, 48 slots).
- Moves: 20 free per day (help item 1) plus bought moves (10 per purchase for 50 diamonds, 50 moves of daily purchases). The counter `timesLeft` is decremented by the client before the answer.
- Five score boxes ("Prêmios"): each opens at a score threshold (`dropItemList` score keys) and is claimed once (`boxMark` bitmask).
- A player can invite one friend per day to help ("Convide algum amigo aleatório para lhe ajudar a eliminar gemas."). The friend receives a slot machine pop-up ("Estrela da Sorte") rolling the number of gems he will remove; accepting applies them to the inviter's board.
- Weekly score ranking from a static XML.

---

## 2. Screens

| Class (file) | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `gemmaze.GemMazeFrame` (`M11/gemmaze/GemMazeFrame.as`), controller `gemmaze` frameType 1 (`CM/mvc/controler/GemMazeControler.as:40-70`) | "Saqueador Soldado" (`gemMaze.GemMazeFrame.title`) | Board, counters, boxes, bag | Game box game 2 (`CM/managers/GameBoxManager.as:174-177`) | Moves left (`:273-278`), level and exp ("Max." at max, `:290-296`), score and rank, buttons invite (`:302-305`), buy moves (`:307-362`), ranking link (`:380-384`), exit confirm "Deseja sair do Saqueador Soldado?" (`:610-625`, clears listeners `:519`) |
| `gemmaze.view.GemMazeView` (`M11/gemmaze/view/GemMazeView.as`) | none | Board | Frame | Gems from `gemArr` at `x = 20 + 65 x (mark % 9)`, `y = 15 + 63 x (mark / 9)` (`:545-555`); click selection, adjacency (`:390-500`); animation of the queued updates (`:150-210`) |
| `GemMazeBoxView`, `GemMazeIntergalBoxView`, `GemMazePrizeView` (`M11/gemmaze/view/*`) | "Prêmios" | Score boxes | Frame | 5 boxes, icon `boxesId[i]`, threshold `scoreArr[i]`, items `dropDict[score]` ("Abre para obter:"), state from `boxMarkArr` (`GemMazeBoxView.as:230-320`); claim button (`GemMazePrizeView.as:86-93`); "+{n} Pontos" float (`:172`) |
| `GemMazeBagView`, `GemMazeBagGridView`, `GemMazeBagCell` | "Caixa do Tesouro" | Private reward bag | Frame | Items of bag type 24 (`GoodsManager.getMazeBagList`, `CM/yishi/manager/GoodsManager.as:2002-2012`); "Coletar tudo" and "Arrumar" (`GemMazeBagView.as:60-100`) |
| `GemMazeInvideFrame` (`M11/gemmaze/view/GemMazeInvideFrame.as`) | invite | Pick a friend | Invite button | Friend list combo box; "Convide algum amigo..." |
| `GemMazeInvideMaskFrame` | none | Waiting mask while the friend answers | 4930 | |
| `GemMazeInvideByFriendFrame` (`M11/gemmaze/view/GemMazeInvideByFriendFrame.as`), controller frameType 2 | "Estrela da Sorte" | Help request received | 4925 | "Saqueadores Soldados {0} do seu Amigo precisam da sua ajuda", "Número de auxílios restantes: {inviteTimes}", slot roll of `helpNums` (tens and units, `:160-170`), countdown (1 s ticks, `:99-120`) |
| `GemMazeSortFrame`, `GemMazeSortView`, `GemMazeSortItemView` | "Lista de Ranking do Saqueador Soldado" | Ranking | Ranking link after `gemmaze.xml` loads | Rank, name, level, score, title prize |

---

## 3. Routes (client to server)

| # | UI control | Client sender (file:line) | Client checks | Route | Request | Expected response |
|---|---|---|---|---|---|---|
| G1 | Opening the frame | `GemMazeFrame` init (`M11/gemmaze/GemMazeFrame.as:199`) → `GemMazeManager.getInitInfo` (`CM/yishi/manager/GemMazeManager.as:82-90`, registers the 4922..4930 listeners once) | none | **9508 (0x2524) C_GET_GEMMAZE_INFO** | no body | **4922** |
| G2 | Swap two adjacent gems | `GemMazeView.onReplacePosComplete` (`M11/gemmaze/view/GemMazeView.as:464-468`) → `GemMazeManager.moveGem` (`:101-111`) | `canMoveGemByUser` (false while an invitation is pending); no animation running; `timesLeft > 0` ("Já usou todas as chances..."); adjacency: same row ± 1 (no wrap at `mark % 9 == 0`) or ± 9 (`:470-500`); maze bag < 48 items ("Caixa do Tesouro cheia...") | **9509 (0x2525) C_GEMMAZE_GEMMOVE** | `minigame.GemMoveMsg`: `beginMark (#1, INT32)`, `endMark (#2, INT32)` | **4923** one or more times (cascades); bag pushes for dropped items |
| G3 | Buy moves | `GemMazeFrame.__onBuyTimesHandler` / `__showTipResult` (`:307-362`) → `GemMazeManager.buyTimes(type)` (`:170-176`) | `timesLeft < 90` ("Você já atingiu o número de vezes máximo..."); `buyTimesLeft >= steps` ("Você já atingiu o limite de comprar diárias"); `allPoint >= price` else recharge; confirmation "Deseja consumir {price} diamantes para comprar chances de pesquisar tesouro {steps} vez(es)? Nº de compras restantes de hoje: {buyTimesLeft} vez(es)" with the bound diamond option | **9516 (0x252c) C_GEMMAZE_BUYTIMES** | `minigame.GemMazeBuyTimesMsg`: `buyTypes (#1, INT32)` 1 diamonds, 2 bound diamonds first | **4927**; currency push |
| G4 | Claim a score box | `GemMazePrizeView.__pickupHandler` (`M11/gemmaze/view/GemMazePrizeView.as:86-93`) → `GemMazeManager.getBoxGoods(boxIndex)` (`:186-192`) | box reachable and not claimed (view state) | **9513 (0x2529) C_GEMMAZE_GETREWARDBOX** | `minigame.GetRewardBoxMsg`: `boxId (#1, INT32)` box index 1..5 | **4928** |
| G5 | "Coletar tudo" of the maze bag | `GemMazeBagView.__pickupHandler` (`M11/gemmaze/view/GemMazeBagView.as:78-82`) → `GemMazeManager.sendOpenInfo` (`:226-230`) | bag not empty (button state) | **9517 (0x252d) C_GEMMAZE_GETALL** | no body | Bag pushes moving every item of bag type 24 to the main bag *(assumption)* |
| G6 | Invite a friend | `GemMazeInvideFrame` confirm (`M11/gemmaze/view/GemMazeInvideFrame.as:145-175`) → `GemMazeManager.invideFriendHelp(userId)` (`:122-129`) | name typed ("friends.view.RosePresentView.inputTip"); not self *(assumption from `consortia...command02`)*; friend online ("O jogador em que pediu auxílio não está online"); in the friend list ("notFriends") | **9510 (0x2526) C_GEMMAZE_INVITE** | `minigame.GemMoveInviteMsg`: `playerIdInvited (#1, INT32)` | **4930** to the inviter (wait mask), **4925** to the friend; later **4924** to the inviter |
| G7 | Friend answers | `GemMazeInvideByFriendFrame` (`:160-170` accept = 1; `dispose` `:240-252` refuse = 2, timeout = 3); `GemMazeManager.__invideNoticeHandler` auto answers 4 when in battle, 5 when the frame is already open (`:140-159`) → `helpFriend(op)` (`:161-168`) | none | **9515 (0x252b) C_GEMMAZE_INVITE_OP** | `minigame.GemInviteOpMsg`: `playerId (#1, INT32)` inviter id; `opCode (#2, INT32)` 1 accept, 2 refuse, 3 timeout, 4 busy in battle, 5 already helping | **4924** to the inviter; on accept **4923** with the friend's removals to the inviter *(assumption)* and the helper reward to the friend |
| G8 | Ranking link | `GemMazeControler.loadGemMazeOrderData` (`CM/mvc/controler/GemMazeControler.as:76-80, 119-140`) | none | HTTP GET `{TPL}gemmaze.xml` (`PathManager.getGemMazeOrderPath`, `CM/yishi/manager/PathManager.as:722-725`) | | `<GemMazeScore UserId Job NickName Score ConsortiaName Grades GemMazeGrades Order Index FightingCapacity IsVip VipType/>` |

---

## 4. Server messages (server to client)

| Opcode | Name | Message, fields (tag, type) | Client receiver (file:line) | When | Client reaction |
|---|---|---|---|---|---|
| **4922 (0x133a)** | U_C_GEMMAZE_INFO | `minigame.GemMazeInfoMsg`: `allGems (#1, GemInfoMsg, repeated)` full board; `score (#2, INT32)` current score; `weekScore (#3, INT32)`; `timesLeft (#4, INT32)` moves left; `buyTimesLeft (#5, INT32)` moves still purchasable today; `helpTimesLeft (#6, INT32)` invitations left today; `gemLevel (#7, INT32)`; `curExp (#8, INT32)`; `maxExp (#9, INT32)`; `boxMark (#10, INT32)` claimed boxes bitmask (bit 0 = box 1); `scoreOrder (#11, INT32)` rank; `boxesId (#12, INT32, repeated)` icon item template per box; `dropItemList (#13, DropItemInfoMsg, repeated)` box contents. `GemInfoMsg`: `mark (#1, INT32)` cell 0-based, `color (#2, INT32)` gem type. `DropItemInfoMsg`: `score (#1, INT32)` box threshold, `itemTempId (#2, INT32)`, `count (#3, INT32)` | `GemMazeManager.__gemMazeInfoBuffHandler` (`CM/yishi/manager/GemMazeManager.as:92-99`) → `GemMazeModel.updateGemMazeInfo` (`CM/mvc/module/gemmaze/GemMazeModel.as`) | Response to 9508 | Rebuilds the board, counters, boxes (thresholds sorted ascending), `GEMMAZE_GET_INIT_INFO` |
| **4923 (0x133b)** | U_C_GEMMAZE_UPDATE | `minigame.GemInfoUpdateMsg`: `gemDel (#1, GemInfoMsg, repeated)` removed gems; `gemAdd (#2, GemInfoMsg, repeated)` new gems; `score (#4, INT32, repeated)` score of each removal step (summed into the total); `curExp (#5, INT32)`; `maxExp (#6, INT32)`; `gemLevel (#7, INT32)`; `scoreOrder (#8, INT32)` not read; `rewardInfo (#9, RewardInfoMsg, repeated)` dropped items (`minigame.RewardInfoMsg.rewardId (#1, INT32)` item template id) | `__gemInfoUpdateHandler` (`:113-120`) → `updateGemUpdateInfo` (queue `gemUpdateArr`) | After G2 (and after a friend's help), one message per cascade step | Animated in order; score added; items shown flying into the bag |
| **4927 (0x133f)** | U_GEMMAZE_BUYTIMES_RSP | `minigame.GemMazeBuyTimesRspMsg`: `moveTimesLeft (#1, INT32)`, `buyTimes (#2, INT32)`; the client ignores the body | `__onBuyTimesHandler` (`:178-184`) | Success of G3 only *(assumption: no message on failure)* | `timesLeft += 10`, `buyTimesLeft -= 10` (hard-coded 10) |
| **4928 (0x1340)** | U_GEMMAZE_GETBOX_RSP | `minigame.GetRewardBoxRspMsg`: `boxGetMark (#1, INT32)` new bitmask; `rewardInfo (#2, RewardInfoMsg, repeated)` item ids granted | `__onGetBoxGoodsHandler` (`:194-210`) | Response to G4 | Updates `boxMark`, shows the items, refreshes boxes |
| **4930 (0x1342)** | U_GEMMAZE_HELPBOARD_STATUS | `minigame.GemMazeHelpBoardStatus`: `HelpBoardStatus (#1, INT32)` not read | `__onInvideBackHandler` (`:212-218`) | To the inviter after G6 | Opens the waiting mask |
| **4924 (0x133c)** | U_GEMMAZE_OPRST | Named `GemMazeOpRstMsg {rstCode (#1, INT32)}` in the proto package, but the client parses it as `GemInviteOpMsg {playerId (#1), opCode (#2)}` and reads nothing | `__invideResultHandler` (`:131-138`) | To the inviter when the friend answered or the invitation ended | `canMoveGemByUser = true`, closes the mask |
| **4925 (0x133d)** | U_GEMMAZE_INVIDE_NOTICE | `minigame.GemMoveInviteReqMsg`: `friendId (#1, INT32)` inviter; `inviteTimes (#2, INT32)` helps left for the receiver; `helpNums (#3, INT32)` gems the helper will remove (two digits) | `GemMazeManager.__invideNoticeHandler` (`:70, 140-159`, registered at login by `setup`, `CM/yishi/lunch/Yishi.as:415`) | To the invited friend | Opens "Estrela da Sorte" or answers 4/5 automatically |

---

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Free moves | 20 per day | `gemMaze.GemMazeFrame.helpFrame.helpContent` item 1 |
| Purchase | `Gem_Maze_BuyInfo` = "10,50,50": 10 moves per purchase, 50 diamonds, daily purchase limit 50 (client compares `buyTimesLeft` in moves) | `ConfigInfos.xml`; `GemMazeFrame.as:307-336` |
| Move cap | Purchase refused when `timesLeft >= 90` | `:309-313` |
| Daily reset | Moves (free and bought) expire at day change; points and counters reset (help items 5, 6) | help |
| Help | One invitation per day (help item 4); helper reward `GemMazeHelp_Reward` = "-4000,3" *(assumption: currency -4000 x3 to the helper)* | `ConfigInfos.xml` |
| Bag | 48 slots, bag type 24; moves refused when full | `GemMazeView.as:432-439` |
| Rewards | Larger single removals give better rewards; higher gem level gives more rewards (help items 2, 3) *(formulas unknown, server)* | help |
| Score boxes | 5 boxes, thresholds = sorted distinct `DropItemInfoMsg.score`, contents per threshold; claimed flag bit i | `GemMazeModel.updateGemMazeInfo`, `GemMazeInfoVO.boxMark` (`CM/mvc/module/gemmaze/info/GemMazeInfoVO.as:57-73`) |
| Board | 9 columns *(assumption: 9 rows, 81 cells)*, colours from the server | `GemMazeView.as:545-555` |

---

## 6. Templates

No client template. Configuration keys `Gem_Maze_BuyInfo`, `GemMazeHelp_Reward` in `raw/xml/tempinfos/ConfigInfos.xml`. Reward pools, colour count, scoring and level curve are server data *(gap)*.

---

## 7. Persistent state (PostgreSQL, schema `mazes`)

```sql
CREATE TABLE mazes.gem_maze_state (
  player_id        integer  PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
  board            smallint[] NOT NULL,              -- colour per cell, index = mark
  score            integer  NOT NULL DEFAULT 0,
  week_score       integer  NOT NULL DEFAULT 0,
  week_start       date     NOT NULL,
  gem_level        smallint NOT NULL DEFAULT 1,
  cur_exp          integer  NOT NULL DEFAULT 0,
  day              date     NOT NULL,
  free_moves_left  smallint NOT NULL DEFAULT 20,
  bought_moves_left smallint NOT NULL DEFAULT 0,
  buyable_moves_left smallint NOT NULL DEFAULT 50,
  help_invites_left smallint NOT NULL DEFAULT 1,
  helps_given_today smallint NOT NULL DEFAULT 0,
  box_mark         smallint NOT NULL DEFAULT 0 CHECK (box_mark BETWEEN 0 AND 31),
  updated_at       timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE mazes.gem_maze_invites (
  invite_id     bigserial   PRIMARY KEY,
  inviter_id    integer     NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  helper_id     integer     NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  help_nums     smallint    NOT NULL,
  status        smallint    NOT NULL DEFAULT 0 CHECK (status BETWEEN 0 AND 5),  -- 0 pending, else opCode
  created_at    timestamptz NOT NULL DEFAULT now(),
  answered_at   timestamptz
);
CREATE INDEX gem_maze_invites_pending ON mazes.gem_maze_invites (inviter_id) WHERE status = 0;
```

The maze bag items live in the inventory tables with bag type 24.

---

## 8. Backend implementation notes

| Handler | Route | Validation order | Transaction and pushes |
|---|---|---|---|
| `mazes::gem_maze::handle_info` | 9508 | none | Daily and weekly resets, generate a board without initial matches. Send 4922 |
| `mazes::gem_maze::handle_move` | 9509 | no pending invitation; moves left > 0; cells adjacent and on the board; bag < 48 | Consume one move (free first *(assumption)*); swap; if no match, swap back and send one 4923 with no removals *(assumption)*; else loop: remove matches, score, exp, roll drops into bag 24, gravity and refill, send 4923 per step. One tx for state and bag |
| `mazes::gem_maze::handle_buy_moves` | 9516 | `moves_left < 90`; `buyable_moves_left >= 10`; diamonds 50 (bound first when `buyTypes = 2`) | Debit, `bought_moves_left += 10`, `buyable_moves_left -= 10`. Send 4927, currency push |
| `mazes::gem_maze::handle_claim_box` | 9513 | box 1..5; `score >= threshold`; bit not set; bag space | Grant items, set bit. Send 4928 |
| `mazes::gem_maze::handle_collect_bag` | 9517 | main bag space | Move items of bag type 24 to the main bag; bag pushes |
| `mazes::gem_maze::handle_invite` | 9510 | invites left; target is a friend and online; no pending invitation | Insert invite with `help_nums` rolled *(assumption: 1..99)*. Send 4930 to the inviter, 4925 to the friend (`inviteTimes` = his helps left) |
| `mazes::gem_maze::handle_invite_answer` | 9515 | pending invite between the two | Record opCode. On 1: apply `help_nums` removals to the inviter's board (4923 to the inviter if online), grant the helper reward. Send 4924 to the inviter. Timeout job answers 3 after the countdown |
| Ranking job | | | Writes `gemmaze.xml` by `week_score` *(assumption: weekly)* |

---

## 9. Open questions and assumptions

- *(gap)* Scoring, levels, drop pools and colour count are server data.
- *(assumption)* Board size 9x9; behaviour of a swap without match.
- *(assumption)* Meaning of `GemMazeHelp_Reward`, `helpNums` range and the invitation timeout.
- 4924 body type mismatch (opcode name vs client parse); any body works because the client reads no field.

---

## 10. Implementation checklist

- [ ] Tables `mazes.gem_maze_state`, `mazes.gem_maze_invites`; inventory bag type 24.
- [ ] Board engine (swap, match, cascade, refill) with deterministic tests.
- [ ] Routes 9508, 9509, 9516, 9513, 9517, 9510, 9515 and pushes 4922..4930.
- [ ] Daily and weekly resets; ranking file `gemmaze.xml`.
- [ ] Game box integration (game 2) in the time-story feature.
- [ ] Test: non adjacent swap refused; move with 0 moves refused.
- [ ] Test: buying at 90 moves refused; buying 6 times in a day when 50 moves are purchasable refused on the sixth.
