package marry.income
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class SatisfactoryHeartView extends Sprite implements Disposeable
   {
      
      public function SatisfactoryHeartView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
      }
      
      public function setLevel(param1:int) : void
      {
         var _loc2_:int = 0;
         var _loc4_:String = null;
         var _loc5_:int = 0;
         var _loc3_:Bitmap = null;
         dispose();
         if(param1 < 9)
         {
            _loc2_ = param1;
            _loc4_ = "asset.marry.marryHeartBlock_";
         }
         else
         {
            _loc2_ = param1 - 9;
            _loc4_ = "asset.marry.marryHeartBlockI_";
         }
         _loc5_ = 1;
         while(_loc5_ <= 18)
         {
            _loc3_ = ComponentFactory.Instance.creatBitmap(_loc4_ + _loc5_);
            addChild(_loc3_);
            if(_loc5_ > _loc2_ * 2)
            {
               _loc3_.alpha = 0.5;
            }
            _loc5_++;
         }
      }
      
      public function dispose() : void
      {
         var _loc1_:Bitmap = null;
         while(this.numChildren > 0)
         {
            _loc1_ = this.getChildAt(0) as Bitmap;
            this.removeChild(_loc1_);
            _loc1_.bitmapData.dispose();
         }
      }
   }
}

