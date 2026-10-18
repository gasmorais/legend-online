# Chegada do BlackJack (blackjack, "黑杰克")

Path aliases:

| Alias | File |
|---|---|
| BJM | `decompiled/core_module/scripts/yishi/manager/BlackjackManager.as` |
| BJB | `decompiled/core_module/scripts/mvc/module/blackjack/BlackjackBoardInfo.as` |
| BJF | `decompiled/m11/scripts/blackjack/BlackjackFrame.as` |
| BJL | `decompiled/m11/scripts/blackjack/BlackjackLayer.as` |
| BJE | `decompiled/m11/scripts/blackjack/BlackjackExchangeView.as` |
| BM | `decompiled/core_module/scripts/yishi/manager/BaseManager.as` |
| TBH | `decompiled/core_module/scripts/ui/toptoolbar/TopBtnCheckShowHelper.as` |

## 1. Overview

A timed single player 21 game against the bank, paid in diamonds. The player picks a stake table (chip), draws cards ("Mais uma carta"), may replace the last card for diamonds ("mão de deus", "Consumir {0} diamantes para substituir a última carta"), then stands ("Comparar com a banca o número da carta"). Win gives the table's win items and more score, loss gives the general items and less score. Score ("Prêmios de pontos") is exchanged for a reward pack. Help (`blackjack.BlackjackFrame.helpContent`): card values 2..9 face value, 10/J/Q/K 10, A 1 or 11; over 21 loses ("Estourou"); bank busts -> player wins; otherwise closest to 21 wins; ties go to the player.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `blackjack.BlackjackFrame` (BJF), 875x620 | "Chegada do BlackJack" (`view.BlackjackFrame.titleText`) | Bank cards (5 slots), player cards (5 slots), points, buttons hit / gold card / stand, reward icons (win items first 2, then others), exchange panel, log of exchanges | Top toolbar `blackjack` (TopToolBtnInfos 2045 "黑杰克") -> `openControllerByInfo("blackjack",1)` (`TopToolsBar.as:1274-1276`) | 269 |
| `blackjack.BlackjackLayer` (BJL) | "Vinte-e-um" table choice | Three chips (`BlackjackChip`) with `cost` | BJF when no hand in progress (`playerCard` empty, BJF:216-232) | 268 tables |
| `blackjack.BlackjackExchangeView` (BJE) | "Prêmios de pontos: {0}" | Exchange pack (`reward_items`), needed score, ratio win/general score, exchange log | inside BJF | 268, 271 |

Toolbar visibility: `grades >= 6 && ConfigManager.info.BLACKJACK && BLACKJACK_BEGIN_DATE <= now < BLACKJACK_END_DATE` (TBH:283-284); these come from push 4422 `SwitchInfoListMsg` entry `switchType 3060` (BM:1577-1582), owner [../account/switches.md](../account/switches.md).

## 3. Routes (client to server)

All routes: C>S 9565 (0x255d) `C_BLACK_JACK`, body `blackjack.BlackJackReqMsg`: `op` (#1, INT32), `param1` (#2, INT32). Sender `BlackjackManager.OperateBlackjack(op, param1 = 0)` (BJM:193-200).

| # | op | Action | UI | Client checks | Expected reply |
|---|---|---|---|---|---|
| R1 | 0 | Refresh state / settle after the result animation / on close | after the result animation (BJF:465-468), frame dispose (BJF:689-690) | none | 269 `op -1` |
| R2 | 1 | Start a hand at a table | chip click (BJL:98-125) | event window (switch 3060) else "activity.ActivityManager.command02"; `point >= cost`; confirm "Deseja consumir {0} diamantes?" (mutable) | 269 `op 1` (`param1` = table id), 3 |
| R3 | 2 | Hit | "Mais uma carta" (BJF:486-512) | 500 ms anti double click; fewer than 5 cards else "Atingiu o número de cartas máximas, não pode continuar a pegar cartas"; not stood; points <= 21 else "Estourou"; points != 21 | 269 `op 2` |
| R4 | 3 | Replace the last card | gold card button (BJF:514-553) | not stood; points != 21; `point >= changeCardCost` else recharge; confirm "Deseja consumir {0} diamantes para mudar carta?" (mutable) | 269 `op 3`, 3 |
| R5 | 4 | Stand | stand button (BJF:555-573), or automatically at 21 ("Jogo encerrado", BJF:309-313) | not stood | 269 `op 4` with `param1` result |
| R6 | 5 | Exchange score | exchange button (BJE:200-209) | event window | 269 `op 5` (new `score`), 115, 271 |

## 4. Server messages (server to client)

### S1. 268 (0x010c) `U_C_BLACK_JACK_MSG`
- `blackjack.BlackJackListMsg`: `blackJack` (#1, `BlackJackMsg`, repeated); `blackJackExchange` (#2, `BlackJackExchangeMsg`, repeated).
- `BlackJackMsg`: `iD` (#1, INT32) table id; `cost` (#2, INT32) diamonds; `winItemReward` (#3, STRING) `"tid,count|..."`; `generalItemReward` (#4, STRING); `winScoreReward` (#5, INT32); `generalScoreReward` (#6, INT32); `changeCardCost` (#7, INT32).
- `BlackJackExchangeMsg`: `id` (#1, INT32); `score` (#2, INT32) needed; `reward_items` (#3, STRING) `"tid,count|..."`.
- Receiver: `BlackjackManager.__blackTempHandler` (BJM:66-105).
- When: login while the event is open (the frame reads it on construction, BJE:112-150).

### S2. 269 (0x010d) `U_C_BLACK_JACK_DATA_MSG`
- `blackjack.BlackJackDataMsg`: `board` (#1, `BlackJackBoardMsg`); `score` (#2, INT32) exchange score; `op` (#3, INT32) echo (-1 for state); `param1` (#4, INT32) table id (op 1) or result (op 4: 1 win, else loss).
- `BlackJackBoardMsg`: `reward_id` (#1, INT32) table id of the hand; `bankerCard` (#2, INT32, repeated) cards 0..51 (`-1` = hidden or empty, rank = `card % 13`, 12 = ace, BJB:14-72); `playerCard` (#3, INT32, repeated); `stoped` (#4, BOOL) stood.
- Receiver: `BlackjackManager.__blackRecordHandler` (BJM:107-135) -> `BLACKJACK_RECORD` -> `BlackjackFrame.__blackRecordHandler` (BJF:190-214): `op -1` table choice or resume, `op 1` new hand, `op 2`/`op 3` player cards, `op 4` bank reveal animation then win or lose movie and item popups (BJF:320-415), `op 5` score.
- When: reply to every route.

### S3. 271 (0x010f) `U_C_BLACK_JACK_EXCHANGE_MSG`
- `blackjack.BlackJackExchangeNoticeMsg`: `exchangeMessage` (#1, STRING, repeated) log lines.
- Receiver: `BlackjackManager.__exchangeMsgHandler` (BJM:137-151).
- When: after exchanges (server wide, assumption) and on open.

## 5. Rules and formulas

- B1. Level 6, window from switch 3060.
- B2. Deal: start gives the player 2 cards and the bank 2 cards (one hidden, assumption); max 5 cards each.
- B3. Points per BJB `countPoints`: ranks 0..7 -> 2..9, 8..11 -> 10, 12 (ace) -> 11 when the running total <= 10 else 1.
- B4. Stand: bank draws to 17 (assumption), compare: player > 21 loses; bank > 21 player wins; higher wins; tie player wins (help line 5).
- B5. Rewards: win -> `winItemReward` and `winScoreReward`; loss -> `generalItemReward` and `generalScoreReward`. The frame shows the ratio `winScoreReward / generalScoreReward`.
- B6. Gold card: replaces the last player card with a new random card for `changeCardCost` diamonds.
- B7. Exchange: spends `score` (exchange view tip: "Consome todos os pontos para obter todos os prêmios de troca") for `reward_items`.

## 6. Templates

None on the client; tables and exchanges come from 268 (server data).

## 7. Persistent state

```sql
CREATE TABLE casino.blackjack_table (
  table_id        INTEGER PRIMARY KEY,
  cost            INTEGER NOT NULL,
  win_items       TEXT    NOT NULL,
  lose_items      TEXT    NOT NULL,
  win_score       INTEGER NOT NULL,
  lose_score      INTEGER NOT NULL,
  change_card_cost INTEGER NOT NULL
);

CREATE TABLE casino.blackjack_exchange (
  exchange_id  INTEGER PRIMARY KEY,
  score        INTEGER NOT NULL,
  reward_items TEXT    NOT NULL
);

CREATE TABLE casino.blackjack_player (
  player_id     BIGINT    PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
  score         INTEGER    NOT NULL DEFAULT 0,
  table_id      INTEGER    REFERENCES casino.blackjack_table(table_id),
  deck          SMALLINT[] NOT NULL DEFAULT '{}',
  banker_cards  SMALLINT[] NOT NULL DEFAULT '{}',
  player_cards  SMALLINT[] NOT NULL DEFAULT '{}',
  stood         BOOLEAN    NOT NULL DEFAULT FALSE
);

CREATE TABLE casino.blackjack_exchange_log (
  log_id     BIGSERIAL   PRIMARY KEY,
  player_id  BIGINT     NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  text       TEXT        NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
```

## 8. Backend implementation notes

- `casino::blackjack::handle_op` (9565) on `op`: 0 `handle_state` (if the hand is finished clear it; reply 269 `op -1`), 1 `handle_start` (window -> no hand in progress -> diamonds; debit, shuffle, deal; reply 269 `op 1`, 3), 2 `handle_hit`, 3 `handle_change_card`, 4 `handle_stand` (bank play, compare, grant items and score; reply 269 `op 4` with `param1`, 115), 5 `handle_exchange`.
- The hand persists across disconnects (`blackjack_player`); 269 `op -1` with cards resumes it.
- Push 268 at login when the switch is open; push 4422 entry 3060 (account feature).

## 9. Open questions and assumptions

- Assumption: hidden bank card is sent as -1 until stand.
- Assumption: bank stands on 17.
- Open: whether exchange can repeat (one pack or every `score` multiple).

## 10. Implementation checklist

- [ ] Screens `BlackjackFrame`, `BlackjackLayer`, `BlackjackExchangeView`
- [ ] Route 9565 ops 0..5
- [ ] Messages 268, 269, 271; switch 3060
- [ ] Tables `blackjack_table`, `blackjack_exchange`, `blackjack_player`, `blackjack_exchange_log`
- [ ] Rules B2..B7
- [ ] Test: ace counting (A + 9 = 20, A + 9 + 5 = 15), tie wins, 6th card refused
