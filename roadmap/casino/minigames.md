# Minigame protocol (package `minigame`): Jogo de 5 Cartas, Jogo da memória, gem maze messages

Path aliases:

| Alias | File |
|---|---|
| AFM | `decompiled/core_module/scripts/managers/AirGardenFivecardManager.as` |
| AMM | `decompiled/core_module/scripts/managers/AirGardenMemoryCardManager.as` |
| AGM | `decompiled/core_module/scripts/managers/AirGardenManager.as` |
| AFF | `decompiled/m3/scripts/map/campaign/view/ui/airgarden/game/fivecard/AirGardenGameFivecardFrame.as` |
| AMF | `decompiled/m3/scripts/map/campaign/view/ui/airgarden/game/memorycard/AirGardenGameMemoryCardFrame.as` |
| AMI | `decompiled/m3/scripts/map/campaign/view/ui/airgarden/game/memorycard/AirGardenGameMemoryCardItem.as` |
| MGM | `decompiled/core_module/scripts/managers/MonopolyGemMazeManager.as` |
| GMM | `decompiled/core_module/scripts/yishi/manager/GemMazeManager.as` |
| MP | `decompiled/core_module/scripts/com/road/yishi/proto/minigame/` |

## 1. Overview

Protobuf package `minigame` (assigned to this feature) carries three minigames:

| Game | Where it is played | UI owner | This file covers |
|---|---|---|---|
| "Jogo de 5 Cartas" (five card poker) | air garden ("Jardim Suspenso") campaign game nodes | [../seasonal-events/README.md](../seasonal-events/README.md) (`airgarden`) | full protocol and rules (5443, 192, 193) |
| "Jogo da memória" (air garden memory card) | air garden | seasonal-events | full protocol and rules (5444, 194, 195) |
| Gem maze ("Pontos do objetivo") | standalone gem maze ([../mazes/README.md](../mazes/README.md), opcodes 9508..9517 and 4922..4930) and the cloud adventure node ([cloud-adventure.md](cloud-adventure.md), opcodes 8961, 8878, 8879, 4760, 4761, 4864) | mazes, casino | message definitions only |

The air garden game is opened by the server with 381 `U_C_AIR_GARDEN_GAME_OPEN` (`player.CommonMsg` `param1`: 1 link game, 2 memory card, 3 five card) (AGM:62, 239-261); the request that leads there is 5442 (air garden, seasonal-events). Results convert game points into "Cristais da diversão" (`air_garden_game_score_to_crystal = 10,1`): "Você obteve {0}pontos no jogo que foram trocados por {1} Cristais da diversão" (`AirGardenGame.hint3`). Leaving early: "Caso saia do jogo os resultados serão calculados na hora, deseja sair?".

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `AirGardenGameFivecardFrame` (AFF) | "Jogo de 5 Cartas" | 5 cards, hold toggles, next / show, score, round "x/5"; rule "Quando a fase começa você pode selecionar qualquer carta para guardar e trocar as demais. Você ganha pontos pelos objetivos alcançados e segue para a próxima rodada, num total de 5." | 381 `param1 3` | 192 |
| `AirGardenGameMemoryCardFrame` (AMF) | "Jogo da memória" | Card grid, "Auto-virar cartas" (auto flip) and "Revelações de cartas" (reveal) with remaining chances, timer `duration`, score | 381 `param1 2` | 194 |

## 3. Routes (client to server)

### Five card poker: C>S 5443 (0x1543) `C_FIVE_CARD_POKER_OP`, body `minigame.FiveCardPokerMsg`

| # | op | Action | UI | Fields | Expected reply |
|---|---|---|---|---|---|
| R1 | 1 | Start | AFF build (AFF:281) | `op` | 192 (cards) |
| R2 | 2 | Next round | next button (AFF:178) | `op` | 192 |
| R3 | 3 | Show (discard non held, score) | show button (AFF:211) | `op`, `holdList` (#6, INT32 repeated) indexes kept | 192 `op 3` with new cards and `addScore` |
| R4 | 4 | Close and settle | exit (AFF:325) | `op` | 193 |

Constants: `OP_START 1`, `OP_NEXT 2`, `OP_SHOW 3`, `OP_CLOSE 4`, `MAX_PLAY_TIME 5` rounds (AFM:18-26). Senders AFM:110-141.

### Memory card: C>S 5444 (0x1544) `C_MEMORY_CARD_OP`, body `minigame.MemoryCardMsg`

| # | op | Action | UI | Fields | Expected reply |
|---|---|---|---|---|---|
| R5 | 1 | Start | AMF build (AMF:360) | `op` | 194 with `cards`, `duration`, chances |
| R6 | 2 | Flip a pair | second card click (AMI:140) | `op`, `cIndex1` (#6), `cIndex2` (#7) | 194 `op 2` (`result`, `addScore`) |
| R7 | 3 | Auto flip | button (AMF:243), needs `leftAutoChance` | `op` | 194 `op 3` |
| R8 | 4 | Reveal all briefly | button (AMF:248), needs `leftCheckChance`; "Primeiro vire um par de cartas  para prosseguir" | `op` | 194 `op 4` with `cards` |
| R9 | 5 | Close and settle | exit (AMF:407) | `op` | 195 |

Constants `OP_START 1`, `OP_FLIP 2`, `OP_AUTO 3`, `OP_SHOW 4`, `OP_CLOSE 5` (AMM:22-30). Senders AMM:166-206.

### Gem maze (definitions)

- `GemMoveMsg`: `beginMark` (#1, INT32), `endMark` (#2, INT32) swap two gems (cloud adventure 8879 via MGM:102-112; standalone 9509 via GMM:103).
- `GemMazeBuyTimesMsg`: `buyTypes` (#1, INT32) (8878 via MGM:114-120, default 2; standalone 9516).
- `GemMoveInviteMsg`: `playerIdInvited` (#1, INT32) (standalone 9510). `GemInviteOpMsg`: `playerId` (#1), `opCode` (#2) (standalone 9515). `GetRewardBoxMsg`: `boxId` (#1) (standalone 9513).
- Info request has no body (8961 MGM:92-100; standalone 9508).

## 4. Server messages (server to client)

### S1. 192 (0x00c0) `U_C_FIVE_CARD_POKER_INFO`
- `minigame.FiveCardPokerMsg`: `op` (#1, INT32) echo; `curTurn` (#2, INT32) round 1..5; `score` (#3, INT32) total; `addScore` (#4, INT32) points of this show; `pokers` (#5, `FiveCardPoker` repeated: `index` (#1, INT32) slot, `color` (#2, INT32) suit, `number` (#3, INT32) rank); `holdList` (#6, INT32 repeated).
- Receiver `AirGardenFivecardManager.infoHandler` (AFM:58-92): `op 3` -> `SHOW_FIVE_CARD`, else `INIT_FIVE_CARD`; `addScore != 0` -> `FIVE_CARD_ADD_SCORE`.
- Hand results (strings `AirGardenGame.fivecard.result1..9`): Straight Flush, Quadra, Full House, Flush, Straight, Trinca, 2 pares, "Par maior de 7" (pair above 7), Outro.

### S2. 193 (0x00c1) `U_C_FIVE_CARD_SCORE_REWARD`
- `FiveCardPokerRewardMsg`: `templateId` (#1, INT32) crystal item; `count` (#2, INT32); `score` (#3, INT32). Receiver `scoreAwardHandler` (AFM:99-108): "Você obteve {0}pontos no jogo que foram trocados por {1} Cristais da diversão".

### S3. 194 (0x00c2) `U_C_MEMORY_CARD_INFO`
- `minigame.MemoryCardMsg`: `op` (#1); `curTurn` (#2); `score` (#3); `addScore` (#4); `addScore2` (#5) combo bonus (assumption); `cIndex1` (#6); `cIndex2` (#7); `result` (#8, BOOL) pair matched; `leftAutoChance` (#9); `leftCheckChance` (#10); `duration` (#11) seconds (only the first value is kept); `cards` (#12, `MemoryCard` repeated: `index` (#1), `type` (#2) face). All INT32 except `result`.
- Receiver `AirGardenMemoryCardManager.infoHandler` (AMM:62-148): `op 2` flip, `op 3` auto, `op 4` show (`cardShow`), otherwise a new board after 2 s when one already existed.

### S4. 195 (0x00c3) `U_C_MEMORY_CARD_REWARD`
- `MemoryCardRewardMsg`: `templateId` (#1), `count` (#2), `score` (#3). Same popup as S2 (AMM:155-164).

### S5. Gem maze pushes (definitions)
- `GemMazeInfoMsg` (cloud adventure 4760 and standalone 4922): `allGems` (#1, `GemInfoMsg` repeated: `mark` (#1) cell, `color` (#2)); `score` (#2); `weekScore` (#3); `timesLeft` (#4) moves; `buyTimesLeft` (#5); `helpTimesLeft` (#6); `gemLevel` (#7); `curExp` (#8); `maxExp` (#9); `boxMark` (#10); `scoreOrder` (#11); `boxesId` (#12, INT32 repeated); `dropItemList` (#13, `DropItemInfoMsg` repeated: `score` (#1), `itemTempId` (#2), `count` (#3)).
- `GemInfoUpdateMsg` (4761, 4923): `gemDel` (#1, repeated), `gemAdd` (#2, repeated), `score` (#4, INT32 repeated) per cascade, `curExp` (#5), `maxExp` (#6), `gemLevel` (#7), `scoreOrder` (#8), `rewardInfo` (#9, `RewardInfoMsg` repeated: `rewardId` (#1)).
- 4864 (cloud adventure) and 4927 (standalone) buy replies: no body read; the client adds 10 moves (MGM:85-90; GMM:178-184 also subtracts 10 from `buyTimesLeft`). `GemMazeBuyTimesRspMsg` (`moveTimesLeft` (#1), `buyTimes` (#2)) and `GemMazeOpRstMsg` (`rstCode` (#1)) are defined but unused.
- Standalone only (mazes): 4924 `GemInviteOpMsg` (`playerId` (#1), `opCode` (#2)) invite result (GMM:131-138); 4925 `GemMoveInviteReqMsg` (`friendId` (#1), `inviteTimes` (#2), `helpNums` (#3)) invite notice (GMM:140-150); 4928 `GetRewardBoxRspMsg` (`boxGetMark` (#1), `rewardInfo` (#2, repeated)) (GMM:194-210); 4930 `GemMazeHelpBoardStatus` (`HelpBoardStatus` (#1)) (GMM:212-218).

## 5. Rules and formulas

- B1. Five card poker: 5 rounds (`MAX_PLAY_TIME`); each round deals 5 cards, the player holds any subset, the rest are replaced on show, the hand is scored by category (S1 list, points per category are server data); total score converts to crystals at `air_garden_game_score_to_crystal = 10,1` (10 points = 1 crystal).
- B2. Memory card: timed board (`duration`), pairs give `addScore`; auto flip and reveal limited by chances; settle on close or timeout; same conversion.
- B3. Gem maze: swap adjacent gems, cascades score, levels raise with exp, moves purchasable (cloud adventure: +10 per purchase).

## 6. Templates

| File | Record | Fields |
|---|---|---|
| `raw/xml/tempinfos/ConfigInfos.xml` | `air_garden_game_score_to_crystal` | 10,1 |
| `raw/xml/tempinfos/AirGardenNodeTemplates.xml` | air garden nodes (seasonal-events) | game node types |

## 7. Persistent state

```sql
CREATE TABLE casino.minigame_session (
  player_id    BIGINT     PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
  game         SMALLINT    NOT NULL CHECK (game IN (2, 3)),
  turn         SMALLINT    NOT NULL DEFAULT 1,
  score        INTEGER     NOT NULL DEFAULT 0,
  state        JSONB       NOT NULL,
  started_at   TIMESTAMPTZ NOT NULL DEFAULT now(),
  expires_at   TIMESTAMPTZ
);
```

`game` 2 memory card, 3 five card (381 codes). Gem maze state belongs to mazes and cloud adventure.

## 8. Backend implementation notes

- `casino::minigames::handle_five_card` (5443): op 1 deal (create session), op 2 next round (deal), op 3 show (validate `holdList` indexes 0..4, replace others, score, reply 192 `op 3`), op 4 settle (crystals = score / 10, grant, reply 193, delete session, return to the air garden node).
- `casino::minigames::handle_memory_card` (5444): op 1 create a shuffled board, op 2 compare `cIndex1`/`cIndex2` (distinct, unopened), op 3 auto flip a matching pair (chance), op 4 send all faces (chance), op 5 settle with 195. Timeout job settles automatically.
- The air garden node handler (seasonal-events) sends 381 to start the game.

## 9. Open questions and assumptions

- Assumption: points per poker hand category and per memory pair are server data.
- Assumption: `addScore2` is a combo bonus.

## 10. Implementation checklist

- [ ] Five card poker routes 5443 ops 1..4, messages 192, 193
- [ ] Memory card routes 5444 ops 1..5, messages 194, 195
- [ ] Table `minigame_session`
- [ ] Coordinate gem maze message definitions with mazes and cloud adventure
- [ ] Test: hold list with index 5 refused; flip of the same index twice refused
