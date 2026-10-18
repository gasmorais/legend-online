package com.yy.game.encrypt
{
   import flash.utils.ByteArray;
   
   internal class Crypto
   {
      
      public function Crypto()
      {
         super();
      }
      
      public static function getCipher(param1:ByteArray, param2:IPad = null) : ICipher
      {
         return new ECBMode(new TripleDESKey(param1),param2);
      }
   }
}

