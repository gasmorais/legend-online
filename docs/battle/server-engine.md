# Battle server engine (mock server)

This document describes the authoritative battle simulation of the local mock server: how a battle is created from a
flow rule, how the engine schedules unit actions in real time, picks skills and targets, computes damage, SP and
cooldowns, answers skill requests, and ends the battle. It covers only the server side. The client behavior the engine
relies on (packet queue, synchronization, skill playback) is documented in [README.md](README.md) and
[rules.md](rules.md).

**Sources** (`file:line` refer to these files):

| file | role |
|---|---|
| `server/src/battle.rs` | engine: templates, `Battle` state, scheduling, damage, packets, `run` task |
| `server/src/game.rs` | `Session`: runs the `battle` object of a flow rule (113-123), routes battle opcodes to the engine (`Session::battle_packet`, 135-165), aborts on disconnect (`Session::close`, 127-133) |
| `server/src/main.rs` | spawns `battle::run` once the client reports it has loaded (171-172), calls `Session::close` on socket close (178), `/debug/{name}` route (205-212, 248), template preload at startup (254) |
| `server/flows/battle.json` | the three battle rules and the fallback rules for battle opcodes (§9.1) |

## 1. Lifecycle

| step | trigger | server sends |
|---|---|---|
| create | a flow rule with a `battle` object runs: `push:battle`, `push:campaign_battle` or opcode 8253 (§9.1) | 64 `HeroFastKeyMsg` (skill bar, see §9.4), then 157 `BattlePrepareMsg` |
| start | client sends 10007 `U_B_USER_LOADOVER` (or 10018) | 156 `BattleStartMsg {frame 0, mainType = battle_type, count_down}` |
| fight | the battle task ticks every 40 ms (25 fps) | 153 `AttackOrderMsg` per action, in real time |
| skill | client sends 10008 `UseSkillMsg` | 75 `HeroOrderMsg` at once, then 153 when the hero is free |
| auto | client sends 10020 `AttackModeMsg` (`mode` 1 = on, any other value = off) | nothing |
| end | one side has no living unit, or `count_down` expires | 154 `PrepareOverMsg`, then 4103 `BattleReportMsg` 50 frames later |

Routing rules (`game.rs:135-165`):

- 10007 and 10018 go to the engine only while the battle is pending (created, not started, not aborted). The engine
  marks it started and `main.rs` spawns `battle::run`, which sends 156 at once.
- 10008 and 10020 go to the engine only while the battle is active (started, not aborted, not finished).
- In every other case the flow rules for these opcodes run as before (§9.1).
- A new `battle` rule aborts the previous battle, and a socket disconnect aborts the running one.
- 159 `U_B_GAME_OVER` is never sent: the client has no handler for it.

The `run` task (`battle.rs:945-965`) ticks with `MissedTickBehavior::Skip`, but `advance` simulates every frame up to
the current one, so a late tick never skips game frames. The task stops when the battle is aborted, the report is sent,
or the socket channel closes.

## 2. Clock

- Frame 0 is the moment 156 is sent. Server frame = elapsed ms / 40 (`FRAME_MS = 40`, `FPS = 25`).
- Every 153 is sent at its own frame `f`, with `frame = exec_frame = f` and header `extend2 = f`. The client queue
  releases it when its clock reaches `f`, so `processSynchronization` sees a `diff` close to 0.
- 154 carries `frame = f` of the moment it is sent, also with `extend2 = f`. It bypasses the client queue, and the
  Victory skill starts at that frame.
- All other packets (64, 157, 156, 75, 4103) have `extend2 = 0`.

## 3. Units and scheduling

### 3.1 Templates

Unit and skill data come from the rule config (§9.2, §9.3). Missing values fall back to templates loaded once from
`raw/xml/tempinfos/` (`battle.rs:93-190`; `battle::preload` loads them in a background thread at server start). For each
id the first XML entry wins, and CSV lists drop zeros.

| file | fields used |
|---|---|
| `SkillTempInfos.xml` | TemplateId, TemplateName, UseWay, AcceptObject, ActionId, Cost, Parameter1, CoolDown, SonType, Description |
| `ActionInfos.xml` | ActionId, ActionType, Sex, Frame (hits, duration and melee flag per action, §3.3, §5) |
| `GameHeroTemp.xml` | TemplateName, Job (3 = magic), DefaultSkill, AI, SkillScript, Live, Attack, Defence, MagicAttack, MagicDefence, ForceHit, Parry, ResPath |
| `PawnTempInfos.xml` | PawnName, DefaultSkill, AI, Live, Attack, Defence, MagicAttack, MagicDefence, ForceHit, Parry, AttackType (2 = magic), Swf |
| `HeroAis.xml` | ID, Skills (AI skill cycle) |

`PawnTempInfos.Live` is loaded but not used: soldier HP comes only from the config (§9.3).

### 3.2 Grid

- `col = (pos - 1) % 3` (0 = front), `row = (pos - 1) / 3`.
- Same 3×4 grid as the client; see [formation.md](formation.md) §1-§2.

### 3.3 Action timing

1. **First action:** `start_delay` (default 25) + 7 frames per unit, with units ordered by column, row, side.
2. **Duration:** `max(Frame of the ActionType 99 row, 10)`, plus 16 frames when the action has an ActionType 0 row
   (melee walk forward and back), plus 4. An unknown ActionId counts as 30 frames, 1 hit, not melee (34 frames in
   total). The unit is busy until `f + duration`.
3. **Next automatic action:** `busy_until + interval` (heroes 20, soldiers 30; overridable per unit with `interval`).
4. **Requested skill (10008):** runs on the first frame where the hero is not busy, even before its next automatic
   action.
5. **Order within a frame** (`battle.rs:595-629`): a living unit is a candidate when it has a pending request and is
   not busy, or when its next action is due. Candidates act one by one: pending requests first, then the lowest
   `next_act`, then the lowest `living_id`. Several units may act on the same frame; the client still releases at most
   one packet per frame.
6. After each action the engine checks for a winner (§8).

### 3.4 Skill choice

`Battle::choose` (`battle.rs:663-692`). A pending request is consumed first and used if it is still usable; otherwise:

| unit | choice |
|---|---|
| player hero, manual | `DefaultSkill` |
| player hero, auto (10020 mode 1, or `auto` config, which defaults to on for battle_type 16/35/307) | first usable skill with UseWay 1 from its `skills` list, sorted by Cost ascending (so the largest SP spenders, with the most negative Cost, come first), else `DefaultSkill` |
| other heroes with type ≠ 3 | same as auto |
| boss (hero type 3) and soldiers | next usable skill of the `ai` cycle (`HeroAis.Skills`; round robin from the last pick), else `DefaultSkill` |

Usable = the template exists, the cooldown has expired and, for heroes, `sp + Cost >= 0`. `DefaultSkill` is used
without this check. A skill id with no template runs as AcceptObject 6, Parameter1 100, Cost 0, no cooldown.

## 4. Targets (`AcceptObject`)

`Battle::select` (`battle.rs:714-767`). The pool is every living enemy. Random picks are returned sorted by `pos`.

| AcceptObject | targets |
|---|---|
| 4, 18, 24, 26, 27 | self (no damage) |
| 3 | all living enemies |
| 5 | the enemy with the lowest HP ratio |
| 6 and any other value | one enemy in the front-most living column, in the row nearest the attacker (tie: lower row) |
| 7 | one enemy in the back-most living column, nearest row |
| 8 / 9 | all enemies in the front-most / back-most living column |
| 10 / 14 | all enemies in the row / column of one random enemy |
| 15 | one random enemy plus the enemies orthogonally adjacent to it |
| 1, 17, 25 | one random enemy |
| 2, 12 | two random enemies |
| 16, 21 | 2 to 4 random enemies |
| 19 / 20 | 1 to 2 / 2 to 3 random enemies |

## 5. Damage formula

`Battle::hit` and `Battle::act` (`battle.rs:769-865`). For each target of a skill with `Parameter1 > 0` and a
non-self AcceptObject (integer arithmetic throughout):

```
magic   = attacker is magic, or the skill Description contains "mágic" or "magia" (lowercased)
atk     = max(1, magic ? mag_attack : phy_attack)
def     = max(0, magic ? target.mag_defence : target.phy_defence)
damage  = (atk * Parameter1 / 100) * atk / (atk + def)
damage  = damage * random(95..105) / 100
crit    : chance = min(50%, force_hit / (force_hit + 200)), damage * 3 / 2, extra_data bit 1
parry   : chance = min(30%, target.parry / (target.parry + 200)), damage / 2, parry = true
damage  = max(damage, 1, hits)
```

- Crit and parry are rolled once per target and apply to all of that target's hits.
- `hits` = number of ActionType 3 rows with `Sex ≠ 1`. When there are none, it is the number of ActionType 11/12 rows
  (projectiles) with `Sex ≠ 0`. Minimum 1.
- The total is split evenly over the hits; the last hit takes the remainder.
- `damages` is grouped by target (all hits of target 0, then target 1), as `BattleFunctionHelper.dataFormatConversion`
  expects. Each entry has `living_id`, `damage_type 6` (HP), `damage_value`, `left_value` (HP after that hit, floored
  at 0), `extra_data` (1 on crit) and `parry`.
- A target at 0 HP is dead: it stops acting and is no longer targeted. The client plays the death from `left_value 0`.
- Skills without damage (`Parameter1 = 0`, or self targets) send an empty `damages` list. Buffs are not simulated.
- Randomness uses a xorshift64 generator seeded from `seed` (default: current time in ms).

### 5.1 `AttackOrderMsg` (153)

| field | value |
|---|---|
| `battle_id` | battle id |
| `frame`, `exec_frame` | action frame `f` (also header `extend2`) |
| `order_id` | skill id |
| `is_passive` | `false` |
| `living_id` | acting unit |
| `sp`, `sp_added` | SP after the action and the change (§6) |
| `damages` | per-hit entries (§5) |
| `attackOrderSeq` | sequence number, starting at 1 |

## 6. SP and cooldowns

- SP applies to heroes only. `Cost` is added to SP on every action (positive Cost gains SP, negative Cost spends it),
  clamped to `0..spMax` (default 100). Examples: `10000` +2, `10711` +15, `10811` -10.
- 153 carries `sp` (SP after the action) and `sp_added` (the change). The client applies `sp_added` and then corrects to
  `sp` (`BattleUtils.skillUpdateSp`).
- `CoolDown` (ms) starts at the action frame: the skill is ready again at `f + CoolDown / 40`. The client starts its own
  cooldown later (at skill completion), so the server cooldown always expires first.

## 7. Skill requests (10008 → 75)

`Battle::order` and `Battle::check_order` (`battle.rs:867-918`). The engine reads `hero_id` and `skill_id` from
`UseSkillMsg` and replies with
`HeroOrderMsg {battle_id, hero_index_id, skill_id, result, cast_time 0, qte_time 0, targetIndexs}`.

`result 0` requires all of the following; otherwise `result 1` (the client re-enables the bar after 1 s). The server log
prints the first failed check.

| check | log text on failure |
|---|---|
| the battle is active and still fighting (not ending) | `battle not running` |
| `hero_id` is the player hero | `not the player hero` |
| the hero exists | `unknown hero` |
| the hero is alive | `hero is dead` |
| no other request is pending | `another skill is pending` |
| the skill template exists | `unknown skill` |
| the skill is in the hero `skills` list with UseWay 1 | `skill not on the hero bar` |
| `sp + Cost >= 0` | `not enough sp` |
| the cooldown has expired | `cooldown` |

On acceptance the skill becomes the hero's pending request (§3.3 step 4). `targetIndexs` holds targets predicted with
the same rules as §4 at request time; for random target kinds the 153 that follows may hit different units.

## 8. End

- **Last unit killed:** if the enemy side has no living unit the player side wins; if the player side has none the enemy
  wins. 154 is sent at `f + duration of the last action + 25`.
- **Time limit:** at frame `count_down × 25` (when `count_down > 0`), the side with the higher total HP ratio
  (sum of HP / sum of max HP, dead units included) wins; a tie goes to the enemy side. 154 is sent 25 frames later.
- **154 `prepareOverLivings`:** one entry `{calc_type, living_id, sp}` per living hero, `calc_type 3` (Victory) on the
  winning side and `4` on the losing side. If no winning hero is alive, the living winning soldiers get `calc_type 3`.
- **4103** follows 50 frames after 154: `report` (player side won) or `report_defeat`, with `battle_result` set to 1
  (player side won) or 2. A non-object report becomes `{}`.

## 9. Configuration

### 9.1 Rules in `server/flows/battle.json`

Rules from `server/flows.json` and every `server/flows/*.json` are merged. `push:<name>` rules run on
`GET /debug/<name>`, which targets the most recently connected client.

| rule | `battle_id` | `battle_type` | `map` | units |
|---|---|---|---|---|
| `push:battle` | `B1` | 1 | 1 | player hero (temp 1, pos 2, 12000 HP, SP 50) vs boss "Rei Halazzi" (temp 31010, type 3, pos 2, 9000 HP, res `boss102`); two soldiers per side (temp 2006, pos 1 and 3, 800 HP) |
| `push:campaign_battle` | `P1` | 17 | 2 | same hero vs the boss at pos 5 (7000 HP); two own soldiers (pos 1/3, 800 HP), three enemy soldiers (pos 1/4/7, 700 HP) |
| 8253 (`ChallengeMsg`, arena) | `C1` | 16 | 3 | same hero vs "Arthur" (user 2, temp 2, type 1, pos 2, 9000 HP); no soldiers. battle_type 16 starts on auto |

All three use `count_down` 180 and define `report` / `report_defeat`:

| rule | `report` (victory) | `report_defeat` |
|---|---|---|
| `push:battle` | gp 350, gold 120, strategy 0, pet gp 40, item 2129006 ×1 | gp 20, gold 0 |
| `push:campaign_battle` | gp 500, gold 200, strategy 0, pet gp 50, item 2129006 ×2 | gp 30 |
| 8253 | gp 200, gold 100 | gp 20 |

The same file also holds:

- 8256 `ChallengeRequestMsg` → 4169 `ChallengeInfoMsg` (arena info with rivals Arthur, Lia and Borin);
- fallback rules used when the engine does not take the packet: 10007 (sends nothing), 10018 (sends 156
  `{frame 0, mainType 1, count_down 180}`), 10008 and 10020 (send nothing).

### 9.2 `battle` object

Values go through the usual `$player.*` and `$var.*` substitution.

| key | default | meaning |
|---|---|---|
| `battle_id` | `B1` | id in every message (string) |
| `battle_type` | 1 | 157 `battle_type` and 156 `mainType` |
| `map` (or `map_temp_id`) | 1 | 157 `map_temp_id` |
| `side` | 1 | player side |
| `count_down` | 180 | seconds, 0 = no limit |
| `heroes` (or `heros`) | | hero list (§9.3) |
| `soldiers` | | soldier list (§9.3) |
| `report` / `report_defeat` | `{}` | `BattleReportMsg` fields |
| `fast_key` | from the hero skills | string for opcode 64, or `false` to skip it (§9.4) |
| `auto` | true for 16/35/307 | player hero starts on auto |
| `prepare` | | extra 157 fields, merged over the defaults |
| `start_delay`, `interval_hero`, `interval_soldier` | 25, 20, 30 | scheduling (§3.3), minimum 1 |
| `seed` | current time (ms) | random seed |

157 always carries `need_animation false`, `has_assault true`, `use_way 0`, `attack_model 2`, `battle_capity 1`,
`battle_from 0`, `page 1`, `total_page 1` and `soldierTemplated` (distinct soldier `temp_id`s), unless `prepare`
overrides them.

### 9.3 Unit entries

Each entry holds message fields (`HeroMsg` / `SoldierMsg`) plus engine-only keys. Stats use the config value, else the
template value when it is > 0, else the default below.

| key | hero default | soldier default |
|---|---|---|
| `temp_id` | 1 | 2006 |
| `living_id` | index + 1 | 100 + index |
| `type` | 1 (3 = boss) | 1 |
| `side` | first hero: player side; others: opposite side | player side |
| `pos` | 2 | 1 |
| max HP | `max_hp`, else `hp`, else template `Live`, else 1000 | `init_hp`, else `hp`, else 800 |
| `hp` | max HP (clamped to it) | max HP (clamped to it) |
| `sp` / `spMax` | 0 / 100 | none |
| `phy_attack`, `phy_defence`, `mag_attack`, `mag_defence` | 300, 100, 300, 100 | 60, 10, 60, 10 |
| `force_hit`, `parry` | 0, 0 | 0, 0 |
| `user_id`, `nick_name` | 0, template name | none |
| `skills` (or `skill_script`) | template `SkillScript` (empty for type 3) | none |
| `ai` | `HeroAis` of the template `AI` | same |
| `default_skill` | template, else 10000 | template, else 10 |
| `interval` | `interval_hero` | `interval_soldier` |
| `magic` | template Job 3 | template AttackType 2 |

- Engine-only keys are removed from the outgoing messages: `skills`, `ai`, `default_skill`, `interval`, `magic`,
  `skill_script` and `spMax` (re-added for heroes).
- The engine fills `HeroMsg` with the resolved `living_id`, `temp_id`, `type`, `side`, `pos`, `nick_name`, `max_hp`,
  `hp`, `sp`, `spMax`, stats, `force_hit`, `parry` and `skillId`, and adds `hero_id`, `init_hp`, `grade` (1), `job`
  (template) and, for type 3, `res` (template ResPath) when they are missing.
- The engine fills `SoldierMsg` with `living_id`, `temp_id`, `type`, `side`, `pos`, `init_hp`, `hp`, the four stats and
  `skillId`, and adds `army_pawn_id` (= `living_id`) and `grade` (1) when missing.
- `skillId` lists the default skill, then the skills, then the AI skills, without duplicates, so the client preloads
  their resources.

### 9.4 Player hero and skill bar

- The player hero is the hero with type ≠ 3 on the player side whose `user_id` equals the player id; else the first hero
  of the player side.
- Opcode 64 `HeroFastKeyMsg {fast_key, set_result true}` sets `skillCate.fastKey`, which fills the skill bar slots
  through `SkillItemListController.getFastkey`. By default the string is built from the player hero's skills with
  UseWay 1 and SonType > 0: the first five SonTypes, padded with `-1` to five entries, with a trailing comma (for
  example `107,108,-1,-1,-1,`). When no skill qualifies, 64 is not sent.

## 10. Testing

`server/battletest.mjs` logs in, triggers a battle, sends 10007 and skill requests, decodes every reply and prints the
timeline:

```
cd server
node battletest.mjs                # GET /debug/battle
node battletest.mjs campaign_battle
node battletest.mjs 8253           # arena: sends opcode 8253 with an empty body
AUTO=1 node battletest.mjs         # auto fight, no manual skills
LG_PORT=8790 node battletest.mjs   # another server instance (LG_PORT also sets the server port)
```

| argument / variable | default | meaning |
|---|---|---|
| first argument | `battle` | rule name for `/debug/<name>`; a number is sent as an opcode with an empty body |
| `LG_PORT` | 8787 | server port |
| `AUTO` | off | `1` sends 10020 mode 1 after 156 and no manual skills |
| `SKILLS` | 6 | maximum number of manual skill requests |
| `PLAYER_ID` | 1 | `user_id` used to find the player hero |
| `TIMEOUT` | 240000 | ms before giving up (exit code 2) |
