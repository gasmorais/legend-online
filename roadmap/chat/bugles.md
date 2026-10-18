# Bugles and server wide channels

Feature `chat`, module `bugles`. Paid or limited broadcast channels: "Megafone" (big bugle), "Global" (small bugle, world channel), "Megafone Inter-S" (cross server bugle) and "Terralém" (outyard chat).

Conventions as in [channels.md](channels.md).

## 1. Overview

| Channel | pt-BR | Cost | Send opcode | Receive |
|---:|---|---|---|---|
| 1 | "Megafone" | 1 item 208002 "Megafone" | 5011 | 83 (channel 1, bugle list and top scroller) |
| 10 | "Global" | 1 item 208003 "Corneta", or one daily free use (`SMALL_BUGLE_FREE_COUNT = 10`) | 8198 | 83 (channel 10) |
| 13 | "Megafone Inter-S" | 1 item 2170005 "9999 Rosa(s)" | 8623 | 4541 |
| 109 | "Terralém" | free, only while the outyard map application is active | 9609 | 348 (channels 5, 6, 7, see [../friends/cross-server-relations.md](../friends/cross-server-relations.md)) |

When the item is missing the client opens the quick buy frame and, after the purchase callback, sends the message with a flag that skips the item check (`ChatInputViewII.shopBugleBack` `decompiled/core_module/scripts/chat/view/ChatInputViewII.as:730`).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `ChatInputViewII` channel selector | "Megafone", "Global", "Megafone Inter-S", "Terralém" | choose the channel | chat bar | |
| `quickbuy.buyFrame` (`BuyFrameI`) | shop item frame | buy the missing bugle | `quickUIcallback` `ChatInputViewII.as:657` | shop template of the item |
| `chat.view.ChatTopBugleView` `decompiled/core_module/scripts/chat/view/ChatTopBugleView.as` | none | scrolling bugle at the top of the screen | channel 1, 11, 15 and `is_bigTip` messages (`UPDATE_BIGBUGLE_VIEW`) | `ChatModel.bigBugleList`, `crossBugleList` |
| `chat.view.ChatBugleViewII` `decompiled/core_module/scripts/chat/view/ChatBugleViewII.as` | none | bugle panel above the chat | | |

## 3. Routes (client to server)

| # | UI control | Client sender | Client checks | Route | Request | Response |
|---|---|---|---|---|---|---|
| U1 | Send on "Megafone" | `ChatInputViewII.bigBugleHandler` `ChatInputViewII.as:637` then `ChatManager.chatByBugle` `decompiled/core_module/scripts/chat/ChatManager.as:302` then `ChatSocketOutManager.sendBugleChat` `decompiled/core_module/scripts/chat/ChatSocketOutManager.as:472` | `checkCanSend` (level 6, not empty); item 208002 count > 0, else tip "Não há acessório correspondente, essa função não pode ser utilizada" and quick buy | C>S 5011 0x1393 `C_BAG_USEBIGBUGLE` | `ChatChannelMsg`: `encode_msg (#3)`, `items (#17)`, `stars (#18)`, `powcards (#19)`, `shareTimeSpace (#29)`; `channel` unset | 83 channel 1 to all online players; bag update for the consumed item |
| U2 | Send on "Global" with a "Corneta" | `ChatInputViewII.smallBugleHandler` `:666` then `ChatManager.chatBySmallBugle` `:318` then `sendSmallBugleChat` `ChatSocketOutManager.as:484` | 2 s between sends (`ChatHelper.as:91`); item 208003 > 0 | C>S 8198 0x2006 `C_BAG_USESMALLBUGLE`, header `extend1` = sequence | `ChatChannelMsg` as U1 | 83 channel 10 to all online players (same `extend1` to the sender) |
| U3 | "Global" without item and free uses left | `smallBugleHandler` sets a pending flag then `ChatSocketOutManager.sendSmallBugleFreeCount` `:503` | `thane.smallBugleFreeCount > 0` | C>S 8705 0x2201 `C_SMALL_BUGLE_FREE_COUNT` | `CampaignReqMsg` empty | 4500; the client then sends U2 (`__smallBugleFreeCountHandler` `ChatInputViewII.as:697`) using the free use (Assumption: the server consumes a free use before an item when the count is > 0) |
| U4 | Send on "Megafone Inter-S" | `crossBugleHandler` `:607` then `ChatManager.chatByCross` `:286` then `sendCrossChat` `ChatSocketOutManager.as:453` | item 2170005 > 0, else quick buy | C>S 8623 0x21af `C_SEND_CROSS_BIGBUGLE` | `cross.CrossBigBugleMsg`: `content (#8, STRING)` only | 4541 to all players of the cross group |
| U5 | Send on "Terralém" | `outyardHandler` `:627` then `ChatManager.chatByOutyard` `:334` then `sendOutyardChat` `ChatSocketOutManager.as:461` | 2 s (`ChatHelper.as:97`); channel available only while `outyardControler.isOutyardMapApply` | C>S 9609 0x2589 `C_GRAND_WORLD_CHAT` | `friend.RelationGraphOpMsg`: `op (#1, ENUM)` = 5 (`CHAT`), `param1 (#2, STRING)` own uuid, `param2 (#3, STRING)` text, `channel (#4, ENUM)` = 6 (`HUGE_HEAD_FORCE`) | 348 with `from_channel` 5, 6 or 7 to outyard players |

## 4. Server messages (server to client)

| Route | Message | Client receiver | When |
|---|---|---|---|
| S>C 83 `U_CH_CHANNEL_CHA` | `ChatChannelMsg` with `channel` 1 or 10 (fields in [channels.md](channels.md)); `bigBugleType (#16, INT32)` 0 for player bugles | `ChatManager.__channelChatHandler` `ChatManager.as:110` | U1, U2 broadcast |
| S>C 4500 0x1194 `U_C_SMALL_BUGLE_FREE_COUNT` | `campaign.CampaignReqMsg`: `para_int1 (#1, INT32)` small bugle free uses left, `para_int2 (#2, INT32)` cross bugle free uses left | `ChatManager.__samllBugleFreeCountHandler` `ChatManager.as:99` (sets `thane.smallBugleFreeCount`, `crossBugleFreeCount`) | response to 8705, at login and after each free use (Assumption) |
| S>C 4541 0x11bd `U_C_CROSS_BIGBUGLE` | `cross.CrossBigBugleMsg`: `server_id (#1, INT32)`, `server_name (#2, STRING)` shown as "[server-nick]", `uid (#4, STRING)`, `user_id (#5, INT32)`, `nick_name (#6, STRING)`, `is_lookInfo (#7, BOOL)` name clickable for info, `content (#8, STRING)` text (emoticons `#nn` converted client side), `param1 (#9, INT32)` 0 or 1 = bugle (channel 13), 2 = invitation (channel 108), `param2 (#10, STRING)`, `friendUserId (#11, INT32)`, `uuid (#12, STRING)`, `site (#13, STRING)`, `grade (#14, INT32)` | `ChatManager.__crossBugleHandler` `ChatManager.as:56` (ignored before the chat bar is loaded) | U4 broadcast and cross rose gift announcements |

## 5. Rules and formulas

- Daily free small bugles: `SMALL_BUGLE_FREE_COUNT = 10` ("每天免费小喇叭次数", `raw/xml/tempinfos/ConfigInfos.xml`); the client default is 1 until 4500 arrives (`decompiled/core_module/scripts/yishi/datas/playerinfo/ThaneInfo.as:108`). Reset daily at 00:00 (Assumption).
- Consumption order for "Global": free use first if available, else one "Corneta" (Assumption consistent with the client flow: free count is asked only when no item exists; the server should use the free count when the client did not have an item).
- Bugle items are consumed by the server on success; a failure (muted, filter) must not consume.
- Marriage notices use `channel 12` with `bigBugleType` 6, 7, 8, 9, 12 (`ChatManager.isMarryBugleType` `ChatManager.as:350`); `bigBugleType` 5 and 10 are bugle only (not added to the normal list).
- Rate limit 2 s for "Global" and "Terralém" (client); big bugle has no client limit.

## 6. Templates

| File | Record |
|---|---|
| `raw/xml/tempinfos/ItemTempInfos.xml` | 208002 "Megafone", 208003 "Corneta", 2170005 "9999 Rosa(s)" |
| `raw/xml/tempinfos/ConfigInfos.xml` | `SMALL_BUGLE_FREE_COUNT` 10 |
| shop templates | quick buy prices (shops feature) |

## 7. Persistent state

```sql
CREATE TABLE chat.bugle_daily (
    player_id          integer     NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
    day                date        NOT NULL,
    small_free_used    smallint    NOT NULL DEFAULT 0 CHECK (small_free_used >= 0),
    cross_free_used    smallint    NOT NULL DEFAULT 0 CHECK (cross_free_used >= 0),
    PRIMARY KEY (player_id, day)
);
```

Messages go to `chat.message_log` ([channels.md](channels.md)).

## 8. Backend implementation notes

| Opcode | Handler |
|---|---|
| 5011 | `chat::bugles::handle_big_bugle` |
| 8198 | `chat::bugles::handle_small_bugle` |
| 8705 | `chat::bugles::handle_free_count` |
| 8623 | `chat::bugles::handle_cross_bugle` |
| 9609 | `chat::bugles::handle_outyard_chat` |

- Validation: level 6, not muted, chat ban switch, word filter, cost available; then in one transaction consume the item (inventory API) or increment `chat.bugle_daily`; after commit broadcast and push the bag update and 4500 when a free use changed.
- Cross bugle: publish to the cross server bus; every server pushes 4541 to its online players.
- Outyard chat: route through the global relation service used by [../friends/cross-server-relations.md](../friends/cross-server-relations.md).

## 9. Open questions and assumptions

1. Free cross bugle count exists (`para_int2`) but no client path uses it.
2. Whether "Global" sends without item consume a free use server side automatically.
3. `param2`, `site`, `friendUserId` in `CrossBigBugleMsg` are used by rose gift announcements (friends feature).

## 10. Implementation checklist

- [ ] 5011 big bugle with item consumption and broadcast
- [ ] 8198 small bugle with item or free use, `extend1` echo
- [ ] 8705 / 4500 free counts and daily reset
- [ ] 8623 / 4541 cross bugle
- [ ] 9609 outyard chat
- [ ] Top bugle display for channels 1, 11, 15
- [ ] Test: quick buy then send path
