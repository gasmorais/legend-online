package battle.view.utils
{
   import flash.display.Sprite;
   
   public class DepthSprite extends Sprite
   {
      
      private var _pointZ:Number = 0;
      
      private var _pointY:Number = 0;
      
      public function DepthSprite()
      {
         super();
      }
      
      public function get pointZ() : Number
      {
         return _pointZ;
      }
      
      public function set pointZ(param1:Number) : void
      {
         _pointZ = param1;
      }
      
      public function get pointY() : Number
      {
         return _pointY;
      }
      
      public function set pointY(param1:Number) : void
      {
         _pointY = param1;
      }
   }
}

