# Theseus tower ("Torre de Teseus")

Area: Theseus PvE, module `tower`. A single-player tower of **100 stages** (`TheseusTowerTmpls.xml`). The player fights the next stage in battleType **3913**, or sweeps ("Bot") the highest cleared stage. Both consume one "tentativa de ganhos" (reward attempt) from a weekly free pool or from permanent bought attempts.

Conventions:
- Paths are relative to `decompiled/` unless they start with `raw/`, `protocol/`, `index/`, `docs/` or `build/`.
- `CM` = `core_module/scripts`. `T11` = `m11/scripts/thessTower`.
- Opcode names come from `protocol/opcodes.csv`. Send codes were also checked in `build/as3/gen/yishi/datas/consant/ProtocolType.ts:751`. Proto tags were checked against the AS3 `writeToBuffer`.
- *(assumption)* marks anything the client does not prove.
- No HTTP servlet or AMF call is involved; everything goes over the binary socket.

Related docs:
- `docs/battle/server-engine.md` §9: the `battle` rule object.
- `docs/battle/rules.md` row 3913 (`THESEUS_TOWER`) and §7 exit table (`BRH:325-327`, `:514-517`).
- `docs/mechanics/world_progression.md` §6.2 (tower template summary).
- Sibling module: [box.md](box.md) ("Desafio de Teseus").

---

## 1. Overview

- **What the player does.**
  - Opens "Torre de Teseus" from the NPC "Eliza, chefe da Zona Proibida" on the Reino do Céu (space map 10000), dialog option **165** "Torre de Teseus".
  - Sees 4 stage cards ("Fase {0}") of the current page, the first-clear reward of the selected stage ("Prêmio Comum") and the sweep reward ("Prêmio de Bot").
  - **Desafiar** (fight) is enabled only on stage `passLevel + 1`. A win raises `passLevel` and grants the stage `FirstRewards`.
  - **Bot** (sweep) is enabled only on stage `passLevel`. It grants `SweepRewards` plus a roll of `SweepRandom`.
  - Each fight or sweep costs 1 reward attempt (help item 1).
  - Free attempts refill every Monday at 05:00; unused free attempts are discarded (help item 2).
  - Extra attempts can be bought with Diamonds (`point`), up to 5 per week at rising prices; bought attempts are permanent (help item 3, `thesstower.buy.tip`).
- **Unlock.**
  - Knight job change (`thane.isChangeJob`), else "Ativado ao obter Profissão de Cavaleiro" (`CM/yishi/SwitchPageHelp.as:3167-3170`).
  - `checkScene()`: not inside a campaign with tips and not in a room scene (`:3172-3174`, `:1883-1899`).
  - Royalty level (Caminho da Realeza) `>= royaltyTempCate.getThessTowerLv(1)`, else "Abre com Realeza Nv. {0}" (`:3176-3180`). `getThessTowerLv(1)` is the lowest `RoyaltyLevel` whose `OpenTower == 1` (`CM/yishi/datas/templates/cate/RoyaltyTempCate.as:110-113, 216-220`): **6** (`raw/xml/tempinfos/RoyaltyTemplates.xml` Id 1006).
  - `RoyaltyBossFrame` lists "Abrir a Torre de Teseus" as a perk of the royalty level where `OpenTower` increases (`m11/scripts/royaltyboss/RoyaltyBossFrame.as:328, 344, 401-406`).
- **No VIP rule, no reset, no level-skip.** The only sweep is the "Bot" button on the top cleared stage.

---

## 2. Screens

| Class (file) | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `thessTower.ThessTowerFrame` (`T11/ThessTowerFrame.as`), style `ui.thesstower.ThessTowerFrame` 850×532 (`raw/ui/zh_cn/xml/decoded/thesstower.xml:179-185`) | "Torre de Teseus" (`thesstower.title`, :79) | Container with the view and a help button | `SwitchPageHelp.openThessTower` → `openControllerByInfo("thesstower","ThessTowerFrame")` (`CM/yishi/SwitchPageHelp.as:3182`); return from battle 3913 (`m3/scripts/map/space/SpaceSceneController.as:490-492`, `m4/scripts/castle/CastleSceneView.as:354-356`) | Help button opens `SimpleHelpFrame` style `thesstower.helpFrame` (:50-55), title "Instruções" (`consortia.crossGuild.helpTitle`), text `thesstower.helpContent` |
| `thessTower.view.ThesstowerView` (`T11/view/ThesstowerView.as`) on `ThesstowerViewUI` (`T11/UI/ThesstowerViewUI.as:51-79`) | none | Main content | Created by the frame (:32) | 4 cards (`_cardItemBox`), "Prêmio Comum" box (`_normalHbox`, `FirstRewards`), "Prêmio de Bot" box (`_advanceBox`, `SweepRewards` + `SweepRandom`), `_pupBtn` (Bot), `_fightBtn` (Desafiar), `_buyBtn` (+), `_buyTxt` "{normalTime}/{WEEK_NUM}" (red when `normalTime <= 0`, :232-240), `_buyTxt1` "Tentativas extras: {0}" with `buyTime` (`TheseusCollenedBuyTimes`, :241) |
| `thessTower.view.ThesstowerCardItem` (`T11/view/ThesstowerCardItem.as`) on `ThessTowerCardItemUI` | "Fase {0}" (`thesstower.idx`, :30) | One stage card, selectable | View `initItem` (:65-83) | state 0 locked icon, not clickable; 1 current ("in" marker); 2 cleared ("in" + pass stamp) (:43-71). Selected frame 1, else 2 (:82-90) |
| `SimpleHelpFrame` `thesstower.helpFrame` | "Instruções" | Rules text | Help button | `thesstower.helpContent` (5 items, see §5) |
| `SimpleAlertHelper` confirm | "Aviso" (`public.prompt`) | Confirm a purchase | `_buyBtn` (:289-296) | "Deseja consumir {0} {1} para comprar 1 tentativa de ganhos? As tentativas compradas são permanente\n(Tentativas restantes de compra nesta semana {3}/{4})" with {1} = "Diamante" (`thesstower.buy.type1`); buttons "Confirmar" / "Cancelar" |
| `RechargeAlertMannager` alert | "Aviso" | "Diamante insuficiente, recarregar?" | `_buyBtn` when diamonds are short (:284-288) | Opens the payment URL in a browser tab (`CM/yishi/manager/RechargeAlertMannager.as:43-67`); no packet |

Card paging (`ThesstowerView.updateHandler`, :183-231):
- `page = int((passLevel - 1) / 3)` (AS3 `int` truncation, so passLevel 0 gives page 0); first card index `start = 3*page + 1`; the 4 cards show stages `start .. start+3`.
- Card `i` is state 2 if `start+i <= passLevel`, 1 if `start+i == passLevel+1`, else 0. Cards above `MAX_LV` (= max `LevelId` = 100, `CM/yishi/datas/templates/cate/ThessTowerTempCate.as:29-32, 45-48`) are hidden.
- Auto-selection: the state 1 card (or, at `passLevel == MAX_LV`, the last cleared card) is selected unless the push came from op 2 or 3 (`param11` 2 or 3), so the selection stays put after a sweep or a purchase (:199-216).

Selection (`selectHandler`, :115-181):
- selected == `passLevel` → Bot enabled, Desafiar disabled; selected == `passLevel+1` → Desafiar enabled, Bot disabled; else both disabled.
- "Prêmio Comum" = `FirstRewards` of the stage, marked "obtained" when the stage `<= passLevel`.
- "Prêmio de Bot" = `SweepRewards` followed by `SweepRandom` items (the random ones always carry the `showHasGet` marker).

---

## 3. Routes (client to server)

All requests are **9760 (0x2620) C_THESEUS_TOWER_CLIENT_OP** with `com.road.yishi.proto.player.PlayerOpMsg`. Only `op (#1, INT32)` is set (`CM/managers/TheseussoulManager.as:651-657`; tag at `CM/com/road/yishi/proto/player/PlayerOpMsg.as:476`). Sent with `SocketManager.instance.socket.sendProtobuffer`. No other sender of 9760 exists in `decompiled/` or `build/as3/gen` (grep).

| # | UI control | Client sender (file:line) | Client checks, in order | Request | Expected response, in order |
|---|---|---|---|---|---|
| R0 | Frame opens | `ThesstowerView()` constructor (`T11/view/ThesstowerView.as:62`) → `TheseussoulManager.doTowerParam(0)` (`CM/managers/TheseussoulManager.as:651`) | entry checks of §1 (only when opened from the NPC; the battle-return reopen skips them) | `op=0` (open / info) | **768** with `param11 = 0` |
| R1 | "Desafiar" (`_fightBtn`) | `fightHandler` (:262-273) → `doTowerParam(1)` | 1. button enabled only on stage `passLevel+1` (:130-134); 2. `normalTime + buyTime > 0`, else "Vezes de ganhos insuficientes" (`thesstower.reward.noTime`). No royalty, cost or bot-mode check | `op=1` (fight stage `passLevel+1`) | Battle **157 U_B_PREPARE** with `battle_type 3913`, then 156, 153..., 154, **4103** report. After the result the client leaves to `SPACE_SCENE` and reopens the frame, which sends R0 again. A 768 push with `param11 = 1` after the result is optional *(assumption)* |
| R2 | "Bot" (`_pupBtn`, listener priority 10, `enableMouseAble = true` so clicks arrive while disabled, :50, :99) | `pupBtnClickHandler` (:244-260) → `doTowerParam(2)` | 1. button enabled (selected stage == `passLevel`), else "Bot só é permitido na Fase de maior progresso atual" (`thesstower.pupNeed`); 2. `normalTime + buyTime > 0`, else "Vezes de ganhos insuficientes" | `op=2` (sweep stage `passLevel`) | **768** with `param11 = 2` and decremented attempts; reward items through the inventory pushes (inventory area) *(assumption: no dedicated reward popup exists in this module)* |
| R3 | "+" (`_buyBtn`) then "Confirmar" | `buyHandler` (:275-297) → confirm `checkForUsePetExpBookBack` (:299-305) → `doTowerParam(3)` | 1. `hasBuyTime >= MAX_BUY` (5): "Limite de compras semanal atingido!" (`thesstower.buyMax`); 2. `playerInfo.point < buyPriceArr[hasBuyTime]`: `RechargeAlertMannager.show()` ("Diamante insuficiente, recarregar?"); 3. confirm dialog | `op=3` (buy 1 attempt) | **768** with `param11 = 3`, `buyTime + 1`, `hasBuyTime + 1`; diamond balance refresh through the player/currency push (currency area) *(assumption)* |
| R4 | Help button, card clicks, reward tips | client only | none | none | none |

There is no route for reset, level choice, or VIP. There is no rank list.

---

## 4. Server messages (server to client)

| Opcode | Name | Message, fields (tag, type) | Client receiver (file:line) | When to send | Client reaction |
|---|---|---|---|---|---|
| 768 (0x0300) | U_C_THESEUS_TOWER_DATA | `com.road.yishi.proto.simple.PropertyMsg` (import `CM/managers/TheseussoulManager.as:9`). Read fields: `param1 (#1, INT32)` = **passLevel**, highest cleared stage 0..100; `param2 (#2, INT32)` = **normalTime**, free attempts left this week; `param3 (#3, INT32)` = **buyTime**, bought attempts left (permanent); `param10 (#10, INT32)` = **hasBuyTime**, purchases made this week 0..5; `param11 (#11, INT32)` = **op** that produced the push (0..3). Other fields unused. Tags at `CM/com/road/yishi/proto/simple/PropertyMsg.as:305, 310, 315, 350, 355` | `TheseussoulManager.__thessTowerDataHandler` (`CM/managers/TheseussoulManager.as:659-670`), listener registered in `setup()` (:229) | Response to every 9760 op; push after a 3913 battle result *(assumption)* and after the weekly reset if the frame is open *(assumption)* | Stores `ThessTowerInfo` (`CM/mvc/module/theseus/ThessTowerInfo.as:6-12`), fires `EVENT_TOWER` with `param11` as data. `ThesstowerView.updateHandler` (`T11/view/ThesstowerView.as:183-242`) re-pages the cards, auto-selects unless `param11` is 2 or 3, and redraws the attempt texts |
| 157, 156, 153, 154, 4103 | U_B_PREPARE, U_B_START, U_B_ATTACKING, U_B_PREPARE_OVER, U_BATTLE_REPORT | battle messages (`docs/battle/README.md`) | battle module | After R1 | Exit: battleType 3913 forces `SPACE_SCENE` (`CM/battle/handler/BattleResultHandler.as:325-327`), sets `thesetower = true` (:514-517). If `SpaceManager.exit` is set, no scene (`BattleResultHandler.as:352-355`). The space or castle scene reopens `ThessTowerFrame` (`m3/scripts/map/space/SpaceSceneController.as:490-492`, `m4/scripts/castle/CastleSceneView.as:354-356`) |
| 126 (0x007e) | U_C_MSG | generic notice (core area) | `BaseManager` | Server-side rejection *(assumption)* | The module has no error code; the client never shows a server error for 9760 |

No result code is carried by 768. Every failure the client can detect is blocked before sending (§3). For server-side rejections (stale client, no attempts, not enough diamonds), the server should resend 768 with the true state *(assumption)* so the view resynchronises.

---

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Stages | `LevelId` 1..100; `MAX_LV` = max LevelId = 100 | `raw/xml/tempinfos/TheseusTowerTmpls.xml`; `ThessTowerTempCate.as:29-32` |
| Fight target | only `passLevel + 1` | `ThesstowerView.as:130-134` |
| Sweep target | only `passLevel` (must be >= 1) | `:125-129`; text `thesstower.pupNeed` |
| Cost per fight or sweep | 1 reward attempt | help item 1 "Desafiar ou usar o Bot nas fases requer o consumo de 1 tentativa de ganhos" |
| Attempt pools | `normalTime` free weekly, `buyTime` bought permanent; client requires `normalTime + buyTime > 0` | `:252, 265`; help items 2-3 |
| Consumption order | free first, then bought *(assumption; consistent with "free unused are zeroed")* | |
| Fight on defeat | consumes nothing *(assumption)*; the help text says completing a stage gives the reward, not that a try costs an attempt | |
| Weekly free attempts | `WEEK_NUM = getConfigValue("theseustower_income_week")`. The key is **absent** from `raw/xml/tempinfos/ConfigInfos.xml`, so the client falls back to **10** (`CM/yishi/manager/TempleteManager.as:3043-3052`). The server must use 10 to match the "{n}/10" label *(assumption)* | `ThesstowerView.as:60` |
| Weekly reset | Monday 05:00 server time: `normalTime = WEEK_NUM`, `hasBuyTime = 0`; `buyTime` is kept | help item 2 |
| Purchase prices | `theseustower_income_addprice = "500,1000,1500,2000,3000"`: price of the n-th purchase this week = element `hasBuyTime`; `MAX_BUY` = 5 | `ThesstowerView.as:53-59, 283`; `ConfigInfos.xml` |
| Purchase currency | Diamonds, `PlayerInfo.point` (`CM/yishi/datas/playerinfo/PlayerInfo.as:594`); label "Diamante". The config comment mentions a type (1 diamond, 2 bound diamond) but the value carries no type and the client only checks `point`. `thesstower.buy.type2` "Gema Vinculada" is unused | `:284, 293` |
| Purchase effect | `buyTime += 1`, `hasBuyTime += 1` | `thesstower.buy.tip` |
| Fight reward | `FirstRewards` of the stage ("Prêmio Comum"), e.g. stage 1 `7450001,5000\|7460003,20`, stage 100 `7450001,15000\|7460003,68` | template; help item 4 |
| Sweep reward | `SweepRewards` (stage 1 `7450001,1000`, +10 per stage, stage 100 `7450001,1990`) plus `SweepRandom` `7460003,1,70\|7460003,2,50\|7460003,5,25` (same on all 100 rows): `itemId,count,chance%`, each entry rolled independently *(assumption on the third field and on independence)* | template; help item 4 |
| Unlock | Knight job; royalty level >= 6 | `SwitchPageHelp.as:3165-3183` |
| Reward currencies | 7450001 "Pedra de Temperamento Divino" (Theseus armor strengthening), 7460003 "Pedra Divina Impecável" (Theseus armor upgrade) | `ItemTempInfos.xml` |

---

## 6. Templates

| File | Record | Fields used by the client | Fields for the server |
|---|---|---|---|
| `raw/xml/tempinfos/TheseusTowerTmpls.xml` (100 rows), loaded as `TheseusTowerTmpls` into `ThessTowerTempCate` (`CM/yishi/manager/TempleteManager.as:1424`), keyed by `LevelId` (`ThessTowerTempCate.as:22-43`) | one stage | `LevelId`; `FirstRewards` `itemId,count\|...`; `SweepRewards` `itemId,count`; `SweepRandom` `itemId,count,chance` (all parsed by `GoodsManager.getGoodListByPramStr`, `ThesstowerView.as:146-160`) | `Heroes` = `GameHeroTemp id,pos` (stage 1 `10000001,5` "Espadachim Soenke", Live 7500, Attack 500; stage 100 `10000100,5` "Rei Rubbia", Live 7 800 000, Attack 520 000, ResPath boss046); `Pawns` = `PawnTempInfos id,pos\|...` (stage 1 `410000001,2\|410000001,3\|410000001,8`, "Cavaleiro do Julgamento", Live 5250); `MapId` = battle map (16 values: 1, 2, 3, 5, 985-998, 8501; e.g. 998 "Campo Nevado" BattleGround 2, 990 "Labirinto Subterrâneo" BattleGround 10) |
| `ThessTowerTempInfo` (`CM/yishi/datas/templates/ThessTowerTempInfo.as:6-18`) | class | declares `Fightimage:int`, which the XML does not have; it does **not** declare `MapId` | The server reads `MapId` straight from the XML |
| `raw/xml/tempinfos/ConfigInfos.xml` | config | `theseustower_income_addprice`; `theseustower_income_week` (missing, default 10) | same |
| `raw/xml/tempinfos/RoyaltyTemplates.xml` (40 rows) | royalty level perks | `OpenTower` (0 for levels 1-5, 1 from level 6) via `RoyaltyTempCate` | same unlock check |
| `GameHeroTemp.xml`, `PawnTempInfos.xml`, `HeroAis.xml`, `MapInfos.xml` | battle units and map | none in this module | stats, AI, `ResPath`, `BattleGround` |

---

## 7. Persistent state (PostgreSQL, schema `theseus`)

```sql
CREATE SCHEMA IF NOT EXISTS theseus;

CREATE TABLE theseus.tower_progress (
  player_id        bigint      PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
  pass_level       smallint    NOT NULL DEFAULT 0  CHECK (pass_level BETWEEN 0 AND 100),
  free_attempts    smallint    NOT NULL DEFAULT 10 CHECK (free_attempts >= 0),
  bought_attempts  integer     NOT NULL DEFAULT 0  CHECK (bought_attempts >= 0),
  week_buy_count   smallint    NOT NULL DEFAULT 0  CHECK (week_buy_count BETWEEN 0 AND 5),
  week_start       timestamptz NOT NULL,
  updated_at       timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE theseus.tower_log (
  id             bigserial   PRIMARY KEY,
  player_id      bigint      NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  action         smallint    NOT NULL CHECK (action IN (1, 2, 3)),
  level_id       smallint    NOT NULL DEFAULT 0,
  won            boolean,
  diamonds_spent integer     NOT NULL DEFAULT 0 CHECK (diamonds_spent >= 0),
  rewards        text        NOT NULL DEFAULT '',
  created_at     timestamptz NOT NULL DEFAULT now()
);
CREATE INDEX tower_log_player ON theseus.tower_log (player_id, created_at DESC);
```

- `week_start` is the Monday 05:00 that opened the current week; a row is lazily reset when `now() >= week_start + 7 days` (§8).
- `tower_log.action`: 1 fight, 2 sweep, 3 purchase. The log is an audit trail *(assumption, not required by the client)*.
- Diamonds (`point`) and items live in the currency and inventory areas.

---

## 8. Backend implementation notes

### Handlers

All three ops arrive on 9760; the router dispatches on `PlayerOpMsg.op`. Unknown ops are ignored.

| Handler | Route | Validation order | Transaction and output |
|---|---|---|---|
| `theseus::tower::handle_open` | 9760 op 0 | knight job, royalty level >= `getThessTowerLv(1)` (6) *(assumption: the server repeats the client gate)* | Load or create the row (`free_attempts = WEEK_NUM`, `week_start` = last Monday 05:00), apply the lazy weekly reset, send 768 `param11 = 0` |
| `theseus::tower::handle_fight` | 9760 op 1 | unlock → lazy weekly reset → `pass_level < 100` → `free_attempts + bought_attempts > 0` → player not in battle, campaign or room | No write before the battle. Build the battle (below), send 157 and follow the engine. On 4103 with a win, one tx: `pass_level += 1`, consume 1 attempt (free first), grant `FirstRewards` of the new level, log. Push 768 `param11 = 1` *(assumption)* plus inventory pushes. On a defeat, nothing changes *(assumption)* |
| `theseus::tower::handle_sweep` | 9760 op 2 | unlock → reset → `pass_level >= 1` → attempts > 0 | One tx: consume 1 attempt, grant `SweepRewards` of `pass_level` plus each `SweepRandom` entry that passes its chance roll, log. Send 768 `param11 = 2` and inventory pushes |
| `theseus::tower::handle_buy_attempt` | 9760 op 3 | unlock → reset → `week_buy_count < 5` → `point >= price[week_buy_count]` | One tx: debit diamonds through the currency service, `bought_attempts += 1`, `week_buy_count += 1`, log. Send 768 `param11 = 3` and the diamond refresh push |

### Schedules

- No timer is needed. The weekly reset (Monday 05:00, server timezone *(assumption)*) is applied lazily in every handler: when `now() >= week_start + interval '7 days'`, set `free_attempts = WEEK_NUM`, `week_buy_count = 0`, advance `week_start` to the latest Monday 05:00; keep `bought_attempts`.
- Optional: push 768 to online players with the frame open at the reset instant *(assumption)*.

### Battle configuration (`docs/battle/server-engine.md` §9.2)

```json
{"battle_id":"<uuid>","battle_type":3913,"map":"<TheseusTowerTmpl.MapId of level passLevel+1>","count_down":180,
 "heroes":[ <player hero>,
            {"temp_id":"<Heroes[0], e.g. 10000001>","type":3,"pos":"<Heroes[1], 5>","side":2} ],
 "soldiers":[ <player soldiers>,
            {"temp_id":"<Pawns[i].id, e.g. 410000001>","pos":"<Pawns[i].pos: 2, 3, 8>","side":2} ],
 "report":{"battle_result":1,"items":"<FirstRewards of the level>"},
 "report_defeat":{"battle_result":2}}
```

- Unit stats come from `GameHeroTemp` (HeroType 3 boss) and `PawnTempInfos`; AI from `HeroAis` (stage 1 hero AI 61611).
- `map` drives the battle background through `MapInfos.BattleGround` *(assumption, same mechanism as other PvE battles)*.
- The player side uses the normal army and hero; no Theseus-specific buff is applied by the client.
- After 4103 the client exits to `SPACE_SCENE`; the server must not move the player elsewhere.

### Pushes to other players

None. The tower is strictly per player.

---

## 9. Open questions and assumptions

1. `theseustower_income_week` is missing from the shipped config; the client shows a denominator of 10. The real weekly free amount is unknown (10 assumed).
2. Whether a lost fight consumes an attempt. Assumed no.
3. Consumption order between free and bought attempts. Assumed free first.
4. Meaning of the third `SweepRandom` field (assumed percent chance, independent rolls) and whether the sweep can give 0 random items.
5. Whether 768 is pushed after a 3913 battle (the client does not need it because the frame reopens and sends op 0).
6. `MapId` as the battle map id, and the `Fightimage` field declared by the client class but absent from the XML.
7. The config comment allows a bound diamond price type; the client only checks `point` (Diamonds). Assumed Diamonds only.
8. Timezone of "Monday 05:00".
9. Royalty level source: `RoyaltyBossManager.model.royaltyLevel` belongs to [Caminho da Realeza](../royalty-boss/README.md); the server must expose the same value.

---

## 10. Implementation checklist

**Client screens (already in the original client; verify against the backend):**

- [ ] `ThessTowerFrame` opens from NPC option 165 with the three entry checks (job, scene, royalty 6)
- [ ] `ThesstowerView` cards: paging, states 0/1/2, auto-selection rules with `param11`
- [ ] Reward boxes: `FirstRewards` with "obtained" marker, `SweepRewards` + `SweepRandom`
- [ ] Attempt texts "{normalTime}/10" and "Tentativas extras: {buyTime}"
- [ ] Buy confirm dialog, purchase limit tip, recharge alert
- [ ] Help frame `thesstower.helpContent`
- [ ] Reopen after battle 3913 in space and castle scenes

**Routes and messages:**

- [ ] 9760 op 0 → `theseus::tower::handle_open` → 768 `param11 = 0`
- [ ] 9760 op 1 → `theseus::tower::handle_fight` → battle 3913 (157 ... 4103) → progress, rewards, optional 768
- [ ] 9760 op 2 → `theseus::tower::handle_sweep` → 768 `param11 = 2` + items
- [ ] 9760 op 3 → `theseus::tower::handle_buy_attempt` → 768 `param11 = 3` + diamond refresh
- [ ] 768 field mapping: param1 passLevel, param2 normalTime, param3 buyTime, param10 hasBuyTime, param11 op

**Rules:**

- [ ] Fight only `pass_level + 1`, sweep only `pass_level >= 1`
- [ ] 1 attempt per fight win and per sweep; free before bought
- [ ] Weekly reset Monday 05:00 (free = 10, buy count = 0, bought kept)
- [ ] Purchase prices 500/1000/1500/2000/3000 Diamonds, 5 per week
- [ ] Reward grants: FirstRewards, SweepRewards, SweepRandom rolls
- [ ] Unlock: knight job, royalty level >= 6

**Templates:**

- [ ] Loader for `TheseusTowerTmpls` (LevelId, Heroes, Pawns, FirstRewards, SweepRewards, SweepRandom, MapId)
- [ ] Config keys `theseustower_income_addprice`, `theseustower_income_week` (default 10)
- [ ] `RoyaltyTemplates.OpenTower` unlock level

**Tables:**

- [ ] `theseus.tower_progress`
- [ ] `theseus.tower_log`

**Tests:**

- [ ] `node server/flowtest.mjs` with 9760 op 0 returns 768 with the five fields
- [ ] Fight flow: op 1 starts 3913 on the template map with the template boss and pawns; a win raises passLevel and grants FirstRewards once
- [ ] Sweep refused when passLevel is 0 or no attempts; grants rewards otherwise
- [ ] Purchase refused at 5 purchases or low diamonds; price index follows the weekly count
- [ ] Weekly reset across a Monday 05:00 boundary keeps bought attempts
- [ ] `node server/battletest.mjs` with a 3913 rule: exit returns to the space scene and the frame reopens
