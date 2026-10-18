package com.greensock
{
   import com.greensock.core.*;
   
   public class TimelineLite extends SimpleTimeline
   {
      
      public static const version:Number = 1.392;
      
      private static var _overwriteMode:int = OverwriteManager.enabled ? OverwriteManager.mode : OverwriteManager.init(2);
      
      protected var _labels:Object;
      
      protected var _endCaps:Array;
      
      public function TimelineLite(param1:Object = null)
      {
         super(param1);
         _endCaps = [null,null];
         _labels = {};
         this.autoRemoveChildren = this.vars.autoRemoveChildren == true;
         _hasUpdate = typeof this.vars.onUpdate == "function";
         if(this.vars.tweens is Array)
         {
            this.insertMultiple(this.vars.tweens,0,this.vars.align != null ? this.vars.align : "normal",this.vars.stagger ? Number(this.vars.stagger) : 0);
         }
      }
      
      override public function addChild(param1:TweenCore) : void
      {
         var _loc4_:TweenCore = null;
         if(!param1.cachedOrphan && param1.timeline)
         {
            param1.timeline.remove(param1,true);
         }
         param1.timeline = this;
         if(param1.gc)
         {
            param1.setEnabled(true,true);
         }
         setDirtyCache(true);
         if(param1.cachedPauseTime || param1.cachedPauseTime == 0)
         {
            param1.cachedPauseTime = param1.cachedStartTime + param1.cachedTime / param1.cachedTimeScale;
         }
         var _loc5_:TweenCore = this.gc ? _endCaps[0] : _firstChild;
         var _loc3_:TweenCore = this.gc ? _endCaps[1] : _lastChild;
         if(_loc3_ == null)
         {
            _loc5_ = _loc3_ = param1;
            param1.nextNode = param1.prevNode = null;
         }
         else
         {
            _loc4_ = _loc3_;
            var _loc2_:Number = param1.cachedStartTime;
            while(_loc4_ != null && _loc2_ <= _loc4_.cachedStartTime)
            {
               _loc4_ = _loc4_.prevNode;
            }
            if(_loc4_ == null)
            {
               _loc5_.prevNode = param1;
               param1.nextNode = _loc5_;
               param1.prevNode = null;
               _loc5_ = param1;
            }
            else
            {
               if(_loc4_.nextNode)
               {
                  _loc4_.nextNode.prevNode = param1;
               }
               else if(_loc4_ == _loc3_)
               {
                  _loc3_ = param1;
               }
               param1.prevNode = _loc4_;
               param1.nextNode = _loc4_.nextNode;
               _loc4_.nextNode = param1;
            }
         }
         param1.cachedOrphan = false;
         if(this.gc)
         {
            _endCaps[0] = _loc5_;
            _endCaps[1] = _loc3_;
         }
         else
         {
            _firstChild = _loc5_;
            _lastChild = _loc3_;
         }
      }
      
      override public function remove(param1:TweenCore, param2:Boolean = false) : void
      {
         if(param1.cachedOrphan)
         {
            return;
         }
         if(!param2)
         {
            param1.setEnabled(false,true);
         }
         var _loc4_:TweenCore = this.gc ? _endCaps[0] : _firstChild;
         var _loc3_:TweenCore = this.gc ? _endCaps[1] : _lastChild;
         if(param1.nextNode)
         {
            param1.nextNode.prevNode = param1.prevNode;
         }
         else if(_loc3_ == param1)
         {
            _loc3_ = param1.prevNode;
         }
         if(param1.prevNode)
         {
            param1.prevNode.nextNode = param1.nextNode;
         }
         else if(_loc4_ == param1)
         {
            _loc4_ = param1.nextNode;
         }
         if(this.gc)
         {
            _endCaps[0] = _loc4_;
            _endCaps[1] = _loc3_;
         }
         else
         {
            _firstChild = _loc4_;
            _lastChild = _loc3_;
         }
         param1.cachedOrphan = true;
         setDirtyCache(true);
      }
      
      public function insert(param1:TweenCore, param2:* = 0) : TweenCore
      {
         if(typeof param2 == "string")
         {
            if(!(param2 in _labels))
            {
               addLabel(param2,this.duration);
            }
            param2 = Number(_labels[param2]);
         }
         param1.cachedStartTime = Number(param2) + param1.delay;
         addChild(param1);
         return param1;
      }
      
      public function append(param1:TweenCore, param2:Number = 0) : TweenCore
      {
         return insert(param1,this.duration + param2);
      }
      
      public function prepend(param1:TweenCore, param2:Boolean = false) : TweenCore
      {
         shiftChildren(param1.totalDuration / param1.cachedTimeScale + param1.delay,param2,0);
         return insert(param1,0);
      }
      
      public function insertMultiple(param1:Array, param2:* = 0, param3:String = "normal", param4:Number = 0) : Array
      {
         var _loc5_:TweenCore = null;
         var _loc7_:int = 0;
         var _loc6_:Number = Number(Number(param2) || 0);
         var _loc8_:int = int(param1.length);
         if(typeof param2 == "string")
         {
            if(!(param2 in _labels))
            {
               addLabel(param2,this.duration);
            }
            _loc6_ = Number(_labels[param2]);
         }
         _loc7_ = 0;
         while(_loc7_ < _loc8_)
         {
            _loc5_ = param1[_loc7_] as TweenCore;
            insert(_loc5_,_loc6_);
            if(param3 == "sequence")
            {
               _loc6_ = _loc5_.cachedStartTime + _loc5_.totalDuration / _loc5_.cachedTimeScale;
            }
            else if(param3 == "start")
            {
               _loc5_.cachedStartTime -= _loc5_.delay;
            }
            _loc6_ += param4;
            _loc7_ += 1;
         }
         return param1;
      }
      
      public function appendMultiple(param1:Array, param2:Number = 0, param3:String = "normal", param4:Number = 0) : Array
      {
         return insertMultiple(param1,this.duration + param2,param3,param4);
      }
      
      public function prependMultiple(param1:Array, param2:String = "normal", param3:Number = 0, param4:Boolean = false) : Array
      {
         var _loc5_:TimelineLite = new TimelineLite({
            "tweens":param1,
            "align":param2,
            "stagger":param3
         });
         shiftChildren(_loc5_.duration,param4,0);
         insertMultiple(param1,0,param2,param3);
         _loc5_.kill();
         return param1;
      }
      
      public function addLabel(param1:String, param2:Number) : void
      {
         _labels[param1] = param2;
      }
      
      public function removeLabel(param1:String) : Number
      {
         var _loc2_:Number = Number(_labels[param1]);
         delete _labels[param1];
         return _loc2_;
      }
      
      public function getLabelTime(param1:String) : Number
      {
         return param1 in _labels ? Number(_labels[param1]) : -1;
      }
      
      protected function parseTimeOrLabel(param1:*) : Number
      {
         if(typeof param1 == "string")
         {
            if(!(param1 in _labels))
            {
               throw new Error("TimelineLite error: the " + param1 + " label was not found.");
            }
            return getLabelTime(String(param1));
         }
         return Number(param1);
      }
      
      public function stop() : void
      {
         this.paused = true;
      }
      
      public function gotoAndPlay(param1:*, param2:Boolean = true) : void
      {
         setTotalTime(parseTimeOrLabel(param1),param2);
         play();
      }
      
      public function gotoAndStop(param1:*, param2:Boolean = true) : void
      {
         setTotalTime(parseTimeOrLabel(param1),param2);
         this.paused = true;
      }
      
      override public function renderTime(param1:Number, param2:Boolean = false, param3:Boolean = false) : void
      {
         var _loc10_:TweenCore = null;
         var _loc13_:Boolean = false;
         var _loc11_:Boolean = false;
         var _loc5_:TweenCore = null;
         var _loc6_:Number = NaN;
         if(this.gc)
         {
            this.setEnabled(true,false);
         }
         else if(!this.active && !this.cachedPaused)
         {
            this.active = true;
         }
         var _loc9_:Number = this.cacheIsDirty ? this.totalDuration : this.cachedTotalDuration;
         var _loc8_:Number = this.cachedTime;
         var _loc4_:Number = this.cachedStartTime;
         var _loc12_:Number = this.cachedTimeScale;
         var _loc7_:Boolean = this.cachedPaused;
         if(param1 >= _loc9_)
         {
            if(_rawPrevTime <= _loc9_ && _rawPrevTime != param1)
            {
               this.cachedTotalTime = this.cachedTime = _loc9_;
               forceChildrenToEnd(_loc9_,param2);
               _loc13_ = !this.hasPausedChild();
               _loc11_ = true;
               if(this.cachedDuration == 0 && _loc13_ && (param1 == 0 || _rawPrevTime < 0))
               {
                  param3 = true;
               }
            }
         }
         else if(param1 <= 0)
         {
            if(param1 < 0)
            {
               this.active = false;
               if(this.cachedDuration == 0 && _rawPrevTime > 0)
               {
                  param3 = true;
                  _loc13_ = true;
               }
            }
            if(_rawPrevTime >= 0 && _rawPrevTime != param1)
            {
               forceChildrenToBeginning(0,param2);
               this.cachedTotalTime = 0;
               this.cachedTime = 0;
               _loc11_ = true;
               if(this.cachedReversed)
               {
                  _loc13_ = true;
               }
            }
         }
         else
         {
            this.cachedTotalTime = this.cachedTime = param1;
         }
         _rawPrevTime = param1;
         if(this.cachedTime == _loc8_ && !param3)
         {
            return;
         }
         if(!this.initted)
         {
            this.initted = true;
         }
         if(_loc8_ == 0 && this.vars.onStart && this.cachedTime != 0 && !param2)
         {
            this.vars.onStart.apply(null,this.vars.onStartParams);
         }
         if(!_loc11_)
         {
            if(this.cachedTime - _loc8_ > 0)
            {
               _loc10_ = _firstChild;
               while(_loc10_)
               {
                  _loc5_ = _loc10_.nextNode;
                  if(this.cachedPaused && !_loc7_)
                  {
                     break;
                  }
                  if(_loc10_.active || !_loc10_.cachedPaused && _loc10_.cachedStartTime <= this.cachedTime && !_loc10_.gc)
                  {
                     if(!_loc10_.cachedReversed)
                     {
                        _loc10_.renderTime((this.cachedTime - _loc10_.cachedStartTime) * _loc10_.cachedTimeScale,param2,false);
                     }
                     else
                     {
                        _loc6_ = Number(_loc10_.cacheIsDirty ? _loc10_.totalDuration : Number(_loc10_.cachedTotalDuration));
                        _loc10_.renderTime(_loc6_ - (this.cachedTime - _loc10_.cachedStartTime) * _loc10_.cachedTimeScale,param2,false);
                     }
                  }
                  _loc10_ = _loc5_;
               }
            }
            else
            {
               _loc10_ = _lastChild;
               while(_loc10_)
               {
                  _loc5_ = _loc10_.prevNode;
                  if(this.cachedPaused && !_loc7_)
                  {
                     break;
                  }
                  if(_loc10_.active || !_loc10_.cachedPaused && _loc10_.cachedStartTime <= _loc8_ && !_loc10_.gc)
                  {
                     if(!_loc10_.cachedReversed)
                     {
                        _loc10_.renderTime((this.cachedTime - _loc10_.cachedStartTime) * _loc10_.cachedTimeScale,param2,false);
                     }
                     else
                     {
                        _loc6_ = _loc10_.cacheIsDirty ? _loc10_.totalDuration : _loc10_.cachedTotalDuration;
                        _loc10_.renderTime(_loc6_ - (this.cachedTime - _loc10_.cachedStartTime) * _loc10_.cachedTimeScale,param2,false);
                     }
                  }
                  _loc10_ = _loc5_;
               }
            }
         }
         if(_hasUpdate && !param2)
         {
            this.vars.onUpdate.apply(null,this.vars.onUpdateParams);
         }
         if(_loc13_ && (_loc4_ == this.cachedStartTime || _loc12_ != this.cachedTimeScale) && (_loc9_ >= this.totalDuration || this.cachedTime == 0))
         {
            complete(true,param2);
         }
      }
      
      protected function forceChildrenToBeginning(param1:Number, param2:Boolean = false) : Number
      {
         var _loc3_:TweenCore = null;
         var _loc4_:Number = NaN;
         var _loc5_:TweenCore = _lastChild;
         var _loc6_:Boolean = this.cachedPaused;
         while(_loc5_)
         {
            _loc3_ = _loc5_.prevNode;
            if(this.cachedPaused && !_loc6_)
            {
               break;
            }
            if(_loc5_.active || !_loc5_.cachedPaused && !_loc5_.gc && (_loc5_.cachedTotalTime != 0 || _loc5_.cachedDuration == 0))
            {
               if(param1 == 0 && (_loc5_.cachedDuration != 0 || _loc5_.cachedStartTime == 0))
               {
                  _loc5_.renderTime(_loc5_.cachedReversed ? _loc5_.cachedTotalDuration : 0,param2,false);
               }
               else if(!_loc5_.cachedReversed)
               {
                  _loc5_.renderTime((param1 - _loc5_.cachedStartTime) * _loc5_.cachedTimeScale,param2,false);
               }
               else
               {
                  _loc4_ = Number(_loc5_.cacheIsDirty ? _loc5_.totalDuration : Number(_loc5_.cachedTotalDuration));
                  _loc5_.renderTime(_loc4_ - (param1 - _loc5_.cachedStartTime) * _loc5_.cachedTimeScale,param2,false);
               }
            }
            _loc5_ = _loc3_;
         }
         return param1;
      }
      
      protected function forceChildrenToEnd(param1:Number, param2:Boolean = false) : Number
      {
         var _loc3_:TweenCore = null;
         var _loc4_:Number = NaN;
         var _loc5_:TweenCore = _firstChild;
         var _loc6_:Boolean = this.cachedPaused;
         while(_loc5_)
         {
            _loc3_ = _loc5_.nextNode;
            if(this.cachedPaused && !_loc6_)
            {
               break;
            }
            if(_loc5_.active || !_loc5_.cachedPaused && !_loc5_.gc && (_loc5_.cachedTotalTime != _loc5_.cachedTotalDuration || _loc5_.cachedDuration == 0))
            {
               if(param1 == this.cachedDuration && (_loc5_.cachedDuration != 0 || _loc5_.cachedStartTime == this.cachedDuration))
               {
                  _loc5_.renderTime(_loc5_.cachedReversed ? 0 : Number(_loc5_.cachedTotalDuration),param2,false);
               }
               else if(!_loc5_.cachedReversed)
               {
                  _loc5_.renderTime((param1 - _loc5_.cachedStartTime) * _loc5_.cachedTimeScale,param2,false);
               }
               else
               {
                  _loc4_ = Number(_loc5_.cacheIsDirty ? _loc5_.totalDuration : Number(_loc5_.cachedTotalDuration));
                  _loc5_.renderTime(_loc4_ - (param1 - _loc5_.cachedStartTime) * _loc5_.cachedTimeScale,param2,false);
               }
            }
            _loc5_ = _loc3_;
         }
         return param1;
      }
      
      public function hasPausedChild() : Boolean
      {
         var _loc1_:TweenCore = this.gc ? _endCaps[0] : _firstChild;
         while(_loc1_)
         {
            if(_loc1_.cachedPaused || _loc1_ is TimelineLite && (_loc1_ as TimelineLite).hasPausedChild())
            {
               return true;
            }
            _loc1_ = _loc1_.nextNode;
         }
         return false;
      }
      
      public function getChildren(param1:Boolean = true, param2:Boolean = true, param3:Boolean = true, param4:Number = -9999999999) : Array
      {
         var _loc6_:Array = [];
         var _loc7_:int = 0;
         var _loc5_:TweenCore = this.gc ? _endCaps[0] : _firstChild;
         while(_loc5_)
         {
            if(_loc5_.cachedStartTime >= param4)
            {
               if(_loc5_ is TweenLite)
               {
                  if(param2)
                  {
                     _loc6_[_loc7_++] = _loc5_;
                  }
               }
               else
               {
                  if(param3)
                  {
                     _loc6_[_loc7_++] = _loc5_;
                  }
                  if(param1)
                  {
                     _loc6_ = _loc6_.concat(TimelineLite(_loc5_).getChildren(true,param2,param3));
                  }
               }
            }
            _loc5_ = _loc5_.nextNode;
         }
         return _loc6_;
      }
      
      public function getTweensOf(param1:Object, param2:Boolean = true) : Array
      {
         var _loc6_:int = 0;
         var _loc4_:Array = getChildren(param2,true,false);
         var _loc3_:Array = [];
         var _loc7_:int = int(_loc4_.length);
         var _loc5_:int = 0;
         _loc6_ = 0;
         while(_loc6_ < _loc7_)
         {
            if(TweenLite(_loc4_[_loc6_]).target == param1)
            {
               _loc3_[_loc5_++] = _loc4_[_loc6_];
            }
            _loc6_ += 1;
         }
         return _loc3_;
      }
      
      public function shiftChildren(param1:Number, param2:Boolean = false, param3:Number = 0) : void
      {
         var _loc5_:TweenCore = this.gc ? _endCaps[0] : _firstChild;
         while(_loc5_)
         {
            if(_loc5_.cachedStartTime >= param3)
            {
               _loc5_.cachedStartTime += param1;
            }
            _loc5_ = _loc5_.nextNode;
         }
         if(param2)
         {
            for(var _loc4_:String in _labels)
            {
               if(_labels[_loc4_] >= param3)
               {
                  var _loc6_:String = _loc4_;
                  var _loc7_:Number = _labels[_loc6_] + param1;
                  _labels[_loc6_] = _loc7_;
               }
            }
         }
         this.setDirtyCache(true);
      }
      
      public function killTweensOf(param1:Object, param2:Boolean = true, param3:Object = null) : Boolean
      {
         var _loc4_:TweenLite = null;
         var _loc5_:Array = getTweensOf(param1,param2);
         var _loc6_:int = int(_loc5_.length);
         while(--_loc6_ > -1)
         {
            _loc4_ = _loc5_[_loc6_];
            if(param3 != null)
            {
               _loc4_.killVars(param3);
            }
            if(param3 == null || _loc4_.cachedPT1 == null && _loc4_.initted)
            {
               _loc4_.setEnabled(false,false);
            }
         }
         return _loc5_.length > 0;
      }
      
      override public function invalidate() : void
      {
         var _loc1_:TweenCore = this.gc ? _endCaps[0] : _firstChild;
         while(_loc1_)
         {
            _loc1_.invalidate();
            _loc1_ = _loc1_.nextNode;
         }
      }
      
      public function clear(param1:Array = null) : void
      {
         if(param1 == null)
         {
            param1 = getChildren(false,true,true);
         }
         var _loc2_:int = int(param1.length);
         while(--_loc2_ > -1)
         {
            TweenCore(param1[_loc2_]).setEnabled(false,false);
         }
      }
      
      override public function setEnabled(param1:Boolean, param2:Boolean = false) : Boolean
      {
         var _loc3_:TweenCore = null;
         if(param1 == this.gc)
         {
            if(param1)
            {
               _firstChild = _loc3_ = _endCaps[0];
               _lastChild = _endCaps[1];
               _endCaps = [null,null];
            }
            else
            {
               _loc3_ = _firstChild;
               _endCaps = [_firstChild,_lastChild];
               _firstChild = _lastChild = null;
            }
            while(_loc3_)
            {
               _loc3_.setEnabled(param1,true);
               _loc3_ = _loc3_.nextNode;
            }
         }
         return super.setEnabled(param1,param2);
      }
      
      public function get currentProgress() : Number
      {
         return this.cachedTime / this.duration;
      }
      
      public function set currentProgress(param1:Number) : void
      {
         setTotalTime(this.duration * param1,false);
      }
      
      override public function get duration() : Number
      {
         var _loc1_:Number = NaN;
         if(this.cacheIsDirty)
         {
            _loc1_ = this.totalDuration;
         }
         return this.cachedDuration;
      }
      
      override public function set duration(param1:Number) : void
      {
         if(this.duration != 0 && param1 != 0)
         {
            this.timeScale = this.duration / param1;
         }
      }
      
      override public function get totalDuration() : Number
      {
         var _loc5_:Number = NaN;
         var _loc2_:TweenCore = null;
         var _loc4_:Number = NaN;
         if(this.cacheIsDirty)
         {
            _loc4_ = 0;
            var _loc3_:TweenCore = this.gc ? _endCaps[0] : _firstChild;
            var _loc1_:Number = -Infinity;
            while(_loc3_)
            {
               _loc2_ = _loc3_.nextNode;
               if(_loc3_.cachedStartTime < _loc1_)
               {
                  this.addChild(_loc3_);
                  _loc1_ = _loc3_.prevNode.cachedStartTime;
               }
               else
               {
                  _loc1_ = _loc3_.cachedStartTime;
               }
               if(_loc3_.cachedStartTime < 0)
               {
                  _loc4_ -= _loc3_.cachedStartTime;
                  this.shiftChildren(-_loc3_.cachedStartTime,false,-9999999999);
               }
               _loc5_ = _loc3_.cachedStartTime + _loc3_.totalDuration / _loc3_.cachedTimeScale;
               if(_loc5_ > _loc4_)
               {
                  _loc4_ = _loc5_;
               }
               _loc3_ = _loc2_;
            }
            this.cachedDuration = this.cachedTotalDuration = _loc4_;
            this.cacheIsDirty = false;
         }
         return this.cachedTotalDuration;
      }
      
      override public function set totalDuration(param1:Number) : void
      {
         if(this.totalDuration != 0 && param1 != 0)
         {
            this.timeScale = this.totalDuration / param1;
         }
      }
      
      public function get timeScale() : Number
      {
         return this.cachedTimeScale;
      }
      
      public function set timeScale(param1:Number) : void
      {
         if(param1 == 0)
         {
            param1 = 0.0001;
         }
         var _loc2_:Number = this.cachedPauseTime || this.cachedPauseTime == 0 ? this.cachedPauseTime : this.timeline.cachedTotalTime;
         this.cachedStartTime = _loc2_ - (_loc2_ - this.cachedStartTime) * this.cachedTimeScale / param1;
         this.cachedTimeScale = param1;
         setDirtyCache(false);
      }
      
      public function get useFrames() : Boolean
      {
         var _loc1_:SimpleTimeline = this.timeline;
         while(_loc1_.timeline)
         {
            _loc1_ = _loc1_.timeline;
         }
         return _loc1_ == TweenLite.rootFramesTimeline;
      }
      
      override public function get rawTime() : Number
      {
         if(this.cachedTotalTime != 0 && this.cachedTotalTime != this.cachedTotalDuration)
         {
            return this.cachedTotalTime;
         }
         return (this.timeline.rawTime - this.cachedStartTime) * this.cachedTimeScale;
      }
   }
}

