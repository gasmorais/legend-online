# Divorce and engagement cancellation

Feature `marriage`, module `divorce`. Forced divorce, divorce by agreement, free divorce when the partner is inactive, engagement cancellation, and the children division step.

Conventions and `MarriageOpMsg` layout as in [proposal-and-engagement.md](proposal-and-engagement.md). All requests are C>S 8759 0x2237 `C_marriage_REQUEST`.

## 1. Overview

Divorce starts at the marriage NPC with one of three options, each opening `DivorceAlert` where the player must type "YES":

| NPC option | `DivorceAlert` type | Meaning | Cost | Op |
|---:|---:|---|---|---|
| 92 | 92 | forced divorce (or engagement cancellation when engaged) | `divorce_need` 1200 diamonds (married) / `cancel_engage_need` (engaged) | 8 with `pay_type` 1 |
| 93 | 93 | divorce by agreement, requires a 2 member team with the partner and the captain acting | `marriage_deal_divorce_point` 1000 diamonds | 16, partner answers with 17 |
| 91 | 91 | free divorce when the partner has been offline for 5 days or more | free | 15 |

When the couple has children, the child feature first asks to divide them (`ChildDivideFrame`) and then sends op 8 with the division in `property3` (`property5` true for the agreement path). Some child flows ask the other parent to confirm (op 14). After a divorce both players get 4657 (state 4) and 357 (marriage state 4); the ring is removed, skills and buffs stop, satisfaction is reset (texts below).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `map.space.view.frame.DivorceAlert` `decompiled/m3/scripts/map/space/view/frame/DivorceAlert.as` | titles "Divorciar", "Cancelar Casamento"; "Deseja consumir {0} diamantes para se divorciar de {1}?..." (`text01`), "Você deseja consumir {0} diamantes para cancelar casamento com {1}?..." (`text02`), consequences "Os pontos de perfeição de ambos será zerado.", "Remover anel de casamento", "Não se pode usar habilidades de casamento", "Buff de casamento inválido", "Você está novamente solteiro", "O anel que você está usando foi retirado não será devolvido."; free divorce "Seu parceiro {0} está offline mais de 5 dias, pode terminar o noivado gratuitamente, quer continuar?" / "Seu parceiro {0} está offline há menos de 5 dias, não pode divorciar gratuitamente."; input "Favor inserir [YES] para confirmar." | Confirm a divorce type (`__submitButtonHandler` `:258`), cost from config (`needPoint` `:336`) | NPC options 91, 92, 93 (`decompiled/m3/scripts/map/space/view/frame/DialogOptionItem.as:479` to `:535`); consult mode `[93, true]` on push 358 (`FreedomTeamListView.__showDivorce` `decompiled/m3/scripts/map/internals/view/team/FreedomTeamListView.as:203`) | partner name, cost, partner offline days |
| `child.handin.ChildDivideFrame` `decompiled/m14/scripts/child/handin/ChildDivideFrame.as` | `child.handin.ChildDivideFrame.hasJewel` tip | Divide children before a divorce (blocked when child equipment has jewels) | child controller `divide` (`decompiled/core_module/scripts/managers/ChildManager.as:798`) | children |

## 3. Routes (client to server)

| # | UI control | Client sender | Client checks | Request | Response |
|---|---|---|---|---|---|
| D1 | Forced divorce / cancel engagement (type 92, "YES") | `DivorceAlert.__submitButtonHandler` `DivorceAlert.as:258` then `MarrySender.divorce(1, "", false)` `decompiled/core_module/scripts/mvc/module/marry/MarrySender.as:196` | "YES" typed (empty: `yishi.view.ConfirmSellFrame.inputNull`, wrong: `inputWrong`); not single ("Você no momento não tem parceiro"); diamonds >= cost, else recharge alert | `op_type` = 8, `pay_type` = 1, `property3` = "" (or child division data), `property5` = false | 4657 (state 4 or 2) to both, 357, ring removal (inventory push) |
| D2 | Divorce by agreement (type 93) | `DivorceAlert` then `MarrySender.consultDivorce(partnerId)` `MarrySender.as:282` | married; free team; captain ("Somente o Líder pode fazer o convite das Perguntas" key `onlyForCaptain2`); diamonds >= 1000; "YES" | `op_type` = 16, `property1` = partner id | 358 to the partner |
| D3 | Partner answers (consult mode) | `DivorceAlert` consult mode: "YES" then `MarrySender.agreeDivorce(selfMarryInfo.userId, true)` `MarrySender.as:291`; cancel or close sends `agreeDivorce(id, false)` (`:238`, `:248`) | | `op_type` = 17, `property1` = partner id, `property5` = agree | agree: as D1 for both (cost charged to the requester, Assumption); refuse: notice to the requester (Assumption 111) |
| D4 | Free divorce (type 91) | `DivorceAlert` then `MarrySender.freeDivorce()` `MarrySender.as:273` | partner `logout_days >= 5` (else "Parceiros com mais de 15 dias offline podem divorciar-se gratuitamente." / text14) | `op_type` = 15, `property3` = "" | as D1, no cost |
| D5 | Divorce with children | `ChildDivideFrame` `:269` (type 92) / `:275` (type 93) then `MarrySender.divorce(1, division, consult)` | no jeweled child equipment | `op_type` = 8, `pay_type` = 1, `property3` = child division string, `property5` = true for the agreement path | as D1 |
| D6 | Confirm child step | `ChildManager` `decompiled/core_module/scripts/managers/ChildManager.as:273`, `:305`, `:308`, `:312` then `MarrySender.confirmDivorce(bool)` `MarrySender.as:264` | | `op_type` = 14, `property5` = confirm | as D1 or cancel |
| D7 | Engagement auto cancel | `MarryManager.onCd` `decompiled/core_module/scripts/managers/MarryManager.as:551` (dead code) then `cancleEngaged(14, 1)` | | `op_type` = 14, `pay_type` = 1 | |

## 4. Server messages (server to client)

| Route | Message | Client receiver | When |
|---|---|---|---|
| S>C 358 0x0166 `U_C_MARRIAGE_DEAL_DIVORCE` | no body | `MarryManager.__consultDivorce` `MarryManager.as:114` dispatches `CONSULT_DIVORCE` (team panel opens `DivorceAlert [93, true]`) | to the partner after D2 |
| S>C 4657 `U_C_MARRIAGE_INFO` | `MarriageMsg` with `state` 4 (divorced) or 2 (engagement cancelled) | `MarryManager.__marryInfoHandler` | to both after a divorce |
| S>C 357 `U_C_MARRIAGE_DATA` | `MarriageDataMsg` with `marriage_state` 4 (client drops mate data) | `MarryManager.__marryPersonalDataHandler` | to both |
| S>C 165 `U_CH_FRIEND_UPDATE` | friend group change | friends feature | the ex partner leaves the mate group (client also moves it, `FriendManager.__maryInfoUpdateHandler` `decompiled/core_module/scripts/yishi/manager/FriendManager.as:235`) |

## 5. Rules and formulas

- Costs (`raw/xml/tempinfos/ConfigInfos.xml`): `divorce_need` 1200 diamonds (forced, "【结婚】离婚所需钻石"), `marriage_deal_divorce_point` 1000 diamonds (agreement), `cancel_engage_need` (engaged; key missing in the config file, so the client shows 0; Assumption: free or a fixed value to define).
- Free divorce: partner offline >= 5 days (`DivorceAlert.as:152`, `:171`); the tip text says 15 days (conflict, Open question).
- Consequences (from `DivorceAlert` texts): both satisfaction points reset, ring removed and not returned, marriage skills and buff disabled. "Casando novemente pode-se herdar o nível do anel..." (`marry.view.MarryRingView.Divorce`) indicates the ring level is kept for inheritance on remarriage with per quality ratios (Assumption).
- Children must be divided first (child feature).

## 6. Templates

| File | Keys |
|---|---|
| `raw/xml/tempinfos/ConfigInfos.xml` | `divorce_need`, `marriage_deal_divorce_point`, `cancel_engage_need` (missing) |

## 7. Persistent state

Uses `marriage.marriage` (`state` 4 or 2, `ended_at`) and `marriage.growth` reset ([married-life.md](married-life.md)).

```sql
CREATE TABLE marriage.divorce_request (
    marriage_id    integer     PRIMARY KEY REFERENCES marriage.marriage(marriage_id) ON DELETE CASCADE,
    requester_id   integer     NOT NULL REFERENCES player.players(player_id),
    created_at     timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE marriage.ring_inheritance (
    player_id      integer     PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
    ring_level     smallint    NOT NULL,
    ring_exp       integer     NOT NULL,
    recorded_at    timestamptz NOT NULL DEFAULT now()
);
```

## 8. Backend implementation notes

| Op | Handler |
|---|---|
| 8 | `marriage::divorce::handle_forced` |
| 14 | `marriage::divorce::handle_confirm` |
| 15 | `marriage::divorce::handle_free` |
| 16 | `marriage::divorce::handle_consult` |
| 17 | `marriage::divorce::handle_agree` |

- Common finalize (one transaction): set `state` 4 (married) or 2 (engaged), `ended_at`; remove ring items and marriage buffs (inventory and buff APIs); reset satisfaction; store ring inheritance; close an active wedding room; apply the child division (child feature API). After commit push 4657 and 357 to both (offline partner gets them at login), friend relation group update.
- Forced: debit `divorce_need` (or the engagement cost) from the requester.
- Consult: requester and partner in the same 2 member team, requester captain; debit at agreement time; store `divorce_request`, push 358; expire after 60 s (Assumption).
- Free: check partner last logout >= 5 days.
- Block divorce while a wedding room is active (`MarryModel.canDivorce` `decompiled/core_module/scripts/mvc/module/marry/MarryModel.as:492` requires no room).

## 9. Open questions and assumptions

1. 5 days (code) vs 15 days (tip) for free divorce.
2. `cancel_engage_need` value.
3. Format of the child division string in `property3` (child feature).
4. Who pays in the agreement path.

## 10. Implementation checklist

- [ ] Ops 8, 14, 15, 16, 17 and push 358
- [ ] Finalize transaction (ring, buffs, growth reset, inheritance, room close)
- [ ] Engagement cancellation path (state 2)
- [ ] Child division integration
- [ ] Test: agreement refused leaves the marriage intact
