# Assistant panel ("Pequena Secretária")

Module `assistant-panel` of feature `secretary`. Panel data requests, chore visibility and costs, selection, confirmation, execution queue and the result frame.

Path aliases:

| Alias | File |
|---|---|
| SM | `decompiled/core_module/scripts/managers/SecretaryManager.as` |
| LAM | `decompiled/core_module/scripts/managers/LitteActionManager.as` |
| SD | `decompiled/core_module/scripts/mvc/module/secretary/SecretaryData.as` |
| SID | `decompiled/core_module/scripts/mvc/module/secretary/SecretaryItemData.as` |
| LAF | `decompiled/core_module/scripts/mvc/module/secretary/acts/LittleActionFactory.as` |
| LSF | `decompiled/m11/scripts/secretary/LittleSecretaryFrame.as` |
| SAF | `decompiled/m11/scripts/secretary/SecretaryAwardFrame.as` |
| SAI | `decompiled/m11/scripts/secretary/item/SecretaryAwardItem.as` |
| SCI | `decompiled/m11/scripts/secretary/item/SecretaryCompentItem.as` |
| SALI | `decompiled/m11/scripts/secretary/item/SecretaryAltarItem.as` |
| AI | `decompiled/m11/scripts/secretary/item/AltarIcon.as` |
| SCV | `decompiled/m11/scripts/secretary/view/SecretaryCompentView.as` |
| PM | `decompiled/core_module/scripts/yishi/manager/PlayerManager.as` |
| MM | `decompiled/core_module/scripts/managers/MopupManager.as` |

## 1. Overview

Opening the panel requests fresh data (tower list, altar counter, gem compose gold) and builds one `SecretaryItemData` per `AssistantTemplates` row (`SD:49-85`). Each chore computes `isOpen` (visible) and its cost from the player's current state (`SID:92-318`). The player toggles chores (`state`) and the bound diamond preference (`moneyState`). Execution pushes one action per selected visible chore into a queue (`LAM`) processed on every frame (`LSF:105-108`, `LAM:59-98`); actions send the owner routes ([chore-actions.md](chore-actions.md)). The server answers each chore with 592 `AssistantMsg`, rendered as a result block in `SecretaryAwardFrame`.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `LittleSecretaryFrame` (`LSF`) | "Pequena Secretária" | tabs, chore list, execute buttons, help | controller `SECRETARY` openType 0 (resource bar icon) | tabs = distinct `MaterType` with `TypeName` (`LSF:125-149`); chores of the tab that are `isOpen` (`SD:95-110`) |
| `SecretaryCompentItem` (`SCI`) | | one chore row: title, description, cost, tick box, "Uso de diamantes vinculados prioritários" box | `SCV:37-65` | `title` (`RoleName`), `des`, cost: `moneyType` 1 diamonds, 0 gold, 2 diamonds + gold (`SCI:166-203`); bound diamond box shown when `moneyType >= 1` |
| `SecretaryAltarItem` (`SALI`) | | altar row: 3 god icons (unlocked at altar level 1, 4, 7), rewards text, contribution and merit cost, "Bênção Rápida: {0}/{1}" | `SCV:50-54` (type 9) | `ConsortiaNewAltarFrame.goodsTxt.text{god}`, `Property1` contribution, `Altar_Reputation_Cost[god-1]` merit, remaining blessings (`SALI:116-127`) |
| `SecretaryAwardFrame` (`SAF`) | "Executando", then "Execução Concluída" | results per chore, maze sweep accelerate and cancel | controller `SECRETARY` openType 1 when the first non gem chore starts (`LSF:279-283,366-370`) | one `SecretaryAwardItem` per 592 (`SAF:117-141`) or per maze sweep start (`SAF:163-184`); title `secretary.awardtitle{type}`; maze progress "%"; items |

## 3. Routes (client to server)

### P1. Load tower list
- Sent by the panel constructor (`LSF:69`), `SM.goGettower` (`SM:90-94`).
- Route C>S 9742 (0x260e) `C_GET_TOWER_LIST`, empty body.
- Response: 4373 (0x1115) `U_C_TOWERLIST` (S1).

### P2. Load altar counter
- `ConsortiaSocketOutManager.getAltarInfo` (`LSF:70`).
- Route C>S 8215 (0x2017) `U_C_CONSORTIA_ALTERINFO`, empty body (owned by [guild buildings](../guild/buildings.md) A4).
- Response: 4141 (0x102d) `ConsortiaMsg`; the secretary reads `blessLeftTime` (`SM:65-72`).

### P3. Query gem compose gold
- `SM.gotoGetGemNum(0)` (`LSF:72`, `SM:82-88`).
- Route C>S 9741 (0x260d) `C_GEM_ONE_KEY_COMPOSE`, `PlayerOpMsg`: `op (#1, INT32)` = 0; other fields unset.
- Response: 593 (S3). The gem chore is visible only when the gold is > 0.

### P4. Execute the current tab
- UI: execute button (`LSF:205-259`).
- Client: sums for the tab's ticked visible chores: diamonds (`moneyType != 0 && !moneyState`), bound diamonds (`moneyType != 0 && moneyState`), gold (`goldNum`). If no diamonds of either kind, runs at once; otherwise confirm "Deseja executar a ação atual. Esta ação exigirá <br/> a dedução de {n} Diamantes {n} Diamantes Vinculados {n} Ouro" + "Diamantes vinculados não pertencem ao evento de consumo".
- On confirm (`LSF:261-290`): for each ticked visible chore: open `SecretaryAwardFrame` once if the chore is not type 5, enqueue `LAF.creatAction(item)`, hide the panel; flag `isFinish` at the last item.
- Routes: those of each chore ([chore-actions.md](chore-actions.md)).

### P5. Execute all
- UI: execute all button (`LSF:292-377`). Same as P4 over every chore of every tab.

### P6. Accelerate a maze sweep
- UI: accelerate button in `SAF` (visible while a maze sweep runs) (`SAF:195-242`).
- With King Contract buff 4 active: free, `MM.sendMopupInfo(2,2,0,0,0,1,false,false)`. Otherwise confirm "Aceleramento consome {0} diamantes" with `ceil(remainSeconds / (60 * 10)) * 1` diamonds (`Sweep_Fast = "1,10"`: 1 diamond per 10 minutes), alert style `USEBINDPOINT_ALERT` (bound diamond check box -> `payType` 2, else 1).
- Route C>S 8528 (0x2150) `C_CAMPAIGN_SWEEP`, `CampaignSweepReq`: `sweep_type (#1)` = 2, `op_type (#2)` = 2, `campaign_id (#3)` 0, `count (#4)` 0, `e_index (#5)` 0, `enter_type (#6)` 1, `open_silver_box (#7)` false, `open_secret_box (#8)` false, `pay_type (#9)` 1 or 2. Owned by [mopup](../mopup/README.md).

### P7. Cancel
- Cancel button in `SAF` (`SAF:283-286`) and frame close dispose the result frame; closing the panel disposes the queue (`LSF:405-420`), and a running maze action sends 8528 `sweep_type 2, op_type 4` (stop) on dispose ([chore-actions.md](chore-actions.md)).

## 4. Server messages (server to client)

### S1. 4373 (0x1115) `U_C_TOWERLIST`, `TowerListMsg`
Receiver `PM.__towerListHandler` (`PM:385-412`): `towerInfo (#1, TowerInfoMsg, repeated)` mapped to `towerInfo1/2/3` by campaign (8001, 8101, 8401). `TowerInfoMsg`: `enter_count (#1)`, `total_gp (#2)`, `tower_index (#3)` current floor of an unfinished run (0 none), `max_index (#4)` best floor, `order (#5)`, `max_enterCount (#6)`, `item_tempIds (#7, STRING)`, `free_enterCount (#8)`, `campaign_id (#9)`, `index (#10)`, `first_hitId (#11)`, `first_hitName (#12, STRING)` (all INT32 unless noted). Owned by [mazes](../mazes/README.md).

### S2. 4141 (0x102d) `U_C_CONSORTIA_ALTERINFO`, `ConsortiaMsg`
Secretary receiver `SM.__refreshAltarInfo` (`SM:65-72`) reads `blessLeftTime` = blessings already used today. Owned by [guild buildings](../guild/buildings.md).

### S3. 593 (0x0251) `U_C_GEM_ONE_KEY_COMPOSE_NEED_GOLD`, `NeedGoldMsg`
Receiver `SM.gemGoldHandler` (`SM:74-80`): `gold (#1, INT32)` gold needed to compose every gem in the bag up to level 6; 0 hides the gem chore.

### S4. 592 (0x0250) `U_C_ASSISTANT_ITEMS`, `player.AssistantMsg`
Receiver `SAF.refrshView` (`SAF:88,117-141`), only while the result frame exists.

| Field | Tag | Type | Meaning |
|---|---|---|---|
| `type` | #1 | ENUM `AssistantType` | chore: 0 `REWARD`, 1 `TOWER_SWEEP`, 2 `GEM_COMPOSE`, 3 `CONSORTIA_ALTERINFO`, 4 `LEVY`, 5 `PERKIN_LAB`, 6 `FARM` |
| `items` | #2 | `player.ItemMsg`, repeated | `itemId (#1, INT32)` template id (negative ids for currencies), `num (#2, INT32)` amount |

Client: creates `new SecretaryAwardItem(type)` whose title is `secretary.awardtitle{type}` (`SAI:36-44`), shows the items and "100%". Note the client titles are indexed 1..9 by chore type while the enum is 0..6: send the chore `SonType` (1..9) in `type` so titles match (assumption, see open questions). `player.ItemMsg` is missing from `protocol/proto.json` (name clash with `active.ItemMsg`); fields read from `decompiled/core_module/scripts/com/road/yishi/proto/player/ItemMsg.as:69-80`.

Maze sweeps do not use 592: `MM` posts `LITTLESECRETARY` when 4425 reports `status = 1` for `sweep_type 2` while the queue is open (`MM:127-138`), and the result item fills from the mopup result list (`SAI:91-152`).

## 5. Rules and formulas

Visibility (`SID:92-122`) and costs (`SID:169-318`):

| Type | Visible when | Cost shown |
|---|---|---|
| 1 | hero level >= 17 and remaining bounties > 0 | `Reward_OneKey` = 68 diamonds (`moneyType 1`) |
| 2, 3, 4 | maze `maxIndex >= 10` and (no run in progress and `enterCount < maxEnterCount`, or a run in progress below `maxIndex`) | gold `Tower_Sweep_Gold (1000) * floors` where floors = `maxIndex` or `maxIndex - towerIndex + 1`; plus keys: type 2 needs 1 key (SonType 297 count), type 3 needs 3 (4 when `dixState`), type 4 needs 3 "Chave do Purgatório" (208037); missing keys priced from the shop (`SD:143-160`); a run in progress shows "Continuar Bot" and no diamonds |
| 5 | hero level >= 15 and 593 gold > 0 | gold from 593 (`moneyType 0`) |
| 6 | hero level >= 11 and remaining levies > 0 (building 901 `property2 - property1`) | none; description "Coleta Rápida" + "used / max" |
| 7 | job advanced (`vocationGrades > 0`), a lab ready to collect and raids left (`perkin_lab_rob_count = 5` minus `robCount`) | none |
| 8 | hero level >= 12 | none |
| 9 | in a guild, `altarLevel > 0` and blessings left (`Property2` of consortia template type 3 at the altar level minus `blessLeftTime`) | contribution and merit per blessing |

Other rules:

| Rule | Value | Source |
|---|---|---|
| Queue | sequential; an action finishes before the next starts | `LAM:59-98` |
| Result frame | opened once per execution unless the only chores are gem compose | `LSF:279-283` |
| End | when the queue is empty and `isFinish`, notify `LitteActionManager` -> title "Execução Concluída", cancel button | `LAM:76-82`, `SAF:257-266` |
| Bound diamonds | default on (`moneyState = true`); bound diamonds do not count for spend events | `SCI:76`, `secretary.LittleSecretaryFrameTips10` |
| Sweep acceleration | `ceil(remain / 600) * 1` diamonds; free with King Contract buff 4 | `SAF:203-218`, `Sweep_Fast` |

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `AssistantTemplates.xml` | chore | `MaterType` (tab), `SonType` (chore type 1..9), `TypeName` (tab label), `RoleName` (chore title) |
| `ConfigInfos.xml` | constants | `Reward_OneKey` 68, `Tower_Sweep_Gold` 1000, `Tower_Sweep_Time` 6, `Sweep_Fast` "1,10", `perkin_lab_rob_count` 5, `Altar_Reputation_Cost` "0,20,30" |
| `ShopTempInfos.xml` | key prices | items 208008 "Chave do Labirinto", 208037 "Chave do Purgatório" |
| `ConsortiaLevelInfos.xml` type 3 | altar | `Property1` contribution per blessing, `Property2` blessings per day |

## 7. Persistent state

No entity of its own: every effect is stored by the owner feature. Optional audit table for support and anti abuse:

```sql
CREATE SCHEMA IF NOT EXISTS secretary;

CREATE TABLE secretary.chore_runs (
  run_id       BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  player_id    BIGINT   NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  chore_type   SMALLINT NOT NULL CHECK (chore_type BETWEEN 1 AND 9),
  pay_type     SMALLINT,
  items        JSONB    NOT NULL DEFAULT '[]',
  created_at   TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX chore_runs_player ON secretary.chore_runs (player_id, created_at DESC);
```

## 8. Backend implementation notes

| Opcode | Handler |
|---|---|
| 9742 | `secretary::assistant_panel::handle_tower_list` (delegates to the mazes service) |
| 9741 op 0 | `secretary::assistant_panel::handle_gem_gold_query` |
| 8215 | owned by guild (`guild::buildings::handle_altar_info`) |
| 8528 op 2 | owned by mopup |

- Gem gold query: simulate the one key compose ([chore-actions.md](chore-actions.md) C5) without writing and return the gold in 593.
- 592 emission: add a helper `secretary::emit_summary(player, type, items)` called at the end of the owner handlers for levy (op 2), lab (op 11), farm (op 25/26), offer reward one key (9583), gem compose (9741 op 1) and altar (5145). The client ignores 592 when the result frame is closed, so emitting it always is harmless.
- No timers, no battle.

## 9. Open questions and assumptions

- Assumption: `AssistantMsg.type` must carry the chore `SonType` (1..9), not the proto enum value, because the client uses it to index `secretary.awardtitle{type}`. With the enum (REWARD = 0) the reward title key `awardtitle0` does not exist. Verify against a capture if available.
- Assumption: 592 is also sent for the altar (enum 3 `CONSORTIA_ALTERINFO`).
- Gap: `player.ItemMsg` is absent from `protocol/proto.json`.

## 10. Implementation checklist

- [ ] Screens (client ready): `LittleSecretaryFrame`, `SecretaryCompentView`, `SecretaryCompentItem`, `SecretaryAltarItem`, `AltarIcon`, `SecretaryAwardFrame`, `SecretaryAwardItem`.
- [ ] Route 9742 -> 4373.
- [ ] Route 8215 -> 4141 (guild).
- [ ] Route 9741 op 0 -> 593.
- [ ] Route 8528 op 2 accelerate (mopup).
- [ ] Message 592 after each chore.
- [ ] Optional table `secretary.chore_runs`.
- [ ] Tests: panel shows only chores whose preconditions hold; 593 with 0 hides gem compose; executing a tab with levy and farm only shows no confirmation; 592 type 6 renders "Coleta de Impostos".
