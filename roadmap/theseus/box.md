# Theseus challenge ("Desafio de Teseus", code name thessbox / StoreHouse)

Area: Theseus PvE, module `box`. A chapter-based roguelike climb. The player enters one of **20 chapters** (`StoreHouseChapterTmpls.xml`), each a solo campaign of 10 to 37 floors (`StoreHouseMapTmpls.xml`, maps 40101..42035). Floor fights use battleType **3914**, whose HUD adds a bar with 3 extra Theseus skills. After each floor the player picks 1 of 3 offered skills; every 5th floor rolls a chest drop. Clearing a chapter unlocks the next and a one-time first-clear reward. 3 attempts per day.

Conventions:
- Paths are relative to `decompiled/` unless they start with `raw/`, `protocol/`, `index/`, `docs/` or `build/`.
- `CM` = `core_module/scripts`. `B3` = `m3/scripts/thessbox`.
- Opcode names come from `protocol/opcodes.csv`. The send code 9761 was also checked in `build/as3/gen/yishi/datas/consant/ProtocolType.ts:752`. Proto tags were checked against the AS3 `writeToBuffer` of `CM/com/road/yishi/proto/storehouse/*.as`.
- *(assumption)* marks anything the client does not prove.
- No HTTP servlet or AMF call is involved.

Related docs:
- `docs/battle/server-engine.md` §9: the `battle` rule object.
- `docs/battle/rules.md` row 3914 (`STORE_HOUSE`, `SILV:134-158`, `SGR:259`, `BRH:518-521`).
- `docs/world/README.md` §3.1: generic campaign flow (125, 21, 127, 5125, 22, 134).
- `docs/mechanics/world_progression.md` §3.3 (template summary).
- Sibling module: [tower.md](tower.md).

---

## 1. Overview

- **Flow.**
  1. The main frame "Desafio de Teseus" lists the 20 chapters, 3 per page, with the first-clear reward and the drop preview of each (op 0 loads the player state, push 769).
  2. "Desafiar" on chapter `passChapter + 1`, or on an already cleared chapter whose first reward was claimed, sends op 1. It needs a remaining daily attempt (`Storehouse_count` = 3).
  3. The server opens a solo campaign of that chapter (`Campaigns.xml` CampaignId 50101..50120, Types 29, Capacity 1) on the first floor map, and pushes 770 (run state).
  4. On a floor map (`WorldBossHelper.checkThessBox(mapId)`: 40101..43000) the client adds the left HUD `ThessBoxLeftView` ("{n}° andar", floor drop list, skill bag button).
  5. The player walks to node(s) and fights in battle 3914. The player hero carries 3 extra active skills (`HeroMsg.addSkills`) shown in an extra bar.
  6. After a cleared floor the server pushes 771 with 3 skill ids; `ThessBoxDropFrame` shows "Escolha uma das três habilidades acima como prêmio"; the choice is sent as op 3; the server confirms with 770 `type 3, addSkill`.
  7. Every 5th floor (rows with a non-empty `Award`) rolls one chest ("Baús de Drop extras podem ser obtidos a cada cinco andares").
  8. Clearing the last floor raises `passChapter`. The cleared chapter then shows "Prêmio de Primeira Conclusão do Capítulo", claimed with op 2.
- **Unlock.** `SwitchPageHelp.openThessBox` checks only the knight job change ("Ativado ao obter Profissão de Cavaleiro") and `checkScene()` (`CM/yishi/SwitchPageHelp.as:3185-3197`). No level, royalty or VIP gate.
- **Entry points (verified).**
  - The only caller of `openThessBox` is NPC dialog option **166** (`m3/scripts/map/space/view/frame/DialogOptionItem.as:895-896`).
  - Space NPC options come from the template field `MapNodeInfos.Param3` (`CM/map/space/SpaceManager.as:374-378`; `m3/scripts/map/space/view/frame/SpaceDialogFrame.as:203-205`).
  - **No row of `raw/xml/tempinfos/MapNodeInfos.xml` offers 166.** Node 49 "Eliza, chefe da Zona Proibida" offers 165 (tower) and 167 (dungeon) only. So the feature is **unreachable** with the shipped data.
  - No day guide, activity list, toolbar (`TopToolBtnInfos.xml`) or other `SwitchPageHelp` caller references the box (grep of `decompiled/` and `raw/xml/`).
  - Reopen after a 3914 battle: `BattleResultHandler` sets `thessbox = true` (`CM/battle/handler/BattleResultHandler.as:518-521`), and the space or castle scene reopens `ThessBoxMainFrame` (`m3/scripts/map/space/SpaceSceneController.as:494-496`, `m4/scripts/castle/CastleSceneView.as:358-360`). 3914 is not in the exit-scene switch, so the exit scene is the previous scene (`BattleResultHandler.as:103-107`): normally the floor map (`CAMPAIGN_MAP_SCENE`). It falls back to `SwitchPageHelp.returnScene` only when the campaign model is gone (`:344-347`). The reopen therefore fires only when the server closed the campaign during the battle.
- **Controller.** Key `"thessbox"` (`CM/yishi/datas/UIModuleTypes.as:654`) is served by the shared `CommonController` (`CM/yishi/manager/FrameControllerManager.as:2054-2056`). The frame class is the open type (`ThessBoxMainFrame`, `ThessBoxSkillBagFrame`, `ThessBoxDropFrame`, `ThessBoxSkillDesFrame`), resolved as style `ui.thessbox.<openType>` (`CM/mvc/controler/CommonController.as:28`). `show(frameData)` is called when data is passed (`:17-24`). The UI file is `thessbox.swf`, also loaded on box floor maps (`CM/yishi/scene/SceneCreate.as:382-385`) and by the dungeon key `dungenexplo` (`FrameControllerManager.as:1232-1233`).

---

## 2. Screens

| Class (file) | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `thessbox.ThessBoxMainFrame` (`B3/ThessBoxMainFrame.as`), style 852×564 (`raw/ui/zh_cn/xml/decoded/thessbox.xml:529-537`) | "Desafio de Teseus" (`thessbox.mainTitle`, :96) | Chapter list | Option 166; reopen after 3914 | Constructor sends op 0 (:32); redraws on `EVENT_BOX_USER` (:51, 69-72). Help button → `SimpleHelpFrame` `thessbox.helpFrame`, title "Instruções", text `thessbox.helpContent` (:62-67; xml :538-545) |
| `thessbox.view.ThessboxMainView` (`B3/view/ThessboxMainView.as`) | none | Chapter carousel | Main frame | `HRollItemPanel`, 3 items per page (:39-40); one `ThessBoxCapterItem` per chapter sorted by Id (`getAllCapters`, :43-53); "Tentativas de desafio restantes: {0}/{1}" with `{0} = max(0, Storehouse_count - count)`, `{1} = Storehouse_count` (`thessbox.leftTime`, :56-63) |
| `thessbox.view.ThessBoxCapterItem` (`B3/view/ThessBoxCapterItem.as`) on `ThessboxCapterUI` | `ChaptersName` (e.g. "Desafio de Teseus - Capítulo 1") | One chapter card | Main view | Icon `txschallengeNN.jpg`; "Prêmio de Primeira Conclusão do Capítulo" = `FirstPassAward` items; "Prévia de Drop do Capítulo" = `PassDropAward` ids (count 0) (:52-101). Buttons `_gotoFtBtn` (challenge) and `_rtBtn` (claim), passed stamp `_chapter6` (:103-147, rules in §5) |
| `thessbox.ThessBoxDropFrame` (`B3/ThessBoxDropFrame.as`), style 700 wide, no title, sprite background (`thessbox.xml:813-818`) | none | Pick 1 of 3 skills | Push 771 → `openControllerByInfo("thessbox","ThessBoxDropFrame",msg)` (`CM/managers/TheseussoulManager.as:616-622`); `show(msg)` (:138-142) | `ThessBoxChooseView` (`B3/view/ThessBoxChooseView.as:27-41`): three `ThessBoxAddNUI` cells with `addSkills[0..2]` (icon and tip from `SkillTempInfos`; a cell with id <= 0 is hidden, `B3/ui/ThessBoxAddNUI.as:46-61`); text "Escolha uma das três habilidades acima como prêmio" (`thessbox.threeOfOne`); first cell preselected. On 770 with `type == 3 && addSkill > 0` an icon flies to the HUD bag and the frame disposes (:105-118, 53-103) |
| `thessbox.ThessBoxSkillBagFrame` (`B3/ThessBoxSkillBagFrame.as`), 625×522 | "Mochila de habilidades" (`thessbox.skT3`, :66) | Run skills | HUD bag button (`B3/view/ThessBoxLeftView.as:92-95`) | `ThessBoxBagView` (`B3/view/ThessBoxBagView.as:80-204`), built once at open (no refresh listener): "Habilidade Atual" (`thessbox.skT1`) = 3 cells from `equipSkills` CSV; "Habilidades Obtidas" (`thessbox.skT2`) = 36-cell grid with every `allSkills` id that is **not** in `SkillPropertyTempInfos`; right panel = sum of the attribute bonuses of the `allSkills` ids that **are** in `SkillPropertyTempInfos` (`AddType 1` flat, `AddType 0` percent, :104-199) |
| `thessbox.view.ThessBoxLeftView` (`B3/view/ThessBoxLeftView.as`) on `ThessBoxLeftUI` | none (HUD) | Floor HUD | `ThessBoxMediator` (`m3/scripts/map/campaign/mediator/mapview/ThessBoxMediator.as:17-27`), registered by `CampaignMapView` when `checkThessBox(mapId)` (`m3/scripts/map/campaign/view/CampaignMapView.as:404-407`); `y = 295`, layer 4 | "{0}° andar" with `curLevel` (`thessbox.dx`); drop list of `StoreHouseMapTmpls[mapId, chapterId].Award` as `ThessBoxDropItem` (item, count, `weight/10` "%", `B3/view/ThessBoxDropItem.as:33-48`), or "Baús de Drop extras podem ser obtidos a cada cinco andares. Este andar não tem drop." (`thessbox.empetyTip`) (:103-144); bag button; slide toggle (:60-90). Redraws on `EVENT_BOX_FIGHT` (:48) |
| Battle 3914 extra skill bar (`CM/battle/view/ui/SkillItemListView.as:134-158`) | none | 3 extra skill buttons | Battle 3914 | Background `asset.battle.comAddSkbg`, 3 `BattleSkillItemII(4)` from `selfHero.thessBoxSkills` (ids <= 0 empty). Clicks send the normal skill notification (`__skillClick` :414-424 → `ACTION_SKILL_BattleNotic`, i.e. the 10008 skill request) |

Map scene details: box maps count as "fog-free" maps (`WorldBossHelper.checkFogMap` includes `checkThessBox`, `CM/yishi/utils/WorldBossHelper.as:64-66`), so no fog, no team list (`CampaignMapView.as:179-183`), and a static background layer (`:448`).

Dead UI (never instantiated, verified by grep): `ThessBoxRightView` (the only opener of `ThessBoxSkillDesFrame`; that class does not exist in the decompiled code even though its style is in `thessbox.xml:692-700`), `ThessBoxSkillItem`, `ThessboxAddSkillUI` ("Habilidade de Bênção"), `ThessBoxRankItemUI`, `ThessBoxMainUI` (sort and goto buttons). `ThessBoxSkillCell.registerMediator` (`B3/view/ThessBoxSkillCell.as:65-70`) is never called, so the drag (`ThessBoxSkillCellDropMediator`) and double-click unequip (`ThessBoxSkillCellClickMediator.as:50-65`, local only, no packet) are inactive. `ShopControler.initthessboxShopFrame` (`CM/mvc/controler/ShopControler.as:1741-1749`) has no caller and reads the collection shop. The bag screen therefore **has no equip action**.

---

## 3. Routes (client to server)

All box requests are **9761 (0x2621) C_STORE_HOUSE_CLIENT_OP** with `com.road.yishi.proto.player.PlayerOpMsg`, sent by `TheseussoulManager.opThessbox(op, chapterId)` (`CM/managers/TheseussoulManager.as:607-614`). Fields set: `op (#1, INT32)` and `chapterId (#11, INT32)` (tags at `CM/com/road/yishi/proto/player/PlayerOpMsg.as:476, 526`). No other sender of 9761 exists in `decompiled/` or `build/as3/gen` (grep).

| # | UI control | Client sender (file:line) | Client checks, in order | Request | Expected response, in order |
|---|---|---|---|---|---|
| B0 | Main frame opens | `ThessBoxMainFrame()` (`B3/ThessBoxMainFrame.as:32`) | entry checks (knight job, `checkScene`) only when opened from option 166 | `op=0, chapterId=0` (open) | **769** (`opType 0`, `count`, `passChapter`, `firstReward`) |
| B1 | "Desafiar" (`_gotoFtBtn`) on a chapter card | `ThessBoxCapterItem.gotoFightHandler` (`B3/view/ThessBoxCapterItem.as:166-176`) | 1. button visible only on chapter `passChapter+1`, or on a cleared chapter whose Id is in `firstReward` (:112-141); 2. `Storehouse_count - count > 0`, else "Tentativas de Desafio Insuficientes" (`thesebox.chapterNoFight`). No confirm | `op=1, chapterId=<StoreHouseChapterTmpl.Id>` (enter chapter) | **769** (`count + 1`) *(assumption: the attempt is spent on entry)*; **770** (run state, floor 1); campaign entry: **125 U_C_CAMPAIGN_CREATE** (map = first floor of the chapter), **21 U_C_CAMPAIGN_ENTER**, **127 U_C_CAMPAIGN_NODE** *(assumption, generic campaign flow, `docs/world/README.md` §3.1)* |
| B2 | Claim button (`_rtBtn`, image button, no text key) on a cleared chapter | `ThessBoxCapterItem.rewardHandler` (:161-164) | button visible only when `Id <= passChapter` and Id not in `firstReward` (:131-135) | `op=2, chapterId=<Id>` (claim first-clear reward) | **769** with the Id appended to `firstReward`; `FirstPassAward` items through the inventory pushes *(assumption)* |
| B3 | Confirm button (`_comfrimBtn`) in the 1-of-3 frame | `ThessBoxChooseView.comfrimHandler` (`B3/view/ThessBoxChooseView.as:53-61`) | sends only if the selected cell id > 0; the button is disabled after one click | `op=3, chapterId=<chosen skill id>`. **The skill id travels in `chapterId (#11)`** | **770** with `type=3`, `addSkill=<skill id>`, updated `allSkills` (and `equipSkills`). The client animates and closes the frame only when `type == 3 && addSkill > 0` |
| B4 | Walk to a floor node | generic campaign: `MapSocketOuterManager.sendCampaignArrive` → **5125 (0x1405) U_C_CAMPAIGN_ARRIVE** `CampaignReqMsg{paraInt1 (#1) = campDataId}` (`docs/world/README.md` §3.1) | generic node checks | generic | battle **157** with `battle_type 3914`, map = floor map id; then 156, 153..., 154, 4103 |
| B5 | Use an extra skill in battle 3914 | `SkillItemListView.__skillClick` (`CM/battle/view/ui/SkillItemListView.as:414-424`) | generic battle checks | **10008 (0x2718) U_B_HERO_ORDER** (`docs/battle/server-engine.md` §7) | **75 (0x004b) U_B_HERO_ORDER** and the attack sequence |
| B6 | Leave the floor map | generic campaign exit **5120 (0x1400) U_C_CAMPAIGN_EXIT** (campaign HUD) | generic | generic | **22 (0x0016) U_C_CAMPAIGN_EXIT**, back to space *(assumption: the run ends and the attempt stays spent)* |
| B7 | Help, bag, HUD toggle, carousel arrows | client only | none | none | none |

There is no route for ranking, equip/unequip, reset, attempt purchase or VIP.

---

## 4. Server messages (server to client)

Listeners are registered in `TheseussoulManager.setup()` (`CM/managers/TheseussoulManager.as:232-234`). Nobody else in `decompiled/` or `build/as3/gen` listens to 769, 770 or 771 (grep).

| Opcode | Name | Message, fields (tag, type) | Client receiver (file:line) | When to send | Client reaction |
|---|---|---|---|---|---|
| 769 (0x0301) | U_C_STOREHOUSE_USER_DATA | `storehouse.StoreHouseUseMsg`: `opType (#1, INT32)` op that produced it (stored, never read); `count (#2, INT32)` attempts used today; `passChapter (#3, INT32)` highest cleared chapter 0..20; `firstReward (#4, STRING)` CSV of chapter ids whose first-clear reward was **claimed** (e.g. `"1,2"`, empty for none). Tags at `CM/com/road/yishi/proto/storehouse/StoreHouseUseMsg.as:119-134` | `__thessBoxDataHandler` (`TheseussoulManager.as:624-634`) → `ThessBoxInfo` (`CM/mvc/module/theseus/ThessBoxInfo.as:6-37`, `firstReward` split on ","; a repeated identical string is ignored) → `EVENT_BOX_USER` | Response to op 0, 1, 2; after a chapter clear; at the daily reset if the frame is open *(assumption)* | Main view redraws counts and every card (`ThessboxMainView.as:56-71`) |
| 770 (0x0302) | U_C_STOREHOUSE_FIGHT_DATA | `storehouse.StoreHouseFightMsg`: `type (#1, INT32)` 3 = "skill added" (other values unknown, ignored); `curLevel (#2, INT32)` floor number inside the chapter (1-based) shown as "{n}° andar"; `chapterId (#3, INT32)`; `mapId (#4, INT32)` current floor `MapInfos` id (e.g. 40105), key of the HUD drop lookup together with `chapterId`; `equipSkills (#5, STRING)` CSV of the 3 equipped skill ids, `-1` for empty (default `"-1,-1,-1"`, `ThessboxFightInfo.as:14`); `allSkills (#6, INT32, repeated)` all skills obtained in the run; `addSkill (#7, INT32)` skill just added. Tags at `StoreHouseFightMsg.as:168-200`; `allSkills` is written unpacked (wire type 0 per element, :194) | `__thessBoxFightDataHandler` (`TheseussoulManager.as:636-649`) → `ThessboxFightInfo` → `EVENT_BOX_FIGHT` | Response to op 1 (floor 1, `type` != 3); response to op 3 (`type=3`, `addSkill`); on each floor change | `ThessBoxLeftView` redraws (`ThessBoxLeftView.as:103-144`); `ThessBoxDropFrame.updateHandler` flies the icon and closes when `type == 3 && addSkill > 0`, then resets `type` to 0 (:105-118). The bag frame reads the model when it opens |
| 771 (0x0303) | U_C_STOREHOUSE_ADD_SKILL | `storehouse.StoreHouseAddSkillMsg`: `addSkills (#1, INT32, repeated)` the 3 offered skill ids (tag at `StoreHouseAddSkillMsg.as:24`) | `__thessBoxADDSKHandler` (`TheseussoulManager.as:616-622`) | After a floor is cleared, once the player is back on the floor map *(assumption: the frame opens on whatever scene is current)* | Opens `ThessBoxDropFrame` with the 3 choices |
| 125, 21, 127, 22, 134 | U_C_CAMPAIGN_CREATE, U_C_CAMPAIGN_ENTER, U_C_CAMPAIGN_NODE, U_C_CAMPAIGN_EXIT, U_C_CAMPAIGN_FINISH | generic campaign messages (`docs/world/README.md` §3.1) | `CampaignManager` / `CampaignSocketManger` | Enter the chapter, move to the next floor (125 with `created_type 3`), leave or finish | The floor map loads; `ThessBoxMediator` adds the HUD |
| 157, 156, 153, 154, 4103 | battle | `docs/battle/README.md`. In 157 the player `HeroMsg.addSkills (#117, INT32, repeated)` (tag at `CM/com/road/yishi/proto/battle/HeroMsg.as:3125`) carries the 3 extra skills | `SocketGameReader.readHeroRoleInfo` stores it as `thessBoxSkills` (`CM/map/internals/utils/SocketGameReader.as:259`; field `CM/yishi/datas/objects/HeroRoleInfo.as:99`) | Each floor fight | Extra bar of §2. Exit to the previous scene (the floor map) |

**StoreHouseRankListMsg** `{ranks (#1, StoreHouseRankMsg, repeated)}` with **StoreHouseRankMsg** `{rank (#1, INT32), level (#2, INT32), nickName (#3, STRING)}` (tags at `StoreHouseRankListMsg.as:24`, `StoreHouseRankMsg.as:95-105`): **nobody reads it**. No opcode in `protocol/opcodes.csv` maps to it (772-778 belong to Sky Treasure), the event `EVENT_BOX_RANK` (`TheseussoulManager.as:79`) is never dispatched, and `ThessBoxRankItemUI` is never created. The language keys `thessbox.rank.layer` "Andares Concluídos", `thessbox.rank.reward` "Conteúdo", `thessbox.rank.passlv` "{0} Andares Concluídos" are orphans. Do not implement.

No result or error codes exist. A server-side refusal should resend 769 / 770 with the true state, or use **126 U_C_MSG** *(assumption)*.

---

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Daily attempts | `Storehouse_count` = 3; remaining = `max(0, 3 - count)` | `ThessboxMainView.as:35, 61-63`; `ConfigInfos.xml` ("每天3次挑战次数0点刷新") |
| Daily reset | 00:00 ("redefinidas diariamente às 24:00"); `count = 0` | help item 3; config comment |
| Attempt spent | on chapter entry (op 1) *(assumption)*; the client checks the counter before op 1 only | `ThessBoxCapterItem.as:166-176` |
| Chapter card state | `Id <= passChapter`: stamp; if Id in `firstReward` → challenge button + first rewards marked obtained, else claim button only. `Id == passChapter+1`: challenge button. Else: no button | `ThessBoxCapterItem.as:103-147` |
| Chapter entry allowed | `chapterId == passChapter + 1`, or `chapterId <= passChapter` with its first reward claimed (client); the server should accept `1 <= chapterId <= passChapter + 1` *(assumption)* | same |
| Floors of a chapter | rows of `StoreHouseMapTmpls` with `Chapters = id`, ordered by `MapId` *(assumption)*; floor n = n-th MapId. Counts: ch1 10, ch2 15, ch3-5 20, ch6-10 25, ch11-16 30, ch17 37, ch18 33, ch19-20 35 | template |
| Data anomaly | MapIds 41801 and 41802 are tagged `Chapters="17"` (`MapInfos` names them chapter 18 floors 1-2). Chapter 18 then starts at 41803. Keep the template key `(MapId, Chapters)` as is, because the HUD looks rows up by `mapId_chapterId` (`ThessBoxMapCate.as:21-41`) | `StoreHouseMapTmpls.xml`, `MapInfos.xml` |
| Skill offer | 3 distinct ids drawn from the floor's `SkillGroup` (`skillId,weight\|...`), weighted, without replacement *(assumption)*. Ch1 floor 1 lists exactly 3 skills (`90301001,1000\|90302001,1000\|90201001,1000`) | template; `thessbox.threeOfOne` |
| Skill pool | 133 distinct ids: 111 stat boosts present in `SkillPropertyTempInfos` (e.g. 90301001 "Fortalecimento de Ataque Físico I" `AddType 1, Attack 100`; 90201001 "Fortalecimento de Vida I" Vida +500) and 22 modifiers of the main skills (e.g. 90113001 "Escudo de Teseus I" dano recebido -5%, 90209001 "Luz de Teseus II" -4 s cooldown, 90319001 "Espada de Teseus I" +20%) | `SkillTempInfos.xml`, `SkillPropertyTempInfos.xml` |
| Main (equipped) skills | `Storehouse_MainSkill` = `90100000\|90200000\|90300000`: "Escudo de Teseus" (dano recebido -40%, 3 turnos), "Luz de Teseus" (recupera 20% da vida), "Espada de Teseus" (+50% dano, 3 turnos); UseWay 1, CoolDown 120000 ms. The client never reads the key; the server sends them as `equipSkills` and `HeroMsg.addSkills` *(assumption)* | `ConfigInfos.xml`; `SkillTempInfos.xml` |
| Skill effects in battle | stat boosts add to the hero stats (flat for `AddType 1`, percent for `AddType 0`, as summed in the bag view); modifiers change the 3 main skills *(assumption, server battle engine)* | `ThessBoxBagView.as:104-199` |
| Run scope | `allSkills` and `equipSkills` belong to one run and reset on a new entry *(assumption)* | |
| Floor drop | rows with `Award` (every 5th floor: 40105, 40110, ...): `itemId,count,weight` with weights summing to 1000; one weighted pick per clear *(assumption)*; displayed chance = weight / 10 % | `ThessBoxDropItem.as:40-46`; help item 2 |
| Drop chests | 3501 "Baú de Bronze", 3502 "Baú de Prata", 3503 "Baú de Ouro", 3504 "Baú de Platina", 3505 "Baú de diamante" (SonType 350, opened from the bag) | `ItemTempInfos.xml` |
| First-clear reward | `FirstPassAward` once per chapter, claimed with op 2 (ch1 `3501,2\|3502,2`; ch20 `3501,1\|3502,1\|3503,1\|3504,1\|3505,1`) | template; help item 2 |
| Chapter clear | after the last floor: `passChapter = max(passChapter, chapterId)` | `ThessBoxInfo.passChapter` usage |
| Defeat | the run ends *(assumption)*; the attempt stays spent | |
| Unlock | knight job only | `SwitchPageHelp.as:3185-3197` |

---

## 6. Templates

| File | Record | Fields used by the client | Fields for the server |
|---|---|---|---|
| `raw/xml/tempinfos/StoreHouseChapterTmpls.xml` (20 rows), loaded as `StoreHouseChapterTmpls` into `ThessBoxTempCate` keyed by `Id` (`CM/yishi/manager/TempleteManager.as:1425`; `CM/yishi/datas/templates/cate/ThessBoxTempCate.as:18-48`) | one chapter | `Id`; `ChaptersName` ("Desafio de Teseus - Capítulo 1"); `Icon` (`txschallenge01.jpg`); `FirstPassAward` `itemId,count\|...`; `PassDropAward` preview ids (`3501,3502`) | `CampaignId` (50101..50120) |
| `raw/xml/tempinfos/StoreHouseMapTmpls.xml` (530 rows), loaded as `StoreHouseMapTmpls` into `ThessBoxMapCate` keyed by `MapId + "_" + Chapters` (`TempleteManager.as:1426`; `ThessBoxMapCate.as:21-55`) | one floor | `MapId`, `Chapters`, `Award` (`3501,1,900\|3502,1,100`, empty on most floors) | `SkillGroup` (`skillId,weight\|...`, 3 to 45 entries) |
| `raw/xml/tempinfos/Campaigns.xml` CampaignId 50101..50120 | chapter campaign | none | `CampaignName` "Desafio de Teseus - Capítulo N", `Types` 29, `SonTypes` 29999, `Capacity` 1, `NeedTransfer` true, `MapIds` "232045,5" (same on all; 232045 is GameHeroTemp "Kronde", meaning unknown) |
| `raw/xml/tempinfos/MapInfos.xml` Id 40101..42035 | floor map | campaign map loading | `CampaignId`, `MapName` "Desafio de Teseus - Capítulo 1 Andar 1", `MapFileId` 8001, `BattleGround` 10 (battle background), 1900×1800 |
| `raw/xml/tempinfos/SkillTempInfos.xml`, `SkillPropertyTempInfos.xml` | skills | icon, name, description, cooldown (`getSkillById`); attribute bonuses (`skillPropertyTemplateCate`) | effects |
| `raw/xml/tempinfos/ConfigInfos.xml` | config | `Storehouse_count` = 3 | `Storehouse_MainSkill` |
| `raw/xml/tempinfos/MapNodeInfos.xml` | NPC options | node 49 has no option 166 | entry (see §9) |

Floor nodes (monsters, start point, exits) are **not** in the client data: `raw/maps/8001` is missing and `MapNodeInfos.xml` has no row for maps 401xx-420xx. They must be server-defined (`127` node list), and the map file 8001 must be fetched with the user's approval (see CLAUDE.md asset rule).

---

## 7. Persistent state (PostgreSQL, schema `theseus`)

```sql
CREATE SCHEMA IF NOT EXISTS theseus;

CREATE TABLE theseus.box_progress (
  player_id       bigint      PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
  pass_chapter    smallint    NOT NULL DEFAULT 0 CHECK (pass_chapter BETWEEN 0 AND 20),
  attempts_used   smallint    NOT NULL DEFAULT 0 CHECK (attempts_used >= 0),
  attempts_day    date        NOT NULL DEFAULT CURRENT_DATE,
  best_chapter    smallint    NOT NULL DEFAULT 0,
  best_floor      smallint    NOT NULL DEFAULT 0,
  updated_at      timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE theseus.box_first_reward (
  player_id   bigint      NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  chapter_id  smallint    NOT NULL CHECK (chapter_id BETWEEN 1 AND 20),
  claimed_at  timestamptz NOT NULL DEFAULT now(),
  PRIMARY KEY (player_id, chapter_id)
);

CREATE TABLE theseus.box_run (
  player_id       bigint      PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
  chapter_id      smallint    NOT NULL CHECK (chapter_id BETWEEN 1 AND 20),
  floor_no        smallint    NOT NULL DEFAULT 1 CHECK (floor_no >= 1),
  map_id          integer     NOT NULL CHECK (map_id BETWEEN 40101 AND 43000),
  state           smallint    NOT NULL DEFAULT 0 CHECK (state IN (0, 1, 2)),
  equip_skills    integer[]   NOT NULL DEFAULT '{-1,-1,-1}' CHECK (cardinality(equip_skills) = 3),
  offered_skills  integer[]   NOT NULL DEFAULT '{}' CHECK (cardinality(offered_skills) <= 3),
  campaign_uuid   uuid,
  started_at      timestamptz NOT NULL DEFAULT now(),
  updated_at      timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE theseus.box_run_skill (
  player_id   bigint      NOT NULL REFERENCES theseus.box_run(player_id) ON DELETE CASCADE,
  seq         smallint    NOT NULL CHECK (seq >= 1),
  skill_id    integer     NOT NULL,
  floor_no    smallint    NOT NULL,
  acquired_at timestamptz NOT NULL DEFAULT now(),
  PRIMARY KEY (player_id, seq)
);
CREATE INDEX box_run_skill_skill ON theseus.box_run_skill (player_id, skill_id);
```

- `box_run.state`: 0 fighting the floor, 1 waiting for the 1-of-3 choice (`offered_skills` set), 2 chapter cleared or finished (row deleted on exit) *(assumption)*.
- One active run per player (primary key). A new op 1 replaces any stale run.
- `box_run_skill` keeps the order of `allSkills` (duplicates allowed: the same boost can be picked twice *(assumption)*).
- `best_chapter` / `best_floor` only matter if the dead ranking (`StoreHouseRankMsg.level`) is ever revived; optional.
- `attempts_used` resets lazily when `attempts_day < CURRENT_DATE`.

---

## 8. Backend implementation notes

`box` is a reserved keyword in Rust: declare the module as `pub mod r#box;` (or `#[path = "box.rs"] pub mod r#box;`) so handlers keep the names `theseus::box::handle_<action>`.

### Handlers

| Handler | Route | Validation order | Transaction and output |
|---|---|---|---|
| `theseus::box::handle_open` | 9761 op 0 | knight job | Load or create `box_progress`, apply the daily reset, send 769 (`opType 0`) |
| `theseus::box::handle_enter_chapter` | 9761 op 1 | knight job → daily reset → `attempts_used < Storehouse_count` → `1 <= chapterId <= pass_chapter + 1` → if `chapterId <= pass_chapter`, first reward claimed (mirrors the client) → player not in battle, room or another campaign | One tx: `attempts_used += 1`, delete the old run, insert `box_run` (floor 1, first MapId of the chapter, `equip_skills = Storehouse_MainSkill`). After commit: 769, 770 (`type 1` *(assumption)*, curLevel 1), then create the solo campaign instance (CampaignId from the chapter) and send 125, 21, 127 with the floor nodes |
| `theseus::box::handle_claim_first_reward` | 9761 op 2 | `chapterId <= pass_chapter` → no `box_first_reward` row | One tx: insert the row, grant `FirstPassAward`. Send 769 (`opType 2`) and inventory pushes |
| `theseus::box::handle_choose_skill` | 9761 op 3 (`chapterId` = skill id) | run exists → `state = 1` → skill id in `offered_skills` | One tx: append `box_run_skill`, clear `offered_skills`, set `state 0`, advance `floor_no` and `map_id` to the next floor. Send 770 (`type 3`, `addSkill`, `allSkills`, `equipSkills`, new `curLevel`/`mapId`), then move the player to the next floor map (125 `created_type 3`, 21, 127) |
| `theseus::box::handle_floor_fight` | 5125 on a map in 40101..43000 (the campaign router delegates) | run exists, `state = 0`, node belongs to the floor | Start battle 3914 (below) |
| `theseus::box::on_battle_report` | engine callback after 4103 | | Win, one tx: if the floor row has `Award`, roll and grant one chest; if it was the last floor, `pass_chapter = max(pass_chapter, chapter_id)`, update best, finish the run (134, 22) and send 769; else roll 3 skills from `SkillGroup`, set `state 1`, store `offered_skills`, then send 771 after the client is back on the floor map. Defeat: finish the run (22) *(assumption)* |
| `theseus::box::handle_leave` | 5120 on a box map | run exists | Delete the run, send 22 *(assumption)* |

Pushes to other players: none (solo, Capacity 1).

### Schedules

- Daily reset at 00:00 server time, applied lazily (`attempts_day < CURRENT_DATE` → `attempts_used = 0`). Optional push of 769 to players with the frame open.
- Stale runs (player offline for long) can be dropped at login *(assumption)*.

### Battle configuration (`docs/battle/server-engine.md` §9.2)

```json
{"battle_id":"<uuid>","battle_type":3914,"map":"<box_run.map_id, e.g. 40101>","count_down":180,
 "heroes":[ {"user_id":"$player.id","pos":2,
             "addSkills":[90100000,90200000,90300000],
             "phy_attack":"<base + flat/percent boosts of allSkills>","max_hp":"<base + boosts>"},
            <enemy heroes of the floor node: server data, unknown> ],
 "soldiers":[ <player soldiers>, <enemy soldiers of the node> ],
 "report":{"battle_result":1,"items":"<rolled Award chest, if any>"},
 "report_defeat":{"battle_result":2}}
```

- `addSkills` is a `HeroMsg` field (#117); the engine passes message fields through, and the client reads it into `thessBoxSkills`. Each id must also be in the hero's usable skills so a 10008 request on it resolves, and in `skillId` so the client preloads it *(assumption on the engine side)*.
- The player's main skill modifiers (90113xxx, 90208xxx, 90319xxx...) change the 3 main skills (damage reduction, heal amount, damage bonus, cooldown) *(assumption)*.
- `map` = floor `MapInfos` id; its `BattleGround` 10 gives the background.
- The exit returns to the floor map (previous scene); keep the campaign instance alive during the battle unless the run ends.

### Pushes from other modules that the box must not break

`DungenBoxSkillCellClickMediator` of the dungeon (`m11/scripts/dungenexploration/view/DungenBoxSkillCellClickMediator.as:55`) reads `thessboxInInfo`, a copy-paste from this module; the exploration backend must not rely on 770.

---

## 9. Open questions and assumptions

1. **Entry.** No NPC offers option 166, so the box is unreachable with the shipped `MapNodeInfos.xml`. Options: add `166,Desafio de Teseus` to node 49 `Param3` (template data change, needs a decision under the fidelity rule), or accept the feature as disabled in this build.
2. Floor content: node layout, monsters per floor and the map file `maps/8001` are not in the assets. The server must define them; the map file must be fetched with approval.
3. `StoreHouseFightMsg.type` values other than 3, and whether 770 is sent on every floor change.
4. Whether the attempt is spent at entry (assumed) or at the first fight; whether a defeat or an exit ends the run.
5. The skill draw rule (3 distinct, weighted, without replacement assumed) and whether duplicates of a boost can stack.
6. `equipSkills` content (assumed the 3 `Storehouse_MainSkill` ids) and whether the 22 "modifier" skills ever become equipped (no equip route exists).
7. Chest drop rule on `Award` rows (one weighted pick assumed) and its delivery (battle report items vs bag push).
8. Ranking: `StoreHouseRankListMsg` has no opcode and no reader; ignored.
9. The `MapId` 41801/41802 chapter tag anomaly (chapter 17 vs 18).
10. Registry overlap: `roadmap/features.json` lists the `storehouse` proto package under [inventory](../inventory/README.md), while the client package `thessbox` is under theseus. This module owns all `storehouse` messages; inventory only delivers the chest items.
11. Dependencies: [hero](../hero/README.md) (knight job), [campaign](../campaign/README.md) (solo campaign instance, 125/21/127/5125/22), [battle](../battle/README.md) (3914, `addSkills`, 10008), [inventory](../inventory/README.md) (chests 3501-3505), [skills](../skills/README.md) (SkillTempInfos/SkillPropertyTempInfos), [sky-realm](../sky-realm/README.md) (NPC dialog), [exploration](../exploration/README.md) (dungeon UI that reuses `thessbox.swf`).

---

## 10. Implementation checklist

**Client screens (already in the original client; verify against the backend):**

- [ ] `ThessBoxMainFrame` + `ThessboxMainView`: op 0 on open, attempts text, carousel of 20 chapters
- [ ] `ThessBoxCapterItem`: stamp, challenge and claim buttons per §5 state rule; first reward and drop preview
- [ ] `ThessBoxDropFrame` + `ThessBoxChooseView`: 3 choices from 771, confirm op 3, close on 770 `type 3`
- [ ] `ThessBoxSkillBagFrame` + `ThessBoxBagView`: equipped CSV, obtained grid, attribute summary
- [ ] `ThessBoxLeftView` HUD on maps 40101..43000: floor number, Award list or empty tip, bag button
- [ ] Battle 3914 extra skill bar from `HeroMsg.addSkills`
- [ ] Help frame `thessbox.helpContent`
- [ ] Entry decision for option 166 (§9.1); reopen after 3914 when the campaign is gone

**Routes and messages:**

- [ ] 9761 op 0 → `theseus::box::handle_open` → 769
- [ ] 9761 op 1 → `theseus::box::handle_enter_chapter` → 769, 770, 125, 21, 127
- [ ] 9761 op 2 → `theseus::box::handle_claim_first_reward` → 769 + items
- [ ] 9761 op 3 (skill id in `chapterId`) → `theseus::box::handle_choose_skill` → 770 `type 3` + next floor
- [ ] 5125 on box maps → `theseus::box::handle_floor_fight` → battle 3914
- [ ] 4103 → `theseus::box::on_battle_report` → Award roll, 771 offer or chapter clear
- [ ] 5120 on box maps → `theseus::box::handle_leave` → 22
- [ ] 769 `StoreHouseUseMsg` (opType, count, passChapter, firstReward CSV)
- [ ] 770 `StoreHouseFightMsg` (type, curLevel, chapterId, mapId, equipSkills CSV, allSkills unpacked, addSkill)
- [ ] 771 `StoreHouseAddSkillMsg` (exactly 3 ids)
- [ ] Do not implement `StoreHouseRankListMsg`

**Rules:**

- [ ] 3 attempts per day, reset at 00:00
- [ ] Chapter entry window `1..pass_chapter+1`, claimed-first-reward rule for replays
- [ ] Floor order by MapId inside `Chapters`; last floor clears the chapter
- [ ] Skill offer from `SkillGroup` weights; boosts applied to hero stats in 3914
- [ ] `Award` chest roll every 5th floor; `FirstPassAward` once per chapter
- [ ] Knight job unlock

**Templates:**

- [ ] Loaders for `StoreHouseChapterTmpls` and `StoreHouseMapTmpls` (key `MapId_Chapters`)
- [ ] `Campaigns` 50101..50120 and `MapInfos` 40101..42035 for the campaign instance
- [ ] Config `Storehouse_count`, `Storehouse_MainSkill`
- [ ] `SkillTempInfos` / `SkillPropertyTempInfos` lookups for the 133 pool ids

**Tables:**

- [ ] `theseus.box_progress`
- [ ] `theseus.box_first_reward`
- [ ] `theseus.box_run`
- [ ] `theseus.box_run_skill`

**Tests:**

- [ ] `node server/flowtest.mjs` with 9761 op 0 returns 769 with the four fields
- [ ] op 1 refused at 3 attempts or on a locked chapter; accepted path sends 769, 770 and the campaign entry on map 40101 for chapter 1
- [ ] op 3 with an id not offered is refused; a valid id returns 770 `type 3` and moves to the next floor
- [ ] op 2 grants `FirstPassAward` once; a second claim is refused
- [ ] `node server/battletest.mjs` with a 3914 rule: the extra bar shows the 3 main skills and a 10008 on one of them resolves
- [ ] Clearing the last floor raises `pass_chapter` and the next chapter card shows "Desafiar"
- [ ] Daily reset across midnight restores 3 attempts
