package com.road.yishi.proto.friend
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class FriendRelationMsg extends Message implements IExternalizable
   {
      
      private var other_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var nick_name$field:String;
      
      private var relation$field:int;
      
      private var notice_msg$field:String;
      
      private var result$field:Boolean;
      
      public function FriendRelationMsg()
      {
         super();
      }
      
      public function removeOtherId() : void
      {
         hasField$0 &= 4294967294;
         other_id$field = new int();
      }
      
      public function get hasOtherId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set otherId(param1:int) : void
      {
         hasField$0 |= 1;
         other_id$field = param1;
      }
      
      public function get otherId() : int
      {
         return other_id$field;
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
      
      public function removeRelation() : void
      {
         hasField$0 &= 4294967293;
         relation$field = new int();
      }
      
      public function get hasRelation() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set relation(param1:int) : void
      {
         hasField$0 |= 2;
         relation$field = param1;
      }
      
      public function get relation() : int
      {
         return relation$field;
      }
      
      public function removeNoticeMsg() : void
      {
         notice_msg$field = null;
      }
      
      public function get hasNoticeMsg() : Boolean
      {
         return notice_msg$field != null;
      }
      
      public function set noticeMsg(param1:String) : void
      {
         notice_msg$field = param1;
      }
      
      public function get noticeMsg() : String
      {
         return notice_msg$field;
      }
      
      public function removeResult() : void
      {
         hasField$0 &= 4294967291;
         result$field = new Boolean();
      }
      
      public function get hasResult() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set result(param1:Boolean) : void
      {
         hasField$0 |= 4;
         result$field = param1;
      }
      
      public function get result() : Boolean
      {
         return result$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasOtherId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,other_id$field);
         }
         if(hasNickName)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,nick_name$field);
         }
         if(hasRelation)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,relation$field);
         }
         if(hasNoticeMsg)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,notice_msg$field);
         }
         if(hasResult)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_BOOL(param1,result$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc8_:uint = 0;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         var _loc4_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc7_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: FriendRelationMsg.otherId cannot be set twice.");
                  }
                  _loc8_++;
                  otherId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: FriendRelationMsg.nickName cannot be set twice.");
                  }
                  _loc3_++;
                  nickName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: FriendRelationMsg.relation cannot be set twice.");
                  }
                  _loc5_++;
                  relation = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: FriendRelationMsg.noticeMsg cannot be set twice.");
                  }
                  _loc4_++;
                  noticeMsg = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 5:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: FriendRelationMsg.result cannot be set twice.");
                  }
                  _loc6_++;
                  result = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
      }
   }
}

