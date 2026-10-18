package events
{
   import flash.events.Event;
   
   public class MagicSpringEvent extends Event
   {
      
      public static const SELECT_FORMULA_CHANGE:String = "SELECT_FORMULA_CHANGE";
      
      public static const INFO_CHANGE_BACK:String = "INFO_CHANGE_BACK";
      
      public static const MAKE_SUCCESS_BACK:String = "MAKE_SUCCESS_BACK";
      
      public var data:Object;
      
      public function MagicSpringEvent(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         data = param2;
         super(param1,param3,param4);
      }
   }
}

