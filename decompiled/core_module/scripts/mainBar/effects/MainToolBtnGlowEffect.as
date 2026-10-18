package mainBar.effects
{
   import com.greensock.TweenLite;
   import com.greensock.TweenMax;
   import com.pickgliss.effect.IEffect;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.geom.ColorTransform;
   
   public class MainToolBtnGlowEffect implements IEffect
   {
      
      private var _target:DisplayObject;
      
      private var _targetColorTrans:ColorTransform;
      
      private var _targetFilters:Array;
      
      private var _time:Number = 0.4;
      
      private var _isPlaying:Boolean = false;
      
      public function MainToolBtnGlowEffect(param1:DisplayObject)
      {
         super();
         _target = param1;
         if(_target)
         {
            _targetColorTrans = _target.transform.colorTransform;
            _targetFilters = _target.filters;
         }
      }
      
      public function init(param1:DisplayObject, param2:Array) : void
      {
         _target = param1;
         if(_target)
         {
            _targetColorTrans = _target.transform.colorTransform;
            _targetFilters = _target.filters;
         }
      }
      
      public function stop() : void
      {
         if(_target)
         {
            TweenMax.killChildTweensOf(_target as DisplayObjectContainer);
            TweenMax.killTweensOf(_target);
            TweenLite.killTweensOf(_target);
            _target.transform.colorTransform = _targetColorTrans;
            _target.filters = _targetFilters;
         }
      }
      
      public function play() : void
      {
         TweenMax.to(_target,_time,{
            "glowFilter":{
               "color":16776960,
               "alpha":1,
               "blurX":10,
               "blurY":10,
               "strength":2.5,
               "quality":2
            },
            "colorTransform":{
               "redOffset":100,
               "greenOffset":100,
               "blueOffset":100
            },
            "onComplete":onFlowComplete
         });
      }
      
      private function onFlowComplete() : void
      {
         disposeTween();
         TweenMax.to(_target,_time,{
            "glowFilter":{
               "color":16711680,
               "alpha":1,
               "blurX":0,
               "blurY":0,
               "strength":0,
               "quality":1
            },
            "colorTransform":{
               "redOffset":0,
               "greenOffset":0,
               "blueOffset":0
            },
            "onComplete":onResumeComplete
         });
      }
      
      private function onResumeComplete() : void
      {
         disposeTween();
         play();
      }
      
      private function playNext1() : void
      {
         TweenLite.to(_target,_time,{
            "glowFilter":{
               "color":16776960,
               "alpha":1,
               "blurX":10,
               "blurY":10,
               "strength":2.5,
               "quality":2
            },
            "onComplete":onFlowComplete1
         });
      }
      
      public function play1() : void
      {
         if(_isPlaying)
         {
            return;
         }
         _isPlaying = true;
         playNext1();
      }
      
      private function onFlowComplete1() : void
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
            "colorTransform":{
               "redOffset":0,
               "greenOffset":0,
               "blueOffset":0
            },
            "onComplete":onResumeComplete1
         });
      }
      
      private function onResumeComplete1() : void
      {
         TweenLite.killTweensOf(_target);
         if(_target)
         {
            _target.filters = [];
            playNext1();
         }
      }
      
      private function disposeTween() : void
      {
         TweenMax.killTweensOf(_target as DisplayObjectContainer);
      }
      
      public function get target() : DisplayObject
      {
         return _target;
      }
      
      public function get id() : int
      {
         return 0;
      }
      
      public function set id(param1:int) : void
      {
      }
      
      public function dispose() : void
      {
         stop();
         _target = null;
         _targetColorTrans = null;
         _targetFilters = null;
      }
   }
}

