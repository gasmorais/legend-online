# Mail attachments

Feature `mail`, module `attachments`. Attachment detail servlets, attachment pickup, mail updates after pickup, and the internal API other features use to send reward mails.

Conventions as in [mailbox.md](mailbox.md).

## 1. Overview

A mail carries up to 5 attachment slots (`Annex1..5`). After every list download the client collects the attachment ids it does not know yet and asks two servlets for their details: `itemlist` for items (`GoodsInfo`) and `starlist` for cosmos stars (`StarInfo`, only `MailType == 4`). A slot whose `AnnexN` is negative is a pseudo item (currency or virtual reward) rendered from `AnnexNName` (template id) and `AnnexNCount` without a servlet call. Taking attachments sends 5022 with mail ids and a slot position (0 = all slots); the server moves the goods to the bag, answers 114 with per slot results and pushes 4131 with the updated mail rows (`IsAnnexN = true`).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `ReadEmailView` attachment row `decompiled/m11/scripts/emailII/view/ReadEmailView.as:187` | button "Extrair" (`emailII.view.ReadEmailView.close`) | 5 item slots (`email.GoodsItem`) or 5 star slots (`email.StarItemIcon`); only untaken slots are shown (`refreshAnnex` `:405`) | reading pane | `EmailInfo.getAnnexByIndex` (`decompiled/core_module/scripts/mvc/module/emailII/EmailInfo.as:184`), `getAnnexStarByIndex` |
| `EmailFrame` "Extrair" button | "Extrair" (`emailII.EmailFrame.attach`), disabled on the reports tab | Take all attachments of selected mails or of the current mail | mailbox | |
| `EmailItemView` icon | none | First attachment icon in the row (`setNormalMail`, `setStarMail` `decompiled/m11/scripts/emailII/view/EmailItemView.as:339`, `:357`) | list | |

## 3. Routes (client to server)

| # | UI control | Client sender | Client checks | Route | Request | Response |
|---|---|---|---|---|---|---|
| A1 | After any list download | `EmailCategory.setupMaill` `decompiled/core_module/scripts/mvc/module/emailII/EmailCategory.as:46` then `EmailManager.getNewGoodMailAnnex` `decompiled/core_module/scripts/yishi/manager/EmailManager.as:126` | only ids `> 0` not yet cached, only for non type 4 mails with untaken attachments | HTTP POST `{REQ}itemlist` | `userId`, `itemId` = comma separated item object ids, `key`, `rnd` | zlib XML, `Info` elements decoded into `GoodsInfo` by property name (`EmainAnnexResolve` `decompiled/core_module/scripts/yishi/resolve/EmainAnnexResolve.as`) keyed by `id` |
| A2 | Same, star mails | `EmailManager.getNewSatrMailAnnex` `EmailManager.as:148` | ids of type 4 mails | HTTP POST `{REQ}starlist` | `userId`, `starId` = comma separated star ids, `key`, `rnd` | zlib XML, `Info` elements decoded into `StarInfo` (`EmainAnnexStarResolve`), keyed by `id` |
| A3 | "Extrair" in the frame | `EmailFrame.__attachHandler` `decompiled/m11/scripts/emailII/EmailFrame.as:238` then `EmailControler.attachEmails` `decompiled/core_module/scripts/mvc/controler/EmailControler.as:231` | at least one mail; `checkAttach` (`:246`): the first selected mail with goods decides: type 4 needs a free star bag slot (`EmailHelp.checkCanGetStart` `decompiled/core_module/scripts/yishi/utils/EmailHelp.as:34`: `12 + starBagCount - stars in bag type 1 > 0`, tip "Mochila de cosmos cheia, falha ao receber"), others need a free bag slot (`checkCanGetGoods` `:21`, tip "Mochila cheia, falha ao receber"); no goods: tip "Não há anexo" | C>S 5022 0x139e `U_C_MAILITEM_MOVE` (`EmailSocketOutManager.getAttached` `decompiled/core_module/scripts/managers/EmailSocketOutManager.as:23`) | `MailMsg`: `mailsIdArray (#4, INT32, repeated)` mail ids; `position (#3, INT32, repeated)` one entry per mail, 0 = all slots; `player_id (#1)`, `mail_id (#2)` unset | 114, then 4131 |
| A4 | "Extrair" in the reading pane | `ReadEmailView.__closeHandler` `ReadEmailView.as:294` then `EmailControler.getAttached(id, 0)` `:272` | mail has goods, else "Não há anexo" | C>S 5022 | `mailsIdArray` = [id], `position` = [0] | as A3 |
| A5 | Click one attachment slot | `ReadEmailView.__itemClickHandler` `ReadEmailView.as:309` | item slot: pseudo item (`templateId < 0`) or a free bag slot; star slot: free star slot | C>S 5022 | `mailsIdArray` = [id], `position` = [slot 1..5] | as A3 |

## 4. Server messages (server to client)

| Route | Message | Client receiver | When | Reaction |
|---|---|---|---|---|
| HTTP `itemlist` response | zlib XML, `Info` elements with `GoodsInfo` property names as attributes: `id` (item object id = `AnnexN`), `templateId`, `userId`, `pos`, `objectId`, `bagType`, `isBinds`, `isUsed`, `isNew`, `validDate`, `beginDate`, `count`, `strengthenGrade`, `join1`..`join4`, `randomSkill1`..`randomSkill5`, `mouldGrade`, `appraisal_skill`, `isExist` (`decompiled/core_module/scripts/yishi/datas/goods/GoodsInfo.as`) | `EmailManager.__onGetAnnexGoodComplete` `EmailManager.as:200` | A1 | caches by `id`, dispatches `ANNEX_CALLBACK` (the reading pane refreshes) |
| HTTP `starlist` response | zlib XML, `Info` elements: `id`, `userId`, `bagType`, `pos`, `grade`, `gp`, `tempId` (star template), `count` (`decompiled/core_module/scripts/mvc/module/star/StarInfo.as:15`) | `EmailManager.__onGetAnnexStarComplete` `EmailManager.as:170` | A2 | caches by `id` |
| S>C 114 0x0072 `U_C_MAILITEM_MOVE_RESULT` | `MailPickupRspMsg`: `pickupResult (#1, PickupResult, repeated)`: `mail_id (#1, INT32)`, `attach_index (#2, INT32)` slot 1..5, `result (#3, BOOL)` | `EmailManager.__attachedHandler` `EmailManager.as:250` | response to 5022, one entry per slot attempted | any `result == false` on a mail that still has goods: type 4 tip "Mochila de cosmos cheia, não é possível extrair anexo" (`command02`), type 5 silent, others "Mochila cheia, não é possível extrair anexo" (`command03`), stop. If failures exist but no goods remain: "Extração de anexo sucedido" (`command04`). All true: no tip (the 4131 update refreshes the view) |
| S>C 4131 0x1023 `U_C_MAIL_LIST` | `ReceiveMailMsg`: `mailInfos (#1, MailInfoMsg, repeated)`. `MailInfoMsg`: `id (#1, INT32)`, `mailType (#2, INT32)`, `sendId (#3, INT32)`, `sendNickName (#4, STRING)`, `receiveId (#5, INT32)`, `receiveNickName (#6, STRING)`, `sendDate (#7, STRING)`, `readDate (#8, STRING)`, `title (#9, STRING)`, `contents (#10, STRING)`, `removeDate (#11, STRING)`, `validityDate (#12, INT32)`, `annex1 (#13, INT32)`, `annex1Name (#14, INT32)`, `annex1Count (#15, INT32)`, `isAnnex1 (#16, BOOL)`, `annex2..5` (#17 to #32 in the same pattern), `isExist (#33, BOOL)`, `sendType (#34, INT32)`, `sendPlayerGrades (#35, INT32)` | `EmailManager.__attachedMailListUpdate` `EmailManager.as:230` (`EmailHelp.transferToMailInfo` `EmailHelp.as:49`) | after a pickup, for each touched mail (Assumption: also usable for any server side mail change) | replaces fields of existing mails, removes taken attachment cache entries (`EmailCategory.refreshAnnex` `EmailCategory.as:287`), refreshes rows |

Item and currency changes caused by the pickup are pushed by the inventory and currency features (bag update packets, `PlayerMsg` gold/diamonds).

## 5. Rules and formulas

- Slot semantics (`EmailInfo.as:184`): `AnnexN > 0` real item object stored for the mail (details from `itemlist`); `AnnexN < 0` pseudo item: client shows template `AnnexNName` with count `AnnexNCount` and allows pickup even with a full bag (`ReadEmailView.as:316`); `AnnexN == 0` empty slot. A slot is pending when `IsAnnexN` is false and `AnnexN != 0` (`hasGoods`, `getFirstGoodsIndex`).
- Mail type 4 slots refer to stars (`StarInfo`), not items.
- Pickup is per slot atomic: each slot either moves fully or fails; a full bag fails the remaining item slots (result false), pseudo items always succeed (Assumption).
- Position 0 means every pending slot of that mail, in slot order.
- Bag capacity checks are repeated server side (inventory feature).

## 6. Templates

| File | Use |
|---|---|
| `raw/xml/tempinfos/ItemTemplate*` (inventory feature) | `AnnexNName` and `templateId` icons and names |
| Star templates (cosmos feature) | `tempId` icon |
| `raw/xml/tempinfos/ConfigInfos.xml` | none specific |

## 7. Persistent state

```sql
CREATE TABLE mail.attachment (
    mail_id         integer     NOT NULL REFERENCES mail.mail(mail_id) ON DELETE CASCADE,
    slot            smallint    NOT NULL CHECK (slot BETWEEN 1 AND 5),
    kind            text        NOT NULL CHECK (kind IN ('item', 'pseudo', 'star')),
    item_object_id  integer,                       -- AnnexN for 'item' (inventory item row held by the mail)
    star_id         integer,                       -- AnnexN for 'star'
    pseudo_id       integer,                       -- negative AnnexN for 'pseudo' (unique per mail)
    template_id     integer     NOT NULL,          -- AnnexNName
    count           integer     NOT NULL CHECK (count > 0), -- AnnexNCount
    taken_at        timestamptz,                   -- IsAnnexN
    PRIMARY KEY (mail_id, slot),
    CHECK ((kind = 'item' AND item_object_id IS NOT NULL) OR (kind = 'star' AND star_id IS NOT NULL) OR (kind = 'pseudo' AND pseudo_id < 0))
);
```

Items attached to a mail are inventory rows owned by the receiver with a "mail" bag location (inventory feature) so `itemlist` can return their full state (strengthen, joins, random skills). Pseudo items (currencies, experience) are converted on pickup.

## 8. Backend implementation notes

- HTTP `mail::attachments::handle_itemlist` and `handle_starlist`: authenticate, parse ids, return only rows attached to mails of that receiver.
- Socket `mail::attachments::handle_pickup` (5022): for each (mail id, position): check ownership and not deleted; select pending slots; in one transaction per mail move items to the bag (inventory API, respecting free slots), stars to the star bag, credit pseudo items (currency API); set `taken_at`. Respond 114 with one `PickupResult` per attempted slot; push 4131 with the updated rows; then the inventory/currency pushes.
- Internal API `mail::attachments::send_system_mail(receiver, title, contents, mail_type, attachments)` used by every reward producer (activities, guild, auction returns, etc.). It calls `mail::mailbox::deliver` and creates attachment rows; pseudo ids are assigned -1, -2, ... per mail.
- Log every pickup (economy audit).

## 9. Open questions and assumptions

1. Pseudo item template ids (negative ids such as -500 gold seen in `mail_rewards = -500,1000|...` in `ConfigInfos.xml`) are defined by the inventory/currency features; Assumption: `AnnexNName` carries that negative template id and `AnnexN` a negative placeholder.
2. Whether 4131 is also sent for read state changes is unknown; the client handles it generically.

## 10. Implementation checklist

- [ ] Table `mail.attachment` and the mail bag location in inventory
- [ ] `itemlist` and `starlist` servlets
- [ ] Pickup 5022 with position 0 and per slot
- [ ] 114 results and all four client tips
- [ ] 4131 updated mail rows
- [ ] `send_system_mail` API with items, pseudo items and stars
- [ ] Test: full bag partial pickup, pseudo item pickup with full bag, star mail pickup
