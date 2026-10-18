package com.speedEngine.speedBones.events
{
   import avmplus.getQualifiedClassName;
   import com.speedEngine.speedBones.BaseClass;
   import com.speedEngine.speedBones.interfaces.IDispatch;
   import flash.utils.Dictionary;
   import flash.utils.getDefinitionByName;
   
   public class Event extends BaseClass
   {
      
      public static const RESIZE:String = "resize";
      
      public static const ADDED_TO_STAGE:String = "add_to_stage";
      
      public static const REMOVE_FROM_STAGE:String = "remove_from_stage";
      
      public static const CHANG:String = "change";
      
      public static const COMPLETE:String = "complete";
      
      public static const CONTEXT3D_CREATE:String = "context3DCreate";
      
      private static var _eventDic:Dictionary = new Dictionary();
      
      private var _type:String;
      
      private var _data:Object;
      
      private var _target:IDispatch;
      
      private var _currentTarget:IDispatch;
      
      public function Event()
      {
         super();
      }
      
      public static function reset(param1:Event, param2:String, param3:Object = null) : void
      {
         param1._type = param2;
         param1._data = param3;
         param1._target = null;
         param1._currentTarget = null;
      }
      
      public static function getEvent(param1:Class, param2:String, param3:Object = null, ... rest) : *
      {
         var _loc5_:Event = null;
         var _loc6_:Array = _eventDic[param1];
         if(_loc6_ && _loc6_.length > 0)
         {
            _loc5_ = _loc6_.shift();
         }
         else
         {
            _loc5_ = new param1();
         }
         (param1["reset"] as Function).apply(null,[_loc5_,param2,param3].concat(rest));
         return _loc5_;
      }
      
      public static function pushEvent(param1:Event) : void
      {
         var _loc2_:Array = _eventDic[getDefinitionByName(getQualifiedClassName(param1))];
         param1.initialize();
         if(_loc2_ == null)
         {
            _loc2_ = [param1];
            _eventDic[getDefinitionByName(getQualifiedClassName(param1))] = _loc2_;
         }
         else
         {
            _loc2_.push(param1);
         }
      }
      
      public function initialize() : void
      {
         _type = "";
         _data = null;
         _target = null;
         _currentTarget = null;
      }
      
      public function get type() : String
      {
         return _type;
      }
      
      public function get data() : Object
      {
         return _data;
      }
      
      public function get target() : IDispatch
      {
         return _target;
      }
      
      public function set target(param1:IDispatch) : void
      {
         _target = param1;
      }
      
      public function get currentTarget() : IDispatch
      {
         return _currentTarget;
      }
      
      public function set currentTarget(param1:IDispatch) : void
      {
         _currentTarget = param1;
      }
   }
}

