package com.road.yishi.proto.cccactive
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class CustomizedVipBoxMsg extends Message implements IExternalizable
   {
      
      private var type$field:int;
      
      private var hasField$0:uint = 0;
      
      private var price$field:int;
      
      private var maxCount$field:int;
      
      [ArrayElementType("com.road.yishi.proto.cccactive.CustomizedVipItemMsg")]
      public var items:Array = [];
      
      public function CustomizedVipBoxMsg()
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
      
      public function removePrice() : void
      {
         hasField$0 &= 4294967293;
         price$field = new int();
      }
      
      public function get hasPrice() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set price(param1:int) : void
      {
         hasField$0 |= 2;
         price$field = param1;
      }
      
      public function get price() : int
      {
         return price$field;
      }
      
      public function removeMaxCount() : void
      {
         hasField$0 &= 4294967291;
         maxCount$field = new int();
      }
      
      public function get hasMaxCount() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set maxCount(param1:int) : void
      {
         hasField$0 |= 4;
         maxCount$field = param1;
      }
      
      public function get maxCount() : int
      {
         return maxCount$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasType)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,type$field);
         }
         if(hasPrice)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,price$field);
         }
         if(hasMaxCount)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,maxCount$field);
         }
         _loc2_ = 0;
         while(_loc2_ < items.length)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_MESSAGE(param1,items[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc7_:CustomizedVipItemMsg = null;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: CustomizedVipBoxMsg.type cannot be set twice.");
                  }
                  _loc4_++;
                  type = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: CustomizedVipBoxMsg.price cannot be set twice.");
                  }
                  _loc3_++;
                  price = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: CustomizedVipBoxMsg.maxCount cannot be set twice.");
                  }
                  _loc5_++;
                  maxCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  _loc7_ = new CustomizedVipItemMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc7_);
                  items.push(_loc7_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

