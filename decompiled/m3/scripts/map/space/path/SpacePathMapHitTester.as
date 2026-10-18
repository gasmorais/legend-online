package map.space.path
{
   import flash.display.Sprite;
   import flash.geom.Point;
   import map.internals.scenePathSearcher.Geometry;
   import map.space.SpaceManager;
   
   public class SpacePathMapHitTester implements SpacePathIHitTester
   {
      
      private var mc:Sprite;
      
      public function SpacePathMapHitTester(param1:Sprite)
      {
         super();
         this.mc = param1;
      }
      
      public function isHit(param1:Point) : Boolean
      {
         return SpaceManager.instance.model.getWalkable(param1.x,param1.y);
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

