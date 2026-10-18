# Newbie privilege ("Privilégio de Novatos")

Path aliases:

| Alias | File |
|---|---|
| RWM | `decompiled/core_module/scripts/yishi/manager/RegistWelfareManager.as` |
| RWF | `decompiled/m11/scripts/registwelfare/RegistWelfareFrame.as` |
| RWI | `decompiled/m11/scripts/registwelfare/RegistWelfareItem.as` |
| RWC | `decompiled/m11/scripts/registwelfare/RegistWelfareConfirmFrame.as` |
| BM | `decompiled/core_module/scripts/yishi/manager/BaseManager.as` |
| TBH | `decompiled/core_module/scripts/ui/toptoolbar/TopBtnCheckShowHelper.as` |

## 1. Overview

A time limited welfare window for new characters (top toolbar template 2001 "新玩家福利"). It offers three discounted pack chains (mount, gems, fashion) bought with diamonds one step at a time, and a list of newbie tasks whose normal reward is free and whose extra reward ("Prêmios adicionais") can be bought with diamonds after the normal reward was claimed.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `registwelfare.RegistWelfareFrame` (RWF) | "Privilégio de Novatos" (RWF:100) | Countdown (days, hours, minutes, seconds to `endDate`, RWF:264-287), three chain buttons "Desconto de Pacote de Montaria", "Desconto do Pacote de Gemas", "Desconto do Pacote de Moda" with the current step number (RWF:130-132, 190-210), horizontal list of tasks (RWF:212-236) | top toolbar "registwelfare" (`TopToolsBar.as:1332-1333`); visible when hero level >= 6 and `endDate > now` (TBH:287-288) | step = chain index + 1; hidden when the index is -1 (chain finished) |
| `registwelfare.RegistWelfareConfirmFrame` (RWC) | "Ver Compra" (RWC:62) | Content and price of the current step of a chain | RWF chain button (`openControllerByInfo("registwelfare", 1, ItemBoxInfo)`, RWF:238-257) | `items` "templateId,count|..." (RWC:120-144), price |
| `RegistWelfareItem` (RWI) | task card: `detail`, "Prêmio de Missões" or "Prêmios adicionais" | State 0: collect disabled; 1: "Coletar" enabled (normal reward); 2: extra reward with "Apenas necessário" cost and "Pode obter" button (RWI:98-125) | RWF list (records with state != -1, sorted by state descending, RWF:212-236) | rewards filtered by job (`toJob`) |

## 3. Routes (client to server)

### N1. Buy the current step of a chain
- UI: RWC confirm (RWC:100-110).
- Client checks: `playerInfo.point >= price` (diamonds only) else `RechargeAlertMannager.show()`.
- Sender: `RegistWelfareManager.openChainBuy(id)` (RWM:231-237).
- Route: send 9561 (0x2559) `C_ITEM_BOX_CHAIN_BUY`; message `ItemBoxChainReqMsg` (active): `item_box_id` (#1, INT32) id of the step (`ItemBoxChainMsg.id`).
- Expected responses: 3 (`point`), bag updates, 260 with the new chain index (field 2 gems, 3 fashion, 4 mount).

### N2. Claim a task's normal reward
- UI: RWI "Coletar" (RWI:145-149) when state 1.
- Sender: `RegistWelfareManager.receiveHandler(taskId, 1)` (RWM:239-246).
- Route: send 9564 (0x255c) `C_SIMPLE_TASK_REWARD`; message `SimpleTaskReqMsg` (simpletask): `task_id` (#1, INT32); `reward_type` (#2, INT32) 1 = normal reward.
- Expected responses: bag updates, 266 with the task in state 2.

### N3. Buy a task's extra reward
- UI: RWI "Pode obter" (RWI:151-155) when state 2. No client diamond check.
- Sender: `RegistWelfareManager.increaseHandler(taskId, 2)` (RWM:248-255).
- Route: send 9564 (0x255c); `task_id` (#1), `reward_type` (#2) = 2.
- Expected responses: 3 (`point` minus `extraRewardCost`), bag updates, 266 with the task in state -1 (hidden, assumption: fully done).

## 4. Server messages (server to client)

### S1. 260 (0x0104) `U_C_PLAYER_EXTRA_FIELD_MSG`
- Fields used (BM:335, 876-901): 1 `value` = end of the welfare window "YYYY-MM-DD hh:mm:ss"; 2 gems chain index; 3 fashion chain index; 4 mount chain index (index into `ItemBoxChainIndexListMsg.itemBoxId`, -1 = finished). Message layout in [../currency/wallet.md](../currency/wallet.md) S4.
- When: login and after each chain purchase.

### S2. 261 (0x0105) `U_C_ITEM_BOX_CHAIN_MSG`
- Message `ItemBoxChainTemplateMsg` (active): `itemBoxChainIndexList` (#1, `ItemBoxChainIndexListMsg`, repeated: `type` (#1, INT32) 1 gems, 2 fashion, 3 mount; `itemBoxId` (#2, INT32, repeated) step ids in order); `itemBoxChainMsg` (#2, `ItemBoxChainMsg`, repeated: `id` (#1, INT32), `type` (#2, INT32), `price` (#3, INT32) diamonds, `items` (#4, STRING) "templateId,count|...", `preId` (#5, INT32), `nextId` (#6, INT32)).
- Receiver: `RegistWelfareManager.__chainBoxHandler` (RWM:78, 83-124).
- When: login (template data).

### S3. 265 (0x0109) `U_C_SIMPLE_TASK_MSG`
- Message `SimpleTaskListMsg` (simpletask): `simpleTask` (#1, `simpletask.SimpleTaskMsg`, repeated). `SimpleTaskMsg` (simpletask; `proto.json` lists the colliding `leed.SimpleTaskMsg`, fields read from `decompiled/core_module/scripts/com/road/yishi/proto/simpletask/SimpleTaskMsg.as:266-330`): `taskId` (#1, INT32); `type` (#2, INT32); `detail` (#3, STRING) description; `iParam1..iParam5` (#4..#8, INT32) condition parameters; `sParam1` (#9, STRING); `extraRewardCost` (#10, INT32) diamonds for the extra reward; `generalReward` (#11, `SimpleTaskRewardMsg`, repeated); `extraReward` (#12, `SimpleTaskRewardMsg`, repeated). `SimpleTaskRewardMsg`: `rewardItemID` (#1, INT32), `rewardItemCount` (#2, INT32), `toJob` (#3, INT32, 0 = every job).
- Receiver: `RegistWelfareManager.__taskMsgHandler` (RWM:79, 126-175).
- When: login.

### S4. 266 (0x010a) `U_C_SIMPLE_TASK_RECORD_MSG`
- Message `SimpleTaskRecordListMsg` (simpletask): `simpleTaskRecord` (#1, `SimpleTaskRecordMsg`, repeated: `task_id` (#1, INT32), `task_state` (#2, INT32)).
- Receiver: `RegistWelfareManager.__taskRecordHandler` (RWM:80, 177-201): merges records, notifies `REGIST_TASK_RECORD`, info tip 28 (count of state 1, RWM:203-214).
- When: login, on task progress and after N2 / N3.

Task states: -1 hidden, 0 in progress, 1 normal reward claimable, 2 normal reward claimed and extra reward purchasable (RWI:98-125; -1 meaning is an assumption).

## 5. Rules and formulas

- Window: from character creation until `endDate` (field 1). Duration is server configured (assumption: 7 days).
- Chains: each type has an ordered list of steps; buying the step at the current index advances to the next (`nextId`), last step sets index -1. Price diamonds only (RWC:103-107).
- Tasks: progress by `type` and `iParam*` (server task engine, [../quests/README.md](../quests/README.md)); normal reward free; extra reward `extraRewardCost` diamonds (diamonds only, assumption) only after the normal reward.
- Rewards filtered by job: `toJob` 0 or equal to the hero job (1 warrior, 2 archer, 3 mage; jobs 4 to 6 map to 1 to 3, as in `bag360/Bag360Item.as:200-216`, assumption).
- After `endDate` the toolbar hides; whether claimable rewards remain claimable is an open question (section 9).

## 6. Templates

None in `raw/xml/tempinfos`: chain steps and tasks are server data (261, 265).

## 7. Persistent state

```sql
CREATE TABLE vip.newbie_chain_steps (
  id          INTEGER  PRIMARY KEY,
  chain_type  SMALLINT NOT NULL CHECK (chain_type IN (1, 2, 3)),
  step_order  SMALLINT NOT NULL,
  price       INTEGER  NOT NULL CHECK (price > 0),
  items       TEXT     NOT NULL,                     -- "templateId,count|..."
  UNIQUE (chain_type, step_order)
);

CREATE TABLE vip.newbie_tasks (
  id                INTEGER  PRIMARY KEY,
  task_type         INTEGER  NOT NULL,
  detail            TEXT     NOT NULL,
  params            INTEGER[] NOT NULL DEFAULT '{}',
  sparam            TEXT,
  extra_reward_cost INTEGER  NOT NULL DEFAULT 0 CHECK (extra_reward_cost >= 0),
  general_reward    JSONB    NOT NULL,               -- [{item_id, count, job}]
  extra_reward      JSONB    NOT NULL
);

CREATE TABLE vip.newbie_welfare (
  player_id      BIGINT      PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
  ends_at        TIMESTAMPTZ NOT NULL,
  gem_index      SMALLINT    NOT NULL DEFAULT 0,     -- -1 finished
  fashion_index  SMALLINT    NOT NULL DEFAULT 0,
  mount_index    SMALLINT    NOT NULL DEFAULT 0
);

CREATE TABLE vip.newbie_task_progress (
  player_id   BIGINT   NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  task_id     INTEGER  NOT NULL REFERENCES vip.newbie_tasks(id),
  state       SMALLINT NOT NULL DEFAULT 0 CHECK (state IN (-1, 0, 1, 2)),
  progress    INTEGER  NOT NULL DEFAULT 0,
  PRIMARY KEY (player_id, task_id)
);
```

## 8. Backend implementation notes

- `vip::regist_welfare::handle_chain_buy` (9561): lock `vip.newbie_welfare`; require `now < ends_at`; the requested id must be the step at the current index of its chain; spend diamonds (no bound, reason "vip.newbie_chain"); grant items; advance index; reply 3, bag, 260 (fields 2..4).
- `vip::regist_welfare::handle_task_reward` (9564): lock progress; `reward_type` 1 requires state 1, grants general reward, state 2; `reward_type` 2 requires state 2, spends `extra_reward_cost`, grants extra reward, state -1; reply bag, 3 when paid, 266 with the changed record.
- Task progress hooks from the quest engine set state 0 -> 1 and push 266.
- Login: 261, 265, 266 and 260 (fields 1 to 4). Character creation inserts `vip.newbie_welfare` with `ends_at = created_at + window`.

## 9. Open questions and assumptions

- Assumption: window length 7 days; field 1 comes from the server only.
- Open: can rewards be claimed after `ends_at` (the frame is unreachable once the toolbar hides).
- Assumption: state -1 means fully done; state 2 card disappears after buying the extra reward.
- Gap: no client data for the chain steps and task list; must be authored.

## 10. Implementation checklist

- [ ] Screen: countdown and chain step numbers
- [ ] Screen: task cards in states 0, 1, 2
- [ ] Route N1 9561
- [ ] Route N2 9564 type 1
- [ ] Route N3 9564 type 2
- [ ] Server message S1 260 fields 1 to 4
- [ ] Server message S2 261
- [ ] Server message S3 265
- [ ] Server message S4 266
- [ ] Table `vip.newbie_chain_steps`
- [ ] Table `vip.newbie_tasks`
- [ ] Table `vip.newbie_welfare`
- [ ] Table `vip.newbie_task_progress`
- [ ] Rule: chain advances one step per purchase
- [ ] Rule: extra reward only after the normal reward, paid
- [ ] Test: buying a step that is not the current one is refused
- [ ] Test: toolbar hides after `endDate`
