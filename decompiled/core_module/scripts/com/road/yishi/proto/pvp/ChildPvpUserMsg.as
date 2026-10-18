package com.road.yishi.proto.pvp
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ChildPvpUserMsg extends Message implements IExternalizable
   {
      
      private var op$field:int;
      
      private var hasField$0:uint = 0;
      
      private var integral$field:int;
      
      private var pvpId$field:int;
      
      private var rank$field:int;
      
      private var freeCount$field:int;
      
      private var addCount$field:int;
      
      private var buyCount$field:int;
      
      private var keepWin$field:int;
      
      private var fightInfo$field:String;
      
      private var redReward$field:Boolean;
      
      private var maxIntegral$field:int;
      
      private var maxPvpId$field:int;
      
      public function ChildPvpUserMsg()
      {
         super();
      }
      
      public function removeOp() : void
      {
         hasField$0 &= 4294967294;
         op$field = new int();
      }
      
      public function get hasOp() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set op(param1:int) : void
      {
         hasField$0 |= 1;
         op$field = param1;
      }
      
      public function get op() : int
      {
         return op$field;
      }
      
      public function removeIntegral() : void
      {
         hasField$0 &= 4294967293;
         integral$field = new int();
      }
      
      public function get hasIntegral() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set integral(param1:int) : void
      {
         hasField$0 |= 2;
         integral$field = param1;
      }
      
      public function get integral() : int
      {
         return integral$field;
      }
      
      public function removePvpId() : void
      {
         hasField$0 &= 4294967291;
         pvpId$field = new int();
      }
      
      public function get hasPvpId() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set pvpId(param1:int) : void
      {
         hasField$0 |= 4;
         pvpId$field = param1;
      }
      
      public function get pvpId() : int
      {
         return pvpId$field;
      }
      
      public function removeRank() : void
      {
         hasField$0 &= 4294967287;
         rank$field = new int();
      }
      
      public function get hasRank() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set rank(param1:int) : void
      {
         hasField$0 |= 8;
         rank$field = param1;
      }
      
      public function get rank() : int
      {
         return rank$field;
      }
      
      public function removeFreeCount() : void
      {
         hasField$0 &= 4294967279;
         freeCount$field = new int();
      }
      
      public function get hasFreeCount() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set freeCount(param1:int) : void
      {
         hasField$0 |= 16;
         freeCount$field = param1;
      }
      
      public function get freeCount() : int
      {
         return freeCount$field;
      }
      
      public function removeAddCount() : void
      {
         hasField$0 &= 4294967263;
         addCount$field = new int();
      }
      
      public function get hasAddCount() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set addCount(param1:int) : void
      {
         hasField$0 |= 32;
         addCount$field = param1;
      }
      
      public function get addCount() : int
      {
         return addCount$field;
      }
      
      public function removeBuyCount() : void
      {
         hasField$0 &= 4294967231;
         buyCount$field = new int();
      }
      
      public function get hasBuyCount() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set buyCount(param1:int) : void
      {
         hasField$0 |= 64;
         buyCount$field = param1;
      }
      
      public function get buyCount() : int
      {
         return buyCount$field;
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
      
      public function removeFightInfo() : void
      {
         fightInfo$field = null;
      }
      
      public function get hasFightInfo() : Boolean
      {
         return fightInfo$field != null;
      }
      
      public function set fightInfo(param1:String) : void
      {
         fightInfo$field = param1;
      }
      
      public function get fightInfo() : String
      {
         return fightInfo$field;
      }
      
      public function removeRedReward() : void
      {
         hasField$0 &= 4294967039;
         redReward$field = new Boolean();
      }
      
      public function get hasRedReward() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set redReward(param1:Boolean) : void
      {
         hasField$0 |= 256;
         redReward$field = param1;
      }
      
      public function get redReward() : Boolean
      {
         return redReward$field;
      }
      
      public function removeMaxIntegral() : void
      {
         hasField$0 &= 4294966783;
         maxIntegral$field = new int();
      }
      
      public function get hasMaxIntegral() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set maxIntegral(param1:int) : void
      {
         hasField$0 |= 512;
         maxIntegral$field = param1;
      }
      
      public function get maxIntegral() : int
      {
         return maxIntegral$field;
      }
      
      public function removeMaxPvpId() : void
      {
         hasField$0 &= 4294966271;
         maxPvpId$field = new int();
      }
      
      public function get hasMaxPvpId() : Boolean
      {
         return (hasField$0 & 0x0400) != 0;
      }
      
      public function set maxPvpId(param1:int) : void
      {
         hasField$0 |= 1024;
         maxPvpId$field = param1;
      }
      
      public function get maxPvpId() : int
      {
         return maxPvpId$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasOp)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,op$field);
         }
         if(hasIntegral)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,integral$field);
         }
         if(hasPvpId)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,pvpId$field);
         }
         if(hasRank)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,rank$field);
         }
         if(hasFreeCount)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,freeCount$field);
         }
         if(hasAddCount)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,addCount$field);
         }
         if(hasBuyCount)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,buyCount$field);
         }
         if(hasKeepWin)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,keepWin$field);
         }
         if(hasFightInfo)
         {
            WriteUtils.writeTag(param1,2,9);
            WriteUtils.write$TYPE_STRING(param1,fightInfo$field);
         }
         if(hasRedReward)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_BOOL(param1,redReward$field);
         }
         if(hasMaxIntegral)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,maxIntegral$field);
         }
         if(hasMaxPvpId)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_INT32(param1,maxPvpId$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc13_:* = 0;
         var _loc14_:uint = 0;
         var _loc11_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc8_:uint = 0;
         var _loc10_:uint = 0;
         var _loc9_:uint = 0;
         var _loc7_:uint = 0;
         var _loc6_:uint = 0;
         var _loc5_:uint = 0;
         var _loc15_:uint = 0;
         var _loc12_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc13_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: ChildPvpUserMsg.op cannot be set twice.");
                  }
                  _loc14_++;
                  op = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: ChildPvpUserMsg.integral cannot be set twice.");
                  }
                  _loc11_++;
                  integral = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ChildPvpUserMsg.pvpId cannot be set twice.");
                  }
                  _loc3_++;
                  pvpId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ChildPvpUserMsg.rank cannot be set twice.");
                  }
                  _loc4_++;
                  rank = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: ChildPvpUserMsg.freeCount cannot be set twice.");
                  }
                  _loc8_++;
                  freeCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: ChildPvpUserMsg.addCount cannot be set twice.");
                  }
                  _loc10_++;
                  addCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: ChildPvpUserMsg.buyCount cannot be set twice.");
                  }
                  _loc9_++;
                  buyCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: ChildPvpUserMsg.keepWin cannot be set twice.");
                  }
                  _loc7_++;
                  keepWin = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ChildPvpUserMsg.fightInfo cannot be set twice.");
                  }
                  _loc6_++;
                  fightInfo = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 9:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ChildPvpUserMsg.redReward cannot be set twice.");
                  }
                  _loc5_++;
                  redReward = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 10:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: ChildPvpUserMsg.maxIntegral cannot be set twice.");
                  }
                  _loc15_++;
                  maxIntegral = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 11:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: ChildPvpUserMsg.maxPvpId cannot be set twice.");
                  }
                  _loc12_++;
                  maxPvpId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc13_ & 7);
            }
         }
      }
   }
}

