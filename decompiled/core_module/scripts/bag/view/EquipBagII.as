package bag.view
{
   import cell.view.bag.BaseBagCell;
   import cell.view.playerbag.PlayerBagCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.events.PlayerEvent;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.GoodsManager;
   import yishi.manager.PlayerManager;
   import yishi.service.managers.SocketManager;
   import yishi.view.community.BaseItemView;
   
   public class EquipBagII extends BaseBagListView
   {
      
      private var _rentalBagStateView:RentalBagStateView;
      
      private var _storeBagStateView:StoreBagStateView;
      
      public function EquipBagII(param1:int = 7, param2:int = 7, param3:int = 1)
      {
         bagType = 1;
         super(param1,param2,param3);
         _list.vSpace = -6;
         _list.hSpace = -7;
      }
      
      override protected function initEvent() : void
      {
         super.initEvent();
         playerInfo.addEventListener("BAG_CAPICITY_INCRESS",__infoChange);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 276,onOpenStoreBag);
      }
      
      override protected function removeEvent() : void
      {
         super.removeEvent();
         playerInfo.removeEventListener("BAG_CAPICITY_INCRESS",__infoChange);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 276,onOpenStoreBag);
      }
      
      private function onOpenStoreBag(param1:SLGSocketEvent) : void
      {
         sort(true);
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function __infoChange(param1:PlayerEvent) : void
      {
         refreshItems();
      }
      
      override protected function creatItem(param1:Boolean = false, param2:int = -1) : BaseItemView
      {
         var _loc3_:PlayerBagCell = ComponentFactory.Instance.creatCustomObject("army.HeroBagItemView");
         _loc3_.bagType = bagType;
         _loc3_.objectId = 0;
         _loc3_.lock = true;
         return _loc3_;
      }
      
      protected function get bagLimit() : int
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo.bagTotalCount;
      }
      
      protected function get bagCount() : int
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo.bagCount;
      }
      
      override protected function refreshView() : void
      {
         var _loc3_:int = 0;
         var _loc1_:BaseItemView = null;
         var _loc4_:Date = null;
         _itemDic.clear();
         if(_curPage > _pageCount)
         {
            _curPage %= _pageCount;
         }
         if(_curPage == 0)
         {
            _curPage = 1;
         }
         var _loc7_:int = (_curPage - 1) * _itemCount;
         var _loc2_:int = int(_itemList.length);
         if(_curPage == 5)
         {
            if(bagCount > 126 && bagCount <= 182)
            {
               _loc7_ = (_curPage - 2) * _itemCount + bagCount - 126;
            }
            else
            {
               _loc7_ = (_curPage - 2) * _itemCount;
            }
            _loc2_ = 49;
         }
         else if(_curPage == 6)
         {
            if(bagCount > 126 && bagCount <= 182)
            {
               _loc7_ = (_curPage - 3) * _itemCount + 49 + bagCount - 126;
            }
            else
            {
               _loc7_ = (_curPage - 3) * _itemCount + 49;
            }
            _loc2_ = 49;
         }
         var _loc6_:int = 56;
         if(_curPage == 4 && bagLimit - 266 <= 56 && PlayerManager.instance.currentPlayerModel.playerInfo.rentalBagStatus > 0)
         {
            _loc6_ = bagCount - 126;
         }
         else if(PlayerManager.instance.currentPlayerModel.playerInfo.rentalBagStatus <= 0)
         {
            _loc6_ = 56;
         }
         clearBagItemData();
         for each(var _loc5_:GoodsInfo in _data)
         {
            _loc3_ = _loc5_.pos - _loc7_;
            if(!(_curPage == 4 && _loc6_ - 1 < _loc3_))
            {
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
         }
         refreshItems();
      }
      
      override protected function refreshItems() : void
      {
         var _loc2_:int = 0;
         var _loc1_:BaseBagCell = null;
         if(!_rentalBagStateView)
         {
            _rentalBagStateView = new RentalBagStateView();
            addChild(_rentalBagStateView);
         }
         stopEffect();
         var _loc3_:int = bagLimit - (_curPage - 1) * _itemCount;
         if(_curPage == 4)
         {
            _loc3_ = bagCount - 126;
         }
         _loc2_ = 0;
         while(_loc2_ < _itemCount)
         {
            _loc1_ = _itemList[_loc2_] as BaseBagCell;
            if(_curPage >= 5)
            {
               _loc1_.lock = false;
               _loc1_.lockTxt = false;
            }
            else
            {
               _loc1_.lock = _loc2_ >= _loc3_;
               _loc1_.lockTxt = false;
               if(_loc3_ + 1 >= 0 && _loc3_ < _itemCount - 1 && _loc2_ == _loc3_)
               {
                  _loc1_.lockTxt = true;
               }
            }
            _loc2_++;
         }
         _rentalBagStateView.visible = false;
         if(_curPage >= 5)
         {
            _rentalBagStateView.currentPage = _curPage;
            _rentalBagStateView.refresh();
            _rentalBagStateView.visible = true;
         }
         if(_storeBagStateView != null)
         {
            if(_storeBagStateView != null && _storeBagStateView.parent != null)
            {
               _storeBagStateView.parent.removeChild(_storeBagStateView);
            }
         }
      }
      
      public function showStoreBagStateView(param1:Boolean) : void
      {
         if(_storeBagStateView == null)
         {
            _storeBagStateView = new StoreBagStateView();
         }
         addChild(_storeBagStateView);
         stopEffect();
         super._list.visible = false;
         if(!param1)
         {
            if(_storeBagStateView != null && _storeBagStateView.parent != null)
            {
               _storeBagStateView.parent.removeChild(_storeBagStateView);
            }
            super._list.visible = true;
         }
      }
      
      override protected function clearBagItemData() : void
      {
         var _loc3_:int = 0;
         var _loc1_:BaseItemView = null;
         var _loc4_:int = (_curPage - 1) * _itemCount;
         var _loc2_:int = int(_itemList.length);
         if(_curPage == 5)
         {
            _loc4_ = (_curPage - 1) * _itemCount;
            _loc2_ = 49;
         }
         else if(_curPage == 6)
         {
            _loc4_ = (_curPage - 2) * _itemCount + 49;
            _loc2_ = 49;
         }
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = _itemList[_loc3_] as BaseItemView;
            _loc1_.data = null;
            if(_curPage == 5 || _curPage == 6)
            {
               _loc1_.pos = _loc3_ + _loc4_ - 56 + bagCount - 126;
            }
            else
            {
               _loc1_.pos = _loc3_ + _loc4_;
            }
            if(_curPage == 4)
            {
               if(bagCount - 126 > _loc3_)
               {
                  _loc1_.pos = _loc3_ + _loc4_;
               }
               else
               {
                  _loc1_.pos = _loc3_ + _loc4_ + 49 + 49;
               }
            }
            _itemDic.add(_loc1_.pos + "_0_" + bagType,_loc1_);
            _loc3_++;
         }
      }
      
      public function getBaseBagItemByPos(param1:int) : BaseItemView
      {
         return _itemDic[param1 + "_0_1"];
      }
      
      public function getBaseBagItemByType(param1:int) : BaseItemView
      {
         var _loc2_:BaseItemView = null;
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < _itemList.length)
         {
            if(_itemList[_loc3_].data && _itemList[_loc3_].data.templateInfo.SonType == param1)
            {
               _loc2_ = _itemList[_loc3_];
               break;
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      override protected function defaultView() : void
      {
      }
      
      public function showEffectByPos(param1:int) : void
      {
         for each(var _loc2_:PlayerBagCell in _itemList)
         {
            if(_loc2_.data && _loc2_.data.pos == param1)
            {
               _loc2_.showEffect();
            }
         }
      }
      
      public function showEffectBySontype(param1:int) : void
      {
         for each(var _loc2_:PlayerBagCell in _itemList)
         {
            if(_loc2_.data && _loc2_.data.templateInfo.SonType == param1)
            {
               _loc2_.showEffect();
            }
         }
      }
      
      public function showFilterByPos(param1:int) : void
      {
         for each(var _loc2_:PlayerBagCell in _itemList)
         {
            if(_loc2_.data && _loc2_.data.pos == param1)
            {
               _loc2_.setLightFilter();
            }
            else if(_loc2_.data)
            {
               _loc2_.setDarkFilter();
            }
         }
      }
      
      public function showFilterBySontype(param1:int) : void
      {
         for each(var _loc2_:PlayerBagCell in _itemList)
         {
            if(_loc2_.data && _loc2_.data.templateInfo.SonType == param1)
            {
               _loc2_.setLightFilter();
            }
            else if(_loc2_.data)
            {
               _loc2_.setDarkFilter();
            }
         }
      }
      
      override protected function stopEffect() : void
      {
         for each(var _loc1_:PlayerBagCell in _itemList)
         {
            _loc1_.stopEffect();
         }
      }
      
      override public function sort(param1:Boolean, param2:int = 0) : void
      {
         var _loc5_:GoodsInfo = null;
         var _loc11_:int = 0;
         var _loc9_:int = 0;
         var _loc3_:int = 0;
         refreshData();
         if(!_data)
         {
            return;
         }
         var _loc7_:Array = [];
         var _loc14_:Array = [];
         var _loc13_:Array = [];
         var _loc4_:Array = [];
         var _loc10_:int = 0;
         var _loc8_:int = 0;
         var _loc12_:Array = [];
         _loc12_ = _loc12_.concat(_data.getList());
         var _loc6_:GoodsInfo = GoodsManager.instance.goodsListByPos["0_0_1"];
         if(_loc6_ && _loc6_.templateInfo.SonType == 298)
         {
            _loc5_ = _loc12_.splice(_loc12_.indexOf(_loc6_),1)[0];
         }
         sortByType = param2;
         _loc12_.sort(sortFun);
         if(_loc5_)
         {
            _loc12_.unshift(_loc5_);
         }
         var _loc15_:Boolean = false;
         _loc9_ = 0;
         while(_loc9_ < _loc12_.length)
         {
            _loc11_ = int(GoodsInfo(_loc12_[_loc9_]).pos);
            _loc3_ = int(GoodsInfo(_loc12_[_loc9_]).templateInfo.SonType);
            if(_loc11_ != _loc9_)
            {
               _loc15_ = true;
            }
            if(playerInfo.stoneBagCount > 0 && (_loc3_ == 205 || _loc3_ == 224 || _loc3_ == 228 || _loc3_ == 312 || _loc3_ == 329 || _loc3_ == 343 || _loc3_ == 344 || _loc3_ == 752 || _loc3_ == 753 || _loc3_ == 760 || _loc3_ == 761))
            {
               _loc13_.push(_loc11_);
            }
            else
            {
               _loc7_.push(_loc11_);
               _loc14_.push(_loc10_);
               _loc10_++;
            }
            _loc9_++;
         }
         _loc9_ = 0;
         while(_loc9_ < _loc13_.length)
         {
            _loc4_.push(_loc7_.length + _loc9_);
            _loc9_++;
         }
         _loc7_ = _loc7_.concat(_loc13_);
         _loc14_ = _loc14_.concat(_loc4_);
         if(_loc15_ || param1)
         {
            GoodsManager.instance.fixBagItem(_loc7_,_loc14_,bagType,param1);
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         removeEvent();
         ObjectUtils.disposeObject(_storeBagStateView);
         _storeBagStateView = null;
         ObjectUtils.disposeObject(_rentalBagStateView);
         _rentalBagStateView = null;
         ObjectUtils.disposeAllChildren(this);
      }
   }
}

