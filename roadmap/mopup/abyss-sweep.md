# Abyss bot ("Modo Bot Abismo sem fim", "Bot do Abismo Sem Fim (Inferno)")

Feature [mopup](README.md), module `abyss-sweep`. Aliases in [README.md](README.md). The abyss activity itself (floors, bosses, formation, opcode 9644 ops 1 and 2) belongs to [abyss](../abyss/README.md); this module documents only its sweep ops.

## 1. Overview

- Help: "1. Seu maior Checkpoint é {0}, pode usar o modo bot para pular até o piso {1}. 2. Quando estiver offline também poderá usar o modo bot. ..." (`abysm.abysmView.mopupTip02`, `V/AbysmMopupPrepareFrame.as:108-116`).
- The player sweeps from the current floor up to a target floor below his record (`maxIndex - 1` by default); 30 s per floor (client constant `_mazeTime = 30`); results arrive per floor on 428.
- Two variants share the code: normal ("Abismo sem fim") and Hell ("Inferno", `isHorrible = true`, frames 17 and 18). The flag is sent in every 9644 request (`OYM:356-406`).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `V/AbysmMopupPrepareFrame.as` (7), `V/HellAbysmMopupPrepareFrame.as` (17) | "Modo Bot Abismo sem fim", "Bot do Abismo Sem Fim (Inferno)" | Target floor input, time, "desafiar manualmente" switch | `decompiled/m11/scripts/abysm/AbysmFrame.as:233`, `decompiled/m11/scripts/abysm/HellAbysmFrame.as:219` | `maxIndex`, `currentLayer`, time `(maxIndex - currentLayer) * 30` |
| `V/AbysmMopupIngFrame.as` (8), `V/HellAbysmMopupIngFrame.as` (18) | "Bot piso {0}" | Per floor results, accelerate, cancel | `AbysmModel.mopupCount` set from 423 `sweepIndex > 0` (`decompiled/core_module/scripts/mvc/module/outyard/AbysmModel.as:126-156`) | `mopupList` from 428 |

## 3. Routes (client to server)

All requests: 9644 (0x25ac) `C_GUARDENDLESS_OP`, `GuardendlessOpMsg` (package `guardendless`, full field list in [abyss](../abyss/README.md)): fields used here `opType` (#1, INT32), `sweepIndex` (#11, INT32), `payType` (#13, INT32), `isHorrible` (#15, BOOL), `index` (#5, INT32).

| opType | Sender | Meaning | Client checks |
|---|---|---|---|
| 3 | `OYM.abysmSendInfo(3)` from the prepare frame "desafiar manualmente" (`V/AbysmMopupPrepareFrame.as:155-163`) | manual challenge of the current floor (`index` = current index), not a sweep | daily skip confirm "Deseja desafiar Checkpoint manualmente?" |
| 4 | `OYM.sendMopup(target + 1)` (`OYM:389-397`) from `V/AbysmMopupPrepareFrame.as:164-210` | start sweep, `sweepIndex` = target floor + 1 | anti addiction (AAS 3 h) "Você está no estado anti-tonturas, não poderá usar BOT!"; target > 0; target >= current ("Número de bot deve ser maior que o número atual de Checkpoints."); target <= max ("Os checkpoints devem ser inferiores ao número máximo de Bot.") |
| 5 | `OYM.sendMopupOP(5, payType)` (`V/AbysmMopupIngFrame.as:341-385`) | accelerate; payType 1 diamonds (also used for free elf contract), 0 bound first | cost `mopupCount - currentFloor` diamonds (1 per floor) |
| 6 | `OYM.sendMopupOP(6, 0)` on frame dispose (`V/AbysmMopupIngFrame.as:561-566`) | stop | cancel confirm |
| 7 | `OYM.sendMopupOP(7, 0)` every 5 s (`V/AbysmMopupIngFrame.as:398-410`) | poll | - |

## 4. Server messages (server to client)

### 423 (0x01a7) `U_C_GUARDENDLESS_INFO`

- `GuardendlessOpMsg`; for the sweep: `sweepIndex` (#11) target (> 0 while sweeping, makes the client open frame 8/18), `plies` (#6) current floor, `maxIndex` (#7) record, `items` (#9) and `isFinishes` (#14). Receiver `OYM.__abysmHandler` -> `AbysmModel.abysmInfoHandler` (`AbysmModel.as:69-119`).

### 428 (0x01ac) `U_C_GUARD_REWARD`

- `GuardEndlessItemMsg`: `type` (#1, INT32) 2 = sweep floor result; `count` (#2, INT32) floor number; `items` (#3, STRING) rewards (format shared with the abyss drop strings). Receiver `OYM.__rewarldHandler` (`OYM:221-235`) appends to `mopupList`.
- When: one per finished floor, on poll (op 7) and on accelerate.

### 427 (0x01ab) `U_C_GUARD_ONFIGHT`

- `GuardOnFightMsg` (package `battle`): `guardId` (#1). Abyss battle state, not sweep specific (`OYM:213-219`).

## 5. Rules and formulas

- 30 s per floor; accelerate 1 diamond per remaining floor; free with elf contract buff 4.
- Drops per floor: `GuardEndlessDrop.xml` (normal), `GuardEndlessHorribleDrop.xml` (hell), owned by [abyss](../abyss/README.md).

## 6. Templates

`raw/xml/tempinfos/GuardEndlessDrop.xml`, `GuardEndlessHorribleDrop.xml` (owner [abyss](../abyss/README.md)).

## 7. Persistent state

Uses `mopup.sweep_job` with `source` = `abyss` or `hell_abyss`, `target_index` = target floor, `run_seconds` = 30 ([campaign-sweep.md](campaign-sweep.md)).

## 8. Backend implementation notes

- `mopup::abyss_sweep::handle_start` (op 4), `handle_accelerate` (op 5), `handle_stop` (op 6), `handle_poll` (op 7) are called by the abyss 9644 dispatcher. Each finished floor: roll the floor drop, grant, push 428, update `plies`.
- At login or abyss open, include `sweepIndex` in 423 so the client reopens the in progress frame.

## 9. Open questions and assumptions

- Whether bosses on swept floors are skipped or auto won.
- `payType` encoding identical to [campaign-sweep.md](campaign-sweep.md) (assumed).

## 10. Implementation checklist

- [ ] Screens: abyss and hell prepare / in progress frames
- [ ] Route op 4 start
- [ ] Route op 5 accelerate
- [ ] Route op 6 stop
- [ ] Route op 7 poll
- [ ] Server messages 423 (`sweepIndex`), 428 type 2
- [ ] `mopup.sweep_job` rows for abyss
- [ ] Test: target above record refused
