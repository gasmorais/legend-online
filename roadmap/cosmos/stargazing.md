# Stargazing ("Astronomia"): wishes, star charts, star force

Module `stargazing` of feature `cosmos`. Three tabs on the twelve zodiac signs: "Desejo" (pray with "Fragmento de Céu Estrelado" to fill wish counters, then draw daily rewards), "Carta Celeste" (fill 9 fragments of 12 charts per sign with celestial cards; each chart gives attack, defence, magic attack, magic defence and life) and "Força das Estrelas" (light 45 points per sign with "Fogo das Estrelas" to add a percentage bonus to that sign's charts). All traffic is one opcode pair with an op enum.

Path aliases:

| Alias | File |
|---|---|
| SGM | `decompiled/core_module/scripts/yishi/manager/StarGazingManager.as` |
| SGMOD | `decompiled/core_module/scripts/mvc/module/stargazing/StarGazingModel.as` |
| SPI | `decompiled/core_module/scripts/mvc/module/stargazing/StarPalaceInfo.as` |
| SCI | `decompiled/core_module/scripts/mvc/module/stargazing/StarChartInfo.as` |
| V | `decompiled/m14/scripts/stargazing/` |

## 1. Overview

| Concept | Client | Meaning |
|---|---|---|
| Sign ("palácio") | `StarPalaceInfo.index` 0..11 | "Aries", "Taurus", "Gemini", "Cancer", "Leo", "Virgo", "Libra", "Scorpius", "Sagittarius", "Capricornus", "Aquarius", "Pisces" (`stargazing.starName.text0..11`) |
| Chart ("carta celeste") | `StarChartInfo.mapIndex` 0..11 per sign | 9 fragments in a 3x3 grid; `fragmentChar` = comma list of filled fragment indexes; `openNine` when 9 are filled (`SCI:22-29`) |
| Chart repeat | `repeatTimes` | completions of the chart, shown as lit stars out of `timeCount` (`V/view/StarChartView.as:422-446`) |
| Star force | `totalLightStar` 0..45 per sign | `timeCount = floor(total / 9)` (0..5), `addPrecent = timeCount * 20 + total % 9`, `successRate = 100 - (total % 9) * 10` (`SPI:20-33`) |
| Wish | `starPieceCount` (debris), `starDesire`, `normalWishCount`, `advanceWishCount` | 7 balls = `floor(desire / 100) % 7`, bar = `desire % 100` of 100 (`V/view/StarWishView.as:413-460`) |
| Total bonus | `starChartTotalProperty` | sum of all charts (hero stats) |

Items (`ItemTempInfos.xml`): 8001000 "Fragmento de Céu Estrelado" (SonType 802), 8001001 "Pergaminho de Desejo das Estrelas Básico", 8001002 "Pergaminho de Desejo das Estrelas Avançado", 8001003..8001014 "Carta Celeste da Constelação Aries..Pisces" (SonType 801, `Property1` = sign index, Aries has none = 0), 8001015 "Carta Celeste Geral", 8001016 "Fogo das Estrelas", 8001017 "Atração do Fogo das Estrelas".

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `V/StarGazingFrame.as` | "Astronomia" (`:143`) | tabs wish (0), chart (1), force (2); sends op 0 on creation (`:45`) | archaeology button (`decompiled/m14/scripts/archaeology/ArchaeologyMakeRightView.as:109-113`), `SwitchPageHelp.openStarGazingFrame(tab)` (`decompiled/core_module/scripts/yishi/SwitchPageHelp.as:2488-2496`), using an item: 8001001/8001002 -> tab 0, 8001015 -> tab 1, 8001016/8001017 -> tab 2, sign cards (SonType 801) -> tab 1 with that sign selected (`decompiled/core_module/scripts/cell/view/GoodsItemMenu.as:565-596`, `decompiled/core_module/scripts/cell/mediator/playerbag/PlayerBagCellClickMediator.as:535-555`) | tab from `frameData` (`:140-152`) |
| `V/view/StarPalaceView.as` | | 12 sign buttons; sets `SGMOD.selectStarIndex` | chart and force tabs | (`:30-68`) |
| `V/view/StarWishView.as` | pray, normal wish, advanced wish, coupon toggles | wish tab | tab 0 | debris, normal/advanced counts, desire bar and 7 balls, today's reward lists (site 2: 10 items, site 3: 6 items, by weekday) (`:150-191,236-271,413-460`) |
| `V/view/StarChartView.as` | "Atributos do Fragmento (Bônus da Força das Estrelas)" | charts of the selected sign, 12 pages, use card | tab 1 | totals "Ataque Físico:", "Defesa Física:", "Ataque Mágico:", "Defesa mágica:", "Vida:"; chart stats "Ataque Físico:{0}({1}%)" with `{1}` = `addPrecent`; masks of filled fragments; card counts (`:383-470`) |
| `V/view/StarForceView.as` | "Montagens de cartas celestes: +{0}", "Bônus da Força das Estrelas: {0}%", "Probabilidade de sucesso da Carta Celeste Geral: {0}%" | light points of the selected sign | tab 2 | `timeCount`, `addPrecent`, `successRate` (100 when the 8001017 toggle is on), 9 points, item counts (`:292-355`) |

## 3. Routes (client to server)

All routes: C>S 5188 (0x1444) `C_STARGAZING_OP`, `StargazingOpMsg`:

| Field | Tag | Type | Meaning |
|---|---|---|---|
| `op` | #1 | ENUM `StargazingOp` | 0 OPEN, 1 UPDATE (server only), 2 PRAY, 3 NOMAL_REWARD, 4 SENIOR_REWARD, 5 UPGRADE_STAR, 6 USE_MAP_ITEM (`build/as3/gen/com/road/yishi/proto/stargazing/StargazingOp.ts`) |
| `index` | #2 | INT32 | sign 0..11 (op 5; server echo in op 6) |
| `useItem` | #3 | BOOL | ops 3, 4: pay with the coupon; op 5: use 8001017 for 100% success |
| `mapIndex` | #4 | INT32 | chart 0..11 (server echo in op 6) |
| `fragmentIndex` | #5 | INT32 | fragment 0..8 (server echo in op 6) |
| `mapItemId` | #6 | INT32 | op 6: card item template id |
| `infoMsg` | #7 | `StargazingInfoMsg` | server only |

Senders: `SGM.sendStarGazingRequest(op)` (`SGM:154-160`), `SGM.sendStarGazingWish(op, useItem)` (`SGM:162-169`), `SGM.sendStarGazingForceLittle(index, useItem)` (`SGM:171-179`), `SGM.sendStarGazingChartUseItem(itemId)` (`SGM:181-188`).

| # | Action | UI and client checks | Request | Server effect | Response |
|---|---|---|---|---|---|
| G0 | Open | frame constructor (`V/StarGazingFrame.as:45`) | `op = 0` | none | 4687 op 0 with full `infoMsg` |
| G1 | Pray ("pedir aos deuses") | `_prayBtn` (`V/view/StarWishView.as:283-291`): `starPieceCount <= 0` -> "Fragmentos de Céu Estrelado insuficientes. Não é possível pedir aos deuses." | `op = 2` | debris -1, desire + gain; every 100 desire -> normal count +1; every 7th ball (700) -> senior count +1 (assumption derived from the ball display) | 4687 op 2 with `starDebris`, `starDesire`, counts |
| G2 | Normal wish | `_normalWishBtn` (`:293-303`): `normalWishCount <= 0` and coupon toggle off -> "Desejos normais insuficientes, ou {0} não foi selecionado." Coupon toggle needs 8001001 in bag or "Itens insuficientes. Não é possível realizar esta ação." (`:316-324`) | `op = 3`, `useItem` | consume one normal count or one 8001001; grant one reward from `StargazingDrop` site 2 of today's weekday | 4687 op 3 with counts; bag pushes (inventory) |
| G3 | Advanced wish | `_advanceWishBtn` (`:305-314`): `advanceWishCount <= 0` and coupon off -> "Desejos avançados insuficientes, ou {0} não foi selecionado."; coupon 8001002 | `op = 4`, `useItem` | consume senior count or 8001002; reward from site 3 of today's weekday | 4687 op 4; bag pushes |
| G4 | Light a force point | `_littleStarBtn` (`V/view/StarForceView.as:209-222`): no 8001016 -> "Itens insuficientes..."; `totalLightStar >= 45` -> "Força das estrelas máxima. Não é possível continuar esta ação."; 8001017 toggle requires the item (`:193-207`) | `op = 5`, `index` = sign, `useItem` | consume 1 x 8001016 (and 1 x 8001017 when `useItem`); success chance `successRate` (100 with 8001017); on success `totalLightStar + 1`; recompute bonus | 4687 op 5 with the sign and totals; bag pushes |
| G5 | Use a card | `_useItemBtn` (`V/view/StarChartView.as:267-301`): selected toggle "Carta Celeste Geral" (8001015) or the sign card (SonType 801, `Property1` = sign); count <= 0 -> "Itens insuficientes..."; when already full (general card: every sign full, `SGMOD.palaceAllOpen`; sign card: that sign full, `SPI.chartAllOpen`) confirm with "não perguntar novamente": "As Cartas Celestes não podem ser montadas repetidamente. Continuando a usar os itens eles serão convertidos em fragmentos de céu estrelado." | `op = 6`, `mapItemId` | consume the card; fill one empty fragment (sign card: of that sign; general card: any sign, assumption), when full convert into debris (assumption: amount from `StargazingDrop` site 1, 5/10/20/50); a chart reaching 9 fragments raises `repeatTimes` up to `timeCount` (assumption) | 4687 op 6 with `index`, `mapIndex`, `fragmentIndex` and the updated sign |

## 4. Server messages (server to client)

### S1. 4687 (0x124f) `U_C_STARGAZING_OP`, `StargazingOpMsg`
Receiver `SGM.__starGazingMsgBack` (`SGM:52-152`, listener `SGM:49`). Fields as in section 3; `infoMsg`:

`StargazingInfoMsg`:

| Field | Tag | Type | Rep | Meaning |
|---|---|---|---|---|
| `starDebris` | #1 | INT32 | | debris counter |
| `starDesire` | #2 | INT32 | | desire progress (read only when `starDebris` is present, `SGM:68`; always send both) |
| `nomalRewardCount` | #3 | INT32 | | normal wishes available |
| `seniorRewardCount` | #4 | INT32 | | advanced wishes available; an increase triggers the full 7 ball animation (`isTurnChange`) |
| `totalProperty` | #5 | `stargazing.PropertyMsg` | | sum of all chart stats |
| `zodiacSign` | #6 | `ZodiacSignInfoMsg` | yes | changed signs |

`ZodiacSignInfoMsg`: `index (#1, INT32)` sign; `totalLightStar (#2, INT32)` 0..45; `starMapMsg (#3, StarMapInfoMsg, repeated)` charts. The client replaces the whole chart list of a sign (`SGM:111-127`), so always send all charts of every sign included.

`StarMapInfoMsg`: `mapIndex (#1, INT32)` 0..11; `repeatTimes (#2, INT32)`; `fragmentBitMap (#3, STRING)` comma separated filled fragment indexes, e.g. "0,4,8"; `mapProerty (#4, stargazing.PropertyMsg)` chart stats including the force bonus (must be present, the client dereferences it).

`stargazing.PropertyMsg`: `attack (#1, INT32)`, `defence (#2, INT32)`, `magicAttack (#3, INT32)`, `magicDefence (#4, INT32)`, `live (#5, INT32)`.

Client dispatch after merging (`SGM:132-151`): op 2 with a desire or count change -> `STAR_POWER_CHANGE` (ball animation); op 5 -> `STAR_FORCE_POINT_CHANGE` (point animation); op 6 -> `STAR_CHART_PIECE_CHANGE` with `index`, `mapIndex`, `fragmentIndex` (jumps to that chart page and animates the fragment); any other op -> `STAR_VIEW_DATA_CHANGE`. Op 1 `UPDATE` can be pushed at any time (for example after debris is gained elsewhere) and only refreshes the views.

No error codes: failures should be answered with the unchanged state (any op) so the client re-enables buttons.

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Unlock | archaeology grade >= 3 (max) for item use and `SwitchPageHelp`; message "Ativado quando a Arqueologia atinge o nível máximo." | `decompiled/core_module/scripts/cell/view/GoodsItemMenu.as:567-571,588-592` |
| Signs, charts, fragments | 12 x 12 x 9 | `SGMOD:45-59`, `SPI:6,59-73`, `V/view/StarChartView.as:211-227` |
| Force points | 45 per sign (5 tiers x 9) | `V/view/StarForceView.as:30-32,216` |
| Force bonus | `timeCount * 20 + totalLightStar % 9` percent on that sign's charts | `SPI:25-28` |
| Lighting success | `100 - (totalLightStar % 9) * 10` percent, 100 with 8001017 | `SPI:30-33`, `V/view/StarForceView.as:201-206,303-311` |
| Wish rewards | `StargazingDrop` site 2 (normal, 10 entries) and site 3 (advanced, 6 entries) filtered by `para2` = weekday of server time (`sysCurtime.day`, 0 Sunday) | `V/view/StarWishView.as:161-163,472-475`, `decompiled/core_module/scripts/yishi/datas/templates/cate/StarGazingDropTempCate.as:19-31` |
| Desire display | balls `floor(desire / 100) % 7`, bar `desire % 100` / 100 | `V/view/StarWishView.as:350,418-419,451` |
| Chart stats | not in client templates (assumption: server config per sign and chart; multiplied by `1 + addPrecent / 100`) | |
| Hero stats | `totalProperty` adds attack, defence, magic attack, magic defence, life to the hero | owner [hero](../hero/README.md) |

## 6. Templates

| File | Fields used |
|---|---|
| `StargazingDrop.xml` (116 rows) | `id`, `dropId` (157001..157015), `site` (1 debris amounts, 2 normal wish, 3 advanced wish), `para2` (weekday 0..6), `itemId`, `count`, `isBind`, `appearType`, `validDate`, `isShow` |
| `ItemTempInfos.xml` | 8001000..8001017 (names, `SonType` 800/801/802, `Property1` sign index) |
| chart images | `PathManager.getStarGazingChartUrl(sign, chart)` (`V/view/StarChartView.as:361-368`) |

## 7. Persistent state

```sql
CREATE TABLE cosmos.stargazing_state (
  player_id          BIGINT  PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
  star_debris        INTEGER NOT NULL DEFAULT 0 CHECK (star_debris >= 0),
  star_desire        INTEGER NOT NULL DEFAULT 0 CHECK (star_desire >= 0),
  normal_wish_count  INTEGER NOT NULL DEFAULT 0 CHECK (normal_wish_count >= 0),
  senior_wish_count  INTEGER NOT NULL DEFAULT 0 CHECK (senior_wish_count >= 0)
);

CREATE TABLE cosmos.zodiac_signs (
  player_id          BIGINT   NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  sign_index         SMALLINT NOT NULL CHECK (sign_index BETWEEN 0 AND 11),
  total_light_star   SMALLINT NOT NULL DEFAULT 0 CHECK (total_light_star BETWEEN 0 AND 45),
  PRIMARY KEY (player_id, sign_index)
);

CREATE TABLE cosmos.star_charts (
  player_id      BIGINT   NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  sign_index     SMALLINT NOT NULL CHECK (sign_index BETWEEN 0 AND 11),
  map_index      SMALLINT NOT NULL CHECK (map_index BETWEEN 0 AND 11),
  fragment_mask  SMALLINT NOT NULL DEFAULT 0 CHECK (fragment_mask BETWEEN 0 AND 511),  -- bit i = fragment i filled
  repeat_times   SMALLINT NOT NULL DEFAULT 0 CHECK (repeat_times BETWEEN 0 AND 5),
  PRIMARY KEY (player_id, sign_index, map_index),
  FOREIGN KEY (player_id, sign_index) REFERENCES cosmos.zodiac_signs (player_id, sign_index) ON DELETE CASCADE
);
```

`fragmentBitMap` is rendered from `fragment_mask` as a comma list. Chart stats are computed from server config, not stored.

## 8. Backend implementation notes

| op | Handler |
|---|---|
| 0 | `cosmos::stargazing::handle_open` |
| 2 | `cosmos::stargazing::handle_pray` |
| 3 | `cosmos::stargazing::handle_normal_wish` |
| 4 | `cosmos::stargazing::handle_senior_wish` |
| 5 | `cosmos::stargazing::handle_light_force` |
| 6 | `cosmos::stargazing::handle_use_chart_item` |

- Common validation: archaeology max grade -> op specific state -> item counts via the inventory service (coupons, cards, fire items) -> one transaction (items, state, rewards) -> push bag changes, then 4687 with the same `op` -> recompute hero stats when chart stats changed.
- Op 6 random fragment selection must exclude filled fragments; when the target (sign or all signs) is full, convert the card into debris and answer with op 1 or op 6 without fragment fields (assumption).
- Rewards for ops 3/4: weighted or uniform draw from the day's site list (assumption: uniform, `appearType` 4 suggests a single random pick).
- Debris acquisition (item 8001000 and other sources) is outside this module; whoever grants debris must push 4687 op 1.
- No timers (the reward list rotates by weekday only).

## 9. Open questions and assumptions

- Assumption: desire gained per pray and the 100/700 thresholds for wish counters.
- Assumption: how 8001000 items convert into the `starDebris` counter (the item has no client use handler).
- Assumption: chart repeat semantics (`repeatTimes` up to `timeCount`) and whether a complete chart resets its mask for the next repeat.
- Assumption: chart base stats per sign/chart (no template in the client).
- Assumption: general card picks a random sign with free fragments.

## 10. Implementation checklist

- [ ] Screens (client ready): `StarGazingFrame`, `StarPalaceView`, `StarWishView`, `StarChartView`, `StarForceView`.
- [ ] Tables `cosmos.stargazing_state`, `cosmos.zodiac_signs`, `cosmos.star_charts`.
- [ ] Route 5188 op 0 open and full 4687 snapshot.
- [ ] Route 5188 op 2 pray; ops 3, 4 wishes with coupons and weekday rewards.
- [ ] Route 5188 op 5 force lighting with success rate and 8001017.
- [ ] Route 5188 op 6 card use with fragment echo and debris conversion.
- [ ] Push 4687 op 1 when debris changes elsewhere.
- [ ] Hero stat integration of `totalProperty`.
- [ ] Tests: pray without debris rejected; normal wish with coupon consumes coupon not count; reward list matches weekday; lighting at 45 rejected; 8001017 forces success; card fills a free fragment and echoes indexes; full sign converts card to debris; every 4687 includes all charts of each sent sign.
