# Mailbox

Feature `mail`, module `mailbox`. Mail list download, read marking, new mail notification, delete, expiry and the list UI.

Conventions: paths relative to the repository root; AS3 citations `decompiled/<module>/scripts/<path>.as:<line>`; opcodes from `protocol/opcodes.csv`; fields `name (#tag, TYPE, repeated?)` from `protocol/proto.json`; "Assumption" marks behavior not visible in the client.

## 1. Overview

At login the client POSTs to `{REQ}maillist` and receives a zlib compressed XML with one `Info` element per mail. Mails of type 3 go to the battle report tab, all others to the mail tab. When the server pushes 148 (`U_C_NEW_MAIL`) the client fetches only that mail with `maillist?mailId=<id>`. Opening an unread mail calls `maillist` with `reqType=1`, which must mark the mail read and return it. Delete uses the socket (8206/4132). The client hides mails whose remaining time is <= 0 and keeps at most 300 mails loaded.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `emailII.EmailFrame` `decompiled/m11/scripts/emailII/EmailFrame.as:61` | "Email" (`emailII.EmailFrame.title`); tab "Relatório de Batalhas" (`emailII.EmailFrame.battle`); buttons "Todos", "Deletar", "Extrair" | Two tab list (`__panelChangeHandler` `:192`: mail type 1, battle type 3; "Extrair" disabled on reports), paging (`:253`, `:265`), write button (`__writeHandler` `:277`, level 6), new report blink (`__newBattleChangeHandler` `:178`) | controller `email` (`SmallMapBar.as:778`); on open shows "Caixa de email cheia, delete alguns emails para garantir que receberá novos emails." when >= 300 mails (`EmailControler.showFrame` `decompiled/core_module/scripts/mvc/controler/EmailControler.as:77`) | `EmailManager.mailList` / `reportList` |
| `EmailListView` `decompiled/m11/scripts/emailII/view/EmailListView.as:23` | none | 6 rows per page (`EmailModel._pageCapicity = 6`, `decompiled/core_module/scripts/mvc/module/emailII/EmailModel.as:18`) | frame | |
| `EmailItemView` `decompiled/m11/scripts/emailII/view/EmailItemView.as:69` | "Remetente: {0}", "Restante: {0}" | Row: title (bold when unread), sender, remaining time, first attachment icon or envelope (open/closed), GM icon when `SendType == 2` (`:319`), player or system sender color (`initPersonColor` `:128`), checkbox, delete icon | list | `EmailInfo` |
| `ReadEmailFrame` + `ReadEmailView` `decompiled/m11/scripts/emailII/view/ReadEmailFrame.as:24`, `ReadEmailView.as:76` | "Email"; buttons "Responder", "Extrair" | Reading pane (`refreshView` `ReadEmailView.as:331`): sender with "Nv.{0}", title, text, 5 attachment slots; "system mail, do not reply" frame for types 2, 4, 5 (`:364`) | row click (`EmailItemView.__openHandler` `:230`) | current mail |
| `ReadBattleReportView` | "Relatório de Batalhas" | see [battle-reports.md](battle-reports.md) | row click on a report | |

## 3. Routes (client to server)

| # | UI control | Client sender | Client checks | Route | Request | Response |
|---|---|---|---|---|---|---|
| B1 | Login (automatic) | `EmailManager.setup` `decompiled/core_module/scripts/yishi/manager/EmailManager.as:70` then `getMailList("0", 0)` `:75` | none | HTTP POST `{REQ}maillist` (`REQUEST_PATH` = `/` on our server, `server/src/main.rs:37`), `dataFormat = binary` | form fields: `userId` (player id), `mailId` = `"0"` (all), `reqType` = 0, `key` (session key `PlayerManager.currentPlayerModel.userInfo.key`), `rnd` (random) | zlib compressed XML; every `Info` descendant becomes an `EmailInfo` by attribute name (`EmailInfoResolve` `decompiled/core_module/scripts/yishi/resolve/EmailInfoResolve.as:16`, `ClassFactory.createInstanceIII`). Then the client requests attachment details, see [attachments.md](attachments.md) |
| B2 | New mail push | `EmailManager.__newMail` `EmailManager.as:295` | if the loaded count would exceed 300: tip "E-mail cheio", id queued in `unLoadList` | HTTP POST `{REQ}maillist` | `mailId` = new id, `reqType` = 0 | XML with that mail |
| B3 | Open an unread mail | `EmailItemView.__openHandler` `EmailItemView.as:230` then `EmailControler.readEmail` `EmailControler.as:266` | read mails open without a request | HTTP POST `{REQ}maillist` | `mailId` = id, `reqType` = 1 | XML with the mail, `ReadDate` now set; the client merges it (`EmailCategory.addMailNew` `decompiled/core_module/scripts/mvc/module/emailII/EmailCategory.as:120`, `updateEmail`) |
| B4 | "Deletar" (selected or current), row delete icon | `EmailFrame.__deleteHandler` `EmailFrame.as:219`, `EmailItemView.__deleteHandler` `:172` then `EmailControler.deleteEmails` `EmailControler.as:189` | at least one mail ("Escolha pelo menos um email"); confirmation "Email contêm anexo, deletar?" if any selected mail still has attachments | C>S 8206 0x200e `U_C_MAIL_DEL` (`EmailSocketOutManager.deleteMail` `decompiled/core_module/scripts/managers/EmailSocketOutManager.as:38`) | `MailDelReqMsg`: `delList (#1, INT32, repeated)` mail ids | 4132 |
| B5 | Reload queued mails after delete | `EmailManager.removeEmail` `EmailManager.as:316` | only if `unLoadList` is not empty | HTTP POST `{REQ}maillist` | `mailId` = comma separated ids (as many as were deleted), `reqType` = 0 | XML with those mails |

## 4. Server messages (server to client)

| Route | Message | Client receiver | When | Reaction |
|---|---|---|---|---|
| HTTP `maillist` response | zlib(UTF-8 XML). Shape: any root, `Info` descendants. Attributes (`decompiled/core_module/scripts/mvc/module/emailII/EmailInfo.as`): `Id` (int), `MailType` (int: 1 player, 2 system, 3 battle report, 4 star attachments, 5 system with silent pickup failure, see Rules), `SendId` (0 = system), `SendType` (2 shows the GM icon), `SendNickName`, `SendPlayerGrade`, `ReceiveId`, `ReceiveNickName`, `SendDate`, `ReadDate` (`YYYY-MM-DD hh:mm:ss`; year 2999 means unread), `Title`, `Contents` (plain text, or report XML for type 3), `RemoveDate`, `ValidityDate` (days), `Annex1`..`Annex5` (attachment ids, see [attachments.md](attachments.md)), `Annex1Name`..`Annex5Name` (template id), `Annex1Count`..`Annex5Count`, `IsAnnex1`..`IsAnnex5` (`"true"` once taken), `IsExist` | `EmailManager.__onGetMailComplete` `EmailManager.as:94`, `EmailCategory.setupMaill` `EmailCategory.as:46` | B1, B2, B3, B5 | adds or updates mails; on login, an unread mail starts the mail button effect (`EMAIL_STARTREAD`) |
| S>C 148 0x0094 `U_C_NEW_MAIL` | `MailMsg`: `player_id (#1, INT32)` receiver, `mail_id (#2, INT32)` new mail id; `position (#3, INT32, repeated)` and `mailsIdArray (#4, INT32, repeated)` unused here | `EmailManager.__newMail` `EmailManager.as:295` | push to the online receiver after any mail is created | sound "014", `totalLength++`, then B2 |
| S>C 4132 0x1024 `U_C_MAIL_DEL_RESULT` | `MailDelReqMsg`: `delList (#1, INT32, repeated)` ids actually deleted; empty = failure | `EmailControler.__mailDelResult` `EmailControler.as:134` | response to 8206 | non empty: removes mails and refetches queued ones (B5); empty: tip "Falha ao deletar email" |

## 5. Rules and formulas

- Read state: `ReadDate` year 2999 means unread (`EmailInfo.isRead` `EmailInfo.as:106`). The server must store a sentinel `2999-01-01 00:00:00` for unread mails.
- Remaining time in hours (`EmailInfo.remainTime` `EmailInfo.as:238`): `ValidityDate*24 - (now - ReadDate)/3600000` when read, else from `SendDate`; negative is shown as "Expirado" and the mail is dropped from the client list when the frame opens (`EmailControler.filterOutDateEmails` `EmailControler.as:110`). Server rule: delete the mail when `remaining <= 0` (Assumption: validity 30 days for player mails, per feature for system mails; `removeDate` is informative).
- Display: days when >= 24 h ("{n}D"), else hours ("{n}H") (`EmailInfo.leftTime`).
- Capacity: the client keeps at most 300 loaded mails (`EmailManager.as:306`, `EmailCategory.as:61`); the server should keep accepting mails but warn (Assumption: no hard server cap, since the client queues overflow ids).
- Sorting (`EmailCategory.sortMail` `EmailCategory.as:254`): unread first (newest first), then mails with attachments, then by send date descending.
- Tabs: `MailType == 3` goes to reports, everything else to mails (`EmailCategory.addMailNew` `:120`).
- Delete with attachments asks confirmation client side; the server deletes anyway (attachments are lost).

## 6. Templates

None. pt-BR strings from `emailII.*` and `yishi.manager.EmailManager.*` keys.

## 7. Persistent state

```sql
CREATE SCHEMA IF NOT EXISTS mail;

CREATE TABLE mail.mail (
    mail_id          serial      PRIMARY KEY,                 -- Info@Id
    receiver_id      integer     NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
    sender_id        integer     REFERENCES player.players(player_id) ON DELETE SET NULL, -- null = system (SendId 0)
    sender_nickname  text        NOT NULL DEFAULT '',
    sender_level     smallint    NOT NULL DEFAULT 0,          -- SendPlayerGrade
    mail_type        smallint    NOT NULL CHECK (mail_type IN (1, 2, 3, 4, 5)),
    send_type        smallint    NOT NULL DEFAULT 1,          -- SendType, 2 = GM icon
    title            varchar(64) NOT NULL,
    contents         text        NOT NULL DEFAULT '',
    sent_at          timestamptz NOT NULL DEFAULT now(),
    read_at          timestamptz,                             -- null = unread (sent as 2999-01-01 00:00:00)
    validity_days    smallint    NOT NULL DEFAULT 30 CHECK (validity_days > 0),
    deleted_at       timestamptz
);
CREATE INDEX mail_receiver_idx ON mail.mail (receiver_id, sent_at DESC) WHERE deleted_at IS NULL;
CREATE INDEX mail_expiry_idx ON mail.mail ((COALESCE(read_at, sent_at) + make_interval(days => validity_days))) WHERE deleted_at IS NULL;
```

Attachments live in `mail.attachment` ([attachments.md](attachments.md)).

## 8. Backend implementation notes

- HTTP handler `mail::mailbox::handle_maillist` (POST `/maillist`): authenticate `userId` + `key` against the session store; parse `mailId` (`"0"` = all, else comma separated ids) and `reqType` (1 = mark read). For `reqType = 1` set `read_at = now()` when null, in one statement. Select non deleted, non expired mails of that receiver (and only the requested ids). Render `Info` elements with the exact attribute names, compress with zlib, respond `application/octet-stream`. On auth failure return a compressed empty document (the client treats non decodable bodies as no data).
- Socket handler `mail::mailbox::handle_delete` (8206): validate ownership, soft delete in one transaction, respond 4132 with the ids actually deleted (possibly empty).
- Internal API used by other features and by compose: `mail::mailbox::deliver(mail) -> mail_id` inserts mail plus attachments in the caller's transaction; after commit push 148 to the receiver if online.
- Schedule `mail::mailbox::purge_expired` hourly: soft delete expired mails (attachments are discarded).
- The current `server/src/main.rs` answers `maillist` with `Result value=false` (see `docs/ui/navigation.md:843`), which leaves the frame empty; replace it with this handler.

## 9. Open questions and assumptions

1. Validity period per mail type is not in the client (Assumption: 30 days player mails, system mails per sender feature, battle reports 7 days).
2. Meaning of `MailType` 5 is inferred only from pickup failure handling (`EmailManager.as:277`): Assumption: system mail whose attachment failure is silent (for example reward mails from activities).
3. `SendType` values other than 2 have no client effect; 1 = player, 2 = GM/system (Assumption).
4. The servlet response root element name is not checked by the client.

## 10. Implementation checklist

- [ ] Table `mail.mail`
- [ ] `maillist` servlet with `mailId` (0, single, list) and `reqType` (0, 1), zlib XML
- [ ] Login fetch fills both tabs; unread blink
- [ ] Push 148 after delivery and single mail fetch
- [ ] Read marking via `reqType=1`
- [ ] Delete 8206 and result 4132 (success and failure tip)
- [ ] Expiry display and hourly purge
- [ ] 300 mail client cap behavior and refetch after delete (B5)
- [ ] Sorting and paging (6 per page)
- [ ] Test: unread sentinel date 2999 renders as unread
