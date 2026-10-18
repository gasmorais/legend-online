package auction.view.supermarket
{
   import auction.SupermarketFrame;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.MysteryShopManager;
   import mvc.module.auction.MysteryShopModel;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.view.tips.MessageTipManager;
   
   public class MysteryShopView extends Sprite implements Disposeable
   {
      
      private var _icon:Bitmap;
      
      private var _text:FilterFrameText;
      
      private var _mask:Bitmap;
      
      private var _enterBtn:IconButton;
      
      private var _shape:Shape;
      
      public function MysteryShopView()
      {
         super();
         init();
         initEvent();
      }
      
      private function init() : void
      {
         _icon = ComponentFactory.Instance.creatBitmap("asset.auction.MysteryShopIcon");
         _mask = ComponentFactory.Instance.creatBitmap("asset.auction.Mask");
         _text = ComponentFactory.Instance.creatComponentByStylename("auction.DescribeText");
         _enterBtn = ComponentFactory.Instance.creatComponentByStylename("auction.MysteryShopButton");
         createShape();
         addChild(_icon);
         addChild(_text);
         addChild(_enterBtn);
         addChild(_mask);
         addChild(_shape);
         _text.text = LanguageMgr.GetTranslation("auction.view.supermarket.MysteryShopView.text");
      }
      
      private function createShape() : void
      {
         _shape = new Shape();
         _shape.graphics.beginFill(65535,0);
         _shape.graphics.drawRect(0,0,_mask.width,_mask.height);
      }
      
      private function initEvent() : void
      {
         _enterBtn.addEventListener("click",__enterHandler);
         addEventListener("mouseOver",__overHandler);
      }
      
      private function removeEvent() : void
      {
         _enterBtn.removeEventListener("click",__enterHandler);
         removeEventListener("mouseOver",__overHandler);
      }
      
      public function get enterBtn() : IconButton
      {
         return _enterBtn;
      }
      
      private function __overHandler(param1:MouseEvent) : void
      {
         _mask.visible = false;
         (parent.parent as SupermarketFrame).auctionShopView.showMask.visible = true;
      }
      
      public function get showMask() : Bitmap
      {
         return _mask;
      }
      
      private function __enterHandler(param1:MouseEvent) : void
      {
         var _loc3_:String = null;
         var _loc2_:String = null;
         if(ArmyManager.instance.thane.grades < 26)
         {
            _loc3_ = LanguageMgr.GetTranslation("auction.view.supermarket.MysteryShopView.gradesTipData");
            MessageTipManager.instance().show(_loc3_);
            return;
         }
         if(mysteryShopModel.buyCount >= mysteryShopModel.maxBuyCount)
         {
            _loc2_ = LanguageMgr.GetTranslation("auction.view.mysteryshop.BuyGoodsItem.buyTipData");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         SoundManager.instance.play("022");
         FrameControllerManager.instance.openControllerByInfo("mysteryshop");
      }
      
      private function get mysteryShopModel() : MysteryShopModel
      {
         return MysteryShopManager.instance.model;
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

