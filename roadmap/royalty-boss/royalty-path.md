# Royalty path: boss chain, fight and ranking

Feature `royalty-boss`, module `royalty-path`. Client: `M11/royaltyboss/*`, `CM/yishi/manager/RoyaltyBossManager.as`, `CM/mvc/module/royaltyboss/*`, `CM/mvc/controler/RoyaltyBossController.as`. Conventions: see [README.md](README.md).

---

## 1. Overview

- 600 bosses (`RoyaltyBossTemplates.xml`, `Level` 1..600) must be beaten in order, one at a time, solo.
- The player sees the next three bosses (`passBossLevel + 1 .. + 3`); only the first one is clickable. Clicking it opens "Desafiar Chefão" with the recommended Theseus soul value, the recommended armour value, the boss condition skill and the drop.
- "Desafiar" sends opcode 8674 without body. The server starts a battle of type 3902. A win raises `passBossLevel` by one, grants `DropItem` and recomputes the royalty level. The server pushes 4292 with the new values.
- In this battle only the player's own attributes plus the Theseus armour attributes count ("Sua força no Caminho da Realeza foi selada", `royaltyFightFrame.descTxt.text`). The dragon talker is not allowed (help item 6).
- A ranking ("Ranking do Chefão da Realeza") is a static XML regenerated every day at 00:00 (help item 5).

---

## 2. Screens

| Class (file) | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `royaltyboss.RoyaltyBossFrame` (`M11/royaltyboss/RoyaltyBossFrame.as`), 760x565, controller `royaltyboss` openType default (`CM/mvc/controler/RoyaltyBossController.as:49-60`) | "Caminho da Realeza" (`royaltyBossFrame.titleText`) | Boss chain and royalty level browser | NPC option 156 (`CM/yishi/SwitchPageHelp.as:3041-3063`), return from battle 3902 | Left: up to 3 `RoyaltyBossItem` for `passBossLevel+1..+3` (`:184-211`); "Já derrotou todos os chefões da Realeza" when none (`:207-210`). Right: next royalty level number `royaltyLevel+1` and "Ainda precisa matar {n} BOSS" with `n = RoyaltyTemplates[royaltyLevel+1].BossLevel - passBossLevel` (`:274-283`); "Já passou do Caminho da Realeza" when level 40 is reached (`:284-294`). Bottom: horizontal roll of 40 `RoyaltyLevelItem`, grey above the current level (`RoyaltyLevelItem.as:63-72`); selecting one lists what that level newly unlocks (difference with the previous level) and the attribute lines of its `SkillId` description (`:295-459`). Buttons: "Ranking" (`:235-245`), help (`:229-233`) |
| `royaltyboss.RoyaltyBossItem` (`M11/royaltyboss/RoyaltyBossItem.as`) | none | One boss card | `RoyaltyBossFrame`, `RoyaltyFightFrame` | Icon `HeroIcon`, name from `GameHeroTemp` of the first `Heros` id, "Nv. {Level}" (`:80-94`). Index 1 clickable (opens fight frame), index > 1 grey, click shows "Chefe não desbloqueado" (`:68-78`) |
| `royaltyboss.RoyaltyFightFrame` (`M11/royaltyboss/RoyaltyFightFrame.as`), 383x413, openType 2 | "Desafiar Chefão" (`royaltyFightFrame.titleText`) | Boss detail and fight button | Boss card index 1 | Boss `passBossLevel+1` (`:198-201`); `SoulValue` (recommended Theseus soul power), `ArmourValue` coloured frame 2 when `theseussoul.propertys.armour >= ArmourValue`, else frame 1 (`:148-157`); condition text = description of skill `BossSkill` wrapped in `apex.team.str13` (`:158-162`); reward icons from `DropItem` "tid,count\|..." (`:164-180`). Buttons: armour button opens Poseidon shop (`:132-135`), fight button (`:137-140`) |
| `royaltyboss.RoyaltyRankFrame` (`M11/royaltyboss/RoyaltyRankFrame.as`), openType 3 | "Ranking do Chefão da Realeza" | Ranking list | "Ranking" button after the XML is loaded (`RoyaltyBossFrame.as:235-245`) | Columns "Rank", "Nome", "Nível de Realeza", "Nível do Chefão da Realeza" from `model.rankList` (`:100-117`, `RoyaltyRankItem.as`) |
| `royaltyboss.RoyaltyPropertyItem` | none | One unlock or attribute line | `RoyaltyBossFrame` | frame 2 = unlock line, frame 1 = attribute line |

---

## 3. Routes (client to server)

| # | UI control | Client sender (file:line) | Client checks | Route | Request | Expected response |
|---|---|---|---|---|---|---|
| R1 | "Desafiar" button of `RoyaltyFightFrame` | `RoyaltyFightFrame.__fightBtnClickHandler` (`M11/royaltyboss/RoyaltyFightFrame.as:137-140`) → `RoyaltyBossManager.sendFight` (`CM/yishi/manager/RoyaltyBossManager.as:69-73`) | None in the frame. The frame can only be opened for boss `passBossLevel + 1`; the NPC entry already checked knight job change, quest 1100 and scene | client → server **8674 (0x21e2) C_ROYALTY_CLIENT_OP** | No body (`new PackageOut(8674)` sent with `SocketSendManager.send`) | Battle sequence: 64 skill bar, **157** `U_B_PREPARE` with battleType 3902, then the engine flow of `docs/battle/server-engine.md` §1 (156, 153..., 154, 4103). After a win, **4292** with the new progress and the reward pushes (currency and bag). On refusal: nothing *(assumption, no error message exists)* |
| R2 | "Ranking" button | `RoyaltyBossFrame.__rankBtnClickHandler` (`M11/royaltyboss/RoyaltyBossFrame.as:235-239`) → `RoyaltyBossManager.loadRoyaltyRankData` (`CM/yishi/manager/RoyaltyBossManager.as:75-79`) | none | HTTP GET `{TPL}royalty.xml` (`PathManager.royaltyRankPath`, `CM/yishi/manager/PathManager.as:938-941`; `routes/routes.md` row `royaltyRankPath`) | none | XML document, see §4 |
| R3 | Armour button | `RoyaltyFightFrame.__armorBtnClickHandler` (`:132-135`) → `SwitchPageHelp.openPoseidonFrame` (`CM/yishi/SwitchPageHelp.as:3065-3074`) | royalty level >= `getLockLv(1)` = 1, else tip "Abre com Realeza Nv. {0}" | none (opens `poseidonshop`, shops feature) | | |
| R4 | Level roll, help, close | client only | | none | | |

---

## 4. Server messages (server to client)

| Opcode | Name | Message, fields | Client receiver (file:line) | When to send | Client reaction |
|---|---|---|---|---|---|
| **4292 (0x10c4)** | U_C_ROYALTY_DATA | `simple.PropertyMsg`: `param1 (#1, INT32)` royalty level 0..40; `param2 (#2, INT32)` passBossLevel 0..600. Other fields unused: `param3 (#3, INT32)`, `param4 (#4, STRING)`, `param5 (#5, STRING)`, `param6 (#6, STRING)`, `param7 (#7, BOOL)`, `param8 (#8, BOOL)`, `param9 (#9, BOOL)`, `param10 (#10, INT32)`, `param11 (#11, INT32)`, `param12 (#12, STRING)` | `RoyaltyBossManager.__royaltyDataHandler` (`CM/yishi/manager/RoyaltyBossManager.as:58-67`), listener registered at login by `RoyaltyBossManager.setup` (`CM/yishi/lunch/Yishi.as:539`) | At login, before any frame that reads the royalty level (Theseus, smith tabs, currency bar); after every won royalty fight | Stores `royaltyLevel` and `passBossLevel`, recomputes Theseus red dots (`TheseussoulModel.checkEquipRed`), fires `ROYALTYBOSS_LV_EVENT` (main tool bar refreshes the Theseus child button after 1 s, `CM/ui/maintoolbar/MainToolBar.as:585-600`). The open `RoyaltyBossFrame` does not listen: it is rebuilt when reopened after the battle |
| 157, 156, 153, 154, 4103 | battle | Battle engine messages (`docs/battle/server-engine.md`) | battle module | Response to R1 | `BattleResultHandler` marks `isRoyaltyBossBattle` (`CM/battle/handler/BattleResultHandler.as:489-492`); the hub scene reopens `royaltyboss` (`M3/map/space/SpaceSceneController.as:442-445`, `M4/castle/CastleSceneView.as:327-330`) |
| HTTP `royalty.xml` | ranking file | `<... ><item Order="1" NickName="..." RoyaltyLevel="40" BossLevel="600"/>...` (attributes read with `XML(param2)..item`, `CM/yishi/manager/RoyaltyBossManager.as:81-96`) | `RoyaltyBossManager.__royaltyRankLoadCompleteHandler` | Regenerated daily at 00:00 | Fills `rankList` (Order, NickName, RoyaltyLevel, BossLevel), notifies `ROYALTY_RANKDATA_LOAD_COMPLETE`, opens the rank frame |

No error code exists for this feature.

---

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Next boss | `RoyaltyBossTemplates.Level == passBossLevel + 1`; none after 600 | `RoyaltyFightFrame.as:198-201`; `RoyaltyBossTempCate.getTempInfoByLevel` (`CM/yishi/datas/templates/cate/RoyaltyBossTempCate.as:36-47`) |
| Royalty level | `max(RoyaltyLevel)` such that `RoyaltyTemplates.BossLevel <= passBossLevel`, 0 when `passBossLevel = 0` *(derived: level 1 needs 1 kill, the frame shows `BossLevel(next) - passBossLevel` kills left, `RoyaltyBossFrame.as:274-283`)* | `RoyaltyTemplates.xml` |
| Kill reward | Every boss: `DropItem` = `-19000,200` (200 "Gema Poseidon") | `RoyaltyBossTemplates.xml` (600 rows, all identical) |
| Retries | Unlimited, no cost, no daily limit *(assumption: no counter exists in the client or the templates)* | |
| Boss handicap | `BossSkill` 84101001 "Diminui dano recebido em 90%" (buffer 84101001 `ValuePercent=-90`, `SkillBufferTempInfos.xml`), description "Não alcançou o valor da armadura: redução de 90% no dano". Apply it only when the player's Theseus armour `< ArmourValue` *(assumption from the skill description and the frame colouring, `RoyaltyFightFrame.as:150-157`; the forbidden boss help text states the same rule)* | `RoyaltyBossTemplates.xml`, `SkillTempInfos.xml` |
| `ArmourValue` | 0 at level 1, 25 at 2, ... 14783 at 600 | template |
| `SoulValue` | 1461 at level 1 .. 178192 at 600; display only (recommended Theseus soul power) | template |
| Allowed power | Own hero attributes plus Theseus armour attributes; other systems sealed; no dragon talker; sealed skill (Q) locked in battle 3902 (`CM/battle/view/ui/SkillItemListView.as:197`) | `royaltyFightFrame.descTxt.text`, help items 3 and 6 |
| Ranking reset | Daily at 00:00 | help item 5 |

---

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `raw/xml/tempinfos/RoyaltyBossTemplates.xml` (600 rows), class `RoyaltyBossTempInfo` (`CM/yishi/datas/templates/RoyaltyBossTempInfo.as`), loaded `TempleteManager.as:1357` | One boss of the chain | `Id` 10001..10600; `Level` 1..600 (chain index); `BossSkill` handicap skill (84101001 everywhere); `ArmourValue` recommended Theseus armour; `SoulValue` recommended soul power; `Heros` "heroTemplateId,position" (`5100001,5` .. `5100600,5`, `GameHeroTemp.xml`); `HeroIcon` icon path; `Soldiers` empty everywhere (no soldiers); `DropItem` "tid,count\|..." |
| `raw/xml/tempinfos/RoyaltyTemplates.xml` | One royalty level | See [royalty-levels.md](royalty-levels.md) |
| `raw/xml/tempinfos/GameHeroTemp.xml` rows 5100001..5100600 | Boss hero | `TemplateName`, `Icon`, `Grades`, combat stats, `DefaultSkill`, `AI` |
| `raw/xml/tempinfos/SkillTempInfos.xml` 84101001 and 84102001..84102040 | Handicap skill and royalty attribute skill | `Description` |
| `index/language.json` keys `royaltyBossFrame.*`, `royaltyFightFrame.*`, `royaltyRankFrame.*`, `royaltyBossItem.*`, `royaltyLevelItem.*` | UI strings | |

---

## 7. Persistent state (PostgreSQL, schema `royalty_boss`)

```sql
CREATE SCHEMA IF NOT EXISTS royalty_boss;

CREATE TABLE royalty_boss.progress (
  player_id        integer     PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
  pass_boss_level  smallint    NOT NULL DEFAULT 0 CHECK (pass_boss_level BETWEEN 0 AND 600),
  royalty_level    smallint    NOT NULL DEFAULT 0 CHECK (royalty_level BETWEEN 0 AND 40),
  last_kill_at     timestamptz,
  updated_at       timestamptz NOT NULL DEFAULT now()
);
CREATE INDEX progress_rank ON royalty_boss.progress (royalty_level DESC, pass_boss_level DESC, last_kill_at ASC);

CREATE TABLE royalty_boss.fight_log (
  fight_id     bigserial   PRIMARY KEY,
  player_id    integer     NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  boss_level   smallint    NOT NULL CHECK (boss_level BETWEEN 1 AND 600),
  won          boolean     NOT NULL,
  battle_id    bigint,
  created_at   timestamptz NOT NULL DEFAULT now()
);
CREATE INDEX fight_log_player ON royalty_boss.fight_log (player_id, created_at DESC);

CREATE TABLE royalty_boss.rank_snapshot (
  snapshot_date  date        NOT NULL,
  rank_order     integer     NOT NULL CHECK (rank_order > 0),
  player_id      integer     NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  nickname       text        NOT NULL,
  royalty_level  smallint    NOT NULL,
  boss_level     smallint    NOT NULL,
  PRIMARY KEY (snapshot_date, rank_order)
);
```

`royalty_level` is stored denormalized so that every other feature can read it cheaply; it must always equal the formula of §5.

---

## 8. Backend implementation notes

| Handler | Route | Validation order | Transaction and pushes |
|---|---|---|---|
| `royalty_boss::royalty_path::handle_fight` | 8674 | 1. player not in a battle, room or campaign map; 2. `vocation` changed (knight job change); 3. quest 1100 finished; 4. `pass_boss_level < 600`; 5. load `RoyaltyBossTemplates[pass+1]` | No DB write before the battle. Build and start the battle (below). On battle end (win): one tx: `pass_boss_level += 1`, recompute `royalty_level`, insert `fight_log`, grant `DropItem` (currency -19000 via currency service). After commit: push 4292 `{param1 = royalty_level, param2 = pass_boss_level}`, currency push, and if the royalty level changed run the level-up hooks of [royalty-levels.md](royalty-levels.md) §8. On loss: insert `fight_log` only |
| `royalty_boss::royalty_path::send_login` | login hook | none | Push 4292 |
| `royalty_boss::royalty_path::build_rank_file` | daily job 00:00 | none | Select top N *(assumption: 100)* from `progress` ordered by `royalty_level DESC, pass_boss_level DESC, last_kill_at ASC`, write `rank_snapshot` and serve `royalty.xml` under the template path (`<items><item Order NickName RoyaltyLevel BossLevel/></items>`, root name free, the client reads `..item`) |

Battle configuration (battle engine rule, see `docs/battle/server-engine.md` §9):
- `battle_type = 3902`; map: any boss arena *(assumption: the royalty map id is not known; use the battle ground of the current scene)*.
- Player side: the hero alone, no soldiers, no pets, no dragon talker. Stats: base hero attributes plus Theseus armour attributes only *(assumption: exact list of "sealed" sources is server side)*.
- Enemy side: one boss hero per `Heros` pair (`5100xxx` at position 5), level from `GameHeroTemp.Grades`; no soldiers.
- If player armour `< ArmourValue`, attach buffer 84101001 (damage taken by the boss -90%) to the boss at start.
- Report 4103 then result handling above.

---

## 9. Open questions and assumptions

- *(assumption)* Royalty level formula derived from the frame text; verify against a live server if possible.
- *(assumption)* No daily attempt limit, no stamina cost.
- *(assumption)* The 90% handicap applies only below `ArmourValue`.
- Map id of battle 3902 and the boss AI timing are unknown.
- The ranking file size (top N) and tie order are unknown.
- The server must also refuse 8674 when `pass_boss_level = 600`; the client never sends it then because no boss card exists.

---

## 10. Implementation checklist

- [ ] Loader `RoyaltyBossTemplates.xml` (600 rows) and `GameHeroTemp` 5100001..5100600.
- [ ] Table `royalty_boss.progress`, `fight_log`, `rank_snapshot`.
- [ ] Login push 4292 (`PropertyMsg` param1, param2).
- [ ] Route 8674 with validation (job change, quest 1100, chain end).
- [ ] Battle 3902 configuration: hero only, boss heroes, conditional buffer 84101001.
- [ ] Win: pass + 1, royalty level recompute, `-19000 x200`, push 4292.
- [ ] Return scene flag `isRoyaltyBossBattle` reopens the frame (client side, no work).
- [ ] Daily job writing `royalty.xml`.
- [ ] Screen check: `RoyaltyBossFrame` kills-left text, level roll unlock lines, `RoyaltyFightFrame` armour colour, rank frame.
- [ ] Test: player with pass 0 sees boss 1..3, fights boss 1, receives 200 Poseidon gems, royalty level becomes 1 and 4292 arrives.
- [ ] Test: pass 15 to 16 raises level 1 to 2.
- [ ] Test: 8674 at pass 600 is ignored.
