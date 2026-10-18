package com.road.yishi.proto.cccactive
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class LuckyRewardMsg extends Message implements IExternalizable
   {
      
      private var uuid$field:String;
      
      private var eggId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var timeOutDate$field:String;
      
      private var takeState$field:int;
      
      public function LuckyRewardMsg()
      {
         super();
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
      
      public function removeEggId() : void
      {
         hasField$0 &= 4294967294;
         eggId$field = new int();
      }
      
      public function get hasEggId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set eggId(param1:int) : void
      {
         hasField$0 |= 1;
         eggId$field = param1;
      }
      
      public function get eggId() : int
      {
         return eggId$field;
      }
      
      public function removeTimeOutDate() : void
      {
         timeOutDate$field = null;
      }
      
      public function get hasTimeOutDate() : Boolean
      {
         return timeOutDate$field != null;
      }
      
      public function set timeOutDate(param1:String) : void
      {
         timeOutDate$field = param1;
      }
      
      public function get timeOutDate() : String
      {
         return timeOutDate$field;
      }
      
      public function removeTakeState() : void
      {
         hasField$0 &= 4294967293;
         takeState$field = new int();
      }
      
      public function get hasTakeState() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set takeState(param1:int) : void
      {
         hasField$0 |= 2;
         takeState$field = param1;
      }
      
      public function get takeState() : int
      {
         return takeState$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasUuid)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,uuid$field);
         }
         if(hasEggId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,eggId$field);
         }
         if(hasTimeOutDate)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,timeOutDate$field);
         }
         if(hasTakeState)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,takeState$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc7_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: LuckyRewardMsg.uuid cannot be set twice.");
                  }
                  _loc3_++;
                  uuid = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: LuckyRewardMsg.eggId cannot be set twice.");
                  }
                  _loc4_++;
                  eggId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: LuckyRewardMsg.timeOutDate cannot be set twice.");
                  }
                  _loc5_++;
                  timeOutDate = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: LuckyRewardMsg.takeState cannot be set twice.");
                  }
                  _loc6_++;
                  takeState = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
      }
   }
}

