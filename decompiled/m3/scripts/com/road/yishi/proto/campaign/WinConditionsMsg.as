package com.road.yishi.proto.campaign
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class WinConditionsMsg extends Message implements IExternalizable
   {
      
      private var conditions_byte$field:int;
      
      private var hasField$0:uint = 0;
      
      public function WinConditionsMsg()
      {
         super();
      }
      
      public function removeConditionsByte() : void
      {
         hasField$0 &= 4294967294;
         conditions_byte$field = new int();
      }
      
      public function get hasConditionsByte() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set conditionsByte(param1:int) : void
      {
         hasField$0 |= 1;
         conditions_byte$field = param1;
      }
      
      public function get conditionsByte() : int
      {
         return conditions_byte$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasConditionsByte)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,conditions_byte$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc3_:* = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            _loc3_ = uint(ReadUtils.read$TYPE_UINT32(param1));
            switch((_loc3_ >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: WinConditionsMsg.conditionsByte cannot be set twice.");
                  }
                  _loc4_++;
                  conditionsByte = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc3_ & 7);
            }
         }
      }
   }
}

