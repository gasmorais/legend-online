package pet.advanced
{
   import bag.events.BagEvent;
   import com.pickgliss.geom.IntPoint;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import managers.PetEquipManager;
   import yishi.datas.goods.GoodsInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.GoodsManager;
   import yishi.manager.NotificationManager;
   import yishi.utils.SimpleDictionary;
   import yishi.view.community.BaseItemView;
   
   public class PetEquipBagView extends Sprite implements Disposeable
   {
      
      private var _bagBack:Bitmap;
      
      private var _bg:ScaleBitmapImage;
      
      private var _list:SimpleTileList;
      
      private var _bagScroll:ScrollPanel;
      
      private var _defaultCount:int;
      
      private var _rowCount:int;
      
      private var _columnCount:int;
      
      private var _data:Array;
      
      private var _itemList:Vector.<BaseItemView>;
      
      private var _itemDic:SimpleDictionary = new SimpleDictionary(true);
      
      private var _scrollStyle:String;
      
      private var _rowNum:int;
      
      private var _showBg:Boolean;
      
      private var _bgStyle:String;
      
      public function PetEquipBagView(param1:int, param2:int, param3:int = 6, param4:String = "pet.petEquipScroll", param5:Boolean = true, param6:String = "pet.petEquipBagViewBg01")
      {
         super();
         _rowCount = param1;
         _columnCount = param2;
         _rowNum = param3;
         _scrollStyle = param4;
         _defaultCount = _rowCount * _columnCount;
         _showBg = param5;
         _bgStyle = param6;
         initView();
         initEvent();
         initList();
         refreshData();
      }
      
      private function initView() : void
      {
         if(_showBg)
         {
            _bagBack = ComponentFactory.Instance.creatBitmap("asset.pet.bagBg");
            addChild(_bagBack);
         }
         else
         {
            _bg = ComponentFactory.Instance.creatComponentByStylename(_bgStyle);
            addChild(_bg);
         }
         _list = ComponentFactory.Instance.creatCustomObject("pet.SimpleTileList",[_rowNum]);
         _bagScroll = ComponentFactory.Instance.creatComponentByStylename(_scrollStyle);
         _bagScroll.setView(_list);
         addChild(_bagScroll);
      }
      
      private function initEvent() : void
      {
         GoodsManager.instance.addEventListener("UPDATE_BAG",__bagItemUpdateHandler);
         GoodsManager.instance.addEventListener("DELETE_BAG",__bagItemDeleteHandler);
         NotificationManager.instance.addEventListener("PETSTORECHANGEPAGE",__changeView);
         if(PetEquipManager.currSelectedPage != "PropertyView")
         {
            NotificationManager.instance.addEventListener("PETSELECTEDCHANGE",__changeView);
         }
      }
      
      private function removeEvent() : void
      {
         GoodsManager.instance.removeEventListener("UPDATE_BAG",__bagItemUpdateHandler);
         GoodsManager.instance.removeEventListener("DELETE_BAG",__bagItemDeleteHandler);
         NotificationManager.instance.removeEventListener("PETSTORECHANGEPAGE",__changeView);
         NotificationManager.instance.removeEventListener("PETSELECTEDCHANGE",__changeView);
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
               if(_showBg)
               {
                  _loc1_ = ComponentFactory.Instance.creatCustomObject("pet.PetBagCell");
               }
               else
               {
                  _loc1_ = ComponentFactory.Instance.creatCustomObject("pet.PetBagCell2");
               }
               _loc1_.pos = -1;
               _list.addChild(_loc1_);
               _itemList.push(_loc1_);
               _loc2_++;
            }
            if(_showBg)
            {
               _list.hSpace = 2;
            }
            else
            {
               _list.hSpace = 1;
            }
            _list.commitChanges();
            _bagScroll.invalidateViewport();
         }
      }
      
      private function __changeView(param1:NotificationEvent) : void
      {
         refreshData();
         refreshView();
      }
      
      private function refreshData() : void
      {
         var _loc5_:GoodsInfo = null;
         var _loc4_:int = 0;
         _data = [];
         var _loc1_:Array = [];
         var _loc7_:Array = [];
         var _loc6_:Array = [];
         var _loc9_:Array = [];
         var _loc8_:Array = [];
         var _loc3_:Array = [];
         var _loc2_:Array = [];
         if(PetEquipManager.currSelectedPetData == null)
         {
            return;
         }
         if(PetEquipManager.currSelectedPage == "PropertyView")
         {
            _loc7_ = GoodsManager.instance.getGeneralBagPetEquipList();
            if(_loc7_.length == 0)
            {
               return;
            }
            _loc7_.sort(sortPetEquip);
         }
         if(PetEquipManager.currSelectedPetData == null)
         {
            return;
         }
         if(PetEquipManager.currSelectedPage == "EquipStoreView" && PetEquipManager.currSelectedView == "PetEquipStrengView")
         {
            _loc7_ = GoodsManager.instance.getGeneralBagPetEquipList();
            _loc7_.sort(sortPetEquip);
            _loc6_ = GoodsManager.instance.getPetEquipListById(PetEquipManager.currSelectedPetData.petId);
            _loc6_.sort(sortPetEquip);
         }
         else if(PetEquipManager.currSelectedPage == "EquipStoreView" && PetEquipManager.currSelectedView == "PetEquipRefineryView")
         {
            _loc7_ = GoodsManager.instance.getGeneralBagPetEquipListByQuality(3,6);
            _loc7_.sort(sortPetEquip);
            _loc6_ = GoodsManager.instance.getPetEquipListByIdAndQuality(PetEquipManager.currSelectedPetData.petId,3,6).getList();
            _loc6_.sort(sortPetEquip);
         }
         else if(PetEquipManager.currSelectedPage == "EquipStoreView" && PetEquipManager.currSelectedView == "PetEquipGodHeadView")
         {
            _loc7_ = GoodsManager.instance.getGeneralBagPetEquipList();
            _loc7_.sort(sortPetEquip);
            _loc6_ = GoodsManager.instance.getPetEquipListById(PetEquipManager.currSelectedPetData.petId);
            _loc6_.sort(sortPetEquip);
            _loc9_ = GoodsManager.instance.getGeneralBagGoodsBySonType(329);
            _loc9_ = _loc9_.concat(GoodsManager.instance.getStoneBagGoodsBySonType(329));
            _loc9_.sort(sortByTpye);
            _loc8_ = GoodsManager.instance.getGeneralBagGoodsBySonType(328);
            _loc8_.sort(sortByTpye);
            _loc3_ = GoodsManager.instance.getGeneralBagGoodsBySonType(343);
            _loc3_ = _loc3_.concat(GoodsManager.instance.getStoneBagGoodsBySonType(343));
            _loc3_.sort(sortByTpye);
            _loc2_ = GoodsManager.instance.getGeneralBagGoodsBySonType(344);
            _loc2_ = _loc2_.concat(GoodsManager.instance.getStoneBagGoodsBySonType(344));
            _loc2_.sort(sortByTpye);
         }
         else if(PetEquipManager.currSelectedPage == "EquipStoreView" && PetEquipManager.currSelectedView == "PetEquipUpgradeView")
         {
            _loc7_ = GoodsManager.instance.getGeneralBagPetEquipListByQuality(3,5);
            _loc7_.sort(sortPetEquip);
            _loc6_ = GoodsManager.instance.getPetEquipListByIdAndQuality(PetEquipManager.currSelectedPetData.petId,3,5).getList();
            _loc6_.sort(sortPetEquip);
         }
         _loc1_ = _loc1_.concat(_loc6_).concat(_loc7_).concat(_loc9_).concat(_loc8_).concat(_loc3_).concat(_loc2_);
         _loc4_ = 0;
         while(_loc4_ < _loc1_.length)
         {
            _loc5_ = _loc1_[_loc4_] as GoodsInfo;
            _data.push(_loc5_);
            _loc4_++;
         }
      }
      
      private function sortPetEquip(param1:GoodsInfo, param2:GoodsInfo) : int
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
      
      private function refreshView() : void
      {
         var _loc2_:int = 0;
         var _loc3_:GoodsInfo = null;
         clearGoods();
         refreshBag();
         if(!_bagScroll || !_bagScroll.viewPort)
         {
            return;
         }
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
      
      private function addItems(param1:int) : void
      {
         var _loc3_:int = 0;
         var _loc2_:BaseItemView = null;
         _list.beginChanges();
         _loc3_ = 0;
         while(_loc3_ < param1)
         {
            if(_showBg)
            {
               _loc2_ = ComponentFactory.Instance.creatCustomObject("pet.PetBagCell");
            }
            else
            {
               _loc2_ = ComponentFactory.Instance.creatCustomObject("pet.PetBagCell2");
            }
            _loc2_.pos = -1;
            _list.addChild(_loc2_);
            _itemList.push(_loc2_);
            _loc3_++;
         }
         if(_itemList.length <= _defaultCount)
         {
            if(_showBg)
            {
               _list.hSpace = 2;
            }
            else
            {
               _list.hSpace = 1;
            }
         }
         else
         {
            _list.hSpace = 0;
         }
         _list.commitChanges();
         _bagScroll.invalidateViewport();
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
            if(_showBg)
            {
               _list.hSpace = 2;
            }
            else
            {
               _list.hSpace = 1;
            }
         }
         else
         {
            _list.hSpace = 0;
         }
         _list.commitChanges();
         _bagScroll.invalidateViewport();
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
         else if(PetEquipManager.currSelectedPage == "PropertyView")
         {
            if(_loc3_.bagType == 1)
            {
               addItem(_loc3_);
            }
         }
         else if(PetEquipManager.currSelectedPage == "EquipStoreView")
         {
            if(_loc3_.templateInfo.MasterType == 5)
            {
               if(_loc3_.objectId == PetEquipManager.currSelectedPetData.petId || _loc3_.objectId <= 0)
               {
                  addItem(_loc3_);
               }
            }
            else
            {
               addItem(_loc3_);
            }
         }
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
      
      private function filterGoods(param1:GoodsInfo) : Boolean
      {
         if(param1.templateInfo.MasterType == 5 || param1.templateInfo.SonType == 329 || param1.templateInfo.SonType == 328 || param1.templateInfo.SonType == 343 || param1.templateInfo.SonType == 344)
         {
            if(PetEquipManager.currSelectedPage == "PropertyView")
            {
               if(param1.templateInfo.MasterType == 5)
               {
                  return true;
               }
               return false;
            }
            if(PetEquipManager.currSelectedPage == "EquipStoreView" && PetEquipManager.currSelectedView == "PetEquipStrengView")
            {
               if(param1.templateInfo.MasterType == 5)
               {
                  return true;
               }
               return false;
            }
            if(PetEquipManager.currSelectedPage == "EquipStoreView" && PetEquipManager.currSelectedView == "PetEquipRefineryView")
            {
               if(param1.templateInfo.MasterType == 5 && param1.templateInfo.Profile >= 3)
               {
                  return true;
               }
               return false;
            }
            if(PetEquipManager.currSelectedPage == "EquipStoreView" && PetEquipManager.currSelectedView == "PetEquipGodHeadView")
            {
               if(param1.templateInfo.MasterType == 5 || param1.templateInfo.SonType == 329 || param1.templateInfo.SonType == 328 || param1.templateInfo.SonType == 343 || param1.templateInfo.SonType == 344)
               {
                  return true;
               }
               return false;
            }
            if(PetEquipManager.currSelectedPage == "EquipStoreView" && PetEquipManager.currSelectedView == "PetEquipUpgradeView")
            {
               if(param1.templateInfo.MasterType == 5 && param1.templateInfo.Profile >= 3 && param1.templateInfo.Profile <= 5)
               {
                  return true;
               }
               return false;
            }
         }
         return false;
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
            _loc2_ = ComponentFactory.Instance.creatCustomObject("pet.PetBagCell");
            _list.addChild(_loc2_);
            _itemList.push(_loc2_);
            _loc4_++;
         }
         _list.hSpace = 0;
         _list.commitChanges();
         _bagScroll.invalidateViewport();
         return findBagEmputyItem(_loc3_);
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
         if(_itemList)
         {
            _itemList.length = 0;
         }
         _itemList = null;
         removeEvent();
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(_bagBack)
         {
            ObjectUtils.disposeObject(_bagBack);
         }
         _bagBack = null;
         if(_list)
         {
            _list.disposeAllChildren();
            ObjectUtils.disposeObject(_list);
            _list = null;
         }
         if(_bagScroll)
         {
            ObjectUtils.disposeObject(_bagScroll);
         }
         _bagScroll = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

