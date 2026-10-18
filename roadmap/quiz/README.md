# Resposta de Inteligência (`quiz`)

Domain: events. Client package `answer` (m11: `answer/AnswerFrame.as`, `answer/view/*`), shared code `decompiled/core_module/scripts/yishi/manager/AnswerManager.as`, `mvc/module/answer/*` (model and enums), `mvc/controler/AnswerControler.as`. A second, map based quiz lives in the campaign module (`decompiled/m3/scripts/map/campaign/mediator/QuizActivity/QuizActivityMediator.as`, `view/ui/QuizActivity/*`) and reads the other half of protobuf package `answerquestion`. Protobuf package `answerquestion` (11 messages).

## Overview

| System | pt-BR | What the player does |
|---|---|---|
| Online quiz | "Resposta de Inteligência" (toolbar tip "Perguntas e Respostas") | server wide timed quiz Mon, Wed, Fri 19:30-20:00 ("Horário do Evento: Seg, Qua, Sex às 19:30-20:00"). Each question: 5 s to read, 15 s to answer, 5 s showing the result. Faster right answers score more; wrong or no answer still gives 1 point. Three helper items: double score (21), "heart" auto correct answer (22), "eyes" remove 2 wrong answers (23); VIP gets extra helpers. End: experience by score plus extra experience for the top 10. |
| Map quiz | "Resultado das Respostas" | players inside campaign map 5101 walk to the left half ("Ande para a Esquerda") or right half ("Ande para a Direita:") of the map to choose between two options; a live top 10 and personal tip "A minha pontuação: {0}   Respostas correctas: {1}/{2}". |

## Entry points

| Entry | Condition | Opens | Source |
|---|---|---|---|
| Top toolbar `answer` | visible when `state > 0`, level >= 30 and `ConfigManager.info.ANSWER_SYSTEM`; click only in `CASTLE_SCENE` or `SPACE_SCENE`, else "Resposta Online só pode ser acessada na Cidade" | `AnswerFrame` | `decompiled/core_module/scripts/yishi/manager/AnswerManager.as:83-90`, `decompiled/core_module/scripts/ui/toptoolbar/TopBtnCheckShowHelper.as:341-342`, `decompiled/core_module/scripts/ui/toptoolbar/TopToolsBar.as:1198-1208` |
| Push 4908 with state 0 or first non zero state | toolbar refresh (`ANSWER_SWITCH`) | | `AnswerManager.as:372-376`, `TopToolsBar.as:408` |
| Campaign map 5101 (`WorldBossHelper.checkInQuizActivity`) or campaign `Types == 17` | entering the map | `QuizActivityMediator` overlays | `decompiled/core_module/scripts/yishi/utils/WorldBossHelper.as:275-278`, `decompiled/m3/scripts/map/campaign/view/CampaignMapView.as:324-326` |

## Modules

| Module | File | Scope |
|---|---|---|
| Online quiz | [online-quiz.md](online-quiz.md) | 9501, 4907, 4908, 4909, 4910, helper items, schedule, rewards |
| Map quiz | [map-quiz.md](map-quiz.md) | 4692, 4693, 4694, 4695 in map 5101 |

## Protocol summary

| Dir | Opcode | Hex | Name | Module |
|---|---|---|---|---|
| C>S | 9501 | 0x251d | `C_ANSWER_REQUEST_OPTION` (`AnswerquestionReqMsg`) | online-quiz |
| S>C | 4907 | 0x132b | `U_C_ANSWER_PLAYER_INFO` | online-quiz |
| S>C | 4908 | 0x132c | `U_C_ANSWER_SYSTEM_STATE` | online-quiz |
| S>C | 4909 | 0x132d | `U_C_ANSWER_SINGLER_QUESTION` | online-quiz |
| S>C | 4910 | 0x132e | `U_C_ANSWER_RANK_LIST` | online-quiz |
| S>C | 4692 | 0x1254 | `U_C_QUIZ_RANKING` (not in opcodes.csv; `ProtocolTypeTable.as:592`) | map-quiz |
| S>C | 4693 | 0x1255 | `U_C_GET_QUESTION` (`ProtocolTypeTable.as:591`) | map-quiz |
| S>C | 4694 | 0x1256 | `U_C_SHOW_QUIZ_BTN` (`ProtocolTypeTable.as:590`) | map-quiz |
| S>C | 4695 | 0x1257 | `U_C_QUIZ_RANKING_MY_INFO` (`ProtocolTypeTable.as:593`) | map-quiz |

## Dependencies

- [hero](../hero/README.md): experience rewards and level 30 gate.
- [vip](../vip/README.md): extra helper item counts.
- [campaign](../campaign/README.md): map 5101 scene, walk packets, scene enter and leave.
- [rankings](../rankings/README.md): top 10 lists.
- [customer-service](../customer-service/README.md) owns the unrelated questionnaire (`QuestionTemplates.xml`, 8534, 4429); [marriage](../marriage/README.md) owns the couple quiz (4691); Christmas quiz (560) belongs to its event feature.

## Suggested implementation order

1. Quiz scheduler (state machine 0..5 with timers) and question bank table.
2. 9501 op 1 open/close, 4908 broadcast to viewers, 4909 question push, 4907 player info.
3. 9501 op 3 answer and scoring, 4910 top 10.
4. Helper items (op 2) and VIP counts; end rewards.
5. Map quiz on map 5101 using player positions.
