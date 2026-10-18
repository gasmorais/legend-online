package com.yy.game.encrypt
{
   import flash.utils.ByteArray;
   
   internal interface ISymmetricKey
   {
      
      function getBlockSize() : uint;
      
      function encrypt(param1:ByteArray, param2:uint = 0) : void;
      
      function decrypt(param1:ByteArray, param2:uint = 0) : void;
      
      function dispose() : void;
      
      function toString() : String;
   }
}

