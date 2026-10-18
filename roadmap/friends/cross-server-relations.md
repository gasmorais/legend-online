# Cross server relations

Feature `friends`, module `cross-server-relations`. The global relation graph: following (cross server friends), strangers and blacklist across servers, cross server private chat, cross server friend requests and the outyard/huge head broadcast channel.

Conventions as in [friend-list.md](friend-list.md). Enums from `decompiled/core_module/scripts/com/road/yishi/proto/friend/`: `RelationGraphOpState` FOLLOW 0, UNFOLLOW 1, BLACKLIST 2, UNBLACKLIST 3, RELATION_GRAPH 4, CHAT 5; `GlobalChannel` WORLD_CHAT 0, PRIVATE_CHAT 1, RELATION_GRAPH_UPDATE 2, RELATION_GRAPH_NOTIFY 3, PLAYER_ALERT 4, HUGE_HEAD_ALL 5, HUGE_HEAD_FORCE 6, HUGE_HEAD_FORCE_NOTICE 7; `RelationGraphErrorCode` NONE 0, ERROR_PARAM_OP_NONE 1, ERROR_PARAM_UUID_EQUAL_SELF 2, ERROR_USER_NONE 3, ERROR_USER_OFFLINE 4, ERROR_FOLLOWING_FOLLOWED 5, ERROR_FOLLOWING_NUM_LIMIT 6, ERROR_CHAT_CHANNEL_NONE 7, ERROR_CHAT_CHANNEL_MISMATCHING 8, ERROR_CHAT_MESSAGE_NONE 9, ERROR_CHAT_MESSAGE_FREQUENCY_LIMIT 10.

## 1. Overview

Players are identified across servers by `uuid`. All operations use C>S 9606 with `RelationGraphOpMsg` (`op`, `param1` target uuid, `param2` text, `channel`). The full graph is requested with op 4 at login and when the friends frame opens; the service answers with one or more 347 pages (`FriendRelationGraphMsg` with friend, stranger and blacklist arrays, each player as a JSON string). A higher `stamp` starts a new snapshot. Private messages (op 5, channel 1) and notifications arrive as 348 (`GlobalImMsg`), whose `from_channel` selects the meaning: 1 private chat, 3 a cross server follow request (shown in the friend invite list), 5/6/7 broadcast messages shown on chat channel 109 ("Terralém").

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `FridendsListView` cross groups | "Amigo inter-servidor [{0}]", "Desconhecido inter-servidor [{0}]", "Lista Negra inter-servidor [{0}]" (online/total) | Cross lists (groups 1001, 1002, 1003, `decompiled/m12/scripts/friends/view/FridendsListView.as:156` to `:182`) | friends frame | `FriendManager.crossFriendList`, `crossStrangerList`, `crossBlackList` |
| `IMFrame` in cross mode | tip "Para falar com o adversário no canal privado inter-servidor terá que adicionar amigo." | Cross private chat; add, delete, blacklist through 9606 (`decompiled/m12/scripts/im/IMFrame.as:445`, `:527`, `:531`, `:567`, `:755`) | cross list rows, chat names from other servers | |
| `ToolInviteFriendList/Item` | "Concordar" | Accept a cross follow request with FOLLOW (`ToolInviteFriendItem.as:137`, `ToolInviteFriendList.as:134`) | 348 channel 3 | |
| `PlayerMenu`, `ChatItemMenu` cross mode | "Adicionar Amigo", "Lista Negra", "Deletar Amigo" | FOLLOW, BLACKLIST, UNFOLLOW/UNBLACKLIST (`decompiled/core_module/scripts/yishi/view/community/PlayerMenu.as:807`, `:826`, `:908`, `:912`; `decompiled/core_module/scripts/chat/view/ChatItemMenu.as:409`, `:471`) | player with another server name | |

## 3. Routes (client to server)

All rows: C>S 9606 0x2586 `C_GLOBAL_RELATION_GRAPH` via `FriendSocketOutManager.requestCrossFriendMsg(op, param1, param2, channel = 1)` `decompiled/core_module/scripts/managers/FriendSocketOutManager.as:127`. Body `friend.RelationGraphOpMsg`: `op (#1, ENUM RelationGraphOpState)`, `param1 (#2, STRING)`, `param2 (#3, STRING)`, `channel (#4, ENUM GlobalChannel)`.

| # | UI control | Client sender | Client checks | Fields | Response |
|---|---|---|---|---|---|
| X1 | Load graph (login, friends frame open) | `FriendManager.setup` `decompiled/core_module/scripts/yishi/manager/FriendManager.as:158`, `FriendsFrame` `decompiled/m12/scripts/friends/view/FriendsFrame.as:100` | none | `op` 4, `channel` 1 | 347 pages |
| X2 | Follow (add cross friend) | `FriendManager.sendCrossFriendRequest(0, uuid)` `:1214` | level 6 (tip only, the request still goes out, `:1218`); not already a cross friend or stranger ("Jogador já está na lista", IM) | `op` 0, `param1` target uuid | 347 refresh (Assumption) and 348 channel 3 to the target |
| X3 | Unfollow | `PlayerMenu._delFriendResponse` `PlayerMenu.as:912`, `IMFrame` `:531` | confirmation | `op` 1, `param1` uuid | 347 refresh |
| X4 | Blacklist | `sendCrossFriendRequest(2, uuid)` after "Certeza ao adicionar usuário à lista negra?" (`addCrossRelationCall` `:1233`) | confirmation | `op` 2, `param1` uuid | 347 refresh |
| X5 | Remove from blacklist | `PlayerMenu` `:908`, `IMFrame` `:527` | confirmation | `op` 3, `param1` uuid | 347 refresh |
| X6 | Cross private chat | `IMFrame.__onSendMsgBtnClick` `IMFrame.as:755` | IM checks (see [instant-messages.md](instant-messages.md)) | `op` 5, `param1` target uuid, `param2` text, `channel` 1 | 348 channel 1 to both sides (the sender's copy is recognized by own id and server) |
| X7 | Outyard chat | `ChatSocketOutManager.sendOutyardChat` (C>S 9609, see [../chat/bugles.md](../chat/bugles.md)) | | `op` 5, `param1` own uuid, `param2` text, `channel` 6 | 348 channels 5, 6, 7 |

## 4. Server messages (server to client)

`friend.SimpleGlobalPlayerMsg`: `uuid (#1, STRING)`, `jsonstr (#2, STRING)`; `"{}"` means a removed or unknown player and is skipped. JSON keys read by `FriendManager.createCrossFriendCellInfo` (`FriendManager.as:120`): `userId`, `nickName`, `serverName`, `site`, `pics`, `sexs`, `job`, `state` (7 online), `consortiaId`, `consortiaName`, `fightingCapacity`, `grades`, `changeGrades`, `changeBranch`.

| Route | Message | Client receiver | When | Reaction |
|---|---|---|---|---|
| S>C 347 0x015b `U_C_FRIEND_RELATION_GRAPH_MSG` | `friend.FriendRelationGraphMsg`: `friend (#1, SimpleGlobalPlayerMsg, repeated)` followed players, `stranger (#2, ..., repeated)` players following you without being followed, `blacklist (#3, ..., repeated)`, `stamp (#4, INT32)` snapshot version, `currentPage (#5, INT32)`, `totalPage (#6, INT32)` | `FriendManager.__crossFriendListHandler` `:1166` | response to op 4 and after relation changes (Assumption) | a stamp greater than the last one resets the three lists; each page adds entries; when the received page count exceeds `totalPage` the client notifies `CROSS_FRIENDS_UPDATE` (send pages 1..N, then the update fires after page N+1 or the count rule; Assumption: send `totalPage` = N-1 or one extra empty page, see Open questions) |
| S>C 348 0x015c `U_C_GLOBAL_RELATION_MESSAGE_MSG` | `friend.GlobalImMsg`: `from (#1, SimpleGlobalPlayerMsg)`, `from_channel (#2, ENUM GlobalChannel)`, `target (#3, STRING)` target user id as string, `msg (#4, STRING)`, `send_date (#5, INT64)` ms epoch | `IMManager.__crossFriendChatHandler` `decompiled/core_module/scripts/managers/IMManager.as:223` | channel 1: private message (to target and echo to sender); channel 3: follow notification to the target (ignored below level 6 or with refuse friend set); channels 5, 6, 7: outyard/huge head broadcast | 1: IM window or unread queue; 3: adds a cross entry to the friend invite list; 5 to 7: chat line on channel 109 with "[server-nick]" |
| `friend.RelationGraphOpResMsg` | `op (#1, ENUM)`, `result (#2, BOOL)`, `error_code (#3, ENUM RelationGraphErrorCode)` | no client listener in this version | | Assumption: not needed; errors can be reported with 111 |

## 5. Rules and formulas

- `uuid` is the global player key; `serverName` from JSON is displayed.
- Follow limit exists (`ERROR_FOLLOWING_NUM_LIMIT`), value unknown (Assumption: same as local max friends).
- Chat frequency limit exists (`ERROR_CHAT_MESSAGE_FREQUENCY_LIMIT`); Assumption 1 message per second.
- Following yourself is an error (`ERROR_PARAM_UUID_EQUAL_SELF`).

## 6. Templates

None.

## 7. Persistent state

Stored by the global relation service (shared across servers):

```sql
CREATE TABLE friends.global_relation (
    owner_uuid    text        NOT NULL,
    target_uuid   text        NOT NULL,
    relation      text        NOT NULL CHECK (relation IN ('follow', 'blacklist')),
    created_at    timestamptz NOT NULL DEFAULT now(),
    PRIMARY KEY (owner_uuid, target_uuid),
    CHECK (owner_uuid <> target_uuid)
);
CREATE INDEX global_relation_target_idx ON friends.global_relation (target_uuid, relation);

CREATE TABLE friends.global_player_card (
    uuid          text        PRIMARY KEY,
    player_id     integer     REFERENCES player.players(player_id) ON DELETE CASCADE, -- local players only
    server_name   text        NOT NULL,
    card_json     jsonb       NOT NULL,           -- jsonstr payload
    online        boolean     NOT NULL DEFAULT false,
    updated_at    timestamptz NOT NULL DEFAULT now()
);
```

Strangers are derived: followers that the owner does not follow.

## 8. Backend implementation notes

- `friends::cross_relations::handle_op` (9606) dispatches by `op`: `handle_follow`, `handle_unfollow`, `handle_blacklist`, `handle_unblacklist`, `handle_graph`, `handle_chat`. 9609 (outyard) reuses `handle_chat` with channel 6 (see [../chat/bugles.md](../chat/bugles.md)).
- The service updates `global_player_card` on login, logout and level/guild changes of local players.
- Graph pages: 50 entries per array per page (Assumption); bump `stamp` on every change and resend.
- Single server deployment: the service can live in the game server; `uuid` = server name + player id.

## 9. Open questions and assumptions

1. Page completion rule: the client fires the update when the number of received pages becomes greater than `totalPage` (`FriendManager.as:1208`), which suggests `totalPage` is 0 based (pages 0..totalPage). Assumption: send `totalPage = pages - 1`.
2. Follow limit value and error reporting path.

## 10. Implementation checklist

- [ ] Global relation tables and player cards
- [ ] 9606 ops 0 to 5
- [ ] 347 paging with stamp and 0 based `totalPage`
- [ ] 348 channels 1, 3, 5 to 7
- [ ] Cross IM end to end between two servers
- [ ] Test: blacklisted cross player cannot message
