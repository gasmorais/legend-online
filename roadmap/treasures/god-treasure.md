# God treasure ("Tesouro dos Deuses")

Module `god-treasure` of feature `treasures`.

Path aliases:

| Alias | File |
|---|---|
| GTM | `decompiled/core_module/scripts/managers/GodTreasureManager.as` |
| GTO | `decompiled/core_module/scripts/mvc/module/godTreasure/GodTreasureModel.as` |
| GTI | `decompiled/core_module/scripts/mvc/module/godTreasure/GodTreasureInfo.as` |
| GTC | `decompiled/core_module/scripts/mvc/controler/GodTreasureControler.as` |
| GTF | `decompiled/m11/scripts/godtreasure/GodTreasureFrame.as` |
| GTT | `decompiled/core_module/scripts/yishi/datas/templates/cate/GodTreasureTemplateCate.as` |
| FUN | `decompiled/core_module/scripts/managers/FunnyManager.as` |

## 1. Overview

Diamond investment event bound to activity type 145. The player invests the grade's `InvestDiamond` into a floating box; the box opens and returns a profit (1 or 2 animation levels). Grades advance one by one ("{0}º Prêmio") until all grades are done. At the end a summary shows "Durante o tesouro dos deuses, você investiu {0}, lucro total {1}". Help text: "Antes do evento ser finalizado, é possível participar clicando no ícone ... Depois de coletar todos os prêmios pode verificar o investimento e recompensa desta atividade."

Status: dormant in this client. No code opens controller `godtreasure` (only `UIModuleTypes.GodTREASURE`), and `TempleteManager._godTreasureTemplateCate` is never assigned, so `godTreasureTemplateCate.grades` would throw. The template XML is not shipped in `raw/xml/tempinfos`.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `GodTreasureFrame` (GTF, style `godtreasure.frame`) | "Tesouro dos Deuses" | box animation, the join button | controller `godtreasure` (`decompiled/core_module/scripts/yishi/manager/FrameControllerManager.as:1665-1666`) | invested and profit of the next grade (`InvestDiamond`, `ProfitDisplay`), gained diamonds, "{0}º Prêmio" (GTF:136-164) |

While open the frame forces "refuse invite" (8286) and "refuse team invite" (8746) and restores them on close (GTF:264-288).

## 3. Routes (client to server)

C>S 9546 (0x254a) `C_GODTREASURE_REQ`, `GodTreasureReqMsg { opType (#1, INT32), level (#2, INT32) }`, sender `GTM.senReq` (GTM:64-71).

| opType | Trigger | Call site | Client checks | Response |
|---|---|---|---|---|
| 1 open | frame init | `GTC.sendOpen` (GTC:79-82), GTF:92 | | 4968 op 1 |
| 2 invest, `level = grade` | the join button | `GTC.jionHandler` (GTC:84-87), GTF:317-349 | `point >= InvestDiamond(grade)` else recharge; no free team ("antes de participar no evento cancele o estado de equipe"); not within the last 180 s of the activity ("a atividade está a chegar ao fim, descontinuar a participação") | 4968 op 2 |
| 3 collect | end of the box animation | `GTC.sendGetReward` (GTC:89-92), GTF:231-262 | | 4968 op 3 (only at the end, see below) |

## 4. Server messages (server to client)

### S1. 4968 (0x1368) `U_C_GODTREASURE_RSP`, `GodTreasureRspMsg`
Receiver `GTM.__godTreasureRspHandler` (GTM:55-62) -> `GTO.updateInfo` (GTO:18-48) -> `GTC.__infoUpdateHandler`.

| Field | Tag | Type | op 1 / op 2 meaning | op 3 meaning |
|---|---|---|---|---|
| `opType` | #1 | INT32 | 1 open, 2 invest result | 3 activity summary |
| `grade` | #2 | INT32 | grades completed (next grade = grade + 1) | grades completed |
| `diamond` | #3 | INT32 | diamonds gained in this step (shown as "gained") | total profit |
| `level` | #4 | INT32 | box level of the result: 1 short animation, else long (GTF:211-229) | total invested |

Client reaction: op 1 -> `openFrame`, op 2 -> `updateView` (animation then sends op 3), op 3 -> summary alert "Durante o tesouro dos deuses, você investiu {0}, lucro total {1}" and closes the frame.

Assumption: answer op 3 with the summary only when all grades are done; otherwise answer op 3 with op 1 data so the frame stays open (the client closes on op 3).

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Activity window | `SumActiveinfoMsg` type 145: start = beginDate + 120 s, end = endDate | FUN:552-556 |
| Last call | no investing in the last 180 s | GTF:335-344 |
| Cost per grade | `InvestDiamond` (non bound `point`) | GTF:324-329 |
| Grades | template rows with `phase >= 1`, keyed by `Grade` | GTT |
| Team | must not be in a free team | GTF:330-334 |

## 6. Templates

`GodTreasureTemInfo`: `phase`, `grade`, `InvestDiamond`, `ProfitDisplay` (`decompiled/core_module/scripts/yishi/datas/templates/GodTreasureTemInfo.as`). XML file missing from `raw/xml/tempinfos` (open question).

## 7. Persistent state

```sql
CREATE TABLE treasures.god_treasure_grades (
  grade           SMALLINT PRIMARY KEY,
  phase           SMALLINT NOT NULL,
  invest_diamond  INTEGER NOT NULL CHECK (invest_diamond > 0),
  profit_display  INTEGER NOT NULL,
  profit_min      INTEGER NOT NULL,
  profit_max      INTEGER NOT NULL
);

CREATE TABLE treasures.god_treasure_players (
  activity_id     TEXT NOT NULL,
  player_id       BIGINT NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  grade           SMALLINT NOT NULL DEFAULT 0,
  total_invested  INTEGER NOT NULL DEFAULT 0,
  total_profit    INTEGER NOT NULL DEFAULT 0,
  PRIMARY KEY (activity_id, player_id)
);
```

## 8. Backend implementation notes

`treasures::god_treasure::handle_open`, `handle_invest`, `handle_collect`. Invest: validate window, grade = stored grade + 1 exists, debit `point`, roll profit (assumption: random in [profit_min, profit_max] around `ProfitDisplay`), credit diamonds, increment grade, push 4968 op 2. One transaction.

## 9. Open questions and assumptions

- Dormant client path (no opener, null template cate); implement only with a client fix.
- Profit roll and `level` semantics (1 or 2 box tiers) are assumptions.

## 10. Implementation checklist

- [ ] Template table and loader
- [ ] Route 9546 ops 1, 2, 3
- [ ] Server message 4968 ops 1, 2, 3
- [ ] Tables `treasures.god_treasure_*`
- [ ] Tests: last 180 s block, grade progression, debit and credit
