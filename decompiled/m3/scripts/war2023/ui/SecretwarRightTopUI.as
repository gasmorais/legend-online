package war2023.ui
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class SecretwarRightTopUI extends Sprite
   {
      
      protected var _righttop:Bitmap;
      
      protected var _flg:Bitmap;
      
      protected var _ft0:Bitmap;
      
      public function SecretwarRightTopUI()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _righttop = ComponentFactory.Instance.creatBitmap("asset.secretwar.righttop");
         _flg = ComponentFactory.Instance.creatBitmap("asset.secretwar.right.flg");
         _ft0 = ComponentFactory.Instance.creatBitmap("asset.secretwar.right.ft0");
         addChild(_righttop);
         addChild(_flg);
         addChild(_ft0);
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_righttop);
         _righttop = null;
         ObjectUtils.disposeObject(_flg);
         _flg = null;
         ObjectUtils.disposeObject(_ft0);
         _ft0 = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

