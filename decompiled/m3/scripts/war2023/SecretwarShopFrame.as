package war2023
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.exploitsshop.ExploitsShopRespMsg;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.PlayerCurrencyManager;
   import mvc.module.war2023.SecretWarModel;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.datas.templates.SecretwarShopTempInfo;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.SecretWarManager;
   import yishi.manager.SharedManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.community.TimeDownView;
   import yishi.view.frame.SimpleHelpFrame;
   import yishi.view.frame.TodayNotAlertFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class SecretwarShopFrame extends Frame
   {
      
      private var _bg:Bitmap;
      
      private var _refreshIcon:Bitmap;
      
      private var _displayShow:Bitmap;
      
      private var _icon:Bitmap;
      
      private var _displayShowTxt:Bitmap;
      
      private var _numTxt:FilterFrameText;
      
      private var _refreshBtn:IconButton;
      
      private var _autoRefreshTxt:FilterFrameText;
      
      private var _pointTxt:FilterFrameText;
      
      private var _refreshNumTxt:FilterFrameText;
      
      private var _goodsList:Vector.<SecretwarShopItem>;
      
      private var _simpleTileList:SimpleTileList;
      
      private var _downTime:TimeDownView;
      
      private var _helpBtn:BaseButton;
      
      public function SecretwarShopFrame()
      {
         super();
         initView();
         addEvent();
         SecretWarManager.Instance.shopOp(0);
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("secretwarShopFrame.titleText.text");
         _bg = ComponentFactory.Instance.creatBitmap("asset.secretwar.shopBg");
         _refreshIcon = ComponentFactory.Instance.creatBitmap("asset.secretwar.refreshIcon");
         _displayShow = ComponentFactory.Instance.creatBitmap("asset.shop.ShopDisplayShow02");
         _icon = ComponentFactory.Instance.creatBitmap("asset.secretwar.icon");
         _displayShowTxt = ComponentFactory.Instance.creatBitmap("asset.secretwar.displayShowTxt");
         _numTxt = ComponentFactory.Instance.creatComponentByStylename("SecretwarShopFrame.numTxt");
         _refreshBtn = ComponentFactory.Instance.creatComponentByStylename("SecretwarShopFrame.refreshBtn");
         _autoRefreshTxt = ComponentFactory.Instance.creatComponentByStylename("SecretwarShopFrame.autoRefreshTxt");
         _pointTxt = ComponentFactory.Instance.creatComponentByStylename("SecretwarShopFrame.pointTxt");
         _refreshNumTxt = ComponentFactory.Instance.creatComponentByStylename("SecretwarShopFrame.refreshNumTxt");
         _simpleTileList = ComponentFactory.Instance.creatCustomObject("SecretwarShopFrame.simpleTileList",[3]);
         _downTime = ComponentFactory.Instance.creatComponentByStylename("SecretwarShopFrame.downUpdateTime");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("SecretwarShopFrame.helpBtn");
         addToContent(_bg);
         addToContent(_refreshIcon);
         addToContent(_displayShow);
         _displayShow.x = 12;
         _displayShow.y = 357;
         addToContent(_icon);
         addToContent(_displayShowTxt);
         addToContent(_numTxt);
         addToContent(_refreshBtn);
         addToContent(_downTime);
         addToContent(_autoRefreshTxt);
         addToContent(_pointTxt);
         addToContent(_refreshNumTxt);
         addToContent(_simpleTileList);
         addToContent(_helpBtn);
         _autoRefreshTxt.text = LanguageMgr.GetTranslation("secretwarShopFrame.autoRefreshTxt.text");
         initItem();
         refreshTime();
      }
      
      private function refreshTime() : void
      {
         var _loc2_:Date = new Date();
         _loc2_.hours = playerModel.sysCurtime.hours;
         _loc2_.minutes = playerModel.sysCurtime.minutes;
         _loc2_.seconds = playerModel.sysCurtime.seconds;
         var _loc1_:Date = new Date();
         _loc1_.hours = 23;
         _loc1_.minutes = 59;
         _loc1_.seconds = 59;
         var _loc3_:Number = _loc1_.time - _loc2_.time;
         _downTime.timeCount = _loc3_ / 1000;
      }
      
      private function initItem() : void
      {
         var _loc1_:SecretwarShopItem = null;
         var _loc2_:int = 0;
         _goodsList = new Vector.<SecretwarShopItem>();
         _loc2_ = 0;
         while(_loc2_ < 6)
         {
            _loc1_ = new SecretwarShopItem();
            _goodsList.push(_loc1_);
            _simpleTileList.addChild(_loc1_);
            _loc2_++;
         }
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         NotificationManager.instance.addEventListener("secretwarShopEvent",__updateShopInfoHandler);
         _refreshBtn.addEventListener("click",__refreshBtnClickHandler);
         _helpBtn.addEventListener("click",__helpBtnClickHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         NotificationManager.instance.removeEventListener("secretwarShopEvent",__updateShopInfoHandler);
         _refreshBtn.removeEventListener("click",__refreshBtnClickHandler);
         _helpBtn.removeEventListener("click",__helpBtnClickHandler);
      }
      
      private function __helpBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("secretwarShopFrame.HelpFrame");
         _loc2_.show();
      }
      
      private function __refreshBtnClickHandler(param1:MouseEvent) : void
      {
         if(refreshCounts <= 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("secretwarShopFrame.refreshCounts.text"));
            return;
         }
         refreshCall();
      }
      
      private function refreshAlert(param1:Function = null) : Boolean
      {
         var _loc8_:TodayNotAlertFrame = null;
         var _loc7_:String = null;
         var _loc3_:String = null;
         var _loc4_:Date = SharedManager.instance.secretwarShopRefreshCheckDate;
         var _loc6_:Boolean = Boolean(SharedManager.instance.secretwarShopRefresh);
         var _loc5_:Date = new Date();
         var _loc2_:Boolean = false;
         if(!_loc6_ || _loc4_.month <= _loc4_.month && _loc4_.date < _loc5_.date)
         {
            _loc2_ = true;
         }
         if(_loc2_)
         {
            _loc8_ = ComponentFactory.Instance.creatComponentByStylename("worldboss.RiverNotAlert");
            _loc7_ = LanguageMgr.GetTranslation("secretwarShopFrame.refreshAlert.content.text",price);
            _loc3_ = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
            _loc8_.show(_loc7_,_loc3_,refreshAlertBack,null,"center");
         }
         return _loc2_;
      }
      
      private function refreshAlertBack(param1:Boolean, param2:Boolean) : void
      {
         SharedManager.instance.secretwarShopRefresh = param1;
         SharedManager.instance.secretwarShopRefreshCheckDate = new Date();
         SharedManager.instance.saveSecretwarShopRefreshCheck();
         SharedManager.instance.secretwarShopRefreshUseBind = param2;
         SharedManager.instance.saveSecretwarShopRefreshUseBind();
         refreshShop();
      }
      
      private function refreshShop() : void
      {
         var _loc1_:int = 1;
         if(SharedManager.instance.secretwarShopRefreshUseBind)
         {
            _loc1_ = 2;
         }
         var _loc2_:int = 0;
         if(_loc1_ == 1)
         {
            _loc2_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.point);
         }
         else
         {
            _loc2_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.allPoint);
         }
         if(_loc2_ < price)
         {
            RechargeAlertMannager.show();
            return;
         }
         SecretWarManager.Instance.shopOp(2,_loc1_);
      }
      
      private function refreshCall() : void
      {
         var _loc5_:SecretwarShopTempInfo = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc1_:Boolean = false;
         for each(var _loc2_:ExploitsShopRespMsg in model.shopInfo)
         {
            _loc5_ = TempleteManager.instance.secretwarShopTempCate.getTempInfoById(_loc2_.mapShopId);
            if(_loc5_ && _loc5_.IsDrop == 1 && _loc2_.state == 0)
            {
               _loc1_ = true;
               break;
            }
         }
         if(_loc1_)
         {
            SimpleAlertHelper.instance.data = [callBack];
            _loc3_ = LanguageMgr.GetTranslation("public.confirm");
            _loc4_ = LanguageMgr.GetTranslation("public.cancel");
            _loc6_ = LanguageMgr.GetTranslation("public.prompt");
            _loc7_ = LanguageMgr.GetTranslation("secretwarShopFrame.drop.refreshContent.text");
            SimpleAlertHelper.instance.popAlerFrame(_loc6_,_loc7_,_loc3_,_loc4_,true,true);
         }
         else
         {
            if(refreshAlert(refreshAlertBack))
            {
               return;
            }
            refreshShop();
         }
      }
      
      private function callBack(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            if(refreshAlert(refreshAlertBack))
            {
               return;
            }
            refreshShop();
         }
      }
      
      private function __updateShopInfoHandler(param1:Event) : void
      {
         refreshView();
      }
      
      protected function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      public function refreshView() : void
      {
         var _loc2_:ExploitsShopRespMsg = null;
         var _loc3_:SecretwarShopItem = null;
         var _loc4_:int = 0;
         _refreshNumTxt.text = refreshCounts + "/" + refreshLimitTimes;
         _pointTxt.text = price.toString();
         _numTxt.text = displayShowNum.toString();
         var _loc1_:Array = model.shopInfo;
         _loc4_ = 0;
         while(_loc4_ < _loc1_.length)
         {
            _loc2_ = _loc1_[_loc4_];
            _loc3_ = _goodsList[_loc4_];
            if(_loc3_)
            {
               _loc3_.data = _loc2_;
            }
            _loc4_++;
         }
         refreshTime();
      }
      
      public function get refreshLimitTimes() : int
      {
         return ConfigInfoManager.instance.secretwarRefreshLimitTimes;
      }
      
      public function get refreshCounts() : int
      {
         return refreshLimitTimes - model.refreshCounts;
      }
      
      public function get price() : int
      {
         return ConfigInfoManager.instance.secretwarRefreshPrice;
      }
      
      public function get displayShowNum() : int
      {
         return PlayerCurrencyManager.instance.currencyInfo.secretwarShopCoin.amount;
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function get model() : SecretWarModel
      {
         return SecretWarManager.Instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_refreshIcon);
         _refreshIcon = null;
         ObjectUtils.disposeObject(_displayShow);
         _displayShow = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_displayShowTxt);
         _displayShowTxt = null;
         ObjectUtils.disposeObject(_numTxt);
         _numTxt = null;
         ObjectUtils.disposeObject(_refreshBtn);
         _refreshBtn = null;
         ObjectUtils.disposeObject(_autoRefreshTxt);
         _autoRefreshTxt = null;
         ObjectUtils.disposeObject(_pointTxt);
         _pointTxt = null;
         ObjectUtils.disposeObject(_refreshNumTxt);
         _refreshNumTxt = null;
         ObjectUtils.disposeObject(_downTime);
         _downTime = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

