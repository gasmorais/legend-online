package com.road.yishi.proto.vehicle
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class VehicleAttackRspMsg extends Message implements IExternalizable
   {
      
      private var skill_id$field:int;
      
      private var hasField$0:uint = 0;
      
      [ArrayElementType("com.road.yishi.proto.vehicle.HurtDataMsg")]
      public var npcHurtDataList:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.vehicle.HurtDataMsg")]
      public var playerHurtDataList:Array = [];
      
      private var effectX$field:int;
      
      private var effectY$field:int;
      
      private var attackerId$field:int;
      
      private var serverName$field:String;
      
      private var attackTyep$field:int;
      
      public function VehicleAttackRspMsg()
      {
         super();
      }
      
      public function removeSkillId() : void
      {
         hasField$0 &= 4294967294;
         skill_id$field = new int();
      }
      
      public function get hasSkillId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set skillId(param1:int) : void
      {
         hasField$0 |= 1;
         skill_id$field = param1;
      }
      
      public function get skillId() : int
      {
         return skill_id$field;
      }
      
      public function removeEffectX() : void
      {
         hasField$0 &= 4294967293;
         effectX$field = new int();
      }
      
      public function get hasEffectX() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set effectX(param1:int) : void
      {
         hasField$0 |= 2;
         effectX$field = param1;
      }
      
      public function get effectX() : int
      {
         return effectX$field;
      }
      
      public function removeEffectY() : void
      {
         hasField$0 &= 4294967291;
         effectY$field = new int();
      }
      
      public function get hasEffectY() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set effectY(param1:int) : void
      {
         hasField$0 |= 4;
         effectY$field = param1;
      }
      
      public function get effectY() : int
      {
         return effectY$field;
      }
      
      public function removeAttackerId() : void
      {
         hasField$0 &= 4294967287;
         attackerId$field = new int();
      }
      
      public function get hasAttackerId() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set attackerId(param1:int) : void
      {
         hasField$0 |= 8;
         attackerId$field = param1;
      }
      
      public function get attackerId() : int
      {
         return attackerId$field;
      }
      
      public function removeServerName() : void
      {
         serverName$field = null;
      }
      
      public function get hasServerName() : Boolean
      {
         return serverName$field != null;
      }
      
      public function set serverName(param1:String) : void
      {
         serverName$field = param1;
      }
      
      public function get serverName() : String
      {
         return serverName$field;
      }
      
      public function removeAttackTyep() : void
      {
         hasField$0 &= 4294967279;
         attackTyep$field = new int();
      }
      
      public function get hasAttackTyep() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set attackTyep(param1:int) : void
      {
         hasField$0 |= 16;
         attackTyep$field = param1;
      }
      
      public function get attackTyep() : int
      {
         return attackTyep$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         if(hasSkillId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,skill_id$field);
         }
         _loc2_ = 0;
         while(_loc2_ < npcHurtDataList.length)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_MESSAGE(param1,npcHurtDataList[_loc2_]);
            _loc2_++;
         }
         _loc3_ = 0;
         while(_loc3_ < playerHurtDataList.length)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_MESSAGE(param1,playerHurtDataList[_loc3_]);
            _loc3_++;
         }
         if(hasEffectX)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,effectX$field);
         }
         if(hasEffectY)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,effectY$field);
         }
         if(hasAttackerId)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,attackerId$field);
         }
         if(hasServerName)
         {
            WriteUtils.writeTag(param1,2,7);
            WriteUtils.write$TYPE_STRING(param1,serverName$field);
         }
         if(hasAttackTyep)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,attackTyep$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc10_:* = 0;
         var _loc8_:HurtDataMsg = null;
         var _loc11_:HurtDataMsg = null;
         var _loc9_:uint = 0;
         var _loc7_:uint = 0;
         var _loc4_:uint = 0;
         var _loc6_:uint = 0;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc10_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: VehicleAttackRspMsg.skillId cannot be set twice.");
                  }
                  _loc9_++;
                  skillId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  _loc8_ = new HurtDataMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc8_);
                  npcHurtDataList.push(_loc8_);
                  break;
               case 2:
                  _loc11_ = new HurtDataMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc11_);
                  playerHurtDataList.push(_loc11_);
                  break;
               case 3:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: VehicleAttackRspMsg.effectX cannot be set twice.");
                  }
                  _loc7_++;
                  effectX = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: VehicleAttackRspMsg.effectY cannot be set twice.");
                  }
                  _loc4_++;
                  effectY = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: VehicleAttackRspMsg.attackerId cannot be set twice.");
                  }
                  _loc6_++;
                  attackerId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: VehicleAttackRspMsg.serverName cannot be set twice.");
                  }
                  _loc3_++;
                  serverName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 7:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: VehicleAttackRspMsg.attackTyep cannot be set twice.");
                  }
                  _loc5_++;
                  attackTyep = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc10_ & 7);
            }
         }
      }
   }
}

