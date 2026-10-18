package com.road.yishi.proto.cccactive
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class MonthCardMsg extends Message implements IExternalizable
   {
      
      private var op$field:int;
      
      private var hasField$0:uint = 0;
      
      private var type$field:int;
      
      private var isOpen$field:Boolean;
      
      private var openTime$field:String;
      
      private var stopTime$field:String;
      
      [ArrayElementType("com.road.yishi.proto.cccactive.MonthCardGiftMsg")]
      public var gifts:Array = [];
      
      public function MonthCardMsg()
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
      
      public function removeType() : void
      {
         hasField$0 &= 4294967293;
         type$field = new int();
      }
      
      public function get hasType() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set type(param1:int) : void
      {
         hasField$0 |= 2;
         type$field = param1;
      }
      
      public function get type() : int
      {
         return type$field;
      }
      
      public function removeIsOpen() : void
      {
         hasField$0 &= 4294967291;
         isOpen$field = new Boolean();
      }
      
      public function get hasIsOpen() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set isOpen(param1:Boolean) : void
      {
         hasField$0 |= 4;
         isOpen$field = param1;
      }
      
      public function get isOpen() : Boolean
      {
         return isOpen$field;
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
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasOp)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,op$field);
         }
         if(hasType)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,type$field);
         }
         if(hasIsOpen)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_BOOL(param1,isOpen$field);
         }
         if(hasOpenTime)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,openTime$field);
         }
         if(hasStopTime)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_STRING(param1,stopTime$field);
         }
         _loc2_ = 0;
         while(_loc2_ < gifts.length)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_MESSAGE(param1,gifts[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc8_:MonthCardGiftMsg = null;
         var _loc9_:uint = 0;
         var _loc5_:uint = 0;
         var _loc4_:uint = 0;
         var _loc7_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: MonthCardMsg.op cannot be set twice.");
                  }
                  _loc9_++;
                  op = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: MonthCardMsg.type cannot be set twice.");
                  }
                  _loc5_++;
                  type = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: MonthCardMsg.isOpen cannot be set twice.");
                  }
                  _loc4_++;
                  isOpen = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 3:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: MonthCardMsg.openTime cannot be set twice.");
                  }
                  _loc7_++;
                  openTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: MonthCardMsg.stopTime cannot be set twice.");
                  }
                  _loc3_++;
                  stopTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 5:
                  _loc8_ = new MonthCardGiftMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc8_);
                  gifts.push(_loc8_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

