# Server function switches and version flags

Area: account, module `switches`. Covers the server driven feature flags pushed with `4422 U_C_SWITCH` (`SwitchInfoListMsg`, proto package `switches`), the login version flags `4233 U_C_SEND_VERSION` (`VersionMsg`), and the unused `TimerInfoListMsg` (proto package `timer`).

Conventions: see [login-session.md](login-session.md). Paths are relative to the repository root.

## 1. Overview

Operators open or close systems and time windowed events without a client release. The client keeps the values in `ConfigManager.info` (`SwitchInfo`) and checks them before showing buttons or opening frames. The list is requested at login with `8224 {switches:true}` (phase B, [login-session.md](login-session.md)) and can be pushed again at any time (for example when an event starts).

## 2. Screens

None of its own. Switches show or hide: the customer service button ([../customer-service/README.md](../customer-service/README.md)), the mail check popup and toolbar button, Facebook share button, anti-addiction view, security code puzzle ([security-code.md](security-code.md)), event buttons on the top toolbar (Gold Road, Blackjack, Bingo, Assault War, SQ Memory, New Year NPCs, Birthday), chat ban window, quiz system.

## 3. Routes (client to server)

No dedicated request. The list is pushed as part of `8224` phase B (`switches (#22) = true`, `decompiled/core_module/scripts/yishi/lunch/LoginInitDataAccept.as:86-96`).

## 4. Server messages (server to client)

### `4422 U_C_SWITCH` (0x1146), `SwitchInfoListMsg` (package switches)

Fields: `switches (#1, MESSAGE SwitchInfoMsg, repeated)`.

`SwitchInfoMsg`: `switch_id (#1, INT32)` row id (not read by the client), `switch_type (#2, INT32)` which system, `is_open (#3, BOOL)`, `begin_date (#4, STRING)` "YYYY-MM-DD hh:mm:ss", `end_date (#5, STRING)`.

- Receiver: `BaseManager.__switchesUpdateHandler` (`decompiled/core_module/scripts/yishi/manager/BaseManager.as:1505-1615`), registered at `BaseManager.as:316`.
- When: response to `8224 {switches:true}`; push on change (only changed rows are needed, each row is applied independently).

`switch_type` table (`BaseManager.as:1513-1614`):

| switch_type | Field set | Dates used | Effect / consumer |
|---:|---|---|---|
| 1 | `CLIENT_DOWNLAND` | no | Desktop client download task and sign-in bonus (`decompiled/core_module/scripts/mvc/module/task/TaskCategory.as:74`, `decompiled/m11/scripts/dayguide/SignView.as:129`) |
| 2 | `MOBILE_TASK` | no | Mobile binding task (`TaskCategory.as:86`) |
| 3 | `CUSTOMER_SERVICE` | no | Customer service button enable (`decompiled/core_module/scripts/mainBar/SmallMapBar.as:541`, event `CUSTOMER_SERVICE_SWITCH` at `:453`) |
| 11 | `VOICE` | no | Voice consulting entries in customer service (`decompiled/m11/scripts/customerService/view/ConsultingGameView.as:32`) |
| 13 | `AAS` | no | Anti-addiction (keep closed in BR) |
| 14 | `SECURITY_CODE` | no | Puzzle allowed ([security-code.md](security-code.md)) |
| 15 | `BEHAVIOR_ANALYSIS` | no | Flag only; the client dispatches `BEHAVIOR_ANALYSIS` notifications from bag, task and store frames regardless |
| 127 | `ANSWER_SYSTEM` | no | Quiz system at level >= 30 (`decompiled/core_module/scripts/yishi/manager/AnswerManager.as:85`, [../quiz/README.md](../quiz/README.md)) |
| 223 | `FORBIT_CHAT` | begin, end into `ChatManager.model` | Chat ban window (`decompiled/core_module/scripts/chat/ChatSocketOutManager.as:66`, [../chat/README.md](../chat/README.md)) |
| 1001 | `FACE_BOOK` | no | Facebook share button at level >= 20 (`SmallMapBar.as:575`, `:1187`) |
| 2003 | `tiroActStarTime/EndTime` | begin, end (strings) | Newcomer activity window |
| 2005 | `NewYearActManager.loginModel` | begin, end | New Year login event ([../seasonal-events/README.md](../seasonal-events/README.md)) |
| 2007 | `BirthdayManager.setBirthdaySwitch` | begin, end | Birthday event |
| 3031 | `GOLDROAD` | begin, end | Gold Road button (level >= 18, `decompiled/core_module/scripts/ui/toptoolbar/TopBtnCheckShowHelper.as:336`) |
| 3060 | `BLACKJACK` | begin, end | Blackjack button (level >= 6, `TopBtnCheckShowHelper.as:284`, [../casino/README.md](../casino/README.md)) |
| 3064 | `NEW_YEAR_MODULE` | begin, end | New Year NPC 32 visibility in the sky city (`SPACE_NPC_VISIBLE`) |
| 3066 | `MAIL_CHECK` | no | Mail check toolbar entry and login popup ([../customer-service/README.md](../customer-service/README.md)) |
| 3068 | `BINGO` | begin, end | Bingo button (level >= 11, `TopBtnCheckShowHelper.as:294`) |
| 3069 | `ASSAULTWAR` | no | Assault War button |
| 3073 | `SQ_MEMORY` | begin, end | SQ Memory event (level >= 80, `TopBtnCheckShowHelper.as:420`) |

Unknown types are ignored. Date windows are evaluated client side against the server clock (`playerModel.nowDate`).

### `4233 U_C_SEND_VERSION` (0x1089), `VersionMsg` (package player)

Fields: `open_version (#1, BOOL)`, `version_id (#2, INT32)`, `open_story (#3, BOOL)`, `module (#4, INT32)`.

- Receiver: `LoginInitDataAccept.__versionHandler` (`LoginInitDataAccept.as:316-325`). Counted in phase A of the login (mandatory).
- `open_version` -> `playerInfo.showVersion`: shows the update announcement popup after login (`decompiled/core_module/scripts/yishi/lunch/Yishi.as:600-604`, [notices.md](notices.md)) and enables "new feature" hints in the castle (level >= 55, `decompiled/m4/scripts/castle/CastleSceneView.as:370`), equipment (`decompiled/m5/scripts/armyII/viewII/equip/EquipView.as:431`) and Einherjar (`decompiled/m14/scripts/pet/PetFrame.as:132`) views; those views clear it after showing.
- `open_story` -> `showStory`, `module` -> `showStoryModule` (story / time story hints, owned by [../time-story/README.md](../time-story/README.md)).
- `version_id` is not read.

### `TimerInfoListMsg` (package timer)

Fields: `timerInfo (#1, MESSAGE TimerInfoMsg, repeated)`; `TimerInfoMsg`: `type (#1, INT32)`, `index (#2, INT32)`, `name (#3, STRING)`, `readyOpen (#4, STRING)`, `readyStop (#5, STRING)`, `finalOpen (#6, STRING)`, `finalStop (#7, STRING)`, `param1 (#8, STRING)`, `param2 (#9, STRING)`, `param3 (#10, STRING)`, `signupTime (#11, STRING)`.

No class outside the proto package reads it (searched the decompiled tree). Do not implement a sender; keep the schema for future activity calendars.

## 5. Rules and formulas

- A switch row with dates is "active" when `is_open && begin <= now < end` (client rule, for example `TopBtnCheckShowHelper.as:284`). The server must apply the same rule before accepting any request of the gated system.
- `version_id` should increase on each update announcement so the server can send `open_version = true` only once per player per version (assumption).

## 6. Templates

None. `raw/config.xml` has an empty `<SWITCHS>` node per site (`raw/config.xml:30`), not read by the decompiled code.

## 7. Persistent state

```sql
CREATE TABLE account.feature_switches (
  switch_id      SERIAL      PRIMARY KEY,
  switch_type    INT         NOT NULL UNIQUE,
  is_open        BOOLEAN     NOT NULL DEFAULT false,
  begin_at       TIMESTAMP,
  end_at         TIMESTAMP,
  note           TEXT,
  updated_at     TIMESTAMPTZ NOT NULL DEFAULT now(),
  CHECK (end_at IS NULL OR begin_at IS NULL OR end_at > begin_at)
);

CREATE TABLE account.client_versions (
  version_id     SERIAL      PRIMARY KEY,
  published_at   TIMESTAMPTZ NOT NULL DEFAULT now(),
  open_story     BOOLEAN     NOT NULL DEFAULT false,
  story_module   INT         NOT NULL DEFAULT 0
);

CREATE TABLE account.player_version_seen (
  player_id      BIGINT      PRIMARY KEY REFERENCES player.players(player_id),
  version_id     INT         NOT NULL REFERENCES account.client_versions(version_id),
  seen_at        TIMESTAMPTZ NOT NULL DEFAULT now()
);
```

Dates are stored as server local time without zone because the client parses them without a zone.

## 8. Backend implementation notes

- `account::switches::push_login_switches` (called from `8224` phase B): send every row of `feature_switches` in one `4422`.
- `account::switches::push_login_version` (phase A): `open_version = player_version_seen.version_id < max(version_id)`; then upsert `player_version_seen` (assumption: shown once per version).
- Admin change: update the row and broadcast `4422` with that row to all online players.
- `account::switches::is_open(switch_type, now)` used by the gated systems (customer service, mail check, security code, events).
- Seed for BR: 3 open, 11 closed, 13 closed, 14 open, 15 closed, 127 open, 1001 closed, 3066 open (assumption, adjust to product).

## 9. Open questions and assumptions

- Assumption: switch rows are global, not per player.
- Assumption: `open_version` is per player per version.
- Open: original BR values for each switch type.

## 10. Implementation checklist

- [ ] `account.feature_switches` with BR seed
- [ ] `4422` in login phase B and broadcast on change
- [ ] `4233` in login phase A with `open_version` logic
- [ ] `is_open` helper used by gated systems
- [ ] Tables `account.client_versions`, `account.player_version_seen`
- [ ] Test: closing type 3 disables the customer service button live
- [ ] Test: dated switch outside its window hides the event button
