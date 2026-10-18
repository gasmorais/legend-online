# Instant messages and chat state

Feature `friends`, module `instant-messages`. Private chat windows (IM), message delivery, chat state with auto reply (busy, away, do not disturb), IM window actions and local history.

Conventions as in [friend-list.md](friend-list.md).

## 1. Overview

Any player can be messaged (friend or not). The IM window sends 15023; the server echoes the stored message to the sender as 4236 (or `result = -1` when the target is offline) and delivers it to the target as 4231. Unknown senders are first resolved with 15038/4256 so the window can show their profile. Each player has a chat state: online (7), away (4), do not disturb (5), busy (6), each with an auto reply text; the client sets 7 at startup, switches to 4 after 5 minutes without input and back to 7 on activity, and the player can pick a state and edit the reply. The server broadcasts state changes (4232). History is kept only on the client (Flash shared object). Cross server private chat uses the relation graph service (see [cross-server-relations.md](cross-server-relations.md)).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `core.IMFrame` (`im.IMFrame` `decompiled/m12/scripts/im/IMFrame.as:124`) | buttons "Registro de mensagem", "Enviar" (tip "Pressione Enter para enviar"), "Fechar"; tips "Dar Flores", "Convite de Guilda", "Pedir em casamento", "Adicionar amigo", "Excluir Amigo", "Lista Negra", "Copiar", "Limpar Tela", "Convidar para a Equipe"; warning "No chat, atente-se à não confiar em informações de ganho de prêmios, venda de diamantes ou de transferência bancária." | One conversation; max 3 open windows ("Não abra múltiplas janelas de conversa ao mesmo tempo"); cannot talk to self ("Favor não conversar consigo") (`FriendControler.showFrame` `decompiled/core_module/scripts/mvc/controler/FriendControler.as:126`) | friends controller type 4 from `IMManager.createIMFrame` (friend row double click, menus "Privado", group chat member, chat name menu) | target `ThaneInfo`, profile (`IMFriendInfoView`), messages (`IMChatInfoView`) |
| `IMHistoryView` `decompiled/m12/scripts/im/view/IMHistoryView.as` | "Registro de mensagem", "Data" | Local history, 8 per page (`IMManager.getIMHistoryTotalPages` `decompiled/core_module/scripts/managers/IMManager.as:535`) | IM window | cached messages |
| `IMStateComBox` `decompiled/m12/scripts/im/view/IMStateComBox.as` + `IMStateReplyInputView` `IMStateReplyInputView.as` | "Online", "Ausente", "Ocupado", "Não pertube"; reply input "Insira resposta (máximo 60 letras)", "Conteúdo contém caractéres inválidos"; default reply "Oi, no momento não estou, entrarei em contato mais tarde." | Pick state and edit the auto reply | friends frame / IM | `IMModel.stateList` (`decompiled/core_module/scripts/mvc/module/friends/IMModel.as:55`) |
| `im.view.IMMsgBoxView` / `IMMsgBoxItem` `decompiled/core_module/scripts/im/view/IMMsgBoxView.as` | | Unread message box near the toolbar (friend button shine) | unread IM | `IMModel.unreadMsgDic` |
| `simplegame.roses.IMQuickRosePresentView` `decompiled/core_module/scripts/simplegame/roses/IMQuickRosePresentView.as` | title `friends.view.RosePresentView.title` | Give roses to a friend from the IM window | "Dar Flores" (friends type 6) | rose count |

## 3. Routes (client to server)

| # | UI control | Client sender | Client checks | Route | Request | Response |
|---|---|---|---|---|---|---|
| I1 | "Enviar" or Enter | `IMFrame.__onSendMsgBtnClick` `IMFrame.as:693` then `IMManager.sendIMMsg` `IMManager.as:575` | not empty ("Conteúdo não pode estar em branco"); target online unless robot ("O adversário não está online", also printed on channel 3); 1 s between messages ("Intervalo entre mensagens deve ser maior que 1 segundo"); forbidden word filter; robots are answered locally | C>S 15023 0x3aaf `CH_PRIVATE_CHAT` | `im.ChatFriendMsg`: `from_id (#1, INT32)` own id, `from_nick (#2, STRING)` own nickname, `to_id (#3, INT32)` target, `encode_msg (#4, STRING)` text | 4236 to the sender, 4231 to the target |
| I2 | Same with a cross server target | `IMFrame.as:755` | as I1 | C>S 9606 `C_GLOBAL_RELATION_GRAPH` | `RelationGraphOpMsg` op 5, see [cross-server-relations.md](cross-server-relations.md) | 348 channel 1 |
| I3 | State selection | `IMStateComBox` `:123` then `IMManager.sendChangeIMState` `IMManager.as:586` | none | C>S 15029 0x3ab5 `CH_EXCHANGE_STATE` | `chat.ChatStateMsg`: `chat_state (#2, INT32)` 7, 4, 5 or 6; `replay_str (#4, STRING)` "" | 4232 |
| I4 | Edit auto reply | `IMStateReplyInputView` `:107` | <= 60 width, no forbidden words | C>S 15029 | `chat_state` = edited state id, `replay_str` = text | 4232 |
| I5 | Startup, idle 300 s, activity | `IMManager` constructor `:58` (sends 7), `NoOperationCallUtil(300000, setLeaveIMState, setOnlineIMState)` `:71`, `setLeaveIMState` `:325` (state 4 with its reply), `setOnlineIMState` `:334` (7) | none | C>S 15029 | as I3 | 4232 |
| I6 | Unknown sender or new contact | `IMManager.__receiveIMMsgHandler` `:168`, `__imSendMsgResponseHandler` `:130` then `PlayerManager.sendRequestSimpleAndSnsInfo(id, 0)` | not in friend or recent list | C>S 15038 | see [friend-list.md](friend-list.md) F8 | 4256 |
| I7 | IM window actions | invite team (`:248`, 8738), "Dar Flores" (`:359`: must be a friend with relation 1 "Jogador não é seu amigo", must own roses item 2170001 "Não há este item na Mochila"; then item use 5006 `ItemUseMsg` with `friend_id`), propose (`:386`: level 36, single "Você já tem parceiro, não pode pedir em casamento."), guild invite (`:402`: right 9 and a guild), add friend (`:427`), delete (`:454`), blacklist (`:549`) | per action | owned by team, inventory, marriage, guild and friend list modules | | |

## 4. Server messages (server to client)

| Route | Message | Client receiver | When | Reaction |
|---|---|---|---|---|
| S>C 4236 0x108c `U_CH_PRIVATE_CHAT_REPLY` | `im.ChatFriendMsg`: `from_id (#1)`, `from_nick (#2)`, `to_id (#3)`, `encode_msg (#4)` filtered text, `send_date (#5, STRING "YYYY-MM-DD hh:mm:ss")`, `result (#6, INT32)` -1 = target offline, else 0 | `IMManager.__imSendMsgResponseHandler` `IMManager.as:130` | response to 15023 | `-1`: tip "O adversário não está online" and channel 3 notice; else caches and shows the message, adds the target to recent contacts |
| S>C 4231 0x1087 `U_CH_PRIVATE_CHAT` | `im.ChatFriendMsg` (same fields) | `IMManager.__receiveIMMsgHandler` `:168` | push to the online target | known sender: recent contact update, unread queue or open window, friend button shine; unknown: queued until 4256 |
| S>C 4232 0x1088 `U_CH_EXCHANGE_STATE` | `chat.ChatStateMsg`: `user_id (#1, INT32)`, `chat_state (#2, INT32)`, `result (#3, INT32)` 1 = applied, `replay_str (#4, STRING)` | `IMManager.__imStateChangeHandler` `:104` | response to 15029 (own id) and push to online players who have the user in their friend or recent list | own: stores state and reply; others: updates the friend row state |
| S>C 4256 | see [friend-list.md](friend-list.md) | | | |

## 5. Rules and formulas

- State ids: 7 online, 4 away ("Ausente"), 6 busy ("Ocupado"), 5 do not disturb ("Não pertube") (`IMModel.as:61` to `:71`); 0 is offline (server only).
- Idle timeout 300000 ms to away (client).
- Auto reply delivery (Assumption): when a message reaches a target whose state is 4, 5 or 6 with a non empty reply, the server sends the reply back to the sender as a 4231 from the target, once per conversation per state change.
- Client throttle 1 message per second; Assumption: server throttle 1 per second and 200 characters.
- Offline messages are not stored (the client blocks sending to offline players; the server answers -1).
- Blacklist: the target's blacklist (relation 2 with the sender) silently drops messages (Assumption, consistent with `readFriendInfo` cleaning IM caches for blacklisted users).
- History: client only (`SharedManager.saveIMHistory`), 8 per page.

## 6. Templates

None.

## 7. Persistent state

```sql
CREATE TABLE friends.chat_state (
    player_id    BIGINT     PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
    state        smallint    NOT NULL DEFAULT 7 CHECK (state IN (4, 5, 6, 7)),
    reply_away   varchar(60) NOT NULL DEFAULT '',
    reply_busy   varchar(60) NOT NULL DEFAULT '',
    reply_dnd    varchar(60) NOT NULL DEFAULT '',
    updated_at   timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE friends.private_message_log (
    message_id   bigserial   PRIMARY KEY,
    sender_id    integer     NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
    receiver_id  integer     NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
    content      text        NOT NULL,
    sent_at      timestamptz NOT NULL DEFAULT now()
);
CREATE INDEX private_message_log_pair_idx ON friends.private_message_log (sender_id, receiver_id, sent_at DESC);
```

The log is for moderation only (the client keeps its own history).

## 8. Backend implementation notes

| Opcode | Handler |
|---|---|
| 15023 | `friends::instant_messages::handle_send` |
| 15029 | `friends::instant_messages::handle_change_state` |

- Send: sender level >= 6 (Assumption, social level), not muted ([../chat/channels.md](../chat/channels.md)), throttle, filter, target exists; if target offline respond 4236 `result = -1`; if blacklisted by the target respond 4236 normally but do not deliver (Assumption); else respond 4236 with `send_date` and push 4231 to the target; apply the auto reply rule; log asynchronously.
- State: validate the state id and reply length; upsert `friends.chat_state` (reply column per state); respond 4232 (`result = 1`) and push 4232 to online players with a relation row targeting the player. On logout the state is reset to 7 for the next login (Assumption) and friends get 161.

## 9. Open questions and assumptions

1. Auto reply delivery mechanism (server message vs client) is not visible.
2. Whether offline messages were stored by the original server (the client suggests no).

## 10. Implementation checklist

- [ ] 15023 send, 4236 echo (including `-1` offline), 4231 delivery
- [ ] Unknown sender profile resolution (15038/4256) works with queued messages
- [ ] 15029 state changes, 4232 to self and friends; idle away and back
- [ ] Auto reply for away, busy, do not disturb
- [ ] IM window actions route to their features (team invite, roses, propose, guild invite, add, delete, blacklist)
- [ ] Table `friends.chat_state`, moderation log
- [ ] Test: max 3 IM windows, self chat blocked
