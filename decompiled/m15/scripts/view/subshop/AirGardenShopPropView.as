package view.subshop
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import utils.LogicUtils;
   import view.GoodsItem;
   
   public class AirGardenShopPropView extends Component
   {
      
      private var _itemBox:SimpleTileList;
      
      private var itemList:Vector.<GoodsItem>;
      
      private var pageCount:int = 9;
      
      public function AirGardenShopPropView()
      {
         super();
         initView();
         initListView();
      }
      
      private function initView() : void
      {
         _itemBox = ComponentFactory.Instance.creatCustomObject("AirGardenShopPropView.SimpleTileList",[3]);
         addChild(_itemBox);
      }
      
      private function initListView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:GoodsItem = null;
         itemList = new Vector.<GoodsItem>();
         _loc2_ = 0;
         while(_loc2_ < pageCount)
         {
            _loc1_ = new GoodsItem();
            _itemBox.addChild(_loc1_);
            itemList.push(_loc1_);
            _loc2_++;
         }
         _itemBox.commitChanges();
      }
      
      public function refreshListView(param1:Array) : void
      {
         var _loc3_:int = 0;
         var _loc2_:GoodsItem = null;
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

