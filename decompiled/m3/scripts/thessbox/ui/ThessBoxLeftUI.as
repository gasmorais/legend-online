package thessbox.ui
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class ThessBoxLeftUI extends Sprite
   {
      
      protected var _leftBg:MutipleImage;
      
      protected var _leftBg1:Bitmap;
      
      protected var _levelTxt:FilterFrameText;
      
      protected var _leftBagBtn:BaseButton;
      
      protected var _ftmg:ScaleFrameImage;
      
      protected var _ArrowImg:Bitmap;
      
      protected var _desTxt:FilterFrameText;
      
      public function ThessBoxLeftUI()
      {
         super();
         initView();
      }
      
      protected function initView() : void
      {
         _leftBg = ComponentFactory.Instance.creatComponentByStylename("ui.thessbox.leftBg");
         _leftBg1 = ComponentFactory.Instance.creatBitmap("asset.thessbox.leftBg1");
         _levelTxt = ComponentFactory.Instance.creatComponentByStylename("ui.thessbox.levelTxt");
         _leftBagBtn = ComponentFactory.Instance.creatComponentByStylename("ui.thessbox.leftBagBtn");
         _ftmg = ComponentFactory.Instance.creatComponentByStylename("ui.thessbox.ftmg");
         _ArrowImg = ComponentFactory.Instance.creatBitmap("asset.thessbox.ArrowImg");
         _desTxt = ComponentFactory.Instance.creatComponentByStylename("ui.thessbox.addIconSkTxt");
         addChild(_leftBg);
         addChild(_leftBg1);
         addChild(_levelTxt);
         addChild(_leftBagBtn);
         addChild(_ftmg);
         addChild(_ArrowImg);
         addChild(_desTxt);
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_leftBg);
         _leftBg = null;
         ObjectUtils.disposeObject(_leftBg1);
         _leftBg1 = null;
         ObjectUtils.disposeObject(_levelTxt);
         _levelTxt = null;
         ObjectUtils.disposeObject(_leftBagBtn);
         _leftBagBtn = null;
         ObjectUtils.disposeObject(_ftmg);
         _ftmg = null;
         ObjectUtils.disposeObject(_ArrowImg);
         _ArrowImg = null;
         ObjectUtils.disposeObject(_desTxt);
         _desTxt = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

