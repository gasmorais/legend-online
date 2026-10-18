package com.road.yishi.proto.team
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class InviteTeamMsg extends Message implements IExternalizable
   {
      
      private var team_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var inviter_id$field:int;
      
      private var inviter_name$field:String;
      
      private var inviter_serverName$field:String;
      
      public function InviteTeamMsg()
      {
         super();
      }
      
      public function removeTeamId() : void
      {
         hasField$0 &= 4294967294;
         team_id$field = new int();
      }
      
      public function get hasTeamId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set teamId(param1:int) : void
      {
         hasField$0 |= 1;
         team_id$field = param1;
      }
      
      public function get teamId() : int
      {
         return team_id$field;
      }
      
      public function removeInviterId() : void
      {
         hasField$0 &= 4294967293;
         inviter_id$field = new int();
      }
      
      public function get hasInviterId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set inviterId(param1:int) : void
      {
         hasField$0 |= 2;
         inviter_id$field = param1;
      }
      
      public function get inviterId() : int
      {
         return inviter_id$field;
      }
      
      public function removeInviterName() : void
      {
         inviter_name$field = null;
      }
      
      public function get hasInviterName() : Boolean
      {
         return inviter_name$field != null;
      }
      
      public function set inviterName(param1:String) : void
      {
         inviter_name$field = param1;
      }
      
      public function get inviterName() : String
      {
         return inviter_name$field;
      }
      
      public function removeInviterServerName() : void
      {
         inviter_serverName$field = null;
      }
      
      public function get hasInviterServerName() : Boolean
      {
         return inviter_serverName$field != null;
      }
      
      public function set inviterServerName(param1:String) : void
      {
         inviter_serverName$field = param1;
      }
      
      public function get inviterServerName() : String
      {
         return inviter_serverName$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasTeamId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,team_id$field);
         }
         if(hasInviterId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,inviter_id$field);
         }
         if(hasInviterName)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,inviter_name$field);
         }
         if(hasInviterServerName)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,inviter_serverName$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc7_:uint = 0;
         var _loc4_:uint = 0;
         var _loc6_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: InviteTeamMsg.teamId cannot be set twice.");
                  }
                  _loc7_++;
                  teamId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: InviteTeamMsg.inviterId cannot be set twice.");
                  }
                  _loc4_++;
                  inviterId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: InviteTeamMsg.inviterName cannot be set twice.");
                  }
                  _loc6_++;
                  inviterName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: InviteTeamMsg.inviterServerName cannot be set twice.");
                  }
                  _loc3_++;
                  inviterServerName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

