# Artillery garage ("Artilharia TM")

Module `artillery::garage`. Citation prefixes: see [README.md](README.md).

## 1. Overview

The garage lists the playable vehicles (templates `VehicleObjectTempInfos` with `Type = 1`), shows the player's control level ("Controle") and EXP, the server-wide tech level ("Nível Tecnológico TM"), and lets the player:

- pick the default vehicle used in "Julgamento TM" (only owned vehicles);
- unlock a vehicle early with diamonds, when the tech level allows it.

Vehicles also unlock automatically when the control level reaches the grade whose `ActiveObject` equals the vehicle id (`UpGradeTempInfos` Types=24). The control EXP comes from "Julgamento TM" results ([battle-scene.md](battle-scene.md)).

Per-player state lives on `PlayerInfo`: `vehicleGp` (EXP), `vehicleScore`, `vehicleList` (owned template ids), `vehicleTempId` (default), plus `PlayerModel.vehicleTech` (`CM/yishi/datas/playerinfo/PlayerInfo.as:266-270,1654-1717`).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `vehicle.DaimonFrame` (790x540, `M9/vehicle/daimon/DaimonFrame.as:155`) | Artilharia TM (`vehicle.daimon`) | Garage | castle building 1505, `vehicledaimon`; also embedded without group from the team room "Trocar" button (`CM/mvc/controler/VehicleDaimonController.as:72-82`) | left, right, bottom views below |
| `DaimonLeftView` | | Selected vehicle: name, Attack, Speed, Defence, Hp, genius skill icon + tip, avatar `PathManager.getVehicleShowAvatarPath(Avatar)` | | template values (`M9/vehicle/daimon/view/DaimonLeftView.as:107-136`) |
| `DaimonRightView` | | Grid of 6 vehicles per page, prev/next, "tech level" label, "Usar" button (`_daimonTiralBtn`) | | `DaimonModel.getShowData()`, owned first then `Sort` (`CM/mvc/module/vehicle/DaimonModel.as:182-208`) |
| `DaimonBottomView` | | Control level "Nv. {0}", EXP bar `curGp / maxGp` or "MAX", bonuses "+attack", "+defence", "+hp" | | `DaimonModel` (`M9/vehicle/daimon/view/DaimonBottomView.as:73-96`) |
| `VehicleItemView` | | One card: name, image, lock overlay when not owned; tip `DaimonInfoTip` | | owned = `vehicleList` contains id (`M9/vehicle/daimon/view/VehicleItemView.as:133-170`) |
| `DaimonInfoTip` | | Name, attributes, genius skill, unlock conditions "Ativação automática (1): Controle nível {0}" and "Ativação antecipada (2): Nível tecnológico {0}, consumo de {1} diamantes" | hover | `autoOpenGrade`, `NeedGrades`, `NeedDiamond` (`M9/vehicle/daimontrial/view/DaimonInfoTip.as:76-120`) |

## 3. Routes (client to server)

### R1. Choose default vehicle

- UI: select an owned card, click "Usar" (`DaimonRightView.__changeVehicleHandler`, `M9/vehicle/daimon/view/DaimonRightView.as:233-245`).
- Sender: `PlayerManager.changeVehicle(templateId)` (`CM/yishi/manager/PlayerManager.as:1739-1745`).
- Client checks: card not locked (owned); button enabled only when `vehicleTempId != currentVehicleTempid`. The client sets `playerInfo.vehicleTempId` optimistically before sending.
- Route: C to S 8611 (0x21a3) `C_VEHICLE_CHOOSE_VEHICLE`, `campaign.CampaignReqMsg`:
  - `para_int1` (#1, INT32): vehicle template id.
  - other fields unused.
- Server response: 4515 `PlayerVehicleProfileMsg` with `defaultVehicle` (A: the client already updated itself; sending 4515 keeps it authoritative). If the player is in a team room, the server should also refresh the room member (generic room member push 120) so others see the new vehicle (A).

### R2. Early activation with diamonds

- UI: click a locked card (`DaimonRightView.__clickHandler`, `M9/vehicle/daimon/view/DaimonRightView.as:189-231`).
- Client checks in order:
  1. `vehicleTech < NeedGrades` -> tip "Nível tecnológico TM inferior à {0}" (`vehicle.needVehicleTech`), stop.
  2. `NeedDiamond > 0` -> confirm "Consumir {0} diamantes para ativar {1}?" (`vehicle.DaimonRightView.OpenContent`) with the bind-diamond checkbox (`popAlerFrame(... "USEBINDPOINT_ALERT" ...)`), then send.
  3. otherwise, `vehicleGrade < autoOpenGrade` -> tip "Necessário nível de controle" + grade, stop (no request).
- Sender: `VehicleDaimonController.sendOpenVehicle(templateId, useBind)` from `__alertBackHandler` (`M9/vehicle/daimon/view/DaimonRightView.as:247-253`, `CM/mvc/controler/VehicleDaimonController.as:84-95`).
- Route: C to S 8619 (0x21ab) `C_ACTIVE_VEHICLE`, `simple.PropertyMsg`:
  - `param1` (#1, INT32): vehicle template id.
  - `param2` (#2, INT32): 0 when the alert checkbox "use bound diamonds" is checked, 1 when unchecked (the client writes `param2 = 0`, then `1` if `!param2`).
- Server response order: diamond balance push (currency feature), then 4516 `PlayerVehicleListMsg` with the new vehicle (the client appends, `CM/yishi/manager/PlayerManager.as:1444-1460`). No error opcode exists; on failure send nothing or a generic tip (A).

### R3. Vehicle list request (unused)

- 8618 (0x21aa) `C_VEHICLE_LIST_REQ` has no sender in the client. The server pushes 4516 at login instead (A).

## 4. Server messages (server to client)

| Opcode | Message | Receiver | When | Client effect |
|---|---|---|---|---|
| 4516 (0x11a4) `U_C_VEHICLE_LIST_RSP` | `vehicle.PlayerVehicleListMsg` {`vehicles` (#1, PlayerVehicleMsg, repeated)}; only `templateId` (#2, INT32) is read | `PlayerManager.__receiveVehicleListHandler` (`CM/yishi/manager/PlayerManager.as:170,1444-1460`) | login, after activation, after auto unlock on level up | `addVehicle` for each id (append only, never removes); if the list has exactly one vehicle it becomes `vehicleTempId` |
| 4515 (0x11a3) `U_C_VEHICLE_PROFILE_CHANGE` | `vehicle.PlayerVehicleProfileMsg` {`exp` (#1, INT32) total control EXP, `score` (#2, INT32) vehicle score, `defaultVehicle` (#3, INT32)} | `PlayerManager.__vehicleProfileChangeHandler` (`CM/yishi/manager/PlayerManager.as:169,1423-1442`) | login, after each match result, after R1 | sets `vehicleGp`, `vehicleScore`, `vehicleTempId`; events `VEHICLE_GP`, `PLAYER_VEHICLEINFO_CHANGE` |
| 4501 (0x1195) `U_C_VEHICLE_TECH_RSP` | `simple.PropertyMsg` {`param1` (#1, INT32) tech level} | `PlayerManager.__vehicleTechHandler` (`CM/yishi/manager/PlayerManager.as:171,1462-1472`) | login and whenever the server-wide tech level changes | `PlayerModel.vehicleTech`; right view label |

`PlayerVehicleMsg` full field list (shared with [battle-scene.md](battle-scene.md)): `id` (#1, INT32), `templateId` (#2, INT32), `hp` (#3, INT32), `team` (#4, INT32), `buffState` (#5, INT32, repeated), `grade` (#6, INT32), `name` (#7, STRING), `head` (#8, INT32), `x` (#9, INT32), `y` (#10, INT32), `playerId` (#11, INT32), `consortia` (#12, STRING), `vip` (#13, INT32), `appellId` (#14, INT32), `rebornTime` (#15, INT32), `npcNodeId` (#16, INT32), `serverName` (#17, STRING), `trans_grade` (#18, INT32), `vipType` (#19, INT32), `is_back_player` (#20, BOOL), `changeBranch` (#21, INT32), `maxHp` (#22, INT32), `defaultSkills` (#23, STRING), `isHoldKey` (#24, BOOL).

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Garage access | hero level >= 35 | `decompiled/m4/scripts/castle/view/CastleBuildingView.as:335-342` |
| Listed vehicles | `VehicleObjectTempInfos` rows with `Type = 1` (ids 1..4) | `CM/mvc/module/vehicle/DaimonModel.as:41-48` |
| Page size | 6 | `DaimonModel.as:25` |
| Sort | owned first, then `Sort` asc | `DaimonModel.as:195-208` |
| Control level from EXP | rows Types=24 sorted by `Grades`; level g is reached when `exp >= sum(Data of grades 2..g)`; level 1 at 0 EXP; max 30 | `CM/yishi/datas/playerinfo/PlayerInfo.as:1696-1717`, `TPL/UpGradeTempInfos.xml` |
| EXP to next level | `Data` of row `Grades = level + 1`; `MAX` when none | `DaimonModel.as:111-124` |
| Current EXP in level | `exp` minus cumulative `Data` | `DaimonModel.as:126-147` |
| Control bonuses (added to the vehicle in battle, display only on client) | HP `+100*(level-1)`, attack `+2*(level-1)`, defence `+1*(level-1)` | `DaimonModel.as:53-81` (constants `BUFF_HP=100`, `BUFF_ATTACK=2`, `BUFF_DEFENCE=1`, :17-21) |
| Auto unlock | vehicle id = `ActiveObject` of a Types=24 row; unlocks at that `Grades` (default 1) | `CM/yishi/datas/templates/VehicleObjectTempInfo.as:45-61` |
| Early unlock | requires `vehicleTech >= NeedGrades` and costs `NeedDiamond` | `DaimonRightView.as:205-223` |
| Default vehicle | must be owned; the first owned vehicle becomes default automatically | `PlayerManager.as:1455-1458` |

Type 1 vehicles (`TPL/VehicleObjectTempInfos.xml`):

| Id | Name | Attack | Defence | Hp | Dodge | Speed | Genius skill | Normal skill | NeedDiamond | Auto unlock (control level) |
|---|---|---|---|---|---|---|---|---|---|---|
| 1 | Devorador | 100 | 50 | 5000 | 5 | 7 | 1002 Sanguessuga | 1 Munição Normal | 0 | 1 |
| 2 | Mina de Fúria | 150 | 50 | 6000 | 5 | 8 | 1001 Ataque Cinzela | 1 | 200 | 6 |
| 3 | Lobo Silencioso | 170 | 60 | 6500 | 5 | 8 | 1003 Paralisação (10%) | 1 | 500 | 10 |
| 4 | Alma Rapina | 190 | 60 | 7000 | 5 | 8 | 1004 Paralisação (15%) | 1 | 1000 | 13 |

`NeedGrades` is 0 for all four, so the tech level never blocks in this data set.

Control EXP table (Types=24, `Data` = EXP for that level): 2:100, 3:150, 4:300, 5:450, 6:650, 7:1000, 8:1500, 9..30: 2000 each.

Tech level: "Decidido de acordo com nível de controle da Artilharia TM de todos os jogadores" (`vehicle.vehicleTechDesc`). The formula is server-side and not in the client (A: average or max control level of the server population, recomputed daily).

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `TPL/VehicleObjectTempInfos.xml` (39 rows) | vehicle or map object | `TemplateId`, `TemplateName`, `Type` (1 player vehicle, 2 boss 2191, 3..18 campaign objects, 10 alt vehicles 5001-5004, 11 snow battle), `Attack`, `Defence`, `Hp`, `Dodge`, `Speed`, `GeniusSkill`, `NormalSkill`, `NeedDiamond`, `NeedGrades`, `Sort`, `Avatar`, `Description` |
| `TPL/VehicleSkillTempInfos.xml` (77 rows) | vehicle skill | see [battle-scene.md](battle-scene.md) |
| `TPL/UpGradeTempInfos.xml` Types=24 | control level | `Grades`, `Data` (EXP), `ActiveObject` (vehicle unlocked) |
| `VehicleProficiencyTempInfo` | loaded by `TempleteManager` (`CM/yishi/manager/TempleteManager.as:1182`) as `VehicleAdditionTemplateCate` | file absent from `raw/xml/tempinfos/`; no reader found in garage code |

## 7. Persistent state

Schema `artillery`.

```sql
CREATE TABLE artillery.player_profile (
  player_id           BIGINT PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
  control_exp         INTEGER NOT NULL DEFAULT 0 CHECK (control_exp >= 0),
  vehicle_score       INTEGER NOT NULL DEFAULT 0,
  default_vehicle_id  INTEGER NOT NULL DEFAULT 1,
  updated_at          TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE artillery.owned_vehicles (
  player_id      BIGINT NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  vehicle_id     INTEGER NOT NULL,
  unlock_source  SMALLINT NOT NULL CHECK (unlock_source IN (1, 2, 3)),
  unlocked_at    TIMESTAMPTZ NOT NULL DEFAULT now(),
  PRIMARY KEY (player_id, vehicle_id)
);

CREATE TABLE artillery.server_tech (
  id          SMALLINT PRIMARY KEY DEFAULT 1 CHECK (id = 1),
  tech_level  INTEGER NOT NULL DEFAULT 0,
  computed_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
```

`unlock_source`: 1 default grant, 2 auto unlock by control level, 3 diamonds. The control level is derived from `control_exp` and never stored.

## 8. Backend implementation notes

- Login: push 4516 (owned list), 4515 (exp, score, default), 4501 (tech). Grant vehicle 1 on first access (A).
- `artillery::garage::handle_choose_vehicle` (8611): validate the id is owned, update `default_vehicle_id`, reply 4515. Reject while in a running `VEHICLE` scene (A).
- `artillery::garage::handle_activate_vehicle` (8619): validate template `Type = 1`, not owned, `tech_level >= NeedGrades`, `NeedDiamond > 0`; one transaction: spend diamonds through the currency service (`param2 = 0` bound first, `1` unbound only, A), insert `owned_vehicles` (source 3), commit, then push currency and 4516.
- Auto unlock: when control EXP increases ([battle-scene.md](battle-scene.md) result), recompute the level; for each row with `ActiveObject > 0` and `Grades <= level`, insert missing vehicles (source 2) and push 4516.
- Tech level: daily job recomputes `server_tech` and broadcasts 4501 to online players.

## 9. Open questions and assumptions

- (A) Server reply to 8611: the client never waits for one; 4515 is the natural choice.
- (A) `param2` semantics of 8619 follows the common bind-diamond alert pattern (0 = allow bound diamonds).
- (A) Tech level formula unknown.
- `VehicleProficiencyTempInfo.xml` is missing; its purpose (control proficiency bonuses) is unknown.
- `PlayerVehicleMsg.grade` in battle carries the control level; the bonus formula on the server must match `DaimonModel` (A).

## 10. Implementation checklist

- [ ] Load `VehicleObjectTempInfos`, `VehicleSkillTempInfos`, `UpGradeTempInfos` Types=24.
- [ ] Tables `player_profile`, `owned_vehicles`, `server_tech`.
- [ ] Login pushes 4516, 4515, 4501.
- [ ] Route 8611 choose vehicle, reply 4515.
- [ ] Route 8619 early activation with bound/unbound diamonds, push 4516.
- [ ] Auto unlock on control level up, push 4516.
- [ ] Control level formula identical to `PlayerInfo.vehicleGrade`.
- [ ] Tech level daily job and 4501 broadcast.
- [ ] Screen check: `DaimonFrame` paging, lock state, EXP bar, "MAX" at level 30.
- [ ] Tests: level boundaries (0, 100, 250, max), activation without diamonds, activation of owned vehicle, choose unowned vehicle.
