package com.road.yishi.proto.cccactive
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class MonthCardGiftMsg extends Message implements IExternalizable
   {
      
      private var type$field:int;
      
      private var hasField$0:uint = 0;
      
      private var giftName$field:String;
      
      private var giftPic$field:String;
      
      private var needPoint$field:int;
      
      private var lastDay$field:int;
      
      [ArrayElementType("com.road.yishi.proto.cccactive.GiftItemInfoMsg")]
      public var items:Array = [];
      
      private var leftDay$field:int;
      
      private var collectTime$field:String;
      
      public function MonthCardGiftMsg()
      {
         super();
      }
      
      public function removeType() : void
      {
         hasField$0 &= 4294967294;
         type$field = new int();
      }
      
      public function get hasType() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set type(param1:int) : void
      {
         hasField$0 |= 1;
         type$field = param1;
      }
      
      public function get type() : int
      {
         return type$field;
      }
      
      public function removeGiftName() : void
      {
         giftName$field = null;
      }
      
      public function get hasGiftName() : Boolean
      {
         return giftName$field != null;
      }
      
      public function set giftName(param1:String) : void
      {
         giftName$field = param1;
      }
      
      public function get giftName() : String
      {
         return giftName$field;
      }
      
      public function removeGiftPic() : void
      {
         giftPic$field = null;
      }
      
      public function get hasGiftPic() : Boolean
      {
         return giftPic$field != null;
      }
      
      public function set giftPic(param1:String) : void
      {
         giftPic$field = param1;
      }
      
      public function get giftPic() : String
      {
         return giftPic$field;
      }
      
      public function removeNeedPoint() : void
      {
         hasField$0 &= 4294967293;
         needPoint$field = new int();
      }
      
      public function get hasNeedPoint() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set needPoint(param1:int) : void
      {
         hasField$0 |= 2;
         needPoint$field = param1;
      }
      
      public function get needPoint() : int
      {
         return needPoint$field;
      }
      
      public function removeLastDay() : void
      {
         hasField$0 &= 4294967291;
         lastDay$field = new int();
      }
      
      public function get hasLastDay() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set lastDay(param1:int) : void
      {
         hasField$0 |= 4;
         lastDay$field = param1;
      }
      
      public function get lastDay() : int
      {
         return lastDay$field;
      }
      
      public function removeLeftDay() : void
      {
         hasField$0 &= 4294967287;
         leftDay$field = new int();
      }
      
      public function get hasLeftDay() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set leftDay(param1:int) : void
      {
         hasField$0 |= 8;
         leftDay$field = param1;
      }
      
      public function get leftDay() : int
      {
         return leftDay$field;
      }
      
      public function removeCollectTime() : void
      {
         collectTime$field = null;
      }
      
      public function get hasCollectTime() : Boolean
      {
         return collectTime$field != null;
      }
      
      public function set collectTime(param1:String) : void
      {
         collectTime$field = param1;
      }
      
      public function get collectTime() : String
      {
         return collectTime$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasType)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,type$field);
         }
         if(hasGiftName)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,giftName$field);
         }
         if(hasGiftPic)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,giftPic$field);
         }
         if(hasNeedPoint)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,needPoint$field);
         }
         if(hasLastDay)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,lastDay$field);
         }
         _loc2_ = 0;
         while(_loc2_ < items.length)
         {
            WriteUtils.writeTag(param1,2,7);
            WriteUtils.write$TYPE_MESSAGE(param1,items[_loc2_]);
            _loc2_++;
         }
         if(hasLeftDay)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,leftDay$field);
         }
         if(hasCollectTime)
         {
            WriteUtils.writeTag(param1,2,9);
            WriteUtils.write$TYPE_STRING(param1,collectTime$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc8_:* = 0;
         var _loc11_:GiftItemInfoMsg = null;
         var _loc7_:uint = 0;
         var _loc5_:uint = 0;
         var _loc4_:uint = 0;
         var _loc9_:uint = 0;
         var _loc3_:uint = 0;
         var _loc6_:uint = 0;
         var _loc10_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc8_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: MonthCardGiftMsg.type cannot be set twice.");
                  }
                  _loc7_++;
                  type = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: MonthCardGiftMsg.giftName cannot be set twice.");
                  }
                  _loc5_++;
                  giftName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: MonthCardGiftMsg.giftPic cannot be set twice.");
                  }
                  _loc4_++;
                  giftPic = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: MonthCardGiftMsg.needPoint cannot be set twice.");
                  }
                  _loc9_++;
                  needPoint = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: MonthCardGiftMsg.lastDay cannot be set twice.");
                  }
                  _loc3_++;
                  lastDay = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  _loc11_ = new GiftItemInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc11_);
                  items.push(_loc11_);
                  break;
               case 7:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: MonthCardGiftMsg.leftDay cannot be set twice.");
                  }
                  _loc6_++;
                  leftDay = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: MonthCardGiftMsg.collectTime cannot be set twice.");
                  }
                  _loc10_++;
                  collectTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc8_ & 7);
            }
         }
      }
   }
}

