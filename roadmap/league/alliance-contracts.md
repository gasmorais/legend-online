# Alliance contracts ("Contrato da Aliança")

Aliases: see [README.md](README.md) and [alliance-event.md](alliance-event.md). Extra aliases:

| Alias | File |
|---|---|
| FF | `decompiled/m11/scripts/oldplayerreturn/OldPlayerReturnFindFrame.as` |
| FI | `decompiled/m11/scripts/oldplayerreturn/OldPlayerReturnFindItem.as` |
| CF | `decompiled/m11/scripts/oldplayerreturn/OldPlayerReturnContractFrame.as` |
| AV | `decompiled/m11/scripts/oldplayerreturn/alliance/OldPlayerReturnAllianceView.as` |
| LV | `decompiled/m11/scripts/oldplayerreturn/alliance/OldPlayerReturnLeftView.as` |
| CV | `decompiled/m11/scripts/oldplayerreturn/alliance/OldPlayerReturnContractView.as` |
| HI | `decompiled/m11/scripts/oldplayerreturn/alliance/OldPlayerReturnHeadItem.as` |
| HM | `decompiled/m11/scripts/oldplayerreturn/alliance/OldPlayerReturnHeadMenu.as` |
| BI | `decompiled/m11/scripts/oldplayerreturn/OldPlayerReturnBuffItem.as` |
| PTC | `decompiled/core_module/scripts/yishi/datas/templates/cate/OldPlayerReturnPrivilegeTempCate.as` |

## 1. Overview

Returnees and eternalists search each other, apply, and the receiver approves. An alliance links one returnee and one eternalist. An eternalist can hold up to 3 alliances ("Vaga na Aliança" `{0}/3`, `FI:138`); the returnee view shows one bound partner (`isBinding`) in the large slot and other allies in up to 3 small slots (`LV:176-219`). Each alliance has a contract with a level (1 to 9), EXP accumulated from both sides' alliance tasks, per level rewards (claimed once per level) and privileges (passive bonuses) that depend on the contract level. Either side can terminate; the terminating side cannot form a new alliance for 48 hours and both lose the alliance EXP with that ally.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `OldPlayerReturnAllianceView` (AV) tab "Contrato da Aliança" | sub tabs alliance, oracle tasks, alliance tasks; the last two enabled only with allies (`AV:110-130`) | Contract overview | `OldPlayerReturnFrame` | |
| `OldPlayerReturnLeftView` (LV) | "Minha Aliança" | Ally heads; empty state shows a find button; ban text "Pode formar nova aliança após {0}" | AV | `allyList`, `RevokeDate`; selecting a head sets `selectedAllyId` (`LV:119-134`) |
| `OldPlayerReturnContractView` (CV) | "Ressurgido", "Eternalista", "EXP do Contrato atual:\n{0}", "EXP do Nível do Contrato:", "Minha EXP na Aliança: {0}", "Minha EXP de Oráculo: {0}"; empty text "Detalhes podem ser exibidos após a conclusão da aliança" | Selected contract | AV | `contractLevel`, `contractCurExp / contractNeedExp`, `myContractExp`, `allyContractExp`, `myAllianceExp`, `OracleExp` (`CV:126-168`) |
| `OldPlayerReturnHeadMenu` (HM) | "Adicionar amigo", "Info", "Convidar", "Aplicar para entrar", guild, level, AP, "Rescindir o contrato" | Player menu on an ally head; terminate only when `isBinding` (`HM:100-108`) | click on an ally head (requests simple info, `HI:86-99`) | |
| `oldplayerreturn.OldPlayerReturnFindFrame` (FF), `openType` 3 | "Mensagem", "Buscar Aliado:", columns "Nome do jogador", "Força de Combate", "Vaga na Aliança" | Three tabs: 0 search / recommended, 1 applications to me, 2 my applications (`FF:198-245`) | find button on LV or an empty head (`LV:113-117`, `HI:101-109`), both send op 2 with empty text first | `playerList` (536), `applyList`, `inviteList` (535) |
| `OldPlayerReturnFindItem` (FI) | "Aplicar", "Desfazer", "Aceitar" | Row actions: tab 0 apply when `status == 0`, revoke when `status == 1`; tab 1 accept; tab 2 revoke (`FI:139-151`); "{0}/3" only shown to returnees | FF | `RelationData` |
| `oldplayerreturn.OldPlayerReturnContractFrame` (CF), `openType` 2 | "Poder do Contrato", "Nível do Contrato", tabs "Premiação com Contrato Nv." / "Benefícios com Contrato Nv." | Browse levels 1..9 with arrows; rewards tab claims a level reward; benefits tab lists privileges of that level for the player type | CV button (`CV:121-124`) | `AllianceRewardInfos` type 4, `AlliancePrivileges`, `privilegeProcess` |

## 3. Routes (client to server)

All routes: C>S 9717 (0x25f5) `C_ALLIANCE_REGRESSION_OP`, request `allianceregression.CommonReq` (fields in [alliance-event.md](alliance-event.md)).

### R1. Search allies (op 2)

- UI: search button in FF (`FF:165-169`), tab 0 selection (`FF:189-196`), find buttons (`LV:115`, `HI:107`).
- Sender: `OldPlayerReturnManager.sendSearch(text = "")` (`OPRM:166-173`).
- Fields: `op (#1)` = 2, `stringParam1 (#5, STRING)` = nickname filter, empty = recommendations.
- Response: S1 536.

### R2. Apply (op 3)

- UI: "Aplicar" in a tab 0 row (`FI:96-104`).
- Client checks: none (no ban or capacity check client side).
- Sender: `send(3, playerId)` (`OPRM:156-164`). Fields: `op` = 3, `intParam1 (#2, INT32)` = target player id, `intParam2 (#3)` = 0.
- Response: S2 538 (`userId` = target, `result` != 0 success), then 535 with the new `invites` row; push 535 to the target with the new `applys` row.

### R3. Revoke application (op 4)

- UI: "Desfazer" in tab 0 (status 1) or tab 2 rows (`FI:86-94`).
- Sender: `send(4, playerId)`. Fields: `op` = 4, `intParam1` = target id.
- Response: 535 (and 535 push to the target).

### R4. Approve application (op 5)

- UI: "Aceitar" in tab 1 rows (`FI:106-113`).
- Sender: `sendApprove(playerId, true)` (`OPRM:175-183`). Fields: `op` = 5, `intParam1` = applicant id, `boolParam1 (#7, BOOL)` = true. The client never sends `false` (no refuse button).
- Response: 535 to both sides with the new `allys` row; the pending application rows of the pair are removed.

### R5. Claim contract level reward (op 6)

- UI: receive button in CF rewards tab (`CF:216-219`).
- Client checks: button enabled only when the level flag in `privilegeProcess` is 0 and `index <= level`, where `level` = the selected ally's `contractLevel` for returnees, or `allyMaxLevel` (max over all allies) for eternalists (`CF:268-290`).
- Sender: `send(6, levelIndex)`. Fields: `op` = 6, `intParam1` = contract level 1..9. The ally is not sent (see section 9).
- Response: 535 with updated `privilegeProcess`; item grants (inventory pushes).

### R6. Terminate contract (op 8)

- UI: "Rescindir o contrato" in HM, confirm "Cancelar o contrato com este jogador?\n(Nenhuma nova aliança pode ser formada nas próximas 48h após a rescisão do contrato)" (`HM:156-172`).
- Sender: `send(8, allyUserId)`. Fields: `op` = 8, `intParam1` = ally id.
- Response: 535 to both sides (ally removed, caller `RevokeDate` = now + 48 h).

## 4. Server messages (server to client)

### S1. 536 (0x0218) `U_C_ALLIANCE_SEARCH_ALLY`

`allianceregression.SearchAllyResp`: `players (#1, MESSAGE RelationData, repeated)`. Receiver `__searchAllyHandler` (`OPRM:139-146`) sets `playerList`, refreshes tab 0 (`FF:180-187`).

`RelationData` fields:

| Field | Tag, type | Meaning |
|---|---|---|
| `playerId` | #1 INT32 | player id |
| `nickName` | #2 STRING | name |
| `fightingCapacity` | #3 INT32 | fight power |
| `allianceNum` | #4 INT32 | current alliances of that player (shown "{0}/3" to returnees) |
| `status` | #5 INT32 | in search results: 0 not applied, 1 already applied by me |

Search returns players of the opposite type, participating, not banned, not full, not already allied (assumption: up to 20 rows, recommendations sorted by fight power close to the caller).

### S2. 538 `U_C_ALLIANCE_OP_RESP` and 535 `U_C_ALLIANCE_USER_DATA`

See [alliance-event.md](alliance-event.md). `AllyData` fields (rows of `allys`):

| Field | Tag, type | Meaning |
|---|---|---|
| `player` | #1 SimplePlayerInfoMsg | ally: `userId (#1, INT32)`, `nickName (#2, STRING)`, `isExist (#3, INT32)`, `sexs (#4, INT32)`, `pics (#5, INT32)` head icon, `camp (#6, INT32)` |
| `isBinding` | #2 BOOL | contract partner flag; terminate allowed only when true |
| `myAllianceExp` | #3 INT32 | my alliance EXP with this ally |
| `myContractExp` | #4 INT32 | contract EXP contributed by me |
| `allyContractExp` | #5 INT32 | contract EXP contributed by the ally |
| `contractLevel` | #6 INT32 | 1..9 |
| `contractCurExp` | #7 INT32 | EXP inside the current level |
| `contractNeedExp` | #8 INT32 | EXP needed for the next level |
| `privilegeProcess` | #9 STRING | `\|` separated flags per level, index `level - 1`, 0 unclaimed, 1 claimed |

## 5. Rules and formulas

- Capacity: eternalist up to 3 returnee allies (`{0}/3`); returnee capacity open (assumption: 3, the left view has 3 slots plus the bound slot).
- Ban: `alliance_coolingtime` = 48 hours after terminating, applies to the terminating side only (help item 9). Terminating removes all alliance EXP between the pair.
- Contract EXP: alliance tasks give "EXP da Aliança" ([alliance-tasks.md](alliance-tasks.md)); contract EXP = `myContractExp + allyContractExp` (assumption); level thresholds are not in the client (open, configure `league.alliance_contract_levels`).
- Contract level used for privileges and shop limits (`OPRMOD:177-195`): returnee uses the bound ally's level (default 1); eternalist uses the highest level among allies (default 1).
- Privileges (`OPRMOD:322-352`, `PTC:52-64`): for PrivilegeType 104 to 107 the value is `AlliancePrivileges[PlayerType, PrivilegeType, contractLevel].PrivilegeValue` when the player has at least one ally and the event is open, else 0.

| PrivilegeType | Meaning (PrivilegeDes) | Value at level 1 .. 9 | Consumer |
|---|---|---|---|
| 101 | "Ataque Físico +100, Ataque Mágico +100, Vida +500" up to "+2000 / +2000 / +10000" | buffer templates 15910101 .. 15910109 | hero stats (assumption: buffer applied while allied) |
| 102 | "Atividade Diária +5" .. "+20" | 5 .. 20 | daily activity |
| 103 | "EXP de campanha +10%" .. "+50%" | 10 .. 50 | campaign EXP |
| 104 | "Desafio do Vórtice do Tempo +1x" .. "+4x" | 1 .. 4 | `TimeVortexModel.as:87` |
| 105 | "Compras de Lágrimas da Deusa +3x" (from some level) | 0 .. 3 | `DemonLandModel.as:71`, `DemonLandFrame.as:169`, `AwardView.as:195`, `DemonLandMopupPrepareFrame.as:280` |
| 106 | "Prêmio de Posse do Chefão da Zona Proibida +2x" | 0 .. 2 | `ForbiddenBossFrame.as:387` |
| 107 | "Compra de Movimento na Rua Mítica +4x" (value 2 in the template) | 0 .. 2 | `IncreasinglyRoadFrame.as:247` |

`PrivilegeMode` is 2 for every row (meaning unknown). Rows with `PrivilegeValue == 0` are hidden in the benefits tab (`CF:179`). 126 rows = 2 player types x 7 privilege types x 9 levels.

- Contract level rewards: `AllianceRewardInfos` `RewardType = 4`, `RewardNum` = level 1..9, `NeedCount` = 0, up to 6 `RewardItemN` / `RewardItemNumN` pairs (`CF:256-267`). Example level 1: 2250001 x100, 2260001 x100, 208055 x100.

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `raw/xml/tempinfos/AlliancePrivileges.xml` | privilege per type and level | `Id`, `PlayerType`, `PrivilegeType`, `ContractLevel`, `PrivilegeDes`, `PrivilegeValue`, `PrivilegeMode` |
| `raw/xml/tempinfos/AllianceRewardInfos.xml` | type 4 rows | `RewardType`, `RewardNum`, `RewardItem1..6`, `RewardItemNum1..6` |
| `raw/xml/tempinfos/ConfigInfos.xml` | `alliance_coolingtime` | 48 |

## 7. Persistent state

```sql
CREATE TABLE league.alliance_contracts (
    contract_id     bigserial   PRIMARY KEY,
    event_id        bigint      NOT NULL REFERENCES league.alliance_events(event_id) ON DELETE CASCADE,
    returnee_id     bigint      NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
    eternal_id      bigint      NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
    is_binding      boolean     NOT NULL DEFAULT true,
    returnee_contract_exp integer NOT NULL DEFAULT 0,
    eternal_contract_exp  integer NOT NULL DEFAULT 0,
    returnee_alliance_exp integer NOT NULL DEFAULT 0,
    eternal_alliance_exp  integer NOT NULL DEFAULT 0,
    contract_level  smallint    NOT NULL DEFAULT 1 CHECK (contract_level BETWEEN 1 AND 9),
    created_at      timestamptz NOT NULL DEFAULT now(),
    terminated_at   timestamptz,
    terminated_by   bigint      REFERENCES player.players(player_id),
    CHECK (returnee_id <> eternal_id)
);
CREATE UNIQUE INDEX alliance_contracts_active_pair ON league.alliance_contracts (event_id, returnee_id, eternal_id) WHERE terminated_at IS NULL;
CREATE INDEX alliance_contracts_eternal_idx ON league.alliance_contracts (event_id, eternal_id) WHERE terminated_at IS NULL;

CREATE TABLE league.alliance_applications (
    event_id     bigint      NOT NULL REFERENCES league.alliance_events(event_id) ON DELETE CASCADE,
    applicant_id bigint      NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
    target_id    bigint      NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
    created_at   timestamptz NOT NULL DEFAULT now(),
    PRIMARY KEY (event_id, applicant_id, target_id)
);
CREATE INDEX alliance_applications_target_idx ON league.alliance_applications (event_id, target_id);

CREATE TABLE league.alliance_contract_claims (
    event_id   bigint   NOT NULL REFERENCES league.alliance_events(event_id) ON DELETE CASCADE,
    player_id  bigint   NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
    contract_level smallint NOT NULL CHECK (contract_level BETWEEN 1 AND 9),
    claimed_at timestamptz NOT NULL DEFAULT now(),
    PRIMARY KEY (event_id, player_id, contract_level)
);

CREATE TABLE league.alliance_contract_levels (
    contract_level smallint PRIMARY KEY CHECK (contract_level BETWEEN 1 AND 9),
    need_exp       integer  NOT NULL CHECK (need_exp > 0)
);
```

Claims are per player and level (assumption: since op 6 carries no ally id, a level reward is claimed once per player per event). `privilegeProcess` of every ally row is built from the caller's claims.

## 8. Backend implementation notes

- `league::alliance::handle_search` (op 2): participants of the other type, `status = 1`, not banned, below capacity, not allied with the caller; `status` field = 1 when an application from the caller exists. Reply 536.
- `league::alliance::handle_apply` (op 3): event open, caller not banned (`revoke_until`), types differ, both below capacity, no active contract, no duplicate. Insert application; reply 538 (`result` 1) and 535; push 535 to target. On failure 538 `result` 0.
- `league::alliance::handle_revoke` (op 4): delete the caller's application to the target; reply 535; push 535 to target.
- `league::alliance::handle_approve` (op 5): application from `intParam1` to caller exists, both below capacity, caller not banned. Transaction: insert contract (binding true), delete applications in both directions; reply 535 to both.
- `league::alliance::handle_claim_contract_reward` (op 6): level in 1..9, `level <= effective contract level`, not claimed. Transaction: insert claim, grant `AllianceRewardInfos` type 4 row items (inventory API, full bag goes to mail); reply 535.
- `league::alliance::handle_terminate` (op 8): active contract with `intParam1` and `is_binding`. Transaction: set `terminated_at`, zero the pair's alliance EXP, set caller `revoke_until = now() + 48 h`; reply 535 to both.
- Contract EXP updates come from alliance task completion ([alliance-tasks.md](alliance-tasks.md)); level up loops while `cur_exp >= need_exp` and level < 9.
- Privilege export API for other features: `league::alliance::privilege(player_id, privilege_type) -> i32`; type 101 adds buffer template `PrivilegeValue` to the player buffs while the event is open and the player has an ally (assumption).

## 9. Open questions and assumptions

- Open: contract level EXP thresholds (not in client data).
- Open: returnee ally capacity and the exact meaning of `isBinding` for non bound allies.
- Assumption: op 6 claims are per player and level, not per ally.
- Assumption: `boolParam1 = false` (refuse) is accepted by op 5 even if the client never sends it.

## 10. Implementation checklist

- [ ] Screens AV, LV, CV, HM, FF, FI, CF.
- [ ] Routes 9717 ops 2, 3, 4, 5, 6, 8.
- [ ] Server messages 536, 538, 535 refresh to both sides.
- [ ] Tables `league.alliance_contracts`, `league.alliance_applications`, `league.alliance_contract_claims`, `league.alliance_contract_levels`.
- [ ] Privilege API (types 101 to 107) and the four consumer features.
- [ ] Tests: eternalist with 3 allies cannot accept a fourth; terminate sets a 48 h ban; claim level 3 with contract level 2 rejected.
