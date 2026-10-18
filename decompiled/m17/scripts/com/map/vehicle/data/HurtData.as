package com.map.vehicle.data
{
   public class HurtData
   {
      
      public var effectId:int;
      
      public var effectValue:int;
      
      public var skillId:int;
      
      public var effectType:int = 0;
      
      public var shootId:int = 0;
      
      public var attackType:int = 0;
      
      public function HurtData(param1:int = 0)
      {
         super();
         skillId = param1;
      }
   }
}

