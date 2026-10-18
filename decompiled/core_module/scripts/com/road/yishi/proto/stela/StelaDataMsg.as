package com.road.yishi.proto.stela
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class StelaDataMsg extends Message implements IExternalizable
   {
      
      private var id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var templateId$field:int;
      
      private var pos$field:int;
      
      private var step$field:int;
      
      private var level$field:int;
      
      private var exp$field:int;
      
      private var totalExp$field:int;
      
      private var skill1$field:int;
      
      private var skill2$field:int;
      
      private var skill3$field:int;
      
      private var skill4$field:int;
      
      private var skill5$field:int;
      
      private var isExist$field:Boolean;
      
      public function StelaDataMsg()
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
      
      public function removeStep() : void
      {
         hasField$0 &= 4294967287;
         step$field = new int();
      }
      
      public function get hasStep() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set step(param1:int) : void
      {
         hasField$0 |= 8;
         step$field = param1;
      }
      
      public function get step() : int
      {
         return step$field;
      }
      
      public function removeLevel() : void
      {
         hasField$0 &= 4294967279;
         level$field = new int();
      }
      
      public function get hasLevel() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set level(param1:int) : void
      {
         hasField$0 |= 16;
         level$field = param1;
      }
      
      public function get level() : int
      {
         return level$field;
      }
      
      public function removeExp() : void
      {
         hasField$0 &= 4294967263;
         exp$field = new int();
      }
      
      public function get hasExp() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set exp(param1:int) : void
      {
         hasField$0 |= 32;
         exp$field = param1;
      }
      
      public function get exp() : int
      {
         return exp$field;
      }
      
      public function removeTotalExp() : void
      {
         hasField$0 &= 4294967231;
         totalExp$field = new int();
      }
      
      public function get hasTotalExp() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set totalExp(param1:int) : void
      {
         hasField$0 |= 64;
         totalExp$field = param1;
      }
      
      public function get totalExp() : int
      {
         return totalExp$field;
      }
      
      public function removeSkill1() : void
      {
         hasField$0 &= 4294967167;
         skill1$field = new int();
      }
      
      public function get hasSkill1() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set skill1(param1:int) : void
      {
         hasField$0 |= 128;
         skill1$field = param1;
      }
      
      public function get skill1() : int
      {
         return skill1$field;
      }
      
      public function removeSkill2() : void
      {
         hasField$0 &= 4294967039;
         skill2$field = new int();
      }
      
      public function get hasSkill2() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set skill2(param1:int) : void
      {
         hasField$0 |= 256;
         skill2$field = param1;
      }
      
      public function get skill2() : int
      {
         return skill2$field;
      }
      
      public function removeSkill3() : void
      {
         hasField$0 &= 4294966783;
         skill3$field = new int();
      }
      
      public function get hasSkill3() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set skill3(param1:int) : void
      {
         hasField$0 |= 512;
         skill3$field = param1;
      }
      
      public function get skill3() : int
      {
         return skill3$field;
      }
      
      public function removeSkill4() : void
      {
         hasField$0 &= 4294966271;
         skill4$field = new int();
      }
      
      public function get hasSkill4() : Boolean
      {
         return (hasField$0 & 0x0400) != 0;
      }
      
      public function set skill4(param1:int) : void
      {
         hasField$0 |= 1024;
         skill4$field = param1;
      }
      
      public function get skill4() : int
      {
         return skill4$field;
      }
      
      public function removeSkill5() : void
      {
         hasField$0 &= 4294965247;
         skill5$field = new int();
      }
      
      public function get hasSkill5() : Boolean
      {
         return (hasField$0 & 0x0800) != 0;
      }
      
      public function set skill5(param1:int) : void
      {
         hasField$0 |= 2048;
         skill5$field = param1;
      }
      
      public function get skill5() : int
      {
         return skill5$field;
      }
      
      public function removeIsExist() : void
      {
         hasField$0 &= 4294963199;
         isExist$field = new Boolean();
      }
      
      public function get hasIsExist() : Boolean
      {
         return (hasField$0 & 0x1000) != 0;
      }
      
      public function set isExist(param1:Boolean) : void
      {
         hasField$0 |= 4096;
         isExist$field = param1;
      }
      
      public function get isExist() : Boolean
      {
         return isExist$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
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
         if(hasStep)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,step$field);
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
         if(hasTotalExp)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,totalExp$field);
         }
         if(hasSkill1)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,skill1$field);
         }
         if(hasSkill2)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,skill2$field);
         }
         if(hasSkill3)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,skill3$field);
         }
         if(hasSkill4)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,skill4$field);
         }
         if(hasSkill5)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_INT32(param1,skill5$field);
         }
         if(hasIsExist)
         {
            WriteUtils.writeTag(param1,0,13);
            WriteUtils.write$TYPE_BOOL(param1,isExist$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc16_:* = 0;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc12_:uint = 0;
         var _loc3_:uint = 0;
         var _loc13_:uint = 0;
         var _loc6_:uint = 0;
         var _loc5_:uint = 0;
         var _loc4_:uint = 0;
         var _loc15_:uint = 0;
         var _loc14_:uint = 0;
         var _loc11_:uint = 0;
         var _loc7_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc16_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: StelaDataMsg.id cannot be set twice.");
                  }
                  _loc8_++;
                  id = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: StelaDataMsg.templateId cannot be set twice.");
                  }
                  _loc9_++;
                  templateId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: StelaDataMsg.pos cannot be set twice.");
                  }
                  _loc10_++;
                  pos = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: StelaDataMsg.step cannot be set twice.");
                  }
                  _loc12_++;
                  step = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: StelaDataMsg.level cannot be set twice.");
                  }
                  _loc3_++;
                  level = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: StelaDataMsg.exp cannot be set twice.");
                  }
                  _loc13_++;
                  exp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: StelaDataMsg.totalExp cannot be set twice.");
                  }
                  _loc6_++;
                  totalExp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: StelaDataMsg.skill1 cannot be set twice.");
                  }
                  _loc5_++;
                  skill1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: StelaDataMsg.skill2 cannot be set twice.");
                  }
                  _loc4_++;
                  skill2 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: StelaDataMsg.skill3 cannot be set twice.");
                  }
                  _loc15_++;
                  skill3 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: StelaDataMsg.skill4 cannot be set twice.");
                  }
                  _loc14_++;
                  skill4 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 11:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: StelaDataMsg.skill5 cannot be set twice.");
                  }
                  _loc11_++;
                  skill5 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 12:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: StelaDataMsg.isExist cannot be set twice.");
                  }
                  _loc7_++;
                  isExist = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc16_ & 7);
            }
         }
      }
   }
}

