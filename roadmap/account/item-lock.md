# Item lock (second password)

Area: account, module `item-lock`. Covers the "Bloqueio de Itens" second password (`VicePassword`): set, confirm per session, change and reset (`8806` / `4696`), and the lock or unlock operation on items, equipment, Einherjar (pets), monsters and Theseus objects (`8809`). The lock state itself is a flag on each owning object and is pushed by the owning feature.

Conventions: see [login-session.md](login-session.md). Paths are relative to the repository root.

## 1. Overview

- At level 10 or more the player can set a 6 digit numeric password. Once set, every lock or unlock needs the password confirmed once per session (`GlobalConfig.isConfirmPassword`).
- Locked objects cannot be sold, decomposed, purified, have gems removed (equipment), be synthesized or fed (Cosmos), absorbed or sacrificed (Einherjar) (`mainBar.vicePassword.helpContent`). The checks run on the client (for example selling a locked item shows `vicepassword.description2`, `decompiled/core_module/scripts/bag/helper/BagHelper.as:463-472`) and must be repeated on the server by each owning feature.
- Forgotten password: "reset" disables the password; for 72 hours ("3 dias" in the success text) locks are inactive, then the password is removed and the player can set a new one.
- The server can ask the client to show a tutorial hint to set the password (`op_type 5`) and whether the first-set reward is still available (`op_type 6`).

## 2. Screens

| Class / style | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `mainBar.vicePassword.SetVPView` (style `vicepassword.setviewui`, `decompiled/core_module/scripts/mainBar/vicePassword/SetVPView.as`) | `mainBar.vicePassword.setviewtitle` "Senha" | Set the password (two inputs) | `openControllerByInfo("vicepassword", 1)` when `hasVicePassword == 0` (for example `decompiled/m14/scripts/pet/property/PetShowView.as:217-220`) | Rules `setviewdes`, support link, first time reward block when `needShowReward` (`SetVPView.as:99`, `:103-104`) |
| `ChangeVPView` (style `vicepassword.changevpview`) | `mainBar.vicePassword.changeviewtitle` "Alterar Senha" | Change (old, new, confirm) or reset (`BtnResetVp` "Redefinir") | open type 2 | Three inputs |
| `ConfirmVPView` (style `vicepassword.checkvpview`) | `mainBar.vicePassword.checkviewtitle` "Inserir Senha" | Confirm the password for this session | open type 3 when `hasVicePassword == 1` and not yet confirmed | One input |
| Lock cursor mode | tip `mainBar.SmallMapBar.vicepasswordBtnTipData` "Bloqueio de Itens" | Click objects to toggle their lock | Lock buttons in bag/army (`decompiled/m5/scripts/armyII/ArmyFrameII.as:599-616`), Cosmos (`decompiled/m5/scripts/star/HoroscopeFrame.as:298-315`), Einherjar (`PetShowView.as:208-232`), monsters (`decompiled/m14/scripts/monster/view/MonsterPropView.as:266-282`), Theseus (`decompiled/m5/scripts/theseus/TheseussoulFrame.as:206-248`, `decompiled/m5/scripts/theseusgodhead/TheseusgodAllFrame.as:395-459`) | Cursor `VICE_PASSWORD_LOCK` (`BagHelper.as:261-279`) |

Controller: `mvc.controler.VicepasswordController` picks the frame by `openType` 1/2/3 (`decompiled/core_module/scripts/mvc/controler/VicepasswordController.as:42-55`).

Common guard before any lock action (same code in every entry point, e.g. `PetShowView.as:208-232`):

1. `isDuringResetTime` -> tip `vicepassword.description1` "Durante o periodo de reset à senha, não pode realizar nenhuma operação", stop.
2. `hasVicePassword == 0` -> open SetVPView (type 1).
3. `isConfirmPassword` -> send the lock op directly (or enter cursor mode); else open ConfirmVPView (type 3).

## 3. Routes (client to server)

### 3.1 `8806 C_VICEPASSWORD` (C>S, 0x2266)

Sender: `VicePasswordUtil.vpOp(op, input, new, pre)` (`decompiled/core_module/scripts/mainBar/vicePassword/VicePasswordUtil.as:28-38`). Request `VicePasswordMsg` (package player): `op_type (#1, INT32)`, `input_pass (#2, STRING)`, `pre_pass (#3, STRING)`, `new_pass (#4, STRING)`, `result (#5, INT32)` unset. Unused password fields are sent as `"0"`.

| Action | UI | Client checks | Fields sent |
|---|---|---|---|
| Confirm (`op_type 1`) | ConfirmVPView confirm (`ConfirmVPView.as:118-135`) | input not empty, 6 digits | `input_pass` |
| Set (`op_type 2`) | SetVPView confirm (`SetVPView.as:268-311`) | both filled (`description12`, `description13`), `^\d{6}$`, equal (`description7`), not 6 equal digits (`description111`), not an ascending or descending run (`description112`), else `description6` | `input_pass`, `new_pass` (same value) |
| Change (`op_type 3`) | ChangeVPView confirm (`ChangeVPView.as:260-309`) | old (`description15`), new (`description14`), confirm (`description13`) filled; same rules on new | `pre_pass` = old, `input_pass` = new, `new_pass` = confirm |
| Reset (`op_type 4`) | ChangeVPView "Redefinir", alert `vicepassword.description5` (`ChangeVPView.as:185-199`) | confirmation dialog | none |

Expected response: `4696` with the same `op_type`.

### 3.2 `8809 C_LOCK_OR_UNLOCK` (C>S, 0x2269)

Sender: `VicePasswordUtil.vpLockOp(op, itemPos, petId)` (`VicePasswordUtil.as:40-49`). Request `LockAndUnlockMsg` (package player): `op_type (#1, INT32)`, `item_pos (#2, INT32)`, `pet_id (#3, INT32)`. The operation toggles the lock ("加锁解锁操作", ProtocolTypeTable).

| op_type | Object | Key field | Caller |
|---:|---|---|---|
| 1 | Bag item | `item_pos` = bag pos | `BagHelper.as:336` |
| 2 | Einherjar (pet) | `pet_id` | `PetShowView.as:228` |
| 3 | Equipped item | `item_pos` | `BagHelper.as:360` |
| 4 | Honor equipment cell | `item_pos` | `BagHelper.as:356` |
| 5 | Storage (warehouse) item | `item_pos` | `BagHelper.as:328` |
| 6 | Monster | `pet_id` = monster id | `MonsterPropView.as:282` |
| 7 | Rune bag (bag type 401) item | `item_pos` | `BagHelper.as:332`, `decompiled/m5/scripts/armyII/viewII/stone/item/RuneCellMenu.as:93` |
| 8 | Theseus treasure cell | `item_pos` | `decompiled/m5/scripts/theseus/TheseusBagHelper.as:114` |
| 9 | Theseus war equipment / inscription | `pet_id` = object id | `TheseusBagHelper.as:152`, `:172` |
| 11 | Theseus bag item | `pet_id` = object id | `TheseusBagHelper.as:99` |
| 13 | Theseus outer treasure item | `item_pos` | `TheseusBagHelper.as:132` |

Cosmos stars use their own lock (`StarManager.sendStarComposeLock`, `8330 C_STAR_LOCK`, `BagHelper.as:379`), owned by [../cosmos/README.md](../cosmos/README.md).

Expected response: the owning feature's update push with the new lock flag: `SimpleItemInfoMsg.is_locked (#36)` / `CommonItemMsg.lock (#16)` for items ([../inventory/README.md](../inventory/README.md)), `PetInfoMsg.is_locked (#42)` ([../einherjar/README.md](../einherjar/README.md)), `MonsterMsg.isLock (#13)` ([../monsters/README.md](../monsters/README.md)), `TheseusEquipMsg.isLock (#9)` ([../theseus/README.md](../theseus/README.md)).

## 4. Server messages (server to client)

### `4696 U_C_VICEPASSWORD` (0x1258), `VicePasswordMsg` (package player)

Not in `protocol/opcodes.csv`; name from ProtocolTypeTable ("二级密码返回信息"). Receiver: `PlayerManager.__vicePassword` (`decompiled/core_module/scripts/yishi/manager/PlayerManager.as:260-341`), registered at `PlayerManager.as:181`. Fields used: `op_type`, `result`.

| op_type | result | Client reaction |
|---:|---:|---|
| 1 | 1 | Confirmed: `isConfirmPassword = true`, tip `vicepassword.description16` "Confirmação de senha aceite", notifies the open view (`VICE_PASSWORD_OP_SUCCESS_EVENT`) |
| 2 | 1 | Set: `hasVicePassword = 1`, `isConfirmPassword = true`, tip `description17` |
| 3 | 1 | Changed: `isConfirmPassword = true`, tip `description18` |
| 4 | 1 | Reset requested: `isDuringResetTime = 1`, tip `description19` |
| 1..4 | 0 or other | No reaction (the view stays open); send a tip text separately for wrong passwords (assumption) |
| 5 | 0 / 1 | Push: `needViceGuild` false / true (tutorial hint to set the password, shown by `NewbieManager.checkHasViceGuild` at level >= 10, `decompiled/core_module/scripts/dialog/utils/NewbieManager.as:100-110`, `:154-157`) |
| 6 | 0 / 1 | Push: `needShowReward` false / true (first set reward block in SetVPView) |

`PlayerMsg.hasVicePassword (#95, INT32)` and `PlayerMsg.isDuringToResetTime (#96, INT32)` (read at `PlayerManager.as:1113-1117`) carry the state at login.

## 5. Rules and formulas

- Password: exactly 6 digits, not `dddddd`, not one of `012345, 123456, 234567, 345678, 456789, 987654, 876543, 765432, 654321, 543210` (`VicePasswordUtil.as:51-104`).
- Unlock level: 10 (`NewbieManager.as:154-157`).
- Session confirmation: one successful op 1, 2 or 3 sets the session flag; it is never cleared client side until reload.
- Reset: during the reset period all locks are ignored and no lock operation is allowed; duration 72 hours (`description5`, `setviewdes`; `description19` says 3 days). After it, `hasVicePassword = 0` and `isDuringResetTime = 0`.
- First set reward: shown when `needShowReward`; the reward list is not in the client strings (assumption: server config).

## 6. Templates

None found for rewards. The rules text lives in `index/language.json` (`mainBar.vicePassword.*`, `vicepassword.*`).

## 7. Persistent state

```sql
CREATE TABLE account.item_lock_passwords (
  player_id           BIGINT      PRIMARY KEY REFERENCES player.players(player_id),
  password_hash       TEXT        NOT NULL,
  set_at              TIMESTAMPTZ NOT NULL DEFAULT now(),
  reset_requested_at  TIMESTAMPTZ,
  first_reward_taken  BOOLEAN     NOT NULL DEFAULT false,
  failed_attempts     SMALLINT    NOT NULL DEFAULT 0,
  locked_out_until    TIMESTAMPTZ
);

CREATE TABLE account.object_locks (
  player_id           BIGINT      NOT NULL REFERENCES player.players(player_id),
  object_kind         SMALLINT    NOT NULL CHECK (object_kind IN (1, 2, 3, 4, 5, 6, 7, 8, 9, 11, 13)),
  object_id           BIGINT      NOT NULL,
  locked_at           TIMESTAMPTZ NOT NULL DEFAULT now(),
  PRIMARY KEY (player_id, object_kind, object_id)
);
```

`object_kind` reuses `op_type`; `object_id` is the stable id of the item (resolved from the bag position at lock time), pet, monster or Theseus object. Owning features read `object_locks` (or mirror a boolean column) to fill their `is_locked` fields and to refuse destructive operations. The per session confirmation flag lives in the session state (memory).

## 8. Backend implementation notes

- `account::item_lock::handle_vice_password` (8806):
  - op 1: require password set; verify hash (argon2); on success set session `confirmed = true`, reply `{op_type:1, result:1}`; on failure increment `failed_attempts`, reply `result 0` (5 failures lock for 30 minutes, assumption).
  - op 2: require level >= 10 and no password; validate rules; store hash; reply `{2,1}`; if `first_reward_taken` is false grant the reward via mail or bag and set it true, then push `{6,0}`.
  - op 3: verify `pre_pass`, validate new, store; reply `{3,1}`.
  - op 4: set `reset_requested_at = now()`, reply `{4,1}`; scheduler deletes the row after 72 hours and pushes `3 PlayerMsg {hasVicePassword:0, isDuringToResetTime:0}`.
- `account::item_lock::handle_lock_toggle` (8809): require password set, session confirmed and not during reset; resolve the object by `op_type` and position or id through the owning feature; toggle the `object_locks` row in a transaction; ask the owning feature to push the object update.
- Login: push `{5, needGuide}` and `{6, rewardAvailable}` after phase A ([login-session.md](login-session.md)).
- Every destructive handler in inventory, smith, einherjar, monsters, theseus, cosmos must check `object_locks` and reply with its own failure (client shows `vicepassword.description2/3/4/10/11`).

## 9. Open questions and assumptions

- Assumption: wrong password replies `result 0` with no extra push; the client shows nothing.
- Assumption: lockout after 5 wrong confirmations.
- Open: the first set reward contents.
- Open: `op_type` 10 and 12 for `8809` were not found in callers.

## 10. Implementation checklist

- [ ] SetVPView, ChangeVPView, ConfirmVPView flows (client exists, server ops 1..4)
- [ ] `8806` handler with hashing and validation rules
- [ ] `4696` replies and login pushes op 5 / op 6
- [ ] Reset scheduler (72 h)
- [ ] `8809` toggle for all 11 object kinds
- [ ] Integration hooks in owning features (refuse destructive ops on locked objects)
- [ ] Tables `account.item_lock_passwords`, `account.object_locks`
- [ ] Test: lock without confirmation is rejected
- [ ] Test: password `111111` and `123456` rejected by the server too
- [ ] Test: during reset no lock toggle is accepted
