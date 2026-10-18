package view.subshop
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import events.MountsEvent;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.MountsManager;
   import managers.ShopManager;
   import yishi.datas.goods.GoodsInfo;
   import yishi.utils.StringHelper;
   import yishi.view.community.BaseItemView;
   
   public class MountPreviewFrame extends Frame
   {
      
      private static const COLUMN_NUM:int = 6;
      
      private static const ROW_NUM:int = 5;
      
      private static const PAGE_COUNT:int = 1;
      
      private var _goodsBackBg:Scale9CornerImage;
      
      private var _goodsBack:ScaleBitmapImage;
      
      private var _lastPageBtn:IconButton;
      
      private var _nextPageBtn:IconButton;
      
      private var _pageBg:Image;
      
      private var _pageTxt:FilterFrameText;
      
      private var _pageCount:int = 30;
      
      private var _pageNumMax:int = 1;
      
      private var _currentPageNum:int;
      
      private var _formatStr:String = "{0} / {1}";
      
      private var _goodsLists:Vector.<BaseItemView>;
      
      private var _goodsArray:Array = [];
      
      public function MountPreviewFrame()
      {
         super();
         ShopManager.Instance.isOpenMountPreviewFrame = true;
         initView();
         addEvent();
         MountsManager.instance.mountOperateSend(11);
      }
      
      private function initView() : void
      {
         var _loc1_:BaseItemView = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         titleText = LanguageMgr.GetTranslation("outercityshop.OuterCityShopFrame.linkText");
         _goodsBackBg = ComponentFactory.Instance.creatComponentByStylename("MountPreviewFrame.goodsBackBg");
         _goodsBack = ComponentFactory.Instance.creatComponentByStylename("MountPreviewFrame.goodsBack");
         _pageBg = ComponentFactory.Instance.creatComponentByStylename("MountPreviewFrame.lookPageBg");
         _pageTxt = ComponentFactory.Instance.creatComponentByStylename("MountPreviewFrame.lookPageTextStyle");
         _lastPageBtn = ComponentFactory.Instance.creatComponentByStylename("MountPreviewFrame.lookLastPageBtn");
         _nextPageBtn = ComponentFactory.Instance.creatComponentByStylename("MountPreviewFrame.lookNextPageBtn");
         addToContent(_goodsBackBg);
         addToContent(_goodsBack);
         _goodsLists = new Vector.<BaseItemView>();
         _loc2_ = 0;
         while(_loc2_ < 5)
         {
            _loc3_ = 0;
            while(_loc3_ < 6)
            {
               _loc1_ = ComponentFactory.Instance.creatCustomObject("MountPreviewFrame.goodsItemView");
               _loc1_.x = _loc3_ * 70 + 25;
               _loc1_.y = _loc2_ * 70 + 30;
               _goodsLists.push(_loc1_);
               addToContent(_loc1_);
               _loc3_++;
            }
            _loc2_++;
         }
         addToContent(_pageBg);
         addToContent(_pageTxt);
         addToContent(_lastPageBtn);
         addToContent(_nextPageBtn);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponseHandler);
         _lastPageBtn.addEventListener("click",__onLastPageHandler);
         _nextPageBtn.addEventListener("click",__onNextPageHandler);
         MountsManager.instance.avatarList.addEventListener("mountShopInfoChange",__shopInfoUpdateHandler);
         MountsManager.instance.avatarList.addEventListener("MOUNT_SHOP_PREVIEW",__previewInfoUpdateHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponseHandler);
         _lastPageBtn.removeEventListener("click",__onLastPageHandler);
         _nextPageBtn.removeEventListener("click",__onNextPageHandler);
         MountsManager.instance.avatarList.removeEventListener("mountShopInfoChange",__shopInfoUpdateHandler);
         MountsManager.instance.avatarList.removeEventListener("MOUNT_SHOP_PREVIEW",__previewInfoUpdateHandler);
      }
      
      private function __shopInfoUpdateHandler(param1:MountsEvent) : void
      {
         dispose();
      }
      
      private function __previewInfoUpdateHandler(param1:MountsEvent) : void
      {
         _goodsArray = MountsManager.instance.mountPreviewList;
         _pageNumMax = Math.ceil(_goodsArray.length / _pageCount);
         currentPageNum = 1;
         refreshListView();
      }
      
      private function __onLastPageHandler(param1:MouseEvent) : void
      {
         currentPageNum = currentPageNum - 1;
         refreshListView();
      }
      
      private function __onNextPageHandler(param1:MouseEvent) : void
      {
         currentPageNum = currentPageNum + 1;
         refreshListView();
      }
      
      public function get currentPageNum() : int
      {
         return _currentPageNum;
      }
      
      private function refreshListView() : void
      {
         var _loc2_:GoodsInfo = null;
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _goodsLists.length)
         {
            if(getCurrentList()[_loc1_])
            {
               _loc2_ = new GoodsInfo();
               _loc2_.templateId = getCurrentList()[_loc1_].tempId;
               _loc2_.count = getCurrentList()[_loc1_].count;
               _goodsLists[_loc1_].data = _loc2_;
            }
            else
            {
               _goodsLists[_loc1_].data = null;
            }
            _loc1_++;
         }
      }
      
      public function set currentPageNum(param1:int) : void
      {
         if(param1 < 1)
         {
            return;
         }
         if(param1 > _pageNumMax)
         {
            return;
         }
         _currentPageNum = param1;
         updatePageInfo();
      }
      
      private function updatePageInfo() : void
      {
         if(_lastPageBtn)
         {
            _lastPageBtn.enable = currentPageNum > 1;
         }
         if(_nextPageBtn)
         {
            _nextPageBtn.enable = currentPageNum < _pageNumMax;
         }
         if(_pageTxt)
         {
            _pageTxt.text = StringHelper.format(_formatStr,_currentPageNum,_pageNumMax);
         }
      }
      
      private function getCurrentList() : Array
      {
         var _loc2_:Array = null;
         var _loc1_:int = 0;
         var _loc3_:int = 0;
         if(_goodsArray)
         {
            _loc1_ = (currentPageNum - 1) * _pageCount;
            _loc3_ = Math.min(_loc1_ + _pageCount,_goodsArray.length);
            _loc2_ = _goodsArray.slice(_loc1_,_loc3_);
         }
         return _loc2_;
      }
      
      private function __frameResponseHandler(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ShopManager.Instance.isOpenMountPreviewFrame = false;
         if(_goodsBackBg)
         {
            ObjectUtils.disposeObject(_goodsBackBg);
         }
         _goodsBackBg = null;
         if(_goodsBack)
         {
            ObjectUtils.disposeObject(_goodsBack);
         }
         _goodsBack = null;
         if(_pageBg)
         {
            ObjectUtils.disposeObject(_pageBg);
         }
         _pageBg = null;
         if(_pageTxt)
         {
            ObjectUtils.disposeObject(_pageTxt);
         }
         _pageTxt = null;
         if(_lastPageBtn)
         {
            ObjectUtils.disposeObject(_lastPageBtn);
         }
         _lastPageBtn = null;
         if(_nextPageBtn)
         {
            ObjectUtils.disposeObject(_nextPageBtn);
         }
         _nextPageBtn = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

