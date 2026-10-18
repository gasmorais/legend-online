package com.speedEngine.components.ui2D
{
   import com.speedEngine.components.model.MovieData2D;
   import com.speedEngine.game.Director;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.utils.Dictionary;
   
   public class SimpleMovie extends TinyUI
   {
      
      private static const MAX_COUNT:int = 2147483647;
      
      private var _data:MovieData2D;
      
      private var _meta:Object;
      
      private var _textures:Vector.<BitmapData>;
      
      private var _frames:Array;
      
      private var _image:Bitmap;
      
      private var _actions:Dictionary;
      
      private var _startFrame:int;
      
      private var _endFrame:int;
      
      private var _totalFrame:int;
      
      private var _curFrame:int;
      
      private var _playCnt:int;
      
      private var _frameRate:int;
      
      private var _isPlaying:Boolean = false;
      
      private var _isStop:Boolean = false;
      
      private var _enable:Boolean;
      
      private var _tmpAction:Object;
      
      private var _timeId:int = -1;
      
      public function SimpleMovie(param1:MovieData2D = null)
      {
         super();
         data = param1;
      }
      
      public function set data(param1:MovieData2D) : void
      {
         if(null == param1)
         {
            return;
         }
         _data = param1;
         _meta = param1.meta;
         if(_meta == null)
         {
            Director.instance.trace(0,"SimpleMovie",this.name + "资源可能已经被释放了{invalid_utf8=239}{invalid_utf8=188}?");
            return;
         }
         _frameRate = _meta.meta.frameFps;
         _textures = _data.intactTextures;
         _frames = _data.intactFrame;
         if(_textures && _textures.length > 0)
         {
            _timeId = Director.instance.addTimer(1000 / _frameRate,-1,null,advanceTime);
         }
         _image = new Bitmap();
         addChild(_image);
         gotoFrame(0);
         scaleX = scaleY = _meta.meta.scale;
         initAction(_data.meta.actions);
         resetState();
         play();
      }
      
      private function gotoFrame(param1:int) : void
      {
         if(_textures == null)
         {
            return;
         }
         if(param1 >= _frames.length || param1 >= _textures.length)
         {
            Director.instance.traceMe(0,"2D 帧动画，播放的帧超过资源长度");
            return;
         }
         var _loc2_:Object = _frames[param1];
         _image.bitmapData = _textures[param1];
         _image.x = _loc2_.registerPoint.x;
         _image.y = _loc2_.registerPoint.y;
      }
      
      public function set direction(param1:int) : void
      {
         if(param1 > 0)
         {
            scaleX = Math.abs(scaleX);
         }
         else
         {
            scaleX = -Math.abs(scaleX);
         }
      }
      
      private function initAction(param1:Object) : void
      {
         _actions = new Dictionary();
         for(var _loc2_:String in param1)
         {
            _actions[_loc2_] = param1[_loc2_];
         }
      }
      
      private function resetState() : void
      {
         _totalFrame = _actions["default"].end;
         _endFrame = _totalFrame;
         _startFrame = 0;
         _curFrame = 0;
      }
      
      public function play(param1:int = 0) : void
      {
         _isPlaying = true;
         _playCnt = param1 == 0 ? 2147483647 : param1;
      }
      
      public function playAction(param1:String, param2:int = 0, param3:Boolean = false) : void
      {
         var _loc4_:Object = null;
         if(_isPlaying)
         {
            stop();
         }
         _isPlaying = false;
         if(param3)
         {
            _loc4_ = _tmpAction;
         }
         else
         {
            _loc4_ = _actions[param1];
         }
         if(_loc4_ != null)
         {
            _startFrame = _loc4_.start;
            _endFrame = _loc4_.end;
            _curFrame = _startFrame;
         }
         play(param2);
      }
      
      public function playFrame2Frame(param1:int, param2:int) : void
      {
         _tmpAction = {};
         _tmpAction["start"] = param1;
         _tmpAction["end"] = param2;
         playAction("tmp",1,true);
      }
      
      public function stopToFrame(param1:int = 0) : void
      {
         _isPlaying = false;
         _curFrame = param1;
         _image.bitmapData = _textures[param1];
      }
      
      public function getFrameWidth(param1:int) : Number
      {
         return 0;
      }
      
      public function stop() : void
      {
         _isPlaying = false;
         _curFrame = _startFrame;
      }
      
      public function pause() : void
      {
         _isPlaying = false;
      }
      
      public function clone() : SimpleMovie
      {
         var _loc1_:SimpleMovie = new SimpleMovie(_data);
         _loc1_.x = this.x;
         _loc1_.y = this.y;
         return _loc1_;
      }
      
      public function advanceTime(param1:int) : void
      {
         if(!_isPlaying)
         {
            return;
         }
         gotoFrame(_curFrame);
         _curFrame = _curFrame + 1;
         _playCnt = _playCnt - 1;
         if(_curFrame >= _endFrame)
         {
            if(_playCnt <= 0)
            {
               stop();
               dispatchEvent(new Event("complete"));
            }
            else
            {
               _curFrame = _startFrame;
            }
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         Director.instance.removeTimer(_timeId);
         if(_textures)
         {
            _textures = null;
         }
         if(_data)
         {
            _data = null;
         }
         _meta = null;
         _actions = null;
         _tmpAction = null;
         _image = null;
         stop();
      }
      
      public function get isStop() : Boolean
      {
         return _isStop;
      }
      
      public function set isStop(param1:Boolean) : void
      {
         _isStop = param1;
      }
      
      public function get enable() : Boolean
      {
         return _enable;
      }
      
      public function set enable(param1:Boolean) : void
      {
         if(enable == param1)
         {
            return;
         }
         _enable = param1;
      }
      
      public function get curFrame() : int
      {
         return _curFrame;
      }
      
      public function get currLabel() : String
      {
         var _loc2_:Object = null;
         for(var _loc1_:String in _actions)
         {
            _loc2_ = _actions[_loc1_];
            if(_curFrame >= _loc2_.start && _curFrame <= _loc2_.end)
            {
               return _loc1_;
            }
         }
         return null;
      }
      
      public function get bloodY() : Number
      {
         if(_meta && _meta.bloodY)
         {
            return _meta.bloodY;
         }
         return 0;
      }
      
      override public function __onAfterProp() : void
      {
         _isPlaying = !_isStop;
         _curFrame = 0;
      }
   }
}

