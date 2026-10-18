# Guild wants: "Caçada da Guilda" (economy module)

Scope: the guild bounty system (`com.road.yishi.proto.consortiawant`): each member hunts a rolled target player (1..5 stars), earns personal and guild score, opens score chests, and competes in a ranking with rewards from `ConsortiaWantDrop.xml`. The battle itself belongs to the battle module (battle type 3890).

Path aliases:

| Alias | File |
|---|---|
| GWM | `decompiled/core_module/scripts/yishi/manager/GuildWantedManager.as` |
| GWF | `decompiled/m6/scripts/consortia/view/wanted/GuildWantedFrame.as` |
| GWC | `decompiled/m6/scripts/consortia/view/wanted/GuildWantedChestItem.as` |
| GWT | `decompiled/m6/scripts/consortia/view/wanted/GuildWantedRewardTipView.as` |
| CIM | `decompiled/core_module/scripts/yishi/datas/ConfigInfoManager.as` |
| CVH | `decompiled/core_module/scripts/mvc/module/consortia/ConsortiaViewHelper.as` |
| PROTO | `decompiled/core_module/scripts/com/road/yishi/proto/consortiawant/` |

## Overview

- Unlocked at guild level 10; the activity tab item id 6 shows "{left}/10" and opens the frame (`CVH:417-444`, `CVH:492-495`).
- 10 hunts per day (`GuildWantedManager.WANTED_COUNT = 10`, `GWM:34`).
- The target has a star level 1..5; defeating it grants score by star (`consortia_want_score = 1,5|2,10|3,20|4,35|5,50`).
- Personal score resets daily at 0:00 ("(Pontuação atualizada diariamente à 0:00)"), guild score every Monday 0:00 ("(Pontuação atualizada todas as segundas à 0:00)").
- 6 personal chests at personal score 50, 100, 200, 300, 400, 500 and 6 guild chests at guild score 5000, 10000, 20000, 30000, 40000, 50000 (`CIM:1396-1412`).
- Changing the target costs 20 diamonds (`CIM:1414-1421`); a free change is available when the cooldown "Atualização gratuita depois" reaches 0.

Entry points: activity tab (above), daily task condition 240 (`decompiled/core_module/scripts/yishi/SwitchPageHelp.as:440-441`), `DayGuideManager` (`decompiled/core_module/scripts/managers/DayGuideManager.as:928`), and automatically after a hunt battle (`decompiled/core_module/scripts/battle/handler/BattleResultHandler.as:274-276` adds `GuildWantedBattleAction`, which reopens the frame in castle or space scene, `decompiled/core_module/scripts/yishi/actions/consortia/GuildWantedBattleAction.as:15-21`). `SwitchPageHelp.openGuildWantedFrame` requires `consortiaID > 0` (`decompiled/core_module/scripts/yishi/SwitchPageHelp.as:1917-1923`). Controller `GuildWantedController` (`decompiled/core_module/scripts/mvc/controler/GuildWantedController.as:14-23`), key `guildwanted`.

## Screens

| Class | pt-BR title | Purpose | Data |
|---|---|---|---|
| `GWF` | "Caçada da Guilda" (`:119`) | Target avatar and name, star bar, reward score, hunts left, my score and guild score bars, chest rows, ranking list, refresh and fight buttons | `GuildWantedModel` (`decompiled/core_module/scripts/mvc/module/guildwanted/GuildWantedModel.as`) via `refreshView` (`GWF:373-390`): "Alvo da caçada: {0}", "Pontuação de prêmio: {0}", "Lançamentos restantes: {0}", "Pontuação acumulada: {0}", "Meu ranking: {0}", "Nível de estrelas do alvo:" |
| `GWC` | | Chest with threshold; claim button visible when score >= threshold and state != 1 (`GWC:82-104`); tooltip lists drops of `site = type`, `para2 = index` (`GWC:106-139`) | |
| `GWT` | "Lista de Prêmio"; ranks "{0}º lugar", "{0}º-{1}º lugares", "Abaixo do {0}º lugar" | Rank reward list from drops with `site = 3` (`GWT:35-90`) | |
| `decompiled/m6/scripts/consortia/view/wanted/GuildWantedRankItem.as` | columns "Rank", "Nome", "Pontuação" | ranking row | `rankInfoList` |

## Actions

All requests: sender `GWM.sendRequest(opType, drawIndex = 0, drawType = 0)` (`GWM:138-146`); route send 8365 (0x20ad) `C_CONSORTIAWANT_CLIENT_OP`; message `ConsortiaWantMsg` (`PROTO/ConsortiaWantMsg.as`): `opType` (#1, INT32), `drawIndex` (#10, INT32), `drawType` (#11, INT32). Reply always 199.

| # | opType | UI and file:line | Client checks | `drawIndex`, `drawType` | Reply |
|---|---|---|---|---|---|
| W1 | 2 = info (`REFRESHTIME`) | `GuildWantedFrame` ctor (`GWF:111`) | none | 0, 0 | 199 with every field |
| W2 | 3 = change target (`REFRESH`) | `__refreshBtnClickHandler` / `refreshStar` (`GWF:301-356`) | once per day a "não alertar hoje" dialog "Deseja consumir {0} diamantes para atualizar o alvo da caçada?" (`GWF:320-350`); diamonds `point` (or `point + giftToken` when the bind option is on) >= 20 else recharge dialog | 0, 1 when bound diamonds may be used else 0 | 199 with new `wantGoal`, `leftFreeRefreshCD`; 3 for diamonds |
| W3 | 4 = open chest (`RECEVIE`) | chest button (`GWC:77-80`) | button only when score >= threshold and state != 1 | index 0..5, type 1 personal / 2 guild | 199 with `receiveState`; 115 items |
| W4 | 5 = hunt (`FIGHT`) | `__fightBtnClickHandler` (`GWF:358-361`) | none client side | 0, 0 | battle start (battle module, type 3890); after the battle 199 with new scores, `leftCount`, next `wantGoal` |

## Server messages

199 (0x00c7) `U_C_CONSORTIA_WANT_RESP`, `ConsortiaWantMsg`, handler `GWM.__updateConsortiaWantMsg` (`GWM:68-136`, listener `GWM:63-66`, registered at login `decompiled/core_module/scripts/yishi/lunch/Yishi.as:521`). Every field is optional; only fields present (`has*`) are applied:
- `personalScore` (#2, INT32) today's personal score.
- `consortiaScore` (#3, INT32) guild score this week.
- `leftCount` (#4, INT32) hunts left today.
- `receiveState` (#5, repeated `ConsortiaWantBoxStateMsg`: `type` (#1, INT32) 1 personal / 2 guild, `index` (#2, INT32) 0..5, `state` (#3, INT32) 1 = already opened). Entries are merged, never cleared, so the server must send all 12 states after a reset.
- `wantGoal` (#6, `ConsortiaWantGoalMsg`: `Id` (#1, INT32) target id, `starLevel` (#2, INT32) 1..5, `score` (#3, INT32) score reward, `nickName` (#4, STRING), `consortiaName` (#5, STRING) target guild, `fashion` (#6, STRING) `|` separated item template ids for wing, hair fashion, body fashion, arms fashion, arms equip, body equip (`GWF:195-224`), `isHiden` (#7, BOOL) hide fashion, `job` (#8, INT32) class template).
- `myRank` (#7, INT32), `totalScore` (#8, INT32) accumulated score of the ranking period.
- `rankInfos` (#9, repeated `ConsortiaWantRankMsg`: `rank` (#1), `score` (#2), `nickName` (#3)); when non empty the list is replaced, ranks are read from 1..N.
- `leftFreeRefreshCD` (#12, INT32) seconds until the free target change.
- Notifies `GUILD_WANTED_INFO_CHANGE` which repaints the frame.

## Rules and formulas

- Star score: 1 -> 5, 2 -> 10, 3 -> 20, 4 -> 35, 5 -> 50 (`consortia_want_score`). Defeating the target adds `wantGoal.score` to personal score, guild score and ranking total (assumption: the same amount to all three).
- Chest thresholds: personal 50, 100, 200, 300, 400, 500; guild 5000..50000 (`consortia_want_personal_box_score`, `consortia_want_consortia_box_score`). Guild chests are claimed per member once per week (assumption: guild score shared, chest state personal).
- Chest rewards (`raw/xml/tempinfos/ConsortiaWantDrop.xml`): `site` 1 personal and `site` 2 guild, `para2` = chest index 0..5, each 208017 "Pedra Bestial" x10, bound.
- Rank rewards (`site` 3): 1st 208017 x50, 2nd x45, 3rd x40, 4th..10th x35, 11th..50th x30, 51st..100th x25, 101st and below x20. The ranking scope and payout moment are not visible (open question).
- Hunts per day: 10; resets 0:00 together with the personal score and personal chests.
- Change target: 20 diamonds (`consortia_want_refresh_cost`), free when `leftFreeRefreshCD = 0` (assumption, the client still checks the diamond balance).
- Guild level >= 10 to take part (`CVH:423`).

## Templates

| File | Record | Fields |
|---|---|---|
| `raw/xml/tempinfos/ConsortiaWantDrop.xml` | `ConsortiaWantDropInfo` -> `CommonDropTempInfo` via `GuildWantedDropTempCate` (`decompiled/core_module/scripts/yishi/datas/templates/cate/GuildWantedDropTempCate.as:21-70`) | `id`, `dropId`, `site` (1 personal chest, 2 guild chest, 3 rank), `para2` (chest index, or rank `N` / `min,max`), `itemId`, `count`, `isBind`, `appearType`, `validDate`, `isShow` |
| `raw/xml/tempinfos/ConfigInfos.xml` | `consortia_want_score`, `consortia_want_personal_box_score`, `consortia_want_consortia_box_score`, `consortia_want_refresh_cost` | |

## Persistent state

```sql
CREATE TABLE guild.member_want_state (
  player_id          BIGINT   PRIMARY KEY REFERENCES public.player(id) ON DELETE CASCADE,
  day                DATE     NOT NULL,
  hunts_left         SMALLINT NOT NULL DEFAULT 10 CHECK (hunts_left BETWEEN 0 AND 10),
  personal_score     INTEGER  NOT NULL DEFAULT 0 CHECK (personal_score >= 0),
  target_player_id   BIGINT   REFERENCES public.player(id) ON DELETE SET NULL,
  target_star        SMALLINT CHECK (target_star BETWEEN 1 AND 5),
  target_score       INTEGER,
  free_refresh_at    TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE guild.member_want_chest (
  player_id  BIGINT   NOT NULL REFERENCES public.player(id) ON DELETE CASCADE,
  chest_type SMALLINT NOT NULL CHECK (chest_type IN (1,2)),
  period_key DATE     NOT NULL,
  chest_index SMALLINT NOT NULL CHECK (chest_index BETWEEN 0 AND 5),
  opened_at  TIMESTAMPTZ NOT NULL DEFAULT now(),
  PRIMARY KEY (player_id, chest_type, period_key, chest_index)
);

CREATE TABLE guild.guild_want_score (
  guild_id   INTEGER  NOT NULL REFERENCES guild.guild(id) ON DELETE CASCADE,
  week_start DATE    NOT NULL,
  score      INTEGER NOT NULL DEFAULT 0 CHECK (score >= 0),
  PRIMARY KEY (guild_id, week_start)
);

CREATE TABLE guild.want_rank_score (
  player_id    BIGINT  NOT NULL REFERENCES public.player(id) ON DELETE CASCADE,
  period_start DATE    NOT NULL,
  guild_id     INTEGER  REFERENCES guild.guild(id) ON DELETE SET NULL,
  total_score  INTEGER NOT NULL DEFAULT 0 CHECK (total_score >= 0),
  reward_paid  BOOLEAN NOT NULL DEFAULT false,
  PRIMARY KEY (player_id, period_start)
);
CREATE INDEX want_rank_score_order_idx ON guild.want_rank_score (period_start, total_score DESC);
```

## Backend implementation notes

- `guild::wants::handle_op` (8365) dispatching on `opType`:
  - `guild::wants::handle_info` (2): guild level >= 10; roll the daily row; ensure a target (roll one if missing); reply 199 with all fields (12 chest states, top ranking, my rank).
  - `guild::wants::handle_refresh` (3): free if `now >= free_refresh_at` (then set a new cooldown) else charge 20 diamonds (bound first when `drawType = 1`); roll a new target and star. Reply 199 (`wantGoal`, `leftFreeRefreshCD`), push 3.
  - `guild::wants::handle_chest` (4): `drawType` 1 or 2, `drawIndex` 0..5, score >= threshold (personal or this week's guild score), not opened in the period. Insert, grant drop rows (`site = drawType`, `para2 = index`). Reply 199 with the chest state, push 115.
  - `guild::wants::handle_fight` (5): `hunts_left > 0`, target present; decrement and start battle 3890 against the target snapshot (battle module). On victory callback `guild::wants::on_battle_won`: add score to personal, guild (all online members get a 199 with `consortiaScore`), ranking; roll the next target; reply 199 to the hunter.
- Daily reset 0:00 (lazy by `day`), weekly reset Monday 0:00 for the guild score and guild chests.
- Ranking payout job `guild::wants::pay_rank_rewards` at the end of the ranking period (assumption: weekly) using `site = 3` ranges, by mail.
- Target selection: assumption, a random player of similar level from another guild with star level weighted; the original rules are server side only.

## Open questions

- How targets are chosen and what the target `Id` refers to (player id or snapshot id).
- Ranking period (daily, weekly) and scope (server wide or per guild); payout delivery.
- Whether the guild chests are per member or one shared claim.
- Whether losing a hunt consumes an attempt.

## Implementation checklist

- [ ] Client screen: GuildWantedFrame with avatar, chests, ranking, refresh countdown
- [ ] Client screen: GuildWantedRewardTipView from drop site 3
- [ ] Tables `guild.member_want_state`, `guild.member_want_chest`, `guild.guild_want_score`, `guild.want_rank_score`
- [ ] Template loader `ConsortiaWantDrop.xml` and the four config keys
- [ ] Handler `guild::wants::handle_op` (8365 -> 199) with ops 2, 3, 4, 5
- [ ] Battle integration type 3890 and `guild::wants::on_battle_won`
- [ ] Guild score push 199 to online members
- [ ] Daily and weekly resets; ranking payout job
- [ ] Daily task condition 240 hook (quest module)
