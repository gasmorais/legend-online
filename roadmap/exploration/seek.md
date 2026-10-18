# Treasure seek protocol ("Caça ao Tesouro")

Feature [exploration](README.md), module `seek`. Protobuf package `seek` (opcodes 9502, 4914, 4915). The UI package `treasurehunt` (`TreasureHuntFrame` "Caça ao Tesouro") is registered under [treasures](../treasures/README.md); this file maps the protocol and the server rules, and the UI facts needed to drive it.

## 1. Overview

- The player owns up to 10 "Caça ao Tesouro" charges (one regenerates on a timer). Each hunt moves the hero on a world picture to a random node (`SeekNodeMsg`) and triggers an event described by text ("Você encontra-se {0}, {1}"). The player resolves the event (open treasure) or gives up.
- Hunts drop "Fragmento da Magia Misteriosa" (2131019); 100 fragments exchange into 1 "Selo Mágico" ("100 fragmentos mágicos podem ser trocados por 1 Selo Mágico"); the item "Roleta do Tempo" (2131022) adds one charge.
- Unlock: hero level 32 (`decompiled/core_module/scripts/mvc/controler/TreasureHuntControler.as:30-40`, `decompiled/core_module/scripts/yishi/SwitchPageHelp.as:1819-1833`).
- Client sending is broken in this build: `TreasureHuntControler.sendHuntRequest(op)` has an empty body (`decompiled/core_module/scripts/mvc/controler/TreasureHuntControler.as:59-61`; the transpiled `build/as3/gen/mvc/controler/TreasureHuntControler.ts:32-34` is also empty), so no 9502 packet is ever sent. The request layout below is reconstructed (assumption) and must be confirmed against the original bytecode before implementation.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `decompiled/m3/scripts/treasurehunt/TreasureHuntFrame.as` | "Caça ao Tesouro"; "Caça ao Tesouro restante: {0}/10"; "Após {0} poderá adicionar 1 caça ao tesouro (máximo de 10 vezes)"; "Caça ao Tesouro atingiu limite (máximo de 10 vezes)"; "Após {0} poderá continuar à Caça ao Tesouro" | World picture, hero walker, hunt, add charge, exchange, 3 line message log (`:136-342`) | controller `treasurehunt` (`SwitchPageHelp.gotoTreasureHunt`, chat link "Ir à Caça" `decompiled/core_module/scripts/chat/view/ChatOutputViewII.as:380-391`) | 4914 state, 4915 messages, fragment count |
| `decompiled/m3/scripts/treasurehunt/HunterDialogFrame.as` | "Você encontra-se {0}, {1}" | Event dialog: confirm (op 4) or cancel (quit alert) (`:75-95`) | `TreasureHuntControler.showDialogFrame` when `state != 0` | node name, `eventDesc` |
| `treasurehunt.SimpleAlert` | "Grande Líder, desistir dessa Caça ao Tesouro ou sair temporariamente e continuar depois?" | Give up (op 5) or close (`TreasureHuntControler.as:83-113`) | dialog cancel | |
| `decompiled/m5/scripts/magicCard/view/MagicCardSlotView.as` | | Shows a hunt hint when `seekCount > 0` (`:162-170`) | magic cards | `seekCount` |

## 3. Routes (client to server)

Send 9502 (0x251e) `C_SEEK_REQ` ("寻宝系统请求", `decompiled/core_module/scripts/yishi/datas/consant/ProtocolTypeTable.as:1342`). Op codes `decompiled/core_module/scripts/mvc/module/treasurehunt/SeekType.as:6-18`. Assumed request body: `PlayerSeekInfoMsg` with only `op` (#6, INT32) set (the only seek message carrying an op).

| # | op | Intended UI caller | Client checks | Expected reply |
|---|---|---|---|---|
| K1 | 1 SEEK_OPEN | frame open (`TreasureHuntFrame.as:142`) | level 32 | 4914 `op = 1` with `seekNodeList`, counts, state |
| K2 | 2 SEEK_SYNCINFO | charge timer end (`TreasureHuntFrame.as:268-272`) | timer | 4914 `op = 2` |
| K3 | 3 SEEK_START | hunt button (`TreasureHuntFrame.as:311-315`) | `seekCount > 0` (button enabled, `:234`) | 4914 `op = 3`, `state = 1`, new `curNodeId`, `eventDesc`; 4915 log line |
| K4 | 4 OPEN_TREASURE | dialog confirm (`HunterDialogFrame.as:75-81`) | dialog open | 4914 `op = 4`, `state = 0`; bag 115 rewards; 4915 log line |
| K5 | 5 SEEK_GIVEUP | quit alert confirm (`TreasureHuntControler.as:102-107`) | | 4914 `state = 0` |
| K6 | 6 MAGIC_EXCHANGE | exchange alert confirm (`TreasureHuntControler.as:115-131`) | | bag 115 (100 x 2131019 -> 1 seal) |
| K7 | 7 ADD_SEEKCOUNT | add charge button (`TreasureHuntFrame.as:317-321`) | owns 2131022 (tip) | 4914 `seekCount + 1`, bag 115 |

## 4. Server messages (server to client)

Receivers `decompiled/core_module/scripts/managers/TreasureHuntManager.as` (`THM:45-86`, listeners `THM:47-48`).

### 4914 (0x1332) `U_C_SEEK_LOADNODEINFO`

`PlayerSeekInfoMsg`: `seekCount` (#1, INT32) charges 0..10; `nextAddTime` (#2, INT64) seconds until the next charge (the frame counts it down in minutes and requests op 2 at the end, `TreasureHuntFrame.as:209-262`); `state` (#3, INT32) 0 idle, 1 event pending; `eventDesc` (#4, STRING) event text; `curNodeId` (#5, INT32) node where the hero stands; `op` (#6, INT32) op being answered; `seekNodeList` (#7, MESSAGE `SeekNodeListMsg`: `seekNode` (#1, `SeekNodeMsg`, repeated: `nodeId` (#1, INT32), `nodeName` (#2, STRING), `pointX` (#3, INT32), `pointY` (#4, INT32) pixel position on the picture)). Nodes are appended only when `op == 1`. Client reactions (`TreasureHuntFrame.as:180-220`): op 1 places the hero, opens the event dialog if `state == 1`; op 3 with `state == 1` walks the hero from the previous node and disables buttons; op 4 with `state == 0` closes the dialog.

### 4915 (0x1333) `U_C_SEEK_MESSAGE`

`MessageForSeekMsg`: `info` (#1, STRING) message line; the frame keeps the last 3 (`TreasureHuntFrame.as:279-298`).

## 5. Rules and formulas

- Max 10 charges; `nextAddTime` regeneration period not in client data.
- 100 x 2131019 -> 1 seal (seal item id not in client text, open question).
- "Roleta do Tempo" (2131022) consumed by op 7.
- Event and reward tables are not in client data.

## 6. Templates

None in `raw/xml/tempinfos/` for nodes or events; nodes come from the server (`seekNodeList`).

## 7. Persistent state

```sql
CREATE TABLE exploration.seek_state (
  player_id        BIGINT     PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
  charges          SMALLINT    NOT NULL DEFAULT 10 CHECK (charges BETWEEN 0 AND 10),
  next_charge_at   TIMESTAMPTZ,
  cur_node_id      INTEGER,
  pending_event_id INTEGER,
  updated_at       TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE exploration.seek_node (
  node_id     INTEGER  PRIMARY KEY,
  node_name   TEXT     NOT NULL,
  point_x     SMALLINT NOT NULL,
  point_y     SMALLINT NOT NULL
);
```

## 8. Backend implementation notes

- `exploration::seek::handle_request` (9502) dispatching ops 1..7 to `handle_open`, `handle_sync`, `handle_start`, `handle_open_treasure`, `handle_give_up`, `handle_exchange`, `handle_add_charge`.
- Lazy regeneration: while `charges < 10`, add one charge per period since `next_charge_at`.
- Start: `charges > 0`, no pending event -> consume, pick a random node and event, store pending, reply 4914 (`op = 3`, `state = 1`) and 4915.
- Open treasure: pending event -> grant rewards (fragments 2131019 among them), clear, reply 4914 (`op = 4`, `state = 0`) and 4915.
- Exchange: remove 100 x 2131019, add the seal.

## 9. Open questions and assumptions

- Request message of 9502 and the sender body are missing from the decompiled client (see overview); fix via a `PATCHES` entry once recovered.
- Regeneration period, node list, events, rewards and seal id.

## 10. Implementation checklist

- [ ] Recover `TreasureHuntControler.sendHuntRequest` (transpiler patch)
- [ ] Route K1..K7 on 9502
- [ ] Server message 4914 `PlayerSeekInfoMsg`
- [ ] Server message 4915 `MessageForSeekMsg`
- [ ] Tables `exploration.seek_state`, `exploration.seek_node`
- [ ] Charge regeneration
- [ ] Test: give up clears the pending event; exchange needs 100 fragments
