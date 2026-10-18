package yishi.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   
   public class HeroProfileTip extends BaseTip
   {
      
      private var _content:Bitmap;
      
      public function HeroProfileTip()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         _bg.width = 235;
         _bg.height = 65;
         _content = ComponentFactory.Instance.creatBitmap("asset.tips.HerprofileTipAsset");
         addChild(_content);
      }
      
      override public function dispose() : void
      {
         if(_content)
         {
            ObjectUtils.disposeObject(_content);
         }
         _content = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

