package com.road.yishi.proto.army
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class HeroTalentMsg extends Message implements IExternalizable
   {
      
      private var user_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var talent_point$field:int;
      
      private var talent_grade$field:int;
      
      private var talent_skill$field:String;
      
      private var advanced_talent_point$field:int;
      
      private var advanced_talent_grade$field:int;
      
      public function HeroTalentMsg()
      {
         super();
      }
      
      public function removeUserId() : void
      {
         hasField$0 &= 4294967294;
         user_id$field = new int();
      }
      
      public function get hasUserId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set userId(param1:int) : void
      {
         hasField$0 |= 1;
         user_id$field = param1;
      }
      
      public function get userId() : int
      {
         return user_id$field;
      }
      
      public function removeTalentPoint() : void
      {
         hasField$0 &= 4294967293;
         talent_point$field = new int();
      }
      
      public function get hasTalentPoint() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set talentPoint(param1:int) : void
      {
         hasField$0 |= 2;
         talent_point$field = param1;
      }
      
      public function get talentPoint() : int
      {
         return talent_point$field;
      }
      
      public function removeTalentGrade() : void
      {
         hasField$0 &= 4294967291;
         talent_grade$field = new int();
      }
      
      public function get hasTalentGrade() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set talentGrade(param1:int) : void
      {
         hasField$0 |= 4;
         talent_grade$field = param1;
      }
      
      public function get talentGrade() : int
      {
         return talent_grade$field;
      }
      
      public function removeTalentSkill() : void
      {
         talent_skill$field = null;
      }
      
      public function get hasTalentSkill() : Boolean
      {
         return talent_skill$field != null;
      }
      
      public function set talentSkill(param1:String) : void
      {
         talent_skill$field = param1;
      }
      
      public function get talentSkill() : String
      {
         return talent_skill$field;
      }
      
      public function removeAdvancedTalentPoint() : void
      {
         hasField$0 &= 4294967287;
         advanced_talent_point$field = new int();
      }
      
      public function get hasAdvancedTalentPoint() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set advancedTalentPoint(param1:int) : void
      {
         hasField$0 |= 8;
         advanced_talent_point$field = param1;
      }
      
      public function get advancedTalentPoint() : int
      {
         return advanced_talent_point$field;
      }
      
      public function removeAdvancedTalentGrade() : void
      {
         hasField$0 &= 4294967279;
         advanced_talent_grade$field = new int();
      }
      
      public function get hasAdvancedTalentGrade() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set advancedTalentGrade(param1:int) : void
      {
         hasField$0 |= 16;
         advanced_talent_grade$field = param1;
      }
      
      public function get advancedTalentGrade() : int
      {
         return advanced_talent_grade$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasUserId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,user_id$field);
         }
         if(hasTalentPoint)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,talent_point$field);
         }
         if(hasTalentGrade)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,talent_grade$field);
         }
         if(hasTalentSkill)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,talent_skill$field);
         }
         if(hasAdvancedTalentPoint)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,advanced_talent_point$field);
         }
         if(hasAdvancedTalentGrade)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,advanced_talent_grade$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc8_:* = 0;
         var _loc7_:uint = 0;
         var _loc4_:uint = 0;
         var _loc9_:uint = 0;
         var _loc6_:uint = 0;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc8_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: HeroTalentMsg.userId cannot be set twice.");
                  }
                  _loc7_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: HeroTalentMsg.talentPoint cannot be set twice.");
                  }
                  _loc4_++;
                  talentPoint = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: HeroTalentMsg.talentGrade cannot be set twice.");
                  }
                  _loc9_++;
                  talentGrade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: HeroTalentMsg.talentSkill cannot be set twice.");
                  }
                  _loc6_++;
                  talentSkill = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: HeroTalentMsg.advancedTalentPoint cannot be set twice.");
                  }
                  _loc3_++;
                  advancedTalentPoint = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: HeroTalentMsg.advancedTalentGrade cannot be set twice.");
                  }
                  _loc5_++;
                  advancedTalentGrade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc8_ & 7);
            }
         }
      }
   }
}

