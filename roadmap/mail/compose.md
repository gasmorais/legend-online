# Compose and send

Feature `mail`, module `compose`. Writing a mail to a player, replying, and the guild chairman mass mail.

Conventions as in [mailbox.md](mailbox.md).

## 1. Overview

The write frame takes a recipient nickname (typed, or picked from the friend list or the guild member list), a title and a text. If the recipient was picked from a list the client already knows the user id; otherwise it resolves the nickname with the shared player search (8257/4170) and then sends 8205. Sending costs 100 gold, checked client side. The guild chairman can send one mail to selected guild members for 50 diamonds with `send_type = 2`. Mails are text only: players cannot attach items.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `emailII.view.WriteEmailFrame` `decompiled/m11/scripts/emailII/view/WriteEmailFrame.as:84` | "Escrever Email" (`emailII.view.WriteEmailFrame.title`); cost "{0} ouro" with 100 (`:98`); buttons "Enviar", "Cancelar"; recipient combo with tabs "Amigos" and "Guilda", tip "Lista de amigos" | Compose | controller `writeemail` openType `email.WriteEmailFrame` from `EmailFrame.__writeHandler` `decompiled/m11/scripts/emailII/EmailFrame.as:277` and `ReadEmailView.__sendHandler` `decompiled/m11/scripts/emailII/view/ReadEmailView.as:268` (reply prefills the nickname, `WriteEmailFrame.show` `:401`, `sendEmailToPerson` `:378`) | friends with relation 1 (`getFriendNameList` `:364`), guild members (`_comConsortia` `:341`) |
| `consortia...ConsortiaEmailGroupSendView` `decompiled/m6/scripts/consortia/view/myConsortia/chairmanPath/consortiaEmail/ConsortiaEmailGroupSendView.as` | `consortia.view.myConsortia.chairmanPath.ConsortiaEmailGroupSengView.title` | Guild mass mail with member checklist, title max 15 | guild member page mail button (`ConsortiaStaffPage._consortEmailBtnHandler` `decompiled/m6/scripts/consortia/view/myConsortia/ConsortiaStaffPage.as:350`) | guild members |

## 3. Routes (client to server)

| # | UI control | Client sender | Client checks | Route | Request | Response |
|---|---|---|---|---|---|---|
| C1 | "Enviar" with an unknown nickname | `WriteEmailFrame.__sendHandler` `WriteEmailFrame.as:264` | recipient not empty ("Destinatário não pode estar em branco"), title not empty ("Título não pode estar em branco"), text not empty ("Conteúdo não pode estar em branco"); title and text pass `FilterWordManager.filterWrod`; spaces removed when `VersionSwitch.FILTER_TRIM`; nickname width <= 12 (`:219`); text <= 7 lines (`:234`); title max 15 chars (`:105`) | C>S 8257 0x2041 `C_PLAYER_SEARCH` | `SimplePlayerSearchReqMsg`: `other_nickname (#1, STRING)` | 4170 |
| C2 | Search answer, or "Enviar" with a picked recipient | `WriteEmailFrame.__getUserInfoHandler` `:244` (case insensitive nickname match, else "Usuário inexistente") or `__sendHandler` direct, then `sendEmail` `:314` then `EmailControler.sendEmail` `decompiled/core_module/scripts/mvc/controler/EmailControler.as:277` | gold >= 100, else "Ouro Insuficiente" (`public.gold`); level >= 6 to open the frame ("Nível inferior a {0}, não é possível enviar email!") | C>S 8205 0x200d `U_C_MAIL_SEND` (`EmailSocketOutManager.sendEmail` `decompiled/core_module/scripts/managers/EmailSocketOutManager.as:46`) | `MailSendReqMsg`: `receiverUserId (#1, INT32, repeated)` = [recipient id]; `title (#2, STRING)`; `contents (#3, STRING)`; `send_type (#4, INT32)` = 1; `pay_type (#5, INT32)` = 0 | Assumption: no direct reply packet (the frame closes immediately); gold update via `PlayerMsg` (3); errors via 111 alert; receiver gets 148 |
| C3 | Reply "Responder" | `ReadEmailView.__sendHandler` `ReadEmailView.as:268` | blocked for system mails (`MailType == 2` or `SendId == 0`: "Esse é um email do sistema, não responda"); level >= 6 | opens C1/C2 | | |
| C4 | Guild mass mail send | `ConsortiaEmailGroupSendView.sendEmail` `ConsortiaEmailGroupSendView.as:233`, confirm "USEBINDPOINT_ALERT" with `Mail_NeedPoint` diamonds, then `ConsortiaControler.sendEmail` `decompiled/core_module/scripts/mvc/controler/ConsortiaControler.as:1099` | recipients not empty, title and text not empty; diamond cost 50 (`ConfigInfos.xml` `Mail_NeedPoint`) | C>S 8205 | `receiverUserId` = selected members; `send_type` = 2; `pay_type` = 0 when the "use bound diamonds" checkbox is set, 1 otherwise | as C2 |

## 4. Server messages (server to client)

| Route | Message | Client receiver | When |
|---|---|---|---|
| S>C 4170 0x104a `U_C_PLAYER_SEARCH` | `SimplePlayerSearchRspMsg`: `info (#1, simple.SimplePlayerInfoMsg)`, read `userId (#1)`, `nickName (#2)`; absent `info` = not found | `WriteEmailFrame.__getUserInfoHandler` `WriteEmailFrame.as:244` (also the guild recruit frame listens, see [../guild/membership.md](../guild/membership.md)) | response to 8257 |
| S>C 148 `U_C_NEW_MAIL` | see [mailbox.md](mailbox.md) | receiver | after delivery |
| S>C 3 `U_C_PLAYER_INFO` | `PlayerMsg` gold or `point` fields | `PlayerManager` | after the cost is debited |
| S>C 111 0x006f `U_C_CHANNEL_ALERT` | `ChatChannelMsg.encode_msg` text | `BaseManager.__serverBroadcastHandler` | Assumption: any rejection (recipient missing, insufficient gold, forbidden words) |

## 5. Rules and formulas

- Cost: 100 gold per send (`ConfigInfos.xml` `Mail_NeedGold = 100`, client constant in `WriteEmailFrame.as:98` and `EmailControler.as:280`). Assumption: charged once per send, not per recipient, for `send_type = 1` (single recipient).
- Guild mass mail: `Mail_NeedPoint = 50` diamonds ("【公会】会长群发邮件"), only for the chairman (guild rights, see [../guild/ranks.md](../guild/ranks.md)); `pay_type 0` allows bound diamonds first.
- Level 6 to write or reply (`EmailFrame.as:283`, `ReadEmailView.as:281`).
- Text filtering: forbidden word replacement is done client side; the server must re-filter.
- Recipient must exist; Assumption: sending to oneself is rejected; blacklist (relation 2) of the receiver blocks delivery silently (Assumption).
- Delivered mail: `mail_type = 1` (player) or 2 for guild mass mail (Assumption, since replies to guild mails are blocked only for type 2), `send_type` copied, `sender_level` = sender hero level, `validity_days` 30 (Assumption).

## 6. Templates

| File | Record |
|---|---|
| `raw/xml/tempinfos/ConfigInfos.xml` | `Mail_NeedGold` 100 (邮费), `Mail_NeedPoint` 50 |

## 7. Persistent state

Uses `mail.mail` ([mailbox.md](mailbox.md)). Optional anti spam counter:

```sql
CREATE TABLE mail.send_log (
    sender_id     integer     NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
    sent_at       timestamptz NOT NULL DEFAULT now(),
    receiver_count integer    NOT NULL CHECK (receiver_count > 0),
    send_type     smallint    NOT NULL,
    PRIMARY KEY (sender_id, sent_at)
);
```

## 8. Backend implementation notes

- `mail::compose::handle_send` (8205). Validation order: sender level >= 6; `send_type` in (1, 2); title 1..15 characters, contents not empty and <= 7 lines (Assumption: 300 characters); forbidden words filter; recipients exist and are distinct; for `send_type = 2` sender is guild chairman and every recipient is a member of that guild; cost available (gold 100, or diamonds 50 with `pay_type`). Transaction: debit cost, insert one `mail.mail` per recipient (`mail::mailbox::deliver`), insert `mail.send_log`. After commit: push `PlayerMsg` currency update to the sender, 148 to each online recipient.
- `mail::compose::handle_player_search` is the shared 8257 handler (guild feature defines it too): case insensitive exact nickname lookup, respond 4170 with `info` or without it.

## 9. Open questions and assumptions

1. The client never listens for a send result; any error feedback must use 111 (Assumption).
2. Content length limit beyond 7 lines is unknown.
3. Whether guild mass mails are free of the gold fee (Assumption: only the diamond cost applies).

## 10. Implementation checklist

- [ ] Write frame opens at level 6, reply prefill, system mail reply blocked
- [ ] Nickname lookup 8257/4170 and "Usuário inexistente"
- [ ] Send 8205 with gold debit and delivery to the receiver (148)
- [ ] Friend and guild recipient pickers send the known id directly
- [ ] Guild mass mail (send_type 2, diamonds, bound diamond option)
- [ ] Error alerts via 111
- [ ] Test: insufficient gold blocked client side and server side
