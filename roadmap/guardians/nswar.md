# Espírito de Proteção arena ("Arena do Espírito de Proteção", childnswar)

Module `nswar` ("NS" = nursing spirit). A cross server seasonal ladder for Espírito de Proteção teams in its own scene (`CHILD_NS_WAR_SCENE`). The player sets a team of up to 3 main spirits and 2 support spirits, queues for matchmaking during the daily window, fights 1v1 rounds (battleType 3911), earns or loses points, climbs ranks Prata, Ouro, Platina, Diamante, Lenda, Glória ("Hall"), and collects daily task, rank and season rewards; "Mérito da Arena" buys items in the arena shop.

Path aliases:

| Alias | File |
|---|---|
| NM | `decompiled/core_module/scripts/managers/ChildNswarManager.as` |
| NMOD | `decompiled/core_module/scripts/mvc/module/childnswar/ChildNswarModel.as` |
| NC | `decompiled/core_module/scripts/mvc/controler/ChildNswarController.as` |
| V | `decompiled/m3/scripts/childnswar/` |

Proto package `pvp` (ChildPvp* messages) is registered under [arena](../arena/README.md) in `roadmap/features.json`; this module is its only client user for the `ChildPvp*` messages.

## 1. Overview

- Send 9732 (0x2604) `C_CHILD_PVP_CLIENT_OP`, `PlayerOpMsg` (package `player`): `op` (#1, INT32), `id` (#5, INT32), `count` (#4, INT32), `param1` (#15, STRING) (`NM:273-286`).
- Ops (`NM:40-56`): 1 OPEN, 2 ADD_MATCH_COUNT (use challenge scrolls), 3 BUY_MATCH_COUNT, 4 MATCH, 5 CANCEL_MATCH, 6 GET_REWARD, 7 VIEW_RANK, 8 VIEW_REWARD, 9 FIGHT_SET (team).
- Send 25240 (0x6298) `CR_CHILD_PVP_AID` in battle to call a support spirit: `UseSkillMsg` `battle_id` #1, `hero_id` #2 (main spirit living id), `skill_id` #3 (`decompiled/core_module/scripts/yishi/service/managers/SocketSendManager.as:237-245`, from `decompiled/core_module/scripts/battle/view/ui/ChildCommonSkillItemListController.as:217-227`).
- Receive 568..574 (below).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from |
|---|---|---|---|
| `V/ChildNswarScene.as` + views `V/view/ChildNswarTopView.as`, `ChildNswarLeftView.as`, `ChildNswarRightView.as`, `ChildNswarBottomView.as`, `ChildNswarMatchView.as`, `ChildNswarChooseView.as`; items `V/item/*` | "Arena do Espírito de Proteção", "Contagem regressiva para o início da temporada: {0}", "A temporada já acabou", "Horário de Pareamento: {0} até {1}", exit "Deseja sair da Arena do Espírito de Proteção?" | scene with own data, matching, team | `SwitchPageHelp.openChildNsWar` (`decompiled/core_module/scripts/yishi/SwitchPageHelp.as:3155-3163`, needs `isChangeJob`) -> op 1; 568 with `op` 1 switches scene (`NM:164-167`) |
| `V/frame/ChildNswarTeamFrame.as`, `V/item/ChildNswarTeamUI.as`, `V/item/ChildNswarChooseItemUI.as` | "Formação", "Batalha Principal①..③", "Suporte①..②", "Trocar Espírito de Proteção" | team setup | `NC` `TEAM` |
| `V/frame/ChildNswarRewardFrame.as`, `V/item/ChildNswarRewardItem.as` | | daily/rank/season rewards | `NC` `REWARD` |
| `V/frame/ChildNswarRankFrame.as`, `V/item/ChildNswarRankItem.as`, `V/item/ChildNswarRankTopItem.as` | | ranking | `NC` `RANK` |
| `V/frame/ChildNswarResultFrame.as` | | battle result | `NC` `BATTLE_RESULT` (from 572) |
| `V/frame/ChildNswarBuyTimeFrame.as` | | use challenge scrolls | `NC` `BUY_TIME` |

## 3. Routes (client to server)

| op | UI | Fields | Client checks | Response |
|---|---|---|---|---|
| 1 | open | | job change | 573 season, 568 user (`op` 1 -> scene) |
| 2 | use scrolls (`V/frame/ChildNswarBuyTimeFrame.as:150-156`) | `count` = scrolls | | 568 (`addCount`) |
| 3 | buy one attempt (`V/view/ChildNswarBottomView.as:296-332`) | | next price from `child_pvp_buy_count_points` (1:20, 2:30, 3:40, 4:50, 5:100 diamonds), confirm "theseuspvp.buyAlert", max reached "theseuspvp.buyMax" | 568 (`buyCount`, `addCount`) |
| 4 | match (`V/view/ChildNswarBottomView.as:334-385`) | | season started ("A temporada ainda não começa"), not over ("theseuspvp.inCounting"), inside match window ("Horário de Pareamento: {0} até {1}"), attempts `freeCount + addCount > 0` ("theseuspvp.fightNeedGood"), at least one main spirit ("É preciso ter pelo menos um Espírito de Proteção da Batalha Principal para iniciar o emparelhamento.") | 571 match state/opponent, then 574 battle info and battle 3911 |
| 5 | cancel match (`:387-390`, also `decompiled/core_module/scripts/ui/maintoolbar/MainToolBar.as:1948`) | | | 571 |
| 6 | claim reward (`V/item/ChildNswarRewardItem.as:85-92`) | `id` = reward template id | | 569 |
| 7 | view rank (`V/frame/ChildNswarRankFrame.as:58`) | | | 570 |
| 8 | view rewards (`V/frame/ChildNswarRewardFrame.as:63`) | | | 569 |
| 9 | save team (`V/frame/ChildNswarTeamFrame.as:100-113`) | `param1` = team string (spirit ids: 3 main + 2 support) | | 568 (`fightInfo`) |

## 4. Server messages (server to client)

All handlers in `NM`.

| Opcode | Message | Handler | Fields | When |
|---|---|---|---|---|
| 573 (0x023d) `U_C_CHILD_PVP_SEASON` | `ChildPvpSeasonMsg` | `__timeInfosHandler` (`NM:108-121`) | `seasonId` #1, `seasonStartDate` #2, `seasonStopDate` #3, `matchStartDate` #4, `matchStopDate` #5 (STRING dates), `totalDay` #6 | on open and season change |
| 568 (0x0238) `U_C_CHILD_PVP_USER` | `ChildPvpUserMsg` | `__userInfosHandler` (`NM:146-168`) | `op` #1 (1 = enter scene), `integral` #2 points, `pvpId` #3 rank template, `rank` #4, `freeCount` #5, `addCount` #6, `buyCount` #7, `keepWin` #8, `fightInfo` #9 (team string; client inserts "-1" placeholders, `NM:123-144`), `redReward` #10 BOOL, `maxIntegral` #11, `maxPvpId` #12 | open, after ops 2, 3, 9, after battles |
| 569 (0x0239) `U_C_CHILD_PVP_REWARD` | `ChildPvpRewardListMsg` | `__rewardInfosHandler` (`NM:170-186`) | `op` #1, `rewards` #2 repeated {`templateId` #1, `data` #2 progress, `state` #3 (claimable/claimed)} | ops 6, 8 |
| 570 (0x023a) `U_C_CHILD_PVP_RANK` | `ChildPvpRankListMsg` | `__rankInfosHandler` (`NM:188-211`) | `ranks` repeated {`rank` #1, `integral` #2, `pvpId` #3, `nickName` #4, `serverName` #5, `job` #6, `fightCapacity` #7, `uuid` #8, `site` #9} | op 7 |
| 571 (0x023b) `U_C_CHILD_PVP_MATCH` | `ChildPvpMatchMsg` | `__matchInfosHandler` (`NM:213-243`) | `state` #1 (match state), `players` repeated {`integral` #1, `pvpId` #2, `nickName` #3, `serverName` #4, `job` #5, `fightCapacity` #6, `grade` #7}; own row recognized by nick + server | ops 4, 5, match found |
| 574 (0x023e) `U_C_CHILD_PVP_BATTLE` | `ChildPvpBattleMsg` | `__battleInfosHandler` (`NM:91-106`) | `op` #1, `battleId` #2, `fightSkillId` #3 (round field buff), `childs` repeated {`side` #1, `pos` #2, `jobType` #3, `state` #4, `grade` #5} | before/between rounds |
| 572 (0x023c) `U_C_CHILD_PVP_FIGHT_RESULT` | `ChildPvpFightResultMsg` | `__resultInfosHandler` buffered until the scene is back (`NM:245-271`) | `isWin` #1, `rank` #2, `integral` #3, `pvpId` #4, `lastRank` #5, `lastIntegral` #6, `lastPvpId` #7, `keepWin` #8, `keepWinIntegral` #9, `rewardInfo` #10 STRING | after the battle |

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Points | win +15, loss -10 (`child_pvp_rankpoints`); win streak bonus `keepWinIntegral` *(assumption: server)* | config |
| Attempts | 5 free per day, up to 5 extra per day via scrolls (`child_pvp_day_free_count` "5,5"); diamond buys 20/30/40/50/100 (`child_pvp_buy_count_points`) | config, help |
| Open time | 01:00 to 23:00 (`child_pvp_open_times`), season length 21 days (`child_pvp_open_days`) | config |
| Ranks | `ChildPvpTmpls.xml` 26 tiers: Prata I..Ⅴ (0..800), Ouro (1000..2200), Platina (2500..4100), Diamante (4500..6500), Lenda (7000..9400), Hall 10000; `MatchingSection` = point window for matchmaking; `OpenShop` = shop tab | template |
| Rewards | `ChildPvpRewardTmpls.xml` 24: Area 1 daily tasks (TaskType 1 matches, 2 wins), Area 2 rank reached (TaskType 3), Area 3 season ranking (TaskType 4, `TaskNum` "from,to"); `Reward` "itemId,count" (7650001 = arena merit *(assumption)*); unclaimed rewards vanish at season end | template, help |
| Team | 3 main + 2 support spirits, at least 1 main; supports keep 85% of their stats | `childnswar.team.helpTip` |
| Combat | mains fight in sequence; the winner heals 30% max HP; each round rolls a field buff (`fightSkillId`); after 30 s damage taken +100% and again every 30 s; a support called via 25240 casts one Ex skill and stays up to 5 actions or until its main dies | help text |
| Battle | battleType 3911 (P-CHILD; `isLockChildnswar`; exit to `SPACE_SCENE` fallthrough) | `docs/battle/rules.md` |

## 6. Templates

`ChildPvpTmpls.xml`, `ChildPvpRewardTmpls.xml`, `ConfigInfos.xml` `child_pvp_*`; the arena shop belongs to [shops](../shops/README.md).

## 7. Persistent state

```sql
CREATE TABLE guardians.nswar_seasons (
  season_id      SERIAL PRIMARY KEY,
  starts_at      TIMESTAMPTZ NOT NULL,
  ends_at        TIMESTAMPTZ NOT NULL,
  match_start    TIME NOT NULL DEFAULT '01:00',
  match_stop     TIME NOT NULL DEFAULT '23:00'
);

CREATE TABLE guardians.nswar_players (
  season_id      INTEGER  NOT NULL REFERENCES guardians.nswar_seasons(season_id) ON DELETE CASCADE,
  player_id      BIGINT   NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  integral       INTEGER  NOT NULL DEFAULT 0,
  max_integral   INTEGER  NOT NULL DEFAULT 0,
  pvp_id         SMALLINT NOT NULL DEFAULT 11,
  max_pvp_id     SMALLINT NOT NULL DEFAULT 11,
  keep_win       SMALLINT NOT NULL DEFAULT 0,
  free_count     SMALLINT NOT NULL DEFAULT 5,
  add_count      SMALLINT NOT NULL DEFAULT 0,
  buy_count      SMALLINT NOT NULL DEFAULT 0,
  matches_today  SMALLINT NOT NULL DEFAULT 0,
  wins_today     SMALLINT NOT NULL DEFAULT 0,
  team           INTEGER[] NOT NULL DEFAULT '{}',
  reset_on       DATE     NOT NULL DEFAULT CURRENT_DATE,
  PRIMARY KEY (season_id, player_id)
);
CREATE INDEX nswar_players_rank ON guardians.nswar_players (season_id, integral DESC);

CREATE TABLE guardians.nswar_reward_claims (
  season_id      INTEGER  NOT NULL,
  player_id      BIGINT   NOT NULL,
  reward_id      INTEGER  NOT NULL,
  claimed_on     DATE     NOT NULL DEFAULT CURRENT_DATE,
  PRIMARY KEY (season_id, player_id, reward_id, claimed_on),
  FOREIGN KEY (season_id, player_id) REFERENCES guardians.nswar_players(season_id, player_id) ON DELETE CASCADE
);
```

## 8. Backend implementation notes

Handlers `guardians::nswar::handle_<action>`: `open` (1), `add_count` (2), `buy_count` (3), `match` (4), `cancel_match` (5), `get_reward` (6), `view_rank` (7), `view_reward` (8), `set_team` (9); `guardians::nswar::handle_call_support` (25240).

- Matchmaking queue per `MatchingSection` window; on match push 571 to both, create battle 3911 with both teams (mains sequential, supports callable), push 574 at round starts; on end compute points (+15/-10, streak), update tier by `NeedIntegral`, push 572 and 568.
- Scheduler: daily reset of counters, season end (rank rewards by mail, clear unclaimed).
- Cross server: if not supported, run per server *(assumption)*.

## 9. Open questions and assumptions

- *(assumption)* Team string format for op 9 and `fightInfo`.
- *(assumption)* Reward `state` values and item 7650001 meaning.
- *(assumption)* Matching window uses the player's tier `MatchingSection`.

## 10. Implementation checklist

- [ ] 9732 ops 1..9, 25240.
- [ ] Pushes 568..574.
- [ ] Tables `guardians.nswar_seasons`, `nswar_players`, `nswar_reward_claims`.
- [ ] Matchmaking and battle 3911.
- [ ] Scene switch `CHILD_NS_WAR_SCENE`.
- [ ] Tests: match outside the window rejected; match with no main spirit rejected; 6th free match requires scrolls or purchase; win +15 and loss -10 points; tier changes at `NeedIntegral`.
