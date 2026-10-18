package com.road.yishi.proto.gamebox
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class LastDitchMsg extends Message implements IExternalizable
   {
      
      private var ditchTempId1$field:int;
      
      private var hasField$0:uint = 0;
      
      private var ditchTempId2$field:int;
      
      private var ditchTempId3$field:int;
      
      private var ditchTempId4$field:int;
      
      private var skillCount1$field:int;
      
      private var skillCount2$field:int;
      
      private var skillCount3$field:int;
      
      private var energy$field:int;
      
      private var score$field:int;
      
      private var boxTakeMark$field:int;
      
      private var rounds$field:int;
      
      private var op$field:int;
      
      private var boxId$field:int;
      
      private var skillIndex$field:int;
      
      private var npcIndex$field:int;
      
      private var nextTempIndex$field:int;
      
      private var id$field:int;
      
      [ArrayElementType("com.road.yishi.proto.gamebox.DitchNpcInfoMsg")]
      public var ditchNpcInfo:Array = [];
      
      public function LastDitchMsg()
      {
         super();
      }
      
      public function removeDitchTempId1() : void
      {
         hasField$0 &= 4294967294;
         ditchTempId1$field = new int();
      }
      
      public function get hasDitchTempId1() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set ditchTempId1(param1:int) : void
      {
         hasField$0 |= 1;
         ditchTempId1$field = param1;
      }
      
      public function get ditchTempId1() : int
      {
         return ditchTempId1$field;
      }
      
      public function removeDitchTempId2() : void
      {
         hasField$0 &= 4294967293;
         ditchTempId2$field = new int();
      }
      
      public function get hasDitchTempId2() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set ditchTempId2(param1:int) : void
      {
         hasField$0 |= 2;
         ditchTempId2$field = param1;
      }
      
      public function get ditchTempId2() : int
      {
         return ditchTempId2$field;
      }
      
      public function removeDitchTempId3() : void
      {
         hasField$0 &= 4294967291;
         ditchTempId3$field = new int();
      }
      
      public function get hasDitchTempId3() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set ditchTempId3(param1:int) : void
      {
         hasField$0 |= 4;
         ditchTempId3$field = param1;
      }
      
      public function get ditchTempId3() : int
      {
         return ditchTempId3$field;
      }
      
      public function removeDitchTempId4() : void
      {
         hasField$0 &= 4294967287;
         ditchTempId4$field = new int();
      }
      
      public function get hasDitchTempId4() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set ditchTempId4(param1:int) : void
      {
         hasField$0 |= 8;
         ditchTempId4$field = param1;
      }
      
      public function get ditchTempId4() : int
      {
         return ditchTempId4$field;
      }
      
      public function removeSkillCount1() : void
      {
         hasField$0 &= 4294967279;
         skillCount1$field = new int();
      }
      
      public function get hasSkillCount1() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set skillCount1(param1:int) : void
      {
         hasField$0 |= 16;
         skillCount1$field = param1;
      }
      
      public function get skillCount1() : int
      {
         return skillCount1$field;
      }
      
      public function removeSkillCount2() : void
      {
         hasField$0 &= 4294967263;
         skillCount2$field = new int();
      }
      
      public function get hasSkillCount2() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set skillCount2(param1:int) : void
      {
         hasField$0 |= 32;
         skillCount2$field = param1;
      }
      
      public function get skillCount2() : int
      {
         return skillCount2$field;
      }
      
      public function removeSkillCount3() : void
      {
         hasField$0 &= 4294967231;
         skillCount3$field = new int();
      }
      
      public function get hasSkillCount3() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set skillCount3(param1:int) : void
      {
         hasField$0 |= 64;
         skillCount3$field = param1;
      }
      
      public function get skillCount3() : int
      {
         return skillCount3$field;
      }
      
      public function removeEnergy() : void
      {
         hasField$0 &= 4294967167;
         energy$field = new int();
      }
      
      public function get hasEnergy() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set energy(param1:int) : void
      {
         hasField$0 |= 128;
         energy$field = param1;
      }
      
      public function get energy() : int
      {
         return energy$field;
      }
      
      public function removeScore() : void
      {
         hasField$0 &= 4294967039;
         score$field = new int();
      }
      
      public function get hasScore() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set score(param1:int) : void
      {
         hasField$0 |= 256;
         score$field = param1;
      }
      
      public function get score() : int
      {
         return score$field;
      }
      
      public function removeBoxTakeMark() : void
      {
         hasField$0 &= 4294966783;
         boxTakeMark$field = new int();
      }
      
      public function get hasBoxTakeMark() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set boxTakeMark(param1:int) : void
      {
         hasField$0 |= 512;
         boxTakeMark$field = param1;
      }
      
      public function get boxTakeMark() : int
      {
         return boxTakeMark$field;
      }
      
      public function removeRounds() : void
      {
         hasField$0 &= 4294966271;
         rounds$field = new int();
      }
      
      public function get hasRounds() : Boolean
      {
         return (hasField$0 & 0x0400) != 0;
      }
      
      public function set rounds(param1:int) : void
      {
         hasField$0 |= 1024;
         rounds$field = param1;
      }
      
      public function get rounds() : int
      {
         return rounds$field;
      }
      
      public function removeOp() : void
      {
         hasField$0 &= 4294965247;
         op$field = new int();
      }
      
      public function get hasOp() : Boolean
      {
         return (hasField$0 & 0x0800) != 0;
      }
      
      public function set op(param1:int) : void
      {
         hasField$0 |= 2048;
         op$field = param1;
      }
      
      public function get op() : int
      {
         return op$field;
      }
      
      public function removeBoxId() : void
      {
         hasField$0 &= 4294963199;
         boxId$field = new int();
      }
      
      public function get hasBoxId() : Boolean
      {
         return (hasField$0 & 0x1000) != 0;
      }
      
      public function set boxId(param1:int) : void
      {
         hasField$0 |= 4096;
         boxId$field = param1;
      }
      
      public function get boxId() : int
      {
         return boxId$field;
      }
      
      public function removeSkillIndex() : void
      {
         hasField$0 &= 4294959103;
         skillIndex$field = new int();
      }
      
      public function get hasSkillIndex() : Boolean
      {
         return (hasField$0 & 0x2000) != 0;
      }
      
      public function set skillIndex(param1:int) : void
      {
         hasField$0 |= 8192;
         skillIndex$field = param1;
      }
      
      public function get skillIndex() : int
      {
         return skillIndex$field;
      }
      
      public function removeNpcIndex() : void
      {
         hasField$0 &= 4294950911;
         npcIndex$field = new int();
      }
      
      public function get hasNpcIndex() : Boolean
      {
         return (hasField$0 & 0x4000) != 0;
      }
      
      public function set npcIndex(param1:int) : void
      {
         hasField$0 |= 16384;
         npcIndex$field = param1;
      }
      
      public function get npcIndex() : int
      {
         return npcIndex$field;
      }
      
      public function removeNextTempIndex() : void
      {
         hasField$0 &= 4294934527;
         nextTempIndex$field = new int();
      }
      
      public function get hasNextTempIndex() : Boolean
      {
         return (hasField$0 & 0x8000) != 0;
      }
      
      public function set nextTempIndex(param1:int) : void
      {
         hasField$0 |= 32768;
         nextTempIndex$field = param1;
      }
      
      public function get nextTempIndex() : int
      {
         return nextTempIndex$field;
      }
      
      public function removeId() : void
      {
         hasField$0 &= 4294901759;
         id$field = new int();
      }
      
      public function get hasId() : Boolean
      {
         return (hasField$0 & 0x010000) != 0;
      }
      
      public function set id(param1:int) : void
      {
         hasField$0 |= 65536;
         id$field = param1;
      }
      
      public function get id() : int
      {
         return id$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasDitchTempId1)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,ditchTempId1$field);
         }
         if(hasDitchTempId2)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,ditchTempId2$field);
         }
         if(hasDitchTempId3)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,ditchTempId3$field);
         }
         if(hasDitchTempId4)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,ditchTempId4$field);
         }
         if(hasSkillCount1)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,skillCount1$field);
         }
         if(hasSkillCount2)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,skillCount2$field);
         }
         if(hasSkillCount3)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,skillCount3$field);
         }
         if(hasEnergy)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,energy$field);
         }
         if(hasScore)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,score$field);
         }
         if(hasBoxTakeMark)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,boxTakeMark$field);
         }
         if(hasRounds)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,rounds$field);
         }
         if(hasOp)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_INT32(param1,op$field);
         }
         if(hasBoxId)
         {
            WriteUtils.writeTag(param1,0,13);
            WriteUtils.write$TYPE_INT32(param1,boxId$field);
         }
         if(hasSkillIndex)
         {
            WriteUtils.writeTag(param1,0,14);
            WriteUtils.write$TYPE_INT32(param1,skillIndex$field);
         }
         if(hasNpcIndex)
         {
            WriteUtils.writeTag(param1,0,15);
            WriteUtils.write$TYPE_INT32(param1,npcIndex$field);
         }
         if(hasNextTempIndex)
         {
            WriteUtils.writeTag(param1,0,16);
            WriteUtils.write$TYPE_INT32(param1,nextTempIndex$field);
         }
         if(hasId)
         {
            WriteUtils.writeTag(param1,0,17);
            WriteUtils.write$TYPE_INT32(param1,id$field);
         }
         _loc2_ = 0;
         while(_loc2_ < ditchNpcInfo.length)
         {
            WriteUtils.writeTag(param1,2,18);
            WriteUtils.write$TYPE_MESSAGE(param1,ditchNpcInfo[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc18_:* = 0;
         var _loc13_:DitchNpcInfoMsg = null;
         var _loc14_:uint = 0;
         var _loc9_:uint = 0;
         var _loc11_:uint = 0;
         var _loc3_:uint = 0;
         var _loc15_:uint = 0;
         var _loc12_:uint = 0;
         var _loc17_:uint = 0;
         var _loc19_:uint = 0;
         var _loc20_:uint = 0;
         var _loc10_:uint = 0;
         var _loc6_:uint = 0;
         var _loc21_:uint = 0;
         var _loc5_:uint = 0;
         var _loc8_:uint = 0;
         var _loc16_:uint = 0;
         var _loc4_:uint = 0;
         var _loc7_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc18_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: LastDitchMsg.ditchTempId1 cannot be set twice.");
                  }
                  _loc14_++;
                  ditchTempId1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: LastDitchMsg.ditchTempId2 cannot be set twice.");
                  }
                  _loc9_++;
                  ditchTempId2 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: LastDitchMsg.ditchTempId3 cannot be set twice.");
                  }
                  _loc11_++;
                  ditchTempId3 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: LastDitchMsg.ditchTempId4 cannot be set twice.");
                  }
                  _loc3_++;
                  ditchTempId4 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: LastDitchMsg.skillCount1 cannot be set twice.");
                  }
                  _loc15_++;
                  skillCount1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: LastDitchMsg.skillCount2 cannot be set twice.");
                  }
                  _loc12_++;
                  skillCount2 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc17_ != 0)
                  {
                     throw new IOError("Bad data format: LastDitchMsg.skillCount3 cannot be set twice.");
                  }
                  _loc17_++;
                  skillCount3 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc19_ != 0)
                  {
                     throw new IOError("Bad data format: LastDitchMsg.energy cannot be set twice.");
                  }
                  _loc19_++;
                  energy = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc20_ != 0)
                  {
                     throw new IOError("Bad data format: LastDitchMsg.score cannot be set twice.");
                  }
                  _loc20_++;
                  score = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: LastDitchMsg.boxTakeMark cannot be set twice.");
                  }
                  _loc10_++;
                  boxTakeMark = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: LastDitchMsg.rounds cannot be set twice.");
                  }
                  _loc6_++;
                  rounds = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 11:
                  if(_loc21_ != 0)
                  {
                     throw new IOError("Bad data format: LastDitchMsg.op cannot be set twice.");
                  }
                  _loc21_++;
                  op = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 12:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: LastDitchMsg.boxId cannot be set twice.");
                  }
                  _loc5_++;
                  boxId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 13:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: LastDitchMsg.skillIndex cannot be set twice.");
                  }
                  _loc8_++;
                  skillIndex = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 14:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: LastDitchMsg.npcIndex cannot be set twice.");
                  }
                  _loc16_++;
                  npcIndex = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 15:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: LastDitchMsg.nextTempIndex cannot be set twice.");
                  }
                  _loc4_++;
                  nextTempIndex = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 16:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: LastDitchMsg.id cannot be set twice.");
                  }
                  _loc7_++;
                  id = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 17:
                  _loc13_ = new DitchNpcInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc13_);
                  ditchNpcInfo.push(_loc13_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc18_ & 7);
            }
         }
      }
   }
}

