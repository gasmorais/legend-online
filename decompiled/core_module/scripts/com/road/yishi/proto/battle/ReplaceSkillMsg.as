package com.road.yishi.proto.battle
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ReplaceSkillMsg extends Message implements IExternalizable
   {
      
      private var fastKey$field:String;
      
      private var petFastKey$field:String;
      
      private var childFastKey$field:String;
      
      [ArrayElementType("int")]
      public var childSkills:Array = [];
      
      private var talnetSkill$field:String;
      
      public function ReplaceSkillMsg()
      {
         super();
      }
      
      public function removeFastKey() : void
      {
         fastKey$field = null;
      }
      
      public function get hasFastKey() : Boolean
      {
         return fastKey$field != null;
      }
      
      public function set fastKey(param1:String) : void
      {
         fastKey$field = param1;
      }
      
      public function get fastKey() : String
      {
         return fastKey$field;
      }
      
      public function removePetFastKey() : void
      {
         petFastKey$field = null;
      }
      
      public function get hasPetFastKey() : Boolean
      {
         return petFastKey$field != null;
      }
      
      public function set petFastKey(param1:String) : void
      {
         petFastKey$field = param1;
      }
      
      public function get petFastKey() : String
      {
         return petFastKey$field;
      }
      
      public function removeChildFastKey() : void
      {
         childFastKey$field = null;
      }
      
      public function get hasChildFastKey() : Boolean
      {
         return childFastKey$field != null;
      }
      
      public function set childFastKey(param1:String) : void
      {
         childFastKey$field = param1;
      }
      
      public function get childFastKey() : String
      {
         return childFastKey$field;
      }
      
      public function removeTalnetSkill() : void
      {
         talnetSkill$field = null;
      }
      
      public function get hasTalnetSkill() : Boolean
      {
         return talnetSkill$field != null;
      }
      
      public function set talnetSkill(param1:String) : void
      {
         talnetSkill$field = param1;
      }
      
      public function get talnetSkill() : String
      {
         return talnetSkill$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasFastKey)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,fastKey$field);
         }
         if(hasPetFastKey)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,petFastKey$field);
         }
         if(hasChildFastKey)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,childFastKey$field);
         }
         _loc2_ = 0;
         while(_loc2_ < childSkills.length)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,childSkills[_loc2_]);
            _loc2_++;
         }
         if(hasTalnetSkill)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_STRING(param1,talnetSkill$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ReplaceSkillMsg.fastKey cannot be set twice.");
                  }
                  _loc6_++;
                  fastKey = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 1:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: ReplaceSkillMsg.petFastKey cannot be set twice.");
                  }
                  _loc7_++;
                  petFastKey = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ReplaceSkillMsg.childFastKey cannot be set twice.");
                  }
                  _loc3_++;
                  childFastKey = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if((_loc5_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,childSkills);
                  }
                  else
                  {
                     childSkills.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               case 4:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ReplaceSkillMsg.talnetSkill cannot be set twice.");
                  }
                  _loc4_++;
                  talnetSkill = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

