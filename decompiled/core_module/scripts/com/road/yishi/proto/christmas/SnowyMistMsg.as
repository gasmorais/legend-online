package com.road.yishi.proto.christmas
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class SnowyMistMsg extends Message implements IExternalizable
   {
      
      private var teamId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var teamLeaderUserId$field:int;
      
      private var teamPoint$field:int;
      
      [ArrayElementType("com.road.yishi.proto.christmas.SnowyMistMapMsg")]
      public var map:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.christmas.SnowyMistTeamPlayerMsg")]
      public var teamPlayers:Array = [];
      
      public function SnowyMistMsg()
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
      
      public function removeTeamLeaderUserId() : void
      {
         hasField$0 &= 4294967293;
         teamLeaderUserId$field = new int();
      }
      
      public function get hasTeamLeaderUserId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set teamLeaderUserId(param1:int) : void
      {
         hasField$0 |= 2;
         teamLeaderUserId$field = param1;
      }
      
      public function get teamLeaderUserId() : int
      {
         return teamLeaderUserId$field;
      }
      
      public function removeTeamPoint() : void
      {
         hasField$0 &= 4294967291;
         teamPoint$field = new int();
      }
      
      public function get hasTeamPoint() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set teamPoint(param1:int) : void
      {
         hasField$0 |= 4;
         teamPoint$field = param1;
      }
      
      public function get teamPoint() : int
      {
         return teamPoint$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         if(hasTeamId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,teamId$field);
         }
         if(hasTeamLeaderUserId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,teamLeaderUserId$field);
         }
         if(hasTeamPoint)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,teamPoint$field);
         }
         _loc2_ = 0;
         while(_loc2_ < map.length)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_MESSAGE(param1,map[_loc2_]);
            _loc2_++;
         }
         _loc3_ = 0;
         while(_loc3_ < teamPlayers.length)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_MESSAGE(param1,teamPlayers[_loc3_]);
            _loc3_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc3_:SnowyMistMapMsg = null;
         var _loc5_:SnowyMistTeamPlayerMsg = null;
         var _loc4_:uint = 0;
         var _loc6_:uint = 0;
         var _loc8_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc7_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: SnowyMistMsg.teamId cannot be set twice.");
                  }
                  _loc4_++;
                  teamId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: SnowyMistMsg.teamLeaderUserId cannot be set twice.");
                  }
                  _loc6_++;
                  teamLeaderUserId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: SnowyMistMsg.teamPoint cannot be set twice.");
                  }
                  _loc8_++;
                  teamPoint = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  _loc3_ = new SnowyMistMapMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc3_);
                  map.push(_loc3_);
                  break;
               case 4:
                  _loc5_ = new SnowyMistTeamPlayerMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc5_);
                  teamPlayers.push(_loc5_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
      }
   }
}

