package com.road.yishi.proto.team
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class TeamInfoMsg extends Message implements IExternalizable
   {
      
      private var team_id$field:int;
      
      private var hasField$0:uint = 0;
      
      [ArrayElementType("int")]
      public var memberId:Array = [];
      
      private var captain_id$field:int;
      
      [ArrayElementType("com.road.yishi.proto.team.TeamPlayerInfoMsg")]
      public var memberDetail:Array = [];
      
      private var captain_serverName$field:String;
      
      public function TeamInfoMsg()
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
      
      public function removeCaptainId() : void
      {
         hasField$0 &= 4294967293;
         captain_id$field = new int();
      }
      
      public function get hasCaptainId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set captainId(param1:int) : void
      {
         hasField$0 |= 2;
         captain_id$field = param1;
      }
      
      public function get captainId() : int
      {
         return captain_id$field;
      }
      
      public function removeCaptainServerName() : void
      {
         captain_serverName$field = null;
      }
      
      public function get hasCaptainServerName() : Boolean
      {
         return captain_serverName$field != null;
      }
      
      public function set captainServerName(param1:String) : void
      {
         captain_serverName$field = param1;
      }
      
      public function get captainServerName() : String
      {
         return captain_serverName$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc3_:* = 0;
         var _loc2_:* = 0;
         if(hasTeamId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,team_id$field);
         }
         _loc3_ = 0;
         while(_loc3_ < memberId.length)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,memberId[_loc3_]);
            _loc3_++;
         }
         if(hasCaptainId)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,captain_id$field);
         }
         _loc2_ = 0;
         while(_loc2_ < memberDetail.length)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_MESSAGE(param1,memberDetail[_loc2_]);
            _loc2_++;
         }
         if(hasCaptainServerName)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_STRING(param1,captain_serverName$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc3_:TeamPlayerInfoMsg = null;
         var _loc6_:uint = 0;
         var _loc4_:uint = 0;
         var _loc7_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: TeamInfoMsg.teamId cannot be set twice.");
                  }
                  _loc6_++;
                  teamId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if((_loc5_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,memberId);
                  }
                  else
                  {
                     memberId.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: TeamInfoMsg.captainId cannot be set twice.");
                  }
                  _loc4_++;
                  captainId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  _loc3_ = new TeamPlayerInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc3_);
                  memberDetail.push(_loc3_);
                  break;
               case 4:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: TeamInfoMsg.captainServerName cannot be set twice.");
                  }
                  _loc7_++;
                  captainServerName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

