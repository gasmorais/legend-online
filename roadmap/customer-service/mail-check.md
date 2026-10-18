# Email verification (Verificação de email)

Area: customer-service, module `mail-check`. Covers binding and verifying a real e-mail address with a PIN code (`9591 C_MAIL_CHECK` ops 1 and 2, `337 U_C_MAIL_CHECK` state push), the intro reward frame (`MobilephoneCheckFrame`), the login popup and the reward configured in `ConfigInfos.xml` (`mail_rewards`).

Conventions: see [support-tickets.md](support-tickets.md). Paths are relative to the repository root.

## 1. Overview

- The server tells the client the verification state with `337`. While not verified, the player is invited (popup after login in the sky city or castle at level 25+, and after closing the customer service frame at level 6+) to verify an e-mail address and earn 1000 bound diamonds, 40 "Bolsa de Ouro" and 1 "Gema de Vida Nv. 7".
- Flow: intro frame (rewards and a button) -> "Verificação de email" frame: type the address, "Enviar código" (server mails a numeric PIN; resend allowed after 300 s), accept the privacy policy ("Li e concordo"), type the PIN, "Entregar".
- Gate: switch type 3066 (`MAIL_CHECK`, [../account/switches.md](../account/switches.md)). The top toolbar entry `mailcheck` is hard disabled (`decompiled/core_module/scripts/ui/toptoolbar/TopBtnCheckShowHelper.as:303-304`).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `mailcheck.MobilephoneCheckFrame` (open type 1, `decompiled/m11/scripts/mailcheck/MobilephoneCheckFrame.as:20`) | `mailCheck.MailCheckFrame.successPrize` "Após verificar email poderá obter os seguintes prêmios:" | Intro with reward icons and a button | `openControllerByInfo("mailcheck", 1)`: login popup (`decompiled/core_module/scripts/yishi/lunch/Yishi.as:587-592`), `337` with state 0 or 4 in `SPACE_SCENE`/`CASTLE_SCENE` (`decompiled/core_module/scripts/managers/MailCheckManager.as:101-104`), toolbar case (`decompiled/core_module/scripts/ui/toptoolbar/TopToolsBar.as:1271-1272`) | `ConfigInfoManager.getMailCheckPrize()` items (`MobilephoneCheckFrame.as:51-62`) |
| `mailcheck.MailCheckFrame` (open type 2, `decompiled/m11/scripts/mailcheck/MailCheckFrame.as:41`) | `mailCheck.MailCheckFrame.title` "Verificação de email" | Address, send code, PIN, submit | Intro button (`MobilephoneCheckFrame.as:95-98`), closing the customer service frame at level >= 6 while not verified (`decompiled/m11/scripts/customerService/CustomerServiceFrame.as:265-268`) | Address (prefilled from `337`), countdown `mailcheck.MailCheckFrame.refreshTxt` "({0}s Resend)", privacy checkbox `mailCheckFrame.selectedCheckBtn.text` "Li e concordo" with link `mailCheckFrame.privacyTxt.text` (opens `http://www.wan.com/en/policy.html`, `MailCheckFrame.as:184-200`), support link to the customer service frame (`:226-244`), rewards |

Controller: `mvc.controler.MailCheckControler` (`decompiled/core_module/scripts/mvc/controler/MailCheckControler.as:18-29`).

## 3. Routes (client to server)

Both actions use `9591 C_MAIL_CHECK` (C>S, 0x2577) with `MailCheckMsg` (package player): `op (#1, INT32)`, `state (#2, INT32)`, `pin (#3, INT32)`, `mail (#4, STRING)`.

### 3.1 Send code (`op = 1`)

- UI control: "Enviar código" (`mailCheck.MailCheckFrame.sendCheckCodeBtn`).
- Sender: `MailCheckFrame.__sendCheckCodeBtnClickHandle` (`MailCheckFrame.as:262-274`) -> `MailCheckManager.sendCheckMail` (`MailCheckManager.as:73-80`).
- Client-side checks: address matches `\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+(w+([.-]\w+))*` (`MailCheckFrame.as:256-260`), else `MailCheckFrame.wrongEmailAddress` "Formato de email incorreto". Disables the button for 300 s (`MailCheckFrame.as:271-273`, `:299-323`).
- Fields: `op = 1`, `mail`.
- Expected response: `337` with `state = 1` (code sent) and the address.

### 3.2 Submit PIN (`op = 2`)

- UI control: "Entregar" (`mailCheck.MailCheckFrame.submitBtn`), enabled only in state 1.
- Sender: `MailCheckFrame.__submitBtnClickHandle` (`MailCheckFrame.as:325-334`) -> `MailCheckManager.submitCheckCode` (`MailCheckManager.as:82-90`).
- Client-side checks: privacy checkbox selected, else `mailCheckFrame.notSelected.text` "Você deve concordar com a política de privacidade para continuar". PIN parsed with `parseInt`.
- Fields: `op = 2`, `mail`, `pin`.
- Expected response: `337` with `state = 2` on success (frame closes), or `3` on a wrong or expired PIN (assumption), then the reward items.

## 4. Server messages (server to client)

### `337 U_C_MAIL_CHECK` (0x0151), `MailCheckMsg` (package player)

Fields used: `state (#2, INT32)`, `mail (#4, STRING)`.

- Receiver: `MailCheckManager.__mailCheckInfoHandler` (`MailCheckManager.as:92-106`), registered at `:70`; the open frame reacts through `MailCheckEvent.STATE_UPDATE` (`MailCheckFrame.as:207-224`).
- `isShow = state != 2`. States:

| state | Meaning (assumption from client reactions) | Client reaction |
|---:|---|---|
| 0 | Not verified, no code pending | Intro popup in sky city/castle; submit disabled |
| 1 | Code sent to `mail` | Submit enabled |
| 2 | Verified | Frame closes, never shown again |
| 3 | Code rejected or expired | Submit disabled (must resend) |
| 4 | Verification required again (address invalidated) | Intro popup like 0 |

- When: at login (after the scene is known, so the popup can appear), and as the response to every `9591`.

## 5. Rules and formulas

- Resend cooldown 300 s (client), enforce server side too.
- PIN: integer (`INT32`); proposal 6 digits, valid 30 minutes, 5 attempts.
- Reward (`raw/xml/tempinfos/ConfigInfos.xml`, `ConfigName="mail_rewards"`, value `-500,1000|2030102,40|2050607,1`, description "游戏角色邮箱验证完成奖励"): 1000 bound diamonds (`-500`, [../currency/README.md](../currency/README.md)), 40 x 2030102 "Bolsa de Ouro", 1 x 2050607 "Gema de Vida Nv. 7"; granted once per player.
- Popup gates: level >= 25 at login (`Yishi.as:587`), level >= 6 after the customer service frame, scenes `SPACE_SCENE`/`CASTLE_SCENE` only.

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `raw/xml/tempinfos/ConfigInfos.xml` | `ConfigInfo ConfigName="mail_rewards"` | `ConfigValue` = `templateId,count` pairs separated by `|` (`decompiled/core_module/scripts/yishi/datas/ConfigInfoManager.as:57-60`, `:736-744`) |

## 7. Persistent state

```sql
CREATE TABLE customer_service.email_verifications (
  player_id        BIGINT      PRIMARY KEY REFERENCES player.players(player_id),
  email            TEXT,
  state            SMALLINT    NOT NULL DEFAULT 0 CHECK (state BETWEEN 0 AND 4),
  pin_hash         TEXT,
  pin_expires_at   TIMESTAMPTZ,
  pin_attempts     SMALLINT    NOT NULL DEFAULT 0,
  last_sent_at     TIMESTAMPTZ,
  verified_at      TIMESTAMPTZ,
  rewarded         BOOLEAN     NOT NULL DEFAULT false
);
CREATE INDEX email_verifications_email_idx ON customer_service.email_verifications (lower(email));
```

E-mail addresses are personal data: store only what verification needs and never expose them to other players.

## 8. Backend implementation notes

- `customer_service::mail_check::push_state` (login, after `6` and the scene push): send `337 {state, mail}` when switch 3066 is open; omit otherwise (the client then never shows the popup because `isShow` stays false).
- `customer_service::mail_check::handle_mail_check` (9591):
  - op 1: validate switch, address format, cooldown (300 s since `last_sent_at`); generate PIN, store hash and expiry, send the e-mail through the mail gateway, set `state = 1`; reply `337`.
  - op 2: require state 1, PIN not expired, attempts < 5; compare; success: `state = 2`, `verified_at`, grant `mail_rewards` (currency service for `-500`, bag or mail for items) once (`rewarded`), reply `337 {state: 2}`; failure: increment attempts, `state = 3`, reply `337`.
- Transaction: state change and reward grant together.

## 9. Open questions and assumptions

- Assumption: meanings of states 3 and 4 (only their UI effects are known).
- Open: whether the PIN was numeric only (`INT32` suggests yes).
- Open: `C_USER_PIN_CHECK` (8352, "手机任务发送验证码") belongs to the mobile binding task in [../quests/README.md](../quests/README.md) (`decompiled/m15/scripts/task/net/TaskSocketSendManager.as:18`), not to this frame despite the `MobilephoneCheckFrame` name.

## 10. Implementation checklist

- [ ] Switch 3066 gate
- [ ] `337` at login and on change
- [ ] `9591` op 1 with e-mail delivery and cooldown
- [ ] `9591` op 2 with PIN validation and attempts
- [ ] One time `mail_rewards` grant
- [ ] Table `customer_service.email_verifications`
- [ ] Test: invalid address rejected client side and server side
- [ ] Test: resend before 300 s rejected
- [ ] Test: reward granted once
