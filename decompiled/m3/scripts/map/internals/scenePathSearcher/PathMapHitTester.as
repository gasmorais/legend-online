package map.internals.scenePathSearcher
{
   import flash.display.Sprite;
   import flash.geom.Point;
   import map.outercity.path.PathIHitTester;
   
   public class PathMapHitTester implements PathIHitTester
   {
      
      private var mc:Sprite;
      
      private var _titles:Object;
      
      public function PathMapHitTester(param1:Sprite)
      {
         super();
         this.mc = param1;
      }
      
      public function set titles(param1:Object) : void
      {
         _titles = param1;
      }
      
      public function isHit(param1:Point) : Boolean
      {
         return _titles[int(param1.x / 20) + "_" + int(param1.y / 20)] ? false : true;
      }
      
      public function getNextMoveAblePoint(param1:Point, param2:Number, param3:Number, param4:Number) : Point
      {
         var _loc5_:Number = 0;
         while(isHit(param1))
         {
            param1 = Geometry.nextPoint(param1,param2,param3);
            _loc5_ += param3;
            if(_loc5_ > param4)
            {
               return null;
            }
         }
         return param1;
      }
   }
}

