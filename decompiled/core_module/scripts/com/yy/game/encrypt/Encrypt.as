package com.yy.game.encrypt
{
   import flash.net.URLVariables;
   import flash.utils.ByteArray;
   
   public class Encrypt
   {
      
      public function Encrypt()
      {
         super();
      }
      
      public static function encrypt(param1:URLVariables, param2:String) : String
      {
         var _loc3_:String = decodeURIComponent(param1.toString());
         test(param2);
         return base64(tripleDes(_loc3_,param2));
      }
      
      private static function test(param1:String) : void
      {
         var _loc3_:String = "pid=L1&game=SZJS&passport=bimoziyan5";
         var _loc2_:ByteArray = tripleDes(_loc3_,param1);
         var _loc4_:String = base64(_loc2_);
      }
      
      private static function tripleDes(param1:String, param2:String) : ByteArray
      {
         param1 = Hex.fromString(param1);
         param2 = Hex.fromString(param2);
         var _loc6_:ByteArray = Hex.toArray(param2);
         var _loc5_:ByteArray = Hex.toArray(param1);
         var _loc4_:IPad = new ZeroBytePadding();
         var _loc3_:ICipher = Crypto.getCipher(_loc6_,_loc4_);
         _loc4_.setBlockSize(_loc3_.getBlockSize());
         _loc3_.encrypt(_loc5_);
         return _loc5_;
      }
      
      private static function base64(param1:ByteArray) : String
      {
         return Base64.encodeByteArray(param1);
      }
   }
}

