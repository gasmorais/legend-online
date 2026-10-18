package auction.view.sell
{
   import bag.events.BagEvent;
   import com.pickgliss.geom.IntPoint;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import events.PetEvent;
   import flash.display.Sprite;
   import flash.events.Event;
   import mvc.module.armyII.UserArmy;
   import mvc.module.pet.PetData;
   import mvc.module.store.StoreModel;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.SimpleDictionary;
   import yishi.view.community.BaseItemView;
   
   public class AuctionSellBagPane extends Sprite implements Disposeable
   {
      
      private var _bg1:ScaleBitmapImage;
      
      private var _list:SimpleTileList;
      
      private var _bagScroll:ScrollPanel;
      
      private var _defaultCount:int;
      
      private var _rowCount:int;
      
      private var _columnCount:int;
      
      private var _data:Array;
      
      private var _itemList:Vector.<BaseItemView>;
      
      private var _itemDic:SimpleDictionary = new SimpleDictionary(true);
      
      private var _type:int = 1;
      
      public function AuctionSellBagPane(param1:int, param2:int)
      {
         super();
         _rowCount = param1;
         _columnCount = param2;
         _defaultCount = _rowCount * _columnCount;
         AuctionSellBagCell;
         initView();
         initEvent();
         initList();
      }
      
      private function get model() : StoreModel
      {
         return FrameControllerManager.instance.storeController.model;
      }
      
      private function get uArmy() : UserArmy
      {
         return ArmyManager.instance.army;
      }
      
      private function initView() : void
      {
         _bg1 = ComponentFactory.Instance.creatComponentByStylename("auction.bag.Bg");
         _list = ComponentFactory.Instance.creatCustomObject("auction.bag.SimpleTileList",[7]);
         _bagScroll = ComponentFactory.Instance.creatComponentByStylename("auction.bag.Scroll");
         _bagScroll.vUnitIncrement = 8;
         _bagScroll.setView(_list);
         addChild(_bg1);
         addChild(_bagScroll);
      }
      
      private function initList() : void
      {
         var _loc2_:* = 0;
         var _loc1_:BaseItemView = null;
         if(_rowCount > 0 && _columnCount > 0)
         {
            _itemList = new Vector.<BaseItemView>();
            _list.beginChanges();
            _loc2_ = 0;
            while(_loc2_ < _defaultCount)
            {
               _loc1_ = ComponentFactory.Instance.creatCustomObject("acution.BagCell");
               _loc1_.pos = -1;
               _list.addChild(_loc1_);
               _itemList.push(_loc1_);
               _loc2_++;
            }
            _list.hSpace = 3;
            _list.commitChanges();
            _bagScroll.invalidateViewport();
         }
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function sortHeroEquip(param1:GoodsInfo, param2:GoodsInfo) : int
      {
         if(param1.templateInfo.NeedGrades > param2.templateInfo.NeedGrades)
         {
            return -1;
         }
         if(param1.templateInfo.NeedGrades == param2.templateInfo.NeedGrades)
         {
            if(param1.templateInfo.Profile > param2.templateInfo.Profile)
            {
               return -1;
            }
            if(param1.templateInfo.Profile < param2.templateInfo.Profile)
            {
               return 1;
            }
            return 0;
         }
         return 1;
      }
      
      private function refreshView() : void
      {
         var _loc1_:int = 0;
         var _loc2_:GoodsInfo = null;
         clearGoods();
         refreshBag();
         _loc1_ = 0;
         while(_loc1_ < _data.length)
         {
            _loc2_ = _data[_loc1_] as GoodsInfo;
            _itemList[_loc1_].bagType = _loc2_.bagType;
            _itemList[_loc1_].pos = _loc2_.pos;
            _itemList[_loc1_].data = _loc2_;
            _itemDic.add(_loc2_.pos + "_" + _loc2_.objectId + "_" + _loc2_.bagType,_itemList[_loc1_]);
            _loc1_++;
         }
      }
      
      public function setScrollPosition() : void
      {
         var _loc1_:IntPoint = new IntPoint(0,0);
         if(_bagScroll)
         {
            _bagScroll.viewPort.viewPosition = _loc1_;
         }
      }
      
      private function clearGoods() : void
      {
         for each(var _loc1_:BaseItemView in _itemList)
         {
            _loc1_.data = null;
         }
         for each(var _loc2_:BaseItemView in _itemDic)
         {
            _loc2_.data = null;
            _loc2_.pos = -1;
         }
         _itemDic.clear();
      }
      
      private function refreshBag() : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = _rowCount * (int((_data.length + _rowCount - 1) / _rowCount));
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
            _loc2_ = ComponentFactory.Instance.creatCustomObject("acution.BagCell");
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
         if(canSell(param1) && _data)
         {
            _loc2_ = findBagEmputyItem(_data.length);
            _loc2_.bagType = param1.bagType;
            _loc2_.pos = param1.pos;
            _loc2_.data = param1;
            _itemDic.add(param1.pos + "_" + param1.objectId + "_" + param1.bagType,_loc2_);
         }
      }
      
      public function defaultView(param1:int = 1) : void
      {
         _type = param1;
         if(param1 == 2)
         {
            getCanBeSellPet();
         }
         else
         {
            getCanBeSellGoodsFormBag();
         }
         refreshView();
      }
      
      public function getCanBeSellPet() : void
      {
         var _loc4_:PetData = null;
         var _loc3_:GoodsInfo = null;
         var _loc2_:int = 0;
         _data = [];
         var _loc1_:Array = PlayerManager.instance.currentPlayerModel.playerInfo.petList;
         _loc2_ = 0;
         while(_loc2_ < _loc1_.length)
         {
            _loc4_ = _loc1_[_loc2_] as PetData;
            if(canSell(_loc4_))
            {
               _loc3_ = _loc4_.convertToGoods();
               _data.push(_loc3_);
            }
            _loc2_++;
         }
      }
      
      public function getCanBeSellGoodsFormBag() : void
      {
         var _loc3_:GoodsInfo = null;
         var _loc2_:int = 0;
         _data = [];
         var _loc1_:Array = GoodsManager.instance.getGeneralBagList().getList();
         _loc1_ = _loc1_.concat(GoodsManager.instance.getStroeBagList().getList());
         _loc2_ = 0;
         while(_loc2_ < _loc1_.length)
         {
            _loc3_ = _loc1_[_loc2_] as GoodsInfo;
            if(canSell(_loc3_))
            {
               _data.push(_loc3_);
            }
            _loc2_++;
         }
      }
      
      private function initEvent() : void
      {
         GoodsManager.instance.addEventListener("UPDATE_BAG",__bagItemUpdateHandler);
         GoodsManager.instance.addEventListener("DELETE_BAG",__bagItemDeleteHandler);
         GoodsManager.instance.addEventListener("RETURN_REFRESH",__cleanBagItemFilterHandler);
         PlayerManager.instance.currentPlayerModel.playerInfo.addEventListener("PET_ADD",__refreshPetHander);
         PlayerManager.instance.currentPlayerModel.playerInfo.addEventListener("PET_REMOVE",__refreshPetHander);
         PlayerManager.instance.currentPlayerModel.playerInfo.addEventListener("PET_UPDATE",__refreshPetHander);
      }
      
      private function __refreshPetHander(param1:PetEvent) : void
      {
         if(!stage)
         {
            return;
         }
         if(_type != 2)
         {
            return;
         }
         defaultView(_type);
         cleanBagItemFilter();
      }
      
      protected function __cleanBagItemFilterHandler(param1:Event) : void
      {
         cleanBagItemFilter();
      }
      
      private function removeEvent() : void
      {
         GoodsManager.instance.removeEventListener("UPDATE_BAG",__bagItemUpdateHandler);
         GoodsManager.instance.removeEventListener("DELETE_BAG",__bagItemDeleteHandler);
         GoodsManager.instance.removeEventListener("RETURN_REFRESH",__cleanBagItemFilterHandler);
         PlayerManager.instance.currentPlayerModel.playerInfo.removeEventListener("PET_ADD",__refreshPetHander);
         PlayerManager.instance.currentPlayerModel.playerInfo.removeEventListener("PET_REMOVE",__refreshPetHander);
         PlayerManager.instance.currentPlayerModel.playerInfo.removeEventListener("PET_UPDATE",__refreshPetHander);
      }
      
      private function __bagItemDeleteHandler(param1:BagEvent) : void
      {
         var _loc3_:GoodsInfo = param1.info;
         for each(var _loc2_:BaseItemView in _itemDic)
         {
            if(_loc2_.data && _loc3_.id == _loc2_.data.id)
            {
               _loc2_.data = null;
               _loc2_.setNormalFilter();
               break;
            }
         }
      }
      
      private function __bagItemUpdateHandler(param1:BagEvent) : void
      {
         var _loc3_:GoodsInfo = param1.info;
         if(_loc3_.bagType == 0)
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
         cleanBagItemFilter();
      }
      
      public function cleanBagItemFilter() : void
      {
         for each(var _loc1_:BaseItemView in _itemList)
         {
            if(_loc1_ && !_loc1_.isNormalFilter)
            {
               _loc1_.setNormalFilter();
            }
         }
      }
      
      private function sortByTpye(param1:GoodsInfo, param2:GoodsInfo) : int
      {
         var _loc4_:GoodsTemplateInfo = param1.templateInfo;
         var _loc3_:GoodsTemplateInfo = param2.templateInfo;
         return _loc4_.MasterType == _loc3_.MasterType ? 0 : (_loc4_.MasterType > _loc3_.MasterType ? 1 : -1);
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
            _loc2_ = ComponentFactory.Instance.creatCustomObject("acution.BagCell");
            _list.addChild(_loc2_);
            _itemList.push(_loc2_);
            _loc4_++;
         }
         _list.hSpace = 0;
         _list.commitChanges();
         _bagScroll.invalidateViewport();
         return findBagEmputyItem(_loc3_);
      }
      
      private function canSell(param1:Object) : Boolean
      {
         var _loc2_:PetData = null;
         if(param1 is GoodsInfo)
         {
            return !(param1 as GoodsInfo).isBinds;
         }
         if(param1 is PetData)
         {
            _loc2_ = param1 as PetData;
            return !_loc2_.isBind && !_loc2_.isEnterWar && !_loc2_.isPractice;
         }
         return false;
      }
      
      public function get itemList() : Vector.<BaseItemView>
      {
         return _itemList;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg1);
         _bg1 = null;
         ObjectUtils.disposeObject(_list);
         _list = null;
         ObjectUtils.disposeObject(_bagScroll);
         _bagScroll = null;
         ObjectUtils.disposeObject(_bg1);
         _bg1 = null;
         ObjectUtils.disposeObject(_bg1);
         _bg1 = null;
         for each(var _loc1_:BaseItemView in _itemDic)
         {
            _loc1_.dispose();
            _loc1_ = null;
         }
         _itemDic.clear();
         _itemList = null;
         _data = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

