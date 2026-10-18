# AI and auto battle

Module `ai-auto` of the feature [Motor de batalha](README.md). Path prefixes as in [lifecycle.md](lifecycle.md). Client detail: `docs/battle/hud.md` §3.1, `docs/battle/rules.md` §11.3 (P-AUTO, P-MULTI); mock behavior: `docs/battle/server-engine.md` §3.

## 1. Overview

Every unit acts by itself on the server clock. Only the player's own controllable unit (hero, manual child, captain monster, pet in pet modes) can receive manual skill requests ([skills-effects.md](skills-effects.md)); when the player is on **auto** ("combate automático") the server also chooses that unit's skills. NPCs, bosses and troops always follow their AI template (`HeroAis.xml`).

Auto is a per battle flag toggled by the player with the auto button (opcode 10020). The initial value comes from 157 `attack_model`. Auto requires leader level 15 and is blocked in multi player battles and on some campaign maps.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `battle.AutoFightBtn2` in `BattleUIView` (M10) | tooltip below level 15: `store.view.StoreFrame.command01` with 15 ("Função habilitada no Nv. 15"); in multi player: "Essa batalha não pode entrar em combate automático" (`battle.view.ui.BattleUIView.command01`) | toggle auto | bottom bar (variant H only) | selected state; sprite `SetAutoFightAsset` / `CancelAutoFightAsset`; banner `AutoFightFlagAsset` while on auto |
| Skill bar while on auto | "Você está em combate automático, não é possível realizar função" (`battle.view.ui.SkillItemListView.command01`) | blocked actions message | skill bar | none |

Auto button hidden in battleTypes 35, 307, 16, 3895, 3896, 3898, 349, 3844, 3866, 3864, 3845, child battles, 3884, 295, 3846 (`docs/battle/rules.md` §11.3 P-AUTO).

## 3. Routes (client to server)

### A1. Toggle auto battle

| Item | Value |
|---|---|
| UI control | auto button; also any manual skill click (sends "off"), pet/child transform clicks (off), maze hang up (on) |
| Client sender | `BattleUIView.onAutoFightClick` (`M10/battle/view/ui/BattleUIView.as:1757-1779`) -> `BattleModel.setAutoFight` (`CM/yishi/datas/BattleModel.as:296-309`) -> `SocketSendManager.sendAutoAttack` (`CM/yishi/service/managers/SocketSendManager.as:383-392`). Other callers: `BattleSkillItemII.__iconClick` (`CM/battle/view/ui/BattleSkillItemII.as:392`), `SelfAwakenView` (:295-298, 351-354), `ChildSelfChangeView`, `initAutoFight` (`BattleModel.as:311-323`), `EnterBattleController` maze auto (:255-258) |
| Client checks | flag differs from the current one and battle not over (`setAutoFight`); button enabled: leader level >= 15, `!isMultiPlayer()` (always false with `VersionSwitch.allAutoFight = true`) and `allowAutoFight` (false on campaign maps Taila, WasteCampaign, PvP, MineralPVP, Wedding, FlameTemple, Svs, pet boss floor, Bloody: `M3/map/campaign/view/CampaignMapView.as:191-345`); 3886 forces enabled (`BattleUIView.as:739-752`) |
| Route | C>S **10020 (0x2724) B_SET_ATUO_ATTACK** |
| Request | `battle.AttackModeMsg`: `battle_id (#2, STRING)`; `server_name (#3, STRING)` player server; `army_id (#4, INT32)` `ArmyManager.army.id`; `mode (#5, INT32)` 1 = auto on, 2 = auto off; `userId (#1)`, `fm_turn (#6)`, `hero_sp (#7)` unset |
| Expected response | none (the client updates its UI locally); from now on the server picks the player's skills (on) or waits for requests (off) |
| Note | when `allowAutoFight == false`, `initAutoFight` immediately sends `mode 2` at battle creation, before 10007 |

## 4. Server messages (server to client)

No dedicated message. The initial flag is 157 `attack_model (#8, INT32)` (1 auto, 2 manual). AI driven actions arrive as normal 153 orders ([skills-effects.md](skills-effects.md) §4.1).

## 5. Rules and formulas

### 5.1 Action scheduling (server)

| Rule | Value | Source |
|---|---|---|
| First action | `start_delay` (25 frames) + 7 frames per unit, units ordered by column, row, side | `docs/battle/server-engine.md` §3.3 |
| Busy time | action duration ([skills-effects.md](skills-effects.md) §5) | same |
| Next action | `busy_until + interval`: heroes 20 frames, troops 30 frames | same |
| Order within a frame | pending manual requests first, then lowest `next_act`, then lowest `living_id`; several units may act on one frame | same |
| Speed buffs | `AttackType 13` "Velocidade diminui N%" *(assumption: scales the interval)* | `SkillBufferTempInfos.xml` |

### 5.2 Skill choice

| Unit | Choice | Source |
|---|---|---|
| Player unit, manual | pending request if still usable, else `DefaultSkill` | `docs/battle/server-engine.md` §3.4 |
| Player unit, auto | first usable `UseWay 1` skill of its bar sorted by `Cost` ascending (biggest SP spenders first), else `DefaultSkill` | same |
| Other player heroes (allies or PvP enemies) | same as auto | same |
| Boss (type 3) and troops | next usable skill of the `HeroAis.Skills` cycle (round robin), else `DefaultSkill` | same |
| Usable | template exists, cooldown expired, for heroes `sp + Cost >= 0` (and `hitPoint + HitPointCost >= 0`) | same |

### 5.3 `HeroAis.xml` fields (8080 rows)

| Field | Rows with a value | Use (client) | Server meaning |
|---|---:|---|---|
| `ID` | 8080 | key from `GameHeroTemp.AI` / `PawnTempInfos.AI` | |
| `Skills` | 8080 | preload | skill cycle "id,id,...," played in order |
| `CrazySkill` | 2420 | preload | enrage skill *(assumption: used when HP falls below a threshold or after a time)* |
| `BottomSkill` / `BottomSkills` | 336 / 455 | preload | fallback skill / cycle *(assumption)* |
| `DeadSkill` | 0 | preload | skill on death |
| `LessHpSkill` | 3 | preload | skill at low HP |
| `AngrySkill` | 0 | preload | skill at full SP |
| `AwakenSkill` | 144 | preload | phase change skill (example 650493) |
| `Soldiers` | 144 | preload of summoned troops | summoned units "pawnTempId,pos|..." (via `awakenSoldiers`) |
| `ChangeSkills` | 558 | not read | skill cycle after the phase change |
| `ChangeIcon` | 3 | client switches body to `boss032a` after skill 650493 (`CM/battle/skillsys/skills/BaseSkill.as:487-512`) | new body resource |

Client reader: `HeroAisTemplate.getSkills` (`CM/yishi/datas/templates/HeroAisTemplate.as`), used for resource preload (`CM/battle/transaction/CreateGameTransaction.as:690-727`; `CM/battle/BattleResPreloadManager.as`).

### 5.4 Auto availability

| Rule | Value | Source |
|---|---|---|
| Level | leader (`thane`) grade >= 15 | `BattleUIView.as:1448-1458, 719-737` |
| Multi player | blocked when `battle_capity > 1` or more than one player hero, except 3886; forced allowed in 306, 3850, 3900. Client side always allowed because `VersionSwitch.allAutoFight = true` | `BattleModel.as:182-220, 882-889` |
| Campaign maps | auto disabled on Taila, WasteCampaign, PvP, MineralPVP, Wedding, FlameTemple, Svs, pet boss floor, Bloody maps | `CampaignMapView.as:191-345` |
| Maze hang up | auto forced on (`CampaignMapModel.isHangUp`); a loss in a maze turns maze auto off | `BattleModel.as:311-323`; `BattleResultHandler.as:110-113` |
| Default on | mock: 16, 35, 307 start on auto (the player cannot act there anyway) | `docs/battle/server-engine.md` §9.2 |
| QTE and aim | on auto the aim markers are not drawn; QTE never opens (template 0) | `docs/battle/hud.md` §3.1 |

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `raw/xml/tempinfos/HeroAis.xml` | NPC AI | all fields of §5.3 |
| `raw/xml/tempinfos/GameHeroTemp.xml` | hero/boss | `AI`, `DefaultSkill`, `SkillScript` |
| `raw/xml/tempinfos/PawnTempInfos.xml` | troop | `AI`, `DefaultSkill` |
| `raw/xml/tempinfos/SkillTempInfos.xml` | auto choice | `UseWay`, `Cost`, `HitPointCost`, `CoolDown` |

## 7. Persistent state

```sql
CREATE TABLE battle.player_battle_settings (
  player_id         bigint PRIMARY KEY REFERENCES player.players(player_id),
  auto_fight        boolean NOT NULL DEFAULT false,
  updated_at        timestamptz NOT NULL DEFAULT now()
);
```

Stores the last auto choice so the next 157 can send `attack_model` 1 or 2 *(assumption: the original server remembered it, since 157 carries the flag)*.

## 8. Backend implementation notes

- **`battle::ai::handle_set_auto` (10020):** validate battle active, sender participant, mode in {1, 2}; check level >= 15 and that the battle's config allows auto (owning feature flag, multi player rule) when mode = 1; set `unit.auto = (mode == 1)` for the sender's controllable unit; drop any pending manual request when turning auto on *(assumption)*; upsert `battle.player_battle_settings.auto_fight`. No reply.
- `battle::ai::choose(unit, frame)`: implements §5.2; for NPCs keep a cursor into `Skills`; switch to `ChangeSkills` after the `AwakenSkill` fires; summon `Soldiers` with the awaken skill.
- `battle::ai::schedule`: initial delays and intervals (§5.1), with speed modifiers.
- Disconnected players: their unit switches to auto *(assumption)*.
- 157 `attack_model` = 1 when `player_battle_settings.auto_fight` and the mode allows auto, else 2.

## 9. Open questions and assumptions

1. Trigger conditions of `CrazySkill`, `BottomSkill(s)`, `LessHpSkill`, `AwakenSkill` are not in the client.
2. Whether the original auto picked skills by cost, by priority (`Priority`) or by a fixed slot order.
3. Whether the auto preference was persisted server side.
4. Real action intervals of the original server (the mock values 20/30 frames are tuned by eye).

## 10. Implementation checklist

- [ ] Route 10020 -> `battle::ai::handle_set_auto` with level and mode checks
- [ ] 157 `attack_model` from the stored preference
- [ ] Table `battle.player_battle_settings`
- [ ] Scheduler: start delay, per kind interval, busy time, frame ordering
- [ ] Auto skill choice for player units
- [ ] NPC AI cycle, phase change (`AwakenSkill`, `ChangeSkills`), summons (`Soldiers`)
- [ ] Test: auto on picks the most expensive affordable skill; manual click turns auto off (10020 mode 2)
- [ ] Test: below level 15 the server rejects mode 1
