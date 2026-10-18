# Battlefield entry ("Campo de Batalha")

Feature `world-boss`, module `battlefield-entry`. Client: `M13/worldboss/PvpSelectFrame.as`, `M13/worldboss/pvp/WarFightItem.as`, `M13/worldboss/pvp/PvpHeroSortData.as`, `M13/net/SingWarSocketSendManager.as`, `CM/managers/WorldBossManager.as:127-137`, `CM/yishi/manager/BaseManager.as:320, 1404-1441`. Conventions: see [README.md](README.md).

This module only covers the selection frame of the cross-server battlefield, which lives in the `worldboss` package and controller. The battlefield maps (4701 "Pico de Gelo e Fogo", 4101 "Templo das Chamas", 4901 "Terra do crepúsculo", all `Types 50/12`, capacity 10000) and their gameplay belong to [../campaign/README.md](../campaign/README.md) (`duskarea` package and campaign map mediators).

---

## 1. Overview

- The battlefield opens at fixed times (`cross_war_open_time` = "13:00,13:30\|15:00,15:30\|17:00,17:30\|19:00,19:30").
- The frame lists one card per time slot. A player who has not changed job sees "Pico de Gelo e Fogo" (4701) per slot; a player with job change (or avenger) sees two cards per slot: "Terra do crepúsculo" (4901) and "Templo das Chamas" (4101).
- A card is enterable ("Entrar") when the battlefield is open (`WorldBossManager.pvpWarIsOpen`, from 4248) and the slot start hour equals the current hour (minutes < 25 → current hour, else next hour). Other cards show "Aberto às {start}-{end}".
- "Campo de Batalha restante de hoje: {n} / {max}" with `max = WarField_MaxCount` (client default 2; help: rewards twice per day).
- With rewards left the client enters directly (8332). Without rewards left it asks the server (8599); the server answers 4493 and the client confirms "Ganhos diários esgotados, você não poderá ganhar os prêmios do campo de batalha, deseja entrar?" before 8332.

---

## 2. Screens

| Class (file) | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `worldboss.PvpSelectFrame` (`M13/worldboss/PvpSelectFrame.as`), 480x320, controller `worldboss` openType 3 (`CM/mvc/controler/WorldBossControler.as:36-39`) | "Campo de Batalha" (`worldboss.WorldBossFrame.title02`) | Choose a battlefield slot | Top bar `rvr1` (level >= 30, `CM/ui/toptoolbar/TopToolsBar.as:1366-1368`), `SwitchPageHelp.gotoWorldFightFrame` (`CM/yishi/SwitchPageHelp.as:1232-1258`) | Remaining count text (`:104-108`); VIP open view `NewVipOpenView(15)` (`:91`); magic spring buffer 8 view when active (`:112-130`); cards built from `cross_war_open_time` and `pvpWarFightDic` (`:215-336`); help with `worldboss.view.BaseHelpFrame.BattleHelpContent{warType}` (`:178-188`); heroes button hidden (`:109`) |
| `worldboss.pvp.WarFightItem` (`M13/worldboss/pvp/WarFightItem.as`) | none | One slot card | Frame | Map name, "Aberto às" and time, description, icon `IconFactory.getPvpWarFight(campaignId)`; button visible only when `state == 0` (`:47-81`) |

---

## 3. Routes (client to server)

| # | UI control | Client sender (file:line) | Client checks | Route | Request | Expected response |
|---|---|---|---|---|---|---|
| B1 | Card "Entrar" with rewards left | `WarFightItem.__enterWarFightHandler` (`M13/worldboss/pvp/WarFightItem.as:106-117`) → `SingWarSocketSendManager.enterWarfield` (`M13/net/SingWarSocketSendManager.as:24-36`) | `playerInfo.warFieldCount > 0`; anti spam 5 s ("Clique excessivo, tente novamente") | **8332 (0x208c) C_ENTER_WARFIELD** | `worldmap.WorldBossMsg`: `param1 (#3, INT32)` = campaign id (4701, 4101 or 4901). Unused: `army_id #1`, `map_id #2`, `param2 #4`, `param3 #5 STRING`, `param4 #6 STRING` | Matchmaking and campaign creation of the battlefield (campaign feature) |
| B2 | Card "Entrar" without rewards left | `WarFightItem.__enterWarFightHandler` → `SingWarSocketSendManager.sendRequestPvpRemainNumber` (`:38-49`) | `warFieldCount <= 0`; same 5 s guard (silent) | **8599 (0x2197) C_CHECK_WARFIELD_COUNT** | `campaign.CampaignReqMsg`: `para_int1 (#1, INT32)` = campaign id. Unused: `para_int2..5 (#2..#5)`, `para_string1 (#6)`, `para_bool1 (#7)`, `server_name (#8)`, `isCross (#9)` | **4493** |
| B3 | Confirmation after 4493 | `BaseManager.__warFightRemainNumber` (`CM/yishi/manager/BaseManager.as:1404-1441`) | `para_bool1 == false` → confirm ("pvpselectFrame.enterwarTip2" for job changed players, else "enterwarTip"); true → no confirm | **8332** | `WorldBossMsg {param1 = para_int1}` | as B1 |

---

## 4. Server messages (server to client)

| Opcode | Name | Message, fields | Client receiver (file:line) | When | Client reaction |
|---|---|---|---|---|---|
| **4248 (0x1098)** | U_C_WARFIELD_STATE | `campaign.WorldBossStateMsg`: `worldBossInfo (#1, WorldBossInfoStateMsg, repeated)` with `campaignId (#1, INT32)`, `state (#2, INT32)` 0 open | `WorldBossManager.__updateWarFightStateHandler` (`CM/managers/WorldBossManager.as:127-137`) | Response to 8271 at login; push at every slot open and close | `pvpWarIsOpen = (last entry state == 0)`; dispatches `UPDATE_WARFIGHT_STATE_LIST` (frames refresh) |
| **4493 (0x118d)** | U_CHECK_WARFIELD_COUNT_RS | `campaign.CampaignReqMsg`: `para_int1 (#1, INT32)` campaign id echoed; `para_bool1 (#7, BOOL)` true = enter without warning *(assumption: true when rewards are still available)* | `BaseManager.__warFightRemainNumber` (`:320, 1404-1441`) | Response to 8599 | Confirm then 8332, or 8332 directly |
| player info | `warFieldCount` | Field of the player info message read in `PlayerManager` (`CM/yishi/manager/PlayerManager.as:590-594`), also `InfoTipsManager` key 9 (top bar badge) | hero feature | At login and after each battlefield reward | Remaining count |

---

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Level | 30 (top bar `rvr1`, skip) | `TopBtnCheckShowHelper.as:277-278`; `TopBtnType.TIME_ACTIVE_GRADES[1]` |
| Map by profile | no job change → 4701; job change → 4101 and 4901; avenger → same two | `PvpSelectFrame.as:338-362` |
| Slot open | `pvpWarIsOpen && slotStartHour == (minutes < 25 ? hour : hour + 1)` | `:226-234, 265-268` |
| Rewards per day | `WarField_MaxCount` (absent from local config, client default 2) | `WarFightItem.as:108-109`; help text "duas vezes por dia" |
| Daily reset | 05:00 *(from the Flame Temple help text "redefinido às 5h")*, *(assumption for all battlefields)* | `worldboss.view.BaseHelpFrame.FlameHelpContent` |

---

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `raw/xml/tempinfos/Campaigns.xml` 4101, 4701, 4901 (`pvpWarFightDic`, `Types 5/50/12`) | Battlefield maps | `CampaignId`, `CampaignName`, `Description` |
| `raw/xml/tempinfos/ConfigInfos.xml` | Config | `cross_war_open_time`, `WarField_MaxCount` (absent) |

---

## 7. Persistent state

Owned by the campaign feature (battlefield sessions and daily reward counts). The only value needed here is the per player daily reward counter, proposed as:

```sql
CREATE TABLE world_boss.battlefield_daily (
  player_id     BIGINT  NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  counter_date  date     NOT NULL,
  rewards_used  smallint NOT NULL DEFAULT 0 CHECK (rewards_used >= 0),
  PRIMARY KEY (player_id, counter_date)
);
```

*(assumption: the campaign feature may own this table instead; keep a single source of truth.)*

---

## 8. Backend implementation notes

| Handler | Route | Validation order | Transaction and pushes |
|---|---|---|---|
| `world_boss::battlefield_entry::handle_check_count` | 8599 | campaign id is a battlefield | Read only. Send 4493 `{para_int1 = campaign id, para_bool1 = rewards_used < max}` |
| `world_boss::battlefield_entry::handle_enter` | 8332 | battlefield open and slot hour matches; campaign allowed for the player profile (4701 before job change, 4101/4901 after); level >= 30; not in a team, battle or other map | Delegate to the campaign battlefield matchmaker; the reward counter is incremented by the battlefield settlement, not here |
| `world_boss::battlefield_entry::scheduler` | timers | | At each slot start and end broadcast 4248 |

---

## 9. Open questions and assumptions

- *(assumption)* Meaning of `para_bool1` in 4493.
- *(assumption)* Daily reset hour and the real `WarField_MaxCount` on the live server.
- The heroes sort button (`PvpHeroFrame`, `PvpHeroSortData`) is hidden in this client.

---

## 10. Implementation checklist

- [ ] 4248 at login (with 8271) and at slot changes.
- [ ] Route 8599 → 4493.
- [ ] Route 8332 delegating to the battlefield matchmaker.
- [ ] Daily reward counter and `warFieldCount` in the player info message.
- [ ] Screen check: one card per slot before job change, two after; enter only on the current slot.
