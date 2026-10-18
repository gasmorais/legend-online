# Treasure hunt ("Caça ao Tesouro")

Module `treasure-hunt` of feature `treasures`. Protobuf package `seek`.

Path aliases:

| Alias | File |
|---|---|
| THM | `decompiled/core_module/scripts/managers/TreasureHuntManager.as` |
| THC | `decompiled/core_module/scripts/mvc/controler/TreasureHuntControler.as` |
| HPM | `decompiled/core_module/scripts/mvc/module/treasurehunt/HuntPointModel.as` |
| SKT | `decompiled/core_module/scripts/mvc/module/treasurehunt/SeekType.as` |
| THF | `decompiled/m3/scripts/treasurehunt/TreasureHuntFrame.as` |
| HDF | `decompiled/m3/scripts/treasurehunt/HunterDialogFrame.as` |

## 1. Overview

A world map with named nodes. The player has up to 10 seek attempts ("Caça ao Tesouro restante: {0}/10") that regenerate over time ("Após {0} poderá adicionar 1 caça ao tesouro (máximo de 10 vezes)"). The hunt button moves the hero figure to a random node where an event happens; the dialog "Você encontra-se {node}, {event}" offers to open the treasure (confirm) or give up. Events and rewards are written in a 3 line log. "Fragmento da Magia Misteriosa" (2131019) accumulates; "100 fragmentos mágicos podem ser trocados por 1 Selo Mágico". "Roleta do Tempo" (2131022) adds one attempt. Requires level 32.

Status: `THC.sendHuntRequest(op)` is an empty function (THC:59-61), so every action in this client sends nothing. The server pushes are still handled, and `PlayerMsg.seekSurplusTime (#120)` updates the attempt count (`decompiled/core_module/scripts/yishi/manager/PlayerManager.as:1140-1143`), which makes the magic card and equip buttons glow (`decompiled/m5/scripts/magicCard/view/MagicCardSlotView.as:162-170`, `decompiled/m5/scripts/armyII/viewII/equip/EquipView.as:612-630`) and adds an exit reminder (`decompiled/core_module/scripts/yishi/utils/ExitGameUtils.as:88-92`).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `TreasureHuntFrame` (THF) | "Caça ao Tesouro" | map, hero, buttons hunt, exchange and add-attempt buttons | controller `treasurehunt` (level >= 32 else "Não atingiu o nível 32, não é capaz de Pesquisar Tesouro.", THC:30-40); chat seek link type 26 (`decompiled/core_module/scripts/chat/view/ChatOutputViewII.as:379-391`, `decompiled/core_module/scripts/chat/utils/ChatFormat.as:220-223,755-770`); task condition 91 (`decompiled/core_module/scripts/yishi/SwitchPageHelp.as:359,1819-1832`) | fragment count 2131019 (THF:133), attempts and timer texts (THF:221-244), last 3 messages (THF:285-303) |
| `HunterDialogFrame` (HDF) | | event dialog: confirm = open treasure, cancel = alert | `THC.showDialogFrame` when `state != 0` (THC:63-75) | "Você encontra-se <font color='#ff0000'>{0}</font>, {1}" |
| Alert `treasurehunt.SimpleAlert` | | "Grande Líder, desistir dessa Caça ao Tesouro ou sair temporariamente e continuar depois?" | HDF cancel (HDF:85-90, THC:83-91) | confirm = give up (op 5), cancel = close frame |

## 3. Routes (client to server)

Intended route: C>S 9502 (0x251e) `C_SEEK_REQ` ("寻宝系统请求"). No request message exists in `protocol/proto.json` package `seek`; assumption: a body carrying the op (for example a generic `{ op (#1, INT32) }`). All calls go through the empty `THC.sendHuntRequest`.

| op (SKT) | Trigger | Call site | Client checks | Expected response |
|---|---|---|---|---|
| 1 `SEEK_OPEN` | frame created | THF:142 | level 32 | 4914 `op = 1` with node list |
| 2 `SEEK_SYNCINFO` | regeneration timer completed | THF:268-272 | `seekCount < 10` | 4914 `op = 2` |
| 3 `SEEK_START` | hunt button | THF:311-315 | button enabled when `seekCount > 0` and not moving (THF:233-239) | 4914 `op = 3`, `state = 1`, new `curNodeId`; 4915 messages |
| 4 `OPEN_TREASURE` | dialog confirm | HDF:77-83 | | 4914 `op = 4`, `state = 0`; 4915; bag updates |
| 5 `SEEK_GIVEUP` | give up alert confirm | THC:102-113 | | 4914 `state = 0` |
| 6 `MAGIC_EXCHANGE` | exchange button + confirm "100 fragmentos mágicos podem ser trocados por 1 Selo Mágico" | THF:305-309, THC:115-131 | none | bag updates, 4915 |
| 7 `ADD_SEEKCOUNT` | add-attempt button "Use {0} para adicionar mais uma chance de pesquisar tesouro" | THF:317-321 | | 4914 with `seekCount + 1` |

## 4. Server messages (server to client)

### S1. 4914 (0x1332) `U_C_SEEK_LOADNODEINFO`, `PlayerSeekInfoMsg`
Receiver `THM.__nodeHandler` (THM:51-78), dispatches `HUNT_TEM`.

| Field | Tag | Type | Meaning |
|---|---|---|---|
| `seekCount` | #1 | INT32 | attempts left (max 10) |
| `nextAddTime` | #2 | INT64 | time until the next attempt (seconds as displayed by `DateFormatter.getFullTimeString`; the timer code also divides by 1000, see open questions) |
| `state` | #3 | INT32 | 1 = at an event node, 0 = idle |
| `eventDesc` | #4 | STRING | event text for the dialog |
| `curNodeId` | #5 | INT32 | current node |
| `op` | #6 | INT32 | echo of the request op; 1 places the hero, 3 animates a move, 4 with state 0 closes the dialog (THF:174-219) |
| `seekNodeList` | #7 | `SeekNodeListMsg` | only read when `op == 1`: `seekNode (#1, SeekNodeMsg, repeated)` with `nodeId (#1, INT32)`, `nodeName (#2, STRING)`, `pointX (#3, INT32)`, `pointY (#4, INT32)` |

### S2. 4915 (0x1333) `U_C_SEEK_MESSAGE`, `MessageForSeekMsg`
Receiver THM:80-86. `info (#1, STRING)` appended to the last 3 lines of the log.

### S3. `PlayerMsg.seekSurplusTime (#120, INT32)`
Attempts left at login (player info push, see [account](../account/README.md)).

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Unlock | level 32 | THC:33-38, `SwitchPageHelp.as:1825-1830` |
| Max attempts | 10 | language `hunt.TreasureHuntFrame.huntcountFull`, THF:225 |
| Regeneration | +1 per `nextAddTime` while < 10 | THF:194-218 |
| Fragment exchange | 100 x 2131019 -> 1 "Selo Mágico" | `hunt.TreasureHuntFrame.exchangeBtnTipData` |
| Extra attempt | 1 x 2131022 "Roleta do Tempo" | THF:115-116, `ItemTempInfos.xml` |
| Close blocked | while moving (`closeButton.enable = false`) | THF:199-204, 358-370 |

## 6. Templates

`ItemTempInfos.xml`: 2131019, 2131022 and the "Selo Mágico" item (template id not referenced by the client). Node list and events are server data (no XML).

## 7. Persistent state

```sql
CREATE TABLE treasures.hunt_nodes (
  node_id         INTEGER PRIMARY KEY,
  node_name       TEXT NOT NULL,
  point_x         INTEGER NOT NULL,
  point_y         INTEGER NOT NULL
);

CREATE TABLE treasures.hunt_players (
  player_id       BIGINT PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
  seek_count      SMALLINT NOT NULL DEFAULT 10 CHECK (seek_count >= 0),
  next_add_at     TIMESTAMPTZ,
  state           SMALLINT NOT NULL DEFAULT 0 CHECK (state IN (0, 1)),
  cur_node_id     INTEGER REFERENCES treasures.hunt_nodes(node_id),
  event_code      INTEGER,
  event_desc      TEXT
);
```

## 8. Backend implementation notes

Handlers `treasures::treasure_hunt::handle_open`, `handle_sync`, `handle_start`, `handle_open_treasure`, `handle_give_up`, `handle_magic_exchange`, `handle_add_count`, all on 9502. Regeneration computed lazily from `next_add_at`. Since the client never sends 9502, the only live server work is `PlayerMsg.seekSurplusTime` at login (send the real count or 0 to avoid misleading glows).

## 9. Open questions and assumptions

- 9502 has no sender and no request message; the op values come from `SeekType`.
- `nextAddTime` unit is inconsistent in the client (THF:246-252 divides by 1000, THF:213-218 does not).
- Event tables, rewards and the "Selo Mágico" template id are unknown.

## 10. Implementation checklist

- [ ] `PlayerMsg.seekSurplusTime` at login
- [ ] Screen `TreasureHuntFrame` (only if the sender is restored)
- [ ] Route 9502 ops 1..7 (blocked by the empty client sender)
- [ ] Server messages 4914, 4915
- [ ] Tables `treasures.hunt_nodes`, `treasures.hunt_players`
- [ ] Tests: regeneration, cap 10, exchange 100:1
