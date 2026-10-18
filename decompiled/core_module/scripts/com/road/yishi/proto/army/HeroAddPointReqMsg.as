package com.road.yishi.proto.army
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class HeroAddPointReqMsg extends Message implements IExternalizable
   {
      
      private var power_point$field:int;
      
      private var hasField$0:uint = 0;
      
      private var agility_point$field:int;
      
      private var intellect_point$field:int;
      
      private var captain_point$field:int;
      
      private var physique_point$field:int;
      
      private var skill_temp_id$field:int;
      
      private var type$field:int;
      
      public function HeroAddPointReqMsg()
      {
         super();
      }
      
      public function removePowerPoint() : void
      {
         hasField$0 &= 4294967294;
         power_point$field = new int();
      }
      
      public function get hasPowerPoint() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set powerPoint(param1:int) : void
      {
         hasField$0 |= 1;
         power_point$field = param1;
      }
      
      public function get powerPoint() : int
      {
         return power_point$field;
      }
      
      public function removeAgilityPoint() : void
      {
         hasField$0 &= 4294967293;
         agility_point$field = new int();
      }
      
      public function get hasAgilityPoint() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set agilityPoint(param1:int) : void
      {
         hasField$0 |= 2;
         agility_point$field = param1;
      }
      
      public function get agilityPoint() : int
      {
         return agility_point$field;
      }
      
      public function removeIntellectPoint() : void
      {
         hasField$0 &= 4294967291;
         intellect_point$field = new int();
      }
      
      public function get hasIntellectPoint() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set intellectPoint(param1:int) : void
      {
         hasField$0 |= 4;
         intellect_point$field = param1;
      }
      
      public function get intellectPoint() : int
      {
         return intellect_point$field;
      }
      
      public function removeCaptainPoint() : void
      {
         hasField$0 &= 4294967287;
         captain_point$field = new int();
      }
      
      public function get hasCaptainPoint() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set captainPoint(param1:int) : void
      {
         hasField$0 |= 8;
         captain_point$field = param1;
      }
      
      public function get captainPoint() : int
      {
         return captain_point$field;
      }
      
      public function removePhysiquePoint() : void
      {
         hasField$0 &= 4294967279;
         physique_point$field = new int();
      }
      
      public function get hasPhysiquePoint() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set physiquePoint(param1:int) : void
      {
         hasField$0 |= 16;
         physique_point$field = param1;
      }
      
      public function get physiquePoint() : int
      {
         return physique_point$field;
      }
      
      public function removeSkillTempId() : void
      {
         hasField$0 &= 4294967263;
         skill_temp_id$field = new int();
      }
      
      public function get hasSkillTempId() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set skillTempId(param1:int) : void
      {
         hasField$0 |= 32;
         skill_temp_id$field = param1;
      }
      
      public function get skillTempId() : int
      {
         return skill_temp_id$field;
      }
      
      public function removeType() : void
      {
         hasField$0 &= 4294967231;
         type$field = new int();
      }
      
      public function get hasType() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set type(param1:int) : void
      {
         hasField$0 |= 64;
         type$field = param1;
      }
      
      public function get type() : int
      {
         return type$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasPowerPoint)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,power_point$field);
         }
         if(hasAgilityPoint)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,agility_point$field);
         }
         if(hasIntellectPoint)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,intellect_point$field);
         }
         if(hasCaptainPoint)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,captain_point$field);
         }
         if(hasPhysiquePoint)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,physique_point$field);
         }
         if(hasSkillTempId)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,skill_temp_id$field);
         }
         if(hasType)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,type$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc10_:* = 0;
         var _loc6_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc8_:uint = 0;
         var _loc5_:uint = 0;
         var _loc7_:uint = 0;
         var _loc9_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc10_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: HeroAddPointReqMsg.powerPoint cannot be set twice.");
                  }
                  _loc6_++;
                  powerPoint = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: HeroAddPointReqMsg.agilityPoint cannot be set twice.");
                  }
                  _loc3_++;
                  agilityPoint = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: HeroAddPointReqMsg.intellectPoint cannot be set twice.");
                  }
                  _loc4_++;
                  intellectPoint = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: HeroAddPointReqMsg.captainPoint cannot be set twice.");
                  }
                  _loc8_++;
                  captainPoint = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: HeroAddPointReqMsg.physiquePoint cannot be set twice.");
                  }
                  _loc5_++;
                  physiquePoint = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: HeroAddPointReqMsg.skillTempId cannot be set twice.");
                  }
                  _loc7_++;
                  skillTempId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: HeroAddPointReqMsg.type cannot be set twice.");
                  }
                  _loc9_++;
                  type = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc10_ & 7);
            }
         }
      }
   }
}

