package com.road.yishi.proto.simple
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class GoldImposeMsg extends Message implements IExternalizable
   {
      
      private var left_impose$field:int;
      
      private var hasField$0:uint = 0;
      
      private var max_impose$field:int;
      
      public function GoldImposeMsg()
      {
         super();
      }
      
      public function removeLeftImpose() : void
      {
         hasField$0 &= 4294967294;
         left_impose$field = new int();
      }
      
      public function get hasLeftImpose() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set leftImpose(param1:int) : void
      {
         hasField$0 |= 1;
         left_impose$field = param1;
      }
      
      public function get leftImpose() : int
      {
         return left_impose$field;
      }
      
      public function removeMaxImpose() : void
      {
         hasField$0 &= 4294967293;
         max_impose$field = new int();
      }
      
      public function get hasMaxImpose() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set maxImpose(param1:int) : void
      {
         hasField$0 |= 2;
         max_impose$field = param1;
      }
      
      public function get maxImpose() : int
      {
         return max_impose$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasLeftImpose)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,left_impose$field);
         }
         if(hasMaxImpose)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,max_impose$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: GoldImposeMsg.leftImpose cannot be set twice.");
                  }
                  _loc3_++;
                  leftImpose = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: GoldImposeMsg.maxImpose cannot be set twice.");
                  }
                  _loc4_++;
                  maxImpose = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

