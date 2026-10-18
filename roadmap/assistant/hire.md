# Hiring an Anteus assistant

Area: assistant, module `hire`. Covers inviting a board assistant to help in one of four campaigns (`9682 C_ANTAEUS_CLIENT_OP` with `param1 = 3`), the cost formula, the per assistant limits, the resulting buff (`4188 U_C_ITEM_BUFFER`, buffer type 8) and the battle side effect, plus the Anteus coin earned by assistants.

Conventions: see [board.md](board.md). Paths are relative to the repository root. The whole feature is dormant in the BR client (`VersionSwitch.ANTAEUS = false`), see [board.md](board.md) section 1.

## 1. Overview

- The hire panel of `AntaeusFrame` shows 4 campaign cards, 3 at a time with left/right paging (`funCount = 4`, `pageCount = 3`, `decompiled/m11/scripts/antaeus/AntaeusFrame.as:115-119`, `:365-379`, `:403-413`). Each card (`AntaeusItem`) shows the campaign name and the cost for the selected assistant.
- Clicking a card asks to confirm (`antaeus.campaign.invite` with cost, assistant name and campaign) and sends the invitation. On success the player gets a buff of type 8 whose `grade` is the campaign index; the card of the hired assistant shows "invited" (`asset.antaeus.strInvited`).
- Campaign index (`antaeus.campaign.str<index>`, costs in `antaeus_money` described as "初始花费(泰坦神殿,黄道圣宫,地下迷宫,时空之门)"): 1 Titan Temple (`CAMPAIGN_TITAN`), 2 Ecliptic Palace (`CAMPAIGN_ECLIPTIC_PALACE`), 3 underground maze (`CAMPAIGN_TOWER`), 4 time-space gate ("shuttle") (`decompiled/core_module/scripts/yishi/manager/AntaeusManager.as:24-28`).

## 2. Screens

| Class | Language key | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `antaeus.AntaeusItem` (`decompiled/m11/scripts/antaeus/AntaeusItem.as`) | `antaeus.campaign` (label), `antaeus.campaign.str1..4` + `antaeus.campaign.str0`, cost text, `asset.antaeus.strInvited` | One campaign card | `AntaeusFrame.initContent` (`AntaeusFrame.as:305-323`) | Cost (`costMoney`), invited mark, grey when the shuttle limit is reached (`AntaeusItem.as:84-107`) |
| Buff icon and tip | `antaeus.buff.name`, `antaeus.tip.buff` with the campaign name, icon `/antaeus.png` | Active hire | Buff bar | `decompiled/core_module/scripts/yishi/datas/playerinfo/PlayerBufferInfo.as:133`, `:190`, `:238-244` |

## 3. Routes (client to server)

### 3.1 `9682 C_ANTAEUS_CLIENT_OP` (C>S, 0x25d2), invite (`param1 = 3`)

- UI control: click on a campaign card, then confirm.
- Sender: `AntaeusItem.onClick` -> `confirm` -> `AntaeusManager.sendInvite(index, assistantUserId)` (`AntaeusItem.as:119-170`, `AntaeusManager.as:91-99`).
- Request `CommonMsg` (package player): `param1 (#1, INT32) = 3`, `param2 (#2, INT32)` campaign index 1..4, `param3 (#3, INT32)` assistant player id. Other fields unset.
- Client-side checks, in order (`AntaeusItem.as:121-145`):
  1. A row is selected.
  2. Index 4 and the receiver already hired this assistant for the shuttle (`shuttleCount >= 1`) -> `antaeus.shuttle.countMax`.
  3. Hire count of this assistant >= 5 -> `antaeus.campaign.countMax`.
  4. An assistant is already hired (`AntaeusMsg.userId != 0`) -> `antaeus.campaign.used`.
  5. The assistant is the player himself -> `antaeus.campaign.self`.
  6. Confirmation dialog with the cost.
- Expected response: `4188` with the type 8 buffer (`grade = index`), the currency deduction push ([../currency/README.md](../currency/README.md)), then `4894` with `userId = assistant` and updated `assistantData` ([board.md](board.md)).

## 4. Server messages (server to client)

### `4188 U_C_ITEM_BUFFER` (0x105c), `ItemBufferRspMsg`

- Owned by the buff system ([../hero/README.md](../hero/README.md)); read by `PlayerBufferManager.__refreshItemBufferHandler` (`decompiled/core_module/scripts/yishi/manager/PlayerBufferManager.as:311-352`). For this module send one `BufferDataMsg` with `type = 8` (`PlayerBufferType.ANTAEUS_BUFFER`, `decompiled/core_module/scripts/yishi/datas/consant/PlayerBufferType.as:26`), `grade` = campaign index, `templateId` (assumption: 0), `validityDate` minutes left (assumption: until the next daily reset or until the campaign run ends).

### `4894 U_C_ANTAEUS_INFO`

See [board.md](board.md) section 4: `userId` is the active hire and `assistantData` carries `"<assistantId>_<hireCount>_<shuttleCount>"` per assistant.

## 5. Rules and formulas

- Cost: `antaeus_money[index - 1] * 2 ^ hireCount(assistant)` (`AntaeusItem.as:154-162`), with `antaeus_money = 40,50,20,80` (`raw/xml/tempinfos/ConfigInfos.xml`; read by `ConfigInfoManager.getAntaeusFunCost`, `decompiled/core_module/scripts/yishi/datas/ConfigInfoManager.as:1135-1140`). Example: third hire of the same assistant for the Ecliptic Palace costs `50 * 2^2 = 200`. Currency: not visible in the client (`ui.antaeus.money` icon); assumption: diamonds (point), falling back to bound diamonds first like other paid actions.
- Limits per receiver and assistant: 5 hires (`hireCount`), 1 shuttle hire (`shuttleCount`); one active hire at a time. Reset: assumption daily at 00:00.
- Assistant capacity: 100 assists per day (`antaeus_assists_max_count`).
- Reward to the assistant: Anteus coins (currency type 32, `decompiled/core_module/scripts/mvc/module/currency/CurrencyType.as:82`) per hire (assumption: equal to the cost paid, amount not in client data); spent in shop 1017 (22 goods priced in `Score`, for example item 2013505 for 700, 2350205 for 5000; `raw/xml/tempinfos/ShopTempInfos.xml`, `ShopGoodsInfo.PAY_BY_ANTAEUS_SCORE = 32`, `decompiled/core_module/scripts/mvc/module/shop/ShopGoodsInfo.as:69`, `:203`).
- Battle effect: no client battle code references the assistant; the server must add the assistant's hero (and companions from `AssistantDataMsg`) as an allied AI unit in the next battle of the hired campaign and consume the buff (assumption). Battle configuration follows `docs/battle/server-engine.md`: same `battleType` as the campaign, one extra allied unit built from the assistant's current army snapshot.

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `raw/xml/tempinfos/ConfigInfos.xml` | `antaeus_money`, `antaeus_assists_max_count` | `ConfigValue` |
| `raw/xml/tempinfos/ShopTempInfos.xml` | `ShopTempInfo ShopType="1017"` (22 rows) | `ItemId`, `Score` (price in Anteus coins), `IsHot`, `Sort` |

## 7. Persistent state

```sql
CREATE TABLE assistant.hire_counters (
  player_id        BIGINT      NOT NULL REFERENCES player.players(player_id),
  assistant_id     BIGINT      NOT NULL REFERENCES player.players(player_id),
  hire_count       SMALLINT    NOT NULL DEFAULT 0 CHECK (hire_count BETWEEN 0 AND 5),
  shuttle_count    SMALLINT    NOT NULL DEFAULT 0 CHECK (shuttle_count BETWEEN 0 AND 1),
  reset_on         DATE        NOT NULL DEFAULT current_date,
  PRIMARY KEY (player_id, assistant_id),
  CHECK (player_id <> assistant_id)
);

CREATE TABLE assistant.active_hires (
  player_id        BIGINT      PRIMARY KEY REFERENCES player.players(player_id),
  assistant_id     BIGINT      NOT NULL REFERENCES player.players(player_id),
  campaign_index   SMALLINT    NOT NULL CHECK (campaign_index BETWEEN 1 AND 4),
  cost_paid        INT         NOT NULL CHECK (cost_paid >= 0),
  hired_at         TIMESTAMPTZ NOT NULL DEFAULT now(),
  expires_at       TIMESTAMPTZ NOT NULL
);

CREATE TABLE assistant.hire_log (
  hire_id          BIGSERIAL   PRIMARY KEY,
  player_id        BIGINT      NOT NULL REFERENCES player.players(player_id),
  assistant_id     BIGINT      NOT NULL REFERENCES player.players(player_id),
  campaign_index   SMALLINT    NOT NULL,
  cost_paid        INT         NOT NULL,
  coins_awarded    INT         NOT NULL DEFAULT 0,
  consumed_battle  TEXT,
  hired_at         TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX hire_log_assistant_idx ON assistant.hire_log (assistant_id, hired_at DESC);
```

## 8. Backend implementation notes

- `assistant::hire::handle_invite` (9682 op 3), validation order: feature flag; `param2` in 1..4; assistant on the board and not removed; not self; no active hire; counters (5, shuttle 1) after daily reset; assistant `daily_assists < 100`; enough currency for the computed cost.
- Transaction: lock the receiver's counters row and the assistant's board row; deduct currency (currency service); insert `active_hires`, `hire_log`; increment `hire_count` (and `shuttle_count` for index 4), `board_entries.total_assists`, `daily_assists`; award coins to the assistant (currency 32).
- After commit: push `4188` (type 8, grade index), currency pushes, `4894` to the receiver; if the assistant is online, push its currency update.
- Battle hook: when the receiver starts a battle in the hired campaign, the campaign service asks `assistant::hire::take_helper(player_id, campaign_index)` which returns the assistant snapshot and deletes `active_hires` (sets `consumed_battle`), then pushes the buffer removal.
- Expiry job: delete expired `active_hires` and push the buffer removal.

## 9. Open questions and assumptions

- Assumption: payment currency and coin reward amount.
- Assumption: helper joins as an allied AI unit; the exact unit composition is not in the client.
- Assumption: daily reset of counters.
- Open: mapping of "地下迷宫" (index 3, `CAMPAIGN_TOWER`) and "时空之门" (index 4) to roadmap features: candidates [../mazes/README.md](../mazes/README.md), [../trials/README.md](../trials/README.md); Titan Temple and Ecliptic Palace map to [../dragon/README.md](../dragon/README.md) and [../ecliptic-palace/README.md](../ecliptic-palace/README.md).

## 10. Implementation checklist

- [ ] `9682` op 3 with validation order and limits
- [ ] Cost formula and currency deduction
- [ ] Buffer type 8 push (`4188`) and expiry
- [ ] Coin award (currency 32) and shop 1017 availability ([../shops/README.md](../shops/README.md))
- [ ] Battle hook in the four campaigns
- [ ] Tables `assistant.hire_counters`, `assistant.active_hires`, `assistant.hire_log`
- [ ] Test: sixth hire of the same assistant rejected
- [ ] Test: second shuttle hire rejected
- [ ] Test: cost doubles per previous hire
