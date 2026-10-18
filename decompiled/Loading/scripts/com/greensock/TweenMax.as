package com.greensock
{
   import com.greensock.core.*;
   import com.greensock.events.TweenEvent;
   import com.greensock.plugins.*;
   import flash.display.*;
   import flash.events.*;
   import flash.utils.*;
   
   public class TweenMax extends TweenLite implements IEventDispatcher
   {
      
      public static const version:Number = 11.4;
      
      private static var _overwriteMode:int = OverwriteManager.enabled ? OverwriteManager.mode : OverwriteManager.init(2);
      
      public static var killTweensOf:Function = TweenLite.killTweensOf;
      
      public static var killDelayedCallsTo:Function = TweenLite.killTweensOf;
      
      TweenPlugin.activate([AutoAlphaPlugin,EndArrayPlugin,FramePlugin,RemoveTintPlugin,TintPlugin,VisiblePlugin,VolumePlugin,BevelFilterPlugin,BezierPlugin,BezierThroughPlugin,BlurFilterPlugin,ColorMatrixFilterPlugin,ColorTransformPlugin,DropShadowFilterPlugin,FrameLabelPlugin,GlowFilterPlugin,HexColorsPlugin,RoundPropsPlugin,ShortRotationPlugin,{}]);
      
      protected var _dispatcher:EventDispatcher;
      
      protected var _hasUpdateListener:Boolean;
      
      protected var _repeat:int = 0;
      
      protected var _repeatDelay:Number = 0;
      
      protected var _cyclesComplete:int = 0;
      
      protected var _easePower:int;
      
      protected var _easeType:int;
      
      public var yoyo:Boolean;
      
      public function TweenMax(param1:Object, param2:Number, param3:Object)
      {
         super(param1,param2,param3);
         this.yoyo = Boolean(this.vars.yoyo);
         _repeat = uint(this.vars.repeat);
         _repeatDelay = this.vars.repeatDelay ? Number(this.vars.repeatDelay) : 0;
         this.cacheIsDirty = true;
         if(this.vars.onCompleteListener || this.vars.onInitListener || this.vars.onUpdateListener || this.vars.onStartListener || this.vars.onRepeatListener || this.vars.onReverseCompleteListener)
         {
            initDispatcher();
            if(param2 == 0 && _delay == 0)
            {
               _dispatcher.dispatchEvent(new TweenEvent("change"));
               _dispatcher.dispatchEvent(new TweenEvent("complete"));
            }
         }
         if(this.vars.timeScale && !(this.target is TweenCore))
         {
            this.cachedTimeScale = this.vars.timeScale;
         }
      }
      
      public static function to(param1:Object, param2:Number, param3:Object) : TweenMax
      {
         return new TweenMax(param1,param2,param3);
      }
      
      public static function from(param1:Object, param2:Number, param3:Object) : TweenMax
      {
         param3.runBackwards = true;
         if(!("immediateRender" in param3))
         {
            param3.immediateRender = true;
         }
         return new TweenMax(param1,param2,param3);
      }
      
      public static function fromTo(param1:Object, param2:Number, param3:Object, param4:Object) : TweenMax
      {
         param4.startAt = param3;
         if(param3.immediateRender)
         {
            param4.immediateRender = true;
         }
         return new TweenMax(param1,param2,param4);
      }
      
      public static function allTo(param1:Array, param2:Number, param3:Object, param4:Number = 0, param5:Function = null, param6:Array = null) : Array
      {
         var varsDup:Object;
         var p:String;
         var targets:Array = param1;
         var duration:Number = param2;
         var vars:Object = param3;
         var stagger:Number = param4;
         var onCompleteAll:Function = param5;
         var onCompleteAllParams:Array = param6;
         var l:int = int(targets.length);
         var a:Array = [];
         var curDelay:Number = "delay" in vars ? Number(vars.delay) : 0;
         var onCompleteProxy:Function = vars.onComplete;
         var onCompleteParamsProxy:Array = vars.onCompleteParams;
         var lastIndex:int = stagger <= 0 ? 0 : l - 1;
         var i:int = 0;
         while(i < l)
         {
            varsDup = {};
            for(p in vars)
            {
               varsDup[p] = vars[p];
            }
            varsDup.delay = curDelay;
            if(i == lastIndex && onCompleteAll != null)
            {
               varsDup.onComplete = function():void
               {
                  if(onCompleteProxy != null)
                  {
                     onCompleteProxy.apply(null,onCompleteParamsProxy);
                  }
                  onCompleteAll.apply(null,onCompleteAllParams);
               };
            }
            a[a.length] = new TweenMax(targets[i],duration,varsDup);
            curDelay += stagger;
            i += 1;
         }
         return a;
      }
      
      public static function allFrom(param1:Array, param2:Number, param3:Object, param4:Number = 0, param5:Function = null, param6:Array = null) : Array
      {
         param3.runBackwards = true;
         if(!("immediateRender" in param3))
         {
            param3.immediateRender = true;
         }
         return allTo(param1,param2,param3,param4,param5,param6);
      }
      
      public static function allFromTo(param1:Array, param2:Number, param3:Object, param4:Object, param5:Number = 0, param6:Function = null, param7:Array = null) : Array
      {
         param4.startAt = param3;
         if(param3.immediateRender)
         {
            param4.immediateRender = true;
         }
         return allTo(param1,param2,param4,param5,param6,param7);
      }
      
      public static function delayedCall(param1:Number, param2:Function, param3:Array = null, param4:Boolean = false) : TweenMax
      {
         return new TweenMax(param2,0,{
            "delay":param1,
            "onComplete":param2,
            "onCompleteParams":param3,
            "immediateRender":false,
            "useFrames":param4,
            "overwrite":0
         });
      }
      
      public static function getTweensOf(param1:Object) : Array
      {
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:Array = masterList[param1];
         var _loc3_:Array = [];
         if(_loc2_)
         {
            _loc5_ = int(_loc2_.length);
            _loc4_ = 0;
            while(--_loc5_ > -1)
            {
               if(!TweenLite(_loc2_[_loc5_]).gc)
               {
                  _loc3_[_loc4_++] = _loc2_[_loc5_];
               }
            }
         }
         return _loc3_;
      }
      
      public static function isTweening(param1:Object) : Boolean
      {
         var _loc3_:TweenLite = null;
         var _loc2_:Array = getTweensOf(param1);
         var _loc4_:int = int(_loc2_.length);
         while(--_loc4_ > -1)
         {
            _loc3_ = _loc2_[_loc4_];
            if(_loc3_.active || _loc3_.cachedStartTime == _loc3_.timeline.cachedTime && _loc3_.timeline.active)
            {
               return true;
            }
         }
         return false;
      }
      
      public static function getAllTweens() : Array
      {
         var _loc1_:* = null;
         var _loc4_:int = 0;
         var _loc5_:Dictionary = masterList;
         var _loc3_:int = 0;
         var _loc2_:Array = [];
         for each(_loc1_ in _loc5_)
         {
            _loc4_ = int(_loc1_.length);
            while(--_loc4_ > -1)
            {
               if(!TweenLite(_loc1_[_loc4_]).gc)
               {
                  _loc2_[_loc3_++] = _loc1_[_loc4_];
               }
            }
         }
         return _loc2_;
      }
      
      public static function killAll(param1:Boolean = false, param2:Boolean = true, param3:Boolean = true) : void
      {
         var _loc5_:Boolean = false;
         var _loc4_:Array = getAllTweens();
         var _loc6_:int = int(_loc4_.length);
         while(--_loc6_ > -1)
         {
            _loc5_ = _loc4_[_loc6_].target == _loc4_[_loc6_].vars.onComplete;
            if(_loc5_ == param3 || _loc5_ != param2)
            {
               if(param1)
               {
                  _loc4_[_loc6_].complete(false);
               }
               else
               {
                  _loc4_[_loc6_].setEnabled(false,false);
               }
            }
         }
      }
      
      public static function killChildTweensOf(param1:DisplayObjectContainer, param2:Boolean = false) : void
      {
         var _loc6_:DisplayObjectContainer = null;
         var _loc5_:Object = null;
         var _loc3_:Array = getAllTweens();
         var _loc4_:int = int(_loc3_.length);
         while(--_loc4_ > -1)
         {
            _loc5_ = _loc3_[_loc4_].target;
            if(_loc5_ is DisplayObject)
            {
               _loc6_ = _loc5_.parent;
               while(_loc6_)
               {
                  if(_loc6_ == param1)
                  {
                     if(param2)
                     {
                        _loc3_[_loc4_].complete(false);
                     }
                     else
                     {
                        _loc3_[_loc4_].setEnabled(false,false);
                     }
                  }
                  _loc6_ = _loc6_.parent;
               }
            }
         }
      }
      
      public static function pauseAll(param1:Boolean = true, param2:Boolean = true) : void
      {
         changePause(true,param1,param2);
      }
      
      public static function resumeAll(param1:Boolean = true, param2:Boolean = true) : void
      {
         changePause(false,param1,param2);
      }
      
      private static function changePause(param1:Boolean, param2:Boolean = true, param3:Boolean = false) : void
      {
         var _loc5_:Boolean = false;
         var _loc4_:Array = getAllTweens();
         var _loc6_:int = int(_loc4_.length);
         while(--_loc6_ > -1)
         {
            _loc5_ = TweenLite(_loc4_[_loc6_]).target == TweenLite(_loc4_[_loc6_]).vars.onComplete;
            if(_loc5_ == param3 || _loc5_ != param2)
            {
               TweenCore(_loc4_[_loc6_]).paused = param1;
            }
         }
      }
      
      public static function get globalTimeScale() : Number
      {
         return TweenLite.rootTimeline == null ? 1 : TweenLite.rootTimeline.cachedTimeScale;
      }
      
      public static function set globalTimeScale(param1:Number) : void
      {
         if(param1 == 0)
         {
            param1 = 0.0001;
         }
         if(TweenLite.rootTimeline == null)
         {
            TweenLite.to({},0,{});
         }
         var _loc3_:SimpleTimeline = TweenLite.rootTimeline;
         var _loc2_:Number = getTimer() * 0.001;
         _loc3_.cachedStartTime = _loc2_ - (_loc2_ - _loc3_.cachedStartTime) * _loc3_.cachedTimeScale / param1;
         _loc3_ = TweenLite.rootFramesTimeline;
         _loc2_ = TweenLite.rootFrame;
         _loc3_.cachedStartTime = _loc2_ - (_loc2_ - _loc3_.cachedStartTime) * _loc3_.cachedTimeScale / param1;
         TweenLite.rootFramesTimeline.cachedTimeScale = TweenLite.rootTimeline.cachedTimeScale = param1;
      }
      
      override protected function init() : void
      {
         var _loc6_:TweenMax = null;
         var _loc1_:String = null;
         var _loc2_:Object = null;
         var _loc4_:PropTween = null;
         var _loc3_:PropTween = null;
         var _loc5_:String = null;
         var _loc7_:int = 0;
         if(this.vars.startAt)
         {
            this.vars.startAt.overwrite = 0;
            this.vars.startAt.immediateRender = true;
            _loc6_ = new TweenMax(this.target,0,this.vars.startAt);
         }
         if(_dispatcher)
         {
            _dispatcher.dispatchEvent(new TweenEvent("init"));
         }
         super.init();
         if(_ease in fastEaseLookup)
         {
            _easeType = fastEaseLookup[_ease][0];
            _easePower = fastEaseLookup[_ease][1];
         }
         if(this.vars.roundProps != null && "roundProps" in TweenLite.plugins)
         {
            var _loc8_:Array = this.vars.roundProps;
            _loc7_ = int(_loc8_.length);
            while(--_loc7_ > -1)
            {
               _loc5_ = _loc8_[_loc7_];
               _loc3_ = this.cachedPT1;
               while(_loc3_)
               {
                  if(_loc3_.name == _loc5_)
                  {
                     if(_loc3_.isPlugin)
                     {
                        _loc3_.target.round = true;
                     }
                     else
                     {
                        if(_loc2_ == null)
                        {
                           _loc2_ = new TweenLite.plugins.roundProps();
                           _loc2_.add(_loc3_.target,_loc5_,_loc3_.start,_loc3_.change);
                           _hasPlugins = true;
                           this.cachedPT1 = _loc4_ = insertPropTween(_loc2_,"changeFactor",0,1,"_MULTIPLE_",true,this.cachedPT1);
                        }
                        else
                        {
                           _loc2_.add(_loc3_.target,_loc5_,_loc3_.start,_loc3_.change);
                        }
                        this.removePropTween(_loc3_);
                        this.propTweenLookup[_loc5_] = _loc4_;
                     }
                  }
                  else if(_loc3_.isPlugin && _loc3_.name == "_MULTIPLE_" && !_loc3_.target.round)
                  {
                     _loc1_ = " " + _loc3_.target.overwriteProps.join(" ") + " ";
                     if(_loc1_.indexOf(" " + _loc5_ + " ") != -1)
                     {
                        _loc3_.target.round = true;
                     }
                  }
                  _loc3_ = _loc3_.nextNode;
               }
            }
         }
      }
      
      protected function insertPropTween(param1:Object, param2:String, param3:Number, param4:*, param5:String, param6:Boolean, param7:PropTween) : PropTween
      {
         var _loc8_:Array = null;
         var _loc10_:int = 0;
         var _loc9_:PropTween = new PropTween(param1,param2,param3,typeof param4 == "number" ? param4 - param3 : Number(param4),param5,param6,param7);
         if(param6 && param5 == "_MULTIPLE_")
         {
            _loc8_ = param1.overwriteProps;
            _loc10_ = int(_loc8_.length);
            while(--_loc10_ > -1)
            {
               this.propTweenLookup[_loc8_[_loc10_]] = _loc9_;
            }
         }
         else
         {
            this.propTweenLookup[param5] = _loc9_;
         }
         return _loc9_;
      }
      
      protected function removePropTween(param1:PropTween) : Boolean
      {
         if(param1.nextNode)
         {
            param1.nextNode.prevNode = param1.prevNode;
         }
         if(param1.prevNode)
         {
            param1.prevNode.nextNode = param1.nextNode;
         }
         else if(this.cachedPT1 == param1)
         {
            this.cachedPT1 = param1.nextNode;
         }
         if(param1.isPlugin && param1.target.onDisable)
         {
            param1.target.onDisable();
            if(param1.target.activeDisable)
            {
               return true;
            }
         }
         return false;
      }
      
      override public function invalidate() : void
      {
         this.yoyo = this.vars.yoyo == true;
         _repeat = this.vars.repeat ? Number(this.vars.repeat) : 0;
         _repeatDelay = this.vars.repeatDelay ? Number(this.vars.repeatDelay) : 0;
         _hasUpdateListener = false;
         if(this.vars.onCompleteListener != null || this.vars.onUpdateListener != null || this.vars.onStartListener != null)
         {
            initDispatcher();
         }
         setDirtyCache(true);
         super.invalidate();
      }
      
      public function updateTo(param1:Object, param2:Boolean = false) : void
      {
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:PropTween = null;
         var _loc7_:Number = this.ratio;
         if(param2 && this.timeline != null && this.cachedStartTime < this.timeline.cachedTime)
         {
            this.cachedStartTime = this.timeline.cachedTime;
            this.setDirtyCache(false);
            if(this.gc)
            {
               this.setEnabled(true,false);
            }
            else
            {
               this.timeline.addChild(this);
            }
         }
         for(var _loc3_:String in param1)
         {
            this.vars[_loc3_] = param1[_loc3_];
         }
         if(this.initted)
         {
            this.initted = false;
            if(!param2)
            {
               init();
               if(!param2 && this.cachedTime > 0 && this.cachedTime < this.cachedDuration)
               {
                  _loc4_ = 1 / (1 - _loc7_);
                  _loc6_ = this.cachedPT1;
                  while(_loc6_)
                  {
                     _loc5_ = _loc6_.start + _loc6_.change;
                     _loc6_.change *= _loc4_;
                     _loc6_.start = _loc5_ - _loc6_.change;
                     _loc6_ = _loc6_.nextNode;
                  }
               }
            }
         }
      }
      
      public function setDestination(param1:String, param2:*, param3:Boolean = true) : void
      {
         var _loc4_:Object = {};
         _loc4_[param1] = param2;
         updateTo(_loc4_,!param3);
      }
      
      public function killProperties(param1:Array) : void
      {
         var _loc2_:Object = {};
         var _loc3_:int = int(param1.length);
         while(--_loc3_ > -1)
         {
            _loc2_[param1[_loc3_]] = true;
         }
         killVars(_loc2_);
      }
      
      override public function renderTime(param1:Number, param2:Boolean = false, param3:Boolean = false) : void
      {
         var _loc13_:Boolean = false;
         var _loc9_:Boolean = false;
         var _loc6_:Boolean = false;
         var _loc10_:Number = NaN;
         var _loc12_:int = 0;
         var _loc11_:int = 0;
         var _loc4_:Number = NaN;
         var _loc8_:Number = this.cacheIsDirty ? this.totalDuration : this.cachedTotalDuration;
         var _loc7_:Number = this.cachedTime;
         if(param1 >= _loc8_)
         {
            this.cachedTotalTime = _loc8_;
            this.cachedTime = this.cachedDuration;
            this.ratio = 1;
            _loc13_ = true;
            if(this.cachedDuration == 0)
            {
               if((param1 == 0 || _rawPrevTime < 0) && _rawPrevTime != param1)
               {
                  param3 = true;
               }
               _rawPrevTime = param1;
            }
         }
         else if(param1 <= 0)
         {
            if(param1 < 0)
            {
               this.active = false;
               if(this.cachedDuration == 0)
               {
                  if(_rawPrevTime > 0)
                  {
                     param3 = true;
                     _loc13_ = true;
                  }
                  _rawPrevTime = param1;
               }
            }
            this.cachedTotalTime = this.cachedTime = this.ratio = 0;
            if(this.cachedReversed && _loc7_ != 0)
            {
               _loc13_ = true;
            }
         }
         else
         {
            this.cachedTotalTime = this.cachedTime = param1;
            _loc6_ = true;
         }
         if(_repeat != 0)
         {
            _loc10_ = this.cachedDuration + _repeatDelay;
            if(_loc13_)
            {
               if(this.yoyo && _repeat % 2)
               {
                  this.cachedTime = this.ratio = 0;
               }
            }
            else if(param1 > 0)
            {
               _loc12_ = _cyclesComplete;
               _cyclesComplete = this.cachedTotalTime / _loc10_ >> 0;
               if(_cyclesComplete == this.cachedTotalTime / _loc10_)
               {
                  _cyclesComplete = _cyclesComplete - 1;
               }
               if(_loc12_ != _cyclesComplete)
               {
                  _loc9_ = true;
               }
               this.cachedTime = (this.cachedTotalTime / _loc10_ - _cyclesComplete) * _loc10_;
               if(this.yoyo && _cyclesComplete % 2)
               {
                  this.cachedTime = this.cachedDuration - this.cachedTime;
               }
               else if(this.cachedTime >= this.cachedDuration)
               {
                  this.cachedTime = this.cachedDuration;
                  this.ratio = 1;
                  _loc6_ = false;
               }
               if(this.cachedTime <= 0)
               {
                  this.cachedTime = this.ratio = 0;
                  _loc6_ = false;
               }
            }
         }
         if(_loc7_ == this.cachedTime && !param3)
         {
            return;
         }
         if(!this.initted)
         {
            init();
         }
         if(!this.active && !this.cachedPaused)
         {
            this.active = true;
         }
         if(_loc6_)
         {
            if(_easeType)
            {
               _loc11_ = _easePower;
               _loc4_ = this.cachedTime / this.cachedDuration;
               if(_easeType == 2)
               {
                  this.ratio = _loc4_ = 1 - _loc4_;
                  while(--_loc11_ > -1)
                  {
                     this.ratio = _loc4_ * this.ratio;
                  }
                  this.ratio = 1 - this.ratio;
               }
               else if(_easeType == 1)
               {
                  this.ratio = _loc4_;
                  while(--_loc11_ > -1)
                  {
                     this.ratio = _loc4_ * this.ratio;
                  }
               }
               else if(_loc4_ < 0.5)
               {
                  this.ratio = _loc4_ *= 2;
                  while(--_loc11_ > -1)
                  {
                     this.ratio = _loc4_ * this.ratio;
                  }
                  this.ratio *= 0.5;
               }
               else
               {
                  this.ratio = _loc4_ = (1 - _loc4_) * 2;
                  while(--_loc11_ > -1)
                  {
                     this.ratio = _loc4_ * this.ratio;
                  }
                  this.ratio = 1 - 0.5 * this.ratio;
               }
            }
            else
            {
               this.ratio = _ease(this.cachedTime,0,1,this.cachedDuration);
            }
         }
         if(_loc7_ == 0 && this.cachedTotalTime != 0 && !param2)
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
         var _loc5_:PropTween = this.cachedPT1;
         while(_loc5_)
         {
            _loc5_.target[_loc5_.property] = _loc5_.start + this.ratio * _loc5_.change;
            _loc5_ = _loc5_.nextNode;
         }
         if(_hasUpdate && !param2)
         {
            this.vars.onUpdate.apply(null,this.vars.onUpdateParams);
         }
         if(_hasUpdateListener && !param2)
         {
            _dispatcher.dispatchEvent(new TweenEvent("change"));
         }
         if(_loc13_)
         {
            if(_hasPlugins && this.cachedPT1)
            {
               onPluginEvent("onComplete",this);
            }
            complete(true,param2);
         }
         else if(_loc9_ && !param2)
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
         if(!param2 && _dispatcher)
         {
            if(this.cachedTotalTime == this.cachedTotalDuration && !this.cachedReversed)
            {
               _dispatcher.dispatchEvent(new TweenEvent("complete"));
            }
            else if(this.cachedReversed && this.cachedTotalTime == 0)
            {
               _dispatcher.dispatchEvent(new TweenEvent("reverseComplete"));
            }
         }
      }
      
      protected function initDispatcher() : void
      {
         if(_dispatcher == null)
         {
            _dispatcher = new EventDispatcher(this);
         }
         if(this.vars.onInitListener is Function)
         {
            _dispatcher.addEventListener("init",this.vars.onInitListener,false,0,true);
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
         if(_dispatcher)
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
      
      public function get currentProgress() : Number
      {
         return this.cachedTime / this.duration;
      }
      
      public function set currentProgress(param1:Number) : void
      {
         if(_cyclesComplete == 0)
         {
            setTotalTime(this.duration * param1,false);
         }
         else
         {
            setTotalTime(this.duration * param1 + _cyclesComplete * this.cachedDuration,false);
         }
      }
      
      public function get totalProgress() : Number
      {
         return this.cachedTotalTime / this.totalDuration;
      }
      
      public function set totalProgress(param1:Number) : void
      {
         setTotalTime(this.totalDuration * param1,false);
      }
      
      override public function set currentTime(param1:Number) : void
      {
         if(_cyclesComplete != 0)
         {
            if(this.yoyo && _cyclesComplete % 2 == 1)
            {
               param1 = this.duration - param1 + _cyclesComplete * (this.cachedDuration + _repeatDelay);
            }
            else
            {
               param1 += _cyclesComplete * (this.duration + _repeatDelay);
            }
         }
         setTotalTime(param1,false);
      }
      
      override public function get totalDuration() : Number
      {
         if(this.cacheIsDirty)
         {
            this.cachedTotalDuration = _repeat == -1 ? 999999999999 : this.cachedDuration * (_repeat + 1) + _repeatDelay * _repeat;
            this.cacheIsDirty = false;
         }
         return this.cachedTotalDuration;
      }
      
      override public function set totalDuration(param1:Number) : void
      {
         if(_repeat == -1)
         {
            return;
         }
         this.duration = (param1 - _repeat * _repeatDelay) / (_repeat + 1);
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
   }
}

