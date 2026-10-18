# Guild group chat

Feature `friends`, module `guild-group-chat`. The IM style group window for the guild (client package `groupchat`): member list with heads and VIP marks, guild channel messages, local history, announcement ("Anúncio") editing and an unread alert switch.

Conventions as in [friend-list.md](friend-list.md).

## 1. Overview

The window is a different view of the guild chat channel (5): sending uses `ChatManager.chatNormal(text, 5)` (C>S 15005) and receiving uses S>C 83 on channel 5, which `ChatManager` forwards as `CHAT_FROM_CONSORTIA` to the group chat model. The member list comes from the guild member list (guild feature); head ids are refreshed with 15038/4256 (`from` 2 or 3) and VIP changes with 4455. The announcement is the guild `groupPlacard`, modified with C>S 8544 (guild feature) and read from `ConsortiaInfoMsg`. History is client side.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `consortiagroupchat.ConsortiaGroupChatFrame` `decompiled/m12/scripts/groupchat/ConsortiaGroupChatFrame.as:136` | buttons "Minha Guilda", "Histórico", "Fechar", "Enviar", "Modificar"; "Anúncio"; members "Membros"; alert toggle tips "Desabilitar Alerta" / "Habilitar Alerta"; warning `friends.im.view.IMChatInfoView.Notice` | Guild chat window (input channel 5, `:232`), announcement edit (`__updateBtnHandler` `:474`), open guild frame (`:442`), history (`:448`) | controller `consortiagroupchat` (`ConsortiaGroupChatControler.frameClassName` `decompiled/core_module/scripts/mvc/controler/ConsortiaGroupChatControler.as:40`) from the friends frame (`decompiled/m12/scripts/friends/view/FriendsFrame.as:425`) and the toolbar pop tip button (`MainToolBar.__poptipBtnClickHandler` `decompiled/core_module/scripts/ui/maintoolbar/MainToolBar.as:2503`) | `ConsortiaGroupChatModel.curConsortiaChats`, guild members |
| `ConsortiaGroupChatHistoryView` `decompiled/m12/scripts/groupchat/view/ConsortiaGroupChatHistoryView.as` | | Paged local history | "Histórico" | `historyArray` |
| `ConsortiaGroupChatPlayerItem` `decompiled/m12/scripts/groupchat/view/ConsortiaGroupChatPlayerItem.as` | | Member row; click opens IM (`:113`) | member list | head, name, VIP, online |
| `im.view.IMConsortiaGroupChatMsgBoxItem` `decompiled/core_module/scripts/im/view/IMConsortiaGroupChatMsgBoxItem.as` | `consortiagroupchat.msgBoxItemNameTxt` | Unread entry in the IM message box | unread guild messages | |

## 3. Routes (client to server)

| # | UI control | Client sender | Client checks | Route | Request | Response |
|---|---|---|---|---|---|---|
| G1 | "Enviar" / Enter | `ConsortiaGroupChatFrame.sendChat` `:363` then `ChatManager.chatNormal` | not empty ("Mensagem em branco, não é possível enviar"); 1 s throttle ("Intervalo entre mensagens deve ser maior que 1 segundo"); `ChatHelper.checkCanSend` (level 6, guild) | C>S 15005 | `ChatChannelMsg` channel 5 (see [../chat/channels.md](../chat/channels.md)) | 83 channel 5 to online guild members |
| G2 | "Modificar" announcement | `__updateBtnHandler` `:474` then `ConsortiaGroupChatControler.sendModifyGroupPlacard` `ConsortiaGroupChatControler.as:154` (forbidden words in name or chat lists block: `consortia.ConsortiaControler.command05`) then `ConsortiaSocketOutManager.sendModifyGroupPlacard` `decompiled/core_module/scripts/managers/ConsortiaSocketOutManager.as:87` | guild right (Assumption: placard right, see [../guild/ranks.md](../guild/ranks.md)) | C>S 8544 0x2160 `U_C_CONSORTIA_GROUP_PLACARD` | `consortia.ConsortiaMsg`: `group_placard (#18, STRING)` | guild info refresh (`ConsortiaInfoMsg.groupPlacard`, read in `ConsortiaManager` `decompiled/core_module/scripts/yishi/manager/ConsortiaManager.as:547`) |
| G3 | Member head refresh | `ConsortiaGroupChatControler` listens to 4256 (`:116`) | | C>S 15038 with `from` 2 or 3 (sender in the guild/group views) | `InfoReqMsg` | 4256 |

## 4. Server messages (server to client)

| Route | Message | Client receiver | When |
|---|---|---|---|
| S>C 83 channel 5 | `ChatChannelMsg` | `ChatManager.__channelChatHandler` (`CHAT_FROM_CONSORTIA`) then group chat model | guild message |
| S>C 4256 | `simple.RelationPlayerMsg` with `from` 2 or 3 | `ConsortiaGroupChatControler.__getSimpleAndSnsInfoHandler` `:134` updates the member head id | response to G3 |
| S>C 4455 0x1167 `U_C_CONSORTIA_VIP` | `vip.VipToConsortiaMsg`: `userid (#1, INT32)`, `is_vip (#2, BOOL)`, `vip_type (#3, INT32)`, `consortia_id (#4, INT32)` | `ConsortiaGroupChatControler.__vipInfoChangeHandler` `:120` | a guild member's VIP state changed (push to online guild members) |

## 5. Rules and formulas

- Same rules as the guild channel (level 6, guild membership, filter).
- Announcement text: forbidden word check client side; Assumption max 100 characters.
- History and unread alerts are client only (`SharedManager`).

## 6. Templates

None.

## 7. Persistent state

None of its own: guild messages are logged by [../chat/channels.md](../chat/channels.md); the placard is a guild column (guild feature).

## 8. Backend implementation notes

- No dedicated handler: channel 5 in `chat::channels::handle_send`; 8544 in the guild feature (`guild::profile::handle_set_group_placard`); 4455 pushed by the VIP feature to guild members.

## 9. Open questions and assumptions

1. Placard edit right and length.

## 10. Implementation checklist

- [ ] Channel 5 messages appear in the group window
- [ ] Member list heads (4256) and VIP updates (4455)
- [ ] Announcement edit through 8544 and display from guild info
- [ ] Unread alert in the IM message box
