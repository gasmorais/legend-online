# Fantasy bar NPCs ("Bar da Fantasia")

Module `magic-pub` of feature `fantasy-bar`.

Path aliases:

| Alias | File |
|---|---|
| MPM | `decompiled/core_module/scripts/yishi/manager/MagicPubManager.as` |
| MPC | `decompiled/core_module/scripts/mvc/controler/MagicPubControler.as` |
| MPF | `decompiled/m11/scripts/magicpub/MagicPubFrame.as` |
| MPL | `decompiled/m11/scripts/magicpub/MagicPubListView.as` |
| MPI | `decompiled/m11/scripts/magicpub/MagicPubListItem.as` |
| MPV | `decompiled/m11/scripts/magicpub/MagicPubChatView.as` |
| CIM | `decompiled/core_module/scripts/yishi/datas/ConfigInfoManager.as` |

## 1. Overview

The bar lists 5 NPCs. Each has a friendship level (`grades`), friendship points (`gp`) toward the next level (`UpGradeTempInfos.xml` Types 126: level 2 at 155, 3 at 300, 4 at 560, 5 at 900), a mood (`isEvent`, shown as a double icon) and a daily state. Opening an NPC shows a dialog line chosen from `MagicPubChatInfos.xml` by NPC and level (capped at 4) and by `state` (1 greet, 2 ask, 3 thank). "Talk" (once a day, `isFirst`) and "Present" (pick a gift item, up to `magic_pub_present_count` = 10 a day) raise friendship and give magic dust. Help: "Diariamente ao conversar com as pessoas do bar da fantasia, poderá ganhar mais pontos de amizade podendo ativar mais cartas mágicas. Ás vezes haverá pessoas com bom humor, falando com eles poderá obter ganhos extraordinários. Ao presentear a outros, pode obter prêmios, quanto mais alto for a qualidade do item, melhor serão os prêmios."

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `MagicPubFrame` (MPF) | "Bar da Fantasia" | container switching list, chat and gift party views, help "Explicação do Bar da Fantasia" | controller `magicpub` (MPC); `show(3)` opens the gift party (MPF:126-147) | |
| `MagicPubListView` (MPL) | | NPC list, notice text, gift party button with "Tempo de abertura: {0}", magic spring buff 15 badge | default view | from `listMsg.infos` (MPL:71-96) |
| `MagicPubListItem` (MPI) | "Grau de Amizade Nv.{0}" | NPC row | MPL | icon `MagicPubNpcInfos.IconPath`, name, level (max shown 4), green progress `gp / Data(level+1)`, double icon if `isEvent` (MPI:95-121) |
| `MagicPubChatView` (MPV) | | NPC dialog, talk and present buttons, 10 gift slots | click on an item -> `MAGICPUB_OPEN_CHAT_VIEW` | dialog line, friendship progress "x/y" or "max", "ONúmero de presenteamentos restantes {0}/{1}" (`10 - presentCount`), gift slots from currencies 101..110 with amount > 0 (MPV:255-340) |

## 3. Routes (client to server)

All use C>S 9632 (0x25a0) `C_MAGIC_PUB_OP`, `MagicPubReqMsg`, sender `MPM.OperateMagicHotelReq` (MPM:187-196):

| Field | Tag | Type | Meaning |
|---|---|---|---|
| `op` | #1 | INT32 | 1 begin chat (talk), 2 ask chat (open dialog), 3 present (MPM:18-22) |
| `templateId` | #2 | INT32 | NPC template id 1..5 |
| `giftId` | #3 | INT32 | op 3: gift currency id (-1700..-1709 as sent by the slot `templeteId`, `CurrencyType.MAGIC_PUB_VALUE_LIST`) |
| `count` | #4 | INT32 | op 3: always 1 |

### R1. Open NPC dialog (op 2)
- Trigger: `MPV.set data` (MPV:200-209) after clicking a list item.
- Server: push 404 op 1 with this NPC (state for the dialog line, usually 1 greet or 2 ask).

### R2. Talk (op 1)
- UI: talk button, visible only when `isFirst` (MPV:247, 394-400).
- Server: once per NPC per day; add friendship `magic_pub_chat_add_favor[level-1]` and magic dust `magic_pub_chat_add_dust[level-1]` (doubled when `isEvent`, assumption), set `isFirst = false`, `state = 3`, push 404 op 1 with `tip` (the client shows it as a tip and system chat line, MPV:291-305) and 4725 for dust.

### R3. Present (op 3)
- UI: select a gift slot then the present button; without selection "Favor selecionar presente" (MPV:403-417).
- Client checks: none on counts (the label shows remaining).
- Server: validate `presentCount < 10` (per NPC per day, assumption) and gift amount >= 1; consume 1 gift (currency), add friendship `magic_pub_add_favor[q]` and dust `magic_pub_add_dust[q]` where `q` is the gift quality index 0..4, `presentCount += 1`, `state = 3`, push 4725 then 404 op 1 with `tip`.

## 4. Server messages (server to client)

### S1. 404 (0x0194) `U_C_MAGIC_PUB`, `MagicPubInfoListMsg`
Receiver `MPM.__magicPubHandler` (MPM:85-111), then `MAGICPUB_UPDATE_CHAT_VIEW`.

| Field | Tag | Type | Meaning |
|---|---|---|---|
| `op` | #1 | INT32 | 0 full list (replaces, sorted by templateId), 1 single NPC update (`infos[0]` merged into the cached entry) |
| `infos` | #2 | `MagicPubInfoMsg`, repeated | NPC states |
| `tip` | #3 | STRING | reward text shown after the dialog animation |

`MagicPubInfoMsg`: `templateId (#1, INT32)`, `grades (#2, INT32)` friendship level 1..5, `gp (#3, INT32)` points toward next level, `state (#4, INT32)` 1 greet / 2 ask / 3 thank, `presentCount (#5, INT32)` gifts given today, `isEvent (#6, BOOL)` good mood, `isFirst (#7, BOOL)` talk still available today.

When: op 0 at login and at the daily reset (the client never requests the list; the list view and `canChatCount` read the cache, MPL:71-85, MPM:155-170); op 1 after each 9632.

### S2. 4725 currency refresh
Gift amounts (master types 101..110) and magic dust (`decompiled/core_module/scripts/managers/PlayerCurrencyManager.as:528-552`). See [currency](../currency/README.md).

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Level 32 to enter | yes | `SwitchPageHelp.as:1691-1697` |
| Friendship thresholds | level 2: 155, 3: 300, 4: 560, 5: 900 (`Data` of Types 126 at `Grades = level + 1`) | `UpGradeTempInfos.xml`, MPI:107-118 |
| Displayed level cap | 4 | MPI:105, MPV:226 |
| Daily presents | `magic_pub_present_count` = 10 | `ConfigInfos.xml`, CIM:242-245 |
| Present favor by quality | 2, 4, 6, 8, 12 | `magic_pub_add_favor` |
| Present dust by quality | 60, 70, 80, 90, 120 | `magic_pub_add_dust` |
| Talk dust by level | 50, 65, 80, 100 | `magic_pub_chat_add_dust` |
| Talk favor by level | 5, 7, 9, 12 | `magic_pub_chat_add_favor` |
| Good mood | double gains (assumption from the "double" icon and help item 2) | MPI:106, MPV:248 |
| Magic spring buff 15 "Coração sincero" | +100% friendship gain (assumption: applies to talk and present) | MPL:88-95, `MagicSpringTempInfos.xml` |
| Gift items | -1700 Sorvete, -1701 Papagaio, -1702 Chocolate, -1703 Lanternas, -1704 Galinhas fritas e Cerveja, -1705 Álbum de Fotos, -1706 Balde Sorvete, -1707 Vaso de Tulipas, -1708 Cerejas Enlatadas, -1709 Álbum Novo | `ItemTempInfos.xml`, `CurrencyType.as:136-138` |

## 6. Templates

| File | Record | Fields |
|---|---|---|
| `MagicPubNpcInfos.xml` | NPC | `TemplateId`, `TemplateName`, `IconPath`, `ResourcePath` |
| `MagicPubChatInfos.xml` | dialog per NPC and level 1..4 | `TemplateId`, `Grade`, `GreetWord`, `AskWord`, `ThankWord` (pipe separated) |
| `UpGradeTempInfos.xml` Types 126 | friendship levels | `Grades`, `Data` |
| `ConfigInfos.xml` | `magic_pub_*` | above |

## 7. Persistent state

```sql
CREATE SCHEMA IF NOT EXISTS fantasy_bar;

CREATE TABLE fantasy_bar.npc_friendships (
  player_id       BIGINT NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  npc_id          SMALLINT NOT NULL CHECK (npc_id BETWEEN 1 AND 5),
  grade           SMALLINT NOT NULL DEFAULT 1 CHECK (grade BETWEEN 1 AND 5),
  points          INTEGER NOT NULL DEFAULT 0 CHECK (points >= 0),
  state           SMALLINT NOT NULL DEFAULT 1 CHECK (state BETWEEN 1 AND 3),
  present_count   SMALLINT NOT NULL DEFAULT 0 CHECK (present_count >= 0),
  is_event        BOOLEAN NOT NULL DEFAULT false,
  can_talk        BOOLEAN NOT NULL DEFAULT true,
  reset_on        DATE NOT NULL,
  PRIMARY KEY (player_id, npc_id)
);
```

Gift item balances and magic dust live in the currency tables of [currency](../currency/README.md).

## 8. Backend implementation notes

| op | Handler |
|---|---|
| 2 | `fantasy_bar::magic_pub::handle_open_dialog` |
| 1 | `fantasy_bar::magic_pub::handle_talk` |
| 3 | `fantasy_bar::magic_pub::handle_present` |

- Lazy daily reset per row: `present_count = 0`, `can_talk = true`, `state = 1`, reroll `is_event` (assumption: small chance per NPC per day).
- Level up loop: while `points >= Data(grade+1)` subtract (or keep cumulative, see open questions) and increment grade; notify [magic-cards](../magic-cards/README.md) to unlock cards for the new level.
- Talk/present in one transaction with currency changes; push 4725 then 404 op 1.

## 9. Open questions and assumptions

- Whether `gp` is cumulative or resets per level (client shows `gp / Data(level+1)`, so per level is the natural reading).
- Gift quality mapping of the 10 gift items to the 5 quality buckets (assumption: by item `Quality` or position in the list, 2 items per bucket).
- Mood probability and its exact effect.

## 10. Implementation checklist

- [ ] Screens list, chat view
- [ ] Route 9632 ops 1, 2, 3
- [ ] Server message 404 op 0 at login and reset, op 1 after actions
- [ ] Currency 4725 for gifts and dust
- [ ] Table `fantasy_bar.npc_friendships`
- [ ] Daily reset
- [ ] Magic card unlock hook
- [ ] Tests: present cap, level thresholds, dust amounts by level and quality
