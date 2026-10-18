package yishi.manager
{
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   import yishi.events.NotificationEvent;
   
   public class NotificationManager extends EventDispatcher
   {
      
      private static var _instance:NotificationManager;
      
      private var _command_map:Dictionary = new Dictionary();
      
      public function NotificationManager()
      {
         super();
         if(_instance)
         {
            throw new Error();
         }
         _instance = this;
         init();
      }
      
      public static function get instance() : NotificationManager
      {
         return _instance || new NotificationManager();
      }
      
      private function init() : void
      {
      }
      
      public function sendNotification(param1:String, param2:* = null) : void
      {
         dispatchEvent(new NotificationEvent(param1,param2));
      }
   }
}

