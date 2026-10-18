# Assistant (Assistente de Anteus)

Feature slug `assistant`, domain `platform`. Anteus ("安泰俄斯") is a sky city NPC that runs a board of the 10 strongest players who signed up as "assistants". Other players hire one of them as a helper for one of four hard campaigns (Titan Temple, Ecliptic Palace, underground maze, time-space gate), paying a cost that doubles with each repeated hire; assistants earn Anteus coins for the Anteus shop.

It is not an automation or daily task helper: the protocol carries a ranking of players with their avatar and companion snapshots, a sign-up and an invitation.

Client packages: `antaeus` (`decompiled/m11/scripts/antaeus/*`, `decompiled/core_module/scripts/mvc/module/antaeus/*`, asset `core/scripts/asset/core/antaeus`). Shared code followed: `yishi/manager/AntaeusManager`, `mvc/controler/AntaeusController`, `BaseManager.__antaeusTipsHandler`, `PlayerBufferInfo` (buffer type 8), `TaskTraceTipManager` (tips 58, 59), `ShopControler` / `AntaeusShopFrame` (shop 1017), currency type 32.

Proto package `antaeus` (10 messages): `AntaeusMsg`, `AntaeusAssistantMsg`, `AssistantDataMsg`, `AssistantPlayerShowMsg`, `PetShowMsg`, `ChildrenShowMsg`, `SlaveChildShowMsg`, `ArtifactShowMsg`, `GoddessShowMsg`, `TitanShowMsg`. Requests use `player.CommonMsg`; tips use the simple `PropertyMsg`.

## Status in the BR client

Dormant. `VersionSwitch.ANTAEUS` is `false` and never set (`decompiled/core_module/scripts/yishi/datas/VersionSwitch.as:166`), so the frame refuses to open ("Esta função ainda não foi ativada"), NPC node 47 is hidden, tips are suppressed and the coin is not listed. No `antaeus.*` pt-BR strings exist and the `antaeus_*` config rows are marked deprecated ("【废弃】"). Implementing it requires a client patch and new strings; the backend design is complete in the module files.

## Entry points

| Entry | Where | Condition |
|---|---|---|
| Sky city NPC Anteus (node 47, function 135) | `decompiled/core_module/scripts/map/space/data/SpaceNodeType.as:68`, `decompiled/m3/scripts/map/space/helper/hero/SpaceArmyViewHelper.as:214-215` | `VersionSwitch.ANTAEUS` |
| Tip "Ir Agora" (types 58, 59) | `decompiled/m16/scripts/tasktracetip/view/AntaeusMeetTipView.as:44`, `AntaeusBattleFailureTipView.as:44` | `4897` push and switch |
| Shop button inside the frame | `decompiled/m11/scripts/antaeus/AntaeusFrame.as:428-431` | frame open |

Unlock level `OpenGradesII.ANTAEUS = 1` (unused). Sign-up requires 10 000 000 fighting capacity.

## Modules

| Module | File | Routes | Server messages | Tables |
|---|---|---|---|---|
| Board, sign-up and tips | [board.md](board.md) | `9682` op 1 (open), op 2 (sign) | `4894`, `4897` | `board_entries`, `tip_log` |
| Hiring | [hire.md](hire.md) | `9682` op 3 (invite) | `4188` (buffer type 8), `4894` | `hire_counters`, `active_hires`, `hire_log` |

## Dependencies

- [../hero/README.md](../hero/README.md): fighting capacity, avatar parts, buffs (`4188`).
- [../einherjar/README.md](../einherjar/README.md), [../guardians/README.md](../guardians/README.md), [../goddess/README.md](../goddess/README.md), [../divine-weapon/README.md](../divine-weapon/README.md), [../dragon/README.md](../dragon/README.md), [../fashion/README.md](../fashion/README.md): companion snapshots in `AssistantDataMsg`.
- [../currency/README.md](../currency/README.md): hire payment and Anteus coin (type 32).
- [../shops/README.md](../shops/README.md): Anteus shop, shop type 1017.
- [../ecliptic-palace/README.md](../ecliptic-palace/README.md), [../dragon/README.md](../dragon/README.md), [../mazes/README.md](../mazes/README.md), [../trials/README.md](../trials/README.md), [../battle/README.md](../battle/README.md): campaigns where the hired helper fights.
- [../navigation/README.md](../navigation/README.md): sky city node 47.
- [../account/README.md](../account/README.md): feature flag delivery (server side) and the client patch process.

## Suggested implementation order

1. Decide whether to enable the feature (client patch, strings).
2. [board.md](board.md): board table, open view with show data, sign-up.
3. [hire.md](hire.md): invitation, cost, counters, buffer, coin award.
4. Battle hook in the four campaigns.
5. Tips (`4897`).

## Notable gaps

- Payment currency of the hire and the coin amount awarded to assistants are not in the client.
- No client battle code for the helper: its battle composition is a server design decision.
- Mapping of campaign indexes 3 and 4 to concrete campaign features is inferred from Chinese config descriptions.
