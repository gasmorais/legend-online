package com.road.yishi.proto.dungeonturn
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class DungeonTurnOpMsg extends Message implements IExternalizable
   {
      
      private var op$field:int;
      
      private var hasField$0:uint = 0;
      
      private var errorId$field:int;
      
      private var rollNum$field:int;
      
      private var reward$field:String;
      
      private var hasGetReward$field:Boolean;
      
      private var dungeonTurnInfoMsg$field:DungeonTurnInfoMsg;
      
      public function DungeonTurnOpMsg()
      {
         super();
      }
      
      public function removeOp() : void
      {
         hasField$0 &= 4294967294;
         op$field = new int();
      }
      
      public function get hasOp() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set op(param1:int) : void
      {
         hasField$0 |= 1;
         op$field = param1;
      }
      
      public function get op() : int
      {
         return op$field;
      }
      
      public function removeErrorId() : void
      {
         hasField$0 &= 4294967293;
         errorId$field = new int();
      }
      
      public function get hasErrorId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set errorId(param1:int) : void
      {
         hasField$0 |= 2;
         errorId$field = param1;
      }
      
      public function get errorId() : int
      {
         return errorId$field;
      }
      
      public function removeRollNum() : void
      {
         hasField$0 &= 4294967291;
         rollNum$field = new int();
      }
      
      public function get hasRollNum() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set rollNum(param1:int) : void
      {
         hasField$0 |= 4;
         rollNum$field = param1;
      }
      
      public function get rollNum() : int
      {
         return rollNum$field;
      }
      
      public function removeReward() : void
      {
         reward$field = null;
      }
      
      public function get hasReward() : Boolean
      {
         return reward$field != null;
      }
      
      public function set reward(param1:String) : void
      {
         reward$field = param1;
      }
      
      public function get reward() : String
      {
         return reward$field;
      }
      
      public function removeHasGetReward() : void
      {
         hasField$0 &= 4294967287;
         hasGetReward$field = new Boolean();
      }
      
      public function get hasHasGetReward() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set hasGetReward(param1:Boolean) : void
      {
         hasField$0 |= 8;
         hasGetReward$field = param1;
      }
      
      public function get hasGetReward() : Boolean
      {
         return hasGetReward$field;
      }
      
      public function removeDungeonTurnInfoMsg() : void
      {
         dungeonTurnInfoMsg$field = null;
      }
      
      public function get hasDungeonTurnInfoMsg() : Boolean
      {
         return dungeonTurnInfoMsg$field != null;
      }
      
      public function set dungeonTurnInfoMsg(param1:DungeonTurnInfoMsg) : void
      {
         dungeonTurnInfoMsg$field = param1;
      }
      
      public function get dungeonTurnInfoMsg() : DungeonTurnInfoMsg
      {
         return dungeonTurnInfoMsg$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasOp)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_ENUM(param1,op$field);
         }
         if(hasErrorId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_ENUM(param1,errorId$field);
         }
         if(hasRollNum)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,rollNum$field);
         }
         if(hasReward)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,reward$field);
         }
         if(hasHasGetReward)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_BOOL(param1,hasGetReward$field);
         }
         if(hasDungeonTurnInfoMsg)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_MESSAGE(param1,dungeonTurnInfoMsg$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc7_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: DungeonTurnOpMsg.op cannot be set twice.");
                  }
                  _loc8_++;
                  op = ReadUtils.read$TYPE_ENUM(param1);
                  break;
               case 1:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: DungeonTurnOpMsg.errorId cannot be set twice.");
                  }
                  _loc9_++;
                  errorId = ReadUtils.read$TYPE_ENUM(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: DungeonTurnOpMsg.rollNum cannot be set twice.");
                  }
                  _loc4_++;
                  rollNum = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: DungeonTurnOpMsg.reward cannot be set twice.");
                  }
                  _loc5_++;
                  reward = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: DungeonTurnOpMsg.hasGetReward cannot be set twice.");
                  }
                  _loc6_++;
                  hasGetReward = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 5:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: DungeonTurnOpMsg.dungeonTurnInfoMsg cannot be set twice.");
                  }
                  _loc3_++;
                  dungeonTurnInfoMsg = new DungeonTurnInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,dungeonTurnInfoMsg);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
      }
   }
}

