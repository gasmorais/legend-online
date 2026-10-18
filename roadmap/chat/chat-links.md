# Chat links, markup and name menu

Feature `chat`, module `chat-links`. How message text carries clickable elements (players, items, stars, magic cards, rooms, emoticons and feature specific links), what the client sends to create them, what the server must produce, and the player name menu.

Conventions as in [channels.md](channels.md).

## 1. Overview

Outgoing: the input box shows linked objects as `[Name]` (the item, star or card template name). On send the client parses every `[...]` group and attaches the matching objects as `ChatItemInfoMsg`, `ChatStarInfoMsg`, `ChatPowCardInfoMsg` and space time share XML strings (`ChatInputViewII.sendChat` `decompiled/core_module/scripts/chat/view/ChatInputViewII.as:454`).

Incoming: the receiver never reads those lists. `ChatManager.__channelChatHandler` uses only `encode_msg`; `ChatFormat` (`decompiled/core_module/scripts/chat/utils/ChatFormat.as`) splits it into text and XML tags `<a t='N' .../>`. So the server must rewrite each `[Name]` into the corresponding tag before broadcasting (Assumption derived from the reader: no other path creates the cells). Emoticons are sent as `#NN` (00 to 39) and converted client side to `<a t='9' index='NN' name='NN'/>`, except the literal messages `#36` and `#25` (`ChatManager.analyzeExpression` `decompiled/core_module/scripts/chat/ChatManager.as:204`).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `chat.view.ExpressionList` `decompiled/core_module/scripts/chat/view/ExpressionList.as` | "Emoticon" | emoticon picker inserting `#NN` | input emoticon button | |
| Item, star, card tips (`ChatEquipTips`, `ChatFashionTips`, `ChatMonsterAccesoriesTips`, `PropTips`, `RuneTip`, `MountCardTip`, `ChatStarTip`) | none | show linked object details from the tag attributes (`ChatOutputViewII.__equipClickHandler` `decompiled/core_module/scripts/chat/view/ChatOutputViewII.as:965`, `__propClickHandler` `:1017`, `__starClickHandler` `:946`) | click on a link | tag data only (no server request) |
| `chat.view.ChatItemMenu` `decompiled/core_module/scripts/chat/view/ChatItemMenu.as` | "Privado", "Adicionar amigo", "Copiar Nome", "Lista Negra", "Ver Informações", "Convite de Guilda", "Pedir em casamento", "Aplicar para a Equipe", team invite, duel | player name menu | click on a player name (`ChatOutputViewII.__playerNameClickHandler` `:524`) | user id, name, level, server, uuid |

## 3. Routes (client to server)

Sending links is part of C1 in [channels.md](channels.md) and U1 to U4 in [bugles.md](bugles.md). Fields written by the client:

| Message | Fields filled (`ItemHelper.createChatItemInfoMsg` `decompiled/core_module/scripts/com/road/pb/helper/item/ItemHelper.as:107`, `ChatInputViewII.as:510` to `:540`) |
|---|---|
| `ChatItemInfoMsg` | `id (#1, INT32)` item object id, `template_id (#2, INT32)`, `item_name (#28, STRING)` = the `[Name]` text, `strengthen_grade (#17, INT32)`, `bind (#7, BOOL)`, `join_1..join_4 (#18, #19, #20, #29, INT32)`, `random_skill_1..5 (#21 to #25, INT32)`, `mould_grade (#31, INT32)`, `property1 (#30, STRING)`, `appraisal_skill (#32, INT32)`. Not filled: `pos`, `exist`, `object_id`, `bag_type`, `used`, `valid_date`, `begin_date`, `count`, `attack`, `defence`, `agility`, `ability`, `captain`, `is_new`, `user_id`, `life_skill` |
| `ChatStarInfoMsg` | `template_id (#2, INT32)`, `grade (#8, INT32)`, `star_name (#11, STRING)` |
| `ChatPowCardInfoMsg` | `template_id (#2, INT32)`, `grade (#8, INT32)`, `powcard_name (#11, STRING)` |
| `shareTimeSpace (#29, STRING, repeated)` | raw XML strings of space time fault shares whose `@data` matches the `[...]` text |

Name menu actions (each route is owned by another feature):

| Menu item | Sender | Route |
|---|---|---|
| "Privado" | `ChatItemMenu.__chatmessageHandler` `ChatItemMenu.as:352` (level 6) then `IMManager.createIMFrame` | IM, [../friends/instant-messages.md](../friends/instant-messages.md) |
| "Adicionar amigo" | `__addfriendHandler` `:452` | 15003 or cross 9606 op 0, [../friends/friend-list.md](../friends/friend-list.md) |
| "Lista Negra" | `__blacklistHandler` `:390` | 15003 relation 2 or 9606 op 2 |
| "Copiar Nome" | `__copyNameHandler` `:384` | clipboard only |
| "Ver Informações" | `__messageHandler` `:418` | C>S 8200 `C_SIMPLEUSER_INFO` (`InfoReqMsg`: `other_id (#1)`, `from (#2)`) or C>S 25097 `CR_WARFIELD_USER_INFO` (`DetailReqMsg`: `user_id (#1)`, `server_name (#2)`, `other_id (#3)`, `other_name (#4)`) for another server; response handled by `PlayerManager` (hero feature) |
| "Convite de Guilda" | `__consortiaHandler` `:373` | guild invite 5142, [../guild/membership.md](../guild/membership.md) |
| team invite / "Aplicar para a Equipe" | `__inviteHandler` `:550`, `__applyJoinHandler` `:562` | 8738 / 8807, [../team/freedom-team.md](../team/freedom-team.md) |
| "Pedir em casamento" | `__proposeHandler` `:556` | marriage propose frame, [../marriage/proposal-and-engagement.md](../marriage/proposal-and-engagement.md) |
| duel | `__pkBtnClickHandler` `:527` | PvP feature |

Other clickable cells and what they trigger (`ChatOutputViewII` listeners `:216` to `:245`): room link (enter room or wedding room, `__roomClickHandler` `:780`), guild link (8343 guild preview, guild feature), game hall and apex team invitations, magic card link (opens `magiccard` view), appellation link, rose back (opens rose present back view with item 2170001/2170005), reinforce (world boss help), seek link (treasure hunt), fish, gold road, outer city boss, planes help, open sale, treasure, space time share, alchemical invite, gods evening goto, crisis attack invite, guild new boss.

## 4. Server messages (server to client)

`ChatChannelMsg.encode_msg` markup produced by the server. Tags are `<a t='N' attr='...'/>` elements embedded in text; attribute values must be XML escaped.

| `t` | Cell | Attributes read | Reader |
|---:|---|---|---|
| 1 | player name (wrapped in `[` `]`) | `id`, `serverName`, `grades`, `consortiaId`, `name`, `uuid` | `ChatFormat.createSysCellDataByContent` `ChatFormat.as:153`, `createPlayerCellData` `:567` |
| 2, 14 | item | `tempid` (template id), `id`, `grade` (strengthen), `mouldGrade`, `bind` (`"true"`), `appSkill`, `join` (`j1,j2,j3,j4`), `skill` (`s1,s2,s3,s4,s5`), `name` | `createGoodsCellData` `:471` (equipment when template `MasterType` 1, 3, 5, 6 or `SonType` 232, else prop) |
| 3 | cosmos star | `id` (star template id), `grades`, `name` | `createStarCellData` `:428` |
| 7 | VIP link | `name` | `createVipLinkCellData` `:367` |
| 8 | image by son type | `sontype` | `createImageCellDataBySonType` `:346` |
| 9 | emoticon | `index`, `name` | `createExpressionByIndex` `:337` |
| 10 | appellation link | `appellId`, `name` | `createAppellLinkCellData` `:691` |
| 11 | rose back | `userId`, `templateId`, `name` | `createRoseBackCellData` `:702` |
| 12 | reinforce request | `userId`, `mapId`, `posX`, `posY`, `name` | `createReinforceCellData` `:738` |
| 15 | pet boss reinforce | as 12 | `createPetBossReinforceCellData` `:772` |
| 16 | magic card back | | `createCardBackCellData` `:726` |
| 100 | seek link | `userId`, `mapId`, `posX`, `posY` | `createSeekLinkCellData` `:755` |
| 101 | magic card | `id`, `grades`, `bufId`, `sonType`, `fixValue`, `percent`, `name` | `createCardCellData` `:447` |
| 102 | fish | | `createFishCellData` `:417` |
| 110 | gold road | | `createGoldRoadCellData` `:716` |
| 111, 112, 113 | outer city boss, planes help, open sale | `name`, `userId` | `:305`, `:315`, `:326` |
| 114 | item plus treasure | item attributes, `treasureId`, `quality` | `createTreasureCellData` `:376` |
| 116 | space time share | `name`, `data` | `creatSpaceTimefault` `:386` |
| 117 | alchemical invite | `name`, `rewardType`, `shareUid` | `creatAlchemicalInvite` `:397` |
| 118 | crisis attack invite | `userId`, `nodeId` | `creatCrisisAttcknvite` `:407` |
| 121 | guild new boss | | `createConsortiaNewBossOpenData` `:294` |

Message `type` values: 3 = the message is a player link tag (rendered as `[name]`), 4 = a room tag: `<a t='4' teamId gameId difficulty name/>` game hall, `t='120'` apex team (`teamId`, `name`), otherwise a room with `id`, `campaignId`, `roomType`, `position` (0 = locked), `name`; `roomType = 4` is a wedding room (`id` = room key `userIdA_userIdB`, `position` = password) (`createRoomCellData` `:621`). `user_type` 2 shows the GM icon, 6 the guide icon; `appellid` non zero shows the title prefix (`createSpeakerCellData` `:1032`).

## 5. Rules and formulas

- Link replacement: for each attached object whose name appears as `[Name]` in the text, replace the first occurrence with its tag; the server must rebuild item attributes from its own inventory (by `id` and owner) instead of trusting client values (Assumption: anti forgery).
- Unknown templates make the client drop the cell (`createGoodsCellData` returns null), so only real template ids may be emitted.
- Emoticons `#00` to `#39`.

## 6. Templates

| File | Use |
|---|---|
| item, star, magic card templates | names, profiles (colors) |
| appellation templates | title prefix |

## 7. Persistent state

None.

## 8. Backend implementation notes

- `chat::links::render(sender, text, items, stars, powcards, shares) -> String` called by every chat send handler; escapes user text (`<`, `>`, `&`, quotes) before inserting tags.
- `chat::links::player_tag(player)`, `item_tag(item)`, `room_tag(room)` helpers for system messages of other features (guild recruit, room invites, wedding announcements, rose gifts).

## 9. Open questions and assumptions

1. The original server behavior for `[Name]` replacement is inferred; it is the only way the receiver can render links.
2. Tag attribute sets for `t` 8, 16, 102, 110 are not fully mapped here (owned by their features).

## 10. Implementation checklist

- [ ] `chat::links::render` for items, stars, magic cards, space time shares
- [ ] XML escaping of user text
- [ ] Player and room tag helpers for system messages
- [ ] Name menu routes reach the owning features
- [ ] Test: item link tip shows strengthen, joins and random skills
- [ ] Test: emoticons and the `#36`/`#25` literal exception
