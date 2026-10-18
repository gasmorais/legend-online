# Elf contract ("Contrato dos Elfos")

Module `king-contract` of feature `returning-players`. Messages in protobuf package `player` (`KingContractBuyMsg`, `KingContractMsg`, `KingContractInfoMsg`).

Path aliases:

| Alias | File |
|---|---|
| KCM | `decompiled/core_module/scripts/managers/KingContractManager.as` |
| KCF | `decompiled/m11/scripts/kingcontract/KingContractFrame.as` |
| KCV | `decompiled/m11/scripts/kingcontract/KingContractView.as` |
| KCP | `decompiled/m11/scripts/kingcontract/KingContractPresentFrame.as` |

## 1. Overview

A 31 day convenience service ("Contrato dos Elfos {0} diamantes/mês (Serviço mensal: 31 dias à partir da data de ativação)"). Each contract has an expiry; buying one extends it. All contracts can be bought at once for `All_KingContract` = 338 diamonds, renewed, or gifted to a friend or guild member. Contract 6 lets the player collect a daily 30 min PvE buff ("Deseja coletar o aumento de ganhos?").

| Id | Name | Duration (min) | Price | Effect |
|---|---|---|---|---|
| 2 | Recompensador | 44640 | 90 | bounty quests complete immediately |
| 4 | Deus do Tempo | 44640 | 80 | bot speed up costs no diamonds |
| 6 | BUFF Exclusivo | 44640 | 50 | daily 30 min PvE buff |
| 7 | BUFF Exclusivo | 30 | 50 | +10% attack, defense, magic, resistance, life, infantry in campaigns, multiplayer maps, underground and abyss labyrinths |
| 9 | Mestre de Habilidades | 44640 | 50 | free skill and talent reset |
| 10 | Radar de Monstro | 44640 | 50 | find boss coordinates |
| 11 | Chefão automático | 44640 | 50 | auto walk to the world boss |
| 12 | Mestre dos Ciclos | 44640 | 50 | cycle quests auto accept |
| 15 | Rota automática da Zona Proibida | 44640 | 50 | auto route to the forbidden zone boss |
| 16 | Patrulha do guardião | 44640 | 50 | 10 free guardian patrol refreshes per day |

(`KingContracts.xml`.)

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `KingContractFrame` (KCF) | "Contrato dos Elfos" | contract list, buy all, renew all, fetch buff, gift | `kingcontract` from resource bar (`decompiled/core_module/scripts/ui/resourcebar/view/ResourceExtraView.as:129`), task trace, `NewKingContractView`, offer reward, mop up, farm, monster explore, archaeology, child patrol | per contract "Aberto"/"Fechado" and left time in days/hours/minutes (KCF:260-300) |
| `KingContractView` (KCV) | "Consumir {0} diamantes para utilizar {1} por {2} dias?" | one contract row with buy | KCF | `NeedPoint`, name |
| `KingContractPresentFrame` (KCP) | "Comprar Contrato dos Elfos" | gift to a friend / guild member, name typed twice | `kingcontract` openType 1 (KCF:402) | friend list combo |

## 3. Routes (client to server)

All use C>S 8540 (0x215c) `C_KING_CONTRACT`, `KingContractBuyMsg`: `ids (#1, INT32, repeated)` contract ids, `use (#2, BOOL)` true = fetch buff, `friendId (#3, INT32)` receiver, `friendname (#4, STRING)`.

| Action | Sender | Fields | Client checks |
|---|---|---|---|
| Buy one | `KCM.sendKingContract([id])` (KCM:74-84) from KCV:76-90 | `ids=[id]`, `friendId = self userId`, `friendname = self nick` | `point >= NeedPoint` else recharge |
| Buy or renew all | `KCM.sendKingContract(kingList)` from KCF:360-394, `kingList = [1,2,3,4,5,6,8,9,10]` (KCM:25) | self | confirm "Consumir {0} diamantes para utilizar todos os Buff por {1} dias?" / "...estender..."; `point >= 338` |
| Gift | `KCM.presentKingContract([1..6], friendId or 0, name)` (KCM:96-105) from KCP:246-283 | `friendId` 0 when typed name not in the list | both names non empty and equal; `point >= 338` |
| Fetch daily buff | `KCM.sendKingContractFench()` (KCM:86-94) from KCF:330-360 | `use = true`, `ids = []` | contract 6 active else "Você não habilitou o Contrato dos Elfos, não é possível usar essa função" |

Server: charge diamonds (non bound `point`), extend `end_at = max(now, end_at) + Duration` per id, push 4434 to the owner (and to the receiver if online for gifts, plus a mail, assumption). The ids lists in the client do not match `KingContracts.xml` ids (1, 3, 5, 8 do not exist; 7, 11, 12, 15, 16 are missing); treat "all" as every id in the template table (assumption).

## 4. Server messages (server to client)

### S1. 4434 (0x1152) `U_C_KING_CONTRACTE`, `KingContractMsg`
Receiver KCM:57-72. `kingContractInfos (#1, KingContractInfoMsg, repeated)`: `contractId (#1, INT32)`, `endData (#2, STRING)` "YYYY-MM-DD hh:mm:ss". Only contracts known to the client model are updated. Send at login and after every 8540.

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| All contracts price | 338 diamonds | `All_KingContract` |
| Days for "all" | `Duration(info[2]) / 1440` = 31 | KCF:405-408 |
| Active check | `leftTime > 0` | KCM:107-115 |
| Market note | level 26 | `kingcontract.view.openMarket.fail` |

Consumers call `checkHasBuffById`: 2 (offer reward), 4 (mop up and hook speed up, `decompiled/m5/scripts/mopup/view/LordTrialMopupIngFrame.as:424`, `decompiled/m3/scripts/map/campaign/view/ui/HookTimeView.as:265`), 8 (farm, `decompiled/m3/scripts/farm/view/FarmUILayer.as:217`), 9 (talent and dragon talker reset, `decompiled/m5/scripts/armyII/viewII/talent/TalentView.as:381`), 16 (child patrol, `decompiled/m14/scripts/childpatrol/ChildPatrolTaskView.as:143`).

## 6. Templates

`KingContracts.xml`: `Id`, `Name`, `Description`, `Duration` (minutes), `NeedPoint`, `CanAdd`.

## 7. Persistent state

```sql
CREATE TABLE returning_players.elf_contracts (
  player_id       BIGINT NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  contract_id     SMALLINT NOT NULL,
  ends_at         TIMESTAMPTZ NOT NULL,
  last_fetch_on   DATE,
  PRIMARY KEY (player_id, contract_id)
);

CREATE TABLE returning_players.elf_contract_purchases (
  purchase_id     BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  buyer_id        BIGINT NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  receiver_id     BIGINT NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  contract_ids    SMALLINT[] NOT NULL,
  paid_points     INTEGER NOT NULL,
  created_at      TIMESTAMPTZ NOT NULL DEFAULT now()
);
```

## 8. Backend implementation notes

Handler `returning_players::king_contract::handle_op`: branch on `use` (fetch: contract 6 active, once per day, grant buff 30 min) or purchase (resolve receiver by `friendId` or by `friendname`). Expose `returning_players::king_contract::is_active(player_id, id)` for consumers.

## 9. Open questions and assumptions

- Mismatch between client id lists and template ids; gift price uses 338 regardless of ids.

## 10. Implementation checklist

- [ ] Screens frame, row, present frame
- [ ] Route 8540 buy, buy all, gift, fetch
- [ ] Server message 4434
- [ ] Tables `returning_players.elf_contracts`, `elf_contract_purchases`
- [ ] Consumer API
- [ ] Tests: extension math, fetch once per day, gift by name
