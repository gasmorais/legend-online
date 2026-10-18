# Glory Road ("Caminho da Glória")

Area: roads, module `glory-road`. Client package `gloryroad` (`decompiled/m9/scripts/gloryroad`), manager `managers.GloryroadManager`, model `mvc.module.gloryroad.GloryRoadModel`, controller key `gloryroad` (`decompiled/core_module/scripts/mvc/controler/GloryRoadController.as`), proto package `gloryroad`. Shop 1008 ("Pontos da Glória") belongs to [shops](../shops/README.md).

Path aliases:

| Alias | File |
|---|---|
| GRM | `decompiled/core_module/scripts/managers/GloryroadManager.as` |
| GRMOD | `decompiled/core_module/scripts/mvc/module/gloryroad/GloryRoadModel.as` |
| GR | `decompiled/m9/scripts/gloryroad/` |

## 1. Overview

A daily 15 layer gauntlet against mirrors of other players (battle type 3863 `GLORY_ROAD_BATTLE`). The player fights with the hero, one guardian ("Guardião", child) and one Einherjar (child pet); HP does not regenerate between layers and the guardian is locked after the first layer ("Durante o desafio não irá recuperar sangue, ao completar a 1ª fase não poderá mudar guardião"). Before each layer the player picks a difficulty (normal, nightmare, hell) that scales the score; clearing layers gives score, glory points (currency -3900 "Pontos da Glória") and buff stars. Stars buy temporary buffs (HP, attack, defense, resistance) in a buff shop; odd layers open treasure chests (random 20..100 glory points). A strong player may skip ("pular") layers. Accumulated score unlocks score rewards. Resurrections cost diamonds. One run per day, reset at 0:00. Daily queue text "Caminho da Glória {0}/{1}".

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `gloryroad.GloryRoadFrame` (`GR/GloryRoadFrame.as`) | explain text "1. Pode se desafiar uma vez por dia, é redefinido às 0h automaticamente. 2. Durante o desafio não irá recuperar sangue..." | Layer road (15), hero HP (`GloryBloodHead`: "Sangue atual do líder"), guardian and Einherjar slots (`GloryChildrenView`), stats tips (buff star, HP, attack, defense, resistance gains), opponent tip (`GloryRoadRivalTip`), challenge, revive all, revive guardian, shop, score rewards | controller `gloryroad` default: space NPC dialog option 108 (level >= 15, `decompiled/m3/scripts/map/space/view/frame/DialogOptionItem.as:723-730`), queue bar item 13 (`decompiled/core_module/scripts/ui/queuebar/QueueBar.as:331-332`), reopened after a 3863 battle (`decompiled/m3/scripts/map/space/SpaceSceneController.as:306-309`) | 384, 385 |
| `gloryroad.view.GloryRoadDifficultyFrame` | "Selecionar dificuldade"; "Desafiar dificuldade *", "Pontos de conclusão:", "Pontos da Glória:", "Número de Estrelas:" | Choose difficulty 1..3 and start the layer | openType `glory_road_difficulty` | config factors |
| `gloryroad.view.GloryRoadBuffFrame` | "Comprar Buff"; "Números restantes: {0}"; close alert "Ao fechar a tela não poderá comprar mais os prêmios, deseja fechar?" | Buy buffs with stars; refresh offers (after a skip) | openType `glory_road_buff`, layer road icons | `canBuyBuffers`, `hasBuyBuffers`, `buffStar`, `buyBufferTimes` |
| `gloryroad.view.GloryRoadTreasureFrame` | "Prêmio de Baú"; "Pontos de conclusão atual = Histórico de conclusão de pontos ({0}) x10% + pontos de conclusão do dia ({1})" | Open layer chests one by one or all; cells `GloryRoadTreasureCell` "{0}ª fase", "Baú aleatório (obtém 20~100 pontos de glória aleatoriamente)" | openType `glory_road_treasure` | `boxTimes`, `canGetBox`, drop templates |
| `gloryroad.view.GloryRoadScoreFrame` | "Prêmios de pontos" | Claim score milestone rewards (`GloryRoadScoreCell`) | reward icon | `scoreRewards`, upgrade templates type 125 |

## 3. Routes (client to server)

All routes: send 9624 (0x2598) `C_GLORY_ROAD_OP` with `gloryroad.GloryRoadOpMsg`: `op` (#1, INT32), `type` (#2, INT32), `layer` (#3, INT32), `templateId` (#4, INT32), `payType` (#5, INT32), `value1` (#6, INT32), `value2` (#7, INT32), `param1` (#8, STRING), `param2` (#9, STRING). Ops (`decompiled/core_module/scripts/com/road/yishi/proto/gloryroad/GloryRoadOpState.as`): 0 REQUEST, 1 FIGHT, 2 RESURGENCE, 3 OPEN_BOX, 4 CHOOSE_CHILD_PET, 5 BUY_BUFF, 6 GET_SCORE_REWARD, 7 SKIP_LAYER, 8 TAG, 9 REFRESH_BUFF.

| # | UI control | Client sender | Client checks | Fields | Response |
|---|---|---|---|---|---|
| G1 | Manager creation (login) and frame open | `GRM.requestData(type)` (`GRM:105-112`); constructor sends `type 0` (`GRM:31-38`), frame sends `type 1` (`GR/GloryRoadFrame.as:108`) | none | `op 0`, `type` 0 login / 1 frame | 384 (and 385 for the next mirror) |
| G2 | Challenge | `GRM.fight(difficulty)` (`GRM:114-122`) from `GR/GloryRoadFrame.as:306-321` or difficulty frame (`GR/view/GloryRoadDifficultyFrame.as:95-117`) | if `jumpLayer > 0` first ask "Você desempenhou-se muito bem, deseja pular até à fase {0}?" (G7); if no difficulty chosen open the difficulty frame; layer 0 confirm "Ao completar com sucesso a primeira fase, não poderá alterar guardião, deseja iniciar desafio?" | `op 1`, `type` difficulty 1 normal / 2 nightmare / 3 hell | battle 3863 vs mirror; 384 after the battle, 385 for the next mirror |
| G3 | Revive all / revive guardian | `GRM.resurgence(tag, bind)` (`GRM:124-135`) from `GR/GloryRoadFrame.as:507-571` | on layer 15 no confirm; else confirm "Deseja consumir {0} diamantes para ressuscitar todos?" (`resurgencePoint`) or "Deseja consumir {0} diamantes para ressuscitar?" (`resurgenceChildPoint`, bind checkbox); diamonds | `op 2`, `type` 0 all (hero full HP) / 1 guardian; `value1` (guardian only) 0 bound diamonds, 1 diamonds | 384 |
| G4 | Open chest | `GRM.openBox(type, layer)` (`GRM:137-148`) from `GR/component/GloryRoadTreasureCell.as:79-99`, `GR/view/GloryRoadTreasureFrame.as:100-178` | any chest openable ("Não contém baús para coletar"); confirm "Deseja consumir {0} diamantes para abrir 1 vez o baú de conclusão de fase?" or the multi version; diamonds | `op 3`, `type` 1 one cell (`layer` = grade), 2 one random, 3 all after a skip, 5 all, 0 on frame close (`GR/view/GloryRoadTreasureFrame.as:178`) | 384 with `boxTimes` |
| G5 | Choose guardian / Einherjar | `GRM.choosePet(type, id)` (`GRM:159-167`) from `GR/component/GloryChildrenView.as:376-419` | owns a child ("noChild1"); for the pet a child must be selected ("noSelectChild") | `op 4`, `type` 0 guardian (child id) / 1 Einherjar (child pet id), `templateId` id | 384 (`childId`, `childPetId`) |
| G6 | Buy buff | `GRM.buyBuff(id)` (`GRM:150-157`) from `GR/component/GloryRoadBuffCell.as:68-71` | none (button state) | `op 5`, `templateId` buff template id | 384 (`buffStar`, `hasBuyBuffers`) |
| G7 | Skip layers prompt answer | `GRM.skipLayer(1|0)` (`GR/GloryRoadFrame.as:323-337`) | none | `op 7`, `type` 1 accept (then treasure and buff frames) / 0 refuse (then difficulty frame) | 384 (`layer = jumpLayer` on accept) |
| G8 | Score reward | `GRM.getScoreReward(grade)` (`GRM:169-176`) from `GR/component/GloryRoadScoreCell.as:78-81` | none | `op 6`, `type` = `Grades` of the upgrade template | 384 (`scoreRewards`) |
| G9 | View state tag | `GRM.opTag(state)` via `GRMOD.viewSate` setter (`GRMOD:106-110`), set to 0 when the buff or treasure frames close (`GR/view/GloryRoadTreasureFrame.as:215-223`, `GR/view/GloryRoadBuffFrame.as:118-127`) | none | `op 8`, `type` view state (0 = normal) | 384 with `tag` |
| G10 | Refresh buff offers | `GRM.refreshBuff` (`GRM:196-202`) from `GR/view/GloryRoadBuffFrame.as:69-72` | refresh count > 0 | `op 9` | 384 (`canBuyBuffers`, `buyBufferTimes`) |

## 4. Server messages (server to client)

| Opcode | Message and fields | Client receiver | When |
|---|---|---|---|
| 384 (0x0180) `U_C_GLORY_ROAD_DATA` | `gloryroad.GloryRoadDataMsg` copied by name into the model (`LogicUtils.copyMsgValueToInfo`, `GRM:86-94`): `userId` (#1); `layer` (#2) cleared layers 0..15; `jumpLayer` (#3) layer the player may skip to (0 none); `resetTimes` (#4); `resurgenceTimes` (#5) revives used; `remainHp` (#6, INT64) hero HP; `childId` (#7); `childPetId` (#8); `childRemainHp` (#9, INT64); `score` (#10) today; `totalScore` (#11) history; `gloryScore` (#12); `buffStar` (#13); `buyBufferTimes` (#14) refreshes left; `allBuffers` (#15, INT32, repeated) active buffs; `canBuyBuffers` (#16, repeated) offers; `hasBuyBuffers` (#17, repeated) bought; `scoreRewards` (#18, repeated) claimed grades; `canGetBox` (#19, BOOL); `boxTimes` (#20, STRING CSV) open count per chest layer; `tag` (#21) view state; `difficulty` (#22) chosen difficulty 0 none; `config` (#23, `GloryRoadConfigMsg`: `baseScore` (#1), `baseGloryScore` (#2), `baseBuffStar` (#3), `resurgenceTimes` (#4) max revives, `resetTimes` (#5), `openBoxTimes` (#6), `openBoxPoint` (#7) diamonds per chest, `resurgencePoint` (#8) diamonds revive all, `resurgenceChildPoint` (#9) diamonds revive guardian, `normalFactor` (#10, FLOAT), `nightmareFactor` (#11, FLOAT), `hellFactor` (#12, FLOAT)) | `GRM.__dataUpdateHandler` -> `GLORY_ROAD_DATA_UPDATE` | Reply to every op; login |
| 385 (0x0181) `U_C_GLORY_ROAD_MIRROR` | `gloryroad.MirrorInfoMsg`: `userid` (#1), `grade` (#2), `job` (#3), `sexs` (#4), `fightCapacity` (#5), `nickName` (#6), `phyAttack` (#7), `phyDefence` (#8), `magAttack` (#9), `magDefence` (#10), `forceHit` (#11), `penetrate` (#12), `parry` (#13), `hp` (#14), `stunAttr` (#15), `conat` (#16), `reduceResi` (#17), `fireResi` (#18), `waterResi` (#19), `electResi` (#20), `windResi` (#21), `darkResi` (#22), `lightResi` (#23), `arm` (#24), `cloth` (#25), `wing` (#26), `hat` (#27), `hideFashion` (#28, BOOL), `fashionArm` (#29), `fashionCloth` (#30), `isDragonTalker` (#31, BOOL), `battleBeastId` (#32) | `GRM.__updateMirrorHandler` (`GRM:96-103`) into `GloryRoadMirrorInfo` (opponent avatar and tip) | Next opponent after G1 and each layer |
| 528 (0x0210) `U_C_FROST_HEART_SHOP` | `CommonMsgList.list` (`CommonMsg.param1` shop item id, `param2` bought count) | `GRM.shopBuyHandler` (`GRM:57-71`) updates glory shop limits | Shop purchase counts ([shops](../shops/README.md)) |

## 5. Rules and formulas

- 15 layers (`GRMOD.isTopLayer`, `leftAmount = 15 - layer`).
- Difficulty preview (`GRMOD.getDiffectyData`, `GRMOD:250-272`) for d in 1..3 and next layer L (1..15): factor = `normalFactor|nightmareFactor|hellFactor`; completion points = `15d + L*d`; glory points = `10 d^2`; stars = `5d` (these are the displayed bases; actual gains are multiplied by the factor, assumption).
- Score: today score plus 10% of history (`GloryRoadTreasureFrame.refreshView.gloryTip`, `GR/GloryRoadFrame.as:435`).
- Buffs (`GloryRoadBufferInfos.xml`, 40 rows): `Type` (1 HP limit, 2 attack, 3 defense, 4 resistance, assumption from `GloryRoadFrame.initView.txtTips`), `Percent`, `Value`, `Pos`, `Price` in stars.
- Chests (`GloryRoadDrop.xml`): `site` = layers with a chest (1,3,5,7,9,11,13), items -3900 x 20..100; extra openings cost `openBoxPoint` diamonds, at most 10 (`treasureAllOpenCount + "/10"`).
- Score rewards: `UpGradeTempInfos.xml` `Types = 125`, `Grades` = milestone index, `Data` = score needed, `TemplateName` = `itemId,count|...`.
- Revives limited by `config.resurgenceTimes`.
- HP does not regenerate; the guardian is locked after layer 1.
- Entry: NPC option 108 (level 15), queue bar 13.

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `raw/xml/tempinfos/GloryRoadBufferInfos.xml` | buff | `TemplateId`, `Type`, `Desc`, `Value`, `Percent`, `Pos`, `Price` |
| `raw/xml/tempinfos/GloryRoadDrop.xml` | chest drop | `site`, `itemId`, `count`, `appearType` |
| `raw/xml/tempinfos/UpGradeTempInfos.xml` (`Types 125`) | score milestone | `Grades`, `Data`, `TemplateName` |
| `raw/xml/tempinfos/ItemTempInfos.xml` -3900 | "Pontos da Glória" currency | |

## 7. Persistent state

```sql
CREATE TABLE roads.glory_road_state (
    player_id          integer     PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
    run_date           date        NOT NULL DEFAULT current_date,
    layer              smallint    NOT NULL DEFAULT 0 CHECK (layer BETWEEN 0 AND 15),
    jump_layer         smallint    NOT NULL DEFAULT 0,
    difficulty         smallint    NOT NULL DEFAULT 0 CHECK (difficulty BETWEEN 0 AND 3),
    remain_hp          bigint      NOT NULL DEFAULT 0,
    child_id           integer     NOT NULL DEFAULT -1,
    child_pet_id       integer     NOT NULL DEFAULT -1,
    child_remain_hp    bigint      NOT NULL DEFAULT 0,
    resurgence_used    smallint    NOT NULL DEFAULT 0,
    score              integer     NOT NULL DEFAULT 0,
    total_score        integer     NOT NULL DEFAULT 0,
    glory_score        integer     NOT NULL DEFAULT 0,
    buff_stars         integer     NOT NULL DEFAULT 0,
    buff_refresh_left  smallint    NOT NULL DEFAULT 0,
    active_buffs       integer[]   NOT NULL DEFAULT '{}',
    offered_buffs      integer[]   NOT NULL DEFAULT '{}',
    bought_buffs       integer[]   NOT NULL DEFAULT '{}',
    box_open_counts    smallint[]  NOT NULL DEFAULT '{}',
    view_tag           smallint    NOT NULL DEFAULT 0
);

CREATE TABLE roads.glory_road_score_reward (
    player_id    integer  NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
    grade        smallint NOT NULL,
    claimed_at   timestamptz NOT NULL DEFAULT now(),
    PRIMARY KEY (player_id, grade)
);
```

Mirror opponents are chosen from snapshot data of other players (shared with arena style features); the chosen opponent per layer can be cached in memory.

## 8. Backend implementation notes

- Handlers: `roads::glory_road::handle_request` (0), `handle_fight` (1), `handle_resurgence` (2), `handle_open_box` (3), `handle_choose_child_pet` (4), `handle_buy_buff` (5), `handle_get_score_reward` (6), `handle_skip_layer` (7), `handle_tag` (8), `handle_refresh_buff` (9). Each answers 384; G1 and fights also send 385 for the next opponent.
- Fight: validate layer < 15, hero HP > 0, companions chosen (locked after layer 1); battle 3863 against the mirror built from `MirrorInfoMsg` attributes with the player's carried HP and active buffs. Win: `layer += 1`, add score, glory points (-3900 currency) and stars by difficulty, roll new buff offers, mark chest availability on chest layers, compute `jump_layer` when the player is far stronger (rule unknown). Loss: store HP 0.
- Resurrection: deduct diamonds (bound for `value1 = 0`), restore HP.
- Daily reset 0:00: new run, `total_score` keeps history.
- Mirror selection: by fight capacity bands per layer (assumption).

## 9. Open questions and assumptions

- Exact score, glory and star formulas per difficulty (client shows only bases and factors).
- Skip rule (`jumpLayer`) and its reward handling (`openBox` types 3 and 5).
- Meaning of `tag` / `viewSate` values beyond 0.
- Mirror selection algorithm.

## 10. Implementation checklist

- [ ] Template loaders (buffs, drops, upgrade type 125)
- [ ] Tables `roads.glory_road_state`, `roads.glory_road_score_reward`
- [ ] G1 request at login and on open (384, 385)
- [ ] G2 fight 3863 with mirror and carried HP
- [ ] G3 revives, G4 chests, G5 companions, G6 and G10 buffs, G7 skip, G8 score rewards, G9 tag
- [ ] Daily reset
- [ ] Tests: companion lock, HP carry, revive cost, star spending, chest limits
