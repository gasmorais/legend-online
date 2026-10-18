package proxy
{
   import flash.events.Event;
   
   public class SocketDataProxyEventEvent extends Event
   {
      
      public static const READ_SOCKET_DATA_OVEW:String = "READ_SOCKET_DATA_OVEW";
      
      private var _sceneType:String;
      
      public function SocketDataProxyEventEvent(param1:String, param2:String, param3:Boolean = false, param4:Boolean = false)
      {
         _sceneType = param2;
         super(param1,param3,param4);
      }
      
      public function get sceneType() : String
      {
         return _sceneType;
      }
   }
}

