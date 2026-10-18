# Sky realm: duels between players

Area: sky-realm, module `duel`. Covers the "Duelo" invitation between two players standing in the hub: invite, accept, refuse, the popup on the defender side and the battle that follows.

Conventions: see [scene.md](scene.md).

## 1. Overview

In the Reino do Céu a player selects another avatar, opens the target menu and chooses "Duelo". The server forwards the invitation to the target, who sees "{0} lhe enviou convite de duelo, aceitar?" with "Aceitar" / "Recusar" for 10 seconds. On acceptance the server starts a PvP battle between the two heroes. Duels have no cost, no reward and no ranking (assumption: the client shows no reward UI for it).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `TargetSelectView` (`CM/ui/toptoolbar/view/TargetSelectView.as:173-216`) | target bar | Opens the player menu for the selected avatar; the "Duelo" entry is enabled only in `SPACE_SCENE` and not for self (`canShowPkBtn`, `:209-216`) | Clicking an avatar sets `selectTarget` ([players.md](players.md) P3) | target name, level |
| `ChatItemMenu` (`CM/chat/view/ChatItemMenu.as:84-186`) | entry "Duelo" (`yishi.view.PlayerMenu.pk`) | Menu with the duel button (`_showPk` forced false outside `SPACE_SCENE`, `:108-111`) | target bar, chat name click | none |
| `space.SpacePkAlertFrame` (`M3/map/space/view/frame/SpacePkAlertFrame.as`) | "Aviso", text "<font color='#00ff00'>{0}</font> lhe enviou convite de duelo, aceitar?" (`map.hookMap.command01`), buttons "Aceitar" / "Recusar" | Defender confirmation; closes itself after 10 s | `SpacePKMediator.alertMsg` (`M3/map/space/mediator/mapview/SpacePKMediator.as:86-121`) | attacker name |

## 3. Routes (client to server)

| # | UI control | Client sender | Client checks | Route | Request | Expected response |
|---|---|---|---|---|---|---|
| D1 | "Duelo" in the target / chat menu | `ChatItemMenu.__pkBtnClickHandler` (`CM/chat/view/ChatItemMenu.as:527-547`) → `SpaceSocketOutManager.sendMapPkInviteTo(userId)` (`CM/map/space/manager/SpaceSocketOutManager.as:98-108`) | Only in `SPACE_SCENE`; target army must exist in the hub model; target `state` not 2 or 3 (`ArmyState.checkCampaignAttack`), else "Em combate, aguarde..." (`playermenu.command01`) | C>S 9547 0x254b `C_SPACEMAP_ATTACK` | `HangupAttackMsg` (campaign): `op (#5, INT32)` = 1 invite, `attack_id (#1, INT32)` = own userId, `attack_name (#2, STRING)` = own nickname, `defence_id (#3, INT32)` = target userId, `defence_name (#4, INT32)` not set | Push 4421 (op 1) to the defender. No reply to the attacker |
| D2 | "Aceitar" in `SpacePkAlertFrame` (response codes 2, 3) | `SpacePKMediator.receiveThisRequest` (`SpacePKMediator.as:138-143`) → `MapSocketOuterManager.receivePKRequest` (`M3/map/net/MapSocketOuterManager.as:127-135`) | none | C>S 9547 0x254b | `HangupAttackMsg`: `op` = 2 accept, `defence_id` = own userId, `attack_id` = inviter userId | Battle start (157 and the battle protocol) for both players |
| D3 | "Recusar", close, ESC (response codes 0, 1, 4), or automatic refusal when `SharedManager.refuseInvitation` is set | `SpacePKMediator.refuseThisRequest` (`SpacePKMediator.as:145-153`) → `MapSocketOuterManager.refusePKRequest` (`MapSocketOuterManager.as:137-145`) | none | C>S 9547 0x254b | `HangupAttackMsg`: `op` = 3 refuse, `defence_id` = own userId, `attack_id` = inviter userId | None required (the attacker client has no handler for refusals). Optional system tip to the attacker (assumption) |

The 10 s timeout (`SpacePKMediator.as:120`) only closes the popup and keeps the request in the local stack; it does **not** send a refusal. The server must expire invitations itself.

## 4. Server messages (server to client)

| Opcode | Message | Receiver | When | Client reaction |
|---|---|---|---|---|
| S>C 4421 0x1145 `U_C_HANGUP_PVP` | `HangupAttackMsg` (campaign): `attack_id (#1, INT32)`, `attack_name (#2, STRING)`, `defence_id (#3, INT32)`, `defence_name (#4, INT32)`, `op (#5, INT32)` | `SpaceManager.__onPKRequestHandler` (`CM/map/space/SpaceManager.as:154-172`) → event `SPACE_PK` → `SpacePKMediator.__onPKRequestHandler` (`SpacePKMediator.as:46-68`) | Push to the defender after a valid D1 | Dropped silently when the defender is in the guardian arena, has the Palácio da Eclíptica frame open or is matching in the Arena Ilusória (`SpaceManager.as:159-170`), or when not in `SPACE_SCENE`, or during Terralém map apply or the landmine frame (`SpacePKMediator.as:90-105`). With `refuseInvitation` the client answers D3 at once. Only `op == 1` from another player opens the popup; repeated invites from the same attacker replace the older one; popups are shown one at a time with 300 ms spacing |
| Battle start | see [../battle/README.md](../battle/README.md) | | After D2 | Both clients leave the hub for `BATTLE_SCENE`; on exit `BattleResultHandler.exitBattle` returns to `BattleManager.preScene` or `returnScene` (hub) |

## 5. Rules and formulas

| # | Rule | Source |
|---|---|---|
| DU1 | Duels exist only between two players in the hub; the target must not be in combat (army state 2 or 3). | `ChatItemMenu.as:527-547`, `CM/map/internals/constant/ArmyState.as` |
| DU2 | Defender popup lifetime 10 s; one popup at a time; requests queued by attacker id (latest wins). | `SpacePKMediator.as:46-121` |
| DU3 | No level difference, guild or cost check exists in the client (assumption: none on the server either). | client code |
| DU4 | Battle type: no dedicated constant exists (`CM/yishi/datas/battle/BattleType.as`). Do **not** use 19 `HANGUP_PVP` (the campaign map duel sent by 8525), because battleType 19 exits to `CAMPAIGN_MAP_SCENE` (`CM/battle/handler/BattleResultHandler.as:202-209`). Use a PvP type absent from the `exitBattle` switch so the client returns to `returnScene` (the hub). Assumption: battleType 11 `BATTLE_MULTIPLAYER` with both heroes and their armies, no rewards. 11 is also the campaign multiplayer type ([../battle/battle-types.md](../battle/battle-types.md)), so the server must tag duel battles separately from campaign rooms. | `BattleResultHandler.as:93-215` |
| DU5 | During the battle both players are in army state 2; push 140 type 3 so hub viewers show the combat icon ([players.md](players.md)). | `CM/yishi/manager/ArmyManager.as:335-370` |

## 6. Templates

None.

## 7. Persistent state

Pending invitations are short lived; keep them in memory. For audit, an optional log:

```sql
CREATE TABLE sky_realm.duel_log (
    duel_id        BIGSERIAL PRIMARY KEY,
    attacker_id    BIGINT NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
    defender_id    BIGINT NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
    invited_at     TIMESTAMPTZ NOT NULL DEFAULT now(),
    outcome        TEXT NOT NULL CHECK (outcome IN ('accepted','refused','expired','cancelled')),
    battle_id      BIGINT,
    winner_id      BIGINT REFERENCES player.players(player_id),
    CHECK (attacker_id <> defender_id)
);
CREATE INDEX duel_log_attacker_idx ON sky_realm.duel_log (attacker_id, invited_at DESC);
CREATE INDEX duel_log_defender_idx ON sky_realm.duel_log (defender_id, invited_at DESC);
```

## 8. Backend implementation notes

- `sky_realm::duel::handle_attack` (9547): dispatch on `op`.
  - `op = 1` invite: `attack_id` must be the session player; both players present in the hub; neither in army state 2/3 nor in a battle, room or campaign; attacker has no other pending outgoing invite to the same defender. Store `{attacker, defender, expires_at = now + 15 s}` (10 s popup + margin) and push 4421 `{op 1, attack_id, attack_name, defence_id}` to the defender.
  - `op = 2` accept: `defence_id` must be the session player; a non-expired invite `(attack_id → defence_id)` must exist; recheck presence and states. Remove the invite, set both army states to 2, push 140 state to hub viewers, remove both from hub presence (4593 to others) and start the battle (DU4) through the battle engine with both heroes' current formations.
  - `op = 3` refuse: drop the invite if it exists. No reply (optional tip to the attacker).
  - Unknown `op`: ignore.
- Expiry: a timer drops invitations past `expires_at` (no packet).
- Battle end: the battle engine returns both players to the hub through the client's `returnScene`; on the next 8688 / 4606 they reappear (see [scene.md](scene.md)).

## 9. Open questions and assumptions

- DU4 battle type is an assumption; the original value is not visible in the client.
- Whether the attacker received a refusal notice is unknown.
- `defence_name` is declared INT32 in the protocol although it should be a name; it is never set.

## 10. Implementation checklist

- [ ] Screen: target menu "Duelo" only in the hub
- [ ] Route D1 9547 op 1 `sky_realm::duel::handle_attack`
- [ ] Route D2 9547 op 2 accept and battle start
- [ ] Route D3 9547 op 3 refuse
- [ ] Server message 4421 to the defender
- [ ] Rule DU4 battle type that exits to the hub
- [ ] Rule DU5 state broadcast during the duel
- [ ] Invitation expiry timer
- [ ] Table `sky_realm.duel_log` (optional)
- [ ] Test: accept starts a battle and both return to the hub
- [ ] Test: invite to a player in combat is rejected client side and server side
