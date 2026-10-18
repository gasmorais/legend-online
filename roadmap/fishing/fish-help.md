# Rage help ("Pedir auxílio")

Module `fish-help` of feature `fishing`. Violent fish, the 120 s help window, help requests, paid help ("robots") and the helper session.

Path aliases:

| Alias | File |
|---|---|
| FM | `decompiled/core_module/scripts/managers/FishManager.as` |
| FMO | `decompiled/core_module/scripts/mvc/module/fish/FishModel.as` |
| FF | `decompiled/m11/scripts/fish/FishFrame.as` |
| FV | `decompiled/m11/scripts/fish/view/FishView.as` |
| FHV | `decompiled/m11/scripts/fish/view/FishHelpView.as` |
| FHF | `decompiled/m11/scripts/fish/view/FishHelpFrame.as` |
| FHS | `decompiled/m11/scripts/fish/view/FishHelpSprite.as` |
| COV | `decompiled/core_module/scripts/chat/view/ChatOutputViewII.as` |
| CF | `decompiled/core_module/scripts/chat/utils/ChatFormat.as` |

## 1. Overview

When the normal harpoon (type 0) hooks exactly one fish whose `fishState == 3` (rage), the harpoon freezes and the fish is pinned (`FV:435-465`). The fisher sees `FishHelpView` with a 120 s countdown and three heart slots. Each helper who joins fills a heart. When 3 helpers are present (or the fisher pays diamonds for the missing ones) the fish is landed with the rage bonus (`RageId1 x RageCount1`); if the countdown ends it is landed without the bonus. Helpers open the fisher's pool in read only mode, watch the pinned fish and receive a reward when the help succeeds.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `FishHelpView` (`FHV`) | | fisher: help button, 120 s timer, 3 hearts; helper: hearts only | `FF:238-239`, shown on `FISH_RAGE` (`FF:359-364`); for helpers always visible (`FF:250-271`) | `playerList` nicknames in heart tips "Auxiliador: {0}" (`FHS:33-50`) |
| `FishHelpFrame` (`FHF`) | "Pedir auxílio" | three buttons: world, guild, pay | help button in `FHV` (`FHV:105-111`) | remaining time (`FHF:158-161`); closes at 0 |
| `FishFrame` as helper | "Pescar" | read only pool of another player | controller `fish`, opened by 4920 (`FM:82-98`) | fish of the fisher, pinned harpoon (`FV:294-318`) |

## 3. Routes (client to server)

All use C>S 9507 (0x2523) `C_FISH_POOL`, `FreshPoolMsg { op (#1, INT32), paras (#2, INT32, repeated) }`, sender `FM.fishAction` (`FM:197-207`).

### H1. Pin a raging fish (op 11 `CRAZYFISH`, `[1, fishId, angle, frame]`)
- Trigger: harpoon end of travel with exactly one hooked fish, harpoon type 0 and `fishState == 3` (`FV:440-458`); also called for the reinforced harpoon path (`FV:582-586`) but the type check makes it a no-op there.
- Paras: `1`, `fishId`, `angle` = integer harpoon rotation in degrees (-65..65), `frame` = harpoon movie frame (travel distance).
- Client effect: harpoon state 3 (fixed), dispatches `FISH_RAGE` -> help view with 120 s (`FF:359-364`), `model.rage = true`.
- Server: mark `rage_fish_id`, `rage_until = now + 120 s`, store angle and frame for helpers. No direct response.

### H2. Ask for help in chat (op 7 `SENDHELP`, `[2]` world or `[3]` guild)
- UI: `FHF` world / guild buttons (`FHF:73-81,112-115`).
- Server: broadcast a system chat message on the world (2) or guild (3) channel whose content contains a link element with `t="102"`, `name` (link text) and `userId` (fisher id), parsed by `CF.createSysCellDataByContent` (`CF:153-243`) into a type 30 cell (`CF:417-425`). Guild request requires a guild (assumption: silently ignored otherwise).

### H3. Paid help (op 7 `SENDHELP`, `[1]`)
- UI: `FHF` pay button (`FHF:83-110`). Price `(3 - helpers) * 5` diamonds (`Fish_Help_Point = 5`), confirm "Deseja consumir {0} diamantes para completar o auxílio!"; not enough diamonds -> recharge alert.
- On confirm the client completes locally first (`isPointHelp = true`, `pointHelp()` -> `isRageReward = true`, `over()`, `FHV:72-76,127-136`), the harpoon returns, and at the end of the catch animation it sends op 7 `[1]` instead of op 9 (`FV:645-652`).
- Server: debit diamonds, land the rage fish with the rage reward, push 4919 `result = true` to helpers, 4917, 115, 4916.

### H4. Help timeout or 3 helpers (op 9 `TIMEOVER`)
- Sent at the end of the catch animation when `model.rage` and not paid (`FV:645-656`). Reached either after 3 helpers (`isRageReward = true`, `FHV:98-102`) or after the 120 s timer (`isRageReward = false`, `FHV:166-170`).
- Server: if the session had 3 helpers, grant the rage reward and push 4919 `result = true` to helpers; otherwise grant the normal reward and push 4919 `result = false` (assumption). Then 4917, 115, 4916, 4918.

### H5. Join as helper (op 6 `HELP`, `[fisherUserId]`)
- UI: click on the chat link (`COV:1195-1230`).
- Client checks: not in battle (`ChatBar.inBattleFlag`); no Athena team ("braveleg.Error.str08"); scene not `OUTER_CITY_SCENE` ("Não pode auxiliar nesta área"). Sets `fishPoolInfo.userId = fisherUserId` and forces refuse flags.
- Expected responses to the helper, in order: 4918 (fisher's fish), 4916 (fisher's pool with `fishplayers` including the helper), 4920 (pinned fish, opens the frame). To the fisher: 4916 with the new `fishplayers`.
- Errors (fisher gone, help finished, 3 helpers already, helper is the fisher): no client message exists; assumption: send 4919 `result = false`, which disposes the helper frame (`FF:347-357`).

### H6. Helper leaves (op 8 `CLOSE`)
- UI: close as helper with confirm "Auxílio não completado, se sair agora não poderá ganhar o prêmio de auxílio, deseja sair?" (`FF:581-584`).
- Server: remove the helper from `fishplayers`, push 4916 to the fisher (language key `fish.FishFrame.exit` "Auxiliador saiu, este auxílio é inválido." exists but is unused by this client).

## 4. Server messages (server to client)

### S1. 4920 (0x1338) `U_C_FISH_CRAZY`, `CrazyFishInfoMsg`
Receiver `FM.__fishCrazyHandler` (`FM:82-98`).

| Field | Tag | Type | Meaning |
|---|---|---|---|
| `fishId` | #1 | INT32 | pinned fish (its `catchState` set to 3) |
| `angle` | #2 | INT64 | harpoon rotation (H1 `angle`) |
| `frame` | #3 | INT32 | harpoon frame (H1 `frame`) |

Client: all harpoons state 3, opens controller `fish`. Sent to a helper when he joins (H5).

### S2. 4919 (0x1337) `U_C_FISH_HELPOVER`, `HelpOverMsg`
Receiver `FM.__fishHelpOverHandler` (`FM:73-80`) -> `FF.__helpOverHandler` (`FF:347-357`).

| Field | Tag | Type | Meaning |
|---|---|---|---|
| `result` | #1 | BOOL | true: help succeeded, play the pull animation then close; false: close at once |

Sent to every helper when the help ends (success, timeout, paid completion, fisher closed).

### S3. 4916 `U_C_FISH_POOL`
See [fish-pool.md](fish-pool.md). `fishplayers` (#14) drives the hearts; with 3 entries the fisher's client finishes the help (`FHV:98-102`).

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Rage pin condition | harpoon type 0, exactly one hooked fish, `fishState == 3` | `FV:440-443` |
| Help window | 120 s | `FF:363` |
| Helpers needed | 3 (`Fish_Help_Count`) | `FHV:98`, `FHF:85`, `ConfigInfos.xml` |
| Paid help price | `(3 - helpers) * 5` diamonds (`Fish_Help_Point`) | `FHF:89` |
| Rage reward (fisher) | `RageId1 x RageCount1` in addition to `RewardId x RewardCount` | `FV:695-708`, `FishTemplateInfos.xml` |
| Helper reward | assumption: `RageId2 x RageCount2` of the pinned fish to each helper on success (help text item 3: "Auxiliando jogador a pescar poderá ganhar prêmios") | open question |
| Helper locations | not outer city, not in battle, no Athena team | `COV:1197-1210` |
| Fisher leaving with a pinned fish | loses the fish | `fish.FishFrame.selfClose`, `FF:585-588` |

## 6. Templates

| File | Fields used |
|---|---|
| `FishTemplateInfos.xml` | `RageId1`, `RageCount1`, `RageId2`, `RageCount2` |
| `ConfigInfos.xml` | `Fish_Help_Point` 5, `Fish_Help_Count` 3 |

## 7. Persistent state

Session columns `rage_fish_id`, `rage_until` live in `fishing.sessions` ([fish-pool.md](fish-pool.md)). Helpers:

```sql
CREATE TABLE fishing.session_helpers (
  fisher_id   BIGINT NOT NULL REFERENCES fishing.sessions(fisher_id) ON DELETE CASCADE,
  helper_id   BIGINT NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  joined_at   TIMESTAMPTZ NOT NULL DEFAULT now(),
  PRIMARY KEY (fisher_id, helper_id),
  CHECK (fisher_id <> helper_id)
);
CREATE UNIQUE INDEX session_helpers_one_session ON fishing.session_helpers (helper_id);

CREATE TABLE fishing.help_log (
  log_id      BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  fisher_id   BIGINT NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  helper_id   BIGINT REFERENCES player.players(player_id) ON DELETE SET NULL,
  template_id INTEGER NOT NULL,
  paid_points INTEGER NOT NULL DEFAULT 0,
  succeeded   BOOLEAN NOT NULL,
  created_at  TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX help_log_helper_day ON fishing.help_log (helper_id, created_at);
```

## 8. Backend implementation notes

| Opcode / op | Handler |
|---|---|
| 9507 op 11 `[1,...]` | `fishing::fish_help::handle_pin_rage` |
| 9507 op 7 `[2]` / `[3]` | `fishing::fish_help::handle_request_chat` |
| 9507 op 7 `[1]` | `fishing::fish_help::handle_paid_help` |
| 9507 op 9 | `fishing::fish_help::handle_time_over` |
| 9507 op 6 | `fishing::fish_help::handle_join` |
| 9507 op 8 (helper) | `fishing::fish_help::handle_leave` |

- Pin: validate the fish is `state = 3`, hooked, single; store angle and frame; start a 125 s server timer (5 s grace) that resolves the help as timeout if the client never sends op 9.
- Join validation order: fisher session exists with an active rage pin and `rage_until > now` -> helper is not the fisher -> fewer than 3 helpers -> helper not in another session -> insert helper -> send 4918, 4916, 4920 to the helper and 4916 to the fisher.
- Resolve (op 9, op 7 `[1]`, timer): one transaction: rewards to the fisher (bag 23), helper rewards on success, increment the fisher daily count, clear the pin and helpers -> push 4919 to helpers, 4917, 115, 4916, 4918 to the fisher.
- Chat request: rate limit per pin (assumption: one per channel per pin); build the system chat XML link `t="102"`.
- Pushes to other online players: helpers (4916, 4919), chat broadcast.

## 9. Open questions and assumptions

- Assumption: helper reward is `RageId2 x RageCount2` (the only unused reward column).
- Assumption: errors on join are reported with 4919 `result = false`.
- Assumption: a daily limit on helps per helper is not enforced by the client; propose 20 per day.
- Unknown: whether helpers must be friends or guild mates; the guild channel suggests anyone who sees the link.

## 10. Implementation checklist

- [ ] Screens (client ready): `FishHelpView`, `FishHelpFrame`, `FishHelpSprite`, helper mode of `FishFrame`.
- [ ] Route op 11 `[1,id,angle,frame]` pin.
- [ ] Route op 7 `[2]`, `[3]` chat link broadcast.
- [ ] Route op 7 `[1]` paid help with diamond debit.
- [ ] Route op 9 resolve.
- [ ] Route op 6 helper join.
- [ ] Route op 8 helper leave.
- [ ] Messages 4920, 4919, 4916 `fishplayers`.
- [ ] Tables `fishing.session_helpers`, `fishing.help_log`.
- [ ] Server timer for the 120 s window.
- [ ] Tests: 4th helper refused; fisher cannot help himself; paid help price with 1 helper is 10; timeout without op 9 resolves without rage reward; fisher close pushes 4919 false to helpers.
