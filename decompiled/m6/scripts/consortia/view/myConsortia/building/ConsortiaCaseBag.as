package consortia.view.myConsortia.building
{
   import bag.events.BagEvent;
   import bag.view.BaseBagListView;
   import cell.view.consortiabag.ConsortiaCaseCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.Event;
   import mvc.module.consortia.ConsortiaModel;
   import yishi.datas.goods.GoodsInfo;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.ViewTempDataManager;
   import yishi.utils.SimpleDictionary;
   import yishi.view.community.BaseItemView;
   
   public class ConsortiaCaseBag extends BaseBagListView
   {
      
      private var _cModel:ConsortiaModel;
      
      private var _preLevel:int;
      
      private var _rentalBagStateView:ConsortiaRentalBagStateView;
      
      public function ConsortiaCaseBag(param1:int = 7, param2:int = 9, param3:int = 1)
      {
         bagType = 6;
         super(param1,param2,param3);
      }
      
      override protected function __bagItemUpdateHandler(param1:BagEvent) : void
      {
         var _loc3_:GoodsInfo = param1.info;
         var _loc2_:BaseItemView = _itemDic[_loc3_.pos + "_" + _loc3_.objectId + "_" + _loc3_.bagType];
         if(_loc2_)
         {
            _loc2_.data = _loc3_;
         }
      }
      
      override protected function __bagItemDeleteHandler(param1:BagEvent) : void
      {
         var _loc3_:GoodsInfo = param1.info;
         var _loc2_:BaseItemView = _itemDic[_loc3_.pos + "_" + _loc3_.objectId + "_" + _loc3_.bagType];
         if(_loc2_)
         {
            _loc2_.data = null;
         }
      }
      
      override protected function init(param1:int, param2:int) : void
      {
         var _loc6_:* = 0;
         var _loc4_:Boolean = false;
         var _loc3_:ConsortiaCaseCell = null;
         _cModel = FrameControllerManager.instance.consortiaController.model;
         _itemCount = param1 * param2;
         _itemList = new Vector.<BaseItemView>();
         _itemDic = new SimpleDictionary();
         _list = ComponentFactory.Instance.creatCustomObject("consortia.SimpleTileList",[param1]);
         addChild(_list);
         _preLevel = _cModel.consortiaInfo.storeLevel;
         var _loc5_:int = int(_preLevel == 10 ? _itemCount : _preLevel * 5);
         _list.beginChanges();
         _loc6_ = 0;
         while(_loc6_ < _itemCount)
         {
            _loc4_ = _loc6_ >= _loc5_ ? true : false;
            _loc3_ = ConsortiaCaseCell(creatItem(_loc4_));
            _list.addChild(_loc3_);
            _itemList.push(_loc3_);
            _loc6_++;
         }
         _list.commitChanges();
         _cModel.addEventListener("UPDA_CONSORTIA_INFO",__onConsortiaInfoUpdataHandler);
      }
      
      override protected function creatItem(param1:Boolean = false, param2:int = -1) : BaseItemView
      {
         var _loc3_:BaseItemView = ComponentFactory.Instance.creatCustomObject("consortia.ConsortiaCaseCell");
         _loc3_.bagType = bagType;
         _loc3_.objectId = 0;
         (_loc3_ as ConsortiaCaseCell).isLock = param1;
         return _loc3_;
      }
      
      override public function get itemList() : Vector.<BaseItemView>
      {
         return _itemList;
      }
      
      override protected function removeEvent() : void
      {
         super.removeEvent();
         if(_cModel)
         {
            _cModel.removeEventListener("UPDA_CONSORTIA_INFO",__onConsortiaInfoUpdataHandler);
         }
      }
      
      private function __onConsortiaInfoUpdataHandler(param1:Event) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = 56;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            (_itemList[_loc3_] as ConsortiaCaseCell).isLock = true;
            _loc3_++;
         }
         if(_curPage == 1)
         {
            _loc2_ = int(_preLevel == 10 ? _itemCount : _preLevel * 5);
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               (_itemList[_loc3_] as ConsortiaCaseCell).isLock = false;
               _loc3_++;
            }
         }
         else if(_curPage == 2)
         {
            if(model.consortiaInfo.isStorageExpire1 && checkGrid() || !model.consortiaInfo.isStorageExpire1)
            {
               _loc2_ = 56;
               _loc3_ = 0;
               while(_loc3_ < _loc2_)
               {
                  (_itemList[_loc3_] as ConsortiaCaseCell).isLock = false;
                  _loc3_++;
               }
            }
         }
         else if(_curPage == 3)
         {
            if(model.consortiaInfo.isStorageExpire2 && checkGrid() || !model.consortiaInfo.isStorageExpire2)
            {
               _loc2_ = 56;
               _loc3_ = 0;
               while(_loc3_ < _loc2_)
               {
                  (_itemList[_loc3_] as ConsortiaCaseCell).isLock = false;
                  _loc3_++;
               }
            }
         }
      }
      
      private function checkGrid() : Boolean
      {
         var _loc3_:int = 0;
         var _loc1_:BaseItemView = null;
         var _loc2_:int = int(_itemList.length);
         if(_curPage == 2 || _curPage == 3)
         {
            _loc2_ = 49;
         }
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = _itemList[_loc3_] as BaseItemView;
            if(_loc1_.data)
            {
               return true;
            }
            _loc3_++;
         }
         return false;
      }
      
      override protected function refreshView() : void
      {
         var _loc3_:int = 0;
         var _loc1_:BaseItemView = null;
         var _loc4_:Date = null;
         _itemDic.clear();
         if(_curPage == 0)
         {
            _curPage = 1;
         }
         var _loc6_:int = (_curPage - 1) * _itemCount;
         var _loc2_:int = int(_itemList.length);
         if(_curPage == 2)
         {
            _loc6_ = (_curPage - 1) * _itemCount;
            _loc2_ = 49;
         }
         else if(_curPage == 3)
         {
            _loc6_ = (_curPage - 2) * _itemCount + 49;
            _loc2_ = 49;
         }
         clearBagItemData();
         for each(var _loc5_:GoodsInfo in _data)
         {
            _loc3_ = _loc5_.pos - _loc6_;
            if(_loc3_ >= 0)
            {
               if(_loc3_ < _loc2_)
               {
                  _loc1_ = _itemList[_loc3_] as BaseItemView;
                  _loc1_.data = _loc5_;
                  _loc4_ = new Date();
                  _loc4_.setTime(serverTime);
                  if(_loc5_.validDate > 0 && serverTime - _loc5_.beginDate.getTime() >= _loc5_.validDate * 60 * 1000)
                  {
                     sendDeleteGoods(_loc5_.bagType,_loc5_.pos);
                  }
               }
            }
         }
         refreshItems();
      }
      
      override protected function clearBagItemData() : void
      {
         var _loc3_:int = 0;
         var _loc1_:BaseItemView = null;
         var _loc4_:int = (_curPage - 1) * _itemCount;
         var _loc2_:int = int(_itemList.length);
         if(_curPage == 2)
         {
            _loc4_ = (_curPage - 1) * _itemCount;
            _loc2_ = 49;
         }
         else if(_curPage == 3)
         {
            _loc4_ = (_curPage - 2) * _itemCount + 49;
            _loc2_ = 49;
         }
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
      
      override public function sort(param1:Boolean, param2:int = 0) : void
      {
         var _loc7_:int = 0;
         var _loc9_:int = 0;
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
         if(_loc3_.length <= 56)
         {
            _loc7_ = 1;
         }
         else if(_loc3_.length > 56 && _loc3_.length <= 56 + 49)
         {
            _loc7_ = 2;
         }
         else
         {
            _loc7_ = 3;
         }
         var _loc8_:Boolean = false;
         _loc6_ = 0;
         while(_loc6_ < _loc3_.length)
         {
            _loc9_ = int(GoodsInfo(_loc3_[_loc6_]).pos);
            if(_loc9_ != _loc6_)
            {
               _loc8_ = true;
            }
            _loc4_.push(_loc9_);
            if(_loc7_ == 1)
            {
               _loc5_.push(_loc6_);
            }
            else if(_loc7_ == 2)
            {
               if(!model.consortiaInfo.isStorageExpire1 && _loc6_ + 1 > 56)
               {
                  _loc5_.push(_loc6_);
               }
               else if(!model.consortiaInfo.isStorageExpire2 && _loc6_ + 1 > 56)
               {
                  _loc5_.push(_loc6_ + 49);
               }
               else
               {
                  _loc5_.push(_loc6_);
               }
            }
            else
            {
               _loc5_.push(_loc6_);
            }
            _loc6_++;
         }
         if(_loc8_ || param1)
         {
            GoodsManager.instance.fixBagItem(_loc4_,_loc5_,bagType,param1);
         }
      }
      
      override protected function refreshItems() : void
      {
         if(!_rentalBagStateView)
         {
            _rentalBagStateView = new ConsortiaRentalBagStateView();
            addChild(_rentalBagStateView);
         }
         _rentalBagStateView.visible = false;
         if(_curPage >= 2)
         {
            _rentalBagStateView.currentPage = _curPage;
            _rentalBagStateView.delayRental = checkGrid();
            _rentalBagStateView.refresh();
            _rentalBagStateView.visible = true;
         }
         __onConsortiaInfoUpdataHandler(null);
      }
      
      private function get model() : ConsortiaModel
      {
         return FrameControllerManager.instance.consortiaController.model;
      }
      
      override protected function uninit() : void
      {
         ViewTempDataManager.getInstance().castleViewdata.heroUIViewData.curBagType = -1;
         _cModel = null;
         super.uninit();
         ObjectUtils.disposeObject(_rentalBagStateView);
         _rentalBagStateView = null;
      }
      
      override public function refreshData() : void
      {
         _data = GoodsManager.instance.consoritaBagList;
      }
   }
}

