# UI module `Loading`

Screens defined in the decompiled module `Loading` (`decompiled/Loading/scripts`) and the composition tree of
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

### Loading

- **Loading** (`Loading:Loading.as`)
  - `asset.loading.MainLoadingBg` · bitmap 1000×600 (mainloading.swf)
  - subviews: `LoginQueueView`

### loading.MaxLoading

- **MaxLoading** (`Loading:loading/MaxLoading.as`)
  - `asset.loading.SlogoOld` · bitmap 250×185 (mainloading.swf)
  - `asset.loading.SlogoOld` · bitmap 250×185 (mainloading.swf)
  - `asset.loading.SlogoOld` · bitmap 250×185 (mainloading.swf)
  - `asset.loading.MainLoadingAsset` · sprite 2 frames (mainloading.swf)
  - `asset.loading.bgMovie` · sprite 50 frames (mainloading.swf)
  - _no style/symbol_: `notice.NoticeFrame`, `notice.NoticeFrame`, `doctor.DoctorFrame`, `doctor.DoctorFrame`

### loading.MaxLoadingII

- **MaxLoadingII** (`Loading:loading/MaxLoadingII.as`)
  - `asset.loading.MainLoadingAssetII` · sprite (mainloadingii.swf)

### register.HeadComp

- **HeadComp** (`Loading:register/HeadComp.as`)
  - `asset.mainloadingii.register.headBg` · bitmap 90×90 (mainloadingii.swf)
  - `asset.mainloadingii.register.selectedBg` · bitmap 90×90 (mainloadingii.swf)
  - _no style/symbol_: `asset.mainloadingii.register.head`, `asset.mainloadingii.register.lightBg`

### register.MainFigureView

- **MainFigureView** (`Loading:register/MainFigureView.as`)
  - `asset.mainloadingii.register.Back` · bitmap 1400×800 (mainloadingii.swf)
  - `asset.mainloadingii.register.Back01` · bitmap 780×21 (mainloadingii.swf)
  - `asset.mainloadingii.register.Back02` · bitmap 816×60 (mainloadingii.swf)
  - `asset.mainloadingii.register.MainFigureBg` · sprite (mainloadingii.swf)
  - `asset.mainloadingii.register.figureNameBg` · sprite 271.7×29.0 (mainloadingii.swf)
  - _no style/symbol_: `mainloadingii.register.ChooseView.ConfirmBtn`, `mainloadingii.register.ChooseView.HeadComp1`, `mainloadingii.register.ChooseView.HeadComp2`, `mainloadingii.register.ChooseView.HeadComp3`, `mainloadingii.register.ChooseView.HeadComp4`, `mainloadingii.register.ChooseView.HeadComp5`, `mainloadingii.register.ChooseView.HeadComp6`, `mainloadingii.register.ChooseView.commonTipBg`, `mainloadingii.register.ChooseView.commonTipText`, `mainloadingii.register.ChooseView.ShaiziBtn`, `mainloadingii.register.ChooseView.ReNameTxt`, `mainloadingii.register.ChooseView.DescribeTxt`
  - texts: `noviceII.node.AddUserNameFrame.describt01` “Nome do Personagem deve conter de 4~12 caracteres”; `noviceII.node.AddUserNameFrame.describt02` “Nome do Personagem em branco!”; `noviceII.node.AddUserNameFrame.describt03` “Nome do Personagem muito curto!”; `noviceII.node.AddUserNameFrame.describt04` “Nome do Personagem muito longo!”; `noviceII.node.AddUserNameFrame.describt05` “Nome do Personagem contêm caracteres inválidos!”; `noviceII.view.AddUserNameFrame.checkNickErrorEvent2` “Falha ao carregar verificação de apelido”

