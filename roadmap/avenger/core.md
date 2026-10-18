# Avenger core: deification, main frame, data sync, Olhos da Verdade, inspection

Module `core` of the feature [Vingador](README.md). Path conventions are in the README (`CM/` = `core_module/scripts/`, `M5/` = `m5/scripts/`, paths relative to `decompiled/`).

## 1. Overview

This module owns everything that is not a single progression track:

- **Deification (unlock).** An NPC dialog option sends 8658 C_THIRD_TRANSFER. The server turns the hero into an avenger (`vocationIndex = 3`) and creates the avenger state (body, 6 skills, armor, 6 holes).
- **Main frame** `AvengerFrame` ("Vingador") with 5 tabs, opened by the toolbar, hotkey X and task links. Opening it sends 8657 op 0 and the server answers 4588 with the full `AvengerMsg` (opType 0).
- **Push dispatch.** 4588 is the single response/push for ops 0..7. The client merges skills by `skillSonType` and holes by `pos`, then fires a UI event chosen by `opType`.
- **Olhos da Verdade (eye tab).** Read-only view of the job-title level (vocation grade, owned by the hero feature) and the battle skill swap cooldown it grants (`UpGradeTempInfos` Types 152).
- **Shared avenger fields** that other features must fill: `ArmyMsg.avenger_grade (#43)`, `RoomPlayerMsg.avenger_grade (#57)`, `TeamPlayerInfoMsg.avenger_grade (#48)` (body grade, drives the avatar effect) and `DetailRspMsg.avengerInfo (#24)` (player inspection).
- **Inspection.** `AvengerOtherView` ("Verificar Vingador") and `DevilArmorInfoView` ("Armadura Mítica") show another player's avenger next to the own one.

## 2. Screens

| Class (file) | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `avenger.AvengerFrame` (`M5/avenger/AvengerFrame.as`), 757x562, groups MAIN_TOOLS_GROUP + BAG_GROUP (:62-70) | "Vingador" (`AvengerFrame.title.text`, :219) | Tab host | `openControllerByInfo("avenger")` from toolbar star child button (`CM/ui/maintoolbar/MainToolBar.as:1536-1540`), hotkey X (`CM/yishi/keyboard/KeyBoardRegister.as:1086-1118`), task links (`CM/yishi/SwitchPageHelp.as:2889-2909`) | Tabs in order skill(0), body(1), eye(2), devil armor(3, only if `DEVIL_ARMOR`), child sword(4, only if `CHILD_NS`) (:72-104). `show()` selects tab `int(frameData)` (:216-224). Constructor sends op 0 (:58) and starts a fighting-capacity record (:59, ended in `dispose` :229) |
| `avenger.view.AvengerEyeView` (`M5/avenger/view/AvengerEyeView.as`) | tab "Olhos da Verdade" (tab is an icon; name from `AvengerEyeView.curDescText.text`) | Read-only | Tab 2 | Level = 30 if `thane.isHoly` else `thane.vocationGrades` (:81-90); current and next effect "Efeito dos Olhos da Verdade: Altera o tempo de resfriamento dos Braços da Vingança para {0} segundos" with {0} = `UpGrade(Types 152, Grades=level).ActiveObject` (:91-100); progress bar `vocationGp / UpGrade(152, level+1).Data` (:101-102), "max" when no next row (:105-111). Refreshes on `VOCATION_GRADES` and `VOCATION_GP` (:62-66) |
| `avenger.AvengerOtherView` (`M5/avenger/AvengerOtherView.as`), controller key `OTHER_INFO_FRAME` -> class `playerInfo.avengerOtherView` (`CM/mvc/controler/AvengerControler.as:38-41`) | "Verificar Vingador" (`playerInfo.checkAvanger.frameTitle`, :40); second panel "Meu Vingador" (`...frameTitle1`, :113) | Compare another player's avenger with mine | Player info button 9 (`M5/playerinfo/PlayerInfoFrameII.as:1398-1399, 1427-1435`); refused with "O jogador não desbloqueou o Vingador." when the target is not an avenger | Hosts two `AvengerOtherFrame` panels (target at left, self at x=650 if self is avenger, :105-124) |
| `avenger.AvengerOtherFrame` (`M5/avenger/AvengerOtherFrame.as`) | none | One avenger panel | `AvengerOtherView` | 6 skill items (read-only, tooltips on) (:98-117); body stats `avengerBodyPropAry` (attack, defense, magic defense, HP) (:136-140); body degree `BodyType` (:141-144); eye level (30 if holy else vocationGrades) (:145-146). Uses `thane.avengerInfo` or the own model (:149-165) |
| `avenger.DevilArmorInfoView` (`M5/avenger/DevilArmorInfoView.as`), key `OTHER_INFO_DEVILARMOR_FRAME` -> `playerInfo.devilArmorInfoView` (`AvengerControler.as:50-53`) | "Armadura Mítica" (`playerinfo.devilArmorFrame.title1`); own panel "Minha Armadura Mítica" (`...title2`, :113) | Compare devil armor | Player info button 10 (`PlayerInfoFrameII.as:1401-1402, 1437-1445`); refused with "O oponente não tem Armadura Mítica" | Two `DevilArmorLookInfoFrame` panels (:105-124) |
| `avenger.DevilArmorLookInfoFrame` (`M5/avenger/DevilArmorLookInfoFrame.as`), 405x417 | none | One armor panel | `DevilArmorInfoView` | Armor grade, exp bar `exp / UpGrade(155, grade+1).Data`, 6 holes with inlaid pearls (read-only) (:73-99) |

Controller: `CM/mvc/controler/AvengerControler.as` (FrameControllerManager key `"avenger"`, created at `CM/yishi/manager/FrameControllerManager.as:672`, started at :1919-1921, UI resources `avengereffect`, `child`, `childnursingspirit` at :1217-1221). `frameClassName` maps `openType` to `AvengerSkillEvolveFrame` (`UPGARDE_FRAME`), `AvengerDevilArmorCarveFrame`, `playerInfo.avengerOtherView`, `AvengerChildNsSwordUpgradeFrame`, `AvengerChildNsSkillFrame`, `playerInfo.devilArmorInfoView`, else `AvengerFrame` (:28-55). `showFrame` passes `frameData` when `openType == 1`, else the whole `ModuleFrameInfo` (:57-68).

Tab selection from task links (`CM/yishi/SwitchPageHelp.as`):

| Task condition type | Constant (`CM/yishi/datas/consant/TaskConditionType.as:92-118`) | Call | Tab opened |
|---|---|---|---|
| 246 | REVENGE_SOUL_TASK | `openRevengeSoul()` (:459, :2889-2899), openType 1, frameData 1 | 1 (body) |
| 247, 255-259 | ADVANCE_REVENGE_TASK, HOLY_* | `openAdvanceRevengeSkill(0)` (:462, :487, :2901-2909) | 0 (skills) |
| 248-251 | AVENGER_CHILDNS_GRADE/STAGE, AVENGER_PASSIVESKILL/ACTIVESKILL | `openAdvanceRevengeSkill(4)` (:468) | 4; with `CHILD_NS = false` index 4 does not exist (only 4 tabs), so the selection is a no-op *(assumption from `SelectedButtonGroup` behaviour)* |

## 3. Routes (client to server)

### C1. Deification ("Deificação")

| Item | Value |
|---|---|
| UI control | NPC dialog option of type 146 in `SpaceDialogFrame` |
| Client sender | `DialogOptionItem` case 146 closes the dialog and calls `PlayerManager.sendAvengerTransfer` (`M3/map/space/view/frame/DialogOptionItem.as:833-839`; `CM/yishi/manager/PlayerManager.as:2102-2106`) |
| Client checks | Option listed only if `PlayerManager.isShowAvengerItem()`: task 1943 finished and `!playerInfo.isAvenger` (`M3/map/space/view/frame/SpaceDialogFrame.as:327-333`; `PlayerManager.as:2216-2224`). No cost or confirmation on the client |
| Route | client to server, **8658 (0x21d2) C_THIRD_TRANSFER** |
| Request | none (`SocketSendManager.send(pkg)` without a protobuf body) |
| Expected response | **4557 (0x11cd) U_C_TRANS_GRADE** `FateInfoMsg{index (#8)=3, grades (#4), total_gp (#3)}` (updates `vocationIndex`, `vocationGrades`, `vocationGp`, fires `VOCATION_INDEX`; `PlayerManager.as:179, 2049-2073`); **4556 (0x11cc) U_C_TRANSFER** broadcast `PropertyMsg{param1 userId, param2 job, param3 vocationGrades, param4 nick, param5 consortiaId}` (world chat tip + map effect; `PlayerManager.as:178, 1991-2047`); then 4588 opType 0 and 211 bagType 3 for the new avenger *(assumption: same message pair as the dragon transfer 8643; the client has no dedicated deification response)* |

### C2. Load avenger data (op 0)

| Item | Value |
|---|---|
| UI control | Opening `AvengerFrame` (any entry point) |
| Client sender | `AvengerFrame()` constructor (`M5/avenger/AvengerFrame.as:58`) -> `AvengerManager.sendAvengerDataRequest` (`CM/yishi/manager/AvengerManager.as:185-191`) |
| Client checks | none beyond the entry point checks (`isAvenger`, switch) |
| Route | client to server, **8657 (0x21d1) C_AVENGER_CLIENT_OP** |
| Request | `player.PlayerOpMsg`: `op (#1, INT32) = 0`. No other field. Tags verified in `CM/com/road/yishi/proto/player/PlayerOpMsg.as:476-573` |
| Expected response | **4588 (0x11ec) U_C_AVENGER_DATA** `AvengerMsg` with `opType = 0` and every field: body grade/exp, all 6 `skillDatas`, armor grade/exp, all 6 `holeDatas` |

Full `PlayerOpMsg` field list (shared by every 8657 op; tags from `protocol/proto.json`, verified at `PlayerOpMsg.as:476-573`): `op (#1, INT32)`, `type (#2, INT32)`, `payType (#3, INT32)`, `count (#4, INT32)`, `id (#5, INT32)`, `index (#6, INT32)`, `userId (#7, INT32)`, `templateId (#8, INT32)`, `campaignId (#9, INT32)`, `nodeId (#10, INT32)`, `chapterId (#11, INT32)`, `uuid (#12, STRING)`, `value1 (#13, INT32)`, `value2 (#14, INT32)`, `param1 (#15, STRING)`, `param2 (#16, STRING)`, `flag1 (#17, BOOL)`, `flag2 (#18, BOOL)`, `pos (#19, INT32)`, `ids (#20, INT32, repeated)`. The avenger ops use only `op`, `type`, `count`, `id`, `index`, `templateId` and `param1`.

## 4. Server messages (server to client)

### S1. 4588 (0x11ec) U_C_AVENGER_DATA

Message `avenger.AvengerMsg` (tags verified at `CM/com/road/yishi/proto/avenger/AvengerMsg.as:151-184`):

| Field | Tag | Type | Meaning |
|---|---|---|---|
| opType | 1 | INT32 | Echo of the request `op` (0..7) that caused the push; selects the UI refresh |
| grade | 2 | INT32 | Body grade 0..220 (`AvengerBodyTemplates.BodyGrade`) |
| exp | 3 | INT32 | Body exp (crystals fed toward the next grade) |
| skillDatas | 4 | AvengerSkillMsg, repeated | Skills, upsert by `skillSonType` |
| armorGrade | 5 | INT32 | Devil armor grade 1..10 |
| armorExp | 6 | INT32 | Devil armor exp |
| holeDatas | 7 | AvengerHoleMsg, repeated | Holes, upsert by `pos` |

`AvengerSkillMsg` (tags verified at `.../avenger/AvengerSkillMsg.as:480-570`): `skillId (#1, INT32)` SkillTempInfos TemplateId of the current grade; `skillSonType (#2, INT32)` 511..536; `attack (#3, INT32)`; `magicAttack (#4, INT32)` (not read by the client); `defence (#5, INT32)`; `magicDefence (#6, INT32)`; `live (#7, INT32)`; `forcehit (#8, INT32)`; `parry (#9, INT32)`; `penetrate (#10, INT32)`; `reduceResi (#11, INT32)` (stored, not displayed); `fireResi (#12)`; `waterResi (#13)`; `electResi (#14)`; `windResi (#15)`; `darkResi (#16)`; `lightResi (#17)` (all INT32); `isUse (#18, BOOL)` in the battle formation; `itemInfo (#19, STRING)` fed stones of the current grade as `"tid,count|tid,count"`. Details in [skills.md](skills.md).

`AvengerHoleMsg` (tags verified at `.../avenger/AvengerHoleMsg.as:122-137`): `pos (#1, INT32)` 0..5; `grade (#2, INT32)` 0 = locked, 1..20; `exp (#3, INT32)` carve exp; `inlayItem (#4, INT32)` pearl item template id, 0 = empty. Details in [devil-armor.md](devil-armor.md).

Client receiver `AvengerManager.__avengerMsgUpdateHandler` (`CM/yishi/manager/AvengerManager.as:65, 70-151`):

1. Scalars are applied only when present (`hasGrade`, `hasExp`, `hasArmorGrade`, `hasArmorExp`, :77-92).
2. Holes are upserted by `pos` (:93-105), skills by `skillSonType` (:106-132). Nothing is ever deleted.
3. UI event by `opType` (:133-150):

| opType | Event(s) fired | Listeners |
|---|---|---|
| 0 | `SKILL_INFO_UPDATE`, `BODY_INFO_UPDATE`, `DEVIL_ARMOR_INFO_UPDATE` | all tabs |
| 4 | `BODY_INFO_UPDATE` | body tab, tasks 246 and 255-259 |
| 1, 2, 3 | `SKILL_INFO_UPDATE` | skill tab, evolve frame, tasks 255-259 |
| anything else | `DEVIL_ARMOR_INFO_UPDATE` | armor tab, carve frame, tasks 255-259 |

Client bug to keep in mind: the last branch is `opType == 5 || 6` (:147), which is always true, so any opType other than 0..4 (including 7) refreshes the armor views. The server should still send the exact op.

When to send: response to every successful 8657 op 0..7 (op 8 answers with virtual bag pushes, see [devil-armor.md](devil-armor.md)); at login for avengers *(assumption: the client never requests it outside the frame, but tasks 246 and 255-259 read the model at any time, `CM/mvc/module/task/TaskTemplate.as:318-330`)*. No result code exists: a rejected request gets no 4588 *(see §9)*.

### S2. Avenger grade carried by shared messages

| Opcode | Message and field | Client reader | Use |
|---|---|---|---|
| 150 (0x0096) U_C_SERIAL_ARMY | `army.ArmyMsg.avenger_grade (#43, INT32)` = body grade | `ArmyManager.__getArmyListHandler` -> `__recieveArmyHandler` -> `ThaneInfoHelper.readHeroInfo` (`CM/yishi/manager/ArmyManager.as:155, 213-252`; `CM/com/road/pb/helper/army/ThaneInfoHelper.as:196-199`); outer-city armies at `ThaneInfoHelper.as:45` | `ThaneInfo.avengerGrade` (`CM/yishi/datas/playerinfo/ThaneInfo.as:301-308`) -> `avengerDegree = AvengerBodyTemplates(BodyGrade).BodyType` (:310-314); fires `AVENGER_DEGREE_CHANGE` (:1131-1134, task 246) |
| room/space members (RoomPlayerMsg) | `room.RoomPlayerMsg.avenger_grade (#57, INT32)` | `SpaceManager.readMember` (`CM/map/space/SpaceManager.as:184, 231`); `CampaignManager.readMember` (`CM/map/campaign/CampaignManager.as:539, 642`) | Avatar effect of other players |
| team members (TeamPlayerInfoMsg) | `team.TeamPlayerInfoMsg.avenger_grade (#48, INT32)` | `FreedomTeamManager.readMember` (`CM/managers/FreedomTeamManager.as:428, 527-530`) | Same |
| 157 U_B_PREPARE | `battle.HeroMsg.avengerGrade (#111)` and the other avenger fields | see [battle.md](battle.md) | Battle effect `core.avengerEffectzd<n>` |

Send rule: whenever the body grade changes, re-send the owner's 150 (or the hero's army update) so `avengerDegree` refreshes *(assumption: the client has no other path to update `thane.avengerGrade`)*.

### S3. 4125 (0x101d) U_C_BAG_EQUIPLOOK, field `DetailRspMsg.avengerInfo (#24, AvengerMsg)`

- Answer to 8199 C_BAG_EQUIPLOOK (player inspection, owned by the hero feature).
- Client: `PlayerInfoFrameII.__receiveEquipHandler` reads `DetailRspMsg` (`M5/playerinfo/PlayerInfoFrameII.as:211, 598, 654-655`) and builds an `AvengerModel` from `avengerInfo`: grade, exp, skills, holes, armor grade/exp (:908-968).
- The server must fill `avengerInfo` with the same content as a 4588 opType 0 for the inspected hero, or omit it when the hero is not an avenger.
- The same structure is read by Perkin Lab (`CM/managers/PerkinLabManager.as:607-646`) and, as XML `<AvengerInfo grade exp armorGrade armorExp><AvengerSkillInfo skillId skillSonType isUse attack ...>`, by rankings (`CM/mvc/controler/SortController.as:480-529`).

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Is avenger | `vocationIndex >= 3`; holy is `>= 4` and is also an avenger | `CM/yishi/datas/playerinfo/SimplePlayerInfo.as:1264-1272` |
| Deification prerequisite (client view) | task 1943 finished. Task conditions 236 (vocation grade 80 with `vocationIndex > 0`), 237 (talent grade) and 238 (`vocationIndex >= 3`) track the deification chain | `PlayerManager.as:2216-2224`; `TaskTemplate.as:1321-1329, 1350-1358, 1381-1389` |
| Job of the avenger skills | hero job 1/2/3 = "Deus espadachim/arqueiro/mago vingador" (`UpGradeTempInfos` Types 152 TemplateName) and skill SonTypes 51x/52x/53x | `raw/xml/tempinfos/AvengerSkillTemplates.xml` JobType |
| Initial state at deification | body grade 0 exp 0; 6 skills of the job at grade 1; armor grade 1 with 2 open holes (grade 1); holes 2..5 locked *(assumption: the armor view returns early when `UpGrade(155, grade)` is missing, so grade 0 cannot be displayed, `M5/avenger/view/AvengerDevilArmorView.as:174-177`; the first major and the first minor skill in the formation)* | |
| Eye level | 30 if holy, else `vocationGrades` (1..30) | `AvengerEyeView.as:81-89`; `AvengerOtherFrame.as:145` |
| Eye effect | swap cooldown seconds = `UpGrade(Types 152, Grades = eye level).ActiveObject`: 30 at level 1 down to 1 at level 30 | `AvengerEyeView.as:91-100`; `raw/xml/tempinfos/UpGradeTempInfos.xml` Id 15200001..15200030 |
| Eye progress | vocation GP vs `UpGrade(152, level+1).Data` (1 205 000 000 .. 1 350 000 000) | `AvengerEyeView.as:101-102` |
| Avenger vocation level display | `vocationLevel + 16` (avenger), `+19` (holy) | `SimplePlayerInfo.as:1318-1325` (hero feature) |
| Avatar effect tier | `min(10, ceil(avengerDegree / 2))`, assets `core.avengerEffectzs<n>` (frame) and `core.avengerEffectzd<n>` (battle) | `M5/avenger/view/AvengerBodyView.as:243-244`; `CM/battle/view/roles/HeroRoleView.as:65-94` |

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `raw/xml/tempinfos/UpGradeTempInfos.xml` Types 152 (30 rows, Id 15200001-15200030), loaded through `TempleteManager.getTemplateByLevelAndType` | eye level | `Grades` = eye level; `Data` = vocation GP needed; `ActiveObject` = swap cooldown seconds; `TemplateName` = vocation titles per job ("Deus espadachim vingador\|Deus arqueiro vingador\|Deus mago vingador", "... negro", "... caótico") |
| `raw/xml/tempinfos/AvengerBodyTemplates.xml` | body grade | `BodyGrade` -> `BodyType` for `avengerDegree` (see [body.md](body.md)) |

## 7. Persistent state

Schema `avenger`. Player tables reference `player.players(player_id)`.

```sql
CREATE SCHEMA IF NOT EXISTS avenger;

-- One row per deified hero. Created by the deification handler (8658).
CREATE TABLE avenger.profiles (
  player_id      bigint      PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
  hero_job       smallint    NOT NULL CHECK (hero_job BETWEEN 1 AND 3),   -- AvengerSkillTemplates.JobType
  deified_at     timestamptz NOT NULL DEFAULT now(),
  body_grade     smallint    NOT NULL DEFAULT 0 CHECK (body_grade BETWEEN 0 AND 220),
  body_exp       integer     NOT NULL DEFAULT 0 CHECK (body_exp >= 0),
  updated_at     timestamptz NOT NULL DEFAULT now()
);
```

`vocation_index`, `vocation_grade` and `vocation_gp` stay in the hero feature tables; this module only reads them. Skills, armor and holes are in [skills.md](skills.md) and [devil-armor.md](devil-armor.md).

## 8. Backend implementation notes

| Handler | Route | Validation order | Transaction and pushes |
|---|---|---|---|
| `avenger::core::handle_deify` | 8658 | player online -> not already avenger (`vocation_index < 3`) -> task 1943 finished -> hero prerequisites of the hero feature (vocation grade 80, talent) *(assumption)* | One tx: hero `vocation_index = 3` (hero feature API), insert `avenger.profiles`, 6 rows `avenger.skills` (job SonTypes, grade 1), `avenger.devil_armors` grade 1, 6 rows `avenger.armor_holes` (pos 0,1 grade 1; 2..5 grade 0). After commit: 4557 to the player, 4556 broadcast, 150 army refresh, 4588 opType 0, 211 bagType 3 |
| `avenger::core::handle_get_data` | 8657 op 0 | player is avenger, else drop | Read only. Send 4588 opType 0 with all fields |
| `avenger::core::dispatch_client_op` | 8657 | decode `PlayerOpMsg`; `op` in 0..13 else drop; player is avenger; `VersionSwitch` equivalents: ops 5..8 need `devil_armor_enabled`, ops 9..13 need `child_ns_enabled` (default false) | Routes to the module handlers listed in each module file |
| `avenger::core::build_avenger_msg` | helper | | Builds `AvengerMsg` for 4588, `DetailRspMsg.avengerInfo` and ranking XML from the same rows |
| `avenger::core::on_login` | login hook | player is avenger | Push 4588 opType 0, 211 bagType 3 (and 4276 when child sword is enabled) *(assumption)* |

- Every 8657 handler runs under a per-player lock (the client can double click).
- All `avenger_grade` fields (ArmyMsg #43, RoomPlayerMsg #57, TeamPlayerInfoMsg #48, HeroMsg #111) are read from `avenger.profiles.body_grade` (0 for non-avengers).
- Combat stats contributed by the avenger (body, skills, holes, pearls) must be added to the hero attribute pipeline of the hero feature and reflected in the fighting capacity (the frame records capacity before/after, `AvengerFrame.as:59, 229`).

## 9. Open questions and assumptions

1. *(assumption)* The deification response pair is 4557 + 4556 like the dragon transfer; the client has no avenger-specific confirmation. The real server-side prerequisites (beyond task 1943) are unknown.
2. *(assumption)* Initial state after deification: armor grade 1, holes 0 and 1 open, first major and first minor skill in the formation.
3. *(assumption)* 4588 opType 0, 211 bagType 3 and 4276 are pushed at login; the client only requests op 0 when the frame opens.
4. No error code exists in `AvengerMsg`. Rejected requests should get no 4588 (the client then shows nothing). A generic tip channel may be used *(open question, owned by the core/chat area)*.
5. With `CHILD_NS = false`, task links of types 248-251 try to select tab 4, which does not exist.
6. NPC dialog option 146 placement (which NPC, which map) is server data; it is not in the client templates.
7. `docs/ui/navigation.md` (row `_starBtn.child`) says the avenger button opens at `thane.grades >= 18`; the code opens it only when `VersionSwitch.AVENGER && thane.isAvenger` (`CM/ui/maintoolbar/constant/MainToolCheckBtnOpen.as:68-69`, `MainToolBar.as:1076`). This file follows the code.

## 10. Implementation checklist

- [ ] Screen `AvengerFrame` with the 4 enabled tabs and tab selection from `frameData`
- [ ] Screen `AvengerEyeView` (vocation grade, Types 152)
- [ ] Screens `AvengerOtherView` / `AvengerOtherFrame` and `DevilArmorInfoView` / `DevilArmorLookInfoFrame`
- [ ] Entry points: toolbar star child button, hotkey X, task links 246/247/248-251/255-259, player info buttons 9 and 10
- [ ] Route 8658 C_THIRD_TRANSFER -> `avenger::core::handle_deify` (+ 4557, 4556, 150, 4588, 211)
- [ ] Route 8657 op 0 -> `avenger::core::handle_get_data`
- [ ] `avenger::core::dispatch_client_op` for ops 0..13 with feature switches
- [ ] Server message 4588 builder (all fields, opType echo)
- [ ] `ArmyMsg.avenger_grade #43`, `RoomPlayerMsg.avenger_grade #57`, `TeamPlayerInfoMsg.avenger_grade #48`
- [ ] `DetailRspMsg.avengerInfo #24` in 4125; ranking XML `<AvengerInfo>`
- [ ] Login push hook
- [ ] Table `avenger.profiles`
- [ ] Template loader: `UpGradeTempInfos` Types 152
- [ ] Test: non-avenger sending 8657 gets no answer
- [ ] Test: deification creates profile, 6 skills, armor, 6 holes, and the frame opens with all data
- [ ] Test: eye shows 30 for holy heroes and the cooldown value of Types 152
