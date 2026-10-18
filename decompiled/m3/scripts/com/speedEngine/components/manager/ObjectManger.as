package com.speedEngine.components.manager
{
   import flash.sampler.getSize;
   
   public class ObjectManger
   {
      
      private static var _instance:ObjectManger;
      
      private var _objects:Object = {};
      
      private var _objectsMemory:Object = {};
      
      private var _isDebug:Boolean = false;
      
      public function ObjectManger(param1:SingletonHelp)
      {
         super();
      }
      
      public static function get instance() : ObjectManger
      {
         if(!_instance)
         {
            _instance = new ObjectManger(new SingletonHelp());
         }
         return _instance;
      }
      
      public function pushObject(param1:String, param2:Object) : void
      {
         if(!isDebug)
         {
            return;
         }
         if(_objects[param1] == null)
         {
            _objects[param1] = [];
         }
         if(_objectsMemory[param1] == null)
         {
            _objectsMemory[param1] = getSize(param2);
         }
         _objects[param1].push(param2);
      }
      
      public function removeObject(param1:String, param2:Object) : void
      {
         if(!isDebug)
         {
            return;
         }
         if(_objects[param1] == null)
         {
            return;
         }
         var _loc3_:int = (_objects[param1] as Array).indexOf(param2);
         if(_loc3_ > -1)
         {
            (_objects[param1] as Array).splice(_loc3_,1);
         }
      }
      
      public function get objects() : Object
      {
         return _objects;
      }
      
      public function get objectLen() : uint
      {
         var _loc1_:uint = 0;
         for each(var _loc2_:Array in _objects)
         {
            _loc1_ += _loc2_.length;
         }
         return _loc1_;
      }
      
      public function get objectMemory() : uint
      {
         var _loc3_:Array = null;
         var _loc1_:uint = 0;
         for(var _loc2_:String in _objects)
         {
            _loc3_ = _objects[_loc2_];
            _loc1_ += _loc3_.length * _objectsMemory[_loc2_];
         }
         return _loc1_;
      }
      
      public function get isDebug() : Boolean
      {
         return _isDebug;
      }
      
      public function set isDebug(param1:Boolean) : void
      {
         _isDebug = param1;
      }
      
      public function get objectsMemory() : Object
      {
         return _objectsMemory;
      }
   }
}

class SingletonHelp
{
   
   public function SingletonHelp()
   {
      super();
   }
}
