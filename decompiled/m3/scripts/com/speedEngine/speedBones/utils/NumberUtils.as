package com.speedEngine.speedBones.utils
{
   public class NumberUtils
   {
      
      public function NumberUtils()
      {
         super();
      }
      
      public static function getNextPowerOfTwo(param1:uint) : uint
      {
         param1--;
         param1 |= param1 >> 1;
         param1 |= param1 >> 2;
         param1 |= param1 >> 4;
         param1 |= param1 >> 8;
         param1 |= param1 >> 16;
         param1++;
         return param1;
      }
      
      public static function getARGB(param1:uint) : Array
      {
         var _loc5_:Number = 0;
         var _loc3_:Number = 0;
         var _loc2_:Number = 0;
         var _loc4_:Number = 0;
         _loc5_ = (param1 >> 24 & 0xFF) / 255;
         _loc3_ = (param1 >> 16 & 0xFF) / 255;
         _loc2_ = (param1 >> 8 & 0xFF) / 255;
         _loc4_ = (param1 >> 0 & 0xFF) / 255;
         return [_loc5_,_loc3_,_loc2_,_loc4_];
      }
   }
}

