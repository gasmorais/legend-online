# World boss map, shared HP battle, revive and rewards

Feature `world-boss`, module `boss-map`. Client: `M3/map/campaign/CampaignSocketManger.as` (world boss handlers), `M3/map/internals/view/frame/WoundInfoView.as`, `WoundInfoItemView.as`, `WorldBossRewardView.as`, `WorldBossRewardItem.as`, `M3/map/campaign/view/ui/WorldBossRebirthView.as`, `M3/map/campaign/mediator/mapview/WorldBossWoundMediator.as`, `WorldBossHeadInfoMediator.as`, `WorldBossRiverMediator.as`, `WorldBossBuffMediator.as`, `M3/map/campaign/view/ui/WorldBossBuyBuffView.as` (dormant), `M3/map/campaign/data/WorldBossBuyBuffModel.as`, `CM/mvc/module/worldboss/WorldBossModel.as`, `CM/managers/WorldBossManager.as`, `CM/yishi/manager/BaseManager.as`, `M10/battle/view/ui/RoleShowViewII.as`. Conventions: see [README.md](README.md).

---

## 1. Overview

- The boss map is an open campaign (5001 or 5003, `Types 1`). On maps with `Types == 1` the client registers `WorldBossWoundMediator`, `WorldBossHeadInfoMediator`, `WorldBossRiverMediator`, `WorldBossBuffMediator` and `NodeGuideMediator` (`M3/map/campaign/view/CampaignMapView.as:217-224`).
- HUD: boss head with a shared HP bar, damage ranking panel ("Ranking Geral" top 10 or "Mesma Profissão" top 10 of the player's job, own line, participants count, remaining time, inspiration level, boss phase text), three damage reward tier icons.
- The fight has two phases. First an invincible phase: the boss takes no damage and the bar shows "∞ / ∞" ("O Chefão Global está em status invencível."); the boss HP is then set from the damage done in the first 5 minutes (help item 4). Then the killable phase ("O Chefão Global está em status derrotável. Por favor, vá já matá-lo!").
- The player walks to the boss node; arrival starts a battle of type 17. Players lose no HP and no soldiers (help item 2). Each battle grants gold and spirit according to the damage *(assumption: settled at the end of the event in 4203)*.
- After a battle the player is "dead" for a countdown (`WorldBossPlayerStateMsg.left_time`). He can wait, pay `Live_Fight_Pay` (3) diamonds to fight again at once (8264), or with king contract buff 11 enable automatic re-attack.
- Global "Inspiração" (attack and magic +500 per level, up to 20 levels) is given to everybody when the damage record reaches thresholds ("Dano máximo atingindo 500K...").
- Three cumulative damage tiers (`WorldBoss_Wound1..3` = 0.3%, 0.5%, 0.8%) light up reward icons when reached.
- When the event ends each participant receives a report alert (4203): own damage, rank, gold and spirit. Last hitter and job top 10 receive special prizes.

---

## 2. Screens

| Class (file) | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `map.internals.view.frame.WoundInfoView` (`M3/map/internals/view/frame/WoundInfoView.as`), added by `WorldBossWoundMediator` | none (panel) | Damage ranking | Boss map | Tabs "Mesma Profissão" / "Ranking Geral" (`WorldBossModel.woundAll`) with 10 rows each (`:92-115, 205-212`); own row (`selfWoundInfo`, "Você não causou danos ao Chefão" when 0); participants "Nº Participantes": "Numeroso" while `totalNum < 300`, else the number (`:212-213`); inspiration text "Todos recebem Inspiração Nv. {buffGrade}, ataque/magia adiciona {buffGrade*500}" or "Dano máximo atingindo 500K, adicionará à todos efeito de inspiração" (`:214-221`); phase text from `BaseManager.wordBossInvincibleState` (`:222-233`); "Tempo Restante" countdown from `mapModel.syncErrorTime`/`syncEndTime` (4371); hide or show other players buttons |
| `WoundInfoItemView` | none | One ranking row | panel | rank, nickname, damage, percent `wound * 100 / totalHp` clamped 0..100 (`CM/mvc/module/worldboss/WoundInfo.as`) |
| Boss head (`BossInfoView`) via `WorldBossHeadInfoMediator` (`M3/map/campaign/mediator/mapview/WorldBossHeadInfoMediator.as:86-150`) | none | Shared HP bar | Boss map | `totalHp`, `curHp`; "∞ / ∞" (`worldboss.bloodText.maxValue`) while invincible |
| `WorldBossRewardView` / `WorldBossRewardItem` (`M3/map/internals/view/frame/WorldBossReward*.as`) | none | Damage tier icons | Head mediator | One image `core.WorldBossReward{rewardid}` per tier with tip `woundmsg + "\n" + rewardmsg`; reached tiers (`state == 1`) show a flag, with a fly animation the first time (`WorldBossRewardItem.as:41-62`) |
| `map.campaign.view.ui.WorldBossRebirthView` (`M3/map/campaign/view/ui/WorldBossRebirthView.as`), shown by `WorldBossRiverMediator` when `selfMemberData.isDie == 1` (`WorldBossRiverMediator.as:34-57, 79-101`) | "Contagem de ressuscitação:" | Revive countdown and instant fight | After each battle | Countdown in seconds; "imediato" button (instant fight, alert "Batalhar agora consome {0} diamantes" once per day unless dismissed, `:153-199`); auto and stop auto buttons enabled only with king contract buff 11 (`:86-87, 134-151`); auto starts 2 s after creation when the buff exists (`:106-113`); when the countdown ends with auto on, dispatches `WORK_NEXT_NODE` (auto walk to the boss) (`:246-253`) |
| `RiverView(0)` (`M3/map/campaign/view/ui/RiverView.as`) | "Ressuscitação imediata consume 2 diamantes" | Revive on pet boss floors only (`WorldBossHelper.checkInPetBossFloor`) | `WorldBossRiverMediator.as:39-42` | Owned by [../einherjar/README.md](../einherjar/README.md) (pet boss), uses the same 8264 |
| `WorldBossBuyBuffView` (`M3/map/campaign/view/ui/WorldBossBuyBuffView.as`) | "Confirmar ganho" | Buy +5% attributes buff | Never shown: `WorldBossBuffMediator.register` is empty (`M3/map/campaign/mediator/mapview/WorldBossBuffMediator.as:20-22`) and `CampaignBufferTemps.xml` has no `Types=4` rows | Dormant |

---

## 3. Routes (client to server)

| # | UI control | Client sender (file:line) | Client checks | Route | Request | Expected response |
|---|---|---|---|---|---|---|
| M1 | Walk to and arrive at the boss node | campaign map (`docs/world/README.md` §3) | none specific | 5124, then 5125 `U_C_CAMPAIGN_ARRIVE` `CampaignReqMsg{para_int1 = campDataId}` | | Battle 17 (64, 157, 156, 153..., 154, 4103); **4174** syncs during and after; **4175** death state after the battle |
| M2 | Instant fight button of `WorldBossRebirthView` | `__immediaBtnClickHandler` → `sendEnterBattle(true)` (`M3/map/campaign/view/ui/WorldBossRebirthView.as:153-228`) → `WorldBossSocketOutManager.sendEnterBattle()` (`CM/managers/WorldBossSocketOutManager.as:63-73`) | `giftToken + point >= Live_Fight_Pay` (3), else recharge alert; must be dead (`isDie == 1`), else "Você está morto" tip *(string as shipped)*; one request per view | **8264 (0x2048) C_WORLDBOSS_PLAYER_LIVE** | `player.PayTypeMsg`: `pay_type (#1, INT32)` = 0 (always 0 from this view; 1 only if called with `false`). Unused: `property1 (#2, INT32)`, `property2 (#3, INT32)`, `type (#4, INT32)` | 4175 with the player alive, a new battle 17 at once *(assumption from "Batalhar agora")*, currency push |
| M3 | Auto toggle | client only; `WORK_NEXT_NODE` walks to the boss (`WorldBossRiverMediator.as:111-132`) | king contract buff 11 | none (then M1) | | |
| M4 | Ranking tabs, hide players | client only | | none | | |
| M5 | Buy buff (dormant) | `WorldBossBuyBuffView.confirmBuyBuff` (`:199-222`) → `CampaignMapController.buyWorldBossBufferWithPointOrGiftToken` (`M3/map/campaign/CampaignMapController.as:1529-1532`) → `MapSocketOuterManager.sendBuyWorldBossBuffer(2, type)` (`M3/map/net/MapSocketOuterManager.as:118-125`) | diamonds `>= WorldBoss_Buffer_Diamond_Price` (5) or bound diamonds `>= WorldBoss_Buffer_Gift_Price` (5); not at max level ("Adição máxima atingida") | **8470 (0x2116) C_WORLDBOSS_BUFFER** | `campaign.WorldBossBufferMsg`: `type (#1, INT32)` 1 diamonds, 2 bound diamonds; `op (#4, INT32)` = 2. Unused: `point_value (#2)`, `gift_value (#3)`, `result (#5)`, `wound (#6)` | 4374 U_C_WORLDBOSS_BUFFER (no client handler). Not reachable in this client |
| M6 | Leave the map | campaign exit | | 5120 | | 22 |

---

## 4. Server messages (server to client)

| Opcode | Name | Message, fields (tag, type) | Client receiver (file:line) | When | Client reaction |
|---|---|---|---|---|---|
| **4174 (0x104e)** | U_C_SYNC_BOSS_HP | `simple.WorldBossInfoMsg`: `cur_hp (#1, INT64)` shared HP; `total_num (#2, INT32)` participants; `campaign_id (#3, INT32)` must equal the current campaign; `woundInfo (#4, WoundInfoMsg, repeated)` ranking entries; `total_hp (#5, INT64)`; `my_wound (#6, INT64)` receiver's cumulative damage; `grades (#7, INT32)` boss level; `current_millis (#8, INT64)` server time; `castleWound (#9, WoundInfoMsg, repeated)` unused here; `buffer_grade (#10, INT32)` inspiration level 0..20; `boss_type (#11, INT32)` unused; `boss_state (#12, INT32)` 0 invincible, 1 killable. `WoundInfoMsg`: `user_id (#1, INT32)`, `nick_name (#2, STRING)`, `wound (#3, INT64)`, `woundAddation (#4, INT64)` unused, `job (#5, INT32)` | Map: `CampaignSocketManger.__syncBossHpHandler` (`M3/map/campaign/CampaignSocketManger.as:347, 1398-1446`). Battle: `RoleShowViewII.__syncBossHpHandler` (`M10/battle/view/ui/RoleShowViewII.as:219, 264-286`) | On map entry and periodically to every player in the map or in a battle 17 on this boss *(assumption: every 2 to 3 s)*; at every phase change | Map: ignores other campaigns; updates `curHp`, `totalHp`, counters, own row, merges ranking entries by nickname, sets `BaseManager.wordBossInvincibleState = (boss_state == 0)` on `Types 1` maps, commits (`WorldBossModel.commit` sorts by damage, builds top 10 overall and top 10 of the player's job, keeps 30 rows, `CM/mvc/module/worldboss/WorldBossModel.as:116-201`). Battle: on `boss_state` 0 → 1 sets the boss total HP; always `battleModel.updateWorldBossBlood(cur_hp, current_millis)` |
| **4175 (0x104f)** | U_C_PLAYER_DIE_STATE | `simple.PlayerStateListMsg`: `playerState (#1, WorldBossPlayerStateMsg, repeated)`; `userId (#2, INT32, repeated)` unused. `WorldBossPlayerStateMsg`: `army_id (#1, INT32)`; `state (#2, INT32)` 1 dead, 0 alive (other values used by other maps: towers, vehicles, flags); `left_time (#3, INT32)` revive countdown in ms; `server_name (#4, STRING)` cross-server key; `res_count (#5, INT32)` unused here; `npcNodeId (#6, INT32)`; `templateId (#7, INT32)` | `CampaignSocketManger.__playerDieStateHandler` (`:348, 1338-1382`) | After each battle 17 of any player in the map (broadcast to the map); after M2 | Sets `riverStartTime`, `riverTime`, `isDie`; `IS_DIE` makes `WorldBossRiverMediator` show or hide the countdown |
| **4369 (0x1111)** | C_WORLDBOSSWOUND_REWARD | `campaign.WorldBossWoundRewardListMsg`: `rewardinfo (#1, WorldBossWoundRewardMsg, repeated)`. `WorldBossWoundRewardMsg`: `campaignId (#1, INT32)`; `rewardid (#2, INT32)` tier 1..3 (icon `core.WorldBossReward{id}`); `woundmsg (#3, STRING)` tier condition text; `rewardmsg (#4, STRING)` reward text; `state (#5, INT32)` 1 reached | `WorldBossManager.__updateRewardStateHandler` (`CM/managers/WorldBossManager.as:139-193`) | First on map entry with all tiers (initialises the list); then the changed tiers when a tier is reached | First message builds `worldBossModel.rewards` (fires `REWARDS_INIT`); later messages update `state` by `rewardid` (fly animation for newly reached tiers). Ignored when no world boss model exists (not on the map) |
| **4371 (0x1113)** | U_C_TIME_JUDGE | `campaign.TimeJudgeMsg`: `is_add (#1, BOOL)` unused; `second_count (#2, INT32)` server clock offset; `stopTime (#3, STRING)` "YYYY-MM-DD hh:mm:ss" event end | `CampaignSocketManger.__timeJudgeHandler` (`:359, 1089-1096`) | On map entry | `syncErrorTime`, `syncEndTime` (remaining time display) |
| **4262 (0x10a6)** | U_C_BROADBUFFER | `army.ArmyBufferListMsg`: `armyBuffer (#1, ArmyBufferMsg, repeated)`; `ArmyBufferMsg`: `user_id (#1, INT32)`, `buffer_tempId (#2, INT32)` | `CampaignSocketManger.__broadBufferHandler` (`:358, 1126-1137`) | When a player of the map gains a map buffer *(assumption: inspiration buffer 701..720 to everybody when `buffer_grade` rises)* | Sets `CampaignArmy.bufferTempId` (avatar buff icon) |
| **4203 (0x106b)** | U_C_WORLDBOSS_REPORT | `campaign.WorldBossReportMsg`: `campaignId (#1, INT32)`; `order (#2, INT32)` rank, 0 = not ranked; `gold (#3, INT64)`; `strengy (#4, INT64)` spirit; `total_wound (#5, INT32)`; `type (#6, INT32)` 1 world boss (others: 2 PvE room, 3 cross guild boss, 4 pet boss, 7 race against time); `property1 (#7, STRING)` extra text for types 2/4/7 | `BaseManager.__worldBossReportHandler` (`CM/yishi/manager/BaseManager.as:289, 1801-1860`) | At the end of the event (kill or `StopTime`) to every participant, online or at next login *(assumption)* | Type 1: delayed alert "Batalha do Chefão Global encerrada \nVocê {acumulou {0} Dano, \| Não causou dano,} {Ranking {0}, \| No ranking,} \nObtido {gold} ouro, {strengy} espíritos" (`yishi.manager.BaseManager.str01/11/12/21/22`) |
| 157, 156, 153, 154, 4103 | battle | battle engine | battle module | M1, M2 | battleType 17: P-WB, boss type 3 face 2 takes no damage and never dies while invincible, bar full, exit to `CAMPAIGN_MAP_SCENE` (`docs/battle/rules.md` row 17) |
| 4374 (0x1116) | U_C_WORLDBOSS_BUFFER | `WorldBossBufferMsg` | none | dormant | none |

---

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Phases | Invincible phase first; HP pool set from the damage of the first 5 minutes; then killable | help item 4; `boss_state` |
| Losses | Players lose no HP and no soldiers in battle 17 | help item 2 |
| Revive countdown | `left_time` ms from 4175 *(value server defined; assumption 20 s, the mediator reuses `riverTime` only if less than 20 s elapsed, `WorldBossRiverMediator.as:79-96`)* | |
| Instant fight | `Live_Fight_Pay` = 3 diamonds, bound diamonds accepted first (`giftToken + point`) | `ConfigInfos.xml`; `WorldBossRebirthView.as:89-98, 201-228` |
| Pet boss revive | `Live_Pay` = 2 diamonds (pet boss floors only) | `RiverView` |
| Damage tiers | 3 tiers, thresholds `WorldBoss_Wound1..3` = 0.003, 0.005, 0.008 *(assumption: fraction of boss total HP reached by the player's cumulative damage)*; rewards described by `rewardmsg` | `ConfigInfos.xml` |
| Inspiration | Buffer templates `CampaignBufferTemps` `Types 7` grades 1..20 "Inspiração Nv. N" (+500 x N attack and magic attack); grade from `buffer_grade` *(assumption: +1 grade each time the best single battle damage of the event crosses a multiple of 500 000, max 20)* | `WoundInfoView.as:214-221`; `CampaignBufferTemps.xml` 701..720 |
| Per battle reward | Gold and spirit grow with damage *(formula unknown, assumption: settled per battle and summed in 4203)* | help item 1 |
| Last hit | "Grande Prêmio da Sorte" to the player who kills the boss | help item 3 |
| Job ranking | "Grande Prêmio do Deus da Guerra" to the top 10 damage of each job | help item 3; job grouping by `ThaneInfoHelper.getJob(job)` |
| Clone | Excluded from luck, warrior and Ares prizes | `worldboss.BuyAvatarFrame.command02` |
| Achievement | Every battle adds its damage to achievement condition 114 | [../medals/achievements.md](../medals/achievements.md) |
| Buff purchase | +5% all attributes per purchase, 5 diamonds or 5 bound diamonds; dormant | `WorldBossBuyBuffModel.as:31-42`; config `WorldBoss_Buffer_*_Price` |

---

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `raw/xml/tempinfos/Campaigns.xml` 5001, 5003 | Boss maps | `OpenTime`, `StopTime`, `MinLevel` |
| `raw/xml/tempinfos/GameHeroTemp.xml` *(assumption: boss heroes of the map nodes)* | Boss stats | |
| `raw/xml/tempinfos/CampaignBufferTemps.xml` `Types 7` (701..720) | Inspiration buffs | `TemplateName`, `Grades`, `Attack`, `MagicAttack`, `Description` |
| `raw/xml/tempinfos/ConfigInfos.xml` | Config | `WorldBoss_Wound1..3`, `Live_Pay`, `Live_Fight_Pay`, `WorldBoss_Buffer_Diamond_Price`, `WorldBoss_Buffer_Gift_Price`, `BattleMusicWorldBoss` |

---

## 7. Persistent state (PostgreSQL, schema `world_boss`)

```sql
-- Cumulative damage and rewards per player and event.
CREATE TABLE world_boss.participants (
  event_id      bigint      NOT NULL REFERENCES world_boss.events(event_id) ON DELETE CASCADE,
  player_id     integer     NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  job           smallint    NOT NULL,
  damage        bigint      NOT NULL DEFAULT 0 CHECK (damage >= 0),
  best_battle_damage bigint NOT NULL DEFAULT 0,
  battles       integer     NOT NULL DEFAULT 0,
  gold_earned   bigint      NOT NULL DEFAULT 0,
  spirit_earned bigint      NOT NULL DEFAULT 0,
  tiers_reached smallint    NOT NULL DEFAULT 0 CHECK (tiers_reached BETWEEN 0 AND 3),
  dead_until    timestamptz,
  final_rank    integer,
  report_sent   boolean     NOT NULL DEFAULT false,
  PRIMARY KEY (event_id, player_id)
);
CREATE INDEX participants_rank ON world_boss.participants (event_id, damage DESC);
CREATE INDEX participants_job_rank ON world_boss.participants (event_id, job, damage DESC);
```

`world_boss.events` (in [boss-list.md](boss-list.md) §7) also needs `invincible_until timestamptz` and `inspiration_grade smallint NOT NULL DEFAULT 0 CHECK (inspiration_grade BETWEEN 0 AND 20)`.

---

## 8. Backend implementation notes

- **Event actor** `world_boss::boss_map` per running event: holds HP, phase, participants (damage, death timers), inspiration grade. Flushes to `participants` every few seconds and at the end.
- `world_boss::boss_map::on_enter(player)` (after 8258): push 4371 (`stopTime` = `closes_at`), 4369 (all three tiers with the player's state), 4174 (full state, `campaign_id` = event campaign), and 4175 if the player is dead.
- `world_boss::boss_map::handle_arrive_boss` (campaign 5125 on the boss node): refuse if dead (`dead_until > now`); build battle 17: player hero and army as in normal campaigns *(assumption)*, no losses kept; enemy boss hero; if phase invincible, the boss takes no damage; use server HP; the battle ends on a timer *(assumption: same as the client battle count down)*.
- `world_boss::boss_map::on_battle_end(player, damage)`: add damage (also during the invincible phase, it calibrates HP); in the killable phase subtract from HP; update tiers and push 4369 changed tiers; update inspiration grade and broadcast 4174/4262 when it rises; set `dead_until = now + revive_ms` and broadcast 4175 `{army_id, state=1, left_time}`; record achievement 114; credit per battle gold and spirit *(assumption)*.
- `world_boss::boss_map::handle_live` (8264): validation: player in the event map, dead, enough diamonds (bound first when `pay_type = 0`, plain diamonds only when 1). Tx: debit `Live_Fight_Pay`. Then clear death, broadcast 4175 `{state=0}`, and start battle 17 at once *(assumption)*.
- Phase change at `opens_at + 5 min`: compute `max_hp` from the damage done *(assumption: the formula is server side; for example total phase damage x factor)*, set phase killable, broadcast 4174 with `boss_state = 1` (battles in progress switch HP via 4174).
- Kill or `StopTime`: phase finished; last hitter prize; job top 10 prizes; ranking; 4203 to each participant (`type = 1`, `order`, `gold`, `strengy`, `total_wound`); 4182 state 2 broadcast; remove everybody from the map (22) *(assumption)*.
- Broadcast 4174 to all players of the map every 2 to 3 s; include at most 30 `woundInfo` entries: the top 10 overall plus the top 10 of each job present *(assumption: the client merges by nickname and recomputes its own top 10 per job)*.
- 8470 / 4374 need no implementation unless the buff purchase is re-enabled.

---

## 9. Open questions and assumptions

- *(assumption)* HP calibration formula after the invincible phase.
- *(assumption)* Revive countdown length, battle duration and per battle gold and spirit formula.
- *(assumption)* Inspiration grade rule ("500K").
- *(assumption)* Tier thresholds as fractions of total HP and their rewards.
- *(assumption)* Contents of the luck, warrior and Ares prizes (no template on the client).
- Whether 4203 must be stored and delivered at next login.

---

## 10. Implementation checklist

- [ ] Event actor with phases, HP pool, participants, inspiration.
- [ ] Table `world_boss.participants`; columns `invincible_until`, `inspiration_grade` on `events`.
- [ ] On enter pushes 4371, 4369, 4174, 4175.
- [ ] Battle 17 config with invincible flag and server HP.
- [ ] Battle end: damage, tiers (4369), inspiration (4174/4262), death (4175), achievement 114.
- [ ] Route 8264 instant fight with diamond debit.
- [ ] Periodic 4174 broadcast with ranking entries.
- [ ] End of event: prizes, ranking, 4203, state 2.
- [ ] Screen check: ranking tabs, phase text, "∞ / ∞" bar, countdown and auto revive with king contract buff 11.
- [ ] Test: during the invincible phase damage is counted but HP stays full.
- [ ] Test: 8264 with 2 diamonds is refused; with 3 bound diamonds accepted.
