# Friend list and relations

Feature `friends`, module `friend-list`. Relations (friend, blacklist, stranger), groups, friend requests, online notices, intimacy, recent contacts and the refuse setting.

Conventions: paths relative to the repository root; AS3 citations `decompiled/<module>/scripts/<path>.as:<line>`; opcodes from `protocol/opcodes.csv` or `decompiled/core_module/scripts/yishi/datas/consant/ProtocolType.as` / `AcceptProtocolType.as`; fields `name (#tag, TYPE, repeated?)` from `protocol/proto.json`, and for `simple.*` messages from the AS3 classes in `decompiled/core_module/scripts/com/road/yishi/proto/simple/` (`simple.SimplePlayerInfoMsg` collides in `proto.json`); "Assumption" marks behavior not visible in the client.

## 1. Overview

Relations are directed: when A adds B, B becomes A's friend (relation 1) in A's list; the server tells B (popup "Pedido de adição" via 84 and the toolbar invite list via 4246) so B can add A back. A blacklisted player has relation 2. Relation 3 ("Desconhecidos", stranger) appears in lists sent by the server (Assumption: players who added you without being added back). Relation 4 is client only (recent contacts). Friends are arranged in groups: default group 2 "Amigos", custom groups (max 3 more), blacklist group 3, strangers group -1, recent contacts group 1 and the mate group -2 are client side groupings. The login sequence pushes the whole list (4156); afterwards changes arrive as 78, 79, 165, 160, 161 and group pushes.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `friends.FriendsFrame` `decompiled/m12/scripts/friends/view/FriendsFrame.as` | "Social" (`friends.view.FriendsFrame.title`); "Procurar" (find); signature placeholder "Editar a Assinatura da personagem"; level "Nv.{0}" | Own card, signature edit (saves via 15033, see [sns-profile.md](sns-profile.md), `:347`), list view, find button (`:432`), group chat button (`:425`), cross list refresh on open (9606 op 4, `:100`) | friends controller type 1 | own `thane`, `snsInfo` |
| `FridendsListView` `decompiled/m12/scripts/friends/view/FridendsListView.as` | "Contatos recentes [{0}]", "Desconhecidos [{0}]", "Lista negra [{0}]", "Amigo inter-servidor [{0}]", "Desconhecido inter-servidor [{0}]", "Lista Negra inter-servidor [{0}]", "Clique para adicionar grupo", "Número máximo de grupos atingido", "Nome do grupo inserido contêm caractéres inválidos, corrija" | Group tree (`:108` to `:185`), sorting online first then intimacy (`:669`), add group (`:338`), polls recent contact states every 30 min (`__systimeUpdateHandler` `:274`) | `FriendsFrame` | `FriendManager.friendList`, `groupDic`, `privatePerson` |
| `FriendItemCell` `decompiled/m12/scripts/friends/view/FriendItemCell.as` | "Renomear", "Certeza ao deletar grupo?", "Pontos de perfeição: {0}", "Nível:" | Group header (rename `:284`, delete `:236`) or friend row (double click opens IM `:314`) | list | |
| `FriendItemButton` `decompiled/m12/scripts/friends/view/FriendItemButton.as` | tip "Deletar amigo" | Row buttons: chat (`:156`), delete (`:272`) | list | |
| `yishi.view.community.PlayerMenu` `decompiled/core_module/scripts/yishi/view/community/PlayerMenu.as` | "Privado", "Mover Amigo", "Adicionar Amigo", "Copiar Nome", "Lista Negra", "Deletar Amigo", "Deletar Contato Recente", "Ver Informações", "Convidar para a Equipe", "Perseguir", "Duelo", "Nomear Presidente"; confirmations "Confirmar ao deletar amigo", "Confirmar ao deletar da lista negra", "Deletar do Desconhecidos", "Confirmar ao deletar contatos recentes"; "Não há grupo disponível" | Player context menu (shared) | friend rows, map, rankings, team panel | target `ThaneInfo` |
| `friends.AddOrDeleteFriendFrame` `decompiled/m12/scripts/friends/view/AddOrDeleteFriendFrame.as` | "Adicionar amigo" / "Adicionar à lista negra"; "Insira apelido"; "Clique no jogador na janela de conversa para obter apelido" | Add or blacklist by nickname (`:76`, `:80`) | list view buttons | |
| `yishi.view.frame.ApplyFriendFrame` `decompiled/core_module/scripts/yishi/view/frame/ApplyFriendFrame.as` | "Pedido de adição"; "pediu para adicioná-lo como amigo, concordar?"; "Informação adicional"; buttons "Concordar", reject | Incoming request popup (`ApplyFriendAction` `decompiled/core_module/scripts/yishi/actions/friend/ApplyFriendAction.as`); accept adds the requester (`:94`) | push 84 | requester name, notice text |
| `ToolInviteFriendFrame` / `ToolInviteFriendList` / `ToolInviteFriendItem` `decompiled/m12/scripts/friends/view/` | "Convite de Amigo", "Nome", "Ação", "Concordar", "Ignorar", "Concordar Todos", "Ignorar Todos", "Ignorar todos os convites de amigos?", "Ação sucedida" | Toolbar list of requests | push 4246 (friends type 3) | `FriendManager.toolInviteFriendList` |

## 3. Routes (client to server)

| # | UI control | Client sender | Client checks | Route | Request | Response |
|---|---|---|---|---|---|---|
| F1 | Add friend (menus, frames, popup accept, recommendation, search result, IM) | `FriendManager.sendAddFriendRequest(nick, 1)` `decompiled/core_module/scripts/yishi/manager/FriendManager.as:639` then `FriendSocketOutManager.sendAddFriendRequest` `decompiled/core_module/scripts/managers/FriendSocketOutManager.as:33` | own level >= 6 ("Função Social está habilitada" key `command01`); `checkFriendList` `:683`: friends (excluding blacklist) < `maxFriendCount` ("Número máximo de amigos atingido"); not self ("Não é possível adicionar a si mesmo"); not already in that relation ("Jogador já está na lista") | C>S 15003 0x3a9b `U_CH_ADD_RELATIONSHIP` | `FriendRelationMsg`: `nick_name (#2, STRING)` target nickname; `relation (#3, INT32)` = 1 | 78 to the requester; 84 and/or 4246 to the target if online |
| F2 | Blacklist ("Lista Negra") | same with relation 2 after confirmation "Certeza ao adicionar usuário à lista negra?" (`:655`) | blacklist count < 50 ("A sua lista negra atingiu 50 pessoas, apague algumas para continuar à adicionar"), not self ("Não é possível adicionar a si mesmo na lista negra") | C>S 15003 | `nick_name`, `relation` = 2 | 78 (relation 2) |
| F3 | Delete friend / remove from blacklist / remove stranger | `PlayerMenu.__onDelFriendHandler` `PlayerMenu.as:844`, `FriendItemButton` `:272`, `IMFrame.__delFriendBtnClickHandler` `decompiled/m12/scripts/im/IMFrame.as:454` then `FriendManager.sendRemoveFriendRequest` `FriendManager.as:869` then `FriendSocketOutManager.sendRemoveFriendRequest` `:50` | confirmation; relation 4 (recent) is removed locally only | C>S 15004 0x3a9c `U_CH_REMOVE_RELATIONSHIP` | `FriendRelationMsg`: `other_id (#1, INT32)` | 79 |
| F4 | Add group | `FridendsListView.__inputGroupNameHandler` `FridendsListView.as:338` then `sendAddGroup` `FriendSocketOutManager.as:64` | name not blank, no `,` `|` `%`; groups < 4 including the default (`:467`) | C>S 15025 0x3ab1 `CH_ADD_GROUP` | `simple.FriendGroupMsg`: `group_name (#2, STRING)` | 4227 |
| F5 | Delete group | `FriendItemCell.delGroupResponseHandler` `FriendItemCell.as:238` after "Certeza ao deletar grupo?" then `sendDelGroup` `:72` | custom group | C>S 15026 0x3ab2 `CH_DEL_GROUP` | `FriendGroupMsg`: `group_id (#1, INT32)` | 4228; members move to group 2 client side (`FriendManager.__delGroupHandler` `:396`) |
| F6 | Rename group | `FriendItemCell` `:293` then `sendRenameGroup` `:80` | same name rules | C>S 15027 0x3ab3 `CH_RENAME_GROUP` | `FriendGroupMsg`: `group_id (#1)`, `group_name (#2)` | 4229 |
| F7 | "Mover Amigo" | `PlayerMenu.__groupSelectHandler` `PlayerMenu.as:576` then `sendMoveFriend` `:89` | at least 2 groups ("Não há grupo disponível"), target is a friend | C>S 15028 0x3ab4 `CH_FRIEND_MOVE` | `MoveFriendReqMsg`: `firend_id (#1, INT32)` (sic), `group_id (#2, INT32)` | 4230 |
| F8 | Recent contact details (login and on demand) | `FriendManager.reqPrivatePerson` `:906`, `IMManager` (unknown sender) then `PlayerManager.sendRequestSimpleAndSnsInfo` `decompiled/core_module/scripts/yishi/manager/PlayerManager.as:1654` | recent ids are stored client side (`SharedManager.recentList`), max 15 (`addPrivatePerson` `:915`) | C>S 15038 0x3abe `CH_SIMPLEUSER_INFO` | `simple.InfoReqMsg`: `other_id (#1, INT32)`, `from (#2, INT32)` = 0 (recent/IM), 2 or 3 (refresh) | 4256 |
| F9 | Recent contacts state poll | `FridendsListView.__systimeUpdateHandler` `FridendsListView.as:274` (every 1800 s) then `sendReqChatState` `FriendSocketOutManager.as:98` | recent list not empty | C>S 15043 0x3ac3 `CH_CHAT_STATE` | `chat.RecentContractsStateReqMsg`: `userId (#1, INT32, repeated)` | 4272 |
| F10 | Refuse friend requests toggle | `SettingFrame` `decompiled/m11/scripts/setting/SettingFrame.as:442` then `SocketSendManager.sendFriendRefuse` `decompiled/core_module/scripts/yishi/service/managers/SocketSendManager.as:420` | toggle | C>S 8285 0x205d `C_FRIEND_REFUSE` | no body | 4193 |
| F11 | Confirm add (unused) | `FriendSocketOutManager.sendFriendAddConfirm` `:42` | no caller | C>S 15012 0x3aa4 `U_CH_FRIENDADD_CONFIRM` | `FriendRelationMsg`: `nick_name` | Assumption: not needed |

## 4. Server messages (server to client)

`simple.FriendInfoMsg`: `user_id (#1, INT32)`, `relation (#2, INT32)`, `sex (#3, INT32)`, `pic (#4, INT32)`, `grades (#5, INT32)`, `nick_name (#6, STRING)`, `online_state (#7, INT32)`, `relation_grade (#8, INT32)` intimacy level, `relation_gp (#9, INT32)` intimacy points, `consortia_id (#10, INT32)`, `consortia_name (#11, STRING)`, `result (#12, BOOL)`, `add_msg (#13, STRING)` error text when `result` is false, `fight_capacity (#14, INT32)`, `job (#15, INT32)`, `group_id (#16, INT32)`, `exp_added (#17, INT32)` intimacy gained, `sns_info (#18, simple.SNSInfoMsg)`, `chat_state (#19, INT32)` status shown as state (7 online, 0 offline, 4 away, 5 do not disturb, 6 busy), `vip_type (#20, INT32)`, `is_vip (#21, BOOL)`, `trans_grade (#22, INT32)`, `changeBranch (#23, INT32)`.

`simple.RelationPlayerMsg`: `relation (#1, INT32)`, `friend_rp (#2, INT32)` intimacy points, `friend_grade (#3, INT32)` intimacy level, `group_id (#4, INT32)`, `player (#5, simple.SimplePlayerInfoMsg)`, `sns_info (#6, simple.SNSInfoMsg)`, `from (#7, INT32)` request origin echo, `is_vip (#8, INT32)` (1 = VIP), `trans_grade (#9, INT32)`, `changeBranch (#10, INT32)`. From `SimplePlayerInfoMsg` the login reader uses `uuid (#43)`, `userId (#1)`, `nickName (#2)`, `job (#26)`, `sexs (#4)`, `pics (#5)`, `camp (#6)`, `state (#7)`, `consortiaID (#8)`, `strategy (#9, INT64)`, `consortiaName (#10)`, `consortiaOffer (#11)`, `consortiaTotalOffer (#27)`, `claimId (#12)`, `claimName (#13)`, `grades (#14)`, `gp (#15, INT64)`, `repute (#16)`, `logOutTime (#17, "YYYY-MM-DD hh:mm:ss")`, `dutyId (#18)`, `parameter1 (#19)`, `gpOrder (#20)`, `fightingCapacity (#21)`, `matchWin (#22)`, `matchFailed (#23)`, `right (#24)` (`LoginInitDataAccept.as:395`).

| Route | Message | Client receiver | When | Reaction |
|---|---|---|---|---|
| S>C 4156 0x103c `U_C_LOAD_FRIEND_LIST` | `simple.FriendRelationList`: `relationList (#1, RelationPlayerMsg, repeated)`, `group (#2, FriendGroupMsg, repeated)` custom groups, `max_page (#3, INT32)`, `cur_page (#4, INT32)` | `LoginInitDataAccept.__loadFriendListHandler` `decompiled/core_module/scripts/yishi/lunch/LoginInitDataAccept.as:385` | login sequence, possibly several pages (`max_page` extends the login step count) | first page: `FriendManager.setup` (also sends 15013 and 9606 op 4) and `IMManager.setup`; later pages: `addFriends` |
| S>C 78 0x004e `U_CH_ADD_RELATIONSHIP` | `simple.FriendInfoMsg` (full) | `FriendManager.__addFriend` `FriendManager.as:465` | response to 15003 | `result` true: sound, adds/updates the entry (relation 2 also removes the recent contact and IM cache); false: tip `add_msg`; removes the user from recommendations |
| S>C 79 0x004f `U_CH_REMOVE_RELATIONSHIP` | `friend.FriendRelationMsg`: `other_id (#1, INT32)`, `result (#6, BOOL)` | `__removeFriend` `:486` | response to 15004 | removes entry, recent contact, IM cache |
| S>C 84 0x0054 `U_CH_FRIENDADD_CONFIRM` | `FriendRelationMsg`: `nick_name (#2)` requester, `notice_msg (#4)` extra text | `__addFriendConfirmHandler` `:338` | push to the target of 15003 relation 1 if the target does not refuse requests (Assumption) | popup `ApplyFriendFrame` (buffered while in battle, blinks the friends button); ignored when own level <= 6 |
| S>C 4246 0x1096 `U_CH_FRIEND_ADDED` | `friend.FriendAddedMsg`: `user_id (#1)`, `nick_name (#2)`, `grades (#3)`, `sex (#4)`, `trans_grade (#5)`, `job (#6)`, `changeBranch (#7)` | `__friendAddHandler` `:298` | push to the target of a friend add | adds to the toolbar invite list unless own level < 6 or `refuseFriend` |
| S>C 165 0x00a5 `U_CH_FRIEND_UPDATE` | `simple.FriendInfoMsg` (`user_id`, `relation_grade`, `relation_gp`, `relation`, `group_id`, `exp_added`) | `__updateFriend` `:437` | intimacy or relation change | updates; `exp_added > 0` adds "O seu nível de amizade com {0} aumentou + {1}" on channel 3 |
| S>C 160 0x00a0 `U_CH_FRIEND_LOGIN` | `FriendRelationMsg`: `other_id (#1)` | `__friendLogin` `:503` | to online players who have the user in their list | state 7; for relations 1 and 3 adds "[name] está online" on channel 3 |
| S>C 161 0x00a1 `U_CH_FRIEND_LOGOUT` | `FriendRelationMsg`: `other_id (#1)` | `__friendLoginOut` `:534` | same audience on logout | state 0 |
| S>C 4227 0x1083 `U_CH_ADD_GROUP` | `FriendGroupMsg`: `group_id (#1)`, `group_name (#2)`, `result (#3)` | `__addGroupHandler` `:384` | response to 15025 | adds group (no result check) |
| S>C 4228 0x1084 `U_CH_DEL_GROUP` | `FriendGroupMsg`: `group_id` | `__delGroupHandler` `:396` | response to 15026 | moves members to group 2 |
| S>C 4229 0x1085 `U_CH_RENAME_GROUP` | `FriendGroupMsg`: `group_id`, `group_name` | `__renameGroupHandler` `:410` | response to 15027 | |
| S>C 4230 0x1086 `U_CH_FRIEND_MOVE` | `MoveFriendReqMsg`: `firend_id (#1)`, `group_id (#2)`, `result (#3, INT32)` 1 = success | `__moveFriendHandler` `:423` | response to 15028 | updates group when `result == 1` |
| S>C 4256 0x10a0 `U_CH_SIMPLEUSER_INFO` | `simple.RelationPlayerMsg` (fields above) | `PlayerManager.__getSimpleAndSnsInfoHandler` `PlayerManager.as:1577` (reader `SocketGameReader.readSimpleAndSnsInfo`), then `IMManager.__requestFriendInfoHandler` `decompiled/core_module/scripts/managers/IMManager.as:297` for `from == 0` | response to 15038, `from` echoed | `from` 0: becomes a recent contact (relation 4, group 1) and flushes queued IM messages; 2 and 3: refresh of a known contact; also used by the guild group chat for head ids |
| S>C 4272 0x10b0 `U_CH_CHAT_STATE` | `chat.ChatStateListRspMsg`: `chatState (#1, ChatStateMsg, repeated)` with `user_id (#1)`, `chat_state (#2)` | `__recentContactStateUpdateHandler` `:278` | response to 15043 | updates recent contact states |
| S>C 4193 0x1061 `U_C_REFUSEFRIEND_REFRESH` | `player.RefuseFriendRspMsg`: `result (#1, BOOL)` | `PlayerManager.__uRefusefriend` `PlayerManager.as:461` | response to 8285 | `playerInfo.refuseFriend` (also in `PlayerMsg.refuseFriend #50` at login) |

## 5. Rules and formulas

- Max friends: `200 + VIPManager.model.vipFriendPrivilege` (`FriendManager.maxFriendCount` `:754`); count excludes blacklist (`countFriend` `:744`).
- Max blacklist: 50 (`checkFriendList` `:711`).
- Groups: default group id 2 named "Amigos" (`initGroupList` `:191`), at most 3 custom groups (client blocks at 4 groups total); custom group ids must not collide with -2, -1, 1, 2, 3, 1001 to 1003 (Assumption: start at 10).
- Level 6 for all social actions; friend requests are only shown above level 6.
- Login notices only for relations 1 and 3.
- Intimacy (`relation_gp`, `relation_grade`) grows from interactions (Assumption: team battles, roses, farm help; owned by those features, which call `friends::friend_list::add_intimacy`). The client shows it in tips and sorting only.
- Divorce moves the ex mate to group 2 client side (`__maryInfoUpdateHandler` `:235`).
- Recent contacts are client only (stored in the Flash shared object), max 15; their state is polled every 30 minutes.

## 6. Templates

None (VIP friend privilege comes from VIP templates, VIP feature).

## 7. Persistent state

```sql
CREATE SCHEMA IF NOT EXISTS friends;

CREATE TABLE friends.friend_group (
    group_id      serial      PRIMARY KEY,
    owner_id      integer     NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
    name          varchar(16) NOT NULL,
    created_at    timestamptz NOT NULL DEFAULT now()
);
CREATE INDEX friend_group_owner_idx ON friends.friend_group (owner_id);
-- ids 1, 2, 3 and negatives are reserved client side: start the sequence at 10
ALTER SEQUENCE friends.friend_group_group_id_seq RESTART WITH 10;

CREATE TABLE friends.relation (
    owner_id        integer     NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
    target_id       integer     NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
    relation        smallint    NOT NULL CHECK (relation IN (1, 2, 3)),   -- friend, blacklist, stranger
    group_id        integer     NOT NULL DEFAULT 2,                       -- 2 default, 3 blacklist, -1 stranger, or friends.friend_group.group_id
    intimacy_points integer     NOT NULL DEFAULT 0 CHECK (intimacy_points >= 0), -- friend_rp / relation_gp
    intimacy_level  smallint    NOT NULL DEFAULT 1 CHECK (intimacy_level >= 1),  -- friend_grade / relation_grade
    created_at      timestamptz NOT NULL DEFAULT now(),
    PRIMARY KEY (owner_id, target_id),
    CHECK (owner_id <> target_id)
);
CREATE INDEX relation_target_idx ON friends.relation (target_id, relation);

CREATE TABLE friends.setting (
    player_id       integer PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
    refuse_requests boolean NOT NULL DEFAULT false   -- PlayerMsg.refuseFriend
);
```

## 8. Backend implementation notes

| Opcode | Handler |
|---|---|
| 15003 | `friends::friend_list::handle_add_relation` |
| 15004 | `friends::friend_list::handle_remove_relation` |
| 15025 | `friends::friend_list::handle_add_group` |
| 15026 | `friends::friend_list::handle_delete_group` |
| 15027 | `friends::friend_list::handle_rename_group` |
| 15028 | `friends::friend_list::handle_move_friend` |
| 15038 | `friends::friend_list::handle_simple_info` |
| 15043 | `friends::friend_list::handle_recent_states` |
| 8285 | `friends::friend_list::handle_toggle_refuse` |
| 15012 | `friends::friend_list::handle_add_confirm` (no op, Assumption) |

- Add (15003): resolve nickname (case insensitive); validate level 6, not self, limits (200 + VIP for relation 1, 50 for relation 2); upsert `friends.relation` (relation 1 or 2, group 2 or 3) in one transaction; respond 78 with full `FriendInfoMsg` (`result` true) or `result` false with `add_msg`. For relation 1, if the target has no relation to the requester create a relation 3 (stranger) row on the target side (Assumption) and, unless `refuse_requests`, push 84 and 4246 to the target if online.
- Remove (15004): delete the row; respond 79 `result` true.
- Login: send 4156 pages (Assumption: 100 relations per page) before `IMManager.setup`; include custom groups in the first page.
- Online notices: on login/logout push 160/161 to every online owner of a relation row targeting the player.
- Intimacy API `friends::friend_list::add_intimacy(a, b, points)`: update both directions when mutual, recompute level (Assumption: thresholds owned by the calling features or a future template), push 165 with `exp_added`.
- Simple info (15038): build `RelationPlayerMsg` for any player id (relation from the requester's view, 0 if none), echo `from`, respond 4256.

## 9. Open questions and assumptions

1. Stranger (relation 3) creation rule and intimacy thresholds are not in the client.
2. Whether 84 and 4246 are both sent for the same request (the client handles both independently; Assumption: 4246 always, 84 only when the target is online and not in battle).
3. Page size of 4156.

## 10. Implementation checklist

- [ ] Tables `friends.relation`, `friends.friend_group`, `friends.setting`
- [ ] Login list 4156 with groups and SNS info
- [ ] Add friend / blacklist (15003 -> 78; 84 and 4246 to the target)
- [ ] Remove (15004 -> 79)
- [ ] Groups add, delete, rename, move (15025 to 15028 -> 4227 to 4230)
- [ ] Login and logout notices (160, 161)
- [ ] Intimacy update push 165
- [ ] Recent contacts info and states (15038/4256, 15043/4272)
- [ ] Refuse friend requests toggle (8285/4193) and `PlayerMsg.refuseFriend`
- [ ] Limits: 200 + VIP friends, 50 blacklist, 3 custom groups
- [ ] Test: accept from the popup adds the requester back
