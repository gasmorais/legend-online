package com.road.yishi.proto.children
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class SpiritInfoMsg extends Message implements IExternalizable
   {
      
      private var childId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var resiGrade$field:int;
      
      private var resiGp$field:int;
      
      private var reduceResiGrade$field:int;
      
      private var reduceResiGp$field:int;
      
      private var jobTypeA$field:int;
      
      private var skillA$field:String;
      
      private var skillBookA$field:String;
      
      private var jobTypeB$field:int;
      
      private var skillB$field:String;
      
      private var skillBookB$field:String;
      
      private var lifeWheel$field:LifeWheelInfoMsg;
      
      private var talentPoint$field:int;
      
      private var talentGrade$field:int;
      
      private var talentGp$field:int;
      
      private var talentSkill$field:String;
      
      private var awakeGrade$field:int;
      
      private var awakeGp$field:int;
      
      private var artifact$field:SpiritArtifactInfoMsg;
      
      private var trainInfo$field:SpiritTrainInfoMsg;
      
      public function SpiritInfoMsg()
      {
         super();
      }
      
      public function removeChildId() : void
      {
         hasField$0 &= 4294967294;
         childId$field = new int();
      }
      
      public function get hasChildId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set childId(param1:int) : void
      {
         hasField$0 |= 1;
         childId$field = param1;
      }
      
      public function get childId() : int
      {
         return childId$field;
      }
      
      public function removeResiGrade() : void
      {
         hasField$0 &= 4294967293;
         resiGrade$field = new int();
      }
      
      public function get hasResiGrade() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set resiGrade(param1:int) : void
      {
         hasField$0 |= 2;
         resiGrade$field = param1;
      }
      
      public function get resiGrade() : int
      {
         return resiGrade$field;
      }
      
      public function removeResiGp() : void
      {
         hasField$0 &= 4294967291;
         resiGp$field = new int();
      }
      
      public function get hasResiGp() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set resiGp(param1:int) : void
      {
         hasField$0 |= 4;
         resiGp$field = param1;
      }
      
      public function get resiGp() : int
      {
         return resiGp$field;
      }
      
      public function removeReduceResiGrade() : void
      {
         hasField$0 &= 4294967287;
         reduceResiGrade$field = new int();
      }
      
      public function get hasReduceResiGrade() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set reduceResiGrade(param1:int) : void
      {
         hasField$0 |= 8;
         reduceResiGrade$field = param1;
      }
      
      public function get reduceResiGrade() : int
      {
         return reduceResiGrade$field;
      }
      
      public function removeReduceResiGp() : void
      {
         hasField$0 &= 4294967279;
         reduceResiGp$field = new int();
      }
      
      public function get hasReduceResiGp() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set reduceResiGp(param1:int) : void
      {
         hasField$0 |= 16;
         reduceResiGp$field = param1;
      }
      
      public function get reduceResiGp() : int
      {
         return reduceResiGp$field;
      }
      
      public function removeJobTypeA() : void
      {
         hasField$0 &= 4294967263;
         jobTypeA$field = new int();
      }
      
      public function get hasJobTypeA() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set jobTypeA(param1:int) : void
      {
         hasField$0 |= 32;
         jobTypeA$field = param1;
      }
      
      public function get jobTypeA() : int
      {
         return jobTypeA$field;
      }
      
      public function removeSkillA() : void
      {
         skillA$field = null;
      }
      
      public function get hasSkillA() : Boolean
      {
         return skillA$field != null;
      }
      
      public function set skillA(param1:String) : void
      {
         skillA$field = param1;
      }
      
      public function get skillA() : String
      {
         return skillA$field;
      }
      
      public function removeSkillBookA() : void
      {
         skillBookA$field = null;
      }
      
      public function get hasSkillBookA() : Boolean
      {
         return skillBookA$field != null;
      }
      
      public function set skillBookA(param1:String) : void
      {
         skillBookA$field = param1;
      }
      
      public function get skillBookA() : String
      {
         return skillBookA$field;
      }
      
      public function removeJobTypeB() : void
      {
         hasField$0 &= 4294967231;
         jobTypeB$field = new int();
      }
      
      public function get hasJobTypeB() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set jobTypeB(param1:int) : void
      {
         hasField$0 |= 64;
         jobTypeB$field = param1;
      }
      
      public function get jobTypeB() : int
      {
         return jobTypeB$field;
      }
      
      public function removeSkillB() : void
      {
         skillB$field = null;
      }
      
      public function get hasSkillB() : Boolean
      {
         return skillB$field != null;
      }
      
      public function set skillB(param1:String) : void
      {
         skillB$field = param1;
      }
      
      public function get skillB() : String
      {
         return skillB$field;
      }
      
      public function removeSkillBookB() : void
      {
         skillBookB$field = null;
      }
      
      public function get hasSkillBookB() : Boolean
      {
         return skillBookB$field != null;
      }
      
      public function set skillBookB(param1:String) : void
      {
         skillBookB$field = param1;
      }
      
      public function get skillBookB() : String
      {
         return skillBookB$field;
      }
      
      public function removeLifeWheel() : void
      {
         lifeWheel$field = null;
      }
      
      public function get hasLifeWheel() : Boolean
      {
         return lifeWheel$field != null;
      }
      
      public function set lifeWheel(param1:LifeWheelInfoMsg) : void
      {
         lifeWheel$field = param1;
      }
      
      public function get lifeWheel() : LifeWheelInfoMsg
      {
         return lifeWheel$field;
      }
      
      public function removeTalentPoint() : void
      {
         hasField$0 &= 4294967167;
         talentPoint$field = new int();
      }
      
      public function get hasTalentPoint() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set talentPoint(param1:int) : void
      {
         hasField$0 |= 128;
         talentPoint$field = param1;
      }
      
      public function get talentPoint() : int
      {
         return talentPoint$field;
      }
      
      public function removeTalentGrade() : void
      {
         hasField$0 &= 4294967039;
         talentGrade$field = new int();
      }
      
      public function get hasTalentGrade() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set talentGrade(param1:int) : void
      {
         hasField$0 |= 256;
         talentGrade$field = param1;
      }
      
      public function get talentGrade() : int
      {
         return talentGrade$field;
      }
      
      public function removeTalentGp() : void
      {
         hasField$0 &= 4294966783;
         talentGp$field = new int();
      }
      
      public function get hasTalentGp() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set talentGp(param1:int) : void
      {
         hasField$0 |= 512;
         talentGp$field = param1;
      }
      
      public function get talentGp() : int
      {
         return talentGp$field;
      }
      
      public function removeTalentSkill() : void
      {
         talentSkill$field = null;
      }
      
      public function get hasTalentSkill() : Boolean
      {
         return talentSkill$field != null;
      }
      
      public function set talentSkill(param1:String) : void
      {
         talentSkill$field = param1;
      }
      
      public function get talentSkill() : String
      {
         return talentSkill$field;
      }
      
      public function removeAwakeGrade() : void
      {
         hasField$0 &= 4294966271;
         awakeGrade$field = new int();
      }
      
      public function get hasAwakeGrade() : Boolean
      {
         return (hasField$0 & 0x0400) != 0;
      }
      
      public function set awakeGrade(param1:int) : void
      {
         hasField$0 |= 1024;
         awakeGrade$field = param1;
      }
      
      public function get awakeGrade() : int
      {
         return awakeGrade$field;
      }
      
      public function removeAwakeGp() : void
      {
         hasField$0 &= 4294965247;
         awakeGp$field = new int();
      }
      
      public function get hasAwakeGp() : Boolean
      {
         return (hasField$0 & 0x0800) != 0;
      }
      
      public function set awakeGp(param1:int) : void
      {
         hasField$0 |= 2048;
         awakeGp$field = param1;
      }
      
      public function get awakeGp() : int
      {
         return awakeGp$field;
      }
      
      public function removeArtifact() : void
      {
         artifact$field = null;
      }
      
      public function get hasArtifact() : Boolean
      {
         return artifact$field != null;
      }
      
      public function set artifact(param1:SpiritArtifactInfoMsg) : void
      {
         artifact$field = param1;
      }
      
      public function get artifact() : SpiritArtifactInfoMsg
      {
         return artifact$field;
      }
      
      public function removeTrainInfo() : void
      {
         trainInfo$field = null;
      }
      
      public function get hasTrainInfo() : Boolean
      {
         return trainInfo$field != null;
      }
      
      public function set trainInfo(param1:SpiritTrainInfoMsg) : void
      {
         trainInfo$field = param1;
      }
      
      public function get trainInfo() : SpiritTrainInfoMsg
      {
         return trainInfo$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasChildId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,childId$field);
         }
         if(hasResiGrade)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,resiGrade$field);
         }
         if(hasResiGp)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,resiGp$field);
         }
         if(hasReduceResiGrade)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,reduceResiGrade$field);
         }
         if(hasReduceResiGp)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,reduceResiGp$field);
         }
         if(hasJobTypeA)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,jobTypeA$field);
         }
         if(hasSkillA)
         {
            WriteUtils.writeTag(param1,2,7);
            WriteUtils.write$TYPE_STRING(param1,skillA$field);
         }
         if(hasSkillBookA)
         {
            WriteUtils.writeTag(param1,2,8);
            WriteUtils.write$TYPE_STRING(param1,skillBookA$field);
         }
         if(hasJobTypeB)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,jobTypeB$field);
         }
         if(hasSkillB)
         {
            WriteUtils.writeTag(param1,2,10);
            WriteUtils.write$TYPE_STRING(param1,skillB$field);
         }
         if(hasSkillBookB)
         {
            WriteUtils.writeTag(param1,2,11);
            WriteUtils.write$TYPE_STRING(param1,skillBookB$field);
         }
         if(hasLifeWheel)
         {
            WriteUtils.writeTag(param1,2,12);
            WriteUtils.write$TYPE_MESSAGE(param1,lifeWheel$field);
         }
         if(hasTalentPoint)
         {
            WriteUtils.writeTag(param1,0,13);
            WriteUtils.write$TYPE_INT32(param1,talentPoint$field);
         }
         if(hasTalentGrade)
         {
            WriteUtils.writeTag(param1,0,14);
            WriteUtils.write$TYPE_INT32(param1,talentGrade$field);
         }
         if(hasTalentGp)
         {
            WriteUtils.writeTag(param1,0,15);
            WriteUtils.write$TYPE_INT32(param1,talentGp$field);
         }
         if(hasTalentSkill)
         {
            WriteUtils.writeTag(param1,2,16);
            WriteUtils.write$TYPE_STRING(param1,talentSkill$field);
         }
         if(hasAwakeGrade)
         {
            WriteUtils.writeTag(param1,0,17);
            WriteUtils.write$TYPE_INT32(param1,awakeGrade$field);
         }
         if(hasAwakeGp)
         {
            WriteUtils.writeTag(param1,0,18);
            WriteUtils.write$TYPE_INT32(param1,awakeGp$field);
         }
         if(hasArtifact)
         {
            WriteUtils.writeTag(param1,2,19);
            WriteUtils.write$TYPE_MESSAGE(param1,artifact$field);
         }
         if(hasTrainInfo)
         {
            WriteUtils.writeTag(param1,2,20);
            WriteUtils.write$TYPE_MESSAGE(param1,trainInfo$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc21_:* = 0;
         var _loc20_:uint = 0;
         var _loc6_:uint = 0;
         var _loc18_:uint = 0;
         var _loc17_:uint = 0;
         var _loc11_:uint = 0;
         var _loc12_:uint = 0;
         var _loc15_:uint = 0;
         var _loc22_:uint = 0;
         var _loc19_:uint = 0;
         var _loc13_:uint = 0;
         var _loc7_:uint = 0;
         var _loc4_:uint = 0;
         var _loc8_:uint = 0;
         var _loc23_:uint = 0;
         var _loc5_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc14_:uint = 0;
         var _loc3_:uint = 0;
         var _loc16_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch((_loc21_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3)
            {
               case 1:
                  if(_loc20_ != 0)
                  {
                     throw new IOError("Bad data format: SpiritInfoMsg.childId cannot be set twice.");
                  }
                  _loc20_++;
                  childId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: SpiritInfoMsg.resiGrade cannot be set twice.");
                  }
                  _loc6_++;
                  resiGrade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc18_ != 0)
                  {
                     throw new IOError("Bad data format: SpiritInfoMsg.resiGp cannot be set twice.");
                  }
                  _loc18_++;
                  resiGp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc17_ != 0)
                  {
                     throw new IOError("Bad data format: SpiritInfoMsg.reduceResiGrade cannot be set twice.");
                  }
                  _loc17_++;
                  reduceResiGrade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: SpiritInfoMsg.reduceResiGp cannot be set twice.");
                  }
                  _loc11_++;
                  reduceResiGp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: SpiritInfoMsg.jobTypeA cannot be set twice.");
                  }
                  _loc12_++;
                  jobTypeA = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: SpiritInfoMsg.skillA cannot be set twice.");
                  }
                  _loc15_++;
                  skillA = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 8:
                  if(_loc22_ != 0)
                  {
                     throw new IOError("Bad data format: SpiritInfoMsg.skillBookA cannot be set twice.");
                  }
                  _loc22_++;
                  skillBookA = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 9:
                  if(_loc19_ != 0)
                  {
                     throw new IOError("Bad data format: SpiritInfoMsg.jobTypeB cannot be set twice.");
                  }
                  _loc19_++;
                  jobTypeB = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: SpiritInfoMsg.skillB cannot be set twice.");
                  }
                  _loc13_++;
                  skillB = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 11:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: SpiritInfoMsg.skillBookB cannot be set twice.");
                  }
                  _loc7_++;
                  skillBookB = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 12:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: SpiritInfoMsg.lifeWheel cannot be set twice.");
                  }
                  _loc4_++;
                  lifeWheel = new LifeWheelInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,lifeWheel);
                  break;
               case 13:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: SpiritInfoMsg.talentPoint cannot be set twice.");
                  }
                  _loc8_++;
                  talentPoint = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 14:
                  if(_loc23_ != 0)
                  {
                     throw new IOError("Bad data format: SpiritInfoMsg.talentGrade cannot be set twice.");
                  }
                  _loc23_++;
                  talentGrade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 15:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: SpiritInfoMsg.talentGp cannot be set twice.");
                  }
                  _loc5_++;
                  talentGp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 16:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: SpiritInfoMsg.talentSkill cannot be set twice.");
                  }
                  _loc9_++;
                  talentSkill = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 17:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: SpiritInfoMsg.awakeGrade cannot be set twice.");
                  }
                  _loc10_++;
                  awakeGrade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 18:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: SpiritInfoMsg.awakeGp cannot be set twice.");
                  }
                  _loc14_++;
                  awakeGp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 19:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: SpiritInfoMsg.artifact cannot be set twice.");
                  }
                  _loc3_++;
                  artifact = new SpiritArtifactInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,artifact);
                  break;
               case 20:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: SpiritInfoMsg.trainInfo cannot be set twice.");
                  }
                  _loc16_++;
                  trainInfo = new SpiritTrainInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,trainInfo);
                  break;
               default:
                  ReadUtils.skip(param1,_loc21_ & 7);
            }
         }
      }
   }
}

