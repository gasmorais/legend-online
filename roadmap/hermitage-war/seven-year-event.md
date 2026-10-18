# 7th anniversary hub ("周年庆", `sevenyear`)

Module `hermitage_war::seven_year`. Citation prefixes: see [README.md](README.md); `SYM` = `CM/managers/SevenYearManager.as`.

The registry assigns the client package `sevenyear` to this feature, while its protobuf package `com.road.yishi.proto.active.anniversary` belongs to [seasonal-events](../seasonal-events/README.md). This file maps the whole hub so the owner of either feature can implement it; the auto-chess, glory and star-area tabs are only entry points here.

## 1. Overview

A 4-week anniversary event (`seven_year_start_date` 2020-05-11 to `seven_year_stop_date` 2020-06-08) built as a battle pass:

- "Bandeira de Guerra" (war flag) has a level; every 1000 "Pontos de guerreiro" give 1 level (`seven_year_grade_score`). Points come from the daily mini game (200, `seven_year_game_score`), the quiz, achievements, auto-chess placement ([auto-chess](../auto-chess/README.md)) and the snow battle ([artillery/snow-battle.md](../artillery/snow-battle.md)).
- Two reward tracks per level: free (`SevenYearFreeRewardDrop`, dropId 184000+level) and paid "Glória" (`SevenYearRewardDrop`, dropId 191000+level) unlocked by buying the flag (`hasBuy`).
- Players can buy levels with diamonds, buy or gift the flag, claim achievements, answer a quiz while waiting for a match, see the flag-level ranking, buy anniversary shop items and open collection boxes.

## 2. Screens

| Class | pt-BR title | Purpose | Data |
|---|---|---|---|
| `sevenyear.SevenYearMainFrame` (950x735; `sevenyear`, `CM/mvc/controler/SevenYearController.as`) | (art title) "Duração do evento: {0} a {1}" | Tabs: Bandeira de Batalha (0), Área Estelar (1), Supremacia da Glória (2), Loja, Conquistas (`M11/sevenyear/SevenYearMainFrame.as:56-140`) | 4986, 4987 |
| `view.SevenYearBattleFlagView` | | Grade card, auto-chess card (style `selfchessView`, class `SevenYearSelfChessView`), daily game card, rank card, quiz card (visible while matching), reward track (`M11/sevenyear/view/SevenYearBattleFlagView.as:43-60`) | |
| `battleflag.SevenYearGradeView` | | Flag level, "1000 pontos de guerreiro = 1 nível", progress `flagScore/1000`, buttons "Comprar Glória" (not bought) / "Comprar nível" (bought), "Enviar Glória" (`M11/sevenyear/view/battleflag/SevenYearGradeView.as:100-200`) | 4987 |
| `battleflag.SevenYearFlagHandleFrame` (610x505) | Comprar Bandeira de Guerra / Enviar Bandeira de Guerra | Buy or gift flag nv.1 or nv.40 variants ("Bandeira de Guerra nv.1 pode receber itens", "nv.40 pode receber todos itens ... e mais") | config |
| `sevenyear.SevenYearBuyFrame` (535x500) | | Buy level packs (3 rows from `seven_year_buy_grade_config` = `25,20000|15,13500|5,5000`), totals "Nível total"/"Preço total" (`M11/sevenyear/SevenYearBuyFrame.as:160-200`) | config |
| `battleflag.SevenYearRewardView` | | Free and paid reward rows per level, "{0} prêmios que podem ser coletados", claim, "Voltar o meu nível" (`M11/sevenyear/view/battleflag/SevenYearRewardView.as:230-390`) | templates, 4987 |
| `battleflag.SevenYearGameView` | | "Desafiar mini game aleatório" (star-area mini game), "Coleta de prêmios" once per day, glory schedule shortcut (`M11/sevenyear/view/battleflag/SevenYearGameView.as:100-330`) | `gameCount` |
| `battleflag.SevenYearAnswerView` / `item.SevenYearAnswerItem` | | Quiz: question, options, "Pontuação acumulada: {0}", "Tempo restante: {0}" | 4989 |
| `battleflag.SevenYearRankView` | | Top flag levels "Nível da Bandeira de Guerra" | 4988 |
| `view.SevenYearAchievementView` / `item.SevenYearAchievementItem` | | Achievements with 3 tiers each, claim button, "{0}/{1}" | 4987 `achievements` |
| `view.SevenYearShopView` / `item.SevenYearShopGoodsItem` | | Anniversary shop (shop goods list of the seven-year shop, job filtered, `CM/mvc/controler/ShopControler.as:1339-1352`); collection items open the treasure box frame | shop templates |
| `sevenyear.SevenYearTreasureBoxFrame` (835x605) | | Collection box: buy level, buy collection, gift, "Desbloquear coleção" | 4898 |
| `view.SevenYearStarAreaView` | | Star-area tab: opens `STARAREA_SCENE` ([../cosmos/stararea.md](../cosmos/stararea.md)) | |
| `view.SevenYearGloryGameView` | | Glory tab ([../glory-supremacy/README.md](../glory-supremacy/README.md)); blocked with "SevenYearGloryGame.sign.str9" when `GloryGameManager.model.isOpen` is false (`SevenYearMainFrame.as:183-191`) | |

Reachability in this build: the toolbar key `sevenyear` (template 2061 "周年庆", visible when `YearActiveManager.ins.isOpen`, `CM/ui/toptoolbar/TopBtnCheckShowHelper.as:397-398`) opens `yearactive` (`CM/ui/toptoolbar/TopToolsBar.as:1482-1484`), not this frame. `SevenYearMainFrame` opens only when returning from the star-area scene (`isOpenStararea`, `M3/map/space/SpaceSceneController.as:342-344`, `decompiled/m4/scripts/castle/CastleSceneView.as:281`). A rebuild that wants the hub must add an entry (A).

## 3. Routes (client to server)

C to S 9692 (0x25dc) `C_SEVEN_YEAR_OP`, `player.PlayerOpMsg` {`op` (#1, INT32), `type` (#2, INT32) always set (0 unless stated), `param1` (#15, STRING) when non empty, `templateId` (#8, INT32) when > 0}. Senders `SYM.sendOp` (`SYM:129-144`), `sendBuyFlag` (`SYM:146-153`), `sendSendFlag` (`SYM:155-163`).

| op | Action | UI / sender | Client checks | Fields | Response |
|---|---|---|---|---|---|
| 0 | Open hub | `SevenYearMainFrame` constructor (`SevenYearMainFrame.as:63`) | none | - | 4986, 4987, 4988, 4989 (A) |
| 1 | Buy flag ("Glória") | `SevenYearGradeView.secondConfrimBuy` (`SevenYearGradeView.as:166-176`), `SevenYearFlagHandleFrame.buyCallBack` (`SevenYearFlagHandleFrame.as:205-216`) | confirm "Usar {0} diamantes para comprar glória?"; diamonds >= price (`LogicUtils.judgePointEnoughToShowPay`) | `type` 0 = nv.1 flag, 1 = nv.40 flag | 4987 (`hasBuy = true`), currency push |
| 2 | Gift flag | `GiftDonatioFrame` callback (`SevenYearGradeView.as:192-197`, `SevenYearFlagHandleFrame.as:224-228`) | diamonds; friend picked | `type` 0/1, `param1` friend name | 4987 to buyer (A); target gets `hasBuy` and mail (A) |
| 3 | Buy levels | `SevenYearBuyFrame.buyCallBack` (`SevenYearBuyFrame.as:176-197`) | confirm "Confirmar o consumo de {0} diamantes para elevar {1} níveis da Bandeira de Guerra?"; diamonds | `param1` = "n25,n15,n5" counts of each pack | 4987 |
| 4 | Claim reward track | "{0} prêmios que podem ser coletados" (`SevenYearRewardView.as:380-383`) | some level claimable | - | items, 4987 (`rewardGrade`, `rewardFreeGrade`) |
| 5 | Claim daily game reward | "Coleta de prêmios" (`SevenYearGameView.as:323-328`) | mini game passed today (`isGamePassed`), `gameCount == 0` | - | 4987 (`gameCount = 1`, +200 points) |
| 6 | Claim achievement tier | `SevenYearAchievementItem.__btnClickHandler` (`M11/sevenyear/view/item/SevenYearAchievementItem.as:192-198`) | progress reached | `templateId` achievement template | 4987 |
| 7 | Answer quiz | `SevenYearAnswerItem` click (`M11/sevenyear/view/item/SevenYearAnswerItem.as:85-100`) | one click per question | `templateId` chosen option (question template id) | 4989 with `rightAnswer`, next question; 4987 `answerTotalScore` |
| 8 | Close hub | `SevenYearMainFrame.dispose` (`SevenYearMainFrame.as:254-258`) | none | - | none |

Treasure box: C to S 9695 (0x25df) `C_TREASURE_BOX_OP`, `PlayerOpMsg` {`op` = 0 open, `templateId` = box item id} from `SYM.openTreasureBox` (`SYM:165-171`), called by `SevenYearTreasureBoxFrame` (`M11/sevenyear/SevenYearTreasureBoxFrame.as:493`) and by `year2023` (`M3/year2023/frame/YearActiveTreasureBoxFrame.as:482`). Response 4898. Buying collections uses the generic shop purchase (`ShopManager.buyOne`, `SevenYearTreasureBoxFrame.as:640`; see [../shops/purchase.md](../shops/purchase.md)).

Matchmaking for auto-chess from this hub: `SevenYearSelfChessView` -> 9701 ([auto-chess](../auto-chess/README.md)); the daily game card also cancels a pending auto-chess match (`SelfChessManager.sendMatch(2)`, `SevenYearGameView.as:309-316`) before launching the star-area mini game.

## 4. Server messages (server to client)

Receivers in `SYM` (`SYM:70-127`), model `CM/mvc/module/sevenyear/SevenYearModel.as`.

| Opcode | Message | When | Effect |
|---|---|---|---|
| 4986 (0x137a) `U_C_SEVEN_YEAR_ACTIVE_INFO` | `SevenYearActiveMsg` {`isOpen` (#1, BOOL), `startDate` (#2, STRING), `stopDate` (#3, STRING)} | login, open, state change | `isOpen=false` closes the hub (`SevenYearMainFrame.as:204-210`) |
| 4987 (0x137b) `U_C_SEVEN_YEAR_USER_INFO` | `SevenYearUserMsg` {`flagGrade` (#1), `flagScore` (#2) points inside the level, `rewardGrade` (#3) last paid level claimed, `gameCount` (#4) daily game claims today, `answerTotalScore` (#5), `achievementTotalScore` (#6), `snowScore` (#7) "Pontos de Guerreiro" earned today in auto-chess/snow (cap 600), `achievements` (#8, repeated `SevenYearAchievementMsg` {`type` (#1), `progress` (#2), `rewardGrades` (#3, INT32, repeated) claimed tiers}), `rewardFreeGrade` (#9) last free level claimed, `hasBuy` (#10, BOOL)} | after any op and after games | `updateUserInfo` (`SevenYearModel.as:93-113`) |
| 4988 (0x137c) `U_C_SEVEN_YEAR_ORDER_INFO` | `SevenYearOrderListMsg` {`orders` (#1, repeated `SevenYearOrderMsg` {`order` (#1), `nickName` (#2), `serverName` (#3), `flagGrade` (#4)}), `orderDate` (#2, STRING)} | open, periodic | rank view (sorted by `order`) |
| 4989 (0x137d) `U_C_SEVEN_YEAR_QUESTION_INFO` | `SevenYearQuestionMsg` {`questionId` (#1), `options` (#2, INT32, repeated, template ids), `myAnswer` (#3), `rightAnswer` (#4), `cdTime` (#5, seconds left)} | when matching starts, after each answer | quiz |
| 4898 (0x1322) `U_C_TREASURE_BOX` | `module.TreasureBoxUserMsg` {`dropList` (#1, INT32, repeated) items just obtained, `boxList` (#2, repeated `TreasureBoxMsg` {`templateId` (#1), `count` (#2), `openList` (#3, INT32, repeated) already obtained ids})} | after 9695, at open | box frame |
| 200, 201 | snow battle | see [../artillery/snow-battle.md](../artillery/snow-battle.md) | |

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Event dates | `seven_year_start_date`, `seven_year_stop_date` | ConfigInfos |
| Points per level | 1000 | `seven_year_grade_score`; `SevenYearGradeView.as:120-124` |
| Daily game | +200 points, once per day | `seven_year_game_score` |
| Daily war points cap | 600 (auto-chess and snow battle) | `snow_vehicle_daily_reward_max` |
| Flag price | `seven_year_buy_flag_point` = 1000 diamonds; the client reads index 0 (nv.1) and 1 (nv.40); only one value is configured, so the nv.40 price is undefined (default array `[100,1000,2000]` when the key is missing, `CM/yishi/datas/ConfigInfoManager.as:1527-1534`) | ConfigInfos |
| Level packs | 25 levels 20000, 15 levels 13500, 5 levels 5000 diamonds | `seven_year_buy_grade_config`; `ConfigInfoManager.as:1423-1430` |
| Flag background | `seven_year_flag_bgimg` = level thresholds 100/200/300/400/500 -> image 1..5 | ConfigInfos |
| Reward tracks | levels 1..500; free dropId 184000+level, paid dropId 191000+level (`site` = level) | `TPL/SevenYearFreeRewardDrop.xml`, `TPL/SevenYearRewardDrop.xml` |
| Claim | claims every unclaimed level up to `min(flagGrade, max)`; paid track only with `hasBuy` | `SevenYearRewardView.as:235-260`, `item/SevenYearRewardItem.as:130-160` |
| Achievements | 14 types x 3 tiers: daily games 7/14/28, quiz points 1000/5000/10000, space-time explore 20/40/80, destinations 1/2/4, space-time fights 10/20/30, glory predictions 1/3/5 (scores 100/350/550), unlock Aquarius I..IV and Tesouro I..IV 1/4/8 (scores 1000/5000/10000) | `TPL/SevenYearAchievementTemplates.xml` (42 rows) |
| Quiz | 388 templates, types 1 and 2 (194 each), shown while waiting for a match | `TPL/SevenYearQuestionTemplates.xml`; `SevenYearBattleFlagView.as:51-65` |
| Flag check | `SevenYearModel.hasFlag` always true | `SevenYearModel.as:180-192` |

## 6. Templates

| File | Record | Fields |
|---|---|---|
| `TPL/SevenYearAchievementTemplates.xml` | achievement tier | `TemplateId`, `TemplateName`, `IconPath`, `Desc`, `Type`, `Grade` (tier), `Target`, `Score` (points granted) |
| `TPL/SevenYearQuestionTemplates.xml` | question or option | `TemplateId`, `Type`, `TemplateName` (question), `AnswerName`, `IconPath`, `AnswerIconPath` |
| `TPL/SevenYearRewardDrop.xml`, `TPL/SevenYearFreeRewardDrop.xml` | drop rows | `dropId`, `site` (level), `itemId`, `count`, `isBind`, `appearType`, `validDate`, `isShow` |
| `TPL/TreasureBoxDrop.xml` | collection box drops | via `SevenYearTreasureBoxDropCate` (`CM/yishi/manager/TempleteManager.as:1315`) |
| `TPL/ConfigInfos.xml` | `seven_year_*` keys | |

## 7. Persistent state

```sql
CREATE TABLE hermitage_war.anniversary_players (
  player_id               BIGINT PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
  event_key               TEXT NOT NULL DEFAULT 'seven_year',
  flag_level              INTEGER NOT NULL DEFAULT 1,
  flag_points             INTEGER NOT NULL DEFAULT 0,
  has_paid_flag           BOOLEAN NOT NULL DEFAULT false,
  paid_claimed_level      INTEGER NOT NULL DEFAULT 0,
  free_claimed_level      INTEGER NOT NULL DEFAULT 0,
  quiz_total_score        INTEGER NOT NULL DEFAULT 0,
  achievement_total_score INTEGER NOT NULL DEFAULT 0
);

CREATE TABLE hermitage_war.anniversary_daily (
  player_id        BIGINT NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  day              DATE NOT NULL,
  game_claims      SMALLINT NOT NULL DEFAULT 0,
  war_points       INTEGER NOT NULL DEFAULT 0 CHECK (war_points >= 0),
  PRIMARY KEY (player_id, day)
);

CREATE TABLE hermitage_war.anniversary_achievements (
  player_id        BIGINT NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  achievement_type INTEGER NOT NULL,
  progress         INTEGER NOT NULL DEFAULT 0,
  claimed_tiers    SMALLINT[] NOT NULL DEFAULT '{}',
  PRIMARY KEY (player_id, achievement_type)
);

CREATE TABLE hermitage_war.anniversary_quiz (
  player_id     BIGINT PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
  question_id   INTEGER NOT NULL,
  options       INTEGER[] NOT NULL,
  my_answer     INTEGER NOT NULL DEFAULT 0,
  expires_at    TIMESTAMPTZ NOT NULL
);

CREATE TABLE hermitage_war.treasure_boxes (
  player_id     BIGINT NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  box_item_id   INTEGER NOT NULL,
  opened_ids    INTEGER[] NOT NULL DEFAULT '{}',
  PRIMARY KEY (player_id, box_item_id)
);
CREATE INDEX anniversary_players_rank_idx ON hermitage_war.anniversary_players (flag_level DESC, flag_points DESC);
```

`anniversary_daily.war_points` is the shared "Pontos de Guerreiro" counter used by auto-chess and the snow battle (`SevenYearUserMsg.snowScore`).

## 8. Backend implementation notes

- `hermitage_war::seven_year::handle_op` (9692) dispatch on `op` 0..8; every mutating op runs in one transaction and replies 4987.
- `add_war_points(player, n)`: clamp to `600 - war_points` today, add to `flag_points`, roll levels every 1000, push 4987. Called by auto-chess game over and the snow battle end.
- Op 1/2: spend diamonds via currency service; op 2 resolves the friend by name and grants the flag to the target (mail notice, A).
- Op 3: parse "a,b,c", price = a*20000 + b*13500 + c*5000, levels = 25a + 15b + 5c.
- Op 4: grant every drop row of levels `free_claimed_level+1..flag_level` (free) and `paid_claimed_level+1..flag_level` (paid, when `has_paid_flag`), update both markers.
- Op 7: validate the option belongs to the current question; correct answer adds quiz points (amount not in the client, A) and achievement progress (type 2).
- 4988 ranking: top N by flag level, refreshed periodically (A: hourly), `orderDate` = refresh time.
- 9695: roll a non-repeated common item from `TreasureBoxDrop`, rare and very rare also grant a common item (`SevenYearTreasureBoxFrame.openDescTxt.text`).

## 9. Open questions and assumptions

- (A) Quiz scoring, question cooldown and number of questions per wait.
- (A) The nv.40 flag price (only one value configured).
- (A) Rank size and refresh period.
- (A) Hub entry point in the rebuild (toolbar key now opens `yearactive`).
- The proto package `active.anniversary` belongs to [seasonal-events](../seasonal-events/README.md); coordinate ownership.

## 10. Implementation checklist

- [ ] Event switch and dates; 4986 at login.
- [ ] 9692 ops 0..8 with 4987 replies.
- [ ] Shared war points counter with daily cap, used by auto-chess and snow battle.
- [ ] Reward tracks (free and paid) claim.
- [ ] Flag buy and gift; level pack purchase.
- [ ] Achievements progress hooks (daily game, quiz, star area, glory predictions, collections).
- [ ] Quiz 4989 during matchmaking.
- [ ] Ranking 4988.
- [ ] Treasure box 9695 -> 4898.
- [ ] Tables above.
- [ ] Tests: level roll-over at 1000, cap 600, claim with and without paid flag, buy packs parsing.

## Screens

- `SevenYearStarAreaHelpFrame` (`decompiled/m11/scripts/sevenyear/view/help/SevenYearStarAreaHelpFrame.as`) extends `SimpleHelpFrame` and shows the star area rules ("Instruções").
