# Hero Road ("Histórico")

Area: roads, module `hero-road`. Client package `heroroad` (`decompiled/m11/scripts/heroroad`), manager `yishi.manager.HeroRoadManager`, info `mvc.module.heroroad.HeroRoadInfo`, controller key `heroroad` (`decompiled/core_module/scripts/mvc/controler/HeroRoadControler.as`), proto package `heroroad`.

The frame `heroroad.HeroRoadFrame` has two tabs: tab 1 "Histórico" (this module: growth milestones with rewards, "Pontos históricos", and day/VIP point packages) and tab 2 "Histórico de Conquistas" (achievements, owned by [medals/achievements.md](../medals/achievements.md); the achievement gift pop-up is in [medals/achievement-gifts.md](../medals/achievement-gifts.md)). `HeroRoadManager` serves both.

Path aliases:

| Alias | File |
|---|---|
| HRM | `decompiled/core_module/scripts/yishi/manager/HeroRoadManager.as` |
| HR | `decompiled/m11/scripts/heroroad/` |

## 1. Overview

A milestone track ("Histórico"): 293 tasks in 7 categories (`MasterType`): 1 growth, 2 exploration, 3 pets, 4 children (guardians), 5 other, 8 advanced (job advance, shown only after the job change), plus packages 6 (day packages, "{0}º dia: Pacote {1}") and 7 (VIP packages, "Pacote de VIP {0}{1}"). Completing a task makes its fixed reward claimable and adds "Pontos históricos" (`HeroRoadScore`, total 2835). Many tasks also offer a discount package (`BuysItems`, priced `BuyNeedPoint` diamonds) that must be bought before claiming the free reward ("Após coletar o prêmio, não é possível comprar este pacote de desconto"). Day packages unlock at a points threshold (`Param1`) and, once bought, give items every day for `Param2` days; VIP packages unlock at a VIP level.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `heroroad.HeroRoadFrame` (`HR/HeroRoadFrame.as`), 950 x 615 | "Histórico de Conquistas" when `VersionSwitch.ACHIEVEMENT` (true, `decompiled/core_module/scripts/yishi/datas/VersionSwitch.as:218`) and tab 2 preselected; else "Histórico" | Tab container (`HR/HeroRoadFrame.as:48-124`) | queue bar `_heroRoadBtn2` / `_heroRoadBtn` (hero level >= 11, `decompiled/core_module/scripts/ui/queuebar/QueueBar.as:731-735`, `:1010-1045`) | |
| `HR/HeroRoadCourseView` (tab 1) | progress "{score}/{total}" or "max" | Points bar, category buttons (`HR/HeroRoadItemView`), day and VIP package boxes (`HR/HeroRoadBoxItemView`) | tab 1 | 407 |
| `HR/HeroRoadItemView` + `HeroRoadItem` | categories 1, 2, 3, 4, 5, 8 (`HR/HeroRoadItemView.as:40-80`); rows "Missão", "Prêmios fixos: Pontos históricos {0}", reward and package icons ("Após abrir obterá: ...") | Task list per category, claim and buy buttons | course view | `HeroRoadInfo` per task, templates |
| `HR/HeroRoadBoxItem` | "Pontos históricos ao atingir {0} pode comprar", VIP variant "VIP Ao atingir {0} pode comprar" | Day and VIP package cards | course view | `MasterType` 6 and 7 |
| `heroroad.HeroRoadConfirmFrame` (`HR/HeroRoadConfirmFrame.as`), 510 x 226 | "{0}º dia: Pacote {1}" / "Pacote de VIP {0}{1}"; "Após comprar poderá obter os seguintes itens diariamente durante {0} dia(s) consecutivos:", "Restam {0} dia(s) de coleta" | Package detail, buy, daily claim | box click -> controller `heroroad` openType 1 with the info (`HR/HeroRoadBoxItem.as:95-98`) | `HeroRoadInfo` |

## 3. Routes (client to server)

Route: send 9634 (0x25a2) `C_HEROROAD_OP`, sender `HRM.operateHandler(op, taskTempId)` (`HRM:375-382`), message `heroroad.HeroRoadListMsg`: `op` (#1, INT32), `taskTempId` (#2, INT32); `heroScore` (#3) and `roadInfo` (#4) unused in requests.

| # | UI control | Client checks | Fields | Response |
|---|---|---|---|---|
| H1 | Task "Coletar" (`HR/HeroRoadItem.as:130-149`), package daily claim (`HR/HeroRoadBoxItem.as:100-104`, `HR/HeroRoadConfirmFrame.as:119-122`) | button enabled when `takeItemsState == 1`; tasks: confirm "Após coletar o prêmio, nãop é possível comprar este pacote de desconto, deseja coletar prêmio?" | `op = 1` (`OP_TAKE_REWARD`), `taskTempId` | 407 (updated states), items via bag updates |
| H2 | Buy discount or day/VIP package (`HR/HeroRoadItem.as:151-174`, `HR/HeroRoadBoxItem.as:106-131`, `HR/HeroRoadConfirmFrame.as:108-116`) | `buysItemsState == 1`; confirm "Deseja consumir {0} diamantes para comprar" (`BuyNeedPoint`); diamonds >= price else recharge dialog | `op = 2` (`OP_BUYS_REWARD`), `taskTempId` | 407 |

No open request exists: 407 must be pushed at login and after every change (the course view only listens, `HR/HeroRoadCourseView.as:110-137`).

Tab 2 uses 8671 `C_ACHIEVEMENT_TASK_CLIENT_OP` (`HRM.achivementOpenFrame`, `achivementGetReward`, `popBuyFrame`, `buyPackage`, `HRM:384-418`) and 4288 / 4289; see [medals/achievements.md](../medals/achievements.md).

## 4. Server messages (server to client)

| Opcode | Message and fields | Client receiver | When |
|---|---|---|---|
| 407 (0x0197) `U_C_HEROROAD_LIST` | `heroroad.HeroRoadListMsg`: `op` (#1, INT32) echo of the last operation; `heroScore` (#3, INT32) accumulated "Pontos históricos"; `roadInfo` (#4, repeated `HeroRoadInfoMsg`: `taskTempId` (#1); `takeItemsState` (#2) 0 not reached, 1 claimable, 2 claimed; `buysItemsState` (#3) 0 locked, 1 buyable, 2 bought; `takeNumbers` (#4) days already claimed for day packages; `masterType` (#5); `index` (#6) display order) | `HRM.__chainBoxHandler` (`HRM:115-141`) rebuilds `itemCate` and fires `HEROROAD_UPDATE_VIEW` | Login, after H1/H2, on task progress and at the daily reset for day packages |

## 5. Rules and formulas

- Template `HeroRoadTempInfos.xml` (293 rows): `MasterType` 1..8 (counts: 1:105, 2:44, 3:31, 4:13, 6:32, 7:27, 8:41); `SonType` = condition type (101 hero level, 1000 day package, 1001 VIP package, others feature specific); `Param1..3` condition values; `QuestType` 1 normal, 2 random reward ("Aleatório"); `PreTaskTempId` chain; `Priority`; `OpenGrades` minimum level of the category; `HeroRoadScore` points; `TakeItems` / `BuysItems` = `itemId,count|...` ("0" = no package); `BuyNeedPoint` diamonds; `BuyNeedFinish` buy requires completion (1); `Describe` text; icons.
- Category unlock: hero level (`grades + (isChangeJob ? 80 + vocationGrades : vocationGrades)`) >= min `OpenGrades` of the category (`HR/HeroRoadItemView.as:43-77`); above 80 shows "runeitemView.tip02".
- Task flow: progress -> `takeItemsState 1`; discount package buyable while not claimed (`buysItemsState 1`); claiming locks the package (assumption: `buysItemsState` becomes 0 or 2).
- Day packages (`MasterType 6`, `SonType 1000`): buyable when `heroScore >= Param1`; after purchase claim once per day for `Param2` days (`takeNumbers` counts).
- VIP packages (`MasterType 7`, `SonType 1001`): buyable at VIP level `Param2` (assumption from "Pacote de VIP {0}" with `Param2`); single purchase gives `BuysItems`.
- Total points = sum of `HeroRoadScore` (2835); progress bar shows "max" when reached.

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `raw/xml/tempinfos/HeroRoadTempInfos.xml` | milestone or package | see rules |

## 7. Persistent state

```sql
CREATE TABLE roads.hero_road_task (
    player_id         BIGINT     NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
    task_temp_id      integer     NOT NULL,
    progress          integer     NOT NULL DEFAULT 0,
    take_state        smallint    NOT NULL DEFAULT 0 CHECK (take_state IN (0, 1, 2)),
    buy_state         smallint    NOT NULL DEFAULT 0 CHECK (buy_state IN (0, 1, 2)),
    take_numbers      smallint    NOT NULL DEFAULT 0,
    last_take_date    date,
    updated_at        timestamptz NOT NULL DEFAULT now(),
    PRIMARY KEY (player_id, task_temp_id)
);

CREATE TABLE roads.hero_road_score (
    player_id   BIGINT  PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
    hero_score  integer  NOT NULL DEFAULT 0
);
```

## 8. Backend implementation notes

- `roads::hero_road::handle_op` (9634): op 1 `handle_take_reward`, op 2 `handle_buy_reward`; both reply 407 with the full list.
- Take: `take_state = 1` (tasks) or day package bought with days left and not taken today; grant `TakeItems` (or `BuysItems` daily for day packages), add `HeroRoadScore` once per task, set `take_state = 2` (day packages: increment `take_numbers`, back to 1 next day while days remain).
- Buy: `buy_state = 1`, deduct `BuyNeedPoint` diamonds, grant `BuysItems` (tasks, VIP) or start the daily schedule (day packages), `buy_state = 2`.
- Progress tracking: subscribe to the source features by `SonType` (level, campaign, pets, guardians, job advance...) and unlock tasks in `PreTaskTempId` order; push 407 on change.
- Daily reset: day packages become claimable again.

## 9. Open questions and assumptions

- Exact `SonType` condition semantics per type (most mirror task condition types).
- Whether claiming a task reward makes its discount package unavailable (`buy_state 0`) or simply hides it.
- VIP package unlock parameter (`Param1` or `Param2`).

## 10. Implementation checklist

- [ ] Template loader `HeroRoadTempInfos.xml`
- [ ] Tables `roads.hero_road_task`, `roads.hero_road_score`
- [ ] 407 at login and after changes
- [ ] H1 take reward, H2 buy package
- [ ] Day package daily claims
- [ ] Progress hooks per `SonType`
- [ ] Tests: claim locks package, day package duration, category unlock
