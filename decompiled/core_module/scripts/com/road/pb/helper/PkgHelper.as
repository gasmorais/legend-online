package com.road.pb.helper
{
   import flash.utils.ByteArray;
   
   public class PkgHelper
   {
      
      public function PkgHelper()
      {
         super();
      }
      
      public static function readDate(param1:ByteArray) : Date
      {
         if(param1 == null)
         {
            return null;
         }
         param1.position = 0;
         return new Date(param1.readShort(),param1.readByte() - 1,param1.readByte(),param1.readByte(),param1.readByte(),param1.readByte());
      }
   }
}

