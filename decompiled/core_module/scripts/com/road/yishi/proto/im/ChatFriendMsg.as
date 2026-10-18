package com.road.yishi.proto.im
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ChatFriendMsg extends Message implements IExternalizable
   {
      
      private var from_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var from_nick$field:String;
      
      private var to_id$field:int;
      
      private var encode_msg$field:String;
      
      private var send_date$field:String;
      
      private var result$field:int;
      
      public function ChatFriendMsg()
      {
         super();
      }
      
      public function removeFromId() : void
      {
         hasField$0 &= 4294967294;
         from_id$field = new int();
      }
      
      public function get hasFromId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set fromId(param1:int) : void
      {
         hasField$0 |= 1;
         from_id$field = param1;
      }
      
      public function get fromId() : int
      {
         return from_id$field;
      }
      
      public function removeFromNick() : void
      {
         from_nick$field = null;
      }
      
      public function get hasFromNick() : Boolean
      {
         return from_nick$field != null;
      }
      
      public function set fromNick(param1:String) : void
      {
         from_nick$field = param1;
      }
      
      public function get fromNick() : String
      {
         return from_nick$field;
      }
      
      public function removeToId() : void
      {
         hasField$0 &= 4294967293;
         to_id$field = new int();
      }
      
      public function get hasToId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set toId(param1:int) : void
      {
         hasField$0 |= 2;
         to_id$field = param1;
      }
      
      public function get toId() : int
      {
         return to_id$field;
      }
      
      public function removeEncodeMsg() : void
      {
         encode_msg$field = null;
      }
      
      public function get hasEncodeMsg() : Boolean
      {
         return encode_msg$field != null;
      }
      
      public function set encodeMsg(param1:String) : void
      {
         encode_msg$field = param1;
      }
      
      public function get encodeMsg() : String
      {
         return encode_msg$field;
      }
      
      public function removeSendDate() : void
      {
         send_date$field = null;
      }
      
      public function get hasSendDate() : Boolean
      {
         return send_date$field != null;
      }
      
      public function set sendDate(param1:String) : void
      {
         send_date$field = param1;
      }
      
      public function get sendDate() : String
      {
         return send_date$field;
      }
      
      public function removeResult() : void
      {
         hasField$0 &= 4294967291;
         result$field = new int();
      }
      
      public function get hasResult() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set result(param1:int) : void
      {
         hasField$0 |= 4;
         result$field = param1;
      }
      
      public function get result() : int
      {
         return result$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasFromId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,from_id$field);
         }
         if(hasFromNick)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,from_nick$field);
         }
         if(hasToId)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,to_id$field);
         }
         if(hasEncodeMsg)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,encode_msg$field);
         }
         if(hasSendDate)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_STRING(param1,send_date$field);
         }
         if(hasResult)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,result$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc8_:* = 0;
         var _loc9_:uint = 0;
         var _loc5_:uint = 0;
         var _loc4_:uint = 0;
         var _loc6_:uint = 0;
         var _loc3_:uint = 0;
         var _loc7_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc8_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: ChatFriendMsg.fromId cannot be set twice.");
                  }
                  _loc9_++;
                  fromId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ChatFriendMsg.fromNick cannot be set twice.");
                  }
                  _loc5_++;
                  fromNick = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ChatFriendMsg.toId cannot be set twice.");
                  }
                  _loc4_++;
                  toId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ChatFriendMsg.encodeMsg cannot be set twice.");
                  }
                  _loc6_++;
                  encodeMsg = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ChatFriendMsg.sendDate cannot be set twice.");
                  }
                  _loc3_++;
                  sendDate = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 5:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: ChatFriendMsg.result cannot be set twice.");
                  }
                  _loc7_++;
                  result = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc8_ & 7);
            }
         }
      }
   }
}

