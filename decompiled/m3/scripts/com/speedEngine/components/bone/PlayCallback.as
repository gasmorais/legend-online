package com.speedEngine.components.bone
{
   import com.speedEngine.speedBones.animation.Animation;
   
   public class PlayCallback
   {
      
      private var _animation:Animation;
      
      private var _duration:Number;
      
      private var _callback:Function;
      
      public function PlayCallback(param1:Animation)
      {
         super();
         _animation = param1;
         _animation.onLoopCallback = onLoopHander;
      }
      
      public function get animation() : Animation
      {
         return _animation;
      }
      
      public function get duration() : Number
      {
         return _duration;
      }
      
      public function set duration(param1:Number) : void
      {
         _duration = param1;
      }
      
      public function get callback() : Function
      {
         return _callback;
      }
      
      public function set callback(param1:Function) : void
      {
         _callback = param1;
      }
      
      protected function onLoopHander() : void
      {
         _animation.gotoAndPlay(_animation.movement,true);
      }
      
      public function execute() : void
      {
         if(_callback != null)
         {
            _callback.apply(null);
         }
         _animation.onLoopCallback = null;
      }
      
      public function dispose() : void
      {
         _animation = null;
         _callback = null;
      }
   }
}

