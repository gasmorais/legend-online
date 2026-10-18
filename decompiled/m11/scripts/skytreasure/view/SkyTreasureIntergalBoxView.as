package skytreasure.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class SkyTreasureIntergalBoxView extends Sprite implements Disposeable
   {
      
      private var _boxIndex:int;
      
      private var keduImg:Bitmap;
      
      private var keduValueImg:ScaleFrameImage;
      
      public function SkyTreasureIntergalBoxView()
      {
         super();
         initView();
      }
      
      public function get boxIndex() : int
      {
         return _boxIndex;
      }
      
      private function initView() : void
      {
         keduImg = ComponentFactory.Instance.creatBitmap("asset.skytreasure.line");
         addChildAt(keduImg,0);
         keduValueImg = ComponentFactory.Instance.creatComponentByStylename("skytreasure.keduValueImg");
         addChild(keduValueImg);
      }
      
      public function set boxIndex(param1:int) : void
      {
         if(keduValueImg)
         {
            keduValueImg.setFrame(param1);
         }
         if(keduImg)
         {
            addChildAt(keduImg,0);
         }
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(keduImg);
         keduImg = null;
         ObjectUtils.disposeObject(keduValueImg);
         keduValueImg = null;
      }
   }
}

