package theseus.war.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import theseus.war.utils.TheseusWarBitPool;
   
   public class TheseusStarItem extends Sprite
   {
      
      private var _starBit:Bitmap;
      
      private var _starNumTxt:FilterFrameText;
      
      private var _space:int;
      
      public function TheseusStarItem(param1:int)
      {
         super();
         _space = param1;
         initView();
         mouseEnabled = false;
      }
      
      private function initView() : void
      {
         _starBit = new Bitmap();
         addChild(_starBit);
         _starNumTxt = ComponentFactory.Instance.creatComponentByStylename("ui.theseussoul.starNumTxt");
         addChild(_starNumTxt);
      }
      
      public function showStar(param1:int) : void
      {
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc7_:int = 0;
         var _loc3_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = (param1 - 1) / 5 + 1;
         if(param1 > 0)
         {
            _starNumTxt.setFrame(_loc6_ + 1);
            _loc4_ = _loc6_ * 5;
            _loc7_ = (_loc6_ - 1) * 5;
            _loc5_ = 0;
            while(_loc5_ < 5)
            {
               _loc3_ = _loc7_ + _loc5_;
               if(param1 > _loc3_ && _loc6_ > 0)
               {
                  _loc2_++;
               }
               _loc5_++;
            }
            _starNumTxt.text = "" + _loc2_;
            _starBit.bitmapData = TheseusWarBitPool.Ins.getStarBitmapData(_loc6_);
         }
         else
         {
            _starNumTxt.text = "";
            _starBit.bitmapData = null;
         }
      }
      
      public function dispose() : void
      {
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

