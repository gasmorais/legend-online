package com.speedEngine.utils.zip
{
   import flash.utils.*;
   
   public class ZipReader extends ZipFile
   {
      
      private var _names:Array = [];
      
      public function ZipReader(param1:ByteArray)
      {
         var _loc2_:int = 0;
         super(param1);
         while(_loc2_ < entries.length)
         {
            this._names.push(ZipEntry(entries[_loc2_]).name);
            _loc2_++;
         }
      }
      
      public function get names() : Array
      {
         return this._names;
      }
      
      public function getFile(param1:String) : ByteArray
      {
         return getInput(getEntry(param1));
      }
   }
}

