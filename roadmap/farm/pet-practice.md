# Pet practice ("Prática do Einherjar") and guard pet

Module `pet-practice` of feature `farm`. Farm side of the einherjar practice plots and the farm guard pet. Gameplay rules and pet effects are documented by the pet owner feature in [../einherjar/pet-land.md](../einherjar/pet-land.md); this module lists what the farm server must store and send.

Path aliases:

| Alias | File |
|---|---|
| FM | `decompiled/core_module/scripts/farm/FarmManager.as` |
| PLI | `decompiled/core_module/scripts/farm/data/PetLandInfo.as` |
| FPLV | `decompiled/m3/scripts/farm/view/FarmPetLandView.as` |
| FPSM | `decompiled/m3/scripts/farm/view/FarmPetSelectMeun.as` |
| FAM | `decompiled/m3/scripts/farm/view/FarmAutoMediator.as` |
| PSV | `decompiled/m14/scripts/pet/property/PetShowView.as` |

## 1. Overview

A practice plot holds one pet for a fixed duration (`begin_time` to `end_time`); the owner and friends may feed it up to 5 times, once per tenth of the duration (`PLI:74-99`); when the time is over the owner collects (`PLI:101-115`). One pet can be the farm guard. In this client the plot view (`FPLV`) and the guard view are never instantiated; the remaining live paths are the cancel button in the pet frame (`PSV:845-859`, op 16) and the pet frame state flags `isPractice` / `isDefenser` that read the farm model (`FM:1083-1112`). Implement the server for completeness.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `FarmPetLandView` (`FPLV`) | "Praticar com Einherjar" | plot: select, feed, collect, cancel "Cancelar?" | not instantiated | `PetLandInfo`; "Prática do Einherjar habilitada no nível 50" |
| `FarmPetSelectMeun` (`FPSM`) | | choose a pet (type 1 practice, type 2 guard) | `FPLV`, guard view | own pets |
| Pet frame cancel | "Cancelar Prática" | cancel practice of the shown pet | [einherjar](../einherjar/README.md) pet frame | |

## 3. Routes (client to server)

All: C>S 15044 (0x3ac4) `CH_FARM_OPER_CHECK`, `FarmOperReqMsg` via `FM.sendFarmOper` (`FM:635-651`); the pet id travels in `bag_pos (#7)`.

| Action | op_type | Fields | Client checks | Source |
|---|---:|---|---|---|
| Start practice | 15 `PRACTICE_PET` | `friend_id` = self, `pos` = plot, `bag_pos` = pet id, `template_id` = constant (12 in the einherjar doc) | plot has a pet -> "FarmPetSelectMeun.hasPet"; pet fighting -> "FarmPetSelectMeun.inWar"; pet experience full -> "FarmPetSelectMeun.isFullExp" | `FPSM:236-264` |
| Set guard | 18 `GUARD_PET` | `pos` = current pos, `bag_pos` = pet id | | `FPSM:255-264` |
| Feed | 13 `FARM_FEED` | `friend_id` = plot owner, `pos`, `bag_pos` = pet id, `template_id` = 10 | `PLI.canFeed` | `FPLV:198-206`, `FAM:79-92` |
| Collect or cancel | 16 `CANCEL_PRACTICE_PET` | `friend_id` = self, `pos`, `bag_pos` = pet id | confirm "Cancelar?" when not finished | `FPLV:189-196,344-359`, `PSV:845-859` |
| Complete | 17 `COMPLETE_PRACTICE_PET` | never sent | | `FarmOperateType.as` |

Response: 4387 with `petInfo` (changed plots) and `guard_pet_info` when changed; pet experience push 4540 ([einherjar](../einherjar/pets.md)).

## 4. Server messages (server to client)

`FarmPetInfoMsg` in 4386 / 4387 (`FM:375-398`):

| Field | Tag | Type | Meaning |
|---|---|---|---|
| `user_id` | #1 | INT32 | owner |
| `pet_id` | #2 | INT32 | pet (0 = empty, guard 0 = none) |
| `pos` | #3 | INT32 | plot |
| `begin_time` | #4 | STRING | practice start |
| `end_time` | #5 | STRING | practice end |
| `pet_template_id` | #6 | INT32 | pet template |
| `state` | #7 | INT32 | last fed region 0..5 (`lastFeedRegion`) |
| `pet_name` | #8 | STRING | pet name |
| `quality` | #9 | INT32 | raw quality; client maps `< 26 ? (q - 1) / 5 + 1 : (q - 1) / 5` |

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Unlock | hero level 50 | `FarmPetLandView.noOpen` |
| Feeding | at most 5 feeds; allowed when `floor((now - begin) / ((end - begin) / 10)) > state` | `PLI:74-99` |
| Collect | `now >= end_time` | `PLI:101-115` |
| Restrictions | pet not fighting, not full experience | `FPSM:236-251` |

## 6. Templates

Pet templates ([einherjar](../einherjar/README.md)); duration and experience are server configuration.

## 7. Persistent state

Farm owned table (shape agreed with [../einherjar/pet-land.md](../einherjar/pet-land.md) section 7, placed in the farm schema):

```sql
CREATE TABLE farm.pet_plots (
  player_id         BIGINT   NOT NULL REFERENCES farm.farms(player_id) ON DELETE CASCADE,
  pos               SMALLINT NOT NULL,
  pet_id            BIGINT,
  begin_at          TIMESTAMPTZ,
  end_at            TIMESTAMPTZ,
  last_feed_region  SMALLINT NOT NULL DEFAULT 0 CHECK (last_feed_region BETWEEN 0 AND 5),
  is_guard          BOOLEAN  NOT NULL DEFAULT false,
  PRIMARY KEY (player_id, pos)
);
CREATE UNIQUE INDEX pet_plots_one_guard ON farm.pet_plots (player_id) WHERE is_guard;
```

`pet_id` references the einherjar pets table when it exists.

## 8. Backend implementation notes

| Opcode / op | Handler |
|---|---|
| 15044 op 15 | `farm::pet_practice::handle_start` -> `einherjar::pet_land::handle_start` |
| 15044 op 13 | `farm::pet_practice::handle_feed` -> `einherjar::pet_land::handle_feed` |
| 15044 op 16, 17 | `farm::pet_practice::handle_collect` -> `einherjar::pet_land::handle_collect` |
| 15044 op 18 | `farm::pet_practice::handle_guard` -> `einherjar::pet_land::handle_guard` |

- The farm dispatcher validates the farm and plot; the einherjar service validates the pet and computes experience; one transaction spans both.

## 9. Open questions and assumptions

- Assumption: plot count and positions (not visible in this client).
- Unknown: meaning of `template_id` 10 and 12.

## 10. Implementation checklist

- [ ] Routes 15044 ops 13, 15, 16, 18 (17 accepted as alias of 16).
- [ ] `petInfo` and `guard_pet_info` in 4386 and 4387.
- [ ] Table `farm.pet_plots`.
- [ ] Tests: feed window rule, sixth feed refused, cancel from the pet frame frees the plot.
