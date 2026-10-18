# Casamento (marriage)

Feature slug `marriage`, domain social. Client package `marry` (`decompiled/m9/scripts/marry` views: `propose`, `quality`, `room`, `income`; `decompiled/core_module/scripts/marry/view` ring, propose box, flower views), core `managers/MarryManager`, `mvc/controler/MarryController`, `mvc/module/marry/*` (`MarryModel`, `MarrySender`, info classes). Wedding scene UI in the campaign map (`decompiled/m3/scripts/map/campaign/mediator/marry/MarryUIMediator.as`, `view/frame/MarryWeddingDialogFrame.as`), marriage NPC options (`decompiled/m3/scripts/map/space/view/frame/DialogOptionItem.as`), divorce alert (`decompiled/m3/scripts/map/space/view/frame/DivorceAlert.as`), marriage tree on the farm (`decompiled/m3/scripts/farm/view/marrytree/MarryTreeView.as`). Protobuf package `marriage` (11 messages) plus `farm.MarriageTreeMsg`, `friend.RecommendListMsg`, `reward.RewardUpdatedRspMsg`.

The feature registry also assigns the protobuf package `party` (`PartyMsg`, `PartyOpMsg`, `PartyOrdersMsg`, `PartyRewardMsg`, `PartyConsortiaMsg`, `PartyConsortiaMsgList`) to this feature, but the client uses it only in `managers/RavePartyManager` (Rave Party event, client package `raveparty`, feature [../seasonal-events/README.md](../seasonal-events/README.md)) and `yishi/manager/MagicPubManager` (feature [../fantasy-bar/README.md](../fantasy-bar/README.md)). It has nothing to do with weddings and is not mapped here; those features own it.

## What it does for the player

- Propose ("Pedir em casamento", level 36, ring item 208033 "Anel de Casamento", default text "Vamos casar, irei usar a minha vida para proteger você para sempre!"); the target answers in "Ninguém pediu você em casamento" (answer frame) from the toolbar propose box ("{0} pediu te em casamento"). Accepting makes both engaged.
- Choose and pay the wedding quality ("Casamento": "Amor de mil anos" 11999, "Casamento Nobre" 3188, "Casamento Normal" 1199 diamonds, 80% discount during the first 72 hours, half price for returning players), paid by one partner or split ("Dividir" / "Pagar Individualmente"). Requires a 2 member team with the captain acting at the marriage NPC.
- Wedding: a wedding hall room ("Salão de cerimônia") with room number, optional password, guest list ("Lista de Convidados", kick "Expulsar da Sal"), invitations ("Auto-Convidar", item 208003), ceremony actions at the NPC ("Iniciar o casamento", "Convocar o bolo", "Servir o champânhe", "Pegar o Buquê", "Servir os Doces", "Comprar Fogos de Artifício", "Oferecer {0} presente de Ouro", "Oferecer diamantes"), oath and auto walk, wedding carriage ride ("Amor de mil anos" only).
- Married life: satisfaction ("Pontos de Perfeição" up to level 9, then "Pontos de Felicidade") trained with "Coração de Rosas" 208034 or "Selo de Juramento" 208057, partner help with diamonds; ring tempering ("temperar", diamonds or "Coração Eterno" 208036, advanced with "Cristal da Eternidade" 208058) unlocking marriage skills; marriage tree on the farm (water with gold or diamonds, foster, refresh, harvest); daily heart quiz "Apaixonados" (questions from `HeartTempInfos.xml`); daily marriage tasks (10 per day).
- Mate search ("Nível do Anel de Casamento", "Nível de Perfeição").
- Divorce: by agreement (1000 diamonds, partner must agree), forced (1200 diamonds), free when the partner was offline for 5 days or more, cancel engagement; type "YES" to confirm.

## Entry points

| Entry | Code | Condition |
|---|---|---|
| Marriage NPC dialog options (space scene, NPC node `MARRY_NPC_NODE_ID = 22`) | `DialogOptionItem` cases 17 (quality), 19 (room list), 21/96/97 (tasks), 23 (ride), 25 (heart quiz), 90 (propose), 91/92/93 (divorce), 95 (task guide) `decompiled/m3/scripts/map/space/view/frame/DialogOptionItem.as:414` to `:600` | per option, see modules |
| "Pedir em casamento" in `PlayerMenu`, `ChatItemMenu`, IM window | `PlayerMenu.__onMarryHandler` `decompiled/core_module/scripts/yishi/view/community/PlayerMenu.as:494`, `ChatItemMenu` `:556`, `IMFrame.__marryBtnClickHandler` `decompiled/m12/scripts/im/IMFrame.as:386` then `MarryManager.creatProposeQuestFrame` | level 36, both single |
| Toolbar propose box / marry button | `MainToolBar.__onMarryBtnClick` `decompiled/core_module/scripts/ui/maintoolbar/MainToolBar.as:712` opens every pending proposal | proposals pending |
| Top tool bar "wedding" activity | `TopToolsBar` case `wedding` `decompiled/core_module/scripts/ui/toptoolbar/TopToolsBar.as:1339` opens `QUALITY_SELECT` | engaged |
| Ring in the equipment panel | `MarryRingView` `decompiled/core_module/scripts/marry/view/MarryRingView.as:184` opens the ring/train frame | married |
| Farm marriage tree | `MarryTreeView` `decompiled/m3/scripts/farm/view/marrytree/MarryTreeView.as:186` | married ("openAfterMarry") |
| Login | pushes 4657 (state), 357 (data), 4656 (proposals), 4675 (tasks) | |

Controller key `marry` with open types `QUEST`, `RECEIVE`, `SUCCEED`, `QUALITY_SELECT`, `QUALITY_CONFIRM`, `ROOM_LIST`, `WEDDING_SET`, `WEDDING_INVATE`, `RING_UPGRADE`, `TREE_FOSTER`, `TASK_MAP`, `HEART`, `MARRY_TRAIN`, `SEARCH_MATE` (`decompiled/core_module/scripts/mvc/controler/MarryController.as:42` to `:95`, constants `decompiled/core_module/scripts/mvc/module/marry/MarryModel.as:24`).

## Modules

| Module | File | Scope |
|---|---|---|
| Proposal and engagement | [proposal-and-engagement.md](proposal-and-engagement.md) | marriage state 4657, propose (8759 ops 1, 3, 9), proposal list 4656, lover info 4659, mate search (op 20, 359), engagement auto cancel |
| Wedding | [wedding.md](wedding.md) | quality purchase (15049, op 5, 4658), wedding hall rooms (op 6, 10, 13, 4662, 4673, 4674), room settings and invitations (8760 ops 105, 106, 110, 111), ceremony actions (8760 ops 101 to 112), oath 4660, auto move 4676, carriage (op 7, 4672) |
| Married life | [married-life.md](married-life.md) | marriage data 357, satisfaction (op 11, op 18), ring (op 12), skills (op 19), marriage tree (8773, 4678), heart quiz (8802, 4690, 4691), marriage tasks (8774, 4675) |
| Divorce | [divorce.md](divorce.md) | forced (op 8), free (op 15), agreement (ops 16, 17, push 358), confirm with children (op 14), cancel engagement (op 14 auto) |

## Dependencies

- [../team/freedom-team.md](../team/freedom-team.md): propose at the NPC, wedding quality and heart quiz require a 2 player team with the captain acting.
- [../friends/README.md](../friends/README.md): mate group in the friend list, intimacy shown in the propose frame, roses.
- [../chat/README.md](../chat/README.md): marriage announcements (`bigBugleType` 6, 7, 8, 9, 12 on channel 12), wedding room links (room tag `roomType = 4`).
- [../farm/README.md](../farm/README.md): marriage tree location; [../guardians/README.md](../guardians/README.md) (`ChildManager` children and divorce confirmation, child divide frame `decompiled/m14/scripts/child/handin/ChildDivideFrame.as`).
- [../inventory/README.md](../inventory/README.md), [../currency/README.md](../currency/README.md), [../shops/README.md](../shops/README.md): items 208033, 208034, 208036, 208057, 208058, 208003 and quick buy; diamonds and gold.
- Campaign maps (wedding campaigns 4301, 4302, 4303 from `MarrySpecTempInfos.xml`), tasks (`RingTaskManager`, reward templates), battle (`B_USE_MARRSKILL` 10509 for marriage skills in battle, battle feature).
- [../hero/README.md](../hero/README.md): ring grade and mate nickname shown on the hero (`RingGrade`, `NickNameB`).

## Suggested implementation order

1. [proposal-and-engagement.md](proposal-and-engagement.md): tables, state push 4657, propose and answer.
2. [wedding.md](wedding.md): quality purchase and the simplest wedding (room creation and ceremony start), then decorations, gifts, invitations, carriage.
3. [divorce.md](divorce.md).
4. [married-life.md](married-life.md): data 357, satisfaction, ring, skills, then tree, heart quiz, tasks.
