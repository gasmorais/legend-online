# Anteus board (ranking of assistants, sign-up and tips)

Area: assistant, module `board`. Covers the Anteus NPC frame: the top 10 list of strongest players who signed up as "assistants", the detail of the selected assistant (avatar, power, companions), the sign-up action, and the tip pushes inviting a player to sign up or to hire help after a defeat. Protocol: `9682 C_ANTAEUS_CLIENT_OP` (`CommonMsg.param1` 1 open, 2 sign), `4894 U_C_ANTAEUS_INFO` (`AntaeusMsg`), `4897 U_C_ANTAEUS_TIPS`.

Conventions used in this file:

- Paths are relative to the repository root. AS3 citations use `decompiled/<module>/scripts/<path>.as:<line>`.
- Opcodes come from `protocol/opcodes.csv`. "C>S" is client to server, "S>C" is server to client.
- Protobuf fields are written `name (#tag, TYPE, repeated?)` from `protocol/proto.json`.
- "Assumption" marks behavior not visible in client code.

## 1. Overview

- Anteus ("安泰俄斯") is a sky city NPC (space node 47, `decompiled/core_module/scripts/map/space/data/SpaceNodeType.as:68`; node function 135 maps to controller `antaeus`, `decompiled/m3/scripts/map/space/helper/hero/SpaceArmyViewHelper.as:214-215`).
- Strong players (fighting capacity >= 10 000 000 and higher than the current 10th place) sign up to the board. Other players hire one of them as a helper for one of four hard campaigns ([hire.md](hire.md)). Assistants earn Anteus coins (currency 32) spent in the Anteus shop (shop type 1017).
- Dormant in the BR client: `VersionSwitch.ANTAEUS` is `false` and never assigned (`decompiled/core_module/scripts/yishi/datas/VersionSwitch.as:166`). With it false the controller refuses to open ("Esta função ainda não foi ativada", `decompiled/core_module/scripts/yishi/manager/FrameControllerManager.as:1896-1902`), node 47 is not drawn (`decompiled/m3/scripts/map/space/mediator/mapview/SpaceUIMediator.as:100`), the tip views are not created (`decompiled/core_module/scripts/managers/TaskTraceTipManager.as:866-877`) and the coin is hidden from the currency list (`decompiled/core_module/scripts/managers/PlayerCurrencyManager.as:701-706`). All `antaeus.*` language keys are missing from `index/language.json`, and every `antaeus_*` row of `ConfigInfos.xml` is tagged "【废弃】" (deprecated). Enabling the feature needs a client patch (`VersionSwitch.ANTAEUS = true`, through `PATCHES` in `tools/as3/gen.py`) and pt-BR strings; the backend below is complete for when that happens.

## 2. Screens

| Class | Language key (pt-BR missing) | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `antaeus.AntaeusFrame` (`decompiled/m11/scripts/antaeus/AntaeusFrame.as:34`) | title bitmap `asset.antaeus.title`, help tip `antaeus.help.title` | Board and hire panel | Controller `antaeus` (`decompiled/core_module/scripts/mvc/controler/AntaeusController.as:33-40`): node 47, tip views `AntaeusMeetTipView` / `AntaeusBattleFailureTipView` (`decompiled/m16/scripts/tasktracetip/view/AntaeusMeetTipView.as:44`, `AntaeusBattleFailureTipView.as:44`) | 10 rank rows, selected assistant power (digits), name, `[server]`, `antaeus.assistCount` (assists), avatar, 6 companion icons with tips, 3 of 4 campaign cards with paging, Sign, Shop, Help |
| `antaeus.AntaeusListItem` (`decompiled/m11/scripts/antaeus/AntaeusListItem.as`) | `antaeus.player.power` | One rank row; click selects | Frame | rank, name, power |
| `antaeus.AntaeusTip` (`decompiled/m11/scripts/antaeus/AntaeusTip.as:58-120`) | `antaeus.tip1-0..tip6-7` | Companion detail | Hover on `_txt1.._txt6` (`AntaeusFrame.as:282-303`) | 1 pet `petCap`; 2 child `childrenCap`; 3 slave child `slaveChildCap`; 4 goddess attack..live; 5 artifact attack..live; 6 titan stars (`starLevel / 10`, `% 10`) and 7 resistances |
| `antaeus.AntaeusHelpFrame` | n/a | Rules | Help button (`AntaeusFrame.as:415-419`) | static |
| `shop.AntaeusShopFrame` (`decompiled/m15/scripts/view/subshop/AntaeusShopFrame.as:31`) | `antaeus.shop.title` | Coin shop | Shop button -> `openControllerByInfo("shop", 1017)` (`AntaeusFrame.as:428-431`) | owned by [../shops/README.md](../shops/README.md) |
| Tip views 58 / 59 | `tasktracetip.view.AntaeusBattleFailureTipView.ContentTxt` "Pode convidar o assistente Anteus para auxiliar no combate"; `AntaeusMeetTipView.ContentTxt` "Sua é força é grande o suficiente para se tornar assistente de Anteus"; button "Ir Agora" | Invitations | `4897` | text |

## 3. Routes (client to server)

All actions use `9682 C_ANTAEUS_CLIENT_OP` (C>S, 0x25d2) with `CommonMsg` (package player): `param1 (#1, INT32)` operation, `param2 (#2, INT32)`, `param3 (#3, INT32)`, `param4 (#4, STRING)`, `param5 (#5, STRING)`, `param6 (#6, INT64)`, `param7 (#7, INT64)`. Constants `OP_OPENVIEW = 1`, `OP_SIGN = 2`, `OP_INVITATION = 3` (`decompiled/core_module/scripts/yishi/manager/AntaeusManager.as:18-22`).

### 3.1 Open board (`param1 = 1`)

- Trigger: frame creation (`AntaeusFrame.initView`, `AntaeusFrame.as:212`).
- Sender: `AntaeusManager.sendOpenView` (`AntaeusManager.as:75-81`).
- Expected response: `4894` with the full board.

### 3.2 Sign up (`param1 = 2`)

- UI control: `ui.antaeus.btnSign`.
- Sender: `AntaeusFrame.onClickSign` -> confirm `antaeus.campaign.sign` -> `AntaeusManager.sendSign` (`AntaeusFrame.as:433-461`, `AntaeusManager.as:83-89`).
- Client-side checks: own fighting capacity >= `antaeus_sign_power` (10 000 000), else `antaeus.powerNotEnough`; `model.canSign`: fewer than 10 rows or own capacity > 10th row `power` (`decompiled/core_module/scripts/mvc/module/antaeus/AntaeusModel.as:15-31`), else `antaeus.powerLowerThanLast`.
- Expected response: `4894` with the updated board (assumption: the server re-sorts by power and drops the 11th).

The hire action (`param1 = 3`) is documented in [hire.md](hire.md).

## 4. Server messages (server to client)

### `4894 U_C_ANTAEUS_INFO` (0x131e), `AntaeusMsg` (package antaeus)

| Field | Meaning |
|---|---|
| `userId (#1, INT32)` | Player id of the assistant the receiver has hired now, `0` = none (`AntaeusItem.as:88-96`, `:135-140`) |
| `assistantData (#2, STRING)` | Receiver's hire counters per assistant: `"<assistantId>_<hireCount>_<shuttleCount>,..."` (`decompiled/core_module/scripts/mvc/module/antaeus/AntaeusAssistantData.as:34-63`) |
| `assistantList (#3, MESSAGE AntaeusAssistantMsg, repeated)` | Board rows; an empty list keeps the previous rows (`decompiled/core_module/scripts/mvc/module/antaeus/AntaeusData.as:22-35`) |

`AntaeusAssistantMsg`: `userId (#1, INT32)`, `order (#2, INT32)` rank 1..10 (rows sorted numerically by `order`), `power (#3, INT32)` fighting capacity, `assists (#4, INT32)` total times hired, `showData (#5, MESSAGE AssistantDataMsg)`.

`AssistantDataMsg`: `player (#1, AssistantPlayerShowMsg)`, `pet (#2, PetShowMsg)`, `children (#3, ChildrenShowMsg)`, `slaveChild (#4, SlaveChildShowMsg)`, `artifact (#5, ArtifactShowMsg)`, `goddess (#6, GoddessShowMsg)`, `titan (#7, TitanShowMsg)`.

- `AssistantPlayerShowMsg`: `arm (#1, STRING)`, `cloth (#2, STRING)`, `wing (#3, STRING)`, `hat (#4, STRING)`, `hideFashion (#5, BOOL)`, `fashionArm (#6, STRING)`, `fashionCloth (#7, STRING)`, `isDragonTalker (#8, BOOL)`, `job (#9, INT32)`, `nickName (#10, STRING)`, `serverName (#11, STRING)`, `playerUid (#12, STRING)`, `head (#13, INT32)`, `heroTempId (#14, INT32)`: avatar parts (same strings as other avatar messages, [../fashion/README.md](../fashion/README.md)).
- `PetShowMsg`: `templateId (#1, INT32)`, `petCap (#2, INT32)` power ([../einherjar/README.md](../einherjar/README.md)).
- `ChildrenShowMsg`: `templateId (#1, INT32)` job, `childrenCap (#2, INT32)`; `SlaveChildShowMsg`: `templateId (#1, INT32)`, `slaveChildCap (#2, INT32)` ([../guardians/README.md](../guardians/README.md)).
- `ArtifactShowMsg`: `templateId (#1)`, `attack (#2)`, `defences (#3)`, `magicAttack (#4)`, `magicDefences (#5)`, `penetrate (#6)`, `parry (#7)`, `live (#8)`, all `INT32` ([../divine-weapon/README.md](../divine-weapon/README.md)).
- `GoddessShowMsg`: `templateId (#1)`, `attack (#2)`, `defance (#3)`, `magicAttack (#4)`, `magicDefance (#5)`, `live (#6)`, all `INT32` ([../goddess/README.md](../goddess/README.md)).
- `TitanShowMsg`: `templateId (#1)`, `starLevel (#2)` (tens = stars, units = sub level), `reduceResi (#3)`, `fireResi (#4)`, `waterResi (#5)`, `electResi (#6)`, `windResi (#7)`, `darkResi (#8)`, `lightResi (#9)`, all `INT32` ([../dragon/README.md](../dragon/README.md)).

Icons are resolved from templates: pet head icon, child template `getTemplateByJobAndGrades(templateId, 1).Icon`, goddess small icon, artifact and titan template icons (`decompiled/core_module/scripts/mvc/module/antaeus/AntaeusShowData.as:44-78`). Missing companions must still be sent with a valid `templateId` or the icon lookup throws (assumption: send the message only when the companion exists and accept the client error otherwise).

- Receiver: `AntaeusManager.receiveAntaeusInfo` (`AntaeusManager.as:54-68`), registered at `:51`. Frame refresh: `AntaeusFrame.updateInfo` (`AntaeusFrame.as:421-426`). Closing the frame clears the list (`AntaeusManager.clear`, `:101-104`).
- When: response to ops 1, 2, 3; push to a viewer when the board changes (optional).

### `4897 U_C_ANTAEUS_TIPS` (0x1321), simple `PropertyMsg`

- Receiver: `BaseManager.__antaeusTipsHandler` (`decompiled/core_module/scripts/yishi/manager/BaseManager.as:461-484`), registered at `:348`.
- `param1 (#1, INT32)`: `1` -> tip type 59 "meet" (you can become an assistant); `2` -> tip type 58 "battle failure" (hire an assistant). Shown only when `VersionSwitch.ANTAEUS`.
- When: `1` after the player's fighting capacity first exceeds the sign threshold and the 10th place (assumption); `2` after losing a battle in one of the four campaigns of [hire.md](hire.md) (assumption).

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Board size | 10 (`PLAYER_COUNT`, config `antaeus_buff_id` "排行榜数量") | `AntaeusFrame.as:83`, `raw/xml/tempinfos/ConfigInfos.xml` |
| Sign threshold | fighting capacity >= 10 000 000 | `antaeus_sign_power` |
| Sign condition | board not full, or capacity > 10th `power` | `AntaeusModel.as:15-31` |
| Ranking | by `power` desc (assumption, `order` is the rank) | |
| Daily assists of an assistant | 100 (`antaeus_assists_max_count` "每天协助总次数") | ConfigInfos |
| Unlock level | `OpenGradesII.ANTAEUS = 1` (unused) | `decompiled/core_module/scripts/yishi/OpenGradesII.as:252` |

Power refresh: the board stores the power at sign time; assumption: refresh it daily from the hero service and re-sort.

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `raw/xml/tempinfos/ConfigInfos.xml` | `antaeus_sign_power`, `antaeus_buff_id`, `antaeus_money`, `antaeus_assists_max_count` | `ConfigValue` |
| Child, goddess, artifact, titan templates | companion icons | `Icon`, `AvatarPath` (via `TempleteManager`) |

## 7. Persistent state

Schema `assistant`.

```sql
CREATE TABLE assistant.board_entries (
  player_id        BIGINT      PRIMARY KEY REFERENCES player.players(player_id),
  power            BIGINT      NOT NULL CHECK (power >= 0),
  total_assists    INT         NOT NULL DEFAULT 0,
  daily_assists    INT         NOT NULL DEFAULT 0,
  daily_reset_on   DATE        NOT NULL DEFAULT current_date,
  signed_at        TIMESTAMPTZ NOT NULL DEFAULT now(),
  removed_at       TIMESTAMPTZ
);
CREATE INDEX board_entries_rank_idx ON assistant.board_entries (power DESC) WHERE removed_at IS NULL;

CREATE TABLE assistant.tip_log (
  player_id        BIGINT      NOT NULL REFERENCES player.players(player_id),
  tip_kind         SMALLINT    NOT NULL CHECK (tip_kind IN (1, 2)),
  sent_on          DATE        NOT NULL DEFAULT current_date,
  PRIMARY KEY (player_id, tip_kind, sent_on)
);
```

At most 10 rows have `removed_at IS NULL`; enforce in the sign transaction.

## 8. Backend implementation notes

- `assistant::board::handle_open_view` (9682 op 1): build `AntaeusMsg` for the caller: `userId` = active hire ([hire.md](hire.md)), `assistantData` from the caller's hire counters, `assistantList` = top 10 with show data gathered from hero, fashion, einherjar, guardians, goddess, divine weapon and dragon services (cache per assistant for 5 minutes).
- `assistant::board::handle_sign` (9682 op 2): validation order: feature enabled (server flag), capacity >= threshold, not already on the board, board not full or capacity > lowest. Transaction with `SELECT ... FOR UPDATE` on the board: insert, remove the lowest when 11 rows. Reply `4894`.
- `assistant::board::push_tip` (4897): rate limit one per kind per day via `tip_log`.
- Daily reset at 00:00 server time: `daily_assists = 0`.

## 9. Open questions and assumptions

- The feature is disabled in the BR client and deprecated in the config; confirm product intent before implementing.
- Assumption: ranking by power; `order` 1 = strongest.
- Assumption: tip triggers.
- Open: whether assistants from other servers appear (`serverName` is shown, suggesting a cross server board).

## 10. Implementation checklist

- [ ] Server flag to enable the feature (and client patch `VersionSwitch.ANTAEUS`, pt-BR strings)
- [ ] `9682` op 1 and `4894` with show data
- [ ] `9682` op 2 sign-up with board limit
- [ ] `4897` tips
- [ ] Daily reset
- [ ] Tables `assistant.board_entries`, `assistant.tip_log`
- [ ] Test: sign below 10 000 000 rejected
- [ ] Test: eleventh signer with higher power evicts the lowest
