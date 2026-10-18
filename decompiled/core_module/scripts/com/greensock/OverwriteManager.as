package com.greensock
{
   import com.greensock.core.*;
   
   public class OverwriteManager
   {
      
      public static const version:Number = 6.03;
      
      public static const NONE:int = 0;
      
      public static const ALL_IMMEDIATE:int = 1;
      
      public static const AUTO:int = 2;
      
      public static const CONCURRENT:int = 3;
      
      public static const ALL_ONSTART:int = 4;
      
      public static const PREEXISTING:int = 5;
      
      public static var mode:int;
      
      public static var enabled:Boolean;
      
      public function OverwriteManager()
      {
         super();
      }
      
      public static function init(param1:int = 2) : int
      {
         TweenLite.overwriteManager = OverwriteManager;
         mode = param1;
         enabled = true;
         return mode;
      }
      
      public static function manageOverwrites(param1:TweenLite, param2:Object, param3:Array, param4:uint) : Boolean
      {
         var _loc18_:Boolean = false;
         var _loc6_:TweenLite = null;
         var _loc7_:int = 0;
         var _loc9_:* = 0;
         var _loc10_:TweenCore = null;
         var _loc12_:Number = NaN;
         var _loc15_:SimpleTimeline = null;
         var _loc8_:Number = NaN;
         if(param4 >= 4)
         {
            _loc9_ = param3.length;
            _loc7_ = 0;
            while(_loc7_ < _loc9_)
            {
               _loc6_ = param3[_loc7_];
               if(_loc6_ != param1)
               {
                  if(_loc6_.setEnabled(false,false))
                  {
                     _loc18_ = true;
                  }
               }
               else if(param4 == 5)
               {
                  break;
               }
               _loc7_++;
            }
            return _loc18_;
         }
         var _loc16_:Number = param1.cachedStartTime + 1e-10;
         var _loc13_:Array = [];
         var _loc17_:Array = [];
         var _loc14_:uint = 0;
         var _loc11_:uint = 0;
         _loc7_ = int(param3.length);
         while(--_loc7_ > -1)
         {
            _loc6_ = param3[_loc7_];
            if(!(_loc6_ == param1 || _loc6_.gc))
            {
               if(_loc6_.timeline != param1.timeline)
               {
                  if(!getGlobalPaused(_loc6_))
                  {
                     _loc17_[_loc14_++] = _loc6_;
                  }
               }
               else if(_loc6_.cachedStartTime <= _loc16_ && _loc6_.cachedStartTime + _loc6_.totalDuration + 1e-10 > _loc16_ && !getGlobalPaused(_loc6_))
               {
                  _loc13_[_loc11_++] = _loc6_;
               }
            }
         }
         if(_loc14_ != 0)
         {
            _loc8_ = param1.cachedTimeScale;
            var _loc5_:Number = _loc16_;
            _loc15_ = param1.timeline;
            while(_loc15_)
            {
               _loc8_ *= _loc15_.cachedTimeScale;
               _loc5_ += _loc15_.cachedStartTime;
               _loc15_ = _loc15_.timeline;
            }
            _loc16_ = _loc8_ * _loc5_;
            _loc7_ = int(_loc14_);
            while(--_loc7_ > -1)
            {
               _loc10_ = _loc17_[_loc7_];
               _loc8_ = _loc10_.cachedTimeScale;
               _loc5_ = _loc10_.cachedStartTime;
               _loc15_ = _loc10_.timeline;
               while(_loc15_)
               {
                  _loc8_ *= _loc15_.cachedTimeScale;
                  _loc5_ += _loc15_.cachedStartTime;
                  _loc15_ = _loc15_.timeline;
               }
               _loc12_ = _loc8_ * _loc5_;
               if(_loc12_ <= _loc16_ && (_loc12_ + _loc10_.totalDuration * _loc8_ + 1e-10 > _loc16_ || _loc10_.cachedDuration == 0))
               {
                  _loc13_[_loc11_++] = _loc10_;
               }
            }
         }
         if(_loc11_ == 0)
         {
            return _loc18_;
         }
         _loc7_ = int(_loc11_);
         if(param4 == 2)
         {
            while(--_loc7_ > -1)
            {
               _loc6_ = _loc13_[_loc7_];
               if(_loc6_.killVars(param2))
               {
                  _loc18_ = true;
               }
               if(_loc6_.cachedPT1 == null && _loc6_.initted)
               {
                  _loc6_.setEnabled(false,false);
               }
            }
         }
         else
         {
            while(--_loc7_ > -1)
            {
               if(TweenLite(_loc13_[_loc7_]).setEnabled(false,false))
               {
                  _loc18_ = true;
               }
            }
         }
         return _loc18_;
      }
      
      public static function getGlobalPaused(param1:TweenCore) : Boolean
      {
         var _loc2_:Boolean = false;
         while(param1)
         {
            if(param1.cachedPaused)
            {
               _loc2_ = true;
               break;
            }
            param1 = param1.timeline;
         }
         return _loc2_;
      }
   }
}

