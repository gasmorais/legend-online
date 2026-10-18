# Bar da Fantasia e Fonte Mágica (`fantasy-bar`)

Domain: events. Client packages `magicpub` (m11: `magicpub/MagicPubFrame.as` and views) and `magicspring` (m11: `magicspring/MagicSpringFrame.as`, `item/*`). Shared code: `decompiled/core_module/scripts/yishi/manager/MagicPubManager.as`, `decompiled/core_module/scripts/managers/MagicSpringManager.as`, `mvc/module/magicspring/*`, controllers `MagicPubControler`, `MagicSpringController`, templates `MagicPubNpcTemplateCate`, `MagicPubChatTemplateCate`, `MagicSpringTempCate`. Protobuf packages `magicpub` (3 messages) and `giftparty` (`GiftPartyMsg`, `GiftPartyTeamInfoMsg`, `TeamMemberInfoMsg`, used by the Magic Pub gift party), plus `player.MagicSpringMsg`, `player.CommonMsg` and `simple.PropertyMsg`.

## Overview

| System | pt-BR | What the player does |
|---|---|---|
| Fantasy bar NPCs | "Bar da Fantasia" | 5 NPCs (Miguel, Baiding, Diana, Sandy, Brad). Talk once a day and give gifts (10 a day) to raise "Grau de Amizade" (friendship level 1..5). Friendship unlocks magic cards; talking and gifting also give magic dust. NPCs in good mood give double. |
| Gift party | gift party ("礼品会"), opened from the bar or the time activity box | twice a day (12:00-12:30, 18:00-18:30) players form 3 member teams; each member holds a fragment of quality normal, advanced or epic (1, 2, 3 points) for the top, middle or bottom position; the leader starts and the team gets gift items by total quality (levels 3..9). Fragments can be refreshed for diamonds or sold directly. |
| Magic spring | "Fonte Mágica" | spend magic potions to brew temporary buffs ("magias") into up to 5 slots (gold +100%, farm +100%, campaign gains, cosmos cost, offer rewards, ...). Slots unlock by potion usage or diamonds. |

## Entry points

| Entry | Condition | Opens | Source |
|---|---|---|---|
| Magic card frame "treasure" button | none | `magicpub` (list view) | `decompiled/m5/scripts/magicCard/view/MagicCardSlotView.as:179-183` |
| Day guide option 46, `SwitchPageHelp.gotoMagicPub` | level >= 32 ("dayGuide.DayGuideManager.command02") | `magicpub` | `decompiled/core_module/scripts/managers/DayGuideManager.as:655-663`, `decompiled/core_module/scripts/yishi/SwitchPageHelp.as:1685-1699` |
| Top toolbar `giftwill`, time activity box `giftwill` | level >= 32 (button visible at 32) | `magicpub` with `frameData = 3` (gift party view) | `decompiled/core_module/scripts/ui/toptoolbar/TopBtnCheckShowHelper.as:315-316`, `TopToolsBar.as:1407-1414`, `decompiled/core_module/scripts/ui/toptoolbar/view/TimeActiveBoxView.as:153-160` |
| Bar list "open gift party" button | level >= 32 | gift party view | `decompiled/m11/scripts/magicpub/MagicPubListView.as:122-132` |
| Top toolbar `magicspring` "Fonte Mágica" | `VersionSwitch.MAGIC_SPRING` and level >= `magic_spring_open_grade` (50) | `magicspring` | `TopBtnCheckShowHelper.as:369-370`, `TopToolsBar.as:1435-1436` |

## Modules

| Module | File | Scope |
|---|---|---|
| Fantasy bar NPCs | [magic-pub.md](magic-pub.md) | 9632 ops 1..3, 404 |
| Gift party | [gift-party.md](gift-party.md) | 9636 ops 1..9, 409, 412, 413 |
| Magic spring | [magic-spring.md](magic-spring.md) | 5189 ops 1..4, 172, buff consumers |

## Protocol summary

| Dir | Opcode | Hex | Name | Module |
|---|---|---|---|---|
| C>S | 9632 | 0x25a0 | `C_MAGIC_PUB_OP` (`MagicPubReqMsg`) | magic-pub |
| S>C | 404 | 0x0194 | `U_C_MAGIC_PUB` (`MagicPubInfoListMsg`) | magic-pub |
| C>S | 9636 | 0x25a4 | `C_GIFTPARTY_OP` (`GiftPartyMsg`) | gift-party |
| S>C | 409 | 0x0199 | `U_C_GIFTPARTY_TEAMINFO` | gift-party |
| S>C | 412 | 0x019c | `U_C_GIFTPARTY_TEAMLIST` | gift-party |
| S>C | 413 | 0x019d | `U_C_GIFTPARTY_OPENSTATE` (`simple.PropertyMsg`) | gift-party |
| C>S | 5189 | 0x1445 | `C_MAGIC_SPRING_OP` (`player.CommonMsg`) | magic-spring |
| S>C | 172 | 0x00ac | `U_C_MAGIC_SPRING_INFO` (`player.MagicSpringMsg`) | magic-spring |
| S>C | 4725 | 0x1275 | currency refresh (gift items 101..110 as currencies) | magic-pub, gift-party |

## Dependencies

- [magic-cards](../magic-cards/README.md): friendship levels unlock cards; magic dust currency; the magic card frame opens the bar.
- [currency](../currency/README.md): gift items are currencies (master types 101..110, display templates -1700..-1709) refreshed by 4725; diamonds for fragment refresh and slot unlock.
- [inventory](../inventory/README.md): magic potions 250001..250006 (SonType 398).
- Buff consumers of the magic spring: [castle](../castle/README.md) (gold), [farm](../farm/README.md), [campaign](../campaign/README.md), [cosmos](../cosmos/README.md), [mines](../mines/README.md), [cat-house](../cat-house/README.md), [abyss](../abyss/README.md), [laboratory](../laboratory/README.md), [outyard](../outyard/README.md), [sky-realm](../sky-realm/README.md) and others listed in [magic-spring.md](magic-spring.md).
- [time-story](../time-story/README.md): the time activity box (`TimeActiveBoxView`) hosts the gift party entry.

## Suggested implementation order

1. Magic spring: template loader, 172 at login, 5189 ops 4, 2, 3, 1; server side buff lookup API for the other features.
2. Fantasy bar: NPC state table, 404 op 0 at login and daily reset, 9632 ops 2, 1, 3, magic dust and friendship.
3. Gift party: open window scheduler and 413, fragments, teams, 9636 ops 8, 9, 1..7, rewards.
