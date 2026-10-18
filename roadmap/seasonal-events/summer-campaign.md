# Summer nine days ("Verão 9 dias", 夏日九重天)

Feature `seasonal-events`, module `summer-campaign`. Client code: `CM/yishi/manager/SumCampaignManager.as` (`SCM`), `CM/map/campaign/data/SumCampaignModel.as`, `M3/map/campaign/view/ui/sumcampaign/SumCampaignListView.as`, `SumCampaignListItem.as`, `M3/map/campaign/mediator/sumcampaign/SumCampaignUIMediator`, `M3/map/campaign/view/physics/SumCampaignArmyView.as`, `CM/yishi/view/tips/SumCampaignTip.as`. Proto `sumpassion.SumCampaignTaskListMsg`, `TaskMsg`, `ItemMsg`. The package is not listed in `features.json`; it is mapped here because it uses this feature's proto package `sumpassion`.

Conventions: see [README.md](README.md).

---

## 1. Overview

A summer PvE dungeon of 9 floors: campaign 6000, maps 6001..6009 "Verão dia 1".."Verão dia 9" (`MapInfos.xml`; `WorldBossHelper.checkSumCampaign`, `CM/yishi/utils/WorldBossHelper.as:265-268`). Each floor has three kill tasks (monsters, leaders, bosses); completing a task gives a chest ("Baú da Iniciação", "Baú Secundário", "Baú Primitivo"). Leaders drop "Passaporte do Império" keys needed to go up. The map, movement and battles are the campaign scene ([../campaign/README.md](../campaign/README.md)); this module owns the entry, the task list and the open state.

---

## 2. Screens

| Class | pt-BR text | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| Tool bar `sumcampaign` (TopToolBtnInfo 2030) | "Verão 9 dias" | Entry | `TopToolsBar.as:1329-1331` sends 9639; visible when `grades >= 6` and `openSumCampaign` (`TopBtnCheckShowHelper.as:329-330`) | |
| `SumCampaignListView` + `SumCampaignListItem` (campaign HUD, added by `CampaignMapView` for maps 6001..6009, `M3/map/campaign/view/CampaignMapView.as:283-286`) | "Prêmio de conclusão do piso", "Passaporte do Império: {0} (Drop da derrota de líder)", "Objetivo:", "Matar monstros {0}/{1}", "Matar líderes {0}/{1}", "Matar Chefões {0}/{1}" | Floor tasks | Inside the dungeon | `task` rows (`taskType` 1..3, `killCount/needKillCount`, chest name, `isSendReward` stamp), `keyCount`; tip `SumCampaignTip` with `item` rewards |
| `SumCampaignArmyView` | | Player avatar in the dungeon | Campaign walk view (`CampaignWalkView.as:394-396`) | |
| Leave prompt | "Deseja sair do Verão dia 9" | Exit | Main tool bar return (`CM/ui/maintoolbar/MainToolBar.as:2003-2006`) | |

---

## 3. Routes (client to server)

| Route | Control | Sender | Fields | Response |
|---|---|---|---|---|
| 9639 (0x25a7) `C_SUMCAMPAIGN_ENTER` | Tool bar button | `SumCampaignManager.OperateSunEnter()` (`SCM:112-116`) | empty body | Campaign enter for the current floor (campaign protocol) and 425 |

Movement, fights and floor changes use the campaign routes ([../campaign/README.md](../campaign/README.md)); leaving uses the generic campaign exit.

---

## 4. Server messages (server to client)

| Opcode | Name | Message | Receiver | When | Reaction |
|---|---|---|---|---|---|
| 425 (0x01a9) | U_C_SUMCAMPAIGN_INFO | `sumpassion.SumCampaignTaskListMsg` | `SCM.__sumlistHandler` (`SCM:56, 60-91`) | On entering a floor (full list) and after each kill (partial) | First message is kept; later ones update `killCount`, `isSendReward` by `templateId` and `keyCount`; fires `PUBLIC_SUM_CAMPAIGN`. Setting `sumListMsg` clears the cache (`SCM:107-110`) so a new floor sends a full list |
| 426 (0x01aa) | U_C_SUMCAMPAIGN_OPENSTATE | `simple.PropertyMsg` | `SCM.__openStateHandler` (`SCM:57, 93-99`) | Login, start, end | `openSumCampaign = param7` |

`SumCampaignTaskListMsg`: `task` (#1, TaskMsg, repeated); `keyCount` (#2, INT32) passports. `TaskMsg`: `templateId` (#1, INT32); `taskType` (#2, INT32) 1 monsters, 2 leaders, 3 bosses; `needKillCount` (#3, INT32); `killCount` (#4, INT32); `isSendReward` (#5, BOOL) chest given; `item` (#6, ItemMsg, repeated) chest content. `ItemMsg`: `tempId` (#1, INT32); `counts` (#2, INT32).

---

## 5. Rules and formulas

- Floors 1..9 = maps 6001..6009; the floor reached is kept per player *(assumption)*; entry places the player on the current floor.
- A task chest is granted automatically when `killCount >= needKillCount` (`isSendReward`).
- Leaders drop passports; going to the next floor consumes passports *(assumption: amount configured per floor)*.
- Battles are campaign battles against `PawnTempInfos`/`GameHeroTemp` units of campaign 6000 ([../battle/README.md](../battle/README.md)).

---

## 6. Templates

| File | Use |
|---|---|
| `MapInfos.xml` | Maps 6001..6009, `CampaignId` 6000, `MapFileId` 6001, `BattleGround` 3 |
| `ActionTempInfos.xml`, `PawnTempInfos.xml`, `GameHeroTemp.xml`, `AreaMapDropInfos.xml`, `CampaignBufferTemps.xml` | Units, drops and buffs of campaign 6000 (rows with CampaignId 6000) |

---

## 7. Persistent state (PostgreSQL, schema `seasonal_events`)

```sql
CREATE TABLE seasonal_events.summer_campaign_players (
  window_id   integer  NOT NULL REFERENCES seasonal_events.event_windows(window_id),
  player_id   bigint   NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  floor       smallint NOT NULL DEFAULT 1 CHECK (floor BETWEEN 1 AND 9),
  key_count   integer  NOT NULL DEFAULT 0,
  PRIMARY KEY (window_id, player_id)
);

CREATE TABLE seasonal_events.summer_campaign_tasks (
  window_id    integer  NOT NULL,
  player_id    bigint   NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  floor        smallint NOT NULL,
  template_id  integer  NOT NULL,
  kill_count   integer  NOT NULL DEFAULT 0,
  rewarded     boolean  NOT NULL DEFAULT false,
  PRIMARY KEY (window_id, player_id, floor, template_id)
);
```

---

## 8. Backend implementation notes

| Handler | Route | Notes |
|---|---|---|
| `seasonal_events::summer_campaign::handle_enter` | 9639 | event open → place the player on map `6000 + floor` via the campaign service → push 425 (full) |
| `seasonal_events::summer_campaign::on_kill` | campaign battle result hook | increment the task of the killed unit class, grant the chest at the goal, add passports for leaders; push 425 (partial) |

---

## 9. Open questions and assumptions

- *(assumption)* Floor progression rule and passport cost; the task templates are server data.

---

## 10. Implementation checklist

- [ ] Tool bar 2030, campaign HUD list
- [ ] 9639; 425 (full and partial), 426
- [ ] Tables `summer_campaign_players`, `summer_campaign_tasks`
- [ ] Campaign 6000 maps, units and battle hook
- [ ] Tests: enter while closed, chest granted once
