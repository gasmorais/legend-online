# Magic emblems ("Brasão Mágico", "Brasão da Ressonância")

Feature `divine-weapon`, module `emblems` (client name "armory"). Emblems are stat items that live in their own emblem bag (not the normal bag). The player equips up to 6 emblems on each artifact (host), engraves ("gravar", seal level) them with "Pedra de Gravação de Brasões Mágicos", advances their quality by fusing copies with "Pedra de Avanço de Brasões", and decomposes ("Decompor") unwanted ones back into engraving stones. Two emblems of the same kind on one host activate a 2-piece suit skill.

Conventions:
- Paths are relative to `decompiled/` unless they start with `raw/`, `protocol/`, `index/` or `docs/`. `CM` = `core_module/scripts`, `M11` = `m11/scripts`.
- Opcode names come from `protocol/opcodes.csv`. Proto fields come from `protocol/proto.json`; tags checked against the AS3 `writeTo` (`CM/com/road/yishi/proto/player/ArtifactMsg.as`, `ArmoryInfoMsg.as`).
- *(assumption)* marks anything the client does not prove.
- No HTTP servlet or AMF call is used by this module.

---

## 1. Overview

- **Kinds.** `raw/xml/tempinfos/ArftiArmoryTemplateInfos.xml` has 30 rows = 6 kinds x 5 qualities (`Profile` 1 Verde, 2 Azul, 3 Roxo, 4 Laranja, 5 Vermelho; texts `ancientartifact.AncientAdvanceFrame.armoryTips01..05`). Kinds: 101 "Alma de Tigre", 102 "Alma de Lobo", 103 "Alma de Cervo", 104 "Alma de Rato", 105 "Alma de Urso", 106 "Alma de Falcão" (TemplateName "Brasão Mágico - Alma de Tigre(Verde)" etc.). Icon `icon/armory_{TemplateId}_{Profile}.png` (`CM/yishi/utils/IconFactory.as:282-285`).
- **Where.** Main frame "Arma Divina", third tab `AncientArmoryView` (`M11/ancientartifact/AncientArtifactFrame.as:120-125`), title "Brasão da Ressonância" (`armoryTitle`). Four image sub-tabs (`M11/ancientartifact/view/AncientArmoryView.as:45-108`):
  - 0 equip (`AncientArmoryEquipView`, title "Já ativou os equipamentos do brasão"), together with the resonance slots ([resonance.md](resonance.md));
  - 1 engrave (`AncientArmoryMarkView`);
  - 2 advance (`AncientArmoryGradeView`);
  - 3 decompose (`AcnientArmoryDeleteView`).
  Each page shares the emblem bag `AncientArmoryBagView` on the side.
- **Obtaining emblems.** Using an emblem item 6261tp (SonType 626 `ANCIENT_ARMORY_STONE`, "Após o uso, poderá obter uma Brasão Mágico - ...") from the normal bag creates the emblem (`CM/bag/datas/GoodsSonType.as:264`; usable per `CM/bag/helper/BagHelper.as:76, 129`). The item id equals the template's `NeedActiveTempId` (6261011 = Tigre Verde ... 6261065 = Falcão Vermelho).
- **Slots.** 6 emblem slots per host. Slot N (1..5) is unlocked only when resonance position N of the host holds an artifact; slot 6 when the host is owned ([resonance.md](resonance.md) §5).
- **Suit.** 2 emblems of the same kind on one host activate the kind's suit (SuiteTempInfos 606..611, 2-piece); the bonus skill grade follows the **lowest** quality of the pair ("Obs.:O nível da habiliade do equipamento é conforme a qualidade mais baixa do brasão equipado.", `armoryEquipTips01`).

---

## 2. Screens

| Class (file) | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `ancientartifact.view.AncientArmoryView` (`M11/.../view/AncientArmoryView.as`) | "Brasão da Ressonância" | Container with 4 sub-tabs and the emblem bag | Tab 2 of the main frame | Sets `model.currentArmoryIndx` 0..3 and resets selection on tab change (:74-108) |
| `ancientartifact.view.AncientArmoryBagView` (`M11/.../view/AncientArmoryBagView.as`) | none | Emblem bag | All sub-tabs | `AncientBagCell` grid: 16 cells on sub-tab 0, 32 on the others, grows in rows of 4 (:43-61, 129-164). Lists emblems **not equipped on the selected host** and not picked; on sub-tab 2 only max-seal emblems (and, once a main is picked, of the same kind and quality). Sorted by profile then TemplateId, descending (:166-246) |
| `ancientartifact.view.AncientArmoryEquipView` (`M11/.../view/AncientArmoryEquipView.as`) | "Já ativou os equipamentos do brasão" | Equip page | Sub-tab 0 | 6 `AncientEquipArmoryItem` slots in order 6,1,2,3,4,5 (`posList`, :64, 102-118) with lock overlay (:230-244); suit skill descriptions from `suitSkill` (:211-227); tip `armoryEquipTips01` |
| `ancientartifact.view.AncientArmoryMarkView` (`M11/.../view/AncientArmoryMarkView.as`) | "Nível do Selo {0}" in tips (`armoryMarkTips`) | Engrave (seal level up) | Sub-tab 1 | Picked emblem; GP bar `gp/Data` or "Nível Máximo"; current / next / max attribute blocks "Atributos atuais", "Atributos de nv. máx." (`AncientArmoryMarkItem`, `M11/.../view/item/AncientArmoryMarkItem.as:56-95`); owned 6260001; count input 1..owned (:114-188) |
| `ancientartifact.view.AncientArmoryGradeView` (`M11/.../view/AncientArmoryGradeView.as`) | tip "É necessário o nível completo do selo para elevar o brasão" (`armoryGradesTips05`) | Advance quality | Sub-tab 2 | Picked main emblem, current and next quality blocks (or max), up to 4 material slots (`ComposeNeedCount`), needed 6260003 (`AdvanceNeedCount`) and owned count (:144-229) |
| `ancientartifact.view.AcnientArmoryDeleteView` (`M11/.../view/AcnientArmoryDeleteView.as`) | button text "Decompor" (`cell.view.ArmoryGoodsItemMenu.delete`) | Decompose | Sub-tab 3 | 12 picked slots; output preview 6260001 x total (:49-120) |
| `ancientartifact.ArmoryDeleteAlertFrame` | message only | Confirmations with a "Não alertar mais" (`yishi.view.base.ThewAlertFrame.text`) checkbox, suppressed for the rest of the day via `SharedManager` | Advance with equipped emblems; decompose of purple or better | `armoryGradesTips06`, `armoryDeleteTips02` |

`ancientartifact.view.ArmoryGoodsItemMenu` is dead UI: `AncientBagCellClickMediator.showUseMenu` is never called (`M11/ancientartifact/mediator/AncientBagCellClickMediator.as:195-201`); the menu only contains copied bag-use code.

---

## 3. Routes (client to server)

All routes use **9649 (0x25b1) C_ARTIFACT_OP**, `player.ArtifactMsg`, via `AncientArtifactManager.OperateArtifactReq` (`CM/yishi/manager/AncientArtifactManager.as:332-351`). All scalars are always sent; `consumeArmoryIds (#10, INT32, repeated)` is set only for ops 10 and 12 (:342-349). Full field table in [artifacts.md](artifacts.md) §3.

| # | UI control | Client sender (file:line) | Client checks, in order | Request | Expected response |
|---|---|---|---|---|---|
| E1 | Double-click an emblem in the bag (sub-tab 0) | `AncientBagCellClickMediator.__mouseDoubleClick` (`M11/ancientartifact/mediator/AncientBagCellClickMediator.as:70-88`) | Host owned and a free unlocked slot exists, searched in order 6,1,2,3,4,5 (slot free if `armoryEquipPosN == 0` or the id is unknown; unlocked if N == 6 or `slotedEquipPosN > 0`, :239-272); else "Slot do brasão ocupado" (`resonateTips02`) | `{op=8 ARMORY_EQUIP, templateId=host, pos=slot, armoryId=emblem id}` | **438** host row (`armoryEquipPosN`, `suitSkill`); **456** for the emblem (`isEquip=true`) and for any emblem it replaced (`isEquip=false`) *(assumption)* |
| E2 | Drag an emblem from the bag onto a slot (sub-tab 0) | `AncientBagCellDropMediator` drop handler (`M11/ancientartifact/mediator/AncientBagCellDropMediator.as:119-136`) | Slot locked: "Favor preparar a arma divina de ressonância deste lugar" (`armoryEquipTips03`) | same as E1 with `pos` = target slot | same as E1 |
| E3 | Double-click an equipped slot, or drag it back to the bag | `ArmoryEquipItemCellClickMediator.__mouseDoubleClick` (`M11/ancientartifact/mediator/ArmoryEquipItemCellClickMediator.as:57-69`); `ArmoryEquipItemCellDropMediator` (`.../ArmoryEquipItemCellDropMediator.as:83-90`); also `ArmoryItemCellClickMediator` (:58-70) and `ArmoryItemCellDropMediator` (:103-110) when on sub-tab 0 | none | `{op=8, templateId=host, pos=slot, armoryId=0}` | **438** host row; **456** emblem `isEquip=false` |
| E4 | Engrave button (sub-tab 1) | `AncientArmoryMarkView.__onClick` (`M11/.../view/AncientArmoryMarkView.as:190-196`) | An emblem is picked (double-click or drag from the bag, `AncientBagCellClickMediator.as:89-94`; `AncientBagCellDropMediator.as:165-174`); button enabled only when the next seal level exists (:147-165); count clamped 1..owned on change (:177-188), so 1 can be sent with 0 stones | `{op=9 ARMORY_UPGRADE, templateId=0, count, pos=0, armoryId=emblem id}` | Bag push for 6260001; **456** with the emblem (new `gp`, `grades`, stats). The client then re-dispatches the pick so the page refreshes (`AncientArtifactManager.as:169-174`); **438** for the host if the emblem is equipped *(assumption)* |
| E5 | Advance button (sub-tab 2) | `AncientArmoryGradeView.__onClick` (`M11/.../view/AncientArmoryGradeView.as:269-301`), possibly through the confirmation (:303-335) | 1. a main emblem is picked, else "Favor colocar o brasão de avanço" (`armoryGradesTips01`); picking requires max seal, else "Favor colocar o brasão com selos máximos." (`AncientBagCellClickMediator.as:97-109`); 2. a template exists for `profile+1`, else `armoryGradesTips02`; 3. `chooseList.length >= ComposeNeedCount` of the **current** profile row, else "Materiais insuficientes" (`armoryGradesTips03`) (see the mismatch in §5); 4. materials must have the same kind and quality as the main, else "Este brasão não é possível efetuar o avanço" (`armoryGradesTips04`), and are capped at `ComposeNeedCount` of the **next** row (`AncientBagCellClickMediator.as:111-120, 214-226`); 5. if any picked emblem is equipped on any host, confirm "Há brasões equipados na arma divina, deseja avançar?" (`armoryGradesTips06`, :337-367). No check of 6260003 | `{op=10 ARMORY_ADVANCE, templateId=0, count=0, pos=0, armoryId=main id, consumeArmoryIds=[material ids]}` | Bag push for 6260003; **456**: main emblem upserted (profile+1, grades 0), materials with `isExist=false`. Because `chooseId` matches and the tab is 2, the client resets the page (`AncientArtifactManager.as:175-181`). **438** for any host that lost an equipped material *(assumption)* |
| E6 | "Decompor" button (sub-tab 3) | `AcnientArmoryDeleteView.__onClick` (`M11/.../view/AcnientArmoryDeleteView.as:122-134`) | List not empty, else "Não há lista de decomposição, não é possível decompor" (`armoryDeleteTips01`). Picking: max 12, else "Mochila de decomposição cheia, ..." (`armoryDeleteTips03`); profile > 2 asks "Este brasão é de qualidade roxa ou superior, deseja decompor?" (`armoryDeleteTips02`) (`AncientBagCellClickMediator.as:123-193`; `AncientBagCellDropMediator.as:137-163`). Candidates exclude emblems equipped on the selected host only | `{op=12 ARMORY_RESOLVE, templateId=0, count=0, pos=0, armoryId=0, consumeArmoryIds=[ids]}` | **456** with each id `isExist=false` (the client also removes them from the pick list and refreshes sub-tab 3, `AncientArtifactManager.as:139-148, 187-190`); bag push adding 6260001 |
| E7 | Use an emblem item from the normal bag | generic bag use **5006 (0x138e) U_C_BAG_USEITEM** (`CM/yishi/service/managers/SocketSendManager.as:157-167`) | inventory area | `ItemUseMsg` (inventory area) | Bag push consuming the item; **456** with the new emblem *(assumption)*. Owned by [../inventory/README.md](../inventory/README.md), which must call this module's create service |
| E8 | (dead) op 11 ARMORY_SALE | constant only (`AncientArtifactManager.as:46`); no sender | none | none | Not needed |
| E9 | Pick/unpick in sub-tabs 1-3, sub-tab switch | client only (`ArmoryItemCellClickMediator.as:71-100`, `ArmoryEquipItemCellClickMediator.as:70-79`) | none | none | none |

---

## 4. Server messages (server to client)

| Opcode | Name | Message | Client receiver (file:line) | When to send | Client effect |
|---|---|---|---|---|---|
| 455 (0x01c7) | U_C_ARMORY_LIST | `player.ArtifactMsg`, only `armoryInfo (#8, ArmoryInfoMsg, repeated)` | `AncientArtifactManager.__armoryGoodsInfoHandler` (`CM/yishi/manager/AncientArtifactManager.as:86, 193-236`) | Response to op 1 (full emblem bag) | **Replaces** the list; entries with `isExist=false` are skipped. Fires `ARMORY_BAG_UP_DATA` |
| 456 (0x01c8) | U_C_ARMORY_UPDATE | same message, delta | `__armoryGoodsUpdataHandler` (:87, 120-191) | After ops 8, 9, 10, 12 and emblem creation | `isExist=false`: delete (and drop from the pick list); otherwise upsert. If the updated id is the picked one: sub-tab 1 refreshes the page, sub-tab 2 clears the pick. Fires `ARMORY_BAG_UP_DATA` |
| 457 (0x01c9) | U_C_ARMORY_POS | none read (handler body is empty, :88, 116-118); `ArmoryPosMsg{pos #1, ArmoryId #2}` exists in `protocol/proto.json` and `AncientArtifactModel.armoryPosList` is never filled | `__artifactArmoryPosInfoHandler` | Never required | none |
| 438 (0x01b6) | U_C_ARTIFACTINFO | `ArtifactMsg.infos (#5)`: this module changes `armoryEquipPos1..6 (#20..#25)` and `suitSkill (#26, STRING)` | `__artifactInfoHandler` (:238-288) | After op 8 and whenever an equipped emblem changes or disappears | Host upsert; equip page, bonuses and suit text refresh |

`ArmoryInfoMsg` (`protocol/proto.json`; tags checked in `CM/com/road/yishi/proto/player/ArmoryInfoMsg.as`):

| Field | Tag | Type | Meaning |
|---|---|---|---|
| armoryId | 1 | INT32 | emblem instance id |
| templateId | 2 | INT32 | kind 101..106 |
| profile | 3 | INT32 | quality 1..5 |
| attacks | 4 | INT32 | ATQ = `Attacks + AttackAdd * grades` (the client adds it to both ATQ and MAG, see §5) |
| phyDefence | 5 | INT32 | DEF = `PhyDefence + PhyDefenceAdd * grades` |
| magicDefence | 6 | INT32 | RES = `MagicDefence + MagicDefenceAdd * grades` |
| live | 7 | INT32 | Vida = `Live + LiveAdd * grades` |
| parry | 8 | INT32 | Bloqueio = `Parry + ParryAdd * grades` |
| penetrate | 9 | INT32 | Penetração = `Penetrate + PenetrateAdd * grades` |
| gp | 10 | INT32 | engraving GP inside the current seal level |
| grades | 11 | INT32 | seal level 0..5 |
| isEquip | 12 | BOOL | equipped on some host |
| isExist | 13 | BOOL | false = deleted (456 only) |

Stat formulas are from the display code (`M11/.../view/item/AncientArmoryMarkItem.as:79-95`); the client reads the sent values directly for bonuses (`M11/ancientartifact/view/AncientPropertyView.as:236-251`), so the server must send the computed totals *(assumption: the original sent totals)*.

No result codes; failures are silent.

---

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Slots per host | 6; slot N in 1..5 needs resonance link N; slot 6 needs the host owned | `AncientArmoryEquipView.as:151-183` |
| Auto slot order (double-click) | 6, 1, 2, 3, 4, 5 | `AncientBagCellClickMediator.as:250` |
| One emblem, one host | *(assumption: an emblem can be equipped on one host only; equipping it on another host moves it, because the bag of a host still lists emblems equipped elsewhere)* | `AncientArmoryBagView.as:248-268` |
| Host bonus | sum over the 6 slots: ATQ += attacks, DEF += phyDefence, MAG += attacks (client quirk, the message has no magic attack), RES += magicDefence, Penetração += penetrate, Bloqueio += parry, Vida += live; not multiplied by `addPer` | `AncientPropertyView.as:236-251`; `AncientMiddleView.as:263-278` |
| Seal (engrave) material | "Pedra de Gravação de Brasões Mágicos" 6260001 | `AncientArmoryMarkView.as:99, 117` |
| Seal levels | 0..5. GP needed for level g+1 = `UpGradeTempInfos` Types 138 row `TemplateId = profile`, `Grades = g+1`, `Data`: 50*profile*(g+1) (e.g. Verde 50, 100, 150, 200, 250; Vermelho 250 .. 1250). The bar shows `gp / Data`, so `gp` is per level *(assumption: resets on level-up with carry-over)* | `AncientArmoryMarkView.as:147-171`; `raw/xml/tempinfos/UpGradeTempInfos.xml` 13800101..13800506 |
| GP per stone | 1 *(assumption: the item has no `Property1`)* | `ItemTempInfos.xml` 6260001 |
| Stats per seal level | `base + Add * grades` per stat (example: Tigre Vermelho ATQ 165600 + 3000 * grades) | `AncientArmoryMarkItem.as:79-95` |
| Advance preconditions | main at max seal (no Types 138 row for `grades+1`), `profile < 5` | `AncientBagCellClickMediator.as:97-109, 228-237`; `AncientArmoryGradeView.as:280-287` |
| Advance materials | other emblems of the same kind and quality, each at max seal; count = `ComposeNeedCount` of the **next** quality row: to Azul 1, to Roxo 2, to Laranja 3, to Vermelho 3. The click check uses the **current** row (0, 1, 2, 3), a client inconsistency; the server should require the next-row value *(assumption)* | `AncientArmoryGradeView.as:186-229, 288-294`; `AncientBagCellClickMediator.as:214-226`; `ArftiArmoryTemplateInfos.xml` |
| Advance cost | `AdvanceNeedCount` of the next quality row x 6260003 "Pedra de Avanço de Brasões": 200, 500, 1000, 2000 | `AncientArmoryGradeView.as:197-198` |
| Advance result | main: profile+1, grades 0 (the preview copies `gp`, *(assumption: gp reset to 0)*), stats recomputed; materials deleted (unequipped from their hosts first) | `AncientArmoryGradeView.as:231-248` |
| Equipped warning bug | `isHasEquipArmory` uses `indexOf(...) > 0`, so an equipped emblem in position 0 of the pick array is not detected | `AncientArmoryGradeView.as:343-359` |
| Decompose limit | at most 12 per request | `AncientBagCellClickMediator.as:129, 144`; `AcnientArmoryDeleteView.as:68` |
| Decompose output | 6260001 x Σ(`ResolvedCount` + `grades` x `ResolvedRate`); ResolvedCount 5/10/15/20/25 by quality, ResolvedRate 0 in every row | `AcnientArmoryDeleteView.as:97-118` |
| Decompose of equipped emblems | *(assumption: reject ids with `isEquip=true`; the client can list emblems equipped on other hosts)* | `AncientArmoryBagView.as:186-189, 248-268` |
| Emblem creation | item 6261tp (Property1 = kind, NeedActiveTempId match = quality) creates `{templateId, profile, grades 0, gp 0}` with base stats | `ItemTempInfos.xml`; `ArftiArmoryTemplateInfos.xml` `NeedActiveTempId` |
| Suit | 2 emblems with the same TemplateId on one host activate `SuiteTempInfos` `SuiteId` (606 Tigre .. 611 Águia, Template1 = Template2 = kind); `Property1..5` = skill per quality (= `NeedActiveTempId`); the active one is the lower quality of the pair. Effects: Tigre crítico +1..5%, Lobo dano crítico +1..5%, Cervo dano recebido -1..5%, Rato bloqueio +1..5%, Urso dano causado +1..5%, Falcão 20% de chance de recuperar 1..5% de vida (`Desc`). `suitSkill` = CSV of active SkillTempInfos ids (e.g. "6261013") | `raw/xml/tempinfos/SuiteTempInfos.xml` 606..611; `SkillTempInfos.xml` 6261011..; `AncientArmoryEquipView.as:211-227`; `armoryEquipTips01` |
| `MaxCount` = 6 | meaning unknown *(open question: maybe max emblems per host or max of one kind)* | `ArftiArmoryTemplateInfos.xml` |

---

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `raw/xml/tempinfos/ArftiArmoryTemplateInfos.xml` (`TempleteManager.armoryTempCate`, `CM/yishi/manager/TempleteManager.as:1253`; lookup by `TemplateId + Profile`, `CM/yishi/datas/templates/cate/ArmoryTempCate.as:19-40`; class `ArmoryTemplateInfo.as`) | one per kind and quality | `TemplateId` kind; `TemplateName`; `Profile` quality; `SuiteId`; base stats `Attacks, PhyDefence, MagicDefence, Live, Parry, Penetrate`; per-seal-level adds `*Add`; `NeedActiveTempId` item id and suit skill id; `ResolvedCount`, `ResolvedRate` decomposition; `MaxCount` (unknown); `ComposeNeedCount` materials to reach this quality; `AdvanceNeedCount` 6260003 to reach this quality; `Desc` suit text |
| `raw/xml/tempinfos/UpGradeTempInfos.xml` Types 138 | seal level | `TemplateId` = profile, `Grades` = seal level, `Data` = GP needed |
| `raw/xml/tempinfos/SuiteTempInfos.xml` 606..611 | 2-piece suit | `Template1`, `Template2` kind; `Property1..5` skill per quality |
| `raw/xml/tempinfos/SkillTempInfos.xml` 6261011..6261065 | suit skills | `Description` (shown), `BufferIds` |
| `raw/xml/tempinfos/ItemTempInfos.xml` | materials and emblem items | 6260001 engraving stone, 6260003 advance stone, 6261011..6261065 emblem items (SonType 626, NeedGrades 80) |

---

## 7. Persistent state (PostgreSQL, schema `divine_weapon`)

```sql
-- Emblem instances (the emblem bag). armoryId is INT32 on the wire.
CREATE TABLE divine_weapon.emblems (
    emblem_id    INTEGER     GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    player_id    BIGINT      NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
    template_id  INTEGER     NOT NULL CHECK (template_id BETWEEN 101 AND 106),
    profile      SMALLINT    NOT NULL CHECK (profile BETWEEN 1 AND 5),
    grade        SMALLINT    NOT NULL DEFAULT 0 CHECK (grade BETWEEN 0 AND 5),
    gp           INTEGER     NOT NULL DEFAULT 0 CHECK (gp >= 0),
    source       TEXT        NOT NULL DEFAULT 'item',     -- item, advance (audit only)
    created_at   TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at   TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX emblems_player ON divine_weapon.emblems (player_id);

-- Emblems equipped on a host artifact.
CREATE TABLE divine_weapon.artifact_emblem_slots (
    player_id         BIGINT   NOT NULL,
    host_template_id  INTEGER  NOT NULL,
    slot              SMALLINT NOT NULL CHECK (slot BETWEEN 1 AND 6),
    emblem_id         INTEGER  NOT NULL UNIQUE REFERENCES divine_weapon.emblems(emblem_id) ON DELETE CASCADE,
    equipped_at       TIMESTAMPTZ NOT NULL DEFAULT now(),
    PRIMARY KEY (player_id, host_template_id, slot),
    FOREIGN KEY (player_id, host_template_id)
        REFERENCES divine_weapon.artifacts (player_id, template_id) ON DELETE CASCADE
);
```

`isEquip` is derived from the existence of a slot row; stats and `suitSkill` are derived from templates. The `UNIQUE (emblem_id)` enforces the one-host assumption.

---

## 8. Backend implementation notes

| Handler | Op | Validation order | Transaction | Pushes |
|---|---|---|---|---|
| `divine_weapon::emblems::handle_equip` | 8 | feature unlocked; host owned; `pos` 1..6; slot unlocked (pos 6, or resonance link at pos); if `armoryId > 0`: emblem owned by the player | one transaction: `armoryId > 0`: remove the emblem from any other slot/host, replace the occupant of the target slot; `armoryId == 0`: delete the slot row | 438 for every host changed (slots and recomputed `suitSkill`), 456 for every emblem whose `isEquip` changed, hero attribute refresh if the equipped host changed |
| `divine_weapon::emblems::handle_engrave` | 9 | emblem owned; `grade < 5`; `count >= 1`; bag holds `count` x 6260001 | one transaction: consume, `gp += count`, level-up loop on Types 138 `Data` of `profile` *(assumption: cap count at what reaches level 5)* | bag update, 456, 438 for the host if equipped |
| `divine_weapon::emblems::handle_advance` | 10 | main owned, max seal, `profile < 5`; materials distinct, owned, not the main, same kind and profile, max seal; `len == ComposeNeedCount(profile+1)`; bag holds `AdvanceNeedCount(profile+1)` x 6260003 | one transaction: consume stones, unequip and delete materials, set main `profile+1, grade 0, gp 0` | bag update; 456 (main upsert + materials `isExist=false`); 438 for hosts that lost materials or hold the main |
| `divine_weapon::emblems::handle_resolve` | 12 | 1..12 distinct ids, all owned, none equipped *(assumption)* | one transaction: delete, grant 6260001 x Σ(ResolvedCount + grade x ResolvedRate) | 456 (`isExist=false` per id), bag update |
| `divine_weapon::emblems::create_from_item` | (called by inventory on 5006 for SonType 626) | item kind and quality resolvable through `NeedActiveTempId` | inside the inventory transaction | 456 with the new emblem |

`handle_open` of [artifacts.md](artifacts.md) sends 455 with all emblems (`isExist=true`). Suit computation: group the host's 6 slots by `template_id`; for each kind with 2 or more emblems, emit `SuiteTempInfos[SuiteId].Property{p}` where `p` is the lower quality of the pair *(assumption: with 3 or more of one kind only one suit counts, and the pair is the two highest-quality emblems)*. No timers, no battles.

---

## 9. Open questions and assumptions

1. *(assumption)* GP per engraving stone is 1 and seal GP is per level.
2. Advance material count: the client checks `ComposeNeedCount` of the current row but displays and caps with the next row. The server rule is unknown; the next row is the display value.
3. *(assumption)* Main emblem `gp` after advance is reset to 0.
4. *(assumption)* An emblem can be on one host only; equipping it elsewhere moves it.
5. *(assumption)* Decomposing equipped emblems is rejected.
6. Meaning of `MaxCount = 6` in `ArftiArmoryTemplateInfos`.
7. Suit rule with 3 or more emblems of one kind on a host; which pair defines the skill grade.
8. Whether emblem stats are sent as totals (base + Add x grade); the bonus code reads them directly, so totals are required for correct display.
9. 457 U_C_ARMORY_POS has no client effect; it can be omitted.

---

## 10. Implementation checklist

- [ ] Template loaders: `ArftiArmoryTemplateInfos` (key TemplateId + Profile), `UpGradeTempInfos` Types 138, `SuiteTempInfos` 606..611, items 6260001, 6260003, 6261011..6261065.
- [ ] Tables `divine_weapon.emblems` and `divine_weapon.artifact_emblem_slots`.
- [ ] Encoder for `ArmoryInfoMsg` (13 fields, computed stats) used by 455 and 456.
- [ ] 438 fields `armoryEquipPos1..6` and `suitSkill` from slots.
- [ ] Route E1/E2 op 8 equip with slot lock rule and move semantics.
- [ ] Route E3 op 8 unequip (`armoryId = 0`).
- [ ] Route E4 op 9 engrave.
- [ ] Route E5 op 10 advance with materials in `consumeArmoryIds`.
- [ ] Route E6 op 12 decompose (max 12).
- [ ] Route E7 emblem creation from SonType 626 items (inventory hook).
- [ ] Suit calculator and host bonus calculator (shared with hero stats).
- [ ] Tests: locked slot rejected; same emblem on two hosts impossible; engrave past 5 rejected; advance with wrong kind, quality, seal or count rejected; decompose output sum; 456 deletions remove equipped references; 455 replaces the whole bag.
