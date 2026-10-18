package yishi.service.services
{
   import flash.net.Responder;
   
   public class AmfResponder extends Responder
   {
      
      public var onResult:Function;
      
      public var onError:Function;
      
      public var data:*;
      
      private var _result:*;
      
      private var _error:Object;
      
      private var _arrgument:Array;
      
      public function AmfResponder(param1:Array)
      {
         super(__result,__status);
         _arrgument = param1;
      }
      
      private function __result(param1:*) : void
      {
         _result = param1;
         callBackFunction(onResult);
      }
      
      private function __status(param1:Object) : void
      {
         _error = param1;
         callBackFunction(onError);
      }
      
      public function get result() : *
      {
         return _result;
      }
      
      public function get error() : *
      {
         return _error;
      }
      
      final public function callBackFunction(param1:Function) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(param1.length > 0)
         {
            param1(this);
         }
         else
         {
            param1();
         }
      }
      
      public function get arrgument() : Array
      {
         return _arrgument;
      }
   }
}

