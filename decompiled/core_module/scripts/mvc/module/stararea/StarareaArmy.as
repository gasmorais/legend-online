package mvc.module.stararea
{
   import flash.events.Event;
   import mvc.module.armyII.SystemArmy;
   
   public class StarareaArmy extends SystemArmy
   {
      
      public var viewState:int = -1;
      
      public var angle:Number = -1;
      
      private var _standNodeId:int = -1;
      
      public var lastStandNodeId:int;
      
      public var isMoving:Boolean;
      
      public var color:int;
      
      public function StarareaArmy()
      {
         super();
      }
      
      public function get standNodeId() : int
      {
         return _standNodeId;
      }
      
      public function set standNodeId(param1:int) : void
      {
         if(_standNodeId == param1)
         {
            return;
         }
         _standNodeId = param1;
         if(lastStandNodeId != 0 && lastStandNodeId != _standNodeId && !isMoving)
         {
            dispatchEvent(new Event("MOVE_TO_POINT"));
         }
      }
   }
}

