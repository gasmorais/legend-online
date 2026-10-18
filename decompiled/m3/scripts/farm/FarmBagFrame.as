package farm
{
   import bag.events.BagEvent;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import farm.cell.FarmBagCell;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import yishi.datas.goods.GoodsInfo;
   import yishi.manager.GoodsManager;
   import yishi.utils.SimpleDictionary;
   
   public class FarmBagFrame extends Frame
   {
      
      public static const DEFAULT_CELLS_NUM:int = 20;
      
      public static const COLUMN_NUM:int = 4;
      
      private var _scaleBg:Scale9CornerImage;
      
      private var _itemContainer:SimpleTileList;
      
      private var _scrollPanel:ScrollPanel;
      
      private var _shopBtn:IconButton;
      
      private var _seedList:Array;
      
      private var _animalList:Array;
      
      private var _itemList:Vector.<FarmBagCell>;
      
      private var _itemDic:SimpleDictionary;
      
      public function FarmBagFrame()
      {
         super();
         initView();
         addEvent();
         refreshView();
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP"];
      }
      
      private function initView() : void
      {
         _itemList = new Vector.<FarmBagCell>();
         _itemDic = new SimpleDictionary();
         titleText = LanguageMgr.GetTranslation("farm.FarmBagFrame.title");
         _scaleBg = ComponentFactory.Instance.creatComponentByStylename("farm.FarmBagFrameScaleBg");
         _itemContainer = ComponentFactory.Instance.creatCustomObject("farm.FarmBagFrameItemContainer",[4]);
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("farm.FarmBagFrameScrollPanel");
         _shopBtn = ComponentFactory.Instance.creatComponentByStylename("farm.FarmBagFrameShopBtn");
         addItemByLen(20);
         _scrollPanel.setView(_itemContainer);
         addToContent(_scaleBg);
         addToContent(_scrollPanel);
         addToContent(_shopBtn);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponseHandler);
         _shopBtn.addEventListener("click",__onShopClick);
         GoodsManager.instance.addEventListener("UPDATE_BAG",__bagItemUpdateHandler);
         GoodsManager.instance.addEventListener("DELETE_BAG",__bagItemDeleteHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponseHandler);
         _shopBtn.removeEventListener("click",__onShopClick);
         GoodsManager.instance.removeEventListener("UPDATE_BAG",__bagItemUpdateHandler);
         GoodsManager.instance.removeEventListener("DELETE_BAG",__bagItemDeleteHandler);
      }
      
      private function __frameResponseHandler(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
            case 4:
               dispose();
         }
      }
      
      private function __onShopClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         FarmManager.instance.openShopFrame();
      }
      
      private function __bagItemUpdateHandler(param1:BagEvent) : void
      {
         var _loc2_:FarmBagCell = null;
         var _loc3_:GoodsInfo = param1.info;
         if(_loc3_ == null)
         {
            return;
         }
         if(_loc3_.templateInfo.SonType == 216 || _loc3_.templateInfo.SonType == 1500)
         {
            _loc2_ = _itemDic[_loc3_.pos];
            if(_loc2_)
            {
               _loc2_.data = _loc3_;
            }
            else
            {
               addInfoToItem(_loc3_,_seedList.length);
            }
         }
      }
      
      private function __bagItemDeleteHandler(param1:BagEvent) : void
      {
         var _loc2_:FarmBagCell = null;
         var _loc3_:GoodsInfo = param1.info;
         if(_loc3_.templateInfo.SonType == 216 || _loc3_.templateInfo.SonType == 1500)
         {
            _loc2_ = _itemDic[_loc3_.pos];
            if(_loc2_)
            {
               _loc2_.data = null;
            }
         }
      }
      
      private function refreshView() : void
      {
         cleanGoods();
         _seedList = GoodsManager.instance.getGeneralBagGoodsBySonType(216);
         _animalList = GoodsManager.instance.getGeneralBagGoodsBySonType(1500);
         for each(var _loc2_:GoodsInfo in _seedList)
         {
            addInfoToItem(_loc2_);
         }
         for each(var _loc1_:GoodsInfo in _animalList)
         {
            addInfoToItem(_loc1_);
         }
         updateScroll();
      }
      
      private function addInfoToItem(param1:GoodsInfo, param2:int = 0) : void
      {
         var _loc3_:FarmBagCell = null;
         if(param1)
         {
            _loc3_ = findEmptyItem(param2);
            _loc3_.data = param1;
            _loc3_.pos = param1.pos;
            _itemDic.add(param1.pos,_loc3_);
         }
      }
      
      private function findEmptyItem(param1:int = 0) : FarmBagCell
      {
         var _loc3_:int = param1;
         var _loc2_:int = int(_itemList.length);
         _loc3_;
         while(_loc3_ < _loc2_)
         {
            if(!_itemList[_loc3_].data)
            {
               return _itemList[_loc3_];
            }
            _loc3_++;
         }
         addItemByLen(4);
         updateScroll();
         return findEmptyItem(_loc3_);
      }
      
      private function addItemByLen(param1:int) : void
      {
         var _loc2_:int = 0;
         var _loc3_:FarmBagCell = null;
         _loc2_ = 0;
         while(_loc2_ < param1)
         {
            _loc3_ = ComponentFactory.Instance.creatCustomObject("farm.FarmBagCell");
            _loc3_.data = null;
            _itemContainer.addChild(_loc3_);
            _itemList.push(_loc3_);
            _loc2_++;
         }
      }
      
      private function updateScroll() : void
      {
         _itemContainer.beginChanges();
         _itemList.length > 20 ? (_itemContainer.hSpace = 0) : (Number(_itemContainer.hSpace = 1));
         _itemContainer.commitChanges();
         _scrollPanel.invalidateViewport();
      }
      
      public function show() : void
      {
         x = StageReferance.stageWidth - this.width - 250;
         y = (StageReferance.stageHeight - this.height) / 2;
         LayerManager.Instance.addToLayer(this,9,false,false);
      }
      
      private function cleanGoods() : void
      {
         if(_itemDic)
         {
            for each(var _loc1_:FarmBagCell in _itemDic)
            {
               _loc1_.data = null;
               _loc1_.pos = -1;
            }
            _itemDic.clear();
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         cleanGoods();
         if(_scaleBg)
         {
            _scaleBg.dispose();
         }
         _scaleBg = null;
         if(_itemContainer)
         {
            _itemContainer.dispose();
         }
         _itemContainer = null;
         if(_scrollPanel)
         {
            _scrollPanel.dispose();
         }
         _scrollPanel = null;
         if(_shopBtn)
         {
            _shopBtn.dispose();
         }
         _shopBtn = null;
         for each(var _loc1_:FarmBagCell in _itemList)
         {
            _loc1_.dispose();
         }
         _itemList = null;
         _itemDic = null;
         _seedList = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

