package com.map.vehicle.action
{
   import flash.events.EventDispatcher;
   import yishi.interfaces.IAction;
   
   public class BaseVehicleAction extends EventDispatcher implements IAction
   {
      
      protected var _finished:Boolean;
      
      public function BaseVehicleAction()
      {
         super();
      }
      
      public function synchronization() : void
      {
      }
      
      public function get finished() : Boolean
      {
         return _finished;
      }
      
      public function replace(param1:IAction) : Boolean
      {
         return false;
      }
      
      public function prepare() : void
      {
      }
      
      public function filter(param1:IAction) : Boolean
      {
         return false;
      }
      
      public function update() : void
      {
      }
      
      public function cancel() : void
      {
      }
      
      public function get priority() : int
      {
         return 0;
      }
      
      public function dispose() : void
      {
         _finished = true;
      }
      
      public function getCode() : uint
      {
         return 0;
      }
      
      public function ready(param1:int = 0) : Boolean
      {
         return false;
      }
      
      public function get type() : String
      {
         return null;
      }
      
      public function pause() : void
      {
      }
      
      public function resume() : void
      {
      }
      
      public function get canCancel() : Boolean
      {
         return false;
      }
      
      public function set priority(param1:int) : void
      {
         throw new Error("not implemented!!!");
      }
      
      public function get canDisplay() : Boolean
      {
         throw new Error("not implemented!!!");
      }
      
      public function get isAlone() : Boolean
      {
         throw new Error("not implemented!!!");
      }
      
      public function get delayFrameCount() : int
      {
         throw new Error("not implemented!!!");
      }
      
      public function set delayFrameCount(param1:int) : void
      {
         throw new Error("not implemented!!!");
      }
      
      public function get timePriority() : int
      {
         throw new Error("not implemented!!!");
      }
      
      public function set timePriority(param1:int) : void
      {
         throw new Error("not implemented!!!");
      }
   }
}

