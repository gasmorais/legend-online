package com.map.vehicle.interfaces
{
   import com.map.vehicle.data.UseSkillInfo;
   import flash.display.Sprite;
   import flash.geom.Point;
   
   public interface ICaster
   {
      
      function playBombSmoke(param1:Sprite) : void;
      
      function getShootPoint() : Point;
      
      function bombFlyOut() : void;
      
      function changeDirectionTo(param1:int, param2:int) : void;
      
      function beAttacted(param1:UseSkillInfo) : void;
   }
}

