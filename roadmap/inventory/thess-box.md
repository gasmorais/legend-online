# Theseus challenge ("Desafio de Teseus", proto package `storehouse`)

Module of [README.md](README.md). The proto package `storehouse` (internal name "秘宝探险", treasure exploration) is not a storage: it is the Theseus chapter challenge whose chapters drop treasure chests (collection chests 3501..3505, [boxes.md](boxes.md)). Screens are in the client package `thessbox`, owned by [../theseus/README.md](../theseus/README.md); this module documents the protocol of the package.

Path aliases:

| Alias | File |
|---|---|
| TSM | `decompiled/core_module/scripts/managers/TheseussoulManager.as` |
| TBMF | `decompiled/m3/scripts/thessbox/ThessBoxMainFrame.as` |
| TBCI | `decompiled/m3/scripts/thessbox/view/ThessBoxCapterItem.as` |
| TBCV | `decompiled/m3/scripts/thessbox/view/ThessBoxChooseView.as` |
| TBDF | `decompiled/m3/scripts/thessbox/ThessBoxDropFrame.as` |
| TBBV | `decompiled/m3/scripts/thessbox/view/ThessBoxBagView.as` |

## 1. Overview

- 20 chapters (`StoreHouseChapterTmpls.xml`), each a campaign (`CampaignId` 50101..) of floors (maps 40101.. in `StoreHouseMapTmpls.xml`). Every 5 floors give drops; the first clear of a chapter gives `FirstPassAward`.
- 3 challenge attempts per day, reset at 24:00 (config `Storehouse_count = 3`; help text `thessbox.helpContent`).
- During a run the hero carries up to 3 equipped challenge skills chosen from skills gained on floors (`Storehouse_MainSkill = 90100000|90200000|90300000` main skill groups; floor `SkillGroup` weights); after some floors the server offers 3 skills and the player picks one ("Escolha uma das três habilidades acima como prêmio").
- Entry: castle or space scene building and `SwitchPageHelp` (`decompiled/core_module/scripts/yishi/SwitchPageHelp.as:3196`, `decompiled/m4/scripts/castle/CastleSceneView.as:360`, `decompiled/m3/scripts/map/space/SpaceSceneController.as:496`).

## 2. Screens (owned by Theseus)

| Class | pt-BR title | Purpose |
|---|---|---|
| `thessbox.ThessBoxMainFrame` (837 x 546) | "Desafio de Teseus" (`thessbox.mainTitle`) | chapter list with first clear rewards ("Prêmio de Primeira Conclusão do Capítulo") and drop preview ("Prévia de Drop do Capítulo"), "Tentativas de desafio restantes: {0}/{1}"; requests data on open (`TBMF:32`) |
| `ThessBoxCapterItem` | | fight button for chapter `passChapter + 1` and replays of cleared chapters, reward button when the first clear reward is pending (`TBCI:103-176`) |
| `thessbox.ThessBoxDropFrame` / `ThessBoxChooseView` | "Habilidade de Bênção" (`thesebox.addDesSK`) | pick one of three offered skills (`TBCV:53-60`) |
| `thessbox.ThessBoxSkillBagFrame`, `ThessBoxBagView` | "Mochila de habilidades", "Habilidade Atual", "Habilidades Obtidas" | equipped skills (3) and gained skills with summed attributes (`TBBV:90-120`); equipping is local (`decompiled/m3/scripts/thessbox/ui/ThessBoxSkillCellClickMediator.as:50-68`) |

## 3. Routes (client to server)

All: C>S 9761 (0x2621) `C_STORE_HOUSE_CLIENT_OP`, message `player.PlayerOpMsg` (fields in [slate.md](slate.md) section 3), sender `TSM.opThessbox(op, chapterId)` (`TSM:607-614`).

| Op (`op` #1) | `chapterId` (#11) | Action | Sender | Client checks | Expected response |
|---:|---|---|---|---|---|
| 0 | 0 | load state | `TBMF:32` | | 769 |
| 1 | chapter id | start the chapter challenge | `TBCI:166-176` | attempts left (`3 - count > 0`) else "Tentativas de Desafio Insuficientes" (`thesebox.chapterNoFight`); chapter is cleared or the next one | 769 (count), 770 (run state), scene change to the chapter campaign (assumption, campaign feature) |
| 2 | chapter id | claim the first clear reward | `TBCI:160-164` | chapter cleared and reward pending | 769 (updated `firstReward`), 115 items |
| 3 | skill id (in `chapterId`) | choose one offered skill | `TBCV:53-60` | an option selected | 770 with `type = 3` and `addSkill` (fly animation, `TBDF:105-117`) |

## 4. Server messages (server to client)

| Opcode | Message | Receiver | Meaning |
|---|---|---|---|
| 769 (0x0301) `U_C_STOREHOUSE_USER_DATA` | `storehouse.StoreHouseUseMsg`: `opType` (#1, INT32) echo; `count` (#2, INT32) attempts used today; `passChapter` (#3, INT32) highest cleared chapter; `firstReward` (#4, STRING) comma list of chapter ids whose first clear reward is still claimable | `TSM.__thessBoxDataHandler` (`TSM:624-634`) -> `EVENT_BOX_USER` | answer to ops 0, 1, 2 |
| 770 (0x0302) `U_C_STOREHOUSE_FIGHT_DATA` | `storehouse.StoreHouseFightMsg`: `type` (#1, INT32) 3 = a skill was just added; `curLevel` (#2, INT32) current floor; `chapterId` (#3, INT32); `mapId` (#4, INT32) current floor map; `equipSkills` (#5, STRING) 3 equipped skill ids "a,b,c" (-1 empty); `allSkills` (#6, INT32, repeated) gained skills; `addSkill` (#7, INT32) skill just added | `TSM.__thessBoxFightDataHandler` (`TSM:636-649`) -> `EVENT_BOX_FIGHT` | run state during the challenge |
| 771 (0x0303) `U_C_STOREHOUSE_ADD_SKILL` | `storehouse.StoreHouseAddSkillMsg`: `addSkills` (#1, INT32, repeated) three offered skill ids | `TSM.__thessBoxADDSKHandler` (`TSM:616-622`) opens `ThessBoxDropFrame` | after the floors that grant a skill choice |
| (none) | `storehouse.StoreHouseRankListMsg` (`ranks` #1 repeated `StoreHouseRankMsg`: `rank` #1, `level` #2, `nickName` #3) | no client user; rank texts `thessbox.rank.*` exist | unused in this build |

## 5. Rules and formulas

- Daily attempts: 3 (`Storehouse_count`), reset at 00:00; an attempt is consumed when a chapter starts.
- Chapter order: chapter `n + 1` unlocks after clearing `n`; cleared chapters can be replayed.
- Drops: every 5 floors (`thessbox.empetyTip` "Baús de Drop extras podem ser obtidos a cada cinco andares."), chests 3501 / 3502 (`PassDropAward`); first clear `FirstPassAward = 3501,2|3502,2`.
- Skill offers: three skill ids drawn from the floor `SkillGroup` (`skillId,weight|...`), one kept.

## 6. Templates

| File | Record | Fields |
|---|---|---|
| `raw/xml/tempinfos/StoreHouseChapterTmpls.xml` | `StoreHouseChapterTmpl` (20) | `Id`, `ChaptersName` ("Desafio de Teseus - Capítulo N"), `CampaignId`, `Icon`, `FirstPassAward` (`template,count|...`), `PassDropAward` (template ids) |
| `raw/xml/tempinfos/StoreHouseMapTmpls.xml` | `StoreHouseMapTmpl` (530) | `MapId`, `Chapters`, `SkillGroup` (`skill,weight|...`), `Award` |
| `raw/xml/tempinfos/ConfigInfos.xml` | `Storehouse_count = 3`, `Storehouse_MainSkill = 90100000|90200000|90300000` | |

Loaded by `decompiled/core_module/scripts/yishi/manager/TempleteManager.as:1425-1426`.

## 7. Persistent state

```sql
CREATE TABLE inventory.thess_box_progress (
  player_id        BIGINT     PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
  passed_chapter   SMALLINT    NOT NULL DEFAULT 0 CHECK (passed_chapter BETWEEN 0 AND 20),
  attempts_used    SMALLINT    NOT NULL DEFAULT 0 CHECK (attempts_used >= 0),
  attempts_day     DATE        NOT NULL DEFAULT current_date
);

CREATE TABLE inventory.thess_box_first_rewards (
  player_id   BIGINT     NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  chapter_id  SMALLINT    NOT NULL,
  claimed_at  TIMESTAMPTZ,
  PRIMARY KEY (player_id, chapter_id)
);

CREATE TABLE inventory.thess_box_runs (
  player_id      BIGINT     PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
  chapter_id     SMALLINT    NOT NULL,
  current_floor  SMALLINT    NOT NULL DEFAULT 1,
  map_id         INTEGER     NOT NULL,
  equipped_skills INTEGER[]  NOT NULL DEFAULT '{-1,-1,-1}',
  gained_skills  INTEGER[]   NOT NULL DEFAULT '{}',
  pending_offer  INTEGER[],
  started_at     TIMESTAMPTZ NOT NULL DEFAULT now()
);
```

Assumption: the owning schema may move to `theseus` when that feature is implemented; the tables are listed here because the package is assigned to inventory.

## 8. Backend implementation notes

- `inventory::thess_box::handle_op` (9761): op 0 -> push 769; op 1 -> daily reset, attempts < 3, chapter allowed -> create run, consume attempt -> push 769, 770 -> start the campaign `CampaignId` (campaign feature; battles per floor configured by the map templates, see [../campaign/README.md](../campaign/README.md) and docs/battle/server-engine.md); op 2 -> chapter cleared and reward unclaimed -> grant `FirstPassAward` (115) -> push 769; op 3 -> skill in `pending_offer` -> add to gained skills -> push 770 with `type 3`.
- Floor clear hook (from campaign): advance floor, every 5 floors grant `PassDropAward`, when the floor grants a skill choice push 771, at the last floor mark the chapter cleared and add it to `firstReward`.

## 9. Open questions and assumptions

- Which floors offer skills and how many floors each chapter has (from `StoreHouseMapTmpls.Chapters`).
- Whether equipped challenge skills are sent to the server (no client route found; assumption: the server uses the first three gained skills or the battle request carries them).
- Rank message unused.

## 10. Implementation checklist

- [ ] Route 9761 ops 0..3
- [ ] Pushes 769, 770, 771
- [ ] Daily attempts reset
- [ ] Chapter run state and floor hooks with the campaign feature
- [ ] Tables `inventory.thess_box_progress`, `inventory.thess_box_first_rewards`, `inventory.thess_box_runs`
- [ ] Tests: fourth attempt refused, first reward claimed twice refused
