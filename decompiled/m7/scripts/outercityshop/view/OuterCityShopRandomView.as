package outercityshop.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.OuterCityShopEvent;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.getTimer;
   import manager.LanguageMgr;
   import managers.OuterCityShopManager;
   import mvc.module.outercityshop.OuterCityShopItemInfo;
   import mvc.module.outercityshop.OuterCityShopModel;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.SharedManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.frame.TodayNotAlertFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class OuterCityShopRandomView extends Sprite implements Disposeable
   {
      
      private static var needAlert:Boolean = true;
      
      private var _buyGoodsList:Vector.<OuterCityShopGoodsItem>;
      
      private var _quickRefreshBtn:IconButton;
      
      private var _selectedView:OuterCityShopSelectedView;
      
      private var _lastClickTime:int = 0;
      
      public function OuterCityShopRandomView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _buyGoodsList = new Vector.<OuterCityShopGoodsItem>();
         createGoodsList();
         _selectedView = ComponentFactory.Instance.creatCustomObject("outercityshop.view.selectedView");
         _quickRefreshBtn = ComponentFactory.Instance.creatComponentByStylename("outercityshop.QuickRefreshBtn");
         addChild(_selectedView);
         addChild(_quickRefreshBtn);
         updateGoodsListData();
      }
      
      private function addEvent() : void
      {
         model.addEventListener("FRESH_VIEW",__freshViewHandler);
         _quickRefreshBtn.addEventListener("click",__quickFreshHandler);
      }
      
      public function setIsFreeFreshAble(param1:Boolean) : void
      {
      }
      
      private function __freshViewHandler(param1:OuterCityShopEvent) : void
      {
         updateGoodsListData();
      }
      
      private function __freeFreshHandler(param1:MouseEvent) : void
      {
         setIsFreeFreshAble(false);
         freshGoods();
      }
      
      private function __quickFreshHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc4_:int = getTimer();
         if(_loc4_ - _lastClickTime < 400)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("activity.view.ActivityItem.command01"));
            return;
         }
         _lastClickTime = _loc4_;
         SoundManager.instance.play("022");
         if(!model.goodsList)
         {
            return;
         }
         model.payType = _selectedView.payType;
         if(checkGoods)
         {
            SimpleAlertHelper.instance.data = [checkGoodsHandlerBack];
            _loc2_ = LanguageMgr.GetTranslation("public.confirm");
            _loc3_ = LanguageMgr.GetTranslation("public.cancel");
            _loc5_ = LanguageMgr.GetTranslation("public.prompt");
            _loc6_ = LanguageMgr.GetTranslation("outercityshop.QuickRefreshGoodsTip");
            SimpleAlertHelper.instance.popAlerFrame(_loc5_,_loc6_,_loc2_,_loc3_,true,false,false,2,"SIMPLE_ALERT");
            return;
         }
         checkFresh();
      }
      
      private function get checkGoods() : Boolean
      {
         for each(var _loc1_:OuterCityShopItemInfo in model.goodsList)
         {
            if(!_loc1_.isBuy && _loc1_.itemTemInfo.IsDrop == 1)
            {
               return true;
            }
         }
         return false;
      }
      
      private function checkGoodsHandlerBack(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            checkFresh();
         }
      }
      
      private function checkFresh() : void
      {
         if(model.payType == 1)
         {
            if(model.refreshNeedPoint > playerModel.playerInfo.point + playerModel.playerInfo.giftToken)
            {
               RechargeAlertMannager.show();
               return;
            }
            alertTodayFrame();
         }
         else
         {
            if(model.refreshNeedPoint > model.consumePoints)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("outercityshop.QuickRefreshScoreTip"));
               return;
            }
            freshGoods();
         }
      }
      
      private function alertTodayFrame() : void
      {
         var _loc3_:TodayNotAlertFrame = null;
         var _loc2_:String = null;
         var _loc1_:String = null;
         if(needAlert)
         {
            _loc3_ = ComponentFactory.Instance.creatComponentByStylename("worldboss.RiverNotAlert3");
            _loc2_ = LanguageMgr.GetTranslation("outercityshop.QuickRefreshPointTip",model.refreshNeedPoint);
            _loc1_ = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
            _loc3_.show(_loc2_,_loc1_,__todayNotAlertFresh,null,"center",2,true);
         }
         else
         {
            freshGoods(SharedManager.instance.outercityshopFreshUseBind);
         }
      }
      
      private function __todayNotAlertFresh(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            needAlert = false;
            SharedManager.instance.outercityshopFreshUseBind = param2;
            SharedManager.instance.saveOutercityshopFreshAlert();
         }
         freshGoods(param2);
      }
      
      private function freshGoods(param1:Boolean = true) : void
      {
         OuterCityShopManager.instance.sendAction(3,model.payType,param1 ? 2 : 1);
         setIsFreeFreshAble(false);
      }
      
      private function removeEvent() : void
      {
         model.removeEventListener("FRESH_VIEW",__freshViewHandler);
         _quickRefreshBtn.removeEventListener("click",__quickFreshHandler);
      }
      
      private function createGoodsList() : void
      {
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc1_:OuterCityShopGoodsItem = null;
         _loc3_ = 0;
         while(_loc3_ < 6)
         {
            _loc1_ = new OuterCityShopGoodsItem();
            _loc4_ = _loc3_ / 2;
            _loc2_ = _loc3_ % 2;
            _loc1_.x = 3 + _loc2_ * (_loc1_.width - 3);
            _loc1_.y = 3 + _loc4_ * 98;
            _buyGoodsList.push(_loc1_);
            addChild(_loc1_);
            _loc3_++;
         }
      }
      
      private function updateGoodsListData() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _buyGoodsList.length)
         {
            if(model.goodsList && model.goodsList[_loc1_])
            {
               _buyGoodsList[_loc1_].data = model.goodsList[_loc1_] as OuterCityShopItemInfo;
            }
            else
            {
               _buyGoodsList[_loc1_].data = null;
            }
            _loc1_++;
         }
      }
      
      private function get model() : OuterCityShopModel
      {
         return OuterCityShopManager.instance.model;
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_buyGoodsList)
         {
            _buyGoodsList = null;
         }
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

