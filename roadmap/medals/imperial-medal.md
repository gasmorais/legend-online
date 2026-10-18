# Imperial medal ("Desenvolver Medalhas")

Feature `medals`, module `imperial-medal`. Proto package `medal`. Chinese protocol comment: "圣龙伯爵勋章" (Holy Dragon Earl medal), `CM/yishi/datas/consant/ProtocolTypeTable.as:567-568, 1357`.

Conventions: see [README.md](README.md). `CM` = `core_module/scripts`.

---

## 1. Overview

- **The item.** "Medalha do Império Earl Nv.1" .. "Nv.10" (items 3010001..3010010, MasterType 3, SonType 301, Profile 5) is equipped in the honor slot (`HonorCell`, bag type 3). Each level is a different item template with higher stats and a suite skill "Fúria de batalha com o jogador +15" (skill 4017).
- **Progress.** The player has a medal grade (1..10), medal GP and an expiry date, all kept on the hero (`ThaneInfo.medalGrades`, `medalGp`, `medalInvalidTime`). They are pushed by 4717.
- **Feed ("alimentar").** While GP is below the next level requirement, the player spends N arena medals (currency type 8, item 208001 "Medalhas") to add GP.
- **Advance ("avanço").** When GP reaches the requirement, the feed button is replaced by the advance button. The advance needs honor (geste) at least `ActiveObject` of the next level and consumes `TemplateName` units of item 208041 "Bastão do Império" (client text "Ceptro Imperial").
- **Validity.** The medal expires. Two renew buttons spend arena medals: `Property1` for 1 day, `Property2` for 15 days (both read from the current level item).
- **Help text** (`armyII.viewII.equip.MedalFrame.helpContent`): the medal can be developed continuously by consuming medals; when development hits the limit and honor matches, "Ceptro Imperial" advances it; advancing raises the properties; only one can be exchanged, and it cannot be sold or discarded.

---

## 2. Screens

| Class (file) | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `armyII.viewII.equip.MedalFrame` (`m5/scripts/armyII/viewII/equip/MedalFrame.as`), 460x606, style `army.MedalFrame` | "Desenvolver Medalhas" (`armyII.viewII.equip.MedalFrame.TitleTxt`) | Feed, advance, renew | Up button on `HonorCell` (`CM/cell/view/playerequip/HonorCell.as:61-64`) → `ArmyControler.openMedalFrame` (`CM/mvc/controler/ArmyControler.as:299-303`) | Current level icon and "Nv.{0}" (`public.level2`); next level icon; two `MedalAttributeView` columns (current stats, next stats with +delta); GP bar `medalGp / next.Data` (percent frame); honor requirement `next.ActiveObject` (red frame 1 if `thane.honer < ActiveObject`, green frame 2 otherwise); cost `next.TemplateName` (number of 208041); owned count (arena medals when feeding, 208041 when advancing); "Para avançar precisa de Consumir o ceptro imperial: {0}" (`TipsTxt03`); validity remaining time or "Expirado" (`EquipTip.timeStr02`); max level badge at level 10 (`MedalFrame.as:355-456`) |
| `armyII.viewII.equip.MedalAttributeView` (`m5/scripts/armyII/viewII/equip/MedalAttributeView.as:124-199`) | none | Stat list of an item template | `MedalFrame` | First 6 non-zero stats in the order Power, Agility, Intellect, Physique, Captain, Attack, MagicAttack, Defence, MagicDefence, Parry, Live, ForceHit, Conat, Strength, Tenacity; line 7 is the name of the suite skill (`SuiteTempInfos.Property1` → `SkillTempInfos.TemplateName`) |
| `HonorCell` (`CM/cell/view/playerequip/HonorCell.as`) | none | Honor equip slot with an up arrow (`MarryRingView.upBtn` style) | Player info equipment panel (`m5/scripts/playerinfo/view/EquipInfoView.as:304-307`), dragon talker equip view (`m5/scripts/dragontalker/view/DragonTalkerEquipView.as:92`) | Arrow visible when the item belongs to the current player and its template is in Upgrade Types 43 (`HonorCell.as:34-59`) |
| `EquipTip` (`CM/yishi/view/tips/goods/EquipTip.as:276-330`) | none | Item tip of the medal | Hover | Intended to show the medal validity from `medalInvalidTime`; see the bug in §9 |
| `army.MedalFrame.HelpFrame` (`SimpleHelpFrame`) | help | Help text | Help button (`MedalFrame.as:291-296`) | `armyII.viewII.equip.MedalFrame.helpContent` |

The frame re-renders on `ThaneInfo` events `MEDALGRADE_UPDATE`, `MEDALGP_UPDATE`, `MEDALINVALIDTIME_UPDATE` (`MedalFrame.as:254-256`, dispatched by `CM/yishi/datas/playerinfo/ThaneInfo.as:1098-1108`) and on bag `UPDATE_BAG` / `DELETE_BAG` of an item with SonType 321 (arena medal family) or template 208041 (`MedalFrame.as:257-258, 277-284`).

---

## 3. Routes (client to server)

All five operations go to one opcode. Sender: `SocketSendManager.sendMedalOp(opType, cost = 0)` (`CM/yishi/service/managers/SocketSendManager.as:627-634`).

Route: client → server **8838 (0x2286) C_MEDAL_OP**, body `medal.MedalOpMsg`:

| Field | Tag | Type | Repeated | Meaning in the request |
|---|---|---|---|---|
| `opType` | #1 | INT32 | no | 1 feed, 2 feed advanced (never sent), 3 advance, 4 renew 1 day, 5 renew 15 days (`MedalFrame.as:103-111`) |
| `result` | #2 | INT32 | no | not set by the client |
| `cost` | #3 | INT32 | no | feed only: number of arena medals to spend. `sendMedalOp` always assigns it, so tag #3 is always on the wire, with value 0 for ops 3/4/5 (`SocketSendManager.as:632`; `MedalOpMsg.writeToBuffer` writes a field only when its has-flag is set, `build/as3/gen/com/road/yishi/proto/medal/MedalOpMsg.ts:73-93`) |
| `param` | #4 | STRING | no | not set by the client |

| # | UI control | Client sender (file:line) | Client checks, in order | Request | Expected response |
|---|---|---|---|---|---|
| M1 | "Alimentar" button `army.MedalFrame.FeedBtn` (visible only while `medalGp < next.Data` and a next level exists) | `MedalFrame.__feedBtnClickHandler` (`m5/scripts/armyII/viewII/equip/MedalFrame.as:332-343`) | 1. Input box value is clamped on every change to `[1, arenaMedal.amount]`; if the player owns 0, the box becomes "0" (`MedalFrame.as:298-315`); 2. value 0 → tip "Por favor introduza o número a ser consumido, no mínimo 1" (`TipsTxt01`) and no send | `{opType=1, cost=N}` | 4715 `{opType=1, result}`, then 4717 with the new GP; currency refresh for arena medals (currency feature) |
| M2 | "Avançar" button `army.MedalFrame.UpgradeBtn` (visible only while `medalGp >= next.Data`) | `__upgradeBtnClickHandler` (`MedalFrame.as:327-330`) | none. The client does **not** check honor (`thane.honer >= next.ActiveObject`) nor the 208041 count; it only colors the honor text | `{opType=3}` | 4715 `{opType=3, result}`, 4717 with new grade and GP, bag update replacing the equipped item 30100NN by 30100NN+1 and removing the 208041 units *(assumption on the item swap, see §9)* |
| M3 | Renew 1 day `army.MedalFrame.RenewalBtn`, tip "Consumir{0}Medalha, Válido após {1} dia" with `{0}=current.Property1`, `{1}=1` | `__renewalBtnClickHandler` (`MedalFrame.as:322-325`); tip set at `:389-391` | none (no cost check) | `{opType=4}` | 4715 `{opType=4, result}`, 4717 with new `invalidTime`, arena medal currency refresh |
| M4 | Renew 15 days `army.MedalFrame.RenewalAdvBtn`, tip with `{0}=current.Property2`, `{1}=15` | `__renewalAdvBtnClickHandler` (`MedalFrame.as:317-320`); tip at `:390-392` | none | `{opType=5}` | same as M3 |
| M5 | Up arrow on `HonorCell` | `HonorCell.__upBtnClickHandler` (`CM/cell/view/playerequip/HonorCell.as:61-64`) | arrow only shown for own medal templates (`:34-59`) | none (opens the frame locally) | none |
| M6 | Help, close | client only | none | none | none |

`OP_FEED_ADV = 2` is declared (`MedalFrame.as:105`) but no control sends it. The server may reject it with result 1.

---

## 4. Server messages (server to client)

| Opcode | Name | Message, fields (tag, type) | Client receiver (file:line) | When to send | Client reaction |
|---|---|---|---|---|---|
| 4717 (0x126d) | U_C_MEDAL_INFO | `medal.MedalInfoMsg`: `grade (#1, INT32)` medal level 1..10, written to `thane.medalGrades`; `gp (#2, INT64)` medal GP accumulated toward the next level, `thane.medalGp`; `tempId (#3, INT32)` medal item template, **not read**; `invalidTime (#4, STRING "YYYY-MM-DD hh:mm:ss")` expiry instant, parsed to seconds into `thane.medalInvalidTime` | `BaseManager.__medalInfoHandler` (`CM/yishi/manager/BaseManager.as:333, 993-1003`) | At login (the frame has no open request, so the state must already be on the client) *(assumption: also whenever the medal item is first obtained)*; after every successful op 1/3/4/5 | Fires the three `ThaneInfo` events; `MedalFrame` and `EquipTip` re-render. `ThaneInfo.medalInvalidTime` getter returns 0 when the instant is in the past (`ThaneInfo.as:645-652`), so the frame shows "Expirado". `invalidTime` must always be a parseable date string: an empty string makes `DateFormatter.parse` fail *(assumption: send a past date such as "2000-01-01 00:00:00" when there is no validity)* |
| 4715 (0x126b) | U_C_MEDAL_OP | `medal.MedalOpMsg`: `opType (#1, INT32)` echo of the request; `result (#2, INT32)` 0 success, non-zero failure; `cost (#3, INT32)` *(assumption: amount actually spent)*; `param (#4, STRING)` unused | `BaseManager.__medalOpHandler` (`BaseManager.as:332, 1005-1016`) | Response to every 8838 | **No visible effect**: the handler only tests `result != 0` and `result == 1` with empty bodies. Error feedback must come from a generic server message tip (system message channel, core feature) *(assumption)*. Success feedback is the 4717 refresh |
| bag / currency updates | inventory and currency opcodes | see [../inventory/README.md](../inventory/README.md), [../currency/README.md](../currency/README.md) | `GoodsManager` `UPDATE_BAG` / `DELETE_BAG`, `PlayerCurrencyManager` (currency type 8 → `currencyInfo.arenaMedal`, `CM/managers/PlayerCurrencyManager.as:220-225`) | After feed and renew (arena medals), advance (208041 removed, medal item swapped) | Frame refresh (`MedalFrame.as:277-284`) |

Proposed result codes *(assumption, the client does not distinguish them)*: 0 ok; 1 invalid op or no medal equipped; 2 not enough arena medals; 3 GP below requirement; 4 honor below requirement; 5 not enough 208041; 6 already max level; 7 medal expired (if advancing an expired medal is forbidden).

---

## 5. Rules and formulas

Level table: `raw/xml/tempinfos/UpGradeTempInfos.xml` Types 43, read by `TempleteManager.getTemplateByLevelAndType(grade, 43)` (`MedalFrame.as:360-361`).

| Grade | Upgrade row Id | Item TemplateId | `Data` = GP required to reach this grade | `ActiveObject` = honor (geste) required | `TemplateName` = 208041 consumed to reach this grade |
|---|---|---|---|---|---|
| 1 | 40101 | 3010001 | 0 | 450000 | 0 |
| 2 | 40102 | 3010002 | 15000 | 530000 | 400 |
| 3 | 40103 | 3010003 | 27000 | 674000 | 800 |
| 4 | 40104 | 3010004 | 48000 | 930000 | 1600 |
| 5 | 40105 | 3010005 | 85500 | 1386000 | 3200 |
| 6 | 40106 | 3010006 | 153000 | 2202000 | 6400 |
| 7 | 40107 | 3010007 | 274500 | 3666000 | 12800 |
| 8 | 40108 | 3010008 | 493500 | 6298000 | 25600 |
| 9 | 40109 | 3010009 | 888000 | 11034000 | 51200 |
| 10 | 40110 | 3010010 | 1597500 | 19554000 | 102400 |

Renew costs and stats (`raw/xml/tempinfos/ItemTempInfos.xml`):

| Item | Physique | Parry | ForceHit | Conat | Strength | Tenacity | SuiteId | Renew 1 day (`Property1`) | Renew 15 days (`Property2`) |
|---|---|---|---|---|---|---|---|---|---|
| 3010001 | 520 | 830 | 880 | 320 | 5560 | 2530 | 423 | 150 | 1500 |
| 3010002 | 680 | 980 | 970 | 340 | 5800 | 2820 | 424 | 200 | 2000 |
| 3010003 | 880 | 1160 | 1070 | 360 | 6040 | 3120 | 425 | 250 | 2500 |
| 3010004 | 1140 | 1370 | 1180 | 380 | 6290 | 3430 | 426 | 300 | 3000 |
| 3010005 | 1480 | 1620 | 1300 | 400 | 6550 | 3770 | 427 | 350 | 3500 |
| 3010006 | 1910 | 1920 | 1430 | 420 | 6820 | 4130 | 428 | 400 | 4000 |
| 3010007 | 2470 | 2270 | 1580 | 440 | 7100 | 4500 | 429 | 450 | 4500 |
| 3010008 | 3190 | 2680 | 1740 | 460 | 7390 | 4910 | 430 | 500 | 5000 |
| 3010009 | 4120 | 3170 | 1920 | 500 | 7690 | 5120 | 431 | 550 | 5500 |
| 3010010 | 5320 | 3750 | 2120 | 540 | 8000 | 5340 | 427 | 600 | 6000 |

All suites 423..431 have `Property1 = 4017` ("Fúria de batalha com o jogador +15", `SuiteTempInfos.xml`, `SkillTempInfos.xml`). Item 3010010 points to suite 427 (data quirk, same skill).

Rules:
- **Feed** (op 1): precondition `grade < 10` and `gp < Data(grade+1)`; `1 <= cost <= arenaMedal.amount`; effect `arenaMedal -= cost`, `gp += cost` *(assumption: 1 medal = 1 GP; no rate is visible in the client)*. Whether GP may exceed `Data(grade+1)` is not visible; recommended: cap the accepted cost at `Data(grade+1) - gp` *(assumption)*.
- **Advance** (op 3): precondition `grade < 10`, `gp >= Data(grade+1)`, `honor >= ActiveObject(grade+1)`, `count(208041) >= int(TemplateName(grade+1))`; effect: consume 208041, `grade += 1`, `gp -= Data(grade+1)` *(assumption: the next threshold is per level, since the frame compares raw `gp` with `Data` and the thresholds grow; resetting to the excess keeps the bar at 0% after an advance)*, swap the equipped item template to the new level *(assumption)*. Honor is checked, not consumed (help text: honor "estar de acordo com o valor").
- **Renew** (ops 4 and 5): cost from the **current** level item (`MedalFrame.as:389-392`): `Property1` arena medals for +1 day, `Property2` for +15 days. New expiry = `max(now, invalid_at) + days` *(assumption)*.
- **Expiry**: when `now >= invalid_at`, the medal stops granting stats and suite skill *(assumption; the client only displays "Expirado")*. The item itself stays equipped (it cannot be sold or discarded, help text).
- **Acquisition**: item 3010001 is bought in the honor shop (`ShopTempInfos.xml` Id 30034, ShopType 3, Honor 6000, NeedGeste 450000; also ShopType 1020/1021 Score 6000). "Only one can be exchanged" (help text): the shop must refuse a second purchase. On first equip or purchase, create the medal state with grade 1, gp 0 and an initial validity *(assumption: initial validity unknown, propose 0 days so the player renews immediately, or ShopTempInfo.ValidDate when non-zero)*.
- Item 208041 "Bastão do Império" (MaxCount 9999), source "Batalha do Império" plus shops (ShopType 10 LordsScore 20/10, ShopType 13 CrossGuildScore 5).
- Honor (geste) is `ThaneInfo.honer`, filled from the hero message `geste` (`CM/com/road/pb/helper/army/ThaneInfoHelper.as:43`).

---

## 6. Templates

| File | Records used | Fields and meaning |
|---|---|---|
| `raw/xml/tempinfos/UpGradeTempInfos.xml` | `Types="43"` (10 rows) | `Grades` medal level; `TemplateId` item template of that level; `Data` GP required to reach the level; `ActiveObject` honor required; `TemplateName` count of 208041 to reach the level (numeric string) |
| `raw/xml/tempinfos/UpGradeTempInfos.xml` | `Types="40"` (40 rows, all TemplateId 0) | Wrongly used by `EquipTip.isCanUpdateMedal` (§9). Not part of this feature |
| `raw/xml/tempinfos/ItemTempInfos.xml` | 3010001..3010010 | Stats (`Physique`, `Parry`, `ForceHit`, `Conat`, `Strength`, `Tenacity`), `SuiteId`, `Property1` renew cost 1 day, `Property2` renew cost 15 days, `TemplateName` "Medalha do Império Earl Nv.N" |
| `raw/xml/tempinfos/ItemTempInfos.xml` | 208041 | "Bastão do Império", advance material |
| `raw/xml/tempinfos/ItemTempInfos.xml` | 208001 (SonType 321) | "Medalhas", the arena medal (currency type 8) *(assumption: currency type 8 maps to 208001)* |
| `raw/xml/tempinfos/SuiteTempInfos.xml` | 423..431 | `Property1` = suite skill id 4017 |
| `raw/xml/tempinfos/SkillTempInfos.xml` | 4017 | Suite skill name shown on line 7 of `MedalAttributeView` |
| `raw/xml/tempinfos/ShopTempInfos.xml` | ItemId 3010001, 208041 | Acquisition (shops feature) |

---

## 7. Persistent state (PostgreSQL, schema `medals`)

```sql
CREATE SCHEMA IF NOT EXISTS medals;

CREATE TABLE medals.imperial_medals (
  player_id      BIGINT     PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
  grade          smallint    NOT NULL DEFAULT 1 CHECK (grade BETWEEN 1 AND 10),
  gp             bigint      NOT NULL DEFAULT 0 CHECK (gp >= 0),
  invalid_at     timestamptz,                 -- NULL or past = expired
  created_at     timestamptz NOT NULL DEFAULT now(),
  updated_at     timestamptz NOT NULL DEFAULT now()
);
CREATE INDEX imperial_medals_invalid_at ON medals.imperial_medals (invalid_at);

CREATE TABLE medals.imperial_medal_log (
  id             bigserial   PRIMARY KEY,
  player_id      BIGINT     NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  op_type        smallint    NOT NULL CHECK (op_type IN (1, 3, 4, 5)),
  arena_medals_spent integer NOT NULL DEFAULT 0 CHECK (arena_medals_spent >= 0),
  scepters_spent integer     NOT NULL DEFAULT 0 CHECK (scepters_spent >= 0),
  grade_before   smallint    NOT NULL,
  grade_after    smallint    NOT NULL,
  gp_after       bigint      NOT NULL,
  invalid_at_after timestamptz,
  created_at     timestamptz NOT NULL DEFAULT now()
);
CREATE INDEX imperial_medal_log_player ON medals.imperial_medal_log (player_id, created_at DESC);
```

The equipped item row, the arena medal balance and the 208041 stack live in the inventory and currency schemas; this module only debits them in the same transaction.

---

## 8. Backend implementation notes

| Handler | Route | Validation order | Transaction and pushes |
|---|---|---|---|
| `medals::imperial_medal::handle_feed` | 8838 opType 1 | medal row exists and an imperial medal is equipped → `grade < 10` → `gp < Data(grade+1)` → `cost >= 1` → `arenaMedal >= cost` | One tx: debit currency type 8, `gp += cost` (capped, §5), log. After commit: 4715 `{1, 0, cost}`, 4717, currency push |
| `medals::imperial_medal::handle_upgrade` | 8838 opType 3 | medal equipped → `grade < 10` → `gp >= Data(grade+1)` → `honor >= ActiveObject(grade+1)` → `count(208041) >= TemplateName(grade+1)` | One tx: remove 208041, grade+1, gp adjust, swap the equipped item template to `TemplateId(grade+1)` keeping position, binding and validity, log. After commit: 4715, 4717, bag pushes, hero stat/fight power recalculation push (hero feature) |
| `medals::imperial_medal::handle_renew` | 8838 opType 4 / 5 | medal equipped → `arenaMedal >= Property1` (op 4) or `Property2` (op 5) of the current item | One tx: debit, `invalid_at = greatest(now, invalid_at) + 1 or 15 days`, log. After commit: 4715, 4717, currency push; stat recalculation if it was expired |
| `medals::imperial_medal::handle_feed_advanced` | 8838 opType 2 | always reject | 4715 `{2, 1}` |
| `medals::imperial_medal::send_info` | login hook | none | 4717 `{grade, gp, tempId = current item, invalidTime}`; skip or send grade 1 / gp 0 when the player has no medal *(assumption)* |

- Stat calculator (hero feature): include the medal item stats and suite skill 4017 only while `invalid_at > now`.
- Scheduled job `medals::imperial_medal::tick_expiry` (every minute or lazily at login and on stat recalculation): when a medal of an online player crosses `invalid_at`, recalculate stats and push the hero refresh *(assumption)*.
- No battle is started by this module. No push to other players.
- Serialize per player (row lock on `imperial_medals`) to avoid double spending on fast clicks; the client has no cooldown.

---

## 9. Open questions and assumptions

- *(assumption)* Feed rate 1 arena medal = 1 GP. Thresholds (15000..1597500) suggest a 1:1 rate against medals earned in the arena, but nothing in the client proves it.
- *(assumption)* GP behaviour on advance (reset to excess vs cumulative). The frame compares raw `gp` with the next row `Data`; the reset model is consistent with a growing per-level requirement.
- *(assumption)* Advance swaps the equipped item to the next template. Evidence: each grade has its own TemplateId, `HonorCell` shows the arrow only for templates in Types 43, and `MedalFrame` reloads on bag updates.
- *(assumption)* Arena medal = currency type 8 = item 208001. The frame reads `PlayerCurrencyManager.currencyInfo.arenaMedal` (`MedalFrame.as:301, 364`), and the bag listener watches SonType 321 (the 208001/208080/208081 family).
- *(assumption)* Initial validity when the medal is bought.
- *(assumption)* Error reporting: 4715 errors are silent in the client; use the generic message tip.
- **Client bug:** `EquipTip.isCanUpdateMedal` (`CM/yishi/view/tips/goods/EquipTip.as:376-390`) looks in Upgrade Types **40**, whose rows all have TemplateId 0, so the medal tip never shows `medalInvalidTime`; it falls back to the item `leftTime`/`validDate`. Server-side, keeping the item `validDate`/`leftTime` consistent with `invalid_at` makes the tip correct anyway.
- `MedalInfoMsg.tempId (#3)` and `MedalOpMsg.param (#4)` are never read by the client.
- The frame is in `CASTLE_BUIDING_GROUP`/`MAIN_TOOLS_GROUP`; no scene restriction exists.

---

## 10. Implementation checklist

**Screens (existing client, verify against the backend):**
- [ ] `MedalFrame`: feed, advance, renew 1 day, renew 15 days, help, max-level state, expired state
- [ ] `MedalAttributeView` current and next columns with deltas and suite skill name
- [ ] `HonorCell` up arrow in player info and dragon talker views
- [ ] `EquipTip` validity line (consistent item validity, see §9)

**Routes:**
- [ ] 8838 opType 1 feed
- [ ] 8838 opType 3 advance
- [ ] 8838 opType 4 renew 1 day
- [ ] 8838 opType 5 renew 15 days
- [ ] 8838 opType 2 rejected

**Server messages:**
- [ ] 4715 response with `opType` echo and `result`
- [ ] 4717 at login and after every successful op, valid `invalidTime` string
- [ ] Bag and currency pushes after each op
- [ ] Hero stat refresh after advance, renew of an expired medal and expiry

**Tables:**
- [ ] `medals.imperial_medals`
- [ ] `medals.imperial_medal_log`

**Rules and templates:**
- [ ] Load `UpGradeTempInfos` Types 43, items 3010001..3010010, suites 423..431, skill 4017
- [ ] Feed cap and rate, advance requirements (GP, honor, 208041), renew costs from current item
- [ ] Expiry disables stats and suite skill
- [ ] Single medal per player at purchase (shops)

**Tests:**
- [ ] Feed with 0, with more than owned, at GP cap, at grade 10
- [ ] Advance with low honor, low 208041, exact thresholds, grade 9 → 10, at grade 10
- [ ] Renew from expired and from active, both durations, insufficient medals
- [ ] Concurrent double feed does not overspend
- [ ] Login push renders frame values correctly (GP bar, honor color, costs)
