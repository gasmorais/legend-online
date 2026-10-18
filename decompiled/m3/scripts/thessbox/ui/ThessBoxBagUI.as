package thessbox.ui
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class ThessBoxBagUI extends Sprite
   {
      
      protected var _bagImg:Bitmap;
      
      protected var _pos1:Image;
      
      protected var _pos2:Image;
      
      protected var _pos3:Image;
      
      public function ThessBoxBagUI()
      {
         super();
         initView();
      }
      
      protected function initView() : void
      {
         _bagImg = ComponentFactory.Instance.creatBitmap("asset.thessbox.bagImg");
         _pos1 = ComponentFactory.Instance.creatComponentByStylename("ui.thessbox.pos1");
         _pos2 = ComponentFactory.Instance.creatComponentByStylename("ui.thessbox.pos2");
         _pos3 = ComponentFactory.Instance.creatComponentByStylename("ui.thessbox.pos3");
         addChild(_bagImg);
         addChild(_pos1);
         addChild(_pos2);
         addChild(_pos3);
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_bagImg);
         _bagImg = null;
         ObjectUtils.disposeObject(_pos1);
         _pos1 = null;
         ObjectUtils.disposeObject(_pos2);
         _pos2 = null;
         ObjectUtils.disposeObject(_pos3);
         _pos3 = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

