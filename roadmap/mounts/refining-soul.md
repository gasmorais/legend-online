# Refining soul ("Refino Espiritual de Fera", "Vontade da Alma da Fera")

Scope: feeding "Coração do Refino da Fera" (208070) to raise four refining grades (one per mount attribute) and the derived skill "Vontade da Alma da Fera", which add a percentage bonus on top of the mount attribute totals. State travels inside `MountInfoMsg` fields #16..#20.

Path aliases (all under `decompiled/`):

| Alias | File |
|---|---|
| MM | `core_module/scripts/managers/MountsManager.as` |
| MRSI | `core_module/scripts/mvc/module/mounts/MountRefiningSoulInfo.as` |
| MRSF | `m14/scripts/mounts/MountRefiningSoulFrame.as` |
| MRSIT | `m14/scripts/mounts/MountRefiningSoulItem.as` |
| MF | `m14/scripts/mounts/MountsFrame.as` |
| PIT | `m14/scripts/mounts/PropertyItem.as` |
| SMI | `core_module/scripts/yishi/datas/playerinfo/SimpleMountInfo.as` |
| TM | `core_module/scripts/yishi/manager/TempleteManager.as` |
| CIM | `core_module/scripts/yishi/datas/ConfigInfoManager.as` |

## 1. Overview

The player owns one refining record: `strength_grade`, `intellect_grade`, `stamina_grade`, `armor_grade` (0..80 each) and `exp`. Every item fed adds EXP to a single bar; when the bar reaches the requirement of the current total grade, one attribute grade rises. Each attribute grade gives a percentage (`UpGradeTempInfos` Types 144); the total grade gives the skill level and its percentage (Types 145). Final bonus per attribute = `ceil(min(ceil(addition * skill% / 100), cap) * attr% / 100)`, added to the attribute shown to the player (`PIT:124-132`).

Available when `VersionSwitch.MOUNT_REFINING_SOUL` is true (`core_module/scripts/yishi/datas/VersionSwitch.as:100`, default true), from the mount screen (lord grade 16).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `mounts.MountRefiningSoulFrame` (`MRSF`) | "Refino Espiritual de Fera" (`MRSF:288-293`) | Feed 208070 | MountsFrame button `mount.refiningSouleBtn` (`MF:220, 277-280, 477-481`) -> controller `mounts` openType 3 -> stylename `mountrefiningsoul.MountRefiningSoulFrame` (`core_module/scripts/mvc/controler/MountsController.as:26-29`), mapped to class `mounts.MountRefiningSoulFrame` in `raw/ui/zh_cn/xml/decoded/mounts.xml` | Skill name "Vontade da Alma da Fera", skill percent "{n}%" (`MRSF:238-266`) with tooltip `MountRefiningSoulFrame.skillImage.tipdata` "Elevando a Vontade da Alma da Fera pode fortalecer os atributos da montaria. Atualmente a montaria tem uma Vontade da Alma da Fera de nível {0}. A taxa de fortalecimento é {1}%." plus one `propValue0..3` line per attribute; EXP bar `exp / Data(totalGrade)` or "Max" (`MRSF:216-236`); owned count of 208070 in bag and storage (`GoodsManager.getBagCountInPlayerAndStoneByTempId`, `MRSF:229-230`); count input (1..min(owned, 999), `MRSF:181-193`); item icon tooltip = item description |
| `mounts.MountRefiningSoulItem` (`MRSIT`) | head icon per attribute | Attribute refining percent | MRSF (4 heads, order Strength, Intellect, Armor, Stamina, `MRSIT:35-42`) | "{attr%}%", tooltip "Pontos de Vontade da Alma da Fera fortalecidos para {0}\nProgresso de refino espiritual de {1}: {2}%\nPontos do bônus do atributo {3} da montaria: {4}" (`MRSIT:57-76`) |

## 3. Routes (client to server)

### R1. Refine (op 12, `REFINING_SOULE_SEND`)
- UI: `_refiningSoulBtn` (`MRSF:195-209`).
- Client checks: count <= 0 or > owned -> "Materiais necessários insuficentes, não é possível efetuar operação."; all four grades at max (`MRSI.isSkillMax`, `MRSI:34-39`) -> "O nível atingiu o máximo".
- Request: 8529 (0x2151) `C_MOUNT_OP`, `MountEditMsg`: `op` (#5) = 12, `param1` (#3) = item count, others 0.
- Response: 4426 `MountInfoMsg` with `refining_soul_*_grade` (#16..#19) and `refining_soul_exp` (#20) updated (plus all other fields); 115 for the consumed items.

### Unused refining opcodes (do not implement)
8466 (0x2112) `C_REFININGSOUL_FRFRESH`, 8467 (0x2113) `C_REFININGSOUL_SWAP`, 4372 (0x1114) `U_C_REFININGSOUL_FRFRESH` ("炼魂刷新", "炼魂兑换") and `PlayerRefiningSoulMsg` (package `lucky`: `count` #1, `remainCount` #2, `point` #3, `soul` #4, `state` #5, `p` #6, all INT32) are declared (`core_module/scripts/yishi/datas/consant/ProtocolType.as:446-448`, `AcceptProtocolType.as:594`) but no class sends or listens to them. Together with `ConfigInfos` `RefiningSoul_Grades`, `RefiningSoul_Count`, `RefiningSoul_ArmyHouseMut`, `RefiningSoul_PeopleMut` (barracks/house multipliers) they belong to an older, removed system unrelated to mounts.

## 4. Server messages (server to client)

### S1. 4426 (0x114a) `U_C_MOUNT_UPDATE`, `MountInfoMsg` refining fields
Receiver `MM.__onMountInfoUpdate` (`MM:149-154`): copies the fields into `MM.selfRefiningSoulInfo` and notifies `MOUNT_REFINING_SOUL_CHANGE`, which refreshes MRSF (`MRSF:211-214`) and every PropertyItem of MountsFrame (`MF:447-453`).

| Field | Tag, type | Meaning |
|---|---|---|
| `refining_soul_power_grade` | #16, INT32 | Strength refining grade 0..80 |
| `refining_soul_intellect_grade` | #17, INT32 | Intellect refining grade |
| `refining_soul_physique_grade` | #18, INT32 | Stamina refining grade |
| `refining_soul_agility_grade` | #19, INT32 | Armor refining grade |
| `refining_soul_exp` | #20, INT32 | EXP inside the current step |

The same fields in 4459 let other players' views add the bonus (`SMI:30-61`, `m5/scripts/playerinfo/view/MountInfoView.as:205-221`).

### Current server behavior
The login 4426 sends all refining fields as 0 (`server/flows.json:411-433`); op 12 is unanswered.

## 5. Rules and formulas

Definitions (`MRSI:23-72`): `totalGrade = strength + intellect + stamina + armor` (0..320).

EXP requirement (`raw/xml/tempinfos/UpGradeTempInfos.xml` Types 146, `Grades` = totalGrade, `MRSF:218`): `Data = 10 * (floor(totalGrade / 4) + 1)` for totalGrade 0..319 (10, 10, 10, 10, 20, ..., 800) and 1000 at 320 (max, bar shows "Max"). Sum from 0 to max: 129600 EXP.

Attribute grade percent (Types 144, `Grades` 1..80, `ActiveObject`, `MRSI:47-55`; grade 0 = 0%):

| Grades | Percent |
|---|---|
| 1..10 | 1..10 (+1 per grade) |
| 11..20 | 12..30 (+2) |
| 21..30 | 33..60 (+3) |
| 31..40 | 64..100 (+4) |
| 41..80 | 105..300 (+5) |

Max attribute grade = last row of Types 144 = 80 (`MRSI:34-39`).

Skill grade (Types 145, 20 rows, each `Data` 16, via `TM.getNewUpgradeGradeBy(145, totalGrade)`, `TM:2373-2402`): `skill = min(20, floor(totalGrade / 16) + 1)`; skill percent = `ActiveObject` = `24 + 4 * (skill - 1)` (24..100) (`MRSI:28-45`). Note that a player with totalGrade 0 already has skill 1 (24%), but the bonus is 0 because every attribute percent is 0.

Bonus per attribute (`PIT:124-132`, `SMI:47-59`, `m16/scripts/yishi/view/tips/PropertyTip.as:58-86`):
- `skillPart = ceil(addition * skill% / 100)` where `addition` is the attribute total from 4426.
- `capped = min(skillPart, mount_refining_soul_value_max)` (config 100000; client default 200000, `CIM:936-943`).
- `bonus = ceil(capped * attr% / 100)`.
- Displayed attribute = `addition + bonus`. The hero stat calculator must use the same value (assumption).

Feeding (server, assumptions marked):
- Each 208070 gives 1 EXP (assumption; no template states it).
- After adding EXP, while `exp >= Data(totalGrade)` and not all grades are 80: `exp -= Data`, raise one attribute grade by 1. Which attribute: assumption, uniformly random among attributes below 80.
- Reject when all grades are 80 (client check `isSkillMax`). Stop consuming items when max is reached (refund the rest, assumption).
- Count limits: 1..999 per request (client clamp `MRSF:188`).

## 6. Templates

| File | Records and fields used |
|---|---|
| `raw/xml/tempinfos/UpGradeTempInfos.xml` Types 144 | attribute refining percent by grade (`Grades`, `ActiveObject`) |
| `raw/xml/tempinfos/UpGradeTempInfos.xml` Types 145 | skill grade step (`Data` 16) and skill percent (`ActiveObject`) |
| `raw/xml/tempinfos/UpGradeTempInfos.xml` Types 146 | EXP per step by total grade (`Grades`, `Data`) |
| `raw/xml/tempinfos/ConfigInfos.xml` | `mount_refining_soul_item_temp_id` = 208070; `mount_refining_soul_value_max` = 100000 |
| `raw/xml/tempinfos/ItemTempInfos.xml` | 208070 "Coração do Refino da Fera" (SonType 208, MaxCount 999; "é produzido na Câmara de Comércio da Guilda") |

## 7. Persistent state

```sql
CREATE TABLE mounts.refining_soul (
  player_id        BIGINT      PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
  strength_grade   SMALLINT    NOT NULL DEFAULT 0 CHECK (strength_grade BETWEEN 0 AND 80),
  intellect_grade  SMALLINT    NOT NULL DEFAULT 0 CHECK (intellect_grade BETWEEN 0 AND 80),
  stamina_grade    SMALLINT    NOT NULL DEFAULT 0 CHECK (stamina_grade BETWEEN 0 AND 80),
  armor_grade      SMALLINT    NOT NULL DEFAULT 0 CHECK (armor_grade BETWEEN 0 AND 80),
  exp              INTEGER     NOT NULL DEFAULT 0 CHECK (exp >= 0),
  updated_at       TIMESTAMPTZ NOT NULL DEFAULT now()
);
```

## 8. Backend implementation notes

Handler `mounts::refining::handle_refine` (8529 op 12).

Validation order: lord grade >= 16 -> `1 <= param1 <= 999` -> not all grades 80 -> owned 208070 (bag and storage, per the client count) >= `param1`.

Transaction: lock `refining_soul`; consume items one by one applying the level-up loop until the count is used or max is reached; consume only what was used; update the row; commit. Pushes: 115 (items), 4426 (refining fields and unchanged totals). Recompute fighting capacity (the bonus changes the displayed attributes).

Item source in storage: the client counts "player and stone" bags (`getBagCountInPlayerAndStoneByTempId`); the inventory service must consume from the same bags (assumption: bag first).

## 9. Open questions and assumptions

- EXP per item (assumption: 1).
- Choice of the attribute that levels up (assumption: random among non-max).
- Whether the hero stats include the refining bonus (assumption: yes, the client shows it in the totals).
- Bag order when consuming 208070 from bag and storage.

## 10. Implementation checklist

- [ ] Screen `mounts.MountRefiningSoulFrame` and `MountRefiningSoulItem` driven by 4426 #16..#20
- [ ] Route op 12 refine (count 1..999)
- [ ] Server message 4426 refining fields (also in 4459)
- [ ] Table `mounts.refining_soul`
- [ ] Rule: Types 146 EXP steps, Types 144 attribute percent, Types 145 skill percent
- [ ] Rule: bonus formula with cap `mount_refining_soul_value_max`
- [ ] Rule: max grade 80 per attribute
- [ ] Test: feeding 40 items from 0 raises 4 grades (10 EXP each) and totalGrade 4 needs 20 next
- [ ] Test: max state rejects
