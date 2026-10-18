package theseus.war.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import managers.TheseussoulManager;
   import mvc.module.theseus.TheseusWarsoulItemInfo;
   import theseus.war.item.TheseusInsfBagCell;
   
   public class TheseusWarsoulBagView extends Sprite
   {
      
      protected var _listPanel:SimpleTileList;
      
      protected var _itemList:Vector.<TheseusInsfBagCell>;
      
      protected var _column:int;
      
      protected var _row:int;
      
      protected var _data:Array;
      
      private var _mainType:int;
      
      private var _funtype:int;
      
      public function TheseusWarsoulBagView(param1:int = 7, param2:int = 7, param3:int = 0)
      {
         super();
         _column = param1;
         _row = param2;
         _funtype = param3;
         initView();
         TheseussoulManager.Instance.addEventListener("EVENT_WAR_EQUIP",updateView);
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
         var _loc1_:TheseusInsfBagCell = null;
         var _loc2_:* = 0;
         _listPanel = ComponentFactory.Instance.creatCustomObject("core.SimpleTileList",[_column]);
         var _loc3_:int = _column * _row;
         _itemList = new Vector.<TheseusInsfBagCell>();
         addChild(_listPanel);
         _listPanel.beginChanges();
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("theseus.war.insfBagItemView");
            _loc1_.funType = _funtype;
            _listPanel.addChild(_loc1_);
            _itemList.push(_loc1_);
            _loc2_++;
         }
         _listPanel.commitChanges();
         _listPanel.vSpace = -6;
         _listPanel.hSpace = -7;
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
         _data = TheseussoulManager.Instance.warsoulModel.getListByMainType(_mainType,_funtype == 1);
      }
      
      public function cellUpdateView(param1:int) : void
      {
         var _loc2_:TheseusWarsoulItemInfo = TheseussoulManager.Instance.warsoulModel.getItemInfo(param1);
         if(_loc2_.warTempInfo.MainType == _mainType)
         {
            updateView();
         }
      }
      
      protected function refreshView() : void
      {
         var _loc1_:TheseusInsfBagCell = null;
         var _loc3_:int = 0;
         var _loc2_:int = int(_itemList.length);
         var _loc4_:int = int(_data ? _data.length : 0);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = _itemList[_loc3_];
            if(_loc3_ < _loc4_)
            {
               _loc1_.data = _data[_loc3_];
            }
            else
            {
               _loc1_.data = null;
            }
            _loc3_++;
         }
      }
      
      public function dispose() : void
      {
         TheseussoulManager.Instance.removeEventListener("EVENT_WAR_EQUIP",updateView);
         ObjectUtils.disposeObject(_listPanel);
         _listPanel = null;
         for each(var _loc1_:TheseusInsfBagCell in _itemList)
         {
            _loc1_.dispose();
         }
         _itemList = null;
         _data = null;
      }
   }
}

