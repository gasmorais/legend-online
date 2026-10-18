# Guild funds, member contribution and resets (economy module)

Scope (overlaps `contribution.md`, which owns the donation handlers, and `profile.md`, which owns upkeep): the guild currencies (wealth "Fortuna da guilda", production "Produção da guilda", guild activity points, boss "Guerra" spirit), the member currencies (personal contribution "Contribuição", lifetime contribution, personal merit "Mérito individual"), donations, the contribution ranking, weekly upkeep, every sink and source by module, and the consolidated daily and weekly reset calendar of the economy area.

Path aliases:

| Alias | File |
|---|---|
| CSOM | `decompiled/core_module/scripts/managers/ConsortiaSocketOutManager.as` |
| CSSM | `decompiled/m6/scripts/consortia/net/ConsortiaSocektSendManager.as` |
| CM | `decompiled/core_module/scripts/yishi/manager/ConsortiaManager.as` |
| CC | `decompiled/core_module/scripts/mvc/controler/ConsortiaControler.as` |
| CMOD | `decompiled/core_module/scripts/mvc/module/consortia/ConsortiaModel.as` |
| PM | `decompiled/core_module/scripts/yishi/manager/PlayerManager.as` |
| CF | `decompiled/m6/scripts/consortia/view/myConsortia/contribution/ConsortiaContributeFrame.as` |
| CL | `decompiled/m6/scripts/consortia/view/myConsortia/contribution/ContributeItemList.as` |

## Overview

| Currency | Owner | Wire field | Sources | Sinks |
|---|---|---|---|---|
| Fortuna da guilda (wealth) | guild | `ConsortiaInfoMsg.offer` (#20) | donations of gold and diamonds | building upgrades types 1..5 (`buildings.md`), skill research 6..21 (`skills.md`), warehouse rental (`warehouse.md`), weekly upkeep; cross modules: new boss buff shop `consortia_newboss_buff_shop` 50000 each, cross guild sign up `cross_guild_sign_in_offer` 1000000, `consortia_war_sign_offer` 150000, `chess_pvp_sign_offer` 100000, `daylight_signin_offer` 2500000, demon altar `Consortia_OpenAltar1_Offer` 50000 / `Consortia_OpenAltar2_Offer` 200000 |
| Produção da guilda (production) | guild | `ConsortiaInfoMsg.consortia_asset` (#71) | guild activity quests `QuestType` 1 (`quests.md`) | Torre de Habilidade de Mestre upgrades, master research, commerce supply slots (`shop.md`) |
| Guild activity points | guild | `consortia_active_point` (#70) today, `consortia_weekly_active_point` (#77) week | quest rewards `ConsortiaActivePoint` | none (drive weekly goals) |
| Guerra (boss spirit) | guild | `ConsortiaInfoMsg.boss_info.spirit` (#65 -> `ConsortiaBossMsg.spirit` #2, INT64) | Espírito donations (1000 Espírito = 1) | boss upgrade (PvE module) |
| Contribuição (personal contribution) | member | `PlayerMsg.consortia_offer` (#19) | donations | common skill learning, altar prayers (20 each), Loja da Guilda ShopType 2, secret land buff `Fam_Buffer_Price` 200 (`decompiled/m3/scripts/map/campaign/view/ui/secretland/ConsortiaSecretInfoView.as:156-175`, PvE module) |
| Contribuição total (lifetime) | member | `PlayerMsg.consortia_totaloffer` (#52) | donations | none; voting needs `total >= 100 or current >= 100` (`CMOD:903-909`, core module) |
| Mérito individual (merit) | member | `ConsortiaUserJoinMsg.reputation` (#3) | personal quests `QuestType` 2 | altar gods 2 and 3, master skill learning, commerce trade purchases |

Entry points: info tab "Doar" button (`decompiled/m6/scripts/consortia/view/myConsortia/newui/ConsortiaInfoView.as:182-186`) and every "acrescentar fortuna/contribuição" confirm -> `CC.showContributeFrame` (`CC:338-341`) -> openType 2 `consortia.ConsortiaContributeFrame` (`CC:225-228`).

## Screens

| Class | pt-BR title | Purpose | Data |
|---|---|---|---|
| `CF` | "Contribuição da Guilda" (`CF:107`) | Three donation inputs: gold ("1000 ouro = 1 contribuição + 1 fortuna da Guilda"), Espírito ("1000 Espíritos = 1 guerra \n Guerra pode adestrar o Chefão da Guilda."), diamonds ("{0} diamantes = 1 Contribuição + 1 Fortuna da Guilda" + "Consumo de diamante vinculado prioritário"); live preview "+N" next to own contribution, guild wealth and Guerra (`CF:297-313`, `CF:592-629`) | guild wealth, Guerra, own contribution, own gold/Espírito/diamonds (`CF:160-183`) |
| `CL` | tabs today / history, columns "Posição", "Nome do Membro", "Fortuna", "Guerra" | Contribution ranking, 8 rows per page (`CL:60-125`) | `consortiaContributionList`, own row (`CF:484-505`) |
| `decompiled/m6/scripts/consortia/view/myConsortia/newui/ConsortiaInfoView.as` | "Fortuna da guilda:{0}", "Produção da guilda:{0}", "Pontos de combate:{0}", "Gasto para manutenção:{0}", "Contribuição individual:{0}", "Mérito individual:{0}", "Ranking da guilda:{0}" | Summary (`:219-261`) | |

## Actions

The three actions below are also specified in `contribution.md` (server handlers `guild::contribution::*`); they are repeated here so the currency flows are complete.

### F1. Donate gold and/or diamonds
- UI: gold button `__onContributeHnadler` (`CF:559-590`): gold > 0 else "Ouro insuficiente, não é possível contribuir"; input >= 1000 else "Contribuição mínima de 1000 ouro por vez". Diamond button `__onPointContributeHnadler` (`CF:316-347`): `point + giftToken > 0` else "Diamante insuficiente, não é possível contribuir"; input > 0 else "Insira valor de contribuição"; input >= `Point_ToOffer` else "Sempre que doar consumirá {0} diamantes". Both buttons send the current values of both inputs (the other field is reset to 0 when an input is focused, `CF:349-392`).
- Client path: `CSSM.consortiaContribute(gold, point)` (`CSSM:100-117`): gold balance check ("Ouro insuficiente!"), `point + giftToken >= point` check ("Diamante insuficiente!"), gold rounded down to a multiple of 1000, then `CSSM.consortiaContributesend` (`CSSM:119-126`).
- Route: send 5144 (0x1418) `U_C_CONSORTIA_OFF`.
- Message `ConsortiaUserOfferReqMsg` (`decompiled/core_module/scripts/com/road/yishi/proto/consortia/ConsortiaUserOfferReqMsg.as`): `offer_gold` (#1, INT32) gold amount (multiple of 1000); `offer_point` (#2, INT32) diamonds. `proto.json` also lists `pay_type` (#3, INT32), not written by this client.
- Expected replies in order: 42 (0x002a) `U_C_CONSORTIA_OFF` `ConsortiaMsg.result = true` (S2); 3 (0x0003) `U_C_PLAYER_INFO` with `consortia_offer`, `consortia_totaloffer`, `point`, `gift_token`; gold through the resource update of the castle module; 164 (0x00a4) with the new `offer` to all online members.

### F2. Donate Espírito (Guerra)
- UI: `__onSoulBtnHnadler` (`CF:528-557`): `strategy > 0` else "Espíritos insuficientes,  não é possível doar."; input >= 1000 else "Cada vez que doar consome 1000 espíritos.".
- Client path: `CSSM.consortiaContributeSoul(n)` (`CSSM:128-139`): `playerInfo.strategy >= n` else "Espíritos insuficientes!".
- Route: send 8845 (0x228d) `C_CONSORTIA_STRATEGY`; message `ConsortiaUserOfferReqMsg.offer_gold` (#1, INT32) = Espírito amount rounded down to a multiple of 1000.
- Expected replies: 42 `result = true` (assumption, same handler); 3 with `strategy` (#20, INT64); 164 with `boss_info.spirit` increased by `n / 1000` (PvE module consumes it).

### F3. Read the contribution ranking
- UI: tabs today / history (`CL:163-166`) -> `CC.getConsortiaOffer(isHistory)` (`CC:680-685`, resets page to 1); page buttons -> `CC.contributeSearchPageHandler` (`CC:727-742`); refresh after F1 success or member list change (`CL:126-140`).
- Client path: `CC.sendGetConsortiaOffer` (`CC:687-690`) -> `CSOM.getConsortiaOffer(page, isHistory)` (`CSOM:195-202`).
- Route: send 8208 (0x2010) `U_C_CONSORTIA_OFFER_LIST`; message `ConsortiaOfferReqMsg`: `page_index` (#1, INT32, 1 based), `is_history` (#2, BOOL, false = today, true = all time).
- Reply: 4134 (0x1026) `U_C_CONSORTIA_OFFER_LIST` (S1).

## Server messages

| Opcode | Name | Message | Handler | Fields | When |
|---|---|---|---|---|---|
| 4134 (0x1026) | `U_C_CONSORTIA_OFFER_LIST` | `ConsortiaContributeRspMsg`: `total_rows` (#1, INT32), `contributeInfo` (#2, repeated `ConsortiaContributeMsg`), `self_info` (#3, `ConsortiaContributeMsg`), `self_order` (#4, INT32, rank or <= 0 when unranked); `ConsortiaContributeMsg`: `nick_name` (#1, STRING), `total_offer` (#2, INT32), `today_offer` (#3, INT32), `today_spirit` (#4, INT64), `total_spirit` (#5, INT64) | `CC.__updataOfferList` (`CC:692-716`, listener only while a guild frame is open `CC:101`) | pages = `ceil(total_rows / 8)`; rows ordered by today or total contribution | Reply to 8208 |
| 42 (0x002a) | `U_C_CONSORTIA_OFF` | `ConsortiaMsg.result` (#14, BOOL) | `CC.__consortiaContributeResult` (`CC:668-678`) | true dispatches `ON_CONSORTIA_CONTRIBUTE_SUCCEED` (ranking reload) | Reply to 5144 (and 8845) |
| 3 (0x0003) | `U_C_PLAYER_INFO` | `PlayerMsg` | `PM.__uPlayerInfoHandler` (`PM:496`) | `consortia_offer` (#19, `PM:859`), `consortia_totaloffer` (#52, `PM:863`), `strategy` (#20, `PM:867`), `point` (#6), `gift_token` (#7); the contribution setter dispatches `CONSORTIA_OFFER_CHANGE` and `CM.__onContributeUpdata` mirrors it into the member list (`CM:707-719`) | After every personal currency change |
| 164 (0x00a4) / 4138 (0x102a) | `U_CH_CONSORTIA_FRESHINFO` / `U_C_CONSORTIA_INFO` | `ConsortiaInfoMsg` | `CM.__refreshConsortiaInfo` (`CM:457-577`) | `offer` (#20), `consortia_asset` (#71), `consortia_active_point` (#70), `consortia_weekly_active_point` (#77), `boss_info` (#65), `deduct_date` (#38, next upkeep), `warn_date` (#39, last unpaid upkeep), `orderInfo` (#44, `ConsortiaOrderInfoMsg`: `consortia_id` (#1), `grade_order` (#2) guild rank shown as "Ranking da guilda", `fight_power_order` (#3), `last_day_offer` (#4), `last_day_order` (#5), `last_week_offer` (#6), `last_week_order` (#7), `offer` (#8), `last_day_date` (#9), `last_week_date` (#10)) (`CM:611-625`) | Push to online members after any guild currency change |
| 180 (0x00b4) | `U_C_CONSORTIA_USER_JOIN_INFO` | `ConsortiaUserJoinMsg` | `CM.__userJoinInfoUpdateHandler` (`CM:1163-1207`) | `reputation` (#3) merit, `active_point` (#4), `weekly_active_point` (#5) | After merit changes |

## Rules and formulas

- Gold donation: `floor(gold / 1000)` personal contribution and the same guild wealth (`CF:625`, tip "1000 ouro = 1 contribuição + 1 fortuna"). Gold is rounded down to a multiple of 1000 before sending (`CSSM:116`).
- Diamond donation: `floor(diamonds / Point_ToOffer)` with `Point_ToOffer = 1`; bound diamonds are spent first.
- Espírito donation: `floor(espirito / 1000)` Guerra; also counted as `today_spirit` / `total_spirit` in the ranking.
- Personal contribution and lifetime contribution increase together; only the current value is spent.
- Weekly upkeep: `hall_level * 500` wealth per week (`decompiled/m6/scripts/consortia/view/myConsortia/newui/ConsortiaInfoView.as:231`), tip "Será deduzido da fortuna da Guilda, próximo dedução:" (`consortia.view.myConsortia.ConsortiaFrameTopView.maintenanceCostTip`). When wealth is insufficient set `warn_date`; if still unpaid at the next deduction the guild is dissolved ("mais uma vez e a Guilda será dissolvida"). The client warns when `now - warn_date >= 8 days` (`CC:132-142`). Dissolution itself is a core module action.
- Guild ranking snapshot (`orderInfo`): daily and weekly wealth gained and their ranks, refreshed at `last_day_date` / `last_week_date` (assumption: 00:00 daily, Monday weekly).

Reset calendar of the economy area (server time; assumptions marked):

| Item | Period | Source |
|---|---|---|
| `today_offer`, `today_spirit` in the ranking | daily 00:00 (assumption) | 4134 "today" tab |
| Altar prayers used | daily 00:00 (assumption) | `buildings.md` |
| Treasure digs (8), helps (8), paid refresh count | daily 00:00 (assumption) | `treasure.md` |
| Treasure offer list | every even UTC hour | `decompiled/m6/scripts/consortia/view/myConsortia/treasure/TreasureListView.as:153-156` |
| Personal quests `ResetType` 1 and guild daily goals | daily | `quests.md` |
| Guild weekly goals `ResetType` 2, `consortia_weekly_active_point` | weekly Monday 00:00 (assumption) | `quests.md` |
| Collective quests `ResetType` 3 | monthly | `quests.md` |
| Caçada: personal score, hunts (10), personal chests | daily 00:00 | `wants.md` |
| Caçada: guild score and guild chests | weekly Monday 00:00 | `wants.md` |
| Câmara de Comércio supply and trade windows | Monday 00:00 supply opens, Thursday 00:00 trade opens | `shop.md` |
| Weekly upkeep deduction | weekly at `deduct_date` | this file |
| Warehouse rental expiry | per rental | `warehouse.md` |
| Legacy prize chest grant | weekly | `warehouse.md` |

## Templates

`raw/xml/tempinfos/ConfigInfos.xml`: `Point_ToOffer` = 1, `Consortia_Fast`, `consortia_storage_offer`, plus the cross module wealth sinks listed in the overview. `raw/xml/tempinfos/ConsortiaLevelInfos.xml` type 1 `Property2` = weekly upkeep.

## Persistent state

Aligned with the core module: guild wealth is `guild.guild.fortune`, production is `guild.guild.asset`, upkeep dates are `guild.guild.next_maintenance_at` / `maintenance_warned_at`, ranking is `guild.ranking` (`profile.md`); personal contribution is `guild.member.contribution` / `total_contribution` / `total_spirit` and daily ranking rows are `guild.member_daily_contribution` (`membership.md`, `contribution.md`); boss spirit lives in the PvE boss table (`boss.md`). This module adds merit, guild activity counters and a ledger:

```sql
ALTER TABLE guild.member
  ADD COLUMN merit INTEGER NOT NULL DEFAULT 0 CHECK (merit >= 0);          -- ConsortiaUserJoinMsg.reputation

ALTER TABLE guild.guild
  ADD COLUMN active_point_day        DATE,
  ADD COLUMN active_point_today      INTEGER NOT NULL DEFAULT 0 CHECK (active_point_today >= 0),   -- consortia_active_point
  ADD COLUMN active_point_week_start DATE,
  ADD COLUMN active_point_week       INTEGER NOT NULL DEFAULT 0 CHECK (active_point_week >= 0);    -- consortia_weekly_active_point

CREATE TABLE guild.currency_ledger (
  id         BIGSERIAL PRIMARY KEY,
  guild_id   INTEGER  NOT NULL REFERENCES guild.guild(id) ON DELETE CASCADE,
  player_id  INTEGER  REFERENCES public.player(id) ON DELETE SET NULL,
  currency   TEXT     NOT NULL CHECK (currency IN ('fortune','asset','activity','contribution','merit')),
  delta      INTEGER  NOT NULL CHECK (delta <> 0),
  reason     TEXT     NOT NULL,
  ref_id     BIGINT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX currency_ledger_guild_time_idx ON guild.currency_ledger (guild_id, created_at DESC);
CREATE INDEX currency_ledger_player_time_idx ON guild.currency_ledger (player_id, created_at DESC) WHERE player_id IS NOT NULL;
```

Donations themselves are logged in `guild.donation_log` (`contribution.md`); the ledger covers every other movement (spending by buildings, skills, rental, altar, shops, quests).

## Backend implementation notes

Ownership: the request handlers of this file are specified in `contribution.md` (`guild::contribution::handle_donate` 5144, `guild::contribution::handle_donate_spirit` 8845, `guild::contribution::handle_list_ranking` 8208) and the weekly upkeep job in `profile.md` (`guild::profile::maintenance_tick`). This module provides the shared currency API used by every economy handler:
- `guild::funds::spend_fortune(tx, guild_id, amount, reason, ref)` / `add_fortune`: lock `guild.guild`, check and update `fortune`, insert ledger.
- `guild::funds::spend_asset` / `add_asset`: same on `asset`.
- `guild::funds::add_activity_points(tx, guild_id, amount)`: roll `active_point_day` / `active_point_week_start`, add to both counters, then call `guild::quests::bump_condition` for condition type 7.
- `guild::funds::spend_contribution(tx, player_id, amount, reason)`: on `guild.member.contribution` (never touches `total_contribution`).
- `guild::funds::add_merit` / `spend_merit`: on `guild.member.merit`.
- After commit callers push: 164 to all online members (guild currencies), 3 to the player (`consortia_offer`), 180 to the player (merit).

Validation rule shared by all spends: amount > 0, balance >= amount, row locked in the same transaction as the purchased effect; on failure return the module specific error (most client flows have no error opcode, so reply nothing).

Daily and weekly rollovers are lazy (compare stored day/week with now) plus one job `guild::funds::midnight_push` that pushes fresh 164/179/180 to online members at 00:00 (assumption, keeps counters in sync on screen).

## Open questions

- Does 8845 reply on 42 or on a boss specific opcode (PvE module)?
- Exact upkeep deduction weekday/time and the dissolution rule.
- Whether personal contribution and merit are kept, reset or partially kept when changing guild.
- `ConsortiaUserOfferReqMsg.pay_type` (#3) in `proto.json` is not written by the client; ignore it.

## Implementation checklist

- [ ] Client screen: ConsortiaContributeFrame (gold, Espírito, diamonds) with ranking list
- [ ] Client screen: ConsortiaInfoView currency labels
- [ ] Column `guild.member.merit` and activity columns on `guild.guild`
- [ ] Table `guild.currency_ledger`
- [ ] Handlers 5144, 8845, 8208 (specified in `contribution.md`)
- [ ] Shared API `guild::funds::spend_*` / `add_*` with ledger
- [ ] Weekly upkeep job (specified in `profile.md`) and `guild::funds::midnight_push`
- [ ] Encoders: `PlayerMsg` #19/#52/#20, `ConsortiaInfoMsg` #20/#38/#39/#44/#65/#70/#71/#77, `ConsortiaUserJoinMsg` #3..#5
- [ ] Daily rollover of `today_contribution` / `today_spirit`
