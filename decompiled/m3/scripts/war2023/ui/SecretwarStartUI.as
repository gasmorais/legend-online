package war2023.ui
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class SecretwarStartUI extends Sprite
   {
      
      protected var _waitStartBg:Bitmap;
      
      protected var _waitStartFt:Bitmap;
      
      public function SecretwarStartUI()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _waitStartBg = ComponentFactory.Instance.creatBitmap("asset.secretwar.waitStartBg");
         _waitStartFt = ComponentFactory.Instance.creatBitmap("asset.secretwar.waitStartFt");
         addChild(_waitStartBg);
         addChild(_waitStartFt);
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_waitStartBg);
         _waitStartBg = null;
         ObjectUtils.disposeObject(_waitStartFt);
         _waitStartFt = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

