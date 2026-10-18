# Dragon Talker and Titan ("Encantador de Dragões e Titã")

Feature slug `dragon`, domain companions. Two systems unlocked after the job advance:

- **Encantador de Dragões** (dragontalker): an alternate hero form. In Dragon Talker form the hero wears talismans instead of equipment, inherits a share of the hero equipment through symbiosis, rides a combat beast and uses a dedicated skill tree with up to three skill sets; four potentials add passive bonuses.
- **Titã** (dragontitan): a collection of 12 Titans with a shared star level, three skill order pages (one Titan skill per battle round), spirit injection and resistance energization; plus the **Santuário de Titã** (titanland) daily PvE ladder in the Terrálem hub.

## Entry points

| Entry | Condition | Source |
|---|---|---|
| Toolbar `DragonTalkerBtn` (hotkey D) -> "Encantador de Dragões" | `vocationGrades > 0` and `DragonTalkerInfoMsg.isOpen` ("Ativado depois de Avançar Profissão e completar as Cavernas do Tempo.") | `decompiled/core_module/scripts/ui/maintoolbar/MainToolBar.as:2290-2312`, `decompiled/core_module/scripts/yishi/SwitchPageHelp.as:2255-2268` |
| Form switch button (resource bar, equip views) | same, not in battle | `talker.md` A1 |
| Toolbar child `titanBtn` (hotkey I) -> "Titã" | `isChangeJob` and a Titan owned ("Titã não ativado") | `MainToolBar.as:2302-2312`, `decompiled/core_module/scripts/ui/maintoolbar/constant/MainToolCheckBtnOpen.as:30-31` |
| Titan temple: NPC option 118, day guide 72 | `isChangeJob`, 06:00..23:00 | `titanland.md` |
| Time Vortex ("Cavernas do Tempo") dragon nodes 4842 | unlock source, owned by [trials](../trials/README.md) | `talker.md` section 1 |

## Modules

| Module | Scope | Opcodes |
|---|---|---|
| [talker](talker.md) | Dragon Talker state, form switch, skill sets, potentials ("Potencialidades") | 9667 ops 2, 10..13, 18, 19; 4845 |
| [talisman](talisman.md) | talismans: equip, strengthen, batch strengthening ("Fortalecimento em Lote"), quality, absorb, sell | 9667 ops 1, 3..6, 14..17, 20; 4844, 4846 |
| [symbiote](symbiote.md) | "Sistema de Simbiose" | 9667 op 7; 4845 |
| [battle-beast](battle-beast.md) | combat beast view ("Fera de Combate") | 9667 ops 8, 9; 4845 |
| [titan](titan.md) | Titans: display, star training, skill order, inject, reinject, energize | 9581 ops 0..9; 324 |
| [titanland](titanland.md) | "Santuário de Titã" ladder (battle 3860) | 9617 ops 0..3; 375 |

Not part of this feature: 8641..8643 and 8761, 8768, 8769 (dragon lair campaign, [campaign](../campaign/README.md)), 9689 `C_HOLY_DRAGON_OP` (holy dragon soul system), 4842 (Time Vortex nodes, [trials](../trials/README.md)).

## Dependencies

- [hero](../hero/README.md): form switch changes hero stats and battle skills; look up `DetailRspMsg.dragonTalkerInfo` (#20) and `titanInfo` (#16) in 4125.
- [inventory](../inventory/README.md): materials and bag pushes.
- [trials](../trials/README.md): Time Vortex unlock.
- [outyard](../outyard/README.md): Terrálem hub hosting the Titan temple.
- [battle](../battle/README.md): Dragon Talker skills, Titan round skills (`DragonTitanTeamView`), battleType 3860.
- [fashion](../fashion/README.md): Dragon Talker fashion (`DragonFashionMsg`).
- [goddess](../goddess/README.md): goddess formation texts mention Titan skills 6..9.
- [currency](../currency/README.md), [vip](../vip/README.md).

## Suggested implementation order

1. `talker` (state, 4845, unlock, switch) and `talisman` (4844 paging, equip) to make the form usable.
2. `symbiote`, `battle-beast`, then skill sets and potentials in `talker`.
3. `titan` (324, star training, skill pages) then inject/charge.
4. `titanland` (needs ranking snapshots and battle 3860).
