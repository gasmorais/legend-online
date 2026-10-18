# Lord Trial ("Julgamento Principal")

Area: trials, module `lord-trial`. Client package `lordtrial` (`decompiled/m11/scripts/lordtrial`), manager `yishi.manager.LordTrialManager`, model `mvc.module.lordtrial.LordTrialModel`, controller key `lordtrial`, proto package `lordtrial`. Includes the prayer ("Orar"), the weekly ranking and the sweep ("BOT do Julgamento", frames of the [mopup](../mopup/README.md) package, openType 9 and 10).

Path aliases:

| Alias | File |
|---|---|
| LTM | `decompiled/core_module/scripts/yishi/manager/LordTrialManager.as` |
| LTMOD | `decompiled/core_module/scripts/mvc/module/lordtrial/LordTrialModel.as` |
| LTC | `decompiled/core_module/scripts/mvc/controler/LordTrialController.as` |
| MF | `decompiled/m11/scripts/lordtrial/LordTrialMainFrame.as` |
| PF | `decompiled/m11/scripts/lordtrial/pray/LordTrialPrayFrame.as` |
| RF | `decompiled/m11/scripts/lordtrial/rank/LordTrialRankFrame.as` |
| MPF | `decompiled/m5/scripts/mopup/view/LordTrialMopupPrepareFrame.as` |
| MIF | `decompiled/m5/scripts/mopup/view/LordTrialMopupIngFrame.as` |
| TC | `decompiled/core_module/scripts/yishi/datas/templates/cate/LordTrialTempCate.as` |

## 1. Overview

Weekly PvE climb with 3 difficulties ("Dificuldade 1..3", type 0..2) of 30 floors each (every 5th floor is a boss floor). Each floor costs 1 "Chaves do Julgamento" (virtual item -4300) and is a battle of type 3869 `LORD_TRIAL_BATTLE`. The hero HP percentage carries over between floors; at 0 the player cannot fight until a reset. The first fight locks the difficulty and the guardian/Einherjar used ("Após iniciar desafio ou modo bot, não poderá alterar dificuldade"). Keys come from the daily prayer: 5 cards, each with a 25% chance to hold a key; sacrifices re-roll the empty cards. The best floor per difficulty is ranked weekly (top 100) with rank rewards. A sweep mode clears already reached floors over time (30 s per floor, 10000 gold per floor) with optional diamond acceleration.

Weekly calendar (help text `lordtrial.helperFrame_helpTxt`): the season runs from Monday 1:00 to Sunday 23:00; between Sunday 23:00 and Monday 1:00 the trial is closed for settlement (`LTMOD.isInActivity`, `LTMOD:80-96`). Keys are zeroed every Sunday 23:59 and reset cannot be used on Monday ("Todas as segundas feiras, não é possível efetuar redefinação"). Prayer and sacrifice counts reset daily at 0:00.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `lordtrial.LordTrialMainFrame` (`MF:128`), 785 x 558 | "Julgamento Principal" | Difficulty selector (prev/next), floor number, boss frame each 5 floors, floor drops, difficulty debuffs, hero HP bar (`LordTrialHPExpView`), key count, my rank, buttons "Desafiar", "Modo Bot", "Orar", "Redefinir", "Ranking", help | controller `lordtrial` openType 0 (`LTC:37-52`) via `SwitchPageHelp.openLordTrailFrame` (`decompiled/core_module/scripts/yishi/SwitchPageHelp.as:2311-2329`); reopened after a 3869 battle (`decompiled/m3/scripts/map/space/SpaceSceneController.as:314-317`) | 445 fields stored on `PlayerInfo` |
| `lordtrial.pray.LordTrialPrayFrame` (`PF:57`), 534 x 488 | "Orar" | 5 cards, prayers left, sacrifices left, reward preview by keys found, "Iniciar Oração", "Terminar", "Continuar Sacrifício" | `MF.__prayerBtnHandler` (`MF:503-512`) | `prayCount`, `sacrificeCount`, `cards`, `prayStatus` |
| `lordtrial.rank.LordTrialRankFrame` (`RF:87`), 460 x 495 | "Ranking"; columns rank, name, "Pisos atingidos"; note "O rank é atualizado a cada 1 hora." | 3 tabs (difficulty), 8 rows per page, my rank, reward tip (`LordTrialRankRewardTipView` with `getRankRewrad(100 + tab)`) | `MF.__rankBtnHandler` (`MF:536-540`) | HTTP XML `lordtrial_unzip.xml` |
| `mopup.view.LordTrialMopupPrepareFrame` (`MPF`) | "BOT do Julgamento" | Choose target floor, shows time, gold and keys needed, VIP tip "Ao ativar o contrato do elfo poderá usar o modo bot gratuitamente" | `MF.__mopupBtnHandler` -> controller `mopup` openType 9 (`MF:486-501`) | `maxIndexs[type]`, config |
| `mopup.view.LordTrialMopupIngFrame` (`MIF`) | "BOT do Julgamento" | Running sweep: floor results with items, remaining time, accelerate, cancel | `LTMOD.mopupCount` setter when `sweepIndex > 0` -> controller `mopup` openType 10 (`LTMOD:57-68`) | 445 op 9 pushes |

## 3. Routes (client to server)

All routes: send 9650 (0x25b2) `C_LORD_TRIAL_OP` with `lordtrial.LordTrialOpMsg`. Only the fields listed are set by the client.

`LordTrialOpMsg` fields: `op` (#1, ENUM `LordTrialOpType`); `payType` (#2, INT32); `errorID` (#3, ENUM `ErrorID`); `debuffs` (#4, STRING, repeated); `sweepIndex` (#5, INT32); `nowType` (#6, INT32); `nowIndex` (#7, INT32); `resetTime` (#8, STRING); `items` (#9, STRING); `petId` (#10, INT32); `childPetId` (#11, INT32); `secondChildPetId` (#12, INT32); `childId` (#13, INT32); `secondChildId` (#14, INT32); `hpPercent` (#15, INT32); `keyCount` (#16, INT32); `prayCount` (#17, INT32); `sacrificeCount` (#18, INT32); `cards` (#19, STRING); `maxIndexs` (#20, INT32, repeated); `orders` (#21, INT32, repeated); `indexItems` (#22, STRING); `prayStatus` (#23, INT32).

`LordTrialOpType` (`decompiled/core_module/scripts/com/road/yishi/proto/lordtrial/LordTrialOpType.as`): 0 OPEN, 1 RESET, 2 PRAY, 3 FINISH_PRAY, 4 SACRIFICE, 5 FIGHT, 6 SWEEP, 7 CANCEL_SWEEP, 8 SPEED_SWEEP, 9 SWEEP_ITEM (server only).

| # | UI control | Client sender | Client checks | Request fields | Response |
|---|---|---|---|---|---|
| L1 | Frame open; every 30 s while sweeping | `LordTrialManager.openMainFrame` (`LTM:38-44`) from `MF:136` and `MIF.__timeCompleteHandler` (`MIF:269-288`) | open: hero changed job ("Esta habilidade só poderá ser activada depois de ser transferida"), scene is castle or space ("O cenário atual não é possível participar deste evento"), `isInActivity` ("Julgamento em modo de avaliação, na segunda às 1h será liberado novamente.") (`SwitchPageHelp.as:2311-2329`) | `op = 0` | 445 full state |
| L2 | "Redefinir" | `LordTrialManager.reset` (`LTM:46-52`) from `MF:514-522` | `isInActivity`; button enabled only when a difficulty is locked (`MF:400-404`) | `op = 1` | 445 with `errorID = 0` ("Redefinido com sucesso") or `errorID = 8` ("Hoje já redefiniu, não é possível efetuar esta operação novamente.") |
| L3 | "Iniciar Oração" | `LordTrialManager.startPray` (`LTM:54-60`) from `PF:199-207` | prayers left `> 0` ("Número de orações insuficientes, não é possível orar") | `op = 2` | 445 with `prayStatus = 1`, `cards` |
| L4 | "Terminar" | `LordTrialManager.endPray` (`LTM:62-68`) from `PF:209-213` (frame closes) | none | `op = 3` | 445 with `prayStatus = 0`, keys and rewards granted |
| L5 | "Continuar Sacrifício" | `LordTrialManager.sacrifice` (`LTM:70-76`) from `PF:215-228` | sacrifices left `> 0` ("Sacrifícios insuficientes, não é possível sacrificar"); `cards` contains a "0" ("Já obteve o melhor prêmio, não é possível sacrificar.") | `op = 4` | 445 with new `cards` |
| L6 | "Desafiar" | `LordTrialManager.enterBattle(type, index)` (`LTM:78-86`) after the enter animation (`MF:542-587`) | `isInActivity`; `hpPercent > 0` ("Sangue: 0, não é possível desafiar"); `keyCount > 0` ("Chaves de Julgamento insuficientes, não é possível desafiar"); `currentIndex <= 30` ("Já atingiu o piso máximo") | `op = 5`, `nowType` = difficulty 0..2, `nowIndex` = floor to fight (1..30) | battle 3869 (157 ...), then 445 after the battle |
| L7 | "Iniciar" in the sweep prepare frame | `LordTrialManager.sendMopup(type, floor)` (`LTM:88-96`) from `MPF:238-288` | `isInActivity`, not in outer city ("No cenário atual não é possível usar o Modo BOT", `MF:493-497`); floor `> 0`, `>= currentIndex`, `<= maxIndexs[type]` ("Piso do Modo Bot ..."); gold `>= floors x 10000` ("Ouro insuficiente"); keys `>= floors` ("Chaves do Julgamento insuficientes") | `op = 6`, `nowType`, `sweepIndex` = target floor | 445 with `sweepIndex > 0` (opens the running sweep frame), then 445 op 9 per floor |
| L8 | Sweep frame closed or "Cancelar" (confirm "Cancelar Modo Bot?") | `LordTrialManager.cancelMopup` (`LTM:98-104`) from `MIF.dispose` (`MIF:605-607`) | none | `op = 7` | 445 with `sweepIndex = 0` |
| L9 | "Acelerar" | `LordTrialManager.speedMopup(payType)` (`LTM:106-113`) from `MIF:414-474` | king contract buff 4 active: send `payType = 1` with no cost dialog; else confirm "Aceleramento consome {0} diamantes" with cost `(sweepIndex - currentIndex + 1) x 5`; bind point checkbox checked -> `payType = 0`, unchecked -> 1 | `op = 8`, `payType` | 445 op 9 for every remaining floor, then 445 with `sweepIndex = 0` |
| L10 | Ranking frame open | `LordTrialController.loadRankXML` (`LTC:54-59`) | none | HTTP GET `{TPL}lordtrial_unzip.xml` (`PathManager.orderPath`) | XML (see 4.2) |

## 4. Server messages (server to client)

### 4.1 445 (0x01bd) `U_C_LORD_TRIAL`

Message `lordtrial.LordTrialOpMsg` (fields above). Receiver `LordTrialManager.__lordTrialInfoHandler` (`LTM:136-193`).

| Case | Fields read | Client reaction |
|---|---|---|
| `errorID == 8` (LACK_RESET_COUNT) | none | tip "Hoje já redefiniu ..." and stop (`LTM:146-150`) |
| `errorID == 0` and `op == 1` | as default | tip "Redefinido com sucesso" (`LTM:151-154`) then default |
| `op == 9` (SWEEP_ITEM) | `nowType`, `nowIndex` floor just swept, `indexItems` (`"tid,count|tid,count"`) | `currentType = nowType`, `currentIndex = nowIndex + 1`, appends `{count: nowIndex, items}` to `mopupList`, sweep frame lists "Piso {0}" with items (`LTM:155-164`, `MIF:290-372`) |
| default (any other op) | `sweepIndex` -> `model.mopupCount` (opens openType 10 when > 0); `keyCount`; `prayCount` used today; `sacrificeCount` used today; `cards` (5 CSV values 0/1); `hpPercent` 0..100; `petId`, `childPetId`, `secondChildPetId`, `childId`, `secondChildId` locked companions; `nowType` (-1 none locked, 0..2); `nowIndex` (last cleared floor, client shows `nowIndex + 1`); `maxIndexs` (3 values, best floor per difficulty this week); `orders` (3 values, rank per difficulty, 0 or > 100 = unranked "Novato"); `items`; `debuffs` (3 strings, CSV of skill template ids shown as difficulty modifiers); `prayStatus` (0 idle, 1 cards dealt) | stores on `PlayerInfo` and fires `UPDATE_VIEW` (`LTM:165-191`) |

`ErrorID` values (`decompiled/core_module/scripts/com/road/yishi/proto/lordtrial/ErrorID.as`): 0 NO_ERROR, 1 FAILED, 2 LACK_POINT, 3 UNOPEN, 4 NEED_TRANSFER, 5 LACK_PRAY_COUNT, 6 LACK_SACRIFICE_COUNT, 7 HP_ZERO, 8 LACK_RESET_COUNT, 9 LACK_KEY, 10 ALL_CARD_CROSS, 11 NOT_FIGHT_TIME, 12 IN_SWEEP, 13 LACK_GOLD. Only 8 has a client message; for the others the server should answer with the unchanged state.

`resetTime` (#8) and `items` (#9) are read but never displayed.

### 4.2 Ranking XML (`{TPL}lordtrial_unzip.xml`)

Parsed by `LordTrialController.resolveRankXML` (`LTC:73-121`):

```xml
<Root>
  <LordTrialOrder0><LordTrialOrder Order="1" NickName="..." Index="30" IsVip="true"/>...</LordTrialOrder0>
  <LordTrialOrder1>...</LordTrialOrder1>
  <LordTrialOrder2>...</LordTrialOrder2>
</Root>
```

`Order` rank, `NickName`, `Index` best floor, `IsVip`; group N = difficulty N. Regenerated hourly ("O rank é atualizado a cada 1 hora.").

## 5. Rules and formulas

- Difficulties 0..2, floors 1..30; boss floors when `floor % 5 == 0` (`MF:425-432`, `:564-571`).
- Fight cost: 1 key per floor (help point 4; sweep prepare uses `floors` keys, `MPF:276-281`).
- HP: `hpPercent` decreases with the damage taken and persists; reset restores 100 (assumption: reset restores HP, help point 3 "o status e o andar voltam a ser como era no estado inicial").
- Reset (op 1): once per day (`errorID 8`), not on Mondays; clears `nowType = -1`, `nowIndex = 0`, HP 100, unlocks companions; keeps `maxIndexs`.
- Companions: at the first fight the server stores the current guardian (`childId`, `secondChildId`) and Einherjar (`petId`, `childPetId`, `secondChildPetId`); in battle the client uses `LordTrialModel.getChildData()` for the child skill bar (`decompiled/core_module/scripts/battle/view/ui/SkillItemListController.as:280-296`).
- Floor rewards: `LordTrialTempInfos.xml` rows with `para1 = difficulty` and `para2` = floor or `min,max` range (`TC:53-116`).
- Prayer (`ConfigInfos.lord_trial_pray_templates = 3,3,25`): 3 prayers per day, 3 sacrifices per day, 25% chance per card to be a key (`PF:95-112`). Prayer deals 5 cards; sacrifice re-rolls the cards that are 0 and keeps the 1 cards; finishing grants rows `para1 = 200`, `para2 = number of key cards` (0..5), e.g. 5 keys -> 5 x item -4300, 20 x 212018, 5 x 212015 (`TC:118-149`).
- Weekly reward per difficulty by final rank: rows `para1 = 100 + difficulty`, `para2 = rank range` (1-10, 11-20, 21-50, 51-100) (`decompiled/m11/scripts/lordtrial/rank/LordTrialRankRewardTipView.as:66`).
- Sweep (`ConfigInfos.lord_trial_sweep_templates = 30,10000,5`): 30 s per floor, 10000 gold per floor, 5 diamonds per remaining floor to accelerate; keys and gold are deducted floor by floor ("não irá descontar tudo de uma vez"); sweep can run offline; floors swept give the floor rewards. King contract buff 4 makes acceleration free.
- Sweep target: `currentIndex <= target <= maxIndexs[type]`.
- Season closed: Sunday 23:00 to Monday 0:59 (`isInActivity`); sweep stops if the next tick falls in that window (`MIF:233-252`).
- Entry points: daily guide type 87 (`decompiled/core_module/scripts/managers/DayGuideManager.as:942-943`), space NPC dialog option 117 (`decompiled/m3/scripts/map/space/view/frame/DialogOptionItem.as:773-774`), queue bar (controller `lordtrial` 0).

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `raw/xml/tempinfos/LordTrialTempInfos.xml` (`LordTrialDropInfo`, 90 rows) | drop and reward rows | `id`; `para1` 0..2 floor rewards per difficulty, 100..102 weekly rank rewards per difficulty, 200 prayer rewards; `para2` floor, rank or key count, single value or `min,max`; `itemId` (-4300 = "Chaves do Julgamento"); `count`; `isBind`; `appearType`; `validDate` |
| `raw/xml/tempinfos/ConfigInfos.xml` | `lord_trial_pray_templates` = `3,3,25`; `lord_trial_sweep_templates` = `30,10000,5` | see rules |
| `raw/xml/tempinfos/ItemTempInfos.xml` | `TemplateId="-4300"` "Chaves do Julgamento" (`SonType 208`) | key currency |
| `raw/xml/tempinfos/SkillTempInfos.xml` | debuff skill descriptions | `Description` |

Boss and monster composition per floor is not in the client templates (open question).

## 7. Persistent state

```sql
CREATE TABLE trials.lord_trial_state (
    player_id          integer     PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
    season_week        date        NOT NULL,
    key_count          integer     NOT NULL DEFAULT 0 CHECK (key_count >= 0),
    current_type       smallint    NOT NULL DEFAULT -1 CHECK (current_type BETWEEN -1 AND 2),
    current_floor      smallint    NOT NULL DEFAULT 0 CHECK (current_floor BETWEEN 0 AND 30),
    hp_percent         smallint    NOT NULL DEFAULT 100 CHECK (hp_percent BETWEEN 0 AND 100),
    pet_id             integer     NOT NULL DEFAULT 0,
    child_pet_id       integer     NOT NULL DEFAULT 0,
    second_child_pet_id integer    NOT NULL DEFAULT 0,
    child_id           integer     NOT NULL DEFAULT 0,
    second_child_id    integer     NOT NULL DEFAULT 0,
    pray_used          smallint    NOT NULL DEFAULT 0,
    sacrifice_used     smallint    NOT NULL DEFAULT 0,
    pray_status        smallint    NOT NULL DEFAULT 0 CHECK (pray_status IN (0, 1)),
    cards              text        NOT NULL DEFAULT '0,0,0,0,0',
    last_reset_date    date,
    daily_date         date        NOT NULL DEFAULT current_date,
    updated_at         timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE trials.lord_trial_best (
    player_id     integer  NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
    season_week   date     NOT NULL,
    difficulty    smallint NOT NULL CHECK (difficulty BETWEEN 0 AND 2),
    best_floor    smallint NOT NULL DEFAULT 0 CHECK (best_floor BETWEEN 0 AND 30),
    reached_at    timestamptz NOT NULL DEFAULT now(),
    PRIMARY KEY (player_id, season_week, difficulty)
);
CREATE INDEX lord_trial_best_rank_idx ON trials.lord_trial_best (season_week, difficulty, best_floor DESC, reached_at);

CREATE TABLE trials.lord_trial_sweep (
    player_id     integer     PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
    difficulty    smallint    NOT NULL CHECK (difficulty BETWEEN 0 AND 2),
    target_floor  smallint    NOT NULL,
    next_floor    smallint    NOT NULL,
    next_tick_at  timestamptz NOT NULL,
    started_at    timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE trials.lord_trial_rank_reward (
    season_week   date     NOT NULL,
    difficulty    smallint NOT NULL,
    player_id     integer  NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
    rank          smallint NOT NULL CHECK (rank BETWEEN 1 AND 100),
    granted_at    timestamptz NOT NULL DEFAULT now(),
    PRIMARY KEY (season_week, difficulty, player_id)
);
```

## 8. Backend implementation notes

- Handlers: `trials::lord_trial::handle_open` (op 0), `handle_reset` (1), `handle_pray` (2), `handle_finish_pray` (3), `handle_sacrifice` (4), `handle_fight` (5), `handle_sweep` (6), `handle_cancel_sweep` (7), `handle_speed_sweep` (8). Every handler answers 445 with the full state (`build_state`), `op` echoed, `errorID` set.
- Validation order for fight: season open, job changed, not sweeping (12), keys > 0 (9), hp > 0 (7), floor <= 30, `nowType` equals the locked type or no type locked, `nowIndex == current_floor + 1`.
- Fight: deduct 1 key, lock type and companions on the first fight, start battle 3869 (map and monsters from server configuration; boss floor every 5). On victory: `current_floor += 1`, update `lord_trial_best`, grant floor rewards, store new `hp_percent` (hero HP left / max). On defeat: `hp_percent = 0` (assumption). Send 445 after the battle report.
- Prayer: op 2 requires `pray_used < 3` and `pray_status = 0`; roll 5 cards with p = 0.25; op 4 requires `pray_status = 1`, `sacrifice_used < 3`, a 0 card; op 3 grants rows `para1 = 200, para2 = keys` in one transaction (keys go to `key_count`) and sets `pray_status = 0`.
- Sweep: a scheduler ticks every 30 s per active sweep: deduct 10000 gold and 1 key, grant floor rewards, advance floor, push 445 op 9 with `nowIndex` and `indexItems` if online; stop at target, when gold or keys run out, or when the season closes. Speed (op 8): cost `remaining x 5` diamonds (or bound diamonds for `payType 0`, free with king contract buff 4), process all remaining floors at once.
- Schedules: daily 0:00 reset of `pray_used`, `sacrifice_used`; Sunday 23:00 close season, compute ranks per difficulty, grant rank rewards by mail (assumption), Sunday 23:59 zero `key_count`; Monday 1:00 open the new season with fresh `lord_trial_best` rows and `current_type = -1`.
- Ranking file: regenerate `lordtrial_unzip.xml` hourly from `lord_trial_best` (top 100 per difficulty) and serve it under the `{TPL}` path.

## 9. Open questions and assumptions

- Assumption: defeat sets HP to 0 versus partial HP loss; the client only shows `hpPercent`.
- Assumption: rank rewards are mailed at season close.
- Floor monster composition, map id and boss data are not in the client.
- `debuffs` content per difficulty (skill ids) must come from server configuration; unknown values.
- Whether a reset also refunds keys or restores companions selection is not documented beyond the help text.
- `payType` mapping (0 bound diamonds, 1 diamonds) is inferred from the checkbox handling in `MIF:453-474`.

## 10. Implementation checklist

- [ ] Tables `trials.lord_trial_state`, `lord_trial_best`, `lord_trial_sweep`, `lord_trial_rank_reward`
- [ ] Template loader `LordTrialTempInfos.xml`, config keys `lord_trial_pray_templates`, `lord_trial_sweep_templates`
- [ ] L1 open -> 445
- [ ] L2 reset with daily limit and Monday block (errorID 8)
- [ ] L3, L4, L5 prayer flow and rewards
- [ ] L6 fight -> battle 3869 -> 445
- [ ] L7, L8, L9 sweep with scheduler and 445 op 9 pushes
- [ ] L10 ranking XML generation
- [ ] Weekly season close, rank rewards, key wipe
- [ ] Tests: key consumption, HP carry, reset limit, prayer probabilities, sweep cost and cancel, season window
