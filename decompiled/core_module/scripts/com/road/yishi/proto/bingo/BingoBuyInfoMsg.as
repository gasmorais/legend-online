package com.road.yishi.proto.bingo
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class BingoBuyInfoMsg extends Message implements IExternalizable
   {
      
      private var uuid$field:String;
      
      private var user_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var nick_name$field:String;
      
      private var server_name$field:String;
      
      private var event_date$field:String;
      
      [ArrayElementType("com.road.yishi.proto.bingo.BingoBuyDetailMsg")]
      public var detail:Array = [];
      
      public function BingoBuyInfoMsg()
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
      
      public function removeUserId() : void
      {
         hasField$0 &= 4294967294;
         user_id$field = new int();
      }
      
      public function get hasUserId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set userId(param1:int) : void
      {
         hasField$0 |= 1;
         user_id$field = param1;
      }
      
      public function get userId() : int
      {
         return user_id$field;
      }
      
      public function removeNickName() : void
      {
         nick_name$field = null;
      }
      
      public function get hasNickName() : Boolean
      {
         return nick_name$field != null;
      }
      
      public function set nickName(param1:String) : void
      {
         nick_name$field = param1;
      }
      
      public function get nickName() : String
      {
         return nick_name$field;
      }
      
      public function removeServerName() : void
      {
         server_name$field = null;
      }
      
      public function get hasServerName() : Boolean
      {
         return server_name$field != null;
      }
      
      public function set serverName(param1:String) : void
      {
         server_name$field = param1;
      }
      
      public function get serverName() : String
      {
         return server_name$field;
      }
      
      public function removeEventDate() : void
      {
         event_date$field = null;
      }
      
      public function get hasEventDate() : Boolean
      {
         return event_date$field != null;
      }
      
      public function set eventDate(param1:String) : void
      {
         event_date$field = param1;
      }
      
      public function get eventDate() : String
      {
         return event_date$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasUuid)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,uuid$field);
         }
         if(hasUserId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,user_id$field);
         }
         if(hasNickName)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,nick_name$field);
         }
         if(hasServerName)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,server_name$field);
         }
         if(hasEventDate)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_STRING(param1,event_date$field);
         }
         _loc2_ = 0;
         while(_loc2_ < detail.length)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_MESSAGE(param1,detail[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc9_:BingoBuyDetailMsg = null;
         var _loc3_:uint = 0;
         var _loc6_:uint = 0;
         var _loc4_:uint = 0;
         var _loc8_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc7_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: BingoBuyInfoMsg.uuid cannot be set twice.");
                  }
                  _loc3_++;
                  uuid = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 1:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: BingoBuyInfoMsg.userId cannot be set twice.");
                  }
                  _loc6_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: BingoBuyInfoMsg.nickName cannot be set twice.");
                  }
                  _loc4_++;
                  nickName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: BingoBuyInfoMsg.serverName cannot be set twice.");
                  }
                  _loc8_++;
                  serverName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: BingoBuyInfoMsg.eventDate cannot be set twice.");
                  }
                  _loc5_++;
                  eventDate = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 5:
                  _loc9_ = new BingoBuyDetailMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc9_);
                  detail.push(_loc9_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
      }
   }
}

