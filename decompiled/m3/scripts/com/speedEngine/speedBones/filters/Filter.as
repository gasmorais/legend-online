package com.speedEngine.speedBones.filters
{
   import com.speedEngine.speedBones.BaseClass;
   import flash.utils.ByteArray;
   
   public class Filter extends BaseClass
   {
      
      protected var _filterBytes:ByteArray = null;
      
      public function Filter()
      {
         super();
         _filterBytes = new ByteArray();
         _filterBytes.endian = "littleEndian";
      }
      
      public function get filterBytes() : ByteArray
      {
         return _filterBytes;
      }
      
      public function dispose() : void
      {
         _filterBytes.clear();
         _filterBytes.length = 0;
      }
   }
}

