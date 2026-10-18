package outercityshop.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import events.OuterCityShopEvent;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import managers.OuterCityShopManager;
   import mvc.controler.OuterCityShopControler;
   import mvc.module.outercityshop.OuterCityShopModel;
   import yishi.datas.goods.GoodsInfo;
   import yishi.manager.FrameControllerManager;
   import yishi.view.community.BaseItemView;
   
   public class OuterCityShopGoodsView extends Sprite implements Disposeable
   {
      
      private static const COLUMN_NUM:int = 6;
      
      private static const ROW_NUM:int = 5;
      
      private static const PAGE_COUNT:int = 1;
      
      private var _lastPageBtn:IconButton;
      
      private var _nextPageBtn:IconButton;
      
      private var _pageBg:Image;
      
      private var _pageTxt:FilterFrameText;
      
      private var _goodsLists:Vector.<BaseItemView>;
      
      public function OuterCityShopGoodsView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         var _loc1_:BaseItemView = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _goodsLists = new Vector.<BaseItemView>();
         _loc2_ = 0;
         while(_loc2_ < 5)
         {
            _loc3_ = 0;
            while(_loc3_ < 6)
            {
               _loc1_ = ComponentFactory.Instance.creatCustomObject("outercityshop.goodsItemView");
               _loc1_.x = _loc3_ * 70;
               _loc1_.y = _loc2_ * 70;
               _goodsLists.push(_loc1_);
               addChild(_loc1_);
               _loc3_++;
            }
            _loc2_++;
         }
         _pageBg = ComponentFactory.Instance.creatComponentByStylename("outercityshop.lookPageBg");
         _pageTxt = ComponentFactory.Instance.creatComponentByStylename("outercityshop.lookPageTextStyle");
         _lastPageBtn = ComponentFactory.Instance.creatComponentByStylename("outercityshop.lookLastPageBtn");
         _nextPageBtn = ComponentFactory.Instance.creatComponentByStylename("outercityshop.lookNextPageBtn");
         addChild(_pageBg);
         addChild(_pageTxt);
         addChild(_lastPageBtn);
         addChild(_nextPageBtn);
      }
      
      private function addEvent() : void
      {
         _lastPageBtn.addEventListener("click",__onPageHandler);
         _nextPageBtn.addEventListener("click",__onPageHandler);
         model.addEventListener("LOOK_GOODS_LIST_UPDATE",__refreshViewHandler);
      }
      
      private function removeEvent() : void
      {
         _lastPageBtn.removeEventListener("click",__onPageHandler);
         _nextPageBtn.removeEventListener("click",__onPageHandler);
         model.removeEventListener("LOOK_GOODS_LIST_UPDATE",__refreshViewHandler);
      }
      
      private function __refreshViewHandler(param1:OuterCityShopEvent) : void
      {
         var _loc3_:int = 1;
         var _loc2_:int = 1;
         _pageTxt.text = model.currentLookPage + " / " + model.totalLookPage;
         _lastPageBtn.enable = model.currentLookPage != 1;
         _nextPageBtn.enable = model.currentLookPage != model.totalLookPage;
         updateLookGoodsListData();
      }
      
      private function updateLookGoodsListData() : void
      {
         var _loc2_:GoodsInfo = null;
         var _loc1_:int = 0;
         if(model.showLookGoodsList)
         {
            _loc1_ = 0;
            while(_loc1_ < _goodsLists.length)
            {
               if(model.showLookGoodsList[_loc1_])
               {
                  _loc2_ = new GoodsInfo();
                  _loc2_.templateId = model.showLookGoodsList[_loc1_].ItemId;
                  _loc2_.count = model.showLookGoodsList[_loc1_].Count;
                  _goodsLists[_loc1_].data = _loc2_;
               }
               else
               {
                  _goodsLists[_loc1_].data = null;
               }
               _loc1_++;
            }
         }
      }
      
      private function __onPageHandler(param1:MouseEvent) : void
      {
         outercityShopControler.pageLookHandler(param1.currentTarget == _lastPageBtn);
      }
      
      private function get outercityShopControler() : OuterCityShopControler
      {
         return FrameControllerManager.instance.outerCityShopControler;
      }
      
      private function get model() : OuterCityShopModel
      {
         return OuterCityShopManager.instance.model;
      }
      
      public function dispose() : void
      {
         removeEvent();
         _goodsLists = null;
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
      }
   }
}

