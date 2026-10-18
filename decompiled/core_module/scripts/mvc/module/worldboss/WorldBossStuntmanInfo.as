package mvc.module.worldboss
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   
   public final class WorldBossStuntmanInfo extends EventDispatcher
   {
      
      private var dict:Dictionary = new Dictionary();
      
      public function WorldBossStuntmanInfo()
      {
         super();
      }
      
      public function hasBuyFor(param1:int) : Boolean
      {
         return dict[param1] == 1;
      }
      
      public function parseFromString(param1:String) : void
      {
         var _loc3_:Array = null;
         for(var _loc5_:String in dict)
         {
            delete dict[_loc5_];
         }
         var _loc2_:Array = param1.split("|");
         for each(var _loc4_:String in _loc2_)
         {
            _loc3_ = _loc4_.split(",");
            if(_loc3_.length == 2)
            {
               dict[_loc3_[0]] = parseInt(_loc3_[1]);
            }
         }
         this.dispatchEvent(new Event("change"));
      }
      
      public function buyFor(param1:int, param2:int = 1) : void
      {
         dict[param1] = param2;
         this.dispatchEvent(new Event("change"));
      }
      
      public function cancelBuyFor(param1:int) : void
      {
         delete dict[param1];
         this.dispatchEvent(new Event("change"));
      }
   }
}

