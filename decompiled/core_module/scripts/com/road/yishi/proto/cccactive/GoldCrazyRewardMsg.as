package com.road.yishi.proto.cccactive
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class GoldCrazyRewardMsg extends Message implements IExternalizable
   {
      
      private var rewardType$field:int;
      
      private var hasField$0:uint = 0;
      
      private var rewardData$field:int;
      
      private var rewardPer$field:int;
      
      private var rewardSite$field:int;
      
      private var rewardPerMaxData$field:int;
      
      private var needNum1$field:int;
      
      private var needNum2$field:int;
      
      public function GoldCrazyRewardMsg()
      {
         super();
      }
      
      public function removeRewardType() : void
      {
         hasField$0 &= 4294967294;
         rewardType$field = new int();
      }
      
      public function get hasRewardType() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set rewardType(param1:int) : void
      {
         hasField$0 |= 1;
         rewardType$field = param1;
      }
      
      public function get rewardType() : int
      {
         return rewardType$field;
      }
      
      public function removeRewardData() : void
      {
         hasField$0 &= 4294967293;
         rewardData$field = new int();
      }
      
      public function get hasRewardData() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set rewardData(param1:int) : void
      {
         hasField$0 |= 2;
         rewardData$field = param1;
      }
      
      public function get rewardData() : int
      {
         return rewardData$field;
      }
      
      public function removeRewardPer() : void
      {
         hasField$0 &= 4294967291;
         rewardPer$field = new int();
      }
      
      public function get hasRewardPer() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set rewardPer(param1:int) : void
      {
         hasField$0 |= 4;
         rewardPer$field = param1;
      }
      
      public function get rewardPer() : int
      {
         return rewardPer$field;
      }
      
      public function removeRewardSite() : void
      {
         hasField$0 &= 4294967287;
         rewardSite$field = new int();
      }
      
      public function get hasRewardSite() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set rewardSite(param1:int) : void
      {
         hasField$0 |= 8;
         rewardSite$field = param1;
      }
      
      public function get rewardSite() : int
      {
         return rewardSite$field;
      }
      
      public function removeRewardPerMaxData() : void
      {
         hasField$0 &= 4294967279;
         rewardPerMaxData$field = new int();
      }
      
      public function get hasRewardPerMaxData() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set rewardPerMaxData(param1:int) : void
      {
         hasField$0 |= 16;
         rewardPerMaxData$field = param1;
      }
      
      public function get rewardPerMaxData() : int
      {
         return rewardPerMaxData$field;
      }
      
      public function removeNeedNum1() : void
      {
         hasField$0 &= 4294967263;
         needNum1$field = new int();
      }
      
      public function get hasNeedNum1() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set needNum1(param1:int) : void
      {
         hasField$0 |= 32;
         needNum1$field = param1;
      }
      
      public function get needNum1() : int
      {
         return needNum1$field;
      }
      
      public function removeNeedNum2() : void
      {
         hasField$0 &= 4294967231;
         needNum2$field = new int();
      }
      
      public function get hasNeedNum2() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set needNum2(param1:int) : void
      {
         hasField$0 |= 64;
         needNum2$field = param1;
      }
      
      public function get needNum2() : int
      {
         return needNum2$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasRewardType)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,rewardType$field);
         }
         if(hasRewardData)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,rewardData$field);
         }
         if(hasRewardPer)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,rewardPer$field);
         }
         if(hasRewardSite)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,rewardSite$field);
         }
         if(hasRewardPerMaxData)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,rewardPerMaxData$field);
         }
         if(hasNeedNum1)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,needNum1$field);
         }
         if(hasNeedNum2)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,needNum2$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc10_:* = 0;
         var _loc3_:uint = 0;
         var _loc6_:uint = 0;
         var _loc4_:uint = 0;
         var _loc9_:uint = 0;
         var _loc8_:uint = 0;
         var _loc7_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc10_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 2)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: GoldCrazyRewardMsg.rewardType cannot be set twice.");
                  }
                  _loc3_++;
                  rewardType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: GoldCrazyRewardMsg.rewardData cannot be set twice.");
                  }
                  _loc6_++;
                  rewardData = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: GoldCrazyRewardMsg.rewardPer cannot be set twice.");
                  }
                  _loc4_++;
                  rewardPer = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: GoldCrazyRewardMsg.rewardSite cannot be set twice.");
                  }
                  _loc9_++;
                  rewardSite = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: GoldCrazyRewardMsg.rewardPerMaxData cannot be set twice.");
                  }
                  _loc8_++;
                  rewardPerMaxData = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: GoldCrazyRewardMsg.needNum1 cannot be set twice.");
                  }
                  _loc7_++;
                  needNum1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: GoldCrazyRewardMsg.needNum2 cannot be set twice.");
                  }
                  _loc5_++;
                  needNum2 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc10_ & 7);
            }
         }
      }
   }
}

