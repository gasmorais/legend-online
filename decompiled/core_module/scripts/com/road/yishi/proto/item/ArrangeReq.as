package com.road.yishi.proto.item
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ArrangeReq extends Message implements IExternalizable
   {
      
      private var isStackItem$field:Boolean;
      
      private var hasField$0:uint = 0;
      
      private var bagType$field:int;
      
      [ArrayElementType("com.road.yishi.proto.item.ArrangeInfo")]
      public var arrangeInfo:Array = [];
      
      public function ArrangeReq()
      {
         super();
      }
      
      public function removeIsStackItem() : void
      {
         hasField$0 &= 4294967294;
         isStackItem$field = new Boolean();
      }
      
      public function get hasIsStackItem() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set isStackItem(param1:Boolean) : void
      {
         hasField$0 |= 1;
         isStackItem$field = param1;
      }
      
      public function get isStackItem() : Boolean
      {
         return isStackItem$field;
      }
      
      public function removeBagType() : void
      {
         hasField$0 &= 4294967293;
         bagType$field = new int();
      }
      
      public function get hasBagType() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set bagType(param1:int) : void
      {
         hasField$0 |= 2;
         bagType$field = param1;
      }
      
      public function get bagType() : int
      {
         return bagType$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasIsStackItem)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_BOOL(param1,isStackItem$field);
         }
         if(hasBagType)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,bagType$field);
         }
         _loc2_ = 0;
         while(_loc2_ < arrangeInfo.length)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_MESSAGE(param1,arrangeInfo[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc6_:ArrangeInfo = null;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ArrangeReq.isStackItem cannot be set twice.");
                  }
                  _loc4_++;
                  isStackItem = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ArrangeReq.bagType cannot be set twice.");
                  }
                  _loc3_++;
                  bagType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  _loc6_ = new ArrangeInfo();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc6_);
                  arrangeInfo.push(_loc6_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

