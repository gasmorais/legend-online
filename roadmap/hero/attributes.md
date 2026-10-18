# Attributes, level and stats (Atributos)

Path aliases:

| Alias | File |
|---|---|
| AM | `decompiled/core_module/scripts/yishi/manager/ArmyManager.as` |
| PM | `decompiled/core_module/scripts/yishi/manager/PlayerManager.as` |
| TIH | `decompiled/core_module/scripts/com/road/pb/helper/army/ThaneInfoHelper.as` |
| TI | `decompiled/core_module/scripts/yishi/datas/playerinfo/ThaneInfo.as` |
| SPI | `decompiled/core_module/scripts/yishi/datas/playerinfo/SimplePlayerInfo.as` |
| ASOM | `decompiled/core_module/scripts/managers/ArmySocketOutManager.as` |
| TAF | `decompiled/m5/scripts/playerinfo/view/ThaneAttributeFrame.as` |
| PEV | `decompiled/core_module/scripts/ui/maintoolbar/view/PlayerExperenceView.as` |

## 1. Overview

All hero numbers are server-authoritative. The client receives:
- the hero record (113 `SimpleHeroInfoMsg`, also embedded in 150 `ArmyMsg.simple_hero_info`): template (class and sex), primary attributes (Força, Proteção, Inteligência, Físico, Liderança) as base / added points / totals, combat stats (Ataque, Defesa, Magia, Resistência, Crítico, Bloqueio, Vida, Infantaria = soldier command, Penetração, "Força Consistente" = stun), elemental resistances, skills, talents, runes;
- level/EXP and player-level counters through 3 `U_C_PLAYER_INFO` (`PlayerMsg`): `grades`, `gp`, `leave_gp` (offline EXP), `job`, `geste` (honor), `charm`, `fighting_capacity`, `appell_id`.

Manual attribute point allocation exists in the protocol (`remain_point`, `*_point`, 5170/5171) but the BR client has no UI that sends it: points are legacy. The UI shows totals and explanations.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `armyII.ArmyFrameII` + `armyII.viewII.equip.EquipView` | "Equipamentos" (`armyII.ArmyFrameII.title01`) | Hero figure, equipment slots (inventory feature), side attribute panel | key B, toolbar | `ThaneInfo` |
| `armyII.viewII.equip.HeroFigureView`, `ThaneExperenceView` | | Avatar and EXP/vocation bar | EquipView | avatar, `gp`, `grades` |
| `playerinfo.view.PlayerAttributeView` (+ `playerattribute/*`) | link "Detalhes", title combo "Modificar de Título" | Summary panel: level "Nv.{0}", guild ("Nenhum"), title, totals | hero frame, PlayerInfoFrameII | `ThaneInfo` |
| `playerinfo.view.ThaneAttributeFrame` (TAF) | "Atributos" (`playerinfo.view.ThaneAttributeFrame.titleText`) | Full attribute sheet with tooltips | "Detalhes" | base and total of every stat; tips "Aumento dos danos do jogador {n}%", "Redução de danos recebidos {n}%", resistance gem totals ("Anti-Resistência, Fogo, Água, Vento, Choque, Luz, Escuridão") |
| `ui.maintoolbar.view.PlayerExperenceView` (PEV) | "{0}({1}%) \nExperiência abundante restante {2} (Exp Offline)" / "Nível máximo atingido" | EXP bar of the main toolbar | always | `gp` vs next level, or vocation EXP |

## 3. Routes (client to server)

### R1. Reset attribute points (legacy, no UI)
- Client path: `ArmyControler.sendWashPoint()` (`decompiled/core_module/scripts/mvc/controler/ArmyControler.as:386-394`) → `ASOM.sendWashPoint` (ASOM:291-295). No caller exists in the BR client.
- Route: send 5170 (0x1432) `U_C_HERO_RESETPOINT`, no body. Expected response 66 (0x0042) `U_C_HERO_RESETPOINT` (no client listener) and 113.

### R2. Add attribute points (legacy, no UI)
- 5171 (0x1433) `U_C_HERO_ADDPOINT` exists in `protocol/opcodes.csv`; no client sender. The message would be `HeroAddPointReqMsg` (`power_point` #1, `agility_point` #2, `intellect_point` #3, `captain_point` #4, `physique_point` #5, INT32) by name *(assumption)*. Response 67 (0x0043) `U_C_HERO_ADDPOINT` has no client listener.

Implement both as no-ops returning 113 unless a later client uses them.

## 4. Server messages (server to client)

### S1. 113 (0x0071) `U_C_HERO_INFO`
- Message `SimpleHeroInfoMsg` (army), every field:

| Field | Tag/type | Meaning / client target (TIH:161-460) |
|---|---|---|
| `hero_id` | #1, INT32 | `id` |
| `nick_name` | #2, STRING | `nickName` |
| `tempate_id` | #3, INT32 | `templateId` (`GameHeroTemp`; changing it disables auto head update, AM:372-385) |
| `player_id` | #4, INT32 | `userId` |
| `remain_point` | #5, INT32 | unspent attribute points (legacy) |
| `skill_point` | #6, INT32 | see [../skills/hero-skills.md](../skills/hero-skills.md) |
| `skill_script` | #7, STRING | learned skills CSV |
| `fast_key` | #8, STRING | skill bar |
| `hp` | #9, INT32 | current HP |
| `blood` | #10, INT32 | blood bottle amount |
| `blood_id` | #11, INT32 | blood item id |
| `total_power`..`total_physique` | #12-#16, INT32 | totals of Força, Proteção (`agility`), Inteligência, Liderança (`captain`), Físico |
| `total_phy_attack`, `total_phy_defence`, `total_magic_attack`, `total_magic_defence`, `total_force_hit`, `total_parry`, `total_conat_army`, `total_live` | #17-#24, INT32 | combat totals; `conat_army` = soldier command (troop cap) |
| `base_power`..`base_physique` | #25-#29, INT32 | base primary attributes |
| `base_phy_attack`..`base_live` | #30-#37, INT32 | base combat stats |
| `power_point`..`physique_point` | #38-#42, INT32 | added points (legacy) |
| `fight_pos` | #43, INT32 | read unconditionally (1 front, 3 back) |
| `skill_index` | #44, INT32 | active skill set |
| `is_activeSecond` | #45, BOOL | second skill set bought |
| `head_id` | #46, INT32 | portrait |
| `talent_point`, `talent_grade`, `talent_skill` | #47-#49 | talents |
| `grade` | #50, INT32 | not read (level comes from 3) |
| `arm`, `cloth`, `wing` | #51-#53, STRING | not read from 113 (read from 150 `ArmyMsg`) |
| `fighting_capacity` | #54, INT32 | not read here |
| `server_name` | #55, STRING | not read |
| `hat`, `fashion_arm`, `fashion_cloth` | #56-#58, STRING | not read from 113 |
| `hide` | #59, BOOL | not read from 113 |
| `rune` | #60, `HeroRuneMsg` | runes |
| `fireResi`, `waterResi`, `electResi`, `windResi`, `darkResi`, `lightResi` | #61-#66, INT32 | read unconditionally into `totalFireResi`.. |
| `reduce_resi` | #67, INT32 | read unconditionally into `totalBattleWill` (anti-resistance) |
| `total_strength`, `base_strength` | #68-#69 | intensity ("Aumento dos danos") |
| `total_tenacity`, `base_tenacity` | #70-#71 | tenacity ("Redução de danos recebidos") |
| `total_penetrate`, `base_penetrate` | #72-#73 | Penetração |
| `advanced_talent_point`, `advanced_talent_grade`, `advanced_talent_skill` | #74-#76 | advanced talents |
| `total_stunAttr`, `base_stunAttr` | #77-#78 | "Força Consistente" (`Dingli`) |
| `total_reduce_resi_against`, `reduce_resi_against` | #79-#80 | first read unconditionally into `totalResistResi` |
| `total_resi_penetrate`, `resi_penetrate` | #81-#82 | first read unconditionally into `totalStrikeResi` |

- Receiver: `AM.__uHeroInfoHandler` (AM:372-385) → `TIH.readHeroInfo`. Fields marked unconditional (TIH:443-452) are overwritten even when absent; always send them.
- When: after any change of stats, skills, talents, runes, equipment, buffs; at login via 150.

### S2. 3 (0x0003) `U_C_PLAYER_INFO` hero fields
- Message `PlayerMsg` (player, 166 fields). Hero-related, read by `PM.__uPlayerInfoHandler` (PM:496-1120): `job` (#41) (PM:726-731), `grades` (#16) (PM:733-740), `gp` (#17) (PM:741-748), `leave_gp` (#72) offline EXP (PM:749-756), `geste` (#60) honor (PM:757-764), `charm` (#69), `lords_score` (#82), `reward_times` (#75), `storeGrade`/`storeGp` (#61/#62, jewel), `appell_id` (#78) (PM:837-843), `applle_property_Open` (#94) title attributes unlocked (PM:1105-1109), `hasVicePassword` (#95), `isDuringToResetTime` (#96) (PM:1113-1117), `fighting_capacity` (#30), `totalGp` (#49). Other fields belong to their features.
- When: at login and after every change; partial messages are allowed (`has*` guards).

### S3. 66 `U_C_HERO_RESETPOINT` / S4. 67 `U_C_HERO_ADDPOINT`
No client listeners; do not send.

## 5. Rules and formulas

- Hero templates: `GameHeroTemp.xml` rows 1..6 are the six starting heroes (Guerreiro/Guerreira job 1, Arqueiro/Arqueira job 2, Feiticeiro/Feiticeira job 3); `Power`, `Agility`, `Intellect`, `Captain`, `Physique` base attributes; `SkillScript` initial skills.
- Hero level EXP: `UpGradeTempInfos` `Types 3`, `Grades` 1..80, `Data` = total EXP to reach that level (level 2 = 3000, level 80 = 110946655) (PEV:184).
- After level 80 EXP goes to the vocation track ([job-change.md](job-change.md)): `Types 105` (no transfer, 80 levels), `110` (transferred), `152` (Avenger, 30), `158` (Holy, 40) (PEV:154-176).
- Display formulas (`decompiled/core_module/scripts/yishi/datas/playerinfo/AttackProrertyInfo.as:109-117`): damage increase % = `intensity * 100 / (intensity + 8000)`; damage reduction % = `tenacity * 100 / (tenacity + 8000)`.
- `totalGrade` for rankings (TI:511-531): `grades + vocationGrades` without transfer; `160 + vocationGrades` for vocation index 1-2; `240 +` for index 3; `270 +` for index >= 4.
- Level-up side effects in the client (TI:1044-1068): at 55 requests fate wheel skills (8628), at 30 refreshes fighting power.
- Stat aggregation (server): template base + attribute points + equipment + gems + skills/talents passives + tattoos + fashion + titles + battle guard + dragon soul + mounts + buffs. Each feature owns its contribution; the hero service sums them and sends 113.

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `GameHeroTemp.xml` | hero template (7370 rows; 1..6 player heroes, others NPC) | `TemplateId`, `TemplateName`, `HeroType`, `Job`, `Sexs`, `Icon`, `Grades`, `DefaultSkill`, `SkillScript`, `Power`, `Agility`, `Intellect`, `Captain`, `Physique`, `Attack`, `Defence`, `MagicAttack`, `MagicDefence`, `Live`, `Conat`, `ForceHit`, `Parry`, resistances, `ResPath`, `ArmPath`, `ClothPath` |
| `UpGradeTempInfos.xml` | `Types 3`, `105`, `110`, `152`, `158` | `Grades`, `Data` (EXP), `TemplateName` (vocation names per class, `|` separated) |

## 7. Persistent state

```sql
CREATE SCHEMA IF NOT EXISTS hero;

CREATE TABLE hero.heroes (
    player_id        BIGINT PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
    hero_id          BIGINT  NOT NULL UNIQUE,
    template_id      INTEGER NOT NULL,
    nick_name        TEXT    NOT NULL,
    head_id          INTEGER NOT NULL DEFAULT 0,
    grade            SMALLINT NOT NULL DEFAULT 1 CHECK (grade BETWEEN 1 AND 80),
    exp              BIGINT  NOT NULL DEFAULT 0 CHECK (exp >= 0),
    offline_exp      BIGINT  NOT NULL DEFAULT 0,
    hp               INTEGER NOT NULL DEFAULT 0,
    honor            INTEGER NOT NULL DEFAULT 0,
    charm            INTEGER NOT NULL DEFAULT 0,
    blood            INTEGER NOT NULL DEFAULT 0,
    blood_item_id    INTEGER NOT NULL DEFAULT 0,
    fighting_capacity INTEGER NOT NULL DEFAULT 0,
    updated_at       TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE hero.attribute_points (
    player_id        BIGINT PRIMARY KEY REFERENCES hero.heroes(player_id) ON DELETE CASCADE,
    remain_points    INTEGER NOT NULL DEFAULT 0,
    power_points     INTEGER NOT NULL DEFAULT 0,
    agility_points   INTEGER NOT NULL DEFAULT 0,
    intellect_points INTEGER NOT NULL DEFAULT 0,
    captain_points   INTEGER NOT NULL DEFAULT 0,
    physique_points  INTEGER NOT NULL DEFAULT 0
);
```

Derived totals are computed, not stored *(assumption: cache them in memory per session)*.

## 8. Backend implementation notes

- `hero::attributes::build_simple_hero_info(player)` assembles the full 113 from all contributing features; `hero::attributes::push_hero_info` sends it.
- `hero::attributes::handle_reset_points` (5170) and `hero::attributes::handle_add_points` (5171): legacy; validate and recompute; reply 113 only.
- `hero::attributes::grant_exp(player, amount)`: level-ups using `Types 3`; after level 80 delegate to the vocation track; push 3 (`grades`, `gp`), 113 (stats), skill points ([../skills/hero-skills.md](../skills/hero-skills.md)), talent points.
- Battle configuration: hero unit stats from the same aggregation (`docs/battle/server-engine.md` §9.3-9.4).

## 9. Open questions and assumptions

- Assumption: attribute points are obsolete in BR (no sender for 5170/5171).
- Open: exact aggregation order and rounding of stat sources (server formula not in the client).
- Open: whether `grade` (#50) of 113 must match 3 `grades`; the client ignores it.

## 10. Implementation checklist

- [ ] Screens: EquipView attribute panel, ThaneAttributeFrame, PlayerExperenceView
- [ ] Route 5170 (legacy) no-op
- [ ] Route 5171 (legacy) no-op
- [ ] Server message 113 complete field set
- [ ] Server message 3 hero fields
- [ ] Table `hero.heroes`
- [ ] Table `hero.attribute_points`
- [ ] Rule: EXP tables `Types 3` and vocation tracks
- [ ] Rule: stat aggregation service
- [ ] Test: level-up pushes 3 and 113 with consistent values
