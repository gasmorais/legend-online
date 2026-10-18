package com.road.yishi.proto.christmas
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class SnowyMistTeamPlayerMsg extends Message implements IExternalizable
   {
      
      private var userId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var nickName$field:String;
      
      private var grade$field:int;
      
      private var headId$field:int;
      
      private var consortiaName$field:String;
      
      private var arm$field:String;
      
      private var cloth$field:String;
      
      private var wing$field:String;
      
      private var hat$field:String;
      
      private var sex$field:int;
      
      private var job$field:int;
      
      private var templateId$field:int;
      
      private var fashionArm$field:String;
      
      private var fashionCloth$field:String;
      
      private var hideFashion$field:Boolean;
      
      private var isDragonTalker$field:Boolean;
      
      private var energy$field:int;
      
      private var myPoint$field:int;
      
      private var isBossReward$field:Boolean;
      
      public function SnowyMistTeamPlayerMsg()
      {
         super();
      }
      
      public function removeUserId() : void
      {
         hasField$0 &= 4294967294;
         userId$field = new int();
      }
      
      public function get hasUserId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set userId(param1:int) : void
      {
         hasField$0 |= 1;
         userId$field = param1;
      }
      
      public function get userId() : int
      {
         return userId$field;
      }
      
      public function removeNickName() : void
      {
         nickName$field = null;
      }
      
      public function get hasNickName() : Boolean
      {
         return nickName$field != null;
      }
      
      public function set nickName(param1:String) : void
      {
         nickName$field = param1;
      }
      
      public function get nickName() : String
      {
         return nickName$field;
      }
      
      public function removeGrade() : void
      {
         hasField$0 &= 4294967293;
         grade$field = new int();
      }
      
      public function get hasGrade() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set grade(param1:int) : void
      {
         hasField$0 |= 2;
         grade$field = param1;
      }
      
      public function get grade() : int
      {
         return grade$field;
      }
      
      public function removeHeadId() : void
      {
         hasField$0 &= 4294967291;
         headId$field = new int();
      }
      
      public function get hasHeadId() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set headId(param1:int) : void
      {
         hasField$0 |= 4;
         headId$field = param1;
      }
      
      public function get headId() : int
      {
         return headId$field;
      }
      
      public function removeConsortiaName() : void
      {
         consortiaName$field = null;
      }
      
      public function get hasConsortiaName() : Boolean
      {
         return consortiaName$field != null;
      }
      
      public function set consortiaName(param1:String) : void
      {
         consortiaName$field = param1;
      }
      
      public function get consortiaName() : String
      {
         return consortiaName$field;
      }
      
      public function removeArm() : void
      {
         arm$field = null;
      }
      
      public function get hasArm() : Boolean
      {
         return arm$field != null;
      }
      
      public function set arm(param1:String) : void
      {
         arm$field = param1;
      }
      
      public function get arm() : String
      {
         return arm$field;
      }
      
      public function removeCloth() : void
      {
         cloth$field = null;
      }
      
      public function get hasCloth() : Boolean
      {
         return cloth$field != null;
      }
      
      public function set cloth(param1:String) : void
      {
         cloth$field = param1;
      }
      
      public function get cloth() : String
      {
         return cloth$field;
      }
      
      public function removeWing() : void
      {
         wing$field = null;
      }
      
      public function get hasWing() : Boolean
      {
         return wing$field != null;
      }
      
      public function set wing(param1:String) : void
      {
         wing$field = param1;
      }
      
      public function get wing() : String
      {
         return wing$field;
      }
      
      public function removeHat() : void
      {
         hat$field = null;
      }
      
      public function get hasHat() : Boolean
      {
         return hat$field != null;
      }
      
      public function set hat(param1:String) : void
      {
         hat$field = param1;
      }
      
      public function get hat() : String
      {
         return hat$field;
      }
      
      public function removeSex() : void
      {
         hasField$0 &= 4294967287;
         sex$field = new int();
      }
      
      public function get hasSex() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set sex(param1:int) : void
      {
         hasField$0 |= 8;
         sex$field = param1;
      }
      
      public function get sex() : int
      {
         return sex$field;
      }
      
      public function removeJob() : void
      {
         hasField$0 &= 4294967279;
         job$field = new int();
      }
      
      public function get hasJob() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set job(param1:int) : void
      {
         hasField$0 |= 16;
         job$field = param1;
      }
      
      public function get job() : int
      {
         return job$field;
      }
      
      public function removeTemplateId() : void
      {
         hasField$0 &= 4294967263;
         templateId$field = new int();
      }
      
      public function get hasTemplateId() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set templateId(param1:int) : void
      {
         hasField$0 |= 32;
         templateId$field = param1;
      }
      
      public function get templateId() : int
      {
         return templateId$field;
      }
      
      public function removeFashionArm() : void
      {
         fashionArm$field = null;
      }
      
      public function get hasFashionArm() : Boolean
      {
         return fashionArm$field != null;
      }
      
      public function set fashionArm(param1:String) : void
      {
         fashionArm$field = param1;
      }
      
      public function get fashionArm() : String
      {
         return fashionArm$field;
      }
      
      public function removeFashionCloth() : void
      {
         fashionCloth$field = null;
      }
      
      public function get hasFashionCloth() : Boolean
      {
         return fashionCloth$field != null;
      }
      
      public function set fashionCloth(param1:String) : void
      {
         fashionCloth$field = param1;
      }
      
      public function get fashionCloth() : String
      {
         return fashionCloth$field;
      }
      
      public function removeHideFashion() : void
      {
         hasField$0 &= 4294967231;
         hideFashion$field = new Boolean();
      }
      
      public function get hasHideFashion() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set hideFashion(param1:Boolean) : void
      {
         hasField$0 |= 64;
         hideFashion$field = param1;
      }
      
      public function get hideFashion() : Boolean
      {
         return hideFashion$field;
      }
      
      public function removeIsDragonTalker() : void
      {
         hasField$0 &= 4294967167;
         isDragonTalker$field = new Boolean();
      }
      
      public function get hasIsDragonTalker() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set isDragonTalker(param1:Boolean) : void
      {
         hasField$0 |= 128;
         isDragonTalker$field = param1;
      }
      
      public function get isDragonTalker() : Boolean
      {
         return isDragonTalker$field;
      }
      
      public function removeEnergy() : void
      {
         hasField$0 &= 4294967039;
         energy$field = new int();
      }
      
      public function get hasEnergy() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set energy(param1:int) : void
      {
         hasField$0 |= 256;
         energy$field = param1;
      }
      
      public function get energy() : int
      {
         return energy$field;
      }
      
      public function removeMyPoint() : void
      {
         hasField$0 &= 4294966783;
         myPoint$field = new int();
      }
      
      public function get hasMyPoint() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set myPoint(param1:int) : void
      {
         hasField$0 |= 512;
         myPoint$field = param1;
      }
      
      public function get myPoint() : int
      {
         return myPoint$field;
      }
      
      public function removeIsBossReward() : void
      {
         hasField$0 &= 4294966271;
         isBossReward$field = new Boolean();
      }
      
      public function get hasIsBossReward() : Boolean
      {
         return (hasField$0 & 0x0400) != 0;
      }
      
      public function set isBossReward(param1:Boolean) : void
      {
         hasField$0 |= 1024;
         isBossReward$field = param1;
      }
      
      public function get isBossReward() : Boolean
      {
         return isBossReward$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasUserId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,userId$field);
         }
         if(hasNickName)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,nickName$field);
         }
         if(hasGrade)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,grade$field);
         }
         if(hasHeadId)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,headId$field);
         }
         if(hasConsortiaName)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_STRING(param1,consortiaName$field);
         }
         if(hasArm)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_STRING(param1,arm$field);
         }
         if(hasCloth)
         {
            WriteUtils.writeTag(param1,2,7);
            WriteUtils.write$TYPE_STRING(param1,cloth$field);
         }
         if(hasWing)
         {
            WriteUtils.writeTag(param1,2,8);
            WriteUtils.write$TYPE_STRING(param1,wing$field);
         }
         if(hasHat)
         {
            WriteUtils.writeTag(param1,2,9);
            WriteUtils.write$TYPE_STRING(param1,hat$field);
         }
         if(hasSex)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,sex$field);
         }
         if(hasJob)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,job$field);
         }
         if(hasTemplateId)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_INT32(param1,templateId$field);
         }
         if(hasFashionArm)
         {
            WriteUtils.writeTag(param1,2,13);
            WriteUtils.write$TYPE_STRING(param1,fashionArm$field);
         }
         if(hasFashionCloth)
         {
            WriteUtils.writeTag(param1,2,14);
            WriteUtils.write$TYPE_STRING(param1,fashionCloth$field);
         }
         if(hasHideFashion)
         {
            WriteUtils.writeTag(param1,0,15);
            WriteUtils.write$TYPE_BOOL(param1,hideFashion$field);
         }
         if(hasIsDragonTalker)
         {
            WriteUtils.writeTag(param1,0,16);
            WriteUtils.write$TYPE_BOOL(param1,isDragonTalker$field);
         }
         if(hasEnergy)
         {
            WriteUtils.writeTag(param1,0,17);
            WriteUtils.write$TYPE_INT32(param1,energy$field);
         }
         if(hasMyPoint)
         {
            WriteUtils.writeTag(param1,0,18);
            WriteUtils.write$TYPE_INT32(param1,myPoint$field);
         }
         if(hasIsBossReward)
         {
            WriteUtils.writeTag(param1,0,19);
            WriteUtils.write$TYPE_BOOL(param1,isBossReward$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc21_:* = 0;
         var _loc11_:uint = 0;
         var _loc14_:uint = 0;
         var _loc7_:uint = 0;
         var _loc10_:uint = 0;
         var _loc5_:uint = 0;
         var _loc15_:uint = 0;
         var _loc19_:uint = 0;
         var _loc16_:uint = 0;
         var _loc3_:uint = 0;
         var _loc9_:uint = 0;
         var _loc17_:uint = 0;
         var _loc8_:uint = 0;
         var _loc20_:uint = 0;
         var _loc4_:uint = 0;
         var _loc18_:uint = 0;
         var _loc12_:uint = 0;
         var _loc22_:uint = 0;
         var _loc6_:uint = 0;
         var _loc13_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc21_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: SnowyMistTeamPlayerMsg.userId cannot be set twice.");
                  }
                  _loc11_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: SnowyMistTeamPlayerMsg.nickName cannot be set twice.");
                  }
                  _loc14_++;
                  nickName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: SnowyMistTeamPlayerMsg.grade cannot be set twice.");
                  }
                  _loc7_++;
                  grade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: SnowyMistTeamPlayerMsg.headId cannot be set twice.");
                  }
                  _loc10_++;
                  headId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: SnowyMistTeamPlayerMsg.consortiaName cannot be set twice.");
                  }
                  _loc5_++;
                  consortiaName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 5:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: SnowyMistTeamPlayerMsg.arm cannot be set twice.");
                  }
                  _loc15_++;
                  arm = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 6:
                  if(_loc19_ != 0)
                  {
                     throw new IOError("Bad data format: SnowyMistTeamPlayerMsg.cloth cannot be set twice.");
                  }
                  _loc19_++;
                  cloth = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 7:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: SnowyMistTeamPlayerMsg.wing cannot be set twice.");
                  }
                  _loc16_++;
                  wing = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 8:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: SnowyMistTeamPlayerMsg.hat cannot be set twice.");
                  }
                  _loc3_++;
                  hat = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 9:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: SnowyMistTeamPlayerMsg.sex cannot be set twice.");
                  }
                  _loc9_++;
                  sex = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc17_ != 0)
                  {
                     throw new IOError("Bad data format: SnowyMistTeamPlayerMsg.job cannot be set twice.");
                  }
                  _loc17_++;
                  job = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 11:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: SnowyMistTeamPlayerMsg.templateId cannot be set twice.");
                  }
                  _loc8_++;
                  templateId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 12:
                  if(_loc20_ != 0)
                  {
                     throw new IOError("Bad data format: SnowyMistTeamPlayerMsg.fashionArm cannot be set twice.");
                  }
                  _loc20_++;
                  fashionArm = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 13:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: SnowyMistTeamPlayerMsg.fashionCloth cannot be set twice.");
                  }
                  _loc4_++;
                  fashionCloth = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 14:
                  if(_loc18_ != 0)
                  {
                     throw new IOError("Bad data format: SnowyMistTeamPlayerMsg.hideFashion cannot be set twice.");
                  }
                  _loc18_++;
                  hideFashion = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 15:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: SnowyMistTeamPlayerMsg.isDragonTalker cannot be set twice.");
                  }
                  _loc12_++;
                  isDragonTalker = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 16:
                  if(_loc22_ != 0)
                  {
                     throw new IOError("Bad data format: SnowyMistTeamPlayerMsg.energy cannot be set twice.");
                  }
                  _loc22_++;
                  energy = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 17:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: SnowyMistTeamPlayerMsg.myPoint cannot be set twice.");
                  }
                  _loc6_++;
                  myPoint = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 18:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: SnowyMistTeamPlayerMsg.isBossReward cannot be set twice.");
                  }
                  _loc13_++;
                  isBossReward = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc21_ & 7);
            }
         }
      }
   }
}

