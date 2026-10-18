package com.road.yishi.proto.battle
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class BattleReqMsg extends Message implements IExternalizable
   {
      
      private var userId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var battleId$field:String;
      
      private var armyId$field:int;
      
      private var otherObj$field:int;
      
      public function BattleReqMsg()
      {
         super();
      }
      
      public function removeUserId() : void
      {
         hasField$0 &= 4294967294;
         userId$field = new int();
      }
      
      public function get hasUserId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set userId(param1:int) : void
      {
         hasField$0 |= 1;
         userId$field = param1;
      }
      
      public function get userId() : int
      {
         return userId$field;
      }
      
      public function removeBattleId() : void
      {
         battleId$field = null;
      }
      
      public function get hasBattleId() : Boolean
      {
         return battleId$field != null;
      }
      
      public function set battleId(param1:String) : void
      {
         battleId$field = param1;
      }
      
      public function get battleId() : String
      {
         return battleId$field;
      }
      
      public function removeArmyId() : void
      {
         hasField$0 &= 4294967293;
         armyId$field = new int();
      }
      
      public function get hasArmyId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set armyId(param1:int) : void
      {
         hasField$0 |= 2;
         armyId$field = param1;
      }
      
      public function get armyId() : int
      {
         return armyId$field;
      }
      
      public function removeOtherObj() : void
      {
         hasField$0 &= 4294967291;
         otherObj$field = new int();
      }
      
      public function get hasOtherObj() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set otherObj(param1:int) : void
      {
         hasField$0 |= 4;
         otherObj$field = param1;
      }
      
      public function get otherObj() : int
      {
         return otherObj$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasUserId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,userId$field);
         }
         if(hasBattleId)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,battleId$field);
         }
         if(hasArmyId)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,armyId$field);
         }
         if(hasOtherObj)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,otherObj$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc4_:* = 0;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc4_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: BattleReqMsg.userId cannot be set twice.");
                  }
                  _loc3_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: BattleReqMsg.battleId cannot be set twice.");
                  }
                  _loc5_++;
                  battleId = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: BattleReqMsg.armyId cannot be set twice.");
                  }
                  _loc6_++;
                  armyId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: BattleReqMsg.otherObj cannot be set twice.");
                  }
                  _loc7_++;
                  otherObj = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc4_ & 7);
            }
         }
      }
   }
}

