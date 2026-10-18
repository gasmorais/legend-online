package com.speedEngine.game.event
{
   import com.speedEngine.game.base.basegame_internal;
   import flash.utils.getQualifiedClassName;
   
   use namespace basegame_internal;
   
   public class BaseEvent
   {
      
      private static var _eventPool:Vector.<BaseEvent> = new Vector.<BaseEvent>(0);
      
      private var _target:Object;
      
      private var _currentTarget:Object;
      
      private var _type:String;
      
      private var _bubbles:Boolean;
      
      private var _stopsPropagation:Boolean;
      
      private var _stopsImmediatePropagation:Boolean;
      
      private var _data:Object;
      
      public function BaseEvent(param1:String, param2:Boolean = false, param3:Object = null)
      {
         super();
         _type = param1;
         _bubbles = param2;
         _data = param3;
      }
      
      basegame_internal static function fromPool(param1:String, param2:Boolean = false, param3:Object = null) : BaseEvent
      {
         if(_eventPool.length)
         {
            return _eventPool.pop().reset(param1,param2,param3);
         }
         return new BaseEvent(param1,param2,param3);
      }
      
      basegame_internal static function toPool(param1:BaseEvent) : void
      {
         param1._data = param1._target = param1._currentTarget = null;
         _eventPool.push(param1);
      }
      
      public function stopPropagation() : void
      {
         _stopsPropagation = true;
      }
      
      public function stopImmediatePropagation() : void
      {
         _stopsPropagation = _stopsImmediatePropagation = true;
      }
      
      public function toString() : String
      {
         return "[" + getQualifiedClassName(this).split("::").pop() + " type=\"" + _type + "\" bubbles=" + _bubbles + "]";
      }
      
      basegame_internal function setTarget(param1:Object) : void
      {
         _target = param1;
      }
      
      basegame_internal function setCurrentTarget(param1:Object) : void
      {
         _currentTarget = param1;
      }
      
      basegame_internal function setData(param1:Object) : void
      {
         _data = param1;
      }
      
      public function reset(param1:String, param2:Boolean = false, param3:Object = null) : BaseEvent
      {
         _type = param1;
         _bubbles = param2;
         _data = param3;
         _target = _currentTarget = null;
         _stopsPropagation = _stopsImmediatePropagation = false;
         return this;
      }
      
      public function get stopsPropagation() : Boolean
      {
         return _stopsPropagation;
      }
      
      public function get stopsImmediatePropagation() : Boolean
      {
         return _stopsImmediatePropagation;
      }
      
      public function get bubbles() : Boolean
      {
         return _bubbles;
      }
      
      public function get target() : Object
      {
         return _target;
      }
      
      public function get currentTarget() : Object
      {
         return _currentTarget;
      }
      
      public function get type() : String
      {
         return _type;
      }
      
      public function get data() : Object
      {
         return _data;
      }
   }
}

