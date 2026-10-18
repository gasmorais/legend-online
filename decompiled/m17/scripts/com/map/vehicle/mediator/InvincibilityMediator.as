package com.map.vehicle.mediator
{
   import flash.events.Event;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import yishi.interfaces.IMediator;
   
   public class InvincibilityMediator implements IMediator
   {
      
      private var _map:Object;
      
      private var _timeId:int;
      
      public function InvincibilityMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         _map = param1;
         _map.addEventListener("mouseDown",__cancelInvincibilityHandler);
         _timeId = setTimeout(__cancelInvincibilityHandler,10000);
      }
      
      public function unregister(param1:Object) : void
      {
         _map.removeEventListener("mouseDown",__cancelInvincibilityHandler);
         if(_timeId != 0)
         {
            clearTimeout(_timeId);
            _timeId = 0;
         }
         _map = null;
      }
      
      private function __cancelInvincibilityHandler(param1:Event = null) : void
      {
         if(_timeId != 0)
         {
            clearTimeout(_timeId);
            _timeId = 0;
         }
         _map.removeEventListener("mouseDown",__cancelInvincibilityHandler);
      }
   }
}

