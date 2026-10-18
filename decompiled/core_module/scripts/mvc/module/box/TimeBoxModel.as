package mvc.module.box
{
   import events.TimeBoxEvent;
   import flash.events.EventDispatcher;
   import managers.BoxManager;
   
   public class TimeBoxModel extends EventDispatcher
   {
      
      private var _remainTime:int;
      
      public function TimeBoxModel()
      {
         super();
         _remainTime = BoxManager.instance.remainTime;
      }
      
      public function set remainTime(param1:int) : void
      {
         _remainTime = param1;
         if(_remainTime == 0)
         {
            dispatchEvent(new TimeBoxEvent("TIME_COMPLETE"));
         }
      }
      
      public function get remainTime() : int
      {
         return _remainTime;
      }
   }
}

