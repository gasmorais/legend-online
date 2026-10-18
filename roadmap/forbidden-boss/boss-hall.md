# Boss hall ("Chefão da Zona Proibida" main frame)

Feature `forbidden-boss`, module `boss-hall`. Client: `M11/forbiddenboss/ForbiddenBossFrame.as`, `M11/forbiddenboss/ForbiddenBossItem.as`, `CM/yishi/manager/ForbiddenBossManager.as`, `CM/mvc/module/forbiddenboss/ForbiddenBossModel.as`, `CM/mvc/controler/ForbiddenBossController.as`. Conventions: see [README.md](README.md).

---

## 1. Overview

- Five tabs, one per forbidden zone category (`ForbiddenBossTemplates.Category` 1..5): "Normal", "Aventura", "Pesadelo", "Caverna", "Pesadelo" (category 5). Tabs 2..5 are locked until the royalty level reaches `getForbiddenLv(c)` (5, 10, 15, 21).
- Each tab lists the bosses of the category sorted by `BAV` (recommended armour). Each row shows the boss head, name, level, rarity badge (`BossType` 2..5: "Estrela", "Lua Vermelha", "Demônio", "Supremo") and the respawn state.
- The right side shows the selected boss animation (`swf/npc/forbiddenboss/{MarkImage}`), the recommended armour (hidden when `BAV = 0`), the server group name, the ownership reward preview (`RewardShow1`), the participation reward preview (`RewardShow2`), remaining daily counts and the "Entrar" button.
- Opening the frame sends op 1; the server answers with the boss list (4294) and the user counters (4293).
- "Entrar" sends op 2 with the boss id; the server moves the player into the boss zone ([zone-battle.md](zone-battle.md)).

---

## 2. Screens

| Class (file) | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `forbiddenboss.ForbiddenBossFrame` (`M11/forbiddenboss/ForbiddenBossFrame.as`), 950x665, controller `forbiddenboss` openType 1/default (`CM/mvc/controler/ForbiddenBossController.as:51-66`) | "Chefão da Zona Proibida" (`forbiddenBossFrame.titleText`) | Choose a boss and enter its zone | NPC option 158 | Tabs `btn1..btn5` with lock icons `lock2..lock5` and tip "Abre com Realeza Nv. {0}" (`:236-257`); boss list (`:514-537`); selected boss name, `BAV` "Valor de armadura recomendado:" (`:480-498`); "Servidor:" + `model.ConsortiaName` (`:347-357`); "Primeiro Dano:" items of `RewardShow1`, "Prêmio da Guilda:" items of `RewardShow2` (`:539-586`); "Qtd de Primeiro Dano:{0}", "Qtd de Prêmio da Guilda:{0}", "Total de Ganhos de Posse: {0}", "Total de Ganhos de Participação: {0}" (`:359-450`); red dot on the first kill button when a first kill reward is claimable (`:452-463`); buttons "Prêmio de 1ª Morte" (openType 2), "Registro do Chefão" (openType 3 with the tab index), help (`:285-294`), "Entrar" (`:296-300`) |
| `forbiddenboss.ForbiddenBossItem` (`M11/forbiddenboss/ForbiddenBossItem.as`) | none | One boss row | Frame list | Icon, name, "Nv.{bossGrades}", rarity badge (`:86-111`); state from `bossList` (`:128-187`): if `refreshTime` is more than 5 s in the future "Próxima atualização {hh:mm:ss}" else "Atualizado"; `state == 0` grey icon; `state != 0` and `endTime` in the future: "Acaba à(s): {hh:mm:ss}" in yellow |
| Help frame `forbiddenBossFrame.helperFrame` | "Ajuda do Chefão da Zona Proibida" | Rules text, formatted with `ForbiddenBoss_Killhp / 100` | help button | 9 rules quoted in §5 |

---

## 3. Routes (client to server)

Opcode: client → server **8675 (0x21e3) C_FORBIDDEN_BOSS_CLIENT_OP**, body `player.PlayerOpMsg` (`CM/com/road/yishi/proto/player/PlayerOpMsg.as`). Only these fields are written (unset fields are skipped by `writeToBuffer`):

| Field | Tag | Type | Meaning |
|---|---|---|---|
| `op` | #1 | INT32 | 1 open (`OP_OPEN`), 2 enter (`OP_ENTER`), 3 first kill reward (`OP_REWARD`), 4 record (`OP_RECORD`) (`CM/yishi/manager/ForbiddenBossManager.as:23-29`) |
| `id` | #5 | INT32 | Boss id (`ForbiddenBossTemplates.Id`) for ops 2 and 3 |

Unused fields of `PlayerOpMsg`: `type #2`, `payType #3`, `count #4`, `index #6`, `userId #7`, `templateId #8`, `campaignId #9`, `nodeId #10`, `chapterId #11`, `uuid #12 STRING`, `value1 #13`, `value2 #14`, `param1 #15 STRING`, `param2 #16 STRING`, `flag1 #17 BOOL`, `flag2 #18 BOOL`, `pos #19`, `ids #20 repeated INT32`.

| # | UI control | Client sender (file:line) | Client checks | Request | Expected response |
|---|---|---|---|---|---|
| H1 | Opening the frame | `ForbiddenBossFrame()` constructor (`M11/forbiddenboss/ForbiddenBossFrame.as:128-135`) → `ForbiddenBossManager.sendOpen` (`CM/yishi/manager/ForbiddenBossManager.as:117-123`) | Gates of the NPC entry (README) | `{op=1}` | **4294** boss list of the player's server group, then **4293** user counters |
| H2 | "Entrar" (`enterBtn`) | `ForbiddenBossFrame.__enterBtnClickHandler` (`:296-300`) → `ForbiddenBossManager.sendEnter` (`:125-132`); also stores `model.SelectBoss` | Button enabled by `refreshNum` (`:359-450`): category 1 needs remaining ownership count > 0; categories 2..5 need remaining ownership count of the category > 0 and remaining total ownership count > 0 *(the participation counters are shown but not checked)* | `{op=2, id=bossId}` | Campaign creation into campaign `CampaignId` of the boss (opcode 125, then 21/127, see [zone-battle.md](zone-battle.md) §3); then 4295 ranking and 4294 with `bossId` set. Refusal: generic tip *(assumption)* |
| H3 | Tab change, boss row selection | client only (`:475-498`) | | none | none |
| H4 | "Prêmio de 1ª Morte", "Registro do Chefão" | open sub frames, see [first-kill-and-records.md](first-kill-and-records.md) | | | |

---

## 4. Server messages (server to client)

| Opcode | Name | Message, fields (tag, type) | Client receiver (file:line) | When | Client reaction |
|---|---|---|---|---|---|
| **4294 (0x10c6)** | U_C_FORBIDDEN_BOSS_LIST | `forbiddenboss.ForbiddenBossListMsg`: `bossList (#2, ForbiddenBossMsg, repeated)`; `consortiaId (#4, INT32)` not read; `bossId (#5, INT32)` boss the player is bound to, 0 = keep | `ForbiddenBossManager.__forbiddenBossListHandler` (`CM/yishi/manager/ForbiddenBossManager.as:80-91`) | Response to op 1; after op 2 *(assumption)*; whenever a boss of the group dies or respawns while the player has the frame or a zone open *(assumption, push)* | Replaces `model.bossList`; if `bossId != 0` sets `model.SelectBoss`; notifies `FORBIDDEN_BOSS_LIST_UPDATE` (rows refresh, zone HUD reads `endTime`) |
| | | `ForbiddenBossMsg`: `bossId (#1, INT32)` template id; `state (#2, INT32)` 0 dead or waiting (grey), other alive *(assumption: 1 alive)*; `refreshTime (#3, STRING)` "YYYY-MM-DD hh:mm:ss" of the next respawn; `hp (#4, INT64)` current HP; `maxHp (#5, INT64)`; `endTime (#6, INT64)` epoch ms when the alive window ends, 0 = none | `ForbiddenBossItem.refreshView` (`M11/forbiddenboss/ForbiddenBossItem.as:128-187`), `ForbiddenBossView.__updateListHandler` (`M3/map/campaign/view/ui/ForbiddenBossView.as:157-170`) | | `hp`/`maxHp` are not displayed by the client |
| **4293 (0x10c5)** | U_C_FORBIDDEN_BOSS_USER | `forbiddenboss.ForbiddenBossUserMsg`: `belongReward (#1, STRING)` ownership rewards used today "category,count\|...\|-1,total"; `joinReward (#2, STRING)` participation rewards used today, same format; `firstReward (#3, STRING)` "bossId,state\|..." with state 1 claimable, 2 not reached, 3 claimed; `needVerify (#4, BOOL)` stored, never used; `consortiaName (#5, STRING)` text shown after "Servidor:" *(assumption: the server group name)* | `ForbiddenBossManager.__forbiddenBossUserHandler` (`:67-78`); model parsing `ForbiddenBossModel.splitArr` (`CM/mvc/module/forbiddenboss/ForbiddenBossModel.as:44-75`) | Response to op 1 and op 3; after each reward grant at a kill *(assumption)* | Counters, red dot, first kill frame refresh |

No result code exists. Refusals are silent; use the generic message tip (opcode used by other features) for errors *(assumption)*.

---

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Category unlock | Category c open when royalty `OpenForbidenBoss >= c` (levels 1, 5, 10, 15, 21) | `ForbiddenBossFrame.as:236-257`; [../royalty-boss/royalty-levels.md](../royalty-boss/royalty-levels.md) |
| Open hours | `ForbiddenBoss_time` = "06:00:00\|23:59:59" (help text says 08:00 to 24:00) | `raw/xml/tempinfos/ConfigInfos.xml`; `CM/yishi/datas/ConfigInfoManager.as:1819-1830` |
| Guild | Must belong to a guild | `SwitchPageHelp.as:3088-3092` |
| Ownership limit per category per day | `ForbiddenBoss_relegationRewards_limit` = "1,8\|2,3\|3,3\|4,3\|5,3" (default "1,5\|2,10\|3,-1\|4,-1") | `ConfigInfoManager.getForbiddenBossBelongLimit` (`:1765-1790`) |
| Participation limit per category per day | `ForbiddenBoss_participationRewards_limit` = same values (default "1,10\|2,15\|3,-1\|4,-1") | `getForbiddenBossJoinLimit` (`:1792-1817`) |
| Total ownership per day (categories 2..5) | `ForbiddenBoss_participationRewards_max` = 8 (default 5), plus returning player privilege `forbiddenBossCount` (privilege 106) | `getForbiddenBossBelongMax` (`:1747-1754`) reads the *participation* key; `OldPlayerReturnModel.forbiddenBossCount` (`CM/mvc/module/oldplayerreturn/OldPlayerReturnModel.as:332-335`) |
| Total participation per day (categories 2..5) | `ForbiddenBoss_relegationRewards_max` = 8 (default 5) + privilege 106 | `getForbiddenBossJoinMax` (`:1756-1763`) reads the *relegation* key. The two max keys are swapped in the client; both are 8 so the display is right. The server should use relegation (归属, ownership) for ownership and participation for participation |
| Remaining | `limit - used[category]`; totals `max + privilege - used[-1]`, floored at 0. A limit of -1 means unlimited (text hidden) but then the client disables "Entrar" because the remaining stays 0: never configure -1 | `ForbiddenBossFrame.as:359-450` |
| Daily reset | 00:00 for all counters | help item 5 |
| Category 1 exception | The totals do not apply to category 1 ("Com exceção da Zona Proibida Normal") | help item 9; `_belongMaxTxt.visible = index > 1` |
| Boss order | Category list sorted by `BAV` ascending | `ForbiddenBossTempCate.getTempInfoByCategory` (`CM/yishi/datas/templates/cate/ForbiddenBossTempCate.as:37-50`) |

Help text (`forbiddenBossFrame.helperFrame.helpTxt.text`), summarized: daily window; only own attributes plus Theseus soul attributes; cross-server, groups re-matched every Monday; ownership reward only to the highest cumulative damage on the current boss, participation reward to the guild members of the owner who dealt damage (leaving the scene resets damage); daily counts per zone reset at 0h; armour below the recommended value gives 90% damage reduction to the boss; only Poseidon gems are a sure drop; no dragon talker; totals apply except in the Normal zone.

---

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `raw/xml/tempinfos/ForbiddenBossTemplates.xml` (47 rows), class `ForbiddenBossTempInfo` (`CM/yishi/datas/templates/ForbiddenBossTempInfo.as`), cate `ForbiddenBossTempCate` | One boss | `Id` 31001..35020 (= `CampaignId` = boss hero template id); `Category` 1..5 (10, 8, 6, 3, 20 bosses); `BossType` 1..5 rarity (badge for 2..5); `MarkImage` swf under `swf/npc/forbiddenboss/` (`CM/yishi/manager/PathManager.as:943-946`); `CampaignId`; `BAV` recommended Theseus armour (0..19000); `HpMultiple` 100 *(assumption: HP percent multiplier, server)*; `RefreshType` 1 *(assumption: fixed delay respawn)*; `RefreshParm` 10/30/60/90/120 *(assumption: respawn delay in minutes after death)*; `BossCD` 30..90 (not mapped by the client class, server only, meaning unknown); `FirstRewards` "tid,count\|..." first kill reward; `BossSkill` 0 or 84101001 (armour handicap); `BossInfo` "heroTemplateId,position" (`31001,5`), resolved to `bossName`, `bossGrades`, `bossIcon` via `GameHeroTemp`; `RewardShow1` ownership preview; `RewardShow2` participation preview |
| `raw/xml/tempinfos/ConfigInfos.xml` | Config | `ForbiddenBoss_time`, `ForbiddenBoss_sever_matchTime`, `ForbiddenBoss_maxSever`, `ForbiddenBoss_participationRewards_limit`, `ForbiddenBoss_relegationRewards_limit`, `ForbiddenBoss_relegationRewards_max`, `ForbiddenBoss_participationRewards_max`, `ForbiddenBoss_Killhp` |
| `raw/xml/tempinfos/Campaigns.xml` 31001..35020 | Boss zones | `CampaignName` ("Zona Proibida Normal", "... Aventura", "... Pesadelo", "Caverna da Zona Proibida", "Zona Proibida do Pesadelo"), `Types 51`, `Capacity 10000`, `MinLevel 241` |

The previews call `getTempInfoById(bossTempId)` with the hero template id; this works only because hero id equals boss id in the data (`ForbiddenBossFrame.as:539-541`). Keep that invariant.

---

## 7. Persistent state (PostgreSQL, schema `forbidden_boss`)

```sql
CREATE SCHEMA IF NOT EXISTS forbidden_boss;

-- Daily counters, one row per player, category and day. category -1 holds the total for categories 2..5.
CREATE TABLE forbidden_boss.daily_counters (
  player_id      BIGINT  NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  counter_date   date     NOT NULL,
  category       smallint NOT NULL CHECK (category = -1 OR category BETWEEN 1 AND 5),
  ownership_used smallint NOT NULL DEFAULT 0 CHECK (ownership_used >= 0),
  participation_used smallint NOT NULL DEFAULT 0 CHECK (participation_used >= 0),
  PRIMARY KEY (player_id, counter_date, category)
);
```

Boss runtime state and first kills are in [zone-battle.md](zone-battle.md) §7 and [first-kill-and-records.md](first-kill-and-records.md) §7.

---

## 8. Backend implementation notes

| Handler | Route | Validation order | Transaction and pushes |
|---|---|---|---|
| `forbidden_boss::boss_hall::handle_open` | 8675 op 1 | knight job change, guild, royalty >= 1, open window | Read only. Send 4294 `{bossList = every boss of the player's group with state, refreshTime, hp, maxHp, endTime; bossId = boss the player is currently inside or 0}`, then 4293 built from `daily_counters` of today, first kill states and the group name |
| `forbidden_boss::boss_hall::handle_enter` | 8675 op 2 | same as op 1; boss id exists; `Category <= OpenForbidenBoss`; daily ownership remaining > 0 for the category (and total for categories 2..5) as the client does; player not in a team, battle or other campaign *(assumption)*; boss alive or waiting (entering a dead boss zone is allowed, the client does not check `state`) *(assumption)* | Register the player in the zone instance of the boss in his group; create the campaign `CampaignId` for him (125 + 21 + 127 + nodes of the boss); push 4294 with `bossId` and 4295 current ranking |

- 4294 must use the tags of the AS3 class (bossList #2, consortiaId #4, bossId #5).
- Times in `refreshTime` use the server local time zone (the client parses it as local "YYYY-MM-DD hh:mm:ss"); `endTime` is epoch milliseconds.

---

## 9. Open questions and assumptions

- *(assumption)* `state` values other than 0; whether 4294 is pushed on respawn without op 1.
- *(assumption)* Meaning of `HpMultiple`, `RefreshType`, `RefreshParm`, `BossCD`.
- *(assumption)* `consortiaName` of 4293 is the server group label shown after "Servidor:".
- Whether op 2 must be refused when the participation counters are exhausted (client does not check them).

---

## 10. Implementation checklist

- [ ] Loaders `ForbiddenBossTemplates.xml` and the `ForbiddenBoss_*` config keys.
- [ ] Table `forbidden_boss.daily_counters` and the 00:00 reset (date keyed rows).
- [ ] Route 8675 op 1 → 4294 then 4293 (AS3 tags).
- [ ] Route 8675 op 2 with gates and campaign creation.
- [ ] Screen check: tabs locked by royalty, rows with respawn texts, previews, counters, enter button enable rule.
- [ ] Test: royalty 4 player sees tab 2 locked; royalty 5 unlocked.
- [ ] Test: player without guild cannot open (client) and op 1/op 2 are refused (server).
- [ ] Test: category 2 with 3 ownership rewards used today: enter refused.
