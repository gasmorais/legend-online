package com.map.vehicle.data
{
   import com.road.mapengine.bitmap.logic.BitmapSimpleLogic;
   import flash.geom.Point;
   
   public class SkillCastInfo
   {
      
      public var skillid:int;
      
      public var target:BitmapSimpleLogic;
      
      public var castPos:Point;
      
      public function SkillCastInfo()
      {
         super();
      }
   }
}

