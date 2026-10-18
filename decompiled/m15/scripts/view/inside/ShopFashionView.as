package view.inside
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import mvc.module.fashion.FashionModel;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.RechargeAlertMannager;
   
   public class ShopFashionView extends Sprite implements Disposeable
   {
      
      private var _back:ScaleBitmapImage;
      
      private var _showView:FashionShowView;
      
      private var _listView:FashionGoodsListView;
      
      private var _hGap:Bitmap;
      
      private var _vGap:Bitmap;
      
      private var _recharge:IconButton;
      
      private var _shopCartBtn:IconButton;
      
      public function ShopFashionView()
      {
         super();
         fashionModel.scene = "SHOP_SCENE";
         initView();
         initEvent();
         defaultTryOn();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("shop.fashionBack");
         _hGap = ComponentFactory.Instance.creatBitmap("asset.shop.fashionHGap");
         _vGap = ComponentFactory.Instance.creatBitmap("asset.shop.fashionVGap");
         _recharge = ComponentFactory.Instance.creatComponentByStylename("shop.fashionChargeBtn");
         _shopCartBtn = ComponentFactory.Instance.creatComponentByStylename("shop.fashionShopCartBtn");
         _showView = new FashionShowView();
         _listView = new FashionGoodsListView();
         _listView.x = 360;
         _listView.y = 32;
         addChild(_back);
         addChild(_showView);
         _showView.x = 2;
         _showView.y = 30;
         addChild(_listView);
         addChild(_recharge);
         _recharge.x = 785;
         _recharge.y = 445;
         addChild(_shopCartBtn);
         addChild(_hGap);
         addChild(_vGap);
      }
      
      private function initEvent() : void
      {
         if(_recharge)
         {
            _recharge.addEventListener("click",__onRechargeHandler);
         }
         if(_shopCartBtn)
         {
            _shopCartBtn.addEventListener("click",__onShopCartBtnHandler);
         }
      }
      
      private function removeEvent() : void
      {
         if(_recharge)
         {
            _recharge.removeEventListener("click",__onRechargeHandler);
         }
         if(_shopCartBtn)
         {
            _shopCartBtn.removeEventListener("click",__onShopCartBtnHandler);
         }
      }
      
      private function defaultTryOn() : void
      {
         if(fashionModel.tryOnShopInfo)
         {
            fashionModel.wearFahion(fashionModel.tryOnShopInfo);
            fashionModel.tryOnShopInfo = null;
         }
      }
      
      private function __onRechargeHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         RechargeAlertMannager.navigateToRechargePage();
      }
      
      private function __onShopCartBtnHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("shop",200);
      }
      
      private function get fashionModel() : FashionModel
      {
         return FrameControllerManager.instance.fashionCodeController.model;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_showView);
         _showView = null;
         ObjectUtils.disposeObject(_listView);
         _listView = null;
         ObjectUtils.disposeObject(_hGap);
         _hGap = null;
         ObjectUtils.disposeObject(_vGap);
         _vGap = null;
         ObjectUtils.disposeObject(_recharge);
         _recharge = null;
         ObjectUtils.disposeObject(_shopCartBtn);
         _shopCartBtn = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

