package map.space.helper.mapview
{
   import flash.display.DisplayObject;
   import flash.geom.Rectangle;
   
   public class SpaceMapViewHelper
   {
      
      private static const startY:int = 0;
      
      private static const startX:int = -30;
      
      public function SpaceMapViewHelper()
      {
         super();
      }
      
      public static function checkDistance(param1:int, param2:int, param3:int, param4:int) : int
      {
         var _loc5_:Number = (param1 - param3) * (param1 - param3) + (param2 - param4) * (param2 - param4);
         return Math.sqrt(_loc5_);
      }
      
      public static function getCurrentMapRect(param1:DisplayObject) : Rectangle
      {
         var _loc2_:Rectangle = new Rectangle();
         _loc2_.x = -param1.x + param1.stage.stageWidth / 2;
         _loc2_.y = -param1.y + param1.stage.stageHeight / 2;
         _loc2_.width = param1.stage.stageWidth;
         _loc2_.height = param1.stage.stageHeight;
         return _loc2_;
      }
   }
}

