package war2023.ui
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class SecretWarEnterUI extends Sprite
   {
      
      protected var _enterbg:Bitmap;
      
      protected var _enterTxtBg:ScaleBitmapImage;
      
      protected var _overtimeFt:Bitmap;
      
      protected var _shopBtn:BaseButton;
      
      protected var _enterBtn:IconButton;
      
      public function SecretWarEnterUI()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _enterbg = ComponentFactory.Instance.creatBitmap("asset.secretwar.enterbg");
         _overtimeFt = ComponentFactory.Instance.creatBitmap("asset.secretwar.overtimeFt");
         _shopBtn = ComponentFactory.Instance.creatComponentByStylename("ui.secretwar.shopBtn");
         _enterBtn = ComponentFactory.Instance.creatComponentByStylename("ui.secretwar.enterBtn");
         _enterTxtBg = ComponentFactory.Instance.creatComponentByStylename("ui.secretwar.enterTxtBg");
         addChild(_enterbg);
         addChild(_enterTxtBg);
         addChild(_overtimeFt);
         addChild(_shopBtn);
         addChild(_enterBtn);
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_enterbg);
         _enterbg = null;
         ObjectUtils.disposeObject(_overtimeFt);
         _overtimeFt = null;
         ObjectUtils.disposeObject(_shopBtn);
         _shopBtn = null;
         ObjectUtils.disposeObject(_enterBtn);
         _enterBtn = null;
         ObjectUtils.disposeObject(_enterTxtBg);
         _enterTxtBg = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

