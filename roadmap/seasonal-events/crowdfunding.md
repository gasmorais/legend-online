# Recharge crowdfunding ("Recarga de Coletivo", 充值众筹)

Feature `seasonal-events`, module `crowdfunding`. Client package `publicchairs` (`M11/publicchairs/PublicChairsFrame.as`), shared `CM/yishi/manager/PublicChairsManager.as` (`PCM`). Proto `active.ChairsListMsg`, `ChairsChargeMsg`, `ChairsRewardMsg` (package `active`, assigned to this feature). The client package is not listed in `features.json`; it is mapped here because it uses this feature's proto package and runs as a time limited event.

Conventions: see [README.md](README.md).

---

## 1. Overview

A cross-server crowdfunding round. Every `chairsNeedPoints` diamonds recharged give the player one crowdfunding certificate ("certificado de financiamento coletivo"). All certificates of all players fill a progress bar to `rewardNeedChairs`; at 100% every certificate pays the comfort reward (`comfortItems`), one certificate holder is drawn for the lucky prize (`luckyItems`), and all certificates reset for the next round. Winners are listed ("Parabéns, os jogadores abaixo obtiveram o grande prêmio da sorte").

---

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `publicchairs.PublicChairsFrame` | "Recarga de Coletivo" | Progress and claims | Tool bar `publicchairs` (TopToolBtnInfo 2015, `TopToolsBar.as:1305-1306`), visible when `grades >= 6` and `openChairs` (`TopBtnCheckShowHelper.as:317-318`) | progress `totalChairsCount / rewardNeedChairs` ("max" at 100%, `PublicChairsFrame.as:254-271`), my certificates `currentChairs`, pending rewards `rewardCounts` (claim button enabled when > 0), next certificate text ("Sempre que recarregar {0} diamantes..." with `chairsNeedPoints`, or "Continuando a recarregar {0} diamantes..." with `leftPoint`), lucky winners `luckyNickName`, reward tips (`luckyItems`, `comfortItems`), countdown to `stopTime`, recharge button |

---

## 3. Routes (client to server)

Route: **9638 (0x25a6) `C_CHAIRS_CLIENT_OP`**, body `active.ChairsListMsg` with only `op (#1, INT32)`; sender `PublicChairsManager.OperateChairsReq(op)` (`PCM:73-79`).

| op | UI control | Call site | Client checks | Response |
|---|---|---|---|---|
| 1 REQUEST | Frame opens | `PublicChairsFrame` (`PublicChairsFrame.as:84`) | none | 415 |
| 2 TAKEREWARD | "collect" | `PublicChairsFrame.__receiveHandler` (`:166-170`) | `rewardCounts > 0` | 415 with `rewardCounts = 0`; bag pushes |

---

## 4. Server messages (server to client)

| Opcode | Name | Message | Receiver | When | Reaction |
|---|---|---|---|---|---|
| 414 (0x019e) | U_C_CHAIRS_OPENSTATE | `simple.PropertyMsg` | `PCM.__openstateHandler` (`PCM:47, 59-65`) | Login, start, end | `openChairs = param7`; tool bar refresh |
| 415 (0x019f) | U_C_CHAIRS_INFO | `active.ChairsListMsg` | `PCM.__chairslistHandler` (`PCM:46, 50-57`) | op 1, op 2; push on recharge and when a round completes | stores the message, fires `PUBLIC_CHAIRS_UPDATE` |

`ChairsListMsg`: `op` (#1, INT32); `totalChairsCount` (#2, INT32) certificates in the round (all servers); `reward` (#3, ChairsRewardMsg, repeated) not read; `charge` (#4, ChairsChargeMsg, repeated) not read; `userId` (#5, INT32); `luckyNickName` (#6, STRING, repeated) last winners; `currentChairs` (#7, INT32) my certificates; `rewardCounts` (#8, INT32) my unclaimed comfort rewards; `rewardNeedChairs` (#9, INT32) round size; `chairsNeedPoints` (#10, INT32) diamonds per certificate; `openTime` (#11, STRING), `stopTime` (#12, STRING); `chairsNum` (#13, STRING) not read; `luckyItems` (#14, STRING, repeated) "templateId\|count"; `comfortItems` (#15, STRING, repeated); `leftPoint` (#16, INT32) diamonds missing for the next certificate.

`ChairsChargeMsg` (`userId`, `totalPoint`, `currentPoint`, `tokenCount`, `uuid`, `site`, `serverName`, `param1`, `param2`) and `ChairsRewardMsg` (`cCCActiveUUID`, `uUID`, `userId`, `tokenChairs`, `rewardTypes`, `rewardState`, `serverName`) are the cross-server bookkeeping rows; the client never reads them *(assumption: server to cross-server use)*.

---

## 5. Rules and formulas

- Certificates: `floor((recharge_in_event + carry) / chairsNeedPoints)`; `leftPoint = chairsNeedPoints - carry`.
- Round completion when `totalChairsCount >= rewardNeedChairs`: each certificate of each player adds one `rewardCounts` (comfort reward); one certificate is drawn uniformly for the lucky prize *(assumption: weighted by certificates, as the text "Quanto mais certificados tiver, maior será a chance")*; certificates reset.
- Tool bar requires `grades >= 6`.

---

## 6. Templates

None (server configuration).

---

## 7. Persistent state (PostgreSQL, schema `seasonal_events`)

```sql
CREATE TABLE seasonal_events.crowdfunding_rounds (
  round_id        serial PRIMARY KEY,
  event_uuid      text    NOT NULL,
  need_chairs     integer NOT NULL,
  total_chairs    integer NOT NULL DEFAULT 0,
  lucky_player_id bigint  REFERENCES player.players(player_id),
  completed_at    timestamptz
);

CREATE TABLE seasonal_events.crowdfunding_players (
  event_uuid     text    NOT NULL,
  player_id      bigint  NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  carry_points   integer NOT NULL DEFAULT 0,
  current_chairs integer NOT NULL DEFAULT 0,
  reward_counts  integer NOT NULL DEFAULT 0,
  PRIMARY KEY (event_uuid, player_id)
);
```

---

## 8. Backend implementation notes

| Handler | Route | Notes |
|---|---|---|
| `seasonal_events::crowdfunding::handle_request` | 9638 op 1 | 415 |
| `seasonal_events::crowdfunding::handle_take_reward` | 9638 op 2 | `reward_counts > 0` → grant `comfortItems x reward_counts` → 0; 415 |

- Recharge hook adds certificates, may complete the round (cross-server lock), then pushes 415 to online participants.

---

## 9. Open questions and assumptions

- *(assumption)* Lucky draw weighting and whether rounds repeat until `stopTime`.

---

## 10. Implementation checklist

- [ ] Tool bar 2015, frame
- [ ] 9638 ops 1, 2; 414, 415
- [ ] Tables `crowdfunding_rounds`, `crowdfunding_players`
- [ ] Recharge hook and round completion
- [ ] Tests: claim with 0 rewards, round completion resets certificates
