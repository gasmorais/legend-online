package com.speedEngine.components.bone
{
   public class PlayClock
   {
      
      private static var _playCallback:Vector.<PlayCallback> = new Vector.<PlayCallback>();
      
      public function PlayClock()
      {
         super();
      }
      
      public static function addPlayCallback(param1:PlayCallback) : void
      {
         if(-1 == _playCallback.indexOf(param1))
         {
            _playCallback.push(param1);
         }
      }
      
      public static function removePlayCallback(param1:PlayCallback) : void
      {
         var _loc2_:int = _playCallback.indexOf(param1);
         if(-1 != _loc2_)
         {
            _playCallback.splice(_loc2_,1);
         }
      }
      
      public static function advanceTime() : void
      {
         if(_playCallback == null || _playCallback.length == 0)
         {
            return;
         }
         for each(var _loc1_:PlayCallback in _playCallback)
         {
            execute(_loc1_);
         }
      }
      
      private static function execute(param1:PlayCallback) : void
      {
         if(param1.animation && param1.animation.currentTime >= param1.duration)
         {
            removePlayCallback(param1);
            param1.execute();
            param1.dispose();
            param1 = null;
         }
      }
   }
}

