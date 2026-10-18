package events
{
   import flash.events.Event;
   
   public class ActionEvent extends Event
   {
      
      public var data:*;
      
      public function ActionEvent(param1:String, param2:*, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this.data = param2;
      }
   }
}

