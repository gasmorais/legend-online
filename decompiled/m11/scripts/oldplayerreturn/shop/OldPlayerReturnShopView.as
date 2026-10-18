package oldplayerreturn.shop
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import mvc.module.oldplayerreturn.OldPlayerReturnModel;
   import yishi.manager.GoodsManager;
   import yishi.manager.OldPlayerReturnManager;
   
   public class OldPlayerReturnShopView extends Component
   {
      
      private var _bg:MutipleImage;
      
      private var _displayShow:Bitmap;
      
      private var _icon:ScaleFrameImage;
      
      private var _displayShowTxt:ScaleFrameImage;
      
      private var _prePageBtn:IconButton;
      
      private var _nextPageBtn:IconButton;
      
      private var _pageNumTxt:FilterFrameText;
      
      private var _contributeTxt:FilterFrameText;
      
      private var _itemList:Vector.<OldPlayerReturnShopItem>;
      
      public function OldPlayerReturnShopView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         var _loc3_:int = 0;
         var _loc1_:OldPlayerReturnShopItem = null;
         _bg = ComponentFactory.Instance.creatComponentByStylename("OldPlayerReturnShopView.bg");
         _displayShow = ComponentFactory.Instance.creatBitmap("asset.shop.ShopDisplayShow02");
         _icon = ComponentFactory.Instance.creatComponentByStylename("OldPlayerReturnTaskItem.icon");
         _displayShowTxt = ComponentFactory.Instance.creatComponentByStylename("OldPlayerReturnTaskItem.displayShowTxt");
         _prePageBtn = ComponentFactory.Instance.creatComponentByStylename("OldPlayerReturnShopView.PrePageBtn");
         _nextPageBtn = ComponentFactory.Instance.creatComponentByStylename("OldPlayerReturnShopView.NextPageBtn");
         _pageNumTxt = ComponentFactory.Instance.creatComponentByStylename("OldPlayerReturnShopView.pageNumTxt");
         _contributeTxt = ComponentFactory.Instance.creatComponentByStylename("OldPlayerReturnShopView.contributeTxt");
         addChild(_bg);
         addChild(_displayShow);
         _displayShow.x = 7;
         _displayShow.y = 415;
         addChild(_icon);
         _icon.x = 10;
         _icon.y = 418;
         addChild(_displayShowTxt);
         addChild(_prePageBtn);
         addChild(_nextPageBtn);
         addChild(_pageNumTxt);
         addChild(_contributeTxt);
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         _itemList = new Vector.<OldPlayerReturnShopItem>();
         _loc3_ = 0;
         while(_loc3_ < 9)
         {
            _loc1_ = new OldPlayerReturnShopItem();
            _loc4_ = _loc3_ / 3;
            _loc2_ = _loc3_ % 3;
            _loc1_.x = _loc2_ * 240;
            _loc1_.y = _loc4_ * 125;
            addChild(_loc1_);
            _itemList.push(_loc1_);
            _loc3_++;
         }
         _pageNumTxt.text = "1/1";
         _contributeTxt.text = "";
         _icon.setFrame(model.type);
         _displayShowTxt.setFrame(model.type);
      }
      
      private function addEvent() : void
      {
         _prePageBtn.addEventListener("click",__onPageHandler);
         _nextPageBtn.addEventListener("click",__onPageHandler);
      }
      
      private function removeEvent() : void
      {
         _prePageBtn.removeEventListener("click",__onPageHandler);
         _nextPageBtn.removeEventListener("click",__onPageHandler);
      }
      
      private function __onPageHandler(param1:MouseEvent) : void
      {
         model.shopPageBtnHandler(param1.currentTarget == _prePageBtn);
         refreshView();
      }
      
      public function refreshView() : void
      {
         var _loc4_:int = 0;
         var _loc1_:Array = model.getShopShowList();
         _loc4_ = 0;
         while(_loc4_ < 9)
         {
            _itemList[_loc4_].data = _loc4_ < _loc1_.length ? _loc1_[_loc4_] : null;
            _loc4_++;
         }
         _pageNumTxt.text = model.currentPage + "/" + model.totalPage;
         _prePageBtn.enable = model.currentPage != 1;
         _nextPageBtn.enable = model.currentPage != model.totalPage;
         var _loc2_:int = model.isReturnPlayer ? 208701 : 208702;
         var _loc3_:int = int(GoodsManager.instance.getBagCountInPlayerAndStoneByTempId(_loc2_));
         _contributeTxt.text = _loc3_.toString();
      }
      
      private function get model() : OldPlayerReturnModel
      {
         return OldPlayerReturnManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_displayShow);
         _displayShow = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_displayShowTxt);
         _displayShowTxt = null;
         ObjectUtils.disposeObject(_prePageBtn);
         _prePageBtn = null;
         ObjectUtils.disposeObject(_nextPageBtn);
         _nextPageBtn = null;
         ObjectUtils.disposeObject(_pageNumTxt);
         _pageNumTxt = null;
         ObjectUtils.disposeObject(_contributeTxt);
         _contributeTxt = null;
         for each(var _loc1_:OldPlayerReturnShopItem in _itemList)
         {
            ObjectUtils.disposeObject(_loc1_);
            _loc1_ = null;
         }
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

