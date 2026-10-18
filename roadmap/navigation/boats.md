# Navigation ships

Feature [navigation](README.md), module `boats`. Aliases in [README.md](README.md). Common request/response format in [hub.md](hub.md).

## 1. Overview

- Up to 5 ships. The first ship is owned from the start (assumption: created when navigation is first used); each further slot is activated for 500 diamonds (`navigation_boat_activate_point`).
- Ship level 1..9 (`UpGradeTempInfos.xml` Types 118). Upgrading costs "Moedas de Navegação" (`Data` of the next level) and takes `navigation_boat_upgrade_cd = 600` minutes (10 h). Each level reduces expedition time by `ActiveObject` minutes ("Tempo de navegação diminui {0}min").
- While a ship upgrades, its owner can invite up to 3 online friends per day (level >= 80). Each friend who accepts spends 20 strength, earns 40 coins and cuts the upgrade by `navigation_boat_upgrade_speedup_cd = 10` minutes; a player can assist 5 times per day.
- Ship states (`NavigationBoatMsg.state`, frame `state + 1` of `NavigationBoatItem.stateImage`): 0 idle (can upgrade, sail, fish); 1 sailing on an expedition (assumption); 2 resting after an expedition, `navigation_boat_stopping_cd = 10` minutes (assumption); 3 upgrading (assist possible); 4 fishing (`NMOD:148-162`). Frame 6 marks a locked slot.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `NAV/NavigationBoatFrame.as` (605 x 465) | "Navio" (`:324-328`) | 5 ship slots, current/next level effects, upgrade, invite friends, "Ver Nível" link (`:74-307`) | ship hotspot (openType 2) | selected ship `grade`, `state`, `boatCd` countdown for states 2 and 3 (`:270-276`); coins `currency`; "Moedas de navegação necessárias para elevar: {0}" |
| `NAV/NavigationBoatItem.as` | | Ship slot cell; "activate" button on the first empty slot (`:120-184`) | ship frame, patrol frame | `grade`, `state` |
| `NAV/NavigationBoadUpgradeView.as` | "Tempo de navegação diminui {0}min" | Level number and effect (`:46-60`) | ship frame | Types 118 row |
| `NAV/NavigationBoatPreviewFrame.as` (345 x 480) | "Ver Nível" | 9 ship pictures with the time reduction tip (`:40-66`) | "Ver Nível" link (openType 5) | Types 118 |
| `NAV/NavigationInviteFrame.as` (285 x 480) | "Auxiliar Amigo"; "Hoje poder convidar: {0}/{1}", "Hoje poder auxiliar: {0}/{1}" | Paged list of online friends level >= 80, multi select, invite (`:73-237`) | "assist" button, only for a ship in state 3 (`NAV/NavigationBoatFrame.as:203-211`) | friends, `inviteNum`, `assistNum` |
| `NAV/NavigationInviteItem.as` | "Convidado" | Friend row with level | invite frame | `ThaneInfo` |
| `decompiled/core_module/scripts/yishi/view/frame/NavigationInviteAssistFrame.as` (330 x 120) | "Convite de auxílio de navegação" | Popup on the friend's screen with a 10 s countdown (`:130-137`) | push 343 | inviter name, strength cost 20, coins 40, assists left |

## 3. Routes (client to server)

### R1. Activate ship slot (op 0)

- UI: activate button on an empty slot (`NAV/NavigationBoatItem.as:120-154`).
- Client checks: confirmation "Deseja consumir {0} diamantes para ativar este navio?" (500) with the "use bound diamonds" checkbox (`USEBINDPOINT_ALERT`); `allPoint` (bound + real) or `point` (real) >= 500 else recharge.
- Request: `op = 0`, `param1 = ""`, `param2 = ""`, `param3 = useBound ? 0 : 1`.
- Expected: 341 `{op: 0}`, 342 with the new ship (`grade = 1`, `state = 0`), player info 3.

### R2. Upgrade ship (op 3)

- UI: "Elevar" button, enabled only when the selected ship has `state == 0` and a next level exists (`NAV/NavigationBoatFrame.as:175-201`, `:250-262`).
- Client checks: `currency >= next.Data` else "Moedas de navegação insuficiente, não é possível elevar"; confirmation "Deseja consumir {0} moedas de navegação para elevar este navio? (Tempo de elevação: {1}h)" with `{1} = navigation_boat_upgrade_cd / 60`.
- Request: `op = 3`, `param1 = boatId`, `param2 = ""`.
- Expected: 341 `{op: 3}`, 342 with the ship in `state = 3`, `cd = now + 600 min` (epoch ms), coins reduced. At `cd`: ship `grade += 1`, `state = 0`; send 341 `{op: 7}` (BOAT_UPGRADE_FINISHED) then 342.

### R3. Invite friends to speed up (op 4)

- UI: "Convidar" in `NavigationInviteFrame` (`NAV/NavigationInviteFrame.as:168-206`).
- Client checks: at least one selected friend ("Amigos online que não podem ser convidados." when the list is empty, "Nenhum amigo ainda foi escolhido." when nothing is selected); `inviteNum < navigation_boat_upgrade_invite_num (3)` else "Nº de convites diários esgotados". Friends listed: online and level >= 80 (`:109-126`).
- Request: `op = 4`, `param1 = boatId`, `param2 = ""`, `param3 = 0`, `param4 = 0`, `param5 = [friend userIds]`.
- Expected: 341 `{op: 4}`, 342 with `inviteNum + 1` (one invitation per click, assumption: not per friend); push 343 to each selected friend who is online.

### R4. Assist a friend (op 5)

- UI: `NavigationInviteAssistFrame` confirm (`decompiled/core_module/scripts/yishi/view/frame/NavigationInviteAssistFrame.as:144-172`). The popup closes by itself after 10 s.
- Client checks: `assistNum < navigation_boat_upgrade_assist_num (5)` else "Chances de auxílio diário esgotadas"; confirmation "Deseja consumir {0} pontos de movimento para ajudar amigo a elevar navio?"; `strength >= 20` else "Pontos de movimento insuficiente, não é possível auxiliar".
- Request: `op = 5`, `param1 = boatId` (from 343), `param2 = token` (from 343), `param3 = inviter playerId`.
- Expected to the helper: 341 `{op: 5}`, 342 with `strength - 20`, `currency + 40`, `assistNum + 1`. To the owner if online: 341 `{op: 5}` (or 6) and 342 with the reduced `cd`.

## 4. Server messages (server to client)

### 343 (0x0157) `U_C_NAVIGATION_BOAT_UPGRADE_INVITE_EVENT`

- `NavigationBoatUpgradeInviteMsg` (package `pet`): `playerId` (#1, INT32) inviter id; `playerName` (#2, STRING) inviter nickname; `boatId` (#3, STRING) ship id; `token` (#4, STRING) one time invitation token.
- Receiver: `BaseManager.__navigationInviteAssistHandler` (`BM:3068-3088`, listener `BM:338`). Ignored during battle or while another invitation popup is open (`existNavigationInvite`).
- When: R3, to each invited online friend.

### 342 ship rows

`NavigationBoatMsg` (package `pet`), field `boat` (#10) of `NavigationMsg`: `id` (#1, STRING) ship id (sorted as string); `grade` (#2, INT32) level 1..9; `state` (#3, INT32) see overview; `cd` (#4, INT64) epoch ms when the current state ends (expedition return, rest end, upgrade end). Client stores `cd / 1000` and compares with server seconds (`NM:184-197`, `NAV/NavigationBoatFrame.as:275`).

### 341

`{op: 0|3|4|5}` as replies, `{op: 1}` (BOAT_IDLE, ship back to idle), `{op: 2}` (BOAT_STOPPING, ship back from expedition and resting), `{op: 7}` (upgrade finished) as events.

## 5. Rules and formulas

| Key | Value | Meaning |
|---|---|---|
| `navigation_boat_activate_point` | 500 | diamonds per slot |
| `navigation_boat_upgrade_cd` | 600 | upgrade minutes |
| `navigation_boat_upgrade_invite_num` | 3 | invitations per day |
| `navigation_boat_upgrade_assist_num` | 5 | assists per day |
| `navigation_boat_upgrade_speedup_cd` | 10 | minutes cut per assist |
| `navigation_currency_assist_speedup` | 40 | coins earned per assist |
| `navigation_strength_assist_speedup` | 20 | strength per assist |
| `navigation_boat_stopping_cd` | 10 | rest minutes after an expedition (assumption on unit) |

Upgrade table (`UpGradeTempInfos.xml` Types 118, `Grades`, `Data` coins, `ActiveObject` expedition minutes saved): 1: 0/0, 2: 40/2, 3: 120/6, 4: 200/10, 5: 500/14, 6: 800/18, 7: 1200/22, 8: 1600/26, 9: 2000/30 (max).

- Slots: max 5 (`NAV/NavigationBoatFrame.as:130-145`); only the slot right after the last owned one can be activated (`NAV/NavigationBoatItem.as:179-183`).
- A token is valid for one assist by the invited player, while the ship is still upgrading (assumption). One assist per friend per upgrade (assumption).
- Upgrade cannot finish below `now`; assists clamp `cd` at `now` and finish the upgrade immediately when reached.

## 6. Templates

- `raw/xml/tempinfos/UpGradeTempInfos.xml` Types 118 (above).
- Config keys above (`CFG:287-325`).

## 7. Persistent state

```sql
CREATE TABLE navigation.ship (
  ship_id      UUID        PRIMARY KEY,
  player_id    BIGINT     NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  slot         SMALLINT    NOT NULL CHECK (slot BETWEEN 1 AND 5),
  grade        SMALLINT    NOT NULL DEFAULT 1 CHECK (grade BETWEEN 1 AND 9),
  state        SMALLINT    NOT NULL DEFAULT 0 CHECK (state BETWEEN 0 AND 4),
  state_ends_at TIMESTAMPTZ,
  UNIQUE (player_id, slot)
);
CREATE INDEX ship_timer_idx ON navigation.ship (state_ends_at) WHERE state_ends_at IS NOT NULL;

CREATE TABLE navigation.upgrade_invite (
  token        TEXT        PRIMARY KEY,
  ship_id      UUID        NOT NULL REFERENCES navigation.ship(ship_id) ON DELETE CASCADE,
  inviter_id   INTEGER     NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  invitee_id   INTEGER     NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  created_at   TIMESTAMPTZ NOT NULL DEFAULT now(),
  used_at      TIMESTAMPTZ,
  UNIQUE (ship_id, invitee_id)
);
```

`ship_id` is sent as the STRING `id`.

## 8. Backend implementation notes

- `navigation::boats::handle_activate` (op 0): owned ships < 5 -> charge 500 diamonds per `param3` -> insert ship in the next slot.
- `navigation::boats::handle_upgrade` (op 3): ship owned, `state = 0`, next level exists, `currency >= Data` -> deduct coins, `state = 3`, `state_ends_at = now + 600 min`; schedule completion.
- `navigation::boats::handle_invite` (op 4): ship `state = 3`, `invites_today < 3`, each id in `param5` is a friend, online, level >= 80 -> create tokens, increment `invites_today`, push 343 to each.
- `navigation::boats::handle_assist` (op 5): token exists, unused, matches `param1` and `param3`, invitee = sender, ship still `state = 3`, `assists_today < 5`, `strength >= 20` -> one transaction: mark token used, helper `strength -= 20`, `currency += 40`, `assists_today += 1`, ship `state_ends_at -= 10 min`. Push 341/342 to both players.
- Timer `navigation::boats::on_state_end`: state 3 -> grade + 1, state 0, event op 7; state 1 -> handled by [ports.md](ports.md) (reward) then state 2 with `now + rest`, event op 2; state 2 -> state 0, event op 1.
- No battles.

## 9. Open questions and assumptions

- Meaning of states 1 and 2 (sailing, resting) and the unit of `navigation_boat_stopping_cd` (minutes assumed).
- Whether the first ship is free and when it is created.
- Whether op 6 (BOAT_UPGRADE_SPEEDUP, self speed up with diamonds) exists server side; no client sender.
- Whether `inviteNum` counts clicks or invited friends.

## 10. Implementation checklist

- [ ] Screen: `NavigationBoatFrame` slots, effects, countdown
- [ ] Screen: `NavigationBoatPreviewFrame`
- [ ] Screen: `NavigationInviteFrame` friend list
- [ ] Screen: `NavigationInviteAssistFrame` popup
- [ ] Route R1 op 0 activate
- [ ] Route R2 op 3 upgrade and completion event op 7
- [ ] Route R3 op 4 invite and push 343
- [ ] Route R4 op 5 assist
- [ ] Server message 343
- [ ] Table `navigation.ship`
- [ ] Table `navigation.upgrade_invite`
- [ ] Template loader Types 118
- [ ] Timer: upgrade end, rest end
- [ ] Test: assist from a non invited player refused
- [ ] Test: assist cap 5 and strength cost
