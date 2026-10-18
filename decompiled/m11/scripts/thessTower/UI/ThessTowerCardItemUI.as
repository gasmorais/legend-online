package thessTower.UI
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class ThessTowerCardItemUI extends Sprite
   {
      
      protected var _in:Image;
      
      protected var _lock:Bitmap;
      
      protected var _idx:FilterFrameText;
      
      protected var _cardPass:Image;
      
      protected var _cardBg:ScaleFrameImage;
      
      public function ThessTowerCardItemUI()
      {
         super();
         initView();
      }
      
      protected function initView() : void
      {
         _in = ComponentFactory.Instance.creatComponentByStylename("ui.thesstower.in");
         _lock = ComponentFactory.Instance.creatBitmap("asset.thessTower.lock");
         _idx = ComponentFactory.Instance.creatComponentByStylename("ui.thesstower.idx");
         _cardPass = ComponentFactory.Instance.creatComponentByStylename("ui.thesstower.cardPass");
         _cardBg = ComponentFactory.Instance.creatComponentByStylename("ui.thesstower.cardBg");
         addChild(_cardBg);
         addChild(_in);
         addChild(_lock);
         addChild(_cardPass);
         addChild(_idx);
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_in);
         _in = null;
         ObjectUtils.disposeObject(_lock);
         _lock = null;
         ObjectUtils.disposeObject(_idx);
         _idx = null;
         ObjectUtils.disposeObject(_cardPass);
         _cardPass = null;
         ObjectUtils.disposeObject(_cardBg);
         _cardBg = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

