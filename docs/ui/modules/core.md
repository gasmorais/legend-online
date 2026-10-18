# UI module `core`

Screens defined in the decompiled module `core` (`decompiled/core/scripts`) and the composition tree of
every view class in it that uses styles or symbols. Subviews defined in other modules are described on
their own module page.

Related: [UI composition](../README.md), [screen index](../screens.md), [navigation map](../navigation.md).

## How to read this

Screen table columns:

| Column | Meaning |
|---|---|
| Screen | Fully qualified class name |
| Title (pt-BR) | Resolved title text, or the raw language key; truncated to 50 characters |
| Kind | frame, scene or tip (see [terminology](../README.md#terminology)) |
| Extends | Direct superclass |
| Size | `width×height` of the screen style or of its `backStyle` |
| Styles, Symbols | Resolved style entries and SWF symbols, subviews included |
| Subviews | Display classes reached transitively, up to 4 levels |
| UI SWFs | First four SWF files that provide the symbols |

Composition tree notation:

- **Class** (`module:path`): a view class; the path is relative to `decompiled/<module>/scripts`.
- `` `style` · Class x=… y=… width=… height=… ``: a style entry, the component class it creates and its
  geometry from the XML; `font` shows the `TextFormat` arguments; `← parent` is the `parentStyle` it inherits.
- `` `symbol` · kind W×H N frames labels: … (file.swf) ``: an exported SWF symbol with its size, frame
  count, frame labels and source SWF.
- Nested items are parts of the item above (`backStyle`, `resourceLink` and similar attributes).
- _no style/symbol_: style-like strings in the code that match no style or symbol.
- texts: language keys used by the class and their pt-BR text (first eight).
- subviews: display classes the view instantiates.

## Screens

This module defines no frame, scene or tip.

## View composition

### asset.avatar.DefaultAvatarMovieAsset

- **DefaultAvatarMovieAsset** (`core:asset/avatar/DefaultAvatarMovieAsset.as`)
  - `asset.avatar.DefaultAvatarMovieAsset` · DefaultAvatarMovieAsset 

### asset.battle.BossHpStripAsset

- **BossHpStripAsset** (`core:asset/battle/BossHpStripAsset.as`)
  - `asset.battle.BossHpStripAsset` · BossHpStripAsset 

### asset.battle.BossShowRightAsset

- **BossShowRightAsset** (`core:asset/battle/BossShowRightAsset.as`)
  - `asset.battle.BossShowRightAsset` · BossShowRightAsset 

### asset.battle.LiteBossBloodBar_0

- **LiteBossBloodBar_0** (`core:asset/battle/LiteBossBloodBar_0.as`)
  - `asset.battle.LiteBossBloodBar_0` · LiteBossBloodBar_0 

### asset.battle.LiteBossBloodBar_1

- **LiteBossBloodBar_1** (`core:asset/battle/LiteBossBloodBar_1.as`)
  - `asset.battle.LiteBossBloodBar_1` · LiteBossBloodBar_1 

### asset.battle.WorldBossBloodMC

- **WorldBossBloodMC** (`core:asset/battle/WorldBossBloodMC.as`)
  - `asset.battle.WorldBossBloodMC` · WorldBossBloodMC 

### asset.chatII.Appell1

- **Appell1** (`core:asset/chatII/Appell1.as`)
  - `chatII.Appell1` · Appell1 

### asset.chatII.Appell10

- **Appell10** (`core:asset/chatII/Appell10.as`)
  - `chatII.Appell10` · Appell10 

### asset.chatII.Appell11

- **Appell11** (`core:asset/chatII/Appell11.as`)
  - `chatII.Appell11` · Appell11 

### asset.chatII.Appell12

- **Appell12** (`core:asset/chatII/Appell12.as`)
  - `chatII.Appell12` · Appell12 

### asset.chatII.Appell2

- **Appell2** (`core:asset/chatII/Appell2.as`)
  - `chatII.Appell2` · Appell2 

### asset.chatII.Appell3

- **Appell3** (`core:asset/chatII/Appell3.as`)
  - `chatII.Appell3` · Appell3 

### asset.chatII.Appell4

- **Appell4** (`core:asset/chatII/Appell4.as`)
  - `chatII.Appell4` · Appell4 

### asset.chatII.Appell5

- **Appell5** (`core:asset/chatII/Appell5.as`)
  - `chatII.Appell5` · Appell5 

### asset.chatII.Appell6

- **Appell6** (`core:asset/chatII/Appell6.as`)
  - `chatII.Appell6` · Appell6 

### asset.chatII.Appell7

- **Appell7** (`core:asset/chatII/Appell7.as`)
  - `chatII.Appell7` · Appell7 

### asset.chatII.Appell8

- **Appell8** (`core:asset/chatII/Appell8.as`)
  - `chatII.Appell8` · Appell8 

### asset.chatII.Appell9

- **Appell9** (`core:asset/chatII/Appell9.as`)
  - `chatII.Appell9` · Appell9 

### asset.chatII.AppellQualityEffect

- **AppellQualityEffect** (`core:asset/chatII/AppellQualityEffect.as`)
  - `chatII.AppellQualityEffect` · AppellQualityEffect 

### asset.core.CollectionAsset

- **CollectionAsset** (`core:asset/core/CollectionAsset.as`)
  - `asset.core.CollectionAsset` · CollectionAsset 

### asset.core.CollectionNodeEffectAsset

- **CollectionNodeEffectAsset** (`core:asset/core/CollectionNodeEffectAsset.as`)
  - `asset.core.CollectionNodeEffectAsset` · CollectionNodeEffectAsset 

### asset.core.EnterBattleSwitchMC

- **EnterBattleSwitchMC** (`core:asset/core/EnterBattleSwitchMC.as`)
  - `asset.core.EnterBattleSwitchMC` · EnterBattleSwitchMC 

### asset.core.GetGoodsEffect

- **GetGoodsEffect** (`core:asset/core/GetGoodsEffect.as`)
  - `core.GetGoodsEffect` · GetGoodsEffect 

### asset.core.NoviceArrowGuide

- **NoviceArrowGuide** (`core:asset/core/NoviceArrowGuide.as`)
  - `core.NoviceArrowGuide` · NoviceArrowGuide 

### asset.core.ShowAvatarEffect

- **ShowAvatarEffect** (`core:asset/core/ShowAvatarEffect.as`)
  - `core.ShowAvatarEffect` · ShowAvatarEffect 

### asset.core.TaskRewardButtonMc1

- **TaskRewardButtonMc1** (`core:asset/core/TaskRewardButtonMc1.as`)
  - `asset.core.TaskRewardButtonMc1` · TaskRewardButtonMc1 

### asset.core.TaskRewardButtonMc2

- **TaskRewardButtonMc2** (`core:asset/core/TaskRewardButtonMc2.as`)
  - `asset.core.TaskRewardButtonMc2` · TaskRewardButtonMc2 

### asset.core.TaskRewardButtonMc3

- **TaskRewardButtonMc3** (`core:asset/core/TaskRewardButtonMc3.as`)
  - `task.TaskRewardButtonMc3` · TaskRewardButtonMc3 x=429 y=419

### asset.core.boubleBossHPAsset

- **boubleBossHPAsset** (`core:asset/core/boubleBossHPAsset.as`)
  - `asset.core.boubleBossHPAsset` · boubleBossHPAsset 

### asset.core.cursor.AnxietIconAsset

- **AnxietIconAsset** (`core:asset/core/cursor/AnxietIconAsset.as`)
  - `asset.core.cursor.AnxietIconAsset` · AnxietIconAsset 

### asset.core.cursor.AttackIconAsset

- **AttackIconAsset** (`core:asset/core/cursor/AttackIconAsset.as`)
  - `asset.core.cursor.AttackIconAsset` · AttackIconAsset 

### asset.core.cursor.BonFireIconAsset

- **BonFireIconAsset** (`core:asset/core/cursor/BonFireIconAsset.as`)
  - `asset.core.cursor.BonFireIconAsset` · BonFireIconAsset 

### asset.core.cursor.ClearIconAsset

- **ClearIconAsset** (`core:asset/core/cursor/ClearIconAsset.as`)
  - `asset.core.cursor.ClearIconAsset` · ClearIconAsset 

### asset.core.cursor.CollectIconAsset

- **CollectIconAsset** (`core:asset/core/cursor/CollectIconAsset.as`)
  - `asset.core.cursor.CollectIconAsset` · CollectIconAsset 

### asset.core.cursor.DragIconAsset

- **DragIconAsset** (`core:asset/core/cursor/DragIconAsset.as`)
  - `asset.core.cursor.DragIconAsset` · DragIconAsset 

### asset.core.cursor.HarvestIconAsset

- **HarvestIconAsset** (`core:asset/core/cursor/HarvestIconAsset.as`)
  - `asset.core.cursor.HarvestIconAsset` · HarvestIconAsset 

### asset.core.cursor.HungerAsset

- **HungerAsset** (`core:asset/core/cursor/HungerAsset.as`)
  - `asset.core.cursor.HungerAsset` · HungerAsset 

### asset.core.cursor.IllIconAsset

- **IllIconAsset** (`core:asset/core/cursor/IllIconAsset.as`)
  - `asset.core.cursor.IllIconAsset` · IllIconAsset 

### asset.core.cursor.LockIconAsset

- **LockIconAsset** (`core:asset/core/cursor/LockIconAsset.as`)
  - `asset.core.cursor.LockIconAsset` · LockIconAsset 

### asset.core.cursor.NoWalkIconAsset

- **NoWalkIconAsset** (`core:asset/core/cursor/NoWalkIconAsset.as`)
  - `asset.core.cursor.NoWalkIconAsset` · NoWalkIconAsset 

### asset.core.cursor.PickOverIconAsset

- **PickOverIconAsset** (`core:asset/core/cursor/PickOverIconAsset.as`)
  - `asset.core.cursor.PickOverIconAsset` · PickOverIconAsset 

### asset.core.cursor.RemoveIconDownAsset

- **RemoveIconDownAsset** (`core:asset/core/cursor/RemoveIconDownAsset.as`)
  - `asset.core.cursor.RemoveIconDownAsset` · RemoveIconDownAsset 

### asset.core.cursor.RemoveIconUpAsset

- **RemoveIconUpAsset** (`core:asset/core/cursor/RemoveIconUpAsset.as`)
  - `asset.core.cursor.RemoveIconUpAsset` · RemoveIconUpAsset 

### asset.core.cursor.ReviveIconAsset

- **ReviveIconAsset** (`core:asset/core/cursor/ReviveIconAsset.as`)
  - `asset.core.cursor.ReviveIconAsset` · ReviveIconAsset 

### asset.core.cursor.SeedIconAsset

- **SeedIconAsset** (`core:asset/core/cursor/SeedIconAsset.as`)
  - `asset.core.cursor.SeedIconAsset` · SeedIconAsset 

### asset.core.cursor.SellIconAsset

- **SellIconAsset** (`core:asset/core/cursor/SellIconAsset.as`)
  - `asset.core.cursor.SellIconAsset` · SellIconAsset 

### asset.core.cursor.SpaceNpcAsset

- **SpaceNpcAsset** (`core:asset/core/cursor/SpaceNpcAsset.as`)
  - `asset.core.cursor.SpaceNpcAsset` · SpaceNpcAsset 

### asset.core.cursor.SpacePlayerAsset

- **SpacePlayerAsset** (`core:asset/core/cursor/SpacePlayerAsset.as`)
  - `asset.core.cursor.SpacePlayerAsset` · SpacePlayerAsset 

### asset.core.cursor.SpliteIconAsset

- **SpliteIconAsset** (`core:asset/core/cursor/SpliteIconAsset.as`)
  - `asset.core.cursor.SpliteIconAsset` · SpliteIconAsset 

### asset.core.cursor.WaterIconAsset

- **WaterIconAsset** (`core:asset/core/cursor/WaterIconAsset.as`)
  - `asset.core.cursor.WaterIconAsset` · WaterIconAsset 

### asset.core.cursor.WeedIconAsset

- **WeedIconAsset** (`core:asset/core/cursor/WeedIconAsset.as`)
  - `asset.core.cursor.WeedIconAsset` · WeedIconAsset 

### asset.core.cursor.WormIconAsset

- **WormIconAsset** (`core:asset/core/cursor/WormIconAsset.as`)
  - `asset.core.cursor.WormIconAsset` · WormIconAsset 

### asset.core.goods.Strengthen

- **Strengthen** (`core:asset/core/goods/Strengthen.as`)
  - `asset.core.goods.Strengthen` · Strengthen 

### asset.core.novice.ContinueBtn

- **ContinueBtn** (`core:asset/core/novice/ContinueBtn.as`)
  - `core.novice.ContinueBtnMc` · ContinueBtn 

### asset.core.novice.GlowMc

- **GlowMc** (`core:asset/core/novice/GlowMc.as`)
  - `core.BtnGlowMc` · GlowMc 

### asset.loading.CacheMcAsset

- **CacheMcAsset** (`core:asset/loading/CacheMcAsset.as`)
  - `asset.loading.CacheMcAsset` · CacheMcAsset 

### asset.map.PetQuaityAsset

- **PetQuaityAsset** (`core:asset/map/PetQuaityAsset.as`)
  - `asset.map.PetQuaityAsset` · PetQuaityAsset 

### asset.novice.ToolBtnAppearEffectMC

- **ToolBtnAppearEffectMC** (`core:asset/novice/ToolBtnAppearEffectMC.as`)
  - `core.toolBtnAppearEffectMC` · ToolBtnAppearEffectMC 

