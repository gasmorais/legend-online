package com.speedEngine.speedBones.utils
{
   public class FileHead
   {
      
      public static const HEAD_LENGTH:int = 8;
      
      public static const HEAD_FLAG:int = 29099;
      
      private var _head:int;
      
      private var _compressType:uint;
      
      private var _version:uint;
      
      public function FileHead()
      {
         super();
      }
      
      public function get head() : int
      {
         return _head;
      }
      
      public function set head(param1:int) : void
      {
         _head = param1;
      }
      
      public function get compressType() : uint
      {
         return _compressType;
      }
      
      public function set compressType(param1:uint) : void
      {
         _compressType = param1;
      }
      
      public function get version() : uint
      {
         return _version;
      }
      
      public function set version(param1:uint) : void
      {
         _version = param1;
      }
   }
}

