# Bonfire party ("Festa da fogueira") and garden extras

Module `bonfire-party` of feature `farm`. Garden map (5501..5505) social features: the daily big bonfire party with countdowns and invitations, dice, sitting, random transformations and the mount showcase.

Path aliases:

| Alias | File |
|---|---|
| FM | `decompiled/core_module/scripts/farm/FarmManager.as` |
| FMO | `decompiled/core_module/scripts/farm/FarmModel.as` |
| HUV | `decompiled/m3/scripts/map/campaign/view/house/HouseUIView.as` |
| FUL | `decompiled/m3/scripts/farm/view/FarmUILayer.as` |
| FBCT | `decompiled/m3/scripts/farm/view/FarmBonCdTimeView.as` |
| FIF | `decompiled/m3/scripts/farm/view/FarmInvideFrame.as` |
| FAI | `decompiled/m3/scripts/farm/view/FarmAnimationItem.as` |
| FMI | `decompiled/m3/scripts/farm/view/FarmMountItem.as` |
| FMSM | `decompiled/m3/scripts/farm/view/FarmMountSelectMenu.as` |
| FMLI | `decompiled/m3/scripts/farm/view/FarmMountListItemView.as` |
| FML | `decompiled/m3/scripts/farm/view/FarmMountLayer.as` |
| BM | `decompiled/core_module/scripts/yishi/manager/BaseManager.as` |
| IF | `decompiled/core_module/scripts/yishi/view/frame/InviteFrame.as` |
| CM | `decompiled/core_module/scripts/map/campaign/CampaignManager.as` |
| MSO | `decompiled/m3/scripts/map/net/MapSocketOuterManager.as` |

## 1. Overview

Help text (`farm.view.FarmResourcesView.helpContent`): the owner ("agricultor") can host 1 bonfire party per day and invite players, each player can take part twice; the party starts 2 minutes after the owner lights the big bonfire and lasts 10 minutes; every participant gets experience every 30 seconds; invited friends get items when they light the small bonfires. The garden HUD (`FUL`) adds a dice button, a sit button, an auto pick button (King Contract) and the invite button during a party; the mount layer shows up to N mounts chosen by the owner.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `HouseUIView` bonfire button (`HUV`) | | light the big bonfire (owner only, once per day) | garden map HUD | countdown to midnight when already used (`HUV:241-275`) |
| `FarmBonCdTimeView` (`FBCT`) | "Contagem da Fogueira:" / "Bônus de tempo da fogueria:" | start countdown then party countdown | garden HUD | `beginLeftTime`, `leftTime` (`FBCT:121-190`) |
| `FarmUILayer` (`FUL`) | | dice ("atirar os dados"), sit ("sentar"), auto pick, invite button with glow | garden map (`decompiled/m3/scripts/map/campaign/mediator/farm/FarmMediator.as:108-119`) | |
| `FarmInvideFrame` (`FIF`) | "Festa da fogueira" | pick online friends (level >= 12), 5 per page | invite button (`FUL:204-208`, `FBCT:116-119`) | "Amigos online que não podem ser convidados.", "Convidado" |
| `InviteFrame` (core) | "Convite da festa da fogueira" | invitee accept / refuse, 10 s timer | 16 with `room_type = 100` (`BM:2467-2471,2489-2520`) | "{name}, Convidamos você para participar na festa da fogueira" |
| `FarmAnimationLayer` / `FarmAnimationItem` (`FAI`) | | dice animation over a player with chat style tips | 4969 event 2 | tips `farm.farmAnimationItem.tips0..8` |
| `FarmMountLayer` / `FarmMountItem` / `FarmMountSelectMenu` (`FML`, `FMI`, `FMSM`) | "escolher colocação da montaria" | showcase slots; owner picks a mount from his avatars or clears a slot | garden map | `HomeMsg.showMount` |

## 3. Routes (client to server)

### B1. Light the big bonfire
- UI: bonfire button (`HUV:601-604`); enabled only for the owner (`masterId == self`), not when the party is used today (`is_big_bonfire`) or counting down (`HUV:257-275`).
- Sender `HUV.sendOpenFire` (`HUV:637-646`): finds the map node of type 1001 and sends C>S 5125 (0x1405) `U_C_CAMPAIGN_ARRIVE` via `MSO.sendCampaignArrive(armyId, nodeId)` (`MSO:55-62`): `CampaignReqMsg { paraInt1 = nodeId, paraBool1 = true }`, header extend = 0. Owned by [campaign](../campaign/README.md); the server recognizes the bonfire node of a garden map.
- Server: mark today's party used, set the node state to 20 (big bonfire, `CM:301-304` sets `bigBonFireIsOpen`), push 4982 with `beginLeftTime = 120` to everyone in the garden, then after 120 s 4982 with `leftTime = 600`; every 30 s grant experience to participants in the map; at the end reset the node.

### B2. Invite friends (op 1006)
- UI: `FIF` OK button (`FIF:194-229`). Client checks: at least one selected friend ("Nenhum amigo ainda foi escolhido.").
- Sender `FM.invideFirends(ids)` (`FM:936-943`): C>S 8873 (0x22a9) `C_HOME_OP`, `ChildrenOpMsg { op_type (#1) = 1006, inviteFriendids (#12, INT32, repeated) }`.
- Server: for each online friend push S>C 16 (0x0010) `U_C_CAMPAIGN_ROOM_INVITE`, `room.RoomInviteMsg`: `room_type (#6) = 100`, `player_id (#2)` = host, `nick_name (#3)` = host name, others optional (`room_id #1`, `name #4`, `sign_str #5`, `temp_id #7`, `position #8`, `userKey #9`, `boss_count #10`, `isCross #11`). Invitees inside the garden get it delayed by 1 s and only when in a garden map (`BM:2348-2356,2489-2520`).

### B3. Answer an invite (op 1007)
- UI: `InviteFrame` accept / refuse / timeout (`IF:132-143,185-191,394`).
- Sender `FM.respondInvide(hostId, accept)` (`FM:945-953`): `ChildrenOpMsg { op_type = 1007, property1 (#3) = host id, property5 (#7) = accept }`.
- Server: on accept move the player into the host's garden map (campaign enter) and count one participation (max `Bonfire_Max_Count` = 2 per day, assumption per invitee).

### B4. Throw dice (op 12)
- UI: dice button, disabled for a few seconds after a click (`FUL:148-158`).
- Sender `FM.randomNum()` (`FM:955-961`): `ChildrenOpMsg { op_type = 12 }`.
- Server: roll two dice 0..6 (0 = lost die) and broadcast 4969 event 2 to the garden.

### B5. Sit down (op 11)
- UI: sit button (`FUL:160-183`). Client checks: already sitting -> "sentado"; transformed (`changeShapeId != 0`) -> confirm "ao sentar irá tirar o estado deformado, quer continuar?".
- Sender `FM.sitDown()` (`FM:963-969`): `ChildrenOpMsg { op_type = 11 }`.
- Server: clear the transformation, broadcast 4969 event 3 (and event 1 with value 0 when a shape was cleared, assumption).

### B6. Show a mount (op 13)
- UI: owner clicks an empty showcase slot -> `FMSM` lists his mount avatars not already shown (`FMSM:109-140`); clicking one sends; the slot cancel button sends template 0 (`FMI:138-157`, `FMLI:131-134`).
- Sender `FM.showMount(templateId)` (`FM:1009-1017`): `ChildrenOpMsg { op_type = 13, property1 (#3) = slot (currentMountPos), property2 (#4) = mount template (0 to clear) }`.
- Server: validate ownership of the mount avatar ([mounts](../mounts/README.md)), store, broadcast 4753 with `showMount`.

### B7. Auto pick (garden HUD)
- UI: auto pick button (`FUL:210-234`): without King Contract buff 8 shows "kingcontract.view.allBuyFrontAlert" and opens the King Contract frame; with the buff nothing is sent (the `FarmAutoMediator` is never started). No route.

## 4. Server messages (server to client)

### S1. 4982 (0x1376) `U_C_COURTYARD_FIRE_COUNTDOWN`, `HomeMsg`
Receiver `FM.onFarmBonCd` (`FM:147-160`): only `leftTime (#22, INT32)` (party seconds left) and `beginLeftTime (#23, INT32)` (seconds before the party starts) are read, when present. Drives `FBCT` and disables the bonfire button.

### S2. 4969 (0x1369) `U_C_COURTYARD_EVENT`, `children.BonfireEventMsg`
Receiver `FM._onfarmOpHandler` (`FM:971-1007`).

| Field | Tag | Type | Meaning |
|---|---|---|---|
| `userId` | #1 | INT32 | player concerned |
| `userName` | #2 | STRING | name for tips |
| `event_type` | #3 | INT32 | 1 transformation, 2 dice, 3 sit down |
| `value` | #4 | INT32 | event 1: new `changeShapeId` (0 = normal); event 2: 3 digit code `1XY`, X = die 1, Y = die 2 (digits read with `charAt(1)`, `charAt(2)`) |

Dice tips (`FAI:88-131`): both dice 0 -> tips0 / tips7, total 1 -> tips1, one die 0 -> tips6 / tips8, totals -> tips2..tips4, 12 -> tips5 "sorte boa! Pode-se comprar a loteria".

### S3. 16 (0x0010) `U_C_CAMPAIGN_ROOM_INVITE`
See B2.

### S4. 4753 `U_C_HOME_INFO`
`is_big_bonfire (#17)` and `showMount (#21, ShowMountMsg: pos #1, templateId #2, starlevel #3, is_valid #4)` (`FM:115-145`); see [residence.md](residence.md).

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Parties per day | 1 per owner (resets at midnight, client countdown to 00:00) | `HUV:262-272`, help text |
| Participation | `Bonfire_Max_Count` = 2 per player per day | `ConfigInfos.xml`, help text |
| Timing | start 2 min after lighting, lasts 10 min, experience every 30 s | help text |
| Small bonfires | `Bonfire_Fire_Small_Max` = 3 small fires per party; lighting one gives items to invited friends | `ConfigInfos.xml`, help text |
| Transformation | `Bonfire_Transformation_Percent` = 20 % chance when lighting a small fire | `ConfigInfos.xml` |
| Invite list | online friends with level >= 12 | `FIF:113-130` |
| Mount showcase | slots from `showMount`; only valid mounts of the owner | `FMI`, `FML:58-85` |

## 6. Templates

| File | Fields used |
|---|---|
| `ConfigInfos.xml` | `Bonfire_Max_Count`, `Bonfire_Transformation_Percent`, `Bonfire_Fire_Small_Max` |
| map nodes (server) | bonfire node `types = 1001` in garden maps, small fire nodes (assumption) |

## 7. Persistent state

```sql
CREATE TABLE farm.bonfire_parties (
  residence_id   BIGINT NOT NULL REFERENCES farm.residences(residence_id) ON DELETE CASCADE,
  party_day      DATE   NOT NULL,
  lit_at         TIMESTAMPTZ NOT NULL,
  starts_at      TIMESTAMPTZ NOT NULL,
  ends_at        TIMESTAMPTZ NOT NULL,
  small_fires    SMALLINT NOT NULL DEFAULT 0 CHECK (small_fires BETWEEN 0 AND 3),
  PRIMARY KEY (residence_id, party_day)
);

CREATE TABLE farm.bonfire_participations (
  player_id      BIGINT NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  party_day      DATE   NOT NULL,
  count          SMALLINT NOT NULL DEFAULT 0 CHECK (count BETWEEN 0 AND 2),
  PRIMARY KEY (player_id, party_day)
);

CREATE TABLE farm.garden_mounts (
  residence_id   BIGINT   NOT NULL REFERENCES farm.residences(residence_id) ON DELETE CASCADE,
  slot           SMALLINT NOT NULL,
  mount_template_id INTEGER NOT NULL,
  PRIMARY KEY (residence_id, slot)
);
```

## 8. Backend implementation notes

| Opcode / op | Handler |
|---|---|
| 5125 on node type 1001 | `farm::bonfire_party::handle_light` (called by the campaign arrive handler) |
| 8873 op 1006 | `farm::bonfire_party::handle_invite` |
| 8873 op 1007 | `farm::bonfire_party::handle_invite_answer` |
| 8873 op 12 | `farm::bonfire_party::handle_dice` |
| 8873 op 11 | `farm::bonfire_party::handle_sit` |
| 8873 op 13 | `farm::bonfire_party::handle_show_mount` |

- Timers: per party schedule (start at +120 s, ticks every 30 s for experience, end at +720 s); push 4982 at lighting and at start; on end push 4982 with `leftTime = 0` and reset the node state.
- Broadcast scope: every player in the garden room for 4969, 4982 and 4753.
- Invite validation: host is the garden owner and a party is running or counting down; invitees are online friends; answer validation: invite pending and not expired (10 s client timer).
- Experience amount per tick: assumption, scale with hero level (server configuration).

## 9. Open questions and assumptions

- Assumption: experience per tick, small fire rewards and their nodes.
- Assumption: participation counter is per invitee per day.
- Unknown: how many showcase slots exist (driven by `showMount` length and map art).

## 10. Implementation checklist

- [ ] Screens (client ready): `FarmUILayer`, `FarmBonCdTimeView`, `FarmInvideFrame`, `InviteFrame` (type 100), `FarmAnimationLayer`, `FarmMountLayer`, `FarmMountSelectMenu`.
- [ ] Bonfire lighting through 5125 node 1001 with timers and broadcasts.
- [ ] Routes 8873 ops 1006, 1007, 11, 12, 13.
- [ ] Messages 4982, 4969, 16 (type 100), 4753 `showMount`.
- [ ] Tables `farm.bonfire_parties`, `farm.bonfire_participations`, `farm.garden_mounts`.
- [ ] Tests: second lighting the same day refused; visitor cannot light; dice value encoding 1XY; third participation refused.
