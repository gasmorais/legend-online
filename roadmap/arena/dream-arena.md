# Dream arena ("Arena Ilusória")

Module `arena::dream_arena`. Prefixes as in [README.md](README.md). Manager `CM/managers/DreamArenaManager.as` (DAM), model `CM/mvc/module/dreamarena/DreamArenaModel.as`, constants `CM/mvc/module/dreamarena/DreamArenaConstClass.as` (DAC).

## 1. Overview

A dated event (`dream_arena_start_date` .. `dream_arena_stop_date`, daily fight window `dream_arena_fight_time` = 19:30,21:30). Instead of the player's real units, the player assembles a line-up from `TPL/DreamArenaTemplates.xml`: a hero class (or dragon talker) with skill and passive selection, an einherjar, a goddess, a main guardian and a secondary guardian with their pets, a divine artifact with 3 armories, 2 runes, 10 titan skills, talismans, and the hero grid position. Each page is saved separately (server echoes 4581). Opening a run consumes a ticket (item `dreamarean_ticket_id`, default 208111); then the player matches (op 11) against other players and fights battle 3885 `DREAM_ARENA_BATTLE` until 12 wins or 3 losses ("Quando o jogador atingir 12 vitórias ou 3 derrotas, a arena termina."). The reward depends on the number of wins (`TPL/DreamArenaDrop.xml`, `site` = wins 0..12).

## 2. Screens

Controller `dreamarena` (`CM/mvc/controler/DreamArenaController.as:45-68`): `MAIN_FRAME`, `FORMATION_FRAME`, `RANK_REWARD_FRAME`, `REPORT_FRAME`, `PREVIEW_REWARD_FRAME`.

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `dreamarena.DreamArenaFrame` (976x641) | (help title "Instruções de ajuda da Arena Ilusória") | left list of pages (hero, rune, pet, artifact, goddess, titan, main guardian, secondary guardian), page views, win/loss bars (12/3), tickets "(Passes obtidos: {0})", buttons open, match, rewards preview, formation, ranking, help; text "{0}- {1}, diariamente às {2} você pode montar sua formação mais forte..." | top bar `dreamarena` (`CM/ui/toptoolbar/TopToolsBar.as:1464-1466`), after battle 3885 (`M3/map/space/SpaceSceneController.as:363-377`; `M4/castle/CastleSceneView.as:230-241`) | 4581, 4582, 4584 (`M13/dreamarena/DreamArenaFrame.as:139-420`) |
| page views `DreamArenaHeroView`, `DreamArenaDragonTalkerView`, `DreamArenaPetView`, `DreamArenaGoddessView`, `DreamArenaArtifactView`, `DreamArenaRuneView`, `DreamArenaTitanView`, `DreamArenaMainChildView`, `DreamArenaSlaveChildView`, `DreamArenaTalismanView`, `DreamArenaProficiencyView`, `DreamArenaChildSkillView` | | choose templates and skills, save button per page | main frame | `TPL/DreamArenaTemplates.xml` (`M13/dreamarena/view/*.as`) |
| `dreamarena.DreamArenaFormationFrame` | Configurações de formação | hero grid position | formation button | `heroPos` (`M13/dreamarena/DreamArenaFormationFrame.as:165`) |
| `dreamarena.DreamArenaMatchingView` | | matching spinner with cancel | 4583 `state 0` | (`M13/dreamarena/DreamArenaMatchingView.as:70-90`) |
| `dreamarena.DreamAreanaReportFrame` | Informações do Combate na Arena | run summary (wins/losses) | 4582 `isReport` then back in space | `reportData` |
| `dreamarena.DreamAreanaPreviewRewardFrame` | Visualização dos Prêmios | rewards by wins | rewards link | `TPL/DreamArenaDrop.xml` |
| `dreamarena.DreamArenaRankRewardFrame` | Ranking e prêmios | rank tab and reward tab; sends op 1 | rank button | rank list never filled in this client (observer `RANK_LIST_BACK` has no sender) (`M13/dreamarena/DreamArenaRankRewardFrame.as:46-75`) |

## 3. Routes (client to server)

All: **C to S 8654 (0x21CE) `C_DREAM_ARENA_CLIENT_OP`**, body `player.PlayerOpMsg` (fields in [../theseus-arena/season.md](../theseus-arena/season.md)); used fields `op` (#1), `templateId` (#8), `index` (#6), `id` (#5), `param1` (#15, STRING), `param2` (#16, STRING). Op constants DAC:66-92.

| # | Op | Action | Client sender | Client checks | Fields | Responses |
|---|---|---|---|---|---|---|
| D0 | 0 | Open panel | `DreamArenaFrame()` (`:147`) | | | 4581, 4582, 4584 |
| D1 | 1 | View rank | `DreamArenaRankRewardFrame` (`:51`) | | | none handled (A) |
| D2 | 2 | Save hero | `DreamArenaHeroView` (`:120-133`) -> `DAM.sendHeroSelect` (`DAM:222-230`) | skill selected (`DreamArenaArtifactView.skill.noSelectAlert` "Selecione a Habilidade") | `templateId` hero template, `index` skill choice | 4581 |
| D2b | 2 | Save dragon talker | `DreamArenaDragonTalkerView` (`:140-166`) -> `DAM.sendDragonTalkerSelect` (`DAM:232-243`) | proficiency selected ("Selecione a Potencialidade"); 4 talisman skills ("Selecione 2 Talismãs e Habilidades") | `templateId`, `index` skill index 1, `id` proficiency (skill index 2), `param1` talisman skills "a,b,c,d", `param2` "skillbar1\|skillbar2" | 4581 |
| D3 | 3 | Save einherjar | `DreamArenaPetRightItem` (`:155`) -> `sendPetOrGoddessSelect(3, id)` | | `templateId` | 4581 |
| D4 | 4 | Save artifact | `DreamArenaArtifactView` (`:105-119`) -> `DAM.sendArtifactSelect` | 3 armories ("Selecione 3 Brasões Mágicos") | `templateId` artifact, `param1` "armory1,armory2,armory3" | 4581 |
| D5 | 5 | Save goddess | `DreamArenaGoddessRightItem` (`:153`) | | `templateId` | 4581 |
| D6 | 6 | Save titan skills | `DreamArenaTitanView` (`:135-147`) -> `sendTitanOrRuneSelect(6, s)` | 10 skills ("Equipe 10 habilidades de Titã") | `param1` "s1,...,s10" | 4581 |
| D7 | 7 | Save main guardian | `DreamArenaMainChildView` (`:116`) -> `DAM.sendChildSelect(7, tpl, petId)` | | `templateId` guardian, `id` guardian pet | 4581 |
| D8 | 8 | Save secondary guardian | `DreamArenaSlaveChildView` (`:116`) | | same | 4581 |
| D9 | 9 | Save runes | `DreamArenaRuneView` (`:93`) | 2 runes ("Selecione 2 Runas") | `param1` "r1,r2" | 4581 |
| D10 | 10 | Save hero position | `DreamArenaFormationFrame` (`:165`) -> `DAM.sendHeroPosSelect` (`DAM:283-290`) | | `id` grid position | 4581 |
| D11 | 11 | Match | `DreamArenaFrame._matchBtnClickHandler` (`:397-409`) | `model.canMatch` (inside the event dates and the daily window) else "Não é possível Emparelhar neste horário"; all pages saved else `DreamArenaFrame.match.noSaveAlert{n}` | | 4583 `state 0`, then battle 3885 or 4583 `state != 0` (timeout "Falha no emparelhamento") |
| D12 | 12 | Cancel match | `DreamArenaMatchingView` (`:77,83`) | | | 4583 |
| D13 | 13 | Open a run (use ticket) | `DreamArenaFrame.__openBtnClickHandler` (`:347-363`) | tickets > 0 else "Bilhetes insuficientes para abrir"; all pages saved | | 4584 (tickets), 4582 `isOpen = true` |

## 4. Server messages (server to client)

Receivers registered in `DAM.initEvent` (`DAM:51-57`). Messages in package `module`.

| Opcode | Hex | Name | Body | Receiver and effect |
|---|---|---|---|---|
| 4581 | 0x11E5 | `U_C_DREAM_ARENA_USER` | `DreamArenaUserMsg` | `__dreamArenaUserInfoHandler` (`DAM:59-163`): saved line-up, clears unsaved client edits, `USER_INFO_CHANGE` |
| 4582 | 0x11E6 | `U_C_DREAM_ARENA_FIGHT` | `DreamArenaFightMsg` | `__dreamArenaFightHandler` (`DAM:165-190`): `isOpen` (#1, BOOL, run active), `winCount` (#2), `lostCount` (#3), `isReport` (#4, BOOL: run ended, show the report frame) |
| 4583 | 0x11E7 | `U_C_DREAM_ARENA_MATCH` | `DreamArenaMatchMsg` | `__dreamArenaMatchHandler` (`DAM:197-203`): `state` (#1, INT32): 0 matching (spinner), other = matching failed |
| 4584 | 0x11E8 | `U_C_DREAM_ARENA_TICKET` | `simple.PropertyMsg` | `__dreamArenaTicketHandler` (`DAM:205-212`): `param1` = tickets owned |

`DreamArenaUserMsg` fields: `userId` (#1), `heroId` (#2), `heroPetId` (#3), `goddessId` (#4), `mainChildId` (#5), `mainChildPetId` (#6), `salveChildId` (#7), `salveChildPetId` (#8), `artifactId` (#9), `skillIndex1` (#10), `skillIndex2` (#11), `talismanTempId1` (#12), `talismanTempId2` (#13), `talismanSkillId1` (#14), `talismanSkillId2` (#15), `armoryId1` (#16), `armoryId2` (#17), `armoryId3` (#18), `runeId1` (#19), `runeId2` (#20) (all INT32), `titanSkills` (#21, STRING "a,b,..."), `heroPos` (#22, INT32), `dragonSkill` (#23, STRING), `dragonPassiveSkill` (#24, STRING).

Battle 3885: exit flag `isOpenDreamArena` reopens the main or report frame (`docs/battle/rules.md`).

## 5. Rules and formulas

| # | Rule | Source |
|---|---|---|
| R1 | Visible from 1 day before start to 1 day after stop, only for players with `vocationGrades > 0` (job transfer) | `DreamArenaModel.as:69-82`; `TopBtnCheckShowHelper.as:385-386` |
| R2 | Match only inside [start, stop] and the daily window `dream_arena_fight_time` (default 1:00-23:00 if missing) | `DreamArenaModel.as:56-96`; `CM/yishi/datas/ConfigInfoManager.as:1171-1188` |
| R3 | A run needs 1 ticket (`PLYE_NEED_TICKET = 1`), item `dreamarean_ticket_id` (default 208111) | DAC:8; `ConfigInfoManager.as:1180-1187` |
| R4 | Run ends at 12 wins or 3 losses | `DreamArenaFrame.as:130-132`; help text |
| R5 | Reward by wins: `DreamArenaDrop` `dropId` 1750001+wins, `site` = wins (0..12): items 208059 "Pedra do Poder do Espírito", 208060 "Fragmento de Energização", 208054 "Pedra da Alma de Titã" (e.g. 0 wins: 100/20/60; 12 wins: .../200/780) | `TPL/DreamArenaDrop.xml` |
| R6 | Template types: 1 hero, 2 einherjar, 3 main guardian, 4 secondary guardian, 5 goddess, 6 artifact, 7 armory, 8 talisman, 9 rune; dragon talker = job 4 with `DRAGONTALKER_TYPE_TEMPID` 0; armory profile max 5 | DAC:6-32; `TPL/DreamArenaTemplates.xml` (71 rows) |
| R7 | `dream_arena_score_config` is marked obsolete ("废弃") | config |

## 6. Templates

| File | Record | Fields |
|---|---|---|
| `TPL/DreamArenaTemplates.xml` | selectable component | `TemplateId`, `Type`, `TypeTemplateId` (real template), `PropertyId`, `Skill1..Skill4`, `PassiveSkill1..2`, `Param1..2` |
| `TPL/DreamArenaDrop.xml` | reward by wins | `dropId`, `site`, `itemId`, `count`, `isBind` |
| `TPL/ConfigInfos.xml` | `dream_arena_start_date`, `dream_arena_stop_date`, `dream_arena_fight_time`, `dreamarean_ticket_id` | |

## 7. Persistent state

```sql
CREATE TABLE arena.dream_lineup (
  player_id       integer PRIMARY KEY REFERENCES player.players(player_id),
  hero_template   integer, skill_index1 integer, skill_index2 integer,
  hero_pet        integer, goddess integer,
  main_child      integer, main_child_pet integer,
  slave_child     integer, slave_child_pet integer,
  artifact        integer, armories integer[], runes integer[],
  talisman_templates integer[], talisman_skills integer[],
  titan_skills    integer[], dragon_skill text, dragon_passive_skill text,
  hero_pos        smallint,
  updated_at      timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE arena.dream_run (
  run_id          bigserial PRIMARY KEY,
  player_id       integer NOT NULL REFERENCES player.players(player_id),
  event_start     timestamptz NOT NULL,
  wins            smallint NOT NULL DEFAULT 0 CHECK (wins BETWEEN 0 AND 12),
  losses          smallint NOT NULL DEFAULT 0 CHECK (losses BETWEEN 0 AND 3),
  finished        boolean NOT NULL DEFAULT false,
  reward_paid     boolean NOT NULL DEFAULT false,
  started_at      timestamptz NOT NULL DEFAULT now()
);
CREATE UNIQUE INDEX ON arena.dream_run (player_id) WHERE NOT finished;
```

## 8. Backend implementation notes

- `arena::dream_arena::handle_op` (8654) dispatch by op. Saves validate each id against `DreamArenaTemplates` (type matches), then upsert `dream_lineup` and send 4581.
- Op 13: event running, ticket in bag; consume ticket, create `dream_run`, send 4584 and 4582 (`isOpen`).
- Op 11: active run, R2, complete line-up; enqueue; 4583 `state 0`; pair with another queued run (A: nearest wins), build both sides from the line-ups (template ids -> real templates via `TypeTemplateId`), start battle 3885; update wins/losses; on R4 end set `finished`, pay R5, send 4582 with `isReport`.
- Op 12: dequeue, 4583 non zero.

## 9. Open questions and assumptions

- (A) Op 1 rank response does not exist in this client.
- (A) Unit stats of template based units (level, equipment) must be fixed by the server.

## 10. Implementation checklist

- [ ] 8654 ops 0, 2..13 and pushes 4581..4584
- [ ] Line-up validation against `DreamArenaTemplates.xml`
- [ ] Battle 3885 from line-ups, run state machine, rewards by wins
- [ ] Tables `dream_lineup`, `dream_run`
- [ ] Tests: no ticket, unsaved page, outside window, 12 wins / 3 losses end
