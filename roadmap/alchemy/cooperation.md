# Cooperation: shared group formulas, join, invite, open by invite

Module `cooperation` of feature `alchemy`. Covers the "cooperation" list of shared group formulas, joining a step of someone else's formula (op 3), broadcasting an invite (op 4), opening a formula from a chat link (op 8), completion (rewards for all participants) and the 12 hour expiry.

Path aliases:

| Alias | File |
|---|---|
| AM | `decompiled/core_module/scripts/yishi/manager/AlchemicalManager.as` |
| AFI | `decompiled/core_module/scripts/mvc/module/alchemical/AlchemicalMakeFormulaInfo.as` |
| MV | `decompiled/m14/scripts/alchemical/makeview/` |
| CF | `decompiled/core_module/scripts/chat/utils/ChatFormat.as` |
| COV | `decompiled/core_module/scripts/chat/view/ChatOutputViewII.as` |

## 1. Overview

- A shared formula is created when a player does one step of a group formula (`Type` 1) from the notebook ([formulas.md](formulas.md) C2). It has a server id `shareUid`, the formula id, a `startTime`, and one `ChildFormulaMsg` per completed step (step number, player, nickname, catalyst flag).
- Each step must be done by a different player: the client blocks a player that already did a step of this formula ("Você já participou da combinação em grupo, favor aguardar.", `MV/AlchemicalMakeMaterialView.as:171-177`).
- A shared formula lasts `alchemyworkshop_share_outtime` = 12 hours from `startTime` ("Restante: {0}" countdown, then "Expirado", `AFI:127-136`).
- Joining does not require the formula `NeedScore` (`MV/AlchemicalMakeMaterialView.as:283-286`).
- When the last step is done the formula completes: rewards are paid ([formulas.md](formulas.md) section 5) and the formula leaves the lists.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `MV/AlchemicalMakeCooperationView.as` | pager "{0} / {1}" | 4 shared formulas per page | Fabricar right panel tab 1 | `cooperationList` sorted: formulas the player joined first, then by `startTime` (`AM:163-174`, `:29,41-58,213-219`) |
| `MV/AlchemicalMakeCooperationItem.as` | "{categoria}-{Name}", participants, "Passos completados:{0}/{1}", "Restante: {0}", link "Enviar Convite" | one shared formula | CooperationView | `allName`, `childFormulaList.length`/`stepCount`, catalyst icon frame = catalyst count, invite link only when the player joined (`:124-149`) |
| `MV/AlchemicalMakeMaterialView.as` | step buttons "Passos {n}" or "Completado" | materials of the chosen step; catalyst toggle shows the step's flag for completed steps | selection of a cooperation item | `getChildFormulaInfoByIndex(step)` (`:214-258,320-345`) |
| chat line | "{categoria}-{formula name}" link | invite | chat output | `CF:276-279,397-405` |

## 3. Routes (client to server)

### C1. Join a step (op 3 SHARE_PRODUCE)
- UI: select a cooperation item, choose a step, press make (`MV/AlchemicalMakeMaterialView.as:154-179`).
- Client checks: 2 s anti double click; player not yet in the formula (`isSelfJoin`, else "Você já participou da combinação em grupo, favor aguardar."); button enabled only when the step's materials are in storage and the step is not done (`:281-286`); catalyst toggle off when the storage has no catalyst.
- Sender: `AM.sendAlchemicalSharedFormula(shareUid, isAddCatalyst, step)` (`AM:207-216`).
- Route: C>S 9661 (0x25bd) `C_ALCHEMY_WORKSHOP_OP`, `AlchemyWorkshopMsg`: `op (#1)` = 3; `shareUid (#5, INT32)`; `isAddCatalyst (#6, BOOL)`; `childIndex (#7, INT32)` = step 1..4.
- Response to the joiner: 461 `op` 3 with `opResult` (0 ok; 2 SHARE_COMPLETE when this step completed the formula; 5 HAS_COMPLETE when the step or the formula is already done/expired; 3 LACK_ITEM; 1 other), `alchemyItem`, `score`/`cycleScore` and `mine` when rewards were paid, `sharedFormula` (full visible list).
- Pushes: to every other online participant, 461 `op` 3 (assumption: same op so the client replaces the list) with their refreshed `sharedFormula`; on completion also their `score`, `cycleScore`, `alchemyItem`, `mine` and bag pushes.

### C2. Send an invite (op 4 INVITE)
- UI: "Enviar Convite" link on a cooperation item, visible only when the player joined it (`MV/AlchemicalMakeCooperationItem.as:90-97,133`).
- Client checks: none besides visibility.
- Sender: `AM.sendAlchemicalSharedInvite(shareUid)` (`AM:218-225`).
- Route: 9661, `op` = 4, `shareUid (#5)`.
- Server: broadcast a system chat message containing the element `<a t="117" name="{formula Name}" rewardType="{RewardType}" shareUid="{shareUid}"/>` (parsed by the regex `/\<([^>]*)>*/g` and `createSysCellDataByContent`, which handles elements only on channels 2 SYSTEM, 3 INFO, 11 SYS_ALERT, 12 NOTICE; `CF:276-279`). The link text is "{Alchemical.chatInvite.text<rewardType>}-{name}" (`CF:397-405`). Opcode and chat message format owned by [chat](../chat/README.md) (receiver 83 `U_CH_CHANNEL_CHA`).
- Response: 461 `op` 4 `opResult` 0 (only `ALCHEMICAL_SELFINFO_UPGATE` refresh).

### C3. Open by invite (op 8 OPEN_BY_INVITE)
- UI: click on the chat link (`COV:240,258-265`, notification `ALCHEMICAL_INVITE_CLICK`, `userType` holds `shareUid`).
- Sender: `AM.sendAlchemicalSharedByChat(shareUid)` (`AM:227-234`).
- Route: 9661, `op` = 8, `shareUid (#5)`.
- Server: check `vocation_grades > 0` and that the formula is still active; add the player as a viewer so it appears in the list.
- Response: 461 `op` 8, `opResult` 0, `shareUid` (#5) echo, `sharedFormula` including that formula. Client: if `opResult == 0` and the scene is `CASTLE_SCENE` or `SPACE_SCENE`, opens `alchemical` with `{index: 1, formulaInfo}` (Fabricar tab, cooperation list with the formula selected) (`AM:153-159,236-243`). On failure send `opResult` 5 (expired/complete) or 1; the client does nothing.

## 4. Server messages (server to client)

### S1. 461 `U_C_ALCHEMY_WORKSHOP_OP`, field `sharedFormula (#13)`
Receiver `AM:119-152` (definition of the outer message in [core.md](core.md) S1). Only read when `op` is 0, 2, 3 or 8; replaces `cooperationList`, sorts it, reselects the previously selected cooperation formula by `shareUid`, notifies `ALCHEMICAL_FORMULA_UPDATE`.

`SharedFormulaMsg`:

| Field | Tag | Type | Rep | Meaning |
|---|---|---|---|---|
| `shareUid` | #1 | INT32 | no | shared formula id |
| `formulaId` | #2 | INT32 | no | `AlchemyFormulaTemplate.Id` (Type 1) |
| `startTime` | #3 | STRING | no | creation time `YYYY-MM-DD hh:mm:ss`; expiry = start + 12 h |
| `childFormula` | #4 | `ChildFormulaMsg` | yes | completed steps |

`ChildFormulaMsg`:

| Field | Tag | Type | Rep | Meaning |
|---|---|---|---|---|
| `childIndex` | #1 | INT32 | no | step number 1..4 |
| `userId` | #2 | INT32 | no | player id (compared with the own `userId` for `isSelfJoin`) |
| `nickName` | #3 | STRING | no | shown in the participants line |
| `isAddCatalyst` | #4 | BOOL | no | catalyst added in that step (catalyst icon frame = count) |

### S2. System chat message with element `t="117"` (owned by [chat](../chat/README.md))
Attributes: `name` (formula name), `rewardType` (1..6), `shareUid`.

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Steps | `NeedItem.split("|").length` (3 or 4) | `AFI:59-66` |
| One step per player | a player may own at most one `ChildFormulaMsg` of a formula | `AFI:138-148`, `MV/AlchemicalMakeMaterialView.as:171-177` |
| Step uniqueness | each step number done once | `MV/AlchemicalMakeMaterialView.as:285` |
| Expiry | `startTime + 12 h` (`alchemyworkshop_share_outtime`) | `AFI:127-136` |
| Completion | all steps done -> every participant receives the formula `Reward` (items and points); doubling chance by total catalysts (1: 50%, 2: 80%, 3+: 100%) | `ConfigInfos.xml` `alchemyworkshop_double_percent`; assumption on "every participant" |
| Visibility | formulas the player created or joined, plus those opened by invite (op 8) | assumption (client shows whatever the server sends) |
| Category label | `Alchemical.chatInvite.text{RewardType}`: 1 "Equipamento", 2 "Brasão Sagrado", 3 "Arma Divina", 4 "Titã", 5 "Arma Sagrada", 6 "Proteção da Alma" | `language.json` |

## 6. Templates

| File | Fields used |
|---|---|
| `AlchemyFormulaTemplates.xml` | `Type` 1 rows: `NeedItem` steps, `Reward`, `RewardType`, `Name` |
| `ConfigInfos.xml` | `alchemyworkshop_share_outtime` 12, `alchemyworkshop_double_percent` |

## 7. Persistent state

```sql
CREATE TABLE alchemy.shared_formulas (
  share_uid     SERIAL PRIMARY KEY,                     -- INT32 on the wire
  formula_id    INTEGER NOT NULL,
  creator_id    BIGINT NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  started_at    TIMESTAMPTZ NOT NULL DEFAULT now(),
  expires_at    TIMESTAMPTZ NOT NULL,                   -- started_at + 12 h
  completed_at  TIMESTAMPTZ,
  CHECK (expires_at > started_at)
);
CREATE INDEX shared_formulas_active_idx ON alchemy.shared_formulas (expires_at) WHERE completed_at IS NULL;

CREATE TABLE alchemy.shared_formula_steps (
  share_uid       INTEGER NOT NULL REFERENCES alchemy.shared_formulas(share_uid) ON DELETE CASCADE,
  step_index      SMALLINT NOT NULL CHECK (step_index BETWEEN 1 AND 4),
  player_id       BIGINT NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  catalyst_added  BOOLEAN NOT NULL DEFAULT false,
  done_at         TIMESTAMPTZ NOT NULL DEFAULT now(),
  PRIMARY KEY (share_uid, step_index),
  UNIQUE (share_uid, player_id)
);

CREATE TABLE alchemy.shared_formula_viewers (
  share_uid   INTEGER NOT NULL REFERENCES alchemy.shared_formulas(share_uid) ON DELETE CASCADE,
  player_id   BIGINT NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  added_at    TIMESTAMPTZ NOT NULL DEFAULT now(),
  PRIMARY KEY (share_uid, player_id)
);
```

`nickName` is read from the player profile when building `ChildFormulaMsg`.

## 8. Backend implementation notes

| Opcode | Handler |
|---|---|
| 9661 `op` 2 (Type 1) | `alchemy::cooperation::create` (called from `alchemy::formulas::handle_start_group`) |
| 9661 `op` 3 | `alchemy::cooperation::handle_join` |
| 9661 `op` 4 | `alchemy::cooperation::handle_invite` |
| 9661 `op` 8 | `alchemy::cooperation::handle_open_by_invite` |
| timer | `alchemy::cooperation::expire_job` |

- `handle_join` validation order: `vocation_grades > 0` -> formula exists, not completed, `now < expires_at` (else `opResult` 5) -> `childIndex` in 1..stepCount and free (else 5) -> player not already in the formula (else 1) -> step materials and optional catalyst in storage (else 3). Lock the formula row (`SELECT ... FOR UPDATE`) so two players cannot take the same step.
- Transaction: consume materials/catalyst, insert the step, add the player as viewer; if all steps are done set `completed_at`, roll doubling once for the formula (assumption: one roll shared by all participants), pay every participant (bag items, `alchemy::core::add_score`), count quest condition 64 and Funny condition 21 per participant.
- After commit: 461 `op` 3 to the joiner (`opResult` 2 on completion), 461 `op` 3 pushes with fresh `sharedFormula` (and rewards) to the other online participants and online viewers.
- `handle_invite`: player must have a step in the formula and the formula must be active; rate limit (assumption: one invite per formula per 60 s); send the system chat element to the chosen audience (assumption: world channel shown as INFO 3; alternatives guild/friends). Reply 461 `op` 4.
- `expire_job` (every minute, or lazily when building lists): formulas with `expires_at <= now` and not completed are deleted from lists; consumed materials are not refunded (assumption). Push refreshed lists (`op` 0 is not appropriate because it would not reopen anything; use `op` 3 with the list) to online viewers with the frame open (optional).
- `sharedFormula` list builder: active formulas where the player is creator, participant or viewer; order is irrelevant (client sorts).

## 9. Open questions and assumptions

- Assumption: on completion every participant receives the full `Reward`; alternative: only the creator. The help text is not in the client.
- Assumption: the doubling roll uses the total catalyst count of the formula and is shared by all participants.
- Assumption: invites go to the world chat as an INFO (3) system message; the element only renders on channels 2, 3, 11, 12.
- Open: refund of materials for expired formulas (default: none).
- Open: limit of simultaneous shared formulas per creator.
- Open: whether non participants can see formulas without an invite (default: no).

## 10. Implementation checklist

- [ ] Screens (client ready): `AlchemicalMakeCooperationView`, `AlchemicalMakeCooperationItem`, chat link cell type 117.
- [ ] Tables `alchemy.shared_formulas`, `alchemy.shared_formula_steps`, `alchemy.shared_formula_viewers`.
- [ ] Route 9661 op 3 join with step lock, completion and rewards for all participants.
- [ ] Route 9661 op 4 invite broadcast through the chat service.
- [ ] Route 9661 op 8 open by invite (viewer registration, `shareUid` echo).
- [ ] Pushes 461 op 3 to other participants.
- [ ] Expiry job (12 h).
- [ ] Tests: second step by the same player refused; two concurrent joins on the same step, one wins; last step returns `opResult` 2 and pays all participants; expired formula returns 5; op 8 response opens the frame only with `opResult` 0; invite only allowed for participants.
