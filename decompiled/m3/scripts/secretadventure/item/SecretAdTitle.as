package secretadventure.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   
   public class SecretAdTitle extends Sprite
   {
      
      private var _ftWait:Bitmap;
      
      private var _itemTxt:FilterFrameText;
      
      private var _fntTitle:ScaleFrameImage;
      
      public function SecretAdTitle()
      {
         super();
      }
      
      public function loadTitle(param1:int) : void
      {
         if(_fntTitle == null)
         {
            _fntTitle = ComponentFactory.Instance.creatComponentByStylename("ui.secretadProgress.titleFnt");
            addChild(_fntTitle);
         }
         _fntTitle.setFrame(param1);
      }
      
      public function preNull() : void
      {
         _ftWait = ComponentFactory.Instance.creatBitmap("asset.secretad.ftWait");
         _itemTxt = ComponentFactory.Instance.creatComponentByStylename("ui.secretadventure.itemTxt");
         addChild(_ftWait);
         addChild(_itemTxt);
         _itemTxt.text = LanguageMgr.GetTranslation("secret.open.wait");
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_ftWait);
         _ftWait = null;
         ObjectUtils.disposeObject(_itemTxt);
         _itemTxt = null;
         ObjectUtils.disposeObject(_fntTitle);
         _fntTitle = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

