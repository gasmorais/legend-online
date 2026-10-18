package logging
{
   public class LoggerSys
   {
      
      private static var _logger:ILogger;
      
      public static var logMode:int = 2;
      
      private static const EMPTY_MODE:int = 0;
      
      private static const DEBUG_TRACE_MODE:int = 1;
      
      private static const SERVER_MODE:int = 2;
      
      public function LoggerSys()
      {
         super();
      }
      
      public static function info(param1:*) : void
      {
         getLogger().info(param1);
      }
      
      public static function error(param1:*) : void
      {
         getLogger().error(param1);
      }
      
      private static function getLogger() : ILogger
      {
         if(!_logger)
         {
            switch(logMode)
            {
               case 0:
                  _logger = new EmptyLoggerImp();
                  break;
               case 1:
                  _logger = new DebugTraceLoggerImp();
                  break;
               case 2:
                  _logger = new ServerLoggerImp();
                  break;
               default:
                  _logger = new EmptyLoggerImp();
            }
         }
         return _logger;
      }
   }
}

