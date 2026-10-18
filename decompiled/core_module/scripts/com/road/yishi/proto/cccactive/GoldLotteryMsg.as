package com.road.yishi.proto.cccactive
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class GoldLotteryMsg extends Message implements IExternalizable
   {
      
      private var userId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var needNum1$field:int;
      
      private var needNum2$field:int;
      
      private var isLucky$field:Boolean;
      
      private var uuid$field:String;
      
      public function GoldLotteryMsg()
      {
         super();
      }
      
      public function removeUserId() : void
      {
         hasField$0 &= 4294967294;
         userId$field = new int();
      }
      
      public function get hasUserId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set userId(param1:int) : void
      {
         hasField$0 |= 1;
         userId$field = param1;
      }
      
      public function get userId() : int
      {
         return userId$field;
      }
      
      public function removeNeedNum1() : void
      {
         hasField$0 &= 4294967293;
         needNum1$field = new int();
      }
      
      public function get hasNeedNum1() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set needNum1(param1:int) : void
      {
         hasField$0 |= 2;
         needNum1$field = param1;
      }
      
      public function get needNum1() : int
      {
         return needNum1$field;
      }
      
      public function removeNeedNum2() : void
      {
         hasField$0 &= 4294967291;
         needNum2$field = new int();
      }
      
      public function get hasNeedNum2() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set needNum2(param1:int) : void
      {
         hasField$0 |= 4;
         needNum2$field = param1;
      }
      
      public function get needNum2() : int
      {
         return needNum2$field;
      }
      
      public function removeIsLucky() : void
      {
         hasField$0 &= 4294967287;
         isLucky$field = new Boolean();
      }
      
      public function get hasIsLucky() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set isLucky(param1:Boolean) : void
      {
         hasField$0 |= 8;
         isLucky$field = param1;
      }
      
      public function get isLucky() : Boolean
      {
         return isLucky$field;
      }
      
      public function removeUuid() : void
      {
         uuid$field = null;
      }
      
      public function get hasUuid() : Boolean
      {
         return uuid$field != null;
      }
      
      public function set uuid(param1:String) : void
      {
         uuid$field = param1;
      }
      
      public function get uuid() : String
      {
         return uuid$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasUserId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,userId$field);
         }
         if(hasNeedNum1)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,needNum1$field);
         }
         if(hasNeedNum2)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,needNum2$field);
         }
         if(hasIsLucky)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_BOOL(param1,isLucky$field);
         }
         if(hasUuid)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_STRING(param1,uuid$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc8_:* = 0;
         var _loc7_:uint = 0;
         var _loc5_:uint = 0;
         var _loc4_:uint = 0;
         var _loc6_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc8_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: GoldLotteryMsg.userId cannot be set twice.");
                  }
                  _loc7_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: GoldLotteryMsg.needNum1 cannot be set twice.");
                  }
                  _loc5_++;
                  needNum1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: GoldLotteryMsg.needNum2 cannot be set twice.");
                  }
                  _loc4_++;
                  needNum2 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: GoldLotteryMsg.isLucky cannot be set twice.");
                  }
                  _loc6_++;
                  isLucky = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 4:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: GoldLotteryMsg.uuid cannot be set twice.");
                  }
                  _loc3_++;
                  uuid = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc8_ & 7);
            }
         }
      }
   }
}

