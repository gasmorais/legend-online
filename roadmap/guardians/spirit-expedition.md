# Espírito de Proteção expedition ("Expedição do Espírito de Proteção")

Module `spirit-expedition`. A solo PvE chapter map for Espírito de Proteção teams: areas with nodes (some with bosses) are cleared in order for stars; each spirit has "Espírito primordial" energy spent per battle; star totals open chest rewards; progress resets weekly. Battles use battleType 3895 `EXPEDITION_BATTLE`.

Disabled in this client build: `VersionSwitch.SPIRIT_EXPEDITION = false` (`decompiled/core_module/scripts/yishi/datas/VersionSwitch.as:194`). Implement only if the switch is enabled.

Path aliases:

| Alias | File |
|---|---|
| SEM | `decompiled/core_module/scripts/managers/SpiritExpeditionManager.as` |
| SEMOD | `decompiled/core_module/scripts/mvc/module/childspiritexpedition/SpiritExpeditionModel.as` |
| SEC | `decompiled/core_module/scripts/mvc/controler/SpiritExpeditionControl.as` |
| V | `decompiled/m14/scripts/childspiritexpedition/` |

## 1. Overview

- Send 8661 (0x21d5) `C_EXPEDITION_CLIENT_OP`, `PlayerOpMsg` (package `player`): `op` (#1), `id` (#5), `index` (#6), `nodeId` (#10), `chapterId` (#11), `param1` (#15).
- Ops (`decompiled/core_module/scripts/mvc/module/childspiritexpedition/SpiritExpeditionOpClass.as`): 1 REQUEST_DATA, 2 FIGHT, 3 EDIT_POS, 4 EDIT_SKILL, 5 GET_REWARD, 6 CLEAR_CD.
- Receive 4274 (0x10b2) `U_C_EXPEDITION_DATA` and 4275 (0x10b3) `U_C_EXPEDITION_EDIT`, both `ExpeditionMsg`.
- Entry: `SwitchPageHelp.openSpiritExpeditionFrame` (`decompiled/core_module/scripts/yishi/SwitchPageHelp.as:2911-2928`): switch on, `thane.isAvenger` ("Primeiro complete a prova de Divindade", see [avenger](../avenger/README.md)), scene check; queue bar shows expedition state (`decompiled/core_module/scripts/yishi/manager/QueueBarManager.as:93-94`).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `V/SpiritExpeditionFrame.as`, `V/SpiritExpeditionMapItem.as` | "Sobre a expedição do Espírito de Proteção" | area map ("A região não está desbloqueada, desafie mais fases") | `SEC` default | `openAreaId`, areas |
| `V/SpiritExpeditionChapterFrame.as`, `V/SpiritExpeditionNodeItem.as` ("Chefão"), `V/SpiritExpeditionRewardItem.as` | "Drop de fase" | nodes of an area, fight, chests | `SEC` openType 2 | `passNodeId`, rewards string |
| `V/formation/SpiritExpeditionFormationFrame.as`, `V/formation/SpiritExpeditionNSHeadItem.as`, `V/formation/SpiritExpeditionSkillSelectView.as`, `V/formation/SpiritExpeditionChildSkillItem.as` | "Clique na caixa de habilidades para alterar habilidades", "Pontos de Espírito primordial: {0}/{1}" | up to 3 spirits, 5 active skills each, energy refill | `SEC` openType 3 | edits |

## 3. Routes (client to server)

| op | UI | Fields | Client checks | Response |
|---|---|---|---|---|
| 1 | frame open (`V/SpiritExpeditionFrame.as:69`) | | | 4274 |
| 2 | fight (`V/SpiritExpeditionChapterFrame.as:170-185`) | `chapterId` = area, `nodeId` = `passNodeId + 1` | team not empty ("Defina antes o Espírito de Proteção de combate"), energy ("Valor de pontos de Espírito primordial insuficiente") | battle 3895, then 4274 |
| 3 | save positions (`V/formation/SpiritExpeditionFormationFrame.as:304`, `V/formation/SpiritExpeditionChildSkillItem.as:222`) | `param1` = formation string (child ids by position) | | 4275 |
| 4 | save skills (`V/formation/SpiritExpeditionChildSkillItem.as:130`, `:194`) | `id` = child id, `param1` = skill list (max 5) | "Sem habilidades a escolher" | 4275 |
| 5 | open chest (`V/SpiritExpeditionRewardItem.as:73`) | `index` = chest 1..n | stars ("Estrelas insuficientes para coletar..."), not taken ("Não pode coletar mais") | 4274, bag 115 |
| 6 | refill energy (`V/formation/SpiritExpeditionNSHeadItem.as:140-154`) | `id` = child id | confirm "Deseja gastar {0} diamantes para recuperar todos os pontos de Espírito primordial?" | 4275 |

## 4. Server messages (server to client)

`ExpeditionMsg`: `openAreaId` #1 (max open area), `rewards` #2 STRING (chest state), `areas` #3 repeated {`areaId` #1, `passNodeId` #2}, `edits` #4 repeated `ExpeditionEditMsg` {`childId` #1, `energy` #2, `pos` #3 (grid position, order `[3,1,6,4,9,7,12,10]`), `skills` #4 STRING, `cdTime` #5 STRING "YYYY-MM-DD hh:mm:ss" (energy recovery end)}.

| Opcode | Receiver | Fields applied |
|---|---|---|
| 4274 (0x10b2) `U_C_EXPEDITION_DATA` | `SEM.__expeditionMsgHandler` (`SEM:57-101`) | all; `EXPEDITION_INFO_UPDATE` |
| 4275 (0x10b3) `U_C_EXPEDITION_EDIT` | `SEM.__expeditionFormationMsgHandler` (`SEM:114-140`) | `edits` only; `FORMATION_INFO_UPDATE` |

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Team | up to 3 spirits, 5 active skills each in fixed order; passive and awakening skills always on | help text |
| Energy | max `expedition_max_energy` 1000; each battle costs `expedition_cost_energy` 100 at entry plus `(1 - hpLeft%) * expedition_energy_rate (100)` after; at 0 the spirit recovers for `expedition_cd_minute` (3600 min *(assumption: unit as written)*) | config, help text |
| Refill | `expedition_cd_point` "30,5": 5 diamonds per 30 minutes remaining | config |
| Nodes | `ExpeditionTemplates.xml` (60): `AreaId`, `NodeId`, `Star`, `Bosses` ("unit,pos"), `Npcs` ("unit,pos|...") | template |
| Drops | `ExpeditionFightDrop.xml` per node (`para2` node), e.g. 208526 x30 | template |
| Chests | `ExpeditionStarDrop.xml` (8): `site` = stars needed (13, 26, 49, 72, ...), item 208528 x25/50 | template |
| Reset | weekly progress reset; unlocked areas stay | help text |
| Battle | 3895 (P-CHILD, no bottom bar) | `docs/battle/rules.md` |

## 6. Templates

`ExpeditionTemplates.xml`, `ExpeditionFightDrop.xml`, `ExpeditionStarDrop.xml`, `ConfigInfos.xml` (`expedition_*`).

## 7. Persistent state

```sql
CREATE TABLE guardians.expedition_progress (
  player_id      BIGINT   PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
  open_area_id   SMALLINT NOT NULL DEFAULT 1,
  area_pass_nodes JSONB   NOT NULL DEFAULT '{}',
  chests_taken   SMALLINT[] NOT NULL DEFAULT '{}',
  week_start     DATE     NOT NULL
);

CREATE TABLE guardians.expedition_spirits (
  player_id   BIGINT   NOT NULL REFERENCES guardians.expedition_progress(player_id) ON DELETE CASCADE,
  child_id    INTEGER  NOT NULL REFERENCES guardians.children(child_id) ON DELETE CASCADE,
  energy      SMALLINT NOT NULL DEFAULT 1000,
  pos         SMALLINT NOT NULL DEFAULT 0,
  skills      INTEGER[] NOT NULL DEFAULT '{}',
  recover_at  TIMESTAMPTZ,
  PRIMARY KEY (player_id, child_id)
);
```

## 8. Backend implementation notes

Handlers `guardians::spirit_expedition::handle_<action>`: `request_data` (1), `fight` (2), `edit_pos` (3), `edit_skill` (4), `get_reward` (5), `clear_cd` (6).

- Fight: area open, node = next node, team energy >= 100 each; deduct entry energy; battle 3895 with NPCs/bosses at their positions; after the battle deduct HP based energy, update `passNodeId` and stars, grant drops; push 4274.
- Weekly reset job.

## 9. Open questions and assumptions

- Feature disabled by version switch.
- *(assumption)* Star count per node equals `Star` on first clear; chest indexes match `ExpeditionStarDrop` order.

## 10. Implementation checklist

- [ ] 8661 ops 1..6, pushes 4274, 4275 (behind a feature flag).
- [ ] Tables `guardians.expedition_progress`, `guardians.expedition_spirits`.
- [ ] Battle 3895 and energy rules.
- [ ] Tests: fight without energy rejected; chest below star threshold rejected; weekly reset keeps `open_area_id`.
