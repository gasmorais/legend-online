package com.road.yishi.proto.star
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class StarComposeReqMsg extends Message implements IExternalizable
   {
      
      private var pos$field:int;
      
      private var hasField$0:uint = 0;
      
      private var bag_type$field:int;
      
      public function StarComposeReqMsg()
      {
         super();
      }
      
      public function removePos() : void
      {
         hasField$0 &= 4294967294;
         pos$field = new int();
      }
      
      public function get hasPos() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set pos(param1:int) : void
      {
         hasField$0 |= 1;
         pos$field = param1;
      }
      
      public function get pos() : int
      {
         return pos$field;
      }
      
      public function removeBagType() : void
      {
         hasField$0 &= 4294967293;
         bag_type$field = new int();
      }
      
      public function get hasBagType() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set bagType(param1:int) : void
      {
         hasField$0 |= 2;
         bag_type$field = param1;
      }
      
      public function get bagType() : int
      {
         return bag_type$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasPos)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,pos$field);
         }
         if(hasBagType)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,bag_type$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc4_:* = 0;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc4_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: StarComposeReqMsg.pos cannot be set twice.");
                  }
                  _loc3_++;
                  pos = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: StarComposeReqMsg.bagType cannot be set twice.");
                  }
                  _loc5_++;
                  bagType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc4_ & 7);
            }
         }
      }
   }
}

