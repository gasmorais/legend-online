package com.map.vehicle.interfaces
{
   import com.map.vehicle.data.HurtData;
   
   public interface IBuffer
   {
      
      function changeSpeed(param1:int) : void;
      
      function changePercentSpeed(param1:int) : void;
      
      function setStun(param1:Boolean) : void;
      
      function changeHp(param1:HurtData) : void;
   }
}

