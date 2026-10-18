package com.road.yishi.proto.active
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ItemBoxChainMsg extends Message implements IExternalizable
   {
      
      public var id:int;
      
      public var type:int;
      
      public var price:int;
      
      public var items:String;
      
      public var preId:int;
      
      public var nextId:int;
      
      public function ItemBoxChainMsg()
      {
         super();
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         WriteUtils.writeTag(param1,0,1);
         WriteUtils.write$TYPE_INT32(param1,id);
         WriteUtils.writeTag(param1,0,2);
         WriteUtils.write$TYPE_INT32(param1,type);
         WriteUtils.writeTag(param1,0,3);
         WriteUtils.write$TYPE_INT32(param1,price);
         WriteUtils.writeTag(param1,2,4);
         WriteUtils.write$TYPE_STRING(param1,items);
         WriteUtils.writeTag(param1,0,5);
         WriteUtils.write$TYPE_INT32(param1,preId);
         WriteUtils.writeTag(param1,0,6);
         WriteUtils.write$TYPE_INT32(param1,nextId);
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc4_:uint = 0;
         var _loc6_:uint = 0;
         var _loc5_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc7_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ItemBoxChainMsg.id cannot be set twice.");
                  }
                  _loc4_++;
                  id = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ItemBoxChainMsg.type cannot be set twice.");
                  }
                  _loc6_++;
                  type = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ItemBoxChainMsg.price cannot be set twice.");
                  }
                  _loc5_++;
                  price = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: ItemBoxChainMsg.items cannot be set twice.");
                  }
                  _loc8_++;
                  items = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: ItemBoxChainMsg.preId cannot be set twice.");
                  }
                  _loc9_++;
                  preId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ItemBoxChainMsg.nextId cannot be set twice.");
                  }
                  _loc3_++;
                  nextId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
         if(_loc4_ != 1)
         {
            throw new IOError("Bad data format: ItemBoxChainMsg.id must be set.");
         }
         if(_loc6_ != 1)
         {
            throw new IOError("Bad data format: ItemBoxChainMsg.type must be set.");
         }
         if(_loc5_ != 1)
         {
            throw new IOError("Bad data format: ItemBoxChainMsg.price must be set.");
         }
         if(_loc8_ != 1)
         {
            throw new IOError("Bad data format: ItemBoxChainMsg.items must be set.");
         }
         if(_loc9_ != 1)
         {
            throw new IOError("Bad data format: ItemBoxChainMsg.preId must be set.");
         }
         if(_loc3_ != 1)
         {
            throw new IOError("Bad data format: ItemBoxChainMsg.nextId must be set.");
         }
      }
   }
}

