package com.road.yishi.proto.hugehead
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class StackHeadBattleFieldMsg extends Message implements IExternalizable
   {
      
      private var op$field:int;
      
      private var hasField$0:uint = 0;
      
      [ArrayElementType("com.road.yishi.proto.hugehead.StackHeadForceMsg")]
      public var forceList:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.hugehead.StackHeadAttackMsg")]
      public var attackList:Array = [];
      
      private var battle_field_uid$field:String;
      
      private var week_union_strong_force$field:int;
      
      public function StackHeadBattleFieldMsg()
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
      
      public function removeBattleFieldUid() : void
      {
         battle_field_uid$field = null;
      }
      
      public function get hasBattleFieldUid() : Boolean
      {
         return battle_field_uid$field != null;
      }
      
      public function set battleFieldUid(param1:String) : void
      {
         battle_field_uid$field = param1;
      }
      
      public function get battleFieldUid() : String
      {
         return battle_field_uid$field;
      }
      
      public function removeWeekUnionStrongForce() : void
      {
         hasField$0 &= 4294967293;
         week_union_strong_force$field = new int();
      }
      
      public function get hasWeekUnionStrongForce() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set weekUnionStrongForce(param1:int) : void
      {
         hasField$0 |= 2;
         week_union_strong_force$field = param1;
      }
      
      public function get weekUnionStrongForce() : int
      {
         return week_union_strong_force$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc3_:* = 0;
         var _loc2_:* = 0;
         if(hasOp)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,op$field);
         }
         _loc3_ = 0;
         while(_loc3_ < forceList.length)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_MESSAGE(param1,forceList[_loc3_]);
            _loc3_++;
         }
         _loc2_ = 0;
         while(_loc2_ < attackList.length)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_MESSAGE(param1,attackList[_loc2_]);
            _loc2_++;
         }
         if(hasBattleFieldUid)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,battle_field_uid$field);
         }
         if(hasWeekUnionStrongForce)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,week_union_strong_force$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc4_:StackHeadForceMsg = null;
         var _loc7_:StackHeadAttackMsg = null;
         var _loc8_:uint = 0;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: StackHeadBattleFieldMsg.op cannot be set twice.");
                  }
                  _loc8_++;
                  op = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  _loc4_ = new StackHeadForceMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc4_);
                  forceList.push(_loc4_);
                  break;
               case 2:
                  _loc7_ = new StackHeadAttackMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc7_);
                  attackList.push(_loc7_);
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: StackHeadBattleFieldMsg.battleFieldUid cannot be set twice.");
                  }
                  _loc5_++;
                  battleFieldUid = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: StackHeadBattleFieldMsg.weekUnionStrongForce cannot be set twice.");
                  }
                  _loc3_++;
                  weekUnionStrongForce = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

