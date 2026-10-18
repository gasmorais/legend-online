package thessbox.ui
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import yishi.view.community.BaseIconView;
   
   public class ThessBoxSkillItemUI extends Sprite
   {
      
      protected var _skBg:Bitmap;
      
      protected var _sknameTxt:FilterFrameText;
      
      protected var _skDesTxt:FilterFrameText;
      
      protected var _skCdTxt:FilterFrameText;
      
      protected var _skIconBg:Bitmap;
      
      protected var _skicon:BaseIconView;
      
      public function ThessBoxSkillItemUI()
      {
         super();
         initView();
      }
      
      protected function initView() : void
      {
         _skBg = ComponentFactory.Instance.creatBitmap("asset.thessbox.skBg");
         _sknameTxt = ComponentFactory.Instance.creatComponentByStylename("ui.thessbox.sknameTxt");
         _skDesTxt = ComponentFactory.Instance.creatComponentByStylename("ui.thessbox.skDesTxt");
         _skCdTxt = ComponentFactory.Instance.creatComponentByStylename("ui.thessbox.skCdTxt");
         _skIconBg = ComponentFactory.Instance.creatBitmap("asset.thessbox.skIconBg");
         _skicon = ComponentFactory.Instance.creatCustomObject("ui.thessbox.skicon");
         addChild(_skBg);
         addChild(_sknameTxt);
         addChild(_skDesTxt);
         addChild(_skCdTxt);
         addChild(_skIconBg);
         addChild(_skicon);
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_skBg);
         _skBg = null;
         ObjectUtils.disposeObject(_sknameTxt);
         _sknameTxt = null;
         ObjectUtils.disposeObject(_skDesTxt);
         _skDesTxt = null;
         ObjectUtils.disposeObject(_skCdTxt);
         _skCdTxt = null;
         ObjectUtils.disposeObject(_skIconBg);
         _skIconBg = null;
         ObjectUtils.disposeObject(_skicon);
         _skicon = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

