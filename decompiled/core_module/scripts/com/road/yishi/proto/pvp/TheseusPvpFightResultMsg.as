package com.road.yishi.proto.pvp
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class TheseusPvpFightResultMsg extends Message implements IExternalizable
   {
      
      private var isWin$field:Boolean;
      
      private var hasField$0:uint = 0;
      
      private var rank$field:int;
      
      private var integral$field:int;
      
      private var pvpId$field:int;
      
      private var lastRank$field:int;
      
      private var lastIntegral$field:int;
      
      private var lastPvpId$field:int;
      
      private var keepWin$field:int;
      
      private var keepWinIntegral$field:int;
      
      private var rewardInfo$field:String;
      
      public function TheseusPvpFightResultMsg()
      {
         super();
      }
      
      public function removeIsWin() : void
      {
         hasField$0 &= 4294967294;
         isWin$field = new Boolean();
      }
      
      public function get hasIsWin() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set isWin(param1:Boolean) : void
      {
         hasField$0 |= 1;
         isWin$field = param1;
      }
      
      public function get isWin() : Boolean
      {
         return isWin$field;
      }
      
      public function removeRank() : void
      {
         hasField$0 &= 4294967293;
         rank$field = new int();
      }
      
      public function get hasRank() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set rank(param1:int) : void
      {
         hasField$0 |= 2;
         rank$field = param1;
      }
      
      public function get rank() : int
      {
         return rank$field;
      }
      
      public function removeIntegral() : void
      {
         hasField$0 &= 4294967291;
         integral$field = new int();
      }
      
      public function get hasIntegral() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set integral(param1:int) : void
      {
         hasField$0 |= 4;
         integral$field = param1;
      }
      
      public function get integral() : int
      {
         return integral$field;
      }
      
      public function removePvpId() : void
      {
         hasField$0 &= 4294967287;
         pvpId$field = new int();
      }
      
      public function get hasPvpId() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set pvpId(param1:int) : void
      {
         hasField$0 |= 8;
         pvpId$field = param1;
      }
      
      public function get pvpId() : int
      {
         return pvpId$field;
      }
      
      public function removeLastRank() : void
      {
         hasField$0 &= 4294967279;
         lastRank$field = new int();
      }
      
      public function get hasLastRank() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set lastRank(param1:int) : void
      {
         hasField$0 |= 16;
         lastRank$field = param1;
      }
      
      public function get lastRank() : int
      {
         return lastRank$field;
      }
      
      public function removeLastIntegral() : void
      {
         hasField$0 &= 4294967263;
         lastIntegral$field = new int();
      }
      
      public function get hasLastIntegral() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set lastIntegral(param1:int) : void
      {
         hasField$0 |= 32;
         lastIntegral$field = param1;
      }
      
      public function get lastIntegral() : int
      {
         return lastIntegral$field;
      }
      
      public function removeLastPvpId() : void
      {
         hasField$0 &= 4294967231;
         lastPvpId$field = new int();
      }
      
      public function get hasLastPvpId() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set lastPvpId(param1:int) : void
      {
         hasField$0 |= 64;
         lastPvpId$field = param1;
      }
      
      public function get lastPvpId() : int
      {
         return lastPvpId$field;
      }
      
      public function removeKeepWin() : void
      {
         hasField$0 &= 4294967167;
         keepWin$field = new int();
      }
      
      public function get hasKeepWin() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set keepWin(param1:int) : void
      {
         hasField$0 |= 128;
         keepWin$field = param1;
      }
      
      public function get keepWin() : int
      {
         return keepWin$field;
      }
      
      public function removeKeepWinIntegral() : void
      {
         hasField$0 &= 4294967039;
         keepWinIntegral$field = new int();
      }
      
      public function get hasKeepWinIntegral() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set keepWinIntegral(param1:int) : void
      {
         hasField$0 |= 256;
         keepWinIntegral$field = param1;
      }
      
      public function get keepWinIntegral() : int
      {
         return keepWinIntegral$field;
      }
      
      public function removeRewardInfo() : void
      {
         rewardInfo$field = null;
      }
      
      public function get hasRewardInfo() : Boolean
      {
         return rewardInfo$field != null;
      }
      
      public function set rewardInfo(param1:String) : void
      {
         rewardInfo$field = param1;
      }
      
      public function get rewardInfo() : String
      {
         return rewardInfo$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasIsWin)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_BOOL(param1,isWin$field);
         }
         if(hasRank)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,rank$field);
         }
         if(hasIntegral)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,integral$field);
         }
         if(hasPvpId)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,pvpId$field);
         }
         if(hasLastRank)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,lastRank$field);
         }
         if(hasLastIntegral)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,lastIntegral$field);
         }
         if(hasLastPvpId)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,lastPvpId$field);
         }
         if(hasKeepWin)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,keepWin$field);
         }
         if(hasKeepWinIntegral)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,keepWinIntegral$field);
         }
         if(hasRewardInfo)
         {
            WriteUtils.writeTag(param1,2,10);
            WriteUtils.write$TYPE_STRING(param1,rewardInfo$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc13_:* = 0;
         var _loc11_:uint = 0;
         var _loc3_:uint = 0;
         var _loc12_:uint = 0;
         var _loc4_:uint = 0;
         var _loc6_:uint = 0;
         var _loc5_:uint = 0;
         var _loc8_:uint = 0;
         var _loc10_:uint = 0;
         var _loc9_:uint = 0;
         var _loc7_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc13_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: TheseusPvpFightResultMsg.isWin cannot be set twice.");
                  }
                  _loc11_++;
                  isWin = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: TheseusPvpFightResultMsg.rank cannot be set twice.");
                  }
                  _loc3_++;
                  rank = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: TheseusPvpFightResultMsg.integral cannot be set twice.");
                  }
                  _loc12_++;
                  integral = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: TheseusPvpFightResultMsg.pvpId cannot be set twice.");
                  }
                  _loc4_++;
                  pvpId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: TheseusPvpFightResultMsg.lastRank cannot be set twice.");
                  }
                  _loc6_++;
                  lastRank = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: TheseusPvpFightResultMsg.lastIntegral cannot be set twice.");
                  }
                  _loc5_++;
                  lastIntegral = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: TheseusPvpFightResultMsg.lastPvpId cannot be set twice.");
                  }
                  _loc8_++;
                  lastPvpId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: TheseusPvpFightResultMsg.keepWin cannot be set twice.");
                  }
                  _loc10_++;
                  keepWin = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: TheseusPvpFightResultMsg.keepWinIntegral cannot be set twice.");
                  }
                  _loc9_++;
                  keepWinIntegral = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: TheseusPvpFightResultMsg.rewardInfo cannot be set twice.");
                  }
                  _loc7_++;
                  rewardInfo = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc13_ & 7);
            }
         }
      }
   }
}

