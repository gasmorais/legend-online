package com.road.yishi.proto.lottery
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class LotteryMsg extends Message implements IExternalizable
   {
      
      private var payedPoint$field:int;
      
      private var hasField$0:uint = 0;
      
      private var totalCount$field:int;
      
      private var leftCount$field:int;
      
      private var dayMaxCount$field:int;
      
      private var onceNeedPoint$field:int;
      
      private var leftMillis$field:Int64;
      
      private var isOpen$field:Boolean;
      
      private var property1$field:String;
      
      private var property2$field:String;
      
      [ArrayElementType("String")]
      public var property3:Array = [];
      
      [ArrayElementType("String")]
      public var property4:Array = [];
      
      private var dayAddCount$field:int;
      
      public function LotteryMsg()
      {
         super();
      }
      
      public function removePayedPoint() : void
      {
         hasField$0 &= 4294967294;
         payedPoint$field = new int();
      }
      
      public function get hasPayedPoint() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set payedPoint(param1:int) : void
      {
         hasField$0 |= 1;
         payedPoint$field = param1;
      }
      
      public function get payedPoint() : int
      {
         return payedPoint$field;
      }
      
      public function removeTotalCount() : void
      {
         hasField$0 &= 4294967293;
         totalCount$field = new int();
      }
      
      public function get hasTotalCount() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set totalCount(param1:int) : void
      {
         hasField$0 |= 2;
         totalCount$field = param1;
      }
      
      public function get totalCount() : int
      {
         return totalCount$field;
      }
      
      public function removeLeftCount() : void
      {
         hasField$0 &= 4294967291;
         leftCount$field = new int();
      }
      
      public function get hasLeftCount() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set leftCount(param1:int) : void
      {
         hasField$0 |= 4;
         leftCount$field = param1;
      }
      
      public function get leftCount() : int
      {
         return leftCount$field;
      }
      
      public function removeDayMaxCount() : void
      {
         hasField$0 &= 4294967287;
         dayMaxCount$field = new int();
      }
      
      public function get hasDayMaxCount() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set dayMaxCount(param1:int) : void
      {
         hasField$0 |= 8;
         dayMaxCount$field = param1;
      }
      
      public function get dayMaxCount() : int
      {
         return dayMaxCount$field;
      }
      
      public function removeOnceNeedPoint() : void
      {
         hasField$0 &= 4294967279;
         onceNeedPoint$field = new int();
      }
      
      public function get hasOnceNeedPoint() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set onceNeedPoint(param1:int) : void
      {
         hasField$0 |= 16;
         onceNeedPoint$field = param1;
      }
      
      public function get onceNeedPoint() : int
      {
         return onceNeedPoint$field;
      }
      
      public function removeLeftMillis() : void
      {
         leftMillis$field = null;
      }
      
      public function get hasLeftMillis() : Boolean
      {
         return leftMillis$field != null;
      }
      
      public function set leftMillis(param1:Int64) : void
      {
         leftMillis$field = param1;
      }
      
      public function get leftMillis() : Int64
      {
         return leftMillis$field;
      }
      
      public function removeIsOpen() : void
      {
         hasField$0 &= 4294967263;
         isOpen$field = new Boolean();
      }
      
      public function get hasIsOpen() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set isOpen(param1:Boolean) : void
      {
         hasField$0 |= 32;
         isOpen$field = param1;
      }
      
      public function get isOpen() : Boolean
      {
         return isOpen$field;
      }
      
      public function removeProperty1() : void
      {
         property1$field = null;
      }
      
      public function get hasProperty1() : Boolean
      {
         return property1$field != null;
      }
      
      public function set property1(param1:String) : void
      {
         property1$field = param1;
      }
      
      public function get property1() : String
      {
         return property1$field;
      }
      
      public function removeProperty2() : void
      {
         property2$field = null;
      }
      
      public function get hasProperty2() : Boolean
      {
         return property2$field != null;
      }
      
      public function set property2(param1:String) : void
      {
         property2$field = param1;
      }
      
      public function get property2() : String
      {
         return property2$field;
      }
      
      public function removeDayAddCount() : void
      {
         hasField$0 &= 4294967231;
         dayAddCount$field = new int();
      }
      
      public function get hasDayAddCount() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set dayAddCount(param1:int) : void
      {
         hasField$0 |= 64;
         dayAddCount$field = param1;
      }
      
      public function get dayAddCount() : int
      {
         return dayAddCount$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc3_:* = 0;
         var _loc2_:* = 0;
         if(hasPayedPoint)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,payedPoint$field);
         }
         if(hasTotalCount)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,totalCount$field);
         }
         if(hasLeftCount)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,leftCount$field);
         }
         if(hasDayMaxCount)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,dayMaxCount$field);
         }
         if(hasOnceNeedPoint)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,onceNeedPoint$field);
         }
         if(hasLeftMillis)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT64(param1,leftMillis$field);
         }
         if(hasIsOpen)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_BOOL(param1,isOpen$field);
         }
         if(hasProperty1)
         {
            WriteUtils.writeTag(param1,2,8);
            WriteUtils.write$TYPE_STRING(param1,property1$field);
         }
         if(hasProperty2)
         {
            WriteUtils.writeTag(param1,2,9);
            WriteUtils.write$TYPE_STRING(param1,property2$field);
         }
         _loc3_ = 0;
         while(_loc3_ < property3.length)
         {
            WriteUtils.writeTag(param1,2,10);
            WriteUtils.write$TYPE_STRING(param1,property3[_loc3_]);
            _loc3_++;
         }
         _loc2_ = 0;
         while(_loc2_ < property4.length)
         {
            WriteUtils.writeTag(param1,2,11);
            WriteUtils.write$TYPE_STRING(param1,property4[_loc2_]);
            _loc2_++;
         }
         if(hasDayAddCount)
         {
            WriteUtils.writeTag(param1,0,13);
            WriteUtils.write$TYPE_INT32(param1,dayAddCount$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc11_:* = 0;
         var _loc12_:uint = 0;
         var _loc3_:uint = 0;
         var _loc10_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc8_:uint = 0;
         var _loc7_:uint = 0;
         var _loc9_:uint = 0;
         var _loc13_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc11_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: LotteryMsg.payedPoint cannot be set twice.");
                  }
                  _loc12_++;
                  payedPoint = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: LotteryMsg.totalCount cannot be set twice.");
                  }
                  _loc3_++;
                  totalCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: LotteryMsg.leftCount cannot be set twice.");
                  }
                  _loc10_++;
                  leftCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: LotteryMsg.dayMaxCount cannot be set twice.");
                  }
                  _loc4_++;
                  dayMaxCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: LotteryMsg.onceNeedPoint cannot be set twice.");
                  }
                  _loc5_++;
                  onceNeedPoint = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: LotteryMsg.leftMillis cannot be set twice.");
                  }
                  _loc8_++;
                  leftMillis = ReadUtils.read$TYPE_INT64(param1);
                  break;
               case 6:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: LotteryMsg.isOpen cannot be set twice.");
                  }
                  _loc7_++;
                  isOpen = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 7:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: LotteryMsg.property1 cannot be set twice.");
                  }
                  _loc9_++;
                  property1 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 8:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: LotteryMsg.property2 cannot be set twice.");
                  }
                  _loc13_++;
                  property2 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 9:
                  property3.push(ReadUtils.read$TYPE_STRING(param1));
                  break;
               case 10:
                  property4.push(ReadUtils.read$TYPE_STRING(param1));
                  break;
               case 12:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: LotteryMsg.dayAddCount cannot be set twice.");
                  }
                  _loc6_++;
                  dayAddCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc11_ & 7);
            }
         }
      }
   }
}

