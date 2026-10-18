package yishi.interfaces
{
   import flash.events.IEventDispatcher;
   import yishi.actions.IPrioritizable;
   
   public interface IAction extends IEventDispatcher, IPrioritizable
   {
      
      function synchronization() : void;
      
      function get finished() : Boolean;
      
      function replace(param1:IAction) : Boolean;
      
      function prepare() : void;
      
      function filter(param1:IAction) : Boolean;
      
      function update() : void;
      
      function cancel() : void;
      
      function getCode() : uint;
      
      function ready(param1:int = 0) : Boolean;
      
      function pause() : void;
      
      function resume() : void;
      
      function get type() : String;
      
      function get canDisplay() : Boolean;
      
      function set delayFrameCount(param1:int) : void;
      
      function get delayFrameCount() : int;
      
      function get isAlone() : Boolean;
      
      function get canCancel() : Boolean;
      
      function dispose() : void;
   }
}

