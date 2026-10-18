package com.yy.game.encrypt
{
   import flash.utils.ByteArray;
   
   internal interface IPad
   {
      
      function pad(param1:ByteArray) : void;
      
      function unpad(param1:ByteArray) : void;
      
      function setBlockSize(param1:uint) : void;
   }
}

