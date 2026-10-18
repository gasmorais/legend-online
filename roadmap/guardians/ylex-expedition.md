# Espírito de Proteção camps ("Espírito de Proteção à expedição", ylex / child camp)

Module `ylex-expedition`. Idle camps ("Campo") where an Espírito de Proteção is stationed ("Alojar") for hours to earn exp and items. Camps level up with stationing exp (shorter time, better rewards). The player picks a difficulty: with full troops nothing happens; with fewer troops enemies raid ("assalto", 15 minutes each) reducing exp unless the player resists them in battle; a protective cover can be bought to auto resist; after stationing the reward can be doubled for diamonds. Spirits need energy to station again.

Disabled in this client build: `VersionSwitch.YL_EXPEDTION = false` (`decompiled/core_module/scripts/yishi/datas/VersionSwitch.as:198`).

Path aliases:

| Alias | File |
|---|---|
| YM | `decompiled/core_module/scripts/managers/YLExpedtionManger.as` |
| YMOD | `decompiled/core_module/scripts/mvc/module/ylex/YLExpedtionModel.as` |
| YC | `decompiled/core_module/scripts/mvc/controler/YLExpeditionController.as` |
| V | `decompiled/m14/scripts/ylex/` |

## 1. Overview

- Send 9018 (0x233a) `C_CHILD_CAMP_OP`, `com.road.yishi.proto.simple.PropertyMsg` (`YM:90-99`): `param1` (#1, INT32) = op, `param2` (#2, INT32), `param3` (#3, INT32), `param10` (#10, INT32). The `simple.PropertyMsg` tags are documented in `../goddess/equipment.md` S2 (`protocol/proto.json` holds a different `PropertyMsg`).
- Ops (by callers): 1 open, 2 station, 3 buy protective cover, 4 resist a raid, 5 restore spirit energy, 6 collect reward (`param3` 2 = double).
- Receive 4215 (0x1077) `U_C_CHILD_CAMP`, `ChildCampListMsg` (package `childpatrol`).
- Entry: `SwitchPageHelp.openYLExpeditionFrame` (`decompiled/core_module/scripts/yishi/SwitchPageHelp.as:2931-2947`): switch on, `isAvenger` ("Primeiro complete a prova de Divindade"), scene check; `YC` openType 1 main, 2 camp detail, 3 choose (station), 4 raid info, 5 reward.

## 2. Screens

| Class | pt-BR title | Purpose |
|---|---|---|
| `V/YLExpeditionMainFrame.as`, `V/view/YLExpedtionMainView.as`, `V/view/YLExpeditionItem.as`, `V/view/YLExpedtionLeftListView.as`, `V/view/YLExpedtionLeftItemView.as`, `V/view/YLExpedtionHeadInfoView.as` | "Espírito de Proteção à expedição", help "Sobre o Espírito de Proteção ao combate" | camps, spirits list with states "Alojando...", "Alojamento concluído", "Pode entrar no Alojamento", "Recuperando energia..." |
| `V/YLXpedtionYeildFrame.as`, `V/view/YLEepedtionYeildView.as` | "Campo {0}" | camp details, expected exp "Estima-se obter {0} de EXP no alojamento" |
| `V/YLExpedtionChooseFrame.as`, `V/view/YLExpeditionChooseView.as`, `V/view/YLExpedtionNodeItem.as`, `V/view/YLExpedtionBigNodeItem.as` | "Alojamento", "Alojar {0} neste Campo?" | choose spirit and difficulty: 1 "Muita força de tropa" (no raids, no trophies), 2 "Pouca força de tropa" (raids possible, trophies), 3 "Sem força de tropa" (frequent raids, better rewards) |
| `V/YLExpedtionFightInfoFrame.as`, `V/view/YLXepedtionFightInfoView.as` | "Resistência ao assalto", "Sucesso do assalto inimigo: {0} vezes" | raids, buy cover |
| `V/YLEpedtionRewardFrame.as`, `V/view/YLExpedetionRewardView.as`, `V/view/YLExpedtionDesItem.as` | "Coletar prêmio" | single or double reward |

## 3. Routes (client to server)

| op (`param1`) | UI | Other fields | Client checks | Response |
|---|---|---|---|---|
| 1 | main frame open (`V/YLExpeditionMainFrame.as:47`) | | | 4215 |
| 2 | confirm station (`V/YLExpedtionChooseFrame.as:118-137`) | `param2` camp id, `param3` child id, `param10` difficulty 1..3 | spirit chosen ("Selecione antes o Espírito de Proteção que precisa Alojar!"), camp not full ("Alojamento do Campo já lotou de Espíritos de Proteção!") | 4215 |
| 3 | buy cover (`V/YLExpedtionFightInfoFrame.as:80-110`) | `param2` camp id | cost = ceil(remaining / unit) x price from `childcamp_buy_cover_point` "10,5"; diamonds; difficulty 1 has no raids ("Nenhum assalto na dificuldade atual") | 4215 (`IsCover`) |
| 4 | resist raid (`V/view/YLExpeditionItem.as:274-277`) | `param2` camp id | not already fighting ("Em assalto... Impossível fazer isto agora"), defense count ("Qtd. de ataques recebidos cheio!") | battle against `ChildCampTemp.Monster`, then 4215 |
| 5 | restore energy (`V/view/YLExpedtionLeftItemView.as:120-163`) | `param2` child id | confirm "Deseja gastar {0} diamantes para recuperar Energia?" (`childcamp_buy_energy_point` "10,5") | 4215 (`childList` over time cleared) |
| 6 | collect (`V/YLEpedtionRewardFrame.as:139-165`) | `param2` camp id, `param3` 2 = double | double costs `childcamp_double_exp_point` 200 diamonds ("Gastar {0} diamantes para receber dupla experiência?") | 4215, bag 115, spirit exp (4747/424) |

## 4. Server messages (server to client)

### S1. 4215 (0x1077) `U_C_CHILD_CAMP`, `ChildCampListMsg`
Receiver `YM.__updateInfoHandler` (`YM:57-88`), merges by camp id.

| Field | Tag | Type | Meaning |
|---|---|---|---|
| `op` | #1 | INT32 | echo |
| `campList` | #2 | ChildCampInfoMsg repeated | `Id` #1, `Grade` #2, `NowExp` #3, `ChildId` #4 (stationed spirit), `Difficulty` #5, `SneakCount` #6 (successful raids), `DefenseCount` #7 (resisted), `StartTime` #8 INT64 ms, `SneakTime` #9 INT64 ms (current raid start), `IsCover` #10 |
| `childList` | #3 | ChildCampTimeInfoMsg repeated | `ChildId` #1, `OverTime` #2 INT64 (energy recovery end) |

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Camp levels | `ChildCampTemps.xml` (10): `Grade`, `StationedTime` (50400 s at level 1, shorter later), `StationedAward`, `SneakCount2/3` (raids at difficulty 2/3: 5/8), `SneakAward2/3` (per resisted raid), `SneakFinishAward2/3` (all resisted), `Exp` (camp exp to next level), `Monster` (raid units "unit,pos|..."), `Desc` | template |
| Raid | lasts `childcamp_sneak_attack_time` 900 s; each successful raid cuts stationing exp by `childcamp_sneak_attack_loss` 2% | config, help |
| Finish award | difficulty 2 needs `childcamp_sneakcount2` 3 resisted, difficulty 3 needs `childcamp_sneakcount3` 6 | config |
| Energy | recovery `childcamp_energy_recovery_time` 43200 s; buy "10,5" (per 10 min 5 diamonds *(assumption)*) | config |
| Cover | "10,5" units/price; with cover rewards are sent directly | config, help |
| Double reward | 200 diamonds | config |

## 6. Templates

`ChildCampTemps.xml`, `ConfigInfos.xml` (`childcamp_*`).

## 7. Persistent state

```sql
CREATE TABLE guardians.camps (
  player_id      BIGINT   NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  camp_id        SMALLINT NOT NULL,
  grade          SMALLINT NOT NULL DEFAULT 1,
  now_exp        INTEGER  NOT NULL DEFAULT 0,
  child_id       INTEGER  REFERENCES guardians.children(child_id) ON DELETE SET NULL,
  difficulty     SMALLINT NOT NULL DEFAULT 1 CHECK (difficulty BETWEEN 1 AND 3),
  sneak_count    SMALLINT NOT NULL DEFAULT 0,
  defense_count  SMALLINT NOT NULL DEFAULT 0,
  started_at     TIMESTAMPTZ,
  sneak_started_at TIMESTAMPTZ,
  is_cover       BOOLEAN  NOT NULL DEFAULT FALSE,
  PRIMARY KEY (player_id, camp_id)
);

CREATE TABLE guardians.camp_spirit_rest (
  child_id     INTEGER  PRIMARY KEY REFERENCES guardians.children(child_id) ON DELETE CASCADE,
  over_at      TIMESTAMPTZ NOT NULL
);
```

## 8. Backend implementation notes

Handlers `guardians::ylex_expedition::handle_<action>`: `open` (1), `station` (2), `buy_cover` (3), `resist` (4), `restore_energy` (5), `collect` (6).

- Scheduler: raid spawns during stationing for difficulty 2/3 (count `SneakCountN`), raid expiry (apply exp loss), stationing end (reward ready), energy recovery end.
- Resist: battle with the stationed spirit vs `Monster` units *(assumption: guardian only battle type, likely 3868 `CHILD_WAR_BATTLE`)*.

## 9. Open questions and assumptions

- Feature disabled by version switch.
- *(assumption)* Raid battle type and reward formulas.

## 10. Implementation checklist

- [ ] 9018 ops 1..6 (feature flag), push 4215.
- [ ] Tables `guardians.camps`, `guardians.camp_spirit_rest`.
- [ ] Scheduler for stationing, raids, energy.
- [ ] Tests: station into an occupied camp rejected; cover on difficulty 1 rejected; double reward charges 200 diamonds.
