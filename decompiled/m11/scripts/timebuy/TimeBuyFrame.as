package timebuy
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import manager.LanguageMgr;
   import managers.ShopManager;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.events.NotificationEvent;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   
   public class TimeBuyFrame extends Frame
   {
      
      private var _roleImg:Bitmap;
      
      private var _bg01:ScaleBitmapImage;
      
      private var _bg02:Bitmap;
      
      private var _pageNumbg:Bitmap;
      
      private var _pageNumTxt:FilterFrameText;
      
      private var _lastBtn:IconButton;
      
      private var _nextBtn:IconButton;
      
      private var _pointBg:MutipleImage;
      
      private var _pointTxt:FilterFrameText;
      
      private var _chargeBtn:IconButton;
      
      private var _itemList:Vector.<TimeBuyItem>;
      
      private var _isVIPShop:Boolean = false;
      
      private var _countGood:int = 0;
      
      private var _currentPage:int = 1;
      
      private var _totalPage:int;
      
      private var b:Boolean = true;
      
      private var _homepageTime:Timer;
      
      private var _sprite:Sprite;
      
      private var _sprite2:Sprite;
      
      public function TimeBuyFrame()
      {
         super();
         initView();
         initEvent();
         updateView();
      }
      
      private function initView() : void
      {
         var _loc3_:int = 0;
         var _loc1_:TimeBuyItem = null;
         this.titleText = LanguageMgr.GetTranslation("ui.toptoolbar.TopToolsBar.timeBuy.tipsData");
         _roleImg = ComponentFactory.Instance.creatBitmap("asset.timebuy.roleImg");
         _bg01 = ComponentFactory.Instance.creatComponentByStylename("timebuy.bg01");
         _bg02 = ComponentFactory.Instance.creatBitmap("asset.timebuy.splitLine");
         _pageNumbg = ComponentFactory.Instance.creatBitmap("asset.timebuy.pageNumBg");
         _pageNumTxt = ComponentFactory.Instance.creatComponentByStylename("timebuy.PageTextStyle1");
         _lastBtn = ComponentFactory.Instance.creatComponentByStylename("timebuy.LastPageBtn");
         _nextBtn = ComponentFactory.Instance.creatComponentByStylename("timebuy.NextPageBtn");
         _pointBg = ComponentFactory.Instance.creatComponentByStylename("timebuy.pointImage");
         _pointTxt = ComponentFactory.Instance.creatComponentByStylename("timebuy.PointTextStyle1");
         _chargeBtn = ComponentFactory.Instance.creatComponentByStylename("timebuy.ChargeBtn");
         _itemList = new Vector.<TimeBuyItem>();
         addToContent(_roleImg);
         addToContent(_bg01);
         addToContent(_bg02);
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < 9)
         {
            _loc4_ = _loc3_ / 3;
            _loc2_ = _loc3_ % 3;
            _loc1_ = new TimeBuyItem();
            _loc1_.x = _loc2_ * (_loc1_.width - 3) + 205;
            _loc1_.y = _loc4_ * (_loc1_.height - 12) + 36;
            addToContent(_loc1_);
            _itemList.push(_loc1_);
            _loc3_++;
         }
         addToContent(_pageNumbg);
         addToContent(_pageNumTxt);
         addToContent(_lastBtn);
         addToContent(_nextBtn);
         addToContent(_pointBg);
         addToContent(_pointTxt);
         _pointTxt.text = playerInfo.point + "";
         addToContent(_chargeBtn);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         NotificationManager.instance.addEventListener("SHOPHOMEPAGE_UPDATA",__updateHandler);
         StageReferance.stage.addEventListener("resize",__resizeHanlder);
         _lastBtn.addEventListener("click",_preHandler);
         _nextBtn.addEventListener("click",_nextHandler);
         _chargeBtn.addEventListener("click",__rechargeHandler);
         playerInfo.addEventListener("PLAYER_INFO_UPDATE",__refreshPlayerInfoHandler);
         NotificationManager.instance.addEventListener("SHOP_TIME_BUY_REFRESH",__refreshTimeBuy);
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
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         NotificationManager.instance.removeEventListener("SHOPHOMEPAGE_UPDATA",__updateHandler);
         StageReferance.stage.removeEventListener("resize",__resizeHanlder);
         _lastBtn.removeEventListener("click",_preHandler);
         _nextBtn.removeEventListener("click",_nextHandler);
         _chargeBtn.removeEventListener("click",__rechargeHandler);
         playerInfo.removeEventListener("PLAYER_INFO_UPDATE",__refreshPlayerInfoHandler);
         NotificationManager.instance.removeEventListener("SHOP_TIME_BUY_REFRESH",__refreshTimeBuy);
      }
      
      private function __resizeHanlder(param1:Event) : void
      {
         var _loc2_:int = int(StageReferance.stageWidth);
         var _loc3_:int = int(StageReferance.stageHeight);
         this.x = (_loc2_ - this.width) / 2;
         this.y = (_loc3_ - this.height) / 2;
      }
      
      public function updateView() : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         _countGood = 0;
         var _loc1_:Array = ShopManager.Instance.model.getTimeBuyList2();
         if(_loc1_.length <= 0)
         {
            this.dispose();
            return;
         }
         if(_loc1_.length % 9 != 0 || _loc1_.length == 0)
         {
            _totalPage = _loc1_.length / 9 + 1;
         }
         else
         {
            _totalPage = _loc1_.length / 9;
         }
         _loc3_ = 0;
         while(_loc3_ < 9)
         {
            if(_currentPage - 1 < 0)
            {
               _loc2_ = _loc3_;
            }
            else
            {
               _loc2_ = _loc3_ + (_currentPage - 1) * 9;
            }
            if(_loc1_.length > _loc2_)
            {
               _countGood = _countGood + 1;
               _itemList[_loc3_].data = _loc1_[_loc2_];
            }
            else
            {
               _itemList[_loc3_].data = null;
            }
            _loc3_++;
         }
         if(_countGood > 0)
         {
            if(_homepageTime == null)
            {
               addTimer();
            }
            __updateTimeHandler(null);
         }
         updatePageView();
      }
      
      private function __updateTimeHandler(param1:TimerEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Number = NaN;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < 9)
         {
            if(_itemList[_loc2_].data)
            {
               _loc3_ = Number(_itemList[_loc2_].data.remainTime);
               if(_loc3_ > 0)
               {
                  _itemList[_loc2_].timeText = _loc3_;
               }
               else
               {
                  _itemList[_loc2_].data = null;
                  updateView();
               }
               if(_itemList[_loc2_].data.type == 2)
               {
                  _loc4_ = int(ShopManager.Instance.timeBuyDesc);
                  _loc5_ = _loc4_ - playerModel.sysCurTimeBySecond;
                  if(_loc5_ > 0)
                  {
                     _itemList[_loc2_].timeText = _loc5_;
                     b = true;
                  }
                  else if(b)
                  {
                     b = false;
                     ShopManager.Instance.refreshTimeGoods();
                     ShopManager.Instance.refreshGoodsCount();
                  }
               }
            }
            _loc2_++;
         }
      }
      
      private function updatePageView() : void
      {
         _pageNumTxt.text = _currentPage + "/" + _totalPage;
         if(_currentPage == 1)
         {
            _lastBtn.enable = false;
         }
         else
         {
            _lastBtn.enable = true;
         }
         if(_currentPage == _totalPage)
         {
            _nextBtn.enable = false;
         }
         else
         {
            _nextBtn.enable = true;
         }
      }
      
      private function addTimer() : void
      {
         _homepageTime = new Timer(1000);
         _homepageTime.addEventListener("timer",__updateTimeHandler);
         _homepageTime.start();
      }
      
      private function _preHandler(param1:MouseEvent) : void
      {
         _currentPage = _currentPage - 1;
         updateView();
         updatePageView();
      }
      
      private function _nextHandler(param1:MouseEvent) : void
      {
         _currentPage = _currentPage + 1;
         updateView();
         updatePageView();
      }
      
      private function __updateHandler(param1:NotificationEvent) : void
      {
         removeTimer();
         updateView();
      }
      
      private function __rechargeHandler(param1:Event) : void
      {
         SoundManager.instance.play("022");
         RechargeAlertMannager.navigateToRechargePage();
      }
      
      private function removeTimer() : void
      {
         if(_homepageTime)
         {
            _homepageTime.stop();
            _homepageTime.removeEventListener("timer",__updateTimeHandler);
            _homepageTime = null;
         }
      }
      
      private function __refreshPlayerInfoHandler(param1:Event) : void
      {
         _pointTxt.text = playerInfo.point + "";
      }
      
      private function __refreshTimeBuy(param1:NotificationEvent) : void
      {
         updateView();
      }
      
      override public function get groups() : Array
      {
         return ["CASTLE_BUIDING_GROUP","MAIN_TOOLS_GROUP"];
      }
      
      public function show() : void
      {
         SoundManager.instance.play("020",true);
         LayerManager.Instance.addToLayer(this,3,true,false);
         KeyBoardRegister.instance.keyEnable = false;
         ShopManager.Instance.refreshTimeGoods();
         ShopManager.Instance.isFrist = false;
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function uninit() : void
      {
         ObjectUtils.disposeObject(_roleImg);
         ObjectUtils.disposeObject(_bg01);
         ObjectUtils.disposeObject(_bg02);
         ObjectUtils.disposeObject(_pageNumbg);
         ObjectUtils.disposeObject(_pageNumTxt);
         ObjectUtils.disposeObject(_lastBtn);
         ObjectUtils.disposeObject(_nextBtn);
         ObjectUtils.disposeObject(_pointBg);
         ObjectUtils.disposeObject(_pointTxt);
         ObjectUtils.disposeObject(_chargeBtn);
         while(_itemList.length)
         {
            ObjectUtils.disposeObject(_itemList.shift());
         }
         _countGood = 0;
         _currentPage = 1;
         b = true;
      }
      
      override public function dispose() : void
      {
         KeyBoardRegister.instance.keyEnable = true;
         removeTimer();
         removeEvent();
         uninit();
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

