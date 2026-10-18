package logging
{
   import flash.net.URLVariables;
   import yishi.manager.PathManager;
   import yishi.manager.PlayerManager;
   
   public class ServerLoggerImp implements ILogger
   {
      
      public function ServerLoggerImp()
      {
         super();
      }
      
      public function info(param1:*) : void
      {
         send(param1,5000);
      }
      
      public function error(param1:*) : void
      {
         send(param1,40000);
      }
      
      private function send(param1:*, param2:int) : void
      {
         var _loc3_:URLVariables = new URLVariables();
         _loc3_["level"] = param2;
         _loc3_["text"] = "UserId:" + PlayerManager.instance.currentPlayerModel.userInfo.userId + "  " + param1;
         _loc3_["ran"] = Math.random();
         var _loc4_:String = PathManager.info.REQUEST_PATH + "logReuest";
      }
   }
}

