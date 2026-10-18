# Documentation

Technical documentation of the Legend Online client: how the original Flash game is built, how it is rebuilt for the browser, and the game knowledge extracted from its code and data.

## Overview

| Document | Content |
|---|---|
| [overview/architecture.md](overview/architecture.md) | Layers of the system, from the decompiled AS3 to the browser runtime and the server |
| [overview/roadmap.md](overview/roadmap.md) | Current state, work in progress and next steps |

## Client

| Document | Content |
|---|---|
| [client/renderer.md](client/renderer.md) | HTML5 renderer and Flash runtime on PixiJS |
| [client/graphics.md](client/graphics.md) | SWF graphics, symbols, filters and color transforms |
| [client/animations.md](client/animations.md) | Animation sequences, avatars and mounts |
| [client/asset-catalog.md](client/asset-catalog.md) | Resource manifest and asset groups |
| [client/components.md](client/components.md) | PickGliss UI components |
| [client/managers.md](client/managers.md) | Game managers and their responsibilities |

## User interface

| Document | Content |
|---|---|
| [ui/README.md](ui/README.md) | How screens are composed from styles and symbols |
| [ui/screens.md](ui/screens.md) | Every frame, scene and tip of the client |
| [ui/navigation.md](ui/navigation.md) | Buttons, handlers, opened screens and their opcodes |
| [ui/modules/](ui/modules/) | Composition tree of each screen, per code module |

## Battle

| Document | Content |
|---|---|
| [battle/README.md](battle/README.md) | Battle flow, scene and protocol overview |
| [battle/formation.md](battle/formation.md) | Grid, positions and formations |
| [battle/hud.md](battle/hud.md) | Battle HUD layout and behavior |
| [battle/rules.md](battle/rules.md) | Rules, conditions and sequences |
| [battle/server-engine.md](battle/server-engine.md) | Authoritative battle engine of the mock server |
| [battle/chess-modes.md](battle/chess-modes.md) | The two chess game modes |

## World

| Document | Content |
|---|---|
| [world/README.md](world/README.md) | Scenes, worlds, dungeons and room protocol |
| [world/maps.md](world/maps.md) | Map files, borders, spawns and coordinates |

## Mechanics

| Document | Content |
|---|---|
| [mechanics/README.md](mechanics/README.md) | Index of game mechanics and systems |
| [mechanics/catalog.md](mechanics/catalog.md) | Catalog of all mechanics in the database |

Related references outside this folder: [protocol/socket.md](../protocol/socket.md), [protocol/proto.md](../protocol/proto.md), [db/README.md](../db/README.md).
