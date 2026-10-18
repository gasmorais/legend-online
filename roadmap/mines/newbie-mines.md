# Newbie mines: three diamond sets with level rewards

Module `newbie-mines` of feature `mines`. Covers "Minas de Iniciante" (`FundVeinFrame`): the state message 4640 (`LodeListMsg`), the query (8751 op 0), buying a mine set (op 1) and claiming a level reward (op 2).

Path aliases:

| Alias | File |
|---|---|
| FVM | `decompiled/core_module/scripts/managers/FundVeinManager.as` |
| FVI | `decompiled/core_module/scripts/mvc/module/fundVein/FundVeinInfo.as` |
| GRI | `decompiled/core_module/scripts/mvc/module/fundVein/GradeRewardInfo.as` |
| V | `decompiled/m11/scripts/fundVein/` |

## 1. Overview

- Three mine sets (levels, frames 1..3 of `fund.LevelImg`), each bought once with real diamonds (`needPoint`; config `FreshManDepositCost` = "200,2000,10000", description "新手矿脉，参与需要钻石"). "Aviso: Pode comprar 3 sets das minas" (bottom tip), help "1. Apenas poderá comprar os 3 sets das minas de iniciante. 2. Após participar do evento, após obter determinado nível poderá coletar o prêmio, através da mina de iniciante."
- Each set lists rewards (`GradeRewardInfoMsg`): a hero level condition ("Condições para coletar: Nível da Personagem {0}") and diamonds (-400) and/or bound diamonds (-500). Rewards are claimable only after the set is bought.
- Totals: each set shows the total obtainable (`allTakedInfo`, up to 2 cells), the frame shows the grand total ("Acumulado", `totalTakedInfo`, 2 cells).
- `isOver = true` hides the top bar button and closes the frame ("Evento encerrado").

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `V/FundVeinFrame.as` | "Minas de Iniciante"; help "Instruções da Mina de Iniciante"; "Aviso: Pode comprar 3 sets das minas"; "Acumulado" | 3 sets and grand total | top bar `fundnewbie` -> controller `fundnewbie` (`decompiled/core_module/scripts/mvc/controler/FundVeinController.as`); `show()` sends op 0 (`:49-54`) | `leveInfo[0..2]`, `totalTakedInfo` (`:134-152`) |
| `V/FundVeinItem.as` | buy button; confirmation "Consumir {0} para abrir a Mina de Iniciante" ({0} = "{needPoint}Diamante") | one set: price, totals, reward list | Frame | `needPoint`, `allTakedInfo`, `infoMsg` sorted by claimable, not claimed, claimed then `index` (`:90-125`, `GRI:47-58`) |
| `V/FundVeinItemCell.as` | "Condições para coletar: Nível da Personagem {0}"; collect button; level too low tip "Nível insuficiente" | one reward | Item | `needGrade`, `isTaked`, `itemInfo` diamonds (`:116-173`) |
| `V/FundVeinDiamondCell.as` | tip "Diamante" or "Diamante vinculado" | amount with icon (frame 2 for `tempId == -500`) | cells above | (`:50-66`) |

## 3. Routes (client to server)

`DepositActiveMsg` request fields used: `opType (#15, INT32)`, `opParam (#16, INT32)`, `depositLevel (#13, INT32)`. Sender `FVM.fundOperate(op, a, b)` (`FVM:64-79`).

### C1. Query (op 0)
- UI: frame `show()` (`V/FundVeinFrame.as:49-54`).
- Route: C>S 8751 (0x222f) `C_FRESHMAN_DEPOSIT`, `DepositActiveMsg`: `opType` = 0.
- Response: 4640.

### C2. Buy a set (op 1)
- UI: buy button of a set (`V/FundVeinItem.as:157-178`).
- Client checks: button enabled only when `!isBuy` (`:124`); confirmation "Consumir {0} para abrir a Mina de Iniciante"; `playerInfo.point >= needPoint` (real diamonds) else recharge alert.
- Route: 8751, `opType` = 1, `opParam (#16)` = set `level`.
- Response: 4640 with `isBuy = true` for that set; diamond balance push.

### C3. Claim a reward (op 2)
- UI: collect button of a reward cell (`V/FundVeinItemCell.as:102-109`).
- Client checks: button visible when `!isTaked`, enabled when the set is bought (`:123-125`); hero level `< needGrade` -> grey overlay that swallows clicks (`:104-107,158-172`).
- Route: 8751, `opType` = 2, `depositLevel (#13)` = set `level` (the cell is built with the parent `level`, `V/FundVeinItem.as:127-135`), `opParam (#16)` = reward `index`.
- Response: 4640 with `isTaked = true`; currency pushes (diamonds and/or bound diamonds).

## 4. Server messages (server to client)

### S1. 4640 (0x1220) `U_C_FRESHMAN_DEPOSIT`, `active.LodeListMsg`
Receiver `FVM.__getFundInfoHandler` (`FVM:54-62`, listener `FVM:49-52`) -> `FVI.info` (`FVI:28-55`).

| Field | Tag | Type | Rep | Meaning |
|---|---|---|---|---|
| `leveInfo` | #1 | `LevelInfoMsg` | yes | the 3 sets, in display order |
| `totalTakedInfo` | #2 | `RewardItemInfoMsg` | yes | grand total (2 entries: diamonds, bound diamonds) |
| `isOver` | #3 | BOOL | no | true hides the button and closes the frame |

`LevelInfoMsg`: `needPoint (#1, INT32)` diamond price; `isBuy (#2, BOOL)` bought; `infoMsg (#3, GradeRewardInfoMsg, repeated)` rewards; `allTakedInfo (#4, RewardItemInfoMsg, repeated)` set total (first 2 entries shown); `level (#5, INT32)` set id sent back in op 1 and op 2.

`GradeRewardInfoMsg`: `needGrade (#1, INT32)` hero level required; `isTaked (#2, BOOL)` claimed; `itemInfo (#3, RewardItemInfoMsg, repeated)` amounts; `index (#4, INT32)` reward id within the set (also the diamond icon frame, `V/FundVeinItemCell.as:127-128`).

`RewardItemInfoMsg`: `tempId (#1, INT32)` -400 diamonds or -500 bound diamonds (any other id is drawn as diamonds); `count (#2, INT32)`.

Client reaction: rebuilds the model, counts claimable rewards (`isGained`: set bought, not claimed, level reached) into InfoTips key 22 (top bar badge), dispatches `SHOWTOPBTN` and `FUND_VEIN_INFO_REFRESH` (frame refresh or close when `isOver`).

When: response to 8751 ops 0, 1, 2; push at login for eligible players (needed for the button, default `isOver` is true); push on hero level up when a reward becomes claimable (assumption, for the badge).

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Prices | 200, 2000, 10000 diamonds (`FreshManDepositCost`), real diamonds only | `ConfigInfos.xml`, `V/FundVeinItem.as:171` |
| Purchase | once per set | help text |
| Claimable | `isBuy && !isTaked && heroLevel >= needGrade` | `GRI:30-45` |
| Badge | number of claimable rewards | `FVI:116-120`, `decompiled/core_module/scripts/yishi/manager/InfoTipsManager.as:243-247` |
| End | `isOver` when the offer window closes, or (assumption) when every set is bought and every reward claimed | `FVM:81-84` |
| Top bar level | template 2004 has no level check; visibility depends only on `isOver` | `docs/mechanics/world_progression.md` top bar table |
| Reward contents | not in client data (server config) | open question |

Dead code: `FundManager.getNewbieShowBtn` and `fundNewbieOperate` (8751 op 0 from `InfoTipsManager.as:73-76`) depend on `FundManager.newbieModel`, which is never filled (`__getFundNewbieInfo` is not registered), so that path never sends.

## 6. Templates

| File | Fields used |
|---|---|
| `ConfigInfos.xml` | `FreshManDepositCost` "200,2000,10000" (server side; not read by the client) |

## 7. Persistent state

Schema `mines`.

```sql
CREATE TABLE mines.newbie_sets (
  set_level     SMALLINT PRIMARY KEY CHECK (set_level BETWEEN 1 AND 3),
  need_point    INTEGER NOT NULL CHECK (need_point > 0)          -- 200, 2000, 10000
);

CREATE TABLE mines.newbie_rewards (
  set_level      SMALLINT NOT NULL REFERENCES mines.newbie_sets(set_level) ON DELETE CASCADE,
  reward_index   SMALLINT NOT NULL,
  need_grade     SMALLINT NOT NULL CHECK (need_grade >= 1),
  diamonds       INTEGER NOT NULL DEFAULT 0 CHECK (diamonds >= 0),        -- tempId -400
  bound_diamonds INTEGER NOT NULL DEFAULT 0 CHECK (bound_diamonds >= 0),  -- tempId -500
  PRIMARY KEY (set_level, reward_index)
);

CREATE TABLE mines.newbie_purchases (
  player_id     BIGINT NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  set_level     SMALLINT NOT NULL REFERENCES mines.newbie_sets(set_level),
  bought_at     TIMESTAMPTZ NOT NULL DEFAULT now(),
  PRIMARY KEY (player_id, set_level)
);

CREATE TABLE mines.newbie_claims (
  player_id     BIGINT NOT NULL,
  set_level     SMALLINT NOT NULL,
  reward_index  SMALLINT NOT NULL,
  claimed_at    TIMESTAMPTZ NOT NULL DEFAULT now(),
  PRIMARY KEY (player_id, set_level, reward_index),
  FOREIGN KEY (player_id, set_level) REFERENCES mines.newbie_purchases(player_id, set_level) ON DELETE CASCADE,
  FOREIGN KEY (set_level, reward_index) REFERENCES mines.newbie_rewards(set_level, reward_index)
);
```

Optional per player window: `mines.newbie_offer (player_id PK, offer_ends_at TIMESTAMPTZ)` if the offer is time limited (open question).

## 8. Backend implementation notes

| Opcode | Handler |
|---|---|
| 8751 `opType` 0 | `mines::newbie_mines::handle_query` |
| 8751 `opType` 1 | `mines::newbie_mines::handle_buy` |
| 8751 `opType` 2 | `mines::newbie_mines::handle_claim` |
| login, level up | `mines::newbie_mines::push_state` |

- `handle_query`: build 4640 (3 `LevelInfoMsg` with totals computed from `newbie_rewards`, `totalTakedInfo` = sum over the 3 sets, `isOver`).
- `handle_buy`: `!isOver` -> set exists -> not bought -> real diamonds `>= need_point` (currency service, no bound diamonds) -> one transaction: deduct, insert purchase -> 4640 + diamond push.
- `handle_claim`: `depositLevel` set bought -> `opParam` reward exists -> not claimed -> hero level `>= need_grade` -> one transaction: insert claim, add diamonds and bound diamonds -> 4640 + currency pushes. Recompute `isOver`.
- `push_state` at login for every player while the offer is open; on hero level up only if a new reward becomes claimable.
- Invalid requests: reply 4640 unchanged (the client shows no error).

## 9. Open questions and assumptions

- Open: reward table (levels and amounts per set) is not in client data.
- Open: whether the offer is time limited per account (for example N days after creation) or permanent until finished.
- Assumption: `isOver` becomes true when every set is bought and every reward claimed, or the offer window ends.
- Assumption: only real diamonds pay (client checks `point`).

## 10. Implementation checklist

- [ ] Screens (client ready): `FundVeinFrame`, `FundVeinItem`, `FundVeinItemCell`, `FundVeinDiamondCell`.
- [ ] Tables `mines.newbie_sets`, `newbie_rewards`, `newbie_purchases`, `newbie_claims`; seed prices 200/2000/10000.
- [ ] Route 8751 op 0 and server message 4640 builder.
- [ ] Route 8751 op 1 purchase with real diamonds.
- [ ] Route 8751 op 2 claim with level check, diamonds and bound diamonds.
- [ ] Login push and level up push (badge).
- [ ] Tests: buy twice refused; buy without diamonds refused; claim before buying refused; claim below `needGrade` refused; claim pays -400 to diamonds and -500 to bound diamonds; `isOver` hides the button.
