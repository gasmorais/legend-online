package com.road.yishi.proto.children
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ChildEquipmentMsg extends Message implements IExternalizable
   {
      
      private var templateId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var pos$field:int;
      
      private var join1$field:int;
      
      private var join2$field:int;
      
      private var join3$field:int;
      
      private var join4$field:int;
      
      private var randomSkill1$field:int;
      
      private var randomSkill2$field:int;
      
      private var randomSkill3$field:int;
      
      private var randomSkill4$field:int;
      
      private var randomSkill5$field:int;
      
      private var mouldGrade$field:int;
      
      private var isBind$field:Boolean;
      
      private var strengthenGrade$field:int;
      
      public function ChildEquipmentMsg()
      {
         super();
      }
      
      public function removeTemplateId() : void
      {
         hasField$0 &= 4294967294;
         templateId$field = new int();
      }
      
      public function get hasTemplateId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set templateId(param1:int) : void
      {
         hasField$0 |= 1;
         templateId$field = param1;
      }
      
      public function get templateId() : int
      {
         return templateId$field;
      }
      
      public function removePos() : void
      {
         hasField$0 &= 4294967293;
         pos$field = new int();
      }
      
      public function get hasPos() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set pos(param1:int) : void
      {
         hasField$0 |= 2;
         pos$field = param1;
      }
      
      public function get pos() : int
      {
         return pos$field;
      }
      
      public function removeJoin1() : void
      {
         hasField$0 &= 4294967291;
         join1$field = new int();
      }
      
      public function get hasJoin1() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set join1(param1:int) : void
      {
         hasField$0 |= 4;
         join1$field = param1;
      }
      
      public function get join1() : int
      {
         return join1$field;
      }
      
      public function removeJoin2() : void
      {
         hasField$0 &= 4294967287;
         join2$field = new int();
      }
      
      public function get hasJoin2() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set join2(param1:int) : void
      {
         hasField$0 |= 8;
         join2$field = param1;
      }
      
      public function get join2() : int
      {
         return join2$field;
      }
      
      public function removeJoin3() : void
      {
         hasField$0 &= 4294967279;
         join3$field = new int();
      }
      
      public function get hasJoin3() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set join3(param1:int) : void
      {
         hasField$0 |= 16;
         join3$field = param1;
      }
      
      public function get join3() : int
      {
         return join3$field;
      }
      
      public function removeJoin4() : void
      {
         hasField$0 &= 4294967263;
         join4$field = new int();
      }
      
      public function get hasJoin4() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set join4(param1:int) : void
      {
         hasField$0 |= 32;
         join4$field = param1;
      }
      
      public function get join4() : int
      {
         return join4$field;
      }
      
      public function removeRandomSkill1() : void
      {
         hasField$0 &= 4294967231;
         randomSkill1$field = new int();
      }
      
      public function get hasRandomSkill1() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set randomSkill1(param1:int) : void
      {
         hasField$0 |= 64;
         randomSkill1$field = param1;
      }
      
      public function get randomSkill1() : int
      {
         return randomSkill1$field;
      }
      
      public function removeRandomSkill2() : void
      {
         hasField$0 &= 4294967167;
         randomSkill2$field = new int();
      }
      
      public function get hasRandomSkill2() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set randomSkill2(param1:int) : void
      {
         hasField$0 |= 128;
         randomSkill2$field = param1;
      }
      
      public function get randomSkill2() : int
      {
         return randomSkill2$field;
      }
      
      public function removeRandomSkill3() : void
      {
         hasField$0 &= 4294967039;
         randomSkill3$field = new int();
      }
      
      public function get hasRandomSkill3() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set randomSkill3(param1:int) : void
      {
         hasField$0 |= 256;
         randomSkill3$field = param1;
      }
      
      public function get randomSkill3() : int
      {
         return randomSkill3$field;
      }
      
      public function removeRandomSkill4() : void
      {
         hasField$0 &= 4294966783;
         randomSkill4$field = new int();
      }
      
      public function get hasRandomSkill4() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set randomSkill4(param1:int) : void
      {
         hasField$0 |= 512;
         randomSkill4$field = param1;
      }
      
      public function get randomSkill4() : int
      {
         return randomSkill4$field;
      }
      
      public function removeRandomSkill5() : void
      {
         hasField$0 &= 4294966271;
         randomSkill5$field = new int();
      }
      
      public function get hasRandomSkill5() : Boolean
      {
         return (hasField$0 & 0x0400) != 0;
      }
      
      public function set randomSkill5(param1:int) : void
      {
         hasField$0 |= 1024;
         randomSkill5$field = param1;
      }
      
      public function get randomSkill5() : int
      {
         return randomSkill5$field;
      }
      
      public function removeMouldGrade() : void
      {
         hasField$0 &= 4294965247;
         mouldGrade$field = new int();
      }
      
      public function get hasMouldGrade() : Boolean
      {
         return (hasField$0 & 0x0800) != 0;
      }
      
      public function set mouldGrade(param1:int) : void
      {
         hasField$0 |= 2048;
         mouldGrade$field = param1;
      }
      
      public function get mouldGrade() : int
      {
         return mouldGrade$field;
      }
      
      public function removeIsBind() : void
      {
         hasField$0 &= 4294963199;
         isBind$field = new Boolean();
      }
      
      public function get hasIsBind() : Boolean
      {
         return (hasField$0 & 0x1000) != 0;
      }
      
      public function set isBind(param1:Boolean) : void
      {
         hasField$0 |= 4096;
         isBind$field = param1;
      }
      
      public function get isBind() : Boolean
      {
         return isBind$field;
      }
      
      public function removeStrengthenGrade() : void
      {
         hasField$0 &= 4294959103;
         strengthenGrade$field = new int();
      }
      
      public function get hasStrengthenGrade() : Boolean
      {
         return (hasField$0 & 0x2000) != 0;
      }
      
      public function set strengthenGrade(param1:int) : void
      {
         hasField$0 |= 8192;
         strengthenGrade$field = param1;
      }
      
      public function get strengthenGrade() : int
      {
         return strengthenGrade$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasTemplateId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,templateId$field);
         }
         if(hasPos)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,pos$field);
         }
         if(hasJoin1)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,join1$field);
         }
         if(hasJoin2)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,join2$field);
         }
         if(hasJoin3)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,join3$field);
         }
         if(hasJoin4)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,join4$field);
         }
         if(hasRandomSkill1)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,randomSkill1$field);
         }
         if(hasRandomSkill2)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,randomSkill2$field);
         }
         if(hasRandomSkill3)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,randomSkill3$field);
         }
         if(hasRandomSkill4)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,randomSkill4$field);
         }
         if(hasRandomSkill5)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,randomSkill5$field);
         }
         if(hasMouldGrade)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_INT32(param1,mouldGrade$field);
         }
         if(hasIsBind)
         {
            WriteUtils.writeTag(param1,0,13);
            WriteUtils.write$TYPE_BOOL(param1,isBind$field);
         }
         if(hasStrengthenGrade)
         {
            WriteUtils.writeTag(param1,0,14);
            WriteUtils.write$TYPE_INT32(param1,strengthenGrade$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc16_:* = 0;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc12_:uint = 0;
         var _loc14_:uint = 0;
         var _loc6_:uint = 0;
         var _loc5_:uint = 0;
         var _loc11_:uint = 0;
         var _loc10_:uint = 0;
         var _loc15_:uint = 0;
         var _loc3_:uint = 0;
         var _loc7_:uint = 0;
         var _loc4_:uint = 0;
         var _loc13_:uint = 0;
         var _loc17_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc16_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: ChildEquipmentMsg.templateId cannot be set twice.");
                  }
                  _loc8_++;
                  templateId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: ChildEquipmentMsg.pos cannot be set twice.");
                  }
                  _loc9_++;
                  pos = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: ChildEquipmentMsg.join1 cannot be set twice.");
                  }
                  _loc12_++;
                  join1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: ChildEquipmentMsg.join2 cannot be set twice.");
                  }
                  _loc14_++;
                  join2 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ChildEquipmentMsg.join3 cannot be set twice.");
                  }
                  _loc6_++;
                  join3 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ChildEquipmentMsg.join4 cannot be set twice.");
                  }
                  _loc5_++;
                  join4 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: ChildEquipmentMsg.randomSkill1 cannot be set twice.");
                  }
                  _loc11_++;
                  randomSkill1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: ChildEquipmentMsg.randomSkill2 cannot be set twice.");
                  }
                  _loc10_++;
                  randomSkill2 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: ChildEquipmentMsg.randomSkill3 cannot be set twice.");
                  }
                  _loc15_++;
                  randomSkill3 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ChildEquipmentMsg.randomSkill4 cannot be set twice.");
                  }
                  _loc3_++;
                  randomSkill4 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: ChildEquipmentMsg.randomSkill5 cannot be set twice.");
                  }
                  _loc7_++;
                  randomSkill5 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 11:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ChildEquipmentMsg.mouldGrade cannot be set twice.");
                  }
                  _loc4_++;
                  mouldGrade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 12:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: ChildEquipmentMsg.isBind cannot be set twice.");
                  }
                  _loc13_++;
                  isBind = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 13:
                  if(_loc17_ != 0)
                  {
                     throw new IOError("Bad data format: ChildEquipmentMsg.strengthenGrade cannot be set twice.");
                  }
                  _loc17_++;
                  strengthenGrade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc16_ & 7);
            }
         }
      }
   }
}

