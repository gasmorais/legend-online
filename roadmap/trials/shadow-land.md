# Shadow Land ("Terra Sombria")

Area: trials, module `shadow-land`. Client package `shadowland` (`decompiled/m11/scripts/shadowland`), manager `yishi.manager.ShadowLandManager`, model `mvc.module.shadowland.ShadowLandModel`, controller key `shadowland`. Messages `module.ShadowLandMsg` and `player.PlayerOpMsg`. Sweeps use the generic [mopup](../mopup/README.md) route with `sweep_type = 6`.

Path aliases:

| Alias | File |
|---|---|
| SLM | `decompiled/core_module/scripts/yishi/manager/ShadowLandManager.as` |
| SLMOD | `decompiled/core_module/scripts/mvc/module/shadowland/ShadowLandModel.as` |
| SL | `decompiled/m11/scripts/shadowland/` |

## 1. Overview

5 continents ("continentes", `AreaId` 1..5), each with 6 checkpoints in "Normal" difficulty and 6 in "Demônio" difficulty. Every fight costs 10 energy (max 200, +10 per hour). Checkpoints unlock in order; the demon difficulty of a continent opens after its 6 normal checkpoints. Each cleared checkpoint gives a star; a chest per continent and difficulty can be opened once its stars are complete. Cleared checkpoints can be swept. Battle type 3897 `SHADOW_LAND_BATTLE`.

Help text (`ShadowLandFrame.helpTxt.text`): 5 continents x 12 monsters (6 normal, 6 demon); energy is consumed per challenge; cleared monsters can be swept; demon difficulty opens after all normal monsters of the continent; stars open the chest.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `shadowland.ShadowLandFrame` (`SL/ShadowLandFrame.as:41`), 1180 x 770 | "Terra Sombria"; energy "{0}/{1}"; help "Guia da Terra Sombria" | World map with 5 continents | controller `shadowland` (default openType) via `SwitchPageHelp.openShadowLandFrame` (`decompiled/core_module/scripts/yishi/SwitchPageHelp.as:2949-2966`) | 517 |
| `ShadowLandMapItem` (`SL/ShadowLandMapItem.as`) | "Área temporariamente bloqueada" when locked | Continent button, locked when `mapId > openMaxAreaId` (`:77-90`) | map | `openMaxAreaId` |
| `shadowland.ShadowLandChapterFrame` (`SL/ShadowLandChapterFrame.as:73`), 1123 x 456 | tabs normal / demon, stars "{passed}/6", chest with tip "Pode obter ao coletar:" | 6 checkpoints, chest | continent click -> controller `shadowland` openType 2 with `[areaId]` or `[areaId, difficulty]` | 517, `ShadowLandTemplates`, box drop |
| `ShadowLandNodeItem` (`SL/ShadowLandNodeItem.as`) | | Checkpoint: cleared (no star icon), next (highlighted), locked (gray) (`:97-127`) | chapter frame | `passNodeId` |
| `shadowland.ShadowLandFightFrame` (`SL/ShadowLandFightFrame.as:52`), 450 x 389 | "Normal {0}-{1}" / "Demônio {0}-{1}", energy cost | Fight, sweep (enabled when cleared), fixed rewards (`appearType 1`) and drops | node click (energy check) -> openType 3 with the template (`SL/ShadowLandNodeItem.as:85-95`) | template, fight drop |
| `mopup.view.ShadowLandMopupPrepareFrame` / `ShadowLandMopupIngFrame` | "Bot da Terra Sombria" | Sweep a cleared checkpoint | fight frame "Modo Bot" -> controller `mopup` openType 19 (`SL/ShadowLandFightFrame.as:137-140`), 20 | 4425 |

## 3. Routes (client to server)

Route: send 9702 (0x25e6) `C_SHADOW_LAND_OP` with `player.PlayerOpMsg`. Fields: `op` (#1, INT32), `type` (#2), `payType` (#3), `count` (#4), `id` (#5), `index` (#6), `userId` (#7), `templateId` (#8), `campaignId` (#9), `nodeId` (#10), `chapterId` (#11), `uuid` (#12, STRING), `value1` (#13), `value2` (#14), `param1` (#15, STRING), `param2` (#16, STRING), `flag1` (#17, BOOL), `flag2` (#18, BOOL), `pos` (#19), `ids` (#20, INT32, repeated). Only the listed fields are set.

| # | UI control | Client sender | Client checks | Fields | Response |
|---|---|---|---|---|---|
| S1 | Map or chapter frame open | `SLM.sendDataRequest` (`SLM:92-98`) from `SL/ShadowLandFrame.as:47`, `SL/ShadowLandChapterFrame.as:78` | open: `VersionSwitch.SHADOW_LAND` ("Esta função ainda não foi ativada"), hero holy class `thane.isHoly` ("Abre com a Classe Consagrada"), `checkScene()` | `op = 0` | 517 |
| S2 | Fight "Desafiar" | `SLM.sendFight(checkpointId)` (`SLM:100-107`) from `SL/ShadowLandFightFrame.as:132-135` | node click requires energy >= `consume` ("Energia insuficiente", `SL/ShadowLandNodeItem.as:85-91`) | `op = 1`, `id` = `CheckpointId` | battle 3897; after the battle 517; the client reopens the chapter frame (`decompiled/m3/scripts/map/space/SpaceSceneController.as:415-424`) |
| S3 | Chest click | `SLM.sendGetReward(areaId, difficulty)` (`SLM:109-117`) from `SL/ShadowLandChapterFrame.as:154-167` | state 0: "Estrelas insuficientes para Coletar"; state 2: `ShadowLandChapterFrame.hasGetReward` | `op = 2`, `chapterId` = area id, `value1` = difficulty | 517 with `boxStates` updated, items granted |
| S4 | Sweep | `MopupManager.sendMopupInfo(6, op, checkpointId, count)` (`decompiled/m5/scripts/mopup/view/ShadowLandMopupPrepareFrame.as:218-250`, `ShadowLandMopupIngFrame.as:396`, `:430`, `:451`, `:596`) | count >= 1; energy >= count x 10; gold >= count x 50000 ("Ouro insuficiente") | send 8528 (0x2150) `C_CAMPAIGN_SWEEP`, `CampaignSweepReq`: `sweep_type` (#1) 6, `op_type` (#2) 1 start / 2 accelerate / 3 cancel / 4 close, `campaign_id` (#3) checkpoint id, `count` (#4), `pay_type` (#9) | 4425 (mopup), 517 with new energy |

## 4. Server messages (server to client)

| Opcode | Message and fields | Client receiver | When |
|---|---|---|---|
| 517 (0x0205) `U_C_SHADOW_LAND_INFO` | `module.ShadowLandMsg`: `openAreaId` (#1, INT32) highest open continent; `checkpointId` (#2, INT32) unused; `bodyStrength` (#3, INT32) current energy; `updateTime` (#4, STRING) unused (last regeneration time, assumption); `boxStates` (#5, STRING) CSV of `area|difficulty|state` with state 0 locked, 1 collectable, 2 collected; `nodeList` (#6, repeated `ShadowLandNodeMsg`: `areaId` (#1), `difficulty` (#2) 1 normal / 2 demon, `nodeId` (#3) highest cleared node 0..6) | `SLM.__shadowLandUpdateHandler` (`SLM:61-90`); only fields present (`has*`) are applied; `SHADOWLAND_INFO_UPDATE` refreshes the frames | Reply to S1, S3; after each battle and sweep; on energy regeneration while the frame is open (optional) |

A `nodeList` entry must exist for every open area and difficulty, otherwise the chapter frame shows nothing for it (`SL/ShadowLandChapterFrame.as:206-215`).

## 5. Rules and formulas

- Energy (`shadow_land_config = 200,10,10`): max 200, +10 per hour, 10 per fight (`SLMOD:87-102`).
- Open content (`shadow_land_open_config = 5,2`): 5 continents, 2 difficulties.
- Unlock order: checkpoint N of (area, difficulty) requires N - 1 cleared; demon difficulty requires the 6 normal checkpoints of the same area; next area requires the previous area normal clear (assumption: `openAreaId` grows when the 6 normal checkpoints are cleared).
- Stars = cleared checkpoints of (area, difficulty); chest collectable at 6/6 (assumption from "Estrelas insuficientes").
- Rewards per fight: `ShadowLandFightDrop.xml` rows with `site = difficulty`, `para2 = "area,node"`; `appearType 1` fixed reward, other values random drop (`SL/ShadowLandFightFrame.as:90-116`).
- Chest: `ShadowLandBoxDrop.xml` rows with `site = difficulty`, `para2 = area` (10 rows).
- Sweep (`shadow_land_sweep_config = 60,50000`): 60 s and 50000 gold per run, 10 energy per run; accelerate with `Sweep_Fast`.
- Battle 3897: `Bosses = "heroTemplateId,pos"`, waves `Npc1`, `Npc2`, `Npc3` = `pawnTemplateId,pos|...` (3 waves before or with the boss, assumption).
- Entry points: daily guide type 94 (`decompiled/core_module/scripts/managers/DayGuideManager.as:963-964`), space NPC dialog option 152 (`decompiled/m3/scripts/map/space/view/frame/DialogOptionItem.as:852-853`), task links via `openShadowLandFrameByTask` (`SwitchPageHelp.as:2968-2993`).

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `raw/xml/tempinfos/ShadowLandTemplates.xml` (60 rows) | checkpoint | `CheckpointId` (area x 10000 + difficulty x 100 + node, e.g. 10101), `AreaId`, `NodeId` 1..6, `Difficulty` 1..2, `Npc1..3`, `Bosses` |
| `raw/xml/tempinfos/ShadowLandFightDrop.xml` | fight reward | `dropId`, `site`, `para2`, `itemId`, `count`, `isBind`, `appearType` |
| `raw/xml/tempinfos/ShadowLandBoxDrop.xml` | chest reward | `site`, `para2`, `itemId`, `count` |
| `raw/xml/tempinfos/ConfigInfos.xml` | `shadow_land_config`, `shadow_land_sweep_config`, `shadow_land_open_config` | |

## 7. Persistent state

```sql
CREATE TABLE trials.shadow_land_state (
    player_id        integer     PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
    open_area_id     smallint    NOT NULL DEFAULT 1 CHECK (open_area_id BETWEEN 1 AND 5),
    energy           smallint    NOT NULL DEFAULT 200 CHECK (energy >= 0),
    energy_updated_at timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE trials.shadow_land_progress (
    player_id        integer  NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
    area_id          smallint NOT NULL CHECK (area_id BETWEEN 1 AND 5),
    difficulty       smallint NOT NULL CHECK (difficulty IN (1, 2)),
    passed_node      smallint NOT NULL DEFAULT 0 CHECK (passed_node BETWEEN 0 AND 6),
    box_state        smallint NOT NULL DEFAULT 0 CHECK (box_state IN (0, 1, 2)),
    PRIMARY KEY (player_id, area_id, difficulty)
);
```

## 8. Backend implementation notes

- `trials::shadow_land::handle_request` (op 0): regenerate energy lazily (`floor(hours since energy_updated_at) x 10`, capped at 200), reply 517 with every progress row.
- `trials::shadow_land::handle_fight` (op 1): validate checkpoint exists, unlocked (previous node passed, demon gate, area open), energy >= 10; deduct energy and start battle 3897 (boss + npc waves). On victory: if first clear update `passed_node`, set `box_state = 1` at 6/6, open the next area when normal 6/6; grant fixed rewards and roll drops. Push 517.
- `trials::shadow_land::handle_reward` (op 2): `box_state` must be 1; grant chest items and set 2 in one transaction; push 517.
- Sweep: handled by `mopup::handle_campaign_sweep` sweep type 6, only for checkpoints with `passed_node >= node`; deduct energy and gold per run.

## 9. Open questions and assumptions

- Assumption: energy regeneration is computed lazily; `updateTime` may be the server timestamp of the last tick.
- Assumption: chest unlocks at 6 stars; the exact star count is not in the client.
- Assumption: area N + 1 opens after the normal checkpoints of area N.
- Battle map for 3897 is not in the client templates.

## 10. Implementation checklist

- [ ] Template loaders for `ShadowLandTemplates.xml`, `ShadowLandFightDrop.xml`, `ShadowLandBoxDrop.xml`, config keys
- [ ] Tables `trials.shadow_land_state`, `shadow_land_progress`
- [ ] S1 request -> 517
- [ ] S2 fight -> battle 3897 -> rewards -> 517
- [ ] S3 chest reward
- [ ] S4 sweep type 6 via mopup
- [ ] Energy regeneration
- [ ] Tests: unlock order, demon gate, energy cost and cap, chest once
