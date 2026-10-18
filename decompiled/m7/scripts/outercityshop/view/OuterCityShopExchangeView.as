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
   import mvc.module.outercityshop.OuterCityShopGoodsInfo;
   import mvc.module.outercityshop.OuterCityShopItemInfo;
   import mvc.module.outercityshop.OuterCityShopModel;
   import yishi.manager.FrameControllerManager;
   
   public class OuterCityShopExchangeView extends Sprite implements Disposeable
   {
      
      private var _exchangeList:Vector.<OuterCityShopGoodsItem>;
      
      private var _lastPageBtn:IconButton;
      
      private var _nextPageBtn:IconButton;
      
      private var _pageBg:Image;
      
      private var _pageTxt:FilterFrameText;
      
      public function OuterCityShopExchangeView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _exchangeList = new Vector.<OuterCityShopGoodsItem>();
         createExchangeList();
         _pageBg = ComponentFactory.Instance.creatComponentByStylename("outercityshop.PageBg");
         _pageTxt = ComponentFactory.Instance.creatComponentByStylename("outercityshop.PageTextStyle");
         _lastPageBtn = ComponentFactory.Instance.creatComponentByStylename("outercityshop.LastPageBtn");
         _nextPageBtn = ComponentFactory.Instance.creatComponentByStylename("outercityshop.NextPageBtn");
         addChild(_pageBg);
         addChild(_pageTxt);
         addChild(_lastPageBtn);
         addChild(_nextPageBtn);
      }
      
      private function addEvent() : void
      {
         _lastPageBtn.addEventListener("click",__onPageHandler);
         _nextPageBtn.addEventListener("click",__onPageHandler);
         model.addEventListener("EXCHANGE_GOODS_LIST_UPDATE",__refreshViewHandler);
      }
      
      private function removeEvent() : void
      {
         _lastPageBtn.removeEventListener("click",__onPageHandler);
         _nextPageBtn.removeEventListener("click",__onPageHandler);
         model.removeEventListener("EXCHANGE_GOODS_LIST_UPDATE",__refreshViewHandler);
      }
      
      private function createExchangeList() : void
      {
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc1_:OuterCityShopGoodsItem = null;
         _loc3_ = 0;
         while(_loc3_ < 6)
         {
            _loc1_ = new OuterCityShopGoodsItem();
            _loc4_ = _loc3_ / 2;
            _loc2_ = _loc3_ % 2;
            _loc1_.x = 3 + _loc2_ * (_loc1_.width - 3);
            _loc1_.y = 3 + _loc4_ * 98;
            _exchangeList.push(_loc1_);
            addChild(_loc1_);
            _loc3_++;
         }
      }
      
      private function __refreshViewHandler(param1:OuterCityShopEvent) : void
      {
         var _loc3_:int = 1;
         var _loc2_:int = 1;
         _pageTxt.text = model.currentPage + "/" + model.totalPage;
         _lastPageBtn.enable = model.currentPage != 1;
         _nextPageBtn.enable = model.currentPage != model.totalPage;
         updateExchangeGoodsListData();
      }
      
      private function updateExchangeGoodsListData() : void
      {
         var _loc2_:OuterCityShopItemInfo = null;
         var _loc1_:int = 0;
         if(model.showGoodsList)
         {
            _loc1_ = 0;
            while(_loc1_ < _exchangeList.length)
            {
               if(model.showGoodsList[_loc1_])
               {
                  _loc2_ = new OuterCityShopItemInfo();
                  _loc2_.isBuy = false;
                  _loc2_.itemTemInfo = model.showGoodsList[_loc1_] as OuterCityShopGoodsInfo;
                  if(_loc2_.itemTemInfo.Point > 0)
                  {
                     _loc2_.costInfos.push([-400,_loc2_.itemTemInfo.Point]);
                  }
                  if(_loc2_.itemTemInfo.Score > 0)
                  {
                     _loc2_.costInfos.push(["Score",_loc2_.itemTemInfo.Score]);
                  }
                  if(_loc2_.itemTemInfo.SecretStone > 0)
                  {
                     _loc2_.costInfos.push([2131057,_loc2_.itemTemInfo.SecretStone]);
                  }
                  if(_loc2_.itemTemInfo.Strategy > 0)
                  {
                     _loc2_.costInfos.push([-300,_loc2_.itemTemInfo.Strategy]);
                  }
                  if(_loc2_.itemTemInfo.Crystal > 0)
                  {
                     _loc2_.costInfos.push([-600,_loc2_.itemTemInfo.Crystal]);
                  }
                  _exchangeList[_loc1_].data = _loc2_;
               }
               else
               {
                  _exchangeList[_loc1_].data = null;
               }
               _loc1_++;
            }
         }
      }
      
      private function __onPageHandler(param1:MouseEvent) : void
      {
         outercityShopControler.pageBtnHandler(param1.currentTarget == _lastPageBtn);
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
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

