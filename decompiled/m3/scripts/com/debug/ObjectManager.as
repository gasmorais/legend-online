package com.debug
{
   import flash.sampler.getSize;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   
   public class ObjectManager
   {
      
      private static var _instance:ObjectManager;
      
      private static const NAME:String = "name";
      
      private static const TIME:String = "time";
      
      private var _objects:Dictionary;
      
      private var _count:uint;
      
      public function ObjectManager(param1:HelpClass)
      {
         super();
         _objects = new Dictionary(true);
      }
      
      public static function get instance() : ObjectManager
      {
         if(_instance == null)
         {
            _instance = new ObjectManager(new HelpClass());
         }
         return _instance;
      }
      
      public function addObject(param1:Object, param2:Class = null, param3:uint = 0) : void
      {
         var _loc4_:String = null;
         var _loc5_:Object = null;
         if(_objects[param1])
         {
            return;
         }
         if(param2 == null)
         {
            _loc4_ = getQualifiedClassName(param1);
         }
         else
         {
            _loc4_ = getQualifiedClassName(param2);
         }
         _loc5_ = {};
         _loc5_["name"] = _loc4_;
         _loc5_["time"] = param3;
         _objects[param1] = _loc5_;
      }
      
      public function forEach(param1:Function) : void
      {
         for(var _loc2_:Object in _objects)
         {
            param1.call(null,Object,_objects[Object]["name"]);
         }
      }
      
      public function getObjectByName(param1:String) : Array
      {
         var _loc2_:String = null;
         var _loc4_:Array = [];
         for(var _loc3_:Object in _objects)
         {
            _loc2_ = _objects[_loc3_]["name"];
            if(param1 == _loc2_.split("&")[0])
            {
               _loc4_.push(_loc3_);
            }
         }
         return _loc4_;
      }
      
      public function getNames() : Object
      {
         var _loc2_:String = null;
         var _loc3_:Object = null;
         var _loc4_:Object = null;
         var _loc5_:Object = {};
         for(var _loc1_:Object in _objects)
         {
            _loc4_ = _objects[_loc1_];
            _loc2_ = _loc4_["name"];
            _loc3_ = _loc5_[_loc2_];
            if(_loc3_ != null)
            {
               _loc3_["count"] += 1;
               _loc3_["size"] += getSize(_loc1_);
            }
            else
            {
               _loc3_ = {
                  "count":1,
                  "size":getSize(_loc4_)
               };
               _loc5_[_loc2_] = _loc3_;
            }
         }
         return _loc5_;
      }
   }
}

class HelpClass
{
   
   public function HelpClass()
   {
      super();
   }
}
