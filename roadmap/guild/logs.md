# Guild logs, login data, presence, chat and notifications

Area: guild core, module `logs`. Covers the guild event log ("Evento da Guilda"), the packets exchanged at login, member online/offline presence, the guild chat channel and the guild group chat window (including its notice), member VIP updates, toolbar and badge notifications, and the generic alert used for errors.

Conventions: see [membership.md](membership.md). No HTTP servlet is involved.

## Overview

- Event log: any member opens "Evento da Guilda" from the member tab (`decompiled/m6/scripts/consortia/view/myConsortia/ConsortiaStaffPage.as:326`); the client requests 8210 and lists events newest first. Each event is a type plus a pipe separated `remark` that the client colors per type.
- Login: after `PlayerMsg` (3) the client runs `ConsortiaManager.setup` (`decompiled/core_module/scripts/yishi/lunch/Yishi.as:739`) and later requests the invitation list (`Yishi.as:623`). Guild members request duties, members, guild info and treasure; others hook the level 15 robot invite and the invitation push.
- Presence: online members get 162 when a guildmate logs in and 163 when one logs out.
- Chat: channel 5 is the guild channel in the main chat bar and in the dedicated group chat window ("Chat da Guilda", toolbar `_poptipBtn`, `docs/ui/navigation.md:90`), which also shows a guild group notice editable with right 3.
- Notifications: toolbar guild button shine, the guild red dot counter (`InfoTipsManager` type 4) and tab badges.

## Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `ConsortiaEventFrame` (`decompiled/m6/scripts/consortia/view/myConsortia/event/ConsortiaEventFrame.as:48`) | "Evento da Guilda"; columns "Evento da Guilda", "Tempo de Ocorrência" | Event list, at least 11 rows (`ConsortiaModel.CONSORTIA_EVENT_LIST_NUM = 11`, `decompiled/core_module/scripts/mvc/module/consortia/ConsortiaModel.as:36`) | Staff page events button, always visible | `ConsortiaEventInfo` list |
| `ConsortiaEventItem` (`decompiled/m6/scripts/consortia/view/myConsortia/event/ConsortiaEventItem.as:60`) | type labels "Alteração de Membros", "Elevar Guilda", "Transferir Guilda", "Dedução da Guilda", "Evento da Guilda", "Acelerar Resfriamento", "Distribuição de Baú" | Row with type icon, decoded remark, time `DateFormatter.timeFormat1` | Event frame | `type`, `remark`, `create_date` |
| `ConsortiaGroupChatFrame` (`decompiled/m12/scripts/groupchat/ConsortiaGroupChatFrame.as:155`) | "Chat da Guilda" | Guild chat window with member list, history, group notice | `consortiagroupchat` controller (`decompiled/core_module/scripts/mvc/controler/ConsortiaGroupChatControler.as:45`, blocked without guild with "Não há Guilda"); friends frame group button | channel 5 messages, members (online first), `group_placard` |
| `ConsortiaApplyAction` popup (`decompiled/core_module/scripts/yishi/actions/consortia/ConsortiaApplyAction.as:43`) | "{0} o convida à participar da Guilda: {1}" | Invitation prompt ([membership.md](membership.md) M8) | 41 then 4135 | inviter and guild name |
| `CaseGoodsSendBackByMailAction` popup (`decompiled/core_module/scripts/yishi/actions/consortia/CaseGoodsSendBackByMailAction.as:38`) | "Items do depósito da Guilda foram retornados, verifique seu email, \nemail será guardado por 30 dias" plus date range | Notice after leaving when guild storage items were mailed back | 117 with `return_item` | date now to now + 30 days |

## Actions

| # | UI control | Client sender | Client checks | Route | Request message and fields | Resp |
|---|---|---|---|---|---|---|
| G1 | Open event frame | `ConsortiaEventFrame.initData` `ConsortiaEventFrame.as:72` -> `ConsortiaControler.getConsortiaEventInfos` `decompiled/core_module/scripts/mvc/controler/ConsortiaControler.as:774` -> `ConsortiaSocketOutManager.getConsortiaEventInfos` `decompiled/core_module/scripts/managers/ConsortiaSocketOutManager.as:210` | in a guild | C>S 8210 0x2012 `U_C_EVENT_LIST` | no body | 4136 |
| G2 | Login, member path | `ConsortiaManager.setup` `decompiled/core_module/scripts/yishi/manager/ConsortiaManager.as:127` | `consortiaID != 0` | C>S 8211 0x2013 `U_C_DUTY_LIST`, C>S 8207 0x200f `U_C_CONSORTIAUSER_LIST`, C>S 8212 0x2014 `U_C_CONSORTIA_INFO`, C>S 9629 0x259d `C_CONSORTIA_TREASURE_OP` x3 (op 0, 1, 2; economy, repeated every 30 min, `:579`) | see [ranks.md](ranks.md) R1, [membership.md](membership.md) M15, [profile.md](profile.md) P1 | 4137, 4133, 4138, 390 x3 |
| G3 | Login, all players | `Yishi.loginInitDataAcceptComplete` `Yishi.as:623` -> `ConsortiaSocketOutManager.getConsortiaInviteInfos` `ConsortiaSocketOutManager.as:204` | none | C>S 8209 0x2011 `U_C_INVITEINFO_LIST` | no body | 4135 |
| G4 | Guild chat send (chat bar channel 5 or group chat window) | `ConsortiaGroupChatFrame.sendChat` `ConsortiaGroupChatFrame.as:363` (`_currentInChannel = 5`, `:232`) -> `ChatManager.chatNormal` `decompiled/core_module/scripts/chat/ChatManager.as:268` -> `ChatSocketOutManager.sendChat` `decompiled/core_module/scripts/chat/ChatSocketOutManager.as:59` | not empty ("Mensagem em branco, não é possível enviar"); 1 s throttle; channel 5 requires a guild ("Você não juntou-se à nenhuma Guilda", `decompiled/core_module/scripts/chat/utils/ChatHelper.as:103`) | C>S 15005 0x3a9d `U_CH_CHANNEL_CHA` (normal scenes); C>S 25024 0x61c0 `CR_CHANNEL_CHAT` when `initChatData` routes cross server (`ChatSocketOutManager.as:96`) | `ChatChannelMsg`: `channel (#1, INT32)` = 5, `encode_msg (#3, STRING)`, `items (#17, repeated)`, `stars (#18, repeated)`, `powcards (#19, repeated)`, `shareTimeSpace (#29, repeated STRING)` | 83 to every online member of the sender's guild |
| G5 | Group notice update | `ConsortiaGroupChatFrame.__updateBtnHandler` `ConsortiaGroupChatFrame.as:474` -> `ConsortiaGroupChatControler.sendModifyGroupPlacard` `ConsortiaGroupChatControler.as:154` -> `ConsortiaSocketOutManager.sendModifyGroupPlacard` `ConsortiaSocketOutManager.as:87` | editable with right 3 (`ConsortiaGroupChatFrame.as:614`, `:701`); forbidden words ("Caractéres inválidos, insira novamente") | C>S 8544 0x2160 `U_C_CONSORTIA_GROUP_PLACARD` | `ConsortiaMsg`: `group_placard (#18, STRING)` | 164 to all online members (`group_placard (#53)`) |

## Server messages

| Route | Message and fields read | When | Client handler and effect |
|---|---|---|---|
| S>C 4136 0x1028 `U_C_EVENT_LIST` | `ConsortiaEventListRspMsg`: `eventInfo (#1, repeated ConsortiaEventInfoMsg)`: `id (#1, INT32)`, `consortia_id (#2, INT32)`, `remark (#3, STRING)` pipe separated parts, `create_date (#4, STRING "YYYY-MM-DD hh:mm:ss")`, `type (#5, INT32)` event type, `is_exist (#6, BOOL)` | Response to 8210 | `ConsortiaControler.__refreshEventList` `ConsortiaControler.as:779` sorts by `createDate` descending; listener only while the guild controller is active (`:102`) |
| S>C 162 0x00a2 `U_CH_CONSORTIA_USERLOGIN` | `ConsortiaMsg.other_id (#3)` member who logged in | Push to online guildmates on login | `ConsortiaManager.__userLogin` `ConsortiaManager.as:1057`: member `state = 7`, dispatches `UPDE_MEMEBER_STATE` (member row shows "Online") |
| S>C 163 0x00a3 `U_CH_CONSORTIA_USERLOGOUT` | `ConsortiaMsg.other_id (#3)` | Push to online guildmates on logout | `ConsortiaManager.__userLogout` `ConsortiaManager.as:1073`: `state = 0`, `logOutTime = client now` |
| S>C 83 0x0053 `U_CH_CHANNEL_CHA` | `ChatChannelMsg`: `channel (#1)` = 5, `type (#2)`, `encode_msg (#3)`, `other_id (#4)` sender, `name (#5)` sender nickname, `consortia_id (#7)`, `consortia_name (#8)`, `user_type (#9)`, `vip_grade (#14)`, `appellid (#23)`, `job (#24)` (0 = all jobs), `grades (#26)`, `vipType (#27)`, `player_uuid (#28)`, `server_name (#20)`, item and star attachments | Broadcast of G4 to guild members | `ChatManager.__channelChatHandler` `ChatManager.as:110`: adds to the chat model; channel 5 also feeds the group chat window (`decompiled/core_module/scripts/chat/ChatModel.as:153`) and fires `CHAT_FROM_CONSORTIA` (`ChatManager.as:185`) |
| S>C 4455 0x1167 `U_C_CONSORTIA_VIP` | `VipToConsortiaMsg`: `userid (#1, INT32)`, `is_vip (#2, BOOL)`, `vip_type (#3, INT32)`, `consortia_id (#4, INT32)` | Push to online guildmates when a member's VIP status changes | `ConsortiaGroupChatControler.__vipInfoChangeHandler` `ConsortiaGroupChatControler.as:120` updates the member VIP icon in the group chat |
| S>C 180 0x00b4 `U_C_CONSORTIA_USER_JOIN_INFO` | `ConsortiaUserJoinMsg`: `quest_site (#1, BYTES)`, `conditionList (#2, repeated ConsortiaConditionMsg)`, `reputation (#3, INT32)` "Mérito individual", `active_point (#4)`, `weekly_active_point (#5)` | Assumption: at login for members and after joining (quests are economy) | `ConsortiaManager.__userJoinInfoUpdateHandler` `ConsortiaManager.as:1163` |
| S>C 111 0x006f `U_C_CHANNEL_ALERT` | `ChatChannelMsg.encode_msg (#3)` | Error or info tips for any guild action (Assumption) | `BaseManager.__serverBroadcastHandler` `decompiled/core_module/scripts/yishi/manager/BaseManager.as:2171` |
| S>C 4454 0x1166 `U_C_CONSORTIA_EVENT` | no client listener | Not needed | none |

## Event types and remark formats

Types (`decompiled/core_module/scripts/mvc/module/consortia/ConsortiaEventInfo.as:6`), rendering (`ConsortiaEventItem.decode`, `ConsortiaEventItem.as:78`). `[n]` is the n-th `|` part; orange `#fc7d00` and gold `#f1c143` highlights are added by the client, so the server sends plain text parts. pt-BR wording of the parts is an Assumption (not in `language.json`); keep player names as standalone parts.

| Type | Constant | Label | Parts and highlight | Proposed parts (Assumption) | Written by |
|---|---|---|---|---|---|
| 1 | JOIN_CONSORTIA | "Alteração de Membros" | 4 parts, [0] and [2] orange | `{player}|entrou na guilda, aprovado por|{approver}|.` | join ([membership.md](membership.md)) |
| 2 | KICK | "Alteração de Membros" | 4 parts, [0] and [2] orange | `{player}|foi expulso por|{actor}|.` | kick |
| 3 | QUIT | "Alteração de Membros" | 2 parts, [0] orange | `{player}|saiu da guilda.` | leave |
| 4 | CONSORTIA_UPGRADE | "Elevar Guilda" | 2 parts, [0] gold | `{actor}|elevou a guilda para o Nv. {n}.` | level up ([profile.md](profile.md)) |
| 5 | SKILL_UPGRADE | "Elevar Guilda" | 3 parts, [1] gold | `{actor} pesquisou|{skill}|Nv. {n}` | economy |
| 6 | BUILDING_UPGRADE | "Elevar Guilda" | 3 parts, [1] gold | `{actor} elevou|{building}|para o Nv. {n}` | economy |
| 7 | CHANGE | "Transferir Guilda" | 3 parts, [1] gold | `{old} transferiu a presidência para|{new}|.` | transfer, election ([ranks.md](ranks.md)) |
| 8 | DEDUCT | "Dedução da Guilda" | 1 part orange | `Manutenção semanal: -{amount} de fortuna` | maintenance |
| 9 | EVENT | "Evento da Guilda" | 3 parts with [1] orange, or 1 part | free text | misc (rename, election, activities) |
| 10 | SPEED | "Acelerar Resfriamento" | 2 parts, [0] orange | `{actor}|acelerou o resfriamento.` | speed up |
| 11 | CONSORTIA_PICK_FRUIT | "Elevar Guilda" | 1 part | free text | PvE secret land |
| 12 | CHAIRMAN_SEND | "Distribuição de Baú" | 5 parts, [0], [2], [4] orange | `{chairman}|distribuiu|{item}|para|{member}` | economy box allot |

## Login sequence (server side)

1. On login of a guild member: send `PlayerMsg` (3) with `consortia_id`, `consortia_name`, `consortia_offer`, `consortia_totaloffer`, `is_auto`, `lastOutConsortia`; push 162 to every other online member of the guild; answer the client's 8211, 8207, 8212, 9629, 8209 as they arrive; optionally 180 (Assumption).
2. On login of a player without guild: `PlayerMsg` with `consortia_id` 0 and cooldown fields; answer 8209 (pending invitations and applications).
3. On logout or disconnect of a guild member: store `last_logout_at`, push 163 to online guildmates. This also feeds the election absence rule ([election.md](election.md)).

## Rules and formulas

- Presence: `state` 7 = online after 162 (`ConsortiaManager.as:1066`); `isOnline` is `state != 0` (`decompiled/core_module/scripts/yishi/datas/playerinfo/SimplePlayerInfo.as:512`). The member list `state` (#7) at 8207 must be non zero for online members.
- Event list: client renders all events it receives; return the latest 100 (Assumption) ordered by date descending.
- Guild chat: channel 5 reaches only members of the sender's guild; messages are not persisted by the client except the group chat history in memory (Assumption: server persistence optional).
- Group notice: right 3; forbidden words; shown to everyone in the group chat window.
- Toolbar guild button shine (`MainToolBar.consortiaButtonShine`, `decompiled/core_module/scripts/ui/maintoolbar/MainToolBar.as:2472`) is set when: invitations exist at first record list (`ConsortiaManager.as:656`), an invitation push arrived (`:660`), an invitation was accepted while the frame is closed (`:377`), 4266 arrived while the frame is closed (`:336`). Cleared when the search frame opens (`decompiled/m6/scripts/consortia/view/club/ConsortiaSearchFrame.as:56`) or the controller shows a frame (`ConsortiaControler.as:152`).
- Guild red dot (`InfoTipsManager` type 4, `ConsortiaManager.giftCount` `ConsortiaManager.as:1538`): treasures ready + applicant count (right 9 only) + guild task rewards + guild dungeon rewards. Tab badges in `ConsortiaFrame` (`decompiled/m6/scripts/consortia/view/myConsortia/ConsortiaFrame.as:231`).

## Templates

None. Strings: `consortia.view.myConsortia.event.*`, `consortiagroupchat.*`, `yishi.manager.ConsortiaManager.*`, `yishi.actions.consortia.CaseGoodsSendBackByMailAction.sendBack`.

## Persistent state

```sql
CREATE TABLE guild.event (
    id          bigserial   PRIMARY KEY,
    guild_id    integer     NOT NULL REFERENCES guild.guild(id) ON DELETE CASCADE,
    type        smallint    NOT NULL CHECK (type BETWEEN 1 AND 12),
    remark      text        NOT NULL,          -- pipe separated parts
    created_at  timestamptz NOT NULL DEFAULT now()
);
CREATE INDEX event_guild_idx ON guild.event (guild_id, created_at DESC);

CREATE TABLE guild.chat_message (               -- optional, for history after reconnect
    id          bigserial   PRIMARY KEY,
    guild_id    integer     NOT NULL REFERENCES guild.guild(id) ON DELETE CASCADE,
    sender_id   integer     REFERENCES public.player(id) ON DELETE SET NULL,
    body        text        NOT NULL,
    created_at  timestamptz NOT NULL DEFAULT now()
);
CREATE INDEX chat_message_guild_idx ON guild.chat_message (guild_id, created_at DESC);
```

Presence uses the in memory session registry plus `public.player.last_logout_at` (existing player table, Assumption on the column name). `guild.guild.group_notice` is defined in [profile.md](profile.md).

## Backend implementation notes

| Opcode | Handler |
|---|---|
| 8210 | `guild::logs::handle_list_events` |
| 8544 | `guild::logs::handle_set_group_notice` |
| 15005 / 25024 with channel 5 | `guild::logs::handle_guild_chat` (called from the chat router) |
| login / logout hooks | `guild::logs::on_member_login`, `guild::logs::on_member_logout` |

Shared helpers used by every guild module:

- `guild::logs::record_event(tx, guild_id, type, parts: &[&str])` inside the caller's transaction.
- `guild::push::to_online_members(guild_id, opcode, msg, except: Option<player_id>)`.
- `guild::push::alert(player_id, text)` sending 111.

Fan out: 162/163 to online guildmates except the subject; 83 channel 5 to online guildmates including the sender; 4455 to online guildmates when VIP changes (hook in the VIP module); 164 after 8544.

## Open questions

1. Exact pt-BR remark wording of each event type (the original server composed them).
2. Whether 180 is sent at login.
3. Event retention (count or days).
4. Persistence of guild chat history.

## Implementation checklist

Client flows:

- [ ] Event frame lists events with correct colors per type
- [ ] Login as guild member: duties, members, info, invitations load without errors; member rows show online states
- [ ] Guildmate login/logout updates the member list live
- [ ] Guild chat in the chat bar and in the group chat window; group notice edit with right 3
- [ ] VIP icon update in group chat
- [ ] Invitation popup, toolbar shine, red dot counter, storage return notice

Backend:

- [ ] Tables `guild.event` (and optional `guild.chat_message`)
- [ ] `record_event` helper called by membership, ranks, profile, contribution, election, economy modules
- [ ] Handlers 8210, 8544, guild chat routing for channel 5
- [ ] Login/logout hooks pushing 162/163 and updating `last_logout_at`
- [ ] Pushes 4136, 83, 4455, 111, 180 (if confirmed)
