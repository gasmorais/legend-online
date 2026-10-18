package com.road.yishi.proto.chat
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ChatStateMsg extends Message implements IExternalizable
   {
      
      private var user_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var chat_state$field:int;
      
      private var result$field:int;
      
      private var replay_str$field:String;
      
      public function ChatStateMsg()
      {
         super();
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
      
      public function removeChatState() : void
      {
         hasField$0 &= 4294967293;
         chat_state$field = new int();
      }
      
      public function get hasChatState() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set chatState(param1:int) : void
      {
         hasField$0 |= 2;
         chat_state$field = param1;
      }
      
      public function get chatState() : int
      {
         return chat_state$field;
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
      
      public function removeReplayStr() : void
      {
         replay_str$field = null;
      }
      
      public function get hasReplayStr() : Boolean
      {
         return replay_str$field != null;
      }
      
      public function set replayStr(param1:String) : void
      {
         replay_str$field = param1;
      }
      
      public function get replayStr() : String
      {
         return replay_str$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasUserId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,user_id$field);
         }
         if(hasChatState)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,chat_state$field);
         }
         if(hasResult)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,result$field);
         }
         if(hasReplayStr)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,replay_str$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         var _loc6_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc7_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ChatStateMsg.userId cannot be set twice.");
                  }
                  _loc5_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ChatStateMsg.chatState cannot be set twice.");
                  }
                  _loc3_++;
                  chatState = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ChatStateMsg.result cannot be set twice.");
                  }
                  _loc6_++;
                  result = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ChatStateMsg.replayStr cannot be set twice.");
                  }
                  _loc4_++;
                  replayStr = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
      }
   }
}

