# Dragon Talker combat beast ("Fera de Combate")

Module `battle-beast`. The Dragon Talker rides a combat beast. The beast has one shared exp pool (levels 1..8) fed with "Forragem do Outro Mundo"; each level unlocks one more beast appearance (Grendel, Fafnir, Piasa, Falak, Serafim, Jormungandr, Nidhogg, ...) and raises the beast stats and the initial attack points. The player chooses which unlocked appearance to ride.

Path aliases:

| Alias | File |
|---|---|
| DTM | `decompiled/core_module/scripts/managers/DragonTalkerManager.as` |
| DMOD | `decompiled/core_module/scripts/mvc/module/dragontalker/DragonTalkerModel.as` |
| V | `decompiled/m5/scripts/dragontalker/` |

`DragonTalkerOpMsg` and 4845 are documented in `talker.md`.

## 1. Overview

- Level = `UpGradeTempInfos` Types 140 from `fightMountGp` (Data: 0, 800, 2300, 4300, 6800, 9600, 12600, 17600 for levels 1..8) (`DTM:102-113`).
- Feed item: config `DragonTalker_Gp_Item_Config` = "208066,10,208067,10": items 3 and 4 are the beast food 208067 "Forragem do Outro Mundo" and its exp per item (10). The client falls back to `[208066,10,208067,30]` when the config row is missing (`decompiled/core_module/scripts/yishi/datas/ConfigInfoManager.as:801-808`).
- Appearances: `DragonTalkerFightMountTemplates.xml`, one row per `Grade` with `MountTempId`, `TemplateName`, `AvatarPath`, `Power`, `Agility`, `Intellect`, `Physique`, `HitPoint`.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `V/view/DragonTalkerBattleBeastView.as`, `V/item/DragonTalkerBattleBeastPropItem.as`, `V/view/BattleBeastShowAvatarView.as` | tab "Fera de Combate" | train the beast, open preview | `DragonTalkerFrame` beast tab | name and avatar of the selected appearance, exp bar `battleBeastExp / battleBesatCurMaxExp` or "Max", food count, current and next level rows: "Nv. {n} Pontos de ataque iniciais +{HitPoint}" and "Ativar Nova Aparência" on the next row (`:160-200`, prop item `:55-76`) |
| `V/DragonTalkerMountPreviewFrame.as`, `V/item/DragonTalkerMountPreviewItem.as` | "Visualização da Fera de Combate" | list of all appearances with a select button | change button, `DragonTalkerController` openType `BATTLE_BEAST_PREVIEW_FRAME` | select enabled when `battleBeastGrade >= Grade`, else tooltip "armyII.SkillFrame.AlertMsg" with the required level |

## 3. Routes (client to server)

Send 9667 (0x25c3) `C_DRAGONTALKER_OP`, `DragonTalkerOpMsg`.

### A1. Feed the beast (op 8 STRENGTHEN_FIGHTMOUNT)
- UI: train button (`V/view/DragonTalkerBattleBeastView.as:141-149`), count input clamped to `[1, min(owned, 9999)]` (`:122-135`).
- Client checks: count <= 0 or > owned -> "PetHallowsRightSkillView.train.noGoodsAlert"; disabled at max level.
- Sender: `DTM.sendFightMountStrengthReq(count)` (`DTM:308-315`).
- Request: `op`=8, `count` (#3).
- Response: bag update 115 (owner [inventory](../inventory/README.md)); 4845 with `fightMountGp` (#6) (total exp).

### A2. Select an appearance (op 9 SELECT_FIGHT_MOUNT)
- UI: select on a preview row (`V/item/DragonTalkerMountPreviewItem.as:82-88`), closes the preview.
- Request: `op`=9, `mountTempId` (#10).
- Response: 4845 with `currentFightMount` (#4).

## 4. Server messages (server to client)

4845 (0x12ed) `U_C_DRAGONTALKER_INFO` fields used here: `currentFightMount` (#4, INT32) -> `model.selectBattleBeastId`; `fightMountGp` (#6, INT32) -> level, exp inside the level and level span computed client side (`DTM:98-113`). Full table in `talker.md`.

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Exp per food | 10 (config) | `ConfigInfos.xml` `DragonTalker_Gp_Item_Config` |
| Level | Types 140, max 8 (`getIsFullByType(140, grade)`: grade >= 8 rows) | `DMOD:182-197` |
| Exp cap | stop at 17600 total *(assumption: excess food not consumed)* | |
| Selectable appearance | `MountTempId` with `Grade <= level` | `V/item/DragonTalkerMountPreviewItem.as:100-130` |
| Stats | beast row of the current level gives `Power`, `Agility`, `Intellect`, `Physique` (added to the Dragon Talker) and `HitPoint` (initial attack points in battle) *(assumption on stat application)* | `DragonTalkerFightMountTemplates.xml` |

## 6. Templates

| File | Fields |
|---|---|
| `DragonTalkerFightMountTemplates.xml` | `Grade`, `MountTempId`, `TemplateName`, `AvatarPath`, `Power`, `Agility`, `Intellect`, `Physique`, `HitPoint`, `Description` |
| `UpGradeTempInfos.xml` Types 140 | `Grades`, `Data` |
| `ConfigInfos.xml` | `DragonTalker_Gp_Item_Config` |

## 7. Persistent state

Columns `fight_mount_id` and `fight_mount_gp` of `dragon.talkers` (`talker.md` section 7). No extra table.

## 8. Backend implementation notes

| op | Handler |
|---|---|
| 8 | `dragon::battle_beast::handle_feed` |
| 9 | `dragon::battle_beast::handle_select` |

- Op 8: feature open -> count 1..9999 -> owned food >= count -> not max level -> transaction: consume, add `count * 10` exp (cap at max) -> push 115 then 4845 (`fightMountGp`) -> hero stats push.
- Op 9: template exists and `Grade <= level` -> update -> push 4845 (`currentFightMount`); also refresh the avatar for other players in the scene *(assumption: scene avatar broadcast owned by the hero/world features)*.
- Battle: the beast `HitPoint` seeds the Dragon Talker's initial attack points (see `docs/battle/server-engine.md`).

## 9. Open questions and assumptions

- *(assumption)* Exact stat application of `Power/Agility/Intellect/Physique`.
- *(assumption)* Excess food handling at max level.

## 10. Implementation checklist

- [ ] Op 8 feed with config driven exp.
- [ ] Op 9 select with level gate.
- [ ] 4845 fields #4 and #6.
- [ ] Tests: 80 food from level 1 reaches level 2 (800 exp); select of a level 5 appearance at level 4 rejected; feeding at level 8 rejected.
