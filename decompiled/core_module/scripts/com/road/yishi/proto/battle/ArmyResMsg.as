package com.road.yishi.proto.battle
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ArmyResMsg extends Message implements IExternalizable
   {
      
      [ArrayElementType("com.road.yishi.proto.battle.PreLoadResMsg")]
      public var loadRes:Array = [];
      
      private var reinforce_count$field:int;
      
      private var hasField$0:uint = 0;
      
      private var reinforce_type$field:int;
      
      public function ArmyResMsg()
      {
         super();
      }
      
      public function removeReinforceCount() : void
      {
         hasField$0 &= 4294967294;
         reinforce_count$field = new int();
      }
      
      public function get hasReinforceCount() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set reinforceCount(param1:int) : void
      {
         hasField$0 |= 1;
         reinforce_count$field = param1;
      }
      
      public function get reinforceCount() : int
      {
         return reinforce_count$field;
      }
      
      public function removeReinforceType() : void
      {
         hasField$0 &= 4294967293;
         reinforce_type$field = new int();
      }
      
      public function get hasReinforceType() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set reinforceType(param1:int) : void
      {
         hasField$0 |= 2;
         reinforce_type$field = param1;
      }
      
      public function get reinforceType() : int
      {
         return reinforce_type$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         _loc2_ = 0;
         while(_loc2_ < loadRes.length)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_MESSAGE(param1,loadRes[_loc2_]);
            _loc2_++;
         }
         if(hasReinforceCount)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,reinforce_count$field);
         }
         if(hasReinforceType)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,reinforce_type$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc4_:PreLoadResMsg = null;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  _loc4_ = new PreLoadResMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc4_);
                  loadRes.push(_loc4_);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ArmyResMsg.reinforceCount cannot be set twice.");
                  }
                  _loc5_++;
                  reinforceCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ArmyResMsg.reinforceType cannot be set twice.");
                  }
                  _loc3_++;
                  reinforceType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

