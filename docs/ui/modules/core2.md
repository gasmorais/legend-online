# UI module `core2`

Screens defined in the decompiled module `core2` (`decompiled/core2/scripts`) and the composition tree of
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

### asset.core.IconLoading

- **IconLoading** (`core2:asset/core/IconLoading.as`)
  - `homepageTop.Loading` · IconLoading x=385 y=140

### asset.core.loading.LoadingMapAsset.shenqu

- **shenqu** (`core2:asset/core/loading/LoadingMapAsset/shenqu.as`)
  - `core.loading.LoadingMapAsset.shenqu` · shenqu 

### asset.core.loading.LoadingMapAsset.zhanqu

- **zhanqu** (`core2:asset/core/loading/LoadingMapAsset/zhanqu.as`)
  - `core.loading.LoadingMapAsset.zhanqu` · zhanqu 

