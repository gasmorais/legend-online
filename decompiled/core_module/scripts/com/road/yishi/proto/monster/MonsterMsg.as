package com.road.yishi.proto.monster
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class MonsterMsg extends Message implements IExternalizable
   {
      
      private var monsterId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var name$field:String;
      
      private var type$field:int;
      
      private var star$field:int;
      
      private var level$field:int;
      
      private var exp$field:int;
      
      private var stageLevel$field:int;
      
      private var stateExp$field:int;
      
      private var fightPower$field:int;
      
      private var skills$field:String;
      
      private var first$field:int;
      
      private var isFight$field:Boolean;
      
      private var isLock$field:Boolean;
      
      private var isExist$field:Boolean;
      
      private var isFollow$field:Boolean;
      
      public function MonsterMsg()
      {
         super();
      }
      
      public function removeMonsterId() : void
      {
         hasField$0 &= 4294967294;
         monsterId$field = new int();
      }
      
      public function get hasMonsterId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set monsterId(param1:int) : void
      {
         hasField$0 |= 1;
         monsterId$field = param1;
      }
      
      public function get monsterId() : int
      {
         return monsterId$field;
      }
      
      public function removeName() : void
      {
         name$field = null;
      }
      
      public function get hasName() : Boolean
      {
         return name$field != null;
      }
      
      public function set name(param1:String) : void
      {
         name$field = param1;
      }
      
      public function get name() : String
      {
         return name$field;
      }
      
      public function removeType() : void
      {
         hasField$0 &= 4294967293;
         type$field = new int();
      }
      
      public function get hasType() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set type(param1:int) : void
      {
         hasField$0 |= 2;
         type$field = param1;
      }
      
      public function get type() : int
      {
         return type$field;
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
      
      public function removeLevel() : void
      {
         hasField$0 &= 4294967287;
         level$field = new int();
      }
      
      public function get hasLevel() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set level(param1:int) : void
      {
         hasField$0 |= 8;
         level$field = param1;
      }
      
      public function get level() : int
      {
         return level$field;
      }
      
      public function removeExp() : void
      {
         hasField$0 &= 4294967279;
         exp$field = new int();
      }
      
      public function get hasExp() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set exp(param1:int) : void
      {
         hasField$0 |= 16;
         exp$field = param1;
      }
      
      public function get exp() : int
      {
         return exp$field;
      }
      
      public function removeStageLevel() : void
      {
         hasField$0 &= 4294967263;
         stageLevel$field = new int();
      }
      
      public function get hasStageLevel() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set stageLevel(param1:int) : void
      {
         hasField$0 |= 32;
         stageLevel$field = param1;
      }
      
      public function get stageLevel() : int
      {
         return stageLevel$field;
      }
      
      public function removeStateExp() : void
      {
         hasField$0 &= 4294967231;
         stateExp$field = new int();
      }
      
      public function get hasStateExp() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set stateExp(param1:int) : void
      {
         hasField$0 |= 64;
         stateExp$field = param1;
      }
      
      public function get stateExp() : int
      {
         return stateExp$field;
      }
      
      public function removeFightPower() : void
      {
         hasField$0 &= 4294967167;
         fightPower$field = new int();
      }
      
      public function get hasFightPower() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set fightPower(param1:int) : void
      {
         hasField$0 |= 128;
         fightPower$field = param1;
      }
      
      public function get fightPower() : int
      {
         return fightPower$field;
      }
      
      public function removeSkills() : void
      {
         skills$field = null;
      }
      
      public function get hasSkills() : Boolean
      {
         return skills$field != null;
      }
      
      public function set skills(param1:String) : void
      {
         skills$field = param1;
      }
      
      public function get skills() : String
      {
         return skills$field;
      }
      
      public function removeFirst() : void
      {
         hasField$0 &= 4294967039;
         first$field = new int();
      }
      
      public function get hasFirst() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set first(param1:int) : void
      {
         hasField$0 |= 256;
         first$field = param1;
      }
      
      public function get first() : int
      {
         return first$field;
      }
      
      public function removeIsFight() : void
      {
         hasField$0 &= 4294966783;
         isFight$field = new Boolean();
      }
      
      public function get hasIsFight() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set isFight(param1:Boolean) : void
      {
         hasField$0 |= 512;
         isFight$field = param1;
      }
      
      public function get isFight() : Boolean
      {
         return isFight$field;
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
      
      public function removeIsExist() : void
      {
         hasField$0 &= 4294965247;
         isExist$field = new Boolean();
      }
      
      public function get hasIsExist() : Boolean
      {
         return (hasField$0 & 0x0800) != 0;
      }
      
      public function set isExist(param1:Boolean) : void
      {
         hasField$0 |= 2048;
         isExist$field = param1;
      }
      
      public function get isExist() : Boolean
      {
         return isExist$field;
      }
      
      public function removeIsFollow() : void
      {
         hasField$0 &= 4294963199;
         isFollow$field = new Boolean();
      }
      
      public function get hasIsFollow() : Boolean
      {
         return (hasField$0 & 0x1000) != 0;
      }
      
      public function set isFollow(param1:Boolean) : void
      {
         hasField$0 |= 4096;
         isFollow$field = param1;
      }
      
      public function get isFollow() : Boolean
      {
         return isFollow$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasMonsterId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,monsterId$field);
         }
         if(hasName)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,name$field);
         }
         if(hasType)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,type$field);
         }
         if(hasStar)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,star$field);
         }
         if(hasLevel)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,level$field);
         }
         if(hasExp)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,exp$field);
         }
         if(hasStageLevel)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,stageLevel$field);
         }
         if(hasStateExp)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,stateExp$field);
         }
         if(hasFightPower)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,fightPower$field);
         }
         if(hasSkills)
         {
            WriteUtils.writeTag(param1,2,10);
            WriteUtils.write$TYPE_STRING(param1,skills$field);
         }
         if(hasFirst)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,first$field);
         }
         if(hasIsFight)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_BOOL(param1,isFight$field);
         }
         if(hasIsLock)
         {
            WriteUtils.writeTag(param1,0,13);
            WriteUtils.write$TYPE_BOOL(param1,isLock$field);
         }
         if(hasIsExist)
         {
            WriteUtils.writeTag(param1,0,14);
            WriteUtils.write$TYPE_BOOL(param1,isExist$field);
         }
         if(hasIsFollow)
         {
            WriteUtils.writeTag(param1,0,15);
            WriteUtils.write$TYPE_BOOL(param1,isFollow$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc16_:* = 0;
         var _loc18_:uint = 0;
         var _loc12_:uint = 0;
         var _loc6_:uint = 0;
         var _loc13_:uint = 0;
         var _loc3_:uint = 0;
         var _loc14_:uint = 0;
         var _loc11_:uint = 0;
         var _loc7_:uint = 0;
         var _loc4_:uint = 0;
         var _loc8_:uint = 0;
         var _loc17_:uint = 0;
         var _loc10_:uint = 0;
         var _loc15_:uint = 0;
         var _loc5_:uint = 0;
         var _loc9_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc16_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc18_ != 0)
                  {
                     throw new IOError("Bad data format: MonsterMsg.monsterId cannot be set twice.");
                  }
                  _loc18_++;
                  monsterId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: MonsterMsg.name cannot be set twice.");
                  }
                  _loc12_++;
                  name = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: MonsterMsg.type cannot be set twice.");
                  }
                  _loc6_++;
                  type = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: MonsterMsg.star cannot be set twice.");
                  }
                  _loc13_++;
                  star = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: MonsterMsg.level cannot be set twice.");
                  }
                  _loc3_++;
                  level = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: MonsterMsg.exp cannot be set twice.");
                  }
                  _loc14_++;
                  exp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: MonsterMsg.stageLevel cannot be set twice.");
                  }
                  _loc11_++;
                  stageLevel = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: MonsterMsg.stateExp cannot be set twice.");
                  }
                  _loc7_++;
                  stateExp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: MonsterMsg.fightPower cannot be set twice.");
                  }
                  _loc4_++;
                  fightPower = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: MonsterMsg.skills cannot be set twice.");
                  }
                  _loc8_++;
                  skills = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 10:
                  if(_loc17_ != 0)
                  {
                     throw new IOError("Bad data format: MonsterMsg.first cannot be set twice.");
                  }
                  _loc17_++;
                  first = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 11:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: MonsterMsg.isFight cannot be set twice.");
                  }
                  _loc10_++;
                  isFight = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 12:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: MonsterMsg.isLock cannot be set twice.");
                  }
                  _loc15_++;
                  isLock = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 13:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: MonsterMsg.isExist cannot be set twice.");
                  }
                  _loc5_++;
                  isExist = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 14:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: MonsterMsg.isFollow cannot be set twice.");
                  }
                  _loc9_++;
                  isFollow = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc16_ & 7);
            }
         }
      }
   }
}

