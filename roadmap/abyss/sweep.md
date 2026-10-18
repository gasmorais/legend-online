# Abyss sweep ("Modo Bot Abismo sem fim")

Feature `abyss`, module `sweep`. Client: `M5/mopup/view/AbysmMopupPrepareFrame.as`, `AbysmMopupIngFrame.as`, `HellAbysmMopupPrepareFrame.as`, `HellAbysmMopupIngFrame.as` (package registered to the mopup feature), `CM/yishi/manager/OutyardManager.as:98, 222-238, 389-407`, `CM/mvc/module/outyard/AbysmModel.as:121-156`. Conventions: see [README.md](README.md).

---

## 1. Overview

- Below his record the player sweeps floors instead of fighting: the server resolves one floor every 30 seconds and grants its drops.
- Prepare frame: "Seu maior Checkpoint é {record}, pode usar o modo bot para pular até o piso {record}." with an input (default `maxIndex - 1`) and the estimated time `(target - current + 1) x 30 s`. Start sends op 4 with `sweepIndex = target + 1`. A "change" button challenges manually instead (op 3, [abyss-tower.md](abyss-tower.md) A5). Sweeping works offline too (help text).
- When 423 arrives with `sweepIndex > 0` the client opens the progress frame (normal `mopup` 8, hell `mopup` 18). The progress frame polls the server every 5 s (op 7); every finished floor arrives as 428 and is listed ("Bot piso {n}" with the items). Accelerate finishes the remaining floors for 1 diamond each (op 5), free of confirmation with king contract buff 4. Closing the frame stops the sweep (op 6).

---

## 2. Screens

| Class (file) | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `mopup.view.AbysmMopupPrepareFrame` (`M5/mopup/view/AbysmMopupPrepareFrame.as`), `mopup` openType 7 | "Modo Bot Abismo sem fim" (`abysm.abysmView.mopupTip01`) | Choose the sweep target | "Desafiar" below the frontier (`M11/abysm/AbysmFrame.as:231-234`) | Tip `abysm.abysmView.mopupTip02` with `maxIndex - 1` (`:123-132`); target input; estimated time; start and manual challenge buttons |
| `mopup.view.HellAbysmMopupPrepareFrame`, openType 17 | "Bot do Abismo Sem Fim (Inferno)" (`abysm.abysmView.mopupTip03`) | Same for hell | `HellAbysmFrame.as:217-220` | Same |
| `mopup.view.AbysmMopupIngFrame` (`M5/mopup/view/AbysmMopupIngFrame.as`), openType 8 | "Modo Bot Abismo sem fim" | Progress | `AbysmModel.mopupCount` setter when `sweepIndex > 0` (`CM/mvc/module/outyard/AbysmModel.as:131-156`) | Remaining time `(mopupCount - layer) x 30` s (`:197-213`); one block per finished floor "Bot piso {count}" with coloured item names from `items` (`:215-296`); current floor "lutando"; end state when `mopupCount == layer` (`:327-340`); accelerate, cancel, end buttons; sets `MopupModel.isMopup` (tool bars in bot mode) |
| `mopup.view.HellAbysmMopupIngFrame`, openType 18 | "Bot do Abismo Sem Fim (Inferno)" | Same for hell | same | Same |

---

## 3. Routes (client to server)

Opcode **9644 (0x25ac) C_GUARDENDLESS_OP**, body `guardendless.GuardendlessOpMsg` (fields in [abyss-tower.md](abyss-tower.md) §3). Every request carries `isHorrible (#15, BOOL)`.

| # | UI control | Client sender (file:line) | Client checks | Request | Expected response |
|---|---|---|---|---|---|
| S1 | "Iniciar" of the prepare frame | `AbysmMopupPrepareFrame.__startMopupHandler` (`M5/mopup/view/AbysmMopupPrepareFrame.as:171-212`) → `OutyardManager.sendMopup(target + 1)` (`CM/yishi/manager/OutyardManager.as:389-397`); clears `mopupList` | Not in anti-addiction state with 3 h or more ("Você está no estado anti-tonturas, não poderá usar BOT!"); target > 0; target >= current floor; target <= `maxIndex` (tips `mopup.view.RemoteMopupPrepareFrame.layerTipData1..3`) | `{opType=4, sweepIndex=target+1, isHorrible}` | **423** with `sweepIndex` set (opens the progress frame) |
| S2 | Timer every 5 s of the progress frame | `AbysmMopupIngFrame.__timeCompleteHandler` (`M5/mopup/view/AbysmMopupIngFrame.as:401-411`) → `sendMopupOP(7, 0)` (`OutyardManager.as:399-407`) | none | `{opType=7, payType=0, isHorrible}` | **428** for every floor finished since the last poll; **423** when the state changed *(assumption)* |
| S3 | "Acelerar" | `AbysmMopupIngFrame.__accelerateHandler` (`:342-364`) → `accelerateBack` (`:366-387`) | Not finished ("Modo Bot encerrado"); with king contract buff 4: no confirmation, `payType = 1`; else confirmation "Aceleramento consome {remaining floors} diamantes" with the bound diamond option: `payType = 0` when the bound option is chosen, `1` otherwise | `{opType=5, payType, isHorrible}` | **428** for all remaining floors, **423** with `sweepIndex = 0`, currency push |
| S4 | Closing the progress frame (cancel with confirmation `mopup.view.MazeMopupIngFrame.alertContent`, end button, or any dispose) | `AbysmMopupIngFrame.dispose` (`:563-575`) → `sendMopupOP(6, 0)` | Confirmation while not finished (`:389-399, 455-471`) | `{opType=6, payType=0, isHorrible}` | **423** with `sweepIndex = 0` |

---

## 4. Server messages (server to client)

| Opcode | Name | Message, fields | Client receiver (file:line) | When | Client reaction |
|---|---|---|---|---|---|
| **428 (0x01ac)** | U_C_GUARD_REWARD | `guardendless.GuardEndlessItemMsg`: `type (#1, INT32)` 2 = sweep floor result (other values ignored); `count (#2, INT32)` floor number just swept; `items (#3, STRING)` "tid,count\|tid,count" | `OutyardManager.__rewarldHandler` (`CM/yishi/manager/OutyardManager.as:98, 222-238`) | One message per swept floor, in order (S2 polls, S3) | Appends `{count, items}` to `mopupList` and redraws the progress list |
| 423 (0x01a7) | U_C_GUARDENDLESS_INFO | `GuardendlessOpMsg`; `sweepIndex (#11)` = sweep target + 1 while a sweep runs, else 0; `plies (#6)` floor reached | `AbysmModel.abysmInfoHandler` (`CM/mvc/module/outyard/AbysmModel.as:69-119`) | After S1, S3, S4, at sweep completion, and on op 1 when a sweep is running (reopens the progress frame after a relog) | `mopupCount` change > 0 opens the progress frame 200 ms later |
| Bag and currency pushes | inventory, currency | | | With each 428 | |

---

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Time per floor | 30 s | `AbysmMopupPrepareFrame.as:127` (`_mazeTime`), `AbysmMopupIngFrame.as:205` |
| Target range | `current floor <= target <= maxIndex`; request carries `target + 1` | `:171-212` |
| Accelerate cost | 1 diamond per remaining floor (`mopupCount - layer`); bound diamonds allowed when `payType = 0`; king contract buff 4 skips the alert | `AbysmMopupIngFrame.as:342-387` |
| Offline | Sweep continues offline | `abysm.abysmView.mopupTip02` item 2 |
| Rewards | Drops of each swept wave of the floor *(assumption: the 7 waves of the floor, rolled like a manual win)* | |
| Blocked actions | While sweeping, the tool bars switch to bot mode (`model.isMopup`); fights and formation saves are refused *(assumption)* | `AbysmMopupIngFrame.as:197-199, 563-575` |
| Scene | Sweep not allowed in some scenes ("No cenário atual não é possível usar o Modo BOT") *(owned by the mopup feature)* | |

---

## 6. Templates

Same drop tables as [abyss-tower.md](abyss-tower.md) §6.

---

## 7. Persistent state (PostgreSQL, schema `abyss`)

```sql
CREATE TABLE abyss.sweeps (
  player_id     integer     NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  is_hell       boolean     NOT NULL,
  start_floor   integer     NOT NULL CHECK (start_floor >= 1),
  target_floor  integer     NOT NULL CHECK (target_floor >= start_floor),
  next_floor    integer     NOT NULL,              -- next floor to resolve
  started_at    timestamptz NOT NULL DEFAULT now(),
  next_due_at   timestamptz NOT NULL,              -- started_at + 30 s per resolved floor
  PRIMARY KEY (player_id, is_hell)
);

CREATE TABLE abyss.sweep_results (
  player_id   integer     NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  is_hell     boolean     NOT NULL,
  floor       integer     NOT NULL,
  items       text        NOT NULL,                -- "tid,count|..." as sent in 428
  delivered   boolean     NOT NULL DEFAULT false,  -- 428 already sent
  created_at  timestamptz NOT NULL DEFAULT now(),
  PRIMARY KEY (player_id, is_hell, floor)
);
```

---

## 8. Backend implementation notes

| Handler | Route | Validation order | Transaction and pushes |
|---|---|---|---|
| `abyss::sweep::handle_start` | 9644 op 4 | progress exists, not finished, no sweep running, `target = sweepIndex - 1`, `floor <= target <= max_floor` *(assumption: `max_floor` already includes +1)*, player not in anti-addiction lock | Insert `sweeps` (`next_due_at = now + 30 s`). Send 423 with `sweepIndex` |
| `abyss::sweep::handle_poll` | 9644 op 7 | sweep exists | Resolve every floor with due time `<= now`: one tx per floor: roll drops, grant items, insert `sweep_results`, advance `progress` (wave and floor), `next_floor += 1`. Send 428 per undelivered result, mark delivered. When `next_floor > target` delete the sweep and send 423 with `sweepIndex = 0` |
| `abyss::sweep::handle_accelerate` | 9644 op 5 | sweep exists; cost = remaining floors; king contract buff 4 *(assumption: free)*; diamonds (bound first when `payType = 0`) | One tx: debit, resolve all remaining floors as above. Send 428s, 423, currency push |
| `abyss::sweep::handle_stop` | 9644 op 6 | none | Resolve due floors (deliver 428), delete the sweep. Send 423 with `sweepIndex = 0` |
| `abyss::sweep::offline_job` | timer | | Resolve due floors of offline players so that progress continues offline; results are delivered at the next poll |

---

## 9. Open questions and assumptions

- *(assumption)* Exact meaning of `payType` 0/1 and the king contract buff 4 price.
- *(assumption)* Rewards per swept floor and whether swept floors raise anything besides `plies`.
- Whether op 6 cancels the floors not yet resolved (the client sends op 6 even after the natural end).

---

## 10. Implementation checklist

- [ ] Tables `abyss.sweeps`, `abyss.sweep_results`.
- [ ] Routes 9644 ops 4, 5, 6, 7 with validation.
- [ ] 428 per floor, 423 transitions (`sweepIndex`).
- [ ] Offline resolution job.
- [ ] Screen check: prepare frame limits, progress list, accelerate alert cost, end state.
- [ ] Test: start sweep to floor 5 from floor 2, poll after 95 s returns floors 2, 3, 4.
- [ ] Test: accelerate charges the remaining floors and completes the sweep.
