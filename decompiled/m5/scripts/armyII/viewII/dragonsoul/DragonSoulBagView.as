package armyII.viewII.dragonsoul
{
   import bag.events.BagEvent;
   import cell.view.storebag.StoreBagCell;
   import com.pickgliss.geom.IntPoint;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.manager.GoodsManager;
   import yishi.utils.SimpleDictionary;
   import yishi.view.community.BaseItemView;
   
   public class DragonSoulBagView extends Sprite implements Disposeable
   {
      
      private var _list:SimpleTileList;
      
      private var _bagScroll:ScrollPanel;
      
      private var _defaultCount:int;
      
      private var _rowCount:int;
      
      private var _columnCount:int;
      
      private var _data:Array;
      
      private var _itemList:Vector.<BaseItemView>;
      
      private var _itemDic:SimpleDictionary = new SimpleDictionary(true);
      
      private var _inited:Boolean;
      
      public function DragonSoulBagView(param1:int, param2:int)
      {
         super();
         _rowCount = param2;
         _columnCount = param1;
         _defaultCount = _rowCount * _columnCount;
      }
      
      public function defaultView() : void
      {
         if(!_inited)
         {
            initView();
            initEvent();
            initList();
            _inited = true;
         }
         refreshData();
         refreshView();
      }
      
      public function holyDefaultView() : void
      {
         if(!_inited)
         {
            initView();
            initEvent();
            initList();
            _inited = true;
         }
         refreshHolyData();
         refreshView();
      }
      
      private function initView() : void
      {
         _list = ComponentFactory.Instance.creatCustomObject("core.SimpleTileList",[_columnCount]);
         _bagScroll = ComponentFactory.Instance.creatComponentByStylename("BattleGuardBagView.HeroEquipScroll");
         _bagScroll.setView(_list);
         addChild(_bagScroll);
      }
      
      private function uninitView() : void
      {
         var _loc1_:BaseItemView = null;
         while(_itemList && _itemList.length > 0)
         {
            _loc1_ = _itemList.pop();
            _loc1_.dispose();
            _loc1_ = null;
         }
         ObjectUtils.disposeAllChildren(_list);
         _list = null;
         ObjectUtils.disposeObject(_bagScroll);
         _bagScroll = null;
         ObjectUtils.disposeAllChildren(this);
      }
      
      private function initList() : void
      {
         var _loc2_:* = 0;
         var _loc1_:StoreBagCell = null;
         if(_rowCount > 0 && _columnCount > 0)
         {
            _itemList = new Vector.<BaseItemView>();
            _list.beginChanges();
            _loc2_ = 0;
            while(_loc2_ < _defaultCount)
            {
               _loc1_ = ComponentFactory.Instance.creatCustomObject("BattleGuardView.StoreBagCell");
               _loc1_.objectId = 0;
               _loc1_.pos = -1;
               _loc1_.bagType = 1;
               _loc1_.data = null;
               _list.addChild(_loc1_);
               _itemList.push(_loc1_);
               _loc2_++;
            }
            _list.vSpace = -1;
            _list.hSpace = 0;
            _list.commitChanges();
            _bagScroll.invalidateViewport();
         }
      }
      
      private function initEvent() : void
      {
         GoodsManager.instance.addEventListener("UPDATE_BAG",__bagItemUpdateHandler);
         GoodsManager.instance.addEventListener("DELETE_BAG",__bagItemDeleteHandler);
      }
      
      private function removeEvent() : void
      {
         GoodsManager.instance.removeEventListener("UPDATE_BAG",__bagItemUpdateHandler);
         GoodsManager.instance.removeEventListener("DELETE_BAG",__bagItemDeleteHandler);
      }
      
      private function __bagItemDeleteHandler(param1:BagEvent) : void
      {
         var _loc3_:GoodsInfo = param1.info;
         var _loc2_:BaseItemView = _itemDic[_loc3_.pos + "_" + _loc3_.objectId + "_" + _loc3_.bagType];
         if(_loc2_)
         {
            _loc2_.data = null;
         }
      }
      
      private function __bagItemUpdateHandler(param1:BagEvent) : void
      {
         var _loc3_:GoodsInfo = param1.info;
         if(_loc3_.bagType == 0)
         {
            return;
         }
         if(!isCorrectGoods(_loc3_))
         {
            return;
         }
         var _loc2_:BaseItemView = _itemDic[_loc3_.pos + "_" + _loc3_.objectId + "_" + _loc3_.bagType];
         if(_loc2_)
         {
            _loc2_.data = _loc3_;
         }
         else
         {
            addItem(_loc3_);
         }
      }
      
      public function refreshData() : void
      {
         var _loc3_:GoodsInfo = null;
         var _loc2_:int = 0;
         _data = [];
         var _loc1_:Array = GoodsManager.instance.getGeneralBagGoodsBySonType(319);
         _loc2_ = 0;
         while(_loc2_ < _loc1_.length)
         {
            _loc3_ = _loc1_[_loc2_] as GoodsInfo;
            if(isCorrectGoods(_loc3_))
            {
               _data.push(_loc3_);
            }
            _loc2_++;
         }
      }
      
      public function refreshHolyData() : void
      {
         var _loc3_:GoodsInfo = null;
         var _loc2_:int = 0;
         _data = [];
         var _loc1_:Array = GoodsManager.instance.getBagGoodsByTemplateId(PlayerModel.HOLY_DRAGONSOUL_COSTTEMPID);
         _loc2_ = 0;
         while(_loc2_ < _loc1_.length)
         {
            _loc3_ = _loc1_[_loc2_] as GoodsInfo;
            if(isCorrectGoods(_loc3_))
            {
               _data.push(_loc3_);
            }
            _loc2_++;
         }
      }
      
      private function refreshView() : void
      {
         var _loc2_:int = 0;
         var _loc3_:GoodsInfo = null;
         clearGoods();
         refreshBag();
         _loc2_ = 0;
         while(_loc2_ < _data.length)
         {
            _loc3_ = _data[_loc2_] as GoodsInfo;
            _itemList[_loc2_].bagType = _loc3_.bagType;
            _itemList[_loc2_].pos = _loc3_.pos;
            _itemList[_loc2_].data = _loc3_;
            _itemDic.add(_loc3_.pos + "_" + _loc3_.objectId + "_" + _loc3_.bagType,_itemList[_loc2_]);
            _loc2_++;
         }
         _bagScroll.invalidateViewport();
         var _loc1_:IntPoint = new IntPoint(0,0);
         _bagScroll.viewPort.viewPosition = _loc1_;
      }
      
      public function clearGoods() : void
      {
         for each(var _loc1_:BaseItemView in _itemDic)
         {
            _loc1_.data = null;
            _loc1_.pos = -1;
         }
         _itemDic.clear();
      }
      
      private function refreshBag() : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = _columnCount * (int((_data.length + _columnCount - 1) / _columnCount));
         var _loc1_:int = _loc4_ < _defaultCount ? _defaultCount : _loc4_;
         if(_itemList.length < _loc1_)
         {
            addItems(_loc1_ - _itemList.length);
         }
         else if(_itemList.length > _loc1_ && _itemList.length > _defaultCount)
         {
            removeItems(_itemList.length - _loc1_);
         }
      }
      
      private function removeItems(param1:int) : void
      {
         var _loc3_:int = 0;
         var _loc2_:BaseItemView = null;
         _list.beginChanges();
         _loc3_ = 0;
         while(_loc3_ < param1)
         {
            _loc2_ = _itemList.pop();
            _list.removeChild(_loc2_);
            _loc2_.dispose();
            _loc3_++;
         }
         if(_itemList.length <= _defaultCount)
         {
            _list.hSpace = 3;
         }
         else
         {
            _list.hSpace = 0;
         }
         _list.commitChanges();
         _bagScroll.invalidateViewport();
      }
      
      private function addItems(param1:int) : void
      {
         var _loc3_:int = 0;
         var _loc2_:BaseItemView = null;
         _list.beginChanges();
         _loc3_ = 0;
         while(_loc3_ < param1)
         {
            _loc2_ = ComponentFactory.Instance.creatCustomObject("store.StoreBagCell");
            _loc2_.pos = -1;
            _list.addChild(_loc2_);
            _itemList.push(_loc2_);
            _loc3_++;
         }
         if(_itemList.length <= _defaultCount)
         {
            _list.hSpace = 3;
         }
         else
         {
            _list.hSpace = 0;
         }
         _list.commitChanges();
         _bagScroll.invalidateViewport();
      }
      
      private function addItem(param1:GoodsInfo) : void
      {
         var _loc2_:BaseItemView = null;
         if(isCorrectGoods(param1) && _data)
         {
            _loc2_ = findBagEmputyItem(_data.length);
            _loc2_.bagType = param1.bagType;
            _loc2_.pos = param1.pos;
            _loc2_.data = param1;
            _itemDic.add(param1.pos + "_" + param1.objectId + "_" + param1.bagType,_loc2_);
         }
      }
      
      public function findSuperpositionPos(param1:int) : BaseItemView
      {
         if(_itemDic.hasOwnProperty(param1 + "_0_" + 1))
         {
            return _itemDic[param1 + "_0_" + 1] as BaseItemView;
         }
         return null;
      }
      
      public function findBagEmputyItem(param1:int = 0) : BaseItemView
      {
         var _loc2_:BaseItemView = null;
         var _loc4_:* = 0;
         var _loc3_:int = param1;
         _loc3_;
         while(_loc3_ < _itemList.length)
         {
            if(!_itemList[_loc3_].data)
            {
               return _itemList[_loc3_];
            }
            _loc3_++;
         }
         _loc4_ = 0;
         while(_loc4_ < _columnCount)
         {
            _loc2_ = ComponentFactory.Instance.creatCustomObject("store.StoreBagCell");
            _list.addChild(_loc2_);
            _itemList.push(_loc2_);
            _loc4_++;
         }
         _list.hSpace = 0;
         _list.commitChanges();
         _bagScroll.invalidateViewport();
         return findBagEmputyItem(_loc3_);
      }
      
      private function isCorrectGoods(param1:GoodsInfo) : Boolean
      {
         if(param1.templateInfo.SonType == 319 || param1.templateInfo.TemplateId == PlayerModel.HOLY_DRAGONSOUL_COSTTEMPID)
         {
            return true;
         }
         return false;
      }
      
      public function get itemList() : Vector.<BaseItemView>
      {
         return _itemList;
      }
      
      override public function set visible(param1:Boolean) : void
      {
         super.visible = param1;
      }
      
      public function dispose() : void
      {
         removeEvent();
         uninitView();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

