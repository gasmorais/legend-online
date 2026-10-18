package com.road.yishi.proto.active
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ReturnOptionMsg extends Message implements IExternalizable
   {
      
      private var optionType$field:int;
      
      private var hasField$0:uint = 0;
      
      private var param1$field:int;
      
      public function ReturnOptionMsg()
      {
         super();
      }
      
      public function removeOptionType() : void
      {
         hasField$0 &= 4294967294;
         optionType$field = new int();
      }
      
      public function get hasOptionType() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set optionType(param1:int) : void
      {
         hasField$0 |= 1;
         optionType$field = param1;
      }
      
      public function get optionType() : int
      {
         return optionType$field;
      }
      
      public function removeParam1() : void
      {
         hasField$0 &= 4294967293;
         param1$field = new int();
      }
      
      public function get hasParam1() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set param1(param1:int) : void
      {
         hasField$0 |= 2;
         param1$field = param1;
      }
      
      public function get param1() : int
      {
         return param1$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasOptionType)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,optionType$field);
         }
         if(hasParam1)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,param1$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc4_:* = 0;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc4_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ReturnOptionMsg.optionType cannot be set twice.");
                  }
                  _loc5_++;
                  optionType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ReturnOptionMsg.param1 cannot be set twice.");
                  }
                  _loc3_++;
                  param1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc4_ & 7);
            }
         }
      }
   }
}

