# Final Road ("Caminho Final")

Area: roads, module `final-road`. Client package `finalroad` (`decompiled/m11/scripts/finalroad`), manager `yishi.manager.FinalRoadManager`, model `mvc.module.finalroad.FinalRoadModel` / `FinalRoadGroupInfo`, controller key `finalroad`, proto package `finalroad`. Sweeps use the generic [mopup](../mopup/README.md) route with `sweep_type = 8`.

Path aliases:

| Alias | File |
|---|---|
| FRM | `decompiled/core_module/scripts/yishi/manager/FinalRoadManager.as` |
| FR | `decompiled/m11/scripts/finalroad/` |
| SPH | `decompiled/core_module/scripts/yishi/SwitchPageHelp.as` |

## 1. Overview

Weekly roguelike road with 3 chapters ("Caminho Final (Fácil)", "(Comum)", "(Difícil)"). A chapter has 6 floors ("Piso", groups) of 5 stages ("Fase", levels). At each stage the server offers 2 or 3 events: monster choices (each with an element icon and boss), an optional buff (skill ids applied for the rest of the chapter) and a floor reward. The player picks a monster and fights it (battle type 3906 `FINAL_ROAD_BATTLE`, own attributes plus Theseus soul only, no Dragon Talker). Clearing the 5 stages of a floor grants the floor reward. A chapter run costs one weekly chapter access (1 free plus up to 7 bought with diamonds, 8 in total per help text); a failed stage can be retried 3 times per chapter (50 diamonds each) or abandoned. Fully cleared chapters can be swept. Weekly reset Sunday 23:30, closed 23:30..23:59.

Help (`finalRoadFrame.helperFrame.helpTxt.text`): reset every Sunday 23:30, closed until 23:59; 8 chapter selections per week and 3 re-challenges per chapter; reselecting a chapter resets its rewards and re-challenges; "Abandonar desafio" ends the chapter progress; in boss fights only own attributes plus Theseus soul count; Dragon Talker not allowed.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `finalroad.FinalRoadFrame` (`FR/FinalRoadFrame.as`), 900 x 655 | "Caminho Final"; "Seleção de Fase"; "Caminho Final atualiza a cada {0}{1}"; "Número de capítulos que pode escolher nesta semana: {0}" | 3 chapter cards (`FinalRoadItem`), buy chapter access, help | controller `finalroad` (`decompiled/core_module/scripts/mvc/controler/FinalRoadController.as:43-54`) via `SPH.openFinalRoadFrame` (`SPH:3199-3262`) | 532 |
| `FinalRoadItem` (`FR/FinalRoadItem.as`) | buttons challenge, continue, "Bot"; lock tip with the chapter `Description` (e.g. "Caminho da Realeza nv. 20 Passar da Dificuldade Fácil") | Chapter card | frame | royalty level, `passChapterRecord`, `currentChapter` |
| `finalroad.FinalRoadLevelFrame` (`FR/FinalRoadLevelFrame.as`), 890 x 755 | "Caminho Final (Fácil/Comum/Difícil)", "Piso {0}/Fase {1}", "Redesafios de Fase restantes: {0}" | Floor progress, event choices (`FinalRoadLevelItem`), challenge, retry, give up, buff view | openType 1 after choosing or continuing a chapter, or after a 3906 battle when `state != 2` (`decompiled/m3/scripts/map/space/SpaceSceneController.as:453-467`) | 533 |
| `finalroad.FinalRoadBuffFrame` (`FR/FinalRoadBuffFrame.as`), 330 x 525 | "Visualizar Buffs" | Buffs collected in this chapter | openType 2; "Ainda não há buffs" when `levelSkills` is empty (`FR/FinalRoadLevelFrame.as:165-177`) | `levelSkills` |

## 3. Routes (client to server)

All routes: send 9711 (0x25ef) `C_FINAL_ROAD_CLIENT_OP`, sender `FRM.send(op, value)` (`FRM:92-99`), message `simple.PropertyMsg`: `param1` (#1, INT32) operation, `param2` (#2, INT32) value. Operations `FRM:18-26`: 0 OP_BUY, 1 OP_ENTER, 2 OP_CHALLENGE, 3 OP_AGAIN, 4 OP_GIVEUP.

| # | UI control | Client checks | Fields | Response |
|---|---|---|---|---|
| F0 | Open the frame (no request; data comes from pushes) | changed job; quest 1391 "O Eco Final" finished (`TaskManage.FINAL_ROAD = 1391`); `checkScene()`; royalty level >= first `OpenFinalRoad` level (10); not in the weekly window Sunday 23:30..23:59 ("Fechado durante {0}{1}-{2}"); `model.isOpen` ("Reseta aos domingos 23:30~23:59! Não pode entrar") (`SPH:3199-3262`) | none | needs 532 and 533 already pushed |
| F1 | Buy chapter access (`FR/FinalRoadFrame.as:136-163`) | price `FinalroadChallengePrice[buyChapterTimes]` (0 or missing: "Limite de compras semanal atingido!"); confirm "Consumir {0} diamantes para comprar {1} Acessos de Capítulo? (Nesta semana ainda pode comprar {2}x)"; diamonds >= price else recharge dialog | `param1 = 0` | 532 |
| F2 | Chapter "Desafiar" (`FR/FinalRoadItem.as:140-157`) | `surplusChapterTimes > 0` ("Não restam capítulos para escolher nesta semana"); chapter unlocked; confirm "Gastar um desafio para desafiar o Caminho Final (Fácil/Normal/Difícil)?"; the client opens the level frame at once | `param1 = 1`, `param2` chapter 1..3 | 532 (`currentChapter`), 533 (stage 1 events) |
| F3 | Stage "Desafiar" (`FR/FinalRoadLevelFrame.as:178-189`) | event selected | `param1 = 2`, `param2` = selected `FinalRoadEventRspMsg.monster` (event id) | battle 3906; after the battle 533 (next stage or state change), 532 when the chapter ends |
| F4 | "Desafiar novamente" (`FR/FinalRoadLevelFrame.as:192-212`) | `surplusLevelTimes > 0` ("Número insuficiente de redesafios das Fases restantes"); confirm "Gastar {0} diamantes para desafiar de novo a Fase?" (`FinalroadRepeatChallengePrice` 50); diamonds | `param1 = 3` | 533 (state back to choosing) |
| F5 | "Abandonar desafio" (`FR/FinalRoadLevelFrame.as:214-225`) | confirm "Deixar de desafiar a Fase?"; client returns to the chapter frame | `param1 = 4` | 532 (`currentChapter = 0`) |
| F6 | Chapter "Bot" (`FR/FinalRoadItem.as:100-138`) | chapter accesses left; chapter fully cleared before (`index <= passChapterRecord`, "Requer a conclusão total antes de usar o Bot"); not the chapter in progress with `state != 2` ("O Capítulo escolhido está sendo desafiado, não é possível usar o Bot"); confirm "Deseja consumir 1 tentativa do Capítulo para usar o Bot?" | send 8528 (0x2150) `C_CAMPAIGN_SWEEP`, `CampaignSweepReq`: `sweep_type` (#1) 8, `op_type` (#2) 1, `campaign_id` (#3) chapter | 4425 (mopup), 532 |

## 4. Server messages (server to client)

| Opcode | Message and fields | Client receiver | When |
|---|---|---|---|
| 532 (0x0214) `U_C_FINAL_ROAD_CHAPTER` | `finalroad.FinalRoadChapterRspMsg`: `currentChapter` (#1, INT32) chapter in progress, 0 = none; `surplusChapterTimes` (#2, INT32) chapter accesses left this week; `buyChapterTimes` (#3, INT32) accesses bought this week; `passChapterRecord` (#4, INT32) highest fully cleared chapter (unlocks the next and the sweep; quest condition 269 `FINAL_ROAD_CHAPTER`, `decompiled/core_module/scripts/mvc/module/task/TaskTemplate.as:948-956`); `isOpen` (#5, BOOL) false during the weekly reset window | `FRM.__finalRoadChapterHandler` (`FRM:64-75`) -> `FINALROAD_CHAPTER_UPDATE` | Login, F1, F2, F5, chapter end, weekly reset |
| 533 (0x0215) `U_C_FINAL_ROAD_GROUP` | `finalroad.FinalRoadGroupRspMsg`: `chapter` (#1); `level` (#2) floor 1..6 ("Piso"); `groupLevel` (#3) stage 1..5 ("Fase", progress bar frame); `state` (#4) 0 choosing, 1 last fight lost (retry or give up, assumption), 2 chapter complete; `surplusLevelTimes` (#5) re-challenges left (3); `levelSkills` (#6, STRING) collected buffs `eventId,...|...`; `events` (#7, repeated `FinalRoadEventRspMsg`: `monster` (#1) monster event id, `buff` (#2) buff event id or 0, `reward` (#3) floor group id for the reward preview) | `FRM.__finalRoadGroupHandler` (`FRM:77-90`) -> `FINALROAD_GROUP_UPDATE` | Login when a chapter is in progress, F2, F3 result, F4 |
| `FinalRoadPassLevelSkillsRspMsg` | `level` (#1), `skills` (#2, STRING) | no reader | declared only |

## 5. Rules and formulas

Config (`raw/xml/tempinfos/ConfigInfos.xml`):

| Key | Value | Meaning |
|---|---|---|
| `FinalroadChallengeNum` | 1 | free chapter accesses per week |
| `FinalroadChallengePrice` | 300,300,500,600,800,1000,2000 | diamond price of the Nth bought access (7 purchases) |
| `FinalroadRepeatChallengeNum` | 3 | re-challenges per chapter run |
| `FinalroadRepeatChallengePrice` | 50 | diamonds per re-challenge |
| `FinalroadRefreshTime` | `0,23:30:00|23:59:59` | weekday 0 (Sunday) closed window |

- Structure: chapters 1..3 (`FinalRoadChapterTemplates.xml`), 6 groups per chapter (`FinalRoadGroupTemplates.xml`, `BelongChapter`, `Sort`, `Reward`), 5 levels per group (`FinalRoadLevelTemplates.xml` 90 rows, `BelongGroup`, `Sort`, `EventNum` choices), events (`FinalRoadEventTemplates.xml` 1296 rows: `EventType 1` monster with `Para1` boss `heroId,pos`, `Para2` pawns `id,pos|...`, `Para3` element icon frame, `Para4` boss icon; `EventType 2` buff with `Para1` skill ids).
- Chapter unlock: royalty level >= `RoyaltyTemplates.OpenFinalRoad` level of that chapter (`decompiled/core_module/scripts/yishi/datas/templates/cate/RoyaltyTempCate.as:98-101`, `:210-214`) and chapter <= `passChapterRecord + 1`. The client also locks the chapter whose index equals the template count (`FR/FinalRoadItem.as:186-200`), so chapter 3 shows "unopened" in this build.
- One chapter in progress at a time (`currentChapter`); other challenge buttons disabled.
- Stage flow: choose a monster event, win -> next stage; after stage 5 the floor `Reward` is granted and the next floor starts; after floor 6 `state = 2` and `passChapterRecord = max(record, chapter)`.
- Re-selecting a chapter resets its progress, rewards and re-challenges (help point 3).
- Sweep (type 8): consumes one chapter access and grants the full chapter rewards (assumption).
- Unlock quest 1391 "O Eco Final" (level 80..100, prereq 1389, "Fale com Eliza no Reino do Céu para saber sobre o Caminho Final"); space NPC dialog option 161 (`decompiled/m3/scripts/map/space/view/frame/DialogOptionItem.as:883-884`).

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `raw/xml/tempinfos/FinalRoadChapterTemplates.xml` | chapter | `ChapterId`, `Description` (unlock text) |
| `raw/xml/tempinfos/FinalRoadGroupTemplates.xml` | floor | `GroupId` (chapter x 100 + n), `BelongChapter`, `Sort`, `Reward` (`templateId,count|...`) |
| `raw/xml/tempinfos/FinalRoadLevelTemplates.xml` | stage | `LevelId`, `BelongGroup`, `Sort`, `EventNum` |
| `raw/xml/tempinfos/FinalRoadEventTemplates.xml` | event | `EventId`, `BelongLevel`, `EventType`, `Para1..4` |
| `raw/xml/tempinfos/RoyaltyTemplates.xml` | unlock | `OpenFinalRoad` |
| `raw/xml/tempinfos/QuestTemps.xml` 1391 | unlock quest | |

## 7. Persistent state

```sql
CREATE SCHEMA IF NOT EXISTS roads;

CREATE TABLE roads.final_road_state (
    player_id            BIGINT     PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
    week_start           date        NOT NULL,
    chapter_access_left  smallint    NOT NULL DEFAULT 1,
    chapter_access_bought smallint   NOT NULL DEFAULT 0,
    pass_chapter_record  smallint    NOT NULL DEFAULT 0 CHECK (pass_chapter_record BETWEEN 0 AND 3),
    current_chapter      smallint    NOT NULL DEFAULT 0 CHECK (current_chapter BETWEEN 0 AND 3)
);

CREATE TABLE roads.final_road_run (
    player_id          BIGINT  PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
    chapter            smallint NOT NULL,
    floor              smallint NOT NULL DEFAULT 1 CHECK (floor BETWEEN 1 AND 6),
    stage              smallint NOT NULL DEFAULT 1 CHECK (stage BETWEEN 1 AND 5),
    state              smallint NOT NULL DEFAULT 0 CHECK (state IN (0, 1, 2)),
    retries_left       smallint NOT NULL DEFAULT 3,
    buff_event_ids     integer[] NOT NULL DEFAULT '{}',
    offered_events     jsonb    NOT NULL DEFAULT '[]'
);
```

`offered_events` stores the `{monster, buff, reward}` choices of the current stage so the server can validate F3.

## 8. Backend implementation notes

- Handlers: `roads::final_road::handle_buy` (0), `handle_enter` (1), `handle_challenge` (2), `handle_again` (3), `handle_give_up` (4); sweep through `mopup::handle_campaign_sweep` type 8.
- Global gate: reject every op during Sunday 23:30..23:59 (`isOpen = false`).
- Enter: chapter unlocked, accesses left, no other chapter in progress (or same chapter = continue); deduct an access, create the run at floor 1 stage 1, roll `EventNum` events from `FinalRoadEventTemplates` of that level (monsters type 1, plus a buff type 2 when available), push 532 and 533.
- Challenge: `param2` must be one of the offered monster event ids; build battle 3906 with `Para1`/`Para2` and the collected buffs on the player (skill ids), using base attributes plus Theseus soul only and no Dragon Talker form. Win: add the buff of the chosen choice (assumption: each choice pairs a monster with a buff), advance stage, grant the floor reward after stage 5, finish at floor 6. Loss: `state = 1`.
- Again: `retries_left > 0`, charge 50 diamonds, `state = 0`. Give up: delete the run, `current_chapter = 0`.
- Weekly reset (Sunday 23:59): accesses to `FinalroadChallengeNum`, purchases 0, delete runs; push 532 with `isOpen` true; at 23:30 push `isOpen = false`.

## 9. Open questions and assumptions

- Meaning of `state = 1` (lost stage awaiting retry or give up) is inferred from the UI.
- How the buff choice is combined with the monster choice (`FinalRoadEventRspMsg` carries both) is not explicit.
- Sweep reward content for type 8 is not visible in the client.
- Whether chapter 3 is intentionally locked by the client in this build.

## 10. Implementation checklist

- [ ] Template loaders (chapters, groups, levels, events, config keys)
- [ ] Tables `roads.final_road_state`, `roads.final_road_run`
- [ ] Login pushes 532 and 533
- [ ] F1 buy access, F2 enter, F3 challenge battle 3906, F4 again, F5 give up
- [ ] F6 sweep type 8
- [ ] Weekly window and reset
- [ ] Tests: access pricing, retry limit, floor rewards, chapter unlock by royalty level
