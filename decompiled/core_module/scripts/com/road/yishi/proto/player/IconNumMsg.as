package com.road.yishi.proto.player
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class IconNumMsg extends Message implements IExternalizable
   {
      
      public var type:int;
      
      private var intValue1$field:int;
      
      private var hasField$0:uint = 0;
      
      public function IconNumMsg()
      {
         super();
      }
      
      public function removeIntValue1() : void
      {
         hasField$0 &= 4294967294;
         intValue1$field = new int();
      }
      
      public function get hasIntValue1() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set intValue1(param1:int) : void
      {
         hasField$0 |= 1;
         intValue1$field = param1;
      }
      
      public function get intValue1() : int
      {
         return intValue1$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         WriteUtils.writeTag(param1,0,1);
         WriteUtils.write$TYPE_INT32(param1,type);
         if(hasIntValue1)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,intValue1$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: IconNumMsg.type cannot be set twice.");
                  }
                  _loc4_++;
                  type = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: IconNumMsg.intValue1 cannot be set twice.");
                  }
                  _loc3_++;
                  intValue1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
         if(_loc4_ != 1)
         {
            throw new IOError("Bad data format: IconNumMsg.type must be set.");
         }
      }
   }
}

