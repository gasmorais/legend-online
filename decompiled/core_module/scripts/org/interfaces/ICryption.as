package org.interfaces
{
   import flash.utils.ByteArray;
   
   public interface ICryption
   {
      
      function encry(param1:ByteArray) : ByteArray;
      
      function decry(param1:ByteArray) : ByteArray;
   }
}

