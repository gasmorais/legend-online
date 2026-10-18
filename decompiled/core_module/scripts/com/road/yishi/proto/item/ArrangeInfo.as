package com.road.yishi.proto.item
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ArrangeInfo extends Message implements IExternalizable
   {
      
      private var oldplace$field:int;
      
      private var hasField$0:uint = 0;
      
      private var newplace$field:int;
      
      public function ArrangeInfo()
      {
         super();
      }
      
      public function removeOldplace() : void
      {
         hasField$0 &= 4294967294;
         oldplace$field = new int();
      }
      
      public function get hasOldplace() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set oldplace(param1:int) : void
      {
         hasField$0 |= 1;
         oldplace$field = param1;
      }
      
      public function get oldplace() : int
      {
         return oldplace$field;
      }
      
      public function removeNewplace() : void
      {
         hasField$0 &= 4294967293;
         newplace$field = new int();
      }
      
      public function get hasNewplace() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set newplace(param1:int) : void
      {
         hasField$0 |= 2;
         newplace$field = param1;
      }
      
      public function get newplace() : int
      {
         return newplace$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasOldplace)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,oldplace$field);
         }
         if(hasNewplace)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,newplace$field);
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
                     throw new IOError("Bad data format: ArrangeInfo.oldplace cannot be set twice.");
                  }
                  _loc3_++;
                  oldplace = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ArrangeInfo.newplace cannot be set twice.");
                  }
                  _loc4_++;
                  newplace = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

