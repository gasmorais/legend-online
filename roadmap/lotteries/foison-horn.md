# Cornucópia (foison horn, "丰收号角")

Path aliases:

| Alias | File |
|---|---|
| FHM | `decompiled/core_module/scripts/managers/FoisonHornManager.as` |
| FHMOD | `decompiled/core_module/scripts/mvc/module/foisonhorn/FoisonHornModel.as` |
| FHF | `decompiled/m11/scripts/foisonhorn/FoisonHornFrame.as` |
| FHI | `decompiled/m11/scripts/foisonhorn/FoisonHornItem.as` |
| TTB | `decompiled/core_module/scripts/ui/toptoolbar/TopToolsBar.as` |
| TBH | `decompiled/core_module/scripts/ui/toptoolbar/TopBtnCheckShowHelper.as` |

## 1. Overview

A cross server collection event. The player collects five different event items; with all five in the bag the player "activates" the horn (the items are consumed, assumption). When the event ends the "Grande Pacote da Cornucópia" prize is shared among all activated players of all servers and mailed. Rules (`foisonHornFrame.ruleTxt.content`): "1) Coletando os cinco itens diferentes durante o evento poderá obter a cornucópia. 2) Os jogadores que obtiveram a cornucópia dividem o prêmio quando o evento termina. 3) Este [Grande Pacote da Cornucópia] é muito generoso. O evento está disponível em todos os servidores. 4) Os prêmios são enviados por email quando o evento termina."

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `foisonhorn.FoisonHornFrame` (FHF) | art title `asset.FoisonHornFrame.frameTitle` | Five `FoisonHornItem` (item, `bag/needed`, activated state); period `openTime - stopTime`; number of activated players `count`; reward icon with tip `rewardInfo` ("Grande Pacote da Cornucópia", "Os jogadores que colecionarem todos os itens podem compartilhar os itens abaixo:"); activate button, "activated" badge | Top toolbar `foisonhorn` (TopToolBtnInfos 2052 "丰收号角") -> `openControllerByInfo("foisonhorn")` (TTB:1441-1443) | FHF:145-167, FHI:43-94 |

Toolbar visibility: `VersionSwitch.FOISON_HORN && model.isOpen` (TBH:373-374).

Important: the five item slots are created in the constructor from `model.goodsList` (FHF:101-116), so the server must push 4877 before the player can open the frame (at login).

## 3. Routes (client to server)

All routes: C>S 9645 (0x25ad), header `extend1 = 30`, body `cccactive.FoisonHornMsg`: `op` (#1, INT32), `itemId` (#2, INT32, default 0). Sender `FoisonHornManager.sendRequest(op, itemId = 0)` (FHM:119-126); `OPEN_FRAME 1`, `ACTIVATING 2` (FHM:18-20).

### R1. Open (op 1)
- UI: frame constructor (FHF:58).
- Expected response: 4877 (S1).

### R2. Activate (op 2)
- UI: activate button (FHF:135-138), enabled when every item `bagCount >= count` (FHF:150-164, FHI:55-76); hidden once any item is activated.
- Expected response: 115 (items consumed), 4877 with every activation flag 1 and the new `count`.

## 4. Server messages (server to client)

### S1. 4877 (0x130d) `U_C_FOISON_HORN`
- `cccactive.FoisonHornMsg`: `op` (#1, INT32); `itemId` (#2, INT32) unused; `isOpen` (#3, BOOL); `openTime` (#4, STRING); `stopTime` (#5, STRING) displayed verbatim; `count` (#6, INT32) players activated (all servers); `activation` (#7, STRING) `"itemId,count,flag|..."` with `flag` 1 when activated (5 entries); `rewardInfo` (#8, STRING) tooltip text of the shared prize.
- Receiver: `FoisonHornManager.__updateFoisonHornMsg` (FHM:57-117): `openChange` when it opens; optional fields overwrite when present; parses `activation`; notifies `FOISONHORN_INFO_CHANGE`.
- When: login, reply to R1 and R2, event start or end, and when the global count changes (assumption).

## 5. Rules and formulas

- B1. No level check in the client.
- B2. Activation requires every item in quantity `count` (bag plus stone house: `getBagCountInPlayerAndStoneByTempId`).
- B3. One activation per player per event (the button is hidden after activation).
- B4. At event end: prize package split among activated players and mailed (assumption: equal share of each item count, rounded down).

## 6. Templates

None. Items, counts and the prize are server event data.

## 7. Persistent state

```sql
CREATE TABLE lotteries.horn_event (
  event_id     SERIAL      PRIMARY KEY,
  starts_at    TIMESTAMPTZ NOT NULL,
  ends_at      TIMESTAMPTZ NOT NULL,
  reward_text  TEXT        NOT NULL,
  settled      BOOLEAN     NOT NULL DEFAULT FALSE
);

CREATE TABLE lotteries.horn_requirement (
  event_id   INTEGER  NOT NULL REFERENCES lotteries.horn_event(event_id) ON DELETE CASCADE,
  slot       SMALLINT NOT NULL CHECK (slot BETWEEN 0 AND 4),
  item_id    INTEGER  NOT NULL,
  item_count INTEGER  NOT NULL CHECK (item_count > 0),
  PRIMARY KEY (event_id, slot)
);

CREATE TABLE lotteries.horn_prize (
  event_id   INTEGER NOT NULL REFERENCES lotteries.horn_event(event_id) ON DELETE CASCADE,
  item_id    INTEGER NOT NULL,
  item_count INTEGER NOT NULL,
  PRIMARY KEY (event_id, item_id)
);

CREATE TABLE lotteries.horn_activation (
  event_id     INTEGER     NOT NULL REFERENCES lotteries.horn_event(event_id) ON DELETE CASCADE,
  player_id    BIGINT     NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  activated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  PRIMARY KEY (event_id, player_id)
);
```

## 8. Backend implementation notes

- `extend1 = 30` -> `lotteries::horn::handle_op`: op 1 `handle_open` (reply 4877); op 2 `handle_activate`: open -> not yet activated -> all requirements in bag. Transaction: consume, insert activation. Reply 115, 4877.
- Cross server count: this server only knows its own activations unless a cross server aggregate exists (see [../cross-server/README.md](../cross-server/README.md)); assumption: local count.
- Job at `ends_at`: split `horn_prize` among activations, mail (see [../mail/README.md](../mail/README.md)), set `settled`; push 4877 `isOpen false`.

## 9. Open questions and assumptions

- Assumption: activation consumes the items.
- Assumption: prize split rule and rounding.
- Open: cross server total.

## 10. Implementation checklist

- [ ] Push 4877 at login (frame needs `goodsList` on construction)
- [ ] Route 9645/30 op 1, op 2
- [ ] Tables `horn_event`, `horn_requirement`, `horn_prize`, `horn_activation`
- [ ] End of event settlement job and mail
- [ ] Test: activation refused with one item missing; second activation refused
