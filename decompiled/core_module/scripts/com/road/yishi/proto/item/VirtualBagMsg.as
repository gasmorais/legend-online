package com.road.yishi.proto.item
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class VirtualBagMsg extends Message implements IExternalizable
   {
      
      private var bagType$field:int;
      
      private var hasField$0:uint = 0;
      
      [ArrayElementType("com.road.yishi.proto.item.VirtualItemMsg")]
      public var items:Array = [];
      
      public function VirtualBagMsg()
      {
         super();
      }
      
      public function removeBagType() : void
      {
         hasField$0 &= 4294967294;
         bagType$field = new int();
      }
      
      public function get hasBagType() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set bagType(param1:int) : void
      {
         hasField$0 |= 1;
         bagType$field = param1;
      }
      
      public function get bagType() : int
      {
         return bagType$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasBagType)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,bagType$field);
         }
         _loc2_ = 0;
         while(_loc2_ < items.length)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_MESSAGE(param1,items[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc4_:* = 0;
         var _loc5_:VirtualItemMsg = null;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc4_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: VirtualBagMsg.bagType cannot be set twice.");
                  }
                  _loc3_++;
                  bagType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  _loc5_ = new VirtualItemMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc5_);
                  items.push(_loc5_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc4_ & 7);
            }
         }
      }
   }
}

