# Pandora box ("Caixa de Pandora", client package `pandora`)

Module of [README.md](README.md). A timed diamond lottery: the player pays the diamond price of the current level and a wheel of six values picks how many diamonds he receives; each draw advances the level. Despite the name it is not a bag item. Protocol package `cccactive` (owned by [../seasonal-events/README.md](../seasonal-events/README.md)); the client package is assigned to inventory.

Path aliases:

| Alias | File |
|---|---|
| PDM | `decompiled/core_module/scripts/yishi/manager/PandoraManager.as` |
| PDF | `decompiled/m11/scripts/pandora/PandoraFrame.as` |
| PDI | `decompiled/m11/scripts/pandora/PandoraItem.as` |
| TBH | `decompiled/core_module/scripts/ui/toptoolbar/TopBtnCheckShowHelper.as` |

## 1. Overview

- Top toolbar button "Caixa de Pandora" visible when hero level >= 6 and the event is open (`TBH:331-332`), opens `PandoraFrame` (`decompiled/core_module/scripts/ui/toptoolbar/TopToolsBar.as:1323-1324`).
- The event state is pushed with 430; the frame asks the lottery data (op 1) and draws (op 2).
- Each level has six possible results `point1..point6` (diamonds won) and a `needPoint` price; after a draw the frame shows "Você obteve o prêmio da sorte através da caixa de pandora: ganhou {0} diamantes" in the system chat channel and moves to the next level (`PDF:193-209`).
- `leftLotteryCount` limits the draws; at 0 the button is disabled with "Números restantes insuficientes, favor tentar para a próxima." (`PDF:241-253`).

## 2. Screens

| Class | pt-BR title | Purpose | Data |
|---|---|---|---|
| `pandora.PandoraFrame` (768 x 602) | "Caixa de Pandora" (`ui.toptoolbar.TopToolsBar.tipData_pandora`) | six `PandoraItem` on a wheel, draw button, remaining draws, price of the current level, event period and countdown (`PDF:96-327`) | `PandoraLotteryMsg` |

## 3. Routes (client to server)

Route: C>S 9645 (0x25ad) `C_CCCACTIVE_CLIENTOP`, packet header extra parameter `23` (third `PackageOut` argument, written as the second int after the client id, `decompiled/core_module/scripts/yishi/comm/PackageOut.as:13-27`), message `cccactive.PandoraLotteryMsg` with only `op` (#1, INT32) set (`PDM:95-101`).

| Op | Action | Sender | Client checks | Response |
|---:|---|---|---|---|
| 1 | load lottery data | `PDF:102` on open | | 429 with the full message |
| 2 | draw | `PDF.__receiveBtnHandler` (`PDF:283-294`) | `needPoint <= point` (diamonds) else recharge prompt; locks the frame until the result | 429 with `op` 2, `currentLevel`, `resultPoint`, `leftLotteryCount`; 3 with diamonds |

## 4. Server messages (server to client)

| Opcode | Message | Receiver | Meaning |
|---|---|---|---|
| 429 (0x01ad) `U_C_PANDORAINFO` | `cccactive.PandoraLotteryMsg`: `op` (#1, INT32); `currentLevel` (#2, INT32); `reward` (#3, repeated `LotteryRewardMsg`); `resultPoint` (#4, INT32) diamonds won; `leftLotteryCount` (#5, INT32); `openTime` (#6, STRING), `stopTime` (#7, STRING) `YYYY-MM-DD hh:mm:ss`. `cccactive.LotteryRewardMsg`: `point1`..`point6` (#1..#6, INT32) wheel values, `level` (#7, INT32), `needPoint` (#8, INT32) price | `PDM.__pandoraHandler` (`PDM:47-64`): op 1 stores the full message, op 2 updates level, result and count; the frame spins to the slot whose value equals `resultPoint` (`PDF:211-239`) | answers |
| 430 (0x01ae) `U_C_PANDORAOPEN_STATE` | `simple.PropertyMsg.param7` (#7, BOOL) open | `PDM.__openStateHandler` (`PDM:66-73`) refreshes the toolbar | login and when the event opens or closes |
| 3 | `point` | | after a draw |

## 5. Rules and formulas

- Draw cost: `needPoint` of the reward row whose `level == currentLevel` (`PDM:80-93`), diamonds only (no bound diamonds in the client check).
- Result: one of `point1..point6`, credited as diamonds (assumption: weights are server side).
- Level after a draw: `min(currentLevel + 1, reward.length)` (`PDF:207`).
- Available only between `openTime` and `stopTime`, hero level >= 6.

## 6. Templates

None in the client; levels, prices and values come from the server (event configuration).

## 7. Persistent state

```sql
CREATE TABLE inventory.pandora_events (
  event_id     SERIAL      PRIMARY KEY,
  opens_at     TIMESTAMPTZ NOT NULL,
  closes_at    TIMESTAMPTZ NOT NULL CHECK (closes_at > opens_at),
  draws_per_player SMALLINT NOT NULL CHECK (draws_per_player > 0)
);

CREATE TABLE inventory.pandora_levels (
  event_id     INTEGER  NOT NULL REFERENCES inventory.pandora_events(event_id) ON DELETE CASCADE,
  level        SMALLINT NOT NULL,
  price        INTEGER  NOT NULL CHECK (price > 0),
  wheel_values  INTEGER[] NOT NULL CHECK (array_length(wheel_values, 1) = 6),
  wheel_weights INTEGER[] NOT NULL CHECK (array_length(wheel_weights, 1) = 6),
  PRIMARY KEY (event_id, level)
);

CREATE TABLE inventory.pandora_progress (
  event_id     INTEGER  NOT NULL REFERENCES inventory.pandora_events(event_id) ON DELETE CASCADE,
  player_id    BIGINT  NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  level        SMALLINT NOT NULL DEFAULT 1,
  draws_used   SMALLINT NOT NULL DEFAULT 0,
  PRIMARY KEY (event_id, player_id)
);
```

## 8. Backend implementation notes

- `inventory::pandora::handle_op` (9645 with header parameter 23; the `cccactive` dispatcher of seasonal events routes it here): op 1 -> push 429 (full); op 2 -> event open, draws left, diamonds >= price -> debit, weighted pick, credit result, advance level -> push 429 (partial) and 3.
- Push 430 on login and at open / close times.

## 9. Open questions and assumptions

- Weights of the six values and the number of draws per player are not in the client.
- Whether bound diamonds may pay (client checks only `point`).

## 10. Implementation checklist

- [ ] 9645 sub type 23 dispatch, ops 1 and 2
- [ ] Pushes 429 and 430
- [ ] Tables `inventory.pandora_events`, `inventory.pandora_levels`, `inventory.pandora_progress`
- [ ] Tests: draw without diamonds, last level clamp, event closed
