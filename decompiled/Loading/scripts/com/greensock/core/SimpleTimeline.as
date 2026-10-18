package com.greensock.core
{
   public class SimpleTimeline extends TweenCore
   {
      
      protected var _firstChild:TweenCore;
      
      protected var _lastChild:TweenCore;
      
      public var autoRemoveChildren:Boolean;
      
      public function SimpleTimeline(param1:Object = null)
      {
         super(0,param1);
      }
      
      public function addChild(param1:TweenCore) : void
      {
         if(!param1.cachedOrphan && param1.timeline)
         {
            param1.timeline.remove(param1,true);
         }
         param1.timeline = this;
         if(param1.gc)
         {
            param1.setEnabled(true,true);
         }
         if(_firstChild)
         {
            _firstChild.prevNode = param1;
         }
         param1.nextNode = _firstChild;
         _firstChild = param1;
         param1.prevNode = null;
         param1.cachedOrphan = false;
      }
      
      public function remove(param1:TweenCore, param2:Boolean = false) : void
      {
         if(param1.cachedOrphan)
         {
            return;
         }
         if(!param2)
         {
            param1.setEnabled(false,true);
         }
         if(param1.nextNode)
         {
            param1.nextNode.prevNode = param1.prevNode;
         }
         else if(_lastChild == param1)
         {
            _lastChild = param1.prevNode;
         }
         if(param1.prevNode)
         {
            param1.prevNode.nextNode = param1.nextNode;
         }
         else if(_firstChild == param1)
         {
            _firstChild = param1.nextNode;
         }
         param1.cachedOrphan = true;
      }
      
      override public function renderTime(param1:Number, param2:Boolean = false, param3:Boolean = false) : void
      {
         var _loc4_:Number = NaN;
         var _loc5_:TweenCore = null;
         var _loc6_:TweenCore = _firstChild;
         this.cachedTotalTime = param1;
         this.cachedTime = param1;
         while(_loc6_)
         {
            _loc5_ = _loc6_.nextNode;
            if(_loc6_.active || param1 >= _loc6_.cachedStartTime && !_loc6_.cachedPaused && !_loc6_.gc)
            {
               if(!_loc6_.cachedReversed)
               {
                  _loc6_.renderTime((param1 - _loc6_.cachedStartTime) * _loc6_.cachedTimeScale,param2,false);
               }
               else
               {
                  _loc4_ = _loc6_.cacheIsDirty ? _loc6_.totalDuration : _loc6_.cachedTotalDuration;
                  _loc6_.renderTime(_loc4_ - (param1 - _loc6_.cachedStartTime) * _loc6_.cachedTimeScale,param2,false);
               }
            }
            _loc6_ = _loc5_;
         }
      }
      
      public function get rawTime() : Number
      {
         return this.cachedTotalTime;
      }
   }
}

