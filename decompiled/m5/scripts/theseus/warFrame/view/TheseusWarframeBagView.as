package theseus.warFrame.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import managers.TheseussoulManager;
   import mvc.module.theseus.WarFrameItemInfo;
   import theseus.item.TheseusBagCell;
   
   public class TheseusWarframeBagView extends Sprite
   {
      
      protected var _listPanel:SimpleTileList;
      
      protected var _itemList:Vector.<TheseusBagCell>;
      
      protected var _column:int;
      
      protected var _row:int;
      
      protected var _data:Array;
      
      private var _mainType:int;
      
      private var _funtype:int;
      
      public function TheseusWarframeBagView(param1:int = 7, param2:int = 7, param3:int = 0)
      {
         super();
         _column = param1;
         _row = param2;
         _funtype = param3;
         initView();
         updateView();
      }
      
      public function get mainType() : int
      {
         return _mainType;
      }
      
      public function set mainType(param1:int) : void
      {
         _mainType = param1;
         updateView();
      }
      
      private function initView() : void
      {
         var _loc1_:TheseusBagCell = null;
         var _loc2_:* = 0;
         _listPanel = ComponentFactory.Instance.creatCustomObject("core.SimpleTileList",[_column]);
         var _loc3_:int = _column * _row;
         _itemList = new Vector.<TheseusBagCell>();
         addChild(_listPanel);
         _listPanel.beginChanges();
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("theseus.BagItemView");
            _listPanel.addChild(_loc1_);
            _itemList.push(_loc1_);
            _loc2_++;
         }
         _listPanel.commitChanges();
         _listPanel.vSpace = 1;
         _listPanel.hSpace = -5;
      }
      
      public function updateHSpace(param1:int) : void
      {
         _listPanel.hSpace = param1;
      }
      
      public function updateVSpace(param1:int) : void
      {
         _listPanel.vSpace = param1;
      }
      
      public function updateView(param1:Object = null) : void
      {
         refreshData();
         refreshView();
      }
      
      private function refreshData() : void
      {
         _data = TheseussoulManager.Instance.model.itemSort;
      }
      
      protected function refreshView() : void
      {
         var _loc1_:TheseusBagCell = null;
         var _loc4_:int = 0;
         var _loc3_:int = int(_itemList.length);
         var _loc2_:Array = [];
         for each(var _loc5_:WarFrameItemInfo in _data)
         {
            if(_loc5_.warTempInfo.SonType == 720)
            {
               _loc2_.push(_loc5_);
            }
         }
         var _loc6_:int = int(_data ? _data.length : 0);
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc1_ = _itemList[_loc4_];
            if(_loc4_ < _loc6_)
            {
               _loc1_.data = _loc2_[_loc4_];
            }
            else
            {
               _loc1_.data = null;
            }
            _loc4_++;
         }
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_listPanel);
         _listPanel = null;
         for each(var _loc1_:TheseusBagCell in _itemList)
         {
            _loc1_.dispose();
         }
         _itemList = null;
         _data = null;
      }
   }
}

