# Regresso de jogadores (`returning-players`)

Domain: events. Client packages `kingback`, `oldbacker`, `regress`, `kingcontract`, `oldplayerreturn` and the exp recovery frame `expback` (all m11), with shared code in `core_module`: `managers/KingbackManager.as`, `managers/OldBackerManager.as`, `yishi/manager/RegressManager.as`, `managers/KingContractManager.as`, `yishi/manager/ExpBackManager.as`, `yishi/manager/OldPlayerReturnManager.as`, models under `mvc/module/{kingback,oldbacker,kingcontract,oldplayerreturn}`. Protobuf packages `olderreflux`, `oldbacker`, `regress`, `recover`, `retrieve` (plus `player.KingContract*`, `player.PlayerOpMsg`).

## Overview

| System | pt-BR | What the player does | Status |
|---|---|---|---|
| King return | "Regresso do Rei" | returning players (offline >= 10 days, level 55, power 30000) get a time limited event: daily login rewards, regress score rewards (activity and recharge), discounted packs, and spend targets for holy weapons, divine weapons, goddess, Einherjar and guardians | live (toolbar `kingback`) |
| Old backer | "Regresso dos Jogadores Antigos" / "Novo Personagem da Migração" | an old player chooses to stay (buff "Prerrogativa Real" and rewards) or to migrate to a new server with a migration code that transfers a share of the old recharge value to the new character | live (toolbar `regress`) |
| Old players privileges | "Privilégios dos Velhos Jogadores" | a new character on the target server receives a share of the old recharge by level and login milestones | push handled; frame has no opener in this client |
| Elf contract | "Contrato dos Elfos" | 31 day service of convenience buffs (instant bounty quests, free bot speed up, free skill reset, boss radar, auto routes, ...), bought individually, all at once, renewed or gifted | live (resource bar, task trace, many feature frames) |
| EXP recovery | "Recuperação de EXP" | recover experience missed while offline, free share or paid larger share | live (queue bar button) |
| Old player return (alliance) | "Regresso dos Jogadores Antigos" (tabs "Missão de Regresso", "Contrato da Aliança", "Marco", "Loja do Evento") | returner and veteran alliance contracts, tasks, milestones and shop | fully mapped in [league](../league/README.md) |

## Entry points

| Entry | Condition | Opens | Source |
|---|---|---|---|
| Top toolbar `kingback` | `KingbackManager.isOpen == 1` (515 `openState`) | `KingbackFrame` "Regresso do Rei" | `decompiled/core_module/scripts/ui/toptoolbar/TopBtnCheckShowHelper.as:395-396`, `TopToolsBar.as:1479-1480` |
| Top toolbar `regress` "Privilégios de Velhos jogadores" | level >= 6 and 4843 `openState == 1` | `oldbacker` openType 1 (`backerType == 1`) or 2 | `TopBtnCheckShowHelper.as:291-292`, `TopToolsBar.as:1279-1288` |
| Resource bar contract icon, task trace, offer reward, mop up, farm, monster explore, archaeology, child patrol frames | none | `kingcontract` | `decompiled/core_module/scripts/ui/resourcebar/view/ResourceExtraView.as:129`, others in [king-contract.md](king-contract.md) |
| Queue bar EXP button, daily activity frame | `VersionSwitch.RECOVER_BAK`, level >= 40, `backExp > 0` | `expback` | `decompiled/core_module/scripts/ui/queuebar/QueueBar.as:640-660,728`, `decompiled/m11/scripts/dailyactivity/DailyActivityFrame.as:100` |
| Top toolbar `oldplayerreturn` / `oldplayerreturn2` | see league | `OldPlayerReturnFrame` | [../league/alliance-event.md](../league/alliance-event.md) |

## Modules

| Module | File | Scope |
|---|---|---|
| King return | [kingback.md](kingback.md) | 9690, 515, `OlderRefluxTempInfos.xml` |
| Old backer | [old-backer.md](old-backer.md) | 9666 ops 0..4, 4843 |
| Old players privileges | [regress.md](regress.md) | 9593, 340, `RegressTemplateInfos.xml` |
| Elf contract | [king-contract.md](king-contract.md) | 8540, 4434, `KingContracts.xml` |
| EXP recovery | [exp-recovery.md](exp-recovery.md) | 9503, 4912 |
| Old player return | [old-player-return.md](old-player-return.md) | screens only, protocol in league |

The `retrieve` protobuf package (`RetrieveInfosMsg`, `RetrieveInfo`) is consumed by the find back screens of client package `findback`; it is mapped in [../time-story/findback.md](../time-story/findback.md).

## Protocol summary

| Dir | Opcode | Hex | Name | Module |
|---|---|---|---|---|
| C>S | 9690 | 0x25da | `C_OLDER_REFLUX_OP` (`player.PlayerOpMsg`) | kingback |
| S>C | 515 | 0x0203 | `U_OLDER_REFLUX` (`OlderRefluxMsg`) | kingback |
| C>S | 9666 | 0x25c2 | `C_BACKER_OP` (`OldBackerMsg`) | old-backer |
| S>C | 4843 | 0x12eb | `U_C_OLCBACKER_INFO` (`OldBackerMsg`) | old-backer |
| C>S | 9593 | 0x2579 | `C_REGRESS_TAKE` (`RegressRecordMsg`) | regress |
| S>C | 340 | 0x0154 | `U_C_REGRESS_INFO` (`RegressRecordListMsg`) | regress |
| C>S | 8540 | 0x215c | `C_KING_CONTRACT` (`player.KingContractBuyMsg`) | king-contract |
| S>C | 4434 | 0x1152 | `U_C_KING_CONTRACTE` (`player.KingContractMsg`) | king-contract |
| C>S | 9503 | 0x251f | `C_RECOVER` (`RecoverReqMsg`) | exp-recovery |
| S>C | 4912 | 0x1330 | `U_C_RECOVER` (`RecoverRspMsg`) | exp-recovery |
| C>S | 9717 | 0x25f5 | `C_ALLIANCE_REGRESSION_OP` | [league](../league/README.md) |

Related but owned elsewhere: the "regression" funny activity (type 1007, 8860 `C_RETURNER_PLAYER`, 4739, 4740, `active.Return*Msg`, toolbar `regression1` "Pacote do novo rei" and `regression2` "Pacote do Regresso") belongs to [seasonal-events](../seasonal-events/README.md) (`decompiled/core_module/scripts/managers/FunnyManager.as:157-158,1095-1102`).

## Dependencies

- [recharge](../recharge/README.md): recharge totals drive king return scores and old backer rewards; `RechargeAlertMannager`.
- [currency](../currency/README.md), [inventory](../inventory/README.md): rewards, packs, spend targets.
- [hero](../hero/README.md): experience for EXP recovery, level gates, "Prerrogativa Real" buff (`PLAYER_OLDBACKER_BUFF_CHANGE`).
- [divine-weapon](../divine-weapon/README.md), [goddess](../goddess/README.md), [einherjar](../einherjar/README.md), [guardians](../guardians/README.md): king return spend targets.
- [league](../league/README.md): alliance regression.
- [time-story](../time-story/README.md): `retrieve` find back.
- Contract consumers: [mopup](../mopup/README.md), [farm](../farm/README.md), [exploration](../exploration/README.md), [archaeology](../archaeology/README.md), [world-boss](../world-boss/README.md), [forbidden-boss](../forbidden-boss/README.md), [skills](../skills/README.md).

## Suggested implementation order

1. Elf contract (most used): 4434 at login, 8540 buy, gift, fetch; bonus lookup API.
2. EXP recovery: offline experience accounting, 4912 at login, 9503.
3. King return: eligibility at login, 515, 9690 claims and pack purchases, score accumulation from activity and recharge.
4. Old backer and old player privileges: 4843 / 9666, migration codes across servers, 340 / 9593.
