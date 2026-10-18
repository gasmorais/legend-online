# Colosseum ("Coliseu", "Desafio individual")

Module `arena::colosseum`. Prefixes as in [README.md](README.md).

## 1. Overview

An asynchronous rank ladder. The server sends the player's rank, the 4 challengeable players around it (rank 0 = new player shown first as "Iniciante"), up to 10 battle logs and a notice. Clicking a rival starts battle 16 `BATTLE_CHALLENGE` (auto battle against the rival's snapshot). A win swaps ranks. Each player has free challenges per day, then paid ones (2, 4, 6, 8, 10 diamonds, capped at 10). After every challenge a cooldown queue runs (`Challenge_Cool` = 1 diamond per minute to speed up, free for VIP with `vipCoolPrivilege`). Every few days (`leftDay`) the server pays a rank reward of gold and spirits and shows a dialog.

Two UIs show the same data: the castle "Coliseu" frame (controller `colosseum`) and the colosseum scene `CHANLLENGE_ROOM_SCENE` (from the "Salão da Arena" single tab).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `colosseum.ColosseumFrame` | Coliseu | 4 `ColosseumPlayerItem` rivals, self view, cooldown bar with speed up button (tip "Acelerar resfriamento(VIP Gratuito)") | castle building -> controller `colosseum` (`M4/castle/CastleSceneView.as:117`; `CM/mvc/controler/ColosseumControler.as:43-70`) | 4169 (`M13/colosseum/ColosseumFrame.as:63-246`) |
| scene `colosseum.ChallengeSceneControl` (`CHANLLENGE_ROOM_SCENE`) with `ChallengeView` | | full screen version: top (rank, reward days, rank/event buttons), left, middle (4 `ChallengeMiddleItem`), remaining free/buy counts, cooldown, return | `PvPSingleView.__startSingleHandler` (`M9/pvp/view/PvPSingleView.as:90-96`); on enter `ChallengeManager.initModel` sends 8256 (`M13/colosseum/ChallengeSceneControl.as:54-64`) | 4169 (`M13/colosseum/view/ChallengeView.as:72-350`) |
| `colosseum.view.ColosseumSelfView` / `ChallengeTopView` | | own rank, "Após {0} dias" until reward, buttons ranking and events | frame / scene | `currentRank`, `leftDay` (`M13/colosseum/view/ColosseumSelfView.as:243-270`; `M13/colosseum/view/ChallengeTopView.as:100-131`) |
| `colosseum.view.HeroRankFrame` | Ranking de Heróis | server top list ("Ranking", "Apelido") | rank button | HTTP file `{TEMPLATE_PATH}challengeorder.xml` (`M13/colosseum/view/HeroRankFrame.as:55-130`; `CM/yishi/manager/PathManager.as:493-496`) |
| `colosseum.view.ColosseumEventFrame` | Relatório de Batalhas | last 10 logs ("Você desafiou X, você foi vitorioso, ranking aumentou para N", "Muito tempo atrás".."A pouco") | event button | `eventsList` (`M13/colosseum/view/ColosseumEventFrame.as`; `M13/colosseum/view/ColosseumEventItem.as`) |

## 3. Routes (client to server)

| # | Action | UI control | Client sender | Client checks | Request | Responses |
|---|---|---|---|---|---|---|
| C1 | Load colosseum | frame creation; scene enter | `ColosseumControler.requestData` (`CM/mvc/controler/ColosseumControler.as:82-88`), `ChallengeManager.requestData` (`CM/managers/ChallengeManager.as:66-72`) | none | C to S 8256 (0x2040) `C_CHALLENGEINFO_REQUEST`, `pet.ChallengeRequestMsg` `type` (#1, INT32) = 0 (pet arena uses another type, [../einherjar/challenge-arena.md](../einherjar/challenge-arena.md)) | 4169 |
| C2 | Challenge a rival | rival avatar | `ChallengeMiddleItem.__avatarClickHandler` -> `sendChallenge` (`M13/colosseum/view/ChallengeMiddleItem.as:118-180`); frame: `ColosseumPlayerItem` (`M13/colosseum/view/ColosseumPlayerItem.as:125-183`) -> `sendChallengeById` (`ChallengeManager.as:229-242`; `ColosseumControler.as:287-300`) | idle cooldown order (`checkHasIdleColosseumOrder`) else "Fila de desafio em resfriamento"; not in a PvP room ("Você está dentro de uma sala, não é possível realizar essa ação"); not on a campaign map; free count > 0, else buy count > 0 with confirmation "Para desafiar uma vez é necessário consumir {0} diamantes" (bind diamonds allowed) else "Número de desafios de hoje esgotados"; diamonds check -> recharge; 5 s throttle | C to S 8253 (0x203D) `C_CHALLENGE`, `player.ChallengeMsg`: `tarUserId` (#1, INT32, rival), `tarArmyId` (#2, unused), `payType` (#3, INT32: 0 = may use bind diamonds, 1 = diamonds only), `type` (#4, unused), `uuid` (#5, unused) | battle start (type 16, auto); after the battle 4169 refresh and 4176 cooldown |
| C3 | Speed up cooldown | cooldown button | `ChallengeView.__clickHandler` / `ColosseumFrame.__clickHandler` -> `coolColosseBack` -> `SocketSendManager.sendCoolColosseun(orderId, useBind)` (`M13/colosseum/view/ChallengeView.as:153-188`; `CM/yishi/service/managers/SocketSendManager.as:400-412`) | VIP privilege: free and immediate; else cost `ceil(remainTime / (60 * 1)) * 1` diamonds confirmation | C to S 8265 (0x2049) `C_QUICKCOOL_CHALLENGE_TIME`, `player.PayTypeMsg`: `payType` (#1: 2 = may use bind diamonds, 1 = diamonds), `property1` (#2), `property2` (#3), `type` (#4) | 4176 with `leftTime 0` |
| C4 | VIP auto clear | VIP state change | `ChallengeView.__UpvipInfoHandler` (`:243-249`) | VIP active | 8265 `{payType:2}` | 4176 |
| C5 | Return | scene return button | `ChallengeView.__returnClick` (`:291-302`) | | none (scene change) | |
| C6 | Hero ranking | rank button | `HeroRankFrame.getRankList` | | HTTP GET `{TEMPLATE_PATH}challengeorder.xml?rnd=` | XML `item` rows: `userId`, `nickName`, `grades`, `fightingCapacity`, `consortiaName`, `order`, `job`, `curRank`, `IsVip`, children `DragonInfo` (`Type`, `Grade`, `Gp`), `TransferInfo` (`Grade`, `Gp`) |

## 4. Server messages (server to client)

### 4169 (0x1049) `U_C_CHALLENGE_INFO`, `simple.ChallengeInfoMsg`

Receivers `ChallengeManager.__initDataHandler` (`CM/managers/ChallengeManager.as:76-227`) and `ColosseumControler.__initDataHandler` (`CM/mvc/controler/ColosseumControler.as:92,100-245`).

| Field | Tag | Type | Meaning |
|---|---|---|---|
| `lastWinCount` | 1 | INT32 | consecutive wins |
| `challengeCount` | 2 | INT32 | challenges used today |
| `curRank` | 3 | INT32 | own rank (0 = unranked) |
| `simplePlayer` | 4 | `SimplePlayerInfoMsg` repeated | rivals: `userId` #1, `nickName` #2, `sexs` #4, `pics` #5, `consortiaID` #8, `consortiaName` #10, `grades` #14, `fightingCapacity` #21, `challengeRank` #25, `job` #26, `storeGrade` #28, `isHide` (fashion hidden), `curFightPetTempId` (pet shown) (other fields unused) |
| `challengeLog` | 5 | `ChallengeLogMsg` repeated | `userId` #1, `result` #2, `tarUserId` #3, `tarNickName` #4, `isAttack` #5, `logDate` #6 ("YYYY-MM-DD hh:mm:ss"), `curRankResult` #7, `grades` #8, `gpOrder` #9, `gp` #10, `job` #11, `forward` #12 (rank movement); max 10 kept |
| `noticMsg` | 6 | STRING | notice; `<... name='x'>` tags are replaced by their `name` attribute |
| `avater` | 7 | `AvaterMsg` repeated | rival avatars: `userId` #1, `armTempId` #2, `clothTempId` #3, `fashionArmTempId` #4, `fashionClothTempId` #5, `fashionWingTempId` #6, `fashionHeadTempId` #7 (item template ids) |
| `leftDay` | 8 | INT32 | days until the next rank reward |
| `totalCount` | 9 | INT32 | free challenges per day |
| `totalBuyCount` | 10 | INT32 | purchasable challenges per day |

When: response to 8256 and after every colosseum battle (A).

### 4176 (0x1050) `U_C_CHALLENGE_TIME`, `player.ChallengeCoolTimeMsg`

Receivers `CM/yishi/lunch/LoginInitDataAccept.as:108,360-383` (login: creates the colosseum order 10000 in `BuildingManager.colosseumOrderList`), `CM/yishi/manager/QueueBarManager.as:86,500-530` (updates). Fields: `leftTime` (#1, INT32, cooldown seconds), `challengeCount` (#2), `totalCount` (#3), `type` (#4, INT32: 0 colosseum; 1 = pet arena, ignored here), `totalBuyCount` (#5). When: at login and after each challenge or speed up.

### 4243 (0x1093) `U_C_TAKECHALLENGE_RESULT` and 4244 (0x1094) `U_C_ISTAKE_CHALLENGEREWARD`, `player.ChallengeRankRewardMsg`

Fields `isTake` (#1, BOOL), `param1` (#2, rank), `param2` (#3, gold), `param3` (#4, spirits), `param4` (#5, days to the next reward). 4244 at login sets `playerInfo.isChallReward` (`LoginInitDataAccept.as:110,231-237`). 4243 when the reward is paid: dialog "Seu ranking atual {0}, obtido prêmio de ranking {1} ouro, {2} espíritos, próxima premiação: após {3} dias." (`CM/ui/toptoolbar/TopToolsBar.as:420,1729-1756`). 8329 `C_TAKE_CHALLENGEREWARD` has no client sender: the reward is paid automatically.

### Battle 16

Auto battle, no skill use, "Encerrar" strip; exit to `CHANLLENGE_ROOM_SCENE` if `ChallengeManager.isLogin` else space; reopens the colosseum frame (`isOpenColosseum`) (`docs/battle/rules.md` type 16; `CM/battle/handler/BattleResultHandler.as:330-361`). Mock rule exists in `server/flows/battle.json` (`docs/battle/server-engine.md` section 9.1).

## 5. Rules and formulas

| # | Rule | Source |
|---|---|---|
| K1 | Remaining free = max(0, `totalCount - challengeCount`); remaining paid = `totalBuyCount` while free remain, else `totalBuyCount - (challengeCount - totalCount)` | `CM/mvc/module/colosseum/ColosseumModel.as:60-78` |
| K2 | Paid challenge price = min(10, (paidUsed + 1) * 2) diamonds | `ColosseumModel.as:80-84` |
| K3 | Cooldown speed up `Challenge_Cool` = 1,1: diamonds = ceil(remainTime / (60 * 1)) * 1; free for VIP cool privilege | config; `ChallengeView.as:164-178` |
| K4 | Rank swap on win when the rival is better ranked (A: standard ladder) | logs `forward`, `curRankResult` |
| K5 | Rank reward every N days (`leftDay`), gold and spirits by rank (A: server table) | 4243 |
| K6 | Rivals list: 4 players, unranked first | `ChallengeManager.as:129-158` |

## 6. Templates

`TPL/ConfigInfos.xml` `Challenge_Cool`; HTTP `challengeorder.xml` (generated by the server, `routes/routes.md` `challengPath`).

## 7. Persistent state

```sql
CREATE TABLE arena.colosseum_rank (
  rank            integer PRIMARY KEY CHECK (rank > 0),
  player_id       BIGINT NOT NULL UNIQUE REFERENCES player.players(player_id)
);

CREATE TABLE arena.colosseum_player (
  player_id       BIGINT PRIMARY KEY REFERENCES player.players(player_id),
  win_streak      integer NOT NULL DEFAULT 0,
  used_today      smallint NOT NULL DEFAULT 0,
  counters_day    date NOT NULL,
  cooldown_until  timestamptz,
  last_reward_at  timestamptz
);

CREATE TABLE arena.colosseum_log (
  log_id          bigserial PRIMARY KEY,
  attacker_id     integer NOT NULL REFERENCES player.players(player_id),
  defender_id     integer NOT NULL REFERENCES player.players(player_id),
  attacker_won    boolean NOT NULL,
  attacker_rank_after integer,
  defender_rank_after integer,
  fought_at       timestamptz NOT NULL DEFAULT now()
);
CREATE INDEX ON arena.colosseum_log (attacker_id, fought_at DESC);
CREATE INDEX ON arena.colosseum_log (defender_id, fought_at DESC);
```

## 8. Backend implementation notes

- `arena::colosseum::handle_info` (8256 type 0): rivals = 4 ranks around own rank (A: the 4 better ranks, or bottom ranks for unranked), logs where the player is attacker or defender (max 10), counters; send 4169.
- `arena::colosseum::handle_challenge` (8253): validate rival in the offered list, cooldown idle, counts (K1) and price (K2, bind diamonds allowed when `payType 0`), not in a room; transaction for diamonds and counters; start battle 16 auto against the rival snapshot; on end: swap ranks (K4), insert log, set cooldown (A: 10 min), push 4176 and 4169; write `challengeorder.xml` periodically.
- `arena::colosseum::handle_quick_cool` (8265): VIP free, else K3 diamonds; push 4176 with 0.
- Reward job every N days: 4243 to online players, mail otherwise (A); 4244 at login.

## 9. Open questions and assumptions

- (A) Cooldown length, daily free and paid counts (sent by the server in 4169), reward table and period.

## 10. Implementation checklist

- [ ] 8256 -> 4169; 8253 with battle 16; 8265; 4176 at login and after battles; 4244 at login; 4243 reward
- [ ] `challengeorder.xml` HTTP file
- [ ] Tables `colosseum_rank`, `colosseum_player`, `colosseum_log`
- [ ] Tests: K1/K2 counts and prices, cooldown speed up cost, rank swap
