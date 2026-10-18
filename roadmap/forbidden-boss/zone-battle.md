# Boss zone, shared HP battle and kill rewards

Feature `forbidden-boss`, module `zone-battle`. Client: `M3/map/campaign/view/ui/ForbiddenBossView.as`, `ForbiddenBossRankItem.as`, `ForbiddenBossMapFrame.as`, `M3/map/campaign/mediator/mapview/ForbiddenBossMediator.as`, `M10/battle/view/ui/ForbiddenBossUIView.as`, `M10/battle/view/ui/RoleShowViewII.as`, `CM/yishi/utils/WorldBossHelper.as:501-508`. Conventions: see [README.md](README.md).

---

## 1. Overview

- Each boss lives in its own open campaign map (campaign id = boss id, 31001..35020; `WorldBossHelper.checkForbiddenBoss(mapId)` = `31000 < mapId < 40000`). The map has no fog, no team list, no team chat and a static background (`WorldBossHelper.as:49-52, 64-68`; `M3/map/campaign/view/CampaignMapView.as:408-412, 448`).
- On the map the HUD (`ForbiddenBossView`) shows the live damage ranking of the current boss, the player's Theseus armour against `BAV`, the end time of the boss window, an auto-walk button (requires the king contract buff 15) and a mini map button.
- Walking to the boss node and arriving (5125) starts a battle of type 3903 against the boss. The boss HP is shared by every player of the server group: the battle HUD receives HP syncs (4297) and shows the current top damage dealer.
- The boss dies when its shared HP reaches 0. The player with the highest cumulative damage on this boss life gets the ownership reward; members of his guild who dealt damage get the participation reward. The boss respawns after its timer.
- Leaving the zone resets the player's damage: warning "Sair do Chefão da Zona Proibida? Após sair do cenário, o dano será zerado e nenhum Prêmio será obtido" (`mainBar.MainToolBar.str12`, `CM/ui/maintoolbar/MainToolBar.as:2112-2116`).

---

## 2. Screens

| Class (file) | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `map.campaign.view.ui.ForbiddenBossView` (`M3/map/campaign/view/ui/ForbiddenBossView.as`), registered by `ForbiddenBossMediator` (`M3/map/campaign/mediator/mapview/ForbiddenBossMediator.as:20-27`) on boss maps (`CampaignMapView.as:408-412`, together with `NodeGuideMediator`) | none (HUD on the right, y 200) | Zone HUD | Entering the zone | Ranking rows from `model.rankList` (`:124-142`); "Acaba à(s): {hh:mm:ss}" from `endTime` of the selected boss, ticking every second (`:97-115, 185-207`); "Valor de Armadura Recomendado: {armour}/{BAV}" in red when below (`forbiddenBossView.txt.text`, `:248-271`); lock image when king contract buff 15 is missing (`:116, 209-212`); auto button (`:214-241`); map button (`:278-281`) |
| `map.campaign.view.ui.ForbiddenBossRankItem` (`M3/.../ForbiddenBossRankItem.as:55-79`) | none | One ranking row | HUD | Rank (images for 1..3), nickname, "<{guild}>" (`forbiddenBossRankItem.consortiaNameTxt.text`), damage percent `damage / maxHp * 100` with 2 decimals |
| `map.campaign.view.ui.ForbiddenBossMapFrame` (`M3/map/campaign/view/ui/ForbiddenBossMapFrame.as`), controller `forbiddenboss` openType 4 | none | Mini map of the zone, click to walk | HUD map button | Map image `asset.forbiddenBossMapFrame.mapImg{Category}` (`:134-142`); category 5 maps (35000 < id < 36000) use a 375x475 viewport (`:106-119`); click converts to map coordinates with a scale per category (12/12, 13/12, 6/6, 11/10.2, 12/12) and calls `moveArmyByPos` (`:183-216`); node names of visible node types (`:268-`) |
| `battle.view.ui.ForbiddenBossUIView` (`M10/battle/view/ui/ForbiddenBossUIView.as:57-73`), created when `battleModel.isForbiddenBoss()` (`M10/battle/view/ui/BattleUIView.as:1346-1349`) | none | Battle HUD: current owner | Battle 3903 | Nickname and guild of `rankList[0]` (refreshed on `FORBIDDEN_BOSS_RANK_UPDATE`) |

---

## 3. Routes (client to server)

The zone uses the generic campaign map protocol (owned by [../campaign/README.md](../campaign/README.md), detailed in `docs/world/README.md` §3). Only the parts this feature needs are listed.

| # | UI control | Client sender | Client checks | Route | Expected response |
|---|---|---|---|---|---|
| Z1 | Walk (map click, mini map click, auto walk) | `CampaignMapController.moveArmyByPos` (`ForbiddenBossMapFrame.as:183-216`); auto: `WORK_NEXT_NODE` notification (`ForbiddenBossView.as:214-223`) | Auto needs king contract buff 15, else alert "Necessário ativar contrato dos elfos, deseja habilitar?" opening `kingcontract` (`:224-241`) | 5124 `U_C_CAMPAIGN_SYNCPOS` `PosMoveMsg` | Position broadcasts 4185/4213 to the other players of the zone |
| Z2 | Arrive at the boss node | `CampaignArmyViewHelper` → 5125 `U_C_CAMPAIGN_ARRIVE` `CampaignReqMsg{para_int1 = campDataId}` | none specific | 5125 | Battle: 64, **157** with battleType **3903**, 156, 153..., 154, 4103; during the battle **4297** HP syncs and **4295** ranking pushes |
| Z3 | Leave the zone (back button) | `MainToolBar` campaign exit with confirm str12 | confirmation | 5120 `U_C_CAMPAIGN_EXIT` (or 5025) | 22 exit, back to space; the server clears the player's damage on this boss |
| Z4 | Mini map open | `ForbiddenBossView.__mapBtnClickHandler` | none | none | none |

No feature specific opcode is sent from the zone.

---

## 4. Server messages (server to client)

| Opcode | Name | Message, fields (tag, type) | Client receiver (file:line) | When | Client reaction |
|---|---|---|---|---|---|
| **4295 (0x10c7)** | U_C_FORBIDDEN_BOSS_RANK | `forbiddenboss.ForbiddenBossRankListMsg`: `bossId (#1, INT32)` not read; `rankList (#2, ForbiddenBossRankMsg, repeated)`; `maxHp (#3, INT64)` boss max HP (read only when present); `consortiaId (#4, INT32)` not read. `ForbiddenBossRankMsg`: `rank (#1, INT32)` 1-based; `damage (#2, INT64)` cumulative damage of this boss life; `userId (#3, INT32)`; `nickName (#4, STRING)`; `consortiaId (#5, INT32)`; `consortiaName (#6, STRING)` "" = no guild text | `ForbiddenBossManager.__forbiddenBossRankHandler` (`CM/yishi/manager/ForbiddenBossManager.as:93-104`) | On zone entry; after every damage change (end of each battle, throttled) *(assumption)*; reset when the boss respawns | Replaces `rankList`, sets `maxHp`, notifies `FORBIDDEN_BOSS_RANK_UPDATE` (zone HUD list, battle HUD owner) |
| **4297 (0x10c9)** | U_C_FORBIDDEN_BOSS_HP | `simple.WorldBossInfoMsg`: `cur_hp (#1, INT64)` shared HP; `total_num (#2, INT32)`; `campaign_id (#3, INT32)`; `woundInfo (#4, WoundInfoMsg, repeated)`; `total_hp (#5, INT64)`; `my_wound (#6, INT64)`; `grades (#7, INT32)`; `current_millis (#8, INT64)` server time of the sample; `castleWound (#9, WoundInfoMsg, repeated)`; `buffer_grade (#10, INT32)`; `boss_type (#11, INT32)`; `boss_state (#12, INT32)`. The battle reads only `current_millis`, `cur_hp`, `total_hp`, `boss_state` | `RoleShowViewII.__syncBossHpHandler` (`M10/battle/view/ui/RoleShowViewII.as:227, 264-286`); buffered while the campaign scene loads by `CampaignSocketDataProxy` (`CM/proxy/scene/CampaignSocketDataProxy.as:95`) | Periodically during battle 3903 *(assumption: every 1 to 2 s and on large changes)* | When `boss_state` goes 0 → 1, sets the boss total and initial HP; always calls `battleModel.updateWorldBossBlood(cur_hp, current_millis)` (bar driven by server HP) |
| 4294 | U_C_FORBIDDEN_BOSS_LIST | see [boss-hall.md](boss-hall.md) §4 | | On boss death and respawn while the player is in the zone *(assumption)* | Updates `endTime` in the HUD |
| 4293 | U_C_FORBIDDEN_BOSS_USER | see [boss-hall.md](boss-hall.md) §4 | | After rewards are granted at a kill *(assumption)* | Counters |
| 125, 21, 127, 4185, 4213, 22 | campaign | campaign map messages | campaign module | Zone entry, movement, exit | |
| 157, 156, 153, 154, 4103 | battle | battle engine messages | battle module | Z2 | Battle 3903; P-WB group (`docs/battle/rules.md` row 3903) |

`ForbiddenBossKillMsg` (`bossId #1, userId #2, rankList #4 ForbiddenBossRankListMsg, consortiaId #5, kill #6 BOOL`) and `ForbiddenBossGroupMsg` (`opType #1, site #2 STRING, consortiaId #6`) exist in the proto package but no client code reads or sends them: they are cross-server messages between game servers and the boss server *(assumption)*. They can be reused as internal event payloads.

---

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Shared HP | One HP pool per boss life per server group; every battle of every player subtracts its damage | help items 3 and 4; 4297 |
| Armour handicap | If player Theseus armour `< BAV`, the boss takes 90% less damage (buffer 84101001, `BossSkill`); bosses with `BAV = 0` have `BossSkill = 0` | help item 6; `ForbiddenBossTemplates.xml` |
| Allowed power | Own attributes plus Theseus soul attributes; no dragon talker; sealed skill locked on forbidden maps (`CM/battle/view/ui/SkillItemListView.as:197`) | help items 2 and 8 |
| Owner | Player with the highest cumulative damage on the current boss life when it dies | help item 4 |
| Ownership reward | Owner gets `ForbiddenBossBelongDrop` where `site = bossId`, if he still has ownership count for the category today (and total for categories 2..5) | help items 4, 5, 9 |
| Participation reward | Every member of the owner's guild with damage > 0 on this boss life (owner excluded *(assumption)*) gets `ForbiddenBossJoinDrop` where `site = bossId`, if he still has participation count | help item 4 |
| `ForbiddenBoss_Killhp` | 7000; the help frame formats `Killhp / 100` = 70 into the text; description "归属奖励所需攻击血量百分比" (percentage of boss HP that must be dealt to get the ownership reward) *(assumption: the owner's damage must reach 70% of max HP, or the guild's; verify)* | `ForbiddenBossFrame.as:285-294`; `ConfigInfos.xml` |
| Drop roll | Drop packages use `appearType` 1 fixed, 2 possible, 3 rare, 4 random (`docs/mechanics/world_progression.md`): for site 31001 = 150 Poseidon gems (fixed) + one of ten armour pieces 72134xx..72139xx (possible) + 7211003 (rare) | `ForbiddenBossBelongDrop.xml`, `ForbiddenBossJoinDrop.xml` (730 rows each, 47 sites) |
| Damage reset | Leaving the zone resets the player's damage on that boss | help item 4; str12 |
| Respawn | After death the boss state is 0 and `refreshTime` shows the respawn time *(assumption: death time + `RefreshParm` minutes)*; `endTime` bounds the alive window *(assumption: spawn + `BossCD` minutes)* | `ForbiddenBossItem.as:128-187` |
| Server groups | Re-matched every Monday at `ForbiddenBoss_sever_matchTime` 00:00, at most `ForbiddenBoss_maxSever` = 4 servers per group | `ConfigInfos.xml`; help item 3 |
| Daily window | Bosses can be entered only inside `ForbiddenBoss_time` *(assumption: the server also closes zones at 23:59:59)* | |

---

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `raw/xml/tempinfos/ForbiddenBossTemplates.xml` | Boss | see [boss-hall.md](boss-hall.md) §6 |
| `raw/xml/tempinfos/ForbiddenBossBelongDrop.xml` (`ForbiddenBossBelongDropCate`, loaded `CM/yishi/manager/TempleteManager.as:1360`) | Ownership drop row | `id`, `dropId` (2040xxxx), `site` = boss id, `para2` 0, `itemId`, `count`, `isBind` 1, `appearType`, `validDate`, `isShow` |
| `raw/xml/tempinfos/ForbiddenBossJoinDrop.xml` (`ForbiddenBossJoinDropCate`, `:1361`) | Participation drop row | same schema, `dropId` 2050xxxx |
| `raw/xml/tempinfos/GameHeroTemp.xml` 31001..35020 | Boss hero | stats, `Grades`, `Icon` |
| `raw/xml/tempinfos/Campaigns.xml`, `MapInfos.xml`, map files of 31001..35020 | Zone maps | nodes, boss node |

---

## 7. Persistent state (PostgreSQL, schema `forbidden_boss`)

```sql
-- One row per boss and server group: the live boss.
CREATE TABLE forbidden_boss.boss_instances (
  group_id      integer     NOT NULL,
  boss_id       integer     NOT NULL,              -- ForbiddenBossTemplates.Id
  life_no       integer     NOT NULL DEFAULT 1,     -- increments at every respawn
  state         smallint    NOT NULL DEFAULT 0 CHECK (state IN (0, 1)),
  current_hp    bigint      NOT NULL CHECK (current_hp >= 0),
  max_hp        bigint      NOT NULL CHECK (max_hp > 0),
  spawned_at    timestamptz,
  ends_at       timestamptz,
  next_respawn_at timestamptz,
  updated_at    timestamptz NOT NULL DEFAULT now(),
  PRIMARY KEY (group_id, boss_id)
);

-- Cumulative damage per boss life. Deleted when the player leaves the zone or at respawn.
CREATE TABLE forbidden_boss.boss_damage (
  group_id    integer NOT NULL,
  boss_id     integer NOT NULL,
  life_no     integer NOT NULL,
  player_id   BIGINT NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  guild_id    integer,
  damage      bigint  NOT NULL DEFAULT 0 CHECK (damage >= 0),
  updated_at  timestamptz NOT NULL DEFAULT now(),
  PRIMARY KEY (group_id, boss_id, life_no, player_id),
  FOREIGN KEY (group_id, boss_id) REFERENCES forbidden_boss.boss_instances(group_id, boss_id) ON DELETE CASCADE
);
CREATE INDEX boss_damage_rank ON forbidden_boss.boss_damage (group_id, boss_id, life_no, damage DESC);

-- Weekly server groups.
CREATE TABLE forbidden_boss.server_groups (
  week_start  date    NOT NULL,
  server_id   integer NOT NULL,
  group_id    integer NOT NULL,
  label       text    NOT NULL,            -- shown after "Servidor:"
  PRIMARY KEY (week_start, server_id)
);

-- Kill history (also feeds the record log of first-kill-and-records.md).
CREATE TABLE forbidden_boss.kills (
  kill_id       bigserial   PRIMARY KEY,
  group_id      integer     NOT NULL,
  boss_id       integer     NOT NULL,
  life_no       integer     NOT NULL,
  owner_player_id BIGINT   REFERENCES player.players(player_id) ON DELETE SET NULL,
  owner_guild_id  integer,
  killed_at     timestamptz NOT NULL DEFAULT now(),
  UNIQUE (group_id, boss_id, life_no)
);
```

The live HP should be held in memory by the zone actor and flushed periodically; the table is the recovery point.

---

## 8. Backend implementation notes

- **Zone actor** `forbidden_boss::zone_battle` per `(group_id, boss_id)`: owns HP, damage map, player list, respawn timer. Message handlers:
  - `forbidden_boss::zone_battle::handle_arrive_boss` (called by the campaign 5125 handler when the node is the boss): refuse if `state = 0` (boss dead) with a tip; build battle 3903.
  - `forbidden_boss::zone_battle::on_battle_damage(player, damage)`: subtract from HP (clamped at 0), add to `boss_damage`, schedule 4295 to all players of the zone (throttle 1 s) and 4297 to all players currently in a 3903 battle on this boss.
  - `forbidden_boss::zone_battle::on_player_leave(player)`: delete the player's damage row (help item 4), push 4295.
  - `forbidden_boss::zone_battle::on_kill()`: one tx: insert `kills`; owner = max damage; check `ForbiddenBoss_Killhp` rule; grant ownership drop if the owner has count (increment `daily_counters` for the category and -1 total when category > 1); for each guild member of the owner with damage > 0 and participation count: grant participation drop and increment counters; insert record rows for level 3 armour drops; mark first kill state 1 for every participant *(assumption: first kill reward is per player and per boss, claimable by anyone who took part in a kill)*; set `state = 0`, `next_respawn_at`. After commit: end running 3903 battles of this boss as victory *(assumption)*, push 4294 to every player of the group that has the frame or a zone open, 4293 to rewarded players, bag and currency pushes.
  - Respawn timer: new `life_no`, full HP (`GameHeroTemp` HP x `HpMultiple / 100` *(assumption)*), `state = 1`, `spawned_at`, `ends_at`; clear `boss_damage` of the old life; push 4294.
- **Battle 3903 configuration**: player side hero only with own attributes plus Theseus armour; enemy the hero of `BossInfo` at position 5 with HP = current shared HP (bar shows `total_hp`); attach buffer 84101001 when armour `< BAV`; the battle ends on player death or a battle timer *(assumption: same timer as the world boss battle)*; the boss never dies inside the battle unless shared HP reaches 0. Damage dealt is reported to the zone actor at the end of the battle (and optionally live). 4103 report then the player returns to the zone map.
- **Cross-server**: groups are computed every Monday 00:00; with a single server deploy, group = server. `ForbiddenBossKillMsg` and `ForbiddenBossGroupMsg` can serve as internal payloads between servers.

---

## 9. Open questions and assumptions

- *(assumption)* Exact `ForbiddenBoss_Killhp` semantics (70%).
- *(assumption)* Whether the owner also gets the participation reward.
- *(assumption)* Battle duration and whether players inside a battle when the boss dies win immediately.
- *(assumption)* Respawn and alive window formulas (`RefreshParm`, `BossCD`).
- *(assumption)* Delivery channel of rewards (bag push or mail when the bag is full).
- The map id and node id of the boss inside each zone come from the downloaded map files (`web/public/maps`), not from templates.

---

## 10. Implementation checklist

- [ ] Zone actor per boss and group with HP, damage map and respawn timer.
- [ ] Tables `boss_instances`, `boss_damage`, `server_groups`, `kills`.
- [ ] Campaign integration: boss maps 31001..35020, boss node arrival → battle 3903.
- [ ] Battle 3903 config with shared HP and armour handicap.
- [ ] Push 4295 (ranking with `maxHp`) on entry and on damage changes.
- [ ] Push 4297 (`WorldBossInfoMsg` with `cur_hp`, `total_hp`, `current_millis`, `boss_state`) during battles.
- [ ] Damage reset on zone exit.
- [ ] Kill resolution: owner, ownership drop, participation drops, counters, records, first kill states.
- [ ] Respawn and 4294 pushes.
- [ ] Weekly cross-server grouping job (single server first).
- [ ] Test: two players of the same guild damage a boss; on kill the top damager gets the ownership drop and the other the participation drop.
- [ ] Test: player leaves the zone; his ranking row disappears.
- [ ] Test: armour below `BAV` reduces damage by 90%.
