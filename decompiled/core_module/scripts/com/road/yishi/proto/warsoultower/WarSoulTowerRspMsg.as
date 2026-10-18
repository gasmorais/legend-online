package com.road.yishi.proto.warsoultower
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class WarSoulTowerRspMsg extends Message implements IExternalizable
   {
      
      private var currentLevel$field:int;
      
      private var hasField$0:uint = 0;
      
      private var highestLevel$field:int;
      
      private var challengeTimes$field:int;
      
      public function WarSoulTowerRspMsg()
      {
         super();
      }
      
      public function removeCurrentLevel() : void
      {
         hasField$0 &= 4294967294;
         currentLevel$field = new int();
      }
      
      public function get hasCurrentLevel() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set currentLevel(param1:int) : void
      {
         hasField$0 |= 1;
         currentLevel$field = param1;
      }
      
      public function get currentLevel() : int
      {
         return currentLevel$field;
      }
      
      public function removeHighestLevel() : void
      {
         hasField$0 &= 4294967293;
         highestLevel$field = new int();
      }
      
      public function get hasHighestLevel() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set highestLevel(param1:int) : void
      {
         hasField$0 |= 2;
         highestLevel$field = param1;
      }
      
      public function get highestLevel() : int
      {
         return highestLevel$field;
      }
      
      public function removeChallengeTimes() : void
      {
         hasField$0 &= 4294967291;
         challengeTimes$field = new int();
      }
      
      public function get hasChallengeTimes() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set challengeTimes(param1:int) : void
      {
         hasField$0 |= 4;
         challengeTimes$field = param1;
      }
      
      public function get challengeTimes() : int
      {
         return challengeTimes$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasCurrentLevel)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,currentLevel$field);
         }
         if(hasHighestLevel)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,highestLevel$field);
         }
         if(hasChallengeTimes)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,challengeTimes$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc4_:* = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc4_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: WarSoulTowerRspMsg.currentLevel cannot be set twice.");
                  }
                  _loc5_++;
                  currentLevel = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: WarSoulTowerRspMsg.highestLevel cannot be set twice.");
                  }
                  _loc6_++;
                  highestLevel = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: WarSoulTowerRspMsg.challengeTimes cannot be set twice.");
                  }
                  _loc3_++;
                  challengeTimes = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc4_ & 7);
            }
         }
      }
   }
}

