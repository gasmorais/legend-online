# Caça-Niquel (slot check-in, "拉霸")

Path aliases:

| Alias | File |
|---|---|
| SLM | `decompiled/core_module/scripts/managers/SlotManager.as` |
| SLMOD | `decompiled/core_module/scripts/mvc/module/slot/SlotModel.as` |
| SLF | `decompiled/m11/scripts/slot/SlotFrame.as` |
| TTB | `decompiled/core_module/scripts/ui/toptoolbar/TopToolsBar.as` |
| TBH | `decompiled/core_module/scripts/ui/toptoolbar/TopBtnCheckShowHelper.as` |

## 1. Overview

A 7 day login event shaped as a slot machine. Each day the player may pull once; the reel shows one digit 0..9. The digits of the event days form the reward amount of one currency (gold, diamonds or other, `rewarditemtemplateid`). At the end (or earlier) the player collects. Two variants: new servers (`type 1`): a missed day can be pulled for free the next day; old servers (`type 2`): a missed day can be bought for `findcost` diamonds, and fewer days are shown (the slot string is left padded with `#`). Notices (`slot.slotFrame.noticeArrNewS` / `noticeArrOldS`): "Cada dia que acessar no jogo tem uma chance de sortear prêmios", "Após sortear, poderá coletar imediatamente o prêmio", "Se esquecer de sortear o prêmio, pode sortear gratuitamente no dia seguinte" or "Caso você se esqueceu do sorteio diário, utilize alguns diamantes para usufruir do sorteio anterior".

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `slot.SlotFrame` (SLF) | "Caça-Niquel" (`slot.slotFrame.title`) | 7 reels (`_slotResultArr`), participation "{days}/{total}", reward icon (frames for -100, -300, -600, -500), buttons pull, add (buy a missed day), collect | Top toolbar `slot` (TopToolBtnInfos 2033 "拉霸") (TTB:1236-1255): refused while in a team ("Você encontra-se numa Equipe, não é possível participar no Evento de Caça-Niquel"); while open the client turns on refuse invite flags and restores them on close (SLF:400-420) | 4901 |

Toolbar visibility: `grades > 11 && model.isOpen && checkIsRightScene()` (TBH:339-340).

## 3. Routes (client to server)

All routes: C>S 9500 (0x251c) `C_SLOT_ACTIVE_REQ` ("拉霸活动请求"), body `active.SlotActiveRequest`: `op` (#1, INT32, required). Sender `SlotManager.sendSlotReq(op)` (SLM:77-83).

| # | op | Action | UI | Client checks | Expected reply |
|---|---|---|---|---|---|
| R1 | 1 | Open | frame constructor (SLF:114) | none | 4901 `op 1` |
| R2 | 2 | Pull today (free) | pull button (SLF:323-350) | `isOpen` else "Evento do Caça-Niquel Encerrado"; `status != 2` else "Você já coletou o prêmio, aguarde até o próximo evento"; a `*` position exists else "Você já utilizou suas chances diárias no Caça-níquel" | 4901 `op 2` |
| R3 | 11 | Buy a missed day | add button, enabled when a `+` exists and `status != 2` (SLF:235-286, 626-655) | `isOpen`; confirm "Deseja consumir {0} diamantes para fazer o Check-in" (`findcost`); `point >= findcost` else recharge | 4901 `op 11`, 3 |
| R4 | 3 | Collect | collect button, enabled when `status == 1` (SLF:288-321) | `isOpen`; if days pulled < total days, confirm "Ainda tem chances para fazer check-in, deseja coletar o prêmio?" | 4901 `op 3`, currency push |

## 4. Server messages (server to client)

### S1. 4901 (0x1325) `U_C_SLOTINFO`
- `active.SlotActiveMsg`: `open` (#1, BOOL, required) event open; `op` (#2, INT32, required) echo; `status` (#3, INT32) 0 playing, 1 can collect, 2 collected; `slot` (#4, STRING) one char per day; `type` (#5, INT32) 1 new server, 2 old server; `rewarditemtemplateid` (#6, INT32) reward currency id (-100, -300, -500, -600, negative ids = currencies); `findcost` (#7, INT32) diamonds per missed day.
- Day chars: digit `0..9` pulled value; `*` can pull now (free); `+` missed, can be bought (R3); `-` future day; `#` padding (type 2 pads to 7 when the string has 3, 4 or 5 chars, SLM:52-65).
- Receiver: `SlotManager.__slotInfoHandler` (SLM:45-75): sets the model; dispatches `SLOTINFO` only when `open`. `SlotFrame.__slotInfoHandler` (SLF:370-388): op 0 nothing, op 1 full refresh, op 2/10/11 rolls the current reel then shows the next notice ("hoje ainda pode apostar no Caça-Niquel {0} vezes", "hoje ainda pode fazer o check-in {0} vezes", "Favor participar novamente o evento amanhã"), op 3 collected.
- When: reply to every route; at login (sets `isOpen` for the toolbar); op 10 push after the daily rollover (assumption: a new `*`).

## 5. Rules and formulas

- B1. Level 12+ (`grades > 11`), castle or space scene, not in a team.
- B2. One free pull per day (`*`). Type 1: a missed day becomes `*` again the next day (free). Type 2: a missed day becomes `+` and costs `findcost` diamonds.
- B3. Reward amount: the digits of the pulled days read as a number (each reel's digit flies to its position, SLF:461-500); currency `rewarditemtemplateid`.
- B4. Collect once (`status 2` afterwards); collecting early forfeits the remaining days.
- B5. Pull result digit: server random 0..9 (assumption: weighted so that early days have higher digits, typical of this event).

## 6. Templates

None. Reward currency, day count and `findcost` are server event data.

## 7. Persistent state

```sql
CREATE TABLE casino.slot_event (
  event_id      SERIAL      PRIMARY KEY,
  starts_on     DATE        NOT NULL,
  days          SMALLINT    NOT NULL CHECK (days BETWEEN 1 AND 7),
  variant       SMALLINT    NOT NULL CHECK (variant IN (1, 2)),
  reward_id     INTEGER     NOT NULL,
  missed_cost   INTEGER     NOT NULL DEFAULT 0
);

CREATE TABLE casino.slot_player (
  event_id    INTEGER  NOT NULL REFERENCES casino.slot_event(event_id) ON DELETE CASCADE,
  player_id   INTEGER  NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  digits      SMALLINT[] NOT NULL DEFAULT '{}',
  status      SMALLINT NOT NULL DEFAULT 0 CHECK (status IN (0, 1, 2)),
  PRIMARY KEY (event_id, player_id)
);
```

`digits` holds one entry per event day (-1 = not pulled); the slot string is derived from it and today's date.

## 8. Backend implementation notes

- `casino::slot::handle_op` (9500): op 1 `handle_open`; op 2 `handle_pull` (status 0 or 1 -> first pullable day by variant: type 1 first `*`, type 2 last `*` (SLF:676-726) -> roll digit -> `status = 1`); op 11 `handle_buy_missed` (variant 2, a `+` day, diamonds; roll); op 3 `handle_collect` (status 1 -> grant `number(digits)` of `reward_id` -> `status 2`). Every reply is 4901 with the rebuilt `slot` string.
- Push 4901 `op 0` at login with `open` so the toolbar shows the button.

## 9. Open questions and assumptions

- Assumption: the reward amount is the concatenation of the digits.
- Open: digit distribution.

## 10. Implementation checklist

- [ ] Screen `SlotFrame` with team and scene checks
- [ ] Route 9500 ops 1, 2, 3, 11
- [ ] Message 4901 with the slot string encoding
- [ ] Tables `slot_event`, `slot_player`
- [ ] Rules B2..B4
- [ ] Test: second pull the same day refused; type 2 padding with `#`
