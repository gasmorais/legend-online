package events
{
   import flash.events.Event;
   
   public class TaskSelectEvent extends Event
   {
      
      public static const ITEM_SELECTED:String = "task_item_selected";
      
      private var _info:Object;
      
      public function TaskSelectEvent(param1:String, param2:Object)
      {
         super(param1,false,false);
         _info = param2;
      }
      
      public function get info() : Object
      {
         return _info;
      }
   }
}

