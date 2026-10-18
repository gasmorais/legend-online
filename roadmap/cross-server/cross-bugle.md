# Cross-server bugle ("Megafone Inter-S")

Aliases: CHM = `decompiled/core_module/scripts/chat/ChatManager.as`, CSO = `decompiled/core_module/scripts/chat/ChatSocketOutManager.as`.

## 1. Overview

The only message of the `cross` protobuf package, `cross.CrossBigBugleMsg`, carries the cross-server bugle: a chat line broadcast to every server of the cross group. The full chat behavior (channel 13, top scrolling bugle, emoticons, free uses, quick buy) is specified in [../chat/bugles.md](../chat/bugles.md). This module records the protocol contract and the cross relay, which belongs to this feature.

## 2. Screens

See [../chat/bugles.md](../chat/bugles.md): chat input with channel "Megafone Inter-S" and `ChatTopBugleView` (`crossBugleList`).

## 3. Routes (client to server)

### R1. Send a cross bugle

- UI and checks: chat input on "Megafone Inter-S"; item 2170005 count > 0 else quick buy ([../chat/bugles.md](../chat/bugles.md) U4).
- Sender: `ChatSocketOutManager.sendCrossChat` (`CSO:453-460`).
- Route: C>S 8623 (0x21af) `C_SEND_CROSS_BIGBUGLE`, `cross.CrossBigBugleMsg` with `content (#8, STRING)` only.
- Response: S1 4541 to all online players of every server in the cross group (sender included).

## 4. Server messages (server to client)

### S1. 4541 (0x11bd) `U_C_CROSS_BIGBUGLE`

`cross.CrossBigBugleMsg`, receiver `ChatManager.__crossBugleHandler` (`CHM:50`, `CHM:56-97`):

| Field | Tag, type | Meaning |
|---|---|---|
| `server_id` | #1 INT32 | origin server id |
| `server_name` | #2 STRING | origin server name, shown "[server-nick]" |
| `uid` | #4 STRING | origin account uid |
| `user_id` | #5 INT32 | origin player id |
| `nick_name` | #6 STRING | sender name |
| `is_lookInfo` | #7 BOOL | name clickable for player info |
| `content` | #8 STRING | text |
| `param1` | #9 INT32 | 0 or 1 bugle, 2 invitation |
| `param2` | #10 STRING | rose gift announcements (friends feature) |
| `friendUserId` | #11 INT32 | rose gift target |
| `uuid` | #12 STRING | player uuid |
| `site` | #13 STRING | origin site |
| `grade` | #14 INT32 | sender level |

Field #3 does not exist.

## 5. Rules and formulas

- Cost: one item 2170005 per message (free uses `crossBugleFreeCount` exist but no client path spends them).
- The cross group is the same server grouping used by the other cross features (assumption: one global group per region).

## 6. Templates

None (item 2170005 in `ItemTempInfos.xml`).

## 7. Persistent state

No table here; consumption and free counters live in the chat feature (`cross_free_used`, [../chat/bugles.md](../chat/bugles.md)). Optional audit log:

```sql
CREATE TABLE cross_server.bugle_log (
    message_id  bigserial   PRIMARY KEY,
    server_id   integer     NOT NULL,
    user_id     bigint      NOT NULL,
    nick_name   text        NOT NULL,
    content     text        NOT NULL,
    sent_at     timestamptz NOT NULL DEFAULT now()
);
CREATE INDEX bugle_log_sent_idx ON cross_server.bugle_log (sent_at);
```

## 8. Backend implementation notes

- `chat::bugles::handle_cross_bugle` (8623) validates and consumes the item (chat feature), then calls `cross_server::relay::publish_bugle(msg)`.
- `cross_server::relay`: a bus (for example a PostgreSQL `LISTEN/NOTIFY` channel or a message broker) shared by the servers of the group; each server's subscriber fills `server_id`, `server_name`, `user_id`, `nick_name`, `grade`, `uuid`, `site` from the origin and pushes 4541 to its online players.
- Rate limit per player (assumption: 1 message per 10 s).

## 9. Open questions and assumptions

- Assumption: group membership and rate limit.

## 10. Implementation checklist

- [ ] Relay bus and subscriber per server.
- [ ] Route 8623 hook into the relay.
- [ ] Server message 4541 with origin fields.
- [ ] Optional table `cross_server.bugle_log`.
- [ ] Test: message from server A appears on server B with "[A-nick]".
