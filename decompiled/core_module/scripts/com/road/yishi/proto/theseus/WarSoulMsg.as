package com.road.yishi.proto.theseus
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class WarSoulMsg extends Message implements IExternalizable
   {
      
      private var id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var warSoulId$field:int;
      
      private var star$field:int;
      
      private var strengthen$field:int;
      
      private var reform$field:int;
      
      private var learnSkill$field:int;
      
      private var ramdomSkills$field:String;
      
      private var reformBuff$field:String;
      
      private var isEquip$field:Boolean;
      
      private var isExist$field:Boolean;
      
      private var count$field:int;
      
      private var newLearnSkill$field:int;
      
      private var isLock$field:Boolean;
      
      public function WarSoulMsg()
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
      
      public function removeWarSoulId() : void
      {
         hasField$0 &= 4294967293;
         warSoulId$field = new int();
      }
      
      public function get hasWarSoulId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set warSoulId(param1:int) : void
      {
         hasField$0 |= 2;
         warSoulId$field = param1;
      }
      
      public function get warSoulId() : int
      {
         return warSoulId$field;
      }
      
      public function removeStar() : void
      {
         hasField$0 &= 4294967291;
         star$field = new int();
      }
      
      public function get hasStar() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set star(param1:int) : void
      {
         hasField$0 |= 4;
         star$field = param1;
      }
      
      public function get star() : int
      {
         return star$field;
      }
      
      public function removeStrengthen() : void
      {
         hasField$0 &= 4294967287;
         strengthen$field = new int();
      }
      
      public function get hasStrengthen() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set strengthen(param1:int) : void
      {
         hasField$0 |= 8;
         strengthen$field = param1;
      }
      
      public function get strengthen() : int
      {
         return strengthen$field;
      }
      
      public function removeReform() : void
      {
         hasField$0 &= 4294967279;
         reform$field = new int();
      }
      
      public function get hasReform() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set reform(param1:int) : void
      {
         hasField$0 |= 16;
         reform$field = param1;
      }
      
      public function get reform() : int
      {
         return reform$field;
      }
      
      public function removeLearnSkill() : void
      {
         hasField$0 &= 4294967263;
         learnSkill$field = new int();
      }
      
      public function get hasLearnSkill() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set learnSkill(param1:int) : void
      {
         hasField$0 |= 32;
         learnSkill$field = param1;
      }
      
      public function get learnSkill() : int
      {
         return learnSkill$field;
      }
      
      public function removeRamdomSkills() : void
      {
         ramdomSkills$field = null;
      }
      
      public function get hasRamdomSkills() : Boolean
      {
         return ramdomSkills$field != null;
      }
      
      public function set ramdomSkills(param1:String) : void
      {
         ramdomSkills$field = param1;
      }
      
      public function get ramdomSkills() : String
      {
         return ramdomSkills$field;
      }
      
      public function removeReformBuff() : void
      {
         reformBuff$field = null;
      }
      
      public function get hasReformBuff() : Boolean
      {
         return reformBuff$field != null;
      }
      
      public function set reformBuff(param1:String) : void
      {
         reformBuff$field = param1;
      }
      
      public function get reformBuff() : String
      {
         return reformBuff$field;
      }
      
      public function removeIsEquip() : void
      {
         hasField$0 &= 4294967231;
         isEquip$field = new Boolean();
      }
      
      public function get hasIsEquip() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set isEquip(param1:Boolean) : void
      {
         hasField$0 |= 64;
         isEquip$field = param1;
      }
      
      public function get isEquip() : Boolean
      {
         return isEquip$field;
      }
      
      public function removeIsExist() : void
      {
         hasField$0 &= 4294967167;
         isExist$field = new Boolean();
      }
      
      public function get hasIsExist() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set isExist(param1:Boolean) : void
      {
         hasField$0 |= 128;
         isExist$field = param1;
      }
      
      public function get isExist() : Boolean
      {
         return isExist$field;
      }
      
      public function removeCount() : void
      {
         hasField$0 &= 4294967039;
         count$field = new int();
      }
      
      public function get hasCount() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set count(param1:int) : void
      {
         hasField$0 |= 256;
         count$field = param1;
      }
      
      public function get count() : int
      {
         return count$field;
      }
      
      public function removeNewLearnSkill() : void
      {
         hasField$0 &= 4294966783;
         newLearnSkill$field = new int();
      }
      
      public function get hasNewLearnSkill() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set newLearnSkill(param1:int) : void
      {
         hasField$0 |= 512;
         newLearnSkill$field = param1;
      }
      
      public function get newLearnSkill() : int
      {
         return newLearnSkill$field;
      }
      
      public function removeIsLock() : void
      {
         hasField$0 &= 4294966271;
         isLock$field = new Boolean();
      }
      
      public function get hasIsLock() : Boolean
      {
         return (hasField$0 & 0x0400) != 0;
      }
      
      public function set isLock(param1:Boolean) : void
      {
         hasField$0 |= 1024;
         isLock$field = param1;
      }
      
      public function get isLock() : Boolean
      {
         return isLock$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,id$field);
         }
         if(hasWarSoulId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,warSoulId$field);
         }
         if(hasStar)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,star$field);
         }
         if(hasStrengthen)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,strengthen$field);
         }
         if(hasReform)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,reform$field);
         }
         if(hasLearnSkill)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,learnSkill$field);
         }
         if(hasRamdomSkills)
         {
            WriteUtils.writeTag(param1,2,7);
            WriteUtils.write$TYPE_STRING(param1,ramdomSkills$field);
         }
         if(hasReformBuff)
         {
            WriteUtils.writeTag(param1,2,8);
            WriteUtils.write$TYPE_STRING(param1,reformBuff$field);
         }
         if(hasIsEquip)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_BOOL(param1,isEquip$field);
         }
         if(hasIsExist)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_BOOL(param1,isExist$field);
         }
         if(hasCount)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,count$field);
         }
         if(hasNewLearnSkill)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_INT32(param1,newLearnSkill$field);
         }
         if(hasIsLock)
         {
            WriteUtils.writeTag(param1,0,13);
            WriteUtils.write$TYPE_BOOL(param1,isLock$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc16_:* = 0;
         var _loc5_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc13_:uint = 0;
         var _loc8_:uint = 0;
         var _loc7_:uint = 0;
         var _loc11_:uint = 0;
         var _loc15_:uint = 0;
         var _loc14_:uint = 0;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         var _loc6_:uint = 0;
         var _loc12_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc16_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: WarSoulMsg.id cannot be set twice.");
                  }
                  _loc5_++;
                  id = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: WarSoulMsg.warSoulId cannot be set twice.");
                  }
                  _loc9_++;
                  warSoulId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: WarSoulMsg.star cannot be set twice.");
                  }
                  _loc10_++;
                  star = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: WarSoulMsg.strengthen cannot be set twice.");
                  }
                  _loc13_++;
                  strengthen = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: WarSoulMsg.reform cannot be set twice.");
                  }
                  _loc8_++;
                  reform = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: WarSoulMsg.learnSkill cannot be set twice.");
                  }
                  _loc7_++;
                  learnSkill = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: WarSoulMsg.ramdomSkills cannot be set twice.");
                  }
                  _loc11_++;
                  ramdomSkills = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 7:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: WarSoulMsg.reformBuff cannot be set twice.");
                  }
                  _loc15_++;
                  reformBuff = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 8:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: WarSoulMsg.isEquip cannot be set twice.");
                  }
                  _loc14_++;
                  isEquip = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 9:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: WarSoulMsg.isExist cannot be set twice.");
                  }
                  _loc4_++;
                  isExist = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 10:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: WarSoulMsg.count cannot be set twice.");
                  }
                  _loc3_++;
                  count = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 11:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: WarSoulMsg.newLearnSkill cannot be set twice.");
                  }
                  _loc6_++;
                  newLearnSkill = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 12:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: WarSoulMsg.isLock cannot be set twice.");
                  }
                  _loc12_++;
                  isLock = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc16_ & 7);
            }
         }
      }
   }
}

