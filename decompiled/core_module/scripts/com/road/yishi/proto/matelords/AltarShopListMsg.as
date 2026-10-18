package com.road.yishi.proto.matelords
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class AltarShopListMsg extends Message implements IExternalizable
   {
      
      private var op$field:int;
      
      private var hasField$0:uint = 0;
      
      private var altarScore$field:int;
      
      private var templateId$field:int;
      
      private var skillTempId$field:int;
      
      [ArrayElementType("com.road.yishi.proto.matelords.AltarShopInfoMsg")]
      public var info:Array = [];
      
      public function AltarShopListMsg()
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
      
      public function removeAltarScore() : void
      {
         hasField$0 &= 4294967293;
         altarScore$field = new int();
      }
      
      public function get hasAltarScore() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set altarScore(param1:int) : void
      {
         hasField$0 |= 2;
         altarScore$field = param1;
      }
      
      public function get altarScore() : int
      {
         return altarScore$field;
      }
      
      public function removeTemplateId() : void
      {
         hasField$0 &= 4294967291;
         templateId$field = new int();
      }
      
      public function get hasTemplateId() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set templateId(param1:int) : void
      {
         hasField$0 |= 4;
         templateId$field = param1;
      }
      
      public function get templateId() : int
      {
         return templateId$field;
      }
      
      public function removeSkillTempId() : void
      {
         hasField$0 &= 4294967287;
         skillTempId$field = new int();
      }
      
      public function get hasSkillTempId() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set skillTempId(param1:int) : void
      {
         hasField$0 |= 8;
         skillTempId$field = param1;
      }
      
      public function get skillTempId() : int
      {
         return skillTempId$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasOp)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,op$field);
         }
         if(hasAltarScore)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,altarScore$field);
         }
         if(hasTemplateId)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,templateId$field);
         }
         if(hasSkillTempId)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,skillTempId$field);
         }
         _loc2_ = 0;
         while(_loc2_ < info.length)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_MESSAGE(param1,info[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc5_:AltarShopInfoMsg = null;
         var _loc8_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc7_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: AltarShopListMsg.op cannot be set twice.");
                  }
                  _loc8_++;
                  op = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: AltarShopListMsg.altarScore cannot be set twice.");
                  }
                  _loc3_++;
                  altarScore = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: AltarShopListMsg.templateId cannot be set twice.");
                  }
                  _loc4_++;
                  templateId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: AltarShopListMsg.skillTempId cannot be set twice.");
                  }
                  _loc6_++;
                  skillTempId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  _loc5_ = new AltarShopInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc5_);
                  info.push(_loc5_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
      }
   }
}

