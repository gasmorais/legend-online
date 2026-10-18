package buildings.transferbuilding.view.planesbag
{
   import bag.events.BagEvent;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   import yishi.datas.goods.GoodsInfo;
   import yishi.manager.GoodsManager;
   import yishi.utils.SimpleDictionary;
   import yishi.view.community.BaseItemView;
   
   public class PlanesBagFrame extends Frame
   {
      
      private static const rowCount:int = 5;
      
      private static const columnCount:int = 6;
      
      private var back:ScaleBitmapImage;
      
      private var bagList:SimpleTileList;
      
      private var bagScroll:ScrollPanel;
      
      private var itemList:Vector.<BaseItemView>;
      
      private var itemDic:SimpleDictionary = new SimpleDictionary(true);
      
      private var realRowNum:int = 5;
      
      private var defaultCount:int;
      
      private var showGoodsArr:Array;
      
      public function PlanesBagFrame()
      {
         super();
         defaultCount = 5 * 6;
         initView();
         addEvent();
         initList();
         refreshData();
         refreshView();
      }
      
      private function initView() : void
      {
         back = ComponentFactory.Instance.creatComponentByStylename("PlanesBagFrame.back");
         bagList = ComponentFactory.Instance.creatCustomObject("PlanesBagFrame.SimpleTileList",[6]);
         bagScroll = ComponentFactory.Instance.creatComponentByStylename("PlanesBagFrame.bagScroll");
         bagScroll.vUnitIncrement = 8;
         bagScroll.setView(bagList);
         addToContent(back);
         addToContent(bagScroll);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         GoodsManager.instance.addEventListener("UPDATE_BAG",__bagItemUpdateHandler);
         GoodsManager.instance.addEventListener("DELETE_BAG",__bagItemDeleteHandler);
      }
      
      private function initList() : void
      {
         var _loc2_:* = 0;
         var _loc1_:BaseItemView = null;
         itemList = new Vector.<BaseItemView>();
         bagList.beginChanges();
         _loc2_ = 0;
         while(_loc2_ < defaultCount)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("PlanesBagFrame.BagCell");
            _loc1_.pos = -1;
            bagList.addChild(_loc1_);
            itemList.push(_loc1_);
            _loc2_++;
         }
         bagList.commitChanges();
         bagScroll.invalidateViewport();
      }
      
      private function refreshData() : void
      {
         var _loc3_:GoodsInfo = null;
         var _loc2_:int = 0;
         showGoodsArr = [];
         var _loc1_:Array = GoodsManager.instance.getGeneralBagGoodsBySonType(606);
         _loc2_ = 0;
         while(_loc2_ < _loc1_.length)
         {
            _loc3_ = _loc1_[_loc2_] as GoodsInfo;
            if(isPlanesGoods(_loc3_))
            {
               showGoodsArr.push(_loc3_);
            }
            _loc2_++;
         }
         showGoodsArr.sort(sortByTempId);
      }
      
      private function sortByTempId(param1:GoodsInfo, param2:GoodsInfo) : int
      {
         if(param1.templateInfo.TemplateId > param2.templateInfo.TemplateId)
         {
            return -1;
         }
         if(param1.templateInfo.TemplateId < param2.templateInfo.TemplateId)
         {
            return 1;
         }
         return 0;
      }
      
      private function refreshView() : void
      {
         var _loc1_:int = 0;
         var _loc2_:GoodsInfo = null;
         clearGoods();
         refreshBag();
         _loc1_ = 0;
         while(_loc1_ < showGoodsArr.length)
         {
            _loc2_ = showGoodsArr[_loc1_] as GoodsInfo;
            itemList[_loc1_].bagType = _loc2_.bagType;
            itemList[_loc1_].pos = _loc2_.pos;
            itemList[_loc1_].data = _loc2_;
            itemDic.add(_loc2_.pos + "_" + _loc2_.objectId + "_" + _loc2_.bagType,itemList[_loc1_]);
            _loc1_++;
         }
      }
      
      private function clearGoods() : void
      {
         for each(var _loc1_:BaseItemView in itemList)
         {
            _loc1_.data = null;
         }
         for each(var _loc2_:BaseItemView in itemDic)
         {
            _loc2_.data = null;
            _loc2_.pos = -1;
         }
         itemDic.clear();
      }
      
      private function refreshBag() : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         realRowNum = Math.ceil(showGoodsArr.length / 6);
         var _loc4_:int = 6 * realRowNum;
         var _loc1_:int = _loc4_ < defaultCount ? defaultCount : _loc4_;
         if(itemList.length < _loc1_)
         {
            addItems(_loc1_ - itemList.length);
         }
         else if(itemList.length > _loc1_ && itemList.length > defaultCount)
         {
            removeItems(itemList.length - _loc1_);
         }
      }
      
      private function removeItems(param1:int) : void
      {
         var _loc3_:int = 0;
         var _loc2_:BaseItemView = null;
         bagList.beginChanges();
         _loc3_ = 0;
         while(_loc3_ < param1)
         {
            _loc2_ = itemList.pop();
            bagList.removeChild(_loc2_);
            _loc2_.dispose();
            _loc3_++;
         }
         bagList.commitChanges();
         bagScroll.invalidateViewport();
      }
      
      private function addItems(param1:int) : void
      {
         var _loc3_:int = 0;
         var _loc2_:BaseItemView = null;
         bagList.beginChanges();
         _loc3_ = 0;
         while(_loc3_ < param1)
         {
            _loc2_ = ComponentFactory.Instance.creatCustomObject("PlanesBagFrame.BagCell");
            _loc2_.pos = -1;
            bagList.addChild(_loc2_);
            itemList.push(_loc2_);
            _loc3_++;
         }
         bagList.commitChanges();
         bagScroll.invalidateViewport();
      }
      
      private function addItem(param1:GoodsInfo) : void
      {
         var _loc2_:BaseItemView = null;
         if(isPlanesGoods(param1) && showGoodsArr)
         {
            _loc2_ = findBagEmputyItem(showGoodsArr.length);
            _loc2_.bagType = param1.bagType;
            _loc2_.pos = param1.pos;
            _loc2_.data = param1;
            itemDic.add(param1.pos + "_" + param1.objectId + "_" + param1.bagType,_loc2_);
         }
      }
      
      private function isPlanesGoods(param1:GoodsInfo) : Boolean
      {
         if(param1.templateInfo.SonType == 606)
         {
            return true;
         }
         return false;
      }
      
      public function findBagEmputyItem(param1:int = 0) : BaseItemView
      {
         var _loc2_:BaseItemView = null;
         var _loc4_:* = 0;
         var _loc3_:int = param1;
         _loc3_;
         while(_loc3_ < itemList.length)
         {
            if(!itemList[_loc3_].data)
            {
               return itemList[_loc3_];
            }
            _loc3_++;
         }
         _loc4_ = 0;
         while(_loc4_ < 6)
         {
            _loc2_ = ComponentFactory.Instance.creatCustomObject("PlanesBagFrame.BagCell");
            bagList.addChild(_loc2_);
            itemList.push(_loc2_);
            _loc4_++;
         }
         bagList.commitChanges();
         bagScroll.invalidateViewport();
         return findBagEmputyItem(_loc3_);
      }
      
      private function __bagItemDeleteHandler(param1:BagEvent) : void
      {
         var _loc3_:GoodsInfo = param1.info;
         var _loc2_:BaseItemView = itemDic[_loc3_.pos + "_" + _loc3_.objectId + "_" + _loc3_.bagType];
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
         if(!isPlanesGoods(_loc3_))
         {
            return;
         }
         var _loc2_:BaseItemView = itemDic[_loc3_.pos + "_" + _loc3_.objectId + "_" + _loc3_.bagType];
         if(_loc2_)
         {
            _loc2_.data = _loc3_;
         }
         else
         {
            addItem(_loc3_);
         }
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         GoodsManager.instance.removeEventListener("UPDATE_BAG",__bagItemUpdateHandler);
         GoodsManager.instance.removeEventListener("DELETE_BAG",__bagItemDeleteHandler);
      }
      
      public function show() : void
      {
         titleText = LanguageMgr.GetTranslation("PlanesBagFrame.title.text");
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         if(realRowNum > 5)
         {
            back.height = 291 + (realRowNum - 5) * 50;
            this.height = 390 + (realRowNum - 5) * 50;
         }
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(back)
         {
            ObjectUtils.disposeObject(back);
         }
         back = null;
         if(bagList)
         {
            ObjectUtils.disposeAllChildren(bagList);
            ObjectUtils.disposeObject(bagList);
            bagList = null;
         }
         if(bagScroll)
         {
            ObjectUtils.disposeAllChildren(bagScroll);
            ObjectUtils.disposeObject(bagScroll);
            bagScroll = null;
         }
         for each(var _loc1_:BaseItemView in itemDic)
         {
            _loc1_.dispose();
            _loc1_ = null;
         }
         itemDic.clear();
         itemList = null;
         showGoodsArr = null;
         super.dispose();
      }
   }
}

