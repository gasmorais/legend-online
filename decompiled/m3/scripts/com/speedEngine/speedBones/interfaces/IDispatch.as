package com.speedEngine.speedBones.interfaces
{
   import com.speedEngine.speedBones.events.Event;
   
   public interface IDispatch
   {
      
      function addEventListener(param1:String, param2:Function) : void;
      
      function removeEventListener(param1:String, param2:Function) : void;
      
      function hasEventType(param1:String) : Boolean;
      
      function removeAllEvents() : void;
      
      function dispathEventWidth(param1:Event, param2:Boolean = false) : void;
   }
}

