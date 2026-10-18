# Guardian seal ("Selo do Guardião")

Module `seal`. A daily matching mini game: the player clicks seal buttons (limited clicks per day); each click compares the clicked seal with the target ("option") seals and grants stars (5 on no match, 10 and activates a seal on match, +50 when all are activated); stars unlock up to five reward tiers. Option seals and the reward list can be refreshed for diamonds.

Path aliases:

| Alias | File |
|---|---|
| SM | `decompiled/core_module/scripts/managers/ChildesalManager.as` |
| SMOD | `decompiled/core_module/scripts/mvc/module/childseal/ChildesalModel.as` |
| F | `decompiled/m11/scripts/childesal/ChildesalFrame.as` |

## 1. Overview

- Send 9641 (0x25a9) `C_CHILD_SEAL_OP`, `ChildSealRequestMsg`: `op` (#1, INT32), `sealId` (#2, INT32, op 1 only), `payType` (#3, INT32, ops 2 and 3 only, the client always sends 1) (`SM:52-68`).
- Ops: 0 open/info, 1 click a seal, 2 refresh option seals, 3 refresh rewards.
- Receive 420 (0x01a4) `U_C_CHILD_SEAL`, `ChildSealMsg`.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `F`, `decompiled/m11/scripts/childesal/view/ChildesalItemView.as`, `decompiled/m11/scripts/childesal/view/ChildesalRewardItemView.as` | "Selo do Guardião", help "Instruções do Selo do Guardião" | seal grid, option seals, star bar, rewards "X{stars}" | `SwitchPageHelp.openChildEsalFrame` (`decompiled/core_module/scripts/yishi/SwitchPageHelp.as:2271-2279`, needs `isChangeJob`), top bar button (`ui.toptoolbar.TopToolsBar.tipData_childesal`), glow when clicks remain (`CHILD_ESAL_EFFECT`) | `star`, `count`/`child_seal_max_count`, seals, activated, options, rewards |

## 3. Routes (client to server)

| op | UI | Fields | Client checks | Response |
|---|---|---|---|---|
| 0 | frame open (`F:72`) | | | 420 |
| 1 | seal cell click (`F:369-372`) | `sealId` = clicked seal index | | 420 |
| 2 | refresh option seals (`F:288-318`) | `payType` 1 | confirm "Deseja consumir {0} diamantes par resfriar selo imediatamente?" (`child_seal_flush_option_point` 30), "today do not alert" option, diamonds (`point`) >= cost else recharge | 420, currency |
| 3 | refresh rewards (`F:320-349`) | `payType` 1 | confirm "Deseja consumir {0} diamantes par resfriar prêmios imediatamente?" (`child_seal_flush_reward_point` 100) | 420, currency |

## 4. Server messages (server to client)

### S1. 420 (0x01a4) `U_C_CHILD_SEAL`, `ChildSealMsg`
Receiver `SM.__receiveChildsealInfo` (`SM:75-112`): replaces the model, sorts rewards by stars, toggles the top bar glow when `count < child_seal_max_count`.

| Field | Tag | Type | Rep | Meaning |
|---|---|---|---|---|
| `star` | #1 | INT32 | | stars today (max `child_seal_max_star` 400) |
| `count` | #2 | INT32 | | clicks used today |
| `seals` | #3 | INT32 | yes | seal grid (seal types per button) |
| `activatedSeals` | #4 | INT32 | yes | activated seals |
| `optionSeals` | #5 | INT32 | yes | target seals |
| `rewards` | #6 | ChildSealRewardMsg | yes | `needStar` #1, `templateId` #2, `count` #3, `isGet` #4 BOOL |

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Daily clicks | `child_seal_max_count` 20 | config |
| Stars | no match +5 (`child_seal_no_match_add_star`), match +10 and activate (`child_seal_match_add_star`), all matched +50 (`child_seal_full_match_add_star`), cap 400 | config, help text |
| Reward tiers | `child_seal_get_reward_star` = 100, 200, 270, 340, 400 | config |
| Reroll | each click rerolls the clicked button's seal type (help item 5) | `childseal.helpTxt` |
| Refresh costs | options 30 diamonds, rewards 100 diamonds (not collected rewards only) | config, help item 8 |
| Reward claim | granted when the star threshold is reached *(assumption: automatic, no claim op exists)* | |
| Reset | daily *(assumption: 0h)* | |

## 6. Templates

`ConfigInfos.xml` `child_seal_*`. Reward pools are server side *(assumption)*.

## 7. Persistent state

```sql
CREATE TABLE guardians.seal_days (
  player_id        BIGINT   NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  day              DATE     NOT NULL,
  stars            SMALLINT NOT NULL DEFAULT 0 CHECK (stars BETWEEN 0 AND 400),
  clicks           SMALLINT NOT NULL DEFAULT 0 CHECK (clicks BETWEEN 0 AND 20),
  seals            SMALLINT[] NOT NULL,
  activated_seals  SMALLINT[] NOT NULL DEFAULT '{}',
  option_seals     SMALLINT[] NOT NULL,
  rewards          JSONB    NOT NULL,
  PRIMARY KEY (player_id, day)
);
```

## 8. Backend implementation notes

Handlers `guardians::seal::handle_open` (0), `handle_click` (1), `handle_refresh_options` (2), `handle_refresh_rewards` (3).

- Click: clicks < 20 -> compare `seals[sealId]` with options not yet activated -> stars and activation -> full bonus -> reroll that button -> grant newly reached reward tiers (bag 115, `isGet` true) -> push 420.
- Gate: job change required.

## 9. Open questions and assumptions

- *(assumption)* Number of grid buttons and seal types; reward pool contents.
- *(assumption)* `payType` 1 means diamonds.

## 10. Implementation checklist

- [ ] 9641 ops 0..3, push 420.
- [ ] Table `guardians.seal_days` with daily reset.
- [ ] Tests: 21st click rejected; match adds 10 stars and activates; refresh without 30 diamonds rejected; tier at 100 stars granted once.
