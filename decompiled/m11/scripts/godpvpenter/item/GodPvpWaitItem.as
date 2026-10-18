package godpvpenter.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   
   public class GodPvpWaitItem extends Sprite
   {
      
      public var _wait:Bitmap;
      
      public var _waitTxt:FilterFrameText;
      
      public function GodPvpWaitItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _wait = ComponentFactory.Instance.creatBitmap("asset.godpvpenter.wait");
         _waitTxt = ComponentFactory.Instance.creatComponentByStylename("ui.godpvpenter.waitTxt");
         addChild(_wait);
         addChild(_waitTxt);
         _waitTxt.text = LanguageMgr.GetTranslation("secret.frame.will");
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_wait);
         _wait = null;
         ObjectUtils.disposeObject(_waitTxt);
         _waitTxt = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

