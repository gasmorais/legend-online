# Card collection: activation, upgrade and absorption

Scope: the "Carta Mágica" frame, the per-player card collection (20 cards in 5 series), card activation with card items, card upgrade with Pó Mágico (magic dust), one-key absorption of card items into dust, and the full collection sync (4905). Battle effects of the cards are in [battle-effects.md](battle-effects.md); the inspection frame, chat sharing and other players' cards are in [viewing-sharing.md](viewing-sharing.md).

Path aliases:

| Alias | File |
|---|---|
| MCM | `decompiled/core_module/scripts/yishi/manager/MagicCardManager.as` |
| MODEL | `decompiled/core_module/scripts/mvc/module/card/MagicCardModel.as` |
| CTRL | `decompiled/core_module/scripts/mvc/controler/MagicCardControler.as` |
| CATE | `decompiled/core_module/scripts/yishi/datas/templates/cate/MagicCardTemplateCate.as` |
| ACT | `decompiled/core_module/scripts/mvc/module/card/enums/MagicCardActionEnums.as` |
| FRAME | `decompiled/m5/scripts/magicCard/MagicCardFrame.as` |
| SLOT | `decompiled/m5/scripts/magicCard/view/MagicCardSlotView.as` |
| SUIT | `decompiled/m5/scripts/magicCard/view/MagicCardSuitView.as` |
| ITEM | `decompiled/m5/scripts/magicCard/view/base/MagicCardSlotItem.as` |
| ORG | `decompiled/m5/scripts/magicCard/view/base/MagicCardSlotOrgItem.as` |
| SUITITEM | `decompiled/m5/scripts/magicCard/view/base/MagicCardSuitItem.as` |
| CELL | `decompiled/m5/scripts/magicCard/view/MagicCardCell.as` |
| LVTIP | `decompiled/m16/scripts/yishi/view/tips/MagicCardLvUpTips.as` |
| EQV | `decompiled/m5/scripts/armyII/viewII/equip/EquipView.as` |
| PCM | `decompiled/core_module/scripts/managers/PlayerCurrencyManager.as` |
| GM | `decompiled/core_module/scripts/yishi/manager/GoodsManager.as` |

## 1. Overview

- The player owns at most one instance of each card template (`TemplateId` 10001..10026). A card is either not activated (absent from the server list) or activated with a grade 1..9 (`MagicCardInfoMsg.grades`).
- Cards are grouped in 5 series (`Types` 1..5) of 4 positions (`Pos` 1..4). The frame shows one series at a time: 4 corner slots plus a center slot (position 5) that has no template in the BR data and always shows "Fechado".
- Activation consumes one card item (`ActiveNeedTempId`, items 6000001..6000026, `SonType` 600) from the bag. Upgrade consumes Pó Mágico (currency token `masterType` 13), the cost is `NeedMagicDust` of the next grade row. Duplicate card items are absorbed (decomposed) into Pó Mágico.
- Every state change is answered by a full collection push 4905 `U_C_POWCARD_ALL` (MCM `:98-128`); the client rebuilds the whole model from it.
- Unlock: hero level 32 (`OpenGradesII.MAGIC_CARD = 32`, `decompiled/core_module/scripts/yishi/OpenGradesII.as:154`; button disabled below 32, EQV `:1139-1150`). Feature flag `VersionSwitch.MAGIC_CARD = true` (`decompiled/core_module/scripts/yishi/datas/VersionSwitch.as:52`, EQV `:435-438`). Card items also require level 32 (`ItemTempInfos.NeedGrades = 32`).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| FRAME `magicCard.MagicCardFrame` (790x620, FRAME `:28-31`) | "Carta Mágica" (`card.CardFrame.title`, FRAME `:40`) | Container of the series tabs and the slot board | Hero equipment panel button `army.MagicCardBtn` (EQV `:301`, `:656-660`); auto-open when a 4905 push carries a card with `isActive = true` and the frame is closed (EQV `:644-654`); building model name "magiccard" for building `MasterType` 16 "Bar da Fantasia" and 18 (`decompiled/core_module/scripts/mvc/controler/BuildingControler.as:41-46`); back navigation from Caça ao Tesouro and Bar da Fantasia (`setPreFrame("magiccard")`, `decompiled/core_module/scripts/mvc/controler/TreasureHuntControler.as:46`, `decompiled/core_module/scripts/mvc/controler/MagicPubControler.as:31`). Controller key `"magiccard"` (`decompiled/core_module/scripts/yishi/datas/UIModuleTypes.as:316`, `decompiled/core_module/scripts/yishi/manager/FrameControllerManager.as:1581-1582`); any `openType` other than 1 selects this frame (CTRL `:37-45`) | Groups `CASTLE_BUIDING_GROUP`, `MAIN_TOOLS_GROUP` (FRAME `:33-36`) |
| SUIT `MagicCardSuitView` | none | Vertical list of series tabs (at least `MAX_COUNT = 7` items; items beyond `typeCount` are disabled placeholders, `type = -1`) (SUIT `:60-90`) | inside FRAME | Tab icon `icon/powcard/tab/{type}.png`, placeholder `icon/powcard/tab/default.jpg` (SUITITEM `:64-77`); icon black-filtered when the series has no activated card (SUIT `:159-172`) |
| SLOT `MagicCardSlotView` | none | Board of the selected series: 4 `MagicCardSlotItem` at x = `i%2*393+32`, y = `int(i/2)*200+37` and one `MagicCardSlotOrgItem` center at (204,160) (SLOT `:133-153`) | inside FRAME | Series name image `icon/powcard/tabname/{type}.png` (SLOT `:210`); series description `magicCard.view.cardDscTxt{type}` (SLOT `:212`); Pó Mágico amount `currencyInfo.magicDust.amount` (SLOT `:251`) with tip "Recursos consumidos para aumento do cartão, obtidos através da decomposição do cartão\nCartões ativados na mochila serão decompostos imediatamente ao serem usados outra vez" (SLOT `:101`); Bar da Fantasia button `magicCardSlotView.magicpubBtn` (SLOT `:89`, `:179-183`); absorb button `MagicCardSlotView.explainBtn` (SLOT `:92`, `:113-119`) |
| ITEM `MagicCardSlotItem` | tips "Ver" (`card.CardFrame.check`), "Compartilhar" (`card.CardFrame.share`) (ITEM `:98-99`) | One card slot | SLOT | Card cell (template of grade 1 for the slot, CELL `:268-332`), current grade "Nv.{0}" (`public.level2`, CELL `:366-367`), skill names of the current grade (CELL `:368-386`); on hover (only if activated): level up, check, share buttons (ITEM `:146-156`); when not activated: black filter, and if a card item is owned the "can activate" glow plus the activate button `magicCard.cardSlotItem.ActiveBtn` (ITEM `:244-275`) |
| ORG `MagicCardSlotOrgItem` | level up tip "Elevar" (`card.CardFrame.levelup`, ORG `:40`) | Center slot (position 5) | SLOT | No template exists for `Pos` 5, so the cell is hidden and the tip is "Fechado" (`armyII.viewII.rune.FastRuneItem.OpenTipTxt1`, ORG `:58-70`) |
| CELL `MagicCardCell` | none | Card face | ITEM | Icon `icon/powcard{Icon}.png` (`decompiled/core_module/scripts/yishi/manager/PathManager.as:560-563`), frame by `Profile` 1..5, `TemplateName`, skill names joined by "," (`SkillTempIds` resolved in `SkillTempInfos`) |
| LVTIP `MagicCardLvUpTips` | "Pó mágico necessário para aumentar nível:{0}" | Tooltip of the level up button (`_levelupBtn.tipData = MagicCardInfo`, ITEM `:224`) | ITEM hover | Current grade skills; if `grades < maxGP` the next grade skills ("buildings.BaseBuildFrame.next") and `NeedMagicDust` of grade+1, drawn in the "insufficient" frame when `NeedMagicDust > magicDust.amount` (LVTIP `:96-126`) |
| `magicCard.HelpFrame` (`SimpleHelpFrame`) | "Ajuda" (`card.CardHelpFrame.title`) | Help text `card.CardHelpFrame.helpContent` | `CTRL.openCardHelpFrame` (CTRL `:52-56`); no caller found | Static text |

Hero equipment panel button tooltip (EQV `:1139-1163`): below level 32 "Cartas Mágica:" plus "Esta habilidade será liberado no nv. 32"; from level 32 "Taxa de coleção   {activedPer}%" and "Nível de qualidade {averageGrades}" (MODEL `:66-122`). The button glows when Caça ao Tesouro has free seeks, when `hasCanExplainCard` or when `hasCanActiveCard` (EQV `:623-642`).

## 3. Routes (client to server)

All actions use one request.

- Route: send 9505 (0x2521) `C_POWCARD_REQ` (`decompiled/core_module/scripts/yishi/datas/consant/ProtocolType.as:862`).
- Sender: `MagicCardManager.updateMagicCard(op, cardId = 0)` (MCM `:135-142`), `SocketSendManager.sendProtoBuffer`.
- Protobuf `powcard.PowCardReqMsg`:
  - `op` (#1, INT32): action, values in ACT `:6-10` and the table below.
  - `cardId` (#2, INT32): card `TemplateId` (10001..10026), or 0.

`op` values:

| op | Enum (ACT) | Meaning | cardId | Client sender |
|---:|---|---|---|---|
| 1 | `CARD_LEVELUP` | Upgrade one activated card by one grade | card `TemplateId` | ITEM `.__levelupMouseDownHandler` `:117-120` |
| 2 | `CARD_ACTIVATE` | Activate one card by consuming its card item | card `TemplateId` | ITEM `.onActiveClick` `:181-184` |
| 2 | `CARD_ACTIVATE` | Activate every card whose item is in the bag ("Certeza em ativar todas as cartas na mochila disponíveis?") | 0 | SLOT `.__todayNotAlertTidyTwo` `:196-205`; dead code, never wired to a button in the BR client |
| 3 | `CARD_ONEKEYLEVELUP` | Absorb all eligible card items in the bag into Pó Mágico ("Certeza em absorver todas as cartas na mochila disponíveis para elevar?") | 0 | SLOT `.onExplainClick` `:264-267` (live, no confirmation); SLOT `.__todayNotAlertTidy` `:185-194` (dead code with confirmation) |

### A1. Upgrade a card (op 1)
- UI: level up button `magicCard.cardSlotItem.levelupBtn` on an activated slot, visible on hover only (ITEM `:76`, `:146-156`). The request fires on `mouseDown` (ITEM `:106`, `:117-120`); `mouseUp`/`rollOut` only clear an unused timeout (ITEM `:122-130`), so one click = one request.
- Client checks: none. The tooltip shows the cost and marks it red when insufficient (LVTIP `:118-123`); no max grade or dust check before sending.
- Request: `op = 1`, `cardId = _cardTempInfo.TemplateId` (the slot template, grade 1 row, same `TemplateId` for all grades).
- Expected server sequence: 4725 `U_C_PLAYER_TOKENINFO` (dust decreased), then 4905 `U_C_POWCARD_ALL` with the new grade (and `isActive = true` on the upgraded card to replay the board effect), then 4902/4903 if the battle bonuses changed (see [battle-effects.md](battle-effects.md)). Errors: generic tip 126 (0x007e) `U_C_MSG` (assumption, no specific error opcode exists).

### A2. Activate a card (op 2, cardId > 0)
- UI: "activate" button `magicCard.cardSlotItem.ActiveBtn` created only when the slot is not activated and `GM.getGoodsNumByTempId(ActiveNeedTempId) + GM.getConsoritaBagGoodsNumByTempId(ActiveNeedTempId) > 0` (ITEM `:230-239`, `:256-273`). `getConsoritaBagGoodsNumByTempId` counts items with `bagType == 6` (GM `:592-616`).
- Client checks: only the item count above. The center slot hides the button because no template exists (ORG `:58-70`).
- Request: `op = 2`, `cardId = TemplateId`.
- Expected server sequence: 115 (0x0073) `U_C_BAG_MOVE_UPDATE` for the consumed item (inventory feature), 4905 with the new card at grade 1 and `isActive = true` (triggers `_activeMc` animation ITEM `:214-226`, the board effect ITEM `:277-295`, the series tab selection SUIT `:146-158` and the auto-open in EQV `:644-654`), then battle bonus pushes if applicable.

### A3. Activate all (op 2, cardId = 0)
- Not reachable from the BR UI (dead handler SLOT `:196-205`, which also stores "do not ask today" in `SharedManager.quickActiveMouseWorkDate`). Implement on the server for protocol completeness: activate every non-activated card whose item is owned, consuming one item each.
- Expected server sequence: as A2, one 4905 at the end.

### A4. Absorb card items (op 3)
- UI: absorb button `MagicCardSlotView.explainBtn` (glowing), visible only while `MODEL.hasCanExplainCard` is true (SLOT `:113-119`, `:233-250`, refreshed on `CURRENCYREFRESH`).
- `hasCanExplainCard` (MODEL `:144-190`) is true when either:
  1. any activated card has at least 1 of its card item in bag 1 or bag 6; or
  2. any card template has at least 2 of its card item in bag 1 or bag 6.
  It also sets `hasCanActiveCard` when a non-activated card has at least 1 item.
- Client checks: none, no confirmation on the live path.
- Request: `op = 3`, `cardId = 0`.
- Expected server behavior (derived from the eligibility rule and the dust tooltip): for each card item stack in the bag, if the card is activated absorb all copies; if it is not activated, keep 1 copy (so it can still be activated) and absorb the rest. Each absorbed copy adds its dust value (see section 5).
- Expected server sequence: 115 bag updates, 4725 with the new dust amount, 4905 (unchanged collection, keeps the client in sync and re-evaluates the glow).

### A5. Use a card item from the bag (inventory route)
- UI: bag "Usar" on an item with `SonType` 600; allowed by `BagHelper.checkCanUseGoods` (`decompiled/core_module/scripts/bag/helper/BagHelper.as:76-100`) under `MasterType == 2` (`decompiled/core_module/scripts/cell/mediator/playerbag/PlayerBagCellClickMediator.as:117-120`).
- Route: send 5006 (0x138e) `U_C_BAG_USEITEM`, `item.ItemUseMsg`: `pos` (#1, INT32) bag position, `count` (#2, INT32), `bag_type` (#3, INT32), `battle_id` (#4, STRING), `friend_id` (#5, INT32) (`decompiled/core_module/scripts/yishi/service/managers/SocketSendManager.as:157-167`). Owned by [inventory](../inventory/README.md); the inventory use handler must delegate SonType 600 to this module.
- Rule (pt-BR tip SLOT `:101` and item descriptions "Ao usar, obterá Carta ..."): using the item activates the card (`Property1` = card `TemplateId`) when it is not activated; when it is already activated the item is decomposed into Pó Mágico immediately.
- Expected server sequence: 115, then 4905 (activation) or 4725 (decomposition).

## 4. Server messages (server to client)

### S1. 4905 (0x1329) `U_C_POWCARD_ALL`
- Message `magiccard.MagicCardInfoListMsg`: `cardInfos` (#1, MESSAGE `MagicCardInfoMsg`, repeated).
- `magiccard.MagicCardInfoMsg`:
  - `templateId` (#1, INT32): card `TemplateId`.
  - `grades` (#2, INT32): current grade 1..9.
  - `gp` (#3, INT32): legacy experience; stored by the client, never displayed (send 0 or the accumulated value).
  - `pos` (#4, INT32): ignored, the client recomputes `pos` from the template `Pos` (MCM `:116`).
  - `skillTempIds` (#5, STRING): CSV of skill ids of the current grade (template `SkillTempIds`).
  - `types` (#6, INT32): series 1..5.
  - `templateName` (#7, STRING): card name, shown in LVTIP `:77`.
  - `isActive` (#8, BOOL, optional): true only for the card(s) changed by the request that caused this push; drives the one-shot animations and auto-open (MCM `:120-123`, ITEM `:277-295`, ORG `:94-112`, MODEL `:332-349`, EQV `:644-654`).
- Receiver: `MagicCardManager.__cardAllHandler` (MCM `:55`, `:98-128`), registered at boot (`decompiled/core_module/scripts/yishi/lunch/Yishi.as:414`). It replaces `allActivatedCard`, rebuilds `activatedPosByType` and dispatches `MAGICCARD_UPDATE`, which refreshes SLOT (`:174-177`), SUIT (`:119-122`) and EQV.
- When: on login (full list, all `isActive` false), after every 9505 request, after a card item use (A5), and whenever cards change from another source. Only activated cards are listed; an empty list means nothing activated.

### S2. 4725 (0x1275) `U_C_PLAYER_TOKENINFO`
- Message `player.PlayerTokenInfoMsg`: `tokenInfos` (#1, MESSAGE `TokenInfoMsg`, repeated); `TokenInfoMsg`: `masterType` (#1, INT32), `amount` (#2, INT32), `expiredDate` (#3, STRING).
- Pó Mágico is `masterType = 13` (PCM `:242-246`). Receiver `PlayerCurrencyManager.__currencyRefreshHandler` (PCM `:71-74`, `:135`), which dispatches `CURRENCYREFRESH` used by SLOT `:160`, `:233-252`. Owned by [currency](../currency/README.md). Note: 4725 is missing from `protocol/opcodes.csv` (defined in `decompiled/core_module/scripts/yishi/datas/consant/AcceptProtocolType.as:1066`).
- When: after A1, A4 and A5 (decompose), and on login.

### S3. 115 (0x0073) `U_C_BAG_MOVE_UPDATE`
- Owned by [inventory](../inventory/README.md). Sent after any card item is consumed (A2, A3, A4, A5). The client recomputes item counts through `GoodsManager`, which drives the activate buttons and the absorb glow.

### S4. 126 (0x007e) `U_C_MSG`
- Generic tip (`decompiled/core_module/scripts/yishi/manager/BaseManager.as:299`). Use it for every 9505 rejection (assumption: the original server answered errors this way). Suggested reasons: card not activated, already activated, max grade, insufficient Pó Mágico, no card item, level below 32, unknown template.

## 5. Rules and formulas

Template data: `raw/xml/tempinfos/MagicCardTempInfos.xml` (180 rows = 20 cards x 9 grades).

| Types | Series (cards) | Card `TemplateId` (Pos 1..4) | Profile | Items `ActiveNeedTempId` | Mode (`magicCard.view.cardDscTxt{type}`) |
|---:|---|---|---|---|---|
| 1 | Tau: Soldado Tau - Kyle, Paladino Tau - Meranus, Guerreiro Tau - Terius, Líder Tau - Kain | 10001..10004 | 1..4 | 6000001..6000004 | "O efeito deste conjunto de cartas apenas é ativado na batalha de campanha de multiplayer, não inclui campanha de eventos." |
| 2 | Imortal: Dior, Félix, Allen, Garo | 10011..10014 | 1..4 | 6000011..6000014 | "... apenas é ativado na batalha dentro do labirinto subterrâneo, labirinto do abismo e labirinto do purgatório." |
| 3 | Luz: Cowe, Lucia, Tello, Selan | 10015..10018 | 1..4 | 6000015..6000018 | "... apenas é ativado durante a batalha arena multiplayer." |
| 4 | Trevas: Tiga, Galina, Obama, Abbey Aires | 10019..10022 | 1..4 | 6000019..6000022 | "... apenas é ativado durante o campo de batalha, inclusive nas batalhas contra outros jogadores e NPC." |
| 5 | Arma Antiga: Espada Demoníaca, Lança Espiritual, Escudo Fantasma, Deus da Batalha | 10023..10026 | 1..4 | 6000023..6000026 | "... apenas é ativado durante o combate da torre de julgamento." |

- Card identity: `(TemplateId, Grades)` is unique; `(Types, Pos, Grades)` is unique (CATE `:93-119`). `Profile` equals `Pos` for all rows (quality 1 gray .. 4 purple; 5 orange exists only for item 6000005).
- Grades: 1..9 for every card; `maxGP` = 9 = max `Grades` (CATE `:54-78`). Upgrade allowed while `grade < 9`.
- Upgrade cost to reach grade g = `NeedMagicDust` of row (TemplateId, g) = `Pos x [0, 50, 100, 150, 200, 250, 300, 400, 500][g-1]`. Totals to grade 9: 1950 / 3900 / 5850 / 7800 dust for Pos 1 / 2 / 3 / 4. Grade 1 costs 0 (activation is paid with the item).
- Activation cost: 1 item `ActiveNeedTempId`. Card item `Property1` = card `TemplateId`. The client counts bag type 1 and bag type 6 (GM `:592-616`); the server must look in the same bags.
- Absorption value per card item: assumption, `ItemTempInfos.Property2` of the card item (10 / 20 / 30 / 40 for Profile 1..4, 50 for 6000005). No client code reads it; it is the only per-item numeric field that scales with quality.
- Item 6000005 "Totem Tribal" ("Ao usar, elevarpa atributos das Cartas dos Taus") references `Property1 = 10005`, which has no template row (the center slot, Pos 5, is closed). Treat it as non-activatable; absorb it like other card items (assumption).
- Collection stats (client only, MODEL): `activedCount` = number of activated cards; `activedPer = activedCount / cardCount * 100` with `cardCount` = sum of max `Pos` per type = 20 (MODEL `:112-116`, CATE `:80-91`); `averageGrades` = mean grade of activated cards (MODEL `:66-87`); `averageProfile` = mean profile (MODEL `:89-110`).
- Series tab activation look: a series is "activated" when at least one of its cards is activated (MODEL `:224-241`, SUIT `:159-172`).
- Legacy strings not used by the BR client logic: `card.CardSlotView.Notactive0..2`, `card.CardSlotView.gradeOpen`, `card.CardFrame.equip` "Equipar", `card.CardFrame.unload` "Retirar", `card.CardBagCell.expMax`, and the help text about absorbing similar cards. They describe an older equip/GP system; the BR system has no equip/unequip step (activated = active).

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `raw/xml/tempinfos/MagicCardTempInfos.xml` (`TempleteManager` cate `MagicCardTempInfos`, `decompiled/core_module/scripts/yishi/manager/TempleteManager.as:1192`, getter `:3018`) | One card at one grade | `TemplateId` card id (shared by all grades); `TemplateName`; `Grades` 1..9; `Types` series 1..5; `ActiveScene` (= `Types` in all rows, mode id, see [battle-effects.md](battle-effects.md)); `Profile` quality frame 1..4; `Pos` slot 1..4; `SkillTempIds` CSV of passive skill ids for this grade; `NeedMagicDust` dust to reach this grade; `Icon` (`/card_tauren01`, `/card_skeleton0N`, `/card_light0N`, `/card_dark0N`, `/card_old0N`); `Description1`, `Description2` (always "0"); `ActiveNeedTempId` card item id |
| `raw/xml/tempinfos/ItemTempInfos.xml` | Card items `SonType` 600, `MasterType` 2 (6000001..6000005, 6000011..6000026) | `Property1` card `TemplateId`; `Property2` absorption dust value (assumption); `NeedGrades` 32; `Profile`; `MaxCount` 9999 |
| `raw/xml/tempinfos/SkillTempInfos.xml` | Card skills 403TPGG (T = type, P = pos, GG = grade) | `TemplateName` shown on the card face; detail in [battle-effects.md](battle-effects.md) |
| `MagicCardSuiteTemplateInfo` (`decompiled/core_module/scripts/yishi/datas/templates/MagicCardSuiteTemplateInfo.as`) | Suit bonus template (`Template1..8`, `Property1..8`, `fixvalue`, `percent`, `camptype`) | Never loaded: `TempleteManager` has no cate instance for it and no XML exists. Do not implement. |

## 7. Persistent state

Schema `magic_cards`. Assumption: items live in `inventory.items(item_id BIGINT PK, player_id, template_id, bag_type, position, count, ...)` and Pó Mágico lives in the currency feature as token `masterType = 13` (for example `currency.player_tokens(player_id, master_type, amount, expired_at)`); this feature only references them.

```sql
CREATE SCHEMA IF NOT EXISTS magic_cards;

-- One row per activated card.
CREATE TABLE magic_cards.player_cards (
    player_id          BIGINT      NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
    card_template_id   INTEGER     NOT NULL,              -- MagicCardTempInfos.TemplateId
    card_type          SMALLINT    NOT NULL CHECK (card_type BETWEEN 1 AND 5),
    position           SMALLINT    NOT NULL CHECK (position BETWEEN 1 AND 5),
    grade              SMALLINT    NOT NULL DEFAULT 1 CHECK (grade BETWEEN 1 AND 9),
    gp                 INTEGER     NOT NULL DEFAULT 0 CHECK (gp >= 0),  -- legacy, sent as MagicCardInfoMsg.gp
    activated_at       TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at         TIMESTAMPTZ NOT NULL DEFAULT now(),
    PRIMARY KEY (player_id, card_template_id),
    UNIQUE (player_id, card_type, position)
);
CREATE INDEX player_cards_type_idx ON magic_cards.player_cards (player_id, card_type);

-- Audit of every card operation (activation, upgrade, absorption, item use).
CREATE TABLE magic_cards.card_operations (
    operation_id       BIGSERIAL   PRIMARY KEY,
    player_id          BIGINT      NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
    op                 SMALLINT    NOT NULL CHECK (op IN (1, 2, 3, 4)),  -- 1 upgrade, 2 activate, 3 absorb, 4 item use
    card_template_id   INTEGER,                           -- NULL for bulk ops
    grade_before       SMALLINT,
    grade_after        SMALLINT,
    dust_delta         INTEGER     NOT NULL DEFAULT 0,    -- negative = spent, positive = gained
    items_consumed     INTEGER     NOT NULL DEFAULT 0,
    created_at         TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX card_operations_player_idx ON magic_cards.card_operations (player_id, created_at DESC);
```

## 8. Backend implementation notes

Handlers (all from opcode 9505, dispatched on `op`):

| op | Handler |
|---:|---|
| 1 | `magic_cards::collection::handle_upgrade` |
| 2 (cardId > 0) | `magic_cards::collection::handle_activate` |
| 2 (cardId = 0) | `magic_cards::collection::handle_activate_all` |
| 3 | `magic_cards::collection::handle_absorb_all` |
| other | reject (126 tip), no state change |
| item use 5006 SonType 600 | `magic_cards::collection::handle_use_card_item` (called by `inventory::use::handle_use_item`) |

Validation order:
1. Player online and hero level >= 32.
2. `op` known. For op 1 and op 2 with cardId > 0: `cardId` is a `TemplateId` present in `MagicCardTempInfos` with a grade 1 row.
3. op 1: card row exists; `grade < 9`; dust >= `NeedMagicDust(cardId, grade + 1)`.
4. op 2: card row absent; item `ActiveNeedTempId(cardId, 1)` count >= 1 in bag types 1 or 6 (prefer bag 1 first).
5. op 3: at least one eligible stack (same rule as `hasCanExplainCard`), otherwise reply with tip and still push 4905.

Transactions: one DB transaction per request covering `player_cards`, the item rows in `inventory.items`, the dust token and the `card_operations` log. Lock the player's card rows and token row (`SELECT ... FOR UPDATE`) to serialize rapid clicks (the client sends one request per mouseDown with no throttle).

After commit, push in this order to the requesting player only: 115 (if items changed), 4725 (if dust changed), 4905 (always, with `isActive = true` on changed cards), then recompute and push the battle bonus messages 4902/4903 described in [battle-effects.md](battle-effects.md). Also invalidate any cached fighting capacity of the hero (see [hero](../hero/README.md)) if the server includes card bonuses in it.

Login: send 4905 (all `isActive = false`) and 4725 during the login data burst, after the template-dependent bag data.

No timers, resets or cross-player pushes.

## 9. Open questions and assumptions

- Assumption: errors are reported with the generic tip 126 `U_C_MSG`; the client has no per-op result handling.
- Assumption: absorption dust per item = `ItemTempInfos.Property2` (10/20/30/40/50).
- Assumption: op 3 keeps one copy of a not-activated card's item and absorbs the rest; activated cards' items are fully absorbed. Derived from `hasCanExplainCard` (MODEL `:144-190`), not from server code.
- Assumption: bag type 6 (client name "consoritaBag") is a valid source for activation and absorption because the client counts it (GM `:605-616`).
- Assumption: `isActive = true` is also set on upgrade so the board effect replays; the client handles it identically.
- Open: `MagicCardInfoMsg.gp` meaning in the BR server (legacy GP leveling). Send 0 unless a GP mechanic is added.
- Open: item 6000005 "Totem Tribal" (Property1 10005) has no card template; its intended effect ("elevar atributos das Cartas dos Taus") is unknown.
- Open: whether the original server limited op 1 by any cooldown. The client constant `MagicCardEnums.SPEED = 600` ms is used only by the inspection frame.

## 10. Implementation checklist

- [ ] Template loader for `MagicCardTempInfos.xml` indexed by `(TemplateId, Grades)` and `(Types, Pos, Grades)`.
- [ ] Card item lookup (`SonType` 600) and `Property1`/`Property2` mapping.
- [ ] Table `magic_cards.player_cards`.
- [ ] Table `magic_cards.card_operations`.
- [ ] 9505 dispatcher on `PowCardReqMsg.op` with unknown op rejection.
- [ ] op 1 `handle_upgrade`: grade < 9, dust check and debit, grade + 1.
- [ ] op 2 `handle_activate`: item check in bags 1 and 6, consume 1, insert grade 1.
- [ ] op 2 cardId 0 `handle_activate_all`.
- [ ] op 3 `handle_absorb_all`: eligibility, dust credit, item removal.
- [ ] Inventory hook `handle_use_card_item` for 5006 on SonType 600 (activate or decompose).
- [ ] Push 4905 `MagicCardInfoListMsg` with `skillTempIds`, `types`, `templateName`, `isActive`.
- [ ] Push 4725 dust token (`masterType` 13) after dust changes and on login.
- [ ] Push 115 bag updates after item consumption.
- [ ] Tip 126 on every rejection.
- [ ] Login burst includes 4905.
- [ ] Hero level 32 gate.
- [ ] Screen check: FRAME opens from the equipment panel button, shows 5 series tabs (7 rows with 2 disabled), 4 slots plus closed center slot.
- [ ] Screen check: activate button appears only with the card item; level up tooltip shows next grade cost.
- [ ] Screen check: absorb button visible and glowing only when `hasCanExplainCard`.
- [ ] Test: upgrade from 1 to 9 costs exactly 1950 dust for a Pos 1 card and 7800 for a Pos 4 card.
- [ ] Test: upgrade at grade 9 is rejected without state change.
- [ ] Test: activation without item is rejected; activation twice is rejected.
- [ ] Test: rapid double upgrade click never debits dust twice for one grade.
- [ ] Test: absorb with 3 items of a non-activated card leaves 1 item and credits 2 x Property2.
- [ ] Test: 4905 after activation auto-opens the frame and selects the card's series tab.
