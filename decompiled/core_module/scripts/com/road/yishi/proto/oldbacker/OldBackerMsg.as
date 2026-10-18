package com.road.yishi.proto.oldbacker
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class OldBackerMsg extends Message implements IExternalizable
   {
      
      private var op$field:int;
      
      private var hasField$0:uint = 0;
      
      private var openTime$field:String;
      
      private var stopTime$field:String;
      
      private var backerType$field:int;
      
      [ArrayElementType("com.road.yishi.proto.oldbacker.OldBackerInfoMsg")]
      public var info:Array = [];
      
      private var templateId$field:int;
      
      private var signKey$field:String;
      
      private var activeState$field:int;
      
      private var openState$field:int;
      
      private var isUseSignKey$field:Boolean;
      
      private var isTakeBuffer$field:Boolean;
      
      private var chargeTotalCount$field:int;
      
      private var isOpenNewSvr$field:Boolean;
      
      private var needGrades$field:int;
      
      public function OldBackerMsg()
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
      
      public function removeOpenTime() : void
      {
         openTime$field = null;
      }
      
      public function get hasOpenTime() : Boolean
      {
         return openTime$field != null;
      }
      
      public function set openTime(param1:String) : void
      {
         openTime$field = param1;
      }
      
      public function get openTime() : String
      {
         return openTime$field;
      }
      
      public function removeStopTime() : void
      {
         stopTime$field = null;
      }
      
      public function get hasStopTime() : Boolean
      {
         return stopTime$field != null;
      }
      
      public function set stopTime(param1:String) : void
      {
         stopTime$field = param1;
      }
      
      public function get stopTime() : String
      {
         return stopTime$field;
      }
      
      public function removeBackerType() : void
      {
         hasField$0 &= 4294967293;
         backerType$field = new int();
      }
      
      public function get hasBackerType() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set backerType(param1:int) : void
      {
         hasField$0 |= 2;
         backerType$field = param1;
      }
      
      public function get backerType() : int
      {
         return backerType$field;
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
      
      public function removeSignKey() : void
      {
         signKey$field = null;
      }
      
      public function get hasSignKey() : Boolean
      {
         return signKey$field != null;
      }
      
      public function set signKey(param1:String) : void
      {
         signKey$field = param1;
      }
      
      public function get signKey() : String
      {
         return signKey$field;
      }
      
      public function removeActiveState() : void
      {
         hasField$0 &= 4294967287;
         activeState$field = new int();
      }
      
      public function get hasActiveState() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set activeState(param1:int) : void
      {
         hasField$0 |= 8;
         activeState$field = param1;
      }
      
      public function get activeState() : int
      {
         return activeState$field;
      }
      
      public function removeOpenState() : void
      {
         hasField$0 &= 4294967279;
         openState$field = new int();
      }
      
      public function get hasOpenState() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set openState(param1:int) : void
      {
         hasField$0 |= 16;
         openState$field = param1;
      }
      
      public function get openState() : int
      {
         return openState$field;
      }
      
      public function removeIsUseSignKey() : void
      {
         hasField$0 &= 4294967263;
         isUseSignKey$field = new Boolean();
      }
      
      public function get hasIsUseSignKey() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set isUseSignKey(param1:Boolean) : void
      {
         hasField$0 |= 32;
         isUseSignKey$field = param1;
      }
      
      public function get isUseSignKey() : Boolean
      {
         return isUseSignKey$field;
      }
      
      public function removeIsTakeBuffer() : void
      {
         hasField$0 &= 4294967231;
         isTakeBuffer$field = new Boolean();
      }
      
      public function get hasIsTakeBuffer() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set isTakeBuffer(param1:Boolean) : void
      {
         hasField$0 |= 64;
         isTakeBuffer$field = param1;
      }
      
      public function get isTakeBuffer() : Boolean
      {
         return isTakeBuffer$field;
      }
      
      public function removeChargeTotalCount() : void
      {
         hasField$0 &= 4294967167;
         chargeTotalCount$field = new int();
      }
      
      public function get hasChargeTotalCount() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set chargeTotalCount(param1:int) : void
      {
         hasField$0 |= 128;
         chargeTotalCount$field = param1;
      }
      
      public function get chargeTotalCount() : int
      {
         return chargeTotalCount$field;
      }
      
      public function removeIsOpenNewSvr() : void
      {
         hasField$0 &= 4294967039;
         isOpenNewSvr$field = new Boolean();
      }
      
      public function get hasIsOpenNewSvr() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set isOpenNewSvr(param1:Boolean) : void
      {
         hasField$0 |= 256;
         isOpenNewSvr$field = param1;
      }
      
      public function get isOpenNewSvr() : Boolean
      {
         return isOpenNewSvr$field;
      }
      
      public function removeNeedGrades() : void
      {
         hasField$0 &= 4294966783;
         needGrades$field = new int();
      }
      
      public function get hasNeedGrades() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set needGrades(param1:int) : void
      {
         hasField$0 |= 512;
         needGrades$field = param1;
      }
      
      public function get needGrades() : int
      {
         return needGrades$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasOp)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,op$field);
         }
         if(hasOpenTime)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,openTime$field);
         }
         if(hasStopTime)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,stopTime$field);
         }
         if(hasBackerType)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,backerType$field);
         }
         _loc2_ = 0;
         while(_loc2_ < info.length)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_MESSAGE(param1,info[_loc2_]);
            _loc2_++;
         }
         if(hasTemplateId)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,templateId$field);
         }
         if(hasSignKey)
         {
            WriteUtils.writeTag(param1,2,7);
            WriteUtils.write$TYPE_STRING(param1,signKey$field);
         }
         if(hasActiveState)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,activeState$field);
         }
         if(hasOpenState)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,openState$field);
         }
         if(hasIsUseSignKey)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_BOOL(param1,isUseSignKey$field);
         }
         if(hasIsTakeBuffer)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_BOOL(param1,isTakeBuffer$field);
         }
         if(hasChargeTotalCount)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_INT32(param1,chargeTotalCount$field);
         }
         if(hasIsOpenNewSvr)
         {
            WriteUtils.writeTag(param1,0,13);
            WriteUtils.write$TYPE_BOOL(param1,isOpenNewSvr$field);
         }
         if(hasNeedGrades)
         {
            WriteUtils.writeTag(param1,0,14);
            WriteUtils.write$TYPE_INT32(param1,needGrades$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc16_:* = 0;
         var _loc14_:OldBackerInfoMsg = null;
         var _loc17_:uint = 0;
         var _loc9_:uint = 0;
         var _loc11_:uint = 0;
         var _loc6_:uint = 0;
         var _loc4_:uint = 0;
         var _loc15_:uint = 0;
         var _loc3_:uint = 0;
         var _loc12_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc13_:uint = 0;
         var _loc5_:uint = 0;
         var _loc10_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc16_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc17_ != 0)
                  {
                     throw new IOError("Bad data format: OldBackerMsg.op cannot be set twice.");
                  }
                  _loc17_++;
                  op = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: OldBackerMsg.openTime cannot be set twice.");
                  }
                  _loc9_++;
                  openTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: OldBackerMsg.stopTime cannot be set twice.");
                  }
                  _loc11_++;
                  stopTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: OldBackerMsg.backerType cannot be set twice.");
                  }
                  _loc6_++;
                  backerType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  _loc14_ = new OldBackerInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc14_);
                  info.push(_loc14_);
                  break;
               case 5:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: OldBackerMsg.templateId cannot be set twice.");
                  }
                  _loc4_++;
                  templateId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: OldBackerMsg.signKey cannot be set twice.");
                  }
                  _loc15_++;
                  signKey = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 7:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: OldBackerMsg.activeState cannot be set twice.");
                  }
                  _loc3_++;
                  activeState = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: OldBackerMsg.openState cannot be set twice.");
                  }
                  _loc12_++;
                  openState = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: OldBackerMsg.isUseSignKey cannot be set twice.");
                  }
                  _loc7_++;
                  isUseSignKey = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 10:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: OldBackerMsg.isTakeBuffer cannot be set twice.");
                  }
                  _loc8_++;
                  isTakeBuffer = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 11:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: OldBackerMsg.chargeTotalCount cannot be set twice.");
                  }
                  _loc13_++;
                  chargeTotalCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 12:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: OldBackerMsg.isOpenNewSvr cannot be set twice.");
                  }
                  _loc5_++;
                  isOpenNewSvr = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 13:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: OldBackerMsg.needGrades cannot be set twice.");
                  }
                  _loc10_++;
                  needGrades = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc16_ & 7);
            }
         }
      }
   }
}

