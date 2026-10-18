# Animation sequences (Legend Online BR)

This document lists every client animation sequence (map avatars, battle units, skill frame scripts, UI timelines and mounts), the rules that drive it and the database table that stores it (`db/`, see [../../db/README.md](../../db/README.md)). It complements [graphics.md](graphics.md) §1 to §3 (resource formats) and [../battle/README.md](../battle/README.md) §3 (attack pipeline).

**Conventions:** **CM** = `decompiled/core_module/scripts`, **M3** = `decompiled/m3/scripts`; `file:line` is relative to those roots.

## Sequence index

| sequence | context | table/view |
|---|---|---|
| map avatar direction (angle → frame row + mirror) | map/city | `game.avatar_direction_map` |
| map avatar frames (`S_<x>_<y>`, `W_<x>_<y>`) | map/city | `game.avatar_frame_sequences` |
| layer order per direction (z-order) | map/city | `game.avatar_layer_z_orders`, `game.avatar_part_draw_orders` |
| hero part stack in battle | battle | `game.battle_movie_parts` |
| battle labels and transitions | battle | `game.animation_labels`, `game.battle_label_transitions` |
| per-skill frame script | battle | `game.action_frames`, view `game.v_action_timelines`, `game.action_frame_types` |
| visual effects fired by frames/buffs | battle | `game.visual_effects`, `game.action_frame_effects` |
| UI MovieClip timelines | UI | `client.swf_symbols`, `client.swf_frame_labels` |
| mount animations | map (+ battle for the dragon) | `game.mount_animations`, view `game.v_mounts` |

## 1. Map avatar (`.bswf`)

### Direction

`HeroAvatar.set angle` (`M3/avatar/view/HeroAvatar.as:89-205`) maps the movement angle (screen degrees: 90 = down, 270 = up, 0 = right) to `frameY` (0 down, 1 down diagonal, 2 side, 3 up diagonal, 4 up) and a mirror (`scaleX = ±1`).

On foot (`is_stand_pos_mount=false`):

| angle | frameY | mirror |
|---|---:|---:|
| 80-90 | 0 | 1 |
| 90-100 | 0 | −1 |
| 10-80 | 1 | 1 |
| 100-170 | 1 | −1 |
| 350-10 | 2 | 1 |
| 170-190 | 2 | −1 |
| 280-350 | 3 | 1 |
| 190-260 | 3 | −1 |
| 270-280 | 4 | 1 |
| 260-270 | 4 | −1 |

Mounted in standing pose uses another table with narrow diagonals (lines 103-151; all rows are in `game.avatar_direction_map`).

### Frames

| state | class | layout | advance |
|---|---|---|---|
| Walk | `asset.<folder>_<file>.W_<frameX>_<frameY>` | 5 directions × 6 frames by default (`.bswf` header tag 6 `curTotalFrameX` can change it) | `nextFrameX` advances 1 per tick and wraps to 0 (`HeroAvatar.as:675-700`) |
| Stand | `S_<frameX>_<frameY>` | 3 rows × 5 frames; `getFrameY` reduces 5 directions to 3 (0/1 → 0, 2/3 → 1, 4 → 2) | mounted standing: Stand advances 1 frame every `_standWalkDValue` Walk ticks |

The map avatar has only these two states (`drawAttack`/`drawJump` are empty, `HeroAvatar.as:430-438`).

### Layer order

- Weight per layer, action and direction comes from `CM/avatar/data/AvatarStaticData.as` (normal and `_MOUNT` tables). The sort is **descending**: the higher weight is drawn first (behind).
- Example, Walk on foot, direction 0: cloak/wing 40 → hairDown 30 → army 20 → body 10 → hairUp 0 → pet −10.
- Per-frame composition: `dest = sizeMax[part] − sizeMax[avatar] + cell.{x,y} (+ mount offsetY)` (`HeroAvatar.as:525-526`).

## 2. Battle

### Part stack

`HeroMovieClip.as:112-121`, back to front: `cloak2, mount, arms2, hair4, hair3, body, hair2, arms, hair1, cloak1`. All parts receive the same label and play in sync.

### Labels and transitions

Source: `CM/yishi/view/tools/ActionMovie.as:163-266`.

| label | repeat | then |
|---|---|---|
| `Stand`, `Walk`, `Ready` | loop | (none) |
| attack (`Attack01..04`, from `ActionInfos.Para[0]`) | once | `Stand` |
| `Danny` (took damage) | once | `Stand` |
| `Die` | once | crush/cut/freeze particles |
| `Victory`, `Failed` | stop on last frame | (none) |

Typical attack turn:

1. `Stand → Walk` (frame type 0, advance).
2. `→ AttackNN` (type 1).
3. Effects and damage (types 2/3/11/12) hit the target, which plays `Danny → Stand`.
4. `→ Walk` (type 100, return) `→ Stand`.
5. At battle end: `Victory`/`Failed`.

Attack label usage in the data: Attack01 271 frames, Attack02 181, Victory 105, Attack03 26, Walk 14, Stand 5, Attack04 1.

### Skill frame script

Each `ActionId` has an ordered event list (`ActionInfos`): frame, type and params.

| type | event |
|---:|---|
| 0 | advance |
| 1 | label |
| 2 | effect |
| 3 | damage |
| 4 | zoom |
| 5 | gas |
| 6 | background color |
| 7 | shake |
| 11/12 | projectile |
| 23/24 | displacement |
| 25 | hide |
| 99 | end |
| 100 | return |

Example, hunter skill 20 "Ataque Normal":

| step | frame | type | params |
|---:|---:|---|---|
| 1 | 0 | 1 play_attack_action | `Attack01` |
| 2 | 11 | 2 add_release_effect | effect `hunter.skill09`, anchor 1, front layer |
| 3 | 11 | 12 shoot_beam | beam `hunter.laser001` from (0,−80), width 580, impact `flying.hit1` |
| 4 | 21 | 99 finish | (none) |

`SELECT * FROM game.v_action_timelines WHERE action_id = ...` returns this list with named params (`named_params`).

## 3. UI

| table | content |
|---|---|
| `client.swf_symbols` | the 37 723 characters of the 320 parsed UI SWFs in `web/public/lib/<swf>/library.json` (1 876 sprites with more than one frame; `place_ops` measures timeline complexity) |
| `client.swf_frame_labels` | the 120 labels in order (e.g. `battle` char 670: `qte` → `loop`; `artifact` char 29: `c0..c10`) |
| `client.symbol_linkages` | global class name → SWF index (17 875) |

## 4. Mounts

- Each mount has map `stand`/`walk` sequences for the body and, if `AvatarPath = "body|wing"`, for the wing (`game.mount_animations`, classes `asset.<folder>_2.S_*`/`W_*`).
- Only the Dragon Tamer's dragon mount appears in battle (`mount` part of the stack, battle labels).
- Details: [../mechanics/README.md#mount](../mechanics/README.md#mount). In the HTML5 rebuild, riding and dismounting go through opcode **8529** `MountEditMsg` (rules in `server/flows.json`).
