package com.road.yishi.proto.giftparty
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class GiftPartyTeamInfoMsg extends Message implements IExternalizable
   {
      
      private var teamId$field:int;
      
      private var hasField$0:uint = 0;
      
      [ArrayElementType("com.road.yishi.proto.giftparty.TeamMemberInfoMsg")]
      public var memberInfo:Array = [];
      
      private var masterUserId$field:int;
      
      public function GiftPartyTeamInfoMsg()
      {
         super();
      }
      
      public function removeTeamId() : void
      {
         hasField$0 &= 4294967294;
         teamId$field = new int();
      }
      
      public function get hasTeamId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set teamId(param1:int) : void
      {
         hasField$0 |= 1;
         teamId$field = param1;
      }
      
      public function get teamId() : int
      {
         return teamId$field;
      }
      
      public function removeMasterUserId() : void
      {
         hasField$0 &= 4294967293;
         masterUserId$field = new int();
      }
      
      public function get hasMasterUserId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set masterUserId(param1:int) : void
      {
         hasField$0 |= 2;
         masterUserId$field = param1;
      }
      
      public function get masterUserId() : int
      {
         return masterUserId$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasTeamId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,teamId$field);
         }
         _loc2_ = 0;
         while(_loc2_ < memberInfo.length)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_MESSAGE(param1,memberInfo[_loc2_]);
            _loc2_++;
         }
         if(hasMasterUserId)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,masterUserId$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc4_:* = 0;
         var _loc6_:TeamMemberInfoMsg = null;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc4_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: GiftPartyTeamInfoMsg.teamId cannot be set twice.");
                  }
                  _loc3_++;
                  teamId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  _loc6_ = new TeamMemberInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc6_);
                  memberInfo.push(_loc6_);
                  break;
               case 2:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: GiftPartyTeamInfoMsg.masterUserId cannot be set twice.");
                  }
                  _loc5_++;
                  masterUserId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc4_ & 7);
            }
         }
      }
   }
}

