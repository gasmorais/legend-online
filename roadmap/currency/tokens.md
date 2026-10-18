# Token wallet (4725 `U_C_PLAYER_TOKENINFO`) and the currency list

Path aliases:

| Alias | File |
|---|---|
| PCM | `decompiled/core_module/scripts/managers/PlayerCurrencyManager.as` |
| PCI | `decompiled/core_module/scripts/mvc/module/currency/PlayerCurrencyInfo.as` |
| CT | `decompiled/core_module/scripts/mvc/module/currency/CurrencyType.as` |
| CI | `decompiled/core_module/scripts/mvc/module/currency/CurrencyInfo.as` |
| IEV | `decompiled/m5/scripts/armyII/viewII/information/ItemExchangeView.as` |
| GEI | `decompiled/m5/scripts/armyII/viewII/information/GoodsExchangeItem.as` |

## 1. Overview

Most secondary currencies are "tokens" ("代币", the protocol table describes 4725 as "兑换物品的代币信息", token info for item exchange). Each token has a `masterType`, an amount and an optional expiry date. The server pushes the whole token list in one message; the client stores it in `PlayerCurrencyInfo` (one property per known type, plus dictionaries for cat toys and magic pub ingredients) and notifies `CURRENCYREFRESH` (PCM:556). Shops, quick buy frames and the hero frame list read it.

4725 (0x1275) is missing from `protocol/opcodes.csv`; it is declared in `decompiled/core_module/scripts/yishi/datas/consant/AcceptProtocolType.as:1066` (`U_C_PLAYER_TOKENINFO`) and `ProtocolTypeTable.as:556`.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `armyII.viewII.information.ItemExchangeView` (IEV) | columns "Item", "Quantidade", "Validade", "Loja" | Paged list (7 rows per page, IEV:56, 107-114) of tokens and pseudo currencies with a shortcut to the shop that spends each | hero frame information tab | `PlayerCurrencyManager.getShowArr()` (IEV:145) sorted by `sort` ascending (PCM:741); refreshes on `CURRENCYREFRESH`, `PLAYER_INFO_UPDATE` and mystery shop `CONSUME_POINTS_REFRESH` (IEV:126-128). On open with hero level >= 26 it asks the mystery shop list if stale (IEV:65-71) |
| `GoodsExchangeItem` (GEI) | button "gotoShopping" (or "gotoPeiYang" for type 27) | One row: name `CurrencyType.getCurrencyNameByType` (GEI:91), amount (`n/99999` for -3, GEI:120-123), expiry: "2000-01-01 00:00:00" or empty means permanent (timeStr01) except types 46 and 39 which show expired (timeStr02); a past date shows expired (GEI:124-149) | row of IEV | shop button hidden for 103 (Texas chips, GEI:93-105) |

## 3. Routes (client to server)

None. The token wallet is push only; no decompiled class requests 4725. Shop shortcuts only open client frames (`FrameControllerManager.openControllerByInfo("shop", ShopType, {type})`, GEI:172-651); the purchases themselves are specified in [../shops/README.md](../shops/README.md).

## 4. Server messages (server to client)

### S1. 4725 (0x1275) `U_C_PLAYER_TOKENINFO`
- Message `PlayerTokenInfoMsg` (player): `tokenInfos` (#1, `TokenInfoMsg`, repeated). `TokenInfoMsg`: `masterType` (#1, INT32) token type; `amount` (#2, INT32) balance; `expiredDate` (#3, STRING, "YYYY-MM-DD hh:mm:ss") expiry, "2000-01-01 00:00:00" or empty = no expiry.
- Receiver: `PlayerCurrencyManager.__currencyRefreshHandler` (PCM:71, 74-557).
- Client reaction: before reading the list it resets 15 properties to empty `CurrencyInfo` (amount 0): petCrystal, petSpirit, petBreath, the four pet creams, guildSkill, yellowCoin, copyConsortia, arenaMedal, mazeGold, eternalCrystal, mountCoin, outyardCoin (PCM:137-151). Every other property keeps its previous object when absent. Then it maps each entry by `masterType` (table below), sets `mazeGoldNumber` for type 11 (PCM:230), and dispatches `CURRENCYREFRESH`.
- When: at login (after `PlayerMsg`), and after every token change. The server must always send the full list of every token the player has ever held (amount 0 included), otherwise stale values stay on screen.

## 5. Rules and formulas

### Token table

`sort` is the order in the list (PCI setters); "Listed" is the `getShowArr` condition (PCM:559-743); "Shop" is the shortcut in GEI (`shop`, ShopType, extra `type`) and the level check shown by the button.

| masterType | Property (PCI) | pt-BR name (CT key) | sort | Listed when | Shop shortcut (GEI line) | Other consumers |
|---|---|---|---:|---|---|---|
| 1 | petCrystal (PCM:157) | "Cristais de Einherjar" (moneyType7) | 110 | level >= 50 | shop 888 type 0, level >= 50 (183-192) | `PetExchangeShopFrame`, `NumBuyFrame` |
| 2 | petFireCream (PCM:178) | "Essência de Fogo" (moneyType1) | 80 | never | shop 888, level >= 50 (223-232) | `GoodsItem6`, `NumBuyFrame` |
| 3 | petWaterCream (PCM:185) | "Essência de Água" (moneyType2) | 90 | never | shop 888 (233-242) | same |
| 4 | petElectricCream (PCM:192) | "Essência de Choque" (moneyType3) | 100 | never | shop 888 (243-252) | same |
| 5 | petWindCream (PCM:199) | "Essência de Vento" (moneyType4) | 70 | never | shop 888 (253-262) | same |
| 6 | guildSkill (PCM:206) | "Dente de Terror" (type01) | 50 | level >= 13 | shop 2 type 1, needs level 13, a guild and guild shop level > 0 (263-280) | `ConsortiaShopFrame`, `BuyFrameI`; virtual -1400 |
| 8 | arenaMedal (PCM:220) | "Medalha" (PvpSettlementAwardView.awardMax.tipData) | 60 | level >= 16 | shop 3, level >= 16 (299-308) | `PvPShopFrame`, `MedalFrame`, `OuterCityShopGoodsItem` |
| 10 | chaos (not set by 4725) | "Pedra do Caos" (type08) | 160 | never | shop 19, level >= 50 (360-369) | `SvSShopFrame`, `QuickBuyFrame`; virtual -1500 |
| 11 | mazeGold (PCM:227) | "Moedas do labirinto" (type09) | 170 | level >= 12 | shop 4, level >= 11 (370-379) | `MazeShopFrame` |
| 12 | eternalCrystal (PCM:235) | "Cristais de Vênus" (type10) | 180 | level >= 36 | shop 20, level >= 36 (380-389) | `MatelordsShopFrame`; virtual -1600 |
| 13 | magicDust (PCM:242, no expiry read) | (no name) | none | never | none | magic cards (`MagicCardSlotView`) |
| 14 | mountCoin (PCM:248) | "Essência da Fera" (type14) | 2 | level >= 16 | shop 1002, level >= 16 (390-399) | `MountShopFrame`; virtual -3000 |
| 15 | gameBoxCoin (PCM:276) | (no name) | none | never | none | `NavigationHelper` virtual -4000 "Moeda do Jogo" |
| 17 | outyardCoin (PCM:255) | "Cristais da Terrálem" (type17) | 6 | level >= 13 | shop 1004, level >= 13 (416-425) | `OutyardShopFrame`; virtual -3400 |
| 18 | aresHeart (PCM:283) | "Coração de Ares" (type18) | 190 | level >= 36 | shop 10, level >= 36 (436-445) | `AresLordsShopFrame`; virtual -3500 |
| 19 | yarramanCoin (PCM:297) | "Ouro de Yalamen" (type19) | 120 | never | shop 13, level >= 13 (446-455) | `CrossPvPShopFrame`; virtual -3600 |
| 20 | athenaTear (PCM:290) | "Lágrimas de Athena" (type20) | 195 | level >= 40 | shop 16, level >= 40 (456-465) | `BraveLegShopFrame`; virtual -3700 |
| 21 | bingoCoin (PCM:269) | "Cristais Vermelhos" (type28) | 8 | level >= 11 | shop 1005 type 1, level >= 11 (487-496) | `BingoShopFrame`; virtual -3800 |
| 22 | gloryCoin (PCM:311) | "Pontos da Glória" (type22) | 220 | level >= 15 | shop 1008, level >= 15 (466-475) | `GloryRoadModel`; virtual -3900 |
| 23 | yellowCoin (PCM:213) | "Cristais amarelos" (type29) | 230 | level >= 13 | shop 2 type 2, guild rules as type 6 (281-298) | `ConsortiaShopFrame`; virtual -4100 |
| 24 | exploreMedal (PCM:318) | "Medalha do Eremitério" (type24) | 240 | never | shop 1010, level >= 10 (497-506) | `IsLandExploreShopFrame`; virtual -4200 |
| 26 | petExchangeCoin (PCM:339) | "Essência de Einherjar" (type26) | 65 | level >= 30 | shop 888 type 2, level >= 50 (193-202) | `PetExchangeShopFrame` |
| 27 | newMagicDust (PCM:304) | "Pó da Ilusão" (type27) | 4 | level >= 18 | button "gotoPeiYang": frame `star` 5 if `vocationGrades > 0` (476-486) | `SubStarFrame` |
| 28 | assaultwarMedal (PCM:325) | "Medalha da Força" (type25) | 280 | never | shop 1011, level >= 80 (507-516) | `AssaultwarShopFrame`; virtual -4400 |
| 29 | copyConsortia (PCM:346) | "Prata de Moréia" (type36) | 300 | level >= 13 | shop 2 type 3, guild rules (527-544) | `ConsortiaShopFrame`; virtual -4700 |
| 30 | apexCoin (PCM:360) | "Corações de Gelo" (type38) | 300 | level >= 80, `VersionSwitch.APEX` and expiry not "2000-01-01 00:00:00" | shop 1015, level >= 80 (566-575) | `ApexShopFrame`, `ApexGuessFrame`; virtual -4800 |
| 31 | crossGuildCoin (PCM:353) | "Pedra da Coragem" (type37) | 310 | level >= 13 and `VersionSwitch.CROSS_GUILD` | shop 2 type 4 when guild shop level > 0, else type 0; needs a guild (545-565) | `CrossGuildShopFrame`; virtual -2900 |
| 32 | antaeusCoin (PCM:367) | "Cristal de localização" (type39) | 320 | `VersionSwitch.ANTAEUS` (false) | shop 1017 (576-585) | `AntaeusShopFrame`; virtual -4900 |
| 33 | airGardenPropCoin (PCM:374) | "Cristal da diversão" (type330) | 330 | never (AIR_GARDEN false) | shop 1018 if `vocationGrades > 0` (586-595) | `AirGardenShopFrame`; virtual -5000 |
| 34 | airGardenBedCoin (PCM:381) | "Cristal da loucura" (type340) | 340 | never | shop 1018 type 1 (596-605) | virtual -5100 |
| 35 | eastEggCoin (PCM:388) | (no name) | 350 | never | none | `GameHallEastShopFrame` |
| 36 | eastTickesCoin (PCM:395) | (no name) | 360 | never | none | game hall |
| 37 | flameTempleCoin (PCM:402) | "Medalha da Chama" (type370) | 61 | `thane.isChangeJob` | shop 1020 type 1 if `isChangeJob` (606-615) | `PvPShopFrame` |
| 38 | duskAreaCoin (PCM:409) | "Medalha do Crepúsculo" (type380) | 62 | `thane.isAvenger` | shop 1021 type 2 if `isAvenger` (616-625) | `PvPShopFrame` |
| 39 | darkmazeSoulCoin (PCM:423) | "Alma do labirinto" (type40) | 390 | `isChangeJob` and `VersionSwitch.DARK_MAZE` | `SwitchPageHelp.openDarkMazeShopFrame` (626-628) | `DarkMazeShopFrame`; virtual -17000 |
| 41 | gemDust (PCM:262), `CurrencyType.VIP_COIN` (CT:46) | "Moeda Estelar" (vip.vipShop.item.tip02) | none | never | none | VIP shop (disabled, [../vip/privileges.md](../vip/privileges.md)), `NumBuyFrame`; virtual -2700 |
| 46 | godsMarking (PCM:332) | "Marca dos Deuses" (type35) | 460 | level >= 1 and `VersionSwitch.GODS_EVENING` (false) | shop 35 if the gods evening icon is shown (517-526) | `GodsEveningShopFrame`; virtual -11000 |
| 56 | demonroadCoin (PCM:416) | "Pó" (demonroad.shop.CurrencyType.type) | none | never | none | `DemonRoadShopFrame`; virtual -16000 "Pó Mítico" |
| 57 | consortiaNewBossCoin (PCM:430) | (no name; virtual -18000 "Pontos de Chefão") | 570 | never | none | `ConsortiaNewBossShopFrame` ([../guild/boss.md](../guild/boss.md)) |
| 58 | poseidonCoin (PCM:437) | "Gema Poseidon" (poseidon.shop.type) | 580 | `RoyaltyBossManager.model.royaltyLevel > 0` | `SwitchPageHelp.openPoseidonFrame` (629-631) | Theseus warframe enhancement; virtual -19000 |
| 59 | thesepvpMedal (PCM:444) | (no name) | 590 | never | none | `TheseuspvpShopFrame` |
| 60 | thesepvpHoner (PCM:451) | (no name) | 600 | never | none | `TheseusGloryRewardFrame` |
| 61 | secretwarShopCoin (PCM:479) | "Mérito" (secretwar.shop.type) | 610 | level >= 30 and `VersionSwitch.SECRET_WAR` | frame `secretwar` 5 if `isAvenger` (632-641) | `SecretwarShopFrame`; virtual -5500 |
| 62 | yearBoxKey (PCM:486) | "Chave do Baú de Aniversário" | 620 | never | none | anniversary event; virtual -1801 |
| 63 | yearEggTicket (PCM:493) | "Cupom de Gashapon de Aniversário" | 630 | never | none | virtual -1802 |
| 64 | yearGold (PCM:500) | "Moeda de Aniversário" | 640 | never | none | virtual -1803 |
| 65 | minosCoin (PCM:507) | (virtual -21000 "Pontos Minos") | 650 | never | none | guild shop ([../guild/minos.md](../guild/minos.md)) |
| 66 | chessPvpCoin (PCM:514) | (virtual -23000 "Pontos Táticos", assumption) | 660 | never | none | guild shop ([../guild/chess.md](../guild/chess.md)) |
| 67 | childNsWarCoin (PCM:521) | (no name) | 670 | never | none | `ChildNswarShopFrame` |
| 69 | theseDoublepvpHoner (PCM:458) | (no name) | 690 | never | none | `TheseusDoubleGloryRewardFrame` |
| 70 | theseuscollectionBox (PCM:465) | (no name) | 700 | never | none | Theseus collection |
| 71 | theseusshuijing (PCM:472) | (no name) | 700 | never | none | `DungenexShopFrame` |
| 99 | petBreath (PCM:171) | "Sopro de Einherjar" (moneyType10) | 67 | level >= 50 | shop 888 type 3, level >= 50 (213-222) | `PetExchangeShopFrame` |
| 100 | petSpirit (PCM:164) | "Essência de Einherjar" (moneyType8) | 66 | level >= 50 | shop 888 type 1, level >= 50 (203-212) | `PetExchangeShopFrame` |
| 101..110 | magic pub dictionary (PCM:541-552) | ingredients, virtual -1700..-1709 ("Sorvete", "Papagaio", "Chocolate", "Lanternas", "Galinhas fritas e Cerveja", "Álbum de Fotos", "Balde Sorvete", "Vaso de Tulipas", "Cerejas Enlatadas", "Álbum Novo") (CT:136-138) | none | never | none | [../fantasy-bar/README.md](../fantasy-bar/README.md) |
| 1001..1007 | cat toy dictionary (PCM:529-540) | toys, virtual -2000..-2600 ("Madeira", "Corda", "Flanela", "Jornal", "Algodão", "Pena", "Nepenta") (CT:132-134) | none | never | none | [../cat-house/README.md](../cat-house/README.md) |

### Pseudo currencies in the same list (not part of 4725)

| masterType | Source | pt-BR | sort | Listed when | Shortcut |
|---:|---|---|---:|---|---|
| -1 | `PlayerInfo.starPoint` (PlayerMsg #57) | "Pontos do Cosmo" (type03) | 10 | level >= 18 | shop 101, level >= 18 (GEI:309-318) |
| -2 | light crystal (109 #11) | "Cristal de luz" | 20 | level >= 18 | building of SonType 501, level >= 18 (GEI:319-329) |
| -3 | `PlayerInfo.mineral` (PlayerMsg #84) | "Ametistas" (type04) | 30 | never pushed (built but not added, PCM:572-576) | shop 11, level >= 25 (GEI:330-339) |
| -4 | `MysteryShopManager.model.consumePoints` | "Pontos da Loja Misteriosa" (type05) | 40 | level >= 26 | frame `outercityshop`, level >= 26 (GEI:340-349) |
| -5 | `PlayerInfo.crossLeagueMedal` (PlayerMsg #93) | "Emblema do Campeonato" (type06) | 130 | level >= 16 | shop 3 type 3, level >= 16 (GEI:350-359) |
| 101 | `NavigationManager.model.currency` | "Moedas de Navegação" (type101) | 220 | level >= 80 | shop 9001, level >= 80 (GEI:426-435) |
| 102 | `PokerManager.palyerInfo.pokerScore` | "Pontos de Texas" (type15) | 200 | never pushed (PCM:587-591) | shop 1003, level >= 6 (GEI:400-409) |
| 103 | `pokerCorn` | "Fichas de Texas" (type16) | 210 | never pushed | no shop (GEI:93-105) |

Pseudo type -5 expiry is computed by `getOutTime` (PCM:745-752): intended "first day of next month 00:00:00", but the code adds two months and drops the dash before the day ("YYYY-MM01 00:00:00"), so the parsed date is invalid. The server should still reset league medals monthly (see [wallet.md](wallet.md)).

### Other rules
- Type 101 is ambiguous: `CurrencyType.NAVIGATION_COIN = 101` (CT:68) and the magic pub range 101..110 (CT:136). Tokens 101..110 in 4725 go to the magic pub dictionary; the navigation pseudo entry 101 is client built. The server must not send navigation coins in 4725.
- Expiry: an entry with a future `expiredDate` is valid until that instant; the GEI button refuses with "armyII.viewII.information.GoodsExchangeItem.prompt" when expired (GEI:178, 643-646). The server must zero or delete expired tokens and push 4725 (assumption on the reset instant: exactly at `expiredDate`).
- Types 46 and 39 with no expiry display as expired (GEI:126-129): a client quirk, no server rule.
- Not populated by 4725 despite having properties: `chaos` (10), `godWiner`, `remotePetFlag`; a client reading them gets the last object or null. Treat 10 as a valid token anyway (shops price in it).
- Amount is INT32 on the wire; cap every token at 2147483647.

## 6. Templates

| File | Record | Fields |
|---|---|---|
| `raw/xml/tempinfos/ItemTempInfos.xml` | negative `TemplateId` virtual items | name and icon of each currency when it appears in a drop or price (mapping above) |
| `raw/xml/tempinfos/ShopTempInfos.xml` | `ShopTempInfo` per `ShopType` | the shops listed above; price columns are owned by [../shops/README.md](../shops/README.md) |
| `index/language.json` | `mvc.module.currency.CurrencyType.type*`, `view.subshop.PetExchangeShopFrame.moneyType*` | display names |

## 7. Persistent state

```sql
CREATE TABLE currency.tokens (
  player_id    BIGINT      NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  master_type  INTEGER     NOT NULL CHECK (master_type > 0),
  amount       INTEGER     NOT NULL DEFAULT 0 CHECK (amount >= 0),
  expires_at   TIMESTAMPTZ,
  updated_at   TIMESTAMPTZ NOT NULL DEFAULT now(),
  PRIMARY KEY (player_id, master_type)
);
CREATE INDEX tokens_expiry_idx ON currency.tokens (expires_at) WHERE expires_at IS NOT NULL AND amount > 0;

CREATE TABLE currency.token_types (
  master_type      INTEGER PRIMARY KEY,
  code             TEXT    NOT NULL UNIQUE,
  name_key         TEXT,
  virtual_item_id  INTEGER UNIQUE,
  expires_policy   TEXT    NOT NULL DEFAULT 'none' CHECK (expires_policy IN ('none','fixed','monthly','event'))
);
```

`currency.token_types` is seeded from the table above (code = PCI property name). Rows with `amount = 0` are kept so 4725 can resend them.

## 8. Backend implementation notes

- `currency::tokens::push_token_info(player_id)`: select all rows of `currency.tokens`, format `expires_at` as "YYYY-MM-DD hh:mm:ss" (or "2000-01-01 00:00:00" when null), send 4725. Called after commit by `grant_token`, `spend_token`, the expiry job and at login.
- `currency::tokens::grant_token(tx, player_id, master_type, amount, expires_at, reason, ref)` and `spend_token(...)`: upsert with row lock, check `amount >= cost`, insert ledger row ([spending.md](spending.md)).
- Expiry job every minute: `UPDATE currency.tokens SET amount = 0 WHERE expires_at <= now() AND amount > 0 RETURNING player_id`; push 4725 to each online player.
- Event tokens (anniversary 62..64, Easter 35..36, magic pub, cat toys) carry the event end as `expires_at` when the owning feature grants them (assumption).
- Order at login: after `PlayerMsg` (3) so the list screen has both sources.

## 9. Open questions and assumptions

- Open: real source and sink of tokens 35, 36, 59, 60, 67, 69, 70, 71 belong to their features (Theseus, game hall, child war); the names here come only from the item virtual ids.
- Assumption: 66 is "Pontos Táticos" (-23000) and 65 "Pontos Minos" (-21000) based on the guild feature naming.
- Assumption: expired tokens are reset to 0, not deleted.
- Open: whether the original server sent 4725 as a delta; the client reset of 15 types suggests a full snapshot.

## 10. Implementation checklist

- [ ] Server message S1 4725 full snapshot with zero rows
- [ ] Screen: currency list paging, names, amounts and expiry text
- [ ] Screen: each shop shortcut opens the right ShopType with the level and guild checks
- [ ] Table `currency.tokens`
- [ ] Table `currency.token_types` seeded with every row above
- [ ] Rule: expiry job zeroes and pushes
- [ ] Rule: monthly reset of pseudo type -5
- [ ] Rule: no navigation coin in 4725 (type 101 clash)
- [ ] Test: grant arena medals pushes 4725 and the list refreshes
- [ ] Test: a token with a past `expiredDate` shows expired and cannot open its shop
- [ ] Test: cat toy 1003 and magic pub 105 land in their dictionaries
