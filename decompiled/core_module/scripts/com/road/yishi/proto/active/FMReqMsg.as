package com.road.yishi.proto.active
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class FMReqMsg extends Message implements IExternalizable
   {
      
      public var op:int;
      
      public var type:int;
      
      private var payType$field:int;
      
      private var hasField$0:uint = 0;
      
      public function FMReqMsg()
      {
         super();
      }
      
      public function removePayType() : void
      {
         hasField$0 &= 4294967294;
         payType$field = new int();
      }
      
      public function get hasPayType() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set payType(param1:int) : void
      {
         hasField$0 |= 1;
         payType$field = param1;
      }
      
      public function get payType() : int
      {
         return payType$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         WriteUtils.writeTag(param1,0,1);
         WriteUtils.write$TYPE_ENUM(param1,op);
         WriteUtils.writeTag(param1,0,2);
         WriteUtils.write$TYPE_ENUM(param1,type);
         if(hasPayType)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,payType$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc6_:uint = 0;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: FMReqMsg.op cannot be set twice.");
                  }
                  _loc6_++;
                  op = ReadUtils.read$TYPE_ENUM(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: FMReqMsg.type cannot be set twice.");
                  }
                  _loc4_++;
                  type = ReadUtils.read$TYPE_ENUM(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: FMReqMsg.payType cannot be set twice.");
                  }
                  _loc3_++;
                  payType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
         if(_loc6_ != 1)
         {
            throw new IOError("Bad data format: FMReqMsg.op must be set.");
         }
         if(_loc4_ != 1)
         {
            throw new IOError("Bad data format: FMReqMsg.type must be set.");
         }
      }
   }
}

