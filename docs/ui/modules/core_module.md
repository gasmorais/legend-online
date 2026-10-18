# UI module `core_module`

Screens defined in the decompiled module `core_module` (`decompiled/core_module/scripts`) and the composition tree of
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

| Screen | Title (pt-BR) | Kind | Extends | Size | Styles | Symbols | Subviews | UI SWFs |
|---|---|---|---|---|---:|---:|---:|---|
| `bag.view.ItemSellView` | Itens à Venda | frame | `Frame` | 257×519 | 31 | 20 | 1 | core.swf, core2.swf, resourcesbar.swf |
| `bag.view.MulItemUseFrame` | Usar em massa | frame | `SpliteItemFrame` |  | 16 | 5 | 1 | chat.swf, friends.swf |
| `bag.view.RentalBagAlertFrame` | Mochila Temporária | frame | `Frame` | 345×315 | 16 | 4 | 0 | core2.swf |
| `bag.view.SpliteItemFrame` | Divisão de itens | frame | `Frame` | 308×181 | 6 | 2 | 0 | core.swf |
| `cell.mediator.marketbag.MarketSellAlertFrame` | Vender | frame | `Frame` | 375×250 | 11 | 7 | 0 | bottle.swf, campaign.swf, core2.swf |
| `dialog.view.SplitePointFrame` | Oferta de diamantes | frame | `Frame` |  | 5 | 2 | 0 | core.swf |
| `feedback.FeedBackFrame` | Feedback de Pacote de Recarga | frame | `Frame` | 775×507 | 43 | 48 | 3 | common.swf, core.swf, core2.swf, feedback.swf |
| `funny.view.FunnyFrame` |  | frame | `Frame` | 765×543 | 484 | 287 | 31 | bottle.swf, campaign.swf, common.swf, core.swf |
| `funny.view.FunnyMutiFrame` | X-Troca | frame | `Frame` |  | 6 | 2 | 0 | core.swf |
| `funny.view.TiroFunnyFrame` | Surpresas durante o Evento de Abertura do Servidor | frame | `Frame` | 772×619 | 57 | 36 | 5 | common.swf, core.swf, core2.swf, exchargeall.swf |
| `mainBar.vicePassword.ChangeVPView` | Alterar Senha | frame | `Frame` | 314×386 | 28 | 8 | 2 | campaign.swf, core2.swf, friends.swf, vicepassword.swf |
| `mainBar.vicePassword.ConfirmVPView` | Inserir Senha | frame | `Frame` | 292×179 | 10 | 13 | 0 | core2.swf, framebg.swf, vicepassword.swf |
| `mainBar.vicePassword.SetVPView` | Senha | frame | `Frame` | 314×386 | 47 | 30 | 2 | campaign.swf, common.swf, core.swf, core2.swf |
| `mainBar.view.ChoosePayTypeFrame` |  | frame | `Frame` | 364×215 | 7 | 0 | 0 |  |
| `mainBar.view.IndulgeFrame` | Autenticação dos nomes | frame | `Frame` | 533×366 | 24 | 4 | 0 | core2.swf, resourcesbar.swf |
| `mainBar.view.IndulgeInfoFrame` | Alerta de mensagem anti-vício | frame | `Frame` | 442×205 | 36 | 8 | 1 | core2.swf, resourcesbar.swf |
| `mainBar.view.VipCoolDownFrame` |  | frame | `Frame` | 310×195 | 12 | 1 | 0 | resourcesbar.swf |
| `map.campaign.view.frame.ArmyManageFrame` | Gerenciamento da Equipe | frame | `Frame` | 478×281 | 39 | 10 | 2 | core.swf, core2.swf |
| `map.campaign.view.frame.MazeFallItemsFrame` | Item Recebido | frame | `Frame` | 345×330 | 28 | 20 | 1 | common.swf, core.swf, core2.swf |
| `map.campaign.view.frame.PVPArmyManageFrame` | Gerenciamento da Equipe | frame | `Frame` | 489×273 | 103 | 51 | 6 | common.swf, core.swf, core2.swf, framebg.swf |
| `monopoly.view.MonopolyAlertFrame` | monopoly.view.MonopolyAlertFrame.TitleTxt | frame | `Frame` | 464×246 | 22 | 19 | 1 | core.swf, core2.swf, framebg.swf, monopoly.swf |
| `monopoly.view.MonopolyBattleFailureFrame` | Batalha perdida | frame | `Frame` | 280×180 | 11 | 14 | 0 | core2.swf, framebg.swf, monopoly.swf |
| `monopoly.view.MonopolyDiceMagicFrame` | Escolher os pontos necessários | frame | `Frame` | 600×210 | 14 | 8 | 0 | monopoly.swf |
| `monopoly.view.MonopolyFinishRewardFrame` |  | frame | `Frame` | 371×235 | 17 | 19 | 4 | core.swf, core2.swf, monopoly.swf |
| `monopoly.view.MonopolyFriendAssistFrame` | Pedir Assistência | frame | `Frame` | 459×425 | 78 | 33 | 2 | core.swf, core2.swf, framebg.swf, monopoly.swf |
| `monopoly.view.MonopolyGameOverFrame` | Aventura terminada | frame | `Frame` | 431×338 | 26 | 21 | 0 | core2.swf, framebg.swf, monopoly.swf |
| `monopoly.view.MonopolyPetFormationFrame` | Ajustar Formação | frame | `Frame` | 650×470 | 44 | 20 | 6 | core2.swf, framebg.swf, monopoly.swf |
| `simplegame.christmasroses.SnowRosePresentView` | Presentear | frame | `Frame` | 314×228 | 12 | 4 | 0 | friends.swf |
| `simplegame.hamster.HamsterGameFrame` |  | frame | `Frame` |  | 8 | 3 | 1 | core2.swf, hamster.swf |
| `simplegame.handlsel.HandlselFrame` | Presentear | frame | `Frame` | 372×174 | 177 | 132 | 10 | bottle.swf, chat.swf, common.swf, core.swf |
| `simplegame.roses.IMQuickRosePresentView` | Presentear | frame | `Frame` | 344×160 | 11 | 6 | 0 | core2.swf, friends.swf |
| `simplegame.roses.RosePresentBackNewView` | Presentear de volta | frame | `Frame` | 350×? | 189 | 149 | 8 | bottle.swf, chat.swf, common.swf, core.swf |
| `simplegame.roses.RosePresentBackView` | Presentear de volta | frame | `Frame` | 345×? | 183 | 147 | 8 | bottle.swf, chat.swf, common.swf, core.swf |
| `simplegame.roses.RosePresentView` | Presentear | frame | `Frame` | 314×228 | 14 | 5 | 0 | chat.swf, friends.swf |
| `svs.view.SvsFrame` |  | frame | `Frame` | 1000×600 | 62 | 33 | 2 | campaign.swf, friends.swf, svsmap.swf |
| `svs.view.ranklists.SvsRankListFrame` | Templo Sagrado Batalha do Caos | frame | `Frame` | 450×495 | 29 | 22 | 1 | core.swf, core2.swf, snowball.swf, svsmap.swf |
| `svs.view.warteam.SvsEnterWarAddFrame` | Lista de Participantes | frame | `Frame` | 925×478 | 518 | 286 | 8 | campaign.swf, core.swf, core2.swf, friends.swf |
| `svs.view.warteam.SvsEnterWarFrame` | Lista de Participantes | frame | `Frame` | 536×530 | 453 | 257 | 4 | core.swf, core2.swf, maintoolbar.swf, steelmap.swf |
| `ui.resourcebar.view.quickbuy.QuickBuyFrame` | Compra rápida | frame | `Frame` | 249×393 | 28 | 23 | 2 | common.swf, core.swf, core2.swf, resourcesbar.swf |
| `ui.tasktracebar.view.ChildRemoveAlert` | Abandonar Guardião | frame | `Frame` | 300×280 | 23 | 14 | 0 | core2.swf, framebg.swf, tasktracebar.swf |
| `ui.tasktracebar.view.TransferAnimationView` |  | frame | `Frame` |  | 3 | 0 | 0 |  |
| `yishi.view.base.BaseHelpFrame` |  | frame | `Frame` |  | 9 | 4 | 0 | campaign.swf, friends.swf |
| `yishi.view.base.BaseInputFrame` | Campo de entrada | frame | `Frame` | 283×228 | 10 | 0 | 0 |  |
| `yishi.view.base.ViewBaseFrame` |  | frame | `Frame` |  | 0 | 0 | 0 |  |
| `yishi.view.community.CrossBugleFrame` | Megafone inter-servidor | frame | `Frame` | 347×202 | 10 | 5 | 0 | core.swf |
| `yishi.view.frame.ApplyFriendFrame` | Pedido de adição | frame | `Frame` | 375×225 | 16 | 0 | 0 |  |
| `yishi.view.frame.ArtifactBuyFrame` |  | frame | `BuyFrameI` |  | 70 | 24 | 4 | chat.swf, core2.swf, invite.swf, quickbuy.swf |
| `yishi.view.frame.AttackCastleAlertFrame` | Aviso | frame | `Frame` |  | 9 | 2 | 0 | core2.swf |
| `yishi.view.frame.BingoBuyFrame` | Comprar | frame | `Frame` |  | 39 | 56 | 0 | bottle.swf, common.swf, core.swf, core2.swf |
| `yishi.view.frame.BuyFrameI` | Comprar | frame | `Frame` |  | 148 | 121 | 7 | bottle.swf, chat.swf, common.swf, core.swf |
| `yishi.view.frame.CacheTipFrame` |  | frame | `Frame` |  | 2 | 0 | 1 |  |
| `yishi.view.frame.CasernRecruitFrame` | Recrutar | frame | `Frame` | 397×299 | 29 | 20 | 1 | core.swf, core2.swf, framebg.swf, resourcesbar.swf |
| `yishi.view.frame.ChangeHeadIconFrame` | Selecionar Retrato | frame | `Frame` | 490×390 | 26 | 7 | 1 | core.swf, core2.swf |
| `yishi.view.frame.ChatInvieAlert` |  | frame | `SimpleAlert` | 229×17 | 18 | 15 | 0 | core2.swf, framebg.swf |
| `yishi.view.frame.ChildSexFrame` | Aviso | frame | `Frame` | 385×185 | 15 | 13 | 0 | core2.swf, framebg.swf |
| `yishi.view.frame.ConfirmSellFrame` | Aviso | frame | `Frame` | 340×196 | 13 | 14 | 0 | core.swf, core2.swf, framebg.swf |
| `yishi.view.frame.ConsortiaEmeDreamRewardFrame` | Prêmios da Terra dos Sonhos | frame | `Frame` | 355×285 | 32 | 34 | 1 | common.swf, core.swf, core2.swf |
| `yishi.view.frame.FurnitureShopBuyFrame` | Comprar | frame | `Frame` | 271×330 | 47 | 40 | 1 | campaign.swf, core.swf, core2.swf, framebg.swf |
| `yishi.view.frame.HookRewardFrame` |  | frame | `Frame` | 304×345 | 15 | 3 | 0 | core.swf, core2.swf |
| `yishi.view.frame.InviteFrame` |  | frame | `Frame` | 330×120 | 53 | 28 | 2 | core.swf, core2.swf, framebg.swf |
| `yishi.view.frame.LookFrame` | Visualizar | frame | `Frame` | 408×428 | 10 | 18 | 5 | core.swf, core2.swf, framebg.swf, playerbg.swf |
| `yishi.view.frame.MultiFailedAlertFrame` |  | frame | `Frame` |  | 0 | 0 | 0 |  |
| `yishi.view.frame.NavigationInviteAssistFrame` |  | frame | `Frame` | 330×120 | 19 | 4 | 1 | core.swf, core2.swf |
| `yishi.view.frame.NumBuyFrame` | Trocar | frame | `Frame` | 271×291 | 45 | 58 | 3 | common.swf, core.swf, core2.swf, framebg.swf |
| `yishi.view.frame.PetChallengeReportFrame` |  | frame | `Frame` |  | 19 | 9 | 0 | petchallenge.swf |
| `yishi.view.frame.PvpHeroFrame` | Ranking Inter-Servidores | frame | `Frame` | 570×488 | 48 | 28 | 2 | campaign.swf, chesspvp.swf, core.swf, core2.swf |
| `yishi.view.frame.RaceAgainstTimeFrame` | Coleta de Prêmio | frame | `Frame` | 385×446 | 23 | 24 | 1 | common.swf, core.swf, core2.swf, room.swf |
| `yishi.view.frame.ShopLimiteTimeDiscountBuyFrame` |  | frame | `BuyFrameI` |  | 1 | 0 | 0 |  |
| `yishi.view.frame.ShopMainBuyFrame` |  | frame | `BuyFrameI` |  | 70 | 24 | 4 | chat.swf, core2.swf, invite.swf, quickbuy.swf |
| `yishi.view.frame.SimpleHelpFrame` | Ajuda | frame | `Frame` |  | 10 | 4 | 0 | campaign.swf, friends.swf |
| `yishi.view.frame.TimeOutInviteFrame` |  | frame | `Frame` | 330×120 | 22 | 6 | 1 | core.swf, core2.swf |
| `yishi.view.frame.TodayNotAlertFrame` | Aviso | frame | `Frame` | 430×190 | 17 | 10 | 0 | framebg.swf |
| `yishi.view.frame.UpdateBroadCastFrame` | Anúncio de Atualização | frame | `Frame` | 651×560 | 19 | 8 | 0 | mainloading.swf, maintoolbar.swf |
| `yishi.view.frame.UseBindPointAlert` |  | frame | `SimpleAlert` | 229×17 | 20 | 14 | 0 | core2.swf, framebg.swf |
| `yishi.view.frame.UseBindPointWithChoiceAutoLayoutAlert` |  | frame | `SimpleAlert` | 229×17 | 25 | 16 | 0 | core2.swf, framebg.swf |
| `yishi.view.frame.WishPoolShopBuyFrame` | Comprar | frame | `Frame` | 271×330 | 48 | 46 | 1 | common.swf, core.swf, core2.swf, framebg.swf |
| `yishi.view.frame.WithChoiceAlert` |  | frame | `SimpleAlert` |  | 0 | 0 | 0 |  |
| `yishi.view.frame.giftdonatio.GiftDonatioFrame` |  | frame | `Frame` | 385×196 | 68 | 24 | 3 | chat.swf, core2.swf, invite.swf, quickbuy.swf |
| `yishi.view.frame.planeswar.PlanesResourceFrame` | Informação de Planos de mina | frame | `Frame` | 500×515 | 38 | 28 | 2 | common.swf, core.swf, core2.swf |
| `yishi.view.frame.pvpleague.PVPLeagueRankListFrame` | Ranking da Aliança | frame | `Frame` | 575×590 | 69 | 34 | 2 | campaign.swf, core2.swf, friends.swf, sort.swf |
| `yishi.view.guild.QteUpgradeTipFrame` | Aviso | frame | `Frame` | 250×180 | 16 | 10 | 0 | framebg.swf |
| `yishi.view.newGuildHelp.NewGuildFrame` |  | frame | `Frame` | 835×610 | 12 | 10 | 2 | core2.swf |
| `mvc.controler.ApexRoomController` |  | scene | `BaseSceneView` |  | 511 | 274 | 14 | apexroom.swf, baseroom.swf, core.swf, core2.swf |
| `mvc.controler.AresLordsRoomController` |  | scene | `BaseSceneView` |  | 495 | 278 | 13 | areslordsroom.swf, baseroom.swf, core2.swf, maintoolbar.swf |
| `mvc.controler.GloryGameRoomController` |  | scene | `BaseSceneView` |  | 443 | 251 | 8 | baseroom.swf, core2.swf, glorygameroom.swf, maintoolbar.swf |
| `mvc.controler.MatelordsRoomController` |  | scene | `BaseSceneView` |  | 466 | 263 | 10 | baseroom.swf, core2.swf, maintoolbar.swf, matelordsroom.swf |
| `mvc.controler.MultilordsRoomController` |  | scene | `BaseSceneView` |  | 1 | 0 | 0 |  |
| `mvc.controler.PvpRoomControl` |  | scene | `BaseSceneView` |  | 577 | 339 | 14 | baseroom.swf, common.swf, core.swf, core2.swf |
| `mvc.controler.RoomControl` |  | scene | `BaseSceneView` |  | 738 | 435 | 23 | baseroom.swf, common.swf, core.swf, core2.swf |
| `mvc.controler.UnrealShootingRoomController` |  | scene | `BaseSceneView` |  | 59 | 19 | 11 | campaign.swf, core2.swf, friends.swf, unrealshootingroom.swf |
| `yishi.scene.EmptyScene` |  | scene | `BaseSceneView` |  | 0 | 0 | 0 |  |
| `battle.view.buffer.BufferListItemTip` |  | tip | `BaseTip` |  | 21 | 5 | 1 | army.swf, core2.swf, tips.swf |
| `battle.view.ui.attackmode.AttackModeBtnTip` |  | tip | `BaseTip` |  | 4 | 0 | 0 |  |
| `yishi.view.tips.ConsortiaNewBossBufferTip` |  | tip | `BaseTip` |  | 13 | 1 | 1 | army.swf |
| `yishi.view.tips.ConsortiaNewBossDamageRewardTip` |  | tip | `BaseTip` |  | 35 | 27 | 2 | common.swf, core.swf, core2.swf |
| `yishi.view.tips.IMButtonTip` |  | tip | `BaseTip` |  | 2 | 0 | 0 |  |
| `yishi.view.tips.OneLineTip` |  | tip | `BaseTip` |  | 3 | 0 | 0 |  |
| `yishi.view.tips.StokesOreGoodsShowTip` |  | tip | `BaseTip` |  | 26 | 27 | 2 | common.swf, core.swf, core2.swf |
| `yishi.view.tips.SumCampaignTip` |  | tip | `BaseTip` |  | 31 | 27 | 2 | common.swf, core.swf, core2.swf |
| `yishi.view.tips.TaskTraceTip` |  | tip | `BaseTip` |  | 52 | 27 | 2 | common.swf, core.swf, core2.swf |
| `yishi.view.tips.TimeBoxTip` |  | tip | `BaseTip` |  | 23 | 21 | 2 | common.swf, core.swf, core2.swf |
| `yishi.view.tips.goods.ArtifactEquipTip` |  | tip | `BaseTip` |  | 48 | 44 | 3 | army.swf, common.swf, core.swf, core2.swf |
| `yishi.view.tips.goods.ChatEquipTips` |  | tip | `EquipTip` |  | 1 | 1 | 0 | core2.swf |
| `yishi.view.tips.goods.ChatFashionTips` |  | tip | `FashionCardTip` |  | 1 | 1 | 0 | core2.swf |
| `yishi.view.tips.goods.ChatMonsterAccesoriesTips` |  | tip | `MonsterAccessoriesTips` |  | 1 | 1 | 0 | core2.swf |
| `yishi.view.tips.goods.ChatStarTip` |  | tip | `StarTip` |  | 3 | 3 | 1 | core2.swf |
| `yishi.view.tips.goods.EquipTip` |  | tip | `BaseTip` |  | 130 | 94 | 8 | army.swf, core.swf, core2.swf, theseussoul.swf |
| `yishi.view.tips.goods.FashionCardTip` |  | tip | `BaseTip` |  | 138 | 94 | 13 | army.swf, core.swf, core2.swf, theseussoul.swf |
| `yishi.view.tips.goods.FashionComposeTip` |  | tip | `BaseTip` |  | 18 | 14 | 2 | army.swf, core2.swf, theseussoul.swf, tips.swf |
| `yishi.view.tips.goods.GroupbuyCheckTips` |  | tip | `BaseTip` |  | 3 | 0 | 0 |  |
| `yishi.view.tips.goods.MagicCardTip` |  | tip | `BaseTip` |  | 40 | 55 | 1 | army.swf, core2.swf, tips.swf |
| `yishi.view.tips.goods.MonsterAccessoriesTips` |  | tip | `EquipTip` |  | 48 | 14 | 3 | army.swf, core2.swf, tips.swf |
| `yishi.view.tips.goods.MonsterTips` |  | tip | `BaseTip` |  | 32 | 21 | 2 | army.swf, core2.swf, theseussoul.swf, tips.swf |
| `yishi.view.tips.goods.MountCardTip` |  | tip | `BaseTip` |  | 60 | 62 | 2 | army.swf, core.swf, core2.swf, theseussoul.swf |
| `yishi.view.tips.goods.PropTips` |  | tip | `BaseTip` |  | 44 | 74 | 1 | army.swf, core2.swf, tips.swf |
| `yishi.view.tips.goods.QuizRewordTips` |  | tip | `BaseTip` |  | 12 | 1 | 0 | army.swf |
| `yishi.view.tips.goods.RuneTip` |  | tip | `BaseTip` |  | 39 | 55 | 1 | army.swf, core2.swf, tips.swf |
| `yishi.view.tips.goods.StarTip` |  | tip | `BaseTip` |  | 23 | 1 | 1 | theseussoul.swf |
| `yishi.view.tips.goods.SwitchVipPrivilegeTip` |  | tip | `BaseTip` |  | 8 | 0 | 0 |  |
| `yishi.view.tips.goods.TaskItemTips` |  | tip | `BaseTip` |  | 36 | 4 | 1 | army.swf, core2.swf |
| `yishi.view.tips.goods.TheseusEquipTip` |  | tip | `BaseTip` |  | 52 | 68 | 2 | army.swf, core2.swf, theseussoul.swf, tips.swf |
| `yishi.view.tips.goods.TmpTips` |  | tip | `BaseTip` |  | 3 | 0 | 0 |  |
| `yishi.view.tips.goods.TreaBaseEquipTip` |  | tip | `BaseTip` |  | 40 | 65 | 2 | army.swf, core2.swf, theseussoul.swf, tips.swf |
| `yishi.view.tips.goods.TreasureTip` |  | tip | `BaseTip` |  | 77 | 81 | 4 | army.swf, core.swf, core2.swf, theseussoul.swf |

## View composition

### avatar.view.AppellView

- **AppellView** (`core_module:avatar/view/AppellView.as`)
  - `appell.apellTitleText` · GradientText x=123 y=1 width=260 height=38
    - `appell.apellTitle` · FilterFrameText width=260 height=38 font `Arial,16,0xfcf2c6,true,,,,,center`

### avatar.view.Avatar

- **Avatar** (`core_module:avatar/view/Avatar.as`)
  - `asset.core.StandShadowAsset` · bitmap 
    - `asset.core.StandShadowAsset` · bitmap 89×64 (core.swf)
  - `asset.core.MountStandShadowAsset` · bitmap 
    - `asset.core.MountStandShadowAsset` · bitmap 181×65 (core.swf)

### avatar.view.RapidView

- **RapidView** (`core_module:avatar/view/RapidView.as`)
  - `RapidView.colorTxt` · FilterFrameText x=60 y=25 width=60 height=40 font `宋体,14,0xffe400,true,,,,,left`

### avatar.view.ShowAvatar

- **ShowAvatar** (`core_module:avatar/view/ShowAvatar.as`)
  - `colosseum.ShowAvatar` · ShowAvatar x=0 y=0
  - subviews: `ShowAvatarLoader`, `ShowPetAvatar`, `ShowWeaponAvatar`

### avatar.view.ShowWeaponAvatar

- **ShowWeaponAvatar** (`core_module:avatar/view/ShowWeaponAvatar.as`)
  - `core.ShowAvatarEffect` · ShowAvatarEffect 
  - subviews: `ShowAvatarEffect`

### bag.view.BaseBagListView

- **BaseBagListView** (`core_module:bag/view/BaseBagListView.as`)
  - `core.SimpleTileList` · SimpleTileList 
  - _no style/symbol_: `bag.BaseItemView`

### bag.view.EquipBagII

- **EquipBagII** (`core_module:bag/view/EquipBagII.as`)
  - `army.HeroBagItemView` · PlayerBagCell 
    - `core.FashionLevel` · ScaleFrameImage 
      - `asset.core.fashionLevelNormal` · bitmap 21×21 (core.swf)
      - `asset.core.fashionLevelSpecial` · bitmap 21×21 (core.swf)
    - `core.EquipActiveBack` · MovieImage x=-4 y=-4 width=53 height=52
      - `asset.core.EquipActiveBack` · sprite 44 frames (core.swf)
    - `core.ItemBack` · ScaleBitmapImage x=1 y=1 width=45 height=45 ← `core.goods.ItemBack`
    - `core.BaseItemViewIcon` · BaseIconView x=1 y=1
      - `asset.core.IconLoading` · sprite 42 frames (core2.swf)
    - `core.BaseItemText` · FilterFrameText x=0 y=26 width=45 height=18 font `Arial,12,0xffffff,true,,,,,right`
    - `core.GoodsProfileBG` · ScaleFrameImage 
      - `asset.core.BagProfileGreen` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileBlue` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfilePurple` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileOrange` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileRed` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileBlackKing` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileFashion` · bitmap 45×45 (core.swf)
    - `core.BagCellLock` · ScaleFrameImage 
      - `asset.core.BagCellLock` · bitmap 45×45 (core.swf)
      - `asset.core.BagCellUnLock` · bitmap 45×45 (core.swf)
    - `core.goods.Strengthen` · MovieImage x=-50 y=-50
      - `asset.core.goods.Strengthen` · Strengthen 
  - subviews: `RentalBagStateView`, `StoreBagStateView`, `PlayerBagCell`

### bag.view.EquipBagSortList

- **EquipBagSortList** (`core_module:bag/view/EquipBagSortList.as`)
  - `core.commonTipBg` · ScaleBitmapImage width=435
    - `asset.core.describeBackground_style07` · bitmap 260×82 (core2.swf)
  - `army.PanelFashionSelectBtn` · TextButton x=7 y=10 width=95 height=16
    - `army.PanelFashionSelectBtnBack` · ScaleFrameImage 
      - `asset.chatII.PanelSelectedUpBack` · sprite 86.95×16.95 (chat.swf)
      - `asset.chatII.PanelSelectedBack` · bitmap 87×17 (chat.swf)
      - `asset.chatII.PanelSelectedBack` · bitmap 87×17 (chat.swf)
      - `asset.chatII.PanelSelectedBack` · bitmap 87×17 (chat.swf)
    - `army.FashionTxt` · FilterFrameText x=88 y=9 width=70 height=18 font `Arial,12,0xecdfa1,,,,,,left`
  - `army.PanelPropSelectBtn` · TextButton y=30 ← `army.PanelFashionSelectBtn`
  - `army.PanelEquipSelectBtn` · TextButton y=50 ← `army.PanelFashionSelectBtn`
  - `army.PanelJewelSelectBtn` · TextButton y=70 ← `army.PanelFashionSelectBtn`
  - texts: `bag.view.EquipBagSortList.Fashion` “Moda”; `bag.view.EquipBagSortList.Prop` “Acessório”; `bag.view.EquipBagSortList.Equip` “Equipamento”; `bag.view.EquipBagSortList.Jewel` “Gema”

### bag.view.GeneralBag

- **GeneralBag** (`core_module:bag/view/GeneralBag.as`)
  - `consortia.ConsortiaBagCell` · ConsortiaBagCell 
    - `consortia.ConsortiaBagCellBack` · ScaleBitmapImage width=45 height=45 ← `core.goods.ItemBack`
    - `consortia.ConsortiaBagCellIcon` · BaseIconView x=1 y=1
      - `asset.core.IconLoading` · sprite 42 frames (core2.swf)
    - `core.BaseItemText` · FilterFrameText x=0 y=26 width=45 height=18 font `Arial,12,0xffffff,true,,,,,right`
    - `consortia.ProfileBG` · ScaleFrameImage  ← `core.GoodsProfileBG`
    - `core.FashionLevel` · ScaleFrameImage 
      - `asset.core.fashionLevelNormal` · bitmap 21×21 (core.swf)
      - `asset.core.fashionLevelSpecial` · bitmap 21×21 (core.swf)
    - `consortia.BagCellLock` · ScaleFrameImage 
      - `asset.core.BagCellLock` · bitmap 45×45 (core.swf)
      - `asset.core.BagCellUnLock` · bitmap 45×45 (core.swf)
    - `core.goods.Strengthen` · MovieImage x=-50 y=-50
      - `asset.core.goods.Strengthen` · Strengthen 
    - `core.EquipActiveBack` · MovieImage x=-4 y=-4 width=53 height=52
      - `asset.core.EquipActiveBack` · sprite 44 frames (core.swf)
  - subviews: `ConsortiaBagCell`

### bag.view.ItemSellView

- **ItemSellView**: “Itens à Venda” (`core_module:bag/view/ItemSellView.as`)
  - `army.ItemSellView` · ItemSellView x=765 y=38 width=257 height=519 ← `core.Frame2`
  - `army.itemSellView.bg1` · ScaleBitmapImage x=0 y=0 width=240 height=353 ← `core.describeBackground_style04`
  - `army.itemSellView.titleBg` · ScaleLeftRightImage x=2 y=2 width=236 height=35
    - `asset.core.titleBg1` · bitmap 94×35 (core.swf)
    - `asset.core.titleBg2` · bitmap 11×35 (core.swf)
    - `asset.core.titleBg3` · bitmap 94×35 (core.swf)
  - `army.itemSellView.priceImage` · MutipleImage x=0 y=361
    - `asset.core.priceBack` · bitmap 120×27 (core.swf)
    - `itemSellView.priceBack` · Image 
      - `asset.core.priceBack` · bitmap 120×27 (core.swf)
    - `asset.core.totalImage` · bitmap 117×22 (core.swf)
    - `asset.resourcesBar.GoldIcoImg` · bitmap 
      - `asset.resourcesBar.GoldIcoImg` · bitmap 26×29 (resourcesbar.swf)
  - `army.itemSellView.sellBtn` · IconButton x=14 y=392
    - `asset.core.offerQuickBtn` · bitmap 96×40 (core2.swf)
    - `asset.core.sellIcon` · bitmap 66×18 (core.swf)
  - `army.itemSellView.cancelBtn` · IconButton x=128 y=392
    - `asset.core.AlertBtnStyle_01` · bitmap 96×40 (core2.swf)
    - `asset.core.CancelTxtAsset_01` · bitmap 75×18 (core2.swf)
  - `army.itemSellView.name` · FilterFrameText x=16 y=11 width=220 height=20 font `Arial,14,0xe7c88b,true,,,,,left`
  - `army.itemSellView.number` · FilterFrameText x=85 y=12 width=100 height=20 font `Arial,14,0xe7c88b,true,,,,,left`
  - `army.itemSellView.delete` · FilterFrameText x=170 y=12 width=35 height=20 font `Arial,14,0xe7c88b,true,,,,,left`
  - `army.itemSellView.totalPrice` · FilterFrameText x=143 y=366 width=85 height=20 font `Arial,14,0xebc351,true,,,,,left`
  - `army.itemSellView.panel` · ScrollPanel x=2 y=37 width=232 height=312
    - `core.VScrollbar02` · Scrollbar width=21 height=200
      - `core.Scrollbar02_Back` · ScaleBitmapImage width=15 height=24
        - `asset.core.scrollbar02_bg` · bitmap 15×24 (core2.swf)
      - `core.Scrollbar02_Step` · BaseButton width=21 height=56
        - `core.scrollbar02_stepAsset` · ScaleBitmapImage width=21 height=56
          - `asset.core.scrollbar02_step` · bitmap 21×56 (core2.swf)
      - `core.Scrollbar02_Up` · BaseButton width=11 height=10
        - `asset.core.scrollbar02_up` · bitmap 11×10 (core2.swf)
      - `core.Scrollbar02_Down` · BaseButton width=11 height=10
        - `asset.core.scrollbar02_down` · bitmap 11×10 (core2.swf)
  - `army.itemSellView.vBox` · VBox x=0 y=0
  - texts: `armyII.viewII.ItemSellView.titleText` “Itens à Venda”; `armyII.viewII.ItemSellView.nameText` “Nome”; `armyII.viewII.ItemSellView.numberText` “Quantidade”; `armyII.viewII.ItemSellView.deleteText` “Cancelar”; `army.itemSellView.sell.overMaxAlert` “Itens para vender ultrapassaram o limite de ouro, não é poss”; `mainBar.view.GoldOvertopView.goldOvertop` “Capacidade máxima de ouro atingida!”; `public.confirm` “Confirmar”; `public.cancel` “Cancelar”
  - subviews: `SellItem`

### bag.view.MulItemUseFrame

- **MulItemUseFrame**: “Usar em massa” (`core_module:bag/view/MulItemUseFrame.as`)
  - `core.MulItemUseFrame` · MulItemUseFrame  ← `core.SpliteItemFrame`
  - `friends.RosePresentView` · RosePresentView width=314 height=228 ← `core.ConfirmSellFrame`
  - texts: `bag.view.MulItemUseFrame.command01` “Usar em massa”; `mopup.MopupManager.mopupTipData01` “Modo Bot em andamento”; `campaign.Goods.AddNum.isOpen` “A Campanha atual não está aberta, este item não pode ser usa”; `cell.mediator.playerbag.PlayerBagCellClickMediator.command08` “Itens insuficientes para abrir o Baú, não poderá abrir”; `bag.view.MulItemUseFrame.command02` “Você possui efeito mais forte, não é possível substituir”; `child.handin.ChildHandInFrame.noThisChild` “Este guardião não existe”; `public.confirm` “Confirmar”; `public.cancel` “Cancelar”
  - subviews: `RosePresentView`

### bag.view.RentalBagAlertFrame

- **RentalBagAlertFrame**: “Mochila Temporária” (`core_module:bag/view/RentalBagAlertFrame.as`)
  - `bag.view.RentalBagAlertFrame` · RentalBagAlertFrame width=345 height=315 ← `core.Frame2`
  - `RentalBagAlertFrame.contentText` · FilterFrameText x=10 y=10 width=305 height=60 font `Arial,14,0xFFefbd,,,,,,center`
  - `RentalBagAlertFrame.dayBtn1` · SelectedIconTextButton x=50 y=60 width=150 height=23
    - `asset.core.checkstyle_1.Selected` · bitmap 22×22 (core2.swf)
    - `asset.core.checkstyle_1.UnSelected` · bitmap 22×22 (core2.swf)
    - `RentalBagAlertFrame.dayBtn.Text` · FilterFrameText x=23 y=3 width=120 height=22 font `Arial,14,0xfde87f,,,,,,left`
  - `RentalBagAlertFrame.dayBtn2` · SelectedIconTextButton x=50 y=90 width=150 height=23 ← `RentalBagAlertFrame.dayBtn1`
  - `RentalBagAlertFrame.dayBtn3` · SelectedIconTextButton x=50 y=120 width=150 height=23 ← `RentalBagAlertFrame.dayBtn1`
  - `RentalBagAlertFrame.useBindBtn` · SelectedCheckButton x=50 y=155
    - `asset.core.checkstyle_2.UnSelected_1` · Image 
      - `asset.core.checkstyle_2.UnSelected` · bitmap 22×23 (core2.swf)
    - `asset.core.checkstyle_2.Selected_1` · Image 
      - `asset.core.checkstyle_2.Selected` · sprite (core2.swf)
    - `core.ThewCheckTxt_2` · FilterFrameText  font `Arial,12,0xe7c88b,,,,,,center`
  - `RentalBagAlertFrame.alertText` · FilterFrameText x=50 y=185 font `Arial,12,0xff0000,,,,,,left`
  - `RentalBagAlertFrame.ConfirmBtn` · TextButton x=105 y=205 ← `core.ConfirmBtn`
  - texts: `RentalBagAlertFrame.dayBtn.text` “{0} dia(s) ({1} diamantes)”; `public.confirm` “Confirmar”; `mainBar.view.VipCoolDownFrame.promptTxt` “(Não participa no evento de consumo)”; `mainBar.view.VipCoolDownFrame.useBind` “Diamante vinculado prioritário”; `bag.view.RentalBagAlertFrame.titleText` “Mochila Temporária”

### bag.view.RentalBagStateView

- **RentalBagStateView** (`core_module:bag/view/RentalBagStateView.as`)
  - `asset.core.RentalBagLock` · bitmap x=1 y=0
    - `asset.core.RentalBagLock` · bitmap 319×321 (core.swf)
  - `asset.core.RentalBagStateBg` · bitmap x=-3 y=322
    - `asset.core.RentalBagStateBg` · bitmap 330×48 (core.swf)
  - `asset.core.RentalBagOverdueTip` · bitmap x=90 y=340
    - `asset.core.RentalBagOverdueTip` · bitmap 65×14 (core.swf)
  - `core.RentalBagOverdueTxt` · FilterFrameText x=160 y=339 width=100 height=20 font `Arial,12,0xef9c00,true`
  - `core.RentalBagOpenBtn` · IconButton x=107 y=327
    - `asset.core.RentalBagOpenBtnBg` · bitmap 116×42 (core.swf)
    - `asset.core.RentalBagOpenBtnTxt` · bitmap 78×23 (core.swf)
  - `core.RentalBagContinueBtn` · IconButton x=230 y=333
    - `asset.core.PlayerBagContinueBg` · bitmap 80×30 (core.swf)
    - `asset.core.PlayerBagContinueTxt` · bitmap 72×18 (core.swf)
  - `bag.view.RentalBagAlertFrame` · RentalBagAlertFrame width=345 height=315 ← `core.Frame2`
  - texts: `bag.view.RentalBagStateView.OpenBtn.TipData01` “Por favor desbloqueie os 3 primeiros compartimentos da Mochi”
  - subviews: `RentalBagAlertFrame`

### bag.view.SellItem

- **SellItem** (`core_module:bag/view/SellItem.as`)
  - `army.SellItem.Line` · ScaleLeftRightImage x=0 y=30 width=220 height=2
    - `asset.core.SellItemLine1` · bitmap 81×2 (core.swf)
    - `asset.core.SellItemLine2` · bitmap 7×2 (core.swf)
    - `asset.core.SellItemLine3` · bitmap 80×2 (core.swf)
  - `asset.core.SellItemCountBg` · bitmap x=132 y=6
    - `asset.core.SellItemCountBg` · bitmap 46×23 (core.swf)
  - `army.SellItem.name` · FilterFrameText x=2 y=8 width=130 height=35 font `Arial,11,0xe4d29c,,,,,,left`
  - `army.SellItem.count` · FilterFrameText x=135 y=8 width=39 height=20 font `Arial,13,0xe4d30c,,,,,,center`
  - `army.SellItem.closeBtn` · BaseButton x=196 y=6
    - `asset.core.SellItemClose` · bitmap 23×23 (core.swf)

### bag.view.SpliteItemFrame

- **SpliteItemFrame**: “Divisão de itens” (`core_module:bag/view/SpliteItemFrame.as`)
  - `core.SpliteItemFrame` · SpliteItemFrame width=308 height=181 ← `core.Frame2`
  - `asset.core.SpliteInputBack` · bitmap x=82 y=11
    - `asset.core.SpliteInputBack` · bitmap 151×26 (core.swf)
  - `core.ConfirmBtn` · TextButton x=70 y=48 ← `core.NewAlertButton`
  - `asset.core.InputAlertTextStyle` · bitmap x=-17 y=5
    - `asset.core.InputAlertTextStyle` · bitmap 96×36 (core.swf)
  - `core.InputTextStyle` · FilterFrameText x=86 y=16 width=145 height=20 font `Arial,12,0x8d8d8d,,,,,,left`
  - texts: `bag.view.SpliteItemFrame.title` “Divisão de itens”; `public.confirm` “Confirmar”

### bag.view.StoreBag

- **StoreBag** (`core_module:bag/view/StoreBag.as`)
  - `army.HeroBagItemView` · PlayerBagCell 
    - `core.FashionLevel` · ScaleFrameImage 
      - `asset.core.fashionLevelNormal` · bitmap 21×21 (core.swf)
      - `asset.core.fashionLevelSpecial` · bitmap 21×21 (core.swf)
    - `core.EquipActiveBack` · MovieImage x=-4 y=-4 width=53 height=52
      - `asset.core.EquipActiveBack` · sprite 44 frames (core.swf)
    - `core.ItemBack` · ScaleBitmapImage x=1 y=1 width=45 height=45 ← `core.goods.ItemBack`
    - `core.BaseItemViewIcon` · BaseIconView x=1 y=1
      - `asset.core.IconLoading` · sprite 42 frames (core2.swf)
    - `core.BaseItemText` · FilterFrameText x=0 y=26 width=45 height=18 font `Arial,12,0xffffff,true,,,,,right`
    - `core.GoodsProfileBG` · ScaleFrameImage 
      - `asset.core.BagProfileGreen` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileBlue` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfilePurple` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileOrange` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileRed` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileBlackKing` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileFashion` · bitmap 45×45 (core.swf)
    - `core.BagCellLock` · ScaleFrameImage 
      - `asset.core.BagCellLock` · bitmap 45×45 (core.swf)
      - `asset.core.BagCellUnLock` · bitmap 45×45 (core.swf)
    - `core.goods.Strengthen` · MovieImage x=-50 y=-50
      - `asset.core.goods.Strengthen` · Strengthen 
  - `consortia.ConsortiaBagCell` · ConsortiaBagCell 
    - `consortia.ConsortiaBagCellBack` · ScaleBitmapImage width=45 height=45 ← `core.goods.ItemBack`
    - `consortia.ConsortiaBagCellIcon` · BaseIconView x=1 y=1
      - `asset.core.IconLoading` · sprite 42 frames (core2.swf)
    - `core.BaseItemText` · FilterFrameText x=0 y=26 width=45 height=18 font `Arial,12,0xffffff,true,,,,,right`
    - `consortia.ProfileBG` · ScaleFrameImage  ← `core.GoodsProfileBG`
    - `core.FashionLevel` · ScaleFrameImage 
      - `asset.core.fashionLevelNormal` · bitmap 21×21 (core.swf)
      - `asset.core.fashionLevelSpecial` · bitmap 21×21 (core.swf)
    - `consortia.BagCellLock` · ScaleFrameImage 
      - `asset.core.BagCellLock` · bitmap 45×45 (core.swf)
      - `asset.core.BagCellUnLock` · bitmap 45×45 (core.swf)
    - `core.goods.Strengthen` · MovieImage x=-50 y=-50
      - `asset.core.goods.Strengthen` · Strengthen 
    - `core.EquipActiveBack` · MovieImage x=-4 y=-4 width=53 height=52
      - `asset.core.EquipActiveBack` · sprite 44 frames (core.swf)
  - subviews: `ConsortiaBagCell`, `PlayerBagCell`

### bag.view.StoreBagStateView

- **StoreBagStateView** (`core_module:bag/view/StoreBagStateView.as`)
  - `army.HeroBagItemView` · PlayerBagCell 
    - `core.FashionLevel` · ScaleFrameImage 
      - `asset.core.fashionLevelNormal` · bitmap 21×21 (core.swf)
      - `asset.core.fashionLevelSpecial` · bitmap 21×21 (core.swf)
    - `core.EquipActiveBack` · MovieImage x=-4 y=-4 width=53 height=52
      - `asset.core.EquipActiveBack` · sprite 44 frames (core.swf)
    - `core.ItemBack` · ScaleBitmapImage x=1 y=1 width=45 height=45 ← `core.goods.ItemBack`
    - `core.BaseItemViewIcon` · BaseIconView x=1 y=1
      - `asset.core.IconLoading` · sprite 42 frames (core2.swf)
    - `core.BaseItemText` · FilterFrameText x=0 y=26 width=45 height=18 font `Arial,12,0xffffff,true,,,,,right`
    - `core.GoodsProfileBG` · ScaleFrameImage 
      - `asset.core.BagProfileGreen` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileBlue` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfilePurple` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileOrange` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileRed` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileBlackKing` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileFashion` · bitmap 45×45 (core.swf)
    - `core.BagCellLock` · ScaleFrameImage 
      - `asset.core.BagCellLock` · bitmap 45×45 (core.swf)
      - `asset.core.BagCellUnLock` · bitmap 45×45 (core.swf)
    - `core.goods.Strengthen` · MovieImage x=-50 y=-50
      - `asset.core.goods.Strengthen` · Strengthen 
  - texts: `bag.view.StoreBagStateView.showTips` “Deseja consumir {0} diamantes para obter permanentemente a b”; `public.confirm` “Confirmar”; `public.cancel` “Cancelar”; `public.prompt` “Aviso”
  - subviews: `PlayerBagCell`

### battle.chat.BattleChatPopView

- **BattleChatPopView** (`core_module:battle/chat/BattleChatPopView.as`)
  - `asset.battle.ChatPopIconBack` · bitmap x=31 y=11
    - `asset.battle.ChatPopIconBack` · bitmap 154×74 (battle.swf)
  - `asset.battle.ChatPopAsset` · bitmap 
    - `asset.battle.ChatPopAsset` · bitmap 57×51 (battle.swf)
  - `battle.ChatPopName` · FilterFrameText x=56 y=3 height=22 font `Arial,13,0xffdd9a,true`
  - `battle.ChatPopIcon` · BaseIconView x=3 y=3
    - `asset.core.IconLoading` · sprite 42 frames (core2.swf)
  - texts: `public.colon` “{0}:”
  - subviews: `ExpressionChatNotic`, `BaseIconView`

### battle.view.battleresult.FailedBattleResultView

- **FailedBattleResultView** (`core_module:battle/view/battleresult/FailedBattleResultView.as`)
  - `asset.battle.FailedAsset2` · sprite 20 frames (battle2.swf)

### battle.view.battleresult.FailedBattleResultViewSimple

- **FailedBattleResultViewSimple** (`core_module:battle/view/battleresult/FailedBattleResultViewSimple.as`)
  - `asset.battle.FailedAssetII2` · sprite 20 frames (battle2.swf)

### battle.view.battleresult.FailedOutyardBattleResultView

- **FailedOutyardBattleResultView** (`core_module:battle/view/battleresult/FailedOutyardBattleResultView.as`)
  - `asset.battle.FailedAsset3` · sprite 25 frames (battle2.swf)

### battle.view.battleresult.SinglePassVicotyResultView

- **SinglePassVicotyResultView** (`core_module:battle/view/battleresult/SinglePassVicotyResultView.as`)
  - `asset.singlePass.BattleResultBg` · sprite (clearance.swf)
  - `battle.ResultHBox` · HBox x=268 y=300
  - `battle.ResultItem` · BaseItemView width=41 height=41
    - `battle.ResultItem.RewardCellIcon` · BaseIconView x=1 y=1
      - `asset.core.IconLoading` · sprite 42 frames (core2.swf)
    - `selecteCP.BaseItemText` · FilterFrameText x=2 y=26 width=42 height=16 font `Arial,12,0xffffff,true,,,,,right`
    - `core.GoodsProfileBG` · ScaleFrameImage 
      - `asset.core.BagProfileGreen` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileBlue` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfilePurple` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileOrange` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileRed` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileBlackKing` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileFashion` · bitmap 45×45 (core.swf)
  - `asset.singlePass.Star` · bitmap 16×16 (clearance.swf)
  - `battle.PetIcon2` · BaseIconView x=3 y=3
  - `core.CloseBtn` · BaseButton 
    - `asset.core.closeBtn_style01` · bitmap 29×29 (core2.swf)
  - `asset.campaign.Number1` · bitmap 
    - `asset.campaign.Number1` · bitmap 275×25 (clearance.swf)
  - `asset.campaign.Number2` · bitmap 
    - `asset.campaign.Number2` · bitmap 240×30 (clearance.swf)
  - `asset.campaign.Number3` · bitmap y=-5
    - `asset.campaign.Number3` · bitmap 240×30 (clearance.swf)
  - `asset.campaign.ProfileMCA` · ProfileMCA 
  - `asset.campaign.ProfileMCB` · ProfileMCB 
  - `asset.campaign.ProfileMCC` · ProfileMCC 
  - `asset.campaign.ProfileMCD` · ProfileMCD 
  - `asset.campaign.ProfileMCS` · ProfileMCS 
  - `asset.campaign.ProfileMCSS` · ProfileMCSS 
  - `asset.campaign.ProfileMCSSS` · ProfileMCSSS 
  - subviews: `Component`, `BaseIconView`, `BaseItemView`

### battle.view.battleresult.VicotyBattleResultView

- **VicotyBattleResultView** (`core_module:battle/view/battleresult/VicotyBattleResultView.as`)
  - `asset.battle.VictoryAsset2` · sprite 25 frames (battle2.swf)

### battle.view.battleresult.VicotyBattleResultViewSimple

- **VicotyBattleResultViewSimple** (`core_module:battle/view/battleresult/VicotyBattleResultViewSimple.as`)
  - `asset.battle.VictoryAssetII2` · sprite 50 frames (battle2.swf)

### battle.view.battleresult.VicotyOutyardBattleResultView

- **VicotyOutyardBattleResultView** (`core_module:battle/view/battleresult/VicotyOutyardBattleResultView.as`)
  - `asset.battle.VictoryAsset3` · sprite 24 frames (battle2.swf)

### battle.view.buffer.BufferIconOnRole

- **BufferIconOnRole** (`core_module:battle/view/buffer/BufferIconOnRole.as`)
  - `battle.BufferIconView` · BaseIconView 
  - `tips.BufferLayerNumText` · FilterFrameText x=3 y=15 width=30 height=30 font `Arial,12,0xffffff,true,,,,,right`
  - subviews: `BaseIconView`

### battle.view.buffer.BufferListItemTip

- **BufferListItemTip** (`core_module:battle/view/buffer/BufferListItemTip.as`)
  - `tips.BufferItemTip.Icon` · BaseIconView x=10 y=-10
    - `asset.core.IconLoading` · sprite 42 frames (core2.swf)
  - `tips.BufferItemTipNameText` · FilterFrameText x=65 width=250 height=30 font `Arial,12,0xffffff`
  - `tips.BufferItemTipTurnText` · FilterFrameText y=4 width=180 height=30 font `Arial,12,0xffffff,,,,,,right`
  - `tips.BufferItemTipCountText` · FilterFrameText y=4 width=30 height=20 font `Arial,12,0xffffff,,,,,,right`
  - `tips.BufferItemTip.dispelText` · FilterFrameText x=90 width=120 height=20 font `Arial,12,0x07adfa,,,,,,right`
  - `asset.tips.splitLine` · bitmap x=-2
    - `asset.tips.splitLine` · bitmap 250×2 (army.swf)
  - `tips.BufferItemTip.maxLayerText` · FilterFrameText width=130 height=20 font `Arial,12,0x818181,,,,,,left`
  - `tips.BufferItemTip.maxValueText` · FilterFrameText width=65 height=20 font `Arial,12,0x818181,,,,,,right`
  - `tips.bufferlistitemtip.layerBox` · HBox x=5
  - `tips.bufferlistitemtip.turnBox` · HBox y=20
  - `tips.bufferlistitemtip.countBox` · HBox y=45
  - `asset.tips.equipnum` · bitmap 
    - `asset.tips.equipnum` · bitmap 150×21 (tips.swf)
  - `asset.tips.equipnum` · bitmap 
    - `asset.tips.equipnum` · bitmap 150×21 (tips.swf)
  - `tips.bufferlistitemtip.countVBox` · VBox x=8 y=8
  - texts: `battle.view.buffer.BufferListItemTip.turnText03` “turnos”; `battle.view.buffer.BufferListItemTip.turnText02` “vezes”; `battle.view.buffer.BufferListItemTip.noDispel` “Não pode despersar/purificar”; `battle.view.buffer.BufferListItemTip.maxLayerText` “Pode no máximo acumular camadas”; `battle.view.buffer.BufferListItemTip.maxValueText` “{0} camadas”
  - subviews: `BaseIconView`

### battle.view.roles.HeroRoleView

- **HeroRoleView** (`core_module:battle/view/roles/HeroRoleView.as`)
  - `HeroRoleView.childChangeMovie` · childChangeMovie x=0 y=9
  - `battle.BottomAwakenMc` · BottomAwakenMc x=0 y=9
  - _no style/symbol_: `core.avengerEffectzd`
  - texts: `public.nickName` “Herói”; `battle.view.roles.HeroRoleView.roleInfoView.nameTxt` “Nome não enviado pelo servidor”
  - subviews: `GameView`, `HeroMovieClip`

### battle.view.roles.PetRoleView

- **PetRoleView** (`core_module:battle/view/roles/PetRoleView.as`)
  - `battle.PetNameTxt` · FilterFrameText x=-75 y=-110 width=150 height=18 font `Arial,13,0xffffff,,,,,,center`
  - `asset.pet.smallMoonLightLevelImg` · bitmap 12×11 (core.swf)
  - `asset.pet.smallStarLevelImg` · bitmap 6×6 (core.swf)
  - subviews: `GameView`, `HBox`

### battle.view.roles.RoleViewBase

- **RoleViewBase** (`core_module:battle/view/roles/RoleViewBase.as`)
  - `asset.battle.RoleShadeMC` · RoleShadeMC 
  - `asset.battle.PawnBottomAsset` · PawnBottomAsset y=10
  - `battle.HeroNameTxt` · FilterFrameText x=-65 y=-9 width=130 height=60 font `Arial,13,0xFFE79F,,,,,,center`
  - `battle.HeroServiceTxt` · FilterFrameText x=-75 y=10 width=150 height=18 font `Arial,12,0xFEFD02,,,,,,center`
  - `battle.bufferResistMc` · bufferResistMc 
  - `battle.bufferStateHbox` · HBox x=-35 y=-20
  - `battle.bufferStateHbox` · HBox x=-35 y=-20
  - `battle.bufferGoodImage` · Image x=0 y=0
    - `asset.battle.bufferGoodImage` · bitmap 20×24 (battle.swf)
  - `battle.bufferBadImage` · Image x=0 y=0
    - `asset.battle.bufferBadImage` · bitmap 20×24 (battle.swf)
  - `battle.bufferGoodText` · FilterFrameText width=20 height=20 font `arial,14,0x00ff36,true,,,,,left`
  - `battle.bufferBadText` · FilterFrameText width=20 height=20 font `arial,14,0xff0000,true,,,,,left`
  - `asset.battle.RoleLoadingView` · RoleLoadingView 
  - `asset.battle.BottomHpStripAsset` · BottomHpStripAsset 
  - `asset.battle.SkillUsedSelectedAsset1` · SkillUsedSelectedAsset1 
  - `asset.battle.SkillUsedSelectedAsset2` · SkillUsedSelectedAsset2 
  - texts: `battle.view.roles.RoleViewBase.multiLordsBufferInfo.Tips` “Inspiração: Aumenta os seus atributos e os do Einherjar de b”; `battle.view.roles.RoleViewBase.multiLordsBufferInfo.Tips2` “Inspiração: Eleva {0}% dos atributos de todos os membros e m”
  - subviews: `EffectContainer`, `BufferContainer`, `BufferIconOnRole`, `BossBottomStrip`, `DamageNumView`, `SkillUseItemCell`, `StripUIView`

### battle.view.roles.SelfChessRoleView

- **SelfChessRoleView** (`core_module:battle/view/roles/SelfChessRoleView.as`)
  - `battle.BottomAwakenMc` · BottomAwakenMc x=0 y=9
  - subviews: `GameView`

### battle.view.ui.AddOtherSkillItem

- **AddOtherSkillItem** (`core_module:battle/view/ui/AddOtherSkillItem.as`)
  - `asset.battle.SkillItemCDFlashAsset` · SkillItemCDFlashAsset 
  - `battle.warsoul.SkillItemView` · BaseIconView x=4 y=6
  - `asset.battle.DownMc` · DownMc x=3 y=4
  - `asset.battle.OverMc` · OverMc x=3 y=5
  - `asset.battle.BattlePropLockAsset` · bitmap 
    - `asset.battle.BattlePropLockAsset` · bitmap 56×56 (battle.swf)
  - `asset.battle.BanAsset` · bitmap x=3 y=4
    - `asset.battle.BanAsset` · bitmap 46×46 (battle.swf)
  - subviews: `BaseIconView`

### battle.view.ui.AddOtherSkillView

- **AddOtherSkillView** (`core_module:battle/view/ui/AddOtherSkillView.as`)
  - `asset.battle.comAddSkbg` · bitmap 140×41 (battle.swf)
  - `battle.addSkHBox` · HBox x=193 y=-38
  - subviews: `AddOtherSkillItem`

### battle.view.ui.AvengerBattleSkillView

- **AvengerBattleSkillView** (`core_module:battle/view/ui/AvengerBattleSkillView.as`)
  - `asset.SelfAvengerView.skillBack` · bitmap x=0 y=0
    - `asset.SelfAvengerView.skillBack` · bitmap 309×103 (battle.swf)
  - `SelfAvengerView.avengerImage` · Image x=15 y=18
    - `asset.SelfAvengerView.avengerImage` · bitmap 182×24 (battle.swf)
  - `asset.SelfAvengerView.splitLine` · bitmap x=15 y=18
    - `asset.SelfAvengerView.splitLine` · bitmap 182×24 (battle.swf)
  - `SelfAvengerView.waitBg` · MutipleImage x=0 y=0
    - `SelfAvengerView.waitScaleBg` · ScaleBitmapImage  ← `core.describeBackground_style048`
    - `asset.SelfAvengerView.waitSkillBg` · bitmap 68×156 (battle.swf)
    - `asset.SelfAvengerView.waitSkillBg` · bitmap 68×156 (battle.swf)
  - `SelfAvengerView.majorText` · FilterFrameText x=3 y=15 width=75 height=20 font `arial,14,0xe9c68c,,,,,,center`
  - `SelfAvengerView.minorText` · FilterFrameText x=80 y=15 ← `SelfAvengerView.majorText`
  - `SelfAvengerView.fightSkillHbox` · HBox x=23 y=40
  - `SelfAvengerView.waitSkillCon` · Component x=13 y=12
  - `asset.SelfAvengerView.numBmd` · bitmap x=0 y=0
    - `asset.SelfAvengerView.numBmd` · bitmap 130×18 (battle.swf)
  - `SelfAvengerView.avengerSpCon` · Component x=30 y=0
  - `SelfAvengerView.waitView` · Component x=57 y=-152
  - `SelfAvengerView.openBtn` · BaseButton x=128 y=44
    - `asset.SelfAvengerView.openBtn` · bitmap 51×50 (battle.swf)
  - `asset.SelfAvengerView.closeImage` · bitmap x=128 y=44
    - `asset.SelfAvengerView.closeImage` · bitmap 51×50 (battle.swf)
  - `SelfAvengerView.leftTimeText` · FilterFrameText x=135 y=60 width=40 height=20 font `arial,14,0xff0000,,,,,,center`
  - `AvengerBattleSkillView.btnKeyImage` · Image x=130 y=40
    - `asset.battle.SkillCountBack` · bitmap x=29 y=43
      - `asset.battle.SkillCountBack` · bitmap 19×16 (battle.swf)
  - `AvengerBattleSkillView.btnKeyText` · FilterFrameText x=143 y=82 ← `battle.SkillBigCount`
  - texts: `SelfAvengerView.majorText.text` “Principal”; `SelfAvengerView.minorText.text` “Secundário”
  - subviews: `BattleSkillItemII`, `Component`

### battle.view.ui.BattleLoadingView

- **BattleLoadingView** (`core_module:battle/view/ui/BattleLoadingView.as`)
  - `core.loading.LoadingMapAsset.zhanqu` · zhanqu 
  - `core.loading.LoadingMapAsset.zhanqu` · zhanqu 
  - `core.loading.LoadingMapAsset.shenqu` · shenqu 
  - subviews: `shenqu`, `zhanqu`

### battle.view.ui.BattleSkillItemII

- **BattleSkillItemII** (`core_module:battle/view/ui/BattleSkillItemII.as`)
  - `asset.battle.SkillItemCDFlashAsset` · SkillItemCDFlashAsset 
  - `battle.SkillItemView` · BaseIconView x=4 y=6
  - `asset.battle.SuperSkill` · bitmap x=4 y=6
    - `asset.battle.SuperSkill` · bitmap 20×23 (battle.swf)
  - `asset.battle.SkillCountBack` · bitmap x=29 y=43
    - `asset.battle.SkillCountBack` · bitmap 19×16 (battle.swf)
  - `battle.SkillCount` · FilterFrameText x=15 y=41 width=30 height=20 font `Arial,13,0xffffff,true,,,,,right`
  - `asset.battle.DownMc` · DownMc x=3 y=4
  - `asset.battle.OverMc` · OverMc x=3 y=5
  - `asset.battle.BattlePropLockAsset` · bitmap 
    - `asset.battle.BattlePropLockAsset` · bitmap 56×56 (battle.swf)
  - `asset.battle.BanAsset` · bitmap x=3 y=4
    - `asset.battle.BanAsset` · bitmap 46×46 (battle.swf)
  - `battleSkillItemII.circleImg` · CustomBitmap x=7 y=9
    - `asset.battle.SkillCricleImg` · bitmap 35×34 (battle.swf)
  - `battle.MarrPropCount` · FilterFrameText x=12 y=5 width=30 height=20 font `Arial,12,0xffffff,true,,,,,right`
  - `battleSkillItemII.bigCircleImg` · CustomBitmap x=7 y=9
    - `asset.battle.SkillBigCricleImg` · bitmap 42×41 (battle.swf)
  - `asset.battle.SkillCountBack` · bitmap x=29 y=43
    - `asset.battle.SkillCountBack` · bitmap 19×16 (battle.swf)
  - `battle.SkillBigCount` · FilterFrameText x=6 y=41 width=50 height=20 font `Arial,13,0xffffff,true,,,,,center`
  - `battle.MarrPropCount` · FilterFrameText x=12 y=5 width=30 height=20 font `Arial,12,0xffffff,true,,,,,right`
  - `battleSkillItemII.sacristy.blackCircle` · CustomBitmap x=2 y=3
    - `asset.battle.sacristy.blackCircle` · bitmap 66×67 (battle.swf)
  - `asset.battle.SkillCountBack` · bitmap x=29 y=43
    - `asset.battle.SkillCountBack` · bitmap 19×16 (battle.swf)
  - `battle.SkillBigCount` · FilterFrameText x=6 y=41 width=50 height=20 font `Arial,13,0xffffff,true,,,,,center`
  - `battle.MarrPropCount` · FilterFrameText x=12 y=5 width=30 height=20 font `Arial,12,0xffffff,true,,,,,right`
  - `battle.SkillSacristyItemView` · BaseIconView x=4 y=6
  - subviews: `SkillItemCDEffect`, `SkillItemCDNumView`, `BaseIconView`

### battle.view.ui.BattleTrailPropItem

- **BattleTrailPropItem** (`core_module:battle/view/ui/BattleTrailPropItem.as`)
  - `battle.TrailPropIcon` · BaseIconView x=5 y=5
  - `asset.battle.SkillItemCDFlashAsset` · SkillItemCDFlashAsset 
  - `battle.TrailPropCount` · FilterFrameText x=13 y=26 width=30 height=20 font `Arial,12,0xFFefbd,,,,,,right`
  - `asset.battle.DownMc` · DownMc x=3 y=4
  - `asset.battle.OverMc` · OverMc x=3 y=5
  - `asset.battle.GetTraiCountMc` · sprite 25.0×19.0 50 frames (battle.swf)
  - subviews: `SkillItemCDEffect`, `SkillItemCDNumView`, `BaseIconView`, `SimpleMovie`

### battle.view.ui.BattleWarsoulSkillItem

- **BattleWarsoulSkillItem** (`core_module:battle/view/ui/BattleWarsoulSkillItem.as`)
  - `asset.battle.SkillItemCDFlashAsset` · SkillItemCDFlashAsset 
  - `battle.warsoul.SkillItemView` · BaseIconView x=4 y=6
  - `asset.battle.DownMc` · DownMc x=3 y=4
  - `asset.battle.OverMc` · OverMc x=3 y=5
  - `asset.battle.BattlePropLockAsset` · bitmap 
    - `asset.battle.BattlePropLockAsset` · bitmap 56×56 (battle.swf)
  - `asset.battle.BanAsset` · bitmap x=3 y=4
    - `asset.battle.BanAsset` · bitmap 46×46 (battle.swf)
  - subviews: `BaseIconView`

### battle.view.ui.BossBottomStrip

- **BossBottomStrip** (`core_module:battle/view/ui/BossBottomStrip.as`)
  - `asset.battle.BossBottomStripAsset` · BossBottomStripAsset 
  - subviews: `StripUIView`

### battle.view.ui.BossStripUIView

- **BossStripUIView** (`core_module:battle/view/ui/BossStripUIView.as`)
  - `asset.battle.BossStripNumAsset` · bitmap 
    - `asset.battle.BossStripNumAsset` · bitmap 249×50 (core.swf)
  - `asset.battle.BossHpStripAsset` · BossHpStripAsset 
  - `asset.battle.BossHpStripBgAsset` · bitmap 
    - `asset.battle.BossHpStripBgAsset` · bitmap 397×27 (core.swf)
  - subviews: `BossHpStripAsset`, `StripUIView`

### battle.view.ui.DamageNumView

- **DamageNumView** (`core_module:battle/view/ui/DamageNumView.as`)
  - `asset.battle.BloodUpdateRage` · BloodUpdateRage 
  - `asset.battle.BloodUpdateAsset` · BloodUpdateAsset 
  - `asset.battle.ParryAsset` · bitmap 
    - `asset.battle.ParryAsset` · bitmap 113×28 (battle.swf)
  - `battle.GreenNumberAssetSp.text` · FilterFrameText height=60 font `arial,40,0x5EEF26,,,,,,left`
  - `battle.SelfCauseNumberAssetSp.text` · FilterFrameText height=60 font `arial,40,0x23B3E8,,,,,,left`
  - `battle.DamageNumberAssetSp.text` · FilterFrameText height=60 font `arial,40,0xF1FA61,,,,,,left`
  - `battle.SelfCauseNumberAssetSp.text` · FilterFrameText height=60 font `arial,40,0x23B3E8,,,,,,left`
  - `battle.RedNumberAssetSp.text` · FilterFrameText height=60 font `arial,40,0xF4FFCC,,,,,,left`
  - `asset.battle.fireImg` · bitmap 45×67 (battle.swf)
  - `battle.CriticalDamageNumAssetSp` · CriticalDamageNumAssetSp 
  - `asset.battle.CriticalDamageAsset` · bitmap 
    - `asset.battle.CriticalDamageAsset` · bitmap 114×47 (battle.swf)

### battle.view.ui.PropSkillBattleItem

- **PropSkillBattleItem** (`core_module:battle/view/ui/PropSkillBattleItem.as`)
  - `core.BaseItemText` · FilterFrameText x=0 y=26 width=45 height=18 font `Arial,12,0xffffff,true,,,,,right`
  - subviews: `SkillItemCDEffect`

### battle.view.ui.SkillItemCDEffect

- **SkillItemCDEffect** (`core_module:battle/view/ui/SkillItemCDEffect.as`)
  - `asset.battle.SkillItemCDAsset` · SkillItemCDAsset 

### battle.view.ui.SkillItemCDNumView

- **SkillItemCDNumView** (`core_module:battle/view/ui/SkillItemCDNumView.as`)
  - `asset.battle.SkillCDNumRed` · bitmap 
    - `asset.battle.SkillCDNumRed` · bitmap 220×28 (battle.swf)
  - `asset.battle.SkillCDNumYellow` · bitmap 
    - `asset.battle.SkillCDNumYellow` · bitmap 220×28 (battle.swf)

### battle.view.ui.SkillItemListView

- **SkillItemListView** (`core_module:battle/view/ui/SkillItemListView.as`)
  - `battle.TrailBack` · ScaleFrameImage x=163 y=-47
    - `asset.battle.TrailBack` · bitmap x=0 y=0
      - `asset.battle.TrailBack` · bitmap 176×42 (battle.swf)
    - `asset.battle.CrossGuildTrailBack` · bitmap 104×41 (battle.swf)
  - `battle.TrailPropBox` · HBox x=173 y=-46
  - `asset.battle.comAddSkbg` · bitmap 140×41 (battle.swf)
  - `battle.addSkHBox` · HBox x=193 y=-38
  - subviews: `BattleSkillItemII`, `BattleTrailPropItem`, `PropSkillBattleItem`, `TileContainer`

### battle.view.ui.SkillUseItemCell

- **SkillUseItemCell** (`core_module:battle/view/ui/SkillUseItemCell.as`)
  - `battle.SkillUseItemCell` · BaseIconView x=5 y=5
  - `asset.battle.SkillGlowAsset` · SkillGlowAsset 
  - subviews: `BaseIconView`

### battle.view.ui.SkillWarsoulView

- **SkillWarsoulView** (`core_module:battle/view/ui/SkillWarsoulView.as`)
  - `asset.battle.warsoul.containBg` · bitmap x=0 y=0
    - `asset.battle.warsoul.containBg` · bitmap 179×51 (battle.swf)
  - `asset.battle.warsoul.spBg` · bitmap x=22 y=-15
    - `asset.battle.warsoul.spBg` · bitmap 129×37 (battle.swf)
  - `asset.battle.warsoul.spBar` · bitmap x=33 y=3
    - `asset.battle.warsoul.spBar` · bitmap 109×12 (battle.swf)
  - `asset.battle.warsoul.spLine` · bitmap x=29 y=1
    - `asset.battle.warsoul.spLine` · bitmap 114×15 (battle.swf)
  - `battle.warsoulHBox` · HBox x=38 y=18
  - `battle.warsoul.spTxt` · FilterFrameText x=21 y=-13 width=50 height=20 font `arial,12,0xffffff,true,,,,,center`
  - subviews: `BattleWarsoulSkillItem`

### battle.view.ui.StripUIView

- **StripUIView** (`core_module:battle/view/ui/StripUIView.as`)
  - `asset.battle.BossHpStripLightMc` · sprite 5.0×29.0 55 frames (core.swf)

### battle.view.ui.attackmode.AttackModeBtnTip

- **AttackModeBtnTip** (`core_module:battle/view/ui/attackmode/AttackModeBtnTip.as`)
  - `tips.SkillNameText` · FilterFrameText width=130 font `Arial,14,0x2fb8ff,true,,,,,left`
  - `tips.AttackModeBtnDescribeText` · FilterFrameText width=250 font `Arial,12,0xffffff`

### battle.view.ui.attackmode.AttackModeButton

- **AttackModeButton** (`core_module:battle/view/ui/attackmode/AttackModeButton.as`)
  - `battle.ModeNameTxt` · FilterFrameText x=32 y=6 height=22 font `Arial,12,0xF1E1BC`
  - `battle.ValidTimeTxt` · FilterFrameText x=3 y=17 height=22 font `Arial,11,0xFFFFFF`
  - `battle.TurnNumTxt` · FilterFrameText x=28 y=6 height=22 font `Arial,14,0xFFFFFF`
  - `battle.TurnStrTxt` · FilterFrameText x=37 y=6 height=22 font `Arial,12,0xF1E1BC`
  - texts: `battle.view.ui.attackmode.turnStrTf.text` “turnos”

### battle.view.ui.top.BossInfoView

- **BossInfoView** (`core_module:battle/view/ui/top/BossInfoView.as`)
  - `asset.battle.AddHpNumAsset` · bitmap 
    - `asset.battle.AddHpNumAsset` · bitmap 549×46 (core.swf)
  - `asset.battle.ExtraNumberAsset` · ExtraNumberAsset 
  - `asset.battle.WorldBossBloodMC` · WorldBossBloodMC 
  - `asset.battle.BossShowRightAsset` · BossShowRightAsset 
  - `core.boss.bossNameBg` · ScaleBitmapImage x=-75 y=108 width=213 height=56
    - `asset.battle.BossNameBgImg` · bitmap 213×56 (core.swf)
  - `asset.battle.BossGradeNumAsset` · bitmap 200×25 (core.swf)
  - subviews: `BossShowRightAsset`, `ExtraNumberAsset`, `WorldBossBloodMC`, `BossStripUIView`, `HeroRoleHeadView`, `Component`

### battle.view.ui.top.BossInfoViewII

- **BossInfoViewII** (`core_module:battle/view/ui/top/BossInfoViewII.as`)
  - `asset.battle.ExtraNumberAsset` · ExtraNumberAsset 
  - `asset.battle.WorldBossBloodMC` · WorldBossBloodMC 
  - `asset.battle.BossGradeNumAsset` · bitmap 200×25 (core.swf)
  - `asset.battle.BossHpStripAsset_0` · sprite (core.swf)
  - `asset.battle.BossHpStripAsset_1` · sprite (core.swf)
  - `asset.battle.LiteBossBloodBar_0` · LiteBossBloodBar_0 
  - `asset.battle.LiteBossBloodBar_1` · LiteBossBloodBar_1 
  - `asset.battle.LiteBossBloodBmd_0` · bitmap 187×13 (core.swf)
  - `asset.battle.LiteBossBloodBmd_1` · bitmap 134×10 (core.swf)
  - subviews: `ExtraNumberAsset`, `LiteBossBloodBar_0`, `LiteBossBloodBar_1`, `WorldBossBloodMC`, `BossStripUIView`, `HeroRoleHeadView`

### battle.view.ui.top.DoubleBossInfoView

- **DoubleBossInfoView** (`core_module:battle/view/ui/top/DoubleBossInfoView.as`)
  - `asset.core.boubleBossHPAsset` · boubleBossHPAsset 
  - `asset.battle.BossGradeNumAsset` · bitmap 200×25 (core.swf)
  - subviews: `boubleBossHPAsset`, `BossStripUIView`, `HeroRoleHeadView`, `Component`

### cell.mediator.marketbag.MarketItemCell

- **MarketItemCell** (`core_module:cell/mediator/marketbag/MarketItemCell.as`)
  - `MarketBagListView.cell` · MarketItemCell x=7 y=5 ← `core.BaseItemView`

### cell.mediator.marketbag.MarketSellAlertFrame

- **MarketSellAlertFrame**: “Vender” (`core_module:cell/mediator/marketbag/MarketSellAlertFrame.as`)
  - `market.MarketSellAlertFrame` · MarketSellAlertFrame width=375 height=250 ← `core.Frame2`
  - `MarketSellAlertFrame.bg` · MutipleImage 
    - `asset.MarketSellAlertFrame.numImg` · bitmap 61×19 (campaign.swf)
    - `asset.MarketSellAlertFrame.priceImg` · bitmap 78×34 (campaign.swf)
    - `core.InputBack_Style_05` · ScaleBitmapImage 
      - `asset.core.InputBack_Style_05` · bitmap 180×34 (core2.swf)
    - `core.InputBack_Style_05` · ScaleBitmapImage 
      - `asset.core.InputBack_Style_05` · bitmap 180×34 (core2.swf)
    - `asset.core.SmallPointImg` · bitmap x=0
      - `asset.core.SmallPointImg` · bitmap 23×21 (bottle.swf)
  - `MarketSellAlertFrame.numTxt` · FilterFrameText x=80 y=3 ← `auction.AuctionBuyNumText`
  - `MarketSellAlertFrame.priceTxt` · FilterFrameText x=80 y=53 ← `auction.AuctionBuyNumText`
  - `MarketSellAlertFrame.addBtn` · BaseButton x=265 y=-2 width=26 height=18
    - `asset.MarketSellAlertFrame.addButton` · bitmap 32×22 (campaign.swf)
  - `MarketSellAlertFrame.reduceBtn` · BaseButton x=265 y=15 width=26 height=18
    - `asset.MarketSellAlertFrame.reduceButton` · bitmap 32×22 (campaign.swf)
  - `MarketSellAlertFrame.confirmBtn` · IconButton x=25 y=98 ← `core.AlertButtonConfirm_1`
  - `MarketSellAlertFrame.cancleBtn` · IconButton x=167 y=98 ← `core.AlertButtonCancel_1`
  - texts: `armyII.ArmyFrameII.sell` “Vender”

### cell.view.GoodsItemMenu

- **GoodsItemMenu** (`core_module:cell/view/GoodsItemMenu.as`)
  - `core.GoodsItemMenu` · GoodsItemMenu 
  - `core.UseButton` · TextButton x=0 y=0 width=110 height=28
    - `asset.core.SellGoodsBack` · bitmap 68×28 (core.swf)
    - `core.UseButtonText` · FilterFrameText width=110 height=24 font `Arial,12,0xffd8b2,,,,,,center`
  - `core.MoveButton` · TextButton x=0 y=0 ← `core.UseButton`
  - `core.MulUseButton` · TextButton x=0 y=0 ← `core.UseButton`
  - `core.GoodsItemMenuContain` · VBox x=5 y=5
  - `core.MulItemUseFrame` · MulItemUseFrame  ← `core.SpliteItemFrame`
  - `friends.RosePresentView` · RosePresentView width=314 height=228 ← `core.ConfirmSellFrame`
  - `core.CrossBugleFrame` · CrossBugleFrame width=347 height=202 ← `core.Frame2`
    - `core.CrossBugleFrame.back` · MutipleImage 
      - `asset.core.crossBack` · bitmap 347×202 (core.swf)
      - `asset.core.cross.leftTitle` · bitmap 60×18 (core.swf)
      - `asset.core.cross.rightTitle` · bitmap 60×18 (core.swf)
  - `friends.SnowRosePresentView` · SnowRosePresentView width=314 height=228 ← `core.ConfirmSellFrame`
  - texts: `cell.view.GoodsItemMenu.use` “Usar”; `cell.view.GoodsItemMenu.move` “Mover”; `cell.view.GoodsItemMenu.mul` “Usar em massa”; `cell.view.GoodsItemMenu.command01` “Nível insuficiente”; `cell.mediator.playerbag.PlayerBagCellClickMediator.command08` “Itens insuficientes para abrir o Baú, não poderá abrir”; `cell.mediator.playerbag.PlayerBagCellClickMediator.outDateGoods` “Item inválido”; `cell.mediator.playerbag.PlayerBagCellClickMediator.command11` “Esta carta de convocação do chefão apenas pode ser usado nos”; `mopup.MopupManager.mopupTipData01` “Modo Bot em andamento”
  - subviews: `MulItemUseFrame`, `SnowRosePresentView`, `RosePresentView`, `CrossBugleFrame`, `RenameView`

### cell.view.PrizeItemMenu

- **PrizeItemMenu** (`core_module:cell/view/PrizeItemMenu.as`)
  - `consortia.PrizeItemMenu` · PrizeItemMenu 
  - `consortia.AllotButton` · TextButton x=0 y=0 ← `core.UseButton`
  - `consortia.PrizeItemMenuContain` · VBox x=5 y=5
  - texts: `cell.view.PrizeItemMenu.allot` “Distribuir”

### cell.view.bottlebag.BottleBagCell

- **BottleBagCell** (`core_module:cell/view/bottlebag/BottleBagCell.as`)
  - `bottle.BottleBagCell` · BottleBagCell  ← `core.BaseItemView`

### cell.view.consortiabag.ConsortiaBagCell

- **ConsortiaBagCell** (`core_module:cell/view/consortiabag/ConsortiaBagCell.as`)
  - `consortia.ConsortiaBagCell` · ConsortiaBagCell 
    - `consortia.ConsortiaBagCellBack` · ScaleBitmapImage width=45 height=45 ← `core.goods.ItemBack`
    - `consortia.ConsortiaBagCellIcon` · BaseIconView x=1 y=1
      - `asset.core.IconLoading` · sprite 42 frames (core2.swf)
    - `core.BaseItemText` · FilterFrameText x=0 y=26 width=45 height=18 font `Arial,12,0xffffff,true,,,,,right`
    - `consortia.ProfileBG` · ScaleFrameImage  ← `core.GoodsProfileBG`
    - `core.FashionLevel` · ScaleFrameImage 
      - `asset.core.fashionLevelNormal` · bitmap 21×21 (core.swf)
      - `asset.core.fashionLevelSpecial` · bitmap 21×21 (core.swf)
    - `consortia.BagCellLock` · ScaleFrameImage 
      - `asset.core.BagCellLock` · bitmap 45×45 (core.swf)
      - `asset.core.BagCellUnLock` · bitmap 45×45 (core.swf)
    - `core.goods.Strengthen` · MovieImage x=-50 y=-50
      - `asset.core.goods.Strengthen` · Strengthen 
    - `core.EquipActiveBack` · MovieImage x=-4 y=-4 width=53 height=52
      - `asset.core.EquipActiveBack` · sprite 44 frames (core.swf)

### cell.view.consortiabag.ConsortiaCaseCell

- **ConsortiaCaseCell** (`core_module:cell/view/consortiabag/ConsortiaCaseCell.as`)
  - `consortia.ConsortiaCaseCell` · ConsortiaCaseCell 
    - `consortia.CaseItemBack` · ScaleBitmapImage width=45 height=45 ← `core.goods.ItemBack`
    - `consortia.BaseItemText` · FilterFrameText x=2 y=26 width=42 height=16 font `Arial,12,0xffffff,true,,,,,right`
    - `consortia.ConsortiaCaseCellIcon` · BaseIconView x=1 y=1
      - `asset.core.IconLoading` · sprite 42 frames (core2.swf)
    - `core.BagLockIcon` · ScaleFrameImage 
      - `asset.core.BagLockIcon` · bitmap 
        - `asset.core.BagLockIcon` · bitmap 45×45 (core.swf)
      - `core.BagLockIcon1` · ScaleFrameImage 
        - `asset.core.BagLockIcon` · bitmap 
          - `asset.core.BagLockIcon` · bitmap 45×45 (core.swf)
    - `core.GoodsProfileBG` · ScaleFrameImage 
      - `asset.core.BagProfileGreen` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileBlue` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfilePurple` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileOrange` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileRed` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileBlackKing` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileFashion` · bitmap 45×45 (core.swf)
    - `core.FashionLevel` · ScaleFrameImage 
      - `asset.core.fashionLevelNormal` · bitmap 21×21 (core.swf)
      - `asset.core.fashionLevelSpecial` · bitmap 21×21 (core.swf)
    - `core.goods.Strengthen` · MovieImage x=-50 y=-50
      - `asset.core.goods.Strengthen` · Strengthen 

### cell.view.consortiabag.ConsortiaPrizeCell

- **ConsortiaPrizeCell** (`core_module:cell/view/consortiabag/ConsortiaPrizeCell.as`)
  - `consortia.ConsortiaPrizeCell` · ConsortiaPrizeCell 
    - `consortia.CaseItemBack` · ScaleBitmapImage width=45 height=45 ← `core.goods.ItemBack`
    - `consortia.BaseItemText` · FilterFrameText x=2 y=26 width=42 height=16 font `Arial,12,0xffffff,true,,,,,right`
    - `consortia.ConsortiaPrizeCellIcon` · BaseIconView x=1 y=1
      - `asset.core.IconLoading` · sprite 42 frames (core2.swf)
    - `core.GoodsProfileBG` · ScaleFrameImage 
      - `asset.core.BagProfileGreen` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileBlue` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfilePurple` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileOrange` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileRed` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileBlackKing` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileFashion` · bitmap 45×45 (core.swf)
    - `core.FashionLevel` · ScaleFrameImage 
      - `asset.core.fashionLevelNormal` · bitmap 21×21 (core.swf)
      - `asset.core.fashionLevelSpecial` · bitmap 21×21 (core.swf)
    - `core.goods.Strengthen` · MovieImage x=-50 y=-50
      - `asset.core.goods.Strengthen` · Strengthen 

### cell.view.fashionbag.FashionBag

- **FashionBag** (`core_module:cell/view/fashionbag/FashionBag.as`)
  - `fashionStoreFrame.preBtn` · BaseButton x=96 y=96 ← `auction.prePageBtn`
  - `fashionStoreFrame.nextBtn` · BaseButton x=200 y=96 ← `auction.nextPageBtn`
  - `asset.core.PageNumBack` · bitmap x=35 y=-1.5 width=67
    - `asset.core.PageNumBack` · bitmap 57×30 (core2.swf)
  - `fashionStoreFrame.pageText` · FilterFrameText x=133 y=100 ← `auction.PageTxt`
  - `store.SimpleTileList` · SimpleTileList 
  - `fashion.fashionBagCell` · FashionBagCell 
    - `core.ItemBack` · ScaleBitmapImage x=1 y=1 width=45 height=45 ← `core.goods.ItemBack`
    - `store.StoreBagCellIcon` · BaseIconView x=0 y=0
      - `asset.core.IconLoading` · sprite 42 frames (core2.swf)
    - `core.BaseItemText` · FilterFrameText x=0 y=26 width=45 height=18 font `Arial,12,0xffffff,true,,,,,right`
    - `asset.core.HeroEquipIcon` · bitmap x=22 y=3
      - `asset.core.HeroEquipIcon` · bitmap 22×22 (core.swf)
    - `store.ProfileBG` · ScaleFrameImage x=1 y=1 ← `core.GoodsProfileBG`
    - `core.FashionLevel` · ScaleFrameImage 
      - `asset.core.fashionLevelNormal` · bitmap 21×21 (core.swf)
      - `asset.core.fashionLevelSpecial` · bitmap 21×21 (core.swf)
    - `core.goods.Strengthen` · MovieImage x=-50 y=-50
      - `asset.core.goods.Strengthen` · Strengthen 
  - `fashion.fashionBagCell` · FashionBagCell 
    - `core.ItemBack` · ScaleBitmapImage x=1 y=1 width=45 height=45 ← `core.goods.ItemBack`
    - `store.StoreBagCellIcon` · BaseIconView x=0 y=0
      - `asset.core.IconLoading` · sprite 42 frames (core2.swf)
    - `core.BaseItemText` · FilterFrameText x=0 y=26 width=45 height=18 font `Arial,12,0xffffff,true,,,,,right`
    - `asset.core.HeroEquipIcon` · bitmap x=22 y=3
      - `asset.core.HeroEquipIcon` · bitmap 22×22 (core.swf)
    - `store.ProfileBG` · ScaleFrameImage x=1 y=1 ← `core.GoodsProfileBG`
    - `core.FashionLevel` · ScaleFrameImage 
      - `asset.core.fashionLevelNormal` · bitmap 21×21 (core.swf)
      - `asset.core.fashionLevelSpecial` · bitmap 21×21 (core.swf)
    - `core.goods.Strengthen` · MovieImage x=-50 y=-50
      - `asset.core.goods.Strengthen` · Strengthen 
  - subviews: `FashionBagCell`

### cell.view.fishBag.FishBagCell

- **FishBagCell** (`core_module:cell/view/fishBag/FishBagCell.as`)
  - `fish.FishBagCell` · FishBagCell  ← `core.BaseItemView`

### cell.view.goldroad.GoldRoadBagCell

- **GoldRoadBagCell** (`core_module:cell/view/goldroad/GoldRoadBagCell.as`)
  - `gold.goldRoadBagCell` · GoldRoadBagCell  ← `core.BaseItemView`

### cell.view.playerbag.PlayerBagCell

- **PlayerBagCell** (`core_module:cell/view/playerbag/PlayerBagCell.as`)
  - `army.HeroBagItemView` · PlayerBagCell 
    - `core.FashionLevel` · ScaleFrameImage 
      - `asset.core.fashionLevelNormal` · bitmap 21×21 (core.swf)
      - `asset.core.fashionLevelSpecial` · bitmap 21×21 (core.swf)
    - `core.EquipActiveBack` · MovieImage x=-4 y=-4 width=53 height=52
      - `asset.core.EquipActiveBack` · sprite 44 frames (core.swf)
    - `core.ItemBack` · ScaleBitmapImage x=1 y=1 width=45 height=45 ← `core.goods.ItemBack`
    - `core.BaseItemViewIcon` · BaseIconView x=1 y=1
      - `asset.core.IconLoading` · sprite 42 frames (core2.swf)
    - `core.BaseItemText` · FilterFrameText x=0 y=26 width=45 height=18 font `Arial,12,0xffffff,true,,,,,right`
    - `core.GoodsProfileBG` · ScaleFrameImage 
      - `asset.core.BagProfileGreen` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileBlue` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfilePurple` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileOrange` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileRed` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileBlackKing` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileFashion` · bitmap 45×45 (core.swf)
    - `core.BagCellLock` · ScaleFrameImage 
      - `asset.core.BagCellLock` · bitmap 45×45 (core.swf)
      - `asset.core.BagCellUnLock` · bitmap 45×45 (core.swf)
    - `core.goods.Strengthen` · MovieImage x=-50 y=-50
      - `asset.core.goods.Strengthen` · Strengthen 

### cell.view.playerequip.HonorCell

- **HonorCell** (`core_module:cell/view/playerequip/HonorCell.as`)
  - `playerinfo.HonorCell1` · HonorCell x=127 y=295
    - `playerinfo.HonerCellBack` · ScaleFrameImage x=-5 y=-3 width=44 height=44
      - `asset.playerinfo.HonerItemBack` · bitmap 54×52 (playerinfo.swf)
    - `core.PlayerEquipicon` · BaseIconView x=1 y=1
      - `asset.core.IconLoading` · sprite 42 frames (core2.swf)
    - `core.GoodsProfileBG` · ScaleFrameImage 
      - `asset.core.BagProfileGreen` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileBlue` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfilePurple` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileOrange` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileRed` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileBlackKing` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileFashion` · bitmap 45×45 (core.swf)
    - `core.EquipActiveBack` · MovieImage x=-4 y=-4 width=53 height=52
      - `asset.core.EquipActiveBack` · sprite 44 frames (core.swf)
    - `core.EquipItemEffect` · MovieImage x=2 y=3
      - `asset.core.EquipItemEffect` · sprite 14 frames (core.swf)
    - `core.BaseItemText` · FilterFrameText x=0 y=26 width=45 height=18 font `Arial,12,0xffffff,true,,,,,right`
  - `MarryRingView.upBtn` · IconButton x=25 y=25 width=29 height=28
    - `asset.core.ringUpBack1` · bitmap 29×30 (core.swf)

### cell.view.playerequip.PlayerEquipCell

- **PlayerEquipCell** (`core_module:cell/view/playerequip/PlayerEquipCell.as`)
  - `core.UpgradeEquipBtn` · SelectedButton x=28 y=31
    - `asset.core.EquipUpgradeDidsEnable` · bitmap 23×19 (core.swf)
    - `asset.core.EquipUpgradeEnable` · bitmap 23×19 (core.swf)

### cell.view.runebag.RuneBagCell

- **RuneBagCell** (`core_module:cell/view/runebag/RuneBagCell.as`)
  - `army.rune.RuneBagCell` · RuneBagCell 
    - `core.ItemBack` · ScaleBitmapImage x=1 y=1 width=45 height=45 ← `core.goods.ItemBack`
    - `army.rune.RuneBagCellIcon` · BaseIconView x=0 y=0
      - `asset.core.IconLoading` · sprite 42 frames (core2.swf)
    - `core.BaseItemText` · FilterFrameText x=0 y=26 width=45 height=18 font `Arial,12,0xffffff,true,,,,,right`
    - `asset.core.HeroEquipIcon` · bitmap x=22 y=3
      - `asset.core.HeroEquipIcon` · bitmap 22×22 (core.swf)
    - `army.rune.ProfileBG` · ScaleFrameImage x=1 y=1 ← `core.GoodsProfileBG`
    - `core.goods.Strengthen` · MovieImage x=-50 y=-50
      - `asset.core.goods.Strengthen` · Strengthen 

### cell.view.runebag.RuneIntensifyCell

- **RuneIntensifyCell** (`core_module:cell/view/runebag/RuneIntensifyCell.as`)
  - `army.rune.IntensifyRuneItem` · RuneIntensifyCell x=0 y=0
    - `army.rune.IntensifyBack` · ScaleBitmapImage x=0 y=0 width=50 height=50
      - `asset.army.rune.RuneItemBg` · bitmap 50×50 (army.swf)
    - `army.rune.IntensifyRuneItemIcon` · BaseIconView x=0 y=0
    - `army.rune.IntensifyRuneTipFrameMc` · MovieImage x=-2 y=-3 width=55 height=55
      - `asset.core.EquipActiveBack` · sprite 44 frames (core.swf)
    - `core.goods.Strengthen` · MovieImage x=-50 y=-50
      - `asset.core.goods.Strengthen` · Strengthen 
  - `army.rune.RuneIntensifyCellNumTxt` · FilterFrameText x=0 y=32 width=50 height=18 font `Arial,12,0xffffff,,,,,,right`

### cell.view.sale.SaleBagCell

- **SaleBagCell** (`core_module:cell/view/sale/SaleBagCell.as`)
  - `sale.SaleBagCell` · SaleBagCell  ← `core.BaseItemView`
  - `SaleBagCell.state` · FilterFrameText x=1 y=0 width=42 height=42 font `Arial,11,0x4ffe02,true,,,,,left`
  - texts: `SaleBagCell.state1` “Vendido”; `SaleBagCell.state2` “Leiloado”

### cell.view.starbag.StarBagCell

- **StarBagCell** (`core_module:cell/view/starbag/StarBagCell.as`)
  - `continuePayRebate.rewardItem.StarBagCell` · StarBagCell  ← `payreward.StarBagCell`
  - `asset.common.vp.icon` · bitmap 
    - `asset.common.vp.icon` · bitmap 17×20 (common.swf)
  - `star.maxButton` · BaseButton  ← `star.addAttributeBtn`
    - `asset.star.maxBg` · bitmap 31×21 (star.swf)
  - `star.tipButton` · BaseButton  ← `star.addAttributeBtn`
  - `core.ConfirmSellFrame` · ConfirmSellFrame width=340 height=196 ← `core.Frame2`
    - `core.quickBuyFrameBg` · MutipleImage 
      - `core.AlertFrameBg` · MutipleImage 
        - `core.AlertFrameBaseBg` · Scale9CornerImage 
          - `asset.core.framestyle03_scale9bg1` · bitmap 42×42 (framebg.swf)
          - `asset.core.framestyle03_scale9bg2` · bitmap 42×42 (framebg.swf)
          - `asset.core.framestyle03_scale9bg3` · bitmap 42×42 (framebg.swf)
          - `asset.core.framestyle03_scale9bg4` · bitmap 42×18 (framebg.swf)
          - `asset.core.framestyle03_scale9bg5` · bitmap 42×18 (framebg.swf)
          - `asset.core.framestyle03_scale9bg6` · bitmap 42×18 (framebg.swf)
          - `asset.core.framestyle03_scale9bg7` · bitmap 42×42 (framebg.swf)
          - `asset.core.framestyle03_scale9bg8` · bitmap 42×42 (framebg.swf)
          - `asset.core.framestyle03_scale9bg9` · bitmap 42×42 (framebg.swf)
      - `core.FrameTitleImage2` · Image width=229 height=17
        - `asset.core.frameTitleImage2` · bitmap 229×17 (framebg.swf)
  - _no style/symbol_: `core.DefaultFilter,core.LightFilter`
  - texts: `cell.view.starbag.StarBagCell.HigStarDragTips1` “Não se pode efetuar absorção entre 2 cosmos avançados”; `vicepassword.description11` “O Cosmo atual já foi bloqueado, favor desbloquear”; `cell.view.starbag.StarBagCell.tempStr` “{0} acrescentará {1} pontos de experiência”; `cell.view.starbag.StarBagCell.tempLevel` “, \nelevado ao Nv. {0}”; `public.confirm` “Confirmar”; `public.cancel` “Cancelar”; `public.prompt` “Aviso”; `cell.view.starbag.StarBagCell.HigStarDragTips3` “Este cosmo não contém cosmos avançados correspondentes”
  - subviews: `ConfirmSellFrame`

### cell.view.storebag.StoreBagCell

- **StoreBagCell** (`core_module:cell/view/storebag/StoreBagCell.as`)
  - `BattleGuardView.StoreBagCell` · StoreBagCell 
    - `core.FashionLevel` · ScaleFrameImage 
      - `asset.core.fashionLevelNormal` · bitmap 21×21 (core.swf)
      - `asset.core.fashionLevelSpecial` · bitmap 21×21 (core.swf)
    - `core.EquipActiveBack` · MovieImage x=-4 y=-4 width=53 height=52
      - `asset.core.EquipActiveBack` · sprite 44 frames (core.swf)
    - `core.ItemBack` · ScaleBitmapImage x=1 y=1 width=45 height=45 ← `core.goods.ItemBack`
    - `core.BaseItemViewIcon` · BaseIconView x=1 y=1
      - `asset.core.IconLoading` · sprite 42 frames (core2.swf)
    - `core.BaseItemText` · FilterFrameText x=0 y=26 width=45 height=18 font `Arial,12,0xffffff,true,,,,,right`
    - `core.GoodsProfileBG` · ScaleFrameImage 
      - `asset.core.BagProfileGreen` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileBlue` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfilePurple` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileOrange` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileRed` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileBlackKing` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileFashion` · bitmap 45×45 (core.swf)
    - `core.BagCellLock` · ScaleFrameImage 
      - `asset.core.BagCellLock` · bitmap 45×45 (core.swf)
      - `asset.core.BagCellUnLock` · bitmap 45×45 (core.swf)
    - `core.goods.Strengthen` · MovieImage x=-50 y=-50
      - `asset.core.goods.Strengthen` · Strengthen 

### cell.view.storebag.StoreCastCell

- **StoreCastCell** (`core_module:cell/view/storebag/StoreCastCell.as`)
  - `store.CastEquipItem` · StoreCastCell x=68 y=38
    - `store.CastEquipItemIcon` · BaseIconView x=5 y=5
    - `store.EquipBg` · Image x=1 y=1
      - `asset.store.EquipWordTxtImg` · bitmap x=3 y=18
        - `asset.store.EquipWordTxtImg` · bitmap 57×31 (store.swf)
    - `store.EquipTipFrameMc` · MovieImage x=-2 y=-3 width=75 height=75
      - `asset.core.EquipActiveBack` · sprite 44 frames (core.swf)
    - `core.goods.Strengthen` · MovieImage x=-50 y=-50
      - `asset.core.goods.Strengthen` · Strengthen 

### cell.view.storebag.StoreJewelCell

- **StoreJewelCell** (`core_module:cell/view/storebag/StoreJewelCell.as`)
  - `core.MoveButton` · TextButton x=0 y=0 ← `core.UseButton`
  - texts: `cell.view.storebag.jewelcombox` “Perfurar”; `public.confirm` “Confirmar”; `public.cancel` “Cancelar”; `public.prompt` “Aviso”; `cell.view.storebag.StoreJewelCell.content` “Retirar gema consumirá {0} ouro, continuar?”; `public.gold` “Ouro Insuficiente”

### cell.view.storebag.StoreMountCell

- **StoreMountCell** (`core_module:cell/view/storebag/StoreMountCell.as`)
  - `store.MountEquiItem` · StoreMountCell x=172 y=129
    - `store.MountEquiItemIcon` · BaseIconView x=5 y=5
    - `store.EquipBg` · Image x=1 y=1
      - `asset.store.EquipWordTxtImg` · bitmap x=3 y=18
        - `asset.store.EquipWordTxtImg` · bitmap 57×31 (store.swf)
    - `store.EquipTipFrameMc` · MovieImage x=-2 y=-3 width=75 height=75
      - `asset.core.EquipActiveBack` · sprite 44 frames (core.swf)
    - `core.goods.Strengthen` · MovieImage x=-50 y=-50
      - `asset.core.goods.Strengthen` · Strengthen 

### cell.view.storebag.StoreResolveCell

- **StoreResolveCell** (`core_module:cell/view/storebag/StoreResolveCell.as`)
  - `store.resolveEquiItem` · StoreResolveCell x=0 y=0
    - `store.resolveBack` · ScaleBitmapImage x=0 y=0 width=50 height=50
      - `asset.store.resolveEquipBg` · bitmap 
        - `asset.store.resolveEquipBg` · bitmap 50×50 (store.swf)
    - `store.resolveEquiItemIcon` · BaseIconView x=0 y=0
    - `store.resolveEquipBg` · Image x=1 y=15
      - `asset.store.resolveMaterialTxt` · bitmap 48×25 (store.swf)
    - `store.resolveEquipTipFrameMc` · MovieImage x=-2 y=-3 width=55 height=55
      - `asset.core.EquipActiveBack` · sprite 44 frames (core.swf)
    - `core.goods.Strengthen` · MovieImage x=-50 y=-50
      - `asset.core.goods.Strengthen` · Strengthen 
    - `core.BaseItemText` · FilterFrameText x=0 y=26 width=45 height=18 font `Arial,12,0xffffff,true,,,,,right`

### cell.view.storebag.StoreSwitchCell

- **StoreSwitchCell** (`core_module:cell/view/storebag/StoreSwitchCell.as`)
  - `store.switchEquiItem` · StoreSwitchCell x=143 y=32
    - `store.switchEquiItemIcon` · BaseIconView x=5 y=5
    - `store.GoodBg` · Image x=6 y=1
      - `asset.store.GoodWordTxtImg` · bitmap x=16 y=24
        - `asset.store.GoodWordTxtImg` · bitmap 32×18 (store.swf)
    - `store.EquipTipFrameMc` · MovieImage x=-2 y=-3 width=75 height=75
      - `asset.core.EquipActiveBack` · sprite 44 frames (core.swf)
    - `core.goods.Strengthen` · MovieImage x=-50 y=-50
      - `asset.core.goods.Strengthen` · Strengthen 
  - `store.resolveMaterialNumTxt` · FilterFrameText x=6 y=29 width=40 height=18 font `Arial,12,0xffffff,,,,,,right`

### chat.view.ChatBugleViewII

- **ChatBugleViewII** (`core_module:chat/view/ChatBugleViewII.as`)
  - `chatII.ChatBugleViewII` · ChatBugleViewII y=0
  - `asset.chatII.BigBugleIcon` · bitmap x=0 y=0
    - `asset.chatII.BigBugleIcon` · bitmap 18×15 (chat.swf)
  - `chatII.panel1` · ScrollPanel x=30 y=5 width=285 height=75
    - `chat.VScrollbar04` · Scrollbar width=5 height=40
      - `core.Scrollbar04_BackV` · ScaleBitmapImage width=15 height=24
        - `asset.core.scrollbar04_bgV` · bitmap 15×24 (core2.swf)
      - `core.Scrollbar04_StepV` · BaseButton width=16 height=36
        - `core.scrollbar04_stepAssetV` · ScaleBitmapImage width=16 height=36
          - `asset.core.scrollbar04_stepV` · bitmap 14×46 (core2.swf)
      - `core.Scrollbar04_Up` · BaseButton width=11 height=10
        - `asset.core.scrollbar04_up` · bitmap 11×10 (core2.swf)
      - `core.Scrollbar04_Down` · BaseButton width=11 height=10
        - `asset.core.scrollbar04_down` · bitmap 11×10 (core2.swf)
  - `chatII.flower.Image` · MutipleImage x=20 y=-18
    - `asset.chatII.marrySmallFlower` · bitmap 296×26 (chat.swf)
    - `chatII.marrySmallFlower.scaleX` · Image 
      - `asset.chatII.marrySmallFlower` · bitmap 296×26 (chat.swf)
  - `asset.chatII.marrySmallBackMc1` · sprite 28.1×28.1 46 frames (chat.swf)
  - `chatII.flower.Image` · MutipleImage x=20 y=-18
    - `asset.chatII.marrySmallFlower` · bitmap 296×26 (chat.swf)
    - `chatII.marrySmallFlower.scaleX` · Image 
      - `asset.chatII.marrySmallFlower` · bitmap 296×26 (chat.swf)
  - `asset.chatII.marrySmallBackMc1` · sprite 28.1×28.1 46 frames (chat.swf)
  - `asset.chatII.CrossBugleIcon1` · bitmap 23×22 (chat.swf)
  - `chatII.panel2` · ScrollPanel x=30 y=-75 width=285 height=35
    - `chat.VScrollbar04` · Scrollbar width=5 height=40
      - `core.Scrollbar04_BackV` · ScaleBitmapImage width=15 height=24
        - `asset.core.scrollbar04_bgV` · bitmap 15×24 (core2.swf)
      - `core.Scrollbar04_StepV` · BaseButton width=16 height=36
        - `core.scrollbar04_stepAssetV` · ScaleBitmapImage width=16 height=36
          - `asset.core.scrollbar04_stepV` · bitmap 14×46 (core2.swf)
      - `core.Scrollbar04_Up` · BaseButton width=11 height=10
        - `asset.core.scrollbar04_up` · bitmap 11×10 (core2.swf)
      - `core.Scrollbar04_Down` · BaseButton width=11 height=10
        - `asset.core.scrollbar04_down` · bitmap 11×10 (core2.swf)
  - `asset.chatII.CrossRoseMovie` · sprite (chat.swf)

### chat.view.ChatInputViewII

- **ChatInputViewII** (`core_module:chat/view/ChatInputViewII.as`)
  - `chatII.ChatInputViewII` · ChatInputViewII y=0
  - `chatII.ChatInputBack1` · ScaleBitmapImage width=320 height=34 ← `core.describeBackground_style04`
  - `chatII.ChatInputBack2` · ScaleBitmapImage x=80 y=4 width=192 height=26
    - `asset.chatII.Inputback` · bitmap 324×26 (chat.swf)
  - `chatII.InputChannelBtn` · ChatPanelButton x=6 y=4 width=70 height=26
    - `chatII.InputChannelBack` · ScaleFrameImage width=59 height=24
      - `asset.chatII.ChatPanelUp` · bitmap 59×24 (chat.swf)
      - `asset.chatII.ChatPanelOver` · bitmap 59×24 (chat.swf)
      - `asset.chatII.ChatPanelOver` · bitmap 59×24 (chat.swf)
      - `asset.chatII.ChatPanelUp` · bitmap 59×24 (chat.swf)
    - `chatII.InputChanelTxt` · FilterFrameText width=70 height=22 font `Arial,12,0xffffff,,,,,,center`
  - `chatII.ChatInputFriendsBtn` · SelectedButton x=268 y=5 width=19 height=26
    - `asset.chatII.FriendBtnBack` · bitmap 19×26 (chat.swf)
    - `asset.chatII.FriendBtnBack` · bitmap 19×26 (chat.swf)
  - `chatII.ChatSendBtn` · BaseButton x=244 y=10
    - `asset.chatII.SendBtnBack` · bitmap 25×19 (chat.swf)
  - `chatII.ChatExpressionBtn` · BaseButton x=273 y=9
    - `asset.chatII.ExpressionBtnAsset` · bitmap 22×18 (chat.swf)
  - `chatII.ChatCleanBtn` · BaseButton x=295 y=6
    - `asset.chatII.CleanBtnBack` · bitmap 21×26 (chat.swf)
  - `chatII.InPutTxt` · FilterFrameText x=84 y=7 width=158 height=20
  - `quickbuy.buyFrame` · BuyFrameI width=286 ← `core.QuickBuyFrame`
  - texts: `chat.view.ChatView.command06` “Emoticon”; `chat.view.ChatView.command02` “Limpar”; `chat.view.ChatInputView.command06` “Não há acessório correspondente, essa função não pode ser ut”
  - subviews: `ChatPanelButton`, `ExpressionList`, `InputChannelList`, `BuyFrameI`

### chat.view.ChatItemMenu

- **ChatItemMenu** (`core_module:chat/view/ChatItemMenu.as`)
  - `core.commonTipBg` · ScaleBitmapImage width=435
    - `asset.core.describeBackground_style07` · bitmap 260×82 (core2.swf)
  - `ChatItemMenu.VBox` · VBox x=4 y=3 width=88
  - `chatII.chatMessageSelectBtn` · TextButton x=0 y=2 width=103 height=23
    - `chatII.ItemMenuPanelSelectBtnBack` · ScaleFrameImage 
      - `asset.chatII.PanelSelectedUpBack` · sprite 86.95×16.95 (chat.swf)
      - `asset.chatII.FriendListCellback` · bitmap 144×21 (chat.swf)
      - `asset.chatII.FriendListCellback` · bitmap 144×21 (chat.swf)
      - `asset.chatII.PanelSelectedUpBack` · sprite 86.95×16.95 (chat.swf)
    - `chatII.ItemMenuText` · FilterFrameText x=0 y=0 width=103 height=23 font `Arial,12,0xdcb55c`
  - `chatII.addfriendSelectBtn` · TextButton y=25 ← `chatII.chatMessageSelectBtn`
  - `chatII.copyNameSelectBtn` · TextButton y=50 ← `chatII.chatMessageSelectBtn`
  - `chatII.blacklistSelectBtn` · TextButton y=75 ← `chatII.chatMessageSelectBtn`
  - `chatII.messageSelectBtn` · TextButton y=100 ← `chatII.chatMessageSelectBtn`
  - `chatII.consortiaSelectBtn` · TextButton y=125 ← `chatII.chatMessageSelectBtn`
  - `chatII.consortiaSelectBtn` · TextButton y=125 ← `chatII.chatMessageSelectBtn`
  - `chatII.consortiaSelectBtn` · TextButton y=125 ← `chatII.chatMessageSelectBtn`
  - `chatII.proposeBtn` · TextButton y=150 ← `chatII.chatMessageSelectBtn`
  - `chatII.applyJoinBtn` · TextButton y=175 ← `chatII.chatMessageSelectBtn`
  - `chatII.pkBtn` · TextButton y=200 ← `chatII.chatMessageSelectBtn`
  - texts: `chatII.view.ChatItemMenu.chatMessageText` “Privado”; `chatII.view.ChatItemMenu.addfriendText` “Adicionar amigo”; `chatII.view.ChatItemMenu.copyNametext` “Copiar Nome”; `chatII.view.ChatItemMenu.blacklistText` “Lista Negra”; `chatII.view.ChatItemMenu.messageText` “Ver Informações”; `chatII.view.ChatItemMenu.consortiaBtnText` “Convite de Guilda”; `ChatItemMenu.attack` “Atacar”; `yishi.view.PlayerMenu.invite` “Convidar para a Equipe”

### chat.view.ChatOutputViewII

- **ChatOutputViewII** (`core_module:chat/view/ChatOutputViewII.as`)
  - `chatII.ChatOutputViewII` · ChatOutputViewII y=0
  - `chat.ChatList` · ScrollPanel x=7 y=0 width=290 height=132
    - `chatII.ChatOutputScrollbar` · Scrollbar x=5 y=3 height=102 ← `core.VScrollbar03`
  - `chatII.ChatOutputChannelBox` · HBox x=7 y=124
  - `chatII.ChatOutputBack` · ScaleBitmapImage x=5 y=-2 width=322 height=195
    - `asset.chatII.ChatBackBg` · bitmap 20×20 (chat.swf)
  - `chatII.ChatOutputAllBtn` · SelectedCheckButton 
    - `chatII.ChatOututChannelBtn1` · BaseButton 
      - `chatII.ChatOututChannelBack1` · ScaleFrameImage 
        - `asset.chatII.OutputChannelBack1` · bitmap 51×20 (chat.swf)
        - `asset.chatII.OutputChannelBack2` · bitmap 52×20 (chat.swf)
        - `asset.chatII.OutputChannelBack2` · bitmap 52×20 (chat.swf)
        - `asset.chatII.OutputChannelBack2` · bitmap 52×20 (chat.swf)
    - `chatII.ChatOututChannelBtn2` · BaseButton 
      - `asset.chatII.OutputChannelBack3` · bitmap 52×20 (chat.swf)
    - `chatII.ChatOutputChannelText` · FilterFrameText y=1 width=54 height=20 font `Arial,12,0xecdfa1,,,,,,center`
  - `chatII.ChatOutputWorldBtn` · SelectedCheckButton  ← `chatII.ChatOutputAllBtn`
    - `chatII.ChatOutputChannelText` · FilterFrameText y=1 width=54 height=20 font `Arial,12,0xecdfa1,,,,,,center`
  - `chatII.ChatOutputOutyardBtn` · SelectedCheckButton  ← `chatII.ChatOutputWorldBtn`
  - `chatII.ChatOutputTeamBtn` · SelectedCheckButton  ← `chatII.ChatOutputWorldBtn`
  - `chatII.ChatOutputConsortiaBtn` · SelectedCheckButton  ← `chatII.ChatOutputWorldBtn`
    - `asset.chatII.ChatOutputChannelText` · ChatOutputChannelText x=0 y=0
  - `chatII.ChatOutputInfoBtn` · SelectedCheckButton  ← `chatII.ChatOutputWorldBtn`
  - `chatII.ChatOutputToBottomBtn` · BaseButton 
    - `asset.chatII.ChatOutputToBottomBtn` · bitmap 16×16 (chat.swf)
  - `chatII.BattlechatClean` · BaseButton x=288 y=130
    - `asset.chatII.BattleChatCleanBtn` · bitmap 26×20 (chat.swf)
  - `chatII.DownShineEffect` · TaskRewardButtonMc1 x=-58 y=85
  - texts: `chatII.view.ChatOutputViewII.toBottomBtn.tip` “Final”; `chat.view.ChatView.command02` “Limpar”; `chatII.datas.getChatChannelName.AllChannel` “Todos”; `chatII.datas.getChatChannelName.WorldChannel` “Global”; `chatII.datas.getChatChannelName.OutyardChannel` “Terralém”; `chatII.datas.getChatChannelName.TeamChannel` “Equipe”; `chatII.datas.getChatChannelName.consortiaChannel` “Guilda”; `chatII.datas.getChatChannelName.InfoChannel` “MSG”
  - subviews: `TaskRewardButtonMc1`, `ChatItemMenu`, `VBox`, `ChatEquipTips`, `ChatFashionTips`, `ChatMonsterAccesoriesTips`, `ChatStarTip`, `MountCardTip`, `PropTips`, `RuneTip`

### chat.view.ChatPanelButton

- **ChatPanelButton** (`core_module:chat/view/ChatPanelButton.as`)
  - `chatII.InputChannelBtn` · ChatPanelButton x=6 y=4 width=70 height=26
    - `chatII.InputChannelBack` · ScaleFrameImage width=59 height=24
      - `asset.chatII.ChatPanelUp` · bitmap 59×24 (chat.swf)
      - `asset.chatII.ChatPanelOver` · bitmap 59×24 (chat.swf)
      - `asset.chatII.ChatPanelOver` · bitmap 59×24 (chat.swf)
      - `asset.chatII.ChatPanelUp` · bitmap 59×24 (chat.swf)
    - `chatII.InputChanelTxt` · FilterFrameText width=70 height=22 font `Arial,12,0xffffff,,,,,,center`

### chat.view.ChatPopView

- **ChatPopView** (`core_module:chat/view/ChatPopView.as`)
  - `chatII.ChatPopAsset` · ScaleUpDownImage width=170 height=42
    - `asset.chatII.ChatPopToprAsset` · bitmap 170×11 (chat.swf)
    - `asset.chatII.ChatPopCenterAsset` · bitmap 170×3 (chat.swf)
    - `asset.chatII.ChatPopBottomAsset` · bitmap 170×28 (chat.swf)
  - subviews: `ExpressionChatNotic`

### chat.view.ChatTopBugleView

- **ChatTopBugleView** (`core_module:chat/view/ChatTopBugleView.as`)
  - `chatII.BugleBg` · ScaleFrameImage x=-10
    - `chatII.NormalBugleBg` · ScaleBitmapImage width=650 height=45
      - `asset.chatII.NormalBugleBg` · bitmap 
        - `asset.chatII.NormalBugleBg` · bitmap 100×28 (chat.swf)
    - `asset.chatII.RoseBugleBg` · bitmap 650×42 (chat.swf)
    - `chatII.WarlordsBugleBg` · ScaleBitmapImage x=41 y=-11 width=610
      - `asset.chatII.WarlordsBugleBg` · bitmap 507×67 (chat.swf)
    - `chatII.CrossBugleBg` · ScaleBitmapImage x=50 width=600 height=50
      - `asset.chatII.CrossBugleBg` · bitmap 516×53 (chat.swf)
    - `chatII.marryBugleBg` · MutipleImage x=50 y=-10
      - `asset.chatII.marryBack` · bitmap 682×50 (chat.swf)
      - `asset.chatII.marryBigFlower` · bitmap 689×71 (chat.swf)
    - `chatII.WORLDMAPLIGHTBg` · WORLDMAPLIGHTBg 
    - `chatII.SnowRoseBugleBg` · ScaleBitmapImage x=-35 y=-15 width=715
      - `asset.chatII.SnowRoseBugleBg` · bitmap 755×76 (chat.swf)
    - `chatII.RoseCross` · Image height=60
      - `asset.chatII.RoseCrossBg` · bitmap 737×60 (chat.swf)
  - `chatII.BugleIcon` · ScaleFrameImage x=0 y=-3
    - `asset.chatII.BugleIcon` · bitmap x=0 y=-3
      - `asset.chatII.BugleIcon` · bitmap 61×53 (chat.swf)
    - `asset.chatII.MarryBugleIcon1` · bitmap 60×60 (chat.swf)
    - `asset.chatII.MarryBugleIcon2` · bitmap 60×60 (chat.swf)
    - `asset.chatII.CrossBugleIcon2` · bitmap x=0 y=-3
      - `asset.chatII.CrossBugleIcon2` · bitmap 61×53 (chat.swf)
  - `chatII.RoseLaceImg` · MutipleImage 
    - `asset.core.LaceStyle04` · bitmap 98×24 (chat.swf)
    - `asset.core.LaceStyle02` · bitmap 100×39 (chat.swf)
    - `asset.core.LaceStyle03` · bitmap 187×39 (chat.swf)
    - `chatII.LaceStyle01` · Image 
      - `asset.core.LaceStyle01` · bitmap 81×26 (chat.swf)
    - `chatII.LaceStyle02` · Image 
      - `asset.core.LaceStyle02` · bitmap 100×39 (chat.swf)
  - `chatII.BugleViewText` · FilterFrameText x=68 y=30 width=540 height=40 font `Arial,14,0x00d8ff`
  - `asset.wedding.flower2` · sprite 105.0×105.0 50 frames (wedding.swf)
  - texts: `chatII.view.ChatTopBugleView.useBigHorn` “anunciou com megafone:”; `chatII.view.ChatTopBugleView.useCrossHorn` “Utilizar Megafone Inter-S”
  - subviews: `ExpressionChatNotic`

### chat.view.ExpressionItem

- **ExpressionItem** (`core_module:chat/view/ExpressionItem.as`)
  - `asset.chatII.ExpressionSelected` · bitmap x=0 y=0
    - `asset.chatII.ExpressionSelected` · bitmap 28×28 (chat.swf)
  - _no style/symbol_: `chatII.Expression`

### chat.view.ExpressionList

- **ExpressionList** (`core_module:chat/view/ExpressionList.as`)
  - `chatII.ExpressionList.ExpressionPanelBg` · Scale9CornerImage width=285 height=141
    - `asset.chatII.ExpressionPanelBg1` · bitmap 30×30 (chat.swf)
    - `asset.chatII.ExpressionPanelBg2` · bitmap 30×30 (chat.swf)
    - `asset.chatII.ExpressionPanelBg3` · bitmap 30×30 (chat.swf)
    - `asset.chatII.ExpressionPanelBg4` · bitmap 30×30 (chat.swf)
    - `asset.chatII.ExpressionPanelBg5` · bitmap 30×30 (chat.swf)
    - `asset.chatII.ExpressionPanelBg6` · bitmap 30×30 (chat.swf)
    - `asset.chatII.ExpressionPanelBg7` · bitmap 30×30 (chat.swf)
    - `asset.chatII.ExpressionPanelBg8` · bitmap 30×30 (chat.swf)
    - `asset.chatII.ExpressionPanelBg9` · bitmap 30×30 (chat.swf)
  - `chatII.ExpressionList.ExpressionCutOffRule` · MutipleImage x=7 y=7
    - `asset.chatII.ExpressionCutOffRule` · bitmap x=7 y=7
      - `asset.chatII.ExpressionCutOffRule` · bitmap 136×109 (chat.swf)
    - `asset.chatII.ExpressionCutOffRule` · bitmap x=7 y=7
      - `asset.chatII.ExpressionCutOffRule` · bitmap 136×109 (chat.swf)
  - `chatII.ExpressionList.NameTxt` · FilterFrameText x=7 y=118 font `Arial,12,0xc1c1c1,,,,,,left`
  - subviews: `ExpressionItem`

### chat.view.InputChannelList

- **InputChannelList** (`core_module:chat/view/InputChannelList.as`)
  - `core.commonTipBg` · ScaleBitmapImage width=435
    - `asset.core.describeBackground_style07` · bitmap 260×82 (core2.swf)
  - `chatII.PanelBugleSelectBtn` · TextButton y=5 ← `chatII.PanelWorldSelectBtn`
    - `chatII.BugleText` · FilterFrameText x=88 y=9 width=75 height=18 font `Arial,12,0x00d8ff`
  - `chatII.PanelWorldSelectBtn` · TextButton x=7 y=25 width=80 height=16
    - `chatII.PanelSelectBtnBack` · ScaleFrameImage 
      - `asset.chatII.PanelSelectedUpBack` · sprite 86.95×16.95 (chat.swf)
      - `asset.chatII.PanelSelectedBack` · bitmap 87×17 (chat.swf)
      - `asset.chatII.PanelSelectedBack` · bitmap 87×17 (chat.swf)
      - `asset.chatII.PanelSelectedBack` · bitmap 87×17 (chat.swf)
    - `chatII.WorldText` · FilterFrameText x=88 y=9 width=70 height=18 font `Arial,12,0xeb9504`
  - `chatII.PanelOutyardSelectBtn` · TextButton x=7 y=25 width=80 height=16
    - `chatII.PanelSelectBtnBack` · ScaleFrameImage 
      - `asset.chatII.PanelSelectedUpBack` · sprite 86.95×16.95 (chat.swf)
      - `asset.chatII.PanelSelectedBack` · bitmap 87×17 (chat.swf)
      - `asset.chatII.PanelSelectedBack` · bitmap 87×17 (chat.swf)
      - `asset.chatII.PanelSelectedBack` · bitmap 87×17 (chat.swf)
    - `chatII.OutyardText` · FilterFrameText x=88 y=9 width=70 height=18 font `Arial,12,0xeb9504`
  - `chatII.PanelTeamSelectBtn` · TextButton y=45 ← `chatII.PanelWorldSelectBtn`
    - `chatII.TeamText` · FilterFrameText  font `Arial,12,0x939dff`
  - `chatII.PanelConsortiaSelectBtn` · TextButton y=65 ← `chatII.PanelWorldSelectBtn`
    - `chatII.ConsortiaText` · FilterFrameText  font `Arial,12,0x4cd551`
  - `chatII.PanelCurrentSelectBtn` · TextButton y=85 ← `chatII.PanelWorldSelectBtn`
    - `chatII.CurrentText` · FilterFrameText  font `Arial,12,0xffffff`
  - texts: `chatII.view.InputChannelList.BugleBtnText` “/D Megafone”; `chatII.view.InputChannelList.WorldBtnText` “/X  Global”; `chatII.view.InputChannelList.OutyardBtnText` “/W Terralém”; `chatII.view.InputChannelList.TeamBtnText` “/P  Equipe”; `chatII.view.InputChannelList.ConsortiaBtnText` “/G  Guilda”; `chatII.view.InputChannelList.CurrentBtnText` “/A   Atual”

### dialog.DialogWordView

- **DialogWordView** (`core_module:dialog/DialogWordView.as`)
  - `core.novice.DialogText` · FilterFrameText width=420 height=100 font `Arial,16,0xFFFFCB`
  - `core.novice.DialogNameText` · FilterFrameText width=400 height=50 font `Arial,22,0xFFD200`
  - `asset.novice.GuardImage` · bitmap 
    - `asset.novice.GuardImage` · bitmap 55×55 (novice.swf)
  - texts: `public.nickName` “Herói”
  - subviews: `SplitTextField`

### dialog.view.DialogView

- **DialogView** (`core_module:dialog/view/DialogView.as`)
  - `core.novice.DialogUpBg` · ScaleBitmapImage 
    - `asset.core.novice.dialogUPImg` · bitmap 400×15 (core.swf)
  - `core.novice.DialogBg` · ScaleBitmapImage 
    - `asset.core.novice.dialogImg` · bitmap 100×140 (core.swf)
  - `core.novice.ContinueBtnMc` · ContinueBtn 
  - texts: `dialog.view.DialogView.continueBtn.Text` “Clique para continuar({0})”
  - subviews: `ContinueBtn`, `DialogWordView`, `DialogRoleImage`

### dialog.view.SplitePointFrame

- **SplitePointFrame**: “Oferta de diamantes” (`core_module:dialog/view/SplitePointFrame.as`)
  - `core.SplitePointFrame` · SplitePointFrame  ← `core.SpliteItemFrame`
  - `asset.core.SpliteInputBack` · bitmap x=82 y=11
    - `asset.core.SpliteInputBack` · bitmap 151×26 (core.swf)
  - `core.ConfirmBtn` · TextButton x=70 y=48 ← `core.NewAlertButton`
  - `asset.core.InputAlertTextStyle` · bitmap x=-17 y=5
    - `asset.core.InputAlertTextStyle` · bitmap 96×36 (core.swf)
  - `splitePointFrame.InputTextStyle` · FilterFrameText  ← `core.InputTextStyle`
  - texts: `dialog.view.SplitePointFrame.title` “Oferta de diamantes”; `public.confirm` “Confirmar”

### farm.cell.FarmBagCell

- **FarmBagCell** (`core_module:farm/cell/FarmBagCell.as`)
  - `farm.FarmBagCell` · FarmBagCell 
    - `core.ItemBack` · ScaleBitmapImage x=1 y=1 width=45 height=45 ← `core.goods.ItemBack`
    - `farm.FarmBagCellIcon` · BaseIconView x=0 y=0
      - `asset.core.IconLoading` · sprite 42 frames (core2.swf)
    - `core.BaseItemText` · FilterFrameText x=0 y=26 width=45 height=18 font `Arial,12,0xffffff,true,,,,,right`
    - `farm.FarmBagCellProfileBG` · ScaleFrameImage x=1 y=1 ← `core.GoodsProfileBG`
    - `core.goods.Strengthen` · MovieImage x=-50 y=-50
      - `asset.core.goods.Strengthen` · Strengthen 

### farm.view.FarmAnimalArea

- **FarmAnimalArea** (`core_module:farm/view/FarmAnimalArea.as`)
  - `PastureView.lineArea` · lineArea x=295 y=255
  - `farm.FarmAnimalItem` · FarmAnimalItem 
  - subviews: `FarmAnimalItem`

### farm.view.FarmAnimalItem

- **FarmAnimalItem** (`core_module:farm/view/FarmAnimalItem.as`)
  - `farm.FarmAnimalItem` · FarmAnimalItem 
  - `farm.AnimalHasOperEffect` · AnimalHasOperEffect x=-20 y=-75
  - `asset.farm.farmanimalitem.HungerImg` · bitmap 32×32 (farm.swf)
  - `asset.farm.farmanimalitem.AnxietyImg` · bitmap 32×32 (farm.swf)
  - `asset.farm.farmanimalitem.IllImg` · bitmap 32×32 (farm.swf)
  - `asset.farm.farmanimalitem.HarvestImg` · bitmap 32×32 (farm.swf)
  - `farm.FarmAnimalItem.AnimalContent` · Component 
  - `farm.ExpEffect` · ExpEffect x=69 y=-50
  - `farm.FarmExp` · TextFormat 
  - texts: `farm.view.FarmLandItem.outStealCountTip` “Falha ao coletar, limite de colheitas atingida”; `farm.view.FarmLandItem.farmExpFull` “Experiência da fazenda atingiu limite máximo”; `farm.view.FarmLandItem.dayGpFull` “Limite de experiência em fazenda de amigos atingido”; `farm.view.FarmLandItem.farmExp` “Experiência da fazenda”; `farm.view.FarmLandItem.accelerateSucceed` “Aceleração sucedida”
  - subviews: `FarmOperMenu`

### farm.view.FarmLandItem

- **FarmLandItem** (`core_module:farm/view/FarmLandItem.as`)
  - `farm.FarmLandItem` · FarmLandItem 
  - `farm.LandItemBack` · LandItemBack x=0 y=0
  - `farm.FarmLandItemCropIcon` · BaseIconView x=13 y=-22
    - `asset.core.IconLoading` · sprite 42 frames (core2.swf)
  - `asset.farm.FarmLandItemGrassImg` · bitmap x=-2 y=-3
    - `asset.farm.FarmLandItemGrassImg` · bitmap 39×36 (farm.swf)
  - `asset.farm.FarmLandItemGrassImgII` · bitmap 
    - `asset.farm.FarmLandItemGrassImgII` · bitmap 108×64 (farm.swf)
  - `asset.farm.FarmLandItemWormImg` · bitmap x=1 y=-7
    - `asset.farm.FarmLandItemWormImg` · bitmap 34×35 (farm.swf)
  - `asset.farm.FarmLandItemPickImg` · bitmap x=1 y=-2
    - `asset.farm.FarmLandItemPickImg` · bitmap 31×29 (farm.swf)
  - `farm.HasOperEffect` · HasOperEffect x=41 y=20
  - `farm.ExpEffect` · ExpEffect x=69 y=-50
  - `farm.MatureEffect` · MatureEffect x=46 y=0
  - `farm.LandItem.hitMc` · LandItemHitArea x=0 y=0
  - `farm.FarmExp` · TextFormat 
  - texts: `farm.view.FarmLandItem.outStealCountTip` “Falha ao coletar, limite de colheitas atingida”; `farm.view.FarmOperMenu.clearTip` “Ao remover não poderá coletar os ganhos, continuar?”; `farm.view.FarmOperMenu.DieClearTip` “Ao remover não poderá coletar os ganhos, amigo pode ressusci”; `public.prompt` “Aviso”; `public.confirm` “Confirmar”; `public.cancel` “Cancelar”; `farm.view.FarmLandItem.goldLimitTip` “Ouro atingiu limite de armazenamento, não é possível coletar”; `farm.view.FarmLandItem.farmExpFull` “Experiência da fazenda atingiu limite máximo”
  - subviews: `FarmOperMenu`, `BaseIconView`

### farm.view.FarmOperMenu

- **FarmOperMenu** (`core_module:farm/view/FarmOperMenu.as`)
  - `farm.FarmLandItemAccelerateBtn` · IconButton x=10 y=-25
    - `asset.farm.OperTipBgSmall` · bitmap 38×37 (farm.swf)
    - `asset.farm.FarmLandItemAccelerateBtnImg` · bitmap 27×27 (farm.swf)
  - `farm.FarmAnimalItemSaleBtn` · IconButton x=60 y=-25 ← `farm.FarmLandItemAccelerateBtn`
    - `asset.farm.farmanimalitem.SaleImg` · bitmap 27×27 (farm.swf)
  - `farm.FarmLandItemClearBtn` · IconButton x=50 y=-25 ← `farm.FarmLandItemAccelerateBtn`
    - `asset.farm.FarmLandItemClearBtnImg` · bitmap 32×34 (farm.swf)
  - texts: `farm.view.FarmOperMenu.accelerate` “Acelerar”; `farm.view.FarmOperMenu.hasAccelerateTip` “Falha ao acelerar, colheita já foi acelerada”; `farm.view.FarmOperMenu.hasanimalAccelerateTip` “falha ao acelerar, a velocidade de criação do animal já foi ”; `farm.view.FarmOperMenu.accelerateTip` “Aceleraração de 50% do tempo de crescimento da colheita cons”; `farm.view.FarmOperMenu.animalccelerateTip` “para acelerar a velocidade de criação do animal por 50% prec”; `public.prompt` “Aviso”; `public.confirm` “Confirmar”; `public.cancel` “Cancelar”

### farm.view.FarmPetListItemView

- **FarmPetListItemView** (`core_module:farm/view/FarmPetListItemView.as`)
  - `farm.FarmPetListItemView` · FarmPetListItemView 
  - `FarmPetListItemView.HeadBorder` · ScaleBitmapImage x=0 y=0 width=56 height=56
    - `core.shop.goodsItemBack2` · bitmap 
      - `core.shop.goodsItemBack2` · bitmap 60×60 (core.swf)
  - `FarmPetListItemView.HeadIcon` · BaseIconView x=3 y=3
    - `asset.core.IconLoading` · sprite 42 frames (core2.swf)
  - `FarmPetListItemView.Back` · ScaleBitmapImage x=51 y=0 width=164 height=56 ← `core.describeBackground_style04`
  - `FarmPetListItemView.Line` · ScaleBitmapImage x=44 y=29 width=138
    - `asset.core.tipsLineImg` · bitmap 
      - `asset.core.tipsLineImg` · bitmap 242×1 (core2.swf)
  - `FarmPetListItemView.MouseOver` · Scale9CornerImage x=-5 y=-9 width=225 height=72 ← `shop.MouseOver1`
  - `farm.PetNameTxt` · FilterFrameText x=65 y=8 width=150 height=22 font `Arial,12,0xffffff`
  - `farm.PetLvTxt` · FilterFrameText x=65 y=30 width=25 height=22 font `Arial,12,0xfffbe2,true,,,,,left`
  - `farm.PetGradeTxt` · FilterFrameText x=80 y=30 width=25 height=22 font `Arial,12,0xfffbe2,true,,,,,left`
  - `acution.BagCell` · AuctionSellBagCell 
    - `core.ItemBack` · ScaleBitmapImage x=1 y=1 width=45 height=45 ← `core.goods.ItemBack`
    - `acution.BagCellIcon` · BaseIconView x=0 y=0
      - `asset.core.IconLoading` · sprite 42 frames (core2.swf)
    - `core.BaseItemText` · FilterFrameText x=0 y=26 width=45 height=18 font `Arial,12,0xffffff,true,,,,,right`
    - `auction.ProfileBG` · ScaleFrameImage x=1 y=1 ← `core.GoodsProfileBG`
    - `core.goods.Strengthen` · MovieImage x=-50 y=-50
      - `asset.core.goods.Strengthen` · Strengthen 
  - `asset.pet.StarLevelLightImg` · bitmap 18×17 (core.swf)
  - `asset.pet.bigMoonLightLevelImg` · bitmap 18×17 (core.swf)
  - subviews: `AuctionSellBagCell`, `HBox`, `BaseIconView`

### feedback.FeedBackFrame

- **FeedBackFrame**: “Feedback de Pacote de Recarga” (`core_module:feedback/FeedBackFrame.as`)
  - `feedback.FeedBackFrame` · FeedBackFrame width=775 height=507 ← `core.Frame1`
  - `feedBackFrame.back1` · Scale9CornerImage x=-8 y=-16 width=738 height=400 ← `core.describeBackground_style27`
  - `feedBackFrame.back2` · Scale9CornerImage x=0 y=0 width=723 height=270 ← `core.describeBackground_style26`
  - `asset.feedback.titleBack` · bitmap x=0 y=154
    - `asset.feedback.titleBack` · bitmap 710×30 (feedback.swf)
  - `asset.feedback.priceNumber` · bitmap 220×26 (feedback.swf)
  - `asset.feedback.progress1` · bitmap x=0 y=333
    - `asset.feedback.progress1` · bitmap 488×27 (feedback.swf)
  - `feedBackFrame.giftTitle` · FilterFrameText x=9 y=159 width=400 height=20 font `Arial,14,0xf9ed68,true,,,,,left`
  - `feedBackFrame.remainTimeText` · FilterFrameText x=170 y=280 width=160 height=25 font `Arial,16,0xee1919,true,,,,,left`
  - `asset.feedback.timeDownImage` · bitmap x=10 y=282
    - `asset.feedback.timeDownImage` · bitmap 169×24 (feedback.swf)
  - `feedBackFrame.describeText` · FilterFrameText x=12 y=298 width=500 height=40 font `Arial,14,0x66db17,,,,,,left`
  - `feedBackFrame.priceIcon` · ScaleFrameImage x=525 y=150
    - `asset.feedback.priceBack1` · bitmap 168×66 (feedback.swf)
    - `asset.feedback.priceBack2` · bitmap 210×72 (feedback.swf)
  - `feedBackFrame.chargeBtn` · IconButton x=540 y=312 width=167 height=52
    - `asset.feedback.payBack` · bitmap 167×52 (feedback.swf)
    - `asset.feedback.payIcon` · bitmap 93×27 (feedback.swf)
  - `feedBackFrame.Progress` · Progress 
  - `asset.feedback.goodsBack` · bitmap x=26 y=36
    - `asset.feedback.goodsBack` · bitmap 56×56 (feedback.swf)
  - `feedBackFrame.BaseItemView` · BaseItemView x=0 y=0
    - `feedBackFrame.ItemBaseItemViewIcon` · BaseIconView x=1 y=1
      - `asset.core.IconLoading` · sprite 42 frames (core2.swf)
    - `core.GoodsProfileBG` · ScaleFrameImage 
      - `asset.core.BagProfileGreen` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileBlue` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfilePurple` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileOrange` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileRed` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileBlackKing` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileFashion` · bitmap 45×45 (core.swf)
    - `feedBackFrame.BaseItemText` · FilterFrameText x=0 y=33 width=52 height=18 ← `core.BaseItemText`
  - `feedback.LightEffect` · MovieImage x=27 y=-27
    - `asset.feedback.LightEffect` · sprite 18 frames (feedback.swf)
  - `asset.feedback.progress2` · bitmap 467×15 (feedback.swf)
  - `progress.text` · FilterFrameText x=128 y=-2 width=210 height=20 font `Arial,14,0xfff6d9,true,,,,,center`
  - texts: `feedback.FeedBackFrame.describeText02` “Parabéns ao obter qualificação para coletar todos os pacotes”; `feedback.FeedBackFrame.describeText03` “Ainda falta recarregar  {0} diamantes para poder coletar pac”; `feedback.FeedBackFrame.giftTitle` “Conteúdo do Pacote de {0} Diamantes”; `feedback.FeedBackFrame.title` “Feedback de Pacote de Recarga”
  - subviews: `HBox`, `FeedBackItem`, `Progress`, `BaseItemView`

### feedback.FeedBackItem

- **FeedBackItem** (`core_module:feedback/FeedBackItem.as`)
  - `feedBackItem.selectedBack` · ScaleBitmapImage x=0 y=0 width=110 height=147
    - `asset.feedback.selectedBack` · bitmap 161×98 (feedback.swf)
  - `feedBackItem.back` · ScaleFrameImage x=6 y=6
    - `asset.feedback.itemback1` · bitmap 97×135 (feedback.swf)
    - `asset.feedback.itemback2` · bitmap 97×135 (feedback.swf)
  - `feedBackItem.title` · FilterFrameText x=7 y=4 width=96 height=36 font `Arial,11,0xefd89b,,,,,,center`
  - `feedBackItem.giftImage` · ScaleFrameImage x=29 y=39
    - `asset.feedback.iconImage_1` · bitmap 50×50 (feedback.swf)
    - `asset.feedback.iconImage_2` · bitmap 50×50 (feedback.swf)
    - `asset.feedback.iconImage_3` · bitmap 50×50 (feedback.swf)
    - `asset.feedback.iconImage_4` · bitmap 50×50 (feedback.swf)
    - `asset.feedback.iconImage_5` · bitmap 50×50 (feedback.swf)
    - `asset.feedback.iconImage_6` · bitmap 50×50 (feedback.swf)
    - `asset.feedback.iconImage_7` · bitmap 50×50 (feedback.swf)
  - `feedBackItem.getBtn` · IconButton x=9 y=96 width=90 height=34
    - `asset.feedback.getBack` · bitmap 90×34 (feedback.swf)
    - `asset.feedback.getIcon` · bitmap 63×17 (feedback.swf)
  - `asset.feedback.goodsBack` · bitmap x=26 y=36
    - `asset.feedback.goodsBack` · bitmap 56×56 (feedback.swf)
  - `asset.core.ReceivedImg` · bitmap x=0 y=0
    - `asset.core.ReceivedImg` · bitmap 99×68 (core.swf)
  - texts: `feedback.FeedBackItem.outDate` “Evento expirado”; `feedback.FeedBackItem.title01` “Recarregue qualquer valor”; `feedback.FeedBackItem.title02` “Recarregue {0} diamantes”

### feedback.Progress

- **Progress** (`core_module:feedback/Progress.as`)
  - `feedBackFrame.Progress` · Progress 

### fund.FundItem

- **FundItem** (`core_module:fund/FundItem.as`)
  - `fund.itemnumTxt` · FilterFrameText  font `Arial,14,0x00effe,,,,,,right`
  - `fund.deedImg` · ScaleBitmapImage 
    - `asset.fund.deed` · bitmap 21×20 (fund.swf)
  - `fund.DropItem` · BaseItemView 
    - `fund.DropItemIcon` · BaseIconView x=1 y=1
      - `asset.core.IconLoading` · sprite 42 frames (core2.swf)
    - `core.GoodsProfileBG` · ScaleFrameImage 
      - `asset.core.BagProfileGreen` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileBlue` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfilePurple` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileOrange` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileRed` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileBlackKing` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileFashion` · bitmap 45×45 (core.swf)
  - `fund.diamondImg` · ScaleFrameImage 
    - `asset.core.SmallPointImg` · bitmap x=0
      - `asset.core.SmallPointImg` · bitmap 23×21 (bottle.swf)
    - `asset.fund.bindPoint` · bitmap 25×21 (fund.swf)
  - `fund.itemnumTxt_2` · FilterFrameText width=60 height=20 ← `fund.itemnumTxt`
  - `fund.deedImg` · ScaleBitmapImage 
    - `asset.fund.deed` · bitmap 21×20 (fund.swf)
  - `fund.DropItem` · BaseItemView 
    - `fund.DropItemIcon` · BaseIconView x=1 y=1
      - `asset.core.IconLoading` · sprite 42 frames (core2.swf)
    - `core.GoodsProfileBG` · ScaleFrameImage 
      - `asset.core.BagProfileGreen` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileBlue` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfilePurple` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileOrange` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileRed` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileBlackKing` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileFashion` · bitmap 45×45 (core.swf)
  - `fund.diamondImg` · ScaleFrameImage 
    - `asset.core.SmallPointImg` · bitmap x=0
      - `asset.core.SmallPointImg` · bitmap 23×21 (bottle.swf)
    - `asset.fund.bindPoint` · bitmap 25×21 (fund.swf)
  - `fund.itemnumTxt_3` · FilterFrameText  font `Arial,18,0x00effe,true,,,,,right`
  - `fund.DropItem` · BaseItemView 
    - `fund.DropItemIcon` · BaseIconView x=1 y=1
      - `asset.core.IconLoading` · sprite 42 frames (core2.swf)
    - `core.GoodsProfileBG` · ScaleFrameImage 
      - `asset.core.BagProfileGreen` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileBlue` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfilePurple` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileOrange` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileRed` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileBlackKing` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileFashion` · bitmap 45×45 (core.swf)
  - `fund.diamondImg` · ScaleFrameImage 
    - `asset.core.SmallPointImg` · bitmap x=0
      - `asset.core.SmallPointImg` · bitmap 23×21 (bottle.swf)
    - `asset.fund.bindPoint` · bitmap 25×21 (fund.swf)
  - texts: `mainBar.WorldBossBuyBuffBar.point` “Diamante”; `mainBar.WorldBossBuyBuffBar.giftToken` “Diamante vinculado”
  - subviews: `BaseItemView`

### funny.activity.ActivityCodeView

- **ActivityCodeView** (`core_module:funny/activity/ActivityCodeView.as`)
  - `funny.activityCodeBack` · MutipleImage x=0 y=0
    - `asset.funny.actiivityCodebg` · bitmap 530×420 (funny.swf)
    - `asset.funny.actiivityCodeImage1` · bitmap 260×28 (funny.swf)
    - `asset.funny.actiivityCodeBack` · bitmap 233×111 (funny.swf)
    - `funny.actiivityCodeBack.ScaleX` · Image 
      - `asset.funny.actiivityCodeBack` · bitmap 233×111 (funny.swf)
    - `asset.funny.actiivityCodeImage2` · bitmap 86×40 (funny.swf)
    - `asset.funny.ItemInputBack` · bitmap 231×27 (funny.swf)
  - `funny.activity.ItemContent` · FilterFrameText x=117 y=226 width=290 height=20 font `Arial,12,0xffffff,,,,,,left`
  - `funny.activity.ItemButtonMc1` · IconButton x=420 y=194
    - `asset.funny.getBack1` · bitmap 90×34 (funny.swf)
    - `asset.funny.ItemButtonMc1` · bitmap 55×19 (funny.swf)
  - `funny.activity.ItemInput` · FilterFrameText x=119 y=202 width=275 height=20 font `Arial,12,0x858585,,,,,,left`
  - texts: `activity.view.ActivityItem.content` “Digite cód. de ativação para coletar pacote”; `activity.view.ActivityItem.input` “Insira o Cód. de Ativação para coletar o pacote”; `activity.view.ActivityItem.command01` “Clique excessivo, tente novamente”

### funny.activity.ActivityItem2

- **ActivityItem2** (`core_module:funny/activity/ActivityItem2.as`)
  - `asset.funny.ItemBack` · bitmap x=0 y=100 width=508
    - `asset.funny.ItemBack` · bitmap 418×2 (funny.swf)
  - `funny.activity.ItemName2` · FilterFrameText x=10 y=12 width=290 height=20 font `Arial,14,0x1fbfe7,true,,,,,left`
  - `funny.activity.ItemContent2` · FilterFrameText x=10 y=35 width=380 height=65 font `Arial,12,0xffffff,,,,,,left`
  - `funnyRewardItem.getBtn` · IconButton x=392 y=36 width=90 height=34
    - `asset.core.Style24Btn` · bitmap 90×34 (core2.swf)
    - `asset.funny.getIcon` · bitmap 64×22 (funny.swf)
  - `funny.activity.ItemIcon` · BaseIconView x=11 y=14
    - `asset.core.IconLoading` · sprite 42 frames (core2.swf)
  - `asset.core.ReceivedImg` · bitmap x=0 y=0
    - `asset.core.ReceivedImg` · bitmap 99×68 (core.swf)
  - texts: `activity.view.ActivityItem.command01` “Clique excessivo, tente novamente”; `activity.view.ActivityItem.command02` “Nível insuficiente”; `activity.view.ActivityItem.command03` “Nível da Guilda insuficiente”
  - subviews: `BaseIconView`

### funny.groupbuy.CheckView

- **CheckView**: “Aviso” (`core_module:funny/groupbuy/CheckView.as`)
  - `groupbuy.Alert` · Frame width=390 height=192 ← `core.Frame2`
    - `core.quickBuyFrameBg` · MutipleImage 
      - `core.AlertFrameBg` · MutipleImage 
        - `core.AlertFrameBaseBg` · Scale9CornerImage 
          - `asset.core.framestyle03_scale9bg1` · bitmap 42×42 (framebg.swf)
          - `asset.core.framestyle03_scale9bg2` · bitmap 42×42 (framebg.swf)
          - `asset.core.framestyle03_scale9bg3` · bitmap 42×42 (framebg.swf)
          - `asset.core.framestyle03_scale9bg4` · bitmap 42×18 (framebg.swf)
          - `asset.core.framestyle03_scale9bg5` · bitmap 42×18 (framebg.swf)
          - `asset.core.framestyle03_scale9bg6` · bitmap 42×18 (framebg.swf)
          - `asset.core.framestyle03_scale9bg7` · bitmap 42×42 (framebg.swf)
          - `asset.core.framestyle03_scale9bg8` · bitmap 42×42 (framebg.swf)
          - `asset.core.framestyle03_scale9bg9` · bitmap 42×42 (framebg.swf)
      - `core.FrameTitleImage2` · Image width=229 height=17
        - `asset.core.frameTitleImage2` · bitmap 229×17 (framebg.swf)
  - `core.AlertConfirmBtn_2` · SelectedCheckButton  ← `core.AlertButton`
    - `core.AlertConfirmButtonImage_2` · ScaleFrameImage 
      - `core.AlertButtonConfirm_2` · IconButton  ← `core.AlertButtonConfirm_1`
        - `asset.core.AlertBtnStyle_02` · bitmap 96×40 (core2.swf)
      - `core.AlertButtonConfirm_2` · IconButton  ← `core.AlertButtonConfirm_1`
        - `asset.core.AlertBtnStyle_02` · bitmap 96×40 (core2.swf)
      - `core.AlertButtonConfirm_2` · IconButton  ← `core.AlertButtonConfirm_1`
        - `asset.core.AlertBtnStyle_02` · bitmap 96×40 (core2.swf)
      - `core.AlertButtonConfirm_2` · IconButton  ← `core.AlertButtonConfirm_1`
        - `asset.core.AlertBtnStyle_02` · bitmap 96×40 (core2.swf)
    - `core.AlertConfirmButtonImage_2` · ScaleFrameImage 
      - `core.AlertButtonConfirm_2` · IconButton  ← `core.AlertButtonConfirm_1`
        - `asset.core.AlertBtnStyle_02` · bitmap 96×40 (core2.swf)
      - `core.AlertButtonConfirm_2` · IconButton  ← `core.AlertButtonConfirm_1`
        - `asset.core.AlertBtnStyle_02` · bitmap 96×40 (core2.swf)
      - `core.AlertButtonConfirm_2` · IconButton  ← `core.AlertButtonConfirm_1`
        - `asset.core.AlertBtnStyle_02` · bitmap 96×40 (core2.swf)
      - `core.AlertButtonConfirm_2` · IconButton  ← `core.AlertButtonConfirm_1`
        - `asset.core.AlertBtnStyle_02` · bitmap 96×40 (core2.swf)
  - `asset.groupbuy.fanhuan` · bitmap 
    - `asset.groupbuy.fanhuan` · bitmap 86×30 (groupbuy.swf)
  - `groupbuy.fanhuizuanshiC` · Sprite x=152 y=80
  - `asset.groupbuy.zuanshibig` · bitmap 
    - `asset.groupbuy.zuanshibig` · bitmap 39×38 (groupbuy.swf)
  - `asset.groupbuy.miandian` · bitmap 
    - `asset.groupbuy.miandian` · bitmap 247×33 (groupbuy.swf)
  - `groupbuy.huodetxt` · FilterFrameText x=35 y=7 width=40 height=25 font `Arial,14,0xFFefbd,,,,,,center`
  - `groupbuy.txt1` · FilterFrameText x=0 y=0 width=370 height=50 font `Arial,14,0xFFefbd,,,,,,center`
  - `groupbuy.txt2` · FilterFrameText x=0 y=28 width=160 height=25 font `Arial,14,0xFFefbd,,,,,,center`
  - `groupbuy.txt3` · FilterFrameText x=163 y=28 width=131 height=25 font `Arial,14,0xFFefbd,,,,,,left`
  - `asset.core.SmallPointImg` · bitmap x=0
    - `asset.core.SmallPointImg` · bitmap 23×21 (bottle.swf)
  - `asset.groupbuy.num1` · bitmap 
    - `asset.groupbuy.num1` · bitmap 220×28 (groupbuy.swf)
  - texts: `public.prompt` “Aviso”; `funny.groupbuy.huode` “Obter”; `funny.groupbuy.txt1` “Lamentamos, você não ganhou o pedido da sorte”; `funny.groupbuy.txt2` “Compra em grupo {0}”; `funny.groupbuy.txt3` “Consumir {0}”

### funny.groupbuy.GroupBuyListBar

- **GroupBuyListBar** (`core_module:funny/groupbuy/GroupBuyListBar.as`)
  - `groupbuy.groupBuyListBar` · GroupBuyListBar x=4 y=60
  - `asset.groupbuy.listbg` · sprite 187.0×174.0 (groupbuy.swf)
  - `groupbuy.scrollPanel` · ScrollPanel x=0 y=0 width=193 height=174
    - `groupbuy.VScrollbar02` · Scrollbar width=18 height=174
      - `core.Scrollbar02_Back` · ScaleBitmapImage width=15 height=24
        - `asset.core.scrollbar02_bg` · bitmap 15×24 (core2.swf)
      - `core.Scrollbar02_Step` · BaseButton width=21 height=56
        - `core.scrollbar02_stepAsset` · ScaleBitmapImage width=21 height=56
          - `asset.core.scrollbar02_step` · bitmap 21×56 (core2.swf)
      - `core.Scrollbar02_Up` · BaseButton width=11 height=10
        - `asset.core.scrollbar02_up` · bitmap 11×10 (core2.swf)
      - `core.Scrollbar02_Down` · BaseButton width=11 height=10
        - `asset.core.scrollbar02_down` · bitmap 11×10 (core2.swf)
  - subviews: `VBox`, `GroupBuyListItem`

### funny.groupbuy.GroupBuyListItem

- **GroupBuyListItem** (`core_module:funny/groupbuy/GroupBuyListItem.as`)
  - `asset.groupbuy.groupbuyitembg` · sprite 172.0×27.0 (groupbuy.swf)
  - `asset.groupbuy.groupbuyitembgOver` · bitmap 
    - `asset.groupbuy.groupbuyitembgOver` · bitmap 170×27 (groupbuy.swf)

### funny.groupbuy.GroupBuyProgressBar

- **GroupBuyProgressBar** (`core_module:funny/groupbuy/GroupBuyProgressBar.as`)
  - `groupbuy.progressbar` · progressBar x=0 y=0
  - `groupbuy.buyNumTxt1` · GradientText x=-29 y=-17 width=84 height=20
    - `groupbuy.buyNumtxtfieldstyle2` · FilterFrameText height=20 font `Arial,12,0xffffff,,,,,,center`
  - `groupbuy.buyNumTxt2` · GradientText x=109 y=-17 ← `groupbuy.buyNumTxt1`
  - `groupbuy.buyNumTxt3` · GradientText x=244 y=-17 ← `groupbuy.buyNumTxt1`
  - `groupbuy.buyNumTxt4` · GradientText x=380 y=-17 ← `groupbuy.buyNumTxt1`
  - texts: `funny.groupbuy.rengou1` “Compra: {0}”; `funny.groupbuy.rengou2` “{0}”
  - subviews: `JianzuanItem`

### funny.groupbuy.GroupBuyView

- **GroupBuyView** (`core_module:funny/groupbuy/GroupBuyView.as`)
  - `groupbuy.groupBuyView` · GroupBuyView x=200 y=3
  - `core.groupbuy.HelpFrame` · SimpleHelpFrame  ← `core.SimpleHelpFrame`
  - `groupbuy.bgMC` · bg x=0 y=0
  - `groupbuy.BaseItemView` · BaseItemView x=54 y=111
    - `firstpay.ItemIcon` · BaseIconView x=1 y=1
      - `asset.core.IconLoading` · sprite 42 frames (core2.swf)
    - `firstpay.BaseItemText` · FilterFrameText x=15 y=38 width=42 height=16 font `Arial,12,0xffffff,true,,,,,right`
    - `core.BagCellLock` · ScaleFrameImage 
      - `asset.core.BagCellLock` · bitmap 45×45 (core.swf)
      - `asset.core.BagCellUnLock` · bitmap 45×45 (core.swf)
    - `core.goods.Strengthen` · MovieImage x=-50 y=-50
      - `asset.core.goods.Strengthen` · Strengthen 
  - `groupbuy.oldpricetxt` · FilterFrameText x=130 y=102 width=150 height=25 font `Arial,14,0x999999,true,,,,,left`
  - `asset.core.SmallPointImg` · bitmap x=0
    - `asset.core.SmallPointImg` · bitmap 23×21 (bottle.swf)
  - `asset.groupbuy.xiantiao` · bitmap 
    - `asset.groupbuy.xiantiao` · bitmap 112×1 (groupbuy.swf)
  - `groupbuy.jingbaojiaC` · Sprite x=268 y=123
  - `groupbuy.quanfubuyC` · Sprite x=275 y=162
  - `groupbuy.dazheC` · Sprite x=410 y=109
  - `groupbuy.mineYirengouNum` · GradientText x=56 y=313 width=100 height=20
    - `groupbuy.buyNumtxtfieldstyle` · FilterFrameText height=20 font `Arial,14,0xffffff,true,,,,,left`
  - `asset.groupbuy.zizuanshismall` · bitmap 
    - `asset.groupbuy.zizuanshismall` · bitmap 64×14 (groupbuy.swf)
  - `groupbuy.mineGonghuafeiNum` · GradientText x=66 y=335 ← `groupbuy.mineYirengouNum`
  - `asset.groupbuy.zijiansmall` · bitmap 
    - `asset.groupbuy.zijiansmall` · bitmap 72×17 (groupbuy.swf)
  - `asset.groupbuy.zijianbig` · bitmap y=159
    - `asset.groupbuy.zijianbig` · bitmap 250×24 (groupbuy.swf)
  - `groupbuy.btnRengou` · IconButton x=167 y=300 width=199 height=73
    - `asset.groupbuy.choujiangBg` · bitmap 199×73 (groupbuy.swf)
    - `asset.groupbuy.btnRengou` · bitmap 106×30 (groupbuy.swf)
  - `groupbuy.rengouovertxt` · FilterFrameText x=47 y=387 width=406 height=25 font `Arial,12,0x00fff0,,,,,,center`
  - `groupbuy.checktips` · StripView x=404 y=327 width=91 height=21
    - `groupbuy.checktips.tips` · GroupbuyCheckTips 
  - `groupbuy.helpbtn` · BaseButton x=480 y=93
    - `asset.core.HelpBtnStyle_02` · bitmap 22×23 (core2.swf)
  - `groupbuy.btnZhuanpan` · IconButton x=359 y=315 width=163 height=42
    - `asset.groupbuy.choujiang` · bitmap 222×32 (groupbuy.swf)
    - `asset.funny.rechargeBack` · bitmap 163×42 (funny.swf)
    - `core.HtmlMultipleLineTip` · MultipleLineTip 
  - `groupbuy.btnJiesuan` · IconButton x=182 y=305 width=184 height=63
    - `asset.groupbuy.choujiangBg` · bitmap 199×73 (groupbuy.swf)
    - `asset.groupbuy.btnJiesuan` · bitmap 174×42 (groupbuy.swf)
  - `asset.groupbuy.num4` · bitmap 
    - `asset.groupbuy.num4` · bitmap 154×18 (groupbuy.swf)
  - `asset.groupbuy.num2` · bitmap 
    - `asset.groupbuy.num2` · bitmap 180×22 (groupbuy.swf)
  - `asset.groupbuy.num1` · bitmap 
    - `asset.groupbuy.num1` · bitmap 220×28 (groupbuy.swf)
  - texts: `funny.groupbuy.buyRestTimeSecond` “{0} segundos”; `funny.groupbuy.buyRestTime` “Tempo restante de compra: {0}”; `funny.groupbuy.checkRestTime` “Tempo restante de Pagamento: {0}”; `funny.groupbuy.checkOver` “Pagamento encerrado”; `funny.groupbuy.error2` “Quantidade de itens insuficientes”; `funny.groupbuy.error1` “Compra limitada do item {0} vezes por dia”; `funny.groupbuy.helptips` “Instruções para Compra em Grupo”; `funny.groupbuy.zhuanpanTips` “Ao subscrever e comprar com sucesso, tem 1 chance de sortear”
  - subviews: `CheckView`, `GroupBuyProgressBar`, `ZuanshiView`, `StripView`, `BaseItemView`, `SimpleHelpFrame`

### funny.groupbuy.JianzuanItem

- **JianzuanItem** (`core_module:funny/groupbuy/JianzuanItem.as`)
  - `asset.groupbuy.zijianqu` · bitmap x=43 y=13
    - `asset.groupbuy.zijianqu` · bitmap 85×23 (groupbuy.swf)
  - `groupbuy.jianzuanC` · Sprite x=60 y=-2
  - `asset.groupbuy.zizuanshisbig` · bitmap x=23 y=23
    - `asset.groupbuy.zizuanshisbig` · bitmap 98×23 (groupbuy.swf)
  - `asset.groupbuy.num3` · bitmap 
    - `asset.groupbuy.num3` · bitmap 130×19 (groupbuy.swf)

### funny.groupbuy.ZuanshiView

- **ZuanshiView**: “Aviso” (`core_module:funny/groupbuy/ZuanshiView.as`)
  - `groupbuy.Alert2` · Frame width=390 height=163 ← `core.Frame2`
    - `core.quickBuyFrameBg` · MutipleImage 
      - `core.AlertFrameBg` · MutipleImage 
        - `core.AlertFrameBaseBg` · Scale9CornerImage 
          - `asset.core.framestyle03_scale9bg1` · bitmap 42×42 (framebg.swf)
          - `asset.core.framestyle03_scale9bg2` · bitmap 42×42 (framebg.swf)
          - `asset.core.framestyle03_scale9bg3` · bitmap 42×42 (framebg.swf)
          - `asset.core.framestyle03_scale9bg4` · bitmap 42×18 (framebg.swf)
          - `asset.core.framestyle03_scale9bg5` · bitmap 42×18 (framebg.swf)
          - `asset.core.framestyle03_scale9bg6` · bitmap 42×18 (framebg.swf)
          - `asset.core.framestyle03_scale9bg7` · bitmap 42×42 (framebg.swf)
          - `asset.core.framestyle03_scale9bg8` · bitmap 42×42 (framebg.swf)
          - `asset.core.framestyle03_scale9bg9` · bitmap 42×42 (framebg.swf)
      - `core.FrameTitleImage2` · Image width=229 height=17
        - `asset.core.frameTitleImage2` · bitmap 229×17 (framebg.swf)
  - `core.AlertConfirmBtn_2` · SelectedCheckButton  ← `core.AlertButton`
    - `core.AlertConfirmButtonImage_2` · ScaleFrameImage 
      - `core.AlertButtonConfirm_2` · IconButton  ← `core.AlertButtonConfirm_1`
        - `asset.core.AlertBtnStyle_02` · bitmap 96×40 (core2.swf)
      - `core.AlertButtonConfirm_2` · IconButton  ← `core.AlertButtonConfirm_1`
        - `asset.core.AlertBtnStyle_02` · bitmap 96×40 (core2.swf)
      - `core.AlertButtonConfirm_2` · IconButton  ← `core.AlertButtonConfirm_1`
        - `asset.core.AlertBtnStyle_02` · bitmap 96×40 (core2.swf)
      - `core.AlertButtonConfirm_2` · IconButton  ← `core.AlertButtonConfirm_1`
        - `asset.core.AlertBtnStyle_02` · bitmap 96×40 (core2.swf)
    - `core.AlertConfirmButtonImage_2` · ScaleFrameImage 
      - `core.AlertButtonConfirm_2` · IconButton  ← `core.AlertButtonConfirm_1`
        - `asset.core.AlertBtnStyle_02` · bitmap 96×40 (core2.swf)
      - `core.AlertButtonConfirm_2` · IconButton  ← `core.AlertButtonConfirm_1`
        - `asset.core.AlertBtnStyle_02` · bitmap 96×40 (core2.swf)
      - `core.AlertButtonConfirm_2` · IconButton  ← `core.AlertButtonConfirm_1`
        - `asset.core.AlertBtnStyle_02` · bitmap 96×40 (core2.swf)
      - `core.AlertButtonConfirm_2` · IconButton  ← `core.AlertButtonConfirm_1`
        - `asset.core.AlertBtnStyle_02` · bitmap 96×40 (core2.swf)
  - `groupbuy.txt1` · FilterFrameText x=0 y=0 width=370 height=50 font `Arial,14,0xFFefbd,,,,,,center`
  - texts: `public.prompt` “Aviso”; `funny.groupbuy.zuanshiconfirm` “Deseja consumir {0} diamantes para comprar este item?”

### funny.mountact.MountActView

- **MountActView** (`core_module:funny/mountact/MountActView.as`)
  - `funny.mountAct` · MountActView x=200 y=2
  - `asset.funny.mountBg` · bitmap x=0 y=0 width=526
    - `asset.funny.mountBg` · bitmap 531×367 (funny.swf)
  - `asset.funny.mountBg02` · bitmap x=108 y=267
    - `asset.funny.mountBg02` · bitmap 320×51 (funny.swf)
  - `asset.funny.mountArrow` · bitmap x=227 y=89
    - `asset.funny.mountArrow` · bitmap 79×143 (funny.swf)
  - `asset.funny.mountTitle` · bitmap x=95 y=11
    - `asset.funny.mountTitle` · bitmap 372×30 (funny.swf)
  - `funny.mountAct.mountItemBg01` · Image x=28 y=62
    - `asset.funny.mountItemBg` · bitmap 
      - `asset.funny.mountItemBg` · bitmap 174×186 (funny.swf)
  - `funny.mountAct.mountItemBg02` · Image x=325 y=62
    - `asset.funny.mountItemBg` · bitmap 
      - `asset.funny.mountItemBg` · bitmap 174×186 (funny.swf)
  - `funny.mountAct.currMountName` · FilterFrameText x=30 y=228 width=120 height=20 font `Arial,12,0xf3e9c1,,,,,,left`
  - `funny.mountAct.nextMountName` · FilterFrameText x=330 y=228 width=120 height=20 font `Arial,12,0xf3e9c1,,,,,,left`
  - `funny.mountAct.currMountLv` · FilterFrameText x=155 y=228 width=50 height=20 font `Arial,12,0x99f131,,,,,,left`
  - `funny.mountAct.nextMountLv` · FilterFrameText x=455 y=228 width=50 height=20 font `Arial,12,0x99f131,,,,,,left`
  - `funny.mountAct.costTxt` · GradientText y=282 width=60 height=30
    - `funny.mountAct.costTxtField` · FilterFrameText width=80 height=30 font `Arial,18,0xffffff,true,,,,,left`
  - `funny.mountAct.returnTxt` · GradientText width=80 height=30 ← `funny.mountAct.costTxt`
  - `funny.mountAct.costValueTxtField` · FilterFrameText x=0 y=282 width=80 height=30 font `Arial,18,0x00fff0,true,,,,,left`
  - `funny.mountAct.returnValueTxt` · FilterFrameText  ← `funny.mountAct.costValueTxtField`
  - `funny.mountAct.promptTxt` · FilterFrameText x=15 y=344 width=400 height=20 font `Arial,12,0xef9c00,,,,,,left`
  - `asset.core.SmallPointImg` · bitmap x=0
    - `asset.core.SmallPointImg` · bitmap 23×21 (bottle.swf)
  - `asset.funny.BindPointImg` · bitmap 25×21 (funny.swf)
  - `funny.buttonBg` · Image x=0 y=365 width=526
    - `asset.funny.funnyRightViewBack2` · bitmap 531×53 (funny.swf)
  - `asset.funny.timeImage` · bitmap x=144 y=385
    - `asset.funny.timeImage` · bitmap 73×18 (funny.swf)
  - `funnyRightView.timeText` · FilterFrameText x=232 y=385 width=300 height=20 font `Arial,12,0x00fff0,true,,,,,left`
  - `funnyRightView.remainTimeText` · FilterFrameText x=95 y=382 width=320 height=20 font `Arial,12,0x00fff0,,,,,,center`
  - texts: `funny.mountact.MountActView.prompt` “Ao aumentar o Nv.da Montaria durante o Evento, poderá recebe”; `mounts.command01` “Nv. {0}”; `fund.fundBuyItemTip.consumeTxt` “Consumindo”; `funny.mountact.MountActView.returnPoint` “Feedback {0}%”; `funny.FunnyRightView.active.remainTime` “Contagem do Evento: {0}”; `feedback.FeedBackItem.outDate` “Evento expirado”
  - subviews: `MountsAvatarView`

### funny.newyearact.NewYearPayActView

- **NewYearPayActView** (`core_module:funny/newyearact/NewYearPayActView.as`)
  - `funny.newyearact.payView` · NewYearPayActView x=193 y=-3
  - `funny.newyearAct.payActBg` · MutipleImage 
    - `asset.funny.bgImg01` · bitmap 544×432 (funny.swf)
    - `asset.funny.bgImg02` · bitmap 131×132 (funny.swf)
    - `asset.funny.bgImg03` · bitmap 74×71 (funny.swf)
    - `asset.funny.bgImg03` · bitmap 74×71 (funny.swf)
    - `asset.funny.bgImg04` · bitmap 44×30 (funny.swf)
    - `asset.funny.bgImg04` · bitmap 44×30 (funny.swf)
    - `asset.funny.bgImg05` · bitmap 90×21 (funny.swf)
    - `asset.funny.bgImg05` · bitmap 90×21 (funny.swf)
    - `asset.funny.bgImg06` · bitmap 90×18 (funny.swf)
    - `asset.funny.bgImg07` · bitmap 98×18 (funny.swf)
  - `funny.newyearact.diamondItem` · BaseIconView x=1 y=176
    - `asset.core.IconLoading` · sprite 42 frames (core2.swf)
  - `funny.newyearact.diamondItem` · BaseIconView x=1 y=176
    - `asset.core.IconLoading` · sprite 42 frames (core2.swf)
  - `funny.newyearAct.itemNumTxt` · FilterFrameText y=218 width=50 height=20 ← `firstpay.BaseItemText`
  - `funny.newyearAct.itemNumTxt` · FilterFrameText y=218 width=50 height=20 ← `firstpay.BaseItemText`
  - `funny.newyearact.currProfitLevelDinamicTxt` · GradientText x=178 y=116 width=120 height=20
    - `funny.newyearact.currProfitLevelTxt` · FilterFrameText width=120 height=20 font `Arial,14,0xffffff,true,,,,,left`
  - `funny.newyearact.maxdiamondTxt` · FilterFrameText x=238 y=195 width=75 height=40 font `Arial,12,0xffff00,,,,,,center`
  - `funny.newyearact.promptTxt` · FilterFrameText x=54 y=274 width=455 height=40 font `Arial,12,0xef9c00,,,,,,center`
  - `funny.newyearact.actTimeTxt` · FilterFrameText x=96 y=314 width=370 height=20 font `Arial,12,0x00fff0,,,,,,center`
  - `funny.newyearact.getRewardBtn` · IconButton x=403 y=343 width=96 height=40
    - `asset.core.AlertBtnStyle_01` · bitmap 96×40 (core2.swf)
    - `asset.funny.getRewardBtnImg` · bitmap 64×21 (funny.swf)
  - `asset.funny.newyearactNumBmd` · bitmap 
    - `asset.funny.newyearactNumBmd` · bitmap 165×16 (funny.swf)
  - `asset.funny.newyearact.progess01` · bitmap x=40 y=350
    - `asset.funny.newyearact.progess01` · bitmap 359×29 (funny.swf)
  - `asset.funny.newyearact.progess02` · bitmap x=59 y=359
    - `asset.funny.newyearact.progess02` · bitmap 323×11 (funny.swf)
  - `asset.funny.blueProgess` · bitmap x=59 y=359
    - `asset.funny.blueProgess` · bitmap 323×11 (funny.swf)
  - `asset.funny.blueProgess02` · bitmap y=347
    - `asset.funny.blueProgess02` · bitmap 79×34 (funny.swf)
  - `asset.funny.purpleprogess` · bitmap x=59 y=359
    - `asset.funny.purpleprogess` · bitmap 321×11 (funny.swf)
  - `funny.newyear.helpBtn` · BaseButton x=488 y=100
    - `asset.core.HelpBtnStyle_02` · bitmap 22×23 (core2.swf)
  - `funny.newyearact.getProfitDinamicTxt` · GradientText x=30 y=335 width=84 height=20
    - `funny.newyearact.getProfitTxt` · FilterFrameText height=20 font `Arial,12,0xffffff,,,,,,left`
  - `funny.newyearact.getProfitDinamicTxt` · GradientText x=30 y=335 width=84 height=20
    - `funny.newyearact.getProfitTxt` · FilterFrameText height=20 font `Arial,12,0xffffff,,,,,,left`
  - `funny.newyearact.getProfitDinamicTxt` · GradientText x=30 y=335 width=84 height=20
    - `funny.newyearact.getProfitTxt` · FilterFrameText height=20 font `Arial,12,0xffffff,,,,,,left`
  - `funny.newyearact.getProfitDinamicTxt` · GradientText x=30 y=335 width=84 height=20
    - `funny.newyearact.getProfitTxt` · FilterFrameText height=20 font `Arial,12,0xffffff,,,,,,left`
  - `funny.newyearact.getProfitDinamicTxt` · GradientText x=30 y=335 width=84 height=20
    - `funny.newyearact.getProfitTxt` · FilterFrameText height=20 font `Arial,12,0xffffff,,,,,,left`
  - `funny.newyearact.getProfitDinamicTxt` · GradientText x=30 y=335 width=84 height=20
    - `funny.newyearact.getProfitTxt` · FilterFrameText height=20 font `Arial,12,0xffffff,,,,,,left`
  - `funny.newyearact.getProfitLevelDinamicTxt` · GradientText x=-29 y=386 width=84 height=20
    - `funny.newyearact.getProfitLevelTxt` · FilterFrameText height=20 font `Arial,12,0xffffff,true,,,,,left`
  - `funny.newyearact.getProfitLevelDinamicTxt` · GradientText x=-29 y=386 width=84 height=20
    - `funny.newyearact.getProfitLevelTxt` · FilterFrameText height=20 font `Arial,12,0xffffff,true,,,,,left`
  - `funny.newyearact.getProfitLevelDinamicTxt` · GradientText x=-29 y=386 width=84 height=20
    - `funny.newyearact.getProfitLevelTxt` · FilterFrameText height=20 font `Arial,12,0xffffff,true,,,,,left`
  - `funny.newyearact.getProfitLevelDinamicTxt` · GradientText x=-29 y=386 width=84 height=20
    - `funny.newyearact.getProfitLevelTxt` · FilterFrameText height=20 font `Arial,12,0xffffff,true,,,,,left`
  - `funny.newyearact.getProfitLevelDinamicTxt` · GradientText x=-29 y=386 width=84 height=20
    - `funny.newyearact.getProfitLevelTxt` · FilterFrameText height=20 font `Arial,12,0xffffff,true,,,,,left`
  - `funny.newyearact.getProfitLevelDinamicTxt` · GradientText x=-29 y=386 width=84 height=20
    - `funny.newyearact.getProfitLevelTxt` · FilterFrameText height=20 font `Arial,12,0xffffff,true,,,,,left`
  - `asset.funny.newyearLine` · bitmap y=358
    - `asset.funny.newyearLine` · bitmap 8×13 (funny.swf)
  - `asset.funny.newyearLine` · bitmap y=358
    - `asset.funny.newyearLine` · bitmap 8×13 (funny.swf)
  - `asset.funny.newyearLine` · bitmap y=358
    - `asset.funny.newyearLine` · bitmap 8×13 (funny.swf)
  - `asset.funny.newyearLine` · bitmap y=358
    - `asset.funny.newyearLine` · bitmap 8×13 (funny.swf)
  - `asset.funny.newyearLine` · bitmap y=358
    - `asset.funny.newyearLine` · bitmap 8×13 (funny.swf)
  - `core.funny.newyearPayHelpFrame` · SimpleHelpFrame  ← `core.SimpleHelpFrame`
  - `core.normal_f` · GlowFilter 
  - texts: `funny.newyearPayAct.helpBtnTip` “Guia de Consumo do Ano Novo”; `funny.newyearact.NewYearPayActView.numArr` “1|2|3|4|5|6”; `funny.newyearact.NewYearPayActView.promptTxt` “Depois de participar na actividade, poderá participar na col”; `funny.newyearact.NewYearPayActView.actTimeTxt` “Hora do Evento: {0} -- {1}”; `funny.newyearact.NewYearPayActView.currLevel` “Coluna atual {0} feedback de {1}%”; `funny.newyearact.NewYearPayActView.currLevel_2` “O Evento não começou”; `funny.newyearact.NewYearPayActView.maxBindDiamondTxt` “{0} Diamantes Vinculados”; `funny.newyearact.NewYearPayActView.profitTxt` “DevoNv.er:  {0}%”
  - subviews: `BaseIconView`, `SimpleHelpFrame`

### funny.regression.RegressChargeView

- **RegressChargeView** (`core_module:funny/regression/RegressChargeView.as`)
  - `funny.funnyBagViewBack` · MutipleImage x=0 y=0
    - `asset.funny.funnyRightViewBack1` · bitmap width=527 height=417
      - `asset.funny.funnyRightViewBack1` · bitmap 533×419 (funny.swf)
    - `asset.funny.funnyRightViewBack2` · bitmap 531×53 (funny.swf)
  - `funny.funnyBagView.rechargeBtn` · IconButton x=365 y=-5 width=163 height=42
    - `asset.funny.rechargeBack` · bitmap 163×42 (funny.swf)
    - `asset.funny.rechargeIcon` · bitmap 70×23 (funny.swf)
  - `funnyRightView.title` · GradientText x=20 y=3 width=200 height=22
    - `funnyRightView.title.Field` · FilterFrameText width=200 height=22 font `Arial,16,0xffffff,true,,,,,center`
  - `funnyRightView.describeText` · FilterFrameText x=5 y=0 width=483 height=22 font `Arial,12,0xf2e4a5,,,,,,left`
  - `asset.funny.timeImage` · bitmap x=144 y=385
    - `asset.funny.timeImage` · bitmap 73×18 (funny.swf)
  - `funnyRightView.timeText` · FilterFrameText x=232 y=385 width=300 height=20 font `Arial,12,0x00fff0,true,,,,,left`
  - `funnyRightView.remainTimeText` · FilterFrameText x=95 y=382 width=320 height=20 font `Arial,12,0x00fff0,,,,,,center`
  - `asset.funny.conditionImage` · bitmap x=-5 y=1
    - `asset.funny.conditionImage` · bitmap 63×17 (funny.swf)
  - `funnyRightView.condition` · FilterFrameText x=63 y=0 width=410 height=20 font `Arial,12,0x00bff8,,,,,,left`
  - `asset.funny.processImage` · bitmap x=-4 y=1
    - `asset.funny.processImage` · bitmap 127×18 (funny.swf)
  - `funnyRightView.process` · FilterFrameText x=62 y=-1 width=410 height=20 font `Arial,12,0xf2e4a5,,,,,,left`
  - `asset.funny.rewardTitleBack` · bitmap x=0 y=20 width=489
    - `asset.funny.rewardTitleBack` · bitmap 255×37 (funny.swf)
  - `asset.funny.rewardTitle` · bitmap x=20 y=29
    - `asset.funny.rewardTitle` · bitmap 121×17 (funny.swf)
  - `funnyRightView.itemVBox` · VBox x=5 y=0
  - `funnyRightView.totalVBox` · VBox x=0 y=0
  - `funnyRightView.panel` · ScrollPanel x=8 y=33 width=516 height=331
    - `core.VScrollbar02` · Scrollbar width=21 height=200
      - `core.Scrollbar02_Back` · ScaleBitmapImage width=15 height=24
        - `asset.core.scrollbar02_bg` · bitmap 15×24 (core2.swf)
      - `core.Scrollbar02_Step` · BaseButton width=21 height=56
        - `core.scrollbar02_stepAsset` · ScaleBitmapImage width=21 height=56
          - `asset.core.scrollbar02_step` · bitmap 21×56 (core2.swf)
      - `core.Scrollbar02_Up` · BaseButton width=11 height=10
        - `asset.core.scrollbar02_up` · bitmap 11×10 (core2.swf)
      - `core.Scrollbar02_Down` · BaseButton width=11 height=10
        - `asset.core.scrollbar02_down` · bitmap 11×10 (core2.swf)
  - `funnyRightView.itemVBox` · VBox x=5 y=0
  - texts: `funny.view.FunnyBagView.title` “Introdução do Evento”; `funny.FunnyRightView.active.timeText` “{0}-{1}”; `funny.FunnyRightView.active.remainTime` “Contagem do Evento: {0}”; `feedback.FeedBackItem.outDate` “Evento expirado”
  - subviews: `FunnyBagItem`

### funny.regression.RegressionView

- **RegressionView** (`core_module:funny/regression/RegressionView.as`)
  - `RegressionView.back` · MutipleImage 
    - `asset.toptoolbar.regressionBack` · bitmap 465×186 (toptoolbar.swf)
    - `asset.toptoolbar.regressionPeople` · bitmap 247×273 (toptoolbar.swf)
    - `asset.toptoolbar.regressionTitle` · bitmap 253×46 (toptoolbar.swf)
  - `RegressionView.btn` · IconButton x=172 y=130
    - `asset.core.AlertBtnStyle_01` · bitmap 96×40 (core2.swf)
    - `asset.toptoolbar.regressionGetIcon` · bitmap 70×22 (toptoolbar.swf)
  - `RegressionView.describe` · FilterFrameText x=88 y=51 width=326 height=55 font `Arial,14,0xffa800,,,,,,left`
  - texts: `funny.regression.RegressionView.describe` “Caros Heróis, Bem-Vindo[Legend Online]，você já obteu umgrand”

### funny.view.DoubleGiftItem

- **DoubleGiftItem** (`core_module:funny/view/DoubleGiftItem.as`)
  - `funny.doubleBagItem.giftLable01` · FilterFrameText x=0 y=19 width=60 height=20 font `Arial,12,0xffb330,,,,,,left`
  - `funnyRewardItem.getBtn` · IconButton x=392 y=36 width=90 height=34
    - `asset.core.Style24Btn` · bitmap 90×34 (core2.swf)
    - `asset.funny.getIcon` · bitmap 64×22 (funny.swf)
  - `asset.core.ReceivedImg` · bitmap x=0 y=0
    - `asset.core.ReceivedImg` · bitmap 99×68 (core.swf)
  - `feedBackFrame.BaseItemView` · BaseItemView x=0 y=0
    - `feedBackFrame.ItemBaseItemViewIcon` · BaseIconView x=1 y=1
      - `asset.core.IconLoading` · sprite 42 frames (core2.swf)
    - `core.GoodsProfileBG` · ScaleFrameImage 
      - `asset.core.BagProfileGreen` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileBlue` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfilePurple` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileOrange` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileRed` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileBlackKing` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileFashion` · bitmap 45×45 (core.swf)
    - `feedBackFrame.BaseItemText` · FilterFrameText x=0 y=33 width=52 height=18 ← `core.BaseItemText`
  - `funny.LightEffect` · MovieImage x=27 y=-27
    - `asset.funny.LightEffect` · sprite 18 frames (funny.swf)
  - `funnyBagItem.StarBagCell` · StarBagCell x=0 y=0
    - `asset.funny.StarBagCell` · bitmap 60×60 (funny.swf)
    - `star.PlayerStarBagCellIcpn` · BaseIconView x=30 y=30
      - `asset.core.IconLoading` · sprite 42 frames (core2.swf)
      - `tips.StarTip` · StarTip 
    - `star.StarNameTxt` · FilterFrameText x=-17 y=35 width=80 height=60 font `Arial,12,0x999999,,,,,,center`
    - `star.StarLevelTxt` · FilterFrameText x=-10 y=3 width=50 height=20 ← `star.StarNameTxt`
  - `asset.core.Style24Btn` · bitmap 90×34 (core2.swf)
  - `asset.funny.getIcon` · bitmap 64×22 (funny.swf)
  - texts: `feedback.FeedBackItem.outDate` “Evento expirado”; `funny.view.FunnyDoubleBagItem.giftLable01` “Pacote A”; `funny.view.FunnyDoubleBagItem.giftLable02` “Pacote B”
  - subviews: `StarBagCell`, `HBox`, `BaseItemView`

### funny.view.ExchargeRankLeftButton

- **ExchargeRankLeftButton** (`core_module:funny/view/ExchargeRankLeftButton.as`)
  - `exchargerankLeftButton.title` · GradientText x=30 y=15 width=140 height=40
  - `asset.exchargerank.leftBtn1` · bitmap 116×28 (exchargeall.swf)
  - `asset.exchargerank.leftBtn2` · bitmap 116×28 (exchargeall.swf)

### funny.view.FunnyBagItem

- **FunnyBagItem** (`core_module:funny/view/FunnyBagItem.as`)
  - `funnyRewardItem.title` · FilterFrameText x=0 y=3 width=480 height=40 font `Arial,12,0xd4d1d1,,,,,,left`
  - `funnyRewardItem.rewardTileList` · SimpleTileList x=0 y=21
  - `asset.core.ReceivedImg` · bitmap x=0 y=0
    - `asset.core.ReceivedImg` · bitmap 99×68 (core.swf)
  - `funnyRewardItem.getBtn` · IconButton x=392 y=36 width=90 height=34
    - `asset.core.Style24Btn` · bitmap 90×34 (core2.swf)
    - `asset.funny.getIcon` · bitmap 64×22 (funny.swf)
  - `funnyRewardItem.payBtn` · IconButton x=392 y=36 width=90 height=34
    - `asset.funny.payBack` · bitmap 90×34 (funny.swf)
    - `asset.funny.payIcon` · bitmap 70×21 (funny.swf)
  - `asset.funny.getBack1` · bitmap 90×34 (funny.swf)
  - `funnyRewardItem.remainTime` · FilterFrameText x=404 y=40 width=70 height=25 font `Arial,18,0xfff000,true,,,,,center`
  - `funnyRewardItem.canGetImage` · Image x=460 y=29
    - `asset.funnyRewardItem.canGetImage` · bitmap 27×27 (funny.swf)
  - `funnyRewardItem.canGetText` · FilterFrameText x=460 y=34 width=30 height=20 font `Arial,12,0xffffff,,,,,,center`
  - `feedBackFrame.BaseItemView` · BaseItemView x=0 y=0
    - `feedBackFrame.ItemBaseItemViewIcon` · BaseIconView x=1 y=1
      - `asset.core.IconLoading` · sprite 42 frames (core2.swf)
    - `core.GoodsProfileBG` · ScaleFrameImage 
      - `asset.core.BagProfileGreen` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileBlue` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfilePurple` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileOrange` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileRed` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileBlackKing` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileFashion` · bitmap 45×45 (core.swf)
    - `feedBackFrame.BaseItemText` · FilterFrameText x=0 y=33 width=52 height=18 ← `core.BaseItemText`
  - `funnyBagItem.StarBagCell` · StarBagCell x=0 y=0
    - `asset.funny.StarBagCell` · bitmap 60×60 (funny.swf)
    - `star.PlayerStarBagCellIcpn` · BaseIconView x=30 y=30
      - `asset.core.IconLoading` · sprite 42 frames (core2.swf)
      - `tips.StarTip` · StarTip 
    - `star.StarNameTxt` · FilterFrameText x=-17 y=35 width=80 height=60 font `Arial,12,0x999999,,,,,,center`
    - `star.StarLevelTxt` · FilterFrameText x=-10 y=3 width=50 height=20 ← `star.StarNameTxt`
  - `funny.LightEffect` · MovieImage x=27 y=-27
    - `asset.funny.LightEffect` · sprite 18 frames (funny.swf)
  - `funny.view.FunnyMutiFrame` · FunnyMutiFrame  ← `core.SpliteItemFrame`
  - `asset.core.Style24Btn` · bitmap 90×34 (core2.swf)
  - `asset.funny.ItemButtonMc1` · bitmap 55×19 (funny.swf)
  - `asset.funny.getIcon` · bitmap 64×22 (funny.swf)
  - texts: `funny.view.FunnyBagItem.PayBtn.TipTxt` “Recarregue mais {0} diamantes para coletar o prêmio”; `feedback.FeedBackItem.outDate` “Evento expirado”; `funny.view.FunnyBagItem.cannotBuy` “Moda de evento não pode ser comprado”
  - subviews: `StarBagCell`, `FunnyMutiFrame`, `BaseItemView`

### funny.view.FunnyBagView

- **FunnyBagView** (`core_module:funny/view/FunnyBagView.as`)
  - `funny.funnyBagViewBack` · MutipleImage x=0 y=0
    - `asset.funny.funnyRightViewBack1` · bitmap width=527 height=417
      - `asset.funny.funnyRightViewBack1` · bitmap 533×419 (funny.swf)
    - `asset.funny.funnyRightViewBack2` · bitmap 531×53 (funny.swf)
  - `funny.funnyBagView.rechargeBtn` · IconButton x=365 y=-5 width=163 height=42
    - `asset.funny.rechargeBack` · bitmap 163×42 (funny.swf)
    - `asset.funny.rechargeIcon` · bitmap 70×23 (funny.swf)
  - `funny.funnyBagView.readAllBtn` · IconButton x=365 y=-5 width=163 height=42
    - `asset.funny.rechargeBack` · bitmap 163×42 (funny.swf)
    - `asset.funny.readAllIcon` · bitmap 94×24 (funny.swf)
  - `funnyRightView.title` · GradientText x=20 y=3 width=200 height=22
    - `funnyRightView.title.Field` · FilterFrameText width=200 height=22 font `Arial,16,0xffffff,true,,,,,center`
  - `funnyRightView.describeText` · FilterFrameText x=5 y=0 width=483 height=22 font `Arial,12,0xf2e4a5,,,,,,left`
  - `asset.funny.timeImage` · bitmap x=144 y=385
    - `asset.funny.timeImage` · bitmap 73×18 (funny.swf)
  - `funnyRightView.timeText` · FilterFrameText x=232 y=385 width=300 height=20 font `Arial,12,0x00fff0,true,,,,,left`
  - `funnyRightView.remainTimeText` · FilterFrameText x=95 y=382 width=320 height=20 font `Arial,12,0x00fff0,,,,,,center`
  - `asset.funny.conditionImage` · bitmap x=-5 y=1
    - `asset.funny.conditionImage` · bitmap 63×17 (funny.swf)
  - `funnyRightView.condition` · FilterFrameText x=63 y=0 width=410 height=20 font `Arial,12,0x00bff8,,,,,,left`
  - `asset.funny.processImage` · bitmap x=-4 y=1
    - `asset.funny.processImage` · bitmap 127×18 (funny.swf)
  - `funnyRightView.process` · FilterFrameText x=62 y=-1 width=410 height=20 font `Arial,12,0xf2e4a5,,,,,,left`
  - `asset.funny.rewardTitleBack` · bitmap x=0 y=20 width=489
    - `asset.funny.rewardTitleBack` · bitmap 255×37 (funny.swf)
  - `asset.funny.rewardTitle` · bitmap x=20 y=29
    - `asset.funny.rewardTitle` · bitmap 121×17 (funny.swf)
  - `funnyRightView.itemVBox` · VBox x=5 y=0
  - `funnyRightView.totalVBox` · VBox x=0 y=0
  - `funnyRightView.panel` · ScrollPanel x=8 y=33 width=516 height=331
    - `core.VScrollbar02` · Scrollbar width=21 height=200
      - `core.Scrollbar02_Back` · ScaleBitmapImage width=15 height=24
        - `asset.core.scrollbar02_bg` · bitmap 15×24 (core2.swf)
      - `core.Scrollbar02_Step` · BaseButton width=21 height=56
        - `core.scrollbar02_stepAsset` · ScaleBitmapImage width=21 height=56
          - `asset.core.scrollbar02_step` · bitmap 21×56 (core2.swf)
      - `core.Scrollbar02_Up` · BaseButton width=11 height=10
        - `asset.core.scrollbar02_up` · bitmap 11×10 (core2.swf)
      - `core.Scrollbar02_Down` · BaseButton width=11 height=10
        - `asset.core.scrollbar02_down` · bitmap 11×10 (core2.swf)
  - `funny.outLinkDesc` · FilterFrameText x=8 y=46 width=520 height=60 font `Arial,12,0xf4e3a6,,,,,,left`
  - `funnyRightView.itemVBox` · VBox x=5 y=0
  - texts: `funny.view.FunnyBagView.title` “Introdução do Evento”; `funny.FunnyRightView.active.timeText` “{0}-{1}”; `funny.FunnyRightView.active.remainTime` “Contagem do Evento: {0}”; `feedback.FeedBackItem.outDate` “Evento expirado”; `funny.view.FunnyRightView.currentNum` “Possui: {0} x{1}”
  - subviews: `ActivityItem2`, `FunnyBagItem`, `FunnyDoubleBagItem`, `MultiImageSwitchView`

### funny.view.FunnyDoubleBagItem

- **FunnyDoubleBagItem** (`core_module:funny/view/FunnyDoubleBagItem.as`)
  - `funnyRewardItem.title` · FilterFrameText x=0 y=3 width=480 height=40 font `Arial,12,0xd4d1d1,,,,,,left`
  - `funnyRewardItem.rewardTileList` · SimpleTileList x=0 y=21
  - `funnyRewardItem.getBtn` · IconButton x=392 y=36 width=90 height=34
    - `asset.core.Style24Btn` · bitmap 90×34 (core2.swf)
    - `asset.funny.getIcon` · bitmap 64×22 (funny.swf)
  - `asset.core.ReceivedImg` · bitmap x=0 y=0
    - `asset.core.ReceivedImg` · bitmap 99×68 (core.swf)
  - `feedBackFrame.BaseItemView` · BaseItemView x=0 y=0
    - `feedBackFrame.ItemBaseItemViewIcon` · BaseIconView x=1 y=1
      - `asset.core.IconLoading` · sprite 42 frames (core2.swf)
    - `core.GoodsProfileBG` · ScaleFrameImage 
      - `asset.core.BagProfileGreen` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileBlue` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfilePurple` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileOrange` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileRed` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileBlackKing` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileFashion` · bitmap 45×45 (core.swf)
    - `feedBackFrame.BaseItemText` · FilterFrameText x=0 y=33 width=52 height=18 ← `core.BaseItemText`
  - `funny.LightEffect` · MovieImage x=27 y=-27
    - `asset.funny.LightEffect` · sprite 18 frames (funny.swf)
  - `funnyBagItem.StarBagCell` · StarBagCell x=0 y=0
    - `asset.funny.StarBagCell` · bitmap 60×60 (funny.swf)
    - `star.PlayerStarBagCellIcpn` · BaseIconView x=30 y=30
      - `asset.core.IconLoading` · sprite 42 frames (core2.swf)
      - `tips.StarTip` · StarTip 
    - `star.StarNameTxt` · FilterFrameText x=-17 y=35 width=80 height=60 font `Arial,12,0x999999,,,,,,center`
    - `star.StarLevelTxt` · FilterFrameText x=-10 y=3 width=50 height=20 ← `star.StarNameTxt`
  - `funny.view.FunnyMutiFrame` · FunnyMutiFrame  ← `core.SpliteItemFrame`
  - texts: `funny.datas.FunnyBagData.title20_1` “(Ente os dois selecione 1)”; `feedback.FeedBackItem.outDate` “Evento expirado”
  - subviews: `StarBagCell`, `DoubleGiftItem`, `FunnyMutiFrame`, `BaseItemView`

### funny.view.FunnyFrame

- **FunnyFrame** (`core_module:funny/view/FunnyFrame.as`)
  - `funny.view.FunnyFrame` · FunnyFrame width=765 height=543 ← `core.Frame1`
  - `funnyFrame.back` · Scale9CornerImage x=0 y=0 width=730 height=425 ← `core.describeBackground_style11`
  - `asset.funny.leftBack` · bitmap x=4 y=4
    - `asset.funny.leftBack` · bitmap 192×418 (funny.swf)
  - `funnyFrame.gap` · MutipleImage x=194 y=1
    - `asset.funny.gap` · bitmap 8×213 (funny.swf)
    - `asset.funny.gap` · bitmap 8×213 (funny.swf)
  - `funnyFrame.leftVBox` · VBox x=3 y=3
  - `funnyFrame.preBtn` · BaseButton x=0 y=1 ← `auction.prePageBtn`
  - `funnyFrame.nextBtn` · BaseButton x=104 y=1 ← `auction.nextPageBtn`
  - `funnyFrame.pageText` · FilterFrameText x=37 y=6 ← `auction.PageTxt`
  - `asset.core.PageNumBack` · bitmap x=35 y=-1.5 width=67
    - `asset.core.PageNumBack` · bitmap 57×30 (core2.swf)
  - `funny.newyearact.payView` · NewYearPayActView x=193 y=-3
  - `funny.mountAct` · MountActView x=200 y=2
  - `groupbuy.groupBuyView` · GroupBuyView x=200 y=3
  - `groupbuy.groupBuyListBar` · GroupBuyListBar x=4 y=60
  - `groupbuy.btnGroupbuy` · FunnyLeftButton x=4 y=4 width=193 height=55 ← `funnyFrame.leftSelectedBtn`
  - `funnyFrame.activityBtn` · FunnyLeftButton x=3 y=381 width=176 height=39 ← `funnyFrame.leftSelectedBtn`
    - `asset.funny.leftBtn3` · bitmap 192×38 (funny.swf)
    - `asset.funny.leftBtn4` · bitmap 192×38 (funny.swf)
    - `funny.leftSelectedBtnText` · FilterFrameText x=28 y=11 width=140 height=40 font `Arial,12,0xb08b56,,,,,,center`
  - `funnyFrame.leftSelectedBtn` · FunnyLeftButton x=0 y=0 width=176 height=39
    - `asset.funny.leftBtn1` · bitmap 193×55 (funny.swf)
    - `asset.funny.leftBtn2` · bitmap 193×55 (funny.swf)
    - `funny.leftSelectedBtnText` · FilterFrameText x=28 y=11 width=140 height=40 font `Arial,12,0xb08b56,,,,,,center`
  - texts: `funny.view.FunnyFrame.hotBuy.title` “Venda da Loja Limitada”; `funny.view.FunnyFrame.vipBuy.title` “Venda Limitada de VIP”; `funny.view.FunnyFrame.goddessDoubleForge.title` “Forja Dupla da Deusa”; `funny.groupbuy.btngroupbuy` “Evento da compra de diamantes em grupo”; `mainBar.SmallMapBar.activityRewardBtnTipData` “Prêmio de Evento”
  - subviews: `GroupBuyListBar`, `GroupBuyView`, `MountActView`, `NewYearPayActView`, `FunnyLeftButton`, `FunnyRightView`

### funny.view.FunnyHotBuyItem

- **FunnyHotBuyItem** (`core_module:funny/view/FunnyHotBuyItem.as`)
  - `funny.FunnyHotBuyItemBg` · ScaleFrameImage 
    - `funny.NormalItemBGImg` · MutipleImage 
      - `funny.NormalItemBG9Corner` · Scale9CornerImage width=250 height=138 ← `core.describeBackground_style39`
      - `asset.core.NormalGoodsBg` · bitmap 67×67 (core.swf)
      - `funny.NormalPriceBg.ScaleX` · Image 
        - `asset.core.NormalPriceBg` · bitmap 75×25 (core.swf)
      - `asset.core.NormalPriceBg` · bitmap 75×25 (core.swf)
    - `funny.FunnyHotBuyItemAsset` · MutipleImage 
      - `funny.NormalItemBGImg` · MutipleImage 
        - `funny.NormalItemBG9Corner` · Scale9CornerImage width=250 height=138 ← `core.describeBackground_style39`
        - `asset.core.NormalGoodsBg` · bitmap 67×67 (core.swf)
        - `funny.NormalPriceBg.ScaleX` · Image 
          - `asset.core.NormalPriceBg` · bitmap 75×25 (core.swf)
        - `asset.core.NormalPriceBg` · bitmap 75×25 (core.swf)
      - `funny.MouseOver` · Scale9CornerImage width=248 height=144
        - `asset.core.shopover_scale9bg1` · bitmap 43×16 (core.swf)
        - `asset.core.shopover_scale9bg2` · bitmap 43×16 (core.swf)
        - `asset.core.shopover_scale9bg3` · bitmap 43×16 (core.swf)
        - `asset.core.shopover_scale9bg4` · bitmap 43×16 (core.swf)
        - `asset.core.shopover_scale9bg5` · bitmap 43×16 (core.swf)
        - `asset.core.shopover_scale9bg6` · bitmap 43×16 (core.swf)
        - `asset.core.shopover_scale9bg7` · bitmap 43×16 (core.swf)
        - `asset.core.shopover_scale9bg8` · bitmap 43×16 (core.swf)
        - `asset.core.shopover_scale9bg9` · bitmap 43×16 (core.swf)
  - `funny.FunnyHotBuyBtn` · IconButton x=150 y=100 ← `shop.BuyBtn`
  - `funny.FunnyHotBuyNameText` · FilterFrameText x=80 y=35 width=160 ← `shop.timeBuyGoodsNameTextStyle`
  - `funny.FunnyHotBuyValueText` · FilterFrameText x=90 y=78 width=120 height=20 font `Arial,12,0xdec100,true,,,,,right`
  - `core.SmallValueIcon` · ScaleFrameImage x=182 y=72
    - `asset.core.SmallPointImg` · bitmap x=0
      - `asset.core.SmallPointImg` · bitmap 23×21 (bottle.swf)
    - `asset.core.SmallPointImg` · bitmap x=0
      - `asset.core.SmallPointImg` · bitmap 23×21 (bottle.swf)
  - `shop.BaseItemView2` · BaseItemView x=20 y=41
    - `shop.BaseItemViewIcon2` · BaseIconView x=1 y=1
      - `asset.core.IconLoading` · sprite 42 frames (core2.swf)
    - `core.GoodsProfileBG` · ScaleFrameImage 
      - `asset.core.BagProfileGreen` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileBlue` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfilePurple` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileOrange` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileRed` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileBlackKing` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileFashion` · bitmap 45×45 (core.swf)
    - `core.FashionLevel` · ScaleFrameImage 
      - `asset.core.fashionLevelNormal` · bitmap 21×21 (core.swf)
      - `asset.core.fashionLevelSpecial` · bitmap 21×21 (core.swf)
  - `shop.PurchaseTextStyle` · FilterFrameText x=20 y=95 height=20 font `Arial,12,0xbaad89,,,,,,left`
  - `shop.PurchaseNumTextStyle` · FilterFrameText x=75 y=95 width=70 height=20 font `Arial,14,0xbaad89,true,,,,,left`
  - `shop.timeRemaining` · FilterFrameText x=90 y=10 width=130 height=22 font `Arial,16,0xfffdf4,true,,,,,left`
  - `shop.remainingTimeTxt` · FilterFrameText x=20 y=11 height=20 font `Arial,15,0xfff17e,true,,,,,left`
  - `asset.core.PromoTimeImgTxt` · bitmap x=159 y=10
    - `asset.core.PromoTimeImgTxt` · bitmap 53×20 (core.swf)
  - `asset.core.PromoPromptImgTxt` · bitmap x=63 y=68
    - `asset.core.PromoPromptImgTxt` · bitmap 105×60 (core.swf)
  - `funny.FunnyHotBuyListPromptTxt` · FilterFrameText x=90 y=59 width=90 height=20 font `Arial,12,0xbaad89,true,,,,,right`
  - `core.SmallValueIcon` · ScaleFrameImage x=182 y=72
    - `asset.core.SmallPointImg` · bitmap x=0
      - `asset.core.SmallPointImg` · bitmap 23×21 (bottle.swf)
    - `asset.core.SmallPointImg` · bitmap x=0
      - `asset.core.SmallPointImg` · bitmap 23×21 (bottle.swf)
  - `core.TryOnButton` · TextButton x=13 y=67 width=80 height=28
    - `asset.core.tryWearBack` · bitmap 80×28 (core2.swf)
    - `core.tryWearText` · FilterFrameText width=70 height=20 font `Arial,12,0xfffbe8,,,,,,center`
  - `core.GrayFilter` · ColorMatrixFilter 
  - `shop.ShopMainBuyFrame` · ShopMainBuyFrame  ← `core.QuickBuyFrame`
  - `shop.timeBuyDiscountMc` · MovieImage x=7 y=30
    - `asset.shop.DiscountMC` · sprite 9 frames (shop.swf)
  - texts: `task.view.shopFrame.Purchase` “Limitada”; `funny.view.FunnyHotBuyItem.price1` “Preço original: {0}”; `funny.view.FunnyHotBuyItem.price2` “Preço atual: {0}”; `Task.view.GoodsItem5.timeLable.text` “Restante:”
  - subviews: `BaseItemView`, `ShopMainBuyFrame`

### funny.view.FunnyHotBuyView

- **FunnyHotBuyView** (`core_module:funny/view/FunnyHotBuyView.as`)
  - `asset.funny.funnyRightViewBack1` · bitmap width=527 height=417
    - `asset.funny.funnyRightViewBack1` · bitmap 533×419 (funny.swf)
  - `funnyRightView.title` · GradientText x=20 y=3 width=200 height=22
    - `funnyRightView.title.Field` · FilterFrameText width=200 height=22 font `Arial,16,0xffffff,true,,,,,center`
  - `funnyHotBuyView.panel` · ScrollPanel height=378 ← `funnyRightView.panel`
  - `funnyRightView.describeText` · FilterFrameText x=5 y=0 width=483 height=22 font `Arial,12,0xf2e4a5,,,,,,left`
  - `asset.funny.rewardTitleBack` · bitmap x=0 y=20 width=489
    - `asset.funny.rewardTitleBack` · bitmap 255×37 (funny.swf)
  - `funny.HotBuyImage` · ScaleFrameImage x=20 y=81
    - `asset.funny.hotBuyImage` · bitmap 121×17 (funny.swf)
    - `asset.funny.vipHotBuyImage` · bitmap 165×17 (funny.swf)
  - `funnyHotBuyView.goodsBack` · ScaleBitmapImage y=107 width=504 height=270
    - `asset.funny.funnyRightViewBack3` · bitmap 67×67 (funny.swf)
  - `funny.funnyBagView.rechargeBtn` · IconButton x=365 y=-5 width=163 height=42
    - `asset.funny.rechargeBack` · bitmap 163×42 (funny.swf)
    - `asset.funny.rechargeIcon` · bitmap 70×23 (funny.swf)
  - texts: `funny.view.FunnyBagView.title` “Introdução do Evento”; `funny.view.FunnyFrame.FunnyHotBuyView.vipDescribeText` “Durante o Evento, irá aparecer novos itens na área de VIP da”; `funny.view.FunnyFrame.FunnyHotBuyView.describeText` “Durante o evento, será lançado itens com promoção na Loja, t”
  - subviews: `FunnyHotBuyItem`

### funny.view.FunnyLeftButton

- **FunnyLeftButton** (`core_module:funny/view/FunnyLeftButton.as`)
  - `funnyLeftButton.title` · GradientText x=28 y=9 width=140 height=22
  - `asset.groupbuy.tuangouicon` · bitmap x=-1 y=-1
    - `asset.groupbuy.tuangouicon` · bitmap 67×61 (groupbuy.swf)
  - `asset.funny.newIcon` · bitmap x=-1 y=-1
    - `asset.funny.newIcon` · bitmap 62×61 (funny.swf)
  - `asset.funny.leftIcon` · bitmap x=-2 y=-2
    - `asset.funny.leftIcon` · bitmap 63×61 (exchargeall.swf)
  - `asset.funny.leftBtn1` · bitmap 193×55 (funny.swf)
  - `asset.funny.leftBtn2` · bitmap 193×55 (funny.swf)
  - `asset.funny.leftBtn3` · bitmap 192×38 (funny.swf)
  - `asset.funny.leftBtn4` · bitmap 192×38 (funny.swf)

### funny.view.FunnyMutiFrame

- **FunnyMutiFrame**: “X-Troca” (`core_module:funny/view/FunnyMutiFrame.as`)
  - `funny.view.FunnyMutiFrame` · FunnyMutiFrame  ← `core.SpliteItemFrame`
  - `asset.core.SpliteInputBack` · bitmap x=82 y=11
    - `asset.core.SpliteInputBack` · bitmap 151×26 (core.swf)
  - `core.ConfirmBtn` · TextButton x=70 y=48 ← `core.NewAlertButton`
  - `asset.core.InputAlertTextStyle` · bitmap x=-17 y=5
    - `asset.core.InputAlertTextStyle` · bitmap 96×36 (core.swf)
  - `core.InputTextStyle` · FilterFrameText x=86 y=16 width=145 height=20 font `Arial,12,0x8d8d8d,,,,,,left`
  - texts: `funny.view.FunnyMutiFrame.titleText` “X-Troca”; `public.confirm` “Confirmar”

### funny.view.GoddessDoubleForgeActivityView

- **GoddessDoubleForgeActivityView** (`core_module:funny/view/GoddessDoubleForgeActivityView.as`)
  - `asset.funny.goddessDoubleForgeBg` · bitmap 
    - `asset.funny.goddessDoubleForgeBg` · bitmap 531×419 (funny.swf)
  - `funny.goddessTime` · FilterFrameText x=270 y=398 width=300 height=25 font `Arial,12,0xfb3b06,,,,,,left`

### funny.view.MultiImageSwitchView

- **MultiImageSwitchView** (`core_module:funny/view/MultiImageSwitchView.as`)
  - `homepageTop.Loading` · IconLoading x=385 y=140
  - `funny.muneItem` · muneItem 
  - subviews: `IconLoading`

### funny.view.TiroFunnyButton

- **TiroFunnyButton** (`core_module:funny/view/TiroFunnyButton.as`)
  - `funny.leftBtn` · TiroFunnyButton x=0 y=0 width=193 height=55
    - `asset.funny.tiroFunnyBtnBg1` · bitmap 192×53 (funny.swf)
    - `asset.funny.tiroFunnyBtnBg2` · bitmap 192×53 (funny.swf)
  - `asset.funny.leftIcon` · bitmap x=-2 y=-2
    - `asset.funny.leftIcon` · bitmap 63×61 (exchargeall.swf)
  - `asset.funny.timeOverIcon` · bitmap x=-2 y=-2
    - `asset.funny.timeOverIcon` · bitmap 56×51 (funny.swf)
  - _no style/symbol_: `asset.funny.tiroBtnTitle`

### funny.view.TiroFunnyFrame

- **TiroFunnyFrame**: “Surpresas durante o Evento de Abertura do Servidor. Prêmio o aguardando.” (`core_module:funny/view/TiroFunnyFrame.as`)
  - `funny.view.TiroFunnyFrame` · TiroFunnyFrame width=772 height=619 ← `core.Frame1`
  - `funny.TiroFunnyFrameBack` · Scale9CornerImage x=0 y=0 width=737 height=507 ← `core.describeBackground_style11`
  - `asset.funny.gridSplitLine` · bitmap x=195 y=0
    - `asset.funny.gridSplitLine` · bitmap 8×505 (funny.swf)
  - `asset.funny.leftBg` · bitmap x=5 y=3
    - `asset.funny.leftBg` · bitmap 192×500 (funny.swf)
  - `funny.TiroRightView` · TiroRightView x=200 y=5
  - `funny.TiroLeftView` · TiroFunnyLeftView x=0 y=0
  - texts: `active.funny.TiroFunnyFrame.titleTxt` “Surpresas durante o Evento de Abertura do Servidor. Prêmio o”
  - subviews: `TiroFunnyLeftView`, `TiroRightView`

### funny.view.TiroFunnyItem

- **TiroFunnyItem** (`core_module:funny/view/TiroFunnyItem.as`)
  - `funny.TiroFunnyItem` · TiroFunnyItem x=0 y=0
  - `asset.funny.tiroFunnySplitLine` · bitmap x=0 y=73
    - `asset.funny.tiroFunnySplitLine` · bitmap 527×3 (funny.swf)
  - `funny.tiroFunny.title01` · FilterFrameText x=5 y=31 width=150 height=70 font `Arial,14,0xf4e3a6,,,,,,center`
  - `funny.tiroFunny.getBtn` · BaseButton x=398 y=21
    - `asset.funny.tiroFunnyGetBtn` · bitmap 91×34 (funny.swf)
  - `asset.funny.tiroFunny.getImg` · bitmap x=411 y=10
    - `asset.funny.tiroFunny.getImg` · bitmap 72×49 (funny.swf)
  - `funny.tiroFunny.firsstKillGradientText` · GradientText x=363 y=33 width=70 height=20
    - `funny.tiroFunnyFirstKillTxt` · FilterFrameText width=150 height=20 font `Arial,16,0xffffff,true,,,,,center`
  - `asset.funny.firstKillIcon` · bitmap x=402 y=0
    - `asset.funny.firstKillIcon` · bitmap 95×83 (funny.swf)
  - `funny.tiroFunny.BaseItemView` · BaseItemView  ← `feedBackFrame.BaseItemView`
  - `funny.tirofunny.itemEffect` · MovieImage x=-2 y=-4
    - `asset.funny.TiroItemEffect` · sprite 44 frames (funny.swf)
  - `funny.tirofunny.itemEffect02` · MovieImage x=-3 y=-4
    - `asset.funny.TiroItemEffect02` · sprite 44 frames (funny.swf)
  - `funny.tiroFunny.itemHbox` · HBox x=161 y=5
  - texts: `feedback.FeedBackItem.outDate` “Evento expirado”
  - subviews: `BaseItemView`

### funny.view.TiroFunnyLeftView

- **TiroFunnyLeftView** (`core_module:funny/view/TiroFunnyLeftView.as`)
  - `funny.TiroLeftView` · TiroFunnyLeftView x=0 y=0
  - `funnyFrame.leftVBox` · VBox x=3 y=3
  - `funny.tiroFunny.preBtn` · BaseButton x=40 y=468 ← `auction.prePageBtn`
  - `funny.tiroFunny.nextBtn` · BaseButton x=144 y=468 ← `auction.nextPageBtn`
  - `funny.tiroFunny.pageText` · FilterFrameText x=77 y=473 ← `auction.PageTxt`
  - `funny.leftBtn` · TiroFunnyButton x=0 y=0 width=193 height=55
    - `asset.funny.tiroFunnyBtnBg1` · bitmap 192×53 (funny.swf)
    - `asset.funny.tiroFunnyBtnBg2` · bitmap 192×53 (funny.swf)
  - subviews: `TiroFunnyButton`

### funny.view.TiroLeftView

- **TiroLeftView** (`core_module:funny/view/TiroLeftView.as`)
  - `funnyFrame.leftVBox` · VBox x=3 y=3
  - `funny.tiroFunny.preBtn` · BaseButton x=40 y=468 ← `auction.prePageBtn`
  - `funny.tiroFunny.nextBtn` · BaseButton x=144 y=468 ← `auction.nextPageBtn`
  - `funny.tiroFunny.pageText` · FilterFrameText x=77 y=473 ← `auction.PageTxt`
  - `funny.leftBtn` · TiroFunnyButton x=0 y=0 width=193 height=55
    - `asset.funny.tiroFunnyBtnBg1` · bitmap 192×53 (funny.swf)
    - `asset.funny.tiroFunnyBtnBg2` · bitmap 192×53 (funny.swf)
  - subviews: `TiroFunnyButton`

### funny.view.TiroRightView

- **TiroRightView** (`core_module:funny/view/TiroRightView.as`)
  - `funny.TiroRightView` · TiroRightView x=200 y=5
  - `asset.funny.gridSplitLine2` · bitmap x=0 y=140
    - `asset.funny.gridSplitLine2` · bitmap 536×8 (funny.swf)
  - `asset.funny.tiroFunnyBotton` · bitmap x=1 y=456
    - `asset.funny.tiroFunnyBotton` · bitmap 531×40 (funny.swf)
  - `asset.funny.tiroFunnyGridBg` · bitmap x=1 y=146
    - `asset.funny.tiroFunnyGridBg` · bitmap 532×312 (funny.swf)
  - `funny.TiroFunnyScrollPanel` · ScrollPanel x=6 y=150 width=522 height=301
    - `core.VScrollbar02` · Scrollbar width=21 height=200
      - `core.Scrollbar02_Back` · ScaleBitmapImage width=15 height=24
        - `asset.core.scrollbar02_bg` · bitmap 15×24 (core2.swf)
      - `core.Scrollbar02_Step` · BaseButton width=21 height=56
        - `core.scrollbar02_stepAsset` · ScaleBitmapImage width=21 height=56
          - `asset.core.scrollbar02_step` · bitmap 21×56 (core2.swf)
      - `core.Scrollbar02_Up` · BaseButton width=11 height=10
        - `asset.core.scrollbar02_up` · bitmap 11×10 (core2.swf)
      - `core.Scrollbar02_Down` · BaseButton width=11 height=10
        - `asset.core.scrollbar02_down` · bitmap 11×10 (core2.swf)
    - `core.HScrollbar01` · Scrollbar width=200 height=23 ← `core.VScrollbar01`
  - `funny.tiroFunny.itemVbox` · VBox x=0 y=0
  - `funny.tiroFunny.remainTimeText` · FilterFrameText x=115 y=466 ← `funnyRightView.remainTimeText`
  - `funny.tiroFunny.startRemainTimeText` · FilterFrameText x=115 y=466 font `Arial,16,0xFF0000,true,,,,,center` ← `funnyRightView.remainTimeText`
  - `funny.TiroFunnyItem` · TiroFunnyItem x=0 y=0
  - _no style/symbol_: `asset.funny.tiroFunnyTitle`
  - texts: `funny.FunnyRightView.active.remainTime` “Contagem do Evento: {0}”; `feedback.FeedBackItem.outDate` “Evento expirado”; `funny.FunnyRightView.active.remainTime02` “Contagem do Evento: {0}”
  - subviews: `TiroFunnyItem`

### im.view.IMConsortiaGroupChatMsgBoxItem

- **IMConsortiaGroupChatMsgBoxItem** (`core_module:im/view/IMConsortiaGroupChatMsgBoxItem.as`)
  - `core.IMConsortiaGroupChatMsgBoxItemNameTxt` · FilterFrameText x=65 y=2 width=140 height=20 font `Arial,12,0xebd59b`
  - `core.IMConsortiaGroupChatMsgBoxItemMsgNumTxt` · FilterFrameText x=130 y=2 width=30 height=20 font `Arial,12,0xebd59b,,,,,,right`
  - `asset.core.IMMsgBoxItemMouseOverBg` · bitmap x=0 y=0
    - `asset.core.IMMsgBoxItemMouseOverBg` · bitmap 174×24 (core.swf)
  - texts: `consortiagroupchat.msgBoxItemNameTxt` “Chat da Guilda”

### im.view.IMMsgBoxItem

- **IMMsgBoxItem** (`core_module:im/view/IMMsgBoxItem.as`)
  - `core.IMMsgBoxItemNameTxt` · FilterFrameText x=0 y=2 width=160 height=20 font `Arial,12,0xebd59b`
  - `core.IMMsgBoxItemMsgNumTxt` · FilterFrameText x=117 y=2 width=30 height=20 font `Arial,12,0xebd59b,,,,,,right`
  - `core.IMMsgBoxItemDelBtn` · BaseButton x=150 y=5
    - `asset.core.IMMsgBoxItemDelBtnImg` · bitmap 14×14 (core.swf)
  - `asset.core.IMMsgBoxItemMouseOverBg` · bitmap x=0 y=0
    - `asset.core.IMMsgBoxItemMouseOverBg` · bitmap 174×24 (core.swf)

### im.view.IMMsgBoxView

- **IMMsgBoxView** (`core_module:im/view/IMMsgBoxView.as`)
  - `core.IMMsgBoxBg` · ScaleUpDownImage width=184 height=200
    - `asset.core.IMMsgBoxBgTop` · bitmap 184×37 (core.swf)
    - `asset.core.IMMsgBoxBgMid` · bitmap 184×6 (core.swf)
    - `asset.core.IMMsgBoxBgBottom` · bitmap 184×20 (core.swf)
  - `core.IMMsgBoxCancleShineBtn` · BaseButton x=117 y=5
    - `asset.core.IMMsgBoxCancleBtnImg` · bitmap 60×19 (core.swf)
  - `core.IMMsgBoxItemVBox` · VBox x=5 y=34
  - subviews: `IMMsgBoxItem`

### mainBar.ChatBar

- **ChatBar** (`core_module:mainBar/ChatBar.as`)
  - `chatII.VBox` · VBox x=0 y=0
  - `chatII.ChatBugleViewII` · ChatBugleViewII y=0
  - `chatII.ChatOutputViewII` · ChatOutputViewII y=0
  - `chatII.ChatInputViewII` · ChatInputViewII y=0
  - `chatII.ChatOutputUpBtn` · BaseButton x=275 y=-61
    - `asset.chatII.ChatOutputUpBtn` · bitmap 20×21 (chat.swf)
  - `chatII.ChatOutputDownBtn` · BaseButton x=296 y=-61
    - `asset.chatII.ChatOutputDownBtn` · bitmap 20×21 (chat.swf)
  - texts: `chat.view.ChatView.command04` “Expandir”; `chat.view.ChatView.command05` “Diminuir”
  - subviews: `ChatBugleViewII`, `ChatInputViewII`, `ChatOutputViewII`

### mainBar.SmallMapBar

- **SmallMapBar** (`core_module:mainBar/SmallMapBar.as`)
  - `asset.smallMap.BgMcAsset` · BgMcAsset 
  - `asset.smallMap.zoomBtnBg` · bitmap x=30 y=103
    - `asset.smallMap.zoomBtnBg` · bitmap 106×22 (smallmap.swf)
  - `smallMap.ZoomBtn` · BaseButton x=110 y=103
    - `asset.smallMap.zoomBtnImg` · bitmap 
      - `asset.smallMap.zoomBtnImg` · bitmap 20×20 (smallmap.swf)
  - `smallMap.InputPosText` · FilterFrameText x=34 y=104 width=33 height=20 font `Arial,12,0xffecb7,,,,,,right`
  - `smallMap.InputPosYText` · FilterFrameText x=74 y=104 width=33 height=20 font `Arial,12,0xffecb7,,,,,,left`
  - `smallMap.InputPosCText` · FilterFrameText x=66 y=103 width=7 height=20 font `Arial,12,0xffecb7,,,,,,left`
  - `smallMap.LocateArmyBtn` · IconButton x=60 y=125 ← `smallMap.BaseBtn`
    - `asset.smallMap.locateArmyImg` · bitmap 
      - `asset.smallMap.locateArmyImg` · bitmap 33×13 (smallmap.swf)
  - `smallMap.campaignTransmitBtn` · IconButton x=32 y=150 width=48 height=24
    - `asset.smallMap.transmitBtnImg` · bitmap 48×24 (smallmap.swf)
    - `asset.smallMap.transmitTxtImg` · bitmap 45×15 (smallmap.swf)
  - `smallMap.ResultCastleBtn` · IconButton x=7 y=125 ← `smallMap.BaseBtn`
    - `asset.smallMap.ArmyGoToAsset` · bitmap 42×12 (smallmap.swf)
  - `smallMap.AttackBtn` · IconButton x=85 y=150 width=48 height=24
    - `asset.smallMap.transmitBtnImg` · bitmap 48×24 (smallmap.swf)
    - `asset.smallMap.AttackBtnImg` · bitmap 43×14 (smallmap.swf)
  - `smallMap.LocateHkeeBtn` · IconButton x=113 y=125 ← `smallMap.BaseBtn`
    - `asset.smallMap.locateHkeeImg` · bitmap 
      - `asset.smallMap.locateHkeeImg` · bitmap 43×12 (smallmap.swf)
  - `smallMap.SpaceBtn` · IconButton x=31 y=18 width=114 height=46
    - `asset.smallMap.SpaceBtnAsset` · bitmap 111×46 (smallmap.swf)
    - `asset.smallMap.SpaceBtnTxt` · bitmap 93×42 (smallmap.swf)
  - `smallMap.SpaceBtnTip` · StripView x=0 y=0
  - `smallMap.CastleBtn` · IconButton x=28 y=18 width=114 height=46
    - `asset.smallMap.CastleBtnAsset` · bitmap 111×46 (smallmap.swf)
    - `asset.smallMap.CastleBtnTxt` · bitmap 80×28 (smallmap.swf)
  - `smallMap.OutercityBtn` · IconButton x=28 y=18 width=114 height=46
    - `asset.smallMap.OutercityBtnAsset` · bitmap 111×46 (smallmap.swf)
    - `asset.smallMap.OutercityBtnTxt` · bitmap 66×31 (smallmap.swf)
  - `smallMap.TitleText` · FilterFrameText x=27 y=-2 width=117 height=20 font `Arial,12,0xeae5c0,,,,,,center`
  - `smallMap.HelpBtn` · BaseButton x=65 y=230 width=90 height=21
    - `asset.core.HelpBg` · bitmap 70×21 (core2.swf)
  - `smallMap.CustomerServiceBtn` · BaseButton x=102 y=60
    - `asset.customerservice.MainBtnTxt` · bitmap 33×33 (smallmap.swf)
  - `smallMap.DayGuideBtn` · BaseButton x=-10 y=0
    - `asset.smallMap.DailyRoutineBtnAsset` · bitmap 45×45 (smallmap.swf)
  - `smallMap.NoviceCloseBtn` · BaseButton x=248 y=5
    - `asset.smallMap.NoviceCloseBtnAsset` · bitmap 72×72 (smallmap.swf)
  - `smallMap.UpdateBtn` · BaseButton x=126 y=39
    - `asset.smallMap.UpdateBtnAsset` · bitmap 33×35 (smallmap.swf)
  - `smallMap.SetBtn` · BaseButton x=138 y=9
    - `asset.smallMap.SetBtnAsset` · bitmap 33×33 (smallmap.swf)
  - `smallMap.RankingBtn` · BaseButton x=-4 y=10
    - `asset.smallMap.RankingBtnAsset` · bitmap 33×33 (smallmap.swf)
  - `smallMap.MailBtn` · BaseButton x=12 y=38
    - `asset.smallMap.MailBtnAsset` · bitmap 34×34 (smallmap.swf)
  - `smallMap.OthersShowBtn` · BaseButton x=-7 y=-4
    - `asset.smallMap.OthersShowBtnAsset` · bitmap 33×33 (smallmap.swf)
  - `smallMap.OthersShowBtnTip` · StripView x=45 y=65
  - `smallMap.OthersHideBtn` · BaseButton x=38 y=62
    - `asset.smallMap.OthersHideBtnAsset` · bitmap 33×33 (smallmap.swf)
  - `smallMap.FunPreviewBtn` · IconButton x=95 y=140 width=73 height=24
    - `smallMap.FunPreviewBtnBack` · ScaleBitmapImage 
      - `asset.smallMap.CampaignGuidBtnOverAsset` · bitmap 64×23 (smallmap.swf)
    - `asset.smallMap.funpreviewBtnIconAsset` · bitmap 53×12 (smallmap.swf)
  - `smallMap.FaceBookBtn` · BaseButton x=102 y=110
    - `asset.smallMap.FaceBookImg` · bitmap 68×20 (smallmap.swf)
  - `smallMap.guideTaskBtn` · BaseButton x=-100 y=210 width=61 height=67
    - `asset.smallMap.guideTaskBtnBg` · bitmap 64×70 (smallmap.swf)
  - `asset.smallmap.guideTaskBtnEff` · guideTaskBtnEff 
  - `asset.smallMap.guideTaskTxt` · bitmap x=-143 y=254
    - `asset.smallMap.guideTaskTxt` · bitmap 72×24 (smallmap.swf)
  - `asset.smallmap.getRewardbg` · bitmap x=-114 y=213
    - `asset.smallmap.getRewardbg` · bitmap 45×28 (smallmap.swf)
  - `smallMap.getRewardTxt_2` · GradientText x=-108 y=217 width=30 height=16
    - `smallMap.getRewardTxt` · FilterFrameText width=30 height=16 font `Arial,12,0xffffff,,,,,,center`
  - `asset.smallmap.guideTaskRewardEff` · guideTaskRewardEff 
  - `smallMap.mailStrip` · StripView x=15 y=45
  - `smallMap.friendsStrip` · StripView x=79 y=74
  - `smallMap.TimeIcon` · Image x=70 y=68
    - `asset.smallMap.TimeIcon` · bitmap 33×33 (smallmap.swf)
  - `mainToolBar.BroadCastFrame` · UpdateBroadCastFrame width=651 height=560 ← `core.Frame1`
  - `worldboss.pvpHelperFrame` · SimpleHelpFrame  ← `core.SimpleHelpFrame`
  - `email.EmailFrame` · EmailFrame width=383 height=503 ← `core.Frame2`
  - texts: `guidetask.GuideTaskFrame.titleTxt` “Objetivo dos 7 dias”; `mainBar.SmallMapBar.zoomBtnTipData` “Localizar entrada de coordenadas”; `mainBar.SmallMapBar.locateHkeeBtnTipData` “Localizar coordenadas do castelo”; `mainBar.SmallMapBar.locateArmyBtnTipData` “Localizar coordenadas do Herói”; `mainBar.SmallMapBar.transmitBtnTipData` “Transferir Herói para qualquer lugar”; `mainBar.SmallMapBar.returnCastleBtnTipData` “Transferir de volta à cidade”; `mainBar.SmallMapBar.attackBtnTipData` “Atacar outro jogador \nAtalho:X”; `ui.queuebar.view.getReward.text` “Coletar”
  - subviews: `EmailFrame`, `StripView`, `SimpleHelpFrame`, `UpdateBroadCastFrame`

### mainBar.StripView

- **StripView** (`core_module:mainBar/StripView.as`)
  - `armyII.SoulView.StripView` · StripView x=0 y=0
    - `dragonsoul.MultipleLineTip` · MultipleLineTip 

### mainBar.TimeBoxView

- **TimeBoxView** (`core_module:mainBar/TimeBoxView.as`)
  - `timebox.TimeBoxMc` · TimeBoxMc 
  - `asset.timeBox.timeBGAsset` · bitmap x=-7 y=43
    - `asset.timeBox.timeBGAsset` · bitmap 79×26 (box.swf)
  - `timeBox.TimeDown` · TimeDownView x=-7 y=45
    - `bossbox.downTimeTxt` · FilterFrameText width=76 height=22 font `Arial,16,0xffde00,,,,,,center`
  - `TimeBox.TimeTip` · StripView width=69 height=70
  - subviews: `StripView`, `BoxMovieView`, `TimeDownView`

### mainBar.TipsBar

- **TipsBar** (`core_module:mainBar/TipsBar.as`)
  - `taskTrace.MessageBtnListView` · MessageBtnListView 
  - subviews: `HBox`, `MessageBtnListView`

### mainBar.vicePassword.BtnResetVp

- **BtnResetVp** (`core_module:mainBar/vicePassword/BtnResetVp.as`)
  - `vicepassword.btnReset` · BtnResetVp x=10 y=265
  - `vicepassword.imgReset` · IconButton x=0 y=-4 width=21 height=23
    - `asset.vicepassword.reset` · bitmap 21×23 (vicepassword.swf)
  - `vicepassword.btnresettxt` · FilterFrameText x=20 y=0 height=22 font `Arial,12,0x31ff15,,,,,,left`
  - texts: `mainBar.vicePassword.setviewreset` “Redefinir”

### mainBar.vicePassword.ChangeVPView

- **ChangeVPView**: “Alterar Senha” (`core_module:mainBar/vicePassword/ChangeVPView.as`)
  - `vicepassword.changevpview` · ChangeVPView width=314 height=386 ← `core.Frame2`
  - `vicepassword.back` · Scale9CornerImage x=-3 y=-4 width=288 height=300 ← `core.describeBackground_style11`
  - `asset.vicepassword.bgchange` · sprite (vicepassword.swf)
  - `vicepassword.AlertButtonConfirm_2` · IconButton x=38 y=230 ← `core.AlertButtonConfirm_1`
    - `asset.core.AlertBtnStyle_02` · bitmap 96×40 (core2.swf)
  - `vicepassword.AlertButtonCancel_2` · IconButton x=150 y=230 ← `core.AlertButtonConfirm_1`
    - `asset.core.CancelTxtAsset_01` · bitmap 75×18 (core2.swf)
  - `vicepassword.change.p1` · FilterFrameText x=122 y=16 width=125 height=31 font `Arial,12,0x4a4a4a`
  - `vicepassword.change.p2` · FilterFrameText x=122 y=42 width=125 height=31 font `Arial,12,0x4a4a4a`
  - `vicepassword.change.p3` · FilterFrameText x=122 y=68 width=125 height=31 font `Arial,12,0x4a4a4a`
  - `vicepassword.p3` · FilterFrameText x=19 y=100 width=255 height=110 font `Arial,12,0xe0c151,,,,,,left`
  - `vicepassword.btnReset` · BtnResetVp x=10 y=265
  - `core.vicepassword.HelpFrame` · SimpleHelpFrame  ← `core.SimpleHelpFrame`
  - texts: `mainBar.vicePassword.changeviewtitle` “Alterar Senha”; `mainBar.vicePassword.setviewinputdes` “Favor inserir 6 digitos”; `mainBar.vicePassword.setviewdes` “1. Configure o bloqueio de item para bloquear equipamento, i”; `vicepassword.description8` “A senha contém outros simbolos,  só pode introduzir algarism”; `vicepassword.description9` “Favor inserir 6 algarismos”; `vicepassword.description5` “72 horas após o reset, o bloqueio de itens será desativado, ”; `public.confirm` “Confirmar”; `public.cancel` “Cancelar”
  - subviews: `BtnResetVp`, `SimpleHelpFrame`

### mainBar.vicePassword.ConfirmVPView

- **ConfirmVPView**: “Inserir Senha” (`core_module:mainBar/vicePassword/ConfirmVPView.as`)
  - `vicepassword.checkvpview` · ConfirmVPView width=292 height=179 ← `core.Frame2`
    - `core.quickBuyFrameBg` · MutipleImage 
      - `core.AlertFrameBg` · MutipleImage 
        - `core.AlertFrameBaseBg` · Scale9CornerImage 
          - `asset.core.framestyle03_scale9bg1` · bitmap 42×42 (framebg.swf)
          - `asset.core.framestyle03_scale9bg2` · bitmap 42×42 (framebg.swf)
          - `asset.core.framestyle03_scale9bg3` · bitmap 42×42 (framebg.swf)
          - `asset.core.framestyle03_scale9bg4` · bitmap 42×18 (framebg.swf)
          - `asset.core.framestyle03_scale9bg5` · bitmap 42×18 (framebg.swf)
          - `asset.core.framestyle03_scale9bg6` · bitmap 42×18 (framebg.swf)
          - `asset.core.framestyle03_scale9bg7` · bitmap 42×42 (framebg.swf)
          - `asset.core.framestyle03_scale9bg8` · bitmap 42×42 (framebg.swf)
          - `asset.core.framestyle03_scale9bg9` · bitmap 42×42 (framebg.swf)
      - `core.FrameTitleImage2` · Image width=229 height=17
        - `asset.core.frameTitleImage2` · bitmap 229×17 (framebg.swf)
  - `vicepassword.backcheck` · Scale9CornerImage x=-3 y=-4 width=288 height=132 ← `core.describeBackground_style11`
  - `asset.vicepassword.bgcheck` · sprite (vicepassword.swf)
  - `vicepassword.confirm.p1` · FilterFrameText x=151 y=33 width=125 height=31 font `Arial,12,0x4a4a4a`
  - `vicepassword.checkAlertButtonConfirm_2` · IconButton x=38 y=72 ← `core.AlertButtonConfirm_1`
    - `asset.core.AlertBtnStyle_02` · bitmap 96×40 (core2.swf)
  - `vicepassword.checkAlertButtonCancel_2` · IconButton x=160 y=72 ← `core.AlertButtonConfirm_1`
    - `asset.core.CancelTxtAsset_01` · bitmap 75×18 (core2.swf)
  - texts: `mainBar.vicePassword.checkviewtitle` “Inserir Senha”; `mainBar.vicePassword.setviewinputdes` “Favor inserir 6 digitos”; `vicepassword.description8` “A senha contém outros simbolos,  só pode introduzir algarism”; `vicepassword.description9` “Favor inserir 6 algarismos”; `vicepassword.description12` “Favor inserir senha”; `vicepassword.description6` “O formato da senha introduzida está incorrecto”

### mainBar.vicePassword.SetVPView

- **SetVPView**: “Senha” (`core_module:mainBar/vicePassword/SetVPView.as`)
  - `vicepassword.setvpviewui` · SetVPView width=314 height=386 ← `core.Frame2`
  - `vicepassword.back` · Scale9CornerImage x=-3 y=-4 width=288 height=300 ← `core.describeBackground_style11`
  - `asset.vicepassword.bgset` · sprite (vicepassword.swf)
  - `vicepassword.AlertButtonConfirm_2` · IconButton x=38 y=230 ← `core.AlertButtonConfirm_1`
    - `asset.core.AlertBtnStyle_02` · bitmap 96×40 (core2.swf)
  - `vicepassword.AlertButtonCancel_2` · IconButton x=150 y=230 ← `core.AlertButtonConfirm_1`
    - `asset.core.CancelTxtAsset_01` · bitmap 75×18 (core2.swf)
  - `vicepassword.p1` · FilterFrameText x=122 y=32 width=160 height=31 font `Arial,12,0x4a4a4a`
  - `vicepassword.p2` · FilterFrameText x=122 y=66 width=165 height=31 font `Arial,12,0x4a4a4a`
  - `vicepassword.p3` · FilterFrameText x=19 y=100 width=255 height=110 font `Arial,12,0xe0c151,,,,,,left`
  - `vicepassword.serviceText` · FilterFrameText x=185 y=265 width=100 height=20 font `Arial,14,0xff9915,,,true,,,center`
  - `vicepassword.firstRewardCon` · Component x=-20 y=305
  - `vicepassword.rewardBack` · Scale9CornerImage width=320 height=125 ← `core.AlertFrameBaseBg`
  - `vicepassword.rewardText` · FilterFrameText x=25 y=20 width=280 height=40 font `Arial,12,0xe0c151,,,,,,left`
  - `vicepassword.rewardHbox` · HBox x=30 y=50
  - `core.fallGoods.BaseItemView` · BaseItemView 
    - `core.fallGoods.HeroBagEquipBack` · ScaleBitmapImage width=50 height=50 ← `core.goods.ItemBack`
    - `core.fallGoods.BaseItemViewIcon` · BaseIconView x=1 y=1
      - `asset.core.IconLoading` · sprite 42 frames (core2.swf)
    - `core.GoodsProfileBG` · ScaleFrameImage 
      - `asset.core.BagProfileGreen` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileBlue` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfilePurple` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileOrange` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileRed` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileBlackKing` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileFashion` · bitmap 45×45 (core.swf)
    - `core.BaseItemText` · FilterFrameText x=0 y=26 width=45 height=18 font `Arial,12,0xffffff,true,,,,,right`
    - `core.goods.Strengthen` · MovieImage x=-50 y=-50
      - `asset.core.goods.Strengthen` · Strengthen 
  - `core.vicepassword.HelpFrame` · SimpleHelpFrame  ← `core.SimpleHelpFrame`
  - texts: `mainBar.vicePassword.setviewtitle` “Senha”; `mainBar.vicePassword.setviewinputdes` “Favor inserir 6 digitos”; `mainBar.vicePassword.setviewdes` “1. Configure o bloqueio de item para bloquear equipamento, i”; `mainBar.vicePassword.serviceText.text` “SUPPORT”; `mainBar.vicePassword.rewardText.text` “Set up the first time to get the following rewards:”; `mainBar.SmallMapBar.customerservice` “Seu problema está sendo solucionado, aguarde resposta antes ”; `vicepassword.description8` “A senha contém outros simbolos,  só pode introduzir algarism”; `vicepassword.description9` “Favor inserir 6 algarismos”
  - subviews: `BaseItemView`, `SimpleHelpFrame`

### mainBar.view.AppellGetView

- **AppellGetView** (`core_module:mainBar/view/AppellGetView.as`)
  - `appell.AppellFrame.CurrentTitle` · GradientText x=255 y=412
    - `appell.AppellFrame.CurrentTitleStyle` · FilterFrameText width=240 height=25 font `Arial,16,0xffffff,true,,,,,left`
  - `appell.GetTitleTips` · GetTitleTips x=0 y=0
  - subviews: `SimpleMovie`

### mainBar.view.BloodExperenceView

- **BloodExperenceView** (`core_module:mainBar/view/BloodExperenceView.as`)
  - `resourceBar.BloodExperenceView` · BloodExperenceView x=276 y=64
  - `resourcesBar.QuickBuyBtn` · SelectedButton 
    - `asset.resourceBar.QuickBuyBtn` · bitmap 18×17 (resourcesbar.swf)
    - `asset.resourceBar.QuickBuyBtn` · bitmap 18×17 (resourcesbar.swf)

### mainBar.view.BoxMovieView

- **BoxMovieView** (`core_module:mainBar/view/BoxMovieView.as`)
  - `box.downBoxSprite` · Sprite y=-100
  - `box.DownBoxImg` · Image x=-100 y=-90
    - `asset.box.DownBoxImg` · bitmap 
      - `asset.box.DownBoxImg` · bitmap 307×205 (box.swf)
  - `box.waiteBox` · MovieImage 
    - `asset.Box.DownBox` · sprite 53 frames labels: startTip (box.swf)

### mainBar.view.ChoosePayTypeFrame

- **ChoosePayTypeFrame** (`core_module:mainBar/view/ChoosePayTypeFrame.as`)
  - `queueBar.ChoosePayTypeFrame` · ChoosePayTypeFrame width=364 height=215 ← `core.Frame2`
  - `queueBar.QuickCodeButton` · IconButton x=20 y=105 ← `core.ConfitmSellConfitmBtn`
  - `queueBar.CloseButton` · IconButton x=178 y=105 ← `core.ConfitmSellCancelBtn`
  - `queueBar.AlertTextStyle` · FilterFrameText x=-28 width=350 height=25 font `Arial,14,0xFFefbd,,,,,,center`
  - `queueBar.AlertPromotTextStyle` · FilterFrameText x=-5 y=55 width=305 height=50 font `Arial,14,0xFFefbd,,,,,,center`
  - texts: `public.confirm1` “Confirmar”; `public.close1` “Fechar”; `public.queueBar.alertPromotText` “(Diamante vinculado prioritário)”; `mainBar.view.ChoosePayTypeFrame.tipTxtText` “Escolha modo de pagamento de aceleração de resfriamento:”

### mainBar.view.CountExperenceView

- **CountExperenceView** (`core_module:mainBar/view/CountExperenceView.as`)
  - `resourceBar.CountExperenceView` · CountExperenceView x=92 y=85
  - `resourceBar.CountValueTxt` · FilterFrameText x=0 y=-6 width=166 height=18 font `arial,12,0xffffff,,,,,,center`
  - `asset.resourcesBar.PawnProgress` · bitmap x=0
    - `asset.resourcesBar.PawnProgress` · bitmap 169×9 (resourcesbar.swf)
  - `resourcesBar.CountAlertMc` · CountAlertMc x=0 y=0

### mainBar.view.ExplainBuildItem

- **ExplainBuildItem** (`core_module:mainBar/view/ExplainBuildItem.as`)
  - `asset.castle.buildingBoxImg` · bitmap x=20
    - `asset.castle.buildingBoxImg` · bitmap 82×80 (castle.swf)
  - `castle.BuildIcon` · BaseIconView x=27 y=8
    - `asset.core.IconLoading` · sprite 42 frames (core2.swf)
  - `explainBar.ItemNodeTxt` · FilterFrameText x=90 y=0 width=335 height=80 font `Arial,14,0x0c0000,,,,,,left`
  - subviews: `BaseIconView`

### mainBar.view.ForbidConsortiaView

- **ForbidConsortiaView** (`core_module:mainBar/view/ForbidConsortiaView.as`)
  - `asset.resourcesBar.buffer.TimeBack` · bitmap x=-5 y=32 width=40
    - `asset.resourcesBar.buffer.TimeBack` · bitmap 34×15 (resourcesbar.swf)
  - `ForbidConsortiaView.buffer.TimeDownView` · TimeDownView x=0 y=0
    - `ForbidConsortiaView.buffer.TimeText` · FilterFrameText x=-3 y=30 width=40 height=18 font `arial,12,0xfefefe,,,,,,center`
  - `ForbidConsortiaView.buffer.Image` · Image x=0 y=0
    - `asset.resourcesBar.buffer.ForbidConsortia` · bitmap x=0 y=0
      - `asset.resourcesBar.buffer.ForbidConsortia` · bitmap 30×30 (resourcesbar.swf)
  - texts: `mainBar.view.ForbidConsortiaView.Tips` “Antes do tempo esgotar não é possível \ncriar ou juntar-se à”
  - subviews: `TimeDownView`

### mainBar.view.HPExperenceView

- **HPExperenceView** (`core_module:mainBar/view/HPExperenceView.as`)
  - `resourceBar.HPExperenceView` · HPExperenceView x=105 y=65
  - `resourceBar.HpValueTxt` · FilterFrameText x=0 y=-3 width=168 height=18 font `arial,12,0xffffff,,,,,,center`
  - `asset.resourcesBar.HpProgress` · bitmap x=0
    - `asset.resourcesBar.HpProgress` · bitmap 166×14 (resourcesbar.swf)
  - `resourcesBar.HpAlertMc` · HpAlertMc x=0 y=0

### mainBar.view.IndulgeFrame

- **IndulgeFrame**: “Autenticação dos nomes” (`core_module:mainBar/view/IndulgeFrame.as`)
  - `resoueceBar.IndulgeFrame` · IndulgeFrame width=533 height=366 ← `core.Frame1`
  - `resoueceBar.IndulgeFrame.Back1` · ScaleBitmapImage x=3 y=4 width=495 height=204 ← `core.describeBackground_style04`
  - `resoueceBar.IndulgeFrame.Back2` · ScaleLeftRightImage x=3 y=212 width=495 height=53 ← `core.FameBottomImage`
  - `resoueceBar.IndulgeFrame.Back3` · ScaleBitmapImage x=86 y=137 ← `core.InputBack`
  - `resoueceBar.IndulgeFrame.Back4` · ScaleBitmapImage x=86 y=170 ← `core.InputBack`
  - `resoueceBar.IndulgeFrame.SpliceLine` · ScaleBitmapImage x=8 y=92 width=490 height=2 ← `core.SpliceLine_03`
  - `resoueceBar.IndulgeFrame.Describe` · FilterFrameText x=14 y=12 width=480 height=74 font `Arial,12,0xe7c89b,,,,,,left`
  - `resoueceBar.IndulgeFrame.Alert1` · FilterFrameText x=13 y=108 width=472 height=20 font `Arial,12,0xffe1a6,,,,,,left`
  - `resoueceBar.IndulgeFrame.Alert2` · FilterFrameText x=251 y=141 width=240 height=20 font `Arial,12,0xa67a34,,,,,,left`
  - `resoueceBar.IndulgeFrame.Alert3` · FilterFrameText x=251 y=174 width=240 height=20 font `Arial,12,0xa67a34,,,,,,left`
  - `resoueceBar.IndulgeFrame.NameAlert1` · FilterFrameText x=10 y=141 width=70 height=20 font `Arial,12,0xffae01,,,,,,right`
  - `resoueceBar.IndulgeFrame.PidAlert1` · FilterFrameText x=10 y=174 width=70 height=20 font `Arial,12,0xffae01,,,,,,right`
  - `resoueceBar.IndulgeFrame.Name` · FilterFrameText x=89 y=141 width=150 height=20 font `Arial,12,0xffefbd,,,,,,center`
  - `resoueceBar.IndulgeFrame.Pid` · FilterFrameText x=89 y=174 width=150 height=20 font `Arial,12,0xffefbd,,,,,,center`
  - `resoueceBar.IndulgeFrame.Button` · IconButton x=88 y=221
    - `asset.core.PayBtn` · bitmap 131×39 (core2.swf)
    - `asset.resoueceBar.IndulgeFrame.CommitTxt` · bitmap 65×21 (resourcesbar.swf)
  - `resoueceBar.IndulgeFrame.NotButton` · IconButton x=266 y=221
    - `asset.resoueceBar.IndulgeFrame.NotBack` · bitmap 150×41 (resourcesbar.swf)
    - `asset.resoueceBar.IndulgeFrame.NotTxt` · bitmap 138×18 (resourcesbar.swf)
  - texts: `mainBar.view.IndulgeFrame.desc` “Essas informações adicionais não substituem suas informações”; `mainBar.view.IndulgeFrame.aler1` “Preencha as informações abaixo, ao enviar não poderá ser mod”; `mainBar.view.IndulgeFrame.aler2` “Preencha o seu verdadeiro nome, de modo a proteger seus dire”; `mainBar.view.IndulgeFrame.aler3` “Sua identidade é sua única prova de titularidade da sua cont”; `mainBar.view.IndulgeFrame.name` “Nome verdadeiro”; `mainBar.view.IndulgeFrame.pId` “Número de identidade”; `mainBar.view.IndulgeFrame.command01` “Nome não pode estar em branco!”; `mainBar.view.IndulgeFrame.command02` “Número de identidade incorreto!”

### mainBar.view.IndulgeInfoFrame

- **IndulgeInfoFrame**: “Alerta de mensagem anti-vício” (`core_module:mainBar/view/IndulgeInfoFrame.as`)
  - `resoueceBar.IndulgeInfoFrame` · IndulgeInfoFrame width=442 height=205 ← `core.Frame2`
  - `resoueceBar.IndulgeInfoFrame.Back1` · ScaleBitmapImage x=-18 y=4 width=405 height=68 ← `core.describeBackground_style04`
  - `resoueceBar.IndulgeInfoFrame.Back2` · ScaleLeftRightImage x=-18 y=74 width=405 height=53 ← `core.FameBottomImage`
  - `resoueceBar.IndulgeInfoFrame.Txt1` · FilterFrameText x=-7 y=11 width=88 height=20 font `Arial,14,0xe7c88b,,,,,,left`
  - `resoueceBar.IndulgeInfoFrame.Txt2` · FilterFrameText x=-7 y=38 width=384 height=20 font `Arial,14,0xe7c88b,,,,,,left`
  - `resoueceBar.IndulgeInfoFrame.Button` · TextButton x=110 y=85 width=149 height=33
    - `resoueceBar.IndulgeInfoFrame.ButtonAsset` · ScaleFrameImage 
      - `asset.resourceBar.IndulgeView.ButtonUp` · bitmap 149×33 (resourcesbar.swf)
      - `asset.resourceBar.IndulgeView.ButtonOver` · bitmap 149×33 (resourcesbar.swf)
      - `asset.resourceBar.IndulgeView.ButtonOver` · bitmap 149×33 (resourcesbar.swf)
      - `asset.resourceBar.IndulgeView.ButtonUp` · bitmap 149×33 (resourcesbar.swf)
    - `resoueceBar.IndulgeInfoFrame.ButtonTxt` · FilterFrameText width=140 height=20 font `Arial,14,0xFFefbd,true,,,,,center`
  - `resoueceBar.IndulgeFrame` · IndulgeFrame width=533 height=366 ← `core.Frame1`
  - texts: `mainBar.view.IndulgeInfoFrame.txt1` “Prezado Usuário:”; `mainBar.view.IndulgeInfoFrame.button1` “Informação Anti-Vício”; `mainBar.view.IndulgeInfoFrame.button` “Preencher informações anti-vício”; `mainBar.view.IndulgeInfoFrame.clickTips` “Após registrar, terá que acessar novamente no jogo.”; `mainBar.view.IndulgeInfoFrame.title` “Alerta de mensagem anti-vício”
  - subviews: `IndulgeFrame`

### mainBar.view.LordTrialHPExpView

- **LordTrialHPExpView** (`core_module:mainBar/view/LordTrialHPExpView.as`)
  - `rightView.hpView` · LordTrialHPExpView x=568 y=48
  - `resourceBar.HpValueTxt` · FilterFrameText x=0 y=-3 width=168 height=18 font `arial,12,0xffffff,,,,,,center`
  - `asset.resourcesBar.HpProgress` · bitmap x=0
    - `asset.resourcesBar.HpProgress` · bitmap 166×14 (resourcesbar.swf)

### mainBar.view.MessageBtnListView

- **MessageBtnListView** (`core_module:mainBar/view/MessageBtnListView.as`)
  - `taskTrace.MessageBtnListView` · MessageBtnListView 
  - subviews: `HBox`, `MessageBtnView`

### mainBar.view.MessageBtnView

- **MessageBtnView** (`core_module:mainBar/view/MessageBtnView.as`)
  - `taskTrace.MessageBtn` · BaseButton 
    - `asset.taskTrace.TaskTraceMessageBtn` · bitmap 42×42 (tasktracebar.swf)

### mainBar.view.PlayerBufferItem

- **PlayerBufferItem** (`core_module:mainBar/view/PlayerBufferItem.as`)
  - `asset.resourcesBar.buffer.TimeBack` · bitmap x=-5 y=32 width=40
    - `asset.resourcesBar.buffer.TimeBack` · bitmap 34×15 (resourcesbar.swf)
  - `resourceBar.buffer.ItemIcon` · BaseIconView 
  - `resourceBar.buffer.ItemTime` · FilterFrameText x=-5 y=30 width=40 height=18 font `arial,12,0xfefefe,,,,,,center`
  - `resourceBar.buffer.LastCount` · FilterFrameText y=13 width=30 height=18 font `arial,12,0xfefefe,,,,,,right`
  - `resourceBar.buffer.Effect` · Effect 
  - texts: `public.confirm` “Confirmar”; `public.cancel` “Cancelar”; `public.prompt` “Aviso”; `yishi.view.PlayerBufferItem.content` “Cancelar efeito?”; `public.day` “D”; `public.time.sigHour` “H”; `public.minute` “M”; `task.view.TaskMobilePhoneView.Text1` “segundos”
  - subviews: `BaseIconView`

### mainBar.view.PowerExperenceView

- **PowerExperenceView** (`core_module:mainBar/view/PowerExperenceView.as`)
  - `resourceBar.PowerExperenceView` · PowerExperenceView x=20 y=79
    - `resourceBar.PowerTip` · MultipleLineTip 
  - `resourceBar.PowerValueTxt` · FilterFrameText x=0 y=16 width=46 height=18 font `arial,12,0xfff600,true,,,,,center`
  - `asset.resourcesBar.PowerProgress` · bitmap 
    - `asset.resourcesBar.PowerProgress` · bitmap 69×30 (resourcesbar.swf)

### mainBar.view.VipCoolDownFrame

- **VipCoolDownFrame** (`core_module:mainBar/view/VipCoolDownFrame.as`)
  - `queueBar.VipCoolDownFrame` · VipCoolDownFrame width=310 height=195 ← `core.QuickBuyFrame`
  - `queueBar.VoucherBack` · Image x=65 y=30
    - `asset.resourcesBar.VoucherBack` · bitmap 
      - `asset.resourcesBar.VoucherBack` · bitmap 24×23 (resourcesbar.swf)
  - `queueBar.QuickCodeButton` · IconButton x=20 y=105 ← `core.ConfitmSellConfitmBtn`
  - `queueBar.CloseButton` · IconButton x=178 y=105 ← `core.ConfitmSellCancelBtn`
  - `queueBar.AlertTextStyle_2` · FilterFrameText x=40 y=8 width=220 height=23 font `Arial,14,0xFFefbd,,,,,,left`
  - `queueBar.VipCoolTextStyle` · FilterFrameText x=30 y=40 width=200 height=20 font `Arial,12,0xfff600,,,,,,center`
  - `queuebar.useBindPointBtn` · SelectedCheckButton x=60 y=77 ← `core.useBindPointBtn`
  - `queueBar.promptTxt` · FilterFrameText x=59 y=57 width=120 height=20 font `Arial,12,0xFF0000,,,,,,center`
  - texts: `mainBar.view.VipCoolDownFrame.promptTxt` “(Não participa no evento de consumo)”; `public.confirm1` “Confirmar”; `public.close1` “Fechar”; `mainBar.view.ChoosePayTypeFrame.tipTxtText` “Escolha modo de pagamento de aceleração de resfriamento:”; `mainBar.view.VipCoolDownFrame.useBind` “Diamante vinculado prioritário”; `mainBar.view.ChoosePayTypeFrame.vipCoolTxt` “VIP tem resfriamento gratuito”; `mainBar.view.ChoosePayTypeFrame.openVipTxt` “Habilitar”; `public.parentheses1` “({0})”

### map.campaign.pvp.view.PvpHeroItemView

- **PvpHeroItemView** (`core_module:map/campaign/pvp/view/PvpHeroItemView.as`)
  - `PvpHeroFrame.PvpHeroItemView` · PvpHeroItemView width=410 height=31
  - `PvpHeroFrame.itemBg` · ScaleFrameImage width=515
    - `PvpHeroFrame.itemBgGray` · Scale9CornerImage x=2 y=0 width=410 height=32 ← `core.TitleBack_Style777`
    - `PvpHeroFrame.itemBgLight` · Scale9CornerImage x=1 y=0 width=515 height=30 ← `core.TitleBack_Style888`
  - `PvpHeroItemView.Txt00` · FilterFrameText x=0 y=7 width=128 height=20 font `Arial,12,0xe4d29c,,,,,,center`
  - `PvpHeroItemView.Txt01` · FilterFrameText x=135 y=7 width=105 height=20 font `Arial,12,0xe4d29c,,,,,,center`
  - `PvpHeroItemView.Txt02` · FilterFrameText x=240 y=7 width=88 height=20 font `Arial,12,0xe4d29c,,,,,,center`
  - `PvpHeroItemView.Txt03` · FilterFrameText x=335 y=7 width=170 height=40 font `Arial,12,0xe4d29c,,,,,,center`
  - subviews: `PlayerMenu`

### map.campaign.view.frame.ArmyManageFrame

- **ArmyManageFrame**: “Gerenciamento da Equipe” (`core_module:map/campaign/view/frame/ArmyManageFrame.as`)
  - `core.ArmyManageFrame` · ArmyManageFrame width=478 height=281 ← `core.Frame2`
  - `core.armymanage.Back` · ScaleBitmapImage y=151 width=451 height=45 ← `core.describeBackground_style04`
  - `core.armymanage.AddBtn` · TextButton x=140 y=159 ← `core.GreenBtn`
    - `core.armymanage.ButtonText` · FilterFrameText width=64 height=20 font `Arial,12,0xe1dab7,,,,,,center`
  - `core.armymanage.ChangeBtn` · TextButton x=325 y=159 ← `core.BrownBtn`
    - `core.armymanage.ButtonText` · FilterFrameText width=64 height=20 font `Arial,12,0xe1dab7,,,,,,center`
  - `core.armymanage.KickBtn` · TextButton x=50 y=159 ← `core.RedBtn`
    - `core.armymanage.ButtonText` · FilterFrameText width=64 height=20 font `Arial,12,0xe1dab7,,,,,,center`
  - `core.armymanage.AdjustmentLineUp` · TextButton x=235 y=159 ← `core.BlueBtn`
    - `core.armymanage.ButtonText` · FilterFrameText width=64 height=20 font `Arial,12,0xe1dab7,,,,,,center`
  - `core.armymanage.Box` · HBox x=-2 y=5
  - texts: `map.campaign.view.frame.ArmyManageFrame.title` “Gerenciamento da Equipe”; `map.campaign.view.frame.ArmyManageFrame.add` “Adicionar”; `map.campaign.view.frame.ArmyManageFrame.change` “Capitão”; `map.campaign.view.frame.ArmyManageFrame.kick` “Expulsar”; `armyII.viewII.allocate.AllocateView.sort` “Formação”; `map.campaign.view.frame.ArmyManageFrame.kick2` “Voto de expulsação”; `map.internals.view.team.FreedomTeamManageFrame.sortCheck` “Ver Formação”; `room.view.pve.RoomRightView.command01` “Não há espaço livre”
  - subviews: `ArmyManageHeroItem`

### map.campaign.view.frame.ArmyManageHeroItem

- **ArmyManageHeroItem** (`core_module:map/campaign/view/frame/ArmyManageHeroItem.as`)
  - `core.armymanage.HeroBack` · ScaleFrameImage 
    - `core.HeroUnSelectBg` · MutipleImage x=0 y=0
      - `core.HeroUnSelectLeftBg` · Image 
        - `asset.core.HeroUnSelected` · bitmap 56×142 (core.swf)
      - `core.HeroUnSelectRightBg` · Image 
        - `asset.core.HeroUnSelected` · bitmap 56×142 (core.swf)
    - `core.HeroSelectBg` · MutipleImage x=0 y=0
      - `core.HeroSelectLeftBg` · Image 
        - `asset.core.HeroSelected` · bitmap 56×142 (core.swf)
      - `core.HeroSelectRightBg` · Image 
        - `asset.core.HeroSelected` · bitmap 56×142 (core.swf)
  - `core.PlayerLevelback` · ScaleBitmapImage x=74 y=63
    - `asset.core.LevelBack` · bitmap 
      - `asset.core.LevelBack` · bitmap 31×31 (core.swf)
  - `core.armymanage.LevelTxt` · FilterFrameText x=78 y=70 width=24 height=22 font `Arial,12,0xffffff,true,,,,,center`
  - `core.armymanage.NameTxt` · FilterFrameText x=7 y=100 width=100 height=18 font `Arial,12,0xffffff,,,,,,center`
  - `core.armymanage.ConsortiaTxt` · FilterFrameText x=7 y=115 width=100 height=22 font `Arial,12,0xf0ee2e,,,,,,center`
  - `core.armymanage.PlayerIcon` · BaseHeroCell x=18 y=16
    - `core.armymanage.IconBack` · ScaleBitmapImage 
      - `asset.core.armymanage.IconBack` · bitmap 75×75 (core.swf)
    - `core.armymanage.PlayerIconIcon` · BaseIconView x=4 y=4
      - `asset.core.IconLoading` · sprite 42 frames (core2.swf)
    - `core.armymanage.HeroVocation` · ScaleFrameImage x=-5 y=-4 ← `core.HeroVocation`
  - `core.armymanage.CaptainFlag` · Image x=9 y=54
    - `asset.core.CaptainIcon` · bitmap 42×43 (core.swf)
  - subviews: `BaseHeroCell`

### map.campaign.view.frame.MazeFallItemsFrame

- **MazeFallItemsFrame**: “Item Recebido” (`core_module:map/campaign/view/frame/MazeFallItemsFrame.as`)
  - `campaign.maze.FallItemsFrame` · MazeFallItemsFrame width=345 height=330 ← `core.Frame2`
  - `campaign.maze.fall.SimpleTileList` · SimpleTileList 
  - `campaign.maze.fall.FallScrollPanel` · ScrollPanel x=-12 y=0 width=302 height=235
    - `core.VScrollbar02` · Scrollbar width=21 height=200
      - `core.Scrollbar02_Back` · ScaleBitmapImage width=15 height=24
        - `asset.core.scrollbar02_bg` · bitmap 15×24 (core2.swf)
      - `core.Scrollbar02_Step` · BaseButton width=21 height=56
        - `core.scrollbar02_stepAsset` · ScaleBitmapImage width=21 height=56
          - `asset.core.scrollbar02_step` · bitmap 21×56 (core2.swf)
      - `core.Scrollbar02_Up` · BaseButton width=11 height=10
        - `asset.core.scrollbar02_up` · bitmap 11×10 (core2.swf)
      - `core.Scrollbar02_Down` · BaseButton width=11 height=10
        - `asset.core.scrollbar02_down` · bitmap 11×10 (core2.swf)
    - `core.HScrollbar02` · Scrollbar width=200 height=15 ← `core.VScrollbar02`
  - `campaign.maze.fall.BagCellIcon` · BaseItemView 
    - `core.ItemBack` · ScaleBitmapImage x=1 y=1 width=45 height=45 ← `core.goods.ItemBack`
    - `campaign.maze.fall.CellIcon` · BaseIconView x=0 y=0
      - `asset.core.IconLoading` · sprite 42 frames (core2.swf)
    - `core.BaseItemText` · FilterFrameText x=0 y=26 width=45 height=18 font `Arial,12,0xffffff,true,,,,,right`
    - `core.goods.Strengthen` · MovieImage x=-50 y=-50
      - `asset.core.goods.Strengthen` · Strengthen 
  - texts: `map.campaign.view.frame.MazeFallItemsFrame.title` “Item Recebido”
  - subviews: `BaseItemView`

### map.campaign.view.frame.MolongCountDownView

- **MolongCountDownView** (`core_module:map/campaign/view/frame/MolongCountDownView.as`)
  - `asset.core.molongCountDownBg` · sprite 304.0×40.0 (core.swf)
  - `molong.countDown` · FilterFrameText x=198 y=6 width=100 height=32 font `Arial,24,0xffe827,true,,,,,left`

### map.campaign.view.frame.PVPArmyManageFrame

- **PVPArmyManageFrame**: “Gerenciamento da Equipe” (`core_module:map/campaign/view/frame/PVPArmyManageFrame.as`)
  - `core.PVPArmyManageFrame` · PVPArmyManageFrame width=489 height=273 ← `core.Frame2`
  - `core.PvParmymanage.Back` · ScaleBitmapImage y=151 width=449 height=45 ← `core.describeBackground_style04`
  - `core.PVParmymanage.AddBtn` · TextButton x=352 y=159 ← `core.GreenBtn`
    - `core.armymanage.ButtonText` · FilterFrameText width=64 height=20 font `Arial,12,0xe1dab7,,,,,,center`
  - `core.PVParmymanage.KickBtn` · TextButton x=20 y=159 ← `core.RedBtn`
    - `core.armymanage.ButtonText` · FilterFrameText width=64 height=20 font `Arial,12,0xe1dab7,,,,,,center`
  - `core.armymanage.Box` · HBox x=-2 y=5
  - `room.RoomInviteFrame` · RoomInviteFrame width=335 height=442 ← `core.Frame5`
    - `room.RoomInviteFrameBg5` · MutipleImage 
      - `core.FrameBackgoundBase2` · Scale9CornerImage 
        - `asset.core.style02_scale9bg1` · bitmap 126×64 (framebg.swf)
        - `asset.core.style02_scale9bg2` · bitmap 38×64 (framebg.swf)
        - `asset.core.style02_scale9bg3` · bitmap 126×64 (framebg.swf)
        - `asset.core.style02_scale9bg4` · bitmap 126×18 (framebg.swf)
        - `asset.core.style02_scale9bg5` · bitmap 38×18 (framebg.swf)
        - `asset.core.style02_scale9bg6` · bitmap 126×18 (framebg.swf)
        - `asset.core.style02_scale9bg7` · bitmap 126×64 (framebg.swf)
        - `asset.core.style02_scale9bg8` · bitmap 38×64 (framebg.swf)
        - `asset.core.style02_scale9bg9` · bitmap 126×64 (framebg.swf)
  - texts: `map.campaign.view.frame.ArmyManageFrame.title` “Gerenciamento da Equipe”; `map.campaign.view.frame.ArmyManageFrame.add` “Adicionar”; `map.campaign.view.frame.ArmyManageFrame.kick` “Expulsar”; `room.view.pve.RoomRightView.command01` “Não há espaço livre”
  - subviews: `ArmyManageHeroItem`, `RoomInviteFrame`

### map.internals.battle.ChestFrame

- **ChestFrame** (`core_module:map/internals/battle/ChestFrame.as`)
  - `core.chest.ChestFrame` · ChestFrame 
  - `chest.BackMc` · BackMc 
  - `chest.ContentMc` · FlopMovieAsset x=311 y=89
  - `chest.ChestOKBtn` · IconButton x=-38
    - `asset.core.Style12Btn` · bitmap 233×63 (core2.swf)
    - `asset.core.ConfirmTxtAsset_02` · bitmap 101×25 (core2.swf)
  - `chest.ChestExitBtn` · IconButton x=0
    - `asset.core.Style12Btn` · bitmap 233×63 (core2.swf)
    - `asset.chest.battleinvite.ExitTxtAsset` · bitmap 143×26 (chest.swf)
  - `chest.ChestAgainBtn` · IconButton x=0
    - `asset.core.Style13Btn` · bitmap 237×69 (core2.swf)
    - `asset.chest.battleinvite.AgainTxtAsset` · bitmap 154×24 (chest.swf)
  - `chest.TimerBtn` · TimerButton x=-40 y=-3
    - `asset.core.Style13Btn` · bitmap 237×69 (core2.swf)
    - `chest.TimerBtnTxt` · FilterFrameText x=121 y=20 width=40 height=30 font `Arial,26,0xecda14,true,,,,,center`
    - `asset.chest.battleinvite.WashTxtAsset` · bitmap x=65 y=23
      - `asset.chest.battleinvite.WashTxtAsset` · bitmap 143×27 (chest.swf)
  - `asset.chest.battleinvite.BattleInviteNumberAsset` · bitmap 
    - `asset.chest.battleinvite.BattleInviteNumberAsset` · bitmap 300×36 (chest.swf)
  - `core.TodayNotAlertFrame` · TodayNotAlertFrame width=400 height=193 ← `core.Frame2`
    - `core.AlertConfirmBtn_3` · SelectedCheckButton x=30 y=89 ← `core.AlertConfirmBtn_2`
    - `core.AlertButton_3` · SelectedCheckButton x=195 y=89 ← `core.AlertButton_2`
    - `core.ThewCheckBtn` · SelectedCheckButton x=109 y=62
      - `asset.core.checkstyle_2.UnSelected` · bitmap 22×23 (core2.swf)
      - `asset.core.checkstyle_2.Selected` · sprite (core2.swf)
      - `core.ThewCheckTxt` · FilterFrameText width=170 font `Arial,12,0xe7c88b,,,,,,center`
    - `core.ThewDescribeTxt` · FilterFrameText x=-4 y=8 width=340 height=50 font `Arial,14,0xe7c88b,,,,,,left`
    - `core.quickBuyFrameBg` · MutipleImage 
      - `core.AlertFrameBg` · MutipleImage 
        - `core.AlertFrameBaseBg` · Scale9CornerImage 
          - `asset.core.framestyle03_scale9bg1` · bitmap 42×42 (framebg.swf)
          - `asset.core.framestyle03_scale9bg2` · bitmap 42×42 (framebg.swf)
          - `asset.core.framestyle03_scale9bg3` · bitmap 42×42 (framebg.swf)
          - `asset.core.framestyle03_scale9bg4` · bitmap 42×18 (framebg.swf)
          - `asset.core.framestyle03_scale9bg5` · bitmap 42×18 (framebg.swf)
          - `asset.core.framestyle03_scale9bg6` · bitmap 42×18 (framebg.swf)
          - `asset.core.framestyle03_scale9bg7` · bitmap 42×42 (framebg.swf)
          - `asset.core.framestyle03_scale9bg8` · bitmap 42×42 (framebg.swf)
          - `asset.core.framestyle03_scale9bg9` · bitmap 42×42 (framebg.swf)
      - `core.FrameTitleImage2` · Image width=229 height=17
        - `asset.core.frameTitleImage2` · bitmap 229×17 (framebg.swf)
    - `core.FrameTitleText` · FilterFrameText  font `Arial,14,0xFFDD83,true`
  - texts: `public.confirm` “Confirmar”; `public.cancel` “Cancelar”; `public.prompt` “Aviso”; `map.internals.battle.ChestFrame.againContent` “Desafiar novamente a campanha?”; `yishi.view.base.ThewAlertFrame.disclist02` “Energia insuficiente, você não receberá nenhum ganho ao entr”; `yishi.view.base.ThewAlertFrame.text` “Não alertar mais”
  - subviews: `ChestItemView`, `TimerButton`, `TodayNotAlertFrame`

### map.internals.battle.ChestItemView

- **ChestItemView** (`core_module:map/internals/battle/ChestItemView.as`)
  - `chest.ItemEffect` · ItemEffect 
  - `chest.GoodsNameTxt` · FilterFrameText x=7 y=90 width=100 height=60 font `Arial,12,0xffffff,,,,,,center`
  - `chest.NickNameTxt` · FilterFrameText x=0 y=158 width=110 height=20 font `Arial,12,0xFF6C00,true,,,,,center`
  - `chest.OtherNameTxt` · FilterFrameText x=0 y=158 width=110 height=20 font `Arial,12,0xffcc00,,,,,,center`
  - `core.chest.GoodsItem` · BaseItemView x=11 y=10
    - `core.chest.GoodsItemIcon` · BaseIconView x=22 y=22
      - `asset.core.IconLoading` · sprite 42 frames (core2.swf)
    - `core.chest.BaseItemText` · FilterFrameText x=26 y=51 width=42 height=16 font `Arial,12,0xffffff,true,,,,,right`
    - `core.GoodsProfileBG` · ScaleFrameImage 
      - `asset.core.BagProfileGreen` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileBlue` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfilePurple` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileOrange` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileRed` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileBlackKing` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileFashion` · bitmap 45×45 (core.swf)
    - `core.goods.Strengthen` · MovieImage x=-50 y=-50
      - `asset.core.goods.Strengthen` · Strengthen 
  - subviews: `BaseItemView`

### map.internals.effect.RedScreen

- **RedScreen** (`core_module:map/internals/effect/RedScreen.as`)
  - `vehicel.redScreen` · ScaleBitmapImage 
    - `asset.vehiclemap.RedScreenBMD` · bitmap 190×190 (vehicle.swf)

### map.internals.view.displaye.CampaignResultView

- **CampaignResultView** (`core_module:map/internals/view/displaye/CampaignResultView.as`)
  - `battle.PetIcon` · BaseIconView 
  - `asset.campaign.Number1` · bitmap 
    - `asset.campaign.Number1` · bitmap 275×25 (clearance.swf)
  - `asset.campaign.Number2` · bitmap 
    - `asset.campaign.Number2` · bitmap 240×30 (clearance.swf)
  - `asset.campaign.Number3` · bitmap y=-5
    - `asset.campaign.Number3` · bitmap 240×30 (clearance.swf)
  - `asset.campaign.tenThousand` · bitmap 
    - `asset.campaign.tenThousand` · bitmap 20×23 (clearance.swf)
  - `asset.campaign.orderUnit` · bitmap 
    - `asset.campaign.orderUnit` · bitmap 82×23 (clearance.swf)
  - `campaign.Resultmc` · Resultmc 
  - `asset.campaign.ProfileMCD` · ProfileMCD 
  - `asset.campaign.ProfileMCC` · ProfileMCC 
  - `asset.campaign.ProfileMCB` · ProfileMCB 
  - `asset.campaign.ProfileMCA` · ProfileMCA 
  - `asset.campaign.ProfileMCS` · ProfileMCS 
  - `asset.campaign.ProfileMCSS` · ProfileMCSS 
  - `asset.campaign.ProfileMCSSS` · ProfileMCSSS 
  - texts: `campaign.Resultmc.bossTime` “(Tempo da Batalha do Chefão ≤ {0} Seg)”; `campaign.Resultmc.dieS` “(Número de Mortes≤ {0} S)”
  - subviews: `BaseIconView`, `SimpleMovie`

### map.internals.view.displaye.MapNameMovie

- **MapNameMovie** (`core_module:map/internals/view/displaye/MapNameMovie.as`)
  - `map.mapNameMovieAsset` · MovieImage 
    - `asset.map.mapNameMovieAsset` · sprite 36 frames (map.swf)
  - subviews: `SimpleMovie`

### marry.view.MarryFlowerView

- **MarryFlowerView** (`core_module:marry/view/MarryFlowerView.as`)
  - `marry.WeddingBackgoundBase` · Scale9CornerImage 
    - `asset.wedding.style01_scale9bg1` · bitmap 484×415 (wedding.swf)
    - `asset.wedding.style01_scale9bg2` · bitmap 343×415 (wedding.swf)
    - `asset.wedding.style01_scale9bg3` · bitmap 484×415 (wedding.swf)
    - `asset.wedding.style01_scale9bg4` · bitmap 484×343 (wedding.swf)
    - `asset.wedding.style01_scale9bg5` · bitmap 343×343 (wedding.swf)
    - `asset.wedding.style01_scale9bg6` · bitmap 484×343 (wedding.swf)
    - `asset.wedding.style01_scale9bg7` · bitmap 484×415 (wedding.swf)
    - `asset.wedding.style01_scale9bg8` · bitmap 343×415 (wedding.swf)
    - `asset.wedding.style01_scale9bg9` · bitmap 484×415 (wedding.swf)
  - `marry.weddingDialogBg` · ScaleBitmapImage width=528 height=136
    - `asset.wedding.dialogBg` · bitmap 528×136 (wedding.swf)
  - `asset.wedding.angel01` · bitmap x=0 y=0
    - `asset.wedding.angel01` · bitmap 152×94 (wedding.swf)
  - `asset.wedding.angel02` · bitmap 99×148 (wedding.swf)
  - texts: `marry.view.MarryFlowerView.toHideMarryCar` “Favor entrar no Reino de casamento e monte no carro de casam”
  - subviews: `DialogWordView`, `DialogRoleImage`

### marry.view.MarryRingView

- **MarryRingView** (`core_module:marry/view/MarryRingView.as`)
  - `playerinfo.ring` · BaseIconView x=0 y=0
    - `asset.core.IconLoading` · sprite 42 frames (core2.swf)
  - `MarryRingView.upBtn` · IconButton x=25 y=25 width=29 height=28
    - `asset.core.ringUpBack1` · bitmap 29×30 (core.swf)
  - `asset.core.fashionLevelSpecial` · bitmap 21×21 (core.swf)
  - `playerinfo.ringLevelTxt` · FilterFrameText x=0 y=28 width=20 height=16 font `Arial,12,0xffff00,true,,,,,left`
  - texts: `armyII.viewII.equip.MarryRingView.tipData1` “Parabéns {0} e {1} irão casar brevemente”; `armyII.viewII.equip.MarryRingView.tipData3` “Clique para temperar anel”; `marry.view.MarryRingView.Divorce` “Casando novemente pode-se herdar o nível do anel e ativar at”
  - subviews: `BaseIconView`

### marry.view.ProposeBoxItem

- **ProposeBoxItem** (`core_module:marry/view/ProposeBoxItem.as`)
  - `core.IMMsgBoxItemNameTxt` · FilterFrameText x=0 y=2 width=160 height=20 font `Arial,12,0xebd59b`
  - `asset.core.IMMsgBoxItemMouseOverBg` · bitmap x=0 y=0
    - `asset.core.IMMsgBoxItemMouseOverBg` · bitmap 174×24 (core.swf)
  - texts: `marry.view.ProposeBoxItem.nameTxt` “{0} pediu te em casamento”

### marry.view.ProposeBoxView

- **ProposeBoxView** (`core_module:marry/view/ProposeBoxView.as`)
  - `core.IMMsgBoxBg` · ScaleUpDownImage width=184 height=200
    - `asset.core.IMMsgBoxBgTop` · bitmap 184×37 (core.swf)
    - `asset.core.IMMsgBoxBgMid` · bitmap 184×6 (core.swf)
    - `asset.core.IMMsgBoxBgBottom` · bitmap 184×20 (core.swf)
  - `core.IMMsgBoxCancleShineBtn` · BaseButton x=117 y=5
    - `asset.core.IMMsgBoxCancleBtnImg` · bitmap 60×19 (core.swf)
  - `core.IMMsgBoxItemVBox` · VBox x=5 y=34
  - subviews: `ProposeBoxItem`

### monopoly.view.MonopolyAlertFrame

- **MonopolyAlertFrame**: “monopoly.view.MonopolyAlertFrame.TitleTxt” (`core_module:monopoly/view/MonopolyAlertFrame.as`)
  - `monopoly.MonopolyAlertFrame` · MonopolyAlertFrame width=464 height=246
    - `core.quickBuyFrameBg` · MutipleImage 
      - `core.AlertFrameBg` · MutipleImage 
        - `core.AlertFrameBaseBg` · Scale9CornerImage 
          - `asset.core.framestyle03_scale9bg1` · bitmap 42×42 (framebg.swf)
          - `asset.core.framestyle03_scale9bg2` · bitmap 42×42 (framebg.swf)
          - `asset.core.framestyle03_scale9bg3` · bitmap 42×42 (framebg.swf)
          - `asset.core.framestyle03_scale9bg4` · bitmap 42×18 (framebg.swf)
          - `asset.core.framestyle03_scale9bg5` · bitmap 42×18 (framebg.swf)
          - `asset.core.framestyle03_scale9bg6` · bitmap 42×18 (framebg.swf)
          - `asset.core.framestyle03_scale9bg7` · bitmap 42×42 (framebg.swf)
          - `asset.core.framestyle03_scale9bg8` · bitmap 42×42 (framebg.swf)
          - `asset.core.framestyle03_scale9bg9` · bitmap 42×42 (framebg.swf)
      - `core.FrameTitleImage2` · Image width=229 height=17
        - `asset.core.frameTitleImage2` · bitmap 229×17 (framebg.swf)
    - `core.FrameTitleText` · FilterFrameText  font `Arial,14,0xFFDD83,true`
  - `monopoly.MonopolyAlertFrame.ScaleBg` · ScaleBitmapImage x=0 y=0 width=450 height=180 ← `core.describeBackground_style06`
  - `monopoly.MonopolyAlertFrame.ContentBg` · Image x=2 y=2
    - `asset.monopoly.AlertFrameBg` · bitmap 446×176 (monopoly.swf)
  - `monopoly.MonopolyAlertFrame.EventIcon` · BaseIconView x=31 y=38 ← `pet.MainPetIcon`
    - `core.GoodsBack` · ScaleBitmapImage width=60 height=60
      - `core.shop.goodsItemBack2` · bitmap 
        - `core.shop.goodsItemBack2` · bitmap 60×60 (core.swf)
  - `monopoly.MonopolyAlertFrame.NCPIcon` · BaseIconView x=31 y=38
    - `core.GoodsBack` · ScaleBitmapImage width=60 height=60
      - `core.shop.goodsItemBack2` · bitmap 
        - `core.shop.goodsItemBack2` · bitmap 60×60 (core.swf)
  - `monopoly.MonopolyAlertFrame.ContentTxt` · FilterFrameText x=140 y=50 width=270 height=60 font `Arial,12,0x39cdde,,,,,,left`
  - `monopoly.MonopolyAlertFrame.SelfFightBtn` · IconButton x=90 y=130
    - `asset.monopoly.BtnBg` · bitmap 87×40 (monopoly.swf)
    - `asset.monopoly.SelfFightTxt` · bitmap 74×31 (monopoly.swf)
  - `monopoly.MonopolyAlertFrame.FriendFightBtn` · IconButton x=275 ← `monopoly.MonopolyAlertFrame.SelfFightBtn`
    - `asset.monopoly.FriendFightTxt` · bitmap 77×34 (monopoly.swf)
  - `monopoly.MonopolyAlertFrame.ConfirmBtn` · IconButton x=183 ← `monopoly.MonopolyAlertFrame.SelfFightBtn`
    - `asset.monopoly.ConfirmTxt` · bitmap 79×21 (monopoly.swf)
  - `monopoly.MonopolyAlertFrame.ConfirmBtn` · IconButton x=183 ← `monopoly.MonopolyAlertFrame.SelfFightBtn`
    - `asset.monopoly.ConfirmTxt` · bitmap 79×21 (monopoly.swf)
  - _no style/symbol_: `monopoly.AlertIcon`, `monopoly.AlertIcon`
  - texts: `MonopolyManager.BattleGetTip02` “{0} x{1}、”
  - subviews: `BaseIconView`

### monopoly.view.MonopolyBattleFailureFrame

- **MonopolyBattleFailureFrame**: “Batalha perdida” (`core_module:monopoly/view/MonopolyBattleFailureFrame.as`)
  - `monopoly.MonopolyBattleFailureFrame` · MonopolyBattleFailureFrame width=280 height=180
    - `core.quickBuyFrameBg` · MutipleImage 
      - `core.AlertFrameBg` · MutipleImage 
        - `core.AlertFrameBaseBg` · Scale9CornerImage 
          - `asset.core.framestyle03_scale9bg1` · bitmap 42×42 (framebg.swf)
          - `asset.core.framestyle03_scale9bg2` · bitmap 42×42 (framebg.swf)
          - `asset.core.framestyle03_scale9bg3` · bitmap 42×42 (framebg.swf)
          - `asset.core.framestyle03_scale9bg4` · bitmap 42×18 (framebg.swf)
          - `asset.core.framestyle03_scale9bg5` · bitmap 42×18 (framebg.swf)
          - `asset.core.framestyle03_scale9bg6` · bitmap 42×18 (framebg.swf)
          - `asset.core.framestyle03_scale9bg7` · bitmap 42×42 (framebg.swf)
          - `asset.core.framestyle03_scale9bg8` · bitmap 42×42 (framebg.swf)
          - `asset.core.framestyle03_scale9bg9` · bitmap 42×42 (framebg.swf)
      - `core.FrameTitleImage2` · Image width=229 height=17
        - `asset.core.frameTitleImage2` · bitmap 229×17 (framebg.swf)
    - `core.FrameTitleText` · FilterFrameText  font `Arial,14,0xFFDD83,true`
  - `monopoly.MonopolyBattleFailureFrame.ContentTxt` · FilterFrameText x=0 y=20 width=280 height=60 font `Arial,14,0xffefbd,,,,,,center`
  - `monopoly.MonopolyBattleFailureFrame.SelfFightBtn` · IconButton x=20 y=80
    - `asset.core.AlertBtnStyle_02` · bitmap 96×40 (core2.swf)
    - `asset.monopoly.FSelfFightTxt` · bitmap 84×32 (monopoly.swf)
  - `monopoly.MonopolyBattleFailureFrame.FriendFightBtn` · IconButton x=160 y=80
    - `asset.core.AlertBtnStyle_01` · bitmap 96×40 (core2.swf)
    - `asset.monopoly.FFriendFightTxt` · bitmap 84×36 (monopoly.swf)
  - texts: `monopoly.view.MonopolyBattleFailureFrame.TitleTxt` “Batalha perdida”; `monopoly.view.MonopolyBattleFailureFrame.ContentTxt` “Somente após eliminar o Demónio é que pode continuar, Por fa”

### monopoly.view.MonopolyDiceMagicFrame

- **MonopolyDiceMagicFrame**: “Escolher os pontos necessários” (`core_module:monopoly/view/MonopolyDiceMagicFrame.as`)
  - `monopoly.MonopolyDiceMagicFrame` · MonopolyDiceMagicFrame width=600 height=210 ← `core.Frame2`
  - `monopoly.MonopolyDiceMagicFrame.ContentBg` · Image x=0 y=0
    - `asset.monopoly.DiceMagicFrameBg` · sprite 574.0×122.0 (monopoly.swf)
  - `monopoly.MonopolyDiceMagicBtn.DiceSelectBg1` · Image x=8 y=13
    - `asset.monopoly.DiceSelectBg` · bitmap 96×96 (monopoly.swf)
  - `monopoly.MonopolyDiceMagicBtn.DiceSelectBg2` · Image x=98 ← `monopoly.MonopolyDiceMagicBtn.DiceSelectBg1`
  - `monopoly.MonopolyDiceMagicBtn.DiceSelectBg3` · Image x=188 ← `monopoly.MonopolyDiceMagicBtn.DiceSelectBg1`
  - `monopoly.MonopolyDiceMagicBtn.DiceSelectBg4` · Image x=278 ← `monopoly.MonopolyDiceMagicBtn.DiceSelectBg1`
  - `monopoly.MonopolyDiceMagicBtn.DiceSelectBg5` · Image x=368 ← `monopoly.MonopolyDiceMagicBtn.DiceSelectBg1`
  - `monopoly.MonopolyDiceMagicBtn.DiceSelectBg6` · Image x=458 ← `monopoly.MonopolyDiceMagicBtn.DiceSelectBg1`
  - `monopoly.MonopolyDiceMagicFrame.DiceBtn1` · BaseButton x=15 y=20
    - `asset.monopoly.DiceMagic1` · sprite 83.0×84.0 (monopoly.swf)
  - `monopoly.MonopolyDiceMagicFrame.DiceBtn2` · BaseButton x=105 ← `monopoly.MonopolyDiceMagicFrame.DiceBtn1`
    - `asset.monopoly.DiceMagic2` · sprite 83.0×84.0 (monopoly.swf)
  - `monopoly.MonopolyDiceMagicFrame.DiceBtn3` · BaseButton x=195 ← `monopoly.MonopolyDiceMagicFrame.DiceBtn1`
    - `asset.monopoly.DiceMagic3` · sprite 83.0×84.0 (monopoly.swf)
  - `monopoly.MonopolyDiceMagicFrame.DiceBtn4` · BaseButton x=285 ← `monopoly.MonopolyDiceMagicFrame.DiceBtn1`
    - `asset.monopoly.DiceMagic4` · sprite 83.0×84.0 (monopoly.swf)
  - `monopoly.MonopolyDiceMagicFrame.DiceBtn5` · BaseButton x=375 ← `monopoly.MonopolyDiceMagicFrame.DiceBtn1`
    - `asset.monopoly.DiceMagic5` · sprite 83.0×84.0 (monopoly.swf)
  - `monopoly.MonopolyDiceMagicFrame.DiceBtn6` · BaseButton x=465 ← `monopoly.MonopolyDiceMagicFrame.DiceBtn1`
    - `asset.monopoly.DiceMagic6` · sprite 83.0×84.0 (monopoly.swf)
  - texts: `monopoly.view.MonopolyDiceMagicFrame.TitleTxt` “Escolher os pontos necessários”

### monopoly.view.MonopolyDiceRollView

- **MonopolyDiceRollView** (`core_module:monopoly/view/MonopolyDiceRollView.as`)
  - `monopoly.DiceRollMC` · DiceRollMC x=0 y=0
  - `monopoly.DiceRollResult` · ScaleFrameImage x=0 y=0
    - `asset.monopoly.DiceRollResult1` · bitmap 108×118 (monopoly.swf)
    - `asset.monopoly.DiceRollResult2` · bitmap 108×118 (monopoly.swf)
    - `asset.monopoly.DiceRollResult3` · bitmap 108×118 (monopoly.swf)
    - `asset.monopoly.DiceRollResult4` · bitmap 108×118 (monopoly.swf)
    - `asset.monopoly.DiceRollResult5` · bitmap 108×118 (monopoly.swf)
    - `asset.monopoly.DiceRollResult6` · bitmap 108×118 (monopoly.swf)
  - subviews: `QuickenMovieClip`

### monopoly.view.MonopolyFinishRewardFrame

- **MonopolyFinishRewardFrame** (`core_module:monopoly/view/MonopolyFinishRewardFrame.as`)
  - `monopoly.MonopolyFinishRewardFrame` · MonopolyFinishRewardFrame width=371 height=235
    - `asset.monopoly.FinishRewardBg` · bitmap 371×235 (monopoly.swf)
  - `monopoly.MonopolyFinishRewardFrame.TitleImg` · Image x=49 y=-40
    - `asset.monopoly.SuccessTxt` · bitmap 282×64 (monopoly.swf)
  - `monopoly.MonopolyFinishRewardFrame.DiceIcon` · Image x=155 y=165
    - `asset.monopoly.DiceIcon` · bitmap 33×25 (monopoly.swf)
  - `monopoly.MonopolyFinishRewardFrame.DiceCountTxt` · FilterFrameText x=192 y=170 width=50 height=20 font `Arial,12,0xffeec0,,,,,,left`
  - `monopoly.MonopolyFinishRewardFrame.FreeCountTxt` · FilterFrameText x=202 y=170 width=70 height=20 font `Arial,12,0xffeec0,,,,,,left`
  - `monopoly.MonopolyFinishRewardFrame.StartBtn` · IconButton x=86 y=185
    - `asset.monopoly.StartBtnBg` · bitmap 200×57 (monopoly.swf)
    - `asset.monopoly.StartBtnTxt` · bitmap 75×25 (monopoly.swf)
  - `monopoly.Handle` · Handle x=374 y=62
  - texts: `MonopolyManager.BattleGetTip02` “{0} x{1}、”; `MonopolyManager.BattleGetTip01` “Obteve: {0}”; `vip.view.VipBoxFrame.command03` “Mochila cheia, cheque seu email”; `monopoly.view.MonopolyFinishRewardFrame.diceCountTxt` “x{0}”; `monopoly.view.MonopolyFinishRewardFrame.freeCountTxt` “Número de Prendas x{0}”
  - subviews: `MonopolyFinishRewardView`, `QuickenMovieClip`

### monopoly.view.MonopolyFinishRewardItemView

- **MonopolyFinishRewardItemView** (`core_module:monopoly/view/MonopolyFinishRewardItemView.as`)
  - `monopoly.MonopolyFinishRewardItemView.ItemIconBg` · Image x=0 y=0
    - `asset.monopoly.ItemIconBg` · bitmap 74×71 (monopoly.swf)
  - `monopoly.MonopolyFinishRewardItemView.ItemIcon` · BaseIconView x=7 y=5 ← `pet.MainPetIcon`
    - `core.GoodsBack` · ScaleBitmapImage width=60 height=60
      - `core.shop.goodsItemBack2` · bitmap 
        - `core.shop.goodsItemBack2` · bitmap 60×60 (core.swf)
  - `monopoly.MonopolyFinishRewardItemView.ItemIconImages` · ScaleFrameImage x=0 y=0
    - `asset.monopoly.ItemIcon1` · bitmap 60×60 (monopoly.swf)
    - `asset.monopoly.ItemIcon2` · bitmap 60×60 (monopoly.swf)
    - `asset.monopoly.ItemIcon3` · bitmap 60×60 (monopoly.swf)
    - `asset.monopoly.ItemIcon4` · bitmap 60×60 (monopoly.swf)
    - `asset.monopoly.ItemIcon5` · bitmap 60×60 (monopoly.swf)
    - `asset.monopoly.ItemIcon6` · bitmap 60×60 (monopoly.swf)
    - `asset.monopoly.ItemIcon7` · bitmap 60×60 (monopoly.swf)
    - `asset.monopoly.ItemIcon8` · bitmap 60×60 (monopoly.swf)
    - `asset.monopoly.ItemIcon9` · bitmap 60×60 (monopoly.swf)
    - `asset.monopoly.ItemIcon10` · bitmap 60×60 (monopoly.swf)
    - `asset.monopoly.ItemIcon11` · bitmap 60×60 (monopoly.swf)
  - `monopoly.MonopolyFinishRewardItemView.ItemCountTxt` · FilterFrameText x=0 y=75 width=74 height=20 font `Arial,14,0xffeec0,,,,,,center`
  - subviews: `BaseIconView`

### monopoly.view.MonopolyFriendAssistFrame

- **MonopolyFriendAssistFrame**: “Pedir Assistência” (`core_module:monopoly/view/MonopolyFriendAssistFrame.as`)
  - `monopoly.MonopolyFriendAssistFrame` · MonopolyFriendAssistFrame width=459 height=425 ← `core.Frame2`
  - `monopoly.MonopolyFriendAssistFrame.ScaleBg` · ScaleBitmapImage x=0 y=0 width=434 height=310 ← `core.describeBackground_style04`
  - `monopoly.MonopolyFriendAssistFrame.ContentBg` · Scale9CornerImage x=2 y=40 width=430 height=217 ← `core.describeBackground_style40`
  - `monopoly.MonopolyFriendAssistFrame.UnionButton` · SelectedCheckButton x=5 y=-24 width=65 height=25
    - `monopoly.UnionUnselectedBg` · MutipleImage 
      - `asset.core.friendsButtonUnselectedImg` · bitmap 65×24 (core.swf)
      - `asset.core.friendsUnionImg` · bitmap x=3 y=2
        - `asset.core.friendsUnionImg` · bitmap 21×20 (core.swf)
    - `monopoly.UnionSelectedBg` · MutipleImage 
      - `asset.core.friendsButtonSelectedImg` · bitmap 65×25 (core.swf)
      - `asset.core.friendsUnionImg` · bitmap x=3 y=2
        - `asset.core.friendsUnionImg` · bitmap 21×20 (core.swf)
    - `core.FriendsBtnTextStyle` · FilterFrameText width=52 height=20 font `Arial,13,0xa68559,true,,,,,center`
  - `monopoly.MonopolyFriendAssistFrame.FriendsButton` · SelectedCheckButton x=77 y=-24 width=65 height=25
    - `monopoly.FriendsUnselectedBg` · MutipleImage 
      - `asset.core.friendsButtonUnselectedImg` · bitmap 65×24 (core.swf)
      - `asset.core.friendsFriendImg` · bitmap x=5 y=4
        - `asset.core.friendsFriendImg` · bitmap 19×17 (core.swf)
    - `monopoly.FriendsSelectedBg` · MutipleImage 
      - `asset.core.friendsButtonSelectedImg` · bitmap 65×25 (core.swf)
      - `asset.core.friendsFriendImg` · bitmap x=5 y=4
        - `asset.core.friendsFriendImg` · bitmap 19×17 (core.swf)
    - `core.FriendsBtnTextStyle` · FilterFrameText width=52 height=20 font `Arial,13,0xa68559,true,,,,,center`
  - `monopoly.MonopolyFriendAssistFrame.WarFlagIcon` · Image x=10 y=272
    - `asset.monopoly.WarFlagIcon` · bitmap 24×23 (monopoly.swf)
  - `monopoly.MonopolyFriendAssistFrame.WarFlagTxt` · FilterFrameText x=35 y=272 width=100 height=20 font `Arial,14,0xf8b95b,,,,,,left`
  - `monopoly.MonopolyFriendAssistFrame.WarFlagCountTxt` · FilterFrameText x=170 y=269 width=100 height=20 font `Arial,16,0xeecfa1,,,,,,left`
  - `monopoly.MonopolyFriendAssistFrame.WarFlagAddBtn` · BaseButton x=210 y=267
    - `asset.monopoly.AddBtn` · sprite (monopoly.swf)
  - `monopoly.MonopolyFriendAssistFrame.ContentView` · MonopolyFriendAssistView x=0 y=40
  - `monopoly.MonopolyFriendAssistFrame.SearchBg` · Image x=146 y=12
    - `asset.monopoly.SearchBg` · sprite 142.0×24.0 (monopoly.swf)
  - `monopoly.MonopolyFriendAssistFrame.SearchTxt` · FilterFrameText x=150 y=15 width=110 height=20 font `Arial,12,0xd9b88d,,,,,,left`
  - `monopoly.MonopolyFriendAssistFrame.SearchTipTxt` · FilterFrameText x=150 y=15 width=110 height=20 font `Arial,12,0x6b6b6b,,,,,,center`
  - `monopoly.MonopolyFriendAssistFrame.SearchBtn` · BaseButton x=260 y=14
    - `asset.monopoly.SearchBtn` · bitmap 20×21 (monopoly.swf)
  - `monopoly.TodayNotAlertFrame` · TodayNotAlertFrame width=390 ← `worldboss.RiverNotAlert`
    - `monopoly.AlertTextStyle` · FilterFrameText x=0 y=0 width=375 height=50 font `Arial,14,0xe7c88b,,,,,,left`
  - texts: `monopoly.view.MonopolyFriendAssistFrame.TitleTxt` “Pedir Assistência”; `public.consortia` “Guilda”; `public.friend` “Amigos”; `monopoly.view.MonopolyFriendAssistFrame.WarFlagTxt` “Bandeira de Guerra”; `friends.view.RosePresentView.inputTip` “Nome do amigo”; `monopoly.view.MonopolyFriendAssistFrame.BuyTips` “Quer consumir {0} Diamantes para comprar 1 Bandeira de Guerr”; `yishi.view.base.ThewAlertFrame.text` “Não alertar mais”; `room.view.invite.RoomInviteFrame.command01` “Você ainda não juntou-se à uma Guilda!”
  - subviews: `MonopolyFriendAssistView`, `TodayNotAlertFrame`

### monopoly.view.MonopolyFriendAssistItemView

- **MonopolyFriendAssistItemView** (`core_module:monopoly/view/MonopolyFriendAssistItemView.as`)
  - `monopoly.MonopolyAlertFrame.ItemView` · MonopolyFriendAssistItemView width=400 height=30
  - `asset.core.simpleVIPIcon` · bitmap 
    - `asset.core.simpleVIPIcon` · bitmap 18×16 (core2.swf)
  - `monopoly.MonopolyFriendAssistItemView.NameTxt` · FilterFrameText x=0 y=6 width=165 height=20 font `Arial,12,0xe4d29c,,,,,,center`
  - `monopoly.MonopolyFriendAssistItemView.VipNameGradientTxt` · GradientText x=0 y=5 width=165
    - `monopoly.MonopolyFriendAssistItemView.VipNameTxt` · FilterFrameText width=165 height=20 font `Arial,14,0xffffff,,,,,,center`
  - `monopoly.MonopolyFriendAssistItemView.VocationIcon` · ScaleFrameImage x=160 y=5 ← `core.VocationIcon`
  - `monopoly.MonopolyFriendAssistItemView.GradesTxt` · FilterFrameText x=170 y=6 width=50 height=20 font `Arial,12,0xe4d29c,,,,,,center`
  - `monopoly.MonopolyFriendAssistItemView.FightingCapacityTxt` · FilterFrameText x=225 y=6 width=110 height=20 font `Arial,12,0xe4d29c,,,,,,center`
  - `monopoly.MonopolyFriendAssistItemView.InviteBtn` · TextButton x=340 y=5 ← `core.GreenIIBtn`
    - `monopoly.MonopolyFriendAssistItemView.InviteStyle` · FilterFrameText width=55 height=18 font `Arial,12,0xffefbd,,,,,,center`
  - `monopoly.MonopolyFriendAssistItemView.ItemLine` · MutipleImage y=30
    - `asset.core.gapLine01` · bitmap 81×2 (core.swf)
    - `asset.core.gapLine02` · bitmap 7×2 (core.swf)
    - `asset.core.gapLine03` · bitmap 80×2 (core.swf)
  - texts: `room.view.invite.RoomInviteFrame.title` “Convidar”; `monopoly.view.MonopolyFriendAssistItemView.InviteTip01` “O Nv.da outra parte é inferior a {0}”

### monopoly.view.MonopolyFriendAssistView

- **MonopolyFriendAssistView** (`core_module:monopoly/view/MonopolyFriendAssistView.as`)
  - `monopoly.MonopolyFriendAssistFrame.ContentView` · MonopolyFriendAssistView x=0 y=40
  - `monopoly.MonopolyFriendAssistView.NameTxt` · FilterFrameText x=4 y=10 width=165 height=20 font `Arial,14,0xe7c88b,true,,,,,center`
  - `monopoly.MonopolyFriendAssistView.GradesTxt` · FilterFrameText x=170 y=10 width=50 height=20 font `Arial,14,0xe7c88b,true,,,,,center`
  - `monopoly.MonopolyFriendAssistView.FightingCapacityTxt` · FilterFrameText x=215 y=0 width=120 height=40 font `Arial,14,0xe7c88b,true,,,,,center`
  - `monopoly.MonopolyFriendAssistView.OprateTxt` · FilterFrameText x=335 y=10 width=50 height=20 font `Arial,14,0xe7c88b,true,,,,,center`
  - `monopoly.MonopolyFriendAssistFrame.PlayerListPanel` · ListPanel x=7 y=38 width=423 height=177
    - `core.VScrollbar01` · Scrollbar width=23 height=200
      - `core.Scrollbar01_Thumb` · BaseButton width=14 height=46
        - `core.Scrollbar01_thumbImg` · ScaleFrameImage width=14 height=46
          - `core.scrollbar01_step1` · ScaleBitmapImage 
          - `core.scrollbar01_step2` · ScaleBitmapImage 
          - `core.scrollbar01_step2` · ScaleBitmapImage 
          - `core.scrollbar01_step1` · ScaleBitmapImage 
      - `core.Scrollbar01_BackImg` · ScaleUpDownImage width=23 height=103
        - `asset.core.scrollbar01_bg1` · bitmap 23×19 (core2.swf)
        - `asset.core.scrollbar01_bg2` · bitmap 24×60 (core2.swf)
        - `asset.core.scrollbar01_bg3` · bitmap 23×24 (core2.swf)
      - `core.Scrollbar01_Up` · BaseButton width=22 height=21
        - `core.Scrollbar01_UpImg` · ScaleFrameImage width=22 height=21
          - `asset.core.scrollbar01_up1` · bitmap 22×21 (core2.swf)
          - `asset.core.scrollbar01_up2` · bitmap 22×21 (core2.swf)
          - `asset.core.scrollbar01_up2` · bitmap 22×21 (core2.swf)
          - `asset.core.scrollbar01_up1` · bitmap 22×21 (core2.swf)
      - `core.Scrollbar01_Down` · BaseButton width=22 height=21
        - `core.Scrollbar01_DownImg` · ScaleFrameImage width=22 height=21
          - `asset.core.scrollbar01_down1` · bitmap 22×21 (core2.swf)
          - `asset.core.scrollbar01_down2` · bitmap 22×21 (core2.swf)
          - `asset.core.scrollbar01_down2` · bitmap 22×21 (core2.swf)
          - `asset.core.scrollbar01_down1` · bitmap 22×21 (core2.swf)
  - texts: `monopoly.view.MonopolyFriendAssistView.Title01` “Nome”; `monopoly.view.MonopolyFriendAssistView.Title02` “Nível”; `monopoly.view.MonopolyFriendAssistView.Title03` “Força de Combate”; `monopoly.view.MonopolyFriendAssistView.Title04` “Operação”

### monopoly.view.MonopolyGameOverFrame

- **MonopolyGameOverFrame**: “Aventura terminada” (`core_module:monopoly/view/MonopolyGameOverFrame.as`)
  - `monopoly.MonopolyGameOverFrame` · MonopolyGameOverFrame width=431 height=338
    - `core.FrameBg2` · MutipleImage 
      - `core.FrameBackgoundBase2` · Scale9CornerImage 
        - `asset.core.style02_scale9bg1` · bitmap 126×64 (framebg.swf)
        - `asset.core.style02_scale9bg2` · bitmap 38×64 (framebg.swf)
        - `asset.core.style02_scale9bg3` · bitmap 126×64 (framebg.swf)
        - `asset.core.style02_scale9bg4` · bitmap 126×18 (framebg.swf)
        - `asset.core.style02_scale9bg5` · bitmap 38×18 (framebg.swf)
        - `asset.core.style02_scale9bg6` · bitmap 126×18 (framebg.swf)
        - `asset.core.style02_scale9bg7` · bitmap 126×64 (framebg.swf)
        - `asset.core.style02_scale9bg8` · bitmap 38×64 (framebg.swf)
        - `asset.core.style02_scale9bg9` · bitmap 126×64 (framebg.swf)
    - `core.FrameTitleText` · FilterFrameText  font `Arial,14,0xFFDD83,true`
  - `monopoly.MonopolyGameOverFrame.ScaleBg` · ScaleBitmapImage x=0 y=0 width=406 height=247 ← `core.describeBackground_style06`
  - `monopoly.MonopolyGameOverFrame.ContentBg` · Image x=2 y=2
    - `asset.monopoly.GameOverFrameBg` · sprite 402.0×243.0 (monopoly.swf)
  - `monopoly.MonopolyGameOverFrame.ResultImg` · ScaleFrameImage x=67 y=13
    - `asset.monopoly.FailureTxt` · bitmap 229×53 (monopoly.swf)
    - `asset.monopoly.SuccessTxt` · bitmap 282×64 (monopoly.swf)
  - `monopoly.MonopolyGameOverFrame.ContentScroll` · ScrollPanel x=25 y=60 width=365 height=127
    - `core.VScrollbar07` · Scrollbar width=15 height=200
      - `core.VScrollbar07_Back` · ScaleUpDownImage width=14 height=33
        - `asset.core.scrollbar07_bg1` · bitmap 14×14 (core2.swf)
        - `asset.core.scrollbar07_bg2` · bitmap 14×18 (core2.swf)
        - `asset.core.scrollbar07_bg3` · bitmap 14×14 (core2.swf)
      - `core.VScrollbar07_Step` · BaseButton width=14 height=46
        - `core.Scroll07_StepAsset` · ScaleUpDownImage width=14 height=46
          - `asset.core.Scroll07_Step1` · bitmap 14×16 (core2.swf)
          - `asset.core.Scroll07_Step2` · bitmap 14×1 (core2.swf)
          - `asset.core.Scroll07_Step3` · bitmap 14×16 (core2.swf)
      - `core.VScrollbar07_Up` · BaseButton width=20 height=14
        - `asset.core.Scroll07_Up` · bitmap 20×14 (core2.swf)
      - `core.VScrollbar07_Down` · BaseButton width=20 height=14
        - `asset.core.Scroll07_Down` · bitmap 20×14 (core2.swf)
  - `monopoly.MonopolyGameOverFrame.ContentTxt` · FilterFrameText x=30 y=-5 width=300 height=24 font `Arial,14,0xffefbd,,,,,,center`
  - `monopoly.MonopolyGameOverFrame.ItemContainer` · SimpleTileList x=30 y=25
  - `monopoly.MonopolyGameOverFrame.ConfirmBtn` · IconButton x=160 y=200 ← `monopoly.MonopolyAlertFrame.SelfFightBtn`
    - `asset.monopoly.ConfirmTxt` · bitmap 79×21 (monopoly.swf)
  - `monopoly.MonopolyGameOverFrame.ItemTxt` · FilterFrameText x=0 y=0 width=130 height=24 font `Arial,14,0xffffff`
  - texts: `monopoly.view.MonopolyGameOverFrame.TitleTxt` “Aventura terminada”; `monopoly.view.MonopolyGameOverFrame.ContentTxt` “Essa aventura já terminou, durante essa viagem você obteve.”

### monopoly.view.MonopolyPetFormationFrame

- **MonopolyPetFormationFrame**: “Ajustar Formação” (`core_module:monopoly/view/MonopolyPetFormationFrame.as`)
  - `monopoly.MonopolyPetFormationFrame` · MonopolyPetFormationFrame width=650 height=470 ← `core.Frame2`
    - `core.quickBuyFrameBg` · MutipleImage 
      - `core.AlertFrameBg` · MutipleImage 
        - `core.AlertFrameBaseBg` · Scale9CornerImage 
          - `asset.core.framestyle03_scale9bg1` · bitmap 42×42 (framebg.swf)
          - `asset.core.framestyle03_scale9bg2` · bitmap 42×42 (framebg.swf)
          - `asset.core.framestyle03_scale9bg3` · bitmap 42×42 (framebg.swf)
          - `asset.core.framestyle03_scale9bg4` · bitmap 42×18 (framebg.swf)
          - `asset.core.framestyle03_scale9bg5` · bitmap 42×18 (framebg.swf)
          - `asset.core.framestyle03_scale9bg6` · bitmap 42×18 (framebg.swf)
          - `asset.core.framestyle03_scale9bg7` · bitmap 42×42 (framebg.swf)
          - `asset.core.framestyle03_scale9bg8` · bitmap 42×42 (framebg.swf)
          - `asset.core.framestyle03_scale9bg9` · bitmap 42×42 (framebg.swf)
      - `core.FrameTitleImage2` · Image width=229 height=17
        - `asset.core.frameTitleImage2` · bitmap 229×17 (framebg.swf)
    - `core.FrameTitleText` · FilterFrameText  font `Arial,14,0xFFDD83,true`
  - `monopoly.MonopolyPetFormationFrame.border` · ScaleBitmapImage x=-16 y=-2 width=631 height=402 ← `core.describeBackground_style04`
  - `monopoly.MonopolyPetFormationFrame.back` · MutipleImage x=-14 y=0
    - `asset.monopoly.Back` · bitmap 624×395 (monopoly.swf)
    - `asset.monopoly.Title` · bitmap 258×46 (monopoly.swf)
  - `monopoly.MonopolyPetFormationFrame.listBack` · ScaleBitmapImage x=-193 y=15 width=160 height=402 ← `core.commonTipBg`
  - `monopoly.MonopolyPetFormationFrame.vBox` · VBox x=-190 y=18
  - `monopoly.MonopolyPetFormationFrame.PrePageBtn` · BaseButton x=-177 y=365
    - `asset.core.PrePageBtn` · bitmap x=-5
      - `asset.core.PrePageBtn` · bitmap 30×29 (core2.swf)
  - `monopoly.MonopolyPetFormationFrame.NextPageBtn` · BaseButton x=-73 y=365
    - `asset.core.NextPageBtn` · bitmap 30×29 (core2.swf)
  - `monopoly.MonopolyPetFormationFrame.PageBg` · Image x=-181 y=366
    - `asset.core.PageNumBack` · bitmap x=35 y=-1.5 width=67
      - `asset.core.PageNumBack` · bitmap 57×30 (core2.swf)
  - `monopoly.MonopolyPetFormationFrame.PageText` · FilterFrameText x=-142 y=369 width=60 height=20 font `Arial,16,0xe6d9b0,true,,,,,center`
  - `monopoly.MonopolyPetFormationPetHeadView` · MonopolyPetFormationPetHeadView 
  - texts: `PetFormationFrame.title` “Ajustar Formação”; `PetFormationFrame.noPetInFormation` “Configure pelo menos um Einherjar.”; `public.confirm` “Confirmar”; `public.cancel` “Cancelar”; `public.prompt` “Aviso”; `WarlordsPetFormationFrame.closeTip` “Pode configurar no máximo 2 Einherjar para participar no Com”
  - subviews: `MonopolyPetFormationItemView`, `MonopolyPetFormationPetHeadView`

### monopoly.view.MonopolyPetFormationItemView

- **MonopolyPetFormationItemView** (`core_module:monopoly/view/MonopolyPetFormationItemView.as`)
  - `asset.monopoly.Bottom` · sprite 40 frames (monopoly.swf)
  - `monopoly.MonopolyPetFormationItemView.nameTxt` · FilterFrameText y=-190 font `Arial,12,0xffffff`
  - `asset.avatar.DefaultAvatarMovieAsset` · DefaultAvatarMovieAsset 
  - `asset.avatar.DefaultAvatarMovieAsset` · DefaultAvatarMovieAsset 
  - subviews: `DefaultAvatarMovieAsset`, `PetFormationMovieClip`

### monopoly.view.MonopolyPetFormationPetHeadView

- **MonopolyPetFormationPetHeadView** (`core_module:monopoly/view/MonopolyPetFormationPetHeadView.as`)
  - `monopoly.MonopolyPetFormationPetHeadView` · MonopolyPetFormationPetHeadView 
  - `monopoly.MonopolyPetFormationPetHeadView.border` · ScaleBitmapImage x=0 y=0 width=154 height=63 ← `core.describeBackground_style04`
  - `monopoly.MonopolyPetFormationPetHeadView.back` · Image x=2 y=3
    - `asset.monopoly.PetItemBg` · bitmap 150×58 (monopoly.swf)
  - `monopoly.MonopolyPetFormationPetHeadView.icon` · BaseIconView x=2 y=2
    - `asset.core.IconLoading` · sprite 42 frames (core2.swf)
  - `monopoly.MonopolyPetFormationPetHeadView.nameTxt` · FilterFrameText x=150 y=5 width=150 height=22 font `Arial,12,0xffffff`
  - `monopoly.MonopolyPetFormationPetHeadView.gradeTxt` · FilterFrameText x=83 y=35 width=66 height=22 font `Arial,12,0xedbf83,,,,,,right`
  - `monopoly.MonopolyPetFormationPetHeadView.stateFlag` · ScaleFrameImage x=-0 y=-1
    - `asset.monopoly.EnterWarImg` · bitmap 37×32 (monopoly.swf)
  - texts: `pet.list.PetListItemView.enterWarTip` “Este Einherjar já participou na Batalha.”; `PetFormationItemView.posFull` “Lugar Cheio”; `public.level2` “Nv.{0}”
  - subviews: `MonopolyPetFormationItemView`, `BaseIconView`

### mvc.controler.ApexRoomController

- **ApexRoomController** (`core_module:mvc/controler/ApexRoomController.as`)
  - `apex.room.ApexRoomView` · ApexRoomView 
  - subviews: `ApexRoomView`

### mvc.controler.AresLordsRoomController

- **AresLordsRoomController** (`core_module:mvc/controler/AresLordsRoomController.as`)
  - `areslordsroom.AresLordsRoomView` · AresLordsRoomView 
  - subviews: `AresLordsRoomView`

### mvc.controler.GloryGameRoomController

- **GloryGameRoomController** (`core_module:mvc/controler/GloryGameRoomController.as`)
  - `gloryGame.GloryGameRoomView` · GloryGameRoomView 
  - subviews: `GloryGameRoomView`

### mvc.controler.MatelordsRoomController

- **MatelordsRoomController** (`core_module:mvc/controler/MatelordsRoomController.as`)
  - `matelordsroom.MatelordsRoomView` · MatelordsRoomView x=0 y=0
  - subviews: `MatelordsRoomView`

### mvc.controler.MultilordsRoomController

- **MultilordsRoomController** (`core_module:mvc/controler/MultilordsRoomController.as`)
  - `multilordsroom.MultilordsRoomView` · MultilordsRoomView x=0 y=0

### mvc.controler.PvpRoomControl

- **PvpRoomControl** (`core_module:mvc/controler/PvpRoomControl.as`)
  - `roomPVP.PVPRoomView` · PVPRoomView x=0 y=0
  - subviews: `PVPRoomView`

### mvc.controler.RoomControl

- **RoomControl** (`core_module:mvc/controler/RoomControl.as`)
  - `room.RoomView` · RoomView 
  - `room.InstanceSelectFrame` · InstanceSelectFrame width=820 height=552 ← `core.Frame1`
  - subviews: `RoomView`, `InstanceSelectFrame`

### mvc.controler.UnrealShootingRoomController

- **UnrealShootingRoomController** (`core_module:mvc/controler/UnrealShootingRoomController.as`)
  - `unrealshootingroom.UnrealShootingRoomView` · UnrealShootingRoomView x=0 y=0
  - subviews: `UnrealShootingRoomView`

### mvc.module.gamehall.GameHallAutoView

- **GameHallAutoView** (`core_module:mvc/module/gamehall/GameHallAutoView.as`)
  - `asset.core.gameHall.cancelBack` · bitmap 357×78 (core.swf)
  - `gamehall.renfroce.CancelBtn` · IconButton x=132 y=35
    - `asset.core.Style18Btn` · bitmap 90×34 (core2.swf)
    - `asset.core.gameHall.cancelFt` · bitmap 68×19 (core.swf)
  - `gamehall.renfroce.autoCancelDesTxt` · FilterFrameText x=0 y=10 width=357 height=20 font `Arial,16,0xfff9db,true,,,,,center`
  - texts: `gameHall.east.fighting` “Desafiando {0} automaticamente...”; `public.confirm` “Confirmar”; `public.cancel` “Cancelar”; `public.prompt` “Aviso”; `gameHall.east.auto.captainStop` “Encerrar o desafio {0}?”; `gameHall.east.auto.otherStop` “Encerrar o desafio {0} e sair da equipe?”

### simplegame.christmasroses.SnowRosePresentView

- **SnowRosePresentView**: “Presentear” (`core_module:simplegame/christmasroses/SnowRosePresentView.as`)
  - `friends.SnowRosePresentView` · SnowRosePresentView width=314 height=228 ← `core.ConfirmSellFrame`
  - `friends.SnowRosePresentViewBg` · MutipleImage x=-12 y=3
    - `asset.friends.SnowRosePresentViewBg` · bitmap 182×173 (friends.swf)
    - `asset.friends.SnowRosePresentViewBg2` · Image 
      - `asset.friends.SnowRosePresentViewBg` · bitmap 182×173 (friends.swf)
  - `friends.SnowRosePresentViewBgFlower` · ScaleBitmapImage x=-25 y=-20 width=368 height=245
    - `asset.friends.SnowRosePresentViewBgFlower` · bitmap 393×220 (friends.swf)
  - `asset.friends.SnowRosePresentViewInputTipImg` · bitmap 142×28 (friends.swf)
  - `friends.SnowRosePresentViewInputBg` · ScaleBitmapImage x=5 y=43 width=170 height=25 ← `core.InputBack_style02`
  - `friends.SnowRosePresentViewContentBg` · ScaleBitmapImage x=6 y=75 width=297 height=60 ← `core.describeBackground_style06`
  - `friends.SnowRosePresentViewContentTxt` · FilterFrameText x=10 y=79 width=290 height=52 font `Arial,12,0xdad8b6`
  - `friends.SnowRosePresentViewWordCountTxt` · FilterFrameText x=151 y=134 width=150 height=20 font `Arial,12,0xdad8b6,,,,,,right`
  - `friends.SnowRosePresentViewConfirmBtn` · IconButton x=48 y=152 ← `core.AlertButtonConfirm_1`
  - `friends.SnowRosePresentViewCancleBtn` · IconButton x=172 y=152 ← `core.AlertButtonCancel_1`
  - _no style/symbol_: `friends.RosePresentViewInputComBox`
  - texts: `friends.view.RosePresentView.title` “Presentear”; `yishi.view.RosePresentView.wordCount` “Letras: {0}/{1}”; `friends.view.RosePresentView.inputTip` “Nome do amigo”; `shop.ShopControler.command01` “Não pode presentear a si mesmo!!”; `yishi.view.RosePresentView.noContent` “Você não preencheu nenhum conteúdo do presente, presentear m”; `public.prompt` “Aviso”; `public.confirm` “Confirmar”; `public.cancel` “Cancelar”

### simplegame.hamster.HamsterGame

- **HamsterGame** (`core_module:simplegame/hamster/HamsterGame.as`)
  - `task.HamsterGameBack` · GameBack x=0 y=0
  - `task.HamsterGameCountDownMc` · CountDownMc x=0 y=0
  - `task.HamsterGameSucceedMc` · SucceedMc x=0 y=0
  - `task.HamsterGameSusliks` · Susliks x=180 y=180
  - `task.HamsterGameSusliks` · Susliks x=180 y=180
  - `task.HamsterGameStick` · Stick x=167 y=169

### simplegame.hamster.HamsterGameFrame

- **HamsterGameFrame** (`core_module:simplegame/hamster/HamsterGameFrame.as`)
  - `task.hamsterRestartBtn` · IconButton x=231 y=278
    - `asset.core.Style12Btn` · bitmap 233×63 (core2.swf)
    - `asset.task.HamsterRestartBtnImg` · bitmap 104×31 (hamster.swf)
  - `task.hamsterCloseBtn` · BaseButton x=608 y=8
    - `asset.task.HamsterCloseBtn` · bitmap 26×26 (hamster.swf)
  - subviews: `HamsterGame`

### simplegame.handlsel.HandlselFrame

- **HandlselFrame**: “Presentear” (`core_module:simplegame/handlsel/HandlselFrame.as`)
  - `newYearAct.HandlselFrame` · HandlselFrame width=372 height=174 ← `core.ConfirmSellFrame`
    - `newyearact.handlselFrameBg` · MutipleImage 
      - `newyearact.handlselFrameBg_2` · ScaleBitmapImage 
        - `asset.newyearact.handlselBg02` · bitmap 
          - `asset.newyearact.handlselBg02` · bitmap 372×169 (newyearact.swf)
      - `core.FrameTitleImage2` · Image width=229 height=17
        - `asset.core.frameTitleImage2` · bitmap 229×17 (framebg.swf)
  - `newYearAct.handlselBg` · MutipleImage 
    - `asset.newyearact.handlselBg` · bitmap 
      - `asset.newyearact.handlselBg` · bitmap 363×166 (newyearact.swf)
    - `asset.newyearact.inputFriendName` · bitmap x=65 y=32
      - `asset.newyearact.inputFriendName` · bitmap 138×25 (newyearact.swf)
  - `newYearAct.inputBg` · ScaleBitmapImage x=63 y=65 width=155 height=25 ← `core.InputBack_style02`
  - `newYearAct.handlselInputComBox` · WriteMailComboxBox x=271 y=21 width=138 height=25
    - `newYearAct.handlselInputComBoxListPanel` · ListPanel 
      - `asset.newyearact.handselInputComBoxBg` · bitmap 132×99 (newyearact.swf)
      - `core.VScrollbar02` · Scrollbar width=21 height=200
        - `core.Scrollbar02_Back` · ScaleBitmapImage width=15 height=24
          - `asset.core.scrollbar02_bg` · bitmap 15×24 (core2.swf)
        - `core.Scrollbar02_Step` · BaseButton width=21 height=56
          - `core.scrollbar02_stepAsset` · ScaleBitmapImage width=21 height=56
        - `core.Scrollbar02_Up` · BaseButton width=11 height=10
          - `asset.core.scrollbar02_up` · bitmap 11×10 (core2.swf)
        - `core.Scrollbar02_Down` · BaseButton width=11 height=10
          - `asset.core.scrollbar02_down` · bitmap 11×10 (core2.swf)
    - `newYearAct.handlselInputComBoxTxt` · FilterFrameText width=155 height=20 font `Arial,12,0xdad8b6`
    - `newYearAct.handlselInputComBoxBtn` · TextButton x=-54 y=38 width=96 height=40
      - `newYearAct.handlselInputComBoxBtnBg` · MutipleImage 
        - `asset.core.AlertBtnStyle_02` · bitmap 96×40 (core2.swf)
        - `asset.core.friendsFriendImg` · bitmap x=5 y=4
          - `asset.core.friendsFriendImg` · bitmap 19×17 (core.swf)
      - `newYearAct.handlselInputComBoxBtnTxt` · FilterFrameText  font `Arial,12,0xffeda7`
  - `newYearAct.handlselConfirmBtn` · IconButton x=57 y=111 ← `core.AlertButtonConfirm_1`
  - `newYearAct.handlselCancleBtn` · IconButton x=219 y=111 ← `core.AlertButtonCancel_1`
  - `quickbuy.buyFrame` · BuyFrameI width=286 ← `core.QuickBuyFrame`
  - texts: `friends.view.RosePresentView.title` “Presentear”; `emailII.view.WriteEmailFrame.Friendlist` “Amigos”; `friends.view.RosePresentView.inputTip` “Nome do amigo”; `simplegame.handlsel.HandlselFrame.offLine` “Este amigo não está online, não pode oferecer”; `simplegame.handlsel.HandlselFrame.noThisFriend` “Este amigo não está presente”
  - subviews: `WriteMailComboxBox`, `BuyFrameI`

### simplegame.qte.QTEComponent

- **QTEComponent** (`core_module:simplegame/qte/QTEComponent.as`)
  - `asset.qte.QTEShowEf` · QTEShowEf 
  - `asset.qte.QTESuccess` · QTESuccess y=55
  - subviews: `HBox`, `QteItem`

### simplegame.qte.QTETraining

- **QTETraining** (`core_module:simplegame/qte/QTETraining.as`)
  - `task.QteBgMc` · QteBgMc x=60 y=23
  - `task.QteCloseBtn` · BaseButton x=500 y=0
    - `asset.task.QteCloseBtn` · bitmap 26×26 (qte.swf)
  - `task.QteRestartBtn` · IconButton 
    - `asset.core.Style12Btn` · bitmap 233×63 (core2.swf)
    - `asset.task.QteRestartBtnImg` · bitmap 98×27 (qte.swf)
  - `task.QteTimeMc` · QteTimeMc x=0 y=0
  - `task.CountDownMc` · CountDownMc x=0 y=0
  - `task.QteShine` · QteShine x=0 y=0
  - `task.SucceedMc` · SucceedMc x=0 y=0
  - subviews: `QTEComponent`

### simplegame.qte.QteItem

- **QteItem** (`core_module:simplegame/qte/QteItem.as`)
  - `asset.qte.QTEItem` · QTEItem 
  - `asset.qte.QTEItemShowEf` · QTEItemShowEf 
  - `asset.qte.QTEItemOkEffect` · QTEItemOkEffect x=25 y=25

### simplegame.roses.BombPrtal

- **BombPrtal** (`core_module:simplegame/roses/BombPrtal.as`)
  - `asset.chatII.MarryBomb_01` · sprite 24.0×24.0 43 frames (wedding.swf)

### simplegame.roses.FlyPetal

- **FlyPetal** (`core_module:simplegame/roses/FlyPetal.as`)
  - `asset.common.snow` · sprite 59 frames (common.swf)
  - `asset.core.Petal` · sprite 90 frames (chat.swf)
  - `asset.core.PetalPink` · sprite 90 frames (chat.swf)
  - `asset.core.PetalSnowSmall` · sprite 21.0×24.0 90 frames (chat.swf)
  - `asset.warlords.Star` · sprite 90 frames (warlords.swf)
  - `asset.wedding.flower1` · sprite (wedding.swf)

### simplegame.roses.IMQuickRosePresentView

- **IMQuickRosePresentView**: “Presentear” (`core_module:simplegame/roses/IMQuickRosePresentView.as`)
  - `friends.IMQuickRosePresentView` · IMQuickRosePresentView width=344 height=160 ← `core.ConfirmSellFrame`
  - `friends.RosePresentBackViewConfirmBtn` · IconButton x=48 y=76 ← `core.AlertButtonConfirm_1`
    - `asset.core.AlertBtnStyle_02` · bitmap 96×40 (core2.swf)
    - `friends.RosePresentBackViewConfirmBtnIcon` · ScaleFrameImage 
      - `asset.core.ConfirmTxtAsset_01` · bitmap 81×17 (core2.swf)
      - `asset.friends.RosePresentBackGiveBackImg` · bitmap 80×21 (friends.swf)
  - `friends.RosePresentBackViewCancleBtn` · IconButton x=202 y=76 ← `core.AlertButtonCancel_1`
    - `friends.RosePresentBackViewCancleBtnIcon` · ScaleFrameImage 
      - `asset.core.CancelTxtAsset_01` · bitmap 75×18 (core2.swf)
      - `asset.friends.RosePresentBackChatImg` · bitmap 91×19 (friends.swf)
  - `friends.RosePresentBackViewInputTipTxt` · FilterFrameText x=20 y=30 width=100 height=36 font `Arial,14,0xffc62c,true`
  - `friends.RosePresentBackViewInputNumTxt` · FilterFrameText x=114 y=37 width=60 height=20 font `Arial,12,0xffebc5`
  - `friends.RosePresentBackViewInputNumBg` · ScaleBitmapImage x=108 y=34 width=195 height=25
    - `asset.friends.FriendsSearchBg` · bitmap width=240
      - `asset.friends.FriendsSearchBg` · bitmap 212×27 (friends.swf)
  - texts: `friends.view.RosePresentView.title` “Presentear”; `simplegame.roses.RosePresentBackView.inputNum` “Inserir quantidade”; `Auction.ResultAlert2` “Item inexistente”; `friends.im.IMFrame.present.NotFriends` “Jogador não é seu amigo”

### simplegame.roses.PetalFlyView

- **PetalFlyView** (`core_module:simplegame/roses/PetalFlyView.as`)
  - `asset.core.PetalPinkPopEffect` · sprite 49 frames (chat.swf)
  - `asset.core.PetalPopEffect` · sprite 49 frames (chat.swf)
  - `asset.core.PetalSnowSmall` · sprite 21.0×24.0 90 frames (chat.swf)
  - `asset.core.RoseEffect` · sprite 53 frames (chat.swf)
  - `asset.warlords.FireworkStyle4` · sprite 55 frames (warlords.swf)
  - `asset.wedding.redHeart` · sprite (wedding.swf)
  - subviews: `BombPrtal`, `FlyPetal`

### simplegame.roses.RosePresentBackNewView

- **RosePresentBackNewView**: “Presentear de volta” (`core_module:simplegame/roses/RosePresentBackNewView.as`)
  - `friends.RosePresentBackNewView` · RosePresentBackNewView width=350 ← `core.ConfirmSellFrame2`
  - `friends.RosePresentBackViewConfirmBtn1` · IconButton x=202 y=140 ← `core.AlertButtonConfirm_1`
    - `asset.core.AlertBtnStyle_02` · bitmap 96×40 (core2.swf)
    - `friends.RosePresentBackViewConfirmBtnIcon` · ScaleFrameImage 
      - `asset.core.ConfirmTxtAsset_01` · bitmap 81×17 (core2.swf)
      - `asset.friends.RosePresentBackGiveBackImg` · bitmap 80×21 (friends.swf)
  - `friends.RosePresentBackViewCancleBtn1` · IconButton x=48 y=140 ← `core.AlertButtonCancel_1`
    - `friends.RosePresentBackViewCancleBtnIcon` · ScaleFrameImage 
      - `asset.core.CancelTxtAsset_01` · bitmap 75×18 (core2.swf)
      - `asset.friends.RosePresentBackChatImg` · bitmap 91×19 (friends.swf)
  - `friends.RosePresentBackViewContentContainer1` · Sprite x=-18 y=202
  - `friends.RosePresentViewBg1` · MutipleImage x=-9 y=2
    - `asset.friends.RosePresentViewBg1` · bitmap 364×200 (friends.swf)
    - `friends.LaceStyle041` · Image 
      - `asset.core.LaceStyle041` · bitmap 195×97 (friends.swf)
    - `friends.LaceStyle031` · Image 
      - `asset.core.LaceStyle031` · bitmap 113×58 (friends.swf)
    - `friends.LaceStyle021` · Image 
      - `asset.core.LaceStyle021` · bitmap 138×50 (friends.swf)
  - `friends.RosePresentViewNewBg2` · MutipleImage x=-12 y=3
    - `border.bg1` · Image 
      - `asset.border.bg1` · bitmap 30×30 (friends.swf)
    - `border.bg2` · Image 
      - `asset.border.bg2` · bitmap 15×30 (friends.swf)
    - `border.bg3` · Image 
      - `asset.border.bg3` · bitmap 30×30 (friends.swf)
    - `border.bg4` · Image 
      - `asset.border.bg4` · bitmap 30×15 (friends.swf)
    - `border.bg5` · Image 
      - `asset.border.bg5` · bitmap 30×15 (friends.swf)
    - `border.bg6` · Image 
      - `asset.border.bg6` · bitmap 30×30 (friends.swf)
    - `border.bg7` · Image 
      - `asset.border.bg7` · bitmap 15×30 (friends.swf)
    - `border.bg8` · Image 
      - `asset.border.bg8` · bitmap 30×30 (friends.swf)
    - `asset.core.frameTitleImage2` · bitmap 229×17 (framebg.swf)
  - `asset.friends.textBg` · bitmap x=5 y=20
    - `asset.friends.textBg` · bitmap 333×97 (friends.swf)
  - `friends.RosePresentBackViewPresentNameTxt1` · GradientText x=38 y=35 width=180 height=20
    - `friends.RosePresentBackViewPresentNameTextField1` · FilterFrameText width=268 height=40 font `Arial,18,0xffffff,,,,,,center`
  - `friends.RosePresentBackViewPresentShowTxt1` · GradientText x=8 y=70 width=180 height=20
    - `friends.RosePresentBackViewPresentNameTextField1` · FilterFrameText width=268 height=40 font `Arial,18,0xffffff,,,,,,center`
  - `friends.RosePresentBackViewChangeContentTxt` · FilterFrameText x=-7 y=178 font `Arial,12,0x00d8ff,,,true,,,left`
  - `friends.RosePresentBackViewContentBg1` · MutipleImage 
    - `friends.RosePresentViewNewBg4` · MutipleImage x=-15 y=0
      - `border.bg1` · Image 
        - `asset.border.bg1` · bitmap 30×30 (friends.swf)
      - `border.bg2` · Image 
        - `asset.border.bg2` · bitmap 15×30 (friends.swf)
      - `border.bg3` · Image 
        - `asset.border.bg3` · bitmap 30×30 (friends.swf)
      - `border.bg4` · Image 
        - `asset.border.bg4` · bitmap 30×15 (friends.swf)
      - `border.bg5` · Image 
        - `asset.border.bg5` · bitmap 30×15 (friends.swf)
      - `border.bg6` · Image 
        - `asset.border.bg6` · bitmap 30×30 (friends.swf)
      - `border.bg7` · Image 
        - `asset.border.bg7` · bitmap 15×30 (friends.swf)
      - `border.bg8` · Image 
        - `asset.border.bg8` · bitmap 30×30 (friends.swf)
    - `asset.friends.RosePresentBackViewContentBaseBg1` · bitmap 364×63 (friends.swf)
    - `friends.RosePresentBackViewContentInputBg` · ScaleBitmapImage  ← `core.describeBackground_style06`
  - `friends.RosePresentBackViewContentTxt1` · FilterFrameText x=19 y=21 width=343 height=34 ← `friends.RosePresentViewContentTxt1`
  - `quickbuy.buyFrame` · BuyFrameI width=286 ← `core.QuickBuyFrame`
  - texts: `simplegame.roses.RosePresentBackView.presentBack` “Presentear de volta”; `yishi.view.RosePresentView.defaultContent0` “Não há palavras para expressar o meu profundo amor por você”; `simplegame.roses.RosePresentBackView.presentShowContent` “o presenteou um ramo de {0}”; `simplegame.roses.RosePresentBackView.changeContent` “Modificar mensagem”; `yishi.view.RosePresentView.noContent` “Você não preencheu nenhum conteúdo do presente, presentear m”; `public.prompt` “Aviso”; `public.confirm` “Confirmar”; `public.cancel` “Cancelar”
  - subviews: `BuyFrameI`

### simplegame.roses.RosePresentBackView

- **RosePresentBackView**: “Presentear de volta” (`core_module:simplegame/roses/RosePresentBackView.as`)
  - `friends.RosePresentBackView` · RosePresentBackView width=345 ← `core.ConfirmSellFrame`
  - `friends.RosePresentBackViewConfirmBtn` · IconButton x=48 y=76 ← `core.AlertButtonConfirm_1`
    - `asset.core.AlertBtnStyle_02` · bitmap 96×40 (core2.swf)
    - `friends.RosePresentBackViewConfirmBtnIcon` · ScaleFrameImage 
      - `asset.core.ConfirmTxtAsset_01` · bitmap 81×17 (core2.swf)
      - `asset.friends.RosePresentBackGiveBackImg` · bitmap 80×21 (friends.swf)
  - `friends.RosePresentBackViewCancleBtn` · IconButton x=202 y=76 ← `core.AlertButtonCancel_1`
    - `friends.RosePresentBackViewCancleBtnIcon` · ScaleFrameImage 
      - `asset.core.CancelTxtAsset_01` · bitmap 75×18 (core2.swf)
      - `asset.friends.RosePresentBackChatImg` · bitmap 91×19 (friends.swf)
  - `friends.RosePresentBackViewContentContainer` · Sprite x=-20 y=202
  - `friends.RosePresentBackViewBg` · MutipleImage x=-12 y=3
    - `asset.friends.RosePresentBackViewBg` · bitmap 183×198 (friends.swf)
    - `friends.RosePresentBackViewBgTurn` · Image 
      - `asset.friends.RosePresentBackViewBg` · bitmap 183×198 (friends.swf)
    - `friends.BgStyle01` · ScaleUpDownImage 
      - `asset.friends.BgStyle01_U` · bitmap 336×8 (friends.swf)
      - `asset.friends.BgStyle01_M` · bitmap 336×9 (friends.swf)
      - `asset.friends.BgStyle01_D` · bitmap 336×10 (friends.swf)
    - `friends.LaceStyle04` · Image 
      - `asset.core.LaceStyle04` · bitmap 98×24 (chat.swf)
    - `friends.LaceStyle03` · Image 
      - `asset.core.LaceStyle03` · bitmap 187×39 (chat.swf)
    - `friends.LaceStyle02` · Image 
      - `asset.core.LaceStyle02` · bitmap 100×39 (chat.swf)
    - `asset.core.LaceStyle05` · bitmap 119×112 (chat.swf)
  - `friends.RosePresentBackViewPresentNameTxt` · GradientText x=38 y=35 ← `core.NpcName_VipText`
    - `friends.RosePresentBackViewPresentNameTextField` · FilterFrameText width=268 height=40 font `Arial,18,0xffffff,,,,,,center`
  - `friends.RosePresentBackViewPresentShowTxt` · GradientText x=38 y=70 ← `core.NpcName_VipText`
    - `friends.RosePresentBackViewPresentShowTextField` · FilterFrameText width=268 height=40 font `Arial,14,0xffffff,,,,,,center`
  - `friends.RosePresentBackView99Tab` · SelectedIconTextButton x=46 y=121 width=150 height=22 ← `friends.ExactFindBtn`
  - `friends.RosePresentBackView999Tab` · SelectedIconTextButton x=210 y=121 width=150 height=22 ← `friends.ExactFindBtn`
  - `friends.RosePresentBackViewChangeContentTxt` · FilterFrameText x=-7 y=178 font `Arial,12,0x00d8ff,,,true,,,left`
  - `friends.RosePresentBackViewContentBg` · MutipleImage 
    - `core.AlertFrameBaseBg` · Scale9CornerImage 
      - `asset.core.framestyle03_scale9bg1` · bitmap 42×42 (framebg.swf)
      - `asset.core.framestyle03_scale9bg2` · bitmap 42×42 (framebg.swf)
      - `asset.core.framestyle03_scale9bg3` · bitmap 42×42 (framebg.swf)
      - `asset.core.framestyle03_scale9bg4` · bitmap 42×18 (framebg.swf)
      - `asset.core.framestyle03_scale9bg5` · bitmap 42×18 (framebg.swf)
      - `asset.core.framestyle03_scale9bg6` · bitmap 42×18 (framebg.swf)
      - `asset.core.framestyle03_scale9bg7` · bitmap 42×42 (framebg.swf)
      - `asset.core.framestyle03_scale9bg8` · bitmap 42×42 (framebg.swf)
      - `asset.core.framestyle03_scale9bg9` · bitmap 42×42 (framebg.swf)
    - `asset.friends.RosePresentBackViewContentBaseBg` · bitmap 183×63 (friends.swf)
    - `friends.RosePresentBackViewContentBaseBgTurn` · Image 
      - `asset.friends.RosePresentBackViewContentBaseBg` · bitmap 183×63 (friends.swf)
    - `friends.RosePresentBackViewContentInputBg` · ScaleBitmapImage  ← `core.describeBackground_style06`
  - `friends.RosePresentBackViewContentTxt` · FilterFrameText x=19 y=13 width=343 height=34 ← `friends.RosePresentViewContentTxt`
  - `friends.RosePresentBackViewWordCountTxt` · FilterFrameText x=210 y=49 ← `friends.RosePresentViewWordCountTxt`
  - `friends.RosePresentBackViewInputTipTxt` · FilterFrameText x=20 y=30 width=100 height=36 font `Arial,14,0xffc62c,true`
  - `friends.RosePresentBackViewInputNumTxt` · FilterFrameText x=114 y=37 width=60 height=20 font `Arial,12,0xffebc5`
  - `friends.RosePresentBackViewInputNumBg` · ScaleBitmapImage x=108 y=34 width=195 height=25
    - `asset.friends.FriendsSearchBg` · bitmap width=240
      - `asset.friends.FriendsSearchBg` · bitmap 212×27 (friends.swf)
  - `quickbuy.buyFrame` · BuyFrameI width=286 ← `core.QuickBuyFrame`
  - texts: `simplegame.roses.RosePresentBackView.presentBack` “Presentear de volta”; `yishi.view.RosePresentView.defaultContent1` “Vamos festejar nossa amizade eterna！”; `yishi.view.RosePresentView.defaultContent2` “Está expressando sua afeto nesse  céu de pétalas de rosas!”; `simplegame.roses.RosePresentBackView.presentShowContent` “o presenteou um ramo de {0}”; `simplegame.roses.RosePresentBackView.changeContent` “Modificar mensagem”; `yishi.view.RosePresentView.wordCount` “Letras: {0}/{1}”; `simplegame.roses.RosePresentBackView.inputNum` “Inserir quantidade”; `yishi.view.RosePresentView.noContent` “Você não preencheu nenhum conteúdo do presente, presentear m”
  - subviews: `BuyFrameI`

### simplegame.roses.RosePresentView

- **RosePresentView**: “Presentear” (`core_module:simplegame/roses/RosePresentView.as`)
  - `friends.RosePresentView` · RosePresentView width=314 height=228 ← `core.ConfirmSellFrame`
  - `friends.RosePresentViewBg` · MutipleImage x=-12 y=3
    - `asset.friends.RosePresentViewBg` · bitmap 333×192 (friends.swf)
    - `friends.LaceStyle04` · Image 
      - `asset.core.LaceStyle04` · bitmap 98×24 (chat.swf)
    - `friends.LaceStyle03` · Image 
      - `asset.core.LaceStyle03` · bitmap 187×39 (chat.swf)
    - `friends.LaceStyle02` · Image 
      - `asset.core.LaceStyle02` · bitmap 100×39 (chat.swf)
  - `asset.friends.RosePresentViewInputTipImg` · bitmap x=5 y=18
    - `asset.friends.RosePresentViewInputTipImg` · bitmap 147×27 (friends.swf)
  - `friends.RosePresentViewInputBg` · ScaleBitmapImage x=5 y=43 width=170 height=25 ← `core.InputBack_style02`
  - `friends.RosePresentViewContentBg` · ScaleBitmapImage x=6 y=75 width=297 height=60 ← `core.describeBackground_style06`
  - `friends.RosePresentViewContentTxt` · FilterFrameText x=10 y=79 width=290 height=52 font `Arial,12,0xdad8b6`
  - `friends.RosePresentViewWordCountTxt` · FilterFrameText x=151 y=134 width=150 height=20 font `Arial,12,0xdad8b6,,,,,,right`
  - `friends.RosePresentViewConfirmBtn` · IconButton x=48 y=152 ← `core.AlertButtonConfirm_1`
  - `friends.RosePresentViewCancleBtn` · IconButton x=172 y=152 ← `core.AlertButtonCancel_1`
  - _no style/symbol_: `friends.RosePresentViewInputComBox`
  - texts: `friends.view.RosePresentView.title` “Presentear”; `yishi.view.RosePresentView.wordCount` “Letras: {0}/{1}”; `friends.view.RosePresentView.inputTip` “Nome do amigo”; `shop.ShopControler.command01` “Não pode presentear a si mesmo!!”; `yishi.view.RosePresentView.noContent` “Você não preencheu nenhum conteúdo do presente, presentear m”; `public.prompt` “Aviso”; `public.confirm` “Confirmar”; `public.cancel` “Cancelar”

### svs.view.SvsFrame

- **SvsFrame** (`core_module:svs/view/SvsFrame.as`)
  - `svs.SvsFrame` · SvsFrame width=1000 height=600
  - `asset.svsmap.svsFrameBg` · bitmap x=0 y=0
    - `asset.svsmap.svsFrameBg` · bitmap 1500×900 (svsmap.swf)
  - subviews: `SvsView`

### svs.view.SvsView

- **SvsView** (`core_module:svs/view/SvsView.as`)
  - `svs.SvsView.Bg` · Image x=185 y=10
    - `asset.svsmap.svsViewBg` · sprite 629.0×199.0 (svsmap.swf)
  - `svsmap.svsViewOpenTips` · svsViewOpenTips x=120 y=260
  - `asset.svsmap.svsFrameVSIcon` · bitmap x=170 y=320
    - `asset.svsmap.svsFrameVSIcon` · bitmap 315×63 (svsmap.swf)
  - `svs.SvsView.JoinBtn` · IconButton x=389 y=420
    - `asset.svsmap.svsFrameJoinBtnBg` · bitmap 223×68 (svsmap.swf)
    - `asset.svsmap.svsFrameJoinBtnTxt` · bitmap 202×25 (svsmap.swf)
  - `svs.SvsView.ShopBtn` · BaseButton x=900 y=300
    - `asset.svsmap.svsFrameShopBtn` · bitmap 115×85 (svsmap.swf)
  - `svs.SvsView.ListBtn` · FilterFrameText x=625 y=445 width=150 height=20 font `Arial,14,0x01fd36,,,true,,,left`
  - `svs.SvsView.RankBtn` · IconButton x=900 y=400
    - `asset.svsmap.svsFrameSortBtnBg` · bitmap 81×29 (svsmap.swf)
    - `asset.svsmap.svsFrameSortBtnTxt` · bitmap 81×29 (svsmap.swf)
  - `svs.SvsView.HelpBtn` · IconButton x=900 y=440
    - `asset.svsmap.svsFrameHelpBtnBg` · bitmap 81×29 (svsmap.swf)
    - `asset.svsmap.svsFrameHelpBtnTxt` · bitmap 81×29 (svsmap.swf)
  - `asset.svsmap.timeNumBmd` · bitmap 
    - `asset.svsmap.timeNumBmd` · bitmap 230×31 (svsmap.swf)
  - `asset.svsmap.timeNumBmdGold` · bitmap 
    - `asset.svsmap.timeNumBmdGold` · bitmap 230×31 (svsmap.swf)
  - `svs.SvsView.YearSprite` · Sprite x=360 y=260
  - `svs.SvsView.MouthSprite` · Sprite x=320 y=260
  - `svs.SvsView.DaySprite` · Sprite x=280 y=260
  - `svs.SvsView.StartHourSprite` · Sprite x=450 y=260
  - `svs.SvsView.StartMinuteSprite` · Sprite x=485 y=260
  - `svs.SvsView.SelfServerName` · GradientText x=0 y=333 width=460 height=60
    - `svs.SvsView.SelfServerNameTxt` · FilterFrameText width=460 height=60 font `Arial,42,0xFFFFFF,true,,,,,right`
  - `svs.SvsView.MatchServerName` · GradientText x=552 y=333 width=460 height=60
    - `svs.SvsView.MatchServerNameTxt` · FilterFrameText width=460 height=60 font `Arial,42,0xFFFFFF,true,,,,,left`
  - `svs.SvsView.SvsInfoTips` · GradientText x=180 y=333 width=640 height=60
    - `svs.SvsView.SvsInfoTipsTxt` · FilterFrameText width=640 height=60 font `Arial,42,0xFFFFFF,true,,,,,center`
  - `svsmap.TurnBtn1` · SelectedButton x=320 y=240
    - `svsmap.TurnBtn1Unselected` · IconButton width=95 height=28
      - `asset.svsmap.turnUnselected1` · bitmap 97×29 (svsmap.swf)
    - `svsmap.TurnBtn1Selected` · IconButton x=-2 y=-5 width=95 height=28
      - `asset.svsmap.turnSelectedBg` · bitmap 95×28 (svsmap.swf)
      - `asset.svsmap.turnSelected1` · bitmap 97×29 (svsmap.swf)
  - `svsmap.TurnBtn2` · SelectedButton x=410 y=240
    - `svsmap.TurnBtn2Unselected` · IconButton  ← `svsmap.TurnBtn1Unselected`
      - `asset.svsmap.turnUnselected2` · bitmap 97×29 (svsmap.swf)
    - `svsmap.TurnBtn2Selected` · IconButton x=-2 y=-5 ← `svsmap.TurnBtn1Selected`
      - `asset.svsmap.turnSelected2` · bitmap 97×29 (svsmap.swf)
  - `svsmap.TurnBtn3` · SelectedButton x=500 y=240
    - `svsmap.TurnBtn3Unselected` · IconButton  ← `svsmap.TurnBtn1Unselected`
      - `asset.svsmap.turnUnselected3` · bitmap 97×29 (svsmap.swf)
    - `svsmap.TurnBtn3Selected` · IconButton x=-2 y=-5 ← `svsmap.TurnBtn1Selected`
      - `asset.svsmap.turnSelected3` · bitmap 97×29 (svsmap.swf)
  - `svsmap.TurnBtn4` · SelectedButton x=590 y=240
    - `svsmap.TurnBtn4Unselected` · IconButton  ← `svsmap.TurnBtn1Unselected`
      - `asset.svsmap.turnUnselected4` · bitmap 98×29 (svsmap.swf)
    - `svsmap.TurnBtn4Selected` · IconButton x=-2 y=-5 ← `svsmap.TurnBtn1Selected`
      - `asset.svsmap.turnSelected4` · bitmap 98×29 (svsmap.swf)
  - `svsmap.TurnBtnGold1` · SelectedButton x=320 y=240
    - `svsmap.TurnBtnGold1Unselected` · IconButton  ← `svsmap.TurnBtn1Unselected`
      - `asset.svsmap.turnGold1` · bitmap 97×29 (svsmap.swf)
    - `svsmap.TurnBtnGold1Selected` · IconButton  ← `svsmap.TurnBtn1Selected`
      - `asset.svsmap.turnGold1` · bitmap 97×29 (svsmap.swf)
  - `svsmap.TurnBtnGold2` · SelectedButton x=410 y=240
    - `svsmap.TurnBtnGold2Unselected` · IconButton  ← `svsmap.TurnBtn1Unselected`
      - `asset.svsmap.turnGold2` · bitmap 97×29 (svsmap.swf)
    - `svsmap.TurnBtnGold2Selected` · IconButton  ← `svsmap.TurnBtn1Selected`
      - `asset.svsmap.turnGold2` · bitmap 97×29 (svsmap.swf)
  - `svsmap.TurnBtnGold3` · SelectedButton x=500 y=240
    - `svsmap.TurnBtnGold3Unselected` · IconButton  ← `svsmap.TurnBtn1Unselected`
      - `asset.svsmap.turnGold3` · bitmap 97×29 (svsmap.swf)
    - `svsmap.TurnBtnGold3Selected` · IconButton  ← `svsmap.TurnBtn1Selected`
      - `asset.svsmap.turnGold3` · bitmap 97×29 (svsmap.swf)
  - `svsmap.TurnBtnGold4` · SelectedButton x=590 y=240
    - `svsmap.TurnBtnGold4Unselected` · IconButton  ← `svsmap.TurnBtn1Unselected`
      - `asset.svsmap.turnGold4` · bitmap 98×29 (svsmap.swf)
    - `svsmap.TurnBtnGold4Selected` · IconButton  ← `svsmap.TurnBtn1Selected`
      - `asset.svsmap.turnGold4` · bitmap 98×29 (svsmap.swf)
  - `svs.HelperFrame` · SimpleHelpFrame  ← `core.SimpleHelpFrame`
  - texts: `svs.view.SvsFrame.listBtnTxt` “Membro de combate”; `svs.view.SvsFrame.svsInfoTipsTxt01` “Ainda não agrupou”; `svs.view.SvsFrame.svsInfoTipsTxt02` “Não existe uma rodada atualmente”; `svs.view.SvsFrame.svsInfoTipsTxt03` “Encerrado”
  - subviews: `SimpleHelpFrame`

### svs.view.ranklists.SvsRankItem

- **SvsRankItem** (`core_module:svs/view/ranklists/SvsRankItem.as`)
  - `svs.SvsRankItem.ItemGap` · ScaleLeftRightImage x=0 y=29 width=418 height=3
    - `asset.core.gapLine01` · bitmap 81×2 (core.swf)
    - `asset.core.gapLine02` · bitmap 7×2 (core.swf)
    - `asset.core.gapLine03` · bitmap 80×2 (core.swf)
  - `svs.SvsRankItem.RankImg` · ScaleFrameImage x=40 y=-1
    - `asset.svsmap.RankNum1` · bitmap 38×28 (snowball.swf)
    - `asset.svsmap.RankNum2` · bitmap 38×28 (snowball.swf)
    - `asset.svsmap.RankNum3` · bitmap 38×28 (snowball.swf)
  - `svs.SvsRankItem.RankTxt` · FilterFrameText x=0 y=5 width=114 height=20 font `Arial,14,0xe4d29c,,,,,,center`
  - `svs.SvsRankItem.NameTxt` · FilterFrameText x=120 y=5 width=160 height=20 font `Arial,14,0xe4d29c,,,,,,center`
  - `svs.SvsRankItem.FightPowerTxt` · FilterFrameText x=280 y=5 width=140 height=20 font `Arial,14,0xe4d29c,,,,,,center`

### svs.view.ranklists.SvsRankListFrame

- **SvsRankListFrame**: “Templo Sagrado Batalha do Caos” (`core_module:svs/view/ranklists/SvsRankListFrame.as`)
  - `svs.SvsRankListFrame` · SvsRankListFrame width=450 height=495 ← `core.Frame2`
  - `svs.SvsRankListFrame.Bg` · MutipleImage x=0 y=23
    - `core.describeBackground_style04` · ScaleBitmapImage 
      - `asset.core.describeBackground_style04` · bitmap 78×38 (core2.swf)
    - `asset.warlords.SplitLine` · bitmap 60×3 (warlords.swf)
    - `asset.core.pageBg` · bitmap 
      - `asset.core.pageBg` · bitmap 64×33 (core2.swf)
    - `svs.SvsRankListFrame.MyRankBg` · MutipleImage x=3 y=359
      - `svs.SvsRankListFrameMyRankBgBack` · ScaleBitmapImage 
        - `asset.warlords.MyRankBg` · bitmap 69×44 (warlords.swf)
      - `asset.warlords.MyRankTxtBg` · bitmap 146×17 (warlords.swf)
      - `asset.svsmap.svsRankTxt` · bitmap 104×20 (svsmap.swf)
      - `asset.warlords.RankTxt` · bitmap 37×18 (warlords.swf)
      - `warlords.WarlordsRankFrameTxtBg` · ScaleLeftRightImage 
        - `asset.warlords.TxtBg_L` · bitmap 15×27 (warlords.swf)
        - `asset.warlords.TxtBg_M` · bitmap 1×27 (warlords.swf)
        - `asset.warlords.TxtBg_R` · bitmap 15×27 (warlords.swf)
      - `asset.warlords.FightTxt` · bitmap 47×18 (warlords.swf)
      - `warlords.WarlordsRankFrameTxtBg` · ScaleLeftRightImage 
        - `asset.warlords.TxtBg_L` · bitmap 15×27 (warlords.swf)
        - `asset.warlords.TxtBg_M` · bitmap 1×27 (warlords.swf)
        - `asset.warlords.TxtBg_R` · bitmap 15×27 (warlords.swf)
  - `svs.SvsRankListFrame.ContentBg` · Scale9CornerImage x=4 y=26 width=420 height=310 ← `core.describeBackground_style40`
  - `svs.SvsRankListFrame.TitileGap` · MutipleImage x=4 y=27
    - `asset.svsmap.titleGap` · bitmap 18×28 (svsmap.swf)
    - `asset.svsmap.titleGap` · bitmap 18×28 (svsmap.swf)
  - `svs.SvsRankListFrame.ItemVBox` · VBox x=5 y=65
  - `svs.SvsRankListFrame.RankTitleTxt` · FilterFrameText x=30 y=35 ← `warlords.WarlordsWinPrizesFrameNameTitleTxt`
  - `svs.SvsRankListFrame.NameTitleTxt` · FilterFrameText x=170 y=35 ← `warlords.WarlordsWinPrizesFrameNameTitleTxt`
  - `svs.SvsRankListFrame.FightTitleTxt` · FilterFrameText x=285 y=35 ← `warlords.WarlordsWinPrizesFrameNameTitleTxt`
  - `svs.SvsRankListFrame.PageTxt` · FilterFrameText x=180 y=349 width=60 height=20 font `Arial,16,0xe6d9b0,true,,,,,center`
  - `svs.SvsRankListFrame.PrePageBtn` · IconButton x=104 y=345 ← `core.LastPageBtn`
  - `svs.SvsRankListFrame.NextPageBtn` · IconButton x=250 y=345 ← `core.NextPageBtn`
  - `svs.SvsRankListFrame.MyRankTxt` · FilterFrameText x=77 y=404 width=105 height=20 font `Arial,12,0xe4d29c,,,,,,center`
  - `svs.SvsRankListFrame.MyFightTxt` · FilterFrameText x=290 y=404 width=105 height=20 ← `warlords.WarlordsRankFrameMyRankTxt`
  - texts: `svs.view.ranklists.SvsRankListFrame.title` “Templo Sagrado Batalha do Caos”; `svs.view.ranklists.SvsRankListFrame.TitleTxt01` “Ranking”; `svs.view.ranklists.SvsRankListFrame.TitleTxt02` “Servidor”; `svs.view.ranklists.SvsRankListFrame.TitleTxt03` “Poder de combate”; `svs.view.ranklists.SvsRankListFrame.RankTxt01` “Rank {0}º lugar”; `svs.view.ranklists.SvsRankListFrame.RankTxt02` “Rank {0}º lugar”; `colosseum.view.ColosseumPlayerItem.newPeople` “Iniciante”
  - subviews: `SvsRankItem`

### svs.view.warteam.SvsEnterWarAddFrame

- **SvsEnterWarAddFrame**: “Lista de Participantes” (`core_module:svs/view/warteam/SvsEnterWarAddFrame.as`)
  - `svs.SvsEnterWarAddFrame` · SvsEnterWarAddFrame width=925 height=478 ← `core.Frame2`
  - `svs.SvsEnterWarLeftView` · SvsEnterWarLeftView x=2
  - `asset.mainToolBar.IntensifyIcon` · bitmap x=0 y=145
    - `asset.mainToolBar.IntensifyIcon` · bitmap 58×135 (maintoolbar.swf)
  - `svs.SvsEnterWarRightView` · SvsEnterWarRightView x=385
  - `consortia.HelpBtn` · BaseButton x=762 y=-46
    - `asset.core.HelpButton_01` · bitmap 26×26 (core2.swf)
  - `gvg.WarmanSearchBack` · ScaleBitmapImage x=161 y=-8 width=180 ← `core.InputBack_Style_06`
  - `gvg.WarmanSearchTxt` · FilterFrameText x=170 y=-2 width=150 height=20 font `Arial,12,0x7d6429,,,,,,left`
  - `gvg.WarmanSearchTxt` · FilterFrameText x=170 y=-2 width=150 height=20 font `Arial,12,0x7d6429,,,,,,left`
  - `gvg.WarmanSearchBtn` · SimpleBitmapButton x=313 y=-3
    - `asset.core.zoomBtnImg` · bitmap 
      - `asset.core.zoomBtnImg` · bitmap 20×20 (core.swf)
  - `svs.HelperFrame` · SimpleHelpFrame  ← `core.SimpleHelpFrame`
  - texts: `svs.view.warteam.SvsEnterWarAddFrame.helpBtn` “Instruções da Batalha do Caos”; `gvg.view.ready.EnterWarFrame.title` “Lista de Participantes”; `gvg.WarmanTip` “Nome do jogador”
  - subviews: `SvsEnterWarLeftView`, `SvsEnterWarRightView`, `SimpleHelpFrame`

### svs.view.warteam.SvsEnterWarFrame

- **SvsEnterWarFrame**: “Lista de Participantes” (`core_module:svs/view/warteam/SvsEnterWarFrame.as`)
  - `svs.SvsEnterWarFrame` · SvsEnterWarFrame width=536 height=530 ← `core.Frame2`
  - `svs.SvsEnterWarRightView` · SvsEnterWarRightView x=385
  - `svs.AddMemberButton` · IconButton x=177 y=390 width=96 height=40 ← `gvg.ManagerAddButton`
    - `asset.core.AlertBtnStyle_01` · bitmap 96×40 (core2.swf)
    - `gvg.AddMemberButtonText` · FilterFrameText width=55 height=24 font `Arial,12,0xe4d29c,,,,,,center`
    - `asset.mainToolBar.TipsAddFriendsIcon` · bitmap x=6 y=1
      - `asset.mainToolBar.TipsAddFriendsIcon` · bitmap 20×22 (maintoolbar.swf)
  - `gvg.WarmanTipsTxt` · FilterFrameText x=150 y=0 width=270 height=20 font `Arial,12,0xff0100,true,,,,,right`
  - texts: `gvg.view.ready.EnterWarFrame.title` “Lista de Participantes”; `map.campaign.view.frame.ArmyManageFrame.add` “Adicionar”; `gvg.InwarTips` “Aviso:”; `gvg.NotinWarList` “Você não está na lista de participantes!”; `gvg.InWarList` “Você já está na lista de participantes!”
  - subviews: `SvsEnterWarRightView`

### svs.view.warteam.SvsEnterWarLeftItem

- **SvsEnterWarLeftItem** (`core_module:svs/view/warteam/SvsEnterWarLeftItem.as`)
  - `gvg.EnterWarItemBg` · ScaleFrameImage width=441 height=32
  - `gvg.EnterWarOverBg` · ScaleBitmapImage x=-4 y=-4 width=442 ← `core.ItemOver1`
  - `core.HeroVocation` · ScaleFrameImage x=-2 y=-2 width=26 height=26
    - `asset.core.SoldierIcon` · bitmap 26×26 (core.swf)
    - `asset.core.PickManIcon` · bitmap 26×26 (core.swf)
    - `asset.croe.WizardIcon` · bitmap 26×26 (core.swf)
  - `gvg.EnterWarText01` · FilterFrameText x=58 y=6 width=115 height=20 font `Arial,12,0xe4d29c,,,,,,left`
  - `gvg.EnterWarText02` · FilterFrameText x=155 y=6 width=56 height=20 font `Arial,14,0xe4d29c,true,,,,,center`
  - `gvg.EnterWarText04` · FilterFrameText x=225 y=6 width=110 height=20 font `Arial,12,0xe4d29c,true,,,,,center`
  - `gvg.EnterWarAddBtn` · SimpleBitmapButton x=300 y=4
    - `asset.core.UpButton1` · bitmap 27×26 (core2.swf)
  - `gvg.VocationIcon` · ScaleFrameImage x=148 y=3 ← `core.VocationIcon`
  - `asset.core.simpleVIPIcon` · bitmap 
    - `asset.core.simpleVIPIcon` · bitmap 18×16 (core2.swf)
  - `gvg.EnterWarText01.GradientText` · GradientText x=0 y=0 width=115 height=20
    - `gvg.EnterWarText01.GradientTextField` · FilterFrameText x=58 y=6 width=115 height=20 font `Arial,14,0xffffff,,,,,,left`
  - subviews: `ConsortiaPlayerMenu`

### svs.view.warteam.SvsEnterWarLeftView

- **SvsEnterWarLeftView** (`core_module:svs/view/warteam/SvsEnterWarLeftView.as`)
  - `svs.SvsEnterWarLeftView` · SvsEnterWarLeftView x=2
  - `svs.SvsEnterWarLeftView.Bg` · MutipleImage x=-20 y=30
    - `core.describeBackground_style04` · ScaleBitmapImage 
      - `asset.core.describeBackground_style04` · bitmap 78×38 (core2.swf)
  - `svs.SvsEnterWarLeftView.ContentBg` · Scale9CornerImage x=-16 y=33 width=352 height=338 ← `core.describeBackground_style40`
  - `svs.SvsEnterWarLeftView.TitileGap` · MutipleImage x=-16 y=34
    - `asset.svsmap.titleGap` · bitmap 18×28 (svsmap.swf)
    - `asset.svsmap.titleGap` · bitmap 18×28 (svsmap.swf)
  - `svs.SvsEnterWarLeftView.NameTitleTxt` · FilterFrameText x=17 y=42 ← `warlords.WarlordsWinPrizesFrameNameTitleTxt`
  - `svs.SvsEnterWarLeftView.GradesTitleTxt` · FilterFrameText x=155 y=42 ← `warlords.WarlordsWinPrizesFrameNameTitleTxt`
  - `svs.SvsEnterWarLeftView.FightPowerTitleTxt` · FilterFrameText x=225 y=35 width=100 height=36 ← `warlords.WarlordsWinPrizesFrameNameTitleTxt`
  - `svs.SvsEnterWarLeftView.ScrollPanel` · ScrollPanel x=-15 y=72 width=348 height=308
    - `core.VScrollbar01` · Scrollbar width=23 height=200
      - `core.Scrollbar01_Thumb` · BaseButton width=14 height=46
        - `core.Scrollbar01_thumbImg` · ScaleFrameImage width=14 height=46
          - `core.scrollbar01_step1` · ScaleBitmapImage 
          - `core.scrollbar01_step2` · ScaleBitmapImage 
          - `core.scrollbar01_step2` · ScaleBitmapImage 
          - `core.scrollbar01_step1` · ScaleBitmapImage 
      - `core.Scrollbar01_BackImg` · ScaleUpDownImage width=23 height=103
        - `asset.core.scrollbar01_bg1` · bitmap 23×19 (core2.swf)
        - `asset.core.scrollbar01_bg2` · bitmap 24×60 (core2.swf)
        - `asset.core.scrollbar01_bg3` · bitmap 23×24 (core2.swf)
      - `core.Scrollbar01_Up` · BaseButton width=22 height=21
        - `core.Scrollbar01_UpImg` · ScaleFrameImage width=22 height=21
          - `asset.core.scrollbar01_up1` · bitmap 22×21 (core2.swf)
          - `asset.core.scrollbar01_up2` · bitmap 22×21 (core2.swf)
          - `asset.core.scrollbar01_up2` · bitmap 22×21 (core2.swf)
          - `asset.core.scrollbar01_up1` · bitmap 22×21 (core2.swf)
      - `core.Scrollbar01_Down` · BaseButton width=22 height=21
        - `core.Scrollbar01_DownImg` · ScaleFrameImage width=22 height=21
          - `asset.core.scrollbar01_down1` · bitmap 22×21 (core2.swf)
          - `asset.core.scrollbar01_down2` · bitmap 22×21 (core2.swf)
          - `asset.core.scrollbar01_down2` · bitmap 22×21 (core2.swf)
          - `asset.core.scrollbar01_down1` · bitmap 22×21 (core2.swf)
  - `svs.SvsEnterWarLeftView.Vbox` · VBox width=349 height=305
  - `gvg.EnterWarMemberText01` · FilterFrameText x=0 y=0 width=80 height=20 font `Arial,12,0xffffff,,,,,,center`
  - `gvg.EnterWarMemberText02` · FilterFrameText x=70 y=0 width=250 height=20 font `Arial,12,0xffffff,,,,,,left`
  - texts: `svs.view.warteam.SvsEnterWarFrame.TitleTxt01` “Personagem”; `svs.view.warteam.SvsEnterWarFrame.TitleTxt02` “Nível”; `svs.view.warteam.SvsEnterWarFrame.TitleTxt05` “Poder de combate”; `gvg.view.ready.EnterWarFrame.memberNum` “Membros:”
  - subviews: `SvsEnterWarLeftItem`

### svs.view.warteam.SvsEnterWarRightItem

- **SvsEnterWarRightItem** (`core_module:svs/view/warteam/SvsEnterWarRightItem.as`)
  - `svs.EnterWarItemBg` · ScaleFrameImage width=491 height=32
  - `svs.EnterWarOverBg` · ScaleBitmapImage x=-4 y=-4 width=480 ← `core.ItemOver1`
  - `svs.CaptainFlag` · ScaleBitmapImage x=7 y=5 width=22 height=22
    - `asset.core.CaptainIcon` · bitmap 42×43 (core.swf)
  - `core.HeroVocation` · ScaleFrameImage x=-2 y=-2 width=26 height=26
    - `asset.core.SoldierIcon` · bitmap 26×26 (core.swf)
    - `asset.core.PickManIcon` · bitmap 26×26 (core.swf)
    - `asset.croe.WizardIcon` · bitmap 26×26 (core.swf)
  - `svs.EnterWarText01_R` · FilterFrameText x=63 y=6 width=105 height=20 font `Arial,12,0xe4d29c,,,,,,left`
  - `svs.EnterWarText02` · FilterFrameText x=155 y=6 width=70 height=20 font `Arial,14,0xe4d29c,true,,,,,center`
  - `svs.EnterWarText03` · FilterFrameText x=385 y=6 width=70 height=20 font `Arial,12,0xe4d29c,true,,,,,center`
  - `svs.EnterWarText04` · FilterFrameText x=210 y=10 width=90 height=20 font `Arial,10,0xe4d29c,true,,,,,center`
  - `svs.EnterWarText05` · FilterFrameText x=315 y=6 width=70 height=20 font `Arial,12,0xe4d29c,true,,,,,center`
  - `svs.EnterWarDelBtn` · SimpleBitmapButton x=455 y=9
    - `asset.core.deleteBtnImg` · bitmap 
      - `asset.core.deleteBtnImg` · bitmap 18×16 (core2.swf)
  - `svs.VocationIcon` · ScaleFrameImage x=152 y=3 ← `core.VocationIcon`
  - `asset.core.simpleVIPIcon` · bitmap 
    - `asset.core.simpleVIPIcon` · bitmap 18×16 (core2.swf)
  - `svs.EnterWarText01_R.GradientText` · GradientText x=0 y=0 width=105 height=20
    - `svs.EnterWarText01_R.GradientTextField` · FilterFrameText x=63 y=6 width=105 height=20 font `Arial,14,0xffffff,,,,,,left`
  - texts: `steel.view.member.SteelMemberFrame.UserStateTipsTxtNone` “-”; `steel.view.member.SteelMemberFrame.UserStateTipsTxtEnter` “Já entrou na batalha”; `steel.view.member.SteelMemberFrame.UserStateTipsTxtTeam` “Equipe já formada.”
  - subviews: `PlayerMenu`

### svs.view.warteam.SvsEnterWarRightView

- **SvsEnterWarRightView** (`core_module:svs/view/warteam/SvsEnterWarRightView.as`)
  - `svs.SvsEnterWarRightView` · SvsEnterWarRightView x=385
  - `svs.SvsEnterWarRightView.Bg` · MutipleImage x=-20 y=30
    - `core.describeBackground_style04` · ScaleBitmapImage 
      - `asset.core.describeBackground_style04` · bitmap 78×38 (core2.swf)
  - `svs.SvsEnterWarRightView.ContentBg` · Scale9CornerImage x=-16 y=33 width=494 height=338 ← `core.describeBackground_style40`
  - `svs.SvsEnterWarRightView.TitileGap` · MutipleImage x=-16 y=34
    - `asset.svsmap.titleGap` · bitmap 18×28 (svsmap.swf)
    - `asset.svsmap.titleGap` · bitmap 18×28 (svsmap.swf)
    - `asset.svsmap.titleGap` · bitmap 18×28 (svsmap.swf)
    - `asset.svsmap.titleGap` · bitmap 18×28 (svsmap.swf)
  - `svs.SvsEnterWarRightView.NameTitleTxt` · FilterFrameText x=20 y=42 ← `warlords.WarlordsWinPrizesFrameNameTitleTxt`
  - `svs.SvsEnterWarRightView.GradesTitleTxt` · FilterFrameText x=155 y=42 ← `warlords.WarlordsWinPrizesFrameNameTitleTxt`
  - `svs.SvsEnterWarRightView.StateTitleTxt` · FilterFrameText x=210 y=35 width=90 ← `warlords.WarlordsWinPrizesFrameNameTitleTxt`
  - `svs.SvsEnterWarRightView.TeamTitleTxt` · FilterFrameText x=310 y=42 ← `warlords.WarlordsWinPrizesFrameNameTitleTxt`
  - `svs.SvsEnterWarRightView.FightPowerTitleTxt` · FilterFrameText x=370 y=35 width=110 ← `warlords.WarlordsWinPrizesFrameNameTitleTxt`
  - `svs.SvsEnterWarRightView.ScrollPanel` · ScrollPanel x=-15 y=72 width=493 height=308
    - `core.VScrollbar01` · Scrollbar width=23 height=200
      - `core.Scrollbar01_Thumb` · BaseButton width=14 height=46
        - `core.Scrollbar01_thumbImg` · ScaleFrameImage width=14 height=46
          - `core.scrollbar01_step1` · ScaleBitmapImage 
          - `core.scrollbar01_step2` · ScaleBitmapImage 
          - `core.scrollbar01_step2` · ScaleBitmapImage 
          - `core.scrollbar01_step1` · ScaleBitmapImage 
      - `core.Scrollbar01_BackImg` · ScaleUpDownImage width=23 height=103
        - `asset.core.scrollbar01_bg1` · bitmap 23×19 (core2.swf)
        - `asset.core.scrollbar01_bg2` · bitmap 24×60 (core2.swf)
        - `asset.core.scrollbar01_bg3` · bitmap 23×24 (core2.swf)
      - `core.Scrollbar01_Up` · BaseButton width=22 height=21
        - `core.Scrollbar01_UpImg` · ScaleFrameImage width=22 height=21
          - `asset.core.scrollbar01_up1` · bitmap 22×21 (core2.swf)
          - `asset.core.scrollbar01_up2` · bitmap 22×21 (core2.swf)
          - `asset.core.scrollbar01_up2` · bitmap 22×21 (core2.swf)
          - `asset.core.scrollbar01_up1` · bitmap 22×21 (core2.swf)
      - `core.Scrollbar01_Down` · BaseButton width=22 height=21
        - `core.Scrollbar01_DownImg` · ScaleFrameImage width=22 height=21
          - `asset.core.scrollbar01_down1` · bitmap 22×21 (core2.swf)
          - `asset.core.scrollbar01_down2` · bitmap 22×21 (core2.swf)
          - `asset.core.scrollbar01_down2` · bitmap 22×21 (core2.swf)
          - `asset.core.scrollbar01_down1` · bitmap 22×21 (core2.swf)
  - `svs.SvsEnterWarRightView.Vbox` · VBox width=500 height=305
  - `gvg.EnterWarMemberText03` · FilterFrameText x=0 y=0 width=80 height=20 font `Arial,12,0xfdfc04,,,,,,center`
  - `gvg.EnterWarMemberText04` · FilterFrameText x=80 y=0 width=250 height=20 font `Arial,12,0xfdfc04,,,,,,left`
  - texts: `svs.view.warteam.SvsEnterWarFrame.TitleTxt01` “Personagem”; `svs.view.warteam.SvsEnterWarFrame.TitleTxt02` “Nível”; `svs.view.warteam.SvsEnterWarFrame.TitleTxt03` “Estado de batalha”; `svs.view.warteam.SvsEnterWarFrame.TitleTxt04` “Equipe”; `svs.view.warteam.SvsEnterWarFrame.TitleTxt05` “Poder de combate”; `gvg.view.ready.EnterWarFrame.inWar` “Participantes:”
  - subviews: `SvsEnterWarRightItem`

### ui.gameroll.HeroFightingUpdateView

- **HeroFightingUpdateView** (`core_module:ui/gameroll/HeroFightingUpdateView.as`)
  - `core.HeroFightingUpdateView` · HeroFightingUpdateView 
  - `HeroFightingUpdateView.bg` · MutipleImage x=0 y=0
    - `asset.fightingup.bg` · bitmap 261×64 (fightingup.swf)
    - `asset.fightingup.title` · bitmap 147×26 (fightingup.swf)
  - `asset.fightingup.numberImage` · bitmap 
    - `asset.fightingup.numberImage` · bitmap 260×25 (fightingup.swf)

### ui.maintoolbar.MainToolBar

- **MainToolBar** (`core_module:ui/maintoolbar/MainToolBar.as`)
  - `asset.mainToolBar.Back` · bitmap x=17 y=276
    - `asset.mainToolBar.Back` · bitmap 583×43 (maintoolbar.swf)
  - `mainToolBar.PlayerExpView` · PlayerExperenceView x=32 y=310
  - `mainToolBtn.PopTipBtn` · MainToolButton x=801 y=738
  - `mainToolBtn.marryBtn` · MainToolButton x=443 y=100
  - `mainToolBtn.ReturnBtn` · MainToolButton x=550 y=259
  - `mainToolBar.PayBtn` · IconButton x=-54 y=287 width=77 height=33
    - `asset.mainToolBar.PayBtnBack` · bitmap 77×33 (maintoolbar.swf)
    - `asset.mainToolBar.PayBtnTxt` · bitmap 57×19 (maintoolbar.swf)
  - `mainToolBar.recommendBtn` · MovieImage x=294 y=100
    - `asset.mainToolBar.RecommendBtnImg` · sprite 95.0×55.0 20 frames (maintoolbar.swf)
  - `mainToolBar.InviteBtnImg` · MovieImage x=294 y=45
    - `asset.mainToolBar.InviteBtnImg` · sprite 75.0×47.0 20 frames (maintoolbar.swf)
  - `mainToolBar.applyJoinTeam` · MovieImage x=528 y=41
    - `asset.mainToolBar.applyJoinBtnImg` · sprite 87.0×68.0 20 frames (maintoolbar.swf)
  - `mainToolBar.crossGoOnBtn` · MovieButton 
  - `mainToolBar.crossCancelBtn` · MovieButton 
  - `mainToolBar.crossContiner` · Component 
  - `asset.mainToolBar.timeBG` · bitmap x=-50 y=95
    - `asset.mainToolBar.timeBG` · bitmap 218×63 (maintoolbar.swf)
  - `asset.mainToolBar.timeFontBG` · bitmap x=-30 y=105
    - `asset.mainToolBar.timeFontBG` · bitmap 174×32 (maintoolbar.swf)
  - `mainToolBar.timeTxt` · FilterFrameText x=-40 y=124 width=200 height=40 font `Arial,20,0xfff4c2,,,,,,center`
  - `mainToolBar.Warning` · FilterFrameText x=-480 y=250 width=425 height=45 font `Arial,14,0xfff200,,,,,,left`
  - `core.InfoTipsMc` · InfoTipsMc 
  - `DragonTalker.DragonTalkerFrame` · DragonTalkerFrame width=761 height=563 ← `core.Frame1`
  - `army.ArmyFrameII` · ArmyFrameII width=760 height=561
    - `core.FrameTitleText` · FilterFrameText  font `Arial,14,0xFFDD83,true`
    - `core.FrameBg1` · MutipleImage 
      - `core.FrameBackgoundBase1` · Scale9CornerImage 
        - `asset.core.style01_scale9bg1` · bitmap 224×100 (framebg.swf)
        - `asset.core.style01_scale9bg2` · bitmap 50×100 (framebg.swf)
        - `asset.core.style01_scale9bg3` · bitmap 224×100 (framebg.swf)
        - `asset.core.style01_scale9bg4` · bitmap 224×50 (framebg.swf)
        - `asset.core.style01_scale9bg5` · bitmap 50×50 (framebg.swf)
        - `asset.core.style01_scale9bg6` · bitmap 224×50 (framebg.swf)
        - `asset.core.style01_scale9bg7` · bitmap 224×100 (framebg.swf)
        - `asset.core.style01_scale9bg8` · bitmap 50×100 (framebg.swf)
        - `asset.core.style01_scale9bg9` · bitmap 224×100 (framebg.swf)
      - `core.FrameTitleImage1` · Image width=362 height=43
        - `asset.core.frameTitleImage1` · bitmap 243×19 (framebg.swf)
  - `army.PawnFrame` · AllocateFrame width=637 height=380 ← `core.Frame1`
  - `army.SkillFrame` · SkillFrame width=690 height=520 ← `core.Frame1`
  - `armyII.PawnAbilityConvertFrame` · PawnAbilityConvertFrame width=406 height=343 ← `core.Frame2`
  - `consortia.ConsortiaFrame` · ConsortiaFrame width=965 height=633 ← `core.Frame1`
  - `consortia.ConsortiaSearchFrame` · ConsortiaSearchFrame width=844 height=494 ← `core.Frame1`
  - `mounts.MountsFrame` · MountsFrame width=665 height=530 ← `core.Frame1`
  - `pet.PetFrame` · PetFrame width=830 height=560 ← `core.Frame1`
  - `selectCP.SelectCampaignFrame` · SelectCampaignFrame width=960 height=550
    - `core.FrameTitleText` · FilterFrameText  font `Arial,14,0xFFDD83,true`
    - `selectCP.BlackBack` · CustomBitmap x=0 y=0
      - `asset.selectCP.BlackBack` · bitmap 54×38 (selectcampaign.swf)
  - `star.StarFrame` · StarFrame width=638 height=636 ← `core.Frame1`
  - `store.StoreFrame` · StoreFrame width=707 height=481
    - `core.FrameTitleText` · FilterFrameText  font `Arial,14,0xFFDD83,true`
    - `store.StoreFrameBack` · MutipleImage 
      - `core.FrameBg2` · MutipleImage 
        - `core.FrameBackgoundBase2` · Scale9CornerImage 
          - `asset.core.style02_scale9bg1` · bitmap 126×64 (framebg.swf)
          - `asset.core.style02_scale9bg2` · bitmap 38×64 (framebg.swf)
          - `asset.core.style02_scale9bg3` · bitmap 126×64 (framebg.swf)
          - `asset.core.style02_scale9bg4` · bitmap 126×18 (framebg.swf)
          - `asset.core.style02_scale9bg5` · bitmap 38×18 (framebg.swf)
          - `asset.core.style02_scale9bg6` · bitmap 126×18 (framebg.swf)
          - `asset.core.style02_scale9bg7` · bitmap 126×64 (framebg.swf)
          - `asset.core.style02_scale9bg8` · bitmap 38×64 (framebg.swf)
          - `asset.core.style02_scale9bg9` · bitmap 126×64 (framebg.swf)
  - `view.ShopFrame` · ShopFrame width=952 height=612
    - `core.FrameBg1` · MutipleImage 
      - `core.FrameBackgoundBase1` · Scale9CornerImage 
        - `asset.core.style01_scale9bg1` · bitmap 224×100 (framebg.swf)
        - `asset.core.style01_scale9bg2` · bitmap 50×100 (framebg.swf)
        - `asset.core.style01_scale9bg3` · bitmap 224×100 (framebg.swf)
        - `asset.core.style01_scale9bg4` · bitmap 224×50 (framebg.swf)
        - `asset.core.style01_scale9bg5` · bitmap 50×50 (framebg.swf)
        - `asset.core.style01_scale9bg6` · bitmap 224×50 (framebg.swf)
        - `asset.core.style01_scale9bg7` · bitmap 224×100 (framebg.swf)
        - `asset.core.style01_scale9bg8` · bitmap 50×100 (framebg.swf)
        - `asset.core.style01_scale9bg9` · bitmap 224×100 (framebg.swf)
      - `core.FrameTitleImage1` · Image width=362 height=43
        - `asset.core.frameTitleImage1` · bitmap 243×19 (framebg.swf)
    - `core.FrameTitleText` · FilterFrameText  font `Arial,14,0xFFDD83,true`
  - _no style/symbol_: `mainToolBtn.`
  - texts: `consortiagroupchat.msgBoxItemNameTxt` “Chat da Guilda”; `ui.maintoolbar.MainToolBar.proposeTips` “Alguém pediu você em casamento”; `mainBar.MainToolBar.returnBtnTipData` “Voltar”; `mainBar.MainToolBar.hotKey` “Atalho”; `friends.view.FriendsFrame.title` “Social”; `mainTool.mainToolViewTips` “Boicote maus jogos, não jogue jogos pirateados Proteja-se, n”; `mainBar.MainToolBar.command01` “Saia da tela atual”; `public.confirm` “Confirmar”
  - subviews: `AllocateFrame`, `ArmyFrameII`, `SkillFrame`, `PawnAbilityConvertFrame`, `InfoTipsMc`, `ConsortiaSearchFrame`, `ConsortiaFrame`, `DragonTalkerFrame`, `MountsFrame`, `PetFrame`, `SelectCampaignFrame`, `StarFrame`, `StoreFrame`, `MainToolButton`, `PlayerExperenceView`, `ShopFrame`, `MovieButton`

### ui.maintoolbar.view.PlayerExperenceView

- **PlayerExperenceView** (`core_module:ui/maintoolbar/view/PlayerExperenceView.as`)
  - `mainToolBar.PlayerExpView` · PlayerExperenceView x=32 y=310
  - `mainToolBar.PlayerExpProgress` · MovieImage x=2 y=0
    - `asset.mainToolBar.PlayerExpProgress` · sprite 100 frames (maintoolbar.swf)
  - `mainToolBar.PlayerOfflineExpProgress` · MovieImage x=2 y=0
    - `asset.mainToolBar.PlayerOfflineGp` · sprite 100 frames (maintoolbar.swf)
  - `mainToolBar.VocationExpProgress` · MovieImage x=-7 y=0
    - `asset.mainToolBar.VocationExpProgress` · sprite 100 frames (maintoolbar.swf)
  - `mainToolBar.VocationOfflineExpProgress` · MovieImage x=-7 y=0
    - `asset.mainToolBar.VocationOfflineGp` · sprite 100 frames (maintoolbar.swf)
  - `mainToolBar.Grow` · Grow x=1 y=-1
  - `mainToolBar.VocationGrow` · VocationGrow x=-3 y=0
  - texts: `mainBar.PlayerExperenceView.msg2` “{0}({1}%) \nExperiência abundante restante {2} (Exp Offline)”; `mainBar.PlayerExperenceView.msg` “Nível máximo atingido”
  - subviews: `SimpleMovie`

### ui.queuebar.QueueBar

- **QueueBar** (`core_module:ui/queuebar/QueueBar.as`)
  - `queueBar.VipCoolDownFrame` · VipCoolDownFrame width=310 height=195 ← `core.QuickBuyFrame`
  - `queueBar.VipCoolDownFrame` · VipCoolDownFrame width=310 height=195 ← `core.QuickBuyFrame`
  - `queueBar.VipCoolDownFrame` · VipCoolDownFrame width=310 height=195 ← `core.QuickBuyFrame`
  - `queueBar.Back` · ScaleBitmapImage y=14 width=322 height=131
    - `asset.core.QueueBack` · bitmap 211×30 (core.swf)
  - `queueBar.Vbox` · VBox x=0 y=-27
  - `asset.queueBar.tipsImg` · bitmap x=40 y=147
    - `asset.queueBar.tipsImg` · bitmap 215×23 (queuebar.swf)
  - `queueBar.expBackBtn` · BaseButton x=40 y=180
    - `asset.queueBar.expBackBtn` · bitmap 76×79 (queuebar.swf)
  - `queueBar.heroRoadBtn` · BaseButton x=115 y=180
    - `asset.queueBar.heroRoadBtn` · bitmap 65×50 (queuebar.swf)
  - `queueBar.upgradePresentBtn` · BaseButton x=210 y=203
    - `asset.queueBar.upgradePresentBtn` · bitmap 59×56 (queuebar.swf)
  - `queueBar.ScrollPanel` · ScrollPanel x=0 y=15 width=300 height=128
    - `queueBar.VScrollbar04` · Scrollbar width=23 height=200
      - `core.Scrollbar04_BackV` · ScaleBitmapImage width=15 height=24
        - `asset.core.scrollbar04_bgV` · bitmap 15×24 (core2.swf)
      - `core.Scrollbar04_StepV` · BaseButton width=16 height=36
        - `core.scrollbar04_stepAssetV` · ScaleBitmapImage width=16 height=36
          - `asset.core.scrollbar04_stepV` · bitmap 14×46 (core2.swf)
      - `core.Scrollbar04_Up` · BaseButton width=11 height=10
        - `asset.core.scrollbar04_up` · bitmap 11×10 (core2.swf)
      - `core.Scrollbar04_Down` · BaseButton width=11 height=10
        - `asset.core.scrollbar04_down` · bitmap 11×10 (core2.swf)
  - `core.InfoTipsMc` · InfoTipsMc 
  - `queueBar.heroRoadBtn2` · BaseButton x=120 y=190
    - `asset.queueBar.heroRoadBtn2` · bitmap 77×65 (queuebar.swf)
  - `queueBar.popBtn` · BaseButton x=90 y=235
    - `asset.queueBar.popBtn` · bitmap 81×81 (queuebar.swf)
  - `queueBar.countTime` · TimeDownView x=102 y=288
    - `queueBar.countTime.text` · FilterFrameText width=80 height=20 font `Arial,12,0xff0000,,,,,,left`
  - texts: `mopup.MopupManager.mopupTipData01` “Modo Bot em andamento”; `yishi.SwitchPageHelp.movePrompt` “Em campanha, não é possível transferir”; `dayGuide.DayGuideManager.command02` “Nível baixo, função habilitada no Nv. {0}”; `managers.ChildManager.pickChildTips` “Você ainda não contém nenhum guardião”; `outyard.OutyardFrame.noConsortia` “Favor participar primeiro de uma guilda”; `public.confirm` “Confirmar”; `public.cancel` “Cancelar”; `public.prompt` “Aviso”
  - subviews: `InfoTipsMc`, `VipCoolDownFrame`, `QueueItem`, `TimeDownView`

### ui.queuebar.view.QueueItem

- **QueueItem** (`core_module:ui/queuebar/view/QueueItem.as`)
  - `taskTrace.ItemBack1` · Scale9CornerImage y=-7 width=245 height=36
    - `asset.taskTrace.ItemBack1` · bitmap 24×17 (tasktracebar.swf)
    - `asset.taskTrace.ItemBack2` · bitmap 16×17 (tasktracebar.swf)
    - `asset.taskTrace.ItemBack3` · bitmap 28×17 (tasktracebar.swf)
    - `asset.taskTrace.ItemBack4` · bitmap 24×3 (tasktracebar.swf)
    - `asset.taskTrace.ItemBack5` · bitmap 16×3 (tasktracebar.swf)
    - `asset.taskTrace.ItemBack6` · bitmap 28×3 (tasktracebar.swf)
    - `asset.taskTrace.ItemBack7` · bitmap 24×18 (tasktracebar.swf)
    - `asset.taskTrace.ItemBack8` · bitmap 16×18 (tasktracebar.swf)
    - `asset.taskTrace.ItemBack9` · bitmap 28×18 (tasktracebar.swf)
  - `queueBar.StartBtn` · BaseButton x=190 y=4
    - `asset.queueBar.startBtnImg` · bitmap 21×16 (petchallenge.swf)
  - `queueBar.TitText` · FilterFrameText x=5 y=7 width=300 height=22 font `Arial,12,0x00aeef,,,,,,left`
  - `queueBar.TimeText` · FilterFrameText x=138 width=66 ← `queueBar.TitText`
  - `queueBar.GetRewardText` · FilterFrameText x=180 y=2 width=50 height=20 font `Arial,12,0xf8fe02,,,true,,,left`
  - `queueBar.ItemMc` · TaskRewardButtonMc1 x=-63 y=5
  - `queueBar.VipCoolDownFrame` · VipCoolDownFrame width=310 height=195 ← `core.QuickBuyFrame`
  - texts: `mainBar.view.QueueItem.QuickText` “Acelerar resfriamento (VIP gratuito)”; `ui.queuebar.view.QueueItem.getReward.text1` “Coletar prêmio”; `public.confirm` “Confirmar”; `public.cancel` “Cancelar”; `mainBar.SeminaryFrameRightView.prompt` “Confirmar resfriamento”; `mainBar.SeminaryFrameRightView.content` “Resfriamento precisa consumir {0}”; `mainBar.view.QueueItem.QUEUE_TYPE_CONSORTIA_ALTAR` “Bênção da Guilda {0}/{1}”; `mainBar.view.QueueItem.QUEUE_TYPE_OFFER_REWARD` “Recompensa {0}/{1}”
  - subviews: `TaskRewardButtonMc1`, `VipCoolDownFrame`

### ui.resourcebar.ResourcesBar

- **ResourcesBar** (`core_module:ui/resourcebar/ResourcesBar.as`)
  - `resoueceBar.ResourcesBar` · ResourcesBar x=-5 y=-3
  - `resourceBar.ResourceExtraView` · ResourceExtraView x=14 y=124
  - `resourceBar.IndulgeView` · IndulgeView x=331 y=10
  - `asset.resourcesBar.FigureCover` · bitmap x=10 y=66
    - `asset.resourcesBar.FigureCover` · bitmap 27×27 (resourcesbar.swf)
  - `resourceBar.figureCoverStrip` · StripView 
  - `resourceBar.PetFigureView` · PetFigureView x=5 y=60
  - `resourceBar.ChildrenFigureView` · ChildrenFigureView x=113 y=120
  - `resourceBar.ChildrenFigureViewII` · ChildrenFigureView x=205 y=120
  - `resourceBar.GoldenSheepView` · GoldenSheepView x=290 y=330
  - `resoueceBar.ResourcesBar` · ResourcesBar x=-5 y=-3
  - texts: `armyII.SkillFrame.AlertMsg` “Nv.{0} activado”
  - subviews: `StripView`, `ChildrenFigureView`, `GoldenSheepView`, `IndulgeView`, `PetFigureView`, `ResourceExtraView`, `ResourceView`, `StrengthBar`

### ui.resourcebar.view.ChildrenExperenceView

- **ChildrenExperenceView** (`core_module:ui/resourcebar/view/ChildrenExperenceView.as`)
  - `resourceBar.ChildrenExperenceView` · ChildrenExperenceView x=50 y=31
  - `asset.resourcesBar.PetExpProgressBg` · bitmap x=0
    - `asset.resourcesBar.PetExpProgressBg` · bitmap 85×6 (resourcesbar.swf)
  - `resourcesBar.ChildrenExpProgress` · ScaleFrameImage x=0 y=0
    - `asset.resourcesBar.ChildrenExpProgress1` · bitmap 85×5 (resourcesbar.swf)
    - `asset.resourcesBar.ChildrenExpProgress2` · bitmap 85×5 (resourcesbar.swf)
    - `asset.resourcesBar.ChildrenExpProgress3` · bitmap 85×5 (resourcesbar.swf)

### ui.resourcebar.view.ChildrenFigureView

- **ChildrenFigureView** (`core_module:ui/resourcebar/view/ChildrenFigureView.as`)
  - `resourceBar.ChildrenFigureView` · ChildrenFigureView x=113 y=120
  - `asset.resourcesBar.ChildFigureBack` · bitmap 91×55 (resourcesbar.swf)
  - `resoueceBar.ChildrenIcon` · BaseIconView x=7 y=3
  - `resoueceBar.ChildrenIcon2` · BaseIconView x=51 y=22
  - `resourceBar.ChildrenIconStrip` · StripView 
  - `resourceBar.ChildrenIconStrip2` · StripView 
  - `resourceBar.noChildStrip` · StripView 
  - `resourceBar.figureCoverStrip` · StripView 
  - `ChildrenFigureView.childAlertImage` · Image x=9 y=5
    - `asset.ChildrenFigureView.childAlertImage` · bitmap 42×42 (resourcesbar.swf)
  - `ChildrenFigureView.petAlertImage` · Image x=42 y=-44
    - `asset.resourcesBar.FigureCover` · bitmap x=10 y=66
      - `asset.resourcesBar.FigureCover` · bitmap 27×27 (resourcesbar.swf)
  - `resourceBar.childAlertStrip` · StripView 
  - `resourceBar.petAlertStrip` · StripView 
  - texts: `resourcebar.view.PetFigureView.noPet` “Você ainda não tem Einherjar”; `resourcebar.view.PetFigureView.clickOpen` “Clique para selecionar Einherjar”; `resourcebar.view.ChildrenFigureView.noSelectChild` “Clique para selecionar Guardião para batalhar”; `resourcebar.view.ChildrenFigureView.noChild1` “Você ainda não tem Guardião”; `resourcebar.view.ChildrenFigureView.noChild2` “Você ainda não possui Guardião despertado”; `resourcebar.view.ChildrenFigureView.clickOpen` “Clique para selecionar Einherjar para batalhar”; `armyII.SkillFrame.AlertMsg` “Nv.{0} activado”; `resourcebar.view.PetFigureView.noChangeChild` “Você não tem guardiões para trocar”
  - subviews: `StripView`, `ChildrenSortList`, `PetSortList`, `BaseIconView`

### ui.resourcebar.view.ChildrenSortItem

- **ChildrenSortItem** (`core_module:ui/resourcebar/view/ChildrenSortItem.as`)
  - `resourcesBar.ItemOver` · ScaleBitmapImage x=-2 y=2 width=153 height=34
    - `asset.resourcesBar.ItemOver` · bitmap 
      - `asset.resourcesBar.ItemOver` · bitmap 84×19 (resourcesbar.swf)
  - `resoueceBar.PetIcon` · BaseIconView x=2 y=3
  - `resourcesBar.PetItemName` · FilterFrameText x=34 y=10 width=75 height=35 font `Arial,12,0xffffff,,,,,,center`
  - `resourcesBar.PetItemGrade` · FilterFrameText x=82 y=10 width=66 height=22 font `Arial,12,0xdeb65a,,,,,,right`
  - `resourceBar.ChildrenIconStrip` · StripView 
  - texts: `public.level2` “Nv.{0}”
  - subviews: `StripView`, `BaseIconView`

### ui.resourcebar.view.ChildrenSortList

- **ChildrenSortList** (`core_module:ui/resourcebar/view/ChildrenSortList.as`)
  - `core.commonTipBg` · ScaleBitmapImage width=435
    - `asset.core.describeBackground_style07` · bitmap 260×82 (core2.swf)
  - `resourcesBar.PetVBox` · VBox x=5 y=5
  - `resourcesBar.PetSortList.PrePageBtn` · BaseButton x=135 y=215
    - `asset.resourcesBar.FigureUpBtn` · bitmap 11×7 (resourcesbar.swf)
  - `resourcesBar.PetSortList.NextPageBtn` · BaseButton x=135 y=225
    - `asset.resourcesBar.FigureDownBtn` · bitmap 11×7 (resourcesbar.swf)
  - subviews: `ChildrenSortItem`

### ui.resourcebar.view.GoldOvertopView

- **GoldOvertopView** (`core_module:ui/resourcebar/view/GoldOvertopView.as`)
  - `asset.resourcesBar.GoldOvertop` · bitmap height=50
    - `asset.resourcesBar.GoldOvertop` · bitmap 165×37 (resourcesbar.swf)
  - `goldOvertop.goldOvertopFrameTxt` · FilterFrameText x=18 y=10 width=140 height=45 font `Arial,14,0xff0004,,,,,,center`
  - `goldOvertop.CloseBtn` · BaseButton x=152 y=-2
    - `asset.core.closeBtn_style02` · bitmap 26×26 (core2.swf)
  - texts: `mainBar.view.GoldOvertopView.goldOvertop` “Capacidade máxima de ouro atingida!”

### ui.resourcebar.view.GoldenSheepView

- **GoldenSheepView** (`core_module:ui/resourcebar/view/GoldenSheepView.as`)
  - `resourceBar.GoldenSheepView` · GoldenSheepView x=290 y=330
  - `GoldenSheepView.btn` · BaseButton x=0 y=0
    - `asset.resourceBar.GoldenSheepBtn` · bitmap 53×59 (resourcesbar.swf)

### ui.resourcebar.view.IndulgeView

- **IndulgeView** (`core_module:ui/resourcebar/view/IndulgeView.as`)
  - `resourceBar.IndulgeView` · IndulgeView x=331 y=10
  - `resoueceBar.IndulgeView.Back` · ScaleBitmapImage x=0 y=0 width=120 height=40 ← `core.describeBackground_style04`
  - `resoueceBar.IndulgeView.Icons` · ScaleFrameImage x=8 y=5
    - `asset.resourceBar.IndulgeView.Icon1` · bitmap x=0 y=0
      - `asset.resourceBar.IndulgeView.Icon1` · bitmap 14×14 (resourcesbar.swf)
    - `asset.resourceBar.IndulgeView.Icon2` · bitmap x=0 y=0
      - `asset.resourceBar.IndulgeView.Icon2` · bitmap 14×14 (resourcesbar.swf)
    - `asset.resourceBar.IndulgeView.Icon3` · bitmap x=0 y=0
      - `asset.resourceBar.IndulgeView.Icon3` · bitmap 14×14 (resourcesbar.swf)
  - `resoueceBar.IndulgeView.Describe` · FilterFrameText x=28 y=2 width=88 height=20 font `Arial,12,0xffea89,,,,,,left`
  - `resoueceBar.IndulgeView.TimeTxt` · FilterFrameText x=26 y=19 width=90 height=20 font `Arial,12,0xffea89,,,,,,left`
  - `resoueceBar.IndulgeInfoFrame` · IndulgeInfoFrame width=442 height=205 ← `core.Frame2`
  - texts: `mainBar.view.IndulgeView.tip` “\nRecomenda-se o preenchimento rápido das informações anti-v”; `mainBar.view.IndulgeView.describe` “Contagem anti-vício:”; `mainBar.view.IndulgeView.time01` “Você entrou em estado não saudável de jogo. Para garantir su”; `mainBar.view.IndulgeView.time02` “Seu tempo online acumulou 3 horas, saia do jogo e descanse o”; `mainBar.view.IndulgeView.time03` “Voce entrou em estado de cansaço, o seu ganho foi reduzido p”; `mainBar.view.IndulgeView.time04` “Seu tempo online acumulou {0} horas.”; `mainBar.view.IndulgeView.tip01` “Seu tempo online acumulou {0} horas. Você não obterá nenhum ”; `mainBar.view.IndulgeView.tip02` “\nSeu tempo online acumulou {0} horas. Seu ganho foi reduzid”
  - subviews: `IndulgeInfoFrame`

### ui.resourcebar.view.PetExperenceView

- **PetExperenceView** (`core_module:ui/resourcebar/view/PetExperenceView.as`)
  - `resourceBar.PetExperenceView` · PetExperenceView x=50 y=31
  - `asset.resourcesBar.PetExpProgressBg` · bitmap x=0
    - `asset.resourcesBar.PetExpProgressBg` · bitmap 85×6 (resourcesbar.swf)
  - `asset.resourcesBar.PetExpProgress` · bitmap x=0
    - `asset.resourcesBar.PetExpProgress` · bitmap 85×5 (resourcesbar.swf)
  - texts: `ui.resourcebar.view.PetFigureView.PetExpTxt` “Exp. Einherjar {0}”; `mainBar.PlayerExperenceView.msg` “Nível máximo atingido”

### ui.resourcebar.view.PetFigureView

- **PetFigureView** (`core_module:ui/resourcebar/view/PetFigureView.as`)
  - `gloryroad.PetFigureView` · PetFigureView x=40 y=655
  - `asset.resourcesBar.PetFigureBack` · bitmap x=0
    - `asset.resourcesBar.PetFigureBack` · bitmap 41×41 (resourcesbar.swf)
  - `resoueceBar.PetIcon` · BaseIconView x=2 y=3
  - `resourceBar.PetIconStrip` · StripView 
  - `resourceBar.figureCoverStrip` · StripView 
  - texts: `resourcebar.view.PetFigureView.noPet` “Você ainda não tem Einherjar”; `resourcebar.view.PetFigureView.clickOpen` “Clique para selecionar Einherjar”; `resourcebar.view.PetFigureView.noChangePet` “Você não tem einherjar para trocar”
  - subviews: `StripView`, `PetSortList`, `BaseIconView`

### ui.resourcebar.view.PetSortItem

- **PetSortItem** (`core_module:ui/resourcebar/view/PetSortItem.as`)
  - `resourcesBar.ItemOver` · ScaleBitmapImage x=-2 y=2 width=153 height=34
    - `asset.resourcesBar.ItemOver` · bitmap 
      - `asset.resourcesBar.ItemOver` · bitmap 84×19 (resourcesbar.swf)
  - `resoueceBar.PetIcon` · BaseIconView x=2 y=3
  - `resourcesBar.PetItemName` · FilterFrameText x=34 y=10 width=75 height=35 font `Arial,12,0xffffff,,,,,,center`
  - `resourcesBar.PetItemGrade` · FilterFrameText x=82 y=10 width=66 height=22 font `Arial,12,0xdeb65a,,,,,,right`
  - `resourceBar.PetIconStrip` · StripView 
  - `resourceBar.StateFlag` · ScaleFrameImage x=2 y=2
    - `asset.resourcesBar.EnterWarImg` · bitmap 37×32 (resourcesbar.swf)
    - `asset.resourcesBar.EnterChildImg` · bitmap 37×32 (resourcesbar.swf)
  - `asset.PetSortItem.hallowsFlag` · bitmap x=20 y=0
    - `asset.PetSortItem.hallowsFlag` · bitmap 20×22 (resourcesbar.swf)
  - texts: `public.level2` “Nv.{0}”
  - subviews: `StripView`, `BaseIconView`

### ui.resourcebar.view.PetSortList

- **PetSortList** (`core_module:ui/resourcebar/view/PetSortList.as`)
  - `core.commonTipBg` · ScaleBitmapImage width=435
    - `asset.core.describeBackground_style07` · bitmap 260×82 (core2.swf)
  - `resourcesBar.PetVBox` · VBox x=5 y=5
  - `resourcesBar.PetSortList.PrePageBtn` · BaseButton x=135 y=215
    - `asset.resourcesBar.FigureUpBtn` · bitmap 11×7 (resourcesbar.swf)
  - `resourcesBar.PetSortList.NextPageBtn` · BaseButton x=135 y=225
    - `asset.resourcesBar.FigureDownBtn` · bitmap 11×7 (resourcesbar.swf)
  - subviews: `PetSortItem`

### ui.resourcebar.view.ResourceExtraView

- **ResourceExtraView** (`core_module:ui/resourcebar/view/ResourceExtraView.as`)
  - `resourceBar.ResourceExtraView` · ResourceExtraView x=14 y=124
  - `resourceBar.ExtraTotalbox` · HBox 
  - `resourceBar.ArmyBtn` · BaseButton x=0 y=0
    - `asset.resourceBar.ArmyBtn` · bitmap 38×38 (resourcesbar.swf)
  - `resourceBar.ArmyBtn` · BaseButton x=0 y=0
    - `asset.resourceBar.ArmyBtn` · bitmap 38×38 (resourcesbar.swf)
  - `resourcesBar.kingBtnMc` · TaskRewardButtonMc1 x=0 y=0
  - `core.PVPArmyManageFrame` · PVPArmyManageFrame width=489 height=273 ← `core.Frame2`
  - `core.ArmyManageFrame` · ArmyManageFrame width=478 height=281 ← `core.Frame2`
  - `core.FreedomTeamManageFrame` · FreedomTeamManageFrame width=478 height=281 ← `core.Frame2`
  - `resourceBar.KingBtn` · TextButton x=0 y=0 width=36 height=41
    - `asset.resourceBar.ExtraBufferIcon_4` · bitmap 38×38 (resourcesbar.swf)
    - `resourceBar.KingBtnTxt` · FilterFrameText  font `Arial,12,0xe4e4e4`
  - texts: `map.campaign.view.frame.ArmyManageFrame.title` “Gerenciamento da Equipe”; `yishi.view.resourceBar.ExtraBufferTitle4` “Contrato dos Elfos”; `public.clickopen` “Habilitar”
  - subviews: `TaskRewardButtonMc1`, `ArmyManageFrame`, `PVPArmyManageFrame`, `FreedomTeamManageFrame`

### ui.resourcebar.view.ResourceView

- **ResourceView** (`core_module:ui/resourcebar/view/ResourceView.as`)
  - `resourcesBar.Back1` · Image x=8 y=0
    - `asset.resourcesBar.Back1` · bitmap 313×122 (resourcesbar.swf)
  - `resoueceBar.PlayerIcon` · BaseIconView x=0 y=-3
  - `asset.resourceBar.ResourceView.MaskAsset1` · bitmap 
    - `asset.resourceBar.ResourceView.MaskAsset1` · bitmap 120×120 (resourcesbar.swf)
  - `resourcesBar.LevelText` · FilterFrameText x=78 y=98 width=26 height=20 font `arial,14,0xF6E79F,true,,,,,center`
  - `resourcesBar.NickNameText` · FilterFrameText x=135 y=17 width=110 height=20 font `Arial,14,0xffde00,,,,,,center`
  - `asset.resourcesBar.GoldIconAsset` · bitmap x=5 y=3
    - `asset.resourcesBar.GoldIconAsset` · bitmap 16×17 (resourcesbar.swf)
  - `asset.resourcesBar.VoucherIconAsset` · bitmap x=5 y=2
    - `asset.resourcesBar.VoucherIconAsset` · bitmap 18×18 (resourcesbar.swf)
  - `asset.resourcesBar.GiftIconAsset` · bitmap x=5 y=3
    - `asset.resourcesBar.GiftIconAsset` · bitmap 20×17 (resourcesbar.swf)
  - `resourcesBar.GoldTxt` · FilterFrameText x=20 y=2 width=60 height=20 font `Arial,15,0xE9D0A4,,,,,,left`
  - `resourcesBar.GiftTxt` · FilterFrameText x=24 y=2 font `Arial,15,0xE9D0A4,,,,,,left` ← `resourcesBar.VoucherTxt`
  - `resourcesBar.VoucherTxt` · FilterFrameText x=22 y=2 width=55 height=20 font `Arial,15,0xE9D0A4,,,,,,left`
  - `resoueceBar.GoldView` · StripView x=110 y=41
    - `resoueceBar.MultipleDictionaryTip` · MultipleDictionaryTip 
      - `mulitieTip.leftText` · FilterFrameText  font `Arial,12,0xfab634,,,,,,left`
      - `mulitieTip.rightText` · FilterFrameText  font `Arial,12,0xffffff,,,,,,left`
  - `resourceBar.VoucherItem` · StripView x=190 y=41
  - `resourceBar.GIftItem` · StripView x=270 y=41
  - `secrearytary.icon` · BaseButton x=295 y=60
    - `asset.secrearytary.icon` · bitmap x=0 y=0
      - `asset.secrearytary.icon` · bitmap 42×42 (resourcesbar.swf)
  - `resourceBar.HPExperenceView` · HPExperenceView x=105 y=65
  - `resourceBar.CountExperenceView` · CountExperenceView x=92 y=85
  - `resourceBar.PowerExperenceView` · PowerExperenceView x=20 y=79
    - `resourceBar.PowerTip` · MultipleLineTip 
  - `resoueceBar.ResourceView.normalVipBtn` · IconButton x=248 y=14
    - `asset.resourceBar.ResourceView.NormalVipBtnAsset` · bitmap 68×25 (resourcesbar.swf)
  - `resoueceBar.ResourceView.getVipBtn` · IconButton x=228 y=14 width=103 height=26
    - `asset.resourceBar.ResourceView.GetVipBtnAsset` · bitmap 69×26 (resourcesbar.swf)
    - `asset.resourceBar.ResourceView.GetVipBtnTxt` · bitmap 93×17 (resourcesbar.swf)
  - `resourcesBar.JobChangeBtn` · ScaleFrameImage x=260 y=84
    - `asset.resourcesBar.JobChangeBtn1` · bitmap 39×39 (resourcesbar.swf)
    - `asset.resourcesBar.JobChangeBtn2` · bitmap 39×39 (resourcesbar.swf)
    - `asset.resourcesBar.JobChangeBtn3` · bitmap 39×39 (resourcesbar.swf)
    - `asset.resourcesBar.JobChangeBtn4` · bitmap 39×39 (resourcesbar.swf)
  - `asset.core.number_img_02` · bitmap 
    - `asset.core.number_img_02` · bitmap 165×27 (core.swf)
  - `smallMap.FullScreenMC` · MovieButton x=90 y=5
  - `resourcesBar.VocationIconBtn` · ScaleFrameImage x=126 y=16 ← `core.VocationIcon`
    - `resourcesBar.VocationIconBtnsTip` · MultipleLineTip 
  - `resourceBar.GoldEffect` · MovieImage x=94 y=67
    - `asset.resourcesBar.ResourceUpdateEffect` · sprite 25 frames (resourcesbar.swf)
  - `resourcesBar.QuickBuyFrame` · QuickBuyFrame width=249 height=393 ← `core.Frame2`
  - `core.CloseBtn` · BaseButton 
    - `asset.core.closeBtn_style01` · bitmap 29×29 (core2.swf)
  - `core.LevelupViewII` · LevelUpViewII 
  - texts: `mainBar.view.ResourceView.hpExpTipData` “Sangue”; `mainBar.view.ResourceView.countExpTipData` “Infantaria”; `mainBar.view.ResourceView.componetPower` “Limite de 200, o sistema irá recuperar os pontos todos os di”; `mainBar.view.ResourceView.getVipBtnTip` “Clique para ativar VIP”; `mainBar.SmallMapBar.FullScreenBtnTip` “Tela Cheia (Caso encontrar problemas com a tela cheia, favor”; `mainBar.view.ResourceView.JobChangeBtnClickTips` “Clicar para trocar de profissão”; `army.Equip.VocationIcon.holyTip` “\nAumentar o nível do título pode elevar o nível da Classe C”; `army.Equip.VocationIcon.avengerTip` “\nElevando o nome da profissão pode elevar o nível dos Olhos”
  - subviews: `StripView`, `CountExperenceView`, `HPExperenceView`, `PowerExperenceView`, `GoldOvertopView`, `QuickBuyFrame`, `BaseIconView`, `LevelUpViewII`, `MovieButton`

### ui.resourcebar.view.StrengthBar

- **StrengthBar** (`core_module:ui/resourcebar/view/StrengthBar.as`)
  - `asset.resourcesBar.strengthBg` · bitmap 51×17 (resourcesbar.swf)
  - `asset.resourcesBar.strengthNum` · bitmap 130×17 (resourcesbar.swf)

### ui.resourcebar.view.quickbuy.BloodItem

- **BloodItem** (`core_module:ui/resourcebar/view/quickbuy/BloodItem.as`)
  - `asset.resourceBar.QuickBuyItemBg` · bitmap 
    - `asset.resourceBar.QuickBuyItemBg` · bitmap 184×80 (resourcesbar.swf)
  - `asset.resourceBar.QuickBuyMouseOver` · bitmap 
    - `asset.resourceBar.QuickBuyMouseOver` · bitmap 188×82 (resourcesbar.swf)
  - `resourceBar.BloodTxt` · FilterFrameText x=70 y=8 width=112 height=40 font `Arial,14,0xffba00,,,,,,left`
  - `resourceBar.BloodGoldTxt` · FilterFrameText x=78 y=47 width=66 height=18 font `arial,14,0xddcda0,,,,,,right`
  - `resourcesBar.BloodGoldIcon` · ScaleFrameImage x=143 y=43
    - `asset.resourcesBar.GoldIcoImg` · bitmap 
      - `asset.resourcesBar.GoldIcoImg` · bitmap 26×29 (resourcesbar.swf)
    - `asset.resourcesBar.DimondIcoImg` · bitmap 
      - `asset.resourcesBar.DimondIcoImg` · bitmap 26×29 (resourcesbar.swf)
  - `resourcesBar.BaseItemView1` · BaseItemView x=8 y=10
    - `resourcesBar.bloodItemCellBg` · ScaleBitmapImage 
      - `core.shop.goodsItemBack1` · bitmap 
        - `core.shop.goodsItemBack1` · bitmap 62×62 (core.swf)
    - `resourcesBar.BaseItemView1Icon` · BaseIconView x=3 y=3
      - `asset.core.IconLoading` · sprite 42 frames (core2.swf)
    - `resourcesBar.GoodsProfileBG` · ScaleFrameImage  x=2 y=4 ← `core.GoodsProfileBG`
  - subviews: `BaseItemView`

### ui.resourcebar.view.quickbuy.QuickBuyFrame

- **QuickBuyFrame**: “Compra rápida” (`core_module:ui/resourcebar/view/quickbuy/QuickBuyFrame.as`)
  - `resourcesBar.QuickBuyFrame` · QuickBuyFrame width=249 height=393 ← `core.Frame2`
  - `resourcesBar.QuickBuyFrameBg` · ScaleBitmapImage x=-13 y=3 width=202 height=252 ← `core.describeBackground_style04`
  - `resourcesBar.confirmBtn` · IconButton x=38 y=259
    - `asset.core.ConfirmButton` · bitmap 101×38 (core2.swf)
    - `asset.resourceBar.QuickBuyconfirmTxt` · bitmap 83×18 (resourcesbar.swf)
  - texts: `mainBar.view.quickbuy.QuickBuyFrame.title` “Compra rápida”; `star.view.MakeStarView.command02` “Ouro insuficiente”; `shop.view.frame.BuyFrameI.MazeCoinLack` “Moeda do labirinto insuficiente”; `shop.view.frame.BuyFrameI.MedalLack` “Medalha insuficiente”; `shop.view.frame.BuyFrameI.SociatyContribLack` “Contribuição insuficiente”; `ui.resourcebar.view.quickbuy.QuickBuyFrame.chaosTip` “Pedra do caos insuficiente”; `ui.resourcebar.view.quickbuy.QuickBuyFrame.eternalCrystalTip` “Cristais da vênus atual insuficientes”; `shop.view.frame.BuyFrameI.NotEnoughBackPlayer` “No momento não possui Cupom de herói suficientes”
  - subviews: `VBox`, `BloodItem`

### ui.tasktracebar.TaskTraceBar

- **TaskTraceBar** (`core_module:ui/tasktracebar/TaskTraceBar.as`)
  - `taskTrace.SelfHelpButtonView` · SelfHelpButtonView x=210 y=5
  - `taskTrace.HigherGradeOpenTipView` · HigherGradeOpenTipView x=185 y=15
  - `taskTrace.SpaceMapButtonView` · SpaceMapButtonView x=240 y=245
  - `core.InfoTipsMc` · InfoTipsMc 
  - subviews: `InfoTipsMc`, `HigherGradeOpenTipView`, `NewbieTaskTraceView`, `SelfHelpButtonView`, `SpaceMapButtonView`, `TaskTraceView`

### ui.tasktracebar.view.ChildRemoveAlert

- **ChildRemoveAlert**: “Abandonar Guardião” (`core_module:ui/tasktracebar/view/ChildRemoveAlert.as`)
  - `core.childRemoveAlert` · ChildRemoveAlert width=300 height=280
    - `core.FrameTitleText` · FilterFrameText  font `Arial,14,0xFFDD83,true`
    - `core.quickBuyFrameBg` · MutipleImage 
      - `core.AlertFrameBg` · MutipleImage 
        - `core.AlertFrameBaseBg` · Scale9CornerImage 
          - `asset.core.framestyle03_scale9bg1` · bitmap 42×42 (framebg.swf)
          - `asset.core.framestyle03_scale9bg2` · bitmap 42×42 (framebg.swf)
          - `asset.core.framestyle03_scale9bg3` · bitmap 42×42 (framebg.swf)
          - `asset.core.framestyle03_scale9bg4` · bitmap 42×18 (framebg.swf)
          - `asset.core.framestyle03_scale9bg5` · bitmap 42×18 (framebg.swf)
          - `asset.core.framestyle03_scale9bg6` · bitmap 42×18 (framebg.swf)
          - `asset.core.framestyle03_scale9bg7` · bitmap 42×42 (framebg.swf)
          - `asset.core.framestyle03_scale9bg8` · bitmap 42×42 (framebg.swf)
          - `asset.core.framestyle03_scale9bg9` · bitmap 42×42 (framebg.swf)
      - `core.FrameTitleImage2` · Image width=229 height=17
        - `asset.core.frameTitleImage2` · bitmap 229×17 (framebg.swf)
  - `ChildRemoveAlert.content` · FilterFrameText x=11 y=8 width=250 font `Arial,12,0xef9c00,true`
  - `asset.taskTrace.ItemTitleIcon1` · bitmap 
    - `asset.taskTrace.ItemTitleIcon1` · bitmap 16×15 (tasktracebar.swf)
  - `ChildRemoveAlert.text1` · FilterFrameText x=2 y=44 width=290 font `Arial,12,0xef9c00,true`
  - `asset.taskTrace.ItemTitleIcon1` · bitmap 
    - `asset.taskTrace.ItemTitleIcon1` · bitmap 16×15 (tasktracebar.swf)
  - `ChildRemoveAlert.text2` · FilterFrameText x=2 y=68 width=290 font `Arial,12,0xef9c00,true`
  - `ChildRemoveAlert.text3` · FilterFrameText x=62 y=101 width=120 font `Arial,12,0xef9c00,true`
  - `ChildRemoveAlert.text4` · FilterFrameText x=66 y=133 width=115 height=24 font `Arial,14,0xfed205,,,,,,center`
  - `ChildRemoveAlert.ConfirmSellInputBack` · ScaleBitmapImage x=70 y=188 width=126 height=23
    - `asset.core.ConfirmSellInputBack` · bitmap 46×23 (core2.swf)
  - `ChildRemoveAlert.sureButton` · IconButton x=1 y=163 ← `core.AlertButtonConfirm_2`
  - `ChildRemoveAlert.cancelButton` · IconButton x=174 y=163
    - `core.AlertButtonCancel_1` · IconButton  ← `core.AlertButtonConfirm_1`
      - `asset.core.CancelTxtAsset_01` · bitmap 75×18 (core2.swf)
  - texts: `ui.tasktracebar.view.ChildRemoveAlert.content` “Deseja abandonar [{0}], após abandonar:”; `ui.tasktracebar.view.ChildRemoveAlert.text01` “Este Guardião irá desaparecer da lista dos Guardiões permane”; `ui.tasktracebar.view.ChildRemoveAlert.text02` “Não pode recuperar os atributos, habilidades e equipamento d”; `ui.tasktracebar.view.ChildRemoveAlert.text03` “Favor inserir [YES]  em baixo para confirmar.”; `ui.tasktracebar.view.ChildRemoveAlert.title` “Abandonar Guardião”; `ui.tasktracebar.view.ChildRemoveAlert.text04` “Insira Yes para confirmar”

### ui.tasktracebar.view.HigherGradeOpenTipView

- **HigherGradeOpenTipView** (`core_module:ui/tasktracebar/view/HigherGradeOpenTipView.as`)
  - `taskTrace.HigherGradeOpenTipView` · HigherGradeOpenTipView x=185 y=15
  - `tasktracebar.HigherGradeOpenTipBg` · ScaleUpDownImage y=-10 width=270 height=95
    - `asset.tasktracebar.BgStyle01_U` · bitmap 212×9 (tasktracebar.swf)
    - `asset.tasktracebar.BgStyle01_M` · bitmap 212×2 (tasktracebar.swf)
    - `asset.tasktracebar.BgStyle01_D` · bitmap 212×9 (tasktracebar.swf)
  - `tasktracebar.HigherGradeOpenTipIcon` · BaseIconView x=3 y=8
    - `asset.core.IconLoading` · sprite 42 frames (core2.swf)
  - `tasktracebar.HigherGradeOpenTipＯpenContentTxt` · GradientText x=42 y=1 ← `core.NpcName_VipText`
    - `tasktracebar.HigherGradeOpenTipＯpenContentTextField` · FilterFrameText width=230 height=40 font `Arial,12,0xffffff`
  - `tasktracebar.HigherGradeOpenTipＯpenDescTxt` · FilterFrameText x=42 y=18 width=230 height=70 font `Arial,12,0xd2c997`
  - texts: `HigherGradeOpenTipView.openGrade` “Habilitado Nv. {0}”
  - subviews: `BaseIconView`

### ui.tasktracebar.view.NewbieTaskTraceView

- **NewbieTaskTraceView** (`core_module:ui/tasktracebar/view/NewbieTaskTraceView.as`)
  - `asset.taskTrace.NewbieBg` · bitmap 390×202 (tasktracebar.swf)
  - `taskTrace.TaskItemVbox` · VBox x=0 y=0
  - `taskTrace.ScrollPanel` · ScrollPanel x=-63 y=27 width=250 height=200
    - `core.VScrollbar04` · Scrollbar width=23 height=200
      - `core.Scrollbar04_BackV` · ScaleBitmapImage width=15 height=24
        - `asset.core.scrollbar04_bgV` · bitmap 15×24 (core2.swf)
      - `core.Scrollbar04_StepV` · BaseButton width=16 height=36
        - `core.scrollbar04_stepAssetV` · ScaleBitmapImage width=16 height=36
          - `asset.core.scrollbar04_stepV` · bitmap 14×46 (core2.swf)
      - `core.Scrollbar04_Up` · BaseButton width=11 height=10
        - `asset.core.scrollbar04_up` · bitmap 11×10 (core2.swf)
      - `core.Scrollbar04_Down` · BaseButton width=11 height=10
        - `asset.core.scrollbar04_down` · bitmap 11×10 (core2.swf)
  - `tasktracebar.NewbieContinueBtn` · TextButton x=140 y=150 width=140 height=30
    - `asset.taskTrace.BtnBg01` · bitmap 114×31 (tasktracebar.swf)
    - `tasktracebar.NewbieContinueTxt` · FilterFrameText width=110 height=20 font `Arial,14,0xffffff,true,,,,,center`
  - `tasktracebar.NewbieTitleTxt` · FilterFrameText x=110 y=27 width=200 height=20 font `Arial,14,0xffffff,true,,,,,center`
  - `tasktracebar.NewbieArrow` · NewbieArrow x=130 y=178
  - `ui.tasktracebar.view.TaskTraceItem` · TaskTraceItem 
  - texts: `ui.tasktracebar.view.NewbieTaskTraceView.title` “Caminho do Avanço”; `yishi.utils.MaskUtils.arrowTipFindPath` “Clique para encontrar caminho”; `ui.tasktracebar.view.NewbieTaskTraceView.finishTask` “Concluir missão”; `ui.tasktracebar.view.NewbieTaskTraceView.continueTask` “Continuar missão”
  - subviews: `TaskTraceItem`

### ui.tasktracebar.view.SelfHelpButtonView

- **SelfHelpButtonView** (`core_module:ui/tasktracebar/view/SelfHelpButtonView.as`)
  - `taskTrace.SelfHelpButtonView` · SelfHelpButtonView x=210 y=5
  - `tasktracebar.SelfHelpButton` · BaseButton x=150 y=-5 ← `core.CloseBtn`
    - `asset.tasktracebar.SelfHelpAsset` · bitmap 40×23 (tasktracebar.swf)
  - `tasktracebar.FullScreenButton` · BaseButton x=165 y=-5 ← `core.CloseBtn`
    - `asset.tasktracebar.FullScreenAsset` · sprite 27.0×23.0 (tasktracebar.swf)
  - `tasktracebar.QuitFullScreenButton` · BaseButton x=165 y=-5 ← `core.CloseBtn`
    - `asset.tasktracebar.QuitFullScreenAsset` · sprite 27.0×23.0 (tasktracebar.swf)
  - `tasktracebar.shieldBtn` · BaseButton x=10 y=-7 ← `core.CloseBtn`
    - `asset.tasktracebar.ShieldBtnImg` · sprite 135.0×27.0 (tasktracebar.swf)
  - `tasktracebar.cancelShieldBtn` · BaseButton x=10 y=-7 ← `core.CloseBtn`
    - `asset.tasktracebar.CancelShieldBtnImg` · sprite 135.0×27.0 (tasktracebar.swf)
  - texts: `ui.tasktracebar.view.SelfHelpButtonView.BtnTip` “Se encotrar anormalidades no local clique em Ajuda”; `ui.tasktracebar.view.SelfHelpButtonView.FullScreenBtnTip` “O maior”; `ui.tasktracebar.view.SelfHelpButtonView.QuitFullScreenBtnTip` “Move para baixo para recuperar”; `mainBar.SmallMapBar.OthersHideBtnTipData` “Ocultar Jogadores”; `mainBar.SmallMapBar.OthersShowBtnTipData` “Mostrar Jogadores”; `ui.tasktracebar.view.SelfHelpButtonView.TipTxt` “Recuperação sucedida”; `setting.SettingFrame.fullScreenBtn.Tips` “O Dispositivo de Login não suporta tela cheia.”

### ui.tasktracebar.view.SpaceMapButtonView

- **SpaceMapButtonView** (`core_module:ui/tasktracebar/view/SpaceMapButtonView.as`)
  - `taskTrace.SpaceMapButtonView` · SpaceMapButtonView x=240 y=245
  - `tasktracebar.SpaceMapButtonView.MapBtn` · IconButton width=174 height=27
    - `asset.core.MapBtnAsset` · bitmap 174×27 (core.swf)
    - `asset.core.MapBtnTxt` · bitmap 70×25 (core.swf)
  - texts: `mainBar.MainToolBar.hotKey` “Atalho”

### ui.tasktracebar.view.TaskTraceItem

- **TaskTraceItem** (`core_module:ui/tasktracebar/view/TaskTraceItem.as`)
  - `ui.tasktracebar.view.TaskTraceItem` · TaskTraceItem 
  - `taskTrace.ItemBack1` · Scale9CornerImage y=-7 width=245 height=36
    - `asset.taskTrace.ItemBack1` · bitmap 24×17 (tasktracebar.swf)
    - `asset.taskTrace.ItemBack2` · bitmap 16×17 (tasktracebar.swf)
    - `asset.taskTrace.ItemBack3` · bitmap 28×17 (tasktracebar.swf)
    - `asset.taskTrace.ItemBack4` · bitmap 24×3 (tasktracebar.swf)
    - `asset.taskTrace.ItemBack5` · bitmap 16×3 (tasktracebar.swf)
    - `asset.taskTrace.ItemBack6` · bitmap 28×3 (tasktracebar.swf)
    - `asset.taskTrace.ItemBack7` · bitmap 24×18 (tasktracebar.swf)
    - `asset.taskTrace.ItemBack8` · bitmap 16×18 (tasktracebar.swf)
    - `asset.taskTrace.ItemBack9` · bitmap 28×18 (tasktracebar.swf)
  - `taskTrace.ItemTitleIcon` · ScaleFrameImage x=5 y=4
    - `asset.taskTrace.ItemTitleIcon1` · bitmap 
      - `asset.taskTrace.ItemTitleIcon1` · bitmap 16×15 (tasktracebar.swf)
    - `asset.taskTrace.ItemTitleIcon2` · bitmap 
      - `asset.taskTrace.ItemTitleIcon2` · bitmap 16×15 (tasktracebar.swf)
  - `taskTrace.ItemTitleTxt` · FilterFrameText x=18 y=1 width=135 height=20 font `Arial,12,0xfffde9,,,,,,left`
  - `taskTrace.TargetVbox` · VBox x=0 y=0
  - `taskTrace.ringNum` · FilterFrameText width=100 height=18 font `Arial,12,0x00fffc,,,,,,left`
  - `taskTrace.taskTypeBtn` · TextButton x=155 y=3 width=85 height=16
    - `taskTrace.taskTypeBtn.back` · ScaleFrameImage 
      - `asset.taskTrace.mainBack` · bitmap 31×15 (tasktracebar.swf)
      - `asset.taskTrace.commonBack` · bitmap 31×15 (tasktracebar.swf)
      - `asset.taskTrace.offerBack` · bitmap 31×15 (tasktracebar.swf)
      - `asset.taskTrace.ringBack` · bitmap 31×15 (tasktracebar.swf)
    - `taskTrace.taskTypeBtn.text` · FilterFrameText width=85 height=18 font `Arial,12,0xa8f3f2,,,,,,center`
  - `taskTrace.taskTypeBtn` · TextButton x=155 y=3 width=85 height=16
    - `taskTrace.taskTypeBtn.back` · ScaleFrameImage 
      - `asset.taskTrace.mainBack` · bitmap 31×15 (tasktracebar.swf)
      - `asset.taskTrace.commonBack` · bitmap 31×15 (tasktracebar.swf)
      - `asset.taskTrace.offerBack` · bitmap 31×15 (tasktracebar.swf)
      - `asset.taskTrace.ringBack` · bitmap 31×15 (tasktracebar.swf)
    - `taskTrace.taskTypeBtn.text` · FilterFrameText width=85 height=18 font `Arial,12,0xa8f3f2,,,,,,center`
  - `taskTrace.quickBtn` · TextButton x=184 y=18 width=55 height=24
    - `asset.core.quickBtnBack` · bitmap 68×24 (core2.swf)
    - `taskTrace.quickBtn.text` · FilterFrameText width=65 height=18 font `Arial,12,0xeeefac,,,,,,center`
  - `taskTrace.taskTypeBtn` · TextButton x=155 y=3 width=85 height=16
    - `taskTrace.taskTypeBtn.back` · ScaleFrameImage 
      - `asset.taskTrace.mainBack` · bitmap 31×15 (tasktracebar.swf)
      - `asset.taskTrace.commonBack` · bitmap 31×15 (tasktracebar.swf)
      - `asset.taskTrace.offerBack` · bitmap 31×15 (tasktracebar.swf)
      - `asset.taskTrace.ringBack` · bitmap 31×15 (tasktracebar.swf)
    - `taskTrace.taskTypeBtn.text` · FilterFrameText width=85 height=18 font `Arial,12,0xa8f3f2,,,,,,center`
  - `taskTrace.quickBtn` · TextButton x=184 y=18 width=55 height=24
    - `asset.core.quickBtnBack` · bitmap 68×24 (core2.swf)
    - `taskTrace.quickBtn.text` · FilterFrameText width=65 height=18 font `Arial,12,0xeeefac,,,,,,center`
  - `task.RiverNotAlert` · TodayNotAlertFrame width=440 height=235 ← `core.TodayNotAlertFrame`
    - `task.RiverNotAlert_confirmStyle` · SelectedCheckButton x=90 y=125 ← `core.AlertConfirmBtn_2`
    - `task.RiverNotAlert_cancelStyle` · SelectedCheckButton x=225 y=125 ← `core.AlertButton_2`
    - `task.RiverNotAlertCheckBtn` · SelectedCheckButton x=20 y=80 ← `core.ThewCheckBtn`
    - `task.AlertTextStyle` · FilterFrameText x=0 y=0 width=420 height=88 font `arial,14,0xe7c88b,,,,,,center`
    - `core.FrameTitleText` · FilterFrameText  font `Arial,14,0xFFDD83,true`
    - `task.AlertTextStyle` · FilterFrameText x=0 y=0 width=420 height=88 font `arial,14,0xe7c88b,,,,,,center`
    - `core.quickBuyFrameBg` · MutipleImage 
      - `core.AlertFrameBg` · MutipleImage 
        - `core.AlertFrameBaseBg` · Scale9CornerImage 
          - `asset.core.framestyle03_scale9bg1` · bitmap 42×42 (framebg.swf)
          - `asset.core.framestyle03_scale9bg2` · bitmap 42×42 (framebg.swf)
          - `asset.core.framestyle03_scale9bg3` · bitmap 42×42 (framebg.swf)
          - `asset.core.framestyle03_scale9bg4` · bitmap 42×18 (framebg.swf)
          - `asset.core.framestyle03_scale9bg5` · bitmap 42×18 (framebg.swf)
          - `asset.core.framestyle03_scale9bg6` · bitmap 42×18 (framebg.swf)
          - `asset.core.framestyle03_scale9bg7` · bitmap 42×42 (framebg.swf)
          - `asset.core.framestyle03_scale9bg8` · bitmap 42×42 (framebg.swf)
          - `asset.core.framestyle03_scale9bg9` · bitmap 42×42 (framebg.swf)
      - `core.FrameTitleImage2` · Image width=229 height=17
        - `asset.core.frameTitleImage2` · bitmap 229×17 (framebg.swf)
    - `task.UseBindPointBtn` · SelectedCheckButton x=35 y=95 ← `core.ThewCheckBtn`
    - `task.notJoinActPromptTxt` · FilterFrameText x=25 y=75 width=160 height=20 font `Arial,12,0xff0000,,,,,,left`
  - `offerreward.view.OfferTaskItem.showKingContractTip` · TodayNotAlertFrame width=250 height=190 ← `core.TodayNotAlertFrame`
    - `offerreward.view.confirmStyle` · SelectedCheckButton x=15 y=81 ← `worldboss.RiverNotAlert_confirmStyle`
    - `offerreward.view.cancelStyle` · SelectedCheckButton x=140 y=81 ← `worldboss.RiverNotAlert_cancelStyle`
    - `offerreward.NotAlertCheckBtn` · SelectedCheckButton x=62 y=60 ← `core.ThewCheckBtn`
    - `offer.KingContractStyle` · FilterFrameText x=-11 y=0 width=275 height=100 font `arial,14,0xe7c88b,,,,,,center`
    - `core.FrameTitleText` · FilterFrameText  font `Arial,14,0xFFDD83,true`
    - `offer.KingContractStyle` · FilterFrameText x=-11 y=0 width=275 height=100 font `arial,14,0xe7c88b,,,,,,center`
    - `core.quickBuyFrameBg` · MutipleImage 
      - `core.AlertFrameBg` · MutipleImage 
        - `core.AlertFrameBaseBg` · Scale9CornerImage 
          - `asset.core.framestyle03_scale9bg1` · bitmap 42×42 (framebg.swf)
          - `asset.core.framestyle03_scale9bg2` · bitmap 42×42 (framebg.swf)
          - `asset.core.framestyle03_scale9bg3` · bitmap 42×42 (framebg.swf)
          - `asset.core.framestyle03_scale9bg4` · bitmap 42×18 (framebg.swf)
          - `asset.core.framestyle03_scale9bg5` · bitmap 42×18 (framebg.swf)
          - `asset.core.framestyle03_scale9bg6` · bitmap 42×18 (framebg.swf)
          - `asset.core.framestyle03_scale9bg7` · bitmap 42×42 (framebg.swf)
          - `asset.core.framestyle03_scale9bg8` · bitmap 42×42 (framebg.swf)
          - `asset.core.framestyle03_scale9bg9` · bitmap 42×42 (framebg.swf)
      - `core.FrameTitleImage2` · Image width=229 height=17
        - `asset.core.frameTitleImage2` · bitmap 229×17 (framebg.swf)
  - texts: `buildings.offerreward.data.BaseOfferReward.progress` “(Concluído)”; `YiShi.mainBar.view.TaskTraceItem.HandInText` “(Entregar)”; `mopup.MopupManager.mopupTipData01` “Modo Bot em andamento”; `ui.tasktracebar.view.TaskTraceItem.taskcontent` “Ir ao Reino dos Céus receber missão da Asuna”; `ui.tasktracebar.view.TaskTraceItem.mainLine` “Principal”; `ui.tasktracebar.view.TaskTraceItem.Daily` “Diário”; `ui.tasktracebar.view.TaskTraceItem.Reward` “Recompensa”; `ui.tasktracebar.view.TaskTraceItem.CompletedImmediately` “Concluir”
  - subviews: `TraceTaskTargetItem`, `TodayNotAlertFrame`

### ui.tasktracebar.view.TaskTraceView

- **TaskTraceView** (`core_module:ui/tasktracebar/view/TaskTraceView.as`)
  - `taskTraceView.titleComponent` · Component 
  - `taskTraceView.titleBack` · ScaleBitmapImage x=-55 y=-1 width=240 height=31
    - `asset.taskTraceView.titleBack` · bitmap 110×31 (tasktracebar.swf)
  - `asset.taskTrace.Title` · bitmap x=-13 y=7
    - `asset.taskTrace.Title` · bitmap 145×15 (tasktracebar.swf)
  - `taskTrace.TaskBtn` · MovieButton x=-54 y=2
  - `taskTrace.HideBtn` · BaseButton x=184 y=5
    - `asset.core.HideBtnIcon` · bitmap 21×17 (core.swf)
  - `taskTrace.TaskItemVbox` · VBox x=0 y=0
  - `taskTrace.ScrollPanel` · ScrollPanel x=-63 y=27 width=250 height=200
    - `core.VScrollbar04` · Scrollbar width=23 height=200
      - `core.Scrollbar04_BackV` · ScaleBitmapImage width=15 height=24
        - `asset.core.scrollbar04_bgV` · bitmap 15×24 (core2.swf)
      - `core.Scrollbar04_StepV` · BaseButton width=16 height=36
        - `core.scrollbar04_stepAssetV` · ScaleBitmapImage width=16 height=36
          - `asset.core.scrollbar04_stepV` · bitmap 14×46 (core2.swf)
      - `core.Scrollbar04_Up` · BaseButton width=11 height=10
        - `asset.core.scrollbar04_up` · bitmap 11×10 (core2.swf)
      - `core.Scrollbar04_Down` · BaseButton width=11 height=10
        - `asset.core.scrollbar04_down` · bitmap 11×10 (core2.swf)
  - `taskTrace.TotalTxt` · FilterFrameText x=-65 y=3 width=30 height=18 font `Arial,11,0xffffff,,,,,,center`
  - `asset.taskTrace.TotalImage` · bitmap x=-64 y=-2
    - `asset.taskTrace.TotalImage` · bitmap 28×28 (tasktracebar.swf)
  - `ui.tasktracebar.view.TaskTraceItem` · TaskTraceItem 
  - texts: `mainBar.view.TaskTraceView.taskBtn` “Missão (Atalho: L)”; `yishi.utils.MaskUtils.arrowTipFindPath` “Clique para encontrar caminho”; `mopup.MopupManager.mopupTipData01` “Modo Bot em andamento”; `yishi.utils.MaskUtils.arrowTipNextStep` “Clique para Continuar Missão”
  - subviews: `TaskTraceItem`, `MovieButton`, `NoviceArrowView`

### ui.tasktracebar.view.TraceTaskTargetItem

- **TraceTaskTargetItem** (`core_module:ui/tasktracebar/view/TraceTaskTargetItem.as`)
  - `taskTrace.ItemDescribeTxt` · FilterFrameText width=170 font `Arial,12,0xfff200,,,true,,,left`
  - `taskTrace.ItemProgressTxt_t` · TextFormat 

### ui.tasktracebar.view.TransferAnimationView

- **TransferAnimationView** (`core_module:ui/tasktracebar/view/TransferAnimationView.as`)
  - `tasktracebar.TransferAnimationView` · TransferAnimationView 
  - `taskTracebar.Dragonback` · Dragonback 
  - `taskTracebar.Fire` · Fire width=170 height=230

### ui.toptoolbar.TopBtnItemView

- **TopBtnItemView** (`core_module:ui/toptoolbar/TopBtnItemView.as`)
  - `toptoolbar.topBtn` · MovieButton 
  - `toptoolbar.topBtn.stateText` · FilterFrameText x=8 y=12 width=65 height=29 font `Arial,12,0x1de722,,,,,,center`
  - _no style/symbol_: `asset.toptoolbar.topIcon_`
  - texts: `toptoolbar.topBtn.matelords.stateText0` “Ativado”; `braveleg.Tip.sign` “Já se inscreveu”; `toptoolbar.topBtn.matelords.stateText2` “Inscrição inscrever”; `toptoolbar.topBtn.childArena.stateGuessText` “Poderá apostar”; `toptoolbar.topBtn.apex.stateText1_1` “Inscrito”; `toptoolbar.topBtn.apex.stateText1_add` “\n({0}/4)”; `toptoolbar.topBtn.tipData` “Abertura:”; `ChildArenaSignFrame.signText1.text` “Inscrição:{0}-{1}”
  - subviews: `MovieButton`

### ui.toptoolbar.TopToolsBar

- **TopToolsBar** (`core_module:ui/toptoolbar/TopToolsBar.as`)
  - `toptoolbar.TargetSelectView` · TargetSelectView x=-10 y=60
  - `toptoolbar.bufferBack` · Scale9CornerImage x=-5 y=3 width=190 height=53 ← `core.describeBackground_style36`
  - `toptoolbar.bufferHideBtn` · SelectedButton x=168 y=13 width=16 height=15
    - `asset.toptoolbar.bufferHideImage` · bitmap 16×15 (toptoolbar.swf)
    - `toptoolbar.bufferHideImage.scaleY` · Image y=15
      - `asset.toptoolbar.bufferHideImage` · bitmap 16×15 (toptoolbar.swf)
  - `toptoolbar.Container2` · SimpleTileList y=8
  - `onlinereward.timeText` · FilterFrameText x=9 y=65 width=63 height=18 font `Arial,12,0x00eef7,true,,,,,center`
  - `onlinereward.timeText` · FilterFrameText x=9 y=65 width=63 height=18 font `Arial,12,0x00eef7,true,,,,,center`
  - `toptoolbar.condenseBtn` · BaseButton 
    - `toptoolbar.condenseBtnBack` · Image 
      - `asset.toptoolbar.condense` · bitmap 56×23 (toptoolbar.swf)
  - `toptoolbar.extrudeBtn` · BaseButton y=7
    - `toptoolbar.extrudeBtn.back` · Image y=17
      - `asset.toptoolbar.condense` · bitmap 56×23 (toptoolbar.swf)
  - `toptoolbar.preBtn` · BaseButton 
    - `toptoolbar.preBtnBack` · ScaleFrameImage 
      - `asset.toptoolbar.preBtnBack.moveOut` · bitmap 23×23 (toptoolbar.swf)
      - `asset.toptoolbar.preBtnBack.moveOver` · bitmap 23×23 (toptoolbar.swf)
      - `asset.toptoolbar.preBtnBack.moveOut` · bitmap 23×23 (toptoolbar.swf)
      - `asset.toptoolbar.preBtnBack.moveOut` · bitmap 23×23 (toptoolbar.swf)
  - `toptoolbar.nextBtn` · BaseButton 
    - `toptoolbar.nextBtnBack` · ScaleFrameImage 
      - `toptoolbar.nextBtnBack.moveOut` · Image 
        - `asset.toptoolbar.preBtnBack.moveOut` · bitmap 23×23 (toptoolbar.swf)
      - `toptoolbar.nextBtnBack.moveOver` · Image 
        - `asset.toptoolbar.preBtnBack.moveOver` · bitmap 23×23 (toptoolbar.swf)
      - `toptoolbar.nextBtnBack.moveOut` · Image 
        - `asset.toptoolbar.preBtnBack.moveOut` · bitmap 23×23 (toptoolbar.swf)
      - `toptoolbar.nextBtnBack.moveOut` · Image 
        - `asset.toptoolbar.preBtnBack.moveOut` · bitmap 23×23 (toptoolbar.swf)
  - `toptoolbar.pageHbox` · HBox 
  - `resourcesBar.BaseItemView` · BaseIconView 
  - `asset.resourcesBar.ForbidIcon` · bitmap x=10 y=9
    - `asset.resourcesBar.ForbidIcon` · bitmap 20×21 (resourcesbar.swf)
  - `toptoolbar.Container1` · SimpleTileList 
  - `toptoolbar.pageImage` · ScaleFrameImage 
    - `asset.toptoolbar.selectPageImage` · bitmap 14×14 (toptoolbar.swf)
    - `asset.toptoolbar.unselectPageImage` · bitmap 14×14 (toptoolbar.swf)
  - `core.InfoTipsMc` · InfoTipsMc 
  - texts: `tasktracetip.view.HookTipView.text2` “Coleta sucedida”; `tasktracetip.view.HookTipView.text1` “Coletar”; `tasktracetip.view.VipGiftGetTipView.BtnTxt` “Coletar Agora”; `toptoolbar.topBtn.tipData` “Abertura:”; `toptoolbar.topBtn.tipData.darkmaze1` “Faltam {0}h para a próxima atualização! Meia hora antes da a”; `toptoolbar.topBtn.tipData.darkmaze2` “Faltam {0}m para a próxima atualização! Meia hora antes da a”; `mainBar.TopToolsBar.dayGuideBtn.underLevel` “Nível menor que 6, não é possível abrir o Guia Diário”; `mainBar.TopToolsBar.rechargeBtn.click01` “Durante o evento, você já recarregou”
  - subviews: `InfoTipsMc`, `ForbidConsortiaView`, `PlayerBufferItem`, `TopBtnItemView`, `ExtraBufferItem`, `TargetSelectView`, `TopBtnActiveBoxView`, `BaseIconView`

### ui.toptoolbar.view.ExtraBufferItem

- **ExtraBufferItem** (`core_module:ui/toptoolbar/view/ExtraBufferItem.as`)
  - `resourceBar.ExtraBuffer.ItemIcon` · BaseIconView 
  - `asset.resourceBar.BufferBorder` · bitmap 
    - `asset.resourceBar.BufferBorder` · bitmap 30×30 (resourcesbar.swf)
  - `resourceBar.buffer.Effect` · Effect 
  - _no style/symbol_: `asset.resourceBar.ExtraBufferIcon_`
  - texts: `public.confirm` “Confirmar”; `public.cancel` “Cancelar”; `public.prompt` “Aviso”; `mainBar.TopToolsBar.TransportCancelTip` “Cancelar modo de transporte”; `yishi.view.resourceBar.ExtraBufferContent6` “Aumenta experiência obtida em {0}%”; `yishi.view.resourceBar.ExtraBufferContent11` “Durante o Evento, Einherjar de nv.1~54, a velocidade do desp”; `yishi.view.resourceBar.ExtraBufferContent30` “Durante a batalha de proteção de Einherjar, o efeito de redu”; `yishi.view.resourceBar.ExtraBufferContent40008` “Horário de abrir: {0} \nHorário de fechar: {1}”
  - subviews: `BaseIconView`

### ui.toptoolbar.view.TargetSelectView

- **TargetSelectView** (`core_module:ui/toptoolbar/view/TargetSelectView.as`)
  - `toptoolbar.TargetSelectView` · TargetSelectView x=-10 y=60
  - `asset.toptoolbar.TargetSelectBack` · bitmap y=8
    - `asset.toptoolbar.TargetSelectBack` · bitmap 166×71 (toptoolbar.swf)
  - `toptoolbar.TargetIcon` · BaseIconView x=0 y=0
  - `asset.toptoolbar.TargetSelectMask` · bitmap 
    - `asset.toptoolbar.TargetSelectMask` · bitmap 70×70 (toptoolbar.swf)
  - `toptoolbar.LevelText` · FilterFrameText x=51 y=54 width=26 height=20 font `Arial,12,0xf6e80f,true,,,,,center`
  - `toptoolbar.NickNameText` · FilterFrameText x=60 y=30 width=110 height=20 font `Arial,14,0xffde00,,,,,,center`
  - `toptoolbar.OperateBtn` · IconButton x=95 y=55
    - `asset.toptoolbar.TargetSelectOpBtnTxt` · bitmap 31×17 (toptoolbar.swf)
  - `core.ChestOKBtn` · BaseButton 
    - `asset.core.chest.ConfirmBtn` · bitmap 162×52 (core2.swf)
  - `toptoolbar.targetSelectBar.VocationIconBtn` · ScaleFrameImage x=70 y=26 ← `core.VocationIcon`
  - subviews: `ChatItemMenu`, `BaseIconView`

### ui.toptoolbar.view.TimeActiveBoxView

- **TimeActiveBoxView** (`core_module:ui/toptoolbar/view/TimeActiveBoxView.as`)
  - `TimeActiveBoxView.back` · ScaleBitmapImage x=0 y=0 width=300 height=150 ← `core.describeBackground_style047`
  - `TimeActiveBoxView.SimpleTileList` · SimpleTileList x=5 y=5
  - `toptoolbar.topBtn` · MovieButton 
  - `toptoolbar.topBtn.stateText` · FilterFrameText x=8 y=12 width=65 height=29 font `Arial,12,0x1de722,,,,,,center`
  - _no style/symbol_: `asset.toptoolbar.topIcon_`
  - texts: `toptoolbar.topBtn.tipData.alert` “Esta função é aberta no nv.{0}”; `TimeActiveBoxView.notInRightScene.alert` “No cenário atual, não é possível participar deste evento.”; `consortia.data.ConsortiaDemonInfo.overTip` “O Evento ainda não começou.”; `consortia.data.ConsortiaDemonInfo.unopenTip` “Evento ainda não foi aberto, não é possível entrar”; `toptoolbar.topBtn.tipData` “Abertura:”
  - subviews: `MovieButton`

### ui.toptoolbar.view.TopBtnActiveBoxView

- **TopBtnActiveBoxView** (`core_module:ui/toptoolbar/view/TopBtnActiveBoxView.as`)
  - `TimeActiveBoxView.back` · ScaleBitmapImage x=0 y=0 width=300 height=150 ← `core.describeBackground_style047`
  - `topBtn.ActiveBoxView.SimpleTileList` · SimpleTileList x=5 y=5

### yishi.lunch.Yishi

- **Yishi** (`core_module:yishi/lunch/Yishi.as`)
  - `mainToolBar.BroadCastFrame` · UpdateBroadCastFrame width=651 height=560 ← `core.Frame1`
  - subviews: `CacheTipFrame`, `UpdateBroadCastFrame`

### yishi.utils.IconAlertHelper

- **IconAlertHelper** (`core_module:yishi/utils/IconAlertHelper.as`)
  - `IconAlert` · Frame width=315 height=192 ← `core.Frame2`
    - `core.quickBuyFrameBg` · MutipleImage 
      - `core.AlertFrameBg` · MutipleImage 
        - `core.AlertFrameBaseBg` · Scale9CornerImage 
          - `asset.core.framestyle03_scale9bg1` · bitmap 42×42 (framebg.swf)
          - `asset.core.framestyle03_scale9bg2` · bitmap 42×42 (framebg.swf)
          - `asset.core.framestyle03_scale9bg3` · bitmap 42×42 (framebg.swf)
          - `asset.core.framestyle03_scale9bg4` · bitmap 42×18 (framebg.swf)
          - `asset.core.framestyle03_scale9bg5` · bitmap 42×18 (framebg.swf)
          - `asset.core.framestyle03_scale9bg6` · bitmap 42×18 (framebg.swf)
          - `asset.core.framestyle03_scale9bg7` · bitmap 42×42 (framebg.swf)
          - `asset.core.framestyle03_scale9bg8` · bitmap 42×42 (framebg.swf)
          - `asset.core.framestyle03_scale9bg9` · bitmap 42×42 (framebg.swf)
      - `core.FrameTitleImage2` · Image width=229 height=17
        - `asset.core.frameTitleImage2` · bitmap 229×17 (framebg.swf)
  - `IconAlertContentText` · FilterFrameText  font `Arial,14,0xffefbd,,,,,,center`
  - `core.AlertConfirmBtn_2` · SelectedCheckButton  ← `core.AlertButton`
    - `core.AlertConfirmButtonImage_2` · ScaleFrameImage 
      - `core.AlertButtonConfirm_2` · IconButton  ← `core.AlertButtonConfirm_1`
        - `asset.core.AlertBtnStyle_02` · bitmap 96×40 (core2.swf)
      - `core.AlertButtonConfirm_2` · IconButton  ← `core.AlertButtonConfirm_1`
        - `asset.core.AlertBtnStyle_02` · bitmap 96×40 (core2.swf)
      - `core.AlertButtonConfirm_2` · IconButton  ← `core.AlertButtonConfirm_1`
        - `asset.core.AlertBtnStyle_02` · bitmap 96×40 (core2.swf)
      - `core.AlertButtonConfirm_2` · IconButton  ← `core.AlertButtonConfirm_1`
        - `asset.core.AlertBtnStyle_02` · bitmap 96×40 (core2.swf)
    - `core.AlertConfirmButtonImage_2` · ScaleFrameImage 
      - `core.AlertButtonConfirm_2` · IconButton  ← `core.AlertButtonConfirm_1`
        - `asset.core.AlertBtnStyle_02` · bitmap 96×40 (core2.swf)
      - `core.AlertButtonConfirm_2` · IconButton  ← `core.AlertButtonConfirm_1`
        - `asset.core.AlertBtnStyle_02` · bitmap 96×40 (core2.swf)
      - `core.AlertButtonConfirm_2` · IconButton  ← `core.AlertButtonConfirm_1`
        - `asset.core.AlertBtnStyle_02` · bitmap 96×40 (core2.swf)
      - `core.AlertButtonConfirm_2` · IconButton  ← `core.AlertButtonConfirm_1`
        - `asset.core.AlertBtnStyle_02` · bitmap 96×40 (core2.swf)
  - `core.AlertButton_2` · SelectedCheckButton width=97 height=33
    - `core.AlertButtonImage_2` · ScaleFrameImage 
      - `core.AlertButtonCancel_1` · IconButton  ← `core.AlertButtonConfirm_1`
        - `asset.core.CancelTxtAsset_01` · bitmap 75×18 (core2.swf)
      - `core.AlertButtonCancel_1` · IconButton  ← `core.AlertButtonConfirm_1`
        - `asset.core.CancelTxtAsset_01` · bitmap 75×18 (core2.swf)
      - `core.AlertButtonCancel_1` · IconButton  ← `core.AlertButtonConfirm_1`
        - `asset.core.CancelTxtAsset_01` · bitmap 75×18 (core2.swf)
      - `core.AlertButtonCancel_1` · IconButton  ← `core.AlertButtonConfirm_1`
        - `asset.core.CancelTxtAsset_01` · bitmap 75×18 (core2.swf)
    - `core.AlertButtonImage_2` · ScaleFrameImage 
      - `core.AlertButtonCancel_1` · IconButton  ← `core.AlertButtonConfirm_1`
        - `asset.core.CancelTxtAsset_01` · bitmap 75×18 (core2.swf)
      - `core.AlertButtonCancel_1` · IconButton  ← `core.AlertButtonConfirm_1`
        - `asset.core.CancelTxtAsset_01` · bitmap 75×18 (core2.swf)
      - `core.AlertButtonCancel_1` · IconButton  ← `core.AlertButtonConfirm_1`
        - `asset.core.CancelTxtAsset_01` · bitmap 75×18 (core2.swf)
      - `core.AlertButtonCancel_1` · IconButton  ← `core.AlertButtonConfirm_1`
        - `asset.core.CancelTxtAsset_01` · bitmap 75×18 (core2.swf)
    - `core.AlertButtonTextStyle` · FilterFrameText width=91 height=20 font `Arial,14,0xFFefbd,true,,,,,center`
  - `IconAlertBaseItem` · BaseItemView 
    - `core.ItemBack` · ScaleBitmapImage x=1 y=1 width=45 height=45 ← `core.goods.ItemBack`
    - `core.BaseItemViewIcon` · BaseIconView x=1 y=1
      - `asset.core.IconLoading` · sprite 42 frames (core2.swf)
    - `core.GoodsProfileBG` · ScaleFrameImage 
      - `asset.core.BagProfileGreen` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileBlue` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfilePurple` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileOrange` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileRed` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileBlackKing` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileFashion` · bitmap 45×45 (core.swf)
    - `core.BagCellLock` · ScaleFrameImage 
      - `asset.core.BagCellLock` · bitmap 45×45 (core.swf)
      - `asset.core.BagCellUnLock` · bitmap 45×45 (core.swf)
    - `core.goods.Strengthen` · MovieImage x=-50 y=-50
      - `asset.core.goods.Strengthen` · Strengthen 
  - `IconAlertContentText` · FilterFrameText  font `Arial,14,0xffefbd,,,,,,center`
  - texts: `yishi.utils.IconAlertHelper.CanFiveParams` “Máximo de 5 parâmetros suportados no momento”
  - subviews: `BaseItemView`

### yishi.utils.MaskUtils

- **MaskUtils** (`core_module:yishi/utils/MaskUtils.as`)
  - `core.BtnGlowMc` · GlowMc 
  - subviews: `GlowMc`

### yishi.view.adapter.CampaignChapterCellAdapter

- **CampaignChapterCellAdapter** (`core_module:yishi/view/adapter/CampaignChapterCellAdapter.as`)
  - `SelectCP.AreaListCell` · CampaignChapterCellAdapter width=235 height=22
    - `selectCP.ComboxListCellAsset` · ScaleFrameImage x=2
      - `asset.selectCP.ComboxListCellAsset` · bitmap 124×20 (selectcampaign.swf)
      - `asset.selectCP.ComboxListCellAsset` · bitmap 124×20 (selectcampaign.swf)
    - `SelectCP.AreaListCellTextStyle` · FilterFrameText y=1 width=200 height=20 font `Arial,12,0xffdd9a,,,,,,left`

### yishi.view.adapter.CampaignListCellAdapter

- **CampaignListCellAdapter** (`core_module:yishi/view/adapter/CampaignListCellAdapter.as`)
  - `pveroomlist.CampaignListCell` · CampaignListCellAdapter width=215 height=22
    - `pveroomlist.ComboxListCellAsset` · ScaleFrameImage x=2
      - `asset.pveroomlist.ComboxListCellAsset` · bitmap 124×20 (pveroomlist.swf)
      - `asset.pveroomlist.ComboxListCellAsset` · bitmap 124×20 (pveroomlist.swf)
    - `pveroomlist.ListCellTextStyle` · FilterFrameText y=1 width=190 height=20 font `Arial,12,0xffdd9a,,,,,,left`
  - texts: `public.Activity` “Evento”

### yishi.view.adapter.FriendCellAdapter

- **FriendCellAdapter** (`core_module:yishi/view/adapter/FriendCellAdapter.as`)
  - `core.FriendGroupListPanelCell` · FriendCellAdapter width=130 height=22
    - `core.FriendGroupListPanelCellBg` · ScaleFrameImage 
      - `asset.core.FriendGroupListPanelCellBg` · bitmap 92×20 (core.swf)
      - `asset.core.FriendGroupListPanelCellBg` · bitmap 92×20 (core.swf)
    - `core.FriendGroupListPanelCellTxt` · FilterFrameText  font `Arial,12,0xffdd9a,,,,,,left`

### yishi.view.base.BaseBoxGoodsItem

- **BaseBoxGoodsItem** (`core_module:yishi/view/base/BaseBoxGoodsItem.as`)
  - `core.BoxGoodsItem` · BaseItemView 
    - `core.BoxGoodsItemIcon` · BaseIconView x=2 y=2
      - `asset.core.IconLoading` · sprite 42 frames (core2.swf)
    - `core.BoxGoodsItemCountText` · FilterFrameText x=0 y=21 width=40 height=20 font `Arial,12,0xbea969,,,,,,right`
    - `core.BoxGoodsItemProfileBG` · ScaleFrameImage 
      - `asset.core.BagProfileGreen` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileBlue` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfilePurple` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileOrange` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileFashion` · bitmap 45×45 (core.swf)
    - `core.goods.Strengthen` · MovieImage x=-50 y=-50
      - `asset.core.goods.Strengthen` · Strengthen 
  - `core.BoxGoodsItemText` · FilterFrameText x=0 y=0 width=108 height=51 font `Arial,12,0xff8000,,,,,,center`
  - subviews: `BaseItemView`

### yishi.view.base.BaseHelpFrame

- **BaseHelpFrame** (`core_module:yishi/view/base/BaseHelpFrame.as`)
  - `worldboss.HelpTextBmp_1` · ScaleBitmapImage x=18 y=99
    - `asset.worldboss.HelpBmp` · bitmap 
      - `asset.worldboss.HelpBmp` · bitmap 21×21 (campaign.swf)
  - `worldboss.HelpTextBmp_2` · ScaleBitmapImage x=18 y=121
    - `asset.worldboss.HelpBmp` · bitmap 
      - `asset.worldboss.HelpBmp` · bitmap 21×21 (campaign.swf)
  - `worldboss.HelpTextBmp_3` · ScaleBitmapImage x=18 y=142
    - `asset.worldboss.HelpBmp` · bitmap 
      - `asset.worldboss.HelpBmp` · bitmap 21×21 (campaign.swf)
  - `asset.friends.StandingsBG` · bitmap 
    - `asset.friends.StandingsBG` · bitmap 21×15 (friends.swf)
  - `Friends.ItemStandingsTxt` · FilterFrameText x=21 y=2 width=16 height=18 font `Arial,12,0xffffff,,,,,,left`
  - texts: `public.confirm` “Confirmar”

### yishi.view.base.BaseInputFrame

- **BaseInputFrame**: “Campo de entrada” (`core_module:yishi/view/base/BaseInputFrame.as`)
  - `core.BaseInputFrame` · BaseInputFrame width=283 height=228 ← `core.Frame2`
  - `core.BaseInputFrameBack` · MutipleImage x=-22 y=8
    - `core.BaseInputFrameInputBack1` · ScaleBitmapImage width=255 height=80 ← `core.describeBackground_style04`
    - `core.BaseInputFrameInputBack2` · ScaleBitmapImage x=80 y=25 ← `core.InputBack`
  - `core.BaseInputFrameBtn` · TextButton x=65 y=95 ← `core.BlueBtn`
  - `core.BaseInputFrameAlertTxt` · FilterFrameText x=-14 y=37 width=70 height=20 font `Arial,14,0xe7c88b,,,,,,center`
  - `core.BaseInputFrameInputTxt` · FilterFrameText x=64 y=39 width=145 height=20 font `Arial,12,0x8d8d8d,,,,,,center`
  - `core.BaseInputFrameDescribeTxt` · FilterFrameText x=-16 y=63 width=242 height=20 ← `core.BaseInputFrameAlertTxt`
  - texts: `yishi.view.base.BaseInputFrame.title` “Campo de entrada”; `yishi.view.base.BaseInputFrame.alert` “Condição de busca”; `public.confirm` “Confirmar”

### yishi.view.base.GroupSelectObj

- **GroupSelectObj** (`core_module:yishi/view/base/GroupSelectObj.as`)
  - `questionItem.groupSelectObj` · GroupSelectObj x=25 y=30
  - texts: `groupSelectObj.selected.tipTxt` “Você pode selecionar no máximo {0} opções, e pode cancelar a”

### yishi.view.base.HRollItemPanel

- **HRollItemPanel** (`core_module:yishi/view/base/HRollItemPanel.as`)
  - `kingback.day.HRollItemPanel` · HRollItemPanel x=10 y=20

### yishi.view.base.NumberBitmap

- **NumberBitmap** (`core_module:yishi/view/base/NumberBitmap.as`)
  - `kingback.day.NumberBitmap` · NumberBitmap x=101 y=353

### yishi.view.base.OutyardBorderLayer

- **OutyardBorderLayer** (`core_module:yishi/view/base/OutyardBorderLayer.as`)
  - `asset.core.BorderMaskVAsset` · bitmap 
    - `asset.core.BorderMaskVAsset` · bitmap 189×11 (core2.swf)
  - `asset.core.BorderMaskHAsset` · bitmap 
    - `asset.core.BorderMaskHAsset` · bitmap 11×189 (core2.swf)

### yishi.view.base.PageBar

- **PageBar** (`core_module:yishi/view/base/PageBar.as`)
  - `ui.army.runeStone.PageBar` · PageBar x=304 y=354
    - `ui.army.bnextbtn` · BaseButton x=105 y=0 width=30 height=29
      - `asset.core.NextPageBtn` · bitmap 30×29 (core2.swf)
    - `ui.army.blastbtn` · BaseButton x=0 y=0 width=30 height=29
      - `asset.core.PrePageBtn` · bitmap x=-5
        - `asset.core.PrePageBtn` · bitmap 30×29 (core2.swf)
    - `ui.army.bnumbg` · Image x=39 y=-1 width=55 height=30
      - `asset.core.PageNumBack3` · bitmap 55×30 (core2.swf)
    - `ui.army.bpagnum` · FilterFrameText x=42 y=4 width=50 height=19 font `Arial,14,0xffec7b,,,,,,center`

### yishi.view.base.PageSwitchTab

- **PageSwitchTab** (`core_module:yishi/view/base/PageSwitchTab.as`)
  - `gloryroad.switchTab` · PageSwitchTab 
    - `gloryroad.firstBtn` · IconButton x=252 y=384 ← `core.LastPageBtn`
    - `gloryroad.secondBtn` · IconButton x=230 y=300 ← `core.NextPageBtn`
    - `asset.shop.pageNumBg` · bitmap x=534 y=407
      - `asset.shop.pageNumBg` · bitmap 57×30 (shop.swf)
    - `gloryroad.shopTxt` · FilterFrameText x=531 y=413 width=60 height=20 font `arial,14,0xfcdfa7,true,,,,,center`

### yishi.view.base.ProgressPanel

- **ProgressPanel** (`core_module:yishi/view/base/ProgressPanel.as`)
  - `SevenYearBattleFlagView.ProgressPanel` · ProgressPanel x=10 y=160

### yishi.view.base.StarBar

- **StarBar** (`core_module:yishi/view/base/StarBar.as`)
  - `asset.wildsoul.EmptyStar` · bitmap 22×21 (common.swf)
  - `asset.wildsoul.FullStar` · bitmap 22×21 (common.swf)
  - subviews: `Component`

### yishi.view.base.VPropertyBox

- **VPropertyBox** (`core_module:yishi/view/base/VPropertyBox.as`)
  - `ui.goddess.preProsBox` · VPropertyBox x=772 y=315
    - `ui.goddess.preProTxt` · FilterFrameText width=110 height=20 font `Arial,16,0x39ff12,,,,,,left`
    - `ui.goddess.preProVbox` · VBox 

### yishi.view.community.BaseHeroCell

- **BaseHeroCell** (`core_module:yishi/view/community/BaseHeroCell.as`)
  - `core.armymanage.PlayerIcon` · BaseHeroCell x=18 y=16
    - `core.armymanage.IconBack` · ScaleBitmapImage 
      - `asset.core.armymanage.IconBack` · bitmap 75×75 (core.swf)
    - `core.armymanage.PlayerIconIcon` · BaseIconView x=4 y=4
      - `asset.core.IconLoading` · sprite 42 frames (core2.swf)
    - `core.armymanage.HeroVocation` · ScaleFrameImage x=-5 y=-4 ← `core.HeroVocation`

### yishi.view.community.BaseIconView

- **BaseIconView** (`core_module:yishi/view/community/BaseIconView.as`)
  - `assalutwar.BaseIconView` · BaseIconView x=8 y=4
    - `asset.core.IconLoading` · sprite 42 frames (core2.swf)

### yishi.view.community.BaseItemView

- **BaseItemView** (`core_module:yishi/view/community/BaseItemView.as`)
  - `ui.army.fwIcon2.BaseItemView` · BaseItemView x=75 y=0
    - `ui.army.fwIcon2` · BaseIconView x=0 y=0
    - `core.GoodsProfileBG` · ScaleFrameImage 
      - `asset.core.BagProfileGreen` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileBlue` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfilePurple` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileOrange` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileRed` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileBlackKing` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileFashion` · bitmap 45×45 (core.swf)
  - `core.BaseItemView.FashionText` · FilterFrameText x=0 y=0 width=13 height=17 font `Arial,14,0xf6ff00,true,,,,,left`
  - `asset.core.fashionFullLevel` · bitmap 17×16 (core.swf)
  - `mounts.activeText` · FilterFrameText x=0 y=40 width=60 height=20 font `Arial,12,0xff0000,true,,,,,center`
  - `mounts.areaType` · ScaleFrameImage 
    - `asset.mountsTips.magicIcon` · bitmap 25×25 (core.swf)
    - `asset.mountsTips.livestockIcon` · bitmap 25×25 (core.swf)
    - `asset.mountsTips.beastIcon` · bitmap 25×25 (core.swf)
    - `asset.mountsTips.technologyIcon` · bitmap 25×25 (core.swf)
  - `asset.common.vp.icon` · bitmap 
    - `asset.common.vp.icon` · bitmap 17×20 (common.swf)
  - `asset.common.dragontalker` · bitmap 60×60 (common.swf)
  - `core.GoodsBack` · ScaleBitmapImage width=60 height=60
    - `core.shop.goodsItemBack2` · bitmap 
      - `core.shop.goodsItemBack2` · bitmap 60×60 (core.swf)
  - _no style/symbol_: `asset.baseItem.avengerPearlGradeImage`
  - texts: `view.GoodsItem3.ActiveState.text2` “Obtido”; `public.Million` “KK”; `public.Thousands` “K”

### yishi.view.community.BaseWarItem

- **BaseWarItem** (`core_module:yishi/view/community/BaseWarItem.as`)
  - `core.BaseItemView.FashionText` · FilterFrameText x=0 y=0 width=13 height=17 font `Arial,14,0xf6ff00,true,,,,,left`
  - `mounts.areaType` · ScaleFrameImage 
    - `asset.mountsTips.magicIcon` · bitmap 25×25 (core.swf)
    - `asset.mountsTips.livestockIcon` · bitmap 25×25 (core.swf)
    - `asset.mountsTips.beastIcon` · bitmap 25×25 (core.swf)
    - `asset.mountsTips.technologyIcon` · bitmap 25×25 (core.swf)
  - `asset.common.vp.icon` · bitmap 
    - `asset.common.vp.icon` · bitmap 17×20 (common.swf)
  - `asset.common.dragontalker` · bitmap 60×60 (common.swf)
  - _no style/symbol_: `asset.baseItem.avengerPearlGradeImage`

### yishi.view.community.BulePowerItem

- **BulePowerItem** (`core_module:yishi/view/community/BulePowerItem.as`)
  - `core.ProgressBack1` · ScaleBitmapImage 
    - `asset.core.ProgressBack1` · bitmap 284×28 (core.swf)
  - `core.Progressasset1` · ScaleBitmapImage 
    - `asset.core.Progressasset1` · bitmap 276×15 (core.swf)
  - `core.ProgressValueText1` · FilterFrameText height=20 font `Arial,12,0xffffff,true,,,,,center`
  - `core.Progressasset1` · ScaleBitmapImage 
    - `asset.core.Progressasset1` · bitmap 276×15 (core.swf)

### yishi.view.community.CompleteTaskTip

- **CompleteTaskTip** (`core_module:yishi/view/community/CompleteTaskTip.as`)
  - `asset.taskextra.TaskCompleteEffect` · TaskCompleteEffect 
  - `taskextra.TaskIcon` · ScaleFrameImage 
    - `asset.taskextra.dailyTask` · bitmap x=40 y=23
      - `asset.taskextra.dailyTask` · bitmap 42×41 (taskextra.swf)
    - `asset.taskextra.offerTask` · bitmap x=36 y=20
      - `asset.taskextra.offerTask` · bitmap 44×47 (taskextra.swf)
  - `taskextra.Title` · FilterFrameText x=100 y=14 width=182 height=40 font `Arial,14,0x42f939,true,,,,,left`
  - `taskextra.CommitText` · FilterFrameText x=200 y=65 width=100 height=23 font `Arial,14,0x35f7d9,,,true,,,center`
  - texts: `yishi.view.CompleteTaskTip.commitText.text` “Concluir”; `yishi.view.CompleteTaskTip.title0` “[Principal]{0}  Concluído”; `yishi.view.CompleteTaskTip.title1` “[Diário]{0}  Concluído”; `yishi.view.CompleteTaskTip.title2` “[Evento]{0}  Concluído”; `yishi.view.CompleteTaskTip.title3` “[VIP]{0}  Concluído”; `yishi.view.CompleteTaskTip.title6` “[Regresso] {0} completado”; `yishi.view.CompleteTaskTip.title4` “[Recompensa]{0}  Concluído”; `yishi.view.CompleteTaskTip.title5` “[Ciclo] {0} Concluído”

### yishi.view.community.ConsortiaPlayerMenu

- **ConsortiaPlayerMenu** (`core_module:yishi/view/community/ConsortiaPlayerMenu.as`)
  - `tips.ConsortiaPlayerMenuBack` · ScaleBitmapImage x=0 y=244 width=178
    - `asset.mainToolBar.TipsBg02` · bitmap 173×43 (maintoolbar.swf)
  - `consortia.UpgradeBtn` · TextButton x=8 y=279 width=70 height=24
    - `asset.mainToolBar.TipsPromotionBtnBg` · bitmap 50×24 (maintoolbar.swf)
    - `consortia.UpgradeBtnTextStyle` · FilterFrameText height=20 font `Arial,12,0xffefbd,,,,,,left`
  - `consortia.DemotionBtn` · TextButton x=82 ← `consortia.UpgradeBtn`
    - `asset.mainToolBar.TipsDemotionBtnBg` · bitmap 50×24 (maintoolbar.swf)
  - `consortia.FireBtn` · TextButton x=156 ← `consortia.UpgradeBtn`
    - `asset.mainToolBar.TipsFiredBtnBg` · bitmap 50×24 (maintoolbar.swf)
  - `consortia.outRoomBtn` · BaseButton x=50 y=230
    - `asset.core.RightTipOutRoomBG` · bitmap 88×24 (core.swf)
  - texts: `consortia.view.myConsortia.ConsortiaPlayerMenu.promotion` “Promover”; `consortia.view.myConsortia.ConsortiaPlayerMenu.demotion` “Rebaixar”; `consortia.view.myConsortia.ConsortiaPlayerMenu.fire` “Expulsar”; `public.confirm` “Confirmar”; `public.cancel` “Cancelar”; `public.prompt` “Aviso”; `consortia.view.myConsortia.ConsortiaPlayerMenu.content` “Certeza ao expulsar”

### yishi.view.community.CrossBugleFrame

- **CrossBugleFrame**: “Megafone inter-servidor” (`core_module:yishi/view/community/CrossBugleFrame.as`)
  - `core.CrossBugleFrame` · CrossBugleFrame width=347 height=202 ← `core.Frame2`
    - `core.CrossBugleFrame.back` · MutipleImage 
      - `asset.core.crossBack` · bitmap 347×202 (core.swf)
      - `asset.core.cross.leftTitle` · bitmap 60×18 (core.swf)
      - `asset.core.cross.rightTitle` · bitmap 60×18 (core.swf)
  - `asset.core.crossAlertImage` · bitmap x=-10 y=5
    - `asset.core.crossAlertImage` · bitmap 250×24 (core.swf)
  - `CrossBugleFrame.inputBack` · ScaleBitmapImage x=-10 y=35
    - `asset.core.CrossBugleFrame.inputBack` · bitmap 297×93 (core.swf)
  - `CrossBugleFrame.ContentTxt` · FilterFrameText x=-5 y=44 width=288 height=75 font `Arial,12,0xdad8b6`
  - `CrossBugleFrame.WordCountTxt` · FilterFrameText x=136 y=134 width=150 height=20 font `Arial,12,0xdad8b6,,,,,,right`
  - `CrossBugleFrame.ConfirmBtn` · IconButton x=18 y=150 ← `core.AlertButtonConfirm_1`
  - `CrossBugleFrame.CancleBtn` · IconButton x=162 y=150 ← `core.AlertButtonCancel_1`
  - texts: `CrossBugleFrame.title.text` “Megafone inter-servidor”; `yishi.view.RosePresentView.wordCount` “Letras: {0}/{1}”; `friends.im.view.IMStateReplyInputView.dirtyWordTip` “Conteúdo contém caractéres inválidos”

### yishi.view.community.HeadIconCell

- **HeadIconCell** (`core_module:yishi/view/community/HeadIconCell.as`)
  - `colosseum.HeadIconCell` · HeadIconCell x=0 y=4 ← `core.PreviewSmallIconCell`

### yishi.view.community.HeroCell

- **HeroCell** (`core_module:yishi/view/community/HeroCell.as`)
  - `email.HeroCell` · HeroCell 
    - `email.SubHeroBack01` · Image 
      - `asset.core.army.SubHeroBack01` · bitmap 94×94 (core.swf)
    - `core.BaseIcon` · BaseIconView 
      - `asset.core.IconLoading` · sprite 42 frames (core2.swf)
    - `core.HeroVocation` · ScaleFrameImage x=-2 y=-2 width=26 height=26
      - `asset.core.SoldierIcon` · bitmap 26×26 (core.swf)
      - `asset.core.PickManIcon` · bitmap 26×26 (core.swf)
      - `asset.croe.WizardIcon` · bitmap 26×26 (core.swf)
  - texts: `public.level2` “Nv.{0}”

### yishi.view.community.LevelUpView

- **LevelUpView** (`core_module:yishi/view/community/LevelUpView.as`)
  - `playerlevelup.LelveUpLevelBack` · Component 
  - `playerlevelup.LelveUpLevelBack0` · MutipleImage 
    - `playerlevelup.LelveUpLeveBg1.scaleX` · Image 
      - `asset.playerlevelup.LelveUpLeveBg1` · bitmap 269×227 (playerlevelup.swf)
    - `asset.playerlevelup.LelveUpLeveBg1` · bitmap 269×227 (playerlevelup.swf)
    - `playerlevelup.LelveUpLeveBg2.scaleX` · Image 
      - `asset.playerlevelup.LelveUpLeveBg2` · bitmap 135×218 (playerlevelup.swf)
    - `asset.playerlevelup.LelveUpLeveBg2` · bitmap 135×218 (playerlevelup.swf)
  - `asset.playerlevelup.RoleContainer` · RoleContainer 
  - `asset.playerlevelup.LelveUpFrameContain` · LelveUpFrameContain 
  - `asset.playerlevelup.LelveUpVocationContain` · LelveUpVocationContain 
  - `asset.playerlevelup.LelveUpLevelContain` · LelveUpLevelContain 
  - `asset.playerlevelup.LevelUpConfirmBtnBack` · sprite 105 frames (playerlevelup.swf)
  - `asset.playerlevelup.LelveUpLeveltxtContain` · LelveUpLeveltxtContain x=127 y=3
  - `asset.playerlevelup.LelveUpLevelEffect` · LelveUpLevelEffect 
  - `asset.playerlevelup.LelveUpOpenContain` · LelveUpOpenContain 
  - `asset.core.LevelUpNumber` · bitmap 
    - `asset.core.LevelUpNumber` · bitmap 556×64 (core.swf)
  - `playerlevelup.LevelUpVocationTxtStep` · ScaleFrameImage x=0 y=0
    - `asset.playerlevelup.Step01` · bitmap 108×54 (playerlevelup.swf)
    - `asset.playerlevelup.Step02` · bitmap 113×54 (playerlevelup.swf)
    - `asset.playerlevelup.Step03` · bitmap 111×54 (playerlevelup.swf)
    - `asset.playerlevelup.Step04` · bitmap 111×54 (playerlevelup.swf)
    - `asset.playerlevelup.Step05` · bitmap 111×54 (playerlevelup.swf)
    - `asset.playerlevelup.Step06` · bitmap 114×54 (playerlevelup.swf)
    - `asset.playerlevelup.Step07` · bitmap 114×54 (playerlevelup.swf)
    - `asset.playerlevelup.Step08` · bitmap 114×54 (playerlevelup.swf)
    - `asset.playerlevelup.Step09` · bitmap 108×54 (playerlevelup.swf)
    - `asset.playerlevelup.Step10` · bitmap 143×54 (playerlevelup.swf)
  - `playerlevelup.LevelUpItem` · BaseItemView x=0 y=0
    - `playerlevelup.LevelUpItemIcon` · BaseIconView x=11 y=11
      - `asset.core.IconLoading` · sprite 42 frames (core2.swf)
    - `playerlevelup.MultipleLineTip` · MultipleLineTip 
    - `core.goods.Strengthen` · MovieImage x=-50 y=-50
      - `asset.core.goods.Strengthen` · Strengthen 
  - `playerlevelup.LevelUpAddPropName` · FilterFrameText x=0 y=0 width=120 height=25 font `Arial,16,0xdeb986,,,,,,left`
  - `playerlevelup.LevelUpAddPropValue` · FilterFrameText x=110 y=1 width=70 height=20 font `Arial,16,0x00fe06,,,,,,left`
  - _no style/symbol_: `asset.playerlevelup.Human_`, `playerlevelup.LevelUpVocationTxtJob`, `asset.playerlevelup.LevelUpAttribute_`
  - texts: `armyII.ThaneAttributeView.Tip01` “Força”; `armyII.ThaneAttributeView.Tip02` “Proteção”; `armyII.ThaneAttributeView.Tip04` “Físico”; `armyII.ThaneAttributeView.Tip05` “Liderança”; `armyII.ThaneAttributeView.Tip03` “Inteligência”
  - subviews: `BaseItemView`

### yishi.view.community.LevelUpViewII

- **LevelUpViewII** (`core_module:yishi/view/community/LevelUpViewII.as`)
  - `core.LevelupViewII` · LevelUpViewII 
  - `asset.playerlevelup.LelveUpLeveltxtContain` · LelveUpLeveltxtContain x=127 y=3
  - `asset.playerlevelup.NumStyle01` · bitmap 
    - `asset.playerlevelup.NumStyle01` · bitmap 480×70 (playerlevelup.swf)
  - `asset.playerlevelup.LelveUpVocationContain` · LelveUpVocationContain 
  - `asset.playerlevelup.LelveUpLevelContain` · LelveUpLevelContain 
  - _no style/symbol_: `playerlevelup.LevelUpVocationTxtJob`

### yishi.view.community.LoadingSceneView

- **LoadingSceneView** (`core_module:yishi/view/community/LoadingSceneView.as`)
  - `core.loading.LoadingMapAsset.zhanqu` · zhanqu 
  - `core.loading.LoadingMapAsset.zhanqu` · zhanqu 
  - `core.loading.LoadingMapAsset.shenqu` · shenqu 
  - `core.loadingCloseBtn` · BaseButton x=340 y=35 width=29 height=29
    - `asset.core.closeBtn_style01` · bitmap 29×29 (core2.swf)
  - subviews: `shenqu`, `zhanqu`

### yishi.view.community.MagicSpringBufferAddView

- **MagicSpringBufferAddView** (`core_module:yishi/view/community/MagicSpringBufferAddView.as`)
  - `MagicSpringBufferAddView.descText` · FilterFrameText width=200 height=40 font `Arial,12,0xD1C9B1,,,,,,left`
  - `MagicSpringBufferAddView.timeText` · FilterFrameText x=0 y=43 width=170 height=20 font `Arial,12,0xD1C9B1,,,,,,left`
  - texts: `yishi.view.tips.goods.EquipTip.timeStr02` “Expirado”; `MagicSpringBufferAddView.timeText.text` “Efeito temporário: {0}”

### yishi.view.community.PawnContain

- **PawnContain** (`core_module:yishi/view/community/PawnContain.as`)
  - `outercity.PawnBaseCell` · PawnContain 
    - `core.SubHeroBack` · ScaleFrameImage 
      - `asset.core.army.SubHeroBack` · bitmap 
        - `asset.core.army.SubHeroBack` · bitmap 68×69 (core.swf)
    - `core.BaseIcon` · BaseIconView 
      - `asset.core.IconLoading` · sprite 42 frames (core2.swf)
    - `core.outercity.OccupationPawnBaseCellNameText` · FilterFrameText x=-1 y=70 width=66 height=22 font `Arial,12,0xFFC869,,,,,,center`
  - `asset.core.DragIconBack` · bitmap 
    - `asset.core.DragIconBack` · bitmap 78×78 (core.swf)

### yishi.view.community.PawnTileList

- **PawnTileList** (`core_module:yishi/view/community/PawnTileList.as`)
  - `casern.PawnTileList` · PawnTileList x=4 y=-1
  - `casern.ScrollPanel` · ScrollPanel x=3 y=106 width=620 height=267
    - `core.VScrollbar01` · Scrollbar width=23 height=200
      - `core.Scrollbar01_Thumb` · BaseButton width=14 height=46
        - `core.Scrollbar01_thumbImg` · ScaleFrameImage width=14 height=46
          - `core.scrollbar01_step1` · ScaleBitmapImage 
          - `core.scrollbar01_step2` · ScaleBitmapImage 
          - `core.scrollbar01_step2` · ScaleBitmapImage 
          - `core.scrollbar01_step1` · ScaleBitmapImage 
      - `core.Scrollbar01_BackImg` · ScaleUpDownImage width=23 height=103
        - `asset.core.scrollbar01_bg1` · bitmap 23×19 (core2.swf)
        - `asset.core.scrollbar01_bg2` · bitmap 24×60 (core2.swf)
        - `asset.core.scrollbar01_bg3` · bitmap 23×24 (core2.swf)
      - `core.Scrollbar01_Up` · BaseButton width=22 height=21
        - `core.Scrollbar01_UpImg` · ScaleFrameImage width=22 height=21
          - `asset.core.scrollbar01_up1` · bitmap 22×21 (core2.swf)
          - `asset.core.scrollbar01_up2` · bitmap 22×21 (core2.swf)
          - `asset.core.scrollbar01_up2` · bitmap 22×21 (core2.swf)
          - `asset.core.scrollbar01_up1` · bitmap 22×21 (core2.swf)
      - `core.Scrollbar01_Down` · BaseButton width=22 height=21
        - `core.Scrollbar01_DownImg` · ScaleFrameImage width=22 height=21
          - `asset.core.scrollbar01_down1` · bitmap 22×21 (core2.swf)
          - `asset.core.scrollbar01_down2` · bitmap 22×21 (core2.swf)
          - `asset.core.scrollbar01_down2` · bitmap 22×21 (core2.swf)
          - `asset.core.scrollbar01_down1` · bitmap 22×21 (core2.swf)
    - `core.HScrollbar01` · Scrollbar width=200 height=23 ← `core.VScrollbar01`
  - `core.RecruitPawnCell` · RecruitPawnCell 
  - subviews: `VBox`, `RecruitPawnCell`

### yishi.view.community.PlayerMenu

- **PlayerMenu** (`core_module:yishi/view/community/PlayerMenu.as`)
  - `tips.PlayerMenuBack` · ScaleBitmapImage x=0 y=0 width=180 height=245 ← `core.commonTipBg`
  - `tips.ConsortiaPlayerMenuBack` · ScaleBitmapImage x=0 y=244 width=178
    - `asset.mainToolBar.TipsBg02` · bitmap 173×43 (maintoolbar.swf)
  - `asset.mainToolBar.TipsSeparatorbarImg` · bitmap x=1 y=108
    - `asset.mainToolBar.TipsSeparatorbarImg` · bitmap 168×1 (maintoolbar.swf)
  - `tips.PlayerMenuNicknameTextStyle` · FilterFrameText x=8 y=11 width=150 height=20 font `Arial,12,0xfff3d7,,,,,,left`
  - `tips.PlayerMenuConsortiaNameTextStyle1` · FilterFrameText x=8 y=29 width=50 height=20 ← `tips.PlayerMenuNicknameTextStyle`
  - `tips.PlayerMenuConsortiaNameTextStyle2` · FilterFrameText x=56 y=29 width=100 height=20 ← `tips.PlayerMenuNicknameTextStyle`
  - `tips.PlayerMenuConsortiaLevelTextStyle1` · FilterFrameText x=8 y=48 width=50 height=20 ← `tips.PlayerMenuNicknameTextStyle`
  - `tips.PlayerMenuConsortiaLevelTextStyle2` · FilterFrameText x=53 y=48 width=40 height=20 ← `tips.PlayerMenuNicknameTextStyle`
  - `tips.PlayerMenuConsortiaAPTextStyle1` · FilterFrameText x=8 y=67 width=75 height=20 ← `tips.PlayerMenuNicknameTextStyle`
  - `tips.PlayerMenuConsortiaAPTextStyle2` · FilterFrameText x=80 y=67 width=100 height=20 ← `tips.PlayerMenuNicknameTextStyle`
  - `PlayerMenu.serverName` · FilterFrameText x=8 y=85 width=150 height=20 ← `tips.PlayerMenuNicknameTextStyle`
  - `consortia.TipsChatBtn` · ConsortiaSelectedButton x=4 y=93 width=167 height=23
    - `consortia.TipsChatBtnAsset1` · ScaleFrameImage 
      - `consortia.TipsChatBtnSelectedDefault` · MutipleImage 
        - `consortia.TipsMoveFriendBtnAsset1` · ScaleBitmapImage 
          - `asset.mainToolBar.TipsSelectedIcon` · bitmap 167×23 (maintoolbar.swf)
        - `asset.mainToolBar.TipsPrivateChatIcon` · bitmap x=5 y=5
          - `asset.mainToolBar.TipsPrivateChatIcon` · bitmap 20×17 (maintoolbar.swf)
      - `consortia.TipsChatBtnSelectedOver` · MutipleImage 
        - `asset.mainToolBar.TipsSelectedIcon` · bitmap 167×23 (maintoolbar.swf)
        - `asset.mainToolBar.TipsPrivateChatIcon` · bitmap x=5 y=5
          - `asset.mainToolBar.TipsPrivateChatIcon` · bitmap 20×17 (maintoolbar.swf)
      - `consortia.TipsChatBtnSelectedOver` · MutipleImage 
        - `asset.mainToolBar.TipsSelectedIcon` · bitmap 167×23 (maintoolbar.swf)
        - `asset.mainToolBar.TipsPrivateChatIcon` · bitmap x=5 y=5
          - `asset.mainToolBar.TipsPrivateChatIcon` · bitmap 20×17 (maintoolbar.swf)
      - `consortia.TipsChatBtnSelectedDefault` · MutipleImage 
        - `consortia.TipsMoveFriendBtnAsset1` · ScaleBitmapImage 
          - `asset.mainToolBar.TipsSelectedIcon` · bitmap 167×23 (maintoolbar.swf)
        - `asset.mainToolBar.TipsPrivateChatIcon` · bitmap x=5 y=5
          - `asset.mainToolBar.TipsPrivateChatIcon` · bitmap 20×17 (maintoolbar.swf)
    - `consortia.TipsChatBtnAsset1` · ScaleFrameImage 
      - `consortia.TipsChatBtnSelectedDefault` · MutipleImage 
        - `consortia.TipsMoveFriendBtnAsset1` · ScaleBitmapImage 
          - `asset.mainToolBar.TipsSelectedIcon` · bitmap 167×23 (maintoolbar.swf)
        - `asset.mainToolBar.TipsPrivateChatIcon` · bitmap x=5 y=5
          - `asset.mainToolBar.TipsPrivateChatIcon` · bitmap 20×17 (maintoolbar.swf)
      - `consortia.TipsChatBtnSelectedOver` · MutipleImage 
        - `asset.mainToolBar.TipsSelectedIcon` · bitmap 167×23 (maintoolbar.swf)
        - `asset.mainToolBar.TipsPrivateChatIcon` · bitmap x=5 y=5
          - `asset.mainToolBar.TipsPrivateChatIcon` · bitmap 20×17 (maintoolbar.swf)
      - `consortia.TipsChatBtnSelectedOver` · MutipleImage 
        - `asset.mainToolBar.TipsSelectedIcon` · bitmap 167×23 (maintoolbar.swf)
        - `asset.mainToolBar.TipsPrivateChatIcon` · bitmap x=5 y=5
          - `asset.mainToolBar.TipsPrivateChatIcon` · bitmap 20×17 (maintoolbar.swf)
      - `consortia.TipsChatBtnSelectedDefault` · MutipleImage 
        - `consortia.TipsMoveFriendBtnAsset1` · ScaleBitmapImage 
          - `asset.mainToolBar.TipsSelectedIcon` · bitmap 167×23 (maintoolbar.swf)
        - `asset.mainToolBar.TipsPrivateChatIcon` · bitmap x=5 y=5
          - `asset.mainToolBar.TipsPrivateChatIcon` · bitmap 20×17 (maintoolbar.swf)
    - `consortia.TipsMoveFriendBtnTextStyle` · FilterFrameText height=20 font `Arial,12,0xfff3d7,,,,,,left`
  - `consortia.TipsMoveFriendBtn` · ConsortiaSelectedButton x=4 y=93 width=167 height=23
    - `consortia.TipsMoveFriendBtnAsset2` · ScaleFrameImage 
      - `consortia.TipsMoveFriendBtnSelectedDefault` · MutipleImage 
        - `consortia.TipsMoveFriendBtnAsset1` · ScaleBitmapImage 
          - `asset.mainToolBar.TipsSelectedIcon` · bitmap 167×23 (maintoolbar.swf)
        - `asset.mainToolBar.TipsMoveFriendIcon` · bitmap x=6 y=1
          - `asset.mainToolBar.TipsMoveFriendIcon` · bitmap 18×22 (maintoolbar.swf)
      - `consortia.TipsMoveFriendBtnSelectedOver` · MutipleImage 
        - `asset.mainToolBar.TipsSelectedIcon` · bitmap 167×23 (maintoolbar.swf)
        - `asset.mainToolBar.TipsMoveFriendIcon` · bitmap x=6 y=1
          - `asset.mainToolBar.TipsMoveFriendIcon` · bitmap 18×22 (maintoolbar.swf)
      - `consortia.TipsMoveFriendBtnSelectedOver` · MutipleImage 
        - `asset.mainToolBar.TipsSelectedIcon` · bitmap 167×23 (maintoolbar.swf)
        - `asset.mainToolBar.TipsMoveFriendIcon` · bitmap x=6 y=1
          - `asset.mainToolBar.TipsMoveFriendIcon` · bitmap 18×22 (maintoolbar.swf)
      - `consortia.TipsMoveFriendBtnSelectedDefault` · MutipleImage 
        - `consortia.TipsMoveFriendBtnAsset1` · ScaleBitmapImage 
          - `asset.mainToolBar.TipsSelectedIcon` · bitmap 167×23 (maintoolbar.swf)
        - `asset.mainToolBar.TipsMoveFriendIcon` · bitmap x=6 y=1
          - `asset.mainToolBar.TipsMoveFriendIcon` · bitmap 18×22 (maintoolbar.swf)
    - `consortia.TipsMoveFriendBtnAsset2` · ScaleFrameImage 
      - `consortia.TipsMoveFriendBtnSelectedDefault` · MutipleImage 
        - `consortia.TipsMoveFriendBtnAsset1` · ScaleBitmapImage 
          - `asset.mainToolBar.TipsSelectedIcon` · bitmap 167×23 (maintoolbar.swf)
        - `asset.mainToolBar.TipsMoveFriendIcon` · bitmap x=6 y=1
          - `asset.mainToolBar.TipsMoveFriendIcon` · bitmap 18×22 (maintoolbar.swf)
      - `consortia.TipsMoveFriendBtnSelectedOver` · MutipleImage 
        - `asset.mainToolBar.TipsSelectedIcon` · bitmap 167×23 (maintoolbar.swf)
        - `asset.mainToolBar.TipsMoveFriendIcon` · bitmap x=6 y=1
          - `asset.mainToolBar.TipsMoveFriendIcon` · bitmap 18×22 (maintoolbar.swf)
      - `consortia.TipsMoveFriendBtnSelectedOver` · MutipleImage 
        - `asset.mainToolBar.TipsSelectedIcon` · bitmap 167×23 (maintoolbar.swf)
        - `asset.mainToolBar.TipsMoveFriendIcon` · bitmap x=6 y=1
          - `asset.mainToolBar.TipsMoveFriendIcon` · bitmap 18×22 (maintoolbar.swf)
      - `consortia.TipsMoveFriendBtnSelectedDefault` · MutipleImage 
        - `consortia.TipsMoveFriendBtnAsset1` · ScaleBitmapImage 
          - `asset.mainToolBar.TipsSelectedIcon` · bitmap 167×23 (maintoolbar.swf)
        - `asset.mainToolBar.TipsMoveFriendIcon` · bitmap x=6 y=1
          - `asset.mainToolBar.TipsMoveFriendIcon` · bitmap 18×22 (maintoolbar.swf)
    - `consortia.TipsMoveFriendBtnTextStyle` · FilterFrameText height=20 font `Arial,12,0xfff3d7,,,,,,left`
  - `consortia.TipsAddFriendsBtn` · ConsortiaSelectedButton x=4 y=117 width=167 height=23
    - `consortia.TipsAddFriendsBtnAsset1` · ScaleFrameImage 
      - `consortia.TipsAddFriendsBtnSelectedDefault` · MutipleImage 
        - `consortia.TipsMoveFriendBtnAsset1` · ScaleBitmapImage 
          - `asset.mainToolBar.TipsSelectedIcon` · bitmap 167×23 (maintoolbar.swf)
        - `asset.mainToolBar.TipsAddFriendsIcon` · bitmap x=6 y=1
          - `asset.mainToolBar.TipsAddFriendsIcon` · bitmap 20×22 (maintoolbar.swf)
      - `consortia.TipsAddFriendsBtnSelectedOver` · MutipleImage 
        - `asset.mainToolBar.TipsSelectedIcon` · bitmap 167×23 (maintoolbar.swf)
        - `asset.mainToolBar.TipsAddFriendsIcon` · bitmap x=6 y=1
          - `asset.mainToolBar.TipsAddFriendsIcon` · bitmap 20×22 (maintoolbar.swf)
      - `consortia.TipsAddFriendsBtnSelectedOver` · MutipleImage 
        - `asset.mainToolBar.TipsSelectedIcon` · bitmap 167×23 (maintoolbar.swf)
        - `asset.mainToolBar.TipsAddFriendsIcon` · bitmap x=6 y=1
          - `asset.mainToolBar.TipsAddFriendsIcon` · bitmap 20×22 (maintoolbar.swf)
      - `consortia.TipsAddFriendsBtnSelectedDefault` · MutipleImage 
        - `consortia.TipsMoveFriendBtnAsset1` · ScaleBitmapImage 
          - `asset.mainToolBar.TipsSelectedIcon` · bitmap 167×23 (maintoolbar.swf)
        - `asset.mainToolBar.TipsAddFriendsIcon` · bitmap x=6 y=1
          - `asset.mainToolBar.TipsAddFriendsIcon` · bitmap 20×22 (maintoolbar.swf)
    - `consortia.TipsAddFriendsBtnAsset1` · ScaleFrameImage 
      - `consortia.TipsAddFriendsBtnSelectedDefault` · MutipleImage 
        - `consortia.TipsMoveFriendBtnAsset1` · ScaleBitmapImage 
          - `asset.mainToolBar.TipsSelectedIcon` · bitmap 167×23 (maintoolbar.swf)
        - `asset.mainToolBar.TipsAddFriendsIcon` · bitmap x=6 y=1
          - `asset.mainToolBar.TipsAddFriendsIcon` · bitmap 20×22 (maintoolbar.swf)
      - `consortia.TipsAddFriendsBtnSelectedOver` · MutipleImage 
        - `asset.mainToolBar.TipsSelectedIcon` · bitmap 167×23 (maintoolbar.swf)
        - `asset.mainToolBar.TipsAddFriendsIcon` · bitmap x=6 y=1
          - `asset.mainToolBar.TipsAddFriendsIcon` · bitmap 20×22 (maintoolbar.swf)
      - `consortia.TipsAddFriendsBtnSelectedOver` · MutipleImage 
        - `asset.mainToolBar.TipsSelectedIcon` · bitmap 167×23 (maintoolbar.swf)
        - `asset.mainToolBar.TipsAddFriendsIcon` · bitmap x=6 y=1
          - `asset.mainToolBar.TipsAddFriendsIcon` · bitmap 20×22 (maintoolbar.swf)
      - `consortia.TipsAddFriendsBtnSelectedDefault` · MutipleImage 
        - `consortia.TipsMoveFriendBtnAsset1` · ScaleBitmapImage 
          - `asset.mainToolBar.TipsSelectedIcon` · bitmap 167×23 (maintoolbar.swf)
        - `asset.mainToolBar.TipsAddFriendsIcon` · bitmap x=6 y=1
          - `asset.mainToolBar.TipsAddFriendsIcon` · bitmap 20×22 (maintoolbar.swf)
    - `consortia.TipsMoveFriendBtnTextStyle` · FilterFrameText height=20 font `Arial,12,0xfff3d7,,,,,,left`
  - `consortia.TipsCopyNameBtn` · ConsortiaSelectedButton x=4 y=142 width=167 height=23
    - `consortia.TipsCopyNameBtnAsset1` · ScaleFrameImage 
      - `consortia.TipsCopyNameBtnDefault` · MutipleImage 
        - `consortia.TipsMoveFriendBtnAsset1` · ScaleBitmapImage 
          - `asset.mainToolBar.TipsSelectedIcon` · bitmap 167×23 (maintoolbar.swf)
        - `asset.mainToolBar.TipsCopyIcon` · bitmap x=1 y=2
          - `asset.mainToolBar.TipsCopyIcon` · bitmap 26×19 (maintoolbar.swf)
      - `consortia.TipsCopyNameBtnOver` · MutipleImage 
        - `asset.mainToolBar.TipsSelectedIcon` · bitmap 167×23 (maintoolbar.swf)
        - `asset.mainToolBar.TipsCopyIcon` · bitmap x=1 y=2
          - `asset.mainToolBar.TipsCopyIcon` · bitmap 26×19 (maintoolbar.swf)
      - `consortia.TipsCopyNameBtnOver` · MutipleImage 
        - `asset.mainToolBar.TipsSelectedIcon` · bitmap 167×23 (maintoolbar.swf)
        - `asset.mainToolBar.TipsCopyIcon` · bitmap x=1 y=2
          - `asset.mainToolBar.TipsCopyIcon` · bitmap 26×19 (maintoolbar.swf)
      - `consortia.TipsCopyNameBtnDefault` · MutipleImage 
        - `consortia.TipsMoveFriendBtnAsset1` · ScaleBitmapImage 
          - `asset.mainToolBar.TipsSelectedIcon` · bitmap 167×23 (maintoolbar.swf)
        - `asset.mainToolBar.TipsCopyIcon` · bitmap x=1 y=2
          - `asset.mainToolBar.TipsCopyIcon` · bitmap 26×19 (maintoolbar.swf)
    - `consortia.TipsCopyNameBtnAsset1` · ScaleFrameImage 
      - `consortia.TipsCopyNameBtnDefault` · MutipleImage 
        - `consortia.TipsMoveFriendBtnAsset1` · ScaleBitmapImage 
          - `asset.mainToolBar.TipsSelectedIcon` · bitmap 167×23 (maintoolbar.swf)
        - `asset.mainToolBar.TipsCopyIcon` · bitmap x=1 y=2
          - `asset.mainToolBar.TipsCopyIcon` · bitmap 26×19 (maintoolbar.swf)
      - `consortia.TipsCopyNameBtnOver` · MutipleImage 
        - `asset.mainToolBar.TipsSelectedIcon` · bitmap 167×23 (maintoolbar.swf)
        - `asset.mainToolBar.TipsCopyIcon` · bitmap x=1 y=2
          - `asset.mainToolBar.TipsCopyIcon` · bitmap 26×19 (maintoolbar.swf)
      - `consortia.TipsCopyNameBtnOver` · MutipleImage 
        - `asset.mainToolBar.TipsSelectedIcon` · bitmap 167×23 (maintoolbar.swf)
        - `asset.mainToolBar.TipsCopyIcon` · bitmap x=1 y=2
          - `asset.mainToolBar.TipsCopyIcon` · bitmap 26×19 (maintoolbar.swf)
      - `consortia.TipsCopyNameBtnDefault` · MutipleImage 
        - `consortia.TipsMoveFriendBtnAsset1` · ScaleBitmapImage 
          - `asset.mainToolBar.TipsSelectedIcon` · bitmap 167×23 (maintoolbar.swf)
        - `asset.mainToolBar.TipsCopyIcon` · bitmap x=1 y=2
          - `asset.mainToolBar.TipsCopyIcon` · bitmap 26×19 (maintoolbar.swf)
    - `consortia.TipsMoveFriendBtnTextStyle` · FilterFrameText height=20 font `Arial,12,0xfff3d7,,,,,,left`
  - `consortia.TipsBlacklistBtn` · ConsortiaSelectedButton x=4 y=166 width=167 height=23
    - `consortia.TipsBlacklistBtnAsset1` · ScaleFrameImage 
      - `consortia.TipsBlacklistBtnDefault` · MutipleImage 
        - `consortia.TipsMoveFriendBtnAsset1` · ScaleBitmapImage 
          - `asset.mainToolBar.TipsSelectedIcon` · bitmap 167×23 (maintoolbar.swf)
        - `asset.mainToolBar.TipsBlacklistIcon` · bitmap x=4 y=1
          - `asset.mainToolBar.TipsBlacklistIcon` · bitmap 21×22 (maintoolbar.swf)
      - `consortia.TipsBlacklistBtnOver` · MutipleImage 
        - `asset.mainToolBar.TipsSelectedIcon` · bitmap 167×23 (maintoolbar.swf)
        - `asset.mainToolBar.TipsBlacklistIcon` · bitmap x=4 y=1
          - `asset.mainToolBar.TipsBlacklistIcon` · bitmap 21×22 (maintoolbar.swf)
      - `consortia.TipsBlacklistBtnOver` · MutipleImage 
        - `asset.mainToolBar.TipsSelectedIcon` · bitmap 167×23 (maintoolbar.swf)
        - `asset.mainToolBar.TipsBlacklistIcon` · bitmap x=4 y=1
          - `asset.mainToolBar.TipsBlacklistIcon` · bitmap 21×22 (maintoolbar.swf)
      - `consortia.TipsBlacklistBtnDefault` · MutipleImage 
        - `consortia.TipsMoveFriendBtnAsset1` · ScaleBitmapImage 
          - `asset.mainToolBar.TipsSelectedIcon` · bitmap 167×23 (maintoolbar.swf)
        - `asset.mainToolBar.TipsBlacklistIcon` · bitmap x=4 y=1
          - `asset.mainToolBar.TipsBlacklistIcon` · bitmap 21×22 (maintoolbar.swf)
    - `consortia.TipsBlacklistBtnAsset1` · ScaleFrameImage 
      - `consortia.TipsBlacklistBtnDefault` · MutipleImage 
        - `consortia.TipsMoveFriendBtnAsset1` · ScaleBitmapImage 
          - `asset.mainToolBar.TipsSelectedIcon` · bitmap 167×23 (maintoolbar.swf)
        - `asset.mainToolBar.TipsBlacklistIcon` · bitmap x=4 y=1
          - `asset.mainToolBar.TipsBlacklistIcon` · bitmap 21×22 (maintoolbar.swf)
      - `consortia.TipsBlacklistBtnOver` · MutipleImage 
        - `asset.mainToolBar.TipsSelectedIcon` · bitmap 167×23 (maintoolbar.swf)
        - `asset.mainToolBar.TipsBlacklistIcon` · bitmap x=4 y=1
          - `asset.mainToolBar.TipsBlacklistIcon` · bitmap 21×22 (maintoolbar.swf)
      - `consortia.TipsBlacklistBtnOver` · MutipleImage 
        - `asset.mainToolBar.TipsSelectedIcon` · bitmap 167×23 (maintoolbar.swf)
        - `asset.mainToolBar.TipsBlacklistIcon` · bitmap x=4 y=1
          - `asset.mainToolBar.TipsBlacklistIcon` · bitmap 21×22 (maintoolbar.swf)
      - `consortia.TipsBlacklistBtnDefault` · MutipleImage 
        - `consortia.TipsMoveFriendBtnAsset1` · ScaleBitmapImage 
          - `asset.mainToolBar.TipsSelectedIcon` · bitmap 167×23 (maintoolbar.swf)
        - `asset.mainToolBar.TipsBlacklistIcon` · bitmap x=4 y=1
          - `asset.mainToolBar.TipsBlacklistIcon` · bitmap 21×22 (maintoolbar.swf)
    - `consortia.TipsMoveFriendBtnTextStyle` · FilterFrameText height=20 font `Arial,12,0xfff3d7,,,,,,left`
  - `consortia.TipsDelFriendBtn` · ConsortiaSelectedButton x=4 y=190 width=167 height=23
    - `consortia.TipsDelFriendBtnAsset1` · ScaleFrameImage 
      - `consortia.TipsDelFriendBtnDefault` · MutipleImage 
        - `consortia.TipsMoveFriendBtnAsset1` · ScaleBitmapImage 
          - `asset.mainToolBar.TipsSelectedIcon` · bitmap 167×23 (maintoolbar.swf)
        - `asset.mainToolBar.TipsDelFriendIcon` · bitmap x=6 y=2
          - `asset.mainToolBar.TipsDelFriendIcon` · bitmap 19×22 (maintoolbar.swf)
      - `consortia.TipsDelFriendBtnOver` · MutipleImage 
        - `asset.mainToolBar.TipsSelectedIcon` · bitmap 167×23 (maintoolbar.swf)
        - `asset.mainToolBar.TipsDelFriendIcon` · bitmap x=6 y=2
          - `asset.mainToolBar.TipsDelFriendIcon` · bitmap 19×22 (maintoolbar.swf)
      - `consortia.TipsDelFriendBtnOver` · MutipleImage 
        - `asset.mainToolBar.TipsSelectedIcon` · bitmap 167×23 (maintoolbar.swf)
        - `asset.mainToolBar.TipsDelFriendIcon` · bitmap x=6 y=2
          - `asset.mainToolBar.TipsDelFriendIcon` · bitmap 19×22 (maintoolbar.swf)
      - `consortia.TipsDelFriendBtnDefault` · MutipleImage 
        - `consortia.TipsMoveFriendBtnAsset1` · ScaleBitmapImage 
          - `asset.mainToolBar.TipsSelectedIcon` · bitmap 167×23 (maintoolbar.swf)
        - `asset.mainToolBar.TipsDelFriendIcon` · bitmap x=6 y=2
          - `asset.mainToolBar.TipsDelFriendIcon` · bitmap 19×22 (maintoolbar.swf)
    - `consortia.TipsDelFriendBtnAsset1` · ScaleFrameImage 
      - `consortia.TipsDelFriendBtnDefault` · MutipleImage 
        - `consortia.TipsMoveFriendBtnAsset1` · ScaleBitmapImage 
          - `asset.mainToolBar.TipsSelectedIcon` · bitmap 167×23 (maintoolbar.swf)
        - `asset.mainToolBar.TipsDelFriendIcon` · bitmap x=6 y=2
          - `asset.mainToolBar.TipsDelFriendIcon` · bitmap 19×22 (maintoolbar.swf)
      - `consortia.TipsDelFriendBtnOver` · MutipleImage 
        - `asset.mainToolBar.TipsSelectedIcon` · bitmap 167×23 (maintoolbar.swf)
        - `asset.mainToolBar.TipsDelFriendIcon` · bitmap x=6 y=2
          - `asset.mainToolBar.TipsDelFriendIcon` · bitmap 19×22 (maintoolbar.swf)
      - `consortia.TipsDelFriendBtnOver` · MutipleImage 
        - `asset.mainToolBar.TipsSelectedIcon` · bitmap 167×23 (maintoolbar.swf)
        - `asset.mainToolBar.TipsDelFriendIcon` · bitmap x=6 y=2
          - `asset.mainToolBar.TipsDelFriendIcon` · bitmap 19×22 (maintoolbar.swf)
      - `consortia.TipsDelFriendBtnDefault` · MutipleImage 
        - `consortia.TipsMoveFriendBtnAsset1` · ScaleBitmapImage 
          - `asset.mainToolBar.TipsSelectedIcon` · bitmap 167×23 (maintoolbar.swf)
        - `asset.mainToolBar.TipsDelFriendIcon` · bitmap x=6 y=2
          - `asset.mainToolBar.TipsDelFriendIcon` · bitmap 19×22 (maintoolbar.swf)
    - `consortia.TipsMoveFriendBtnTextStyle` · FilterFrameText height=20 font `Arial,12,0xfff3d7,,,,,,left`
  - `consortia.TipsDelFriendBtn` · ConsortiaSelectedButton x=4 y=190 width=167 height=23
    - `consortia.TipsDelFriendBtnAsset1` · ScaleFrameImage 
      - `consortia.TipsDelFriendBtnDefault` · MutipleImage 
        - `consortia.TipsMoveFriendBtnAsset1` · ScaleBitmapImage 
          - `asset.mainToolBar.TipsSelectedIcon` · bitmap 167×23 (maintoolbar.swf)
        - `asset.mainToolBar.TipsDelFriendIcon` · bitmap x=6 y=2
          - `asset.mainToolBar.TipsDelFriendIcon` · bitmap 19×22 (maintoolbar.swf)
      - `consortia.TipsDelFriendBtnOver` · MutipleImage 
        - `asset.mainToolBar.TipsSelectedIcon` · bitmap 167×23 (maintoolbar.swf)
        - `asset.mainToolBar.TipsDelFriendIcon` · bitmap x=6 y=2
          - `asset.mainToolBar.TipsDelFriendIcon` · bitmap 19×22 (maintoolbar.swf)
      - `consortia.TipsDelFriendBtnOver` · MutipleImage 
        - `asset.mainToolBar.TipsSelectedIcon` · bitmap 167×23 (maintoolbar.swf)
        - `asset.mainToolBar.TipsDelFriendIcon` · bitmap x=6 y=2
          - `asset.mainToolBar.TipsDelFriendIcon` · bitmap 19×22 (maintoolbar.swf)
      - `consortia.TipsDelFriendBtnDefault` · MutipleImage 
        - `consortia.TipsMoveFriendBtnAsset1` · ScaleBitmapImage 
          - `asset.mainToolBar.TipsSelectedIcon` · bitmap 167×23 (maintoolbar.swf)
        - `asset.mainToolBar.TipsDelFriendIcon` · bitmap x=6 y=2
          - `asset.mainToolBar.TipsDelFriendIcon` · bitmap 19×22 (maintoolbar.swf)
    - `consortia.TipsDelFriendBtnAsset1` · ScaleFrameImage 
      - `consortia.TipsDelFriendBtnDefault` · MutipleImage 
        - `consortia.TipsMoveFriendBtnAsset1` · ScaleBitmapImage 
          - `asset.mainToolBar.TipsSelectedIcon` · bitmap 167×23 (maintoolbar.swf)
        - `asset.mainToolBar.TipsDelFriendIcon` · bitmap x=6 y=2
          - `asset.mainToolBar.TipsDelFriendIcon` · bitmap 19×22 (maintoolbar.swf)
      - `consortia.TipsDelFriendBtnOver` · MutipleImage 
        - `asset.mainToolBar.TipsSelectedIcon` · bitmap 167×23 (maintoolbar.swf)
        - `asset.mainToolBar.TipsDelFriendIcon` · bitmap x=6 y=2
          - `asset.mainToolBar.TipsDelFriendIcon` · bitmap 19×22 (maintoolbar.swf)
      - `consortia.TipsDelFriendBtnOver` · MutipleImage 
        - `asset.mainToolBar.TipsSelectedIcon` · bitmap 167×23 (maintoolbar.swf)
        - `asset.mainToolBar.TipsDelFriendIcon` · bitmap x=6 y=2
          - `asset.mainToolBar.TipsDelFriendIcon` · bitmap 19×22 (maintoolbar.swf)
      - `consortia.TipsDelFriendBtnDefault` · MutipleImage 
        - `consortia.TipsMoveFriendBtnAsset1` · ScaleBitmapImage 
          - `asset.mainToolBar.TipsSelectedIcon` · bitmap 167×23 (maintoolbar.swf)
        - `asset.mainToolBar.TipsDelFriendIcon` · bitmap x=6 y=2
          - `asset.mainToolBar.TipsDelFriendIcon` · bitmap 19×22 (maintoolbar.swf)
    - `consortia.TipsMoveFriendBtnTextStyle` · FilterFrameText height=20 font `Arial,12,0xfff3d7,,,,,,left`
  - `consortia.TipsPKBtn` · ConsortiaSelectedButton x=4 y=190 width=167 height=23
    - `consortia.TipsPKBtnAsset1` · ScaleFrameImage 
      - `consortia.TipsPKBtnDefault` · MutipleImage 
        - `consortia.TipsMoveFriendBtnAsset1` · ScaleBitmapImage 
          - `asset.mainToolBar.TipsSelectedIcon` · bitmap 167×23 (maintoolbar.swf)
        - `asset.mainToolBar.TipsPK` · bitmap x=6 y=1
          - `asset.mainToolBar.TipsPK` · bitmap 22×22 (maintoolbar.swf)
      - `consortia.TipsPKBtnOver` · MutipleImage 
        - `asset.mainToolBar.TipsSelectedIcon` · bitmap 167×23 (maintoolbar.swf)
        - `asset.mainToolBar.TipsPK` · bitmap x=6 y=1
          - `asset.mainToolBar.TipsPK` · bitmap 22×22 (maintoolbar.swf)
      - `consortia.TipsPKBtnOver` · MutipleImage 
        - `asset.mainToolBar.TipsSelectedIcon` · bitmap 167×23 (maintoolbar.swf)
        - `asset.mainToolBar.TipsPK` · bitmap x=6 y=1
          - `asset.mainToolBar.TipsPK` · bitmap 22×22 (maintoolbar.swf)
      - `consortia.TipsPKBtnDefault` · MutipleImage 
        - `consortia.TipsMoveFriendBtnAsset1` · ScaleBitmapImage 
          - `asset.mainToolBar.TipsSelectedIcon` · bitmap 167×23 (maintoolbar.swf)
        - `asset.mainToolBar.TipsPK` · bitmap x=6 y=1
          - `asset.mainToolBar.TipsPK` · bitmap 22×22 (maintoolbar.swf)
    - `consortia.TipsPKBtnAsset1` · ScaleFrameImage 
      - `consortia.TipsPKBtnDefault` · MutipleImage 
        - `consortia.TipsMoveFriendBtnAsset1` · ScaleBitmapImage 
          - `asset.mainToolBar.TipsSelectedIcon` · bitmap 167×23 (maintoolbar.swf)
        - `asset.mainToolBar.TipsPK` · bitmap x=6 y=1
          - `asset.mainToolBar.TipsPK` · bitmap 22×22 (maintoolbar.swf)
      - `consortia.TipsPKBtnOver` · MutipleImage 
        - `asset.mainToolBar.TipsSelectedIcon` · bitmap 167×23 (maintoolbar.swf)
        - `asset.mainToolBar.TipsPK` · bitmap x=6 y=1
          - `asset.mainToolBar.TipsPK` · bitmap 22×22 (maintoolbar.swf)
      - `consortia.TipsPKBtnOver` · MutipleImage 
        - `asset.mainToolBar.TipsSelectedIcon` · bitmap 167×23 (maintoolbar.swf)
        - `asset.mainToolBar.TipsPK` · bitmap x=6 y=1
          - `asset.mainToolBar.TipsPK` · bitmap 22×22 (maintoolbar.swf)
      - `consortia.TipsPKBtnDefault` · MutipleImage 
        - `consortia.TipsMoveFriendBtnAsset1` · ScaleBitmapImage 
          - `asset.mainToolBar.TipsSelectedIcon` · bitmap 167×23 (maintoolbar.swf)
        - `asset.mainToolBar.TipsPK` · bitmap x=6 y=1
          - `asset.mainToolBar.TipsPK` · bitmap 22×22 (maintoolbar.swf)
    - `consortia.TipsMoveFriendBtnTextStyle` · FilterFrameText height=20 font `Arial,12,0xfff3d7,,,,,,left`
  - `consortia.TipsInfoBtn` · ConsortiaSelectedButton x=4 y=214 width=167 height=23
    - `consortia.TipsInfoBtnAsset1` · ScaleFrameImage 
      - `cconsortia.TipsInfoBtnDefault` · MutipleImage 
        - `consortia.TipsMoveFriendBtnAsset1` · ScaleBitmapImage 
          - `asset.mainToolBar.TipsSelectedIcon` · bitmap 167×23 (maintoolbar.swf)
        - `asset.mainToolBar.TipsInfoIcon` · bitmap x=6 y=-1
          - `asset.mainToolBar.TipsInfoIcon` · bitmap 19×22 (maintoolbar.swf)
      - `consortia.TipsInfoBtnOver` · MutipleImage 
        - `asset.mainToolBar.TipsSelectedIcon` · bitmap 167×23 (maintoolbar.swf)
        - `asset.mainToolBar.TipsInfoIcon` · bitmap x=6 y=-1
          - `asset.mainToolBar.TipsInfoIcon` · bitmap 19×22 (maintoolbar.swf)
      - `consortia.TipsInfoBtnOver` · MutipleImage 
        - `asset.mainToolBar.TipsSelectedIcon` · bitmap 167×23 (maintoolbar.swf)
        - `asset.mainToolBar.TipsInfoIcon` · bitmap x=6 y=-1
          - `asset.mainToolBar.TipsInfoIcon` · bitmap 19×22 (maintoolbar.swf)
      - `cconsortia.TipsInfoBtnDefault` · MutipleImage 
        - `consortia.TipsMoveFriendBtnAsset1` · ScaleBitmapImage 
          - `asset.mainToolBar.TipsSelectedIcon` · bitmap 167×23 (maintoolbar.swf)
        - `asset.mainToolBar.TipsInfoIcon` · bitmap x=6 y=-1
          - `asset.mainToolBar.TipsInfoIcon` · bitmap 19×22 (maintoolbar.swf)
    - `consortia.TipsInfoBtnAsset1` · ScaleFrameImage 
      - `cconsortia.TipsInfoBtnDefault` · MutipleImage 
        - `consortia.TipsMoveFriendBtnAsset1` · ScaleBitmapImage 
          - `asset.mainToolBar.TipsSelectedIcon` · bitmap 167×23 (maintoolbar.swf)
        - `asset.mainToolBar.TipsInfoIcon` · bitmap x=6 y=-1
          - `asset.mainToolBar.TipsInfoIcon` · bitmap 19×22 (maintoolbar.swf)
      - `consortia.TipsInfoBtnOver` · MutipleImage 
        - `asset.mainToolBar.TipsSelectedIcon` · bitmap 167×23 (maintoolbar.swf)
        - `asset.mainToolBar.TipsInfoIcon` · bitmap x=6 y=-1
          - `asset.mainToolBar.TipsInfoIcon` · bitmap 19×22 (maintoolbar.swf)
      - `consortia.TipsInfoBtnOver` · MutipleImage 
        - `asset.mainToolBar.TipsSelectedIcon` · bitmap 167×23 (maintoolbar.swf)
        - `asset.mainToolBar.TipsInfoIcon` · bitmap x=6 y=-1
          - `asset.mainToolBar.TipsInfoIcon` · bitmap 19×22 (maintoolbar.swf)
      - `cconsortia.TipsInfoBtnDefault` · MutipleImage 
        - `consortia.TipsMoveFriendBtnAsset1` · ScaleBitmapImage 
          - `asset.mainToolBar.TipsSelectedIcon` · bitmap 167×23 (maintoolbar.swf)
        - `asset.mainToolBar.TipsInfoIcon` · bitmap x=6 y=-1
          - `asset.mainToolBar.TipsInfoIcon` · bitmap 19×22 (maintoolbar.swf)
    - `consortia.TipsMoveFriendBtnTextStyle` · FilterFrameText height=20 font `Arial,12,0xfff3d7,,,,,,left`
  - `consortia.TipsMarryBtn` · ConsortiaSelectedButton x=4 y=214 width=167 height=23
    - `consortia.TipsMarryBtnAsset1` · ScaleFrameImage 
      - `consortia.TipsMarryBtnDefault` · MutipleImage 
        - `consortia.TipsMoveFriendBtnAsset1` · ScaleBitmapImage 
          - `asset.mainToolBar.TipsSelectedIcon` · bitmap 167×23 (maintoolbar.swf)
        - `asset.mainToolBar.TipsMarryIcon1` · bitmap x=4 y=4
          - `asset.mainToolBar.TipsMarryIcon1` · bitmap 17×18 (maintoolbar.swf)
      - `consortia.TipsMarryBtnOver` · MutipleImage 
        - `asset.mainToolBar.TipsSelectedIcon` · bitmap 167×23 (maintoolbar.swf)
        - `asset.mainToolBar.TipsMarryIcon1` · bitmap x=4 y=4
          - `asset.mainToolBar.TipsMarryIcon1` · bitmap 17×18 (maintoolbar.swf)
      - `consortia.TipsMarryBtnOver` · MutipleImage 
        - `asset.mainToolBar.TipsSelectedIcon` · bitmap 167×23 (maintoolbar.swf)
        - `asset.mainToolBar.TipsMarryIcon1` · bitmap x=4 y=4
          - `asset.mainToolBar.TipsMarryIcon1` · bitmap 17×18 (maintoolbar.swf)
      - `consortia.TipsMarryBtnDefault` · MutipleImage 
        - `consortia.TipsMoveFriendBtnAsset1` · ScaleBitmapImage 
          - `asset.mainToolBar.TipsSelectedIcon` · bitmap 167×23 (maintoolbar.swf)
        - `asset.mainToolBar.TipsMarryIcon1` · bitmap x=4 y=4
          - `asset.mainToolBar.TipsMarryIcon1` · bitmap 17×18 (maintoolbar.swf)
    - `consortia.TipsMarryBtnAsset1` · ScaleFrameImage 
      - `consortia.TipsMarryBtnDefault` · MutipleImage 
        - `consortia.TipsMoveFriendBtnAsset1` · ScaleBitmapImage 
          - `asset.mainToolBar.TipsSelectedIcon` · bitmap 167×23 (maintoolbar.swf)
        - `asset.mainToolBar.TipsMarryIcon1` · bitmap x=4 y=4
          - `asset.mainToolBar.TipsMarryIcon1` · bitmap 17×18 (maintoolbar.swf)
      - `consortia.TipsMarryBtnOver` · MutipleImage 
        - `asset.mainToolBar.TipsSelectedIcon` · bitmap 167×23 (maintoolbar.swf)
        - `asset.mainToolBar.TipsMarryIcon1` · bitmap x=4 y=4
          - `asset.mainToolBar.TipsMarryIcon1` · bitmap 17×18 (maintoolbar.swf)
      - `consortia.TipsMarryBtnOver` · MutipleImage 
        - `asset.mainToolBar.TipsSelectedIcon` · bitmap 167×23 (maintoolbar.swf)
        - `asset.mainToolBar.TipsMarryIcon1` · bitmap x=4 y=4
          - `asset.mainToolBar.TipsMarryIcon1` · bitmap 17×18 (maintoolbar.swf)
      - `consortia.TipsMarryBtnDefault` · MutipleImage 
        - `consortia.TipsMoveFriendBtnAsset1` · ScaleBitmapImage 
          - `asset.mainToolBar.TipsSelectedIcon` · bitmap 167×23 (maintoolbar.swf)
        - `asset.mainToolBar.TipsMarryIcon1` · bitmap x=4 y=4
          - `asset.mainToolBar.TipsMarryIcon1` · bitmap 17×18 (maintoolbar.swf)
    - `consortia.TipsMoveFriendBtnTextStyle` · FilterFrameText height=20 font `Arial,12,0xfff3d7,,,,,,left`
  - `consortia.TipsInviteBtn` · ConsortiaSelectedButton x=4 y=214 width=167 height=23
    - `consortia.TipsInviteBtnAsset1` · ScaleFrameImage 
      - `cconsortia.TipsInviteBtnDefault` · MutipleImage 
        - `consortia.TipsMoveFriendBtnAsset1` · ScaleBitmapImage 
          - `asset.mainToolBar.TipsSelectedIcon` · bitmap 167×23 (maintoolbar.swf)
        - `asset.mainToolBar.TipsInviteIcon` · bitmap x=5 y=-1
          - `asset.mainToolBar.TipsInviteIcon` · bitmap 21×22 (maintoolbar.swf)
      - `consortia.TipsInviteBtnOver` · MutipleImage 
        - `asset.mainToolBar.TipsSelectedIcon` · bitmap 167×23 (maintoolbar.swf)
        - `asset.mainToolBar.TipsInviteIcon` · bitmap x=5 y=-1
          - `asset.mainToolBar.TipsInviteIcon` · bitmap 21×22 (maintoolbar.swf)
      - `consortia.TipsInviteBtnOver` · MutipleImage 
        - `asset.mainToolBar.TipsSelectedIcon` · bitmap 167×23 (maintoolbar.swf)
        - `asset.mainToolBar.TipsInviteIcon` · bitmap x=5 y=-1
          - `asset.mainToolBar.TipsInviteIcon` · bitmap 21×22 (maintoolbar.swf)
      - `cconsortia.TipsInviteBtnDefault` · MutipleImage 
        - `consortia.TipsMoveFriendBtnAsset1` · ScaleBitmapImage 
          - `asset.mainToolBar.TipsSelectedIcon` · bitmap 167×23 (maintoolbar.swf)
        - `asset.mainToolBar.TipsInviteIcon` · bitmap x=5 y=-1
          - `asset.mainToolBar.TipsInviteIcon` · bitmap 21×22 (maintoolbar.swf)
    - `consortia.TipsInviteBtnAsset1` · ScaleFrameImage 
      - `cconsortia.TipsInviteBtnDefault` · MutipleImage 
        - `consortia.TipsMoveFriendBtnAsset1` · ScaleBitmapImage 
          - `asset.mainToolBar.TipsSelectedIcon` · bitmap 167×23 (maintoolbar.swf)
        - `asset.mainToolBar.TipsInviteIcon` · bitmap x=5 y=-1
          - `asset.mainToolBar.TipsInviteIcon` · bitmap 21×22 (maintoolbar.swf)
      - `consortia.TipsInviteBtnOver` · MutipleImage 
        - `asset.mainToolBar.TipsSelectedIcon` · bitmap 167×23 (maintoolbar.swf)
        - `asset.mainToolBar.TipsInviteIcon` · bitmap x=5 y=-1
          - `asset.mainToolBar.TipsInviteIcon` · bitmap 21×22 (maintoolbar.swf)
      - `consortia.TipsInviteBtnOver` · MutipleImage 
        - `asset.mainToolBar.TipsSelectedIcon` · bitmap 167×23 (maintoolbar.swf)
        - `asset.mainToolBar.TipsInviteIcon` · bitmap x=5 y=-1
          - `asset.mainToolBar.TipsInviteIcon` · bitmap 21×22 (maintoolbar.swf)
      - `cconsortia.TipsInviteBtnDefault` · MutipleImage 
        - `consortia.TipsMoveFriendBtnAsset1` · ScaleBitmapImage 
          - `asset.mainToolBar.TipsSelectedIcon` · bitmap 167×23 (maintoolbar.swf)
        - `asset.mainToolBar.TipsInviteIcon` · bitmap x=5 y=-1
          - `asset.mainToolBar.TipsInviteIcon` · bitmap 21×22 (maintoolbar.swf)
    - `consortia.TipsMoveFriendBtnTextStyle` · FilterFrameText height=20 font `Arial,12,0xfff3d7,,,,,,left`
  - `consortia.TipsApplyBtn` · ConsortiaSelectedButton x=4 y=214 width=167 height=23
    - `consortia.TipsApplyBtnAsset1` · ScaleFrameImage 
      - `consortia.TipsApplyBtnDefault` · MutipleImage 
        - `consortia.TipsMoveFriendBtnAsset1` · ScaleBitmapImage 
          - `asset.mainToolBar.TipsSelectedIcon` · bitmap 167×23 (maintoolbar.swf)
        - `asset.mainToolBar.TipsApplyBtnBg` · bitmap 21×22 (maintoolbar.swf)
      - `consortia.TipsApplyBtnOver` · MutipleImage 
        - `asset.mainToolBar.TipsSelectedIcon` · bitmap 167×23 (maintoolbar.swf)
        - `asset.mainToolBar.TipsApplyBtnBg` · bitmap 21×22 (maintoolbar.swf)
      - `consortia.TipsApplyBtnOver` · MutipleImage 
        - `asset.mainToolBar.TipsSelectedIcon` · bitmap 167×23 (maintoolbar.swf)
        - `asset.mainToolBar.TipsApplyBtnBg` · bitmap 21×22 (maintoolbar.swf)
      - `consortia.TipsApplyBtnDefault` · MutipleImage 
        - `consortia.TipsMoveFriendBtnAsset1` · ScaleBitmapImage 
          - `asset.mainToolBar.TipsSelectedIcon` · bitmap 167×23 (maintoolbar.swf)
        - `asset.mainToolBar.TipsApplyBtnBg` · bitmap 21×22 (maintoolbar.swf)
    - `consortia.TipsApplyBtnAsset1` · ScaleFrameImage 
      - `consortia.TipsApplyBtnDefault` · MutipleImage 
        - `consortia.TipsMoveFriendBtnAsset1` · ScaleBitmapImage 
          - `asset.mainToolBar.TipsSelectedIcon` · bitmap 167×23 (maintoolbar.swf)
        - `asset.mainToolBar.TipsApplyBtnBg` · bitmap 21×22 (maintoolbar.swf)
      - `consortia.TipsApplyBtnOver` · MutipleImage 
        - `asset.mainToolBar.TipsSelectedIcon` · bitmap 167×23 (maintoolbar.swf)
        - `asset.mainToolBar.TipsApplyBtnBg` · bitmap 21×22 (maintoolbar.swf)
      - `consortia.TipsApplyBtnOver` · MutipleImage 
        - `asset.mainToolBar.TipsSelectedIcon` · bitmap 167×23 (maintoolbar.swf)
        - `asset.mainToolBar.TipsApplyBtnBg` · bitmap 21×22 (maintoolbar.swf)
      - `consortia.TipsApplyBtnDefault` · MutipleImage 
        - `consortia.TipsMoveFriendBtnAsset1` · ScaleBitmapImage 
          - `asset.mainToolBar.TipsSelectedIcon` · bitmap 167×23 (maintoolbar.swf)
        - `asset.mainToolBar.TipsApplyBtnBg` · bitmap 21×22 (maintoolbar.swf)
    - `consortia.TipsMoveFriendBtnTextStyle` · FilterFrameText height=20 font `Arial,12,0xfff3d7,,,,,,left`
  - `consortia.TipsFollowBtn` · ConsortiaSelectedButton x=4 y=214 width=167 height=23
    - `consortia.TipsFollowBtnAsset1` · ScaleFrameImage 
      - `cconsortia.TipsFollowBtnDefault` · MutipleImage 
        - `consortia.TipsMoveFriendBtnAsset1` · ScaleBitmapImage 
          - `asset.mainToolBar.TipsSelectedIcon` · bitmap 167×23 (maintoolbar.swf)
        - `asset.mainToolBar.TipsFollowIcon` · bitmap x=6 y=-1
          - `asset.mainToolBar.TipsFollowIcon` · bitmap 20×22 (maintoolbar.swf)
      - `consortia.TipsFollowBtnOver` · MutipleImage 
        - `asset.mainToolBar.TipsSelectedIcon` · bitmap 167×23 (maintoolbar.swf)
        - `asset.mainToolBar.TipsFollowIcon` · bitmap x=6 y=-1
          - `asset.mainToolBar.TipsFollowIcon` · bitmap 20×22 (maintoolbar.swf)
      - `consortia.TipsFollowBtnOver` · MutipleImage 
        - `asset.mainToolBar.TipsSelectedIcon` · bitmap 167×23 (maintoolbar.swf)
        - `asset.mainToolBar.TipsFollowIcon` · bitmap x=6 y=-1
          - `asset.mainToolBar.TipsFollowIcon` · bitmap 20×22 (maintoolbar.swf)
      - `cconsortia.TipsFollowBtnDefault` · MutipleImage 
        - `consortia.TipsMoveFriendBtnAsset1` · ScaleBitmapImage 
          - `asset.mainToolBar.TipsSelectedIcon` · bitmap 167×23 (maintoolbar.swf)
        - `asset.mainToolBar.TipsFollowIcon` · bitmap x=6 y=-1
          - `asset.mainToolBar.TipsFollowIcon` · bitmap 20×22 (maintoolbar.swf)
    - `consortia.TipsFollowBtnAsset1` · ScaleFrameImage 
      - `cconsortia.TipsFollowBtnDefault` · MutipleImage 
        - `consortia.TipsMoveFriendBtnAsset1` · ScaleBitmapImage 
          - `asset.mainToolBar.TipsSelectedIcon` · bitmap 167×23 (maintoolbar.swf)
        - `asset.mainToolBar.TipsFollowIcon` · bitmap x=6 y=-1
          - `asset.mainToolBar.TipsFollowIcon` · bitmap 20×22 (maintoolbar.swf)
      - `consortia.TipsFollowBtnOver` · MutipleImage 
        - `asset.mainToolBar.TipsSelectedIcon` · bitmap 167×23 (maintoolbar.swf)
        - `asset.mainToolBar.TipsFollowIcon` · bitmap x=6 y=-1
          - `asset.mainToolBar.TipsFollowIcon` · bitmap 20×22 (maintoolbar.swf)
      - `consortia.TipsFollowBtnOver` · MutipleImage 
        - `asset.mainToolBar.TipsSelectedIcon` · bitmap 167×23 (maintoolbar.swf)
        - `asset.mainToolBar.TipsFollowIcon` · bitmap x=6 y=-1
          - `asset.mainToolBar.TipsFollowIcon` · bitmap 20×22 (maintoolbar.swf)
      - `cconsortia.TipsFollowBtnDefault` · MutipleImage 
        - `consortia.TipsMoveFriendBtnAsset1` · ScaleBitmapImage 
          - `asset.mainToolBar.TipsSelectedIcon` · bitmap 167×23 (maintoolbar.swf)
        - `asset.mainToolBar.TipsFollowIcon` · bitmap x=6 y=-1
          - `asset.mainToolBar.TipsFollowIcon` · bitmap 20×22 (maintoolbar.swf)
    - `consortia.TipsMoveFriendBtnTextStyle` · FilterFrameText height=20 font `Arial,12,0xfff3d7,,,,,,left`
  - `consortia.TipsAppointBtn` · ConsortiaSelectedButton x=4 y=214 width=167 height=23
    - `consortia.TipsAppointBtnAsset1` · ScaleFrameImage 
      - `cconsortia.TipsAppointBtnDefault` · MutipleImage 
        - `consortia.TipsMoveFriendBtnAsset1` · ScaleBitmapImage 
          - `asset.mainToolBar.TipsSelectedIcon` · bitmap 167×23 (maintoolbar.swf)
        - `asset.mainToolBar.TipsAppointBtnIcon` · bitmap 21×20 (maintoolbar.swf)
      - `consortia.TipsAppointBtnOver` · MutipleImage 
        - `asset.mainToolBar.TipsSelectedIcon` · bitmap 167×23 (maintoolbar.swf)
        - `asset.mainToolBar.TipsAppointBtnIcon` · bitmap 21×20 (maintoolbar.swf)
      - `consortia.TipsAppointBtnOver` · MutipleImage 
        - `asset.mainToolBar.TipsSelectedIcon` · bitmap 167×23 (maintoolbar.swf)
        - `asset.mainToolBar.TipsAppointBtnIcon` · bitmap 21×20 (maintoolbar.swf)
      - `cconsortia.TipsAppointBtnDefault` · MutipleImage 
        - `consortia.TipsMoveFriendBtnAsset1` · ScaleBitmapImage 
          - `asset.mainToolBar.TipsSelectedIcon` · bitmap 167×23 (maintoolbar.swf)
        - `asset.mainToolBar.TipsAppointBtnIcon` · bitmap 21×20 (maintoolbar.swf)
    - `consortia.TipsAppointBtnAsset1` · ScaleFrameImage 
      - `cconsortia.TipsAppointBtnDefault` · MutipleImage 
        - `consortia.TipsMoveFriendBtnAsset1` · ScaleBitmapImage 
          - `asset.mainToolBar.TipsSelectedIcon` · bitmap 167×23 (maintoolbar.swf)
        - `asset.mainToolBar.TipsAppointBtnIcon` · bitmap 21×20 (maintoolbar.swf)
      - `consortia.TipsAppointBtnOver` · MutipleImage 
        - `asset.mainToolBar.TipsSelectedIcon` · bitmap 167×23 (maintoolbar.swf)
        - `asset.mainToolBar.TipsAppointBtnIcon` · bitmap 21×20 (maintoolbar.swf)
      - `consortia.TipsAppointBtnOver` · MutipleImage 
        - `asset.mainToolBar.TipsSelectedIcon` · bitmap 167×23 (maintoolbar.swf)
        - `asset.mainToolBar.TipsAppointBtnIcon` · bitmap 21×20 (maintoolbar.swf)
      - `cconsortia.TipsAppointBtnDefault` · MutipleImage 
        - `consortia.TipsMoveFriendBtnAsset1` · ScaleBitmapImage 
          - `asset.mainToolBar.TipsSelectedIcon` · bitmap 167×23 (maintoolbar.swf)
        - `asset.mainToolBar.TipsAppointBtnIcon` · bitmap 21×20 (maintoolbar.swf)
    - `consortia.TipsMoveFriendBtnTextStyle` · FilterFrameText height=20 font `Arial,12,0xfff3d7,,,,,,left`
  - `tips.PlayerMenuConsortiaBtn` · IconButton x=31 y=244
    - `asset.mainToolBar.ConsortiaBtnAsset` · bitmap 114×42 (maintoolbar.swf)
    - `asset.mainToolBar.ConsortiaAsset` · bitmap 69×18 (maintoolbar.swf)
  - `core.FriendGroupListPanel` · ListPanel width=140 height=110
    - `core.commonTipBg` · ScaleBitmapImage width=435
      - `asset.core.describeBackground_style07` · bitmap 260×82 (core2.swf)
  - `tips.KickBtn` · IconButton x=31 y=244
    - `asset.mainToolBar.ConsortiaBtnAsset` · bitmap 114×42 (maintoolbar.swf)
    - `asset.vehicleroom.KickAsset` · bitmap 112×19 (vehicleroomlist.swf)
  - `tips.ChangeMastBtn` · IconButton x=31 y=244
    - `asset.mainToolBar.ConsortiaBtnAsset` · bitmap 114×42 (maintoolbar.swf)
    - `asset.steelmap.ChangeMastBtnTxt` · bitmap 77×34 (steelmap.swf)
  - `consortia.TipsVBox` · VBox x=0 y=111
  - texts: `yishi.view.PlayerMenu.chat` “Privado”; `yishi.view.PlayerMenu.moveFriend` “Mover Amigo”; `yishi.view.PlayerMenu.addFriend` “Adicionar Amigo”; `yishi.view.PlayerMenu.copyName` “Copiar Nome”; `yishi.view.PlayerMenu.blacklist` “Lista Negra”; `yishi.view.PlayerMenu.delFriend` “Deletar Amigo”; `yishi.view.PlayerMenu.delRecent` “Deletar Contato Recente”; `yishi.view.PlayerMenu.pk` “Duelo”
  - subviews: `ConsortiaSelectedButton`

### yishi.view.community.PromotionItem

- **PromotionItem** (`core_module:yishi/view/community/PromotionItem.as`)
  - `shop.GoodsItemBg4` · ScaleFrameImage y=30
    - `asset.core.NormalItemBGImg4` · bitmap 221×119 (core.swf)
    - `shop.GoodsItemAsset4` · MutipleImage 
      - `asset.core.NormalItemBGImg4` · bitmap 221×119 (core.swf)
      - `shop.MouseOver5` · Scale9CornerImage width=221 height=119 ← `shop.MouseOver1`
  - `core.TryOnButton` · TextButton x=13 y=67 width=80 height=28
    - `asset.core.tryWearBack` · bitmap 80×28 (core2.swf)
    - `core.tryWearText` · FilterFrameText width=70 height=20 font `Arial,12,0xfffbe8,,,,,,center`
  - `shop.BuyBtn` · IconButton x=129 y=81
    - `shop.ShopBuyImage` · ScaleFrameImage 
      - `asset.core.ShopBuyBtn` · bitmap 
        - `asset.core.ShopBuyBtn` · bitmap 77×26 (core.swf)
      - `asset.core.ShopBuyBtn` · bitmap 
        - `asset.core.ShopBuyBtn` · bitmap 77×26 (core.swf)
      - `asset.core.ShopBuyBtn2` · bitmap 
        - `asset.core.ShopBuyBtn2` · bitmap 77×26 (core.swf)
      - `asset.core.ShopBuyBtn` · bitmap 
        - `asset.core.ShopBuyBtn` · bitmap 77×26 (core.swf)
    - `asset.core.ShopBuyTxt` · bitmap 
      - `asset.core.ShopBuyTxt` · bitmap 59×19 (core.swf)
  - `shop.GoodsNameTextStyle` · FilterFrameText x=85 y=10 width=135 height=20 font `Arial,13,0xeae1c9,,,,,,right`
  - `shop.GoodsValueTextStyle` · FilterFrameText x=115 y=55 width=70 height=20 font `Arial,15,0xddcda0,true,,,,,right`
  - `core.SmallValueIcon` · ScaleFrameImage x=182 y=72
    - `asset.core.SmallPointImg` · bitmap x=0
      - `asset.core.SmallPointImg` · bitmap 23×21 (bottle.swf)
    - `asset.core.SmallPointImg` · bitmap x=0
      - `asset.core.SmallPointImg` · bitmap 23×21 (bottle.swf)
  - `shop.PromotionItemView` · BaseItemView x=17 y=47 ← `shop.BaseItemView`
    - `shop.PromotionItemViewIcon` · BaseIconView  ← `shop.BaseItemViewIcon`
  - `shop.DiscountTxt` · FilterFrameText x=16 y=97 width=30 height=20 font `Arial,18,0xfffc00,true,,,,,center`
  - `shop.PromotionText` · FilterFrameText x=70 y=8 width=105 height=20 font `Arial,16,0xfffdf4,true,,,,,center`
  - `asset.core.DiscountBack` · bitmap x=7 y=93
    - `asset.core.DiscountBack` · bitmap 48×48 (core.swf)
  - `asset.core.PromotionBtnImg` · bitmap x=3 y=0
    - `asset.core.PromotionBtnImg` · bitmap 81×38 (core.swf)
  - `asset.core.PromotionTimeBtnImg` · bitmap x=61 y=0
    - `asset.core.PromotionTimeBtnImg` · bitmap 156×38 (core.swf)
  - `asset.core.DiscounttxtBitm` · bitmap x=20 y=115
    - `asset.core.DiscounttxtBitm` · bitmap 20×14 (core.swf)
  - `asset.core.PromoTimeImgTxt` · bitmap x=159 y=10
    - `asset.core.PromoTimeImgTxt` · bitmap 53×20 (core.swf)
  - `asset.core.PromoTimeImgTxt02` · bitmap x=145 y=10
    - `asset.core.PromoTimeImgTxt02` · bitmap 92×21 (core.swf)
  - `asset.core.PromoPromptImgTxt` · bitmap x=63 y=68
    - `asset.core.PromoPromptImgTxt` · bitmap 105×60 (core.swf)
  - `core.GrayFilter` · ColorMatrixFilter 
  - `core.GrayFilter` · ColorMatrixFilter 
  - `shop.ShopMainBuyFrame` · ShopMainBuyFrame  ← `core.QuickBuyFrame`
  - texts: `view.GoodsItem3.tryOnBtn.text` “Provar”
  - subviews: `BaseItemView`, `ShopMainBuyFrame`

### yishi.view.community.RecruitPawnCell

- **RecruitPawnCell** (`core_module:yishi/view/community/RecruitPawnCell.as`)
  - `core.RecruitPawnCell` · RecruitPawnCell 
  - `casern.RecruitPawnIcon` · BaseIconView x=5 y=4
    - `asset.core.IconLoading` · sprite 42 frames (core2.swf)
  - `asset.casern.headFrameImg` · bitmap 
    - `asset.casern.headFrameImg` · bitmap 70×69 (casern.swf)
  - `asset.casern.ItemBgImg` · bitmap x=70 y=-1 width=529
    - `asset.casern.ItemBgImg` · bitmap 449×71 (casern.swf)
  - `casern.RecruitPawnBtn` · TextButton x=512 y=20 ← `core.BrownBtn`
    - `casern.RecruitPawnBtnTextStyle` · FilterFrameText width=60 height=22 font `Arial,12,0xFFefbd,,,,,,center`
  - `casern.UpgradeBtn` · TextButton x=423 y=20 ← `core.GreenBtn`
    - `casern.RecruitPawnBtnTextStyle` · FilterFrameText width=60 height=22 font `Arial,12,0xFFefbd,,,,,,center`
  - `casern.PawnTitle` · FilterFrameText x=86 y=13 font `Arial,14,0xfff4c6,true,,,,,center`
  - `casern.PawnLevel` · FilterFrameText x=200 y=13 font `Arial,14,0xfff4c6,true,,,,,center`
  - `casern.PawnDepict` · FilterFrameText x=86 y=31 width=336 height=40 font `Arial,12,0xFFFFFF`
  - `casern.PawnInfo` · FilterFrameText x=420 y=23 width=170 height=22 font `Arial,12,0xFF0000,,,,,,center`
  - texts: `buildings.casern.view.RecruitPawnCell.command01` “Recrutar”; `buildings.casern.view.RecruitPawnCell.command02` “Elevar”; `buildings.casern.view.RecruitPawnCell.command06` “Nv. {0}”; `buildings.casern.view.RecruitPawnCell.command05` “Necessita de {0}”; `buildings.casern.view.RecruitPawnCell.command03` “População insuficiente”; `public.gold` “Ouro Insuficiente”
  - subviews: `BaseIconView`

### yishi.view.community.RenameView

- **RenameView** (`core_module:yishi/view/community/RenameView.as`)
  - `asset.rename.ReNameBgAsset` · bitmap 
    - `asset.rename.ReNameBgAsset` · bitmap 570×218 (rename.swf)
  - `asset.rename.InputNameTipAsset` · bitmap x=115 y=45
    - `asset.rename.InputNameTipAsset` · bitmap 181×24 (rename.swf)
  - `asset.rename.ReNameFreeTipAsset` · bitmap x=115 y=16
    - `asset.rename.ReNameFreeTipAsset` · bitmap 357×33 (rename.swf)
  - `rename.SubmitBtn` · IconButton x=235 y=161
    - `asset.core.Style9Btn` · bitmap 130×46 (core2.swf)
    - `asset.core.SubmitBtnAsset` · bitmap 102×24 (core.swf)
  - `rename.CloseBtn` · BaseButton x=500 y=0
    - `asset.rename.CloseBtn` · bitmap 26×26 (rename.swf)
  - `rename.ReNameTxt` · FilterFrameText x=206 y=82 width=180 height=30 font `Arial,20,0xFFfA04,,,,,,center`
  - `rename.RenameFrameDescribeTxt` · FilterFrameText x=150 y=119 width=310 height=20 font `Arial,12,0xFF0000,,,,,,center`
  - `rename.RenameFrameWarningTxt` · FilterFrameText x=150 y=138 width=300 height=20 font `Arial,12,0xFF5A04,,,,,,center`
  - texts: `noviceII.node.AddUserNameFrame.describt01` “Nome do Personagem deve conter de 4~12 caracteres”; `noviceII.node.AddUserNameFrame.describt00` “Renomeamento tomará efeito em 24 horas”; `noviceII.node.AddUserNameFrame.describt02` “Nome do Personagem em branco!”; `noviceII.node.AddUserNameFrame.describt03` “Nome do Personagem muito curto!”; `noviceII.node.AddUserNameFrame.describt04` “Nome do Personagem muito longo!”; `noviceII.node.AddUserNameFrame.describt05` “Nome do Personagem contêm caracteres inválidos!”; `public.loadErrorMsg` “Falha ao Carregar”; `noviceII.view.AddUserNameFrame.checkNickErrorEvent2` “Falha ao carregar verificação de apelido”

### yishi.view.community.TimeCountView

- **TimeCountView** (`core_module:yishi/view/community/TimeCountView.as`)
  - `rapid.timeOut` · TimeCountView x=61 y=4
    - `rapid.timeDown.txt1` · FilterFrameText width=100 height=20 font `Arial,14,0x00ff00,,,,,,left`
  - texts: `public.time.sigHour` “H”; `public.minute` “M”

### yishi.view.community.TimeDownBitmapView

- **TimeDownBitmapView** (`core_module:yishi/view/community/TimeDownBitmapView.as`)
  - `fish.FishHelpFrame.time` · TimeDownBitmapView x=25 y=80
    - `fish.FishFrame.fishCDText` · FilterFrameText width=90 height=30 font `Arial,19,0x00fe00,,,,,,left`
    - `asset.fish.FishHelp.time` · bitmap 462×49 (fish.swf)
  - texts: `public.time.sigHour` “H”; `public.minute` “M”

### yishi.view.community.TimeDownView

- **TimeDownView** (`core_module:yishi/view/community/TimeDownView.as`)
  - `worldboss.woundinfo.TimeDownView` · TimeDownView x=120 y=37
    - `worldboss.woundinfo.RemainingTimeFrameText2` · FilterFrameText  font `arial,12,0xFFF4C6`
  - texts: `public.time.sigHour` “H”; `public.minute` “M”

### yishi.view.component.MovieButton2

- **MovieButton2** (`core_module:yishi/view/component/MovieButton2.as`)
  - `slot.slotFrame.pullBtn` · MovieButton2 x=393 y=47 width=52 height=219

### yishi.view.component.MovieButtonII

- **MovieButtonII** (`core_module:yishi/view/component/MovieButtonII.as`)
  - `room.roomRight.crossPveStartBtn` · MovieButtonII 

### yishi.view.component.TileContainer

- **TileContainer** (`core_module:yishi/view/component/TileContainer.as`)
  - `ChildHandBookRightFrame.TileContainer` · TileContainer x=30 y=160

### yishi.view.component.TimerButton

- **TimerButton** (`core_module:yishi/view/component/TimerButton.as`)
  - `chest.TimerBtn` · TimerButton x=-40 y=-3
    - `asset.core.Style13Btn` · bitmap 237×69 (core2.swf)
    - `chest.TimerBtnTxt` · FilterFrameText x=121 y=20 width=40 height=30 font `Arial,26,0xecda14,true,,,,,center`
    - `asset.chest.battleinvite.WashTxtAsset` · bitmap x=65 y=23
      - `asset.chest.battleinvite.WashTxtAsset` · bitmap 143×27 (chest.swf)

### yishi.view.frame.ApplyFriendFrame

- **ApplyFriendFrame**: “Pedido de adição” (`core_module:yishi/view/frame/ApplyFriendFrame.as`)
  - `friends.ApplyFriendFrame` · ApplyFriendFrame width=375 height=225 ← `core.Frame2`
  - `friends.applybg` · ScaleBitmapImage x=12 y=5 width=335 height=90 ← `core.describeBackground_style04`
  - `friends.applyOKBtn` · TextButton x=47 y=100 ← `core.GreenBtn`
    - `friends.RecruitPawnBtnTextStyle` · FilterFrameText width=60 height=22 font `Arial,12,0xFFefbd,,,,,,center`
  - `friends.applyCancleBtn` · TextButton x=230 y=100 ← `core.RedBtn`
    - `friends.RecruitPawnBtnTextStyle` · FilterFrameText width=60 height=22 font `Arial,12,0xFFefbd,,,,,,center`
  - `friends.applyNameTxt` · FilterFrameText x=18 y=20 width=130 height=22 font `Arial,15,0xfc7100,,,,,,left`
  - `friends.applyFont1Txt` · FilterFrameText x=150 y=20 width=194 height=22 font `Arial,15,0xefbe55,,,,,,left`
  - `friends.applyFont2Txt` · FilterFrameText x=20 y=60 width=60 height=22 font `Arial,12,0xffae00,,,,,,left`
  - `friends.applyPSTxt` · FilterFrameText x=80 y=60 width=260 height=22 font `Arial,12,0xfddaac,,,,,,left`
  - texts: `friends.view.ToolInviteFriendItem.accept` “Concordar”; `map.campaign.view.frame.PrepareBattleFrame1.reject` “Recusar”; `friends.view.ApplyFriendFrame.title` “Pedido de adição”; `friends.view.ApplyFriendFrame.font1` “pediu para adicioná-lo como amigo, concordar?”; `friends.view.ApplyFriendFrame.font2` “Informação adicional”

### yishi.view.frame.ArtifactBuyFrame

- **ArtifactBuyFrame** (`core_module:yishi/view/frame/ArtifactBuyFrame.as`)
  - `artifact.buyFrame` · ArtifactBuyFrame  ← `core.QuickBuyFrame`
  - `shop.GiftDonatioFrame` · GiftDonatioFrame width=385 height=196 ← `shop.PresentFrame`
  - texts: `shop.view.GoodsItem.limited07` “Limite”; `shop.view.GoodsItem.limited05` “Limite Atingido”; `shop.view.frame.BuyFrameI.buyFailed` “Falha na compra, informa??es do item atualizados”
  - subviews: `GiftDonatioFrame`

### yishi.view.frame.AttackCastleAlertFrame

- **AttackCastleAlertFrame**: “Aviso” (`core_module:yishi/view/frame/AttackCastleAlertFrame.as`)
  - `core.ThewConfirmBtn` · SelectedCheckButton x=51 y=96 ← `core.AlertButton`
  - `core.ThewCancelBtn` · SelectedCheckButton x=180 y=96 ← `core.AlertButton`
  - `core.ThewCheckBtn` · SelectedCheckButton x=109 y=62
    - `asset.core.checkstyle_2.UnSelected` · bitmap 22×23 (core2.swf)
    - `asset.core.checkstyle_2.Selected` · sprite (core2.swf)
    - `core.ThewCheckTxt` · FilterFrameText width=170 font `Arial,12,0xe7c88b,,,,,,center`
  - `core.ThewDescribeTxt` · FilterFrameText x=-4 y=8 width=340 height=50 font `Arial,14,0xe7c88b,,,,,,left`
  - `core.ThewCheckTxt` · FilterFrameText width=170 font `Arial,12,0xe7c88b,,,,,,center`
  - texts: `yishi.view.base.ThewAlertFrame.text` “Não alertar mais”; `public.confirm` “Confirmar”; `public.cancel` “Cancelar”; `yishi.view.base.AttackAlertFrame.content` “Ao atacar outro jogador, seu efeito de proteção será anulado”; `public.prompt` “Aviso”

### yishi.view.frame.BingoBuyFrame

- **BingoBuyFrame**: “Comprar” (`core_module:yishi/view/frame/BingoBuyFrame.as`)
  - `bingo.buyFrame` · BingoBuyFrame  ← `core.QuickBuyFrame`
  - `quickbuy.BingoBuyFrameBack` · MutipleImage 
    - `asset.quickbuy.BuyFrameBaseBack` · bitmap 268×281 (quickbuy.swf)
    - `asset.quickbuy.BuyPriceText` · bitmap x=10 y=133
      - `asset.quickbuy.BuyPriceText` · bitmap 88×25 (quickbuy.swf)
    - `asset.quickbuy.BuyNumText` · bitmap x=10 y=162
      - `asset.quickbuy.BuyNumText` · bitmap 94×28 (quickbuy.swf)
    - `quickbuy.BuyInputBg` · Image x=96 y=159
      - `asset.core.TextInputBG2` · bitmap 87×30 (core2.swf)
    - `quickbuy.BuyInputBg1` · Image x=128 y=191
      - `asset.core.TextInputBG2` · bitmap 87×30 (core2.swf)
    - `quickbuy.BuyInputBg2` · Image x=172 y=190
      - `asset.core.TextInputBG2` · bitmap 87×30 (core2.swf)
  - `quickbuy.SelfSelectedBackBtn` · SelectedIconButton x=24 y=11 width=100 height=26
    - `asset.quickbuy.Buycheckstyle_2.UnSelected` · bitmap 18×18 (quickbuy.swf)
    - `asset.quickbuy.Buycheckstyle_2.Selected` · bitmap 18×18 (quickbuy.swf)
    - `asset.quickbuy.unselectedBackTxt` · bitmap 81×23 (quickbuy.swf)
    - `asset.quickbuy.unselectedBackTxt` · bitmap 81×23 (quickbuy.swf)
  - `quickbuy.bingoBuy.rankNumBmp` · Image x=38 y=56
    - `asset.shop.rankNumBmp` · bitmap 
      - `asset.shop.rankNumBmp` · bitmap 60×60 (shop.swf)
  - `quickbuy.BuyGoodsNameStyle` · FilterFrameText x=113 y=39 width=168 height=60 font `Arial,14,0xeae1c9,,,,,,left`
  - `quickbuy.AddButton` · BaseButton x=188 y=163 width=22 height=21
    - `asset.core.UpButton` · bitmap 22×21 (core2.swf)
  - `quickbuy.DeleteButton` · BaseButton x=215 ← `quickbuy.AddButton`
    - `asset.core.DownButton` · bitmap 22×21 (core2.swf)
  - `quickbuy.selfConfirmBtn` · IconButton x=129 y=230 width=134 height=45
    - `asset.quickbuy.ShopBuyFrameBuyBtnBg` · bitmap 115×48 (quickbuy.swf)
    - `asset.quickbuy.ShopBuyFrameBuyBtnText` · bitmap 76×17 (quickbuy.swf)
  - `quickbuy.TotalPriceTextStyle` · FilterFrameText x=96 y=134 width=124 height=20 font `Arial,14,0xddcda0,true,,,,,left`
  - `quickbuy.BuyNumTextStyle` · FilterFrameText x=100 y=163 width=76 height=20 font `Arial,14,0xfffd7d,true,,,,,center`
  - `quickbuy.ShopPayType` · ScaleFrameImage y=134
    - `asset.core.SmallPointImg` · bitmap x=0
      - `asset.core.SmallPointImg` · bitmap 23×21 (bottle.swf)
    - `asset.core.SmallGiftImg` · bitmap 
      - `asset.core.SmallGiftImg` · bitmap 23×21 (core.swf)
    - `asset.core.SmallGoldIcon` · bitmap 21×21 (core.swf)
    - `asset.core.contributionImg` · bitmap 
      - `asset.core.contributionImg` · bitmap 89×21 (core.swf)
    - `asset.core.medalImg` · bitmap 
      - `asset.core.medalImg` · bitmap 60×19 (core.swf)
    - `asset.core.MazeCoinlImg` · bitmap 79×29 (core.swf)
    - `asset.core.AresHeart` · bitmap 24×24 (core.swf)
    - `asset.core.BackPLayer` · bitmap 26×21 (core.swf)
    - `asset.core.sealOfKing` · bitmap 24×25 (core.swf)
    - `asset.core.sealOfKing` · bitmap 24×25 (core.swf)
    - `asset.core.LeagueMedalIcon` · bitmap 23×26 (core.swf)
    - `asset.core.guild` · bitmap x=-7 y=-8
      - `asset.core.guild` · bitmap 34×36 (core.swf)
    - `asset.core.AthenaTear` · bitmap 17×24 (core.swf)
    - `asset.core.pokerScoreIcon` · bitmap 22×22 (core.swf)
    - `asset.core.outyardImg` · bitmap 21×22 (core.swf)
    - `quickbuy.redCrystalImg` · Image x=0 y=-4
      - `asset.core.redCrystalImg` · bitmap 26×26 (core.swf)
    - `asset.shop.glory` · bitmap 22×22 (core.swf)
    - `asset.core.YellowIcon` · bitmap 24×24 (core.swf)
    - `asset.core.isLandExploreMedal` · bitmap 20×26 (core.swf)
    - `asset.core.assaultwarMedal` · bitmap 25×25 (core.swf)
    - `asset.core.pumpingJoyCoupon` · bitmap 25×25 (core.swf)
    - `shop.GodsMarking` · Image x=2 y=-8
      - `asset.common.GodsMarking` · bitmap 27×30 (common.swf)
    - `asset.core.copyConsortiaImg` · bitmap 29×32 (core.swf)
    - `asset.core.apex.money` · bitmap 22×27 (core.swf)
    - `asset.core.crossGuildCoin` · bitmap 22×20 (core.swf)
    - `asset.core.antaeus.icon1` · bitmap 22×21 (core.swf)
    - `asset.core.airGardenPropIconImage` · bitmap 30×30 (core.swf)
    - `asset.core.flameTempleIconImage` · bitmap 18×23 (core.swf)
    - `asset.core.duskAreaIconImage` · bitmap 18×24 (core.swf)
    - `quickbuy.demonroadShopCoin` · Image x=-1 y=-6
      - `asset.core.demonroadShopCoin` · bitmap 49×49 (core.swf)
    - `asset.core.darkMazeCoin` · bitmap 22×20 (core.swf)
    - `asset.core.consortianewboss.icon` · bitmap x=0 y=-5
      - `asset.core.consortianewboss.icon` · bitmap 30×30 (core.swf)
    - `asset.core.theseuspvp.fighticon` · bitmap 30×30 (core.swf)
    - `asset.core.yeargoldIcon` · bitmap 31×30 (core.swf)
    - `asset.core.yearboxkeyicon` · bitmap 29×31 (core.swf)
    - `asset.core.minosCoin` · bitmap 25×32 (core.swf)
    - `asset.core.chesspvpCoin` · bitmap 34×34 (core.swf)
    - `asset.core.childnswarIcon` · bitmap 30×30 (core.swf)
    - `asset.vipShopView.CurrencyIcon` · bitmap 22×24 (core.swf)
  - `asset.shop.rankNumAsset` · bitmap 
    - `asset.shop.rankNumAsset` · bitmap 210×29 (shop.swf)
  - `asset.shop.luckNumBmp` · bitmap x=11 y=192
    - `asset.shop.luckNumBmp` · bitmap 120×19 (shop.swf)
  - `quickbuy.LuckNumTextStyle1` · FilterFrameText x=122 y=196 width=50 height=20 font `Arial,14,0xffffff,,,,,,center` ← `quickbuy.BuyNumTextStyle`
  - `quickbuy.LuckNumTextStyle2` · FilterFrameText x=166 y=196 width=50 height=20 font `Arial,14,0xffffff,,,,,,center` ← `quickbuy.BuyNumTextStyle`
  - `campaign.TrailShop.BuyBtnTxt` · GradientText 
    - `campaign.TrailShop.BuyBtnTxt2` · FilterFrameText width=46 height=20 font `Arial,12,0xecc200,,,,,,center`
  - texts: `campaign.TrailShop.BuyBtnTxt` “Comprar”; `bingo.BingoBuyFrame.sameLuckNum` “Não é possível de selecionar os mesmos números da sorte”; `view.GoodsItem10.titleTxt` “Grupo de cartas nº{0}”
  - subviews: `Component`

### yishi.view.frame.BuyFrameI

- **BuyFrameI**: “Comprar” (`core_module:yishi/view/frame/BuyFrameI.as`)
  - `quickbuy.SelfBuyFrameBack` · MutipleImage 
    - `asset.quickbuy.BuyFrameBaseBack` · bitmap 268×281 (quickbuy.swf)
    - `asset.quickbuy.BuyPriceText` · bitmap x=10 y=133
      - `asset.quickbuy.BuyPriceText` · bitmap 88×25 (quickbuy.swf)
    - `asset.quickbuy.BuyNumText` · bitmap x=10 y=162
      - `asset.quickbuy.BuyNumText` · bitmap 94×28 (quickbuy.swf)
    - `quickbuy.BuyInputBg` · Image x=96 y=159
      - `asset.core.TextInputBG2` · bitmap 87×30 (core2.swf)
  - `quickbuy.FriendBuyFrameBack` · MutipleImage 
    - `asset.quickbuy.PresentFrameBaseBack` · bitmap 268×281 (quickbuy.swf)
    - `asset.quickbuy.BuyPriceText` · bitmap x=10 y=133
      - `asset.quickbuy.BuyPriceText` · bitmap 88×25 (quickbuy.swf)
    - `asset.quickbuy.BuyNumText` · bitmap x=10 y=162
      - `asset.quickbuy.BuyNumText` · bitmap 94×28 (quickbuy.swf)
    - `quickbuy.BuyInputBg` · Image x=96 y=159
      - `asset.core.TextInputBG2` · bitmap 87×30 (core2.swf)
  - `quickbuy.SelfSelectedBackBtn` · SelectedIconButton x=24 y=11 width=100 height=26
    - `asset.quickbuy.Buycheckstyle_2.UnSelected` · bitmap 18×18 (quickbuy.swf)
    - `asset.quickbuy.Buycheckstyle_2.Selected` · bitmap 18×18 (quickbuy.swf)
    - `asset.quickbuy.unselectedBackTxt` · bitmap 81×23 (quickbuy.swf)
    - `asset.quickbuy.unselectedBackTxt` · bitmap 81×23 (quickbuy.swf)
  - `quickbuy.FriendSelectedBackBtn` · SelectedIconButton x=130 y=11 width=100 height=26
    - `asset.quickbuy.Buycheckstyle_2.UnSelected` · bitmap 18×18 (quickbuy.swf)
    - `asset.quickbuy.Buycheckstyle_2.Selected` · bitmap 18×18 (quickbuy.swf)
    - `asset.quickbuy.Present.unselectedBackTxt` · bitmap 99×19 (quickbuy.swf)
    - `asset.quickbuy.Present.unselectedBackTxt` · bitmap 99×19 (quickbuy.swf)
  - `quickbuy.FriendConfirmBtn` · BaseButton x=69 y=203 width=134 height=45
    - `asset.quickbuy.PresentSubmitBtn` · bitmap 134×45 (quickbuy.swf)
  - `quickbuy.selfConfirmBtn` · IconButton x=129 y=230 width=134 height=45
    - `asset.quickbuy.ShopBuyFrameBuyBtnBg` · bitmap 115×48 (quickbuy.swf)
    - `asset.quickbuy.ShopBuyFrameBuyBtnText` · bitmap 76×17 (quickbuy.swf)
  - `quickbuy.selfAddToShopCartBtn` · IconButton x=10 y=227 width=115 height=48
    - `asset.quickbuy.ShopBuyFrameAddBtnBg` · bitmap 115×48 (quickbuy.swf)
    - `asset.quickbuy.ShopBuyFrameAddBtnText` · bitmap 91×35 (quickbuy.swf)
  - `quickbuy.BuyBaseItemView` · BaseItemView x=34 y=47
    - `quickbuy.BuyBaseItemViewIcon` · BaseIconView x=3 y=3
      - `asset.core.IconLoading` · sprite 42 frames (core2.swf)
    - `core.GoodsProfileBG` · ScaleFrameImage 
      - `asset.core.BagProfileGreen` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileBlue` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfilePurple` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileOrange` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileRed` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileBlackKing` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileFashion` · bitmap 45×45 (core.swf)
    - `core.goods.Strengthen` · MovieImage x=-50 y=-50
      - `asset.core.goods.Strengthen` · Strengthen 
    - `quickbuy.BaseItemText` · FilterFrameText x=26 y=44 ← `core.BaseItemText`
  - `quickbuy.AddButton` · BaseButton x=188 y=163 width=22 height=21
    - `asset.core.UpButton` · bitmap 22×21 (core2.swf)
  - `quickbuy.DeleteButton` · BaseButton x=215 ← `quickbuy.AddButton`
    - `asset.core.DownButton` · bitmap 22×21 (core2.swf)
  - `quickbuy.BuyNumTextStyle` · FilterFrameText x=100 y=163 width=76 height=20 font `Arial,14,0xfffd7d,true,,,,,center`
  - `quickbuy.ShopPayType` · ScaleFrameImage y=134
    - `asset.core.SmallPointImg` · bitmap x=0
      - `asset.core.SmallPointImg` · bitmap 23×21 (bottle.swf)
    - `asset.core.SmallGiftImg` · bitmap 
      - `asset.core.SmallGiftImg` · bitmap 23×21 (core.swf)
    - `asset.core.SmallGoldIcon` · bitmap 21×21 (core.swf)
    - `asset.core.contributionImg` · bitmap 
      - `asset.core.contributionImg` · bitmap 89×21 (core.swf)
    - `asset.core.medalImg` · bitmap 
      - `asset.core.medalImg` · bitmap 60×19 (core.swf)
    - `asset.core.MazeCoinlImg` · bitmap 79×29 (core.swf)
    - `asset.core.AresHeart` · bitmap 24×24 (core.swf)
    - `asset.core.BackPLayer` · bitmap 26×21 (core.swf)
    - `asset.core.sealOfKing` · bitmap 24×25 (core.swf)
    - `asset.core.sealOfKing` · bitmap 24×25 (core.swf)
    - `asset.core.LeagueMedalIcon` · bitmap 23×26 (core.swf)
    - `asset.core.guild` · bitmap x=-7 y=-8
      - `asset.core.guild` · bitmap 34×36 (core.swf)
    - `asset.core.AthenaTear` · bitmap 17×24 (core.swf)
    - `asset.core.pokerScoreIcon` · bitmap 22×22 (core.swf)
    - `asset.core.outyardImg` · bitmap 21×22 (core.swf)
    - `quickbuy.redCrystalImg` · Image x=0 y=-4
      - `asset.core.redCrystalImg` · bitmap 26×26 (core.swf)
    - `asset.shop.glory` · bitmap 22×22 (core.swf)
    - `asset.core.YellowIcon` · bitmap 24×24 (core.swf)
    - `asset.core.isLandExploreMedal` · bitmap 20×26 (core.swf)
    - `asset.core.assaultwarMedal` · bitmap 25×25 (core.swf)
    - `asset.core.pumpingJoyCoupon` · bitmap 25×25 (core.swf)
    - `shop.GodsMarking` · Image x=2 y=-8
      - `asset.common.GodsMarking` · bitmap 27×30 (common.swf)
    - `asset.core.copyConsortiaImg` · bitmap 29×32 (core.swf)
    - `asset.core.apex.money` · bitmap 22×27 (core.swf)
    - `asset.core.crossGuildCoin` · bitmap 22×20 (core.swf)
    - `asset.core.antaeus.icon1` · bitmap 22×21 (core.swf)
    - `asset.core.airGardenPropIconImage` · bitmap 30×30 (core.swf)
    - `asset.core.flameTempleIconImage` · bitmap 18×23 (core.swf)
    - `asset.core.duskAreaIconImage` · bitmap 18×24 (core.swf)
    - `quickbuy.demonroadShopCoin` · Image x=-1 y=-6
      - `asset.core.demonroadShopCoin` · bitmap 49×49 (core.swf)
    - `asset.core.darkMazeCoin` · bitmap 22×20 (core.swf)
    - `asset.core.consortianewboss.icon` · bitmap x=0 y=-5
      - `asset.core.consortianewboss.icon` · bitmap 30×30 (core.swf)
    - `asset.core.theseuspvp.fighticon` · bitmap 30×30 (core.swf)
    - `asset.core.yeargoldIcon` · bitmap 31×30 (core.swf)
    - `asset.core.yearboxkeyicon` · bitmap 29×31 (core.swf)
    - `asset.core.minosCoin` · bitmap 25×32 (core.swf)
    - `asset.core.chesspvpCoin` · bitmap 34×34 (core.swf)
    - `asset.core.childnswarIcon` · bitmap 30×30 (core.swf)
    - `asset.vipShopView.CurrencyIcon` · bitmap 22×24 (core.swf)
  - `quickbuy.BuyGoodsNameStyle` · FilterFrameText x=113 y=39 width=168 height=60 font `Arial,14,0xeae1c9,,,,,,left`
  - `quickbuy.TotalPriceTextStyle` · FilterFrameText x=96 y=134 width=124 height=20 font `Arial,14,0xddcda0,true,,,,,left`
  - `quickbuy.BuyCanTotalTextStyle` · FilterFrameText x=115 y=75 font `Arial,12,0xffe49c,,,,,,left`
  - `quickbuy.BuyCanTotalValueTextStyle` · FilterFrameText x=200 y=74 font `Arial,14,0xffe49c,true,,,,,left`
  - `quickbuy.BuyCanOneTextStyle` · FilterFrameText x=110 y=99 width=130 height=40 font `Arial,12,0xffe49c,,,,,,left`
  - `quickbuy.BuyCanOneValueTextStyle` · FilterFrameText x=153 y=98 font `Arial,14,0xffe49c,true,,,,,left`
  - `quickbuy.useBindPointBtn` · SelectedCheckButton x=38 y=185
    - `asset.core.checkstyle_2.UnSelected` · bitmap 22×23 (core2.swf)
    - `asset.core.checkstyle_2.Selected` · sprite (core2.swf)
    - `quickbuy.usebindPointTxt` · FilterFrameText  font `Arial,12,0xfffeac,,,,,,center`
  - `quickbuy.useBindPoint_notJoinActTxt` · FilterFrameText x=30 y=210 ← `core.useBindPoint_notJoinActTxt`
  - `quickbuy.ActiveStateTextStyle` · FilterFrameText x=220 y=113 ← `shop.ActiveStateTextStyle`
  - `yishi.view.frame.discount.discountui` · DiscountUI x=283 y=1
  - `shop.GiftDonatioFrame` · GiftDonatioFrame width=385 height=196 ← `shop.PresentFrame`
  - `campaign.TrailShop.BuyBtnTxt` · GradientText 
    - `campaign.TrailShop.BuyBtnTxt2` · FilterFrameText width=46 height=20 font `Arial,12,0xecc200,,,,,,center`
  - texts: `view.GoodsItem3.ActiveState.text` “Ativado”; `yishi.view.frame.BuyFrameI.priorityUse` “Diamante vinculado prioritário”; `mainBar.view.VipCoolDownFrame.promptTxt` “(Não participa no evento de consumo)”; `campaign.TrailShop.BuyBtnTxt` “Comprar”; `view.shopFrame.buyFrameI.addToShopCart.full` “Carrinho está cheio”; `view.shopFrame.buyFrameI.addToShopCart.same` “O item já foi adicionado ao carrinho”; `shop.view.frame.BuyFrameI.mopupexitst2` “já ativou o espírito da fera, não pode adicionar ao carrinho”; `view.ShopFrame.buyFrameI.addToShopCart.Success` “Adicionado com sucesso”
  - subviews: `BaseItemView`, `DiscountUI`, `GiftDonatioFrame`

### yishi.view.frame.CacheTipFrame

- **CacheTipFrame** (`core_module:yishi/view/frame/CacheTipFrame.as`)
  - `asset.loading.CacheMcAsset` · CacheMcAsset 
  - subviews: `CacheMcAsset`

### yishi.view.frame.CasernRecruitFrame

- **CasernRecruitFrame**: “Recrutar” (`core_module:yishi/view/frame/CasernRecruitFrame.as`)
  - `core.RecruitFrame` · CasernRecruitFrame width=397 height=299 ← `core.Frame1`
    - `core.RecruitFrameBack` · MutipleImage 
      - `core.FrameBackgoundBase1` · Scale9CornerImage 
        - `asset.core.style01_scale9bg1` · bitmap 224×100 (framebg.swf)
        - `asset.core.style01_scale9bg2` · bitmap 50×100 (framebg.swf)
        - `asset.core.style01_scale9bg3` · bitmap 224×100 (framebg.swf)
        - `asset.core.style01_scale9bg4` · bitmap 224×50 (framebg.swf)
        - `asset.core.style01_scale9bg5` · bitmap 50×50 (framebg.swf)
        - `asset.core.style01_scale9bg6` · bitmap 224×50 (framebg.swf)
        - `asset.core.style01_scale9bg7` · bitmap 224×100 (framebg.swf)
        - `asset.core.style01_scale9bg8` · bitmap 50×100 (framebg.swf)
        - `asset.core.style01_scale9bg9` · bitmap 224×100 (framebg.swf)
      - `core.FrameTitleImage1` · Image width=362 height=43
        - `asset.core.frameTitleImage1` · bitmap 243×19 (framebg.swf)
      - `core.FameBottomImage` · ScaleLeftRightImage 
        - `asset.core.style01_Bottom1` · bitmap 29×53 (framebg.swf)
        - `asset.core.style01_Bottom2` · bitmap 29×53 (framebg.swf)
        - `asset.core.style01_Bottom3` · bitmap 29×53 (framebg.swf)
  - `core.RecruitBack` · ScaleBitmapImage x=3 y=4 width=357 height=134 ← `core.describeBackground_style04`
  - `asset.core.expandingImg` · bitmap x=92 y=20
    - `asset.core.expandingImg` · bitmap 40×106 (core.swf)
  - `asset.core.headFrameImg` · bitmap x=30 y=27
    - `asset.core.headFrameImg` · bitmap 70×69 (core.swf)
  - `asset.core.RecruitInputBack` · bitmap x=245 y=91
    - `asset.core.RecruitInputBack` · bitmap 82×29 (core.swf)
  - `core.RecruitRequiredTitle` · FilterFrameText x=148 y=26 font `Arial,14,0xD6B16B,true,,,,,center`
  - `core.RectruitGoldIcon` · ScaleBitmapImage x=284 y=25 width=26 height=29
    - `asset.resourcesBar.GoldIcoImg` · bitmap 
      - `asset.resourcesBar.GoldIcoImg` · bitmap 26×29 (resourcesbar.swf)
  - `core.RectuitGoldTxt` · FilterFrameText x=239 y=27 font `Arial,14,0xf9f1ad,true`
  - `core.RecruitHSilder` · Silder x=147 y=55 width=201 height=26 ← `core.HSilder`
    - `core.RecruitHSilderBg` · ScaleBitmapImage width=201 height=15
      - `asset.core.RecruitHSilderBgImg` · bitmap 201×15 (core.swf)
    - `core.RecruitHSilderStepBtn` · BaseButton  ← `core.HSilderStepBtn`
  - `core.RequiredAmount` · FilterFrameText x=144 y=95 font `Arial,14,0xD6B16B,true,,,,,center`
  - `core.RequiredNum` · FilterFrameText x=250 y=96 width=75 height=20 font `Arial,14,0xf9f1ad,true`
  - `core.RectuitOkBtn` · SelectedCheckButton x=56 y=152 ← `core.AlertButton`
  - `core.RectuitCancelBtn` · SelectedCheckButton x=213 ← `core.RectuitOkBtn`
  - `core.PawnIcon` · BaseIconView x=35 y=30
    - `asset.core.IconLoading` · sprite 42 frames (core2.swf)
  - `core.RecruitPawnTitle` · FilterFrameText x=20 y=100 width=95 height=40 font `Arial,14,0xD6B16B,true,,,,,center`
  - texts: `buildings.casern.view.CasernRecruitFrame.title` “Recrutar”; `buildings.casern.view.CasernRecruitFrame.recruitRequiredTitle` “Necessário”; `buildings.casern.view.CasernRecruitFrame.requiredAmount` “Quantidade”; `public.confirm` “Confirmar”; `public.cancel` “Cancelar”; `buildings.casern.view.CasernRecruitFrame.recruitPawnTitle` “Lanceiro”
  - subviews: `BaseIconView`

### yishi.view.frame.ChangeHeadIconFrame

- **ChangeHeadIconFrame**: “Selecionar Retrato” (`core_module:yishi/view/frame/ChangeHeadIconFrame.as`)
  - `core.ChangeHeadIconFrame` · ChangeHeadIconFrame width=490 height=390 ← `core.Frame2`
  - `core.SelectHeadTxt` · FilterFrameText x=8 y=-3 font `Arial,12,0xfda72c`
  - `core.ChangeHeadIconBg` · ScaleBitmapImage x=-14 y=21 width=445 height=225 ← `core.describeBackground_style04`
  - `core.HeadIconContainer` · SimpleTileList x=2 y=28
  - `core.HeadIconScroll` · ScrollPanel x=2 y=28 width=298 height=211
    - `chatII.ChatOutputScrollbar` · Scrollbar x=5 y=3 height=102 ← `core.VScrollbar03`
  - `asset.core.ChangeHeadIconLine` · bitmap x=298 y=16
    - `asset.core.ChangeHeadIconLine` · bitmap 1×239 (core.swf)
  - `core.PreviewTxt` · FilterFrameText x=307 y=40 ← `core.SelectHeadTxt`
  - `core.PreviewSmallIconCell` · HeadIconCell x=342 y=68
    - `core.PreviewSmallIconCellBack` · ScaleBitmapImage width=45 height=45 ← `core.ItemBack`
    - `core.PreviewSmallIcon` · BaseIconView 
      - `asset.core.IconLoading` · sprite 42 frames (core2.swf)
  - `core.PreviewBigIconCell` · HeadIconCell x=317 y=133 ← `core.PreviewSmallIconCell`
    - `core.PreviewBigIconCellBack` · ScaleBitmapImage 
      - `asset.core.PawnBack1` · bitmap 96×96 (core.swf)
    - `core.PreviewBigIcon` · BaseIconView  ← `core.PreviewSmallIcon`
  - `core.ChangeHeadIconConfirmBtn` · TextButton x=132 y=256 width=75 height=31
    - `asset.core.Style14Btn` · bitmap 75×31 (core2.swf)
    - `core.ChangeHeadIconConfirmBtnTxt` · FilterFrameText  font `Arial,12,0xecdfa1`
  - `core.ChangeHeadIconCancleBtn` · TextButton x=237 y=256 ← `core.ChangeHeadIconConfirmBtn`
  - `core.HeadIconCell` · HeadIconCell  ← `core.PreviewSmallIconCell`
    - `core.HeadCellOverImg` · Image x=-7 y=-7
      - `asset.core.HeadCellOver` · bitmap 59×59 (core.swf)
  - `core.HeadIconCell` · HeadIconCell  ← `core.PreviewSmallIconCell`
    - `core.HeadCellOverImg` · Image x=-7 y=-7
      - `asset.core.HeadCellOver` · bitmap 59×59 (core.swf)
  - `core.HeadIconCell` · HeadIconCell  ← `core.PreviewSmallIconCell`
    - `core.HeadCellOverImg` · Image x=-7 y=-7
      - `asset.core.HeadCellOver` · bitmap 59×59 (core.swf)
  - texts: `yishi.view.ChangeHeadIconFrame.title` “Selecionar Retrato”; `yishi.view.ChangeHeadIconFrame.select` “Selecionar”; `yishi.view.ChangeHeadIconFrame.preview` “Visualização:”; `public.confirm` “Confirmar”; `public.cancel` “Cancelar”
  - subviews: `HeadIconCell`

### yishi.view.frame.ChatInvieAlert

- **ChatInvieAlert** (`core_module:yishi/view/frame/ChatInvieAlert.as`)
  - `ChatInvieAlertStyle` · ChatInvieAlert 
    - `core.AlertButtonConfirm_1` · IconButton width=96 height=40
      - `asset.core.AlertBtnStyle_01` · bitmap 96×40 (core2.swf)
      - `asset.core.ConfirmTxtAsset_01` · bitmap 81×17 (core2.swf)
    - `core.AlertButtonCancel_1` · IconButton  ← `core.AlertButtonConfirm_1`
      - `asset.core.CancelTxtAsset_01` · bitmap 75×18 (core2.swf)
    - `core.AlertSmallTipTxt` · FilterFrameText  font `Arial,12,0xfff600,,,,,,center`
    - `core.FrameTitleText` · FilterFrameText  font `Arial,14,0xFFDD83,true`
    - `core.AlertTextStyle` · FilterFrameText width=91 height=20 font `Arial,14,0xFFefbd,,,,,,center`
    - `core.quickBuyFrameBg` · MutipleImage 
      - `core.AlertFrameBg` · MutipleImage 
        - `core.AlertFrameBaseBg` · Scale9CornerImage 
          - `asset.core.framestyle03_scale9bg1` · bitmap 42×42 (framebg.swf)
          - `asset.core.framestyle03_scale9bg2` · bitmap 42×42 (framebg.swf)
          - `asset.core.framestyle03_scale9bg3` · bitmap 42×42 (framebg.swf)
          - `asset.core.framestyle03_scale9bg4` · bitmap 42×18 (framebg.swf)
          - `asset.core.framestyle03_scale9bg5` · bitmap 42×18 (framebg.swf)
          - `asset.core.framestyle03_scale9bg6` · bitmap 42×18 (framebg.swf)
          - `asset.core.framestyle03_scale9bg7` · bitmap 42×42 (framebg.swf)
          - `asset.core.framestyle03_scale9bg8` · bitmap 42×42 (framebg.swf)
          - `asset.core.framestyle03_scale9bg9` · bitmap 42×42 (framebg.swf)
      - `core.FrameTitleImage2` · Image width=229 height=17
        - `asset.core.frameTitleImage2` · bitmap 229×17 (framebg.swf)
    - `core.useBindPointBtn` · SelectedCheckButton 
      - `asset.core.checkstyle_2.UnSelected_1` · Image 
        - `asset.core.checkstyle_2.UnSelected` · bitmap 22×23 (core2.swf)
      - `asset.core.checkstyle_2.Selected_1` · Image 
        - `asset.core.checkstyle_2.Selected` · sprite (core2.swf)
      - `core.ThewCheckTxt_2` · FilterFrameText  font `Arial,12,0xe7c88b,,,,,,center`
  - texts: `room.view.pve.RoomRightView.alertConent` “Utilizar a quantidade de ganhos diária”

### yishi.view.frame.ChildSexFrame

- **ChildSexFrame**: “Aviso” (`core_module:yishi/view/frame/ChildSexFrame.as`)
  - `yishi.view.frame.ChildSexFrame` · ChildSexFrame width=385 height=185
    - `core.quickBuyFrameBg` · MutipleImage 
      - `core.AlertFrameBg` · MutipleImage 
        - `core.AlertFrameBaseBg` · Scale9CornerImage 
          - `asset.core.framestyle03_scale9bg1` · bitmap 42×42 (framebg.swf)
          - `asset.core.framestyle03_scale9bg2` · bitmap 42×42 (framebg.swf)
          - `asset.core.framestyle03_scale9bg3` · bitmap 42×42 (framebg.swf)
          - `asset.core.framestyle03_scale9bg4` · bitmap 42×18 (framebg.swf)
          - `asset.core.framestyle03_scale9bg5` · bitmap 42×18 (framebg.swf)
          - `asset.core.framestyle03_scale9bg6` · bitmap 42×18 (framebg.swf)
          - `asset.core.framestyle03_scale9bg7` · bitmap 42×42 (framebg.swf)
          - `asset.core.framestyle03_scale9bg8` · bitmap 42×42 (framebg.swf)
          - `asset.core.framestyle03_scale9bg9` · bitmap 42×42 (framebg.swf)
      - `core.FrameTitleImage2` · Image width=229 height=17
        - `asset.core.frameTitleImage2` · bitmap 229×17 (framebg.swf)
    - `core.FrameTitleText` · FilterFrameText  font `Arial,14,0xFFDD83,true`
    - `core.AlertTextStyle1` · FilterFrameText  font `Arial,14,0xFFefbd,,,,,,left` ← `core.AlertTextStyle`
  - `ChildSexFrame.describeTxt` · FilterFrameText x=0 y=0 width=370 height=20 font `Arial,14,0xfff9b9,,,,,,left`
  - `ChildSexFrame.confirmBtn` · IconButton x=115 y=79 ← `core.AlertButtonConfirm_1`
    - `asset.core.AlertBtnStyle_02` · bitmap 96×40 (core2.swf)
  - `ChildSexFrame.selectedBtn` · SelectedTextButton 
    - `asset.core.checkstyle_1.UnSelected` · bitmap 22×22 (core2.swf)
    - `asset.core.checkstyle_1.Selected` · bitmap 22×22 (core2.swf)
    - `ChildSexFrame.selectedTxt` · FilterFrameText width=50 height=22 font `Arial,12,0xfff9b9,,,,,,left`
  - texts: `public.prompt1` “Aviso”; `yishi.view.frame.ChildSexFrame.describeTxt` “O poder da maça de ouro pode fazer com que você obtenha a op”; `yishi.view.frame.ChildSexFrame.selectTxt` “Feminino, Masculino, Dragão Fênix”; `cell.mediator.playerbag.PlayerBagCellClickMediator.command10` “Não tem Guardião, não é possível usar”
  - subviews: `HBox`

### yishi.view.frame.ConfirmSellFrame

- **ConfirmSellFrame**: “Aviso” (`core_module:yishi/view/frame/ConfirmSellFrame.as`)
  - `core.ConfirmSellFrame` · ConfirmSellFrame width=340 height=196 ← `core.Frame2`
    - `core.quickBuyFrameBg` · MutipleImage 
      - `core.AlertFrameBg` · MutipleImage 
        - `core.AlertFrameBaseBg` · Scale9CornerImage 
          - `asset.core.framestyle03_scale9bg1` · bitmap 42×42 (framebg.swf)
          - `asset.core.framestyle03_scale9bg2` · bitmap 42×42 (framebg.swf)
          - `asset.core.framestyle03_scale9bg3` · bitmap 42×42 (framebg.swf)
          - `asset.core.framestyle03_scale9bg4` · bitmap 42×18 (framebg.swf)
          - `asset.core.framestyle03_scale9bg5` · bitmap 42×18 (framebg.swf)
          - `asset.core.framestyle03_scale9bg6` · bitmap 42×18 (framebg.swf)
          - `asset.core.framestyle03_scale9bg7` · bitmap 42×42 (framebg.swf)
          - `asset.core.framestyle03_scale9bg8` · bitmap 42×42 (framebg.swf)
          - `asset.core.framestyle03_scale9bg9` · bitmap 42×42 (framebg.swf)
      - `core.FrameTitleImage2` · Image width=229 height=17
        - `asset.core.frameTitleImage2` · bitmap 229×17 (framebg.swf)
  - `asset.core.ConfirmSellIcon` · bitmap x=-23 y=0
    - `asset.core.ConfirmSellIcon` · bitmap 46×41 (core.swf)
  - `core.ConfirmSellContent` · FilterFrameText x=42 y=-17 width=260 height=56 font `Arial,14,0xe7c88b,,,,,,left`
  - `core.ConfirmSellInputBack` · ScaleBitmapImage x=70 y=40 width=126 height=23
    - `asset.core.ConfirmSellInputBack` · bitmap 46×23 (core2.swf)
  - `core.ConfirmSellInputTxt` · FilterFrameText x=75 y=44 width=115 height=24 font `Arial,14,0xfed205,,,,,,center`
  - `core.ConfitmSellConfitmBtn` · IconButton x=5 y=81 ← `core.AlertButtonConfirm_2`
    - `asset.core.ConfirmTxtAsset_01` · bitmap 81×17 (core2.swf)
  - `core.ConfitmSellCancelBtn` · IconButton x=165 y=81 ← `core.AlertButtonConfirm_1`
    - `asset.core.CancelTxtAsset_01` · bitmap 75×18 (core2.swf)
  - texts: `public.prompt` “Aviso”; `yishi.view.ConfirmSellFrame.inputNull` “Entrada em branco”; `yishi.view.ConfirmSellFrame.inputWrong` “Erro de entrada, digite novamente”

### yishi.view.frame.ConsortiaEmeDreamRewardFrame

- **ConsortiaEmeDreamRewardFrame**: “Prêmios da Terra dos Sonhos” (`core_module:yishi/view/frame/ConsortiaEmeDreamRewardFrame.as`)
  - `consortia.consortiaEmeDream.ConsortiaEmeDreamRewardFrame` · ConsortiaEmeDreamRewardFrame width=355 height=285 ← `core.Frame2`
  - `ConsortiaBossRewardFrame.outerBorder` · ScaleBitmapImage x=-15 y=5 width=325 height=191 ← `core.describeBackground_style04`
  - `asset.ConsortiaBossRewardFrame.back` · bitmap x=-12 y=9
    - `asset.ConsortiaBossRewardFrame.back` · bitmap 318×183 (core.swf)
  - `ConsortiaBossRewardFrame.innerBorder` · ScaleBitmapImage x=5 y=20 width=280 height=130 ← `core.describeBackground_style04`
  - `ConsortiaBossRewardFrame.winTitleText` · FilterFrameText x=20 y=25 width=100 height=20 font `Arial,14,0xffbc5d,,,,,,left`
  - `ConsortiaBossRewardFrame.lostTitleText` · FilterFrameText x=20 y=85 width=100 height=20 font `Arial,14,0xffbc5d,,,,,,left`
  - `ConsortiaBossRewardFrame.winGoodsHbox` · HBox x=170 y=25
  - `ConsortiaBossRewardFrame.lostGoodsHbox` · HBox x=165 y=85
  - `ConsortiaBossRewardFrame.sureBtn` · IconButton x=90 y=150
    - `asset.ConsortiaBossRewardFrame.sureBtnTxt` · bitmap 91×20 (core.swf)
    - `asset.core.ButtonStyle_02` · bitmap 114×42 (core2.swf)
  - `ConsortiaBossRewardFrame.baseItem` · BaseItemView 
    - `core.BaseItemViewIcon` · BaseIconView x=1 y=1
      - `asset.core.IconLoading` · sprite 42 frames (core2.swf)
    - `core.BaseItemText` · FilterFrameText x=0 y=26 width=45 height=18 font `Arial,12,0xffffff,true,,,,,right`
    - `core.GoodsProfileBG` · ScaleFrameImage 
      - `asset.core.BagProfileGreen` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileBlue` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfilePurple` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileOrange` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileRed` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileBlackKing` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileFashion` · bitmap 45×45 (core.swf)
  - `ConsortiaBossRewardFrame.baseItem` · BaseItemView 
    - `core.BaseItemViewIcon` · BaseIconView x=1 y=1
      - `asset.core.IconLoading` · sprite 42 frames (core2.swf)
    - `core.BaseItemText` · FilterFrameText x=0 y=26 width=45 height=18 font `Arial,12,0xffffff,true,,,,,right`
    - `core.GoodsProfileBG` · ScaleFrameImage 
      - `asset.core.BagProfileGreen` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileBlue` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfilePurple` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileOrange` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileRed` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileBlackKing` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileFashion` · bitmap 45×45 (core.swf)
  - texts: `ConsortiaBossRewardFrame.winTitleText.text` “Desafiar com sucesso:”; `ConsortiaBossRewardFrame.lostTitleText.text` “Fracasso desafiando:”; `consortia.view.myConsortia.activity.ConsortiaActivityListView.consortiaEmeDreamReward.title` “Prêmios da Terra dos Sonhos”
  - subviews: `BaseItemView`

### yishi.view.frame.FurnitureShopBuyFrame

- **FurnitureShopBuyFrame**: “Comprar” (`core_module:yishi/view/frame/FurnitureShopBuyFrame.as`)
  - `quickbuy.FurnitureShopBuyFrame` · FurnitureShopBuyFrame width=271 height=330
    - `core.FrameTitleText` · FilterFrameText  font `Arial,14,0xFFDD83,true`
    - `core.quickBuyFrameBg` · MutipleImage 
      - `core.AlertFrameBg` · MutipleImage 
        - `core.AlertFrameBaseBg` · Scale9CornerImage 
          - `asset.core.framestyle03_scale9bg1` · bitmap 42×42 (framebg.swf)
          - `asset.core.framestyle03_scale9bg2` · bitmap 42×42 (framebg.swf)
          - `asset.core.framestyle03_scale9bg3` · bitmap 42×42 (framebg.swf)
          - `asset.core.framestyle03_scale9bg4` · bitmap 42×18 (framebg.swf)
          - `asset.core.framestyle03_scale9bg5` · bitmap 42×18 (framebg.swf)
          - `asset.core.framestyle03_scale9bg6` · bitmap 42×18 (framebg.swf)
          - `asset.core.framestyle03_scale9bg7` · bitmap 42×42 (framebg.swf)
          - `asset.core.framestyle03_scale9bg8` · bitmap 42×42 (framebg.swf)
          - `asset.core.framestyle03_scale9bg9` · bitmap 42×42 (framebg.swf)
      - `core.FrameTitleImage2` · Image width=229 height=17
        - `asset.core.frameTitleImage2` · bitmap 229×17 (framebg.swf)
  - `quickbuy.SelfBuyFrameBack` · MutipleImage 
    - `asset.quickbuy.BuyFrameBaseBack` · bitmap 268×281 (quickbuy.swf)
    - `asset.quickbuy.BuyPriceText` · bitmap x=10 y=133
      - `asset.quickbuy.BuyPriceText` · bitmap 88×25 (quickbuy.swf)
    - `asset.quickbuy.BuyNumText` · bitmap x=10 y=162
      - `asset.quickbuy.BuyNumText` · bitmap 94×28 (quickbuy.swf)
    - `quickbuy.BuyInputBg` · Image x=96 y=159
      - `asset.core.TextInputBG2` · bitmap 87×30 (core2.swf)
  - `quickbuy.SelfSelectedBackBtn` · SelectedIconButton x=24 y=11 width=100 height=26
    - `asset.quickbuy.Buycheckstyle_2.UnSelected` · bitmap 18×18 (quickbuy.swf)
    - `asset.quickbuy.Buycheckstyle_2.Selected` · bitmap 18×18 (quickbuy.swf)
    - `asset.quickbuy.unselectedBackTxt` · bitmap 81×23 (quickbuy.swf)
    - `asset.quickbuy.unselectedBackTxt` · bitmap 81×23 (quickbuy.swf)
  - `quickbuy.selfConfirmBtn` · IconButton x=129 y=230 width=134 height=45
    - `asset.quickbuy.ShopBuyFrameBuyBtnBg` · bitmap 115×48 (quickbuy.swf)
    - `asset.quickbuy.ShopBuyFrameBuyBtnText` · bitmap 76×17 (quickbuy.swf)
  - `quickbuy.AddButton` · BaseButton x=188 y=163 width=22 height=21
    - `asset.core.UpButton` · bitmap 22×21 (core2.swf)
  - `quickbuy.DeleteButton` · BaseButton x=215 ← `quickbuy.AddButton`
    - `asset.core.DownButton` · bitmap 22×21 (core2.swf)
  - `quickbuy.BuyNumTextStyle` · FilterFrameText x=100 y=163 width=76 height=20 font `Arial,14,0xfffd7d,true,,,,,center`
  - `FurnitureShopBuyFrame.ShopPayType` · ScaleFrameImage y=134
    - `asset.core.EternalCrystal` · bitmap 26×26 (core.swf)
  - `quickbuy.BuyGoodsNameStyle` · FilterFrameText x=113 y=39 width=168 height=60 font `Arial,14,0xeae1c9,,,,,,left`
  - `quickbuy.TotalPriceTextStyle` · FilterFrameText x=96 y=134 width=124 height=20 font `Arial,14,0xddcda0,true,,,,,left`
  - `quickbuy.BuyCanTotalTextStyle` · FilterFrameText x=115 y=75 font `Arial,12,0xffe49c,,,,,,left`
  - `quickbuy.BuyCanTotalValueTextStyle` · FilterFrameText x=200 y=74 font `Arial,14,0xffe49c,true,,,,,left`
  - `FurnitureShopBuyFrame.hasCountText` · FilterFrameText x=115 y=100 font `Arial,12,0xffe49c,,,,,,center`
  - `FurnitureShopBuyFrame.FurnitureBagCell` · FurnitureBagCell x=32 y=50
    - `FurnitureShopBuyFrame.FurnitureBagCellBack` · ScaleBitmapImage width=70 height=70 ← `core.goods.ItemBack2`
    - `FurnitureShopBuyFrame.FurnitureBagCellIcon` · BaseIconView 
      - `asset.core.IconLoading` · sprite 42 frames (core2.swf)
    - `FurnitureShopBuyFrame.FurnitureBagCellText` · FilterFrameText x=24 y=49 width=42 height=16 font `Arial,12,0xffffff,true,,,,,right`
    - `core.GoodsProfileBG` · ScaleFrameImage 
      - `asset.core.BagProfileGreen` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileBlue` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfilePurple` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileOrange` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileRed` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileBlackKing` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileFashion` · bitmap 45×45 (core.swf)
  - `campaign.TrailShop.BuyBtnTxt` · GradientText 
    - `campaign.TrailShop.BuyBtnTxt2` · FilterFrameText width=46 height=20 font `Arial,12,0xecc200,,,,,,center`
  - texts: `campaign.TrailShop.BuyBtnTxt` “Comprar”; `FurnitureShopItem.FurnitureBagCell.buyFullAlert` “Atingiu o limite não é possível comprar mais”; `FurnitureShopItem.FurnitureBagCell.tipData` “Contém:  {0}/{1}”
  - subviews: `FurnitureBagCell`

### yishi.view.frame.HookRewardFrame

- **HookRewardFrame** (`core_module:yishi/view/frame/HookRewardFrame.as`)
  - `core.HookRewardFrame` · HookRewardFrame width=304 height=345 ← `core.Frame2`
  - `core.HookRewardBack1` · ScaleBitmapImage x=0 y=0 width=265 height=275 ← `core.describeBackground_style04`
  - `asset.core.HoodRewardBack` · bitmap x=0 y=0
    - `asset.core.HoodRewardBack` · bitmap 268×257 (core.swf)
  - `core.HookTotalExpTxt` · FilterFrameText x=120 y=17 width=120 height=25 font `Arial,16,0xffde00,true,,,,,center`
  - `core.HookOffLineHourTxt` · FilterFrameText x=107 y=53 width=48 height=18 font `Arial,14,0xdecfa4,true,,,,,right`
  - `core.HookOffLineMinTxt` · FilterFrameText x=179 y=53 width=24 height=18 font `Arial,14,0xdecfa4,true,,,,,right`
  - `core.HookTotalHourTxt` · FilterFrameText x=138 y=232 width=24 height=18 font `Arial,14,0xdf0606,true,,,,,center`
  - `core.HookreceiveBtn1` · SelectedButton x=25 y=92 ← `core.checkstyle_1.CheckButton`
  - `core.HookreceiveBtn2` · SelectedButton x=25 y=123 ← `core.checkstyle_1.CheckButton`
  - `core.HookreceiveBtn3` · SelectedButton x=25 y=152 ← `core.checkstyle_1.CheckButton`
  - `core.HookreceiveBtn` · IconButton x=75 y=187 width=114 height=42
    - `asset.core.HookReceiveBack` · bitmap 116×42 (core2.swf)
    - `asset.core.HookReceiveTxt` · bitmap 66×19 (core2.swf)
  - texts: `yishi.view.HookRewardFrame.command01` “Não há valor de experiência a ser obtido”

### yishi.view.frame.InviteFrame

- **InviteFrame** (`core_module:yishi/view/frame/InviteFrame.as`)
  - `core.InviteFrame` · InviteFrame x=546 y=131 width=330 height=120
  - `core.InviteFrameBack1` · Scale9CornerImage x=0 y=0 width=330 height=120 ← `core.describeBackground_style11`
  - `core.InviteFrameBack2` · Scale9CornerImage x=3 y=3 width=324 height=114 ← `core.describeBackground_style16`
  - `asset.core.invite.TitleBg` · bitmap x=2 y=3
    - `asset.core.invite.TitleBg` · bitmap 324×24 (core.swf)
  - `core.RoomInviteTitleText` · FilterFrameText x=8 y=6 font `Arial,12,0xe2b414`
  - `core.RoomInviteTime` · TimeDownView x=231 y=5
    - `core.RoomInviteTimeText` · FilterFrameText x=3 y=0 width=75 height=20 font `Arial,14,0xf9f1ad,true`
  - `core.RoomInviteContent` · FilterFrameText x=10 y=44 width=310 height=65 font `Arial,14,0xd8c493,,,,,,center`
  - `core.RoomInviteConfirm` · IconButton x=70 y=80
    - `asset.core.Style10Btn` · bitmap 77×26 (core2.swf)
    - `asset.core.invite.ConfirmBtnImg` · bitmap 53×20 (core.swf)
  - `core.RoomInviteCancel` · IconButton x=183 y=80 ← `core.RoomInviteConfirm`
    - `asset.core.invite.CancleBtnImg` · bitmap 63×20 (core.swf)
  - `core.RoomInviteClose` · BaseButton x=309 y=-5 ← `core.CloseBtn`
  - `core.useBindPointBtn` · SelectedCheckButton 
    - `asset.core.checkstyle_2.UnSelected_1` · Image 
      - `asset.core.checkstyle_2.UnSelected` · bitmap 22×23 (core2.swf)
    - `asset.core.checkstyle_2.Selected_1` · Image 
      - `asset.core.checkstyle_2.Selected` · sprite (core2.swf)
    - `core.ThewCheckTxt_2` · FilterFrameText  font `Arial,12,0xe7c88b,,,,,,center`
  - `core.TodayNotAlertFrame` · TodayNotAlertFrame width=400 height=193 ← `core.Frame2`
    - `core.AlertConfirmBtn_3` · SelectedCheckButton x=30 y=89 ← `core.AlertConfirmBtn_2`
    - `core.AlertButton_3` · SelectedCheckButton x=195 y=89 ← `core.AlertButton_2`
    - `core.ThewCheckBtn` · SelectedCheckButton x=109 y=62
      - `asset.core.checkstyle_2.UnSelected` · bitmap 22×23 (core2.swf)
      - `asset.core.checkstyle_2.Selected` · sprite (core2.swf)
      - `core.ThewCheckTxt` · FilterFrameText width=170 font `Arial,12,0xe7c88b,,,,,,center`
    - `core.ThewDescribeTxt` · FilterFrameText x=-4 y=8 width=340 height=50 font `Arial,14,0xe7c88b,,,,,,left`
    - `core.quickBuyFrameBg` · MutipleImage 
      - `core.AlertFrameBg` · MutipleImage 
        - `core.AlertFrameBaseBg` · Scale9CornerImage 
          - `asset.core.framestyle03_scale9bg1` · bitmap 42×42 (framebg.swf)
          - `asset.core.framestyle03_scale9bg2` · bitmap 42×42 (framebg.swf)
          - `asset.core.framestyle03_scale9bg3` · bitmap 42×42 (framebg.swf)
          - `asset.core.framestyle03_scale9bg4` · bitmap 42×18 (framebg.swf)
          - `asset.core.framestyle03_scale9bg5` · bitmap 42×18 (framebg.swf)
          - `asset.core.framestyle03_scale9bg6` · bitmap 42×18 (framebg.swf)
          - `asset.core.framestyle03_scale9bg7` · bitmap 42×42 (framebg.swf)
          - `asset.core.framestyle03_scale9bg8` · bitmap 42×42 (framebg.swf)
          - `asset.core.framestyle03_scale9bg9` · bitmap 42×42 (framebg.swf)
      - `core.FrameTitleImage2` · Image width=229 height=17
        - `asset.core.frameTitleImage2` · bitmap 229×17 (framebg.swf)
    - `core.FrameTitleText` · FilterFrameText  font `Arial,14,0xFFDD83,true`
  - texts: `room.view.pve.RoomRightView.alertConent` “Utilizar a quantidade de ganhos diária”; `public.confirm` “Confirmar”; `public.cancel` “Cancelar”; `public.prompt` “Aviso”; `chat.view.ChatView.EnterMolongCampaignTips` “Abertura da invasão do dragão demóniaco, deseja entrar?”; `chat.view.ChatView.EnterCampaignTips` “A Campanha já está aberta, deseja entrar?”; `yishi.view.base.ThewAlertFrame.disclist09` “Número de entradas na Torre do Julgamento atingiu o limite，a”; `yishi.view.base.ThewAlertFrame.disclist10` “Número de entradas no Demônio Sanguinário atingiu o limite，a”
  - subviews: `TimeDownView`, `TodayNotAlertFrame`

### yishi.view.frame.LookFrame

- **LookFrame**: “Visualizar” (`core_module:yishi/view/frame/LookFrame.as`)
  - `shop.LookFrame` · LookFrame width=408 height=428 ← `core.Frame1`
    - `shop.LookFrameBg` · MutipleImage 
      - `core.FrameBackgoundBase1` · Scale9CornerImage 
        - `asset.core.style01_scale9bg1` · bitmap 224×100 (framebg.swf)
        - `asset.core.style01_scale9bg2` · bitmap 50×100 (framebg.swf)
        - `asset.core.style01_scale9bg3` · bitmap 224×100 (framebg.swf)
        - `asset.core.style01_scale9bg4` · bitmap 224×50 (framebg.swf)
        - `asset.core.style01_scale9bg5` · bitmap 50×50 (framebg.swf)
        - `asset.core.style01_scale9bg6` · bitmap 224×50 (framebg.swf)
        - `asset.core.style01_scale9bg7` · bitmap 224×100 (framebg.swf)
        - `asset.core.style01_scale9bg8` · bitmap 50×100 (framebg.swf)
        - `asset.core.style01_scale9bg9` · bitmap 224×100 (framebg.swf)
      - `core.FrameTitleImage1` · Image width=362 height=43
        - `asset.core.frameTitleImage1` · bitmap 243×19 (framebg.swf)
  - `shop.LookFrameBack` · Scale9CornerImage x=0 y=0 width=376 height=320 ← `core.describeBackground_style11`
  - `shop.HeroFigureBack` · ScaleFrameImage x=4 y=4
    - `asset.core.WarriorFigureBack` · bitmap 368×312 (playerbg.swf)
    - `asset.core.HutterFigureBack` · bitmap 368×312 (playerbg.swf)
    - `asset.core.WizardFigureBack` · bitmap 368×312 (playerbg.swf)
    - `asset.core.WarriorFigureBackVocation` · bitmap 368×312 (playerbg.swf)
    - `asset.core.HutterFigureBackVocation` · bitmap 368×312 (playerbg.swf)
    - `asset.core.WizardFigureBackVocation` · bitmap 368×312 (playerbg.swf)
  - `shop.BuyWingBtn` · IconButton x=250 y=268
    - `asset.core.HookReceiveBack` · bitmap 116×42 (core2.swf)
    - `asset.core.ItemBuyWingTxt` · bitmap 72×21 (core.swf)
  - texts: `shop.LookFrame.titleText` “Visualizar”; `shop.view.frame.BuyFrameI.buyFailed` “Falha na compra, informa??es do item atualizados”
  - subviews: `ShowAvatar`

### yishi.view.frame.NavigationInviteAssistFrame

- **NavigationInviteAssistFrame** (`core_module:yishi/view/frame/NavigationInviteAssistFrame.as`)
  - `core.NavigationInviteAssistFrame` · NavigationInviteAssistFrame x=546 y=131 width=330 height=120
  - `core.InviteFrameBack1` · Scale9CornerImage x=0 y=0 width=330 height=120 ← `core.describeBackground_style11`
  - `core.InviteFrameBack2` · Scale9CornerImage x=3 y=3 width=324 height=114 ← `core.describeBackground_style16`
  - `asset.core.invite.TitleBg` · bitmap x=2 y=3
    - `asset.core.invite.TitleBg` · bitmap 324×24 (core.swf)
  - `core.RoomInviteTitleText` · FilterFrameText x=8 y=6 font `Arial,12,0xe2b414`
  - `core.RoomInviteTime` · TimeDownView x=231 y=5
    - `core.RoomInviteTimeText` · FilterFrameText x=3 y=0 width=75 height=20 font `Arial,14,0xf9f1ad,true`
  - `NavigationInviteAssistFrame.RoomInviteContent` · FilterFrameText x=10 y=28 width=310 height=69 font `Arial,14,0xd8c493,,,,,,center`
  - `NavigationInviteAssistFrame.leftText` · FilterFrameText x=10 y=80 width=310 height=40 font `Arial,14,0xd8c493,,,,,,center`
  - `core.RoomInviteConfirm` · IconButton x=70 y=80
    - `asset.core.Style10Btn` · bitmap 77×26 (core2.swf)
    - `asset.core.invite.ConfirmBtnImg` · bitmap 53×20 (core.swf)
  - `core.RoomInviteCancel` · IconButton x=183 y=80 ← `core.RoomInviteConfirm`
    - `asset.core.invite.CancleBtnImg` · bitmap 63×20 (core.swf)
  - `core.RoomInviteClose` · BaseButton x=309 y=-5 ← `core.CloseBtn`
  - texts: `yishi.view.frame.NavigationInviteAssistFrame.titleText` “Convite de auxílio de navegação”; `navigation.NavigationInviteAssistFrame.content` “{0} convidou-o para ajudar a elevar o navio {1}pts de movime”; `navigation.NavigationInviteAssistFrame.leftAssistCount` “Chances de auxílio diário restantes:{0}”; `navigation.NavigationInviteAssistFrame.noStrength.alert` “Pontos de movimento insuficiente, não é possível auxiliar”; `navigation.NavigationInviteAssistFrame.noAssistCount.alert` “Chances de auxílio diário esgotadas”; `public.confirm` “Confirmar”; `public.cancel` “Cancelar”; `public.prompt` “Aviso”
  - subviews: `TimeDownView`

### yishi.view.frame.NewKingContractView

- **NewKingContractView** (`core_module:yishi/view/frame/NewKingContractView.as`)
  - `DragonTalkerSkillMainView.newKingContract` · NewKingContractView x=20 y=38
  - `kingcontract.openLeftTxt` · FilterFrameText height=20 font `Arial,12,0xfedd00,,,,,,center`
  - `kingcontract.kingcontractViewTxt` · FilterFrameText height=20 font `Arial,12,0x3cfe00,,,,,,center`
  - `kingcontract.openRightTxt` · FilterFrameText height=20 font `Arial,12,0xfedd00,,,,,,center`
  - texts: `kingcontract.KingcontractOpen.note1` “Habilite contrato de elfos e limpe pontos grat.”; `mainBar.view.ChoosePayTypeFrame.openVipTxt` “Habilitar”; `public.confirm` “Confirmar”; `public.cancel` “Cancelar”; `public.prompt` “Aviso”; `kingcontract.view.allBuyFrontAlert` “Necessário ativar contrato dos elfos, deseja habilitar?”

### yishi.view.frame.NewVipOpenView

- **NewVipOpenView** (`core_module:yishi/view/frame/NewVipOpenView.as`)
  - `vip.vipOpenViewTxt` · FilterFrameText x=0 y=10 width=185 height=50 font `Arial,12,0xff0b2d,,,,,,center`
  - texts: `vip.newVipOpenView.tipsData1` “Habilitando VIP{0} pode desfrutar de desconto de conversão {”; `vip.newVipOpenView.tipsData3` “VIP{0} atual pode desfrutar de recompensa: {1}”; `vip.newVipOpenView.tipsData4` “Habilitando VIP{0} aumenta as chances gratuitas: {1}”; `vip.newVipOpenView.tipsData5` “VIP{0} diminui tempo para:{1}min”; `vip.newVipOpenView.tipsData7` “Não há tempo de eclosão nas qualidades azul ou inferior”; `vip.newVipOpenView.tips1` “Habilitando VIP{0} pode desfrutar de desconto de conversão”; `vip.newVipOpenView.tips3` “Habilitando VIP{0} pode desfrutar imediatamente de prêmios e”; `vip.newVipOpenView.tips4` “Habilitando VIP{0} aumenta as chances gratuitas”

### yishi.view.frame.NumBuyFrame

- **NumBuyFrame**: “Trocar” (`core_module:yishi/view/frame/NumBuyFrame.as`)
  - `numbuy.numbuyFrame` · NumBuyFrame width=271 height=291
    - `core.FrameTitleText` · FilterFrameText  font `Arial,14,0xFFDD83,true`
    - `core.quickBuyFrameBg` · MutipleImage 
      - `core.AlertFrameBg` · MutipleImage 
        - `core.AlertFrameBaseBg` · Scale9CornerImage 
          - `asset.core.framestyle03_scale9bg1` · bitmap 42×42 (framebg.swf)
          - `asset.core.framestyle03_scale9bg2` · bitmap 42×42 (framebg.swf)
          - `asset.core.framestyle03_scale9bg3` · bitmap 42×42 (framebg.swf)
          - `asset.core.framestyle03_scale9bg4` · bitmap 42×18 (framebg.swf)
          - `asset.core.framestyle03_scale9bg5` · bitmap 42×18 (framebg.swf)
          - `asset.core.framestyle03_scale9bg6` · bitmap 42×18 (framebg.swf)
          - `asset.core.framestyle03_scale9bg7` · bitmap 42×42 (framebg.swf)
          - `asset.core.framestyle03_scale9bg8` · bitmap 42×42 (framebg.swf)
          - `asset.core.framestyle03_scale9bg9` · bitmap 42×42 (framebg.swf)
      - `core.FrameTitleImage2` · Image width=229 height=17
        - `asset.core.frameTitleImage2` · bitmap 229×17 (framebg.swf)
  - `numbuy.BuyFrameBg` · MutipleImage x=0 y=3
    - `asset.numbuy.ExchangeBg` · bitmap 268×241 (numbuy.swf)
    - `asset.numbuy.ExchangePrice` · bitmap 39×18 (numbuy.swf)
    - `asset.numbuy.PayNum` · bitmap 96×18 (numbuy.swf)
    - `asset.numbuy.ExchangeNum` · bitmap 77×21 (numbuy.swf)
    - `numbuy.BuyInputBg` · Image x=94 y=129
      - `asset.core.TextInputBG2` · bitmap 87×30 (core2.swf)
  - `numbuy.BuyGoodsNameStyle` · FilterFrameText x=95 y=25 width=148 height=40 font `Arial,14,0xeae1c9,,,,,,left`
  - `numbuy.AddButton` · BaseButton x=193 y=138 width=22 height=21
    - `asset.core.UpButton` · bitmap 22×21 (core2.swf)
  - `numbuy.DeleteButton` · BaseButton x=220 ← `numbuy.AddButton`
    - `asset.core.DownButton` · bitmap 22×21 (core2.swf)
  - `numbuy.BuyNumTextStyle` · FilterFrameText x=100 y=134 width=76 height=20 font `Arial,14,0xfffd7d,true,,,,,center`
  - `numbuy.useBindPointBtn` · SelectedCheckButton x=68 y=163
    - `asset.core.checkstyle_2.UnSelected` · bitmap 22×23 (core2.swf)
    - `asset.core.checkstyle_2.Selected` · sprite (core2.swf)
    - `numbuy.usebindPointTxt` · FilterFrameText  font `Arial,12,0xfffeac,,,,,,center`
  - `numbuy.buyBtn` · IconButton x=70 y=193
    - `asset.numbuy.AuctionShopBtnBg` · bitmap 134×45 (numbuy.swf)
    - `asset.numbuy.SureExchange` · bitmap 105×22 (numbuy.swf)
  - `numbuy.useBindPoint_notJoinActTxt` · FilterFrameText x=184 y=122 width=89 height=49 ← `core.useBindPoint_notJoinActTxt`
  - `numbuy.BuyBaseItemView` · BaseItemView x=30 y=11
    - `numbuy.BuyBaseItemViewIcon` · BaseIconView x=3 y=3
      - `asset.core.IconLoading` · sprite 42 frames (core2.swf)
    - `core.GoodsProfileBG` · ScaleFrameImage 
      - `asset.core.BagProfileGreen` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileBlue` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfilePurple` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileOrange` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileRed` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileBlackKing` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileFashion` · bitmap 45×45 (core.swf)
    - `core.goods.Strengthen` · MovieImage x=-50 y=-50
      - `asset.core.goods.Strengthen` · Strengthen 
  - `numbuy.StarShopItemIcon` · BaseIconView x=63 y=46
    - `asset.core.IconLoading` · sprite 42 frames (core2.swf)
    - `tips.StarTip` · StarTip 
  - texts: `mainBar.view.VipCoolDownFrame.promptTxt` “(Não participa no evento de consumo)”; `yishi.view.frame.NumBuyFrame.title` “Trocar”; `yishi.view.frame.BuyFrameI.priorityUse` “Diamante vinculado prioritário”; `vip.vipShop.item.tip02` “Moeda Estelar insuficiente”; `auction.view.mysteryshop.BuyGoodsItem.buyTipData2` “Ponto insuficiente”; `shop.view.frame.BuyFrameI.mopupexitst` “Fera já ativada, não é possível comprar.”
  - subviews: `HBox`, `BaseIconView`, `BaseItemView`, `PriceItem`

### yishi.view.frame.PetChallengeReportFrame

- **PetChallengeReportFrame** (`core_module:yishi/view/frame/PetChallengeReportFrame.as`)
  - `petchallenge.PetChallengeReportFrame` · PetChallengeReportFrame 
  - `petchallenge.PetChallengeReportFrameBg` · MutipleImage x=0 y=0
    - `petchallenge.BgStyle01` · ScaleUpDownImage 
      - `asset.petchallenge.BgStyle01_U` · bitmap 534×100 (petchallenge.swf)
      - `asset.petchallenge.BgStyle01_M` · bitmap 534×15 (petchallenge.swf)
      - `asset.petchallenge.BgStyle01_D` · bitmap 534×20 (petchallenge.swf)
    - `asset.petchallenge.LaceStyle01` · bitmap 90×24 (petchallenge.swf)
    - `petchallenge.LaceStyle01Turn` · Image 
      - `asset.petchallenge.LaceStyle01` · bitmap 90×24 (petchallenge.swf)
    - `asset.petchallenge.PetReportTxt` · bitmap 172×45 (petchallenge.swf)
    - `asset.petchallenge.PetRankReportRewardTxt` · bitmap 97×30 (petchallenge.swf)
  - `asset.petchallenge.PetDayRankTxt` · bitmap x=164 y=38
    - `asset.petchallenge.PetDayRankTxt` · bitmap 75×30 (petchallenge.swf)
  - `asset.petchallenge.PetWeekRankTxt` · bitmap x=20 y=38
    - `asset.petchallenge.PetWeekRankTxt` · bitmap 66×37 (petchallenge.swf)
  - `petchallenge.PetChallengeReportFrameRankTxt` · FilterFrameText x=120 y=40 ← `PetChallengeInfoView.rankingLabel`
  - `petchallenge.PetChallengeReportFrame.groupName` · GradientText x=290 y=40 ← `PetChallengeInfoView.groupName`
  - `petchallenge.PetChallengeReportFrameTxt1` · FilterFrameText x=125 y=76 width=190 height=35 font `Arial,14,0xff8000`
  - `petchallenge.PetChallengeReportFrameTxt2` · FilterFrameText x=320 y=76 width=200 height=35 font `Arial,14,0xff8000`
  - `petchallenge.PetChallengeReportFrameTxt3` · FilterFrameText x=125 y=106 width=190 height=35 font `Arial,14,0xff8000`
  - `petchallenge.PetChallengeReportFrameTxt4` · FilterFrameText x=320 y=106 width=200 height=35 font `Arial,14,0xff8000`
  - `petchallenge.PetChallengeReportFrameConfirmBtn` · IconButton x=225 y=143 ← `core.AlertButtonConfirm_1`
  - `PetChallengeInfoView.rankingLabel` · FilterFrameText x=147 y=13 width=200 height=20 font `Arial,16,0xffba00,true,,,,,left`
  - texts: `PetChallengeInfoView.rankingLabel` “{0}º lugar”; `armyII.viewII.attribute.PlayerAttributeView.Not` “Nenhum”

### yishi.view.frame.PriceItem

- **PriceItem** (`core_module:yishi/view/frame/PriceItem.as`)
  - `numbuy.priceValueTextStyle` · FilterFrameText height=20 font `Arial,15,0xddcda0,true,,,,,right`
  - `asset.numbuy.diamond` · bitmap 
    - `asset.numbuy.diamond` · bitmap 20×19 (numbuy.swf)
  - `asset.numbuy.integral` · bitmap y=2
    - `asset.numbuy.integral` · bitmap 45×14 (numbuy.swf)
  - `numbuy.PetSymbolImg` · ScaleFrameImage 
    - `asset.numbuy.Money101` · bitmap 21×21 (numbuy.swf)
    - `asset.numbuy.Money102` · bitmap 21×21 (numbuy.swf)
    - `asset.numbuy.Money103` · bitmap 21×21 (numbuy.swf)
    - `asset.numbuy.Money104` · bitmap 21×21 (numbuy.swf)
    - `asset.numbuy.Money105` · bitmap 21×21 (numbuy.swf)
    - `asset.numbuy.Money106` · bitmap 21×21 (numbuy.swf)
    - `asset.numbuy.Money107` · bitmap 21×26 (numbuy.swf)
  - `asset.core.FashionPiece` · bitmap 27×26 (core.swf)
  - `asset.core.mountConversion` · bitmap 27×26 (core.swf)
  - `asset.numbuy.GemDust` · bitmap 22×24 (numbuy.swf)

### yishi.view.frame.PvpHeroFrame

- **PvpHeroFrame**: “Ranking Inter-Servidores” (`core_module:yishi/view/frame/PvpHeroFrame.as`)
  - `worldboss.PvpHeroFrame` · PvpHeroFrame width=570 height=488 ← `core.Frame1`
  - `PvpSelectFrame.FrameBack` · ScaleBitmapImage x=1 y=2 width=417 height=217 ← `core.describeBackground_style06`
  - `PvpHeroFrame.Title` · MutipleImage x=7 y=16
    - `core.TitleBack_Style05` · ScaleLeftRightImage width=406 height=34
      - `asset.core.TitleBack_Style05_L` · bitmap 23×33 (core.swf)
      - `asset.core.TitleBack_Style05_C` · bitmap 127×33 (core.swf)
      - `asset.core.TitleBack_Style05_R` · bitmap 34×33 (core.swf)
    - `asset.core.TitleBack_Style01_S` · bitmap 
      - `asset.core.TitleBack_Style01_S` · bitmap 22×28 (core.swf)
    - `asset.core.TitleBack_Style01_S` · bitmap 
      - `asset.core.TitleBack_Style01_S` · bitmap 22×28 (core.swf)
    - `asset.core.TitleBack_Style01_S` · bitmap 
      - `asset.core.TitleBack_Style01_S` · bitmap 22×28 (core.swf)
  - `PvpSortListView.TitleTxt` · FilterFrameText x=0 y=0 height=20 font `Arial,12,0xe7c88b,true,,,,,center`
  - `PvpSortListView.TitleTxt` · FilterFrameText x=0 y=0 height=20 font `Arial,12,0xe7c88b,true,,,,,center`
  - `PvpSortListView.TitleTxt` · FilterFrameText x=0 y=0 height=20 font `Arial,12,0xe7c88b,true,,,,,center`
  - `PvpSortListView.TitleTxt` · FilterFrameText x=0 y=0 height=20 font `Arial,12,0xe7c88b,true,,,,,center`
  - `PvpHeroFrame.ListPanel` · ListPanel x=9 y=51 width=525 height=270
    - `core.VScrollbar02` · Scrollbar width=21 height=200
      - `core.Scrollbar02_Back` · ScaleBitmapImage width=15 height=24
        - `asset.core.scrollbar02_bg` · bitmap 15×24 (core2.swf)
      - `core.Scrollbar02_Step` · BaseButton width=21 height=56
        - `core.scrollbar02_stepAsset` · ScaleBitmapImage width=21 height=56
          - `asset.core.scrollbar02_step` · bitmap 21×56 (core2.swf)
      - `core.Scrollbar02_Up` · BaseButton width=11 height=10
        - `asset.core.scrollbar02_up` · bitmap 11×10 (core2.swf)
      - `core.Scrollbar02_Down` · BaseButton width=11 height=10
        - `asset.core.scrollbar02_down` · bitmap 11×10 (core2.swf)
  - `worldboss.FriendList.help` · BaseButton x=392 y=23
    - `asset.core.HelpButton_01` · bitmap 26×26 (core2.swf)
  - `PvpSelectFrame.FrameBack2` · ScaleBitmapImage x=5 y=322 width=538 height=60 ← `core.describeBackground_style06`
  - `asset.sort.MySortImg` · bitmap x=13 y=17
    - `asset.sort.MySortImg` · bitmap 98×21 (sort.swf)
  - `asset.sort.SortTxtImg` · bitmap x=34 y=54
    - `asset.sort.SortTxtImg` · bitmap 33×15 (sort.swf)
  - `asset.sort.JifenTxtImg` · bitmap 54×16 (sort.swf)
  - `asset.sort.Reward` · bitmap 67×20 (sort.swf)
  - `sort.textBg1` · ScaleLeftRightImage x=56 y=49 width=82 height=27
    - `asset.sort.TxtBgLeft` · bitmap 15×27 (chesspvp.swf)
    - `asset.sort.TxtBgMiddle` · bitmap 1×27 (chesspvp.swf)
    - `asset.sort.TxtBgRight` · bitmap 15×27 (chesspvp.swf)
  - `sort.textBg2` · ScaleLeftRightImage x=231 y=49 width=82 height=27
    - `asset.sort.TxtBgLeft` · bitmap 15×27 (chesspvp.swf)
    - `asset.sort.TxtBgMiddle` · bitmap 1×27 (chesspvp.swf)
    - `asset.sort.TxtBgRight` · bitmap 15×27 (chesspvp.swf)
  - `sort.lastUpdateTimeText1` · FilterFrameText x=6 y=321 height=20 font `Arial,12,0xc08c38,,,,,,center`
  - `sort.MySortTextStyle1` · FilterFrameText x=71 y=52 width=55 height=20 font `Arial,12,0xe4d29c,,,,,,center`
  - `sort.MySortTextStyle2` · FilterFrameText x=417 y=52 width=95 height=20 font `Arial,12,0xe4d29c,,,,,,center`
  - `asset.sort.RewardIconBg` · bitmap 52×52 (sort.swf)
  - `pvpHerosFrame.RewardIconView` · BaseIconView x=485 y=329
    - `pvpHerosFrame.HtmlMultipleLineTip` · MultipleLineTip 
  - `asset.sort.RewardIcon` · bitmap 60×60 (sort.swf)
  - `worldboss.PvpHeroHelperFrame` · SimpleHelpFrame  ← `core.SimpleHelpFrame`
  - texts: `PvpHeroFrame.PlayerName` “Personagem”; `PvpSortListView.serverName` “Servidor”; `PvpHeroFrame.Kill` “Pontos Inter-S”; `PvpHeroFrame.Honor` “Título”; `PvpHeroFrame.Title` “Ranking Inter-Servidores”; `pvpHeroHelperFrame.title` “Ajuda de Ranking Inter-Servidores”; `pvpHeroFrame.rewardTip` “Pontos Inter-S ao atingir 1000 poderá obter Báu de AresJogad”; `sort.view.SortRightView.lastUpdateTime` “Última Atualização:”
  - subviews: `BaseIconView`, `SimpleHelpFrame`

### yishi.view.frame.RaceAgainstTimeFrame

- **RaceAgainstTimeFrame**: “Coleta de Prêmio” (`core_module:yishi/view/frame/RaceAgainstTimeFrame.as`)
  - `core.raceAgainstTimeFrame` · RaceAgainstTimeFrame width=385 height=446 ← `core.Frame2`
  - `asset.raceAgainstTimeFrame.back` · bitmap x=0 y=0
    - `asset.raceAgainstTimeFrame.back` · bitmap 368×369 (room.swf)
  - `raceAgainstTimeFrame.rewardsBg` · MutipleImage y=25
    - `asset.raceAgainstTimeFrame.titleBg` · bitmap 368×27 (room.swf)
    - `asset.raceAgainstTimeFrame.bottomBg` · bitmap 365×108 (room.swf)
    - `asset.raceAgainstTimeFrame.titleBg` · bitmap 368×27 (room.swf)
    - `asset.raceAgainstTimeFrame.bottomBg` · bitmap 365×108 (room.swf)
    - `asset.raceAgainstTimeFrame.clearTxt` · bitmap 159×18 (room.swf)
    - `asset.raceAgainstTimeFrame.timeTxt` · bitmap 135×22 (room.swf)
  - `raceAgainstTimeFrame.clearTxt` · FilterFrameText x=51 y=65 width=271 height=25 font `Arial,12,0xe7c88b,,,,,,center`
  - `raceAgainstTimeFrame.clearHBox` · HBox x=110 y=90
  - `raceAgainstTimeFrame.timeTxt` · FilterFrameText x=41 y=200 width=300 height=25 font `Arial,12,0xe7c88b,,,,,,center`
  - `raceAgainstTimeFrame.timeHBox` · HBox x=110 y=225
  - `raceAgainstTimeFrame.btn` · IconButton x=105 y=310
    - `asset.core.Style11Btn` · bitmap 151×50 (core2.swf)
    - `asset.raceAgainstTimeFrame.define` · bitmap 93×20 (room.swf)
  - `raceAgainstTimeFrame.itemView` · BaseItemView x=0 y=0 ← `core.normal.BaseItemView`
  - `raceAgainstTimeFrame.itemView` · BaseItemView x=0 y=0 ← `core.normal.BaseItemView`
  - texts: `RaceAgainstTimeFrame.titleText.text` “Coleta de Prêmio”; `RaceAgainstTimeFrame.clearTxt.text` “Você passou do {0}° piso. Prêmio recebido:”; `RaceAgainstTimeFrame.timeTxt.text1` “Você não passou, sem prêmios por enquanto!”; `RaceAgainstTimeFrame.timeTxt.text2` “Tempo gasto ao passar {0}. Prêmio recebido:”
  - subviews: `BaseItemView`

### yishi.view.frame.ShopLimiteTimeDiscountBuyFrame

- **ShopLimiteTimeDiscountBuyFrame** (`core_module:yishi/view/frame/ShopLimiteTimeDiscountBuyFrame.as`)
  - `shop.ShopLimiteTimeDiscountBuyFrame` · ShopLimiteTimeDiscountBuyFrame  ← `core.QuickBuyFrame`
  - texts: `shop.view.frame.BuyFrameI.buyFailed` “Falha na compra, informa??es do item atualizados”

### yishi.view.frame.ShopMainBuyFrame

- **ShopMainBuyFrame** (`core_module:yishi/view/frame/ShopMainBuyFrame.as`)
  - `shop.ShopMainBuyFrame` · ShopMainBuyFrame  ← `core.QuickBuyFrame`
  - `shop.GiftDonatioFrame` · GiftDonatioFrame width=385 height=196 ← `shop.PresentFrame`
  - texts: `shop.view.frame.BuyFrameI.buyFailed` “Falha na compra, informa??es do item atualizados”
  - subviews: `GiftDonatioFrame`

### yishi.view.frame.SimpleHelpFrame

- **SimpleHelpFrame**: “Ajuda” (`core_module:yishi/view/frame/SimpleHelpFrame.as`)
  - `vehiclemap_right.SimpleHelpFrame` · SimpleHelpFrame  ← `core.SimpleHelpFrame`
  - `worldboss.HelpTextBmp_1` · ScaleBitmapImage x=18 y=99
    - `asset.worldboss.HelpBmp` · bitmap 
      - `asset.worldboss.HelpBmp` · bitmap 21×21 (campaign.swf)
  - `worldboss.HelpTextBmp_2` · ScaleBitmapImage x=18 y=121
    - `asset.worldboss.HelpBmp` · bitmap 
      - `asset.worldboss.HelpBmp` · bitmap 21×21 (campaign.swf)
  - `worldboss.HelpTextBmp_3` · ScaleBitmapImage x=18 y=142
    - `asset.worldboss.HelpBmp` · bitmap 
      - `asset.worldboss.HelpBmp` · bitmap 21×21 (campaign.swf)
  - `asset.friends.StandingsBG` · bitmap 
    - `asset.friends.StandingsBG` · bitmap 21×15 (friends.swf)
  - `Friends.ItemStandingsTxt` · FilterFrameText x=21 y=2 width=16 height=18 font `Arial,12,0xffffff,,,,,,left`
  - texts: `public.confirm` “Confirmar”

### yishi.view.frame.TimeOutInviteFrame

- **TimeOutInviteFrame** (`core_module:yishi/view/frame/TimeOutInviteFrame.as`)
  - `core.TimeOutInviteFrame` · TimeOutInviteFrame x=546 y=131 width=330 height=120
  - `core.InviteFrameBack1` · Scale9CornerImage x=0 y=0 width=330 height=120 ← `core.describeBackground_style11`
  - `core.InviteFrameBack2` · Scale9CornerImage x=3 y=3 width=324 height=114 ← `core.describeBackground_style16`
  - `asset.core.invite.TitleBg` · bitmap x=2 y=3
    - `asset.core.invite.TitleBg` · bitmap 324×24 (core.swf)
  - `core.RoomInviteTitleText` · FilterFrameText x=8 y=6 font `Arial,12,0xe2b414`
  - `core.RoomInviteTime` · TimeDownView x=231 y=5
    - `core.RoomInviteTimeText` · FilterFrameText x=3 y=0 width=75 height=20 font `Arial,14,0xf9f1ad,true`
  - `core.RoomInviteContent` · FilterFrameText x=10 y=44 width=310 height=65 font `Arial,14,0xd8c493,,,,,,center`
  - `core.RoomInviteConfirm` · IconButton x=70 y=80
    - `asset.core.Style10Btn` · bitmap 77×26 (core2.swf)
    - `asset.core.invite.ConfirmBtnImg` · bitmap 53×20 (core.swf)
  - `core.RoomInviteCancel` · IconButton x=183 y=80 ← `core.RoomInviteConfirm`
    - `asset.core.invite.CancleBtnImg` · bitmap 63×20 (core.swf)
  - `core.RoomInviteClose` · BaseButton x=309 y=-5 ← `core.CloseBtn`
  - `core.useBindPointBtn` · SelectedCheckButton 
    - `asset.core.checkstyle_2.UnSelected_1` · Image 
      - `asset.core.checkstyle_2.UnSelected` · bitmap 22×23 (core2.swf)
    - `asset.core.checkstyle_2.Selected_1` · Image 
      - `asset.core.checkstyle_2.Selected` · sprite (core2.swf)
    - `core.ThewCheckTxt_2` · FilterFrameText  font `Arial,12,0xe7c88b,,,,,,center`
  - texts: `room.view.pve.RoomRightView.alertConent` “Utilizar a quantidade de ganhos diária”
  - subviews: `TimeDownView`

### yishi.view.frame.TodayNotAlertFrame

- **TodayNotAlertFrame**: “Aviso” (`core_module:yishi/view/frame/TodayNotAlertFrame.as`)
  - `army.TodayNotAlertFrame` · TodayNotAlertFrame width=430 height=190 ← `core.TodayNotAlertFrame`
    - `army.TodayNotAlertFrame.ConfirmBtn` · SelectedCheckButton x=102 y=86 ← `core.AlertConfirmBtn_2`
    - `army.TodayNotAlertFrame.CancelBtn` · SelectedCheckButton x=227 y=86 ← `core.AlertButton_2`
    - `army.TodayNotAlertFrame.CheckBtn` · SelectedCheckButton x=151 y=58 ← `core.ThewCheckBtn`
    - `army.TodayNotAlertFrame.AlertTextStyle` · FilterFrameText x=0 y=0 width=425 height=60 font `arial,14,0xe7c88b,,,,,,center`
    - `core.FrameTitleText` · FilterFrameText  font `Arial,14,0xFFDD83,true`
    - `worldboss.AlertTextStyle` · FilterFrameText x=-6 y=0 width=365 height=60 font `arial,14,0xe7c88b,,,,,,center`
    - `core.quickBuyFrameBg` · MutipleImage 
      - `core.AlertFrameBg` · MutipleImage 
        - `core.AlertFrameBaseBg` · Scale9CornerImage 
          - `asset.core.framestyle03_scale9bg1` · bitmap 42×42 (framebg.swf)
          - `asset.core.framestyle03_scale9bg2` · bitmap 42×42 (framebg.swf)
          - `asset.core.framestyle03_scale9bg3` · bitmap 42×42 (framebg.swf)
          - `asset.core.framestyle03_scale9bg4` · bitmap 42×18 (framebg.swf)
          - `asset.core.framestyle03_scale9bg5` · bitmap 42×18 (framebg.swf)
          - `asset.core.framestyle03_scale9bg6` · bitmap 42×18 (framebg.swf)
          - `asset.core.framestyle03_scale9bg7` · bitmap 42×42 (framebg.swf)
          - `asset.core.framestyle03_scale9bg8` · bitmap 42×42 (framebg.swf)
          - `asset.core.framestyle03_scale9bg9` · bitmap 42×42 (framebg.swf)
      - `core.FrameTitleImage2` · Image width=229 height=17
        - `asset.core.frameTitleImage2` · bitmap 229×17 (framebg.swf)
  - `core.CampaignNoWearyFrameTextBtn` · TextButton x=27 y=65
    - `core.CampaignNoWearyFrameText` · FilterFrameText height=20 font `Arial,15,0x3fcf14,,,true,,,center`
  - texts: `public.prompt` “Aviso”; `mainBar.view.VipCoolDownFrame.useBind` “Diamante vinculado prioritário”; `yishi.view.frame.TodayNotAlertFrame.notJoinActPromptTxt` “Diamantes vinculados não pertencem ao evento de consumo”; `yishi.view.frame.TodayNotAlertFrame.noWearyPromptTxtBtn` “Recuperar energia”

### yishi.view.frame.UpdateBroadCastFrame

- **UpdateBroadCastFrame**: “Anúncio de Atualização” (`core_module:yishi/view/frame/UpdateBroadCastFrame.as`)
  - `mainToolBar.BroadCastFrame` · UpdateBroadCastFrame width=651 height=560 ← `core.Frame1`
  - `mainToolBar.UpdateBroadCastBack1` · Scale9CornerImage x=1 y=24 width=619 height=384 ← `core.describeBackground_style11`
  - `mainToolBar.UpdateBroadCastBack3` · ScaleLeftRightImage x=1 y=412 width=621 height=53 ← `core.FameBottomImage`
  - `mainToolBar.UpdateBroadCastBtn` · IconButton x=254 y=418
    - `asset.mainToolBar.ConsortiaBtnAsset` · bitmap 114×42 (maintoolbar.swf)
    - `asset.broadcast.UpdateBtnTxt` · bitmap 91×19 (maintoolbar.swf)
  - `mainToolBar.UpdateBroadCastScroll` · ScrollPanel x=8 y=27 width=590 height=350
    - `mainToolBar.UpdateBroadCastVScrollbar02` · Scrollbar  ← `core.VScrollbar02`
    - `mainToolBar.UpdateBroadCastVScrollbar02` · Scrollbar  ← `core.VScrollbar02`
  - `mainToolBar.UpdateBroadCastDate` · FilterFrameText x=340 y=7 width=220 height=20 font `Arial,14,0xffeb79,,,,,,left`
  - `broadcast.UpdateBackAsset` · Image x=5 y=26
    - `asset.broadcast.UpdateBackAsset` · sprite 622.0×398.0 (maintoolbar.swf)
  - `asset.broadcast.UpdateDateAsset` · bitmap x=145 y=3
    - `asset.broadcast.UpdateDateAsset` · bitmap 114×17 (mainloading.swf)
  - `asset.broadcast.UpdateTitleBg` · bitmap 
    - `asset.broadcast.UpdateTitleBg` · bitmap 609×32 (mainloading.swf)
  - `asset.broadcast.UpdateContentAsset` · bitmap x=15 y=3
    - `asset.broadcast.UpdateContentAsset` · bitmap 140×17 (mainloading.swf)
  - `asset.broadcast.UpdatePreAsset` · bitmap x=0 y=237
    - `asset.broadcast.UpdatePreAsset` · bitmap 153×20 (mainloading.swf)
  - `asset.broadcast.UpdateTitleBg` · bitmap 
    - `asset.broadcast.UpdateTitleBg` · bitmap 609×32 (mainloading.swf)
  - `mainToolBar.UpdateBroadCastContent` · FilterFrameText x=18 y=0 width=550 font `Arial,14,0xbf9048,,,,,,left`
  - `mainToolBar.UpdateBroadCastContent` · FilterFrameText x=18 y=0 width=550 font `Arial,14,0xbf9048,,,,,,left`
  - texts: `yishi.view.UpdateBroadCastFrame.title` “Anúncio de Atualização”; `yishi.view.UpdateBroadCastFrame.Alert` “Não há comunicado de atualização”
  - subviews: `VBox`

### yishi.view.frame.UseBindPointAlert

- **UseBindPointAlert** (`core_module:yishi/view/frame/UseBindPointAlert.as`)
  - `UseBindPointAlertStyle` · UseBindPointAlert 
    - `core.AlertButtonConfirm_2` · IconButton  ← `core.AlertButtonConfirm_1`
      - `asset.core.AlertBtnStyle_02` · bitmap 96×40 (core2.swf)
    - `core.AlertButtonCancel_1` · IconButton  ← `core.AlertButtonConfirm_1`
      - `asset.core.CancelTxtAsset_01` · bitmap 75×18 (core2.swf)
    - `core.AlertSmallTipTxt` · FilterFrameText  font `Arial,12,0xfff600,,,,,,center`
    - `core.FrameTitleText` · FilterFrameText  font `Arial,14,0xFFDD83,true`
    - `core.AlertTextStyle` · FilterFrameText width=91 height=20 font `Arial,14,0xFFefbd,,,,,,center`
    - `core.quickBuyFrameBg` · MutipleImage 
      - `core.AlertFrameBg` · MutipleImage 
        - `core.AlertFrameBaseBg` · Scale9CornerImage 
          - `asset.core.framestyle03_scale9bg1` · bitmap 42×42 (framebg.swf)
          - `asset.core.framestyle03_scale9bg2` · bitmap 42×42 (framebg.swf)
          - `asset.core.framestyle03_scale9bg3` · bitmap 42×42 (framebg.swf)
          - `asset.core.framestyle03_scale9bg4` · bitmap 42×18 (framebg.swf)
          - `asset.core.framestyle03_scale9bg5` · bitmap 42×18 (framebg.swf)
          - `asset.core.framestyle03_scale9bg6` · bitmap 42×18 (framebg.swf)
          - `asset.core.framestyle03_scale9bg7` · bitmap 42×42 (framebg.swf)
          - `asset.core.framestyle03_scale9bg8` · bitmap 42×42 (framebg.swf)
          - `asset.core.framestyle03_scale9bg9` · bitmap 42×42 (framebg.swf)
      - `core.FrameTitleImage2` · Image width=229 height=17
        - `asset.core.frameTitleImage2` · bitmap 229×17 (framebg.swf)
    - `core.useBindPointBtn` · SelectedCheckButton 
      - `asset.core.checkstyle_2.UnSelected_1` · Image 
        - `asset.core.checkstyle_2.UnSelected` · bitmap 22×23 (core2.swf)
      - `asset.core.checkstyle_2.Selected_1` · Image 
        - `asset.core.checkstyle_2.Selected` · sprite (core2.swf)
      - `core.ThewCheckTxt_2` · FilterFrameText  font `Arial,12,0xe7c88b,,,,,,center`
    - `core.useBindPoint_notJoinActTxt` · FilterFrameText  font `Arial,12,0xff0000,,,,,,left`
  - texts: `mainBar.view.VipCoolDownFrame.useBind` “Diamante vinculado prioritário”; `mainBar.view.VipCoolDownFrame.promptTxt` “(Não participa no evento de consumo)”

### yishi.view.frame.UseBindPointWithChoiceAutoLayoutAlert

- **UseBindPointWithChoiceAutoLayoutAlert** (`core_module:yishi/view/frame/UseBindPointWithChoiceAutoLayoutAlert.as`)
  - `UseBindPointWithChoiceAutoLayoutAlertStyle` · UseBindPointWithChoiceAutoLayoutAlert 
    - `core.AlertButtonConfirm_2` · IconButton  ← `core.AlertButtonConfirm_1`
      - `asset.core.AlertBtnStyle_02` · bitmap 96×40 (core2.swf)
    - `core.AlertButtonCancel_1` · IconButton  ← `core.AlertButtonConfirm_1`
      - `asset.core.CancelTxtAsset_01` · bitmap 75×18 (core2.swf)
    - `core.UseBindPointWithChoiceAutoLayoutAlertSmallTipTxt` · FilterFrameText  font `Arial,12,0xff0000,,,,,,left`
    - `core.FrameTitleText` · FilterFrameText  font `Arial,14,0xFFDD83,true`
    - `core.AlertTextStyle` · FilterFrameText width=91 height=20 font `Arial,14,0xFFefbd,,,,,,center`
    - `core.quickBuyFrameBg` · MutipleImage 
      - `core.AlertFrameBg` · MutipleImage 
        - `core.AlertFrameBaseBg` · Scale9CornerImage 
          - `asset.core.framestyle03_scale9bg1` · bitmap 42×42 (framebg.swf)
          - `asset.core.framestyle03_scale9bg2` · bitmap 42×42 (framebg.swf)
          - `asset.core.framestyle03_scale9bg3` · bitmap 42×42 (framebg.swf)
          - `asset.core.framestyle03_scale9bg4` · bitmap 42×18 (framebg.swf)
          - `asset.core.framestyle03_scale9bg5` · bitmap 42×18 (framebg.swf)
          - `asset.core.framestyle03_scale9bg6` · bitmap 42×18 (framebg.swf)
          - `asset.core.framestyle03_scale9bg7` · bitmap 42×42 (framebg.swf)
          - `asset.core.framestyle03_scale9bg8` · bitmap 42×42 (framebg.swf)
          - `asset.core.framestyle03_scale9bg9` · bitmap 42×42 (framebg.swf)
      - `core.FrameTitleImage2` · Image width=229 height=17
        - `asset.core.frameTitleImage2` · bitmap 229×17 (framebg.swf)
    - `core.useBindPointHtmlBtn` · SelectedCheckHtmlButton 
      - `asset.core.checkstyle_2.UnSelected_1` · Image 
        - `asset.core.checkstyle_2.UnSelected` · bitmap 22×23 (core2.swf)
      - `asset.core.checkstyle_2.Selected_1` · Image 
        - `asset.core.checkstyle_2.Selected` · sprite (core2.swf)
      - `core.ThewCheckTxt_3` · FilterFrameText  font `Arial,12,0xe7c88b,,,,,,center`
    - `core.useBindPointHtmlBtn` · SelectedCheckHtmlButton 
      - `asset.core.checkstyle_2.UnSelected_1` · Image 
        - `asset.core.checkstyle_2.UnSelected` · bitmap 22×23 (core2.swf)
      - `asset.core.checkstyle_2.Selected_1` · Image 
        - `asset.core.checkstyle_2.Selected` · sprite (core2.swf)
      - `core.ThewCheckTxt_3` · FilterFrameText  font `Arial,12,0xe7c88b,,,,,,center`
    - `core.useBindPoint_notJoinActTxt` · FilterFrameText  font `Arial,12,0xff0000,,,,,,left`
  - texts: `mainBar.view.VipCoolDownFrame.useBind` “Diamante vinculado prioritário”; `mainBar.view.VipCoolDownFrame.promptTxt` “(Não participa no evento de consumo)”

### yishi.view.frame.WishPoolShopBuyFrame

- **WishPoolShopBuyFrame**: “Comprar” (`core_module:yishi/view/frame/WishPoolShopBuyFrame.as`)
  - `quickbuy.WishPoolShopBuyFrame` · WishPoolShopBuyFrame width=271 height=330
    - `core.FrameTitleText` · FilterFrameText  font `Arial,14,0xFFDD83,true`
    - `core.quickBuyFrameBg` · MutipleImage 
      - `core.AlertFrameBg` · MutipleImage 
        - `core.AlertFrameBaseBg` · Scale9CornerImage 
          - `asset.core.framestyle03_scale9bg1` · bitmap 42×42 (framebg.swf)
          - `asset.core.framestyle03_scale9bg2` · bitmap 42×42 (framebg.swf)
          - `asset.core.framestyle03_scale9bg3` · bitmap 42×42 (framebg.swf)
          - `asset.core.framestyle03_scale9bg4` · bitmap 42×18 (framebg.swf)
          - `asset.core.framestyle03_scale9bg5` · bitmap 42×18 (framebg.swf)
          - `asset.core.framestyle03_scale9bg6` · bitmap 42×18 (framebg.swf)
          - `asset.core.framestyle03_scale9bg7` · bitmap 42×42 (framebg.swf)
          - `asset.core.framestyle03_scale9bg8` · bitmap 42×42 (framebg.swf)
          - `asset.core.framestyle03_scale9bg9` · bitmap 42×42 (framebg.swf)
      - `core.FrameTitleImage2` · Image width=229 height=17
        - `asset.core.frameTitleImage2` · bitmap 229×17 (framebg.swf)
  - `quickbuy.SelfBuyFrameBack2` · MutipleImage 
    - `asset.quickbuy.BuyFrameBaseBack` · bitmap 268×281 (quickbuy.swf)
    - `asset.quickbuy.BuyPriceText` · bitmap x=10 y=133
      - `asset.quickbuy.BuyPriceText` · bitmap 88×25 (quickbuy.swf)
    - `asset.quickbuy.BuyNumText2` · bitmap x=10 y=160
      - `asset.quickbuy.BuyNumText2` · bitmap 85×40 (quickbuy.swf)
    - `quickbuy.BuyInputBg` · Image x=96 y=159
      - `asset.core.TextInputBG2` · bitmap 87×30 (core2.swf)
  - `quickbuy.SelfSelectedBackBtn` · SelectedIconButton x=24 y=11 width=100 height=26
    - `asset.quickbuy.Buycheckstyle_2.UnSelected` · bitmap 18×18 (quickbuy.swf)
    - `asset.quickbuy.Buycheckstyle_2.Selected` · bitmap 18×18 (quickbuy.swf)
    - `asset.quickbuy.unselectedBackTxt` · bitmap 81×23 (quickbuy.swf)
    - `asset.quickbuy.unselectedBackTxt` · bitmap 81×23 (quickbuy.swf)
  - `quickbuy.selfConfirmBtn` · IconButton x=129 y=230 width=134 height=45
    - `asset.quickbuy.ShopBuyFrameBuyBtnBg` · bitmap 115×48 (quickbuy.swf)
    - `asset.quickbuy.ShopBuyFrameBuyBtnText` · bitmap 76×17 (quickbuy.swf)
  - `quickbuy.AddButton` · BaseButton x=188 y=163 width=22 height=21
    - `asset.core.UpButton` · bitmap 22×21 (core2.swf)
  - `quickbuy.DeleteButton` · BaseButton x=215 ← `quickbuy.AddButton`
    - `asset.core.DownButton` · bitmap 22×21 (core2.swf)
  - `quickbuy.BuyNumTextStyle` · FilterFrameText x=100 y=163 width=76 height=20 font `Arial,14,0xfffd7d,true,,,,,center`
  - `WishPoolShopFrame.ShopPayType` · ScaleFrameImage y=134
    - `asset.core.wishpoolScoreIconImage` · bitmap 28×28 (core.swf)
  - `quickbuy.BuyGoodsNameStyle` · FilterFrameText x=113 y=39 width=168 height=60 font `Arial,14,0xeae1c9,,,,,,left`
  - `quickbuy.TotalPriceTextStyle` · FilterFrameText x=96 y=134 width=124 height=20 font `Arial,14,0xddcda0,true,,,,,left`
  - `quickbuy.BuyCanOneTextStyle` · FilterFrameText x=110 y=99 width=130 height=40 font `Arial,12,0xffe49c,,,,,,left`
  - `quickbuy.BuyCanOneValueTextStyle` · FilterFrameText x=153 y=98 font `Arial,14,0xffe49c,true,,,,,left`
  - `quickbuy.BuyBaseItemView` · BaseItemView x=34 y=47
    - `quickbuy.BuyBaseItemViewIcon` · BaseIconView x=3 y=3
      - `asset.core.IconLoading` · sprite 42 frames (core2.swf)
    - `core.GoodsProfileBG` · ScaleFrameImage 
      - `asset.core.BagProfileGreen` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileBlue` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfilePurple` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileOrange` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileRed` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileBlackKing` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileFashion` · bitmap 45×45 (core.swf)
    - `core.goods.Strengthen` · MovieImage x=-50 y=-50
      - `asset.core.goods.Strengthen` · Strengthen 
    - `quickbuy.BaseItemText` · FilterFrameText x=26 y=44 ← `core.BaseItemText`
  - `campaign.TrailShop.BuyBtnTxt` · GradientText 
    - `campaign.TrailShop.BuyBtnTxt2` · FilterFrameText width=46 height=20 font `Arial,12,0xecc200,,,,,,center`
  - texts: `campaign.TrailShop.BuyBtnTxt` “Comprar”; `shop.view.frame.BuyFrameI.mopupexitst` “Fera já ativada, não é possível comprar.”; `shop.view.GoodsItem12.limited08` “Pode comprar {0} durante o evento”; `shop.view.GoodsItem.limited05` “Limite Atingido”
  - subviews: `BaseItemView`

### yishi.view.frame.discount.DiscountItem

- **DiscountItem** (`core_module:yishi/view/frame/discount/DiscountItem.as`)
  - `asset.quickbuy.quanSmallBg` · bitmap 229×88 (quickbuy.swf)
  - `quickbuy.discountSelfSelectedBtn` · SelectedIconButton x=3 y=36 width=100 height=60
    - `asset.quickbuy.Buycheckstyle_2.UnSelected` · bitmap 18×18 (quickbuy.swf)
    - `asset.quickbuy.Buycheckstyle_2.Selected` · bitmap 18×18 (quickbuy.swf)
    - `asset.quickbuy.unknown` · bitmap 78×78 (quickbuy.swf)
    - `asset.quickbuy.unknown` · bitmap 78×78 (quickbuy.swf)
  - `quickbuy.discountItemDes` · FilterFrameText x=83 y=0 width=145 height=95 font `Arial,12,0xeae1c9,,,,,,left`

### yishi.view.frame.discount.DiscountUI

- **DiscountUI** (`core_module:yishi/view/frame/discount/DiscountUI.as`)
  - `yishi.view.frame.discount.discountui` · DiscountUI x=283 y=1
  - `asset.quickbuy.quanBg` · sprite 266.0×285.0 (quickbuy.swf)
  - `quickbuy.discountScrollPanel` · ScrollPanel x=8 y=45 width=252 height=230
    - `quickbuy.VScrollbar03` · Scrollbar width=16 height=200
      - `core.Scrollbar03_Back` · ScaleBitmapImage width=15 height=24
        - `asset.core.scrollbar03_bg` · bitmap 15×24 (core2.swf)
      - `core.Scrollbar03_Step` · BaseButton width=13 height=36
        - `core.scrollbar03_stepAsset` · ScaleBitmapImage width=13 height=36
          - `asset.core.scrollbar03_step` · bitmap 13×36 (core2.swf)
      - `core.Scrollbar03_Up` · BaseButton width=16 height=16
        - `asset.core.scrollbar03_up` · bitmap 16×16 (core2.swf)
      - `core.Scrollbar03_Down` · BaseButton width=16 height=16
        - `asset.core.scrollbar03_down` · bitmap 16×16 (core2.swf)
  - texts: `yishi.view.frame.BuyFrameI.hasNoDiscountQuan` “Você não tem cupons de desconto na mochila, favor verificar ”; `yishi.view.frame.BuyFrameI.notUsableDiscount` “Não completou condições”
  - subviews: `VBox`, `DiscountItem`

### yishi.view.frame.giftdonatio.AutoSearchFriendView

- **AutoSearchFriendView** (`core_module:yishi/view/frame/giftdonatio/AutoSearchFriendView.as`)
  - `friends.searchResultBg` · ScaleBitmapImage x=-4 y=5 ← `core.commonTipBg`
  - `shop.Combox_TextStyle` · FilterFrameText width=145 ← `core.Combox1_TextStyle`
  - texts: `friends.view.FriendAutoSearchBox.temp` “Nenhum encontrado”
  - subviews: `VBox`, `FriendItemBtn`

### yishi.view.frame.giftdonatio.FriendCombox

- **FriendCombox** (`core_module:yishi/view/frame/giftdonatio/FriendCombox.as`)
  - `shop.FriendCombox` · FriendCombox x=82 y=46 width=407 height=0
    - `shop.FriendList` · ListPanel width=148 height=126
      - `shop.FriendListBtnSelectBackUp` · ScaleBitmapImage width=144 height=21
        - `asset.chatII.FriendListCellback` · bitmap 144×21 (chat.swf)
      - `core.VScrollbar02` · Scrollbar width=21 height=200
        - `core.Scrollbar02_Back` · ScaleBitmapImage width=15 height=24
          - `asset.core.scrollbar02_bg` · bitmap 15×24 (core2.swf)
        - `core.Scrollbar02_Step` · BaseButton width=21 height=56
          - `core.scrollbar02_stepAsset` · ScaleBitmapImage width=21 height=56
        - `core.Scrollbar02_Up` · BaseButton width=11 height=10
          - `asset.core.scrollbar02_up` · bitmap 11×10 (core2.swf)
        - `core.Scrollbar02_Down` · BaseButton width=11 height=10
          - `asset.core.scrollbar02_down` · bitmap 11×10 (core2.swf)
    - `shop.Combox_TextStyle` · FilterFrameText width=145 ← `core.Combox1_TextStyle`
    - `shop.GiftDonatioSelectFriendsBtn` · TextButton x=158 y=0 width=112 height=29
      - `asset.quickbuy.SelectFriendsBtn` · bitmap 69×29 (quickbuy.swf)
      - `shop.GiftDonatioSelectFriendsBtnTex` · FilterFrameText  font `Arial,12,0xfffcb1`
    - `shop.FriendsButton` · SelectedButton x=0 y=134 width=76 height=26
      - `shop.FriendListBtnSelectBack` · MutipleImage 
        - `shop.FriendListBtnSelectBackAsset` · ScaleBitmapImage width=76 height=26 ← `core.commonTipBg`
        - `asset.chatII.FriendIcon` · bitmap x=22 y=4
          - `asset.chatII.FriendIcon` · bitmap 53×18 (chat.swf)
      - `shop.FriendListBtnUnselectBack` · MutipleImage 
        - `shop.FriendListBtnUnselectBackAsset` · ScaleBitmapImage  ← `shop.FriendListBtnSelectBackAsset`
        - `asset.chatII.FriendIcon` · bitmap x=22 y=4
          - `asset.chatII.FriendIcon` · bitmap 53×18 (chat.swf)
    - `shop.UnionButton` · SelectedButton x=77 y=134 width=76 height=26
      - `shop.ConsortiaListBtnSelectBack` · MutipleImage 
        - `shop.FriendListBtnSelectBackAsset` · ScaleBitmapImage width=76 height=26 ← `core.commonTipBg`
        - `asset.chatII.ConsortiaIcon` · bitmap x=22 y=4
          - `asset.chatII.ConsortiaIcon` · bitmap 45×16 (chat.swf)
      - `shop.ConsortiaListBtnUnselectBack` · MutipleImage 
        - `shop.FriendListBtnUnselectBackAsset` · ScaleBitmapImage  ← `shop.FriendListBtnSelectBackAsset`
        - `asset.chatII.ConsortiaIcon` · bitmap x=22 y=4
          - `asset.chatII.ConsortiaIcon` · bitmap 45×16 (chat.swf)
  - `shop.FriendListBack` · ScaleBitmapImage width=153 height=160 ← `chatII.FriendListBack`

### yishi.view.frame.giftdonatio.FriendItemBtn

- **FriendItemBtn** (`core_module:yishi/view/frame/giftdonatio/FriendItemBtn.as`)
  - `friends.FriendsItemBg` · ScaleFrameImage x=1 width=232
    - `asset.invite.FriendsItemOverBg` · bitmap 
      - `asset.invite.FriendsItemOverBg` · bitmap 186×21 (invite.swf)
    - `asset.invite.FriendsItemSelectBg` · bitmap 
      - `asset.invite.FriendsItemSelectBg` · bitmap 186×21 (invite.swf)
  - `shop.Combox_TextStyle` · FilterFrameText width=145 ← `core.Combox1_TextStyle`

### yishi.view.frame.giftdonatio.GiftDonatioFrame

- **GiftDonatioFrame** (`core_module:yishi/view/frame/giftdonatio/GiftDonatioFrame.as`)
  - `shop.GiftDonatioFrame` · GiftDonatioFrame width=385 height=196 ← `shop.PresentFrame`
  - `asset.quickbuy.GiftFrameGifTxtImgBg` · bitmap x=10 y=4
    - `asset.quickbuy.GiftFrameGifTxtImgBg` · bitmap 329×35 (quickbuy.swf)
  - `asset.quickbuy.GiftFrameGifTxtImg` · bitmap x=121 y=11
    - `asset.quickbuy.GiftFrameGifTxtImg` · bitmap 100×21 (quickbuy.swf)
  - `asset.quickbuy.PresentToImg` · bitmap x=0 y=50
    - `asset.quickbuy.PresentToImg` · bitmap 84×18 (quickbuy.swf)
  - `shop.FriendCombox` · FriendCombox x=82 y=46 width=407 height=0
    - `shop.FriendList` · ListPanel width=148 height=126
      - `shop.FriendListBtnSelectBackUp` · ScaleBitmapImage width=144 height=21
        - `asset.chatII.FriendListCellback` · bitmap 144×21 (chat.swf)
      - `core.VScrollbar02` · Scrollbar width=21 height=200
        - `core.Scrollbar02_Back` · ScaleBitmapImage width=15 height=24
          - `asset.core.scrollbar02_bg` · bitmap 15×24 (core2.swf)
        - `core.Scrollbar02_Step` · BaseButton width=21 height=56
          - `core.scrollbar02_stepAsset` · ScaleBitmapImage width=21 height=56
        - `core.Scrollbar02_Up` · BaseButton width=11 height=10
          - `asset.core.scrollbar02_up` · bitmap 11×10 (core2.swf)
        - `core.Scrollbar02_Down` · BaseButton width=11 height=10
          - `asset.core.scrollbar02_down` · bitmap 11×10 (core2.swf)
    - `shop.Combox_TextStyle` · FilterFrameText width=145 ← `core.Combox1_TextStyle`
    - `shop.GiftDonatioSelectFriendsBtn` · TextButton x=158 y=0 width=112 height=29
      - `asset.quickbuy.SelectFriendsBtn` · bitmap 69×29 (quickbuy.swf)
      - `shop.GiftDonatioSelectFriendsBtnTex` · FilterFrameText  font `Arial,12,0xfffcb1`
    - `shop.FriendsButton` · SelectedButton x=0 y=134 width=76 height=26
      - `shop.FriendListBtnSelectBack` · MutipleImage 
        - `shop.FriendListBtnSelectBackAsset` · ScaleBitmapImage width=76 height=26 ← `core.commonTipBg`
        - `asset.chatII.FriendIcon` · bitmap x=22 y=4
          - `asset.chatII.FriendIcon` · bitmap 53×18 (chat.swf)
      - `shop.FriendListBtnUnselectBack` · MutipleImage 
        - `shop.FriendListBtnUnselectBackAsset` · ScaleBitmapImage  ← `shop.FriendListBtnSelectBackAsset`
        - `asset.chatII.FriendIcon` · bitmap x=22 y=4
          - `asset.chatII.FriendIcon` · bitmap 53×18 (chat.swf)
    - `shop.UnionButton` · SelectedButton x=77 y=134 width=76 height=26
      - `shop.ConsortiaListBtnSelectBack` · MutipleImage 
        - `shop.FriendListBtnSelectBackAsset` · ScaleBitmapImage width=76 height=26 ← `core.commonTipBg`
        - `asset.chatII.ConsortiaIcon` · bitmap x=22 y=4
          - `asset.chatII.ConsortiaIcon` · bitmap 45×16 (chat.swf)
      - `shop.ConsortiaListBtnUnselectBack` · MutipleImage 
        - `shop.FriendListBtnUnselectBackAsset` · ScaleBitmapImage  ← `shop.FriendListBtnSelectBackAsset`
        - `asset.chatII.ConsortiaIcon` · bitmap x=22 y=4
          - `asset.chatII.ConsortiaIcon` · bitmap 45×16 (chat.swf)
  - `shop.comboxInputbg2` · ScaleBitmapImage x=82 y=46 width=155 height=26
    - `asset.core.describeBackground_style04` · bitmap 78×38 (core2.swf)
  - `shop.FriendComboxUpgradeBtn` · SelectedCheckButton x=46 y=85 ← `core.AlertButton`
  - `shop.FriendComboxCancelBtn` · SelectedCheckButton x=190 y=85 ← `core.AlertButton`
  - texts: `shop.view.frame.GiftDonatioFrame.command01` “Preencha o apelido de quem deseja presentear!!”; `public.cancel` “Cancelar”; `public.prompt` “Aviso”; `view.shopFrame.buyFrameI.shopCartItem.null` “O carrinho atual não tem nenhum item”; `public.fastCharge` “Recarga imediata”; `view.subshop.ShopCartFrame.buyText4` “Consumo total de diamantes:{0}”; `view.subshop.ShopCartFrame.buyText3` “A sua quantidade de diamantes é insuficiente, por favor reca”; `shop.view.frame.GiftDonatioFrame.Selectedfriend` “Escolha Amigos”
  - subviews: `AutoSearchFriendView`, `FriendCombox`

### yishi.view.frame.giftdonatio.RecipientsAutoSearchBox

- **RecipientsAutoSearchBox** (`core_module:yishi/view/frame/giftdonatio/RecipientsAutoSearchBox.as`)
  - `email.RecipientsSearchListPanel` · ListPanel width=190 height=156
    - `core.commonTipBg` · ScaleBitmapImage width=435
      - `asset.core.describeBackground_style07` · bitmap 260×82 (core2.swf)

### yishi.view.frame.planeswar.PlanesResourceFrame

- **PlanesResourceFrame**: “Informação de Planos de mina” (`core_module:yishi/view/frame/planeswar/PlanesResourceFrame.as`)
  - `PlanesListView.PlanesResourceFrame` · PlanesResourceFrame width=500 height=515 ← `core.Frame1`
  - `PlanesResourceFrame.back` · Scale9CornerImage x=0 y=5 width=460 height=410 ← `core.describeBackground_style11`
  - `PlanesResourceFrame.bottomLine` · Image x=5 y=370
    - `asset.PlanesResourceFrame.bottomLine` · bitmap 450×3 (core.swf)
  - `PlanesResourceFrame.lookPageBg` · Image x=202 y=374
    - `asset.core.pageBg` · bitmap 
      - `asset.core.pageBg` · bitmap 64×33 (core2.swf)
  - `PlanesResourceFrame.lookPageTextStyle` · FilterFrameText x=205 y=380 width=60 height=20 font `Arial,16,0xe6d9b0,true,,,,,center`
  - `PlanesResourceFrame.lookLastPageBtn` · IconButton x=115 y=376 ← `core.LastPageBtn`
  - `PlanesResourceFrame.lookNextPageBtn` · IconButton x=280 y=376 ← `core.NextPageBtn`
  - `PlanesResourceFrame.vbox` · VBox x=7 y=16
  - texts: `planeswar.PlanesResourceFrame.titleText` “Informação de Planos de mina”
  - subviews: `PlanesResourceItemView`

### yishi.view.frame.planeswar.PlanesResourceItemView

- **PlanesResourceItemView** (`core_module:yishi/view/frame/planeswar/PlanesResourceItemView.as`)
  - `PlanesResourceItemView.itemBack` · ScaleBitmapImage 
    - `asset.PlanesResourceItemView.itemBack` · bitmap 448×114 (core.swf)
  - `PlanesResourceItemView.resourceName` · FilterFrameText x=10 y=10 width=120 height=20 font `Arial,14,0xdcc4a6,true,,,,,left`
  - `PlanesResourceItemView.leftTime` · FilterFrameText x=10 y=35 width=175 height=20 font `Arial,13,0xa28e5b,,,,,,left`
  - `PlanesResourceItemView.nextRewardTime` · FilterFrameText x=185 y=35 width=190 height=20 font `Arial,13,0xa28e5b,,,,,,left`
  - `PlanesResourceItemView.rewardText` · FilterFrameText x=10 y=70 width=90 height=36 font `Arial,13,0xa28e5b,,,,,,left`
  - `PlanesResourceItemView.rewardCount` · FilterFrameText x=135 y=85 width=100 height=25 font `Arial,16,0xa28e5b,,,,,,left`
  - `PlanesResourceItemView.rewardItem` · BaseItemView x=80 y=60
    - `core.BaseItemViewIcon` · BaseIconView x=1 y=1
      - `asset.core.IconLoading` · sprite 42 frames (core2.swf)
    - `core.BaseItemText` · FilterFrameText x=0 y=26 width=45 height=18 font `Arial,12,0xffffff,true,,,,,right`
    - `core.GoodsProfileBG` · ScaleFrameImage 
      - `asset.core.BagProfileGreen` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileBlue` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfilePurple` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileOrange` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileRed` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileBlackKing` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileFashion` · bitmap 45×45 (core.swf)
  - `PlanesResourceItemView.getRewardBtn` · IconButton x=346 y=65
    - `asset.PlanesResourceItemView.getRewardBack` · bitmap 90×34 (core.swf)
    - `asset.PlanesResourceItemView.getRewardText` · bitmap 66×20 (core.swf)
  - texts: `PlanesResourceItemView.noReward.alert` “Ainda não chegou  o tempo de coleta, favor aguardar”; `PlanesResourceItemView.rewardText.text` “Prêmio acumulado”; `PlanesResourceItemView.leftTime.text` “Tempo restante: {0}”; `PlanesResourceItemView.nextRewardTime.text` “Tempo do próximo prêmio: {0}”
  - subviews: `BaseItemView`

### yishi.view.frame.pvpleague.PVPLeagueRankItem

- **PVPLeagueRankItem** (`core_module:yishi/view/frame/pvpleague/PVPLeagueRankItem.as`)
  - `sort.league.ItemBg` · Image 
    - `sort.league.itemBgLight` · Scale9CornerImage x=2 y=7 width=524 ← `core.TitleBack_Style888`
  - `sort.league.TopIcon` · ScaleFrameImage x=15 y=10
    - `asset.sort.RankTop1` · bitmap 65×32 (sort.swf)
    - `asset.sort.RankTop2` · bitmap 66×32 (sort.swf)
    - `asset.sort.RankTop3` · bitmap 66×32 (sort.swf)
  - `sort.league.TopText` · FilterFrameText x=4 y=13 width=70 height=20 font `Arial,12,0xe4d29c,,,,,,center`
  - `sort.league.NameText` · FilterFrameText x=74 y=13 width=120 height=20 font `Arial,12,0xe4d29c,,,,,,center`
  - `sort.league.ServerNameText` · FilterFrameText x=194 y=13 width=120 height=20 font `Arial,12,0xe4d29c,,,,,,center`
  - `sort.league.ScoreText` · FilterFrameText x=314 y=13 width=120 height=20 font `Arial,12,0xe4d29c,,,,,,center`
  - `sort.league.FightCapacityText` · FilterFrameText x=434 y=13 width=80 height=20 font `Arial,12,0xe4d29c,,,,,,center`

### yishi.view.frame.pvpleague.PVPLeagueRankListFrame

- **PVPLeagueRankListFrame**: “Ranking da Aliança” (`core_module:yishi/view/frame/pvpleague/PVPLeagueRankListFrame.as`)
  - `sort.league.PVPLeagueRankListFrame` · PVPLeagueRankListFrame width=575 height=590 ← `core.Frame2`
  - `sort.league.FrameBg` · ScaleBitmapImage y=30 width=543 height=465 ← `core.describeBackground_style06`
  - `sort.league.RankContentBg` · Image x=7 y=39
    - `asset.sort.RankContentBg` · sprite 528.0×362.0 (sort.swf)
  - `sort.league.RankListTitle.rankNum` · FilterFrameText x=12 y=50 width=70 height=20 font `Arial,14,0xe7c88b,true,,,,,center`
  - `sort.league.RankListTitle.nickName` · FilterFrameText x=92 y=50 width=100 height=20 font `Arial,14,0xe7c88b,true,,,,,center`
  - `sort.league.RankListTitle.serverName` · FilterFrameText x=202 y=50 width=120 height=20 font `Arial,14,0xe7c88b,true,,,,,center`
  - `sort.league.RankListTitle.totleScore` · FilterFrameText x=347 y=50 width=70 height=20 font `Arial,14,0xe7c88b,true,,,,,center`
  - `sort.league.RankListTitle.fightTxt` · FilterFrameText x=442 y=52 width=80 height=20 font `Arial,14,0xe7c88b,true,,,,,center`
  - `sort.league.ShowReward` · Image x=10 y=413
    - `asset.sort.ShowRewardAsset` · bitmap 85×43 (sort.swf)
  - `matelords.sort.RankTips2` · CustomBitmap x=142 y=463
    - `asset.sort.RankTips2` · bitmap 
      - `asset.sort.RankTips2` · bitmap 19×21 (sort.swf)
  - `matelords.sort.RankTips3` · CustomBitmap x=265 y=463
    - `asset.sort.RankTips3` · bitmap 
      - `asset.sort.RankTips3` · bitmap 58×21 (sort.swf)
  - `matelords.sort.RankTips4` · CustomBitmap x=10 y=463
    - `asset.sort.RankTips4` · bitmap 
      - `asset.sort.RankTips4` · bitmap 104×21 (sort.swf)
  - `sort.league.RankGroupTips` · ScaleFrameImage x=112 y=464
    - `asset.sort.GroupAsset1` · bitmap 137×20 (sort.swf)
    - `asset.sort.GroupAsset2` · bitmap 105×20 (sort.swf)
    - `asset.sort.GroupAsset3` · bitmap 104×20 (sort.swf)
    - `asset.sort.GroupAsset4` · bitmap 104×20 (sort.swf)
  - `sort.league.RankTopTips` · FilterFrameText x=235 y=460 width=30 height=20 font `Arial,16,0xffe400,true,,,,,center`
  - `sort.league.NotApplyTips` · FilterFrameText x=113 y=460 width=100 height=20 font `Arial,16,0xffe400,true,,,,,left`
  - `sort.league.RankItemVbox` · VBox x=8 y=67
  - `sort.league.pageBg` · Image x=232 y=412
    - `asset.core.pageBg` · bitmap 
      - `asset.core.pageBg` · bitmap 64×33 (core2.swf)
  - `sort.league.PageTxt` · FilterFrameText x=238 y=418 width=60 height=20 font `Arial,16,0xe6d9b0,true,,,,,center`
  - `sort.league.LastPageBtn` · IconButton x=155 y=413 ← `core.LastPageBtn`
  - `sort.league.NextPageBtn` · IconButton x=303 y=413 ← `core.NextPageBtn`
  - `sort.league.GroupBtn1` · SelectedIconButton x=12 y=5 width=90 height=38
    - `core.PlayerInfoTabUnselectBack` · Image y=33 width=99 height=34
      - `asset.core.Style8UnselectedBtn` · bitmap 99×34 (core2.swf)
    - `core.PlayerInfoTabSelectBack` · Image y=33 width=99 height=34
      - `asset.core.Style8SelectedBtn` · bitmap 99×34 (core2.swf)
    - `asset.sort.GroupUnselectedAsset1` · bitmap 63×24 (sort.swf)
    - `asset.sort.GroupSelectedAsset1` · bitmap 72×29 (sort.swf)
  - `sort.league.GroupBtn2` · SelectedIconButton x=102 y=5 width=90 height=38
    - `core.PlayerInfoTabUnselectBack` · Image y=33 width=99 height=34
      - `asset.core.Style8UnselectedBtn` · bitmap 99×34 (core2.swf)
    - `core.PlayerInfoTabSelectBack` · Image y=33 width=99 height=34
      - `asset.core.Style8SelectedBtn` · bitmap 99×34 (core2.swf)
    - `asset.sort.GroupUnselectedAsset2` · bitmap 51×24 (sort.swf)
    - `asset.sort.GroupSelectedAsset2` · bitmap 57×27 (sort.swf)
  - `sort.league.GroupBtn3` · SelectedIconButton x=192 y=5 width=90 height=38
    - `core.PlayerInfoTabUnselectBack` · Image y=33 width=99 height=34
      - `asset.core.Style8UnselectedBtn` · bitmap 99×34 (core2.swf)
    - `core.PlayerInfoTabSelectBack` · Image y=33 width=99 height=34
      - `asset.core.Style8SelectedBtn` · bitmap 99×34 (core2.swf)
    - `asset.sort.GroupUnselectedAsset3` · bitmap 50×25 (sort.swf)
    - `asset.sort.GroupSelectedAsset3` · bitmap 57×27 (sort.swf)
  - `sort.league.GroupBtn4` · SelectedIconButton x=282 y=5 width=90 height=38
    - `core.PlayerInfoTabUnselectBack` · Image y=33 width=99 height=34
      - `asset.core.Style8UnselectedBtn` · bitmap 99×34 (core2.swf)
    - `core.PlayerInfoTabSelectBack` · Image y=33 width=99 height=34
      - `asset.core.Style8SelectedBtn` · bitmap 99×34 (core2.swf)
    - `asset.sort.GroupUnselectedAsset4` · bitmap 53×27 (sort.swf)
    - `asset.sort.GroupSelectedAsset4` · bitmap 53×27 (sort.swf)
  - `sort.league.HelpBtn` · BaseButton x=495 y=-40
    - `asset.core.HelpButton_01` · bitmap 26×26 (core2.swf)
  - `sort.league.HelpFrame` · SimpleHelpFrame  ← `core.SimpleHelpFrame`
  - texts: `yishi.view.frame.pvpleague.PVPLeagueRankListFrame.Title` “Ranking da Aliança”; `gvgcross.view.ranklists.Rank.Title1` “Ranking”; `PvpHeroFrame.PlayerName` “Personagem”; `gvgcross.view.ranklists.Rank.Title3` “Local”; `gvgcross.view.ranklists.Rank.Title5` “Pontos”; `gvgcross.view.ranklists.Rank.Title6` “Poder”; `colosseum.view.ColosseumPlayerItem.newPeople` “Iniciante”; `public.help` “Instruções”
  - subviews: `SimpleHelpFrame`, `PVPLeagueRankItem`

### yishi.view.guild.NameView

- **NameView** (`core_module:yishi/view/guild/NameView.as`)
  - `asset.rename.ReNameBgAsset` · bitmap 
    - `asset.rename.ReNameBgAsset` · bitmap 570×218 (rename.swf)
  - `asset.rename.InputNameTipAsset` · bitmap x=115 y=45
    - `asset.rename.InputNameTipAsset` · bitmap 181×24 (rename.swf)
  - `rename.ShaiziBtn` · BaseButton x=392 y=76
    - `asset.rename.ShaiziBtn` · bitmap 35×37 (rename.swf)
  - `rename.SubmitBtn` · IconButton x=235 y=161
    - `asset.core.Style9Btn` · bitmap 130×46 (core2.swf)
    - `asset.core.SubmitBtnAsset` · bitmap 102×24 (core.swf)
  - `rename.ReNameTxt` · FilterFrameText x=206 y=82 width=180 height=30 font `Arial,20,0xFFfA04,,,,,,center`
  - `rename.RenameFrameDescribeTxt` · FilterFrameText x=150 y=119 width=310 height=20 font `Arial,12,0xFF0000,,,,,,center`
  - texts: `noviceII.node.AddUserNameFrame.describt01` “Nome do Personagem deve conter de 4~12 caracteres”; `noviceII.node.AddUserNameFrame.describt02` “Nome do Personagem em branco!”; `noviceII.node.AddUserNameFrame.describt03` “Nome do Personagem muito curto!”; `noviceII.node.AddUserNameFrame.describt04` “Nome do Personagem muito longo!”; `noviceII.node.AddUserNameFrame.describt05` “Nome do Personagem contêm caracteres inválidos!”; `noviceII.node.AddUserNameFrame.describt08` “Nomeamento com sucesso”; `noviceII.view.AddUserNameFrame.checkNickErrorEvent2` “Falha ao carregar verificação de apelido”

### yishi.view.guild.NoviceArrowView

- **NoviceArrowView** (`core_module:yishi/view/guild/NoviceArrowView.as`)
  - `core.NoviceArrowGuide` · NoviceArrowGuide 
  - subviews: `NoviceArrowGuide`

### yishi.view.guild.QteGuideFrame

- **QteGuideFrame** (`core_module:yishi/view/guild/QteGuideFrame.as`)
  - `novice.FrameBack01` · Scale9CornerImage width=420 height=130
    - `asset.novice.frameback01` · bitmap 150×30 (novice.swf)
    - `asset.novice.frameback02` · bitmap 41×30 (novice.swf)
    - `asset.novice.frameback03` · bitmap 150×30 (novice.swf)
    - `asset.novice.frameback04` · bitmap 150×4 (novice.swf)
    - `asset.novice.frameback05` · bitmap 41×4 (novice.swf)
    - `asset.novice.frameback06` · bitmap 150×4 (novice.swf)
    - `asset.novice.frameback07` · bitmap 150×30 (novice.swf)
    - `asset.novice.frameback08` · bitmap 41×30 (novice.swf)
    - `asset.novice.frameback09` · bitmap 150×30 (novice.swf)
  - `asset.novice.DialogIcon` · bitmap 
    - `asset.novice.DialogIcon` · bitmap 160×170 (novice.swf)
  - `asset.novice.close` · IconButton x=265 y=115
    - `asset.novice.Profile.close` · bitmap 114×34 (novice.swf)
    - `asset.novice.Profile.ensure` · bitmap 59×19 (novice.swf)

### yishi.view.guild.QteUpgradeTipFrame

- **QteUpgradeTipFrame**: “Aviso” (`core_module:yishi/view/guild/QteUpgradeTipFrame.as`)
  - `noviceII.QteUpgradeTipFrame` · QteUpgradeTipFrame width=250 height=180
    - `core.FrameTitleText` · FilterFrameText  font `Arial,14,0xFFDD83,true`
    - `core.AlertTextStyle` · FilterFrameText width=91 height=20 font `Arial,14,0xFFefbd,,,,,,center`
    - `core.quickBuyFrameBg` · MutipleImage 
      - `core.AlertFrameBg` · MutipleImage 
        - `core.AlertFrameBaseBg` · Scale9CornerImage 
          - `asset.core.framestyle03_scale9bg1` · bitmap 42×42 (framebg.swf)
          - `asset.core.framestyle03_scale9bg2` · bitmap 42×42 (framebg.swf)
          - `asset.core.framestyle03_scale9bg3` · bitmap 42×42 (framebg.swf)
          - `asset.core.framestyle03_scale9bg4` · bitmap 42×18 (framebg.swf)
          - `asset.core.framestyle03_scale9bg5` · bitmap 42×18 (framebg.swf)
          - `asset.core.framestyle03_scale9bg6` · bitmap 42×18 (framebg.swf)
          - `asset.core.framestyle03_scale9bg7` · bitmap 42×42 (framebg.swf)
          - `asset.core.framestyle03_scale9bg8` · bitmap 42×42 (framebg.swf)
          - `asset.core.framestyle03_scale9bg9` · bitmap 42×42 (framebg.swf)
      - `core.FrameTitleImage2` · Image width=229 height=17
        - `asset.core.frameTitleImage2` · bitmap 229×17 (framebg.swf)
  - `novice.QteCheckBtn` · SelectedButton x=52 y=62 ← `core.checkstyle_2.CheckButton`
  - `novice.QteDescribeTitleTxt` · FilterFrameText x=2 y=28 width=250 height=75 font `Arial,14,0xe7c88b,,,,,,left`
  - `novice.QteDescribeTxt` · FilterFrameText x=2 y=60 width=250 height=75 font `Arial,14,0xe7c88b,,,,,,left`
  - `novice.QteCheckTxt` · FilterFrameText x=83 y=65 width=116 height=20 font `Arial,14,0xe7c88b,,,,,,center`
  - texts: `public.prompt` “Aviso”; `yishi.view.base.ThewAlertFrame.text` “Não alertar mais”

### yishi.view.newGuildHelp.NewGuildFrame

- **NewGuildFrame** (`core_module:yishi/view/newGuildHelp/NewGuildFrame.as`)
  - `core.newGuildHelpFrame` · NewGuildFrame width=835 height=610 ← `core.Frame2`
  - `core.newGuildFrame.preBtn` · BaseButton x=-20 y=250
    - `asset.core.preBtnBg` · bitmap 54×35 (core2.swf)
  - `core.newGuildFrame.nextBtn` · BaseButton x=728 y=250
    - `asset.core.nextBtnBg` · bitmap 56×36 (core2.swf)
  - `core.newGuildFrame.closeBtn` · IconButton x=125 y=465
    - `asset.core.consortia.infoFrameBtnBg` · bitmap 130×41 (core2.swf)
    - `asset.core.newGuildCloseTxt` · bitmap 63×20 (core2.swf)
  - `core.newGuildFrame.scanBtn` · IconButton x=525 y=465
    - `asset.core.consortia.infoFrameBtnBg` · bitmap 130×41 (core2.swf)
    - `asset.core.newGuildScanTxt` · bitmap 53×19 (core2.swf)
  - texts: `activity.view.ActivityItem.command01` “Clique excessivo, tente novamente”
  - subviews: `NewGuildView`

### yishi.view.newGuildHelp.NewGuildItem

- **NewGuildItem** (`core_module:yishi/view/newGuildHelp/NewGuildItem.as`)
  - `core.commonArrowImage2` · ScaleFrameImage 
    - `asset.core.commonArrowImage` · bitmap 95×57 (core2.swf)
  - `core.newGuildFrame.stepText` · FilterFrameText x=5 y=5 font `Arial,13,0xffdd83,,,,,,left`
  - `core.commonlineImage` · ScaleFrameImage 
    - `asset.core.commonlineImage01` · bitmap 57×10 (core2.swf)
    - `asset.core.commonlineImage02` · bitmap 57×35 (core2.swf)
  - `core.commonTipBg` · ScaleBitmapImage width=435
    - `asset.core.describeBackground_style07` · bitmap 260×82 (core2.swf)
  - `core.SimpleHelpText` · FilterFrameText x=5 y=5 font `Arial,13,0xffdd83,,,,,,left`

### yishi.view.tips.BaseTip

- **BaseTip** (`core_module:yishi/view/tips/BaseTip.as`)
  - `core.commonTipBg` · ScaleBitmapImage width=435
    - `asset.core.describeBackground_style07` · bitmap 260×82 (core2.swf)

### yishi.view.tips.ConsortiaNewBossBufferTip

- **ConsortiaNewBossBufferTip** (`core_module:yishi/view/tips/ConsortiaNewBossBufferTip.as`)
  - `tips.consortianewBoss.bufferNameTxt` · FilterFrameText x=5 y=5 width=120 height=40 font `Arial,14,0xff892a,,,,,,left`
  - `tips.consortianewBoss.bufferDescTxt` · FilterFrameText x=5 y=50 width=240 height=40 font `Arial,12,0xedbf83,,,,,,left`
  - `tips.consortianewBoss.recoverTxt` · FilterFrameText x=200 y=10 width=60 height=20 font `Arial,12,0xedbf83,,,,,,left`
  - `tips.ConsortiaNewBossUpdateTime` · TimeDownView x=150 y=10
    - `tips.ConsortiaNewBossUpdateTimeText` · FilterFrameText width=100 height=20 font `Arial,12,0xff0000,,,,,,left`
  - `asset.tips.splitLine` · bitmap x=-2
    - `asset.tips.splitLine` · bitmap 250×2 (army.swf)
  - texts: `ConsortiaNewBossFrame.disableTimeTxt2` “tempo válido”; `ConsortiaNewBossFrame.disableTimeTxt` “perde o efeito”
  - subviews: `TimeDownView`

### yishi.view.tips.ConsortiaNewBossDamageRewardTip

- **ConsortiaNewBossDamageRewardTip** (`core_module:yishi/view/tips/ConsortiaNewBossDamageRewardTip.as`)
  - `tips.TaskTraceNameText` · FilterFrameText x=8 y=0 width=170 height=22 font `Arial,14,0xffffff,true,,,,,left`
  - `tips.TaskTraceDescribeText` · FilterFrameText x=8 width=180 height=18 font `Arial,12,0xfffde9,,,,,,left`
  - `tips.consortianewBoss.selfDamageTxt2` · FilterFrameText x=15 y=10 width=120 height=24 font `Arial,12,0x48d72a,,,,,,left`
  - `tips.ringtask.rewaredTitle` · FilterFrameText x=10 font `Arial,12,0xfef500,,,,,,left`
  - `tips.TaskTraceLine` · ScaleBitmapImage x=0 width=110 ← `tips.HeroTipLine1`
  - `tips.TaskTraceLine` · ScaleBitmapImage x=0 width=110 ← `tips.HeroTipLine1`
  - texts: `yishi.view.tips.ConsortiaNewBossDamageRewardTip.titleTxt` “Prêmio de dano”; `yishi.view.tips.ConsortiaNewBossDamageRewardTip.selfDamageTxt1` “Meu dano:”; `yishi.view.tips.TaskTraceTip.rewardItem` “Prêmios:”
  - subviews: `HBox`, `TaskTraceRewardItem`

### yishi.view.tips.IMButtonTip

- **IMButtonTip** (`core_module:yishi/view/tips/IMButtonTip.as`)
  - `core.IMButtonTipText` · FilterFrameText  font `Arial,12,0xecdfa1`

### yishi.view.tips.MessageTipManager

- **MessageTipManager** (`core_module:yishi/view/tips/MessageTipManager.as`)
  - `tips.MessageTipAsset` · MovieImage 
    - `asset.tips.MessageTipAsset` · sprite 586.4×140.0 74 frames (core.swf)

### yishi.view.tips.MultiMessageTipItem

- **MultiMessageTipItem** (`core_module:yishi/view/tips/MultiMessageTipItem.as`)
  - `tips.MultiMessageTipItem.text` · FilterFrameText y=3 width=600 height=25 font `Arial,14,0xcc9900,true,,,,,center`

### yishi.view.tips.OneLineTip

- **OneLineTip** (`core_module:yishi/view/tips/OneLineTip.as`)
  - `mounts.OneLineTip` · OneLineTip 
  - `core.commonTipText` · FilterFrameText width=250 font `Arial,14,0xffffff`

### yishi.view.tips.StokesOreGoodsShowTip

- **StokesOreGoodsShowTip** (`core_module:yishi/view/tips/StokesOreGoodsShowTip.as`)
  - `tips.stokesOreGoodsShowTip.rewaredTitle` · TextFormat 
  - texts: `yishi.view.tips.rewardTxtTitle` “Tesouro”
  - subviews: `HBox`, `TaskTraceRewardItem`

### yishi.view.tips.SumCampaignTip

- **SumCampaignTip** (`core_module:yishi/view/tips/SumCampaignTip.as`)
  - `tips.TaskTraceNameVbox` · VBox x=0 y=5
  - `tips.SumCampaignNameText` · FilterFrameText x=8 y=0 width=100 height=22 font `Arial,12,0xffffff,,,,,,left`
  - `tips.TaskTraceLine` · ScaleBitmapImage x=0 width=110 ← `tips.HeroTipLine1`
  - `tips.ringtask.rewaredTitle` · FilterFrameText x=10 font `Arial,12,0xfef500,,,,,,left`
  - texts: `yishi.view.tips.SumCampaignTip.rewardNote` “Prêmio de conclusão da missão”; `yishi.view.tips.TaskTraceTip.rewardItem` “Prêmios:”
  - subviews: `HBox`, `TaskTraceRewardItem`

### yishi.view.tips.TaskTraceRewardItem

- **TaskTraceRewardItem** (`core_module:yishi/view/tips/TaskTraceRewardItem.as`)
  - `tips.BaseItemView` · BaseItemView 
    - `core.ItemBack` · ScaleBitmapImage x=1 y=1 width=45 height=45 ← `core.goods.ItemBack`
    - `core.BaseItemViewIcon` · BaseIconView x=1 y=1
      - `asset.core.IconLoading` · sprite 42 frames (core2.swf)
    - `core.GoodsProfileBG` · ScaleFrameImage 
      - `asset.core.BagProfileGreen` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileBlue` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfilePurple` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileOrange` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileRed` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileBlackKing` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileFashion` · bitmap 45×45 (core.swf)
    - `core.FashionLevel` · ScaleFrameImage 
      - `asset.core.fashionLevelNormal` · bitmap 21×21 (core.swf)
      - `asset.core.fashionLevelSpecial` · bitmap 21×21 (core.swf)
    - `core.BagCellLock` · ScaleFrameImage 
      - `asset.core.BagCellLock` · bitmap 45×45 (core.swf)
      - `asset.core.BagCellUnLock` · bitmap 45×45 (core.swf)
    - `core.goods.Strengthen` · MovieImage x=-50 y=-50
      - `asset.core.goods.Strengthen` · Strengthen 
  - `tips.rewardItemTxt` · FilterFrameText x=0 y=50 height=20 font `Arial,12,0xffffff`
  - subviews: `BaseItemView`

### yishi.view.tips.TaskTraceTip

- **TaskTraceTip** (`core_module:yishi/view/tips/TaskTraceTip.as`)
  - `tips.TaskTraceNameVbox` · VBox x=0 y=5
  - `tips.TaskTraceNameText` · FilterFrameText x=8 y=0 width=170 height=22 font `Arial,14,0xffffff,true,,,,,left`
  - `tips.TaskTraceLine` · ScaleBitmapImage x=0 width=110 ← `tips.HeroTipLine1`
  - `tips.TaskTraceDescribeText` · FilterFrameText x=8 width=180 height=18 font `Arial,12,0xfffde9,,,,,,left`
  - `tips.TaskTraceDescribeText` · FilterFrameText x=8 width=180 height=18 font `Arial,12,0xfffde9,,,,,,left`
  - `tips.TaskTraceDescribeText` · FilterFrameText x=8 width=180 height=18 font `Arial,12,0xfffde9,,,,,,left`
  - `tips.TaskTraceDescribeText` · FilterFrameText x=8 width=180 height=18 font `Arial,12,0xfffde9,,,,,,left`
  - `tips.TaskTraceDescribeText` · FilterFrameText x=8 width=180 height=18 font `Arial,12,0xfffde9,,,,,,left`
  - `tips.TaskTraceDescribeText` · FilterFrameText x=8 width=180 height=18 font `Arial,12,0xfffde9,,,,,,left`
  - `tips.TaskTraceDescribeText` · FilterFrameText x=8 width=180 height=18 font `Arial,12,0xfffde9,,,,,,left`
  - `tips.TaskTraceLine` · ScaleBitmapImage x=0 width=110 ← `tips.HeroTipLine1`
  - `tips.ringtask.rewaredTitle` · FilterFrameText x=10 font `Arial,12,0xfef500,,,,,,left`
  - `tips.ringtask.rewaredTitle` · FilterFrameText x=10 font `Arial,12,0xfef500,,,,,,left`
  - `tips.ringtask.rewaredItemName` · FilterFrameText x=25 font `Arial,12,0xfef500,,,,,,left`
  - `tips.ringtask.rewaredItemName` · FilterFrameText x=25 font `Arial,12,0xfef500,,,,,,left`
  - texts: `yishi.view.tips.TaskTraceTip.rewardItem` “Prêmios:”; `yishi.view.tips.TaskTraceTip.rewardItem01` “Prêmios             Prêmios de cada 50 ciclos       Prêmio d”; `yishi.view.tips.TaskTraceTip.rewardItem02` “Prêmio de cada 50 ciclos      Prêmio dos 200 ciclos”; `yishi.view.tips.TaskTraceTip.describeTxt` “Prêmio de Conclusão”; `yishi.view.tips.TaskTraceTip.gpTxt` “Experiência:”; `yishi.view.tips.TaskTraceTip.goldTxt` “Ouro:”; `yishi.view.tips.TaskTraceTip.soulTxt` “Espírito:”; `yishi.view.tips.TaskTraceTip.crystalTxt` “Cristal de Luz:”
  - subviews: `HBox`, `TaskTraceRewardItem`

### yishi.view.tips.TimeBoxTip

- **TimeBoxTip** (`core_module:yishi/view/tips/TimeBoxTip.as`)
  - `tips.tiemboxtiptitle` · FilterFrameText x=7 y=0 width=230 height=20 font `Arial,12,0xf5cc0f,,,,,,left`
  - `tips.timeboxtipVbox` · VBox x=9 y=65
  - texts: `box.timeBox.TimeBoxView.time` “Ao abrir o Baú de Tesouros do tempo poderá obter as seguinte”
  - subviews: `BaseBoxGoodsItem`

### yishi.view.tips.goods.ArtifactEquipItem

- **ArtifactEquipItem** (`core_module:yishi/view/tips/goods/ArtifactEquipItem.as`)
  - `asset.tips.attributeFlag` · bitmap x=4 y=4
    - `asset.tips.attributeFlag` · bitmap 9×9 (theseussoul.swf)
  - `tips.GoodAttackText` · FilterFrameText x=-4 ← `tips.GoodIntensifyText`
  - `tips.GoodAttackText` · FilterFrameText x=-4 ← `tips.GoodIntensifyText`

### yishi.view.tips.goods.ArtifactEquipTip

- **ArtifactEquipTip** (`core_module:yishi/view/tips/goods/ArtifactEquipTip.as`)
  - `core.whiteItemTipsBg` · Scale9CornerImage x=0 y=9 width=287
    - `asset.core.style45_scale9bg1` · bitmap 117×47 (core2.swf)
    - `asset.core.style45_scale9bg2` · bitmap 43×47 (core2.swf)
    - `asset.core.style45_scale9bg3` · bitmap 117×47 (core2.swf)
    - `asset.core.style45_scale9bg4` · bitmap 117×1 (core2.swf)
    - `asset.core.style45_scale9bg5` · bitmap 43×1 (core2.swf)
    - `asset.core.style45_scale9bg6` · bitmap 117×1 (core2.swf)
    - `asset.core.style45_scale9bg7` · bitmap 117×25 (core2.swf)
    - `asset.core.style45_scale9bg8` · bitmap 43×25 (core2.swf)
    - `asset.core.style45_scale9bg9` · bitmap 117×25 (core2.swf)
  - `tips.showItemBaseItemViewIcon` · BaseIconView x=1 y=-9
    - `asset.core.IconLoading` · sprite 42 frames (core2.swf)
  - `tips.profileImg` · ScaleFrameImage 
    - `asset.tips.greenProfileBg01` · bitmap x=0 y=-10
      - `asset.tips.greenProfileBg01` · bitmap 60×60 (tips.swf)
    - `asset.tips.blueProfileBg01` · bitmap x=0 y=-10
      - `asset.tips.blueProfileBg01` · bitmap 60×60 (tips.swf)
    - `asset.tips.purpleProlfileBg01` · bitmap x=0 y=-10
      - `asset.tips.purpleProlfileBg01` · bitmap 60×60 (tips.swf)
    - `asset.tips.yellowProfileBg01` · bitmap x=0 y=-10
      - `asset.tips.yellowProfileBg01` · bitmap 60×60 (tips.swf)
    - `asset.tips.redProfileBg01` · bitmap x=0 y=-10
      - `asset.tips.redProfileBg01` · bitmap 60×60 (tips.swf)
    - `asset.tips.blackProfileBg01` · bitmap x=0 y=-10
      - `asset.tips.blackProfileBg01` · bitmap 61×61 (tips.swf)
  - `tips.GoodsTotalBox` · VBox x=4
  - `tips.GoodNameText_3` · FilterFrameText x=71 y=15 width=210 height=40 font `Arial,14,0xffffff,,,,,,left`
  - `tips.GoodTypeText_2` · FilterFrameText x=-4 width=160 height=18 font `Arial,12,0xb3b3b3,,,,,,left`
  - `ancientartifact.propertyView.skillBaseItemView` · BaseItemView x=378 y=273
    - `ancientartifact.BaseItemViewIcon1` · BaseIconView x=1 y=1
      - `asset.core.IconLoading` · sprite 42 frames (core2.swf)
    - `ancientartifact.BaseItemText` · FilterFrameText x=15 y=40 width=42 height=16 font `Arial,12,0xffffff,true,,,,,right`
    - `core.GoodsProfileBG` · ScaleFrameImage 
      - `asset.core.BagProfileGreen` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileBlue` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfilePurple` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileOrange` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileRed` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileBlackKing` · bitmap 45×45 (core.swf)
      - `asset.core.BagProfileFashion` · bitmap 45×45 (core.swf)
  - `ancientartifact.propertyView.skillNameText` · FilterFrameText x=454 y=270 width=118 height=36 font `Arial,12,0xffffff,,,,,,left`
  - `ancientartifact.propertyView.skilllLevelText` · FilterFrameText x=454 y=312 width=180 height=20 font `Arial,14,0xffffff,,,,,,left`
  - `ancientartifact.propertyView.skillDescText` · FilterFrameText x=372 y=344 width=203 height=83 font `Arial,12,0xe4d29c,,,,,,left`
  - `asset.tips.splitLine` · bitmap x=-2
    - `asset.tips.splitLine` · bitmap 250×2 (army.swf)
  - `asset.tips.splitLine` · bitmap x=-2
    - `asset.tips.splitLine` · bitmap 250×2 (army.swf)
  - `asset.tips.splitLine` · bitmap x=-2
    - `asset.tips.splitLine` · bitmap 250×2 (army.swf)
  - texts: `ancientartifact.AncientEquipFrame.titleText` “Arma Divina”; `armyII.ThaneAttributeView.Tip40` “ATQ:”; `armyII.ThaneAttributeView.Tip41` “DEF:”; `armyII.ThaneAttributeView.Tip42` “MAG:”; `armyII.ThaneAttributeView.Tip43` “RES:”; `armyII.ThaneAttributeView.Tip37` “Penetração:”; `armyII.ThaneAttributeView.Tip38` “Bloqueio:”; `armyII.ThaneAttributeView.Tip39` “Vida:”
  - subviews: `Component`, `BaseIconView`, `BaseItemView`, `ArtifactEquipItem`

### yishi.view.tips.goods.AttributeTipsItem

- **AttributeTipsItem** (`core_module:yishi/view/tips/goods/AttributeTipsItem.as`)
  - `asset.tips.attributeFlag` · bitmap x=4 y=4
    - `asset.tips.attributeFlag` · bitmap 9×9 (theseussoul.swf)
  - `tips.attributeTxt` · FilterFrameText x=15 y=0 width=175 height=20 font `Arial,12,0x48d72a,,,,,,left`

### yishi.view.tips.goods.ChatEquipTips

- **ChatEquipTips** (`core_module:yishi/view/tips/goods/ChatEquipTips.as`)
  - `tips.ChatEquipCloseBtn` · BaseButton x=180 y=-4
    - `asset.core.closeBtn_style02` · bitmap 26×26 (core2.swf)
  - texts: `yishi.view.tips.goods.ChatEquipTips.gradeCount` “[Avaliação {0} pontos]”; `public.level` “Nv.”; `yishi.view.tips.goods.specialFashion` “Moda Especial”; `yishi.view.tips.goods.activeFashion` “Moda do Evento”; `yishi.view.tips.goods.normalFashion` “Moda Normal”; `yishi.view.tips.goods.PropTips.price` “Preço de venda {0} ouro”

### yishi.view.tips.goods.ChatFashionTips

- **ChatFashionTips** (`core_module:yishi/view/tips/goods/ChatFashionTips.as`)
  - `tips.ChatEquipCloseBtn` · BaseButton x=180 y=-4
    - `asset.core.closeBtn_style02` · bitmap 26×26 (core2.swf)

### yishi.view.tips.goods.ChatMonsterAccesoriesTips

- **ChatMonsterAccesoriesTips** (`core_module:yishi/view/tips/goods/ChatMonsterAccesoriesTips.as`)
  - `tips.ChatEquipCloseBtn` · BaseButton x=180 y=-4
    - `asset.core.closeBtn_style02` · bitmap 26×26 (core2.swf)

### yishi.view.tips.goods.ChatStarTip

- **ChatStarTip** (`core_module:yishi/view/tips/goods/ChatStarTip.as`)
  - `chat.StarItemIcon` · BaseIconView x=25 y=25
    - `asset.core.IconLoading` · sprite 42 frames (core2.swf)
  - `tips.ChatEquipCloseBtn` · BaseButton x=180 y=-4
    - `asset.core.closeBtn_style02` · bitmap 26×26 (core2.swf)
  - subviews: `BaseIconView`

### yishi.view.tips.goods.EquipGemTipItem

- **EquipGemTipItem** (`core_module:yishi/view/tips/goods/EquipGemTipItem.as`)
  - `asset.tips.equipGemBg` · bitmap 34×34 (tips.swf)
  - `asset.tips.equipHoldClosed02` · bitmap x=7 y=4
    - `asset.tips.equipHoldClosed02` · bitmap 19×19 (tips.swf)
  - `tip.equipGemIcon` · BaseIconView x=1 y=1
    - `asset.core.IconLoading` · sprite 42 frames (core2.swf)
  - `tips.profileImg02` · ScaleFrameImage 
    - `asset.tips.greenProfileBg02` · bitmap 33×33 (tips.swf)
    - `asset.tips.blueProfileBg02` · bitmap 33×33 (tips.swf)
    - `asset.tips.purpleProlfileBg02` · bitmap 33×33 (tips.swf)
    - `asset.tips.yellowProfileBg02` · bitmap 31×31 (tips.swf)
    - `asset.tips.redProfileBg02` · bitmap 33×33 (tips.swf)
    - `asset.tips.blackProfileBg02` · bitmap 45×45 (tips.swf)
  - `tips.gemAddStr` · FilterFrameText x=35 y=9 width=110 height=18 font `Arial,12,0x7b7b7b,,,,,,left`
  - texts: `yishi.view.tips.goods.InlayItem.value02` “Não inserido”; `yishi.view.tips.goods.InlayItem.value01` “Não aberto”
  - subviews: `BaseIconView`

### yishi.view.tips.goods.EquipSuitSkillItem

- **EquipSuitSkillItem** (`core_module:yishi/view/tips/goods/EquipSuitSkillItem.as`)
  - `asset.tips.attributeFlag` · bitmap x=4 y=4
    - `asset.tips.attributeFlag` · bitmap 9×9 (theseussoul.swf)
  - `tips.GoodSkillText` · FilterFrameText x=0 width=236 height=18 font `Arial,12,0x48d72a`

### yishi.view.tips.goods.EquipTip

- **EquipTip** (`core_module:yishi/view/tips/goods/EquipTip.as`)
  - `core.blackItemTipsBg` · Scale9CornerImage x=0 y=9 width=287
    - `asset.core.style48_scale9bg1` · bitmap 117×47 (core2.swf)
    - `asset.core.style48_scale9bg2` · bitmap 43×47 (core2.swf)
    - `asset.core.style48_scale9bg3` · bitmap 117×47 (core2.swf)
    - `asset.core.style46_scale9bg4` · bitmap 117×1 (core2.swf)
    - `asset.core.style46_scale9bg5` · bitmap 43×1 (core2.swf)
    - `asset.core.style46_scale9bg6` · bitmap 117×1 (core2.swf)
    - `asset.core.style46_scale9bg7` · bitmap 117×25 (core2.swf)
    - `asset.core.style46_scale9bg8` · bitmap 43×25 (core2.swf)
    - `asset.core.style46_scale9bg9` · bitmap 117×25 (core2.swf)
  - `core.redItemTipsBg` · Scale9CornerImage x=0 y=9 width=287
    - `asset.core.style46_scale9bg1` · bitmap 117×47 (core2.swf)
    - `asset.core.style46_scale9bg2` · bitmap 43×47 (core2.swf)
    - `asset.core.style46_scale9bg3` · bitmap 117×47 (core2.swf)
    - `asset.core.style46_scale9bg4` · bitmap 117×1 (core2.swf)
    - `asset.core.style46_scale9bg5` · bitmap 43×1 (core2.swf)
    - `asset.core.style46_scale9bg6` · bitmap 117×1 (core2.swf)
    - `asset.core.style46_scale9bg7` · bitmap 117×25 (core2.swf)
    - `asset.core.style46_scale9bg8` · bitmap 43×25 (core2.swf)
    - `asset.core.style46_scale9bg9` · bitmap 117×25 (core2.swf)
  - `core.yellowItemTipsBg` · Scale9CornerImage x=0 y=9 width=287
    - `asset.core.style41_scale9bg1` · bitmap 117×47 (core2.swf)
    - `asset.core.style41_scale9bg2` · bitmap 43×47 (core2.swf)
    - `asset.core.style41_scale9bg3` · bitmap 117×47 (core2.swf)
    - `asset.core.style41_scale9bg4` · bitmap 117×1 (core2.swf)
    - `asset.core.style41_scale9bg5` · bitmap 43×1 (core2.swf)
    - `asset.core.style41_scale9bg6` · bitmap 117×1 (core2.swf)
    - `asset.core.style41_scale9bg7` · bitmap 117×25 (core2.swf)
    - `asset.core.style41_scale9bg8` · bitmap 43×25 (core2.swf)
    - `asset.core.style41_scale9bg9` · bitmap 117×25 (core2.swf)
  - `core.purpleItemTipsBg` · Scale9CornerImage x=0 y=9 width=287
    - `asset.core.style42_scale9bg1` · bitmap 117×47 (core2.swf)
    - `asset.core.style42_scale9bg2` · bitmap 43×47 (core2.swf)
    - `asset.core.style42_scale9bg3` · bitmap 117×47 (core2.swf)
    - `asset.core.style42_scale9bg4` · bitmap 117×1 (core2.swf)
    - `asset.core.style42_scale9bg5` · bitmap 43×1 (core2.swf)
    - `asset.core.style42_scale9bg6` · bitmap 117×1 (core2.swf)
    - `asset.core.style42_scale9bg7` · bitmap 117×25 (core2.swf)
    - `asset.core.style42_scale9bg8` · bitmap 43×25 (core2.swf)
    - `asset.core.style42_scale9bg9` · bitmap 117×25 (core2.swf)
  - `core.blueItemTipsBg` · Scale9CornerImage x=0 y=9 width=287
    - `asset.core.style43_scale9bg1` · bitmap 117×47 (core2.swf)
    - `asset.core.style43_scale9bg2` · bitmap 43×47 (core2.swf)
    - `asset.core.style43_scale9bg3` · bitmap 117×47 (core2.swf)
    - `asset.core.style43_scale9bg4` · bitmap 117×1 (core2.swf)
    - `asset.core.style43_scale9bg5` · bitmap 43×1 (core2.swf)
    - `asset.core.style43_scale9bg6` · bitmap 117×1 (core2.swf)
    - `asset.core.style43_scale9bg7` · bitmap 117×25 (core2.swf)
    - `asset.core.style43_scale9bg8` · bitmap 43×25 (core2.swf)
    - `asset.core.style43_scale9bg9` · bitmap 117×25 (core2.swf)
  - `core.greenItemTipsBg` · Scale9CornerImage x=0 y=9 width=287
    - `asset.core.style44_scale9bg1` · bitmap 117×47 (core2.swf)
    - `asset.core.style44_scale9bg2` · bitmap 43×47 (core2.swf)
    - `asset.core.style44_scale9bg3` · bitmap 117×47 (core2.swf)
    - `asset.core.style44_scale9bg4` · bitmap 117×1 (core2.swf)
    - `asset.core.style44_scale9bg5` · bitmap 43×1 (core2.swf)
    - `asset.core.style44_scale9bg6` · bitmap 117×1 (core2.swf)
    - `asset.core.style44_scale9bg7` · bitmap 117×25 (core2.swf)
    - `asset.core.style44_scale9bg8` · bitmap 43×25 (core2.swf)
    - `asset.core.style44_scale9bg9` · bitmap 117×25 (core2.swf)
  - `core.whiteItemTipsBg` · Scale9CornerImage x=0 y=9 width=287
    - `asset.core.style45_scale9bg1` · bitmap 117×47 (core2.swf)
    - `asset.core.style45_scale9bg2` · bitmap 43×47 (core2.swf)
    - `asset.core.style45_scale9bg3` · bitmap 117×47 (core2.swf)
    - `asset.core.style45_scale9bg4` · bitmap 117×1 (core2.swf)
    - `asset.core.style45_scale9bg5` · bitmap 43×1 (core2.swf)
    - `asset.core.style45_scale9bg6` · bitmap 117×1 (core2.swf)
    - `asset.core.style45_scale9bg7` · bitmap 117×25 (core2.swf)
    - `asset.core.style45_scale9bg8` · bitmap 43×25 (core2.swf)
    - `asset.core.style45_scale9bg9` · bitmap 117×25 (core2.swf)
  - `asset.tips.splitLine` · bitmap x=-2
    - `asset.tips.splitLine` · bitmap 250×2 (army.swf)
  - `tips.GoodsTotalBox` · VBox x=4
  - `tips.GoodsEquiped_2` · FilterFrameText x=87 y=0 width=180 height=20 font `Arial,14,0x00FF00,true,,,,,center`
  - `tips.GoodgradeCountText` · FilterFrameText x=0 width=230 height=18 font `Arial,12,0x01f0ed,,,,,,left`
  - `tips.GoodPriceText` · FilterFrameText x=35 width=200 height=18 font `Arial,12,0xffffff,,,,,,right`
  - `tips.GoodsTimeTxt` · FilterFrameText x=0 width=176 height=18 font `Arial,12,0x8eea17`
  - `tips.GoodsSendTxt` · FilterFrameText x=0 width=226 height=40 font `Arial,12,0x979797`
  - `tips.fashionIdentityTipTxt` · FilterFrameText x=0 width=178 height=20 font `Arial,12,0xc50000,,,,,,left`
  - `tips.fashionProfileTxt` · FilterFrameText width=50 height=20 font `Arial,12,0x32a2f8,,,,,,left`
  - `asset.fashion.StarLevelLightImg` · bitmap 17×17 (core.swf)
  - `asset.fashion.StarLeveldarkImg` · bitmap 17×17 (core.swf)
  - texts: `yishi.view.tips.goods.EquipTip.equiped` “Equipamento Atual”; `yishi.view.tips.goods.ChatEquipTips.gradeCount` “[Avaliação {0} pontos]”; `public.level` “Nv.”; `yishi.view.tips.goods.specialFashion` “Moda Especial”; `yishi.view.tips.goods.activeFashion` “Moda do Evento”; `yishi.view.tips.goods.normalFashion` “Moda Normal”; `yishi.view.tips.goods.PropTips.price` “Preço de venda {0} ouro”; `yishi.view.tips.goods.EquipTip.time.text` “Validade”
  - subviews: `HBox`, `EquipTipsContent`

### yishi.view.tips.goods.EquipTipsContent

- **EquipTipsContent** (`core_module:yishi/view/tips/goods/EquipTipsContent.as`)
  - `tips.showItemBaseItemViewIcon` · BaseIconView x=1 y=-9
    - `asset.core.IconLoading` · sprite 42 frames (core2.swf)
  - `tips.profileImg` · ScaleFrameImage 
    - `asset.tips.greenProfileBg01` · bitmap x=0 y=-10
      - `asset.tips.greenProfileBg01` · bitmap 60×60 (tips.swf)
    - `asset.tips.blueProfileBg01` · bitmap x=0 y=-10
      - `asset.tips.blueProfileBg01` · bitmap 60×60 (tips.swf)
    - `asset.tips.purpleProlfileBg01` · bitmap x=0 y=-10
      - `asset.tips.purpleProlfileBg01` · bitmap 60×60 (tips.swf)
    - `asset.tips.yellowProfileBg01` · bitmap x=0 y=-10
      - `asset.tips.yellowProfileBg01` · bitmap 60×60 (tips.swf)
    - `asset.tips.redProfileBg01` · bitmap x=0 y=-10
      - `asset.tips.redProfileBg01` · bitmap 60×60 (tips.swf)
    - `asset.tips.blackProfileBg01` · bitmap x=0 y=-10
      - `asset.tips.blackProfileBg01` · bitmap 61×61 (tips.swf)
  - `asset.tips.addImg` · bitmap x=0 y=10
    - `asset.tips.addImg` · bitmap 19×22 (tips.swf)
  - `asset.tips.numImg` · bitmap 
    - `asset.tips.numImg` · bitmap 190×22 (tips.swf)
  - `tips.GoodTypeText` · FilterFrameText x=0 width=120 height=18 font `Arial,12,0xffffff,,,,,,left`
  - `tips.GoodTypeText` · FilterFrameText x=0 width=120 height=18 font `Arial,12,0xffffff,,,,,,left`
  - `tips.GoodNameText_3` · FilterFrameText x=71 y=15 width=210 height=40 font `Arial,14,0xffffff,,,,,,left`
  - `tips.castSelectedTxt` · FilterFrameText x=76 y=44 width=195 height=20 font `Arial,12,0xff0000,,,,,,right`
  - `tips.FashionLevelText` · FilterFrameText x=72 y=0 width=150 height=20 font `Arial,13,0xff9b00,,,,,,right`
  - `tips.GoodIntensifyText_2` · FilterFrameText x=141 width=220 height=18 font `Arial,12,0xb3b3b3,,,,,,right`
  - `tips.EquipContent.IsActivateTxt` · FilterFrameText x=130 width=130 height=20 font `Arial,12,0xecdb07,,,,,,right`
  - `tips.GoodsTotalBox` · VBox x=4
  - `tips.GoodsSubBox` · VBox x=0 y=0
  - `tips.GoodsSubBox` · VBox x=0 y=0
  - `tips.GoodsSubBox3` · VBox x=0 y=0
  - `tips.GoodVocationText` · FilterFrameText x=130 width=230 height=18 font `Arial,12,0xb3b3b3,,,,,,right`
  - `tips.GoodTypeText_2` · FilterFrameText x=-4 width=160 height=18 font `Arial,12,0xb3b3b3,,,,,,left`
  - `tips.GoodGradeText` · FilterFrameText x=-4 width=225 ← `tips.GoodIntensifyText`
  - `tips.GoodBindText` · FilterFrameText x=107 width=120 height=18 font `Arial,12,0xee1a38,,,,,,left`
  - `tips.GoodSkillText` · FilterFrameText x=0 width=236 height=18 font `Arial,12,0x48d72a`
  - `tips.GoodDescribeText` · FilterFrameText x=0 width=220 height=18 font `Arial,12,0xe9c68c`
  - `asset.tips.splitLine` · bitmap x=-2
    - `asset.tips.splitLine` · bitmap 250×2 (army.swf)
  - `asset.tips.splitLine` · bitmap x=-2
    - `asset.tips.splitLine` · bitmap 250×2 (army.swf)
  - `asset.tips.splitLine` · bitmap x=-2
    - `asset.tips.splitLine` · bitmap 250×2 (army.swf)
  - `asset.tips.splitLine` · bitmap x=-2
    - `asset.tips.splitLine` · bitmap 250×2 (army.swf)
  - `asset.tips.splitLine` · bitmap x=-2
    - `asset.tips.splitLine` · bitmap 250×2 (army.swf)
  - `tips.SuitTitleText` · FilterFrameText x=0 width=226 height=18 font `Arial,12,0xf5cc0f`
  - `tips.SuitItemText` · FilterFrameText x=0 width=206 height=18 font `Arial,12,0x7d7d7d`
  - `tips.SuitItemText` · FilterFrameText x=0 width=206 height=18 font `Arial,12,0x7d7d7d`
  - `tips.SuitItemText` · FilterFrameText x=0 width=206 height=18 font `Arial,12,0x7d7d7d`
  - `tips.SuitItemText` · FilterFrameText x=0 width=206 height=18 font `Arial,12,0x7d7d7d`
  - `tips.SuitItemText` · FilterFrameText x=0 width=206 height=18 font `Arial,12,0x7d7d7d`
  - `tips.SuitItemText` · FilterFrameText x=0 width=206 height=18 font `Arial,12,0x7d7d7d`
  - `tips.SuitItemText` · FilterFrameText x=0 width=206 height=18 font `Arial,12,0x7d7d7d`
  - `tips.SuitItemText` · FilterFrameText x=0 width=206 height=18 font `Arial,12,0x7d7d7d`
  - texts: `yishi.view.tips.goods.EquipTipsContent.castSelected.text4` “[Molde de Deus {0} rank {1} dia]”; `yishi.view.tips.goods.EquipTipsContent.castSelected.text3` “[Molde de Deus {0} rank {1} mês ]”; `yishi.view.tips.goods.EquipTipsContent.castSelected.text2` “[Molde de Deus nv.{0} {1} estrelas]”; `yishi.view.tips.goods.EquipTipsContent.castSelected.text1` “Não pode ser moldado”; `yishi.view.tips.goods.EquipTipsContent.fashionFullLevel` “Nv. Máx”; `yishi.view.tips.goods.EquipTipsContent.fashionLevel` “Nv.”; `yishi.view.tips.goods.EquipTipsContent.intensify` “(Fortalecimento até Nv. {0})”; `mountTip.IsActivateTxt` “Já foi activado”
  - subviews: `VBox`, `BaseIconView`, `EquipGemTipItem`, `EquipRefreshTipItem`, `EquipSuitSkillItem`, `GoodAttributeItem`, `SkillTipItem`

### yishi.view.tips.goods.FashionAttItem

- **FashionAttItem** (`core_module:yishi/view/tips/goods/FashionAttItem.as`)
  - `asset.tips.attributeFlag` · bitmap x=4 y=4
    - `asset.tips.attributeFlag` · bitmap 9×9 (theseussoul.swf)
  - `tips.simpleGoodSkillText` · FilterFrameText x=10 width=252 height=18 font `Arial,12,0x48d72a`

### yishi.view.tips.goods.FashionCardTip

- **FashionCardTip** (`core_module:yishi/view/tips/goods/FashionCardTip.as`)
  - `core.blackItemTipsBg` · Scale9CornerImage x=0 y=9 width=287
    - `asset.core.style48_scale9bg1` · bitmap 117×47 (core2.swf)
    - `asset.core.style48_scale9bg2` · bitmap 43×47 (core2.swf)
    - `asset.core.style48_scale9bg3` · bitmap 117×47 (core2.swf)
    - `asset.core.style46_scale9bg4` · bitmap 117×1 (core2.swf)
    - `asset.core.style46_scale9bg5` · bitmap 43×1 (core2.swf)
    - `asset.core.style46_scale9bg6` · bitmap 117×1 (core2.swf)
    - `asset.core.style46_scale9bg7` · bitmap 117×25 (core2.swf)
    - `asset.core.style46_scale9bg8` · bitmap 43×25 (core2.swf)
    - `asset.core.style46_scale9bg9` · bitmap 117×25 (core2.swf)
  - `core.redItemTipsBg` · Scale9CornerImage x=0 y=9 width=287
    - `asset.core.style46_scale9bg1` · bitmap 117×47 (core2.swf)
    - `asset.core.style46_scale9bg2` · bitmap 43×47 (core2.swf)
    - `asset.core.style46_scale9bg3` · bitmap 117×47 (core2.swf)
    - `asset.core.style46_scale9bg4` · bitmap 117×1 (core2.swf)
    - `asset.core.style46_scale9bg5` · bitmap 43×1 (core2.swf)
    - `asset.core.style46_scale9bg6` · bitmap 117×1 (core2.swf)
    - `asset.core.style46_scale9bg7` · bitmap 117×25 (core2.swf)
    - `asset.core.style46_scale9bg8` · bitmap 43×25 (core2.swf)
    - `asset.core.style46_scale9bg9` · bitmap 117×25 (core2.swf)
  - `core.yellowItemTipsBg` · Scale9CornerImage x=0 y=9 width=287
    - `asset.core.style41_scale9bg1` · bitmap 117×47 (core2.swf)
    - `asset.core.style41_scale9bg2` · bitmap 43×47 (core2.swf)
    - `asset.core.style41_scale9bg3` · bitmap 117×47 (core2.swf)
    - `asset.core.style41_scale9bg4` · bitmap 117×1 (core2.swf)
    - `asset.core.style41_scale9bg5` · bitmap 43×1 (core2.swf)
    - `asset.core.style41_scale9bg6` · bitmap 117×1 (core2.swf)
    - `asset.core.style41_scale9bg7` · bitmap 117×25 (core2.swf)
    - `asset.core.style41_scale9bg8` · bitmap 43×25 (core2.swf)
    - `asset.core.style41_scale9bg9` · bitmap 117×25 (core2.swf)
  - `core.purpleItemTipsBg` · Scale9CornerImage x=0 y=9 width=287
    - `asset.core.style42_scale9bg1` · bitmap 117×47 (core2.swf)
    - `asset.core.style42_scale9bg2` · bitmap 43×47 (core2.swf)
    - `asset.core.style42_scale9bg3` · bitmap 117×47 (core2.swf)
    - `asset.core.style42_scale9bg4` · bitmap 117×1 (core2.swf)
    - `asset.core.style42_scale9bg5` · bitmap 43×1 (core2.swf)
    - `asset.core.style42_scale9bg6` · bitmap 117×1 (core2.swf)
    - `asset.core.style42_scale9bg7` · bitmap 117×25 (core2.swf)
    - `asset.core.style42_scale9bg8` · bitmap 43×25 (core2.swf)
    - `asset.core.style42_scale9bg9` · bitmap 117×25 (core2.swf)
  - `core.blueItemTipsBg` · Scale9CornerImage x=0 y=9 width=287
    - `asset.core.style43_scale9bg1` · bitmap 117×47 (core2.swf)
    - `asset.core.style43_scale9bg2` · bitmap 43×47 (core2.swf)
    - `asset.core.style43_scale9bg3` · bitmap 117×47 (core2.swf)
    - `asset.core.style43_scale9bg4` · bitmap 117×1 (core2.swf)
    - `asset.core.style43_scale9bg5` · bitmap 43×1 (core2.swf)
    - `asset.core.style43_scale9bg6` · bitmap 117×1 (core2.swf)
    - `asset.core.style43_scale9bg7` · bitmap 117×25 (core2.swf)
    - `asset.core.style43_scale9bg8` · bitmap 43×25 (core2.swf)
    - `asset.core.style43_scale9bg9` · bitmap 117×25 (core2.swf)
  - `core.greenItemTipsBg` · Scale9CornerImage x=0 y=9 width=287
    - `asset.core.style44_scale9bg1` · bitmap 117×47 (core2.swf)
    - `asset.core.style44_scale9bg2` · bitmap 43×47 (core2.swf)
    - `asset.core.style44_scale9bg3` · bitmap 117×47 (core2.swf)
    - `asset.core.style44_scale9bg4` · bitmap 117×1 (core2.swf)
    - `asset.core.style44_scale9bg5` · bitmap 43×1 (core2.swf)
    - `asset.core.style44_scale9bg6` · bitmap 117×1 (core2.swf)
    - `asset.core.style44_scale9bg7` · bitmap 117×25 (core2.swf)
    - `asset.core.style44_scale9bg8` · bitmap 43×25 (core2.swf)
    - `asset.core.style44_scale9bg9` · bitmap 117×25 (core2.swf)
  - `core.whiteItemTipsBg` · Scale9CornerImage x=0 y=9 width=287
    - `asset.core.style45_scale9bg1` · bitmap 117×47 (core2.swf)
    - `asset.core.style45_scale9bg2` · bitmap 43×47 (core2.swf)
    - `asset.core.style45_scale9bg3` · bitmap 117×47 (core2.swf)
    - `asset.core.style45_scale9bg4` · bitmap 117×1 (core2.swf)
    - `asset.core.style45_scale9bg5` · bitmap 43×1 (core2.swf)
    - `asset.core.style45_scale9bg6` · bitmap 117×1 (core2.swf)
    - `asset.core.style45_scale9bg7` · bitmap 117×25 (core2.swf)
    - `asset.core.style45_scale9bg8` · bitmap 43×25 (core2.swf)
    - `asset.core.style45_scale9bg9` · bitmap 117×25 (core2.swf)
  - `asset.tips.splitLine` · bitmap x=-2
    - `asset.tips.splitLine` · bitmap 250×2 (army.swf)
  - `tips.GoodsTotalBox` · VBox x=4
  - `tips.GoodsEquiped_2` · FilterFrameText x=87 y=0 width=180 height=20 font `Arial,14,0x00FF00,true,,,,,center`
  - `tips.GoodgradeCountText` · FilterFrameText x=0 width=230 height=18 font `Arial,12,0x01f0ed,,,,,,left`
  - `tips.GoodPriceText` · FilterFrameText x=35 width=200 height=18 font `Arial,12,0xffffff,,,,,,right`
  - `tips.GoodsTimeTxt` · FilterFrameText x=0 width=176 height=18 font `Arial,12,0x8eea17`
  - `tips.GoodsSendTxt` · FilterFrameText x=0 width=226 height=40 font `Arial,12,0x979797`
  - `tips.goodsFightingTxt` · FilterFrameText x=133 y=0 width=205 height=20 font `Arial,12,0x00fffc,,,,,,right`
  - `tips.fashionIdentityTipTxt` · FilterFrameText x=0 width=178 height=20 font `Arial,12,0xc50000,,,,,,left`
  - `tips.fashionProfileTxt` · FilterFrameText width=50 height=20 font `Arial,12,0x32a2f8,,,,,,left`
  - `view.ShowAvatar` · ShowAvatar y=91
  - `tips.fashionComposeNoteTxt` · FilterFrameText x=0 width=270 height=20 font `Arial,12,0xb3b3b3,,,,,,left`
  - `asset.fashion.StarLevelLightImg` · bitmap 17×17 (core.swf)
  - `asset.fashion.StarLeveldarkImg` · bitmap 17×17 (core.swf)
  - texts: `yishi.view.tips.goods.EquipTip.equiped` “Equipamento Atual”; `yishi.view.tips.goods.ChatEquipTips.gradeCount` “[Avaliação {0} pontos]”; `public.level` “Nv.”; `yishi.view.tips.goods.FashionCardTip.fashionNoteTxt` “Após absorver na tela de absorção da moda poderá obter as co”; `yishi.view.tips.goods.PropTips.price` “Preço de venda {0} ouro”; `yishi.view.tips.goods.EquipTip.time.text` “Validade”; `yishi.view.tips.goods.EquipTip.fightingTxt` “Poder de Combate: {0}”; `yishi.view.tips.goods.EquipTip.timeStr02` “Expirado”
  - subviews: `ShowAvatar`, `HBox`, `EquipTipsContent`

### yishi.view.tips.goods.FashionComposeTip

- **FashionComposeTip** (`core_module:yishi/view/tips/goods/FashionComposeTip.as`)
  - `core.purpleItemTipsBg` · Scale9CornerImage x=0 y=9 width=287
    - `asset.core.style42_scale9bg1` · bitmap 117×47 (core2.swf)
    - `asset.core.style42_scale9bg2` · bitmap 43×47 (core2.swf)
    - `asset.core.style42_scale9bg3` · bitmap 117×47 (core2.swf)
    - `asset.core.style42_scale9bg4` · bitmap 117×1 (core2.swf)
    - `asset.core.style42_scale9bg5` · bitmap 43×1 (core2.swf)
    - `asset.core.style42_scale9bg6` · bitmap 117×1 (core2.swf)
    - `asset.core.style42_scale9bg7` · bitmap 117×25 (core2.swf)
    - `asset.core.style42_scale9bg8` · bitmap 43×25 (core2.swf)
    - `asset.core.style42_scale9bg9` · bitmap 117×25 (core2.swf)
  - `tips.SkillTotalBox` · VBox x=10 y=10
  - `tips.skilltiptile.bg` · Image x=0 y=0
    - `asset.tips.skilltiptile.bg` · bitmap 254×47 (tips.swf)
  - `tips.skilltitle.titleTxt` · FilterFrameText x=10 y=15 width=200 height=20 font `Arial,14,0xFFFDE9,,,,,,left`
  - `asset.tips.splitLine` · bitmap x=-2
    - `asset.tips.splitLine` · bitmap 250×2 (army.swf)
  - `tips.SkillSubBox` · VBox x=0 y=0
  - `tips.skilltiptile.bg` · Image x=0 y=0
    - `asset.tips.skilltiptile.bg` · bitmap 254×47 (tips.swf)
  - `tips.skilltitle.titleTxt` · FilterFrameText x=10 y=15 width=200 height=20 font `Arial,14,0xFFFDE9,,,,,,left`
  - `asset.tips.splitLine` · bitmap x=-2
    - `asset.tips.splitLine` · bitmap 250×2 (army.swf)
  - `tips.SkillSubBox` · VBox x=0 y=0
  - texts: `fashioncomposetip.current` “Absorção de Moda	Nível Atual”; `fashioncomposetip.next` “Absorção de Moda	Próximo Nível”; `fashioncomposetip.maxGrade` “Absorção de Moda	Já está no nível máximo.”
  - subviews: `EquipRefreshTipItem`

### yishi.view.tips.goods.GoodAttributeItem

- **GoodAttributeItem** (`core_module:yishi/view/tips/goods/GoodAttributeItem.as`)
  - `asset.tips.attributeFlag` · bitmap x=4 y=4
    - `asset.tips.attributeFlag` · bitmap 9×9 (theseussoul.swf)
  - `tips.GoodAttackText` · FilterFrameText x=-4 ← `tips.GoodIntensifyText`
  - `tips.GoodAttackText` · FilterFrameText x=-4 ← `tips.GoodIntensifyText`
  - `tips.GoodAttackAddText` · FilterFrameText width=270 font `Arial,12,0x48d72a` ← `tips.GoodIntensifyText`
  - `tips.goodsenchant_t1` · TextFormat 
  - texts: `yishi.view.tips.goods.GoodAttributeItem.text01` “Fortalecer”; `yishi.view.tips.goods.GoodAttributeItem.text02` “Molde Divino”; `yishi.view.tips.goods.GoodAttributeItem.text03` “Molde Divino”; `yishi.view.tips.goods.GoodAttributeItem.text04` “[encantar]”

### yishi.view.tips.goods.GroupbuyCheckTips

- **GroupbuyCheckTips** (`core_module:yishi/view/tips/goods/GroupbuyCheckTips.as`)
  - `groupbuy.checktips.tips` · GroupbuyCheckTips 
  - `groupbuychecktips.txt` · FilterFrameText x=10 y=10 width=176 height=36 font `Arial,12,0xffffff`
  - texts: `funny.groupbuy.checktips` “Após terminar a compra em grupo terá a probabilidade de ter ”

### yishi.view.tips.goods.InlayItem

- **InlayItem** (`core_module:yishi/view/tips/goods/InlayItem.as`)
  - `tips.MountIcon` · ScaleFrameImage x=0 y=0 width=19
    - `asset.tips.equipMount1` · bitmap 
      - `asset.tips.equipMount1` · bitmap 19×19 (tips.swf)
    - `asset.tips.equipMount2` · bitmap 
      - `asset.tips.equipMount2` · bitmap 19×19 (tips.swf)
    - `asset.tips.equipMount3` · bitmap 
      - `asset.tips.equipMount3` · bitmap 19×19 (tips.swf)
    - `asset.tips.equipMount4` · bitmap 
      - `asset.tips.equipMount4` · bitmap 19×19 (tips.swf)
    - `asset.tips.equipMount5` · bitmap 
      - `asset.tips.equipMount5` · bitmap 19×19 (tips.swf)
    - `asset.tips.equipMount6` · bitmap 19×19 (tips.swf)
    - `asset.tips.equipMount7` · bitmap 19×19 (tips.swf)
    - `asset.tips.equipMount8` · bitmap 19×19 (tips.swf)
    - `asset.tips.equipHoldClosed` · bitmap 
    - `asset.tips.equipUnmount` · bitmap 
      - `asset.tips.equipUnmount` · bitmap 19×19 (tips.swf)
  - `tips.GoodMountText` · FilterFrameText x=23 width=210 height=18 font `Arial,12,0x7b7b7b,,,,,,left`
  - texts: `yishi.view.tips.goods.InlayItem.value01` “Não aberto”; `yishi.view.tips.goods.InlayItem.value02` “Não inserido”

### yishi.view.tips.goods.MagicCardTip

- **MagicCardTip** (`core_module:yishi/view/tips/goods/MagicCardTip.as`)
  - `tips.GoodNameText_3` · FilterFrameText x=71 y=15 width=210 height=40 font `Arial,14,0xffffff,,,,,,left`
  - `tips.GoodBindText1` · FilterFrameText x=135 width=100 height=20 font `Arial,12,0xee1a38,,,,,,left`
  - `tips.CardPropertyText` · FilterFrameText x=0 y=0 width=250 height=20 font `Arial,12,0xffffff`
  - `tips.GoodDescribeText` · FilterFrameText x=0 width=220 height=18 font `Arial,12,0xe9c68c`
  - `tips.GoodPriceText` · FilterFrameText x=35 width=200 height=18 font `Arial,12,0xffffff,,,,,,right`
  - `tips.GoodsTotalBox` · VBox x=4
  - `tips.GoodGradeText` · FilterFrameText x=-4 width=225 ← `tips.GoodIntensifyText`
  - `tips.GoodsSendTxt` · FilterFrameText x=0 width=226 height=40 font `Arial,12,0x979797`
  - `core.yellowItemTipsBg` · Scale9CornerImage x=0 y=9 width=287
    - `asset.core.style41_scale9bg1` · bitmap 117×47 (core2.swf)
    - `asset.core.style41_scale9bg2` · bitmap 43×47 (core2.swf)
    - `asset.core.style41_scale9bg3` · bitmap 117×47 (core2.swf)
    - `asset.core.style41_scale9bg4` · bitmap 117×1 (core2.swf)
    - `asset.core.style41_scale9bg5` · bitmap 43×1 (core2.swf)
    - `asset.core.style41_scale9bg6` · bitmap 117×1 (core2.swf)
    - `asset.core.style41_scale9bg7` · bitmap 117×25 (core2.swf)
    - `asset.core.style41_scale9bg8` · bitmap 43×25 (core2.swf)
    - `asset.core.style41_scale9bg9` · bitmap 117×25 (core2.swf)
  - `core.purpleItemTipsBg` · Scale9CornerImage x=0 y=9 width=287
    - `asset.core.style42_scale9bg1` · bitmap 117×47 (core2.swf)
    - `asset.core.style42_scale9bg2` · bitmap 43×47 (core2.swf)
    - `asset.core.style42_scale9bg3` · bitmap 117×47 (core2.swf)
    - `asset.core.style42_scale9bg4` · bitmap 117×1 (core2.swf)
    - `asset.core.style42_scale9bg5` · bitmap 43×1 (core2.swf)
    - `asset.core.style42_scale9bg6` · bitmap 117×1 (core2.swf)
    - `asset.core.style42_scale9bg7` · bitmap 117×25 (core2.swf)
    - `asset.core.style42_scale9bg8` · bitmap 43×25 (core2.swf)
    - `asset.core.style42_scale9bg9` · bitmap 117×25 (core2.swf)
  - `core.blueItemTipsBg` · Scale9CornerImage x=0 y=9 width=287
    - `asset.core.style43_scale9bg1` · bitmap 117×47 (core2.swf)
    - `asset.core.style43_scale9bg2` · bitmap 43×47 (core2.swf)
    - `asset.core.style43_scale9bg3` · bitmap 117×47 (core2.swf)
    - `asset.core.style43_scale9bg4` · bitmap 117×1 (core2.swf)
    - `asset.core.style43_scale9bg5` · bitmap 43×1 (core2.swf)
    - `asset.core.style43_scale9bg6` · bitmap 117×1 (core2.swf)
    - `asset.core.style43_scale9bg7` · bitmap 117×25 (core2.swf)
    - `asset.core.style43_scale9bg8` · bitmap 43×25 (core2.swf)
    - `asset.core.style43_scale9bg9` · bitmap 117×25 (core2.swf)
  - `core.greenItemTipsBg` · Scale9CornerImage x=0 y=9 width=287
    - `asset.core.style44_scale9bg1` · bitmap 117×47 (core2.swf)
    - `asset.core.style44_scale9bg2` · bitmap 43×47 (core2.swf)
    - `asset.core.style44_scale9bg3` · bitmap 117×47 (core2.swf)
    - `asset.core.style44_scale9bg4` · bitmap 117×1 (core2.swf)
    - `asset.core.style44_scale9bg5` · bitmap 43×1 (core2.swf)
    - `asset.core.style44_scale9bg6` · bitmap 117×1 (core2.swf)
    - `asset.core.style44_scale9bg7` · bitmap 117×25 (core2.swf)
    - `asset.core.style44_scale9bg8` · bitmap 43×25 (core2.swf)
    - `asset.core.style44_scale9bg9` · bitmap 117×25 (core2.swf)
  - `core.whiteItemTipsBg` · Scale9CornerImage x=0 y=9 width=287
    - `asset.core.style45_scale9bg1` · bitmap 117×47 (core2.swf)
    - `asset.core.style45_scale9bg2` · bitmap 43×47 (core2.swf)
    - `asset.core.style45_scale9bg3` · bitmap 117×47 (core2.swf)
    - `asset.core.style45_scale9bg4` · bitmap 117×1 (core2.swf)
    - `asset.core.style45_scale9bg5` · bitmap 43×1 (core2.swf)
    - `asset.core.style45_scale9bg6` · bitmap 117×1 (core2.swf)
    - `asset.core.style45_scale9bg7` · bitmap 117×25 (core2.swf)
    - `asset.core.style45_scale9bg8` · bitmap 43×25 (core2.swf)
    - `asset.core.style45_scale9bg9` · bitmap 117×25 (core2.swf)
  - `tips.showItemBaseItemViewIcon` · BaseIconView x=1 y=-9
    - `asset.core.IconLoading` · sprite 42 frames (core2.swf)
  - `tips.profileImg` · ScaleFrameImage 
    - `asset.tips.greenProfileBg01` · bitmap x=0 y=-10
      - `asset.tips.greenProfileBg01` · bitmap 60×60 (tips.swf)
    - `asset.tips.blueProfileBg01` · bitmap x=0 y=-10
      - `asset.tips.blueProfileBg01` · bitmap 60×60 (tips.swf)
    - `asset.tips.purpleProlfileBg01` · bitmap x=0 y=-10
      - `asset.tips.purpleProlfileBg01` · bitmap 60×60 (tips.swf)
    - `asset.tips.yellowProfileBg01` · bitmap x=0 y=-10
      - `asset.tips.yellowProfileBg01` · bitmap 60×60 (tips.swf)
    - `asset.tips.redProfileBg01` · bitmap x=0 y=-10
      - `asset.tips.redProfileBg01` · bitmap 60×60 (tips.swf)
    - `asset.tips.blackProfileBg01` · bitmap x=0 y=-10
      - `asset.tips.blackProfileBg01` · bitmap 61×61 (tips.swf)
  - `asset.tips.splitLine` · bitmap x=-2
    - `asset.tips.splitLine` · bitmap 250×2 (army.swf)
  - `asset.tips.splitLine` · bitmap x=-2
    - `asset.tips.splitLine` · bitmap 250×2 (army.swf)
  - subviews: `BaseIconView`

### yishi.view.tips.goods.MonsterAccessoriesTipsContent

- **MonsterAccessoriesTipsContent** (`core_module:yishi/view/tips/goods/MonsterAccessoriesTipsContent.as`)
  - `tips.showItemBaseItemViewIcon` · BaseIconView x=1 y=-9
    - `asset.core.IconLoading` · sprite 42 frames (core2.swf)
  - `tips.profileImg` · ScaleFrameImage 
    - `asset.tips.greenProfileBg01` · bitmap x=0 y=-10
      - `asset.tips.greenProfileBg01` · bitmap 60×60 (tips.swf)
    - `asset.tips.blueProfileBg01` · bitmap x=0 y=-10
      - `asset.tips.blueProfileBg01` · bitmap 60×60 (tips.swf)
    - `asset.tips.purpleProlfileBg01` · bitmap x=0 y=-10
      - `asset.tips.purpleProlfileBg01` · bitmap 60×60 (tips.swf)
    - `asset.tips.yellowProfileBg01` · bitmap x=0 y=-10
      - `asset.tips.yellowProfileBg01` · bitmap 60×60 (tips.swf)
    - `asset.tips.redProfileBg01` · bitmap x=0 y=-10
      - `asset.tips.redProfileBg01` · bitmap 60×60 (tips.swf)
    - `asset.tips.blackProfileBg01` · bitmap x=0 y=-10
      - `asset.tips.blackProfileBg01` · bitmap 61×61 (tips.swf)
  - `tips.GoodNameText_3` · FilterFrameText x=71 y=15 width=210 height=40 font `Arial,14,0xffffff,,,,,,left`
  - `tips.GoodTypeText_2` · FilterFrameText x=-4 width=160 height=18 font `Arial,12,0xb3b3b3,,,,,,left`
  - `tips.GoodVocationText` · FilterFrameText x=130 width=230 height=18 font `Arial,12,0xb3b3b3,,,,,,right`
  - `tips.GoodIntensifyText_2` · FilterFrameText x=141 width=220 height=18 font `Arial,12,0xb3b3b3,,,,,,right`
  - `tips.SkillCoolDownText` · FilterFrameText width=260 height=18 font `Arial,12,0xffffff,,,,,,left`
  - `tips.GoodsTotalBox` · VBox x=4
  - `tips.GoodsSubBox` · VBox x=0 y=0
  - `tips.GoodsSubBox` · VBox x=0 y=0
  - `tips.GoodsSubBox3` · VBox x=0 y=0
  - `tips.GoodsSubBox3` · VBox x=0 y=0
  - `asset.tips.splitLine` · bitmap x=-2
    - `asset.tips.splitLine` · bitmap 250×2 (army.swf)
  - `asset.tips.splitLine` · bitmap x=-2
    - `asset.tips.splitLine` · bitmap 250×2 (army.swf)
  - `asset.tips.splitLine` · bitmap x=-2
    - `asset.tips.splitLine` · bitmap 250×2 (army.swf)
  - `asset.tips.splitLine` · bitmap x=-2
    - `asset.tips.splitLine` · bitmap 250×2 (army.swf)
  - `tip.MonsterAccessoriesTips.effectTitleTxt` · FilterFrameText x=10 width=100 height=20 font `Arial,12,0xfec400,,,,,,left`
  - `tip.MonsterAccessoriesTips.effectTxt` · FilterFrameText x=10 width=250 height=40 font `Arial,12,0xfeff00,,,,,,left`
  - `tips.GoodsSendTxt` · FilterFrameText x=0 width=226 height=40 font `Arial,12,0x979797`
  - `tip.MonsterAccessoriesTips.mainAttText` · FilterFrameText x=10 width=200 height=20 font `Arial,12,0xffff00,,,,,,left`
  - texts: `public.level2` “Nv.{0}”; `yishi.view.tips.goods.EquipTipsContent.intensify` “(Fortalecimento até Nv. {0})”; `MonsterAccessoriesTipsContent.wearGradesTxt.text` “Nv. de estrela vestido: {0}”; `MonsterAccessoriesTipsContent.effectTitleTxt.text` “Efeito sendo ativado:”; `MonsterAccessoriesTipsContent.effectTxt.text` “Não há efeito sendo ativado”; `yishi.view.tips.goods.EquipTip.send.text` “clique esquerdo: Enviar ao chat”
  - subviews: `BaseIconView`, `MonsterAccessoriesTipsItem`

### yishi.view.tips.goods.MonsterAccessoriesTipsItem

- **MonsterAccessoriesTipsItem** (`core_module:yishi/view/tips/goods/MonsterAccessoriesTipsItem.as`)
  - `tips.MonsterAccessoriesTipsItem.icon` · ScaleFrameImage x=0 y=10
    - `asset.MonsterAccessoriesTips.icon1` · bitmap 17×17 (tips.swf)
    - `asset.MonsterAccessoriesTips.icon2` · bitmap 17×17 (tips.swf)
  - `tips.MonsterAccessoriesTipsItem.txt` · FilterFrameText x=10 y=1 width=270 height=24 font `Arial,14,0x59cd41,,,,,,left`
  - texts: `MonsterAccessoriesEffectItem.txt.text` “(Ativado ao se fortalecer ao nível {0})”; `MonsterAccessoriesEffectItem.txt.text2` “{0}(nv. {1})”

### yishi.view.tips.goods.MonsterTips

- **MonsterTips** (`core_module:yishi/view/tips/goods/MonsterTips.as`)
  - `core.whiteItemTipsBg` · Scale9CornerImage x=0 y=9 width=287
    - `asset.core.style45_scale9bg1` · bitmap 117×47 (core2.swf)
    - `asset.core.style45_scale9bg2` · bitmap 43×47 (core2.swf)
    - `asset.core.style45_scale9bg3` · bitmap 117×47 (core2.swf)
    - `asset.core.style45_scale9bg4` · bitmap 117×1 (core2.swf)
    - `asset.core.style45_scale9bg5` · bitmap 43×1 (core2.swf)
    - `asset.core.style45_scale9bg6` · bitmap 117×1 (core2.swf)
    - `asset.core.style45_scale9bg7` · bitmap 117×25 (core2.swf)
    - `asset.core.style45_scale9bg8` · bitmap 43×25 (core2.swf)
    - `asset.core.style45_scale9bg9` · bitmap 117×25 (core2.swf)
  - `tips.showItemBaseItemViewIcon` · BaseIconView x=1 y=-9
    - `asset.core.IconLoading` · sprite 42 frames (core2.swf)
  - `tips.profileImg` · ScaleFrameImage 
    - `asset.tips.greenProfileBg01` · bitmap x=0 y=-10
      - `asset.tips.greenProfileBg01` · bitmap 60×60 (tips.swf)
    - `asset.tips.blueProfileBg01` · bitmap x=0 y=-10
      - `asset.tips.blueProfileBg01` · bitmap 60×60 (tips.swf)
    - `asset.tips.purpleProlfileBg01` · bitmap x=0 y=-10
      - `asset.tips.purpleProlfileBg01` · bitmap 60×60 (tips.swf)
    - `asset.tips.yellowProfileBg01` · bitmap x=0 y=-10
      - `asset.tips.yellowProfileBg01` · bitmap 60×60 (tips.swf)
    - `asset.tips.redProfileBg01` · bitmap x=0 y=-10
      - `asset.tips.redProfileBg01` · bitmap 60×60 (tips.swf)
    - `asset.tips.blackProfileBg01` · bitmap x=0 y=-10
      - `asset.tips.blackProfileBg01` · bitmap 61×61 (tips.swf)
  - `tips.GoodsTotalBox` · VBox x=4
  - `tips.GoodNameText_3` · FilterFrameText x=71 y=15 width=210 height=40 font `Arial,14,0xffffff,,,,,,left`
  - `tips.GoodTypeText_2` · FilterFrameText x=-4 width=160 height=18 font `Arial,12,0xb3b3b3,,,,,,left`
  - `asset.tips.splitLine` · bitmap x=-2
    - `asset.tips.splitLine` · bitmap 250×2 (army.swf)
  - `asset.tips.splitLine` · bitmap x=-2
    - `asset.tips.splitLine` · bitmap 250×2 (army.swf)
  - `tips.GoodIntensifyText_2` · FilterFrameText x=141 width=220 height=18 font `Arial,12,0xb3b3b3,,,,,,right`
  - `tips.GoodIntensifyText_2` · FilterFrameText x=141 width=220 height=18 font `Arial,12,0xb3b3b3,,,,,,right`
  - `MonsterTips.fightText` · FilterFrameText x=5 width=200 height=20 font `Arial,12,0xb3b3b3,,,,,,left`
  - `MonsterTips.starHbox` · HBox x=0 y=30
  - `asset.monster.StarTipsImg` · bitmap 21×20 (tips.swf)
  - texts: `MonsterFrame.title.text` “Monstro”; `ChildNursingSpiritItem.fightText.text` “Poder de Combate: {0}”; `public.level2` “Nv.{0}”; `MonsterTips.gradeAlertText.text` “Pode elevar até o nv. {0}”
  - subviews: `BaseIconView`, `ArtifactEquipItem`

### yishi.view.tips.goods.MouldItem

- **MouldItem** (`core_module:yishi/view/tips/goods/MouldItem.as`)
  - `core.MouldTitleText` · FilterFrameText x=0 y=3 width=156 height=18 font `Arial,12,0xf5cc0f`
  - `core.MouldSubBox` · VBox x=0 y=21
  - `core.MouldItemText` · FilterFrameText x=0 y=0 width=156 height=20 font `Arial,12,0x7d7d7d`
  - `core.MouldItemText` · FilterFrameText x=0 y=0 width=156 height=20 font `Arial,12,0x7d7d7d`
  - `core.MouldItemText` · FilterFrameText x=0 y=0 width=156 height=20 font `Arial,12,0x7d7d7d`
  - `core.MouldItemText` · FilterFrameText x=0 y=0 width=156 height=20 font `Arial,12,0x7d7d7d`
  - `core.MouldItemText` · FilterFrameText x=0 y=0 width=156 height=20 font `Arial,12,0x7d7d7d`
  - `core.MouldItemText` · FilterFrameText x=0 y=0 width=156 height=20 font `Arial,12,0x7d7d7d`
  - `core.MouldItemText` · FilterFrameText x=0 y=0 width=156 height=20 font `Arial,12,0x7d7d7d`
  - `core.MouldItemText` · FilterFrameText x=0 y=0 width=156 height=20 font `Arial,12,0x7d7d7d`
  - `core.MouldItemText` · FilterFrameText x=0 y=0 width=156 height=20 font `Arial,12,0x7d7d7d`
  - `core.MouldItemText` · FilterFrameText x=0 y=0 width=156 height=20 font `Arial,12,0x7d7d7d`
  - `core.MouldItemText` · FilterFrameText x=0 y=0 width=156 height=20 font `Arial,12,0x7d7d7d`
  - `core.MouldItemText` · FilterFrameText x=0 y=0 width=156 height=20 font `Arial,12,0x7d7d7d`
  - `core.MouldItemText` · FilterFrameText x=0 y=0 width=156 height=20 font `Arial,12,0x7d7d7d`
  - `core.MouldStarBar` · MovieImage x=0 y=21 width=17 height=17
    - `asset.core.StoreCastStar` · sprite 10 frames (core.swf)
  - `core.MouldMoonBar` · MovieImage x=0 y=21 width=17 height=17
    - `asset.core.StoreCastMoon` · sprite 10 frames (core.swf)
  - `core.MouldDayBar` · MovieImage x=0 y=21 width=17 height=17
    - `asset.core.StoreCastDay` · sprite 10 frames (core.swf)
  - texts: `yishi.view.tips.goods.MouldItem.Tips01` “Molde Divino Épico [Nv. {0}]”; `yishi.view.tips.goods.MouldItem.Tips02` “Molde Divino Épico (Bloqueado)”; `armyII.ThaneAttributeView.Tip01` “Força”; `armyII.ThaneAttributeView.Tip02` “Proteção”; `armyII.ThaneAttributeView.Tip03` “Inteligência”; `armyII.ThaneAttributeView.Tip04` “Físico”; `armyII.ThaneAttributeView.Tip05` “Liderança”; `armyII.ThaneAttributeView.Tip13` “Ataque”

### yishi.view.tips.goods.MountCardTip

- **MountCardTip** (`core_module:yishi/view/tips/goods/MountCardTip.as`)
  - `core.yellowItemTipsBg` · Scale9CornerImage x=0 y=9 width=287
    - `asset.core.style41_scale9bg1` · bitmap 117×47 (core2.swf)
    - `asset.core.style41_scale9bg2` · bitmap 43×47 (core2.swf)
    - `asset.core.style41_scale9bg3` · bitmap 117×47 (core2.swf)
    - `asset.core.style41_scale9bg4` · bitmap 117×1 (core2.swf)
    - `asset.core.style41_scale9bg5` · bitmap 43×1 (core2.swf)
    - `asset.core.style41_scale9bg6` · bitmap 117×1 (core2.swf)
    - `asset.core.style41_scale9bg7` · bitmap 117×25 (core2.swf)
    - `asset.core.style41_scale9bg8` · bitmap 43×25 (core2.swf)
    - `asset.core.style41_scale9bg9` · bitmap 117×25 (core2.swf)
  - `core.purpleItemTipsBg` · Scale9CornerImage x=0 y=9 width=287
    - `asset.core.style42_scale9bg1` · bitmap 117×47 (core2.swf)
    - `asset.core.style42_scale9bg2` · bitmap 43×47 (core2.swf)
    - `asset.core.style42_scale9bg3` · bitmap 117×47 (core2.swf)
    - `asset.core.style42_scale9bg4` · bitmap 117×1 (core2.swf)
    - `asset.core.style42_scale9bg5` · bitmap 43×1 (core2.swf)
    - `asset.core.style42_scale9bg6` · bitmap 117×1 (core2.swf)
    - `asset.core.style42_scale9bg7` · bitmap 117×25 (core2.swf)
    - `asset.core.style42_scale9bg8` · bitmap 43×25 (core2.swf)
    - `asset.core.style42_scale9bg9` · bitmap 117×25 (core2.swf)
  - `core.blueItemTipsBg` · Scale9CornerImage x=0 y=9 width=287
    - `asset.core.style43_scale9bg1` · bitmap 117×47 (core2.swf)
    - `asset.core.style43_scale9bg2` · bitmap 43×47 (core2.swf)
    - `asset.core.style43_scale9bg3` · bitmap 117×47 (core2.swf)
    - `asset.core.style43_scale9bg4` · bitmap 117×1 (core2.swf)
    - `asset.core.style43_scale9bg5` · bitmap 43×1 (core2.swf)
    - `asset.core.style43_scale9bg6` · bitmap 117×1 (core2.swf)
    - `asset.core.style43_scale9bg7` · bitmap 117×25 (core2.swf)
    - `asset.core.style43_scale9bg8` · bitmap 43×25 (core2.swf)
    - `asset.core.style43_scale9bg9` · bitmap 117×25 (core2.swf)
  - `core.greenItemTipsBg` · Scale9CornerImage x=0 y=9 width=287
    - `asset.core.style44_scale9bg1` · bitmap 117×47 (core2.swf)
    - `asset.core.style44_scale9bg2` · bitmap 43×47 (core2.swf)
    - `asset.core.style44_scale9bg3` · bitmap 117×47 (core2.swf)
    - `asset.core.style44_scale9bg4` · bitmap 117×1 (core2.swf)
    - `asset.core.style44_scale9bg5` · bitmap 43×1 (core2.swf)
    - `asset.core.style44_scale9bg6` · bitmap 117×1 (core2.swf)
    - `asset.core.style44_scale9bg7` · bitmap 117×25 (core2.swf)
    - `asset.core.style44_scale9bg8` · bitmap 43×25 (core2.swf)
    - `asset.core.style44_scale9bg9` · bitmap 117×25 (core2.swf)
  - `core.whiteItemTipsBg` · Scale9CornerImage x=0 y=9 width=287
    - `asset.core.style45_scale9bg1` · bitmap 117×47 (core2.swf)
    - `asset.core.style45_scale9bg2` · bitmap 43×47 (core2.swf)
    - `asset.core.style45_scale9bg3` · bitmap 117×47 (core2.swf)
    - `asset.core.style45_scale9bg4` · bitmap 117×1 (core2.swf)
    - `asset.core.style45_scale9bg5` · bitmap 43×1 (core2.swf)
    - `asset.core.style45_scale9bg6` · bitmap 117×1 (core2.swf)
    - `asset.core.style45_scale9bg7` · bitmap 117×25 (core2.swf)
    - `asset.core.style45_scale9bg8` · bitmap 43×25 (core2.swf)
    - `asset.core.style45_scale9bg9` · bitmap 117×25 (core2.swf)
  - `tips.showItemBaseItemViewIcon` · BaseIconView x=1 y=-9
    - `asset.core.IconLoading` · sprite 42 frames (core2.swf)
  - `tips.profileImg` · ScaleFrameImage 
    - `asset.tips.greenProfileBg01` · bitmap x=0 y=-10
      - `asset.tips.greenProfileBg01` · bitmap 60×60 (tips.swf)
    - `asset.tips.blueProfileBg01` · bitmap x=0 y=-10
      - `asset.tips.blueProfileBg01` · bitmap 60×60 (tips.swf)
    - `asset.tips.purpleProlfileBg01` · bitmap x=0 y=-10
      - `asset.tips.purpleProlfileBg01` · bitmap 60×60 (tips.swf)
    - `asset.tips.yellowProfileBg01` · bitmap x=0 y=-10
      - `asset.tips.yellowProfileBg01` · bitmap 60×60 (tips.swf)
    - `asset.tips.redProfileBg01` · bitmap x=0 y=-10
      - `asset.tips.redProfileBg01` · bitmap 60×60 (tips.swf)
    - `asset.tips.blackProfileBg01` · bitmap x=0 y=-10
      - `asset.tips.blackProfileBg01` · bitmap 61×61 (tips.swf)
  - `tips.GoodNameText_3` · FilterFrameText x=71 y=15 width=210 height=40 font `Arial,14,0xffffff,,,,,,left`
  - `tips.GoodsTypeTxt` · FilterFrameText x=72 y=0 width=130 height=20 font `Arial,12,0xfff206`
  - `tips.GoodBindText1` · FilterFrameText x=135 width=100 height=20 font `Arial,12,0xee1a38,,,,,,left`
  - `tips.GoodPriceText` · FilterFrameText x=35 width=200 height=18 font `Arial,12,0xffffff,,,,,,right`
  - `tips.GoodsTotalBox` · VBox x=4
  - `tips.GoodGradeText` · FilterFrameText x=-4 width=225 ← `tips.GoodIntensifyText`
  - `tips.GoodsSendTxt` · FilterFrameText x=0 width=226 height=40 font `Arial,12,0x979797`
  - `tips.MountTipTxt` · FilterFrameText x=0 y=0 width=175 height=200 font `Arial,12,0x48d72a,,,,,,left`
  - `tips.MountTipTxt` · FilterFrameText x=0 y=0 width=175 height=200 font `Arial,12,0x48d72a,,,,,,left`
  - `tips.MountTipTxt` · FilterFrameText x=0 y=0 width=175 height=200 font `Arial,12,0x48d72a,,,,,,left`
  - `tips.MountTipTxt.IsActivateTxt` · FilterFrameText x=150 y=0 width=175 height=24 font `Arial,14,0xecdb07,,,,,,left`
  - `mounts.areaType` · ScaleFrameImage 
    - `asset.mountsTips.magicIcon` · bitmap 25×25 (core.swf)
    - `asset.mountsTips.livestockIcon` · bitmap 25×25 (core.swf)
    - `asset.mountsTips.beastIcon` · bitmap 25×25 (core.swf)
    - `asset.mountsTips.technologyIcon` · bitmap 25×25 (core.swf)
  - `asset.tips.splitLine` · bitmap x=-2
    - `asset.tips.splitLine` · bitmap 250×2 (army.swf)
  - `asset.tips.splitLine` · bitmap x=-2
    - `asset.tips.splitLine` · bitmap 250×2 (army.swf)
  - `asset.tips.splitLine` · bitmap x=-2
    - `asset.tips.splitLine` · bitmap 250×2 (army.swf)
  - `asset.tips.splitLine` · bitmap x=-2
    - `asset.tips.splitLine` · bitmap 250×2 (army.swf)
  - texts: `yishi.view.tips.goods.EquipTipsContent.bind1` “Vinculado”; `yishi.view.tips.goods.EquipTipsContent.bind2` “Não vinculado”; `mounts.WildsoulItem.tips01` “Força +{0}|Inteligência +{0}|Físico +{0}|Proteção +{0}|Nível”; `mountTip.soulscore` “Ponto Bestial +{0}”; `mounts.WildsoulItem.forever` “Validade: Permanente”; `mounts.WildsoulItem.tips02` “Validade: {0} dias”; `mountTip.MountCardTip.noRefreshTxt` “Não é possível decompor”; `yishi.view.tips.goods.PropTips.price` “Preço de venda {0} ouro”
  - subviews: `VBox`, `BaseIconView`, `AttributeTipsItem`

### yishi.view.tips.goods.PropTips

- **PropTips** (`core_module:yishi/view/tips/goods/PropTips.as`)
  - `tips.GoodNameText_3` · FilterFrameText x=71 y=15 width=210 height=40 font `Arial,14,0xffffff,,,,,,left`
  - `tips.GoodsTypeTxt` · FilterFrameText x=72 y=0 width=130 height=20 font `Arial,12,0xfff206`
  - `tips.GoodBindText1` · FilterFrameText x=135 width=100 height=20 font `Arial,12,0xee1a38,,,,,,left`
  - `tips.GoodDescribeText` · FilterFrameText x=0 width=220 height=18 font `Arial,12,0xe9c68c`
  - `tips.GoodDescribeText` · FilterFrameText x=0 width=220 height=18 font `Arial,12,0xe9c68c`
  - `tips.GoodsTimeTxt` · FilterFrameText x=0 width=176 height=18 font `Arial,12,0x8eea17`
  - `tips.GoodPriceText` · FilterFrameText x=35 width=200 height=18 font `Arial,12,0xffffff,,,,,,right`
  - `tips.GoodsTotalBox` · VBox x=4
  - `tips.GoodGradeText_2` · FilterFrameText width=130 height=20 font `Arial,12,0xb3b3b3,,,,,,right`
  - `tips.GoodsSendTxt` · FilterFrameText x=0 width=226 height=40 font `Arial,12,0x979797`
  - `core.blackItemTipsBg` · Scale9CornerImage x=0 y=9 width=287
    - `asset.core.style48_scale9bg1` · bitmap 117×47 (core2.swf)
    - `asset.core.style48_scale9bg2` · bitmap 43×47 (core2.swf)
    - `asset.core.style48_scale9bg3` · bitmap 117×47 (core2.swf)
    - `asset.core.style46_scale9bg4` · bitmap 117×1 (core2.swf)
    - `asset.core.style46_scale9bg5` · bitmap 43×1 (core2.swf)
    - `asset.core.style46_scale9bg6` · bitmap 117×1 (core2.swf)
    - `asset.core.style46_scale9bg7` · bitmap 117×25 (core2.swf)
    - `asset.core.style46_scale9bg8` · bitmap 43×25 (core2.swf)
    - `asset.core.style46_scale9bg9` · bitmap 117×25 (core2.swf)
  - `core.redItemTipsBg` · Scale9CornerImage x=0 y=9 width=287
    - `asset.core.style46_scale9bg1` · bitmap 117×47 (core2.swf)
    - `asset.core.style46_scale9bg2` · bitmap 43×47 (core2.swf)
    - `asset.core.style46_scale9bg3` · bitmap 117×47 (core2.swf)
    - `asset.core.style46_scale9bg4` · bitmap 117×1 (core2.swf)
    - `asset.core.style46_scale9bg5` · bitmap 43×1 (core2.swf)
    - `asset.core.style46_scale9bg6` · bitmap 117×1 (core2.swf)
    - `asset.core.style46_scale9bg7` · bitmap 117×25 (core2.swf)
    - `asset.core.style46_scale9bg8` · bitmap 43×25 (core2.swf)
    - `asset.core.style46_scale9bg9` · bitmap 117×25 (core2.swf)
  - `core.yellowItemTipsBg` · Scale9CornerImage x=0 y=9 width=287
    - `asset.core.style41_scale9bg1` · bitmap 117×47 (core2.swf)
    - `asset.core.style41_scale9bg2` · bitmap 43×47 (core2.swf)
    - `asset.core.style41_scale9bg3` · bitmap 117×47 (core2.swf)
    - `asset.core.style41_scale9bg4` · bitmap 117×1 (core2.swf)
    - `asset.core.style41_scale9bg5` · bitmap 43×1 (core2.swf)
    - `asset.core.style41_scale9bg6` · bitmap 117×1 (core2.swf)
    - `asset.core.style41_scale9bg7` · bitmap 117×25 (core2.swf)
    - `asset.core.style41_scale9bg8` · bitmap 43×25 (core2.swf)
    - `asset.core.style41_scale9bg9` · bitmap 117×25 (core2.swf)
  - `core.purpleItemTipsBg` · Scale9CornerImage x=0 y=9 width=287
    - `asset.core.style42_scale9bg1` · bitmap 117×47 (core2.swf)
    - `asset.core.style42_scale9bg2` · bitmap 43×47 (core2.swf)
    - `asset.core.style42_scale9bg3` · bitmap 117×47 (core2.swf)
    - `asset.core.style42_scale9bg4` · bitmap 117×1 (core2.swf)
    - `asset.core.style42_scale9bg5` · bitmap 43×1 (core2.swf)
    - `asset.core.style42_scale9bg6` · bitmap 117×1 (core2.swf)
    - `asset.core.style42_scale9bg7` · bitmap 117×25 (core2.swf)
    - `asset.core.style42_scale9bg8` · bitmap 43×25 (core2.swf)
    - `asset.core.style42_scale9bg9` · bitmap 117×25 (core2.swf)
  - `core.blueItemTipsBg` · Scale9CornerImage x=0 y=9 width=287
    - `asset.core.style43_scale9bg1` · bitmap 117×47 (core2.swf)
    - `asset.core.style43_scale9bg2` · bitmap 43×47 (core2.swf)
    - `asset.core.style43_scale9bg3` · bitmap 117×47 (core2.swf)
    - `asset.core.style43_scale9bg4` · bitmap 117×1 (core2.swf)
    - `asset.core.style43_scale9bg5` · bitmap 43×1 (core2.swf)
    - `asset.core.style43_scale9bg6` · bitmap 117×1 (core2.swf)
    - `asset.core.style43_scale9bg7` · bitmap 117×25 (core2.swf)
    - `asset.core.style43_scale9bg8` · bitmap 43×25 (core2.swf)
    - `asset.core.style43_scale9bg9` · bitmap 117×25 (core2.swf)
  - `core.greenItemTipsBg` · Scale9CornerImage x=0 y=9 width=287
    - `asset.core.style44_scale9bg1` · bitmap 117×47 (core2.swf)
    - `asset.core.style44_scale9bg2` · bitmap 43×47 (core2.swf)
    - `asset.core.style44_scale9bg3` · bitmap 117×47 (core2.swf)
    - `asset.core.style44_scale9bg4` · bitmap 117×1 (core2.swf)
    - `asset.core.style44_scale9bg5` · bitmap 43×1 (core2.swf)
    - `asset.core.style44_scale9bg6` · bitmap 117×1 (core2.swf)
    - `asset.core.style44_scale9bg7` · bitmap 117×25 (core2.swf)
    - `asset.core.style44_scale9bg8` · bitmap 43×25 (core2.swf)
    - `asset.core.style44_scale9bg9` · bitmap 117×25 (core2.swf)
  - `core.whiteItemTipsBg` · Scale9CornerImage x=0 y=9 width=287
    - `asset.core.style45_scale9bg1` · bitmap 117×47 (core2.swf)
    - `asset.core.style45_scale9bg2` · bitmap 43×47 (core2.swf)
    - `asset.core.style45_scale9bg3` · bitmap 117×47 (core2.swf)
    - `asset.core.style45_scale9bg4` · bitmap 117×1 (core2.swf)
    - `asset.core.style45_scale9bg5` · bitmap 43×1 (core2.swf)
    - `asset.core.style45_scale9bg6` · bitmap 117×1 (core2.swf)
    - `asset.core.style45_scale9bg7` · bitmap 117×25 (core2.swf)
    - `asset.core.style45_scale9bg8` · bitmap 43×25 (core2.swf)
    - `asset.core.style45_scale9bg9` · bitmap 117×25 (core2.swf)
  - `tips.showItemBaseItemViewIcon` · BaseIconView x=1 y=-9
    - `asset.core.IconLoading` · sprite 42 frames (core2.swf)
  - `tips.profileImg` · ScaleFrameImage 
    - `asset.tips.greenProfileBg01` · bitmap x=0 y=-10
      - `asset.tips.greenProfileBg01` · bitmap 60×60 (tips.swf)
    - `asset.tips.blueProfileBg01` · bitmap x=0 y=-10
      - `asset.tips.blueProfileBg01` · bitmap 60×60 (tips.swf)
    - `asset.tips.purpleProlfileBg01` · bitmap x=0 y=-10
      - `asset.tips.purpleProlfileBg01` · bitmap 60×60 (tips.swf)
    - `asset.tips.yellowProfileBg01` · bitmap x=0 y=-10
      - `asset.tips.yellowProfileBg01` · bitmap 60×60 (tips.swf)
    - `asset.tips.redProfileBg01` · bitmap x=0 y=-10
      - `asset.tips.redProfileBg01` · bitmap 60×60 (tips.swf)
    - `asset.tips.blackProfileBg01` · bitmap x=0 y=-10
      - `asset.tips.blackProfileBg01` · bitmap 61×61 (tips.swf)
  - `asset.tips.splitLine` · bitmap x=-2
    - `asset.tips.splitLine` · bitmap 250×2 (army.swf)
  - `asset.tips.splitLine` · bitmap x=-2
    - `asset.tips.splitLine` · bitmap 250×2 (army.swf)
  - `asset.tips.splitLine` · bitmap x=-2
    - `asset.tips.splitLine` · bitmap 250×2 (army.swf)
  - texts: `yishi.view.tips.goods.EquipTipsContent.bind1` “Vinculado”; `yishi.view.tips.goods.EquipTipsContent.bind2` “Não vinculado”; `yishi.view.tips.goods.PropTips.price` “Preço de venda {0} ouro”; `yishi.view.tips.goods.EquipTipsContent.grade02` “Nível necessário: {0}”; `TimesPropTip01` “Hoje já foi ativado”; `TimesPropTip02` “Hoje ainda não foi liberado”; `TimesPropTip03` “Pode abrir uma vez por dia, e pode-se coletar {0} vez(es)”; `yishi.view.tips.goods.EquipTip.timeStr01` “Permanente”
  - subviews: `BaseIconView`

### yishi.view.tips.goods.QuizRewordTips

- **QuizRewordTips** (`core_module:yishi/view/tips/goods/QuizRewordTips.as`)
  - `quiz.reword.tips` · QuizRewordTips 
  - `quiz.tips.txt1` · FilterFrameText x=10 y=8 width=92 height=20 font `Arial,12,0xFFffff,,,,,,left`
  - `quiz.tips.txt2` · FilterFrameText x=10 y=28 width=92 height=20 font `Arial,12,0xFFe400,,,,,,left`
  - `quiz.tips.txt3` · FilterFrameText x=10 y=54 width=92 height=20 font `Arial,12,0xFFffff,,,,,,left`
  - `quiz.tips.txt4` · FilterFrameText x=10 y=74 width=92 height=20 font `Arial,12,0xFFe400,,,,,,left`
  - `quiz.tips.txt5` · FilterFrameText x=10 y=94 width=92 height=20 font `Arial,12,0xFFe400,,,,,,left`
  - `asset.tips.splitLine` · bitmap x=-2
    - `asset.tips.splitLine` · bitmap 250×2 (army.swf)
  - texts: `yishi.view.tips.goods.quizrewordtips.rankreword` “Lista de prémios:”; `yishi.view.tips.goods.quizrewordtips.answerreword` “Prémios às perguntas:”; `yishi.view.tips.goods.quizrewordtips.gold` “Ouro: {0}”; `yishi.view.tips.goods.quizrewordtips.jingyan` “Experiência: {0}”

### yishi.view.tips.goods.RuneTip

- **RuneTip** (`core_module:yishi/view/tips/goods/RuneTip.as`)
  - `core.yellowItemTipsBg` · Scale9CornerImage x=0 y=9 width=287
    - `asset.core.style41_scale9bg1` · bitmap 117×47 (core2.swf)
    - `asset.core.style41_scale9bg2` · bitmap 43×47 (core2.swf)
    - `asset.core.style41_scale9bg3` · bitmap 117×47 (core2.swf)
    - `asset.core.style41_scale9bg4` · bitmap 117×1 (core2.swf)
    - `asset.core.style41_scale9bg5` · bitmap 43×1 (core2.swf)
    - `asset.core.style41_scale9bg6` · bitmap 117×1 (core2.swf)
    - `asset.core.style41_scale9bg7` · bitmap 117×25 (core2.swf)
    - `asset.core.style41_scale9bg8` · bitmap 43×25 (core2.swf)
    - `asset.core.style41_scale9bg9` · bitmap 117×25 (core2.swf)
  - `core.purpleItemTipsBg` · Scale9CornerImage x=0 y=9 width=287
    - `asset.core.style42_scale9bg1` · bitmap 117×47 (core2.swf)
    - `asset.core.style42_scale9bg2` · bitmap 43×47 (core2.swf)
    - `asset.core.style42_scale9bg3` · bitmap 117×47 (core2.swf)
    - `asset.core.style42_scale9bg4` · bitmap 117×1 (core2.swf)
    - `asset.core.style42_scale9bg5` · bitmap 43×1 (core2.swf)
    - `asset.core.style42_scale9bg6` · bitmap 117×1 (core2.swf)
    - `asset.core.style42_scale9bg7` · bitmap 117×25 (core2.swf)
    - `asset.core.style42_scale9bg8` · bitmap 43×25 (core2.swf)
    - `asset.core.style42_scale9bg9` · bitmap 117×25 (core2.swf)
  - `core.blueItemTipsBg` · Scale9CornerImage x=0 y=9 width=287
    - `asset.core.style43_scale9bg1` · bitmap 117×47 (core2.swf)
    - `asset.core.style43_scale9bg2` · bitmap 43×47 (core2.swf)
    - `asset.core.style43_scale9bg3` · bitmap 117×47 (core2.swf)
    - `asset.core.style43_scale9bg4` · bitmap 117×1 (core2.swf)
    - `asset.core.style43_scale9bg5` · bitmap 43×1 (core2.swf)
    - `asset.core.style43_scale9bg6` · bitmap 117×1 (core2.swf)
    - `asset.core.style43_scale9bg7` · bitmap 117×25 (core2.swf)
    - `asset.core.style43_scale9bg8` · bitmap 43×25 (core2.swf)
    - `asset.core.style43_scale9bg9` · bitmap 117×25 (core2.swf)
  - `core.greenItemTipsBg` · Scale9CornerImage x=0 y=9 width=287
    - `asset.core.style44_scale9bg1` · bitmap 117×47 (core2.swf)
    - `asset.core.style44_scale9bg2` · bitmap 43×47 (core2.swf)
    - `asset.core.style44_scale9bg3` · bitmap 117×47 (core2.swf)
    - `asset.core.style44_scale9bg4` · bitmap 117×1 (core2.swf)
    - `asset.core.style44_scale9bg5` · bitmap 43×1 (core2.swf)
    - `asset.core.style44_scale9bg6` · bitmap 117×1 (core2.swf)
    - `asset.core.style44_scale9bg7` · bitmap 117×25 (core2.swf)
    - `asset.core.style44_scale9bg8` · bitmap 43×25 (core2.swf)
    - `asset.core.style44_scale9bg9` · bitmap 117×25 (core2.swf)
  - `core.whiteItemTipsBg` · Scale9CornerImage x=0 y=9 width=287
    - `asset.core.style45_scale9bg1` · bitmap 117×47 (core2.swf)
    - `asset.core.style45_scale9bg2` · bitmap 43×47 (core2.swf)
    - `asset.core.style45_scale9bg3` · bitmap 117×47 (core2.swf)
    - `asset.core.style45_scale9bg4` · bitmap 117×1 (core2.swf)
    - `asset.core.style45_scale9bg5` · bitmap 43×1 (core2.swf)
    - `asset.core.style45_scale9bg6` · bitmap 117×1 (core2.swf)
    - `asset.core.style45_scale9bg7` · bitmap 117×25 (core2.swf)
    - `asset.core.style45_scale9bg8` · bitmap 43×25 (core2.swf)
    - `asset.core.style45_scale9bg9` · bitmap 117×25 (core2.swf)
  - `tips.showItemBaseItemViewIcon` · BaseIconView x=1 y=-9
    - `asset.core.IconLoading` · sprite 42 frames (core2.swf)
  - `tips.profileImg` · ScaleFrameImage 
    - `asset.tips.greenProfileBg01` · bitmap x=0 y=-10
      - `asset.tips.greenProfileBg01` · bitmap 60×60 (tips.swf)
    - `asset.tips.blueProfileBg01` · bitmap x=0 y=-10
      - `asset.tips.blueProfileBg01` · bitmap 60×60 (tips.swf)
    - `asset.tips.purpleProlfileBg01` · bitmap x=0 y=-10
      - `asset.tips.purpleProlfileBg01` · bitmap 60×60 (tips.swf)
    - `asset.tips.yellowProfileBg01` · bitmap x=0 y=-10
      - `asset.tips.yellowProfileBg01` · bitmap 60×60 (tips.swf)
    - `asset.tips.redProfileBg01` · bitmap x=0 y=-10
      - `asset.tips.redProfileBg01` · bitmap 60×60 (tips.swf)
    - `asset.tips.blackProfileBg01` · bitmap x=0 y=-10
      - `asset.tips.blackProfileBg01` · bitmap 61×61 (tips.swf)
  - `tips.GoodNameText_3` · FilterFrameText x=71 y=15 width=210 height=40 font `Arial,14,0xffffff,,,,,,left`
  - `tips.GoodBindText2` · FilterFrameText x=125 width=100 height=20 font `Arial,12,0xee1a38,,,,,,left`
  - `tips.GoodTypeText` · FilterFrameText x=0 width=120 height=18 font `Arial,12,0xffffff,,,,,,left`
  - `tips.GoodDescribeText` · FilterFrameText x=0 width=220 height=18 font `Arial,12,0xe9c68c`
  - `tips.GoodsTimeTxt` · FilterFrameText x=0 width=176 height=18 font `Arial,12,0x8eea17`
  - `tips.GoodPriceText` · FilterFrameText x=35 width=200 height=18 font `Arial,12,0xffffff,,,,,,right`
  - `tips.GoodsTotalBox` · VBox x=4
  - `tips.GoodJobText` · FilterFrameText x=-4 width=200 ← `tips.GoodIntensifyText`
  - `tips.GoodGradeText` · FilterFrameText x=-4 width=225 ← `tips.GoodIntensifyText`
  - `tips.GoodsSendTxt` · FilterFrameText x=0 width=226 height=40 font `Arial,12,0x979797`
  - `asset.tips.splitLine` · bitmap x=-2
    - `asset.tips.splitLine` · bitmap 250×2 (army.swf)
  - `asset.tips.splitLine` · bitmap x=-2
    - `asset.tips.splitLine` · bitmap 250×2 (army.swf)
  - texts: `yishi.view.tips.goods.EquipTipsContent.bind1` “Vinculado”; `yishi.view.tips.goods.EquipTipsContent.bind2` “Não vinculado”; `yishi.view.tips.goods.PropTips.price` “Preço de venda {0} ouro”; `yishi.view.tips.goods.EquipTipsContent.vocation.text` “Profissão:”; `yishi.view.tips.goods.EquipTipsContent.grade02` “Nível necessário: {0}”; `yishi.view.tips.goods.EquipTip.timeStr01` “Permanente”; `yishi.view.tips.goods.EquipTip.timeStr02` “Expirado”; `yishi.view.tips.goods.EquipTip.time.text` “Validade”
  - subviews: `BaseIconView`

### yishi.view.tips.goods.SkillTipItem

- **SkillTipItem** (`core_module:yishi/view/tips/goods/SkillTipItem.as`)
  - `asset.tips.attributeFlag` · bitmap x=4 y=4
    - `asset.tips.attributeFlag` · bitmap 9×9 (theseussoul.swf)
  - `tips.simpleGoodSkillText` · FilterFrameText x=10 width=252 height=18 font `Arial,12,0x48d72a`

### yishi.view.tips.goods.StarTip

- **StarTip** (`core_module:yishi/view/tips/goods/StarTip.as`)
  - `tips.StarTip` · StarTip 
  - `tips.StarNameText` · FilterFrameText x=10 y=10 width=250 height=20 font `Arial,14,0x999999`
  - `tips.StarGpText` · FilterFrameText x=-7 width=230 height=18 font `Arial,12,0xffffff`
  - `tips.StarPriceText` · FilterFrameText x=-4 height=18 font `Arial,12,0xe9c68c`
  - `tips.StarsTotalBox` · VBox x=17 y=26
  - `tips.StarsSubBox` · VBox x=-3 y=0
  - `tips.StarSkillText` · FilterFrameText x=-4 font `Arial,12,0xffffff`
  - texts: `armyII.ThaneAttributeView.Tip01` “Força”; `armyII.ThaneAttributeView.Tip02` “Proteção”; `armyII.ThaneAttributeView.Tip03` “Inteligência”; `armyII.ThaneAttributeView.Tip04` “Físico”; `armyII.ThaneAttributeView.Tip05` “Liderança”; `armyII.ThaneAttributeView.Tip13` “Ataque”; `armyII.ThaneAttributeView.Tip14` “Defesa”; `armyII.ThaneAttributeView.Tip15` “Magia”
  - subviews: `GoodAttributeItem`

### yishi.view.tips.goods.SwitchVipPrivilegeTip

- **SwitchVipPrivilegeTip** (`core_module:yishi/view/tips/goods/SwitchVipPrivilegeTip.as`)
  - `tips.SkillTotalBox` · VBox x=10 y=10
  - `tips.PetAttributeView.desctxt` · FilterFrameText x=15 y=0 width=170 height=20 font `Arial,12,0xffffff`
  - texts: `tips.SwitchVipPrivilegeTip.desctxt` “VIP{0} {1}%Off”

### yishi.view.tips.goods.TaskItemTips

- **TaskItemTips** (`core_module:yishi/view/tips/goods/TaskItemTips.as`)
  - `tips.showItemBaseItemViewIcon` · BaseIconView x=1 y=-9
    - `asset.core.IconLoading` · sprite 42 frames (core2.swf)
  - `tips.TaskItemTips.itemNameTxt` · FilterFrameText x=70 y=25 width=250 height=20 font `Arial,16,0x8299ec,,,,,,left`
  - `asset.tips.splitLine` · bitmap x=-2
    - `asset.tips.splitLine` · bitmap 250×2 (army.swf)
  - `tips.TaskItemTips.rewardTipsTxt` · FilterFrameText x=25 y=70 width=140 height=20 font `Arial,16,0xc2c2c2,,,,,,center`
  - `tips.TaskItemTips.rewardTipsTxt` · FilterFrameText x=25 y=70 width=140 height=20 font `Arial,16,0xc2c2c2,,,,,,center`
  - `asset.tips.splitLine` · bitmap x=-2
    - `asset.tips.splitLine` · bitmap 250×2 (army.swf)
  - `tips.TaskItemTips.tipsTxt` · FilterFrameText x=10 width=185 height=50 font `Arial,12,0xd70707,,,,,,left`
  - `tips.TaskTraceDescribeText` · FilterFrameText x=8 width=180 height=18 font `Arial,12,0xfffde9,,,,,,left`
  - `tips.TaskTraceDescribeText` · FilterFrameText x=8 width=180 height=18 font `Arial,12,0xfffde9,,,,,,left`
  - `tips.TaskTraceDescribeText` · FilterFrameText x=8 width=180 height=18 font `Arial,12,0xfffde9,,,,,,left`
  - `tips.TaskTraceDescribeText` · FilterFrameText x=8 width=180 height=18 font `Arial,12,0xfffde9,,,,,,left`
  - `tips.TaskTraceDescribeText` · FilterFrameText x=8 width=180 height=18 font `Arial,12,0xfffde9,,,,,,left`
  - `tips.TaskTraceDescribeText` · FilterFrameText x=8 width=180 height=18 font `Arial,12,0xfffde9,,,,,,left`
  - `tips.rewardItemTxt` · FilterFrameText x=0 y=50 height=20 font `Arial,12,0xffffff`
  - `tips.rewardItemTxt` · FilterFrameText x=0 y=50 height=20 font `Arial,12,0xffffff`
  - texts: `yishi.view.tips.goods.TaskItemTips.rewardTipsTxt1` “Objetivo”; `yishi.view.tips.goods.TaskItemTips.rewardTipsTxt2` “Prêmios”; `yishi.view.tips.goods.TaskItemTips.tipsTxt` “Ao usar poderá aceitar missão”; `yishi.view.tips.TaskTraceTip.gpTxt` “Experiência:”; `yishi.view.tips.TaskTraceTip.goldTxt` “Ouro:”; `yishi.view.tips.TaskTraceTip.soulTxt` “Espírito:”; `yishi.view.tips.TaskTraceTip.crystalTxt` “Cristal de Luz:”; `yishi.view.tips.TaskTraceTip.consortiaTxt` “Fortuna da Guilda:”
  - subviews: `BaseIconView`

### yishi.view.tips.goods.TheseusEquipTip

- **TheseusEquipTip** (`core_module:yishi/view/tips/goods/TheseusEquipTip.as`)
  - `tips.GoodNameText1_3` · FilterFrameText x=76 y=15 width=210 height=20 font `Arial,14,0xffffff,,,,,,left`
  - `tips.GoodTypeText_2` · FilterFrameText x=-4 width=160 height=18 font `Arial,12,0xb3b3b3,,,,,,left`
  - `tips.showItemBaseItemViewIcon` · BaseIconView x=1 y=-9
    - `asset.core.IconLoading` · sprite 42 frames (core2.swf)
  - `tips.profileImg` · ScaleFrameImage 
    - `asset.tips.greenProfileBg01` · bitmap x=0 y=-10
      - `asset.tips.greenProfileBg01` · bitmap 60×60 (tips.swf)
    - `asset.tips.blueProfileBg01` · bitmap x=0 y=-10
      - `asset.tips.blueProfileBg01` · bitmap 60×60 (tips.swf)
    - `asset.tips.purpleProlfileBg01` · bitmap x=0 y=-10
      - `asset.tips.purpleProlfileBg01` · bitmap 60×60 (tips.swf)
    - `asset.tips.yellowProfileBg01` · bitmap x=0 y=-10
      - `asset.tips.yellowProfileBg01` · bitmap 60×60 (tips.swf)
    - `asset.tips.redProfileBg01` · bitmap x=0 y=-10
      - `asset.tips.redProfileBg01` · bitmap 60×60 (tips.swf)
    - `asset.tips.blackProfileBg01` · bitmap x=0 y=-10
      - `asset.tips.blackProfileBg01` · bitmap 61×61 (tips.swf)
  - `tips.profileBack` · ScaleFrameImage 
    - `core.greenItemTipsBg` · Scale9CornerImage x=0 y=9 width=287
      - `asset.core.style44_scale9bg1` · bitmap 117×47 (core2.swf)
      - `asset.core.style44_scale9bg2` · bitmap 43×47 (core2.swf)
      - `asset.core.style44_scale9bg3` · bitmap 117×47 (core2.swf)
      - `asset.core.style44_scale9bg4` · bitmap 117×1 (core2.swf)
      - `asset.core.style44_scale9bg5` · bitmap 43×1 (core2.swf)
      - `asset.core.style44_scale9bg6` · bitmap 117×1 (core2.swf)
      - `asset.core.style44_scale9bg7` · bitmap 117×25 (core2.swf)
      - `asset.core.style44_scale9bg8` · bitmap 43×25 (core2.swf)
      - `asset.core.style44_scale9bg9` · bitmap 117×25 (core2.swf)
    - `core.blueItemTipsBg` · Scale9CornerImage x=0 y=9 width=287
      - `asset.core.style43_scale9bg1` · bitmap 117×47 (core2.swf)
      - `asset.core.style43_scale9bg2` · bitmap 43×47 (core2.swf)
      - `asset.core.style43_scale9bg3` · bitmap 117×47 (core2.swf)
      - `asset.core.style43_scale9bg4` · bitmap 117×1 (core2.swf)
      - `asset.core.style43_scale9bg5` · bitmap 43×1 (core2.swf)
      - `asset.core.style43_scale9bg6` · bitmap 117×1 (core2.swf)
      - `asset.core.style43_scale9bg7` · bitmap 117×25 (core2.swf)
      - `asset.core.style43_scale9bg8` · bitmap 43×25 (core2.swf)
      - `asset.core.style43_scale9bg9` · bitmap 117×25 (core2.swf)
    - `core.purpleItemTipsBg` · Scale9CornerImage x=0 y=9 width=287
      - `asset.core.style42_scale9bg1` · bitmap 117×47 (core2.swf)
      - `asset.core.style42_scale9bg2` · bitmap 43×47 (core2.swf)
      - `asset.core.style42_scale9bg3` · bitmap 117×47 (core2.swf)
      - `asset.core.style42_scale9bg4` · bitmap 117×1 (core2.swf)
      - `asset.core.style42_scale9bg5` · bitmap 43×1 (core2.swf)
      - `asset.core.style42_scale9bg6` · bitmap 117×1 (core2.swf)
      - `asset.core.style42_scale9bg7` · bitmap 117×25 (core2.swf)
      - `asset.core.style42_scale9bg8` · bitmap 43×25 (core2.swf)
      - `asset.core.style42_scale9bg9` · bitmap 117×25 (core2.swf)
    - `core.yellowItemTipsBg` · Scale9CornerImage x=0 y=9 width=287
      - `asset.core.style41_scale9bg1` · bitmap 117×47 (core2.swf)
      - `asset.core.style41_scale9bg2` · bitmap 43×47 (core2.swf)
      - `asset.core.style41_scale9bg3` · bitmap 117×47 (core2.swf)
      - `asset.core.style41_scale9bg4` · bitmap 117×1 (core2.swf)
      - `asset.core.style41_scale9bg5` · bitmap 43×1 (core2.swf)
      - `asset.core.style41_scale9bg6` · bitmap 117×1 (core2.swf)
      - `asset.core.style41_scale9bg7` · bitmap 117×25 (core2.swf)
      - `asset.core.style41_scale9bg8` · bitmap 43×25 (core2.swf)
      - `asset.core.style41_scale9bg9` · bitmap 117×25 (core2.swf)
    - `core.redItemTipsBg` · Scale9CornerImage x=0 y=9 width=287
      - `asset.core.style46_scale9bg1` · bitmap 117×47 (core2.swf)
      - `asset.core.style46_scale9bg2` · bitmap 43×47 (core2.swf)
      - `asset.core.style46_scale9bg3` · bitmap 117×47 (core2.swf)
      - `asset.core.style46_scale9bg4` · bitmap 117×1 (core2.swf)
      - `asset.core.style46_scale9bg5` · bitmap 43×1 (core2.swf)
      - `asset.core.style46_scale9bg6` · bitmap 117×1 (core2.swf)
      - `asset.core.style46_scale9bg7` · bitmap 117×25 (core2.swf)
      - `asset.core.style46_scale9bg8` · bitmap 43×25 (core2.swf)
      - `asset.core.style46_scale9bg9` · bitmap 117×25 (core2.swf)
    - `core.blackItemTipsBg` · Scale9CornerImage x=0 y=9 width=287
      - `asset.core.style48_scale9bg1` · bitmap 117×47 (core2.swf)
      - `asset.core.style48_scale9bg2` · bitmap 43×47 (core2.swf)
      - `asset.core.style48_scale9bg3` · bitmap 117×47 (core2.swf)
      - `asset.core.style46_scale9bg4` · bitmap 117×1 (core2.swf)
      - `asset.core.style46_scale9bg5` · bitmap 43×1 (core2.swf)
      - `asset.core.style46_scale9bg6` · bitmap 117×1 (core2.swf)
      - `asset.core.style46_scale9bg7` · bitmap 117×25 (core2.swf)
      - `asset.core.style46_scale9bg8` · bitmap 43×25 (core2.swf)
      - `asset.core.style46_scale9bg9` · bitmap 117×25 (core2.swf)
  - `asset.tips.splitLine` · bitmap x=-2
    - `asset.tips.splitLine` · bitmap 250×2 (army.swf)
  - `asset.tips.splitLine` · bitmap x=-2
    - `asset.tips.splitLine` · bitmap 250×2 (army.swf)
  - `asset.tips.splitLine` · bitmap x=-2
    - `asset.tips.splitLine` · bitmap 250×2 (army.swf)
  - `tips.GoodsTotalBox` · VBox x=4
  - `tips.GoodsSubBox` · VBox x=0 y=0
  - `tips.GoodsSubBox` · VBox x=0 y=0
  - `asset.tips.numImg` · bitmap 
    - `asset.tips.numImg` · bitmap 190×22 (tips.swf)
  - `tips.GoodTypeText` · FilterFrameText x=0 width=120 height=18 font `Arial,12,0xffffff,,,,,,left`
  - `tips.castSelectedTxt` · FilterFrameText x=76 y=44 width=195 height=20 font `Arial,12,0xff0000,,,,,,right`
  - `asset.tips.addImg` · bitmap x=0 y=10
    - `asset.tips.addImg` · bitmap 19×22 (tips.swf)
  - `tips.simpleGoodSkillText` · FilterFrameText x=10 width=252 height=18 font `Arial,12,0x48d72a`
  - `tips.SuitItemText` · FilterFrameText x=0 width=206 height=18 font `Arial,12,0x7d7d7d`
  - `tips.SuitItemText` · FilterFrameText x=0 width=206 height=18 font `Arial,12,0x7d7d7d`
  - texts: `goddess.equip.tipMax` “(Pode fortalecer até {0})”; `TheseusEquipTip.desc1` “Valor de Armadura Equipada:”
  - subviews: `BaseIconView`, `SkillTipItem`

### yishi.view.tips.goods.TmpTips

- **TmpTips** (`core_module:yishi/view/tips/goods/TmpTips.as`)
  - `tips.GoodNameText` · FilterFrameText x=0 y=0 width=230 height=20 ← `tips.HeroNameText`
  - `tips.GoodDescribeText.Tmptips` · FilterFrameText x=10 y=33 width=176 height=36 font `Arial,12,0xe9c68c`

### yishi.view.tips.goods.TreaBaseEquipTip

- **TreaBaseEquipTip** (`core_module:yishi/view/tips/goods/TreaBaseEquipTip.as`)
  - `tips.GoodNameText_3` · FilterFrameText x=71 y=15 width=210 height=40 font `Arial,14,0xffffff,,,,,,left`
  - `tips.GoodTypeText_2` · FilterFrameText x=-4 width=160 height=18 font `Arial,12,0xb3b3b3,,,,,,left`
  - `tips.showItemBaseItemViewIcon` · BaseIconView x=1 y=-9
    - `asset.core.IconLoading` · sprite 42 frames (core2.swf)
  - `tips.profileImg` · ScaleFrameImage 
    - `asset.tips.greenProfileBg01` · bitmap x=0 y=-10
      - `asset.tips.greenProfileBg01` · bitmap 60×60 (tips.swf)
    - `asset.tips.blueProfileBg01` · bitmap x=0 y=-10
      - `asset.tips.blueProfileBg01` · bitmap 60×60 (tips.swf)
    - `asset.tips.purpleProlfileBg01` · bitmap x=0 y=-10
      - `asset.tips.purpleProlfileBg01` · bitmap 60×60 (tips.swf)
    - `asset.tips.yellowProfileBg01` · bitmap x=0 y=-10
      - `asset.tips.yellowProfileBg01` · bitmap 60×60 (tips.swf)
    - `asset.tips.redProfileBg01` · bitmap x=0 y=-10
      - `asset.tips.redProfileBg01` · bitmap 60×60 (tips.swf)
    - `asset.tips.blackProfileBg01` · bitmap x=0 y=-10
      - `asset.tips.blackProfileBg01` · bitmap 61×61 (tips.swf)
  - `tips.profileBack` · ScaleFrameImage 
    - `core.greenItemTipsBg` · Scale9CornerImage x=0 y=9 width=287
      - `asset.core.style44_scale9bg1` · bitmap 117×47 (core2.swf)
      - `asset.core.style44_scale9bg2` · bitmap 43×47 (core2.swf)
      - `asset.core.style44_scale9bg3` · bitmap 117×47 (core2.swf)
      - `asset.core.style44_scale9bg4` · bitmap 117×1 (core2.swf)
      - `asset.core.style44_scale9bg5` · bitmap 43×1 (core2.swf)
      - `asset.core.style44_scale9bg6` · bitmap 117×1 (core2.swf)
      - `asset.core.style44_scale9bg7` · bitmap 117×25 (core2.swf)
      - `asset.core.style44_scale9bg8` · bitmap 43×25 (core2.swf)
      - `asset.core.style44_scale9bg9` · bitmap 117×25 (core2.swf)
    - `core.blueItemTipsBg` · Scale9CornerImage x=0 y=9 width=287
      - `asset.core.style43_scale9bg1` · bitmap 117×47 (core2.swf)
      - `asset.core.style43_scale9bg2` · bitmap 43×47 (core2.swf)
      - `asset.core.style43_scale9bg3` · bitmap 117×47 (core2.swf)
      - `asset.core.style43_scale9bg4` · bitmap 117×1 (core2.swf)
      - `asset.core.style43_scale9bg5` · bitmap 43×1 (core2.swf)
      - `asset.core.style43_scale9bg6` · bitmap 117×1 (core2.swf)
      - `asset.core.style43_scale9bg7` · bitmap 117×25 (core2.swf)
      - `asset.core.style43_scale9bg8` · bitmap 43×25 (core2.swf)
      - `asset.core.style43_scale9bg9` · bitmap 117×25 (core2.swf)
    - `core.purpleItemTipsBg` · Scale9CornerImage x=0 y=9 width=287
      - `asset.core.style42_scale9bg1` · bitmap 117×47 (core2.swf)
      - `asset.core.style42_scale9bg2` · bitmap 43×47 (core2.swf)
      - `asset.core.style42_scale9bg3` · bitmap 117×47 (core2.swf)
      - `asset.core.style42_scale9bg4` · bitmap 117×1 (core2.swf)
      - `asset.core.style42_scale9bg5` · bitmap 43×1 (core2.swf)
      - `asset.core.style42_scale9bg6` · bitmap 117×1 (core2.swf)
      - `asset.core.style42_scale9bg7` · bitmap 117×25 (core2.swf)
      - `asset.core.style42_scale9bg8` · bitmap 43×25 (core2.swf)
      - `asset.core.style42_scale9bg9` · bitmap 117×25 (core2.swf)
    - `core.yellowItemTipsBg` · Scale9CornerImage x=0 y=9 width=287
      - `asset.core.style41_scale9bg1` · bitmap 117×47 (core2.swf)
      - `asset.core.style41_scale9bg2` · bitmap 43×47 (core2.swf)
      - `asset.core.style41_scale9bg3` · bitmap 117×47 (core2.swf)
      - `asset.core.style41_scale9bg4` · bitmap 117×1 (core2.swf)
      - `asset.core.style41_scale9bg5` · bitmap 43×1 (core2.swf)
      - `asset.core.style41_scale9bg6` · bitmap 117×1 (core2.swf)
      - `asset.core.style41_scale9bg7` · bitmap 117×25 (core2.swf)
      - `asset.core.style41_scale9bg8` · bitmap 43×25 (core2.swf)
      - `asset.core.style41_scale9bg9` · bitmap 117×25 (core2.swf)
    - `core.redItemTipsBg` · Scale9CornerImage x=0 y=9 width=287
      - `asset.core.style46_scale9bg1` · bitmap 117×47 (core2.swf)
      - `asset.core.style46_scale9bg2` · bitmap 43×47 (core2.swf)
      - `asset.core.style46_scale9bg3` · bitmap 117×47 (core2.swf)
      - `asset.core.style46_scale9bg4` · bitmap 117×1 (core2.swf)
      - `asset.core.style46_scale9bg5` · bitmap 43×1 (core2.swf)
      - `asset.core.style46_scale9bg6` · bitmap 117×1 (core2.swf)
      - `asset.core.style46_scale9bg7` · bitmap 117×25 (core2.swf)
      - `asset.core.style46_scale9bg8` · bitmap 43×25 (core2.swf)
      - `asset.core.style46_scale9bg9` · bitmap 117×25 (core2.swf)
    - `core.blackItemTipsBg` · Scale9CornerImage x=0 y=9 width=287
      - `asset.core.style48_scale9bg1` · bitmap 117×47 (core2.swf)
      - `asset.core.style48_scale9bg2` · bitmap 43×47 (core2.swf)
      - `asset.core.style48_scale9bg3` · bitmap 117×47 (core2.swf)
      - `asset.core.style46_scale9bg4` · bitmap 117×1 (core2.swf)
      - `asset.core.style46_scale9bg5` · bitmap 43×1 (core2.swf)
      - `asset.core.style46_scale9bg6` · bitmap 117×1 (core2.swf)
      - `asset.core.style46_scale9bg7` · bitmap 117×25 (core2.swf)
      - `asset.core.style46_scale9bg8` · bitmap 43×25 (core2.swf)
      - `asset.core.style46_scale9bg9` · bitmap 117×25 (core2.swf)
  - `asset.tips.splitLine` · bitmap x=-2
    - `asset.tips.splitLine` · bitmap 250×2 (army.swf)
  - `asset.tips.splitLine` · bitmap x=-2
    - `asset.tips.splitLine` · bitmap 250×2 (army.swf)
  - `tips.GoodsTotalBox` · VBox x=4
  - `tips.GoodsSubBox` · VBox x=0 y=0
  - `tips.GoodsSubBox` · VBox x=0 y=0
  - `tips.SuitItemText` · FilterFrameText x=0 width=206 height=18 font `Arial,12,0x7d7d7d`
  - `tips.SuitItemText` · FilterFrameText x=0 width=206 height=18 font `Arial,12,0x7d7d7d`
  - subviews: `BaseIconView`, `SkillTipItem`

### yishi.view.tips.goods.TreasureAttributeItem

- **TreasureAttributeItem** (`core_module:yishi/view/tips/goods/TreasureAttributeItem.as`)
  - `asset.tips.attributeFlag` · bitmap x=4 y=4
    - `asset.tips.attributeFlag` · bitmap 9×9 (theseussoul.swf)
  - `tips.treasureAttributeItem.name` · FilterFrameText x=14 y=0 width=150 height=20 font `Arial,12,0xffffff,,,,,,left`
  - `tips.treasureAttributeItem.value` · FilterFrameText x=100 y=2 width=100 height=20 font `Arial,12,0x59cd41,,,,,,left`

### yishi.view.tips.goods.TreasureSkillItem

- **TreasureSkillItem** (`core_module:yishi/view/tips/goods/TreasureSkillItem.as`)
  - `asset.tips.attributeFlag` · bitmap x=4 y=4
    - `asset.tips.attributeFlag` · bitmap 9×9 (theseussoul.swf)
  - `tips.treasureSkillItem.txt` · FilterFrameText x=14 y=0 width=150 height=20 font `Arial,12,0xffffff,,,,,,left`

### yishi.view.tips.goods.TreasureTip

- **TreasureTip** (`core_module:yishi/view/tips/goods/TreasureTip.as`)
  - `core.blackItemTipsBg` · Scale9CornerImage x=0 y=9 width=287
    - `asset.core.style48_scale9bg1` · bitmap 117×47 (core2.swf)
    - `asset.core.style48_scale9bg2` · bitmap 43×47 (core2.swf)
    - `asset.core.style48_scale9bg3` · bitmap 117×47 (core2.swf)
    - `asset.core.style46_scale9bg4` · bitmap 117×1 (core2.swf)
    - `asset.core.style46_scale9bg5` · bitmap 43×1 (core2.swf)
    - `asset.core.style46_scale9bg6` · bitmap 117×1 (core2.swf)
    - `asset.core.style46_scale9bg7` · bitmap 117×25 (core2.swf)
    - `asset.core.style46_scale9bg8` · bitmap 43×25 (core2.swf)
    - `asset.core.style46_scale9bg9` · bitmap 117×25 (core2.swf)
  - `core.redItemTipsBg` · Scale9CornerImage x=0 y=9 width=287
    - `asset.core.style46_scale9bg1` · bitmap 117×47 (core2.swf)
    - `asset.core.style46_scale9bg2` · bitmap 43×47 (core2.swf)
    - `asset.core.style46_scale9bg3` · bitmap 117×47 (core2.swf)
    - `asset.core.style46_scale9bg4` · bitmap 117×1 (core2.swf)
    - `asset.core.style46_scale9bg5` · bitmap 43×1 (core2.swf)
    - `asset.core.style46_scale9bg6` · bitmap 117×1 (core2.swf)
    - `asset.core.style46_scale9bg7` · bitmap 117×25 (core2.swf)
    - `asset.core.style46_scale9bg8` · bitmap 43×25 (core2.swf)
    - `asset.core.style46_scale9bg9` · bitmap 117×25 (core2.swf)
  - `core.yellowItemTipsBg` · Scale9CornerImage x=0 y=9 width=287
    - `asset.core.style41_scale9bg1` · bitmap 117×47 (core2.swf)
    - `asset.core.style41_scale9bg2` · bitmap 43×47 (core2.swf)
    - `asset.core.style41_scale9bg3` · bitmap 117×47 (core2.swf)
    - `asset.core.style41_scale9bg4` · bitmap 117×1 (core2.swf)
    - `asset.core.style41_scale9bg5` · bitmap 43×1 (core2.swf)
    - `asset.core.style41_scale9bg6` · bitmap 117×1 (core2.swf)
    - `asset.core.style41_scale9bg7` · bitmap 117×25 (core2.swf)
    - `asset.core.style41_scale9bg8` · bitmap 43×25 (core2.swf)
    - `asset.core.style41_scale9bg9` · bitmap 117×25 (core2.swf)
  - `core.purpleItemTipsBg` · Scale9CornerImage x=0 y=9 width=287
    - `asset.core.style42_scale9bg1` · bitmap 117×47 (core2.swf)
    - `asset.core.style42_scale9bg2` · bitmap 43×47 (core2.swf)
    - `asset.core.style42_scale9bg3` · bitmap 117×47 (core2.swf)
    - `asset.core.style42_scale9bg4` · bitmap 117×1 (core2.swf)
    - `asset.core.style42_scale9bg5` · bitmap 43×1 (core2.swf)
    - `asset.core.style42_scale9bg6` · bitmap 117×1 (core2.swf)
    - `asset.core.style42_scale9bg7` · bitmap 117×25 (core2.swf)
    - `asset.core.style42_scale9bg8` · bitmap 43×25 (core2.swf)
    - `asset.core.style42_scale9bg9` · bitmap 117×25 (core2.swf)
  - `core.blueItemTipsBg` · Scale9CornerImage x=0 y=9 width=287
    - `asset.core.style43_scale9bg1` · bitmap 117×47 (core2.swf)
    - `asset.core.style43_scale9bg2` · bitmap 43×47 (core2.swf)
    - `asset.core.style43_scale9bg3` · bitmap 117×47 (core2.swf)
    - `asset.core.style43_scale9bg4` · bitmap 117×1 (core2.swf)
    - `asset.core.style43_scale9bg5` · bitmap 43×1 (core2.swf)
    - `asset.core.style43_scale9bg6` · bitmap 117×1 (core2.swf)
    - `asset.core.style43_scale9bg7` · bitmap 117×25 (core2.swf)
    - `asset.core.style43_scale9bg8` · bitmap 43×25 (core2.swf)
    - `asset.core.style43_scale9bg9` · bitmap 117×25 (core2.swf)
  - `core.greenItemTipsBg` · Scale9CornerImage x=0 y=9 width=287
    - `asset.core.style44_scale9bg1` · bitmap 117×47 (core2.swf)
    - `asset.core.style44_scale9bg2` · bitmap 43×47 (core2.swf)
    - `asset.core.style44_scale9bg3` · bitmap 117×47 (core2.swf)
    - `asset.core.style44_scale9bg4` · bitmap 117×1 (core2.swf)
    - `asset.core.style44_scale9bg5` · bitmap 43×1 (core2.swf)
    - `asset.core.style44_scale9bg6` · bitmap 117×1 (core2.swf)
    - `asset.core.style44_scale9bg7` · bitmap 117×25 (core2.swf)
    - `asset.core.style44_scale9bg8` · bitmap 43×25 (core2.swf)
    - `asset.core.style44_scale9bg9` · bitmap 117×25 (core2.swf)
  - `core.whiteItemTipsBg` · Scale9CornerImage x=0 y=9 width=287
    - `asset.core.style45_scale9bg1` · bitmap 117×47 (core2.swf)
    - `asset.core.style45_scale9bg2` · bitmap 43×47 (core2.swf)
    - `asset.core.style45_scale9bg3` · bitmap 117×47 (core2.swf)
    - `asset.core.style45_scale9bg4` · bitmap 117×1 (core2.swf)
    - `asset.core.style45_scale9bg5` · bitmap 43×1 (core2.swf)
    - `asset.core.style45_scale9bg6` · bitmap 117×1 (core2.swf)
    - `asset.core.style45_scale9bg7` · bitmap 117×25 (core2.swf)
    - `asset.core.style45_scale9bg8` · bitmap 43×25 (core2.swf)
    - `asset.core.style45_scale9bg9` · bitmap 117×25 (core2.swf)
  - `asset.tips.splitLine` · bitmap x=-2
    - `asset.tips.splitLine` · bitmap 250×2 (army.swf)
  - `tips.GoodsTotalBox` · VBox x=4
  - `tips.GoodsEquiped_2` · FilterFrameText x=87 y=0 width=180 height=20 font `Arial,14,0x00FF00,true,,,,,center`
  - `tips.GoodgradeCountText` · FilterFrameText x=0 width=230 height=18 font `Arial,12,0x01f0ed,,,,,,left`
  - `tips.GoodPriceText` · FilterFrameText x=35 width=200 height=18 font `Arial,12,0xffffff,,,,,,right`
  - `tips.GoodsTimeTxt` · FilterFrameText x=0 width=176 height=18 font `Arial,12,0x8eea17`
  - `tips.GoodsSendTxt` · FilterFrameText x=0 width=226 height=40 font `Arial,12,0x979797`
  - `tips.fashionIdentityTipTxt` · FilterFrameText x=0 width=178 height=20 font `Arial,12,0xc50000,,,,,,left`
  - `tips.fashionProfileTxt` · FilterFrameText width=50 height=20 font `Arial,12,0x32a2f8,,,,,,left`
  - `asset.fashion.StarLevelLightImg` · bitmap 17×17 (core.swf)
  - `asset.fashion.StarLeveldarkImg` · bitmap 17×17 (core.swf)
  - texts: `yishi.view.tips.goods.EquipTip.equiped` “Equipamento Atual”; `yishi.view.tips.goods.ChatEquipTips.gradeCount` “[Avaliação {0} pontos]”; `public.level` “Nv.”; `yishi.view.tips.goods.specialFashion` “Moda Especial”; `yishi.view.tips.goods.activeFashion` “Moda do Evento”; `yishi.view.tips.goods.normalFashion` “Moda Normal”; `yishi.view.tips.goods.PropTips.price` “Preço de venda {0} ouro”; `yishi.view.tips.goods.EquipTip.time.text` “Validade”
  - subviews: `HBox`, `TreasureTipsContent`

### yishi.view.tips.goods.TreasureTipsContent

- **TreasureTipsContent** (`core_module:yishi/view/tips/goods/TreasureTipsContent.as`)
  - `tips.showItemBaseItemViewIcon` · BaseIconView x=1 y=-9
    - `asset.core.IconLoading` · sprite 42 frames (core2.swf)
  - `tips.profileImg` · ScaleFrameImage 
    - `asset.tips.greenProfileBg01` · bitmap x=0 y=-10
      - `asset.tips.greenProfileBg01` · bitmap 60×60 (tips.swf)
    - `asset.tips.blueProfileBg01` · bitmap x=0 y=-10
      - `asset.tips.blueProfileBg01` · bitmap 60×60 (tips.swf)
    - `asset.tips.purpleProlfileBg01` · bitmap x=0 y=-10
      - `asset.tips.purpleProlfileBg01` · bitmap 60×60 (tips.swf)
    - `asset.tips.yellowProfileBg01` · bitmap x=0 y=-10
      - `asset.tips.yellowProfileBg01` · bitmap 60×60 (tips.swf)
    - `asset.tips.redProfileBg01` · bitmap x=0 y=-10
      - `asset.tips.redProfileBg01` · bitmap 60×60 (tips.swf)
    - `asset.tips.blackProfileBg01` · bitmap x=0 y=-10
      - `asset.tips.blackProfileBg01` · bitmap 61×61 (tips.swf)
  - `asset.tips.addImg` · bitmap x=0 y=10
    - `asset.tips.addImg` · bitmap 19×22 (tips.swf)
  - `asset.tips.numImg` · bitmap 
    - `asset.tips.numImg` · bitmap 190×22 (tips.swf)
  - `tips.GoodTypeText` · FilterFrameText x=0 width=120 height=18 font `Arial,12,0xffffff,,,,,,left`
  - `tips.GoodNameText_3` · FilterFrameText x=71 y=15 width=210 height=40 font `Arial,14,0xffffff,,,,,,left`
  - `tips.GoodIntensifyText_2` · FilterFrameText x=141 width=220 height=18 font `Arial,12,0xb3b3b3,,,,,,right`
  - `tips.GoodsTotalBox` · VBox x=4
  - `tips.GoodsSubBox` · VBox x=0 y=0
  - `tips.GoodsSubBox` · VBox x=0 y=0
  - `tips.GoodsSubBox3` · VBox x=0 y=0
  - `tips.GoodGradeText` · FilterFrameText x=-4 width=225 ← `tips.GoodIntensifyText`
  - `tips.GoodBindText` · FilterFrameText x=107 width=120 height=18 font `Arial,12,0xee1a38,,,,,,left`
  - `tips.GoodSkillText` · FilterFrameText x=0 width=236 height=18 font `Arial,12,0x48d72a`
  - `tips.GoodDescribeText` · FilterFrameText x=0 width=220 height=18 font `Arial,12,0xe9c68c`
  - `asset.tips.splitLine` · bitmap x=-2
    - `asset.tips.splitLine` · bitmap 250×2 (army.swf)
  - `asset.tips.splitLine` · bitmap x=-2
    - `asset.tips.splitLine` · bitmap 250×2 (army.swf)
  - `asset.tips.splitLine` · bitmap x=-2
    - `asset.tips.splitLine` · bitmap 250×2 (army.swf)
  - texts: `yishi.view.tips.goods.EquipTipsContent.intensify` “(Fortalecimento até Nv. {0})”; `yishi.view.tips.goods.EquipTipsContent.bind1` “Vinculado”; `yishi.view.tips.goods.EquipTipsContent.bind2` “Não vinculado”; `TreasurePageView.skill.text` “Bônus de fundição:”
  - subviews: `BaseIconView`, `TreasureAttributeItem`, `TreasureSkillItem`

