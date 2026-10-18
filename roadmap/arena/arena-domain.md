# Arena domain hub ("Domínio da Arena")

Module `arena::domain`. Prefixes as in [README.md](README.md).

## 1. Overview

`godpvpenter.GodPvpEnterFrame` (790x566, title `godpvp.enter.title` "Domínio da Arena") is a scrollable list of arena tiles. In this client it contains exactly two tiles, both for the Theseus arenas: "Arena de Teseu" and "Arena MP Teseu" (`M11/godpvpenter/GodPvpEnterFrame.as:45-54`). It has no own protocol; it reads the Theseus season and user state already pushed by the server.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `godpvpenter.GodPvpEnterFrame` | Domínio da Arena | hub | controller `godpvpenter` (`CM/mvc/controler/GodPvpEnterController.as:21`), from NPC dialog option 162 (`M3/map/space/view/frame/DialogOptionItem.as:886-887`; `CM/yishi/SwitchPageHelp.as:3150-3153`) | tiles below |
| `godpvpenter.item.TheseusPvpEnterItem` | Arena de Teseu | click enters `THESE_PVP_SCENE` | frame | "Graduação" stage, countdown "Até a próxima temporada: {0}" / "Até o fim da temporada: {0}", red dot (`M11/godpvpenter/item/TheseusPvpEnterItem.as:62-195`) |
| `godpvpenter.item.TheseusDoublePvpEnterItem` | Arena MP Teseu | buttons join (room list) and create room | frame | same for MP (`M11/godpvpenter/item/TheseusDoublePvpEnterItem.as:69-238`) |
| `godpvpenter.item.GodPvpWaitItem` | | placeholder tile "wait" (not instantiated by the frame) | | `M11/godpvpenter/item/GodPvpWaitItem.as` |

## 3. Routes (client to server)

None of its own. Tile clicks send 9712 op 1 / 5023 + 9736 op 1 and are documented in [../theseus-arena/season.md](../theseus-arena/season.md) (E1, E3, E4).

## 4. Server messages (server to client)

None of its own. Needs 4320 / 583 (season) and 4312 / 575 (user) already received (notifications `thesepvpUpdateEnterTime`, `thesedoublepvpUpdateEnterTime` refresh the tiles).

## 5. Rules and formulas

| Rule | Source |
|---|---|
| Tiles render nothing below royalty level `RoyaltyTempCate.getPvpLv(1)` (6) | `TheseusPvpEnterItem.as:92-96` |
| Dragon talker state blocks clicks ("No estado de Encantador de Dragões, não é possível participar do evento. Altere-o.") | `TheseusPvpEnterItem.as:177-181` |

## 6. Templates

`TPL/RoyaltyTemplates.xml` (`OpenPvp`), `TPL/TheseusPvpTmpls.xml`, `TPL/TheseusMultiPvpTmpls.xml` (stage names).

## 7. Persistent state

None.

## 8. Backend implementation notes

Nothing to implement besides the NPC dialog option 162 in the NPC dialog data and the Theseus pushes at login.

## 9. Open questions and assumptions

- (A) `GodPvpWaitItem` suggests a "coming soon" tile in other builds.

## 10. Implementation checklist

- [ ] NPC option 162 present in the space NPC dialog
- [ ] Theseus season and user pushes at login so the tiles render
