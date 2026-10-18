# Forbidden Zone Boss ("Chefão da Zona Proibida")

Feature slug `forbidden-boss`, domain `pve`. Registry: client package `forbiddenboss` (`decompiled/m11/scripts/forbiddenboss`), proto package `forbiddenboss` (`roadmap/features.json`). Following the code adds `CM/yishi/manager/ForbiddenBossManager.as`, `CM/mvc/module/forbiddenboss/ForbiddenBossModel.as`, the campaign map HUD in `M3/map/campaign/view/ui/ForbiddenBoss*.as` and the battle HUD `M10/battle/view/ui/ForbiddenBossUIView.as`.

Cross-server open-world bosses. Servers are grouped every Monday (up to 4 servers per group). Each forbidden zone category holds several bosses that respawn on a timer. A player of a guild enters a boss zone (an open campaign map, capacity 10000) and fights the boss repeatedly in battles of type 3903 whose HP is shared by everybody. When the boss dies, the player with the highest cumulative damage receives the ownership reward ("Primeiro Dano") and the members of that player's guild who dealt damage receive the participation reward ("Prêmio da Guilda"). Both are limited per day and per category. A first-kill reward per boss and a drop log complete the feature. Only the player's own attributes and the Theseus armour count; below the recommended armour value the boss takes 90% less damage.

| Module | pt-BR | What it covers | Transport |
|---|---|---|---|
| [boss-hall.md](boss-hall.md) | "Chefão da Zona Proibida" | Main frame: 5 category tabs locked by royalty level, boss list with respawn state, reward previews, daily limits, enter button | socket 8675 ops 1 and 2, 4293, 4294 |
| [zone-battle.md](zone-battle.md) | "Valor de Armadura Recomendado", "Sair do Chefão da Zona Proibida?" | Boss zone campaign map, damage ranking HUD, mini map, shared HP, battle 3903, kill resolution, ownership and participation rewards, respawn, cross-server groups | campaign opcodes, 4295, 4297, battle opcodes |
| [first-kill-and-records.md](first-kill-and-records.md) | "Prêmio de 1ª Morte", "Registro do Chefão" | First kill rewards per boss and the drop log | socket 8675 ops 3 and 4, 4293, 4296 |

Conventions used in every module file:
- Paths are relative to `decompiled/` unless they start with `raw/`, `protocol/`, `index/`, `docs/` or `build/`.
- `CM` = `core_module/scripts`, `M3` = `m3/scripts`, `M10` = `m10/scripts`, `M11` = `m11/scripts`.
- Opcode names come from `protocol/opcodes.csv`. Proto tags were read from the AS3 `writeToBuffer` and `readFromSlice` of each class (`CM/com/road/yishi/proto/forbiddenboss/*.as`). `protocol/proto.json` is wrong for `ForbiddenBossListMsg` (it lists `bossList #1, consortiaId #3, bossId #4`; the client reads `bossList #2, consortiaId #4, bossId #5`): always follow the AS3 tags.
- *(assumption)* marks anything the client does not prove.

## Entry points

| Entry | Where | Unlock condition | Opens |
|---|---|---|---|
| NPC dialog option 158 "BOSS da Zona Proibida" | NPC 49 "Eliza, chefe da Zona Proibida", space map 10000 "Reino do Céu" (`raw/xml/tempinfos/MapNodeInfos.xml` node 49) dispatched by `M3/map/space/view/frame/DialogOptionItem.as:874-876` | `SwitchPageHelp.openForbiddenBossFrame` (`CM/yishi/SwitchPageHelp.as:3076-3118`): knight job change; member of a guild (`consortiaID != 0`, tip "Após entrar para uma guilda, você poderá participar do Chefe da Zona Proibida"); `checkScene()`; royalty level >= `getForbiddenLv(1)` = 1 (tip "Abre com Realeza Nv. {0}"); server time inside `ForbiddenBoss_time` (default "10:00:00","23:59:59", config "06:00:00\|23:59:59", tip "Abre diariamente entre {0}-{1}") | `forbiddenboss.ForbiddenBossFrame` (controller key `forbiddenboss`, openType default) |
| Mini map button inside a boss zone | `ForbiddenBossView` "mapBtn" (`M3/map/campaign/view/ui/ForbiddenBossView.as:278-281`) | Being on a map 31001..39999 | `ForbiddenBossMapFrame` (openType 4) |

No VIP condition. No hero level condition (the campaigns declare `MinLevel 241`, not checked by the client).

## Dependencies

| Feature | Why |
|---|---|
| [../royalty-boss/royalty-levels.md](../royalty-boss/royalty-levels.md) | `OpenForbidenBoss` unlocks categories 1..5 |
| [../guild/README.md](../guild/README.md) | Guild membership required; participation reward goes to the owner's guild members; guild name in rankings |
| [../theseus/README.md](../theseus/README.md) | Theseus armour value vs `BAV`; rewards are Theseus armour pieces (72xxxxx) |
| [../campaign/README.md](../campaign/README.md) | Boss zones are campaigns 31001..35020 (`Types 51`, capacity 10000): create 125, enter 21, nodes 127, move 5124, arrive 5125, exit 5120 (`docs/world/README.md` §3) |
| [../battle/README.md](../battle/README.md) | battleType 3903 (P-WB world boss style HP, `docs/battle/rules.md` row 3903) |
| [../returning-players/README.md](../returning-players/README.md) | `OldPlayerReturnModel.forbiddenBossCount` (privilege type 106) adds to the daily totals; king contract buff 15 enables auto walk |
| [../cross-server/README.md](../cross-server/README.md) | Weekly cross-server grouping (`ForbiddenBoss_sever_matchTime`, `ForbiddenBoss_maxSever`) |
| [../currency/README.md](../currency/README.md) | Rewards in "Gema Poseidon" (-19000) |
| [../inventory/README.md](../inventory/README.md) | Item rewards |

## Suggested implementation order

1. Template loaders: `ForbiddenBossTemplates.xml`, `ForbiddenBossBelongDrop.xml`, `ForbiddenBossJoinDrop.xml`, `ConfigInfos` keys `ForbiddenBoss_*`, campaigns 31001..35020.
2. Boss runtime state and respawn scheduler per server group ([zone-battle.md](zone-battle.md) §8).
3. [boss-hall.md](boss-hall.md): op 1 (4294 then 4293), op 2 enter.
4. [zone-battle.md](zone-battle.md): zone campaign map, battle 3903 with shared HP, 4297 sync, 4295 ranking, kill resolution and rewards.
5. [first-kill-and-records.md](first-kill-and-records.md): op 3, op 4.
6. Cross-server grouping (single server first: one group containing only the local server).
