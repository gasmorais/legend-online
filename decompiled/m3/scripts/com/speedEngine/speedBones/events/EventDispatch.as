package com.speedEngine.speedBones.events
{
   import com.speedEngine.speedBones.BaseClass;
   import com.speedEngine.speedBones.animation.Animation;
   import com.speedEngine.speedBones.display.DisplayObject;
   import com.speedEngine.speedBones.interfaces.IDispatch;
   import com.speedEngine.speedBones.utils.speedBones_internal;
   import flash.geom.Point;
   
   use namespace speedBones_internal;
   
   public class EventDispatch extends BaseClass implements IDispatch
   {
      
      private var _typeCalls:Object;
      
      private var _target:Object;
      
      public function EventDispatch(param1:Object)
      {
         super();
         _typeCalls = {};
         _target = param1;
      }
      
      public function addEventListener(param1:String, param2:Function) : void
      {
         var _loc3_:Array = null;
         if(param2 == null)
         {
            return;
         }
         if(_typeCalls[param1] == null)
         {
            _loc3_ = [];
            _typeCalls[param1] = _loc3_;
         }
         else
         {
            _loc3_ = _typeCalls[param1];
            if(_loc3_.indexOf(param2) > -1)
            {
               return;
            }
         }
         _loc3_.push(param2);
      }
      
      public function removeEventListener(param1:String, param2:Function) : void
      {
         var _loc4_:Array = _typeCalls[param1];
         if(param2 == null || _loc4_ == null)
         {
            return;
         }
         var _loc3_:int = _loc4_.indexOf(param2);
         if(_loc3_ > -1)
         {
            _loc4_.splice(_loc3_,1);
         }
      }
      
      public function hasEventType(param1:String) : Boolean
      {
         return _typeCalls[param1] != null;
      }
      
      public function removeAllEvents() : void
      {
         deleteObject(_typeCalls);
      }
      
      public function dispathEventWidth(param1:Event, param2:Boolean = false) : void
      {
         var _loc3_:int = 0;
         var _loc4_:Function = null;
         var _loc5_:DisplayObject = null;
         var _loc6_:DisplayObject = null;
         var _loc7_:Point = null;
         var _loc9_:int = 0;
         var _loc8_:Array = _typeCalls[param1.type];
         _loc3_ = _loc8_ ? _loc8_.length : 0;
         param1.currentTarget = _target as IDispatch;
         if(param1.target == null)
         {
            param1.target = _target as IDispatch;
         }
         setEventTarget(param1);
         _loc9_ = 0;
         while(_loc9_ < _loc3_)
         {
            _loc4_ = _loc8_[_loc9_];
            _loc4_.call(null,param1);
            _loc9_++;
         }
         if(param2)
         {
            _loc6_ = _target as DisplayObject;
            if(_loc6_)
            {
               _loc5_ = _loc6_.public::parent as DisplayObject;
               if(_loc5_)
               {
                  if(param1 is TouchEvent)
                  {
                     _loc7_ = _loc5_.speedBones_internal::globalToLocal(new Point((param1 as TouchEvent).stageX,(param1 as TouchEvent).stageY));
                     (param1 as TouchEvent).setTouchX(_loc7_.x);
                     (param1 as TouchEvent).setTouchY(_loc7_.y);
                  }
                  _loc5_.dispathEventWidth(param1,param2);
               }
            }
         }
         Event.pushEvent(param1);
      }
      
      private function setEventTarget(param1:Event) : void
      {
         var _loc2_:IDispatch = null;
         if(param1.currentTarget is Animation)
         {
            param1.currentTarget = (param1.currentTarget as Animation).public::parent;
         }
         if(param1.target is Animation)
         {
            param1.target = (param1.target as Animation).public::parent;
         }
         if(param1.currentTarget is DisplayObject)
         {
            _loc2_ = null;
            while(param1.target is DisplayObject && !(param1.target as DisplayObject).touchTarget)
            {
               _loc2_ = param1.target;
               param1.target = (param1.target as DisplayObject).public::parent;
            }
            if(_loc2_)
            {
               param1.target = _loc2_;
            }
         }
      }
      
      protected function deleteObject(param1:Object) : void
      {
         for(var _loc2_:String in param1)
         {
            param1[_loc2_] = null;
            delete param1[_loc2_];
         }
      }
      
      public function dispose() : void
      {
         _target = null;
         _typeCalls = null;
      }
   }
}

