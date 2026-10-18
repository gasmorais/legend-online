package com.greensock
{
   import com.greensock.core.*;
   import com.greensock.events.TweenEvent;
   import flash.events.*;
   
   public class TimelineMax extends TimelineLite implements IEventDispatcher
   {
      
      public static const version:Number = 1.392;
      
      protected var _repeat:int;
      
      protected var _repeatDelay:Number;
      
      protected var _cyclesComplete:int;
      
      protected var _dispatcher:EventDispatcher;
      
      protected var _hasUpdateListener:Boolean;
      
      public var yoyo:Boolean;
      
      public function TimelineMax(param1:Object = null)
      {
         super(param1);
         _repeat = this.vars.repeat ? Number(this.vars.repeat) : 0;
         _repeatDelay = this.vars.repeatDelay ? Number(this.vars.repeatDelay) : 0;
         _cyclesComplete = 0;
         this.yoyo = this.vars.yoyo == true;
         this.cacheIsDirty = true;
         if(this.vars.onCompleteListener != null || this.vars.onUpdateListener != null || this.vars.onStartListener != null || this.vars.onRepeatListener != null || this.vars.onReverseCompleteListener != null)
         {
            initDispatcher();
         }
      }
      
      private static function onInitTweenTo(param1:TweenLite, param2:TimelineMax, param3:Number) : void
      {
         param2.paused = true;
         if(!isNaN(param3))
         {
            param2.currentTime = param3;
         }
         if(param1.vars.currentTime != param2.currentTime)
         {
            param1.duration = Math.abs(Number(param1.vars.currentTime) - param2.currentTime) / param2.cachedTimeScale;
         }
      }
      
      private static function easeNone(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         return param1 / param4;
      }
      
      public function addCallback(param1:Function, param2:*, param3:Array = null) : TweenLite
      {
         var _loc4_:TweenLite = new TweenLite(param1,0,{
            "onComplete":param1,
            "onCompleteParams":param3,
            "overwrite":0,
            "immediateRender":false
         });
         insert(_loc4_,param2);
         return _loc4_;
      }
      
      public function removeCallback(param1:Function, param2:* = null) : Boolean
      {
         var _loc4_:Boolean = false;
         var _loc3_:Array = null;
         var _loc5_:int = 0;
         if(param2 == null)
         {
            return killTweensOf(param1,false);
         }
         if(typeof param2 == "string")
         {
            if(!(param2 in _labels))
            {
               return false;
            }
            param2 = _labels[param2];
         }
         _loc3_ = getTweensOf(param1,false);
         _loc5_ = int(_loc3_.length);
         while(--_loc5_ > -1)
         {
            if(_loc3_[_loc5_].cachedStartTime == param2)
            {
               remove(_loc3_[_loc5_] as TweenCore);
               _loc4_ = true;
            }
         }
         return _loc4_;
      }
      
      public function tweenTo(param1:*, param2:Object = null) : TweenLite
      {
         var _loc4_:Object = {
            "ease":easeNone,
            "overwrite":2,
            "useFrames":this.useFrames,
            "immediateRender":false
         };
         for(var _loc3_:String in param2)
         {
            _loc4_[_loc3_] = param2[_loc3_];
         }
         _loc4_.onInit = onInitTweenTo;
         _loc4_.onInitParams = [null,this,NaN];
         _loc4_.currentTime = parseTimeOrLabel(param1);
         var _loc5_:TweenLite = new TweenLite(this,Math.abs(Number(_loc4_.currentTime) - this.cachedTime) / this.cachedTimeScale || 0.001,_loc4_);
         _loc5_.vars.onInitParams[0] = _loc5_;
         return _loc5_;
      }
      
      public function tweenFromTo(param1:*, param2:*, param3:Object = null) : TweenLite
      {
         var _loc4_:TweenLite = tweenTo(param2,param3);
         _loc4_.vars.onInitParams[2] = parseTimeOrLabel(param1);
         _loc4_.duration = Math.abs(Number(_loc4_.vars.currentTime) - _loc4_.vars.onInitParams[2]) / this.cachedTimeScale;
         return _loc4_;
      }
      
      override public function renderTime(param1:Number, param2:Boolean = false, param3:Boolean = false) : void
      {
         var _loc12_:TweenCore = null;
         var _loc19_:Boolean = false;
         var _loc13_:Boolean = false;
         var _loc11_:Boolean = false;
         var _loc5_:TweenCore = null;
         var _loc6_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc17_:int = 0;
         var _loc8_:Boolean = false;
         var _loc16_:Boolean = false;
         var _loc18_:Boolean = false;
         if(this.gc)
         {
            this.setEnabled(true,false);
         }
         else if(!this.active && !this.cachedPaused)
         {
            this.active = true;
         }
         var _loc10_:Number = this.cacheIsDirty ? this.totalDuration : this.cachedTotalDuration;
         var _loc9_:Number = this.cachedTime;
         var _loc4_:Number = this.cachedStartTime;
         var _loc15_:Number = this.cachedTimeScale;
         var _loc7_:Boolean = this.cachedPaused;
         if(param1 >= _loc10_)
         {
            if(_rawPrevTime <= _loc10_ && _rawPrevTime != param1)
            {
               if(!this.cachedReversed && this.yoyo && _repeat % 2 != 0)
               {
                  forceChildrenToBeginning(0,param2);
                  this.cachedTime = 0;
               }
               else
               {
                  forceChildrenToEnd(this.cachedDuration,param2);
                  this.cachedTime = this.cachedDuration;
               }
               this.cachedTotalTime = _loc10_;
               _loc19_ = !this.hasPausedChild();
               _loc13_ = true;
               if(this.cachedDuration == 0 && _loc19_ && (param1 == 0 || _rawPrevTime < 0))
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
                  _loc19_ = true;
               }
            }
            if(_rawPrevTime >= 0 && _rawPrevTime != param1)
            {
               this.cachedTotalTime = 0;
               forceChildrenToBeginning(0,param2);
               this.cachedTime = 0;
               _loc13_ = true;
               if(this.cachedReversed)
               {
                  _loc19_ = true;
               }
            }
         }
         else
         {
            this.cachedTotalTime = this.cachedTime = param1;
         }
         _rawPrevTime = param1;
         if(_repeat != 0)
         {
            _loc14_ = this.cachedDuration + _repeatDelay;
            _loc17_ = _cyclesComplete;
            if(_loc19_)
            {
               if(this.yoyo && _repeat % 2)
               {
                  this.cachedTime = 0;
               }
            }
            else if(param1 > 0)
            {
               _cyclesComplete = this.cachedTotalTime / _loc14_ >> 0;
               if(_cyclesComplete == this.cachedTotalTime / _loc14_)
               {
                  _cyclesComplete = _cyclesComplete - 1;
               }
               if(_loc17_ != _cyclesComplete)
               {
                  _loc11_ = true;
               }
               this.cachedTime = (this.cachedTotalTime / _loc14_ - _cyclesComplete) * _loc14_;
               if(this.yoyo && _cyclesComplete % 2)
               {
                  this.cachedTime = this.cachedDuration - this.cachedTime;
               }
               else if(this.cachedTime >= this.cachedDuration)
               {
                  this.cachedTime = this.cachedDuration;
               }
               if(this.cachedTime < 0)
               {
                  this.cachedTime = 0;
               }
            }
            if(_loc11_ && !_loc19_ && (this.cachedTime != _loc9_ || param3))
            {
               _loc8_ = !this.yoyo || _cyclesComplete % 2 == 0;
               _loc16_ = !this.yoyo || _loc17_ % 2 == 0;
               _loc18_ = _loc8_ == _loc16_;
               if(_loc17_ > _cyclesComplete)
               {
                  _loc16_ = !_loc16_;
               }
               if(_loc16_)
               {
                  _loc9_ = forceChildrenToEnd(this.cachedDuration,param2);
                  if(_loc18_)
                  {
                     _loc9_ = forceChildrenToBeginning(0,true);
                  }
               }
               else
               {
                  _loc9_ = forceChildrenToBeginning(0,param2);
                  if(_loc18_)
                  {
                     _loc9_ = forceChildrenToEnd(this.cachedDuration,true);
                  }
               }
               _loc13_ = false;
            }
         }
         if(this.cachedTime == _loc9_ && !param3)
         {
            return;
         }
         if(!this.initted)
         {
            this.initted = true;
         }
         if(_loc9_ == 0 && this.cachedTotalTime != 0 && !param2)
         {
            if(this.vars.onStart)
            {
               this.vars.onStart.apply(null,this.vars.onStartParams);
            }
            if(_dispatcher)
            {
               _dispatcher.dispatchEvent(new TweenEvent("start"));
            }
         }
         if(!_loc13_)
         {
            if(this.cachedTime - _loc9_ > 0)
            {
               _loc12_ = _firstChild;
               while(_loc12_)
               {
                  _loc5_ = _loc12_.nextNode;
                  if(this.cachedPaused && !_loc7_)
                  {
                     break;
                  }
                  if(_loc12_.active || !_loc12_.cachedPaused && _loc12_.cachedStartTime <= this.cachedTime && !_loc12_.gc)
                  {
                     if(!_loc12_.cachedReversed)
                     {
                        _loc12_.renderTime((this.cachedTime - _loc12_.cachedStartTime) * _loc12_.cachedTimeScale,param2,false);
                     }
                     else
                     {
                        _loc6_ = Number(_loc12_.cacheIsDirty ? _loc12_.totalDuration : Number(_loc12_.cachedTotalDuration));
                        _loc12_.renderTime(_loc6_ - (this.cachedTime - _loc12_.cachedStartTime) * _loc12_.cachedTimeScale,param2,false);
                     }
                  }
                  _loc12_ = _loc5_;
               }
            }
            else
            {
               _loc12_ = _lastChild;
               while(_loc12_)
               {
                  _loc5_ = _loc12_.prevNode;
                  if(this.cachedPaused && !_loc7_)
                  {
                     break;
                  }
                  if(_loc12_.active || !_loc12_.cachedPaused && _loc12_.cachedStartTime <= _loc9_ && !_loc12_.gc)
                  {
                     if(!_loc12_.cachedReversed)
                     {
                        _loc12_.renderTime((this.cachedTime - _loc12_.cachedStartTime) * _loc12_.cachedTimeScale,param2,false);
                     }
                     else
                     {
                        _loc6_ = _loc12_.cacheIsDirty ? _loc12_.totalDuration : _loc12_.cachedTotalDuration;
                        _loc12_.renderTime(_loc6_ - (this.cachedTime - _loc12_.cachedStartTime) * _loc12_.cachedTimeScale,param2,false);
                     }
                  }
                  _loc12_ = _loc5_;
               }
            }
         }
         if(_hasUpdate && !param2)
         {
            this.vars.onUpdate.apply(null,this.vars.onUpdateParams);
         }
         if(_hasUpdateListener && !param2)
         {
            _dispatcher.dispatchEvent(new TweenEvent("change"));
         }
         if(_loc19_ && (_loc4_ == this.cachedStartTime || _loc15_ != this.cachedTimeScale) && (_loc10_ >= this.totalDuration || this.cachedTime == 0))
         {
            complete(true,param2);
         }
         else if(_loc11_ && !param2)
         {
            if(this.vars.onRepeat)
            {
               this.vars.onRepeat.apply(null,this.vars.onRepeatParams);
            }
            if(_dispatcher)
            {
               _dispatcher.dispatchEvent(new TweenEvent("repeat"));
            }
         }
      }
      
      override public function complete(param1:Boolean = false, param2:Boolean = false) : void
      {
         super.complete(param1,param2);
         if(_dispatcher && !param2)
         {
            if(this.cachedReversed && this.cachedTotalTime == 0 && this.cachedDuration != 0)
            {
               _dispatcher.dispatchEvent(new TweenEvent("reverseComplete"));
            }
            else
            {
               _dispatcher.dispatchEvent(new TweenEvent("complete"));
            }
         }
      }
      
      public function getActive(param1:Boolean = true, param2:Boolean = true, param3:Boolean = false) : Array
      {
         var _loc7_:int = 0;
         var _loc5_:Array = [];
         var _loc4_:Array = getChildren(param1,param2,param3);
         var _loc8_:int = int(_loc4_.length);
         var _loc6_:int = 0;
         _loc7_ = 0;
         while(_loc7_ < _loc8_)
         {
            if(TweenCore(_loc4_[_loc7_]).active)
            {
               _loc5_[_loc6_++] = _loc4_[_loc7_];
            }
            _loc7_ += 1;
         }
         return _loc5_;
      }
      
      override public function invalidate() : void
      {
         _repeat = this.vars.repeat ? Number(this.vars.repeat) : 0;
         _repeatDelay = this.vars.repeatDelay ? Number(this.vars.repeatDelay) : 0;
         this.yoyo = this.vars.yoyo == true;
         if(this.vars.onCompleteListener != null || this.vars.onUpdateListener != null || this.vars.onStartListener != null || this.vars.onRepeatListener != null || this.vars.onReverseCompleteListener != null)
         {
            initDispatcher();
         }
         setDirtyCache(true);
         super.invalidate();
      }
      
      public function getLabelAfter(param1:Number = NaN) : String
      {
         var _loc2_:int = 0;
         if(!param1 && param1 != 0)
         {
            param1 = this.cachedTime;
         }
         var _loc4_:Array = getLabelsArray();
         var _loc3_:int = int(_loc4_.length);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            if(_loc4_[_loc2_].time > param1)
            {
               return _loc4_[_loc2_].name;
            }
            _loc2_ += 1;
         }
         return null;
      }
      
      public function getLabelBefore(param1:Number = NaN) : String
      {
         if(!param1 && param1 != 0)
         {
            param1 = this.cachedTime;
         }
         var _loc3_:Array = getLabelsArray();
         var _loc2_:int = int(_loc3_.length);
         while(--_loc2_ > -1)
         {
            if(_loc3_[_loc2_].time < param1)
            {
               return _loc3_[_loc2_].name;
            }
         }
         return null;
      }
      
      protected function getLabelsArray() : Array
      {
         var _loc2_:Array = [];
         for(var _loc1_:String in _labels)
         {
            _loc2_[_loc2_.length] = {
               "time":_labels[_loc1_],
               "name":_loc1_
            };
         }
         _loc2_.sortOn("time",16);
         return _loc2_;
      }
      
      protected function initDispatcher() : void
      {
         if(_dispatcher == null)
         {
            _dispatcher = new EventDispatcher(this);
         }
         if(this.vars.onStartListener is Function)
         {
            _dispatcher.addEventListener("start",this.vars.onStartListener,false,0,true);
         }
         if(this.vars.onUpdateListener is Function)
         {
            _dispatcher.addEventListener("change",this.vars.onUpdateListener,false,0,true);
            _hasUpdateListener = true;
         }
         if(this.vars.onCompleteListener is Function)
         {
            _dispatcher.addEventListener("complete",this.vars.onCompleteListener,false,0,true);
         }
         if(this.vars.onRepeatListener is Function)
         {
            _dispatcher.addEventListener("repeat",this.vars.onRepeatListener,false,0,true);
         }
         if(this.vars.onReverseCompleteListener is Function)
         {
            _dispatcher.addEventListener("reverseComplete",this.vars.onReverseCompleteListener,false,0,true);
         }
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         if(_dispatcher == null)
         {
            initDispatcher();
         }
         if(param1 == "change")
         {
            _hasUpdateListener = true;
         }
         _dispatcher.addEventListener(param1,param2,param3,param4,param5);
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         if(_dispatcher != null)
         {
            _dispatcher.removeEventListener(param1,param2,param3);
         }
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         return _dispatcher == null ? false : _dispatcher.hasEventListener(param1);
      }
      
      public function willTrigger(param1:String) : Boolean
      {
         return _dispatcher == null ? false : _dispatcher.willTrigger(param1);
      }
      
      public function dispatchEvent(param1:Event) : Boolean
      {
         return _dispatcher == null ? false : _dispatcher.dispatchEvent(param1);
      }
      
      public function get totalProgress() : Number
      {
         return this.cachedTotalTime / this.totalDuration;
      }
      
      public function set totalProgress(param1:Number) : void
      {
         setTotalTime(this.totalDuration * param1,false);
      }
      
      override public function get totalDuration() : Number
      {
         var _loc1_:Number = NaN;
         if(this.cacheIsDirty)
         {
            _loc1_ = super.totalDuration;
            this.cachedTotalDuration = _repeat == -1 ? 999999999999 : this.cachedDuration * (_repeat + 1) + _repeatDelay * _repeat;
         }
         return this.cachedTotalDuration;
      }
      
      override public function set currentTime(param1:Number) : void
      {
         if(_cyclesComplete == 0)
         {
            setTotalTime(param1,false);
         }
         else if(this.yoyo && _cyclesComplete % 2 == 1)
         {
            setTotalTime(this.duration - param1 + _cyclesComplete * (this.cachedDuration + _repeatDelay),false);
         }
         else
         {
            setTotalTime(param1 + _cyclesComplete * (this.duration + _repeatDelay),false);
         }
      }
      
      public function get repeat() : int
      {
         return _repeat;
      }
      
      public function set repeat(param1:int) : void
      {
         _repeat = param1;
         setDirtyCache(true);
      }
      
      public function get repeatDelay() : Number
      {
         return _repeatDelay;
      }
      
      public function set repeatDelay(param1:Number) : void
      {
         _repeatDelay = param1;
         setDirtyCache(true);
      }
      
      public function get currentLabel() : String
      {
         return getLabelBefore(this.cachedTime + 1e-8);
      }
   }
}

