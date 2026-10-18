# Jogo da memória (new memory card, "记忆翻牌")

Path aliases:

| Alias | File |
|---|---|
| NMM | `decompiled/core_module/scripts/managers/NewMemoryCardManager.as` |
| NMMOD | `decompiled/core_module/scripts/mvc/module/newmemorycard/NewMemoryCardModel.as` |
| NMF | `decompiled/m11/scripts/newmemorycard/NewMemoryCardFrame.as` |
| NMI | `decompiled/m11/scripts/newmemorycard/NewMemoryCardItem.as` |
| NMG | `decompiled/m11/scripts/newmemorycard/NewMemoryCardGoodsFrame.as` |
| CIM | `decompiled/core_module/scripts/yishi/datas/ConfigInfoManager.as` |
| TTB | `decompiled/core_module/scripts/ui/toptoolbar/TopToolsBar.as` |
| TBH | `decompiled/core_module/scripts/ui/toptoolbar/TopBtnCheckShowHelper.as` |

## 1. Overview

A timed event. A 4x6 board of 24 face down cards hides 12 pairs of rewards. The player flips two cards per step; a matching pair stays open and gives its reward. Each round has a special item; after obtaining it the player may refresh the board to start a new round early. Steps: free steps reset daily at 00:00, purchasable steps (diamonds) last until the end of the event. Help (`NewMemoryCardFrame.helpTxt.text`): "1. Vire duas cartas idênticas para obter os prêmios da carta correspondente; 2. Depois de obter os itens especiais da rodada, você pode clicar no botão de Atualizar para encerrar a rodada com antecedência, atualizar os prêmios e entrar na próxima rodada; Pode-se jogar várias rodadas todos os dias; 3. Os Passos Grátis são válidos apenas no mesmo dia, resetando às 0:00 todos os dias; O limite de compras é resetado também no mesmo horário, e os passos comprados duram apenas para este evento, e expiram no fim do evento."

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `newmemorycard.NewMemoryCardFrame` (NMF) | "Jogo da memória" (`NewMemoryCardFrame.titleText.text`) | 24 `NewMemoryCardItem` indexed `row * 6 + col` (NMF:149-176); "Passos grátis: {0}", "Comprar Passos: {0}"; special item icon; refresh and buy buttons; link "Itens obtidos hoje"; countdown to `stopTime` (NMF:120-142); closes when the event closes (NMF:198-204) | Top toolbar `newmemorycard` (TopToolBtnInfos 4024 "记忆翻牌") -> `openControllerByInfo("newmemorycard")` (TTB:1506-1508); toolbar badge = `freeStep + buyStep` (TTB:2822-2823) | NMF:281-314 |
| `newmemorycard.NewMemoryCardGoodsFrame` (NMG) | items obtained today | Grid of `dropInfo` items (NMG:58-90) | NMF link (NMF:265-274) | `dropInfo` |

Toolbar visibility: `model.isOpen && checkIsRightScene()` (castle or space scene) (TBH:415-416).

## 3. Routes (client to server)

All routes: C>S 8682 (0x21ea) `C_NEW_MEMORY_CARD_OP`, body `player.PlayerOpMsg` (20 fields; only `op` (#1, INT32), `value1` (#13, INT32), `value2` (#14, INT32) used). Senders `NewMemoryCardManager.send(op)` (NMM:137-143) and `sendChoose()` (NMM:127-135). Ops `OP_OPEN 1`, `OP_CHOOSE 2`, `OP_BUY 3`, `OP_REFRESH 4` (NMM:20-26).

| # | Action | UI | Client checks | Fields | Expected reply |
|---|---|---|---|---|---|
| R1 | Open | frame build (NMF:80) | none | `op 1` | 4301 `opType 1` |
| R2 | Flip a pair | click a second card (NMI:69-92) | `freeStep + buyStep > 0` else "O número de passos restantes é insuficiente, compre mais passos!"; board not locked; clicking the same card twice cancels | `op 2`, `value1` first index, `value2` second index (0..23) | 4301 `opType 2` with `result`, `isMatch`, `posInfo`, steps |
| R3 | Buy steps | buy button (NMF:206-241) | `step < memorycard_limittimes` else "Limite de Passos restantes atingido"; `buyCount < memorycard_maxtimes` else "O número de compras de hoje atingiu o limite"; confirm "Quer consumir {0} Diamantes para comprar {1} Passo\n(Hoje ainda pode comprar {2})" (mutable); `point >= memorycard_costdiamond` | `op 3` | 4301 `opType 3` (`buyStep`, `buyCount`), 3 |
| R4 | Refresh the board | refresh button (enabled by `canRefresh`) with confirm "Fazer atualização?" (NMF:243-263); or after the last pair, alert "O jogo acabou\nReinicie o jogo" (NMI:201-228) | none | `op 4` | 4301 `opType 4` (new board) |

## 4. Server messages (server to client)

### S1. 4590 (0x11ee) `U_C_TOP_TOOL_BTN`
- `PropertyMsg` (simple): `param1` (#1) = 4024; `param4` (#4, STRING) open time; `param5` (#5, STRING) stop time; `param7` (#7, BOOL) open.
- Receiver: `NewMemoryCardManager.__topBtnHandler` (NMM:65-77) -> `REFRESH_TOPTOOLS` (an open frame disposes itself when closed).
- When: login and event start or end.

### S2. 4301 (0x10cd) `U_C_NEW_MEMORY_CARD_DATA`
- `memorycard.NewMemoryCardMsg`: `opType` (#1, INT32) echo of the op (4 resets the board view); `freeStep` (#2, INT32); `buyStep` (#3, INT32); `buyCount` (#4, INT32) purchases today; `dropInfo` (#5, STRING) `"tid,count|tid,count|..."` items obtained today; `posInfo` (#6, STRING) `"i,j,..."` indexes already matched (open); `specialInfo` (#7, STRING) `"tid,count"` special item of the round; `canRefresh` (#8, BOOL); `isMatch` (#9, BOOL) last pair matched; `result` (#10, STRING) `"index,tid,count|index,tid,count"` the two flipped cards.
- Receiver: `NewMemoryCardManager.__updateMemoryCardData` (NMM:79-125): only present fields overwrite; `NEW_MEMORYCARD_UPDATE` -> `refreshView` (NMF:281-314): the two clicked cards play the flip with `result`; matched pairs stay open (frame 95), others close; the special item plays an effect; when `posInfo` has 24 entries and the clicked card is the 24th, the "jogo acabou" alert offers a refresh (NMI:201-220); `opType 4` resets every card from `posInfo` (NMI:107-131).
- When: reply to every route.

## 5. Rules and formulas

`raw/xml/tempinfos/ConfigInfos.xml` (read by CIM:1845-1882):

| Config | Value | Meaning |
|---|---|---|
| `memorycard_defaulttimes` | 15 | free steps per day (client default `freeStep = 20` before data) |
| `memorycard_buytimes` | 10 | steps per purchase |
| `memorycard_costdiamond` | 75 | diamonds per purchase (client default 50) |
| `memorycard_limittimes` | 99 | max total steps held |
| `memorycard_maxtimes` | 10 | purchases per day |

- B1. Each flip of two cards costs one step: free steps first, then bought steps (assumption).
- B2. Board: 12 pairs randomly placed; one pair is the round special item.
- B3. A matched pair grants its reward immediately and appends to `dropInfo`.
- B4. `canRefresh` true once the special pair is matched, or when the board is complete; refresh draws a new board (new round).
- B5. Reset at 00:00: `freeStep = 15`, `buyCount = 0`, `dropInfo` cleared. Bought steps expire at the event end.
- B6. Purchase blocked when `freeStep + buyStep >= 99` (client check uses current steps, not steps after purchase).

## 6. Templates

`ConfigInfos.xml` above. Reward pools are server data.

## 7. Persistent state

```sql
CREATE TABLE memory_games.card_event (
  event_id   SERIAL      PRIMARY KEY,
  starts_at  TIMESTAMPTZ NOT NULL,
  ends_at    TIMESTAMPTZ NOT NULL
);

CREATE TABLE memory_games.card_reward (
  event_id    INTEGER NOT NULL REFERENCES memory_games.card_event(event_id) ON DELETE CASCADE,
  reward_id   INTEGER NOT NULL,
  item_id     INTEGER NOT NULL,
  item_count  INTEGER NOT NULL,
  weight      INTEGER NOT NULL DEFAULT 1,
  is_special  BOOLEAN NOT NULL DEFAULT FALSE,
  PRIMARY KEY (event_id, reward_id)
);

CREATE TABLE memory_games.card_player (
  event_id     INTEGER   NOT NULL REFERENCES memory_games.card_event(event_id) ON DELETE CASCADE,
  player_id    BIGINT   NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  free_steps   INTEGER   NOT NULL DEFAULT 15,
  bought_steps INTEGER   NOT NULL DEFAULT 0,
  buys_today   INTEGER   NOT NULL DEFAULT 0,
  day          DATE      NOT NULL DEFAULT CURRENT_DATE,
  board        JSONB     NOT NULL,
  opened       SMALLINT[] NOT NULL DEFAULT '{}',
  special_got  BOOLEAN   NOT NULL DEFAULT FALSE,
  drops_today  JSONB     NOT NULL DEFAULT '[]',
  PRIMARY KEY (event_id, player_id)
);
```

`board` is an array of 24 `{item_id, item_count, special}` entries.

## 8. Backend implementation notes

- `memory_games::card::handle_op` (8682) on `op`:
  - 1 `handle_open`: create or lazily reset by `day`; reply 4301 with every field.
  - 2 `handle_choose`: event open -> steps > 0 -> `value1 != value2`, both 0..23, neither in `opened`. Transaction: decrement a step, compare, on match grant, add to `opened` and `drops_today`, set `special_got`. Reply 4301 with `result`, `isMatch`, `posInfo`, steps, `canRefresh`, `dropInfo`; 115 on match.
  - 3 `handle_buy`: steps < 99 -> `buys_today < 10` -> diamonds >= 75. Debit, `bought_steps += 10`. Reply 4301, 3.
  - 4 `handle_refresh`: `special_got` or all 24 opened. New board, clear `opened`, `special_got`. Reply 4301 `opType 4`.
- Push 4590 (`param1 4024`) at login and on start or end.

## 9. Open questions and assumptions

- Assumption: a non matching pair still costs a step.
- Assumption: free steps spent before bought steps.
- Open: reward weights and special item per round.

## 10. Implementation checklist

- [ ] Screens `NewMemoryCardFrame`, `NewMemoryCardGoodsFrame`; toolbar badge
- [ ] Route 8682 ops 1..4
- [ ] Messages 4590 (4024), 4301
- [ ] Table `card_event`, `card_reward`, `card_player`
- [ ] Rules B1..B6 and daily reset
- [ ] Test: same index twice refused; open card refused; buy cap 10 per day
