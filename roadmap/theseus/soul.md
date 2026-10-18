# Theseus: main frame "Alma de Teseu", data sync and inspection

Module `soul`. The shell of the Theseus system: the main frame with its four tabs, the open request that loads every Theseus model, the property totals shown in the attribute side panel, the vice password lock routes used by Theseus cells, and the read-only view of another player's Theseus.

Path aliases:

| Alias | File |
|---|---|
| MGR | `decompiled/core_module/scripts/managers/TheseussoulManager.as` |
| MOD | `decompiled/core_module/scripts/mvc/module/theseus/TheseussoulModel.as` |
| CTL | `decompiled/core_module/scripts/mvc/controler/TheseussoulController.as` |
| FCM | `decompiled/core_module/scripts/yishi/manager/FrameControllerManager.as` |
| T | `decompiled/m5/scripts/theseus` |
| CM | `decompiled/core_module/scripts` |

Conventions: opcode names from `protocol/opcodes.csv`, proto fields from `protocol/proto.json` (tags of `PlayerOpMsg` re-checked against `CM/com/road/yishi/proto/player/PlayerOpMsg.as:476-573`; `ids` is written unpacked, one tag 20 per element). *(assumption)* marks anything the client does not prove.

---

## 1. Overview

- "Alma de Teseu" (`theseus.equip.mainFrame`) is a late game character system unlocked by the "Caminho da Realeza" (royalty boss) progress and by deification. It has four tabs (image buttons, no text):
  1. Armadura de Teseu (armor equipment, nine suits): see [equipment-suits.md](equipment-suits.md) and [war-frame.md](war-frame.md).
  2. Intenção de Guerra (12 rage positions): see [war-intent.md](war-intent.md).
  3. Tesouro / "Selo Regenerador" (treasure slots and core): see [treasure.md](treasure.md).
  4. Espírito da Guerra (war souls), only after quest 1389: see [war-soul.md](war-soul.md) and [war-soul-training.md](war-soul-training.md).
- Opening the frame sends 8680 op 1 (`OP_OPEN`). The client never requests the data otherwise, so the server answers op 1 with a full snapshot of every Theseus model (assumption, see §9 Q1).
- All Theseus requests go through two opcodes with `player.PlayerOpMsg`:
  - 8680 `C_THESEUS_CLIENT_OP`: open, war intent, treasure core, all war soul operations (`MGR:969-978`, `MGR:995-1008`).
  - 8684 `C_THESEUS_WARFRAMECLIENT_OP`: Theseus armor bag and armor upgrades (`MGR:980-993`).
- Op constants (`MGR:89-147`):

| Opcode | op | Constant | Used | Module |
|---|---|---|---|---|
| 8680 | 1 | OP_OPEN | yes | soul |
| 8680 | 2 / 3 | OP_EQUIP / OP_UNEQUIP | no sender (legacy, replaced by 8684 ops 7/8) | |
| 8680 | 4 | OP_RAGE_STRENGTHEN | yes | war-intent |
| 8680 | 5 | OP_CORE_STRENGTHEN | yes | treasure |
| 8680 | 6 | OP_TIDY_BAG | no sender (replaced by 8684 op 1) | |
| 8680 | 7, 8, 9 | OP_WARSOUL_HATCH, _FAST, _GET | yes | war-soul |
| 8680 | 10 | OP_WARSOUL_EQUIP | yes | war-soul |
| 8680 | 11, 12, 13, 14 | STAR, STRENGTHEN, REFORM, LEARN_SKILL | yes | war-soul-training |
| 8680 | 15, 16, 17 | REFRESH, VIEW_REFRESH, REPLACE | yes (tab disabled, §5) | war-soul-training |
| 8680 | 18 | DECOMPOSE | yes | war-soul-training |
| 8680 | 19 | FIGHT | yes | war-soul |
| 8680 | 20 | LEARN_SKILL_REPLACE | yes (tab disabled) | war-soul-training |
| 8680 | 21 | SPLIT | yes | war-soul |
| 8680 | 23 | OP_WARSOUL_LOCK | no sender (locks go through 8809) | |
| 8684 | 1..8 | OP_WarTIDY_BAG, OP_WarMOVE, OP_WarLOCK (no sender), OP_WarEQUIP_DECOMPOSE, OP_WarEQUIP_STRENGTHEN, OP_WarEQUIP_QUALITY, OP_WarEQUIP, OP_WarUNEQUIP | 1,2,4..8 | equipment-suits / war-frame |

Out of scope here, reached from this frame (owned by part B of this feature): "Coleção" (openType 9, collection, sends 9740 op 1 on equip tab open, `T/view/ThereussoulEquipView.as:92`) and "Divino" god plates (openType 10/11). Theseus PvP arenas belong to [../theseus-arena/README.md](../theseus-arena/README.md).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `T/TheseussoulFrame.as` | "Alma de Teseu" (`theseus.equip.mainFrame`, `:458-462`) | Tab shell 772x540 (`:80-83`), attribute side panel, vice password buttons, help button (war tab only, `:304-323`) | Controller `theseussoul` with no openType (`CTL:76`): main toolbar child button and hotkey E (§3 entry points) | Tabs: equip (`:111`), war intent (`:112`), treasure (`:113`), war soul (`:114-117`, only if quest 1389 finished and `VersionSwitch.WARSOUL`); `ThaneAttributeFrame` fed by `MOD.propertys.thane` (`:325-331`, `CM/mvc/module/theseus/TheseusPropertys.as:77-105`) |
| `T/TheseusOtherFrame.as` (stylename `playerInfo.TheseusOtherFrame`) | "Teseu" (`playerinfo.theseusFrame.title1`) and "Meu Teseu" (`playerinfo.theseusFrame.title2`) | Side by side read-only view of another player's Theseus and the own Theseus | Player info "Ver Teseu" button (`decompiled/m5/scripts/playerinfo/PlayerInfoFrameII.as:1457-1460`, openType 3 with the viewed `ThaneInfo`) | Viewed player data from `ThaneInfo.theseusInfo` / `warSoulInfo`; own data from MGR models (`:162-177`); sends 8680 op 1 on construction (`:30`) |
| `T/ThereusLookEquipFrame.as` | inner frames of the above | Four tabs with "Look" views: `ThereussoulEquipViewLook`, `TheseussoulyiPageViewLook`, `TreasurePageViewLook`, `TheseusWarEquipPageViewLook` (`:59-62`) | `TheseusOtherFrame` | `initData(thane)` (`:133-139`) |
| Help `theseuswar.zhangyi.helpFrame` | help of the war soul tab | `SimpleHelpFrame` | help button (`T/TheseussoulFrame.as:297-302`) | text `theseus.war.helpTip` *(assumption: the style binds this key)* |

Controller map (`CTL:30-77`): openType 1 `TheseusSuitFrame`, 2 `TheseusYiAllFrame`, 3 `TheseusOtherFrame` (with `frameData`), 4 `TheseuswarFuhuCFrame` (with data), 5 `TheseuswarIntensifyFrame`, 6 `TheseuswarGZMFrame` (with data), 7 `TheseusWarStarChooseFrame` (with data, never opened), 8 `WarframeEnhancementFrame`, 9 `TheseusCollenseFrame`, 10 `TheseusgodAllFrame`, 11 `TheseusGodheadFrame`, default `TheseussoulFrame`. Closing openType 5, 8 or 9 reopens the main frame when `backTheseFrame` is set (`CTL:79-92`). Extra UI packages loaded with the main frame: playerinfo, theseuscollention, consortianewboss, platinum, poseidonshop, shop, petchallenge, raveparty, theseusgodhead, mailcheck (`FCM:1267-1278`).

## 3. Routes (client to server)

### Entry points and unlock (no route)

- Main toolbar: child button of the archaeology button (`_archaeologyBtn.buttonChildBtn`) opens `theseussoul` (`CM/ui/maintoolbar/MainToolBar.as:2336-2357`). Enabled when `MainToolCheckBtnOpen.getBtnKeyIsOpen("ProficiencyBtn")` (`CM/ui/maintoolbar/MainToolBar.as:1077`):
  - `RoyaltyBossManager.model.royaltyLevel > 0` and `VersionSwitch.THESESOUL` (true, `CM/yishi/datas/VersionSwitch.as:220`) and `thane.vocationIndex > 0` (`CM/ui/maintoolbar/constant/MainToolCheckBtnOpen.as:70-72`).
  - Locked tip: "Liberado após a deificação" (`MainToolBar.needAvenger`, `MainToolCheckBtnOpen.as:177-178`); open tip "Atalho E" (`:130-131`). Tips refresh on `ROYALTYBOSS_LV_EVENT` (`MainToolBar.as:585-599`).
  - The parent archaeology button itself needs hero level 15 (`MainToolCheckBtnOpen.as:40-41`).
- Hotkey E: `KeyBoardRegister.showThesesuolFrame` (`CM/yishi/keyboard/KeyBoardRegister.as:181-182, 1154-1191`), same three conditions, ignored in battle, on a vehicle, with keys disabled or while typing.
- Player info: "Ver Teseu" row in `EquipCheckList` shown when `VersionSwitch.THESESOUL && _thane.vocationIndex > 0` (`decompiled/m5/scripts/playerinfo/view/EquipCheckList.as:414-420`), tip "Clique para mudar para Teseu".
- War soul tab: `TaskManage.IsTaskFinish(1389)` (`CM/yishi/manager/TaskManage.as:63`) and `VersionSwitch.WARSOUL` (`VersionSwitch.as:232`). Quest 1389 "Abertura do Espírito da Guerra", NeedMinLevel 80, PreQuestId 1110 (`raw/xml/tempinfos/QuestTemps.xml`), condition "Espírito da Guerra aberto, por favor fale com a Eliza." (`QuestCondictionInfos.xml`).
- Per-system unlocks come from `RoyaltyTemplates.xml` columns `OpenTheseus` (suits 1..9), `OpenOutsideTreasureHoke`, `OpenInsideTreasureHoke`, `OpenCoreTreasureHoke`, `OpenWarSoul` (war soul slots 0/3/6/9): see each module §5.

### R1. Open Theseus (load snapshot)

- UI: constructing `TheseussoulFrame` (`T/TheseussoulFrame.as:72-78`) or `TheseusOtherFrame` (`T/TheseusOtherFrame.as:27-33`).
- Client checks: none beyond the entry conditions above.
- Sender: `TheseussoulManager.doSomething(1)` (`MGR:969-978`).
- Route: client to server, 8680 (0x21e8) `C_THESEUS_CLIENT_OP`, `player.PlayerOpMsg`:
  - `op` (#1, INT32): 1.
  - `index` (#6, INT32): 0.
  - `templateId` (#8, INT32): 0.
  - `pos` (#19, INT32): 0.
- Expected response, in this order *(assumption: order is free, but 4323 must precede 4298 so `checkEquipRed` sees the bag)*:
  1. 4323 `U_C_THESEUS_EQUIP_DATA` op 0 with the whole Theseus bag (equipment-suits §4).
  2. 4298 `U_C_THESEUS_USER_DATA` (hokeInfo, coreLevel).
  3. 4299 `U_C_THESEUS_RAGE_DATA` with all 12 positions (war-intent §4).
  4. 4300 `U_C_THESEUS_PROPERTY_DATA` (totals, §4 S2).
  5. 4302 `U_C_THESEUS_TREASURE_PROPERTY` (treasure §4).
  6. 4306 `U_C_WARSOUL_LIST` op 0 and 4308 `U_C_WARSOUL_HATCH_LIST` op 0, only when the war soul quest is done *(assumption)*.

### R2. Lock or unlock a Theseus object with the vice password

The lock cursor is armed by the main frame lock button (`T/TheseussoulFrame.as:222-257`; requires hero level 10, vice password set, not in reset period, `GlobalConfig.isConfirmPassword`) and then `TheseusBagHelper.__vpLockClickHandler` sends one request per clicked object (`T/TheseusBagHelper.as:71-189`).

- Sender: `VicePasswordUtil.vpLockOp(opType, itemPos, petId)` (`CM/mainBar/vicePassword/VicePasswordUtil.as:40-49`).
- Route: client to server, 8809 (0x2269) `C_LOCK_OR_UNLOCK`, `player.LockAndUnlockMsg`:
  - `op_type` (#1, INT32): object kind (table below).
  - `item_pos` (#2, INT32): slot position for treasures.
  - `pet_id` (#3, INT32): object id for Theseus armor and war souls.

| Clicked cell | op_type | item_pos | pet_id | Line | Expected push |
|---|---|---|---|---|---|
| `TheseusBagCell` (Theseus armor bag) | 11 | 0 | armor item id | `T/TheseusBagHelper.as:99` | 4323 with `isLock` toggled *(assumption: op 3 `OP_WarLOCK`)* |
| `TreasureCell` (treasure storage bag 38) | 8 | item pos in bag 38 | 0 | `:114` | 115 `U_C_BAG_MOVE_UPDATE` with the item `isLock` *(assumption)* |
| `TreasureOuterItem` (equipped treasure, bag 39) | 13 | slot pos 0..11 | 0 | `:132` | 115 *(assumption)* |
| `TheseusWarEquipCell` (equipped war soul) | 9 | 0 | war soul uid | `:152` | 4307 with `isLock` *(assumption: op 23)* |
| `TheseusInsfBagCell` (war soul bag) | 9 | 0 | war soul uid | `:172` | 4307 *(assumption)* |

The lock protocol itself (password session, other op_types) belongs to [../account/README.md](../account/README.md). Locked objects cannot be decomposed (armor: `MOD:231-237, 252-259`; war souls: `T/war/mediator/TheseusInsfBagCellClickMediator.as:90-94`).

### R3. View another player's Theseus (no Theseus route)

- The viewed player's data arrives inside the player detail response 4125 (0x101d) `U_C_BAG_EQUIPLOOK`, `simple.DetailRspMsg` fields `theseusInfo` (#25, `TheseusUserMsg`), `rageInfo` (#26, `TheseusRageListMsg`), `warSoulInfo` (#27, `WarSoulListMsg`), parsed in `decompiled/m5/scripts/playerinfo/PlayerInfoFrameII.as:969-1027`. Treasures come from the same response's equip list, items with `bagType == 39` (`T/view/TreasureOuterItemLook.as:133-141`).
- The request belongs to [../hero/README.md](../hero/README.md). This module only requires that the hero detail builder fills fields #25..#27 (§8).

## 4. Server messages (server to client)

All listeners are registered once in `MGR.setup` (`MGR:217-237`).

### S1. 4298 (0x10ca) `U_C_THESEUS_USER_DATA`

- Message `theseus.TheseusUserMsg`:
  - `suite1` .. `suite9` (#1..#9, STRING): unused by the self handler; *(assumption)* legacy "id,id,..." of the 12 equip slots per suit, send empty.
  - `armour` (#10, INT32): total armor value; read only in the inspection path (`PlayerInfoFrameII.as:972`).
  - `level` (#11, INT32): royalty level; read only in the inspection path (`:973`, used by `MOD.getRoyaltyLevel`, `MOD:182-189`).
  - `hokeInfo` (#12, STRING): CSV of 12 treasure slot flags, index 0..8 outer, 9..11 inner, value 0 locked, non zero open (`T/view/TreasureOuterItem.as:140-153`).
  - `coreLevel` (#13, INT32): treasure core level, 0 = core locked.
  - `theseusEquipList` (#14, `TheseusEquipMsg`, repeated): only read in the inspection path (`PlayerInfoFrameII.as:974-990`); send the equipped items of the viewed player there.
- Receiver: `MGR.__suitInfosHandler` (`MGR:816-826`): stores `hokeInfo`, `coreLevel`, recomputes red dots (`MOD.checkEquipRed`, `MOD:327-373`), dispatches `EVENT_SUIT_UPDATE`.
- When: response to R1; push after core strengthen (treasure R3) and after a royalty level up that opens a slot *(assumption)*.

### S2. 4300 (0x10cc) `U_C_THESEUS_PROPERTY_DATA`

- Message `theseus.TheseusPropertyMsg`, all INT32: `power` (#1), `agility` (#2), `intellect` (#3), `captain` (#4), `physique` (#5), `attack` (#6), `defence` (#7), `magicAttack` (#8), `magicDefence` (#9), `forceHit` (#10), `parry` (#11), `live` (#12), `conat` (#13), `reduceResi` (#14), `fireResi` (#15), `waterResi` (#16), `electResi` (#17), `windResi` (#18), `darkResi` (#19), `lightResi` (#20), `strength` (#21), `tenacity` (#22), `penetrate` (#23), `stunAttr` (#24), `reduceResiAgainst` (#25), `resiPenetrate` (#26), `armour` (#27).
- Receiver: `MGR.__propertyInfosHandler` (`MGR:924-957`) fills `MOD.propertys`, dispatches `EVENT_PROPERTY_UPDATE`; consumers: attribute panel (`T/TheseussoulFrame.as:325-331`, mapping in `CM/mvc/module/theseus/TheseusPropertys.as:77-105`), armor value label (`T/view/ThereussoulEquipView.as:305-315`).
- Meaning: total bonus of the whole Theseus system added to the hero *(assumption: armor items, suit skills, war intent, war soul and treasure bonuses combined)*; `armour` = sum of equipped armor values ("Valor de Armadura", see equipment-suits §5).
- When: response to R1 and push after any change that alters totals (equip, unequip, strengthen, quality, war intent, core, treasure equip, war soul equip/fight/upgrade).

### S3. Other Theseus pushes

Described in their modules: 4299 (war-intent), 4302 (treasure), 4306/4307, 4308/4309 (war-soul), 4310 (war-soul-training), 4323 (equipment-suits). Error results: none of these messages carries a result code; on failure the server sends nothing or a 126 `U_C_MSG` tip *(assumption, same convention as other features)*.

## 5. Rules and formulas

- Unlock: royalty level > 0, `vocationIndex > 0`, switch `THESESOUL` (§3). War soul tab: quest 1389 + `WARSOUL`.
- `VersionSwitch.WARSOUL_XL = false` and `WARSOUL_JN = false` (`VersionSwitch.as:234-236`): the refine and skill tabs of the war soul upgrade frame are hidden in this build (war-soul-training §2).
- The frame belongs to groups `CASTLE_BUIDING_GROUP`, `MAIN_TOOLS_GROUP`, `TREASURE_MAP_GROUP` (`T/TheseussoulFrame.as:464-467`).
- Inspection frame width 850 when the viewer has Theseus unlocked, else 405 (`T/TheseusOtherFrame.as:35-44`).

## 6. Templates

| File | Record | Fields used here |
|---|---|---|
| `raw/xml/tempinfos/RoyaltyTemplates.xml` (`RoyaltyTempCate`, `CM/yishi/datas/templates/cate/RoyaltyTempCate.as`) | one row per royalty level 1..40 | `RoyaltyLevel`; `OpenTheseus` (suits opened 1..9), `OpenOutsideTreasureHoke` (0/3/5/7/9), `OpenInsideTreasureHoke` (0..3), `OpenCoreTreasureHoke` (core level cap 0..150), `OpenWarSoul` (0/3/6/9 war soul slots), `OpenSlate` (god plates button, part B) |
| `raw/xml/tempinfos/QuestTemps.xml` | quest 1389 | gate of the war soul tab |
| `raw/xml/tempinfos/ConfigInfos.xml` | `warsoul_*` keys | see war-soul modules |

## 7. Persistent state

Schema `theseus`. Shared per-player row; the module tables live in the other files.

```sql
CREATE TABLE theseus.player_progress (
    player_id               bigint PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
    core_level              smallint NOT NULL DEFAULT 0 CHECK (core_level BETWEEN 0 AND 150),
    war_soul_fight_main_type smallint NOT NULL DEFAULT 0 CHECK (war_soul_fight_main_type BETWEEN 0 AND 3),
    opened_at               timestamptz,
    updated_at              timestamptz NOT NULL DEFAULT now()
);
```

- `hokeInfo` is not stored: it is derived from the royalty level (and the secret map progress for inner slots) when building 4298 (treasure §5).
- `opened_at` records the first R1 *(assumption, analytics only)*.

## 8. Backend implementation notes

- Dispatchers: `theseus::dispatch_8680` switches on `op` (1 here; 4 war-intent; 5 treasure; 7..21 war soul modules); `theseus::dispatch_8684` switches on `op` (equipment-suits and war-frame). Unknown op: ignore and log.
- `theseus::soul::handle_open` (8680 op 1):
  1. Validate unlock: royalty level > 0 and `vocationIndex > 0`; otherwise ignore.
  2. Ensure `theseus.player_progress` row (insert on first open).
  3. Read-only snapshot, no transaction needed beyond a consistent read (`REPEATABLE READ`).
  4. Send S1..S2 and the module snapshots in the order of R1.
- `theseus::soul::build_property_totals(player_id)`: one function used by every module to recompute and push 4300 (and to feed the hero's combat stats, see [../hero/README.md](../hero/README.md)).
- Vice password locks (8809 op_type 8, 9, 11, 13) are handled by the account lock handler, which must call into `theseus::equipment_suits::set_lock`, `theseus::war_soul::set_lock` or the inventory item lock, then push 4323 / 4307 / 115.
- Hero detail (4125) builder must call `theseus::soul::fill_detail(viewed_player_id)` to set `DetailRspMsg` #25 (`TheseusUserMsg` with `armour`, `level`, `hokeInfo`, `coreLevel`, `theseusEquipList` of equipped items), #26 (`TheseusRageListMsg`), #27 (`WarSoulListMsg` with `fightIdx` and equipped war souls).
- No timers, no battles in this module.

## 9. Open questions and assumptions

1. *(assumption)* 8680 op 1 must return the full snapshot (4323, 4298, 4299, 4300, 4302, 4306, 4308). The client never asks again, and `MOD.checkEquipRed` is also called on 4298, so sending 4323 first avoids stale red dots.
2. *(assumption)* Pushes on royalty level up (new suit, slot, war soul slot): the toolbar listens to `ROYALTYBOSS_LV_EVENT` only for tips; the frames read `RoyaltyBossManager` directly, so no Theseus push is strictly needed except 4298 when `hokeInfo` changes.
3. `TheseusUserMsg.suite1..9` are never read for the own player; their format is unknown.
4. Content of 4300 (which subsystems are summed) is not visible in the client.
5. The help frame text key of `theseuswar.zhangyi.helpFrame` is defined in UI XML, not in code.

## 10. Implementation checklist

- [ ] Screen `TheseussoulFrame` tabs and unlock gates (royalty, deification, quest 1389).
- [ ] Toolbar child button, hotkey E, player info "Ver Teseu" entry.
- [ ] Route R1 8680 op 1 `handle_open` with ordered snapshot.
- [ ] Route R2 8809 op_type 8/9/11/13 hooks in the account lock handler.
- [ ] Server message 4298 `TheseusUserMsg` (hokeInfo derived, coreLevel).
- [ ] Server message 4300 `TheseusPropertyMsg` builder shared by all modules.
- [ ] 4125 detail fields #25, #26, #27 for inspection.
- [ ] Table `theseus.player_progress`.
- [ ] Rule: refine and skill tabs hidden (`WARSOUL_XL`, `WARSOUL_JN` false).
- [ ] Test: player without royalty level gets no response to op 1.
- [ ] Test: open returns all seven messages and the client shows bag, suits, war intent, treasure and war souls.
- [ ] Test: inspecting another player shows his equipped armor, war intent, treasures and war souls.
