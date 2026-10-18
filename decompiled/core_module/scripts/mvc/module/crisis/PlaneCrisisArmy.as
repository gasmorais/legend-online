package mvc.module.crisis
{
   import flash.events.Event;
   import mvc.module.armyII.SystemArmy;
   
   public class PlaneCrisisArmy extends SystemArmy
   {
      
      public var viewState:int = -1;
      
      public var angle:Number = -1;
      
      private var _standNodeId:int = -1;
      
      public var lastStandNodeId:int;
      
      public var isMoving:Boolean;
      
      public var color:int;
      
      private var _online:Boolean = true;
      
      public function PlaneCrisisArmy()
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
            dispatchEvent(new Event("PlaneCrisisEventType.moveTo"));
         }
      }
      
      public function get online() : Boolean
      {
         return _online;
      }
      
      public function set online(param1:Boolean) : void
      {
         if(_online == param1)
         {
            return;
         }
         _online = param1;
      }
   }
}

