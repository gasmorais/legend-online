# Abyss tower: floors, waves, bosses and battles

Feature `abyss`, module `abyss-tower`. Client: `M11/abysm/AbysmFrame.as`, `M11/abysm/HellAbysmFrame.as`, `M11/abysm/view/AbysmBossView.as`, `AbysmChildView.as`, `view/item/AbysmBossHeadItemView.as`, `view/item/AbysmChildItemHeadView.as`, `CM/yishi/manager/OutyardManager.as:96-97, 205-220, 356-386`, `CM/mvc/module/outyard/AbysmModel.as`. Conventions: see [README.md](README.md).

---

## 1. Overview

- Two variants share one model and one opcode: normal ("Abismo sem fim", `isHorrible = false`) and hell ("Abismo Sem Fim (Inferno)", `isHorrible = true`). The variant is a flag in every request.
- The frame shows: current floor number (`plies`), "Apareceu ao mesmo tempo {bossNum} Chefões", "Recorde máximo: {maxIndex - 1} pisos", six boss heads (a highlight marks bosses with state 1), four guardian heads (the fighting order, slots masked when sealed), a background switch when `guardSealNum > 0`, and the drop preview of the current wave (`GuardEndlessDrop` or `GuardEndlessHorribleDrop` rows with `site = index`).
- "Desafiar": when the current floor equals `maxIndex` (the player is at his frontier) the client sends op 3 and the server starts a guardian battle (3867 normal, 3889 hell) against the bosses of the current wave. Below the frontier the button opens the sweep prepare frame ([sweep.md](sweep.md)), which also offers a manual challenge (op 3).
- When the run is finished (`isFinishes`), the button is disabled and shows "Completado".
- Battles use only guardians (P-CHILD); the server announces which guardian is fighting with 427.

---

## 2. Screens

| Class (file) | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `abysm.AbysmFrame` (`M11/abysm/AbysmFrame.as`), 900x613, controller `abysm` openType 7 | "Abismo sem fim" (`ui.toptoolbar.TopToolsBar.tipData_abysm`, `:237-241`) | Normal tower | NPC option 130, daily guide 74, return from 3867 | `__updataInfo` (`:163-190`): floor sprite = `currentLayer`, "Apareceu ao mesmo tempo\n {bossNum} Chefões" (`abysm.abysmViewTips01`), record "Recorde máximo: {maxIndex-1} pisos" (`abysm.abysmViewTips02`), button disabled when `is_OverGame`, background by `sealNum`; drop preview "Visualização do drop" from `abysmDropTempCate.getTemplatesByWave(index)` (`:192-212`); magic spring buffer 18 (`:120-128`); buttons "Ajustar Formação" (`:214-217`) and "Desafiar" (`:219-235`) |
| `abysm.HellAbysmFrame` (`M11/abysm/HellAbysmFrame.as`), openType 11 | "Abismo Sem Fim (Inferno)" (`abysm.abysmView.mopupTip04`, `:223-227`) | Hell tower | NPC option 148 (no NPC in local data), return from 3889 | Same as above with `abysmHellDropTempCate` (`:178-198`), sweep openType 17 (`:205-221`), no buffer view |
| `abysm.view.AbysmBossView` / `AbysmBossHeadItemView` (`M11/abysm/view/AbysmBossView.as:41-69`, `item/AbysmBossHeadItemView.as:45-55`) | none | 6 boss heads on a ring | Frames | `GameHeroTemp(bossId).Icon`, tip `TemplateName`; effect when `state == 1` *(assumption: boss of the current wave)* |
| `abysm.view.AbysmChildView` / `AbysmChildItemHeadView` (`M11/abysm/view/AbysmChildView.as:21-49`, `item/AbysmChildItemHeadView.as:74-151`) | none | 4 guardian heads in fighting order | Frames | Guardian icon by job and growth grade; position frames 1..4; slots with index `>= 4 - sealNum` are greyed with a mask (sealed); drag and drop swaps the order, see [formation.md](formation.md) |

---

## 3. Routes (client to server)

Opcode **9644 (0x25ac) C_GUARDENDLESS_OP**, body `guardendless.GuardendlessOpMsg` built by `OutyardManager.abysmSendInfo` (`CM/yishi/manager/OutyardManager.as:356-386`), `sendMopup` (`:389-397`) and `sendMopupOP` (`:399-407`).

`GuardendlessOpMsg` fields (`CM/com/road/yishi/proto/guardendless/GuardendlessOpMsg.as`):

| Field | Tag | Type | Repeated | Request meaning | Response meaning |
|---|---|---|---|---|---|
| `opType` | #1 | INT32 | no | 1 info, 2 save formation, 3 challenge, 4 start sweep, 5 accelerate sweep, 6 stop sweep, 7 poll sweep | echoed *(assumption)*, not read |
| `bossInfo` | #2 | GuardEndlessBossMsg | yes | unused | boss heads |
| `guardPos` | #3 | GuardEndlessPosMsg | yes | formation (op 2) | formation |
| `bossNum` | #4 | INT32 | no | unused | bosses appearing at once |
| `index` | #5 | INT32 | no | current wave (op 3) | current wave index (1-based) |
| `plies` | #6 | INT32 | no | unused | current floor |
| `maxIndex` | #7 | INT32 | no | unused | highest floor the player may reach (record + 1) |
| `guardSealNum` | #8 | INT32 | no | unused | number of sealed guardian slots (0..3) |
| `items` | #9 | STRING | no | unused | stored as `goodsList`, not displayed |
| `sweepTime` | #10 | STRING | no | unused | not read |
| `sweepIndex` | #11 | INT32 | no | target floor + 1 (op 4) | sweep target (+1) while a sweep runs, 0 otherwise |
| `resetTime` | #12 | STRING | no | unused | not read |
| `payType` | #13 | INT32 | no | op 5 payment (see [sweep.md](sweep.md)) | not read |
| `isFinishes` | #14 | BOOL | no | unused | run finished |
| `isHorrible` | #15 | BOOL | no | always set: false normal, true hell | not read |

`GuardEndlessBossMsg`: `bossOrder (#1, INT32)` boss hero template id (`GameHeroTemp`); `bossState (#2, INT32)` 1 highlighted; `bossIndex (#3, INT32)` position 0..5.
`GuardEndlessPosMsg`: `param1 (#1, INT32)` guardian (child) id; `param2 (#2, INT32)` grid position (`attackPos`, one of 1,3,4,6,7,9,10,12); `param3 (#3, INT32)` fighting order (`pos`, 1 = fighting first).

| # | UI control | Client sender (file:line) | Client checks | Request | Expected response |
|---|---|---|---|---|---|
| A1 | Opening the normal frame | `AbysmFrame()` (`M11/abysm/AbysmFrame.as:68-75`) sets `isHorrible = false` → `abysmSendInfo(1)` | Entry checks (README) | `{opType=1, isHorrible=false}` | **423** full state |
| A2 | Opening the hell frame | `HellAbysmFrame()` (`M11/abysm/HellAbysmFrame.as:63-70`) sets `isHorrible = true` → `abysmSendInfo(1)` | same | `{opType=1, isHorrible=true}` | **423** |
| A3 | "Desafiar" at the frontier | `AbysmFrame.__onChangeClick` (`:219-235`), `HellAbysmFrame.__onChangeClick` (`:205-221`) | not finished (else tip "Completado"); `currentLayer == maxIndex` | `{opType=3, index, isHorrible}` (`OutyardManager.as:381-385`) | Battle 3867 or 3889 (64, 157 ... 4103); **427** at start and whenever the fighting guardian changes; **423** after the battle with the new wave and floor; reward pushes |
| A4 | "Desafiar" below the frontier | same handlers | `currentLayer != maxIndex` | none | opens `mopup` 7 or 17 ([sweep.md](sweep.md)) |
| A5 | Manual challenge from the sweep prepare frame | `AbysmMopupPrepareFrame.alertBack` (`M5/mopup/view/AbysmMopupPrepareFrame.as:159-169`), hell `HellAbysmMopupPrepareFrame` (`:167`) | confirmation "Deseja desafiar Checkpoint manualmente?" (can be muted for the day) | `{opType=3, index, isHorrible}` | as A3 |

---

## 4. Server messages (server to client)

| Opcode | Name | Message | Client receiver (file:line) | When | Client reaction |
|---|---|---|---|---|---|
| **423 (0x01a7)** | U_C_GUARDENDLESS_INFO | `GuardendlessOpMsg` (fields above) | `OutyardManager.__abysmHandler` (`CM/yishi/manager/OutyardManager.as:96, 205-211`) → `AbysmModel.abysmInfoHandler` (`CM/mvc/module/outyard/AbysmModel.as:69-119`) | Response to ops 1, 2, 3 (after the battle), 4, 5, 6, 7 | Replaces `bossNum`, `index`, `currentLayer`, `maxIndex`, `sealNum`, `is_OverGame`, `bossList`, `childList` (sorted by `pos`; the child with `pos == 1` becomes `abysmChildFightId`), `goodsList`; sets `mopupCount = sweepIndex` (a positive change opens the sweep progress frame, [sweep.md](sweep.md)); fires `ABYSM_INFO_UPDATA` |
| **427 (0x01ab)** | U_C_GUARD_ONFIGHT | `battle.GuardOnFightMsg`: `guardId (#1, INT32)` guardian now fighting | `OutyardManager.__abysmFightHandler` (`:97, 213-220`) | At battle start and when the fighting guardian dies and the next one enters | Sets `abysmChildFightId`, fires `ABYSM_FIGHT_INFO_UPDATA`: the battle child skill bar is rebuilt for that guardian (`CM/battle/view/ui/ChildCommonSkillItemListController.as:69, 80-`) |
| 157, 156, 153, 154, 4103 | battle | battle engine | | A3, A5 | battleType 3867 or 3889: P-CHILD (player controls the fighting guardian), P-NOHERO, P-75, P-BUFFICON, no top boss panel (`docs/battle/rules.md` rows 3867 and 3889); exit sets `isAbysmBattle` / `isHellAbysmBattle` and reopens the frame |

---

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Waves per floor | 7 *(derived: formation can change only when `index % 7 == 1`, "Apenas poderá alterar a formação durante a primeira rodada em cada piso")* | `M14/childabysm/ChildAbysmFormationHeadView.as:150-155` |
| Waves | Normal 224 (drop sites 1..224, so 32 floors), hell 210 (30 floors) *(derived from the drop tables)* | `GuardEndlessDrop.xml`, `GuardEndlessHorribleDrop.xml` |
| Frontier | Challenge only when `plies == maxIndex`; `maxIndex - 1` is the record shown | `AbysmFrame.as:166, 227-230` |
| Normal drops | Every wave: 1 "Roleta da Vida do Espírito de Proteção" (212009, fixed) + one random of the three guardian skill scrolls (2269000 active, 2269001 passive, 2269002 common, `appearType 4`) | `GuardEndlessDrop.xml` |
| Hell drops | Every wave: "Bola de Luz Elemental" (208201, fixed, 1 to 3 by wave), "Luz do Caos" (208202, fixed), "Poder Elemental" (208203, rare) | `GuardEndlessHorribleDrop.xml` |
| Guardians | Up to 4 guardians in fighting order; `guardSealNum` slots at the end of the order are sealed | `AbysmChildItemHeadView.as:108-151` |
| Bosses | Up to 6 per wave (`bossIndex` 0..5), `bossNum` at once *(boss data is server side; no client template)* | `AbysmBossView.as:41-69` |
| Retry after a lost battle | *(assumption)* Unlimited; the wave stays the same; guardian HP resets each battle |
| Reset | `resetTime` exists in the message (not read) *(assumption: weekly or daily reset of `plies` to 1 while `maxIndex` keeps the record)* | |

---

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `raw/xml/tempinfos/GuardEndlessDrop.xml` (896 rows), `AbysmDropTempCate` (`CM/yishi/datas/templates/cate/AbysmDropTempCate.as`, loaded `CM/yishi/manager/TempleteManager.as:1318`) | Normal wave drop | `id`, `dropId` 146xxxx, `site` = wave index, `para2` 0, `itemId`, `count`, `isBind` 1, `appearType` 1/4, `validDate`, `isShow` |
| `raw/xml/tempinfos/GuardEndlessHorribleDrop.xml` (630 rows), `AbysmHellDropTempCate` (`:1319`) | Hell wave drop | same, `dropId` 181xxxx, `appearType` 1/3 |
| `raw/xml/tempinfos/GameHeroTemp.xml` | Boss heroes (`bossOrder`) | `Icon`, `TemplateName`, stats |
| Child templates (guardians feature) | Guardian icon | `ChildTempInfo.Icon` by job and growth |

The boss composition per wave, `bossNum`, `guardSealNum` per floor and the reset rule are not in any client file: they must come from server data *(gap)*.

---

## 7. Persistent state (PostgreSQL, schema `abyss`)

```sql
CREATE SCHEMA IF NOT EXISTS abyss;

CREATE TABLE abyss.progress (
  player_id     BIGINT  NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  is_hell       boolean  NOT NULL,
  wave_index    integer  NOT NULL DEFAULT 1 CHECK (wave_index >= 1),
  floor         integer  NOT NULL DEFAULT 1 CHECK (floor >= 1),
  max_floor     integer  NOT NULL DEFAULT 1 CHECK (max_floor >= 1),   -- sent as maxIndex
  finished      boolean  NOT NULL DEFAULT false,
  last_reset_at timestamptz,
  updated_at    timestamptz NOT NULL DEFAULT now(),
  PRIMARY KEY (player_id, is_hell)
);

CREATE TABLE abyss.fight_log (
  fight_id    bigserial   PRIMARY KEY,
  player_id   BIGINT     NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  is_hell     boolean     NOT NULL,
  wave_index  integer     NOT NULL,
  won         boolean     NOT NULL,
  created_at  timestamptz NOT NULL DEFAULT now()
);
```

Formation is in [formation.md](formation.md) §7; sweep state in [sweep.md](sweep.md) §7.

---

## 8. Backend implementation notes

| Handler | Route | Validation order | Transaction and pushes |
|---|---|---|---|
| `abyss::abyss_tower::handle_info` | 9644 op 1 | job change, at least one guardian | Create the `progress` row if absent (and default formation from the player's guardians *(assumption)*). Send 423 with all fields of the current wave, the formation (`guardPos`), `sweepIndex` (0 unless a sweep runs) |
| `abyss::abyss_tower::handle_challenge` | 9644 op 3 | progress exists and not finished; `index` equals `wave_index` (stale clients get a fresh 423); `floor == max_floor`; no sweep running; formation has at least one unsealed guardian | Start battle 3867/3889 (below). On win: one tx: grant drops of `site = wave_index` (roll by `appearType`), `wave_index += 1`, `floor = ceil(wave_index / 7)` *(derived)*, `max_floor = max(max_floor, floor)` *(assumption: the record counts floors reached)*, `finished` when the last wave is cleared; log. After commit 423 and bag pushes. On loss: log, 423 unchanged |

Battle configuration (battleType 3867 normal, 3889 hell):
- Player side: the guardians of `guardPos` with `pos` order 1..(4 - seal), placed at their `attackPos` grid cells; the player controls the guardian with `pos == 1`; when it dies, the next one fights and the server pushes 427 with its id *(assumption on rotation)*. No hero.
- Enemy side: `bossNum` bosses of the wave (hero templates `bossOrder`) at their positions *(server data)*.
- Rewards are not given by the battle report; they are granted by the handler above.

---

## 9. Open questions and assumptions

- *(gap)* Boss lineup per wave, `bossNum`, seal count per floor and reset period are server data.
- *(assumption)* 7 waves per floor, floor = ceil(wave / 7).
- *(assumption)* `maxIndex` semantics (record + 1).
- *(assumption)* Hell variant entry: no NPC offers option 148 in the local data.
- `items`, `sweepTime`, `resetTime` of 423 are ignored by the client.

---

## 10. Implementation checklist

- [ ] Loaders of both drop tables; server data for boss waves and seals.
- [ ] Tables `abyss.progress`, `abyss.fight_log`.
- [ ] Route 9644 op 1 → 423 (both variants).
- [ ] Route 9644 op 3 → battle 3867/3889, 427 pushes, wave advance, drops, 423.
- [ ] Screen check: floor, bosses at once, record, boss heads, sealed slots, drop preview, finished state.
- [ ] Test: challenge below the frontier is refused.
- [ ] Test: win on wave 7 moves to floor 2 and raises the record.
