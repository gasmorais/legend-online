# Vice hero, secondary password and item lock (Senha, Bloqueio de Itens)

Path aliases:

| Alias | File |
|---|---|
| VPU | `decompiled/core_module/scripts/mainBar/vicePassword/VicePasswordUtil.as` |
| SET | `decompiled/core_module/scripts/mainBar/vicePassword/SetVPView.as` |
| CHG | `decompiled/core_module/scripts/mainBar/vicePassword/ChangeVPView.as` |
| CNF | `decompiled/core_module/scripts/mainBar/vicePassword/ConfirmVPView.as` |
| VPC | `decompiled/core_module/scripts/mvc/controler/VicepasswordController.as` |
| PM | `decompiled/core_module/scripts/yishi/manager/PlayerManager.as` |
| BH | `decompiled/core_module/scripts/bag/helper/BagHelper.as` |
| AF | `decompiled/m5/scripts/armyII/ArmyFrameII.as` |

## 1. Overview

Two unrelated systems share the "vice" prefix in the protocol:

1. Vice hero (`viceplayer.ViceHeroOpMsg`): a second hero object `army.viceHero` with `ThaneInfo.isViceHero`. The BR client never sends `ViceHeroOpMsg`; `isViceHero` is only set by the Day Light mode (`decompiled/core_module/scripts/mvc/controler/DayLightController.as:188`) and `ThaneInfoHelper.currentThane` returns the vice hero when it is flagged (`decompiled/core_module/scripts/com/road/pb/helper/army/ThaneInfoHelper.as:549-556`). No route is needed for BR; the message is documented for completeness.
2. Secondary password ("Senha", 6 digits) protecting locked items, Einherjar, monsters and Theseus items ("Bloqueio de Itens"). The player sets, confirms (once per session), changes or requests a reset (3 days without the lock). Locked objects cannot be sold, moved out or consumed until unlocked.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `SetVPView` (SET) | "Senha" | Set a new password (two inputs) | hero frame "Senha" button when no password (`openControllerByInfo("vicepassword", 1)`, AF:625-651) | |
| `ChangeVPView` (CHG) | | Change (old, new, confirm) or request reset ("72 horas após o reset, o bloqueio de itens será desativado, tem que a certeza de que quer fazer reset?") | "Senha" button when a password exists (`vicepassword`, 2) | |
| `ConfirmVPView` (CNF) | "Favor inserir senha" | Enter the password for the session | lock button when not yet confirmed (`vicepassword`, 3, AF:614-621) | |
| Lock cursor mode (`BagHelper.vpLockBtnClickHandler`) | "Bloqueio de Itens" (`mainBar.SmallMapBar.vicepasswordBtnTipData`), "Bloquear" | Click items to toggle lock | hero frame lock button, level >= 10 (AF:568-623) | cursor `VICE_PASSWORD_LOCK` |

Blocking messages shown elsewhere: "O item atual foi bloqueado, favor desbloquear", "O Einherjar atual foi bloqueado, por favor desbloqueie", "A campanha de Einherjar atual foi bloqueada, por favor desbloqueie", "Apenas poderá vender, após desbloquear itens", "O Cosmo atual já foi bloqueado, favor desbloquear" (`vicepassword.description2`, `3`, `4`, `10`, `11`).

## 3. Routes (client to server)

### R1. Password operations
- Client path: `VPU.vpOp(op, input, new, pre)` (VPU:28-38).
- Route: send 8806 (0x2266) `C_VICEPASSWORD`, `VicePasswordMsg` (player): `op_type` (#1, INT32), `input_pass` (#2, STRING), `pre_pass` (#3, STRING), `new_pass` (#4, STRING), `result` (#5, INT32) response only. Unused strings are sent as "0".

| `op_type` | Constant | Sender | Fields | Client checks |
|---|---|---|---|---|
| 1 | `CHECK_PW` | CNF:133-136 | `input_pass` | 6 digits (`strCheck`) else "O formato da senha introduzida está incorrecto"; empty → "Favor inserir senha" |
| 2 | `SET_PW` | SET:306 | `input_pass`, `new_pass` (confirmation) | 6 digits ("Favor inserir 6 algarismos"), digits only ("A senha contém outros simbolos,  só pode introduzir algarismos."), equal ("Ambas as senhas não correspondem"), not 6 repeated digits ("Cannot contain 6 repeated numbers."), not a 6-digit run ("Cannot contain 6 consecutive numbers.") (VPU:51-104) |
| 3 | `CHANGE_PW` | CHG:304 | `pre_pass` old, `input_pass` new, `new_pass` confirmation | same rules; "Favor inserir senha velha", "Favor inserir nova senha" |
| 4 | `RESET_PW` | CHG:199 | none | confirm (description5) |

- Response: 4696 (S1).
- Client gate: all lock/password buttons require hero level >= 10 and are blocked during a reset period ("Durante o periodo de reset à senha, não pode realizar nenhuma operação", AF:572-583).

### R2. Lock or unlock an object
- UI: lock cursor mode, click a target (BH:315-365, others listed below). The op toggles the lock *(assumption: same op locks and unlocks)*.
- Client path: `VPU.vpLockOp(op, itemPos, petId)` (VPU:40-49).
- Route: send 8809 (0x2269) `C_LOCK_OR_UNLOCK`, `LockAndUnlockMsg` (player): `op_type` (#1, INT32), `item_pos` (#2, INT32), `pet_id` (#3, INT32) object id for non-bag objects.

| `op_type` | Target | Sender |
|---|---|---|
| 1 | player bag item (`item_pos`) | BH:336 |
| 2 | Einherjar (`pet_id`) | `decompiled/m14/scripts/pet/property/PetShowView.as:228` |
| 3 | equipped hero item | BH:360 |
| 4 | equipped honor item (`HonorCell`) | BH:356 |
| 5 | storehouse item | BH:328 |
| 6 | battle monster (`pet_id` = monster id) | `decompiled/m14/scripts/monster/view/MonsterPropView.as:282` |
| 7 | rune gem bag item (bag 401/40) | BH:332, `decompiled/m5/scripts/armyII/viewII/stone/item/RuneCellMenu.as:93` |
| 8 | Theseus treasure cell (`item_pos`) | `decompiled/m5/scripts/theseus/TheseusBagHelper.as:114` |
| 9 | Theseus war equipment / insignia (`pet_id` = item id) | `TheseusBagHelper.as:152`, `:172` |
| 11 | Theseus item (`pet_id` = id) | `TheseusBagHelper.as:99` |
| 13 | Theseus outer treasure item (`item_pos`) | `TheseusBagHelper.as:132` |

- Response: item/pet update pushes carrying the lock flag (e.g. `SimpleItemInfoMsg.is_locked` #36 for items) owned by each feature *(assumption: no dedicated response opcode exists; no client listener for 8809)*.

### R3. Vice hero operation (no client sender)
- `ViceHeroOpMsg` (viceplayer): `op_type` (#1, INT32), `pay_type` (#2, INT32), `property1` (#3, INT32), `property2` (#4, INT32), `property3` (#5, STRING), `property4` (#6, STRING). No opcode constant references it in the BR client. Do not implement unless a client sends it.

## 4. Server messages (server to client)

### S1. 4696 (0x1258) `U_C_VICEPASSWORD` (name from `AcceptProtocolType.as:1086`, absent in opcodes.csv)
- `VicePasswordMsg`: `op_type` (#1) echo, `result` (#5, INT32).
- Receiver: `PM.__vicePassword` (PM:260-340):
  - op 1, result 1: `GlobalConfig.isConfirmPassword = true`, "Confirmação de senha aceite";
  - op 2, result 1: `hasVicePassword = 1`, confirmed, "Senha configurada com sucesso, favor memorizar.";
  - op 3, result 1: confirmed, "A alteração da senha sucedida, favor memorizar";
  - op 4, result 1: `isDuringResetTime = 1`, "Pedido de reset bem sucedido, a senha de bloqueio dos seus itens ficará desativada durante 3 dias";
  - op 5: `needViceGuild = (result == 1)`; op 6: `needShowReward = (result == 1)` (server-pushed flags);
  - result 0 or other values: no message *(the server should push a generic error text)*.

### S2. 3 `U_C_PLAYER_INFO`
`hasVicePassword` (#95, INT32) and `isDuringToResetTime` (#96, INT32) (PM:1113-1117).

## 5. Rules and formulas

- Password: exactly 6 digits, not all equal, not an ascending/descending run (VPU:51-104).
- Confirmation lasts for the client session (`GlobalConfig.isConfirmPassword`); the server must keep a per-session flag and refuse lock-protected operations (sell, move, decompose, use) on locked objects.
- Reset: password disabled after 72 h (UI says 3 days); while pending, all password operations are blocked.
- Locks require a set password *(assumption)*.

## 6. Templates

None.

## 7. Persistent state

```sql
CREATE TABLE hero.secondary_password (
    player_id        BIGINT PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
    password_hash    TEXT   NOT NULL,
    reset_requested_at TIMESTAMPTZ,
    updated_at       TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE hero.object_locks (
    player_id    BIGINT   NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
    object_kind  SMALLINT NOT NULL CHECK (object_kind IN (1,2,3,4,5,6,7,8,9,11,13)),
    object_id    BIGINT   NOT NULL,
    locked_at    TIMESTAMPTZ NOT NULL DEFAULT now(),
    PRIMARY KEY (player_id, object_kind, object_id)
);
```

Store passwords with a slow hash (argon2id); never log them.

## 8. Backend implementation notes

- `hero::vice_player::handle_password_op` (8806): op 1 verify and mark the session; op 2 only if none exists; op 3 verify old; op 4 set `reset_requested_at` (password cleared after 72 h by a scheduler, then push 3 `hasVicePassword = 0`, `isDuringToResetTime = 0`); reply 4696 `{op_type, result}` (1 success, 0 failure); push 3 flags.
- `hero::vice_player::handle_lock_toggle` (8809): require a password and a confirmed session; resolve `object_kind` + position/id to an owned object; toggle row; push the owning feature's update (item/pet/monster/Theseus).
- Every feature that sells, moves out, decomposes or consumes objects must check `hero.object_locks`.
- Login: push 4696 op 5/6 flags if used.

## 9. Open questions and assumptions

- Assumption: 8809 toggles; no unlock-specific op exists in the client.
- Assumption: result codes other than 1 are failures.
- Open: meaning of op 5 (`needViceGuild`) and op 6 (`needShowReward`) flags.

## 10. Implementation checklist

- [ ] Screens: SetVPView, ChangeVPView, ConfirmVPView, lock cursor mode
- [ ] Route 8806 ops 1-4
- [ ] Route 8809 lock toggle (ops 1-9, 11, 13)
- [ ] Server message 4696 per op
- [ ] Server message 3 `hasVicePassword`, `isDuringToResetTime`
- [ ] Table `hero.secondary_password`
- [ ] Table `hero.object_locks`
- [ ] Rule: password format, session confirmation, 72 h reset
- [ ] Test: locked item cannot be sold until unlocked with a confirmed session
