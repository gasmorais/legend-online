# Security code (anti-bot puzzle) and client integrity probe

Area: account, module `security-code`. Covers the "Número de autenticação" image puzzle that the server can impose on a player (`8516` ask, `4402` puzzle, `8514` answer, `4401` success), the anti-plugin lockouts reported by the login servlet, and the server-driven client probe `4490 U_CCC` / `8598 C_CC`.

Conventions: see [login-session.md](login-session.md). Paths are relative to the repository root.

## 1. Overview

- The puzzle is a CAPTCHA against bots: the server sends 4 image tiles (`images1..4`, each an encoded image) that form one picture when ordered correctly. The tiles arrive shuffled; the player drags tiles to swap them inside a 2 x 2 grid, then confirms. The client sends the resulting tile order, for example `"3,1,4,2"`.
- Answering in time gives a reward displayed as `level * 100` (experience icon); failing or timing out disconnects the player ("senão será deslogado do jogo").
- The client asks once per session whether a puzzle is due: 3 seconds after the first scene switch it sends `8516` (`MainToolBar.sendSecurityCode`). The server may also push `4402` at any time (for example after suspicious activity).
- The whole system is gated by server switch type 14 (`ConfigManager.info.SECURITY_CODE`, [switches.md](switches.md)); when it is off the client ignores `4402`.
- Repeated failures lead to the login lockouts `Check Code Failed 2/3/4` (5, 15, 30 minutes) returned by the `login` servlet ([login-session.md](login-session.md)).

## 2. Screens

| Class | pt-BR text | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `securityCode.SecurityCodeFrame` (`decompiled/m11/scripts/securityCode/SecurityCodeFrame.as:26`) | title `securitycode.view.SecurityCodeTxt` "Número de autenticação"; `securityCode.alert` "Junte as peças ao lado até formarem uma imagem completa"; `securityCode.reward` "Prêmio do Quebra-Cabeça:"; `securityCode.tip` "Conclua o quebra-cabeça antes do tempo encerrar, senão será deslogado do jogo."; `securityCode.remainCount` "Restantes: {0}" | Solve the puzzle | `FrameControllerManager.openControllerByInfo("securitycode")` from `BaseManager.__securityCodeHandler` (`decompiled/core_module/scripts/yishi/manager/BaseManager.as:1715-1727`) | 4 tiles (150 x 150 each, `SecurityCodeItem.as:95-98`), countdown in seconds, remaining attempts, reward value `grades * 100` (`SecurityCodeFrame.as:139`) |
| `securityCode.SecurityCodeItem` (`decompiled/m11/scripts/securityCode/SecurityCodeItem.as:17`) | n/a | One draggable tile; dropping on another tile swaps position and `index` (`SecurityCodeItem.as:58-82`) | Frame | Image bytes loaded with `Loader.loadBytes` (`SecurityCodeItem.as:100-110`) |

The frame is in group `NONE` (cannot be closed by other frames) and sits on layer 2 with a modal block (`SecurityCodeFrame.as:66-69`, `:207-213`). Controller: `mvc.controler.SecurityCodeControl` (`decompiled/core_module/scripts/mvc/controler/SecurityCodeControl.as:31-38`) refuses to open when the switch is off. Model: `mvc.module.securitycode.SecrityCodeModel` (`byteArr_1..4`, `remainCount`, `remainTime`).

## 3. Routes (client to server)

### 3.1 `8516 C_CHECK_SHOW_CODE` (C>S, 0x2144): ask whether a puzzle is due

- UI control: none, automatic. `MainToolBar` scene switch handler starts a 3000 ms interval on the first scene switch (`decompiled/core_module/scripts/ui/maintoolbar/MainToolBar.as:1296-1300`); `sendSecurityCode` clears it and sends once (`MainToolBar.as:1304-1309`).
- Sender: `SocketSecurityCodeMessageManager.sendCheckShowSecurityCode` (`decompiled/core_module/scripts/managers/SocketSecurityCodeMessageManager.as:23-28`).
- Request: empty `CheckImageMsg` (package simple).
- Expected response: `4402` when a puzzle is due, nothing otherwise. ProtocolTypeTable describes it as "初次登陆请求是否需要显示验证码" (first login asks whether to show the code).

### 3.2 `8514 C_CHECK_CODE` (C>S, 0x2142): submit the answer

- UI control: confirm button `securitycode.ConfirmBtn`.
- Sender: `SecurityCodeFrame.__confirmClickHandler` (`SecurityCodeFrame.as:156-177`) through `SocketSecurityCodeMessageManager.sendSecurityCodeMessage` (`SocketSecurityCodeMessageManager.as:15-21`).
- Client-side: builds `result` from the 4 tiles in grid order (top left, top right, bottom left, bottom right, by the vector order `_imgList`), joining each tile's current `index` with commas. Tiles start with index 1..4 in grid order (`SecurityCodeFrame.as:105-115`), so an untouched grid sends `"1,2,3,4"`. The frame closes immediately after sending. Timeout: when the countdown ends the frame closes without sending (`SecurityCodeFrame.as:198-205`).
- Request `CheckImageMsg` (package simple): `result (#7, STRING)` = the order string; all other fields unset.
- Expected response: `4401` on success; on a wrong answer either a new `4402` with `left_count - 1` or a disconnect when no attempt remains (assumption, see 9).

Note on semantics: swapping exchanges the tiles' `index` values with their positions, so the string lists, per grid cell, the original index of the tile now placed there. The server stores the permutation it applied and checks that the submitted list restores the picture.

### 3.3 `8598 C_CC` (C>S, 0x2196): client integrity probe answer

- Not in `protocol/opcodes.csv`; name from `ProtocolTypeTable.as` ("8598  C_CC").
- Sender: `BaseManager.__cccHandler` (`BaseManager.as:2809-2821`) in reply to `4490`. Also `SocketSendManager.sendMsg` (`decompiled/core_module/scripts/yishi/service/managers/SocketSendManager.as:507-511`), used by `FarmManager.as:485` to send an arbitrary message on the same opcode.
- Request: simple `PropertyMsg` echoing the probe, with `param6 = param4` and, when `param5` was present, `param7 = !ApplicationDomain.hasDefinition(param5)` (true when the class named in `param5` is missing from the client).

## 4. Server messages (server to client)

### `4402 U_C_SECURITY_CODE` (0x1132), `CheckImageMsg` (package simple)

Fields:

| Field | Meaning |
|---|---|
| `left_count (#1, INT32)` | Remaining attempts, shown as "Restantes: {0}" |
| `left_time (#2, INT32)` | Time limit in milliseconds (`new Timer(1000, remainTime / 1000)`, `SecurityCodeFrame.as:184-191`) |
| `images1 (#3, BYTES)` .. `images4 (#6, BYTES)` | Tile images (PNG or JPEG bytes, 150 x 150) in grid order 1..4 |
| `result (#7, STRING)` | unused in this direction |
| `property1 (#8, STRING)`, `property2 (#9, STRING)` | unused |

- Receiver: `BaseManager.__securityCodeHandler` (`BaseManager.as:1715-1727`), registered at `BaseManager.as:315`. Fills the model and opens the frame.
- When: response to `8516`, or push at any time.

### `4401 U_C_SEND_CHECKSUCC` (0x1131)

- ProtocolTypeTable: "验证码验证成功" (code verified). No client listener exists; the success is visible only through the reward pushes (experience update in `3 PlayerMsg` / hero exp push). Send it anyway for fidelity (assumption: empty body or `CheckImageMsg {result:"1"}`).

### `4490 U_CCC` (0x118a), simple `PropertyMsg`

- Receiver: `BaseManager.__cccHandler` (`BaseManager.as:2809-2821`), registered at `BaseManager.as:321`.
- Server sets `param4` (opaque token, echoed back in `param6`) and optionally `param5` (a fully qualified AS3 class name to test). The client answers `8598`.
- Use: detect injected or missing classes (bot plugins). For a faithful port this is optional; if used, only probe class names that exist in the shipped client and treat `param7 == true` as tampering.

## 5. Rules and formulas

- Trigger frequency: one `8516` per session, 3 s after the first scene switch (`MainToolBar.as:1296-1309`).
- Reward displayed: `thane.grades * 100` (`SecurityCodeFrame.as:139`); the server must grant the same experience on success (assumption: hero experience).
- Countdown: `left_time / 1000` seconds; the frame closes at 0 without answering (`SecurityCodeFrame.as:198-205`). The server must start its own timer at send time and disconnect when no correct answer arrives within `left_time` plus a 5 s grace (assumption).
- Lockouts at login (`decompiled/Loading/scripts/LoginResultValue.as:89-96`): `Check Code Failed 2` 5 minutes then 15, `Check Code Failed 3` 15 then 30, `Check Code Failed 4` 30 minutes. Assumption: level 1 is the first failure (no lockout text, generic), levels 2..4 escalate per consecutive failed session.
- Switch 14 off: no puzzle at all (`SecurityCodeControl.as:33-36`).

## 6. Templates

None. Tile images are generated server side (cut one random picture from a pool into 4 tiles, shuffle). Proposal: keep a folder of 300 x 300 images in the server data directory.

## 7. Persistent state

```sql
CREATE TABLE account.security_challenges (
  challenge_id     BIGSERIAL   PRIMARY KEY,
  player_id        BIGINT      NOT NULL REFERENCES player.players(player_id),
  image_key        TEXT        NOT NULL,
  expected_order   TEXT        NOT NULL CHECK (expected_order ~ '^[1-4],[1-4],[1-4],[1-4]$'),
  attempts_left    SMALLINT    NOT NULL CHECK (attempts_left >= 0),
  issued_at        TIMESTAMPTZ NOT NULL DEFAULT now(),
  expires_at       TIMESTAMPTZ NOT NULL,
  status           SMALLINT    NOT NULL DEFAULT 0 CHECK (status IN (0, 1, 2, 3)),
  answered_at      TIMESTAMPTZ
);
CREATE INDEX security_challenges_open_idx ON account.security_challenges (player_id) WHERE status = 0;

CREATE TABLE account.security_lockouts (
  account_id       BIGINT      PRIMARY KEY REFERENCES account.accounts(account_id),
  failure_level    SMALLINT    NOT NULL DEFAULT 0 CHECK (failure_level BETWEEN 0 AND 4),
  locked_until     TIMESTAMPTZ,
  updated_at       TIMESTAMPTZ NOT NULL DEFAULT now()
);
```

`status`: 0 pending, 1 solved, 2 failed, 3 expired.

## 8. Backend implementation notes

- `account::security_code::handle_check_show_code` (8516): if switch 14 is on and the player is due (policy: first login of the day, or a risk flag from behavior analysis, assumption), create a challenge with `attempts_left = 3` (assumption) and `left_time = 120000` ms (assumption), push `4402`. Else no reply.
- `account::security_code::handle_check_code` (8514): load the pending challenge; if expired, mark 3 and disconnect. Compare `result` with `expected_order`. Correct: mark 1, grant `grades * 100` experience through the hero service, push `4401`, reset `security_lockouts.failure_level`. Wrong: decrement `attempts_left`; if > 0 issue a new challenge (`4402`); else mark 2, raise `failure_level`, set `locked_until`, close the socket.
- Timer: a per challenge deadline task closes the socket on expiry.
- `account::security_code::handle_client_probe` (8598): compare `param6` with the issued token; log `param7`.
- `login` checks `security_lockouts.locked_until` and returns the matching `Check Code Failed N` message.

## 9. Open questions and assumptions

- Assumption: attempts per challenge (3) and time limit (120 s); the client only displays server values.
- Assumption: a wrong answer re-issues a puzzle rather than disconnecting immediately (the tip text only threatens a disconnect on timeout).
- Open: exact policy of when the original server demanded the puzzle (only "first login" is documented).
- Open: payload of `4401` (no client reader).

## 10. Implementation checklist

- [ ] Switch 14 wiring ([switches.md](switches.md))
- [ ] `8516` handler and due policy
- [ ] Image pool, tile cutting and shuffle, `4402` push
- [ ] `8514` handler, reward, retries, disconnect
- [ ] `4401` success push
- [ ] Deadline timer per challenge
- [ ] Login lockout levels `Check Code Failed 2/3/4`
- [ ] Optional `4490` / `8598` probe
- [ ] Tables `account.security_challenges`, `account.security_lockouts`
- [ ] Test: untouched grid sends `"1,2,3,4"`; correct permutation accepted
- [ ] Test: timeout disconnects
- [ ] Test: switch off ignores `4402`
