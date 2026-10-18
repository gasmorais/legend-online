package chess
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class SelfChessRecycleView extends Sprite
   {
      
      public var _sell:Bitmap;
      
      public function SelfChessRecycleView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _sell = ComponentFactory.Instance.creatBitmap("asset.selfchess.sell");
         addChild(_sell);
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_sell);
         _sell = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

