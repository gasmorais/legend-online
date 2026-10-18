package auction.view.supermarket
{
   import auction.SupermarketFrame;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import yishi.manager.FrameControllerManager;
   
   public class AuctionShopView extends Sprite implements Disposeable
   {
      
      private var _icon:Bitmap;
      
      private var _text:FilterFrameText;
      
      private var _mask:Bitmap;
      
      private var _enterBtn:IconButton;
      
      private var _shape:Shape;
      
      public function AuctionShopView()
      {
         super();
         init();
         initEvent();
      }
      
      private function init() : void
      {
         _icon = ComponentFactory.Instance.creatBitmap("asset.auction.AuctionShopIcon");
         _mask = ComponentFactory.Instance.creatBitmap("asset.auction.Mask");
         _text = ComponentFactory.Instance.creatComponentByStylename("auction.DescribeText");
         _enterBtn = ComponentFactory.Instance.creatComponentByStylename("auction.AuctionShopButton");
         createShape();
         addChild(_icon);
         addChild(_text);
         addChild(_enterBtn);
         addChild(_mask);
         addChild(_shape);
         _text.text = LanguageMgr.GetTranslation("auction.view.supermarket.AuctionShopView.text");
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
         (parent.parent as SupermarketFrame).mysteryShopView.showMask.visible = true;
      }
      
      public function get showMask() : Bitmap
      {
         return _mask;
      }
      
      private function __enterHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("auction");
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

