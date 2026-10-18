package com.road.yishi.proto.hugehead
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class HugeHeadBattleFieldMsg extends Message implements IExternalizable
   {
      
      private var op$field:int;
      
      private var hasField$0:uint = 0;
      
      private var battle_field_uid$field:String;
      
      [ArrayElementType("com.road.yishi.proto.hugehead.HugeHeadMapNodeMsg")]
      public var nodeList:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.hugehead.HugeHeadForceMsg")]
      public var forceList:Array = [];
      
      public function HugeHeadBattleFieldMsg()
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
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         if(hasOp)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,op$field);
         }
         if(hasBattleFieldUid)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,battle_field_uid$field);
         }
         _loc2_ = 0;
         while(_loc2_ < nodeList.length)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_MESSAGE(param1,nodeList[_loc2_]);
            _loc2_++;
         }
         _loc3_ = 0;
         while(_loc3_ < forceList.length)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_MESSAGE(param1,forceList[_loc3_]);
            _loc3_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc6_:HugeHeadMapNodeMsg = null;
         var _loc3_:HugeHeadForceMsg = null;
         var _loc7_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: HugeHeadBattleFieldMsg.op cannot be set twice.");
                  }
                  _loc7_++;
                  op = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: HugeHeadBattleFieldMsg.battleFieldUid cannot be set twice.");
                  }
                  _loc4_++;
                  battleFieldUid = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  _loc6_ = new HugeHeadMapNodeMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc6_);
                  nodeList.push(_loc6_);
                  break;
               case 3:
                  _loc3_ = new HugeHeadForceMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc3_);
                  forceList.push(_loc3_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

