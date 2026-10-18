package gamehall
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import events.GameHallEvent;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import gamehall.view.GameHallEastShopItemView;
   import manager.LanguageMgr;
   import managers.GameHallManager;
   import managers.PlayerCurrencyManager;
   import mvc.module.currency.PlayerCurrencyInfo;
   import mvc.module.gamehall.GameHallEastShopInfo;
   import mvc.module.gamehall.GameHallLotteryInfo;
   import mvc.module.gamehall.GameHallModel;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.GamehallEastDropTemplate;
   import yishi.events.NotificationEvent;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.TempleteManager;
   import yishi.view.tips.MessageTipManager;
   
   public class GameHallEastShopFrame extends Frame implements IManualSize
   {
      
      private var _bottoImg:Image;
      
      private var _rightImage:Image;
      
      private var _oneBtn:IconButton;
      
      private var _tenBtn:IconButton;
      
      private var _refreshGoodsBtn:BaseButton;
      
      private var _descBtn:TextButton;
      
      private var _costTxt1:FilterFrameText;
      
      private var _costTxt2:FilterFrameText;
      
      private var _costImage1:Image;
      
      private var _costImage2:Image;
      
      private var _costNumber1:FilterFrameText;
      
      private var _costNumber2:FilterFrameText;
      
      private var _goodsListScroll:ScrollPanel;
      
      private var _model:GameHallModel;
      
      private var _costEggNumber:int;
      
      private var _centerGoodsListView:Sprite;
      
      private var _currentRemianEggNumber:FilterFrameText;
      
      private var _currentNumerTxt:FilterFrameText;
      
      private var _topBack:Bitmap;
      
      private var _shopBack:MutipleImage;
      
      private var _leftProgressTxt:FilterFrameText;
      
      public function GameHallEastShopFrame()
      {
         super();
         _model = GameHallManager.instance.model;
         GameHallManager.instance.opEastFrame(2);
         initView();
         addEvent();
         refreshView();
      }
      
      private function initView() : void
      {
         _bottoImg = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallEastShopFrame.bottoImg");
         _rightImage = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallEastShopFrame.rightImage");
         _topBack = ComponentFactory.Instance.creatBitmap("asset.gamehall.topBg");
         _oneBtn = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallEastShopFrame.oneBtn");
         _tenBtn = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallEastShopFrame.tenBtn");
         _refreshGoodsBtn = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallEastShopFrame.refreshGoodsBtn");
         _descBtn = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallEastShopFrame.descBtn");
         _costTxt1 = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallEastShopFrame.costTxt1");
         _costTxt2 = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallEastShopFrame.costTxt2");
         _costImage1 = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallEastShopFrame.costImage1");
         _costImage2 = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallEastShopFrame.costImage2");
         _costNumber1 = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallEastShopFrame.costNumber1");
         _costNumber2 = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallEastShopFrame.costNumber2");
         _goodsListScroll = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallEastShopFrame.goodsListScroll");
         _currentRemianEggNumber = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallEastShopFrame.currentRemianEggNumber");
         _currentNumerTxt = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallEastShopFrame.currentNumerTxt");
         _shopBack = ComponentFactory.Instance.creatComponentByStylename("gamehall.ShopImage");
         _leftProgressTxt = ComponentFactory.Instance.creatComponentByStylename("gamehall.east.shopProgrssTxt");
         _centerGoodsListView = new Sprite();
         addToContent(_rightImage);
         addToContent(_bottoImg);
         addToContent(_topBack);
         addToContent(_shopBack);
         addToContent(_oneBtn);
         addToContent(_tenBtn);
         addToContent(_refreshGoodsBtn);
         addToContent(_descBtn);
         addToContent(_costTxt1);
         addToContent(_costTxt2);
         addToContent(_costImage1);
         addToContent(_costImage2);
         addToContent(_costNumber1);
         addToContent(_costNumber2);
         addToContent(_goodsListScroll);
         addToContent(_currentRemianEggNumber);
         addToContent(_currentNumerTxt);
         addToContent(_leftProgressTxt);
         _goodsListScroll.setView(_centerGoodsListView);
         _costEggNumber = ConfigInfoManager.instance.getEasterLotteryEggCount();
         if(currencyInfo.eastEggCoin)
         {
            _currentRemianEggNumber.text = currencyInfo.eastEggCoin.amount.toString();
         }
         _costTxt1.text = LanguageMgr.GetTranslation("gamehall.GameHallEastShopFrame.costTxt");
         _costTxt2.text = LanguageMgr.GetTranslation("gamehall.GameHallEastShopFrame.costTxt");
         _descBtn.text = LanguageMgr.GetTranslation("gamehall.GameHallEastShopFrame.descTxt");
         _currentNumerTxt.text = LanguageMgr.GetTranslation("gamehall.btnTxt1",_model.num);
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_leftProgressTxt);
         _leftProgressTxt = null;
         ObjectUtils.disposeObject(_bottoImg);
         _bottoImg = null;
         ObjectUtils.disposeObject(_rightImage);
         _rightImage = null;
         ObjectUtils.disposeObject(_topBack);
         _topBack = null;
         ObjectUtils.disposeObject(_shopBack);
         _shopBack = null;
         ObjectUtils.disposeObject(_oneBtn);
         _oneBtn = null;
         ObjectUtils.disposeObject(_tenBtn);
         _tenBtn = null;
         ObjectUtils.disposeObject(_refreshGoodsBtn);
         _refreshGoodsBtn = null;
         ObjectUtils.disposeObject(_descBtn);
         _descBtn = null;
         ObjectUtils.disposeObject(_costTxt1);
         _costTxt1 = null;
         ObjectUtils.disposeObject(_costTxt2);
         _costTxt2 = null;
         ObjectUtils.disposeObject(_costImage1);
         _costImage1 = null;
         ObjectUtils.disposeObject(_costImage2);
         _costImage2 = null;
         ObjectUtils.disposeObject(_costNumber1);
         _costNumber1 = null;
         ObjectUtils.disposeObject(_costNumber2);
         _costNumber2 = null;
         ObjectUtils.disposeObject(_centerGoodsListView);
         _centerGoodsListView = null;
         ObjectUtils.disposeObject(_goodsListScroll);
         _goodsListScroll = null;
         ObjectUtils.disposeObject(_currentRemianEggNumber);
         _currentRemianEggNumber = null;
         ObjectUtils.disposeObject(_currentNumerTxt);
         _currentNumerTxt = null;
         ObjectUtils.disposeAllChildren(this);
         ObjectUtils.disposeSelf(this);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         if(_oneBtn)
         {
            _oneBtn.addEventListener("click",__oneBtnHandler);
         }
         if(_tenBtn)
         {
            _tenBtn.addEventListener("click",__tenBtnHandeler);
         }
         if(_refreshGoodsBtn)
         {
            _refreshGoodsBtn.addEventListener("click",__refreshGoodsBtnHandeler);
         }
         if(_descBtn)
         {
            _descBtn.addEventListener("click",__descBtnHandler);
         }
         if(_model)
         {
            _model.addEventListener("UPDATE_SHOPINFO",__updateShopInfohandler);
         }
         NotificationManager.instance.addEventListener("CURRENCYREFRESH",__updateEggNumber);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_oneBtn)
         {
            _oneBtn.removeEventListener("click",__oneBtnHandler);
         }
         if(_tenBtn)
         {
            _tenBtn.removeEventListener("click",__tenBtnHandeler);
         }
         if(_refreshGoodsBtn)
         {
            _refreshGoodsBtn.removeEventListener("click",__refreshGoodsBtnHandeler);
         }
         if(_descBtn)
         {
            _descBtn.removeEventListener("click",__descBtnHandler);
         }
         if(_model)
         {
            _model.removeEventListener("UPDATE_SHOPINFO",__updateShopInfohandler);
         }
         NotificationManager.instance.removeEventListener("CURRENCYREFRESH",__updateEggNumber);
      }
      
      private function __oneBtnHandler(param1:MouseEvent) : void
      {
         if(currencyInfo.eastEggCoin.amount < _costEggNumber)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("gamehall.gamehallEastShopFrame.eggcount"));
            return;
         }
         GameHallManager.instance.opEastFrame(3,1);
      }
      
      private function __tenBtnHandeler(param1:MouseEvent) : void
      {
         if(currencyInfo.eastEggCoin.amount < 10 * _costEggNumber)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("gamehall.gamehallEastShopFrame.eggcount"));
            return;
         }
         GameHallManager.instance.opEastFrame(3,10);
      }
      
      private function __refreshGoodsBtnHandeler(param1:MouseEvent) : void
      {
         if(!canCheck())
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("gamehall.gameHallEastShopFrame.refreshTips"));
            return;
         }
         GameHallManager.instance.opEastFrame(4);
      }
      
      private function canCheck() : Boolean
      {
         var _loc4_:int = 0;
         var _loc1_:GameHallLotteryInfo = null;
         var _loc5_:int = 0;
         var _loc3_:GamehallEastDropTemplate = null;
         var _loc6_:Array = _model.eastInfoArr;
         var _loc2_:Boolean = true;
         if(_loc6_)
         {
            _loc4_ = int(_loc6_.length);
            _loc5_ = 0;
            while(_loc5_ < _loc4_)
            {
               _loc1_ = _loc6_[_loc5_] as GameHallLotteryInfo;
               if(_loc1_)
               {
                  _loc3_ = TempleteManager.instance.gamehallEastShopTempCate.getTemplateByID(_loc1_.temlateId);
                  if(_loc3_)
                  {
                     if(_loc3_.isShow == 1 && _loc1_.remainNum != 0)
                     {
                        _loc2_ = false;
                        break;
                     }
                  }
               }
               _loc5_++;
            }
         }
         return _loc2_;
      }
      
      private function refreshView() : void
      {
         var _loc2_:GameHallEastShopItemView = null;
         var _loc1_:int = 0;
         var _loc7_:int = 0;
         var _loc3_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:GameHallEastShopInfo = null;
         var _loc5_:int = 0;
         _costNumber1.text = "x" + _costEggNumber;
         _costNumber2.text = "x" + 10 * _costEggNumber;
         _currentNumerTxt.text = LanguageMgr.GetTranslation("gamehall.btnTxt1",_model.num);
         var _loc4_:int = 2;
         var _loc6_:Array = _model.eastInfoArr;
         _goodsListScroll.beginChanges();
         if(_loc6_)
         {
            if(_centerGoodsListView && _centerGoodsListView.numChildren > 0)
            {
               _centerGoodsListView.removeChildren(0,_centerGoodsListView.numChildren - 1);
            }
            _loc3_ = int(_loc6_.length);
            _loc8_ = Math.ceil(_loc3_ / _loc4_);
            _loc5_ = 0;
            while(_loc5_ < _loc3_)
            {
               _loc2_ = new GameHallEastShopItemView();
               _loc2_.x = 10 + _loc5_ % _loc4_ * 250;
               _loc2_.y = int(_loc5_ / _loc4_) * 100;
               _loc9_ = getGameHallEastShopInfo(_loc6_[_loc5_]);
               _loc2_.data = _loc9_;
               _loc1_ += _loc9_.hasGetNumber + _loc9_.remainNumber;
               _loc7_ += _loc9_.remainNumber;
               _centerGoodsListView.addChild(_loc2_);
               _loc5_++;
            }
            if(_loc8_ > 0)
            {
               _centerGoodsListView.scrollRect = new Rectangle(0,0,529,_loc8_ * 100);
            }
            _goodsListScroll.setView(_centerGoodsListView);
            _goodsListScroll.invalidateViewport();
            _goodsListScroll.commitChanges();
            _leftProgressTxt.text = LanguageMgr.GetTranslation("gamehall.GameHallEastShopFrame.leftNum",_loc7_,_loc1_);
         }
      }
      
      private function getGameHallEastShopInfo(param1:GameHallLotteryInfo) : GameHallEastShopInfo
      {
         var _loc4_:GoodsInfo = new GoodsInfo();
         var _loc3_:GameHallEastShopInfo = new GameHallEastShopInfo();
         var _loc2_:GamehallEastDropTemplate = TempleteManager.instance.gamehallEastShopTempCate.getTemplateByID(param1.temlateId);
         if(_loc2_)
         {
            _loc4_.templateId = _loc2_.itemId;
            _loc3_.remainNumber = param1.remainNum;
            _loc3_.isShow = _loc2_.isShow;
         }
         _loc3_.goodsInfo = _loc4_;
         _loc3_.hasGetNumber = _loc2_.count - param1.remainNum;
         return _loc3_;
      }
      
      private function get currencyInfo() : PlayerCurrencyInfo
      {
         return PlayerCurrencyManager.instance.currencyInfo;
      }
      
      private function __updateShopInfohandler(param1:GameHallEvent) : void
      {
         refreshView();
      }
      
      private function __descBtnHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("gamehall","EAST_SHOP_DESC");
      }
      
      private function __updateEggNumber(param1:NotificationEvent) : void
      {
         if(currencyInfo.eastEggCoin)
         {
            _currentRemianEggNumber.text = currencyInfo.eastEggCoin.amount.toString();
         }
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      public function show() : void
      {
         titleText = LanguageMgr.GetTranslation("gamehall.GameHallEastShopFrame.titleTxt");
         LayerManager.Instance.addToLayer(this,3,true,true,2);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,810,630);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         uninitView();
         super.dispose();
      }
   }
}

