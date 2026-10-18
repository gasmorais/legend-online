package yishi.interfaces
{
   public interface IActionManager
   {
      
      function update() : void;
      
      function synchronization() : void;
      
      function get current() : IAction;
      
      function addAction(param1:IAction, param2:Boolean = false) : void;
      
      function dispose() : void;
   }
}

