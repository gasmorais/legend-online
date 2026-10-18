package com.speedEngine.speedBones
{
   import flash.utils.getTimer;
   
   public class BaseClass
   {
      
      private var _hashCode:String;
      
      public function BaseClass()
      {
         super();
         _hashCode = getDJBHash(getTimer() + "");
      }
      
      public function getDJBHash(param1:String) : String
      {
         var _loc4_:int = 0;
         var _loc3_:uint = 5381;
         var _loc2_:int = param1.length;
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = (_loc3_ << 5) + _loc3_ + _loc2_ + param1.charCodeAt(_loc4_);
            _loc4_++;
         }
         return "0x" + _loc3_.toString(16);
      }
      
      public function get hashCode() : String
      {
         return _hashCode;
      }
   }
}

