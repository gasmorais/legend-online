# Graphics: avatars, battle units, effects and maps (Legend Online BR)

This document specifies the graphic resource formats the client loads and how it assembles them: map/city avatars (`.bswf`), battle units (MovieClip SWFs), skill effects, map backgrounds and data, and the game templates that point to them. It is the format reference for the HTML5 renderer ([renderer.md](renderer.md)); animation sequences are in [animations.md](animations.md), the full CDN catalog in [asset-catalog.md](asset-catalog.md) and map geometry in [../world/maps.md](../world/maps.md).

**Conventions**
- Source: decompiled AS3. Paths are relative to `decompiled/core_module/scripts` unless stated otherwise.
- Counts come from `index/manifest_res.json` (52 275 entries). The manifest looks **partial**, so "0 in manifest" does not prove a resource is missing.
- *(assumption)* marks unconfirmed statements.

## 1. Map/city avatars: `.bswf` (pre-rendered bitmaps)

### URL

`PathManager.getAvatarResourcePath(res, sex, kind, pos, job, src, ext=".bswf")` (`yishi/manager/PathManager.as:377`):

| case | path |
|---|---|
| equipment | `swf/avatar{res}/{sex}.bswf` |
| fashion/wing | `swf/avatar{res}/{job}_{sex}.bswf` (dragonic: `4_{sex}`) |
| mount/pet | `swf/avatar{res}/2.bswf` |
| NPC | `swf/npc/{id}.bswf` |

- `job`: 1 = warrior, 2 = hunter, 3 = wizard, 4 = dragonman (`yishi/datas/consant/JobType.as:8-18`). `sex` = 0/1 *(which one is male: assumption; [asset-catalog.md](asset-catalog.md) reads 0 = female, 1 = male)*.
- Default parts: `/warrior_default_body`, `/hunter_default_arms`, `/wizard_default_hairUp`, `/dragonic/dragonman_default_…`, `…body_cloak`, `/mount_default`. When mounted without a standing pose, each part gets the `_mount` suffix.
- The manifest has **16 297 `.bswf`**: `1_0` … `3_1` (about 2.4k each), `2.bswf` (636, mounts) and `4_x` (about 405).

### `.bswf` format

Verified in `com/pickgliss/loader/DomainResourceLoad.as:84-150`. The file is a sequence of TLVs `[u8 tag][value]`:

| tag | field | type |
|---:|---|---|
| 1 | sizeType | byte |
| 2 | standsPara | UTF |
| 3 | walksPara | UTF |
| 4 | noShadow | bool |
| 5 | showNamePosY | int |
| 6 | curTotalFrameX | byte |
| 7 | offsetY | int |
| 8 | attackPara | UTF |
| 9 | flight | int |
| 16 | `int len` + **plain SWF** | loaded with `Loader.loadBytes` |

`*Para` = `k:fx_fy,x:..,y:..|…`, the per-frame offset (`avatar/data/AvatarLayouData.as:31-80`).

### Classes, directions and frames

| item | rule |
|---|---|
| per-frame class (BitmapData) | `asset.{parentFolder}_{file}.S_{frameX}_{dir}` (stand) or `.W_{frameX}_{dir}` (walk). Example: `swf/avatar/fashion_cloth_ballet/1_0.bswf` → `asset.fashion_cloth_ballet_1_0.S_0_0` |
| walk | 5 directions (0 = down, 1 = down diagonal, 2 = side, 3 = up diagonal, 4 = up), 6 frames; left mirrors right (`scaleX = −1`) |
| stand | 3 directions (dir 0/1 → 0, 2/3 → 1, 4 → 2), 5 frames (`m3/scripts/avatar/view/HeroAvatar.as`) |
| map actions | only S and W |

### Layers and z-order

Layers: `body`, `army` (weapon), `hairUp`, `hairDown`, `cloak`/`wing`, `mount`, `mountWing`, `pet` (`AvatarPosition.as`).

Each layer has a weight per direction (`AvatarStaticData.getBaseNumByType`). The sort is descending: **the higher weight is drawn first, i.e. behind**. Walk on foot, directions 0 to 4:

| layer | weights |
|---|---|
| body | `[10,20,40,40,40]` |
| army | `[20,10,0,0,0]` |
| hairUp | `[0,0,10,10,10]` |
| hairDown | `[30,30,20,20,20]` |
| cloak/wing | `[40,40,30,30,30]` |
| pet | `−10` |

Mounted avatars use separate `_MOUNT` tables (mount = 50/60).

- **Frame composition:** `dest = sizeMax[layer.sizeType] − sizeMax[avatar.sizeType] + cell.{x,y} (+ mount offsetY)`. Tables `sizeMaxNew`/`sizeMaxOld` in `Avatar.as:36-256`.
- **Shadow:** `asset.core.StandShadowAsset` / `MountStandShadowAsset`.

### UI avatar ("show")

Source: `avatar/view/ShowAvatar.as:110-178`.
- SWF `equip_show{res}{sex}.swf` or `…{job}_{sex}.swf`, with `/front/` and `/back/` folders.
- Draw order: backHair, wing, backCloak, arms, body, frontCloak, frontHair, pet (hunter/dragon: body and arms swap).

## 2. Battle units (SWF with MovieClip + labels)

### Player hero

`yishi/view/tools/HeroMovieClip.as:112-121` stacks the layers **back to front**:
`cloak2, mount(dragon), arms2, hair4, hair3, body, hair2, arms, hair1, cloak1`.

Part URLs (`battle/view/roles/HeroLoadDataFactory.as`):

| part | path |
|---|---|
| fashion | `equip{res}/{job}_{sex}.swf` (15 105 in manifest) |
| equipment | `equip{res}/{sex}.swf` |
| default | `equip/{warrior\|hunter\|wizard\|dragonic/dragonman}_default_{part}{suf}/{sex}.swf` |
| template 100 | `equip/mystery_default_body/2.swf` |
| pet | `equip{PetAvatar}/2.swf` |
| child | `equip/hychild{ResPath}/2.swf` |
| dragon mount | `equip/dragonic{AvatarPath}/2.swf` |

- The trailing number of a part selects the exported class: index 0 → `ClassExport`, index n → `ClassExport{n}`. **One hair SWF holds 4 layers** (`ClassExport1..4`; `yishi/datas/battle/ResourceModel.as:118-131`).
- All parts play in sync.
- Anchors are the children `pos_head`, `pos_body`, `pos_leg` and `shadow`.

### Monsters, bosses, pawns and NPC heroes

- SWF `swf/{res}/{res}.swf`, class `slg.resource.movie.MovieAsset{res}` (`PathManager.as:97,135`).
- `res`: `MonsterTempInfo.ResPath`, `PawnTemplate.Swf` or the NPC hero's `resPath`.

### Action labels

Source: `yishi/view/tools/ActionMovie.as:163-266`.

| label | behavior |
|---|---|
| `Stand`, `Walk`, `Ready` | loop |
| `Victory`, `Failed` | stop at the end (STOP) |
| `Die` | death |
| `Danny` | take damage |
| attack | label from `ActionInfos.Para[0]` (ActionType 1), then back to `Stand` |

- Facing left: `scaleX = −1` (face 2).
- Death: procedural particles (`battle/particle/crush`, `cut`, `freeze`) that shatter the bitmap.

## 3. Skill effects

Chain: skill → `SkillTempInfo.ActionId` → `ActionInfos` (`yishi/resolve/ActionTemplateInfoResolveII.as`).

| `Para` type | fields |
|---|---|
| 2/5 | `type, target, x, y, effectRes, arrange` |
| 3 | `type, x, y, effectRes, …` |
| 11 | `arrowRes, …, dannyRes, rippleRes` |
| 0/21 | `dustRes` |

- **File:** `skillEffect/{name with . → _}.swf` (81 in manifest). Class = linkage name (`battle/skillsys/loader/SkillResourceLoader.as:182-187`).
- `skill_public.swf` is always loaded.
- **Buffs:** class `slg.resource.BufferEffect{id}` exists (`BufferIconFactory.getBufferEffect`) but is never called; buffs actually load by linkage through `BufferIconFactory.getBufferEffectII(link)` (`battle/view/buffer/BufferIconFactory.as:22`, called from `battle/view/roles/RoleViewBase.as:535,711`). See [../mechanics/skills_buffs.md](../mechanics/skills_buffs.md).

## 4. Maps

| map kind | rendering |
|---|---|
| battle | see [../battle/README.md](../battle/README.md) §4 (`sceneIma/{id}/map{id}.swf`, parallax layers) |
| instances/campaign | `m3/scripts/map/campaign/view/CampaignMapView.as:447-480`: either `BgLayer` with **300 px** tiles `mapmaterial/land/{MapFileId}/tile_{x}_{y}.jpg`, or `MapRenderLayer`, which composes the map from `floorData` (items `{url,x,y,rotation,baseNum}`; `baseNum 101` = repeated background; images in `mapmaterial/floor/…`) |
| city/world | `MapBackgroundView3D`, **512×512** cells, `tile_{row}_{col}.jpg` or `.png.atf` (Stage3D); `land/1..5` are 20×20 grids |

**Data files**
- `maps/{id}/{id}.maps` = zlib + 3 AMF3 objects (floorData, moviesData, topsData).
- `.titles` = zlib + AMF3.
- Walk grid: **orthogonal, 20 px** (key `"{x/20}_{y/20}"` present = walkable).
- Buildings: `mapmaterial/build/{sonType}.swf` (197).

**Engine.** Flash display list (`copyPixels`). Starling/speedEngine (m3) is used only for the 3D background (ATF) and `stage3drender/avatar`.

In the HTML5 rebuild the Reino do Céu lobby (map 10000) runs on the 2D path with its 300 px tiles in `raw/mapmaterial/land/10000`. Units, formats and per-map details: [../world/maps.md](../world/maps.md).

## 5. Game templates (`{TPL}tempinfos.xml`)

Binary layout: `uint` version + records `[u8 nameLen][name][int len][xml]` (`yishi/manager/TempleteManager.as:1095-1113`).

| list | resource fields |
|---|---|
| `GameHeroTemp` | Job, Sexs, ResPath, ArmPath, ClothPath, Icon |
| `PawnTempInfos` | Swf, Icon, DefaultSkill, HighSkill |
| `MonsterTemplates` | ResPath, ResType, Scale, Offset, Icon |
| `ItemTempInfos` | Avata |
| `MountTempInfos` | AvatarPath (`"path\|wing"`), IsStand |
| `PetTempInfos` | PetAvatar |
| `SkillTempInfos` | ActionId, BufferIds |
| `ActionInfos` | ActionId, ActionType, Frame, Sex, Para |
| `MapInfos` | BattleGround, MapFileId, Width, Height |
| `ChildTempInfos` | ResPath |

## Class name (linkage) patterns

| pattern | used for |
|---|---|
| `asset.{folder}_{file}.S_{f}_{d}` / `.W_{f}_{d}` | `.bswf` frames |
| `ClassExport`, `ClassExport{1..4}` | battle equipment, battle map |
| `slg.resource.movie.MovieAsset{res}` | monsters, pawns, NPCs |
| `slg.resource.BufferEffect{id}` | buffs (defined, never called; see §3) |
| skill linkage name | effects |
| `asset.<module>.<name>` | UI (see [../ui/README.md](../ui/README.md)) |
| `asset.avatar.DefaultAvatarMovieAsset` | avatar placeholder |
| `asset.core.StandShadowAsset` | shadow |
