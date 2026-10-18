package com.road.mapengine.bitmap.logic
{
   import com.pickgliss.ui.core.Component;
   
   public class VehicleBaseSprite extends Component
   {
      
      private var _logic:BitmapSimpleLogic;
      
      public function VehicleBaseSprite(param1:BitmapSimpleLogic)
      {
         super();
         _logic = param1;
         this.mouseChildren = false;
      }
      
      public function get logic() : BitmapSimpleLogic
      {
         return _logic;
      }
   }
}

