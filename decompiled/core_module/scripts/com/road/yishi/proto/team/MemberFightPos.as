package com.road.yishi.proto.team
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class MemberFightPos extends Message implements IExternalizable
   {
      
      private var member_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var pos$field:int;
      
      private var serverName$field:String;
      
      public function MemberFightPos()
      {
         super();
      }
      
      public function removeMemberId() : void
      {
         hasField$0 &= 4294967294;
         member_id$field = new int();
      }
      
      public function get hasMemberId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set memberId(param1:int) : void
      {
         hasField$0 |= 1;
         member_id$field = param1;
      }
      
      public function get memberId() : int
      {
         return member_id$field;
      }
      
      public function removePos() : void
      {
         hasField$0 &= 4294967293;
         pos$field = new int();
      }
      
      public function get hasPos() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set pos(param1:int) : void
      {
         hasField$0 |= 2;
         pos$field = param1;
      }
      
      public function get pos() : int
      {
         return pos$field;
      }
      
      public function removeServerName() : void
      {
         serverName$field = null;
      }
      
      public function get hasServerName() : Boolean
      {
         return serverName$field != null;
      }
      
      public function set serverName(param1:String) : void
      {
         serverName$field = param1;
      }
      
      public function get serverName() : String
      {
         return serverName$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasMemberId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,member_id$field);
         }
         if(hasPos)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,pos$field);
         }
         if(hasServerName)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,serverName$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: MemberFightPos.memberId cannot be set twice.");
                  }
                  _loc4_++;
                  memberId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: MemberFightPos.pos cannot be set twice.");
                  }
                  _loc5_++;
                  pos = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: MemberFightPos.serverName cannot be set twice.");
                  }
                  _loc3_++;
                  serverName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

