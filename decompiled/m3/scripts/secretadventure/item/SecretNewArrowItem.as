package secretadventure.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   
   public class SecretNewArrowItem extends Sprite
   {
      
      private var _row:MovieClip;
      
      private var _bg:MovieClip;
      
      private var _des:FilterFrameText;
      
      public function SecretNewArrowItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _des = ComponentFactory.Instance.creatComponentByStylename("ui.secret.newArrow.desTxt");
         _row = ComponentFactory.Instance.creatCustomObject("asset.secret.newArrow");
         _bg = ComponentFactory.Instance.creatCustomObject("asset.secret.newTipBg");
         addChild(_bg);
         addChild(_des);
         addChild(_row);
         mouseChildren = mouseEnabled = false;
         _des.text = LanguageMgr.GetTranslation("secret.newArrow.tip");
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_des);
         _des = null;
         ObjectUtils.disposeViolentMc(_bg);
         _bg = null;
         ObjectUtils.disposeViolentMc(_row);
         _row = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

