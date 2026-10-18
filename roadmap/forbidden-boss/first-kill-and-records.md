# First kill rewards and boss records

Feature `forbidden-boss`, module `first-kill-and-records`. Client: `M11/forbiddenboss/ForbiddenRewardsFrame.as`, `ForbiddenRewardsItem.as`, `ForbiddenRecordFrame.as`, `ForbiddenRecordItem.as`, `CM/yishi/manager/ForbiddenBossManager.as`. Conventions: see [README.md](README.md).

---

## 1. Overview

- "Prêmio de 1ª Morte": every forbidden boss (47) has a `FirstRewards` package. Its state per player comes from `ForbiddenBossUserMsg.firstReward`: 1 claimable ("Receber"), 2 not reached (default), 3 claimed. The list is sorted claimable first, then not reached, then claimed, then by boss id. The main frame shows a red dot while any state is 1.
- "Registro do Chefão": a log of notable drops ("Nota: Registra apenas o Drop de Armad. Nv.3") of the server group, filtered by the category tab that was open when the frame was opened. Each line: "{date} [{nickname}] em {zone} derrotou {boss}, e obteve {item}".

---

## 2. Screens

| Class (file) | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `forbiddenboss.ForbiddenRewardsFrame` (`M11/forbiddenboss/ForbiddenRewardsFrame.as`), 780x548, openType 2 | "Prêmio de 1ª Morte" (`forbiddenRewardsFrame.titleText`) | First kill rewards of all bosses | "Prêmio de 1ª Morte" button of the main frame (`ForbiddenBossFrame.as:465-468`) | All templates with `firstRewardsType` from `model.firstRewardDic` (default 2), sorted by type then id (`:72-125`); refreshes on `FORBIDDEN_BOSS_USER_UPDATE` |
| `forbiddenboss.ForbiddenRewardsItem` (`M11/forbiddenboss/ForbiddenRewardsItem.as`) | none | One boss row | Rewards frame | Boss icon and name, `FirstRewards` items (`:75-104`); type 1: "Receber" button; type 2: "not reached" image; type 3: disabled "received" button (`:105-121`) |
| `forbiddenboss.ForbiddenRecordFrame` (`M11/forbiddenboss/ForbiddenRecordFrame.as`), 650x490, openType 3 with `frameData` = tab index | "Registro do Chefão" (`forbiddenRecordFrame.titleText`) | Drop log | "Registro" button (`ForbiddenBossFrame.as:470-473`) | Records whose boss `Category == tab index`, newest first (`recordArr` sorted by `id` ascending then reversed, `:81-105`; `ForbiddenBossManager.as:106-115`); tip "Nota: Registra apenas o Drop de Armad. Nv.3" |
| `forbiddenboss.ForbiddenRecordItem` (`M11/forbiddenboss/ForbiddenRecordItem.as:32-44`) | none | One record line | Record frame | `forbiddenRecordItem.txt.text` with `recordDate`, nickname in orange, campaign name coloured by category (`min(Category,4)+2` quality colour), boss name, item name coloured by item quality |

---

## 3. Routes (client to server)

Opcode **8675 (0x21e3) C_FORBIDDEN_BOSS_CLIENT_OP**, body `player.PlayerOpMsg` (`op #1 INT32`, `id #5 INT32`; other fields unused, see [boss-hall.md](boss-hall.md) §3).

| # | UI control | Client sender (file:line) | Client checks | Request | Expected response |
|---|---|---|---|---|---|
| F1 | "Receber" (`receiveBtn`, visible only for type 1) | `ForbiddenRewardsItem.__receiveBtnClickHandler` (`M11/forbiddenboss/ForbiddenRewardsItem.as:134-141`) → `ForbiddenBossManager.sendReward` (`CM/yishi/manager/ForbiddenBossManager.as:134-141`) | Button visibility only; no bag check | `{op=3, id=bossId}` | **4293** with the boss state 3; bag and currency pushes for `FirstRewards` |
| F2 | Opening the record frame | `ForbiddenRecordFrame()` constructor (`M11/forbiddenboss/ForbiddenRecordFrame.as:34-40`) → `ForbiddenBossManager.sendRecord` (`:143-149`) | none | `{op=4}` | **4296** full record list of the group |

---

## 4. Server messages (server to client)

| Opcode | Name | Message, fields (tag, type) | Client receiver (file:line) | When | Client reaction |
|---|---|---|---|---|---|
| 4293 (0x10c5) | U_C_FORBIDDEN_BOSS_USER | `ForbiddenBossUserMsg.firstReward (#3, STRING)` = "bossId,state\|bossId,state..." for every boss with a state other than the default 2 (other fields see [boss-hall.md](boss-hall.md) §4) | `ForbiddenBossManager.__forbiddenBossUserHandler` (`:67-78`), `ForbiddenBossModel.firstReward` setter (`CM/mvc/module/forbiddenboss/ForbiddenBossModel.as:54-57`) | Response to F1; after a kill that makes a first reward claimable | Rebuilds `firstRewardDic`; rewards frame and red dot refresh |
| **4296 (0x10c8)** | U_C_FORBIDDEN_BOSS_RECORD | `forbiddenboss.ForbiddenBossRecordListMsg`: `recordList (#1, ForbiddenBossRecordMsg, repeated)`. `ForbiddenBossRecordMsg`: `id (#1, INT32)` record id, ascending with time; `recordDate (#2, STRING)` text shown as is; `nickName (#3, STRING)`; `bossId (#4, INT32)` boss template id; `itemId (#5, INT32)` dropped item template | `ForbiddenBossManager.__forbiddenBossRecordHandler` (`:106-115`) | Response to F2 | Sorts by `id`, stores `recordArr`, notifies `FORBIDDEN_BOSS_RECORD_UPDATE`; the frame reverses and filters by category |

---

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| First kill state | 1 claimable, 2 not reached (client default when absent), 3 claimed | `ForbiddenRewardsItem.as:105-121`, `ForbiddenBossTempInfo.firstRewardsType = 2` |
| When a first kill becomes claimable | *(assumption)* For every player with damage > 0 on the boss life when it dies, the first time that boss is killed with his participation (per player, not per server) | |
| First kill rewards | `FirstRewards`, for example 31001 `-19000,1000\|7213403,1`; 34003 `-19000,5000\|7253803,1\|7253903,1` | `ForbiddenBossTemplates.xml` |
| Record filter | Only level 3 Theseus armour drops are logged (`forbiddenRecordFrame.tips`) *(assumption: item ids 72x3x03 of the drop tables, `ItemTempInfos` level 3 armour)* | |
| Record scope | Server group *(assumption)*, newest N kept *(assumption: 50)* | |
| Date text | `recordDate` is free text; recommended "YYYY-MM-DD hh:mm" | `ForbiddenRecordItem.as:34` |

---

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `raw/xml/tempinfos/ForbiddenBossTemplates.xml` | Boss | `Id`, `Category`, `CampaignId` (zone name via `Campaigns.xml`), `FirstRewards`, `BossInfo` (name, icon) |
| `raw/xml/tempinfos/ItemTempInfos.xml` | Items | `TemplateName`, `Profile` (quality colour) |

---

## 7. Persistent state (PostgreSQL, schema `forbidden_boss`)

```sql
CREATE TABLE forbidden_boss.first_kill_rewards (
  player_id   integer  NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  boss_id     integer  NOT NULL,                 -- ForbiddenBossTemplates.Id
  state       smallint NOT NULL CHECK (state IN (1, 3)),  -- 2 (not reached) is the absence of a row
  reached_at  timestamptz NOT NULL DEFAULT now(),
  claimed_at  timestamptz,
  PRIMARY KEY (player_id, boss_id),
  CHECK ((state = 3) = (claimed_at IS NOT NULL))
);

CREATE TABLE forbidden_boss.drop_records (
  record_id   bigserial   PRIMARY KEY,
  group_id    integer     NOT NULL,
  player_id   integer     REFERENCES player.players(player_id) ON DELETE SET NULL,
  nickname    text        NOT NULL,
  boss_id     integer     NOT NULL,
  item_id     integer     NOT NULL,
  created_at  timestamptz NOT NULL DEFAULT now()
);
CREATE INDEX drop_records_group ON forbidden_boss.drop_records (group_id, record_id DESC);
```

---

## 8. Backend implementation notes

| Handler | Route | Validation order | Transaction and pushes |
|---|---|---|---|
| `forbidden_boss::first_kill_and_records::handle_claim_first_kill` | 8675 op 3 | boss id exists → row exists with `state = 1` → bag space for item rewards | One tx: `state = 3`, `claimed_at`, grant `FirstRewards` (currency -19000 and items, bound *(assumption)*). After commit: 4293 (full user message), currency and bag pushes |
| `forbidden_boss::first_kill_and_records::handle_records` | 8675 op 4 | none | Read the last N `drop_records` of the player's group; send 4296 with `id = record_id` (fits INT32 on the wire; wrap-safe because ordering only matters inside one response) |
| `forbidden_boss::first_kill_and_records::on_kill` (called by the zone actor) | none | none | Insert `first_kill_rewards (state 1)` with `ON CONFLICT DO NOTHING` for each participant; insert `drop_records` for level 3 armour drops |

---

## 9. Open questions and assumptions

- *(assumption)* Who gets a first kill reward (every participant vs owner only).
- *(assumption)* Record scope (group vs server) and retention.
- *(assumption)* Exact item set considered "Armad. Nv.3".

---

## 10. Implementation checklist

- [ ] Tables `first_kill_rewards`, `drop_records`.
- [ ] Route 8675 op 3 with validation and grant; push 4293.
- [ ] Route 8675 op 4; push 4296.
- [ ] Kill hook inserting claimable first kill rows and records.
- [ ] Screen check: rewards frame sorting and button states, red dot, record lines and category filter.
- [ ] Test: claim twice → second refused, state stays 3.
