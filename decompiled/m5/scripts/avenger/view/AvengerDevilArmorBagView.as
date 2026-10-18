package avenger.view
{
   import avenger.item.AvengerDevilArmorItemCell;
   import com.pickgliss.geom.IntPoint;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import mvc.module.avenger.AvengerModel;
   import utils.LogicUtils;
   import yishi.manager.AvengerManager;
   
   public class AvengerDevilArmorBagView extends Component
   {
      
      private static const ROW_NUM:int = 7;
      
      private static const COL_NUM:int = 6;
      
      private static const DEFAULT_COUNT:int = 42;
      
      private var _bagPanel:ScrollPanel;
      
      private var _bagList:SimpleTileList;
      
      private var itemList:Vector.<AvengerDevilArmorItemCell>;
      
      private var data:Array = [];
      
      public function AvengerDevilArmorBagView()
      {
         super();
         initView();
         initBagView();
         refreshView();
      }
      
      private function initView() : void
      {
         _bagList = ComponentFactory.Instance.creatCustomObject("AvengerDevilArmorBagView.bagList",[6]);
         _bagPanel = ComponentFactory.Instance.creatComponentByStylename("AvengerDevilArmorBagView.bagPanel");
         addChild(_bagPanel);
         _bagPanel.setView(_bagList);
      }
      
      private function initBagView() : void
      {
         var _loc2_:* = 0;
         var _loc1_:AvengerDevilArmorItemCell = null;
         itemList = new Vector.<AvengerDevilArmorItemCell>();
         _bagList.beginChanges();
         _loc2_ = 0;
         while(_loc2_ < 42)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("AvengerDevilArmorBagView.bagCell",[1]);
            _bagList.addChild(_loc1_);
            itemList.push(_loc1_);
            _loc2_++;
         }
         _bagList.commitChanges();
         _bagPanel.invalidateViewport();
      }
      
      public function refreshView() : void
      {
         var _loc3_:int = 0;
         var _loc1_:AvengerDevilArmorItemCell = null;
         data = model.armorBagDic.getList();
         data.sortOn("templateId",16);
         refreshBagCountView();
         _loc3_ = 0;
         while(_loc3_ < itemList.length)
         {
            _loc1_ = itemList[_loc3_];
            if(data.length <= _loc3_)
            {
               itemList[_loc3_].data = null;
            }
            else
            {
               itemList[_loc3_].data = data[_loc3_];
            }
            _loc3_++;
         }
         _bagPanel.invalidateViewport();
         var _loc2_:IntPoint = new IntPoint(0,0);
         _bagPanel.viewPort.viewPosition = _loc2_;
      }
      
      private function refreshBagCountView() : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 6 * (int((data.length + 6 - 1) / 6));
         var _loc1_:int = _loc4_ < 42 ? 42 : _loc4_;
         if(itemList.length < _loc1_)
         {
            addItems(_loc1_ - itemList.length);
         }
         else if(itemList.length > _loc1_ && itemList.length > 42)
         {
            removeItems(itemList.length - _loc1_);
         }
      }
      
      private function removeItems(param1:int) : void
      {
         var _loc3_:int = 0;
         var _loc2_:AvengerDevilArmorItemCell = null;
         _bagList.beginChanges();
         _loc3_ = 0;
         while(_loc3_ < param1)
         {
            _loc2_ = itemList.pop();
            _bagList.removeChild(_loc2_);
            _loc2_.dispose();
            _loc3_++;
         }
         _bagList.commitChanges();
         _bagPanel.invalidateViewport();
      }
      
      private function addItems(param1:int) : void
      {
         var _loc3_:int = 0;
         var _loc2_:AvengerDevilArmorItemCell = null;
         _bagList.beginChanges();
         _loc3_ = 0;
         while(_loc3_ < param1)
         {
            _loc2_ = ComponentFactory.Instance.creatCustomObject("AvengerDevilArmorBagView.bagCell",[1]);
            _bagList.addChild(_loc2_);
            itemList.push(_loc2_);
            _loc3_++;
         }
         _bagList.commitChanges();
         _bagPanel.invalidateViewport();
      }
      
      private function get model() : AvengerModel
      {
         return AvengerManager.instance.model;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_bagPanel);
         _bagPanel = null;
         ObjectUtils.disposeObject(_bagList);
         _bagList = null;
         LogicUtils.disposeDisplayCollection(itemList);
         itemList = null;
         super.dispose();
      }
   }
}

