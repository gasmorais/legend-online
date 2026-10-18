package com.road.yishi.proto.apex
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ApexTeamClientOpRespMsg extends Message implements IExternalizable
   {
      
      private var optype$field:int;
      
      private var hasField$0:uint = 0;
      
      private var member$field:ApexTeamMemberMsg;
      
      private var team$field:ApexTeamMsg;
      
      [ArrayElementType("com.road.yishi.proto.apex.ApexTeamMsg")]
      public var teams:Array = [];
      
      public function ApexTeamClientOpRespMsg()
      {
         super();
      }
      
      public function removeOptype() : void
      {
         hasField$0 &= 4294967294;
         optype$field = new int();
      }
      
      public function get hasOptype() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set optype(param1:int) : void
      {
         hasField$0 |= 1;
         optype$field = param1;
      }
      
      public function get optype() : int
      {
         return optype$field;
      }
      
      public function removeMember() : void
      {
         member$field = null;
      }
      
      public function get hasMember() : Boolean
      {
         return member$field != null;
      }
      
      public function set member(param1:ApexTeamMemberMsg) : void
      {
         member$field = param1;
      }
      
      public function get member() : ApexTeamMemberMsg
      {
         return member$field;
      }
      
      public function removeTeam() : void
      {
         team$field = null;
      }
      
      public function get hasTeam() : Boolean
      {
         return team$field != null;
      }
      
      public function set team(param1:ApexTeamMsg) : void
      {
         team$field = param1;
      }
      
      public function get team() : ApexTeamMsg
      {
         return team$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasOptype)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,optype$field);
         }
         if(hasMember)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_MESSAGE(param1,member$field);
         }
         if(hasTeam)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_MESSAGE(param1,team$field);
         }
         _loc2_ = 0;
         while(_loc2_ < teams.length)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_MESSAGE(param1,teams[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc3_:ApexTeamMsg = null;
         var _loc4_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ApexTeamClientOpRespMsg.optype cannot be set twice.");
                  }
                  _loc4_++;
                  optype = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ApexTeamClientOpRespMsg.member cannot be set twice.");
                  }
                  _loc6_++;
                  member = new ApexTeamMemberMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,member);
                  break;
               case 2:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: ApexTeamClientOpRespMsg.team cannot be set twice.");
                  }
                  _loc7_++;
                  team = new ApexTeamMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,team);
                  break;
               case 3:
                  _loc3_ = new ApexTeamMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc3_);
                  teams.push(_loc3_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

