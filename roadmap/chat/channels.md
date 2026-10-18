# Chat channels

Feature `chat`, module `channels`. Sending and receiving normal chat messages, channel routing, recipients and limits.

Conventions: paths relative to the repository root; AS3 citations `decompiled/<module>/scripts/<path>.as:<line>`; opcodes from `protocol/opcodes.csv` or the client constant classes (`decompiled/core_module/scripts/yishi/datas/consant/ProtocolType.as`, `AcceptProtocolType.as`); fields `name (#tag, TYPE, repeated?)` from `protocol/proto.json`; "Assumption" marks behavior not visible in the client. Packet header field `extend1` is described in `protocol/socket.md`.

## 1. Overview

The client sends every normal message as `ChatChannelMsg` on C>S 15005 (`U_CH_CHANNEL_CHA`). For the current (8) and team (6) channels it fills `team` with the user ids that must receive the message (players visible in the scene, team members, room members). In cross server contexts it uses the cross opcodes (25024, 25096, 25211) and tags the packet header `extend1` with a sequence number. The server broadcasts the message as S>C 83 (`U_CH_CHANNEL_CHA`) to the right audience, with `encode_msg` already converted to the display markup ([chat-links.md](chat-links.md)). System messages from any feature use the same 83 push with system channels, and S>C 111 (`U_C_CHANNEL_ALERT`) shows floating alerts.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `chat.view.ChatInputViewII` `decompiled/core_module/scripts/chat/view/ChatInputViewII.as:98` | send tip `chat.view.ChatView.command03`; emoticon tip "Emoticon"; clean tip "Limpar" | Input line, channel selector (`InputChannelList`), history up/down (`__upDown` `:387`), slash shortcuts (`sendChat` `:454`) | always (chat bar) | current input channel |
| `chat.view.InputChannelList` `decompiled/core_module/scripts/chat/view/InputChannelList.as` | channel names from `ChatChannel.getChatChannelName` (`decompiled/core_module/scripts/chat/datas/ChatChannel.as:85`) | Channel choice | input | channels `[13,1,10,6,5,8,14,109,...]` (`ChatChannel.channels` `:72`) |
| `chat.view.ChatOutputViewII` `decompiled/core_module/scripts/chat/view/ChatOutputViewII.as` | "Limpar", "Expandir", "Diminuir" | Output with tabs per channel group (`__updateChatViewHandler` `:458`), name and link clicks ([chat-links.md](chat-links.md)) | always | `ChatModel` lists (50 messages per list, `ChatModel.MAX_CHAT_COUNT` `decompiled/core_module/scripts/chat/ChatModel.as:16`) |
| `ChatPopView` / bubble types 104 to 106 | none | Speech bubbles over avatars (Assumption: map scene feature) | | |

Channel table (`ChatChannel.as:10` to `:72`, names from `language.json`):

| Id | Constant | pt-BR name | Send route | Who receives (server) |
|---:|---|---|---|---|
| 8 | `CURRENT` | "Atual" | 15005 (team = scene players), 25024 in cross battles, 25096 cross campaign maps, 25211 sandbox | users in `team`, or the whole map/battle (Assumption when `team` is empty) |
| 10 | `WORLD` | "Global" | 8198 small bugle, see [bugles.md](bugles.md) | all online players |
| 1 | `BIGBUGLE` | "Megafone" | 5011, see [bugles.md](bugles.md) | all online players |
| 13 | `CROSS_BIGBUGLE` | "Megafone Inter-S" | 8623, see [bugles.md](bugles.md) | all servers of the cross group |
| 5 | `CONSORTIA` | "Guilda" | 15005 | online guild members |
| 6 | `TEAM` | "Equipe" | 15005 (team = members) or cross variants | ids in `team` |
| 14 | `GROUP_TEAM` | "Equipe" | 15005 (team = groupfb room members) | ids in `team` |
| 109 | `OUTYARD` | "Terralém" | 9609, see [bugles.md](bugles.md) | outyard (cross) players |
| 2 | `SYSTEM` | "Sistema" | server only | target players |
| 3 | `INFO` | "Mensagem" | server only (also client local notices) | target player |
| 7 | `ALERT` | none | server only | |
| 11 | `SYS_ALERT` | "Sistema" | server only; also updates the top bugle view | |
| 12 | `NOTICE` | "Comunicado" | server only; with `bigBugleType` 6, 7, 8, 9, 12 goes to the bugle list (marriage bugles) | |
| 15 | `GOLD_BIGBUGLE` | "Comunicado" | server only; bugle list with `userType` 1 | |
| 20 | `PERSONAL` | "Privado" | IM (15023), see [../friends/instant-messages.md](../friends/instant-messages.md) | |
| 21, 98 to 111 | `BOTTLE`, group chat render ids, `MYSTERYSHOP_LUCKYPLAYER`, `CHAT_POP`, bubbles, `POKER`, `CROSS_BUGLE_INVITE`, `STOKES_ORE`, `WISH_POOL` | client side display channels | not sent | |

## 3. Routes (client to server)

| # | UI control | Client sender | Client checks | Route | Request | Response |
|---|---|---|---|---|---|---|
| C1 | Enter or send button on channels 8, 5, 6, 14 | `ChatInputViewII.sendChat` `ChatInputViewII.as:454` then `ChatManager.chatNormal` `decompiled/core_module/scripts/chat/ChatManager.as:268` then `ChatSocketOutManager.sendChat` `decompiled/core_module/scripts/chat/ChatSocketOutManager.as:59` | `ChatHelper.checkCanSend` `decompiled/core_module/scripts/chat/utils/ChatHelper.as:53`: hero level >= 6 ("Seu nível é inferior a 6, essa função não pode ser utilizada"); not empty ("Conteúdo não pode estar em branco"); channel 8: 30 s between messages in normal scenes (`checkSceneType` `:182`), 2 s in battles, rooms, vehicle, game hall ("O intervalo de envio de mensagem é inferior a {0} segundos"); channel 5 needs a guild ("Você não juntou-se à nenhuma Guilda"); channel 6 needs a team context (`checkTeamChatScene` `:140`: Brave Legend team, free team, game hall, sandbox, vehicle, plane crisis or a room; never the space scene without team) ("Você não juntou-se à nenhuma equipe"); channel 14 needs a groupfb room ("Atualmente você não está na campanha da equipe, não pode usar esta função"); text trimmed, forbidden words replaced (`ChatHelper.parasMsgs` `:45`); chat ban window (`FORBIT_CHAT` switch, `ChatSocketOutManager.as:66`) drops the message silently | C>S 15005 0x3a9d `U_CH_CHANNEL_CHA` (header `extend1` = `ChatModel.protocalId` only in the game hall scene) | `ChatChannelMsg`: `channel (#1, INT32)`; `encode_msg (#3, STRING)` text with `[Name]` placeholders for links; `items (#17, ChatItemInfoMsg, repeated)`, `stars (#18, ChatStarInfoMsg, repeated)`, `powcards (#19, ChatPowCardInfoMsg, repeated)`, `shareTimeSpace (#29, STRING, repeated)` link payloads ([chat-links.md](chat-links.md)); `team (#6, INT32, repeated)` recipient ids for channels 8, 6, 14 (`initChatData` `:153`); `battle_id (#21, STRING)` and `server_name (#20, STRING)` in battle current chat | S>C 83 to recipients (including the sender) |
| C2 | Same in a battle of type 10 or 308 on channel 8 | `initBattleCurrentPlayer` `ChatSocketOutManager.as:248` returns true | as C1 | C>S 25024 0x61c0 `CR_CHANNEL_CHAT`, header `extend1` = sequence | `ChatChannelMsg` as C1 with `battle_id`, `server_name` | 83 with the same `extend1` |
| C3 | Channel 6 or 8 on a cross campaign map | `sendChat` switch on `CAMPAIGN_MAP_SCENE`/`BATTLE_SCENE`/`VEHICLE`/`SANDBOX_SCENE` with `mapModel.isCross` | as C1 | C>S 25096 0x6208 `CR_WARFIELD_CHAT`, `extend1` sequence | `ChatChannelMsg` + `server_name` | 83 |
| C4 | Channel 6 or 8 in the sandbox | same switch, `SandboxManager.exit == false` | as C1 | C>S 25211 0x627b `CR_SAND_BOX_CHAT`, `extend1` sequence | as C3 | 83 |
| C5 | Guild group chat window send | `ConsortiaGroupChatFrame.sendChat` `decompiled/m12/scripts/groupchat/ConsortiaGroupChatFrame.as:363` (channel 5, 1 s client throttle "Intervalo entre mensagens deve ser maior que 1 segundo") | as C1 | C>S 15005 | channel 5 | 83 |

Recipient list rules (`ChatSocketOutManager.as:248` to `:450`): current channel in campaign maps = players visible in the map (`initMapCurrentPlayer` `:345`); team channel = groupfb room members, or same `teamId` players on the map, or everyone on rapid maps (`initMapTeamPlayer` `:360`); free team members are added for channel 6 except on PvP, dusk, flame temple and SVS maps (`initFreedomTeamPlayer` `:414`); Brave Legend members (`:434`); room members (`:296`); game hall players (`:315`); plane crisis players (`:330`).

## 4. Server messages (server to client)

| Route | Message | Client receiver | When | Reaction |
|---|---|---|---|---|
| S>C 83 0x0053 `U_CH_CHANNEL_CHA` | `ChatChannelMsg` fields read (`ChatManager.__channelChatHandler` `ChatManager.as:110`): `channel (#1, INT32)`; `type (#2, INT32)` sender kind for system formatting (3 player link, 4 ...); `encode_msg (#3, STRING)` display markup; `other_id (#4, INT32)` sender user id (ignored for channels 2 and 3); `name (#5, STRING)` sender name; `consortia_id (#7, INT32)`, `consortia_name (#8, STRING)`; `user_type (#9, INT32)` (1 = GM/system style); `is_centerTip (#12, BOOL)` also show a center tip; `is_bigTip (#13, BOOL)` also show a tip and refresh the top bugle; `vip_grade (#14, INT32)`; `bigBugleType (#16, INT32)` bugle style (5 and 10 are not added to the normal lists); `server_name (#20, STRING)`; `appellid (#23, INT32)` title shown before the name; `job (#24, INT32)` when non zero only players of that job see it; `receive_name (#25, STRING)`; `grades (#26, INT32)`; `player_uuid (#28, STRING)`. Not read on receive: `team (#6)`, `limit_grade (#10)`, `max_grade (#11)`, `expUserIds (#15)`, `items (#17)`, `stars (#18)`, `powcards (#19)`, `battle_id (#21)`, `is_important (#22)`, `vipType (#27)`, `shareTimeSpace (#29)` | `ChatManager.__channelChatHandler` | every delivered message; header `extend1` echoes the sender's sequence for latency bookkeeping (`ChatModel.removeReceiveProtocol` `ChatModel.as:76`) | adds to the channel lists; channel 1, 15 and marriage notices go to the bugle list; channel 5 also feeds the guild group chat (`CHAT_FROM_CONSORTIA`); channel 11 refreshes the top bugle; channel 12 with `http://` splits a web link |
| S>C 111 0x006f `U_C_CHANNEL_ALERT` | `ChatChannelMsg.encode_msg (#3)` text (XML tags are replaced by their `name` attribute) | `BaseManager.__serverBroadcastHandler` `decompiled/core_module/scripts/yishi/manager/BaseManager.as:2171` | any server side error or notice | floating tip (not in battle) |
| S>C 4422 `SwitchInfoListMsg` | `switches (#1, SwitchInfoMsg, repeated)`: `switch_id (#1, INT32)`, `switch_type (#2, INT32)` (223 = chat ban), `is_open (#3, BOOL)`, `begin_date (#4, STRING)`, `end_date (#5, STRING)` | `BaseManager.__switchesUpdateHandler` `BaseManager.as:1505`, case 223 `:1605` | login and when operations change switches | while `is_open` and now in [begin, end) the client drops outgoing chat |

## 5. Rules and formulas

- Level 6 to send; rate limits per channel as above (client side; the server must enforce at least the same: 30 s on channel 8 in open maps, 2 s otherwise, Assumption).
- Message length: not limited in `checkCanSend`; Assumption: server truncates to 100 characters.
- Forbidden words are replaced client side; the server must filter again (shared word list `{TPL}zip_dirty.txt` (`raw/xml/zip_dirty.txt`, loaded as `ComponentSetting.ZhanPath` in `decompiled/core_module/scripts/yishi/lunch/StartupResourcesLoader.as:134`)).
- Players with `right != 1` (GM accounts, Assumption) send the raw text without the forbidden word filter (only HTML escaped, `ChatInputViewII.as:562`); the server must not trust this.
- Player channel 8 timestamps only update for `right == 1`.
- A player blocked by the receiver (blacklist, relation 2) should not be delivered (Assumption; the client has no receive side filter for channels).
- The client keeps 50 messages per list.

## 6. Templates

| File | Use |
|---|---|
| `raw/xml/zip_dirty.txt`, `raw/xml/proxy_dirty.txt` | forbidden word lists (`FilterWordManager`) |

## 7. Persistent state

```sql
CREATE SCHEMA IF NOT EXISTS chat;

CREATE TABLE chat.message_log (
    message_id    bigserial   PRIMARY KEY,
    sender_id     integer     REFERENCES player.players(player_id) ON DELETE SET NULL,
    channel       smallint    NOT NULL,
    guild_id      integer,
    content       text        NOT NULL,
    sent_at       timestamptz NOT NULL DEFAULT now()
);
CREATE INDEX message_log_sender_idx ON chat.message_log (sender_id, sent_at DESC);

CREATE TABLE chat.mute (
    player_id     BIGINT     PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
    muted_until   timestamptz NOT NULL,
    reason        text        NOT NULL DEFAULT ''
);

CREATE TABLE chat.global_switch (
    switch_type   integer     PRIMARY KEY,           -- 223 chat ban window
    is_open       boolean     NOT NULL DEFAULT false,
    begins_at     timestamptz,
    ends_at       timestamptz
);
```

The log is for moderation (GM tools, customer service reports). Rate limit state is in memory.

## 8. Backend implementation notes

| Opcode | Handler |
|---|---|
| 15005 | `chat::channels::handle_send` |
| 25024 | `chat::channels::handle_send_cross_battle` |
| 25096 | `chat::channels::handle_send_cross_warfield` |
| 25211 | `chat::channels::handle_send_sandbox` |

- Validation order: player level >= 6; not muted; global chat ban window; channel allowed for the sender (5 needs guild membership, 6 needs a team context, 14 needs a groupfb room); rate limit; length; word filter.
- Audience: 8 = intersection of `team` with players actually in the same scene (never trust the list blindly), or the scene audience if empty; 5 = guild members online; 6 and 14 = `team` intersected with real team/room members.
- Build the outgoing `ChatChannelMsg`: copy `channel`, set `other_id` = sender id, `name` = nickname, `grades`, `vip_grade`, `consortia_id`, `consortia_name`, `appellid`, `server_name`, `player_uuid`, `type` = 0 for players, and `encode_msg` = rendered markup ([chat-links.md](chat-links.md)); echo `extend1`.
- Provide `chat::system::send(players, channel, markup, flags)` for other features (system channels 2, 3, 11, 12, 15 and `is_centerTip`/`is_bigTip`), and `chat::system::alert(player, text)` for 111.
- Insert into `chat.message_log` asynchronously (batched).

## 9. Open questions and assumptions

1. Server side rate limits and maximum length are not visible.
2. Meaning of `type` values on received messages beyond the system formatter (`ChatFormat` `decompiled/core_module/scripts/chat/utils/ChatFormat.as:110`) is partially known: 3 = player link inside system text.
3. `limit_grade` and `max_grade` suggest level gated broadcasts (Assumption: server side filter for system announcements).

## 10. Implementation checklist

- [ ] 15005 send and 83 delivery for channels 8, 5, 6, 14
- [ ] Recipient validation for `team` lists
- [ ] Rate limits, level 6, mute table, chat ban switch 223 (4422)
- [ ] `extend1` echo for tagged sends
- [ ] Cross variants 25024, 25096, 25211
- [ ] System message API (channels 2, 3, 11, 12, 15) and alert 111
- [ ] Guild group chat window uses channel 5
- [ ] Moderation log
- [ ] Test: job filtered broadcast (`job` field) only reaches that job
