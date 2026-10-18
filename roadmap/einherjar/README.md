# Einherjar (pets)

"Einherjar" are the lord's pets (frame title "Einherjar"). A player collects pets (from the "Ilha de Einherjar", seal spheres, initial gifts), deploys one to follow and fight with the lord ("Perseguir Personagem") or with a guardian, grows them (level up to 80 but never above the lord, aptitudes, quality, refining into higher tiers, fusion into dual element pets), teaches awakening skills used in battle, equips them with pet equipment, and uses them in pet only modes: the cross server "Arena de Einherjar", the daily "Expedição de Einherjar" ladder, the "Armas Divinas" hallows, the island defense event and farm practice.

Client packages: `pet` (m14, 56 classes), `petchallenge` (14), `pethallows` (12), `remotepet` (24), `petboss` (2); "petland" lives in the farm and campaign code. Proto packages: `pet`, `remotepet`.

## Entry points and unlock conditions

| Entry | Condition | Citation |
|---|---|---|
| Toolbar pet button -> pet frame | lord level >= 50 (tip "store.view.StoreFrame.command01" 50) | `decompiled/core_module/scripts/ui/maintoolbar/MainToolBar.as:1500-1515`, `decompiled/core_module/scripts/ui/maintoolbar/constant/MainToolCheckBtnOpen.as:26-27` |
| Hotkey Y | same | `MainToolCheckBtnOpen.as:86-87`, `decompiled/core_module/scripts/yishi/keyboard/KeyBoardRegister.as:899` |
| Pet button child -> "Armas Divinas" | lord changed job (`isChangeJob`) | `MainToolBar.as:1516-1520`, `MainToolCheckBtnOpen.as:46-47` |
| Queue bar item / post battle (type 35) -> "Arena de Einherjar" | level >= 50 and at least one pet | `decompiled/core_module/scripts/mvc/controler/PetChallengeController.as:66-85` |
| Space NPC option 101 -> "Expedição de Einherjar" | level >= 50 (message says 60), 01:00..23:00 | `decompiled/m3/scripts/map/space/view/frame/DialogOptionItem.as:646-665` |
| Space NPC option 6, transfer scrolls -> "Ilha de Einherjar" | level >= 50 | `DialogOptionItem.as:380-382` |
| Top bar "petboss" -> "Proteção da Ilha do Einherjar" | level >= 50, event hours | `decompiled/core_module/scripts/ui/toptoolbar/TopToolsBar.as:1185-1191` |
| Farm pet plot -> "Praticar com Einherjar" | level 50 | `FarmPetLandView.noOpen` |
| Player info / rankings -> look at another pet | none | `decompiled/m5/scripts/playerinfo/PlayerInfoFrameII.as:1544,1678`, `decompiled/m11/scripts/sort/SortMemberItem.as:169` |

FrameControllerManager keys: `pet`, `pethallows`, `petchallenge`, `remotepet`, `petboss` (`decompiled/core_module/scripts/yishi/manager/FrameControllerManager.as:975-982,1539-1660`).

## Modules

| Module | File | Scope | Routes | Server messages | Tables |
|---|---|---|---:|---:|---|
| Pets roster | [pets.md](pets.md) | Entity, 4540 sync, list and slots, deploy/rest/guardian, prioritize, sacrifice, rename (AMF), lock, look up (8702/4608), full 8621 op table | 9 | 3 | `pets`, `player_state`, `pet_mode_skills` |
| Growth | [growth.md](growth.md) | Absorb (op 1), aptitude training (op 7), growth advance (op 4), refine (op 13), fusion (op 15) | 5 | 2 | `growth_log` (optional) |
| Skills | [skills.md](skills.md) | Learn by book or random (op 5), forget (op 18), bar order (op 11), battle pushes 391/392, cast 10519 | 5 | 3 | `pet_skills` (optional) |
| Equipment | [equipment.md](equipment.md) | Equip in bag 26 (5005), mould strengthen (8644/4558), upgrade (5153/89), refinery (8336/8339/8464, 4258/4368), sacred spirits (5151/5152) | 9 | 6 | `pet_equipment_refinery` (optional, inventory owned) |
| Pet arena | [challenge-arena.md](challenge-arena.md) | 8256/4611, 8724 battle 35, formation 8725, skills 8726, cooldown 8265/4176, finish now 8727, weekly reward 8728/4613, `crosspet.xml` | 7 | 4 | `arena_players`, `arena_logs`, `arena_week` |
| Hallows | [hallows.md](hallows.md) | "Armas Divinas": 9627 ops 1..5, push 388 | 5 | 2 | `hallows`, `hallow_inscriptions`, `pet_contracts` |
| Expedition | [remote-expedition.md](remote-expedition.md) | 9544 ops 1, 2, 5..11, friends 15057, battle 3844, skill 14001, pushes 4964..4967, `remotepet.xml` | 12 | 5 | `expedition_state`, `expedition_pets` |
| Island and defense boss | [boss-island.md](boss-island.md) | Enter 8694, transfer scrolls, event 4686, report 4203 type 4 | 3 | 2 | `island_event`, `island_daily_kills`, `island_boss_damage` |
| Pet land | [pet-land.md](pet-land.md) | Farm practice and guard (15044 ops 13, 15, 16, 18) | 4 | 2 | `pet_land_slots` (farm owned) |

All tables live in schema `einherjar`.

## Dependencies

| Feature | Why |
|---|---|
| [../hero/README.md](../hero/README.md) | `ThaneInfo` pet avatar fields, `ArmyMsg` pet data, lord level gates, fighting capacity |
| [../battle/README.md](../battle/README.md) | Pet units (`pets[]`), pet battles 35 and 3844, 10519/14001 skill orders, 8727 finish now, 391/392 |
| [../inventory/README.md](../inventory/README.md) | Bag 26 (pet equipment), work bag 0, 5005/115, item use 5006 (transfer scrolls, seal spheres) |
| [../smith/README.md](../smith/README.md) | Shared handlers 5150..5153, 8336/8339/8464, 8644 |
| [../shops/README.md](../shops/README.md) | Skill books (hidden goods), "Troca Einherjar" exchange shop, auto buy prices |
| [../guardians/README.md](../guardians/README.md) | Pets assigned to main/secondary guardian (ops 16/17), guardian PvE skills reuse 9544 op 5 |
| [../farm/README.md](../farm/README.md) | Pet practice plots and guard pet |
| [../campaign/README.md](../campaign/README.md) | Island maps 20001..25000 |
| [../world-boss/README.md](../world-boss/README.md) | 4203 report type 4 |
| [../friends/README.md](../friends/README.md) | Friend pets for the expedition |
| [../casino/README.md](../casino/README.md) | Monopoly pet formation cleared when pets change |
| [../vip/README.md](../vip/README.md) | Arena finish now (VIP 3), cooldown privilege, free skill interval privilege 205 |
| [../account/README.md](../account/README.md) | Vice password lock 8809 op 2, nickname check, AMF `renamePet` |
| [../mopup/README.md](../mopup/README.md) | Expedition sweep frames |
| [../rankings/README.md](../rankings/README.md) | Pet data in ranking XML |
| [../currency/README.md](../currency/README.md) | Diamonds, bound diamonds (`giftToken`), gold |

## Suggested implementation order

1. [pets.md](pets.md): tables, login 4540, deploy/rest, list slots, sacrifice, look up; battle hook for the fighting pet.
2. [growth.md](growth.md): absorb, aptitude training, growth advance (needed to make pets useful).
3. [skills.md](skills.md): learn/forget/order, battle 392/391.
4. [equipment.md](equipment.md) once the smith handlers exist.
5. [boss-island.md](boss-island.md) entry (pet source) and [pet-land.md](pet-land.md) with the farm.
6. [challenge-arena.md](challenge-arena.md) and [remote-expedition.md](remote-expedition.md) (need pet battles 35 and 3844).
7. [hallows.md](hallows.md) (needs dual element pets from fusion).

## Current server behavior

`server/flows.json` and `server/flows/*.json` have no rule for 8621, 8702, 9627, 9544, 8256, 8724..8728, 8694 or 15057; the client starts with an empty pet list.
