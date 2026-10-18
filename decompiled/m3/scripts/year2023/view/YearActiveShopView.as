package year2023.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import managers.ShopManager;
   import mvc.module.shop.ShopGoodsInfo;
   import mvc.module.shop.ShopModel;
   import utils.LogicUtils;
   import year2023.item.YearActiveGoodsItem;
   import year2023.item.YearActivePointItem;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.FrameControllerManager;
   
   public class YearActiveShopView extends Component
   {
      
      private var _data:ShopModel;
      
      private var _itemList:Vector.<YearActiveGoodsItem>;
      
      private var _girl:Bitmap;
      
      private var _scrollPanel:ScrollPanel;
      
      private var _container:Sprite;
      
      private var _goldPrice:YearActivePointItem;
      
      public function YearActiveShopView()
      {
         x = 66;
         y = 96;
         super();
         initData();
         initView();
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         _loc2_ = 3;
         var _loc1_:YearActiveGoodsItem = null;
         var _loc4_:int = 0;
         _girl = ComponentFactory.Instance.creatBitmap("asset.SevenYearShop.girl");
         addChild(_girl);
         _goldPrice = ComponentFactory.Instance.creatCustomObject("ui.yearactive.shopGoldPrice");
         addChild(_goldPrice);
         _container = new Sprite();
         addChild(_container);
         _data = FrameControllerManager.instance.shopController.model;
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         _itemList = new Vector.<YearActiveGoodsItem>();
         _loc4_ = 0;
         while(_loc4_ < model.showGoodsList.length)
         {
            _loc1_ = new YearActiveGoodsItem();
            _loc5_ = _loc4_ / 3;
            _loc3_ = _loc4_ % 3;
            _loc1_.x = _loc3_ * (_loc1_.width - 5);
            _loc1_.y = _loc5_ * _loc1_.height;
            _container.addChild(_loc1_);
            _itemList.push(_loc1_);
            _loc4_++;
         }
         _loc4_ = 0;
         while(_loc4_ < model.showGoodsList.length)
         {
            _itemList[_loc4_].data = ShopGoodsInfo(model.showGoodsList[_loc4_]);
            _loc4_++;
         }
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("yearactive.shop.ScrollPanel");
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
         ObjectUtils.disposeObject(_goldPrice);
         _goldPrice = null;
         _data = null;
      }
      
      private function initData() : void
      {
         FrameControllerManager.instance.shopController.inityearActiveShopFrame();
      }
      
      private function __onSignClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         dispose();
      }
      
      override public function dispose() : void
      {
         KeyBoardRegister.instance.keyEnable = true;
         uninitView();
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
         _data = null;
      }
   }
}

