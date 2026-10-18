package com.road.yishi.proto.goddess
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class GoddessInfoMsg extends Message implements IExternalizable
   {
      
      private var userId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var templateId$field:int;
      
      private var grade$field:int;
      
      private var gradeGp$field:int;
      
      private var step$field:int;
      
      private var stepGp$field:int;
      
      private var devote$field:int;
      
      private var devoteGp$field:int;
      
      private var attack$field:int;
      
      private var defance$field:int;
      
      private var magicAttack$field:int;
      
      private var magicDefance$field:int;
      
      private var live$field:int;
      
      private var initBelief$field:int;
      
      private var actionBelief$field:int;
      
      private var activeSkill$field:int;
      
      private var defanceSkill$field:int;
      
      private var isFight$field:Boolean;
      
      private var equiSuitOpenMax$field:int;
      
      [ArrayElementType("com.road.yishi.proto.goddess.GoddessEquipInfoMsg")]
      public var equipInfos:Array = [];
      
      public function GoddessInfoMsg()
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
      
      public function removeGrade() : void
      {
         hasField$0 &= 4294967291;
         grade$field = new int();
      }
      
      public function get hasGrade() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set grade(param1:int) : void
      {
         hasField$0 |= 4;
         grade$field = param1;
      }
      
      public function get grade() : int
      {
         return grade$field;
      }
      
      public function removeGradeGp() : void
      {
         hasField$0 &= 4294967287;
         gradeGp$field = new int();
      }
      
      public function get hasGradeGp() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set gradeGp(param1:int) : void
      {
         hasField$0 |= 8;
         gradeGp$field = param1;
      }
      
      public function get gradeGp() : int
      {
         return gradeGp$field;
      }
      
      public function removeStep() : void
      {
         hasField$0 &= 4294967279;
         step$field = new int();
      }
      
      public function get hasStep() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set step(param1:int) : void
      {
         hasField$0 |= 16;
         step$field = param1;
      }
      
      public function get step() : int
      {
         return step$field;
      }
      
      public function removeStepGp() : void
      {
         hasField$0 &= 4294967263;
         stepGp$field = new int();
      }
      
      public function get hasStepGp() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set stepGp(param1:int) : void
      {
         hasField$0 |= 32;
         stepGp$field = param1;
      }
      
      public function get stepGp() : int
      {
         return stepGp$field;
      }
      
      public function removeDevote() : void
      {
         hasField$0 &= 4294967231;
         devote$field = new int();
      }
      
      public function get hasDevote() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set devote(param1:int) : void
      {
         hasField$0 |= 64;
         devote$field = param1;
      }
      
      public function get devote() : int
      {
         return devote$field;
      }
      
      public function removeDevoteGp() : void
      {
         hasField$0 &= 4294967167;
         devoteGp$field = new int();
      }
      
      public function get hasDevoteGp() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set devoteGp(param1:int) : void
      {
         hasField$0 |= 128;
         devoteGp$field = param1;
      }
      
      public function get devoteGp() : int
      {
         return devoteGp$field;
      }
      
      public function removeAttack() : void
      {
         hasField$0 &= 4294967039;
         attack$field = new int();
      }
      
      public function get hasAttack() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set attack(param1:int) : void
      {
         hasField$0 |= 256;
         attack$field = param1;
      }
      
      public function get attack() : int
      {
         return attack$field;
      }
      
      public function removeDefance() : void
      {
         hasField$0 &= 4294966783;
         defance$field = new int();
      }
      
      public function get hasDefance() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set defance(param1:int) : void
      {
         hasField$0 |= 512;
         defance$field = param1;
      }
      
      public function get defance() : int
      {
         return defance$field;
      }
      
      public function removeMagicAttack() : void
      {
         hasField$0 &= 4294966271;
         magicAttack$field = new int();
      }
      
      public function get hasMagicAttack() : Boolean
      {
         return (hasField$0 & 0x0400) != 0;
      }
      
      public function set magicAttack(param1:int) : void
      {
         hasField$0 |= 1024;
         magicAttack$field = param1;
      }
      
      public function get magicAttack() : int
      {
         return magicAttack$field;
      }
      
      public function removeMagicDefance() : void
      {
         hasField$0 &= 4294965247;
         magicDefance$field = new int();
      }
      
      public function get hasMagicDefance() : Boolean
      {
         return (hasField$0 & 0x0800) != 0;
      }
      
      public function set magicDefance(param1:int) : void
      {
         hasField$0 |= 2048;
         magicDefance$field = param1;
      }
      
      public function get magicDefance() : int
      {
         return magicDefance$field;
      }
      
      public function removeLive() : void
      {
         hasField$0 &= 4294963199;
         live$field = new int();
      }
      
      public function get hasLive() : Boolean
      {
         return (hasField$0 & 0x1000) != 0;
      }
      
      public function set live(param1:int) : void
      {
         hasField$0 |= 4096;
         live$field = param1;
      }
      
      public function get live() : int
      {
         return live$field;
      }
      
      public function removeInitBelief() : void
      {
         hasField$0 &= 4294959103;
         initBelief$field = new int();
      }
      
      public function get hasInitBelief() : Boolean
      {
         return (hasField$0 & 0x2000) != 0;
      }
      
      public function set initBelief(param1:int) : void
      {
         hasField$0 |= 8192;
         initBelief$field = param1;
      }
      
      public function get initBelief() : int
      {
         return initBelief$field;
      }
      
      public function removeActionBelief() : void
      {
         hasField$0 &= 4294950911;
         actionBelief$field = new int();
      }
      
      public function get hasActionBelief() : Boolean
      {
         return (hasField$0 & 0x4000) != 0;
      }
      
      public function set actionBelief(param1:int) : void
      {
         hasField$0 |= 16384;
         actionBelief$field = param1;
      }
      
      public function get actionBelief() : int
      {
         return actionBelief$field;
      }
      
      public function removeActiveSkill() : void
      {
         hasField$0 &= 4294934527;
         activeSkill$field = new int();
      }
      
      public function get hasActiveSkill() : Boolean
      {
         return (hasField$0 & 0x8000) != 0;
      }
      
      public function set activeSkill(param1:int) : void
      {
         hasField$0 |= 32768;
         activeSkill$field = param1;
      }
      
      public function get activeSkill() : int
      {
         return activeSkill$field;
      }
      
      public function removeDefanceSkill() : void
      {
         hasField$0 &= 4294901759;
         defanceSkill$field = new int();
      }
      
      public function get hasDefanceSkill() : Boolean
      {
         return (hasField$0 & 0x010000) != 0;
      }
      
      public function set defanceSkill(param1:int) : void
      {
         hasField$0 |= 65536;
         defanceSkill$field = param1;
      }
      
      public function get defanceSkill() : int
      {
         return defanceSkill$field;
      }
      
      public function removeIsFight() : void
      {
         hasField$0 &= 4294836223;
         isFight$field = new Boolean();
      }
      
      public function get hasIsFight() : Boolean
      {
         return (hasField$0 & 0x020000) != 0;
      }
      
      public function set isFight(param1:Boolean) : void
      {
         hasField$0 |= 131072;
         isFight$field = param1;
      }
      
      public function get isFight() : Boolean
      {
         return isFight$field;
      }
      
      public function removeEquiSuitOpenMax() : void
      {
         hasField$0 &= 4294705151;
         equiSuitOpenMax$field = new int();
      }
      
      public function get hasEquiSuitOpenMax() : Boolean
      {
         return (hasField$0 & 0x040000) != 0;
      }
      
      public function set equiSuitOpenMax(param1:int) : void
      {
         hasField$0 |= 262144;
         equiSuitOpenMax$field = param1;
      }
      
      public function get equiSuitOpenMax() : int
      {
         return equiSuitOpenMax$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasUserId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,userId$field);
         }
         if(hasTemplateId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,templateId$field);
         }
         if(hasGrade)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,grade$field);
         }
         if(hasGradeGp)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,gradeGp$field);
         }
         if(hasStep)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,step$field);
         }
         if(hasStepGp)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,stepGp$field);
         }
         if(hasDevote)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,devote$field);
         }
         if(hasDevoteGp)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,devoteGp$field);
         }
         if(hasAttack)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,attack$field);
         }
         if(hasDefance)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,defance$field);
         }
         if(hasMagicAttack)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_INT32(param1,magicAttack$field);
         }
         if(hasMagicDefance)
         {
            WriteUtils.writeTag(param1,0,13);
            WriteUtils.write$TYPE_INT32(param1,magicDefance$field);
         }
         if(hasLive)
         {
            WriteUtils.writeTag(param1,0,14);
            WriteUtils.write$TYPE_INT32(param1,live$field);
         }
         if(hasInitBelief)
         {
            WriteUtils.writeTag(param1,0,15);
            WriteUtils.write$TYPE_INT32(param1,initBelief$field);
         }
         if(hasActionBelief)
         {
            WriteUtils.writeTag(param1,0,16);
            WriteUtils.write$TYPE_INT32(param1,actionBelief$field);
         }
         if(hasActiveSkill)
         {
            WriteUtils.writeTag(param1,0,17);
            WriteUtils.write$TYPE_INT32(param1,activeSkill$field);
         }
         if(hasDefanceSkill)
         {
            WriteUtils.writeTag(param1,0,18);
            WriteUtils.write$TYPE_INT32(param1,defanceSkill$field);
         }
         if(hasIsFight)
         {
            WriteUtils.writeTag(param1,0,19);
            WriteUtils.write$TYPE_BOOL(param1,isFight$field);
         }
         if(hasEquiSuitOpenMax)
         {
            WriteUtils.writeTag(param1,0,20);
            WriteUtils.write$TYPE_INT32(param1,equiSuitOpenMax$field);
         }
         _loc2_ = 0;
         while(_loc2_ < equipInfos.length)
         {
            WriteUtils.writeTag(param1,2,21);
            WriteUtils.write$TYPE_MESSAGE(param1,equipInfos[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc22_:* = 0;
         var _loc5_:GoddessEquipInfoMsg = null;
         var _loc10_:uint = 0;
         var _loc8_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc13_:uint = 0;
         var _loc21_:uint = 0;
         var _loc11_:uint = 0;
         var _loc17_:uint = 0;
         var _loc19_:uint = 0;
         var _loc3_:uint = 0;
         var _loc20_:uint = 0;
         var _loc23_:uint = 0;
         var _loc16_:uint = 0;
         var _loc14_:uint = 0;
         var _loc4_:uint = 0;
         var _loc15_:uint = 0;
         var _loc18_:uint = 0;
         var _loc12_:uint = 0;
         var _loc9_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch((_loc22_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3)
            {
               case 1:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: GoddessInfoMsg.userId cannot be set twice.");
                  }
                  _loc10_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: GoddessInfoMsg.templateId cannot be set twice.");
                  }
                  _loc8_++;
                  templateId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: GoddessInfoMsg.grade cannot be set twice.");
                  }
                  _loc6_++;
                  grade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: GoddessInfoMsg.gradeGp cannot be set twice.");
                  }
                  _loc7_++;
                  gradeGp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: GoddessInfoMsg.step cannot be set twice.");
                  }
                  _loc13_++;
                  step = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc21_ != 0)
                  {
                     throw new IOError("Bad data format: GoddessInfoMsg.stepGp cannot be set twice.");
                  }
                  _loc21_++;
                  stepGp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: GoddessInfoMsg.devote cannot be set twice.");
                  }
                  _loc11_++;
                  devote = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc17_ != 0)
                  {
                     throw new IOError("Bad data format: GoddessInfoMsg.devoteGp cannot be set twice.");
                  }
                  _loc17_++;
                  devoteGp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc19_ != 0)
                  {
                     throw new IOError("Bad data format: GoddessInfoMsg.attack cannot be set twice.");
                  }
                  _loc19_++;
                  attack = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 11:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: GoddessInfoMsg.defance cannot be set twice.");
                  }
                  _loc3_++;
                  defance = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 12:
                  if(_loc20_ != 0)
                  {
                     throw new IOError("Bad data format: GoddessInfoMsg.magicAttack cannot be set twice.");
                  }
                  _loc20_++;
                  magicAttack = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 13:
                  if(_loc23_ != 0)
                  {
                     throw new IOError("Bad data format: GoddessInfoMsg.magicDefance cannot be set twice.");
                  }
                  _loc23_++;
                  magicDefance = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 14:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: GoddessInfoMsg.live cannot be set twice.");
                  }
                  _loc16_++;
                  live = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 15:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: GoddessInfoMsg.initBelief cannot be set twice.");
                  }
                  _loc14_++;
                  initBelief = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 16:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: GoddessInfoMsg.actionBelief cannot be set twice.");
                  }
                  _loc4_++;
                  actionBelief = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 17:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: GoddessInfoMsg.activeSkill cannot be set twice.");
                  }
                  _loc15_++;
                  activeSkill = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 18:
                  if(_loc18_ != 0)
                  {
                     throw new IOError("Bad data format: GoddessInfoMsg.defanceSkill cannot be set twice.");
                  }
                  _loc18_++;
                  defanceSkill = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 19:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: GoddessInfoMsg.isFight cannot be set twice.");
                  }
                  _loc12_++;
                  isFight = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 20:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: GoddessInfoMsg.equiSuitOpenMax cannot be set twice.");
                  }
                  _loc9_++;
                  equiSuitOpenMax = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 21:
                  _loc5_ = new GoddessEquipInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc5_);
                  equipInfos.push(_loc5_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc22_ & 7);
            }
         }
      }
   }
}

