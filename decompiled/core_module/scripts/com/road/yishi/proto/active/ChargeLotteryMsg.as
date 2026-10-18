package com.road.yishi.proto.active
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ChargeLotteryMsg extends Message implements IExternalizable
   {
      
      private var begin_tm$field:String;
      
      private var end_tm$field:String;
      
      private var lottery_count$field:int;
      
      private var hasField$0:uint = 0;
      
      private var once_need_point$field:int;
      
      private var defect_point$field:int;
      
      private var rewardItem$field:int;
      
      private var count$field:int;
      
      private var statu$field:int;
      
      private var isMail$field:Boolean;
      
      public function ChargeLotteryMsg()
      {
         super();
      }
      
      public function removeBeginTm() : void
      {
         begin_tm$field = null;
      }
      
      public function get hasBeginTm() : Boolean
      {
         return begin_tm$field != null;
      }
      
      public function set beginTm(param1:String) : void
      {
         begin_tm$field = param1;
      }
      
      public function get beginTm() : String
      {
         return begin_tm$field;
      }
      
      public function removeEndTm() : void
      {
         end_tm$field = null;
      }
      
      public function get hasEndTm() : Boolean
      {
         return end_tm$field != null;
      }
      
      public function set endTm(param1:String) : void
      {
         end_tm$field = param1;
      }
      
      public function get endTm() : String
      {
         return end_tm$field;
      }
      
      public function removeLotteryCount() : void
      {
         hasField$0 &= 4294967294;
         lottery_count$field = new int();
      }
      
      public function get hasLotteryCount() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set lotteryCount(param1:int) : void
      {
         hasField$0 |= 1;
         lottery_count$field = param1;
      }
      
      public function get lotteryCount() : int
      {
         return lottery_count$field;
      }
      
      public function removeOnceNeedPoint() : void
      {
         hasField$0 &= 4294967293;
         once_need_point$field = new int();
      }
      
      public function get hasOnceNeedPoint() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set onceNeedPoint(param1:int) : void
      {
         hasField$0 |= 2;
         once_need_point$field = param1;
      }
      
      public function get onceNeedPoint() : int
      {
         return once_need_point$field;
      }
      
      public function removeDefectPoint() : void
      {
         hasField$0 &= 4294967291;
         defect_point$field = new int();
      }
      
      public function get hasDefectPoint() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set defectPoint(param1:int) : void
      {
         hasField$0 |= 4;
         defect_point$field = param1;
      }
      
      public function get defectPoint() : int
      {
         return defect_point$field;
      }
      
      public function removeRewardItem() : void
      {
         hasField$0 &= 4294967287;
         rewardItem$field = new int();
      }
      
      public function get hasRewardItem() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set rewardItem(param1:int) : void
      {
         hasField$0 |= 8;
         rewardItem$field = param1;
      }
      
      public function get rewardItem() : int
      {
         return rewardItem$field;
      }
      
      public function removeCount() : void
      {
         hasField$0 &= 4294967279;
         count$field = new int();
      }
      
      public function get hasCount() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set count(param1:int) : void
      {
         hasField$0 |= 16;
         count$field = param1;
      }
      
      public function get count() : int
      {
         return count$field;
      }
      
      public function removeStatu() : void
      {
         hasField$0 &= 4294967263;
         statu$field = new int();
      }
      
      public function get hasStatu() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set statu(param1:int) : void
      {
         hasField$0 |= 32;
         statu$field = param1;
      }
      
      public function get statu() : int
      {
         return statu$field;
      }
      
      public function removeIsMail() : void
      {
         hasField$0 &= 4294967231;
         isMail$field = new Boolean();
      }
      
      public function get hasIsMail() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set isMail(param1:Boolean) : void
      {
         hasField$0 |= 64;
         isMail$field = param1;
      }
      
      public function get isMail() : Boolean
      {
         return isMail$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasBeginTm)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,begin_tm$field);
         }
         if(hasEndTm)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,end_tm$field);
         }
         if(hasLotteryCount)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,lottery_count$field);
         }
         if(hasOnceNeedPoint)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,once_need_point$field);
         }
         if(hasDefectPoint)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,defect_point$field);
         }
         if(hasRewardItem)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,rewardItem$field);
         }
         if(hasCount)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,count$field);
         }
         if(hasStatu)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,statu$field);
         }
         if(hasIsMail)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_BOOL(param1,isMail$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc9_:* = 0;
         var _loc4_:uint = 0;
         var _loc11_:uint = 0;
         var _loc8_:uint = 0;
         var _loc5_:uint = 0;
         var _loc12_:uint = 0;
         var _loc3_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc10_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc9_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ChargeLotteryMsg.beginTm cannot be set twice.");
                  }
                  _loc4_++;
                  beginTm = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 1:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: ChargeLotteryMsg.endTm cannot be set twice.");
                  }
                  _loc11_++;
                  endTm = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: ChargeLotteryMsg.lotteryCount cannot be set twice.");
                  }
                  _loc8_++;
                  lotteryCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ChargeLotteryMsg.onceNeedPoint cannot be set twice.");
                  }
                  _loc5_++;
                  onceNeedPoint = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: ChargeLotteryMsg.defectPoint cannot be set twice.");
                  }
                  _loc12_++;
                  defectPoint = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ChargeLotteryMsg.rewardItem cannot be set twice.");
                  }
                  _loc3_++;
                  rewardItem = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ChargeLotteryMsg.count cannot be set twice.");
                  }
                  _loc6_++;
                  count = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: ChargeLotteryMsg.statu cannot be set twice.");
                  }
                  _loc7_++;
                  statu = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: ChargeLotteryMsg.isMail cannot be set twice.");
                  }
                  _loc10_++;
                  isMail = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc9_ & 7);
            }
         }
      }
   }
}

