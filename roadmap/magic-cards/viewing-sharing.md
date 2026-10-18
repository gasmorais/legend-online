# Card inspection, chat sharing and other players' cards

Scope: the "Informações da Carta" inspection frame (own cards and cards linked in chat), sharing a card in chat, and the card data the server must include when other players' details are shown (equipment look, Laboratório de Platina rival, rankings). Collection state comes from [collection.md](collection.md).

Path aliases:

| Alias | File |
|---|---|
| CHECK | `decompiled/m5/scripts/magicCard/MagicCardCheckFrame.as` |
| ITEM | `decompiled/m5/scripts/magicCard/view/base/MagicCardSlotItem.as` |
| CTRL | `decompiled/core_module/scripts/mvc/controler/MagicCardControler.as` |
| MODEL | `decompiled/core_module/scripts/mvc/module/card/MagicCardModel.as` |
| CIN | `decompiled/core_module/scripts/chat/view/ChatInputViewII.as` |
| COUT | `decompiled/core_module/scripts/chat/view/ChatOutputViewII.as` |
| CFMT | `decompiled/core_module/scripts/chat/utils/ChatFormat.as` |
| CSOM | `decompiled/core_module/scripts/chat/ChatSocketOutManager.as` |
| PIF | `decompiled/m5/scripts/playerinfo/PlayerInfoFrameII.as` |
| PLM | `decompiled/core_module/scripts/managers/PerkinLabManager.as` |
| SORT | `decompiled/core_module/scripts/mvc/controler/SortController.as` |

## 1. Overview

- Players can open a large animated view of any card ("Ver") and browse the cards of the same series with "Anterior"/"Próxima" when looking at their own cards.
- "Compartilhar" inserts a `[card name]` link into the chat input; the chat message carries the card id and grade, and receivers click the link to open the inspection frame in read-only mode.
- Other players' activated cards travel as `(templateId, grades)` pairs inside the player detail message, the Laboratório de Platina rival detail and the ranking XML. The BR client stores them but does not render them; the server must still fill them for protocol completeness.
- All inspection is client side; the only server work is chat relay and filling detail messages.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| CHECK `magicCard.MagicCardCheckFrame` (520x590 per `docs/ui/screens.md`) | "Informações da Carta" (`card.CardCheckFrame.title`, CHECK `:65`) | Large card view with animation | (a) own slot "Ver" button: `cardModel.isSelfCheck = true`, frame created directly with `data = getInfoByTypeAndPos(type, pos)` (ITEM `:132-138`); (b) chat card link: `isSelfCheck = false`, `openControllerByInfo("magiccard", 1, MagicCardInfo)` (COUT `:927-944`), openType 1 selects this frame (CTRL `:37-45`) and passes `frameData` as `data` (CTRL `:27-35`) | Background by `Profile` (`bg` frame), level "Nv.{0}" (`public.level2`) hidden for Profile 5 (CHECK `:243-252`), `TemplateName` (CHECK `:258`), skill names of the shown grade joined by "," (CHECK `:265-279`), animation `icon/powcard{Icon}.swf` (`PathManager.getCardSwfPath`, CHECK `:151-156`); arrows "Anterior"/"Próxima" visible only when `isSelfCheck` (CHECK `:72-73`, `:241`) |

Template resolution in CHECK (`:229-236`): `templateId == 0` -> by `(types, pos, grades)`; otherwise by `(templateId, grades)`. A chat link carries only `templateId` and `grades`.

## 3. Routes (client to server)

### R1. Open own card view (client only)
- UI: "Ver" (`magicCard.cardSlotItem.checkBtn`, tip `card.CardFrame.check`), visible on hover of an activated slot (ITEM `:77`, `:98`, `:146-156`).
- No request.

### R2. Browse cards in the view (client only)
- UI: "Anterior" / "Próxima" (CHECK `:67-73`, `:91-149`).
- Client checks: clicks closer than 600 ms -> tip "Clique excessivo, tente novamente" (`activity.view.ActivityItem.command01`, CHECK `:95-100`); series with max `Pos` 1 -> "Não há mais cartas para visualizar" (`card.CardCheck.notCheck`, CHECK `:102-108`).
- Navigation wraps over positions 1..maxPos of the series (`getMaxPosByType` = 4); the shown card is the owned card at that position, or a grade 1 placeholder of the template when not activated (CHECK `:136-148`).
- No request.

### R3. Share a card in chat
- UI: "Compartilhar" (`magicCard.cardSlotItem.shareBtn`, tip `card.CardFrame.share`) on an activated slot (ITEM `:78`, `:99`, `:140-144`) sends the notification `SEND_CARD` with the `MagicCardInfo`.
- `ChatInputViewII.__sendCardInfoHandler` (CIN `:143`, `:338-345`) stores the card in `_sendCardList` and appends `[TemplateName]` (name of the `(types, pos, grades)` template) to the input text.
- On send, for each `[name]` token matching a stored card, the client builds `chat.ChatPowCardInfoMsg` with `templateId`, `grade`, `powcardName` (CIN `:528-539`) and passes the list as `cardList` (CIN `:581-602`).
- Route: send 15005 (0x3a9d) `U_CH_CHANNEL_CHA` (normal channels, `ChatSocketOutManager.sendChat`, CSOM `:59-151`), or 5011 (0x1393) `C_BAG_USEBIGBUGLE` (CSOM `:472-480`), or 8198 (0x2006) `C_BAG_USESMALLBUGLE` (CSOM `:484-494`), always with `chat.ChatChannelMsg`. Owned by [chat](../chat/README.md); fields relevant here:
  - `channel` (#1, INT32), `encode_msg` (#3, STRING) chat text containing `[card name]`.
  - `powcards` (#19, MESSAGE `ChatPowCardInfoMsg`, repeated).
- `chat.ChatPowCardInfoMsg` (all optional; the client fills only #2, #8, #11):
  - `id` (#1, INT32), `template_id` (#2, INT32) card `TemplateId`, `user_id` (#3, INT32), `object_id` (#4, INT32), `pos` (#5, INT32), `exist` (#6, BOOL), `bag_type` (#7, INT32), `grade` (#8, INT32) card grade, `gp` (#9, INT32), `is_lock` (#10, BOOL), `powcard_name` (#11, STRING) link text, `buffId` (#12, INT32), `sonType` (#13, INT32), `fixValue` (#14, INT32), `percent` (#15, INT32).
- Server: validate that the sender owns the card at that grade (assumption, anti-forgery), then relay the chat as 83 `U_CH_CHANNEL_CHA` with the link markup (S1).

### R4. Open a card link from chat (client only)
- UI: click on a chat cell of type 27 (`ChatCellType.MAGIC_CARD = 27`, `decompiled/core_module/scripts/chat/datas/ChatCellType.as:54`), dispatched as `CARD_CLICK` (`decompiled/core_module/scripts/chat/datas/ChatCellData.as:337`).
- Client checks (COUT `:927-944`): ignored while in battle (`ChatBar.inBattleFlag`); when in a Batalha de Athena team (`BraveLegManager.hasTeam()`) -> tip "Favor sair primeiro do grupo atual!" (`braveleg.Error.str08`).
- Then `isSelfCheck = false` and open CHECK with the linked `MagicCardInfo`. No request.

### R5. View another player's details (owned by hero)
- Route: send 8199 (0x2007) `C_BAG_EQUIPLOOK` with `simple.DetailReqMsg` (`decompiled/core_module/scripts/yishi/manager/PlayerInfoManager.as:47-57`): `user_id` (#1, INT32), `server_name` (#2, STRING), `other_id` (#3, INT32), `other_name` (#4, STRING), `item_info` (#5, BOOL), `army_info` (#6, BOOL), `hero_info` (#7, BOOL), `pawn_info` (#8, BOOL). See [hero](../hero/README.md).
- Response 4125 (S2) must include the target's activated cards in `cardInfos`.

## 4. Server messages (server to client)

### S1. 83 (0x0053) `U_CH_CHANNEL_CHA` (chat, owned by [chat](../chat/README.md))
- `chat.ChatChannelMsg.encode_msg` (#3) must contain, for each shared card, the markup parsed by `ChatFormat` tag type 101 (CFMT `:225-228`): `<a t='101' id='{templateId}' grades='{grade}' bufId='..' sonType='..' fixValue='..' percent='..' name='{card name}'/>` (attributes read in CFMT `:447-469`). Assumption: the server converts each `ChatPowCardInfoMsg` into this markup when relaying (the client never writes `t='101'` itself).
- Client reaction: `createCardCellData` returns null when `(id, grades)` has no template (link dropped); otherwise builds a type 27 cell whose color follows `Profile` (CFMT `:449-468`). `bufId`, `sonType`, `fixValue`, `percent` are parsed into a `MagicCardBuffInfo` that is not used; send 0.

### S2. 4125 (0x101d) `U_C_BAG_EQUIPLOOK` (player detail, owned by [hero](../hero/README.md))
- Message `simple.DetailRspMsg`; magic card field: `cardInfos` (#9, MESSAGE `SimpleMagicCardInfoMsg`, repeated).
- `simple.SimpleMagicCardInfoMsg`: `templateId` (#1, INT32) card `TemplateId`; `grades` (#2, INT32) grade.
- Receiver: `PlayerInfoFrameII.__receiveEquipHandler` (PIF `:211`, `:598`, `:655`, `:1183-1192`) builds `MagicCardFightInfo{templeteId, gardes}` and passes them to `EquipInfoView.initData` (PIF `:435`, `decompiled/m5/scripts/playerinfo/view/EquipInfoView.as:438-445`) -> `EquipCheckList._fightList` (`decompiled/m5/scripts/playerinfo/view/EquipCheckList.as:163-169`), which is never read.
- When: response to 8199. Fill with all activated cards of the target (one entry per `player_cards` row).

### S3. Laboratório de Platina rival detail (owned by [laboratory](../laboratory/README.md))
- `perkinlab.PerkinLabKengMsg.rivalDetail` is a `simple.DetailRspMsg`; `cardInfos` (#9) is read by `PerkinLabManager.readDetailRspMsg` (PLM `:165`, `:170`, `:528-537`) into `PerkinLabThaneInfo.activeMagicCards`, then shown nowhere except the same unused `EquipCheckList` path (PIF `:265`). Fill like S2.

### S4. Ranking XML (owned by [rankings](../rankings/README.md))
- Static ranking files under `PathManager.orderPath` (SORT `:855-859`), for example `fight.xml`, `totalfightcapacity.xml` (SORT `:779-850`). Per player row:
  - attribute `MagicCards="tid,grade|tid,grade|..."` parsed into `SortData.activeMagicCards` (SORT `:125-136`);
  - child nodes `<PowCardFightInfo op=".." userId=".." camptype=".." add=".."/>` parsed into `SortData.cardFightInfoList` (SORT `:301-310`), same meaning as 4902 (see [battle-effects.md](battle-effects.md)).
- Used for the ranking player info frame (PIF `:254`), again only stored.
- When: whenever the ranking generator writes the files.

## 5. Rules and formulas

- Inspection throttle: 600 ms between arrow clicks (CHECK `:95-101`; same value as `MagicCardEnums.SPEED = 600`).
- Arrow navigation (CHECK `:109-135`): left from pos 1 wraps to maxPos; right from maxPos wraps to 1.
- Only activated cards can be shared (share button visible only on activated slots, ITEM `:146-156`).
- Chat link color = card `Profile` (CFMT `:466`).
- Card name resolution for links uses the template, not the message name: the receiver displays `name` from the markup, but opens the frame by `(id, grades)`.

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `raw/xml/tempinfos/MagicCardTempInfos.xml` | Card grade row | `TemplateId`, `Grades`, `Types`, `Pos`, `Profile`, `TemplateName`, `Icon` (SWF and PNG paths), `SkillTempIds` |
| `raw/xml/tempinfos/SkillTempInfos.xml` | Card skills | `TemplateName` shown in CHECK |

## 7. Persistent state

No new table. Reads `magic_cards.player_cards` ([collection.md](collection.md)). Chat messages are persisted (if at all) by the chat feature.

## 8. Backend implementation notes

| Function | Purpose |
|---|---|
| `magic_cards::viewing_sharing::validate_shared_cards(player_id, &[ChatPowCardInfoMsg]) -> Vec<CardLink>` | Called by the chat send handlers (15005, 5011, 8198): drop entries whose `(template_id, grade)` is not owned by the sender at that grade, resolve the template name |
| `magic_cards::viewing_sharing::render_card_links(&[CardLink]) -> String` | Produce the `<a t='101' .../>` markup inserted into `encode_msg` for 83 |
| `magic_cards::viewing_sharing::simple_card_infos(target_player_id) -> Vec<SimpleMagicCardInfoMsg>` | Used by the hero detail handler (8199 -> 4125), the laboratory rival detail and the ranking export |

- Validation order for shared cards: card exists in the template, sender owns it, grade matches the owned grade (or replace the grade with the owned one).
- No transactions (read only). No pushes beyond the chat relay owned by the chat feature.
- Rate limiting of chat is the chat feature's concern.

## 9. Open questions and assumptions

- Assumption: the server converts `powcards` into `<a t='101' ...>` markup in `encode_msg`, mirroring how items and stars are linked; the client only appends `[name]` text.
- Assumption: the server validates card ownership for shared links (not enforced by the client).
- Open: the BR client never renders other players' cards (`EquipCheckList._fightList` unused); confirm whether a future UI needs more than `(templateId, grades)`.
- Open: exact ranking XML file set that carries `MagicCards` and `PowCardFightInfo` (the parser is shared by all ranking files).

## 10. Implementation checklist

- [ ] Screen check: own "Ver" opens "Informações da Carta" with arrows and animation.
- [ ] Screen check: arrows wrap 1..4 and show grade 1 placeholders for non-activated cards.
- [ ] Screen check: chat card link opens the frame without arrows.
- [ ] Chat send handlers (15005, 5011, 8198) call `validate_shared_cards` for `ChatChannelMsg.powcards` (#19).
- [ ] Chat relay 83 includes `<a t='101' id grades bufId sonType fixValue percent name/>` markup.
- [ ] 4125 `DetailRspMsg.cardInfos` (#9) filled with the target's activated cards.
- [ ] Laboratório de Platina rival detail fills `cardInfos`.
- [ ] Ranking export writes `MagicCards` attribute and `PowCardFightInfo` nodes.
- [ ] Test: sharing a card the player does not own (forged packet) produces no link.
- [ ] Test: link with an unknown `(id, grades)` is ignored by the client without errors.
- [ ] Test: clicking a link during battle does nothing; in an Athena team shows "Favor sair primeiro do grupo atual!".
