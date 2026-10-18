package com.road.yishi.proto.cccactive
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class LotteryRecordPB extends Message implements IExternalizable
   {
      
      private var time$field:String;
      
      private var hasField$0:uint = 0;
      
      private var active_name$field:String;
      
      private var item_id$field:int;
      
      private var item_count$field:int;
      
      private var server_id$field:String;
      
      private var nick_name$field:String;
      
      public function LotteryRecordPB()
      {
         super();
      }
      
      public function removeTime() : void
      {
         hasField$0 &= 4294967294;
         time$field = new String();
      }
      
      public function get hasTime() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set time(param1:String) : void
      {
         hasField$0 |= 1;
         time$field = param1;
      }
      
      public function get time() : String
      {
         return time$field;
      }
      
      public function removeActiveName() : void
      {
         hasField$0 &= 4294967293;
         active_name$field = new String();
      }
      
      public function get hasActiveName() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set activeName(param1:String) : void
      {
         hasField$0 |= 2;
         active_name$field = param1;
      }
      
      public function get activeName() : String
      {
         return active_name$field;
      }
      
      public function removeItemId() : void
      {
         hasField$0 &= 4294967291;
         item_id$field = new int();
      }
      
      public function get hasItemId() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set itemId(param1:int) : void
      {
         hasField$0 |= 4;
         item_id$field = param1;
      }
      
      public function get itemId() : int
      {
         return item_id$field;
      }
      
      public function removeItemCount() : void
      {
         hasField$0 &= 4294967287;
         item_count$field = new int();
      }
      
      public function get hasItemCount() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set itemCount(param1:int) : void
      {
         hasField$0 |= 8;
         item_count$field = param1;
      }
      
      public function get itemCount() : int
      {
         return item_count$field;
      }
      
      public function removeServerId() : void
      {
         hasField$0 &= 4294967279;
         server_id$field = new String();
      }
      
      public function get hasServerId() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set serverId(param1:String) : void
      {
         hasField$0 |= 16;
         server_id$field = param1;
      }
      
      public function get serverId() : String
      {
         return server_id$field;
      }
      
      public function removeNickName() : void
      {
         hasField$0 &= 4294967263;
         nick_name$field = new String();
      }
      
      public function get hasNickName() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set nickName(param1:String) : void
      {
         hasField$0 |= 32;
         nick_name$field = param1;
      }
      
      public function get nickName() : String
      {
         return nick_name$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasTime)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,time$field);
         }
         if(hasActiveName)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,active_name$field);
         }
         if(hasItemId)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,item_id$field);
         }
         if(hasItemCount)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,item_count$field);
         }
         if(hasServerId)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_STRING(param1,server_id$field);
         }
         if(hasNickName)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_STRING(param1,nick_name$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc8_:uint = 0;
         var _loc6_:uint = 0;
         var _loc4_:uint = 0;
         var _loc9_:uint = 0;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc7_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: LotteryRecordPB.time cannot be set twice.");
                  }
                  _loc8_++;
                  time = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 1:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: LotteryRecordPB.activeName cannot be set twice.");
                  }
                  _loc6_++;
                  activeName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: LotteryRecordPB.itemId cannot be set twice.");
                  }
                  _loc4_++;
                  itemId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: LotteryRecordPB.itemCount cannot be set twice.");
                  }
                  _loc9_++;
                  itemCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: LotteryRecordPB.serverId cannot be set twice.");
                  }
                  _loc3_++;
                  serverId = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 5:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: LotteryRecordPB.nickName cannot be set twice.");
                  }
                  _loc5_++;
                  nickName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
      }
   }
}

