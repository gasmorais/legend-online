package view.subshop
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.ShopEvent;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import mainBar.StripView;
   import manager.LanguageMgr;
   import managers.PlayerCurrencyManager;
   import mvc.module.shop.ShopGoodsInfo;
   import mvc.module.shop.ShopModel;
   import utils.LogicUtils;
   import view.GoodsItem;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.VersionSwitch;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.events.NotificationEvent;
   import yishi.events.PlayerEvent;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.ConsortiaManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.view.base.HRollItemPanel;
   
   public class ConsortiaShopFrame extends Frame implements IManualSize
   {
      
      private var _data:ShopModel;
      
      private var _bg:Bitmap;
      
      private var _bg1:Bitmap;
      
      private var _back:ScaleBitmapImage;
      
      private var _signButton:IconButton;
      
      private var _tipTxtImg:Bitmap;
      
      private var _displayShow:Bitmap;
      
      private var _displayShowTxt:Bitmap;
      
      private var _displayShowTxt2:Bitmap;
      
      private var _displayShowTxt3:Image;
      
      private var _displayShowTxt3Txt:Bitmap;
      
      private var _pageNumTxt:FilterFrameText;
      
      private var _contributeTxt:FilterFrameText;
      
      private var _prePageBtn:IconButton;
      
      private var _nextPageBtn:IconButton;
      
      private var _itemList:Vector.<GoodsItem>;
      
      private var _group:SelectedButtonGroup;
      
      private var _consortiaShop:SelectedButton;
      
      private var _advConsortiaShop:SelectedButton;
      
      private var _treasureConsortiaBtn:SelectedButton;
      
      private var _copyConsortiaBtn:SelectedButton;
      
      private var _crossGuildShopBtn:SelectedButton;
      
      private var _consortiaNewBossBtn:SelectedButton;
      
      private var _minosBtn:SelectedButton;
      
      private var _chesspvpBtn:SelectedButton;
      
      private var _currencyIcon:Bitmap;
      
      private var _stripView:StripView;
      
      private var _desGuildSkill:String;
      
      private var _desYellowCoin:String;
      
      private var _desCopyConsortia:String;
      
      private var _copyConsortiaImg:Image;
      
      private var _copyConsortiaTxtImg:Image;
      
      private var _sealOfKingImg:MutipleImage;
      
      private var _displayShowTxt4:Bitmap;
      
      private var _desCrossGuild:String;
      
      private var _desConsortiaNewBoss:String;
      
      private var _rollPanel:HRollItemPanel;
      
      private var _rollList:Array = [];
      
      private var _minosIconImg:Image;
      
      private var _minosFt:Image;
      
      private var _moiosCoinStr:String;
      
      private var _chesspvpCoinTxt:GradientText;
      
      private var _chesspvpCoinImg:Image;
      
      private var _chesspvpConStr:String;
      
      public function ConsortiaShopFrame()
      {
         super();
         initView();
         addEvent();
         initData();
         _group.selectIndex = 0;
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,793,597);
      }
      
      private function initView() : void
      {
         var _loc9_:int = 0;
         var _loc3_:GoodsItem = null;
         _data = FrameControllerManager.instance.shopController.model;
         var _loc10_:int = int(FrameControllerManager.instance.consortiaController.model.consortiaInfo.shopLevel);
         if(_loc10_ == 0)
         {
            titleText = LanguageMgr.GetTranslation("consortia.view.myConsortia.building.ConsortiaShopFrame.titleText1");
         }
         else
         {
            titleText = LanguageMgr.GetTranslation("consortia.view.myConsortia.building.ConsortiaShopFrame.titleText",_loc10_);
         }
         _bg = ComponentFactory.Instance.creatBitmap("asset.shop.GoodsListViewBG");
         _bg1 = ComponentFactory.Instance.creatBitmap("asset.shop.GoodsListViewBG");
         _back = ComponentFactory.Instance.creatComponentByStylename("shop.mazeBack");
         _displayShow = ComponentFactory.Instance.creatBitmap("asset.shop.ShopDisplayShow01");
         _signButton = ComponentFactory.Instance.creatComponentByStylename("stop.SignButton");
         _prePageBtn = ComponentFactory.Instance.creatComponentByStylename("stop.ComShopFramePrePageBtn");
         _nextPageBtn = ComponentFactory.Instance.creatComponentByStylename("stop.ComShopFrameNextPageBtn");
         _pageNumTxt = ComponentFactory.Instance.creatComponentByStylename("stop.ComShopFramePageTextStyle");
         _contributeTxt = ComponentFactory.Instance.creatComponentByStylename("stop.ComMoneyTextStyle");
         _displayShowTxt = ComponentFactory.Instance.creatBitmap("asset.shop.ConsortiaDisplayShowTxt");
         _displayShowTxt2 = ComponentFactory.Instance.creatBitmap("asset.shop.consortia.displayImg2");
         _displayShowTxt3 = ComponentFactory.Instance.creatComponentByStylename("consortiaShop.YellowIcon");
         _displayShowTxt3Txt = ComponentFactory.Instance.creatBitmap("asset.shop.consortia.YellowIconTxt");
         _displayShowTxt4 = ComponentFactory.Instance.creatBitmap("asset.shop.consortianewboss.moneyStr3");
         _tipTxtImg = ComponentFactory.Instance.creatBitmap("asset.shop.consortiaTipTxtImg");
         _consortiaShop = ComponentFactory.Instance.creatComponentByStylename("shop.consortiaBtn");
         _advConsortiaShop = ComponentFactory.Instance.creatComponentByStylename("shop.advConsortiaBtn");
         _treasureConsortiaBtn = ComponentFactory.Instance.creatComponentByStylename("shop.treasureConsortiaBtn");
         _copyConsortiaBtn = ComponentFactory.Instance.creatComponentByStylename("shop.copyConsortiaBtn");
         _crossGuildShopBtn = ComponentFactory.Instance.creatComponentByStylename("shop.crossGuildShopBtn");
         _consortiaNewBossBtn = ComponentFactory.Instance.creatComponentByStylename("shop.consortiaNewBossBtn");
         _minosBtn = ComponentFactory.Instance.creatComponentByStylename("shop.consortiaMinosBtn");
         _chesspvpBtn = ComponentFactory.Instance.creatComponentByStylename("shop.consortiaChessPvpBtn");
         _currencyIcon = ComponentFactory.Instance.creatBitmap("asset.core.guild");
         _copyConsortiaImg = ComponentFactory.Instance.creatComponentByStylename("consortiaShop.copyConsortiaImg");
         _copyConsortiaTxtImg = ComponentFactory.Instance.creatComponentByStylename("consortiaShop.copyConsortiaTxtImg");
         _sealOfKingImg = ComponentFactory.Instance.creatComponentByStylename("shop.CrossGuild.crossGuildCoin");
         _minosIconImg = ComponentFactory.Instance.creatComponentByStylename("consortiaShop.minosCoinImg");
         _minosFt = ComponentFactory.Instance.creatComponentByStylename("consortiaShop.minosCoinFtImg");
         _chesspvpCoinTxt = ComponentFactory.Instance.creatComponentByStylename("consortiaShop.chesspvpCoin.GTitleTxt");
         _chesspvpCoinImg = ComponentFactory.Instance.creatComponentByStylename("consortiaShop.chesspvpCoinImg");
         _chesspvpCoinTxt.text = LanguageMgr.GetTranslation("chesspvp.shop.score");
         _rollPanel = new HRollItemPanel();
         _rollPanel.initParams("shop.consortiaMinos.hbox","shop.consortia.tabPreBtn","shop.consortia.tabNextBtn",6,110,34);
         _group = new SelectedButtonGroup();
         if(ConsortiaManager.instance.model.consortiaInfo.shopLevel > 0)
         {
            _group.addSelectItem(_consortiaShop);
            _group.addSelectItem(_advConsortiaShop);
            _group.addSelectItem(_treasureConsortiaBtn);
            _group.addSelectItem(_copyConsortiaBtn);
            _rollList.push(_consortiaShop);
            _rollList.push(_advConsortiaShop);
            _rollList.push(_treasureConsortiaBtn);
            _rollList.push(_copyConsortiaBtn);
         }
         if(VersionSwitch.CROSS_GUILD)
         {
            _group.addSelectItem(_crossGuildShopBtn);
            _rollList.push(_crossGuildShopBtn);
         }
         if(VersionSwitch.CONSORTIA_NEW_BOSS)
         {
            _group.addSelectItem(_consortiaNewBossBtn);
            _rollList.push(_consortiaNewBossBtn);
         }
         if(VersionSwitch.MINOS)
         {
            _group.addSelectItem(_minosBtn);
            _rollList.push(_minosBtn);
         }
         if(VersionSwitch.CHESS_PVP)
         {
            _group.addSelectItem(_chesspvpBtn);
            _rollList.push(_chesspvpBtn);
         }
         _rollPanel.updateList(_rollList);
         _stripView = ComponentFactory.Instance.creatCustomObject("shop.guildTip.StripView");
         _stripView.setHitArea(0,0,30,27);
         var _loc12_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(-1400);
         if(_loc12_)
         {
            _desGuildSkill = _loc12_.Description;
         }
         _stripView.tipData = _desGuildSkill;
         var _loc1_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(-4100);
         if(_loc1_)
         {
            _desYellowCoin = _loc1_.Description;
         }
         var _loc7_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(-2900);
         if(_loc7_)
         {
            _desCrossGuild = _loc7_.Description;
         }
         var _loc6_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(-18000);
         if(_loc6_)
         {
            _desConsortiaNewBoss = _loc6_.Description;
         }
         var _loc4_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(-4700);
         if(_loc4_)
         {
            _desCopyConsortia = _loc4_.Description;
         }
         var _loc5_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(-21000);
         if(_loc5_)
         {
            _moiosCoinStr = _loc5_.Description;
         }
         var _loc2_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(-23000);
         if(_loc2_)
         {
            _chesspvpConStr = _loc2_.Description;
         }
         _pageNumTxt.text = "1/1";
         _contributeTxt.text = playerInfo.consortiaOffer + "";
         addToContent(_bg1);
         _bg1.x = 10;
         _bg1.y = 30;
         addToContent(_bg);
         _bg.scaleX = -1;
         _bg.x = 2 * _bg1.width + 10;
         _bg.y = 30;
         addToContent(_back);
         _back.y = 30;
         addToContent(_displayShow);
         _displayShow.x = 15;
         _displayShow.y = 456;
         addToContent(_displayShowTxt);
         _displayShowTxt.x = 20;
         _displayShowTxt.y = 465;
         addToContent(_signButton);
         _signButton.y = 443;
         addToContent(_prePageBtn);
         _prePageBtn.y = 414;
         addToContent(_nextPageBtn);
         _nextPageBtn.y = 414;
         addToContent(_pageNumTxt);
         _pageNumTxt.y = 417;
         addToContent(_tipTxtImg);
         _tipTxtImg.y = 465;
         addToContent(_contributeTxt);
         _contributeTxt.y = 462;
         _contributeTxt.x = 106;
         addToContent(_displayShowTxt2);
         addToContent(_currencyIcon);
         _currencyIcon.y = 454;
         _currencyIcon.x = 10;
         addToContent(_displayShowTxt3);
         addToContent(_displayShowTxt3Txt);
         addToContent(_copyConsortiaImg);
         addToContent(_copyConsortiaTxtImg);
         addToContent(_minosIconImg);
         addToContent(_minosFt);
         addToContent(_chesspvpCoinImg);
         addToContent(_chesspvpCoinTxt);
         addToContent(_sealOfKingImg);
         addToContent(_displayShowTxt4);
         addToContent(_stripView);
         addToContent(_rollPanel);
         var _loc11_:int = 0;
         var _loc8_:int = 0;
         _itemList = new Vector.<GoodsItem>();
         _loc9_ = 0;
         while(_loc9_ < 9)
         {
            _loc3_ = new GoodsItem();
            _loc11_ = _loc9_ / 3;
            _loc8_ = _loc9_ % 3;
            _loc3_.x = _loc8_ * _loc3_.width + 7;
            _loc3_.y = _loc11_ * (_loc3_.height + 3) + 35;
            addToContent(_loc3_);
            _itemList.push(_loc3_);
            _loc9_++;
         }
      }
      
      private function initData() : void
      {
         FrameControllerManager.instance.shopController.initConsortiaShopFrame();
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _data.addEventListener("PAGE_UPDATE",__refreshPage);
         _data.addEventListener("GOODS_LIST_UPDATE",__refreshGoods);
         _prePageBtn.addEventListener("click",__onPageHandler);
         _nextPageBtn.addEventListener("click",__onPageHandler);
         _signButton.addEventListener("click",__onSignClick);
         if(_group)
         {
            _group.addEventListener("change",__changeViewHandler);
         }
         playerInfo.addEventListener("CONSORTIA_OFFER_CHANGE",__onContributeUpdata);
         playerInfo.addEventListener("CONSORTIA_CHANGE",__existConsortiaHandler);
         NotificationManager.instance.addEventListener("CURRENCYREFRESH",__refreshCurrencyHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _data.removeEventListener("PAGE_UPDATE",__refreshPage);
         _data.removeEventListener("GOODS_LIST_UPDATE",__refreshGoods);
         _prePageBtn.removeEventListener("click",__onPageHandler);
         _nextPageBtn.removeEventListener("click",__onPageHandler);
         _signButton.removeEventListener("click",__onSignClick);
         if(_group)
         {
            _group.removeEventListener("change",__changeViewHandler);
         }
         playerInfo.removeEventListener("CONSORTIA_OFFER_CHANGE",__onContributeUpdata);
         playerInfo.removeEventListener("CONSORTIA_CHANGE",__existConsortiaHandler);
         NotificationManager.instance.removeEventListener("CURRENCYREFRESH",__refreshCurrencyHandler);
      }
      
      private function __existConsortiaHandler(param1:PlayerEvent) : void
      {
         if(playerInfo.consortiaID == 0)
         {
            dispose();
         }
      }
      
      private function __refreshPage(param1:ShopEvent) : void
      {
         _pageNumTxt.text = _data.currentPage + "/" + _data.totalPage;
         _prePageBtn.enable = _data.currentPage != 1;
         _nextPageBtn.enable = _data.currentPage != _data.totalPage;
      }
      
      private function __refreshGoods(param1:ShopEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < 9)
         {
            _itemList[_loc2_].data = _loc2_ < _data.showGoodsList.length ? ShopGoodsInfo(_data.showGoodsList[_loc2_]) : null;
            _loc2_++;
         }
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
               dispose();
               break;
            case 1:
               dispose();
         }
      }
      
      private function __onSignClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         dispose();
      }
      
      private function __onContributeUpdata(param1:PlayerEvent) : void
      {
         if(_group.getSelectedItem() == _consortiaShop)
         {
            _contributeTxt.text = playerInfo.consortiaOffer + "";
         }
         else if(_group.getSelectedItem() == _advConsortiaShop)
         {
            _contributeTxt.text = PlayerCurrencyManager.instance.currencyInfo.guildSkill.amount + "";
         }
         else if(_group.getSelectedItem() == _treasureConsortiaBtn)
         {
            _contributeTxt.text = PlayerCurrencyManager.instance.currencyInfo.yellowCoin.amount + "";
         }
         else if(_group.getSelectedItem() == _copyConsortiaBtn)
         {
            _contributeTxt.text = PlayerCurrencyManager.instance.currencyInfo.copyConsortia.amount + "";
         }
         else if(_group.getSelectedItem() == _crossGuildShopBtn)
         {
            _contributeTxt.text = PlayerCurrencyManager.instance.currencyInfo.crossGuildCoin.amount + "";
         }
         else if(_group.getSelectedItem() == _consortiaNewBossBtn)
         {
            _contributeTxt.text = PlayerCurrencyManager.instance.currencyInfo.consortiaNewBossCoin.amount + "";
         }
         else if(_group.getSelectedItem() == _minosBtn)
         {
            _contributeTxt.text = PlayerCurrencyManager.instance.currencyInfo.minosCoin.amount + "";
         }
         else if(_group.getSelectedItem() == _chesspvpBtn)
         {
            _contributeTxt.text = PlayerCurrencyManager.instance.currencyInfo.chessPvpCoin.amount + "";
         }
      }
      
      private function __refreshCurrencyHandler(param1:NotificationEvent) : void
      {
         if(_group.getSelectedItem() == _consortiaShop)
         {
            _contributeTxt.text = playerInfo.consortiaOffer + "";
         }
         else if(_group.getSelectedItem() == _advConsortiaShop)
         {
            _contributeTxt.text = PlayerCurrencyManager.instance.currencyInfo.guildSkill.amount + "";
         }
         else if(_group.getSelectedItem() == _treasureConsortiaBtn)
         {
            _contributeTxt.text = PlayerCurrencyManager.instance.currencyInfo.yellowCoin.amount + "";
         }
         else if(_group.getSelectedItem() == _copyConsortiaBtn)
         {
            _contributeTxt.text = PlayerCurrencyManager.instance.currencyInfo.copyConsortia.amount + "";
         }
         else if(_group.getSelectedItem() == _crossGuildShopBtn)
         {
            _contributeTxt.text = PlayerCurrencyManager.instance.currencyInfo.crossGuildCoin.amount + "";
         }
         else if(_group.getSelectedItem() == _consortiaNewBossBtn)
         {
            _contributeTxt.text = PlayerCurrencyManager.instance.currencyInfo.consortiaNewBossCoin.amount + "";
         }
         else if(_group.getSelectedItem() == _minosBtn)
         {
            _contributeTxt.text = PlayerCurrencyManager.instance.currencyInfo.minosCoin.amount + "";
         }
         else if(_group.getSelectedItem() == _chesspvpBtn)
         {
            _contributeTxt.text = PlayerCurrencyManager.instance.currencyInfo.chessPvpCoin.amount + "";
         }
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function __onPageHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         FrameControllerManager.instance.shopController.shopPageBtnHandler(param1.currentTarget == _prePageBtn);
      }
      
      private function __changeViewHandler(param1:Event) : void
      {
         _minosIconImg.visible = false;
         _minosFt.visible = false;
         _chesspvpCoinTxt.visible = false;
         _chesspvpCoinImg.visible = false;
         if(_group.getSelectedItem() == _consortiaShop)
         {
            FrameControllerManager.instance.shopController.initConsortiaShopFrame();
            _displayShowTxt.visible = true;
            _contributeTxt.text = playerInfo.consortiaOffer + "";
            _displayShowTxt2.visible = false;
            _currencyIcon.visible = false;
            _stripView.visible = false;
            _copyConsortiaImg.visible = _copyConsortiaTxtImg.visible = false;
            _displayShowTxt3.visible = _displayShowTxt3Txt.visible = false;
            _sealOfKingImg.visible = false;
            _displayShowTxt4.visible = false;
         }
         else if(_group.getSelectedItem() == _advConsortiaShop)
         {
            FrameControllerManager.instance.shopController.initAdvConsortiaShopFrame();
            _displayShowTxt.visible = false;
            _contributeTxt.text = PlayerCurrencyManager.instance.currencyInfo.guildSkill.amount + "";
            _displayShowTxt2.visible = true;
            _currencyIcon.visible = true;
            _stripView.visible = true;
            _stripView.tipData = _desGuildSkill;
            _copyConsortiaImg.visible = _copyConsortiaTxtImg.visible = false;
            _displayShowTxt3.visible = _displayShowTxt3Txt.visible = false;
            _sealOfKingImg.visible = false;
            _displayShowTxt4.visible = false;
         }
         else if(_group.getSelectedItem() == _treasureConsortiaBtn)
         {
            FrameControllerManager.instance.shopController.initTreasureConsortiaShopFrame();
            _displayShowTxt.visible = false;
            _contributeTxt.text = PlayerCurrencyManager.instance.currencyInfo.yellowCoin.amount + "";
            _displayShowTxt2.visible = false;
            _currencyIcon.visible = false;
            _stripView.visible = true;
            _stripView.tipData = _desYellowCoin;
            _copyConsortiaImg.visible = _copyConsortiaTxtImg.visible = false;
            _displayShowTxt3.visible = _displayShowTxt3Txt.visible = true;
            _sealOfKingImg.visible = false;
            _displayShowTxt4.visible = false;
         }
         else if(_group.getSelectedItem() == _copyConsortiaBtn)
         {
            FrameControllerManager.instance.shopController.initCopyConsortiaShopFrame();
            _displayShowTxt.visible = false;
            _contributeTxt.text = PlayerCurrencyManager.instance.currencyInfo.copyConsortia.amount + "";
            _displayShowTxt2.visible = false;
            _currencyIcon.visible = false;
            _stripView.visible = true;
            _stripView.tipData = _desCopyConsortia;
            _copyConsortiaImg.visible = _copyConsortiaTxtImg.visible = true;
            _displayShowTxt3.visible = _displayShowTxt3Txt.visible = false;
            _sealOfKingImg.visible = false;
            _displayShowTxt4.visible = false;
         }
         else if(_group.getSelectedItem() == _crossGuildShopBtn)
         {
            FrameControllerManager.instance.shopController.initNewCrossGuildShopFrame();
            _sealOfKingImg.visible = true;
            _stripView.visible = true;
            _stripView.tipData = _desCrossGuild;
            _contributeTxt.text = PlayerCurrencyManager.instance.currencyInfo.crossGuildCoin.amount + "";
            _displayShowTxt3.visible = _displayShowTxt3Txt.visible = false;
            _copyConsortiaImg.visible = _copyConsortiaTxtImg.visible = false;
            _displayShowTxt2.visible = false;
            _currencyIcon.visible = false;
            _displayShowTxt.visible = false;
            _displayShowTxt4.visible = false;
         }
         else if(_group.getSelectedItem() == _consortiaNewBossBtn)
         {
            FrameControllerManager.instance.shopController.initConsortiaNewBossShopFrame();
            _displayShowTxt4.visible = true;
            _stripView.visible = true;
            _contributeTxt.text = PlayerCurrencyManager.instance.currencyInfo.consortiaNewBossCoin.amount + "";
            _stripView.tipData = _desConsortiaNewBoss;
            _displayShowTxt2.visible = false;
            _currencyIcon.visible = false;
            _displayShowTxt.visible = false;
            _displayShowTxt3.visible = _displayShowTxt3Txt.visible = false;
            _copyConsortiaImg.visible = _copyConsortiaTxtImg.visible = false;
            _sealOfKingImg.visible = false;
         }
         else if(_group.getSelectedItem() == _minosBtn)
         {
            FrameControllerManager.instance.shopController.initConsortiaMinosShopFrame();
            _displayShowTxt.visible = false;
            if(PlayerCurrencyManager.instance.currencyInfo.minosCoin)
            {
               _contributeTxt.text = PlayerCurrencyManager.instance.currencyInfo.minosCoin.amount + "";
            }
            _displayShowTxt2.visible = false;
            _currencyIcon.visible = false;
            _stripView.visible = true;
            _stripView.tipData = _moiosCoinStr;
            _copyConsortiaImg.visible = _copyConsortiaTxtImg.visible = false;
            _displayShowTxt3.visible = _displayShowTxt3Txt.visible = false;
            _sealOfKingImg.visible = false;
            _displayShowTxt4.visible = false;
            _minosIconImg.visible = true;
            _minosFt.visible = true;
         }
         else if(_group.getSelectedItem() == _chesspvpBtn)
         {
            FrameControllerManager.instance.shopController.initConsortiaChessPvpShopFrame();
            _displayShowTxt.visible = false;
            if(PlayerCurrencyManager.instance.currencyInfo.chessPvpCoin)
            {
               _contributeTxt.text = PlayerCurrencyManager.instance.currencyInfo.chessPvpCoin.amount + "";
            }
            _displayShowTxt2.visible = false;
            _currencyIcon.visible = false;
            _stripView.visible = true;
            _stripView.tipData = _chesspvpConStr;
            _copyConsortiaImg.visible = _copyConsortiaTxtImg.visible = false;
            _displayShowTxt3.visible = _displayShowTxt3Txt.visible = false;
            _sealOfKingImg.visible = false;
            _displayShowTxt4.visible = false;
            _chesspvpCoinTxt.visible = true;
            _chesspvpCoinImg.visible = true;
         }
      }
      
      public function show(param1:Object = null) : void
      {
         var _loc2_:int = 0;
         KeyBoardRegister.instance.keyEnable = false;
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         if(_group && param1)
         {
            if(param1["minos"])
            {
               _loc2_ = _rollList.indexOf(_minosBtn);
               if(_loc2_ != -1)
               {
                  _group.selectIndex = _loc2_;
                  _rollPanel.skip(_loc2_);
               }
            }
            else if(param1["chesspvp"])
            {
               _loc2_ = _rollList.indexOf(_chesspvpBtn);
               if(_loc2_ != -1)
               {
                  _group.selectIndex = _loc2_;
                  _rollPanel.skip(_loc2_);
               }
            }
            else
            {
               _group.selectIndex = int(param1["type"]);
            }
         }
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      override public function dispose() : void
      {
         removeEvent();
         super.dispose();
         ObjectUtils.disposeObject(_consortiaShop);
         _consortiaShop = null;
         ObjectUtils.disposeObject(_advConsortiaShop);
         _advConsortiaShop = null;
         ObjectUtils.disposeObject(_treasureConsortiaBtn);
         _treasureConsortiaBtn = null;
         ObjectUtils.disposeObject(_copyConsortiaBtn);
         _copyConsortiaBtn = null;
         ObjectUtils.disposeObject(_crossGuildShopBtn);
         _crossGuildShopBtn = null;
         ObjectUtils.disposeObject(_consortiaNewBossBtn);
         _consortiaNewBossBtn = null;
         ObjectUtils.disposeObject(_minosBtn);
         _minosBtn = null;
         ObjectUtils.disposeObject(_chesspvpBtn);
         _chesspvpBtn = null;
         ObjectUtils.disposeObject(_group);
         _group = null;
         ObjectUtils.disposeObject(_rollPanel);
         _rollPanel = null;
         LogicUtils.disposeDisplayCollection(_itemList);
         _itemList = null;
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_stripView);
         _stripView = null;
         ObjectUtils.disposeObject(_currencyIcon);
         _currencyIcon = null;
         ObjectUtils.disposeObject(_prePageBtn);
         _prePageBtn = null;
         ObjectUtils.disposeObject(_nextPageBtn);
         _nextPageBtn = null;
         ObjectUtils.disposeObject(_pageNumTxt);
         _pageNumTxt = null;
         ObjectUtils.disposeObject(_contributeTxt);
         _contributeTxt = null;
         ObjectUtils.disposeAllChildren(this);
         KeyBoardRegister.instance.keyEnable = true;
         _rollList = null;
         _data = null;
      }
   }
}

