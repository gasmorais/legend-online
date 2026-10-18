package com.road.yishi.proto.room
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class EditRoomRspMsg extends Message implements IExternalizable
   {
      
      private var room_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var start_campaign_id$field:int;
      
      private var master_id$field:int;
      
      private var count$field:int;
      
      private var capacity$field:int;
      
      private var pass_word$field:String;
      
      private var room_name$field:String;
      
      public function EditRoomRspMsg()
      {
         super();
      }
      
      public function removeRoomId() : void
      {
         hasField$0 &= 4294967294;
         room_id$field = new int();
      }
      
      public function get hasRoomId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set roomId(param1:int) : void
      {
         hasField$0 |= 1;
         room_id$field = param1;
      }
      
      public function get roomId() : int
      {
         return room_id$field;
      }
      
      public function removeStartCampaignId() : void
      {
         hasField$0 &= 4294967293;
         start_campaign_id$field = new int();
      }
      
      public function get hasStartCampaignId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set startCampaignId(param1:int) : void
      {
         hasField$0 |= 2;
         start_campaign_id$field = param1;
      }
      
      public function get startCampaignId() : int
      {
         return start_campaign_id$field;
      }
      
      public function removeMasterId() : void
      {
         hasField$0 &= 4294967291;
         master_id$field = new int();
      }
      
      public function get hasMasterId() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set masterId(param1:int) : void
      {
         hasField$0 |= 4;
         master_id$field = param1;
      }
      
      public function get masterId() : int
      {
         return master_id$field;
      }
      
      public function removeCount() : void
      {
         hasField$0 &= 4294967287;
         count$field = new int();
      }
      
      public function get hasCount() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set count(param1:int) : void
      {
         hasField$0 |= 8;
         count$field = param1;
      }
      
      public function get count() : int
      {
         return count$field;
      }
      
      public function removeCapacity() : void
      {
         hasField$0 &= 4294967279;
         capacity$field = new int();
      }
      
      public function get hasCapacity() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set capacity(param1:int) : void
      {
         hasField$0 |= 16;
         capacity$field = param1;
      }
      
      public function get capacity() : int
      {
         return capacity$field;
      }
      
      public function removePassWord() : void
      {
         pass_word$field = null;
      }
      
      public function get hasPassWord() : Boolean
      {
         return pass_word$field != null;
      }
      
      public function set passWord(param1:String) : void
      {
         pass_word$field = param1;
      }
      
      public function get passWord() : String
      {
         return pass_word$field;
      }
      
      public function removeRoomName() : void
      {
         room_name$field = null;
      }
      
      public function get hasRoomName() : Boolean
      {
         return room_name$field != null;
      }
      
      public function set roomName(param1:String) : void
      {
         room_name$field = param1;
      }
      
      public function get roomName() : String
      {
         return room_name$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasRoomId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,room_id$field);
         }
         if(hasStartCampaignId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,start_campaign_id$field);
         }
         if(hasMasterId)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,master_id$field);
         }
         if(hasCount)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,count$field);
         }
         if(hasCapacity)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,capacity$field);
         }
         if(hasPassWord)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_STRING(param1,pass_word$field);
         }
         if(hasRoomName)
         {
            WriteUtils.writeTag(param1,2,7);
            WriteUtils.write$TYPE_STRING(param1,room_name$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc10_:* = 0;
         var _loc7_:uint = 0;
         var _loc9_:uint = 0;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         var _loc6_:uint = 0;
         var _loc8_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc10_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: EditRoomRspMsg.roomId cannot be set twice.");
                  }
                  _loc7_++;
                  roomId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: EditRoomRspMsg.startCampaignId cannot be set twice.");
                  }
                  _loc9_++;
                  startCampaignId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: EditRoomRspMsg.masterId cannot be set twice.");
                  }
                  _loc5_++;
                  masterId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: EditRoomRspMsg.count cannot be set twice.");
                  }
                  _loc3_++;
                  count = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: EditRoomRspMsg.capacity cannot be set twice.");
                  }
                  _loc6_++;
                  capacity = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: EditRoomRspMsg.passWord cannot be set twice.");
                  }
                  _loc8_++;
                  passWord = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 6:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: EditRoomRspMsg.roomName cannot be set twice.");
                  }
                  _loc4_++;
                  roomName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc10_ & 7);
            }
         }
      }
   }
}

