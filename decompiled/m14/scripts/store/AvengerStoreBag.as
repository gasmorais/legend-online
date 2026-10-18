package store
{
   import com.pickgliss.geom.IntPoint;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   import mvc.module.avenger.AvengerModel;
   import store.resolve.AvengerStoreItemCell;
   import utils.LogicUtils;
   import yishi.datas.goods.GoodsInfo;
   import yishi.manager.AvengerManager;
   import yishi.utils.MsgMan;
   
   public class AvengerStoreBag extends Component
   {
      
      private static const DEFAULT_COUNT:int = 18;
      
      private static const COL_NUM:int = 6;
      
      private var _lineImage:MutipleImage;
      
      private var _textBack:Image;
      
      private var _textBack2:Image;
      
      private var _equipText:FilterFrameText;
      
      private var _materialText:FilterFrameText;
      
      private var _equipViewList:SimpleTileList;
      
      private var _equipScroll:ScrollPanel;
      
      private var _equipData:Array;
      
      private var _equipList:Vector.<AvengerStoreItemCell>;
      
      private var _materialViewList:SimpleTileList;
      
      private var _materialScroll:ScrollPanel;
      
      private var _materialData:Array;
      
      private var _materialList:Vector.<AvengerStoreItemCell>;
      
      private var equipAry:Array = [];
      
      private var materialAry:Array = [];
      
      private var isAllCheck:Boolean = false;
      
      private var alltype:int;
      
      private var alllv:int;
      
      public function AvengerStoreBag()
      {
         super();
         initView();
         addEvent();
         initEquipList();
         initMaterialList();
         refreshView();
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
         _materialScroll.height = 130;
         _equipText.text = LanguageMgr.GetTranslation("StoreBagII.equipText.text");
         _materialText.text = LanguageMgr.GetTranslation("StoreBagII.materialText.text.STORE_PANEL_RESOLVE");
      }
      
      private function initEquipList() : void
      {
         var _loc2_:* = 0;
         var _loc1_:AvengerStoreItemCell = null;
         if(_equipList)
         {
            _equipViewList.removeAllChild();
            _equipList.length = 0;
         }
         else
         {
            _equipList = new Vector.<AvengerStoreItemCell>();
         }
         _equipViewList.beginChanges();
         _loc2_ = 0;
         while(_loc2_ < 18)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("AvengerStoreBag.BagCell",[1]);
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
         var _loc1_:AvengerStoreItemCell = null;
         if(_materialList)
         {
            _materialViewList.removeAllChild();
            _materialList.length = 0;
         }
         else
         {
            _materialList = new Vector.<AvengerStoreItemCell>();
         }
         _materialViewList.beginChanges();
         _loc2_ = 0;
         while(_loc2_ < 18)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("AvengerStoreBag.BagCell",[2]);
            _materialViewList.addChild(_loc1_);
            _materialList.push(_loc1_);
            _loc2_++;
         }
         _materialViewList.hSpace = 3;
         _materialViewList.commitChanges();
         _materialScroll.invalidateViewport();
      }
      
      private function addEvent() : void
      {
         MsgMan.addObserver("DEVIL_ARMOR_BAG_UPDATE",this,__updateBagViewHandler);
      }
      
      private function removeEvent() : void
      {
         MsgMan.removeObserver("DEVIL_ARMOR_BAG_UPDATE",this,__updateBagViewHandler);
      }
      
      private function __updateBagViewHandler(param1:String, param2:Object) : void
      {
         initEquipList();
         initMaterialList();
         refreshView();
      }
      
      private function refreshView() : void
      {
         updateBagAry();
         refreshBagCellCount(1,equipAry);
         refreshCellData(1,equipAry);
         refreshBagCellCount(2,materialAry);
         refreshCellData(2,materialAry);
      }
      
      private function refreshCellData(param1:int, param2:Array) : void
      {
         var _loc5_:int = 0;
         var _loc3_:AvengerStoreItemCell = null;
         var _loc6_:Vector.<AvengerStoreItemCell> = getList(param1);
         _loc5_ = 0;
         while(_loc5_ < _loc6_.length)
         {
            _loc3_ = _loc6_[_loc5_];
            if(param2.length <= _loc5_)
            {
               _loc3_.data = null;
            }
            else
            {
               _loc3_.data = param2[_loc5_] as GoodsInfo;
            }
            _loc5_++;
         }
         getViewPanel(param1).invalidateViewport();
         var _loc4_:IntPoint = new IntPoint(0,0);
         getViewPanel(param1).viewPort.viewPosition = _loc4_;
      }
      
      private function refreshBagCellCount(param1:int, param2:Array) : void
      {
         var _loc5_:int = 6 * (int((param2.length + 6 - 1) / 6));
         var _loc3_:int = _loc5_ < 18 ? 18 : _loc5_;
         var _loc4_:Vector.<AvengerStoreItemCell> = getList(param1);
         if(_loc4_.length < _loc3_)
         {
            addItems(param1,_loc3_ - _loc4_.length);
         }
         else if(_loc4_.length > _loc3_ && _loc4_.length > 18)
         {
            removeItems(param1,_loc4_.length - _loc3_);
         }
      }
      
      private function addItems(param1:int, param2:int) : void
      {
         var _loc5_:int = 0;
         var _loc4_:AvengerStoreItemCell = null;
         var _loc6_:Vector.<AvengerStoreItemCell> = getList(param1);
         var _loc3_:SimpleTileList = getViewList(param1);
         _loc3_.beginChanges();
         _loc5_ = 0;
         while(_loc5_ < param2)
         {
            _loc4_ = ComponentFactory.Instance.creatCustomObject("AvengerStoreBag.BagCell",[param1]);
            _loc3_.addChild(_loc4_);
            _loc6_.push(_loc4_);
            _loc5_++;
         }
         _loc3_.commitChanges();
         getViewPanel(param1).invalidateViewport();
      }
      
      private function removeItems(param1:int, param2:int) : void
      {
         var _loc5_:int = 0;
         var _loc4_:AvengerStoreItemCell = null;
         var _loc6_:Vector.<AvengerStoreItemCell> = getList(param1);
         var _loc3_:SimpleTileList = getViewList(param1);
         _loc3_.beginChanges();
         _loc5_ = 0;
         while(_loc5_ < param2)
         {
            _loc4_ = _loc6_.pop();
            _loc3_.removeChild(_loc4_);
            _loc4_.dispose();
            _loc5_++;
         }
         _loc3_.commitChanges();
         getViewPanel(param1).invalidateViewport();
      }
      
      private function getViewList(param1:int) : SimpleTileList
      {
         return param1 == 1 ? _equipViewList : _materialViewList;
      }
      
      private function getViewPanel(param1:int) : ScrollPanel
      {
         return param1 == 1 ? _equipScroll : _materialScroll;
      }
      
      private function getList(param1:int) : Vector.<AvengerStoreItemCell>
      {
         return param1 == 1 ? _equipList : _materialList;
      }
      
      private function updateBagAry() : void
      {
         equipAry = [];
         materialAry = [];
         for each(var _loc1_:GoodsInfo in model.armorBagDic)
         {
            if(_loc1_.templateInfo.SonType == 670)
            {
               equipAry.push(_loc1_);
            }
            else
            {
               materialAry.push(_loc1_);
            }
         }
         equipAry.sortOn("templateId",16);
         materialAry.sortOn("templateId",16);
      }
      
      private function get model() : AvengerModel
      {
         return AvengerManager.instance.model;
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
         ObjectUtils.disposeObject(_equipViewList);
         _equipViewList = null;
         ObjectUtils.disposeObject(_materialViewList);
         _materialViewList = null;
         ObjectUtils.disposeObject(_equipScroll);
         _equipScroll = null;
         ObjectUtils.disposeObject(_materialScroll);
         _materialScroll = null;
         LogicUtils.disposeDisplayCollection(_equipList);
         _equipList = null;
         LogicUtils.disposeDisplayCollection(_materialList);
         _materialList = null;
         super.dispose();
      }
   }
}

