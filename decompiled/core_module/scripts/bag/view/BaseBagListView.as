package bag.view
{
   import bag.events.BagEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.utils.Dictionary;
   import yishi.datas.goods.GoodsInfo;
   import yishi.manager.GoodsManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.SimpleDictionary;
   import yishi.view.community.BaseItemView;
   
   public class BaseBagListView extends Sprite implements Disposeable
   {
      
      protected var _itemCount:int;
      
      protected var _list:SimpleTileList;
      
      protected var _itemList:Vector.<BaseItemView>;
      
      protected var _itemDic:SimpleDictionary;
      
      protected var _data:SimpleDictionary;
      
      protected var bagType:int = 0;
      
      protected var _curPage:int = 1;
      
      protected var _pageCount:int = 1;
      
      protected var _column:int;
      
      protected var sortByType:int = 0;
      
      protected var sort_type:Array = [101,102,103,104,105,103,106,107,108];
      
      public function BaseBagListView(param1:int = 7, param2:int = 7, param3:int = 1)
      {
         super();
         _pageCount = param3;
         _column = param1;
         init(param1,param2);
         initEvent();
         defaultView();
      }
      
      protected function init(param1:int, param2:int) : void
      {
         var _loc4_:* = 0;
         var _loc3_:BaseItemView = null;
         _list = ComponentFactory.Instance.creatCustomObject("core.SimpleTileList",[param1]);
         _itemCount = param1 * param2;
         _itemList = new Vector.<BaseItemView>();
         _itemDic = new SimpleDictionary(true);
         addChild(_list);
         _list.beginChanges();
         _loc4_ = 0;
         while(_loc4_ < _itemCount)
         {
            _loc3_ = creatItem(false,_loc4_);
            _list.addChild(_loc3_);
            _itemList.push(_loc3_);
            _loc4_++;
         }
         _list.commitChanges();
      }
      
      protected function creatItem(param1:Boolean = false, param2:int = -1) : BaseItemView
      {
         var _loc3_:BaseItemView = ComponentFactory.Instance.creatCustomObject("bag.BaseItemView");
         _loc3_.fashionStyle = "asset.core.fashionLevelNormal,asset.core.fashionLevelSpecial";
         _loc3_.fashionIconY = 22;
         _loc3_.fashionTextY = 26;
         _loc3_.bagType = bagType;
         _loc3_.objectId = 0;
         return _loc3_;
      }
      
      protected function uninit() : void
      {
         if(_list)
         {
            ObjectUtils.disposeObject(_list);
         }
         _list = null;
         for each(var _loc1_:BaseItemView in _itemList)
         {
            _loc1_.dispose();
         }
         _itemList = null;
         _itemDic = null;
         _data = null;
      }
      
      protected function initEvent() : void
      {
         GoodsManager.instance.addEventListener("UPDATE_BAG",__bagItemUpdateHandler);
         GoodsManager.instance.addEventListener("DELETE_BAG",__bagItemDeleteHandler);
      }
      
      protected function removeEvent() : void
      {
         GoodsManager.instance.removeEventListener("UPDATE_BAG",__bagItemUpdateHandler);
         GoodsManager.instance.removeEventListener("DELETE_BAG",__bagItemDeleteHandler);
      }
      
      protected function __bagItemUpdateHandler(param1:BagEvent) : void
      {
         var _loc3_:GoodsInfo = param1.info;
         var _loc2_:BaseItemView = _itemDic[_loc3_.pos + "_" + _loc3_.objectId + "_" + _loc3_.bagType];
         if(_loc2_)
         {
            _loc2_.data = _loc3_;
            stopEffect();
         }
      }
      
      protected function __bagItemDeleteHandler(param1:BagEvent) : void
      {
         var _loc3_:GoodsInfo = param1.info;
         var _loc2_:BaseItemView = _itemDic[_loc3_.pos + "_" + _loc3_.objectId + "_" + _loc3_.bagType];
         if(_loc2_)
         {
            _loc2_.data = null;
            stopEffect();
         }
      }
      
      protected function stopEffect() : void
      {
      }
      
      protected function defaultView() : void
      {
         stopEffect();
         refreshData();
         refreshSortData();
         refreshPage();
         refreshView();
      }
      
      public function refreshData() : void
      {
         _data = GoodsManager.instance.getGeneralBagList();
      }
      
      protected function refreshSortData() : void
      {
      }
      
      public function refreshPage() : void
      {
         if(_curPage > _pageCount)
         {
            _curPage = _pageCount;
         }
      }
      
      protected function refreshView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:BaseItemView = null;
         var _loc3_:Date = null;
         _itemDic.clear();
         if(_curPage > _pageCount)
         {
            _curPage %= _pageCount;
         }
         if(_curPage == 0)
         {
            _curPage = 1;
         }
         clearBagItemData();
         for each(var _loc4_:GoodsInfo in _data)
         {
            _loc2_ = _loc4_.pos - (_curPage - 1) * _itemCount;
            if(_loc2_ >= 0)
            {
               if(_loc2_ < _itemList.length)
               {
                  _loc1_ = _itemList[_loc2_] as BaseItemView;
                  _loc1_.data = _loc4_;
                  _loc3_ = new Date();
                  _loc3_.setTime(serverTime);
                  if(_loc4_.validDate > 0 && serverTime - _loc4_.beginDate.getTime() >= _loc4_.validDate * 60 * 1000)
                  {
                     sendDeleteGoods(_loc4_.bagType,_loc4_.pos);
                  }
               }
            }
         }
         refreshItems();
      }
      
      protected function sendDeleteGoods(param1:int, param2:int) : void
      {
         SocketSendManager.instance.sendDeleteGoods(param1,param2);
      }
      
      protected function refreshItems() : void
      {
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
      
      public function reFreshAll() : void
      {
         refreshData();
         refreshSortData();
         refreshPage();
         refreshView();
      }
      
      public function gotoPage(param1:int) : void
      {
         if(_curPage == param1)
         {
            return;
         }
         _curPage = param1;
         refreshData();
         refreshView();
         NotificationManager.instance.sendNotification("FILTR_BY_SELL");
         NotificationManager.instance.sendNotification("FILTER_GOODS");
      }
      
      public function prePage() : void
      {
         if(_pageCount == 1)
         {
            return;
         }
         _curPage = _curPage - 1;
         if(_curPage < 1)
         {
            _curPage = _pageCount;
         }
         refreshView();
      }
      
      public function nextPage() : void
      {
         if(_pageCount == 1)
         {
            return;
         }
         _curPage = _curPage + 1;
         if(_curPage > _pageCount)
         {
            _curPage = 1;
         }
         refreshView();
      }
      
      public function dispose() : void
      {
         removeEvent();
         uninit();
         if(parent)
         {
            parent.removeChild(this);
         }
         LayerManager.Instance.clearGameMenuLayer();
      }
      
      public function get curPage() : int
      {
         return _curPage;
      }
      
      public function get pageCount() : int
      {
         return _pageCount;
      }
      
      public function get itemList() : Vector.<BaseItemView>
      {
         return _itemList;
      }
      
      protected function get serverTime() : Number
      {
         return PlayerManager.instance.currentPlayerModel.sysCurTimeBySecond * 1000;
      }
      
      protected function sortFun(param1:GoodsInfo, param2:GoodsInfo) : Number
      {
         var _loc3_:int = param1.templateInfo.SonType;
         var _loc4_:int = param2.templateInfo.SonType;
         if(GoodsManager.instance.isType(param1,sortByType) && !GoodsManager.instance.isType(param2,sortByType))
         {
            return -1;
         }
         if(!GoodsManager.instance.isType(param1,sortByType) && GoodsManager.instance.isType(param2,sortByType))
         {
            return 1;
         }
         if(_loc3_ < _loc4_)
         {
            return -1;
         }
         if(_loc3_ > _loc4_)
         {
            return 1;
         }
         if(param1.templateId < param2.templateId)
         {
            return 1;
         }
         if(param1.templateId > param2.templateId)
         {
            return -1;
         }
         if(param1.strengthenGrade < param2.strengthenGrade)
         {
            return 1;
         }
         if(param1.strengthenGrade > param2.strengthenGrade)
         {
            return -1;
         }
         if(!param1.isBinds && param2.isBinds)
         {
            return -1;
         }
         if(param1.isBinds && !param2.isBinds)
         {
            return 1;
         }
         return 0;
      }
      
      public function sort(param1:Boolean, param2:int = 0) : void
      {
         var _loc8_:int = 0;
         var _loc6_:int = 0;
         refreshData();
         if(!_data)
         {
            return;
         }
         var _loc4_:Array = [];
         var _loc5_:Array = [];
         var _loc3_:Array = [];
         _loc3_ = _loc3_.concat(_data.getList());
         sortByType = param2;
         _loc3_.sort(sortFun);
         var _loc7_:Boolean = false;
         _loc6_ = 0;
         while(_loc6_ < _loc3_.length)
         {
            _loc8_ = int(GoodsInfo(_loc3_[_loc6_]).pos);
            if(_loc8_ != _loc6_)
            {
               _loc7_ = true;
            }
            _loc4_.push(_loc8_);
            _loc5_.push(_loc6_);
            _loc6_++;
         }
         if(_loc7_ || param1)
         {
            GoodsManager.instance.fixBagItem(_loc4_,_loc5_,bagType,param1);
         }
      }
      
      public function sortADD() : void
      {
         refreshData();
         if(!_data)
         {
            return;
         }
         __tidyGoogs();
      }
      
      private function __tidyGoogs() : void
      {
         var _loc2_:Dictionary = new Dictionary();
         for each(var _loc3_:GoodsInfo in _data)
         {
            if(_loc3_.templateInfo.MaxCount > 1)
            {
               if(_loc2_[_loc3_.templateId] == null)
               {
                  _loc2_[_loc3_.templateId] = new Vector.<GoodsInfo>();
               }
               _loc2_[_loc3_.templateId].push(_loc3_);
            }
         }
         for each(var _loc1_:Vector.<GoodsInfo> in _loc2_)
         {
            if(_loc1_.length > 1)
            {
               __swap(_loc1_);
            }
         }
      }
      
      private function __swap(param1:Vector.<GoodsInfo>) : void
      {
         var _loc2_:int = 0;
         var _loc3_:GoodsInfo = param1[0];
         _loc2_ = 1;
         while(_loc2_ < param1.length)
         {
            PlayerManager.instance.moveBagToBag(param1[_loc2_].bagType,param1[_loc2_].objectId,param1[_loc2_].pos,_loc3_.bagType,_loc3_.objectId,_loc3_.pos,param1[_loc2_].count);
            _loc2_++;
         }
      }
      
      public function get currentBagType() : int
      {
         return bagType;
      }
   }
}

