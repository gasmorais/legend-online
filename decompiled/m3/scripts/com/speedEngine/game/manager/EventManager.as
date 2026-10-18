package com.speedEngine.game.manager
{
   import com.speedEngine.game.Director;
   import com.speedEngine.game.base.basegame_internal;
   import com.speedEngine.game.error.ErrorManager;
   import com.speedEngine.game.event.BaseEvent;
   import com.speedEngine.game.event.EventTypeHelper;
   import flash.utils.Dictionary;
   
   use namespace basegame_internal;
   
   public class EventManager extends BaseManager
   {
      
      private static var _instance:EventManager;
      
      private var _containers:Dictionary;
      
      private var _sysEventOnces:Dictionary;
      
      private var _sysEvents:Dictionary;
      
      private var _removeSysEvent:Dictionary;
      
      public function EventManager(param1:EventTypeHelper)
      {
         super();
         if(param1 == null)
         {
            ErrorManager.instance.throwSingletonError();
         }
      }
      
      public static function get instance() : EventManager
      {
         if(_instance == null)
         {
            _instance = new EventManager(new EventTypeHelper());
         }
         return _instance;
      }
      
      override public function init() : void
      {
         super.init();
         _containers = new Dictionary(true);
         _sysEventOnces = new Dictionary(true);
         _sysEvents = new Dictionary(true);
         _removeSysEvent = new Dictionary();
      }
      
      override public function update() : void
      {
         super.update();
      }
      
      private function addEventListener(param1:Object, param2:String, param3:Function, param4:Boolean) : void
      {
         var callBack:Function;
         var events:Object;
         var target:Object = param1;
         var eventType:String = param2;
         var handle:Function = param3;
         var isOnce:Boolean = param4;
         if(target == null)
         {
            Director.instance.throwError("空对象不能添加系统事件！{invalid_utf8=239}{invalid_utf8=188}?");
            return;
         }
         if(target.hasOwnProperty("addEventListener"))
         {
            if(_sysEvents[eventType] == null)
            {
               _sysEvents[eventType] = new Dictionary();
            }
            if(_sysEvents[eventType][target] == null)
            {
               _sysEvents[eventType][target] = [];
            }
            if((_sysEvents[eventType][target] as Array).indexOf(handle) > -1)
            {
               return;
            }
            _sysEvents[eventType][target].push(handle);
            callBack = function(param1:Object):void
            {
               systemEventExecute(eventType,handle,param1);
            };
            if(isOnce)
            {
               target.addEventListener(eventType,callBack);
               events = _sysEventOnces[target];
               if(events == null)
               {
                  events = {};
                  events[eventType] = callBack;
                  _sysEventOnces[target] = {"events":events};
               }
               else
               {
                  events.events[eventType] = callBack;
                  _removeSysEvent[handle] = callBack;
               }
            }
            else
            {
               target.addEventListener(eventType,callBack);
               _removeSysEvent[handle] = callBack;
            }
            Director.instance.trace(5,target + " 添加{invalid_utf8=228}{invalid_utf8=184}?个系统事件：" + eventType);
         }
         else
         {
            Director.instance.throwError(target + "对象不能监听事件！！没有addEventListener方法");
         }
      }
      
      basegame_internal function addEvent(param1:Object, param2:String, param3:Function, param4:Boolean = false) : void
      {
         var _loc7_:* = null;
         var _loc8_:int = 0;
         if(EventTypeHelper.eventTypes[param2])
         {
            addEventListener(param1,param2,param3,param4);
            return;
         }
         Director.instance.trace(5,param1 + "添加{invalid_utf8=228}{invalid_utf8=184}?个自定义事件:" + param2);
         if(_containers[param2] == null)
         {
            _containers[param2] = new Dictionary();
         }
         if(_containers[param2][param1] == null)
         {
            _containers[param2][param1] = [];
         }
         var _loc6_:Array = _containers[param2][param1] as Array;
         var _loc5_:int = int(_loc6_.length);
         _loc8_ = 0;
         while(_loc8_ < _loc5_)
         {
            if(_loc6_[_loc8_]["handle"] == param3)
            {
               return;
            }
            _loc8_++;
         }
         _loc6_.push({
            "handle":param3,
            "isOnce":param4
         });
      }
      
      basegame_internal function addEventOnce(param1:Object, param2:String, param3:Function) : void
      {
         addEvent(param1,param2,param3,true);
      }
      
      basegame_internal function removeEvent(param1:Object, param2:String, param3:Function = null) : void
      {
         var _loc6_:int = 0;
         var _loc4_:Function = null;
         var _loc8_:Object = null;
         var _loc9_:int = 0;
         if(param1 == null)
         {
            return;
         }
         var _loc7_:Function = _removeSysEvent[param3];
         if(_loc7_ != null)
         {
            if(param3 == null && param1.hasOwnProperty("removeEventListeners"))
            {
               param1.removeEventListeners(param2);
            }
            else
            {
               if(param3 == null)
               {
                  Director.instance.trace(1,"EventManager","事件监听函数handle为null,无法删除事件监听");
                  return;
               }
               if(param1.hasEventListener(param2))
               {
                  Director.instance.trace(5,"EventManager",param1 + "删除{invalid_utf8=228}{invalid_utf8=184}?个系统事{invalid_utf8=228}{invalid_utf8=187}?:" + param2);
                  param1.removeEventListener(param2,_loc7_);
                  _removeSysEvent[param3] = null;
                  delete _removeSysEvent[param3];
               }
            }
            if(_sysEvents[param2] && _sysEvents[param2][param1])
            {
               _loc6_ = (_sysEvents[param2][param1] as Array).indexOf(param3);
               if(_loc6_ > -1)
               {
                  (_sysEvents[param2][param1] as Array).splice(_loc6_,1);
               }
            }
            return;
         }
         if(!_containers[param2])
         {
            Director.instance.trace(1,"EventManager","不存{invalid_utf8=229}{invalid_utf8=156}?" + param1 + "[" + param2 + "]的事件处{invalid_utf8=231}{invalid_utf8=144}?");
            return;
         }
         var _loc5_:Array = _containers[param2][param1] as Array;
         if(_loc5_ == null)
         {
            return;
         }
         _loc9_ = 0;
         while(_loc9_ < _loc5_.length)
         {
            _loc8_ = _loc5_[_loc9_];
            _loc4_ = _loc8_["handle"];
            if(_loc4_ == param3 || param3 == null)
            {
               _loc5_.splice(_loc9_,1);
               delete _loc8_["handle"];
               _loc8_ = null;
               if(_loc5_.length == 0)
               {
                  _containers[param2][param1] = null;
                  delete _containers[param2][param1];
               }
               Director.instance.trace(5,param1 + "自定义事件监{invalid_utf8=229}{invalid_utf8=144}?:" + param2);
            }
            else
            {
               _loc9_++;
            }
         }
      }
      
      basegame_internal function dispatchEventWith(param1:Object, param2:String, param3:Object) : void
      {
         var _loc6_:Array = null;
         var _loc9_:Object = null;
         var _loc12_:BaseEvent = null;
         var _loc4_:Function = null;
         var _loc8_:Object = null;
         var _loc5_:Boolean = false;
         var _loc10_:int = 0;
         var _loc11_:* = 0;
         if(_containers[param2] != null)
         {
            for(var _loc7_:Object in _containers[param2])
            {
               if(_loc7_ == param1)
               {
                  if(_containers[param2][_loc7_] != null)
                  {
                     _loc6_ = _containers[param2][_loc7_] as Array;
                     _loc12_ = BaseEvent.fromPool(param2,false,param3);
                     _loc12_.setTarget(param1);
                     _loc11_ = 0;
                     while(_loc11_ < _loc6_.length)
                     {
                        _loc10_ = int(_loc6_.length);
                        _loc9_ = _loc6_[_loc11_];
                        _loc4_ = _loc9_["handle"];
                        _loc8_ = _loc7_;
                        _loc5_ = Boolean(_loc9_["isOnce"]);
                        if(_loc8_ == param1)
                        {
                           _loc12_.setCurrentTarget(_loc8_);
                           execute(_loc4_,_loc12_);
                           Director.instance.trace(5,param1 + "执行自定义事件处理函{invalid_utf8=230}{invalid_utf8=149}?, type=" + param2);
                           if(_loc5_)
                           {
                              _loc6_.splice(_loc11_,1);
                              delete _loc9_["handle"];
                              _loc9_ = null;
                              if(_loc6_.length == 0)
                              {
                                 delete _containers[param2][_loc7_];
                                 _containers[param2][_loc7_] = null;
                              }
                           }
                           if(_loc10_ <= _loc6_.length)
                           {
                              _loc11_++;
                           }
                           if(_loc12_.stopsPropagation)
                           {
                              break;
                           }
                        }
                     }
                     BaseEvent.toPool(_loc12_);
                  }
               }
            }
         }
      }
      
      private function execute(param1:Function, param2:BaseEvent) : void
      {
         handleBefore(param1,param2);
         param1.call(null,param2);
         handleAfter(param1,param2);
      }
      
      private function systemEventExecute(param1:String, param2:Function, param3:Object) : void
      {
         var _loc4_:Function = null;
         var _loc5_:int = 0;
         var _loc6_:Object = _sysEventOnces[param3.target];
         if(_loc6_ != null)
         {
            _loc4_ = _loc6_.events[param1];
            if(_loc4_ != null)
            {
               param3.target.removeEventListener(param1,_loc4_);
               _loc6_.events[param1] = null;
               _loc5_ = 0;
               for each(var _loc7_ in _loc6_.events)
               {
                  if(_loc7_ != null)
                  {
                     _loc5_++;
                     break;
                  }
               }
               if(_loc5_ == 0)
               {
                  _sysEventOnces[param3.target] = null;
               }
            }
         }
         Director.instance.trace(5,param3.target + "执行系统事件处理函数,type=" + param1);
         handleBefore(param2,param3);
         param2(param3);
         handleAfter(param2,param3);
      }
      
      private function handleBefore(param1:Function, ... rest) : void
      {
         Director.instance.trace(5,"function ",param1,"has called late with args: ",rest);
      }
      
      private function handleAfter(param1:Function, ... rest) : void
      {
         Director.instance.trace(5,"function ",param1,"has been called with args: ",rest);
      }
   }
}

