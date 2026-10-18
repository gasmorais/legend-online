package com.road.yishi.proto.theseus
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class TheseusEquipMsg extends Message implements IExternalizable
   {
      
      private var id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var templateId$field:int;
      
      private var type$field:int;
      
      private var pos$field:int;
      
      private var count$field:int;
      
      private var strengthen$field:int;
      
      private var quality$field:int;
      
      private var isExist$field:Boolean;
      
      private var isLock$field:Boolean;
      
      private var isEquip$field:Boolean;
      
      private var equipPos$field:int;
      
      public function TheseusEquipMsg()
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
      
      public function removeType() : void
      {
         hasField$0 &= 4294967291;
         type$field = new int();
      }
      
      public function get hasType() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set type(param1:int) : void
      {
         hasField$0 |= 4;
         type$field = param1;
      }
      
      public function get type() : int
      {
         return type$field;
      }
      
      public function removePos() : void
      {
         hasField$0 &= 4294967287;
         pos$field = new int();
      }
      
      public function get hasPos() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set pos(param1:int) : void
      {
         hasField$0 |= 8;
         pos$field = param1;
      }
      
      public function get pos() : int
      {
         return pos$field;
      }
      
      public function removeCount() : void
      {
         hasField$0 &= 4294967279;
         count$field = new int();
      }
      
      public function get hasCount() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set count(param1:int) : void
      {
         hasField$0 |= 16;
         count$field = param1;
      }
      
      public function get count() : int
      {
         return count$field;
      }
      
      public function removeStrengthen() : void
      {
         hasField$0 &= 4294967263;
         strengthen$field = new int();
      }
      
      public function get hasStrengthen() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set strengthen(param1:int) : void
      {
         hasField$0 |= 32;
         strengthen$field = param1;
      }
      
      public function get strengthen() : int
      {
         return strengthen$field;
      }
      
      public function removeQuality() : void
      {
         hasField$0 &= 4294967231;
         quality$field = new int();
      }
      
      public function get hasQuality() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set quality(param1:int) : void
      {
         hasField$0 |= 64;
         quality$field = param1;
      }
      
      public function get quality() : int
      {
         return quality$field;
      }
      
      public function removeIsExist() : void
      {
         hasField$0 &= 4294967167;
         isExist$field = new Boolean();
      }
      
      public function get hasIsExist() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set isExist(param1:Boolean) : void
      {
         hasField$0 |= 128;
         isExist$field = param1;
      }
      
      public function get isExist() : Boolean
      {
         return isExist$field;
      }
      
      public function removeIsLock() : void
      {
         hasField$0 &= 4294967039;
         isLock$field = new Boolean();
      }
      
      public function get hasIsLock() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set isLock(param1:Boolean) : void
      {
         hasField$0 |= 256;
         isLock$field = param1;
      }
      
      public function get isLock() : Boolean
      {
         return isLock$field;
      }
      
      public function removeIsEquip() : void
      {
         hasField$0 &= 4294966783;
         isEquip$field = new Boolean();
      }
      
      public function get hasIsEquip() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set isEquip(param1:Boolean) : void
      {
         hasField$0 |= 512;
         isEquip$field = param1;
      }
      
      public function get isEquip() : Boolean
      {
         return isEquip$field;
      }
      
      public function removeEquipPos() : void
      {
         hasField$0 &= 4294966271;
         equipPos$field = new int();
      }
      
      public function get hasEquipPos() : Boolean
      {
         return (hasField$0 & 0x0400) != 0;
      }
      
      public function set equipPos(param1:int) : void
      {
         hasField$0 |= 1024;
         equipPos$field = param1;
      }
      
      public function get equipPos() : int
      {
         return equipPos$field;
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
         if(hasType)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,type$field);
         }
         if(hasPos)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,pos$field);
         }
         if(hasCount)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,count$field);
         }
         if(hasStrengthen)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,strengthen$field);
         }
         if(hasQuality)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,quality$field);
         }
         if(hasIsExist)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_BOOL(param1,isExist$field);
         }
         if(hasIsLock)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_BOOL(param1,isLock$field);
         }
         if(hasIsEquip)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_BOOL(param1,isEquip$field);
         }
         if(hasEquipPos)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,equipPos$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc14_:* = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc9_:uint = 0;
         var _loc8_:uint = 0;
         var _loc4_:uint = 0;
         var _loc12_:uint = 0;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         var _loc11_:uint = 0;
         var _loc13_:uint = 0;
         var _loc10_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc14_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: TheseusEquipMsg.id cannot be set twice.");
                  }
                  _loc6_++;
                  id = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: TheseusEquipMsg.templateId cannot be set twice.");
                  }
                  _loc7_++;
                  templateId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: TheseusEquipMsg.type cannot be set twice.");
                  }
                  _loc9_++;
                  type = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: TheseusEquipMsg.pos cannot be set twice.");
                  }
                  _loc8_++;
                  pos = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: TheseusEquipMsg.count cannot be set twice.");
                  }
                  _loc4_++;
                  count = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: TheseusEquipMsg.strengthen cannot be set twice.");
                  }
                  _loc12_++;
                  strengthen = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: TheseusEquipMsg.quality cannot be set twice.");
                  }
                  _loc3_++;
                  quality = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: TheseusEquipMsg.isExist cannot be set twice.");
                  }
                  _loc5_++;
                  isExist = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 8:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: TheseusEquipMsg.isLock cannot be set twice.");
                  }
                  _loc11_++;
                  isLock = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 9:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: TheseusEquipMsg.isEquip cannot be set twice.");
                  }
                  _loc13_++;
                  isEquip = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 10:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: TheseusEquipMsg.equipPos cannot be set twice.");
                  }
                  _loc10_++;
                  equipPos = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc14_ & 7);
            }
         }
      }
   }
}

