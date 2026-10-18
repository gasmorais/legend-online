package cell.view.fashionbag
{
   import bag.events.BagEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.store.StoreRspMsg;
   import events.FashionEvent;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import mvc.module.armyII.UserArmy;
   import mvc.module.fashion.FashionModel;
   import yishi.comm.PackageIn;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.TempleteManager;
   import yishi.service.managers.SocketManager;
   import yishi.utils.SimpleDictionary;
   import yishi.view.community.BaseItemView;
   
   public class FashionBag extends Sprite implements Disposeable
   {
      
      private var _preBtn:BaseButton;
      
      private var _nextBtn:BaseButton;
      
      private var _pageBack:Bitmap;
      
      private var _pageText:FilterFrameText;
      
      private var _list:SimpleTileList;
      
      private var _defaultCount:int;
      
      private var _rowCount:int;
      
      private var _columnCount:int;
      
      private var _data:Array;
      
      private var _itemList:Vector.<BaseItemView>;
      
      private var _itemDic:SimpleDictionary = new SimpleDictionary(true);
      
      private var _startIndex:int;
      
      private var _currentPage:int = 1;
      
      private var _totalPage:int = 1;
      
      private var _clearData:Boolean = true;
      
      private var _deleteDic:SimpleDictionary = new SimpleDictionary(true);
      
      public function FashionBag(param1:int, param2:int)
      {
         super();
         _rowCount = param1;
         _columnCount = param2;
         _defaultCount = _rowCount * _columnCount;
         initView();
         initEvent();
      }
      
      private function get model() : FashionModel
      {
         return FrameControllerManager.instance.fashionCodeController.model;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function get userArmy() : UserArmy
      {
         return ArmyManager.instance.army;
      }
      
      private function initView() : void
      {
         _preBtn = ComponentFactory.Instance.creatComponentByStylename("fashionStoreFrame.preBtn");
         _nextBtn = ComponentFactory.Instance.creatComponentByStylename("fashionStoreFrame.nextBtn");
         _pageBack = ComponentFactory.Instance.creatBitmap("asset.core.PageNumBack");
         _pageText = ComponentFactory.Instance.creatComponentByStylename("fashionStoreFrame.pageText");
         _list = ComponentFactory.Instance.creatCustomObject("store.SimpleTileList",[7]);
         addChild(_list);
         _list.hSpace = 0;
         addChild(_preBtn);
         addChild(_nextBtn);
         addChild(_pageBack);
         _pageBack.x = 127;
         _pageBack.y = 95;
         addChild(_pageText);
         _pageText.text = "1/5";
         initList();
         if(model.scene == "SHOP_SCENE")
         {
            refreshData();
            refreshView();
         }
      }
      
      private function initList() : void
      {
         var _loc2_:int = 0;
         var _loc1_:FashionBagCell = null;
         if(_rowCount > 0 && _columnCount > 0)
         {
            _itemList = new Vector.<BaseItemView>();
            _list.beginChanges();
            _loc2_ = 0;
            while(_loc2_ < _defaultCount)
            {
               _loc1_ = ComponentFactory.Instance.creatCustomObject("fashion.fashionBagCell");
               _loc1_.bagType = 1;
               _loc1_.pos = -1;
               _loc1_.moveType = "TRY_ON";
               _list.addChild(_loc1_);
               _itemList.push(_loc1_);
               _loc2_++;
            }
            _list.commitChanges();
         }
      }
      
      public function refreshData() : void
      {
         var _loc3_:GoodsInfo = null;
         var _loc2_:int = 0;
         _data = [];
         _itemDic.clear();
         _deleteDic.clear();
         var _loc4_:Array = model.fashionList;
         var _loc1_:Boolean = false;
         _loc2_ = 0;
         while(_loc2_ < _loc4_.length)
         {
            _loc3_ = _loc4_[_loc2_] as GoodsInfo;
            if(!GoodsManager.instance.isGneralBagGoods(_loc3_) && !GoodsManager.instance.isHeroGoods(userArmy.baseHero ? userArmy.baseHero.id : 0,_loc3_))
            {
               if(model.scene != "SHOP_SCENE")
               {
                  _loc1_ = true;
               }
            }
            else if(!(_loc3_.templateInfo.Property5 != 1 && _loc3_.templateId != 208020 && fashionModel.selectedPanel == "FASHION_SWITCH_PANEL"))
            {
               if(model.scene == "SHOP_SCENE")
               {
                  _data.push(_loc3_);
               }
               else
               {
                  _data.push(_loc3_);
               }
            }
            _loc2_++;
         }
         _data.sort(sortFashionBag);
         if(_loc1_)
         {
            _data.splice(0,0,null);
         }
         if(_data.length <= _defaultCount)
         {
            _totalPage = 1;
         }
         else if(_data.length % _defaultCount == 0)
         {
            _totalPage = _data.length / _defaultCount;
         }
         else
         {
            _totalPage = _data.length / _defaultCount + 1;
         }
      }
      
      private function isFashionSoul(param1:int) : Boolean
      {
         return 208020 == param1;
      }
      
      private function get fashionModel() : FashionModel
      {
         return FrameControllerManager.instance.fashionCodeController.model;
      }
      
      private function sortFashionBag(param1:GoodsInfo, param2:GoodsInfo) : int
      {
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         if(model.isFashion(param1) && !model.isFashion(param2))
         {
            return 1;
         }
         if(!model.isFashion(param1) && model.isFashion(param2))
         {
            return -1;
         }
         if(!model.isFashion(param1) && !model.isFashion(param2))
         {
            return 0;
         }
         if(param1.bagType == 4 && param2.bagType != 4)
         {
            return -1;
         }
         if(param1.bagType != 4 && param2.bagType == 4)
         {
            return 1;
         }
         if(param1.isBinds && !param2.isBinds)
         {
            return 1;
         }
         if(!param1.isBinds && param2.isBinds)
         {
            return -1;
         }
         _loc4_ = getFashionLevelByInfo(param1);
         _loc3_ = getFashionLevelByInfo(param2);
         if(_loc4_ > _loc3_)
         {
            return 1;
         }
         if(_loc4_ < _loc3_)
         {
            return -1;
         }
         if(param1.templateId > param2.templateId)
         {
            return -1;
         }
         if(param1.templateId < param2.templateId)
         {
            return 1;
         }
         return 0;
      }
      
      private function getFashionLevelByInfo(param1:GoodsInfo) : int
      {
         if(!param1)
         {
            return 0;
         }
         if(param1.templateId == 208020)
         {
            return 1;
         }
         if(param1.templateId == 208021)
         {
            return 1;
         }
         var _loc2_:int = param1.randomSkill1;
         if(!TempleteManager.instance.getSkillTemplateInfoById(param1.randomSkill1))
         {
            _loc2_ = int(param1.templateInfo.DefaultSkill.split(",")[0]);
         }
         return TempleteManager.instance.getSkillTemplateInfoById(_loc2_).Grades;
      }
      
      public function refreshView() : void
      {
         var _loc1_:int = 0;
         var _loc2_:GoodsInfo = null;
         refreshBag();
         _loc1_ = 0;
         while(_loc1_ < _defaultCount)
         {
            _loc2_ = _data[_startIndex + _loc1_];
            if(!_loc2_)
            {
               _itemList[_loc1_].pos = -1;
               _itemList[_loc1_].data = null;
            }
            else if(_deleteDic[_loc2_.pos + "_" + _loc2_.objectId + "_" + _loc2_.bagType])
            {
               _itemList[_loc1_].bagType = 1;
               _itemList[_loc1_].pos = -1;
               _itemList[_loc1_].data = null;
            }
            else
            {
               _itemList[_loc1_].bagType = _loc2_.bagType;
               _itemList[_loc1_].pos = _loc2_.pos;
               _itemList[_loc1_].data = _loc2_;
               _itemDic[_currentPage + "_" + _loc2_.pos + "_" + _loc2_.objectId + "_" + _loc2_.bagType] = _itemList[_loc1_];
            }
            _loc1_++;
         }
         if(_currentPage <= 1)
         {
            _preBtn.enable = false;
         }
         else
         {
            _preBtn.enable = true;
         }
         if(_currentPage >= _totalPage)
         {
            _nextBtn.enable = false;
         }
         else
         {
            _nextBtn.enable = true;
         }
         _pageText.text = _currentPage + "/" + _totalPage;
      }
      
      private function refreshBag() : void
      {
         if(_itemList.length < _defaultCount)
         {
            addItems(_defaultCount - _itemList.length);
         }
      }
      
      private function addItems(param1:int) : void
      {
         var _loc3_:int = 0;
         var _loc2_:FashionBagCell = null;
         _list.beginChanges();
         _loc3_ = 0;
         while(_loc3_ < param1)
         {
            _loc2_ = ComponentFactory.Instance.creatCustomObject("fashion.fashionBagCell");
            _loc2_.pos = -1;
            _loc2_.bagType = 1;
            _loc2_.moveType = "TRY_ON";
            _list.addChild(_loc2_);
            _itemList.push(_loc2_);
            _loc3_++;
         }
         _list.commitChanges();
      }
      
      private function initEvent() : void
      {
         GoodsManager.instance.addEventListener("UPDATE_BAG",__bagItemUpdateHandler);
         GoodsManager.instance.addEventListener("DELETE_BAG",__bagItemDeleteHandler);
         model.addEventListener("FASHION_STORE_CHANGE",__selectedChangeHandler);
         model.addEventListener("REFRESH_BAG",__refreshHandler);
         if(_preBtn)
         {
            _preBtn.addEventListener("click",__preHandler);
         }
         if(_nextBtn)
         {
            _nextBtn.addEventListener("click",__nextHandler);
         }
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4487,__onComposeCallback);
      }
      
      protected function __nextHandler(param1:MouseEvent) : void
      {
         if(_currentPage >= _totalPage)
         {
            return;
         }
         _startIndex = _defaultCount * _currentPage;
         _currentPage += 1;
         refreshView();
      }
      
      protected function __preHandler(param1:MouseEvent) : void
      {
         if(_currentPage <= 1)
         {
            return;
         }
         _startIndex = _defaultCount * (_currentPage - 2);
         _currentPage -= 1;
         refreshView();
      }
      
      private function removeEvent() : void
      {
         GoodsManager.instance.removeEventListener("UPDATE_BAG",__bagItemUpdateHandler);
         GoodsManager.instance.removeEventListener("DELETE_BAG",__bagItemDeleteHandler);
         model.removeEventListener("FASHION_STORE_CHANGE",__selectedChangeHandler);
         model.removeEventListener("REFRESH_BAG",__refreshHandler);
         if(_preBtn)
         {
            _preBtn.removeEventListener("click",__preHandler);
         }
         if(_nextBtn)
         {
            _nextBtn.removeEventListener("click",__nextHandler);
         }
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4487,__onComposeCallback);
      }
      
      protected function __refreshHandler(param1:FashionEvent) : void
      {
         refreshData();
         refreshView();
      }
      
      protected function __onComposeCallback(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:StoreRspMsg = new StoreRspMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as StoreRspMsg;
         if(!_loc2_.composeResult)
         {
            return;
         }
         refreshData();
         refreshView();
      }
      
      public function __selectedChangeHandler(param1:FashionEvent) : void
      {
         refreshData();
         refreshView();
      }
      
      private function __bagItemUpdateHandler(param1:BagEvent) : void
      {
         var _loc4_:String = null;
         var _loc2_:FashionBagCell = null;
         var _loc3_:int = 0;
         var _loc5_:GoodsInfo = param1.info;
         if(_loc5_ && !fashionModel.isFashion(_loc5_) && _loc5_.templateId != 208020 && _loc5_.templateId != 208021)
         {
            return;
         }
         if(_loc5_)
         {
            if(_loc5_.bagType == 0)
            {
               return;
            }
            _loc4_ = _loc5_.pos + "_" + _loc5_.objectId + "_" + _loc5_.bagType;
            _deleteDic.del(_loc5_.pos + "_" + _loc5_.objectId + "_" + _loc5_.bagType);
            delete _deleteDic[_loc5_.pos + "_" + _loc5_.objectId + "_" + _loc5_.bagType];
            _loc2_ = _itemDic[_currentPage + "_" + _loc5_.pos + "_" + _loc5_.objectId + "_" + _loc5_.bagType];
            if(_loc2_)
            {
               _loc2_.bagType = _loc5_.bagType;
               _loc2_.pos = _loc5_.pos;
               _loc2_.data = _loc5_;
            }
            else
            {
               if(_loc5_.templateId == 208020)
               {
                  _loc3_ = _data.indexOf(null);
                  if(_loc3_ != -1)
                  {
                     _data[_loc3_] = _loc5_;
                  }
               }
               refreshData();
               refreshView();
            }
         }
      }
      
      private function __bagItemDeleteHandler(param1:BagEvent) : void
      {
         var _loc2_:FashionBagCell = null;
         var _loc3_:GoodsInfo = param1.info;
         if(_loc3_)
         {
            if(_loc3_.pos == 0 && _loc3_.objectId == 0 && _loc3_.bagType == 0)
            {
               return;
            }
            _deleteDic[_loc3_.pos + "_" + _loc3_.objectId + "_" + _loc3_.bagType] = _loc3_;
            _loc2_ = _itemDic[_currentPage + "_" + _loc3_.pos + "_" + _loc3_.objectId + "_" + _loc3_.bagType];
            if(_loc2_)
            {
               _loc2_.bagType = 1;
               _loc2_.pos = -1;
               _loc2_.data = null;
            }
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         for each(var _loc1_:BaseItemView in _itemList)
         {
            _loc1_.dispose();
            _loc1_ = null;
         }
         _itemList = null;
         if(_itemDic)
         {
            _itemDic.clear();
         }
         _itemDic = null;
         if(_deleteDic)
         {
            _deleteDic.clear();
         }
         _deleteDic = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

