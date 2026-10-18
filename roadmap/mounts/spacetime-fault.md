# Spacetime fault ("Piso do Tempo", 时空断层)

Scope: the client package `spacetime` (`decompiled/m9/scripts/spacetime`, 4 classes) that the feature registry assigns to `mounts`. It is not a mount system: it is the weekly result and reward screen of the "Piso do Tempo" multi-floor PvE campaign (campaigns 9998 normal and 9999 nightmare), plus the chat share card of a run. The registry grouping is kept here; the room, campaign and battle parts it relies on belong to [../campaign/README.md](../campaign/README.md) and [../battle/README.md](../battle/README.md). The only link with mounts is the config `star_area_mounts_id` ("【时空探险】稀有坐骑展示", a rare mount card 2183094 shown by another exploration feature), which this package does not use.

Path aliases (all under `decompiled/`):

| Alias | File |
|---|---|
| STRF | `m9/scripts/spacetime/SpaceTimeFaultRewardFrame.as` |
| STSF | `m9/scripts/spacetime/SpaceTimeFaultShareFrame.as` |
| STFI | `m9/scripts/spacetime/view/SpaceTimeFloorItem.as` |
| STBX | `m9/scripts/spacetime/view/SpacetimeFtBox.as` |
| STC | `core_module/scripts/mvc/controler/SpaceTimeFaultController.as` |
| RM | `core_module/scripts/managers/RoomManager.as` |
| BM | `core_module/scripts/yishi/manager/BaseManager.as` |
| SPI | `core_module/scripts/yishi/datas/playerinfo/SimplePlayerInfo.as` |
| RRV | `m9/scripts/room/view/pve/RoomRightView.as` |
| IRV | `m9/scripts/room/view/pve/instance/InstanceRightView.as` |
| BSTV | `m10/scripts/battle/view/ui/BattleSpaceTimeView.as` |
| BSTB | `m10/scripts/battle/view/ui/BattleSpaceTimeBox.as` |

## 1. Overview

- Campaigns (`raw/xml/tempinfos/Campaigns.xml`): 9998 and 9999 "Piso do Tempo", `Types` 0, `SonTypes` 306 (`CampaignTemplate.isSpacetimeFault`, `core_module/scripts/yishi/datas/templates/CampaignTemplate.as:150-157`), `DifficultyGrade` 1 (normal) and 2 (nightmare, "Pesadelo"), lord level 50..80, up to 4 players, `DungeonId` 3, `EnterNumb` 1, reward items 2131302/2131303/2131304.
- A run is a sequence of 7 floors (battle waves). On each floor up to 5 chests can be earned by clearing it before time thresholds; faster clears give more stars.
- One reward per week ("(Tem 1 ganho por semana, ao desafiar novamente os ganhos serão atualizados)"): the result of the last counted run is stored and can be claimed once from the reward frame.
- The run can be shared in chat as a link that opens a read-only card.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `spacetime.SpaceTimeFaultRewardFrame` (`STRF`) | (frame without title) | Weekly result and claim | Room reward button `xmlui.baseroom.fla.spaceTimeGetBtn` (tip "Após completar campanha obterá ganhos", `RRV:189-190, 499-503`); automatically after a run when 446 has `param2` = 1 (`BM:856-865`). Controller `spacetimefault`, default openType (`STC:22-29`) | Three reward items from config `SpaceTimeFaultRewards` with counts from the history (`STRF:124-203`); "Parabéns, você passou o Piso do Tempo {0} da fase {1}" ({0} = "Normal"/"Pesadelo", {1} = floors cleared, `STRF:219-252`); 7 floor rows with chests and stars (`STRF:268-326`); claim button or "claimed" image (`STRF:87-122`); share link "Compartilhar resultado de batalha" (`STRF:360-368`) |
| `spacetime.SpaceTimeFaultShareFrame` (`STSF`) | "{0}-{1} Piso do Tempo" (`spacetimefault.shareTitle`) | Read-only card of a shared run | Click on a chat share link (`core_module/scripts/chat/view/ChatOutputViewII.as:239, 249-256`), openType 1 with `[nickName, history]` | Rewards, floors and stars of the shared history (`STSF:161-191`) |
| `spacetime.view.SpaceTimeFloorItem` (`STFI`) | row | One floor: up to 5 chests | STRF, STSF | chest type, count, stars (`STFI:46-125`) |
| `spacetime.view.SpacetimeFtBox` (`STBX`) | chest | Chest icon with 0..4 stars and count | STFI | |
| In-battle chest bar `BSTV` / `BSTB` (battle package, reference only) | | Live countdown of the chests of the current floor | battle type 3870 (`m10/scripts/battle/view/ui/BattleUIView.as:1187-1190, 1991-1998`) | stars by elapsed time (`BSTB:54-84`) |
| Room right panel (campaign package, reference only) | "Apenas poderá obter 1 ganho por semana" | Shows `spacetimeRestNum / spacetimeMaxNum`, enables nightmare only after normal is passed | `IRV:635-652`, `RRV:463-503, 583-593, 1030-1034` | |

## 3. Routes (client to server)

### T1. Query the weekly state
- Senders: selecting the campaign in the instance panel or the room panel: `RM.requestSpacetimeInfo(1)` (`IRV:652`, `RRV:593`).
- Route: send 9653 (0x25b5) `C_TIMESPACE_INFO`, `simple.PropertyMsg` with `param1` (#1, INT32) = 1 (`RM:584-590`).
- Response: 446 with the history and claimed flag; 3 `U_C_PLAYER_INFO` with the counters (assumption, they also arrive at login).

### T2. Claim the weekly reward
- UI: claim button of STRF (`STRF:370-373`), enabled when the history has a non-empty reward part and `hasSpaceTimeReward` is false (`STRF:87-122`).
- Route: 9653 with `param1` = 2.
- Response: 446 with `param7` = true (the frame switches to "claimed" on `REFRESH_SPACE_TIME_RESTNUM`, `STRF:355-358`; assumption: the server also sends 3 with the new rest count, which triggers that event, `SPI:395-403`); item delivery pushes (115) for the chests.

### T3. Share a run in chat (chat route, reference only)
- UI: share link -> `spacetimefault.shareMsg` `<a t='116' name='Compartilhar resultados do Piso do Tempo' data="{history}"/>` -> chat input (`core_module/scripts/chat/view/ChatInputViewII.as:321-335`) -> chat send with `ChatChannelMsg.shareTimeSpace` (#29, STRING, repeated) (`core_module/scripts/chat/ChatSocketOutManager.as:82`). The chat server relays it; see [../chat/README.md](../chat/README.md).

### Enter and fight (campaign and battle routes, reference only)
Room creation, entry and the battle are handled by [../campaign/README.md](../campaign/README.md) and [../battle/README.md](../battle/README.md). Entering with no rewards left asks "Número de entradas do Piso do Tempo atingiu o limite，ao entrar não terá mais ganhos. Desejar entrar?" (`RRV:1030-1034`).

## 4. Server messages (server to client)

`simple.PropertyMsg` fields (`core_module/scripts/com/road/yishi/proto/simple/PropertyMsg.as`; missing from `protocol/proto.json`): `param1`..`param3` (#1..#3, INT32), `param4`..`param6` (#4..#6, STRING), `param7`..`param9` (#7..#9, BOOL), `param10`, `param11` (#10, #11, INT32), `param12` (#12, STRING).

### S1. 446 (0x01be) `U_C_TIME_SPACE_INFO`, `simple.PropertyMsg`
Receiver `BM._reciveSpaceInfoHander` (`BM:342, 843-865`).

| Field | Meaning | Client |
|---|---|---|
| `param4` (#4, STRING) | weekly history `"{campaignId}|{tid}:{count},{tid}:{count},...|{s1},{s2},...,{sN}"`: campaign 9998 or 9999, reward items, clear time in seconds of each cleared floor (N = floors cleared) | `SPI.spacetimePassHistory` (`SPI:410-418`) -> `REFRESH_SPACE_TIME_HISTORY` (room button) |
| `param7` (#7, BOOL) | weekly reward already claimed | `SPI.hasSpaceTimeReward` |
| `param2` (#2, INT32) | 1 = a run just ended: open STRF once back in `PVE_ROOM_SCENE` | delayed action |

Send after T1, after T2, and at the end of a counted run (with `param2` = 1).

### S2. 447 (0x01bf) `U_C_TIME_SPACE_BATTLE_TIME`, `simple.PropertyMsg`
Receiver `BM.__spacetimeFaultFightTimeHandler` (`BM:341, 821-830`): `param4` (#4, STRING `YYYY-MM-DD hh:mm:ss`) = start time of the current floor, stored as `SPI.spaceTimeBoxTimeBegin` (`SPI:425-428`) and used by the in-battle chest countdown (`BSTV:195-210`). Send at each floor (wave) start.

### S3. 3 (0x0003) `U_C_PLAYER_INFO`, `PlayerMsg` counters (hero feature)
`TimeSpaceLeftRewardCount` (#161, INT32) and `TimeSpaceMaxRewardCount` (#162, INT32) -> `spacetimeRestNum` / `spacetimeMaxNum` (`core_module/scripts/yishi/manager/PlayerManager.as:1209-1216`; client default max 1, `SPI:125`).

### Current server behavior
No rule handles 9653 or sends 446/447; the reward button stays disabled.

## 5. Rules and formulas

- Difficulty code in the history: campaign id 9998 -> normal (1), 9999 -> nightmare (2) (`STRF:205-217`; battle map id also 9998/9999, `BSTV:176-177`).
- Nightmare is enterable only after normal is passed (`IRV:640-641`).
- Floors and chests (config, `core_module/scripts/yishi/manager/TempleteManager.as:3458-3497`): `SpaceTimeNomal` / `SpaceTimeNightmare` = 7 floors separated by `|`, each a list of `chestType:seconds` (cumulative thresholds); `SpaceTimeNormalRewards` / `SpaceTimeNightmareRewards` = matching chest counts. Example normal floor 1: chests "3:25,3:90,3:180" with counts "1,1,1"; nightmare floor 7: "1:20,1:40,1:65,2:90,2:180" with counts "2,2,2,4,4".
- Chest types: 1, 2, 3 map to `SpaceTimeFaultRewards` "2131302|2131303|2131304" (Baú de Bronze/Prata/Ouro dos Pisos do Tempo) (assumption on the mapping by index).
- Stars of chest i for floor time t (`STFI:75-125`, `BSTB:54-84`): with window `[prev_i, threshold_i]`, if `t <= threshold_i`: fraction `(t - prev_i) / (threshold_i - prev_i)` -> <= 0.25: 4 stars, <= 0.5: 3, <= 0.75: 2, <= 1: 1; else 0 (chest lost). Floors not cleared show 99999 (all lost).
- Rewards (assumption): for each cleared floor, every chest with `t <= threshold` gives `count` items of its type; the history reward list is the sum by item. Stars are display only.
- Weekly limit: `TimeSpaceMaxRewardCount` (1) rewarded runs per week; `TimeSpaceLeftRewardCount` decrements when a run is counted; a new run while rewards remain replaces the stored result ("ao desafiar novamente os ganhos serão atualizados"). Claim (T2) once per week; reset weekly (assumption: Monday 00:00 server time).
- In battle type 3870 the skill bar is replaced by config `TimeSpaceFaultSkill` "617007,617002,617003,617004,617005" (`core_module/scripts/battle/view/ui/SkillItemListController.as:115-130`).

## 6. Templates

| File | Records and fields used |
|---|---|
| `raw/xml/tempinfos/Campaigns.xml` | 9998, 9999 (`SonTypes` 306, `DifficultyGrade`, `MinLevel`, `MaxLevel`, `Capacity`, `Item`, `DungeonId`) |
| `raw/xml/tempinfos/ConfigInfos.xml` | `SpaceTimeNomal`, `SpaceTimeNightmare`, `SpaceTimeNormalRewards`, `SpaceTimeNightmareRewards`, `SpaceTimeFaultRewards`, `TimeSpaceFaultSkill` |
| `raw/xml/tempinfos/ItemTempInfos.xml` | 2131302, 2131303, 2131304 chests (SonType 206) |

## 7. Persistent state

```sql
CREATE TABLE mounts.spacetime_week (
  player_id        BIGINT      NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  week_start       DATE        NOT NULL,
  campaign_id      INTEGER     CHECK (campaign_id IN (9998, 9999)),
  floor_seconds    INTEGER[]   NOT NULL DEFAULT '{}',
  rewards          JSONB       NOT NULL DEFAULT '[]',
  rewards_left     SMALLINT    NOT NULL DEFAULT 1 CHECK (rewards_left >= 0),
  rewards_max      SMALLINT    NOT NULL DEFAULT 1 CHECK (rewards_max >= 0),
  reward_claimed   BOOLEAN     NOT NULL DEFAULT false,
  updated_at       TIMESTAMPTZ NOT NULL DEFAULT now(),
  PRIMARY KEY (player_id, week_start)
);

CREATE TABLE mounts.spacetime_run (
  run_id         BIGSERIAL   PRIMARY KEY,
  player_id      BIGINT      NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  campaign_id    INTEGER     NOT NULL CHECK (campaign_id IN (9998, 9999)),
  floor_seconds  INTEGER[]   NOT NULL,
  counted        BOOLEAN     NOT NULL,
  finished_at    TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX spacetime_run_player_time ON mounts.spacetime_run (player_id, finished_at);
```

`rewards` holds `[{"template_id": 2131302, "count": 3}, ...]`; the wire history string is built from `campaign_id`, `rewards` and `floor_seconds`.

## 8. Backend implementation notes

Handlers:
- `mounts::spacetime::handle_info` (9653 `param1` = 1): load or create the current week row; send 446 (`param4` history, `param7` claimed, `param2` 0).
- `mounts::spacetime::handle_claim` (9653 `param1` = 2): week row exists, rewards non-empty, not claimed -> deliver items (inventory service), set `reward_claimed`; send 446 (`param7` true), 115, 3.
- `mounts::spacetime::on_floor_start` (battle hook): send 447 with the floor start time to every player of the run.
- `mounts::spacetime::on_run_end` (battle/campaign hook): insert `spacetime_run`; when `rewards_left > 0`, compute chests and replace the week row result, decrement `rewards_left`, reset `reward_claimed` to false (assumption); send 446 with `param2` = 1 and 3 with the counters to each participant.
- Weekly reset job: new `week_start` rows lazily on first access (assumption: Monday 00:00).

Battle configuration (see `docs/battle/server-engine.md`): `battle_type` 3870, map id 9998 or 9999, 7 waves (client field `currentWave` in the create message and `reinforceWave` on reinforcements set the floor, `core_module/scripts/battle/transaction/CreateGameTransaction.as:121`, `core_module/scripts/battle/handler/ReinforceHandler.as:156`), up to 4 players, fixed skill bar `TimeSpaceFaultSkill`; monster waves come from the dungeon/campaign data (`DungeonId` 3, assumption).

## 9. Open questions and assumptions

- Mapping of chest type 1/2/3 to items 2131302/3/4 (assumption: by index).
- Reward computation from thresholds (assumption above); whether stars matter.
- Weekly reset time and whether a later worse run also replaces the stored result (text says rewards are "atualizados").
- Who in a 4-player run gets counted (assumption: every participant with rewards left).
- Monster waves of `DungeonId` 3 (not in client templates read here).

## 10. Implementation checklist

- [ ] Screen `spacetime.SpaceTimeFaultRewardFrame` from 446
- [ ] Screen `spacetime.SpaceTimeFaultShareFrame` from a chat share
- [ ] Route 9653 `param1` 1 (query)
- [ ] Route 9653 `param1` 2 (claim)
- [ ] Server message 446 (history, claimed, open flag)
- [ ] Server message 447 per floor start
- [ ] `PlayerMsg` #161/#162 counters (hero feature encoder)
- [ ] `simple.PropertyMsg` encoder (add to `protocol/proto.json` tooling)
- [ ] Table `mounts.spacetime_week`
- [ ] Table `mounts.spacetime_run`
- [ ] Rule: chest thresholds and counts per floor and difficulty
- [ ] Rule: weekly limit, replacement and claim once
- [ ] Battle hook: type 3870, map 9998/9999, 7 waves, fixed skills
- [ ] Test: clear floor 1 normal in 20 s earns 3 gold chests (1 each)
- [ ] Test: claim twice in a week rejected
