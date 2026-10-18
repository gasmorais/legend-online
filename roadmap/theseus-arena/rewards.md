# Theseus arena: tasks, glory track and shop

Module `theseus_arena::rewards`. Prefixes as in [README.md](README.md).

## 1. Overview

Three reward systems per mode:

1. **Tasks** (`TPL/TheseusPvpRewardTmpls.xml`, `TPL/TheseusMultiPvpRewardTmpls.xml`): Area 1 daily (match N times, win N times), Area 2 stage reached in the season, Area 3 final rank of the season. Viewed with op 13 (push 4313 / 576), claimed with op 7.
2. **Glory track** ("Prêmio do Valente" single, "Prêmio da Glória" MP; `TPL/SpecialRewardTmpls.xml` Type 1 / Type 5): gears unlocked by accumulated honor (currency 60 single from item 7640002 "Glória da Arena"; currency 69 MP from item 7650004 "Emblema da Glória"). Each gear has a free reward and a paid reward; the paid lane is unlocked once per season with diamonds (`specialrewar_theseus_diamonds` = 1500, MP `specialrewar_theseus_multi_diamonds` = 2000). Ops 9 (unlock), 10 (claim gear), 11 (claim all).
3. **Shop** "Loja da Arena" (`shop` openType 1027, currency 59 "Mérito de Teseu" 7640001; MP merit 7650003), stage gated by template `OpenShop` (see [../shops/catalog.md](../shops/catalog.md)).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `theseuspvp.TheseusPvpRewardFrame` | Prêmios | tabs Area 1/2/3; header "Pontos atuais: {0}", "Graduação atual: {0}", "Maior da Temporada: {0}"; rows with progress "(data/TaskNum)", claim button by `state` | scene bottom reward button (`REWARD`); sends op 13 on open | 4313 (`M3/theseuspvp/TheseusPvpRewardFrame.as:57-200`; `M3/theseuspvp/item/TheseusPvpRewardItem.as:87-226`) |
| `theseusdoublepvp.TheseusDoublePvpRewardFrame` | | same for MP (op 13 on open) | `REWARDDOUBLE` | 576 (`M3/theseusdoublepvp/TheseusDoublePvpRewardFrame.as:63`) |
| `theseusDoublepvpscene.view.TheseusBoxItem` (x4) | | daily task boxes in the MP room top bar | room | 576 |
| `theseuspvp.TheseusGloryRewardFrame` | Prêmio do Valente | "A Glória da Arena é obtida com as recompensas diárias da Arena de Teseu"; honor amount (currency 60); lanes "Recompensa Normal" / "Recompensa Avançada"; per gear claim; claim all | scene right `PRIVATE` | `specialInfo`, `openPaySpecial`, currency 60 (`M3/theseuspvp/TheseusGloryRewardFrame.as:67-250`; items `M3/theseuspvp/item/TheseuspvpPrivateItem.as:78-160`, `M3/theseuspvp/item/TheseuspvpPrivateCItem.as:41-95`) |
| `theseusdoublepvp.TheseusDoubleGloryRewardFrame` | Prêmio da Glória | same for MP ("O Emblema da Glória é obtido através do prêmio diário da Arena Multiplayer de Teseus"), currency 69 | `PRIVATE_DOUBLE` | `M3/theseusdoublepvp/TheseusDoubleGloryRewardFrame.as:112-240` |

## 3. Routes (client to server)

9712 (single) / 9736 (MP), `PlayerOpMsg`.

| # | Action | UI control | Client sender | Client checks | Request | Responses |
|---|---|---|---|---|---|---|
| W1 | View tasks | frame open; MP room top view creation | `TheseusPvpRewardFrame()` (`:63`), `TheseusDoublePvpRewardFrame()` (`:63`), `TheseusRoomReadyTopView()` (`:85`) | none | `{op:13}` | 4313 / 576 |
| W2 | Claim task | row claim button (state 1) | `TheseusPvpRewardItem.getHandler` (`:87-93`), MP item and `TheseusBoxItem` | button enabled only in state 1 | `{op:7, id:taskId}` | 4313 / 576 with state 2, 4312 / 575 (`redReward`), item and currency updates |
| W3 | Unlock advanced lane | `TheseuspvpPrivateCItem` unlock, confirm `theseuspvp.gloryAdvanceAlert` "Gastar {0} diamantes para desbloquear Recompensa Avançada da arena?" | `__alertResponse` (`TheseuspvpPrivateCItem.as:79-95`) | none client side for diamonds | `{op:9}` | 4312 / 575 `openPaySpecial = true`, diamond update |
| W4 | Claim a gear | gear claim | `TheseuspvpPrivateItem.getClickHandler` (`:78-84`) | enabled when honor >= `NeedNum` and gear not in `specialInfo` | `{op:10, id:Gear}` | 4312 / 575 with the gear added to `specialInfo`, items |
| W5 | Claim all gears | one key button | `TheseusGloryRewardFrame.oneKeyHandler` (`:202-205`) | enabled when at least one gear claimable (`:154-200`) | `{op:11}` | 4312 / 575, items |

## 4. Server messages (server to client)

| Opcode | Hex | Name | Body | Receiver |
|---|---|---|---|---|
| 4313 | 0x10D9 | `U_C_THESEUS_PVP_REWARD` | `TheseusPvpRewardListMsg` | `__rewardInfosHandler` (`TPM:264-280`), notification `theseuspvpRewardEvent` |
| 576 | 0x0240 | `U_C_THESEUS_PVPDOUBLE_REWARD` | `TheseusMultiPvpRewardListMsg` | `__rewardInfosDoubleHandler` (`TPM:501-517`) |

Fields: `op` (#1, INT32, echo), `rewards` (#2, repeated `TheseusPvpRewardMsg` / `TheseusMultiPvpRewardMsg`: `templateId` #1 task id, `data` #2 progress, `state` #3: 0 in progress, 1 claimable, 2 claimed). Area 3 rows show no button (rank rewards are mailed at season end, A).

`specialInfo` format in the user message: "gear,x|gear,x|" (only the gear number before the comma is read, `TheseusGloryRewardFrame.as:165-183`; A: x = lane flags).

## 5. Rules and formulas

| # | Rule | Source |
|---|---|---|
| G1 | Single tasks: Area 1 "Combinar na Arena 5x/10x" (TaskType 1 matches) -> 7640002 x50/x100; "Ganhar na Arena 1x..10x" (TaskType 2 wins) -> 7640002 x2 each; Area 2 stage reached (TaskType 6, TaskNum = stage id 11..61) -> 7640001 x100..2000; Area 3 final rank (TaskType 7, "1", "2", "3", "4,10", ..., "51,9999") -> 2127023 "Pedra de Fort. do Núcleo" x1000..200 plus title cards 7640101..7640103 for top 3 | `TPL/TheseusPvpRewardTmpls.xml` |
| G2 | MP tasks: matches 2/4/6/10 -> 7650004 x30..100; stage (TaskNum = MP stage id 4, 7, 10, 13, 16) -> 7450001 "Pedra de Temperamento Divino" x1000..3000; rank -> 7460003 x100..20 | `TPL/TheseusMultiPvpRewardTmpls.xml` |
| G3 | Daily tasks reset daily (A: 00:00); stage tasks once per season | |
| G4 | Glory gears single (Type 1, 15 gears): `NeedNum` 100..2550 of honor (currency 60, item 7640002), `FreeReward`, `PayReward` (paid lane); MP (Type 5, 15 gears): 100..1500 of currency 69 (item 7650004). Types 2, 3, 4 belong to the year 2023 event (`decompiled/m3/scripts/year2023/view/*.as`) | `TPL/SpecialRewardTmpls.xml` |
| G5 | Unlock cost 1500 / 2000 diamonds, once per season (A) | config |
| G6 | Shop item unlock by stage `OpenShop` ("Libera com {0}") | `TPL/TheseusPvpTmpls.xml`; LANG `theseuspvp.shopLockTip` |

## 6. Templates

| File | Record | Fields |
|---|---|---|
| `TPL/TheseusPvpRewardTmpls.xml` (25) / `TPL/TheseusMultiPvpRewardTmpls.xml` (16) | tasks | `Id`, `Name`, `Area`, `TaskType` (1 match, 2 win, 6 stage, 7 rank), `TaskNum`, `Reward` "item,count\|...", `Sort` |
| `TPL/SpecialRewardTmpls.xml` Type 1 / 5 | glory gears | `Gear`, `NeedItem`, `NeedNum`, `FreeReward`, `PayReward`, `RandReward`, `IsTips` |

## 7. Persistent state

```sql
CREATE TABLE theseus_arena.task_progress (
  mode            smallint NOT NULL,
  season_id       integer NOT NULL,
  player_id       integer NOT NULL REFERENCES player.players(player_id),
  task_id         integer NOT NULL,
  period_day      date,                                -- null for season tasks
  progress        integer NOT NULL DEFAULT 0,
  state           smallint NOT NULL DEFAULT 0 CHECK (state BETWEEN 0 AND 2),
  PRIMARY KEY (mode, season_id, player_id, task_id)
);

CREATE TABLE theseus_arena.glory_claim (
  mode            smallint NOT NULL,
  season_id       integer NOT NULL,
  player_id       integer NOT NULL REFERENCES player.players(player_id),
  gear            smallint NOT NULL,
  free_claimed    boolean NOT NULL DEFAULT false,
  paid_claimed    boolean NOT NULL DEFAULT false,
  claimed_at      timestamptz NOT NULL DEFAULT now(),
  PRIMARY KEY (mode, season_id, player_id, gear)
);
```

`paid_lane_open` is in `player_state` ([season.md](season.md)).

## 8. Backend implementation notes

- `theseus_arena::rewards::handle_view` (op 13), `handle_claim_task` (op 7: state must be 1; grant `Reward`; set 2), `handle_unlock_paid` (op 9: debit diamonds once), `handle_claim_gear` (op 10: honor >= `NeedNum`; grant free reward and, if the lane is open, the paid reward; if the lane opens later, a second claim grants the paid part, A), `handle_claim_all` (op 11).
- Update task progress on every match (TaskType 1) and win (TaskType 2) and stage change (TaskType 6); recompute `redReward`.
- Season settlement: Area 3 by final rank, by mail.

## 9. Open questions and assumptions

- (A) Second component of `specialInfo` entries; claim of the paid part after a late unlock.
- (A) Honor source: daily task rewards give item 7640002 which converts to currency 60.

## 10. Implementation checklist

- [ ] Ops 7, 9, 10, 11, 13 for both modes
- [ ] 4313 / 576
- [ ] Tables `task_progress`, `glory_claim`
- [ ] Season rank rewards by mail
- [ ] Tests: claim twice, claim gear without honor, unlock twice
