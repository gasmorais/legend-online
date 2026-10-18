package com.road.yishi.proto.pvp
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ChildPvpBattleMsg extends Message implements IExternalizable
   {
      
      private var op$field:int;
      
      private var hasField$0:uint = 0;
      
      private var battleId$field:String;
      
      private var fightSkillId$field:int;
      
      [ArrayElementType("com.road.yishi.proto.pvp.ChildPvpBattleChildMsg")]
      public var childs:Array = [];
      
      public function ChildPvpBattleMsg()
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
      
      public function removeFightSkillId() : void
      {
         hasField$0 &= 4294967293;
         fightSkillId$field = new int();
      }
      
      public function get hasFightSkillId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set fightSkillId(param1:int) : void
      {
         hasField$0 |= 2;
         fightSkillId$field = param1;
      }
      
      public function get fightSkillId() : int
      {
         return fightSkillId$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasOp)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,op$field);
         }
         if(hasBattleId)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,battleId$field);
         }
         if(hasFightSkillId)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,fightSkillId$field);
         }
         _loc2_ = 0;
         while(_loc2_ < childs.length)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_MESSAGE(param1,childs[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc4_:* = 0;
         var _loc6_:ChildPvpBattleChildMsg = null;
         var _loc7_:uint = 0;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc4_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: ChildPvpBattleMsg.op cannot be set twice.");
                  }
                  _loc7_++;
                  op = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ChildPvpBattleMsg.battleId cannot be set twice.");
                  }
                  _loc5_++;
                  battleId = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ChildPvpBattleMsg.fightSkillId cannot be set twice.");
                  }
                  _loc3_++;
                  fightSkillId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  _loc6_ = new ChildPvpBattleChildMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc6_);
                  childs.push(_loc6_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc4_ & 7);
            }
         }
      }
   }
}

