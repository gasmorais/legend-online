package view.subshop
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import managers.AirGardenManager;
   import utils.LogicUtils;
   import yishi.manager.ArmyManager;
   
   public class AirGardenShopBedView extends Component
   {
      
      private var _itemBox:SimpleTileList;
      
      private var itemList:Vector.<AirGardenShopBedItem>;
      
      private var pageCount:int = 9;
      
      public function AirGardenShopBedView()
      {
         super();
         initView();
         initListView();
         AirGardenManager.instance.reqAirGardenCampaign(8,ArmyManager.instance.thane.userId);
      }
      
      private function initView() : void
      {
         _itemBox = ComponentFactory.Instance.creatCustomObject("AirGardenShopBedView.SimpleTileList",[3]);
         addChild(_itemBox);
      }
      
      private function initListView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:AirGardenShopBedItem = null;
         itemList = new Vector.<AirGardenShopBedItem>();
         _loc2_ = 0;
         while(_loc2_ < pageCount)
         {
            _loc1_ = new AirGardenShopBedItem();
            _itemBox.addChild(_loc1_);
            itemList.push(_loc1_);
            _loc2_++;
         }
         _itemBox.commitChanges();
      }
      
      public function refreshListView(param1:Array) : void
      {
         var _loc3_:int = 0;
         var _loc2_:AirGardenShopBedItem = null;
         _loc3_ = 0;
         while(_loc3_ < pageCount)
         {
            _loc2_ = itemList[_loc3_];
            _loc2_.data = param1.length > _loc3_ ? param1[_loc3_] : null;
            _loc3_++;
         }
         _itemBox.commitChanges();
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_itemBox);
         _itemBox = null;
         LogicUtils.disposeDisplayCollection(itemList);
         itemList = null;
         super.dispose();
      }
   }
}

