package yishi.utils
{
   import com.greensock.TweenLite;
   import com.greensock.TweenMax;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   
   public class ButtonEffectUtil
   {
      
      private var _target:DisplayObject;
      
      private var _time:Number = 0.5;
      
      private var _strength:Number;
      
      public function ButtonEffectUtil(param1:DisplayObject, param2:Number = 15)
      {
         super();
         _strength = param2;
         _target = param1;
      }
      
      public function stop() : void
      {
         if(_target)
         {
            TweenMax.killChildTweensOf(_target as DisplayObjectContainer);
         }
         TweenLite.to(_target,0.01,{"glowFilter":{
            "color":16711680,
            "alpha":1,
            "blurX":0,
            "blurY":0,
            "strength":0,
            "quality":1
         }});
         _target.filters = null;
      }
      
      public function play() : void
      {
         if(!_target)
         {
            return;
         }
         TweenLite.to(_target,_time,{
            "glowFilter":{
               "color":16763955,
               "blurX":10,
               "blurY":10,
               "strength":_strength,
               "quality":1
            },
            "onComplete":onFlowComplete
         });
      }
      
      private function onFlowComplete() : void
      {
         if(!_target)
         {
            return;
         }
         TweenLite.to(_target,_time,{
            "glowFilter":{
               "color":16711680,
               "alpha":1,
               "blurX":0,
               "blurY":0,
               "strength":0,
               "quality":1
            },
            "onComplete":onResumeComplete
         });
      }
      
      private function onResumeComplete() : void
      {
         play();
      }
      
      public function dispose() : void
      {
         stop();
         _target = null;
      }
   }
}

