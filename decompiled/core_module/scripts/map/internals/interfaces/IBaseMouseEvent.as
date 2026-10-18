package map.internals.interfaces
{
   import flash.events.MouseEvent;
   
   public interface IBaseMouseEvent
   {
      
      function mouseClickHandler(param1:MouseEvent) : Boolean;
      
      function mouseOverHandler(param1:MouseEvent) : Boolean;
      
      function mouseOutHandler(param1:MouseEvent) : Boolean;
      
      function mouseMoveHandler(param1:MouseEvent) : Boolean;
   }
}

