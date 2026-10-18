# Old players privileges ("Privilégios dos Velhos Jogadores")

Module `regress` of feature `returning-players`. Protobuf package `regress`.

Path aliases:

| Alias | File |
|---|---|
| RGM | `decompiled/core_module/scripts/yishi/manager/RegressManager.as` |
| RGF | `decompiled/m11/scripts/regress/RegressFrame.as` |
| RGI | `decompiled/m11/scripts/regress/RegressItem.as` |

## 1. Overview

A new character created on the target server by an old player receives part of the old recharge total (`canTakeTotalCount`) as diamonds through milestones: reaching levels 20/30/40/50 and logging in 2/3/5 days, plus a recharge share (template Types 1). If the player is on the wrong server the frame says "Parabéns você ganhou o privilégio do velho jogador, favor usar a mesma conta e entrar no servidor {0} criando um personagem novo para ativar ganhos." (`targetSite`).

Status: the controller `regress` (`decompiled/core_module/scripts/yishi/manager/FrameControllerManager.as:1698-1699`) has no opener in this client (toolbar `regress` opens `oldbacker`). The push 340 is still handled and makes the toolbar `regress` button shine when a milestone is claimable (RGM:60-79, `TopToolsBar.as:935-937`).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `RegressFrame` (RGF) | "Privilégios dos Velhos Jogadores" | milestones and recharge share | controller `regress` (no caller) | `chargeCanTakeCount`, `takedCount`, remaining time from `overDate` (RGF:210-255), not open text when `!states` |
| `RegressItem` (RGI) | "Nível atingiu {0} ({1}/{2})", "{0}º de Login ({1}/{2})" | milestone row | RGF | amount `TakePercent * canTakeTotalCount / 100` or `TakeData` (RGI:70-95) |

## 3. Routes (client to server)

C>S 9593 (0x2579) `C_REGRESS_TAKE`, `RegressRecordMsg`, sender `RGM.OperatePoker(templateId)` (RGM:104-110): `takeTemplateId (#1, INT32)` milestone template; other fields `takeNum (#2)`, `isFinish (#3)`, `isTakeReward (#4)` unused.

- Milestone receive button (RGI:126); recharge share receive button sends the Types 1 template id found in `info` (RGF:186-201), enabled when `chargeCanTakeCount > 0`.
- Server: validate finished and not taken, credit diamonds, push 340.

## 4. Server messages (server to client)

### S1. 340 (0x0154) `U_C_REGRESS_INFO`, `RegressRecordListMsg`
Receiver RGM:50-58.

| Field | Tag | Type | Meaning |
|---|---|---|---|
| `info` | #1 | `RegressRecordMsg`, repeated | `takeTemplateId (#1, INT32)`, `takeNum (#2, INT32)`, `isFinish (#3, BOOL)`, `isTakeReward (#4, BOOL)` |
| `chargeCanTakeCount` | #2 | INT32 | recharge share available now |
| `takedCount` | #3 | INT32 | already received |
| `canTakeTotalCount` | #4 | INT32 | total inheritable amount |
| `loginDateCount` | #5 | INT32 | login days on the new character |
| `overDate` | #6 | STRING | end date |
| `states` | #7 | BOOL | false = wrong server, show `targetSite` |
| `targetSite` | #8 | STRING | server to create the character on |

## 5. Rules and formulas

`RegressTemplateInfos.xml`: Types 2 (level) 20/30/40/50 -> 5/5/10/15 %; Types 3 (login) 2/3/5 days -> 5/10/20 %; Types 1 (recharge share) 30 %. Amount = `TakePercent * canTakeTotalCount / 100` (RGM:86-102, RGI:91-93).

## 6. Templates

`RegressTemplateInfos.xml`: `TemplateId`, `Types`, `NeedGrades`, `NeedCharge`, `LoginCount`, `TakePercent`, `TakeData`.

## 7. Persistent state

```sql
CREATE TABLE returning_players.regress_grants (
  player_id       BIGINT PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
  total_amount    INTEGER NOT NULL,
  taken_amount    INTEGER NOT NULL DEFAULT 0,
  target_site     TEXT NOT NULL,
  ends_at         TIMESTAMPTZ NOT NULL
);

CREATE TABLE returning_players.regress_takes (
  player_id       BIGINT NOT NULL REFERENCES returning_players.regress_grants(player_id) ON DELETE CASCADE,
  template_id     INTEGER NOT NULL,
  taken_at        TIMESTAMPTZ NOT NULL DEFAULT now(),
  PRIMARY KEY (player_id, template_id)
);
```

## 8. Backend implementation notes

Handler `returning_players::regress::handle_take`. The grant is created from the old account's recharge total (shared account store) when the account creates a character on `target_site`.

## 9. Open questions and assumptions

- No client opener; recharge share accrual rule (Types 1 30 %) timing is unknown.

## 10. Implementation checklist

- [ ] Server message 340 at login for eligible accounts
- [ ] Route 9593
- [ ] Tables `returning_players.regress_*`
- [ ] Screen `RegressFrame` only if an opener is added
- [ ] Tests: percent math, single take per milestone
