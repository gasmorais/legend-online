package com.road.yishi.proto.army
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class TalentUpGradeMsg extends Message implements IExternalizable
   {
      
      private var upresult$field:Boolean;
      
      private var hasField$0:uint = 0;
      
      private var payType$field:int;
      
      public function TalentUpGradeMsg()
      {
         super();
      }
      
      public function removeUpresult() : void
      {
         hasField$0 &= 4294967294;
         upresult$field = new Boolean();
      }
      
      public function get hasUpresult() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set upresult(param1:Boolean) : void
      {
         hasField$0 |= 1;
         upresult$field = param1;
      }
      
      public function get upresult() : Boolean
      {
         return upresult$field;
      }
      
      public function removePayType() : void
      {
         hasField$0 &= 4294967293;
         payType$field = new int();
      }
      
      public function get hasPayType() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set payType(param1:int) : void
      {
         hasField$0 |= 2;
         payType$field = param1;
      }
      
      public function get payType() : int
      {
         return payType$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasUpresult)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_BOOL(param1,upresult$field);
         }
         if(hasPayType)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,payType$field);
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
                     throw new IOError("Bad data format: TalentUpGradeMsg.upresult cannot be set twice.");
                  }
                  _loc3_++;
                  upresult = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: TalentUpGradeMsg.payType cannot be set twice.");
                  }
                  _loc4_++;
                  payType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

