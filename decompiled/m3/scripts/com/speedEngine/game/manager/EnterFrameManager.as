package com.speedEngine.game.manager
{
   import com.speedEngine.game.Director;
   import com.speedEngine.game.base.basegame_internal;
   import com.speedEngine.game.error.ErrorManager;
   
   use namespace basegame_internal;
   
   public class EnterFrameManager extends BaseManager
   {
      
      private static var _instance:EnterFrameManager;
      
      private var _enterFrameHandles:Vector.<Function>;
      
      public function EnterFrameManager(param1:SingleHelper)
      {
         super();
         if(param1 == null)
         {
            ErrorManager.instance.throwSingletonError();
         }
         else
         {
            _enterFrameHandles = new Vector.<Function>();
         }
      }
      
      public static function get instance() : EnterFrameManager
      {
         if(_instance == null)
         {
            _instance = new EnterFrameManager(new SingleHelper());
         }
         return _instance;
      }
      
      override public function init() : void
      {
         super.init();
      }
      
      override public function update() : void
      {
         if(_enterFrameHandles == null)
         {
            return;
         }
         for each(var _loc1_:Function in _enterFrameHandles)
         {
            _loc1_.call();
         }
      }
      
      basegame_internal function addEnterFrameEvent(param1:Function) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(_enterFrameHandles == null)
         {
            _enterFrameHandles = new Vector.<Function>();
         }
         if(_enterFrameHandles.indexOf(param1) < 0)
         {
            _enterFrameHandles.push(param1);
            Director.instance.trace(5,"添加{invalid_utf8=228}{invalid_utf8=184}?个帧频事{invalid_utf8=228}{invalid_utf8=187}?");
         }
      }
      
      basegame_internal function removeEnterFrameEvent(param1:Function) : void
      {
         if(_enterFrameHandles == null)
         {
            return;
         }
         var _loc2_:int = _enterFrameHandles.indexOf(param1);
         if(_loc2_ != -1)
         {
            Director.instance.trace(5,"删除{invalid_utf8=228}{invalid_utf8=184}?个帧频事{invalid_utf8=228}{invalid_utf8=187}?");
            _enterFrameHandles.splice(_loc2_,1);
         }
      }
      
      basegame_internal function removeAllEnterFrameEvents() : void
      {
         _enterFrameHandles = null;
      }
   }
}

class SingleHelper
{
   
   public function SingleHelper()
   {
      super();
   }
}
