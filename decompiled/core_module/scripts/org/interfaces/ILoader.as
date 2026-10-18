package org.interfaces
{
   public interface ILoader
   {
      
      function isStarted() : Boolean;
      
      function isSuccess() : Boolean;
      
      function loadAsync(param1:Function = null, param2:uint = 3) : void;
      
      function cancel() : void;
   }
}

