# Seventh anniversary ("周年庆", registry name `sevenyear_events`)

Feature `seasonal-events`, module `seven-year`. The registry lists the client package `sevenyear_events` for this feature, but no such package exists in the client: the 7th anniversary hub is the client package `sevenyear` (`M11/sevenyear/*`, `CM/managers/SevenYearManager.as`), which the registry assigns to [../hermitage-war/README.md](../hermitage-war/README.md). The complete map of the hub (screens, routes 9692 and 9695, messages 4986..4989, 200, 4898, rules, templates, tables, handlers) is **[../hermitage-war/seven-year-event.md](../hermitage-war/seven-year-event.md)**; implement it from there and do not duplicate its tables.

This module records only what seasonal-events owns or shares around that hub.

Conventions: see [README.md](README.md).

---

## 1. Overview

| Piece | Owner | Notes |
|---|---|---|
| 7th anniversary hub (battle flag, level rewards, quiz, daily game, achievements, ranking, shop tab) | [../hermitage-war/seven-year-event.md](../hermitage-war/seven-year-event.md) | 2020 event (`seven_year_start_date` 2020-05-11 .. `seven_year_stop_date` 2020-06-08) |
| Proto package `active.anniversary` | seasonal-events (this feature) | message catalogue below; 6 messages used by the hub, 14 unused |
| Collection treasure box (9695 / 4898, `TreasureBoxDrop.xml`) | hub doc above | reused by the 2023 anniversary shop ([year-2023.md](year-2023.md)), so the 2023 event must ship the same handler |
| Top tool bar key `sevenyear` (TopToolBtnInfo 2061) | [year-2023.md](year-2023.md) | in this client it opens the 2023 frame `yearactive` (`TopToolsBar.as:1482-1483`); `SevenYearMainFrame` only reopens after a star area battle (`M4/castle/CastleSceneView.as:279-282`) |
| Star area tab | [../cosmos/stararea.md](../cosmos/stararea.md) | |
| Glory game tab | [../glory-supremacy/README.md](../glory-supremacy/README.md) | |
| Snow battle | [../artillery/README.md](../artillery/README.md) | |

---

## 2. Screens

None owned here. See the hub doc.

---

## 3. Routes (client to server)

None owned here. Routes 9692 `C_SEVEN_YEAR_OP` and 9695 `C_TREASURE_BOX_OP` are specified in the hub doc. 9695 is also sent by `M3/year2023/frame/YearActiveTreasureBoxFrame.as:482` (2023 shop collection items, SonType 668).

---

## 4. Server messages (server to client)

Messages of `active.anniversary` used by the hub (field lists in the hub doc and verified against `CM/com/road/yishi/proto/active/anniversary/*.as`):

| Message | Opcode | Fields |
|---|---|---|
| `SevenYearActiveMsg` | 4986 | `isOpen` (#1, BOOL), `startDate` (#2, STRING), `stopDate` (#3, STRING) |
| `SevenYearUserMsg` | 4987 | `flagGrade` (#1), `flagScore` (#2), `rewardGrade` (#3), `gameCount` (#4), `answerTotalScore` (#5), `achievementTotalScore` (#6), `snowScore` (#7) INT32; `achievements` (#8, SevenYearAchievementMsg, repeated); `rewardFreeGrade` (#9, INT32); `hasBuy` (#10, BOOL) |
| `SevenYearAchievementMsg` | inside 4987 | `type` (#1, INT32), `progress` (#2, INT32), `rewardGrades` (#3, INT32, repeated) |
| `SevenYearOrderListMsg` | 4988 | `orders` (#1, SevenYearOrderMsg, repeated), `orderDate` (#2, STRING) |
| `SevenYearOrderMsg` | inside 4988 | `order` (#1, INT32), `nickName` (#2, STRING), `serverName` (#3, STRING), `flagGrade` (#4, INT32) |
| `SevenYearQuestionMsg` | 4989 | `questionId` (#1, INT32), `options` (#2, INT32, repeated), `myAnswer` (#3, INT32), `rightAnswer` (#4, INT32), `cdTime` (#5, INT32) |

Messages of `active.anniversary` with no client user (do not implement unless a later client needs them): `ActiveInfoMsg` (`active_uid` #1, `activeReward` #2 ActiveRewardMsg repeated, `param1` #3, `beginTime` #4, `endTime` #5, `type` #6, `desc` #7, `activeSimpleMsg` #8 ActiveSimpleMsg repeated, `param2` #9, `param3` #10), `ActiveRewardMsg` (`templateId`, `templatecount`, `templateshow`, `item_type`, `original_price`, `now_price`, `limit_times`, `can_buy`), `ActiveSimpleMsg` (`active_type`, `beginTime`, `endTime`), `DreamCTPassMsg` (`item_id`, `nickName`, `serverName`, `isVip`), `GetTreasuryMsg` (`get_hour`, `temp_id`, `type`, `param1`, `param2`), `GoldenEggPassMsg` (`items` PassItem repeated), `PassItem` (`level`, `user_name`, `server_name`, `reward_type`, `egg_type`), `ItemInfo` (`temp_id`, `count`, `value`, `is_rare`, `multiple`, `is_buy`), `MysticalTreasuryMsg` (`currItem` ItemInfo repeated), `NoteInfo` and `NoteInfoMsg` (prayer notes: `id`, `type`, `serverName`, `nickName`, `content`, `praiseNmuber`, `user_id`), `PrayerInfoMsg` (`myNote`, `goldenNote`, `nomalNote` NoteInfoMsg repeated, `nomal_count`, `golden_count`, `free_count`, `uid`, `total_count`), `TruewordInfoListMsg` and `TruewordInfoMsg` (anniversary "true words" board). They describe anniversary sub-events of other regions (golden egg, mystical treasury, prayer wall, true words) that this BR client does not contain.

---

## 5. Rules and formulas

See the hub doc. The 2023 event reuses: the treasure box rules (one non repeated common item per opening, rare and very rare give an extra common item) and the star area mini game.

---

## 6. Templates

See the hub doc (`SevenYearRewardDrop.xml`, `SevenYearFreeRewardDrop.xml`, `SevenYearAchievementTemplates.xml`, `SevenYearQuestionTemplates.xml`, `TreasureBoxDrop.xml`, `ConfigInfos.xml` `seven_year_*`).

---

## 7. Persistent state

Owned by the hub doc (`hermitage_war.anniversary_*`, `hermitage_war.treasure_boxes`). The 2023 module must read and write `hermitage_war.treasure_boxes` for collection boxes instead of creating its own table.

---

## 8. Backend implementation notes

- Expose the hub's 9695 handler as a shared service so both `hermitage_war::seven_year` and `seasonal_events::year2023` can call it.
- `seasonal_events` keeps the generated protobuf code of `active.anniversary` (package ownership).

---

## 9. Open questions and assumptions

- The registry name `sevenyear_events` does not match any client package; the hub itself is registered under hermitage-war. Keep a single implementation.

---

## 10. Implementation checklist

- [ ] Generate `active.anniversary` messages (6 used)
- [ ] Share the 9695 / 4898 treasure box service with year 2023
- [ ] Implement the hub per [../hermitage-war/seven-year-event.md](../hermitage-war/seven-year-event.md)
