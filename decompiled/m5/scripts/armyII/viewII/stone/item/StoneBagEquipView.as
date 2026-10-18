package armyII.viewII.stone.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import yishi.datas.goods.GoodsInfo;
   import yishi.manager.GoodsManager;
   import yishi.utils.SimpleDictionary;
   import yishi.view.community.BaseItemView;
   
   public class StoneBagEquipView extends Sprite
   {
      
      private var _xing:int = -1;
      
      private var _profie:int = 0;
      
      private var _isComit:Boolean;
      
      protected var _listPanel:SimpleTileList;
      
      protected var _itemList:Vector.<BaseItemView>;
      
      protected var _itemDic:SimpleDictionary;
      
      protected var _data:SimpleDictionary;
      
      protected var _curPage:int = 1;
      
      protected var _pageCount:int = 1;
      
      protected var _column:int;
      
      protected var _itemCount:int;
      
      protected var bagType:int = 0;
      
      public function StoneBagEquipView(param1:int = 7, param2:int = 7, param3:int = 1)
      {
         super();
         _pageCount = param3;
         _column = param1;
         init(param1,param2);
         updateView();
      }
      
      public function updateView() : void
      {
         if(_xing == -1)
         {
            return;
         }
         refreshData();
         refreshView();
      }
      
      protected function creatItem(param1:Boolean = false, param2:int = -1) : BaseItemView
      {
         var _loc3_:BaseItemView = ComponentFactory.Instance.creatCustomObject(itemClassName);
         _loc3_.objectId = 0;
         return _loc3_;
      }
      
      protected function get listStylename() : String
      {
         return "army.stone.Bag.SimpleTileList";
      }
      
      protected function get itemClassName() : String
      {
         return "army.stone.equipbag.BagItemView";
      }
      
      protected function refreshView() : void
      {
         var _loc4_:int = 0;
         var _loc1_:BaseItemView = null;
         var _loc3_:int = 0;
         var _loc6_:Array = _data.getList();
         var _loc7_:int = (_curPage - 1) * _itemCount;
         var _loc5_:Array = [];
         _loc4_ = _loc7_;
         while(_loc4_ < _loc7_ + _itemCount)
         {
            _loc5_.push(_loc6_[_loc4_]);
            _loc4_++;
         }
         var _loc2_:int = int(_itemList.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = _itemList[_loc3_];
            _loc1_.data = _loc5_[_loc3_];
            _loc3_++;
         }
      }
      
      public function refreshData() : void
      {
         _data = GoodsManager.instance.getRuneBagList(_xing,_profie);
      }
      
      public function set openNum(param1:int) : void
      {
         var _loc2_:BaseItemView = null;
         var _loc4_:int = 0;
         var _loc6_:int = 0;
         var _loc5_:Boolean = false;
         var _loc3_:int = int(_itemList.length);
         _loc6_ = 0;
         while(_loc6_ < _loc3_)
         {
            _loc2_ = _itemList[_loc6_];
            _loc4_ = (_curPage - 1) * _itemCount + _loc6_;
            _loc5_ = param1 > _loc4_;
            (_loc2_ as StoneBagCell).isOpen = _loc5_;
            _loc6_++;
         }
      }
      
      public function updateItem(param1:GoodsInfo, param2:String) : void
      {
         updateView();
      }
      
      public function beginCommit() : void
      {
         _isComit = false;
      }
      
      public function endCommit() : void
      {
         if(_isComit)
         {
            _isComit = false;
            updateView();
         }
      }
      
      public function set xing(param1:int) : void
      {
         if(_xing == param1)
         {
            return;
         }
         _xing = param1;
         _isComit = true;
      }
      
      public function set profie(param1:int) : void
      {
         if(_profie == param1)
         {
            return;
         }
         _profie = param1;
         _isComit = true;
      }
      
      protected function init(param1:int, param2:int) : void
      {
         var _loc4_:* = 0;
         var _loc3_:BaseItemView = null;
         _listPanel = ComponentFactory.Instance.creatCustomObject(listStylename,[param1]);
         _itemCount = param1 * param2;
         _itemList = new Vector.<BaseItemView>();
         _itemDic = new SimpleDictionary(true);
         addChild(_listPanel);
         _listPanel.beginChanges();
         _loc4_ = 0;
         while(_loc4_ < _itemCount)
         {
            _loc3_ = creatItem(false,_loc4_);
            _listPanel.addChild(_loc3_);
            _itemList.push(_loc3_);
            _loc4_++;
         }
         _listPanel.commitChanges();
      }
      
      protected function clearBagItemData() : void
      {
         var _loc3_:int = 0;
         var _loc1_:BaseItemView = null;
         var _loc4_:int = (curPage - 1) * _itemCount;
         var _loc2_:int = int(_itemList.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = _itemList[_loc3_] as BaseItemView;
            _loc1_.data = null;
            _loc1_.pos = _loc3_ + _loc4_;
            _itemDic.add(_loc1_.pos + "_0_" + bagType,_loc1_);
            _loc3_++;
         }
      }
      
      public function gotoPage(param1:int) : void
      {
         if(_curPage == param1)
         {
            return;
         }
         _curPage = param1;
         refreshView();
      }
      
      public function get curPage() : int
      {
         return _curPage;
      }
      
      public function get pageCount() : int
      {
         return _pageCount;
      }
      
      public function dispose() : void
      {
         if(_listPanel)
         {
            ObjectUtils.disposeObject(_listPanel);
         }
         _listPanel = null;
         for each(var _loc1_:BaseItemView in _itemList)
         {
            _loc1_.dispose();
         }
         _itemList = null;
         _itemDic = null;
         _data = null;
      }
   }
}

