package theseus.war
{
   import bag.events.BagEvent;
   import com.pickgliss.geom.IntPoint;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import manager.LanguageMgr;
   import managers.TheseussoulManager;
   import mvc.module.theseus.TheseusWarsoulItemInfo;
   import theseus.war.view.TheseusWarsoulBagView;
   import yishi.datas.goods.GoodsInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.GoodsManager;
   import yishi.manager.NotificationManager;
   import yishi.utils.SimpleDictionary;
   import yishi.view.community.BaseItemView;
   
   public class TheseusWarInSBag extends Sprite
   {
      
      private var _tabHbox:HBox;
      
      private var _buttonGroup:SelectedButtonGroup;
      
      private var _tab1Btn:SelectedButton;
      
      private var _tab2Btn:SelectedButton;
      
      private var _tab3Btn:SelectedButton;
      
      private var _titleBg:Bitmap;
      
      private var _defaultCount:int = 18;
      
      private var _columnCount:int = 6;
      
      private var _equipScroll:ScrollPanel;
      
      private var _equipBag:TheseusWarsoulBagView;
      
      private var _materialViewList:SimpleTileList;
      
      private var _materialScroll:ScrollPanel;
      
      private var _materialData:Array = [];
      
      private var _materialList:Vector.<BaseItemView>;
      
      private var _materialDic:SimpleDictionary = new SimpleDictionary(true);
      
      private var _metrialTitle:FilterFrameText;
      
      private var _mainTabType:String;
      
      public function TheseusWarInSBag()
      {
         super();
         initView();
         initEquipList();
         initMaterialList();
         initEvent();
         _buttonGroup.selectIndex = 0;
      }
      
      private function initView() : void
      {
         _titleBg = ComponentFactory.Instance.creatBitmap("asset.theseus.intensify.bagLine");
         _equipScroll = ComponentFactory.Instance.creatComponentByStylename("theseus.BagII.equipScroll");
         _metrialTitle = ComponentFactory.Instance.creatComponentByStylename("theseus.BagII.materialTitle");
         _materialViewList = ComponentFactory.Instance.creatCustomObject("theseus.BagII.materialViewList",[6]);
         _materialScroll = ComponentFactory.Instance.creatComponentByStylename("theseus.BagII.materialScroll");
         _materialScroll.setView(_materialViewList);
         _tab1Btn = ComponentFactory.Instance.creatComponentByStylename("theseus.intensifeframe.Tab1Btn");
         _tab2Btn = ComponentFactory.Instance.creatComponentByStylename("theseus.intensifeframe.Tab2Btn");
         _tab3Btn = ComponentFactory.Instance.creatComponentByStylename("theseus.intensifeframe.Tab3Btn");
         _tabHbox = ComponentFactory.Instance.creatComponentByStylename("theseus.intensifeframe.TabHbox");
         addChild(_tabHbox);
         addChild(_titleBg);
         _tabHbox.beginChanges();
         _tabHbox.addChild(_tab1Btn);
         _tabHbox.addChild(_tab2Btn);
         _tabHbox.addChild(_tab3Btn);
         _tabHbox.commitChanges();
         addChild(_equipScroll);
         addChild(_materialScroll);
         addChild(_metrialTitle);
         _buttonGroup = new SelectedButtonGroup();
         _buttonGroup.addSelectItem(_tab1Btn);
         _buttonGroup.addSelectItem(_tab2Btn);
         _buttonGroup.addSelectItem(_tab3Btn);
      }
      
      private function initEquipList() : void
      {
         _equipBag = new TheseusWarsoulBagView(6,11,1);
         _equipBag.updateVSpace(-4);
         _equipScroll.setView(_equipBag);
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
            _loc1_ = ComponentFactory.Instance.creatCustomObject("theseus.metrialBagCell");
            _loc1_.pos = -1;
            _materialViewList.addChild(_loc1_);
            _materialList.push(_loc1_);
            _loc2_++;
         }
         _materialViewList.hSpace = 3;
         _materialViewList.commitChanges();
         _materialScroll.invalidateViewport();
      }
      
      private function refreshView() : void
      {
         var _loc2_:int = 0;
         var _loc3_:GoodsInfo = null;
         clearGoods();
         refreshBag();
         var _loc1_:IntPoint = new IntPoint(0,0);
         _loc2_ = 0;
         while(_loc2_ < _materialData.length)
         {
            _loc3_ = _materialData[_loc2_] as GoodsInfo;
            _materialList[_loc2_].bagType = _loc3_.bagType;
            _materialList[_loc2_].pos = _loc3_.pos;
            _materialList[_loc2_].data = _loc3_;
            _materialDic.add(_loc3_.pos + "_" + _loc3_.objectId + "_" + _loc3_.bagType,_materialList[_loc2_]);
            _loc2_++;
         }
         _materialScroll.invalidateViewport();
         _materialScroll.viewPort.viewPosition = _loc1_;
      }
      
      public function clearGoods() : void
      {
         for each(var _loc1_:BaseItemView in _materialDic)
         {
            _loc1_.data = null;
            _loc1_.pos = -1;
         }
         _materialDic.clear();
      }
      
      private function refreshBag() : void
      {
         var _loc2_:int = _columnCount * (int((_materialData.length + _columnCount - 1) / _columnCount));
         var _loc1_:int = _loc2_ < _defaultCount ? _defaultCount : _loc2_;
         if(_materialList.length < _loc1_)
         {
            addItems(_loc1_ - _materialList.length);
         }
         else if(_materialList.length > _loc1_ && _materialList.length > _defaultCount)
         {
            removeItems(_materialList.length - _loc1_);
         }
      }
      
      private function removeItems(param1:int) : void
      {
         var _loc3_:int = 0;
         var _loc2_:BaseItemView = null;
         _materialViewList.beginChanges();
         _loc3_ = 0;
         while(_loc3_ < param1)
         {
            _loc2_ = _materialList.pop();
            _materialViewList.removeChild(_loc2_);
            _loc2_.dispose();
            _loc3_++;
         }
         _materialViewList.commitChanges();
         _materialScroll.invalidateViewport();
      }
      
      private function addItems(param1:int) : void
      {
         var _loc3_:int = 0;
         var _loc2_:BaseItemView = null;
         _materialViewList.beginChanges();
         _loc3_ = 0;
         while(_loc3_ < param1)
         {
            _loc2_ = ComponentFactory.Instance.creatCustomObject("theseus.metrialBagCell");
            _loc2_.pos = -1;
            _materialViewList.addChild(_loc2_);
            _materialList.push(_loc2_);
            _loc3_++;
         }
         _materialViewList.commitChanges();
         _materialScroll.invalidateViewport();
      }
      
      private function initEvent() : void
      {
         _buttonGroup.addEventListener("change",__onTabBtnHandler);
         NotificationManager.instance.addEventListener("Event.theseusInsPutIn",cellChangeInHandler);
         NotificationManager.instance.addEventListener("Event.theseusInsPutOut",cellChangeOutHandler);
         NotificationManager.instance.addEventListener("Event.theseusWarReset",resetChangeHandler);
         NotificationManager.instance.addEventListener("Evt.warsoulOut",warsoulOutHandler);
         NotificationManager.instance.addEventListener("Evt.warsoulIn",warsoulInHandler);
         TheseussoulManager.Instance.addEventListener("EVENT_WAR_EQUIP",listChangeHandler);
         GoodsManager.instance.addEventListener("UPDATE_BAG",__bagItemUpdateHandler);
         GoodsManager.instance.addEventListener("DELETE_BAG",__bagItemDeleteHandler);
      }
      
      private function removeEvent() : void
      {
         _buttonGroup.removeEventListener("change",__onTabBtnHandler);
         NotificationManager.instance.removeEventListener("Event.theseusInsPutIn",cellChangeInHandler);
         NotificationManager.instance.removeEventListener("Event.theseusInsPutOut",cellChangeOutHandler);
         NotificationManager.instance.removeEventListener("Event.theseusWarReset",resetChangeHandler);
         NotificationManager.instance.removeEventListener("Evt.warsoulOut",warsoulOutHandler);
         NotificationManager.instance.removeEventListener("Evt.warsoulIn",warsoulInHandler);
         TheseussoulManager.Instance.removeEventListener("EVENT_WAR_EQUIP",listChangeHandler);
         GoodsManager.instance.removeEventListener("UPDATE_BAG",__bagItemUpdateHandler);
         GoodsManager.instance.removeEventListener("DELETE_BAG",__bagItemDeleteHandler);
      }
      
      private function warsoulInHandler(param1:NotificationEvent) : void
      {
         var _loc6_:TheseusWarsoulItemInfo = null;
         var _loc5_:Array = null;
         var _loc2_:int = 0;
         var _loc4_:GoodsInfo = null;
         var _loc3_:int = 0;
         if(_mainTabType == "jn")
         {
            _loc6_ = TheseussoulManager.Instance.warsoulModel.currInsSelectInfo;
            if(_loc6_)
            {
               _loc5_ = GoodsManager.instance.getGoodsBySontypeFromBagType(763,1);
               _materialData.length = 0;
               _loc2_ = int(_loc5_.length);
               _loc3_ = 0;
               while(_loc3_ < _loc2_)
               {
                  _loc4_ = _loc5_[_loc3_];
                  if(_loc4_.templateInfo.Property2 == _loc6_.warTempInfo.Rank)
                  {
                     _materialData.push(_loc4_);
                  }
                  _loc3_++;
               }
               refreshView();
            }
         }
      }
      
      private function warsoulOutHandler(param1:NotificationEvent) : void
      {
         if(_mainTabType == "jn")
         {
            _materialData = GoodsManager.instance.getGoodsBySontypeFromBagType(763,1);
            refreshView();
         }
      }
      
      private function __bagItemUpdateHandler(param1:BagEvent) : void
      {
         var _loc2_:BaseItemView = null;
         var _loc4_:Boolean = false;
         var _loc3_:TheseusWarsoulItemInfo = null;
         var _loc5_:GoodsInfo = param1.info;
         if(_loc5_.bagType == 0)
         {
            return;
         }
         if(_materialDic[_loc5_.pos + "_" + _loc5_.objectId + "_" + _loc5_.bagType])
         {
            _loc2_ = _materialDic[_loc5_.pos + "_" + _loc5_.objectId + "_" + _loc5_.bagType];
         }
         if(_loc2_)
         {
            _loc2_.data = _loc5_;
         }
         else
         {
            _loc4_ = false;
            switch(_mainTabType)
            {
               case "qh":
               case "sx":
               case "gz":
               case "xl":
                  break;
               case "jn":
                  _loc3_ = TheseussoulManager.Instance.warsoulModel.currInsSelectInfo;
                  if(_loc3_ == null || _loc5_.templateInfo.Property2 == _loc3_.warTempInfo.Rank)
                  {
                     _loc4_ = true;
                  }
                  break;
               case "fj":
                  _loc4_ = true;
            }
            if(_loc4_)
            {
               addMaterialItem(_loc5_);
            }
         }
      }
      
      private function addMaterialItem(param1:GoodsInfo) : void
      {
         var _loc2_:BaseItemView = null;
         if(param1.templateInfo.SonType == 763 && _mainTabType != "jn")
         {
            return;
         }
         if(_materialData)
         {
            _loc2_ = findMaterialEmputyItem(_materialData.length);
            _loc2_.bagType = param1.bagType;
            _loc2_.pos = param1.pos;
            _loc2_.data = param1;
            _materialDic.add(param1.pos + "_" + param1.objectId + "_" + param1.bagType,_loc2_);
         }
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
            _loc2_ = ComponentFactory.Instance.creatCustomObject("theseus.metrialBagCell");
            _materialViewList.addChild(_loc2_);
            _materialList.push(_loc2_);
            _loc4_++;
         }
         _materialViewList.hSpace = 3;
         _materialViewList.commitChanges();
         _materialScroll.invalidateViewport();
         return findMaterialEmputyItem(_loc3_);
      }
      
      private function __bagItemDeleteHandler(param1:BagEvent) : void
      {
         var _loc2_:BaseItemView = null;
         var _loc3_:GoodsInfo = param1.info;
         _materialDic[_loc3_.pos + "_" + _loc3_.objectId + "_" + _loc3_.bagType];
         _loc2_ = _materialDic[_loc3_.pos + "_" + _loc3_.objectId + "_" + _loc3_.bagType];
         if(_loc2_)
         {
            _loc2_.data = null;
         }
      }
      
      private function listChangeHandler(param1:NotificationEvent) : void
      {
         var _loc2_:int = int(param1.data);
         _equipBag.updateView();
      }
      
      private function cellChangeInHandler(param1:NotificationEvent) : void
      {
         var _loc2_:int = int(param1.data);
         if(_loc2_ > 0)
         {
            _equipBag.cellUpdateView(_loc2_);
         }
      }
      
      private function cellChangeOutHandler(param1:NotificationEvent) : void
      {
         var _loc2_:int = int(param1.data);
         if(_loc2_ > 0)
         {
            _equipBag.cellUpdateView(_loc2_);
         }
      }
      
      private function resetChangeHandler(param1:NotificationEvent) : void
      {
         _equipBag.updateView();
      }
      
      private function __onTabBtnHandler(param1:Event) : void
      {
         _equipBag.mainType = _buttonGroup.selectIndex + 1;
      }
      
      public function metrailUpdateView(param1:String) : void
      {
         _mainTabType = param1;
         refreshData();
         refreshView();
      }
      
      private function getListByP7(param1:Array, param2:int, param3:int = -1) : Array
      {
         var _loc4_:Array = [];
         for each(var _loc5_:GoodsInfo in param1)
         {
            if(param3 == _loc5_.templateId || _loc5_.templateInfo.Property7 == param2)
            {
               _loc4_.push(_loc5_);
            }
         }
         return _loc4_;
      }
      
      private function refreshData() : void
      {
         var _loc2_:int = 0;
         _loc2_ = 7620150;
         var _loc3_:Array = null;
         var _loc4_:Array = null;
         var _loc1_:Array = null;
         _materialData.length = 0;
         switch(_mainTabType)
         {
            case "qh":
               _loc3_ = GoodsManager.instance.getGoodsBySontypeFromBagType(762,1);
               _materialData = getListByP7(_loc3_,1);
               _metrialTitle.text = LanguageMgr.GetTranslation("theseus.war.intensifyqhc");
               break;
            case "gz":
               _loc3_ = GoodsManager.instance.getGoodsBySontypeFromBagType(762,1);
               _loc4_ = getListByP7(_loc3_,3);
               _materialData = _loc4_.concat(getListByP7(_loc3_,4));
               _metrialTitle.text = LanguageMgr.GetTranslation("theseus.war.intensifyMetrial");
               break;
            case "xl":
               _loc3_ = GoodsManager.instance.getGoodsBySontypeFromBagType(762,1);
               _materialData = getListByP7(_loc3_,2);
               _metrialTitle.text = LanguageMgr.GetTranslation("theseus.war.xlc");
               break;
            case "jn":
               _materialData = GoodsManager.instance.getGoodsBySontypeFromBagType(763,1);
               _metrialTitle.text = LanguageMgr.GetTranslation("theseus.war.intensifySks");
               break;
            case "sx":
               _materialData = GoodsManager.instance.getBagGoodsByTemplateId(7620150);
               _metrialTitle.text = LanguageMgr.GetTranslation("theseus.war.starOther");
               break;
            case "fj":
               _loc3_ = GoodsManager.instance.getGoodsBySontypeFromBagType(762,1);
               _loc1_ = getListByP7(_loc3_,1,7620150);
               _materialData = _loc1_.concat(GoodsManager.instance.getGoodsBySontypeFromBagType(760,1));
               _metrialTitle.text = LanguageMgr.GetTranslation("theseus.war.fejieMt");
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_titleBg);
         _titleBg = null;
         ObjectUtils.disposeObject(_tab1Btn);
         _tab1Btn = null;
         ObjectUtils.disposeObject(_tab2Btn);
         _tab2Btn = null;
         ObjectUtils.disposeObject(_tab3Btn);
         _tab3Btn = null;
         ObjectUtils.disposeObject(_tabHbox);
         _tabHbox = null;
         ObjectUtils.disposeObject(_buttonGroup);
         _buttonGroup = null;
         ObjectUtils.disposeObject(_equipBag);
         _equipBag = null;
         ObjectUtils.disposeObject(_equipScroll);
         _equipScroll = null;
         for each(var _loc1_:BaseItemView in _materialList)
         {
            ObjectUtils.disposeObject(_loc1_);
            _loc1_ = null;
         }
         _materialList = null;
         ObjectUtils.disposeObject(_materialViewList);
         _materialViewList = null;
         ObjectUtils.disposeObject(_materialScroll);
         _materialScroll = null;
         ObjectUtils.disposeObject(_metrialTitle);
         _metrialTitle = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

