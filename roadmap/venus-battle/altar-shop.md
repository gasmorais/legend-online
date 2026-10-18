# Venus battle: altar shop ("Bênção de Pontos")

Module `venus_battle::altar_shop`. Prefixes as in [README.md](README.md).

## 1. Overview

After every Venus battle the team earns blessing points (`altarScore`, "Pontos de Bênção"). Inside the room the altar shop sells two kinds of goods for these points: score multipliers for the next battle (pseudo template ids -1 and -2) and battle skills ("Escolha do Destino", "Proteção do Altar", "Retorno do Altar", "Contra-ataque do Altar") that appear as trial props in battle 315. Each good has a holding limit.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `matelords.room.MatelordsDemonShopFrame` | Bênção de Pontos | 2 tabs: items (`templateId < 0`) and skills (`templateId > 0`), 4 rows each, "Bênção de Pontos:  {0}" | room right panel altar button -> controller `matelords` openType 3 (`M9/matelords/room/MatelordsRoomRightView.as:227-231`; `CM/mvc/controler/MatelordsController.as:28-29`) | 365 list (`M9/matelords/room/MatelordsDemonShopFrame.as:40-124`; `CM/mvc/module/matelords/MatelordsModel.as:59-75`) |
| `matelords.room.MatelordsDemonShopItem` | | icon, name, description, "Consumir: {0}" (price), "Contém: {0}" (owned count), buy button | frame | items -1 "Tesouro de Vitória", -2 "Tesouro de Conquista" from LANG; skills from `TPL/SkillTempInfos.xml` (`M9/matelords/room/MatelordsDemonShopItem.as:64-105`) |

## 3. Routes (client to server)

Opcode **C to S 9611 (0x258B) `C_MATE_SKILL_SHOP`** (PTT:1495 "新永恒之战祭坛数据请求"), body `AltarShopListMsg`: `op` (#1, INT32: 1 DEMON_LIST_REQUEST, 2 DEMON_ITEM_BUY, `CM/yishi/manager/MatelordsManager.as:23-25`), `altarScore` (#2, INT32, not sent), `templateId` (#3, INT32, good to buy), `skillTempId` (#4, INT32, not sent), `info` (#5, repeated, not sent). Sender `MatelordsManager.sendRequestDemoOp(op, templateId)` (`MatelordsManager.as:345-352`).

| # | Action | UI control | Client sender | Client checks | Request | Responses |
|---|---|---|---|---|---|---|
| D1 | Open the shop | frame constructor | `MatelordsDemonShopFrame()` (`MatelordsDemonShopFrame.as:40-47`) | none | `{op:1}` | 365 |
| D2 | Buy | item buy button | `MatelordsDemonShopItem.__buyHandler` -> `confirmBack` (`MatelordsDemonShopItem.as:133-164`) | `leftCount >= maxCount` -> `MatelordsDemonShopItem.buyBtn.alert` "No momento, você já ultrapassou o limite, favor usá-los(as)!"; `price > altarScore` -> `noScore.alert` "Pontos de Bênção insuficiente, não é possível comprar"; confirmation `BuyConfirm.content` "Deseja consumir {0} pontos de bênção para comprar {1}?" | `{op:2, templateId}` | 365 with new `altarScore` and counts |

## 4. Server messages (server to client)

### 365 (0x016D) `U_C_MATE_SKILL_SHOP`, `AltarShopListMsg`

Receiver `MatelordsManager.__matelordsDemonShopHandler` (`MatelordsManager.as:68,297-320`). If `altarScore` is present it updates the model and fires `DEMON_SCORE_UPDATE` (room right panel text). `info` rebuilds the list (sorted by `templateId`), fires `DEMON_LIST_UPDATE`.

`AltarShopInfoMsg`: `templateId` (#1, INT32: -1, -2 or a skill id), `price` (#2, INT32, blessing points), `leftCount` (#3, INT32, count currently held, shown as "Contém"), `maxCount` (#4, INT32, holding limit), `skillTempId` (#5, INT32, not read).

When: response to D1 and D2; (A) also after a battle when held counts change.

## 5. Rules and formulas

| # | Rule | Source |
|---|---|---|
| A1 | Goods and prices from `Mate_Shop` = `41001000,30,1,2\|41001005,30,1,2\|41001006,30,1,2\|41001007,30,1,2` ("模版ID,价格,最大数量,类型(2为技能)"): 4 skills, 30 points, max 1 each. The two items -1/-2 are not in the config (A: server constants; price and max unknown) | `TPL/ConfigInfos.xml` |
| A2 | -1 "Tesouro de Vitória": on win in the next battle the team gains +0.5x points, stackable. -2 "Tesouro de Conquista": next battle +0.5x points regardless of result, stackable. Manager constants `REDUCE_PRECENT1 = 10`, `REDUCE_PRECENT2 = 5`, `SHOP_ITEM1 = -1`, `SHOP_ITEM2 = -2` (A: related decay percentages, unused by the client) | LANG `MatelordsDemonShopItem.itemDesc.text1/2`; `MatelordsManager.as:27-33` |
| A3 | Skills are consumed in battle as trial props (`isMateLords`), one use per held count (A) | `CM/battle/view/ui/SkillItemListView.as:96` |
| A4 | `altarScore` is per team or per player (A: per player, since each partner sees own value) | |

Skills (`TPL/SkillTempInfos.xml`): 41001000 "Escolha do Destino" (random: +500% next attack, +2000 awakening, forget 2 skills, confusion 3 turns; uses 41001001..41001004), 41001005 "Proteção do Altar" (all resistances +200% for 3 turns), 41001006 "Retorno do Altar" (next main skill without cooldown, 1 turn), 41001007 "Contra-ataque do Altar" (reflect 80% damage, 1 turn).

## 6. Templates

| File | Record | Fields |
|---|---|---|
| `TPL/ConfigInfos.xml` `Mate_Shop` | altar catalog | template id, price, max count, type |
| `TPL/SkillTempInfos.xml` | skill goods | `TemplateId`, `TemplateName`, `Icons`, `Description`, `BufferIds` |

## 7. Persistent state

```sql
CREATE TABLE venus_battle.altar_wallet (
  player_id       BIGINT NOT NULL REFERENCES player.players(player_id),
  season_id       integer NOT NULL,
  altar_score     integer NOT NULL DEFAULT 0 CHECK (altar_score >= 0),
  PRIMARY KEY (player_id, season_id)
);

CREATE TABLE venus_battle.altar_holding (
  player_id       BIGINT NOT NULL REFERENCES player.players(player_id),
  season_id       integer NOT NULL,
  good_id         integer NOT NULL,                    -- -1, -2 or skill template id
  held_count      smallint NOT NULL DEFAULT 0 CHECK (held_count >= 0),
  PRIMARY KEY (player_id, season_id, good_id)
);
```

## 8. Backend implementation notes

- `venus_battle::altar_shop::handle_list` (9611 op 1): build 365 from the catalog (config + constants for -1/-2) and the player's holdings and wallet.
- `venus_battle::altar_shop::handle_buy` (9611 op 2): validate good exists, held < max, score >= price; transaction debit and increment; send 365. For -1/-2 also add to `team_day_state` multipliers ([room.md](room.md)).
- After each battle: credit altar points (A amount), decrement used skills and consumed multipliers, send 365 if the shop is open (A).

## 9. Open questions and assumptions

- (A) Price and limits of -1/-2; altar points per battle; whether score is per player or per team.

## 10. Implementation checklist

- [ ] Catalog from `Mate_Shop` plus -1/-2
- [ ] 9611 op 1 and op 2 -> 365
- [ ] Holdings consumed in battle 315 as trial props
- [ ] Tables `altar_wallet`, `altar_holding`
- [ ] Tests: limit reached, insufficient points, stacking multipliers
