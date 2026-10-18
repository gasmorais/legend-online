# World boss list, open states and clone

Feature `world-boss`, module `boss-list`. Client: `M13/worldboss/WorldBossFrame.as`, `M13/worldboss/view/WorldBossItem.as`, `M13/worldboss/EnterBaseItemView.as`, `M13/worldboss/view/WorldBossHelp.as`, `M13/worldboss/view/BuyAvatarFrame.as` (dead), `CM/managers/WorldBossManager.as`, `CM/managers/WorldBossSocketOutManager.as`, `CM/mvc/controler/WorldBossControler.as`, `CM/mvc/module/worldboss/WorldBossStuntmanInfo.as`, `CM/yishi/manager/BaseManager.as` (preload). Conventions: see [README.md](README.md).

---

## 1. Overview

- The world bosses are the campaign templates with `Types == 1` (`raw/xml/tempinfos/Campaigns.xml`): 5001 "Rei dos Lobos" (11:00-12:00) and 5003 "Dragão Infernal" (21:35-22:35), level 20..100, capacity 10000, description "Batalhando o Chefão Global receberá Ouro e Espírito".
- At login the client asks for the state of every "world boss dictionary" campaign (8271). The server answers 4182 with a state per campaign: 0 open, 1 not open yet, 2 finished today. The player flag `worldbossState` is true when any campaign 5000..5100 is in state 0; it drives the top bar button and the frame.
- The frame lists the `Types == 1` campaigns sorted by state. An open boss shows "Entrar"; a not yet open boss shows the clone toggle "Usar Clone" (30 diamonds) instead.
- "Entrar" sends 8258 with the campaign id; the server moves the player into the boss map ([boss-map.md](boss-map.md)).
- The clone ("substituto") is bought per boss before it opens; entering in person cancels it (with a confirmation).
- About 14, 9 or 5 minutes before a boss opens the server sends 4381; one quarter of the players (by `userId % 4`) start preloading the boss map resources.

---

## 2. Screens

| Class (file) | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `worldboss.WorldBossFrame` (`M13/worldboss/WorldBossFrame.as`), 480x320, controller `worldboss` openType 1, 2 or default (`CM/mvc/controler/WorldBossControler.as:26-41`) | "Chefão global" (`worldboss.WorldBossFrame.title01`) | List of world bosses | Top bar `worldboss`, `gotoWorldBossFrame` | One `WorldBossItem` per campaign with `Types == 1` (`:120-134`), sorted by `state` (`:136-149`); refreshed on `WORLDBOSSSTATE`, `UPDATE_WARFIGHT_STATE_LIST` and clone changes (`:76-118`); help button opens `worldboss.worldbossHelperFrame` (`:99-105`) |
| `worldboss.view.WorldBossItem` (`M13/worldboss/view/WorldBossItem.as`) | none | One boss row | Frame | `CampaignName`, "Nv. {MinLevel}", "Horário: das {OpenTime} às {StopTime}", `Description`, boss icon (`IconFactory.getBossIcon(CampaignId)`) (`:115-123`); state 0: "Entrar" button; state 1: state text "Ainda não aberto" and clone toggle "Usar Clone" (selected when bought, tip 30); state 2: "Encerrado hoje" (`:125-160`) |
| Help frame `worldboss.worldbossHelperFrame` | "Explicação" | Rules (`worldboss.view.BaseHelpFrame.helpText`) | Help button | Damage gives gold and spirit; no HP or soldier loss; "Grande Prêmio da Sorte" to the last hitter; "Grande Prêmio do Deus da Guerra" to the top 10 of each job; boss HP depends on the damage of the first 5 minutes |
| `worldboss.view.BuyAvatarFrame` (`M13/worldboss/view/BuyAvatarFrame.as`) | "Usar substituto" | Clone confirmation with price | Never instantiated in this client (dead code); the row toggle sends directly | `WorldBoss_Replacement_Price` (default 200 in the class, config 30) "Consumir {0} para usar função de Clone? Clone não pode ganhar prêmio da Sorte, Guerreiro ou de Deus Ares." |

---

## 3. Routes (client to server)

| # | UI control | Client sender (file:line) | Client checks | Route | Request | Expected response |
|---|---|---|---|---|---|---|
| L1 | Login | `WorldBossManager.setup` (`CM/managers/WorldBossManager.as:61-69`, called `CM/yishi/lunch/Yishi.as:740`) → `WorldBossSocketOutManager.reqWorldBossStates` (`CM/managers/WorldBossSocketOutManager.as:45-49`) | none | **8271 (0x204f) C_WORLDBOSS_STATE** | No body (`sendProtobuffer(pkg, null)`) | **4182** state list; **4423** clone list *(assumption: also at login)*; **4248** battlefield state |
| L2 | "Entrar" of an open boss | `WorldBossItem.__enterHander` (`M13/worldboss/view/WorldBossItem.as:179-199`) → `WorldBossControler.sendEnterBattle` (`CM/mvc/controler/WorldBossControler.as:102-108`) → `WorldBossSocketOutManager.sendWorldBossCmd` (`:23-35`) | `MinLevel <= hero level` (tip "Nível insuficiente"); not already in `CAMPAIGN_MAP_SCENE` (tip from `WorldBossHelper.getCampaignTips`); if a clone is bought for this boss: confirmation "Clone comprado, se entrar no Chefão Global cancelará essa função, continuar?" then also L4 (`:201-219`); anti spam 5 s (tip "Clique excessivo, tente novamente") | **8258 (0x2042) C_WORLD_BOSS_CMD** | `worldmap.WorldBossMsg`: `param1 (#3, INT32)` = campaign id. Unused: `army_id (#1, INT32)`, `map_id (#2, INT32)`, `param2 (#4, INT32)`, `param3 (#5, STRING)`, `param4 (#6, STRING)` | Campaign creation (125, 21, 127) into campaign 5001/5003; then **4174** boss state, **4369** damage reward tiers, **4175** death states. Refusal (closed, level) *(assumption: generic message tip)* |
| L3 | "Usar Clone" toggle when not bought | `WorldBossItem.__onBuyAvatarHandler` (`:221-233`) → `sendBuyStunmanFor` (`CM/managers/WorldBossSocketOutManager.as:75-82`); the client marks it bought before the answer | Row in state 1 (button only visible then); `delayClickTime` 800 ms | **8526 (0x214e) C_OPRATE_REPLACEMENTS** | `campaign.OprateReplacemntMsg`: `op (#1, INT32)` = 1 buy; `campaign_id (#2, INT32)`. `result (#3, INT32)` unused in requests | **4424** with `op=1`, `result` |
| L4 | "Usar Clone" toggle when bought, or entering with a clone | `WorldBossItem.__onBuyAvatarHandler` / `enter` (`:211-233`) → `sendCancelStunmanFor` (`:84-91`) | none | **8526** | `OprateReplacemntMsg {op=2, campaign_id}` | **4424** with `op=2` |
| L5 | `reqWorldBossCmd` | `WorldBossSocketOutManager.reqWorldBossCmd` (`:37-43`) | never called | 8259 C_WORLD_BOSS_REQ | `WorldBossMsg {map_id (#2)}` | none (dead route) |

---

## 4. Server messages (server to client)

| Opcode | Name | Message, fields (tag, type) | Client receiver (file:line) | When | Client reaction |
|---|---|---|---|---|---|
| **4182 (0x1056)** | U_C_CAMPAIGN_STATE | `campaign.WorldBossStateMsg`: `worldBossInfo (#1, WorldBossInfoStateMsg, repeated)`. `WorldBossInfoStateMsg`: `campaignId (#1, INT32)`; `state (#2, INT32)` 0 open, 1 not yet open, 2 finished today (`CampaignTemplate.stateValue`, `CM/yishi/datas/templates/CampaignTemplate.as:91-106`) | `WorldBossManager.__updateWorldsBossStateHandler` (`CM/managers/WorldBossManager.as:102-125`) | Response to 8271; push to all online players at every state change of any listed campaign (open, close, midnight reset) | Sets `CampaignTemplate.state` of each listed id; recomputes `playerInfo.worldbossState` (true if any id 5000..5100 is 0) and commits (`WORLDBOSSSTATE` event: frames and top bar refresh). Every `campaignId` must exist in `worldBossTemplateDict` (campaigns with `Types >= 1` that are not 5, 9, 12, 26, 50), otherwise the client throws (`TempleteManager.as:2570-2600`) |
| **4423 (0x1147)** | U_C_REPLACEMENT_STATE | `campaign.ReplacementMsg`: `state_str (#1, STRING)` "campaignId,1\|campaignId,1" bought clones | `WorldBossManager.__initStuntmanInfoHanlder` (`:94-100`), `WorldBossStuntmanInfo.parseFromString` (`CM/mvc/module/worldboss/WorldBossStuntmanInfo.as:22-39`) | At login *(assumption)* and after a boss ends (clone consumed) | Replaces the clone dictionary, fires `change` |
| **4424 (0x1148)** | U_C_OPRATE_REPLACEMENT_STATE | `campaign.OprateReplacemntMsg`: `op (#1, INT32)` 1 buy, 2 cancel; `campaign_id (#2, INT32)`; `result (#3, INT32)` 1 success | `WorldBossManager.__buyStuntmanResultHandler` (`:71-92`) | Response to L3/L4 | op 1 result 1: mark bought; op 1 other: unmark and tip "Falha ao comprar substituto"; op 2: unmark |
| **4381 (0x111d)** | U_C_WORLDBOSS_LOAD | `campaign.WorldBossInfoLoadMsg`: `campaignId (#1, INT32)`; `left_time (#2, INT32)` minutes before the boss opens *(assumption: minutes, thresholds 14/9/5)* | `BaseManager.__worldBossLoadHandler` (`CM/yishi/manager/BaseManager.as:314, 1775-1799`) | Broadcast before opening *(assumption: at T-15, T-10, T-6 minutes)* | If `left_time >= 14` and `userId % 4 == 0`, or `9 <= left_time < 14` and `% 4 == 1`, or `5 <= left_time < 9` and `% 4 == 2`, and hero level >= 20: `new PreLoadWorldBoss(campaignId, left_time)` (resource preload) |
| 125, 21, 127 | campaign | campaign entry | campaign module | Response to L2 | Map scene, see [boss-map.md](boss-map.md) |

---

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Bosses | 5001 "Rei dos Lobos" 11:00-12:00, 5003 "Dragão Infernal" 21:35-22:35; `MinLevel 20`, `MaxLevel 100` | `Campaigns.xml`; `TimeActiveBoxOpenTime.worldBossTime` (`CM/ui/toptoolbar/view/TimeActiveBoxOpenTime.as:66-83`) |
| Level gate | 20 (top bar, skip, `MinLevel`) | `TopBtnType.TIME_ACTIVE_GRADES[2]` |
| Clone price | `WorldBoss_Replacement_Price` = 30 diamonds (tip data of the toggle is 30) | `ConfigInfos.xml`; `WorldBossItem.as:80` |
| Clone limits | Buy only while the boss is not yet open (toggle visible in state 1); entering in person cancels the clone; the clone cannot win the luck, warrior or Ares prizes | `WorldBossItem.as:125-160, 201-219`; `worldboss.BuyAvatarFrame.command02` |
| Clone behaviour | *(assumption)* When the boss opens, every bought clone deals a server simulated damage equal to the player's average fight, during the whole event, and receives gold and spirit like a normal participant; debit the price at purchase, refund on cancel *(assumption)* | |
| State reset | All states return to 1 at midnight *(assumption)* | |

---

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `raw/xml/tempinfos/Campaigns.xml` (`CampaignTemplate`, `CM/yishi/datas/templates/CampaignTemplate.as`), classified into `worldBossTemplateDict` when `Types >= 1` and not 5/50/12/9/26 (`CM/yishi/manager/TempleteManager.as:2570-2600`) | World boss campaign | `CampaignId`, `CampaignName`, `Types` (1), `MinLevel`, `OpenTime`, `StopTime`, `Description` |
| `raw/xml/tempinfos/ConfigInfos.xml` | Config | `WorldBoss_Replacement_Price` 30 |
| `index/language.json` `worldboss.*`, `yishi.datas.templates.stateValue0{1,2,3}` | Strings | |

---

## 7. Persistent state (PostgreSQL, schema `world_boss`)

```sql
CREATE SCHEMA IF NOT EXISTS world_boss;

-- One row per world boss occurrence (per day and campaign).
CREATE TABLE world_boss.events (
  event_id     bigserial   PRIMARY KEY,
  campaign_id  integer     NOT NULL,                  -- 5001, 5003
  event_date   date        NOT NULL,
  state        smallint    NOT NULL DEFAULT 1 CHECK (state IN (0, 1, 2)),  -- 0 open, 1 not open, 2 finished
  opens_at     timestamptz NOT NULL,
  closes_at    timestamptz NOT NULL,
  killed_at    timestamptz,
  last_hit_player_id BIGINT REFERENCES player.players(player_id) ON DELETE SET NULL,
  max_hp       bigint,
  current_hp   bigint,
  UNIQUE (campaign_id, event_date)
);

-- Clone purchases.
CREATE TABLE world_boss.clones (
  player_id    BIGINT     NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  event_id     bigint      NOT NULL REFERENCES world_boss.events(event_id) ON DELETE CASCADE,
  price_paid   integer     NOT NULL CHECK (price_paid >= 0),
  bought_at    timestamptz NOT NULL DEFAULT now(),
  cancelled_at timestamptz,
  PRIMARY KEY (player_id, event_id)
);
```

---

## 8. Backend implementation notes

| Handler | Route | Validation order | Transaction and pushes |
|---|---|---|---|
| `world_boss::boss_list::handle_states` | 8271 | none | Send 4182 with every campaign of the world boss dictionary that has a state (at least 5001 and 5003; hook rooms and other `Types >= 1` campaigns may be included by their owners); send 4423 with the player's active clones |
| `world_boss::boss_list::handle_enter` | 8258 | `param1` is a world boss campaign → event state 0 → hero level >= `MinLevel` → player not in a battle, room or campaign → if a clone exists, cancel it (the client already sent 8526 op 2) | Create the campaign instance membership and send 125/21/127 (campaign module), then the world boss pushes of [boss-map.md](boss-map.md) §8. For other campaign types (hook rooms, quest `NeedFightId`), delegate to the owning feature |
| `world_boss::boss_list::handle_replacement` | 8526 | op 1: event of `campaign_id` is today and state 1; not already bought; diamonds >= `WorldBoss_Replacement_Price`. op 2: clone exists and event not finished | op 1: one tx debit diamonds, insert `clones`; push 4424 `{op=1, campaign_id, result=1}` (result 0 on any failure) and the currency push. op 2: set `cancelled_at`, refund *(assumption)*; push 4424 `{op=2, campaign_id}` |
| `world_boss::boss_list::scheduler` | timers | none | Daily per boss: at `OpenTime - 15/10/6 min` broadcast 4381; at `OpenTime` set state 0, create HP pool, broadcast 4182; at kill or `StopTime` set state 2, broadcast 4182, settle rewards ([boss-map.md](boss-map.md)); at 00:00 reset to state 1 and broadcast 4182 |

---

## 9. Open questions and assumptions

- *(assumption)* Unit of `left_time` in 4381 and the broadcast times.
- *(assumption)* Clone damage model, refund policy and whether clones are consumed when the boss opens.
- *(assumption)* 4423 sent at login.
- The frame title and help texts mention "Tempo de desafio 15" (`worldboss.view.WorldBossItem.timetxt`), not used by `refreshView`.

---

## 10. Implementation checklist

- [ ] Loader of campaigns 5001/5003 and `WorldBoss_Replacement_Price`.
- [ ] Tables `world_boss.events`, `world_boss.clones`.
- [ ] Route 8271 → 4182 (+ 4423).
- [ ] Scheduler: 4381 preloads, open/close/reset broadcasts 4182.
- [ ] Route 8258 enter with validation.
- [ ] Route 8526 ops 1 and 2 → 4424.
- [ ] Screen check: rows sorted by state, "Entrar" only when open, clone toggle only when not open.
- [ ] Test: 4182 with an unknown campaign id is never sent.
- [ ] Test: buying a clone with 29 diamonds returns 4424 result 0.
