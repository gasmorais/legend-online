package com.road.yishi.proto.dragontalker
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class TalismanMsg extends Message implements IExternalizable
   {
      
      private var id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var templateId$field:int;
      
      private var pos$field:int;
      
      private var equipslot$field:int;
      
      private var isExist$field:Boolean;
      
      private var grade$field:int;
      
      private var gp$field:int;
      
      [ArrayElementType("int")]
      public var randomSkillList:Array = [];
      
      private var newSkillId$field:int;
      
      private var oldSkillIndex$field:int;
      
      private var isNew$field:Boolean;
      
      private var count$field:int;
      
      public function TalismanMsg()
      {
         super();
      }
      
      public function removeId() : void
      {
         hasField$0 &= 4294967294;
         id$field = new int();
      }
      
      public function get hasId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set id(param1:int) : void
      {
         hasField$0 |= 1;
         id$field = param1;
      }
      
      public function get id() : int
      {
         return id$field;
      }
      
      public function removeTemplateId() : void
      {
         hasField$0 &= 4294967293;
         templateId$field = new int();
      }
      
      public function get hasTemplateId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set templateId(param1:int) : void
      {
         hasField$0 |= 2;
         templateId$field = param1;
      }
      
      public function get templateId() : int
      {
         return templateId$field;
      }
      
      public function removePos() : void
      {
         hasField$0 &= 4294967291;
         pos$field = new int();
      }
      
      public function get hasPos() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set pos(param1:int) : void
      {
         hasField$0 |= 4;
         pos$field = param1;
      }
      
      public function get pos() : int
      {
         return pos$field;
      }
      
      public function removeEquipslot() : void
      {
         hasField$0 &= 4294967287;
         equipslot$field = new int();
      }
      
      public function get hasEquipslot() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set equipslot(param1:int) : void
      {
         hasField$0 |= 8;
         equipslot$field = param1;
      }
      
      public function get equipslot() : int
      {
         return equipslot$field;
      }
      
      public function removeIsExist() : void
      {
         hasField$0 &= 4294967279;
         isExist$field = new Boolean();
      }
      
      public function get hasIsExist() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set isExist(param1:Boolean) : void
      {
         hasField$0 |= 16;
         isExist$field = param1;
      }
      
      public function get isExist() : Boolean
      {
         return isExist$field;
      }
      
      public function removeGrade() : void
      {
         hasField$0 &= 4294967263;
         grade$field = new int();
      }
      
      public function get hasGrade() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set grade(param1:int) : void
      {
         hasField$0 |= 32;
         grade$field = param1;
      }
      
      public function get grade() : int
      {
         return grade$field;
      }
      
      public function removeGp() : void
      {
         hasField$0 &= 4294967231;
         gp$field = new int();
      }
      
      public function get hasGp() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set gp(param1:int) : void
      {
         hasField$0 |= 64;
         gp$field = param1;
      }
      
      public function get gp() : int
      {
         return gp$field;
      }
      
      public function removeNewSkillId() : void
      {
         hasField$0 &= 4294967167;
         newSkillId$field = new int();
      }
      
      public function get hasNewSkillId() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set newSkillId(param1:int) : void
      {
         hasField$0 |= 128;
         newSkillId$field = param1;
      }
      
      public function get newSkillId() : int
      {
         return newSkillId$field;
      }
      
      public function removeOldSkillIndex() : void
      {
         hasField$0 &= 4294967039;
         oldSkillIndex$field = new int();
      }
      
      public function get hasOldSkillIndex() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set oldSkillIndex(param1:int) : void
      {
         hasField$0 |= 256;
         oldSkillIndex$field = param1;
      }
      
      public function get oldSkillIndex() : int
      {
         return oldSkillIndex$field;
      }
      
      public function removeIsNew() : void
      {
         hasField$0 &= 4294966783;
         isNew$field = new Boolean();
      }
      
      public function get hasIsNew() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set isNew(param1:Boolean) : void
      {
         hasField$0 |= 512;
         isNew$field = param1;
      }
      
      public function get isNew() : Boolean
      {
         return isNew$field;
      }
      
      public function removeCount() : void
      {
         hasField$0 &= 4294966271;
         count$field = new int();
      }
      
      public function get hasCount() : Boolean
      {
         return (hasField$0 & 0x0400) != 0;
      }
      
      public function set count(param1:int) : void
      {
         hasField$0 |= 1024;
         count$field = param1;
      }
      
      public function get count() : int
      {
         return count$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,id$field);
         }
         if(hasTemplateId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,templateId$field);
         }
         if(hasPos)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,pos$field);
         }
         if(hasEquipslot)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,equipslot$field);
         }
         if(hasIsExist)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_BOOL(param1,isExist$field);
         }
         if(hasGrade)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,grade$field);
         }
         if(hasGp)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,gp$field);
         }
         _loc2_ = 0;
         while(_loc2_ < randomSkillList.length)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,randomSkillList[_loc2_]);
            _loc2_++;
         }
         if(hasNewSkillId)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,newSkillId$field);
         }
         if(hasOldSkillIndex)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,oldSkillIndex$field);
         }
         if(hasIsNew)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_BOOL(param1,isNew$field);
         }
         if(hasCount)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_INT32(param1,count$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc13_:* = 0;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc14_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc12_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc13_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: TalismanMsg.id cannot be set twice.");
                  }
                  _loc8_++;
                  id = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: TalismanMsg.templateId cannot be set twice.");
                  }
                  _loc9_++;
                  templateId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: TalismanMsg.pos cannot be set twice.");
                  }
                  _loc10_++;
                  pos = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: TalismanMsg.equipslot cannot be set twice.");
                  }
                  _loc11_++;
                  equipslot = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: TalismanMsg.isExist cannot be set twice.");
                  }
                  _loc6_++;
                  isExist = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 5:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: TalismanMsg.grade cannot be set twice.");
                  }
                  _loc7_++;
                  grade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: TalismanMsg.gp cannot be set twice.");
                  }
                  _loc14_++;
                  gp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if((_loc13_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,randomSkillList);
                  }
                  else
                  {
                     randomSkillList.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               case 8:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: TalismanMsg.newSkillId cannot be set twice.");
                  }
                  _loc3_++;
                  newSkillId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: TalismanMsg.oldSkillIndex cannot be set twice.");
                  }
                  _loc4_++;
                  oldSkillIndex = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: TalismanMsg.isNew cannot be set twice.");
                  }
                  _loc12_++;
                  isNew = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 11:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: TalismanMsg.count cannot be set twice.");
                  }
                  _loc5_++;
                  count = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc13_ & 7);
            }
         }
      }
   }
}

