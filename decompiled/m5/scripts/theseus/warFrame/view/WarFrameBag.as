package theseus.warFrame.view
{
   import bag.events.BagEvent;
   import com.pickgliss.geom.IntPoint;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import managers.TheseussoulManager;
   import yishi.datas.goods.GoodsInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.GoodsManager;
   import yishi.manager.NotificationManager;
   import yishi.utils.SimpleDictionary;
   import yishi.view.community.BaseItemView;
   
   public class WarFrameBag extends Sprite
   {
      
      private var _titleBg:Bitmap;
      
      private var _titleBg1:Bitmap;
      
      private var _defaultCount:int = 18;
      
      private var _columnCount:int = 6;
      
      private var _equipScroll:ScrollPanel;
      
      private var _equipBag:TheseusWarframeBagView;
      
      private var _materialViewList:SimpleTileList;
      
      private var _materialScroll:ScrollPanel;
      
      private var _materialData:Array = [];
      
      private var _materialList:Vector.<BaseItemView>;
      
      private var _materialDic:SimpleDictionary = new SimpleDictionary(true);
      
      private var _metrialTitle:FilterFrameText;
      
      private var _equipTitle:FilterFrameText;
      
      private var _mainTabType:int;
      
      public function WarFrameBag()
      {
         super();
         initView();
         initEquipList();
         initMaterialList();
         initEvent();
      }
      
      private function initView() : void
      {
         _titleBg = ComponentFactory.Instance.creatBitmap("asset.theseus.intensify.bagLine");
         _titleBg1 = ComponentFactory.Instance.creatBitmap("asset.theseus.intensify.bagLine");
         _equipScroll = ComponentFactory.Instance.creatComponentByStylename("theseus.BagII.equipScroll");
         _equipTitle = ComponentFactory.Instance.creatComponentByStylename("theseus.BagII.materialTitle1");
         _metrialTitle = ComponentFactory.Instance.creatComponentByStylename("theseus.BagII.materialTitle");
         _materialViewList = ComponentFactory.Instance.creatCustomObject("theseus.BagII.materialViewList",[6]);
         _materialScroll = ComponentFactory.Instance.creatComponentByStylename("theseus.BagII.materialScroll");
         _materialScroll.setView(_materialViewList);
         _titleBg1.y = 12;
         addChild(_titleBg);
         addChild(_titleBg1);
         addChild(_equipScroll);
         addChild(_materialScroll);
         addChild(_equipTitle);
         addChild(_metrialTitle);
         _equipTitle.text = LanguageMgr.GetTranslation("theseus.warFrame.intensifyTxt2");
      }
      
      private function initEquipList() : void
      {
         var _loc1_:int = Math.ceil(TheseussoulManager.Instance.model.itemSort.length / 6) > 11 ? Math.ceil(TheseussoulManager.Instance.model.itemSort.length / 6) : 11;
         _equipBag = new TheseusWarframeBagView(6,_loc1_,1);
         _equipBag.updateVSpace(1);
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
         while(_loc2_ < _materialList.length)
         {
            _loc3_ = _materialData[_loc2_] as GoodsInfo;
            if(_loc3_)
            {
               _materialList[_loc2_].bagType = _loc3_.bagType;
               _materialList[_loc2_].pos = _loc3_.pos;
               _materialList[_loc2_].data = _loc3_;
               _materialDic.add(_loc3_.pos + "_" + _loc3_.objectId + "_" + _loc3_.bagType,_materialList[_loc2_]);
            }
            else
            {
               _materialList[_loc2_].data = null;
            }
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
         NotificationManager.instance.addEventListener("EventWarFrameInsPutIn",cellChangeInHandler);
         NotificationManager.instance.addEventListener("EventWarFrameInsPutOut",cellChangeOutHandler);
         TheseussoulManager.Instance.addEventListener("OP_WarEQUIP_STRENGTHENSTR",listChangeHandler);
         TheseussoulManager.Instance.addEventListener("OP_WarEQUIP_STRENGTHENSTR",listChangeHandler);
      }
      
      private function removeEvent() : void
      {
         NotificationManager.instance.removeEventListener("EventWarFrameInsPutIn",cellChangeInHandler);
         NotificationManager.instance.removeEventListener("EventWarFrameInsPutOut",cellChangeOutHandler);
         TheseussoulManager.Instance.removeEventListener("OP_WarEQUIP_STRENGTHENSTR",listChangeHandler);
         TheseussoulManager.Instance.removeEventListener("OP_WarEQUIP_STRENGTHENSTR",listChangeHandler);
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
         metrailUpdateView(_loc2_);
      }
      
      private function cellChangeInHandler(param1:NotificationEvent) : void
      {
         _equipBag.updateView();
      }
      
      private function cellChangeOutHandler(param1:NotificationEvent) : void
      {
         _equipBag.updateView();
      }
      
      private function resetChangeHandler(param1:NotificationEvent) : void
      {
         _equipBag.updateView();
      }
      
      public function metrailUpdateView(param1:int) : void
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
         var _loc1_:int = 0;
         _loc1_ = 7620150;
         var _loc2_:Array = null;
         var _loc3_:Array = null;
         _materialData.length = 0;
         switch(_mainTabType - 5)
         {
            case 0:
               _loc2_ = GoodsManager.instance.getGoodsBySontypeFromBagType(750,10);
               _materialData = getListByP7(_loc2_,1);
               _metrialTitle.text = LanguageMgr.GetTranslation("theseus.war.intensifyqhc");
               break;
            case 1:
               _loc2_ = GoodsManager.instance.getGoodsBySontypeFromBagType(751,10);
               _loc3_ = getListByP7(_loc2_,3);
               _materialData = _loc3_.concat(getListByP7(_loc2_,4));
               _metrialTitle.text = LanguageMgr.GetTranslation("theseus.warFrame.intensifyMetrial");
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_titleBg);
         _titleBg = null;
         ObjectUtils.disposeObject(_titleBg1);
         _titleBg1 = null;
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

