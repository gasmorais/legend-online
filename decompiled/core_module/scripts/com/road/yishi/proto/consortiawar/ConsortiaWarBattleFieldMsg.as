package com.road.yishi.proto.consortiawar
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ConsortiaWarBattleFieldMsg extends Message implements IExternalizable
   {
      
      private var teamId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var spirit$field:int;
      
      private var buyCount$field:int;
      
      private var myTeam$field:ConsortiaWarTeamMsg;
      
      private var rivalTeam$field:ConsortiaWarTeamMsg;
      
      private var bufferCount$field:int;
      
      public function ConsortiaWarBattleFieldMsg()
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
      
      public function removeSpirit() : void
      {
         hasField$0 &= 4294967293;
         spirit$field = new int();
      }
      
      public function get hasSpirit() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set spirit(param1:int) : void
      {
         hasField$0 |= 2;
         spirit$field = param1;
      }
      
      public function get spirit() : int
      {
         return spirit$field;
      }
      
      public function removeBuyCount() : void
      {
         hasField$0 &= 4294967291;
         buyCount$field = new int();
      }
      
      public function get hasBuyCount() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set buyCount(param1:int) : void
      {
         hasField$0 |= 4;
         buyCount$field = param1;
      }
      
      public function get buyCount() : int
      {
         return buyCount$field;
      }
      
      public function removeMyTeam() : void
      {
         myTeam$field = null;
      }
      
      public function get hasMyTeam() : Boolean
      {
         return myTeam$field != null;
      }
      
      public function set myTeam(param1:ConsortiaWarTeamMsg) : void
      {
         myTeam$field = param1;
      }
      
      public function get myTeam() : ConsortiaWarTeamMsg
      {
         return myTeam$field;
      }
      
      public function removeRivalTeam() : void
      {
         rivalTeam$field = null;
      }
      
      public function get hasRivalTeam() : Boolean
      {
         return rivalTeam$field != null;
      }
      
      public function set rivalTeam(param1:ConsortiaWarTeamMsg) : void
      {
         rivalTeam$field = param1;
      }
      
      public function get rivalTeam() : ConsortiaWarTeamMsg
      {
         return rivalTeam$field;
      }
      
      public function removeBufferCount() : void
      {
         hasField$0 &= 4294967287;
         bufferCount$field = new int();
      }
      
      public function get hasBufferCount() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set bufferCount(param1:int) : void
      {
         hasField$0 |= 8;
         bufferCount$field = param1;
      }
      
      public function get bufferCount() : int
      {
         return bufferCount$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasTeamId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,teamId$field);
         }
         if(hasSpirit)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,spirit$field);
         }
         if(hasBuyCount)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,buyCount$field);
         }
         if(hasMyTeam)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_MESSAGE(param1,myTeam$field);
         }
         if(hasRivalTeam)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_MESSAGE(param1,rivalTeam$field);
         }
         if(hasBufferCount)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,bufferCount$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc9_:* = 0;
         var _loc8_:uint = 0;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc9_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaWarBattleFieldMsg.teamId cannot be set twice.");
                  }
                  _loc8_++;
                  teamId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaWarBattleFieldMsg.spirit cannot be set twice.");
                  }
                  _loc3_++;
                  spirit = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaWarBattleFieldMsg.buyCount cannot be set twice.");
                  }
                  _loc5_++;
                  buyCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaWarBattleFieldMsg.myTeam cannot be set twice.");
                  }
                  _loc6_++;
                  myTeam = new ConsortiaWarTeamMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,myTeam);
                  break;
               case 4:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaWarBattleFieldMsg.rivalTeam cannot be set twice.");
                  }
                  _loc7_++;
                  rivalTeam = new ConsortiaWarTeamMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,rivalTeam);
                  break;
               case 5:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaWarBattleFieldMsg.bufferCount cannot be set twice.");
                  }
                  _loc4_++;
                  bufferCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc9_ & 7);
            }
         }
      }
   }
}

