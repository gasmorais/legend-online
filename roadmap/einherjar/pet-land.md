# Pet land (Prática do Einherjar on the farm) and farm guard pet

Path aliases:

| Alias | File |
|---|---|
| FM | `decompiled/core_module/scripts/farm/FarmManager.as` |
| PLI | `decompiled/core_module/scripts/farm/data/PetLandInfo.as` |
| PLV | `decompiled/m3/scripts/farm/view/FarmPetLandView.as` |
| PSM | `decompiled/m3/scripts/farm/view/FarmPetSelectMeun.as` |

## 1. Overview

"petland" has no client package of its own. In the client it is the farm pet plot: the player puts a pet to practice ("Praticar com Einherjar") on a farm pet land; the pet gains EXP over a fixed duration, friends (and the owner) can feed it up to 5 times to speed it up, and at the end the owner collects the EXP. One pet can also be set as the farm guard (defender). The farm feature owns the farm scene, plots, protocol and timers ([../farm/README.md](../farm/README.md)); this module lists the pet specific rules and the pet side effects. The island maps called "Ilha de Einherjar" (map ids 20001..25000, `WorldBossHelper.checkPetLand`) are in [boss-island.md](boss-island.md).

Unlock: "Prática do Einherjar habilitada no nível 50" (`FarmPetLandView.noOpen`).

Pet side effects ([pets.md](pets.md), [growth.md](growth.md)): a practicing pet cannot fight, be sacrificed ("Einherjar em prática, não é possível sacrificar"), absorbed or refined; the guard pet asks for confirmation before sacrifice or absorb ("Einherjar está em estado {0}, sacrificar?" with "Proteção"). `PetData.isPractice` / `isDefenser` read the farm model (`decompiled/core_module/scripts/mvc/module/pet/PetData.as:1079-1087`).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `PLV` | "Praticar com Einherjar" | Pet plot: empty (select pet), practicing (feed), done (collect), cancel "Cancelar?" | farm scene | `PetLandInfo` |
| `PSM` | | Pet selector: type 1 practice, type 2 guard (`decompiled/m3/scripts/farm/view/FarmGuardView.as:130`) | plot or guard view | own pets |
| `decompiled/m14/scripts/pet/property/PetShowView.as` | "Cancelar Prática" | Cancel practice from the pet frame (`:825-859`) | pet frame | |

## 3. Routes (client to server)

All: send 15044 (0x3ac4) `CH_FARM_OPER_CHECK`, `FarmOperReqMsg` (package farm): `user_id` (#1), `friend_id` (#2) farm owner, `op_type` (#3), `pos` (#4) plot position, `template_id` (#5), `pay_type` (#6) 0, `bag_pos` (#7). Sender `FM.sendFarmOper(friendId, opType, pos, bagPos, templateId, useBind)` (`FM:635-651`); for pet operations the pet id travels in `bag_pos`.

| Action | UI and client checks | op_type | Fields | Citation |
|---|---|---:|---|---|
| Start practice | Select a pet for an empty plot: plot already has a pet -> "Há Einherjar em prática"; pet fighting -> "Einherjar combatente, não é possível praticar"; pet EXP full -> "Atualmente, a experiência deste einherjar já atingiu ao limite superior, não é possível praticar." | 15 | `pos`, `bag_pos` = pet id, `template_id` = 12 | `PSM:223-264` |
| Set guard pet | Guard selector (type 2) | 18 | `pos` = -1, `bag_pos` = pet id, `template_id` = 12 | `PSM:236-264` |
| Feed | Plot practicing and `canFeed` (owner or friend; at most 5 feeds, one per tenth of the duration elapsed) | 13 | `friend_id` = owner, `pos`, `bag_pos` = pet id, `template_id` = 10 | `PLV:198-206`, auto feed `decompiled/m3/scripts/farm/view/FarmAutoMediator.as:80-90` |
| Collect / cancel | Done (`canGains`) collects; cancel from the pet frame or plot | 16 | `pos`, `bag_pos` = pet id | `PLV:189-196,359`, `PetShowView.as:855` |

Responses: farm messages (farm info with `petInfo` and `guardPetInfo`, `FarmInfoRspMsg`, `FM:430-510`); pet EXP changes arrive in 4540 ([pets.md](pets.md)); `isPractice` (#31) in `PetInfoMsg`.

## 4. Server messages (server to client)

| Message | Fields | Receiver |
|---|---|---|
| `FarmPetInfoMsg` (package farm, inside farm info responses) | `user_id` (#1), `pet_id` (#2), `pos` (#3), `begin_time` (#4, STRING), `end_time` (#5, STRING), `pet_template_id` (#6), `state` (#7), `pet_name` (#8, STRING), `quality` (#9) | `FM.readPetInfoMsg` (`FM:375-410`) into `PLI` |
| 4540 `U_C_PLAYER_PETINFO` | `cur_gp`, `cur_grade`, `isPractice` | `PlayerManager.__petInfoHandler` |

## 5. Rules and formulas

- Feeding window: duration split in 10 parts; a feed is allowed when the elapsed part index > `lastFeedRegion` and `lastFeedRegion < 5` (`PLI:74-99`).
- Collect when now >= `end_time` (`PLI:101-115`).
- One practicing pet per plot; the guard pet is separate.
- Practice EXP amount and duration: server side (`template_id` 12 suggests 12 hours, assumption).

## 6. Templates

Farm templates (farm feature); pet templates for avatar and quality.

## 7. Persistent state

Owned by the farm feature. Proposed shape for the pet part:

```sql
CREATE TABLE einherjar.pet_land_slots (
  player_id         BIGINT      NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  pos               SMALLINT    NOT NULL,
  pet_id            BIGINT      REFERENCES einherjar.pets(pet_id) ON DELETE SET NULL,
  begin_at          TIMESTAMPTZ,
  end_at            TIMESTAMPTZ,
  last_feed_region  SMALLINT    NOT NULL DEFAULT 0,
  is_guard          BOOLEAN     NOT NULL DEFAULT false,
  PRIMARY KEY (player_id, pos)
);
```

## 8. Backend implementation notes

- `farm::handle_oper` (15044) dispatches ops 13, 15, 16, 18 to `einherjar::pet_land::{handle_feed, handle_start, handle_collect, handle_guard}`.
- Start: pet owned, not fighting, not full EXP, plot empty -> set times, mark pet practicing -> farm push + 4540.
- Feed: owner or friend, window rule, max 5 -> shorten or add EXP (assumption) -> farm push to viewers.
- Collect / cancel: grant EXP (capped by lord level) -> clear plot -> 4540.

## 9. Open questions and assumptions

- EXP formula and duration; effect of a feed.
- Meaning of `template_id` 12 and 10 in pet operations.

## 10. Implementation checklist

- [ ] Farm op 15 start practice
- [ ] Farm op 13 feed (owner and friends)
- [ ] Farm op 16 collect / cancel
- [ ] Farm op 18 guard pet
- [ ] `FarmPetInfoMsg` in farm info
- [ ] Pet side effects (`isPractice`, guard confirmations)
- [ ] Table `einherjar.pet_land_slots` (or farm table)
- [ ] Tests: feeding window, practicing pet blocked from fight/sacrifice
