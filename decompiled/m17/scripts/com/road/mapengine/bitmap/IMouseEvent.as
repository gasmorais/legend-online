package com.road.mapengine.bitmap
{
   import flash.events.MouseEvent;
   
   public interface IMouseEvent
   {
      
      function mouseClickEvent(param1:MouseEvent) : Boolean;
      
      function mouseDownEvent(param1:MouseEvent) : Boolean;
      
      function mouseUpEvent(param1:MouseEvent) : Boolean;
      
      function mouseOverEvent(param1:MouseEvent) : Boolean;
      
      function mouseOutEvent(param1:MouseEvent) : Boolean;
      
      function mouseMoveEvent(param1:MouseEvent) : Boolean;
   }
}

