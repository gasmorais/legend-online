# Find back ("Sistema de Resgate")

Module `findback` of feature `time-story`. Protobuf package `retrieve` (assigned to [returning-players](../returning-players/README.md) in `roadmap/features.json`; mapped here because only this module reads it).

Path aliases:

| Alias | File |
|---|---|
| FBM | `decompiled/core_module/scripts/mvc/module/findback/FindBackModel.as` |
| FBI | `decompiled/core_module/scripts/mvc/module/findback/FindBackItemInfo.as` |
| FBR | `decompiled/core_module/scripts/mvc/module/findback/FindBackRewardInfo.as` |
| PM | `decompiled/core_module/scripts/yishi/manager/PlayerManager.as` |

## 1. Overview

Daily activities the player missed can be recovered the next day: each activity type offers its rewards for gold (`findType` 1) or diamonds (`findType` 2). "Recover all" applies a discount ladder (`item_back1` for gold, `item_back2` for diamonds; default `1|0.8|0.7|0.7|0.7|0.7|0.7|0.7` by number of activities, FBM:179-211). Language keys `active.expback.*` ("Sistema de Resgate", "Resgates:", "Prêmio:", "Material insuficiente, substituído por diamantes", help "É possível resgatar o valor máximo diário de cada módulo ... Ganhos resgatáveis poderão apenas ser resgatados no mesmo dia de acesso, sendo redefinidos no segundo dia") describe the screen.

Status: the model exists, but `PM.__findBackHandler` (PM:236-258) is never registered on the socket, no screen class exists, and no request is sent. Nothing is reachable in this client.

## 2. Screens

None in this client (only model `FindBackModel` on `PlayerModel.findBackModel`, `decompiled/core_module/scripts/yishi/datas/playerinfo/PlayerModel.as:165`).

## 3. Routes (client to server)

None. No find back request opcode exists in `protocol/opcodes.csv`.

## 4. Server messages (server to client)

### S1. 4561 (0x11d1) `U_C_FIND_BACK`, `RetrieveInfosMsg` (handler unregistered)

| Field | Tag | Type | Meaning |
|---|---|---|---|
| `operate` | #1 | INT32 | non zero = already received today |
| `retrieveInfo` | #2 | `RetrieveInfo`, repeated | one per activity and payment type |

`RetrieveInfo`: `temp_type (#1, INT32)` activity type, `temp_name (#2, STRING)` name, `total_gold (#3, INT32)` gold cost, `total_point (#4, INT32)` diamond cost, `retrieve_count (#5, INT32)` recoverable count, `items (#6, STRING)` rewards `templateId,count|...` (zero pairs skipped, FBI:28-56), `type (#7, INT32)` 1 gold, 2 diamonds.

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| All discount | ladder by number of activities, last value of the comma list at index n-1 | FBM:179-211 |
| Reset | next day | help text |

## 6. Templates

`ConfigInfos.xml` `item_back1`, `item_back2` (absent in the shipped file, client defaults apply).

## 7. Persistent state

```sql
CREATE TABLE time_story.findback_entries (
  player_id       BIGINT NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  entry_day       DATE NOT NULL,
  activity_type   INTEGER NOT NULL,
  pay_type        SMALLINT NOT NULL CHECK (pay_type IN (1, 2)),
  cost            INTEGER NOT NULL,
  items           TEXT NOT NULL,
  retrieved       BOOLEAN NOT NULL DEFAULT false,
  PRIMARY KEY (player_id, entry_day, activity_type, pay_type)
);
```

## 8. Backend implementation notes

Only compute and store entries (daily job from yesterday's activity participation) so a later client can use them; do not send 4561 to this client.

## 9. Open questions and assumptions

- No request protocol; the feature is effectively removed from this client.

## 10. Implementation checklist

- [ ] Decide whether to implement (no client path)
- [ ] Table `time_story.findback_entries` if implemented
- [ ] Server message 4561 contract documented
