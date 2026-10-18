package com.road.yishi.proto.avenger
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class AvengerMsg extends Message implements IExternalizable
   {
      
      private var opType$field:int;
      
      private var hasField$0:uint = 0;
      
      private var grade$field:int;
      
      private var exp$field:int;
      
      [ArrayElementType("com.road.yishi.proto.avenger.AvengerSkillMsg")]
      public var skillDatas:Array = [];
      
      private var armorGrade$field:int;
      
      private var armorExp$field:int;
      
      [ArrayElementType("com.road.yishi.proto.avenger.AvengerHoleMsg")]
      public var holeDatas:Array = [];
      
      public function AvengerMsg()
      {
         super();
      }
      
      public function removeOpType() : void
      {
         hasField$0 &= 4294967294;
         opType$field = new int();
      }
      
      public function get hasOpType() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set opType(param1:int) : void
      {
         hasField$0 |= 1;
         opType$field = param1;
      }
      
      public function get opType() : int
      {
         return opType$field;
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
      
      public function removeExp() : void
      {
         hasField$0 &= 4294967291;
         exp$field = new int();
      }
      
      public function get hasExp() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set exp(param1:int) : void
      {
         hasField$0 |= 4;
         exp$field = param1;
      }
      
      public function get exp() : int
      {
         return exp$field;
      }
      
      public function removeArmorGrade() : void
      {
         hasField$0 &= 4294967287;
         armorGrade$field = new int();
      }
      
      public function get hasArmorGrade() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set armorGrade(param1:int) : void
      {
         hasField$0 |= 8;
         armorGrade$field = param1;
      }
      
      public function get armorGrade() : int
      {
         return armorGrade$field;
      }
      
      public function removeArmorExp() : void
      {
         hasField$0 &= 4294967279;
         armorExp$field = new int();
      }
      
      public function get hasArmorExp() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set armorExp(param1:int) : void
      {
         hasField$0 |= 16;
         armorExp$field = param1;
      }
      
      public function get armorExp() : int
      {
         return armorExp$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         if(hasOpType)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,opType$field);
         }
         if(hasGrade)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,grade$field);
         }
         if(hasExp)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,exp$field);
         }
         _loc2_ = 0;
         while(_loc2_ < skillDatas.length)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_MESSAGE(param1,skillDatas[_loc2_]);
            _loc2_++;
         }
         if(hasArmorGrade)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,armorGrade$field);
         }
         if(hasArmorExp)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,armorExp$field);
         }
         _loc3_ = 0;
         while(_loc3_ < holeDatas.length)
         {
            WriteUtils.writeTag(param1,2,7);
            WriteUtils.write$TYPE_MESSAGE(param1,holeDatas[_loc3_]);
            _loc3_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc9_:* = 0;
         var _loc10_:AvengerSkillMsg = null;
         var _loc3_:AvengerHoleMsg = null;
         var _loc4_:uint = 0;
         var _loc6_:uint = 0;
         var _loc5_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc9_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: AvengerMsg.opType cannot be set twice.");
                  }
                  _loc4_++;
                  opType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: AvengerMsg.grade cannot be set twice.");
                  }
                  _loc6_++;
                  grade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: AvengerMsg.exp cannot be set twice.");
                  }
                  _loc5_++;
                  exp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  _loc10_ = new AvengerSkillMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc10_);
                  skillDatas.push(_loc10_);
                  break;
               case 4:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: AvengerMsg.armorGrade cannot be set twice.");
                  }
                  _loc7_++;
                  armorGrade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: AvengerMsg.armorExp cannot be set twice.");
                  }
                  _loc8_++;
                  armorExp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  _loc3_ = new AvengerHoleMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc3_);
                  holeDatas.push(_loc3_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc9_ & 7);
            }
         }
      }
   }
}

