package com.road.yishi.proto.consortiawar
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ConsortiaWarClientOpMsg extends Message implements IExternalizable
   {
      
      private var opType$field:int;
      
      private var hasField$0:uint = 0;
      
      private var signType$field:int;
      
      private var bufferId$field:int;
      
      private var towerId$field:int;
      
      private var teamId$field:int;
      
      private var attackType$field:int;
      
      private var payType$field:int;
      
      public function ConsortiaWarClientOpMsg()
      {
         super();
      }
      
      public function removeOpType() : void
      {
         hasField$0 &= 4294967294;
         opType$field = new int();
      }
      
      public function get hasOpType() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set opType(param1:int) : void
      {
         hasField$0 |= 1;
         opType$field = param1;
      }
      
      public function get opType() : int
      {
         return opType$field;
      }
      
      public function removeSignType() : void
      {
         hasField$0 &= 4294967293;
         signType$field = new int();
      }
      
      public function get hasSignType() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set signType(param1:int) : void
      {
         hasField$0 |= 2;
         signType$field = param1;
      }
      
      public function get signType() : int
      {
         return signType$field;
      }
      
      public function removeBufferId() : void
      {
         hasField$0 &= 4294967291;
         bufferId$field = new int();
      }
      
      public function get hasBufferId() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set bufferId(param1:int) : void
      {
         hasField$0 |= 4;
         bufferId$field = param1;
      }
      
      public function get bufferId() : int
      {
         return bufferId$field;
      }
      
      public function removeTowerId() : void
      {
         hasField$0 &= 4294967287;
         towerId$field = new int();
      }
      
      public function get hasTowerId() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set towerId(param1:int) : void
      {
         hasField$0 |= 8;
         towerId$field = param1;
      }
      
      public function get towerId() : int
      {
         return towerId$field;
      }
      
      public function removeTeamId() : void
      {
         hasField$0 &= 4294967279;
         teamId$field = new int();
      }
      
      public function get hasTeamId() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set teamId(param1:int) : void
      {
         hasField$0 |= 16;
         teamId$field = param1;
      }
      
      public function get teamId() : int
      {
         return teamId$field;
      }
      
      public function removeAttackType() : void
      {
         hasField$0 &= 4294967263;
         attackType$field = new int();
      }
      
      public function get hasAttackType() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set attackType(param1:int) : void
      {
         hasField$0 |= 32;
         attackType$field = param1;
      }
      
      public function get attackType() : int
      {
         return attackType$field;
      }
      
      public function removePayType() : void
      {
         hasField$0 &= 4294967231;
         payType$field = new int();
      }
      
      public function get hasPayType() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set payType(param1:int) : void
      {
         hasField$0 |= 64;
         payType$field = param1;
      }
      
      public function get payType() : int
      {
         return payType$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasOpType)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,opType$field);
         }
         if(hasSignType)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,signType$field);
         }
         if(hasBufferId)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,bufferId$field);
         }
         if(hasTowerId)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,towerId$field);
         }
         if(hasTeamId)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,teamId$field);
         }
         if(hasAttackType)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,attackType$field);
         }
         if(hasPayType)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,payType$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc3_:uint = 0;
         var _loc10_:uint = 0;
         var _loc5_:uint = 0;
         var _loc8_:uint = 0;
         var _loc6_:uint = 0;
         var _loc9_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc7_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaWarClientOpMsg.opType cannot be set twice.");
                  }
                  _loc3_++;
                  opType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaWarClientOpMsg.signType cannot be set twice.");
                  }
                  _loc10_++;
                  signType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaWarClientOpMsg.bufferId cannot be set twice.");
                  }
                  _loc5_++;
                  bufferId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaWarClientOpMsg.towerId cannot be set twice.");
                  }
                  _loc8_++;
                  towerId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaWarClientOpMsg.teamId cannot be set twice.");
                  }
                  _loc6_++;
                  teamId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaWarClientOpMsg.attackType cannot be set twice.");
                  }
                  _loc9_++;
                  attackType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaWarClientOpMsg.payType cannot be set twice.");
                  }
                  _loc4_++;
                  payType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
      }
   }
}

