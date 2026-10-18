package com.road.yishi.proto.retrieve
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class RetrieveInfosMsg extends Message implements IExternalizable
   {
      
      private var operate$field:int;
      
      private var hasField$0:uint = 0;
      
      [ArrayElementType("com.road.yishi.proto.retrieve.RetrieveInfo")]
      public var retrieveInfo:Array = [];
      
      public function RetrieveInfosMsg()
      {
         super();
      }
      
      public function removeOperate() : void
      {
         hasField$0 &= 4294967294;
         operate$field = new int();
      }
      
      public function get hasOperate() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set operate(param1:int) : void
      {
         hasField$0 |= 1;
         operate$field = param1;
      }
      
      public function get operate() : int
      {
         return operate$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasOperate)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,operate$field);
         }
         _loc2_ = 0;
         while(_loc2_ < retrieveInfo.length)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_MESSAGE(param1,retrieveInfo[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc3_:RetrieveInfo = null;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: RetrieveInfosMsg.operate cannot be set twice.");
                  }
                  _loc4_++;
                  operate = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  _loc3_ = new RetrieveInfo();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc3_);
                  retrieveInfo.push(_loc3_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

