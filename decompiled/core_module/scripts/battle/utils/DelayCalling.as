package battle.utils
{
   import flash.events.EventDispatcher;
   import yishi.utils.LogicObject;
   
   public class DelayCalling extends LogicObject
   {
      
      private var _fun:Function;
      
      private var _dispatcher:EventDispatcher;
      
      public function DelayCalling(param1:Function, param2:EventDispatcher)
      {
         super();
         _fun = param1;
         _dispatcher = param2;
      }
      
      public function cancel() : void
      {
         _dispatcher.removeEventListener("enterFrame",_fun);
      }
   }
}

