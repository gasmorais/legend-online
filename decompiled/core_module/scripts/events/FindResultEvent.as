package events
{
   import flash.events.Event;
   
   public class FindResultEvent extends Event
   {
      
      public static const GET_FIND_RESULTS:String = "GET_FIND_RESULTS";
      
      private var _totalPage:int;
      
      private var _data:Object;
      
      public function FindResultEvent(param1:String, param2:Object, param3:int, param4:Boolean = false, param5:Boolean = false)
      {
         super(param1,param4,param5);
         _data = param2;
         _totalPage = param3;
      }
      
      override public function clone() : Event
      {
         return new FindResultEvent(type,data,totalPage,bubbles,cancelable);
      }
      
      public function get data() : Object
      {
         return _data;
      }
      
      public function get totalPage() : int
      {
         return _totalPage;
      }
   }
}

