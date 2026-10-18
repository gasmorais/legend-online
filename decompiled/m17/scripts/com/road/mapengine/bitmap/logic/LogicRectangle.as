package com.road.mapengine.bitmap.logic
{
   import flash.geom.Rectangle;
   
   public class LogicRectangle extends Rectangle
   {
      
      private var _logic:BitmapSimpleLogic;
      
      public function LogicRectangle(param1:BitmapSimpleLogic, param2:Number = 0, param3:Number = 0, param4:Number = 0, param5:Number = 0)
      {
         _logic = param1;
         super(param2,param3,param4,param5);
      }
      
      public function get logic() : BitmapSimpleLogic
      {
         return _logic;
      }
      
      public function dispose() : void
      {
         _logic = null;
      }
   }
}

