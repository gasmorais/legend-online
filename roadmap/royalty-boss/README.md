# Royalty Path ("Caminho da Realeza")

Feature slug `royalty-boss`, domain `pve`. Registry: client package `royaltyboss` (`decompiled/m11/scripts/royaltyboss`), no proto package (`roadmap/features.json`). The feature reuses `simple.PropertyMsg` for its only push and sends a bodiless request.

The player defeats a chain of 600 sequential solo bosses ("Chefão da Realeza", `RoyaltyBossTemplates.xml`). Each kill raises `passBossLevel`; crossing the thresholds of `RoyaltyTemplates.xml` raises the **royalty level** (1..40). The royalty level is a global progression key: it grants an attribute skill and unlocks Theseus armor suits, forbidden zone tiers, Poseidon shop floors, Theseus treasure slots, war souls, the war tower, the final road, Theseus PvP, the Theseus tower, the Theseus dungeon and god plates. Many features only read `RoyaltyBossManager.model.royaltyLevel`, so this feature must ship before them.

| Module | pt-BR | What it covers |
|---|---|---|
| [royalty-path.md](royalty-path.md) | "Caminho da Realeza", "Desafiar Chefão", "Ranking do Chefão da Realeza" | Main frame, boss fight (opcode 8674, battleType 3902), progress push 4292, kill rewards, daily ranking file `royalty.xml` |
| [royalty-levels.md](royalty-levels.md) | "Nível de Realeza" | Complete reference of every `RoyaltyTemplates` field, the level table 1..40, the royalty attribute skill, and every client consumer that gates content on the royalty level (server rules for other features) |

Conventions used in every module file:
- Paths are relative to `decompiled/` unless they start with `raw/`, `protocol/`, `index/`, `docs/` or `build/`.
- `CM` = `core_module/scripts`, `M3` = `m3/scripts`, `M4` = `m4/scripts`, `M5` = `m5/scripts`, `M11` = `m11/scripts`, `M14` = `m14/scripts`.
- Opcode names come from `protocol/opcodes.csv`. Proto tags were read from the AS3 `writeToBuffer` of each message class (`CM/com/road/yishi/proto/**`), not from `protocol/proto.json`, because several short names collide there (for example `PropertyMsg` exists in packages `army` and `simple`).
- *(assumption)* marks anything the client does not prove.

## Entry points

| Entry | Where | Unlock condition | Opens |
|---|---|---|---|
| NPC dialog option 156 "Caminho da Realeza" | NPC 49 "Eliza, chefe da Zona Proibida", space map 10000 "Reino do Céu" (`raw/xml/tempinfos/MapNodeInfos.xml`, node Id 49, `Param3`) | Knight job change (`thane.isChangeJob`, tip "MainToolBar.needChangeJob") and quest 1100 finished (`TaskManage.ROYALTY_BOSS_TASK`, `CM/yishi/manager/TaskManage.as:61`); `checkScene()` (`CM/yishi/SwitchPageHelp.as:3041-3063`; dispatch `M3/map/space/view/frame/DialogOptionItem.as:868-870`) | `royaltyboss.RoyaltyBossFrame` (controller key `royaltyboss`, openType default) |
| Same NPC, option 7 "Libera a Realeza" | `Param4` = 1100 | Story quest dialog for quest 1100 (quests feature) | Quest dialog |
| Return from a royalty boss battle | `_preSceneData.isRoyaltyBossBattle` (`CM/battle/handler/BattleResultHandler.as:489-492`) | battleType 3902 | Reopens `royaltyboss` (`M3/map/space/SpaceSceneController.as:442-445`, `M4/castle/CastleSceneView.as:327-330`) |

No VIP condition. No level condition besides the knight job change and quest 1100.

## Dependencies

| Feature | Why |
|---|---|
| [../theseus/README.md](../theseus/README.md) | Fight frame shows Theseus armour (`TheseussoulModel.propertys.armour`) against the boss `ArmourValue`; armour button opens Poseidon shop; most royalty unlocks are Theseus content |
| [../quests/README.md](../quests/README.md) | Quest 1100 gates the feature; task condition type 261 checks the royalty level (`CM/mvc/module/task/TaskTemplate.as:887-888, 958-966`) |
| [../currency/README.md](../currency/README.md) | Kill reward `-19000` "Gema Poseidon" (currency `poseidonCoin`); currency bar shows Poseidon gems only when royalty level > 0 (`CM/managers/PlayerCurrencyManager.as:733-736`) |
| [../battle/README.md](../battle/README.md) | battleType 3902 solo battle, sealed skill locked (`CM/battle/view/ui/SkillItemListView.as:197`) |
| [../rankings/README.md](../rankings/README.md) | Daily generated `royalty.xml` ranking file |
| [../skills/README.md](../skills/README.md) | Royalty attribute skill `SkillId` 84102001..84102040 (`SkillPropertyTempInfos.xml`) |
| Consumers of the royalty level | [../forbidden-boss/README.md](../forbidden-boss/README.md), [../shops/README.md](../shops/README.md) (Poseidon), [../theseus/README.md](../theseus/README.md), [../trials/README.md](../trials/README.md) (war soul tower), [../roads/README.md](../roads/README.md) (final road), [../arena/README.md](../arena/README.md) (Theseus PvP entry), [../exploration/README.md](../exploration/README.md) (Theseus dungeon, secret adventure), [../smith/README.md](../smith/README.md) (Theseus compose and resolve tabs), [../hero/README.md](../hero/README.md) (toolbar child button): see [royalty-levels.md](royalty-levels.md) §5 |

## Suggested implementation order

1. Template loaders: `RoyaltyTemplates.xml`, `RoyaltyBossTemplates.xml`, `SkillPropertyTempInfos.xml` rows 84102001..84102040, `SkillBufferTempInfos.xml` 84101001.
2. [royalty-levels.md](royalty-levels.md): table `royalty_boss.progress`, the shared Rust API `royalty_boss::levels::royalty_level(player_id)` and `unlock_level(field, value)`, login push 4292. Other features can then gate on it.
3. [royalty-path.md](royalty-path.md): fight route 8674, battle configuration for battleType 3902, kill reward, level up push.
4. Daily ranking job writing `royalty.xml` under the template path.
5. Attribute skill injection into the hero stat calculator (hero feature).
