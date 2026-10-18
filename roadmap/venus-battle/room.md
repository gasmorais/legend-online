# Venus battle: fight room, inspiration and matches

Module `venus_battle::room`. Prefixes as in [README.md](README.md).

## 1. Overview

During the fight window each partner presses the join button. The server puts both partners in the same two seat campaign room of type 8 (scene `MATELORDS_ROOM`). The server drives turns (`currentTurn`/`maxTurnCount`, countdown `leftTime` in ms), pairs couple teams present in rooms and starts battle 315 `CROSS_MATELORDS_BATTLE` (2 heroes per side, positions from the team sort frame). After each battle the clients return to the room (`BattleManager.preScene = "MATELORDS_ROOM"`, `CM/managers/RoomManager.as:85-88`) and receive 4798. Inspiration (diamonds) raises attributes for the next battle.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| scene `mvc.controler.MatelordsRoomController` (`MATELORDS_ROOM`) | | hosts `matelordsroom.MatelordsRoomView` | 12 with `roomType == 8` (`CM/yishi/manager/BaseManager.as:2670-2673`; `CM/yishi/scene/SceneCreate.as`) | |
| `matelords.room.MatelordsRoomView` | | composes back, top, right panels; refresh on `INFO_UPDATE` | scene | model (`M9/matelords/room/MatelordsRoomView.as`) |
| `matelords.room.MatelordsRoomBackView` | | two seats (`PLAYER_COUNT = 2`) with the partners from room members 120 | room view | `M9/matelords/room/MatelordsRoomBackView.as:22,138` |
| `matelords.room.MatelordsRoomTopView` | | turn "{n}/{max}", per second countdown from `leftTime`; end title when `currentTurn >= maxTurnCount` | room view | `M9/matelords/room/MatelordsRoomTopView.as:84-102` |
| `matelords.room.MatelordsRoomRightView` | | 4 group tabs listing teams ("Equipe", "Pontos"), "Grupo: {0}", "Pontos: {0}", next group hint, inspiration level digits and button, "Bênção de Pontos: {0}", buttons altar shop and team order | room view | `roomRankList` filtered by `teamType == tab+1` (`M9/matelords/room/MatelordsRoomRightView.as:221-300`) |
| `teammanager.MatelordsSortFrame` | (title `teammanager.pve.TeamSortFrame.title`) | order of the two heroes on the battle grid | team order button -> `teammanager` openType `MATELORDS_SORT_FRAME` (`MatelordsRoomRightView.as:221-225`; `CM/mvc/controler/TeamSortControler.as:38-41`) | see [../team/fight-positions.md](../team/fight-positions.md) (`M5/teammanager/MatelordsSortFrame.as:48-52,304-319`) |

## 3. Routes (client to server)

| # | Action | UI control | Client sender | Client checks | Request | Responses (in order) |
|---|---|---|---|---|---|---|
| M1 | Join the room | main frame `_joinBtn` | `MatelordsFrame.__joinBtnClickHandler` -> `MatelordsManager.matelordsCreateRoom` (`M9/matelords/MatelordsFrame.as:269-279`; `CM/yishi/manager/MatelordsManager.as:339-343`) | 3000 ms throttle only | C to S 8976 (0x2310) `C_MATE_LORDS_ROOM_CREATE`, empty body | 12 `U_C_CAMPAIGN_ROOM_CREATE` (`roomType 8`, capacity 2), 120 room members (self and partner if present), 4798 |
| M2 | Inspire | right panel inspire button | `MatelordsRoomRightView.__inspireBtnClickHandler` -> `inspireCallBack` -> `matelordsInspire` (`MatelordsRoomRightView.as:233-269`; `MatelordsManager.as:354-358`) | `currentTurn >= maxTurnCount` -> `matelordsroom.MatelordsInspireBtn.TipTxt03` "Batalha encerrada, não é necessário efetuar inspiração"; `inspirLevel >= 10` -> `TipTxt02` "Limite de insipiração atingido"; confirmation `TipTxt01` "Deseja consumir {0} diamantes para efetuar inspiração, elevando 10% dos atributos de todos os membros e de einherjar? (O efeito de inspiração será ativo no próximo combate)"; diamonds `point >= Mate_Inspire` (200) else recharge prompt | C to S 8981 (0x2315) `C_MATE_LORDS_INSPIRE`, empty | 4798 with the new `inspirLevel` (to both partners, A), diamond update |
| M3 | Team order | team order button | opens `MatelordsSortFrame` | | team module: `RoomSocketOutManager.sendRequestTeamPos` / `ArmySocketSendManager.sendEditTeamPos` | team module |
| M4 | Altar shop | altar button | openType 3 | | see [altar-shop.md](altar-shop.md) | |
| M5 | Leave | main toolbar exit in `MATELORDS_ROOM` | `MainToolBar` (`CM/ui/maintoolbar/MainToolBar.as:1629-1633`) -> `exitMatelordsRoom` (`:1876-1882`) -> `sendReturnCampaignRoom` | confirmation `ui.maintoolbar.MainToolBar.exitMatelordsRoom` "Deseja sair da Batalha de Vênus?" | 5025 `U_C_CAMPAIGN_ROOM_EXIT` `RoomExitMsg{msg:""}` | 15 `RoomExitRspMsg` |

## 4. Server messages (server to client)

### 4798 (0x12BE) `U_C_MATE_LORDS_INFO`, `MateLordsListMsg`

PTT:669 ("永恒之战房间信息"), missing from `protocol/opcodes.csv`. Receiver `MatelordsManager.__matelordsRoomInfoHandler` (`MatelordsManager.as:67,148-163`): common fields as in 4799 ([signup.md](signup.md)), `info` replaces `roomRankList`, event `INFO_UPDATE`. Fields used in the room: `currentTurn`, `maxTurnCount`, `leftTime` (ms), `teamType`, `totalScore`, `inspirLevel`, `altarScore`, `info` (team rows with `teamType`, `nickName`, `totalScore`, `curreOrder`, `serverName`).

When: after M1, at each turn start, after each battle result (both partners), after M2.

### Room and battle

- 12 / 120 / 15 as in [../ares-battle/room.md](../ares-battle/room.md) section 4 with `roomType = 8`, capacity 2.
- Battle 315: `BattleModel.isMateLords()` (`CM/yishi/datas/BattleModel.as:1045-1048`) shows the hero `trialProps` (the altar skills bought) on the skill bar (`CM/battle/view/ui/SkillItemListView.as:96`); the inspiration icon uses the "+10%/level" tip (`docs/battle/rules.md` type 315).

## 5. Rules and formulas

| # | Rule | Source |
|---|---|---|
| W1 | Room entry requires signed team, open window, still married to the same partner (A: server) | help text item 7 |
| W2 | Both partners enter individually; the team fights only when both are in the room (A); a team with one member present waits | help item 2 |
| W3 | Turn countdown `leftTime` in milliseconds | `MatelordsManager.as:211-214` |
| W4 | Inspiration: max 10 levels (`MatelordsModel.INSPIRE_MAX`), `Mate_Inspire` = 200 diamonds per level, +10% attributes of all members and einherjar, active from the next battle; (A) resets at the end of the fight day | `CM/mvc/module/matelords/MatelordsModel.as:10`; config; LANG |
| W5 | Score per battle: more points for consecutive wins (help item 8: "Quantos mais vezes ganhar consecutivamente, melhor serão os prêmios"); altar multipliers from [altar-shop.md](altar-shop.md) apply. (A) Base values server side | LANG |
| W6 | Blessing points (`altarScore`) are earned after every battle (help item 5) (A: amount by result) | LANG |
| W7 | Pairing (A): same group first, then nearest score; byes give no score | |

## 6. Templates

| File | Record | Fields |
|---|---|---|
| `TPL/ConfigInfos.xml` | `Mate_Inspire` 200, `Mate_Time` | |

## 7. Persistent state

```sql
CREATE TABLE venus_battle.team_day_state (
  team_uid        uuid NOT NULL REFERENCES venus_battle.couple_team(team_uid),
  week_no         smallint NOT NULL,
  inspire_level   smallint NOT NULL DEFAULT 0 CHECK (inspire_level BETWEEN 0 AND 10),
  win_streak      smallint NOT NULL DEFAULT 0,
  pending_win_multiplier  numeric(4,2) NOT NULL DEFAULT 0,   -- "Tesouro de Vitória" stacks
  pending_any_multiplier  numeric(4,2) NOT NULL DEFAULT 0,   -- "Tesouro de Conquista" stacks
  PRIMARY KEY (team_uid, week_no)
);

CREATE TABLE venus_battle.match (
  match_id        bigserial PRIMARY KEY,
  season_id       integer NOT NULL,
  week_no         smallint NOT NULL,
  turn_no         smallint NOT NULL,
  team_a          uuid NOT NULL REFERENCES venus_battle.couple_team(team_uid),
  team_b          uuid REFERENCES venus_battle.couple_team(team_uid),
  winner_team     uuid,
  score_a_delta   integer NOT NULL DEFAULT 0,
  score_b_delta   integer NOT NULL DEFAULT 0,
  altar_a_delta   integer NOT NULL DEFAULT 0,
  altar_b_delta   integer NOT NULL DEFAULT 0,
  battle_id       text,
  fought_at       timestamptz NOT NULL DEFAULT now()
);
CREATE INDEX ON venus_battle.match (season_id, week_no, turn_no);
```

## 8. Backend implementation notes

- `venus_battle::room::handle_create_room` (8976): validate W1; find or create the team room (type 8, capacity 2) keyed by `team_uid`; add the player; send 12 to the player, 120 to both members, 4798 to the player.
- `venus_battle::room::handle_inspire` (8981): validate in room, turn not finished, level < 10, diamonds >= 200; transaction debit and increment; push 4798 to both partners.
- Turn scheduler: at each turn push 4798 (`leftTime` ms) to all room members; pair complete teams; start battle 315 with both partners' heroes and armies (positions from the team order), trial props = altar skills, inspiration as an attribute buff. On result: score with streak and multipliers, altar points, consume multipliers, update `match`, push 4798 to the four players.

## 9. Open questions and assumptions

- (A) Score formula and streak bonus values; altar points per battle.
- (A) Behavior when one partner is offline during a turn.
- (A) Battle map id.

## 10. Implementation checklist

- [ ] 8976 -> 12 + 120 + 4798, two seat room per team
- [ ] 8981 inspiration with limits and diamonds
- [ ] 5025 exit
- [ ] Turn scheduler, pairing, battle 315 with trial props and inspiration buff
- [ ] Tables `team_day_state`, `match`
- [ ] Tests: inspiration at 10, after last turn, insufficient diamonds; partner joins later
