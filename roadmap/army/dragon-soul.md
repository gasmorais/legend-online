# Dragon Soul and Holy Dragon Soul (Alma do Dragão, Alma do Dragão Sagrado)

Path aliases:

| Alias | File |
|---|---|
| PM | `decompiled/core_module/scripts/yishi/manager/PlayerManager.as` |
| DSV | `decompiled/m5/scripts/armyII/viewII/dragonsoul/DragonSoulView.as` |
| HDV | `decompiled/m5/scripts/armyII/viewII/holydragonsoul/HolyDragonSoulView.as` |
| HDL | `decompiled/m5/scripts/armyII/viewII/holydragonsoul/HolyDragonSoulLeadItem.as` |
| AF | `decompiled/m5/scripts/armyII/ArmyFrameII.as` |

## 1. Overview

A hero-bound progression fed with items:
1. Type 101 "Alma do Dragão": egg + 5 levels ("Filhote", "Criança", "Jovem", "Adulto", "Combate"); max level depends on hero level (40 → 1, 50 → 2, 60 → 3, 70 → 4, 80 → 5).
2. Type 102 "Coração do Dragão": 8 levels ("Coração do Dragão nv.1".."nv.8").
3. Type 153 "Alma do Dragão Sagrado" (Holy): unlocked by "awakening" a maxed type 102; 600 levels in stars of 6, fed with item 208550 "Alma do Dragão Sagrado".

Every type 101/102 level activates a passive skill (`ActiveObject`, 7101..7105, 7201..7208) whose attributes come from `SkillPropertyTempInfos`. Holy levels add flat stats listed in the template name CSV.

Note: `UpGradeTempInfos.xml` stores the names with `?` in place of non-ASCII letters (`Alma do Drag?o (Filhote)`); the strings above are the intended pt-BR names.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `armyII.viewII.dragonsoul.DragonSoulView` (DSV) | hero frame tab (`army.DragonSoulButton`), help "Instruções" | Stars of type 101 (5) and 102 (8), exp bar, "feed", "quick feed", "awaken" | `ArmyFrameII` tab, hero level >= 40 ("Habilitado Nv. {0}", AF:218, AF:351-356) | `playerInfo.dragonSoulType`, `dragonSoulGrade`, `dragonSoulGp`; tips "Não ativou", "Esperando a ser ativado:<br/>{0}", "Adição total de atributos da Alma do Dragão:<br/>{0}" |
| `DragonSoulBagView`, `DragonSoulBallComp`, `DragonSoulExpView` | | Item bag, animation, exp | DSV | items SonType 319 |
| `armyII.viewII.holydragonsoul.HolyDragonSoulView` (HDV) | tab replaces the Dragon Soul tab when `dragonSoulType == 153` (AF:242-249) | Holy level, star groups of 6, advance with item 208550 | `ArmyFrameII` | stat lines "Ataque +1000", "Defesa +1000", "Magia +1000", "Resistência +1000", "Crítico +1000", "Bloqueio +1000", "Vida +5000", "Penetração +1000"; final preview "Alma do Dragão Sagrado:" with "+50000"/"+250000" lines |
| `HolyDragonSoulLeadItem` (HDL) | "Ativado com Alma do Dragão Sagrado nv. {0}" | Milestone skills | HDV | `ActiveObject` skill descriptions |

## 3. Routes (client to server)

### R1. Request Dragon Soul data
- When: DSV opens for the own hero (DSV:173-178).
- Client path: `PM.sendDragonSoulRequest()` (PM:2090-2094).
- Route: send 8642 (0x21c2) `C_DRAGON_REQUEST`, no body.
- Response: 4555 (S1).

### R2. Feed (type 101/102) or advance (type 153)
- UI: "feed" (`DSV.__feedBtnClickHandler`, DSV:321-327) and "quick feed" (DSV:329-335); holy advance (`HDV.__advanceBtnHandler`, HDV:301-318).
- Client checks (DSV:342-362): type 102 at max level and exp full → "Atingiu o nível máximo da Alma do Dragão, não pode continuar a alimentar"; no item SonType 319 in bag → "Não existe Alma do Deus de Dragão na sua mochila, não é possível alimentar". Holy: item 208550 count >= next level `Data` else "Materiais insuficientes"; no next level → "Coração do Dragão Sagrado no nível máximo, não é possível elevar mais".
- Client path: `PM.sendDragonSoulFeed(n)` (PM:2075-2081).
- Route: send 8641 (0x21c1) `C_DRAGON_FEED`, `FateEditMsg` (fate): `use_itemCount` (#2, INT32) 1 = feed once, 2 = quick feed (holy advance always 1); other fields (`skill_sonType` #1, `is_disable` #3, `turn_num` #4, `param1` #5, `param2` #6, `is_success` #7, `curr_count` #8, `count` #9 repeated, `pay_type` #10, `index` #11) unset.
- Response: 4555 with new type/grade/gp, bag update for consumed items, hero stats 113.

### R3. Awaken into Holy Dragon Soul
- UI: `_awakenBtn` (DSV:337-340), visible when `VersionSwitch.HOLY_DRAGON_SOUL` (true) and type 102 is at max level with full exp (DSV:480-485).
- Route: send 9689 (0x25d9) `C_HOLY_DRAGON_OP`, `CommonMsg` (player) with no fields set (`param1`..`param7` exist: INT32 #1-#3, STRING #4-#5, INT64 #6-#7).
- Response: 4555 with `fate_types = 153`, grade 0; the hero frame then shows the Holy tab.

## 4. Server messages (server to client)

### S1. 4555 (0x11cb) `U_C_DRAGON_REQ`
- Message `FateListMsg` (fate): `fateInfo` (#1, `FateInfoMsg`, repeated). `FateInfoMsg`: `template_id` (#1, INT32), `fate_types` (#2, INT32) 101/102/153, `total_gp` (#3, INT64) exp inside the current level, `grades` (#4, INT32), `property1` (#5, STRING), `property2` (#6, STRING), `turn_count` (#7, INT32), `index` (#8, INT32).
- Receiver: `PM.__dragonSoulReqHandler` (PM:1970-1989): keeps the entry with the highest `fate_types` → `playerInfo.dragonSoulType`, `dragonSoulGrade`, `dragonSoulGp`.
- When: response to 8642, 8641, 9689; at login *(assumption)*.

Not part of this module: 4556 `U_C_TRANSFER` and 4557 `U_C_TRANS_GRADE` are job transfer messages handled next to it in `PlayerManager` (PM:1991-2073), see [../hero/job-change.md](../hero/job-change.md).

## 5. Rules and formulas

- `UpGradeTempInfos` `Types 101`: `Grades` 0..5, `Data` exp to reach the level (6, 15, 30, 50, 72), `ActiveObject` skill id. Max level by hero level (DSV:401-430).
- `Types 102`: `Grades` 1..8, `Data` (0, 50, 120, 300, 830, 1590, 2240, 2890), `ActiveObject` 7201..7208. Max level = highest `Grades` (`maxUpLevel`, DSV:213-220).
- Exp accounting (DSV:364-399): current = sum of `Data` for levels 1..grade + `dragonSoulGp`; cap = sum up to max level + next `Data`.
- Feed item: SonType 319 (e.g. 208032 "Alma do Dragão", `Property2` = 2 exp per item *(assumption: `Property2` is the exp value)*).
- `Types 153` (holy, 600 levels): `Data` = number of 208550 per level (5 at the start, 200 at level 600); `TemplateName` = CSV of 6 stat totals at that level; stars of `LEVEL_NUMBER` = 6 levels (HDV:31, HDV:354-356); `HOLY_DRAGONSOUL_COSTTEMPID` = 208550 (`decompiled/core_module/scripts/yishi/datas/playerinfo/PlayerModel.as:61`).
- Transition 101 → 102 happens server-side when type 101 reaches level 5 *(assumption)*.

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `UpGradeTempInfos.xml` | `Types 101`, `102`, `153` | `Grades`, `TemplateName` (level name or stat CSV), `Data` (exp or item count), `ActiveObject` (skill id) |
| `SkillTempInfos.xml` / `SkillPropertyTempInfos.xml` | skills 7101..7208 | attribute bonuses shown in tips (DSV:640-740) |
| `ItemTempInfos.xml` | SonType 319, 208550 | feed materials |

## 7. Persistent state

```sql
CREATE TABLE army.dragon_soul (
    player_id     BIGINT   PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
    soul_type     SMALLINT NOT NULL DEFAULT 101 CHECK (soul_type IN (101, 102, 153)),
    grade         INTEGER  NOT NULL DEFAULT 0 CHECK (grade >= 0),
    exp           BIGINT   NOT NULL DEFAULT 0 CHECK (exp >= 0),
    awakened_at   TIMESTAMPTZ,
    updated_at    TIMESTAMPTZ NOT NULL DEFAULT now()
);
```

## 8. Backend implementation notes

- `army::dragon_soul::handle_request` (8642): reply 4555 with one `FateInfoMsg` (`fate_types` = current type) *(assumption: earlier stages need not be listed)*.
- `army::dragon_soul::handle_feed` (8641): hero level >= 40; type 101/102: consume 1 item SonType 319 (quick feed: as many as needed to reach the next level or the cap *(assumption)*), add exp, level up while exp >= next `Data` and level < max for the hero level; switch to 102 at the end of 101; type 153: consume `Data` x 208550 and add 1 level. Push 4555, bag update, 113.
- `army::dragon_soul::handle_awaken` (9689): type 102 at max level and exp full; set type 153, grade 0; push 4555.
- Stats: add the level skills (101/102) or the holy stat CSV to the hero; push 113.

## 9. Open questions and assumptions

- Assumption: quick feed (`use_itemCount = 2`) consumes several items in one request.
- Assumption: exp per item from `Property2`.
- Open: `turn_count`, `property1/2`, `index` of `FateInfoMsg` are not read by this screen.

## 10. Implementation checklist

- [ ] Screen: DragonSoulView, HolyDragonSoulView
- [ ] Route 8642 request
- [ ] Route 8641 feed / quick feed / holy advance
- [ ] Route 9689 awaken
- [ ] Server message 4555
- [ ] Table `army.dragon_soul`
- [ ] Rule: max level by hero level, exp thresholds, holy item costs
- [ ] Test: 101 level 1..5, transition to 102, awaken, holy advance
