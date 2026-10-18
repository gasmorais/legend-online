package com.road.yishi.proto.campaign
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class HangupAttackMsg extends Message implements IExternalizable
   {
      
      private var attack_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var attack_name$field:String;
      
      private var defence_id$field:int;
      
      private var defence_name$field:int;
      
      private var op$field:int;
      
      public function HangupAttackMsg()
      {
         super();
      }
      
      public function removeAttackId() : void
      {
         hasField$0 &= 4294967294;
         attack_id$field = new int();
      }
      
      public function get hasAttackId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set attackId(param1:int) : void
      {
         hasField$0 |= 1;
         attack_id$field = param1;
      }
      
      public function get attackId() : int
      {
         return attack_id$field;
      }
      
      public function removeAttackName() : void
      {
         attack_name$field = null;
      }
      
      public function get hasAttackName() : Boolean
      {
         return attack_name$field != null;
      }
      
      public function set attackName(param1:String) : void
      {
         attack_name$field = param1;
      }
      
      public function get attackName() : String
      {
         return attack_name$field;
      }
      
      public function removeDefenceId() : void
      {
         hasField$0 &= 4294967293;
         defence_id$field = new int();
      }
      
      public function get hasDefenceId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set defenceId(param1:int) : void
      {
         hasField$0 |= 2;
         defence_id$field = param1;
      }
      
      public function get defenceId() : int
      {
         return defence_id$field;
      }
      
      public function removeDefenceName() : void
      {
         hasField$0 &= 4294967291;
         defence_name$field = new int();
      }
      
      public function get hasDefenceName() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set defenceName(param1:int) : void
      {
         hasField$0 |= 4;
         defence_name$field = param1;
      }
      
      public function get defenceName() : int
      {
         return defence_name$field;
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
         if(hasAttackId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,attack_id$field);
         }
         if(hasAttackName)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,attack_name$field);
         }
         if(hasDefenceId)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,defence_id$field);
         }
         if(hasDefenceName)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,defence_name$field);
         }
         if(hasOp)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,op$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc6_:uint = 0;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         var _loc4_:uint = 0;
         var _loc8_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc7_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: HangupAttackMsg.attackId cannot be set twice.");
                  }
                  _loc6_++;
                  attackId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: HangupAttackMsg.attackName cannot be set twice.");
                  }
                  _loc3_++;
                  attackName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: HangupAttackMsg.defenceId cannot be set twice.");
                  }
                  _loc5_++;
                  defenceId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: HangupAttackMsg.defenceName cannot be set twice.");
                  }
                  _loc4_++;
                  defenceName = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: HangupAttackMsg.op cannot be set twice.");
                  }
                  _loc8_++;
                  op = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
      }
   }
}

