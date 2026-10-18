package buildings.seminary.view
{
   import buildings.seminary.event.TechnologyItemEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import mvc.module.buildings.BuildInfo;
   import yishi.datas.templates.BuildingTempInfo;
   import yishi.manager.BuildingManager;
   import yishi.utils.SimpleDictionary;
   
   public class MilitaryTechnologyList extends InternalTechnologyList implements Disposeable
   {
      
      private var _activeList:SimpleDictionary;
      
      private var _itemList:Array;
      
      private var _length:int;
      
      private var _row:int;
      
      private var _column:int;
      
      private var _seminaryFrameBottomView:SeminaryFrameBottomView;
      
      public function MilitaryTechnologyList()
      {
         super();
      }
      
      override protected function init() : void
      {
         var _loc5_:int = 0;
         var _loc2_:TechnologyItem = null;
         var _loc4_:int = 0;
         var _loc3_:BuildInfo = null;
         var _loc6_:BuildingTempInfo = null;
         _itemList = [];
         _loc5_ = 0;
         while(_loc5_ < 12)
         {
            _loc2_ = ComponentFactory.Instance.creatCustomObject("seminary.TechnologyItem");
            setItemPos(_loc2_);
            _loc2_.addEventListener(TechnologyItemEvent.TECHNOLOGY_ITEM_ROLL_OVER,_itemRollOverHandler);
            _loc2_.addEventListener(TechnologyItemEvent.TECHNOLOGY_ITEM_ROLL_OUT,_itemRollOutHandler);
            _loc2_.data = null;
            _loc2_.tipData = null;
            itemGroup.addSelectItem(_loc2_);
            _itemList.push(_loc2_);
            addChild(_loc2_);
            _loc5_++;
         }
         _activeList = BuildingManager.instance.model.buildingListByID;
         var _loc1_:Array = _activeList.getList();
         _loc1_.sortOn("sonType");
         _loc4_ = 0;
         while(_loc4_ < _loc1_.length)
         {
            _loc3_ = _loc1_[_loc4_] as BuildInfo;
            _loc6_ = _loc3_.templeteInfo;
            if(_loc6_.MasterType == 13 || _loc6_.MasterType == 14)
            {
               addMilitaryTecItem(_loc3_);
            }
            _loc4_++;
         }
         _loc1_ = null;
      }
      
      public function addMilitaryTecItem(param1:BuildInfo) : void
      {
         if(!_firstBuild)
         {
            _firstBuild = param1;
         }
         for each(var _loc2_:TechnologyItem in _itemList)
         {
            if(!_loc2_.data)
            {
               _loc2_.data = param1;
               _loc2_.tipData = param1;
               return;
            }
         }
         var _loc3_:TechnologyItem = ComponentFactory.Instance.creatCustomObject("seminary.TechnologyItem");
         setItemPos(_loc3_);
         _loc3_.data = param1;
         _loc3_.tipData = param1;
         itemGroup.addSelectItem(_loc3_);
         _itemList.push(_loc3_);
         addChild(_loc3_);
      }
      
      private function setItemPos(param1:TechnologyItem) : void
      {
         _row = _length / 4;
         _column = _length % 4;
         param1.x = _column * 181 + 8;
         param1.y = _row * 90 + 8;
         _length = _length + 1;
      }
      
      public function set seminaryFrameBottomView(param1:SeminaryFrameBottomView) : void
      {
         _seminaryFrameBottomView = param1;
      }
      
      private function _itemRollOverHandler(param1:TechnologyItemEvent) : void
      {
         if(_seminaryFrameBottomView)
         {
            _seminaryFrameBottomView.changeRed();
         }
      }
      
      private function _itemRollOutHandler(param1:TechnologyItemEvent) : void
      {
         if(_seminaryFrameBottomView)
         {
            _seminaryFrameBottomView.revertColor();
         }
      }
      
      public function getTechItemByIndex(param1:int) : TechnologyItem
      {
         return _itemList[param1];
      }
      
      override public function dispose() : void
      {
         var _loc1_:TechnologyItem = null;
         var _loc3_:int = 0;
         if(!_itemList)
         {
            return;
         }
         var _loc2_:int = int(_itemList.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = _itemList[_loc3_] as TechnologyItem;
            if(_loc1_.hasEventListener(TechnologyItemEvent.TECHNOLOGY_ITEM_ROLL_OVER))
            {
               _loc1_.removeEventListener(TechnologyItemEvent.TECHNOLOGY_ITEM_ROLL_OVER,_itemRollOverHandler);
               _loc1_.removeEventListener(TechnologyItemEvent.TECHNOLOGY_ITEM_ROLL_OUT,_itemRollOutHandler);
            }
            _loc3_++;
         }
         _itemList = null;
         super.dispose();
      }
   }
}

