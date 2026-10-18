# Guild treasure (economy module)

Scope: "Tesouro da Guilda": each member digs chests from a personal offer list, a guild mate must help open each chest, the owner and the helper both get a reward after a timer. Everything goes through one request opcode with an `op` code.

Path aliases:

| Alias | File |
|---|---|
| CSOM | `decompiled/core_module/scripts/managers/ConsortiaSocketOutManager.as` |
| CSSM | `decompiled/m6/scripts/consortia/net/ConsortiaSocektSendManager.as` |
| CM | `decompiled/core_module/scripts/yishi/manager/ConsortiaManager.as` |
| CMOD | `decompiled/core_module/scripts/mvc/module/consortia/ConsortiaModel.as` |
| TV | `decompiled/m6/scripts/consortia/view/myConsortia/treasure/` |
| V | `decompiled/m6/scripts/consortia/view/myConsortia/` |
| PROTO | `decompiled/core_module/scripts/com/road/yishi/proto/consortia/` |

## Overview

- The member gets a list of chests ("Escavar"); digging consumes one of 8 daily digs. Digging is free when the free dig timer elapsed, otherwise it costs 20 diamonds.
- A dug chest appears in "Meus tesouros" with status 0 and a countdown. A guild mate must "help open" it (8 helps per day) before the countdown ends, otherwise it disappears ("Contagem do desaparecimento:").
- When helped (status 1) the owner waits until `openTime + RewardSeconds` ("Contagem da coleta de prêmios:"), then claims `Drop` (status 2). The helper waits `helperRewardTime` (can pay to speed up) and claims `HelperDrop`.
- Members who joined the guild less than 24 hours ago get error 5 "Tempo de entrada da guilda inferior a 24h.".

Entry points:
- Activity tab item id 4 (`decompiled/core_module/scripts/mvc/module/consortia/ConsortiaViewHelper.as:328-350`) -> `CC.showTreasureFrame(7)` -> openType 11 `consortia.ConsortiaTreasureFrame` (`decompiled/core_module/scripts/mvc/controler/ConsortiaControler.as:257-260`,`:419-423`).
- Task trace tip type 51 "No momento tem tesouro para ser escavado ou coletado." (`CM:1524-1536`) -> openType 11 (`decompiled/m16/scripts/tasktracetip/view/ConsortiaTreasureTipView.as:49`).
- Guild chat link type 114 (`decompiled/core_module/scripts/chat/datas/ChatCellData.as:228-231`,`:412-415`) -> `ChatOutputViewII.__openTreasureClick` sets `helpOpenId` and opens openType 11 on the help tab (`decompiled/core_module/scripts/chat/view/ChatOutputViewII.as:327-342`).
- Login and every 30 minutes the client polls ops 0, 1, 2 to update red counters (`CM.setup` `CM:127-135`, `CM.sendTreasureInfo` `CM:579-586`).

## Screens

| Class | pt-BR title | Purpose | Data |
|---|---|---|---|
| `V/ConsortiaTreasureFrame.as` | "Tesouro da Guilda" (`:76`) | Frame, sets `isOpenTreasreFrame` (`:77`,`:93`) | |
| `V/ConsortiaTreasurePage.as` | tabs list / meus / ajuda | Loads config (`:59`), clears tip 51 (`:58`), selects tab 2 when opened from a chat link (`:91-110`); disables tabs 1 and 2 when `NoOpen` | red counters `treasureMyCount`, `treasureOtherCount` (`CMOD:297-333`) |
| `TV/TreasureListView.as` | "Após começar a escavar tesouro, é necessário a ajuda dos seus aliados para abri-los." | Offer list, digs left, free dig progress, refresh | `leftCount`, `freeTime`, `freeTemplateSecond`, `refreshTimes`, `treasures` (`:135-196`); system refresh countdown "Contagem de atualização do sistema:" to the next even UTC hour (`:153-156`) |
| `TV/TreasureListItem.as` | "Tempo de Abertura:" | One offered chest: name colored by quality, open time, `Drop` preview, dig buttons | template (`:79-110`) |
| `TV/MyTreasureView.as`, `TV/MyTreasureItem.as` | "Auxiliantes:", "Não teve ajuda dos seus aliados" | Own dug chests; request help, claim | `myTreasures` sorted by status desc, help requests asc, quality desc (`MyTreasureView.as:39-70`) |
| `TV/TreasureHelpView.as`, `TV/TreasureHelpItem.as` | "Tesouros a abrir agora:" | Guild mates' chests to help; helps left; speed up; claim helper reward | `helpList`, `helpLeftCount` (`TreasureHelpView.as:92-127`) |

## Actions

All requests: route send 9629 (0x259d) `C_CONSORTIA_TREASURE_OP`, message `ConsortiaTreasureOpMsg` (`PROTO/ConsortiaTreasureOpMsg.as`): `op` (#1, ENUM `ConsortiaTreasureOpType`), `payType` (#2, INT32), `treasureId` (#3, INT32); `errorID` (#4, ENUM), `teasurePageInfo` (#5, MESSAGE `TreasurePageMsg`), `myTreasures` (#6, MESSAGE `MyTreasuresMsg`, repeated), `helpList` (#7, MESSAGE `HelpListPageMsg`) are only filled by the server. Sender `CSSM.sendOpenTreasure(op, payType=-1, treasureId=-1)` (`CSSM:245-255`) or `CSOM.sendTreasureInfo(op)` (`CSOM:354-362`, payType and treasureId -1). Reply always on 390 (0x0186) `U_C_CONSORTIA_TREASURE` with the same `op` echoed.

| # | op | UI and sender | Client checks | Expected reply |
|---|---|---|---|---|
| T0 | 0 `OPEN_TREASURES` | `TreasureListView` ctor (`TV/TreasureListView.as:83`), after dig (`:251`), on REFRESH reply (`:234-237`), on system countdown end (`:344-347`); `CM.sendTreasureInfo` | none | 390 op 0 with `teasurePageInfo` |
| T1 | 1 `OPEN_MY_TREASURES` | `MyTreasureView` ctor (`TV/MyTreasureView.as:36`), after claim (`:108-111`), after an expired item (`:103-106`); poll | none | 390 op 1 with `myTreasures` |
| T2 | 2 `OPEN_OTHERS_TREASURES` | `TreasureHelpView` ctor (`TV/TreasureHelpView.as:48`), after help/speed up/claim (`:216-224`), item timers (`TV/TreasureHelpItem.as:277-291`); poll | none | 390 op 2 with `helpList` |
| T3 | 3 `REFRESH` | "Atualizar" `_RefreshBtnHandle` (`TV/TreasureListView.as:290-342`) | if any offered chest has `Quality == 5`, confirm "Ainda não escavou o tesouro dourado, deseja atualizar?"; cost = `refresh_cost[min(refreshTimes, 4)]` with `consortia_treasure_refresh_cost = 0,0,10,20,50`; when cost > 0 confirm "Deseja consumir {0} diamantes para atualizar tesouros?" and require `point >= cost` else recharge dialog | 390 op 3 (client then sends T0). `payType` is always -1 (server decides price from `refreshTimes`) |
| T4 | 4 `OPEN_TREASURE` (dig) free | free button when the free timer is done (`TV/TreasureListItem.as:126-137`, enabled by `TreasureListView.refesh` `:198-221`) | `leftCount > 0` else "Nº de escavações restantes insuficientes." | 390 op 4 with `myTreasures[0]` = the new chest and `errorID`; client shows "Escavou {0} tesouro(s) com sucesso" (0) or "Falha ao escavar" and sends T0 (`TV/TreasureListView.as:239-252`) |
| T4p | 4 paid, `payType = 1` | price button (`TV/TreasureListItem.as:139-176`) | `leftCount > 0`; confirm "Deseja consumir {0} diamantes para escavar tesouros?" with `consortia_treasure_open_cost = 20`; `playerInfo.point >= 20` (real diamonds only) else recharge | same as T4 |
| T5 | 5 `HELP_OPEN_TREASURE` | help tab "Abrir" (`TV/TreasureHelpItem.as:264-275`) | `helpLeftCount > 0` else "Auxílios restantes insuficientes."; button disabled while the player already helps another chest (any item with status 1, `TV/TreasureHelpView.as:116-124`,`:187-197`) | 390 op 5; `errorID == 3` shows "Este tesouro desapareceu" (`CM:1506-1512`); client sends T2 |
| T6 | 6 `GET_REWARD` | owner claim (`TV/MyTreasureItem.as:181-184`, status 2) or helper claim (`TV/TreasureHelpItem.as:258-262`, status 2) | none | 390 op 6; client sends T1 and T2 (`CM:1513-1515`) ; bag 115 and player info 3 for the rewards |
| T7 | 7 `SPEED_UP`, `payType = 1` | helper speed up (`TV/TreasureHelpItem.as:230-256`) | cost = `speed_up_cost[0] * ceil(remaining_seconds / 600)` with `consortia_treasure_speed_up_cost = 2,10`; `point >= cost` else recharge | 390 op 7; client sends T2 |
| T8 | 8 `REQUEST_HELP` | owner "Pedir ajuda" (`TV/MyTreasureItem.as:186-191`) | at most 1 request per chest (`_HelpMaxTime = 1`, `:58`, `:173-179`) | 390 op 8 is not handled by the switch (`CM:1404-1521`); server must post a guild chat message with link type 114 whose payload `userId` field carries the `treasureId` (used as `helpOpenId`, compared with `treasureId` in `TreasureHelpView.selectID` `:158-185`) |
| T9 | 9 `HELP_INFO` | never sent by the client | | server push 390 op 9 makes the list view refresh (`CM:1519-1520`) |

## Server messages

390 (0x0186) `U_C_CONSORTIA_TREASURE`, `ConsortiaTreasureOpMsg`, handler `CM.__updateTreasureHandler` (`CM:1368-1522`, listener `CM:180`). Always read: `payType` (#2), `treasureId` (#3), `errorID` (#4).

- `errorID == 5` (`LACK_CONSORTIA_TIME`): sets `treasureGroupInfo.NoOpen = true`, dispatches the list or help event for ops 0/2 and returns (`CM:1391-1403`); list view shows "Tempo de entrada da guilda inferior a 24h." and disables tabs (`TV/TreasureListView.as:141-148`).
- op 0: `teasurePageInfo` `TreasurePageMsg`: `leftCount` (#1, INT32) digs left today; `freeTime` (#2, STRING `YYYY-MM-DD hh:mm:ss`) moment the next free dig is available; `freeTemplateSecond` (#3, INT32) full length of the free cooldown for the progress bar; `refreshTimes` (#4, INT32) manual refreshes used today; `treasures` (#5, repeated `TreasuresMsg`: `treasureId` (#1) slot id, `treasureTemplateId` (#2)). If `leftCount > 0`, `now >= freeTime` and the guild frame is closed the client shows tip 51 (`CM:1406-1433`).
- op 1: `myTreasures` (#6) repeated `MyTreasuresMsg`: `treasureId` (#1), `openTime` (#2, STRING dig time), `treasureTemplateId` (#3), `helperName` (#4, STRING, empty when no helper), `requestHelpCount` (#5, INT32), `status` (#6, INT32: 0 waiting for help, 1 helped and running, 2 claimable). Status 2 shows tip 51 (`CM:1434-1456`).
- op 2: `helpList` (#7) `HelpListPageMsg`: `leftCount` (#1, INT32) helps left today; `othersTreasures` (#2, repeated `OthersTreasuresMsg`: `treasureId` (#1), `openTime` (#2, STRING; the client stores it in a `Number` field, `decompiled/core_module/scripts/mvc/module/consortia/OthersTreasureInfo.as`, so the status 0 countdown is NaN client side), `treasureTemplateId` (#3), `ownerName` (#4), `ownerHeadId` (#5, avatar head id), `helperRewardTime` (#6, STRING time the helper reward is ready), `status` (#7: 0 can help, 1 I am helping, 2 my helper reward is claimable)). Sorted by status then quality (`CM:1583-1606`).
- op 3: dispatch `REFRESH` (client resends op 0).
- op 4: `myTreasures` (#6) with the dug chest; `errorID` 0 success.
- op 5: `errorID == 3` -> "Este tesouro desapareceu".
- op 6, 7: dispatch only.
- op 9: dispatch `OPEN_TREASURES`.

Error codes `ErrorID` (`PROTO/ErrorID.as`): 0 `NO_ERROR`, 1 `FAILED`, 2 `LACK_POINT`, 3 `ALREADY_OPENED`, 4 `LACK_GRADE`, 5 `LACK_CONSORTIA_TIME`, 6 `LACK_OPEN_COUNT`, 7 `LACK_HELP_COUNT`, 8 `LACK_REQ_HELP_COUNT`. Only 3 and 5 have specific client reactions; any non zero on op 4 shows "Falha ao escavar".

Related pushes: 115 (0x0073) `U_C_BAG_MOVE_UPDATE` for item rewards, 3 (0x0003) `U_C_PLAYER_INFO` for gold (-100), Espírito/strategy (-300), Cristal de Luz (-600) and diamonds; yellow crystals (-4100) through the player currency update used by `PlayerCurrencyManager` (cross dependency, currency module).

## Rules and formulas

- Op enum `ConsortiaTreasureOpType` (`PROTO/ConsortiaTreasureOpType.as`): 0 OPEN_TREASURES, 1 OPEN_MY_TREASURES, 2 OPEN_OTHERS_TREASURES, 3 REFRESH, 4 OPEN_TREASURE, 5 HELP_OPEN_TREASURE, 6 GET_REWARD, 7 SPEED_UP, 8 REQUEST_HELP, 9 HELP_INFO.
- Daily limits: `consortia_treasure_Count = 8,8` (digs, helps) (`CM:1566-1570`). Assumption: reset at 00:00 server time together with `refreshTimes`.
- Manual refresh price by count used today: 0, 0, 10, 20, 50 and 50 afterwards (`TV/TreasureListView.as:161-175`).
- Automatic offer refresh at every even UTC hour (countdown `7200 - ((hourUTC % 2) * 3600 + min*60 + sec)`, `TV/TreasureListView.as:153-156`).
- Paid dig: 20 diamonds (real diamonds checked client side). Free dig: when `now >= freeTime`; after a free dig the server sets a new `freeTime = now + freeTemplateSecond` (assumption, cadence not in client data).
- Owner timeline: deadline = `openTime + RewardSeconds`. Status 0 at deadline -> chest removed. Status 1 at deadline -> status 2, owner claims `Drop` (`TV/MyTreasureItem.as:111-154`,`:193-212`).
- Helper timeline: on help the server sets `helperRewardTime = now + RewardSeconds` (assumption from the progress bar total `RewardSeconds`, `TV/TreasureHelpItem.as:199-209`); at that time status 2, helper claims `HelperDrop`. Speed up price `2 * ceil(remaining/600)` diamonds and makes the reward claimable immediately.
- One concurrent help per player (client side, enforce server side too).
- A player cannot help his own chest (assumption; the help list should exclude own chests).
- Quest hook: condition type 8 "Coletar N Tesouro(s) da Guilda" (`quests.md`) counts collected chests (assumption: owner claims).
- Icons: `<resource>/icon/treasure/{Type}_{Quality}.png` (`TV/TreasureListItem.as:95`).

## Templates

`raw/xml/tempinfos/ConsortiaTreasureTempInfos.xml` via `ConsortiaTreasureTemplateCate` (`decompiled/core_module/scripts/yishi/datas/templates/cate/ConsortiaTreasureTemplateCate.as`), fields `TemplateId`, `TemplateName`, `Type` (1 Baú de Ouro, 2 Baú dos Espíritos, 3 Baú de Cristais de Luz, 4 Baú de Gemas), `Quality` 1..5, `RewardSeconds` (3600, 7200, 14400, 28800, 86400 for quality 1..5), `Drop` and `HelperDrop` as `itemId,count|...` (negative id = currency).

| Id | Type | Q | Main drop | Helper main drop |
|---|---|---|---|---|
| 1..5 | Ouro | 1..5 | -100 gold 200000 / 400000 / 800000 / 2000000 / 6000000 + 208017 Pedra Bestial 5/10/20/50/150 + 2040109 Gema da Sorte Nv. 9 1/2/4/10/30 + -4100 Cristais amarelos 10/20/40/100/300 + 2030703 Livro de EXP Nv. 3 10/20/40/100/300 | 80% of each (gems 1,2,3,8,24) |
| 6..10 | Espíritos | 1..5 | -300 Espírito 200000 .. 6000000 + same extras | 80% |
| 11..15 | Cristais de Luz | 1..5 | -600 Cristal de Luz 20000 / 40000 / 80000 / 200000 / 600000 + same extras | 80% |
| 16 | Gemas | 3 | -4100 x80 + 3120005, 3120605, 2240605, 2050605 x1 | -4100 x64 + same gems |
| 17 | Gemas | 4 | -4100 x160 + 3120006, 3120606, 2240606, 2050606 x1 | -4100 x128 + same gems |

Config (`raw/xml/tempinfos/ConfigInfos.xml`): `consortia_treasure_refresh_cost`, `consortia_treasure_open_cost`, `consortia_treasure_Count`, `consortia_treasure_speed_up_cost`. Offer generation weights per quality are not in the client (open question).

## Persistent state

```sql
CREATE TABLE guild.member_treasure_state (
  player_id          INTEGER   PRIMARY KEY REFERENCES public.player(id) ON DELETE CASCADE,
  day                DATE     NOT NULL,
  digs_used          SMALLINT NOT NULL DEFAULT 0 CHECK (digs_used >= 0),
  helps_used         SMALLINT NOT NULL DEFAULT 0 CHECK (helps_used >= 0),
  refreshes_used     SMALLINT NOT NULL DEFAULT 0 CHECK (refreshes_used >= 0),
  next_free_dig_at   TIMESTAMPTZ NOT NULL,
  offer_generated_at TIMESTAMPTZ NOT NULL
);

CREATE TABLE guild.member_treasure_offer (
  player_id   INTEGER   NOT NULL REFERENCES public.player(id) ON DELETE CASCADE,
  slot_id     INTEGER  NOT NULL,
  template_id SMALLINT NOT NULL,
  PRIMARY KEY (player_id, slot_id)
);

CREATE TABLE guild.treasure (
  id                  BIGSERIAL PRIMARY KEY,
  guild_id            INTEGER   NOT NULL REFERENCES guild.guild(id) ON DELETE CASCADE,
  owner_id            INTEGER   NOT NULL REFERENCES public.player(id) ON DELETE CASCADE,
  template_id         SMALLINT NOT NULL,
  dug_at              TIMESTAMPTZ NOT NULL,
  expires_at          TIMESTAMPTZ NOT NULL,
  help_requests       SMALLINT NOT NULL DEFAULT 0 CHECK (help_requests BETWEEN 0 AND 1),
  helper_id           INTEGER   REFERENCES public.player(id) ON DELETE SET NULL,
  helped_at           TIMESTAMPTZ,
  helper_reward_at    TIMESTAMPTZ,
  owner_claimed_at    TIMESTAMPTZ,
  helper_claimed_at   TIMESTAMPTZ,
  CHECK (helper_id IS NULL OR helper_id <> owner_id)
);
CREATE INDEX treasure_owner_idx ON guild.treasure (owner_id) WHERE owner_claimed_at IS NULL;
CREATE INDEX treasure_guild_open_idx ON guild.treasure (guild_id) WHERE helper_id IS NULL;
CREATE INDEX treasure_helper_idx ON guild.treasure (helper_id) WHERE helper_claimed_at IS NULL;
```

Derived status for the owner: 0 when `helper_id IS NULL AND now < expires_at`; 1 when helped and `now < expires_at`; 2 when helped and `now >= expires_at` and not claimed. Rows with no helper after `expires_at` are deleted (or hidden). Helper status: 0 not helped yet (row visible to all guild mates), 1 `helper_id = me AND now < helper_reward_at`, 2 `now >= helper_reward_at` and not claimed.

## Backend implementation notes

Single entry `guild::treasure::handle_op` (9629) dispatching to:
- `guild::treasure::handle_list` (op 0), `handle_my_list` (op 1), `handle_help_list` (op 2), `handle_refresh` (op 3), `handle_dig` (op 4), `handle_help_open` (op 5), `handle_claim` (op 6), `handle_speed_up` (op 7), `handle_request_help` (op 8).

Common validation: player in a guild; membership age (`now - guild.member.joined_at`, `membership.md`) >= 24 h else reply op with `errorID = 5`; lazily roll the daily row (`day` change resets counters) and the offer list (regenerate when the last even UTC hour passed).

- Dig: offer slot exists -> `digs_used < 8` (else 6) -> free if `now >= next_free_dig_at` else charge 20 diamonds when `payType = 1` (else 2 `LACK_POINT`) -> insert `guild.treasure` with `expires_at = now + RewardSeconds`, remove offer slot, bump counters, set `next_free_dig_at` when free. Reply op 4 with the chest, push 3 for diamonds.
- Help open: chest in same guild, not own, no helper (else 3), `helps_used < 8` (else 7), player has no running help -> set helper, `helped_at`, `helper_reward_at = now + RewardSeconds`. Reply op 5; push 390 op 1 to the owner if online (assumption) so the owner sees the helper.
- Claim: owner path requires status 2 and grants `Drop`; helper path requires helper status 2 and grants `HelperDrop`; mark claimed, grant items in one transaction (bag 115, player 3, currency push), update quest condition 8 for owners. Reply op 6.
- Speed up: helper of a running chest, price `2 * ceil(remaining/600)`, set `helper_reward_at = now`. Reply op 7, push 3.
- Request help: owner, `help_requests < 1` (else 8) -> increment and broadcast a guild chat message link type 114 with the treasure id. Reply op 8 (ignored by client).
- Refresh: price by `refreshes_used`, charge diamonds (bound first, assumption), regenerate offers, increment. Reply op 3, push 3.
- Expiry job (or lazy on read): delete unhelped chests past `expires_at`.

## Open questions

- Offer list size and quality weights; whether the system refresh keeps undug chests.
- Free dig cadence (`freeTemplateSecond`) and whether the first dig of the day is free.
- Whether refresh and speed up accept bound diamonds.
- Whether 390 op 8 should carry an error when the request limit is reached (client ignores it).
- Exact chat message format for the help link (chat module).

## Implementation checklist

- [ ] Client screen: ConsortiaTreasureFrame with three tabs and red counters
- [ ] Client screen: TreasureListView offer list, free progress, refresh price
- [ ] Client screen: MyTreasureView statuses 0/1/2 and timers
- [ ] Client screen: TreasureHelpView help, speed up, claim
- [ ] Table `guild.member_treasure_state`
- [ ] Table `guild.member_treasure_offer`
- [ ] Table `guild.treasure`
- [ ] Template loader `ConsortiaTreasureTempInfos.xml` and config keys
- [ ] Handler `guild::treasure::handle_op` (9629 -> 390)
- [ ] Sub handlers ops 0..8 with `ErrorID` codes
- [ ] 24 h membership check (needs join time from core module)
- [ ] Guild chat link type 114 on request help (chat module)
- [ ] Reward grant: bag items (115), gold/strategy/crystal/diamonds (3), yellow crystals currency push
- [ ] Daily reset of digs, helps, refreshes; even UTC hour offer regeneration
- [ ] Expiry cleanup of unhelped chests
