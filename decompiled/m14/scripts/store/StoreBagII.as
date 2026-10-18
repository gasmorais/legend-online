package store
{
   import bag.events.BagEvent;
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.geom.IntPoint;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import events.StoreEvent;
   import manager.LanguageMgr;
   import mvc.module.armyII.UserArmy;
   import mvc.module.store.StoreModel;
   import yishi.datas.VersionSwitch;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.SimpleDictionary;
   import yishi.view.community.BaseItemView;
   
   public class StoreBagII extends Component
   {
      
      private var _lineImage:MutipleImage;
      
      private var _textBack:Image;
      
      private var _textBack2:Image;
      
      private var _equipText:FilterFrameText;
      
      private var _materialText:FilterFrameText;
      
      private var _equipViewList:SimpleTileList;
      
      private var _equipScroll:ScrollPanel;
      
      private var _defaultCount:int = 18;
      
      private var _columnCount:int = 6;
      
      private var _equipData:Array;
      
      private var _equipList:Vector.<BaseItemView>;
      
      private var _equipDic:SimpleDictionary = new SimpleDictionary(true);
      
      private var _materialViewList:SimpleTileList;
      
      private var _materialScroll:ScrollPanel;
      
      private var _materialData:Array;
      
      private var _materialList:Vector.<BaseItemView>;
      
      private var _materialDic:SimpleDictionary = new SimpleDictionary(true);
      
      private const REFRESHLOCK_TEMPID:int = 208027;
      
      public function StoreBagII()
      {
         super();
         initView();
         initEvent();
         initEquipList();
         initMaterialList();
         refreshData();
      }
      
      private function initView() : void
      {
         _lineImage = ComponentFactory.Instance.creatComponentByStylename("StoreBagII.lineImage");
         _textBack = ComponentFactory.Instance.creatComponentByStylename("StoreBagII.textBack");
         _textBack2 = ComponentFactory.Instance.creatComponentByStylename("StoreBagII.textBack");
         _equipText = ComponentFactory.Instance.creatComponentByStylename("StoreBagII.equipText");
         _materialText = ComponentFactory.Instance.creatComponentByStylename("StoreBagII.materialText");
         _equipViewList = ComponentFactory.Instance.creatCustomObject("StoreBagII.equipViewList",[6]);
         _equipScroll = ComponentFactory.Instance.creatComponentByStylename("StoreBagII.equipScroll");
         _equipScroll.setView(_equipViewList);
         _materialViewList = ComponentFactory.Instance.creatCustomObject("StoreBagII.materialViewList",[6]);
         _materialScroll = ComponentFactory.Instance.creatComponentByStylename("StoreBagII.materialScroll");
         _materialScroll.setView(_materialViewList);
         addChild(_lineImage);
         addChild(_textBack);
         addChild(_textBack2);
         _textBack2.x = -5;
         _textBack2.y = 185;
         addChild(_equipText);
         addChild(_materialText);
         addChild(_equipScroll);
         addChild(_materialScroll);
         _equipText.text = LanguageMgr.GetTranslation("StoreBagII.equipText.text");
      }
      
      private function initEquipList() : void
      {
         var _loc2_:* = 0;
         var _loc1_:BaseItemView = null;
         _equipList = new Vector.<BaseItemView>();
         _equipViewList.beginChanges();
         _loc2_ = 0;
         while(_loc2_ < _defaultCount)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("store.StoreBagCell");
            _loc1_.pos = -1;
            _equipViewList.addChild(_loc1_);
            _equipList.push(_loc1_);
            _loc2_++;
         }
         _equipViewList.hSpace = 3;
         _equipViewList.commitChanges();
         _equipScroll.invalidateViewport();
      }
      
      private function initMaterialList() : void
      {
         var _loc2_:* = 0;
         var _loc1_:BaseItemView = null;
         _materialList = new Vector.<BaseItemView>();
         _materialViewList.beginChanges();
         _loc2_ = 0;
         while(_loc2_ < _defaultCount)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("store.StoreBagCell");
            _loc1_.pos = -1;
            _materialViewList.addChild(_loc1_);
            _materialList.push(_loc1_);
            _loc2_++;
         }
         _materialViewList.hSpace = 3;
         _materialViewList.commitChanges();
         _materialScroll.invalidateViewport();
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
      
      public function refreshData() : void
      {
         var _loc6_:GoodsInfo = null;
         var _loc3_:int = 0;
         var _loc5_:int = 0;
         var _loc7_:int = 0;
         _equipData = [];
         _materialData = [];
         var _loc9_:Array = GoodsManager.instance.getHeroEquipListById(thane.id).getList();
         _loc9_.sort(sortHeroEquip);
         var _loc8_:Array = GoodsManager.instance.getGeneralBagEquipList();
         _loc8_.sort(sortHeroEquip);
         var _loc11_:Array = GoodsManager.instance.getGeneralBagPropList();
         _loc11_.sort(sortByTpye);
         var _loc10_:Array = GoodsManager.instance.getStoreBagPropList();
         _loc10_.sort(sortByTpye);
         var _loc2_:Array = [];
         _loc2_ = _loc2_.concat(_loc9_).concat(_loc8_);
         var _loc1_:Array = [];
         _loc1_ = _loc1_.concat(_loc11_).concat(_loc10_);
         var _loc4_:Array = [];
         _loc4_ = _loc4_.concat(_loc9_).concat(_loc8_).concat(_loc11_).concat(_loc10_);
         _loc3_ = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc6_ = _loc2_[_loc3_] as GoodsInfo;
            if(!(!GoodsManager.instance.isGneralStoreBagGoods(_loc6_) && !GoodsManager.instance.isHeroGoods(uArmy.baseHero ? uArmy.baseHero.id : 0,_loc6_)))
            {
               if(filterGoods(_loc6_))
               {
                  _equipData.push(_loc6_);
               }
            }
            _loc3_++;
         }
         _loc5_ = 0;
         while(_loc5_ < _loc1_.length)
         {
            _loc6_ = _loc1_[_loc5_] as GoodsInfo;
            if(!(!GoodsManager.instance.isGneralStoreBagGoods(_loc6_) && !GoodsManager.instance.isHeroGoods(uArmy.baseHero ? uArmy.baseHero.id : 0,_loc6_)))
            {
               if(filterGoods(_loc6_))
               {
                  if(!(_loc6_.templateId == 2127022 || _loc6_.templateId == 2127021 || _loc6_.templateId == 2127026 || _loc6_.templateId == 2127025))
                  {
                     _materialData.push(_loc6_);
                  }
               }
            }
            _loc5_++;
         }
         if(model.selectedPanel == "STORE_PANEL_RESOLVE")
         {
            _loc7_ = 0;
            while(_loc7_ < _loc4_.length)
            {
               _loc6_ = _loc4_[_loc7_] as GoodsInfo;
               if(!(!GoodsManager.instance.isGneralStoreBagGoods(_loc6_) && !GoodsManager.instance.isHeroGoods(uArmy.baseHero ? uArmy.baseHero.id : 0,_loc6_)))
               {
                  if(filterGoodsEquip(_loc6_))
                  {
                     _equipData.push(_loc6_);
                  }
                  else if(filterGoodsMaterial(_loc6_))
                  {
                     if(!(_loc6_.templateId == 2127022 || _loc6_.templateId == 2127021 || _loc6_.templateId == 2127026 || _loc6_.templateId == 2127025))
                     {
                        _materialData.push(_loc6_);
                     }
                  }
               }
               _loc7_++;
            }
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
         var _loc4_:GoodsInfo = null;
         var _loc3_:int = 0;
         var _loc5_:GoodsInfo = null;
         clearGoods();
         refreshBag();
         var _loc1_:IntPoint = new IntPoint(0,0);
         _loc2_ = 0;
         while(_loc2_ < _equipData.length)
         {
            _loc4_ = _equipData[_loc2_] as GoodsInfo;
            _equipList[_loc2_].bagType = _loc4_.bagType;
            _equipList[_loc2_].pos = _loc4_.pos;
            _equipList[_loc2_].data = _loc4_;
            _equipDic.add(_loc4_.pos + "_" + _loc4_.objectId + "_" + _loc4_.bagType,_equipList[_loc2_]);
            _loc2_++;
         }
         _equipScroll.invalidateViewport();
         _equipScroll.viewPort.viewPosition = _loc1_;
         _loc3_ = 0;
         while(_loc3_ < _materialData.length)
         {
            _loc5_ = _materialData[_loc3_] as GoodsInfo;
            _materialList[_loc3_].bagType = _loc5_.bagType;
            _materialList[_loc3_].pos = _loc5_.pos;
            _materialList[_loc3_].data = _loc5_;
            _materialDic.add(_loc5_.pos + "_" + _loc5_.objectId + "_" + _loc5_.bagType,_materialList[_loc3_]);
            _loc3_++;
         }
         _materialScroll.invalidateViewport();
         _materialScroll.viewPort.viewPosition = _loc1_;
         _materialText.text = LanguageMgr.GetTranslation("StoreBagII.materialText.text." + model.selectedPanel);
         if(model.selectedPanel == "STORE_PANEL_RESOLVE")
         {
            _materialScroll.height = 130;
            _equipText.text = LanguageMgr.GetTranslation("rewardsFindBackFrame.items");
         }
         else
         {
            _materialScroll.height = 140;
            _equipText.text = LanguageMgr.GetTranslation("StoreBagII.equipText.text");
         }
      }
      
      public function clearGoods() : void
      {
         for each(var _loc1_:BaseItemView in _equipDic)
         {
            _loc1_.data = null;
            _loc1_.pos = -1;
         }
         for each(var _loc2_:BaseItemView in _materialDic)
         {
            _loc2_.data = null;
            _loc2_.pos = -1;
         }
         _equipDic.clear();
         _materialDic.clear();
      }
      
      private function refreshBag() : void
      {
         var _loc3_:int = _columnCount * (int((_equipData.length + _columnCount - 1) / _columnCount));
         var _loc1_:int = _loc3_ < _defaultCount ? _defaultCount : _loc3_;
         if(_equipList.length < _loc1_)
         {
            addItems(_loc1_ - _equipList.length,1);
         }
         else if(_equipList.length > _loc1_ && _equipList.length > _defaultCount)
         {
            removeItems(_equipList.length - _loc1_,1);
         }
         var _loc4_:int = _columnCount * (int((_materialData.length + _columnCount - 1) / _columnCount));
         var _loc2_:int = _loc4_ < _defaultCount ? _defaultCount : _loc4_;
         if(_materialList.length < _loc2_)
         {
            addItems(_loc2_ - _materialList.length,2);
         }
         else if(_materialList.length > _loc2_ && _materialList.length > _defaultCount)
         {
            removeItems(_materialList.length - _loc2_,2);
         }
      }
      
      private function removeItems(param1:int, param2:int) : void
      {
         var _loc5_:int = 0;
         var _loc3_:BaseItemView = null;
         var _loc6_:int = 0;
         var _loc4_:BaseItemView = null;
         if(param2 == 1)
         {
            _equipViewList.beginChanges();
            _loc5_ = 0;
            while(_loc5_ < param1)
            {
               _loc3_ = _equipList.pop();
               _equipViewList.removeChild(_loc3_);
               _loc3_.dispose();
               _loc5_++;
            }
            _equipViewList.commitChanges();
            _equipScroll.invalidateViewport();
         }
         else
         {
            _materialViewList.beginChanges();
            _loc6_ = 0;
            while(_loc6_ < param1)
            {
               _loc4_ = _materialList.pop();
               _materialViewList.removeChild(_loc4_);
               _loc4_.dispose();
               _loc6_++;
            }
            _materialViewList.commitChanges();
            _materialScroll.invalidateViewport();
         }
      }
      
      private function addItems(param1:int, param2:int) : void
      {
         var _loc5_:int = 0;
         var _loc3_:BaseItemView = null;
         var _loc6_:int = 0;
         var _loc4_:BaseItemView = null;
         if(param2 == 1)
         {
            _equipViewList.beginChanges();
            _loc5_ = 0;
            while(_loc5_ < param1)
            {
               _loc3_ = ComponentFactory.Instance.creatCustomObject("store.StoreBagCell");
               _loc3_.pos = -1;
               _equipViewList.addChild(_loc3_);
               _equipList.push(_loc3_);
               _loc5_++;
            }
            _equipViewList.commitChanges();
            _equipScroll.invalidateViewport();
         }
         else
         {
            _materialViewList.beginChanges();
            _loc6_ = 0;
            while(_loc6_ < param1)
            {
               _loc4_ = ComponentFactory.Instance.creatCustomObject("store.StoreBagCell");
               _loc4_.pos = -1;
               _materialViewList.addChild(_loc4_);
               _materialList.push(_loc4_);
               _loc6_++;
            }
            _materialViewList.commitChanges();
            _materialScroll.invalidateViewport();
         }
      }
      
      private function addEquipItem(param1:GoodsInfo) : void
      {
         var _loc2_:BaseItemView = null;
         var _loc3_:Boolean = false;
         if(model.selectedPanel == "STORE_PANEL_RESOLVE")
         {
            if(filterGoodsEquip(param1))
            {
               _loc3_ = true;
            }
         }
         else if(filterGoods(param1) && param1.templateInfo.MasterType == 1)
         {
            _loc3_ = true;
         }
         if(_loc3_ && _equipData)
         {
            _loc2_ = findEquipEmputyItem(_equipData.length);
            _loc2_.bagType = param1.bagType;
            _loc2_.pos = param1.pos;
            _loc2_.data = param1;
            _equipDic.add(param1.pos + "_" + param1.objectId + "_" + param1.bagType,_loc2_);
         }
      }
      
      private function addMaterialItem(param1:GoodsInfo) : void
      {
         var _loc2_:BaseItemView = null;
         var _loc3_:Boolean = false;
         if(model.selectedPanel == "STORE_PANEL_RESOLVE")
         {
            if(filterGoodsMaterial(param1))
            {
               _loc3_ = true;
            }
         }
         else if(filterGoods(param1) && param1.templateInfo.MasterType == 2)
         {
            if(param1.templateId != 2127022 && param1.templateId != 2127021 && param1.templateId != 2127026 && param1.templateId != 2127025)
            {
               _loc3_ = true;
            }
         }
         if(_loc3_ && _materialData)
         {
            _loc2_ = findMaterialEmputyItem(_materialData.length);
            _loc2_.bagType = param1.bagType;
            _loc2_.pos = param1.pos;
            _loc2_.data = param1;
            _materialDic.add(param1.pos + "_" + param1.objectId + "_" + param1.bagType,_loc2_);
         }
      }
      
      public function moveItem(param1:GoodsInfo) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(param1 == null)
         {
            return;
         }
         if(!filterGoods(param1))
         {
            return;
         }
         if(param1.templateInfo.MasterType == 1 && _equipList && _equipData)
         {
            _loc2_ = 0;
            while(_loc2_ < _equipList.length)
            {
               if(_equipList[_loc2_].data == param1 && _equipList[_loc2_].icon)
               {
                  _equipList[_loc2_].icon.dispatchEvent(new InteractiveEvent("interactive_double_click"));
               }
               _loc2_++;
            }
         }
         else if(param1.templateInfo.MasterType == 2 && _materialList && _materialData)
         {
            _loc3_ = 0;
            while(_loc3_ < _materialList.length)
            {
               if(_materialList[_loc3_].data == param1 && _materialList[_loc3_].icon)
               {
                  _materialList[_loc3_].icon.dispatchEvent(new InteractiveEvent("interactive_double_click"));
               }
               _loc3_++;
            }
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
      
      public function findEquipEmputyItem(param1:int = 0) : BaseItemView
      {
         var _loc2_:BaseItemView = null;
         var _loc4_:* = 0;
         var _loc3_:int = param1;
         _loc3_;
         while(_loc3_ < _equipList.length)
         {
            if(!_equipList[_loc3_].data)
            {
               return _equipList[_loc3_];
            }
            _loc3_++;
         }
         _loc4_ = 0;
         while(_loc4_ < _columnCount)
         {
            _loc2_ = ComponentFactory.Instance.creatCustomObject("store.StoreBagCell");
            _equipViewList.addChild(_loc2_);
            _equipList.push(_loc2_);
            _loc4_++;
         }
         _equipViewList.hSpace = 3;
         _equipViewList.commitChanges();
         _equipScroll.invalidateViewport();
         return findEquipEmputyItem(_loc3_);
      }
      
      public function findMaterialEmputyItem(param1:int = 0) : BaseItemView
      {
         var _loc2_:BaseItemView = null;
         var _loc4_:* = 0;
         var _loc3_:int = param1;
         _loc3_;
         while(_loc3_ < _materialList.length)
         {
            if(!_materialList[_loc3_].data)
            {
               return _materialList[_loc3_];
            }
            _loc3_++;
         }
         _loc4_ = 0;
         while(_loc4_ < _columnCount)
         {
            _loc2_ = ComponentFactory.Instance.creatCustomObject("store.StoreBagCell");
            _materialViewList.addChild(_loc2_);
            _materialList.push(_loc2_);
            _loc4_++;
         }
         _materialViewList.hSpace = 3;
         _materialViewList.commitChanges();
         _materialScroll.invalidateViewport();
         return findMaterialEmputyItem(_loc3_);
      }
      
      public function defaultView() : void
      {
         refreshData();
         refreshView();
      }
      
      private function __selectedPanelChangeHandler(param1:StoreEvent) : void
      {
         defaultView();
      }
      
      private function __bagItemDeleteHandler(param1:BagEvent) : void
      {
         var _loc2_:BaseItemView = null;
         var _loc3_:GoodsInfo = param1.info;
         if(_equipDic[_loc3_.pos + "_" + _loc3_.objectId + "_" + _loc3_.bagType])
         {
            _loc2_ = _equipDic[_loc3_.pos + "_" + _loc3_.objectId + "_" + _loc3_.bagType];
         }
         else if(_materialDic[_loc3_.pos + "_" + _loc3_.objectId + "_" + _loc3_.bagType])
         {
            _loc2_ = _materialDic[_loc3_.pos + "_" + _loc3_.objectId + "_" + _loc3_.bagType];
         }
         if(_loc2_)
         {
            _loc2_.data = null;
         }
      }
      
      private function __bagItemUpdateHandler(param1:BagEvent) : void
      {
         var _loc2_:BaseItemView = null;
         var _loc3_:GoodsInfo = param1.info;
         if(_loc3_.bagType == 0)
         {
            return;
         }
         if(model.selectedPanel != "STORE_PANEL_RESOLVE" && !filterGoods(_loc3_))
         {
            return;
         }
         if(_equipDic[_loc3_.pos + "_" + _loc3_.objectId + "_" + _loc3_.bagType])
         {
            _loc2_ = _equipDic[_loc3_.pos + "_" + _loc3_.objectId + "_" + _loc3_.bagType];
         }
         else if(_materialDic[_loc3_.pos + "_" + _loc3_.objectId + "_" + _loc3_.bagType])
         {
            _loc2_ = _materialDic[_loc3_.pos + "_" + _loc3_.objectId + "_" + _loc3_.bagType];
         }
         if(_loc2_)
         {
            _loc2_.data = _loc3_;
         }
         else
         {
            addEquipItem(_loc3_);
            addMaterialItem(_loc3_);
         }
      }
      
      private function filterGoodsEquip(param1:GoodsInfo) : Boolean
      {
         var _loc2_:Boolean = false;
         if(param1.templateInfo.MasterType == 5)
         {
            return false;
         }
         if(param1.templateInfo.MasterType == 6)
         {
            return false;
         }
         if(param1.templateInfo.MasterType == 1 && param1.templateInfo.Profile < 6 && param1.templateInfo.Refresh != 0 && (param1.templateInfo.SonType >= 101 && param1.templateInfo.SonType <= 108) && param1.objectId != ArmyManager.instance.thane.id)
         {
            return true;
         }
         if(param1.templateInfo.SonType == 228 || param1.templateInfo.SonType == 343 || param1.templateInfo.SonType == 344 || param1.templateInfo.SonType == 626)
         {
            return true;
         }
         return _loc2_;
      }
      
      private function filterGoodsMaterial(param1:GoodsInfo) : Boolean
      {
         if(param1.templateInfo.MasterType == 5)
         {
            return false;
         }
         if(param1.templateInfo.MasterType == 6)
         {
            return false;
         }
         if(param1.templateId == 6260001)
         {
            return true;
         }
         if(param1.templateInfo.SonType == 215)
         {
            return true;
         }
         if(checkIsResolveMaterial(param1))
         {
            return true;
         }
         return false;
      }
      
      private function checkIsResolveMaterial(param1:GoodsInfo) : Boolean
      {
         for each(var _loc2_:GoodsTemplateInfo in TempleteManager.instance.goodsTemplateCate.getTemplates())
         {
            if(!(_loc2_.SonType != 228 && _loc2_.SonType != 343 && _loc2_.SonType != 344))
            {
               if(param1.templateId == _loc2_.Property5 || param1.templateId == _loc2_.Property6)
               {
                  return true;
               }
            }
         }
         return false;
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
            else if(model.selectedPanel == "STORE_PANEL_SWITCH")
            {
               if(param1.templateInfo.TransformId > 0 && param1.templateInfo.SonType != 343 && param1.templateInfo.SonType != 344)
               {
                  return true;
               }
            }
            else if(model.selectedPanel == "STORE_PANEL_CAST")
            {
               if(VersionSwitch.SPEASAL_CAST && [1170006,1170007,1170008,1170009,1180006,1180007,1180008,1180009].indexOf(param1.templateId) != -1)
               {
                  return false;
               }
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
               if(param1.templateId == 2120106)
               {
                  return true;
               }
               if(param1.templateId == 2120107)
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
         return false;
      }
      
      private function get model() : StoreModel
      {
         return FrameControllerManager.instance.storeController.model;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function get uArmy() : UserArmy
      {
         return ArmyManager.instance.army;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_lineImage);
         _lineImage = null;
         ObjectUtils.disposeObject(_textBack);
         _textBack = null;
         ObjectUtils.disposeObject(_textBack2);
         _textBack2 = null;
         ObjectUtils.disposeObject(_equipText);
         _equipText = null;
         ObjectUtils.disposeObject(_materialText);
         _materialText = null;
         for each(var _loc1_:BaseItemView in _equipList)
         {
            ObjectUtils.disposeObject(_loc1_);
            _loc1_ = null;
         }
         for each(var _loc2_:BaseItemView in _materialList)
         {
            ObjectUtils.disposeObject(_loc2_);
            _loc2_ = null;
         }
         ObjectUtils.disposeObject(_equipViewList);
         _equipViewList = null;
         ObjectUtils.disposeObject(_materialViewList);
         _materialViewList = null;
         ObjectUtils.disposeObject(_equipScroll);
         _equipScroll = null;
         ObjectUtils.disposeObject(_materialScroll);
         _materialScroll = null;
         super.dispose();
      }
   }
}

