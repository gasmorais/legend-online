package com.road.yishi.proto.simple
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class FriendGroupMsg extends Message implements IExternalizable
   {
      
      private var group_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var group_name$field:String;
      
      private var result$field:int;
      
      public function FriendGroupMsg()
      {
         super();
      }
      
      public function removeGroupId() : void
      {
         hasField$0 &= 4294967294;
         group_id$field = new int();
      }
      
      public function get hasGroupId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set groupId(param1:int) : void
      {
         hasField$0 |= 1;
         group_id$field = param1;
      }
      
      public function get groupId() : int
      {
         return group_id$field;
      }
      
      public function removeGroupName() : void
      {
         group_name$field = null;
      }
      
      public function get hasGroupName() : Boolean
      {
         return group_name$field != null;
      }
      
      public function set groupName(param1:String) : void
      {
         group_name$field = param1;
      }
      
      public function get groupName() : String
      {
         return group_name$field;
      }
      
      public function removeResult() : void
      {
         hasField$0 &= 4294967293;
         result$field = new int();
      }
      
      public function get hasResult() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set result(param1:int) : void
      {
         hasField$0 |= 2;
         result$field = param1;
      }
      
      public function get result() : int
      {
         return result$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasGroupId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,group_id$field);
         }
         if(hasGroupName)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,group_name$field);
         }
         if(hasResult)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,result$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc6_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: FriendGroupMsg.groupId cannot be set twice.");
                  }
                  _loc6_++;
                  groupId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: FriendGroupMsg.groupName cannot be set twice.");
                  }
                  _loc3_++;
                  groupName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: FriendGroupMsg.result cannot be set twice.");
                  }
                  _loc4_++;
                  result = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

