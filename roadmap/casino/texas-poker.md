# Texas Poker ("德州扑克")

Path aliases:

| Alias | File |
|---|---|
| PM | `decompiled/core_module/scripts/yishi/manager/PokerManager.as` |
| PF | `decompiled/m11/scripts/poker/PokerFrame.as` |
| PL | `decompiled/m11/scripts/poker/PokerLayer.as` |
| PSV | `decompiled/m11/scripts/poker/PokerScrollView.as` |
| PEF | `decompiled/m11/scripts/poker/PokerExchangeFrame.as` |
| PEV | `decompiled/m11/scripts/poker/PokerExchangeView.as` |
| PRH | `decompiled/core_module/scripts/mvc/module/poker/PokerResultHelper.as` |
| BM | `decompiled/core_module/scripts/yishi/manager/BaseManager.as` |
| TTB | `decompiled/core_module/scripts/ui/toptoolbar/TopToolsBar.as` |
| TAO | `decompiled/core_module/scripts/ui/toptoolbar/view/TimeActiveBoxOpenTime.as` |
| ENUM | `decompiled/core_module/scripts/com/road/yishi/proto/pet/` (`PokerOpState.as`, `TableActionType.as`, `PokerPlayerState.as`, `TableState.as`) |

## 1. Overview

A cross server No Limit Texas Hold'em table open twice a day (`poker_open_time = 15:00,15:30|21:00,21:30`). The player converts diamonds into chips ("Fichas de Texas", extra field 6), queues for a table, and plays hands against other players. Each pot pays a 20 percent commission and refunds "Pontos de Texas" (extra field 7) spent in the "Loja de Texas Poker" (shop 1003). Help (`poker.PokerFrame.helpContent`): "1. É necessário trocar fichas para jogar, as fichas serão permanentes. 2. Cada jogo será descontado 20% do Pot de fichas válidas como comissão, ao mesmo tempo será reembolsado pontos de Texas. 3. Os pontos de Texas podem ser trocado por itens raros na Loja de Texas."

Protobuf messages live in package `pet` (historical naming); enums: `PokerOpState` START 0, RECHARGE 1, PLAY 2, CROSS_RECHARGE 3, LEAVE 4, MESSAGE 5, FORBIDDEN 6; `TableActionType` ALL_IN 0, BET 1, BIG_BLIND 2, CALL 3, CHECK 4, FOLD 5, RAISE 6, SMALL_BLIND 7; `PokerPlayerState` NONE 0, READYED 1, PLAYING 2; `TableState` NEW 0, PRE_FLOP 1, FLOP 2, TURN 3, RIVER 4, SHOW_DOWN 5, ENDED 6.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `poker.PokerFrame` (PF) | "Texas Poker" | Table with up to `pokerPlayerArr.length` seats (`PokerPlayerView`), dealer chip, board cards, pots ("Main pool:", "Side pool 1..5:"), action bar (`PokerScrollView`), chat with quick phrases `poker.chatData.text1..9` and emotes, hand ranking list (`PokerPatternList`), "Aguardando o jogo iniciar..." | Top toolbar `poker` (TopToolBtnInfos 4006 "德州扑克"): castle or space scene, `checkIsOpen(6)` (level `TIME_ACTIVE_GRADES[6] = 6` and time box state open) (TTB:1396-1406, 1581-1601) | 286, 278..293 |
| `poker.PokerLayer` (PL) | lobby layer inside PF | "Personagem", "Fichas obtidas" (`pokerCash`), "Pontos obtidos" (`pokerScore`), start (queue) with a waiting timer, exchange chips, points shop | PF | extra fields 6, 7 |
| `poker.PokerExchangeFrame` (PEF) | "Trocar Fichas" | "Troca de Fichas:" / "Consumir diamantes:" 1 diamond = 1 chip, default 1000 | PL exchange button (`openControllerByInfo("poker",1,1000)`) | |
| `poker.PokerPrizesFrame` | "Encerramento do jogo" | Pot division per player with hand type, "(Inválido)" share | 289 after 1 s (PF:261-271) | 289 |
| Shop 1003 | "Loja de Texas Poker" | Points shop (owner [../shops/README.md](../shops/README.md)) | PL points button (PL:197-200) | `pokerScore` |

Toolbar visibility: `thane.grades >= 6 && checkIsRightScene()` (`TopBtnCheckShowHelper.as:289-290`); open state from `TimeActiveBoxOpenTime` index 6 = `poker_open_time` and `PokerManager.openSign` (TAO:30, 116-124).

## 3. Routes (client to server)

| # | Action | UI | Client checks | Route and body | Expected reply |
|---|---|---|---|---|---|
| R1 | Queue for a table (START) | PL start (PL:157-180) | `pokerCash >= 10` else "Quantidade de fichas menor que 10, favor efetuar troca"; `openSign` else "Evento do Texas Poker encerrado, não é possível fazer combinação"; not already waiting | C>S 9571 (0x2563) `C_POKER`, `pet.PokerOpMsg`: `op` (#1, ENUM PokerOpState) 0; `user_id` (#2, INT32) own id; `server_name` (#3, STRING) own server; `param1` (#5, INT32) 0 | 287 `PokerPlayerMsg` state, then 286 table when seated |
| R2 | Exchange chips (RECHARGE) | PEF confirm (PEF:122-155) | amount > 0 else "Quantidades de diamantes não pode ser 0"; `point >= amount`; confirm "Fichas serão guardadas, mas só poderá ser usado no final do jogo, deseja efetuar troca?" | 9571, `op` 1, `param1` diamonds | 260 extra field 6, 3 |
| R3 | Leave the event (LEAVE) | PF close confirm (PF:340-356) | none | 9571, `op` 4 | 291 |
| R4 | Table chat (MESSAGE) | PEV quick phrase or emote (PEV:330-404), 5 s anti spam | text not empty | C>S 25167 (0x624f) `CR_POKER_TABLE`, `PokerOpMsg` `op` 5, `msg` (#7, `TableChannelMessage`: `source` (#1, `PokerPlayerMsg` with `user_id`, `server_name`), `type` (#3, INT32) 1, `msg` (#4, STRING)) | broadcast 290 |
| R5 | Leave the table | PEV quit confirm "Jogo atual ainda não terminou, se sair agora as fichas apostadas não serão reembolsadas, deseja sair?" (PEV:260-277) | none | C>S 25165 (0x624d) `CR_POKER_TABLE_LEAVE`, `pet.TablePlayerMsg` with `user_id` (#1), `server_name` (#3) | broadcast 285 |
| R6 | Act | PSV buttons (PSV:185-244): Desistir = FOLD 5; Passo = CHECK 4; "Pago {0}" = CALL 3; slider or quick +50/+100/+200/+500 = BET 1 if BET is allowed else RAISE 6 with `amount = target - (tableBet - myBet)`; All in button sends 3 | only when it is my turn (`actor == me`, PSV:226-235); allowed actions from 283 | C>S 25166 (0x624e) `CR_POKER_TABLE_ACTION`, `pet.TableActMsg`: `action` (#1, ENUM TableActionType); `amount` (#2, INT32); `server_name` (#3, STRING); `param1` (#4, STRING) unused | broadcast 282, 278, 281 |

## 4. Server messages (server to client)

Shared sub messages: `TablePlayerMsg`: `user_id` (#1, INT32), `user_name` (#2, STRING), `server_name` (#3, STRING), `cash` (#4, INT32) chips at the table, `bet` (#5, INT32) bet this round, `action` (#6, ENUM TableActionType) last action, `has_card` (#7, BOOL), `card` (#8, `CardMsg` repeated: `rank` (#1, INT32), `suit` (#2, INT32)), `hand_type` (#9, INT32) 0..9 ("Carta Alta", "Par", "2 pares", "Trinca", "Stright", "Flush", "Full House", "Quadra", "Straight Flush", "Royal Straight Flush"; 100 "Desistir"), `head_id` (#10, INT32), `hand_value` (#11, INT32) comparable strength, `ranking` (#12, INT32, repeated) indexes of the 5 best cards (`PokerResultHelper.getResultCardArr`). `TablePlayerListMsg`: `player` (#1, repeated). `TableBoardMsg`: `bet` (#1, INT32) current highest bet, `min_bet` (#2, INT32), `raises` (#3, INT32), `card` (#4, `CardMsg` repeated) community cards, `pot` (#5, `PotMsg` repeated: `bet` (#1, INT32), `contributor` (#2, `TablePlayerMsg` repeated)). `PokerPlayerMsg`: `user_id` (#1), `user_name` (#2), `server_name` (#3), `cash` (#4), `score` (#6), `state` (#7, ENUM PokerPlayerState), `head_id` (#9), `last_play_time` (#10, INT64).

| # | Opcode | Message | Receiver (PM) | When |
|---|---|---|---|---|
| S1 | 286 (0x011e) `U_C_POKER_TABLE_MSG` | `TableInfoMsg`: `table_type` (#1), `big_blind` (#2), `players` (#3, list of seats, empty seat `user_id 0`), `active_players` (#4), `board` (#5), `dealer_position` (#6, seat index), `actor` (#7) | `__pokerTableHandler` (PM:96-180) -> `POKER_TABLE` | seated; reconnect |
| S2 | 284 (0x011c) `U_C_POKER_PLAYER_JOINED_MSG` | `TablePlayerMsg` | `__pokerJoinHandler` (PM:182-203): first empty seat | another player sits |
| S3 | 285 (0x011d) `U_C_POKER_PLAYER_LEAVE_MSG` | `TablePlayerMsg` | `__playerLeaveHandler` (PM:205-235): self clears the table | R5 or kick |
| S4 | 278 (0x0116) `U_C_POKER_TABLE_BOARD_MSG` | `TableBoardMsg` | `__boardHandler` (PM:237-252) | after each action and street |
| S5 | 279 (0x0117) `U_C_POKER_HAND_STARTED_MSG` | `TableStartedMsg`: `active_players` (#1), `dealer_position` (#2) | `__handStartHandler` (PM:254-294) | new hand |
| S6 | 280 (0x0118) `U_C_POKER_PLAYER_UPDATED_MSG` | `TablePlayerMsg` (with own hole cards for the owner) | `__playerUpdateHandler` (PM:296-320) | cards dealt, showdown, cash change |
| S7 | 281 (0x0119) `U_C_POKER_ACTOR_ROTATED_MSG` | `TablePlayerMsg` (next actor) | `__rotatedHandler` (PM:322-338) | turn passes |
| S8 | 282 (0x011a) `U_C_POKER_PLAYER_ACTED_MSG` | `TablePlayerMsg` (actor after acting) | `__playerActedHandler` (PM:340-359) | after R6 or timeout ("Aviso: Se não apostar dentro do tempo limite, irá desistir automaticamente") |
| S9 | 283 (0x011b) `U_C_POKER_PLAYER_ACT_NOTIFY_MSG` | `TableActNotifyMsg`: `action` (#1, ENUM repeated) allowed actions; `minBet` (#2); `currentBet` (#3) | `__actNotifyHandler` (PM:361-383) | to the actor only |
| S10 | 287 (0x011f) `U_C_POKER_PLAYER_MSG` | `PokerPlayerMsg` | `__pokerMsgHandler` (PM:385-400) | queue state changes |
| S11 | 289 (0x0121) `U_C_POKER_TABLE_POT_MSG` | `TablePotDivisionListMsg`: `potDivision` (#1, repeated `TablePotDivisionMsg`: `player` (#1), `pot_share` (#2), `commission` (#3), `score` (#4) points refunded, `invalid_share` (#5)) | `__prizesPotHandler` (PM:402-429), sorted by `hand_value` | showdown or everyone folded |
| S12 | 290 (0x0122) `U_C_POKER_CHAT_MSG` | `TableChannelMessage` | `__pokerChatHandler` (PM:444-450) | broadcast of R4 |
| S13 | 291 (0x0123) `U_C_POKER_PLAYER_FORCE_LEAVE_MSG` | `PokerPlayerMsg` | `__pokerQuitHandler` (PM:452-461): own -> close | R3, event end |
| S14 | 292 (0x0124) `U_C_POKER_HAND_ENDED_MSG` | empty | `__handEndHandler` (PM:463-468) | hand end |
| S15 | 293 (0x0125) `U_C_POKER_HAND_BETTINGROUND_MSG` | `BettingRoundMsg`: `state` (#1, ENUM TableState) | `__newRoundHandler` (PM:470-476) | each street |
| S16 | 328 (0x0148) `U_C_POKER_SWITCH` | `PokerOpMsg`, `param3` (#8, BOOL) open | `__startSwitchHandler` (PM:478-485) -> `openSign` | login, window start and end |
| S17 | 260 extra fields 6 and 7 | `PlayerExtraFieldMsg` | BM:903-912: field 6 `pokerCash` (chips), field 7 `pokerScore` (points) | after exchange, after each pot |
| S18 | 277 (0x0115) `U_C_POKER_PLAYER_LIST_MSG` | not handled by this client | none | do not send |

## 5. Rules and formulas

- B1. Window `poker_open_time` 15:00-15:30 and 21:00-21:30 (`ConfigInfos.xml`); level 6; castle or space scene.
- B2. Chips: 1 diamond = 1 chip (R2), chips persist (field 6). Minimum 10 chips to queue.
- B3. Standard Texas Hold'em: blinds `big_blind` and half, 2 hole cards, flop, turn, river, side pots. Hand ranks 0..9 as above.
- B4. Commission 20 percent of each valid pot; refunded as points (`score` in S11); points buy shop 1003 items.
- B5. Leaving during a hand forfeits the bet chips.
- B6. Turn timer: auto fold on timeout (duration server data, assumption 20 s).
- B7. Cross server: opcodes prefixed `CR_` go to the cross server table service; player identity is (`user_id`, `server_name`).

## 6. Templates

| File | Record | Fields |
|---|---|---|
| `raw/xml/tempinfos/ConfigInfos.xml` | `poker_open_time` | windows |
| `raw/xml/tempinfos/ShopTempInfos.xml` | shop 1003 goods with `PokerScore` price (`ShopTempInfoMsg.pokerScore`) | owned by shops |

## 7. Persistent state

```sql
CREATE TABLE casino.poker_wallet (
  player_id    BIGINT     PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
  chips        BIGINT      NOT NULL DEFAULT 0 CHECK (chips >= 0),
  points       BIGINT      NOT NULL DEFAULT 0 CHECK (points >= 0),
  updated_at   TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE casino.poker_hand_log (
  hand_id      BIGSERIAL   PRIMARY KEY,
  table_id     INTEGER     NOT NULL,
  started_at   TIMESTAMPTZ NOT NULL,
  ended_at     TIMESTAMPTZ,
  board        SMALLINT[]  NOT NULL DEFAULT '{}'
);

CREATE TABLE casino.poker_hand_result (
  hand_id      BIGINT  NOT NULL REFERENCES casino.poker_hand_log(hand_id) ON DELETE CASCADE,
  player_id    BIGINT NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  bet_total    INTEGER NOT NULL,
  pot_share    INTEGER NOT NULL DEFAULT 0,
  commission   INTEGER NOT NULL DEFAULT 0,
  points       INTEGER NOT NULL DEFAULT 0,
  PRIMARY KEY (hand_id, player_id)
);
```

Live table state (seats, deck, pots, actor) stays in memory.

## 8. Backend implementation notes

- `casino::poker::handle_op` (9571): `op 0` `handle_queue` (window open, chips >= 10, not seated; seat when a table has room, push 286 to the player and 284 to others; start a hand when 2+ players), `op 1` `handle_recharge` (debit diamonds, add chips, push 260 field 6 and 3), `op 4` `handle_leave_event` (push 291, return chips on the table to the wallet).
- `casino::poker::handle_table_chat` (25167, `op 5`): rate limit, broadcast 290.
- `casino::poker::handle_table_leave` (25165): forfeit current bet, broadcast 285, push 260.
- `casino::poker::handle_action` (25166): actor check -> action in allowed set -> amount rules (min raise) -> apply; broadcast 282, 278; advance: 281 next actor and 283 to that player, or 293 next street, or showdown 280 (cards), 289 division, 292 end, 260 fields 6 and 7 to each player.
- Timers: per turn timeout auto fold; window end at 15:30 and 21:30: finish hands, push 291 and 328 `param3 false`.
- Cross server: if a single server deployment, treat `server_name` as the local server.

## 9. Open questions and assumptions

- Assumption: blind sizes and table types (`table_type`, `big_blind`) are server configuration.
- Open: All in button sends CALL (3) in this client (PSV:217); the server should treat a call with insufficient chips as all in.
- Open: 277 player list is unused.

## 10. Implementation checklist

- [ ] Screens `PokerFrame` with `PokerLayer`, exchange, prizes; shop 1003
- [ ] Routes 9571 (ops 0, 1, 4), 25165, 25166, 25167
- [ ] Messages 286, 284, 285, 278, 279, 280, 281, 282, 283, 287, 289, 290, 291, 292, 293, 328; extra fields 6 and 7
- [ ] Tables `poker_wallet`, `poker_hand_log`, `poker_hand_result`
- [ ] Hand engine with side pots, commission 20 percent, points refund
- [ ] Window timers and auto fold
- [ ] Test: queue refused with 9 chips; leave mid hand loses bet
