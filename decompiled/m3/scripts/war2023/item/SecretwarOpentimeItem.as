package war2023.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class SecretwarOpentimeItem extends Sprite
   {
      
      protected var _openTimeFt:Bitmap;
      
      protected var _openTimeTxt:FilterFrameText;
      
      public function SecretwarOpentimeItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _openTimeFt = ComponentFactory.Instance.creatBitmap("asset.secretwar.openTimeFt");
         _openTimeTxt = ComponentFactory.Instance.creatComponentByStylename("ui.secretwar.openTimeTxt");
         addChild(_openTimeFt);
         addChild(_openTimeTxt);
      }
      
      public function setText(param1:String) : void
      {
         _openTimeTxt.text = param1;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_openTimeFt);
         _openTimeFt = null;
         ObjectUtils.disposeObject(_openTimeTxt);
         _openTimeTxt = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

