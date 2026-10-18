package com.speedEngine.speedBones.utils
{
   import flash.utils.ByteArray;
   
   public class VersionUtils
   {
      
      public static const SPEED_RIDE_1_0_1:String = "1.0.1";
      
      public static const SPEED_RIDE_EMBED_1_1_0:String = "1.1.0";
      
      public static const SPEED_HEAD_1_1_1:String = "1.1.1";
      
      public static const SPEED_HEAD_APPEND_1_1_2:String = "1.1.2";
      
      public function VersionUtils()
      {
         super();
      }
      
      public static function isReadChild(param1:String) : Boolean
      {
         switch(param1)
         {
            case "1.1.0":
            case "1.1.1":
            case "1.1.2":
               break;
            default:
               return false;
         }
         return true;
      }
      
      public static function getLeftMove(param1:String) : int
      {
         if(param1 == "1.1.2")
         {
            return 3;
         }
         return 2;
      }
      
      public static function isReadAppend(param1:String) : Boolean
      {
         if(param1 == "1.1.2")
         {
            return true;
         }
         return false;
      }
      
      public static function getReadHead(param1:ByteArray) : FileHead
      {
         var _loc3_:FileHead = null;
         var _loc2_:int = param1.readShort();
         if(_loc2_ == 29099)
         {
            _loc3_ = new FileHead();
            _loc3_.head = _loc2_;
            _loc3_.compressType = param1.readByte();
            _loc3_.version = param1.readByte();
            param1.position = 8;
            return _loc3_;
         }
         param1.position = 0;
         return _loc3_;
      }
   }
}

