package com.road.yishi.proto.hugehead
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class StackHeadUserMsg extends Message implements IExternalizable
   {
      
      private var user_uid$field:String;
      
      private var alive$field:Boolean;
      
      private var hasField$0:uint = 0;
      
      private var guild_uid$field:String;
      
      public function StackHeadUserMsg()
      {
         super();
      }
      
      public function removeUserUid() : void
      {
         user_uid$field = null;
      }
      
      public function get hasUserUid() : Boolean
      {
         return user_uid$field != null;
      }
      
      public function set userUid(param1:String) : void
      {
         user_uid$field = param1;
      }
      
      public function get userUid() : String
      {
         return user_uid$field;
      }
      
      public function removeAlive() : void
      {
         hasField$0 &= 4294967294;
         alive$field = new Boolean();
      }
      
      public function get hasAlive() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set alive(param1:Boolean) : void
      {
         hasField$0 |= 1;
         alive$field = param1;
      }
      
      public function get alive() : Boolean
      {
         return alive$field;
      }
      
      public function removeGuildUid() : void
      {
         guild_uid$field = null;
      }
      
      public function get hasGuildUid() : Boolean
      {
         return guild_uid$field != null;
      }
      
      public function set guildUid(param1:String) : void
      {
         guild_uid$field = param1;
      }
      
      public function get guildUid() : String
      {
         return guild_uid$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasUserUid)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,user_uid$field);
         }
         if(hasAlive)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_BOOL(param1,alive$field);
         }
         if(hasGuildUid)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,guild_uid$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: StackHeadUserMsg.userUid cannot be set twice.");
                  }
                  _loc4_++;
                  userUid = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: StackHeadUserMsg.alive cannot be set twice.");
                  }
                  _loc3_++;
                  alive = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 2:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: StackHeadUserMsg.guildUid cannot be set twice.");
                  }
                  _loc6_++;
                  guildUid = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

