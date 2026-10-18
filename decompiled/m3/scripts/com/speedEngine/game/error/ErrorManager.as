package com.speedEngine.game.error
{
   import com.speedEngine.game.Director;
   
   public class ErrorManager
   {
      
      private static var _instance:ErrorManager;
      
      private var _error:Error;
      
      public function ErrorManager(param1:SingleHelper)
      {
         super();
         if(param1 == null)
         {
            throwSingletonError();
         }
      }
      
      public static function get instance() : ErrorManager
      {
         if(_instance == null)
         {
            _instance = new ErrorManager(new SingleHelper());
         }
         return _instance;
      }
      
      public function init() : void
      {
         _error = new Error();
      }
      
      public function throwSingletonError() : void
      {
         throwErrorMsg("禁止实例化此{invalid_utf8=231}{invalid_utf8=177}?...");
      }
      
      public function throwErrorMsg(param1:String) : void
      {
         Director.instance.trace(0,"ErrorManager",param1);
         _error.message = param1;
         throw _error;
      }
   }
}

class SingleHelper
{
   
   public function SingleHelper()
   {
      super();
   }
}
