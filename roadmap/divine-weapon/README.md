# Divine weapon ("Arma Divina")

Feature slug `divine-weapon`, domain `character`. Registry (`roadmap/features.json`): client packages `ancientartifact` and `artifact` (`m11/scripts/ancientartifact`, `m11/scripts/artifact`, plus `core_module/scripts/mvc/module/ancientartifact` and `mvc/module/artifact`), proto package `artifactgiftactivity`. Following the code, the feature is two unrelated systems that share the "Arma Divina" name:

| Module | pt-BR name (client) | What it does for the player | Transport |
|---|---|---|---|
| [artifacts.md](artifacts.md) | "Arma Divina", "Evolução da Arma Divina" | Collect 12 legendary weapons by using their activation items, equip one, train its 7 base stats with "Pedra dos Deuses", evolve its level 1..15 with star, moon and sun crystals (stat multiplier 100%..800% and skill level), view another player's weapon | socket 9649 ops 1-5 / 438 (+ 4125 field) |
| [resonance.md](resonance.md) | "Ressonância", "Fortalecer Ressonância" | Link other owned weapons into 5 resonance slots of a host to inherit 10%..70% of their stats; level the slots with "Cristal de Ressonância"; linked slots unlock emblem slots | socket 9649 ops 6-7 / 458, 438 |
| [emblems.md](emblems.md) | "Brasão Mágico", "Brasão da Ressonância" | Emblem bag: equip up to 6 emblems per weapon, engrave (seal level 0..5), advance quality Verde → Vermelho by fusing copies, decompose into engraving stones; 2-piece suit skills | socket 9649 ops 8-12 / 455, 456, 457, 438 |
| [gift-roulette.md](gift-roulette.md) | "Roleta da Arma Divina" | Time-limited event: diamonds spent on event packages give points; each point step gives a spin of a 10-box roulette without repeats; final prize after 10 boxes; daily reset | socket 9580 / 321, 322, 323, 326 (+ shop routes 8693/8970) |

Out of scope although the name matches:
- "Arma Divina" of the Einherjar (`PetHallowsTempInfos`, `pethallows`): see [../einherjar/README.md](../einherjar/README.md) (owner of client package `pethallows`).
- Guardian spirit weapon `children.SpiritArtifactInfoMsg` (`CM/managers/ChildManager.as:474-478`): see [../guardians/README.md](../guardians/README.md).
- Assistant showcase `antaeus.ArtifactShowMsg` (`AssistantDataMsg.artifact #5`, `CM/mvc/module/antaeus/AntaeusShowData.as:39`): see [../assistant/README.md](../assistant/README.md).
- Dream arena artifact picks (`m13/scripts/dreamarena/view/DreamArenaArtifactView.as`, tip type "dreamArena" of `ArtifactEquipTip`): see [../arena/README.md](../arena/README.md).

Conventions used in every module file:
- Paths are relative to `decompiled/` unless they start with `raw/`, `protocol/`, `index/` or `docs/`. `CM` = `core_module/scripts`, `M11` = `m11/scripts`.
- Opcode names come from `protocol/opcodes.csv`; proto fields from `protocol/proto.json`, tags checked against the AS3 `writeTo` (`WriteUtils.writeTag(buf, wireType, tag)`) in `CM/com/road/yishi/proto/**`.
- *(assumption)* marks anything the client does not prove.
- No HTTP servlet or AMF call is used by this feature.

## Entry points

| Entry | Where | Unlock condition | Opens |
|---|---|---|---|
| Bag button child "Arma Divina" (tip key `artifactBtn`) | Main tool bar (`CM/ui/maintoolbar/MainToolBar.as:1045, 1063-1064, 2255-2261`) | `VersionSwitch.ANCIENTARTIFACT` (true, `CM/yishi/datas/VersionSwitch.as:86`) and `thane.vocationGrades > 0` (hero has changed class) | `ancientartifact.AncientArtifactFrame` |
| Hotkey C | `CM/yishi/keyboard/KeyBoardRegister.as:160-161, 962-993` | Not in battle or vehicle, keys enabled, `vocationGrades > 0`, version switch | same |
| Returning-player page "go" button (type 5) | `m11/scripts/kingback/page/KingbackOtherPage.as:252-253` | Returning-player event | same |
| Player info frame artifact button | `m5/scripts/playerinfo/view/EquipCheckList.as:568-575`, `m5/scripts/playerinfo/PlayerInfoFrameII.as:1390, 1596-1604` | The viewed player has an equipped weapon (`artifactInfo.templateId > 0`), else "Não contém arma divina" | `ancientartifact.AncientEquipView` (read-only, openType 2) |
| Bag use of activation item 2410xx (SonType 625) or emblem item 6261tp (SonType 626) | Normal bag (`CM/bag/helper/BagHelper.as:76, 128-129`) | Item NeedGrades 80 | No frame; creates an artifact or an emblem |
| Top tool bar button `artifact` "Roleta da Arma Divina" | `CM/ui/toptoolbar/TopToolsBar.as:1277-1278`; `CM/ui/toptoolbar/TopBtnCheckShowHelper.as:285-286` | Hero level >= 11, event open (323 `open`) and before `end_time` | `artifact.ArtifactFrame` |

No VIP condition exists in any module. The resonance and emblem tab is shown because `VersionSwitch.ARMORY_AND_RESONATE_SHOW = true` (`CM/yishi/datas/VersionSwitch.as:88`).

## Dependencies

| Feature | Why |
|---|---|
| [../hero/README.md](../hero/README.md) | Class change gate (`vocationGrades`); hero stat aggregation must add the equipped weapon, its emblems and resonance; player detail 4125 `DetailRspMsg.artifactInfo (#19)` |
| [../inventory/README.md](../inventory/README.md) | Material counts and consumption (212015-212018, 2410xx, 6260001-6260003), bag pushes, item use 5006 for SonType 625/626, prize delivery |
| [../smith/README.md](../smith/README.md) | Activation items 2410xx are crafted from 100 fragments (`ComposeTempInfos` Types 20); emblem items SonType 626 can be decomposed in the smith resolve view (`m14/scripts/store/ResolveView1.as:290, 361`) |
| [../shops/README.md](../shops/README.md) | Roulette packages are shop discount goods of type 7, bought with 8693/8970; the purchase must feed roulette points |
| [../currency/README.md](../currency/README.md) | Diamonds (`playerInfo.point`) spent on packages |
| [../battle/README.md](../battle/README.md) | Artifact skill (SkillTempInfos SonType 12501..12512) and emblem suit skills (6261xxx) must be applied to the hero in battle *(assumption)* |
| [../rankings/README.md](../rankings/README.md) | Ranking detail XML carries an `ArtifactInfo` node (`CM/mvc/controler/SortController.as:411-428`) |
| [../returning-players/README.md](../returning-players/README.md) | Hosts one entry button |

## Suggested implementation order

1. Template loaders: `ArtifactTemplateInfos`, `ArftiArmoryTemplateInfos`, `UpGradeTempInfos` Types 136/137/138, `SuiteTempInfos` 606-611, the skill families, and the material items.
2. [artifacts.md](artifacts.md): table, op 1 (OPEN, with empty 455/458), op 5 summon, op 4 equip, then op 3 training and op 2 evolution; 438 encoder with all 26 fields; hero stat hook.
3. [resonance.md](resonance.md): tables, op 6 link/unlink, op 7 upgrade, 458, bonus calculator.
4. [emblems.md](emblems.md): tables, emblem creation from SonType 626, op 8 equip/unequip with slot locks, op 9 engrave, op 10 advance, op 12 decompose, suit calculator, 455/456.
5. [gift-roulette.md](gift-roulette.md): independent of 2-4; needs the shops purchase hook and the inventory reward service; login pushes, 9580 ops, daily reset grant, start/end broadcasts.

## Totals

| Module | Routes (client to server) | Server messages | Proposed tables |
|---|---:|---:|---:|
| artifacts | 6 own on 9649 (+1 bag-use hook) | 1 own (438) + 4125 field | 1 |
| resonance | 3 | 1 own (458), reuses 438 | 2 |
| emblems | 6 own on 9649 (+1 bag-use hook; op 11 dead) | 3 own (455, 456, 457 no-op), reuses 438 | 2 |
| gift-roulette | 3 own on 9580 (+1 shop purchase hook) | 4 (321, 322, 323, 326) | 6 |
| **Feature** | **18 own** | **9 own opcodes** | **11** |
