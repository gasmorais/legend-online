# Terrálem season, sign up and state

Feature [outyard](README.md), module `season`. Aliases in [README.md](README.md).

## 1. Overview

- Two schedules run on the same battlefield:
  - crystal war ("stack head", [crystal-war.md](crystal-war.md)): `stack_head_open_week_day = 1,3,5` (Monday, Wednesday, Friday), sessions `12:00-12:30|15:00-15:30|18:00-18:30|21:00-21:30`;
  - land map war ("huge head", [land-map.md](land-map.md), [node-battle.md](node-battle.md)): `huge_head_open_time = 14:00-15:00|19:00-20:00`.
- Sign up: a guild chairman (or a member with guild right 46) pays `stack_head_join_fee = 500000` guild fortune ("Deseja consumir {0} fortuna da guilda para inscrever?") on a sign up day. The server then groups guilds into battlefields (`huge_head_battle_field_guild_count = 8,12,20`: minimum, group target, maximum) and assigns each guild to one of 4 forces. Battlefields reset by month (`huge_head_reset_month` lists every month).
- A player who joined his guild on the event day cannot take part ("Não poderá participar do evento da Terralém no dia em que participar da guilda...").
- Daily occupation reward: the force's occupied node count pays "Cristais da Terrálem" (`huge_head_daliy_reward = 1-5,100|6-10,200|11-20,400|21-40,600|41-61,800`); it shows as the top bar button "Prêmio da Luta" while extra field 14 is not empty.
- Monthly themed events (`HugeHeadActiveMsg`): type 1 "Dia de Saqueamento de Cristais" (crystal war action point cost reduced), type 2 "Dia da Fortaleza" (extra declarations), type 3 "Dia da Pesquisa" (explore cost reduced); configured by `huge_head_active_stack_head = 3,4,1,50`, `huge_head_active_battle = 3,4,1,1`, `huge_head_active_explore = 3,4,1,50` (months, week, weekday, effect).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| Top bar buttons "Terrálem", "Prêmio da Luta" | tips `ui.toptoolbar.TopToolsBar.tipData_outyard`, `tipData_outyardreward` | Entry and reward claim (`TTB:1293-1304`) | HUD | 306, 350, extra field 14 |
| `OY/event/OutyardEventFrame.as`, `OY/event/OutyardEventLeftButton.as`, `OY/event/OutyardEventRightView.as` (769 x 542) | "Casos da Terralém"; "Dia de Saqueamento de Cristais", "Dia Dia da Fortaleza", "Dia da Pesquisa", "Saqueamento dos cristais do centro", "Saqueamento da base", "Pequisa da Terralém", "Santuário de Titã"; "Aberta todo o dia"; "Tempo inter-servidor: {0}" | Calendar: fixed entries 4, 5, 6 (+7 titan) plus `activeList` events with dates, schedules and rules (`OutyardEventFrame.as:125-145`, `OutyardEventRightView.as:112-165`); "enter" button jumps to the mode (`OutyardEventRightView.as:182-220`) | map frame activity button (`OY/scene/OutyardMapFrame.as:422-426`, openType 4) | 306 `activeList`, config times |
| Queue bar orders 3, 13, 15 | "Pontos de Movimento da Terralém {0}/{1}", "Pesquisa da Terrálem {0}/{1}" | HUD timers driven by 306 states (`decompiled/core_module/scripts/yishi/manager/QueueBarManager.as:366-423`) | HUD | states |

## 3. Routes (client to server)

Send 9594 (0x257a) `C_HUGE_HEAD_REQUEST`, `HugeHeadRequestMsg` (package `hugehead`): `op` (#1, INT32); `nodeId` (#2, INT32); `side` (#3, INT32); `notice` (#4, STRING); `userUid` (#5, STRING); `battleFieldUid` (#6, STRING). Sender `OutyardManager.OperateMapOutyard(op, nodeId, side, notice, userUid, battleFieldUid)` (`OM:268-279`). Op constants `OMOD/OutyardModel.as:21-39`: 1 OPEN_FRAME, 2 HEART, 3 CLOSE_FRAME, 4 DECLARE, 5 ADD_BATTLE, 6 CHANGE_NOTICE, 7 GET_REWARD, 8 COLLECT_CRYSTAL, 11 SIGNUP, 12 UPDATE_NODES (push only). Ops 4, 5, 6, 8 are in [land-map.md](land-map.md).

| # | op | UI and sender | Client checks | Expected reply |
|---|---|---|---|---|
| S1 | 11 SIGNUP | `TTB.enterOutyardScene` alert (`TTB:1619-1633`, `:1677-1683`), queue bar alert (`decompiled/core_module/scripts/ui/queuebar/QueueBar.as:444-450`) | in a guild else "Favor participar primeiro de uma guilda"; guild not signed (`guildSignIn == false`); `canSignIn` else "Evento irá encerrar brevemente, favor voltar para a próxima"; chairman or right 46 else "Apenas o líder e membros autorizados podem realizar inscrições"; confirm fee | 350 with `guildSignIn = true`; guild fortune update ([guild](../guild/README.md)) |
| S2 | 1 OPEN_FRAME | map frame open (`OY/scene/OutyardMapFrame.as:129`), crystal frame open (`OY/OutyardFrame.as:96`) | entry checks below | 349 `op = 1` full battlefield ([land-map.md](land-map.md)), 350, 306 |
| S3 | 2 HEART | map frame timer every 30 s (`OY/scene/OutyardMapFrame.as:191-193`, `:250-253`) | | 349 `op = 12` with changed nodes, 306 when the state changed |
| S4 | 7 GET_REWARD | "Prêmio da Luta" (`TTB:1299-1304`) | extra field 14 not empty | 260 field 14 cleared, currency push for -3400 crystals |

Entry checks before opening the map (`TTB:1603-1675`): in a guild; 306 and 350 received; guild signed up (else sign up flow); next huge head session exists else "Hoje a luta da terrálem não abrirá"; `hugeHeadState == 0` -> "Evento iniciará às {0}, favor participar"; `hugeHeadState == 1` -> "Coletando dados de inscrição, favor aguardar"; `guildJoin` false -> next date; `selfJoin` false -> "Não poderá participar do evento da Terralém no dia em que participar da guilda...".

## 4. Server messages (server to client)

### 306 (0x0132) `U_C_STACK_HEAD_STATE`

`HugeHeadStateMsg`: `groupTime` (#1, INT64) time of the grouping; `index` (#2, INT32); `canSignIn` (#3, BOOL); `hugeHeadOpenTime` (#4, `HugeHeadOpenTimeMsg`, repeated: `startTime` #1 INT64, `endTime` #2 INT64, epoch ms) today's land sessions; `hugeHeadNextOpenTime` (#5, repeated) next day's sessions; `hugeHeadSession` (#6, INT32) current session 1 based; `hugeHeadState` (#7, INT32); `stackHeadOpenTime` (#8, repeated); `stackHeadNextOpenTime` (#9, repeated); `stackHeadSession` (#10, INT32); `stackHeadState` (#11, INT32); `activeList` (#12, `HugeHeadActiveMsg`, repeated: `type` #1 INT32 event type 1..3, `date` #2 STRING `YYYY-MM-DD` first day (7 day window), `effect` #3 INT32 percent or count). Receivers `OutyardModel.stateInfoHandler` (`OMOD/OutyardModel.as:96-101`, notifies `OUTYARD_STATE_INFO` and `SPACE_NPC_VISIBLE`) and `QueueBarManager.__stackHeadState` (`QueueBarManager.as:366-423`).

State values used by the client (both modes): 0 not open today / closed; 1 collecting sign ups; 2 preparation before a session; 3 running; 4 settling ("Contabilizando"); 5 finished for the day (`OY/OutyardBlessFrame.as:192-245`, `OY/OutyardFrame.as:335-374`, `OY/scene/OutyardMapFrame.as:526-589`). `outyardIsOpen` = either state 3 (`OMOD/OutyardModel.as:487-494`). `getActiveRateByType(t)` returns the `effect` of active type t or 100 (`OMOD/OutyardModel.as:452-465`).

When: login, every state transition (broadcast to all players level 13+, the top bar uses it), reply to S2.

### 350 (0x015e) `U_C_HUGE_HEAD_MY_SIGN_IN_STATE`

`HugeHeadMySignInStateMsg`: `guildSignIn` (#1, BOOL) guild signed up; `guildJoin` (#2, BOOL) guild placed in a battlefield; `selfJoin` (#3, BOOL) player allowed (joined the guild before the event day); `forceIndex` (#4, INT32) 1..4; `myGuildUid` (#5, STRING) cross server guild uid; `digTodayRemainCount` (#6, INT32) crystal collections left today; `digExtraCount` (#7, INT32) extra collections from occupation. Receiver `OutyardModel.mySignInHandler` (`OMOD/OutyardModel.as:219-223`) and `QueueBarManager` (`:81`). When: login, after S1, after grouping, after a crystal collection.

### 260 (0x0104) `U_C_PLAYER_EXTRA_FIELD_MSG` fields 14 and 15

Field 14: pending daily reward description string (`OutyardModel.reward`, `decompiled/core_module/scripts/yishi/manager/BaseManager.as:929-932`). Field 15: explore points left ([land-explore.md](land-explore.md), `BaseManager.as:933-936`).

## 5. Rules and formulas

- Config (`raw/xml/tempinfos/ConfigInfos.xml`): `stack_head_open_week_day`, `stack_head_open_time`, `huge_head_open_time`, `stack_head_join_fee`, `huge_head_battle_field_guild_count`, `huge_head_reset_month`, `huge_head_daliy_reward`, `huge_head_active_*`.
- Occupation reward table: 1..5 nodes 100, 6..10 200, 11..20 400, 21..40 600, 41..61 800 crystals per day (also in the map tip `outyard.OutyardMapFrame.occupyStrip`).
- Sign up allowed only when `canSignIn` (assumption: the day before the event).
- Grouping (assumption): guilds of all servers signed up for the same day are sorted by power, split in groups of 12 (8 minimum, 20 maximum), then dealt into 4 forces.

## 6. Templates

Config keys above. Map nodes in [land-map.md](land-map.md).

## 7. Persistent state

```sql
CREATE TABLE outyard.battlefield (
  battlefield_uid   TEXT        PRIMARY KEY,
  season_month      DATE        NOT NULL,
  grouped_at        TIMESTAMPTZ NOT NULL
);

CREATE TABLE outyard.guild_signup (
  guild_uid         TEXT        PRIMARY KEY,
  guild_id          INTEGER     NOT NULL,
  server_name       TEXT        NOT NULL,
  signed_at         TIMESTAMPTZ NOT NULL DEFAULT now(),
  battlefield_uid   TEXT        REFERENCES outyard.battlefield(battlefield_uid) ON DELETE SET NULL,
  force_index       SMALLINT    CHECK (force_index BETWEEN 1 AND 4),
  notice            TEXT        NOT NULL DEFAULT ''
);
CREATE INDEX guild_signup_field_idx ON outyard.guild_signup (battlefield_uid, force_index);

CREATE TABLE outyard.player_state (
  player_id            BIGINT     PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
  user_uid             TEXT        NOT NULL UNIQUE,
  day                  DATE        NOT NULL,
  dig_left_today       SMALLINT    NOT NULL DEFAULT 0,
  dig_extra            SMALLINT    NOT NULL DEFAULT 0,
  pending_reward       TEXT        NOT NULL DEFAULT ''
);

CREATE TABLE outyard.active_event (
  event_type   SMALLINT NOT NULL CHECK (event_type BETWEEN 1 AND 3),
  start_date   DATE     NOT NULL,
  effect       SMALLINT NOT NULL,
  PRIMARY KEY (event_type, start_date)
);
```

## 8. Backend implementation notes

- `outyard::season::handle_request` (9594) dispatches: 11 -> `handle_signup`, 1 -> `handle_open`, 2 -> `handle_heartbeat`, 7 -> `handle_get_reward`; 4, 5, 6, 8 -> [land-map.md](land-map.md).
- Signup: guild exists, sender is chairman or has right 46, `canSignIn`, not already signed, guild fortune >= 500000 -> deduct, insert `guild_signup`, push 350 to online members.
- Scheduler `outyard::season::tick`: computes both state machines from the config calendars, pushes 306 to everyone on change, runs grouping at the end of the sign up window, settles sessions (crystal war scores, land node ownership), writes daily rewards into `pending_reward` and pushes 260 field 14.
- Reward claim: non empty `pending_reward` -> grant crystals (-3400) -> clear -> push 260.
- Daily reset: `dig_left_today` from config (assumption 1), `dig_extra` from occupied nodes.
- Cross server: battlefields span servers; use the uid strings (`guildUid`, `userUid`, `battleFieldUid`) as global ids.

## 9. Open questions and assumptions

- Exact sign up window and grouping algorithm.
- Meaning of `index` and `groupTime` in 306.
- Daily reward computation moment (assumed at the end of the last land session).
- Whether 9594 op 3 (CLOSE_FRAME) is expected when the map closes (no client sender).

## 10. Implementation checklist

- [ ] Screens: top bar buttons, events calendar frame
- [ ] Route S1 op 11 sign up
- [ ] Route S2 op 1 open, S3 op 2 heartbeat
- [ ] Route S4 op 7 daily reward
- [ ] Server messages 306, 350, 260 fields 14/15
- [ ] Tables `outyard.battlefield`, `guild_signup`, `player_state`, `active_event`
- [ ] Scheduler for both state machines and grouping
- [ ] Test: entry checks messages for each state
