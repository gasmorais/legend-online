package com.road.yishi.proto.slate
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class SlateMsg extends Message implements IExternalizable
   {
      
      private var id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var templateId$field:int;
      
      private var pos$field:int;
      
      private var grade$field:int;
      
      private var star$field:int;
      
      private var rotate$field:int;
      
      private var equipPos$field:int;
      
      private var isLock$field:Boolean;
      
      private var isExist$field:Boolean;
      
      private var count$field:int;
      
      public function SlateMsg()
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
      
      public function removeGrade() : void
      {
         hasField$0 &= 4294967287;
         grade$field = new int();
      }
      
      public function get hasGrade() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set grade(param1:int) : void
      {
         hasField$0 |= 8;
         grade$field = param1;
      }
      
      public function get grade() : int
      {
         return grade$field;
      }
      
      public function removeStar() : void
      {
         hasField$0 &= 4294967279;
         star$field = new int();
      }
      
      public function get hasStar() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set star(param1:int) : void
      {
         hasField$0 |= 16;
         star$field = param1;
      }
      
      public function get star() : int
      {
         return star$field;
      }
      
      public function removeRotate() : void
      {
         hasField$0 &= 4294967263;
         rotate$field = new int();
      }
      
      public function get hasRotate() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set rotate(param1:int) : void
      {
         hasField$0 |= 32;
         rotate$field = param1;
      }
      
      public function get rotate() : int
      {
         return rotate$field;
      }
      
      public function removeEquipPos() : void
      {
         hasField$0 &= 4294967231;
         equipPos$field = new int();
      }
      
      public function get hasEquipPos() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set equipPos(param1:int) : void
      {
         hasField$0 |= 64;
         equipPos$field = param1;
      }
      
      public function get equipPos() : int
      {
         return equipPos$field;
      }
      
      public function removeIsLock() : void
      {
         hasField$0 &= 4294967167;
         isLock$field = new Boolean();
      }
      
      public function get hasIsLock() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set isLock(param1:Boolean) : void
      {
         hasField$0 |= 128;
         isLock$field = param1;
      }
      
      public function get isLock() : Boolean
      {
         return isLock$field;
      }
      
      public function removeIsExist() : void
      {
         hasField$0 &= 4294967039;
         isExist$field = new Boolean();
      }
      
      public function get hasIsExist() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set isExist(param1:Boolean) : void
      {
         hasField$0 |= 256;
         isExist$field = param1;
      }
      
      public function get isExist() : Boolean
      {
         return isExist$field;
      }
      
      public function removeCount() : void
      {
         hasField$0 &= 4294966783;
         count$field = new int();
      }
      
      public function get hasCount() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set count(param1:int) : void
      {
         hasField$0 |= 512;
         count$field = param1;
      }
      
      public function get count() : int
      {
         return count$field;
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
         if(hasGrade)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,grade$field);
         }
         if(hasStar)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,star$field);
         }
         if(hasRotate)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,rotate$field);
         }
         if(hasEquipPos)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,equipPos$field);
         }
         if(hasIsLock)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_BOOL(param1,isLock$field);
         }
         if(hasIsExist)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_BOOL(param1,isExist$field);
         }
         if(hasCount)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,count$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc13_:* = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc4_:uint = 0;
         var _loc11_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc12_:uint = 0;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc13_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: SlateMsg.id cannot be set twice.");
                  }
                  _loc6_++;
                  id = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: SlateMsg.templateId cannot be set twice.");
                  }
                  _loc7_++;
                  templateId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: SlateMsg.pos cannot be set twice.");
                  }
                  _loc8_++;
                  pos = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: SlateMsg.grade cannot be set twice.");
                  }
                  _loc4_++;
                  grade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: SlateMsg.star cannot be set twice.");
                  }
                  _loc11_++;
                  star = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: SlateMsg.rotate cannot be set twice.");
                  }
                  _loc9_++;
                  rotate = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: SlateMsg.equipPos cannot be set twice.");
                  }
                  _loc10_++;
                  equipPos = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: SlateMsg.isLock cannot be set twice.");
                  }
                  _loc12_++;
                  isLock = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 8:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: SlateMsg.isExist cannot be set twice.");
                  }
                  _loc5_++;
                  isExist = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 9:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: SlateMsg.count cannot be set twice.");
                  }
                  _loc3_++;
                  count = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc13_ & 7);
            }
         }
      }
   }
}

