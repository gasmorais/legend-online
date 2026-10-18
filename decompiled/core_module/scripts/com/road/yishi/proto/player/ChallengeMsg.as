package com.road.yishi.proto.player
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ChallengeMsg extends Message implements IExternalizable
   {
      
      private var tar_userId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var tar_armyId$field:int;
      
      private var pay_type$field:int;
      
      private var type$field:int;
      
      private var uuid$field:String;
      
      public function ChallengeMsg()
      {
         super();
      }
      
      public function removeTarUserId() : void
      {
         hasField$0 &= 4294967294;
         tar_userId$field = new int();
      }
      
      public function get hasTarUserId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set tarUserId(param1:int) : void
      {
         hasField$0 |= 1;
         tar_userId$field = param1;
      }
      
      public function get tarUserId() : int
      {
         return tar_userId$field;
      }
      
      public function removeTarArmyId() : void
      {
         hasField$0 &= 4294967293;
         tar_armyId$field = new int();
      }
      
      public function get hasTarArmyId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set tarArmyId(param1:int) : void
      {
         hasField$0 |= 2;
         tar_armyId$field = param1;
      }
      
      public function get tarArmyId() : int
      {
         return tar_armyId$field;
      }
      
      public function removePayType() : void
      {
         hasField$0 &= 4294967291;
         pay_type$field = new int();
      }
      
      public function get hasPayType() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set payType(param1:int) : void
      {
         hasField$0 |= 4;
         pay_type$field = param1;
      }
      
      public function get payType() : int
      {
         return pay_type$field;
      }
      
      public function removeType() : void
      {
         hasField$0 &= 4294967287;
         type$field = new int();
      }
      
      public function get hasType() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set type(param1:int) : void
      {
         hasField$0 |= 8;
         type$field = param1;
      }
      
      public function get type() : int
      {
         return type$field;
      }
      
      public function removeUuid() : void
      {
         uuid$field = null;
      }
      
      public function get hasUuid() : Boolean
      {
         return uuid$field != null;
      }
      
      public function set uuid(param1:String) : void
      {
         uuid$field = param1;
      }
      
      public function get uuid() : String
      {
         return uuid$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasTarUserId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,tar_userId$field);
         }
         if(hasTarArmyId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,tar_armyId$field);
         }
         if(hasPayType)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,pay_type$field);
         }
         if(hasType)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,type$field);
         }
         if(hasUuid)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_STRING(param1,uuid$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc8_:uint = 0;
         var _loc6_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc7_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ChallengeMsg.tarUserId cannot be set twice.");
                  }
                  _loc4_++;
                  tarUserId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ChallengeMsg.tarArmyId cannot be set twice.");
                  }
                  _loc5_++;
                  tarArmyId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: ChallengeMsg.payType cannot be set twice.");
                  }
                  _loc8_++;
                  payType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ChallengeMsg.type cannot be set twice.");
                  }
                  _loc6_++;
                  type = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ChallengeMsg.uuid cannot be set twice.");
                  }
                  _loc3_++;
                  uuid = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
      }
   }
}

