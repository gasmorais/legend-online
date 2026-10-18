package com.pickgliss.utils
{
   import flash.utils.Dictionary;
   
   public class ArrayUtils
   {
      
      public function ArrayUtils()
      {
         super();
      }
      
      public static function each(param1:Array, param2:Function) : void
      {
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            param2(param1[_loc3_]);
            _loc3_++;
         }
      }
      
      public static function setSize(param1:Array, param2:int) : void
      {
         if(param2 < 0)
         {
            param2 = 0;
         }
         if(param2 == param1.length)
         {
            return;
         }
         if(param2 > param1.length)
         {
            param1[param2 - 1] = undefined;
         }
         else
         {
            param1.splice(param2);
         }
      }
      
      public static function removeFromArray(param1:Array, param2:Object) : int
      {
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            if(param1[_loc3_] == param2)
            {
               param1.splice(_loc3_,1);
               return _loc3_;
            }
            _loc3_++;
         }
         return -1;
      }
      
      public static function removeAllFromArray(param1:Array, param2:Object) : void
      {
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            if(param1[_loc3_] == param2)
            {
               param1.splice(_loc3_,1);
               _loc3_--;
            }
            _loc3_++;
         }
      }
      
      public static function removeAllBehindSomeIndex(param1:Array, param2:int) : void
      {
         var _loc4_:int = 0;
         if(param2 <= 0)
         {
            param1.splice(0,param1.length);
            return;
         }
         var _loc3_:int = int(param1.length);
         _loc4_ = param2 + 1;
         while(_loc4_ < _loc3_)
         {
            param1.pop();
            _loc4_++;
         }
      }
      
      public static function indexInArray(param1:Array, param2:Object) : int
      {
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            if(param1[_loc3_] == param2)
            {
               return _loc3_;
            }
            _loc3_++;
         }
         return -1;
      }
      
      public static function cloneArray(param1:Array) : Array
      {
         return param1.concat();
      }
      
      public static function dictionaryToArray(param1:Dictionary) : Array
      {
         var _loc2_:Array = [];
         for each(var _loc3_:Object in param1)
         {
            _loc2_.push(_loc3_);
         }
         return _loc2_;
      }
   }
}

