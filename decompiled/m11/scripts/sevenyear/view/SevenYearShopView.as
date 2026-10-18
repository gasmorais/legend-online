package sevenyear.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import managers.PlayerCurrencyManager;
   import managers.ShopManager;
   import mvc.module.currency.PlayerCurrencyInfo;
   import mvc.module.shop.ShopGoodsInfo;
   import mvc.module.shop.ShopModel;
   import sevenyear.view.item.SevenYearShopGoodsItem;
   import utils.LogicUtils;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.FrameControllerManager;
   
   public class SevenYearShopView extends Component
   {
      
      private var _data:ShopModel;
      
      private var _itemList:Vector.<SevenYearShopGoodsItem>;
      
      private var _currencyInfo:PlayerCurrencyInfo = PlayerCurrencyManager.instance.currencyInfo;
      
      private var _girl:Bitmap;
      
      private var _scrollPanel:ScrollPanel;
      
      private var _container:Sprite;
      
      public function SevenYearShopView()
      {
         super();
         initData();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         var _loc1_:SevenYearShopGoodsItem = null;
         var _loc3_:int = 0;
         _girl = ComponentFactory.Instance.creatBitmap("asset.SevenYearShop.girl");
         addChild(_girl);
         _container = new Sprite();
         addChild(_container);
         _data = FrameControllerManager.instance.shopController.model;
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         _itemList = new Vector.<SevenYearShopGoodsItem>();
         _loc3_ = 0;
         while(_loc3_ < model.showGoodsList.length)
         {
            _loc1_ = new SevenYearShopGoodsItem();
            _loc4_ = _loc3_ / 3;
            _loc2_ = _loc3_ % 3;
            _loc1_.x = _loc2_ * (_loc1_.width - 5);
            _loc1_.y = _loc4_ * _loc1_.height;
            _container.addChild(_loc1_);
            _itemList.push(_loc1_);
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < model.showGoodsList.length)
         {
            _itemList[_loc3_].data = ShopGoodsInfo(model.showGoodsList[_loc3_]);
            _loc3_++;
         }
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("sevenyear.shop.ScrollPanel");
         _scrollPanel.beginChanges();
         _scrollPanel.setView(_container);
         _scrollPanel.invalidateViewport();
         addChild(_scrollPanel);
      }
      
      public function get model() : ShopModel
      {
         return ShopManager.Instance.model;
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_girl);
         _girl = null;
         ObjectUtils.disposeObject(_scrollPanel);
         _scrollPanel = null;
         ObjectUtils.disposeObject(_container);
         _container = null;
         LogicUtils.disposeDisplayCollection(_itemList);
         _itemList = null;
         _data = null;
      }
      
      private function initData() : void
      {
         FrameControllerManager.instance.shopController.initSevenYearShopFrame();
      }
      
      private function addEvent() : void
      {
      }
      
      private function removeEvent() : void
      {
      }
      
      private function __onSignClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         dispose();
      }
      
      override public function dispose() : void
      {
         KeyBoardRegister.instance.keyEnable = true;
         ObjectUtils.disposeAllChildren(this);
         removeEvent();
         uninitView();
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

