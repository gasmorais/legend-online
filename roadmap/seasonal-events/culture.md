# Whole server training ("Evento de Adestração", 全区培养)

Feature `seasonal-events`, module `culture`. Client package `cultureactive` (`M11/cultureactive/*`), shared `CM/yishi/manager/CultureActiveManager.as` (`CUM`), `CM/mvc/module/culture/CultureModel.as`, `CultureConditionInfo.as`. Proto package `culture`.

Conventions: see [README.md](README.md).

---

## 1. Overview

A timed training event: the server lists goals ("conditions") such as "Consumir Pedras de Crescimento {0}", "Sintetizar {0} gemas de Nv.{1}", "Fortalecer {0} equipamentos de Einherjars até o Nv.{1}". Three tabs evaluate them at three scopes:

| Tab (`rewardType`) | Scope | Total shown |
|---|---|---|
| 1 | Personal: the player's own counts | "Meus Pontos Totais: {0}" (`myTotalScore`) |
| 2 | Guild: the guild total; the player must also have reached at least the first personal tier | "Pontos Totais da Guilda: {0}" (`myConsortiaScore`) |
| 3 | Server: the whole server total, same personal gate | "Pontos totais do Servidor: {0}" (`myServerScore`) |

Each condition tier gives items once. Training actions also give points; points rank players, guilds and servers; rank rewards are mailed after the event ("O prêmio é enviado após o encerramento e avaliação do evento, via email.").

---

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `cultureactive.CultureActiveFrame` (`M11/cultureactive/CultureActiveFrame.as`) | "Evento de Adestração" | 3 tabs | Tool bar `cultureactive` (TopToolBtnInfo 2046, `TopToolsBar.as:1308-1309`), visible when `grades >= 11` and `openCultureActive` (`TopBtnCheckShowHelper.as:319-320`) | Tab view |
| `cultureactive.CultureActiveView` | tab description `cultureactive.CultureActiveFrame.descriptionTxt1..3` | Condition list, 4 per page | Tab change (`set index`, `CultureActiveView.as:56-63`) | "Tempo do Evento: {0} ~ {1}", total of the scope, items sorted claimable, in progress, claimed (`CUM.sortList`), "Rank" button |
| `cultureactive.CultureActiveItem` | condition text `cultureactive.nameTxt<sonType>` (tab 1 variants `nameTxt1_308/309`, tabs 2/3 `nameTxt23_308/309`) | One tier | View | icon `IconFactory.getWholeserverTrain(sonType)`, tip `cultureactive.itemTitleTip<sonType>` with `scoreItem`, `scoreReward`; claim button enabled when `rewardState == 1` |
| `cultureactive.CultureActiveSortFrame` + `CultureActiveSortItem` | "Rank" | Ranking for the tab scope | "Rank" button (`CultureActiveView.as:143`, controller `cultureactive` openType 1) | order, server, guild, score, my order and score, update time |
| `CultureActiveSortRewardView` + `CultureActiveSortRewardItem` | "Ver Prêmios" | Rank rewards | Sort frame link | "{0}-{1}º:" with items |

---

## 3. Routes (client to server)

Single route: **9647 (0x25af) `C_CULTURE_CLIENT_OP`**, body `culture.CultureOpMsg`, sender `CultureActiveManager.OperateCultureReq(op, sonType = 0, takeRewardType = 0, takeRewardLevel = 0, rankType = 0)` (`CUM:226-235`); all five fields are always set.

`CultureOpMsg`: `op` (#1, INT32); `sonType` (#2, INT32); `takeRewardType` (#3, INT32); `takeRewardLevel` (#4, INT32); `rankType` (#5, INT32).

| op | UI control | Sender call site | Client checks | Fields | Expected response |
|---|---|---|---|---|---|
| 1 REQUEST | Tab shown; also at tool bar init when the event is open | `CultureActiveView.set index` (`CultureActiveView.as:56-63`), `TopToolsBar.initData` (`TopToolsBar.as:370-372`) | none | `takeRewardType` = tab 1..3 | 437 with the conditions of that scope |
| 2 REWARD | Claim | `CultureActiveItem.__receiveHandler` (`CultureActiveItem.as:176-180`) | button enabled when `rewardState == 1` | `sonType`, `takeRewardType` = tab, `takeRewardLevel` = `rewardLevel` | 437 with that condition `rewardState = 2`; bag pushes |
| 3 RANK | Sort frame opens | `CultureActiveSortFrame.show(type)` (`CultureActiveSortFrame.as:346-350`) | none | `rankType` = 1 personal, 2 guild, 3 server | 436 |

---

## 4. Server messages (server to client)

| Opcode | Name | Message | Receiver | When | Reaction |
|---|---|---|---|---|---|
| 435 (0x01b3) | U_C_CULTURE_OPEN_STATE | `simple.PropertyMsg` | `CUM.__openstateHandler` (`CUM:62, 165-171`) | Login, start, end | `openCultureActive = param7`; refresh tool bar |
| 437 (0x01b5) | U_C_CULTURE_INFO | `culture.CultureMsg` | `CUM.__cultureListHandler` (`CUM:60, 65-114`) | op 1, op 2, push when a tracked count changes *(optional)* | Rebuilds the condition list (claimable first, then in progress, then claimed, each sorted by `sonType`), fires `CULTURE_INFO_UPDATE`, `InfoTipsManager.dealData(31)` (pending claims badge = count of `rewardState == 1`) |
| 436 (0x01b4) | U_C_CULTURE_RANK | `culture.CultureOrdersMsg` | `CUM.__cultureRankHandler` (`CUM:61, 156-163`) | op 3 | Stores the ranking, fires `CULTURE_RANK_UPDATE` |

Fields:

| Message | Fields |
|---|---|
| `CultureMsg` | `uuid` (#1, STRING) event id; `openTime` (#2, STRING); `stopTime` (#3, STRING); `needScore1` (#4, INT32), `needScore2` (#5, INT32) stored, not displayed *(assumption: personal score gates for guild and server tiers)*; `condition` (#6, ConditionMsg, repeated); `myTotalScore` (#7), `myConsortiaScore` (#8), `myServerScore` (#9) INT32 |
| `ConditionMsg` | `sonType` (#1, INT32) goal type (table below); `cultureCount` (#2, INT32) required count; `myCultureCount` (#3, INT32) current count of the scope; `cultureGrade` (#4, INT32) required level for level goals; `scoreItem` (#5, INT32) and `scoreReward` (#6, INT32) score per unit and reward score (shown in the tip); `rewardLevel` (#7, INT32) tier; `rewardType` (#8, INT32) tab 1..3; `rewardItems` (#9, STRING) item list; `rewardState` (#10, INT32) 0 in progress, 1 claimable, 2 claimed |
| `CultureOrdersMsg` | `myOrder` (#1, INT32); `myScore` (#2, INT32); `rankType` (#3, INT32); `info` (#4, CultureOrderInfoMsg, repeated); `orderReward` (#5, OrderRewardMsg, repeated); `updateTime` (#6, STRING) |
| `CultureOrderInfoMsg` | `order` (#1, INT32); `serverName` (#2, STRING); `consortiaName` (#3, STRING); `totalScore` (#4, INT32) |
| `OrderRewardMsg` | `order1` (#1, INT32), `order2` (#2, INT32) rank range; `rewardItems` (#9, STRING) |

`culture.OrderInfoMsg` (same fields as `CultureOrderInfoMsg`) is unused by the client.

---

## 5. Rules and formulas

Goal types (`sonType`, pt-BR from `cultureactive.nameTxt<sonType>`):

| Range | Goals |
|---|---|
| 100..107 | Pedras de Crescimento (normal, avançadas), Esfera de Energia (normal, avançada), fortalecimento de equipamentos de Einherjar, Água Dourada, Einherjar equipment to level, synthesize divine souls of level |
| 201..204 | Esfera Mágica de Einherjar, Esfera do Poder de Espírito, Esfera de liberação de einherjar, inscriptions of the sacred weapon |
| 301..310 | Sangue de Zeus, guardian equipment to level, guardian skill scrolls (active, common, passive), guardian emblems to level (308), guardian anti-res to level (309), war emblem resistances (310) |
| 401..403 | Titan diamond training, spirit power spheres, energization fragments |
| 501..503 | Beast stones, mount diamond training, beast armour |
| 601..612 | Gems of level, Cristal de Alma, Selo de Alma, Pedra do Destino, Selo da Tenacidade, Esfera da Determinação, Molde Divino, Cristal da Força de Vontade of level, tattoo materials (normal, advanced), job advance talent diamonds, Pó da Ilusão |

- A tier is claimable when `myCultureCount >= cultureCount` (`CUM.sortList`, `:116-154` treats `cultureCount < 1` as 1). For level goals (308, 309, 106, 107, 302, 310, 601, 608) the count is "number of objects at or above `cultureGrade`".
- Guild and server tiers also require the player to have reached the first personal tier (descriptions 2 and 3).
- Points: each tracked action adds `scoreItem` points per unit *(assumption)*; ranks by points per scope; rank rewards mailed at the end.

---

## 6. Templates

None in XML; conditions and rewards come from the server. Icons by `IconFactory.getWholeserverTrain(sonType)`.

---

## 7. Persistent state (PostgreSQL, schema `seasonal_events`)

```sql
CREATE TABLE seasonal_events.culture_events (
  event_uuid   text PRIMARY KEY,
  open_time    timestamptz NOT NULL,
  stop_time    timestamptz NOT NULL,
  need_score1  integer NOT NULL DEFAULT 0,
  need_score2  integer NOT NULL DEFAULT 0
);

CREATE TABLE seasonal_events.culture_conditions (
  event_uuid    text     NOT NULL REFERENCES seasonal_events.culture_events(event_uuid) ON DELETE CASCADE,
  reward_type   smallint NOT NULL CHECK (reward_type BETWEEN 1 AND 3),
  son_type      integer  NOT NULL,
  reward_level  smallint NOT NULL,
  culture_count integer  NOT NULL,
  culture_grade integer  NOT NULL DEFAULT 0,
  score_item    integer  NOT NULL DEFAULT 0,
  score_reward  integer  NOT NULL DEFAULT 0,
  reward_items  text     NOT NULL,
  PRIMARY KEY (event_uuid, reward_type, son_type, reward_level)
);

CREATE TABLE seasonal_events.culture_progress (
  event_uuid  text    NOT NULL,
  player_id   bigint  NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  son_type    integer NOT NULL,
  count       bigint  NOT NULL DEFAULT 0,
  PRIMARY KEY (event_uuid, player_id, son_type)
);

CREATE TABLE seasonal_events.culture_scores (
  event_uuid   text    NOT NULL,
  player_id    bigint  NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  consortia_id integer,
  score        integer NOT NULL DEFAULT 0,
  PRIMARY KEY (event_uuid, player_id)
);
CREATE INDEX culture_scores_rank ON seasonal_events.culture_scores (event_uuid, score DESC);

CREATE TABLE seasonal_events.culture_claims (
  event_uuid   text     NOT NULL,
  player_id    bigint   NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  reward_type  smallint NOT NULL,
  son_type     integer  NOT NULL,
  reward_level smallint NOT NULL,
  claimed_at   timestamptz NOT NULL DEFAULT now(),
  PRIMARY KEY (event_uuid, player_id, reward_type, son_type, reward_level)
);
```

Guild and server counts are aggregates over `culture_progress` (materialize per guild if needed).

---

## 8. Backend implementation notes

| Handler | op | Validation | Effects |
|---|---|---|---|
| `seasonal_events::culture::handle_request` | 1 | event open, tab 1..3 | 437 for the tab with `myCultureCount` of the scope and states |
| `seasonal_events::culture::handle_reward` | 2 | condition exists → scope count >= required → personal gate for tabs 2, 3 → not claimed → bag | tx; 437 |
| `seasonal_events::culture::handle_rank` | 3 | rankType 1..3 | 436 (cache per scope, refresh periodically) |

- Hooks: one increment per tracked action from the owning features (Einherjar, guardian, titan, mount, gems, tattoo, job advance...). Expose a single `seasonal_events::culture::record(player, son_type, amount_or_level)` API.
- Schedules: 435 at start and end; rank reward mail at the end.

---

## 9. Open questions and assumptions

- *(assumption)* Meaning of `needScore1/needScore2` and of `scoreItem/scoreReward`.
- *(assumption)* Server scope means this game server only, the ranking includes other servers (`serverName` in rows).
- `culture.OrderInfoMsg` unused.

---

## 10. Implementation checklist

- [ ] Tool bar 2046 (`grades >= 11`) and login request
- [ ] Frame, view, item, sort frame, rank reward view
- [ ] 9647 ops 1, 2, 3
- [ ] 435, 436, 437
- [ ] Tables `culture_events`, `culture_conditions`, `culture_progress`, `culture_scores`, `culture_claims`
- [ ] `record` hook wired from each source feature
- [ ] End of event rank mail
- [ ] Tests: guild tier without personal tier, level goal counting, double claim
