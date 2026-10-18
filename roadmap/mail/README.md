# Email (mail)

Feature slug `mail`, domain social. Client package `emailII` (`decompiled/m11/scripts/emailII`), manager `yishi.manager.EmailManager`, controller `mvc.controler.EmailControler`, data `mvc.module.emailII.*`, socket helper `managers.EmailSocketOutManager` (core module). Protobuf package `mail`.

The mailbox is unusual: the list and the mail bodies come from HTTP servlets (`{REQ}maillist`, `{REQ}itemlist`, `{REQ}starlist`) that return zlib compressed XML, while delete, send, attachment pickup and the new mail notification use the socket.

## What it does for the player

- "Email" window with two tabs: mails and "Relatório de Batalhas" (battle reports), 6 rows per page, "Todos" (select all), "Deletar", "Extrair" (take attachments), "Escrever Email".
- Reading a mail marks it read and shows sender ("Remetente: {0}" with level), title, text, up to 5 attachments (items, currency pseudo items or cosmos stars) that can be taken one by one or all at once, and "Responder".
- Writing a mail to a nickname, a friend or a guild member costs 100 gold ("{0} ouro"), title max 15 characters, text max 7 lines.
- Mails expire: "Restante: {0}" days or hours, "Expirado".
- System mails (rewards from other features) and guild mass mails (chairman, 50 diamonds) arrive in the same box.
- Battle reports (castle attacks in the outer city) are mails of type 3 with a structured XML body and a link to the location.

## Entry points

| Entry | Code | Condition |
|---|---|---|
| Small map bar mail button (`_mailBtn`) | `SmallMapBar.__mailHander` `decompiled/core_module/scripts/mainBar/SmallMapBar.as:766` opens controller `email` openType `email.EmailFrame` | hero level >= 6, else tip "O sistema Email é liberado no nível 6" (`mainBar.TopToolsBar.mailBtn.underLevel`) |
| Login | `Yishi` setup calls `EmailManager.instance.setup()` `decompiled/core_module/scripts/yishi/lunch/Yishi.as:728` which downloads the full list (`maillist`) | always |
| New mail push 148 | blinks the mail button (`SmallMapBar.as:451`) | always |
| "Responder" in a read mail, guild chairman mass mail | controller `writeemail` | see [compose.md](compose.md) |

## Modules

| Module | File | Scope |
|---|---|---|
| Mailbox | [mailbox.md](mailbox.md) | `maillist` servlet (list, read, refetch), new mail push, delete, expiry, capacity, list UI |
| Attachments | [attachments.md](attachments.md) | `itemlist` and `starlist` servlets, pickup 5022/114, mail update 4131, system mail creation API for other features |
| Compose | [compose.md](compose.md) | Write and reply (8205), nickname lookup (8257/4170), guild mass mail (send_type 2) |
| Battle reports | [battle-reports.md](battle-reports.md) | Mail type 3 body schema, report view, map transfer |

## Dependencies

- [../account/README.md](../account/README.md): `PlayerInfo.userId` and session `key` used to authenticate servlet calls; `C_MAIL_CHECK` 9591/337 (real world email verification) belongs to account, not here.
- [../inventory/README.md](../inventory/README.md): free bag slots, item objects for attachments, item templates.
- [../cosmos/README.md](../cosmos/README.md): star bag (type 1) capacity and `StarInfo` for star attachments.
- [../friends/README.md](../friends/README.md) (friend list for the recipient combo), [../guild/README.md](../guild/README.md) (member list, chairman mass mail button), [../currency/README.md](../currency/README.md) (gold, diamonds), [../castle/README.md](../castle/README.md) and the outer city (battle reports).
- Every feature that grants rewards by mail uses the system mail API defined in [attachments.md](attachments.md).

## Suggested implementation order

1. [mailbox.md](mailbox.md): tables, `maillist` servlet (empty list first, then real rows), push 148, delete.
2. [attachments.md](attachments.md): `itemlist`, pickup, 4131 update, and the internal `mail::system::send` API.
3. [compose.md](compose.md).
4. [battle-reports.md](battle-reports.md) once the outer city battles exist.
