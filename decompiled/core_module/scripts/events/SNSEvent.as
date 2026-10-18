package events
{
   import flash.events.Event;
   
   public class SNSEvent extends Event
   {
      
      public static const SNSTEMP_LOAD_COMPLETE:String = "SNSTEMP_LOAD_COMPLETE";
      
      public static const SNSINFO_UPDATE:String = "SNSINFO_UPDATE";
      
      private var _data:Object;
      
      public function SNSEvent(param1:String, param2:Object = null)
      {
         super(param1);
         _data = param2;
      }
      
      override public function clone() : Event
      {
         return new SNSEvent(type,data);
      }
      
      public function get data() : Object
      {
         return _data;
      }
   }
}

