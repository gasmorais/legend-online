package com.road.yishi.proto.cccactive
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class LuckyLotteryRecordMsg extends Message implements IExternalizable
   {
      
      private var costItemId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var onceCostItemNum$field:int;
      
      private var needTimes$field:int;
      
      private var begintime$field:String;
      
      private var endtime$field:String;
      
      [ArrayElementType("com.road.yishi.proto.cccactive.ItemInfoMsg")]
      public var itemInfos:Array = [];
      
      private var refreshTimes$field:int;
      
      private var refreshedTimes$field:int;
      
      public function LuckyLotteryRecordMsg()
      {
         super();
      }
      
      public function removeCostItemId() : void
      {
         hasField$0 &= 4294967294;
         costItemId$field = new int();
      }
      
      public function get hasCostItemId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set costItemId(param1:int) : void
      {
         hasField$0 |= 1;
         costItemId$field = param1;
      }
      
      public function get costItemId() : int
      {
         return costItemId$field;
      }
      
      public function removeOnceCostItemNum() : void
      {
         hasField$0 &= 4294967293;
         onceCostItemNum$field = new int();
      }
      
      public function get hasOnceCostItemNum() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set onceCostItemNum(param1:int) : void
      {
         hasField$0 |= 2;
         onceCostItemNum$field = param1;
      }
      
      public function get onceCostItemNum() : int
      {
         return onceCostItemNum$field;
      }
      
      public function removeNeedTimes() : void
      {
         hasField$0 &= 4294967291;
         needTimes$field = new int();
      }
      
      public function get hasNeedTimes() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set needTimes(param1:int) : void
      {
         hasField$0 |= 4;
         needTimes$field = param1;
      }
      
      public function get needTimes() : int
      {
         return needTimes$field;
      }
      
      public function removeBegintime() : void
      {
         begintime$field = null;
      }
      
      public function get hasBegintime() : Boolean
      {
         return begintime$field != null;
      }
      
      public function set begintime(param1:String) : void
      {
         begintime$field = param1;
      }
      
      public function get begintime() : String
      {
         return begintime$field;
      }
      
      public function removeEndtime() : void
      {
         endtime$field = null;
      }
      
      public function get hasEndtime() : Boolean
      {
         return endtime$field != null;
      }
      
      public function set endtime(param1:String) : void
      {
         endtime$field = param1;
      }
      
      public function get endtime() : String
      {
         return endtime$field;
      }
      
      public function removeRefreshTimes() : void
      {
         hasField$0 &= 4294967287;
         refreshTimes$field = new int();
      }
      
      public function get hasRefreshTimes() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set refreshTimes(param1:int) : void
      {
         hasField$0 |= 8;
         refreshTimes$field = param1;
      }
      
      public function get refreshTimes() : int
      {
         return refreshTimes$field;
      }
      
      public function removeRefreshedTimes() : void
      {
         hasField$0 &= 4294967279;
         refreshedTimes$field = new int();
      }
      
      public function get hasRefreshedTimes() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set refreshedTimes(param1:int) : void
      {
         hasField$0 |= 16;
         refreshedTimes$field = param1;
      }
      
      public function get refreshedTimes() : int
      {
         return refreshedTimes$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasCostItemId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,costItemId$field);
         }
         if(hasOnceCostItemNum)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,onceCostItemNum$field);
         }
         if(hasNeedTimes)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,needTimes$field);
         }
         if(hasBegintime)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,begintime$field);
         }
         if(hasEndtime)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_STRING(param1,endtime$field);
         }
         _loc2_ = 0;
         while(_loc2_ < itemInfos.length)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_MESSAGE(param1,itemInfos[_loc2_]);
            _loc2_++;
         }
         if(hasRefreshTimes)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,refreshTimes$field);
         }
         if(hasRefreshedTimes)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,refreshedTimes$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc8_:* = 0;
         var _loc3_:ItemInfoMsg = null;
         var _loc6_:uint = 0;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc9_:uint = 0;
         var _loc4_:uint = 0;
         var _loc7_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc8_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: LuckyLotteryRecordMsg.costItemId cannot be set twice.");
                  }
                  _loc6_++;
                  costItemId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: LuckyLotteryRecordMsg.onceCostItemNum cannot be set twice.");
                  }
                  _loc10_++;
                  onceCostItemNum = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: LuckyLotteryRecordMsg.needTimes cannot be set twice.");
                  }
                  _loc11_++;
                  needTimes = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: LuckyLotteryRecordMsg.begintime cannot be set twice.");
                  }
                  _loc9_++;
                  begintime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: LuckyLotteryRecordMsg.endtime cannot be set twice.");
                  }
                  _loc4_++;
                  endtime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 5:
                  _loc3_ = new ItemInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc3_);
                  itemInfos.push(_loc3_);
                  break;
               case 6:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: LuckyLotteryRecordMsg.refreshTimes cannot be set twice.");
                  }
                  _loc7_++;
                  refreshTimes = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: LuckyLotteryRecordMsg.refreshedTimes cannot be set twice.");
                  }
                  _loc5_++;
                  refreshedTimes = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc8_ & 7);
            }
         }
      }
   }
}

