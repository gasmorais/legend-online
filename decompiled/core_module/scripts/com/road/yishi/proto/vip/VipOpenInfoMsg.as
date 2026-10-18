package com.road.yishi.proto.vip
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class VipOpenInfoMsg extends Message implements IExternalizable
   {
      
      private var is_friend$field:Boolean;
      
      private var hasField$0:uint = 0;
      
      private var friend_id$field:int;
      
      private var friend_nick_name$field:String;
      
      private var days$field:int;
      
      public function VipOpenInfoMsg()
      {
         super();
      }
      
      public function removeIsFriend() : void
      {
         hasField$0 &= 4294967294;
         is_friend$field = new Boolean();
      }
      
      public function get hasIsFriend() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set isFriend(param1:Boolean) : void
      {
         hasField$0 |= 1;
         is_friend$field = param1;
      }
      
      public function get isFriend() : Boolean
      {
         return is_friend$field;
      }
      
      public function removeFriendId() : void
      {
         hasField$0 &= 4294967293;
         friend_id$field = new int();
      }
      
      public function get hasFriendId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set friendId(param1:int) : void
      {
         hasField$0 |= 2;
         friend_id$field = param1;
      }
      
      public function get friendId() : int
      {
         return friend_id$field;
      }
      
      public function removeFriendNickName() : void
      {
         friend_nick_name$field = null;
      }
      
      public function get hasFriendNickName() : Boolean
      {
         return friend_nick_name$field != null;
      }
      
      public function set friendNickName(param1:String) : void
      {
         friend_nick_name$field = param1;
      }
      
      public function get friendNickName() : String
      {
         return friend_nick_name$field;
      }
      
      public function removeDays() : void
      {
         hasField$0 &= 4294967291;
         days$field = new int();
      }
      
      public function get hasDays() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set days(param1:int) : void
      {
         hasField$0 |= 4;
         days$field = param1;
      }
      
      public function get days() : int
      {
         return days$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasIsFriend)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_BOOL(param1,is_friend$field);
         }
         if(hasFriendId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,friend_id$field);
         }
         if(hasFriendNickName)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,friend_nick_name$field);
         }
         if(hasDays)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,days$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         var _loc7_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: VipOpenInfoMsg.isFriend cannot be set twice.");
                  }
                  _loc4_++;
                  isFriend = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: VipOpenInfoMsg.friendId cannot be set twice.");
                  }
                  _loc3_++;
                  friendId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: VipOpenInfoMsg.friendNickName cannot be set twice.");
                  }
                  _loc5_++;
                  friendNickName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: VipOpenInfoMsg.days cannot be set twice.");
                  }
                  _loc7_++;
                  days = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

