package yishi.manager
{
   import flash.events.AsyncErrorEvent;
   import flash.events.StatusEvent;
   import flash.net.LocalConnection;
   import flash.utils.Dictionary;
   
   public class LocalConnectionManager
   {
      
      private static var _instance:LocalConnectionManager;
      
      private var conn:LocalConnection;
      
      private var _connSuccess:Boolean = false;
      
      public var isUse:Boolean = false;
      
      private var _connId:int;
      
      private var _calls:Dictionary = new Dictionary();
      
      public function LocalConnectionManager()
      {
         super();
         if(!isUse)
         {
            return;
         }
         conn = new LocalConnection();
         conn.client = this;
         conn.addEventListener("asyncError",__asyncErrorHandler);
         conn.allowDomain("*");
         try
         {
            conn.connect("mainSwf");
            _connSuccess = true;
         }
         catch(error:ArgumentError)
         {
            _connSuccess = false;
            isUse = false;
         }
         conn.addEventListener("status",onStatus);
      }
      
      public static function get instance() : LocalConnectionManager
      {
         if(!_instance)
         {
            _instance = new LocalConnectionManager();
         }
         return _instance;
      }
      
      private function __asyncErrorHandler(param1:AsyncErrorEvent) : void
      {
      }
      
      private function onStatus(param1:StatusEvent) : void
      {
         switch(param1.level)
         {
            case "status":
            case "error":
         }
      }
      
      public function Call(param1:String, param2:Array, param3:Function, param4:Object) : void
      {
         var _loc5_:int = connId;
         _calls[_loc5_] = {
            "call":param3,
            "para":param4
         };
         conn.send("connOtherSwf","CallThread",param1,param2,_loc5_);
      }
      
      public function CallSync(param1:int, param2:Object) : void
      {
         var _loc3_:Function = null;
         if(_calls[param1])
         {
            _loc3_ = _calls[param1].call;
         }
         if(_loc3_ != null)
         {
            _loc3_(param2,_calls[param1].para);
         }
         _loc3_ = null;
         delete _calls[param1];
      }
      
      public function get connId() : int
      {
         return _connId++;
      }
   }
}

