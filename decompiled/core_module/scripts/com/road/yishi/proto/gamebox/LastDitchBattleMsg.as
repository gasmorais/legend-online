package com.road.yishi.proto.gamebox
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class LastDitchBattleMsg extends Message implements IExternalizable
   {
      
      [ArrayElementType("com.road.yishi.proto.gamebox.DitchNpcInfoMsg")]
      public var ditchNpcInfo:Array = [];
      
      private var attakDitchId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var useSkillId$field:int;
      
      private var defenceDitchId$field:int;
      
      private var op$field:int;
      
      public function LastDitchBattleMsg()
      {
         super();
      }
      
      public function removeAttakDitchId() : void
      {
         hasField$0 &= 4294967294;
         attakDitchId$field = new int();
      }
      
      public function get hasAttakDitchId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set attakDitchId(param1:int) : void
      {
         hasField$0 |= 1;
         attakDitchId$field = param1;
      }
      
      public function get attakDitchId() : int
      {
         return attakDitchId$field;
      }
      
      public function removeUseSkillId() : void
      {
         hasField$0 &= 4294967293;
         useSkillId$field = new int();
      }
      
      public function get hasUseSkillId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set useSkillId(param1:int) : void
      {
         hasField$0 |= 2;
         useSkillId$field = param1;
      }
      
      public function get useSkillId() : int
      {
         return useSkillId$field;
      }
      
      public function removeDefenceDitchId() : void
      {
         hasField$0 &= 4294967291;
         defenceDitchId$field = new int();
      }
      
      public function get hasDefenceDitchId() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set defenceDitchId(param1:int) : void
      {
         hasField$0 |= 4;
         defenceDitchId$field = param1;
      }
      
      public function get defenceDitchId() : int
      {
         return defenceDitchId$field;
      }
      
      public function removeOp() : void
      {
         hasField$0 &= 4294967287;
         op$field = new int();
      }
      
      public function get hasOp() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set op(param1:int) : void
      {
         hasField$0 |= 8;
         op$field = param1;
      }
      
      public function get op() : int
      {
         return op$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         _loc2_ = 0;
         while(_loc2_ < ditchNpcInfo.length)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_MESSAGE(param1,ditchNpcInfo[_loc2_]);
            _loc2_++;
         }
         if(hasAttakDitchId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,attakDitchId$field);
         }
         if(hasUseSkillId)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,useSkillId$field);
         }
         if(hasDefenceDitchId)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,defenceDitchId$field);
         }
         if(hasOp)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,op$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc7_:DitchNpcInfoMsg = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc6_:uint = 0;
         var _loc8_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  _loc7_ = new DitchNpcInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc7_);
                  ditchNpcInfo.push(_loc7_);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: LastDitchBattleMsg.attakDitchId cannot be set twice.");
                  }
                  _loc3_++;
                  attakDitchId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: LastDitchBattleMsg.useSkillId cannot be set twice.");
                  }
                  _loc4_++;
                  useSkillId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: LastDitchBattleMsg.defenceDitchId cannot be set twice.");
                  }
                  _loc6_++;
                  defenceDitchId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: LastDitchBattleMsg.op cannot be set twice.");
                  }
                  _loc8_++;
                  op = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

