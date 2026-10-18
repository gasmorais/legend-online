package yishi.comm
{
   import flash.events.Event;
   
   public class SocketEvent extends Event
   {
      
      public static const DATA:String = "data";
      
      public static const CHECK_ERROR:String = "checkError";
      
      private var _data:PackageIn;
      
      public function SocketEvent(param1:String, param2:PackageIn)
      {
         super(param1);
         _data = param2;
      }
      
      public function get data() : PackageIn
      {
         return _data;
      }
   }
}

