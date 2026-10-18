package yishi.interfaces
{
   public interface ISocketTransaction
   {
      
      function disposeWhenComplete() : Boolean;
      
      function isHandleInQueue() : Boolean;
      
      function getCode() : int;
      
      function handlePackage() : void;
      
      function execute(param1:Object = null) : void;
      
      function configure(param1:Object) : void;
      
      function finish() : void;
      
      function get isFinished() : Boolean;
      
      function dispose() : void;
   }
}

