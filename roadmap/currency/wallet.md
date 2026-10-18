# Wallet: core balances and the HUD resource bar

Path aliases:

| Alias | File |
|---|---|
| RM | `decompiled/core_module/scripts/yishi/manager/ResourceManager.as` |
| RD | `decompiled/core_module/scripts/yishi/datas/resource/ResourceData.as` |
| PM | `decompiled/core_module/scripts/yishi/manager/PlayerManager.as` |
| PI | `decompiled/core_module/scripts/yishi/datas/playerinfo/PlayerInfo.as` |
| RV | `decompiled/core_module/scripts/ui/resourcebar/view/ResourceView.as` |
| BM | `decompiled/core_module/scripts/yishi/manager/BaseManager.as` |
| IV | `decompiled/m5/scripts/armyII/viewII/information/InformationView.as` |

## 1. Overview

The wallet is the set of scalar balances every player owns. They reach the client through three pushes: the castle resource update 109 (gold and light crystal), the player info update 3 (`PlayerMsg`, diamonds and hero counters) and a few side channels (260 extra fields, 4471 daily honor). The client keeps a 30 second resync timer for gold (5015).

| Balance | pt-BR | Wire | Client field | Virtual item id | Notes |
|---|---|---|---|---|---|
| Gold | "Ouro" | 109 `CastleYieldMsg.gold_total_count` (#6) | `ResourceManager.gold.count` (RM:69-72) | -100 | cap `gold_max` (#7); yield per hour `gold_yield` (#1) |
| Light crystal | "Cristal de luz" | 109 `CastleYieldMsg.crystals_count` (#11) | `ResourceManager.waterCrystal.count` (RM:75) | -600 | client cap 100000000 (RM:75) |
| Population | "População" | 109 `cur_population` (#8), `max_population` (#9) | `ResourceManager.population` (RM:73-76) | none | not a currency; owned by [../army/README.md](../army/README.md) |
| Diamonds | "Diamante" | 3 `PlayerMsg.point` (#6) | `PlayerInfo.point` (PM:627-630, PI:594-606) | -400 | only from recharge; tip "Diamante: obtido através de recarga" (RV:311) |
| Bound diamonds | "Diamante vinculado" | 3 `PlayerMsg.gift_token` (#7) | `PlayerInfo.giftToken` (PM:631-634) | -500 | getter clamps negatives to 0 (PI:580-583), HUD shows raw `giftToken1` (PI:575-578, RV:549); tip "Diamante vinculado: Pode ser adquirido em missões" (RV:309) |
| Espírito (spirits) | "Espírito" | 3 `PlayerMsg.strategy` (#20, INT64) | `PlayerInfo.strategy` (PM:865-868) | -300 | battle loot, guild donation 1000 = 1 Guerra ([../guild/funds.md](../guild/funds.md)) |
| Honor | "Honra" | 3 `PlayerMsg.geste` (#60) | `ThaneInfo.honer` (PM:757-764) | none | daily caps pushed by 4471; drives honor rank title |
| Reputation | (no UI string) | 3 `PlayerMsg.repute` (#18) | `PlayerInfo.repute` (PM:853-856) | none | stored and echoed, no client screen reads it (assumption: legacy counter) |
| Charm | "Charme" | 3 `PlayerMsg.charm` (#69) | `ThaneInfo.charms` (PM:765-772, IV:441) | none | social stat, granted by gifts ([../friends/README.md](../friends/README.md)) |
| Cosmos points | "Pontos do Cosmo" | 3 `PlayerMsg.starpoint` (#57) | `PlayerInfo.starPoint` (PM:1026-1029) | none | cosmos shop 101 ([../cosmos/README.md](../cosmos/README.md)) |
| Amethysts | "Ametistas" | 3 `PlayerMsg.mine_score` (#84) | `PlayerInfo.mineral` (PM:707-710) | -200 | displayed as `n/99999` (`GoodsExchangeItem.as:120-123`) |
| Glory crystal | "Cristal da Glória" | 3 `PlayerMsg.lords_score` (#82) | `PlayerInfo.gloryPoint`, `ThaneInfo.gloryPoint` (PM:699-702, 773-780) | -800 | warlords shop |
| Championship emblem | "Emblema do Campeonato" | 3 `PlayerMsg.cross_league_medal` (#93) | `PlayerInfo.crossLeagueMedal` (PM:1099-1102) | -1100 | expires at month change (see [tokens.md](tokens.md), pseudo type -5) |
| Cross score | (shop column `CrossLeagueMedal`, `Score`) | 3 `PlayerMsg.cross_score` (#79) | `PlayerInfo.crossScore` (PM:969-972) | none | cross server PvP ([../cross-server/README.md](../cross-server/README.md)) |
| Cross guild score | (shop column `CrossGuildScore`) | 3 `PlayerMsg.cross_guild_score` (#92) | `PlayerInfo.crossGuildScore` (PM:720-723) | none | [../guild/cross-server-war.md](../guild/cross-server-war.md) |
| Rune power | (rune UI) | 3 `PlayerMsg.runePowerPoint` (#166) | (PM:1221-1224) | none | runes, owned by [../smith/README.md](../smith/README.md) (assumption) |
| Guild contribution | "Contribuição" | 3 `consortia_offer` (#19), `consortia_totaloffer` (#52) | (PM:857-864) | none | owned by [../guild/funds.md](../guild/funds.md) |
| Texas chips | "Fichas de Texas" | 260 field 6 | `PokerManager.pokerCash`, `PlayerInfo.pokerCorn` (BM:903-906) | none | casino ([../casino/README.md](../casino/README.md)) |
| Texas points | "Pontos de Texas" | 260 field 7 | `PokerManager.pokerScore`, `PlayerInfo.pokerScore` (BM:907-911) | none | Texas shop 1003 |

Token currencies (arena medals, maze coins, dust, activity coins) live in the token wallet: [tokens.md](tokens.md).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `ui.resourcebar.view.ResourceView` (RV) | none (HUD) | Gold, diamonds, bound diamonds, VIP button | always on screen | gold text `FormularySets.toStringSelf(count, 9999999)` (RV:528), frame 2 (red) when `count >= limit` (RV:514-521) with "Capacidade máxima de ouro atingida!" (`GoldOvertopView`), gold tip "Ouro" + "Produção interna:" `baseYield - fieldYield` "/hr" (+Fonte Mágica buffer) (RV:291-308); diamonds `point` (RV:548, 779); bound `giftToken1` (RV:549, 780); "Ativar VIP" / "VIP Comum" buttons (RV:456-469) open `vip` (RV:760-763) |
| `armyII.viewII.information.InformationView` (IV) | hero information tab | Honor and charm | hero frame | `thane.honer` as "Honra" with tip "Para subir para {0} (nível {1}) ainda precisa de {2} de Honra\nHonras conquistadas hoje: {3}/{4}" or "Honra atingiu o nível máximo,\nCombata para obter Honra:{0}/{1}\nUse itens para obter Honra:{2}/{3}" (IV:439-456) |

## 3. Routes (client to server)

### W1. Resource resync
- UI: none. `ResourceManager` timer every 30000 ms (RM:39-41, 54-57) and once when the resource bar is built (`decompiled/core_module/scripts/ui/resourcebar/ResourcesBar.as:101`).
- Sender: `ResourceManager.sendSyncResources` (RM:106-110).
- Client checks: none.
- Route: send 5015 (0x1397) `U_C_CASTLE_UPDATE`, empty body.
- Expected response: 109 (0x006d) `U_C_CASTLE_UPDATE` with the current castle yield.

No other request of this module exists. 5016 (0x1398) `U_C_PLAYER_INFO` is defined in `opcodes.csv` but no decompiled class sends it.

## 4. Server messages (server to client)

### S1. 109 (0x006d) `U_C_CASTLE_UPDATE`
- Message `CastleYieldMsg` (castle): `gold_yield` (#1, INT32) base gold per hour; `gold_wild_land_yield` (#2, INT32) per hour from occupied fields; `gold_technology` (#3, INT32); `gold_wonder` (#4, INT32); `gold_dower` (#5, INT32) bonus parts; `gold_total_count` (#6, INT32) current gold; `gold_max` (#7, INT32) gold cap; `cur_population` (#8, INT32); `max_population` (#9, INT32); `wildYield` (#10, `WildYieldMsg`, repeated) per field yields; `crystals_count` (#11, INT32) light crystals.
- Receiver: `ResourceManager.__resourceUpgrade` (RM:64-77): `gold.synchronizationResource(gold_yield, gold_total_count, gold_max)`, `waterCrystal.synchronizationResource(0, crystals_count, 100000000)`, `population.synchronizationResource(0, cur, max)`. `ResourceData.synchronizationResource` (RD:35-42) dispatches `RESOURCE_UPDATE` with the delta, used by the HUD "+N" gold animation (RV:501-509).
- When: reply to 5015; push after any gold or light crystal change (spend, grant, production tick visible to the player, building change of the cap), and at login.

### S2. 3 (0x0003) `U_C_PLAYER_INFO` (currency subset)
- Message `PlayerMsg` (player); only the fields set are applied (`has*` checks, PM:496 onward). Currency fields: `point` (#6, INT32), `gift_token` (#7, INT32), `repute` (#18, INT32), `consortia_offer` (#19, INT32), `strategy` (#20, INT64), `consortia_totaloffer` (#52, INT32), `starpoint` (#57, INT32), `geste` (#60, INT32), `first_charge` (#68, BOOL, see [../recharge/payment.md](../recharge/payment.md)), `charm` (#69, INT32), `cross_score` (#79, INT32), `lords_score` (#82, INT32), `mine_score` (#84, INT32), `cross_guild_score` (#92, INT32), `cross_league_medal` (#93, INT32), `runePowerPoint` (#166, INT32).
- Receiver: `PlayerManager.__uPlayerInfoHandler` (listener PM:150); setters set `_changeObj["POINT"]` for point and gift (PI:585-606) and the commit dispatches `PLAYER_INFO_UPDATE`, which refreshes the HUD (RV:545-549), the currency list and every open price check.
- When: after every change of any of these balances (send only the changed fields), and the full message at login (owned by [../hero/README.md](../hero/README.md)).

### S3. 4471 (0x1177) `U_C_DAYGESTE_SEND`
- Message `simple.PropertyMsg`: `param1` (#1, INT32) honor gained today from battles; `param2` (#2, INT32) daily battle honor cap; `param3` (#3, INT32) honor gained today from items (potions).
- Receiver: `PlayerManager.__daygesteUpdateHandler` (PM:168, 1387-1420) writes `thane.honerDay`, `honerDayMax`, `honerDayMedicinal`.
- When: at login, after each honor gain, and at the daily reset.

### S4. 260 (0x0104) `U_C_PLAYER_EXTRA_FIELD_MSG`
- Message `PlayerExtraFieldMsg`: `extraField` (#1, `ExtraFieldInfoMsg`, repeated): `fieldId` (#1, INT32), `field_Type` (#2, INT32), `userId` (#3, INT32), `value` (#4, STRING).
- Receiver: `BaseManager.__updateInfoHandler` (BM:335, 876-...). Currency fields: 6 Texas chips (`pokerCash`, `pokerCorn`), 7 Texas points (`pokerScore`). Fields 1 to 4 belong to [../vip/regist-welfare.md](../vip/regist-welfare.md); 8, 9, 12, 13 and later belong to other features.
- When: login and after a change of the field.

No result codes: these pushes are state, the client has no error path.

## 5. Rules and formulas

- Gold cap: `gold_max` from the castle (warehouse buildings, [../castle/README.md](../castle/README.md)). The HUD marks the value red at `count >= limit` and shows the overflow tip when a grant pushes the value over the cap (RV:514-543), so grants may exceed the cap while production stops at the cap (assumption, matches the overflow view).
- Gold production: `gold_yield` per hour (inner production = `gold_yield - wild land yield`, RV:298) plus field yields. Accrue lazily on read: `gold += floor(yield_per_hour * elapsed_seconds / 3600)` clamped to `gold_max` (assumption).
- `canSubtractResources(gold, crystal, population)` (RM:79-104) is the client pre-check used by buildings and troops: message "Necessário" + missing amounts.
- Bound diamonds may be negative on the wire (refund debt, assumption); spend checks use the clamped value `giftToken` and `allPoint = point + giftToken` (PI:608-611).
- Honor daily caps: `DayAddGeste = 6000,50000` (`raw/xml/tempinfos/ConfigInfos.xml`): at most 6000 honor per day from battles, 50000 per day from honor items; read by IV:94. `Geste_UpperLimit = 30,7000|40,32000|50,88000|55,176000|60,240000|80,99990000`: maximum honor by hero level bracket (hero level <= 30 caps honor at 7000, and so on) (interpretation of "荣誉等级上限").
- VIP privilege 15 reduces honor lost in battlegrounds ([../vip/privileges.md](../vip/privileges.md)).
- Light crystal cap 100000000 is a client constant (RM:75); the server should clamp to the same value (assumption).
- Default bound diamonds at character creation: `Player_GiftToken = 0`.
- Display caps are cosmetic: gold, diamonds and bound diamonds are printed through `FormularySets.toStringSelf(value, 9999999)`.

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `raw/xml/tempinfos/ConfigInfos.xml` | `ConfigInfo` | `DayAddGeste`, `Geste_UpperLimit`, `Player_GiftToken` |
| `raw/xml/tempinfos/ItemTempInfos.xml` | virtual items with negative `TemplateId` | `-100` Ouro, `-200` Ametistas, `-300` Espírito, `-400` Diamante, `-500` Diamante Vinculado, `-600` Cristal de Luz, `-700` Experiência, `-800` Cristal da Glória, `-1000` Emblema do Rei, `-1100` Emblema do Campeonato; full list in [spending.md](spending.md) |

## 7. Persistent state

```sql
CREATE SCHEMA IF NOT EXISTS currency;

CREATE TABLE currency.wallets (
  player_id              BIGINT      PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
  gold                   BIGINT      NOT NULL DEFAULT 0 CHECK (gold >= 0),
  gold_accrued_at        TIMESTAMPTZ NOT NULL DEFAULT now(),
  light_crystal          BIGINT      NOT NULL DEFAULT 0 CHECK (light_crystal BETWEEN 0 AND 100000000),
  diamonds               INTEGER     NOT NULL DEFAULT 0 CHECK (diamonds >= 0),
  bound_diamonds         INTEGER     NOT NULL DEFAULT 0,
  spirit                 BIGINT      NOT NULL DEFAULT 0 CHECK (spirit >= 0),
  honor                  INTEGER     NOT NULL DEFAULT 0 CHECK (honor >= 0),
  reputation             INTEGER     NOT NULL DEFAULT 0,
  charm                  INTEGER     NOT NULL DEFAULT 0 CHECK (charm >= 0),
  cosmos_points          INTEGER     NOT NULL DEFAULT 0 CHECK (cosmos_points >= 0),
  amethysts              INTEGER     NOT NULL DEFAULT 0 CHECK (amethysts BETWEEN 0 AND 99999),
  glory_crystals         INTEGER     NOT NULL DEFAULT 0 CHECK (glory_crystals >= 0),
  league_medals          INTEGER     NOT NULL DEFAULT 0 CHECK (league_medals >= 0),
  league_medals_month    DATE,
  cross_score            INTEGER     NOT NULL DEFAULT 0 CHECK (cross_score >= 0),
  cross_guild_score      INTEGER     NOT NULL DEFAULT 0 CHECK (cross_guild_score >= 0),
  rune_power             INTEGER     NOT NULL DEFAULT 0 CHECK (rune_power >= 0),
  texas_chips            INTEGER     NOT NULL DEFAULT 0 CHECK (texas_chips >= 0),
  texas_points           INTEGER     NOT NULL DEFAULT 0 CHECK (texas_points >= 0),
  updated_at             TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE currency.daily_honor (
  player_id        BIGINT  NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  day              DATE    NOT NULL,
  battle_honor     INTEGER NOT NULL DEFAULT 0 CHECK (battle_honor >= 0),
  item_honor       INTEGER NOT NULL DEFAULT 0 CHECK (item_honor >= 0),
  PRIMARY KEY (player_id, day)
);
```

`gold_max` and yields are derived from castle buildings and are not stored here. Every change also inserts a `currency.ledger` row ([spending.md](spending.md)).

## 8. Backend implementation notes

- `currency::wallet::handle_sync_castle` (5015): load wallet, accrue gold, reply 109 built by `castle::yield::build_castle_yield_msg` (castle owns yields, this module fills `gold_total_count` and `crystals_count`). No validation; rate limit to one reply per second per session.
- `currency::wallet::push_player_currency(player_id, fields)`: builds a partial `PlayerMsg` with only the changed currency fields and sends 3. Callers: every `spend`/`grant`.
- `currency::wallet::push_castle_yield(player_id)`: sends 109 after gold or crystal changes.
- `currency::wallet::push_daily_honor(player_id)`: sends 4471 (`param1` battle honor today, `param2` 6000, `param3` item honor today).
- `currency::wallet::grant_honor(tx, player_id, amount, source)`: source `battle` clamps to `6000 - battle_honor`, source `item` clamps to `50000 - item_honor`, then clamps the total to the `Geste_UpperLimit` bracket of the hero level; updates `currency.daily_honor` lazily for the current day.
- Daily job at 00:00 server time: none required (lazy day rows); push 4471 to online players at midnight so the counters reset on screen (assumption).
- Monthly job: zero `league_medals` at the first day of the month and push 3 (see [tokens.md](tokens.md) pseudo type -5).
- Login order: 109 and 3 come from the castle and hero login sequence; this module adds 4725 ([tokens.md](tokens.md)), 260 and 4471.

## 9. Open questions and assumptions

- Assumption: production stops at `gold_max` while explicit grants may exceed it (client shows "Capacidade máxima de ouro atingida!" after an overflow).
- Assumption: `repute` is a legacy counter; kept and echoed.
- Open: what makes `gift_token` negative on the original server (refund debt or GM correction); the HUD prints negatives.
- Open: exact wild land and technology yield formulas belong to the castle feature.
- Assumption: Honor `Geste_UpperLimit` brackets are hero level upper bounds.
- `GoodsItemMenu.as:177-184` checks Espírito for the virtual id -700 ("Experiência"); treated as a client bug, server uses -700 as experience.

## 10. Implementation checklist

- [ ] Screen: HUD gold, diamonds, bound diamonds update after every push
- [ ] Screen: honor tip values match 4471
- [ ] Route W1 5015 replies 109
- [ ] Server message S1 109 with gold, cap, yields, crystals
- [ ] Server message S2 3 partial currency fields
- [ ] Server message S3 4471 daily honor
- [ ] Server message S4 260 Texas fields 6 and 7
- [ ] Table `currency.wallets`
- [ ] Table `currency.daily_honor`
- [ ] Rule: lazy gold accrual clamped to cap
- [ ] Rule: honor daily caps 6000 and 50000 and level cap
- [ ] Rule: light crystal cap 100000000
- [ ] Rule: monthly reset of league medals
- [ ] Test: spend gold below zero is refused and nothing is pushed
- [ ] Test: grant over cap shows the overflow view and 109 carries the new total
- [ ] Test: battle honor stops at 6000 per day and resets next day
