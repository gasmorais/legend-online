package com.road.yishi.proto.minigame
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class GemMoveInviteReqMsg extends Message implements IExternalizable
   {
      
      private var friendId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var inviteTimes$field:int;
      
      private var helpNums$field:int;
      
      public function GemMoveInviteReqMsg()
      {
         super();
      }
      
      public function removeFriendId() : void
      {
         hasField$0 &= 4294967294;
         friendId$field = new int();
      }
      
      public function get hasFriendId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set friendId(param1:int) : void
      {
         hasField$0 |= 1;
         friendId$field = param1;
      }
      
      public function get friendId() : int
      {
         return friendId$field;
      }
      
      public function removeInviteTimes() : void
      {
         hasField$0 &= 4294967293;
         inviteTimes$field = new int();
      }
      
      public function get hasInviteTimes() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set inviteTimes(param1:int) : void
      {
         hasField$0 |= 2;
         inviteTimes$field = param1;
      }
      
      public function get inviteTimes() : int
      {
         return inviteTimes$field;
      }
      
      public function removeHelpNums() : void
      {
         hasField$0 &= 4294967291;
         helpNums$field = new int();
      }
      
      public function get hasHelpNums() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set helpNums(param1:int) : void
      {
         hasField$0 |= 4;
         helpNums$field = param1;
      }
      
      public function get helpNums() : int
      {
         return helpNums$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasFriendId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,friendId$field);
         }
         if(hasInviteTimes)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,inviteTimes$field);
         }
         if(hasHelpNums)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,helpNums$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: GemMoveInviteReqMsg.friendId cannot be set twice.");
                  }
                  _loc3_++;
                  friendId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: GemMoveInviteReqMsg.inviteTimes cannot be set twice.");
                  }
                  _loc4_++;
                  inviteTimes = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: GemMoveInviteReqMsg.helpNums cannot be set twice.");
                  }
                  _loc6_++;
                  helpNums = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

