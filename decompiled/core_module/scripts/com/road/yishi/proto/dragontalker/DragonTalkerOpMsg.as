package com.road.yishi.proto.dragontalker
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class DragonTalkerOpMsg extends Message implements IExternalizable
   {
      
      private var op$field:int;
      
      private var hasField$0:uint = 0;
      
      private var talismanId$field:int;
      
      private var count$field:int;
      
      private var skillIndex$field:int;
      
      private var payType$field:int;
      
      [ArrayElementType("int")]
      public var skillTempIds:Array = [];
      
      private var materialId$field:int;
      
      private var fastKey$field:String;
      
      private var symbiontIndex$field:int;
      
      private var mountTempId$field:int;
      
      private var result$field:int;
      
      private var newSkillIndex$field:int;
      
      [ArrayElementType("com.road.yishi.proto.dragontalker.MaterialListMsg")]
      public var materialList:Array = [];
      
      private var potentialIndex$field:int;
      
      [ArrayElementType("com.road.yishi.proto.dragontalker.SellTalismanInfo")]
      public var sellTaliInfos:Array = [];
      
      public function DragonTalkerOpMsg()
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
      
      public function removeTalismanId() : void
      {
         hasField$0 &= 4294967293;
         talismanId$field = new int();
      }
      
      public function get hasTalismanId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set talismanId(param1:int) : void
      {
         hasField$0 |= 2;
         talismanId$field = param1;
      }
      
      public function get talismanId() : int
      {
         return talismanId$field;
      }
      
      public function removeCount() : void
      {
         hasField$0 &= 4294967291;
         count$field = new int();
      }
      
      public function get hasCount() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set count(param1:int) : void
      {
         hasField$0 |= 4;
         count$field = param1;
      }
      
      public function get count() : int
      {
         return count$field;
      }
      
      public function removeSkillIndex() : void
      {
         hasField$0 &= 4294967287;
         skillIndex$field = new int();
      }
      
      public function get hasSkillIndex() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set skillIndex(param1:int) : void
      {
         hasField$0 |= 8;
         skillIndex$field = param1;
      }
      
      public function get skillIndex() : int
      {
         return skillIndex$field;
      }
      
      public function removePayType() : void
      {
         hasField$0 &= 4294967279;
         payType$field = new int();
      }
      
      public function get hasPayType() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set payType(param1:int) : void
      {
         hasField$0 |= 16;
         payType$field = param1;
      }
      
      public function get payType() : int
      {
         return payType$field;
      }
      
      public function removeMaterialId() : void
      {
         hasField$0 &= 4294967263;
         materialId$field = new int();
      }
      
      public function get hasMaterialId() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set materialId(param1:int) : void
      {
         hasField$0 |= 32;
         materialId$field = param1;
      }
      
      public function get materialId() : int
      {
         return materialId$field;
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
      
      public function removeSymbiontIndex() : void
      {
         hasField$0 &= 4294967231;
         symbiontIndex$field = new int();
      }
      
      public function get hasSymbiontIndex() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set symbiontIndex(param1:int) : void
      {
         hasField$0 |= 64;
         symbiontIndex$field = param1;
      }
      
      public function get symbiontIndex() : int
      {
         return symbiontIndex$field;
      }
      
      public function removeMountTempId() : void
      {
         hasField$0 &= 4294967167;
         mountTempId$field = new int();
      }
      
      public function get hasMountTempId() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set mountTempId(param1:int) : void
      {
         hasField$0 |= 128;
         mountTempId$field = param1;
      }
      
      public function get mountTempId() : int
      {
         return mountTempId$field;
      }
      
      public function removeResult() : void
      {
         hasField$0 &= 4294967039;
         result$field = new int();
      }
      
      public function get hasResult() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set result(param1:int) : void
      {
         hasField$0 |= 256;
         result$field = param1;
      }
      
      public function get result() : int
      {
         return result$field;
      }
      
      public function removeNewSkillIndex() : void
      {
         hasField$0 &= 4294966783;
         newSkillIndex$field = new int();
      }
      
      public function get hasNewSkillIndex() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set newSkillIndex(param1:int) : void
      {
         hasField$0 |= 512;
         newSkillIndex$field = param1;
      }
      
      public function get newSkillIndex() : int
      {
         return newSkillIndex$field;
      }
      
      public function removePotentialIndex() : void
      {
         hasField$0 &= 4294966271;
         potentialIndex$field = new int();
      }
      
      public function get hasPotentialIndex() : Boolean
      {
         return (hasField$0 & 0x0400) != 0;
      }
      
      public function set potentialIndex(param1:int) : void
      {
         hasField$0 |= 1024;
         potentialIndex$field = param1;
      }
      
      public function get potentialIndex() : int
      {
         return potentialIndex$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc4_:* = 0;
         var _loc3_:* = 0;
         var _loc2_:* = 0;
         if(hasOp)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_ENUM(param1,op$field);
         }
         if(hasTalismanId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,talismanId$field);
         }
         if(hasCount)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,count$field);
         }
         if(hasSkillIndex)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,skillIndex$field);
         }
         if(hasPayType)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,payType$field);
         }
         _loc4_ = 0;
         while(_loc4_ < skillTempIds.length)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,skillTempIds[_loc4_]);
            _loc4_++;
         }
         if(hasMaterialId)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,materialId$field);
         }
         if(hasFastKey)
         {
            WriteUtils.writeTag(param1,2,8);
            WriteUtils.write$TYPE_STRING(param1,fastKey$field);
         }
         if(hasSymbiontIndex)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,symbiontIndex$field);
         }
         if(hasMountTempId)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,mountTempId$field);
         }
         if(hasResult)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,result$field);
         }
         if(hasNewSkillIndex)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_INT32(param1,newSkillIndex$field);
         }
         _loc3_ = 0;
         while(_loc3_ < materialList.length)
         {
            WriteUtils.writeTag(param1,2,13);
            WriteUtils.write$TYPE_MESSAGE(param1,materialList[_loc3_]);
            _loc3_++;
         }
         if(hasPotentialIndex)
         {
            WriteUtils.writeTag(param1,0,14);
            WriteUtils.write$TYPE_INT32(param1,potentialIndex$field);
         }
         _loc2_ = 0;
         while(_loc2_ < sellTaliInfos.length)
         {
            WriteUtils.writeTag(param1,2,15);
            WriteUtils.write$TYPE_MESSAGE(param1,sellTaliInfos[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc15_:* = 0;
         var _loc10_:MaterialListMsg = null;
         var _loc14_:SellTalismanInfo = null;
         var _loc17_:uint = 0;
         var _loc13_:uint = 0;
         var _loc4_:uint = 0;
         var _loc7_:uint = 0;
         var _loc12_:uint = 0;
         var _loc9_:uint = 0;
         var _loc16_:uint = 0;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         var _loc8_:uint = 0;
         var _loc6_:uint = 0;
         var _loc11_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc15_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc17_ != 0)
                  {
                     throw new IOError("Bad data format: DragonTalkerOpMsg.op cannot be set twice.");
                  }
                  _loc17_++;
                  op = ReadUtils.read$TYPE_ENUM(param1);
                  break;
               case 1:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: DragonTalkerOpMsg.talismanId cannot be set twice.");
                  }
                  _loc13_++;
                  talismanId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: DragonTalkerOpMsg.count cannot be set twice.");
                  }
                  _loc4_++;
                  count = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: DragonTalkerOpMsg.skillIndex cannot be set twice.");
                  }
                  _loc7_++;
                  skillIndex = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: DragonTalkerOpMsg.payType cannot be set twice.");
                  }
                  _loc12_++;
                  payType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if((_loc15_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,skillTempIds);
                  }
                  else
                  {
                     skillTempIds.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               case 6:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: DragonTalkerOpMsg.materialId cannot be set twice.");
                  }
                  _loc9_++;
                  materialId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: DragonTalkerOpMsg.fastKey cannot be set twice.");
                  }
                  _loc16_++;
                  fastKey = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 8:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: DragonTalkerOpMsg.symbiontIndex cannot be set twice.");
                  }
                  _loc3_++;
                  symbiontIndex = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: DragonTalkerOpMsg.mountTempId cannot be set twice.");
                  }
                  _loc5_++;
                  mountTempId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: DragonTalkerOpMsg.result cannot be set twice.");
                  }
                  _loc8_++;
                  result = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 11:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: DragonTalkerOpMsg.newSkillIndex cannot be set twice.");
                  }
                  _loc6_++;
                  newSkillIndex = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 12:
                  _loc10_ = new MaterialListMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc10_);
                  materialList.push(_loc10_);
                  break;
               case 13:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: DragonTalkerOpMsg.potentialIndex cannot be set twice.");
                  }
                  _loc11_++;
                  potentialIndex = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 14:
                  _loc14_ = new SellTalismanInfo();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc14_);
                  sellTaliInfos.push(_loc14_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc15_ & 7);
            }
         }
      }
   }
}

