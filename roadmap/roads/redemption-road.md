# Redemption Road ("Caminho da Salvação")

Area: roads, module `redemption-road`. Client package `redemptionroad` (`decompiled/m13/scripts/redemptionroad`), manager `managers.RedemptionRoadManager`, model `mvc.module.redemptionroad.RedemptionRoadModel` / `RedemptionRoadNodeInfo`, controller key `redemptionroad` (`decompiled/core_module/scripts/mvc/controler/RedemptionRoadControl.as`), proto package `redemptionroad`. Requires the deified hero ([avenger](../avenger/README.md)).

Path aliases:

| Alias | File |
|---|---|
| RRM | `decompiled/core_module/scripts/managers/RedemptionRoadManager.as` |
| RRMOD | `decompiled/core_module/scripts/mvc/module/redemptionroad/RedemptionRoadModel.as` |
| RR | `decompiled/m13/scripts/redemptionroad/` |
| CIM | `decompiled/core_module/scripts/yishi/datas/ConfigInfoManager.as` |

## 1. Overview

A weekly branching tower of 10 floors ("{0}° andar") in three difficulties (1 normal, 2 nightmare, 3 hell). Each floor offers 1 to 3 nodes; each node has a boss or NPC army, a positive buff ("Buff positivo") and a negative buff ("Buff negativo") as skill ids, and a reward. The player chooses one node per floor and fights it (battle type 3888 `REDEMPTION_ROAD_BATTLE`); the chosen path is recorded. Clearing all floors of a difficulty grants the difficulty reward and starts a cooldown before the next difficulty ("Os demônios estão se reunindo, não é possível desafiar"), which can be skipped for 2 diamonds per 10 minutes. Clearing hell means full clearance until the weekly refresh (Monday, "O Caminho da Salvação é atualizado toda segunda-feira").

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `redemption.RedemptionRoadMainFrame` (`RR/RedemptionRoadMainFrame.as`), 760 x 565 | "Caminho da Salvação"; "O Caminho da Salvação é atualizado toda segunda-feira" | Difficulty cards (`RedemptionRoadDiffItem`: current, cleared, cooldown with "Deseja gastar {0} diamantes para zerar o tempo de resfriamento?"), progress "{floor-1}/{max}", difficulty reward, start | controller `redemptionroad` default via `SwitchPageHelp.openRedemptionRoad` (`decompiled/core_module/scripts/yishi/SwitchPageHelp.as:2731-2748`): `VersionSwitch.REDEMPTION_ROAD`, deified (`isAvenger`, "Primeiro complete a prova de Divindade"), `checkScene()`; after a 3888 battle when cleared or in cooldown (`decompiled/m3/scripts/map/space/SpaceSceneController.as:382-391`) | 209 |
| `redemption.RedemptionRoadChapterFrame` (`RR/RedemptionRoadChapterFrame.as`), 760 x 565 | "{0}° andar", "Buff positivo", "Buff negativo" | Floor map with nodes (`RedemptionRoadNodeItem`), path lines, node reward, buff descriptions, challenge | start button -> openType `CHAPTER_FRAME` (`RR/RedemptionRoadMainFrame.as:126-135`); after a 3888 battle otherwise | 208, 209 |

## 3. Routes (client to server)

Route: send 8659 (0x21d3) `C_REDEMPTION_ROAD_CLIENT_OP`, sender `RRM.sendRedemptionRoadRequest(op, id)` (`RRM:103-110`), message `player.PlayerOpMsg`: `op` (#1, INT32), `id` (#5, INT32); other fields unused (full list in [../trials/shadow-land.md](../trials/shadow-land.md)).

| # | UI control | Client checks | Fields | Response |
|---|---|---|---|---|
| R1 | Main frame open (`RR/RedemptionRoadMainFrame.as:60`); chapter frame open when no node data (`RR/RedemptionRoadChapterFrame.as:97-100`) | open checks above | `op = 0` | 208 (node layout of the current difficulty) and 209 (user state) |
| R2 | Chapter "Desafiar" (`RR/RedemptionRoadChapterFrame.as:208-216`) | a node selected on the current floor (only current floor nodes are clickable, `RR/item/RedemptionRoadNodeItem.as:97-126`); main frame start blocked while in cooldown | `op = 1`, `id` = node id | battle 3888; after the battle 209 (new floor, path) |
| R3 | Cooldown skip (`RR/item/RedemptionRoadDiffItem.as:93-117`) | cost = `ceil(minutes left / 10) x redemption_road_point` (2); confirm; diamonds | `op = 2` | 209 (cdTime cleared) |

## 4. Server messages (server to client)

| Opcode | Message and fields | Client receiver | When |
|---|---|---|---|
| 208 (0x00d0) `U_C_REDEMPTION_ROAD_INFO` | `redemptionroad.RedemptionRoadMsg`: `difficulty` (#1, INT32); `layers` (#2, repeated `RedemptionRoadLayerMsg`: `id` (#1) node id, `layer` (#2) floor 1..10, `pos` (#3) slot 0..2, `buff` (#4) skill id, `debuff` (#5) skill id, `boss` (#6, STRING `heroTemplateId,pos|...`), `npc` (#7, STRING `pawnTemplateId,pos|...`), `reward` (#8, STRING `templateId,count|...`)) | `RRM.__nodeTempInfoHandler` (`RRM:59-80`) keyed `layer_pos` | R1; when the difficulty changes; weekly refresh |
| 209 (0x00d1) `U_C_REDEMPTION_ROAD_USER_DATA` | `redemptionroad.RedemptionRoadUserMsg`: `difficulty` (#1) current difficulty 1..3; `layer` (#2) current floor (max + 1 = cleared); `path` (#3, INT32, repeated) chosen node ids; `cdTime` (#4, STRING `YYYY-MM-DD hh:mm:ss`) end of cooldown. Zero values are ignored by the client (`RRM:87-98`) | `RRM.__nodeUserInfoHandler` (`RRM:82-101`) | R1, after battles, R3 |

## 5. Rules and formulas

- Floors and node counts: config `redemption_road_layers` (absent from `ConfigInfos.xml`, default `[1,2,3,2,3,2,3,2,3,1]`, `CIM:1315-1322`) -> 10 floors (`RRMOD.maxLayer`).
- Difficulties: 3 (`maxDiffCount`); clearance = `difficulty >= 3 && layer > maxLayer` (`RRMOD:78-81`).
- Difficulty rewards: `redemption_road_reward_1 = 2060913,3`, `_2 = 2060913,6`, `_3 = 2060913,10` (`CIM:1324-1349`).
- Cooldown after clearing a difficulty: `redemption_road_cd = 1440,1440` minutes (nightmare, hell). The client reads the misspelled key `edemption_road_cd` (`CIM:1351-1358`) and falls back to `[60,120]`, but it only uses `cdTime` from 209.
- Cooldown skip: `redemption_road_point = 2` diamonds per started 10 minutes.
- Weekly refresh on Monday (new node layout, difficulty back to 1).
- Battle: boss or npc army of the node plus the node buff on the player and debuff on the enemy (assumption from the labels).
- Entry: daily guide type 90 (`decompiled/core_module/scripts/managers/DayGuideManager.as:951-952`), space NPC dialog option 147 (`decompiled/m3/scripts/map/space/view/frame/DialogOptionItem.as:840-841`), queue bar (`redemptionroad`).

## 6. Templates

| File | Record | Fields |
|---|---|---|
| `raw/xml/tempinfos/ConfigInfos.xml` | `redemption_road_reward_1..3`, `redemption_road_cd`, `redemption_road_point` | rules |
| Node pools | not in the client (sent in 208) | server configuration |

## 7. Persistent state

```sql
CREATE TABLE roads.redemption_road_state (
    player_id     integer     PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
    week_start    date        NOT NULL,
    difficulty    smallint    NOT NULL DEFAULT 1 CHECK (difficulty BETWEEN 1 AND 3),
    layer         smallint    NOT NULL DEFAULT 1 CHECK (layer BETWEEN 1 AND 11),
    path          integer[]   NOT NULL DEFAULT '{}',
    cd_until      timestamptz
);

CREATE TABLE roads.redemption_road_node (
    player_id     integer     NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
    node_id       integer     NOT NULL,
    difficulty    smallint    NOT NULL,
    layer         smallint    NOT NULL,
    pos           smallint    NOT NULL,
    buff_skill    integer     NOT NULL DEFAULT 0,
    debuff_skill  integer     NOT NULL DEFAULT 0,
    boss          text        NOT NULL DEFAULT '',
    npc           text        NOT NULL DEFAULT '',
    reward        text        NOT NULL DEFAULT '',
    PRIMARY KEY (player_id, node_id)
);
```

Node layouts may instead be global per week (one table without `player_id`); the client cannot tell (open question).

## 8. Backend implementation notes

- `roads::redemption_road::handle_op` (8659): op 0 `handle_info`, op 1 `handle_fight`, op 2 `handle_skip_cd`.
- Info: lazy weekly reset on Monday; generate the layout per difficulty (node counts per floor from the layer config); send 208 then 209.
- Fight: player deified; not in cooldown; node on the current floor; start battle 3888. Win: grant node reward, append node to `path`, `layer += 1`; after floor 10 grant the difficulty reward, set `cd_until = now + cd(difficulty)` and move to the next difficulty (send 208 for it). Push 209.
- Skip CD: charge diamonds, clear `cd_until`, push 209.

## 9. Open questions and assumptions

- Whether the node layout is per player or shared per server week.
- Whether a node path must follow connections between floors (the client draws lines from `path` but lets any node of the current floor be chosen).
- Behaviour on battle defeat (retry allowed, no cost assumed).

## 10. Implementation checklist

- [ ] Config keys loader (`redemption_road_*`)
- [ ] Tables `roads.redemption_road_state`, `roads.redemption_road_node`
- [ ] R1 info (208, 209)
- [ ] R2 fight battle 3888 and progression
- [ ] R3 cooldown skip
- [ ] Weekly reset
- [ ] Tests: difficulty progression, cooldown cost rounding, clearance state
