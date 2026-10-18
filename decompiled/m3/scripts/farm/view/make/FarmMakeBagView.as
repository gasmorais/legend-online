package farm.view.make
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.core.Component;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import yishi.datas.goods.GoodsInfo;
   import yishi.manager.NotificationManager;
   
   public class FarmMakeBagView extends Component
   {
      
      private var _list:SimpleTileList;
      
      private var _bagScroll:ScrollPanel;
      
      private var _defaultCount:int;
      
      private var _rowCount:int;
      
      private var _columnCount:int;
      
      private var _itemDic:Dictionary;
      
      private var _itemArr:Array;
      
      private var _itemList:Vector.<FarmMakeBagCell>;
      
      private var _data:Array;
      
      private var _currentGoods:GoodsInfo;
      
      private var _currentIndex:int = 0;
      
      public function FarmMakeBagView()
      {
         super();
         _rowCount = 4;
         _columnCount = 6;
         _defaultCount = _rowCount * _columnCount;
         initView();
         addNullItems(_defaultCount);
      }
      
      public function get currentGoods() : GoodsInfo
      {
         _currentGoods = _data[_currentIndex];
         return _currentGoods;
      }
      
      public function get data() : Array
      {
         return _data;
      }
      
      public function updateData(param1:Array, param2:Boolean) : void
      {
         _data = param1;
         if(param2)
         {
            currentIndex = 0;
         }
         else
         {
            currentIndex = _currentIndex;
         }
         updateView();
         _bagScroll.scrollToTop();
      }
      
      private function set currentIndex(param1:int) : void
      {
         _currentIndex = param1;
         onItemClick();
         NotificationManager.instance.sendNotification("FARM_MAKE_SELECTED_CHANGE",_currentIndex);
      }
      
      private function initView() : void
      {
         _list = ComponentFactory.Instance.creatCustomObject("farm.make.composeBagSimpleTileList",[_columnCount]);
         _bagScroll = ComponentFactory.Instance.creatComponentByStylename("Farm.makeCompose.panel");
         _itemList = new Vector.<FarmMakeBagCell>();
         _itemDic = new Dictionary();
         _bagScroll.setView(_list);
         addChild(_bagScroll);
      }
      
      private function addNullItems(param1:int) : void
      {
         var _loc4_:int = 0;
         var _loc3_:FarmMakeBagCell = null;
         if(param1 <= 0)
         {
            return;
         }
         _list.beginChanges();
         var _loc2_:int = int(_itemList.length);
         _loc4_ = _loc2_;
         while(_loc4_ < param1 + _loc2_)
         {
            _loc3_ = ComponentFactory.Instance.creatCustomObject("farm.make.FarmMakeComposeGoodItem");
            _loc3_.addEventListener("click",onItemClick);
            _loc3_.pos = -1;
            _loc3_.data = null;
            _list.addChild(_loc3_);
            _itemList.push(_loc3_);
            _loc4_++;
         }
         _list.commitChanges();
         _bagScroll.invalidateViewport();
      }
      
      private function onItemClick(param1:MouseEvent = null) : void
      {
         var _loc3_:FarmMakeBagCell = null;
         var _loc4_:int = 0;
         for(var _loc2_:String in _itemDic)
         {
            _itemDic[_loc2_].selected = false;
         }
         if(param1 == null)
         {
            _itemList[_currentIndex].selected = true;
         }
         else
         {
            _loc3_ = param1.currentTarget as FarmMakeBagCell;
            if(_loc3_.data == null)
            {
               return;
            }
            _itemList[currentIndex = _data.indexOf(_loc3_.data)].selected = true;
         }
      }
      
      private function updateView() : void
      {
         var _loc1_:int = 0;
         for(var _loc2_:String in _itemDic)
         {
            _itemDic[_loc2_].data = null;
            delete _itemDic[_loc2_];
         }
         _loc1_ = 0;
         while(_loc1_ < data.length)
         {
            if(_itemList.length <= _loc1_)
            {
               addNullItems(1);
            }
            _itemList[_loc1_].data = data[_loc1_];
            _itemDic[data[_loc1_].templateId] = _itemList[_loc1_];
            _loc1_++;
         }
      }
   }
}

