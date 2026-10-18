# Resonance slots ("Ressonância", "Fortalecer Ressonância")

Feature `divine-weapon`, module `resonance`. Every owned artifact (the host) has 5 resonance slots. The player links another owned artifact into a slot, and the host inherits a percentage of one or two stats of the linked artifact. The percentage depends on the slot level, which is **per player and per position** (shared by all hosts) and is raised with "Cristal de Ressonância". A linked resonance slot also unlocks the emblem slot with the same number ([emblems.md](emblems.md)).

Conventions:
- Paths are relative to `decompiled/` unless they start with `raw/`, `protocol/`, `index/` or `docs/`. `CM` = `core_module/scripts`, `M11` = `m11/scripts`.
- Opcode names come from `protocol/opcodes.csv`. Proto fields come from `protocol/proto.json`; tags checked against the AS3 `writeTo` (`CM/com/road/yishi/proto/player/ArtifactMsg.as`, `ResonatePosMsg.as`).
- *(assumption)* marks anything the client does not prove.
- No HTTP servlet or AMF call is used by this module.

---

## 1. Overview

- **Where.** Main frame "Arma Divina", third tab (`ancientartifact.resonateBtn`, shown because `VersionSwitch.ARMORY_AND_RESONATE_SHOW = true`, `CM/yishi/datas/VersionSwitch.as:88`), sub-tab 0 of `AncientArmoryView` (the emblem equip page, `M11/ancientartifact/view/AncientArmoryView.as:83-88`).
- **Layout.** Six `AncientResonateItem` around the host: positions 1..5 are the resonance slots; position 6 is the host itself (icon only, no add image, no upgrade button, no click events, `M11/ancientartifact/view/item/AncientResonateItem.as:55-59, 75-79`; `M11/ancientartifact/view/AncientArmoryEquipView.as:151-183`).
- **Link.** Clicking slot 1..5 opens a drop-down `AcnientCheckList` with "remove" (when the slot is filled) and every owned artifact that is not the host and not already linked in another slot of this host (`M11/ancientartifact/view/AcnientCheckList.as:56-94`). Picking an entry sends op 6.
- **Inheritance per position** (`AncientResonateItem.as:194-215`; texts `ancientartifact.AncientAdvanceFrame.resonateAddTips01..05`):

| Pos | Inherited stat(s) of the linked artifact | pt-BR tip |
|---|---|---|
| 1 | ATQ and MAG | "Herdar ATQ duplo {0}%" |
| 2 | DEF and RES | "Herdar DFS dupla {0}%" |
| 3 | Bloqueio | "Herdar Bloqueio {0}%" |
| 4 | Penetração | "Herdar Penetração {0}%" |
| 5 | Vida | "Herdar Vida {0}%" |

- **Upgrade.** Each position has a level 0..5 and cumulative GP; "Fortalecer Ressonância" spends "Cristal de Ressonância" (6260002) to add GP.

---

## 2. Screens

| Class (file) | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `ancientartifact.view.item.AncientResonateItem` (`M11/.../view/item/AncientResonateItem.as`), 6 instances in `AncientArmoryEquipView` | none (tips "Clique para adicionar a arma divina de ressonância." `AncientResonateItem.selectBtn.tipdata`; "Fortalecer o slot de ressonância" `ancientartifact.resonateUpGrade.tipdata`, :84-85) | Slot widget | Tab 2, sub-tab 0 | Linked artifact icon; tip with the inherited values `floor(stat * pct/100 * addPer/100)` ("ATQ:{0}", "MAG:{0}", "DEF:{0}", "RES:{0}", "Bloqueio:{0}", "Penetração:{0}", "Vida:{0}", `resonateTxt01..07`); text "Herdar ... {pct}%" where pct = UpGrade 137 ActiveObject of the position level, or 0 when the position has no record (:168-229) |
| `ancientartifact.view.AcnientCheckList` + `AcnientCheckListItem` (`M11/.../view/AcnientCheckList.as`, `.../item/AcnientCheckListItem.as`) | none | Pick or remove the linked artifact | Click on a slot 1..5 while the host is owned (`AncientResonateItem.as:102-124`) | Remove entry (id 0) plus candidate artifacts; each item previews the inherited value using the position level (`AcnientCheckListItem.as:72`) |
| `ancientartifact.AncientResonateUpGradeFrame` (`M11/ancientartifact/AncientResonateUpGradeFrame.as`), openType 3 | "Fortalecer Ressonância" (`ancientartifact.AncientAdvanceUpGradeFrame.resonateTitle`, :72) | Upgrade one position | Upgrade button of a slot 1..5 (`AncientResonateItem.as:132-142`, `openControllerByInfo("ancientartifact",3,resonateInfo)`; controller `CM/mvc/controler/AncientArtifactControler.as:50-53`) | Current and next "Herdar ... {pct}%" (`.../item/AncientResonateUpGradeItem.as:57-78`); GP bar `(posGp - Data(g)) / (Data(g+1) - Data(g))` or "Nível Máximo" (:102-135); owned 6260002 count; count input clamped to 1..owned (:151-162); material tip from item 6260002 (:95-99) |

Related tips: "Ainda não equipou a arma divina de ressonância, não é possível fortalecer" (`resonateTips03`), "Nível Máximo" (`resonateTips04`), "Favor preparar a arma divina de ressonância deste lugar" (`armoryEquipTips03`, emblem slot locked).

---

## 3. Routes (client to server)

Both routes use **9649 (0x25b1) C_ARTIFACT_OP**, `player.ArtifactMsg`, through `AncientArtifactManager.OperateArtifactReq` (`CM/yishi/manager/AncientArtifactManager.as:332-351`). All scalar fields are always sent (see [artifacts.md](artifacts.md) §3 for the full field table: `op #1`, `templateId #2`, `count #3`, `isEquip #4`, `armoryId #6`, `pos #7`, `consumeArmoryIds #10`).

| # | UI control | Client sender (file:line) | Client checks, in order | Request | Expected response |
|---|---|---|---|---|---|
| R1 | Pick an artifact in the slot drop-down | `AcnientCheckList.__onClickHander` (`M11/.../view/AcnientCheckList.as:96-105`) | Host must be owned to open the list (`AncientResonateItem.as:104-108`); candidates exclude the host and artifacts already linked to this host's 5 slots (`AcnientCheckList.as:63-92`). No check that the candidate is linked to **another** host | `{op=6 RESON_EQUIP, templateId=host TemplateId, count=0, isEquip=false, pos=1..5, armoryId=linked artifact TemplateId}` (note: `armoryId` carries an artifact TemplateId here) | **438** with the host row (new `slotedEquipPosN`); **458** if a position record was created *(assumption, see §5)* |
| R2 | "Remove" entry (id 0) in the drop-down | same (:73-79, 103) | Shown only when the slot is filled | `{op=6, templateId=host, pos, armoryId=0}` | **438** with the host row (`slotedEquipPosN = 0`, and the emblem in slot N removed, see §5); **455/456** if an emblem was unequipped *(assumption)* |
| R3 | Upgrade button in "Fortalecer Ressonância" | `AncientResonateUpGradeFrame.__upGradeOnClick` (`M11/ancientartifact/AncientResonateUpGradeFrame.as:164-175`) | 1. The frame opens only if the position has a `ResonatePosMsg` record, else tip `resonateTips03` (`AncientResonateItem.as:132-140`); 2. next level exists in UpGrade 137, else "Nível Máximo" (:167-173). Count clamped to 1..owned on change only, so 1 can be sent with 0 crystals | `{op=7 RESON_UPGRADE, templateId=0, count, isEquip=false, pos=1..5, armoryId=0}` | Bag push for 6260002 (inventory area); **458** with the updated positions (the frame listens to `RESONATE_INFO_UP_DATA` and re-reads its position, :142-149) |

---

## 4. Server messages (server to client)

| Opcode | Name | Message | Client receiver (file:line) | When to send | Client effect |
|---|---|---|---|---|---|
| 458 (0x01ca) | U_C_RESONT_POS | `player.ArtifactMsg`, only `resonatePos (#11, ResonatePosMsg, repeated)` is read | `AncientArtifactManager.__artifactResonatePosInfoHandler` (`CM/yishi/manager/AncientArtifactManager.as:89, 92-114`) | Response to op 1 (after 438/455), after op 7, and whenever a position record is created | **Replaces** the whole list (`resonatePosList = []`), so always send all known positions. Fires `RESONATE_INFO_UP_DATA` (emblem equip page, upgrade frame) |
| 438 (0x01b6) | U_C_ARTIFACTINFO | `ArtifactMsg.infos (#5)`; this module changes `slotedEquipPos1..5 (#15..#19)` and, indirectly, `armoryEquipPos1..5 (#20..#24)` and `suitSkill (#26)` | `AncientArtifactManager.__artifactInfoHandler` (:238-288) | After op 6 | Upsert of the host; the emblem page recomputes locks and bonuses |

`ResonatePosMsg` (`protocol/proto.json`, `CM/com/road/yishi/proto/player/ResonatePosMsg.as`):

| Field | Tag | Type | Meaning |
|---|---|---|---|
| pos | 1 | INT32 | position 1..5 |
| posGp | 2 | INT32 | cumulative GP of the position |
| posGrades | 3 | INT32 | position level 0..5 |

`AncientResonateInfo.equipArtifactId` is never filled by the handler (always 0), so `AncientArtifactModel.getIsEquipResonateByPos` and `getResonateInfoByEquipId` are dead code (`CM/mvc/module/ancientartifact/AncientArtifactModel.as:74-90, 158-174`).

No result codes exist; failures are silent.

---

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Positions | 1..5 per host; pos 6 is the host and has no route | `AncientResonateItem.as:55-59`; `AncientArmoryEquipView.as:151-183` |
| Linked artifact | owned, not the host, not already linked in another position of the same host. Linking the same artifact to several hosts is allowed by the client *(open question for the server)* | `AcnientCheckList.as:63-92` |
| Position level and GP scope | per player and position, not per host (`ResonatePosMsg` has no host key) | `AncientArtifactManager.as:92-114` |
| Level table | `UpGradeTempInfos` Types 137, Grades 0..5. `Data` = cumulative GP: 0, 100, 300, 700, 1500, 3100. `ActiveObject` = inherit %: 0, 10, 20, 35, 50, 70 | `raw/xml/tempinfos/UpGradeTempInfos.xml` 13700000..13700005; `AncientResonateUpGradeFrame.as:105-127` |
| Level-up | `posGrades += 1` while `posGp >= Data(posGrades+1)`; max 5 (no row 6) | `AncientResonateUpGradeFrame.as:109-119, 167-173` |
| Material | "Cristal de Ressonância" 6260002 ("Pode ser utilizada para fortalecer slots de ressonância de Arma Divina...") | `AncientResonateUpGradeFrame.as:95, 116, 130` |
| GP per crystal | 1 *(assumption: the item has no `Property1`; 3100 crystals to max one position)* | `ItemTempInfos.xml` 6260002 |
| Position record existence | the client allows the upgrade only when a record exists for the position. *(assumption: the server creates the record, level 0 and GP 0, the first time the player links any artifact into that position; it is never deleted)* | `AncientResonateItem.as:132-140`; tip `resonateTips03` |
| Host bonus (attribute panel) | for pos with a linked artifact L: `floor(pct * L.stat / 100 * L.addPer / 100)` added to the host stat(s) of the table in §1 | `M11/ancientartifact/view/AncientPropertyView.as:252-294`; same in `CM/yishi/view/tips/goods/ArtifactEquipTip.as:270-343` |
| Host bonus (fight power) | same without the `L.addPer/100` factor (client quirk) | `M11/ancientartifact/view/AncientMiddleView.as:279-319` |
| Emblem slot unlock | emblem slot N (1..5) is locked unless `host.slotedEquipPosN > 0`; slot 6 is unlocked when the host is owned | `AncientArmoryEquipView.as:159-182, 230-244` |
| Unlinking with an emblem in the slot | *(assumption: the server unequips the emblem of the same position, because the client would show an emblem in a locked slot)* | none |

---

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `raw/xml/tempinfos/UpGradeTempInfos.xml` Types 137 | resonance position level | `Grades` 0..5; `Data` cumulative GP; `ActiveObject` inherit percent |
| `raw/xml/tempinfos/ItemTempInfos.xml` | 6260002 "Cristal de Ressonância" | name and description for the tip |
| `raw/xml/tempinfos/ArtifactTemplateInfos.xml` | linked artifact | `Icon` |

---

## 7. Persistent state (PostgreSQL, schema `divine_weapon`)

```sql
-- Per player, per position level and GP (shared by all hosts).
CREATE TABLE divine_weapon.resonance_positions (
    player_id   BIGINT      NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
    pos         SMALLINT    NOT NULL CHECK (pos BETWEEN 1 AND 5),
    grade       SMALLINT    NOT NULL DEFAULT 0 CHECK (grade BETWEEN 0 AND 5),
    gp          INTEGER     NOT NULL DEFAULT 0 CHECK (gp >= 0),
    created_at  TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at  TIMESTAMPTZ NOT NULL DEFAULT now(),
    PRIMARY KEY (player_id, pos)
);

-- Which artifact is linked into each position of each host.
CREATE TABLE divine_weapon.resonance_links (
    player_id            BIGINT   NOT NULL,
    host_template_id     INTEGER  NOT NULL,
    pos                  SMALLINT NOT NULL CHECK (pos BETWEEN 1 AND 5),
    linked_template_id   INTEGER  NOT NULL,
    linked_at            TIMESTAMPTZ NOT NULL DEFAULT now(),
    PRIMARY KEY (player_id, host_template_id, pos),
    UNIQUE (player_id, host_template_id, linked_template_id),
    CHECK (linked_template_id <> host_template_id),
    FOREIGN KEY (player_id, host_template_id)
        REFERENCES divine_weapon.artifacts (player_id, template_id) ON DELETE CASCADE,
    FOREIGN KEY (player_id, linked_template_id)
        REFERENCES divine_weapon.artifacts (player_id, template_id) ON DELETE CASCADE
);
CREATE INDEX resonance_links_linked ON divine_weapon.resonance_links (player_id, linked_template_id);
```

`slotedEquipPos1..5` of 438 are built from `resonance_links`.

---

## 8. Backend implementation notes

| Handler | Op | Validation order | Transaction | Pushes |
|---|---|---|---|---|
| `divine_weapon::resonance::handle_link` | 6 | feature unlocked; host owned; `pos` in 1..5; if `armoryId > 0`: linked artifact owned, not the host, not already linked to another position of this host; if `armoryId == 0`: slot filled | one transaction: upsert or delete the link; on removal (or on replacement, *(assumption)* keep the emblem when replacing) unequip the emblem in emblem slot `pos` of the host; create `resonance_positions(pos)` if missing | 438 (host), 458 when a position record was created, 456 for an unequipped emblem (`isEquip=false`) |
| `divine_weapon::resonance::handle_upgrade` | 7 | feature unlocked; `pos` in 1..5; position record exists; `grade < 5`; `count >= 1`; bag holds `count` x 6260002 | one transaction: consume, `gp += count * 1`, level-up loop on cumulative `Data` *(assumption: cap `count` so no crystal is wasted past level 5)* | bag update, 458 (all positions), hero attribute refresh when the change affects the equipped host *(assumption)* |

Op 1 (OPEN, [artifacts.md](artifacts.md)) must send 458 with every existing position. Bonus computation for the hero stat aggregation uses the §5 attribute-panel formula. No timers, no battles.

---

## 9. Open questions and assumptions

1. *(assumption)* When the position record is created (first link vs feature unlock). If records exist from the start, the "Ainda não equipou..." tip never shows; if they never exist, the upgrade frame cannot open.
2. *(assumption)* GP per crystal is 1.
3. Can one artifact be linked to several hosts at once? The client allows it. The server rule is unknown.
4. *(assumption)* Unlinking or replacing a resonance artifact unequips the emblem of the same position.
5. Does resonance add to the hero only for the equipped host? *(assumption: yes, only the equipped artifact contributes to the hero)*.
6. The fight power and attribute panel use different bonus formulas (with and without `L.addPer`); the server should pick the attribute-panel one for stats.

---

## 10. Implementation checklist

- [ ] Template loader for `UpGradeTempInfos` Types 137.
- [ ] Tables `divine_weapon.resonance_positions` and `divine_weapon.resonance_links`.
- [ ] 438 encoder fills `slotedEquipPos1..5` from links.
- [ ] 458 encoder sends all position records.
- [ ] Route R1 op 6 link (armoryId = linked TemplateId).
- [ ] Route R2 op 6 unlink (armoryId = 0) with emblem unequip side effect.
- [ ] Route R3 op 7 upgrade with cumulative thresholds and max level 5.
- [ ] Bonus calculator (per position stat mapping, pct, linked addPer) shared with the hero stat aggregation.
- [ ] Tests: link host to itself rejected; duplicate link in the same host rejected; pos 0 or 6 rejected; upgrade beyond 5 rejected; 458 always replaces the full list; emblem in a slot whose resonance is removed is unequipped.
