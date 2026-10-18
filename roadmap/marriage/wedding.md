# Wedding

Feature `marriage`, module `wedding`. Wedding quality purchase, wedding hall rooms, guests and invitations, the ceremony in the wedding campaign map, gifts and decorations, the oath, and the wedding carriage.

Conventions and the shared `MarriageOpMsg` / `MarriageProMsg` / `EngageMsg` layouts as in [proposal-and-engagement.md](proposal-and-engagement.md). Two request opcodes are used: C>S 8759 0x2237 `C_marriage_REQUEST` (ops 4 to 13) and C>S 8760 0x2238 `C_MARRIAGE_CAMPAIGN_REQUEST` (ops 101 to 112 inside the wedding map); the purchase goes through C>S 15049 0x3ac9 `CH_MARRIAGE_BUY_SPEC`.

## 1. Overview

An engaged couple forms a 2 member team; the captain talks to the marriage NPC ("wedding" option 17 or the top tool bar "wedding" activity) and picks a quality (`MarrySpecTempInfos.xml`). The buyer pays alone (pay type 1) or proposes to split (pay type 2); for a split the partner gets 4658 and must accept (op 5). After payment the couple is married (state 3 in 4657) and a wedding hall room exists (4662 entry with `property6 = 1`). Guests find rooms in the hall list (NPC option 19, op 10), enter with the room key `userIdA_userIdB` and optional password (op 13), and receive wedding room links in chat. In the wedding map the room owners and guests use the NPC dialog: start the ceremony (101), decorations (102 cake, 108 champagne, 103 bouquet, 107 sweets), fireworks (109), gold gifts (104) and diamond gifts (112). The server drives the ceremony with 4674 (wedding state), 4660 (oath) and 4676 (auto walk); guests are tracked with 4673. The "Amor de mil anos" quality also grants a carriage ride (op 7, 4672) on a fixed path.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `marry.quality.MarryQualityFrame` `decompiled/m9/scripts/marry/quality/MarryQualityFrame.as` | "Casamento"; qualities "Amor de mil anos", "Casamento Nobre", "Casamento Normal"; confirm "Deseja consumir {0} diamantes para efetuar cerimônia de {1}?" (+ `chooseQualityContent2` for returning players) | Choose and buy (`__commitHandler` `:97`) | `QUALITY_SELECT` from NPC option 17 (`decompiled/m3/scripts/map/space/view/frame/DialogOptionItem.as:428`), `TopToolsBar` "wedding" (`decompiled/core_module/scripts/ui/toptoolbar/TopToolsBar.as:1339`), proposal accepted (`MarryModel.as:275`) | `MarryQualityData` per template, discounted price (`MarryModel.getMarryQualityCosts` `decompiled/core_module/scripts/mvc/module/marry/MarryModel.as:565`), views `MarryKiloView`, `MarryNobleView`, `MarryCommonView`, `MarryQualityDiscountView`, `MarryRewardList`, `MarryCarriageView` |
| `marry.quality.MarryConfirmFrame` `decompiled/m9/scripts/marry/quality/MarryConfirmFrame.as` | "Parabéns!"; "(Dividir)", "(Pagar Individualmente)"; "O Pagamento do casamento atual será dividio entre ambas as partes, deseja continuar?"; privileges "Após o casamento poderá ganhar os seguintes previlégios" | Partner confirmation of a quality (`QUALITY_CONFIRM` opType 5) or a buy (opType 4) | push 4658 (`MarryManager.__weddingQualityHandler` `decompiled/core_module/scripts/managers/MarryManager.as:566`) | quality, pay type, rewards, ring preview |
| `marry.room.MarryRoomListFrame` + `MarryRoomItem` + `MarryRoomLefttView` `decompiled/m9/scripts/marry/room/` | "Salão de cerimônia"; "Encerramento do Salão" | Wedding hall list (requests op 10 on open `MarryRoomListFrame.as:45`), own room shortcut (`:191`), enter (`MarryRoomItem.__clickHandler`, password frame when locked) | `ROOM_LIST` from NPC option 19 (`DialogOptionItem.as:466`) | rooms: names A and B, "No {n}", type image (`property2`), lock (`property1`) |
| `marry.room.WeddingRoomSetFrame` `decompiled/m9/scripts/marry/room/WeddingRoomSetFrame.as` | "Lista de Convidados"; header `marry.room.WeddingRoomSetFrame.infoTitle` | Guest list and password (`:168`) | wedding map UI button (`MarryUIMediator.__roomSetHandler` `decompiled/m3/scripts/map/campaign/mediator/marry/MarryUIMediator.as:411`) | `MarryModel.guestDic` |
| `marry.room.MarryGuestTips` `decompiled/m9/scripts/marry/room/MarryGuestTips.as` | "Expulsar da Sal" | Kick a guest (`:60`) | guest row | |
| `marry.room.WeddingInviteframe` `decompiled/m9/scripts/marry/room/WeddingInviteframe.as` | tabs "Guilda", "Amigos"; "Auto-Convidar"; invite button "Rápido"; "Lista atual vazia" | Invite one (item 208003 "Corneta" required, quick buy) or all (`:191`) | wedding map UI (`MarryUIMediator.__inviteBtnHandler` `:424`) | friends, guild members |
| `MarryWeddingDialogFrame` `decompiled/m3/scripts/map/campaign/view/frame/MarryWeddingDialogFrame.as` | options "Iniciar o casamento", "Convocar o bolo", "Servir o champânhe", "Pegar o Buquê", "Servir os Doces", "Comprar Fogos de Artifício", "Oferecer {0} presente de Ouro", "Oferecer diamantes"; confirms "Deseja oferecer {0} ouro como presente?", "Deseja consumir {0} ouro para compra 1 fogo de artifício?"; errors "Parceiro offline", "Parceiro não está na Igreja" | Ceremony NPC dialog (option list built at `:330` to `:395`) | NPC click in the wedding map | `MarryModel.weddingInfo`, room players |
| `dialog.view.SplitePointFrame` `decompiled/core_module/scripts/dialog/view/SplitePointFrame.as` | | Diamond gift amount | option 112 | |
| `MarryUIMediator` | | Wedding map buttons, oath animation (`__oathHandler` `:302`), auto move (`:270`), guide | wedding map | |

## 3. Routes (client to server)

| # | UI control | Client sender | Client checks | Route | Request | Response |
|---|---|---|---|---|---|---|
| W1 | Buy quality | `MarryQualityFrame.confirmCallback` then `MarrySender.buyQuality(quality, partnerId, 1)` `decompiled/core_module/scripts/mvc/module/marry/MarrySender.as:160` | diamonds (`point`) >= discounted cost, else recharge alert; in a free team ("Por favor forme a equipe com o seu parceiro"); captain ("Você não é o líder"); `canBuyQuality`: not single, `speTemplateId == 0`, no wedding room | C>S 15049 0x3ac9 `CH_MARRIAGE_BUY_SPEC` | `op_type` = 4, `property1` = quality template id (1 "Amor de mil anos", 2 "Casamento Nobre", 3 "Casamento Normal"), `property2` = partner user id, `pay_type` = 1 pay alone / 2 split | pay alone: 4657 (state 3, `speTemplate_id`) to both, 4662 room entry, announcement on channel 12; split: 4658 to the partner |
| W2 | Partner confirms split / pay | `MarryConfirmFrame` confirm (opType 5) then `MarrySender.qualityAnswer(true)` `MarrySender.as:171`; refuse `qualityAnswer(false)` | split shows "O Pagamento do casamento atual será dividio..." first; diamonds check for opType 4 buys (`Points / payType`) | C>S 8759 | `op_type` = 5, `property5` = accept | as W1 pay alone (both debited half) or a refusal notice to the buyer |
| W3 | Create wedding room | `MarrySender.creatWeddingRoom` `MarrySender.as:180` | no caller in this client | C>S 8759 | `op_type` = 6 | Assumption: the room is created by the server on W1/W2 |
| W4 | Hall list | `MarryRoomListFrame` constructor then `MarrySender.resquestRoomInfo` `MarrySender.as:216` | | C>S 8759 | `op_type` = 10 | 4662 |
| W5 | Enter a wedding room (list, own room, chat link, invitation) | `MarryRoomItem` `:164`, `:173`, `MarryRoomListFrame` `:191`, `ChatOutputViewII` (room tag `roomType = 4`), `InviteFrame` `decompiled/core_module/scripts/yishi/view/frame/InviteFrame.as` then `MarrySender.enterWeddingRoom` `MarrySender.as:253` | `canEnterWedding`: level > 30 (`MarryModel.as:487`); password frame for locked rooms of others | C>S 8759 | `op_type` = 13, `property3` = room key `userIdA_userIdB`, `property4` = password, `property5` = true when coming from a chat link | enter the wedding campaign (campaign feature scene change), 4674, 4673 |
| W6 | Set password | `WeddingRoomSetFrame` `:168` then `MarrySender.changeRoomPassWord` `MarrySender.as:95` | room owner | C>S 8760 0x2238 | `op_type` = 105, `property3` = password ("" removes) | 4662 update (`property1`) |
| W7 | Kick guest | `MarryGuestTips` `:60` then `MarrySender.kickOutGuest` `MarrySender.as:104` | owner | C>S 8760 | `op_type` = 106, `property1` = guest id | 4673 removal; the guest leaves the map |
| W8 | Invite one | room invite items (`decompiled/m9/scripts/room/view/invite/InviteItem.as` when in a wedding room) then `MarrySender.invite` `MarrySender.as:113` | item 208003 owned ("Não há acessório correspondente, essa função não pode ser utilizada", quick buy) | C>S 8760 | `op_type` = 110, `property1` = target id | invitation to the target (room invitation popup with the wedding room key), item consumed (Assumption) |
| W9 | "Auto-Convidar" | `WeddingInviteframe` `:191` then `MarrySender.oneKeyInvite` `MarrySender.as:122` | list not empty ("Lista atual vazia"), item 208003 | C>S 8760 | `op_type` = 111, `userIds` = targets | as W8 for each |
| W10 | Ceremony options | `MarryWeddingDialogFrame` then `MarrySender.weddingDialogConfirm(type)` `MarrySender.as:69` | 101: room master and `speTemplateId != 0`, both partners in the room and online; 102: `canAddCake`; 108: `canAddBubbly`; 103: `canFetchFlower`; 107: `canAddSweet`; 109: confirm with `marriage_fireworks` gold (default 2000 in client, config 100000) | C>S 8760 | `op_type` = 101, 102, 103, 107, 108 or 109 | 4674 (wedding state) to everyone in the room; 101 starts the ceremony sequence (4676 auto move, 4660 oath) |
| W11 | Gold gift | `MarryWeddingDialogFrame.confirmCallback` then `MarrySender.handGift` `MarrySender.as:77` | guests only (`canHandGift`: not master, phase 3, `property4 == "0"`); gold >= amount; amounts from `marriage_gift = 200000,500000,1000000` | C>S 8760 | `op_type` = 104, `property1` = gold amount | 4674 (`property4` set), gold credit to the couple (Assumption: split between both) |
| W12 | Diamond gift | `SplitePointFrame` then `MarryWeddingDialogFrame.handPoint` then `MarrySender.handPoint` `MarrySender.as:86` | `VersionSwitch.MarryPoint`; guests only; `isCandandPoint` (`MarryModel.as:472`): quality 3 allows 1 gift, quality 2 allows 2, quality 1 allows 3 (`property9` quality, `property10` gifts done); `marriage_point = 3,2,1` | C>S 8760 | `op_type` = 112, `property1` = diamond amount | 4674 |
| W13 | Ride the carriage (NPC option 23) | `DialogOptionItem.as:581` then `MarrySender.rideHorse` `MarrySender.as:188` | `canRideCar`: room quality template has a carriage `Path` (only "Amor de mil anos") | C>S 8759 | `op_type` = 7 | 4672 to all players on the map (Assumption) |

## 4. Server messages (server to client)

| Route | Message | Client receiver | When | Reaction |
|---|---|---|---|---|
| S>C 4658 0x1232 `U_C_SPECIFICATION_INFO` | `MarriageProMsg`: `property2` quality template id, `property3` pay type (1 alone, 2 split) | `MarryManager.__weddingQualityHandler` `MarryManager.as:566` | to the partner after W1 with split (and Assumption: also with pay alone, as a confirmation) | opens `QUALITY_CONFIRM` (not in battle or warlords room) |
| S>C 4662 0x1236 `U_C_MARRIAGE_CAMPAING_LIST` | `EngageMsg` of rooms: `userId_a`, `nickName_a`, `userId_b`, `nickName_b`, `property1` locked, `property2` room style (1 = "Amor de mil anos"), `property3` room number, `property4` start time `YYYY-MM-DD hh:mm:ss`, `property5` (stored), `property6` 1 exists / 0 removed, `property7` quality template id | `MarryManager.__roomListHandler` `:466`, `MarryModel.updateRoomDic` `MarryModel.as:303` | response to op 10, on room creation, lock change and end | updates `roomDic`; sets or clears own `roomInfo` (owner) |
| S>C 4674 0x1242 `U_C_MARRIAGE_CAMPAING` | `MarriageProMsg` wedding state: `userId_a`, `nickName_a`, `userId_b`, `nickName_b`, `property1` sweets served, `property2` phase (3 = ceremony running, enables options), `property3` champagne state (0 = not yet), `property4` gift state of the reader ("0" = can give), `property6` cake (0 = not yet), `property7` bouquet taken by A (0 = not yet), `property8` bouquet taken by B, `property9` quality (1, 2, 3), `property10` diamond gifts done by the reader | `MarryManager.__weddingInfoHandler` `:420` | on room entry and every state change (per player, since some fields are per reader) | `WEDDING_STATE` refresh |
| S>C 4673 0x1241 `U_C_MARRIAGE_CAMPAING_INFO` | `EngageMsg` of guests: `userId_a` guest id, `nickName_a`, `job_a`, `property1` present (false removes), `property2` (stored) | `MarryManager.__guestInfoHandler` `:441` | to the owners on guest join/leave | `GUEST_INFO` refresh |
| S>C 4660 0x1234 `U_C_MARRIAGE_CAMPAING_OATH` | `MarriageProMsg` (oath step data) | `CampaignMapController.__oathHandler` `decompiled/m3/scripts/map/campaign/CampaignMapController.as:662` then `MarryUIMediator.__oathHandler` `:302` | ceremony sequence | oath animation |
| S>C 4676 0x1244 `U_C_MARRIAGE_CAMPAIGN_MOVE` | `MarriageProMsg`: `property6` x, `property7` y in tiles (client multiplies by 20) | `CampaignMapController.__weddingAutoMove` `:650` | ceremony sequence | owners auto walk to the position |
| S>C 4672 0x1240 `U_C_MARRIAGE_RIDE` | `MarriageProMsg`: `userId_a`, `nickName_a`, `property6` job of A, `userId_b`, `nickName_b`, `property7` job of B, `property4` carriage data | `MarryManager.__rideHorseHandler` `:402`, `MarryModel.updateCarList` | carriage start and updates | `CAR_INFO` (carriage avatar `PathManager.getMarryCarPathByJob`) |
| S>C 4657 | see [proposal-and-engagement.md](proposal-and-engagement.md) | | after payment (state 3, `speTemplate_id`, `marriage_time`) | |
| S>C 83 channel 12 | `bigBugleType` 6, 7, 8, 9 or 12 | `ChatManager` bugle list | wedding announcements (Assumption: per quality) | |

## 5. Rules and formulas

- Prices (`raw/xml/tempinfos/MarrySpecTempInfos.xml`): `Points` 11999 / 3188 / 1199 diamonds; `Discount` 80 (%) during `DiscountTime` 72 h after `marriage_time` (`MarryModel.getMarryQualityCosts` `MarryModel.as:565`: `ceil(Points * Discount / 100 / k)` inside the window, `Points / k` after, `k = 2` for returning players first marriage). Split payment: each partner pays half (`Points / payType`).
- Rewards per quality (`Rewards`): "Amor de mil anos": 1122401, 1102401 (wedding fashion), 208034 x6888, 208036 x388, 208057 x888, 208058 x388; "Casamento Nobre": 1122401, 1102401, 208034 x6888, 208036 x388; "Casamento Normal": 208034 x1888, 208036 x188. `Gift` 2000000 / 1000000 / 500000 (Assumption: gold given to the couple). `CampaignId` 4303 / 4302 / 4301 is the wedding map campaign. `Path` is the carriage route (only quality 1).
- Wedding duration `mar_time = 120` minutes; ring exchange notice `mar_notice_time = 20` minutes before (`ConfigInfos.xml`).
- Guests: level > 30 to enter.
- Gold gift amounts `marriage_gift = 200000,500000,1000000`; fireworks `marriage_fireworks = 100000` gold; diamond gift counts `marriage_point = 3,2,1` by quality.
- Room key `userIdA_userIdB`; room number shown as "No {n}".

## 6. Templates

| File | Record | Fields |
|---|---|---|
| `raw/xml/tempinfos/MarrySpecTempInfos.xml` | `MarrySpecTempInfo` | `TemplateId`, `TemplateName`, `Points`, `CampaignId`, `Gift`, `DiscountTime`, `Discount`, `Rewards` (`templateId,count|...`), `Path` (`x,y|...`) |
| `raw/xml/tempinfos/ConfigInfos.xml` | `ConfigInfo` | `mar_time`, `mar_notice_time`, `marriage_gift`, `marriage_fireworks`, `marriage_point` |
| `raw/xml/tempinfos/ItemTempInfos.xml` | items | 208003 "Corneta" (invitations), 208034 "Coração de Rosas", 208036 "Coração Eterno", 208057 "Selo de Juramento", 208058 "Cristal da Eternidade" |

## 7. Persistent state

```sql
CREATE TABLE marriage.quality_payment (
    marriage_id          integer     NOT NULL REFERENCES marriage.marriage(marriage_id) ON DELETE CASCADE,
    quality_template_id  integer     NOT NULL,
    buyer_id             integer     NOT NULL REFERENCES player.players(player_id),
    pay_type             smallint    NOT NULL CHECK (pay_type IN (1, 2)),
    price_points         integer     NOT NULL CHECK (price_points >= 0),
    state                text        NOT NULL CHECK (state IN ('pending', 'paid', 'refused')),
    created_at           timestamptz NOT NULL DEFAULT now(),
    PRIMARY KEY (marriage_id)
);

CREATE TABLE marriage.wedding_room (
    room_id          serial      PRIMARY KEY,                 -- room number "No {n}"
    marriage_id      integer     NOT NULL UNIQUE REFERENCES marriage.marriage(marriage_id) ON DELETE CASCADE,
    quality_template_id integer  NOT NULL,
    password         varchar(16) NOT NULL DEFAULT '',
    starts_at        timestamptz NOT NULL DEFAULT now(),
    ends_at          timestamptz NOT NULL,                    -- starts_at + mar_time
    phase            smallint    NOT NULL DEFAULT 0,          -- property2
    cake_done        boolean     NOT NULL DEFAULT false,
    champagne_done   boolean     NOT NULL DEFAULT false,
    sweets_done      boolean     NOT NULL DEFAULT false,
    bouquet_a_done   boolean     NOT NULL DEFAULT false,
    bouquet_b_done   boolean     NOT NULL DEFAULT false
);

CREATE TABLE marriage.wedding_gift (
    room_id       integer     NOT NULL REFERENCES marriage.wedding_room(room_id) ON DELETE CASCADE,
    giver_id      integer     NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
    kind          text        NOT NULL CHECK (kind IN ('gold', 'diamond')),
    amount        integer     NOT NULL CHECK (amount > 0),
    given_at      timestamptz NOT NULL DEFAULT now()
);
CREATE INDEX wedding_gift_room_idx ON marriage.wedding_gift (room_id, giver_id, kind);
```

Guests and carriage positions are runtime state of the wedding map instance.

## 8. Backend implementation notes

| Opcode / op | Handler |
|---|---|
| 15049 op 4 | `marriage::wedding::handle_buy_quality` |
| 8759 op 5 | `marriage::wedding::handle_quality_answer` |
| 8759 op 6 | `marriage::wedding::handle_create_room` |
| 8759 op 7 | `marriage::wedding::handle_ride` |
| 8759 op 10 | `marriage::wedding::handle_room_list` |
| 8759 op 13 | `marriage::wedding::handle_enter_room` |
| 8760 ops 101 to 112 | `marriage::wedding::handle_campaign_op` (start, cake, bouquet, gift, password, kick, sweets, champagne, fireworks, invite, invite all, diamond gift) |

- Buy: validate engaged couple, team of 2 with captain = buyer, quality exists, not bought yet, price with discount and returning player factor; pay alone: debit buyer in one transaction with marriage state 3, `married_at`, room creation, reward items to both (mail or bag), announcement; split: insert `quality_payment` pending, push 4658 to the partner, wait for op 5 (timeout Assumption 5 min), then debit both halves in one transaction.
- Room lifecycle: create on payment; the wedding map instance uses `CampaignId`; schedule the ceremony end at `ends_at` (push 4662 removal, close the instance); notice at `ends_at - mar_notice_time` (chat 12).
- Start (101): owners present and online, phase becomes 3, run the scripted sequence (4676 moves, 4660 oath) with timers; battle configuration none.
- Gifts: debit giver, credit the couple, record `wedding_gift`, update per giver flags, push 4674 to the giver (and owners).
- Invitations consume item 208003 per invite (Assumption) and use the room invitation channel of the room feature.

## 9. Open questions and assumptions

1. Op 6 has no caller; room creation is assumed automatic on payment.
2. Exact ceremony script (number and timing of 4676/4660 pushes) is not in the client.
3. Who receives `Gift` gold from the template and gold gifts (Assumption: both partners equally).
4. The client fallback fireworks price is 2000 while the config says 100000.

## 10. Implementation checklist

- [ ] Tables `marriage.quality_payment`, `marriage.wedding_room`, `marriage.wedding_gift`
- [ ] Buy quality alone and split (15049, 4658, op 5)
- [ ] State 3 and rewards after payment
- [ ] Hall list (op 10 / 4662), enter (op 13), password (105), kick (106), invite (110, 111)
- [ ] Ceremony options 101 to 109 and gifts 104, 112 with limits
- [ ] Ceremony sequence pushes 4674, 4673, 4660, 4676
- [ ] Carriage ride (op 7 / 4672)
- [ ] Room end timer and announcements
