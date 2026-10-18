package bag.view
{
   import cell.view.playerbag.PlayerBagCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.manager.TempleteManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.utils.SimpleDictionary;
   import yishi.view.community.BaseItemView;
   
   public class StoreBagStateView extends RentalBagStateView
   {
      
      protected var _list:SimpleTileList;
      
      protected var _itemCount:int;
      
      protected var _itemList:Vector.<BaseItemView>;
      
      protected var _itemDic:SimpleDictionary;
      
      protected var bagType:int = 0;
      
      public function StoreBagStateView()
      {
         super();
      }
      
      override protected function initView() : void
      {
         if(_playerInfo.stoneBagCount <= 0)
         {
            super.initView();
            ObjectUtils.disposeObject(_continueBtn);
            _continueBtn = null;
            ObjectUtils.disposeObject(_overdueTip);
            _overdueTip = null;
            ObjectUtils.disposeObject(_overdueTxt);
            _overdueTxt = null;
         }
      }
      
      protected function creatItem(param1:Boolean = false, param2:int = -1) : BaseItemView
      {
         var _loc3_:PlayerBagCell = ComponentFactory.Instance.creatCustomObject("army.HeroBagItemView");
         _loc3_.bagType = bagType;
         _loc3_.objectId = 0;
         _loc3_.lock = true;
         return _loc3_;
      }
      
      override protected function showTips(param1:int) : void
      {
         var _loc2_:* = null;
         var _loc5_:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName("Buy_StoneBag");
         var _loc6_:String = LanguageMgr.GetTranslation("bag.view.StoreBagStateView.showTips",_loc5_.ConfigValue);
         var _loc3_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc4_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc7_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc8_:String = _loc6_;
         SimpleAlertHelper.instance.data = [payCallBack];
         SimpleAlertHelper.instance.popAlerFrame(_loc7_,_loc8_,_loc3_,_loc4_,true,false,false,2,"USEBINDPOINT_ALERT",0,"",null,"SimpleAlert",1000);
      }
      
      private function payCallBack(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            SocketSendManager.instance.buyStoreBag(param2);
         }
      }
      
      override public function refresh() : void
      {
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
   }
}

