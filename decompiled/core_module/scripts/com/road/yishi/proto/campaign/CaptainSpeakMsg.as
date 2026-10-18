package com.road.yishi.proto.campaign
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class CaptainSpeakMsg extends Message implements IExternalizable
   {
      
      private var cmapaign_name$field:String;
      
      private var room_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var is_lock$field:int;
      
      [ArrayElementType("String")]
      public var inviteContent:Array = [];
      
      private var type$field:int;
      
      public function CaptainSpeakMsg()
      {
         super();
      }
      
      public function removeCmapaignName() : void
      {
         cmapaign_name$field = null;
      }
      
      public function get hasCmapaignName() : Boolean
      {
         return cmapaign_name$field != null;
      }
      
      public function set cmapaignName(param1:String) : void
      {
         cmapaign_name$field = param1;
      }
      
      public function get cmapaignName() : String
      {
         return cmapaign_name$field;
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
      
      public function removeIsLock() : void
      {
         hasField$0 &= 4294967293;
         is_lock$field = new int();
      }
      
      public function get hasIsLock() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set isLock(param1:int) : void
      {
         hasField$0 |= 2;
         is_lock$field = param1;
      }
      
      public function get isLock() : int
      {
         return is_lock$field;
      }
      
      public function removeType() : void
      {
         hasField$0 &= 4294967291;
         type$field = new int();
      }
      
      public function get hasType() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set type(param1:int) : void
      {
         hasField$0 |= 4;
         type$field = param1;
      }
      
      public function get type() : int
      {
         return type$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasCmapaignName)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,cmapaign_name$field);
         }
         if(hasRoomId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,room_id$field);
         }
         if(hasIsLock)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,is_lock$field);
         }
         _loc2_ = 0;
         while(_loc2_ < inviteContent.length)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,inviteContent[_loc2_]);
            _loc2_++;
         }
         if(hasType)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,type$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc7_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: CaptainSpeakMsg.cmapaignName cannot be set twice.");
                  }
                  _loc3_++;
                  cmapaignName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: CaptainSpeakMsg.roomId cannot be set twice.");
                  }
                  _loc4_++;
                  roomId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: CaptainSpeakMsg.isLock cannot be set twice.");
                  }
                  _loc7_++;
                  isLock = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  inviteContent.push(ReadUtils.read$TYPE_STRING(param1));
                  break;
               case 4:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: CaptainSpeakMsg.type cannot be set twice.");
                  }
                  _loc5_++;
                  type = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

