package com.yy.game.encrypt
{
   import flash.display.Sprite;
   import flash.net.URLVariables;
   
   public class Test extends Sprite
   {
      
      public function Test()
      {
         super();
         Encrypt.encrypt(new URLVariables(),"9h15eL49oOtpMuE9O7u4!@%$");
      }
      
      public function encode() : void
      {
      }
   }
}

