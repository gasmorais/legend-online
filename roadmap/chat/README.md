# Chat

Feature slug `chat`, domain social. Client package `chat` (`decompiled/core_module/scripts/chat`): `ChatManager`, `ChatModel`, `ChatSocketOutManager`, `utils/ChatHelper`, `utils/ChatFormat`, `utils/GroupChatFormat`, views `ChatInputViewII`, `ChatOutputViewII`, `ChatBugleViewII`, `ChatTopBugleView`, `ChatItemMenu`, `ExpressionList`. Protobuf package `chat` (chat messages: `ChatChannelMsg`, `ChatItemInfoMsg`, `ChatStarInfoMsg`, `ChatPowCardInfoMsg`, `ChatStateMsg`, `ChatStateListRspMsg`, `RecentContractsStateReqMsg`, `FirendStateMsg`, `CatFirendStateMsg`). The same proto package also holds cat house (`Cat*Msg`, see [../cat-house/README.md](../cat-house/README.md)) and auto chess (`ChessRoomMsg`, `SelfChessPlayerMsg`) messages that belong to other features.

## What it does for the player

- Chat box at the bottom left with output tabs and an input line with a channel selector: "Atual" (current scene, 8), "Global" (world, item "Corneta", 10), "Megafone" (big bugle, 1), "Megafone Inter-S" (cross server bugle, 13), "Guilda" (5), "Equipe" (team, 6), "Equipe" (group team, 14), "Terralém" (outyard, 109), plus received only channels "Sistema" (2, 11), "Mensagem" (3), "Comunicado" (12, 15), "Privado" (20, from IM).
- Slash shortcuts `/k`, `/d`, `/x`, `/p`, `/g`, `/a`, `/t`, `/w` switch channel (`ChatChannel.chanel_key_set`).
- Emoticons `#00`..`#39`, item, star (cosmos), magic card and space time share links inside messages, clickable player names with a context menu (private chat, add friend, copy name, blacklist, view info, guild invite, team invite or request, propose).
- Rate limits, level 6 to talk, word filter.
- Bugles scroll on top of the screen.
- Busy/away status and auto reply ("chat state") is part of the instant messenger: see [../friends/instant-messages.md](../friends/instant-messages.md) (C>S 15029 `CH_EXCHANGE_STATE`, S>C 4232 `U_CH_EXCHANGE_STATE`, and recent contacts state 15043/4272).

## Entry points

The chat bar is always visible after login (`ChatBar`). Channel tabs and the input are available from level 1 but sending requires hero level 6 (`ChatHelper.checkCanSend` `decompiled/core_module/scripts/chat/utils/ChatHelper.as:53`). `ChatManager.setup` registers listeners (`decompiled/core_module/scripts/chat/ChatManager.as:47`).

## Modules

| Module | File | Scope |
|---|---|---|
| Channels | [channels.md](channels.md) | Normal channel send (15005 and cross variants 25024, 25096, 25211), receive 83, channel list, recipient lists for current and team channels, rate limits, chat ban switch, server alerts 111 |
| Bugles | [bugles.md](bugles.md) | Big bugle (5011), global/small bugle (8198, free count 8705/4500), cross server bugle (8623/4541), outyard chat (9609), bugle displays |
| Chat links and menus | [chat-links.md](chat-links.md) | Message markup (`<a t='..'/>` tags), item/star/card links sent with `ChatItemInfoMsg`, `ChatStarInfoMsg`, `ChatPowCardInfoMsg`, emoticons, player name menu and other clickable cells |

## Dependencies

- [../friends/README.md](../friends/README.md): private chat (IM), chat state, add friend and blacklist from the name menu, cross server relation chat (348 channels 5, 6, 7 shown on channel 109).
- [../team/README.md](../team/README.md): team channel recipients (`FreedomTeamManager`, groupfb rooms, Brave Legend teams, game hall rooms).
- [../guild/README.md](../guild/README.md): guild channel 5, guild group chat window, guild links in chat.
- [../marriage/README.md](../marriage/README.md): marriage bugles (`bigBugleType` 6, 7, 8, 9, 12) and wedding room links.
- [../inventory/README.md](../inventory/README.md): bugle items 208002 "Megafone", 208003 "Corneta", 2170005 "9999 Rosa(s)"; quick buy.
- Hero/player info (`PlayerInfoManager`, 8200/25097) for "Ver Informações".
- Many features push system messages through channels 2, 3, 11, 12 (event announcements); they only need the encoder from [channels.md](channels.md).

## Suggested implementation order

1. [channels.md](channels.md): 15005/83 for channels 8, 10 (without item cost first), 5, 6; system channel pushes; alert 111.
2. [chat-links.md](chat-links.md): server side link markup generation.
3. [bugles.md](bugles.md): items and free counts, top bugle display.
4. Cross server variants (25024, 25096, 25211, 8623, 9609).
