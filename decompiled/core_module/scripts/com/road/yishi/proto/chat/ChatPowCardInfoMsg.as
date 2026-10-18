package com.road.yishi.proto.chat
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ChatPowCardInfoMsg extends Message implements IExternalizable
   {
      
      private var id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var template_id$field:int;
      
      private var user_id$field:int;
      
      private var object_id$field:int;
      
      private var pos$field:int;
      
      private var exist$field:Boolean;
      
      private var bag_type$field:int;
      
      private var grade$field:int;
      
      private var gp$field:int;
      
      private var is_lock$field:Boolean;
      
      private var powcard_name$field:String;
      
      private var buffId$field:int;
      
      private var sonType$field:int;
      
      private var fixValue$field:int;
      
      private var percent$field:int;
      
      public function ChatPowCardInfoMsg()
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
         template_id$field = new int();
      }
      
      public function get hasTemplateId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set templateId(param1:int) : void
      {
         hasField$0 |= 2;
         template_id$field = param1;
      }
      
      public function get templateId() : int
      {
         return template_id$field;
      }
      
      public function removeUserId() : void
      {
         hasField$0 &= 4294967291;
         user_id$field = new int();
      }
      
      public function get hasUserId() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set userId(param1:int) : void
      {
         hasField$0 |= 4;
         user_id$field = param1;
      }
      
      public function get userId() : int
      {
         return user_id$field;
      }
      
      public function removeObjectId() : void
      {
         hasField$0 &= 4294967287;
         object_id$field = new int();
      }
      
      public function get hasObjectId() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set objectId(param1:int) : void
      {
         hasField$0 |= 8;
         object_id$field = param1;
      }
      
      public function get objectId() : int
      {
         return object_id$field;
      }
      
      public function removePos() : void
      {
         hasField$0 &= 4294967279;
         pos$field = new int();
      }
      
      public function get hasPos() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set pos(param1:int) : void
      {
         hasField$0 |= 16;
         pos$field = param1;
      }
      
      public function get pos() : int
      {
         return pos$field;
      }
      
      public function removeExist() : void
      {
         hasField$0 &= 4294967263;
         exist$field = new Boolean();
      }
      
      public function get hasExist() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set exist(param1:Boolean) : void
      {
         hasField$0 |= 32;
         exist$field = param1;
      }
      
      public function get exist() : Boolean
      {
         return exist$field;
      }
      
      public function removeBagType() : void
      {
         hasField$0 &= 4294967231;
         bag_type$field = new int();
      }
      
      public function get hasBagType() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set bagType(param1:int) : void
      {
         hasField$0 |= 64;
         bag_type$field = param1;
      }
      
      public function get bagType() : int
      {
         return bag_type$field;
      }
      
      public function removeGrade() : void
      {
         hasField$0 &= 4294967167;
         grade$field = new int();
      }
      
      public function get hasGrade() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set grade(param1:int) : void
      {
         hasField$0 |= 128;
         grade$field = param1;
      }
      
      public function get grade() : int
      {
         return grade$field;
      }
      
      public function removeGp() : void
      {
         hasField$0 &= 4294967039;
         gp$field = new int();
      }
      
      public function get hasGp() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set gp(param1:int) : void
      {
         hasField$0 |= 256;
         gp$field = param1;
      }
      
      public function get gp() : int
      {
         return gp$field;
      }
      
      public function removeIsLock() : void
      {
         hasField$0 &= 4294966783;
         is_lock$field = new Boolean();
      }
      
      public function get hasIsLock() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set isLock(param1:Boolean) : void
      {
         hasField$0 |= 512;
         is_lock$field = param1;
      }
      
      public function get isLock() : Boolean
      {
         return is_lock$field;
      }
      
      public function removePowcardName() : void
      {
         powcard_name$field = null;
      }
      
      public function get hasPowcardName() : Boolean
      {
         return powcard_name$field != null;
      }
      
      public function set powcardName(param1:String) : void
      {
         powcard_name$field = param1;
      }
      
      public function get powcardName() : String
      {
         return powcard_name$field;
      }
      
      public function removeBuffId() : void
      {
         hasField$0 &= 4294966271;
         buffId$field = new int();
      }
      
      public function get hasBuffId() : Boolean
      {
         return (hasField$0 & 0x0400) != 0;
      }
      
      public function set buffId(param1:int) : void
      {
         hasField$0 |= 1024;
         buffId$field = param1;
      }
      
      public function get buffId() : int
      {
         return buffId$field;
      }
      
      public function removeSonType() : void
      {
         hasField$0 &= 4294965247;
         sonType$field = new int();
      }
      
      public function get hasSonType() : Boolean
      {
         return (hasField$0 & 0x0800) != 0;
      }
      
      public function set sonType(param1:int) : void
      {
         hasField$0 |= 2048;
         sonType$field = param1;
      }
      
      public function get sonType() : int
      {
         return sonType$field;
      }
      
      public function removeFixValue() : void
      {
         hasField$0 &= 4294963199;
         fixValue$field = new int();
      }
      
      public function get hasFixValue() : Boolean
      {
         return (hasField$0 & 0x1000) != 0;
      }
      
      public function set fixValue(param1:int) : void
      {
         hasField$0 |= 4096;
         fixValue$field = param1;
      }
      
      public function get fixValue() : int
      {
         return fixValue$field;
      }
      
      public function removePercent() : void
      {
         hasField$0 &= 4294959103;
         percent$field = new int();
      }
      
      public function get hasPercent() : Boolean
      {
         return (hasField$0 & 0x2000) != 0;
      }
      
      public function set percent(param1:int) : void
      {
         hasField$0 |= 8192;
         percent$field = param1;
      }
      
      public function get percent() : int
      {
         return percent$field;
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
            WriteUtils.write$TYPE_INT32(param1,template_id$field);
         }
         if(hasUserId)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,user_id$field);
         }
         if(hasObjectId)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,object_id$field);
         }
         if(hasPos)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,pos$field);
         }
         if(hasExist)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_BOOL(param1,exist$field);
         }
         if(hasBagType)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,bag_type$field);
         }
         if(hasGrade)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,grade$field);
         }
         if(hasGp)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,gp$field);
         }
         if(hasIsLock)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_BOOL(param1,is_lock$field);
         }
         if(hasPowcardName)
         {
            WriteUtils.writeTag(param1,2,11);
            WriteUtils.write$TYPE_STRING(param1,powcard_name$field);
         }
         if(hasBuffId)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_INT32(param1,buffId$field);
         }
         if(hasSonType)
         {
            WriteUtils.writeTag(param1,0,13);
            WriteUtils.write$TYPE_INT32(param1,sonType$field);
         }
         if(hasFixValue)
         {
            WriteUtils.writeTag(param1,0,14);
            WriteUtils.write$TYPE_INT32(param1,fixValue$field);
         }
         if(hasPercent)
         {
            WriteUtils.writeTag(param1,0,15);
            WriteUtils.write$TYPE_INT32(param1,percent$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc16_:* = 0;
         var _loc6_:uint = 0;
         var _loc14_:uint = 0;
         var _loc12_:uint = 0;
         var _loc13_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc5_:uint = 0;
         var _loc17_:uint = 0;
         var _loc18_:uint = 0;
         var _loc4_:uint = 0;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc15_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc16_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ChatPowCardInfoMsg.id cannot be set twice.");
                  }
                  _loc6_++;
                  id = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: ChatPowCardInfoMsg.templateId cannot be set twice.");
                  }
                  _loc14_++;
                  templateId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: ChatPowCardInfoMsg.userId cannot be set twice.");
                  }
                  _loc12_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: ChatPowCardInfoMsg.objectId cannot be set twice.");
                  }
                  _loc13_++;
                  objectId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: ChatPowCardInfoMsg.pos cannot be set twice.");
                  }
                  _loc7_++;
                  pos = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: ChatPowCardInfoMsg.exist cannot be set twice.");
                  }
                  _loc8_++;
                  exist = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 6:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: ChatPowCardInfoMsg.bagType cannot be set twice.");
                  }
                  _loc9_++;
                  bagType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ChatPowCardInfoMsg.grade cannot be set twice.");
                  }
                  _loc5_++;
                  grade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc17_ != 0)
                  {
                     throw new IOError("Bad data format: ChatPowCardInfoMsg.gp cannot be set twice.");
                  }
                  _loc17_++;
                  gp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc18_ != 0)
                  {
                     throw new IOError("Bad data format: ChatPowCardInfoMsg.isLock cannot be set twice.");
                  }
                  _loc18_++;
                  isLock = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 10:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ChatPowCardInfoMsg.powcardName cannot be set twice.");
                  }
                  _loc4_++;
                  powcardName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 11:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: ChatPowCardInfoMsg.buffId cannot be set twice.");
                  }
                  _loc10_++;
                  buffId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 12:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: ChatPowCardInfoMsg.sonType cannot be set twice.");
                  }
                  _loc11_++;
                  sonType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 13:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: ChatPowCardInfoMsg.fixValue cannot be set twice.");
                  }
                  _loc15_++;
                  fixValue = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 14:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ChatPowCardInfoMsg.percent cannot be set twice.");
                  }
                  _loc3_++;
                  percent = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc16_ & 7);
            }
         }
      }
   }
}

