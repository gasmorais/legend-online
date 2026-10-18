# Old backer ("Regresso dos Jogadores Antigos")

Module `old-backer` of feature `returning-players`. Protobuf package `oldbacker`.

Path aliases:

| Alias | File |
|---|---|
| OBM | `decompiled/core_module/scripts/managers/OldBackerManager.as` |
| OBF | `decompiled/m11/scripts/oldbacker/OldBackerFrame.as` |
| OBN | `decompiled/m11/scripts/oldbacker/OldBackerNewFrame.as` |
| OBV | `decompiled/m11/scripts/oldbacker/view/OldBackerMsgView.as` |
| OBR | `decompiled/m11/scripts/oldbacker/item/OldBackerRewardItem.as` |

## 1. Overview

An inactive player is offered two choices ("poderá escolher continuar a jogar neste servidor ou migrar para um servidor novo"):

- Stay (`backerType = 1`): collect the buff "Prerrogativa Real" and a reward list (login days, level, points).
- Migrate (`backerType = 2`): generate a one time migration code ("código de migração"). A new character on a new server enters the code; it inherits the old character's recharge value and receives rewards proportional to it ("receber uma compensação correspondente ao valor recarregado do personagem antigo"). The code is validated against an external service (`OldBacker_Url` = `http://gm-sq-hw-server.7road-inc.com:9094`).

`OldBackerFrame` is the old character view, `OldBackerNewFrame` "Novo Personagem da Migração" the new character view.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `OldBackerFrame` (OBF) | "Regresso dos Jogadores Antigos" | choice, rewards, code | toolbar `regress`, `oldbacker` openType 1 when `backerType == 1` | "Encerramento do evento: {0}", intro texts `viewText01..14` |
| `OldBackerNewFrame` (OBN) | "Novo Personagem da Migração" | enter code, see inherited value, rewards | `oldbacker` openType 2 | "Valor recarregado:{0}" (`chargeTotalCount`) |
| `OldBackerMsgView` (OBV) | | view states 1..7 with buttons 01..07 | both frames | |
| `OldBackerRewardItem` (OBR) | | reward row | reward list | items with count `ceil(count * chargeTotalCount / 100)` for `rewardTypes == 0` (OBR:120-140), state 0/1/2 (OBR:89-105) |

## 3. Routes (client to server)

All use C>S 9666 (0x25c2) `C_BACKER_OP`, `OldBackerMsg`, sender `OBM.sendInfo(op, templateId, signKey, backerType)` (OBM:70-79). Request fields: `op (#1, INT32)`, `templateId (#6, INT32)`, `signKey (#7, STRING)`, `backerType (#4, INT32)`.

| op | Constant | UI | Call site | Client checks | Server effect |
|---|---|---|---|---|---|
| 0 | info | frame open | OBF:50, OBN:50 | | push 4843 |
| 1, backerType 1 | `OP_SELECT` stay | button 01 when no list yet | OBV:139-145, 198-206 | | set stay choice, build reward list, push 4843 |
| 1, backerType 2 | `OP_SELECT` get migration code | buttons 04/07 + confirm "Coletar o Código de Migração" | OBV:159-161, 207-211 | | generate `signKey` once, store recharge snapshot, push 4843 |
| 2, signKey | `OP_SIGNKEY` use migration code | button 06 + confirm "Utilização do Código de Migração" | OBV:165-167, 212-215 | | validate code (external service), bind to this character, set `chargeTotalCount`, `isUseSignKey`, push 4843 |
| 3, templateId | `OP_TAKEREWARD` | reward button | OBR:148-156 | `rewardTypes == 0` requires `chargeTotalCount > 0` (`OldBackerRewardItem.charge.alertContent`) | grant, push 4843 |
| 4 | `OP_REWARDBUFF` | button 03 | OBV:156-158 | | grant buff "Prerrogativa Real", `isTakeBuffer = true`, push 4843 |

## 4. Server messages (server to client)

### S1. 4843 (0x12eb) `U_C_OLCBACKER_INFO`, `OldBackerMsg`
Receiver `OBM.__oldbackerInfoHandler` (OBM:86-130).

| Field | Tag | Type | Meaning |
|---|---|---|---|
| `op` | #1 | INT32 | echo |
| `openTime`, `stopTime` | #2, #3 | STRING | event window |
| `backerType` | #4 | INT32 | 1 old character (stay path), 2 new character (migration path) |
| `info` | #5 | `OldBackerInfoMsg`, repeated | reward rows |
| `templateId` | #6 | INT32 | unused |
| `signKey` | #7 | STRING | migration code (empty if none) |
| `activeState` | #8 | INT32 | unused |
| `openState` | #9 | INT32 | 1 shows the toolbar button (`REFRESH_OLDBACKER_SHOW`) |
| `isUseSignKey` | #10 | BOOL | code already used |
| `isTakeBuffer` | #11 | BOOL | buff collected |
| `chargeTotalCount` | #12 | INT32 | recharge value inherited / snapshot |
| `isOpenNewSvr` | #13 | BOOL | a new server exists for migration |
| `needGrades` | #14 | INT32 | level requirement |

`OldBackerInfoMsg`: `templateId (#1, INT32)`, `templateName (#2, STRING)`, `rewardTypes (#3, INT32)` 0 = scaled by recharge percent, `rewardLevel (#4, INT32)`, `needPoints (#5, INT32)`, `needGrades (#6, INT32)`, `needLoginDay (#7, INT32)`, `needCounts (#8, INT32)`, `rewardItems (#9, OldBackerItemMsg, repeated)` with `item_temp_id (#1, INT32)`, `count (#2, INT32)`, `param1 (#3, STRING)`, `param2 (#4, STRING)`, `description (#10, STRING)`, `rewardState (#11, INT32)` 0/1/2.

Send at login (only to eligible players) and after each 9666.

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Toolbar | level >= 6 and `openState == 1` | `TopBtnCheckShowHelper.as:291-292` |
| One code per character, single use | yes | `oldback.OldBackFrame.viewText04`, `viewText05` |
| Recharge scaled rewards | `ceil(count * chargeTotalCount / 100)` | OBR:129 |

## 6. Templates

No XML; reward rows come from the server. `ConfigInfos.xml` `OldBacker_Url`.

## 7. Persistent state

```sql
CREATE TABLE returning_players.backers (
  player_id       BIGINT PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
  backer_type     SMALLINT NOT NULL CHECK (backer_type IN (1, 2)),
  opens_at        TIMESTAMPTZ NOT NULL,
  closes_at       TIMESTAMPTZ NOT NULL,
  took_buff       BOOLEAN NOT NULL DEFAULT false,
  charge_total    INTEGER NOT NULL DEFAULT 0
);

CREATE TABLE returning_players.migration_codes (
  sign_key        TEXT PRIMARY KEY,
  source_server   TEXT NOT NULL,
  source_player   BIGINT NOT NULL,
  charge_total    INTEGER NOT NULL,
  used_by_server  TEXT,
  used_by_player  BIGINT,
  created_at      TIMESTAMPTZ NOT NULL DEFAULT now(),
  used_at         TIMESTAMPTZ,
  UNIQUE (source_server, source_player)
);

CREATE TABLE returning_players.backer_rewards (
  player_id       BIGINT NOT NULL REFERENCES returning_players.backers(player_id) ON DELETE CASCADE,
  template_id     INTEGER NOT NULL,
  reward_state    SMALLINT NOT NULL DEFAULT 0 CHECK (reward_state BETWEEN 0 AND 2),
  PRIMARY KEY (player_id, template_id)
);
```

`migration_codes` must live in a store shared by all servers (the original used the external URL).

## 8. Backend implementation notes

Handler `returning_players::old_backer::handle_op` (switch on op 0..4). Code use is a cross-server transaction: mark used atomically (`UPDATE ... WHERE used_at IS NULL`).

## 9. Open questions and assumptions

- Reward row definitions and the buff effects ("Desconto de 50% p..." in `viewText03`) are server data.
- Meaning of `activeState`, `rewardLevel`.

## 10. Implementation checklist

- [ ] Screens old and new frames
- [ ] Route 9666 ops 0..4
- [ ] Server message 4843
- [ ] Tables `returning_players.backers`, `migration_codes`, `backer_rewards`
- [ ] Cross-server code validation
- [ ] Tests: single use code, scaled rewards
