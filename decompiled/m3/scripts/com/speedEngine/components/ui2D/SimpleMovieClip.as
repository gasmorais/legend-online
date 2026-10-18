package com.speedEngine.components.ui2D
{
   import avmplus.getQualifiedClassName;
   import com.speedEngine.game.Director;
   import flash.display.MovieClip;
   import flash.display.Scene;
   import flash.utils.getDefinitionByName;
   
   public class SimpleMovieClip extends TinyUI
   {
      
      private var _isStop:Boolean = false;
      
      private var _movieClip:MovieClip;
      
      private var _enable:Boolean;
      
      private var _playCount:int = 0;
      
      private var _completeCallback:Function = null;
      
      public function SimpleMovieClip()
      {
         super();
      }
      
      public function get movie() : MovieClip
      {
         return _movieClip;
      }
      
      public function set movie(param1:MovieClip) : void
      {
         if(_movieClip)
         {
            this.removeChild(_movieClip);
         }
         _movieClip = param1;
         addChild(_movieClip);
      }
      
      public function set isStop(param1:Boolean) : void
      {
         _isStop = param1;
         if(_movieClip)
         {
            if(param1)
            {
               _movieClip.stop();
            }
            else
            {
               _movieClip.play();
            }
         }
      }
      
      public function get enabled() : Boolean
      {
         return _enable;
      }
      
      public function set enabled(param1:Boolean) : void
      {
         if(_enable == param1)
         {
            return;
         }
         _enable = param1;
      }
      
      public function stop() : void
      {
         if(_movieClip)
         {
            _movieClip.stop();
         }
      }
      
      public function play(param1:int = 0, param2:Function = null) : void
      {
         if(_movieClip)
         {
            _playCount = param1;
            _completeCallback = param2;
            if(_playCount != 0)
            {
               Director.instance.addEnterFrameEvent(onPlayHandle);
            }
            else
            {
               _playCount = 0;
               _completeCallback = null;
               Director.instance.removeEnterFrameEvent(onPlayHandle);
            }
            _movieClip.play();
         }
      }
      
      private function onPlayHandle() : void
      {
         if(_movieClip == null)
         {
            return;
         }
         if(_movieClip.currentFrame == _movieClip.totalFrames)
         {
            _playCount = _playCount - 1;
            if(_playCount == 0 && _completeCallback != null)
            {
               Director.instance.removeEnterFrameEvent(onPlayHandle);
               _completeCallback.apply(null);
            }
         }
      }
      
      public function gotoAndPlay(param1:Object, param2:String = null) : void
      {
         if(_movieClip)
         {
            _movieClip.gotoAndPlay(param1,param2);
         }
      }
      
      public function gotoAndStop(param1:Object, param2:String = null) : void
      {
         if(_movieClip)
         {
            _movieClip.gotoAndStop(param1,param2);
         }
      }
      
      public function get currentFrame() : int
      {
         return _movieClip.currentFrame;
      }
      
      public function get currentFrameLabel() : String
      {
         return _movieClip.currentFrameLabel;
      }
      
      public function get currentLabel() : String
      {
         return _movieClip.currentLabel;
      }
      
      public function get currentLabels() : Array
      {
         return _movieClip.currentLabels;
      }
      
      public function get currentScene() : Scene
      {
         return _movieClip.currentScene;
      }
      
      public function get isPlaying() : Boolean
      {
         return _movieClip.isPlaying;
      }
      
      public function clone() : SimpleMovieClip
      {
         var _loc1_:SimpleMovieClip = new SimpleMovieClip();
         var _loc3_:String = getQualifiedClassName(_movieClip);
         var _loc2_:Class = getDefinitionByName(_loc3_) as Class;
         _loc1_.movie = new _loc2_();
         return _loc1_;
      }
      
      override public function __onAfterProp() : void
      {
         if(!_movieClip)
         {
            return;
         }
         if(_enable)
         {
            _movieClip.enabled = false;
         }
         if(_isStop)
         {
            _movieClip.stop();
         }
         else
         {
            _movieClip.play();
         }
      }
      
      override public function dispose() : void
      {
         if(_movieClip)
         {
            this.removeChild(_movieClip);
         }
         _movieClip = null;
         super.dispose();
      }
   }
}

