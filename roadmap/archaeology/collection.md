# Archaeology collection, exchange and level

Feature [archaeology](README.md), module `collection`. Aliases in [README.md](README.md).

## 1. Overview

- Each archaeology item (`ArchaeologyItemTemps.xml`, 200 rows) is collected as fragments ("fragmentos"). When `chipCount >= NeedChip` the player exchanges `NeedChip` fragments for the reward `RewardId x RewardCount` (resources, items, potions/scrolls, fashion pieces).
- Every exchanged item raises `itemCount`; an item with `itemCount >= 1` counts as "collected" for the picture sets ([handbook.md](handbook.md)).
- Items are grouped by origin map (`MapId` 0 "Mapa" = common, 1..5 = outer worlds) and by type (`Type` 1 "Recursos", 2 "Itens", 3 "Poção e Pergaminho", 4 "Visual").
- Archaeology experience (`exp`, extra field 8) sets the archaeology level 1..5 ("Básico", "Intermédio", "Avançado", "Mestre", "Divino"). Each level from 2 to 5 pays a level up reward (book `Type = 2`): a mount item and a title.
- HUD red counter (`InfoTipsManager` key 30) = number of map tabs with at least one exchangeable item plus 1 when a picture can be claimed (`AMOD:333-382`, `AM:72`, `AM:95`).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `M14A/ArchaeologyFrame.as` | "Arqueologia" (`ArchaeologyFrame.titleText.text`, `:142-146`) | Main frame, groups `MAIN_TOOLS_GROUP`, `BAG_GROUP` (`:43-46`); sends op 2 on open (`:40`) | HUD button, controller `archaeology` | Level name and exp bar "{0} {1}/{2}" (`:89-130`); max level text "Divino"; tip `ArchaeologyUpgradeRewardTips` with the next level reward (`:120-129`) or "Arqueologia atingiu o nível máximo" |
| `M14A/ArchaeologyMakeView.as` | | Container: left list, right detail, "Imagem de Arqueologia" button with counter (`:35-94`) | frame | `getBookCanComposeCount()` badge |
| `M14A/ArchaeologyMakeLeftView.as` | tabs "Mapa", "Pasto Livre" .. "Terra do Julgamento" | Map tab group (all = MapId 0, then 1..5), type groups and item list with exchangeable count " (n)" (`:79-125`, `:157-232`) | make view | items of `getGoodsListByMapId(tab)`, red badges per tab from `typeBtnArr` |
| `M14A/ArchaeologyLeftCheckPanel.as` | | Filter "only exchangeable" (check button `ArchaeologyFrame.checkButton`) lists all items with `canMakeCount > 0` across maps (`:52-235`; toggled in `ArchaeologyMakeLeftView.as:299-334`) | check box | grouped list |
| `M14A/ArchaeologyLeftItem.as` | group names "Recursos", "Itens", "Poção e Pergaminho", "Visual" | List cell; group header (`cellType 1`) or item (`cellType 2`), name color by collected state (`:109-262`) | lists | name, `(canMakeCount)` |
| `M14A/ArchaeologyMakeRightView.as` | "Astrolábio" button tip "Ativado quando a Arqueologia atinge o nível máximo." | Item detail: picture `getArchaeologyDescPicPath(Pic)`, `Detail`, reward cell, progress `chipCount/NeedChip`, exchange button (`:62-225`) | selection | template + `chipCount` |
| `M14A/ArchaeologyWorldMapView.as` | | Map picker that switches the left tab (`:65-73`); not referenced by the frame in this build | | |
| `decompiled/m16/scripts/yishi/view/tips/ArchaeologyUpgradeRewardTips.as` | "Próx. nível", "Pode se obter:", "Título [..]", "Montaria [..]" | Next level reward tip (`:55-79`) | exp bar hover | book Type 2 row for `level + 1` |

## 3. Routes (client to server)

Common: send 9575 (0x2567) `C_ARCHAEOLOGY_REQ`, `ArchaeologyReqMsg` `op` (#1, INT32), `tempId` (#2, INT32); sender `AM.sendArchaeologyRequest` (`AM:98-105`).

### R1. Exchange fragments (op 3)

- UI: exchange button `rechargeBtn` in `ArchaeologyMakeRightView` (`M14A/ArchaeologyMakeRightView.as:114-117`).
- Client checks: the button is enabled only when `chipCount >= NeedChip` (`:145-154`). No confirmation, no bag space check.
- Request: `op = 3`, `tempId = ArchaeologyItemTemp.Id`.
- Expected: 298 with the item row (`chipCount -= NeedChip`, `itemCount += 1`); reward delivery: bag push 115 for items, player info 3 for currencies (negative `RewardId`: -100 gold, -300 Espírito, -500 bound diamonds, -600 Cristal de Luz, etc.); exp change on 260 field 8 if exchanges give exp (assumption).

### R2. Open frame (op 2)

Sent by the frame constructor (`M14A/ArchaeologyFrame.as:40`); the reply 296 is documented in [handbook.md](handbook.md). The server should also resend 298 if the client may be stale (assumption; the client keeps 298 data from login).

## 4. Server messages (server to client)

### 298 (0x012a) `U_C_ARCHAEOLOGY_GOODLIST`

- Message `ArchaeologyItemListMsg`: `updateItem` (#1, MESSAGE `ArchaeologyItemMsg`, repeated): `tempId` (#1, INT32) item template id; `chipCount` (#2, INT32) fragments owned; `itemCount` (#3, INT32) times exchanged (collected when >= 1).
- Receiver: `ArchaeologyManager.__updateArchaelogyGoodList` (`AM:75-96`, listener `AM:51`). Merge semantics: rows are upserted by `tempId`, rows not sent are kept. Then recomputes tab badges, notifies `GOOD_lIST_UPDATE` (left list, right detail, picture badge) and updates HUD counter 30.
- When: login (full list of rows with any fragment or count), after each dig that gives fragments ([dig.md](dig.md)), after each exchange (op 3).

### 260 (0x0104) `U_C_PLAYER_EXTRA_FIELD_MSG`, field 8

- `fieldId = 8`, `value` = total archaeology exp as a decimal string (`BM:913-916`). Event `PLAYER_EXTRA_FIELD` refreshes the frame exp bar (`M14A/ArchaeologyFrame.as:84-87`) and the overlay level (`OCAV:405`).
- When: login, after every exp gain.

## 5. Rules and formulas

- Level from exp (`AMOD.getGradeByExp`, `AMOD:109-130`) with `UpGradeTempInfos.xml` `Types = 111`: Data per level 0, 5000, 25000, 125000, 625000. The exp needed to leave level L is `Data[L+1]` (non cumulative): L1->L2 5000, L2->L3 25000, L3->L4 125000, L4->L5 625000; total 780000 to reach 5 ("Divino"), the max.
- Exp bar text: level name, exp inside the level, exp needed (`M14A/ArchaeologyFrame.as:101-119`).
- Exchangeable count = `floor(chipCount / NeedChip)` (`decompiled/core_module/scripts/mvc/module/archeology/ArchaeologyItemInfo.as:28-36`). Each op 3 exchanges exactly one unit.
- Level 3 unlocks star gazing ([cosmos](../cosmos/README.md)): `ArchaeologyMakeRightView.as:81-85`, `SwitchPageHelp.as:2488-2496`.
- Level up reward (book Type 2, `Collection1` = level reached): level 2 item 2180024 + title 300; level 3 item 2180042 + title 301; level 4 item 2180052 + title 302; level 5 item 2180092 + title 303 (`raw/xml/tempinfos/ArchaeologyBookTemps.xml` Ids 102..105). The tip names the item "Montaria". There is no claim route: the server grants it when the level is reached (assumption).
- `MinLevel` gates drops, not exchanges (assumption, see [dig.md](dig.md)).

## 6. Templates

| File | Record | Fields |
|---|---|---|
| `raw/xml/tempinfos/ArchaeologyItemTemps.xml` (`ArchaeologyItemTemplateCate`) | 200 `ArchaeologyItemTemp` | `Id`; `Name`; `Detail` description; `Pic` description image path (under `{RES}icon`); `PicLayout` 1 or 2 (layout of picture and text); `Type` 1 Recursos (30), 2 Itens (96), 3 Poção e Pergaminho (60), 4 Visual (14); `MapId` 0..5; `MinLevel` 1..3 (server only); `NeedChip` fragments per exchange (250..1500); `RewardId` item template or negative currency id; `RewardCount` |
| `raw/xml/tempinfos/ArchaeologyBookTemps.xml` | `Type = 2` rows 102..105 | level up rewards: `Collection1` level, `RewardId1/RewardCount1` item, `RewardAppell` title id |
| `raw/xml/tempinfos/UpGradeTempInfos.xml` | `Types = 111`, Ids 1110001..1110005 | `Grades`, `Data` exp per level |

## 7. Persistent state

`archaeology.player_state.exp` from [dig.md](dig.md).

```sql
CREATE TABLE archaeology.item_progress (
  player_id         INTEGER  NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  item_template_id  INTEGER  NOT NULL,
  chip_count        INTEGER  NOT NULL DEFAULT 0 CHECK (chip_count >= 0),
  exchange_count    INTEGER  NOT NULL DEFAULT 0 CHECK (exchange_count >= 0),
  updated_at        TIMESTAMPTZ NOT NULL DEFAULT now(),
  PRIMARY KEY (player_id, item_template_id)
);

CREATE TABLE archaeology.level_reward (
  player_id   INTEGER     NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  level       SMALLINT    NOT NULL CHECK (level BETWEEN 2 AND 5),
  granted_at  TIMESTAMPTZ NOT NULL DEFAULT now(),
  PRIMARY KEY (player_id, level)
);
```

## 8. Backend implementation notes

- `archaeology::collection::handle_exchange` (op 3). Validation: template exists -> row exists with `chip_count >= NeedChip`. Transaction: `chip_count -= NeedChip`, `exchange_count += 1`, grant `RewardId x RewardCount` through the inventory/currency services (bag full: send by mail, assumption). After commit push 298 (single row), 115 or 3 for the reward.
- `archaeology::collection::add_exp(player, amount)` used by digs: update exp, compute old and new level, for each level crossed insert `level_reward` and grant item + title (title service, [medals](../medals/README.md)); push 260 field 8.
- `archaeology::collection::login_push`: 298 with all `item_progress` rows, 260 field 8.
- No timers, no battles.

## 9. Open questions and assumptions

- Exp sources (dig only, or also exchanges) and amounts are not in client data.
- Whether level up rewards are granted directly, by mail, or claimable (no client route exists; assumed direct grant).
- Reward delivery when the bag is full.
- Whether op 2 should resend 298.

## 10. Implementation checklist

- [ ] Screen: `ArchaeologyFrame` exp bar and level tip
- [ ] Screen: map tabs, type groups, item list, "only exchangeable" filter
- [ ] Screen: item detail and exchange button
- [ ] Route R1 op 3 exchange
- [ ] Server message 298 merge semantics (only changed rows after login)
- [ ] Server message 260 field 8
- [ ] Table `archaeology.item_progress`
- [ ] Table `archaeology.level_reward`
- [ ] Template loaders: items, book Type 2, upgrade Types 111
- [ ] Rule: level formula and max level 5
- [ ] Rule: level up reward grant (item + title)
- [ ] Test: exchange refused with insufficient fragments
- [ ] Test: crossing several levels at once grants each reward once
