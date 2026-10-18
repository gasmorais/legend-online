# Divine weapons: collection, summon, equip, training and evolution ("Arma Divina")

Feature `divine-weapon`, module `artifacts`. This module owns the artifact records themselves: the 12 legendary weapons, how a player activates ("Invocar") one, equips one, trains its base attributes with "Pedra dos Deuses" and evolves its level with the star, moon and sun crystals. It also owns the read-only views of another player's divine weapon. Resonance slots and emblems ("Brasão Mágico") change the same records but are documented in [resonance.md](resonance.md) and [emblems.md](emblems.md).

Conventions:
- Paths are relative to `decompiled/` unless they start with `raw/`, `protocol/`, `index/` or `docs/`. `CM` = `core_module/scripts`, `M11` = `m11/scripts`.
- Opcode names come from `protocol/opcodes.csv`. Proto fields come from `protocol/proto.json`; every tag below was checked against the AS3 `writeTo` (`CM/com/road/yishi/proto/player/ArtifactMsg.as:180-240`, `ArtifactInfoMsg.as`).
- *(assumption)* marks anything the client does not prove.
- No HTTP servlet or AMF call is used by this module.

---

## 1. Overview

- **Catalogue.** `raw/xml/tempinfos/ArtifactTemplateInfos.xml` has 12 rows, all `IsOpen="1"`: 100 Fradlak, 200 Gaya Borg, 300 Clausoras, 400 Brunoak, 500 Herney, 600 Carrad, 700 Tehhemu, 800 Gaya Gary, 900 Bergeratak, 1000 Akatram, 1100 Gaya Boyd, 1200 Mooreatak. The client lists only `IsOpen == 1` rows, owned first, then by TemplateId (`CM/yishi/manager/AncientArtifactManager.as:308-330`).
- **Unlock.** The bag button child "Arma Divina" and the hotkey C are enabled only when `VersionSwitch.ANCIENTARTIFACT` is true (`CM/yishi/datas/VersionSwitch.as:86`, true in this build) and the hero has a class change, `thane.vocationGrades > 0` (`CM/ui/maintoolbar/MainToolBar.as:1063-1064`; `CM/yishi/keyboard/KeyBoardRegister.as:160-161, 962-993`). No VIP condition.
- **Activation ("Invocar").** Each artifact needs its activation item `NeedItem` 241001..241012 (item SonType 625 `ANCIENT_ARTIFACT_STONE`, NeedGrades 80). The item is crafted in the smith from 100 fragments 240001..240012 (`raw/xml/tempinfos/ComposeTempInfos.xml` Id 10444..10455, Types 20, NeedMinLevel 80, NeedGold 10000); the summon button label is "Requisito: Síntese no Ferreiro{0}" (`ancientartifact.AncientArtifactFrame.summonGoodsName`).
- **Equip.** Exactly one owned artifact can be equipped ("Equipar"/"Retirar" buttons). The equipped artifact is the one shown to other players.
- **Training.** Spending "Pedra dos Deuses" (212018) raises the 7 base attributes (ATQ, DEF, MAG, RES, Penetração, Bloqueio, Vida) from the template minimum toward the template cap.
- **Evolution ("Evolução da Arma Divina").** Spending "Cristal da Estrela" (212015), "Cristal da Lua" (212016) or "Cristal do Sol" (212017) fills a GP bar; each level (1..15) raises the attribute multiplier `addPer` (100% .. 800%) and the artifact skill level.
- **Skill.** Each artifact has one passive skill family (`Skills` = SkillTempInfos SonType 12501..12512); the active grade equals the artifact level (`M11/ancientartifact/view/AncientPropertyView.as:185`).
- **Other players.** The player info frame shows another player's equipped artifact (data from 4125 `DetailRspMsg.artifactInfo`), and the ranking detail XML carries an `ArtifactInfo` node.

---

## 2. Screens

| Class (file) | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `ancientartifact.AncientArtifactFrame` (`M11/ancientartifact/AncientArtifactFrame.as`), 846x565 | "Arma Divina" (`ancientartifact.AncientArtifactFrame.titleText`, :65) | Main frame. Left list, middle showcase, right tab panel. Tabs are image buttons `ancientartifact.PropertyBtn`, `AdvancedBtn`, `resonateBtn` (third tab only when `VersionSwitch.ARMORY_AND_RESONATE_SHOW`, true, `CM/yishi/datas/VersionSwitch.as:88`) (:63-87). Sends op 1 on construction (:50) | `openControllerByInfo("ancientartifact")` (controller `CM/mvc/controler/AncientArtifactControler.as:40-55`, default openType) from the bag button child (`MainToolBar.as:2255-2261`), hotkey C (`KeyBoardRegister.as:993`), returning-player page (`M11/kingback/page/KingbackOtherPage.as:252-253`) | Tabs: 0 `AncientPropertyView`, 1 `AncientStrengthenView`, 2 `AncientArmoryView` (emblems and resonance, see [emblems.md](emblems.md)) (:104-130) |
| `ancientartifact.view.AncientArtifactList` (`M11/.../view/AncientArtifactList.as`) | none | Paged list, 4 per page | Inside the main frame | Icon, name, level "Nv.{0}" (`public.level2`), stars, equipped marker; unowned rows grey (`M11/.../view/item/AncientArtifactItem.as:124-150`). On the first 438 it jumps to the page of the equipped artifact and selects it (:117-134) |
| `ancientartifact.view.AncientMiddleView` (`M11/.../view/AncientMiddleView.as`) | template name | Showcase of the selected artifact | Inside the main frame (hidden on tab 2, `AncientArtifactFrame.as:128-129`) | Animated model `swf/avatar/legend/{SonType}.swf` (`PathManager.getArtifactShowPath`, :345-353); stars; level; fight power (:233-249); buttons "Invocar" (unowned only, enabled when the activation item is in bag 1, :209-219), equip / unequip (:220-221), evolution arrow with tip "Avanço da Arma Divina\nBônus Atual: {0}%" (:236-240); link "Visualizar" with the max-attribute tip (:135-136, 222-225) |
| `ancientartifact.view.AncientPropertyView` (`M11/.../view/AncientPropertyView.as`) | "Atributos da Arma Divina" / "Habilidades da Arma Divina" (`rareweapon.story.contractView.rareAttri/rareName`, :154-155) | Attribute and skill panel (tab 0) | Tab 0 | Owned: `int(stat * addPer/100 + emblem/resonance bonus)` for the 7 stats (:182-195, bonus :224-298); unowned: template minimum (:196-207). Skill name, "Nv.{grade}", description, icon from `SkillTempInfos` SonType=`Skills`, Grades=level (or 1 when unowned) (:185, 198, 208-221) |
| `ancientartifact.view.AncientStrengthenView` (`M11/.../view/AncientStrengthenView.as`) | image only (`asset.ancientartifact.strengthBg`) | Training with "Pedra dos Deuses" (tab 1) | Tab 1 | 7 bars `AncientStrengthenItem` with `current/cap` and `x{addPer}%` (`M11/.../view/item/AncientStrengthenItem.as:77-126`); stones owned (212018, :213-216); count input (default 1, clamped to 1..owned, :167-178); stone tip = item description (:122-126); floating "+N" arrow when a stat grows (:112-124) |
| `ancientartifact.AncientAdvanceFrame` (`M11/ancientartifact/AncientAdvanceFrame.as`), 525x445, openType 1 | "Evolução da Arma Divina" (`ancientartifact.AncientAdvanceFrame.titleText`, :112) | Level evolution | Arrow button of the middle view (`AncientMiddleView.as:184-188`, `openControllerByInfo("ancientartifact",1,TemplateId)`) | Icon, level, stars; current and next bonus `%` (UpGrade 136 ActiveObject); current skill (green) and next skill (red) descriptions; GP bar `gp/Data` or "max" (:211-248); material name "Contém {0}:" (`ownName`, :268-286) and owned count (:288-293); count input (:198-209). The note text key `ancientartifact.AncientAdvanceFrame.noteTxt` is missing in `index/language.json` (only `...noteTxtAviso` exists: "Consumindo materiais de elevação, poderá elevar o nível da arma divina, ...") |
| `ancientartifact.AncientEquipView` (`M11/ancientartifact/AncientEquipView.as`), openType 2 | "Arma Divina" and, side by side, "Minha Arma Divina" (`...AncientEquipFrame.titleText`, `titleText1`, :41, 114) | Read-only view of another player's equipped artifact, plus own equipped artifact for comparison | Player info frame artifact button (`m5/scripts/playerinfo/PlayerInfoFrameII.as:1390, 1596-1605`); button shown only when `artifactInfo.templateId > 0` (`m5/scripts/playerinfo/view/EquipCheckList.as:568-575`, tip "Clique para alterar arma divina") | Each half is an `AncientEquipFrame` (`M11/ancientartifact/AncientEquipFrame.as:100-135, 212-216`) with `AncientCheckPropertyView` (`M11/ancientartifact/AncientCheckPropertyView.as:154-206`): model, stars, level, fight power, `stat * addPer/100` (no emblem or resonance bonus), skill. Own half only if `vocationGrades > 0` and an equipped artifact exists (:106-125) |
| `yishi.view.tips.goods.ArtifactEquipTip` (`CM/yishi/view/tips/goods/ArtifactEquipTip.as`) | template name | Tooltip of a list icon (type "current") or the "Visualizar" link (type "max") | Hover | "max": `Max * (ActiveObject of the last UpGrade 136 row)/100` = cap x 8, skill grade 15; "current": owned values with bonuses, else minimum (:154-200). A third type "dreamArena" belongs to the arena feature |

Error tip used by the player info frame: "Não contém arma divina" (`PlayerInfoFrameII.noArtifactInfo`, `PlayerInfoFrameII.as:1598-1601`).

---

## 3. Routes (client to server)

All requests of this module use **9649 (0x25b1) C_ARTIFACT_OP** with `com.road.yishi.proto.player.ArtifactMsg`, built by `AncientArtifactManager.OperateArtifactReq(op, templateId=0, count=0, isEquip=false, pos=1, armoryId=0, consumeIds=null)` (`CM/yishi/manager/AncientArtifactManager.as:332-351`). The setter is called for every scalar, so `op`, `templateId`, `count`, `isEquip`, `armoryId` and `pos` are **always on the wire**; note the default `pos = 1`.

`ArtifactMsg` request fields:

| Field | Tag | Type | Rep. | Meaning in requests |
|---|---|---|---|---|
| op | 1 | INT32 | no | operation, constants at `AncientArtifactManager.as:26-48`: 1 OPEN, 2 ADVANCE, 3 STRENGTHEN, 4 EQUIP, 5 SUMMON, 6 RESON_EQUIP, 7 RESON_UPGRADE, 8 ARMORY_EQUIP, 9 ARMORY_UPGRADE, 10 ARMORY_ADVANCE, 11 ARMORY_SALE, 12 ARMORY_RESOLVE |
| templateId | 2 | INT32 | no | artifact TemplateId (100..1200) |
| count | 3 | INT32 | no | number of materials to spend |
| isEquip | 4 | BOOL | no | equip (true) or unequip (false), op 4 only |
| infos | 5 | ArtifactInfoMsg | yes | never set in requests |
| armoryId | 6 | INT32 | no | emblem id, or the resonance artifact TemplateId for op 6 |
| pos | 7 | INT32 | no | slot position; defaults to 1 |
| armoryInfo | 8 | ArmoryInfoMsg | yes | never set in requests |
| consumeArmoryIds | 10 | INT32 | yes | emblem ids, ops 10 and 12 only (written unpacked, `ArtifactMsg.as:224-229`) |
| resonatePos | 11 | ResonatePosMsg | yes | never set in requests |

Ops 6 and 7 are in [resonance.md](resonance.md); ops 8 to 12 are in [emblems.md](emblems.md).

| # | UI control | Client sender (file:line) | Client checks, in order | Request | Expected response |
|---|---|---|---|---|---|
| A1 | Main frame opens; player info artifact button | `AncientArtifactFrame()` (`M11/ancientartifact/AncientArtifactFrame.as:44-51`); `PlayerInfoFrameII.showArtifactInfo` (`m5/scripts/playerinfo/PlayerInfoFrameII.as:1596-1604`) | Frame: none (the entry points already require `vocationGrades > 0`). Player info: target `artifactInfo.templateId > 0`, else "Não contém arma divina" | `{op=1, templateId=0, count=0, isEquip=false, pos=1, armoryId=0}` | **438** with **all** owned artifacts (the list waits for the first 438 to select a row, `AncientArtifactList.as:117-134`; send it even when the list is empty), then **455** with all emblems, then **458** with the 5 resonance slots *(assumption on the order; each handler is independent)* |
| A2 | "Invocar" (summon) in the middle view | `AncientMiddleView.__summonHandler` (`M11/.../view/AncientMiddleView.as:190-194`) | Button visible only while not owned and enabled only when bag 1 holds at least one `NeedItem` (`GoodsManager.getBagCountByTempId(1, NeedItem) > 0`, :209-219). No level check | `{op=5, templateId}` | Bag push removing 1 activation item (inventory area); **438** with the new artifact *(assumption: level 1, gp 0, base stats = template minimum, addPer 100, not equipped)* |
| A3 | "Equipar" (equip) | `AncientMiddleView.__equipHandler` (:172-176) | Button visible when owned and not equipped (:220) | `{op=4, templateId, isEquip=true}` | **438** containing the newly equipped artifact **and** the previously equipped one with `isEquip=false` (the client only upserts, it never clears other flags, `AncientArtifactManager.as:238-288`); hero attribute refresh (hero area) *(assumption)* |
| A4 | "Retirar" (unequip) | `AncientMiddleView.__unEquipHandler` (:178-182) | Button visible when owned and equipped (:221) | `{op=4, templateId, isEquip=false}` | **438** with `isEquip=false`; hero attribute refresh *(assumption)* |
| A5 | Use stone button in the training tab | `AncientStrengthenView.__useStoneHandler` (`M11/.../view/AncientStrengthenView.as:155-159`) | Count input is clamped to 1..owned stones on change (:167-178), but the initial text "1" is sent even with 0 stones; the view is only greyed when unowned (:198-205), the button stays clickable. No cap check | `{op=3, templateId, count}` | Bag push for 212018 (inventory area); **438** with the new stat values. The bars animate a "+N" arrow for each stat that grew (`AncientStrengthenItem.as:112-121`) |
| A6 | Evolve button in "Evolução da Arma Divina" | `AncientAdvanceFrame.__advanceHandler` (`M11/ancientartifact/AncientAdvanceFrame.as:186-190`) | Count clamped to 1..owned material on change (:198-209); no max-level check on the button (only the bar shows "max", :230-237) | `{op=2, templateId, count}` | Bag push for the crystal; **438** with new `gp`, `level`, `addPer`, `skills`, `fightPower` |
| A7 | Use activation item from the bag | generic bag use, `SocketSendManager.sendUseItem` → **5006 (0x138e) U_C_BAG_USEITEM** (`CM/yishi/service/managers/SocketSendManager.as:157-167`); SonType 625 is usable (`CM/bag/helper/BagHelper.as:76, 128`) | inventory area | `ItemUseMsg` (inventory area) | Same effect as A2 *(assumption: the item description says "Após usar irá ativar a arma divina ...")*. Owned by [../inventory/README.md](../inventory/README.md); the handler must call this module's summon service |
| A8 | List paging, tab change, "Visualizar" tip, item click | client only | none | none | none |

---

## 4. Server messages (server to client)

| Opcode | Name | Message | Client receiver (file:line) | When to send | Client effect |
|---|---|---|---|---|---|
| 438 (0x01b6) | U_C_ARTIFACTINFO | `player.ArtifactMsg`, only `infos (#5, ArtifactInfoMsg, repeated)` is read | `AncientArtifactManager.__artifactInfoHandler` (`CM/yishi/manager/AncientArtifactManager.as:85, 238-288`) | Response to op 1 (all artifacts); after ops 2, 3, 4, 5 (changed artifacts); after resonance and emblem ops that change a host artifact ([resonance.md](resonance.md), [emblems.md](emblems.md)) | Upsert by `templateId`; no deletion path exists. Fires `ARTIFACT_INFO_UPDATE`, which refreshes the list, middle view, property, training, evolution and emblem views |
| 4125 (0x101d) | U_C_BAG_EQUIPLOOK | `simple.DetailRspMsg`, field `artifactInfo (#19, ArtifactInfoMsg)` | `PlayerInfoFrameII.__receiveEquipHandler` (`m5/scripts/playerinfo/PlayerInfoFrameII.as:211, 598, 1028-1045`) | Owned by the hero feature (player detail look-up). This module must provide the target's **equipped** artifact; leave the field unset (or templateId 0) when none is equipped | Fills `ThaneInfo.artifactInfo` (templateId, level, fightPower, attack, magicAttack, defences, magicDefences, penetrate, parry, live, skills, addPer); controls the artifact button |

`ArtifactInfoMsg` fields (`protocol/proto.json`, tags checked in `CM/com/road/yishi/proto/player/ArtifactInfoMsg.as`):

| Field | Tag | Type | Meaning |
|---|---|---|---|
| templateId | 1 | INT32 | artifact TemplateId, the record key |
| level | 2 | INT32 | evolution level 1..15 (stars: 1-5 stars, 6-10 moons, 11-15 suns, `M11/.../view/item/AncientStarsItem.as:41-72`) |
| gp | 3 | INT32 | evolution GP inside the current level |
| attack | 4 | INT32 | trained base ATQ (before `addPer`) |
| defences | 5 | INT32 | trained base DEF |
| magicAttack | 6 | INT32 | trained base MAG |
| magicDefences | 7 | INT32 | trained base RES |
| penetrate | 8 | INT32 | trained base Penetração |
| parry | 9 | INT32 | trained base Bloqueio |
| live | 10 | INT32 | trained base Vida |
| skills | 11 | STRING | skill id(s) *(assumption: the active skill TemplateId, SonType x 100 + level, e.g. "1250103"; the client never parses it)* |
| isEquip | 12 | BOOL | equipped flag |
| addPer | 13 | INT32 | attribute multiplier in percent (UpGrade 136 ActiveObject of `level`, 100..800) |
| fightPower | 14 | INT32 | fight power of the artifact without emblem/resonance bonus (the client adds those itself, `AncientMiddleView.as:234, 252-324`) |
| slotedEquipPos1..5 | 15..19 | INT32 | resonance artifact TemplateId in resonance slot 1..5, 0 = empty ([resonance.md](resonance.md)) |
| armoryEquipPos1..6 | 20..25 | INT32 | emblem id equipped in emblem slot 1..6, 0 = empty ([emblems.md](emblems.md)) |
| suitSkill | 26 | STRING | CSV of emblem suit skill TemplateIds, shown as descriptions ([emblems.md](emblems.md)) |

There are no result codes. Every failure is silent: the server sends nothing (or a generic tip from the core area) and the client stays unchanged *(open question: the client has no dedicated error opcode for 9649)*.

---

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Feature unlock | `VersionSwitch.ANCIENTARTIFACT` and `thane.vocationGrades > 0` (any class change) | `MainToolBar.as:1063-1064`; `KeyBoardRegister.as:984-991` |
| Artifacts available | `ArtifactTemplateInfos` rows with `IsOpen == 1` (all 12) | `AncientArtifactManager.as:308-330` |
| Summon cost | 1 x `NeedItem` (241001..241012). Item NeedGrades 80 *(assumption: the server also enforces hero level 80, the client does not)* | `AncientMiddleView.as:209-214`; `raw/xml/tempinfos/ItemTempInfos.xml` |
| Initial state after summon | level 1, gp 0, stats = template `*Apt` minimum, addPer 100 *(assumption, matches what the client shows for an unowned artifact and UpGrade 136 Grades 1 ActiveObject 100)* | `AncientPropertyView.as:196-205`; `UpGradeTempInfos` Id 13600001 |
| Equipped artifacts | at most 1 (`getEquipArtifactInfo` returns the first with `isEquip`) | `CM/mvc/module/ancientartifact/AncientArtifactModel.as:44-54` |
| Training material | "Pedra dos Deuses" 212018 ("Pedra mágica utilizada para elevar a qualificação de uma Arma Divina") | `AncientStrengthenView.as:122, 213-216` |
| Training effect | each stone adds a random amount to each of the 7 base stats within `*Conv = "min,max"` (ATQ/DEF/MAG/RES 1..10, Penetração/Bloqueio 1..2, Vida 6..60), capped at `*Apt` max (e.g. Fradlak ATQ 129..129000) *(assumption: `*Conv` is not read by the client; meaning inferred from name and ranges)* | `raw/xml/tempinfos/ArtifactTemplateInfos.xml` |
| Training display | bar = `value / cap`; multiplier text `x{addPer}%` | `AncientStrengthenItem.as:98-111` |
| Evolution levels | 1..15 = rows of `UpGradeTempInfos` Types 136 (Grades 1..15) | `AncientAdvanceFrame.as:295-313` |
| Evolution material | row Grades = current level, field `TemplateName` = item id: levels 1-4 212015 "Cristal da Estrela", 5-9 212016 "Cristal da Lua", 10-14 212017 "Cristal do Sol" | `AncientAdvanceFrame.as:268-293`; `UpGradeTempInfos` 13600001..13600015 |
| Evolution GP needed | row Grades = level+1, field `Data`: 1000, 1500, 2000, 3000 (to 5), 500, 1000, 1500, 2000, 3000 (to 10), 500, 1000, 1500, 2000, 3000 (to 15). The bar shows `gp / Data`, so `gp` is per level and resets (excess carries over *(assumption)*) | `AncientAdvanceFrame.as:238-246, 320-323` |
| GP per crystal | 10 *(assumption: the three crystals have `Property1 = 10`)* | `ItemTempInfos.xml` 212015..212017 |
| Multiplier per level | `addPer` = row Grades = level, `ActiveObject`: 100, 150, ..., 800 (step 50) | `AncientAdvanceFrame.as:228, 245`; `AncientMiddleView.as:236-240` |
| Skill | SkillTempInfos SonType = `Skills` (12501..12512), Grades = level (1..15), e.g. 12501 "Poder da Dispersão" 1% .. 40% | `AncientPropertyView.as:185`; `raw/xml/tempinfos/SkillTempInfos.xml` |
| Displayed stat | `int(base * addPer/100 + emblemBonus + resonanceBonus)` (bonuses: [emblems.md](emblems.md) §5, [resonance.md](resonance.md) §5) | `AncientPropertyView.as:184-193` |
| Fight power (unowned, shown by the client) | `ATQ + DEF + int(MAG * 1.05) + RES + Vida/5 + Bloqueio + Penetração` on template minimums (Fradlak = 845) | `AncientMiddleView.as:245`; `AncientEquipFrame.as:129` |
| Fight power (owned) | server `fightPower` + client-side emblem/resonance part `a0 + a1 + int(a2 * 1.05) + a3 + a4 + a5 + a6` (Vida not divided by 5; emblem ATQ is added to both ATQ and MAG, a client quirk) | `AncientMiddleView.as:234, 252-324` |
| Server `fightPower` | *(assumption)* same formula as the unowned one applied to `base * addPer/100` | none |
| Max tooltip | cap x (last 136 ActiveObject / 100) = cap x 8, skill grade 15 | `ArtifactEquipTip.as:159-173` |
| Hero attributes | the equipped artifact's displayed stats are added to the hero, and its skill is active in battle *(assumption: no client code computes hero totals; the server owns attribute aggregation)* | none |

---

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `raw/xml/tempinfos/ArtifactTemplateInfos.xml` (`TempleteManager.artifactTemplateCate`, `CM/yishi/manager/TempleteManager.as:1238`; class `CM/yishi/datas/templates/ArtifactTemplateInfo.as`) | one per artifact | `TemplateId` key; `TemplateName`; `SonType` model swf id; `AttackApt`, `DefenceApt`, `MagicAttackApt`, `MagicDefenceApt`, `PenetrateApt`, `ParryApt`, `LiveApt` = "min,max" base stat range; `*Conv` "min,max" training gain per stone (server only); `NeedItem` activation item; `Icon`; `Skills` skill SonType; `IsOpen` 1 = listed |
| `raw/xml/tempinfos/UpGradeTempInfos.xml` Types 136 | evolution level | `Grades` level 1..15; `TemplateName` material item id for leaving this level; `Data` GP needed to reach this level; `ActiveObject` addPer % |
| `raw/xml/tempinfos/SkillTempInfos.xml` | artifact skill grades | SonType 12501..12512, Grades 1..15: `TemplateName`, `Description`, `Icons` |
| `raw/xml/tempinfos/ItemTempInfos.xml` | materials | 241001..241012 activation items (SonType 625); 212018 Pedra dos Deuses; 212015/212016/212017 crystals (`Property1` 10); 240001..240012 fragments |
| `raw/xml/tempinfos/ComposeTempInfos.xml` Types 20 | crafting of activation items | owned by the smith feature |

---

## 7. Persistent state (PostgreSQL, schema `divine_weapon`)

```sql
CREATE SCHEMA IF NOT EXISTS divine_weapon;

-- One row per owned artifact.
CREATE TABLE divine_weapon.artifacts (
    player_id        BIGINT      NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
    template_id      INTEGER     NOT NULL,              -- ArtifactTemplateInfos.TemplateId
    level            SMALLINT    NOT NULL DEFAULT 1 CHECK (level BETWEEN 1 AND 15),
    gp               INTEGER     NOT NULL DEFAULT 0 CHECK (gp >= 0),
    attack           INTEGER     NOT NULL CHECK (attack >= 0),
    defence          INTEGER     NOT NULL CHECK (defence >= 0),
    magic_attack     INTEGER     NOT NULL CHECK (magic_attack >= 0),
    magic_defence    INTEGER     NOT NULL CHECK (magic_defence >= 0),
    penetrate        INTEGER     NOT NULL CHECK (penetrate >= 0),
    parry            INTEGER     NOT NULL CHECK (parry >= 0),
    live             INTEGER     NOT NULL CHECK (live >= 0),
    is_equipped      BOOLEAN     NOT NULL DEFAULT FALSE,
    created_at       TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at       TIMESTAMPTZ NOT NULL DEFAULT now(),
    PRIMARY KEY (player_id, template_id)
);
-- At most one equipped artifact per player.
CREATE UNIQUE INDEX artifacts_one_equipped
    ON divine_weapon.artifacts (player_id) WHERE is_equipped;
```

`addPer`, `skills` and `fightPower` are derived from `level` and the templates and are not stored. Resonance links and emblem slots live in the tables of [resonance.md](resonance.md) §7 and [emblems.md](emblems.md) §7.

---

## 8. Backend implementation notes

### Handlers (all on 9649, dispatched by `op`)

| Handler | Op | Validation order | Transaction | Pushes |
|---|---|---|---|---|
| `divine_weapon::artifacts::handle_open` | 1 | feature unlocked (`vocation_grade > 0`) | read only | 438 (all), 455 (all emblems), 458 (resonance) to the requester |
| `divine_weapon::artifacts::handle_summon` | 5 | template exists and `IsOpen == 1`; not owned; hero level >= 80 *(assumption)*; bag 1 holds `NeedItem` | one transaction: consume 1 item, insert row | bag update (inventory area), 438 (the new row) |
| `divine_weapon::artifacts::handle_equip` | 4 | owned; `isEquip` true: clear the flag of any other row, set this one; false: clear this one | one transaction | 438 with every row whose flag changed; hero attribute recalculation and its pushes (hero area) |
| `divine_weapon::artifacts::handle_strengthen` | 3 | owned; `count >= 1`; bag holds `count` x 212018; at least one stat below cap *(assumption: reject when all stats are capped)* | one transaction: consume stones, roll gains per stone per stat within `*Conv`, clamp to `*Apt` max | bag update, 438, hero attribute refresh if equipped |
| `divine_weapon::artifacts::handle_advance` | 2 | owned; `level < 15`; `count >= 1`; bag holds `count` of the material of the current level (UpGrade 136 row Grades=level `TemplateName`) | one transaction: consume, `gp += count * 10`, loop level-up while `gp >= Data(level+1)` *(assumption: stop consuming when the material changes at level 5 and 10, and refund nothing; simplest rule is to cap `count` at what reaches the next material boundary)* | bag update, 438, hero attribute refresh if equipped |

The bag-use path (A7) calls the same summon service from the inventory handler of 5006.

### Derived values

`addPer = UpGrade136[level].ActiveObject`; displayed stats per the §5 formula; `fightPower` per the §5 assumption; `skills = (Skills * 100 + level).to_string()` *(assumption)*.

### Cross-feature outputs

- Hero attributes: the equipped artifact, its emblems and resonance bonuses feed the hero stat aggregation and the battle unit build (`docs/battle/server-engine.md` §9). The artifact skill (SonType `Skills`, grade = level) should be added to the hero's passive skills *(assumption)*.
- Player detail 4125 `DetailRspMsg.artifactInfo (#19)`: fill from the equipped row.
- Ranking detail XML (`CM/mvc/controler/SortController.as:411-428`) reads an `ArtifactInfo` node with attributes `UserId, TemplateId, Level, FightPower, Attack, MagicAttack, Defences, MagicDefences, Penetrate, Parry, Live, Skills, AddPer`; owned by [../rankings/README.md](../rankings/README.md).

No timers, no schedules, no battle starts in this module.

---

## 9. Open questions and assumptions

1. *(assumption)* Training gain per stone uses `*Conv`; the client does not read these fields. The real server could use another rule (for example a fixed gain).
2. *(assumption)* Evolution GP per crystal is 10 (`Property1`), and `gp` is per level. Behaviour when `count` crosses a material boundary (level 5 or 10) is unknown.
3. *(assumption)* `skills` string format; the client never parses it.
4. *(assumption)* Server `fightPower` formula; the client only shows it.
5. *(assumption)* Summon enforces level 80 (item NeedGrades). The client only checks the item.
6. Whether summoning the first artifact equips it automatically is unknown; the client would show it unequipped unless the server sets `isEquip`.
7. There is no error opcode; how the original server reported failures (for example a generic tip) is unknown.
8. `ancientartifact.AncientAdvanceFrame.noteTxt` is missing in `index/language.json` (shows the raw key or empty text).

---

## 10. Implementation checklist

- [ ] Template loaders: `ArtifactTemplateInfos`, `UpGradeTempInfos` Types 136, `SkillTempInfos` SonType 12501..12512, items 2410xx/212015-212018.
- [ ] Table `divine_weapon.artifacts` with the one-equipped partial unique index.
- [ ] Opcode 9649 decoder for `player.ArtifactMsg` (all 10 fields; `consumeArmoryIds` packed or unpacked).
- [ ] Encoder for 438 `ArtifactMsg.infos` with all 26 `ArtifactInfoMsg` fields, including resonance and emblem slot columns and `suitSkill`.
- [ ] Route A1 op 1 OPEN: 438 (always, even empty), 455, 458.
- [ ] Route A2 op 5 SUMMON with item consumption.
- [ ] Route A3/A4 op 4 EQUIP/UNEQUIP; send both changed rows.
- [ ] Route A5 op 3 STRENGTHEN with caps.
- [ ] Route A6 op 2 ADVANCE with material by level, GP thresholds, max level 15.
- [ ] Route A7 bag-use of SonType 625 wired to the summon service (inventory area).
- [ ] Derived values: addPer, skill id, fightPower.
- [ ] 4125 `DetailRspMsg.artifactInfo` filler for the hero feature; ranking XML `ArtifactInfo` node for the rankings feature.
- [ ] Hero stat aggregation hook and battle skill hook.
- [ ] Rule tests: summon without item rejected; double summon rejected; equip switches the flag atomically; strengthen never exceeds caps; advance stops at 15; material id per level; addPer per level.
- [ ] Client test: open the frame with no artifact (list renders, first 438 empty), summon, equip, train, evolve, view another player's artifact from the player info frame.
