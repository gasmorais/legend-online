package com.yy.game.encrypt
{
   import flash.utils.ByteArray;
   
   internal interface ICipher
   {
      
      function getBlockSize() : uint;
      
      function encrypt(param1:ByteArray) : void;
      
      function decrypt(param1:ByteArray) : void;
      
      function dispose() : void;
      
      function toString() : String;
   }
}

