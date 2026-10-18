# Damage formulas, HP changes and damage escalation

Module `damage` of the feature [Motor de batalha](README.md). Path prefixes as in [lifecycle.md](lifecycle.md). Client detail: `docs/battle/rules.md` §2.3, §6, §12.10, §12.11 and `docs/battle/hud.md` §7.1; current mock formula: `docs/battle/server-engine.md` §5.

## 1. Overview

The client never computes damage. The server sends, per hit and per target, a `DamageMsg` with the value, the HP left, a crit flag, a parry flag and resistance data; the client pre-applies the totals to its HP model (`BloodHelper`), then shows each number when the DAMAGE frame of the animation fires. Damage numbers, heals, troop losses, SP, attack points and goddess belief all travel in the same structure, distinguished by `damage_type` (bloodType).

This module defines:

- the `DamageMsg` contract and the meaning of each bloodType;
- the server damage formula (attack, defense, skill percent, random spread, crit, parry, resistances, buffs);
- the PvP damage escalation ("Aumento de danos a todos em N%") pushed by 4361;
- world boss and shared boss HP rules that the battle must respect.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `battle.view.ui.DamageNumView` (CM) | none | floating number at the unit (0, -130); crit 50 px higher | each DAMAGE frame | `RedNumberAssetSp` (others' damage), `DamageNumberAssetSp` (own damage), `SelfCauseNumberAssetSp` (parry, scale 0.6), `GreenNumberAssetSp` (heal), `CriticalDamageNumAssetSp` (crit) |
| `battle.view.ui.ResistUIView` (M10) | none | total resistance percent of the last hit involving the own hero | `ResistModel` (`CM/yishi/datas/battle/ResistModel.as:48-74`) | `resi_percent` sum: positive = green "minus damage", negative = red "plus damage" |
| `battle.view.ui.HurtUpView` (M10) | "Aumento de danos a todos em N%" (`battle.hurtUpTip.text`); 35/307: "Todos os adversários receberam danos" | PvP countdown and escalation | only when `BattleModel.isPvP()` (`M10/battle/view/ui/BattleUIView.as:1329-1332`) | seconds left, cumulative percent |
| `battle.view.ui.RedScreenEffect` (M10) | none | red flash | crit on the own hero | none |

## 3. Routes (client to server)

None.

## 4. Server messages (server to client)

### 4.1 `battle.DamageMsg` (inside 153 `damages`, `BufferMsg.damage`)

| Field | Meaning and client use |
|---|---|
| `living_id (#1, INT32)` | target unit |
| `damage_type (#2, INT32)` | bloodType, see §5.1 |
| `has_icon (#3, BOOL)` | buff icon flag (initial buffs only) |
| `is_harmful (#4, BOOL)` | unused |
| `damage_value (#5, INT64)` | **positive = damage, negative = heal**; shown as its absolute value; also the displayed number (`displayBlood`) |
| `left_value (#6, INT64)` | target HP after this hit (server truth; the client uses it to detect death through its own model) |
| `extra_data (#7, INT32)` | bit 1 = critical (only bit read, `CM/battle/actions/DannyAction.as:140`) |
| `parry (#8, BOOL)` | parried hit (blue small number) |
| `dropInfos (#9, DropInfoMsg, repeated)` | trial item drops shown on the target: `drop_id (#1)`, `drop_count (#2)`, `winnerIds (#3, repeated)`, `param1 (#4)`, `param2 (#5)` |
| `order (#10, INT32)` | in buffs: hit index at which this value is shown |
| `hp_limit (#11, INT64)` | max HP change applied before the value (bloodType 21) |
| `resi_type (#12, INT32)` / `resi_value (#13, INT32)` | unused by the client |
| `resi_percent (#14, INT32)` | resistance percent; summed for the `ResistUIView` (only when the attacker or the target is the own hero) |
| `buffer_type (#15, INT32)` | unused |

Ordering inside one 153: all hits of target A, then all hits of target B (`BattleFunctionHelper.dataFormatConversion`, `CM/battle/utils/BattleFunctionHelper.as:226-249`); `hits = int(len / unique targets)`, a remainder is dropped. The client clips its own HP model so a lethal hit brings HP exactly to 0 (`CM/battle/skillsys/helper/BloodHelper.as:156-219`).

### 4.2 4361 (0x1109) U_B_BATTLE_NOTICE: damage escalation

`battle.BattleNoticeMsg`: `battle_id (#1, STRING)`; `count_down (#2, INT32)` ms until the next escalation; `damage_improve (#3, INT32)` percent added to the cumulative increase (child arena 3847: a skill id); `damage_addition (#4, INT32)` extra percent (child arena: improvement). Receiver `BattleNoticeTransaction` (`CM/battle/transaction/BattleNoticeTransaction.as:15-24`) -> `BattleModel.hurtUpStart` (`CM/yishi/datas/BattleModel.as:921-936`). Initial values come from 157 `count_down` / `damage_improve` and 156 `count_down`.

### 4.3 Shared boss HP (owned by the boss features)

The battle shows a shared boss HP that other players also reduce; these pushes are owned by the boss features but the battle engine must apply them to the boss unit: 4174 `U_C_SYNC_BOSS_HP`, 4462 `U_C_ARCANE_ZONE_BOSS_HP_SYNC`, 4727 `U_C_CONSORTIA_BOSS_SYNC_HP`, 4889 `U_C_CONSORTIA_PVE_BOSS_HP`, 4285 `U_C_CONSORTIA_NEWBOSS_HP`, 4297 `U_C_FORBIDDEN_BOSS_HP` (all `simple.WorldBossInfoMsg`, `cur_hp (#1, INT64)`, `total_hp (#5, INT64)`, `current_millis (#8, INT64)`, `boss_state (#12, INT32)`), 4435 `U_C_ADD_BOSS_HP` (`battle.BossHpMsg {campaign_id (#1), value (#2), node_id (#3), living_id (#4)}`), 4985 `U_C_SYNC_ROOM_BOSS_HP` (`simple.SyncRoomBossHPMsg`), 4794 `U_B_REMAIN_HILL_BLOOD_SYNC` (311/312/313). Receivers: `M10/battle/view/ui/RoleShowViewII.as:219-300`, `M10/battle/view/ui/BattleUIView.as:1597-1640`. See [../world-boss/README.md](../world-boss/README.md), [../guild/README.md](../guild/README.md), [../forbidden-boss/README.md](../forbidden-boss/README.md), [../exploration/README.md](../exploration/README.md), [../campaign/README.md](../campaign/README.md).

## 5. Rules and formulas

### 5.1 bloodType (`DamageMsg.damage_type`, `CM/battle/data/BloodType.as:6-22`)

| Value | Name | Effect on the client | Usable in |
|---:|---|---|---|
| 6 | HP | HP change; number shown (red/yellow damage, green heal) | skills and buffs |
| 7 | troop | troop HP (`hp2`) change; shows "0" | skills and buffs |
| 8 | third | no model change; shows "0" | skills and buffs |
| 9 | SP | `sp += value` on the target hero (not the caster) | buff damages only |
| 10 | revive | HP restored, unit revived | skills (`waitRevives` path) |
| 11 | skill block | nothing visible | n/a |
| 21 | max HP | max HP changed by `hp_limit`, HP adjusted | skills and buffs |
| 24 | attack points | `hitPoint += value` | buff damages only |
| 26 | belief | goddess belief += value (cap 120) | buff damages only, target must be a goddess |

### 5.2 Damage formula (server)

Current mock (`docs/battle/server-engine.md` §5, `server/src/battle.rs:769-865`), integer arithmetic:

```text
magic   = attacker is magic (hero Job 3, troop AttackType 2) or skill Description contains "mágic"/"magia"
atk     = max(1, magic ? mag_attack : phy_attack)
def     = max(0, magic ? target.mag_defence : target.phy_defence)
base    = (atk * Parameter1 / 100) * atk / (atk + def)
spread  = base * random(95..105) / 100
crit    = chance min(50%, force_hit / (force_hit + 200)) -> damage * 3 / 2, extra_data |= 1
parry   = chance min(30%, target.parry / (target.parry + 200)) -> damage / 2, parry = true
damage  = max(damage, 1, hits); split evenly over hits, last hit takes the remainder
```

Production formula (to implement; each term marked as assumption is not visible in the client):

```text
damage  = base(atk, def, Parameter1)                       # as above
        * (1 + sum(attacker "damage dealt" buffs: AttackType 20, 40) )
        * (1 + sum(target  "damage taken" buffs: AttackType 15) )   # signed
        * (1 + crit ? (crit_damage_base + AttackType 17 bonuses) : 0)   # crit_damage_base 50% (mock)
        * (1 - elemental_resist(target, skill element) + resi_penetrate(attacker))   # assumption
        * (1 + hurt_up_percent / 100)                       # 4361 escalation, PvP
        * (magic ? 1 - AttackType 70 magic reduction : 1)
damage  = shield absorb (AttackType 34) before HP
heal    = Parameter1 based or buff value, * (1 + AttackType 14 healing received)
crit    rate = f(force_hit) + AttackType 16 - target AttackType 31     # assumption
parry   rate = f(parry) + AttackType 43                                 # assumption
```

`resi_percent` should carry the net resistance percent applied to the own hero's hits so the HUD shows it.

### 5.3 Other rules

| Rule | Value | Source |
|---|---|---|
| Damage spread | 95..105% | mock |
| Crit multiplier | 1.5 (mock) | mock |
| Parry multiplier | 0.5 (mock) | mock |
| Minimum | 1 per hit | mock |
| HurtUp countdown | `count_down` ms; `damage_improve` cumulative (`+=`) per notice | `CM/battle/mode/HurtUpMode.as:34-70` |
| HurtUp display | only when `isPvP()`: true in 35, 349, 3907, false in 291, 39, 3844, 3847, 3867, 3868, 3870, 3872, 3873, 3875, 3845, 3889, else true when an enemy non boss hero exists | `CM/yishi/datas/BattleModel.as:947-1023` |
| Child arena (3847) | `damage_improve` = skill id, `damage_addition` = improvement; no view | `BattleModel.as:928-935` |
| World boss invincible | battleType 17 with `wordBossInvincibleState`: the boss (type 3, enemy side) takes no damage and its bar stays full | `CM/battle/actions/DannyAction.as:146-150` |
| World boss groups | 17, 297, 305, 3865, 313, 3881, 3903 use a server synced HP (`getWorldBoss`) | `BattleModel.as:861-878` |
| Death | the unit whose HP model reaches 0 plays death 12 frames after the hit | `docs/battle/rules.md` §6.3 |
| Overkill | clipped to remaining HP by the client; send the real value in `damage_value` (displayed) and 0 in `left_value` | `BloodHelper.as:204-219` |
| Troop damage | bloodType 7 on the hero `hp2` (troops carried by heroes) | `RoleInfo.as:346-379` |
| Attack points | `hitPointMax` default 5; spent by `HitPointCost` | `docs/battle/rules.md` §12.11 |

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `raw/xml/tempinfos/SkillTempInfos.xml` | skill power | `Parameter1` (percent of attack, 100 = normal), `Parameter2`, `ProperType` (element, assumption), `Description` (magic keywords in the mock) |
| `raw/xml/tempinfos/SkillBufferTempInfos.xml` | modifiers | `AttackType`, `AttackValue`, `ValuePercent` |
| `raw/xml/tempinfos/GameHeroTemp.xml`, `PawnTempInfos.xml` | base stats | `Attack`, `Defence`, `MagicAttack`, `MagicDefence`, `ForceHit`, `Parry`, resistances |
| `raw/xml/tempinfos/StelaResistTemplates.xml`, `GoddessUnitedResiTemplates.xml` | resistance sources | owned by [../steles/README.md](../steles/README.md), [../goddess/README.md](../goddess/README.md) |

## 7. Persistent state

None. Damage dealt per player is stored in `battle.battle_participants.damage_dealt` ([lifecycle.md](lifecycle.md) §7) for rankings of boss features.

## 8. Backend implementation notes

- `battle::damage::compute(attacker, target, skill, hit_count, rng, ctx) -> Vec<Hit>` pure function, unit tested; `ctx` carries battleType rules (invincible boss, HurtUp percent).
- RNG: xorshift64 seeded per battle (`battles.rng_seed`) for reproducible battles and server side replays.
- Build `DamageMsg` in target grouped order; fill `left_value` after each hit; `extra_data = 1` on crit; `parry = true` on parry; `resi_percent` for HUD.
- HurtUp scheduler (actor): at `count_down` ms, add `damage_improve` to the battle's escalation percent and push 4361 with the next `count_down`. Configured per battleType by the owning feature.
- Shared boss HP: the owning feature holds the authoritative HP (other players hit the same boss). The battle reads it at start (unit `hp`), reports damage dealt in real time to the owner, and applies sync pushes (§4.3) to the boss unit; the owner sends the sync opcodes.
- Death detection on the server is immediate (`hp <= 0`); the unit stops acting and is no longer targeted.

## 9. Open questions and assumptions

1. The original damage formula is not visible in the client; §5.2 production formula is a proposal built from buff names and the mock.
2. Element of a skill (`ProperType` 0..6: assumption mapping to fire, water, electricity, wind, dark, light).
3. Meaning of `resi_type`, `resi_value`, `buffer_type`, `is_harmful`.
4. HurtUp parameters per mode (interval and step) are not in the templates.

## 10. Implementation checklist

- [ ] `battle::damage::compute` with attack/defense, skill percent, spread, crit, parry, minimum, split over hits
- [ ] Buff modifiers: damage dealt/taken, crit rate/damage, parry, shield, heal received, resist, ignore defense/resistance
- [ ] `DamageMsg` encoder (grouping, `left_value`, crit bit, parry, `resi_percent`)
- [ ] bloodTypes 6, 7, 9, 10, 21, 24, 26 produced where needed
- [ ] Server message 4361 and HurtUp scheduler for PvP modes
- [ ] World boss invincible state and shared HP hooks
- [ ] Test: formula golden values with a fixed seed
- [ ] Test: heal shows green, crit shows crit asset, parry shows small blue number
