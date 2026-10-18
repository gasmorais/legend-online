# Theseus: Intenção de Guerra (war intent levels)

Module `war-intent`. Second tab of "Alma de Teseu" (client name "yi", proto name "Rage"): 12 positions, one per armor slot, each levelled 0..100 with Theseus materials; a total level bonus tier; and extra levels granted by equipped war souls (reform bonuses).

Path aliases:

| Alias | File |
|---|---|
| MGR | `decompiled/core_module/scripts/managers/TheseussoulManager.as` |
| MOD | `decompiled/core_module/scripts/mvc/module/theseus/TheseussoulModel.as` |
| YV | `decompiled/m5/scripts/theseus/view/TheseussoulyiPageView.as` |
| T | `decompiled/m5/scripts/theseus` |
| CM | `decompiled/core_module/scripts` |

---

## 1. Overview

- 12 positions `pos` 1..12. The UI places cell `i` (0..11) at `POSLIST[i]` with `POSLIST = [1,3,4,5,2,6,9,10,11,12,7,8]` (`YV:63, 185-202`) and gives it the part icon `SONTYPES[i]` (Arma, Escudo, Manto, Colar, Roupa, Elmo, Anel, Anel, Bracelete, Bracelete, Cinto, Sapato). So pos 1 Arma, 2 Roupa, 3 Escudo, 4 Manto, 5 Colar, 6 Elmo, 7 Cinto, 8 Sapato, 9..10 Anel, 11..12 Bracelete.
- Each "Elevação" (level up) costs Theseus materials stored in the Theseus bag: 7400001 "Aço da Intenção de Guerra" ("Pode elevar as partes Arma e Veste da Intenção de Guerra do Teseu") for pos 1..2, 7400002 for pos 3..4, 7400003 "Ferro da Intenção de Guerra" for pos 5..12.
- Total level bonus ("Atributo do Prêmio de Nv. total"): the lowest level across the 12 positions selects a tier of `TheseusRageSuiteTemplates` (every 5 levels).
- War soul reform bonus ("Bônus de Intenção de Guerra", `theseus.war.tipzy`): every equipped war soul carries `reformBuff` entries "pos,level" that add `MasterType 2` attribute rows on top of the position ([war-soul-training.md](war-soul-training.md) reform).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `YV` (`TheseussoulyiPageView`) | tab 2 of "Alma de Teseu" | 12 `TheseussouYiCell`, center icon, before/after attribute lists, material, level-up button, info button | Main frame tab 2 | cell "Lv.L" plus yellow " +bonus" when war soul bonuses exist (`T/item/TheseussouYiCell.as:53-70`); selected part name "partN  Lv.L" (`YV:106`); "Consumo de Elevação: owned/need" red/green (`theseus.yi.metrialNeed`, `YV:122-136`); "Já fortaleceu ao mais alto nível" at max (`theseus.yi.max`, `YV:144-151`) |
| `T/TheseusYiAllFrame.as` | "Bônus total" (`theseus.yi.frameTitle`) | Two `TheseusYiInfoItem` | info button, controller openType 2 (`YV:277-280`) | item 1 "Atributo de Bônus total": sum of the current level rows of all positions (`T/item/TheseusYiInfoItem.as:37-77`); item 2 "Atributo do Prêmio de Nv. total": tier skill attributes, grey when no tier, next tier "Próx. Prêmio ativa no Nv.{0}" (`:79-173`) |

## 3. Routes (client to server)

### R1. Level up a position ("Elevação")

- UI: strengthen button `_strengthBtn` (`YV:272-275`) after selecting a cell (`YV:261-265`, default pos 1, `YV:53`).
- Client checks (`YV:91-152`): button enabled only when the row (pos, level+1) exists; the material count is displayed but **not** checked (the server must check it).
- Sender: `TheseussoulManager.doSomething(4, 0, 0, pos)` (`MGR:969-978`).
- Route: client to server, 8680 (0x21e8) `C_THESEUS_CLIENT_OP`, `player.PlayerOpMsg`:
  - `op` (#1, INT32): 4 (`OP_RAGE_STRENGTHEN`).
  - `index` (#6, INT32): 0.
  - `templateId` (#8, INT32): 0.
  - `pos` (#19, INT32): position 1..12.
- Expected response, in order: 4323 op 0 with the decremented material stack *(assumption: op 0)*; 4299 with the changed position; 4300 property totals.

## 4. Server messages (server to client)

### S1. 4299 (0x10cb) `U_C_THESEUS_RAGE_DATA`

- Message `theseus.TheseusRageListMsg`:
  - `rages` (#1, `TheseusRageMsg`, repeated).
- `theseus.TheseusRageMsg`:
  - `pos` (#1, INT32): position 1..12.
  - `level` (#2, INT32): level 0..100.
- Receiver: `MGR.__yiInfosHandler` (`MGR:841-861`): upsert into `MOD.yiDic` keyed by pos, dispatch `EVENT_YI_UPDATE`; consumers `YV.yiUpdateHandler` (`YV:267-270`) and `TheseusOtherFrame.yiUpdateHandler` (`T/TheseusOtherFrame.as:85-88`).
- When: snapshot on open ([soul.md](soul.md) R1) with **all 12 positions** (level 0 included, the tier computation in `TheseusYiInfoItem.as:91-107` uses only present entries); after R1 with the changed entry.
- Same message is embedded in the hero detail response `DetailRspMsg.rageInfo` (#26) for inspection (`decompiled/m5/scripts/playerinfo/PlayerInfoFrameII.as:995-1004`).

### S2. 4300, 4323

- 4300 totals: [soul.md](soul.md) S2. 4323 material stack: [equipment-suits.md](equipment-suits.md) S1.

## 5. Rules and formulas

- Levels: `TheseusRageTemplates` rows with `MasterType 1`, `Type = pos` (1..12), `Level` 0..100 (101 rows per pos) (`CM/yishi/datas/templates/cate/TheseusRageTempCate.as:34-44`).
- Cost of L to L+1 = row(pos, L+1).`NeedItem` x `NeedItemNum` (`YV:100, 109-136`). Example pos 1: 10 at level 1, 505 at level 100; pos 5..12 use 3..127 units of 7400003.
- Attributes of a position at level L = row(pos, L): `PhyAttack`, `PhyDefence`, `MagicAttack`, `MagicDefence`, `ForceHit`, `Live`, `Parry`, `Penetrate`, `ReduceResi`, `FireResi`, `WaterResi`, `ElectResi`, `WindResi`, `DarkResi`, `LightResi`, `ReduceResiAgainst`, `ResiPenetrate`.
- War soul bonus (`YV:219-234`, `T/item/TheseussouYiCell.as:59-70`): for each equipped war soul and each `reformBuff` entry "p,b", add row(`MasterType 2`, `Type = p`, `Level = b`) (45 rows per pos, levels 1..45, `NeedItem 0`). The displayed bonus level is the sum of `b` per position; attributes are the sum of the individual rows. Bonus levels do not count for the next level cost.
- Total level tier: `minLevel = min(level over the 12 positions)`; tier = last `TheseusRageSuiteTemplates` row with `MinLevel <= minLevel` (MinLevel 5, 10, ..., 100) (`CM/yishi/datas/templates/cate/TheseusRageSuiteTempCate.as:34-51`); bonus = attributes of `SkillId` (84104001..84104020). No tier below 5.
- No unlock condition beyond the Theseus entry ([soul.md](soul.md) §3); no royalty gate per position.
- Success rate 100%, no failure.

## 6. Templates

| File | Record | Fields |
|---|---|---|
| `raw/xml/tempinfos/TheseusRageTemplates.xml` (1752 rows) | level of a position | `TemplateId`, `MasterType` (1 level, 2 war soul bonus), `Type` pos 1..12, `Level`, `NeedItem`, `NeedItemNum`, 17 attribute columns |
| `raw/xml/tempinfos/TheseusRageSuiteTemplates.xml` (20 rows) | total level tier | `TemplateId`, `MinLevel`, `SkillId` |
| `ItemTempInfos.xml` | materials 7400001..7400003 | MasterType 10, SonType 740 (Theseus bag) |

## 7. Persistent state

```sql
CREATE TABLE theseus.war_intent_levels (
    player_id  bigint   NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
    position   smallint NOT NULL CHECK (position BETWEEN 1 AND 12),
    level      smallint NOT NULL DEFAULT 0 CHECK (level BETWEEN 0 AND 100),
    updated_at timestamptz NOT NULL DEFAULT now(),
    PRIMARY KEY (player_id, position)
);
```

Seed 12 rows at level 0 on the first open ([soul.md](soul.md) `handle_open`).

## 8. Backend implementation notes

- `theseus::war_intent::handle_strengthen` (8680 op 4), validation order:
  1. Theseus unlocked; `pos` in 1..12;
  2. row (pos, level+1, MasterType 1) exists (else max);
  3. Theseus bag stack of `NeedItem` has `>= NeedItemNum` units;
  4. transaction: consume material (update or delete the `theseus.armor_items` stack), `level + 1`;
  5. push 4323 (material), 4299 (pos, level), 4300.
- `theseus::war_intent::bonus_attributes(player_id)`: level rows + war soul reform bonus rows + tier skill; used by `soul::build_property_totals`.
- No timers, no battles.

## 9. Open questions and assumptions

1. The op echoed in 4323 for material consumption is not visible (the handler ignores it for non zero ops except 4, 5, 6, 8).
2. Whether the war soul bonus counts toward the total level tier: the client tier uses only `yiDic` levels, so bonus levels do not count.
3. Template rows of `MasterType 2` go to level 45 although `MaxRageGrades` in `WarSoulReformTmpls` is at most 5 per entry; multiple entries on the same pos are not merged into one row by the client.

## 10. Implementation checklist

- [ ] Screen `TheseussoulyiPageView` with 12 cells, POSLIST mapping and bonus display.
- [ ] Screen `TheseusYiAllFrame` totals and tier.
- [ ] Route 8680 op 4 with material check server side.
- [ ] Server message 4299 (all 12 on snapshot, delta on level up).
- [ ] Table `theseus.war_intent_levels` seeded with 12 rows.
- [ ] Rule: cost row(L+1), attributes row(L), war soul bonus rows MasterType 2, tier by min level.
- [ ] Test: level up without enough 7400003 is rejected.
- [ ] Test: level 100 is the cap.
- [ ] Test: tier 1 activates when all 12 positions reach level 5.
