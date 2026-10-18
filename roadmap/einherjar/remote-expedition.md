# Pet expedition (Expedição de Einherjar)

Path aliases:

| Alias | File |
|---|---|
| RPM | `decompiled/core_module/scripts/managers/RemotePetManager.as` |
| RPMOD | `decompiled/core_module/scripts/mvc/module/remotepet/RemotePetModel.as` |
| RPC | `decompiled/core_module/scripts/mvc/controler/RemotePetController.as` |
| V | `decompiled/m14/scripts/remotepet/` |
| MOP | `decompiled/m5/scripts/mopup/view/` |

## 1. Overview

A daily PvE ladder of 100 checkpoints ("Check point") fought only by pets (battleType 3844, pets as fighters). The player prepares a team of up to 6 own pets plus 1 borrowed friend pet (positions 1..8 in a formation string), chooses expedition skills unlocked by passing checkpoints, then fights checkpoint by checkpoint; 20 "special" (elite) checkpoints can be fought once each. Already cleared checkpoints can be swept ("Expedição automática", bot) with a timer that diamonds accelerate. Daily ranking by highest checkpoint pays rewards at 00:00. Help (`remotepet.helpContent`): "Pode convidar o Einherjar de amigos ... Os Einherjares convidados receberão 20000 ouro ... Os monstros da expedição têm atributos característicos, o efeito dos atributos serão duplicados durante a batalha ... Dicas dos atributos: água-fogo-vento-choque-água (ciclo); luz-trevas (ciclo) ... Todos os dias das 01:00-23:00 poderá participar da expedição, às 00:00 será enviado o prêmio de acordo com o rank de expedição."

Entry: space map NPC dialog option type 101 (`decompiled/m3/scripts/map/space/view/frame/DialogOptionItem.as:646-665`): lord level >= 50 (the message says 60: "Apenas os jogadores com nível 60 ou superior podem participar"), hours 01:00..22:59 ("Neste momento não pode participar do desafio, tempo do desafio é das 01:00-23:00."). First time (`isFirst`) opens the ready frame, otherwise the turn frame. After an expedition battle the scene reopens the frame (`decompiled/core_module/scripts/battle/handler/BattleResultHandler.as:366-369`).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `V/RemotePetReadyFrame.as` | "Expedição de Einherjar" | Team setup: pet list, formation, skills, info; requests data once (`:40-46`) | NPC (first time) via `RPC.startFrameByType(1)` (`RPC:38-41`) | `petListInfo`, `skillString` |
| `V/views/RemotePetListView.as`, `V/views/RemotePetHeadItemView.as`, `V/views/RemotePetHeadSelectView.as`, `V/views/RemotePetFormationView.as`, `V/views/RemotePetFormationItemView.as` | "Paticipar da batalha", "Descansar", "Einherjar dos amigos", "Clique no mouse para trocar Einherjar ou habilidades" | Pick pets and positions | ready frame | |
| `V/views/RemoteSkillView.as`, `V/views/RemoteSkillItemView.as`, `V/views/RemotePetSkillsView.as` | "Fagmento de expedição:", "Essência da expedição:" | Choose expedition skills | ready frame | `skills` |
| `V/views/RemotePetInfoView.as` | "Por favor configure Einherjar para batalha" | Start button with confirm "Não pode adicionar ou remover Einherjar após iniciar a expedição, tem certeza que está preparado?" (`:120-136`) | ready frame | |
| `V/RemotePetFriendFrame.as`, `V/views/RemotePetFriendView.as`, `V/views/RemotePetFriendItemView.as` | "Escolher Einherjar do amigo" | Friend pet list and choose; confirm "Você tem certeza que deseka escolher o Einherjar "{0}" de"{1}"? (poder: {2}, depois de escolher não poderá mais mudar)." | ready frame | 4965 |
| `V/RemotePetTurnFrame.as`, `V/views/RemotePetTurnUpView.as`, `V/views/RemotePetTurnDownView.as`, `V/views/RemotePetTurnInfoItemView.as`, `V/views/RemotePetTurnSingleItemView.as` | "Check point atual:", "Histórico de Checkpoint:", "Itens obtidos hoje:" | Checkpoint map, fight current or special, tips "Primeiro prêmio", "Drop aleatório", "Desbloquear habilidades de expedição "{0}"" | NPC via `RPC.startFrameByType(2)` | `nowIndex`, `MaxIndex`, `specialIndex`, `items` |
| `V/RemotePetOrderFrame.as`, `V/views/RemotePetOrderItemView.as` | "Rank de expedição (Acumulação {0}:00)." | Daily ranking | turn frame | HTTP `{TPL}remotepet.xml` (`RPC.loadRemotePetOrderData`, `routes/routes.md`) |
| `V/views/RemotePetGoodsFrame.as` | | Items gained today | turn frame | `items` |
| `MOP/RemoteMopupPrepareFrame.as`, `MOP/RemoteMopupIngFrame.as` | "Expedição automática", "Bot  piso {0}" | Sweep setup and progress (mopup feature UI) | turn frame when current < max sweep checkpoint (`V/views/RemotePetTurnInfoItemView.as:199-206`, `mopup` openType 5) | `sweepIndex`, 4967 type 2 |

## 3. Routes (client to server)

Main route: send 9544 (0x2548) `C_REMOTE_PET_OP`, `RemotePetOpMsg` (package remotepet): `op` (#1, INT32), `pets` (#2, PetSiteMsg, repeated: `site` #1, `petId` #2, `skills` #3 STRING), `pos` (#3, STRING), `friendId` (#4), `friendPetId` (#5), `skillId` (#6), `index` (#7), `isSpecial` (#8, BOOL), `sweepIndex` (#9), `isFirst` (#10, BOOL), `payType` (#11).

| op | UI | Sender | Fields | Expected response |
|---:|---|---|---|---|
| 1 | Ready frame first open | `RPM.sendRemotePetInfo` (`RPM` line 24-30) | none | 4964 |
| 2 | Save team / start expedition (`V/views/RemotePetInfoView.as:134` with `isFirst` true; `V/RemotePetReadyFrame.as:142` on close) | `RPM.saveRemotePetInfo(isFirst)` | `pos` = 8 entries "-1,-1,..." default; `pets` = one `PetSiteMsg` per occupied site (site 7 = friend pet) with `remote_pet_skill_indexs`; `isFirst` | 4964 (pets `isRemote` in 4540) |
| 5 | Choose an expedition skill (`V/views/RemoteSkillItemView.as:135`; also used by guardian PvE `decompiled/m14/scripts/childpve/ChildPveSkillItemView.as:109`) | `RPM.sendUpdateSkill(skillId)` | `skillId` | 4964 `skills` |
| 6 | Fight a checkpoint (`V/views/RemotePetTurnInfoItemView.as:190-209`, `V/views/RemotePetTurnDownView.as:95`, `MOP/RemoteMopupPrepareFrame.as:158`) | `RPM.sendFight(index, isSpecial)` | `index` = checkpoint, `isSpecial` | battle 3844, then 4964 |
| 7 | Start sweep (`MOP/RemoteMopupPrepareFrame.as:198`) | `RPM.sendMopup(n)` | `sweepIndex` = target checkpoint | 4964, then 4967 type 2 per floor |
| 8 | Accelerate sweep (`MOP/RemoteMopupIngFrame.as:340-385`), free with king contract buff 4 | `RPM.sendMopupOP(8, payType)` | `payType` 0 bound allowed / 1 diamonds only; cost = remaining minutes (`mopup.view.MazeMopupIngFrame.AccelerateTip`) | 4967 type 2 results, 4964 |
| 9 | Close sweep (`MOP/RemoteMopupIngFrame.as:552`) | `RPM.sendMopupOP(9, 0)` | none | 4964 |
| 10 | Sweep timer end (`MOP/RemoteMopupIngFrame.as:397-400`) | `RPM.sendMopupOP(10, 0)` | none | 4967 type 2, 4964 |
| 11 | Claim daily rank reward (top bar `renotereward`, `decompiled/core_module/scripts/ui/toptoolbar/TopToolsBar.as:1026-1031`) | inline | none | 4967 type 1 notice, 115 |

Client checks for op 6 (`V/views/RemotePetTurnInfoItemView.as`): only the current checkpoint or a special one with index <= max; 1 s throttle; "Checkpoint já passado hoje, desafie outros check points.", "Não é possível pular o desafio, passe pelo Checkpoint primeiro.", "Checkpoint especial passado, deafie outros check points.". Normal checkpoints below the max sweep checkpoint redirect to the sweep frame.

Friend pets: send 15057 (0x3ad1) `CH_REMOTE_FRIEND_PET`, `RemoteFriendPetOpMsg`: `op` (#1) 1 = list (`V/RemotePetFriendFrame.as:38`), 2 = choose (`:105`) with `friendId` (#2) and `petId` (#3). Responses 4965 / 4966.

Battle skill: send 14001 (0x36b1) `B_REMOTE_PET_ORDER`, `UseSkillMsg`: `battle_id` (#1), `skill_id` (#3) (`decompiled/core_module/scripts/yishi/service/managers/SocketSendManager.as:278-285`).

## 4. Server messages (server to client)

### S1. 4964 (0x1364) `U_C_REMOTE_PET_MSG`
- `RemotePetMsg`: `userId` (#1); `nowIndex` (#2) current checkpoint minus 1 (client shows `nowIndex + 1`); `MaxIndex` (#3) best checkpoint; `order` (#4) rank; `skills` (#5, STRING) chosen expedition skills; `items` (#6, STRING) items gained today; `sweepTime` (#7, STRING); `specialIndex` (#8, STRING) cleared specials; `pos` (#9, STRING) formation; `pets` (#10, STRING) "site,petId|..." (sites 4, 5, 6 are skipped by the client); `sweepIndex` (#11); `isFirst` (#12, BOOL) team not yet set; `fight` (#13) expedition power; `lastOrder` (#14) yesterday rank; `isGet` (#15, BOOL) rank reward claimed; `resetTime` (#16, STRING).
- Receiver: `RPM.__remotePetHandler`.

### S2. 4965 (0x1365) `U_CH_REMOTE_FRIEND_PETLIST`
- `RemoteFriendPetMsg.pets` (#1, FriendPetMsg, repeated): `friendId` (#1), `petId` (#2), `petFight` (#3), `petQuality` (#4), `petType` (#5), `petName` (#6, STRING), `friendName` (#7, STRING).
- Receiver: `RPM.__friendListHandler`.

### S3. 4966 (0x1366) `U_C_REMOTE_FRIEND_PETINFO`
- `PetInfoMsg` of the chosen friend pet (fields in [pets.md](pets.md)); client puts it at site 7.
- Receiver: `RPM.__friendPetInfoHandler`.

### S4. 4967 (0x1367) `U_C_REMOTE_REWARLD`
- `RemoteItemMsg`: `type` (#1) 1 = rank reward notice ("Parabéns, você atingiu o rank {0} na expedição de Einherjar, obterá {1} X{2}", `TopToolsBar.as:1765-1781`), 2 = sweep floor result; `count` (#2) rank or floor; `items` (#3, STRING) "templateId,count|...".
- Receivers: `RPM.__rewarldHandler` (type 2), `TopToolsBar` (type 1).

### S5. 4540 `U_C_PLAYER_PETINFO`
Expedition pet fields `remote_pet_skill_indexs` (#52), `remoteHp` (#53), `isRemote` (#54) ([pets.md](pets.md)).

## 5. Rules and formulas

- `RemotePetTempInfos.xml` (120 rows): `Index` 1..100 normal (`Type` 1, `SweepIndex` = sweepable target after clearing), 20 specials (`Type` 2, for example 4 "[Fogo Elite]  Keruisite", 9 "[Vento Elite] Paley", 14 "[Luz Elite] Sith"); `Property` element (1 Fogo, 2 Água, 3 Eletricidade, 4 Vento, 6 Luz, ...); `Skill` expedition skill unlocked when cleared; `FirstDropItems` and `DropItems` "templateId|count,..." (checkpoint 1: first 208023 x10, 2131200 x5, 2131101 x25; repeat 208023 x2, 2131200 x1, 2131101 x5).
- Element counters double damage (help text): água > fogo > vento > choque > água; luz <-> trevas.
- Opening hours 01:00..23:00; ranking accumulates and pays at 00:00; daily reset of `nowIndex` (checkpoints "passado hoje").
- Pets in the expedition team cannot be sacrificed, absorbed, refined or sold ("pet.inRemotePet*").
- Borrowed friend pet: fixed choice for the day; the friend receives 20000 gold.
- Sweep: up to `SweepIndex` of the best checkpoint; one floor per time unit (assumption), accelerate with diamonds = remaining minutes; offline sweep allowed.

## 6. Templates

| File | Use |
|---|---|
| `raw/xml/tempinfos/RemotePetTempInfos.xml` | `Index`, `Type`, `SweepIndex`, `Icon`, `Icon2`, `Name`, `Fight`, `Property`, `Skill`, `FirstDropItems`, `DropItems` |
| `{TPL}remotepet.xml` | daily ranking file |

## 7. Persistent state

```sql
CREATE TABLE einherjar.expedition_state (
  player_id        BIGINT      PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
  is_first         BOOLEAN     NOT NULL DEFAULT true,
  formation        TEXT        NOT NULL DEFAULT '-1,-1,-1,-1,-1,-1,-1,-1',
  skills           TEXT        NOT NULL DEFAULT '',
  now_index        SMALLINT    NOT NULL DEFAULT 0,
  max_index        SMALLINT    NOT NULL DEFAULT 0,
  special_cleared  TEXT        NOT NULL DEFAULT '',
  items_today      TEXT        NOT NULL DEFAULT '',
  sweep_index      SMALLINT    NOT NULL DEFAULT 0,
  sweep_until      TIMESTAMPTZ,
  fight_power      INTEGER     NOT NULL DEFAULT 0,
  rank_today       INTEGER,
  rank_yesterday   INTEGER,
  reward_claimed   BOOLEAN     NOT NULL DEFAULT true,
  friend_id        BIGINT,
  friend_pet_id    BIGINT,
  reset_at         TIMESTAMPTZ
);

CREATE TABLE einherjar.expedition_pets (
  player_id  BIGINT   NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  site       SMALLINT NOT NULL CHECK (site BETWEEN 1 AND 8),
  pet_id     BIGINT   NOT NULL,
  is_friend  BOOLEAN  NOT NULL DEFAULT false,
  skills     TEXT     NOT NULL DEFAULT '',
  remote_hp  INTEGER,
  PRIMARY KEY (player_id, site)
);
```

## 8. Backend implementation notes

- `einherjar::remote_expedition::handle_op` (9544) by `op`: 1 info; 2 save team (lock team after `isFirst`); 5 skill; 6 fight -> create battle 3844 with team pets (HP persisted in `remote_hp`) vs checkpoint monsters, first clear drops `FirstDropItems`, later `DropItems`; 7/8/9/10 sweep lifecycle; 11 claim rank reward.
- `einherjar::remote_expedition::handle_friend` (15057): op 1 list friends' best pets (friends feature); op 2 bind the friend pet for the day, pay the friend 20000 gold (mail or direct, assumption) -> 4966.
- Schedules: 00:00 compute ranks by `max_index` (ties by power), set `reward_claimed = false`, push 4967 type 1 notice; daily reset of `now_index`, specials, items; regenerate `remotepet.xml`.
- Reject ops outside 01:00..23:00.

## 9. Open questions and assumptions

- Ops 3 and 4 are not sent by this client (maybe reset or friend related).
- Daily reward table per rank (not in client data).
- Sweep speed per floor and diamond price formula.
- Level requirement 50 (code) vs 60 (message).

## 10. Implementation checklist

- [ ] Screen: ready frame, turn frame, friend frame, rank frame, sweep frames
- [ ] Route 9544 ops 1, 2, 5, 6, 7, 8, 9, 10, 11
- [ ] Route 15057 ops 1, 2
- [ ] Route 14001 battle skill
- [ ] Server messages 4964, 4965, 4966, 4967
- [ ] HTTP `remotepet.xml`
- [ ] Tables `einherjar.expedition_state`, `einherjar.expedition_pets`
- [ ] Schedules: daily reset and rank rewards
- [ ] Tests: hours window, skip prevention, special once per day
