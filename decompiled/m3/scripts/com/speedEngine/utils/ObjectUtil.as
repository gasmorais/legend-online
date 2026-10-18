package com.speedEngine.utils
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.utils.ByteArray;
   import flash.utils.describeType;
   
   public class ObjectUtil
   {
      
      public function ObjectUtil()
      {
         super();
      }
      
      public static function dispose(param1:*) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(param1 is Array)
         {
            disposeElements(param1);
         }
         else if(param1.hasOwnProperty("length") && param1.hasOwnProperty("fixed"))
         {
            disposeElements(param1);
         }
         else
         {
            disposeObj(param1);
         }
         param1 = null;
      }
      
      private static function disposeObj(param1:*, param2:Boolean = false) : void
      {
      }
      
      public static function disposeElements(param1:*) : void
      {
         var _loc3_:int = 0;
         if(param1 == null)
         {
            return;
         }
         var _loc2_:int = int(param1.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            disposeObj(param1.pop());
            _loc3_++;
         }
      }
      
      public static function copyProperties(param1:*, param2:*) : void
      {
         var _loc6_:int = 0;
         var _loc3_:String = null;
         var _loc4_:XML = describeType(param2);
         var _loc5_:XMLList = _loc4_.variable;
         _loc6_ = 0;
         while(_loc6_ < _loc5_.length())
         {
            _loc3_ = String(_loc5_[_loc6_].@name);
            if(param1.hasOwnProperty(_loc3_))
            {
               param1[_loc3_] = param2[_loc3_];
            }
            _loc6_++;
         }
      }
      
      public static function copyPorpertiesByXML(param1:Object, param2:XML) : void
      {
         var _loc3_:String = null;
         var _loc5_:String = null;
         var _loc6_:XMLList = param2.attributes();
         for each(var _loc4_:XML in _loc6_)
         {
            _loc3_ = _loc4_.name().toString();
            if(param1.hasOwnProperty(_loc3_))
            {
               try
               {
                  _loc5_ = _loc4_.toString();
                  if(_loc5_ == "false")
                  {
                     param1[_loc3_] = false;
                  }
                  else
                  {
                     param1[_loc3_] = _loc5_;
                  }
               }
               catch(e:Error)
               {
                  trace("错误:",e.message);
                  continue;
               }
            }
         }
      }
      
      public static function disposeChildren(param1:Sprite, param2:Sprite = null) : void
      {
         var _loc5_:int = 0;
         var _loc4_:DisplayObject = null;
         var _loc3_:int = param1.numChildren;
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            if(!param1.numChildren)
            {
               return;
            }
            _loc4_ = param1.getChildAt(0);
            if(!(param2 && _loc4_ && _loc4_ == param2))
            {
               disposeObj(param1.getChildAt(0));
            }
            _loc5_++;
         }
      }
      
      public static function cloneObject(param1:Object) : Object
      {
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.writeObject(param1);
         _loc2_.position = 0;
         return _loc2_.readObject();
      }
      
      public static function isString(param1:*) : Boolean
      {
         return typeof param1 == "string" || param1 is String;
      }
      
      public static function isNumber(param1:*) : Boolean
      {
         return typeof param1 == "number" || param1 is Number;
      }
      
      public static function isBoolean(param1:*) : Boolean
      {
         return typeof param1 == "boolean" || param1 is Boolean;
      }
      
      public static function isFunction(param1:*) : Boolean
      {
         return typeof param1 == "function" || param1 is Function;
      }
      
      public static function getLength(param1:Object) : Number
      {
         var _loc2_:Number = 0;
         for(var _loc3_ in param1)
         {
            _loc2_++;
         }
         return _loc2_;
      }
   }
}

