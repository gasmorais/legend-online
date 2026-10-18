package com.road.yishi.proto.gamebox
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class DitchNpcInfoMsg extends Message implements IExternalizable
   {
      
      private var id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var templateId$field:int;
      
      private var types$field:int;
      
      private var bornPoint$field:int;
      
      private var rowIndex$field:int;
      
      private var hp$field:int;
      
      private var isBeaten$field:Boolean;
      
      public function DitchNpcInfoMsg()
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
      
      public function removeTypes() : void
      {
         hasField$0 &= 4294967291;
         types$field = new int();
      }
      
      public function get hasTypes() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set types(param1:int) : void
      {
         hasField$0 |= 4;
         types$field = param1;
      }
      
      public function get types() : int
      {
         return types$field;
      }
      
      public function removeBornPoint() : void
      {
         hasField$0 &= 4294967287;
         bornPoint$field = new int();
      }
      
      public function get hasBornPoint() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set bornPoint(param1:int) : void
      {
         hasField$0 |= 8;
         bornPoint$field = param1;
      }
      
      public function get bornPoint() : int
      {
         return bornPoint$field;
      }
      
      public function removeRowIndex() : void
      {
         hasField$0 &= 4294967279;
         rowIndex$field = new int();
      }
      
      public function get hasRowIndex() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set rowIndex(param1:int) : void
      {
         hasField$0 |= 16;
         rowIndex$field = param1;
      }
      
      public function get rowIndex() : int
      {
         return rowIndex$field;
      }
      
      public function removeHp() : void
      {
         hasField$0 &= 4294967263;
         hp$field = new int();
      }
      
      public function get hasHp() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set hp(param1:int) : void
      {
         hasField$0 |= 32;
         hp$field = param1;
      }
      
      public function get hp() : int
      {
         return hp$field;
      }
      
      public function removeIsBeaten() : void
      {
         hasField$0 &= 4294967231;
         isBeaten$field = new Boolean();
      }
      
      public function get hasIsBeaten() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set isBeaten(param1:Boolean) : void
      {
         hasField$0 |= 64;
         isBeaten$field = param1;
      }
      
      public function get isBeaten() : Boolean
      {
         return isBeaten$field;
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
         if(hasTypes)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,types$field);
         }
         if(hasBornPoint)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,bornPoint$field);
         }
         if(hasRowIndex)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,rowIndex$field);
         }
         if(hasHp)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,hp$field);
         }
         if(hasIsBeaten)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_BOOL(param1,isBeaten$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc9_:* = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc8_:uint = 0;
         var _loc10_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc9_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: DitchNpcInfoMsg.id cannot be set twice.");
                  }
                  _loc6_++;
                  id = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: DitchNpcInfoMsg.templateId cannot be set twice.");
                  }
                  _loc7_++;
                  templateId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: DitchNpcInfoMsg.types cannot be set twice.");
                  }
                  _loc5_++;
                  types = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: DitchNpcInfoMsg.bornPoint cannot be set twice.");
                  }
                  _loc3_++;
                  bornPoint = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: DitchNpcInfoMsg.rowIndex cannot be set twice.");
                  }
                  _loc4_++;
                  rowIndex = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: DitchNpcInfoMsg.hp cannot be set twice.");
                  }
                  _loc8_++;
                  hp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: DitchNpcInfoMsg.isBeaten cannot be set twice.");
                  }
                  _loc10_++;
                  isBeaten = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc9_ & 7);
            }
         }
      }
   }
}

