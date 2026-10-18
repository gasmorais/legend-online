package
{
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLVariables;
   
   public class ErrorLog
   {
      
      public function ErrorLog()
      {
         super();
      }
      
      public static function sendLog(param1:int, param2:String, param3:XML) : void
      {
         var _loc4_:URLVariables = new URLVariables();
         _loc4_["level"] = 5000;
         _loc4_["text"] = "UserId:" + param1 + "  " + param2;
         _loc4_["ran"] = Math.random();
         var _loc7_:String = param3.REQUEST_PATH.@value + "logReuest";
         var _loc5_:URLRequest = new URLRequest(_loc7_);
         var _loc6_:URLLoader = new URLLoader();
         _loc6_.data = _loc4_;
         _loc6_.dataFormat = "text";
         _loc6_.load(_loc5_);
      }
   }
}

