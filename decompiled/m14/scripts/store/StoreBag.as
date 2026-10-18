package store
{
   import bag.events.BagEvent;
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.geom.IntPoint;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import events.StoreEvent;
   import flash.display.Sprite;
   import mvc.module.armyII.UserArmy;
   import mvc.module.store.StoreModel;
   import yishi.datas.VersionSwitch;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.events.PlayerEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   import yishi.utils.SimpleDictionary;
   import yishi.view.community.BaseItemView;
   
   public class StoreBag extends Sprite implements Disposeable
   {
      
      private var _list:SimpleTileList;
      
      private var _bagScroll:ScrollPanel;
      
      private var _defaultCount:int;
      
      private var _rowCount:int;
      
      private var _columnCount:int;
      
      private var _data:Array;
      
      private var _itemList:Vector.<BaseItemView>;
      
      private var _itemDic:SimpleDictionary = new SimpleDictionary(true);
      
      private const REFRESHLOCK_TEMPID:int = 208027;
      
      public function StoreBag(param1:int, param2:int)
      {
         super();
         _rowCount = param1;
         _columnCount = param2;
         _defaultCount = _rowCount * _columnCount;
         initView();
         initEvent();
         initList();
         refreshData();
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
         _list = ComponentFactory.Instance.creatCustomObject("store.SimpleTileList",[6]);
         _bagScroll = ComponentFactory.Instance.creatComponentByStylename("store.HeroEquipScroll");
         _bagScroll.setView(_list);
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
               _loc1_ = ComponentFactory.Instance.creatCustomObject("store.StoreBagCell");
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
      
      public function refreshData() : void
      {
         var _loc3_:GoodsInfo = null;
         var _loc2_:int = 0;
         _data = [];
         var _loc5_:Array = GoodsManager.instance.getHeroEquipListById(thane.id).getList();
         _loc5_.sort(sortHeroEquip);
         var _loc4_:Array = GoodsManager.instance.getGeneralBagEquipList();
         _loc4_.sort(sortHeroEquip);
         var _loc7_:Array = GoodsManager.instance.getGeneralBagPropList();
         _loc7_.sort(sortByTpye);
         var _loc6_:Array = GoodsManager.instance.getStoreBagPropList();
         _loc6_.sort(sortByTpye);
         var _loc1_:Array = [];
         _loc1_ = _loc1_.concat(_loc5_).concat(_loc4_).concat(_loc7_).concat(_loc6_);
         _loc2_ = 0;
         while(_loc2_ < _loc1_.length)
         {
            _loc3_ = _loc1_[_loc2_] as GoodsInfo;
            if(!(!GoodsManager.instance.isGneralStoreBagGoods(_loc3_) && !GoodsManager.instance.isHeroGoods(uArmy.baseHero ? uArmy.baseHero.id : 0,_loc3_)))
            {
               if(filterGoods(_loc3_))
               {
                  _data.push(_loc3_);
               }
            }
            _loc2_++;
         }
      }
      
      private function sortHeroEquip(param1:GoodsInfo, param2:GoodsInfo) : int
      {
         if(!param1.isBinds && Boolean(param2.isBinds))
         {
            return -1;
         }
         if(param1.isBinds && !param2.isBinds)
         {
            return 1;
         }
         if(param1.templateInfo.Profile > param2.templateInfo.Profile)
         {
            return -1;
         }
         if(param1.templateInfo.Profile < param2.templateInfo.Profile)
         {
            return 1;
         }
         if(param1.templateInfo.NeedGrades > param2.templateInfo.NeedGrades)
         {
            return -1;
         }
         if(param1.templateInfo.NeedGrades < param2.templateInfo.NeedGrades)
         {
            return 1;
         }
         if(param1.strengthenGrade > param2.strengthenGrade)
         {
            return -1;
         }
         if(param1.strengthenGrade < param2.strengthenGrade)
         {
            return 1;
         }
         return 0;
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
         _list.commitChanges();
         _bagScroll.invalidateViewport();
      }
      
      private function addItem(param1:GoodsInfo) : void
      {
         var _loc2_:BaseItemView = null;
         if(filterGoods(param1) && _data)
         {
            _loc2_ = findBagEmputyItem(_data.length);
            _loc2_.bagType = param1.bagType;
            _loc2_.pos = param1.pos;
            _loc2_.data = param1;
            _itemDic.add(param1.pos + "_" + param1.objectId + "_" + param1.bagType,_loc2_);
         }
      }
      
      public function moveItem(param1:GoodsInfo) : void
      {
         var _loc2_:int = 0;
         if(param1 == null)
         {
            return;
         }
         if(filterGoods(param1) && _data && _itemList)
         {
            _loc2_ = 0;
            while(_loc2_ < _itemList.length)
            {
               if(_itemList[_loc2_].data == param1 && _itemList[_loc2_].icon)
               {
                  _itemList[_loc2_].icon.dispatchEvent(new InteractiveEvent("interactive_double_click"));
               }
               _loc2_++;
            }
         }
      }
      
      public function defaultView() : void
      {
         refreshData();
         refreshView();
      }
      
      private function initEvent() : void
      {
         GoodsManager.instance.addEventListener("UPDATE_BAG",__bagItemUpdateHandler);
         GoodsManager.instance.addEventListener("DELETE_BAG",__bagItemDeleteHandler);
         model.addEventListener("SELECTED_PANEL_CHANGE",__selectedPanelChangeHandler);
      }
      
      private function removeEvent() : void
      {
         GoodsManager.instance.removeEventListener("UPDATE_BAG",__bagItemUpdateHandler);
         GoodsManager.instance.removeEventListener("DELETE_BAG",__bagItemDeleteHandler);
         model.removeEventListener("SELECTED_PANEL_CHANGE",__selectedPanelChangeHandler);
      }
      
      private function __isViceHeroChangeHandler(param1:PlayerEvent) : void
      {
         refreshView();
      }
      
      private function __selectedPanelChangeHandler(param1:StoreEvent) : void
      {
         defaultView();
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
         if(!filterGoods(_loc3_))
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
      
      private function sortByTpye(param1:GoodsInfo, param2:GoodsInfo) : int
      {
         if(param1.isBinds == false && param2.isBinds == true)
         {
            return -1;
         }
         if(param1.isBinds == true && param2.isBinds == true || param1.isBinds == false && param2.isBinds == false)
         {
            if(param1.templateInfo.MasterType > param2.templateInfo.MasterType)
            {
               return -1;
            }
            if(param1.templateInfo.MasterType == param2.templateInfo.MasterType)
            {
               if(param1.templateInfo.NeedGrades > param2.templateInfo.NeedGrades)
               {
                  return -1;
               }
               if(param1.templateInfo.NeedGrades == param2.templateInfo.NeedGrades)
               {
                  if(param1.templateInfo.TemplateId > param2.templateInfo.TemplateId)
                  {
                     return -1;
                  }
                  if(param1.templateInfo.TemplateId == param2.templateInfo.TemplateId)
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
               return 1;
            }
            return 1;
         }
         return 1;
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
      
      private function filterGoods(param1:GoodsInfo) : Boolean
      {
         if(param1.templateInfo.MasterType == 5)
         {
            return false;
         }
         if(param1.templateInfo.MasterType == 6)
         {
            return false;
         }
         if(model.selectedPanel != "STORE_PANEL_RESOLVE" && Boolean(FrameControllerManager.instance.fashionCodeController.model.isFashion(param1)))
         {
            return false;
         }
         if(model.selectedPanel == "STORE_PANEL_INTENSIFY")
         {
            if(param1.templateInfo.SonType == 204)
            {
               return true;
            }
            if(param1.templateInfo.StrengthenMax > 0)
            {
               return true;
            }
         }
         else if(model.selectedPanel == "STORE_PANEL_MOUNT")
         {
            if(param1.templateInfo.SonType == 205)
            {
               return true;
            }
            if(param1.templateInfo.SonType == 228)
            {
               return true;
            }
            if(param1.templateInfo.SonType == 299)
            {
               return true;
            }
            if(param1.templateInfo.MasterType == 1 && param1.templateInfo.SonType != 109)
            {
               return true;
            }
         }
         else
         {
            if(model.selectedPanel == "STORE_PANEL_COMPOSE")
            {
               return true;
            }
            if(model.selectedPanel == "STORE_PANEL_REFRESH")
            {
               if(param1.templateInfo.SonType == 215)
               {
                  return true;
               }
               if(param1.templateInfo.MasterType == 1 && param1.templateInfo.Refresh != 0)
               {
                  return true;
               }
               if(param1.templateInfo.TemplateId == 208027 && Boolean(VersionSwitch.REFRESH_LOCK))
               {
                  return true;
               }
            }
            else
            {
               if(model.selectedPanel == "STORE_PANEL_RESOLVE")
               {
                  return FrameControllerManager.instance.storeController.canShowForReslove(param1);
               }
               if(model.selectedPanel == "STORE_PANEL_SWITCH")
               {
                  if(param1.templateInfo.TransformId > 0 && param1.templateInfo.SonType != 343 && param1.templateInfo.SonType != 344)
                  {
                     return true;
                  }
               }
               else if(model.selectedPanel == "STORE_PANEL_CAST")
               {
                  if(param1.templateId == 2120100)
                  {
                     return true;
                  }
                  if(param1.templateId == 2120101)
                  {
                     return true;
                  }
                  if(param1.templateId == 2120102)
                  {
                     return true;
                  }
                  if(param1.templateId == 2120103)
                  {
                     return true;
                  }
                  if(param1.templateId == 2120104)
                  {
                     return true;
                  }
                  if(param1.templateId == 2120105)
                  {
                     return true;
                  }
                  if(param1.templateInfo.StrengthenMax > 0 && param1.templateInfo.Profile >= 5 && param1.templateInfo.NeedGrades >= 50)
                  {
                     return true;
                  }
               }
               else if(model.selectedPanel == "STORE_PANEL_ENCHANT")
               {
                  if(param1.templateInfo.MasterType == 1)
                  {
                     return true;
                  }
                  if(param1.templateInfo.MasterType == 2 && param1.templateInfo.SonType == 236)
                  {
                     return true;
                  }
               }
            }
         }
         return false;
      }
      
      public function get itemList() : Vector.<BaseItemView>
      {
         return _itemList;
      }
      
      public function dispose() : void
      {
         for each(var _loc1_:BaseItemView in _itemList)
         {
            _loc1_.dispose();
            _loc1_ = null;
         }
         removeEvent();
         _list.disposeAllChildren();
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

