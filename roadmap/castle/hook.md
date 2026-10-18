# Hang up rooms ("Prática" in the Santuário, legacy)

Aliases: see [README.md](README.md). Extra aliases:

| Alias | File |
|---|---|
| HF | `decompiled/m9/scripts/hook/HookFrame.as` |
| HI | `decompiled/m9/scripts/hook/view/HookItem.as` |
| HC | `decompiled/core_module/scripts/mvc/controler/HookContorler.as` |
| WBS | `decompiled/core_module/scripts/managers/WorldBossSocketOutManager.as` |
| HTV | `decompiled/m3/scripts/map/campaign/view/ui/HookTimeView.as` |
| HMM | `decompiled/m3/scripts/map/campaign/mediator/mapview/HookMapMediator.as` |
| SPH | `decompiled/core_module/scripts/yishi/SwitchPageHelp.as` |

## 1. Overview

"Hook" (挂机, hang up) is the original idle training: the player enters a shared room map ("Santuário", campaign `Types = 3`), clicks a god statue ("Estátua dos Deuses") and practices ("Prática"), recovering 1 energy point ("Vigor", `playerInfo.weary`) every 2 minutes until the remaining practice runs out, the player cancels or leaves. The room list frame belongs to the `hook` package (this feature); the in map practice timer belongs to the campaign map code.

State in this build: unreachable and broken.

- `Campaigns.xml` has no row with `Types = 3`, so `HookFrame.initRoom` creates 9 empty items (`HF:63-104`), and `HookItem.refreshView` dereferences `_temp.CampaignId` with a null template (`HI:120-139`), which throws while the frame is built.
- The castle building 1504 that opens it has no template row; the other entries are the sky realm NPC option 22 (`decompiled/m3/scripts/map/space/view/frame/DialogOptionItem.as:371-372`) and the daily guide jump 22 (`decompiled/core_module/scripts/managers/DayGuideManager.as:567-569` > `SPH.gotoHookRoom`, `SPH:1547-1568`, Leader >= 21).
- `HookMapMediator` (`HMM:9-40`), the only creator of `HookTimeView`, is never registered by any map.

Recommendation: implement the stubs in section 8 so the client never hangs; do not build the feature unless templates are added.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `hook.HookFrame` (HF) | "Santuário" | 3 x 3 grid of rooms; reward button with an empty handler (`HF:123-125`) | `openControllerByInfo("hook")` after preload (`HC:32-65`) | per room "Lotado" / "Vazio" |
| `hook.view.HookItem` (HI) | room icon and name | Click enters the room (`HI:90-97`) | HF | `HC.roomState[campaignId]` |
| `map.campaign.view.frame.HookAlertFrame` | "Estátua dos Deuses", "Aqui é uma terra divina, onde prática restaura pontos de energia, iniciar prática?" | Start practice at a statue node; confirms through 5033 (campaign) | campaign map node dialog (`decompiled/m3/scripts/map/campaign/CampaignMapController.as:902-944`) | none |
| `map.campaign.view.ui.HookTimeView` (HTV) | "Contagem da Prática" | Countdown, cancel, quick finish | `HookMapMediator` (never registered) | `left_weay` |
| `map.campaign.view.frame.HookHelperFrame` | "Explicação" | Rules text: 1 energy per 2 minutes; practice ends when finished, at 0 remaining energy, on cancel or logout, remaining energy is saved | help button | static |

## 3. Routes (client to server)

### R1. Room states (preload)

- UI: opening the `hook` controller (`HC:37-46`).
- Route: C>S 8295 (0x2067) `C_HANGUP_ROOM_STATE`, empty body.
- Response: 4204 (S1). The frame opens only after 4204 arrives (`HC:53-65`).

### R2. Enter a room

- UI: `HookItem` click (`HI:90-97`) > `HC.sendEnterBattle` (`HC:114-117`) > `WBS.sendWorldBossCmd` (`WBS:23-35`).
- Client checks: 5 s throttle, "Clique excessivo, tente novamente".
- Route: C>S 8258 (0x2042) `C_WORLD_BOSS_CMD`, owned by [../world-boss/README.md](../world-boss/README.md).
- Request `worldmap.WorldBossMsg`: `param1 (#3, INT32)` = campaign id of the room; `army_id (#1)`, `map_id (#2)`, `param2 (#4)`, `param3 (#5)`, `param4 (#6)` unset.
- Response: the world boss / campaign room entry sequence ([../campaign/README.md](../campaign/README.md)).

### R3. Start practice

Campaign node confirm: C>S 5033 `CampaignReqMsg { paraInt1 = mapId, paraInt2 = nodeId, paraBool1 = confirmed }` (`decompiled/m3/scripts/map/net/MapSocketOuterManager.as:82-90`), owned by [../campaign/README.md](../campaign/README.md). Expected push: 4200 with `is_startHangup = true`.

### R4. Cancel practice

- UI: `HookTimeView._cancel`, confirm "Cancelar prática" (`HTV:230-249`).
- Route: C>S 8292 (0x2064) `C_CANCEL_HANGUP`, empty body.
- Response: 4200 with `is_startHangup = false`.

### R5. Finish practice now

- UI: `HookTimeView._button` (`HTV:251-285`), tooltip "Acelerar resfriamento (Gratuito no Contrato dos Elfos)".
- Client checks: `left_weay != 0`; with the Elf Contract buff 4 ([../returning-players/README.md](../returning-players/README.md), `KingContractManager.checkHasBuffById(4)`) sends without confirm; otherwise cost `min(left_weay, 200 - weary)` diamonds, confirm "Concluir prática imediatamente consumirá {0} diamantes".
- Route: C>S 8293 (0x2065) `C_QUICK_HANGUP_TIME`.
- Request `player.PayTypeMsg`: `pay_type (#1, INT32)`: 0 = bound diamonds allowed, 1 = real only (`HTV:301-317`).
- Response: 4235 (S3) with the energy granted, then 4200 with `is_startHangup = false`, then 3 for diamonds.

## 4. Server messages (server to client)

### S1. 4204 (0x106c) `U_C_HANGUP_ROOM_STATE`

Message `campaign.HangupStateListMsg`. Receiver `HC.__updateRoomState` (`HC:53-65`).

| Field | Tag, type | Meaning |
|---|---|---|
| `max_count` | #1 INT32 | room capacity |
| `hangupState` | #2 MESSAGE `HangupStateMsg`, repeated | per room: `cur_count (#1, INT32)` players inside, `campaignId (#2, INT32)` |

Client: `cur_count >= max_count / 2` shows "Lotado", else "Vazio" (`HC:73-80`).

### S2. 4200 (0x1068) `U_C_HANGUP_STATE`

Message `campaign.HangupInfoMsg`. Receiver `HTV.__hookStateHandler` (`HTV:164-185`).

| Field | Tag, type | Meaning |
|---|---|---|
| `left_weay` | #1 INT32 | practice energy still to gain; timer = `left_weay * 2 * 60` seconds (`HTV:210-218`) |
| `is_startHangup` | #2 BOOL | true shows the countdown; false hides it |
| `add_weay` | #3 INT32 | energy gained (shown on the player army when stopping) |

### S3. 4235 (0x108b) `U_C_HANGUP_SYNC`

Same message. Receiver `HTV.__timeUpdateHandler` (`HTV:141-162`): `weary += add_weay`, updates `left_weay`, chat line "Através da prática, recuperou 1 ponto de energia". When: every 2 minutes of practice (1 point) and on quick finish (all points).

### Related daily reset

`player.DataResetMsg` (4202): `hangup_count (#2, INT32)`, `left_hangupWeary (#6, INT32)`; owned by the daily reset sender ([../hero/README.md](../hero/README.md)).

## 5. Rules and formulas

- Leader >= 21 to open from the daily guide (`SPH:1557-1562`).
- Energy cap `Player_weary = 200`; practice gives 1 point per 120 s.
- Quick finish cost: `min(left_weay, 200 - weary)` diamonds; free with Elf Contract buff 4.
- Practice ends at 0 remaining energy, on cancel, on logout; remaining energy is saved (help text).

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `raw/xml/tempinfos/Campaigns.xml` | rooms with `Types = 3` | none exist in this build |
| `raw/xml/tempinfos/ConfigInfos.xml` | | `Player_weary = 200` |

## 7. Persistent state

Not needed while the feature is unreachable. If revived:

```sql
CREATE TABLE castle.hangup_sessions (
    player_id      bigint      PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
    campaign_id    integer     NOT NULL,
    left_energy    smallint    NOT NULL CHECK (left_energy >= 0),
    started_at     timestamptz NOT NULL DEFAULT now(),
    last_tick_at   timestamptz NOT NULL DEFAULT now()
);
```

## 8. Backend implementation notes

- `castle::hook::handle_room_state` (8295): reply 4204 with `max_count = 0` and no rooms (the client only needs the reply to finish the preload; the frame still fails on its own).
- `castle::hook::handle_cancel` (8292): reply 4200 `{ left_weay: 0, is_startHangup: false, add_weay: 0 }`.
- `castle::hook::handle_quick_finish` (8293): same reply as cancel; no charge.
- 8258 and 5033 stay with their owners.

## 9. Open questions and assumptions

- Assumption: hang up was removed from the BR server (no rooms, no mediator registration).
- Open: `left_weay` source (daily `left_hangupWeary`).

## 10. Implementation checklist

- [ ] Stubs for 8295, 8292, 8293.
- [ ] Test: opening "hook" through a crafted call does not hang the client waiting for 4204.
