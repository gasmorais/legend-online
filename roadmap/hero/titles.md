# Titles (Título)

Path aliases:

| Alias | File |
|---|---|
| ASO | `decompiled/core_module/scripts/managers/AppellSocketOutManager.as` |
| APM | `decompiled/core_module/scripts/yishi/manager/AppellManager.as` |
| AMOD | `decompiled/core_module/scripts/mvc/module/appell/AppellModel.as` |
| AF | `decompiled/m5/scripts/appell/AppellFrame.as` |
| AI | `decompiled/m5/scripts/appell/view/AppellItem.as` |
| PAV | `decompiled/m5/scripts/playerinfo/view/PlayerAttributeView.as` |
| PM | `decompiled/core_module/scripts/yishi/manager/PlayerManager.as` |

## 1. Overview

Titles (`AppellInfos.xml`, 951 rows) are earned by conditions (rankings, achievements, events). The player equips one title, shown above the avatar and in chat (optional prefix `Perfix`). After finishing the "Glória do Império" quests (`applle_property_Open`), every owned title also adds attributes (passive skills `Skills` and buffs `Buffs`), cumulative over all owned titles (help text `appellFrame.helpContent`). Some titles expire (`Time`, `validDate`).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `appell.AppellFrame` (AF) | "Título" (`appell.AppellFrame.Title`) | List with search "Digite o Título de busca", pages, detail panel: description, "Atributos para ativar:", progress "({0})", expiry "Tempo expirado: {0}" | "Modificar de Título"/"Detalhes" in PAV (PAV:199-207), title links "Checar" | `AppellModel.appells` (job-filtered) |
| `appell.view.AppellItem` (AI) | | One title with equip button | AF | template + `isGet`, `progress` |
| `PlayerAttributeView` title combo | "Modificar de Título", "Nenhum" | Quick equip | hero frame | owned titles |
| `AppellGetView` | | Popup when a title with `Notice` is earned (deferred until leaving battle) | 4491 | template |
| `yishi.view.tips.AppellInfoTips` | | Tooltip | everywhere | template |

## 3. Routes (client to server)

### R1. Request the title list
- When: AF opens (`AF.show`, AF:528-536).
- Client path: `ASO.lookAppellInfos()` (ASO:35-42).
- Route: send 8597 (0x2195) `C_APPELL_EXCHANGE`, `AppellExchangeMsg` (player): `appellId` (#1, INT32) = 0, `look` (#2, BOOL) = true.
- Response: 4484 (S1).

### R2. Equip / unequip a title
- UI: equip button (AI:82-92) when the id differs from the current; title combo (PAV:180-187); choosing "Nenhum" sends id 0 *(assumption: the combo's "Nenhum" entry has id 0, PAV:256)*.
- Client path: `ASO.exchangeAppell(id)` (ASO:26-33).
- Route: send 8597, `AppellExchangeMsg`: `appellId` (#1, INT32) title id (0 = none), `look` (#2, BOOL) = false.
- Client checks: none (combo enabled from hero level 1, PAV:209-216; tip "Habilitado no Nv. 30" is static).
- Response: 3 `U_C_PLAYER_INFO` with `appell_id` (#78) (PM:837-843) → `APPELL_CHANGE`; broadcast of the new title to players who see the avatar (map/room updates carry `appellid`); 113 if attributes change.

## 4. Server messages (server to client)

### S1. 4484 (0x1184) `U_APPELL_DATA`
- `AppellsMsg` (player): `appells` (#1, `AppellInfoMsg`, repeated). `AppellInfoMsg`: `appellId` (#1, INT32), `isGet` (#2, BOOL) owned, `value` (#3, STRING) progress text, `validDate` (#4, STRING) expiry (optional).
- Receiver: `APM.__updateAppellDataHandler` (APM:48-87): copies into templates; `Quality 2` is displayed as 3; keeps titles of the hero's `Job` or `Job 0`.
- When: response to R1; push when progress or ownership changes.

### S2. 4491 (0x118b) `U_APPELL_GET`
- `AppellExchangeMsg`: `appellId` (#1) title just earned; `look` unused.
- Receiver: `APM.__getAppellHandler` (APM:89-118): waits until the scene is not `BATTLE_SCENE`, then shows `AppellGetView` if the template `Notice` is true and notifies `APPELL_GET`.

### S3. 3 `U_C_PLAYER_INFO`
`appell_id` (#78, INT32) equipped title; `applle_property_Open` (#94, BOOL) title attributes enabled (PM:1105-1109).

`AppellReachMsg` (`appellId` #1, `value` #2) has no client reader.

## 5. Rules and formulas

- Only one equipped title; any owned, non-expired title of the hero's job (or job 0) can be equipped.
- `CondtionType` + `Para`: earning rule evaluated server-side (most frequent types 202, 203, 39, 7, 3, 100); `AMOD.needShowProgress` shows progress for types 1, 2, 3, 4, 10, 28, 30, 31, 33, 37, 38, 100, 101 (AMOD:136-158).
- Attribute bonus: when `applle_property_Open`, sum `Skills` (skill ids) and `Buffs` of all owned titles into hero stats; names of stats in `appellModel.properties` ("Poder|Proteção|Inteligência|Físico|Liderança|Ataque|Defesa|Magia|Reistência|Crítico|Penetração|Bloqueio|Vida|Liderança").
- Expiry: `Time` > 0 titles get `validDate`; when expired the title and its attributes are removed; re-earning re-adds them (help text).
- `VersionSwitch.APPELL` (true): when false the client forces `appellId = 0` (APM:126-133).

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `AppellInfos.xml` | title | `TemplateId`, `Type` (1..4), `Title`, `Descript`, `Quality`, `Notice` (popup), `Perfix` ("text|style"), `Sort`, `IsLong`, `CondtionType`, `Para`, `Job`, `ShowParam` (render params), `Skills`, `Buffs`, `Time` (duration), `IsHide`, `IsTitleHide` |
| `SkillTempInfos.xml` | title skills (e.g. 8101) | attribute effects |

## 7. Persistent state

```sql
CREATE TABLE hero.titles (
    player_id     BIGINT  NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
    appell_id     INTEGER NOT NULL,
    obtained      BOOLEAN NOT NULL DEFAULT FALSE,
    progress      TEXT    NOT NULL DEFAULT '',
    obtained_at   TIMESTAMPTZ,
    valid_until   TIMESTAMPTZ,
    PRIMARY KEY (player_id, appell_id)
);
CREATE INDEX titles_expiry_idx ON hero.titles (valid_until) WHERE valid_until IS NOT NULL;

ALTER TABLE hero.heroes ADD COLUMN IF NOT EXISTS equipped_appell_id INTEGER NOT NULL DEFAULT 0;
ALTER TABLE hero.heroes ADD COLUMN IF NOT EXISTS title_attributes_open BOOLEAN NOT NULL DEFAULT FALSE;
```

## 8. Backend implementation notes

- `hero::titles::handle_exchange` (8597): `look = true` → reply 4484 with all rows of the hero's job; `look = false` → validate ownership and expiry (or 0), set `equipped_appell_id`, push 3 `appell_id`, update visible avatars (map/room broadcasts carry `appellid`).
- `hero::titles::grant(player, appell_id)` (called by rankings, quests, events): upsert, push 4484 delta and 4491; recompute stats (113) if attributes are open.
- Scheduler: expire titles at `valid_until`, unequip if equipped, push 4484 and 3.
- Ranking titles (`CondtionType` 15/16, e.g. "Mais Poderoso Líder") are reassigned by the rankings job ([../rankings/README.md](../rankings/README.md)).

## 9. Open questions and assumptions

- Assumption: `appellId 0` unequips.
- Open: complete semantics of each `CondtionType` (server-side).
- Open: `Quality 2 → 3` remap reason (display only).

## 10. Implementation checklist

- [ ] Screens: AppellFrame, AppellItem, title combo, AppellGetView
- [ ] Route 8597 look
- [ ] Route 8597 equip/unequip
- [ ] Server message 4484
- [ ] Server message 4491
- [ ] Server message 3 `appell_id`, `applle_property_Open`
- [ ] Table `hero.titles`, columns on `hero.heroes`
- [ ] Rule: job filter, expiry, attribute accumulation
- [ ] Test: earn → popup after battle → equip → others see the title
