# Mount kings ("Treino do Deus da Fera", "Montaria Nv. Rei")

Scope: the four king mounts (MountType 4), their activation item, the king level trained with Pedra Bestial or diamonds, the per-level attribute growth and the extra percentage (`extra_star`). Activation itself goes through op 4 of [avatars-and-wild-souls.md](avatars-and-wild-souls.md).

Path aliases (all under `decompiled/`):

| Alias | File |
|---|---|
| MM | `core_module/scripts/managers/MountsManager.as` |
| WSC | `core_module/scripts/mvc/module/mounts/WildSoulCollection.as` |
| MKI | `core_module/scripts/mvc/module/mounts/MountKingInfo.as` |
| WSF | `m14/scripts/mounts/WildSoulFrame.as` |
| WSIT | `m14/scripts/mounts/WildSoulItem.as` |
| MKTV | `m14/scripts/mounts/MountKingTrainView.as` |
| MTIP | `m16/scripts/yishi/view/tips/MountTip.as` |

## 1. Overview

King mounts (`raw/xml/tempinfos/MountTempInfos.xml`, MountType 4, `StarAddition` "0", no stars):

| TemplateId | Name | Area | IsFly | Base attrs | ExpandLevel | SoulScore |
|---|---|---|---|---|---|---|
| 9001 | Nirvana Dourada | 1 | 1 | 100 each | 10 | 500 |
| 9002 | Rainha Miau | 2 | 0 | 100 each | 10 | 500 |
| 9003 | Tigre de Dentes Prata | 3 | 0 | 100 each | 10 | 500 |
| 9004 | X- Dragão Voador | 4 | 1 | 100 each | 10 | 500 |

They are visible only to lords of grade >= 70 (`WSC:489-499`). Each is activated with one "Despertamento da Fera" (2131500, "Despertamento da Fera distante, através desta missão poderá ativar a Montaria Nv. Rei na interface das Feras", config `mount_king_active_item` "2131500,1"). Once owned, the king has its own level (0..180) trained like the mount attributes; each level adds 5 to each attribute, and `extra_star` adds a percentage of the result.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `mounts.MountKingTrainView` (`MKTV`), embedded in WildSoulFrame | "Treino do Deus da Fera" (`wildSoulFrame.mountKingTrainView.titleText`, `WSF:748`) | Train a king | King train button `mounts.kingTrainBtn` on a MountType 4 cell (`WSIT:295-300`; enabled when owned, `WSIT:521-537`) -> `WSF.__showKingTrainView` / `showKingTrainView` (`WSF:495-504, 710-752`) | Name and avatar; "Nv.{grade}" and "Nv.{grade+1}" (`MKTV:334-349`); four rows "Básico" value and "Adicionar ({extra_star}%)" value, current and next (`MKTV:350-421`); EXP bar "{gp}/{Data(grade+1)}" or "MAX" with the train button disabled at max (`MKTV:338-348`); owned Pedra Bestial "x {n}" (`MKTV:330-331`); train count input 1..9999; return button |
| `mounts.MountKingTrainItemView` | row | One attribute row | MKTV | values only |
| `MountTip` for kings | tooltip | "Nv.{grade}" and attributes with the king formula | hover a king cell (`MTIP:150-163`) | |

## 3. Routes (client to server)

### K1. Activate a king mount
Op 4 of 8529 with `param1` = 9001..9004; the client offers it only when 2131500 is in the bag (kings have `Property1` 0). See [avatars-and-wild-souls.md](avatars-and-wild-souls.md#a2-activate-a-locked-appearance-op-4-mountavatar_active). Server extra effects: create the king row (level 0, gp 0, extra_star 0, assumption) and push 4973.

### K2. Train a king (op 7, `MOUNTKING_EDIT`)
- UI: train button (`MKTV:227-242`).
- Client checks: 400 ms throttle; confirmation "Deseja consumir {0} diamantes para adestrar {1} vez(es)?\n (Uso prioritário de pedras bestiais)" (`mounts.normaltip`, {0} = `count * Mount_Point`) through `SharedManagerHelper.needAlert` with key `mounts.MountKingTrainView.trainAlert`; the callback flag selects bound diamonds (`MKTV:244-268`); affordable when the bag has any 208017 or the balance (`allPoint` with the flag, `point` without) >= cost; else recharge alert. No discount is applied here.
- Request: 8529 (0x2151) `C_MOUNT_OP`, `MountEditMsg`: `op` (#5) = 7, `property_type` (#1) = 0, `pay_type` (#2) = 0 with bound diamonds allowed or 1 real only, `param1` (#3) = king template id, `param2` (#4) = train count (1..9999).
- Response: 4974 `MountKingInfoMsg` for that king; 4426 when the mount totals change (assumption: kings feed the totals); 115 for consumed 208017; 3 for diamonds.

## 4. Server messages (server to client)

### S1. 4973 (0x136d) `U_C_MOUNT_KING_LIST`, `MountKingListMsg` (package `campaign`)
Receiver `MM.__onMountKingListUpdate` (`MM:228-245`): clears the king dictionary, rebuilds it and dispatches `mountListChange`.

| Field | Tag, type | Meaning |
|---|---|---|
| `kingList` | #1, `MountKingInfoMsg`, repeated | every owned king |

The client never requests it: the server must push it at login (assumption: right after 4426) and after a king activation.

### S2. 4974 (0x136e) `U_C_MOUNT_KING`, `MountKingInfoMsg` (package `campaign`)
Receiver `MM.__onMountKingInfoUpdate` (`MM:247-262`): updates an existing king only (unknown template is ignored, so 4973 must come first) and dispatches `mountKingInfoChange` (`WSC:400-403`) which refreshes MKTV (`MKTV:193-225`).

| Field | Tag, type | Meaning | Client field |
|---|---|---|---|
| `template_id` | #1, INT32 | king template | `MKI.templateId` |
| `extra_star` | #2, INT32 | extra percentage on the king attributes | `MKI.extraStar` |
| `level` | #3, INT32 | king level 0..180 | `MKI.grade` |
| `gp` | #4, INT32 | EXP inside the current level | `MKI.exp` |

### Current server behavior
No rule sends 4973/4974 or answers op 7; the fixed 4427 has no king, so kings appear locked (and only to lords >= 70).

## 5. Rules and formulas

Level curve (`raw/xml/tempinfos/UpGradeTempInfos.xml` Types 109, 181 rows, `WSC:559-570`): EXP needed to go from level g to g+1 = `Data` of row g+1 = `min(500 * (g + 1), 10000)` (500, 1000, ..., 10000 from level 20 on). The bar shows `gp / Data(grade+1)` so `gp` is per level and resets on level up (`MKTV:322-339`). Max level 180 (no row 181; train disabled). Total EXP 0 -> 180: 1705000.

Attributes of a king at level g (`MKTV:350-421`, `MTIP:150-163`, config `mount_king_level_add_property` "5,5,5,5" in order Força, Inteligência, Físico, Proteção):
- `base = template attr + g * 5` (Power, Intellect, Physique, Agility).
- `extra = base * extra_star * 0.01` (`MM.MOUNTKING_ADDPRECENT` = 0.01, `MM:45`).
- King contribution to the mount totals = `base + extra` per attribute (assumption; the view labels them "Básico" and "Adicionar ({n}%)").

`extra_star`: source not visible in the client (assumption: a separate progression, for example the star levels of the normal avatars of the same `Area`, or a fixed bonus per king; propose a config map `king_template -> extra_star` until confirmed).

Training: cost per train = 1 Pedra Bestial (208017) first, else `Mount_Point` (5) diamonds (`mounts.tips02`, `MKTV:188`); EXP per train as the core training (assumption, see [mount-core.md](mount-core.md#5-rules-and-formulas)); stop at level 180 and refund unused trains (assumption).

Eligibility: king owned and valid; lord grade >= 70.

## 6. Templates

| File | Records and fields used |
|---|---|
| `raw/xml/tempinfos/MountTempInfos.xml` | MountType 4 rows 9001..9004 |
| `raw/xml/tempinfos/UpGradeTempInfos.xml` Types 109 | king level EXP (`Grades`, `Data`) |
| `raw/xml/tempinfos/ConfigInfos.xml` | `mount_king_level_add_property` = "5,5,5,5"; `mount_king_active_item` = "2131500,1"; `Mount_Point` = 5 |
| `raw/xml/tempinfos/ItemTempInfos.xml` | 2131500 "Despertamento da Fera" (SonType 210); 208017 "Pedra Bestial" |

## 7. Persistent state

```sql
CREATE TABLE mounts.king_mount (
  player_id     BIGINT      NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  template_id   INTEGER     NOT NULL CHECK (template_id BETWEEN 9001 AND 9004),
  level         SMALLINT    NOT NULL DEFAULT 0 CHECK (level BETWEEN 0 AND 180),
  gp            INTEGER     NOT NULL DEFAULT 0 CHECK (gp >= 0),
  extra_star    SMALLINT    NOT NULL DEFAULT 0 CHECK (extra_star >= 0),
  activated_at  TIMESTAMPTZ NOT NULL DEFAULT now(),
  PRIMARY KEY (player_id, template_id),
  FOREIGN KEY (player_id, template_id) REFERENCES mounts.avatar(player_id, template_id) ON DELETE CASCADE
);
```

The ownership row also exists in `mounts.avatar` (source 4). Training spend is logged in:

```sql
CREATE TABLE mounts.king_train_log (
  log_id            BIGSERIAL   PRIMARY KEY,
  player_id         BIGINT      NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  template_id       INTEGER     NOT NULL,
  train_count       INTEGER     NOT NULL CHECK (train_count BETWEEN 1 AND 9999),
  stones_used       INTEGER     NOT NULL DEFAULT 0,
  point_spent       INTEGER     NOT NULL DEFAULT 0,
  gift_token_spent  INTEGER     NOT NULL DEFAULT 0,
  gp_gained         BIGINT      NOT NULL DEFAULT 0,
  level_after       SMALLINT    NOT NULL,
  created_at        TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX king_train_log_player_time ON mounts.king_train_log (player_id, created_at);
```

## 8. Backend implementation notes

Handlers:
- `mounts::king::handle_king_train` (8529 op 7).
- `mounts::king::push_king_list` (4973; called at login and after activation).
- Activation hook from `mounts::avatars::handle_activate` for MountType 4.

Validation order for op 7: lord grade >= 70 -> `param1` is an owned king -> `1 <= param2 <= 9999` -> `pay_type` in {0,1} -> level < 180 -> resources cover one train.

Transaction: lock the king row; consume stones then diamonds per train; add EXP, loop level ups while `gp >= Data(level+1)` and level < 180; commit. Pushes: 4974, 4426 (totals), 115, 3. Recompute fighting capacity.

## 9. Open questions and assumptions

- Source and range of `extra_star` (no client logic sets it).
- Whether king attributes feed `MountInfoMsg` totals (assumption: yes).
- EXP per king train and crit chance (assumption: same as core training).
- Login order 4426 -> 4973 (assumption; 4974 for unknown kings is dropped by the client).

## 10. Implementation checklist

- [ ] Screen `mounts.MountKingTrainView` driven by 4973/4974
- [ ] Route op 7 king train
- [ ] Activation hook (op 4 with 2131500) creating `king_mount`
- [ ] Server message 4973 at login and after activation
- [ ] Server message 4974 after training
- [ ] Table `mounts.king_mount`
- [ ] Table `mounts.king_train_log`
- [ ] Rule: Types 109 level curve, cap 180
- [ ] Rule: attributes `base + g*5`, `extra = base * extra_star%`
- [ ] Rule: lord grade 70 gate
- [ ] Test: 1 train at level 0 with enough EXP reaches level 1 (needs 500)
- [ ] Test: training at level 180 rejected
