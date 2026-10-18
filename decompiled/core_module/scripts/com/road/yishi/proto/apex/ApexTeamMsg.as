package com.road.yishi.proto.apex
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ApexTeamMsg extends Message implements IExternalizable
   {
      
      private var teamId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var captainId$field:int;
      
      [ArrayElementType("com.road.yishi.proto.apex.ApexTeamMemberMsg")]
      public var members:Array = [];
      
      public function ApexTeamMsg()
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
      
      public function removeCaptainId() : void
      {
         hasField$0 &= 4294967293;
         captainId$field = new int();
      }
      
      public function get hasCaptainId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set captainId(param1:int) : void
      {
         hasField$0 |= 2;
         captainId$field = param1;
      }
      
      public function get captainId() : int
      {
         return captainId$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasTeamId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,teamId$field);
         }
         if(hasCaptainId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,captainId$field);
         }
         _loc2_ = 0;
         while(_loc2_ < members.length)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_MESSAGE(param1,members[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc3_:ApexTeamMemberMsg = null;
         var _loc5_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ApexTeamMsg.teamId cannot be set twice.");
                  }
                  _loc5_++;
                  teamId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ApexTeamMsg.captainId cannot be set twice.");
                  }
                  _loc4_++;
                  captainId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  _loc3_ = new ApexTeamMemberMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc3_);
                  members.push(_loc3_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

