package com.speedEngine.components.bone
{
   import com.speedEngine.speedBones.animation.Animation;
   import com.speedEngine.speedBones.display.DisplayObjectContainer;
   import com.speedEngine.speedBones.filters.ColorFilter;
   import com.speedEngine.speedBones.filters.Filter;
   import com.speedEngine.speedBones.utils.speedBones_internal;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   use namespace speedBones_internal;
   
   public class BoneMovie extends DisplayObjectContainer
   {
      
      private var _bonePath:String;
      
      private var _armatureName:String;
      
      private var _animation:Animation = null;
      
      private var _repeatCount:int = -1;
      
      private var _repeatCompleteCallback:Function = null;
      
      private var _nextPlayLabel:String = null;
      
      private var _isGotoAndPlay:Boolean = false;
      
      private var _playCallbackData:PlayCallback = null;
      
      private var _rideBoneMovie:BoneMovie;
      
      public function BoneMovie(param1:Animation = null)
      {
         super();
         setAnimation(param1);
      }
      
      public function setAnimation(param1:Animation) : void
      {
         if(param1)
         {
            _animation = param1;
            addChild(_animation);
            _animation.addParentInnerChild();
         }
      }
      
      public function set direction(param1:Number) : void
      {
         scaleX = param1;
      }
      
      public function gotoAndPlay(param1:String = "", param2:* = null, param3:Boolean = false) : void
      {
         var _loc5_:Vector.<String> = null;
         var _loc4_:Animation = null;
         if(_animation == null)
         {
            return;
         }
         if(!param3 && _animation.movement == param1)
         {
            return;
         }
         _loc5_ = currentLabels;
         if(param1 != null && param1 != "")
         {
            _animation.gotoAndPlay(param1,param2);
         }
         else if(_loc5_ != null && _loc5_.length > 0)
         {
            _animation.gotoAndPlay(_loc5_[0],param2);
         }
      }
      
      public function gotoAndStop(param1:String = null) : void
      {
         _isGotoAndPlay = true;
         if(_animation != null)
         {
            _animation.onLoopCallback = onLoopHandle;
         }
         gotoAndPlay(param1);
      }
      
      public function playLabel(param1:String, param2:String = null, param3:int = -1, param4:Function = null, param5:Number = 0, param6:Function = null) : void
      {
         if(_animation == null)
         {
            return;
         }
         if(param3 != -1)
         {
            _nextPlayLabel = param2;
            _repeatCount = param3;
            _repeatCompleteCallback = param4;
            _animation.onLoopCallback = onLoopHandle;
         }
         else
         {
            _repeatCount = -1;
            _repeatCompleteCallback = null;
            _nextPlayLabel = null;
            _animation.onLoopCallback = null;
         }
         if(param5 <= 0.005)
         {
            if(param6 != null)
            {
               param6.apply(null);
            }
         }
         else
         {
            if(_playCallbackData == null)
            {
               _playCallbackData = new PlayCallback(_animation);
            }
            _playCallbackData.callback = param6;
            _playCallbackData.duration = param5;
            PlayClock.addPlayCallback(_playCallbackData);
         }
         gotoAndPlay(param1,true);
      }
      
      public function removeCallback() : void
      {
         _repeatCount = -1;
         _animation.onLoopCallback = null;
         _repeatCompleteCallback = null;
         _nextPlayLabel = null;
         _isGotoAndPlay = false;
         PlayClock.removePlayCallback(_playCallbackData);
         _playCallbackData = null;
         _rideBoneMovie = null;
      }
      
      public function stop() : void
      {
         if(_animation != null)
         {
            _animation.stop();
         }
      }
      
      public function startClock() : void
      {
         if(_animation != null)
         {
            _animation.play();
         }
      }
      
      public function stopClock() : void
      {
         if(_animation != null)
         {
            _animation.stop();
         }
      }
      
      public function play(param1:int = -1, param2:Function = null) : void
      {
         if(_animation == null)
         {
            return;
         }
         if(!_animation.isPlaying)
         {
            _animation.play();
         }
         if(param1 != -1)
         {
            _repeatCount = param1;
            _repeatCompleteCallback = param2;
            _nextPlayLabel = null;
            _animation.onLoopCallback = onLoopHandle;
            _animation.gotoAndPlay(_animation.movement,true);
         }
         else
         {
            _animation.play();
         }
      }
      
      public function playAction(param1:String, param2:Number = -1, param3:Function = null) : void
      {
         if(_animation != null)
         {
            gotoAndPlay(param1,true);
            if(param2 != -1)
            {
               if(_playCallbackData == null)
               {
                  _playCallbackData = new PlayCallback(_animation);
               }
               _playCallbackData.callback = param3;
               _playCallbackData.duration = param2;
               PlayClock.addPlayCallback(_playCallbackData);
            }
         }
      }
      
      public function playNextAction() : void
      {
         var _loc1_:int = -1;
         var _loc2_:Vector.<String> = null;
         if(_animation != null)
         {
            _animation.playNextAction();
         }
      }
      
      protected function onLoopHandle() : void
      {
         if(_isGotoAndPlay && _animation != null)
         {
            _isGotoAndPlay = false;
            _animation.onLoopCallback = null;
            stop();
         }
         if(_repeatCount != -1)
         {
            _repeatCount = _repeatCount - 1;
            if(_repeatCount == 0)
            {
               _repeatCount = -1;
               _animation.onLoopCallback = null;
               if(_nextPlayLabel != null && _nextPlayLabel != "")
               {
                  gotoAndPlay(_nextPlayLabel);
                  _nextPlayLabel = null;
               }
               else
               {
                  stop();
               }
               if(_repeatCompleteCallback != null)
               {
                  _repeatCompleteCallback.call();
                  _repeatCompleteCallback = null;
               }
            }
         }
      }
      
      public function set childAnimation(param1:BoneMovie) : void
      {
         if(this._animation == null)
         {
            trace("坐骑未加载成功，name=" + this.boneMovieName);
            return;
         }
         if(param1)
         {
            _rideBoneMovie = param1;
            this._animation.mountAnimation = param1._animation;
            this.addChild(param1._animation);
         }
         else
         {
            if(_rideBoneMovie)
            {
               this._animation.mountAnimation.x = 0;
               this._animation.mountAnimation.y = 0;
               _rideBoneMovie.addChild(this._animation.mountAnimation);
            }
            _rideBoneMovie = null;
            this._animation.mountAnimation = null;
         }
      }
      
      public function setPlaySound(param1:int, param2:uint, param3:int = -1) : void
      {
         if(_animation)
         {
            _animation.setPlaySound(param1,param2,param3);
         }
      }
      
      public function setClearSound() : void
      {
         if(_animation)
         {
            _animation.setClearSound();
         }
      }
      
      public function addChildAnimation(param1:BoneMovie, param2:Boolean = true, param3:int = -1) : void
      {
         addChild(param1);
      }
      
      public function removeChildAnimation(param1:BoneMovie) : void
      {
         removeChild(param1);
      }
      
      public function removeChildAnimations() : void
      {
         removeChildren();
      }
      
      override public function getBounds() : Rectangle
      {
         if(_animation)
         {
            return _animation.getBounds();
         }
         return null;
      }
      
      override public function set filter(param1:Filter) : void
      {
         if(param1 is ColorFilter)
         {
            trace("颜色滤镜建议使用BoneMove.addColorFilter()!!");
            addColorFilter(param1 as ColorFilter);
         }
         else if(_animation)
         {
            _animation.filter = param1;
         }
      }
      
      override public function get filter() : Filter
      {
         if(_animation)
         {
            return _animation.filter;
         }
         return null;
      }
      
      override public function addColorFilter(param1:ColorFilter) : void
      {
         if(_animation)
         {
            _animation.addColorFilter(param1);
         }
      }
      
      override public function get colorFilters() : Vector.<Filter>
      {
         if(_animation)
         {
            return _animation.colorFilters;
         }
         return null;
      }
      
      override public function clearColorFilter(param1:ColorFilter = null) : void
      {
         if(_animation)
         {
            _animation.clearColorFilter(param1);
         }
      }
      
      public function hasFilter(param1:ColorFilter) : Boolean
      {
         if(_animation)
         {
            return _animation.colorFilters.indexOf(param1) != -1;
         }
         return false;
      }
      
      public function get isPlaying() : Boolean
      {
         if(_animation != null)
         {
            return _animation.isPlaying;
         }
         return false;
      }
      
      public function getDuration(param1:String = null) : Number
      {
         return 0;
      }
      
      public function getDataByName(param1:String) : String
      {
         if(_animation != null)
         {
            return _animation.getDataByName(param1);
         }
         return null;
      }
      
      public function get bloodY() : Number
      {
         if(_animation != null)
         {
            return Number(_animation.getDataByName("bloodY"));
         }
         return 0;
      }
      
      public function get rideBloodY() : Number
      {
         if(_animation != null)
         {
            return Number(_animation.getDataByName("rideBloodY"));
         }
         return 0;
      }
      
      public function get rideHeight() : Number
      {
         if(_animation != null)
         {
            return _animation.ridePosition.y;
         }
         return 0;
      }
      
      public function get ridePosition() : Point
      {
         if(_animation != null)
         {
            return _animation.ridePosition;
         }
         return new Point();
      }
      
      public function get boneMovieName() : String
      {
         if(_animation != null)
         {
            return _animation.animationData.name;
         }
         return null;
      }
      
      public function get currentLabels() : Vector.<String>
      {
         if(_animation != null)
         {
            return _animation.movementList;
         }
         return null;
      }
      
      public function currentLabel() : String
      {
         if(_animation != null)
         {
            return _animation.movement;
         }
         return null;
      }
      
      public function get parentSkeleton() : String
      {
         if(_animation)
         {
            return _animation.parentSkeleton;
         }
         return "";
      }
      
      override public function dispose() : void
      {
         if(_animation != null)
         {
            _animation.dispose();
            _animation = null;
         }
         if(_playCallbackData != null)
         {
            PlayClock.removePlayCallback(_playCallbackData);
         }
         _playCallbackData = null;
         _repeatCompleteCallback = null;
         _rideBoneMovie = null;
         super.dispose();
      }
      
      public function get bonePath() : String
      {
         return _bonePath;
      }
      
      public function set bonePath(param1:String) : void
      {
         _bonePath = param1;
      }
      
      public function get armatureName() : String
      {
         return _armatureName;
      }
      
      public function set armatureName(param1:String) : void
      {
         _armatureName = param1;
      }
   }
}

