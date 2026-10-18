package com.road.yishi.proto.vehicle
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class VehicleAttackReqMsg extends Message implements IExternalizable
   {
      
      private var skill_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var attack_type$field:int;
      
      private var sufferer_npc_id$field:int;
      
      [ArrayElementType("int")]
      public var suffererId:Array = [];
      
      private var effectX$field:int;
      
      private var effectY$field:int;
      
      [ArrayElementType("String")]
      public var suffererServerName:Array = [];
      
      [ArrayElementType("int")]
      public var suffererNpcIdArray:Array = [];
      
      private var attack_server_name$field:String;
      
      public function VehicleAttackReqMsg()
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
      
      public function removeAttackType() : void
      {
         hasField$0 &= 4294967293;
         attack_type$field = new int();
      }
      
      public function get hasAttackType() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set attackType(param1:int) : void
      {
         hasField$0 |= 2;
         attack_type$field = param1;
      }
      
      public function get attackType() : int
      {
         return attack_type$field;
      }
      
      public function removeSuffererNpcId() : void
      {
         hasField$0 &= 4294967291;
         sufferer_npc_id$field = new int();
      }
      
      public function get hasSuffererNpcId() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set suffererNpcId(param1:int) : void
      {
         hasField$0 |= 4;
         sufferer_npc_id$field = param1;
      }
      
      public function get suffererNpcId() : int
      {
         return sufferer_npc_id$field;
      }
      
      public function removeEffectX() : void
      {
         hasField$0 &= 4294967287;
         effectX$field = new int();
      }
      
      public function get hasEffectX() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set effectX(param1:int) : void
      {
         hasField$0 |= 8;
         effectX$field = param1;
      }
      
      public function get effectX() : int
      {
         return effectX$field;
      }
      
      public function removeEffectY() : void
      {
         hasField$0 &= 4294967279;
         effectY$field = new int();
      }
      
      public function get hasEffectY() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set effectY(param1:int) : void
      {
         hasField$0 |= 16;
         effectY$field = param1;
      }
      
      public function get effectY() : int
      {
         return effectY$field;
      }
      
      public function removeAttackServerName() : void
      {
         attack_server_name$field = null;
      }
      
      public function get hasAttackServerName() : Boolean
      {
         return attack_server_name$field != null;
      }
      
      public function set attackServerName(param1:String) : void
      {
         attack_server_name$field = param1;
      }
      
      public function get attackServerName() : String
      {
         return attack_server_name$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc4_:* = 0;
         var _loc3_:* = 0;
         var _loc2_:* = 0;
         if(hasSkillId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,skill_id$field);
         }
         if(hasAttackType)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,attack_type$field);
         }
         if(hasSuffererNpcId)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,sufferer_npc_id$field);
         }
         _loc4_ = 0;
         while(_loc4_ < suffererId.length)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,suffererId[_loc4_]);
            _loc4_++;
         }
         if(hasEffectX)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,effectX$field);
         }
         if(hasEffectY)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,effectY$field);
         }
         _loc3_ = 0;
         while(_loc3_ < suffererServerName.length)
         {
            WriteUtils.writeTag(param1,2,7);
            WriteUtils.write$TYPE_STRING(param1,suffererServerName[_loc3_]);
            _loc3_++;
         }
         _loc2_ = 0;
         while(_loc2_ < suffererNpcIdArray.length)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,suffererNpcIdArray[_loc2_]);
            _loc2_++;
         }
         if(hasAttackServerName)
         {
            WriteUtils.writeTag(param1,2,9);
            WriteUtils.write$TYPE_STRING(param1,attack_server_name$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc8_:* = 0;
         var _loc6_:uint = 0;
         var _loc9_:uint = 0;
         var _loc7_:uint = 0;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc8_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: VehicleAttackReqMsg.skillId cannot be set twice.");
                  }
                  _loc6_++;
                  skillId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: VehicleAttackReqMsg.attackType cannot be set twice.");
                  }
                  _loc9_++;
                  attackType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: VehicleAttackReqMsg.suffererNpcId cannot be set twice.");
                  }
                  _loc7_++;
                  suffererNpcId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if((_loc8_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,suffererId);
                  }
                  else
                  {
                     suffererId.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               case 4:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: VehicleAttackReqMsg.effectX cannot be set twice.");
                  }
                  _loc5_++;
                  effectX = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: VehicleAttackReqMsg.effectY cannot be set twice.");
                  }
                  _loc3_++;
                  effectY = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  suffererServerName.push(ReadUtils.read$TYPE_STRING(param1));
                  break;
               case 7:
                  if((_loc8_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,suffererNpcIdArray);
                  }
                  else
                  {
                     suffererNpcIdArray.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               case 8:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: VehicleAttackReqMsg.attackServerName cannot be set twice.");
                  }
                  _loc4_++;
                  attackServerName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc8_ & 7);
            }
         }
      }
   }
}

