# Cartas mágicas (magic-cards)

Domain: character. Client packages `magicCard` (m5) and `card` (`mvc/module/card`, core_module); manager `yishi/manager/MagicCardManager.as`; controller `mvc/controler/MagicCardControler.as`. Protobuf packages `magiccard` and `powcard` (plus `simple.SimpleMagicCardInfoMsg`, `simple.SimplePowCardFightInfoMsg`, `chat.ChatPowCardInfoMsg`).

## Overview

"Carta Mágica" is a collection of 20 cards in 5 series ("Tau", "Imortal", "Luz", "Trevas", "Arma Antiga"), 4 cards per series. A card is activated by using its card item ("Ao usar, obterá Carta ..."), then upgraded from grade "Nv.1" to "Nv.9" with Pó Mágico, a currency obtained by absorbing (decomposing) duplicate card items. Each grade grants a passive skill (damage reduction, damage increase, chance to block 80% of damage, fury or healing on attack) that works only in the game mode bound to its series:

| Series | Mode (pt-BR text) |
|---|---|
| 1 Tau | "batalha de campanha de multiplayer, não inclui campanha de eventos" |
| 2 Imortal | "labirinto subterrâneo, labirinto do abismo e labirinto do purgatório" |
| 3 Luz | "batalha arena multiplayer" |
| 4 Trevas | "campo de batalha, inclusive nas batalhas contra outros jogadores e NPC" |
| 5 Arma Antiga | "combate da torre de julgamento" |

Players can inspect cards in "Informações da Carta" and share them in chat ("Compartilhar").

## Entry points

- Hero equipment panel: button `army.MagicCardBtn` ("Cartas Mágica:" tooltip with "Taxa de coleção" and "Nível de qualidade"), enabled from hero level 32 (`decompiled/m5/scripts/armyII/viewII/equip/EquipView.as:301`, `:1139-1163`, `:656-660`; `OpenGradesII.MAGIC_CARD = 32`, `decompiled/core_module/scripts/yishi/OpenGradesII.as:154`). Shown only when `VersionSwitch.MAGIC_CARD` (true, `decompiled/core_module/scripts/yishi/datas/VersionSwitch.as:52`). The button glows when free Caça ao Tesouro seeks exist, when card items can be absorbed or when a card can be activated (`EquipView.as:623-642`).
- Auto-open: a 4905 push with a card flagged `isActive` opens the frame (`EquipView.as:644-654`).
- Building model name `"magiccard"` for building `MasterType` 16 "Bar da Fantasia" and 18 (`decompiled/core_module/scripts/mvc/controler/BuildingControler.as:41-46`).
- Back navigation from Caça ao Tesouro and Bar da Fantasia (`setPreFrame("magiccard")`), and the board's Bar da Fantasia button opens `"magicpub"` (`decompiled/m5/scripts/magicCard/view/MagicCardSlotView.as:179-183`).
- Chat card links (cell type 27) open the inspection frame read-only (`decompiled/core_module/scripts/chat/view/ChatOutputViewII.as:927-944`).
- Bag: using a card item (`SonType` 600, `NeedGrades` 32) activates or decomposes the card.
- Controller key `"magiccard"` (`decompiled/core_module/scripts/yishi/datas/UIModuleTypes.as:316`): openType 1 -> `magicCard.MagicCardCheckFrame`, otherwise `magicCard.MagicCardFrame` (`decompiled/core_module/scripts/mvc/controler/MagicCardControler.as:37-45`).
- Manager setup at boot registers 4902, 4903, 4905 (`decompiled/core_module/scripts/yishi/lunch/Yishi.as:414`, `decompiled/core_module/scripts/yishi/manager/MagicCardManager.as:52-57`).

## Modules

| Module | File | Content |
|---|---|---|
| Card collection | [collection.md](collection.md) | Frame and board, 9505 `C_POWCARD_REQ` op 1 upgrade, op 2 activate (single and all), op 3 absorb all; bag item use; 4905 `U_C_POWCARD_ALL`; Pó Mágico token 4725; templates; tables `player_cards`, `card_operations` |
| Battle effects | [battle-effects.md](battle-effects.md) | Series to mode mapping, card skills and buffs per position and grade, battle injection, 4903 `U_C_POWCARD_BUF_ON` (top bar "Adição de Cartas"), 4902 `U_C_POWCARD_Fight_ADD`, unused 4904 |
| Inspection and sharing | [viewing-sharing.md](viewing-sharing.md) | "Informações da Carta" frame, chat sharing (`ChatChannelMsg.powcards`, link markup t=101), other players' cards in `DetailRspMsg.cardInfos`, Laboratório de Platina rival detail and ranking XML |

Protocol summary:

| Direction | Opcode | Name | Message | Module |
|---|---|---|---|---|
| send | 9505 (0x2521) | `C_POWCARD_REQ` | `powcard.PowCardReqMsg` (`op` 1/2/3, `cardId`) | collection |
| accept | 4905 (0x1329) | `U_C_POWCARD_ALL` | `magiccard.MagicCardInfoListMsg` | collection |
| accept | 4725 (0x1275) | `U_C_PLAYER_TOKENINFO` (currency, masterType 13) | `player.PlayerTokenInfoMsg` | collection |
| accept | 4903 (0x1327) | `U_C_POWCARD_BUF_ON` | `powcard.PowCardBufListMsg` | battle-effects |
| accept | 4902 (0x1326) | `U_C_POWCARD_Fight_ADD` | `powcard.PowcardFightAddMsg` | battle-effects |
| accept | 4904 (0x1328) | `U_C_POWCARD_BUF` | none (no listener) | battle-effects |
| send | 5006 (0x138e) | `U_C_BAG_USEITEM` (inventory) | `item.ItemUseMsg` | collection |
| send | 15005 / 5011 / 8198 | chat channel / bugles (chat) | `chat.ChatChannelMsg.powcards` (#19) | viewing-sharing |
| accept | 83 (0x0053) | `U_CH_CHANNEL_CHA` (chat) | `chat.ChatChannelMsg` with t=101 link | viewing-sharing |
| accept | 4125 (0x101d) | `U_C_BAG_EQUIPLOOK` (hero) | `simple.DetailRspMsg.cardInfos` (#9) | viewing-sharing |

## Dependencies

- [hero](../hero/README.md): hero level gate (32), equipment panel entry button, player detail 8199/4125 carrying `cardInfos`.
- [inventory](../inventory/README.md): card items (`SonType` 600) in bag types 1 and 6, item consumption, bag updates 115, item use 5006 delegation.
- [currency](../currency/README.md): Pó Mágico token (`masterType` 13), push 4725.
- [battle](../battle/README.md): passive skill application for card skills (see [docs/battle/server-engine.md](../../docs/battle/server-engine.md), [docs/mechanics/skills_buffs.md](../../docs/mechanics/skills_buffs.md)).
- [skills](../skills/README.md): `SkillTempInfos` / `SkillBufferTempInfos` passive pipeline shared with other passive sources.
- Modes that apply card skills: [campaign](../campaign/README.md) (series 1), [mazes](../mazes/README.md) (series 2), [arena](../arena/README.md) (series 3), [world-boss](../world-boss/README.md) battlefield (series 4, assumption), [trials](../trials/README.md) (series 5).
- [chat](../chat/README.md): card link sending and relay.
- [rankings](../rankings/README.md): ranking XML `MagicCards` and `PowCardFightInfo`.
- [laboratory](../laboratory/README.md): rival `DetailRspMsg.cardInfos`.
- [treasures](../treasures/README.md) (Caça ao Tesouro) and [fantasy-bar](../fantasy-bar/README.md) (Bar da Fantasia): sources of card items and navigation targets from the board.
- [army](../army/README.md): owner of the equipment panel view (`armyII`) hosting the entry button.

## Suggested implementation order

1. Templates: load `MagicCardTempInfos.xml`, card items (`ItemTempInfos` SonType 600), card skills and buffs.
2. Tables `magic_cards.player_cards` and `magic_cards.card_operations`.
3. 4905 full sync on login and the 9505 dispatcher with op 2 (activate) and op 1 (upgrade), including inventory consumption and the dust token push 4725.
4. op 3 absorb all, op 2 activate all, and the inventory item use hook (5006 SonType 600).
5. Battle effects: series to mode mapping, `skills_for_mode`, engine passive application, then 4903 on mode enter/leave and 4902 after changes.
6. Viewing and sharing: chat link validation and t=101 markup, `cardInfos` in 4125, laboratory rival detail and ranking export.
