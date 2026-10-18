package com.map.vehicle.data
{
   public class TankState
   {
      
      public static var Stop:int = 0;
      
      public static var Run:int = 1;
      
      public static var BeAtk:int = 2;
      
      public static var Die:int = 3;
      
      public static var Pickup:int = 4;
      
      public static var Casting:int = 5;
      
      public static var Stun:int = 6;
      
      public function TankState()
      {
         super();
      }
      
      public static function isStrongControl(param1:int) : Boolean
      {
         var _loc2_:Boolean = false;
         var _loc3_:int = param1;
         if(TankState.Stun === _loc3_)
         {
            _loc2_ = true;
         }
         return _loc2_;
      }
   }
}

