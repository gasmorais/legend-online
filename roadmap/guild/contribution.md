# Guild contribution (donations)

Area: guild core, module `contribution`. Covers the donate frame ("Contribuição da Guilda"), the three donation currencies (gold, diamonds, spirits), personal contribution (`consortiaOffer`, `consortiaTotalOffer`), guild fortune (`offer`), the daily and historical contribution ranking, and how contribution changes reach the client.

Conventions: see [membership.md](membership.md). No HTTP servlet is involved.

## Overview

The donate button in the info tab (`decompiled/m6/scripts/consortia/view/myConsortia/newui/ConsortiaInfoView.as:182`) and the "insufficient fortune" popup in the develop tab ([profile.md](profile.md)) open `ConsortiaContributeFrame` through controller openType 2 (`decompiled/core_module/scripts/mvc/controler/ConsortiaControler.as:338`, `:225`). The player types an amount in one of three inputs:

- Gold: 1000 gold = 1 personal contribution + 1 guild fortune ("1000 ouro = 1 contribuição + 1 fortuna da Guilda").
- Diamonds: `Point_ToOffer` = 1 diamond = 1 contribution + 1 fortune ("{0} diamantes = 1 Contribuição + 1 Fortuna da Guilda"), bound diamonds counted ("Consumo de diamante vinculado prioritário").
- Spirits (`strategy`): 1000 spirits = 1 "Guerra" point of the guild boss ("1000 Espíritos = 1 guerra \n Guerra pode adestrar o Chefão da Guilda."); this feeds the PvE boss (`emeDreamInfo.spirit`, shown as "Pontos de combate").

The right side lists members by contribution, 8 per page, with a "today" tab and a "history" tab, plus the player's own rank.

Personal contribution (`consortiaOffer`) is the spendable currency used to learn guild skills (economy area); `consortiaTotalOffer` is lifetime and drives election eligibility ([election.md](election.md)).

## Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `ConsortiaContributeFrame` (`decompiled/m6/scripts/consortia/view/myConsortia/contribution/ConsortiaContributeFrame.as:104`) | "Contribuição da Guilda"; labels "Posição", "Nome do Membro", "Fortuna", "Guerra" | Three donation inputs with live preview ("+N"), current balances, guild fortune and boss spirit | openType 2 (`ConsortiaControler.as:225`) | gold, `strategy`, `point + giftToken`, guild `offer`, `emeDreamInfo.spirit`, own `consortiaOffer`; own rank row from 4134 (`:484`) |
| `ContributeItemList` + `ConsortiaContributionItem` (`ContributeItemList.as:52`, `ConsortiaContributionItem.as:133`) | tabs today / history | Ranking, 8 rows per page, pager | Contribute frame | nickname, `todayOffer`/`totalOffer`, `todaySpirit`/`totalSpirit`; row click opens `ConsortiaPlayerMenu` |
| `ConsortiaMemberItem` (`decompiled/m6/scripts/consortia/view/myConsortia/ConsortiaMemberItem.as:189`) | contribution column | Shows `consortiaOffer / consortiaTotalOffer` per member; own row uses live `PlayerInfo` values (`:222`) | Member tab | 4133 fields |

## Actions

| # | UI control | Client sender | Client checks | Route | Request message and fields | Resp |
|---|---|---|---|---|---|---|
| T1 | Donate gold | `ConsortiaContributeFrame.__onContributeHnadler` `ConsortiaContributeFrame.as:559` -> `ConsortiaSocektSendManager.consortiaContribute` `decompiled/m6/scripts/consortia/net/ConsortiaSocektSendManager.as:100` -> `consortiaContributesend` `:119` | gold > 0 ("Ouro insuficiente, não é possível contribuir"); amount >= 1000 ("Contribuição mínima de 1000 ouro por vez"); `gold >= amount` ("Ouro insuficiente!"); `point + giftToken >= diamond input` ("Diamante insuficiente!"); gold rounded down to a multiple of 1000 (`:115`). The diamond input is normally 0 because focusing the gold input resets it (`:349`) | C>S 5144 0x1418 `U_C_CONSORTIA_OFF` | `ConsortiaUserOfferReqMsg`: `offer_gold (#1, INT32)` gold amount, multiple of 1000; `offer_point (#2, INT32)` diamonds; `pay_type (#3, INT32)` not set (0) | 42 (`result`), then 3 (gold/diamonds, `consortia_offer`, `consortia_totaloffer`), 164 (guild `offer`) |
| T2 | Donate diamonds | `ConsortiaContributeFrame.__onPointContributeHnadler` `ConsortiaContributeFrame.as:316` -> same sender | `point + giftToken > 0` ("Diamante insuficiente, não é possível contribuir"); amount not 0 ("Insira valor de contribuição"); amount >= `Point_ToOffer` ("Sempre que doar consumirá {0} diamantes"); input clamped to balance (`:297`) | C>S 5144 0x1418 | `offer_gold` = gold input (normally 0, rounded to 1000), `offer_point` = diamonds | as T1 |
| T3 | Donate spirits | `ConsortiaContributeFrame.__onSoulBtnHnadler` `ConsortiaContributeFrame.as:528` -> `ConsortiaSocektSendManager.consortiaContributeSoul` `ConsortiaSocektSendManager.as:128` | `strategy > 0` ("Espíritos insuficientes,  não é possível doar."); amount >= 1000 ("Cada vez que doar consome 1000 espíritos."); `strategy >= amount` ("Espíritos insuficientes!"); rounded down to 1000 | C>S 8845 0x228d `C_CONSORTIA_STRATEGY` | `ConsortiaUserOfferReqMsg`: `offer_gold (#1)` = spirit amount (multiple of 1000), other fields unset | 3 (`strategy`), 164 (`boss_info.spirit`, PvE), Assumption: 42 `result` true so the list refreshes |
| T4 | Open frame, switch tab | `ContributeItemList.initData` `ContributeItemList.as:110` and `__tabBtnHandler` `:162` -> `ConsortiaControler.getConsortiaOffer` `ConsortiaControler.as:680` -> `ConsortiaSocketOutManager.getConsortiaOffer` `decompiled/core_module/scripts/managers/ConsortiaSocketOutManager.as:195` | none; page reset to 1 | C>S 8208 0x2010 `U_C_CONSORTIA_OFFER_LIST` | `ConsortiaOfferReqMsg`: `page_index (#1, INT32)` 1 based; `is_history (#2, BOOL)` false = today, true = all time | 4134 |
| T5 | Pager | `ContributeItemList.__onPageBtnHandler` `ContributeItemList.as:156` -> `ConsortiaControler.contributeSearchPageHandler` `ConsortiaControler.as:727` | page bounds | C>S 8208 0x2010 | same with new page | 4134 |
| T6 | Auto refresh | `ContributeItemList.__onContributeSucceedHandler` `ContributeItemList.as:141` (after 42 `result`), member list update (`:151`) -> `ConsortiaControler.sendGetConsortiaOffer` `ConsortiaControler.as:687` | none | C>S 8208 0x2010 | current page and tab | 4134 |

## Server messages

| Route | Message and fields read | When | Client handler and effect |
|---|---|---|---|
| S>C 42 0x002a `U_C_CONSORTIA_OFF` | `ConsortiaMsg`: `result (#14, BOOL)` | Response to 5144 (and 8845, Assumption) | `ConsortiaControler.__consortiaContributeResult` `ConsortiaControler.as:668`: on true dispatches `ON_CONSORTIA_CONTRIBUTE_SUCCEED` (list refresh). False shows nothing; send 111 with the reason |
| S>C 4134 0x1026 `U_C_CONSORTIA_OFFER_LIST` | `ConsortiaContributeRspMsg`: `total_rows (#1, INT32)` members ranked; `contributeInfo (#2, repeated ConsortiaContributeMsg)` page rows; `self_info (#3, ConsortiaContributeMsg)` own values; `self_order (#4, INT32)` own rank, <= 0 = unranked. `ConsortiaContributeMsg`: `nick_name (#1, STRING)`, `total_offer (#2, INT32)`, `today_offer (#3, INT32)`, `today_spirit (#4, INT64)`, `total_spirit (#5, INT64)` | Response to 8208 | `ConsortiaControler.__updataOfferList` `ConsortiaControler.as:692`: pages = `ceil(total_rows/8)`; rank of row i = `i + 1 + (page - 1) * 8` (`ContributeItemList.as:181`); own row shows today or total values by tab (`ConsortiaContributeFrame.as:484`). Listener only while the guild frame controller is active (`ConsortiaControler.as:101`) |
| S>C 3 0x0003 `U_C_PLAYER_INFO` | `PlayerMsg`: `consortia_offer (#19, INT32)`, `consortia_totaloffer (#52, INT32)`, `point (#6)`, `gift_token (#7)`, `strategy (#20, INT64)` (gold through the usual resource update) | After every donation, and whenever personal contribution changes (skill learning spends it) | `PlayerManager.__uPlayerInfoHandler` `decompiled/core_module/scripts/yishi/manager/PlayerManager.as:857`, `:861`; `CONSORTIA_OFFER_CHANGE` updates the own member row (`decompiled/core_module/scripts/yishi/manager/ConsortiaManager.as:707`); `PLAYER_INFO_UPDATE` refreshes balances in the frame (`ConsortiaContributeFrame.as:268`) |
| S>C 164 0x00a4 | `ConsortiaInfoMsg.offer (#20)`, `boss_info (#65)` | After donations, to all online members | `ConsortiaManager.__refreshConsortiaInfo` `ConsortiaManager.as:514`; frame updates fortune and spirit (`ConsortiaContributeFrame.as:475`) |

## Rules and formulas

- Gold: `contribution += floor(gold / 1000)`, `fortune += floor(gold / 1000)`; client sends multiples of 1000 (`ConsortiaSocektSendManager.as:115`), server must floor again and only debit `floor(gold/1000)*1000`.
- Diamonds: `contribution += floor(points / Point_ToOffer)`, `fortune += same`; `Point_ToOffer = 1` (`raw/xml/tempinfos/ConfigInfos.xml`, read at `ConsortiaContributeFrame.as:162`). Bound diamonds (`gift_token`) are counted by the client (`ConsortiaSocektSendManager.as:109`); Assumption: server spends bound first. The tip says bound diamond donations do not count for consumption events.
- Spirits: `boss_spirit += floor(strategy / 1000)` and member `today_spirit/total_spirit += strategy` (Assumption on units: the ranking shows spirit totals, the frame preview shows "+floor(n/1000)").
- Both `today_offer` and `total_offer` of the ranking count contribution points (not gold). `today_*` reset daily at 00:00 (Assumption).
- `consortiaTotalOffer` never decreases; `consortiaOffer` decreases when spent (skills, economy). The member row shows `offer/offer` when `offer > total` (`ConsortiaMemberItem.as:225`), so the server must keep `total >= offer`.
- Page size 8 (`ConsortiaModel.CONTRIBUTE_RECORD_PAGE_NUM`, `decompiled/core_module/scripts/mvc/module/consortia/ConsortiaModel.as:34`). Order: by `today_offer` (today tab) or `total_offer` (history tab) descending (Assumption).
- Event log: none for donations (Assumption; event types list has no donation type).

## Templates

`raw/xml/tempinfos/ConfigInfos.xml`: `Point_ToOffer` = 1. Strings: `consortia.view.myConsortia.contribution.ConsortiaContributeFrame.*`, `consortia.ConsortiaControler.command06`, `command07`, `command11`.

## Persistent state

Columns `contribution` and `total_contribution` live on `guild.member` ([membership.md](membership.md)); `fortune` on `guild.guild` ([profile.md](profile.md)); boss spirit on the PvE boss table.

```sql
CREATE TABLE guild.member_daily_contribution (
    guild_id      integer NOT NULL REFERENCES guild.guild(id) ON DELETE CASCADE,
    player_id     BIGINT NOT NULL REFERENCES public.player(id) ON DELETE CASCADE,
    day           date    NOT NULL,
    offer         integer NOT NULL DEFAULT 0 CHECK (offer >= 0),
    spirit        bigint  NOT NULL DEFAULT 0 CHECK (spirit >= 0),
    PRIMARY KEY (guild_id, player_id, day)
);
CREATE INDEX member_daily_contribution_rank_idx ON guild.member_daily_contribution (guild_id, day, offer DESC);

ALTER TABLE guild.member ADD COLUMN total_spirit bigint NOT NULL DEFAULT 0 CHECK (total_spirit >= 0);

CREATE TABLE guild.donation_log (
    id          bigserial   PRIMARY KEY,
    guild_id    integer     NOT NULL REFERENCES guild.guild(id) ON DELETE CASCADE,
    player_id   BIGINT     NOT NULL REFERENCES public.player(id) ON DELETE CASCADE,
    currency    text        NOT NULL CHECK (currency IN ('gold', 'diamond', 'bound_diamond', 'spirit')),
    amount      bigint      NOT NULL CHECK (amount > 0),
    contribution_gained integer NOT NULL DEFAULT 0,
    created_at  timestamptz NOT NULL DEFAULT now()
);
CREATE INDEX donation_log_guild_idx ON guild.donation_log (guild_id, created_at DESC);
```

## Backend implementation notes

| Opcode | Handler |
|---|---|
| 5144 | `guild::contribution::handle_donate` |
| 8845 | `guild::contribution::handle_donate_spirit` |
| 8208 | `guild::contribution::handle_list_ranking` |

5144 validation order: member; `offer_gold >= 0`, `offer_point >= 0`, at least one positive; `offer_gold` floored to 1000; balances (gold, bound plus real diamonds). One transaction: debit currencies, add `floor(gold/1000) + floor(points/Point_ToOffer)` to `guild.member.contribution`, `total_contribution`, `guild.guild.fortune`, upsert today's `member_daily_contribution`, insert `donation_log`. After commit: 42 `result` true to the donor, 3 to the donor, 164 to all online members.

8845 validation: member; amount >= 1000 and floored; `strategy` balance. Transaction: debit strategy, add to boss spirit (PvE table) and member spirit counters. Pushes: 3 to donor, 164 to online members, 42 (Assumption).

8208: compute rows for the guild ordered by today or total offer; return the requested page (8 rows), the caller's own row and rank.

## Open questions

1. Response to 8845 (42 or a PvE specific push such as 4728).
2. Daily reset hour for `today_offer`.
3. Spirit unit in the ranking (raw spirits or points of 1000).
4. Whether diamond donations accept `pay_type` (client never sets it).

## Implementation checklist

Client flows:

- [ ] Donate frame opens from info tab and from the develop tab popup
- [ ] Gold donation updates gold, personal contribution, guild fortune, ranking
- [ ] Diamond donation with bound diamonds
- [ ] Spirit donation updates "Guerra" and boss spirit
- [ ] Ranking today/history tabs and pager, own rank row
- [ ] Member list contribution column reflects new values

Backend:

- [ ] `guild.member_daily_contribution`, `guild.donation_log`, `guild.member.total_spirit`
- [ ] Handlers 5144, 8845, 8208
- [ ] Pushes 42, 3, 164
- [ ] Daily reset job for today counters (or date keyed rows as above)
