package view.subshop
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.NavigationManager;
   import mvc.module.mounts.MountShopInfo;
   import mvc.module.navigation.NavigationModel;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.ConfigInfoManager;
   import yishi.manager.NotAlertManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.utils.MsgMan;
   import yishi.view.community.TimeDownView;
   
   public class NavigationShopFrame extends Frame
   {
      
      private static const MAX_SHOW_NUM:int = 6;
      
      private var _border:Scale9CornerImage;
      
      private var _dailyCountTxt:FilterFrameText;
      
      private var _bottomBg:Bitmap;
      
      private var _freshTimeTxt:FilterFrameText;
      
      private var _downTime:TimeDownView;
      
      private var _pointsShow:MutipleImage;
      
      private var _pointsShowTxt:FilterFrameText;
      
      private var _quickRefreshBtn:IconButton;
      
      private var _freeRefreshBtn:IconButton;
      
      private var _buyGoodsList:Vector.<NavigationShopGoodsItem>;
      
      private var _refreshCost:int;
      
      private var _maxBuyCount:int;
      
      public function NavigationShopFrame()
      {
         super();
         _refreshCost = ConfigInfoManager.instance.getNavigationShopRefreshPoint();
         _maxBuyCount = ConfigInfoManager.instance.getNavigationShopBuyNum();
         initView();
         createGoodsList();
         addEvent();
         refreshView();
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         _border = ComponentFactory.Instance.creatComponentByStylename("NavigationShopFrame.rightBackBg");
         _bottomBg = ComponentFactory.Instance.creatBitmap("asset.NavigationShop.bottomBack");
         _dailyCountTxt = ComponentFactory.Instance.creatComponentByStylename("NavigationShopFrame.DailyCountTxt");
         _pointsShow = ComponentFactory.Instance.creatComponentByStylename("NavigationShopFrame.displayShowPoints");
         _pointsShowTxt = ComponentFactory.Instance.creatComponentByStylename("NavigationShopFrame.displayShowTxt");
         _freshTimeTxt = ComponentFactory.Instance.creatComponentByStylename("NavigationShopFrame.freshTimeTxt");
         _downTime = ComponentFactory.Instance.creatComponentByStylename("NavigationShopFrame.downUpdateTime");
         _quickRefreshBtn = ComponentFactory.Instance.creatComponentByStylename("NavigationShopFrame.QuickRefreshBtn");
         _freeRefreshBtn = ComponentFactory.Instance.creatComponentByStylename("NavigationShopFrame.FreeRefreshBtn");
         addToContent(_border);
         addToContent(_bottomBg);
         addToContent(_dailyCountTxt);
         addToContent(_pointsShow);
         addToContent(_pointsShowTxt);
         addToContent(_quickRefreshBtn);
         addToContent(_freeRefreshBtn);
         addToContent(_freshTimeTxt);
         addToContent(_downTime);
         _freshTimeTxt.text = LanguageMgr.GetTranslation("outercityshop.OuterCityShopFrame.freshTimeText");
         _quickRefreshBtn.tipData = LanguageMgr.GetTranslation("NavigationShopFrame.QuickRefreshBtn.tipdata",_refreshCost);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _downTime.addEventListener("timerDown_complete",__timeCompleteHandler);
         MsgMan.addObserver("NAVIGATION_DATA_CHANGE",this,__updateShopList);
         _quickRefreshBtn.addEventListener("click",__quickFreshHandler);
         _freeRefreshBtn.addEventListener("click",__freeFreshHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _downTime.removeEventListener("timerDown_complete",__timeCompleteHandler);
         MsgMan.removeObserver("NAVIGATION_DATA_CHANGE",this,__updateShopList);
         _quickRefreshBtn.removeEventListener("click",__quickFreshHandler);
         _freeRefreshBtn.removeEventListener("click",__freeFreshHandler);
      }
      
      private function __quickFreshHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
         var _loc3_:String = LanguageMgr.GetTranslation("navigation.NavigationShopFrame.refresh.alertText",_refreshCost);
         NotAlertManager.ins.needAlert("navigation.NavigationShopFrame.refreshAlert",refreshResultHandler,_loc2_,_loc3_);
      }
      
      private function refreshResultHandler(param1:Boolean) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(param1)
         {
            _loc2_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.allPoint);
         }
         else
         {
            _loc2_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.point);
         }
         if(_loc2_ >= _refreshCost)
         {
            _loc3_ = param1 ? 0 : 1;
            NavigationManager.instance.sendNavigationOperate(15,"","",1,_loc3_);
         }
         else
         {
            RechargeAlertMannager.show();
         }
      }
      
      private function __freeFreshHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         NavigationManager.instance.sendNavigationOperate(15,"","",0,0);
      }
      
      private function __timeCompleteHandler(param1:Event) : void
      {
         _downTime.timeCount = 0;
         _downTime.visible = false;
         _freshTimeTxt.visible = false;
         _quickRefreshBtn.visible = false;
         _freeRefreshBtn.visible = true;
      }
      
      private function __updateShopList(param1:String, param2:Object) : void
      {
         refreshView();
      }
      
      private function refreshView() : void
      {
         updateGoodsListData();
         var _loc2_:String = _maxBuyCount - model.hasBuyShopNum + "/" + _maxBuyCount;
         _dailyCountTxt.text = LanguageMgr.GetTranslation("auction.view.mysteryshop.BuyCountView.tipText") + _loc2_;
         _pointsShowTxt.text = model.currency.toString();
         var _loc1_:int = model.shopRefreshTime - PlayerManager.instance.currentPlayerModel.sysSecond;
         if(_loc1_ > 0)
         {
            _downTime.visible = true;
            _freshTimeTxt.visible = true;
            _downTime.timeCount = _loc1_;
            _quickRefreshBtn.visible = true;
            _freeRefreshBtn.visible = false;
         }
         else
         {
            _downTime.timeCount = 0;
            _downTime.visible = false;
            _freshTimeTxt.visible = false;
            _quickRefreshBtn.visible = false;
            _freeRefreshBtn.visible = true;
         }
      }
      
      private function createGoodsList() : void
      {
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc1_:NavigationShopGoodsItem = null;
         _buyGoodsList = new Vector.<NavigationShopGoodsItem>();
         _loc3_ = 0;
         while(_loc3_ < 6)
         {
            _loc1_ = new NavigationShopGoodsItem();
            _loc4_ = _loc3_ / 2;
            _loc2_ = _loc3_ % 2;
            _loc1_.x = 8 + _loc2_ * 251;
            _loc1_.y = 70 + _loc4_ * 100;
            _buyGoodsList.push(_loc1_);
            addToContent(_loc1_);
            _loc3_++;
         }
      }
      
      private function updateGoodsListData() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _buyGoodsList.length)
         {
            if(model.shopList && model.shopList[_loc1_])
            {
               _buyGoodsList[_loc1_].data = model.shopList[_loc1_] as MountShopInfo;
            }
            else
            {
               _buyGoodsList[_loc1_].data = null;
            }
            _loc1_++;
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
      
      private function get model() : NavigationModel
      {
         return NavigationManager.instance.model;
      }
      
      public function show(param1:int = 0) : void
      {
         titleText = LanguageMgr.GetTranslation("view.subshop.NavigationShopFrame.titleText");
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_border);
         _border = null;
         ObjectUtils.disposeObject(_bottomBg);
         _bottomBg = null;
         ObjectUtils.disposeObject(_dailyCountTxt);
         _dailyCountTxt = null;
         ObjectUtils.disposeObject(_pointsShow);
         _pointsShow = null;
         ObjectUtils.disposeObject(_pointsShowTxt);
         _pointsShowTxt = null;
         ObjectUtils.disposeObject(_quickRefreshBtn);
         _quickRefreshBtn = null;
         ObjectUtils.disposeObject(_freeRefreshBtn);
         _freeRefreshBtn = null;
         ObjectUtils.disposeObject(_downTime);
         _downTime = null;
         if(_buyGoodsList)
         {
            _buyGoodsList = null;
         }
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

