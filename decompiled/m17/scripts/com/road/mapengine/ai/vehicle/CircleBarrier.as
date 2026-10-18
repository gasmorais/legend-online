package com.road.mapengine.ai.vehicle
{
   public class CircleBarrier extends Vehicle
   {
      
      private var _radius:Number;
      
      public function CircleBarrier()
      {
         super();
      }
      
      public function get radius() : Number
      {
         return _radius;
      }
      
      public function set radius(param1:Number) : void
      {
         _radius = param1;
      }
   }
}

