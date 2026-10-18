# Guardian battle participation and formations

Module `formation`. How guardians enter battles: the hero fields one main guardian and one assist guardian that follow the hero in normal battles (op 6), and the guardian only modes use an 8 slot guardian formation on the battle grid: the common formation frame (guardian arena, see `arena.md`), the abyss formation (`childabysm`, used by "Abismo sem fim" of the outyard), the PvE wanted formation (`pve.md`), the spirit expedition formation (`spirit-expedition.md`) and the Espírito de Proteção arena team (`nswar.md`).

Path aliases:

| Alias | File |
|---|---|
| CS | `decompiled/core_module/scripts/mvc/module/children/ChildSender.as` |
| CMOD | `decompiled/core_module/scripts/mvc/module/children/ChildModel.as` |
| CF | `decompiled/m14/scripts/childformation/` |
| AF | `decompiled/m14/scripts/childabysm/` |
| OM | `decompiled/core_module/scripts/yishi/manager/OutyardManager.as` |
| CGT | `decompiled/core_module/scripts/battle/transaction/CreateGameTransaction.as` |

## 1. Overview

- Field state lives on the guardian: `fight_userId` (#8) = player fielding it as main, `fightSlaveUserId` (#20) = player fielding it as assist (`roster.md` S1). One main and one assist per player (`CMOD.getEnterWar`, `CMOD.getSlavedEnterWar`, `CMOD:274-297`).
- Assist (secondary) guardian inherits a percentage of the main guardian's attributes: normal guardians by job soul awakening `Percentage`, spirits by assist awakening `Percentage` (`handbook.md`); as assist it does not use its Ex/common skills (`skills.md`).
- Formation grid mapping used by every guardian formation UI: 8 slots -> grid positions `[1, 4, 7, 10, 3, 6, 9, 12]` (`CF/ChildCommonFormationFrame.as:375`, `AF/ChildAbysmFormationFrame.as:383`, `ChildManager.__refreshBossInfo` for PvE `[1,4,7,10,3,6,9,12]` from a 14 cell array, `decompiled/core_module/scripts/managers/ChildManager.as:189-199`).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `decompiled/m14/scripts/child/attribute/ChildFosterViewII.as` battle menu | | main / assist / rest buttons (`:462-512`) | attribute tab | |
| `decompiled/core_module/scripts/ui/resourcebar/view/ChildrenSortItem.as` | | quick field from the resource bar (`:85-96`) | resource bar guardian list | |
| `CF/ChildCommonFormationFrame.as`, `CF/ChildCommonFormationItemView.as`, `CF/ChildCommonFormationHeadView.as` | | drag guardians into 8 grid slots; `_formationType` 1 = guardian arena (`:356-395`) | arena frames | `ChildArenaModel.childAreanFromationList` |
| `AF/ChildAbysmFormationFrame.as`, `AF/ChildAbysmFormationItemView.as`, `AF/ChildAbysmFormationHeadView.as` | | abyss guardian formation (`:380-406`) | outyard controller openType 8 (`decompiled/core_module/scripts/mvc/controler/OutyardControler.as:79-82`) | `AbysmModel` (owner [abyss](../abyss/README.md)) |

## 3. Routes (client to server)

### A1. Field as main or assist (op 6 OP_ENTER_WAR)
- UI: `ChildFosterViewII` (`:477-506`) and `ChildrenSortItem` (`:85-96`).
- Client checks for assist (`property2` = 2): normal guardian -> job must have `soulWakes > 0` ("Favor despertar este guardião primeiro na imagem de guardiões."); spirit -> `childAssistAwakeLevel > 0` ("Faça primeiro o Despertamento de combate").
- Request: send 8868 (0x22a4), `op_type`=6, `property1` = child id, `property2` = 1 main / 2 assist.
- Response: 4747 with the previous and new guardian `fight_userId` / `fightSlaveUserId`; hero fields `childrenName/Job/Sex/Grade` refresh (`ChildManager.as:680-702`).

### A2. Rest
Op 7 (`roster.md` A4) clears both flags.

### A3. Guardian arena formation
`CS.setChildArenaPos(list)` (send 9657 `C_GUARDPVP_CLIENT_OP`, `GuardPvpListMsg.guardPvpOp` 3, `guardPos` = [{`param1` child id, `param2` attack pos, `param3` stand pos}]) from `CF/ChildCommonFormationFrame.as:393` and `decompiled/m14/scripts/childarena/ChildArenaHeadItemView.as:162`. Documented in `arena.md`.

### A4. Abyss formation
`OM.abysmSendInfo(2, list)` (send 9644, `GuardendlessOpMsg.opType` 2, `guardPos` repeated `GuardEndlessPosMsg` `param1..3`) from `AF/ChildAbysmFormationFrame.as:405`. The abyss activity, its 9644 protocol and package `guardendless` belong to [abyss](../abyss/README.md); the guardian side only needs the list of fieldable guardians and their stats.

### A5. Guardian skill command in battle (10516 B_CHILD_ORDER)
- UI: in guardian only battles (`isChildBattle`) the guardian skill bar (`decompiled/core_module/scripts/battle/view/ui/ChildCommonSkillItemListController.as:195-214`); in normal battles the hero bar for guardian "profound" skills (`decompiled/core_module/scripts/battle/view/ui/SkillItemListController.as:675-692`).
- Sender: `SocketSendManager.gameChildCommand(battleId, livingId, skillId)` (`decompiled/core_module/scripts/yishi/service/managers/SocketSendManager.as:228-235`).
- Request: send 10516 (0x2914) `B_CHILD_ORDER`, `UseSkillMsg` (package `battle`): `battle_id` (#1, STRING), `hero_id` (#2, INT32, guardian living id), `skill_id` (#3, INT32).
- Response: battle skill opcodes (153 etc., `docs/battle/README.md`). Owner of the battle side: [battle](../battle/README.md).

## 4. Server messages (server to client)

- 4747 `U_C_CHILDREN` (`fight_userId`, `fightSlaveUserId`).
- Battle: guardians arrive in battle creation `children` list (`CGT:908-935`): in guardian only modes (battleTypes 3845, 3847, 3867, 3868, 3889) they are independent units (`isFollowChild = false`); otherwise they follow the hero (`isFollowChild = true`). Their awaken value changes through 4752 (0x1290) `U_C_UPDATE_CHILD_POWER`, `AwakeMsg` (`decompiled/core_module/scripts/battle/transaction/BattleChildChangeTransaction.as:19-55`). Guardian only modes and their UI rules: `docs/battle/rules.md` rows P-CHILD, P-NOHERO, 3845, 3847, 3867, 3868, 3889, 3895, 3898.

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Main/assist | one each per player; the same guardian cannot be both *(assumption)* | `CMOD:274-297` |
| Assist gate | job `soulWakes > 0` or spirit `childAssistAwakeLevel > 0` | `ChildFosterViewII.as:487-506` |
| Assist inheritance | `Percentage` of the soul awakening level (45..85) or spirit assist level (40..85) | `handbook.md` |
| Formation slots | 8; grid positions 1,4,7,10 (front column) and 3,6,9,12 | formation frames |
| Spouse | a guardian fielded by the spouse cannot be edited by this player | `roster.md` |

## 6. Templates

`ChildTypeTempInfos.xml`, `ChildAssistUpgradeTemplates.xml` (inheritance), `DarkMazeChildTemplates.xml` (dark maze guardians, owner [mazes](../mazes/README.md)).

## 7. Persistent state

Field flags are columns of `guardians.children` (`roster.md`). Formations per mode:

```sql
CREATE TABLE guardians.formations (
  player_id     BIGINT   NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  mode          TEXT     NOT NULL CHECK (mode IN ('arena','abyss','pve','expedition','nswar')),
  slot          SMALLINT NOT NULL CHECK (slot BETWEEN 0 AND 7),
  child_id      INTEGER  NOT NULL REFERENCES guardians.children(child_id) ON DELETE CASCADE,
  attack_pos    SMALLINT NOT NULL,
  stand_pos     SMALLINT NOT NULL DEFAULT 0,
  PRIMARY KEY (player_id, mode, slot),
  UNIQUE (player_id, mode, child_id)
);
```

## 8. Backend implementation notes

| Opcode / op | Handler |
|---|---|
| 8868 op 6 | `guardians::formation::handle_enter_war` |
| 10516 | `guardians::formation::handle_battle_child_order` (forwards to the battle engine) |

- Op 6: guardian in household, not removed, assist gate, clear the previous holder of the same role for this player, set the flag, recompute hero power, push 4747 to the player (and to the spouse when shared).
- Battle builder helper `guardians::formation::battle_units(player, mode)` returns the guardian units (stats from `join_info`, skills from `fight_skill`, awaken) for the battle engine (`docs/battle/server-engine.md`); normal battles add the main guardian as a follower and the assist with inherited stats.

## 9. Open questions and assumptions

- *(assumption)* Whether one guardian can be main and assist at once (client never prevents it explicitly).
- *(assumption)* Assist inheritance formula applies to main guardian final stats.

## 10. Implementation checklist

- [ ] Op 6 enter war with assist gate.
- [ ] 10516 guardian skill command routed to the battle engine.
- [ ] Table `guardians.formations` used by arena, pve, expedition, nswar (and abyss via its feature).
- [ ] Battle unit builder for follower and independent guardians.
- [ ] Tests: assist without soul awakening rejected; fielding a new main clears the old one; 4747 reflects both flags.
