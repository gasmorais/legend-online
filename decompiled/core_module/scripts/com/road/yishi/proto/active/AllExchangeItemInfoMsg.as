package com.road.yishi.proto.active
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class AllExchangeItemInfoMsg extends Message implements IExternalizable
   {
      
      private var index$field:int;
      
      private var hasField$0:uint = 0;
      
      private var itemId$field:int;
      
      private var itemCount$field:int;
      
      private var randomType$field:int;
      
      public function AllExchangeItemInfoMsg()
      {
         super();
      }
      
      public function removeIndex() : void
      {
         hasField$0 &= 4294967294;
         index$field = new int();
      }
      
      public function get hasIndex() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set index(param1:int) : void
      {
         hasField$0 |= 1;
         index$field = param1;
      }
      
      public function get index() : int
      {
         return index$field;
      }
      
      public function removeItemId() : void
      {
         hasField$0 &= 4294967293;
         itemId$field = new int();
      }
      
      public function get hasItemId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set itemId(param1:int) : void
      {
         hasField$0 |= 2;
         itemId$field = param1;
      }
      
      public function get itemId() : int
      {
         return itemId$field;
      }
      
      public function removeItemCount() : void
      {
         hasField$0 &= 4294967291;
         itemCount$field = new int();
      }
      
      public function get hasItemCount() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set itemCount(param1:int) : void
      {
         hasField$0 |= 4;
         itemCount$field = param1;
      }
      
      public function get itemCount() : int
      {
         return itemCount$field;
      }
      
      public function removeRandomType() : void
      {
         hasField$0 &= 4294967287;
         randomType$field = new int();
      }
      
      public function get hasRandomType() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set randomType(param1:int) : void
      {
         hasField$0 |= 8;
         randomType$field = param1;
      }
      
      public function get randomType() : int
      {
         return randomType$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasIndex)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,index$field);
         }
         if(hasItemId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,itemId$field);
         }
         if(hasItemCount)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,itemCount$field);
         }
         if(hasRandomType)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,randomType$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc4_:uint = 0;
         var _loc7_:uint = 0;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: AllExchangeItemInfoMsg.index cannot be set twice.");
                  }
                  _loc4_++;
                  index = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: AllExchangeItemInfoMsg.itemId cannot be set twice.");
                  }
                  _loc7_++;
                  itemId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: AllExchangeItemInfoMsg.itemCount cannot be set twice.");
                  }
                  _loc3_++;
                  itemCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: AllExchangeItemInfoMsg.randomType cannot be set twice.");
                  }
                  _loc5_++;
                  randomType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

