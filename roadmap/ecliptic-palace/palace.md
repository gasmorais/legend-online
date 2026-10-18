# Ecliptic Palace main frame and challenges

Feature [ecliptic-palace](README.md), module `palace`. Aliases in [README.md](README.md).

## 1. Overview

- State per player: current palace `current_layer` 1..12, spirit `current_spirit`, the 3 routes of the palace (`route1..route3`), the chosen route `selected_route` (0 = not chosen yet), two countdowns (spirit regen, palace decline) and the hidden event flag `pop_event`.
- Before the first challenge of a palace the player selects a route by clicking a route panel (client side only, `EPCI:130-137`); the first challenge (op 2 with the route) locks it on the server. Other routes turn gray (`EPCI:120-127`).
- Each challenge fights the next undefeated boss of the route in battle type 3879 and costs `SpiritCost` of the palace (10, 15, ..., 65). Clearing all 4 bosses passes the palace: the route reward image switches to "passed" and the server advances `current_layer` (12 = last; then "Já completado. Por favor aguarde o regresso.", `EPMOD:95-100`).
- A defeated boss with `hidden_event` makes the server set `pop_event`; when the frame shows it asks "Deseja causar um evento escondido?" (op 3 yes/no).
- Not enough spirit: "Deseja gastar {0} diamantes para recuperar totalmente os pontos de espírito primordial?" (200 diamonds, op 4), up to 40 purchases per week (tip "Pode comprar até {2} vezes por semana").

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `EPF` (`EclipticPalaceFrame`) | title image per palace (frame `curLayer`); texts "Itens obtidos esta semana", "Matando o chefão atual é possível causar um evento escondido!", decline tip "Se não completar este templo em {0} horas,\nserá enviado de volta para o templo anterior. \n Às 00:00 de cada dia é enviado de volta para o templo anterior." | 3 routes, spirit bar, challenge button, guardian buff text, decline countdown | controller `eclipticpalace` `MAIN_FRAME` | `curSpirit/spiritMax` (`EPF:311-313`), countdown `declineEndTime` (hidden on palace 1, `EPF:262-285`), tip "Recupera {0} pontos de espírito primordial por hora. ... gastar {1} ... comprar até {2} vezes por semana." (`EPF:323-336`), child icons and "Se {0} ou {1} estiverem na formação pode obter {2}." (`EPF:338-371`) |
| `EPCI` (`EclipticPalaceChallengeItem`) | reward tip "Através do templo atual pode obter:" / "É possível obter os itens abaixo:" | One route with 4 bosses and reward icon | `EPF` (3 instances) | rewards from `EclipticPalaceDrop` site 1 `para2 = curLayer` split by `appearType == 1` (fixed) and others (random) (`EPCI:139-154`) |
| `EPBI` (`EclipticPalaceBossItem`) | - | Boss head, defeated mark, hidden event mark, "current fight" mark | `EPCI` | `hero_temp_id` icon, `defeated`, `hidden_event`, `fightIndex` (`EPBI:62-74`) |
| `decompiled/m14/scripts/eclipticpalace/EclipticPalaceLayerProcessView.as` | 12 palace icons | Progress strip | `EPF` bottom view | palaces before current gray, current lit (`:55-89`) |

## 3. Routes (client to server)

All requests: send 5190 (0x1446) `C_ECLIPTIC_PALACE_OP`, protobuf `CommonMsg` (package `player`): `param1` (#1, INT32) op; `param2` (#2, INT32) argument; `param3` (#3, INT32), `param4` (#4, STRING), `param5` (#5, STRING), `param6` (#6, INT64), `param7` (#7, INT64) unused. Sender `EPM.sendEclipticPalaceRequest(op, arg)` (`EPM:146-153`).

### R1. Open / refresh (op 1)

- UI: frame opened with `frameData` (NPC, daily guide) (`EPF:384-394`); also every second tick when `declineLeft <= 0 && !popEvent` or `recoverLeft <= 0` (`EPF:262-297`).
- Request: `param1 = 1`.
- Response: 173 with the full state.

### R2. Challenge (op 2)

- UI: `_challengeBtn` (`EPF:233-255`).
- Client checks: `isChallengeOver` -> "Já completado. Por favor aguarde o regresso."; `curSpirit < SpiritCost` -> buy spirit confirm (R4) instead.
- Request: `param1 = 2`, `param2 = selectedRoute != 0 ? selectedRoute : selectPath` (1..3).
- Server: validate spirit, route (locked once chosen), palace not finished; deduct `SpiritCost`; start battle 3879 against boss `fightIndex` of the route (hero template `hero_temp_id`, with `BossAdditionSkillId` 90001..90004 buffs, assumption) with the route bonus skill `skill_id` applied to the player when a guardian of `guard_job_type1/2` is in the formation.
- Response: battle start; after the battle the client returns to castle/space and reopens the frame from cache, so push 173 after the battle (defeated flag, `pop_event`, layer change) before the battle exit. On a passed palace push 173 with the next palace routes and `selected_route = 0`; rewards go to the bag (and are appended to the weekly log, [reward-log.md](reward-log.md)).

### R3. Hidden event answer (op 3)

- UI: confirm "Deseja causar um evento escondido?" shown on `show()` when `popEvent` (`EPF:399-414`).
- Request: `param1 = 3`, `param2 = 1` accept or `0` decline.
- Server: accept -> start the hidden event (assumption: an extra boss battle or reward from `EclipticPalaceDrop` site 2/3); clear `pop_event`; push 173.

### R4. Buy spirit (op 4)

- UI: shortage confirm from R2 (`EPF:244-259`), daily skip via `SharedManagerHelper`.
- Request: `param1 = 4`.
- Server: weekly purchases < `ecliptic_palace_spirit_buy_count_max` (40); spend `ecliptic_palace_spirit_buy_cost` (200) diamonds; set spirit to max 200 ("recuperar totalmente").
- Response: 173 (`current_spirit`), player info balance push.

## 4. Server messages (server to client)

### 173 (0x00ad) `U_C_ECLIPTIC_PALACE_INFO`

- Message `EclipticPalaceMsg`: `op` (#1, INT32) echo (not read); `recover_count_down` (#2, INT32) seconds to the next spirit regen tick; `current_spirit` (#3, INT32); `current_layer` (#4, INT32) palace 1..12; `decline_count_down` (#5, INT32) seconds before being sent back; `selected_route` (#6, INT32) 0 or 1..3; `route1` (#7), `route2` (#8), `route3` (#9) (MESSAGE `EclipticPalaceRouteMsg`); `pop_event` (#10, BOOL) hidden event pending.
- `EclipticPalaceRouteMsg`: `bossList` (#1, MESSAGE `EclipticPalaceBossMsg`, repeated, 4 entries); `guard_job_type1` (#2, INT32) guardian class 1 (0 none); `guard_job_type2` (#3, INT32); `skill_id` (#4, INT32) bonus skill shown in the text.
- `EclipticPalaceBossMsg`: `hero_temp_id` (#1, INT32) boss hero template; `defeated` (#2, BOOL); `hidden_event` (#3, BOOL).
- Receiver: `EPM.__updateMsgBackHandler` (`EPM:61-108`): only present fields overwrite; routes list rebuilt from present `routeN`; `pop_event` defaults to false when absent; `setFightIndex` (`EPMOD:61-107`); notifies `ECLIPTIC_PALACE_INFO_CHANGE`.
- When: reply to ops 1..4; after each battle 3879; at login (assumption, not required).

## 5. Rules and formulas

- Palaces: 12, `SpiritCost` = 5 * layer + 5 (`EclipticPalaceTempInfos.xml`).
- Spirit: max `ecliptic_palace_spirit_max` = 200, +`ecliptic_palace_spirit_recover_per_hour` = 25 per hour; buy refill 200 diamonds, `ecliptic_palace_spirit_buy_count_max` = 40 (weekly per the tip; config text says "次数上限").
- Decline: `ecliptic_palace_decline_layer_hour` = 14 hours after entering a palace (> 1) without finishing it, the player goes back one palace; also every day at 00:00 (tip text). Palace 1 has no countdown (`EPF:266-270`).
- `fightIndex` = number of defeated bosses of the selected route; route passed when all defeated; challenge over when route passed on palace 12 (`EPMOD:84-106`).
- Rewards per palace (`EclipticPalaceDrop` site 1, `para2` = palace): `6260001` x (5, 8, 11, 14, 18, 22, 26, 30, 35, 50, 60, 70) fixed (`appearType` 1) plus one random green emblem 6261011..6261061 (`appearType` 3). Site 2 (`para2` 0): `6260001` x20; site 3: one random emblem (`appearType` 2): assumed hidden event rewards.

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `raw/xml/tempinfos/EclipticPalaceTempInfos.xml` | 12 palaces | `Layer`, `LayerName`, `SpiritCost`, `BossAdditionSkillId` (`90001,90002,90003,90004`, server only) |
| `raw/xml/tempinfos/EclipticPalaceDrop.xml` | 91 drop rows | `dropId`, `site`, `para2` (palace), `itemId`, `count`, `isBind`, `appearType` (`decompiled/core_module/scripts/yishi/datas/templates/cate/EclipticPalaceRewardCate.as:19-55`) |
| `raw/xml/tempinfos/ConfigInfos.xml` | `ecliptic_palace_spirit_max`, `ecliptic_palace_spirit_recover_per_hour`, `ecliptic_palace_spirit_buy_cost`, `ecliptic_palace_spirit_buy_count_max`, `ecliptic_palace_decline_layer_hour` | read by `decompiled/core_module/scripts/yishi/datas/ConfigInfoManager.as:891-935` |
| child templates | `getTemplateByJobAndGrades(job, 1)` | `Icon`, `JobName` for the route guardian text |

## 7. Persistent state

Schema `ecliptic_palace`.

```sql
CREATE TABLE ecliptic_palace.player_state (
  player_id            BIGINT     PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
  current_layer        SMALLINT    NOT NULL DEFAULT 1 CHECK (current_layer BETWEEN 1 AND 12),
  layer_entered_at     TIMESTAMPTZ NOT NULL DEFAULT now(),
  spirit               SMALLINT    NOT NULL DEFAULT 200 CHECK (spirit >= 0),
  spirit_updated_at    TIMESTAMPTZ NOT NULL DEFAULT now(),
  selected_route       SMALLINT    NOT NULL DEFAULT 0 CHECK (selected_route BETWEEN 0 AND 3),
  pop_event            BOOLEAN     NOT NULL DEFAULT false,
  spirit_buy_count     SMALLINT    NOT NULL DEFAULT 0 CHECK (spirit_buy_count BETWEEN 0 AND 40),
  week_start           DATE        NOT NULL,
  finished             BOOLEAN     NOT NULL DEFAULT false
);

CREATE TABLE ecliptic_palace.route_boss (
  player_id            BIGINT     NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  route                SMALLINT    NOT NULL CHECK (route BETWEEN 1 AND 3),
  boss_index           SMALLINT    NOT NULL CHECK (boss_index BETWEEN 0 AND 3),
  hero_template_id     INTEGER     NOT NULL,
  defeated             BOOLEAN     NOT NULL DEFAULT false,
  hidden_event         BOOLEAN     NOT NULL DEFAULT false,
  PRIMARY KEY (player_id, route, boss_index)
);

CREATE TABLE ecliptic_palace.route_bonus (
  player_id            BIGINT     NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  route                SMALLINT    NOT NULL CHECK (route BETWEEN 1 AND 3),
  guard_job_type1      SMALLINT    NOT NULL DEFAULT 0,
  guard_job_type2      SMALLINT    NOT NULL DEFAULT 0,
  skill_id             INTEGER     NOT NULL DEFAULT 0,
  PRIMARY KEY (player_id, route)
);
```

## 8. Backend implementation notes

- `ecliptic_palace::palace::handle_request` dispatches 5190 by `param1`.
- Lazy updates on every request: spirit regen `min(200, spirit + 25 * floor(elapsed_hours))`, decline (`now - layer_entered_at >= 14 h` and layer > 1 -> layer - 1, regenerate routes), daily 00:00 decline, weekly reset of `spirit_buy_count`.
- Route generation per palace: 3 routes x 4 bosses (hero templates not in client data; assumption: server table per palace), random hidden event flags, random guardian classes and bonus skill.
- `ecliptic_palace::palace::handle_open` (op 1), `handle_challenge` (op 2: transaction deducts spirit and locks the route before the battle; battle config battleType 3879, defender boss hero with buff skills), `handle_battle_end` (mark defeated, roll hidden event, on route pass grant `EclipticPalaceDrop` site 1 rewards, append to reward log, advance layer, reset `layer_entered_at`), `handle_hidden_event` (op 3), `handle_buy_spirit` (op 4).
- Push 173 after each change; the frame polls op 1 when a countdown reaches 0.

## 9. Open questions and assumptions

- Boss line ups per palace and the effect of `BossAdditionSkillId` are server data.
- Hidden event content (sites 2 and 3 of the drop table are assumed).
- Whether losing a battle still consumes spirit (assumed yes).
- Weekly vs daily scope of the spirit purchase limit (tip says weekly).
- Behavior after passing palace 12 until the decline.

## 10. Implementation checklist

- [ ] Screen: `EclipticPalaceFrame`, routes, bosses, progress strip
- [ ] Route R1 op 1 -> 173
- [ ] Route R2 op 2 challenge, battle 3879
- [ ] Route R3 op 3 hidden event
- [ ] Route R4 op 4 buy spirit
- [ ] Server message 173 partial fields
- [ ] Tables `ecliptic_palace.player_state`, `route_boss`, `route_bonus`
- [ ] Rule: spirit regen 25/h, cap 200
- [ ] Rule: decline after 14 h and at 00:00
- [ ] Rule: palace rewards from `EclipticPalaceDrop`
- [ ] Test: route locked after first challenge
- [ ] Test: challenge refused with insufficient spirit
