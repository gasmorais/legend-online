# Guardians wanted PvE ("Guardiões Procurados")

Module `pve`. A daily PvE chain of 8 wanted bosses for guardian teams, reached from the patrol ("Posição de Guardião Procurado"). The player sets a guardian formation (max 4 guardians), challenges the next boss in battleType 3845 `CHILD_PVE_BATLE`, unlocks boss skills for the guardian skill bar, and is ranked daily by progress (HTTP ranking file).

Path aliases:

| Alias | File |
|---|---|
| PVC | `decompiled/core_module/scripts/mvc/controler/ChildPveController.as` |
| PVM | `decompiled/core_module/scripts/mvc/module/children/ChildPveModel.as` |
| CM | `decompiled/core_module/scripts/managers/ChildManager.as` |
| QBM | `decompiled/core_module/scripts/yishi/manager/QueueBarManager.as` |
| V | `decompiled/m14/scripts/childpve/` |

Proto package `guardpve` is registered under [final-defense](../final-defense/README.md) in `roadmap/features.json`, but the only client user is this module.

## 1. Overview

- Send 9548 (0x254c) `C_GUARDPVE_REQ`, `GuardPVEReqMsg`: `opType` (#1, INT32) 1 boss info, 2 formation, 3 challenge; `index` (#2, INT32) boss index 1..8; `guardPos` (#3, repeated `GuardPosMsg`: `param1` #1 child id, `param2` #2 grid position or -1).
- Receive 4979 `U_C_GUARDPVE_OPRSP` (0x1373), `GuardPVERspMsg`; this opcode is missing from `protocol/opcodes.csv` (name from `decompiled/core_module/scripts/yishi/datas/consant/AcceptProtocolType.as:1302`).
- Ranking: HTTP GET `PathManager.getChildPveOrderPath()` = `{TPL}guardpverank.xml` (`routes/routes.md`), XML `info@createDate` and `GuardPVEOrder` rows (`PVC:323-360`).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `V/ChildPveReadyFrame.as`, `V/ChildPveBossItem.as`, `V/ChildPveSkillItemView.as` | "Guardiões Procurados", "(Verificar rank dos desejados)", "Ao vencer o Boss pode obter prêmios:", "Guardião desejado será liberado ao atingir nv.{0}" | 8 boss cards, challenge button on the first unbeaten, unlocked skills | `FrameControllerManager` key `childpve` -> `PVC.preStart(info)` (`decompiled/core_module/scripts/yishi/manager/FrameControllerManager.as:1674-1676`) from the patrol point frame with a `ChildPatrolTowerInfo`; without tower info opens the patrol hall (`PVC:271-286`) | `bossInfo`, `skillInfo`, `rank`, `process` |
| `V/ChildFormationFrame.as`, `V/ChildFormationItemView.as`, `V/ChildFormationHeadView.as` | "Ajustar Formação", "Posição cheia", "Por favor configure pelo menos um guarda", "Pode configurar no máximo 4 Einherjar para participar no Combate, quer fechar?" | formation | ready frame | `CMOD.formationString` |
| `V/ChildPveOrderFrame.as`, `V/ChildPveOrderItemView.as` | "Rank de desejados(Atualizado às 0h)", "Rank", "Jogador", "Progresso", "Poder de combate" | daily ranking from HTTP | ready frame link | XML rows, own row from local data |

## 3. Routes (client to server)

### A1. Load (opType 1)
- `PVC.preStart` (`PVC:79-92`): requires at least one guardian ("Você ainda não contém nenhum guardião"); `sendReqChildPveInfo` (`PVC:192-198`).
- Request: 9548 `opType`=1.
- Response: 4979 `opType` 1 with all boss info -> `start` opens the ready frame (`PVC:186-189`, also `CM:201-204`).

### A2. Save formation (opType 2)
- UI: `V/ChildFormationFrame.as:440-456` -> `PVC.sendChildFormation(formationString)` (`PVC:200-230`): for every guardian `param1` = child id, `param2` = grid position from `[1,4,7,10,3,6,9,12]` by slot, -1 when not placed. At least one guardian, at most 4.
- Response: 4979 with `guardPos` echoed *(assumption)*.

### A3. Challenge (opType 3)
- UI: `V/ChildPveReadyFrame.as:204-212`: at least one guardian placed (`CMOD.getFightChildCount`); beaten bosses cannot be selected ("não pode ser desejado outra vez").
- Request: 9548 `opType`=3, `index` = boss slot 1..8.
- Response: battle start, battleType 3845 (`docs/battle/rules.md` row 3845: `ChildpveBattleBar`, boss skill through 14001 `B_REMOTE_PET_ORDER`); after the battle 4979 `opType` 2 with that boss state.

### A4. Ranking (HTTP)
- `PVC.loadChildPveOrderData` (`PVC:323-327`) from `V/ChildPveOrderFrame.as:70`, `:142`.

## 4. Server messages (server to client)

### S1. 4979 `U_C_GUARDPVE_OPRSP`, `GuardPVERspMsg`
Receivers: `PVC.__refreshBossInfo` (`PVC:101-190`), `CM.__refreshBossInfo` (`CM:153-205`) and `QBM.__refreshChildPveBossInfo` (`QBM:537-570`, queue bar counters).

| Field | Tag | Type | Rep | Meaning |
|---|---|---|---|---|
| `opType` | #1 | INT32 | | 1 full info (opens the frame), 2 single boss update |
| `bossInfo` | #2 | GuardBossMsg | yes | `bossOrder` #1 (template id), `bossIndex` #2 (slot), `bossState` #3 (1 = beaten) |
| `guardPos` | #3 | GuardPosMsg | yes | `param1` child id, `param2` grid position (0..13) |
| `skills` | #4 | STRING | | unlocked boss skills (comma list of skill ids from `activeSkill`) |
| `wantedOrder` | #5 | INT32 | | own rank |
| `maxBossId` | #6 | INT32 | | progress (highest boss template beaten) |

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Bosses per day | 8 slots; daily reset at 0h; complete once per day, retry on failure (help text) | `childpve.helpContent` |
| Guardians | max 4 in the formation | help text, formation frame |
| Boss pool | `GuardPVETemp.xml` `GuardPVEBossInfo` (699): `id`, `grade`, `bossName`, `icon`, `soldier1..3` / `hero1..3` (unit template, grid position list), `minLimit`/`maxLimit` (progress window for selection), `random`, `dropItems`, `activeSkill` | `TempleteManager.childPveBossTemplateCate` (`decompiled/core_module/scripts/yishi/manager/TempleteManager.as:1210`) |
| Skill unlock | beating a boss unlocks its `activeSkill` for guardian battles | help text item 4 |
| Battle | battleType 3845, guardian units only (`isFollowChild = false`) | `docs/battle/rules.md` |

## 6. Templates

`GuardPVETemp.xml` (`GuardPVEBossInfo`), skill templates for `activeSkill` (40201001..40201010).

## 7. Persistent state

```sql
CREATE TABLE guardians.pve_days (
  player_id     BIGINT   NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  day           DATE     NOT NULL,
  boss_ids      INTEGER[] NOT NULL,
  beaten        BOOLEAN[] NOT NULL,
  PRIMARY KEY (player_id, day)
);

CREATE TABLE guardians.pve_progress (
  player_id        BIGINT  PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
  max_boss_id      INTEGER NOT NULL DEFAULT 0,
  unlocked_skills  INTEGER[] NOT NULL DEFAULT '{}'
);
```

Formation rows: `guardians.formations` mode `pve` (`formation.md`). Daily ranking: generate `guardpverank.xml` at 0h from `max_boss_id` and fight power.

## 8. Backend implementation notes

| opType | Handler |
|---|---|
| 1 | `guardians::pve::handle_info` |
| 2 | `guardians::pve::handle_formation` |
| 3 | `guardians::pve::handle_challenge` |

- Daily roll: pick 8 bosses whose `[minLimit, maxLimit]` window contains `max_boss_id` *(assumption)*.
- Challenge: slot not beaten, formation not empty, guardians not busy in patrol; build battle 3845 (left: formation guardians; right: boss units from `soldierN`/`heroN`); on win mark beaten, update `max_boss_id`, unlock `activeSkill`, grant `dropItems`, push 4979 `opType` 2 and 115.
- Static file job: write `{TPL}guardpverank.xml` daily.

## 9. Open questions and assumptions

- *(assumption)* Boss selection rule and drop handling.
- 4979 missing from `protocol/opcodes.csv`.

## 10. Implementation checklist

- [ ] 9548 opTypes 1..3, push 4979.
- [ ] Tables `guardians.pve_days`, `guardians.pve_progress`.
- [ ] Battle 3845 setup.
- [ ] Daily ranking XML.
- [ ] Tests: challenge of a beaten boss rejected; formation with 5 guardians rejected; win updates `maxBossId` and skills.
