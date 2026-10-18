package map.outercity.helper.mapview
{
   import flash.geom.Point;
   import map.outercity.OuterCityModel;
   
   public class GetWalkStartPointHelper
   {
      
      public function GetWalkStartPointHelper()
      {
         super();
      }
      
      public static function getStartPoint(param1:int, param2:int, param3:OuterCityModel) : Point
      {
         var _loc4_:Point = new Point(param1,param2);
         var _loc5_:Boolean = Boolean(param3.getWalkable(param1,param2));
         if(!_loc5_)
         {
            return _loc4_;
         }
         _loc5_ = Boolean(param3.getWalkable(param1 - 20,param2));
         if(!_loc5_)
         {
            _loc4_.x = param1 - 20;
            return _loc4_;
         }
         _loc5_ = Boolean(param3.getWalkable(param1 - 20,param2 + 20));
         if(!_loc5_)
         {
            _loc4_.x = param1 - 20;
            _loc4_.y = param2 + 20;
            return _loc4_;
         }
         _loc5_ = Boolean(param3.getWalkable(param1 - 20,param2 - 20));
         if(!_loc5_)
         {
            _loc4_.x = param1 - 20;
            _loc4_.y = param2 - 20;
            return _loc4_;
         }
         _loc5_ = Boolean(param3.getWalkable(param1 + 20,param2 - 20));
         if(!_loc5_)
         {
            _loc4_.x = param1 + 20;
            _loc4_.y = param2 - 20;
            return _loc4_;
         }
         _loc5_ = Boolean(param3.getWalkable(param1 + 20,param2 + 20));
         if(!_loc5_)
         {
            _loc4_.x = param1 + 20;
            _loc4_.y = param2 + 20;
            return _loc4_;
         }
         _loc5_ = Boolean(param3.getWalkable(param1 + 20,param2));
         if(!_loc5_)
         {
            _loc4_.x = param1 + 20;
            return _loc4_;
         }
         _loc5_ = Boolean(param3.getWalkable(param1,param2 + 20));
         if(!_loc5_)
         {
            _loc4_.y = param2 + 20;
            return _loc4_;
         }
         _loc5_ = Boolean(param3.getWalkable(param1,param2 - 20));
         if(!_loc5_)
         {
            _loc4_.y = param2 - 20;
            return _loc4_;
         }
         return _loc4_;
      }
   }
}

