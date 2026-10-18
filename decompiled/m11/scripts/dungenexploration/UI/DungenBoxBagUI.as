package dungenexploration.UI
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class DungenBoxBagUI extends Sprite
   {
      
      protected var _bagImg:Bitmap;
      
      public function DungenBoxBagUI()
      {
         super();
         initView();
      }
      
      protected function initView() : void
      {
         _bagImg = ComponentFactory.Instance.creatBitmap("asset.dungenexplo.skillbg");
         addChild(_bagImg);
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_bagImg);
         _bagImg = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

