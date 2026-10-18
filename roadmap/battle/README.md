# Motor de batalha (battle engine)

Feature `battle`, domain platform. Client package `battle` (302 classes in `decompiled/core_module/scripts/battle` and `decompiled/m10/scripts/battle`), protobuf package `battle` (69 messages). Deep client references: `docs/battle/README.md`, `rules.md`, `hud.md`, `formation.md`, `server-engine.md`, `chess-modes.md`. Current mock implementation: `server/src/battle.rs` (engine), `server/src/game.rs:113-165` (routing), `server/flows/battle.json` (rules), `server/battletest.mjs` (test).

**Path conventions** used by every file of this folder: **CM** = `decompiled/core_module/scripts`, **M10** = `decompiled/m10/scripts`, **M3** = `decompiled/m3/scripts`, **M5** = `decompiled/m5/scripts`. Opcode names come from `protocol/opcodes.csv`, field tags from `protocol/proto.json` (verified against the decompiled writers where noted).

## 1. Overview

Every fight in Legend Online (campaign nodes, bosses, arenas, towers, pets, guardians, guild wars...) is the same real time battle: two sides on a 3 x 4 grid, units acting on a 25 fps server clock, the client only animating the orders the server streams. There is no player facing "battle" menu: other features start battles and receive their outcome. pt-BR names the player sees in battle: "Fúria" (SP), "Despertamento" (pet awaken), "Combate automático", "Clique para pular batalha", "Vitória".

The server is authoritative for everything: unit snapshot, scheduling, skill choice (AI and auto), targets, damage, buffs, gauges, end condition, rewards (through the owning feature).

## 2. Entry points

| Entry | Condition | Detail |
|---|---|---|
| Any feature that fights | the feature's own unlock (level, VIP, quest) | it calls `battle::lifecycle::create` and sends nothing itself; the battle sends 157 |
| Auto battle button | leader level 15 | [ai-auto.md](ai-auto.md) |
| Finish now | battleType 16 (any), 35 and 307 with VIP 3 | [hud-actions.md](hud-actions.md) |
| Seal skill (Q) | level 50 | `CM/battle/view/ui/SkillItemListView.as:182-211` |
| Guardian skills (R/F) | level 70 | `SkillItemListView.as:213-242` |
| Runes (Z/X) | level 35 / 40 | `SkillItemListView.as:247-260` |
| Spectate | "Lista de Guerras" (unreachable in this client) | [lifecycle.md](lifecycle.md) L7 |

## 3. Modules

| Module | Content | Routes (C>S) | Server messages (S>C) | Tables |
|---|---|---|---|---|
| [lifecycle.md](lifecycle.md) | create, load, start, clock, end, result, rewards hook, cancel, spectator, debug | 10007, 10018, 8282, 10022, 8985, 10003, 14002 (+10010 tutorial) | 157, 156, 69 (do not send), 154, 4103, 4166, 4680, 171 (tutorial), 4803, 4804, 4806 | `battle.battles`, `battle_participants`, `battle_reports`, `player_battle_stats`, `battle_events` |
| [formation.md](formation.md) | grid, placement, reinforcement, preload, swap, revive | none | 72, 4149, 4793, 4795 (+ `waitRevives` in 153) | none |
| [units.md](units.md) | unit kinds, `HeroMsg` / `SoldierMsg`, attributes, gauges, boss control | none | 4600, 4752, 4999 (+ 391 einherjar) | none |
| [skills-effects.md](skills-effects.md) | skill requests, actions, targets, buffs, items, QTE | 10008, 10516, 10519, 10520, 10523, 14001, 25240, 10499, 10507, 10509, 10015, 10016 (dead) | 153, 4102, 75, 158, 77, 173 (do not send) | none |
| [damage.md](damage.md) | `DamageMsg`, bloodTypes, damage formula, HurtUp escalation, shared boss HP | none | 4361 (+ boss HP syncs owned by boss features) | none |
| [ai-auto.md](ai-auto.md) | scheduling, AI cycles (`HeroAis`), auto battle | 10020 | none | `battle.player_battle_settings` |
| [hud-actions.md](hud-actions.md) | speed (none), finish now, leave War Tower, auto, hide others | 8727, 10497 (+10020) | none | none |
| [special-skills.md](special-skills.md) | avenger switch 10521, war soul 10522, gauges 4589 / 4591 / 4311 | 10521, 10522 | 4589, 4591, 4311 | none |
| [battle-types.md](battle-types.md) | all 123 battleType values, behavior groups, owning features | | | |

Totals: 9 documents (8 modules + battleType reference); 24 client to server opcodes (plus 10010 from the tutorial); 29 server to client opcodes (including 69 and 173, which must not be sent, and 171 and 391, specified by tutorial and einherjar); 6 proposed tables.

### Protobuf package `battle`: ownership

| Group | Messages |
|---|---|
| Owned here | AttackModeMsg, AttackOrderListMsg, AttackOrderMsg, AwakeInfoMsg, AwakeMsg, ArmyResMsg, BaseItemMsg, BattleCreateMsg (debug), BattleItemMsg, BattleNoticeMsg, BattlePrepareMsg, BattleReportMsg, BattleReqMsg, BattleStartMsg, BattleViewMsg, BossHpMsg, BufferMsg, ControlBuffStateMsg, CoolDownMsg, DamageMsg, DropInfoMsg, HeroMsg, HeroOrderMsg, ItemUseResultMsg, LivingCleanMsg, LivingInfoMsg, LoadOverMsg, PreLoadResMsg, PrepareOverLivingMsg, PrepareOverMsg, QteMsg, ReinforceMsg, ReliveMsg, ReplaceSkillMsg, ShowPermanentBuffMsg (dead), SkillStateMsg, SoldierMsg, StarBufferMsg, TitanInfoMsg, TrialInfoMsg, UseSkillMsg, UserStopMsg, WaitReviveMsg |
| Used by other features | GuardOnFightMsg ([outyard](../outyard/README.md)), PlayerTrialMsg ([campaign](../campaign/README.md)), SkyTrialOrderInfoMsg / SkyTrialPointInfoMsg / SkyTrialPointMsg ([trials](../trials/README.md), Skybox Road), TimeVortexInfoMsg / TimeVortexListMsg ([trials](../trials/README.md)), TriggerSkillListMsg / TriggerSkillMsg (opcode 541, [skills](../skills/rune-stones.md)) |
| Unused by this client (no reference outside the proto classes) | ArmyPlayerInfoMsg, BattleCancelMsg, BattleDetailMsg, BattleDropMsg, BattleResultMsg, BossBattleReqMsg, CrossWarFieldUpdateMsg, FightPlayer, GuildTotemUpdateBufferMsg, LordsMsg, PlayerAttriUpdateMsg, PlayerInfoNoticeMsg, ReqBattleOrderMsg, TrialReforceMsg, UpdateBattleIdMsg, WarLogMsg, WorldBossStartMsg |

## 4. Dependencies

- Called by every fighting feature: see the owner column of [battle-types.md](battle-types.md) (campaign, trials, guild, guardians, einherjar, exploration, world-boss, theseus, ...).
- Unit snapshots from character features: [../hero/README.md](../hero/README.md), [../army/README.md](../army/README.md) (formation 8276, troops), [../skills/README.md](../skills/README.md) (skill bar opcode 64, talents, runes, stone triggers 541/10523), [../avenger/README.md](../avenger/README.md), [../theseus/README.md](../theseus/README.md) (war soul), [../einherjar/README.md](../einherjar/README.md) (pets, sacristy 391/392/10519), [../guardians/README.md](../guardians/README.md) (children, 4752, 10516, 25240), [../goddess/README.md](../goddess/README.md) (4102, belief), [../monsters/README.md](../monsters/README.md) (10520), [../dragon/README.md](../dragon/README.md) (titan skills, hit points), [../marriage/README.md](../marriage/README.md) (10509), [../cosmos/README.md](../cosmos/README.md), [../steles/README.md](../steles/README.md).
- [../vip/README.md](../vip/README.md): VIP 3 gate for finish now.
- [../tutorial/README.md](../tutorial/README.md): plot dialogs 171, 10022, 10010.
- [../chat/README.md](../chat/README.md): in battle chat (channel 8 via 25024 in 10/308).
- Boss features push shared HP into battles: [../world-boss/README.md](../world-boss/README.md), [../guild/README.md](../guild/README.md), [../forbidden-boss/README.md](../forbidden-boss/README.md), [../exploration/README.md](../exploration/README.md), [../campaign/README.md](../campaign/README.md).
- `player.players(player_id)` for every table.

## 5. Suggested implementation order

1. **Templates loader** (SkillTempInfos, ActionInfos, SkillBufferTempInfos, GameHeroTemp, PawnTempInfos, HeroAis, MapInfos, ConfigInfos) shared with the rest of the server.
2. **Lifecycle skeleton** ([lifecycle.md](lifecycle.md)): `create` API, actor with 40 ms clock, 157/10007/156, end 154/4103, cancel 4166, tables. The mock in `server/src/battle.rs` is a working reference.
3. **Units and formation** ([units.md](units.md), [formation.md](formation.md)): builders with the `BattleContributor` trait; main army placement; NPC sides.
4. **Skills and damage** ([skills-effects.md](skills-effects.md), [damage.md](damage.md)): 10008/75, 153 encoder, targeting, damage formula, SP and cooldowns.
5. **AI and auto** ([ai-auto.md](ai-auto.md)): scheduler, `HeroAis` cycles, 10020.
6. **Buff engine** (skills-effects §5): turns, triggers, stun, shields, DoT, dispel.
7. **HUD actions** ([hud-actions.md](hud-actions.md)): 8727, 10497.
8. **Reinforcement, swap, revive** (formation §4.2-§4.6), HurtUp 4361.
9. **Special systems**: pet awaken (4600, 700001/700002), guardians (4752, 10516), avenger and war soul ([special-skills.md](special-skills.md)), goddess stage 4102, items 10499/10507/10509/158.
10. **Per battleType rules** ([battle-types.md](battle-types.md) §2) as each owning feature lands.
11. Spectator (8985) last.

## 6. Open questions (summary)

- The original damage formula, AI trigger conditions (`CrazySkill`, `BottomSkill`, `LessHpSkill`), buff semantics per `AttackType` and avenger SP gain are not in the client; the files propose rules marked *(assumption)*.
- Spectator mode is unreachable in this build; opcodes 4803/4804/4806 are absent from `protocol/opcodes.csv`.
- `roadmap/einherjar/challenge-arena.md` gives `BattleReqMsg.battle_id` tag #1; the decompiled writer uses #2 (`CM/com/road/yishi/proto/battle/BattleReqMsg.as:119-134`).
