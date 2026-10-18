# Card battle effects: passive skills, mode buffs and power bonus

Scope: how activated cards act in battle. Each card grade grants one passive skill that applies only in the game mode bound to the card's series. This module covers the mode mapping, the skill and buff data, the injection of card skills into battles, the "Adição de Cartas" buff indicator (4903), the per-mode power bonus list (4902) and the unused 4904. Card ownership and grades come from [collection.md](collection.md).

Path aliases:

| Alias | File |
|---|---|
| MCM | `decompiled/core_module/scripts/yishi/manager/MagicCardManager.as` |
| MODEL | `decompiled/core_module/scripts/mvc/module/card/MagicCardModel.as` |
| FIGHT | `decompiled/core_module/scripts/mvc/module/card/MagicCardFightInfo.as` |
| BUFF | `decompiled/core_module/scripts/mvc/module/card/MagicCardBuffInfo.as` |
| BUFFENUM | `decompiled/core_module/scripts/mvc/module/card/enums/MagicCardBuffEnums.as` |
| SUITENUM | `decompiled/core_module/scripts/mvc/module/card/enums/MagicCardSuitEnums.as` |
| TOP | `decompiled/core_module/scripts/ui/toptoolbar/TopToolsBar.as` |
| EXTRA | `decompiled/core_module/scripts/ui/toptoolbar/view/ExtraBufferItem.as` |
| PTT | `decompiled/core_module/scripts/yishi/datas/consant/ProtocolTypeTable.as` |

Battle references: [docs/battle/server-engine.md](../../docs/battle/server-engine.md) (unit entries, skill choice, configuration), [docs/battle/rules.md](../../docs/battle/rules.md), [docs/mechanics/skills_buffs.md](../../docs/mechanics/skills_buffs.md) (SkillTempInfos and SkillBufferTempInfos fields), [docs/mechanics/units_combat.md](../../docs/mechanics/units_combat.md) section 4.5.

## 1. Overview

- A card series (`Types`) works in exactly one mode (`ActiveScene` = `Types` in every template row). The series description is shown on the board (`magicCard.view.cardDscTxt{type}`, `decompiled/m5/scripts/magicCard/view/MagicCardSlotView.as:212`).
- Effect = the skills listed in `SkillTempIds` of the card's current grade row. All card skills are passive (`UseWay` 2), appear at battle start (`AppearTime` 1) and target the owner (`AcceptObject` 4); each skill applies one buff with the same id from `SkillBufferTempInfos`.
- The client never computes card effects. The server must inject the skills into the player's hero when building a battle of the matching mode, and may push:
  - 4903 `U_C_POWCARD_BUF_ON`: the list of card buffs active for the player's current mode, shown as a top bar buff icon.
  - 4902 `U_C_POWCARD_Fight_ADD`: the power ("Poder") bonus per mode; stored by the client but not displayed.
- 4904 `U_C_POWCARD_BUF` has no client listener; do not send it.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| EXTRA `ExtraBufferItem` type 10 | "Adição de Cartas" (`yishi.view.resourceBar.ExtraBufferTitle10`, EXTRA `:176`) | Top bar buff icon `asset.resourceBar.ExtraBufferIcon_10` (EXTRA `:175`) | Added by `TopToolsBar` when `cardCampBuffList.length > 0` (TOP `:1996-2003`); the bar rebuilds on `MAGICCARD_CAMPAIGN_BUFF` (TOP `:457`) | Tooltip lines from `MODEL.buffContent(MagicCardBuffInfo)` (EXTRA `:271-275`), which returns "" in the BR client (MODEL `:295-298`), so the tooltip shows only the title |
| Board series text (see [collection.md](collection.md)) | `magicCard.view.cardDscTxt1..5` | Tells which mode a series affects | Card frame | Static text |

No battle HUD element shows card skills; buffs with an empty `Icon` (all card buffs) are not drawn on units (see `docs/mechanics/skills_buffs.md` section 4.1).

## 3. Routes (client to server)

None. This module has no client request. Battle bonuses are recomputed by the server after the collection routes in [collection.md](collection.md) (9505 op 1/2/3 and item use 5006) and when the player enters or leaves a mode scene.

## 4. Server messages (server to client)

### S1. 4903 (0x1327) `U_C_POWCARD_BUF_ON` ("卡牌副本Buff", card instance buff, PTT `:538`)
- Message `powcard.PowCardBufListMsg`: `bufInfos` (#1, MESSAGE `PowCardBufMsg`, repeated).
- `powcard.PowCardBufMsg`:
  - `sonType` (#1, INT32): buff category; BUFFENUM `:10-16` defines 1001 `SONTYPE_EFFEC`, 1003 `SONTYPE_SKILL`, 1004 `SONTYPE_CAMPAIGN`, 1006 `SONTYPE_GOD`. Card skills should use 1003.
  - `bufId` (#2, INT32): buff id (`SkillBufferTempInfos.Id` = card skill id).
  - `fixValue` (#3, INT32): flat value (`AttackValue`).
  - `percent` (#4, INT32): percent value (`ValuePercent`).
- Receiver: `MagicCardManager.__cardCampaignBuffHandler` (MCM `:54`, `:78-96`) maps each entry to `MagicCardBuffInfo` (BUFF), replaces `cardCampBuffList` (`MODEL.updateCampaignBuff`, MODEL `:243-250`) and dispatches `MAGICCARD_CAMPAIGN_BUFF`; `TopToolsBar.show` then adds or removes the type 10 icon (TOP `:457`, `:1996-2003`).
- When (assumption, from the opcode description and the client usage): push when the player enters a scene or room of a mode bound to a series in which he has activated cards (list of that series' buffs), and push an empty list when he leaves it. Also push after a 9505 change while inside such a mode. An empty list hides the icon.

### S2. 4902 (0x1326) `U_C_POWCARD_Fight_ADD` ("卡牌查看战斗力加成", card power bonus view, PTT `:537`)
- Message `powcard.PowcardFightAddMsg`: `singlefightadd` (#1, MESSAGE `Singlefightadd`, repeated).
- `powcard.Singlefightadd`:
  - `op` (#1, INT32): meaning unknown, copied to `MagicCardFightInfo.op` (FIGHT `:6`).
  - `userid` (#2, INT32): owner player id.
  - `CampType` (#3, INT32, client property `campType`): mode code, one of SUITENUM `:6-24` (table in section 5).
  - `add` (#4, INT32): power bonus for that mode.
- Receiver: `MagicCardManager.__cardFightAddHandler` (MCM `:56`, `:59-76`), stores `cardModel.cardFightInfoList`; no UI reads it in the BR client. The label builder `MODEL.getFightText(campType)` (MODEL `:272-293`) would render "Campanha Multiplayer Poder +", "Torre do Julgamento Poder +", "Labirinto Poder +", "Arena Poder +" or "Campo de Batalha Poder +" (no caller).
- When: on login and after any card change (assumption). One entry per mode with a non-zero bonus.
- The same shape exists as `simple.SimplePowCardFightInfoMsg` (`op` #1, `userid` #2, `CampType` #3, `add` #4) and as `PowCardFightInfo` XML nodes in ranking files (see [viewing-sharing.md](viewing-sharing.md)).

### S3. 4904 (0x1328) `U_C_POWCARD_BUF` ("卡牌Buff", PTT `:539`)
- Constant only (`decompiled/core_module/scripts/yishi/datas/consant/AcceptProtocolType.as:1032`). No listener anywhere in the client; message type unknown. Do not send.

### Related unused client data
- `MagicCardBuffEnums.CARD_BUFF_SLOT = 1`, `CARD_BUFF_SUIT = 2` (BUFFENUM `:6-8`) and `PlayerBufferType.MAGICCARD_BUFFER = 5` (`decompiled/core_module/scripts/yishi/datas/consant/PlayerBufferType.as:24`) are never read.
- `powcard.PowCardSuiteListMsg` / `PowCardSuiteMsg` (`suiteId` #1, `bufInfos` #2 repeated `PowCardBufMsg`, `cardInfos` #3 repeated `PowCardInfoMsg`) and `powcard.PowCardInfoMsg` (`tempId` #1, `grade` #2, `gp` #3, `buf` #4 `PowCardBufMsg`, `isActive` #5 INT32) are generated but never decoded by any handler. They belong to the removed suit system.

## 5. Rules and formulas

### Mode mapping

| Card `Types` | Series | Mode text (`cardDscTxt`) | Camp type (SUITENUM) | `getFightText` label | Owning feature (link) |
|---:|---|---|---:|---|---|
| 1 | Tau | campanha de multiplayer, excluding event campaigns | 800 `CAMPAIGN_MULTI` | "Campanha Multiplayer" | [campaign](../campaign/README.md) |
| 2 | Imortal | labirinto subterrâneo, labirinto do abismo, labirinto do purgatório | 802 `CAMPAIGN_TOWER` | "Labirinto" | [mazes](../mazes/README.md) |
| 3 | Luz | arena multiplayer | 806 `MATCH_PVP` | "Arena" | [arena](../arena/README.md) |
| 4 | Trevas | campo de batalha, against players and NPC | 807 `WARFIELD_BATTLE` | "Campo de Batalha" | [world-boss](../world-boss/README.md) (assumption: the "Campo de Batalha" RVR map) |
| 5 | Arma Antiga | torre de julgamento | 801 `TRIAL_TOWER` | "Torre do Julgamento" | [trials](../trials/README.md) |

Other camp type constants with no card series: 799 `CAMPAIGN_ONE`, 803 `FROM_GODADD`, 804 `KING_TOWER`, 805 `WORLDBOSS_CAMPAIGN`, 808 `ARRET_FIGHT` (SUITENUM `:6-24`). The Types to camp type mapping above is an assumption built from `cardDscTxt{type}` and `getFightText` (MODEL `:275-291`); the template field `ActiveScene` (1..5) is the series id, not a camp type.

### Skills per position (same pattern in all 5 series)

Skill id = `403` + type (2 digits) + pos (1 digit) + grade (2 digits), for example 40301101 (type 1, pos 1, grade 1) .. 40305409 (type 5, pos 4, grade 9). Buff id = skill id. All buffs: `AttackData` 1 (beneficial), `AddWay` 1, `Dispel` 1, empty `Icon`.

| Pos | Effect (grade g = 1..9) | Buff `AttackType` / `AttackWay` / `ValidCount` | Values |
|---:|---|---|---|
| 1 | "Diminui X% do dano recebido", X = 3g + 3 (6..30) | 15 damage received % / 2 on taking damage / -1 permanent | `ValuePercent` = -(3g + 3) |
| 2 | "Danos causados aumenta X%", X = 3g + 3 (6..30) | 40 damage up % / 3 on dealing damage / -1 | `ValuePercent` = 3g + 3 |
| 3 | "Tem X% de chance de diminuir 80% do dano recebido", X = g + 1 (2..10) | 15 / 2 / 1 | `ValuePercent` = -80 |
| 4, type 1 | "Cada ataque recupera adicionalmente X pontos de fúria", X = g + 1 (2..10) | 6 fury per action / 1 per act / -1 | `AttackValue` = g + 1 |
| 4, type 2 | "Sempre que atacar, tem X% de chance de recuperar 50% de sangue máximo", X = g + 1 | 33 instant heal % / 1 / 1 | `ValuePercent` = 50 |
| 4, type 3 | "Sempre que atacar, tem X% de chance de recuperar 20% de sangue máximo", X = 3g + 3 | 33 / 1 / 1 | `ValuePercent` = 20 |
| 4, type 4 | "Tem X% de chance para aumentar 150% dos danos", X = 3g + 3 | 40 / 3 / 1 | `ValuePercent` = 150 |
| 4, type 5 | "Cada ataque recupera X% de vida máxima", X = g + 1 | 33 / 1 / -1 | `ValuePercent` = g + 1 |

- Proc chances exist only in the skill names; `Parameter1..3` and `CountWay` are 0 for every card skill. The server must hold the chance table above (X per grade) for positions 3 and 4 (types 2, 3, 4).
- A player benefits from every activated card of the mode's series simultaneously (up to 4 skills). Non-activated cards give nothing.

### Power bonus (4902 `add`)
- No formula exists in the client or templates. Assumption: `add` = the hero fighting capacity increase granted by the series' card skills in that mode; if the hero feature does not model a fighting capacity for passives, send `add` = 0 or omit the entry. The equipment panel tip string "Não há adição de Poder" and "(Atributos de conjunto não adiciona ao Poder)" (`army.Equip.CardBtnTip.NotAdd`, `.SuitAdd`) suggest that cards were not meant to change the displayed global Poder (assumption).

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `raw/xml/tempinfos/MagicCardTempInfos.xml` | Card grade row | `Types`, `ActiveScene`, `Pos`, `Grades`, `SkillTempIds` |
| `raw/xml/tempinfos/SkillTempInfos.xml` | Card skill 403TTPGG | `TemplateName` (effect text with proc chance), `UseWay` 2, `AppearTime` 1, `AcceptObject` 4, `BufferIds` (= skill id), `Parameter1..3` 0, `CountWay` 0 |
| `raw/xml/tempinfos/SkillBufferTempInfos.xml` | Card buff (Id = skill id) | `BufferName`, `AttackType` (6, 15, 33, 40), `AttackWay` (1, 2, 3), `ValidCount` (-1 or 1), `AttackValue`, `ValuePercent`, `AttackData` 1, `AddWay` 1, `Dispel` 1 |

Field semantics: `docs/mechanics/skills_buffs.md` sections 1.2, 1.4, 4.1; enum `buff_attack_type` in `data/research/skills_buffs.json` (6 `sp_gain_on_action`, 15 `damage_received_pct`, 33 `instant_heal_pct`, 40 `damage_up_pct`).

## 7. Persistent state

No new table. Effects are derived from `magic_cards.player_cards` ([collection.md](collection.md)) at battle build time. Optional cache (only if battle setup latency matters):

```sql
-- Optional materialized view of active card skills per player and series.
CREATE MATERIALIZED VIEW magic_cards.player_card_skills AS
SELECT pc.player_id,
       pc.card_type,
       pc.card_template_id,
       pc.grade
FROM magic_cards.player_cards pc;
CREATE UNIQUE INDEX player_card_skills_pk ON magic_cards.player_card_skills (player_id, card_template_id);
CREATE INDEX player_card_skills_type_idx ON magic_cards.player_card_skills (player_id, card_type);
```

Skill ids are resolved from the template (`SkillTempIds` of `(card_template_id, grade)`), never stored.

## 8. Backend implementation notes

Service functions (no request opcode):

| Function | Purpose |
|---|---|
| `magic_cards::battle_effects::skills_for_mode(player_id, camp_type) -> Vec<u32>` | Map camp type to series, load activated cards of that series, return the concatenated `SkillTempIds` of each card's current grade |
| `magic_cards::battle_effects::push_mode_buffs(player_id, camp_type_or_none)` | Build and send 4903 (`sonType` 1003, `bufId` = skill id, `fixValue` = buff `AttackValue`, `percent` = buff `ValuePercent`); empty list when leaving |
| `magic_cards::battle_effects::push_fight_add(player_id)` | Build and send 4902, one `Singlefightadd` per camp type 800, 801, 802, 806, 807 with `op` = 0 (assumption), `userid`, `CampType`, `add` |

Battle configuration (see `docs/battle/server-engine.md` sections 9.2 and 9.3):
- When a battle is created for a player in a mode bound to a series (battle builders of campaign, mazes, arena, world-boss battlefield, trials), append `skills_for_mode` to the player hero's `skills` list. These skills are `UseWay` 2, so the engine must apply them as passives at battle start (`AppearTime` 1) instead of choosing them as actions (section 3.4 only picks `UseWay` 1). Engine work: apply each skill's `BufferIds` buff to the owner with `ValidCount` -1 (permanent) or as a triggered effect (`AttackWay` 1/2/3 with `ValidCount` 1) and the proc chance table from section 5.
- Include the skill ids in `HeroMsg.skillId` so the client preloads them (they have no effect resources, so preloading is harmless).
- Card skills must not be added in any other mode, including event campaigns for series 1 ("não inclui campanha de eventos").
- Multi-player battles (multiplayer campaign, arena): each participating player gets his own series skills; no sharing.

Triggers for pushes:
- On login: 4902.
- On entering/leaving a mode scene or room: 4903 (scene handlers of the owning features call `push_mode_buffs`).
- After any change in [collection.md](collection.md): 4902, and 4903 if the player is currently inside the affected mode.

## 9. Open questions and assumptions

- Assumption: series to camp type mapping (1 -> 800, 2 -> 802, 3 -> 806, 4 -> 807, 5 -> 801) from `cardDscTxt` and `getFightText`.
- Assumption: "Campo de Batalha" is the RVR battlefield owned by the world-boss feature (`worldboss.WorldBossFrame.title02 = Campo de Batalha`).
- Assumption: 4903 timing (enter/leave mode) and `sonType = 1003` for card skills.
- Assumption: proc chances per grade are taken from skill names (g + 1 and 3g + 3).
- Open: meaning of `Singlefightadd.op` and the formula of `add`.
- Open: 4904 payload; not consumed by the client.
- Open: whether the battle engine exposes a passive skill pipeline already; if not, card skills depend on that engine work (shared with runes, stars, talents and other passive sources, see [skills](../skills/README.md)).

## 10. Implementation checklist

- [ ] Camp type to series mapping constant (800, 801, 802, 806, 807).
- [ ] `skills_for_mode` resolving `SkillTempIds` by card grade.
- [ ] Proc chance table for positions 3 and 4.
- [ ] Battle builders of campaign, mazes, arena, battlefield and trials call `skills_for_mode` for each player hero.
- [ ] Engine applies `UseWay` 2 / `AppearTime` 1 card skills as passives with their buffs (AttackType 6, 15, 33, 40; AttackWay 1, 2, 3).
- [ ] Push 4903 `PowCardBufListMsg` on mode enter, empty list on leave.
- [ ] Push 4902 `PowcardFightAddMsg` on login and after card changes.
- [ ] Never send 4904.
- [ ] Screen check: the top bar shows the "Adição de Cartas" icon while 4903 has entries and hides it after an empty 4903.
- [ ] Test: a type 1 card does not affect arena battles; a type 3 card affects only arena battles.
- [ ] Test: Pos 1 grade 9 reduces damage received by 30% in its mode.
- [ ] Test: upgrading a card inside the mode updates the 4903 list values.
