package com.road.yishi.proto.titanland
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class TitanlandOpMsg extends Message implements IExternalizable
   {
      
      private var op$field:int;
      
      private var hasField$0:uint = 0;
      
      private var payType$field:int;
      
      private var skillIndex$field:int;
      
      private var fightLeftCount$field:int;
      
      private var fightAddCount$field:int;
      
      private var skillCount1$field:int;
      
      private var skillCount2$field:int;
      
      private var skillCount3$field:int;
      
      private var bossHp1$field:int;
      
      private var bossHp2$field:int;
      
      private var bossHp3$field:int;
      
      private var bossHp4$field:int;
      
      private var curLevel$field:int;
      
      [ArrayElementType("com.road.yishi.proto.titanland.TitanlandBoosMsg")]
      public var bossInfo:Array = [];
      
      private var status$field:int;
      
      public function TitanlandOpMsg()
      {
         super();
      }
      
      public function removeOp() : void
      {
         hasField$0 &= 4294967294;
         op$field = new int();
      }
      
      public function get hasOp() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set op(param1:int) : void
      {
         hasField$0 |= 1;
         op$field = param1;
      }
      
      public function get op() : int
      {
         return op$field;
      }
      
      public function removePayType() : void
      {
         hasField$0 &= 4294967293;
         payType$field = new int();
      }
      
      public function get hasPayType() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set payType(param1:int) : void
      {
         hasField$0 |= 2;
         payType$field = param1;
      }
      
      public function get payType() : int
      {
         return payType$field;
      }
      
      public function removeSkillIndex() : void
      {
         hasField$0 &= 4294967291;
         skillIndex$field = new int();
      }
      
      public function get hasSkillIndex() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set skillIndex(param1:int) : void
      {
         hasField$0 |= 4;
         skillIndex$field = param1;
      }
      
      public function get skillIndex() : int
      {
         return skillIndex$field;
      }
      
      public function removeFightLeftCount() : void
      {
         hasField$0 &= 4294967287;
         fightLeftCount$field = new int();
      }
      
      public function get hasFightLeftCount() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set fightLeftCount(param1:int) : void
      {
         hasField$0 |= 8;
         fightLeftCount$field = param1;
      }
      
      public function get fightLeftCount() : int
      {
         return fightLeftCount$field;
      }
      
      public function removeFightAddCount() : void
      {
         hasField$0 &= 4294967279;
         fightAddCount$field = new int();
      }
      
      public function get hasFightAddCount() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set fightAddCount(param1:int) : void
      {
         hasField$0 |= 16;
         fightAddCount$field = param1;
      }
      
      public function get fightAddCount() : int
      {
         return fightAddCount$field;
      }
      
      public function removeSkillCount1() : void
      {
         hasField$0 &= 4294967263;
         skillCount1$field = new int();
      }
      
      public function get hasSkillCount1() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set skillCount1(param1:int) : void
      {
         hasField$0 |= 32;
         skillCount1$field = param1;
      }
      
      public function get skillCount1() : int
      {
         return skillCount1$field;
      }
      
      public function removeSkillCount2() : void
      {
         hasField$0 &= 4294967231;
         skillCount2$field = new int();
      }
      
      public function get hasSkillCount2() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set skillCount2(param1:int) : void
      {
         hasField$0 |= 64;
         skillCount2$field = param1;
      }
      
      public function get skillCount2() : int
      {
         return skillCount2$field;
      }
      
      public function removeSkillCount3() : void
      {
         hasField$0 &= 4294967167;
         skillCount3$field = new int();
      }
      
      public function get hasSkillCount3() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set skillCount3(param1:int) : void
      {
         hasField$0 |= 128;
         skillCount3$field = param1;
      }
      
      public function get skillCount3() : int
      {
         return skillCount3$field;
      }
      
      public function removeBossHp1() : void
      {
         hasField$0 &= 4294967039;
         bossHp1$field = new int();
      }
      
      public function get hasBossHp1() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set bossHp1(param1:int) : void
      {
         hasField$0 |= 256;
         bossHp1$field = param1;
      }
      
      public function get bossHp1() : int
      {
         return bossHp1$field;
      }
      
      public function removeBossHp2() : void
      {
         hasField$0 &= 4294966783;
         bossHp2$field = new int();
      }
      
      public function get hasBossHp2() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set bossHp2(param1:int) : void
      {
         hasField$0 |= 512;
         bossHp2$field = param1;
      }
      
      public function get bossHp2() : int
      {
         return bossHp2$field;
      }
      
      public function removeBossHp3() : void
      {
         hasField$0 &= 4294966271;
         bossHp3$field = new int();
      }
      
      public function get hasBossHp3() : Boolean
      {
         return (hasField$0 & 0x0400) != 0;
      }
      
      public function set bossHp3(param1:int) : void
      {
         hasField$0 |= 1024;
         bossHp3$field = param1;
      }
      
      public function get bossHp3() : int
      {
         return bossHp3$field;
      }
      
      public function removeBossHp4() : void
      {
         hasField$0 &= 4294965247;
         bossHp4$field = new int();
      }
      
      public function get hasBossHp4() : Boolean
      {
         return (hasField$0 & 0x0800) != 0;
      }
      
      public function set bossHp4(param1:int) : void
      {
         hasField$0 |= 2048;
         bossHp4$field = param1;
      }
      
      public function get bossHp4() : int
      {
         return bossHp4$field;
      }
      
      public function removeCurLevel() : void
      {
         hasField$0 &= 4294963199;
         curLevel$field = new int();
      }
      
      public function get hasCurLevel() : Boolean
      {
         return (hasField$0 & 0x1000) != 0;
      }
      
      public function set curLevel(param1:int) : void
      {
         hasField$0 |= 4096;
         curLevel$field = param1;
      }
      
      public function get curLevel() : int
      {
         return curLevel$field;
      }
      
      public function removeStatus() : void
      {
         hasField$0 &= 4294959103;
         status$field = new int();
      }
      
      public function get hasStatus() : Boolean
      {
         return (hasField$0 & 0x2000) != 0;
      }
      
      public function set status(param1:int) : void
      {
         hasField$0 |= 8192;
         status$field = param1;
      }
      
      public function get status() : int
      {
         return status$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasOp)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_ENUM(param1,op$field);
         }
         if(hasPayType)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,payType$field);
         }
         if(hasSkillIndex)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,skillIndex$field);
         }
         if(hasFightLeftCount)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,fightLeftCount$field);
         }
         if(hasFightAddCount)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,fightAddCount$field);
         }
         if(hasSkillCount1)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,skillCount1$field);
         }
         if(hasSkillCount2)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,skillCount2$field);
         }
         if(hasSkillCount3)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,skillCount3$field);
         }
         if(hasBossHp1)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,bossHp1$field);
         }
         if(hasBossHp2)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,bossHp2$field);
         }
         if(hasBossHp3)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,bossHp3$field);
         }
         if(hasBossHp4)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_INT32(param1,bossHp4$field);
         }
         if(hasCurLevel)
         {
            WriteUtils.writeTag(param1,0,13);
            WriteUtils.write$TYPE_INT32(param1,curLevel$field);
         }
         _loc2_ = 0;
         while(_loc2_ < bossInfo.length)
         {
            WriteUtils.writeTag(param1,2,14);
            WriteUtils.write$TYPE_MESSAGE(param1,bossInfo[_loc2_]);
            _loc2_++;
         }
         if(hasStatus)
         {
            WriteUtils.writeTag(param1,0,15);
            WriteUtils.write$TYPE_INT32(param1,status$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc17_:* = 0;
         var _loc11_:TitanlandBoosMsg = null;
         var _loc18_:uint = 0;
         var _loc13_:uint = 0;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         var _loc7_:uint = 0;
         var _loc10_:uint = 0;
         var _loc5_:uint = 0;
         var _loc16_:uint = 0;
         var _loc12_:uint = 0;
         var _loc9_:uint = 0;
         var _loc14_:uint = 0;
         var _loc8_:uint = 0;
         var _loc15_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc17_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc18_ != 0)
                  {
                     throw new IOError("Bad data format: TitanlandOpMsg.op cannot be set twice.");
                  }
                  _loc18_++;
                  op = ReadUtils.read$TYPE_ENUM(param1);
                  break;
               case 1:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: TitanlandOpMsg.payType cannot be set twice.");
                  }
                  _loc13_++;
                  payType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: TitanlandOpMsg.skillIndex cannot be set twice.");
                  }
                  _loc4_++;
                  skillIndex = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: TitanlandOpMsg.fightLeftCount cannot be set twice.");
                  }
                  _loc3_++;
                  fightLeftCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: TitanlandOpMsg.fightAddCount cannot be set twice.");
                  }
                  _loc7_++;
                  fightAddCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: TitanlandOpMsg.skillCount1 cannot be set twice.");
                  }
                  _loc10_++;
                  skillCount1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: TitanlandOpMsg.skillCount2 cannot be set twice.");
                  }
                  _loc5_++;
                  skillCount2 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: TitanlandOpMsg.skillCount3 cannot be set twice.");
                  }
                  _loc16_++;
                  skillCount3 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: TitanlandOpMsg.bossHp1 cannot be set twice.");
                  }
                  _loc12_++;
                  bossHp1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: TitanlandOpMsg.bossHp2 cannot be set twice.");
                  }
                  _loc9_++;
                  bossHp2 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: TitanlandOpMsg.bossHp3 cannot be set twice.");
                  }
                  _loc14_++;
                  bossHp3 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 11:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: TitanlandOpMsg.bossHp4 cannot be set twice.");
                  }
                  _loc8_++;
                  bossHp4 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 12:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: TitanlandOpMsg.curLevel cannot be set twice.");
                  }
                  _loc15_++;
                  curLevel = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 13:
                  _loc11_ = new TitanlandBoosMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc11_);
                  bossInfo.push(_loc11_);
                  break;
               case 14:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: TitanlandOpMsg.status cannot be set twice.");
                  }
                  _loc6_++;
                  status = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc17_ & 7);
            }
         }
      }
   }
}

